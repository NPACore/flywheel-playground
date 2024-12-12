#!/usr/bin/env python3
import flywheel # from 'pip install flywheel-sdk'
import os, sys
fw = flywheel.Client() # auto login with ~/.config/flywheel/user.json created with 'fw login'
playground = fw.projects(filter="label=playground")[0]

def rm_ses(ses_label):
    ses = fw.sessions.find_one(filter=f"parents.project={playground.id},subject.code={ses_label}")
    if ses:
        print(ses)
        fw.delete_session(ses.id)
    else:
        print(f"no ses: {ses_label}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"USAGE: {sys.argv[0]} ses_label\n\tses label like '11967_20231104'")
        sys.exit(1)
    ses_label = sys.argv[1] # eg. '11967_20231104'
    rm_ses(sys.argv[1])

