Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0F3FAE1D;
	Fri, 26 Jun 2026 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490321; cv=none; b=IlaWf+R4QRPUJ6PNREZKekcPAJi8XeOq4qUDyQlYsAJGpGjLeHi3pBL3U2IDMzP/6tlWw2nATo1SB/Fc+XdQjDwJfTtAPXRnvGvW+neT0oA6OP9m6ncR2fcoEmHc07st9h53FwoxqLc4FC2l/PS7YHkbRCW5tNizxI6Ccx0DVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490321; c=relaxed/simple;
	bh=iSfR+9zbKksmHcBVuOe/NurIL4kLG4GXXN2/ltuck8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbeDVVkMgQTWB3lyRho2rHh+1bSXnmNo0424tyxb1dMYHMnAYUh9KilqD/Bme6aPolyrTuBShtInLLZBCHTsL2z77buWC1mQAG4mCJWEeKAagyJCh48qmk20OIVdvnSLL7TLGsi8l5+ZjIJk2jFYzxuz12COubbDf/dfmDi26Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WwulOg/u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WwulOg/u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xpb0OgYrP34zH14FJQRa4tbViBikysXim0c8FtbtJd4=; b=WwulOg/ugjEm32QXtlxjbxk0wY
	6x5bdZcw5jYLXj0wfIu9D7A7bSpXWwXPx3E49q6VCM/9FFU7hYCOMLVl/IPcpOGFAc2wOgumkZsfw
	B10JCthIHCXibfxIE9H7eChT/CkJEVSnFjsFsN8qE68m4WJSWeNeQU3jJqe3p4f9q9hs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd99g-009OGL-TV; Fri, 26 Jun 2026 18:11:48 +0200
Date: Fri, 26 Jun 2026 18:11:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	linux-omap@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: ti: cpts_of_mux_clk_setup: fix device_node
 reference leak on   success path
Message-ID: <64f44697-ecdd-4324-8112-c26ddc46da01@lunn.ch>
References: <20260626153148.52612-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626153148.52612-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:31:48PM +0800, WenTao Liang wrote:
> of_get_child_by_name acquires a device_node reference for refclk_np, and
>   of_clk_add_hw_provider additionally takes an extra reference internally.
>   On the success path, the function returns 0 without calling
>   of_node_put(refclk_np), leaking the initial reference.
> 
> Add of_node_put(refclk_np) before returning success to properly release
>   the acquired reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr
