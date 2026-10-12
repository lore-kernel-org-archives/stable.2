Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD14A99AC;
	Mon, 12 Oct 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820636; cv=none; b=Ea62w9+k/bGEHTB0XiecsWcOZ4tNLeUDSJnyjxZIL7tbriQPFNVZ0yY+Du+YvxHun+6/NXmXhBG7pQ/1I/3xPg01nSOc7NERs5cl9rqynNMdFwCmsEjlmOZ/fbM+Ua6oImDa9UKriY5scSE90U7M+9DD8xM914ILDXruykZIqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820636; c=relaxed/simple;
	bh=+j/wrN+lmmhmBg0Vw9LT+3IZNDGfkQQQLAuI3uoQVoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf0c2PKJaHmb7TRO27sSnajc2T6JRanEEUY8UlRDPWJYbtmVE8Yinzx4HTpdy/qaj5sriuxMJf4dgx1Xih40U9Uj7CiaRqBK8cYtN10Rx5YCkw0r94pw9R7sStF3+oLfqACTjnDd69zU5kmJzd3tWXgPieD3PoKJA1On/UDnD7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loAOGi35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loAOGi35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93BA1F0089B;
	Mon, 12 Oct 2026 15:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820635;
	bh=Jj0B9E3ttjI3QI+ktrkzj6pBasZ09kGnLpoK90d81cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=loAOGi353EL3cfAXFKDjejwAiJ4RERlW1DLlR881bijUjRYzTfLTq14IrgufhtECa
	 1MVHreTEl1xyFmNXyuf8niZmzCzZxhSb7gwi43rFsYZxB+4sKO/1JVCzpUKNRZb8Wo
	 Xxm0zyMwyVdX9LNFetu0b2u7L+uG15KRfpwdydwPcnxLDI6ta3pXQUAvPEOmdBl1cj
	 +CLzg6D6RGOeppvzLEiG65Al/oJdq6rfhKLqrQ2r1DoImQbuIa1JGBpwYTu8DZl2gv
	 lwvzEguPWTuO7IrZ7hNg4/q5zUt/oCNPzndOit/8y3IJod6P9bg3RHZ4LHI82kzMLB
	 kKfdiAq3IMcfA==
Date: Mon, 12 Oct 2026 21:27:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	justin.chen@broadcom.com, kishon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: usb: Fix USB 2.0 clock reference leak in
 brcm_usb_phy_dvr_init()
Message-ID: <as0DR2jcw2mqnxKA@debian>
References: <20260917133510.2153560-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917133510.2153560-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 01:35:10PM +0000, Wentao Liang wrote:
> brcm_usb_phy_dvr_init() obtains usb_20_clk with of_clk_get_by_name(),
> which takes a reference on the clock, but several later error returns
> -- a failed clk_prepare_enable(), a failed devm_phy_create(), the
> -EPROBE_DEFER paths of usb_30_clk and suspend_clk, and a failed
> devm_request_irq() -- return without calling clk_put().  No other code
> in the driver releases it either.
> 
> Add an err_put_clks label that drops the reference before returning.
> 
> Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Duplicate of https://lore.kernel.org/linux-phy/20260913012956.16443-1-mhun512@gmail.com

- Mani

-- 
மணிவண்ணன் சதாசிவம்
