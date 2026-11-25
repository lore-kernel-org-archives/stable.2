Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603204;
	b=ZU1zy8okspk2nCLGC8Qn80/LgcIaNvS+lbmr7iq3b5VFjsKoxTIqIUcqjXHcnbJXLAiZ
	 PI6WSGiCSOSk2xQX2Sg89+fLFzFxSbrdFbbcFSQ1arNPAKFu4JdpXePzJ+6U4d6ED215O
	 p5oIGZzj/vS+W/5yD5F28BbBr2KBPHKG6rYOe12v5h1OPtyImhiKoJA2K9xaCNEBtVVsE
	 BlsCX+7QKrQuUnllHPlRFVbz6gL3nQQcmlTNCIpR0l8fmze5j6WkVSk2OuT4aLx9W++ZP
	 r0/PYxlheayBqIo0DdOZKEQcZG795BZyoZerNrKXaVZLbApd96iPDg7YMzkqWE92Jnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603204;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R3w7nYaswdz1w4Vq8YobG2GJDb6lbQXWew0ar/Bi/fg=;
	b=TIE3gBFW+hJoZY+VCdKlyH3TllLQkBMQ7joYJr+kZi90hkZnlTqWajz1JweNdatN8mv1
	 xBpA+OjSSIzSdjx31QBguFeHF/R7WQT2q20kqwvdDumqIKlS6vtYqdvcn7Fp+MDOH50IP
	 /Hb1Dv3lq1aiou9+1SqI0DgRAHefJMV1WdjbL9IzlDjTp7+zfn+2CzAShfKpexCv2C155
	 nWgqoGasIHZbPpC3tnsvDWh8KvjS2kZbKtXYM78xoG5GCGBSwsc6WfiLmbm87fLTKbC7Y
	 /zpIRQxx2cPVzOVZrhMxAoaLq81jsOxZMt57FcZO9iAiR0YuRze1O4Bpxudogd/haNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ualPbhdS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC34606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ualPbhdS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD921F000CA;
	Wed, 25 Nov 2026 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603204;
	bh=R3w7nYaswdz1w4Vq8YobG2GJDb6lbQXWew0ar/Bi/fg=;
	h=Subject:To:Cc:From:Date;
	b=ualPbhdSTyQuE+fwQYjZ86JscwAB9jtPBTg4mD9n906FnqfKk/Z17rtXYbNOFl7In
	 Lax/i2fLwWyn32cgx13w2RJQ/1jTb2MO5qSEGwAwE1stNNYHDmhT5djXvxgHApNSKE
	 HZxgxcp7zGMHu6dCQx6fod7DMmChG4qgdv7gHBn0=
Subject: FAILED: patch "[PATCH] tracing/probes: Fix user-space dereference string array store" failed to apply to 5.10-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:29:44 +0100
Message-ID: <2026112544-quack-omit-0946@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2721573e6c6faaba2e31f352f2c02ec5f3ecf5e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112544-quack-omit-0946@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

