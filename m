Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC793CAA2F
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456349; cv=none; b=OpmySk/YRvnC6UyQ2GgdrUGgyt4abNm+sqjTYkgJPHdeukdrNHeBbI12ER1l25p66zwdlpAfyXFESYlocenS0uKcZLMq1s/NO1slISd3TpBc5GM/1p7zLO6N35E5MFnipV/MpnSljAEXdMgOWh0Iqfut4qYWMrfaB99tFdh8CRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456349; c=relaxed/simple;
	bh=ZvtIH5z8HhmDKQHpBQk3y9/WPUU/4AANCv3nO1GLv5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6+lY8IQW0HzEHuT/9RMF/mJ2Wpfi3DQlq7fIFa3fBuZ+A1gHfnkSzz20MjRcVp2gl54jhkj2xeYuIavMvqzcaEDO6C/aOY1Lfgptr1mJXVWkbEkrTCEZzNbUPZCVBKTfPHv94CWponnKJNEgeXc16mkDabAuzX2CnVZM2k+9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2E1CbMB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2E1CbMB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso19786455ad.1
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 09:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781456347; x=1782061147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JGrrNJSHy5vk1Iy7qsEIvvL/AGO1HpGdhPPP5tug98=;
        b=H2E1CbMBEIJW74n7tNRGnXoWTqKdQpmC+Vu8gD19YzK4UJxKYg8PPpSC34VDAxiZwj
         8nyvK1YZelCMOhg/IVySRWvKCHCy34g7QhszroFcdZyrb9ZDOpcD2/TlmUqZULY3QcJe
         maAjY2DQ+W/yf4t1UpbkN0CcCzMtPOr83tOEWPTuDVeuIIiang/P75gbE6nCM42TedfQ
         Zh0RXSrW8lvkEE41ukCUCKFqOLM3Uu+BdfazPCSgblzNsg84i247CuD1UoaP9CsnPjU9
         XsjMy5PiqP2FOipvodr3bdC0MrPXvOvMg2xOdF+fkdLhap6x0RjXPrIi03eY9o9Gg4pi
         Ta4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781456347; x=1782061147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JGrrNJSHy5vk1Iy7qsEIvvL/AGO1HpGdhPPP5tug98=;
        b=Txx3GNAeoPpCaKMNMksLszYDiduP/3lrvHxRBYalo+0i/DLqF8XOlZH8qcP2NrZ+7Q
         FDNRlZ6xfuEO5yvbLLwga0e/ssb1EKHMQy9uBRw0Dx2mNUp2CLk/+RhF5wo0DlLtx2Zx
         aqqcCPP67qD/kZO98Pxhc8WeDZciQ6c8wphq1m29n4gYdcHrkjCKg3NC22Es8/PRiD0U
         eOlTefMqkyv4/rBqCrdb1hJ2cB3lDdpIX3KTvWSqtT0dRCW7Zcz7YHK0VfDaFBH1uiJe
         4WkvZiY3U97eL1+VUvSjeURC+p0k1gzjvSUfVTXTJ6moxl9EYA2xOAUiJsRhcoNA9Fxa
         oc8g==
X-Forwarded-Encrypted: i=1; AFNElJ9S3A7rQo/WQraEzJMV7AmIZuPYDgiz6iGcFnmhd0+tbeGHDJBZtw/YsvzXOCqAaT0D6OWFzmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9k/wQEQisPdB7xBfJYFkdRiCm/JTu+jNLf1Dm7PLaPt3oonl0
	0c7Z3ErHz3LT4ccMSd6mrbRhXYxwB0y8hH5j4WvGkKTBRk1MrvCATv2I
X-Gm-Gg: Acq92OHeWuxSunPnhVrx1hkFWqPx+t8hX38q4V7LcP3XTgVaNp8AbFJVzN13Hh8i+61
	ox1IOz987q81znxjhS/dOIMQhwp36QIJ/O/NJXYQHhp0LOFm99f20qQ5WrUwipkR6fcM0bJwSRt
	rNfTTlWSdTX0KGBYZx5pYlyV2foUb2fhKLyZgGZIgOp+wJ4mSEInlNgGWId0J2HuIz7zQ1uDwuy
	cmEdaJ7HTtPFCCQQ6Fllt8vMHYkAOTHBNDL3/kQD9FXNqgB6BnPmEexoanatdbY1OFjQEGKq+gO
	jEZtOkhSPXy8vpi9nNXyUlPPG4cFDB2iHK/az6ikzthS7nvN408+sg0FSaPGiXOql75Imb4Ko74
	MO7osqHRf5wdUpiQWOuqKRDCeQSKf0aeZYG3aLSANKQh1JDYwvX3ZoTAWBKpjHQ2UPgMNK+7J7f
	L+he8NPtU4CPAYIUZ1JrthX5pgPCBt+l0=
X-Received: by 2002:a17:903:3550:b0:2c2:bd05:dacc with SMTP id d9443c01a7336-2c664205199mr83224425ad.16.1781456346792;
        Sun, 14 Jun 2026 09:59:06 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm74457405ad.36.2026.06.14.09.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:59:06 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v3 3/4] selftests/bpf: Tests for per-insn sync_linked_regs() precision tracking
Date: Mon, 15 Jun 2026 00:58:40 +0800
Message-ID: <7701766e65ee2b13c8951e918ebde4cc3fc1263f.1781194510.git.jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit bebc17b1c03b224a0b4aec6a171815e39f8ba9bc ]

Add a few test cases to verify precision tracking for scalars gaining
range because of sync_linked_regs():
- check what happens when more than 6 registers might gain range in
  sync_linked_regs();
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and one of
  linked registers is marked precise;
- check if precision is propagated correctly when operand of
  conditional jump gained range in sync_linked_regs() and a
  other-linked operand of the conditional jump is marked precise;
- add a minimized reproducer for precision tracking bug reported in [0];
- Check that mark_chain_precision() for one of the conditional jump
  operands does not trigger equal scalars precision propagation.

[0] https://lore.kernel.org/bpf/CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com/

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com
[ zhenzhong: keep the linked_regs_broken_link_2 reject check, but
  drop the mark_precise log expectations because 6.6.y does not derive
  the scalar-vs-scalar range for that non-constant JMP_X comparison. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index f70392bf6..778630402 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -47,6 +47,72 @@ __naked void linked_regs_bpf_k(void)
 	: __clobber_all);
 }

+/* Registers r{0,1,2} share same ID when 'if r1 > ...' insn is processed,
+ * check that verifier marks r{1,2} as precise while backtracking
+ * 'if r1 > ...' with r0 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r0 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void linked_regs_bpf_x_src(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed,
+ * check that verifier marks r{0,1,2} as precise while backtracking
+ * 'if r1 > r3' with r3 already marked.
+ */
+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("frame0: regs=r3 stack= before 5: (2d) if r1 > r3 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3 stack=:")
+__msg("frame0: regs=r0,r1,r2,r3 stack= before 4: (b7) r3 = 7")
+__naked void linked_regs_bpf_x_dst(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id == r2.id */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = 7;"
+	"if r1 > r3 goto +0;"
+	/* force r0 to be precise, this eventually marks r1 and r2 as
+	 * precise as well because of shared IDs
+	 */
+	"r4 = r10;"
+	"r4 += r3;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Same as linked_regs_bpf_k, but break one of the
  * links, note that r1 is absent from regs=... in __msg below.
  */
@@ -280,6 +346,102 @@ __naked void precision_two_ids(void)
 	: __clobber_all);
 }

+SEC("socket")
+__success __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/* check thar r0 and r6 have different IDs after 'if',
+ * collect_linked_regs() can't tie more than 6 registers for a single insn.
+ */
+__msg("8: (25) if r0 > 0x7 goto pc+0         ; R0=scalar(id=1")
+__msg("9: (bf) r6 = r6                       ; R6_w=scalar(id=2")
+/* check that r{0-5} are marked precise after 'if' */
+__msg("frame0: regs=r0 stack= before 8: (25) if r0 > 0x7 goto pc+0")
+__msg("frame0: parent state regs=r0,r1,r2,r3,r4,r5 stack=:")
+__naked void linked_regs_too_many_regs(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r{0-6} IDs */
+	"r1 = r0;"
+	"r2 = r0;"
+	"r3 = r0;"
+	"r4 = r0;"
+	"r5 = r0;"
+	"r6 = r0;"
+	/* propagate range for r{0-6} */
+	"if r0 > 7 goto +0;"
+	/* make r6 appear in the log */
+	"r6 = r6;"
+	/* force r0 to be precise,
+	 * this would cause r{0-4} to be precise because of shared IDs
+	 */
+	"r7 = r10;"
+	"r7 += r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("div by zero")
+__naked void linked_regs_broken_link_2(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r8 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 > 1 goto +0;"
+	/* r7.id == r8.id,
+	 * thus r7 precision implies r8 precision,
+	 * which implies r0 precision because of the conditional below.
+	 */
+	"if r8 >= r0 goto 1f;"
+	/* break id relation between r7 and r8 */
+	"r8 += r8;"
+	/* make r7 precise */
+	"if r7 == 0 goto 1f;"
+	"r0 /= 0;"
+"1:"
+	"r0 = 42;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Check that mark_chain_precision() for one of the conditional jump
+ * operands does not trigger equal scalars precision propagation.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("3: (25) if r1 > 0x100 goto pc+0")
+__msg("frame0: regs=r1 stack= before 2: (bf) r1 = r0")
+__naked void cjmp_no_linked_regs_trigger(void)
+{
+	asm volatile (
+	/* r0 = random number up to 0xff */
+	"call %[bpf_ktime_get_ns];"
+	"r0 &= 0xff;"
+	/* tie r0.id == r1.id */
+	"r1 = r0;"
+	/* the jump below would be predicted, thus r1 would be marked precise,
+	 * this should not imply precision mark for r0
+	 */
+	"if r1 > 256 goto +0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 /* Verify that check_ids() is used by regsafe() for scalars.
  *
  * r9 = ... some pointer with range X ...
--
2.43.0
