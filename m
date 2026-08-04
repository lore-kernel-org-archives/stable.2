Received: from sxplsmtpa04-09.prod.sxb1.secureserver.net (sxplsmtpa04-09.prod.sxb1.secureserver.net [92.204.81.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F6413D62
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872835; cv=none; b=P1+pcLPwKegHoLlIlh+FzNKi2dCSgUAll0xqQpjo+rwT7DNZGX59SaU7ak4AxByFG1rRJ4svgy9Ku7meidFBQ90Cksutanmm+gSJpPZXf91x3KATSJZUn/1rESjPBUu42FS/zMoc7+0T47c8xAvrU3il9SCriF3vEKgbC7V2sD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872835; c=relaxed/simple;
	bh=uuCPDABeI8THV/Wgd69Hbsl74V2JvcUtzehZ/fpSIUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFxR7rEMftYqMjsdB2Qbkt8N6OxhzwnAjYk0Bx5Lsbq1DnpNV5At6OtazolHhB1yOJv9YTgpQDldazInaFEVvMAZhdP48QA1KuRMEuKjnqSRdn/tlBDDdlI8UpAY1hrdB+u8sVaCB7Ecs+XKNEWxhvBAseY/2EB8NWSW+1olZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b=F/ISLFwK; dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b=CQZ9baQU; arc=none smtp.client-ip=92.204.81.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b="F/ISLFwK";
	dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b="CQZ9baQU"
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id rKz3wN1nAZp7ZrKz5wkrCp; Tue, 04 Aug 2026 19:39:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1785872373;
	bh=M4S5XIEHI/y0J+bRBKlcZnW1peZNogwcoLm8Sp6IhDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F/ISLFwK7YlZMJqPT1QBJrKeld03+mIih91PfkjJctIg3pZirY1LkrVhPUwRD9WeV
	 w3FtHnkwBSelbVEpgAKr82nsPknqoVinm1RHcsplhfxuZz7R3psAzDalSeI4GBrpQ7
	 jCyJuVgUgtlG+axBuhGBcZEf39+XY59g1jRzmcquz5ZHCPhTyp4DWqC/4Y5PeMx2SB
	 hgezOv3oQv9Dy9JBgQaceI9qpBupMxWImswOdY5XqTe2TUB0fEikiVNnaWy17Thl7B
	 clM1+Y/WLo+4bo1Kpv+JEZq/kYlip2jcgzpE6qV9V6kU7X8b37ywrJ7KCl3OuDfK64
	 O9Z5p0irEBoWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver2; t=1785872373;
	bh=M4S5XIEHI/y0J+bRBKlcZnW1peZNogwcoLm8Sp6IhDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CQZ9baQUZcwxH+HYEHf5CjBR+5U7BVuxHQwgGUgsZy7Xm4C7qwI2j+ihr+FMMGw+k
	 QkF3YZff6w6ImUWcTjPkCdHd4x02Jegv4KDhCT9Wmv9RjqB24W8h4wBwmWvW+3NfVq
	 FB7gD6uFH2yW0wRIMoHQsR5CCTUJ1LhGP11so1QbcTJyiSKaffT+MCYr274bfLqSOG
	 oekS5cNwIe9U5AdLgMqtaxDZSykpvnRvn4wCGi9PcebHOaLsxwZI965itWBZJu2Od+
	 xWLPfUeJo5LZKWTVVtjmTZbo8ktyIi4akz4BC5jMTi/MGpQWlftPRKfsoIBlCYWLKu
	 pQmSJKV1pNBUg==
X-CMAE-Analysis: v=2.4 cv=RaUp41tv c=1 sm=1 tr=0 ts=6a723ff4
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=nFaytsGx70l16phpOWEA:9 a=QEXdDO2ut3YA:10
Feedback-ID: 0a38301e0e0f82352dca74f6e134915e:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <52c572a6-3da3-44c2-9a9f-c7570867dd97@squashfs.org.uk>
Date: Tue, 4 Aug 2026 20:44:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: bound the fragment offset stored in an inode
To: Yuejie Shi <syjcnss@gmail.com>
Cc: squashfs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260803032735.81785-1-syjcnss@gmail.com>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20260803032735.81785-1-syjcnss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDiAie8PRoh9Hk6gJom/2RXankZlJPna8IfrRJRKxokvu3c8JEZuVtFXF3Um4BYtWbOsO6NNYqmRUjHimq9/7NTGSVWvkJuy506LLkSpcYeKAjzQTZ+0
 eF6HkMFCH7lTrsJHXx6iwh+0+fyJrCgXcLwjiI7sMp0G7IshuxXjzttLW+f5NJ/N1398eJBmnl3qDU1dhCUN9D9+c/B6tgUdVcnYsbdAjLZ0HMIsazxsPDM4
 E4N0BH/4uNMB0cmbOoa5QaToFqWc6l4fYMF0hvuQL2ZEKfY2Lz4gF/c0yXMVU1ptYnLWkfrttvTOMK39QFQ+Tw==



On 03/08/2026 04:27, Yuejie Shi wrote:
> Both the REG and LREG inode readers take the fragment offset verbatim
> off disk:
> 
> 	frag = le32_to_cpu(sqsh_ino->fragment);
> 	if (frag != SQUASHFS_INVALID_FRAG) {
> 		/*
> 		 * the file cannot have a fragment (tailend) and have a
> 		 * file size a multiple of the block size
> 		 */
> 		if ((inode->i_size & (msblk->block_size - 1)) == 0) { ... }
> 		frag_offset = le32_to_cpu(sqsh_ino->offset);
> 		...
> 	}
> 	...
> 	squashfs_i(inode)->fragment_offset = frag_offset;
> 
> The check added by commit 9ee94bfbe930 ("Squashfs: add additional inode
> sanity checking") is about i_size, not about offset, and nothing else
> looks at offset at all.  It reaches squashfs_copy_data() unchanged, for
> instance from squashfs_readahead_fragment():
> 
> 	bytes = squashfs_copy_data(addr, buffer, offset +
> 			squashfs_i(inode)->fragment_offset, avail);
> 
> where the parameter is a signed int:
> 
> 	while (offset < entry->length) {
> 		void *buff = entry->data[offset / PAGE_SIZE]
> 				+ (offset % PAGE_SIZE);
> 

NACK.

You have found a bug, but your fix is completely wrong.

Also curiously this got raised as an issue with Squashfs-tools recently
https://github.com/plougher/squashfs-tools/issues/398

and I fixed it in a commit last week
https://github.com/plougher/squashfs-tools/commit/88c47b58df408e8106814079e6979a454269018c

Whether AI is involved or not, this is part of the growing trend to
have multiple reports of the same or related issues by different people,
within days or weeks of each other.  Which is making it more and more
difficult and time consuming to deal with them fairly and quickly.

Comments below

> ---
>   fs/squashfs/inode.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
> index 82b687414e65..4872b28f1b77 100644
> --- a/fs/squashfs/inode.c
> +++ b/fs/squashfs/inode.c
> @@ -156,6 +156,16 @@ int squashfs_read_inode(struct inode *inode, long long
>   				goto failed_read;
>   			}
>   			frag_offset = le32_to_cpu(sqsh_ino->offset);
> +			/*
> +			 * the tailend has to lie within the uncompressed
> +			 * fragment block, which is at most block_size bytes
> +			 */
> +			if (frag_offset +
> +			    (inode->i_size & (msblk->block_size - 1)) >
> +					msblk->block_size) {
> +				err = -EINVAL;
> +				goto failed_read;
> +			}

This is remarkably like the fix I put into Squashfs-tools last week.  Except I
put it in the file write path, when the fragment is about to be written out to
disk.

Why? Because the fragment is only accessed when you read data, it isn't necessary
to create the inode.  Putting the check in the inode instantiation means you
won't be able to use Unsquashfs to do a file listing (unsquashfs -l example.sqsh).

Exactly the same here.  You are prematurely rejecting something before you get to
where the problem is.  Doing it here means you can't stat the file, and if the
tailend is say the last 100 bytes of a 3 Megabyte file, you now can't read any of
it, rather than just the last 100 bytes.

It is also using a hammer to crush a nut, complete over-kill. Cases where
frag_offset (or the combination of frag_offset and the tailend size) go beyond
the end of the buffer are rejected when the tailend is copied.  The only thing which
isn't at that point is a negative offset, and that can be checked then.

Plus this "fix" doesn't even do what it pretends to do either, which is to
prevent accesses beyond the end of the fragment block.  A fragment block may
be a maximum of a block size, but, it is almost always smaller, and can be anything
from 1 byte in size to the block size.

So if the fragment block decompresses to 5 bytes, the fact the frag_offset has
been bounded  to block size is completely useless.  It is the underlying code
which prevents access beyond the actual size of the fragment block when the
tailend is copied.

So NACK.

Phillip
   >   			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
>   			if (frag_size < 0) {
>   				err = frag_size;
> @@ -212,6 +222,16 @@ int squashfs_read_inode(struct inode *inode, long long
>   				goto failed_read;
>   			}
>   			frag_offset = le32_to_cpu(sqsh_ino->offset);
> +			/*
> +			 * the tailend has to lie within the uncompressed
> +			 * fragment block, which is at most block_size bytes
> +			 */
> +			if (frag_offset +
> +			    (inode->i_size & (msblk->block_size - 1)) >
> +					msblk->block_size) {
> +				err = -EINVAL;
> +				goto failed_read;
> +			}
>   			frag_size = squashfs_frag_lookup(sb, frag, &frag_blk);
>   			if (frag_size < 0) {
>   				err = frag_size;
> --
> 2.51.0



