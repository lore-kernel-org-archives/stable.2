Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B83E44E0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140813; cv=none; b=hz2iJ/QuvpGgZ9JNkmezNYvJXWzDaDzeZ3DSHUp0f92rqQ5YbV00bM8pmF4RgXLOXr+fWOMB2Wsm9pd5kQkdwu6BTUK6twWiiHCAL02xGXIhCETMPds+8MbuGKhIJbBAOVe+QpTEOMMW+V92riDItixZoZl2F7IsXLvm9mkwOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140813; c=relaxed/simple;
	bh=HhDvbAk4IZydtuw4BxWDM7iMTI5IQN5czJMFcX/W9v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbHWUIq+/nwZT1jKZ03ub5Vn4I2xdth1Z63wnQThJskUsgt8C+hRefJfmm63IJJ8nF1VsxKacAP8plYa6yDofXXTuVSAlFZ358Sj1fPx4dcFMK8nh7bmn0eEEa70GdV57UMqTKAgUxGkfuDG2GVBoYGbVPPJvjdBKjNpfEM5uAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0+cW0qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0+cW0qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808BF1F000FF;
	Fri, 11 Sep 2026 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789140812;
	bh=fV5ZnfSK3AFK9Au73LuyzrWv99EdZ/bt11v4GPQ50SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0+cW0qyqhozSXZ9l6g+ZZ6O1zLVuVO+dKaKCX00OLI9/id7oIfK/o4QSWsWdXo7s
	 J+h3dD6Xbh0GVl+q2NO/fubcYGAcXqxgaDINYgwsZu9KDJv9LgSoXO4zAAf3vM0M8c
	 2ETMQpLTSTw8QysO6En7WUNMzEgTggPxCuALx1MGOrcQ8inGggPuQxtNsJAmofq/nZ
	 LEGsS08RdWXcbcOG1sdUv3tQgARpyMgx9EQYRbCSr/IqZ5u2eMNrfPomlThYbpfNjh
	 EFdRCP66DbwrgQBmygVUbXN7Rt3L95YshvFofYYoz6yXrT2GlwbT+Y0wUNq2F8d9Sy
	 K9klr28wV/7CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilesh Javali <njavali@marvell.com>,
	Hannes Reinecke <hare@kernel.org>,
	"Martin K. Petersen (Oracle)" <mkp@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Fri, 11 Sep 2026 11:33:29 -0400
Message-ID: <20260911153329.1096658-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-bullring-trodden-a963@gregkh>
References: <2026090958-bullring-trodden-a963@gregkh>
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

