Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAD47C105;
	Sat, 26 Sep 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432503; cv=none; b=YNgCT1l/n24fMPHxq8TMwISPVBeSSDXSVBtjmzRiekqBsmz6aSp6xxOA2Pwia621QOKkkiObjZEvEeddQ8fsNKYWdiRXTqxnBd15saZI4VG0P3M7g02pusTDg2PBi07Vc3NyWg4Z88GqyBe7U6ZK5pm1MVbI9NjwfuWwehefuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432503; c=relaxed/simple;
	bh=N/zc43OX0NJcXOlKttd71aCoXaku/zT4wn3Im0elfbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGZutXnxdgMYD9Dcj1oveTodBTCLpurb4m8oBCYCH+2kuBO5DICqH+Jf1jcAhCkASqNqor2FMX8Ry68UBPTokZMc3NRaaZSjqyYW1hXt71PkyWGyK72BPgCKS3P7iNEU6PbaW0B+t20Lh+cYEckc6JYIHg3lCTqNNXlv2WP53JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVWBvkwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVWBvkwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797381F000FF;
	Sat, 26 Sep 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790432502;
	bh=mcNV7E5affOLKemIdC1o8Ken3eCPRrUXW0HnEaaGIWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nVWBvkwCA1jI79/+Dwlx1Xb6PstnKY3hTTae+Xgt9sT1N6gZJoKyJ5v5ci+Fkydgz
	 K0tj7pdn9HJadKI3kqu6rKWUIt/q7PgHCEef5zKghzDmENNoBw7ZfvbX87H/kM53sy
	 M8Hr/kWDkqxJvooye7Wgaa03yWooHPfRoXZLy74Dj47c1lMX933ku5SGEif1fBsvFa
	 BBT4NRG9JhjRqoB8t/kCGU9d0jyqqdeicc5dNPoEMv0D/ZZ7CYiPDCRw8PkTf/YLMS
	 CEqCOgL8hIUwTV/vOigr9y2BWZ1QlBD2gUxFG4ZeSra2j9YMD0j6NNWJCLpzR+aSYJ
	 ZaLM8Kpou07zg==
Date: Sat, 26 Sep 2026 16:21:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, bmasney@redhat.com, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] phy: freescale: fsl-samsung-hdmi: Fix runtime PM
 cleanup
Message-ID: <klm6moh7mnsrlvh4gfmu6a7dczqmxmp4z3j2dtwdbdshl65fpw@6ujkywilegww>
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

Why not devm_pm_runtime_set_active_enabled()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
