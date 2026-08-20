Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E842DA3F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225848; cv=none; b=usBQS26HaIfmt2Jf1/NdDVf7vpI1gLMd1oNFKZwAuy8/p0pSzelb1+8xoKP++jFBz/CNeAcHBHZlV9sHlYU9PG2QWWAL8ByO0rA+E7EAfm9CbH+/FIGa42XgKZugAI4sJhYQdU6Wo89gTY8GkfYpsCwEh1krXwmyWmZuE0piALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225848; c=relaxed/simple;
	bh=BA6oz5wcpayHUluOep6fe2SPnUci84luACSIziikSM8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Bi59EnbceoHMTWazIAoAcUoh1NAGubSXw33M3WtsILQ1H96/VZ7ZKEK+JTt2VAbhjYSUux6b5HHKQ92rngTyA+KcRpm9xNeM1GPcONRZqeqp9vEy4dwBsz093pQx99mVW4HdLBR45Q8tLM9pHbBSTLJm4ms+MdZUpd+ys4BbRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcDQdD9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcDQdD9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305641F00A3A;
	Thu, 20 Aug 2026 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225847;
	bh=GQo7qdZyT7tCqJEmEdwWL33NBiaSxtk6tTFEv5EBAlA=;
	h=Subject:To:Cc:From:Date;
	b=LcDQdD9konSjdsXgL+LAvPgXbZ87RvenkbfZ8o2KANRkQc5YTQq0IsFIRUP/p/5pj
	 oD/31DUmShOJ3cTKvcNvhMJjYmk16yw6rliGkwCJ+LI7rIYBJYg0w3mTxSq16qKu56
	 XQNs0LuLp34iJPtar56B+HgY8GVYUxMhl/E1NRtQ=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Ensure index for read/write regions are within" failed to apply to 5.15-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,cohuck@redhat.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:22:55 +0200
Message-ID: <2026082055-bakery-eligible-c6f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9f5f9a78fedc45bc29d6a0a64e3a3472361afae5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082055-bakery-eligible-c6f8@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f5f9a78fedc45bc29d6a0a64e3a3472361afae5 Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:18 +0200
Subject: [PATCH] s390/vfio_ccw: Ensure index for read/write regions are within
 range

The introduction of the capability chain rightly clamped the
region indexes to the range of the capabilities itself, but
neglected to do so for the existing read/write regions which
should also be enforced.

Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
Cc: stable@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 420d89ba7f83..4aff0b58fa5d 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/vfio.h>
+#include <linux/nospec.h>
 
 #include "vfio_ccw_private.h"
 
@@ -24,11 +25,20 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_to_user(buf, (void *)region + pos, count))
 		ret = -EFAULT;
 	else
 		ret = count;
+
+out_unlock:
 	mutex_unlock(&private->io_mutex);
 	return ret;
 }
@@ -48,6 +58,12 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
 
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret = -EFAULT;
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 38c176cf6295..f3015132d4b5 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
@@ -26,6 +27,13 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
 	if (cio_update_schib(sch)) {
@@ -97,6 +105,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		list_del(&crw->next);
 
 	mutex_lock(&private->io_mutex);
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
 	if (crw)
@@ -109,6 +123,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 
 	region->crw = 0;
 
+out:
 	mutex_unlock(&private->io_mutex);
 
 	kfree(crw);
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 45ec722d25ea..032a1cdf4df7 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device *vdev,
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->read(private, buf, count,
 							ppos);
 	}
@@ -295,6 +296,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device *vdev,
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->write(private, buf, count,
 							 ppos);
 	}
@@ -338,11 +340,8 @@ static int vfio_ccw_mdev_ioctl_get_region_info(struct vfio_device *vdev,
 		    VFIO_CCW_NUM_REGIONS + private->num_regions)
 			return -EINVAL;
 
-		info->index = array_index_nospec(info->index,
-						 VFIO_CCW_NUM_REGIONS +
-						 private->num_regions);
-
 		i = info->index - VFIO_CCW_NUM_REGIONS;
+		i = array_index_nospec(i, private->num_regions);
 
 		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
 		info->size = private->region[i].size;

