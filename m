Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434463;
	b=1lmrIGotJWqGJk7gYJGYPCa48Ffct7VQhl9U0CezkS4yxegkwuHi1PXSWoZVBKFVSuS2
	 QMmWj/P+OTgYQm/8QU6Z8H2RkcFf0nHlE17EjYKv7tlE/g3pTUJWZ12VbPo+NnbjUz+xK
	 mngrcvk9860ruciWw39F3PocyNW0UjKTtXcrDC/eAN72DzIG4TFbR62d6SQGSglRlSjfs
	 hTRIqjGN72Oq5FRtx035UzS7Fn4RcbwOft5PwQe8k0bkWq1LRhbDmml5ENSDKlvlMQ3Fe
	 rOGQ3V8LwH5xV8xCcqYpNEAzbb5y3gGPA/i4FUtmaQ8/zjMr0zZuA4syrYuq1tnsSVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434463;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jdDPZ2N0BSs+JmB59Imk9zHXrKMegTlUJPTNbboapsQ=;
	b=iymGgyH96RiA+lCNuVEQRV8fhw8GvBfVtF/4be9dRneQ1vcUttKB4YgwKyOWlmphMNv0
	 hmehrivJSuR06FnIo/uP+zNzLdaS+CKNlPYSUx5avmHt5mkvg22TEbc2r7YgXIRAg29h6
	 WC9NBgb+AzlNujgmhPE/CXqwlqJm+qNtGAmya7O8scW5JokjCfrsWvqvHD3MM9yyaLtY/
	 s5GCKulQviXkjptQezeTy7ANt6BPEXeycC4sVRXR35dij0OgPbhuTZy9WGIWnV8i8tfH4
	 qhkWkeZJ1h3jySHRUUCja0g4eBMehZKmJlpl7VuPFRwsFRsLdZxV5R/E5pqOzr1L9Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDRQT46a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F9606A880
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDRQT46a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626EC1F00A07;
	Wed, 11 Nov 2026 22:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434463;
	bh=jdDPZ2N0BSs+JmB59Imk9zHXrKMegTlUJPTNbboapsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDRQT46azJNpyX1D2hCgxvGL5W1+AwkN5eV1kxOqpzYBoS0fMVNNhu9OYlCPFZS+c
	 F9+mBFP2OwavtHKGheTg2xXQ1K5jCgiZlfwGdbE3ZDfePPqaqkbUseyymRcddYJQbv
	 BJUIz7uht0n6TEbwa25w48ec0h4sErVWPpymP9Uz2wKyQHToF/RhW+be70EzPGHEca
	 3NPTzoV4ANcT2bs4zJc3zyI4vsoYIwOZjQK3k6rL2Sqp58wb4sKZ11O0nDEOzsApB9
	 XxAVlzqLml1QOqPyWNd4PTDUmcfFMeMXbL5U//Qg/eUZMDVb1aYs70QCiAFCFmYxLw
	 2n9tdwcp9thOg==
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
Subject: [PATCH 7.3.y 2/2] ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute
Date: Wed, 11 Nov 2026 17:00:59 -0500
Message-ID: <20261111220052.4086173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220052.4086173-1-sashal@kernel.org>
References: <20261109200149-failed-7.3-0a8f258c0f01@kernel.org>
 <20261111220052.4086173-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/cluster/heartbeat.c | 40 ++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index b45adc39aacca..7a18e71b507b3 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -269,6 +269,8 @@ struct o2hb_region {
 	struct list_head	hr_handler_list;
 	/* Serializes timeout arming against failed-start and teardown. */
 	struct mutex		hr_arming_mutex;
+	/* Serializes the dev, block_bytes, start_block and blocks attributes. */
+	struct mutex		hr_dev_mutex;
 	bool			hr_stopping;
 
 	/* last hb status, 0 for success, other value for error. */
@@ -1681,6 +1683,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
 	unsigned long block_bytes;
 	unsigned int block_bits;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1710,6 +1713,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	char *p = (char *)page;
 	ssize_t ret;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1736,6 +1740,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	char *p = (char *)page;
 	int ret;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1753,10 +1758,12 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 
 static ssize_t o2hb_region_dev_show(struct config_item *item, char *page)
 {
+	struct o2hb_region *reg = to_o2hb_region(item);
 	unsigned int ret = 0;
 
-	if (to_o2hb_region(item)->hr_bdev_file)
-		ret = sprintf(page, "%pg\n", reg_bdev(to_o2hb_region(item)));
+	guard(mutex)(&reg->hr_dev_mutex);
+	if (reg->hr_bdev_file)
+		ret = sprintf(page, "%pg\n", reg_bdev(reg));
 
 	return ret;
 }
@@ -1872,11 +1879,9 @@ static int o2hb_populate_slot_data(struct o2hb_region *reg)
  * this is acting as commit; we set up all of hr_bdev_file and hr_task or
  * nothing
  */
-static ssize_t o2hb_region_dev_store(struct config_item *item,
-				     const char *page,
-				     size_t count)
+static ssize_t __o2hb_region_dev_store(struct o2hb_region *reg,
+				       const char *page, size_t count)
 {
-	struct o2hb_region *reg = to_o2hb_region(item);
 	struct task_struct *hb_task;
 	long fd;
 	int sectsize;
@@ -1884,6 +1889,8 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
+	lockdep_assert_held(&reg->hr_dev_mutex);
+
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1987,9 +1994,15 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 
 	wake_up_process(hb_task);
 
+	/*
+	 * Don't hold hr_dev_mutex across the wait, which can take seconds.
+	 * hr_bdev_file is already set, so other writers still get -EINVAL.
+	 */
+	mutex_unlock(&reg->hr_dev_mutex);
 	ret = wait_event_interruptible(o2hb_steady_queue,
 				atomic_read(&reg->hr_steady_iterations) == 0 ||
 				reg->hr_node_deleted);
+	mutex_lock(&reg->hr_dev_mutex);
 	if (ret) {
 		atomic_set(&reg->hr_steady_iterations, 0);
 		reg->hr_aborted_start = 1;
@@ -2041,6 +2054,20 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	return ret;
 }
 
+static ssize_t o2hb_region_dev_store(struct config_item *item,
+				     const char *page,
+				     size_t count)
+{
+	struct o2hb_region *reg = to_o2hb_region(item);
+	ssize_t ret;
+
+	mutex_lock(&reg->hr_dev_mutex);
+	ret = __o2hb_region_dev_store(reg, page, count);
+	mutex_unlock(&reg->hr_dev_mutex);
+
+	return ret;
+}
+
 static ssize_t o2hb_region_pid_show(struct config_item *item, char *page)
 {
 	struct o2hb_region *reg = to_o2hb_region(item);
@@ -2143,6 +2170,7 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 
 	INIT_LIST_HEAD(&reg->hr_all_item);
 	mutex_init(&reg->hr_arming_mutex);
+	mutex_init(&reg->hr_dev_mutex);
 	reg->hr_stopping = true;
 	INIT_DELAYED_WORK(&reg->hr_write_timeout_work, o2hb_write_timeout);
 	INIT_DELAYED_WORK(&reg->hr_nego_timeout_work, o2hb_nego_timeout);
-- 
2.53.0

