Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679118A6CF;
	Thu, 27 Aug 2026 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811153; cv=none; b=Vp6AZz3V8fPjRgKUYAbhVkGKdAis+pmxsxe6tv31mdYDo9OyNtRL2XJRKmgCMkYwqJE9sQeL0OOcL282GOW78PRPrqr7M1xFcfcZ+oV08AU4DRyrYg6LBm5Zi71MeZ9D5l+cQx/ruCl1hJTF7Y5cTo0NyRC5Iq1mufk98bz59eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811153; c=relaxed/simple;
	bh=wkZeUQ4BQwpgXHTOgzgPRXmkOunhCqWXTRvfIjtuG7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3TlQoaN6J5JIb4c8KfV5yH7Xv8h4wAF8u3ZXPLjAiBKTPrltLpb5tl4yuEQx6aEYoXP5zZKrzQHhX9OJFuK3EjhkeK4HGjFTmsoQNEJCMQskAjrLgLMt/R1yC9lUslW0oFeljajDpIYKTj3wm9s+qL8GXXCW/nijO0yhoZ2Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hrj2lziH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hrj2lziH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bv
	wMe8T3Nrn9ZRYw4IEDwm3e+PQfQJg9sEXDb2z5Yeo=; b=hrj2lziHsgvjQ71KX4
	5/8xsIbVTA3nbSgJUoRSJfkGbcFfhINsbKb44ZRoBPiEFZsHtO0LiN2duNvavO7+
	1GiqfayDvzj4yAjKORBcbjG9MH/Ee3OFNuOWGejIIyDaynwUHviP/uKi8qx5ZQDn
	n8qQm/7nwBrUi1z3WWDa/B2wY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC37aUx1Y9qkXlaPQ--.24874S3;
	Thu, 27 Aug 2026 14:12:02 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v2 2/3] md-cluster: propagate update_size() errors to callers
Date: Thu, 27 Aug 2026 14:11:59 +0800
Message-Id: <20260827061200.79753-2-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827061200.79753-1-ghuicao@163.com>
References: <20260827025229.40138-1-ghuicao@163.com>
 <20260827061200.79753-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC37aUx1Y9qkXlaPQ--.24874S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFyrCFy7Xw1UArWDZrWxCrg_yoWrXw1kpF
	W7KFyfGw15JrWFgw4UJFn7ua45K3s7trZrtry7GayxGFnIgrWkGF4rXF9Yqr4DGa4rXrsI
	qws8Jw4Uu3s7Ww7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5AwxUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC4BIAkmqP1TItNwAA34

From: Cao Guanghui <caoguanghui@kylinos.cn>

update_size() in md-cluster.c has a void return type, so the caller in
md.c cannot detect cluster resize failures.  A capacity revert or
message delivery failure is silently lost, and the MD layer reports
success to userspace even when the cluster operation failed.

Change the update_size() callback in struct md_cluster_ops and its
implementation to return int, and propagate the error at the call sites
in md.c.

Fixes: 818da59f97d6 ("md-cluster: add the support for resize")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/md-cluster.c | 11 ++++++-----
 drivers/md/md-cluster.h |  2 +-
 drivers/md/md.c        |  7 +++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1292,7 +1292,7 @@ static int cluster_check_sync_size(struct mddev *mddev)
  *    let other nodes to perform it. If one node can't update sync_size
  *    accordingly, we need to revert to previous value.
  */
-static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
+static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
 {
 	struct md_cluster_info *cinfo = mddev->cluster_info;
 	struct cluster_msg cmsg;
@@ -1303,7 +1303,7 @@ static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
 	md_update_sb(mddev, 1);
 	if (lock_comm(cinfo, 1)) {
 		pr_err("%s: lock_comm failed\n", __func__);
-		return;
+		return -1;
 	}
 
 	memset(&cmsg, 0, sizeof(cmsg));
@@ -1325,12 +1325,12 @@ static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
 			pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
 			       __func__, __LINE__);
 			unlock_comm(cinfo);
-			return;
+			return ret;
 		}
 	} else {
 		pr_err("md-cluster: No good device id found to send\n");
 		unlock_comm(cinfo);
-		return;
+		return -1;
 	}
 
 	/*
@@ -1355,6 +1355,7 @@ static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
 			       __func__, __LINE__);
 	}
 	unlock_comm(cinfo);
+	return ret;
 }
 
 static int resync_start(struct mddev *mddev)
diff --git a/drivers/md/md-cluster.h b/drivers/md/md-cluster.h
--- a/drivers/md/md-cluster.h
+++ b/drivers/md/md-cluster.h
@@ -34,7 +34,7 @@ struct md_cluster_operations {
 	int (*resize_bitmaps)(struct mddev *mddev, sector_t newsize, sector_t oldsize);
 	int (*lock_all_bitmaps)(struct mddev *mddev);
 	void (*unlock_all_bitmaps)(struct mddev *mddev);
-	void (*update_size)(struct mddev *mddev, sector_t old_dev_sectors);
+	int (*update_size)(struct mddev *mddev, sector_t old_dev_sectors);
 };
 
 extern int md_setup_cluster(struct mddev *mddev, int nodes);
diff --git a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8023,7 +8023,7 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 	rv = mddev->pers->resize(mddev, num_sectors);
 	if (!rv) {
 		if (mddev_is_clustered(mddev))
-			mddev->cluster_ops->update_size(mddev, old_dev_sectors);
+			rv = mddev->cluster_ops->update_size(mddev, old_dev_sectors);
 		else if (!mddev_is_dm(mddev))
 			set_capacity_and_notify(mddev->gendisk,
 						mddev->array_sectors);
@@ -10615,8 +10615,12 @@ void md_reap_sync_thread(struct mddev *mddev)
 	 */
 	if (mddev_is_clustered(mddev) && is_reshaped &&
 	    mddev->pers->finish_reshape &&
-	    !test_bit(MD_CLOSING, &mddev->flags))
-		mddev->cluster_ops->update_size(mddev, old_dev_sectors);
+	    !test_bit(MD_CLOSING, &mddev->flags)) {
+		int ret = mddev->cluster_ops->update_size(mddev, old_dev_sectors);
+
+		if (ret)
+			pr_warn("md: cluster update_size failed after reshape: %d\n", ret);
+	}
 	/* flag recovery needed just to double check */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	sysfs_notify_dirent_safe(mddev->sysfs_completed);
-- 
2.34.1

