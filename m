Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431246;
	b=YUWlh90IL533gt8+vUVoaK7CRScyKpt3qYKeBhsAF4HBPcKg9dU/vi1UG+sx9WzjbxrD
	 puIHVH3mqc6jSqyh8gcP8oIOwhXIknTMVk9w8o6kEctt+xpAVHp/xHPt0q5M3XartqMDx
	 Qmj7Q0abMpXQWpJAqvwNYX6qGTguuZRusczJYNJEZxTMEGbAvmnuzUJ2xWGM5nTjvTPzN
	 GKIbcyXC8maJCrTRHLIgbEFy009MqqX5yG4jaZhmo+rL1hbzwYUKRctskldzlKXRMEdQu
	 KYXiBIHGUvhe5iHPBJRlW5p/V04KzN65GHnBX5FojU+dbVIIjYUalezLCXZKsM1fsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431246;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=t4o+Kch58NGW1qVJDl97OvcV/koP7WOsYc1t+eebC2U=;
	b=XjTzapiI0lawgaWMig6zUcVQMmn6PbqJ9YhXb2lwdt/sNjQE2nLvMss5Nr00q02Gc6dy
	 /SlUr+eMGV+0XLPBu7YdGCZoLjEZtECkBI5AzgAg1TZhvol5qw6j7MEE2+1Zr5s7AZu0t
	 4T2RbiZwskP9vnMQi9atPql216BYc3vH3/3ySZKxzSRaCCa0PB9wJiMdeTnW9CWI8jCIx
	 pggImTyS3a1OtyPadzAr4MYQBZ8FE+fhKMgMbT6RZAhnx3FmjuOD00X2viHMXmUn1hri3
	 9Cuu4UQrh+9qYR+XR5Ex9ZdPLHQb2Vzwu71mUlc66I8YZQtbulhdGaoC2Iede0ezEGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HMfCAG14;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D96606A31A
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HMfCAG14
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2F7DB4E41279;
	Mon, 19 Oct 2026 17:34:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E439A60582;
	Mon, 19 Oct 2026 17:34:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9F2310328429;
	Mon, 19 Oct 2026 19:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792431241; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=t4o+Kch58NGW1qVJDl97OvcV/koP7WOsYc1t+eebC2U=;
	b=HMfCAG149YU4d3+kdRqXoQNgqEzmpdHA9L9JqLRhqwX3M71/q7Z1mlyc8nuIMPEpzo/5+l
	YOTvIfDthyVV2kH94crFv4f1qbsuvIG2Px3oszKbYvW4HOLzxWIPmyYJMxHDeRG6plYWEP
	WGB90R9xK9hagaBT6y6h5vm6hZMhVCDMJiQk8RmGtGuy2rK/7T9CR3bYhvAeF99GGxlzky
	J+CfwZBnd8difeKPDb4JLNYpeJI6oUMDjmJpjhVfBXVCf/VfSegH+IB75KksI04LIQthzh
	+FdawgK39Uz/0N/jK9PACSvvS6bkDM6zR+Y7icwVnXQ9fUKSFi39vRC6HzRP8g==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 19:33:57 +0200
Subject: [PATCH 5.10.y] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-cve-2024-26589-v1-1-e96c2b7dbe20@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ7CMAxE0atUs8ZVHBG35SqIBQkumEVBCVSgq
 ncnwPKNNH9B0WxasGsWZJ2t2G2q4E2DdDlOZyU7VcM7L+x4oDQrVWzJS+gH6mLksXdBOhHU0z3
 raK9fcI/QsmvfOPz38oxXTY9vDev6AZ/cspV6AAAA
X-Change-ID: 20261019-cve-2024-26589-7bb1f8056766
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Hao Sun <sunhao.th@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Yonghong Song <yonghong.song@linux.dev>, Sasha Levin <sashal@kernel.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792431239; l=3693;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=b+Rmqbc615j2TCsHh1/qk36G0QKWCffAq9ndODIm+Vw=;
 b=xepNAkzOld8F9c9l5AcHuTXkxJrB0Jd9IXJB0V6HfGDFufeJxvC+bwQE540fC8UN+or/CM/Vw
 l/3obkgLyJHC56OkeKrxeUcuVPz4nUkqn3KAaUCrdiLYpBV9RQMMO4c
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Hao Sun <sunhao.th@gmail.com>

[ Upstream commit 22c7fa171a02d310e3a3f6ed46a698ca8a0060ed ]

For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
for validation. However, variable offset ptr alu is not prohibited
for this ptr kind. So the variable offset is not checked.

The following prog is accepted:

  func#0 @0
  0: R1=ctx() R10=fp0
  0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
  1: (79) r7 = *(u64 *)(r6 +144)        ; R6_w=ctx() R7_w=flow_keys()
  2: (b7) r8 = 1024                     ; R8_w=1024
  3: (37) r8 /= 1                       ; R8_w=scalar()
  4: (57) r8 &= 1024                    ; R8_w=scalar(smin=smin32=0,
  smax=umax=smax32=umax32=1024,var_off=(0x0; 0x400))
  5: (0f) r7 += r8
  mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
  mark_precise: frame0: regs=r8 stack= before 4: (57) r8 &= 1024
  mark_precise: frame0: regs=r8 stack= before 3: (37) r8 /= 1
  mark_precise: frame0: regs=r8 stack= before 2: (b7) r8 = 1024
  6: R7_w=flow_keys(smin=smin32=0,smax=umax=smax32=umax32=1024,var_off
  =(0x0; 0x400)) R8_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1024,
  var_off=(0x0; 0x400))
  6: (79) r0 = *(u64 *)(r7 +0)          ; R0_w=scalar()
  7: (95) exit

This prog loads flow_keys to r7, and adds the variable offset r8
to r7, and finally causes out-of-bounds access:

  BUG: unable to handle page fault for address: ffffc90014c80038
  [...]
  Call Trace:
   <TASK>
   bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
   __bpf_prog_run include/linux/filter.h:651 [inline]
   bpf_prog_run include/linux/filter.h:658 [inline]
   bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
   bpf_flow_dissect+0x15f/0x350 net/core/flow_dissector.c:991
   bpf_prog_test_run_flow_dissector+0x39d/0x620 net/bpf/test_run.c:1359
   bpf_prog_test_run kernel/bpf/syscall.c:4107 [inline]
   __sys_bpf+0xf8f/0x4560 kernel/bpf/syscall.c:5475
   __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
   __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
   __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5559
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fix this by rejecting ptr alu with variable offset on flow_keys.
Applying the patch rejects the program with "R7 pointer arithmetic
on flow_keys prohibited".

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/bpf/20240115082028.9992-1-sunhao.th@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e1f571219d16..8340273b1237 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6281,6 +6281,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str[ptr_reg->type]);
 		return -EACCES;
+	case PTR_TO_FLOW_KEYS:
+		if (known)
+			break;
+		fallthrough;
 	case CONST_PTR_TO_MAP:
 		/* smin_val represents the known value */
 		if (known && smin_val == 0 && opcode == BPF_ADD)

---
base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
change-id: 20261019-cve-2024-26589-7bb1f8056766

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

