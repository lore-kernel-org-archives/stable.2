Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352221;
	b=T2Y5WkxhYxGfdTq4bZyWTirD4tTScV4IYsCFoxaedgCOW4AgN9fJ4ghwgWxu6eMI8NwI
	 gUhHjolRNqP6QvNIoUHofEpYzGFq30TEvNfDivJD4h7JW6YuTwbE+K2bO5SBnKwU+SR4g
	 /Wg5DI9dA9szk4JZPCguerOtisA6vDLoFpR2Mejz9WRDSrvwU8hBHnkfKlUcQevwLJY+B
	 NUGE/M3o72JnGV1cRwfTAogrAByTsJMf8fiQlG/MYKb28upkMx2S42DXPPXF3K+nYYfQi
	 poAtfF1yQ9V+3JvTKOeOBUFoG2oFj6fGgXym0Z9WLLCEyaeCvdzm1+3AgLuAv/bDHYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x9zN8BpvTmeKTczDRXZmo9X1mugHkLUORrNrHN5VqFI=;
	b=kTqMtzTS+kKBCAS44A1uX3At2KGxQCn6SNocKojslWWdMqlxBUueSzsAwPg2C5NrHdfY
	 4IGmuri2/8jmA/PxQEFJ+sN8YDX50mFgZuBKcRZbjIA8wTkUN59wlSroXFIlTsYRLyIKI
	 yePILTLOK2fy6tmSpEzE9llmyaBvNovQuxuN051KDVCcxQUr+FbH9Uw9KJWIwt9qUD3gS
	 H4KHpg+vw7dkLppwZFzeAQ5NiBUwectAqbBGaSa5PJYHC06+0+jvNgI/geh1vTdCLY+NV
	 1hyaEYbCzFIRWFxrGUhYsuZHHt0GrMiUqDg3pheqktDhPoTEwz5r8mszltD16ygbsgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMyqiDj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMyqiDj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD64E1F0093C;
	Tue, 10 Nov 2026 23:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352221;
	bh=x9zN8BpvTmeKTczDRXZmo9X1mugHkLUORrNrHN5VqFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMyqiDj4zBBxQVHXRLBwrENyCLnwCbSO5S7Fo/JB+BxtOytYzoqpQtQx72zKu/ukL
	 TVgMnPcAFh2Ls3OuKuFxoIlp8CXtNKkRNlCuvl1ozAcWhX5qcus4jt25UZClQe8vGj
	 jvR8Jo0qIV1OfpKh4Uq0ds4YROTR2/0fGYJ0UKHEoXTpbes4PRITwxZ/PMNyGLoVHK
	 6BYwRM973B/wh+y3dqUDRA9ZcbslupyeRt8zGWSTv8GFWFv2DyQwLH2OIH80uUf7l+
	 JVym8Yu9ANQ8PxXaF3KMIj7MM/VRns/EJZ2pTt5IlB8eimTl4Clq4DW+YwDrIfxIki
	 mXMHExcAPvQdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] block: amiflop: synchronize flush timer before track flush
Date: Tue, 10 Nov 2026 18:10:19 -0500
Message-ID: <20261110230918.76289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060127-failed-5.15-9690943353ce@kernel.org>
References: <20261107060127-failed-5.15-9690943353ce@kernel.org>
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
[ sashal: adapted blk_mq_freeze_queue() and blk_mq_unfreeze_queue() calls to the older API without memflags ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/amiflop.c | 69 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 1ed557cb5ed23..46e134259e19c 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -265,6 +265,8 @@ static struct fd_data_type data_types[] = {
 static struct amiga_floppy_struct unit[FD_MAX_UNITS];
 
 static struct timer_list flush_track_timer[FD_MAX_UNITS];
+static DEFINE_SPINLOCK(flush_track_timer_lock);
+static bool flush_track_timer_stopped[FD_MAX_UNITS];
 static struct timer_list post_write_timer;
 static unsigned long post_write_timer_drive;
 static struct timer_list motor_on_timer;
@@ -1370,11 +1372,22 @@ static void flush_track_callback(struct timer_list *timer)
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
@@ -1421,6 +1434,35 @@ static int non_int_flush_track (unsigned long nr)
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
@@ -1435,8 +1477,7 @@ static int get_track(int drive, int track)
 	}
 
 	if (unit[drive].dirty == 1) {
-		del_timer (flush_track_timer + drive);
-		non_int_flush_track (drive);
+		flush_track_timer_sync(drive);
 	}
 	errcnt = 0;
 	while (errcnt < MAX_ERRORS) {
@@ -1563,6 +1604,12 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1571,6 +1618,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 			}
 			floppy_off(drive);
 			rel_fdc();
+			flush_track_timer_start(drive);
 		}
 		else
 			return -EINVAL;
@@ -1592,8 +1640,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 	case FDDEFPRM:
 		return -EINVAL;
 	case FDFLUSH: /* unconditionally, even if not needed */
-		del_timer (flush_track_timer + drive);
-		non_int_flush_track(drive);
+		flush_track_timer_sync(drive);
 		break;
 #ifdef RAW_IOCTL
 	case IOCTL_RAW_TRACK:
@@ -1612,9 +1659,14 @@ static int fd_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1716,9 +1768,9 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 	int drive = p - unit;
 
 	mutex_lock(&amiflop_mutex);
+	blk_mq_freeze_queue(disk->queue);
 	if (unit[drive].dirty == 1) {
-		del_timer (flush_track_timer + drive);
-		non_int_flush_track (drive);
+		flush_track_timer_sync(drive);
 	}
   
 	if (!fd_ref[drive]--) {
@@ -1728,6 +1780,7 @@ static void floppy_release(struct gendisk *disk, fmode_t mode)
 #ifdef MODULE
 	floppy_off (drive);
 #endif
+	blk_mq_unfreeze_queue(disk->queue);
 	mutex_unlock(&amiflop_mutex);
 }
 
-- 
2.53.0

