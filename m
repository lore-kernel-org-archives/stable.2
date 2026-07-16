Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B937E5F6;
	Thu, 16 Jul 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238638; cv=none; b=Vu7biPieJLy+gj68a+XYivCXnlr3ufDp7Ex33xXGHrIYyKLjKhadwYRvaIgLJ7f9yUTx2D4rfAS5MvrBMkV0UHYP/u8eDknNHMRdDjLrgK9TpMVLbbzj1NFfNPZZqsmaifoXiOvzPHCnn/A3vcMVq5wWXo7rZm9OkJwPO6JTdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238638; c=relaxed/simple;
	bh=V2Vr7s5c/DktYXLwFcpnq4Xzb0Lv1MO3jn1dqzr24CU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovz9RmHlaLKNZOLmIn8UG4YrjkDIo/3WrnWO1TmQvezbZZLFgzm3+lLxMYZne4aLfbmizZq1QRZsZMsccX2BL1Gp3iQiVDxDv/HpAf+s2HHeKYrDv81MWX+kJKukAgovEsLBbFe9p3YLPaaXmeR4kn/GX1WQYdQ99nxO51OTGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6Jjh3s/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6Jjh3s/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794861F000E9;
	Thu, 16 Jul 2026 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238637;
	bh=On59Ed+6z5FwuPewVYmVjD+eEBTPHmsepnmu8ecs534=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h6Jjh3s/LxycVmB2yN0V6QXNkHXJ+bEXH2VPxBUoyZgIz1q1YyaAdZIQAUivqyao0
	 +beNYCJs4iWLjr2o+4Iuk7mOMWGkTtuluBTalQeDAmxgROAO/1UrUI/HyADf7NgwbP
	 xYaP0/9pUXhOMNbAFWe0SIXKIB/dNCekHLLZW4IXAp+GOEQtCgMYzcQJKh3qIV7TH5
	 bnSXbWsJKeNW6ISqKom6T7bE752N9nyjlWciWunTL1C/3T+eW9xcf6RBj/7ofEbBf1
	 Z6SDJ8GWqcs3zSCkSRApnXGeftYnhXOLy0XZB/NaP3I3Qd1m2ADIOGU8WUOFtCm6gS
	 TDf0pP1oWU+9Q==
Message-ID: <082227b8-7df9-4d0e-8ec9-c0e3cb751a78@kernel.org>
Date: Thu, 16 Jul 2026 22:50:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: brcm_nvram: validate cached NVRAM length
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, srini@kernel.org
Cc: rafal@milecki.pl, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260715084504.43774-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260715084504.43774-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 9:45 AM, Pengpeng Hou wrote:
> The cached-content conversion stops at the partition padding.  Therefore,
> data_len may be smaller than nvmem_size.  brcm_nvram_parse() checks
> header->len against nvmem_size, then passes that length to
> brcm_nvram_add_cells(), which temporarily writes data[len - 1] and parses
> NUL-separated entries.
> 
> A corrupted header can declare a length that fits the MMIO resource but
> exceeds the cached allocation.  Also reject a cached object that is too
> small for the header, and reject declared lengths shorter than the header.
> 
> Validate the declaration against data_len, which bounds the parsed object.
> 
> Fixes: 1e37bf84afac ("nvmem: brcm_nvram: store a copy of NVRAM content")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

There are already few patches on the list which are doing pretty much
same changes, i have applied them which should appear in linux-next in a
day.

https://lkml.org/lkml/2026/7/3/2291

--srini
> ---
>  drivers/nvmem/brcm_nvram.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/brcm_nvram.c b/drivers/nvmem/brcm_nvram.c
> index aaa6537798bf..4701772cfa47 100644
> --- a/drivers/nvmem/brcm_nvram.c
> +++ b/drivers/nvmem/brcm_nvram.c
> @@ -181,15 +181,21 @@ static int brcm_nvram_parse(struct brcm_nvram *priv)
>  	size_t len;
>  	int err;
>  
> +	if (priv->data_len < sizeof(*header)) {
> +		dev_err(dev, "NVRAM content (%zu) is smaller than header (%zu)\n",
> +			priv->data_len, sizeof(*header));
> +		return -EINVAL;
> +	}
> +
>  	if (memcmp(header->magic, NVRAM_MAGIC, 4)) {
>  		dev_err(dev, "Invalid NVRAM magic\n");
>  		return -EINVAL;
>  	}
>  
>  	len = le32_to_cpu(header->len);
> -	if (len > priv->nvmem_size) {
> -		dev_err(dev, "NVRAM length (%zd) exceeds mapped size (%zd)\n", len,
> -			priv->nvmem_size);
> +	if (len < sizeof(*header) || len > priv->data_len) {
> +		dev_err(dev, "NVRAM length (%zu) is outside cached content (%zu)\n",
> +			len, priv->data_len);
>  		return -EINVAL;
>  	}
>  

