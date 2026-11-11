Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436099;
	b=jsAvQAZIxYp4EG7RZGABZyueyyRi9PP7OrnFP8JSHjmEymTt9pN3/SOH8XjvRQ/WfUn9
	 Dz9WDXnx4Gvn5H0zLuJojRsqd7b9XxmQQiS7cO+/VCt4+DOvQz5Ar1dKfOlOARUIa3DNs
	 joIdbiG+SqU1z4AqgllSLlq4MwNtuQBHfSnTBhi2x/aUnS6PyXvjBOp5HcNmdEFT/5jVh
	 vv+3UL52oVYtPjU9NEnyFMB7tVDCGW0wuTqea7aW0Z/fNxsyaQctXwiDV6qosVh+gvObn
	 wDuOUBxv0x+mhYIXBfUjIwWnSYVf8wZGvzfSHLSKXkEdSkCDXx9om9l56hcig9L6xVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436099;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F7Icpw3/p7H/0Ty4lYyRuOUEQk4rCKJ0HWkRN5Yq/mI=;
	b=0qxrQxKydEqxwvcvV4qqSu8DXGxSuGf/Yg7Q363y43Sh+DE3mYSluuIgIPWYGZGW6LsR
	 eooOxK208kUpInSGZxwKtm+BAP4y/pLU8UcyJ462/nEEwnAExxnYb00U/mhIkVKzBqe8Q
	 pJnqbUZTGTYGjScgE3U3yk589TGzUdH8BbhuDhpooLx0gQIJWWNeEdpSTVC34XazOSLLN
	 Wg4XtOfIkQrToQUkxtCSCxvQM9u9nNK0rxdctuvbMOI7HfO1pS7IaUwLWxRX8Mkg3qyZS
	 ota8BSLErfvg0IvcvRKenLFXfiq9gbLK23KSWdZ13ObJlWPJObtY0FrqQYPAIEQvM5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhZnQba1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4701606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhZnQba1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DC81F00A05;
	Wed, 11 Nov 2026 22:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436099;
	bh=F7Icpw3/p7H/0Ty4lYyRuOUEQk4rCKJ0HWkRN5Yq/mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lhZnQba1JPdLpHV+nRSkm62WkHCDCoPzUGvaoGkTHdqHLZvX1++djbvzx55RtyUhY
	 WAcnTz+QlsicaNJXd7WNwQAJH2cdPtfALqOWTPgc1oNAgZy5ceNapp4LejXzFgX8qf
	 H9fYJoAXCKNRkaRzrbR5Lsu/Z9iYs9ZYykvzrdsQhMjkU2ccut/RogKk1PfKxdSdZR
	 78TpjGbn/7u+XccwdMjTZ+/V3YEL21VMx5NRkLrj8LVd1tFzz4IF/j/WANMHYGDkEM
	 Fw3mcO4iAY4lvmwrgf4qfWm7cyAWb3Pe+psqvex0NFP0ejsECrZcrdKQmI3AsDWmI+
	 SnbIz879tRF7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eklavya Singh <eklavyasingh2106@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	syzbot+5d4e96acd0febccb5e87@syzkaller.appspotmail.com,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Heming Zhao <heming.zhao@suse.com>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute
Date: Wed, 11 Nov 2026 17:28:16 -0500
Message-ID: <20261111222759.68491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201726-failed-6.1-0a8f258c0f01@kernel.org>
References: <20261109201726-failed-6.1-0a8f258c0f01@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eklavya Singh <eklavyasingh2106@gmail.com>

[ Upstream commit 0a8f258c0f012314c36b9e4818cdc0178c68f891 ]

o2hb_region_dev_store() checks reg->hr_bdev_file to see if the region
is already started, but nothing stops two writers from doing that at
the same time. configfs only serializes writes through the same open
file, so two processes that each open the dev attribute can both get
past the check:

  A: hr_bdev_file is NULL, opens file A, sets hr_bdev_file = A
  B: hr_bdev_file is NULL, opens file B, sets hr_bdev_file = B
  A: start fails, fput(hr_bdev_file) drops B, sets it to NULL
  B: start fails, fput(NULL)

Both calls also use the same hr_slots, hr_slot_data and hr_tmp_block,
so the error paths can free the slot data twice.

syzbot hit the fput(NULL) with an unbound loop device, where every
start fails with -EIO. With four threads doing the same thing on a
KASAN kernel I get both crashes within a second:

  BUG: KASAN: double-free in o2hb_unmap_slot_data+0x14d/0x2f0
  BUG: kernel NULL pointer dereference, address: 0000000000000158

Add a mutex to the region and hold it in dev_store(), in the
block_bytes, start_block and blocks stores, and in dev_show(), since
they all look at hr_bdev_file. dev_store() cleans up with goto, so it
takes the mutex in a small wrapper rather than with guard(). The mutex
is dropped while dev_store() waits for the heartbeat to become steady,
which takes seconds, so a read of dev doesn't stall behind a start.
hr_bdev_file is already set at that point, so other writers still get
-EINVAL, and the cleanup after the wait retakes the mutex.

With the patch the same test ran for 10 minutes with lockdep on and
nothing was reported. So did a second one, with a working loop device,
that interrupts starts during the wait while other threads read and
write the attributes.

Link: https://lore.kernel.org/20261020212339.46591-1-eklavyasingh2106@gmail.com
Fixes: a7f6a5fb4bde ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Signed-off-by: Eklavya Singh <eklavyasingh2106@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <syzbot+5d4e96acd0febccb5e87@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=5d4e96acd0febccb5e87
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Cen Zhang <zzzccc427@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted locking to the existing hr_bdev-based implementation using inline mutex handling and goto cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/cluster/heartbeat.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index e7229d755dcbe..e641c9c415532 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -268,6 +268,8 @@ struct o2hb_region {
 	struct list_head	hr_handler_list;
 	/* Serializes timeout arming against failed-start and teardown. */
 	struct mutex		hr_arming_mutex;
+	/* Serializes the dev, block_bytes, start_block and blocks attributes. */
+	struct mutex		hr_dev_mutex;
 	bool			hr_stopping;
 
 	/* last hb status, 0 for success, other value for error. */
@@ -1657,6 +1659,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
 	unsigned long block_bytes;
 	unsigned int block_bits;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev)
 		return -EINVAL;
 
@@ -1686,6 +1689,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	char *p = (char *)page;
 	ssize_t ret;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev)
 		return -EINVAL;
 
@@ -1711,6 +1715,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	unsigned long tmp;
 	char *p = (char *)page;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev)
 		return -EINVAL;
 
@@ -1728,10 +1733,12 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 
 static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
 {
+	struct o2hb_region *reg = to_o2hb_region(item);
 	unsigned int ret = 0;
 
-	if (to_o2hb_region(item)->hr_bdev)
-		ret = sprintf(page, "%pg\n", to_o2hb_region(item)->hr_bdev);
+	guard(mutex)(&reg->hr_dev_mutex);
+	if (reg->hr_bdev)
+		ret = sprintf(page, "%pg\n", reg->hr_bdev);
 
 	return ret;
 }
@@ -1859,6 +1866,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
+	mutex_lock(&reg->hr_dev_mutex);
+
 	if (reg->hr_bdev)
 		goto out;
 
@@ -1958,9 +1967,15 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	reg->hr_task = hb_task;
 	spin_unlock(&o2hb_live_lock);
 
+	/*
+	 * Don't hold hr_dev_mutex across the wait, which can take seconds.
+	 * hr_bdev is already set, so other writers still get -EINVAL.
+	 */
+	mutex_unlock(&reg->hr_dev_mutex);
 	ret = wait_event_interruptible(o2hb_steady_queue,
 				atomic_read(&reg->hr_steady_iterations) == 0 ||
 				reg->hr_node_deleted);
+	mutex_lock(&reg->hr_dev_mutex);
 	if (ret) {
 		atomic_set(&reg->hr_steady_iterations, 0);
 		reg->hr_aborted_start = 1;
@@ -2012,6 +2027,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 out2:
 	fdput(f);
 out:
+	mutex_unlock(&reg->hr_dev_mutex);
 	return ret;
 }
 
@@ -2117,6 +2133,7 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 
 	INIT_LIST_HEAD(&reg->hr_all_item);
 	mutex_init(&reg->hr_arming_mutex);
+	mutex_init(&reg->hr_dev_mutex);
 	reg->hr_stopping = true;
 	INIT_DELAYED_WORK(&reg->hr_write_timeout_work, o2hb_write_timeout);
 	INIT_DELAYED_WORK(&reg->hr_nego_timeout_work, o2hb_nego_timeout);
-- 
2.53.0

