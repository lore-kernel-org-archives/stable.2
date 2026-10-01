Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73D492E30;
	Thu,  1 Oct 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856109; cv=none; b=KU7U1cyve0gU/9OBDENhbanbyN8n59AFX+tXqyDFpHS1MAPAc9gWhNY9kx4LrO2IUZITz3knecxsdA9gv+xqiHyzaSdgsC4zAsZ8AnDy9NhYm5G/bNhTvbCKEGPpCEp6u3pl0pGz2Ad3x2icT+2mYPEQWIHIyoUsc7adZgVHphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856109; c=relaxed/simple;
	bh=QH58pptm2vo6sm9BMiv50pbTTzjRmT7G88Qy8myJwTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZVIbUR5Qf/dnFmaANf/iAWVZYV2mzd5Uznf6Y4k0v3k2/RwwJrgX08oChD5UPc8Mcp/rZDH3HjGYlCRiTTk39LxjnVamu8DU7dlsyFULMG/N1yg1FpHvRqRfi6jC1MR8iPjYgRBC4zE8H6wpU6iH+I4O354tFROe4DFrr/l9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AK04FKc/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AK04FKc/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+1BCVWIwlmaUGWsBfIoqleqHXdDsbUwGvLwxVqUvoB4=; b=AK
	04FKc/MyG4PWRy4Y68c5NK8ujkCeGVZGME3PH5TrXVxBU7WlKncC2ir6X/dIamMcJV5m/yQzoJ4iU
	Q7HbwLMJZ8agJfL2V47C44gAty7jWINLzQFHi6/Zfl7gEeX3zT13jOXQNzBTeYXzDWzjKci2tRZA0
	dNgA2vGr7vXCLRg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCFTc-008N2J-NS; Thu, 01 Oct 2026 14:01:28 +0200
Date: Thu, 1 Oct 2026 14:01:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xiangqian Zhang <zhangxiangqian@kylinos.cn>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: mii: Fix unknown speed after link up
Message-ID: <2527117b-cb67-4325-9717-fbed352360d4@lunn.ch>
References: <20260930113842.2640928-1-lilinmao@kylinos.cn>
 <e31a9b2c-2f65-4767-b66a-85676d5a0d5c@lunn.ch>
 <0f0a9d6c-2a3d-4414-b5d8-c960085f0b3c@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f0a9d6c-2a3d-4414-b5d8-c960085f0b3c@kylinos.cn>

On Thu, Oct 01, 2026 at 10:09:00AM +0800, Linmao Li wrote:
> 
> 在 2026/10/1 5:47, Andrew Lunn 写道:
> > On Wed, Sep 30, 2026 at 07:38:42PM +0800, Linmao Li wrote:
> > > mii_ethtool_get_link_ksettings() reads BMSR only once. Since
> > > BMSR_LSTATUS is latched low, the first query after link up can
> > > report SPEED_UNKNOWN even though the link is already up.
> > > 
> > > This is seen with r8152, which detects carrier using a MAC register
> > > without clearing the BMSR latch. NetworkManager can then keep
> > > reporting 0 Mb/s until the next carrier change.
> > > 
> > > Read BMSR twice to obtain the current link status, as mii_link_ok()
> > > already does.
> > There is a reason for this latch behaviour, so you should not ignore
> > it. It ensures a link down is reported, even if it is for a short
> > period.
> > 
> > I suggest you change the code to detect link based on BMSR, not a MAC
> > register. Better still, throw away all the mii code and port it to
> > phylink. A lot of code will go away because phylink/phylib and PHY
> > drivers will implement it.
> Hi Andrew,
> 
> Thanks for the review.
> 
> The existing read in mii_ethtool_get_link_ksettings() already clears
> the latch, but I understand your concern about preserving short
> link-down events.
> 
> For a focused r8152 fix, would it be acceptable to read BMSR once
> before netif_carrier_on(), only when set_carrier() is transitioning
> from carrier off to on? This would retain the existing MAC-based
> carrier detection and clear the latched status before announcing
> link up.
> 
> Or would you prefer changing carrier detection itself to use BMSR?
> Could a phylink conversion be handled separately?

I would prefer the carrier detection be based on BMSR. However, the
current code is based on interrupt URBs, and it is not clear if you
will get two interrupts. You need to test that first.

A phylink conversion can be separate.

  Andrew
