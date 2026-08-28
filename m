Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCF3CBE9C;
	Fri, 28 Aug 2026 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899708; cv=none; b=Z6e4+btnA/52sNRfFD+ON+ylJzvVz3PQcvod7y2epv7Ep4RrWdxPpxF7N4HtB2sBmXqp3Kki43Kn10QIojYkpFgsa+Z8WCK3PHdYhY2wXu6OeAd85MQnyoRi4mc5pBXwnIWTrXE2jPjj/mt830fJNzKI0xX9qZw9684pWjEyYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899708; c=relaxed/simple;
	bh=0mXVft9VFASRJxd9qA9xwN3xqCiX+uuUuRmmj5XXj8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHBzBiLJYzJvOOaHKXrqGnxNZ9/0IRsw235FEPKPLPYTFn+4Bg9iUiOTwYSMZZF5WjzLZPyQcADHWszzEmYpwKLk09Znc15ffbdIXGXMA3lBtwAkMSXjy4o1F3TbWmG6pghJpBjV68EsqbJC7JpTSB0GPubZyf0mXRfoT/xkgjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FZ+VEU6E; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FZ+VEU6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=2FbCZn1u3S4FNsq+8mb+8/B/FxJeLPY3PhoFGphQemo=;
	b=FZ+VEU6Euw2F+sd7L1oGYnfNB9+lG92Anefg9gsI1iM/wqvFHFUwYGXUKlsSkN
	YZHfcQlddf4pgrahZ+9fwuhjUsrB7GOrN+sZWKyuQ8qrqexN9nGd7ChH3CU8zp3a
	gcxFuTORs5UNODbbbwJEmGt3fj/97wSBCze3Qc1Juok3Q=
Received: from [IPV6:2409:8900:1ef4:8f82:3f8a:6d15:2d07:8d9d] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXgQEQL5Fq8_wWPg--.50199S2;
	Fri, 28 Aug 2026 14:47:46 +0800 (CST)
Message-ID: <ba9fa26c-dd72-48bc-b938-b3cff9a4f323@163.com>
Date: Fri, 28 Aug 2026 14:47:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntfs: take invalidate_lock in ntfs_setattr_size()
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260828061607.240845-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260828061607.240845-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXgQEQL5Fq8_wWPg--.50199S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4kWrWrJr4fGw4fGr15Jwb_yoW8ZrWfpF
	ZIkF1rK345tr4DWrnrGa1UW3WrW34kW3yUury2yw47CF97twnrKF18K3yvg397trZ7Jw45
	tr4DAFs3Cr4xZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRpVbQUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwhLOmWqRLxL4TwAA32



在 2026/8/28 14:16, Hongling Zeng 写道:
> ntfs_setattr_size() updates i_size and resizes the on-disk attribute
> without holding mapping->invalidate_lock.  Page faults take the lock
> shared, so a fault racing the resize can resolve a VCN against the
> transient runlist state of ntfs_non_resident_attr_expand() and fail
> with a spurious SIGBUS, and can interleave with the size-change
> epilogue (truncate_pagecache(), i_size_write(),
> pagecache_isize_extended()).
> 
> Take invalidate_lock exclusively around the whole resize after
> inode_dio_wait(), matching the fallocate path and other filesystems
> such as xfs, which wraps truncate in its mmaplock (= invalidate_lock).
> 
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/file.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 1969e4f444f7..585ab2145797 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -270,18 +270,25 @@ static int ntfs_setattr_size(struct inode *vi, struct iattr *attr)
>   		return err;
>   
>   	inode_dio_wait(vi);
> +
> +	/*
> +	 * Serialize with page faults and pagecache instantiation so that
> +	 * readers cannot observe the size change until the attribute
> +	 * updates below have completed.
> +	 */
> +	filemap_invalidate_lock(vi->i_mapping);
>   	if (attr->ia_size > old_size) {
>   		truncate_pagecache(vi, old_size);
>   		i_size_write(vi, attr->ia_size);
>   		pagecache_isize_extended(vi, old_size, attr->ia_size);
> -	} else
> +	} else {
>   		truncate_setsize(vi, attr->ia_size);
> +	}
>   
>   	err = ntfs_truncate_vfs(vi, attr->ia_size, old_size);
> -	if (err) {
> +	if (err)
>   		i_size_write(vi, old_size);
> -		return err;
> -	}
> +	filemap_invalidate_unlock(vi->i_mapping);
>   
>   	return err;
>   }

Looks good to me.
Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

