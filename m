Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1F212542;
	Tue,  4 Aug 2026 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802097; cv=none; b=rSSKUH74hetmaxk8SgR8lvk3+bwgNZfOs3131WfxBaF8IJ2dhi+3SOiXqj27r5qCls3S9EIenNrN9DciD6wKq7yAVEysZUD7FL9Q+/I3LnXdfjBW7sXi1aTioNH3yb2eLhE3ZBUdKXwDRKjWoxt3mo4DYy/d5ll3obaz748xO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802097; c=relaxed/simple;
	bh=yRAyrMuenJyHY+SW/5KVuil7zSjOUFXgHszBM3J4Ggk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TS7+AHgAXRj/eu21kuuLJ6Zz7p7mQNJzLvQNSf4m4G+/eaIfwoR9DrP+UQxjwXLArdISwQFckIDVhwNiGxXlhXWT9iuL4Qg77lQtOTXBL6VvKLxxPD+E/do1Ykzh+88xInpGtYpYN1NZPGEBTi34jgdIpZk3K0ro2sFz0Kp++tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4hEkZUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4hEkZUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CFC1F000E9;
	Tue,  4 Aug 2026 00:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785802095;
	bh=V6JMc4T97qa7AdgeRhkv+CB1f4XYEGtyD+lrlDxriQw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=l4hEkZUPUZb9N+vu4/HX9J0GdPbpGLarUO0nVFsrdNUHQaCJNOfP926uUyJflCuWU
	 477JaJAZGnB3CvWbo9ePBlmoyB3IlOIsEHY7UJoEgzmWy8Yu9nv1LPrtavtlRglwcH
	 gEkSVJXRw0e68Jcmc33bWDquJjh2NexYGb6VU0UTDW1GtIYdedMGhSxbhI6rnHlNL1
	 X9Tc7ip9deJvdk7T6y+sOsKYh0VzOIySrCmlYC6yCRBqRtwHxG/vFzlQZgKtyEuzvG
	 4BQ8DKUb3mOii3bRqILZABTzURgz9g+bWOLG/HGgrv88Jnt8ArlS+SeMupdDuYqVEd
	 37zpDI3Sb4yYw==
Message-ID: <0b450e92-b9b0-4a55-bd16-ad106245d7e1@kernel.org>
Date: Tue, 4 Aug 2026 08:08:12 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ccc194101@163.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix valid block count leak on data block
 allocation failure
To: Chen Changcheng <chenchangcheng@kylinos.cn>
References: <20260803073800.218814-1-chenchangcheng@kylinos.cn>
 <20260803074344.219899-1-chenchangcheng@kylinos.cn>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260803074344.219899-1-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 15:43, Chen Changcheng wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> Fix this by calling dec_valid_block_count() to undo the
> increment before returning the error. The condition
> old_blkaddr == NULL_ADDR precisely identifies the case where
> inc_valid_block_count() was called.
> 
> Fixes: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")

Should be?

Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")

Thanks,

> Cc: <stable@vger.kernel.org>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> ---
>   fs/f2fs/data.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a765fda71536..819631bb61ae 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1532,8 +1532,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>   	old_blkaddr = dn->data_blkaddr;
>   	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
>   				&dn->data_blkaddr, &sum, seg_type, NULL);
> -	if (err)
> +	if (err) {
> +		if (old_blkaddr == NULL_ADDR)
> +			dec_valid_block_count(sbi, dn->inode, count);
>   		return err;
> +	}
>   
>   	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
>   		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);

