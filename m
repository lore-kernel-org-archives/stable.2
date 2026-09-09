Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B34AFE37
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953179; cv=none; b=XmZ4EvIgFcDjd6zuvfynuSIdDS8nqxDRZwYtAWpjhiPA+84ZqHD34nLmjrqSRW4oVXicLYa72AgNZ2EqX/LeBHkzW8VOxqz1G6qKOuTzRW5mfMlAFyX7wZv84HVBQV1Ry5EM/o89A4zKRGdadR0ouaH5Ij6v8aztfXOXXtLYYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953179; c=relaxed/simple;
	bh=Tqz4gWBNyGq6KgjY3FLXZMed7v3RK3h/BkCmGbPC7ME=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ub07P3WJoWw4k2+LVYcPGvr6boQa9r3G0BFdyqYaj2KKKel8KzpvkVszW5+KwcCCDUxXOD+ILRjcgtjdU35iUgY/QnpzGs1bndPm4k8vzi3Fl2GV1v6ebBIcvNtHskemMB5l9JIPpQDCsLmfnNknWYxhW9/o6K1QFdGgapn8XoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ScY1oY8a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ScY1oY8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A981F00A3E;
	Wed,  9 Sep 2026 11:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788953177;
	bh=s1LyNL5WbfonwQQWI10bhT216Sbh1XfJnNZnhwjwSv4=;
	h=Subject:To:Cc:From:Date;
	b=ScY1oY8aE+6Rx0gb8HPpANSUVK5PfcMZLRAqvMU688oEYO++fzF6TD17k+uUCzP+a
	 NWSxXQ++ivlHdhxF+WKSTJAQdBpryswJMJRZ2k5b5Puy8MQwDxCr6oAMp5+p1EFmPy
	 r0zVNIPzj9GWHA77yzI6bgy2h8z7qInfmfjOAHeU=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Skip vport under deletion in report ID" failed to apply to 6.1-stable tree
To: njavali@marvell.com,mkp@kernel.org,sashiko-dev@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:18:51 +0200
Message-ID: <2026090951-daily-sandbag-a20b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 23582731afa35031c94fadb71a4f3b4afd094649
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090951-daily-sandbag-a20b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

