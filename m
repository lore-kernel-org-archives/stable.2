Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.9.28.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438064;
	b=0hjeDL7zeM/8Wxc129HxPto4yXx22wrUm1mWw0Nlq8MWS5ysyuBZ8ksiP3989yDJPOKt
	 nfMX8rNo+XTxpCcYtLV8EtopN8XbG4wyk9WVASlc+bxFFnXFY3uWkqS5wzvL4jmZE1SZX
	 prkPh5huUnk8y5h6ytr8kP/KxasTgHkJsU9vERSYRHh4DWU1UMcBhb60GzJwXxHC9Easl
	 jjhP6dYaxfMHskYiOcbmnPQFGTkPAT3jjr4vDQ/voxQwYgxWPC+2KMLo0oMw0SOtIHsK3
	 4G5uH69KqjKTuBnYXSbf1hmx5OfUjwOTK3B4t6YGLajqwYl56TagaARzU/S1Nrw7w3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hdRiiaC9FUc5w9s4Hjp+o67/X+STjK/LCCxBSdubh9w=;
	b=CYlZk/1GLmYjJrzNwB/CMhA7F21yie5lNzDKCiLtOy2Iu0jKZKlY3BCodXwzbb5Y3g3b
	 IGMG+LOE0YCM3FLEylCguf5mbikwOODLa73GyDXAdu/F5keCh91cNqKsaxsji3z2SPlEr
	 ItcwKRg5IAtZn4pn3WMIySEoF/b2V6q9d6746GuFskIhL3ao3uBJMQAV4dh5UmLwEYVN4
	 jWv/H/3/QZV04/IOaofpOY4O2Aki5NH7FDP9Lzeuh/bbTrxGQxz+QIgYc3TmW4/Xtm7cF
	 ZJMxTqxV1yKNjQvyKVYOcCgWnunso22VFlikxHGAq+kg1/hE0+08r6Z1s9H+qnu1NeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mit.edu;
	spf=pass smtp.mailfrom=mit.edu;
	dkim=pass header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=AQC6wuyu;
	arc=none smtp.remote-ip=18.9.28.11
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AB606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472AB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.a=rsa-sha256 header.s=outgoing header.b=AQC6wuyu
Received: from trampoline.thunk.org (pool-173-48-111-191.bstnma.fios.verizon.net [173.48.111.191])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6ABMxiR3026980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 17:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1794437992; bh=hdRiiaC9FUc5w9s4Hjp+o67/X+STjK/LCCxBSdubh9w=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=AQC6wuyuiZsDnHVo0s5WyNu5aMizxuhylME7eGRRGKVx1a76+yvVSIIaIeJ/lRwe8
	 6++6UMByb3VaD5EnTAQEfi876S2ZVlaVV4l+BAVw+R4T9N46s4epYSvhTE8kzWDIve
	 AhYtCawBMjU+X22oZRUQiNlDvRSkZx9+EQuDi4iF15nMShYezGfEjAq6sveDfFSvV5
	 yMgbbHdUKnY5FOP9hJaGoQI1sxj38MTO7n2Lifg9ZYbITA5LHvLkPErC70KqRlGe78
	 QB7+LDTESSi/QOQhVrBNZadxHOf5QldjOqguC/Q4QRa+SywEl91WqNan88yHJS/SHN
	 TAI9zIyTIbCLQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C1AFF2E013B; Wed, 11 Nov 2026 17:59:44 -0500 (EST)
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
Subject: [PATCH v5 2/6] agents: add a skill to determine Fixes tags
Date: Wed, 11 Nov 2026 17:59:34 -0500
Message-ID: <20261111225940.1573565-3-tytso@mit.edu>
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

Blame and existing Fixes tags can point to code movement instead of the
change that introduced a bug. Add a skill that sends the agent to the
description of the Fixes: tag in submitting-patches.rst, and adds the
checks agents tend to skip: pinning down the bug before searching,
following the code past moves and refactors, comparing each candidate
with its parent, tagging a later commit that only exposed the bug as
well, handling merges, reverts, backports and bugs older than the Git
history, and taking the commit ID and subject from the commit rather
than typing them.

If the origin cannot be established, the skill returns no tag. Point the
bug-fix procedure in coding-assistants.rst at the skill.

Signed-off-by: Sasha Levin <sashal@kernel.org>
Link: https://patch.msgid.link/20261020161642.3713052-3-sashal@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 Documentation/process/coding-assistants.rst |  8 ++++-
 agents/skills/find-fixes/SKILL.md           | 39 +++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 agents/skills/find-fixes/SKILL.md

diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
index b8f2c74e46fc..ca1cc255606b 100644
--- a/Documentation/process/coding-assistants.rst
+++ b/Documentation/process/coding-assistants.rst
@@ -33,6 +33,11 @@ or send mail. A skill returns its result with the evidence for it, or says what
 is missing. Do not fill a missing result with a guess or a placeholder, and do
 not finalize the work until it is resolved.
 
+The following skills are available:
+
+* agents/skills/find-fixes/SKILL.md determines the Fixes tag of a bug fix, or
+  checks an existing one.
+
 Licensing and Legal Requirements
 ================================
 
@@ -78,7 +83,8 @@ these steps:
    another one. The fix must not add build warnings and must pass the
    checkpatch.pl checks (see submitting-patches.rst).
 6. Commit the working fix with a detailed message describing the problem, the
-   solution and a Fixes tag. Do not add a Signed-off-by tag.
+   solution and a Fixes tag determined with the find-fixes skill.  Do not
+   add a Signed-off-by tag.
 7. Identify the maintainers and lists using scripts/get_maintainer.pl.
    Documentation/process/security-bugs.rst shows how to do that.
 8. Indicate what could not be done. If the fix could not be built or tested, or
diff --git a/agents/skills/find-fixes/SKILL.md b/agents/skills/find-fixes/SKILL.md
new file mode 100644
index 000000000000..12b6ea83876d
--- /dev/null
+++ b/agents/skills/find-fixes/SKILL.md
@@ -0,0 +1,39 @@
+---
+# SPDX-License-Identifier: GPL-2.0-only
+name: find-fixes
+description: >-
+  Determine the bug-introducing commit and return a verified Fixes tag for
+  a Linux kernel fix. Use when preparing or reviewing bug-fix patches,
+  drafting their commit messages, or checking an existing Fixes tag.
+---
+
+# Determine a Fixes tag
+
+Read the description of the Fixes: tag in
+Documentation/process/submitting-patches.rst. It says which commit to name
+and how to format the tag. Follow the rules for skills in
+Documentation/process/coding-assistants.rst.
+
+- First establish exactly which bug the fix addresses: the failure, how it is
+  triggered and the code involved. Trace only that bug. If the search leads
+  to a different bug or subsystem, go back to the fix.
+- Name a commit from the history of the tree the fix applies to. A stable
+  backport of that commit, or a commit that exists only on another branch, is
+  not a valid tag.
+- Treat blame output, an existing Fixes tag and a bisection result as leads,
+  not answers. Follow the code back through moves, renames, file splits and
+  older implementations to the commit that made it wrong.
+- For each candidate, compare the commit with its parent and explain why the
+  code was correct before and wrong after. Keep apart the commit that added
+  the code, the commit that made it wrong, and a later commit that only made
+  the bug reachable, which gets a tag of its own.
+- Check each parent of a merge, whether the bug was reverted and later
+  reintroduced, and whether a backport differs from its upstream commit.
+- If the bug is already present in the first commit of the Git history, name
+  that commit: Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2"). Confirm that the bug
+  exists there instead of using it as a default. A shallow clone boundary is
+  not an introducing commit; report the limit instead.
+
+Take the commit ID and subject from the commit itself instead of typing them.
+Return the tags with that explanation and the candidates you rejected. If the
+origin cannot be established, return no tag and say what is missing.
-- 
2.53.0

