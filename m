Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816498;
	b=1+a8LfoBpOl0k/c+ToJjBoQ9EWbSwO7dyIG76dy2gzdyMLZ9GBQV7rBAFKp/i+9YzrVc
	 WTeULHuZUwrc/b6/1BNGeeU8rYijV304To2fmfkJ0TuwQlQ8E97vBH6vvqaMZfH8fivlH
	 3TJOf5mraHMk6BWbCcl4nbHRoJXql0krBtUTJPdIFi7Cmk9S4SgrnxHhzKWX6xVdZDuRE
	 EUaHpOLFGYUxLBS/XKVQyvvdOwjetRTKbKIjc2YGlj7uxPPUuLaCr+1evkgOFZdNBx0rK
	 LXG5IFWfhOZVxoZQxZLFLH2Ebw432RfvpTdTKqaQSX2D1X6qTWjqc58NGL37gmGOCkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816498;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=YU0/bMzoGsM8ll5tTytIdLYRXFVMmJmY3T1q6ioU1dM=;
	b=ditkdsr4VXSLHl0QUCgNdUQBIVHa1L9HAalEbgYUXLxCMRJgbSZJ+YDh7f2ETuMqtzNa
	 rgLFOwpfE1EKySE/RNcBT7TWts4HqtC2fEezPxqoTfKZuUnCOVruM48+Cu73mf+QIq7oP
	 b7KZWmK/ziZOn4v1Gfxd+STNQkfSpJMP4hNaXAbNLC9mXq1W9+JiYUMHF3g3mAbGWbTlM
	 NI0v7mqSpKqViN99OMtQRVmrvdo+MvTR9WBvFYPbFnxGh5lm8XenjM8k09FLwfu4jIyz5
	 ls+ahn9wXlgIR+j6blgHfalHKymZdvxyhg6gAeb1+dWxCeIAOtXn9JVGrZIsjSMtz9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Sm+m2Okr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AB606A33D;
	Mon, 16 Nov 2026 08:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 953AB606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Sm+m2Okr
ARC-Seal: i=1; a=rsa-sha256; t=1794816492; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gpfs8oO8l2d7LpuKNysklBOjM/O0epbisY9HwYFbnTeT9JvAgk51Yo00TJfi6KMyfNhYtAXwbDck4/aTu7/K+mZMNR6h15rwJGa6ZqagmhANXyDbb/XHdyXPR3lenjL4zPkyg7EiXy7kq1ok9FXOvUQhzfDWmhl/pRTrFsxUR/0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794816492; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YU0/bMzoGsM8ll5tTytIdLYRXFVMmJmY3T1q6ioU1dM=; 
	b=NfyZW3RmGNGkV74X0G2Lgvu2Rk4Ayxr6Y+vZXUeZ+C6TAGf8oecULks643zEo4bbcm+HGaYeEjwWNvP3ONX+S0Y06n4I4+I2tI30t2B9Z+dOZssWaVg0RghpyXVwNK7m111Ti2q1G+TfBBRTIhzhLNBSXfIKnBfEyurEWqxWFqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Sm+m2OkrOZd1Y2KaEX+2DoSYm60XtZxEoYNw4QGb7K62ILV7Pd6lDQNXnFSzSXydaAJhDjq3A2aNz8ouXEUlNqfkgZJji033lQD65GEhVd8+A6qjmWwOZ1l/M5RwtBAen6Mg2s7Z2Dtbf7r+8XKa2Lt5J14sRlvAaKN9YHP6dxg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=YU0/bMzoGsM8ll5tTytIdLYRXFVMmJmY3T1q6ioU1dM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794816491501291.52979348085535;
	Mon, 16 Nov 2026 00:08:11 -0800 (PST)
Message-ID: <c8ef7666-41fc-4979-86be-aa60eb8c5554@collabora.com>
Date: Mon, 16 Nov 2026 09:08:08 +0100
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
Subject: Re: [PATCH 2/3] iommu/vsi: Unlink the IOMMU from its old domain under
 that domain's lock
To: aiyengar1990@gmail.com, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
 <20261114-iommu-vsi-fixes-v1-2-1fc7728dfd35@gmail.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20261114-iommu-vsi-fixes-v1-2-1fc7728dfd35@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 14/11/2026 à 01:14, Arun Iyengar via B4 Relay a écrit :
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> Attaching a paging domain moves iommu->node to the new domain's list
> holding only the new domain's lock. A concurrent map or unmap on the old
> domain walks the old list in vsi_iommu_flush_tlb() and can follow the
> moved node into the new list.
>
> Unlink the IOMMU under the old domain's lock first.
>
> Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-206639@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/iommu/vsi-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 5156e8a2e7fc..8a0f253f2017 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -575,12 +575,13 @@ static int vsi_iommu_attach_device(struct iommu_domain *domain,
>   	if (ret < 0)
>   		return ret;
>   
> +	vsi_iommu_list_del(iommu);
> +
>   	spin_lock_irqsave(&vsi_domain->lock, flags);
>   	spin_lock(&iommu->lock);
>   
>   	vsi_iommu_enable(iommu, domain);
>   
> -	list_del_init(&iommu->node);
>   	list_add_tail(&iommu->node, &vsi_domain->iommus);
>   
>   	iommu->domain = domain;
>
