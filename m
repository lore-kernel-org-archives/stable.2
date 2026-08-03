Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948E2C032E;
	Mon,  3 Aug 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746463; cv=none; b=X6ngaycmb9Q8oPN2ttlsqt10aWXkIoZ0KfLPlXzz85R2EcZI3FHtlVwQCzEjBPj5EBd1He1yqKOkW1IqP7niV+g7ARrqFdYPPWDW3DDRIKipBIf7Js5atNVbSjqTjBbqT/Q0JxF3iNkDLKW/OrpEm+tVGGwoVkx2g2EzQV+THSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746463; c=relaxed/simple;
	bh=u4yzjEzTIfXZmhWOGnIBTiZsmQDMKpHVfT7PoUd11ZY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BnXG2g2kLddSi7EPhjyWuU49mNpS8X2ImMFyE/VGs09RbiVDAeIyO+LYui9Mg3KJrG8d36hD9a97RJSY/4ia9aPnVfq5v8wk/zQCnr5Nr9/bWq7HTBeeKf7a0H9q5jOxbjbLpBEVNuAEZhO9fsnBEnSRGhsCTOOaojOCo+W/0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIEGVyW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIEGVyW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCCB1F000E9;
	Mon,  3 Aug 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785746461;
	bh=TfQSkuEReZbncE2oup2LjZWcdyVQEqI2058eWQArA/c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=KIEGVyW7iNJ2QQzeAjT6M+Ou0ZgtOAMCMwwCEUyMhhmUcSo/Ha6MOLAJVjET6WDB9
	 mXadHG4Cl8SWATeK2KIUFPWJaSw8bKBcGo28e4m3s+jQSvYcM97kUGrFmE5aSRPTUr
	 ji8RncBWrP71MVHhBLeMKFhn+dS5ScuEDe0xhtvatSaxgZbJg+OvfdCwred95VR4pq
	 Hx6m0EhPWr9Khltg5D02UdVNUW3LcZtyXqMXU6XsGxmdxOZc47c95pTj2TGqEeomHw
	 rFgTh9ZOTJsBw13LZycDgTRdHSyLFdl5tHzk8Y2i2kGNuRFYmOyDS5DEhzda9MuJIK
	 u0gbtiXca4OOA==
Message-ID: <0b6c89a7-0c09-4244-8238-be12862328a3@kernel.org>
Date: Mon, 3 Aug 2026 16:40:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Christian Brauner <brauner@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: use the mount idmap for the owner check in
 f2fs_xattr_advise_set()
To: Rochan Avlur <rochan.avlur@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260729041656.51967-1-rochan.avlur@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260729041656.51967-1-rochan.avlur@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 12:16, Rochan Avlur wrote:
> f2fs_xattr_advise_set() calls inode_owner_or_capable() with
> &nop_mnt_idmap before allowing the advise xattr to be set, instead of
> the idmap that was passed into the handler.
> 
> Since f2fs supports idmapped mounts, this compares the caller's fsuid
> against the unmapped on-disk owner rather than the mapped owner; resulting
> in the actual owner to be wrongly denied with -EPERM. Use the idmap
> argument that was already passed to the xattr handler instead.
> 
> Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>

Thanks for the patch.

I notice there is already a patch:

https://lore.kernel.org/linux-f2fs-devel/20260716025908.608098-1-zhanxusheng@xiaomi.com

Thanks,

> ---
>   fs/f2fs/xattr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 610d5810074d..281e2fd6c778 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -118,7 +118,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
>   	unsigned char old_advise = F2FS_I(inode)->i_advise;
>   	unsigned char new_advise;
>   
> -	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +	if (!inode_owner_or_capable(idmap, inode))
>   		return -EPERM;
>   	if (value == NULL)
>   		return -EINVAL;

