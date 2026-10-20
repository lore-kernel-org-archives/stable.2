Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531444;
	b=JvDa8ne+mHmnEU2gNK2kdPMLqz2T3ctPRH39L0V3pfq2ZOqcmabSQogJAGxOsi/CgFjj
	 qIr+rVp90oPJz3d9vk78ssKMSR+raJI023kiMiW1ZENNir+joLB5UkvraX4b7RGmAn1nO
	 DSlX2TispjRSPHl6MkzeydKSP3VsBN1UMpo3Hiack0Ja+R+2O5gDBcIbs+jMYDDML5Whm
	 FZ6ur/9xFrOOlCVHBnsion+6mJLDjaYMLnxaWVNXJGWiNA0T2HibrmiHR4yWzyRmsHhmz
	 3j/IPz5nY3q29M1XaNdwa996oz74Z5/y4o6er9clEqijK61YYkTrIfU9uuc+PkioKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sEPH3pV5NQDGveQ4gCC4SZc339s/ZpKzGxrmka5jI0c=;
	b=oxa4sAyco/YkM66XuArmpSQqVIfW1jjvdR8Ni+9bBqXeuj5zBt06g668rm5QTJ9BBRyu
	 0YRWlw2vNWOUBzAn4E5uuXPF/Jieu9qJy7x4BC6XqWEB95Yt0Sy6Pipj2qiimu7qPBwW4
	 iXWggTgZvcvwtXwPMNf+1FsaZtam3ADrUuM+x1y3SCazomJ6QNkAAfs8QliXeDAsaMGFt
	 BPl2AHHNUXi5OQwAACsa1DTKsATrPndBMpXIvA1/GyZbVjU4mUQOGJ35B0Hd7niIZLfp6
	 DSLcmMLkIodPDnsoTZmJtj39HuH7bHQF8GDwvO6O2N8wYc6GH6MpBEicgIBQU3LouAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CERZWXVl;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51809606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51809606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CERZWXVl
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so66713eec.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792531443; x=1793136243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEPH3pV5NQDGveQ4gCC4SZc339s/ZpKzGxrmka5jI0c=;
        b=CERZWXVllHDgB2fcpmh8y7vhIBMPAbPsGsIbfgFPEa8e6D6LrV/bdkdlDalk6DFzcC
         rNPDOX32FdjLJyJQybFpaZ4zNcirdj/R1EEDpivRB1lU0tuwle6TRpRjVgvpTOSjNpIc
         7Xv/yMbAbUNpwuZKH+zQ1Ksn8NTk44mGemC1viFCEoEqk6bmlVekdAWpTs5v8+6oQLvF
         Esd28WoU2GhRHYIlV35rAEXRu0ZIHrhl+SdT1i17sYFwX/euER3OVFUytWQBvq49Ycjx
         RtsH/3rZVvXjH/IkXM9ykGPwm7m1GHDH/vh00NX01Q1oOKlXJYFLx+tbsmSFdoPWrWMJ
         RHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792531443; x=1793136243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sEPH3pV5NQDGveQ4gCC4SZc339s/ZpKzGxrmka5jI0c=;
        b=vWiq5101W//WVrsO1aEmW8LPqoVLXFRJv4CNXpIuWtYmiqZSsxxHAwogBipfJ+bwxs
         +u7rZbKrZ6ioCfmtKpv82Xg5LL2euDk5jsYND/ehXlvb24GrxO9dlbnr0r6ctHW7LEA3
         AHfy0rzhcPPeKcnZzkCrYWUmdDK/MKvYMxWebeVBtyWbu/yYVUZAA4/pO2l1swN0sgJF
         wAtXkiga3TMz2S0A1kt6damG4u7J5lJ5KmfQWNva6Wt2T2glExmNcyIdfXvigYoi9jo1
         DBX4zXfFRMX9GoKSw2Lj6tr6dAHNr+xHY9b2o1RGGGrDu5g0H0YWdVR009i/K8eVsvgJ
         VoHQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3m1ViAn6kpQ+uYOknPpkE3DEbtY5Xd0hux5KLZiMd/c0bn8m2abOFpg2fWgzNx+BbGm24fLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJA7H4+diiQ0tutCKkLnq0GpnxK/xEU+W4ctjTWM/Rb6KDEM6Ah
	jKRTr44v5nVtMgttvydaLYh6MkjJtwIxrt0x9nNAXEYhlBMi05oBz/dc
X-Gm-Gg: AYBFou1K779MWZtyABCnaz5qrGgDBRzUgcoGyutSzRhkQKXCDXLpILoCH3YrEQyFqOq
	nPRXC4PmPn+L+T46Tz+vL2edzMblRc+fQtIvmLwgVGkXAlLlsHwi6UhYQXVaxpthMqO/omTWRep
	Jtt5J8yfAWSmeg+mb/eCVG0kAKxdVbs104E3NLH4Kf3yBULa6GhByfBLWy0xfpOdoQ0KdCDJ5Oy
	ca0OBPIzApp6Wv9g5JapaSrC3jTiVe5tTiF29EjQBUM7wjq7v4HA/fGeREaWO9EJ9MNq4JpQNXq
	ohgz9/KDEO4UkvmM/+7J/BmmCxpb2Rsaqil6zWDUwe+mJQ6RNuWvYt1Y6BHs7Os5sY80Q6eEf8C
	mxlWS57Vemw65uiVOR+2Rg2lh8TQuSS3Scpd/v8v6g77kETjfejHzbF7cYzgBIDITxmnJW50CTz
	ktDMiopmJYdxQbkvHlFAOVbxlR8pbIpVrGaDS6eJ+8eYM4lHbXG9csnLRZV3zWKRmOX7N9oP1vG
	yhfiF/72L2YFYTiGT9lz227LCD4mQc=
X-Received: by 2002:a05:693c:884f:b0:359:9e84:dc99 with SMTP id 5a478bee46e88-367474becaemr467629eec.0.1792531443223;
        Tue, 20 Oct 2026 14:24:03 -0700 (PDT)
Received: from localhost.localdomain ([139.167.143.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741e71eaesm2003444eec.26.2026.10.20.14.23.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 14:24:02 -0700 (PDT)
From: Eklavya Singh <eklavyasingh2106@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Heming Zhao <heming.zhao@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Cen Zhang <zzzccc427@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+5d4e96acd0febccb5e87@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] ocfs2/heartbeat: serialize concurrent writes to a region's dev attribute
Date: Wed, 21 Oct 2026 02:53:39 +0530
Message-ID: <20261020212339.46591-1-eklavyasingh2106@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261019072936.2279-1-eklavyasingh2106@gmail.com>
References: <20261019072936.2279-1-eklavyasingh2106@gmail.com>
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

Fixes: a7f6a5fb4bde ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Reported-by: syzbot+5d4e96acd0febccb5e87@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d4e96acd0febccb5e87
Cc: stable@vger.kernel.org
Signed-off-by: Eklavya Singh <eklavyasingh2106@gmail.com>
---
Changes in v3:
- rebase onto linux-next
- drop hr_dev_mutex while waiting for the heartbeat to become steady,
  so a read of dev that races a start no longer blocks (Joseph)
- name the four attributes in the hr_dev_mutex comment and assert the
  mutex is held in __o2hb_region_dev_store() (Joseph)

Changes in v2:
- take the mutex in a wrapper around dev_store() instead of with
  guard(), since dev_store() uses goto for its cleanup

Deepanshu Kartikey [1] and Cen Zhang [2] have posted patches for the
same race, and they conflict with this one. This version also takes
the mutex in dev_show(), which otherwise can read hr_bdev_file while a
failed start is dropping it.

[1] https://lore.kernel.org/all/20261020085100.8819-1-kartikey406@gmail.com/
[2] https://lore.kernel.org/all/pm-ocfs2-objects-candidate-0077-v7-34980443ec254b2a1ffc@gmail.com/

v2: https://lore.kernel.org/all/20261019072936.2279-1-eklavyasingh2106@gmail.com/
v1: https://lore.kernel.org/all/20261018163121.128911-1-eklavyasingh2106@gmail.com/

 fs/ocfs2/cluster/heartbeat.c | 40 ++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index b45adc3..7a18e71 100644
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
@@ -1872,11 +1879,9 @@ out:
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
@@ -2041,6 +2054,20 @@ out:
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
2.52.0

