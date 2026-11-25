Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597970;
	b=zIA+S29p0EUvo2wLarGD1Mlc/ZVG2nuN+Tyvtzm1B9DaqX2OqFMiQNY0p4TfvhCF14b0
	 CA/QJeeWiiA0rWPKEUXs7Kcwkgd3rpvQClSqdC0rX0jz4dzDJr+1EyyYv+kVuxAUlL9Hv
	 fPU34VHlYiANHMHV01duTbOD/w/FHNoCe4hEClrNDp45bpG/WVTVrYsNTac55Q4xxsY4c
	 wNx9HoGvH7FJeopjYE72pxsO/Yl8XBTfsF+fzPI+lwIgWDQVarzTwepSvgTDYabQ5/prV
	 O2Xdntyd+RqATUSLXVnMNyMw45XxvLyS4siOZYUOmmcjoBydnIZpCJsyb5++LvCsYnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597970;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pPfG62+fR/2HupTRwUMyejO9UU/n/l+Rv3IG+R24EHk=;
	b=RMZ0N4np3D26V5bTiMzu6HS10N7x1JqX+8drpvs9ArrcA7yi6joq13l8Ow3pWznDz+Ox
	 fDOxcz2q2rRoJ1lnWMfRcuVo09Lt7VticBJJF7Tk/jjT74WIiKyPZIaq8vLHZtpzoRdVG
	 GucCsIRbcRz2zfGaTmBF6mbZmeaeBfK93F3uWeo6zp3WyJMNWIgj14tRTxyn6ybfzWdec
	 li37/EDDB2cWbDCaZdoO3gM2rRgWvXgaU/37a1Q7qDdr1/VVvTOz+QC0bIBlGLdzeWieY
	 yG0fPVZsbkZfwVbEZHyHsWpE5W80FcpiKXdv8b5XViwd1HeIjeWs43U/wYzMBYHs8/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JwbU45sT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EA1606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JwbU45sT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB391F000C0;
	Wed, 25 Nov 2026 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795597969;
	bh=pPfG62+fR/2HupTRwUMyejO9UU/n/l+Rv3IG+R24EHk=;
	h=Subject:To:Cc:From:Date;
	b=JwbU45sTHNTMf8ynA21vxcAomuab0zAIeFV98ocAkoPe81zxQV7XcGroYEwgSijCN
	 7Avw3QzkqBwtXDwiDzvMCnVuZslAbyrEHigOiqT/MEHyU1pxO59uFxtNWu8uyItXAF
	 94IT3zcCffECXtY39nsOhrCum3Yn9R/qVQrjfQeE=
Subject: FAILED: patch "[PATCH] netfs: keep the prepare_read errno when abandoning read" failed to apply to 6.12-stable tree
To: pc@manguebit.org,dhowells@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 10:03:00 +0100
Message-ID: <2026112500-jalapeno-aerobics-0387@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d88a0c3a96fd6d7228d04532cecb23f23676aa2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112500-jalapeno-aerobics-0387@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d88a0c3a96fd6d7228d04532cecb23f23676aa2d Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 1 Nov 2026 19:59:55 -0300
Subject: [PATCH] netfs: keep the prepare_read errno when abandoning read
 retries

When ->prepare_read() fails while retrying a read,
netfs_retry_read_subrequests() marks the subrequest failed and abandons
the rest, which overwrites the error of every failed subrequest with
-ENOMEM.  The reader then gets -ENOMEM for e.g. a handle that couldn't be
reopened (-EHOSTDOWN, -ENOENT), a credit wait interrupted by a signal
(-ERESTARTSYS) or umount -f (-EIO).  The first pass doesn't have this
problem, as netfs_cancel_read() keeps the errno.

Record the errno of ->prepare_read() in the subrequest and keep the error
of subrequests that already failed, using -ENOMEM only for those
abandoned while still waiting for a retry.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 5bd8dee5a834..8a722995fa9d 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -28,6 +28,7 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	struct list_head *next;
+	int ret;
 
 	_enter("R=%x", rreq->debug_id);
 
@@ -140,8 +141,11 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 
 			/* Renegotiate max_len (rsize) */
 			stream->sreq_max_len = subreq->len;
-			if (rreq->netfs_ops->prepare_read &&
-			    rreq->netfs_ops->prepare_read(subreq) < 0) {
+			ret = 0;
+			if (rreq->netfs_ops->prepare_read)
+				ret = rreq->netfs_ops->prepare_read(subreq);
+			if (ret < 0) {
+				subreq->error = ret;
 				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 				goto abandon;
@@ -221,7 +225,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 				part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
 
 			netfs_stat(&netfs_n_rh_download);
-			if (rreq->netfs_ops->prepare_read(subreq) < 0) {
+			ret = rreq->netfs_ops->prepare_read(subreq);
+			if (ret < 0) {
+				subreq->error = ret;
 				trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 				goto abandon;
@@ -257,7 +263,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 		if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags) &&
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags))
 			continue;
-		subreq->error = -ENOMEM;
+		if (!subreq->error ||
+		    !test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+			subreq->error = -ENOMEM;
 		__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 	}

