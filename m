Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047005;
	b=qODPHrZP5qIEx6sibbTFs0VqrdFXs+AQIN3brc51auXKM+OzuC7YW7mJ5jlgZ4C6f08N
	 6r5bIGwUe3aeI5t15ongi2LBa6YkIWYxaXDwqOfrh0Bs1BrYIp8T97hyugtp84fwzaN13
	 t+wpwmdK8wf/s5lT/V+xqMryY/ICkn+i7rcmcAW5PiF+PE/rlHRzGLDsDLKlm0t+2CeHx
	 QfO84bM8s2wdzAUirlxwL6X0i+eAWKgyxckCWG4svGoF+sek8m52ZMfNKYuR7kfpZ3QOT
	 VscE3a6u24GMXNpvcAQc32k6K4sL4wl0qPD8byqx3RI/Dv1EN8WpGg9tBp9Cn8oyvyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KVPoZXi+JbOGg0jt7FCP5XrNBHc3wmSLdtep6iwC/5Y=;
	b=W4opvepmY8KbIR1PpezQCkEB6qUE+ivByUDVxwwyzWwQN9a/LKDs2CKn6HNi5weQ5LYK
	 RQmoKDjJKFvEEEOqrh9DNJH7Kjq+n6doR2r/Mnsc4qGM1VqpzY7d2KmZNg2Q82C3aD/BX
	 OIRrqawS2Gj/IUHCrpXpqMptkDd02Nu6IUM1SzDTphxi2FwOlScUQf4xfa4PK1uC35rpt
	 dIcmVA8i05/5OCQIuBENxuKwoSpxr9S++nNfPgt3DroVNpJnAwPuUEYfMCcgVD7N/J48b
	 qVxbdh/Y6POJQkVpOibjGvIs34iz3XQRSdFm9nDldwrK4iakL30fHmss0Ij8bYY7YoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IA+sEe7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221B606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IA+sEe7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593511F0089F;
	Sat,  7 Nov 2026 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047004;
	bh=KVPoZXi+JbOGg0jt7FCP5XrNBHc3wmSLdtep6iwC/5Y=;
	h=From:To:Cc:Subject:Date;
	b=IA+sEe7r4Ksm6kFNsej+uSmUPTxgyit5rpBMswRYGywPTbcPPuX7XxhQqjDUbkJud
	 2wqOdTr4OiYyUBp2FzWcnN80Uj07ixYXyo2tfDCZb6QtOJHDGJWsP0UzUfNScsX21L
	 OZL1hOfUQNwiBOc0qbuD42B2+RZKogMGnxCEoFyMWpZTFCCabnaAbQwc2dsMmrweD3
	 /P5YYCGJgFkzvBd7Zo/p6jLec6TbBYIm9puoHD+gueDoE6NnmW6DLg2ii5sIGWSyU6
	 S4mvpmR4pYtYCWBx4eU0UmS6Q8o13OrNtVaaM3n+lP+AKVEP9RSJQ+7Fu4c5+FXbbx
	 O3GpD+1Ij1g7A==
From: Sasha Levin <sashal@kernel.org>
To: tom.leiming@gmail.com,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ublk: let STOP_DEV cancel the server's commands before its release" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:23 -0500
Message-ID: <20261107052323-failed-6.12-c8b349f9daf6@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c8b349f9daf6d88ff21033028167d00e819dafb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052323-failed-6.12-c8b349f9daf6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c8b349f9daf6d88ff21033028167d00e819dafb6 Mon Sep 17 00:00:00 2001
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 11 Oct 2026 01:35:50 -0500
Subject: [PATCH] ublk: let STOP_DEV cancel the server's commands before its
 release

STOP_DEV cancels the fetched commands after dropping ub->mutex, so
START_DEV and FETCH can run in between:

  STOP_DEV                          START_DEV / FETCH
  lock ub->mutex
    ublk_stop_dev_unlocked()        (not started: does nothing)
  unlock ub->mutex
                                    START_DEV goes live, schedules scan
                                    FETCH publishes a new command
  cancel_work_sync(scan)            cancels the new disk's scan
  ublk_cancel_dev()                 takes the new command: NULL io->cmd
                                    on a queue which isn't canceling

A START_DEV after STOP_DEV also goes live over the canceled commands.

Hold a reference on the server's /dev/ublkcN while canceling:

  STOP_DEV
  lock ub->mutex
    ublk_stop_dev_unlocked()
    cancel_work_sync(scan)
    server attached: take a reference on its file, set STOPPING
  unlock ub->mutex
  ublk_cancel_dev()
  drop the reference

 - STOPPING makes FETCH and PREP get UBLK_IO_RES_ABORT and START_DEV
   -EBUSY; a START_DEV or END_USER_RECOVERY waiting for the device
   to get ready wakes up too; the reset in the server's release
   clears it
 - the release can't run before the reference is dropped, so no new
   server can attach, and the cancel only meets this server's commands
 - the cancel still runs after the unlock: io_uring_cmd_done() may take
   uring_lock, under which FETCH takes ub->mutex

ublk_ch_open() saves the file in ->ch_file and ublk_ch_release() clears
it, under cancel_mutex. The release runs after the last reference is
gone, so take ours with file_ref_get(). Drop it with __fput_sync(): if
it is the last one, fput() would defer the release to this task, which
DEL_DEV then makes wait for the device to be freed.

A server which opened the device but hasn't fetched is stopped too.
Document what a server sees after STOP_DEV in ublk.rst.

Fixes: 85248d670b71 ("ublk: move ublk_cancel_dev() out of ub->mutex")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20261011063555.1142277-8-tom.leiming@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 Documentation/block/ublk.rst |  7 ++++
 drivers/block/ublk_drv.c     | 80 ++++++++++++++++++++++++++++++++----
 2 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 28300fee22bfc..ed3285e361ad5 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -126,6 +126,13 @@ managing and controlling ublk devices with help of several control commands:
   ublk server will release resources (such as destroying I/O handler threads &
   io_uring).
 
+  If a server has ``/dev/ublkc*`` open, its fetched I/O commands complete with
+  ``UBLK_IO_RES_ABORT``. Until it closes ``/dev/ublkc*``, new
+  ``UBLK_IO_FETCH_REQ`` and ``UBLK_U_IO_PREP_IO_CMDS`` commands complete with
+  ``UBLK_IO_RES_ABORT`` too, and ``UBLK_CMD_START_DEV`` fails with ``-EBUSY``,
+  even if the server hadn't fetched anything. The device can be started again
+  by a server that opens ``/dev/ublkc*`` after that.
+
 - ``UBLK_CMD_DEL_DEV``
 
   Remove ``/dev/ublkc*``. When this command returns, the allocated ublk device
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c0a112a9bf426..e315d10ba21cc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -321,6 +321,8 @@ struct ublk_device {
 #define UB_STATE_OPEN		0
 #define UB_STATE_USED		1
 #define UB_STATE_DELETED	2
+/* STOP_DEV canceled the server's commands, until its release */
+#define UB_STATE_STOPPING	3
 	unsigned long		state;
 	int			ub_number;
 
@@ -334,6 +336,8 @@ struct ublk_device {
 	u16			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
+	/* the open /dev/ublkcN, protected by cancel_mutex */
+	struct file *ch_file;
 	/*
 	 * A cancel started in this FETCH round. Set by ublk_set_canceling(),
 	 * cleared only by ublk_reset_ch_dev() when a new round starts. While
@@ -2406,6 +2410,9 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	filp->private_data = ub;
 	ub->ublksrv_tgid = current->tgid;
+	mutex_lock(&ub->cancel_mutex);
+	ub->ch_file = filp;
+	mutex_unlock(&ub->cancel_mutex);
 	return 0;
 }
 
@@ -2432,6 +2439,7 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->nr_queue_ready = 0;
 	ub->unprivileged_daemons = false;
 	ub->ublksrv_tgid = -1;
+	clear_bit(UB_STATE_STOPPING, &ub->state);
 }
 
 static struct gendisk *ublk_get_disk(struct ublk_device *ub)
@@ -2635,6 +2643,9 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
 
+	mutex_lock(&ub->cancel_mutex);
+	ub->ch_file = NULL;
+	mutex_unlock(&ub->cancel_mutex);
 	/*
 	 * Grab ublk device reference, so it won't be gone until we are
 	 * really released from work function.
@@ -3026,13 +3037,54 @@ static void ublk_stop_dev_unlocked(struct ublk_device *ub)
 	put_disk(disk);
 }
 
+static struct file *ublk_get_ch_file(struct ublk_device *ub)
+{
+	struct file *file;
+
+	mutex_lock(&ub->cancel_mutex);
+	file = ub->ch_file;
+	if (file && !file_ref_get(&file->f_ref))
+		file = NULL;
+	mutex_unlock(&ub->cancel_mutex);
+	return file;
+}
+
 static void ublk_stop_dev(struct ublk_device *ub)
 {
+	struct file *file;
+
+	/*
+	 * FETCH, PREP and START_DEV take ub->mutex. If a server has
+	 * /dev/ublkcN open, set STOPPING, which turns it away, and hold a
+	 * reference on the file: the server's release, whose reset clears
+	 * STOPPING and lets a new server attach, can't run before we drop it.
+	 * So the cancel can run after the unlock and only meets this server's
+	 * commands; it has to: io_uring_cmd_done() may take uring_lock, under
+	 * which FETCH takes ub->mutex.
+	 */
 	mutex_lock(&ub->mutex);
 	ublk_stop_dev_unlocked(ub);
-	mutex_unlock(&ub->mutex);
 	cancel_work_sync(&ub->partition_scan_work);
+	file = ublk_get_ch_file(ub);
+	if (file) {
+		/*
+		 * The server has to close /dev/ublkcN before this device can
+		 * be started again: the reset in its release clears STOPPING.
+		 */
+		set_bit(UB_STATE_STOPPING, &ub->state);
+		/* for wake_up_var() below, see wake_up_bit() */
+		smp_mb__after_atomic();
+	}
+	mutex_unlock(&ub->mutex);
+
+	/* no server: nothing to cancel */
+	if (!file)
+		return;
+
+	/* wake a START_DEV waiting for the device to get ready */
+	wake_up_var(&ub->nr_queue_ready);
 	ublk_cancel_dev(ub);
+	__fput_sync(file);
 }
 
 static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
@@ -3297,6 +3349,9 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 			struct ublk_io *io, u16 q_id)
 {
+	if (test_bit(UB_STATE_STOPPING, &ub->state))
+		return UBLK_IO_RES_ABORT;
+
 	/* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
 	if (ublk_dev_ready(ub))
 		return -EBUSY;
@@ -4476,22 +4531,27 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 	return ub->ublksrv_tgid == ublksrv_pid;
 }
 
+static bool ublk_dev_ready_or_stopping(const struct ublk_device *ub)
+{
+	return ublk_dev_ready(ub) || test_bit(UB_STATE_STOPPING, &ub->state);
+}
+
 /*
- * Wait until all queues have fetched their I/O commands, and return with
- * ub->mutex held and readiness guaranteed. The queues stay canceling if
- * this round saw a cancel, see ublk_queue_reset_io_flags(). Ready may
- * regress between wakeup and mutex_lock() (F_BATCH UNPREP, daemon death),
- * so re-check it under the mutex and wait again.
+ * Wait until all queues have fetched their I/O commands, or STOP_DEV set
+ * UB_STATE_STOPPING, and return with ub->mutex held. The queues stay
+ * canceling if this round saw a cancel, see ublk_queue_reset_io_flags().
+ * Ready may regress between wakeup and mutex_lock() (F_BATCH UNPREP,
+ * daemon death), so re-check it under the mutex and wait again.
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
 	while (true) {
 		if (wait_var_event_interruptible(&ub->nr_queue_ready,
-						 ublk_dev_ready(ub)))
+						 ublk_dev_ready_or_stopping(ub)))
 			return -EINTR;
 
 		mutex_lock(&ub->mutex);
-		if (ublk_dev_ready(ub))
+		if (ublk_dev_ready_or_stopping(ub))
 			return 0;
 		mutex_unlock(&ub->mutex);
 	}
@@ -4591,6 +4651,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		ret = -EEXIST;
 		goto out_unlock;
 	}
+	if (test_bit(UB_STATE_STOPPING, &ub->state)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
 
 	disk = blk_mq_alloc_disk(&ub->tag_set, &lim, NULL);
 	if (IS_ERR(disk)) {
-- 
2.53.0




