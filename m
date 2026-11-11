Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361874;
	b=p6Vru7KTWPcOiHnlrMJqJsV4Fn2B3jUFd4GymLsVyzGiSAz1Y1gev7/v9lvB536ZP93p
	 B2BCgBnNuO/bUwDVW1ojN3QizXXevi71CiBS5oHUiE+07PpcPSKnzzsZbxJ3sR6JmUu9X
	 Q34pQLTFipEdpwsYpXg/2gXMA8guDkoHOXjUbHCEeM1WL79s5ODIbSqq9gANw4Gml1d+s
	 X+Fhl0eZcAoXT42ZpUyvHod4QvhYtg18Ta52+5V+AVLWtFnE/t+YDJ3zWlRmBzPV1glv1
	 OKPbJbJNZASI3l4/HjKF0Uvo0maXHwnkav+hfL1OcQ8WrZ4aoNFBT2EdIrzgBZbj1Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361874;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=y9Dwl1B/SkeBN/qAYgB/RrFCJLIxenUFUX+kaToQpxY=;
	b=oxhwdSQFO97xj+8LarLIP1VZQaOii8PvmJHMSj2RiyurzwEY8RLDe3Ja+abU/eBbl39R
	 V6qwg7nOx3LLqDkE42PpsG0+davmfL9KHkTguLUtDLw1GbWU+3Cacgh7ujjQjP8uKIFbe
	 k58Wv22ZWEbkxdc445R9fBCNCCosBbT+dP6dtvxcIU8liA0DjJzCyd3CZYh5Y+k/1zFfW
	 kP+O9u7IqtWqvlTnaHpR3llCZgUImWdbQLkNmDVlTdmXH2SPURPOzoECWSNhphFIrau/6
	 LwQEkJmTBd7Ft8+yrAWyOSXf/7El159m11ft9CpJ8MwI+giNoQ0RRR3Pk8KEcWGtIsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TjRlamZO;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0AA606A31C;
	Wed, 11 Nov 2026 01:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A0AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TjRlamZO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=y9
	Dwl1B/SkeBN/qAYgB/RrFCJLIxenUFUX+kaToQpxY=; b=TjRlamZO9AI9+dcsNd
	K6UMwCWTLBZ0MUQUGC483aMSNlypG17Jwbpq2BfO/9mj5RPhp+AXW03N+p19ECBe
	SanZ9qm+7lDMcmlg8WpX56DQhhBf2mOsKcCwzR+lGXCCUv4VY7tooHjY+BN6fpBW
	Jwafk8kfZ9m/ksJpIrkW7z/lM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3Xx_kyfNqrtbZHA--.39564S2;
	Wed, 11 Nov 2026 09:50:29 +0800 (CST)
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
Subject: [PATCH v4] md: fix sync_work vs array teardown races
Date: Wed, 11 Nov 2026 09:50:27 +0800
Message-Id: <20261111015027.4029184-1-dayou5941@163.com>
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
X-CM-TRANSID:_____wD3Xx_kyfNqrtbZHA--.39564S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF15AF4xZry3KF47uw4DJwb_yoWrtr1fp3
	yfJFn8GrW8t3yfZF9rKFyDWayUZw1IqrZrJryxWa4fAw1fAF4xWryY9F10vFWDJas3tay5
	Za1rJFZxua4v9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjE_NUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+QdD8WrzyeeDoAAA3Y

From: Li Youhong <liyouhong@kylinos.cn>

dm-raid tears down arrays via md_stop(), which cleared mddev->pers
without waiting for previously queued sync_work. That work could
then call remove_spares() with pers == NULL, or keep using mddev
after raid_dtr() frees it.

do_md_stop()/md_stop_writes() already call stop_sync_thread() before
teardown. Do the same in md_stop().

Also fix two related holes that made that wait unreliable:

- md_start_sync() may still use mddev after unlocking. Checking
  work_pending() in stop_sync_thread() is not enough once the work
  is running, so always flush_work() and wait for it to return
  before teardown.

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
v4:
- Always flush_work(&sync_work) in stop_sync_thread(); do not delay
  clearing MD_RECOVERY_RUNNING (that can drop MD_RECOVERY_NEEDED via
  md_check_recovery, and does not cover the successful sync_thread
  registration path).
- v3: https://lore.kernel.org/linux-raid/20261110063045.912703-1-dayou5941@163.com
v3:
- Honour MD_RECOVERY_FROZEN before queueing sync_work on the
  read-only md_check_recovery() path.
- (superseded) delayed MD_RECOVERY_RUNNING clear on not_running.
- v2: https://lore.kernel.org/linux-raid/20261109023055.2164333-1-dayou5941@163.com
v2:
- Drop the pers NULL check in md_start_sync().
- Call stop_sync_thread() from md_stop() before clearing pers,
  matching do_md_stop()/md_stop_writes().
- v1: https://lore.kernel.org/linux-raid/20261106083543.249267-1-dayou5941@163.com

 drivers/md/md.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..68a72513e884 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5184,22 +5184,22 @@ static void stop_sync_thread(struct mddev *mddev, bool locked)
 {
 	int sync_seq = atomic_read(&mddev->sync_seq);
 
-	if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-		if (!locked)
-			mddev_unlock(mddev);
-		return;
-	}
-
 	mddev_unlock(mddev);
 
-	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
+		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		/*
+		 * Thread might be blocked waiting for metadata update which
+		 * will now never happen
+		 */
+		md_wakeup_thread_directly(&mddev->sync_thread);
+	}
 	/*
-	 * Thread might be blocked waiting for metadata update which will now
-	 * never happen
+	 * md_start_sync() may still use mddev after unlocking. Always
+	 * flush so teardown waits for that work to return; checking
+	 * work_pending() is not enough once the work is running.
 	 */
-	md_wakeup_thread_directly(&mddev->sync_thread);
-	if (work_pending(&mddev->sync_work))
-		flush_work(&mddev->sync_work);
+	flush_work(&mddev->sync_work);
 
 	wait_event(resync_wait,
 		   !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
@@ -7101,6 +7101,14 @@ void md_stop(struct mddev *mddev)
 {
 	lockdep_assert_held(&mddev->reconfig_mutex);
 
+	/*
+	 * md_check_recovery() may have queued sync_work; that work accesses
+	 * pers. Wait for it here before __md_stop() clears pers, as
+	 * do_md_stop()/md_stop_writes() do.
+	 */
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true);
+
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
@@ -10494,9 +10502,11 @@ void md_check_recovery(struct mddev *mddev)
 
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

