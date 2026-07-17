Received: from mail-ed2-f9.google.com (mail-ed2-f9.google.com [74.125.228.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06E2C21D8
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 04:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784263666; cv=none; b=tW4JcXApV+5N/iO9wgsPUkiJ9fmzi8RNrTYzOv7qhTloQ0yPwlRV+zK9Qi7uTQX5q4+0xLnryXSjIvSHwdUYieZt2xwfckCIaSDlKCvoDlQ3lHM5rQMBhNq1njs9gaAooxSRi7GlmszPhrRarNnSvbFL/3da7/ukcC8g603mTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784263666; c=relaxed/simple;
	bh=jY6kh4XC2NGi9/DE0ccHa6BIGDwbNokirU2hole0S5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCHwKpEtB7qnnqlrmQeNNTgDLfe7bHsp8XjmEhVKJB5RsoOFOM3n0vPBN9FGsWDmSOXwB/ejTWzowbgx4VSveNQfi8hBrVRR+K3yi8iznruChakixhvmN6yx2FuCjm37mduBvRf15hXd7mPY7cXjXEw/KM53N8N/wt1pSbcufwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cyiYm52R; arc=none smtp.client-ip=74.125.228.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cyiYm52R"
Received: by mail-ed2-f9.google.com with SMTP id 4fb4d7f45d1cf-69c290c7676so1646759a12.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784263663; x=1784868463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuhrAU/mn5X6tovhkVA4Hb80vOZwT8wqQL2ZxCrhgho=;
        b=cyiYm52RCFUxKWBCoB1xWBoyXT0g1F3CrdCwobx4/PFr3QsSyrCkzuLsspTDdjSNtq
         3/cKVtLggzJuFE6C22NcZb697GwNEDoK1NyRmPuAPPt1j68XSwEQc1/zz9N+lYP2q4vB
         s9NXodN13ioN1cH8brIpLbzb+bpiCgoRphGZ061Hu4/2RHs72utcnRf6K9+Lo1EIWNYe
         efZO9VBB5wRFVCEd3Npoa0VWomUCabYaYKGwEkGXUuB8K2d4LisejTgp6PGATsAKL4ew
         gOoHP3PPO7LN6F9sTOtrU6i5txIUAgQbzIJuUkA6bESj75IuB4Q3Ma/6ZF/mWOix9RiI
         1BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784263663; x=1784868463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuhrAU/mn5X6tovhkVA4Hb80vOZwT8wqQL2ZxCrhgho=;
        b=U57E0jkaucgmi3xN/1zAZ/4QShNdS433M1j91A7FNpyLiX16jDduafbYdgrrHyZFdL
         PdOBpBLvmMUoXdWgo5loXNaNWZhRc/wNMJ4x0DNg0MZUmbhklJethdaN3ImUC5ciBa2k
         nsHym32sErDfwb0s8Yz1w8SbJJljekHomuO5m60mNoc0Oyz+UwP9Jp7es5XEwEwR9XWQ
         76k37DZt4gXyLXfgAf/0vQ5NxqkyNpR9KvRLo0oY8u4yxdjbP+XwJF9GbI39tf/Iw0s8
         CIVgocIQeGOpx3GPFhy++gbyX55pA//NWxwS/qJlvhqOQVd3oxUas0Wtfsfx9nHMPRse
         RPGA==
X-Gm-Message-State: AOJu0YzAaOJbMWbw2BGs4zIApAIDvX5ArDhreegA7nbG0Axzc5jULn7u
	+mluNqtp5TVi2qm1EeLRluGlKB1+wrs3CN7PemWCxNoICLsCWMl9RkI5kFbljN/i2aST7AZ4RkP
	/eEF2RvERpmNa
X-Gm-Gg: AfdE7clcSTNMoY432VIKTl7dtmwnE9w6X5aIf1ucWYEh2QPzlyRxIrQDV2Cd39kTrd2
	lFAeWkKuwiZalgQX30dMeszymKxS6yjcRdUzDfcZAW3wtzmW3kkcxJHU98A1hGXA/hZuSBGJez3
	jSclXAn6jjK7JbV4GR1sEb+ffjDXLyK797uJlc9O44Br5pnPBrnMl3nVxxF7spZac53PeZ8QZHa
	Be/TDLoyT637fBHdAQanKkAnTpOvbyz1WCjI0yhI5InymcjOFIxOn8tKBkL8nG5lRCBZXl/biEp
	OkcBjX8zmEb0qUp+JRTtR336rsqSh7auj6Z51nsKiMaRRjyd8okaT9TN48gK/ZGvEkA+q7c6Z6s
	lEzKkjrfm6cbXc1rcWfpMatKj6oBVA7d4PfxUfAjcV1yFeMUhPMNpu16bIKB/RL29mqQ8bGr769
	Iskht6P1hovBm88PcXIAX6oXTmTc76Tzs=
X-Received: by 2002:a17:906:9f86:b0:c16:6a42:c7d6 with SMTP id a640c23a62f3a-c16b46caaa0mr28206466b.9.1784263662756;
        Thu, 16 Jul 2026 21:47:42 -0700 (PDT)
Received: from localhost (106-64-25-226.adsl.fetnet.net. [106.64.25.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3f6sm225182b3a.44.2026.07.16.21.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 21:47:41 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.18 1/6] selftests: bpf: Add test for multiple syncs from linked register
Date: Fri, 17 Jul 2026 12:47:24 +0800
Message-ID: <20260717044731.121353-2-shung-hsi.yu@suse.com>
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

commit 086c99fbe45070d02851427eab5ae26fe7d0f3c0 upstream.

Before the last commit, sync_linked_regs() corrupted the register whose
bounds are being updated by copying known_reg's id to it. The ids are
the same in value but known_reg has the BPF_ADD_CONST flag which is
wrongly copied to reg.

This later causes issues when creating new links to this reg.
assign_scalar_id_before_mov() sees this BPF_ADD_CONST and gives a new id
to this register and breaks the old links. This is exposed by the added
selftest.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260115151143.1344724-3-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../bpf/progs/verifier_linked_scalars.c       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 8f755d2464cf..5f41bbb730a7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -31,4 +31,37 @@ l1:						\
 "	::: __clobber_all);
 }
 
+/*
+ * Test that sync_linked_regs() preserves register IDs.
+ *
+ * The sync_linked_regs() function copies bounds from known_reg to linked
+ * registers. When doing so, it must preserve each register's original id
+ * to allow subsequent syncs from the same source to work correctly.
+ *
+ */
+SEC("socket")
+__success
+__naked void sync_linked_regs_preserves_id(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r0 &= 0xff;	/* r0 in [0, 255] */			\
+	r1 = r0;	/* r0, r1 linked with id 1 */		\
+	r1 += 4;	/* r1 has id=1 and off=4 in [4, 259] */ \
+	if r1 < 10 goto l0_%=;					\
+	/* r1 in [10, 259], r0 synced to [6, 255] */		\
+	r2 = r0;	/* r2 has id=1 and in [6, 255] */	\
+	if r1 < 14 goto l0_%=;					\
+	/* r1 in [14, 259], r0 synced to [10, 255] */		\
+	if r0 >= 10 goto l0_%=;					\
+	/* Never executed */					\
+	r0 /= 0;						\
+l0_%=:								\
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

