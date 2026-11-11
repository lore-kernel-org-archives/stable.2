Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438065;
	b=klo+MwI/DOfalXOM2ytVJznj/ro0LnDqaziozwCMLyYTXGIE85HtV3aGXr2sJ8iyOWy3
	 WdE6mE90gs8OSFWt5ISdxUAzk3SpDeOuX41/E07ThOfwAufevsrScSmUGSxCuAUAGEXFZ
	 wJSXk6fV6ERV6pp/lm/lh9zeGovVtrxT2+Zo5CQP7DdLH3Lr87q431tVsv+wMV/Xmk6mn
	 e2gTfcHZYaV4vavKfZ8MdIY20h79tEhW3WVMSy2ZsWgaMV1nLRICYAC+T7X9YZCPJHmc9
	 itqnl6dC+odEGdjpJVtZ38nQPKWJ4IeE5Dst7uln+snoJl+IQhzBRByKkg/b7evu0hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438065;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=42FlNdMrCN1m98+9czpzijCGMAyrj9OiLxAAq+YA584=;
	b=oPOlN3y4jD80TnDK81X/QTDVaH3fpfQEVp27tfWT/KHPqLOq7nIag7512+BffpQPbkyA
	 Elz5ctp5Bk/kflIVrQCYJqZOE7jjVlaoz8wFihxU31YoZjcJqwIkm3ho0OvGx3GumXbA0
	 T5yjPaeKW7OkZu9JLnj/rYo/CegJmpKNEe1d/2UGR+0UYmxgY0YOW5UcTnQU2AMhCWj0G
	 PXTwjhbiS17yQrBhdTKZTkdCxaAfE9cGGjUeDv8KTBiZRKRGVSluXGmS4FEeH7swDBsKS
	 D1a746fYpDTWylhprLqVvizaj2WWSv9ZXxJXA0T5l7SYxCWOE1LB7mGuacSCLr8ZJTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=fUmLiLfC;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949BA60A2610
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 949BA60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=fUmLiLfC
Received: from trampoline.thunk.org (pool-173-48-111-191.bstnma.fios.verizon.net [173.48.111.191])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6ABMxqPS027065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794437996; bh=42FlNdMrCN1m98+9czpzijCGMAyrj9OiLxAAq+YA584=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=fUmLiLfCyc0yLmDUgME9opuTO5q+hWf1WrpPKcHxit4MCTC7JKqbJs1CR5W5EKP+c
	 +pBET7GUoYjfeAbNB1nFQSx43N2ZTM6i6+p1ZXeTSQwqGsMXz6nrQPVEjC/V6gpvjQ
	 CzCVX/zoS2BdT9dJFtMI8OGUISeFNUhtnz1NtCb/8sKnP3aBzxbHR/rMSD0nAV5CdF
	 kb5VCc85/eFqnFfY2n4J9in+9o6LuE3Gzp2znz9AwpLbs6QS9FGnRs+PhIhpH3qkcN
	 XcGJyt5OoXuGZCiMFjh+MJF45VFKOX9rN7uZUvZ4BA9a5kYG7rXmvxew0FSVZrr7s3
	 4sLyxCkWvL18A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D1F5E2E0147; Wed, 11 Nov 2026 17:59:44 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: workflows@vger.kernel.org, ksummit@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "Michael S. Tsirkin" <mst@redhat.com>, Kees Cook <kees@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dan Carpenter <error27@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>, SJ Park <sj@kernel.org>,
        Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
Subject: [PATCH v5 5/6] agents: add a skill to write commit messages
Date: Wed, 11 Nov 2026 17:59:37 -0500
Message-ID: <20261111225940.1573565-6-tytso@mit.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111225940.1573565-1-tytso@mit.edu>
References: <20261111225940.1573565-1-tytso@mit.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Levin <sashal@kernel.org>

Assistants are asked to commit a fix with a detailed message, and the
find-fixes and stable-tag skills leave their tags for that message, but
nothing says how to write it. Messages written by assistants tend to be
long, and Linus recently asked that pull request text written with an
LLM be less verbose and prefer the imperative voice.

Add a skill that sends the agent to the parts of submitting-patches.rst,
5.Posting.rst and the maintainer documentation that cover commit
messages, cover letters and pull requests, and to the P: profiles of the
changed files. It adds what agents get wrong: stating only what the
change and the supplied sources support, keeping the text short and in
the imperative mood, and adding no tags that were not supplied.

When a semantic patch found the bug, the message includes it, or its path
when it is under scripts/coccinelle/, so that reviewers and the
Coccinelle developers can see it and run it again.

Point the bug-fix procedure in coding-assistants.rst at the skill.

Link: https://lore.kernel.org/r/CAHk-=wgXU50=KgZNZc1JDxsSxg9Z+DjG1_2yU-fNXpZtUe4XDw@mail.gmail.com
Link: https://lore.kernel.org/r/50531bd9-f3ea-2d45-7b3a-a96a446a8fcc@inria.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
Link: https://patch.msgid.link/20261020161642.3713052-6-sashal@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/process/coding-assistants.rst |  9 +++--
 agents/skills/commit-message/SKILL.md       | 45 +++++++++++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100644 agents/skills/commit-message/SKILL.md

diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index c2f9b71650c1..f0bae6bfe9a0 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -41,6 +41,8 @@ The following skills are available:
   returns its stable tag, or checks an existing one.
 * agents/skills/find-siblings/SKILL.md looks for the same bug elsewhere in the
   tree.
+* agents/skills/commit-message/SKILL.md writes, rewrites or reviews a commit
+  message or cover letter, and writes the text of a pull request.
 
 Licensing and Legal Requirements
 ================================
@@ -87,9 +89,10 @@ these steps:
    another one. The fix must not add build warnings and must pass the
    checkpatch.pl checks (see submitting-patches.rst). Then look for the same
    bug elsewhere with the find-siblings skill.
-6. Commit the working fix with a detailed message describing the problem, the
-   solution, a Fixes tag determined with the find-fixes skill, and a stable
-   tag if the stable-tag skill calls for one.  Do not add a Signed-off-by tag.
+6. Commit the working fix with a message written with the commit-message skill,
+   describing the problem, the solution, a Fixes tag determined with the
+   find-fixes skill, and a stable tag if the stable-tag skill calls for one. Do
+   not add a Signed-off-by tag.
 7. Identify the maintainers and lists using scripts/get_maintainer.pl.
    Documentation/process/security-bugs.rst shows how to do that.
 8. Indicate what could not be done. If the fix could not be built or tested, or
diff --git a/agents/skills/commit-message/SKILL.md b/agents/skills/commit-message/SKILL.md
new file mode 100644
index 000000000000..c75f028c56da
--- /dev/null
+++ b/agents/skills/commit-message/SKILL.md
@@ -0,0 +1,45 @@
+---
+# SPDX-License-Identifier: GPL-2.0-only
+name: commit-message
+description: >-
+  Write, rewrite or review the commit message for a Linux kernel change or
+  the cover letter for a patch series, and write the signed tag and pull
+  request text for a subsystem pull. Use when committing or preparing
+  patches, when asked to improve or check a commit message, or when
+  preparing a pull request for an upstream maintainer.
+---
+
+# Write a commit message
+
+Read "Describe your changes", the sections on tags, "The canonical patch
+format" and "Commentary" in Documentation/process/submitting-patches.rst, and
+Documentation/process/5.Posting.rst for cover letters. Follow the maintainer
+profiles, the `P:` entries in MAINTAINERS, for the changed files; they take
+precedence. Follow the rules for skills and for attribution in
+Documentation/process/coding-assistants.rst, and
+Documentation/process/generated-content.rst when a tool found the problem.
+When editing someone else's message, also follow
+Documentation/maintainer/modifying-patches.rst.
+
+- State only what the diff and the sources you were given support, such as a
+  bug report, a crash log, test results, or the list discussion found with
+  `lei q` on lore.kernel.org. If the reason for the change is not known,
+  return no message and say what is missing.
+- Take the Fixes and stable tags from the find-fixes and stable-tag skills.
+  Add other tags only when they were supplied or given on the list. Never add
+  a Signed-off-by.
+- If a semantic patch found the bug, include it in the message between
+  `// <smpl>` and `// </smpl>` lines. For one under scripts/coccinelle/, give
+  its path instead.
+- Use the imperative mood and keep the message as short as its content
+  allows. Leave out markdown, labels such as "Root cause:", intensifiers, a
+  restatement of the subject, and the story of the investigation.
+- Check the result with `scripts/checkpatch.pl --no-signoff`.
+
+For the signed tag and email of a pull request, follow
+Documentation/maintainer/pull-requests.rst,
+Documentation/maintainer/rebasing-and-merging.rst and
+Documentation/maintainer/messy-diffstat.rst. Summarize what the pull contains
+and why from the commit messages in the range, in the same voice, without
+repeating the shortlog. Ask the caller for conflict resolutions and testing
+that the history does not show.
-- 
2.53.0

