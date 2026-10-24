Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792871359;
	b=KfHlcFkinkb75C9c2ZO//4Za3z7HGcJctXkVWKaMPCmrMPtESOYweH8862deR+kRObcW
	 6+Dwfy1zyBg0JwxUOXiD1zszuXkWgBoNz6lc4Zk7hkpmC2QV+NLJLeDt4kX07xpisPjGi
	 3lqYJkYQSu0XQAKq/cNlAwXDaJuPqcS9ykoWIJvtlLf72Gy4P6lbDdcZ/3E0PcgK6g0dM
	 GDLwjNTXbxGdgoDxSIKUpa3UFG2a8j8XzhjrT/yOEAzWAcxLlMVtSgSQOZ0u2psAMkS5r
	 MEDK2GqJIhAncBKEy6ExTx0JLO78ZMa7u0Z6JTn7N9EBHvhhGcN/DeGleqmPi9cC39w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792871359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Lolb73ZzkNeVgvmRmzP6aoaOobLavyPT6W9rKgYFA2k=;
	b=OvZ1pUoCoLd6q1iniuOofYz0lgCD2HqIQryqC5Lzg7R97MbqwFQ3AYgMpm0kdMk9LWWy
	 bdVabcDYLk6RYpjvtx6Sh4gg99e2NYY87ovE2gyD3OVAzKmWXjpGX61pNeXrDmGJokTET
	 CE0fG5OAJoweA3w/sCR7YqGMz/680GfHAM9xEbj6kWOfjPLZg+BjLluNwnmLPwFUpwdhD
	 WpnjIR57p3rbnJ4Mik1QkEzBJoq8hcg/6URJgpYW7yHKSjhT6keRJQHCny9f+W1bsnlX5
	 zixQ84nc3v8o7wKnX3piz2wNci/of9kJEjSQV4IErd5IAbOmT8LTKLTYiDR1OJqEjEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTPJQGRD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB91606A31A;
	Sat, 24 Oct 2026 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTPJQGRD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD24E1F01825;
	Sat, 24 Oct 2026 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792871359;
	bh=Lolb73ZzkNeVgvmRmzP6aoaOobLavyPT6W9rKgYFA2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTPJQGRDTq/Damy+nZIDwbaBi5mKEikg6ZiCXnHVxB4mlVRQGnCR9ffg1/1jfk1Tr
	 9HhOxXIMp2I9res7so/5oAS/TK0KBEtNKaA5IXLFM3dcjsOyLFerixtLr9aX3coHc9
	 rFfyT/sgchtEh+Jbr/0HJpv76tAhkipoY+GKcDhsU7r/T+BtznLXwf8jCy+a0eiCTP
	 JQ7RwCT0kBt4ZQynGpn0bi+sdERq+5aHRd6DK5H9hjps5LrIqzWdogvvD+NILMc097
	 +gbIjG98PApTqTlUYyJ/lnDy1dRKDS2LCXyEvolD48WMIunNXR5liA0ba0iseRT0Ng
	 La0jb+VXxo7DA==
Date: Sat, 24 Oct 2026 21:49:09 +0200
From: Gao Xiang <xiang@kernel.org>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com, jefflexu@163.com,
	dhavale@google.com, hongbohbli@tencent.com, guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] erofs: fix metadata reads at the end of file-backed
 images
Message-ID: <at0LtfBEoQpV4VDn@MacBookPro>
Mail-Followup-To: Hengyu Liang <hengyul@cs.unc.edu>, xiang@kernel.org,
	chao@kernel.org, zbestahu@gmail.com, jefflexu@163.com,
	dhavale@google.com, hongbohbli@tencent.com, guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20261023190051.3457491-1-hengyul@cs.unc.edu>
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
In-Reply-To: <20261023190051.3457491-1-hengyul@cs.unc.edu>

On Fri, Oct 23, 2026 at 03:00:51PM -0400, Hengyu Liang wrote:
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
> zeroes the rest, as the page cache of the backing file did before. A
> folio that lies wholly past the end is zeroed without a read.
> 
> Fixes: e587a984d332 ("erofs: use dedicated meta inodes for file-backed mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Changes in v2:
> - Also zero a folio that lies wholly past the end of the backing file,
>   without a read, as suggested by Gao Xiang.
> - v1: https://lore.kernel.org/r/20261023174232.3282900-1-hengyul@cs.unc.edu
> 
> Tested in KVM with KASAN on 734bef548a96: the images used for v1, plus
> three images cut so that whole folios lie past the end. With this
> patch every complete image reads back correctly, and the cut images
> give the same results as v7.2 (EFSCORRUPTED instead of EIO for the
> inodes past the end).
> 
>  fs/erofs/fileio.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> index c36a90a1a4cb..a77af604479f 100644
> --- a/fs/erofs/fileio.c
> +++ b/fs/erofs/fileio.c
> @@ -142,17 +142,30 @@ int erofs_read_meta_folio(struct file *file, struct folio *folio)
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
> +	/* the image may end before the end of the folio, zero the rest */

I dropped this obvious comment, otherwise it looks good to me:

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
