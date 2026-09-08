Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA2254A7ED;
	Tue,  8 Sep 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876409; cv=none; b=XMYlIYCBrdRP8ir5bMKiziklbJVWe41NQ3zw6MU5/e5VeI+6Yl+IF7TLtSetqn+NgpfZf6yTjVA9Ej9hLYMyz8IXr2uLVlNLzS+98WQpk+uEzHt7mjIf+v+FzW1pqC77AZTLN4VyqJqrxlzJEx1j1b8qoi4mSMzu6fpew73DYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876409; c=relaxed/simple;
	bh=nlw1n+Qam30svdA8271imhkhM/aU9BWN0kxR+6LiA4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unSXcL71fJoE6oPKhhOxlCH0jeLOK0ChWiZr27d4jHmwG6w5ASncpmE6kazmzr3+qy1WKvmLBNtHUwMBRHkeK5Wd/EJFUZij7kU+eUfa7XbpF5mhsg5xh5KEY/XMnT+0axE/n66P66BWkuKn5Q2RHx9Gv0zqtX6wTTO5k2EO8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ptz0uxC9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ptz0uxC9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZAV6al87b/Jcv3+638F2PpIExIpheZIpC5LDyk7c2l4=; b=ptz0uxC9Lwk4karYcKY7az9XDF
	CG0MMpwWc7/3UjFuwQ3T8xzDZRqDOeaC5y/Wz9s95bRFwuyjcKfrAXytWxXW2tieozYKAbHuZADOn
	Q0pyf8dogCyd3zsKRHzeHFQnZDsOxdS4BxnQ548ZZQvTXpv5pAp9sSBqkeSgBzYGT+aM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wSc-003uQZ-KZ; Tue, 08 Sep 2026 16:06:06 +0200
Date: Tue, 8 Sep 2026 16:06:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	daniel@makrotopia.org, o.rempel@pengutronix.de,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] net: phy: dp83td510: handle the active-high
 LED polarity mode
Message-ID: <42c4c477-8fcd-41b6-ba6d-e0ab382b01e8@lunn.ch>
References: <20260908105959.70453-1-donggeunyoo.kernel@gmail.com>
 <20260908105959.70453-3-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908105959.70453-3-donggeunyoo.kernel@gmail.com>

On Tue, Sep 08, 2026 at 07:59:58PM +0900, Donggeun Yoo wrote:
> dp83td510_led_polarity_set() only recognizes PHY_LED_ACTIVE_LOW, so
> PHY_LED_ACTIVE_HIGH falls through to the default case and returns -EINVAL.
> of_phy_led() propagates the error, of_phy_leds() drops the LEDs registered
> so far and passes it on, and phy_probe() returns it. A device tree marking
> a DP83TD510 LED as 'active-high', which leds/common.yaml allows and
> ethernet-phy.yaml references for led@N nodes, thus leaves the mdio device
> unbound, so phy_attach_direct() falls back to the genphy driver, which
> cannot drive this 10BASE-T1L single-mode PHY, so the interface has no
> usable link.
> 
> The callback initializes polarity to DP83TD510E_LED_POLARITY(index), which
> is the active-high setting, so the request is already satisfied and only
> the case label is missing.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5b281fe7e396 ("net: phy: dp83td510: introduce LED framework support")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
