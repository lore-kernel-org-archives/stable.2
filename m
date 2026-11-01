Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793528081;
	b=Bm4NHy0pIcx6wxSHVu4haX4GUujBu/Gvfhjz1MVkH21fq1hEni0tntThMczMtIYIiL/2
	 gbjd5y02FsG83rOLxE4PxunDOmJcSPdm+lWGziERjfM8lFScM/nBuCl3dn0gSKnZkZBRO
	 r1hMKGgvHd3rXCe4rsO3kdXpJYPW1cgWIYqZjb7xdn5PJq7rUcndzeJH6dhctHedpmxlG
	 W6tDRFG/uMXi27gO4WLWmgA2JwiKAU7eUVAweczlj29M7s34/IEQrL9jk6k2OaTXubaWZ
	 jEOAOOQTovHsqge9QBWlLMJl6u89Y57xhVS6bohawqvbu6xyUbFoGUDZcWcQTQm3x7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793528081;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qcpQH98yXrG88iN1/9biSPLXhNxIVIr/aoycHhtDoAQ=;
	b=N3/cvluxN3rCMpfCMbgtLPVflG4g1IzXVMSPe0eBpsZ012fehZdHs/IE4FgDrcE09Swt
	 OCVs57lHeY+SknEpGHvigrNDVWqbo291jvPcv2Og1n7heZes3nwwntN3GfyxB/utDRbbD
	 I33i/IYKkwPl8KuEsOdRllMtqidjYtNnIjEb+Bq91VS125Zi+69y6rJX34H5m1ijLncPt
	 gR0J1XAWx33nCSLe+omwGGXLEMXkWJt1MALxtiJ2lw9fB0m4SIexb0GfHIJ/YwqeEBFUx
	 bjTsPtvwId01ZnM1xWGP3MtdbZ8F6cSKuVKtsnYJDwZGENFptjjdk2030Lfr+BcT0Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7CxUNq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5D606A325;
	Sun,  1 Nov 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7CxUNq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C430A1F000C1;
	Sun,  1 Nov 2026 10:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793528080;
	bh=qcpQH98yXrG88iN1/9biSPLXhNxIVIr/aoycHhtDoAQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=M7CxUNq40UIbSLROAPliuG7tkrW9JpaehQpsIv3r8tXQdA49Ux47V0htIXaF1PaaL
	 GNBai8Zm/ABvjQHG9hL63+cxydQ3OxtgnDiK94YIFOEd7ATmlGhQodjDKAYONYOY0W
	 HB7QoreIcV2Ak3F19NxNZakldWJNzzZchxVg49lYmjrZjA/ljxyHvnmBSoiZMlsMS4
	 L22G8PnK7H95s3troYg4KjxHJia/SGeDBQgrIMuuX3UPCfhNF0C5pdCBJdtJgCqocs
	 yvZRJaqywmTlneWtMnolOJcXcwYHLtSYPZAPAAiMtreDImto2AaOWoniu/hHZUkUyy
	 v0YbC+10sGsQQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] phy: ti: twl4030-usb: free the IRQ before canceling
 work
From: Manivannan Sadhasivam <mani@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261003035111.623790-1-mhun512@gmail.com>
References: <20261003035111.623790-1-mhun512@gmail.com>
Date: Sun, 01 Nov 2026 15:44:30 +0530
Message-Id: <179352807066.2955.5695904295125910316.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=mani@kernel.org;
 h=from:subject:message-id; bh=kmrEgjTeKEpg6c3EfWWIz1qK8YoFa3C7wI+02vgixBQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5xEIW6g18hEmrVsa5SmDh3ZvjXkWVyQONX+vq
 vVAtC2sXFeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaucRCAAKCRBVnxHm/pHO
 9eIEB/0a4PqI70aHy6yZippaf0c03Ksr9Q8Io/qNY2QmaJQ1poTKJG7YZT6rSdTNQxi7PeemIcb
 t5iIUpDcaj33xFQlhF3HNrrNiqPADl+LWp1bhP6WesmLQAaNbOc3/tycOEP8lIZWxEQL5zj28nN
 0VMcm9ImMQpQBb8bSGm7wPBZmHsnJs5KEBMC2SaXKXyNL84dmc1nNvMlBKWG5w9at0KtRzin/od
 4M6hId3vY4MHw4ld/WgSKYNHb7NLEzTWBw6y8PQGgRLNGuTw1WPSG8+yUBeYJHrQCmVqxdir17v
 v2vUXGjbYSijGUIR9fBQ3Id9X22ehhlfgidxp8ZrzdGRNRap
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-02 23:51 -0400, Myeonghun Pak wrote:
> The threaded IRQ handler can schedule id_workaround_work while the PHY
> is runtime active. The remove callback cancels that work, but leaves
> the managed IRQ registered until devres cleanup after remove returns.
> An interrupt after the cancellation can therefore queue work that
> accesses the freed twl4030_usb allocation.
> 
> The same work can be queued after IRQ registration if phy_create_lookup()
> fails during probe. Failed probe cleanup releases the managed IRQ and
> allocation without canceling the delayed work, and does not call remove.
> 
> Free the managed IRQ before canceling the delayed work on remove and on
> the post-IRQ probe failure path. This waits for the threaded IRQ producer
> to finish before canceling any work it queued. The synchronous work
> cancellation also handles the worker's own requeueing. Generic PHY
> consumer callbacks have separate lifetime requirements.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: 85601b8d81e2 ("usb: phy: twl4030-usb: Fix lost interrupts after ID pin goes down")

This doesn't look like the correct tag,

> Cc: stable@vger.kernel.org

Is this patch worth backporting?

> Assisted-by: LLM

Not needed anymore.

> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/phy/ti/phy-twl4030-usb.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
> index a26aec3ab29e..37c326cd1d85 100644
> --- a/drivers/phy/ti/phy-twl4030-usb.c
> +++ b/drivers/phy/ti/phy-twl4030-usb.c
> @@ -779,12 +779,17 @@ static int twl4030_usb_probe(struct platform_device *pdev)
>  	if (pdata)
>  		err = phy_create_lookup(phy, "usb", "musb-hdrc.0");
>  	if (err)
> -		return err;
> +		goto err_free_irq;
>  
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(twl->dev);
>  
>  	return 0;
> +
> +err_free_irq:
> +	devm_free_irq(twl->dev, twl->irq, twl);
> +	cancel_delayed_work_sync(&twl->id_workaround_work);

This err path is not unwinding all resources taken during probe.

- Mani


