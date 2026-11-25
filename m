Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603198;
	b=eCXNeZvSpQ6qQOw26gwc1qeoKYKxPNu2x6/J6zOBw4uE4SzdiFZcyQVe3HIGXw10P33q
	 oZwOAZzfmmwznSv1b+OBgk6f2SQtPDSWNNHG7s940oaRg/5MctoRwzL0b+cm24OdJOy+A
	 CWrOavA9Mc1c6yif+qw8CfgUWnWnvRlJg4ZP+ZJUIpFIbrvUSu1V384XUHa1AnU7d0UY2
	 BnA0Vd/+lMLYugSBmpUwLNgO4qGu/rvLUN7hu+WybzbUDpHjx6AzPdBa0K2GXwk6nH78m
	 e0hWuM+2C3EqC1B+ttAW7LubbvcnaJIABCq5ovMXC7C8SPQUDXsVh+WKExxcD1dx1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603198;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=108pt+O7RjkVHCNo/vmTyf4NDgNgJ9pjhwCu4rNzGI4=;
	b=zzSHEXP8iqAUfKCwC7pK4hSYMSoGroKnOdK92okAFhuLHlxkvyt+0JSxZsVCw7B2lnuc
	 DYXL81ndMWWxipqXZj/m8I33LP0mWgsDY9+ukCKhMwCcya0sVXApNoulQXXgwIljYPckY
	 L2MZ0f44LP+9DGfN7R4GD6YkEkOmUpQ4+ISoQkQrA5fw0K44xZjB9Q4N7ynbN9p1PBPNf
	 +enKhGguxjqQak8kNjgPDvtJq3UTChdb8XKTPUnCjk01VwW+QOYSZp5e8ASMoXScCN4za
	 G+wMxlRog9NXUNyIOV+VtbINJ+v5vIWZ9FwjoneKQKU9CfjOVH4/7aiUfPptmsfPeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=raarxY3Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1A606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=raarxY3Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17DA1F000C6;
	Wed, 25 Nov 2026 10:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603198;
	bh=108pt+O7RjkVHCNo/vmTyf4NDgNgJ9pjhwCu4rNzGI4=;
	h=Subject:To:Cc:From:Date;
	b=raarxY3QguNdWW/Dcxx4+2sLu3xSFwZzjzCT8BP13wCTF9Tc05f/dDBpfNWo3UE8m
	 5i7uZiomYaoBsbIUdvQ4aVyxLTV0r6F4YN3Xraly49rX93jbV7cBkNFhPzvxCzUUge
	 OWZjaTk9GgYcNxLtcC8E3aAKrjfbV5Bpftgn1cI0=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix user-space dereference string array store" failed to apply to 5.15-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:29:43 +0100
Message-ID: <2026112543-periscope-fretful-f22f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2721573e6c6faaba2e31f352f2c02ec5f3ecf5e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-periscope-fretful-f22f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2721573e6c6faaba2e31f352f2c02ec5f3ecf5e9 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Nov 2026 17:29:04 +0900
Subject: [PATCH] tracing/probes: Fix user-space dereference string array store
 type

When finalizing a string array argument (e.g. +0u(%reg):string[N]),
finalize_fetch_insn() advances the instruction pointer to a new slot
for the store operation before checking whether the preceding operation
was FETCH_OP_UDEREF. As a result, user-space dereference string arrays
with type "string" emit FETCH_OP_ST_STRING (kernel memory read) instead
of FETCH_OP_ST_USTRING.

Check for FETCH_OP_UDEREF before advancing the instruction pointer.

Link: https://lore.kernel.org/all/179455854396.403392.18073771811100192405.stgit@devnote2/

Fixes: e65f7ae7f4da ("tracing/probe: Support user-space dereference")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5e53caf2cdb7..e0340ae126b8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1956,6 +1956,8 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 
 	/* Store operation */
 	if (parg->type->is_string) {
+		bool is_uderef;
+
 		/* Check bad combination of the type and the last fetch_insn. */
 		if (!strcmp(parg->type->name, "symstr")) {
 			if (code->op != FETCH_OP_REG && code->op != FETCH_OP_STACK &&
@@ -1975,6 +1977,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 			}
 		}
 
+		is_uderef = (code->op == FETCH_OP_UDEREF);
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
 		     code->op == FETCH_OP_IMMSTR) || code->op == FETCH_OP_TP_ARG ||
@@ -1995,8 +1998,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		}
 
 		/* If op == DEREF, replace it with STRING */
-		if (!strcmp(parg->type->name, "ustring") ||
-		    code->op == FETCH_OP_UDEREF)
+		if (!strcmp(parg->type->name, "ustring") || is_uderef)
 			code->op = FETCH_OP_ST_USTRING;
 		else if (!strcmp(parg->type->name, "symstr"))
 			code->op = FETCH_OP_ST_SYMSTR;

