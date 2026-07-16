Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7141B8C6
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201850; cv=none; b=Up34Nd59xS5ZUp/btXU4LTAmRlAm/BYHAqwkivFLhykQpdLQk/vYsYu10UCyCQQqxFlLXMyvLavW9QSaPKUqPF7ookJku7G6sthJoRjTDMwo7Q+poU+Po6MTyw65QxLsHmR+Bai7QFKhvnWrOEkgA7SE6Pv4hH+uvkDQxy86LO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201850; c=relaxed/simple;
	bh=OhQIL5IyiGFto5iEcYHNaLiQpGhcQX1LdtDORD/Hi2I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uWa6NpeXriLnE0WFuM5otH5HFT+SFpxlraAeBc6JG1OD/7X9h3eVKPU0CZ1MZxZFlgCuuwk7u7ntsD5hP9Ybq7NwTK8StFpsKXrEp8Frmzp16Fq9decy6Q3GBCf5WSH5SGfyZYGmSGpKAvK/g4fIxqAEJOnqbJ3kjQjuyOlwSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z7LdH89K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z7LdH89K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFCE1F000E9;
	Thu, 16 Jul 2026 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784201846;
	bh=grtOWc3mYp1oAPKz04oKX4UT9ISHmsX8U+48F6RlMsI=;
	h=Subject:To:Cc:From:Date;
	b=Z7LdH89KG116jmifjbUhxGfTniznHckfDOH23mH5ocP8aDy6XZ5LvTIHWXXno0b7s
	 27QLiZZEL8u4SNrhxZfByjgfu9f7EtrkofqEXWAeIe6vAd8f5RoC/+zH5x3bDzWUpb
	 ASXlT2T1cWC09M1I4PxE4scvbuZfXakkMWoKjbFg=
Subject: FAILED: patch "[PATCH] iommufd: Avoid partial fault group delivery in" failed to apply to 6.12-stable tree
To: nicolinc@nvidia.com,jgg@nvidia.com,kevin.tian@intel.com,praan@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:37:19 +0200
Message-ID: <2026071619-canning-snowdrop-2a4d@gregkh>
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
git cherry-pick -x 091ab6d70dc444f56ed14faedbcacfc979f4c613
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071619-canning-snowdrop-2a4d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 091ab6d70dc444f56ed14faedbcacfc979f4c613 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Mon, 1 Jun 2026 13:42:37 -0700
Subject: [PATCH] iommufd: Avoid partial fault group delivery in
 iommufd_fault_fops_read()

The cookie returned by xa_alloc() in iommufd_fault_fops_read() is per fault
group, but the inner copy_to_user() runs per fault inside the group. If a
copy fails mid-group, xa_erase clears the cookie and the group is restored
to the deliver list, yet done is not rolled back. The function returns the
partial byte count, with the successfully copied faults sitting at offsets
below done carrying the now-erased cookie. The next read() then re-fetches
the group, allocates a fresh cookie, and re-delivers every fault including
the ones already copied; userspace sees duplicates carrying the new cookie,
and a stale cookie that can never be responded to.

Use a local group_done variable that tracks the per-group progress inside
the inner loop, and only commit done = group_done after the inner loop has
finished successfully. On a copy_to_user failure the outer break skips the
commit, so done remains at its prior start-of-group baseline; the partial
bytes already written past done are undefined to userspace per the read(2)
contract, and the next read re-delivers the whole group atomically.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Link: https://patch.msgid.link/r/360cab4d4aeccb0bae275a970e2b3c340a71e0e0.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 1c010e691f97..5129e3bf5461 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -139,6 +139,8 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 
 	mutex_lock(&fault->mutex);
 	while ((group = iommufd_fault_deliver_fetch(fault))) {
+		size_t group_done = done;
+
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
@@ -160,16 +162,17 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			iommufd_compose_fault_message(&iopf->fault,
 						      &data, idev,
 						      group->cookie);
-			if (copy_to_user(buf + done, &data, fault_size)) {
+			if (copy_to_user(buf + group_done, &data, fault_size)) {
 				xa_erase(&fault->response, group->cookie);
 				iommufd_fault_deliver_restore(fault, group);
 				rc = -EFAULT;
 				break;
 			}
-			done += fault_size;
+			group_done += fault_size;
 		}
 		if (rc)
 			break;
+		done = group_done;
 	}
 	mutex_unlock(&fault->mutex);
 

