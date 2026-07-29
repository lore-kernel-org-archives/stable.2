Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DF306767;
	Wed, 29 Jul 2026 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299346; cv=none; b=sByHcnrt+lj4uOr+5ampq99ofG1DyJy4EBjTHGYD5BtzcAkueLiHzz/scKesk8phFpny+bbD0s0tySLnGRSE8yHbjHyfXbAs0svnnT5/OtxBAH9Rlc1HqDV/4k32VrXVmlo8A3BGFZFIe8hUv2IhT7ILU+LWQ2X1sDwd0VQcvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299346; c=relaxed/simple;
	bh=ujNJ0RFbjUXZ8rF1L1zk/po35+0og+0XuuB6JCxbUS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDrofdeCFEATv9daqUy6MWh2Ays1zmo25RJyZsVlNDsZI4KCtg1g71Z0KD9/egyCXBDloI0JeRrfWBzYvyT47d86B8lOZ8iVbCiUZMA3aVwBnSP8M5onr+45e6Sxw7gT/ZsoEjkPfyjkqNauRYn1xbktT31gO4jNl6MmrlF/OOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+lZg8jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+lZg8jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3EC1F000E9;
	Wed, 29 Jul 2026 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785299345;
	bh=NhYByOYdjqTagJsbd5bhFPYnF87CmrjdzFkq5OwJI3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+lZg8jgUB86d92pEk/aNrND61/ZJ0FyacJZgGq95VBTGUtR1cxi4wt7+ydsnmuE9
	 LmuetMVBObQR/VdS3gv99Uy5g1Y37NzwVY+yd8HZSXjdGk+GC4B8QQxZvtYzC2n5Qv
	 JF7m2Ff8I3HVT7+GDe4T3fyNoyZ2A20v8xkPm0/xsORv7InC0+uMYc5ZcnPmJZTqji
	 9RdLg9kuiGda+J9eEWlfzqvZ1w0CUEpdTt+8BExTjSF/rvPo6PaEciW+FSIfo2/OSl
	 zVHW1U6HMC4y2Q8hTwX4lWmjKADAJaPCEIzHmzUpBmhWdzkhdUnZGvKWLaR6WGm00f
	 3rDBC6dJ1zJaA==
Date: Tue, 28 Jul 2026 21:27:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] fs,fsverity: remove check for fsverity being enabled in
 setattr_prepare()
Message-ID: <20260729042710.GB1705@sol>
References: <20260727094352.1734826-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727094352.1734826-1-aalbersh@kernel.org>

[+Cc linux-fsdevel@vger.kernel.org]

On Mon, Jul 27, 2026 at 11:43:52AM +0200, Andrey Albershteyn wrote:
> The check that fs-verity is available in the kernel is not necessary
> here. Filesystems could have fsverity files even without fs-verity
> enabled. In that case, truncate on fsverity file will succeed, what this
> check is trying to prevent.
> 
> Fixes: e9734653c523 ("fs,fsverity: reject size changes on fsverity files in setattr_prepare")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Acked-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Notes:
>     I rephrased commit messages a bit to be more clear.
> 
>  fs/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 4f437fabb7f0..71888ac903c2 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -176,7 +176,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
>  		 * covered by the open-time check because sys_truncate() takes a
>  		 * path, not an open file.
>  		 */
> -		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
> +		if (IS_VERITY(inode))
>  			return -EPERM;
>  
>  		error = inode_newsize_ok(inode, attr->ia_size);
> -- 
> 2.54.0

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-current

- Eric
