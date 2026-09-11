Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1F3A16B6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140619; cv=none; b=TDDnSQWtur4nmNwgl6Kt6NielW/IbcnBaBakjjH1wNvvakCMgcXUNB1V3H67iaxalfm8wdukKUJJy1gFV/hyD9xDNSnKSurfuYJNafJox33uYazyHQ0bZBh509xBhzdwL39Q/9zjASK4O9q9EcEtydZbw+v/LMhfP9nZp/m5aHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140619; c=relaxed/simple;
	bh=nRA/7xZeLkCeDhOx5T8YOfV+tzUAYIfYPSdinQYxapc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBgiTyfUv9ktLtQVmxtyoxxp75dd4Ri++ZFwC/x3wZxK+UXMGMAd2XFj6ZVFGDBXXnxYe1HLy5FK9UKA/xOpNSSXvTViIeRdwNqCLn2EegtF9xlJS2GGwcakcxpw/zQv/DNecBzH0VonNwKx4j6bjM6bvV7cRVz7uS7B6096J54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKT8u95l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKT8u95l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D46C1F000FF;
	Fri, 11 Sep 2026 15:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140616;
	bh=I18TMjbqE/xLxZV2Xnw5pnXxOy0HlLB/OniCvswzYpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RKT8u95lyZuLJiwYYgjX0ca5xSgrCxvgwDSggwzovKjdveYldKGslMzUdgax9d/j9
	 ai8Ai4aU6KJ6uSIj+YxrHicBQMqWDcWPEsdj/fmvqtwWm/bS632edxPcb+Q+OWL8Kh
	 j7PGPymy+noT7oSSrHhMFd4t1GG4Yp6xb+WYlDEA0E/ClEGH4JZyglDvu/aI35Jzuq
	 Kx1CwE4fkVJjuyEfrSu8UygwkzMkujC4S4LZSKCdIf25HA97ehCtFl0ye6q/Ptfum2
	 LsxIG+57NNw6gdQSFPfFEdDTUIFL1dN8tV8mJcml7GXWIiFN06WVAUai4pqwjXM1Bc
	 A7AGDOdSCVqVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] scsi: qla2xxx: Use ring-slot helpers in __qla2x00_alloc_iocbs
Date: Fri, 11 Sep 2026 11:30:13 -0400
Message-ID: <20260911153014.1083465-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090948-thumb-heritage-b108@gregkh>
References: <2026090948-thumb-heritage-b108@gregkh>
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
index 3224044f17753..3a97973ed26ac 100644
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

