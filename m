Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CA438021
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580360; cv=none; b=RIbnTKgxnwjVasiJ3bx0qqxVa2RCqKIXtoeLoNYT42chEcivTkIyZiv1GC4k606bWT56zmR4lC+j3utYJCLP6VNhlzfXQkMINjXkB/5dLJpA/M3HEAruP3c4R+Yk4xvCp5X/tZmg7H745yo3ZrZdrwhGcJ/0+EEce5p7uvBFWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580360; c=relaxed/simple;
	bh=kWvncc31S4SR7fHGyT1WL6TMO9gPNiXOAkVf+Rzfco4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMjgjzxA+df/AKIzxJvkwK5h3oNi87UvTR3362Ct/9PSX+fixKbNFUNtXIcEGJ5oFjNVAKhga+a+70rCM3T64WjwmcKy9MplXhCJpvqBpXQJwEEA0ZT1XbWKJL402RSdnKNKCrgyqmKLutEl+H5UKMzs5alhGf0GG6gXeuxznjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQfHy8zK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQfHy8zK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789881F00A3D;
	Mon, 24 Aug 2026 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580359;
	bh=eOMVGO/Ec6hR2pLZMClOXqrRelsXmK4FsKCzqOcpxa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KQfHy8zKvDtdLoJ7wHd3FCB8eayM5MvkuWiaOQ0D+AGbj8FInWGRa38Qt4H2C+M3z
	 wbMwscxZ0SUjfoh3567HaNRy9AlXQ+Ai8fhkRpZsHDHICtepK2fe+Vtoyl/XaQHfzs
	 7iiPEF/Rt1JhtlwyaPHgUvVMFG+3s3inOeUOBzrRtdprCYMRmP7za/GNxI/C77XuP8
	 b55f384XAFHQJ3SovfAAzi1weS4Avkl3dVNgu5N/fQfOrr9APIGX39KuGRvtHby6Ez
	 AUVZq5IA7yCveZaulBI16aCflolKSEg3Xg9IPNIA9B8UhCIxRjthMHvPu/+N6SNeW4
	 pT7PxFzRGwWCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] s390/vfio_ccw: Selectively expand io_mutex
Date: Mon, 24 Aug 2026 10:05:54 -0400
Message-ID: <20260824140555.3097579-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824140555.3097579-1-sashal@kernel.org>
References: <2026082011-underarm-plywood-1b0f@gregkh>
 <20260824140555.3097579-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit 34f4feff3e90bd09308fad0974e97113b23b812a ]

The io_mutex was defined to serialize the io_regions, but then has
also sort of been associated with the I/O themselves because of
the close relationship they share.

With the handful of races that are possible, the choices are either to:
 A) expand the scope of io_mutex to close these remaining windows, or
 B) reduce the scope of io_mutex to just io_region, and introduce a new
    lock mechanism for the remaining I/O resources

This patch implements A, since B brings with it a lot more interactions
that would need to be tracked and kept in a correct hierarchy. It also
takes advantage of the workqueue element for cp_free() that now gets
called out of fsm_notoper(), which could be invoked out of an interrupt
context and thus cannot acquire a mutex itself.

Fixes: 4f76617378ee ("vfio-ccw: protect the I/O region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Stable-dep-of: 16b0798024c0 ("s390/vfio_ccw: Implement a crw lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 2 +-
 drivers/s390/cio/vfio_ccw_cp.c      | 9 ++++++++-
 drivers/s390/cio/vfio_ccw_drv.c     | 4 ++--
 drivers/s390/cio/vfio_ccw_private.h | 3 ++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 11264e2adffcb..ee9688738a950 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -97,13 +97,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
+	mutex_lock(&private->io_mutex);
 	crw = list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
 
 	if (crw)
 		list_del(&crw->next);
 
-	mutex_lock(&private->io_mutex);
 	if (i >= private->num_regions) {
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 4da85df9f7816..2b7e32f7ef9be 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -16,6 +16,7 @@
 #include <asm/idals.h>
 
 #include "vfio_ccw_cp.h"
+#include "vfio_ccw_private.h"
 
 struct pfn_array {
 	/* Starting guest physical I/O address. */
@@ -852,17 +853,23 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
  */
 bool cp_iova_pinned(struct channel_program *cp, u64 iova)
 {
+	struct vfio_ccw_private *private =
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	int i;
 
 	if (!cp->initialized)
 		return false;
 
+	mutex_lock(&private->io_mutex);
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
-			if (pfn_array_iova_pinned(chain->ch_pa + i, iova))
+			if (pfn_array_iova_pinned(chain->ch_pa + i, iova)) {
+				mutex_unlock(&private->io_mutex);
 				return true;
+			}
 	}
+	mutex_unlock(&private->io_mutex);
 
 	return false;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index b9091e22ca572..3678c3eed19b8 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -93,6 +93,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	is_final = !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	mutex_lock(&private->io_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
@@ -100,9 +101,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished = true;
 		}
 	}
-	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
-	mutex_unlock(&private->io_mutex);
 
 	/*
 	 * Reset to IDLE only if processing of a channel program
@@ -111,6 +110,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	 */
 	if (private->mdev && cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
+	mutex_unlock(&private->io_mutex);
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index b2c762eb42b9b..9b13b41e3a9cb 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -74,7 +74,8 @@ struct vfio_ccw_crw {
  * @mdev: pointer to the mediated device
  * @nb: notifier for vfio events
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
+ *            and @cp lifecycle
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than START
  * @schib_region: MMIO region for SCHIB information
-- 
2.53.0

