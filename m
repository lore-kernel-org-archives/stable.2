Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E68E4EBAC9;
	Wed, 16 Sep 2026 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554805; cv=none; b=keX5lH4pAISW4KBG7heiyzVOrgi8eRTl06YNDnfkkviYqv2Qur5aDJlOtHqHan9gAGZc9zXnMqydb9yCY1JB0TBzQsfSClvgROAFBUtyzMy/cZu62JO6aZmp3LKAQhxpZ9Tco4SmF+VhwaSF23So6ilz7Mc4m5WpxHhFsUUYnZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554805; c=relaxed/simple;
	bh=DogrESP0WA2kwDRW9adsT0RXC7hZ1Xx0WDPasFz7gaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFTInrICcqhDqPw1Azo6FaM3g5k+Vo6issIAuSjU/x0P8DeIBn7iTIhXlE+zBQX+LluYvr7Fpwx7ZOeFw0mZR8gKMYoRZb5TNTtJcxco5p9thnbAnxxLAs1D35xFLUlyXxjCye/jVLhZqm/8OpwU+txBNA1EtwGOjQ3l2z7M6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tbywcfMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tbywcfMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268951F00898;
	Wed, 16 Sep 2026 10:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789554771;
	bh=08PC1Zy0osrxD5uEEq52omja9Cyu6/fzLf/OJPTukEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tbywcfMnjR9YbGgjGoowoWtoypFwkV04/m0T075x2cdlw9JNqAq64HWPaf0Ohm/MZ
	 luOknS14HacrIaIWw5qRZgHVabt0VQBt+nhPjnhMa3JT15e5lbIKna3i7eHjypHE9p
	 3oCBhYdbi4A7ucwJ2UOq7epdMiLyPmYfllsvdQyk=
Date: Wed, 16 Sep 2026 10:44:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alistair@popple.id.au, andrew@codeconstruct.com.au,
	eajames@linux.ibm.com, joel@jms.id.au,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	ninad@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] fsi: master-aspeed: Fix of_node reference leak in
 fsi_master_aspeed_probe()
Message-ID: <2026091644-equipment-landlady-c1c0@gregkh>
References: <20260916093914.2005582-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916093914.2005582-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 09:39:14AM +0000, Wentao Liang wrote:
> In fsi_master_aspeed_probe(), a reference to the device tree node is
> taken with of_node_get() and stored in master.dev.of_node.  If
> fsi_master_register() fails, the error path frees the master without
> putting that reference, leaking it.
> 
> Put the device node reference before returning on the error path.
> of_node_put() tolerates a NULL node, so the earlier err_release path
> via opb_readl() is unaffected.
> 
> Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/fsi/fsi-master-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
> index aa1380cdff33..7c7f30c2b8e6 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -640,6 +640,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_release:
> +	of_node_put(aspeed->master.dev.of_node);
>  	clk_disable_unprepare(aspeed->clk);
>  err_free_aspeed:
>  	kfree(aspeed);
> -- 
> 2.34.1
> 
> 

did you forget an Assisted-by: tag?
