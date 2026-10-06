Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BE49DBB1
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301208; cv=none; b=DgyZnWH0UDsIoGbq8jO1RUfob/5Yacn/YkKvE7S4wDWdfFoEIHt/SPT20bsuBSUjkgCpsXLtzzpTaR9DdWY8XzwZUi5b/L0gsAADkJMwBq8RH3nkwE/46VFkf8jOMEuaIyDuov0wil9r17BctxQgxJ1ULaWpOMKpC7FGS8xMKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301208; c=relaxed/simple;
	bh=EpL5BB+XScTzIW1MD1W1aVlhIx9smWCMRfW0mPT7Z+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns544kHDBYaSDODocLsfqV2kYtSCSZKMj2Sibmn4NFLrtJ9b3ozifBF8+dtUoefOrbGCa7dmFqiHYRJ0/MmdAAbDuP4UMvS9PJKqM6jzPGQUY4XgJgpAzHh7OGLb+HAlhIOW5+ADyDbPkqMl2J+HPqth5dCPICB/C6mToGc6Pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0hzAey9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0hzAey9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A1A1F0089C;
	Tue,  6 Oct 2026 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301206;
	bh=RVnskFSsazRZPjjbZ67H3JiMDawVp4VSI/bbaqcMxek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0hzAey90qog71jqLv2KB00PtqM3orUTtotNy/co0thGwsSE2jwD3JUg0FA10EGL0
	 ScXT8zzbcrBYu7ihhgjUsnguGBogoxjYwv7Uzoq2IREoLLaSfKEqcVmvS8HDLUZ6Zp
	 fbTF+YvX4Zal/qBqyC7kgLyZN4ooOSvxsI9byPxnvzQj6VUbwHntaQccEP1gMu+olA
	 3yhKeePWC9MvQ3nG+6lz+14NhZZP3CKV+fj2JUJFWtWHwZMbNR/Rn9eMDI0GRYlKMH
	 Eb5Xiyk2Tx4DHNWR3w+9DN1tfw6YuYQbKLbwleUyxYuoM3K02fbOxiDeS1fEXBzxEW
	 XAsEIKAFLpiyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] block2mtd: prevent direct access of bd_inode
Date: Tue,  6 Oct 2026 11:40:00 -0400
Message-ID: <20261006153928.760780-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006153928.760780-1-sashal@kernel.org>
References: <2026100520-kilogram-result-00fb@gregkh>
 <20261006153928.760780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit c9600c63a694249100e2bdcbb604c30d8fee2dc7 ]

All we need is size, and that can be obtained via bdev_nr_bytes()

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20240411145346.2516848-11-viro@zeniv.linux.org.uk
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: b5965c422116 ("mtd: block2mtd: Fix divide error when erase_size is zero")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/block2mtd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index aa44a23ec0451..502c30124aa61 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -269,6 +269,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 	struct block2mtd_dev *dev;
+	loff_t size;
 	char *name;
 
 	if (!devname)
@@ -295,7 +296,8 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)bdev->bd_inode->i_size % erase_size) {
+	size = bdev_nr_bytes(bdev);
+	if ((long)size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
@@ -313,7 +315,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 
 	dev->mtd.name = name;
 
-	dev->mtd.size = bdev->bd_inode->i_size & PAGE_MASK;
+	dev->mtd.size = size & PAGE_MASK;
 	dev->mtd.erasesize = erase_size;
 	dev->mtd.writesize = 1;
 	dev->mtd.writebufsize = PAGE_SIZE;
-- 
2.53.0

