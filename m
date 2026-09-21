Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE70493D5A;
	Mon, 21 Sep 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988555; cv=none; b=olX1Fj8+EUaRcpBglbTja6mcF0KXkeqXmeE4ZVqg3hI/JDMQGDpdP7NsystAE9InERlBY95tCmkTDTUPbx73boK896FHN8tKR7oPyc5aShfYrPaGP5kuiCUV3MSxMoRR+p2HPGrRL6gJEUCLpPbcvkGpHPVa7lQMA4/4ZEoxtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988555; c=relaxed/simple;
	bh=nKgTopeDI5AI0Zoqxk3fUwS+P3rKGVqb5RBdi3Tulcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF3kGfOglJ3BiKSsBQ4BwsMLnzsac+QOiVNmNL6Pczd3yqQabmxhGTuZhk99Kg26SzNJegtITq/DrJ+1TKeOrFni75VP4cmJsgtRk0O7wPTARNlUkkZPNnzYCZ68tEQ0ccd+PwK9LYNLg06r3zv5py7qwpxe3pdJNRH6IYtQyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP+ODfKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP+ODfKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FB41F000FF;
	Mon, 21 Sep 2026 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988547;
	bh=47h/x4FUrhN21NlSWMG0c5AEjHNi5jOV4AHAME/+muA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IP+ODfKj9pIwpUWaBaQDjLhi+vEuD1vxVnNwMH2NABGAvEuSD7/JNYorHgcjBKrqs
	 R6k8JgxT9sdlVE07z5WEyxdoHB/4JJS3LnqINdzHuM0t5UQZ70NixpvG8dV8hIRhy1
	 bpclhJ8xxNY8JWmQlTYlYbVQg4LLtQurX9UCJVBCoqWDStyi/vpJaZkhgHgmd8fzEp
	 x1U7eoonmS8lzIpwJHwHyJF6PdZqEtISCWPVHy3gChRHBbJjbKfCltNma/hAM4DjfT
	 hzL/hSVKJfqR89nddjerKvsux7fjOVads7sLcNiLM7HCOx+hKZsK/eHoONmDgww8JW
	 1bF/fy+70Z9tg==
Date: Mon, 21 Sep 2026 12:02:23 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	grygorii.strashko@ti.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: cpts: Fix refclk node leak in
 cpts_of_mux_clk_setup()
Message-ID: <20260921110223.GJ13925@horms.kernel.org>
References: <20260917114616.2149617-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917114616.2149617-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:46:16AM +0000, Wentao Liang wrote:
> cpts_of_mux_clk_setup() takes a reference on the "cpts-refclk-mux" child
> node that is only released on the mux_fail error path. When the mux clock
> provider is registered successfully, the reference is leaked.
> of_clk_add_hw_provider() keeps its own reference on the node, so release
> the one taken here before returning.
> 
> Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/ti/cpts.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index 2ba4c8795d60..372cef13d81e 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c
> @@ -714,6 +714,8 @@ static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
>  		goto mux_fail;
>  	}
>  
> +	of_node_put(refclk_np);
> +
>  	return ret;

I believe that of_node_put() should not be added here, but
rather it should be added to cpts_clk_del_provider().

Otherwise, what ensures that the node hasn't been reclaimed
by the time cpts_clk_del_provider() runs?

-- 
pw-bot: changes-requested
