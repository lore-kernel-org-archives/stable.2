Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099936;
	b=lGKgSV8MVKAR96U6HTYFF3TxY7oZFlnovkjjgEsOLcZamSav5mChqbTwq2kH3bTNl51X
	 UWCFjpyIVGdZqTlDc+nX6WTQslDyQEN0lrvKSg7Gt7ojcpo+YOA1/pNOXI344NMLqgHIl
	 GhT1/BJu0isCCdBNKvFGcf82eiT+xpF2rwfmY5lhADbjXmWx4jGtfaukEiGf5b4Fn/GVr
	 274I4k2tVf2VBA5lQudUZPKFL/Bs0yO5uC/rLAM+4NxtYZRxODzMbj9DOChgh9djZ7vRm
	 7uh/mpWSW34Rc/Gw63HFAF6d3JGDjNR9FNiNxXAIA+firRNVLvOqYfYju2fJDCnlosA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099936;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=SHLKyJlQ92ycclVRVclHzYt7AhLEu/8J5eYn5vce5kI=;
	b=lqVRwinDfbkDCuDHU9VceNTeVQphH1EMOGwzixxA2EMG8cJnFGS7c5RcZKxqnGncyVU8
	 488fH1+fhRodiFwrLAC8xm7rqfR83VK7NQJa4bdwakB0HP8HPtr/QJ1Hu7y66YIwOkV2r
	 F7HccqrViMxEFPvjFsGAL1K/Jz+y5Z4VuxWB8V/Y4dAuI+40zR/kaBWdPp7dh/pSZREqc
	 2Bd0fspYsYTNBY1NB7PnSYKOZ/n0l1SD3IHGoPs+mSUE2GIiKbp+QM6HgUc2YvWau/USV
	 1JKZafY0i9UgFUs9nuJKPanllmdp6qDsVJqpGbjUKH80CvkAnhQ8/amZ/a1zV57cvYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ijmtIpiD;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD274606A31A;
	Tue, 27 Oct 2026 11:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD274606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ijmtIpiD
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SHLKyJlQ92ycclVRVclHzYt7AhLEu/8J5eYn5vce5kI=;
	b=ijmtIpiDqGjAg+LyC4KtjTcqPEfytqF3S8pSW81KfNo/73c6OSQ+umrfumunmcizZaVSKkein
	ECUjBwpEvNk409dyr1Pf309w/eDSEK5rCEr7ZQN1M/CRKF3IG/XxdjH4oafKDdxf33H+PwgWcna
	Vi7kFdG0/jk70YncXV8qvUI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jDSfm0dc8zLlXn;
	Tue, 27 Oct 2026 19:18:40 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id EE4B940578;
	Tue, 27 Oct 2026 19:18:45 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 27 Oct 2026 19:18:44 +0800
Subject: Re: [PATCH] mtd: ubi: nvmem: Fix device_node leak in ubi_nvmem_add()
To: Vishal Satle <vishalsatleit24@gmail.com>, Richard Weinberger
	<richard@nod.at>, Daniel Golle <daniel@makrotopia.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261027091507.130294-1-vishalsatleit24@gmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <67bc8e42-c4e9-bfbd-f451-1ef5b492a084@huawei.com>
Date: Tue, 27 Oct 2026 19:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261027091507.130294-1-vishalsatleit24@gmail.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/10/27 17:15, Vishal Satle Ð´µÀ:
> ubi_nvmem_add() calls of_get_child_by_name() to verify that the UBI
> volume device node contains an "nvmem-layout" subnode.
> of_get_child_by_name() returns a pointer to the child device_node
> with its reference count incremented.
> 
> Because the returned pointer was only evaluated as a boolean condition
> and not retained or put, the reference count of the "nvmem-layout" node
> was leaked whenever an NVMEM-enabled UBI volume was registered.
> 
> Assign the child node to a local variable and release it with
> of_node_put() once existence has been validated.
> 
> Fixes: 34a5d8525b6a ("mtd: ubi: add NVMEM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
> ---
>   drivers/mtd/ubi/nvmem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/drivers/mtd/ubi/nvmem.c b/drivers/mtd/ubi/nvmem.c
> index 2dade9727..15737d511 100644
> --- a/drivers/mtd/ubi/nvmem.c
> +++ b/drivers/mtd/ubi/nvmem.c
> @@ -61,6 +61,7 @@ static int ubi_nvmem_reg_read(void *priv, unsigned int from,
>   static int ubi_nvmem_add(struct ubi_volume_info *vi)
>   {
>   	struct device_node *np = dev_of_node(vi->dev);
> +	struct device_node *layout;
>   	struct nvmem_config config = {};
>   	struct ubi_nvmem *unv;
>   	int ret;
> @@ -68,9 +69,12 @@ static int ubi_nvmem_add(struct ubi_volume_info *vi)
>   	if (!np)
>   		return 0;
>   
> -	if (!of_get_child_by_name(np, "nvmem-layout"))
> +	layout = of_get_child_by_name(np, "nvmem-layout");
> +	if (!layout)
>   		return 0;
>   
> +	of_node_put(layout);
> +
>   	if (WARN_ON_ONCE(vi->usable_leb_size <= 0) ||
>   	    WARN_ON_ONCE(vi->size <= 0))
>   		return -EINVAL;
> 

