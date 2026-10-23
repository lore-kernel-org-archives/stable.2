Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779600;
	b=UxtRZqXoaxp3GRts+IiCH8SdQe0TaKNyamDHA2n8XYSQXUhKLWkSBh2ufxC5uMAena4Y
	 b38R/uzLOEkkBhyz9t5UYp/WZs4E3w4Vdksdxm/7MALUuFiMCAr/5wuEeE8JkvDLAW2e7
	 YxNXVEH1Okw86nbX0z0yG1zpfB4MGwYCd1U9ydJOjdmWELB2xthKHlqccu11Q0CY9ZGGV
	 QZg9xa8dsPSiKllfhdhgweM9m8zHPRKNvpaOGtJ7YllW+T5OcQtw5H34i3geenDfaAPMW
	 /YjTkFSX4TmoADaL73bAKaIiuCkwwXGCpAtI5m8BM50NvJlN98YZ1Nr21Kggp/7uagQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779600;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=G2c9gMhC26zOajKSMEZ7r3qKmAbIN4QuJKbmwPZjihI=;
	b=4TEgIFMKPmyMhYlttFMG4hSImO7k5eEjmyYVF8awaEgfEpKWEcFz8sUdFXEJs/TAdkyY
	 hmXq0UVSkZjQ1ks9QGUlCFV2xkf0GVHZz1Vi7RlVlphRNuiTe9SBXykTfwIP9s+VHW6Mk
	 2yEIt8wDU/y9Y603Mng35BOdq/yoNpUJPbfZjENJeDm4OmBS72f+kfKU0QjgWKkqdsfdK
	 p5M4/ju1nBpKrk86VVeKgMIvGd81Fy6DxciZ2CpLTxJwQggNKV/bFHB/1TabYwBb/cx4+
	 P7HOW/12AalmtUXfqvDMc1NzYxOtUFt6ngO0xahP2FCQENn7TvnTAirh4L1dNYTctOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWlPZqPU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FE606A31D;
	Fri, 23 Oct 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OWlPZqPU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F24E1F01825;
	Fri, 23 Oct 2026 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792779599;
	bh=G2c9gMhC26zOajKSMEZ7r3qKmAbIN4QuJKbmwPZjihI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OWlPZqPULT7AvYT142dXhPcGli+cTs827dJh+OFQRg3hqG9TU077T28tpi5Y/QbfU
	 2O/oynuiepFmtEL7o/JYxeYIzGLIOuLFH8rWl+NFhJ+Va8rdylrykdLt53QhSOi++0
	 ucquZUZBvBo5MjidzBWGjh4eQDUJ1w8E8gASUL1pMvAjRR4MJI/20psHpIMk7y2PZW
	 al/+3tna+QI063mE3WJbffMTk3VY09wVqD/WJL5ryIWwaC5Wm0OtATwHTLKGYtf1pn
	 4Zrlrj2naxR7KOZ9VxCQlARjKIJvAelMZzQWZklNgKIQeZao5eYVV3Tv76tHsyV3JU
	 dbbYXM6Sra/cg==
Date: Fri, 23 Oct 2026 20:19:36 +0200
From: Gao Xiang <xiang@kernel.org>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com, jefflexu@163.com,
	dhavale@google.com, hongbohbli@tencent.com, guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] erofs: fix metadata reads at the end of file-backed
 images
Message-ID: <atulOBxgbf0OIyOE@XiangdeMacBook-Pro.local>
Mail-Followup-To: Hengyu Liang <hengyul@cs.unc.edu>, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@163.com,
	dhavale@google.com, hongbohbli@tencent.com, guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20261023174232.3282900-1-hengyul@cs.unc.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023174232.3282900-1-hengyul@cs.unc.edu>

Hi Hengyu,

On Fri, Oct 23, 2026 at 01:42:31PM -0400, Hengyu Liang wrote:
> Commit e587a984d332 ("erofs: use dedicated meta inodes for file-backed
> mounts") made erofs_read_meta_folio() read the metadata of a
> file-backed mount one whole folio at a time.
> 
> However, an image only has to be a multiple of its block size. With a
> block size below the page size, it can end in the middle of a page. The
> read of that last page is then short, and erofs_fileio_ki_complete()
> fails it with -EIO. As of now, inodes in the last page of such an image
> cannot be read, and an image smaller than a page cannot be mounted.
> 
> The issue can be reproduced with util-linux 2.41, whose mount uses the
> image file directly:
> 
>     mkdir src
>     for i in $(seq 50); do echo $i > src/$i; done
>     mkfs.erofs -b512 test.erofs src
>     mount -t erofs test.erofs /mnt
>     ls -l /mnt
> 
> Before that commit, ls -l lists all 50 files. After it, ls -l reports
> "Input/output error" for 24 of them.
> 
> This patch reads the folio only up to the end of the backing file and
> zeroes the rest, as the page cache of the backing file did before.
> 
> Fixes: e587a984d332 ("erofs: use dedicated meta inodes for file-backed mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Thanks for catching this!

Yes, since we reject short read on the complete I/O path,
but it makes post-EOF behavior wrong.

> ---
> Tested in KVM with KASAN on a804c5742bff: file-backed mounts of images
> with 512 to 4096 byte blocks, uncompressed and compressed, with and
> without directio. With this patch every file reads back correctly;
> without it, 24 of the 36 mounts give errors. Not tested on 16K or 64K
> page kernels, where 4K-block images should be affected too.
> 
>  fs/erofs/fileio.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index c36a90a1a4cb..b4ed7fe7347c 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -142,17 +142,26 @@ int erofs_read_meta_folio(struct file *file, struct folio *folio)
>  		.dev = { .m_pa = folio_pos(folio), },
>  	};
>  	struct inode *inode = folio_inode(folio);
> +	size_t len = folio_size(folio);
> +	loff_t pos, isize;
>  	int err;
>  
>  	err = erofs_map_dev(inode->i_sb, &io.dev);
>  	if (err)
>  		return err;
>  
> +	pos = io.dev.m_dif->fsoff + io.dev.m_pa;
> +	isize = i_size_read(file_inode(io.dev.m_dif->file));
> +	/* the image may end in the middle of the folio, zero the rest */
> +	if (pos < isize && isize - pos < len) {
> +		len = isize - pos;
> +		folio_zero_segment(folio, len, folio_size(folio));
> +	}
> +

Can you just 
	pos = folio_end_read(fi.folio, uptodate);
	isize = i_size_read(file_inode(io.dev.m_dif->file));
	if (pos + folio_size(folio) > isize) {
		len = isize > pos ? isize - pos : 0;
		folio_zero_segment(folio, len, folio_size(folio));
		if (!len) {
			folio_end_read(folio, true);
			return 0;
		}
	}

...

Since post-EOF should be filled with zeroes all the time.

>  	io.rq = erofs_fileio_rq_alloc(inode->i_sb, io.dev.m_dif->file);
>  	io.rq->bio.bi_end_io = erofs_fileio_meta_endio;
> -	io.rq->bio.bi_iter.bi_sector =
> -		(io.dev.m_dif->fsoff + io.dev.m_pa) >> 9;
> -	bio_add_folio_nofail(&io.rq->bio, folio, folio_size(folio), 0);
> +	io.rq->bio.bi_iter.bi_sector = pos >> 9;
> +	bio_add_folio_nofail(&io.rq->bio, folio, len, 0);

Thanks,
Gao Xiang

>  	erofs_fileio_rq_submit(io.rq);
>  	return 0;
>  }
> 
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
> -- 
> 2.53.0
> 
> 
