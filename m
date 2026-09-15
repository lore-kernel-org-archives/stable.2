Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C125B2F4;
	Tue, 15 Sep 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475841; cv=none; b=QHYYRWKeDNxAeGjwmjEw4voNAXzIlCn4WLd9nhhK5LIBd1s4Q+pQA5HLwa6TqfJ10/6eXyzN4Ec+x5LDFnJvIX8J6L0UIUyrRnvygPPdcaxhfuk1CfR7c83QUaFKOSQmuTMKHByQ8SmYY++y1j2FwEEokvkBn7xYBgvaBbLyZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475841; c=relaxed/simple;
	bh=fnN1sj8oxpNX3SAnWaacVMDCfYcxGT1y/iY+83O2SUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcmVKXAUZa1aiV36djeKcFft/Jyry8qEswdV/6N5d0/Vg4+k03ea6MaRiuY1ApvBw9wgN3eD/Lm1juYZkNKtweZnzIQ42RsOCz/FiRNFQ2Hl1AaJ82wWfBh8PIQ0D+mm7cgcd07fBdVHnQtUEQQ386ZMUKab/j/nqBOjafkBAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W7GR/RNj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W7GR/RNj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j996zvvqMoODqxFqgltWJRyO5tLYKcpJCdsDyVsTL10=; b=W7GR/RNjZ9Pgmzh9nKUccvB4Ek
	7HQZGDmsQlnyNI5fMKKiGTVXCbjQ07JXKXnVmQU+p3kY1PKJDX+EnnGKXDPXHetSz4HKx3JLqZcOD
	jMUZvGklIBd1r5egq5dzjUSnKUiNHPTnjNu5IDzKZWLbR2foStvgvlksMnukXhdjVYOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6SPG-005Gxn-PF; Tue, 15 Sep 2026 14:37:02 +0200
Date: Tue, 15 Sep 2026 14:37:02 +0200
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
Subject: Re: [PATCH] net: phy: intel-xway: workaround 100BASE-TX Link-Up issue
Message-ID: <8768cdd3-e65f-4e74-9700-c21d642fa15d@lunn.ch>
References: <20260915085921.1354706-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915085921.1354706-1-alexander.sverdlin@siemens.com>

On Tue, Sep 15, 2026 at 10:59:17AM +0200, A. Sverdlin wrote:
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

Please set the Subject: line correctly to indicate net, and include a
Fixes: tag.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Out if interest, is there sufficient details in the data sheet to
implement cable diagnostics?

    Andrew

---
pw-bot: cr
