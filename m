Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F41E4A99B3
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149806; cv=none; b=cN5lcTpwIgAOYQR5i4Md8+sTDPAxptW1SnqBL6OOnXlU+vCAJQzKijzx+D3ro1lH1xVrmIxfAsU4lVdGXeiSIm+HQTf41+8ViNzkdeec+mX4TdaKnlEp9V3LgZGyly8XKMBn4RG7xiiJv3nWBvQSeAJ38szS41XRD3kj0tQG6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149806; c=relaxed/simple;
	bh=d01Y20NwP/FUv6Ie576je+f/MRT9W4jLMeHHYAb1qkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBkY1aCouVvcOPWJ9xJ2ANFkPYwQDpb4ONIcZ1+tOxen0lcsDHHhcCEzdy/ws8WwE8ixJSx1YhLpKGcSgDcudZwiOSWu29SBAEWl9rqt54V+7yiSgeUeJd1VQ4W2BL0sWB6Pldpiqhp7A3p16jWxLqyHKbYcdWYWRXO7UmvyQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBY1zXbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBY1zXbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373761F000FF;
	Fri, 11 Sep 2026 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149804;
	bh=dsbquzkiqqls0P4I0hBfTz9TlMWcHiJJ/6QOn7TGfkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBY1zXbYxDJaF+rxp1jYvUN0sS/q1TU230xk8tq/rAfyfk7lIVclUgSDw1DXvirDH
	 w6OsHAL7F9UA7CWu2kgAO7ARgLS2nxFVfI4r+p4iPT4HwtoF8AbyRLAKIEzoX2V9MK
	 SFX2nvc265YVJfHPItMSQxj/BpYtX7gJp1gORAH18sVjy6uyB2CZu61N8qt7sHg02x
	 +CW2mXcL/NSjWTOIqxwX/Q8R+ZTHLzgh1LXY/aTXEPCfGZcKYoWcsz2kj8cdPiizjM
	 p3QLNTg9hVN/YASS+Xfo50BDA1rsCYq8MT2iL6iC2GFotBcy2TUDm6fk0w0PkBV8sX
	 ZGNWsgmzPQsUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Fri, 11 Sep 2026 14:03:22 -0400
Message-ID: <20260911180322.1292470-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090900-collie-ecologist-bee4@gregkh>
References: <2026090900-collie-ecologist-bee4@gregkh>
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
index aa6a68e235c9d..61d0c221f0b40 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5566,7 +5566,7 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
 		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -5577,8 +5577,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
-- 
2.53.0

