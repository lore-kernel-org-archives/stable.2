Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB77531604;
	Tue, 22 Sep 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790078608; cv=none; b=mmK2Xf8nS6AAFQrnQ7VsTRPgKhGXswOclpewfIpdELBjTth/yjbhXw0f81Fx7gZ++ogS3aXhW7MK3SgFRpQV5ZxM2fGNa6EeqQWmNR0izuMtjzAtsOz4U/ruXFC1izwwEtmoqUDxHUQmyYx9lv5CKOIN4zdD9EgKl2TEJ2Qq2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790078608; c=relaxed/simple;
	bh=n9FpIaAN33W0DO7GyLXsKhLBrBgyc9o6R/zLeItOogA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX/7QpM26rNtGME8uCB2uB54iMC4DRFeUIjmBoDKD3EsDUgtZX19WvlQRNACw/Ob+7yz/BhefErvNoZLlQbw/j82ojzomwCoastJts60U7MDMicvRt49voEn6ANlEPHNsu7nfHgmUN13erNMbLDSw6dJ26h1ip67YHN1yUs6AEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1T9WEqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1T9WEqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606B21F000FF;
	Tue, 22 Sep 2026 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790078606;
	bh=DhFfV30KEO/sb3oCDRBx6W3tLymcOKC4hcgAgAQWZ4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1T9WEqNPXL2Cvd6Js8hrKP1/M3YU1kgqqkgL8PZYNvFam5p4YmBKhLAcm4AUUdtP
	 6Py3ZejTCbXIhvJPs5Df+HCpLXfACK4gnVi2EPaFziHrI15NApio3e2BVaOQXEr3P/
	 +69SWypVL74QdPAC/HNWa3SGY21QmJ7k4g4unnppdOQ7RnhtyPxeVgI62Xw3H51GcN
	 IgKU7pTr6KcQ29QjyxL8dWJlWixpbzHD/m/YUFwsAE35fVfiNuE7S+xv9rD/j91Jmi
	 ARv01dbzQpBFxyilyGr9nESYVnMIJDiXoaQ/n3OY+gPaxjQ5xHXgrTZujaDSy/t1nt
	 H7VDnA1tXSSjw==
Date: Tue, 22 Sep 2026 13:03:21 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	clabbe.montjoie@gmail.com, davem@davemloft.net, edumazet@google.com,
	jernej.skrabec@gmail.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com, samuel@sholland.org,
	wens@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: dwmac-sun8i: Fix EPHY clock leak in
 get_ephy_nodes()
Message-ID: <20260922120321.GD13925@horms.kernel.org>
References: <20260917113654.2149268-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917113654.2149268-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 11:36:54AM +0000, Wentao Liang wrote:
> get_ephy_nodes() stores the clock returned by of_clk_get() directly in
> gmac->ephy_clk before the reset control is obtained. When the reset
> lookup fails, the loop continues or returns without releasing that
> clock, and sun8i_dwmac_probe() then jumps to dwmac_remove, which does
> not call clk_put(). Keep the clock in a local variable and release it
> on the error paths.
> 
> Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

