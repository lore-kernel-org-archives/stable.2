Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D383C9ED0;
	Mon, 21 Sep 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992686; cv=none; b=XHVJkwSDDGG23uFdNnptOjjXb9ntbo6lZJ7u00zZ+PNILqDmN8eYAoBlkJwHTz2SYo2lX+hYUOI7Dq9rtwuqy5U/7/M/TDvkmHxb6IhpOGOx0Vr9GXu76ZbapmxrxtlKkzdL4RDs3GA5Krf0fITtYwTInE2S1Wq0jukSqOed3F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992686; c=relaxed/simple;
	bh=JnSnm1lDJ01Rj969zxsQOwm25oRkglMxjPcUzNiA6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeaVx44aw0alVoHhPuJBzEW9DPXfeb6d0UgBfumjGdPdskAXmKnSVKl4Xnq4tKOtJJAiJpjOVLaQjxbUqT0LyGQs34B1J49blsBzBUwBhyHKm5RF1r3bqCauIY7rH49gKTLibTbJoe/7ZaWh7HxU6lIP5c/URBAw3nF6FYWhq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvoYvLux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvoYvLux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D541F000FF;
	Mon, 21 Sep 2026 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789992684;
	bh=KyIzPYUauH3Qhtv7ngBSIIeQCucxdX5r54KBJoGH2DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OvoYvLuxrkWMzUmtMrJWdgyuY3V5JYSkgXPFET2ZXCEVwMONVViYf6st9m7LX0DyW
	 SVgOXdYPEbqMpIDFwZr3k0ygfpkjIzGj4d/zIUUHPJNNxjcqA+NZIjK8wH5Ip2mNqU
	 WIfbMlFM9KodAVdmzGQ863kgolIMZYDdBqT9ZbJddwYhv24Tdh/DwASdLwMEhdnrJF
	 FLjfNv/hn9TQZebeShCgOMdzWQY0BbjzZgZW/cAsYFbKElu5niHPDhhkZ0HhXP/lsr
	 NZBuMuqdG/MaxI5RObzlGVOfjW6qyu1jVv2/pSu/a1Cn8BjUjZEr5sc6SKOZ27Rsvz
	 Hv1ogzJE4fqkw==
Date: Mon, 21 Sep 2026 13:11:20 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, treding@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Fix MDIO node leak in stmmac_mdio_setup()
Message-ID: <20260921121120.GK13925@horms.kernel.org>
References: <20260917113945.2149361-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917113945.2149361-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:39:45AM +0000, Wentao Liang wrote:
> stmmac_mdio_setup() acquires a reference on the MDIO node through
> stmmac_of_get_mdio() and stores it in plat->mdio_node. If the allocation
> of plat->mdio_bus_data fails, the function returns -ENOMEM and the
> caller takes the error_put_phy path, which only releases plat->phy_node,
> so the MDIO node reference is leaked.
> 
> Release plat->mdio_node on this error path.
> 
> Fixes: 1a981c0586c0 ("net: stmmac: Make MDIO bus reset optional")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 5cae2aa72906..09359ccb32ef 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -356,8 +356,11 @@ static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
>  		plat->mdio_bus_data = devm_kzalloc(dev,
>  						   sizeof(*plat->mdio_bus_data),
>  						   GFP_KERNEL);
> -		if (!plat->mdio_bus_data)
> +		if (!plat->mdio_bus_data) {
> +			of_node_put(plat->mdio_node);
> +			plat->mdio_node = NULL;
>  			return -ENOMEM;
> +		}
>  
>  		plat->mdio_bus_data->needs_reset = true;
>  	}

Hi Wentao,

As per my comment on another one of your recent patches, I think this
change would be somewhat more robust against future changes to this
function if it was implemented using a goto-driven unwind ladder, which is
the generally preferred in Networking code.

Something like this (compile tested only!):

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ea16d618215..ded352afd103 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -356,12 +356,17 @@ static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
 						   sizeof(*plat->mdio_bus_data),
 						   GFP_KERNEL);
 		if (!plat->mdio_bus_data)
-			return -ENOMEM;
+			goto err_put_mdio_node;

 		plat->mdio_bus_data->needs_reset = true;
 	}

 	return 0;
+
+err_put_mdio_node:
+	of_node_put(plat->mdio_node);
+	plat->mdio_node = NULL;
+	return -ENOMEM;
 }

 /**

-- 
pw-bot: changes-requested
