Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CE453A4F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335789; cv=none; b=oWqpCtrNyxzmF6Zu1Ju+jbX4U9QGVKvv0/DAwIIzqe4aKzGvpykG8pxm2w3I0tgLkNOp4e7QWvcuzOVw34mdlWVEtabe7oRxbanmCjHL6cow8RI8Fm3e3AF6r2Cs+YrjcbWCdSCN5M22O3uBeAugrngXeHCSLs1E/0bHT8oVsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335789; c=relaxed/simple;
	bh=bgjHGXhsoe6tIDDRzunO0L5/VZjO1HAW6tgobW71CnI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=suxgK0pH6sh+Qb2CHQN+1VYwOmvC0S22OqSs28ZGiJYkzX/hAfwBQtRECkMGsZKmxBUhqylnsQSC+EjGxEx3V2qE7lSxqTT+6Dc8WMC3do3BGpM98DRBLwhAxO/L3eVEo/1dYlHXfHZfZcg24pdnL1E1UJwRP44WznmCdvnN7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AhS/6sWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AhS/6sWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50631F00A3A;
	Wed, 29 Jul 2026 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785335788;
	bh=IFgsxEWXMwrb0f8ycaXV/5RF0mwMNFnfpGXwobYyRSY=;
	h=Subject:To:Cc:From:Date;
	b=AhS/6sWmghnNOgWivykT2hu1ZkGs9phSoSfJQc9enoh9Ok04g9varB8OJh6YKSAkW
	 TXPAUkWcll8EhY1xmeSUAc3wJOWbLyX118K6KWXdCRZwQJ9pwuzEN58KUDz98VwNl1
	 x8VrX4L4uYgooCMQ1syq24lu32k0oVn3vDwz7ibA=
Subject: FAILED: patch "[PATCH] ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*" failed to apply to 6.1-stable tree
To: max.kellermann@ionos.com,idryomov@gmail.com,xiubo.li@clyso.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 16:36:14 +0200
Message-ID: <2026072914-recast-scared-532f@gregkh>
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
git cherry-pick -x cee38bbf5556a8e0a232ccae41649580827d7806
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072914-recast-scared-532f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cee38bbf5556a8e0a232ccae41649580827d7806 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 21 Jul 2026 08:20:46 +0200
Subject: [PATCH] ceph: add owner/capability checks for CEPH_IOC_SET_LAYOUT*

These permission checks were already missing in the initial
impementation of these ioctls.  This Ceph allows any user who owns a
file descriptor to manipulate the layout of any file, even if they
don't have write permissions.

It might be a good idea to guard other ioctls with permission checks
as well or even disallow regular users (even if they own the file) to
manipulate layout settings completely, as this may be abused to DoS
the Ceph servers, but right now, I find it most urgent to have setter
checks at all.

Cc: stable@vger.kernel.org
Fixes: 8f4e91dee2a2 ("ceph: ioctls")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 15cde055f3da..de07f19b0caa 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -72,6 +72,9 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 	struct ceph_ioctl_layout nl;
 	int err;
 
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+		return -EACCES;
+
 	if (copy_from_user(&l, arg, sizeof(l)))
 		return -EFAULT;
 
@@ -142,6 +145,9 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	int err;
 	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
+	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+		return -EACCES;
+
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
 		return -EFAULT;

