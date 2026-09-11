Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5B3839B8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149153; cv=none; b=fZ0BYKtmH6vXbxuPKQpPbjbihiLqaXbS1xZgjDCKTu3H2NYSz0F6SlVkbsOEO+2fFHaNiPtkd0w+8F7MwTslXq6eTn1AzlQ75t3VudqZRsbWUrcfw+1EYDud5XvkxwwX56Q2w6qUi57IBtUAS46YeuvOHVphSOcwmLDIVM+nm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149153; c=relaxed/simple;
	bh=0M43A4cJWV4AOR3vqlpAVclVBkz+xq5522UM0utpUMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4R1LQn1D4o+6WyHBCiFWgnCmu7X/KAn3kz9GPsmPqesBfMnRKNqLl63dSivf/LJ8lCCq3MiMhvwCipdk/d0SxInerwd+h5JTDrKqXirNfR4Rbjl1o/JlupnOAO3XeeaSHYIdHU5iYf8Y8JVrpkCJSSx0+cwOvSHMrkvjJRDBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAW24HHj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAW24HHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F52E1F000FF;
	Fri, 11 Sep 2026 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149152;
	bh=pGDZFB4wsJopH5mAwPukide/qqQZrEkDNp1uLzTykU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BAW24HHjokcake/IJQNsqvQAQ1rLLEmOY9gBUcgk0VB49Rz6iTP5i1tP0simoRm+y
	 m21TKZFUXIAhSUJaHwpTm1IO/gcGyPGuySMipnEbGXWa8WT8m2XNMusgMAHyxqGuUA
	 MERqZZ6zBjGe+rn1jChP7oOLaDGjT1R3fXYzFhIleJpXd1X869PufVU6FkvGTOEBJY
	 Y99G2+E1Vpg2+RZAEdw59jXrMXGIN8Lkm1rLhpXjLlnzow/MlI7m/rZ2R8hQEKSB49
	 aIeoYP7zl8NKab+1cBGjdaPgiIVkRSR4lZhKeVLvr3tbwm/cn5vVay5Vz356RE1djO
	 0K3y+VT1LEHaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Sashiko <sashiko-dev@google.com>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot
Date: Fri, 11 Sep 2026 13:52:30 -0400
Message-ID: <20260911175230.1277530-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090950-suitor-quake-2aad@gregkh>
References: <2026090950-suitor-quake-2aad@gregkh>
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
[ replaced qla_req_ring_slot() and qla_req_entry_size() with req->ring_ptr and REQUEST_ENTRY_SIZE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 7bccd525ee19b..f080e19529272 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2347,11 +2347,13 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	/* Prep packet */
 	req->cnt -= req_cnt;
 	pkt = req->ring_ptr;
-	memset(pkt, 0, REQUEST_ENTRY_SIZE);
 	if (IS_QLAFX00(ha)) {
+		memset_io((void __iomem __force *)pkt, 0,
+			  REQUEST_ENTRY_SIZE);
 		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
 		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
 	} else {
+		memset(pkt, 0, REQUEST_ENTRY_SIZE);
 		pkt->entry_count = req_cnt;
 		pkt->handle = handle;
 	}
-- 
2.53.0

