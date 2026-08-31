Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57337107E
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194579; cv=none; b=hwiJ5qw/P/4JG/+dPDe/+s3G+5AwRKyx//T7DnZEcAee11D0+AOtJkX2h7TednbIvncygA+HvOyOy4wi0LJiXGXfA6CCgh9jVcq3/NkeOPJF+IP4Hoksx6zjv0YryO0wzZYknBi90uSUp9IkVGh6hXF++IMcNGywtjTxQ+iYACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194579; c=relaxed/simple;
	bh=peqU9CrmBoPUTBMwh+0474swFwRgQdYHBH7/w4cPFJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl00+dIVorsu3qRauAoh2TLkf1hWK58OwEpwLWGDxYIqN4slXw+T4+MTFW2POafPLkMpV27UviUzFM2ucSK/nJtN7DZwT8s1UUo+hMCNQi7A0kF8ybHBXwhdeXG1SnHYAEs2HwcLydiRwaC1pGw6JyySvRqNaxJ2Ht4O+gCiUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFKzrqA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFKzrqA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E241F000E9;
	Mon, 31 Aug 2026 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194577;
	bh=VsJ+qeavM686otgi+qQjlOug8wRg8n/44BE1Aze1X5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFKzrqA6+ezEdYa0glyxDp1Ob4Mk2S1CiglJ7V8ABwgsDy4txesEQ5zLJYG4ORtp2
	 fotiZMF3tr/JxD1yfkXZC/vgQ5F0txEhswRU3N8POEpXhkzdVnoGXZNchEyM5PqNbN
	 hulnyKM5NKp8DJ4bNW+sEpk9BvDhnkGYKfMJuze39GIYitVgej9qcIi7FvJYSS1Ta2
	 BpfcKBiBBamkgd4a9XygLUOUaQPhDDOI1nmyfC8dkCA/Z1bMp2NM/D/aXyWl39cSLX
	 UYcfnFBk3OeJ1eH9kTY1Tf0OxsWsIOvMwjNPRrgEtPeW8zxeWo8lTrui0gowmLmhSB
	 582l6RvhescxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] fuse: abort related layering cleanup
Date: Mon, 31 Aug 2026 12:42:53 -0400
Message-ID: <20260831164256.270090-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083101-rimless-sadness-3898@gregkh>
References: <2026083101-rimless-sadness-3898@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 4eeb5e6cb0fd89b343fcf755ae3aad76fdb5b2c2 ]

 - rename fuse_abort_conn() to fuse_chan_abort(), pass fuse_chan pointer
   instead of fuse_conn

 - pass an abort_with_err argument that tells fuse_dev_(read|write) to
   return with ECONNABORTED instead of ENODEV

 - move fc->aborted to fch->abort_with_err

 - rename fuse_wait_aborted() to fuse_chan_wait_aborted()

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

[ 6.18 has no "struct fuse_chan" -- the connection object still plays
  that role, and the surrounding series that splits it out is not in
  stable.  Adapted as follows:

  - the renames (fuse_abort_conn() -> fuse_chan_abort(),
    fuse_wait_aborted() -> fuse_chan_wait_aborted(), the "abort_conn"
    label in fuse_check_timeout() -> "chan_abort") and the new
    abort_with_err argument are taken as-is, but both helpers keep
    taking "struct fuse_conn *".

  - the "move fc->aborted to fch->abort_with_err" bullet is dropped:
    there is no fuse_chan to move the flag into, so fc->aborted stays
    in struct fuse_conn.  fuse_chan_abort() only ever *sets* it, as
    control.c did before, rather than assigning the new argument
    unconditionally the way upstream does: on this tree the flag is
    write-once and is what makes fuse_dev_do_read() and
    fuse_uring_cmd() report ECONNABORTED instead of ENODEV, so letting
    a later abort with abort_with_err=false clear it (umount -f,
    fuse_conn_destroy(), fuse_dev_release(), the timeout worker) would
    change what userspace sees after a sysfs abort on an abort_err
    mount.  Consequently the fuse_dev_i.h and dev_uring.c hunks, which
    only rename the field access, are dropped as well.

  - fs/fuse/dev.h and fs/fuse/req_timeout.c do not exist here: the
    declarations stay in fuse_i.h and fuse_check_timeout() lives in
    dev.c, so those two hunks were replayed there.

  - in request_wait_answer() the connection pointer is named "fch",
    matching the name upstream gives it in 28d733cc3ecad ("fuse: change
    req->fm to req->chan"), so that the follow-up fix applies here
    unchanged. ]

[ sashal: Reduced backport -- upstream 4eeb5e6cb0fd8 touches 9 file(s), this
  backport carries 5. Not backported here:
  fs/fuse/dev.h
  fs/fuse/dev_uring.c
  fs/fuse/fuse_dev_i.h
  fs/fuse/req_timeout.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 64b0b5cacbd2 ("fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/control.c |  4 +---
 fs/fuse/cuse.c    |  4 ++--
 fs/fuse/dev.c     | 35 +++++++++++++++++++----------------
 fs/fuse/fuse_i.h  |  4 ++--
 fs/fuse/inode.c   |  6 +++---
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2e300f6d646c3..5536d6ee65514 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -37,9 +37,7 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
 {
 	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
 	if (fc) {
-		if (fc->abort_err)
-			fc->aborted = true;
-		fuse_abort_conn(fc);
+		fuse_chan_abort(fc, fc->abort_err);
 		fuse_conn_put(fc);
 	}
 	return count;
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 2bb98bf81b079..d90f138321fe9 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -425,7 +425,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 err_region:
 	unregister_chrdev_region(devt, 1);
 err:
-	fuse_abort_conn(fc);
+	fuse_chan_abort(fc, false);
 	goto out;
 }
 
@@ -593,7 +593,7 @@ static ssize_t cuse_class_abort_store(struct device *dev,
 {
 	struct cuse_conn *cc = dev_get_drvdata(dev);
 
-	fuse_abort_conn(&cc->fc);
+	fuse_chan_abort(&cc->fc, false);
 	return count;
 }
 static DEVICE_ATTR(abort, 0200, NULL, cuse_class_abort_store);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 77c3982bca3d7..934f9ac5056ed 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -87,13 +87,13 @@ void fuse_check_timeout(struct work_struct *work)
 	expired = fuse_request_expired(fc, &fiq->pending);
 	spin_unlock(&fiq->lock);
 	if (expired)
-		goto abort_conn;
+		goto chan_abort;
 
 	spin_lock(&fc->bg_lock);
 	expired = fuse_request_expired(fc, &fc->bg_queue);
 	spin_unlock(&fc->bg_lock);
 	if (expired)
-		goto abort_conn;
+		goto chan_abort;
 
 	spin_lock(&fc->lock);
 	if (!fc->connected) {
@@ -107,7 +107,7 @@ void fuse_check_timeout(struct work_struct *work)
 		    fuse_fpq_processing_expired(fc, fpq->processing)) {
 			spin_unlock(&fpq->lock);
 			spin_unlock(&fc->lock);
-			goto abort_conn;
+			goto chan_abort;
 		}
 
 		spin_unlock(&fpq->lock);
@@ -115,15 +115,15 @@ void fuse_check_timeout(struct work_struct *work)
 	spin_unlock(&fc->lock);
 
 	if (fuse_uring_request_expired(fc))
-	    goto abort_conn;
+	    goto chan_abort;
 
 out:
 	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
-abort_conn:
-	fuse_abort_conn(fc);
+chan_abort:
+	fuse_chan_abort(fc, false);
 }
 
 static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
@@ -180,7 +180,7 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
 {
 	/*
 	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
-	 * provides a memory barrier matched with the one in fuse_wait_aborted()
+	 * provides a memory barrier matched with the one in fuse_chan_wait_aborted()
 	 * to ensure no wake-up is missed.
 	 */
 	if (atomic_dec_and_test(&fc->num_waiting) &&
@@ -551,11 +551,11 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
 
 static void request_wait_answer(struct fuse_req *req)
 {
-	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_conn *fch = req->fm->fc;
+	struct fuse_iqueue *fiq = &fch->iq;
 	int err;
 
-	if (!fc->no_interrupt) {
+	if (!fch->no_interrupt) {
 		/* Any signal may interrupt this */
 		err = wait_event_interruptible(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
@@ -579,7 +579,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 
 		if (req->args->abort_on_kill) {
-			fuse_abort_conn(fc);
+			fuse_chan_abort(fch, false);
 			return;
 		}
 
@@ -1491,7 +1491,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	spin_lock(&fpq->lock);
 	/*
 	 *  Must not put request on fpq->io queue after having been shut down by
-	 *  fuse_abort_conn()
+	 *  fuse_chan_abort()
 	 */
 	if (!fpq->connected) {
 		req->out.h.error = err = -ECONNABORTED;
@@ -2475,10 +2475,13 @@ static void end_polls(struct fuse_conn *fc)
  * is OK, the request will in that case be removed from the list before we touch
  * it.
  */
-void fuse_abort_conn(struct fuse_conn *fc)
+void fuse_chan_abort(struct fuse_conn *fc, bool abort_with_err)
 {
 	struct fuse_iqueue *fiq = &fc->iq;
 
+	if (abort_with_err)
+		fc->aborted = true;
+
 	spin_lock(&fc->lock);
 	if (fc->connected) {
 		struct fuse_dev *fud;
@@ -2547,9 +2550,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 	}
 }
-EXPORT_SYMBOL_GPL(fuse_abort_conn);
+EXPORT_SYMBOL_GPL(fuse_chan_abort);
 
-void fuse_wait_aborted(struct fuse_conn *fc)
+void fuse_chan_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
 	smp_mb();
@@ -2579,7 +2582,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		/* Are we the last open device? */
 		if (atomic_dec_and_test(&fc->dev_count)) {
 			WARN_ON(fc->iq.fasync != NULL);
-			fuse_abort_conn(fc);
+			fuse_chan_abort(fc, false);
 		}
 		fuse_dev_free(fud);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c288f28f6c6ea..8b745045f1ab3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1272,8 +1272,8 @@ void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
 void fuse_request_end(struct fuse_req *req);
 
 /* Abort all requests */
-void fuse_abort_conn(struct fuse_conn *fc);
-void fuse_wait_aborted(struct fuse_conn *fc);
+void fuse_chan_abort(struct fuse_conn *fc, bool abort_with_err);
+void fuse_chan_wait_aborted(struct fuse_conn *fc);
 
 /* Check if any requests timed out */
 void fuse_check_timeout(struct work_struct *work);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9ed693fc7b37..399298816dea0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -621,7 +621,7 @@ static void fuse_umount_begin(struct super_block *sb)
 	if (fc->no_force_umount)
 		return;
 
-	fuse_abort_conn(fc);
+	fuse_chan_abort(fc, false);
 
 	// Only retire block-device-based superblocks.
 	if (sb->s_bdev != NULL)
@@ -2099,8 +2099,8 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 	if (fc->destroy)
 		fuse_send_destroy(fm);
 
-	fuse_abort_conn(fc);
-	fuse_wait_aborted(fc);
+	fuse_chan_abort(fc, false);
+	fuse_chan_wait_aborted(fc);
 
 	if (!list_empty(&fc->entry)) {
 		mutex_lock(&fuse_mutex);
-- 
2.53.0

