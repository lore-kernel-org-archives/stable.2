Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E539D6CC;
	Mon,  3 Aug 2026 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740884; cv=none; b=D/hXvmfesVrh6EFkXqaXxa2nuDobda8uBleAaWkZVL5gQ1DlE6HA8bHsYejuerdh8/+BtfyM9/iABVygWCVhfhQwERxaLGH6FLpQcpTKafMG28FCqGW3Gn5XvTREni2PEW5ooc8tvHV6Pexibd3LUgdfPLWIhqMY2FWRkxVrn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740884; c=relaxed/simple;
	bh=yuhAkuUz7lyXELljjeRQe98l8YJ10zN4dr6+xC/YDyw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CeAZ40R5UDF34z10avcgZij8jblCI9SJGxyFSfH6STbWJkZIfn+SPYblvCnZ5n09+iztZ+8mnLfW2HCgWOahH3u/WxKJ1eGPmoJyoEyTTDEfdEfdGaoSPrdTQQE6dT18rJ4XQ33hN14J+LavyECEeQpPQc3V7GFB5GVR7XRUCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAeQkoFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAeQkoFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A521F000E9;
	Mon,  3 Aug 2026 07:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785740882;
	bh=O4JiXbd+a30fELma3hISkdDkULyA1AU9v/peO8WzUe8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=jAeQkoFt7WhF36HIiKZE1FWXw7GajEghVI/VG0yFpeYFsmymQPi2vAtmNqhArxkj8
	 et0eErY7KeP2YLj/KRPTwp2RLHZwJLcpNc5hnv5yF0TtYSyVtYTjeEUxOvyUcwdCUz
	 bRBvWmARk4cKizrXkUuFw3TJuiETTmCMOEGtMjus2+vgCnZmBHdgAPHCpixVHzlrkt
	 cf7cpLFA5haRaZ7us8BGvTYzky2rbsvei060XYm/vOFWjM8gFR7w6UkU7OI16J2loy
	 NAX/hUJeV52qKJ5g+0/SEUK1xIsVl5gBIyirtB3KXgf100ZF2p7n7jVmgMg3a7237B
	 aRVtfuDodhT2w==
Message-ID: <4febf145-36cf-4d4a-b9d3-1c33ac273607@kernel.org>
Date: Mon, 3 Aug 2026 15:07:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: reject overlapping move range after len expansion
To: Hao-Qun Huang <alvinhuang0603@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 14:54, Hao-Qun Huang wrote:
> F2FS_IOC_MOVE_RANGE treats a zero length as a request to move data
> from pos_in to EOF. However, the same-file overlap check runs before
> that expansion, so a request with len == 0 bypasses the overlap
> rejection added for same-file moves.
> 
> For example, with a four-block file, moving from block 0 to block 1
> with len == 0 is accepted by the old check because pos_in + len is
> still pos_in at that point. The code then expands len to cover the
> rest of the file and calls __exchange_data_block() on overlapping
> source and destination ranges in the same inode, which is the
> data-corruption case the overlap check was meant to reject.
> 
> Move the overlap check after the source range has been validated and
> len == 0 has been expanded, so it sees the effective length. This is a
> no-op for non-zero len (the value is unchanged there) and keeps the
> existing early return for identical positions.
> 
> Fixes: d95fd91c1ac1 ("f2fs: exclude special cases for f2fs_move_file_range")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
> ---
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4b52c56d71f0..fdfef01dc799 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3144,8 +3144,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	if (src == dst) {
>   		if (pos_in == pos_out)
>   			return 0;
> -		if (pos_out > pos_in && pos_out < pos_in + len)
> -			return -EINVAL;
>   	}
>   
>   	inode_lock(src);
> @@ -3171,6 +3169,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   		goto out_unlock;
>   	if (len == 0)
>   		olen = len = src->i_size - pos_in;
> +	if (src == dst && pos_out > pos_in && pos_out < pos_in + len)
> +		goto out_unlock;

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   	if (pos_in + len == src->i_size)
>   		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
>   	if (len == 0) {

