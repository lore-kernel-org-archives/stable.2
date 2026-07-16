Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A600D412C07
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201823; cv=none; b=u1uHzd+xIGOdothhAkm3wbvLrtJy4XRBMRSnPNiMed01eJ5Z9kl3Beg0lTLaFgw3/7eZl8cDZX0mDjZ5uP4ARPCQMJwoic+K5Xk+D/cIv/bDRw9lxIzH9Lm0FdMDf1FiN5JFwt/KJTKU0fO7eSLjbNNtJygvw/bSR/lJwdZWsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201823; c=relaxed/simple;
	bh=9DMiaDjiNzF2dlYUYp3x0NeNb8kHkmmGkWUG4/8xOk8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hygstxakoBFaMDpb8VVUC+JfzOUt3/vKFCMwydOQsaMc5Nti1HMheuUME4Z5QBK/9Ro/0SDVOiHDHfkQqoNqe/k2lijdcYwu2M3b+GAX87CPuZVYpCGkOg/sH4bJ+wa+w2m3YPOzy17iowOFgioe+O9QgopzphSNNn1QL+gm+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0bl6Vlyw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0bl6Vlyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEA41F000E9;
	Thu, 16 Jul 2026 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201819;
	bh=CppjcZpHhqh+yXr0ORh86qfxki0kbD+0V7jEd7pbrbk=;
	h=Subject:To:Cc:From:Date;
	b=0bl6Vlyw7ayZI1ouo8FAqjjI/kCJkNf6lHyTRR8AabKJXq/PFGA/+mV8398bbDwxz
	 SWA5sJgSbBnAbWOFvAb2zVI0uqOAXaJdTIo0FaiPN9CKqD5MbFKWWBmEuLzQux0nGt
	 sgeIDIZpLZhs/7KSbBu0Urr9sOHhq1ZO+5XviLOY=
Subject: FAILED: patch "[PATCH] iommufd: Propagate allocation failure in" failed to apply to 6.18-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com,praan@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:36:52 +0200
Message-ID: <2026071652-safeguard-secluding-f2b1@gregkh>
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
git cherry-pick -x 489e63dd120bad52eba63f5506c214750cd5bc75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071652-safeguard-secluding-f2b1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 489e63dd120bad52eba63f5506c214750cd5bc75 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Mon, 1 Jun 2026 13:42:34 -0700
Subject: [PATCH] iommufd: Propagate allocation failure in
 iommufd_veventq_deliver_fetch()

When the kzalloc_obj() fails in iommufd_veventq_deliver_fetch(), it returns
NULL, falsely advertising to userspace that the queue is empty.

Propagate the -ENOMEM properly to the caller.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Link: https://patch.msgid.link/r/25d29feac909e36f78c145fa99ef2d4cb7a415da.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index ac485d010a43..f55d173c59f6 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -264,8 +264,10 @@ iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
 		/* Make a copy of the lost_events_header for copy_to_user */
 		if (next == &veventq->lost_events_header) {
 			vevent = kzalloc_obj(*vevent, GFP_ATOMIC);
-			if (!vevent)
+			if (!vevent) {
+				vevent = ERR_PTR(-ENOMEM);
 				goto out_unlock;
+			}
 		}
 		list_del(&next->node);
 		if (vevent)
@@ -315,6 +317,12 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 		return -EINVAL;
 
 	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		if (IS_ERR(cur)) {
+			if (done == 0)
+				rc = PTR_ERR(cur);
+			break;
+		}
+
 		/* Validate the remaining bytes against the header size */
 		if (done >= count || sizeof(*hdr) > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);

