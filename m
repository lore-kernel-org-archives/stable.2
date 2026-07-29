Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737A282F35
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333033; cv=none; b=cgp/8EakjoysX01ffDMPP/cEIch2V+HPHs/naY9UXJjmnAbOM+Ulv3O+jLmGQwJDrbyZnH1XsoGoQ2wE9zCxTy4nVuyPvj7Rj5MUgBVrxTri4F+2oh1psVDEALheNerozG4DYhMlefku2ObHiyPeDnvcYS12mC630l3YHdOtVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333033; c=relaxed/simple;
	bh=5gvfLMb9L1IBcWj8x/KzWojQEtdSEOVgae2w5NFPTT8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u95Bt8/CobWaPM6iM4aGnK0bGetkwioRojNTFSDcurMM9H7ERTW2iSmNz8sGi1SKOgjU7tLABtlv6drIO1smz4OauRL8KlBtpnJDjEVVbPH+Q0MBG8rIKPqdc2zlFz7fbroVchvzUBEac7JYgO8JzgICO5Etys3LiFDr1wq59b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Noyua/uh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Noyua/uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C6C1F00A3A;
	Wed, 29 Jul 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333026;
	bh=BjZrYUz7z8x5hDiK1Nq3LalBPT+y2SzrfrJB3sgC3jk=;
	h=Subject:To:Cc:From:Date;
	b=Noyua/uhQz+WlGuSVDX4wVZUrdbHCl7yjn863YzDdjHCnC1whxlSqA1c3pFYC8MfQ
	 SLINjl+aRIV1oDuwRqh8RHtxQ7ehWEBl6Jv5fmV0zXgzhYfVNnIj75drcVVxazCJ9z
	 hREQ/Y1Pg+9SHMvejFpHiKQRl3bksixAGsEcdM2E=
Subject: FAILED: patch "[PATCH] io_uring/rw: fix missing ERESTARTSYS conversion in read paths" failed to apply to 6.12-stable tree
To: yi1tang.yang@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:50:12 +0200
Message-ID: <2026072912-manpower-thrift-f2fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ab05caca123c6d0b41850b7c05b246e4dca4a770
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072912-manpower-thrift-f2fd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab05caca123c6d0b41850b7c05b246e4dca4a770 Mon Sep 17 00:00:00 2001
From: Yitang Yang <yi1tang.yang@gmail.com>
Date: Wed, 22 Jul 2026 20:45:51 +0800
Subject: [PATCH] io_uring/rw: fix missing ERESTARTSYS conversion in read paths

Both read and write may receive internal restart error codes from
the filesystem layer and should be converted to -EINTR. However,
when multishot read support was added, the error code normalization
was lost for both io_read() and io_read_mshot().

Extract the conversion into io_fixup_restart_res() and apply it
in all three locations: io_rw_done(), io_read(), and io_read_mshot().

Fixes: a08d195b586a ("io_uring/rw: split io_read() into a helper")
Cc: stable@vger.kernel.org
Signed-off-by: Yitang Yang <yi1tang.yang@gmail.com>
Link: https://patch.msgid.link/20260722124551.130563-1-yi1tang.yang@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 63b6519e498c..95038cfda615 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -615,6 +615,24 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	smp_store_release(&req->iopoll_completed, 1);
 }
 
+static inline ssize_t io_fixup_restart_res(ssize_t ret)
+{
+	switch (ret) {
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/*
+		 * We can't just restart the syscall, since previously
+		 * submitted sqes may already be in progress. Just fail
+		 * this IO with EINTR.
+		 */
+		return -EINTR;
+	default:
+		return ret;
+	}
+}
+
 static inline void io_rw_done(struct io_kiocb *req, ssize_t ret)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
@@ -624,21 +642,8 @@ static inline void io_rw_done(struct io_kiocb *req, ssize_t ret)
 		return;
 
 	/* transform internal restart error codes */
-	if (unlikely(ret < 0)) {
-		switch (ret) {
-		case -ERESTARTSYS:
-		case -ERESTARTNOINTR:
-		case -ERESTARTNOHAND:
-		case -ERESTART_RESTARTBLOCK:
-			/*
-			 * We can't just restart the syscall, since previously
-			 * submitted sqes may already be in progress. Just fail
-			 * this IO with EINTR.
-			 */
-			ret = -EINTR;
-			break;
-		}
-	}
+	if (unlikely(ret < 0))
+		ret = io_fixup_restart_res(ret);
 
 	if (req->flags & REQ_F_IOPOLL)
 		io_complete_rw_iopoll(&rw->kiocb, ret);
@@ -1034,7 +1039,8 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req->flags & REQ_F_BUFFERS_COMMIT)
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
-	return ret;
+
+	return io_fixup_restart_res(ret);
 }
 
 int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
@@ -1068,8 +1074,10 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 		return IOU_RETRY;
 	} else if (ret <= 0) {
 		io_kbuf_recycle(req, sel.buf_list, issue_flags);
-		if (ret < 0)
+		if (ret < 0) {
+			ret = io_fixup_restart_res(ret);
 			req_set_fail(req);
+		}
 	} else if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
 		cflags = io_put_kbuf(req, ret, sel.buf_list);
 	} else {

