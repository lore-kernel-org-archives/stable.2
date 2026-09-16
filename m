Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E71369D47;
	Wed, 16 Sep 2026 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524700; cv=none; b=gE9Y1gt9xJE8pUEG3GpcVik2bEodut+72v/kIT8aGtBgXK3Rhpz/XlD/Vci+NxYv+kXrtnc+1DpgQqnHpvGf1cViEFEgoGgyc986NRRgTt9FkOC4ix0mFcsAU7ATUapGNjz8JL/A3UplXoXoj6SrqdNhrCm1d4Kx5svhCN+sJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524700; c=relaxed/simple;
	bh=kJxvNV0VzrSP9SI0pUhIlADwSp5zijLN4k8DEcv3+zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMCxUM66Nge8lwF1Z2QFNuCp+RqsAHZvJNL1RFsmwjwU1GQ9JTJx2vYG4JUNw7cIY09rQF5JTuUtLT3UhiDh+So1HS+NkSkLs6m5gGKHJE05P4jumTghKCH+/8wsLq9vhwSxn4nMG3dM42FA24KFpiQvZMrZ9jOUF0yxpVIh87U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adLRkThp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adLRkThp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F87F1F000FF;
	Wed, 16 Sep 2026 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789524687;
	bh=DXnUZSn61GCHwmdvY9XvoBKv12WCQ87rHGg3qKqyVPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=adLRkThpUSfYWuyg8gQFMMbCXk7MRhRLq2wV4+O09r/xCBwGtu03a+TiAHoDib69D
	 PrtjxyUaukcbQzgQNN/YXaUfg+3gRYirPVnClDDG1jxmRrbB68i5leX8LwcvslMGq4
	 mimR4UWUNSzhBZm2o9/Wl0uvJdLjHIYD66fa1dWngUT21PYC48qJYct2abHKDUnLxL
	 nQbizR0fw6lEWnG3SqkpMKSWXzOpKd1q+tOi5DFe4QBsU/GiOOo9xY1EKscdAdKent
	 bXQ6YA5qqGMmeU9ZfWwLq8uSdBru5Z8t8glA23B2jLVRdPmZwNjRzArp94NWJpDTkk
	 PdPb3HgXCr1uQ==
Message-ID: <9fbef6c3-b56b-486a-848e-5926bf5e67dc@kernel.org>
Date: Wed, 16 Sep 2026 09:11:23 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci_platform: Fix device reference leak in
 ahci_platform_get_resources()
To: Wentao Liang <vulab@iscas.ac.cn>, cassel@kernel.org
Cc: gregory.clement@bootlin.com, hansg@kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, tj@kernel.org, stable@vger.kernel.org
References: <20260915065933.1733061-1-vulab@iscas.ac.cn>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260915065933.1733061-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/09/15 13:59, Wentao Liang wrote:
> of_find_device_by_node() takes a reference on the port platform device,
> which is only used to look up its port regulator and is never released,
> neither on success nor on the error paths. Drop the reference with
> put_device() once the regulator has been obtained, which covers both the
> success and error paths.
> 
> Fixes: c7d7ddee7e24 ("ata: libahci: Allow using multiple regulators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/libahci_platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 6e072d681341..14a47e0bddd4 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -624,6 +624,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>  			if (port_dev) {
>  				rc = ahci_platform_get_regulator(hpriv, port,
>  								&port_dev->dev);
> +				put_device(&port_dev->dev);

Looks good. But while at it, please remove the blank line between the call to
of_find_device_by_node() and the if.

With that done,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


>  				if (rc == -EPROBE_DEFER)
>  					goto err_out;
>  			}


-- 
Damien Le Moal
Western Digital Research
