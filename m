Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F382199EAD;
	Mon, 14 Sep 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417076; cv=none; b=RIp/SeDz8EI9bIAffufRO6evgFKa6PY+5XJYWFT8JblOCvwdClwR9j81WRZeZ4pzXmT7qi0qpTLynGR46nbFXkn1jbubZy7ZVsGHliNSErUknLMmB4JyaVXCRFdBIZB7dJYEMEgftluSya7//kSu1T8KsowmXSh2gG8rFFsRQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417076; c=relaxed/simple;
	bh=ZNspXXoo+dfPTFPPQyXEBwDtTzS6AnZNJIycwnLE6zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8vvZsxsxnM8LKxu6IJcM1GbYjaVJf3DBcskltP8C/PDdLcgJnI99Te/KdiPkmZUgQpN1miiX3+nIsUYR0BCNeJyP6aifZelpQ3i1yDN9FKUWL2rgzkZfdc37oNnOCm8o9xsT06kRK2jlCbVxHLb5m+yytSnoTxAnnIoUbJaAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b=Onun/M5C; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.b="Onun/M5C"
Received: from [192.168.0.150] (ip5f5af454.dynamic.kabel-deutschland.de [95.90.244.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 423EB4C2C37D66;
	Mon, 14 Sep 2026 22:08:23 +0200 (CEST)
Message-ID: <00e575df-526a-4e1f-87b1-a084ace25f96@molgen.mpg.de>
Date: Mon, 14 Sep 2026 22:08:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] e1000e: roll back registered MSI-X IRQs on failure
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1789416503; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=17omEsBkSdIGbP1denohxoZc3O5NXS7kzLEED9AccTg=; 
	b=Onun/M5C3PXaFeWCaUYqBNJSGYuKCUsKfuSN8hRv3Cm+FjW+t9SeOYKrY0fiaGjmya/w78QMcFQh
	eTMZshh55uLQj9SiheBSpi4MurNPb3hYfCJYFUPy8FPxdvsLcACQ8Er1Cf6XU2AooIOYIpIdXUVHLQ
	yL3WfsTKCC5k/K6WWteEmAHsezm2Hp/HGas5Uvzef4nYWajBNDus1Q6UW/Dova5Ynq/2MItPbLrsT3
	Fiw6JceKiKY9ztRSasI+DstXyKzvBdliep4I0+n6LfK6kvO1lpqRuZOdijNIJbFTsjkAlHOwF/YDX4
	Vw1NgYEd4oY3gnvj9E4sU8ZQhExbEUKg==

Dear Runyu,


Thank you for your patch.

Am 14.09.26 um 16:20 schrieb Runyu Xiao:
> e1000_request_msix() requests the RX, TX, and other-cause interrupt
> handlers sequentially. If a later request_irq() fails, the function
> returns without releasing handlers that were registered earlier. The
> caller then disables MSI-X and falls back to MSI or legacy interrupts,
> leaving those handlers registered against disabled MSI-X vectors.
> 
> Free all handlers registered before the failing request in reverse order
> before returning the error. The failed vector is not freed, and the
> existing fallback path can then disable MSI-X without retaining stale
> handlers.
> 
> A QEMU e1000e test with deterministic failure injection at the third
> request_irq() reproduced a residual IRQ entry and warning on the
> unfixed kernel. The fixed kernel reached the same fallback without the
> residual entry. The injection is deliberate and does not claim that a
> third request_irq() failure occurs spontaneously during normal operation.

Could you please amend the commit message, and give more information how 
to reproduce this exactly, and get the warning?

> Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex

Please add the version.

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..f55aec340342b 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
>   			  netdev);
>   	if (err)
> -		return err;
> +		goto err_irq;
>   	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
>   	    E1000_EITR_82574(vector);
>   	adapter->tx_ring->itr_val = adapter->itr;
> @@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   	err = request_irq(adapter->msix_entries[vector].vector,
>   			  e1000_msix_other, 0, netdev->name, netdev);
>   	if (err)
> -		return err;
> +		goto err_irq;
>   
>   	e1000_configure_msix(adapter);
>   
>   	return 0;
> +
> +err_irq:
> +	while (vector)
> +		free_irq(adapter->msix_entries[--vector].vector, netdev);
> +	return err;
>   }
>   
>   /**

The diff looks good.


Kind regards,

Paul
