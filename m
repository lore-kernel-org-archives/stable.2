Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026158;
	b=IOLbxIhKVPg1QIW/qqaWuS4gRFaOkD0DCkvCN7zBcps+/lHAPqWpre+9YdHiyQddThaD
	 A5W7RrvonHjEiEs37SGl7RNIVz5wWA9qAS4EnQzBO02Anu7+cKDychwPT204I0jdh9zci
	 2/Z7KwQEqLDrZhOkca/XuDlkdQEuZwLbubR+zd1tuMS4CEw8yV71zLODPIm/xrkDt6HAg
	 CH1MF8I9WaIIkwL4ZJSKGqll0JW3mRd95V3IgdX1z06r285bxJQ55fF3JdhV1slxcnrpr
	 ieepwCbvmUXY/TJmMU0vew+ptYBA13Lah2k/y5pGqGjIUD6CNLapQqwrK+FTBlYKIcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026158;
	h=Received:DKIM-Signature:Date:To:Cc:From:Message-Id:Subject;
	bh=4pu6z1Ov5wsBhDkCoZ/+vEL5wykOdNzSLuoNYPfbkfU=;
	b=zJBn+zDPHyI7gl6oPrHdwQyE8AagB1hA0FoCtcea0pc/x9BRHIxOFB08qdHQpREjOKZ9
	 y7fiMBn0d2XzwQpCkAYWuHlYcxyPdas226SRodLR9v2Wpw3JPKoRSCNt9vCfO7+8p+Oh/
	 rdbk9x6P42Vz/BJtsq1O8KmTXNxcwHKVEK7KIbvbBIDB2V5QtRXBq0/C2eizAyTztXzBW
	 uowElXQ9nEEQAuzrb3qjHVJ7afqCGO24OmR5061L5d4XO5zv6kzXL2dqf1f9NrXbljVD5
	 cHt61MLnJH6xgcB4PW00JauxxnGULsWyAd6z/w0IaLn25YQOlZ3uDIzRATGoZSFGaEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wGjb+nc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0B5606A32C;
	Wed, 18 Nov 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=wGjb+nc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9541F000CA;
	Wed, 18 Nov 2026 18:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795026157;
	bh=4pu6z1Ov5wsBhDkCoZ/+vEL5wykOdNzSLuoNYPfbkfU=;
	h=Date:To:Cc:From:Subject;
	b=wGjb+nc1YWq3gAciA4hqq/atiwGomfGG8wCFfivt+YG+4J7PAiK/p5SzkDhZrbi9v
	 BOJjBzHvMXf1643JPSSdT3t55z8jXpis7KnNspNVyqQu5k+w7VKkNnNh/0JkOeShjC
	 7ionM2lzysSXoTe0HVXZhh+9jxvTUDRXkoQBifU8=
Date: Wed, 18 Nov 2026 10:22:37 -0800
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Daehyeon Ko <4ncienth@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Haocheng Yu <l1za0.sec@gmail.com>,
 Tal Zussman <tz2294@columbia.edu>, stable@vger.kernel.org
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <bc6dc5eaf825462783cd3a606636e92b.1@linux-foundation.org>
Subject: [PATCH] iov_iter: validate extracted segment for bvec alignment
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
