Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A52E7F0A;
	Thu, 18 Jun 2026 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773811; cv=none; b=ouhnjSr1LTtrqD7ODzImORJRh9ASsySab4SFyxZWVMabe/WDzvMfEzrCSEGndltmLdTpItd2XWBJ8YC5yXtIijacrNRTXjg1lVtzei31YZi0IyIiq8ieKaf9cv1JXKvxcaP6gEnzvx9XhsUL0IbYyS+WLtClSOY11QuKzUnaGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773811; c=relaxed/simple;
	bh=seytXUg4OafjTMKgU/OCHFXz84Rva5yGTpWWmyGvRGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoCE5eVtt74RPaGNp5IMpD1LHDPwTF2ti/zE0ad06TqR65xV/yKKplYZ03VlP/uXEgQhcYcyTKFOdmZhS6iSswvxZWvIzIvz1BOLm03+UJnjxq6nYt9Zzld+tB9msVTfgVP41GB0abmW6T0Sm1PpAPp9HpA8SAJB5dNfx3ZwtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgoBVbxz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgoBVbxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EFF1F000E9;
	Thu, 18 Jun 2026 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773810;
	bh=qxHls+mvYMga7q55+aIvfUsybLdFRk1lb/ASdVVdilc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UgoBVbxzGIUUQ6cAtRfdVkrJ2rsSgVY/ScZtJ7SG+5Aafgevh00svnwfE08ooiOjX
	 b49oxw1IR95axsZQiIl1Xhf4+KaxY8OZnF/su7GVVAPWVaSS/TvEKyM41LCbwVhY8U
	 XvAXyTBeHdB9EcbARwAEP/A/BtaqPRoE3dMSxWlFZrwk08yjveqPEyYVZWF7iVDQs6
	 OPUNKTXf8KpafqXbtfE1TP0juYfjDmF6He9zX0hXzimvu8e61vQuCP80ZcTwpuQ/TM
	 6Z3r7x+4QiYtP/ofsEGQ0D8WlCH6BMS8lfQdRQgxzdjM6bAzY+TJbReMXglfuDggVN
	 t9qprRxmJWM6w==
Date: Thu, 18 Jun 2026 10:10:04 +0100
From: Simon Horman <horms@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	danishanwar@ti.com, rogerq@kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Carlier <devnexen@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Kevin Hao <haokexin@gmail.com>,
	Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: icssg: guard PA stat lookups
Message-ID: <20260618091004.GG827683@horms.kernel.org>
References: <20260616143642.1972071-1-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616143642.1972071-1-dev@pschenker.ch>

On Tue, Jun 16, 2026 at 04:35:34PM +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> icssg_ndo_get_stats64() unconditionally calls emac_get_stat_by_name()
> with FW PA stat names regardless of whether the PA stats block is
> present on the hardware.  emac_get_stat_by_name() already guards the
> PA stats lookup with `if (emac->prueth->pa_stats)`; when that pointer
> is NULL the lookup falls through to netdev_err() and returns -EINVAL.
> Because ndo_get_stats64 is polled regularly by the networking stack
> this produces thousands of log entries of the form:
> 
>   icssg-prueth icssg1-eth end0: Invalid stats FW_RX_ERROR
> 
> A secondary consequence is that the int(-EINVAL) return value is
> implicitly widened to a near-ULLONG_MAX unsigned value when accumulated
> into the __u64 fields of rtnl_link_stats64, silently corrupting the
> rx_errors, rx_dropped and tx_dropped counters reported by `ip -s link`.
> 
> Every other PA-aware code path in the driver is already guarded with
> the same `if (emac->prueth->pa_stats)` check.  Apply the same guard
> here.
> 
> Fixes: 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats")

nit: no blank line between tags

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> Cc: danishanwar@ti.com
> Cc: rogerq@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>

