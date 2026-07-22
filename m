Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07E40F726;
	Wed, 22 Jul 2026 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784722225; cv=none; b=ZHT4w2Y58LiEIwodbBO2krB2LjlYCemtKh9pPUjJxs46WwkXsKeNyCNPwJL+mYzbyGRssVH3rTBlER/OGB9fkHIveXyOY5IdPQzf22la0BYeMFILuRBg2tR2tFvucxU3CufoLq3PfBgl8cFpSXBIKn089Y5oI/+YRM8GU/qT2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784722225; c=relaxed/simple;
	bh=By2Pb8/nvIpVR/1KLMocte+OH0ZlfO5nWcr+G6VF9Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGFiNszQr8H3AJHqjWV970J+eR5Z7FUY5SBJu0BUEdKXkfXP6wrkZRqGgVl8n1GZJpVXwdx4WjySrhor+B1xcdeiVm5eBbBp44hkEGwHpssSKg29G8lLuxjNUP5FVJKe3AnDv443XMq5k1xtyz9CvJ8w6bRBnD9p9wKcBJA81n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s0TKT8vH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0TKT8vH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aBWUhrEELooDzZRotoj+Hukdel5mE9t3IDWtYjGPSGU=; b=s0TKT8vHYnxHIqUbY8rWpbzveO
	OzMbmSL2MKLiIKW0Ymjr/WqZ4uiL2Ve5Bjw2sHpLprpW0KBpwwJ0cHqO4O2e7d+62ker9Ci56Owux
	jlTuECofoiN8CpD6+nNxU8DzmujG0Eu/nM0De8iWN32kTtNm+YvDhj/X69R9niTSiOzpE6yOkUZKd
	/bvWbjB61D8miX25SBNfTkRDl5Gw3Gfze79MxyRJkQoDydc7qNqs4Mp8pAp9w0Hml6V1Ncj4vSA0K
	uOZGYLRb45yR8RctUOE/fD1Uer9C2DET6nBMNGX4Y1W0xlHTY7be3wpLWrYj4Df/Hjk4lXakOtfzD
	jP5hfeMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmVmH-0000000BiS3-2il1;
	Wed, 22 Jul 2026 12:10:21 +0000
Date: Wed, 22 Jul 2026 05:10:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sangho Lee <kudo3228@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] freevxfs: reject invalid OLT record sizes
Message-ID: <amCzLbCYaj2b_U1S@infradead.org>
References: <20260722105706.1385095-1-kudo3228@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722105706.1385095-1-kudo3228@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 22, 2026 at 07:57:06PM +0900, Sangho Lee wrote:
> vxfs_read_olt() walks image-controlled Object Location Table records by
> adding each record's on-disk olt_size to the current cursor:
> 
> 	oaddr += fs32_to_cpu(infp, ocp->olt_size);
> 
> The value is not checked before it is used. A crafted VxFS image can set a
> record size to zero, which prevents the cursor from advancing and leaves
> mount(2) spinning in the kernel. Oversized values can also move the cursor
> past the mapped OLT block without first rejecting the malformed image.
> 
> Reject malformed OLT header and record sizes before using them. A valid
> header must place the first record after the header and within the mapped
> OLT extent. Each record must be at least large enough to contain the common
> record header and must fit in the remaining extent.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sangho Lee <kudo3228@gmail.com>
> ---
>  fs/freevxfs/vxfs_olt.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/freevxfs/vxfs_olt.c b/fs/freevxfs/vxfs_olt.c
> index 23f35187c289..e5fb3b86d88e 100644
> --- a/fs/freevxfs/vxfs_olt.c
> +++ b/fs/freevxfs/vxfs_olt.c
> @@ -56,6 +56,7 @@
>  	struct buffer_head	*bp;
>  	struct vxfs_olt		*op;
>  	char			*oaddr, *eaddr;
> +	u32			olt_size;
>  
>  	bp = sb_bread(sbp, vxfs_oblock(sbp, infp->vsi_oltext, bsize));
>  	if (!bp || !bp->b_data)
> @@ -77,12 +78,21 @@
>  		goto fail;
>  	}
>  
> -	oaddr = bp->b_data + fs32_to_cpu(infp, op->olt_size);
>  	eaddr = bp->b_data + (infp->vsi_oltsize * sbp->s_blocksize);
> +	olt_size = fs32_to_cpu(infp, op->olt_size);
> +	if (olt_size < sizeof(*op) || olt_size > eaddr - bp->b_data) {
> +		pr_notice("vxfs: invalid olt header size\n");
> +		goto fail;
> +	}
> +	oaddr = bp->b_data + olt_size;
>  
>  	while (oaddr < eaddr) {
>  		struct vxfs_oltcommon	*ocp =
>  			(struct vxfs_oltcommon *)oaddr;
> +		u32			rec_size = fs32_to_cpu(infp, ocp->olt_size);

Overly long line.

Otherwise this does looks sane, but given that freevxfs had
exactly one user in the last 20 years, what is the point?
