Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415395;
	b=gvjvbsPl2Q0ivpSYYNuvYZza16u8Yuncyn8LW25bmjLbRHocszVe8+r/U1kBSMbYlFCt
	 4vCSVQIVTTSUmlMI3noiQlrqnTfe55gMUa8FyVnjJ7BM9a/Muz02Gqcm5gb2AS1G6cEDN
	 H6z2IDRnPcd9QmxibapCtYROxy8HASPqwe0SwHnhorl7oPWTrUCHS/1iflZ87pSMxGoUf
	 cdB519kHBM8U/yz5DJFJyXZhpv0pkVFYJt2dmLWT1m2vo9Y7eDvtrBYU3neX9/oxE1WXM
	 bTOpQL4zyQHDXkj4/uMIcXInrmL2F/fo6vreEakGMkR71vOzVc72EEAAbwbyEibwYQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415395;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=mMNwc/L5WVh73MBuimgul84oe/8CoXdF45cgMt+e8jc=;
	b=LSz9BeEZv//a4Cjk+usHwKaPyKqxFk9Odbwpsw3GBLf3nodkDy+9lrZFkQS/B9BhFwdJ
	 Y1QgAWMY7lPXTBc+n0fVmxdkenfsHmPMyTiswlmiGq8EQCy6/q4MKBxJvmnOvHh/qzQwF
	 VCLqAwh1q/I2Tyg/dwzmky35hyPge1mAd+nSYtDBHRDS499UJ14yqgO//74ujhpOITblQ
	 xYq95oMLJgRpoRFBWhuoVxEyBKTCs1NWXRHApmUvpNxoEQw6srq3v4h09i3aggpZdEyLx
	 Ax2rcUkXMEYUOrdU0qwmEz94opk7wYNKhNCs71vCuGPGsfHTpGPUkJtQwy6O5jiSm3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458D606A881;
	Wed, 11 Nov 2026 16:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6458D606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0E6CB68D17; Wed, 11 Nov 2026 17:43:12 +0100 (CET)
Date: Wed, 11 Nov 2026 17:43:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmet: use overflow-safe range checks in the file
 backend
Message-ID: <20261111164311.GB18076@lst.de>
References: <20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn> <20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111224247129g0VbfWdGlwDMhBpChnT-8@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 11, 2026 at 10:42:47PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> The file backend shifts a host-supplied SLBA to form a byte offset
> before checking it against the namespace size. The shift can discard
> high bits: with a 4 KiB block size, SLBA 2^52 + 1 becomes offset 4096.
> The range check then accepts a command aimed outside the namespace and
> the backend accesses data at the wrapped offset.
> 
> Reject overflowing LBA-to-byte conversions and check the transfer
> length against the remaining namespace size without adding it to the
> offset. Apply the checks to reads, writes, discard and write zeroes.
> 
> Fixes: 9c891c139894 ("nvmet: check fileio lba range access boundaries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> 
> Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
> and a 4 MiB file-backed namespace.
> 
> A Write with SLBA = 2^52 + 1 and a 4 KiB block size yields a byte
> offset that wraps to 0x1000 and passes the size check:
> 
>   unpatched                            patched
>   ret=0 (write accepted at 0x1000)     ret=24705 (Capacity Exceeded)
>   drivers/nvme/target/io-cmd-file.c |   41 +++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index 695963dd932e..d59dbf61b1b0 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -125,17 +125,22 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
>  	size_t len = 0, total_len = 0;
>  	ssize_t ret = 0;
>  	loff_t pos;
> +	u64 pos64;
>  	int i;
>  	struct scatterlist *sg;
>  
>  	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
>  		is_sync = true;
>  
> -	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
> -	if (unlikely(pos + req->transfer_len > req->ns->size)) {
> +	if (unlikely(check_shl_overflow(le64_to_cpu(req->cmd->rw.slba),
> +					req->ns->blksize_shift,
> +					&pos64) ||
> +		     pos64 > req->ns->size ||
> +		     req->transfer_len > req->ns->size - pos64)) {

This condition looks like something that should be factored into a
helper to a bit more readable and so that the pos64 variable can be
hidden inside it.

Otherwise looks good.

