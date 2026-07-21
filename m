Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE653D413C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600727; cv=none; b=rqRGQqQgnYj2NhYEucraaglhW6HFVQbX0p6UKUDbAeAlICEDaCz4pN5+OzzJWIVji9MQdks391lCgSbheTja9F0lb2BhM4IclpO0Pu3vSEakOpG6nCHFiQ8PmrewLv7TlcCI61dHwCrSKmflfUvgge0qq6+72ucMHEGR29t4vqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600727; c=relaxed/simple;
	bh=6Sc95Amde/yFaJddjucveqBOOLp2DzdLSekapXTjUqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTkdtpABYZNrcogFgoYI4mVIWR7Tyo6OrooAf/Z13rYe+jGLyaf1RohsFWpOLT7jBvzKG1hqiHOu1QMUGY3P9n3+rHIY0LNX1M+Yr2IIxKczsamor8tFQK/jCPOiTgVlXJonlGE0scfso3AYtM/ac64XB7OhHT4SC2quKrNnTSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reh3/Hnh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reh3/Hnh"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso8477738a91.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784600720; x=1785205520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9ysNf5dT7wBhgGF8zHdIKiMXn+U8HCR/Fzhkcq7uVU=;
        b=reh3/Hnh94Wie4ymUs2crS3aBOzM3l5b8WN0ajGeq7ZYLmOYn447eo4dQ7DR6cQOYS
         T1c9/gXKAluTWWY5FRsZQD5wxk1/S9g+nYgzY8j+cp134GqeCo9vSsSrCn8ZADK7k0eM
         wvKwRe94hlVrI+pouYDahpkBj9Ql1ax+mTobaHoNwQ7zf/Way64XvjbUyv/UJRYRHsE1
         ulDiBpXl1+wOOi1lUdHWX6CutXkXTkhi46XzRtph0TsMy+9rmWylaEDw9w7nHnCD3CHq
         +GhVZFLGGoMjszXC1diP2VXBlpXuWhxymFx+50fqxc0Cg9Ru4IX1NSp8e7MvGAxTFg3X
         YbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784600720; x=1785205520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9ysNf5dT7wBhgGF8zHdIKiMXn+U8HCR/Fzhkcq7uVU=;
        b=gZ1+/w0B8PkZnvuHQ1gdKOa+KYSp4j0U9uXRlhZUeBHPezwyNJ7OVAvHeiUaE7nNyb
         BXMF1/eCbVrg8unrgEsdyTv4M4DOmAg+NfU+uTxTIuU03bfOeQrT++gWtFUmYuj6Q2YF
         x7IM2UHKV45khu1Qnu1x4jYd8153EF4s9TIs/0fiE9mBGqsKMuSht4rV78iUDjze5JfQ
         dHYg4F2wOecS4oHlTQH4jZN9ayNv8KYuIWpyhCR2elMe8cgCaenbdPiXB4Zb26nYQgty
         a3ZzjSlOAyujwEJb2AbglZDzM9r2kWjte5SstPzqwUgxQ4Vv5Pe+PcqfR8CycxM8yfVM
         RmRg==
X-Gm-Message-State: AOJu0YzCq6G3+6Ie4pkujUwIcQsjOdsRNUowz4BarJ/pvzO38fZcRrw8
	H3zgdM2sL6Ur2gFzgWREpBU+yYXx29sNPj4aSXNwEK7NAia53atHZCBeaCqlCJZ2qO9u2g==
X-Gm-Gg: AR+sD10iKLmS39s7Heo6e7oKJP6tN4ROM6arUUVjVPjYV98ht7uQnI5bxXUBET/T0L1
	bK/13jfoDzv6RtRi+WJcnWieocjxISdEeocZsUM3qyxuKRGttscuLm5gfZlhP28hnzSIssufCK7
	yaO6MZ90/g0AG5F54cQME3noOrrqW6fH6OwYmulEDHSkzjs7MxS4Ct3XBRoEUP/fF2yIWbQdgMS
	0LnHqp50dAQGWziZBLzSa94ohHX9IHm6Smu8OUMur24PBcvZG5ZOgAhyHLxK2XIQe30PLakaazW
	yOaDclkT2aVekTdyHi72wMzC0W7C9wcD/5sl+HKY3/bX1LzDjwzR2f5LmY5kWerVNoE23jAm2XQ
	OdMIabRpHFQILXiTBeZvxuGDWqbdNn4IWLdsVim5KyouYWaAz8/WS8MwG4B7Wt1Nz5u/ZDuG4oW
	DDOLe1/pJpB19uOw5A6nQ1NpzNvj41pF6p3148ZnuoDgspDxjtSpFoY6bhOPEsQiZQ+7FRXmizY
	ixApEiGns4hwa8YAUE+BpSR2w8=
X-Received: by 2002:a17:90b:2f0c:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-38e4b431074mr17728936a91.8.1784600720529;
        Mon, 20 Jul 2026 19:25:20 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([202.8.105.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e921698d7sm631377a91.10.2026.07.20.19.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 19:25:20 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 7.1.y] bpf: Reject negative const offsets for buffer pointers
Date: Mon, 20 Jul 2026 19:25:12 -0700
Message-ID: <20260721022512.213519-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072002-stony-borax-fbef@gregkh>
References: <2026072002-stony-borax-fbef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit fd4cfa8c8f9a17cdec0539334d28754bc1d8a5d9)
---
 kernel/bpf/verifier.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff9b1f68ceca..fe6ed3559b42 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5558,14 +5558,11 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 int regno, int off, int size)
+				 int regno, int off, int size,
+				 u32 *access_end)
 {
-	if (off < 0) {
-		verbose(env,
-			"R%d invalid %s buffer access: off=%d, size=%d\n",
-			regno, buf_info, off, size);
-		return -EACCES;
-	}
+	s64 start;
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5576,6 +5573,15 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	start = (s64)reg->var_off.value + off;
+	if (start < 0) {
+		verbose(env,
+			"R%d invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			regno, buf_info, off, (s64)reg->var_off.value);
+		return -EACCES;
+	}
+
+	*access_end = start + size;
 	return 0;
 }
 
@@ -5583,14 +5589,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  int regno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, regno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, regno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5602,13 +5608,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, regno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, regno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
-- 
2.43.0

