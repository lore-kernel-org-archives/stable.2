Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19834414403;
	Tue, 22 Sep 2026 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079746; cv=none; b=lZ5hEqBtSGK81UAZK1Mm88zCGqlrX+kfda8TCLMSihk9xGdRnF5ujcOKu5hIj40kuY+mLp8sHN5Z4XaqsJjg36jRwww8+ZXjgK9SWaViZ6SOcB14G07S/VRWtgullh8gcUjmCtP2yXLcvh2tdN1E2Y7v7xE5jHzG4CZEmtuY0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079746; c=relaxed/simple;
	bh=3afR1Bzq8XcFa8cMu2H6ovUOMUTvAmf6actyawrW4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmgQo9Uxlg8VVoHMFbC7yXQFCGkwWYMBnF5byjIil7XvYVcETmK+aUCTHfiZnauZlC+TNPqKrizBLAgsjjAGpOqGnPlMsT0Ohy7b+8Legbtvrv85HKRl3dybuF7nYfjuP8zk83f/pqzOA7jJ2ML2vVaBat1iBo2XwV+9FdclLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ee5Lpe9m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ee5Lpe9m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1iAbemXqGoGWsW5gQyZwmNgUJE4W1FWwNo+eaphdyp8=; b=Ee5Lpe9m6PAPfwOOrR/92xrovr
	MwIrl7+7fWEH027M5odknv31cIDrAF/wXBg8KicB/lDnbGBgTghCMc5L3cKB6JanDO1FXbGD9sQUf
	tGah2cLhqFjZlldLhIzFi0Tt18daB8nLGDTXetzowshn6h9fOLWPbDhibP/4X4Hj+ZPE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zVf-006aJ1-G9; Tue, 22 Sep 2026 14:22:07 +0200
Date: Tue, 22 Sep 2026 14:22:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	John Crispin <john@phrozen.org>, Hauke Mehrtens <hauke@hauke-m.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: intel-xway: workaround 100BASE-TX
 Link-Up issue
Message-ID: <38ac8f1a-3024-48bc-9f7f-9302bd8e9acb@lunn.ch>
References: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922075251.23386-1-alexander.sverdlin@siemens.com>

On Tue, Sep 22, 2026 at 09:52:46AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> MaxLinear GSW12x/GSW14x Ethernet Switch Errata Sheet states:
> "An issue has been sporadically observed after device power-on on the first
> link-up attempt in 100BASE-TX mode resulting in either the link-up taking a
> long time, or failing to link-up altogether...
> 
> Workaround:
> After power-on, enable Cable Diagnostic Mode for all ports and disable
> it..."
> 
> Implement the proposed workaround unconditionally in the Intel XWAY driver
> (MaxLinear GSW1xx switches incorporate Intel XWAY PHYs) because the
> diagnostic bits have the same meaning even in older integral PHYs such as
> GPY111/PEF7071/PHY11G. So it's not clear how to distinguish the affected
> newer integrated PHYs, but the workaround should not hurt the older PHYs.
> 
> Cc: stable@vger.kernel.org
> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
