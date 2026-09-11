Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70754A92F0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146994; cv=none; b=q6sA2xdqcen+Ur3T1QcYdzIbAklVcwG5aIVELYTevXCFa2Uazp3P/1D4ApjxmtWYqzV4altPNFTBWPCtBLhj6kJZ4IQJ5ivR2lVJDONVuoRWoXmOcCPSgcWPJD2Tl0feY9w9fTEW8UxziZEYF8Vj00MLrQMef/AJ8rv0lzKIPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146994; c=relaxed/simple;
	bh=jCgA/PtEv73UVfOU39fz8CRPEArL+j7KZDABH1vZFk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPDSfZjuh3C8zK/LkW189j/xc4I7xw2ysf5wxKeVu8pK3O4AwGpAeVFggcRROCR7k4zz69BUifPrG0EahvxtmmIS9MPgsTPFG2e6RILGONnPhAe6/QgXezPuuiZqlSqosn7fhbqkZZ0p/6iTF/rDTBA/SJxWRnP7sDSoAc++WDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhnzT1Ox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhnzT1Ox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8EC1F00899;
	Fri, 11 Sep 2026 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146986;
	bh=cKaZwoinx9O4Yls3xJdMYix/ztBip0qUX8LB3d7R6bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nhnzT1OxANEWxfWynS5l4JgmXTq6aLUJv4LSSDlzeW2DRKgfrI8Ri9TPAqh9g37Ur
	 pIkN7l/xcpZd1QfWyH0Ju3nQUBH/htZjsDTeYuspI2wID982Kq6IRqPsrT8yIWlHIy
	 hYPYl+Q+gqOapZ/OEb7fHsTuRGr4HrKCkQs2/W3WDIZCW3yZhQsTOKijn+IdSwULgL
	 mF2/xcZw5CbKFL0Az4ZGdq7LeE6D7Vj14O1StROsr2mHXDneayqpoPJir/ZMSl0SIm
	 GF3WR1Q1yFSbZq7fo2kaRVuyFeXA1FpXnOCi5ock2b6+l5XH+nDKxSUwzyNpf8jxym
	 YJCvTl/wm/yBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] scsi: qla2xxx: Use ring-slot helpers in __qla2x00_alloc_iocbs
Date: Fri, 11 Sep 2026 13:16:23 -0400
Message-ID: <20260911171624.1221503-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090949-percent-chivalry-9e9e@gregkh>
References: <2026090949-percent-chivalry-9e9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 7e51b6d2d8f6b7f48d9cef1cf87471b55b12f6de ]

__qla2x00_alloc_iocbs() open-codes ring pointer selection and entry size
based on IS_QLA29XX(ha): 29xx reaches the slot via ring_ext_ptr and
zeroes REQUEST_ENTRY_SIZE_EXT bytes, while other adapters use ring_ptr
with REQUEST_ENTRY_SIZE bytes.

Replace the two branches with the qla_req_ring_slot() and
qla_req_entry_size() helpers, and initialise pkt at declaration.  The
IS_QLAFX00 register-mapped writes remain guarded because IS_QLAFX00 and
IS_QLA29XX cannot be true simultaneously.

No functional change: the bytes written to the firmware-visible IOCB are
identical.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-24-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

Stable adaptation:
This tree has no QLA29xx support, extended request ring, or ring-slot
helpers. Provide file-local macro helpers mapping to req->ring_ptr and
REQUEST_ENTRY_SIZE, preserving the existing 64-byte ring behavior without
adding functions or importing the unrelated QLA29xx support series.

Retain the helper calls and declaration initialization from this change.
Use a multiline packet-preparation comment so commit 626e44f3d8a9
("scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot")
applies unchanged, including its leading context. That commit remains
responsible for changing the FX00 clearing operation to memset_io().

Stable-dep-of: 626e44f3d8a9 ("scsi: qla2xxx: Use memset_io() to clear QLAFX00 request ring slot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 0b41e8a066026..1a3a276925b82 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -11,6 +11,10 @@
 
 #include <scsi/scsi_tcq.h>
 
+/* All adapters supported by this tree use the 64-byte request ring. */
+#define qla_req_ring_slot(ha, req) ((req)->ring_ptr)
+#define qla_req_entry_size(ha) REQUEST_ENTRY_SIZE
+
 static int qla_start_scsi_type6(srb_t *sp);
 /**
  * qla2x00_get_cmd_direction() - Determine control_flag data direction.
@@ -2286,10 +2290,9 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	struct req_que *req = qpair->req;
 	device_reg_t *reg = ISP_QUE_REG(ha, req->id);
 	uint32_t handle;
-	request_t *pkt;
 	uint16_t cnt, req_cnt;
+	request_t *pkt = NULL;
 
-	pkt = NULL;
 	req_cnt = 1;
 	handle = 0;
 
@@ -2343,10 +2346,12 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 		sp->handle = handle;
 	}
 
-	/* Prep packet */
+	/*
+	 * Prep the current request-ring slot.
+	 */
 	req->cnt -= req_cnt;
-	pkt = req->ring_ptr;
-	memset(pkt, 0, REQUEST_ENTRY_SIZE);
+	pkt = qla_req_ring_slot(ha, req);
+	memset(pkt, 0, qla_req_entry_size(ha));
 	if (IS_QLAFX00(ha)) {
 		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
 		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
-- 
2.53.0

