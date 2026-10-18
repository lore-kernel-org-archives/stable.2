Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E838F62A
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341113; cv=none; b=qz6e4+efKCMezBqlxLT6eLG0qyZUf3aVSWHMxi+ZhoPdDuzyrNL6rkX9H194qWWkovTLgevsQOza8Pz47AiwyLhI87G0IP4a38/+PXeISUdc/RrI7GZJ8KaH1dwhYBT3Ru279FnVY2egLK6lR38xlLrGSjM++EVOouc8xrpWa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341113; c=relaxed/simple;
	bh=sCP6gp7v4kua0OIiD2f4Nb3Lrarw7N2ZRp8nfSOx8xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ht3CGiH5b/7jzFylypECDHHO0b78bnR1fbbrE6cpx4ZdED/MdawvJMpovrHN0throoVr7hxSuvahLKWi8w6VuWTyqecKxfR43poArdZI+vOKwB46aTg6ABcN37ZRD1NlDDR8wJCqDE/yNUmbITJqtX09gsXbk1IsTUqI6I1Ykg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEQiH74x; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEQiH74x"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1517bda04a0so814339c88.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341111; x=1792945911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rC079flF1ea2UIC6V0VoUeWhWKPu+OYvPPnysw6iStQ=;
        b=oEQiH74xrmZRf3K9XLOQip3aBUl+tICfhE6hvUKUQNm4GQaOUhPhHyW6yfehjAQL3q
         girtdGujZ4Gb/5xdgvJbazp2UYIAmBF01cTChkTIrwzjjF/7hGUPU1RA+LNkjIfQt0zB
         yuYpymD2oLErp3noJ5Q56Y86ir4JO0uH39KiFKFORgStr5gCSeOXsqtu1n/Ex+P0V4mt
         eB/opFNjFPj6lnFVrVd83JGbWqURXKbACqDXF8kC6mGEEt2mqXtx1OFQ8e75ls2DBWUA
         oLUpB52el8iD67E9Yw0I/N6zm/Y5O/pIZCpdzl7x7COAoKPEi/knACsO5SNrHBlRs3j3
         RT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341111; x=1792945911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rC079flF1ea2UIC6V0VoUeWhWKPu+OYvPPnysw6iStQ=;
        b=Xsf/eP+mc0ytxH9ZyYjyjQqdXEsltkP40fuYOkithuvsChURW+I/W3qb6pfwtKDb7v
         RHmk2slzRNRX5wP+Y1Ps3H0HQ/s6cor0FMShM6L1QgjdQc1nT3rEeFecp3jHe9rfIC6G
         MApFTw8Pkvog4SlzWazFw+/PkIKua5sfclUOsuomgqEM6ddg0X9b8zjNt4yySdi1N/Wj
         J868aqu/No/e8Xfb9CbOq/PW9m/D6hTX4XMn+Pdrm0/fwSLyyK3XO0LC2fD/H8gt882A
         dYw+O/EHSqHu67S3g/PQ8/ri0cKd8xy8rZf5O4D6aM2/NOmGyD+IaV/KFIxvFtzdRSfX
         LzpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPB3AIxdZUfiRccWKY6Qz5q+SPU1cEYQ2xytWTYbqOs2msBUCeslLychq2eV15XpQrzaCIPpM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoUVTTZobcheBPHKTmkEPWet0AuRs5+JQOw2wbaxBLaOT6CPTY
	YnhJJYD72vnrBorxhD3ddphwc3akMkOgDK5RvZNahm00fNsC2oboYlsg
X-Gm-Gg: AYBFou0ffHHg1JYCI5w/IhX2SLV71Se89xr8z7m2GYXkaH6iPwXhUwRSXg8Hz5bAW/U
	7BLhJve+N9LaNSFtZ3HbjwxWiIymJeJ5HwdqfVxZj961H+KqrV4EX8iTqD1bNham+6MSbQ4DsY7
	tnQWboDvjkjYbHk+vA8kXltAT7e3uaaA3fRHOrTfrTYXVejjxF0Y6vzESOxHM9Ieo5q+hxPEYHt
	Lh56Y5nzEbrk6l3LCxLhsBGZ8hIK/fv7zfHx1mq71jhvMo5qNL8RboS1RvF+jQpieuPtywb1c88
	k9p2UTPjcZ3PFww3wywUKJpul3BgxXwKM8Q/CCaAVNlWr7AGRHaKM+5ySP53J7SZpa2nHWhei3p
	AcIycV0hLFixHmUgfxdja4FZgGSF4hpXeC1TVY/RYO7VbbxYQ22Yk7WKa6vtr1KvpMeZD8v+30z
	LjC4B5AHcxhG85ufjyQqAeZvXf8483pkH7rzWK+E8LtQX+EQ7iXL3o/2QU2SLQsvjKv6HhwoiEa
	4+uyRg6TyG2ZiWf0AyKzjQOrKtwFVSP3dqQLHOgcYtZnkTDjBf0uBg1YC/q5SiTuEG96aXEJG59
	5RwtBQ==
X-Received: by 2002:a05:7022:fc03:b0:128:d4be:7428 with SMTP id a92af1059eb24-1851229662fmr6253633c88.19.1792341110987;
        Sun, 18 Oct 2026 09:31:50 -0700 (PDT)
Received: from codespaces-393231.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm21629178c88.5.2026.10.18.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:31:50 -0700 (PDT)
From: Eklavya Singh <eklavyasingh2106@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eklavya Singh <eklavyasingh2106@gmail.com>,
	syzbot+5d4e96acd0febccb5e87@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute
Date: Sun, 18 Oct 2026 16:31:21 +0000
Message-ID: <20261018163121.128911-1-eklavyasingh2106@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Add a mutex to the region and take it in dev_store(), in the
block_bytes, start_block and blocks stores, and in dev_show(), since
they all look at hr_bdev_file. dev_store() sleeps with it held while it
waits for the heartbeat thread. That is fine because neither the thread
nor the teardown paths take it.

With the patch the same test ran for 10 minutes with lockdep on and
nothing was reported.

Fixes: a7f6a5fb4bde ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Reported-by: syzbot+5d4e96acd0febccb5e87@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d4e96acd0febccb5e87
Cc: stable@vger.kernel.org
Signed-off-by: Eklavya Singh <eklavyasingh2106@gmail.com>
---
 fs/ocfs2/cluster/heartbeat.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 1c3def99b..2ea870098 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -269,6 +269,8 @@ struct o2hb_region {
 	struct list_head	hr_handler_list;
 	/* Serializes timeout arming against failed-start and teardown. */
 	struct mutex		hr_arming_mutex;
+	/* Serializes the region's configfs attributes against dev_store(). */
+	struct mutex		hr_dev_mutex;
 	bool			hr_stopping;
 
 	/* last hb status, 0 for success, other value for error. */
@@ -1676,6 +1678,7 @@ static ssize_t o2hb_region_block_bytes_store(struct config_item *item,
 	unsigned long block_bytes;
 	unsigned int block_bits;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1705,6 +1708,7 @@ static ssize_t o2hb_region_start_block_store(struct config_item *item,
 	char *p = (char *)page;
 	ssize_t ret;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1731,6 +1735,7 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	char *p = (char *)page;
 	int ret;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -1748,10 +1753,12 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 
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
@@ -1879,6 +1886,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 	int live_threshold;
 
+	guard(mutex)(&reg->hr_dev_mutex);
 	if (reg->hr_bdev_file)
 		return -EINVAL;
 
@@ -2156,6 +2164,7 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 	reg->hr_key = crc32_le(reg->hr_region_num + O2NM_MAX_REGIONS,
 		name, strlen(name));
 	mutex_init(&reg->hr_arming_mutex);
+	mutex_init(&reg->hr_dev_mutex);
 	reg->hr_stopping = true;
 	INIT_DELAYED_WORK(&reg->hr_write_timeout_work, o2hb_write_timeout);
 	INIT_DELAYED_WORK(&reg->hr_nego_timeout_work, o2hb_nego_timeout);
-- 
2.55.0

