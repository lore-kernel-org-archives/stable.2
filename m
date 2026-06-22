Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17703AF676;
	Mon, 22 Jun 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136145; cv=none; b=Y9lC6qHslFBzk+rqyQtQoKrc6rM/e/RdfPW5jauAEejh5P/O96VAEWBOIvoeSOq9lVzEckLCceBYJ1D00mQp51Zd0ZeKKeI/BhpIr7nXshbQF0duC7pR7U0dQgNFVdwcBT6KAlx0/mqzu1JL5mK/vGAKTeNS8LnpO1ncOs7ZbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136145; c=relaxed/simple;
	bh=O54M4H3IQsxhsn8s5sA0Z0djOR/Xvy5bT4hYCwsyhO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqZ98s1OIOiCa07c1Hce/O62ndsLf60EdpcVN1tsegpFR/liCrGh0ylSmEtQ9XBF5JXv4xk3FIfzSMUvqi35eT1taZwQTCck4o6e0Rr5c2SoPyRaOwrtWfJmofQaMabKhZUodkEXuSkK9bNteaP7uZcIQK2J9UvXl/8zz48wMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+s9giIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+s9giIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4171F000E9;
	Mon, 22 Jun 2026 13:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782136142;
	bh=Afk2WkWe1DBdhoAyCR3uQBQn4AnRI6PQbss67twOhfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i+s9giIPkJY66k5c9fxZQV2ud7vAfou4J+/LNLCu/oGKVYlolq2vTLpm7q+ZsbzFN
	 54rlum/XDk0UHfa7Ce58iMCHNYguL0+BblD9PK0Dq0wJkhYK29g9o1+aic0U1P4sZk
	 lPFS+NQ70wb4x+ZCtr8x0sLq76ftvAD02l0BSv5MReRAkgBclFb/kiTMsxlZbrhSBp
	 JUvr59DvDne0M/C0BP6he6G4g4YHA41XqPSxMnZ01sDhI7vHnHjHX1oNnYRva0ng+D
	 ATbmnGiRbLEHpGSQSOR4Zmj4uZ2WpDd8aOQe1RtDO4zR8ebHsEu7YBbefoTZEVxoLf
	 HG4/DN/yOV14w==
Date: Mon, 22 Jun 2026 14:48:58 +0100
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, felix.manlunas@cavium.com,
	ricardo.farrington@cavium.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: liquidio: fix BAR resource leak on PF number failure
Message-ID: <20260622134858.GF827683@horms.kernel.org>
References: <20260620083728.2722895-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620083728.2722895-1-haoxiang_li2024@163.com>

On Sat, Jun 20, 2026 at 04:37:28PM +0800, Haoxiang Li wrote:
> If cn23xx_get_pf_num() fails, the function returns without
> unmapping either BAR. Unmap both BARs before returning from
> the error path.

I think it would be worth noting how this problem was found,
and if a publicly available tool was used, naming it.

> 
> Fixes: 0c45d7fe12c7 ("liquidio: fix use of pf in pass-through mode in a virtual machine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

There is an AI-generated review of this patch available on sashiko.dev.
I don't think the issue raised there directly affects this patch.
But you may want to consider looking into that in the context of
a separate follow-up.

> ---
>  drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> index 75f22f74774c..a1548ca81ecd 100644
> --- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> +++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> @@ -1167,8 +1167,11 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
>  		return 1;
>  	}
>  
> -	if (cn23xx_get_pf_num(oct) != 0)
> +	if (cn23xx_get_pf_num(oct) != 0) {
> +		octeon_unmap_pci_barx(oct, 0);
> +		octeon_unmap_pci_barx(oct, 1);
>  		return 1;
> +	}
>  
>  	if (cn23xx_sriov_config(oct)) {
>  		octeon_unmap_pci_barx(oct, 0);

I think this would be best handled by introducing an idiomatic goto unwind
ladder to this function. Something like this (compile tested only!):

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index 75f22f74774c..73362b92d0fd 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1163,18 +1163,14 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 	if (octeon_map_pci_barx(oct, 1, MAX_BAR1_IOREMAP_SIZE)) {
 		dev_err(&oct->pci_dev->dev, "%s CN23XX BAR1 map failed\n",
 			__func__);
-		octeon_unmap_pci_barx(oct, 0);
-		return 1;
+		goto err_free_barx_0;
 	}
 
 	if (cn23xx_get_pf_num(oct) != 0)
-		return 1;
+		goto err_free_barx_1;
 
-	if (cn23xx_sriov_config(oct)) {
-		octeon_unmap_pci_barx(oct, 0);
-		octeon_unmap_pci_barx(oct, 1);
-		return 1;
-	}
+	if (cn23xx_sriov_config(oct))
+		goto err_free_barx_1;
 
 	octeon_write_csr64(oct, CN23XX_SLI_MAC_CREDIT_CNT, 0x3F802080802080ULL);
 
@@ -1205,6 +1201,12 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
 	oct->coproc_clock_rate = 1000000ULL * cn23xx_coprocessor_clock(oct);
 
 	return 0;
+
+err_free_barx_0:
+	octeon_unmap_pci_barx(oct, 0);
+err_free_barx_1:
+	octeon_unmap_pci_barx(oct, 1);
+	return 1;
 }
 EXPORT_SYMBOL_GPL(setup_cn23xx_octeon_pf_device);
 
-- 
pw-bot: changes-requested
