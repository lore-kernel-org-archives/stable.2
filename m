Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F936F916
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947241; cv=none; b=iCrul4t97e8V6gzDu0nP0fDiMUYRAVo5CGgee8ktdJykSKBOHq7sdZadDw0ZeU5ABxaAfWfD/+XJDhypUDOMlTakjQSViCvcwtjC/gxm5mK114JmigEefno1hN/10wwwCDsMDrGhzuPGu15NAhvyFGs/B3bIr2ygKPyOYL8dunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947241; c=relaxed/simple;
	bh=zcAPeNoB2c7nlKwZb64sEFnRTccGy4XTgV77XYJ0+KA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QxlFF8y72uXUprCPTY51+Ff+tyVoVI205ylNv5FJF3Rc6c+tOCC0PLf30tRz53f3JAFCArsym3NMAP4xDfdUPD/AIzgSPdKKvGknolxsMXpcpU3N6jJwvZ9qV5gDzOM6YkS4XcZoxmTMZJhLqkfOrnKiUc9byP7G6Qz5fhU7Lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tB4X4xCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tB4X4xCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AF71F00A3A;
	Wed,  9 Sep 2026 09:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947239;
	bh=4FXyxw5N98S+X2v3tovKFbaPOKGJz/AwkXXrdZOpCKY=;
	h=Subject:To:Cc:From:Date;
	b=tB4X4xCRddLl5pOqMYr2OND0QBSRxw/rur/5OkWW1KGPijB+oTTEj0Fw1pS6Usltj
	 Iwd/rXhEji4rMlSzmlSrgZjqCUZWutjVyNc3DsjHwROHuCc5NMwEZhwGm6wgWm2URR
	 RiLW44ud8BQC7JSgSzK9RNPEDdePXypAD7nE+BlQ=
Subject: FAILED: patch "[PATCH] nvme: add missing SRCU grace period in error path" failed to apply to 6.12-stable tree
To: tristan@talencesecurity.com,hch@lst.de,john.g.garry@oracle.com,kbusch@kernel.org,sagi@grimberg.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:43:40 +0200
Message-ID: <2026090940-spray-energy-c72e@gregkh>
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
git cherry-pick -x ef248d5de4469fb6bbaf8dbe0c4c47800080d648
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090940-spray-energy-c72e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef248d5de4469fb6bbaf8dbe0c4c47800080d648 Mon Sep 17 00:00:00 2001
From: Tristan Madani <tristan@talencesecurity.com>
Date: Sat, 15 Aug 2026 00:14:27 +0000
Subject: [PATCH] nvme: add missing SRCU grace period in error path

nvme_alloc_ns() error path at out_unlink_ns removes ns from the
namespace head siblings list with list_del_rcu(&ns->siblings) but
does not wait for SRCU readers before freeing the namespace struct.
Multipath code iterates the head->list under srcu_read_lock() in
nvme_find_path() and nvme_mpath_revalidate_paths(), so a concurrent
reader can still hold a reference to ns when kfree(ns) runs.

The normal removal path in nvme_ns_remove() correctly calls
synchronize_srcu(&ns->head->srcu) after list_del_rcu() to wait for
in-progress readers. Add the same grace period in the error path.

Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5f2744be7388..9739ce38b73a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4345,6 +4345,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 			last_path = true;
 	}
 	mutex_unlock(&ctrl->subsys->lock);
+
+	/* guarantee not available in head->list */
+	synchronize_srcu(&ns->head->srcu);
 	if (last_path)
 		nvme_put_ns_head(ns->head);
 	nvme_put_ns_head(ns->head);

