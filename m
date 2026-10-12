Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400AA4A387F;
	Mon, 12 Oct 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821102; cv=none; b=mHSXQQQISdPp6UcP42AsEq8b+QeJ/9FkSTL6Nf338W1QTFgcjgfa7bzGwAUKjcZbKZs+C5E14+/95Zy1R/YqDmTUPMThpf74yI6LLOkqlPFZJefHTGXYFJtlue6+ZQuXzaai6a6BSkPvxnYFP1o8xL/nyoJf12DPRaagZkRwmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821102; c=relaxed/simple;
	bh=U5FqGRPagJeMRptaLpwRa12ZSQDYQHsRHrHj+VKJUsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf8nXVYGwmIO76x0Xqi0hSAr5/Q8VptuXn5JXgo38LvJI2S9yKtoy0QESjH9JVDbRGHI7d8/IfplXWjyMZIIWMPMXFx2DmxL/p8MiuVjfm2B/a92cAjZnVYuSxzbD/O3dYPFJwSA/mrW9p+PegrAmN5eWUYgpiPiyQt4owJ69m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmLe7OIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmLe7OIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496271F0089B;
	Mon, 12 Oct 2026 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821100;
	bh=eldCxvoo+3xT1QHt7oQPOhAPJhe6yOVGMkPFOshsdCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nmLe7OIv+/OeWH/yLrSmuNvcPg0FTZCvwfp/+frflRvbuGrNNX/ErJ0pgZsiWL9Im
	 GoM+tQleb9A/WwGg7AuZUfA38z1M1bC1eFjlxXsQ31vLW56fzgPSrAkMFM50LyRK7t
	 caY6W1kyTyD09Z/pzglEV8lMXIo8Bimt9zmtvXvxFq66Xefgs/dQ+BDFMmJJAxjLWS
	 TUq7t8gN4hfPGhndf26DgnvFU9ASOKIYgPvx01UaX5i/eZx+SkTeB7rqTLGvUi1w85
	 3O/wBWrzKzmmeqXMtkYscImJPPGUNLfcWL5nBOyjlzx5qjcjXvdqoVozNpX6Z4z7w0
	 iM6lal9TXN26A==
Date: Mon, 12 Oct 2026 21:34:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	justin.chen@broadcom.com, kishon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: usb: Fix USB 3.0 clock reference leak in
 brcm_usb_phy_dvr_init()
Message-ID: <as0FEDefpSlqtipP@debian>
References: <20260917133651.2153617-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917133651.2153617-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 01:36:51PM +0000, Wentao Liang wrote:
> brcm_usb_phy_dvr_init() obtains usb_30_clk with of_clk_get_by_name(),
> which takes a reference on the clock, but returns without calling
> clk_put() when clk_prepare_enable() fails, when the suspend clock
> request is deferred, or when devm_request_irq() fails.  The clock is
> only handed to the driver on the success path, so nothing releases the
> reference on these paths.
> 
> Drop it from the err_put_clks label, and clear usb_30_clk on the
> -EPROBE_DEFER path where it holds an error pointer rather than a
> reference.
> 
> Fixes: 49859e55e364 ("phy: usb: phy-brcm-usb: Add Broadcom STB USB phy driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Same comment as previous patch. Handle all leaks in one patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
