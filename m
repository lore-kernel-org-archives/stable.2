Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606319;
	b=BSAIVku3XQkjSUN34GZUoFR0qqK7HWxibSuHmsdHZMScWSQTW5zazKz3hR6iy45uDM+G
	 xi9yh0Rs+1fRH1GwpUauqNsSUHwkNuLEDMPOvlTOFTc9jF2uTfldq3gar/O1W2q+8ZfHC
	 Lk791uOocJgvWdMYXVZ1eudlNwAZXGXH+W8IfwGhp1xl9EKKBTKJTRhOF5/UPCAIa8OW1
	 sPi/SuDU35la2MCQHmS71IjvkG0sPzKdEwBfq6eaYYZVIf4AsY+ViUVND6Xq0UvvsoxZh
	 iAuxdVLM2TlApKXLzoGYEZNnMCCwq+i9DXjD8wfkWXtBi6Dad4fhg2S2lq22Edaxk6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606319;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aenRaXI0/P8hv/XluEqT3qZIv3Z3bUhSl/jD/Prail4=;
	b=HR+Mfs42gny3ge02lrv4Ohp3QNKyWqHsu4osSvjqML4Sr0nEnQEmOT/kmkp/ssviEZQF
	 EspoFHt4c9gmiuBrZMjH1AxObrXC7tR/HMs+Nc53D3KGxReBvAJqJLWeFc0RmrFb1o/p3
	 GtJC3BcnZra5/UnLQgBEcAFR/qEBeFwN3qcNeiTmpfiZTvyYTsMTpt8kGFIdl4MYfQZyb
	 d+JwEsoPsjV5+yH+Y4Ly1GQqL0sdrH7zb7ckU0a4R1ntLtkZXsgciDSFuvdTG7Dz5QD3P
	 9GEoJ/udAMpcpkyHGa0xncBmODT768gXlIF4f4FPJZ3au5B6EksYpPSUIcKEai+4TuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h9yNKvYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF8606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=h9yNKvYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B031F000C0;
	Wed, 25 Nov 2026 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606318;
	bh=aenRaXI0/P8hv/XluEqT3qZIv3Z3bUhSl/jD/Prail4=;
	h=Subject:To:Cc:From:Date;
	b=h9yNKvYm5DzQcXAsz66+7cQXdKyZB1T9paDCI454FUNZH6vGIzZ3X1zjnDBZKSd9a
	 ZkR7VdmP10Bnf/UZW1UU3znFbpIFEPgTRGmia0mK/4y+Mk/Lx+/eDZlvHuuDKsJlBQ
	 ktZJJspdHsz0eSTjjgxRfMN5d3o1xBZqht6HAOjc=
Subject: FAILED: patch "[PATCH] dm: fail a REQ_PREFLUSH bio with data when its preflush fails" failed to apply to 5.10-stable tree
To: daejun7.park@samsung.com,mpatocka@redhat.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:18 +0100
Message-ID: <2026112518-retype-seldom-2c33@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e92cd41e8e5ee5616c6c7cd4378661d942f0a7c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112518-retype-seldom-2c33@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

