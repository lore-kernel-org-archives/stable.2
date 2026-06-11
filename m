Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD03E170F
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194136; cv=none; b=aVJCex396KmJPe5eaoI4ZgDEoXipNpZQolG1ZoA5FRNykupF+uYLu2/3kBa/TmnUkhFM6F3+64ilV8cobu32EYVhoeupZ02k1Y1b5aYYScpYIzpKkuRNpC5A9vnEoioAM2zhnuIGRvI0wnUTDkcNqvuFBBctAB80pDP6qaUiqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194136; c=relaxed/simple;
	bh=BXF26WfspQD1f+THse2SOP2gHSc/2CF0BXE5D15lMrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YEwJCPq7NZMZrrd0LLVS9lopFGX+h//Kajb+rcko5xqhVgId3+ynEqUc35DZRzqkVSKQUS8lVxyOGLuhUCbg2c8kYdOGJ3dDCh9PPExmkp1phf2wRtQTrdsWFM0yc7DoAdej18YwySEC82BVLLEIu65M5bXVhtwR2tUvDApalSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rT/feOGW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT/feOGW"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c855599a77aso4206261a12.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194134; x=1781798934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvQawD0Kg/papzUrEu4jlkugdLsQZFEA+b1BBuoukfo=;
        b=rT/feOGW6AYHMtF1IIshdESdaCVpcHWniXWeQ5zd+F1gGe/LSvkyfbGP9w9Xr4FlJc
         mZYs3iyAAwGV1k1u9xFFp4tezQRdrdnJkPt9mf1acOZfeo6B17P5L8WAIigwtJx28xI8
         YP/j6zgm67Icm/DUFA5QcMOTxgTcbNBLpoOnaS7WXMhuNOWjnzrb+Bdb/XDJbAigw3UV
         0PP/p9v5FT1s1HJkdi6KiNol7ceCpkvtHTRKENIlCuFXsKRsLi4qcMBxW48FDYZPJFTm
         HB8n09Vmf3VkJNfu/Iep/2wovIsxxwYo4PaP/gxLGrkQDA/qv3Sfbetz8sjZJqINvSTN
         QRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194134; x=1781798934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvQawD0Kg/papzUrEu4jlkugdLsQZFEA+b1BBuoukfo=;
        b=q+qQDnKFNyQ4+6PvSbgi5t8m6zG53WPpWQTkENWg1pQlJOExoxbyncak4RntzTqlrH
         OILSivYdLDfDv6rlFApxnrR7r5OkdKFX2YeSkWJhs27WivPt3HIy7uyCJnS7I0zM+AD7
         lVjma/gF188wZ/j7o+WGY76SrMXLRO1fSXeY3gsOgDxpr8C/X0sBcWBNPGjHx0Y3muh2
         QrvvMt/47e9yAUhkujILAnMmEy2W1Ud0WK5v3UirY47/wttjDfwfxp+6hXoIWouo6LQ+
         wbsC1NCXnOWmN6Ku99LK9iixUlJqOD4OcXIjRjhPtvRid6QA3CdUHaLvmwh1Unv2rYT6
         BRXw==
X-Forwarded-Encrypted: i=1; AFNElJ+Pal4lEG1QUUxCXnfK4z6bCva3wAGcPibOoATvm2wmap7EsGG/omAoH4w4QXlpF/l/GDjJkEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztCmslUgfPQLFCMl147ak/du9onA78sstZvqfKgHtTVv22dmyL
	Alr0exRAljsJBSvUcZvTBMjwVCagIZYopRN3RHFi//HLDxvkfHqVm2aa
X-Gm-Gg: Acq92OF+wj9EmPCMyj8XFVOjg/+cjM25znyK6h8JtI9VVV6x3eIYdy6P/GGoafjZ9zz
	1w5s4Nv/AAqqdNeb8o8rWeOZhGMF8g+QI95kKX81bpsx5Y1H6RrVZIeQOmNLa3d8XFGtAJNM0AA
	vm5uOGX65USwnc4lw9xhzEgQngsqouxDg7qQBB5AOcSVSITRxlhtRn4z8/3LmurHcHr6m3P/7Iv
	DFpBPjL7+rv1QRPb3JwIa8i+Bo4LXOilGeLxeYBgpUDwpPbR0ODayoJ20H1PceYFJ51EWleoClP
	ie+4qCuKqGwXCqVOiJK+Br2mvSFrqSdK5gwO8sCJVLmPW2NBCSgzslOHCliN4c6g6CffiIvVZkm
	JKouuvLaliU6XYy3On7vDWTYdsfTCvVXGdCK9Ii/0PcTwy3fjMmLh4z4kc6d10SSX91k3+e5YCS
	ZLoCoJUwruIOrWg9Y22W/3qhAPplq3AJthcQ==
X-Received: by 2002:a05:6a00:9a6:b0:842:3aee:12c0 with SMTP id d2e1a72fcca58-843370762e7mr3967784b3a.23.1781194134186;
        Thu, 11 Jun 2026 09:08:54 -0700 (PDT)
Received: from localhost.localdomain ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843382e5788sm2274495b3a.43.2026.06.11.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 09:08:53 -0700 (PDT)
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
Subject: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar pruning selftest
Date: Fri, 12 Jun 2026 00:07:49 +0800
Message-ID: <20260611160749.391279-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a verifier runtime test for a branch pattern where a helper return
value and a related scalar stay live across the same control-flow
sequence. Rust/Aya-generated eBPF can naturally produce this shape when
a match on a helper status keeps data derived before the helper call
live across the same branches. Such code commonly uses the helper return
value in r0, where 0 means success, producing an r0 == 0 / r0 != 0
branch shape.

The test preserves that branch shape but shifts the success value to 1
before branching. Using r0 == 1 / r0 != 1 avoids depending on the
verifier's not-equal-zero refinement, so the test exercises linked
scalar precision and pruning behavior directly instead of being masked
by zero-specific range refinement.

On affected kernels the verifier can explore an impossible path where
r0 and r7 are linked by scalar ID, keep the wrong branch, and make the
test return 1. With linked scalar precision tracked per instruction,
state pruning keeps the real success path, and the test returns 0.

Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 .../selftests/bpf/progs/verifier_scalar_ids.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 70ae14d60..de71d547f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -448,6 +448,41 @@ __naked void linked_regs_broken_link_2(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("helper retval linked scalar pruning")
+__success __retval(0)
+__naked void helper_retval_linked_scalar_pruning(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[__sk_buff_data_end]);"
+	"r5 = *(u32 *)(r1 + %[__sk_buff_data]);"
+	"r7 -= r5;"
+	"r2 = 0;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 1;"
+	"call %[bpf_skb_load_bytes];"
+	"r0 += 1;"
+	"r6 = 1;"
+	/* success path keeps r7 independent; failure path links r7 to r0. */
+	"if r0 == 1 goto l0_%=;"
+	"r7 = r0;"
+"l0_%=: if r0 != 1 goto l1_%=;"
+	"r7 <<= 32;"
+	"r7 >>= 32;"
+	"if r7 != %[test_data_len] goto l1_%=;"
+	"r0 = 0;"
+	"exit;"
+"l1_%=: r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_skb_load_bytes),
+	  __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)),
+	  __imm_const(test_data_len, TEST_DATA_LEN)
+	: __clobber_all);
+}
+
 /* Check that mark_chain_precision() for one of the conditional jump
  * operands does not trigger equal scalars precision propagation.
  */

base-commit: 30dee2c176e7954f63d1fa3e52d172f30beb9bfb
-- 
2.43.0

