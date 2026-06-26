Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D393FFAAA;
	Fri, 26 Jun 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490338; cv=none; b=GYRn9/0rebUkpj1oWoLdIxTT6mKIu550QBf2n9tmb7g+W331gvXIOhIHO50J+/C+cPEYbiQyvKyHUPmU2KWoAdK+Q3eaOq28+QAwxwLDWbFIdfJP07uIhPGFrDatToSTf7PzcUGr1RdTudBi/5hDTDK/RbmbUXFZ48aeJyhP/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490338; c=relaxed/simple;
	bh=UnfWeBJE9qWardTh3ZWICGyqoW933As04tJPSFuFgU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAX8f0wShWMjtdB3nKJfTUAXg8y4gQip3Nqyu/V9Slu8ULJfxMAQ5TgvYPyruLQk6D3enJ0URJjlndcy4c1Hhwd8Ek/bEneO81fq5Zk6hajlA5w2ugJ4oDIU3hIW0rM7406JtslAf49QjKk6L0tHVVunf1OajLQtr4r7cEEA6nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cupxrwo3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cupxrwo3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o9Rylrd0yB6wm96yBWqeZ1NB9Ha5dTiEZdM6gjx8KlQ=; b=Cupxrwo3q7HKxXah4HMTaNSDk2
	UiRrCC1HNnqRaQ0kBIcIo3cKEAcVoaJg6J2cZHwN8sT9SkfJXUaAwbdrfpZpFyzXe6QUnWpr0TDWf
	UOVpKhqgbe74dR9tntbivbYuf8dtvExDMznQtzwHO9eFkAtf8inCye4SfYbDz+euXjmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd99x-009OGv-MF; Fri, 26 Jun 2026 18:12:05 +0200
Date: Fri, 26 Jun 2026 18:12:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-omap@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: ti: cpsw_init_common: fix excess of_node_put
 on parent node when   cpts child not found
Message-ID: <52d1d43a-efff-40f4-b111-a90f0cdc2ffa@lunn.ch>
References: <20260626152945.52192-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626152945.52192-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:29:45PM +0800, WenTao Liang wrote:
> When no "cpts" child node exists in the device tree, cpts_node is
>   assigned cpsw->dev->of_node without taking a reference via of_node_get.
>   The function then unconditionally calls of_node_put(cpts_node) at the
>   end, causing an excess put on the parent device node which can lead to a
>   refcount underflow.
> 
> Use of_node_get when falling back to the parent node to ensure the
>   reference count is properly balanced with the subsequent of_node_put.
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3525eda4c4 ("net: ethernet: ti: introduce cpsw switchdev based driver part 1 - dual-emac")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr
