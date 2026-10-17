Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08C37C931
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203593; cv=none; b=RWTd2PC89jRVjgporB/quIJZ/f9ySyFFEnY6/v+Pcmss9+96OaaxrsSQN20sfVbdJ4yAJOwVxxPSex2Y4htfTlAST/ut2PMWrWhg8RZsTUrNYsz+H47Pxrcn8A5gOM/SqyleJnOxiT0i376cqCefQIquV5mKkwz/O+Ubj55pCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203593; c=relaxed/simple;
	bh=5rRTjvVUCj1giTYCsBQ/YKcd/9d9HjEXgG9juU7sMfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qP6NAoBLrS61JlYilkb+azzdAFgYL2WPfCVqymj+iKracBDOjXKkXxbHAycwZhGaLfHbVhXscp5iAUob/tPLvBgX0CZBm6e8q/CdW1VU7ECHXWpN/K1LHyarb4AGwDwxO+JotpvM0FDJhmhjuGm4RhEjVnXxfPK0igVHKJtWNPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZNiQ2vr; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZNiQ2vr"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-157fe9d771bso136744c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792203591; x=1792808391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+kfzjr8MQEb3lKi5cTeDPkUvBSdgUV4zlTId0CwE3M=;
        b=qZNiQ2vrR8t1p1kDECcMcJ+4tgxT0xHqGWGnIkvfdJnmRdStPCy2f30zRNJhI6hpQn
         tVrB7pmcocSx6V8z0p2FgOWpDE+EhdzDOFlxZpESRsr6+4S5hIASg1BM70lbfvmW8S3G
         tX92JFpLaVwIwvIKBKMrF9jI5FO4kRhPAhCk7pgDe/Y4uSA33l1ulwF3qGtzwVVBux6G
         P2LcuWNFUIAaFJAis5qWu1OeyQ8cLWicwDfBCafuD4FljTEAujvXtbE/7kqkGnuIAzXu
         KAaZDWw+cZvBSMnayWw9ANvrZrPR6a30wVyClUXyohfyyDQ3jLl4oGzloS4scNhMVbgT
         QNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792203591; x=1792808391;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+kfzjr8MQEb3lKi5cTeDPkUvBSdgUV4zlTId0CwE3M=;
        b=uziqJdCqqC0deCuhmAkU37dAD7xViYCVxV+95qF1fjGlnAP8umEkMQ9je7KR7oLBWO
         na7VVt9f/p0FEoKyAYuc+63E6PvpIK9wJQEaTnXNqy3an1mtFKwHtmDBXcZzt/iGS8Z2
         r2s0FxyqPO+Elt55sFBiBlYOmUWMYod/4Q4/zwD1NYjDX0tAfDHOSIRlvSZijyi7Frc3
         kD3moCWZTEy+xClFApyithrTwkSwUbQjaNBqRFdMqaWnG9PioR7qvZVbevAN7KRC0CF+
         ridrfGpdIYsaeOPkFvKgbb+KlKpEd1EeIdBpnQsp+wbbm1tLWWmaLYVtEvhgCkR8VukP
         5G2Q==
X-Forwarded-Encrypted: i=1; AKwUvByHgd/NbNGELE1AL404TNh9zVW7c28afYQAz3vAQaM4zQF8w4RYCeGdlhPsQo/S03wdWs0oeEw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUkc+JxYl9PzEpxli3a3vsidpBt9Ev8jq+mlLDx+8GP+hyLiLI
	x0idM4mEuLXKRFBFkGpygfL4QnStzd8OPg0Orgoz7yTU4aWs+pBaYH12
X-Gm-Gg: AYBFou3PDKpTh1MMUUEo5Lk+KEg8w1SPQg1GE30kHLaTM/DQuislUybi7y6YbmRDS6v
	u2OpBd77L2PONFlV8Xr26Jh2WZLg7w8F/l4Is3Ic7KRmo+qUKif6oaXU4ToY/gzmDZ66AhQB+Y2
	5rYGqhMs59I/U8zyeE6c8ayIevc1XmcyRmMVBeHgd54GBaFid+RzlfY+FHm+IEZuUB+rYcsAoEV
	QrHUK+V7NpYmrV659f7dlAOTeFJW1mW2LC0RH3JqA38DXWw3tAD5Nda+prXdSEwWifINuxbOB6q
	wihhE4tFSoPuIwSzFrYe7nQpLQZwn8AuhFjGC3T6vpWau2shgI+BxdBclXt8RNrl4Q2XhhpVznm
	Jrzr/WqgRRYVipvFol+7o9EpogQoKCTsDCTy8ne9I/qckAl4U33qEg9eDTRtUqJJl1jwhVpWNvp
	mOfF2+aB+IR7GSU6h3rcctmk2gmwwVM83K8ZSWfSxsayOZgfsrfvYH/FKIujb8MmwJMeMFjY4bp
	dGY9THUmGoGXiF7Q1g=
X-Received: by 2002:a05:7023:a47:10b0:14c:fb3f:bedb with SMTP id a92af1059eb24-185136cad08mr2162857c88.18.1792203591050;
        Fri, 16 Oct 2026 19:19:51 -0700 (PDT)
Received: from [100.125.248.95] ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm9100489c88.5.2026.10.16.19.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 19:19:50 -0700 (PDT)
Message-ID: <743d1d96-40f9-4dac-839f-5d5269364b50@gmail.com>
Date: Sat, 17 Oct 2026 10:19:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix folio reference leak in
 mpage_submit_partial_folio()
To: guolingxing <guolingxing@tju.edu.cn>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jan Kara <jack@suse.cz>, Baokun Li <libaokun@linux.alibaba.com>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ritesh Harjani
 <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261016142524.655789-1-guolingxing@tju.edu.cn>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <20261016142524.655789-1-guolingxing@tju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2026 10:25 PM, guolingxing wrote:
> mpage_submit_partial_folio() obtains a folio reference with
> filemap_get_folio(). If the subsequent position check fails, it
> returns -EINVAL without dropping that reference.
> 
> Call folio_put() before returning from this error path. Leave the
> folio locked so that the caller can invalidate and unlock it through
> mpage_release_unused_pages().
> 
> Fixes: ded2d726a304 ("ext4: fix stale data if it bail out of the extents mapping loop")
> Cc: stable@vger.kernel.org
> Signed-off-by: guolingxing <guolingxing@tju.edu.cn>

Thank you for the fix, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>   fs/ext4/inode.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 26f0f9714f03..7afba6298fa2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2412,8 +2412,14 @@ static int mpage_submit_partial_folio(struct mpage_da_data *mpd)
>   	 */
>   	pos = ((loff_t)mpd->map.m_lblk) << inode->i_blkbits;
>   	if (WARN_ON_ONCE((folio_pos(folio) == pos) ||
> -			 !folio_contains(folio, pos >> PAGE_SHIFT)))
> +			 !folio_contains(folio, pos >> PAGE_SHIFT))) {
> +		/*
> +		 * Leave the folio locked so that the caller can invalidate
> +		 * and unlock it through mpage_release_unused_pages().
> +		 */
> +		folio_put(folio);
>   		return -EINVAL;
> +	}
>   
>   	mpage_submit_folio(mpd, folio);
>   	/*

