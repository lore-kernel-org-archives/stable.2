Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050293;
	b=VgVi459tQh6tH37gzXKC7rvDbQzuUGoVQB81nFS7+igcjjIqvkjqL7dBpMsS8x2UdoEl
	 xXCdRjLhN1ZErw2dXNSKUipnXom7GA+AaBrxrc66VOn9xMjmJ4v32JoLrsu1QoYLsRoKL
	 c7dQTKxZPCOUSkCGX+ITUXqKlaIpxmem2uzT7Ifrbm6D/n8CznfBL/RnLR8kVvOJtH+YK
	 k3H7EKo4ntiXjaYR/eU49FQtYbcPt4Tc7nhJlpZVA0OUb2X28RoY/KRQOMfnV2Szw2XHN
	 CKzUfSooEd+fJNUCprj1Ld9ngCPjjkGVqep7ablSq/48dJmp7ngM8NL29AwjnA0Mk7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SY85j4gfuR5rtz7Iq80c90sZ/rdX+rm16oX4GwNQEs4=;
	b=Z2DWX/X/3kK96oYdDy9pFsbxnlhRbDeLUUtLIxIZgb6ztxEm9vcVqOGDrb6JdtsHX3dK
	 FwdpI71wrrWPXyInkwtK04HgSsuJp/7GGEcPhSf0OmtStRyIh/qRdr1kwfZ7oFcvOR8FY
	 FnJDTwVej4uv4G4QYPS4kgogm1a0st5F8r6sRXtLHpu9zAonUmQU+Dba3ONaASLHtaqQY
	 hzF/JSgevbjp562aYhzyHNfEkLdDENo+jdMIAyojkLm6CPp4DmZ399pxZFyZ4nKnKgECj
	 xqBwoDSKRMVRa0/vs4iH2ijGtUqZMATVV6oc7TJs7RWSU/HzsqiCr/E0NO9nzJ93w0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGCkCq3p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGCkCq3p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39A11F0089F;
	Sat,  7 Nov 2026 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050293;
	bh=SY85j4gfuR5rtz7Iq80c90sZ/rdX+rm16oX4GwNQEs4=;
	h=From:To:Cc:Subject:Date;
	b=hGCkCq3pPq0jRxUHG4Oat0ac2oCNTywwjXrK9Jirgc7o+9N1vzCydggpSziegpHve
	 Qc+T7EPAztb1cF4I5J0KnCt6Kpx9TMBHdjgzg/PsymdLxqnkgyLj5WLi2r7GYAS5YX
	 vmebgad8Ux/+PVnq4vc7BWm8XoAXmFgrggYGqmM4ODQl3guAEw5aFoIyU4NaITrrTg
	 J5P6r/cx89wF8PvgP0OsxreYEK2G2nKRTM6qITKoPwZxM+CDMa48s5XmTbjV+KFaiw
	 ZY6kA8ArNKV416FhWN2LUQB4eswGGTTfMbP8N7975bTtbypPUpIhDulcT7l0KNA7bj
	 BdbGTFMFMCzDQ==
From: Sasha Levin <sashal@kernel.org>
To: runyu.xiao@seu.edu.cn,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] block: amiflop: synchronize flush timer before track flush" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:18:11 -0500
Message-ID: <20261107061811-failed-5.10-9690943353ce@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9690943353cec1690a715e000ba6a74e5139f530
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061811-failed-5.10-9690943353ce@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




