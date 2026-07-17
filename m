Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D4303C8A
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263678; cv=none; b=Krt+YZDQwA/16U7NhXG2CTgvGWQjFeumvQcfMvDC0+BV3xHwgNIJoG6SrCfexthQVs6F8uB6IDorHbYCB7BrTh9+dcZsbGSEpRya4js2HpKiw1OQe/GOP3LADgbenWgm69gkUCcwwrJEIDfTQ1ZBwERuKKOzsFt/jLruKcC1/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263678; c=relaxed/simple;
	bh=eaeOzPhNbhjmwab+TLvnh2U0euXJCf8ZbJh/xxxiXJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1FNpilPQv1wS1NI+YZWXmrhxXWe+6HUDJVQPuVP72tM/7ztXEGCfyCzZdqf5MIpE+A1glt5I0fY3V0EXkCClKKfTE6plfmWMtcrSnatUrR9p863xCYDCPsC/QY8Kv0Bun3bupao1G9CyhbqO8niHQBl1R2cM0hwBnrPVKUTlKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OXv8GOWO; arc=none smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OXv8GOWO"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-69a75ad755cso1713385a12.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263675; x=1784868475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hON4vTvUSgeP5fp0pSB5yhWw3IzBBWrCzYxGBHI4dEk=;
        b=OXv8GOWOMFVHgB1BS9MYJ4jgmNFpG+Nw9eX0r0IFl7k+LfTGM+5bYfJR7YnqpPE1aI
         rKTjXzZbAxJGq0dMIZMXD/tDwj5yImHjVl3PnDPM1z2mj+x1WVJ2UmCcXlRlFYwh+VOq
         XhSwYefXUUJcz4JIaACp3FNEJBmlLLoX6UGCCu409U5A9dRhUgj9h5sxL0hZJokbYmmp
         9PoQhJkefD/aOqW0Unx3IcTMHgpjmsFeebZTBhBVmNyl/izJCGq/Vtgj8PMJBRxJUNRr
         9AgqUJBgsf2QSsMOAPvGSjVsP+ghbkzNDDcF6LyQrTO5rYivOBPtHUyoxCblugKA344s
         oO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263675; x=1784868475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hON4vTvUSgeP5fp0pSB5yhWw3IzBBWrCzYxGBHI4dEk=;
        b=C4vmQUBUTcQFDonjX2E9U9cjFu2SYH0Y9hMq2CceSfW6OLuH1dNABtyiaRdfZCEPTL
         spQfWY4IHxoAnufmqYbSzr9E+87m6dwU5hlIq/3ahtfw0e9MIxrMn7vslNazUcSX3GXI
         YwW113GyapEQJFPZTSeq4qVgZ1LAvHQytRNQVpRcZkwumzGTTp/0pVl23o3nCl3kI702
         ZHcOLyUX2VCcuXm/nxk6xXQtA8182vPHqtKWhY3IJid0TxATE9tf5tt7NisldJiPdmuI
         AwZkXJCiF4e4WCZf119yTeBCTckrBsr8aY4PfcIUwVmW/q8xl4lRzTHOcMMn/qAUXbkm
         g2qQ==
X-Gm-Message-State: AOJu0YxauPkV6Oqp11y7TilL1Oqau7sNijJSkQSbFF3hkLV/cYsnD4b2
	mQfg7zgZhC88Kv5NNJW7a8C5yJtc+vfmwP/wKIglOrKLGUqkyugNWm2AgZ7l86kpuDSHE4aBtth
	uLIndbIj11SSC
X-Gm-Gg: AfdE7ckVgkINa/MWarQpvUYUg54sleGKYZz1XYjhCXwULrD73yG0bTdNECq7RDiDZE/
	3nZXjqCNCYJS/MbbWXopL7uVHuWK01IpwY7o5UwgwKInIFCvaJIOD16R525A96uxO1pisnvHsuT
	9a3udaj4h7pZoOyEo9p1TVYMhjcB2zQBcr0bPxfjF1ou3SHZz3e4jBptM1/FWFyw1PfvXrGMzxh
	65YQ2xz+wSvIx3TH3yXDe+hcTdkAPALGT98yIvbjC3/wrD83Icb0ebwbrWJ/W4oFoI37sTyfVhe
	rcTN8wAYgvz4ihhN4B/9A2D5g+TArhZsFv0sKYQuMrxSJymrsjUlKQ3Y6p4Lx+Ws3t/wmBcz+DZ
	tJ7b6OlRstuEgaMQ69bL7zAkx9QW9OBseryI/zgBSDaTUpVcujmXvUNFl3uH0LY8LKsizHxzYQc
	QJ4ECz9qf6cxvSAzC3NEwrS7mEO2bq+fEpM+q9YM0mcA==
X-Received: by 2002:a17:907:9812:b0:c15:a1e8:c141 with SMTP id a640c23a62f3a-c16b47807dcmr33281666b.30.1784263674527;
        Thu, 16 Jul 2026 21:47:54 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f78asm3585515ad.2.2026.07.16.21.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:47:52 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 3/6] selftests/bpf: Add a test cases for sync_linked_regs regarding zext propagation
Date: Fri, 17 Jul 2026 12:47:26 +0800
Message-ID: <20260717044731.121353-4-shung-hsi.yu@suse.com>
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

commit 4a04d13576fd69149b91672b5f1dc62eca272fa5 upstream.

Add multiple test cases for linked register tracking with alu32 ops:

  - Add a test that checks sync_linked_regs() regarding reg->id (the linked
    target register) for BPF_ADD_CONST32 rather than known_reg->id (the
    branch register).

  - Add a test case for linked register tracking that exposes the cross-type
    sync_linked_regs() bug. One register uses alu32 (w7 += 1, BPF_ADD_CONST32)
    and another uses alu64 (r8 += 2, BPF_ADD_CONST64), both linked to the
    same base register.

  - Add a test case that exercises regsafe() path pruning when two execution
    paths reach the same program point with linked registers carrying
    different ADD_CONST flags (BPF_ADD_CONST32 from alu32 vs BPF_ADD_CONST64
    from alu64). This particular test passes with and without the fix since
    the pruning will fail due to different ranges, but it would still be
    useful to carry this one as a regression test for the unreachable div
    by zero.

With the fix applied all the tests pass:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t verifier_linked_scalars
  [...]
  ./test_progs -t verifier_linked_scalars
  #602/1   verifier_linked_scalars/scalars: find linked scalars:OK
  #602/2   verifier_linked_scalars/sync_linked_regs_preserves_id:OK
  #602/3   verifier_linked_scalars/scalars_neg:OK
  #602/4   verifier_linked_scalars/scalars_neg_sub:OK
  #602/5   verifier_linked_scalars/scalars_neg_alu32_add:OK
  #602/6   verifier_linked_scalars/scalars_neg_alu32_sub:OK
  #602/7   verifier_linked_scalars/scalars_pos:OK
  #602/8   verifier_linked_scalars/scalars_sub_neg_imm:OK
  #602/9   verifier_linked_scalars/scalars_double_add:OK
  #602/10  verifier_linked_scalars/scalars_sync_delta_overflow:OK
  #602/11  verifier_linked_scalars/scalars_sync_delta_overflow_large_range:OK
  #602/12  verifier_linked_scalars/scalars_alu32_big_offset:OK
  #602/13  verifier_linked_scalars/scalars_alu32_basic:OK
  #602/14  verifier_linked_scalars/scalars_alu32_wrap:OK
  #602/15  verifier_linked_scalars/scalars_alu32_zext_linked_reg:OK
  #602/16  verifier_linked_scalars/scalars_alu32_alu64_cross_type:OK
  #602/17  verifier_linked_scalars/scalars_alu32_alu64_regsafe_pruning:OK
  #602/18  verifier_linked_scalars/alu32_negative_offset:OK
  #602/19  verifier_linked_scalars/spurious_precision_marks:OK
  #602     verifier_linked_scalars:OK
  Summary: 1/19 PASSED, 0 SKIPPED, 0 FAILED

Co-developed-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260319211507.213816-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 2ef346c827c2..87930b5e7b78 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -348,6 +348,114 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * Test that sync_linked_regs() checks reg->id (the linked target register)
+ * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_zext_linked_reg(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
+	r7 = r6;		/* linked: same id as r6 */	\
+	w7 += 1;		/* alu32: r7.id |= BPF_ADD_CONST32 */ \
+	r8 = 0xFFFFffff ll;					\
+	if r6 < r8 goto l0_%=;					\
+	/* r6 in [0xFFFFFFFF, 0xFFFFFFFF] */			\
+	/* sync_linked_regs: known_reg=r6, reg=r7 */		\
+	/* CPU: w7 = (u32)(0xFFFFFFFF + 1) = 0, zext -> r7 = 0 */ \
+	/* With fix: r7 64-bit = [0, 0] (zext applied) */	\
+	/* Without fix: r7 64-bit = [0x100000000] (no zext) */	\
+	r7 >>= 32;						\
+	if r7 == 0 goto l0_%=;					\
+	r0 /= 0;		/* unreachable with fix */	\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that sync_linked_regs() skips propagation when one register used
+ * alu32 (BPF_ADD_CONST32) and the other used alu64 (BPF_ADD_CONST64).
+ * The delta relationship doesn't hold across different ALU widths.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void scalars_alu32_alu64_cross_type(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
+	r7 = r6;		/* linked: same id as r6 */	\
+	w7 += 1;		/* alu32: BPF_ADD_CONST32, delta = 1 */ \
+	r8 = r6;		/* linked: same id as r6 */	\
+	r8 += 2;		/* alu64: BPF_ADD_CONST64, delta = 2 */ \
+	r9 = 0xFFFFffff ll;					\
+	if r7 < r9 goto l0_%=;					\
+	/* r7 = 0xFFFFFFFF */					\
+	/* sync: known_reg=r7 (ADD_CONST32), reg=r8 (ADD_CONST64) */ \
+	/* Without fix: r8 = zext(0xFFFFFFFF + 1) = 0 */	\
+	/* With fix: r8 stays [2, 0x100000001] (r8 >= 2) */	\
+	if r8 > 0 goto l1_%=;					\
+	goto l0_%=;						\
+l1_%=:								\
+	r0 /= 0;		/* div by zero */		\
+l0_%=:								\
+	r0 = 0;						\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that regsafe() prevents pruning when two paths reach the same program
+ * point with linked registers carrying different ADD_CONST flags (one
+ * BPF_ADD_CONST32 from alu32, another BPF_ADD_CONST64 from alu64).
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void scalars_alu32_alu64_regsafe_pruning(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;		/* r6 in [0, 0xFFFFFFFF] */	\
+	r7 = r6;		/* linked: same id as r6 */	\
+	/* Get another random value for the path branch */	\
+	call %[bpf_get_prandom_u32];				\
+	if r0 > 0 goto l_pathb_%=;				\
+	/* Path A: alu32 */					\
+	w7 += 1;		/* BPF_ADD_CONST32, delta = 1 */\
+	goto l_merge_%=;					\
+l_pathb_%=:							\
+	/* Path B: alu64 */					\
+	r7 += 1;		/* BPF_ADD_CONST64, delta = 1 */\
+l_merge_%=:							\
+	/* Merge point: regsafe() compares path B against cached path A. */ \
+	/* Narrow r6 to trigger sync_linked_regs for r7 */	\
+	r9 = 0xFFFFffff ll;					\
+	if r6 < r9 goto l0_%=;					\
+	/* r6 = 0xFFFFFFFF */					\
+	/* sync: r7 = 0xFFFFFFFF + 1 = 0x100000000 */		\
+	/* Path A: zext -> r7 = 0 */				\
+	/* Path B: no zext -> r7 = 0x100000000 */		\
+	r7 >>= 32;						\
+	if r7 == 0 goto l0_%=;					\
+	r0 /= 0;		/* div by zero on path B */	\
+l0_%=:								\
+	r0 = 0;						\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __success
 void alu32_negative_offset(void)
-- 
2.54.0

