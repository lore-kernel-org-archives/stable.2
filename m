Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672F4A8A3A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149501; cv=none; b=qzYQ0HZN0TmDQAY94eTGXJDO95wo3t6aUYcjUlp8jUIRUIhTI75GOneuaEDvNfU13RXXM30/TiYYDNg8hFp13hRziNigkBXw6PPnfWmgAAQk68J2m4+YSTIwzKI4eHSaEDR3Xm9mYt6tk3G/yfVWfXKDEKKgGUAMRig/B+lKetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149501; c=relaxed/simple;
	bh=aFSCR/O7CJRtaIfXCIRTDJLGUTqFEV13slGbkGMWo10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHlBN8CKdlNaCFDF7Bn1MV7RfwI+cLFz9QrGXKx9CZs1ettOfMMsUI40B+pSE5ZKX/S71UwoO7VP4CfoVHMeOXZBOaODaQKXCBvtQey4q52ABec6NTcJVJ43DXYkRKhtjVQ2yveuz6JVjDjekxgqGOreRT96enB/n2biiAkhT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUnq/e4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUnq/e4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EC31F00898;
	Fri, 11 Sep 2026 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149499;
	bh=Pa2rK/GA3HXDQDzCQXqNo42zMhKiQPN4wjh4fYprtWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUnq/e4k9HM3GEBP1jYWVmp213CsP+kdrkr4hOmaB3qff6nOuGPXg6WkpOPC9WQte
	 6yqkvC3aY53d6iUFflI/EL9M/EteTT5UhRzE4yNamgWSJP5nnd292k7U08xbBQPtvI
	 sxw3aXPrIvunDQxPuCXGkIXbjXI1yPJRxob9I7Dyexoyn/yrwx8b217IUsU9fC6Qt3
	 BTE9S8mQCSSoKDUTsBnJ+Z/eZfxwWnAV09jL5ta0zEy95LbQyCkTspBFJZuWZGN7W7
	 JzjK09sPcEtVhJhksi9+iKPJE7/9o+hWoEvPd2RvmF/EvZjJl2dZ7C3zuwKVe6xVE5
	 UynGXOBYMGIHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Fri, 11 Sep 2026 13:58:17 -0400
Message-ID: <20260911175817.1283105-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090900-spyglass-amnesty-95b8@gregkh>
References: <2026090900-spyglass-amnesty-95b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit 52fba32317ee631faa878725b2f7cd5c08acacd3 ]

qla2x00_get_data_rate() skips updating ha->link_data_rate when the
firmware returns mcp->mb[1] == 0x7.  That value was a legacy sentinel
from before 64G hardware existed, but PORT_SPEED_64GB is now defined as
0x07 and ha->link_data_rate is decoded with the PORT_SPEED_* encoding.
On a 64G-capable adapter a genuine 64G link is therefore dropped, and
the port speed is misreported (port_speed sysfs, fc_host speed, FDMI).

Only 28xx and 29xx support 64G, so accept 0x07 on those adapters while
keeping the legacy filter for older ones.  Also drop the duplicate copy
of the check at the end of the success branch; it repeated the first
assignment with no intervening change.

Fixes: ecc89f25e225 ("scsi: qla2xxx: Add Device ID for ISP28XX")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-46-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>
[ Omitted IS_QLA29XX() checks because this branch lacks 29xx adapter support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 771b323a51942..500d4d40beaa9 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5643,7 +5643,7 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
 		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -5654,8 +5654,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
-- 
2.53.0

