Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7450AC0D;
	Wed, 30 Sep 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787581; cv=none; b=uHBs8BSsMwQ8ORdTI4XBEp2j2u9WcGOqLWHyu9BpW5/u5wD5W0ZYJx21sy9LmI3biUCOnJaJBtSISEe5h3xGtIcswRnr1Y8gnwn3BwnLIBQVGAqxq298AbqiKAX+a+fDKP1baiBp/ZAdG7N19YN/GjXiXxNE/VC4UDotNwE0RRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787581; c=relaxed/simple;
	bh=XVWxm+61uUc2o7o7SZxJC2olgIhhqlVkBJhGRvoanRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib9ZMj+Fv8EYoW74q0v2cwXWWgKuKAvODBPqQSrluoF9sF22uDdlr7r9FXo9AbKZSzxF+lizHit1O46iVm3MqiWwpJyXELwis89Y/PSBVKaqp3zImmAgj7dV0RycxHz0lR/3/nfsSyvgO/n6D1i9lpf2kAvr11WVFBCMP8M7sX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ6PViHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ6PViHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3321F000FF;
	Wed, 30 Sep 2026 16:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790787580;
	bh=3k2re7GR8Ti5+fp1ZnMTSBnGj/MI1jvnroyZYGhCTWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQ6PViHXJNQScHtsBLSsVYmAZMa+TtjmH81d9422QNj/U2BKH07HtQvD3h0Byk2wM
	 Qg6PMq8bPdegF/GV7SV5GpUGykmHcL/AiV4CBrh147dSEFlz/J+iazee3xxRMXzE1G
	 Yag4xOyA41HDdtFvgDQaz9m0QLkMLMLZPm44CNw2ZVbA88so9EpnLawDp7kvQgmrzN
	 0GwrdmzeiQuLHUHBUteQz6gtHNAQwVUH3GM/f78byWiidLvLjJoKL1QDrUmpLrSnVj
	 y1norEitnQUAdJfr7kkMFq17S5RWyjlaFW8HT1mRMGam+e114bMk3VFkHmRV4NUZSo
	 lhNmG9qkm1Vdw==
Date: Wed, 30 Sep 2026 17:59:36 +0100
From: Simon Horman <horms@kernel.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nfc: nxp-nci: fix IRQ use-after-free in i2c remove
Message-ID: <20260930165936.GY13925@horms.kernel.org>
References: <20260925175800.3694044-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925175800.3694044-1-qwe.aldo@gmail.com>

On Fri, Sep 25, 2026 at 02:58:00PM -0300, Aldo Ariel Panzardo wrote:
> nxp_nci_i2c_remove() calls nxp_nci_remove() before free_irq().
> nxp_nci_remove() unregisters the NCI device and frees ndev via
> nci_free_device().  The IRQ handler nxp_nci_i2c_irq_thread_fn()
> dereferences phy->ndev and calls nci_get_drvdata() on it; if the
> interrupt fires between the nxp_nci_remove() and free_irq() calls the
> handler operates on freed memory.
> 
> Swap the order: disable the interrupt first with free_irq(), then tear
> down the device.
> 
> Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
