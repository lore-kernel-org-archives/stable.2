Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2573F7872;
	Thu, 27 Aug 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820337; cv=none; b=aW8gQzbCtSMQ1dzOC7qFUZPuLBpE1jWcFV/L9FGeJUDjUtQjm7IuHW3KcvJ43zaAGgVDfYlr3vySpMshbBW0gmQQn/ADZDcLjfAfHlQb/AgnpnEcNOcgN7x+rQA+wcmPSW2CuusL44Go8wZC4Dz25rInE7PjeEUNEGReIlpsnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820337; c=relaxed/simple;
	bh=h7yOX4VW/wztNU8fp4bdk4euKzrz9m/US0S6jcGkJ5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+GuacyvF2Y7GLjM9IaavVxEI0APFj0d0pDm7VfjtI2QGBXxEK5YjMqIzDHxH2swfrZwR3BtY1wRf/I3uZ5rgb0aooVVW+yhr/6C04wuiOG4KPVzZBVpc1DbHm4XYYrlG+TEf+Z1AFzCmgBpkJ49uz/o66jTYUw0/cinXDWJzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jG5Zw4X5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jG5Zw4X5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TI
	hGwWka/nqHDgf+s1AOlrgAG1nkUwUC/B6fUMbS5hM=; b=jG5Zw4X5mg0JpttLSz
	d0rPvwo2Rg4paBZiV+j8oT7eQJZo7biegdoppmpkhNnXNXGFMLTXXNffjgGAcPhD
	i0t8W1FDiNg9LwnylU9ebGi/dzYazFr2zwg4knsfX7HC6HNsQSXLoT2d6H7lgd//
	hBEdWoyK+h9BRqzegiYeb624c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXY_kG+Y9q545uPQ--.26825S4;
	Thu, 27 Aug 2026 16:44:57 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v3 3/3] md-cluster: revert local resize and propagate cluster errors
Date: Thu, 27 Aug 2026 16:44:53 +0800
Message-Id: <20260827084453.124629-3-ghuicao@163.com>
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
X-CM-TRANSID:PigvCgAXY_kG+Y9q545uPQ--.26825S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CryUXw4fJFW7ZFykAF1UJrb_yoW8urykp3
	yxKF95try8GrZIgw47X3Z29FW5K34xtrWqqFyaka48JFn7Ar4ktF1ruF95XrWqk3s5Zrs8
	Xws8Ja18ur1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jThFxUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC+wr+kWqP+Qp-hAAA3z

From: Cao Guanghui <caoguanghui@kylinos.cn>

In md.c:update_size(), the local array is resized via pers->resize()
before calling the cluster update_size() callback.  If the cluster
operation fails, the local node has the new size while the rest of
the cluster does not, causing a split-brain state.

Propagate the cluster update_size() return value and revert the local
resize on failure.  Also check the return value in the reshape
completion path (md_reap_sync_thread) and log a warning on failure.

Fixes: 818da59f97d6 ("md-cluster: add the support for resize")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/md.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8022,9 +8022,11 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 	}
 	rv = mddev->pers->resize(mddev, num_sectors);
 	if (!rv) {
-		if (mddev_is_clustered(mddev))
-			mddev->cluster_ops->update_size(mddev, old_dev_sectors);
-		else if (!mddev_is_dm(mddev))
+		if (mddev_is_clustered(mddev)) {
+			rv = mddev->cluster_ops->update_size(mddev, old_dev_sectors);
+			if (rv)
+				mddev->pers->resize(mddev, old_dev_sectors);
+		} else if (!mddev_is_dm(mddev))
 			set_capacity_and_notify(mddev->gendisk,
 						mddev->array_sectors);
 	}
@@ -10615,8 +10617,12 @@ void md_reap_sync_thread(struct mddev *mddev)
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

