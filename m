Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DF2D5932;
	Thu, 27 Aug 2026 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820328; cv=none; b=NHJNl/cyqr3S4CyUp9E777mnn+bNJEIS0Ln5ZiPaBx68FN7FRSEEc/+W3DM+R9Aw8fYGOVGiljzaKpm6bVQ2N0WPX+GD4qwSwuC0KdtIYCqyh94RO0U087/kQAQ630HZIZiq3ZNhwZaEePDsec45gJSDNwzP/E8sj/7xj5sdckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820328; c=relaxed/simple;
	bh=aP4fy6ACXfxpP6LX6pmb1BbnS44opMeYKNjuTW+xXjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBdoH6Q5GUeRLSht1/ZkrD97JiADw5TuDslvD1Wb1C96MI/8JLSDvgVtw72xgig4pgtYPMkizGwG4FzZxhzWIxUMSY4c6XhLwGTaIfmMsc689Z5cEuxMRD6R+sWeYvYzQLj68XycoZbzkoK5wsMt5+4FfOJ7jg+uWOM3e5HwzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nmNTxUyc; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nmNTxUyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2+
	2rxZUJikTUeYYrMEtvl3brnsfonW3c9eKEJTK4i8E=; b=nmNTxUycL/Zkofnn0a
	OkcKx9fAAkFymG38ta+53gJm/AlQWKPRIrHNQFw1hWfuQ6d2qSPaSF9TSvEZ+Mbr
	GzElA72b6mhxH0ld2J+rg+r7RuOZNInRLjVkYkichJp9/kR2uhLZ1h82z6V6Il9R
	dbUfZ+co/bW7O2HD1bTLTpVdA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXY_kG+Y9q545uPQ--.26825S3;
	Thu, 27 Aug 2026 16:44:56 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v3 2/3] md-cluster: fix error handling and superblock consistency in update_size
Date: Thu, 27 Aug 2026 16:44:52 +0800
Message-Id: <20260827084453.124629-2-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827084453.124629-1-ghuicao@163.com>
References: <20260827061200.79753-1-ghuicao@163.com>
 <20260827084453.124629-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXY_kG+Y9q545uPQ--.26825S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF47Ar47try8JF4UWw1Utrb_yoWrWFyxpF
	WUWa43Gw4Ut3y8Ww15JFn7ua4Fy3s7t3y8tryxGayIkrn0grZ7GF4FqF90qFn8CF9xXFsF
	qws8AF4Uu397Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-yCJUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC-Aj+kWqP+QgPaQAA3p

From: Cao Guanghui <caoguanghui@kylinos.cn>

update_size() has multiple issues in the revert path when
cluster_check_sync_size() detects that not all nodes have confirmed
the new size:

1. (pre-existing) The return value of resize() is immediately
   overwritten by __sendmsg(), so a resize failure is silently lost.

2. (pre-existing) The on-disk superblock still retains the new size
   from the earlier md_update_sb() call.  Other nodes re-read it and
   adopt the new size while the initiator runs with the reverted old
   size.

3. (pre-existing) The function returns void, so callers cannot detect
   failures.

Fix all of the above by:
- Using a separate variable for __sendmsg result so resize failure
  is not overwritten
- Calling md_update_sb() after unlock_comm() to write the reverted
  size back to disk.  This must be outside the locked section because
  md_update_sb() internally acquires MD_CLUSTER_SEND_LOCK via
  metadata_update_start(), which would self-deadlock if already held.
- Changing return type from void to int with proper error codes
  (-EIO for lock failure, -ENODEV for no device, ret for others)

Fixes: 818da59f97d6 ("md-cluster: add the support for resize")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/md-cluster.c | 28 +++++++++++++++++++++++++---
 drivers/md/md-cluster.h |  2 +-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1302,18 +1302,19 @@ static int cluster_check_sync_size(struct mddev *mddev)
  *    let other nodes to perform it. If one node can't update sync_size
  *    accordingly, we need to revert to previous value.
  */
-static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
+static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
 {
 	struct md_cluster_info *cinfo = mddev->cluster_info;
+	bool reverted = false;
 	struct cluster_msg cmsg;
 	struct md_rdev *rdev;
-	int ret = 0;
+	int ret = 0, msg_ret = 0;
 	int raid_slot = -1;
 
 	md_update_sb(mddev, 1);
 	if (lock_comm(cinfo, 1)) {
 		pr_err("%s: lock_comm failed\n", __func__);
-		return;
+		return -EIO;
 	}
 
 	memset(&cmsg, 0, sizeof(cmsg));
@@ -1335,12 +1336,12 @@ static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
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
+		return -ENODEV;
 	}
 
 	/*
@@ -1359,12 +1360,28 @@ static int update_size(struct mddev *mddev, sector_t old_dev_sectors)
 	} else {
 		/* revert to previous sectors */
 		ret = mddev->pers->resize(mddev, old_dev_sectors);
-		ret = __sendmsg(cinfo, &cmsg);
 		if (ret)
+			pr_err("%s:%d: failed to revert array size\n",
+			       __func__, __LINE__);
+		reverted = true;
+		msg_ret = __sendmsg(cinfo, &cmsg);
+		if (msg_ret) {
 			pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
 			       __func__, __LINE__);
+			if (!ret)
+				ret = msg_ret;
+		}
 	}
 	unlock_comm(cinfo);
+
+	if (reverted)
+		/* Update on-disk superblock to match reverted in-memory
+		 * size. Must be after unlock_comm() to avoid self-deadlock
+		 * since md_update_sb() acquires the cluster send lock.
+		 */
+		md_update_sb(mddev, 1);
+
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
-- 
2.34.1

