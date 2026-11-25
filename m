Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606323;
	b=48ny1eY7PerRSbU+Meei/VQZCg354QCvF+Znv17w8vt49KIo6dgpFKsuuO0I1MhLFhrO
	 DbPUqLNkepC0krER+m1CPJjk6HSdI2NmAwpVPCjhF1UkXuXXQgsQOK3Tfvsr7KF+dZVaX
	 9xhmTmlJWFC+Fkygf3af8e8ymwemxwfiTL7P78u7cSDqPEGJrK4UAY+1EbLhWMWpNLZiR
	 ugeDSbj9QtPOVvt69vPXvBMmueA/LCsfLyD8yxA6E1F0iHAZ9hUmIGG6b6skIsCipKyq5
	 0gtTwyL/ze09tZjdFf0OMFkS9A5i3XFp8IpErVhMmoznGayANJ4aQkNLerDejkJ52HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606323;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tAeV3ktciSEV+OAgaTb0EJCJtbQ1g5t5ATtyvCOrjc8=;
	b=5FfOC044dOmBchQncCY1B77PgCu2YooDMJuT3n60zBuqWS442OBM5gopkMKPuSKUUTxg
	 V2TfhvE/WaqA2ieHOKBP5ohsZzsvH/vU1LJjFBbnFjgdYXRvGpCgSKnsIBBrfcnHnXZp8
	 5TM38Y+qPSxSkIrozk9uZwFWPTQbG2eFmtSBElBpdNsiupMd4+/8j0CC2uJhoH3pLEWO6
	 UlK5s3PKS2x9Nj2Npb0Ro9qV2+5sJBf4KCAihxLl1FFtU9wCNHXNaUS8b0ZTfSZKoTXGe
	 z/dPQDaiDttaZ+gZZ3pj6VBl5bfH9xrXsIH9JYqW54xoV+4d0reoCujPGjOsS8KoVtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W2Jcb+ka;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDC606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W2Jcb+ka
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC201F000D2;
	Wed, 25 Nov 2026 11:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606322;
	bh=tAeV3ktciSEV+OAgaTb0EJCJtbQ1g5t5ATtyvCOrjc8=;
	h=Subject:To:Cc:From:Date;
	b=W2Jcb+katPPMJVa6zKSJbJ/1/iAt6qnNDmIIwU2eL02nPs80jQofWFLPFPMgMvLpd
	 jF1Mux7on/OJHVMUO/cU3QXivupKV+b2XA6lyrJ9n/ae9KsT/yC84/DjSSM2J+yR0W
	 G1Vx5pk3aEZ/737XN/A7dh6PwNSrKsvrEJzvc3YU=
Subject: FAILED: patch "[PATCH] dm: fail a REQ_PREFLUSH bio with data when its preflush fails" failed to apply to 5.15-stable tree
To: daejun7.park@samsung.com,mpatocka@redhat.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:18 +0100
Message-ID: <2026112517-confetti-saloon-c0b5@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112517-confetti-saloon-c0b5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Thu, 12 Nov 2026 10:35:29 +0900
Subject: [PATCH] dm: fail a REQ_PREFLUSH bio with data when its preflush fails

For a bio with REQ_PREFLUSH and data, dm core may send an empty flush
first. If the flush fails, __dm_io_complete() still reissues the bio
without REQ_PREFLUSH and drops the error. When that write succeeds,
the XFS log keeps running and fsync() can return 0.

End the bio with the flush error instead of writing the data, as
blk-mq does.

Fixes: 6a8736d10cb4 ("dm: relax ordering of bio-based flush implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a73355c0125c..38eaae8ac9b4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -983,7 +983,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 	if (requeued)
 		return;
 
-	if (unlikely(requeue_flush_with_data)) {
+	if (unlikely(requeue_flush_with_data) && !io_error) {
 		/*
 		 * Preflush done for flush with data, reissue
 		 * without REQ_PREFLUSH.
@@ -991,7 +991,7 @@ static void __dm_io_complete(struct dm_io *io, bool first_stage)
 		bio->bi_opf &= ~REQ_PREFLUSH;
 		queue_io(md, bio);
 	} else {
-		/* done with normal IO or empty flush */
+		/* done with normal IO, empty flush or failed preflush */
 		if (io_error)
 			bio->bi_status = io_error;
 		bio_endio(bio);

