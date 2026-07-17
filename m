Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF9314A6B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263688; cv=none; b=C4D9aqRf0vuisKG7ckktJqpwZxWb6gphCVi6iH9CobzYfUtgsGEkmvnddLICBys0sN/t4dho0qDSHet1H5rD37w5dawCHYNjIwcvY7CO7vUpDrkWIgwYMwYz+efhk+pBiALqzSlZ8InlSDMc+gOKr+RBY1tzPbgKZpZR+q3651I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263688; c=relaxed/simple;
	bh=t8oyTuvaF/0pimcRUR2qFP1YFH9GpKb/3qdtOa8Ngfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1SyIMhS2eb1gvezHCQgIM+7Hf9RSLb2nHTfnyLDagLsv8MSOV4eRBpLErnnpH2MTbOmne0v15qbvVdO2/IJQ7qtM2100xWbtHAQ0I2xIidk9D7W4VZWudNUKKAg5x9glNXkPGD2gHDBUwvWrePcmMPlH4vT4KsY2rAOcJ90Efc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DQAv3DvJ; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DQAv3DvJ"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15be76348eso175885766b.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263685; x=1784868485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9DPZW1hM7MByYiVqSKyEum0NYnmYHvi3g+Mja2JvdDs=;
        b=DQAv3DvJBT1nbc8PIEA3VO/3dsJlM2gx4Kp0JdXInCsWhhkrb8G8s4i1tDv79qhp12
         jSifuNBbV6SGs2J6T7LzfkQkBCbwIbRHg84qZLVWIjqIWvZ9vRd8cFidZWWyrnARasmp
         QVQR1FhWCRGcW8Sbrxa3AiaKo8A9USl/qoe2G48x9R8qQjCSrz5cm/hjdw71VR+OYUIA
         lVvfizunx2jpMxiFvEKWj0px7fMNBtST4KrTpJ9IDlfkX+mdVA/yDsPEC9Hwn8Qp7L3y
         jZTdD4rG6tgufiaroN2By3J1POLeSoxIwDEiThapYxl7bh6ipsqxeRL/gEkIx9Ab/PBZ
         Dc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263685; x=1784868485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9DPZW1hM7MByYiVqSKyEum0NYnmYHvi3g+Mja2JvdDs=;
        b=O5RAklYyfm5Tx4L4OY0o3HIkH2cZyu+F94mqvp9YBc2T+ugBynCSbdcPqkSAPYFV37
         tmWWBt8wYmSGp/bXSGY5O4cuxITUdXQYMlnurGJP5i9P9GYSnLMXdrZDO4hD0jw0venN
         JuamKVNVcV0GoqQ4WRas3DWGHj2teTQZQDegPAcD1OvJ5i42jxxNcY01MEnedwOV6jsx
         faikT4clHokEdN49gsKwYh9+Px2nzSFmyGHPnIYeZOUND6A1R7Wdk86BZh5MB1YStGpV
         k+wOEOS9KJmCnzrvBjvU/R13SpPrs0BvcqVqm/aELCNHXS4DRD1amh6B70xDr5dqgYGM
         cY1A==
X-Gm-Message-State: AOJu0YxyfMnmfYrq/DnOqYaN8ZQnvzSrI6YiKuCYEuSvpRUDPlCvT08J
	N6UDWCQqvg/Z6A1eruivmn8/mWmY2R8nJq6GGhP815l1/6idkCiaINasNXC7hT1UAWHVhedDcrf
	+skYQ+KycaUMp
X-Gm-Gg: AfdE7ckHuO7JfcnG9AUT/CdNXpwgxGaVSGjc+MWfz2iy3KmvpG5NZIh1zXkfTbDon1d
	adis64C5tNFat9/Ckd0kfoxfJl0VjW4wNZjRJYvu9pG9GypKUctA2iGLvt6Dq3v+W/akDx/RmP3
	tHRuJHHITCmNjAgWWNZpno90++AgklCm1+BELaDTUDLR0TuzYYZv4d7qleHMzL5W1sUW2VklhVj
	okQ4LcqzvooYCadyi3w4YnBD+essUKPSf+h1FKx1UHDqsikr4NqUHrDu+2IWmbjuxmNqg93s0pf
	9sKQAo/wtcyXZDWfoAbS5YAdcMsG9spi00fmwHAAxNVRJHTziti2W3F8MV7Uu8zaOQct2T2hSmH
	bI8uzz2QtZANxetHhVdNzToKlsMouotIVOj/VeAX66xNtpWPbUqpWM4/FSo1g5060J/fySTbB7j
	d0JK56o9OD3cH+oPncz6QR4at3OhSja6c=
X-Received: by 2002:a17:907:708:b0:c16:6dac:a004 with SMTP id a640c23a62f3a-c16b4738764mr32940266b.24.1784263685292;
        Thu, 16 Jul 2026 21:48:05 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448fba7sm3601325ad.6.2026.07.16.21.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:48:03 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 5/6] selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
Date: Fri, 17 Jul 2026 12:47:28 +0800
Message-ID: <20260717044731.121353-6-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717044731.121353-1-shung-hsi.yu@suse.com>
References: <20260717044731.121353-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Borkmann <daniel@iogearbox.net>

commit ed2eecdc0c6613353bc1565e900d2b23237713da upstream.

Extend the verifier_linked_scalars BPF selftest with a rX += rX test
such that the div-by-zero path is rejected in the fixed case.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
  [...]
  ./test_progs -t verifier_linked_scalars
  #612/1   verifier_linked_scalars/scalars: find linked scalars:OK
  #612/2   verifier_linked_scalars/sync_linked_regs_preserves_id:OK
  #612/3   verifier_linked_scalars/scalars_neg:OK
  #612/4   verifier_linked_scalars/scalars_neg_sub:OK
  #612/5   verifier_linked_scalars/scalars_neg_alu32_add:OK
  #612/6   verifier_linked_scalars/scalars_neg_alu32_sub:OK
  #612/7   verifier_linked_scalars/scalars_pos:OK
  #612/8   verifier_linked_scalars/scalars_sub_neg_imm:OK
  #612/9   verifier_linked_scalars/scalars_double_add:OK
  #612/10  verifier_linked_scalars/scalars_sync_delta_overflow:OK
  #612/11  verifier_linked_scalars/scalars_sync_delta_overflow_large_range:OK
  #612/12  verifier_linked_scalars/scalars_alu32_big_offset:OK
  #612/13  verifier_linked_scalars/scalars_alu32_basic:OK
  #612/14  verifier_linked_scalars/scalars_alu32_wrap:OK
  #612/15  verifier_linked_scalars/scalars_alu32_zext_linked_reg:OK
  #612/16  verifier_linked_scalars/scalars_alu32_alu64_cross_type:OK
  #612/17  verifier_linked_scalars/scalars_alu32_alu64_regsafe_pruning:OK
  #612/18  verifier_linked_scalars/alu32_negative_offset:OK
  #612/19  verifier_linked_scalars/spurious_precision_marks:OK
  #612/20  verifier_linked_scalars/scalars_self_add_clears_id:OK
  #612/21  verifier_linked_scalars/scalars_self_add_alu32_clears_id:OK
  #612     verifier_linked_scalars:OK
  Summary: 1/21 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260407192421.508817-3-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[shung-hsi.yu: missing context from commit 223ffb6a3d05 ("selftests/bpf: add
reproducer for spurious precision propagation through calls").]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 87930b5e7b78..8741238b2ebd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -471,4 +471,61 @@ void alu32_negative_offset(void)
 	__sink(path[0]);
 }
 
+/*
+ * Test that r += r (self-add, src_reg == dst_reg) clears the scalar ID
+ * so that sync_linked_regs() does not propagate an incorrect delta.
+ */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_self_add_clears_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 unknown, id A */		\
+	r7 = r6;		/* r7 linked to r6, id A */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;		/* r8 unknown, id B */		\
+	r9 = r8;		/* r9 linked to r8, id B */	\
+	if r7 != 1 goto l_exit_%=;				\
+	/* r7 == 1; sync propagates: r6 = 1 (known, id A) */	\
+	r6 += r6;		/* r6 = 2; should clear id */	\
+	if r7 == r9 goto l_exit_%=;				\
+	/* Bug: r6 synced to r7(1)+delta(2)=3; Fix: r6 = 2 */	\
+	if r6 == 3 goto l_exit_%=;				\
+	r0 /= 0;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same as above but with alu32 such that w6 += w6 also clears id. */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_self_add_alu32_clears_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;						\
+	w7 = w6;						\
+	call %[bpf_get_prandom_u32];				\
+	w8 = w0;						\
+	w9 = w8;						\
+	if w7 != 1 goto l_exit_%=;				\
+	w6 += w6;						\
+	if w7 == w9 goto l_exit_%=;				\
+	if w6 == 3 goto l_exit_%=;				\
+	r0 /= 0;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

