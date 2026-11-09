Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235712;
	b=0ldSrcWNixVw5IFWf5/iNJoKoaQKDmOPf6CGMt3xG9jO8foRs/T+uQbpdvhI+EzhcqrY
	 unyRUxB/bMyTmKaHdi658mTie2f1P1ISlb97Nm3fsbJlOLmhjW+FTgjVhnyMBWEetWH9i
	 98yEM65Maa8HfUjFlpxs2dUdxxmvVTdyTkCFMw2ErzUtI0aOSoMiLw7Fb1WMJCgaiTAoU
	 5v7i/PiRBWfua63qAD6AOzyFipGQuqv5CXZyTOSq1wKVdbFEdSbiC3b5YVjvHkvwqRsuH
	 Z2Kh3JksJg0wDAYLBsH7KbiaI3YUTAWyzDhyDw4OHtuEsPWQg91WtOZHBBEZcg2S75w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=M7mjVSswzFiYPoD6QT1qC2YywjNa1eCvKgF70U0xhrg=;
	b=UPm6NKNKRytUCVo/pA4KgfmqXnUnX37WxDoKZ+zgsZHOw8pzxqeADzHnCqDmZoS5TanI
	 blDGoqgOplyt5zyrOQgwnSulJfm5VnSpNCAVBJ0KK/oc+eVzStgLUTNGBQiVyM6aTdvJh
	 F1ALIa8On9OJ7IKro1P6ect9HaKAL7qSORx41wwI/7IB60OxWWUjzrnjyxygnMo7TS68c
	 DIiwc5bhfNTyiDTTU+RGgi2GkItG5wuxU2Jlzu2r+AlaRgb6brTq6PcIXWYjzknK8+UPX
	 nxkY8TjfOki5rXDwzRFh1Fd/hBnn4LvEAQQzat967N/k8tked/PSYay3yfhY0QFfMaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oNUecxHC;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C84606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 14:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C84606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oNUecxHC
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93f2f2edb19so81988485a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794235710; x=1794840510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M7mjVSswzFiYPoD6QT1qC2YywjNa1eCvKgF70U0xhrg=;
        b=oNUecxHC4848KNAA26lHQ2G+BYpWGFvGSyUdQl59xdkTLL68nrj101K5yWsvlahxtJ
         NjIy7n4cPKvogrm33G94/yLTrcNabAnbH9oaO9/fqlPdqMhETQ2ody+fek6SSMiHM7lK
         1DB/dDCxqHNrel53IXnnPdTTAasHGJTssEOZ+Ca0HANmvndcE7KPej/d1lzOUgobuQGh
         U3BAlPeubxLio1DWsA623BiUEwqpep+ErKLxc2x4bBU8vHIhgqvUYPLdowJ7w6+mEe2z
         HPHXw8Gvah2ZH/r1bnklT6b2NoK+Vi3kDWqd3gtj/SvPFzgaYABt+HWB3Wqw26RfkEqh
         rcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235710; x=1794840510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7mjVSswzFiYPoD6QT1qC2YywjNa1eCvKgF70U0xhrg=;
        b=sjYnOl1CmwnOLY/LBjFwRsIyxP/lKWyJF3bNnMstTyib7eYZ6nW1eTIrGIcub0Bq+k
         BHF3z11Ut8wUu3Ch4caY3pYVOnlyrByRTja13g5yeBexPLS8cVUrm9FdwjiP31WVTUj0
         1aAqdJlcV85z/de8aIZl94aNpfhb1BC9N77STz4UH+eVLIYXmlxZgdvshmaZv01Y5JQU
         rwlBTi4+1jn9P169ObopiohFvdhpiPbPnKylWiyYPzq382QPp3Fxu+qXicJJ+AaNkgIH
         qgISkAMLSjE3Rnr13UuT3yC/Nzrkwqlm3BI3A1PnepjK2vmpP/syzCeZ/Id9x8woJ3nF
         z20Q==
X-Forwarded-Encrypted: i=1; AL+hErFhihqWxOnaz7WBVnvJYHI3Ow6xzRwPhSFTlqm9payy+nW9BmAhp3WZkYT/y4DfcsueVLxtk9w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aFK5CvEsAIve+jFmqdAulp3sQ1ZbtU8ey6iIkeGog7oNhLfAn
	5O6dHA/Ha89sGisr3ui4jmLABKh6JV5b9QQJKUVOLhKx2a5Mf+Zp6GGcC//JADGfADQ=
X-Gm-Gg: AYBFou1rO7ZdEh09Qbt8l8apKIsLOCSRhvj6P8njmgj+PbBJkYGZQ/0ggR8JPtJ3+t3
	Nft28dyRh0nDQ9vP9IdvWYxMYdDZ2o7XYvZpDyDZJVlJkXFikhySPT3qqAA6BRUScDiebuh0C6/
	qOcebOl1q5+Gvo2sumyhwGdKP517ZNF27bU0T0Lx4ZY9Gpj8BFQwxP7jLWRHnTfgbwKM5bZ52BX
	QLu6jWHoDWTk42wdGPqzZdhG+xWqaDcDf8dhpIUFbn4BL/oT9Z7tJWYbAfHhb9niXsZXcGcfFpi
	BjhP+7e/LGTKA5ygBSrH4lHa77FIcduDxUn/rjGbhHBUKPt0+yZOEDKziMRlLSh7+jPFqrqHoHV
	9E1VngVEL+QqfRWClGFt3yWK7CP99tNYd6fCn87UFva6gupiqs3NLnaufVcNfCqwFrKEdsfZo40
	DklyEX9kardnc8DtdgG5+NP/swN9vANLw/hXhlS6WkN4l/UGnuEsL4PyyRVYrZWox5vNzn7EA51
	83qpe95Al/VG+UB5RSNYzmOj1bSEssoGrdojuhZvRrp//1bkXsitXj2KdRtGkksLIVFDxF05zOw
	E7pD03ltDJX8eK1+ZnMvKzUiz3lIUhS6rBsRBIYPU7tG0RSU5gUpa0J1e+Mbf184XOCcJksCE8S
	E/nvGwctlOA==
X-Received: by 2002:a05:620a:28d6:b0:947:1d0a:c89c with SMTP id af79cd13be357-947848d1cfamr570972285a.56.1794235710297;
        Mon, 09 Nov 2026 06:48:30 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceea05a2sm43886796d6.39.2026.11.09.06.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:48:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQQfd-00000001QiU-0CrP;
	Mon, 09 Nov 2026 10:48:29 -0400
Date: Mon, 9 Nov 2026 10:48:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
	Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Uri Dar <udar@nvidia.com>,
	stable@vger.kernel.org, Michael Gur <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx5: Fix DEVX UMEM mailbox size
 truncation
Message-ID: <20261109144829.GM663069@ziepe.ca>
References: <20261109-devx-umem-mailbox-overflow-v1-0-4a63baab25dc@nvidia.com>
 <20261109-devx-umem-mailbox-overflow-v1-1-4a63baab25dc@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-devx-umem-mailbox-overflow-v1-1-4a63baab25dc@nvidia.com>

On Mon, Nov 09, 2026 at 04:42:32PM +0200, Edward Srouji wrote:
> From: Uri Dar <udar@nvidia.com>
> 
> devx_umem_reg_cmd_alloc() stores the CREATE_UMEM mailbox size, a header
> plus 8 bytes per MTT, in the u32 cmd->inlen. The number of MTTs is
> derived from the user-supplied length and pgsz_bitmap, so a UMEM of about
> 2TB registered with 4KB pages wraps the size, the mailbox is
> under-allocated and mlx5_ib_populate_pas() writes past its end.
> 
> Store the size in an int, the in_size type of mlx5_cmd_exec(), where a
> larger value would turn negative, and compute it with overflow checks so
> a UMEM whose mailbox does not fit is rejected.
> 
> Mailbox sizes within 512 bytes of INT_MAX still overflow the block count
> in mlx5_calc_cmd_blocks(), but the command then fails with -ENOMEM
> before reaching firmware. This predates the change.
> 
> Fixes: aeae94579caf ("IB/mlx5: Add DEVX support for memory registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Uri Dar <udar@nvidia.com>
> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index fc6f793dcc6584e6a22b40c57e2df8f24579eb14..1da6c0e440d6e19d8791b012a148f479cfdddad7 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -113,7 +113,7 @@ struct devx_umem {
>  
>  struct devx_umem_reg_cmd {
>  	void				*in;
> -	u32				inlen;
> +	int				inlen;

Do not change things which must be unsigned into signed values.

Jason
