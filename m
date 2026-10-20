Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502194;
	b=bS5s23eMXsqpVU4SSPmjAcJ5VtJ3iqB/yXiuaUWV3lUyIJ2G7RZkIKIdlsGA9h/HiMyM
	 9F5aPD894PPKHvREDvOSgDnkwwmBy/YJkxbVJhb/QCunyvIU65tJHBpo1zgh58AcKgZhc
	 kFEaTzrKNz2WhZ17SWw+kFFRjgsx4v3u0XWnBZ3w8CgPvjURA4l+6Rm9LmQUBNc55LUlj
	 SSszZH/CHf9S0xmaPN36jmZ11X8G5uqk23SdnlMqZg1oL26Zkp8YUqtEV9nU+TQJqhAVt
	 opXawh5KU3YQ4WoyNa0awoL9czYIm1WCLWZI/33RyvihAUDoZ5/rtrkoQg8NeKzvRJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F3m/+L4fUaNtacc/BKjjfkqz9A0nN/jif39xvTqMZ1Q=;
	b=0MR/CYbQF+i5Vn6TfNgYv3S7BdDpyX0w4kdhBakDXrbP9+I3Izn3NCV/DqCe3S5jmuCm
	 xVeWIEOw33OW7JrNfeXLgZkOfd844LIJg2ySFeDlO5RvWci39DrOkUn3Ez0FhtE7Rymcz
	 fwfYN/yko2CKbakw57nNy61PNw6NEKyEanWIjSAzyGQKRU4zVbItBLc6WUSj9qUowRYhB
	 3b9eYdA8KnGXNX6b2mUwOLfMX5P++6nt/HPGUsOlii01d0eFC7F8Hi51Du1yeiHYWBKbg
	 KBMABMuJ9ZL9qz0SlrSInJH3HH2v0wm/mCewVTcqWHuhWPDVAfrwOVC8F/kSGzHRxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TzBrFBHy;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858C606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3858C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TzBrFBHy
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8b20a899fso15774395ad.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502193; x=1793106993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F3m/+L4fUaNtacc/BKjjfkqz9A0nN/jif39xvTqMZ1Q=;
        b=TzBrFBHyBtdFSpr+MtNwS04HVn5uD758RHA8yVWKhAWbDr71w6h9jPe8+JLkQoOFwB
         DDeMdtdXF2XIZlqsGxZc/3YLmig6zEGo/1l1nPxGSZfV12T2xVkIgMCJSCZ3hcqhuAL4
         rSFJM7Sw5jLp6fLXhPBdlRzPRP6oPuNZXCj6esI0XFISowVgFKY3KR1nWRUjgOqmiU/P
         I9xTw53cnju5JQydUhs+ayrS++vYKMdlDVY3A25aRlZQoR03+zStGvRODwAw3MT4Zp8/
         KAhJOLhQt1zW0WtQ9JGmahxpFd4enFftlTNQ5cQvsZ9TyOJd845olkadThN/nmanq8Fx
         +5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502193; x=1793106993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3m/+L4fUaNtacc/BKjjfkqz9A0nN/jif39xvTqMZ1Q=;
        b=zvgiVPPqiI6eA6Zbyf+7LQmq8EGG2pjS8QR1Loq/P1XVTih728EaGvQw/Nv1NUvF7T
         WlxiaumuzoowL8eQOvUxOZB5iIx4X4eList1vI3fl4CKMFYPnxjrslIhIkqzPUI3wdMg
         XroBhrEs3KqyCKWX6iGoQYW7Kl097Q4H8ukkm38ArwkdguiHgKjA8L414MqBNfCKuVqR
         Fq9F/YoMjxquyI2JMfd7e66i4v29XXUx5HnP1CNB8spPriakxsfz3GCGRPO/5z8VidwX
         FBNg6xknojy81Bfk5lbiCfFv8NcrZHcP6Z9tvZvT/UA/52SmWskAkc30VnLk9Fd9n1fC
         KvEw==
X-Forwarded-Encrypted: i=1; AKwUvBwE4BAC6mflcWeBAqZo2h6Zh+OlV1aOUoyrx2rThSvNvpyiGZyLRztVlFmbw4qqZhic8Z1rpeM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIk9HpcK6qKwYz7iIIXQvBCwIC2mgO4bXV5L7Cdeb1ujcBckVOW
	z0Ui3ETzCUENWkTSEwmYWkfsptr3ZnBNinDwxiAZKJlg1KMOGUkzixLy
X-Gm-Gg: AYBFou3jVbsH5e3TJBb5gbnwHk0SUFlI5bRayxGxX4K8Hax1D5Dzl0R4/PyOre7xa/Y
	Uuny9sugvD4U6anmgpiPWwhr/LFox92vaw4XJmW+qYSAbjwPtQIR/cmLe3ycEkPUsneKiEoptMV
	zb1dK/Ma6M+klk0BaKAN+lmMnZ9WnGhA7Lh+3WZTtw0fWgASgw1TC4R6VjhOUTrFCLezX6KJvPH
	uD1Vvzl6EEFO2TsGeQnFWry+BbK+2cBjwH+mP4d2ffi3alWX5lfrGhV9/iOb1c3hkjIolcioy3E
	nq7PNEB6JSb19E+ejFFUbA1UkG5ZikzzCEGs9+9vj+5LdE1JWxHj3Dbcu1rlNg/0s6jOKb1Xyfe
	VULWnECHvRFrSkYEMjRUHv3x98srHhXf7Yb+f9fGELCe54AL4ggN7hEZS0SoQWFdwgkf38ZFgMQ
	WJl46XtPWzqrIhx8BhohzBfSYb6dm9cKeVSmbLrkk04L6jCNdb2MOq49RPQY6UdZFsuA==
X-Received: by 2002:a17:903:37cc:b0:2e8:4040:792b with SMTP id d9443c01a7336-2e9a6a0c86dmr94936015ad.22.1792502193310;
        Tue, 20 Oct 2026 06:16:33 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1501e24fsm11843535ad.42.2026.10.20.06.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:16:32 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2/cluster: serialize heartbeat block count with device setup
Date: Tue, 20 Oct 2026 21:16:26 +0800
Message-Id: <pm-ocfs2-objects-candidate-0077-v6-eb25e73523a3cb94fae0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

A heartbeat region's hr_blocks must match the number of slots allocated
in hr_slots until its thread stops. o2hb_region_blocks_store() checks
hr_bdev_file before updating hr_blocks, but neither operation is
serialized with device publication in o2hb_region_dev_store().

Writes to blocks and dev through separate configfs opens can overlap.
The buffer mutex is per open, and both callbacks hold frag_sem for read.
With an initial count N, the following order is possible:

  blocks writer               device writer
  -------------               -------------
  check hr_bdev_file == NULL
                              publish hr_bdev_file
                              allocate N slots in o2hb_map_slot_data()
                              start o2hb_thread() and return
  store hr_blocks = M, M > N
  return

After both writes finish, normal region removal calls kthread_stop().
o2hb_thread() iterates over the enlarged count and passes &hr_slots[N]
to o2hb_shutdown_slot(), which reads ds_node_num beyond the allocation.

Recheck the device guard and update hr_blocks under o2hb_live_lock, and
publish the device file under the same lock. Open the device into a
local pointer to keep the sleeping open outside the spinlock. A blocks
write then either completes before publication and determines the slot
count, or sees the published file and returns -EINVAL. Clear the file
under the same lock after failed-start cleanup has stopped the thread
and unmapped the slots, so configuration can resume safely.

KASAN report as below:

    BUG: KASAN: slab-out-of-bounds in o2hb_thread+0xc62/0xe90
    Read of size 1 at addr ffff888107829ac0 by task o2hb-pmbd-regio/497

    CPU: 3 UID: 0 PID: 497 Comm: o2hb-pmbd-regio Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? o2hb_thread+0xc62/0xe90
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? o2hb_thread+0xc62/0xe90
     kasan_report+0xe0/0x110
     ? o2hb_thread+0xc62/0xe90
     o2hb_thread+0xc62/0xe90
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_o2hb_thread+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __lock_acquire+0x5a3/0x2140
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xeb/0x1a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_o2hb_thread+0x10/0x10
     ? kthread+0x351/0x460
     kthread+0x351/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf70
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 496:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_noprof+0x2de/0x780
     o2hb_region_dev_store+0x7c4/0x1c70
     configfs_write_iter+0x2f9/0x4f0
     vfs_write+0x639/0x1010
     ksys_write+0x111/0x200
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888107829a80
     which belongs to the cache kmalloc-64 of size 64
    The buggy address is located 8 bytes to the right of
     allocated 56-byte region [ffff888107829a80, ffff888107829ab8)

(Page and memory-state dump omitted.)

Fixes: a7f6a5fb4bde ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Cc: <stable@vger.kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
 fs/ocfs2/cluster/heartbeat.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index b45adc39aacc..7448ee53aebe 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1746,7 +1746,13 @@ static ssize_t o2hb_region_blocks_store(struct config_item *item,
 	if (tmp > O2NM_MAX_NODES || tmp == 0)
 		return -ERANGE;
 
+	spin_lock(&o2hb_live_lock);
+	if (reg->hr_bdev_file) {
+		spin_unlock(&o2hb_live_lock);
+		return -EINVAL;
+	}
 	reg->hr_blocks = (unsigned int)tmp;
+	spin_unlock(&o2hb_live_lock);
 
 	return count;
 }
@@ -1878,6 +1884,7 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 {
 	struct o2hb_region *reg = to_o2hb_region(item);
 	struct task_struct *hb_task;
+	struct file *bdev_file;
 	long fd;
 	int sectsize;
 	char *p = (char *)page;
@@ -1911,13 +1918,22 @@ static ssize_t o2hb_region_dev_store(struct config_item *item,
 	if (!S_ISBLK(fd_file(f)->f_mapping->host->i_mode))
 		return -EINVAL;
 
-	reg->hr_bdev_file = bdev_file_open_by_dev(fd_file(f)->f_mapping->host->i_rdev,
-			BLK_OPEN_WRITE | BLK_OPEN_READ, NULL, NULL);
-	if (IS_ERR(reg->hr_bdev_file)) {
-		ret = PTR_ERR(reg->hr_bdev_file);
-		reg->hr_bdev_file = NULL;
-		return ret;
+	bdev_file =
+		bdev_file_open_by_dev(fd_file(f)->f_mapping->host->i_rdev,
+				      BLK_OPEN_WRITE | BLK_OPEN_READ,
+				      NULL, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	/* Freeze hr_blocks before allocating the slot array. */
+	spin_lock(&o2hb_live_lock);
+	if (reg->hr_bdev_file) {
+		spin_unlock(&o2hb_live_lock);
+		fput(bdev_file);
+		return -EINVAL;
 	}
+	reg->hr_bdev_file = bdev_file;
+	spin_unlock(&o2hb_live_lock);
 
 	sectsize = bdev_logical_block_size(reg_bdev(reg));
 	if (sectsize != reg->hr_block_bytes) {
@@ -2036,7 +2052,9 @@ out:
 		o2hb_unmap_slot_data(reg);
 
 		fput(reg->hr_bdev_file);
+		spin_lock(&o2hb_live_lock);
 		reg->hr_bdev_file = NULL;
+		spin_unlock(&o2hb_live_lock);
 	}
 	return ret;
 }
