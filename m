Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1C637E5DE;
	Mon,  7 Sep 2026 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770152; cv=none; b=PG4K9ufc4Ocp8jgXOF9idhbpv+mpz1vdj5oIHYQtsjxwC3qegAg/FgvTAwxBre8c2mddALR0GZb7Qg6X8svcairNUkyIMrwqdzkCoMqyfmnALqhmb/vT1hD/cE0LcKRnevKEI508qrPy2R74AyJ+KqtqRw0hLRHbt6lNtXF9baY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770152; c=relaxed/simple;
	bh=Fja9bCbUIZ72CqNHx8WpbG23xt3oe+rgfXZwbGgB+cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUOlOJmr6IUvMduDcWpAw2pJLzyscC/C0Xc3VKBDhh/w62A+DenHSvp+EnVReHRAW/htMhXXj7/IV2vASgmpzBG6HNuW1JOWOZ4mSBvK+zQ4BFkWEboQTvVC5FxCu57kJ1G5gxTfzdEGXnGkbwXM8khpxIlWm0uNh5oJjb44dPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=anyq2syZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="anyq2syZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=iD5hjqjZJPsHFAqATNG9xWcTWffuFguqJoBpwb1tbK4=;
	b=anyq2syZvtpSGO8P+MTpfRAN0gmY8w2CQcIP9aqxna70AGyTmwhN09KJ/wmUBT
	8R0sn2aG0YTf/LTWwLTKnfYYceMANFp9mzHVfce41uud4tmvJ7Q4F4xx5NHLNOAG
	lVZ3Sjyw/b/XdSiSZd6uFeVsQN760Esigqo8rULvOlq5M=
Received: from [IPV6:2409:8900:1e93:d74:46a:b98a:2b32:6a19] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXo95Gd55q6IP7BA--.1196S2;
	Mon, 07 Sep 2026 16:35:19 +0800 (CST)
Message-ID: <62be2fb6-26c5-43f7-972b-9c38a3bd6131@163.com>
Date: Mon, 7 Sep 2026 16:35:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: use fatal_signal_pending() for fallocate
 interruption checks
To: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260907035726.37123-1-zenghongling@kylinos.cn>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20260907035726.37123-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXo95Gd55q6IP7BA--.1196S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF18Jr15ZrWUGrW7ZF1rXrb_yoW8ZFW5pr
	Z8GryYkrWrWrnrCr4ktw4UWFW5W3s7KrWUGrs8Z3WxArsaqFnxKFWxtr1vqF1IyrykXw12
	qrWj9w4xuw4UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRlzutUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6ggy-Gqed0gYLQAA3S



在 2026/9/7 11:57, Hongling Zeng 写道:
> The fallocate implementation uses signal checks to let a long allocation
> loop abort early.  However, signal_pending() also returns true for
> TIF_NOTIFY_SIGNAL, which io_uring uses to deliver task_work completions
> to the submitting task.
> 
> generic/616 is an io_uring fsx soak test that issues fsx-style
> read/write requests through io_uring and calls fallocate() directly in
> between.  A pending io_uring task_work notification can therefore make
> signal_pending() true inside ntfs_attr_fallocate() even though no real
> signal was delivered.
> 
> That caused the previous signal-interruption patch to return -EINTR for
> an io_uring notification, which fsx treats as a fatal failure.  Switch
> both checks to fatal_signal_pending() so only fatal signals interrupt
> the allocation loop.  A real fatal signal still returns -EINTR, and any
> other error still takes precedence.
> 
> Fixes: 4dc8f4ee2d46 ("ntfs: handle signal interruption in fallocate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>   fs/ntfs/attrib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 848a0d338b89..5f761a3b29f4 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5708,7 +5708,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
>   						goto out;
>   				}
>   
> -				if (signal_pending(current))
> +				if (fatal_signal_pending(current))
>   					goto signal_out;
>   
>   				vcn += alloc_cnt;
> @@ -5729,7 +5729,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bo
>   					    try_alloc_cnt, &balloc, false, false);
>   		up_write(&ni->runlist.lock);
>   		mutex_unlock(&ni->mrec_lock);
> -		if (err || signal_pending(current))
> +		if (err || fatal_signal_pending(current))
>   			goto signal_out;
>   
>   		vcn += alloc_cnt;


Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

