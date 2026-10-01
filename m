Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B152379B
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868259; cv=none; b=XJT28M1d6SYgYoNMcX+6BX0puuB/KnimzIQ+xQ7POWsHgfmv0lOaZhthNiYBOaEHLkLUtae8pPnEDwhDTN1BVjAL0djvou9f2GsYqcKCtNMTHvOXLCth6FYSPf+idWQbk73sm4h/2y1bvRuyLsruDkShX3/KmfYSATWJMg3wJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868259; c=relaxed/simple;
	bh=MQ9BjaRNyydHXlIrJ1FdBhoZpYj/3OiqYJYF1xVwEKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=be2wu3zQK9d3AyoC54sTH/nDETK47MhVHMcJnLovBlepzhOA6nIk/igKUlI1C6Qlm1VgdjYqhyQi5dhwQ6++AQdzExACEq2V+dxnbep+5rbyqCBRZiwEp7sCD2QEA48gbD7zXFm00d15gVnnq5X/NQC9Ac6xdgNs2a+/AKtUvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdO+jIZD; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdO+jIZD"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so3288681b3a.2
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868256; x=1791473056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=19Qm5BRlqPrSeymeH9RuVyvzMryAwRHiRwCDW/0wLJM=;
        b=XdO+jIZDzIApcj6T4gnGsY1F0A1ud2ui8FPQUdUs93IKrF9fOsZ5CG4jZ1Z/un5XRV
         RvfAmIji9mMPb54ZSX8vZw+gBCsotTC0dLwMGtQ3BNbJE1AutYlLgaVCebuKbNHN0CrE
         Yz88OonT96b9uHGNzaaKedBySAvnFJXXNqNZkUniVvXiZpcmwCbZxG86RhK5cSRBEfdV
         RSaxR5ZbiKhAxmVovWRXHf3Iwp8d7sIiVnirRmobM9tgA6HUsdGmrHNPJdYWTsbVl+BK
         2peY3wesitjheO9Rqv1YoklJlUqP1je0mWBaLwJYsTQCV7WtJFq5hyhYyD7H8Wvjz614
         HmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868256; x=1791473056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=19Qm5BRlqPrSeymeH9RuVyvzMryAwRHiRwCDW/0wLJM=;
        b=ek7F9XSvl9K2osH2cw5DpBcIqAfQL0fIYUY0nRxrilVxr6+MnjApZ83yU3sXCOG21y
         4nKDauhS34KdpELATliM6M5GGG8iFKqYU2EeFZjltehNez4aQpdoc5Yr+J4zeeaeGzb/
         VYCc+kJKJsdz1266uCts3Fu41tlT9eueVWqXYFliXpDimNv7MEHdWKlO42j4jQDxIXyj
         vGYJFaSQgJXD+XFMjsZdoAvA1yfbJEoHIQHzcBxvmJD0WUlFaWolJg++ek6ES1cAH9ny
         tdPTrQMfungkcNRaT7rWrtW4NlVbnDpkLVTZLDRP/Bh1Mc8o0yFrX4R2WGlRksELkp0R
         vcDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdb98jW060tso2Ee8d3NSIDnm/TImh2vBk0bBS5ZeWHJX0PbfDDC+0MA7R68mM+LE3I+vkoaw=@vger.kernel.org
X-Gm-Message-State: AFuF++l2H53LcKmUh9Y5TTlWblTIOBbHXcZZawDiekCj4S8joNEW08Ms
	P4JzEiv6x24iBeqvagEvOuPBKLQBMqEB291JDiIW21ZHqVzXfQq+rsXwhENVATXc
X-Gm-Gg: AYBFou2QWlzcD5hEsa/+R0vD/aCBWHvyIeoPw6aLjamB/rLw3ua+WsetCr4Y7H+iPVA
	LbKEonc2njLbt5j6mqSTu/wPoeMM9w+UdHC4g73h1iwgRybzZkQnmTFS89ODPIzRuEg8nsCo1oz
	4LosdeEVSpj4XIq3r4snYY0QpKY8/pisGnmXRkS0gq1jOS7wb8wVH5UKO84pNNRT4Jbxgo8V4T4
	h7oQgmZCLCDN7+zV9mx66AeVZeTHIpRYEJnuLjaOXXf59cHB+gNz3oegLsOt23cK8qnW+NMJcOV
	fkTizUghHsMhtWIymDZ97qhINxVoGqrYsDe25rd+KJJOK3QcrF+HfMWx20gYuGpWB5FD9Cmh4Q4
	KpNmmn46IhuIX4EoAhnpuPY6W9kfCGtasoAWNc5SWSffmff1f+QYA9eWUo3gr9ZNeZFLKXPMDQC
	WpJDPcOQsHlKhcK/q1gYK012D04FTIA4BgWyQw6BBrgde6mSV426TFr+qOmF+H88ERE4Ml9weBd
	yz/oEh/Og==
X-Received: by 2002:a05:6a00:1396:b0:87c:3660:fa76 with SMTP id d2e1a72fcca58-8874cebcc9bmr3878684b3a.34.1790868256333;
        Thu, 01 Oct 2026 08:24:16 -0700 (PDT)
Received: from localhost.localdomain ([112.171.72.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-888193d2061sm1270454b3a.36.2026.10.01.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:24:15 -0700 (PDT)
From: Youngsung Ahn <ays511.kr@gmail.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org,
	Youngsung Ahn <ays511.kr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: bound the WQE opcode before indexing rxe_wr_opcode_info[]
Date: Fri,  2 Oct 2026 00:24:07 +0900
Message-ID: <20261001152407.3259261-1-ays511.kr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930180221.2497908-1-ays511.kr@gmail.com>
References: <20260930180221.2497908-1-ays511.kr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wr_opcode_mask() indexes the global rxe_wr_opcode_info[] array with
a caller-supplied opcode and no bounds check. For a user QP the WQE
comes from an mmap'd SQ ring, so wqe->wr.opcode is an
attacker-controlled __u32 read back by the requester
(req_next_wqe() -> rxe_requester()); rxe_post_send() takes the
qp->is_user branch and never runs validate_send_wr(), whose only
opcode check is itself !wr_opcode_mask() (it indexes before it
checks). rxe_wr_opcode_info[] has entries only up to IB_WR_REG_MR,
so an out-of-range opcode reads out of bounds and the result is used
as a mask and dereferenced; observed as a KASAN global-out-of-bounds
"Read of size 4" and a wild-pointer oops.

Return a zero mask for an out-of-range opcode, matching how
validate_send_wr() already treats a zero mask (an invalid WR), so no
path indexes the array out of bounds.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Youngsung Ahn <ays511.kr@gmail.com>
Assisted-by: LLM
---
Notes (not part of the commit):
Reproduced on a KASAN x86-64 build of 7.3-rc4 as uid 1000. Present unchanged
in mainline 551c722f4080 (2026-09-29) and rdma for-next. Compile-tested
(KASAN+RDMA_RXE), not runtime-tested. Per security-bugs.rst this is public and
a reproducer can be shared on request. IB_WR_REG_MR is the highest index the
array initializes; an ARRAY_SIZE(rxe_wr_opcode_info) bound would be equivalent
but the array is extern to this header.

v2: no code change. The irregular indentation in v1 was email mangling (HTML),
not a coding-style problem -- as Willy Tarreau noted on the ODP thread; resent
as plain text with tabs preserved via git send-email. Added Cc: stable, fixed
the author/Signed-off-by match, and added Assisted-by: LLM.

 drivers/infiniband/sw/rxe/rxe_loc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 64d636bf80fd..dcc0788db90a 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -184,6 +184,9 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);

 static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
 {
+	if (unlikely(opcode < 0 || opcode > IB_WR_REG_MR))
+		return 0;
+
 	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
 }

--
2.43.0
