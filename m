Received: from mail-ed2-f1.google.com (mail-ed2-f1.google.com [74.125.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1A2EEE73
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263672; cv=none; b=QZ/HwtWdSqp6G5MlH54jZYJNhv4bXEFdswzV7hYCB7rpNrkR4R9eIFnegDuOiNJvzRWMgXgCa33XZvLsHAAgjqU/Hb6mLflgWaxMk4DhTtKKuVRh7gL4Nr5e9keoDBdCs+sF8Or6diqqZETX+b03MI4n+clNM2uPRsz0fWo3Q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263672; c=relaxed/simple;
	bh=zVCyASEPvhzKcGqvNlWhO2dvIQwypFq6egsDDvjHUic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYWsYmhqaVMZ0FWjSeUFb/mh6cf+zBjXTAnxsEFH7IuCbjPtT66BW4nB2Z1x225Anwp9xs0SYoGmGyDlTce3xBz2ShHkAqKdsiHTNBx5aotb9P1BCtUQerMyIQNG302wjslRVDodgV5obY1TFKEPXNLgh7ZuyFd05tQ/2zFgGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZAq3oaKL; arc=none smtp.client-ip=74.125.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZAq3oaKL"
Received: by mail-ed2-f1.google.com with SMTP id 4fb4d7f45d1cf-698aa235a9dso4783984a12.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263668; x=1784868468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UWhHskn44JPAeQCWDuvkM5k4hj2uXgmiPbT8xND1D/E=;
        b=ZAq3oaKLLq/7YTJv5ASwfGNINnUiHvz+DN8rYQAZ2QvJeh4ldhbQNDNJLqsrQzt5HW
         t1FDaZfqluPzCnd41c4jIGyUOm/85KpsVGOnu3eVsQRdP1HvQ1WK98/PPJJ4U23B20tF
         X1z6YjaEvvm5b6rbmItb21RiWPVWwB1nj1FXlR82xK2DJg5rKeO/bduvI99vPlbiARNP
         hYqaJu0kc9I07AxzfTmKXCCDa/gDC6na37xi4+z4ekX4hmJuPm272mPx+6CMCiUkrehL
         wYSOJswYE6e5q1FGRjrfxt+CKGtVVtNm1qO5GG7p7t6jsDDW1gBpBAqiahqKzNen+Zge
         QIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263668; x=1784868468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UWhHskn44JPAeQCWDuvkM5k4hj2uXgmiPbT8xND1D/E=;
        b=A2pyIJTx45Cr0Y8Z+MMzLIWy4OeR4YlOPU27fEvd7xiYXTVdRwvqOQNsPNrYuo4TGd
         +y8eVDjLThwmRQ0hZb0mkAbyCPT7Vn38wieGNZr8jPYqie7PAv9llPquyRc/kKsN+aMf
         QvTQLRc3dMOMEUq9HlZaJpHDWeUWgnekVIwpa4o9oSV3CyPef9nN8i542XTPAJo3MFqj
         19aTpx6emqYZpIDfpUJDjhIt9InWwnT8GzbtpEWTJ7AdJ7ewAF9tisCxv9WO2JRV6/2U
         iNiVZ/AVALjQgjrtp0QyoZAlyRUhO+3zHpHeDMaZ3Icx3vBd/V7fYJyv1JHq4RuE0zGR
         epKA==
X-Gm-Message-State: AOJu0Ywbwi/YNB4LFsVQhpPZhH7gZ2iLQV9yhKKQsMYNNq2C82ktzrSw
	F321ChvYS5oSOnunvgFxzqHrcRtrR6DP75FDYGEaEHuolBjwizgSdLmDWQ25PO5ySZDfOJDMKrf
	m2kbK2WLB4jeC
X-Gm-Gg: AfdE7cmzWah//hEzLLSIJJNEewdbzzQN2wTndv81Mz3q7M0UHBaN+LL3DxY/asL1wHB
	uRvuW4hrmxQ6LNcltaLkZz7DSrK11hPXORSamucAOTPkyYOUwXJb/f5G5HnVS2JAIE3vUgszeTo
	TQywbGgR4NgYeVCaLDNl2xFvwpL6Ebhh47WZ0QKxP8Q+Bx2KFhC0g9eRt+mV6urs7wWULz5rGiY
	qY0b2KXZoNy2Wnud0eP+oFn0Hgra7qb4MVMftZ9IvL7pLEjJGVQBnpfjsK/4nFCwSTBw69biqVk
	s+t5NbLChAFhIhSple8UZHhymXQ3p2LehqzyDComcImtivqzk7sB0OMKpGMS/vhpyXFnFWITCZ9
	oemLQCYRNt3hKSUIXS2/gcpNs5j9s970eszVJO/49gciUht5vlcseLbgg0VtpP7nHRu+kWi33Qz
	NbaE3N6ZuH2HFElnWidErzriysFrxmfYA=
X-Received: by 2002:a05:6402:44d3:b0:66e:abe5:ab22 with SMTP id 4fb4d7f45d1cf-69e65228f45mr187722a12.5.1784263668584;
        Thu, 16 Jul 2026 21:47:48 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39de7790sm2255296a91.3.2026.07.16.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:47:46 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 2/6] selftests/bpf: Add tests for improved linked register tracking
Date: Fri, 17 Jul 2026 12:47:25 +0800
Message-ID: <20260717044731.121353-3-shung-hsi.yu@suse.com>
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

From: Puranjay Mohan <puranjay@kernel.org>

commit 47fcf4dc0a346dd0b873a679c547d6848bd85a37 upstream.

Add tests for linked register tracking with negative offsets, BPF_SUB,
and alu32. These test for all edge cases like overflows, etc.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260204151741.2678118-3-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 303 +++++++++++++++++-
 1 file changed, 301 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 5f41bbb730a7..2ef346c827c2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/bpf.h>
+#include <limits.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
@@ -18,9 +19,9 @@ __naked void scalars(void)
 	r4 = r1;				\
 	w2 += 0x7FFFFFFF;			\
 	w4 += 0;				\
-	if r2 == 0 goto l1;			\
+	if r2 == 0 goto l0_%=;			\
 	exit;					\
-l1:						\
+l0_%=:						\
 	r4 >>= 63;				\
 	r3 = 1;					\
 	r3 -= r4;				\
@@ -64,4 +65,302 @@ l0_%=:								\
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__naked void scalars_neg(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += -4;					\
+	if r1 s< 0 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Same test but using BPF_SUB instead of BPF_ADD with negative immediate */
+SEC("socket")
+__success
+__naked void scalars_neg_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= 4;					\
+	if r1 s< 0 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* alu32 with negative offset */
+SEC("socket")
+__success
+__naked void scalars_neg_alu32_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += -4;					\
+	if w1 s< 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* alu32 with negative offset using SUB */
+SEC("socket")
+__success
+__naked void scalars_neg_alu32_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 -= 4;					\
+	if w1 s< 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Positive offset: r1 = r0 + 4, then if r1 >= 6, r0 >= 2, so r0 != 0 */
+SEC("socket")
+__success
+__naked void scalars_pos(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 4;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* SUB with negative immediate: r1 -= -4 is equivalent to r1 += 4 */
+SEC("socket")
+__success
+__naked void scalars_sub_neg_imm(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 -= -4;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Double ADD clears the ID (can't accumulate offsets) */
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_double_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r1 += 2;					\
+	r1 += 2;					\
+	if r1 < 6 goto l0_%=;				\
+	if r0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test that sync_linked_regs() correctly handles large offset differences.
+ * r1.off = S32_MIN, r2.off = 1, delta = S32_MIN - 1 requires 64-bit math.
+ */
+SEC("socket")
+__success
+__naked void scalars_sync_delta_overflow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 += %[s32_min];				\
+	r2 += 1;					\
+	if r2 s< 100 goto l0_%=;			\
+	if r1 s< 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_min]"i"(INT_MIN)
+	: __clobber_all);
+}
+
+/*
+ * Another large delta case: r1.off = S32_MAX, r2.off = -1.
+ * delta = S32_MAX - (-1) = S32_MAX + 1 requires 64-bit math.
+ */
+SEC("socket")
+__success
+__naked void scalars_sync_delta_overflow_large_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r1 = r0;					\
+	r2 = r0;					\
+	r1 += %[s32_max];				\
+	r2 += -1;					\
+	if r2 s< 0 goto l0_%=;				\
+	if r1 s>= 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  [s32_max]"i"(INT_MAX)
+	: __clobber_all);
+}
+
+/*
+ * Test linked scalar tracking with alu32 and large positive offset (0x7FFFFFFF).
+ * After w1 += 0x7FFFFFFF, w1 wraps to negative for any r0 >= 1.
+ * If w1 is signed-negative, then r0 >= 1, so r0 != 0.
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_big_offset(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xff;					\
+	w1 = w0;					\
+	w1 += 0x7FFFFFFF;				\
+	if w1 s>= 0 goto l0_%=;				\
+	if w0 != 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure
+__msg("div by zero")
+__naked void scalars_alu32_basic(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	w1 += 1;					\
+	if r1 > 10 goto 1f;				\
+	r0 >>= 32;					\
+	if r0 == 0 goto 1f;				\
+	r0 /= 0;					\
+1:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Test alu32 linked register tracking with wrapping.
+ * R0 is bounded to [0xffffff00, 0xffffffff] (high 32-bit values)
+ * w1 += 0x100 causes R1 to wrap to [0, 0xff]
+ *
+ * After sync_linked_regs, if bounds are computed correctly:
+ *   R0 should be [0x00000000_ffffff00, 0x00000000_ffffff80]
+ *   R0 >> 32 == 0, so div by zero is unreachable
+ *
+ * If bounds are computed incorrectly (64-bit underflow):
+ *   R0 becomes [0xffffffff_ffffff00, 0xffffffff_ffffff80]
+ *   R0 >> 32 == 0xffffffff != 0, so div by zero is reachable
+ */
+SEC("socket")
+__success
+__naked void scalars_alu32_wrap(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 |= 0xffffff00;				\
+	r1 = r0;					\
+	w1 += 0x100;					\
+	if r1 > 0x80 goto l0_%=;			\
+	r2 = r0;					\
+	r2 >>= 32;					\
+	if r2 == 0 goto l0_%=;				\
+	r0 /= 0;					\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+void alu32_negative_offset(void)
+{
+	volatile char path[5];
+	volatile int offset = bpf_get_prandom_u32();
+	int off = offset;
+
+	if (off >= 5 && off < 10)
+		path[off - 5] = '.';
+
+	/* So compiler doesn't say: error: variable 'path' set but not used */
+	__sink(path[0]);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

