Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101553;
	b=ITNTDJoEAu056qyc/oQMKezsMyq92wiEduQDE2bvPGBx+PzQjcgqaxAae6K83scAz/Y6
	 OC2Onr/3YFqqlq5FPljBjOiVINKaCNoWlHLtXR1+X56FoorFWeIdY3i1okqHC4jAXIeo8
	 6IB2SP02Iw0JaYyEMVpKWX8OUjaVpV8i5YjVqt8gS+WqvOHjUYEF8cj7TsPtmNuk42xi8
	 pQIQbY1r0lMyp+SngbF1ZslO2aUUlqkqj/ifqRmAbFz6B7+635xUKeU7U929C/8auGnHG
	 kU1TMe8nwvUgM4y5SV/+jiqlkEn3dlnqmT8twTOp1wNlNP4NwBiRV8d6nYPO0ZvUoHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101553;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ECrV0gi2Y6wf3ZJ9yS8kBi1Aams8XEvdCePJJ8gqujI=;
	b=p5L4SlMK5zrPT004LWVFQq3af7kAnXfxSo1zLcN7a80CKSUKGYj+eg7Y7ofudoj/9iAa
	 NGYG4lcK0jF7Wwzyeqx5YMO/+/N4BburVwEk57zIMhISUu4kmC+O65bhvrrpK5aNr3Pna
	 O9WPtU0rfynGKuFSZx1MArX59lrEvtSwKHLK4DLCwet7pmYzddgK+51zgzlyS4ARksuFk
	 6SmAOqi0xK5/P77lk0TPkFh92BJQmp8SkmmZwxE3XS1ScfDZggTicjymph2uyeVUeClGo
	 0RxkWo++klukjXGJmCSRJreJZVCvVufYkGZVo8XLyFlbIdd3aTBSWUUg2XklACEBZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kXHG49xI;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED68606A320;
	Thu, 19 Nov 2026 15:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED68606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kXHG49xI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ECrV0gi2Y6wf3ZJ9yS8kBi1Aams8XEvdCePJJ8gqujI=; b=kXHG49xIlSzvygzBv8mcM8VI94
	ra7JV3DBdiPGRmvrpon1/VAaI8ZRpHSCB+U3HvZtubBYE+i/W221bWCzu2smt4huBScifQ9hiPF0s
	HrB7D1EBNBh4zPTXBD2MWX92eq90+sqvFbta4rWzMyT1+KVgiIfK9ITmrn7sv7IH8ubI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xU3ui-00048Y-9e; Thu, 19 Nov 2026 16:19:04 +0100
Date: Thu, 19 Nov 2026 16:19:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: blake.alexander@airbus.com
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: do not override PHYIDs on
 external MDIO
Message-ID: <d2feec60-232b-4aeb-9da2-8912dc9ee6ef@lunn.ch>
References: <20261119-mv88e6xxx-fix-v1-1-2db604f3516f@airbus.com>
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
In-Reply-To: <20261119-mv88e6xxx-fix-v1-1-2db604f3516f@airbus.com>

On Thu, Nov 19, 2026 at 11:50:00AM +0100, Blake Alexander via B4 Relay wrote:
> From: Blake Alexander <blake.alexander@airbus.com>
> 
> Some variants of the Marvell 88E6xxx family (such as MV88E6390) support
> an external MDIO bus (in addition to the internal MDIO bus for
> configuring internal PHYs). A typical use-case for the external bus is
> to configure PHYs that are external to the switch. On switches that do
> not assign a PHYID for internal PHYs (i.e. the value is 0), the
> mv88e6xxx_mdio_read() function traps read calls to the PHYID registers
> and sets the PHYID equal to the family ID of the switch.
> 
> The mv88e6xxx_mdio_read() function is reused for both internal and mdio
> bus operations. The PHYID overwrite trap does not check whether the MDIO
> bus is internal or external and wrongly modifies the PHYID of devices on
> the external bus when their PHYID2 register reports a value of 0. When a
> C22 device reports a PHYID of 0, get_phy_device() will reprobe the
> device as C45 and if successful create a C45 device. Overriding the
> PHYID in this case will prevent a C45 device (such as Aquantia AQR115)
> from being reprobed and their driver will fail to bind.

Ah, my bad. I added this code. I did not think an external PHY would
return 0. But at that time, C22 PHYs dominated.

> This was observed on a development board during the bring-up phase. The
> board included an MV88E6393X with external AQR115 PHYs.

We probably have not seen this before because most Marvell switches
are paired with Marvell PHYs.

> Fixes: da9f33018e2c ("net: dsa: mv88e6xxx: Workaround missing PHY ID on mv88e6390")
> Cc: stable@vger.kernel.org
> Signed-off-by: Blake Alexander <blake.alexander@airbus.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
