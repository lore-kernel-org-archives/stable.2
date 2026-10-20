Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521813;
	b=kNkFYcrsKaFZBMLatPz1vcaxkFRsRLBDm/zVF6QuXGecUE1MkhsdyRHut3wO10JRoReP
	 Pt0t4ODQySOws4X9gh59dbPv7Xb83EPHX6BTNYbj6x13OlYoRvuCWrAqbPf1VDCAXB9Tq
	 r/BZdEm7NsblHRhjS1mbj4gQLr1EESyy5eE9CQ0/85X3fEksxEg84ow9oqPpJgKDjXS4K
	 80kNG9oRDTjWkBav0vOaRaG+rwKywDSwLYAKSqD76NeKOqktA00YH5ArgpJAAIjKi8Cgf
	 4SwcdJBWn9qR+ph4PH8IK4BQ9fVxqK7wfgmAntEFVuF7ABv4k5wtCb2VnWoKvsrf0oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521813;
	h=Received:DKIM-Signature:Date:To:From:Subject:Message-Id;
	bh=CUr4Y3OEV68Pj9vRqArQsmNSSXBjVB21zO1EU5jQW7o=;
	b=oKQJkeMwoIMMHZVPmrF77APvu6llMVgGlKOS2phEosV9niqZs6+nGWZdABQTsDraOOMz
	 SD4qOFcz19ATZjSOowwxsgTlohgT95OG1i2BJWmFlcLbkewlaEEAbvG9YaMDqKSWQKMf7
	 FInII/ZEyxA+JPPVmZa1BWAPzafV6A8zVcH/f+7/JIlInZ1nuq6TnMYlhFv5SBU6vVjNw
	 VzggwBTqKPdcWz+vFFTwXjP0uJrh+IN9Fzq01+Jo0oDw26LCxh9sXir90DePiEPk+JaU5
	 dJJKpcFVjbZrOovhAi4DYGPY/KPQeWO4DV2qnJEZpbDQOOgBM8dkkhPp5dSFuvvlVeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tgpwlpRh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BF60A260C;
	Tue, 20 Oct 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tgpwlpRh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AAA1F01573;
	Tue, 20 Oct 2026 18:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792521813;
	bh=CUr4Y3OEV68Pj9vRqArQsmNSSXBjVB21zO1EU5jQW7o=;
	h=Date:To:From:Subject;
	b=tgpwlpRhisktsfmX8dZldZROsUgZIgYbh5pd2SLyLGxrinb3CffJlhsVAF1Pj4Z6n
	 AWX2u6WKIKxnk62cnpqi8JKGf/1kQ5q/2G/ZdP6QDf8A8lsLtA6yJjRKiYHGoecYMb
	 UuCA2czhSzDR3rVzVHkipxUSaYNiJuGTsCAw8dW4=
Date: Tue, 20 Oct 2026 11:43:32 -0700
To: viro@zeniv.linux.org.uk,tz2294@columbia.edu,stable@vger.kernel.org,l1za0.sec@gmail.com,kbusch@kernel.org,hch@lst.de,hare@kernel.org,4ncienth@gmail.com,akpm@linux-foundation.org,linux-block@vger.kernel.org,axboe@kernel.dk
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 1/1] iov_iter: validate extracted segment for bvec alignment
Message-Id: <20261020184333.19AAA1F01573@smtp.kernel.org>
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
Assisted-by: LLM
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Haocheng Yu <l1za0.sec@gmail.com>
Cc: Tal Zussman <tz2294@columbia.edu>
Cc: <stable@vger.kernel.org>
---

 lib/iov_iter.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/lib/iov_iter.c~iov_iter-validate-extracted-segment-for-bvec-alignment
+++ a/lib/iov_iter.c
@@ -1022,7 +1022,7 @@ static ssize_t iter_xarray_get_pages(str
 	return maxsize;
 }
 
-/* must be done on non-empty ITER_UBUF or ITER_IOVEC one */
+/* must be used on a non-empty ITER_UBUF, ITER_IOVEC or ITER_KVEC */
 static unsigned long first_iovec_segment(const struct iov_iter *i, size_t *size)
 {
 	size_t skip;
@@ -1938,8 +1938,13 @@ ssize_t iov_iter_extract_bvecs(struct io
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
