Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCA52BE36
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953028; cv=none; b=iG0shgRJVHY7yLAkTIs6ITt0sV/38zcXyzckm1kuQcVifWlmF7dowYkJqqOh9qDsXmuWLelH9iRj40odsF84sZh19FcYb6kp6ZlBboP9Pr25o0G0wZgm2UDz9SjwN+oYkMGooG5M800sT8hrKIhmkmfq3gAiyqF2Iw6tclp650E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953028; c=relaxed/simple;
	bh=xCFZm5gxPRX1J4yfMhrf+NPGbuE3FvniQwLrZdXTR0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bzdcx8yPUXq6J9u5nI8HDOoTSFOzkMB3MZh9bDMn5YK/5M7LDjexpUkvmjycEK+I4nhuiCqZs7XE3q4D19d2evJoqI/IGi2go/yb7bOXdZD9HYmdTJ76+vGj0tAP0jwNPNVpQFTx+1MOrULeQzgTRXiBncCAvD4EwG4PwjPGucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=npTrbFQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="npTrbFQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E221F00A3A;
	Wed,  9 Sep 2026 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953027;
	bh=nUY+XVdsmDLAJncjm4hoB+1Wdg9qb3ZcORy8zxoR2yo=;
	h=Subject:To:Cc:From:Date;
	b=npTrbFQmkqQjfVXNfKJmbdC6yneLfF44LOM4M4BZYGsX5UjlAqlrapu5yURMmrAyC
	 vcRolkCoQDghWstRZuGJuRCzipnQewmGQZfDeQbU7svaHtgWvKOc4C6PUkZBjxTmU5
	 /vbtGpH2YgOumeNCqMGm6utJ0wftgqRraqYhZQX0=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate" failed to apply to 6.18-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:14:58 +0200
Message-ID: <2026090958-palpable-backyard-4a40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 52fba32317ee631faa878725b2f7cd5c08acacd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090958-palpable-backyard-4a40@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52fba32317ee631faa878725b2f7cd5c08acacd3 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 23 Jul 2026 10:34:02 +0530
Subject: [PATCH] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate

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

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index ba822c196894..b32ca8ed274d 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5785,10 +5785,11 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha) || IS_QLA29XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
-		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha) || IS_QLA29XX(ha)) {
+		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha) ||
+		    IS_QLA29XX(ha)) {
 			if (mcp->mb[4] & BIT_0)
 				ql_log(ql_log_info, vha, 0x11a2,
 				    "FEC=enabled (data rate).\n");
@@ -5796,8 +5797,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;

