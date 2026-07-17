Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88132C21D8
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263694; cv=none; b=a12VbvvAfp+HPpmE7uMmrdr7eMapuFoI69QITJKcsLmWPrQlJ4wx7K8K8EZAijwkF1YdOaAXpiphrfxPSJwoH/HkzzMKhz6diCZy91Vz8WmdBej5mYjJemAWVjWjpLEuPfoqnPv7o/dnKvDShQ8yAEVw6Q2nvyh14UD6Tl6c3V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263694; c=relaxed/simple;
	bh=+nV2dDrWsgUKgd4WW4vC1cDi15fKvgLtIdpTrbrkMe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOlFzV2nFPly4oZv0TL2NkNOiPQQU/DSOBe2BkcUajrXcFxOeNHQysUI+ZSOAaGOpMoKKoLOjPhsAljStTi2bRP2onY1PzskHldpJfHDL55czI02HLu5YSBDxJlgZogCXmYml73lisdSKHB7GBfjWEZ+yyVRM96bqSpk+QECxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Zp118/z1; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Zp118/z1"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c15ec8d6663so283468866b.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263691; x=1784868491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1L1GjsHLmGk58BggPrtZj3cGawb4i1fhYZ+TPnSPmbs=;
        b=Zp118/z1IVfh8hXZeG9xKtML4TzvEwecVVNG+Xt6C5qNSXrPXCHVFqk6Dcfd6lAr8K
         cYj1++RIsCIH2ChzSoE7u82cLbwL5AZnynesMzL3Kvk2GqMboAo3MHbAnyJR3aErjWyh
         06WoFDPtQTP25p9cvAaSls8xQEir+nxA55xE8mM0hOLXo6NEKzWLRR3rqa4K+xnjL5ex
         kBaI60nSI98Up7rcoo7YmZ7/rx6ZJIitmmP2RhcSBAjSMCdYsQCb4XCdsAbViQ8CotSi
         KssN9NKWMxxSId94Vf4HKiGSujsdEYbCVzzv2g5NPeaOE9i+Ujk1NzjT/eItLlBnxBLx
         bCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263691; x=1784868491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1L1GjsHLmGk58BggPrtZj3cGawb4i1fhYZ+TPnSPmbs=;
        b=HwdjAl/lhgkr3WnvlzVqgfg8dwFjxRzgoObs1qSoRfm09kqBcQg7wrpuc3wx1Zt5Lv
         d0zEXayT9fK6lXzLNiZaAIsFi0USAyMUcJeEi0iIXNFt3ZUcRQbDA9AsWCfdsBJyt2s6
         Wh60kMWe9sGtn/oNNAme+D7UI1OQ8/V1POSvOab8YpiEbAN7pgDNed7ZqyVAlEP0iqrR
         spaQTxtc2Wt0yOVh09evlWqWb7Xay3X06XWWDF1F0bCPIS3H84ErRLO+7DnyI5ic8ESS
         CU0DNOu1/61ZdpjURJ///RkwrQVpPH461Oc541LPmgtZIntsiGinFdh67wwT2BxtM/G4
         CdCg==
X-Gm-Message-State: AOJu0YyMMtkrqxLqiK9xkFPzgwCsekuzoChOM1Hh+G611gX54xFRCGYF
	ksduZfynhiD3Ql6yqoyFr2cf0JfT1aBaUbXdM91z0OKN3oVqtZUuStWEsdV67J2ZxpgPNASO1o0
	UdIP+RJn7lMj0
X-Gm-Gg: AfdE7cnPqIK0M7dBkH9BuAeos1C/se8ZBkL+tRSXQqVkqY3HZO7vH6t5Ll4WE7w/MrO
	WZ4g97yzTrxGranRoRz0a/8SbYlPNXpCfNHrLMeigbCSlHzKMc+6HZrHRq+PmEEQxqsiQVgYVQA
	Mvbs7gdbx3rIr1prxvcZJFfSglq299tSGkX6xXxqvlKBRdOLu6Lm14vmSc+t1xLock75Zs0HYk2
	LMlqBacgoklXwprCcxqCwX5qgQHInmH0f83weQ+50vknGEwFDkeSaVNaaj0nMLW+//5Jft0EbjI
	MB41kGkGIQcf+qZwH4XEtzGPKoQpkStH7aDKf45iaAxD9SO1HJT8RiM4HHxAt8xvSSUwJr6L6Gm
	Hunkc06o7pCv23NIFaheqphUtfXAxmxBCWw0PZV2Bpkszu19lYNzSKmJIclMWJPsxDYIaHqKJSh
	Tgwyf31pBent0QBNOn48SpPrLkGHOHWoY=
X-Received: by 2002:a17:907:961c:b0:c15:d6c8:2816 with SMTP id a640c23a62f3a-c16b47b6440mr36815466b.27.1784263691088;
        Thu, 16 Jul 2026 21:48:11 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf345110besm3623515ad.36.2026.07.16.21.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:48:09 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 6/6] selftests/bpf: Add tests for stale delta leaking through id reassignment
Date: Fri, 17 Jul 2026 12:47:29 +0800
Message-ID: <20260717044731.121353-7-shung-hsi.yu@suse.com>
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

commit cac16ce1e3786bd98cec0c108e3bc06ed3d3c6a9 upstream.

Extend the verifier_linked_scalars BPF selftest with a stale delta test
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
  #612/22  verifier_linked_scalars/scalars_stale_delta_from_cleared_id:OK
  #612/23  verifier_linked_scalars/scalars_stale_delta_from_cleared_id_alu32:OK
  #612     verifier_linked_scalars:OK
  Summary: 1/23 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20260407192421.508817-4-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8741238b2ebd..3b0c300c9cbd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -528,4 +528,59 @@ l_exit_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * Test that stale delta from a cleared BPF_ADD_CONST does not leak
+ * through assign_scalar_id_before_mov() into a new id, causing
+ * sync_linked_regs() to compute an incorrect offset.
+ */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_stale_delta_from_cleared_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;		/* r6 unknown, gets id A */	\
+	r6 += 5;		/* id A|ADD_CONST, delta 5 */	\
+	r6 ^= 0;		/* id cleared; delta stays 5 */	\
+	r8 = r6;		/* new id B, stale delta 5 */	\
+	r8 += 3;		/* id B|ADD_CONST, delta 3 */	\
+	r9 = r6;		/* id B, stale delta 5 */	\
+	if r9 != 10 goto l_exit_%=;				\
+	/* Bug: r8 = 10+(3-5) = 8; Fix: r8 = 10+(3-0) = 13 */	\
+	if r8 == 8 goto l_exit_%=;				\
+	r0 /= 0;						\
+l_exit_%=:							\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same as above but with alu32. */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_stale_delta_from_cleared_id_alu32(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	w6 = w0;						\
+	w6 += 5;						\
+	w6 ^= 0;						\
+	w8 = w6;						\
+	w8 += 3;						\
+	w9 = w6;						\
+	if w9 != 10 goto l_exit_%=;				\
+	if w8 == 8 goto l_exit_%=;				\
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

