Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFB3CF694;
	Tue, 28 Jul 2026 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270425; cv=none; b=ETcL7Haa07nf4jNWYcKsF/+ISAAlE0+xNB4fLBf7UW2aIFTNJbOm0TPX+T+UxGIM/AdZPEYEMDMKx9KvBiH9/JUxVobNk1xGovMgZJv3ApQtDyWqp+JluzAND8Rpiy5QNe8orAIBq2iWlhIN5rlw3Z0RQsO9tZSv0xNseX3wY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270425; c=relaxed/simple;
	bh=oLhwIKF0f2DycNnqBRIwhiDvjUQ2yuqU4c+DLTSzLiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RgDETzIWDlwga5DixEyh0YQTBneZZYJpl5oEIYORical5K95SD5Ja3ep/r8LBKzujsY6JCnmcLwdEb2sRTh3RKTwd2K/0VE7fcpLX1TuZyBkk6wL7oW+Y17OtRl3lgfvRmtA15lHMoka2zA2Rsty3NMKji54DqzAyibyIroofe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nW2lyBLQ; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nW2lyBLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785270423; x=1816806423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D0nYnrkxlxzlKhEo6lBxDrDW6IlhsHdiNjG4zE9rnwg=;
  b=nW2lyBLQ6j7XRxSJX99A6ZyEANrCpe9nLdN+6UVFRiIqJYVGF1Kc4GGF
   3Jdc3/qI8tvGHnfvHqJwJ39uMgQcEkDeNZESmOsY09/pW6mEXch5hJTJE
   gRbNAZ8y5IKaDl93PRSCycVRatDDrvI28+71oIOus2aGfuXRR5TV9Z0LJ
   X3FVVoQMPJ7X/xgtHQaLTHl+smvBOmQD2rm5TMehjcmQviwT8Kdd23UXY
   oCSUAOKgzB0zQpKtFXSZcNxX/+zamSDODovb2vQaV4IFLKyAtCBODEl9+
   KL2EbNKDX3O+z+4MrIjcLZVuAhYchv5RXUiLOhT6lA4qJwJaUAMMyT0qh
   w==;
X-CSE-ConnectionGUID: r7qDLhvhRvy5HjayKFPqEw==
X-CSE-MsgGUID: VnlW0/odQGSz6nVb/K+BCg==
X-IronPort-AV: E=Sophos;i="6.25,191,1779148800"; 
   d="scan'208";a="24314078"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:27:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:11988]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.7:2525] with esmtp (Farcaster)
 id cb6db877-2dac-4f4c-a65d-b72c5cf3394c; Tue, 28 Jul 2026 20:27:02 +0000 (UTC)
X-Farcaster-Flow-ID: cb6db877-2dac-4f4c-a65d-b72c5cf3394c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 28 Jul 2026 20:27:02 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 28 Jul 2026 20:27:02 +0000
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<jiayuan.chen@linux.dev>, <martin.lau@kernel.org>, <bpf@vger.kernel.org>,
	Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18.y] bpf: Fix same-register dst/src OOB read and pointer leak in sock_ops
Date: Tue, 28 Jul 2026 20:26:58 +0000
Message-ID: <20260728202658.8687-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 10f86a2a5c91fc4c4d001960f1c21abe52545ef6 ]

When a BPF sock_ops program accesses ctx fields with dst_reg == src_reg,
the SOCK_OPS_GET_SK() and SOCK_OPS_GET_FIELD() macros fail to zero the
destination register in the !fullsock / !locked_tcp_sock path.

Both macros borrow a temporary register to check is_fullsock /
is_locked_tcp_sock when dst_reg == src_reg, because dst_reg holds the
ctx pointer. When the check is false (e.g., TCP_NEW_SYN_RECV state with
a request_sock), dst_reg should be zeroed but is not, leaving the stale
ctx pointer:

 - SOCK_OPS_GET_SK: dst_reg retains the ctx pointer, passes NULL checks
   as PTR_TO_SOCKET_OR_NULL, and can be used as a bogus socket pointer,
   leading to stack-out-of-bounds access in helpers like
   bpf_skc_to_tcp6_sock().

 - SOCK_OPS_GET_FIELD: dst_reg retains the ctx pointer which the
   verifier believes is a SCALAR_VALUE, leaking a kernel pointer.

Fix both macros by:
 - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
   added instruction.
 - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
   restore in the !fullsock path, placed after the restore because
   dst_reg == src_reg means we need src_reg intact to read ctx->temp.

Fixes: fd09af010788 ("bpf: sock_ops ctx access may stomp registers in corner case")
Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when dst_reg = src_reg")
Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@std.uestc.edu.cn/T/#u
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20260407022720.162151-2-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 net/core/filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6dd9bdbef1996..cacbecbba4fea 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10523,10 +10523,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->dst_reg,		      \
 				      offsetof(OBJ, OBJ_FIELD));	      \
 		if (si->dst_reg == si->src_reg)	{			      \
-			*insn++ = BPF_JMP_A(1);				      \
+			*insn++ = BPF_JMP_A(2);				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 				      temp));				      \
+			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
 		}							      \
 	} while (0)
 
@@ -10560,10 +10561,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 				      si->dst_reg, si->src_reg,		      \
 				      offsetof(struct bpf_sock_ops_kern, sk));\
 		if (si->dst_reg == si->src_reg)	{			      \
-			*insn++ = BPF_JMP_A(1);				      \
+			*insn++ = BPF_JMP_A(2);				      \
 			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
 				      offsetof(struct bpf_sock_ops_kern,      \
 				      temp));				      \
+			*insn++ = BPF_MOV64_IMM(si->dst_reg, 0);	      \
 		}							      \
 	} while (0)
 
-- 
2.47.3

