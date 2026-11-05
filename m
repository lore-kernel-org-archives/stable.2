Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897312;
	b=aS04pAnbl8UBRzawozI90phlE9SF3kYMDpKlSgy1XYBJ6LRAjWBdqZ3M6Sppw1p7+ww3
	 ESTY32WJOePDS/0oC0YLF5jwrRG5E69FDXCLrtcX3okgvOIDUS+Q4cdDreLbQ4liaFFPf
	 AS02l6Zyr87FutAomsqdvqVSO3zm4cqkHh5b62Hu9WT2Ic3bIvnjTG2mojWio+1EYUlfn
	 LvEE6lxSWh4r4a3MQKMLX3xfbtAoLomApNO0T1I1bKKA3ouit/GAOd7OcViYl8BKhwMVS
	 8SSGtjh1bzsPixEtQ+JUIAGg6Z5qQzwd//ON5u0SluveN/FxS0wkoACPREwA9ZwDWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897312;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=3nNnYS3rXGBEUIhHZKihqecq8rp1NDmqZJxqu67mjHY=;
	b=1bNATpyHNAw+6TBWOw4OCJBK1g84Cm6pI/nFyyX6zA5He05i5s9xjxkS6pX7c1rwXT/t
	 oH5uBoqgduulXfi4KGhcMel8S2kwFnj15RjUVPpkstTa23DNB4suT/7qpdn4vquOZAffM
	 RaP85F6a8w/KngnUKSX8Z0Wr87vTi3oGqpado+AjVfnFrtvQZrdU2+IYrb71RrRxYlnUA
	 NRBALSVOxG21tvQtzkQtPeAiTvasu7N3ggPY97SJQY3gy35jyTtyPmlUp9VrkWLXpVcFE
	 Gqet6kBHMeDhyfnn+8uIBbq4w6ITEKuyrbGC5lCW/l/S6B1jEdVddYjv2UbMqy7ZSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ZY1udhAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B3606A329;
	Thu,  5 Nov 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ZY1udhAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F6A1F000C1;
	Thu,  5 Nov 2026 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793897311;
	bh=3nNnYS3rXGBEUIhHZKihqecq8rp1NDmqZJxqu67mjHY=;
	h=Date:To:Cc:From:Subject;
	b=ZY1udhAVpAvlluTuk0VV0ITiU7+6n9sCRl47dQHeqnBsOyMVVj/cHs3BsQEJ79WrN
	 GrLAc6AJOPd34awsf74B/zRKFmsy3ICE4EcW7bPTxaOXzbuANJ77XDH3iS7HGUqnal
	 R1b7c2un31wzSEogO+H1x6+H62hKut3GRV/bSPIg=
Date: Thu, 05 Nov 2026 08:48:30 -0800
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Daehyeon Ko <4ncienth@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Haocheng Yu <l1za0.sec@gmail.com>,
 Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <de6c68da958f43278194d4cf45a8fde2.1@linux-foundation.org>
Subject: [PATCH 1/1] iov_iter: validate extracted segment for bvec alignment
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Daehyeon Ko <4ncienth@gmail.com>
Subject: iov_iter: validate extracted segment for bvec alignment
Date: Thu, 15 Oct 2026 15:19:07 +0900

iov_iter_extract_bvecs() validates iter_iov_addr() and iter_iov_len()
before iov_iter_extract_pages() selects the first nonempty segment and
limits it by iter->count.  The checks can therefore cover a different
range after a leading empty segment or iov_iter_truncate().

An unprivileged O_DIRECT preadv() reproduced the empty-segment case: an
aligned empty segment followed by a misaligned one completed 4096 bytes
instead of returning -EINVAL.  A truncated iterator has the same mismatch
when its full segment length is aligned but its remaining count is not.

The worst effect I have confirmed is an alignment-contract bypass.  An
unprivileged O_DIRECT preadv() produced bvecs with offset/length pairs
(1, 4095) and (0, 1).  The bio reached brd_submit_bio(), and the read
completed 4096 bytes instead of failing with -EINVAL.

I have not demonstrated harmful behavior on real DMA hardware.  For a
normal blk-mq target, blk_mq_submit_bio() calls
__bio_split_to_limits(), where bio_split_io_at() rejects the misaligned
bvec before queue_rq().  Virtio-blk and loop both returned -EINVAL in
my controls.

So a bio-based driver can receive a bvec which violates its advertised
dma_alignment, but any further effect is driver-specific.  I have not
reproduced memory corruption or a crash on real hardware.

Bound the normal fast-path length by iter->count.  Keep
first_iovec_segment() for leading empty segments so validation covers the
remaining portion of the segment available for extraction.

Link: https://lore.kernel.org/20261015061907.2713943-1-4ncienth@gmail.com
Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Closes: https://lore.kernel.org/r/20261012065520.1089147-1-4ncienth@gmail.com
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Haocheng Yu <l1za0.sec@gmail.com>
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
---

 lib/iov_iter.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/lib/iov_iter.c~iov_iter-validate-extracted-segment-for-bvec-alignment
+++ a/lib/iov_iter.c
@@ -1042,7 +1042,7 @@ static ssize_t iter_xarray_get_pages(str
 	return maxsize;
 }
 
-/* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
+/* must be used on a non-empty ITER_UBUF, ITER_IOVEC or ITER_KVEC */
 static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 {
 	size_t skip;
@@ -1959,8 +1959,13 @@ ssize_t iov_iter_extract_bvecs(struct io
 		   iter_is_iovec(iter) ||
 		   iov_iter_is_kvec(iter))) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
+		size_t seg_size = min(iter_iov_len(iter), iter->count);
 
-		if ((start | iter_iov_len(iter)) & mem_align_mask)
+		if (unlikely(!seg_size && iter->count)) {
+			seg_size = iter->count;
+			start = first_iovec_segment(iter, &seg_size);
+		}
+		if ((start | seg_size) & mem_align_mask)
 			return -EINVAL;
 	} else if (iov_iter_alignment(iter) & mem_align_mask) {
 		return -EINVAL;
_
