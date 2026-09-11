Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D54A8FC6
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146981; cv=none; b=h5Xn2lwPenIlMfxVTWJMyTuZ+NF7F2Ku6kLlUWoa4/oQUJG4N7tJU7zD2gk1fJomVbiHsoBzav3ZF4P/+/ETLcmksMoZ6O73jxeYPbLRQxYZWQJjeYv/mlPS45kPe35EeMViDap7OjA8GEWtsTXGTMshb6h5wEddUoQtitN5vMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146981; c=relaxed/simple;
	bh=HhDvbAk4IZydtuw4BxWDM7iMTI5IQN5czJMFcX/W9v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgShLP7HYqtim1fc139/RuC2bqRanRIhtUOqHGKEBDYjLbjTn8Fak8yF8Z58Kzlmsd8YUkXpF1CwPL91cEPxHvtNURHqhfEkuW5C2EFlLpILd0KUW7btFmq/giZcd0YSZCV4n6/O5tXoqkvhRMAareazLp+Z7eE0vBjd5TisxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpA5+OWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpA5+OWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430091F00899;
	Fri, 11 Sep 2026 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146976;
	bh=fV5ZnfSK3AFK9Au73LuyzrWv99EdZ/bt11v4GPQ50SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cpA5+OWFezXt4IX4mTe0NdR8+xiPeq6LOaYL9YB6E2tDr7YkNSR8+7vWjvSAW3fPY
	 +tp5crIAkK77tKQBJpCzdYFaJI3/IkJLbXEZpQpx7QbGqGjN3o1hCrZ0HJXCTWpplk
	 liUasThW3GDE5hyvHRzMHKW/AsW1Q95dpmtTvNSWWV6ecqyCeQsvAWsY2O1MoPYLA8
	 N+JU3ViQ/g/6LdmioiwA89s8H+kGRD8FjX6qHrrJVsnQJ6alN3/cA6hJyVxIhDcAob
	 PupThihrdqke+hKqMC/gcJFzUBywcf5jEz2xyR9o9KLW1z4usriDBPhtjhOCcv7IDI
	 xZALw3L45rPnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Fri, 11 Sep 2026 13:16:14 -0400
Message-ID: <20260911171614.1216747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090959-camping-drown-7807@gregkh>
References: <2026090959-camping-drown-7807@gregkh>
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
index 41435e98092a8..dbe84fa47aaf4 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5649,7 +5649,7 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
 		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -5660,8 +5660,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
-- 
2.53.0

