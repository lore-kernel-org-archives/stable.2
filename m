Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B04A9D66;
	Mon, 12 Oct 2026 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821442; cv=none; b=s3SUSOdC9cMooevIa3gCOgTD8DQJ4G11ohBwLNXQn8NuqIizSuEtKNQmzVqYEoXsqbETWydQrpYtOayr3wOK962ijGapDuaA6B9darvBpq2iCgVL4g+jkvGF+hZlAa5nMaUc9No1DxrUy6xUvAAN06YU6PJOPV67rGcwSR5kzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821442; c=relaxed/simple;
	bh=mhNONTRaF/Na6+al0F6FIDV9/MARO9s8T4DrGw21Fgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKeNSce4tlNckV0fh+wUofzhTrJAtzXi+PugzyC+Rfi1m7JpHWBLJfsd/qRtWBLHDdmuc1BHDh3t7SSGUPLP2SIgUP0loxftwkslUeSv3pTCjvIQ4uIFiZ78YaGdKKgviW4PqB9zqSM+LtZxhG7N/s1yJjTnzll6M6aKU9MM9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtVRV9EU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtVRV9EU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDD11F0089B;
	Mon, 12 Oct 2026 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821441;
	bh=egAWEG+bcu6VYNzUqXMRIjdS7+btc7+MbL6C2aV6SSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mtVRV9EUFgxksJVwh0JMvqSXLlXVHyRMWLkDBXVhdfreiTfFMTdb0e2X87Td9gEZj
	 mwWc17HusNhEKQnUQ2C65paV7NO2Srk51v1zUs8zJBU89805gWgfKE3dH/Gh49djUf
	 LXY2lOlhVlAJrjkMoagIa/E/J/1EOxd1WZLQJfr8QimQAGATBsOH6A6aLn5uqZTRQe
	 qgFlEJxcHrMyCL66BLZb4g0NY5nBy9X1p7AMZma06E6cuGCnggOo+3Aa0xaTQbZuxR
	 XciZyo7h0rvm0Fi/bnEzEVNiMCEqvFn71TcdTcjmSnNG0NyCJljILaOb1Cx9A+qf9w
	 VkxoHG0hWDJXA==
Date: Mon, 12 Oct 2026 21:40:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hpchen0nvt@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, neil.armstrong@linaro.org, 
	schung@nuvoton.com, vkoul@kernel.org, ychuang3@nuvoton.com, stable@vger.kernel.org
Subject: Re: [PATCH] phy: nuvoton: Fix clock reference leak in
 ma35_usb_phy_probe()
Message-ID: <as0GcwfgjRsI1O8N@debian>
References: <20260917134353.2153788-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917134353.2153788-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 01:43:53PM +0000, Wentao Liang wrote:
> ma35_usb_phy_probe() obtains the USB PHY clock with of_clk_get(), but
> returns without calling clk_put() when devm_phy_create() or
> devm_of_phy_provider_register() fails, leaking the reference.  The
> clock is only meant to be kept on the success path, where it is stored
> in p_phy->clk and used by the PHY operations.
> 
> Drop the reference on those two error paths.
> 
> Fixes: b48baf69db97 ("phy: nuvoton: add new driver for the Nuvoton MA35 SoC USB 2.0 PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
