Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F23845A6
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040891; cv=none; b=RTrc/6CeS4oDcxQiOrzy+tELoxYJOR0urIlAPdcdQTdfqamWQDstH7ijhkq1jBAB+HRql5bLSh8C4LRkKGuX+wc71Uw9mJ+XbSeLi9IYMpd5dQ487QX1DDp4augfkGskzjSTEVV3OeZYyitlZ7f3+VOGlwAv3jKgZWG3CpsC4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040891; c=relaxed/simple;
	bh=pGZsZITJItgVWsf9XyJJbczhAEmv8y5Zh6KzPg7DYTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBNKqKRW8yqTEgD9Myh1o0uHHZOyOnPaZS8G1v289xIDM45WV7ceh6g6Tf5eNKHonE4w7d+i1e/KJN8dE9GAnOLEk9DyzgrzKVMW6plfycpZL2Sn68IqQu0zJAuQeENO0y7L0tJHHtGmTouRQOZPb6twzJAHPoh223V/BrbQllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YNZNvKF1; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YNZNvKF1"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49550ec5b41so4346045e9.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787040888; x=1787645688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZxhB/5exl1lgMbq7eah+okLtpNH0eiL1HCb7Eb+Ptw=;
        b=YNZNvKF1WVVL6yc7txT3SXBBgFmqR+6KRY8O1gU2AioQtz6cIPA6B4lzq8oy48gHi8
         t1aWsK5KVrk0RhdUt49vU6pUqW6D2S9foqYjwvqwNCX9fkGAS0k/Xasf5/zg/g1eqcU0
         1u15uZZJPQGs0Bs9SCd9Y4ziiguaq6UFPfO1g5gbt9K8bKRz9ZKHCvBhV8Nlko8wKgwP
         k9ZUcC5N0qwCkizMie10KSkDP/y1gb9XXXKvpnmy406uXuPyCSTP9PsTPdN6Rre4+CKL
         ZqJRxT9xcY0TzHqBzuNPHHfj2jfCkt6r7rorN3ukCzBA9V/8UkjAFv9/tnFWuFfZpGn8
         JeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040888; x=1787645688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZxhB/5exl1lgMbq7eah+okLtpNH0eiL1HCb7Eb+Ptw=;
        b=GHyFc6tifCSnVEZtbwMkO+oirb/d3785ud4ednGtiDbAlMwI70x7rFm8GkuXynMN7m
         2xYfwlyRaSyegiuaMDMZXmawMOgKG58O910DlHIedwXNFWmI+tXIpkZ6uwqcCbL3g8H+
         Sko4s3FyNi7SxJVqxI3A7Pj+uwJNLE6FldRLzjO92/UUUEP3Z2wHPvy1UKCopt/WMiXT
         3wFS8BbphwgxfVMQMxnIMRgosmnH5HnCZR2NL66e2HOrHuc5ufvU2qW3M41TJ+6ucP3h
         noel8qtry/ocnB3CQJ0Hg7YJoqGvNRpSZ0tu0N28vQ9N4ganKYUoNlY9uA1DisluHyi6
         iViQ==
X-Gm-Message-State: AOJu0YwYVg81NhMJ9azW0+8Pr+mq+hubVOLfhmv6E7nZipgGj3IS0WtQ
	PkGV8WFl3QH6g8Eiw1LHm3mHLlxbrU3REkcKNiaWEYMusVAK5gPrT0xIFjjOk9e0syX9nCLhzTb
	JuRatBqa3ZKCl
X-Gm-Gg: AR+sD12s8mQr0W16SHW0PUt5gkh5Vf/nRsVv6SWsuDWc1zFgB9iFv1DqXBPesWEi2Tx
	EFRxQtcIIdjMAZr9rKeo2JryX8Uh6QigGuY8idMViXRRdjZxnlpzdS8r1BcZLQZNDTb8fEy636B
	BSm4l4jaIyVE80NdArHmtItgWRYFRyPGr7oeYkZc/ReGFpcAdkNbiz64GYyelCFUJ6eoWXc8T6W
	PpDgP1NrvWqIQ4etZTtNwOxaaCVvEvUWaAzMGdBtWcJghjJuuA7kILlbkd+Bl5gMDdWhudAwnAF
	l9o/ohdQ2Gy+8hs3kdIxWpfg86Smn4lxQNTvqHGJTAUjDQJsteFFOkkG8/7Bp693oXHpFZULX5C
	pxy/d2eru1eoGgxcxRlprayGRHvq3R7hnA9+80YHrzojmE7lsXBMK+mZ0hdwUaMGgil1CaYZDBV
	tQhh9ZSnlS1C72t7IYqAduuc+qpreziAYoiexrSIC7enY8CWb5foNZxSUlaSp1y8hyLuMyfB368
	kVXBG94F0EKzgQlAg==
X-Received: by 2002:a05:600c:2114:b0:499:5210:c537 with SMTP id 5b1f17b1804b1-4998792e462mr341968075e9.1.1787040887793;
        Tue, 18 Aug 2026 01:14:47 -0700 (PDT)
Received: from localhost (27-240-49-235.adsl.fetnet.net. [27.240.49.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ed50absm11507285ad.72.2026.08.18.01.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:14:46 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 4/4] selftests/bpf: Add tests for stale delta leaking through id reassignment
Date: Tue, 18 Aug 2026 16:14:22 +0800
Message-ID: <20260818081428.57938-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818081428.57938-1-shung-hsi.yu@suse.com>
References: <20260818081428.57938-1-shung-hsi.yu@suse.com>
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
index 1b3b44f5f910..fb44f1770dab 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -88,4 +88,59 @@ l_exit_%=:							\
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
2.55.0

