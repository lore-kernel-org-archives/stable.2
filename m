Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F419374E5A;
	Tue, 15 Sep 2026 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454058; cv=none; b=bZEB6bOJ1vxNjoiCPOp2pcWGTBcInqNfIiI4UVUl2SbGYBi3JZ+/vzMG/b4LcKH6B4oFUwvUEuBXkeIwiAVUQTQ85jLaa+EFL+y37DBFdIfwiGWMS7pAEdyASYO6g4X2qpDLUJrvGYLs2n3h7DeiHVL1ctlEIunkkMkSzZkz3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454058; c=relaxed/simple;
	bh=Ser9KmsN1N57Rla+KhmDHZ+zORwXgQxdfa4OX3xOa08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSIGoe0ioXGNQZK0yxtYK7Qzjg/IpeN8nCLJoKxJ+es8YHvgfkIluf1EWvULrJguuFzwb2hVEuT2Qk/n+ROTPWuPwG+mtTqKvatWhiWwMD2fqG+fGn++iolFmclN9OZZ5VdJKEahiWhu5IyVrcRluNe1vbDvj2smUwBjU4a8bGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doVFDbsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doVFDbsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D711F000FF;
	Tue, 15 Sep 2026 06:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789454056;
	bh=au+l37rDlIofO/OyR7zRhhJQrP7Rz6WCu1SPKN84omM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=doVFDbsyA1x4Gktsi+LtE/9eA53BBBxG2OJTRDljpLjv3g4G0uyqepGyb09SBztm0
	 y84HnfhYZ9vsUKve49uoNNmKPZ2rE6YA2ceLSMjc/+oK8ZrNQAmYTbhnOOtmfHyf2u
	 yh+cMis66E5vBzGGPyoQ8XnvBZvQ/vwYXedqnlrtSxbOzYwoVAoS31M3Uv3Iy0SHUw
	 EzQPvyZUKn+O9F7A++5iYqsp/rqtz4K+L8X/pT9e1ofl/k3hnM0xIP5rUfaMJrAZ0u
	 bwS62p2H4uQllEm0v8OCZDOioiWzTI+6ygP8M0BEPXyGKgndvU7q5N+hSVM7FtgHWa
	 VoVRn/Jc8Q95g==
Date: Mon, 14 Sep 2026 23:34:14 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>, linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] usb: chipidea: tegra: disable runtime PM on resume
 failure
Message-ID: <aqjm5m4NhLCeGSJY@hu-petche-lv.qualcomm.com>
References: <20260913041033.25144-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913041033.25144-1-mhun512@gmail.com>

On 26-09-13 00:10:33, Myeonghun Pak wrote:
> tegra_usb_probe() enables runtime PM before resuming the device. If
> pm_runtime_resume_and_get() fails, probe returns without disabling runtime
> PM. The later error paths reach pm_runtime_force_suspend(), but this early
> return bypasses that cleanup.
> 
> Disable runtime PM before returning the resume error. Do not use the
> fail_power_off path: the failed resume did not retain a usage reference,
> so its pm_runtime_put_sync_suspend() would be unbalanced.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 8b85e11c1a7a ("usb: chipidea: tegra: Add runtime PM and OPP support")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
> index 372788f0f..26225b034 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -306,8 +306,10 @@ static int tegra_usb_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(&pdev->dev);
>  	err = pm_runtime_resume_and_get(&pdev->dev);
> -	if (err)
> +	if (err) {
> +		pm_runtime_disable(&pdev->dev);
>  		return err;
> +	}
>  
>  	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
>  		usb->needs_double_reset = true;

-- 

Thanks,
Peter Chen
