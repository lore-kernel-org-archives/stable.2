Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4295375F95
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139860; cv=none; b=T083kXg3hqCsFufo/5lpQ+bdM2v/bLWphzAEgUMM5AtWaEE29uMYmdnJoExy1FDaUL3IFBISVU/z0MHqT+fRMCEiRw9Kx95OvWRwsQAbELuk7wJugYMxs0YLf8K/lQnamEepvCQekUIq1VEqfCSiSgQYmYrEeVnT4oi6X8tlFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139860; c=relaxed/simple;
	bh=auD+xV2JLZmWqTbia70U4ZmpHgkgvM4gI8tSrom4D2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw1RgfQR2Uhiocypqv+OJxH1kqqUe1EKfEMJiXY++5iw3GJIqCRb4a3wn713eafBFeKlbCYZPFcwhUdv0ty/9m/3ML1YuvALfL7oSb47dWnNdQsA+5AmCAeY53MG9/NX/ltau39u+eY2powqoYzVV46HET7KzOEimR27PJftEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUC4p1n8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUC4p1n8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39F71F00893;
	Fri, 11 Sep 2026 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139858;
	bh=4VtDjHuope7/MCu4rfSnjsINhUuW44ioxuFucy/8hVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DUC4p1n8Tj0m+2UgO5SoA4TtNUPyATn5RFJ5GV3deUE6lg2fUpE4MILwilngjlTGf
	 LEqn0RnvHofY9GBt/qssM/l/rGBdFtRmNVNDjeXHnVKoDq9hp65AHz6kGrzmOKw6FC
	 NypSsRAt0s9PJo2vU5J1pNRThshCthFzoCUHm9UENvQ7I3zu7AU2/9SsYiNxQyXG0Y
	 qUzyRG/6uHeMOT1zipJ4AHIsqQGcd109nOIvxwMVQkpMdH2TTM/H83NrNKfPRtlhvQ
	 GxHPWdKqw+qKvam3Gf7/neNOAOMqKmFTD+pZqnIbpz1JbePdDcYDre3xRvcrrPYX2E
	 UlbLcQI7SUiQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Fri, 11 Sep 2026 11:17:36 -0400
Message-ID: <20260911151736.1061638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090957-garnish-taco-a683@gregkh>
References: <2026090957-garnish-taco-a683@gregkh>
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
index f604aab8b161e..005588ebfaeaa 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5715,7 +5715,7 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
 		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
@@ -5726,8 +5726,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
-- 
2.53.0

