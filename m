Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FC93750CB;
	Thu, 18 Jun 2026 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778394; cv=none; b=DjbnPaLNKlEYodWIcAH3xQ9sMWBuHDv9Ufh/Igd6PTz4hvhTK4T2f8zIdkBzyCfKi+I6f3U3QzvoUvbx7aD+e+ZJpTY5Qx8dICXH4ZLtAcbcYzaqsikY23SFQ85KzwyCIJ+eRfBCOWefRZn0OkzYPdC7xrgN8JtXxbZD2HgpSKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778394; c=relaxed/simple;
	bh=QAXjP5J/sFCMInq4Fej3S6aSdguM9eBOQ61FbMRR4s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi3rra8sMgRoV2FRVnCxVO8noOsAP+6Z46ClQ0mogT+mhsFW4UZtnLlD1bHuO4+1rD+d6gYJ+J6JkqavOJN6ugMr0OpF9WymYQCCteM3+hkEV+EnoRXh8tabF3E+ocCZ7Rr6z/v+8BV2k6yFd3YL/B/CSfBbFvpZkf4YiWslJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8508A68C7B; Thu, 18 Jun 2026 12:26:27 +0200 (CEST)
Date: Thu, 18 Jun 2026 12:26:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dm-devel@lists.linux.dev, hch@lst.de, axboe@kernel.dk,
	brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] block: validate user space vectors during
 extraction
Message-ID: <20260618102627.GA23200@lst.de>
References: <20260617233235.1016063-1-kbusch@meta.com> <20260617233235.1016063-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617233235.1016063-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 17, 2026 at 04:32:35PM -0700, Keith Busch wrote:
> @@ -1242,7 +1242,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>   * is returned only if 0 pages could be pinned.
>   */
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
> -			   unsigned len_align_mask)
> +			   unsigned len_align_mask, unsigned vec_align_mask)

vec_align_mask needs to be documented in the kernel doc.  And I find
the vec_align_mask name a bit confusing.  This is all about the physical
address (really the dma address, but the page aligned offset map 1:1),
so maybe phys_align_mask or dma_align_mask might be better names?

Also wouldn't it be more natural to pass the start alignment requirement
before the length alignment paramter?

> @@ -1251,6 +1251,11 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>  
>  	if (iov_iter_is_bvec(iter)) {
>  		bio_iov_bvec_set(bio, iter);
> +
> +		if (mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
> +							vec_align_mask)
> +			return -EINVAL;

Can you add a comment here?  Especially as the bvec iter doesn't actually
require all individual bvecs to be aligned and I'm not entirely sure this
handles all case - writing down the rules might help a bit with that.

>  		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
>  				BIO_MAX_SIZE - bio->bi_iter.bi_size,
> -				&bio->bi_vcnt, bio->bi_max_vecs, flags);
> +				&bio->bi_vcnt, bio->bi_max_vecs,
> +				vec_align_mask, flags);
>  		if (ret <= 0) {
> +			if (ret == -EINVAL) {
> +				bio_release_pages(bio, false);
> +				bio_clear_flag(bio, BIO_PAGE_PINNED);
> +				bio->bi_iter.bi_size = 0;
> +				bio->bi_vcnt = 0;
> +				return ret;
> +			}

Do we need all this cleanups beyoned the bio_release_pages()?  Most
callers just free the bio, so should not care about it, and the error
handling in __blkdev_direct_IO that calls bio_endio looks buggy for
other reasons..

> + * @align_mask:	reject with -EINVAL if the source address or length is not
> + *		aligned to this mask

Maybe use the same paramater name as on the bio side here?

And not for this patch, but this makes me wonder if we should handle the
len alignment in iov_iter_extract_bvecs as well, as that should simplify
it quite a bit.

