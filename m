Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870348EBE8;
	Tue, 15 Sep 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462257; cv=none; b=dGse1sCR8vbCKb/ng0AphAsse0fufDY2Zij9XtLWXDaB9aA3KcvHD9hK4QtpgE1n11oTInucokappookeuNRb04FYbp19AcaHOka62ayGqwl20v0p0wF9IgYMnxgNN/ay6DSWc3zfuvQnWgjM8SOkBCgv8qA0HpHCvrVjlyUwA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462257; c=relaxed/simple;
	bh=+UddRaKfdPLpZemHcLnvLEu/UoE3vLbztsJrXCqkNKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCLzBwOmrPpITQdGZdNzzbgvNUc2cUgtYGs30P93OJ7YhDAlUlURNOf4dAJAjLMOLSHZqiyBtQpcqpj9q9tgqxR12z91HCzYQVoafdd9UKzIZQDEulmwbNLXXy3YY+4Ieto1HmH2FUYNBek/i/2MDHIH8edWtPQU/TLCtyOUuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/KxsUTY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/KxsUTY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49F51F000FF;
	Tue, 15 Sep 2026 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789462255;
	bh=1jPFi2lVcMWz3e2hk3E7/egt63of8YGWwsrqy1MR89w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d/KxsUTYlvTPMklQJzpKpL1oovi8+JPAiso+ktI9INYlanwTe4sewrIgu4AvNnxmS
	 4l4KAA6lCNBq5J1p8N6E7p2MCxyKiLCIMpugFXRuXjtKip8pNgsqKJS+U/xvOkACH0
	 /hZSmavKIn3VaP6G6Ros1qjYN2u30eqn9IOj4qxTk3LHznwbSQBmmjN+jBUmXfdBd/
	 R9DGTSkLO63d5afPNjYU0b5FbTslndYN7/fe2PQ5t15/4hJwabV/D5/H0Zey5Y85x1
	 ujZG+w6SiVksoNUK0YX2ZzHf9FlnvbJGu6cKdpWBCdWqDBLNQCCXPgJDFePJKB4c4E
	 0ArGUT+nq6Cuw==
Message-ID: <e5245a11-d6a0-42d8-a6ef-1b5ca9622413@kernel.org>
Date: Tue, 15 Sep 2026 15:50:50 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] ata: sata_fsl: Fix use-after-free of host_priv on
 probe() failure
To: Niklas Cassel <cassel@kernel.org>, Baokun Li <libaokun1@huawei.com>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>, stable@vger.kernel.org,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>, linux-ide@vger.kernel.org
References: <20260915084127.692494-8-cassel@kernel.org>
 <20260915084127.692494-11-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260915084127.692494-11-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/15 15:41, Niklas Cassel wrote:
> sata_fsl_host_stop() releases hcr_base and host_priv:
> 
> 	static void sata_fsl_host_stop(struct ata_host *host)
> 	{
> 		struct sata_fsl_host_priv *host_priv = host->private_data;
> 
> 		iounmap(host_priv->hcr_base);
> 		kfree(host_priv);
> 	}
> 
> ->host_stop() is called by the driver core through the ata_host_stop()
> devres action which ata_host_start() registers, so it is called both when
> the device is unbound and when probe() fails after the host has been
> started.
> 
> The error_exit_with_cleanup label of sata_fsl_probe() releases hcr_base
> and host_priv as well, and it is reachable from the two
> device_create_file() calls which are done after the host has been
> activated. In that case sata_fsl_host_stop() runs on an already freed
> host_priv, resulting in a use-after-free and a double iounmap()/kfree().
> 
> Add a separate error label for the failures happening after the host has
> been activated, which only detaches the host and leaves hcr_base and
> host_priv to sata_fsl_host_stop().
> 
> Note that ata_host_detach() is dropped from error_exit_with_cleanup, as
> that label is now only reachable while host is still NULL.
> 
> Fixes: 6c8ad7e8cf29 ("sata_fsl: fix UAF in sata_fsl_port_stop when rmmod sata_fsl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below that is worth fixing I think.

> +	/*
> +	 * Once the host has been activated, hcr_base and host_priv are
> +	 * released by sata_fsl_host_stop(), which is called by the driver core
> +	 * through the ata_host_stop() devres action registered by
> +	 * ata_host_start(). Releasing them here as well would result in a
> +	 * double iounmap() and a use-after-free.
> +	 */
> +error_exit_detach:

The label should really go above the comment block to clearly show this is the
explanation for what is done in this label block.

> +	ata_host_detach(host);
>  
> -	if (host)
> -		ata_host_detach(host);
> +	return retval;
>  
> +error_exit_with_cleanup:
>  	if (hcr_base)
>  		iounmap(hcr_base);
>  	kfree(host_priv);


-- 
Damien Le Moal
Western Digital Research
