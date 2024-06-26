# SPDX-License-Identifier: Apache-2.0
# 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if [[ $# -ne 1 ]]; then
    echo "Error, requires branch name argument"
    exit 1
else
    merge_dest=$1
fi

cd $AHA_POC_REPO

yml_mod_count=$(git diff --merge-base ${merge_dest} --name-status | grep -c 'compile.yml$\|compilespecs.yml$\|gen_pb_file_lists.sh$')
if [[ ${yml_mod_count} -gt 0 ]]; then
    # Run the Filelist generator script
    bash $AHA_POC_REPO/tools/scripts/gen_pb_file_lists.sh

    # Check for any file changes
    if [[ $(git status -s --untracked-files=all --ignored=traditional | grep "\.vf" -c) -gt 0 ]]; then
      echo "Regenerating VF file lists produced some file changes:";
      git status -s --untracked-files=all --ignored=traditional | grep "\.vf";
      git diff;
      echo "*****************************************";
      echo "Review above changes locally and resubmit pipeline";
      echo "(Hint: Check $AHA_POC_REPO for the above changes)";
      echo "*****************************************";
      exit 1;
    fi
else
    echo "skipping file_list check since no compile.yml were modified"
fi
