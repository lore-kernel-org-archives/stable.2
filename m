Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2F3B6341;
	Thu, 27 Aug 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817853; cv=none; b=OFpEy0BtUoSelACXrjA/WTeG41OvmuFCdZmwbVOKJMX+cv9TlMOzcCFv085F0Bv4Tchpk7qBwu908eYP+JFkk4rGTSZQI2KjvTZ4ICH6bClyWt/DjKooJkOfLqmJN86wWC3KqDohhKKzNIeqwxKCtZBIV3ujNYgRyek9E5iHNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817853; c=relaxed/simple;
	bh=SZK2uKu99FCmOiH6CtTNvIURwBng/uRczIPfDS5zYAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhNssCEJq0s6UVWyMb9hK93V9ZIRHsC2AFsmln1VMFNTvaoeNlLeiyw319Fej4XC7Xm1WkugjYI0T1hweb7nDq9MOc+n45S6FIk9ELMXlDX6rBZge4FPo/W3g/8ltLUGgf+bcxWX5/fsURkwijv7h0tcbM7F15L17F/xDFSqWLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eBbC7aWG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eBbC7aWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=th
	hfpAm3W3+gvrnvVKZRRufjJwObxV/nCEwA2o7XeDY=; b=eBbC7aWG8ej8FBJoOg
	QBSN3swUdVuTqvzMBxDOQEMGZ42Mzj5iAKbl3vUGDPn3pnkLYlXYtSd5hQzFg3wz
	QZYXv8ea2vMM1KTwM5m9REbkdVg5bRn7yez0KNLz36rywLLAOeSpsY6hfviuaSps
	txsj5pJFtQS0oC2xYFLLqPh6Y=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3_wxe749qoz9pPQ--.29344S2;
	Thu, 27 Aug 2026 16:03:43 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v4 1/2] md/raid5: track disks array size to fix extra_page leak on error paths
Date: Thu, 27 Aug 2026 16:03:40 +0800
Message-Id: <20260827080341.112296-1-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827063235.85375-1-ghuicao@163.com>
References: <20260827063235.85375-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3_wxe749qoz9pPQ--.29344S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFy5Ar4UJr4kJryfuw48WFg_yoW5XrWrpw
	sru34UZa1UWrs3Jr17Z3yUuF15Kw4qqrWxGFW3W3yvvF9agrySyr1rGFZ0krWjyF93Kayf
	tFZ8trnxJr1rtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrYFZUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC-B+RJGqP71872AAA3g

From: Cao Guanghui <caoguanghui@kylinos.cn>

free_conf() iterates conf->pool_size entries to free extra_page
allocations, but pool_size may not reflect the actual size of the
conf->disks array.  Two scenarios cause a mismatch:

1. setup_conf() early abort: pool_size is 0 (not yet set by
   grow_stripes) but conf->disks has max_disks entries with
   extra_page allocated.  The loop iterates 0 times, leaking all
   pages.

2. resize_stripes() Step 4 failure: conf->disks was replaced with
   a newsize-entry array in Step 3, but pool_size is only updated
   on success.  The loop iterates pool_size (old, smaller value)
   times, leaking (newsize - pool_size) pages.

Add a dedicated disks_cnt field to track the actual number of
entries in conf->disks.  Set it immediately after each allocation
or replacement (in setup_conf and resize_stripes Step 3, where the
array is safely stalled with no concurrent access), and use it in
free_conf() instead of pool_size.

This leaves pool_size untouched, preserving the check_reshape()
retry behavior that depends on pool_size only being updated on
full success.

Fixes: d7bd398e97f2 ("md/r5cache: handle alloc_page failure")
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/raid5.c | 4 +++-
 drivers/md/raid5.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2642,6 +2642,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 		} else {
 			kfree(conf->disks);
 			conf->disks = ndisks;
+			conf->disks_cnt = newsize;
 		}
 	} else
 		err = -ENOMEM;
@@ -7552,7 +7553,7 @@ static void free_conf(struct r5conf *conf)
 	free_thread_groups(conf);
 	shrink_stripes(conf);
 	raid5_free_percpu(conf);
-	for (i = 0; i < conf->pool_size; i++)
+	for (i = 0; i < conf->disks_cnt; i++)
 		if (conf->disks[i].extra_page)
 			put_page(conf->disks[i].extra_page);
 	kfree(conf->disks);
@@ -7733,7 +7734,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 
 	if (!conf->disks)
 		goto abort;
-
+	conf->disks_cnt = max_disks;
 	for (i = 0; i < max_disks; i++) {
 		conf->disks[i].extra_page = alloc_page(GFP_KERNEL);
 		if (!conf->disks[i].extra_page)
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -667,6 +667,7 @@ struct r5conf {
 	unsigned long		cache_state;
 	struct shrinker		*shrinker;
 	int			pool_size; /* number of disks in stripeheads in pool */
+	int			disks_cnt; /* number of entries in disks[] array */
 	spinlock_t		device_lock;
 	struct disk_info	*disks;
 	struct bio_set		bio_split;
-- 
2.34.1

