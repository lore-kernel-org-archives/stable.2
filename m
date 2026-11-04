Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818080;
	b=BxVLqQcxGMPGtjwS1SHXeTuHw9auZTvo054BDGsz8Uo8soRt1yg7lmRiPvde7JPhRc9W
	 qK3uMVAT9Qz/h0vYrt0B78K2uPHccMQKACJOfTqxPLnW1h31OkUhAsuYixLlYKtvARlSZ
	 F3vEmxdmKkaEa7zVC6muQm+MxR3du8+mWTg+Sk1vXEZe4FchNCiINyH/omNGHBimu146R
	 s0P4keC0LP7rjc0gh8oz6E1PJloIW0HlPX0csDEpGPLDu8FS8AiKhD6MM2s1aSfrGGZ2E
	 pdcxqFK15SHvATn4I0AFnMzWSCBWABSuSvfbqUO3/gepZaDtI7WALq9tBLeOU0hi3Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818080;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hBt+JTkYqpKt/XKocjBqDqUusNdtyXCreI1EAFHlfCk=;
	b=ZiQQnjoiZEZrGzqTnUuLrlvZl7erZwdDr110srmdVRx/TR7UM3ecN0h3ld0RuGr/LynF
	 AWGcXTOb2GgsU7Zy+Bzt4ESoARPyp1Cdx7Rl58MMn2q1JtdNaDJdprxakn/S3ayUnYiiA
	 DIx/sllUVF3T5zCXqWliXawKqigs497yREVV3EhN6d2ZOr6vezgoyidjTFvH8DAZZmWO3
	 e5iA6idf7yJT+HRqOXnL5qI87OBqrv5DvIqtafJOQjWUDHhZXWgLPeUPmmvLuwj95lOHD
	 E4cP1xtEXWyE3TqKIJjE4P1YrEw5aJf3PDykbcxrA//PekMtIQnDXb6CgVJQ8CbQG/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u1x4o5iN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B2606A335
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=u1x4o5iN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D8C1F000C1;
	Wed,  4 Nov 2026 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818079;
	bh=hBt+JTkYqpKt/XKocjBqDqUusNdtyXCreI1EAFHlfCk=;
	h=Subject:To:Cc:From:Date;
	b=u1x4o5iNUuOQaPSHRqKu6iJXnfQxJDIPvmzDkh7szZlwF2j61f+mG42tVNF/C5kqE
	 qQKmmF+gzx660f38saZbaxY5epro+pQ6NzpyMGxZOMtqgXcuL0gDsmq6ZTpd+fhSLZ
	 xTBH3v8s9nrKJK6u0AX8z0HD9K6Ds3XmBDjaw8LY=
Subject: FAILED: patch "[PATCH] NFS/localio: detect a short read or write before the iterator" failed to apply to 6.18-stable tree
To: snitzer@kernel.org,anna.schumaker@hammerspace.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:47:58 -0500
Message-ID: <2026110458-dreamt-steering-e6da@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x db3ca539c1142d2c5380c5dbd3154ab7bb1c7d77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110458-dreamt-steering-e6da@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db3ca539c1142d2c5380c5dbd3154ab7bb1c7d77 Mon Sep 17 00:00:00 2001
From: Mike Snitzer <snitzer@kernel.org>
Date: Mon, 28 Sep 2026 11:54:26 -0400
Subject: [PATCH] NFS/localio: detect a short read or write before the iterator
 has moved

nfs_local_call_read() and nfs_local_call_write() issue a misaligned
DIO as up to three segments and must stop at the first short one, or
the next segment lands at the wrong file offset.  They test for that
by comparing the bytes transferred against iov_iter_count() of the
segment, read after read_iter() or write_iter() has advanced the
iterator, when the count is the residual rather than the request:

    before the call:  count == expected
    after the call:   count == expected - status

The test is therefore status < expected - status, and it fires only
when less than half of the segment was transferred.  A short I/O that
covers between 50% and 99% of a segment slips through: the loop moves
on with ki_pos advanced by the short amount, the next segment is
issued at the wrong offset, and the header's byte count is
over-reported to the caller.  A write that slips through also never
sets NFS_CONTEXT_WRITE_SYNC, which is what makes the writes that
follow a short one synchronous.

Take the segment's count before issuing it and compare against that.

This is the same defect that commit 250ec14932d5 ("nfsd: fix
partial-write detection in nfsd_direct_write") fixed in NFSD's version
of this loop.

Fixes: c817248fc831 ("nfs/localio: add proper O_DIRECT support for READ and WRITE")
Fixes: d0497dd27452 ("nfs/localio: backfill missing partial read support for misaligned DIO")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 63c38dea50cc..9fcae2391b72 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -674,6 +674,8 @@ static void nfs_local_call_read(struct work_struct *work)
 
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
+		size_t expected;
+
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
 			/* Only use AIO completion if DIO-aligned segment is last */
@@ -684,6 +686,8 @@ static void nfs_local_call_read(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		/* read_iter() advances the iterator: measure it beforehand */
+		expected = iov_iter_count(&iocb->iters[i]);
 		scoped_with_creds(filp->f_cred)
 			status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
 
@@ -691,7 +695,7 @@ static void nfs_local_call_read(struct work_struct *work)
 			continue;
 		/* Break on completion, errors, or short reads */
 		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
-		    (size_t)status < iov_iter_count(&iocb->iters[i])) {
+		    (size_t)status < expected) {
 			nfs_local_read_iocb_done(iocb);
 			break;
 		}
@@ -890,7 +894,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	n_iters = atomic_read(&iocb->n_iters);
 	for (int i = 0; i < n_iters ; i++) {
-		size_t icount;
+		size_t expected;
 
 		if (iocb->iter_is_dio_aligned[i]) {
 			iocb->kiocb.ki_flags |= IOCB_DIRECT;
@@ -902,16 +906,17 @@ static void nfs_local_call_write(struct work_struct *work)
 		} else
 			iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
 
+		/* write_iter() advances the iterator: measure it beforehand */
+		expected = iov_iter_count(&iocb->iters[i]);
 		scoped_with_creds(filp->f_cred)
 			status = filp->f_op->write_iter(&iocb->kiocb, &iocb->iters[i]);
 
 		if (status == -EIOCBQUEUED)
 			continue;
 		/* Break on completion, errors, or short writes */
-		icount = iov_iter_count(&iocb->iters[i]);
 		if (nfs_local_pgio_done(iocb, status) || status < 0 ||
-		    (size_t)status < icount) {
-			if ((size_t)status < icount) {
+		    (size_t)status < expected) {
+			if ((size_t)status < expected) {
 				struct nfs_lock_context *ctx =
 					iocb->hdr->req->wb_lock_context;
 

