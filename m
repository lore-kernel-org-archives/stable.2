Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351773;
	b=chsoWEsiRzObpSBL+dxpFJWXgzMxdoqnseSmLUvQAzUij52pMRN5WXMM8SfXh0npmnVb
	 HNWkfpMAvqOl34HIXzNwUhYBI6+FoUhVEZJ42QgpB7oiLImqhTRGTT+QHe9w60GPJ2UzZ
	 bj0X3z4QEkALol36LxLeBJ1tn3aTAN6hvhdJ/DoD2kuUx4/vzZmMqCnOf2ql3IVNHr+VD
	 CJq1v32ca/KPDS+JwSH/iXf3D70rGY9COYpKe+KuxTCE4R4ZnN8UR8prgdiEfT7ExxOhr
	 HXW0ZHBOHz/VJPeJANeFfPs3r54lPOngbnsu4T1L5RdtnBxlI7XeQiaTcZcl6BxJDjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j81A/FoDuaA6Txl8LYs2v9V+dkzqMpVkeIfikGatCXs=;
	b=ICXOZc2JuaMZq5MzoHt/sxk8vBvC8QAmQ7KX2tmrWKPeyms/upkZ95Pu+qvEJzbwzf0s
	 iCVfVe5UWJ5Jcdd70THjsBRlLxjY9/YIDY2YC52ZCHMIVzRN/hQ5UKU3TonffcNUm0dw9
	 CaORhSUrDgaLbgS1m42RBS+cb/JasG7+cWu+q9FKes1KOXrfo4uYu8Y9OOaUPhZn/jysA
	 U2EX3w6/z3yoyYnUK3xyRYyhKQLIlIBFjYgER4e50iLeksjr9CI2gkX5GwBCZ6j4Al+KY
	 Gb0YIjs0brRJasFICanTKln1C8OPOEMT0iPFJZ9f+fkxrrdP0wPAhsxrBkCXHI/xOaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdLL+7V4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdLL+7V4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DAF1F0093C;
	Tue, 10 Nov 2026 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351773;
	bh=j81A/FoDuaA6Txl8LYs2v9V+dkzqMpVkeIfikGatCXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdLL+7V40tFwfI7WQNO34UFxC1ILDX3ZbKLcxYN5seT6zhmHIhFayZ+UoNbazgWtd
	 Z3WhlmezMzzSKIJrGQjXZ+ub8XoGJiJf4hThJDm0HfmLWEMDN1IEK1hWrku4Y58XY7
	 otF5+yc1KCeyeGHymILx0rZRfbN2b+UeMrYEBwbw/6WNeFV7eDmJFQZNyFlS+qyoYt
	 lYjisoYxuQc9g3jtAM9uBp0QuCzbE9GrkYuV+kQYOpuxXN0rPmPULgPulzBnQh4vSq
	 twbU+X5wlwt+HwcsN4hWASPwq8UOvHQvShYm31cPj0XkjGjJfPBnBB1rUWwXlXRdX6
	 CXseKPeR7UpVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] block: amiflop: synchronize flush timer before track flush
Date: Tue, 10 Nov 2026 18:02:51 -0500
Message-ID: <20261110230048.48033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054347-failed-6.1-9690943353ce@kernel.org>
References: <20261107054347-failed-6.1-9690943353ce@kernel.org>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 9690943353cec1690a715e000ba6a74e5139f530 ]

The amiflop track buffer is shared with the timer callback. timer_delete()
does not wait for an in-flight callback, and that callback can rearm itself
when it cannot acquire the floppy controller. A synchronous track flush can
therefore race with the callback.

Stop the timer before synchronous track writes and use timer_delete_sync()
to wait for any callback already running. Keep callback rearming disabled
until the write is complete. Apply this to the FDFMTTRK path as well.

FDFLUSH, FDFMTTRK and close-time flushes run outside the blk-mq
request callback. Freeze their queues so an in-flight request cannot
change the shared track buffer while it is encoded and written. Restart
the timer if a track remains dirty after a failed flush.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260930065951.2932739-1-runyu.xiao@seu.edu.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: Adapted blk_mq_freeze_queue() and blk_mq_unfreeze_queue() calls to the older API without memflags. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/amiflop.c | 69 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 4c8b2ba579ee6..a5cf490c5fd68 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -264,6 +264,8 @@ static struct fd_data_type data_types[] = {
 static struct amiga_floppy_struct unit[FD_MAX_UNITS];
 
 static struct timer_list flush_track_timer[FD_MAX_UNITS];
+static DEFINE_SPINLOCK(flush_track_timer_lock);
+static bool flush_track_timer_stopped[FD_MAX_UNITS];
 static struct timer_list post_write_timer;
 static unsigned long post_write_timer_drive;
 static struct timer_list motor_on_timer;
@@ -1369,11 +1371,22 @@ static void flush_track_callback(struct timer_list *timer)
 					sizeof(flush_track_timer[0]);
 
 	nr&=3;
+	spin_lock(&flush_track_timer_lock);
+	if (flush_track_timer_stopped[nr]) {
+		spin_unlock(&flush_track_timer_lock);
+		return;
+	}
+	spin_unlock(&flush_track_timer_lock);
+
 	writefromint = 1;
 	if (!try_fdc(nr)) {
 		/* we might block in an interrupt, so try again later */
-		flush_track_timer[nr].expires = jiffies + 1;
-		add_timer(flush_track_timer + nr);
+		spin_lock(&flush_track_timer_lock);
+		if (!flush_track_timer_stopped[nr]) {
+			flush_track_timer[nr].expires = jiffies + 1;
+			add_timer(flush_track_timer + nr);
+		}
+		spin_unlock(&flush_track_timer_lock);
 		return;
 	}
 	get_fdc(nr);
@@ -1420,6 +1433,35 @@ static int non_int_flush_track (unsigned long nr)
 	return 1;
 }
 
+static void flush_track_timer_stop(unsigned int drive)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&flush_track_timer_lock, flags);
+	flush_track_timer_stopped[drive] = true;
+	spin_unlock_irqrestore(&flush_track_timer_lock, flags);
+
+	timer_delete_sync(flush_track_timer + drive);
+}
+
+static void flush_track_timer_start(unsigned int drive)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&flush_track_timer_lock, flags);
+	flush_track_timer_stopped[drive] = false;
+	if (unit[drive].dirty)
+		mod_timer(flush_track_timer + drive, jiffies + 1);
+	spin_unlock_irqrestore(&flush_track_timer_lock, flags);
+}
+
+static void flush_track_timer_sync(unsigned int drive)
+{
+	flush_track_timer_stop(drive);
+	non_int_flush_track(drive);
+	flush_track_timer_start(drive);
+}
+
 static int get_track(int drive, int track)
 {
 	int error, errcnt;
@@ -1434,8 +1476,7 @@ static int get_track(int drive, int track)
 	}
 
 	if (unit[drive].dirty == 1) {
-		del_timer (flush_track_timer + drive);
-		non_int_flush_track (drive);
+		flush_track_timer_sync(drive);
 	}
 	errcnt = 0;
 	while (errcnt < MAX_ERRORS) {
@@ -1562,6 +1603,12 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 	case FDFMTTRK:
 		if (param < p->type->tracks * p->type->heads)
 		{
+			flush_track_timer_stop(drive);
+			if (unit[drive].dirty == 1 &&
+			    !non_int_flush_track(drive)) {
+				flush_track_timer_start(drive);
+				return -EIO;
+			}
 			get_fdc(drive);
 			if (fd_seek(drive,param) != 0){
 				memset(p->trackbuf, FD_FILL_BYTE,
@@ -1570,6 +1617,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 			}
 			floppy_off(drive);
 			rel_fdc();
+			flush_track_timer_start(drive);
 		}
 		else
 			return -EINVAL;
@@ -1591,8 +1639,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 	case FDDEFPRM:
 		return -EINVAL;
 	case FDFLUSH: /* unconditionally, even if not needed */
-		del_timer (flush_track_timer + drive);
-		non_int_flush_track(drive);
+		flush_track_timer_sync(drive);
 		break;
 #ifdef RAW_IOCTL
 	case IOCTL_RAW_TRACK:
@@ -1611,9 +1658,14 @@ static int fd_ioctl(struct block_device *bdev, fmode_t mode,
 			     unsigned int cmd, unsigned long param)
 {
 	int ret;
+	bool freeze_queue = cmd == FDFMTTRK || cmd == FDFLUSH;
 
 	mutex_lock(&amiflop_mutex);
+	if (freeze_queue)
+		blk_mq_freeze_queue(bdev->bd_disk->queue);
 	ret = fd_locked_ioctl(bdev, mode, cmd, param);
+	if (freeze_queue)
+		blk_mq_unfreeze_queue(bdev->bd_disk->queue);
 	mutex_unlock(&amiflop_mutex);
 
 	return ret;
@@ -1715,9 +1767,9 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 	int drive = p - unit;
 
 	mutex_lock(&amiflop_mutex);
+	blk_mq_freeze_queue(disk->queue);
 	if (unit[drive].dirty == 1) {
-		del_timer (flush_track_timer + drive);
-		non_int_flush_track (drive);
+		flush_track_timer_sync(drive);
 	}
   
 	if (!fd_ref[drive]--) {
@@ -1727,6 +1779,7 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 #ifdef MODULE
 	floppy_off (drive);
 #endif
+	blk_mq_unfreeze_queue(disk->queue);
 	mutex_unlock(&amiflop_mutex);
 }
 
-- 
2.53.0

