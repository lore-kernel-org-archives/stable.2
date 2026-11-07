Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048229;
	b=E7ADpaytV/nyXLmrB1EA5FPrJOCKdHrW6D/BrRX3SxxFK7XoaXSXaq1pl3fqZw13h5+S
	 qYiWzSZh1/DVJnBZQDsOBLeWask99YtL+l7TQukHLJNMgqA49UNuQhwUCJx9BXc8d5HIQ
	 KSkNKZTwxO6kw9IPhl11YpYeYzQsUeLzZIA3TcbLAcFeXFND8n5FmXYPHVuLNJuhnf+LC
	 RkwPZb9S53scqlsSoGu1JfcnsiM8aH1v999b/J0KjLZhkzMoGZN3MCOXGZpvGghYGlTDA
	 9zZkcn9a3a5prfqL9357yD8nX6UsODePrXwUZ8z2J4LHzMl+/66g1F2xAQunpBAw6Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=D0InkPA0d1JQqcL+TZQ2oBPh/lD4JzZc3c4UntW5CJc=;
	b=wPVSngMEMPq5CHdMBMn7oZTBGJ2YiPUs+1QGiI4y12wBsyNZK7s5uPDceov6THWjORUa
	 tcOYP/fzzoZGIwWOCg5kXswsEXM0ALDlIhrVvTIyopeVcXotcUf53+Fa4HiphTNNVbmNm
	 IdRQ3MSH5Fcck2gigam0Xpino9wzkmT+NwQnlugrFcN3nZzDyjGTVgwSk/vZFaDYFnWWf
	 r4tvgurptJnBpyslqQ+GecurPPfuIlRCmXTpBRQ9SFbafWeBY9YGETPuAA2zpkI/Ay9Lk
	 mKB8xrO0kkTqybwDCP93+BYXo8245TIMxjJ79P02Wk6PG7Ue7e5nbrGW1YhYTmXfyWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOBEy7ID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOBEy7ID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4511F008A2;
	Sat,  7 Nov 2026 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048229;
	bh=D0InkPA0d1JQqcL+TZQ2oBPh/lD4JzZc3c4UntW5CJc=;
	h=From:To:Cc:Subject:Date;
	b=IOBEy7ID9kDuFMxPY8aMJX3HPdQAX7zovEIE7i9M/bunlkNJTESZx0rqFUR8aqisj
	 bO6kpmpE9sFR+Mi2j6ng9rfggeqEVqxMufcEe4wY2rS3Jo9sRyhLaqWL+ZEk+p0E/7
	 eo7E4nObZVFPfiPKq2+RkGS/YH13UQbRRiB9jDTtWx0aYYUIGaxrJ34yt9pYfkBAJ/
	 TS/VJI8WwlWua7CD4x6KrR9VgrO3riuTE+N+4G1n6/X+yM2HFh8MFqbaT9dbFGMpxg
	 wHKmNDC7wY4qFvwTJtO9qZk0mvtw1DqXMEh84e7sWvMHwExlsa/9Ukw/bw610TcALv
	 dao8wlEyonUdg==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] block: amiflop: synchronize flush timer before track flush" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:47 -0500
Message-ID: <20261107054347-failed-6.1-9690943353ce@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9690943353cec1690a715e000ba6a74e5139f530
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054347-failed-6.1-9690943353ce@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9690943353cec1690a715e000ba6a74e5139f530 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Wed, 30 Sep 2026 14:59:51 +0800
Subject: [PATCH] block: amiflop: synchronize flush timer before track flush

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
---
 drivers/block/amiflop.c | 71 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index 2932b6653b6f0..a477ada6b1ef5 100644
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
-		timer_delete(flush_track_timer + drive);
-		non_int_flush_track (drive);
+		flush_track_timer_sync(drive);
 	}
 	errcnt = 0;
 	while (errcnt < MAX_ERRORS) {
@@ -1562,6 +1603,12 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
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
@@ -1570,6 +1617,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 			}
 			floppy_off(drive);
 			rel_fdc();
+			flush_track_timer_start(drive);
 		}
 		else
 			return -EINVAL;
@@ -1591,8 +1639,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case FDDEFPRM:
 		return -EINVAL;
 	case FDFLUSH: /* unconditionally, even if not needed */
-		timer_delete(flush_track_timer + drive);
-		non_int_flush_track(drive);
+		flush_track_timer_sync(drive);
 		break;
 #ifdef RAW_IOCTL
 	case IOCTL_RAW_TRACK:
@@ -1611,9 +1658,15 @@ static int fd_ioctl(struct block_device *bdev, blk_mode_t mode,
 			     unsigned int cmd, unsigned long param)
 {
 	int ret;
+	unsigned int memflags = 0;
+	bool freeze_queue = cmd == FDFMTTRK || cmd == FDFLUSH;
 
 	mutex_lock(&amiflop_mutex);
+	if (freeze_queue)
+		memflags = blk_mq_freeze_queue(bdev->bd_disk->queue);
 	ret = fd_locked_ioctl(bdev, mode, cmd, param);
+	if (freeze_queue)
+		blk_mq_unfreeze_queue(bdev->bd_disk->queue, memflags);
 	mutex_unlock(&amiflop_mutex);
 
 	return ret;
@@ -1711,11 +1764,12 @@ static void floppy_release(struct gendisk *disk)
 {
 	struct amiga_floppy_struct *p = disk->private_data;
 	int drive = p - unit;
+	unsigned int memflags;
 
 	mutex_lock(&amiflop_mutex);
+	memflags = blk_mq_freeze_queue(disk->queue);
 	if (unit[drive].dirty == 1) {
-		timer_delete(flush_track_timer + drive);
-		non_int_flush_track (drive);
+		flush_track_timer_sync(drive);
 	}
   
 	if (!fd_ref[drive]--) {
@@ -1725,6 +1779,7 @@ static void floppy_release(struct gendisk *disk)
 #ifdef MODULE
 	floppy_off (drive);
 #endif
+	blk_mq_unfreeze_queue(disk->queue, memflags);
 	mutex_unlock(&amiflop_mutex);
 }
 
-- 
2.53.0




