Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C23BCD3D;
	Sat, 26 Sep 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432666; cv=none; b=rz+qmViBBp2/ZQMaQHk++q26CYPRoz7tlPIiDlXdM5jRBztWnys0vaqonp4R7CXRP52riWCaX8WwB4h2wc71uQ3Z2gKUCrbSKEG3gq6lSACj3uHNInHWmK361ChGOnHeTD9xlYIDaW6peagLYHe/SSBPaQeJ88Y51MTxJ9LVEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432666; c=relaxed/simple;
	bh=aQ0eoM8RbS8erFSE79TCqvZjxefs4sAf/aP6gtgKhuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPL+HKmI+N+j1cBNRrPVqHOFPiCyfnWIj/M6R6SdAp67YLF3GSWOqxe3qTv4bft2iw1tzumZIM6OSA7vjXqE0gzFEfTK5Lo71iAWQJuZ8Hv2JWtcshiT6Ih7d2HgcXnkl0LkUinveh8xOJDmfPyTklICC9H/SYtXB+dZqT5gu0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET8y45Op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET8y45Op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD31F000FF;
	Sat, 26 Sep 2026 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790432662;
	bh=a34dKCFGnj1YhLXhoEWVxE1cmbQtJTn1UZf0QYyW3u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ET8y45OpVi01KkX0kIn6q1NJ2NbMjGdLsNWSWGyV3YfshbpjmBaQ/7QW33gekyxW9
	 yx47I3zv6Xr/hHwk4wvYBh0ZUeJ71cfichVp2vKNcHeiIudUPNY8acwWyITS22qSdP
	 yYX8qUXYXgaOp/qgWrgUrE46sb+6sa9rNyBnywDyl/k0ZDO+Lmo12QQpEzIoTB4dxn
	 7zpBBryWAQzTGfNPG9ZpwP/3lheQx5FIn04EIqzhXMT0RCZt26UlMDdZmDdz3LZrgS
	 NsCcv0VYd2uNiJPqKTsC8iuslQJUrBg2DNlhaPl+j3Yclcf3gkwuv/zJIyATLLf0Sm
	 toJmeMCGLlcjA==
Date: Sat, 26 Sep 2026 16:24:09 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, bmasney@redhat.com, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] phy: freescale: fsl-samsung-hdmi: Fix runtime PM
 cleanup
Message-ID: <millx4qmsnogv3uxol44dp243oyct7n5duvrhomapgoc3egsia@6e4p7id3igyk>
References: <20260721064752.153338-1-pengcan@kylinos.cn>
 <20260721064752.153338-2-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721064752.153338-2-pengcan@kylinos.cn>

On Tue, Jul 21, 2026 at 02:47:49PM +0800, Can Peng wrote:
> fsl_samsung_hdmi_phy_probe() takes a runtime PM reference, marks the
> device active and enables runtime PM before registering the PHY clock.
> If phy_clk_register() fails, probe returns without dropping the runtime
> PM reference or disabling runtime PM.
> 
> The remove callback only unregisters the clock provider, so runtime PM
> is also left enabled after a successful probe followed by driver unbind.
> 
> Check pm_runtime_set_active(), use devm_pm_runtime_enable() so runtime
> PM is disabled automatically, and drop the initial noresume reference
> on PM setup and clock registration failures.
> 
> Fixes: 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index d010fec15671..e7af4f9c7b20 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -665,20 +665,26 @@ static int fsl_samsung_hdmi_phy_probe(struct platform_device *pdev)
>  				     "failed to get ref clk\n");
>  
>  	pm_runtime_get_noresume(phy->dev);
> -	pm_runtime_set_active(phy->dev);
> -	pm_runtime_enable(phy->dev);
> +	ret = pm_runtime_set_active(phy->dev);
> +	if (ret)
> +		goto pm_put_noidle;
> +
> +	ret = devm_pm_runtime_enable(phy->dev);
> +	if (ret)
> +		goto pm_put_noidle;

Use devm_pm_runtime_set_active_enabled().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
