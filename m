Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4BE531AE8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953182; cv=none; b=R+OTsuTM7Fe0KDKsRoNPsn+iuI7PBlqdMRqUIiQo209lHcEuGHMM6qAZNJ1MO4fcWTSwuBnlw7p9eV56+MKlm8zGGJdakxARbrPGpCmfaXzGkBq4V52aYJL3TmHyOMmlxZt3PPgN8kDeYpIObooIfoh9LbAgeq5RBogUOatPefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953182; c=relaxed/simple;
	bh=tp24Y7rSBNDLIJjySXZWraYxlKneVA4o14aqjpjuFl0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gwckqd2y10GLPJdoi5o6pRVIvvjTFg/vLqd9SHDr0qJulEOLb+r0yK2fHtlrQDTd2wGaGBwVAHw/D50zyR7PdbQXUEHotoa5X8Q6bfX0DmIT1ZZXtrWP93T7uNWMrfIqDWiUPTA2KCNuwWT5vIBgA9SV/urs+92AkbwkTvpMdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LCMFQnks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCMFQnks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AA61F00A3D;
	Wed,  9 Sep 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953180;
	bh=pkVsloxBlFNu+04pMc6RAsu6r9JGCFefq2ap5zVYDPo=;
	h=Subject:To:Cc:From:Date;
	b=LCMFQnksvJMrkjRMu8mzMDJP7QQSPRy7g193hrUsLZgJ3lic7cfmR58rMFQfufOdK
	 LXKNddP++zZ5CJOESrVuFug95mUcDdGaZ0HYWzwRFcsnTtFY+veZYDHYe8QiyWPBat
	 BPWXoMvSLsz9suA3YPDH4XvquVizJYa5nttvoeFI=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Skip vport under deletion in report ID" failed to apply to 6.6-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:18:51 +0200
Message-ID: <2026090951-unsure-mule-162a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 23582731afa35031c94fadb71a4f3b4afd094649
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090951-unsure-mule-162a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

