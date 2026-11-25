Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603195;
	b=XOrUBlpGQ2yiaDRcI791NpZFeWIAh37O0CjHS8zg6UZxPoAd6wRk+GcJ4XwJbnQplURM
	 bsd9kjrT1HPFx4oLsGw235u2mZkaiSWUw3c+jUsDtdF3puwMa5kIsANZUWNY/cStSUw5m
	 qiq9rICGeQ8wR0Rpx4V6syZ1Ra/dJUp5NTmhU5q6L2TGTevHXKKKAh9dwMT051CRbFMeW
	 +907nP6+g0H4PPDECadDgIY8oe6Di3SUrQZXme4zTEuw/1bqz1L+Sw6zMz6EdscdgfFZR
	 zMnL3DA9KUCmn9bSf73aXyR2ISJOVm2LLYIQZMwn6QhZWarFt2XObKhNQcFah+1D8ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603195;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7N2ASOXFXgzdmrCT3v93v6xiL+UwqVwXha8ngo+Z1Gs=;
	b=4gAEfxf7gs8YuVQpo92fUo6+dUnsuSdjyqBU4DW/cneuOAruWQooh6wP11AbZpR5IxY5
	 LNbe6TWogGgjmKfrgAp9rUuoURptNfuwZ52gsMi1xFnweF8LGQTZpoWGZ1MkH8smgskUy
	 bbLx2MB6ILwR1Y8uuhSCYHGIB8CS+m2p2UuRwy0dYv1LhCxy8IT7KSrYXO2geJT3ikcF7
	 bEMMuFpHBPbIQ0Zc396lbWt+48brHzhfjjsEussmZ52RoeXmb7sKsed/PIthWas9PSJQG
	 P2BdE75ryIVDAUuHdQLdvlBO9OX8ruTVtzDUAzEtz6QdIYHFktUUh3oT47gTuLIX/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=P2aXvlIp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806CD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=P2aXvlIp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0C51F000C0;
	Wed, 25 Nov 2026 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603195;
	bh=7N2ASOXFXgzdmrCT3v93v6xiL+UwqVwXha8ngo+Z1Gs=;
	h=Subject:To:Cc:From:Date;
	b=P2aXvlIpwjKKPDBQhv8lC/iGPK++HaiOSPZE5BYB4yoWv+BTJ1vgQ8QfZP4cZJV3j
	 yewL3hJADdSFOEOruy4lHaXNYsdVnUr6zojBfobDXM/HODdKkqrsFekZ7TGZxAPhq6
	 ygEU7ETDpnXB88EYZJkSMl+b82DAdWf8+ceDr4DY=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix user-space dereference string array store" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:29:43 +0100
Message-ID: <2026112543-bobsled-cofounder-303b@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2721573e6c6faaba2e31f352f2c02ec5f3ecf5e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-bobsled-cofounder-303b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

