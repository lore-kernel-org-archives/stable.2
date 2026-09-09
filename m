Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255053ECF8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953177; cv=none; b=A4+O8uAAv2HiAzQvpzimrhB+MQrF5E2FG6jOLFaltyG9c0j/lWP2Fo1B9/POghPzDPj1fELgB6A4+mPFmr4+ynP7W9zVBRQz8r8u9DMYkZpZix/DXVLlO9oKKPDNbZLuITy7ecI0rd2XRfNxaz7ahJbvRwTQZ1GAviEt+vZP58A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953177; c=relaxed/simple;
	bh=eab6LYv9iquC8f7IoVAJs4kdEE4Zojm9dH97luL8DCI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Lj8S1iz4v5FOJlzx7vO8+kpB5z0uGBvZy1wZ038Vkc9jAQCgODI++CfBBoRKE5m/Dg9k4/TSp+OTTVCz9mFN0uJ7BICslzGB26uJU/FWsFr6cCsTz9CD94csEF3TVjrELm1XxpawysJ4JWHJ++uBEjYCzceZ35YGOCt3ZxxPTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=perM54Bn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="perM54Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488E11F00A3A;
	Wed,  9 Sep 2026 11:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953174;
	bh=LeHCJTxrAoDJDEG8iBiwZLEPTWHXalHa0Mce3G1E3ts=;
	h=Subject:To:Cc:From:Date;
	b=perM54BnkLREKOC98TlLb32EKIak3I+c/wQFGrC7qTIfkfL+bUhvWZn4mQYeuNIlm
	 uq+CscTWQRcVhO5ifIUV3orxgDHHCe/Ek7jnSavfMFLygtYRwNLDlH8osKJcSLeqVk
	 EeRvFYjmW4jKOtIvGaoslH8O4h/1XTggH7eNR+i0=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Skip vport under deletion in report ID" failed to apply to 6.18-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:18:50 +0200
Message-ID: <2026090950-mower-implement-8f2f@gregkh>
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
git cherry-pick -x 23582731afa35031c94fadb71a4f3b4afd094649
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090950-mower-implement-8f2f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23582731afa35031c94fadb71a4f3b4afd094649 Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Thu, 30 Jul 2026 21:28:26 +0530
Subject: [PATCH] scsi: qla2xxx: Skip vport under deletion in report ID
 acquisition

qla24xx_report_id_acquisition() format-1 handling walks ha->vp_list under
vport_slock, takes a vref_count on the matching vport and calls
qla_update_host_map() to register its port id.

A vport teardown via qla24xx_vport_delete() sets VPORT_DELETE, then
qla24xx_disable_vp() removes the vport from the host_map btree and zeroes
vha->d_id (RESET_AL_PA). The vport is only unlinked from vp_list later,
in qla24xx_deallocate_vp_id(), which clears vp_map[idx] (RESET_VP_IDX)
but does not touch host_map. In the window in between, report ID
acquisition can still find the vport on vp_list and call
qla_update_host_map(); with d_id already zeroed it takes the
btree_insert32() path and re-inserts the dying vport into host_map.
Nothing cleans that entry afterwards, so once scsi_host_put() frees the
vha a later host_map lookup dereferences freed memory.

Skip a vport that has VPORT_DELETE set before taking the reference, so it
is neither re-registered nor scheduled for DPC re-registration. This
mirrors the existing guard in qla2x00_alert_all_vps().

Fixes: 41dc529a4602 ("qla2xxx: Improve RSCN handling in driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-dev@google.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://patch.msgid.link/20260730155838.2119230-22-njavali@marvell.com
Signed-off-by: Martin K. Petersen (Oracle) <mkp@kernel.org>

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index ab5648eb5f20..affcd87893cd 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4268,6 +4268,8 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha, void *pkt)
 			spin_lock_irqsave(&ha->vport_slock, flags);
 			list_for_each_entry(vp, &ha->vp_list, list) {
 				if (vp_idx == vp->vp_idx) {
+					if (test_bit(VPORT_DELETE, &vp->dpc_flags))
+						break;
 					found = 1;
 					atomic_inc(&vp->vref_count);
 					break;

