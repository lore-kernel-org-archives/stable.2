Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346E1714AA;
	Fri, 26 Jun 2026 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437033; cv=none; b=K8UT9vlRMiJ1AFshVmpcwCPIbFCf0HQqmfS+Ur2O3kSH+5/Zyy8agL3r/aU+yZ8jD8BisN6/H9Xn3szT7fSD4/TZ0PiODLOAenIfKhHv1c15woGGD4h33FndZ2ynqFf+3hKDdGNcYmAF+3RgH3b3lCu98qUCqebzV9sPVPMrWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437033; c=relaxed/simple;
	bh=SsYxHWPbdIEw6QfLicKn+5LbSINSJo7vhdttkm3+c5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csSsxSnY4N403N1Q2etWuOFgeGr7C1pZvsZTAjP5g0+T8/wS65gK2p2P2Aztsf0Pyhn8DBiDGjMNcNugecP1OdQzfFsKbJtcSjILzXB/tysk7VbTpi9TfQVdDH4ov5rzOW3s5SPXR8oAhYGxTTTkfe+57d1PfZkedNgQLNAA5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcsT0lYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcsT0lYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17B61F00A3A;
	Fri, 26 Jun 2026 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782437032;
	bh=sq6HmXyYHpEL/wxH+ruD00RarkGUJyQnwZk/nxXZDS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kcsT0lYnqxymaQCCUDxBuLRSaWnUWHBdGxuzeQeK6ufU6Ss72b6APJaRoQbwHQgFJ
	 EcNE22Sna/1i8JioJ5lLCZafMI6nUXQhiVtAYQa8FaVPohRGKy7CdNy0xdIYJttJGZ
	 LK2IKaCGKmDU2sVrjCxDWvVRigYFg706rl3TsUOPwZr28mjc4/+KoLgmpaOkPD+UYC
	 znrusKNH/V7wNj2+sng7gvSDKZ3p/n7jg4zqXyuqt9pT9qia2bu6pnTWvA/Ha+1eh3
	 YWJg8OJyDfwwYurb48UldkF+IczMX3x2AErduye2Z6cMy0SE6ckebAhmbUxUX+Jjmx
	 lpCifvtJCbWqQ==
Date: Fri, 26 Jun 2026 09:23:47 +0800
From: Peter Chen <peter.chen@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, thierry.reding@kernel.org,
	jonathanh@nvidia.com, linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: tegra: fix refcount leak in
 tegra_usb_reset_controller()
Message-ID: <aj3Uo2P0LJp1KSPZ@QCOM-gEdNzOMOFu.na.qualcomm.com>
References: <20260611124940.80010-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611124940.80010-1-vulab@iscas.ac.cn>

On 26-06-11 20:49:40, WenTao Liang wrote:
> In tegra_usb_reset_controller(), reset_control_deassert() is called on
> a shared reset control to increment its deassert_count before toggling
> the reset line.  If the subsequent reset_control_assert() call fails
> (e.g. due to a missing reset controller device or an invalid internal
> state), the function returns an error without ever balancing the prior
> deassert.  Since the reset control is shared, the leaked deassert_count
> remains elevated, preventing future reset_control_assert() calls from
> taking effect on the reset line and leaving the USB controller in an
> inconsistent state.
> 
> Fix the leak by calling reset_control_deassert() in the error path of
> reset_control_assert(), ensuring the usage counter is properly balanced
> before returning the error.
> 
> Cc: stable@vger.kernel.org
> Fixes: fc53d5279094 ("usb: chipidea: tegra: Support host mode")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/usb/chipidea/ci_hdrc_tegra.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
> index 372788f0f970..8d313345665c 100644
> --- a/drivers/usb/chipidea/ci_hdrc_tegra.c
> +++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
> @@ -138,8 +138,10 @@ static int tegra_usb_reset_controller(struct device *dev)
>  		return err;
>  
>  	err = reset_control_assert(rst);
> -	if (err)
> +	if (err) {
> +		reset_control_deassert(rst);

Could not understand why doing that, there is already a reset_control_deassert
calling before that.

-- 

Thanks,
Peter Chen
