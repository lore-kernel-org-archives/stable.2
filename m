Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B239EB47
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040886; cv=none; b=kSSxzY1i6IM33kjNlw/DbRGr1p2sX6DHqsD/XZKc6nofIg23ERK7i+PbDdRip+PT6UJfqqDFEAlOcvMKJFiRXgWSIHf9nKFzPVWjJ4GJPFM/kaBqSSPtHT/z//x5jP3u+qAwz5xSsDx4VeIL3+BwKg46VwuxMVSnNkUoW5AGxe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040886; c=relaxed/simple;
	bh=J2upd+yNE3Zr7UUaQMWfOXPeu1SRiznp/2k0hZlMus4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH6l+/42ZpkvoDb8m8YWnnmgTq17MgSeyD8xAYPmJLw413ea/P+54o5cTwI1WaqmhTCzXq5O7+UfxgsbKLRKxK+5nFce23XrxAmCqQBQCZsJgsofwxU0tA6Muf8WYWOw8///CQXjolUBdbYZ5IIHXNhDSgwIh0lTV99YWXGEttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RPGVt7md; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RPGVt7md"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so9648265e9.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787040883; x=1787645683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uqcPnIgXtAq3peqC3TX4olmvnZpLtINTfDaeSemjLFU=;
        b=RPGVt7md1V/4aPq6/GxHFkBxhIZfVB8eYrGba/W3iS4GjgmOo/kuMW3Aq6u4tkoYN5
         tpQqrPCxqLlJuCcknUx5P3qT/0YpJYXSnME6e+s9OYpZwR2sRPU+1MvJp5MV9GItanPH
         TYHfpvW3+2zYckX8ySi74pA3eOurbArlkFl/UugTcG1tGzK2lF5V6bjBOkz+K2PCvX0x
         VlgPAkbIsmyMcCWLXtbzXjX2nkCVDzuL/uj+fTRoit1PiRCDl2Am6xpdZdY+b4fJjiK2
         tjtJ3M1ZgaBubOLYD3cAPwUc35vLugltsP+x5cHAXX4yK4nOb492iHhKy+6X+epSWODF
         vUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787040883; x=1787645683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uqcPnIgXtAq3peqC3TX4olmvnZpLtINTfDaeSemjLFU=;
        b=IzrFpCjfQHdvgWstdD20Pe/+pkRhggSeyFBcCQ2jwViSXaDk75VQSQcBRZIftPNdzE
         OoYlOP7wigJPil9CumJETZknnvhX8MwM8UpFm0ysbiS3/PBYyOOsXgDxXraTR1+nkSG0
         1fJQaSATfGyA+H+V8QS5PNE5eDgtEreRs40OwlP2H49ThfheHzZcfCP7Cgm/BblshQOr
         pR5XshcsVpVvK8L8ndIdiKmZB6IWSdR5lJ2PYJJoLxVKvx8RRFA54RFILUbqD2B8m7aS
         kZDTGLiqHRMcMnQCKjSgzXVFGMRCA4njxsetgKI5Fm2oK3sgMPbsMyHqXB3Fj9eSCMCl
         lLyw==
X-Gm-Message-State: AOJu0YzW/I/WK3Wp8PcLFPpHMlZq+hvpv33dij6Bl/6DlgyuOQ/WnZAP
	ji0IN8EHdpEKya9kgq4FwXTpKBodFQh8GGInqiTVgKkAbEg0r3lRLZTTeNmKzD+gTMxmmBjKuYZ
	RGKWBBiAZRZMQ
X-Gm-Gg: AR+sD113dusS7McJbouad1HEutjqVs4wd9Slq0yraKidy+ndKmRjVV/dlR1iY3m84jg
	xU0hfoZJ26smi1Wm7/fTr9kvJJXnCxHtus6QwHSq90XwVBjZetEDNzyBEUqK4WJbQgMj3bXBX4O
	rFiP3IEmmDPdb+vPmjkYOFyZofHEtMmxspyv4oPOl2F702CBouwvwgRzEh6s3yzvU3jcYaCgLjt
	HXQDisYT6uc/VO2TjKb9KLJh3ljj0LQNwhBojQ4Gq+/xWdBNbRFwA169s3EElG5e0qxR/pb+4SR
	mflNxxGzB8MHyg97+1ClqJN94stjNbForfiL26f2atPm7HIiuhWJOWYafqLojzIY6lgBkKBNe3l
	/qgZUPrp0IbgRIj5kJmKEUYfmqaaOdsBO4Hkep1BmTvMRSq2KpS+4aOkI55L6Cpe5pW21a5HQjC
	9/Hy5DFOjEKgYQtNX4y8VqSVDhTO7EeHIOeDDoDr0p8yiZ3UpFB0WftMbKRhE0icjCZXBP/fkj5
	56Rmj5d0ObwFH1zJw==
X-Received: by 2002:a05:600c:828c:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-49989345963mr509509245e9.10.1787040883050;
        Tue, 18 Aug 2026 01:14:43 -0700 (PDT)
Received: from localhost (27-240-49-235.adsl.fetnet.net. [27.240.49.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b401de34sm1530757b3a.5.2026.08.18.01.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:14:41 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 3/4] selftests/bpf: Add tests for delta tracking when src_reg == dst_reg
Date: Tue, 18 Aug 2026 16:14:21 +0800
Message-ID: <20260818081428.57938-3-shung-hsi.yu@suse.com>
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
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8f755d2464cf..1b3b44f5f910 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -31,4 +31,61 @@ l1:						\
 "	::: __clobber_all);
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
2.55.0

