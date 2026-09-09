Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFAF4C8FE6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953068; cv=none; b=YdDpazpttNJDWOZRrGnv2Yn30yrzIE9bRLe4Wnm2+Fc90/+YipfRdilJTi2D2oaPHJQZ4zwMOaTwJYARUNTcSTgXKKIMv9OjlV6BMttwRoctUKXk7mmyRbAWkzl4hrlUZm4hqVd/DHbt45Xh8FDEJnDrufcwjJoPJ8gTAt4kADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953068; c=relaxed/simple;
	bh=xqL0iNlp24sk4KNN1sMtJz6ds0PGN4YT2QzqRm7Btps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fzlo9avNE6WqeoipVSmw04CrbAtXGqk5GM4ch/8znhSshf92Yh0G6EpuqSc2rAEJS8XTwFseE3st1Y8nTZ4X5evtn6sEmIfRi2ADEicbHukoTCL0k2WePQCSG9puT6yDEwm0YcKI2UYUCXWwf8DX/nWEQ0vvdzFD38CS82AJueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W0pgv9X1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W0pgv9X1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CBE1F00A3A;
	Wed,  9 Sep 2026 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953066;
	bh=4ifHAZ57wATCenqpc/nqF7FTyOtxeW2rCvc4DMXyyvU=;
	h=Subject:To:Cc:From:Date;
	b=W0pgv9X1Yh/hIbn5+PLAu3ysi/4zgpNJGmtNzaF/O3FLLQbw+/HM0x7yPKy4E/mz1
	 HpqM4St/1p2zFoUMlLGEuLvk6xyIVX+/OPx+GGInlMfLbeaNOB2ZxGnHiMhkjKrrKg
	 pzFZQ273zYXtC9RTSAH9PrKpPb7WAxavxIzAjhYU=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix BSG job leak on validate flash image error" failed to apply to 6.12-stable tree
To: njavali@marvell.com,hare@kernel.org,mkp@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:15:45 +0200
Message-ID: <2026090945-scoop-equator-81a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0fb52cc632464b0cd07f970341330466d772efe1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090945-scoop-equator-81a3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fb52cc632464b0cd07f970341330466d772efe1 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 23 Jul 2026 10:34:11 +0530
Subject: [PATCH] scsi: qla2xxx: Fix BSG job leak on validate flash image error
 path

qla28xx_validate_flash_image() returns QLA_SUCCESS (0) unconditionally,
telling the FC BSG transport (fc_bsg_host_dispatch()) that the driver
owns and will complete the request. But bsg_job_done() is guarded by "if
(!rval)", so on the error path (rval == -EINVAL) neither the driver nor
the transport completes the job. The request dangles until it times out,
leaking block layer resources.

Commit c2c68225b145 ("scsi: qla2xxx: Fix bsg_done() causing double
free") added the "if (!rval)" guard to a batch of BSG handlers. That is
correct for handlers that also return the error code (the transport then
completes the job once via fail_host_msg), but this function returns
QLA_SUCCESS unconditionally, so the guard turned a correct single
completion into a leak.

Always call bsg_job_done(): bsg_reply->result is DID_OK and the error is
reported in vendor_rsp[0], and since the function returns 0 the
transport will not complete the job a second time.

Fixes: c2c68225b145 ("scsi: qla2xxx: Fix bsg_done() causing double free")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Link: https://patch.msgid.link/20260723050413.3897522-55-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 4a9cf8da67a6..76c57e574c22 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -3796,9 +3796,8 @@ static int qla28xx_validate_flash_image(struct bsg_job *bsg_job)
 	bsg_reply->result = DID_OK << 16;
 	bsg_reply->reply_payload_rcv_len = 0;
 	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
-	if (!rval)
-		bsg_job_done(bsg_job, bsg_reply->result,
-			     bsg_reply->reply_payload_rcv_len);
+	bsg_job_done(bsg_job, bsg_reply->result,
+		     bsg_reply->reply_payload_rcv_len);
 
 	return QLA_SUCCESS;
 }

