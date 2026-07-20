Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443127B353
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560572; cv=none; b=aRGaXrWNh+qCiiP1Ny3t2TydUZ3D/D/ozqaOkHI5E63eVu6rV1y9GknlyLPYZOOIMaQJJswaIwcsOM+Uz1I5rVEPJB6CpcXSgn8/pU+p+3G9feJExPaYxkqR7csTGaOlglt4D9+7VZGgS8i2mLCH5MyUobRIhKdsdM19+opMnsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560572; c=relaxed/simple;
	bh=9kppF4iiAwnWa6pnNPvMNQy7Pjv92OvIiDjVbN7lA1c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sieUO8EkJZqWRUKbDfLHC/mJKwO7osWb0W5rTmIPxsOv8LW05fQeI7kZ81QN+OhlI9k9x9QiuAbykBRhBO3144ZA2IIYX/Ibw5/0uF3r6D2blI8XUhGor3XMLlpPbhQ/fj+VQ+GK5b4l6ZTlMDHZ3qceFFJC3zAW0xUVCvzOuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZsRgUyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZsRgUyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60481F000E9;
	Mon, 20 Jul 2026 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560571;
	bh=FSRaHuk33srIrBXybQ+Xc4cFkjCRAcBN/ihGUOE1SYk=;
	h=Subject:To:Cc:From:Date;
	b=DZsRgUydmCT9sWsO1A8MrpvJHp1hR+A5nyF1jjn0KfLYrd4o/R1eugX76um9tpQwi
	 o4DzR8aAC/L0ybPuMMJLUb+xEER9wUr8Phhs0/BSg3yZHp9dnU0eAoSfda3qzZN8au
	 7QDTY239lj74aBaxxg8hYaLdRQfAjBvjW1QFQ5Ug=
Subject: FAILED: patch "[PATCH] bpf: Reject negative const offsets for buffer pointers" failed to apply to 7.1-stable tree
To: sun.jian.kdev@gmail.com,eddyz87@gmail.com,shung-hsi.yu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:16:02 +0200
Message-ID: <2026072002-stony-borax-fbef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x fd4cfa8c8f9a17cdec0539334d28754bc1d8a5d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072002-stony-borax-fbef@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd4cfa8c8f9a17cdec0539334d28754bc1d8a5d9 Mon Sep 17 00:00:00 2001
From: Sun Jian <sun.jian.kdev@gmail.com>
Date: Tue, 14 Jul 2026 02:38:45 -0700
Subject: [PATCH] bpf: Reject negative const offsets for buffer pointers

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

Commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off for
pointers") moved constant pointer offsets from reg->off to reg->var_off.
However, __check_buffer_access() continued to check only the instruction
offset. An access with reg->var_off equal to -8 and an instruction offset
of zero therefore passes verification.

For writable raw tracepoints, the access end is also calculated from the
unsigned reg->var_off.value. An eight-byte access starting at -8 wraps
the calculated end to zero, allowing the program to load and attach
without increasing max_tp_access.

After ensuring that reg->var_off is constant, calculate the effective
access start using signed arithmetic and reject it when it is negative.
Use the validated start to calculate the access end for both
PTR_TO_TP_BUFFER and PTR_TO_BUF.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org # 5.2.0
Link: https://patch.msgid.link/20260714093846.18159-2-sun.jian.kdev@gmail.com
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6515d4d3c003..9f1333676365 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,11 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
-	if (off < 0) {
-		verbose(env,
-			"%s invalid %s buffer access: off=%d, size=%d\n",
-			reg_arg_name(env, argno), buf_info, off, size);
-		return -EACCES;
-	}
+	s64 start;
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5341,15 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	start = (s64)reg->var_off.value + off;
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, (s64)reg->var_off.value);
+		return -EACCES;
+	}
+
+	*access_end = start + size;
 	return 0;
 }
 
@@ -5351,14 +5357,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5370,13 +5376,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }

