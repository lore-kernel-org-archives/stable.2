Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C48373BE7;
	Fri, 26 Jun 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490221; cv=none; b=AwR5aGpdTZEiJiR87zF77mpRMgAHpXsP2Gw8m4BdXMcY3y2luzZKBZ/9vCArHC2PeRT4y/yqJdV2QIfg4lE9eFFsa8arFlmdM/+eMJ5lVlWhBkf7rMRezMDuFfjwklrTeu7JZTXyFV38DhksB2UrESjnxbF+KGeyq6iH2Pg6Le8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490221; c=relaxed/simple;
	bh=jM0fxqGdN3P1GRFOqvJj8Dwt0iyeQLQRZCEcZ8CaIGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0wtvO5wwXKZbuuRT4Huhl3SphO5hR2ym9kpWv6U7RQk/T55r0pexhL2zOOB4ZsyWnUsrK5zE0nVm3xU60mga4AAxnqOLB0eRnkBigJBoFh3Bou8gO+xfQmFNPCPTu+uonCZJ8W0k9oO3v4wSE5pJ1R4AqMbwPNBl7RqtrBTco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZwJG6c54; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZwJG6c54"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LqTmciX5H0Eo9RMsPQbpjVewR3Vqa3rOZ1Ov7e2wKPY=; b=Zw
	JG6c54b7NeCbaLn2bGVxYPD5LPxalaTXM3AfBxDQSS6sPYoCnAeYN6UotAh0IvIIrNUmzBqUZE3Lp
	LZ3zOJiKgb1YW192TEa/yAwujtR0wS9xve+iFkqmT19qewRqfaxRhYl/NYm+8Yxle+Svhz2ZB8cE2
	y/SdkO71A5Mgets=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd983-009OEP-Il; Fri, 26 Jun 2026 18:10:07 +0200
Date: Fri, 26 Jun 2026 18:10:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fix: net: renesas: rswitch_mii_register: fix double
 of_node_put after   of_mdiobus_register
Message-ID: <fdb2120d-5d0e-445f-97a5-ef2307ebd4d1@lunn.ch>
References: <20260626152430.51835-1-vulab@iscas.ac.cn>
 <20260626152550.51911-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626152550.51911-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:25:50PM +0800, WenTao Liang wrote:
> After of_mdiobus_register succeeds, the mdio_np reference ownership is
>   transferred to the mii_bus device (released via fwnode_handle_put during
>   mdiobus_release). The success path calls of_node_put(mdio_np) which,
>   combined with the automatic release via bus teardown, results in a double
>   put and refcount underflow.
> 
> Move of_node_put so it is only called in the error path where
>   of_mdiobus_register failed. On success, the bus driver manages the
>   reference lifecycle.

Please stop with these patches.

First please read:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and

https://docs.kernel.org/process/submitting-patches.html

You are getting a lot of things wrong. 

* don’t repost your patches within one 24h period
* Don't thread new versions of a patch to the old one
* Include version history, how is v2 different to v1
* When you see your own patch is broken, reply with NACK, and explain
  what is wrong with it.

Until you learn how to correctly submit patches, please only submit
them one at a time, get it accepted, and move onto the next. Otherwise
you are wasting peoples time, and getting yourself a bad reputation.

     Andrew
