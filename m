Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505621;
	b=2Mw+Q0f5K2trMTL2CbMR6+sEHKcJG0sclWXiCf1s44FIlpEEpphGKlWeDikPL+dIXpvN
	 WLlMctX7nsI301OUmVvhu6oRspXo9jPIa0Dp1gYD/w5yg5grAJX47El3wd5TtunwqKj/z
	 80qYWtEPHpnrrlnPVrV8OqgjVegikt8VgaUjXP9qVgFaC3E44nY4aJhDIAQBPKdUlDju2
	 3nlODk4uKGee4CugRsFxijG84E6bhjlfZqft3pHIQs1AClDVtM2JO8A7PusRFkrtcjzN3
	 B7K0NZWyE9AmVcvcSv1GwSzag5PITCOlgwxLUseqQ/DX6FVkD/d7CyR3LiUwcyS37Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505621;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=gq87rGVVD4KSpSFWL7D6d3e24UEKtH1rPNqBfJ2s+4Q=;
	b=DtVdVKntzDj/NrHtss6A4w1Krrk2zC8u+O6soyDqAJD6O7o94MVHPqwBiIcrlRPFPjhu
	 d4WNlhZNsaAuiXt5DjHtWHB6Z5fe0CWM0MOPCWWvt5pidV4EBL5gOUaW02BVz5dIeQd2a
	 dNDcqSP7gC8HF2HprAXjm8joxNK7ot674vhDL9dHSPHA0yOxW/QS9ig/knxX8F1BoR/L0
	 R3H51piMpPtg+1nw97UughyY/CW2D7pyycAGr5pDBSJy7A+GzB/yM2g4XsR3prXUjTsrz
	 marFMo3sZhEyVZAZ3UsaH2w2Vh8+0+pWiZe9dOIh8vA1whlLBHuW84Au6SOvf/2CLNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IReWqivt;
	arc=none smtp.remote-ip=113.46.200.225
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E0606A31E;
	Tue, 24 Nov 2026 07:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IReWqivt
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gq87rGVVD4KSpSFWL7D6d3e24UEKtH1rPNqBfJ2s+4Q=;
	b=IReWqivtOsblcN+tXM/8b+ODJiGrLJge40Zj53rVyoXBu732GcajweLdUfVu6XElEMAIEa6T0
	bzq4GYAmSbeufVRem9hKBtjgD0jbcvXBmmHP/3k8UCuSRd8FCfqDrG2jwrACcWUkH7QgVUFHMGI
	/FsvAk2OGug5dfXjXNqerA8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4jYZKj4QBmz1K96m;
	Tue, 24 Nov 2026 15:33:13 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id E704C4056C;
	Tue, 24 Nov 2026 15:33:30 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 24 Nov
 2026 15:33:30 +0800
Message-ID: <5e4d8f95-ae3f-4143-a90e-c3ef51127230@huawei.com>
Date: Tue, 24 Nov 2026 15:33:29 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resctrl: mpam: Fix potential per-CPU data leak on probe
 failure
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>, James Morse
	<james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261120173519.3923924-1-liguangshuo@mail.sdu.edu.cn>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20261120173519.3923924-1-liguangshuo@mail.sdu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/11/21 1:35, Guangshuo Li 写道:
> The PPI device IDs are allocated separately from the MSC. If subsequent
> resource discovery fails, probe destroys the MSC without freeing its
> per-CPU allocation.
> 
> Use devm_alloc_percpu() so the device releases the allocation when probe
> fails. Its cleanup remains valid even if the MSC is freed beforehand.
> 
> This issue was found by our static analysis tool under development.

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

> 
> Fixes: 49aa621c4dca ("arm_mpam: Register and enable IRQs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
>  drivers/resctrl/mpam_devices.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index c067b6d57d71..3e89f9183041 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2351,7 +2351,7 @@ static int __setup_ppi(struct mpam_msc *msc)
>  {
>  	int cpu;
>  
> -	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
> +	msc->error_dev_id = devm_alloc_percpu(&msc->pdev->dev, struct mpam_msc *);
>  	if (!msc->error_dev_id)
>  		return -ENOMEM;
>  
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

