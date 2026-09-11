Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508314A99BD
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146994; cv=none; b=UHsZd52SR01VMSBYT87t1gXCBSc/dAR/WQRKjUZPYtwl2iRk+mw95HQblKWm3QFHTKW1jIafQxPdWsTmpM8sYP49pZz/jguar23CimpO79scIdh1K53Fs+kJjm8Qgby/t3J9bLdGHcyNqscrTFDl2rYCqpjvjA5z5xnxzGaD878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146994; c=relaxed/simple;
	bh=9B3IOEHs1gaFMH3IZ6uQfcfDDHJv0dIjgXS4InKJfBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5z8KpGFghedC/+LFSZXxKu4KC34DpellLT7RDuyuTe1QIRskQ1F74jBbLFJmGX0OHMrzJJu0Cnb8ggzyuT/PtlqQKfeZNSMOuTUf97XJEO5Vk6MHTGkdNYXKTBkie382mKPKsOTr6Z+4r77j4NAH/e+KMTnZS6LZj6p/YPGpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTbYedye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTbYedye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921341F0089B;
	Fri, 11 Sep 2026 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146987;
	bh=Gv8IjDN5/hFL45zWCYIQxy2b2EmqHS7FYFlffdE5J7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PTbYedyeGaIFwSY2qfmOvLAltshZ8UisOOr/Dh4NJGHvTAmvor3TZQsmfeT4x7l/3
	 V6Ltc0iV7ELjqXjEWDbFxVck/DLK/6fcbvxdC2mGNw+Ivn0Usq+2/m1ikWdS5rCK7f
	 4jK/GjzpdDBDboDp9dImh4SFCeycs+Ehjw+nn+LYo/h2w6h+hcwecwDqjL0H4VZAs8
	 Q7i5rX6gE2sEWbtbw97GMMX9AJtxRALpeynCKiIXc/wzrlCW6BX4YltoVsGOykJuol
	 743g4aLD/S0IHCJHdqxkFdVCy3AuN1Io5aHUxnG8g+CPbA1vLSTtBHJvovXi1WnpHH
	 bgARvl+aB+X3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
Date: Fri, 11 Sep 2026 13:16:24 -0400
Message-ID: <20260911171624.1221503-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911171624.1221503-1-sashal@kernel.org>
References: <2026090949-percent-chivalry-9e9e@gregkh>
 <20260911171624.1221503-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 626e44f3d8a924a97a3848a9fd45833947e081e9 ]

For QLAFX00 the request ring is ioremapped device I/O memory
(ha->iobase + req_que_off), not DMA-coherent RAM, which is why the rest
of the FX00 path accesses it through memcpy_toio() and the wrt_reg_*
helpers. __qla2x00_alloc_iocbs() however zeroed the producer slot with a
plain memset(). On architectures such as ARM64 a regular memset() may
emit unaligned or block-zeroing instructions (e.g. DC ZVA) that are
invalid on Device memory, leading to a synchronous external abort.

Use memset_io() to clear the slot for QLAFX00, matching the I/O
accessors used elsewhere on this ring. Other adapters keep the plain
memset() on their DMA-coherent rings. The zero-fill is retained for FX00
because its IOCB builders (e.g. qlafx00_fxdisc_iocb()) copy only part of
the entry and rely on the unused tail being pre-zeroed.

Fixes: 8ae6d9c7eb10 ("[SCSI] qla2xxx: Enhancements to support ISPFx00.")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-12-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 1a3a276925b82..4764d5066caf6 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2351,11 +2351,13 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	 */
 	req->cnt -= req_cnt;
 	pkt = qla_req_ring_slot(ha, req);
-	memset(pkt, 0, qla_req_entry_size(ha));
 	if (IS_QLAFX00(ha)) {
+		memset_io((void __iomem __force *)pkt, 0,
+			  qla_req_entry_size(ha));
 		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
 		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
 	} else {
+		memset(pkt, 0, qla_req_entry_size(ha));
 		pkt->entry_count = req_cnt;
 		pkt->handle = handle;
 	}
-- 
2.53.0

