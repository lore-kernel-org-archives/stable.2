Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F282475F7;
	Mon, 17 Aug 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952780; cv=none; b=fY1PslB7ej7Dy/U6GDlXsMv/dCEf3sYnMiNUV7QWS74PpA2Dkdd3qkX0+17FHYCCuHPFnIMLgwhLNz+nRQ0elsF70Zzom/jej56W4/9PoiZAuylZ+DYErfPuIPwPTSiVYJhnCj2V8Co2FlcP2ujq3OjcltXbvUXkpRaOru/3Ahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952780; c=relaxed/simple;
	bh=Yt65Jb9Hqpkawj5X0j7bYU1Su3aQC+kjHY+GGij7OrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBJbfL/2Sp2U70w0Opv53S+umXuR4frFXR/iKMn+36xfc8qtwknI9EcpNvwCi8B83csZQOwALd22/pwEibB7gJM5gkvmL/yVCj4GzzyhRYodfD6dwZWgBH/RFIyds+GtpxwX+DfWXe6rWw0S73UK3UH/jPVN2PGqp11SkciXv1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OowGp0BA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OowGp0BA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vbOaEtok5gbldi2AYftLQvoiGyh8fPqsDjdJTNLwiTg=; b=OowGp0BAPsb+WimBQOiOFTIxDd
	3TXyP7RXxUsg5j+6ZwxeXIL+mWMbbUEdQ9D6z2NAQ00KDovcv01e8hDNZkEFKhCdRuqpDbuPudOd6
	3clFI6bp7b+s/nSwlj+UNol7hiRocNiyq/Vg7xr7LCRdtuE09f5xVwQP5obPrOdO76wFjq9Qj3Ddm
	rEKInxrLSYdzJ47AYhk5ncnjYL/78RVq8NtSx2bbetZjEJgLcQx6ssjnz0ZztrzPi83H/49up2uTB
	jgXlZJ6CGWrYghSDJhJUx+Qc8Km5x6zIuUZ3DSFS3saLUu4RgdCZ/t5sz3bNSoalaovCAP3wfDn62
	I8pOnzqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvs2z-00000005aoI-0C9R;
	Mon, 17 Aug 2026 07:46:17 +0000
Date: Mon, 17 Aug 2026 00:46:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: clear ia_ranges on sysfs registration failure
Message-ID: <aoK8STazvF366Qwo@infradead.org>
References: <20260814220448.4085032-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814220448.4085032-1-shuangpeng.kernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

On Fri, Aug 14, 2026 at 06:04:48PM -0400, Shuangpeng Bai wrote:
> disk_register_independent_access_ranges() clears disk->ia_ranges when
> creating the top-level kobject fails. However, if adding one of the range
> kobjects fails, the cleanup drops the final reference to iars and frees it
> while disk->ia_ranges still points at it.
> 
> A concurrent disk revalidation can wait for q->sysfs_lock and then call
> disk_unregister_independent_access_ranges(), which dereferences the stale
> pointer after registration releases the mutex.
> 
> Clear disk->ia_ranges before dropping the kobject references on the child
> registration error path, matching the top-level error handling.
> 
> Fixes: a2247f19ee1c ("block: Add independent access ranges support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> ---
>  block/blk-ia-ranges.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
> index 7be8b58893c9..2430e475a8e7 100644
> --- a/block/blk-ia-ranges.c
> +++ b/block/blk-ia-ranges.c
> @@ -135,6 +135,7 @@ int disk_register_independent_access_ranges(struct gendisk *disk)
>  					   &blk_ia_range_ktype, &iars->kobj,
>  					   "%d", i);
>  		if (ret) {
> +			disk->ia_ranges = NULL;
>  			while (--i >= 0)
>  				kobject_del(&iars->ia_range[i].kobj);
>  			kobject_del(&iars->kobj);
> -- 
> 2.43.0
> 
> 
---end quoted text---
