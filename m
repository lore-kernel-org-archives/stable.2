Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045923;
	b=rcIDDIWybE4oIs7Umh9lJ9CGvNusl70Sc0oGdgK95TwdeDwJFA1QQJJiwXPJQpDPS2gA
	 3w/DeObdBpSjz7kEW72AYfFTbB1gNFuMj4YsUQDaRCruooONZzGfzpcrCgjT/JZkPv+AS
	 4R2SjMLxz8UhOPAxi+GJprkdkhtaDNqLhklsCuExeMUjBtUjhgx0PRz2ThSUFcEnoIkoD
	 LehVtAZBcfO94bKGdyNMhlDGoRW0l0LBIXde1u2gUK8GseYK8BakpX3yBmOKK0ytm44xV
	 Zu654NYMx7kCIW7m5TN0XPfoJAMsFp+LjnbjchMm3YDgeIAaOVf/C2cmHfo7ISTXfbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7NOTbamsIhnYoarFY1EPP1iQ7GVM9nsb1LD1JvpCORE=;
	b=U/Gz6qTuxEYVr/Cg//6LSCGzlfhlFkJyvn2U4advtmIgVwV6+1bAlyTzZvPNdPzc0LS7
	 1sq4qyNA0fRgpq0Dde4Bg3+bD2WWrT2Yw6k9ldal8hegRelktutYfSSDwATHVCs3NiONG
	 N4WaAsdOBT15fS6B3Ody8VvNHWxZvBG0jPFBo7xVKh1eKnBpyoqWGA+eU2jirFUpRof87
	 aEHqNwr2VYvOqy14VfpKUyGRabW7cIQ/JUXJb0KbCuKesVi6zxKX1Murz7eDHuTeB23G6
	 USA9FlekDG43qeVG/Gn+fpBUJyJjldUpDsIF0t21AOKkrKjkP4CtyLwVBoYTzB09E7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvvzxLIn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvvzxLIn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5AD1F0089F;
	Sat,  7 Nov 2026 10:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045923;
	bh=7NOTbamsIhnYoarFY1EPP1iQ7GVM9nsb1LD1JvpCORE=;
	h=From:To:Cc:Subject:Date;
	b=QvvzxLIn8/kkBmdLw2vHqrDuDXnRVcodKXdbDYLey24r/eATUVaGv2PklhSewjhhV
	 rfz2JrNy8p5lZXi8LYuqd0lVX8fuIJkyG15r5X5emE6xLUue/okNUeEGGJv/A3YPs5
	 +jWKj5UZthS+5AyCvbeMxT/HOd+Hb5y4+zk1yEs2nSYajIn4qKERQmNvEyPkdFCw4D
	 OkDrUHKbDXNSA4SK41AA4W5hpiZd+WYam6qnvyNLu3WmfsfnzsGJXFAeR31NtrD3GI
	 Lrr2u95glbHYFi+666P8M6vuE/iurDv+RcTc3K15I3Z6Q9Tb+BIEEJdYDgDklD1OF4
	 nrDgirm2uKYOg==
From: Sasha Levin <sashal@kernel.org>
To: akpm@linux-foundation.org,
	l1za0.sec@gmail.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	tz2294@columbia.edu,
	4ncienth@gmail.com,
	viro@zeniv.linux.org.uk,
	hare@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] block: restore the iterator when rejecting a misaligned bio" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:21 -0500
Message-ID: <20261107050521-failed-7.3-40d070cbb190@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 40d070cbb1906896d6fd65c39722d2411830ed9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050521-failed-7.3-40d070cbb190@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 40d070cbb1906896d6fd65c39722d2411830ed9f Mon Sep 17 00:00:00 2001
From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 18 Oct 2026 17:30:00 -0700
Subject: [PATCH] block: restore the iterator when rejecting a misaligned bio

bio_iov_iter_get_pages() can extract some iovecs before encountering a
misaligned one.  It releases the pages and rejects the entire bio, but
leaves the supplied iterator advanced.

An iomap direct-I/O caller may subsequently reexpand the iterator's
byte count and fall back to buffered I/O.  The reexpanded count then
includes bytes before the iterator's current segment, potentially
causing iterate_iovec() to read beyond the imported iovec array.

In a reproducer using an initial empty iovec followed by 10-byte and
1015-byte segments, writev() returned 1015 instead of 1025 and KASAN
reported an 8-byte read beyond the nine-element iovec allocation.
Saving and restoring the iterator on the rejected-bio path makes
writev() return 1025 and eliminates the KASAN report.

Restore the entire iterator rather than reverting a byte count:
advancing past an empty segment changes its position without consuming
any bytes.

Leave successful and partially accepted bio paths unchanged.

Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Haocheng Yu <l1za0.sec@gmail.com>
Closes: https://lore.kernel.org/20261018081203.2431035-1-l1za0.sec@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: Daehyeon Ko <4ncienth@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hannes Reinecke <hare@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261020170250.014BD1F000C9@smtp.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index a1e9ffd5982d5..41d9f1c5992d2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1311,6 +1311,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned mem_align_mask, unsigned len_align_mask)
 {
 	iov_iter_extraction_t flags = 0;
+	struct iov_iter saved_iter;
 	int ret;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
@@ -1330,6 +1331,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		flags |= ITER_ALLOW_P2PDMA;
 
+	saved_iter = *iter;
 	do {
 		ssize_t size;
 
@@ -1371,6 +1373,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	bio_release_pages(bio, false);
 	bio_clear_flag(bio, BIO_PAGE_PINNED);
 	bio->bi_vcnt = 0;
+	*iter = saved_iter;
 	return -EINVAL;
 }
 
-- 
2.53.0




