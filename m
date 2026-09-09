Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1152E062
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953020; cv=none; b=AK0YSRxFdR0eoRd1dvfWJXIZ574Nkw20JEpV9KCxLTysQj/uKcMXSRTbu8Q8fq26eJt2aLQ0eIIaQ9QFYZ/+zf3BFKLThy3JUko/eIhHTPMc/ljTQpTKFgzde++yvZtgB3RnKE07Y71A8eYUv1xXFXwnLKbvxPa1eLdNW3YhUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953020; c=relaxed/simple;
	bh=8rDqSie2nso3ZbeDU9xBDRAL3nZ5gkmx9HZGWS2Y1uE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o7uOOVOyXHLrzP7EV3YoOf3V06XPiGYTHjsjoo5gDSrnkeRh8Y/pNgZMWMksGhzBJA+nuIMzxZ67dENvW7gfLTGIx1vF/hT+1+XtktWZ51n7+CdIOQpFd8bKlq+y8y194XkvRlfwtdf99lkJT9Q1L8OuM0a4ZUtjX0bL/lfDySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1oyQdOQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oyQdOQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EC11F00A3A;
	Wed,  9 Sep 2026 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953018;
	bh=iBnqJJSV4oKjp/s25P8hoyffJbbgbTSsK+3k7jB5Lxg=;
	h=Subject:To:Cc:From:Date;
	b=1oyQdOQIQix2deWCixDRDVZtMcvOFfWaAqfsMgewnEu0G1TAqAgzD7Asbx5aPsFfZ
	 oDE07pRrJNXt3ITUfWUkWOD1s3rjeGO6LGdxEfgBPKcKzgqzB5+BOTEvRx3QlHaben
	 /zqhB1DPfdoxKSdPNOYtGLrfHZA2km5EI6rGmGEg=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started" failed to apply to 7.2-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:14:21 +0200
Message-ID: <2026090921-shiny-wired-026c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x f7e46ebffc5781aab3f1f5a5d4350addbb5833f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090921-shiny-wired-026c@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7e46ebffc5781aab3f1f5a5d4350addbb5833f4 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:30 +0530
Subject: [PATCH] scsi: qla2xxx: Skip NVMe LS reject IOCB when FW not started

qla_nvme_xmt_ls_rsp() bails out to the out: label when firmware is not
started (!ha->flags.fw_started), but the out: path unconditionally calls
qla_nvme_ls_reject_iocb(), which ends in qla2x00_start_iocbs() and an
unconditional doorbell write to the request queue in-pointer register.
This rings the firmware doorbell and queues an IOCB that stopped or
resetting firmware cannot consume, and touches MMIO during the reset/EEH
window where fw_started is also clear.

Only emit the LS reject IOCB (and ring the doorbell) when fw_started is
set; otherwise just clean up and return. The post-allocation failure
cases (SRB alloc / qla2x00_start_sp() failure) run with firmware started
and still send the reject. Apply the same guard to the reject emission
in qla2xxx_process_purls_pkt().

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-26-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index fc8a344ec7d8..28a04e0ff660 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -441,9 +441,11 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	a.vp_idx = vha->vp_idx;
 	a.nport_handle = uctx->nport_handle;
 	a.xchg_address = uctx->exchange_address;
-	spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
-	qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
-	spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
+	if (ha->flags.fw_started) {
+		spin_lock_irqsave(ha->base_qpair->qp_lock_ptr, flags);
+		qla_nvme_ls_reject_iocb(vha, ha->base_qpair, &a, true);
+		spin_unlock_irqrestore(ha->base_qpair->qp_lock_ptr, flags);
+	}
 	kfree(uctx);
 	return rval;
 }
@@ -1321,9 +1323,14 @@ qla2xxx_process_purls_pkt(struct scsi_qla_host *vha, struct purex_item *item)
 		a.vp_idx = vha->vp_idx;
 		a.nport_handle = uctx->nport_handle;
 		a.xchg_address = uctx->exchange_address;
-		spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr, flags);
-		qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a, true);
-		spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr, flags);
+		if (vha->hw->flags.fw_started) {
+			spin_lock_irqsave(vha->hw->base_qpair->qp_lock_ptr,
+					  flags);
+			qla_nvme_ls_reject_iocb(vha, vha->hw->base_qpair, &a,
+						true);
+			spin_unlock_irqrestore(vha->hw->base_qpair->qp_lock_ptr,
+					       flags);
+		}
 		list_del(&uctx->elem);
 		kfree(uctx);
 	}

