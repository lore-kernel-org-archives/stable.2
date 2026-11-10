Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292304;
	b=MHM4gCLJBkkBMjpVCoq7UUvmwCZhn0oIT6UFexdYd4Cha0VnEzlHwdK6WIR2/TjZxcQN
	 7lhpAvGxmYDh45ZNGqT5ao0o3fuE2CzdZ7iGvpHc5D+EHxraQsDXv4wDKT951Uwleo1WD
	 nVPoX16OWyH8F4eWyZwIr9j7s6sEhBiyZhfbidyd7YonvHVMg/HOO1JzslPpz8yK9OMQb
	 lwBfgBzTdoBBGd3g+HDXe9cY3aUdYqLpU7VzHoL6P1lcx/YgeLbHXJbh2tGj9UpI2WrRW
	 Xg7AJ6n9TGPBqBxPZFsyepzggVa6EmI+RKOxGKhaKwo75mjd9LvfzKUIslRZPkCSqjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292304;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=hCPqx5wj8Vej8QBG4Zxzq+0P7YhtDg24mAW+V+oPtyk=;
	b=HGDQ1KtIonmsXzYmk+asjGjJLSEhQZQ17OMcyQhb6rb5nnaAj4UNH25EAWG9DuyKmE40
	 tlP7HYIhgN/9E/UwHid/dnVXv0yZdzHp+rBiR2MVin8Z2Iz0fRpmEpJYsy6Few9/4iISY
	 Qr3MgTEVGlphzMoMVcHYuloKq9AZPKUoOzOfIFT1JXwnj0byxgks9P89gMHV/YDr1giKg
	 F/9Kkfcx1nTP2JScpoIPx70DFAYf5kEpMiilXl3Top1nfxeC1YCSbiR+T2ijIOXK8SZfp
	 aYE1Abpavmg1DOz8/PurjYdO3TwpJjJMHZxTq29yed/bkwgOxaPVEBcF1j9DN14SfTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Gg9pCmBD;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EB606A339;
	Tue, 10 Nov 2026 06:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD4EB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Gg9pCmBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hC
	Pqx5wj8Vej8QBG4Zxzq+0P7YhtDg24mAW+V+oPtyk=; b=Gg9pCmBDcxM2vgilSl
	ZEMoju4SJ/qiiahklxrKjDCSzUkgZ9O+ITFG6UOYp1ydpJrw/VpCXUNVCIdqHYpS
	ATLCQJhGgxqoW9vLUBVjdcxFKTviEG1W170fFsUzEUyR8LuBiYDDinSoiF0/O+Sh
	XmqT+ax7gNfbX7I5SE0v+X5lo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCH_6IXuvJqrGnjGA--.29207S2;
	Tue, 10 Nov 2026 14:30:49 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: song@kernel.org,
	yukuai@fygo.io
Cc: magiclinan@didiglobal.com,
	xiao@kernel.org,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Youhong <liyouhong@kylinos.cn>,
	syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] md: fix sync_work vs array teardown races
Date: Tue, 10 Nov 2026 14:30:45 +0800
Message-Id: <20261110063045.912703-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wCH_6IXuvJqrGnjGA--.29207S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF15AF4xZryfJr1ftw15XFb_yoWrCr45pr
	WfXFn8GrWUJ3yfZ39Fga4DWa4jyw1SqrZrJryxWas5AwnYyF47WF1Yg3WUZFWDtas7ta42
	va15tFZxua4v9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjtC7UUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+hoMumryuho9LQAA3+

From: Li Youhong <liyouhong@kylinos.cn>

dm-raid tears down arrays via md_stop(), which cleared mddev->pers
without waiting for previously queued sync_work. That work could
then call remove_spares() with pers == NULL, or keep using mddev
after raid_dtr() frees it.

do_md_stop()/md_stop_writes() already call stop_sync_thread() before
teardown. Do the same in md_stop().

Also fix two related completion/freeze holes that made that wait
unreliable:

- stop_sync_thread() waits for !MD_RECOVERY_RUNNING before teardown,
  but md_start_sync() could still use mddev after unlocking. Clear
  RUNNING only after those uses are done, then wake_up(&resync_wait).

- The read-only path in md_check_recovery() queued sync_work without
  honouring MD_RECOVERY_FROZEN, unlike the read-write path. Check
  FROZEN so freeze/stop cannot race with a new queue while
  stop_sync_thread() drops reconfig_mutex.

Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
Fixes: 81e2ce1b3d5a ("md: delay remove_and_add_spares() for read only array to md_start_sync()")
Reported-by: syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a53c2918175b36cfd601
Cc: stable@vger.kernel.org
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v3:
- Clear MD_RECOVERY_RUNNING only after md_start_sync() finishes using
  mddev on the not_running path.
- Honour MD_RECOVERY_FROZEN before queueing sync_work on the
  read-only md_check_recovery() path.
- v2: link: https://lore.kernel.org/linux-raid/20261109023055.2164333-1-dayou5941@163.com/

v2:
- Drop the pers NULL check in md_start_sync().
- Call stop_sync_thread() from md_stop() before clearing pers,
  matching do_md_stop()/md_stop_writes().
- v1: link: https://lore.kernel.org/linux-raid/20261106083543.249267-1-dayou5941@163.com

 drivers/md/md.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..18d37413ffaf 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7104,6 +7104,13 @@ void md_stop(struct mddev *mddev)
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
+	/*
+	 * md_check_recovery() may have queued sync_work; that work accesses
+	 * pers. Wait for it here before __md_stop() clears pers, as
+	 * do_md_stop()/md_stop_writes() do.
+	 */
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true);
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
 }
@@ -10343,7 +10350,6 @@ static void md_start_sync(struct work_struct *ws)
 	clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 	clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
-	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 	mddev_unlock(mddev);
 	/*
 	 * md_start_sync was triggered by MD_RECOVERY_NEEDED, so we should
@@ -10355,11 +10361,16 @@ static void md_start_sync(struct work_struct *ws)
 		memalloc_noio_restore(noio_flags);
 		__mddev_resume(mddev, false);
 	}
-
-	wake_up(&resync_wait);
 	if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
 	    mddev->sysfs_action)
 		sysfs_notify_dirent_safe(mddev->sysfs_action);
+	/*
+	 * stop_sync_thread() waits for !RUNNING and may then tear down
+	 * the array. This path still uses mddev after unlocking, so
+	 * clear RUNNING only after those uses are done.
+	 */
+	clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
+	wake_up(&resync_wait);
 }
 
 static void unregister_sync_thread(struct mddev *mddev)
@@ -10494,9 +10505,11 @@ void md_check_recovery(struct mddev *mddev)
 
 			/*
 			 * Let md_start_sync() to remove and add rdevs to the
-			 * array.
+			 * array. Honour MD_RECOVERY_FROZEN like the read-write
+			 * path so freeze/stop does not race with a new queue.
 			 */
-			if (md_spares_need_change(mddev)) {
+			if (md_spares_need_change(mddev) &&
+			    !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 				set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 				queue_work(md_misc_wq, &mddev->sync_work);
 			}
-- 
2.25.1

