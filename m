Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388A37FF71
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947238; cv=none; b=e0A/ZJ7AnYIsy6zpicc7NW31sJRMTzGKhgjaHuAtgtgbFzTmvXQl3kqCf3W7vzaQgwLM7OMZAww2kt5/MpKmkKn9Zrd8rGQyH3ZzjobvWP00aZGIT9iRqYqQ8wlxA/YfvcipvQo6krKxuDqxzmXX0gSp+jqVtaiby9qR2Q4EKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947238; c=relaxed/simple;
	bh=AcbfVFBdM7YCIn9INZrwBuPO2omwCaFeRpn9xCLOHk4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SA98pY6GZJOihIgmHoIYQylnOh0oH1cmqo15Fln6k45B2JwljBl7vFhqWdrt0fE9takQC5R8ZSWFksyOQeg6KhJWrlw+SGTS+QCkuyGdGmHiTzTNd0wCREM50Rv7fm3FIdosJFQyamKBD4kMi9+VvZo7asLQPR8gzxAkiFxGp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mQCtf1gM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mQCtf1gM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385B91F00A3A;
	Wed,  9 Sep 2026 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947236;
	bh=lyVmtDccW79XT+Da7sYHV0mdgcp9OOzE653ivKdfqIQ=;
	h=Subject:To:Cc:From:Date;
	b=mQCtf1gMhwa8gd6kyWnNLoYj7iqeQyEwDj6+wDOIldzn3ojbU+xvs3V47235OudpW
	 eAzFAq5tTzmnNSVwmmQE8Md8s4A0nbnN4MvAOx9emTulHdkaw4VlbuUX2ueJnhgU8W
	 34lXHScXNI3R26E0L1kJ7Qgv/jnnAGEpB4Rs+Wd0=
Subject: FAILED: patch "[PATCH] nvme: add missing SRCU grace period in error path" failed to apply to 6.1-stable tree
To: tristan@talencesecurity.com,hch@lst.de,john.g.garry@oracle.com,kbusch@kernel.org,sagi@grimberg.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:43:40 +0200
Message-ID: <2026090940-antiviral-matchbook-0634@gregkh>
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
git cherry-pick -x ef248d5de4469fb6bbaf8dbe0c4c47800080d648
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090940-antiviral-matchbook-0634@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

