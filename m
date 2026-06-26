Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5F3F99E5;
	Fri, 26 Jun 2026 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490297; cv=none; b=ReSD/xsm46pV9ByRQMA5gyn2CCIZaQGXijHdlBMvfRQ5H8tQnmAJJQZaI+ZUEL4iVY00CrgamkKuBkUvr/HkItKYOQPNSWyVOPY1l3pkUQbHmF0qUxySu1qD6fszwxxoyULyqfaeUHTfKo2LU/30o/R3/26+C+2HlYRNE2DirGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490297; c=relaxed/simple;
	bh=v/xtA6lKsmOo4sGuIQCBILfM1fTqp2X4TK4qOq1hJYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncqk/feD/ey7vVX+PeS/g0YJCsHiNlIGHbiqIVRpLew//8Mt3K7pryv2w8Eric/0rJvtQ/JEVFhcuUc+PRYO6KdD++w861EG/rw26ldnsrwAJDr9d65DTPxZQCPxtUqIKuTGKBcSxgu69fZsWJaJII4Kvs+ns6Y/mCnvcCxOX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sio4tBw2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sio4tBw2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KvTW42MNJMvmiaxA36D15Hj/y7V1IlN7NJdDL8uPPds=; b=Sio4tBw2XzlIAwKnA2dOP+7mXy
	bxIcI+UhhGjLIkLPxWk7S0zy84J/XyffKZ38xEcWXmsog4gBB4Vejx8OFutdRINaKEVt5F3y3ruli
	25lu+yUqUUzGTI1NAq+3uNQsQCu1q3qgp0915Iqkm0SOXVnW20PpHG44qJZcZ+YTh3lw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wd99K-009OFF-Lj; Fri, 26 Jun 2026 18:11:26 +0200
Date: Fri, 26 Jun 2026 18:11:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix: net: phy: phy_sfp_probe: fix kref leak when
 phy_setup_sfp_port fails   after sfp_bus_add_upstream
Message-ID: <e8f1d4b5-ddf3-43ab-a324-8325582b2d20@lunn.ch>
References: <20260626153443.52842-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626153443.52842-1-vulab@iscas.ac.cn>

On Fri, Jun 26, 2026 at 11:34:43PM +0800, WenTao Liang wrote:
> sfp_bus_add_upstream unconditionally acquires a kref on the SFP bus. When
>   this call succeeds but the subsequent phy_setup_sfp_port fails, the error
>   path returns without releasing the upstream reference. Since probe fails,
>   the device's remove function (which would normally clean this up) will
>   never be called, permanently leaking the kref.
> 
> Call sfp_bus_del_upstream on the error path after a successful
>   sfp_bus_add_upstream to properly release the upstream reference.
> 
> Cc: stable@vger.kernel.org
> Fixes: 298e54fa810e ("net: phy: add core phylib sfp support")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>


    Andrew

---
pw-bot: cr
