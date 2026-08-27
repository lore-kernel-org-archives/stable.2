Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB02388E5A;
	Thu, 27 Aug 2026 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787804267; cv=none; b=axp4+T2J6r4sNVJvryciRYezd0Bq4DMslhnCHMFNtWK3TygWNsW7UNju8ZxDLY2uEHpSvmPvj6tIFdcSt0k3mYQQXTI/0n1Ho/2BcZa/Y3bn/jlNSU7UiXG5s3iYpauyX/pb1T8snZ7kuHSZAdN1wtO60qwb0PsvRKZ5cYJS5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787804267; c=relaxed/simple;
	bh=DabkrjeINdJ1/NWCYp3fyBZBITERqCH3BISmGggnSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDVOudOzQ6yMDYvCuOIl8cCDh8E9SbBlrxFjGOkbvnlfgnbdV4VKqoYV6uh1xkEy/eDpllYG2z+svuLK4EjBASbtuD3R5bFT3sgGr4OGda56NVNJeH1CMDpESarSYkhKaoOPvexMZ2dX3FBCLjkLyEnOL8dABIyyNMPHGIX5jzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I9rSX58X; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I9rSX58X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=tc/NaKKGBpM+izFIokJfEr1gtOU1x61CifjiB4xfVGs=;
	b=I9rSX58XhZRg3PbuitIuYSdBGdIAb2aIa5GqGjyRy+mQETYM8V9UIgEhoDsikT
	hARluEsqzdf3HsrCPzEymZtnz/nK/PEGP+dgghNRevs3vqP5Mrm/CdP6xwfUczrf
	Wcs0vUNtCCXO9yIX7if4FQ7xw2xt8gmdkFebM5wYRn1CY=
Received: from [IPV6:2409:8900:1ef4:8f82:6a1b:f1a6:cbdd:11fe] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn3gVNuo9q_gFLPQ--.23413S2;
	Thu, 27 Aug 2026 12:17:19 +0800 (CST)
Message-ID: <9022d6dc-3746-4f37-91a1-dfc17fe04fef@163.com>
Date: Thu, 27 Aug 2026 12:17:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: handle signal interruption in fallocate
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260826055953.1372417-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260826055953.1372417-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDn3gVNuo9q_gFLPQ--.23413S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1DArW5Wr17Cw1kZF17trb_yoW8ZFy7pr
	Wjkr90k3yfXr9rCrnxKw409a10934Sgr4UGrW0vw18ZanIq3WUGFyUtr10q3WftFykAw1U
	XrWj9r47Z3y7Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRZFxbUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q9AC2qPuk+3ygAA3A



在 2026/8/26 13:59, Hongling Zeng 写道:
> The ntfs_attr_fallocate() function checks for pending signals during
> allocation loops and exits early via 'out' label. However, when a signal
> interrupts the operation with err == 0, the function returns 0 (success)
> instead of -EINTR.
> 
> The signal_pending() checks at the allocation loops jump to 'out' without
> setting err = -EINTR, so the function returns success even when interrupted
> by a signal.
> 
> Set err = -EINTR when jumping to the signal exit path, and only override
> when no other error is pending. This ensures:
> 
> - Allocation interrupted by signal returns -EINTR
> - Allocation that completed successfully before signal arrived returns 0
> - Other errors are preserved and not overwritten by -EINTR
> 
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/attrib.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 60264833bb63..c898250f63a7 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5709,7 +5709,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
>   				}
>   
>   				if (signal_pending(current))
> -					goto out;
> +					goto signal_out;
>   
>   				vcn += alloc_cnt;
>   				try_alloc_cnt -= alloc_cnt;
> @@ -5730,7 +5730,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
>   		up_write(&ni->runlist.lock);
>   		mutex_unlock(&ni->mrec_lock);
>   		if (err || signal_pending(current))
> -			goto out;
> +			goto signal_out;
>   
>   		vcn += alloc_cnt;
>   		try_alloc_cnt -= alloc_cnt;
> @@ -5756,4 +5756,8 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
>   	mutex_unlock(&ni->mrec_lock);
>   out:
>   	return err >= 0 ? 0 : err;
> +signal_out:
> +	if (!err)
> +		err = -EINTR;
> +	goto out;
>   }

Looks good to me. 
  

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

