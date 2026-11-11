Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794404099;
	b=LAbzrKqcBQUV2mJ3VdiyKpRsBs+gS/6JpRemAj7c5LqXYEHxSaoiT0UBxzW4n4fQzx26
	 a/8x7ynGxEquMabTVSCYhA3JofLK/vP9MquFfsCYKJLXCbuTd1ym0GEXYNv5woERsdG1m
	 /gDvGpWLg5SeJ4gUTkIgDtgXGFtwHyjeoALjBUj9GAkbCXxWYdwyOv6XlVLcp7LiAlXMt
	 FKVOZER9DPU2YhNgRFu+0o4f2eHHtK9YbSL2Mii16e4doVJLMyqyF05r2LQlGTAOiCF/p
	 zxEblyoC683G+8vxtwbH0P2tBDKF61oc2F8o1z68oNLnwIhxbnBglCgBV08hkIeccbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794404099;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=skpWLWubRAy/usrZud3Ziz352i+vYVGgRMybtoWruq8=;
	b=wshoP2gBU5XCl0c8OcbVZDz5XnxIUxMCZKand6IUsz75iDbuxTzcHCxGfRMk9ICPCVa5
	 mMUgGMJjFLIXSLeraDBO1cm/a3efYAlK9ofbAPdeig6q4Vxjvh6PFAQBTuHUk+yGBH7sC
	 ZusdgnU63DUxCkNdZsC/nSgXzwwzhe8NCuowlKo0vYRwAeUi+cVbIA8cB5caMSNIuPhvf
	 1sJ52Hcg0BbqWSZoSBi++z+g/CbjcS2PTcZVEVyWXdUJQx0azjZtQoDSVodOA3y51H/fn
	 5HbiSSBAwpQjqmp+w3CtdUS1i3U1vVk+Xr0hveI+vBZ6W2BewATiCgZaYkAvhUhSEFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PVHR2nY0;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647A606A324;
	Wed, 11 Nov 2026 13:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3647A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=PVHR2nY0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=skpWLWubRAy/usrZud3Ziz352i+vYVGgRMybtoWruq8=; b=PVHR2nY0MMYuGf668uELspapGf
	7nOaQqo8LtRhBp/dn/gI8RhlOcuhiOInxKF1ZGD3ik7RIX6zijluWeBYwr478zIL9BG1fS02t7Htv
	+f0sqAYuvOduUrYXqmAe0X8ZsCCMZw77VEHTfUiarr8v3CT1N/YpuD9vhXj1cN7EyCoA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xR8TE-00FksV-JI; Wed, 11 Nov 2026 14:34:36 +0100
Date: Wed, 11 Nov 2026 14:34:36 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, kuba@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sdf@fomichev.me, nb@tipi-net.de, 2022090917019@std.uestc.edu.cn,
	devnexen@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: phy: fix NULL link_topo dereference in
 phy_prepare_data()
Message-ID: <1fb006fc-aab9-456d-95c2-0e94df1dfb09@lunn.ch>
References: <20261111072146.3293821-1-xiaolinkui@126.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111072146.3293821-1-xiaolinkui@126.com>

> Reaching the crash needs an IBM EMAC device with a fixed-link node, which
> was not available here, so the fix is verified by compilation and code
> inspection only.

There is another way to look at this. The MAC driver might be broken,
it is assigning ndev->phydev, which it should not. It needs to call
one of the helpers that get to phy_attach_direct(), which sets
ndev->phydev.

Are there other MAC drivers which assign ndev->phydev?

This NULL pointer dereference can be considered good, because it might
be pointing out a bug. So we might want to keep it.

	Andrew
