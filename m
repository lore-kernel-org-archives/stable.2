Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562230;
	b=jKQiyZrWvuHQm7pf0s2T6Cnum+hP3YBTG4sSh6SGM4dqmD+t5hBGelFZ/GEyEmA8/w7v
	 /Fop9djlPpoatlfrLIALfilKQ6x5GRX44QWcbpTWEQYF2YLSKWejaIHNtf1MeMJ55x9tP
	 trpNstpOuhHiiAbl/DqYTcFoATd/O0JwOEdAPDJiP7jmmrUlVCQ39bFsydzWKzKBBKhjD
	 5mNe+lxBL8XEE7uyvyCWrpikNJkPEPK0GzWGw22spakE13MLMxypfc4QcvjMSCyEWuDP2
	 WazFF4Z1+976cjxwmuI2k6ZbUtOgSC1UgiAokWviN8txYueefrjfuUJA+Yx2BlVHUgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562230;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=eXZg4OtNyAdnGb6jvfUIQu7basWR+frN3rF2zFF8XoY=;
	b=mVRMegZOx8jkMF3Q91Oy8tayqTGm60CoU1dGW3siayq3fw/CGOl9v/BNC19bVLJCImVN
	 Jkvnm/hdboz+Z6ecEpll0S/pMrBPrQTWQWv0OIhCdJyL6ZXWq1bbDEabAIdESuOzBJGj8
	 6WmMRgVahvj703sABiPscdMSB+FghANJAGKPZz0JdGbbOVjhHp8+3nOGyGdgwsO/IUDdt
	 o9yFaEwRkZW2185cufPpo27IzpTnnjoSh/foJOrNpoENlw+lFOSfVyfgSegSCHMSN6l4T
	 oF8p54hbRvhl37WXsGT7gTRcyVCZVZLsv238JNdkt1AlvJjB8C2rxuiP5GezlVqhkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ejegZVbf;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7121606A324;
	Sun,  1 Nov 2026 19:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7121606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=ejegZVbf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eXZg4OtNyAdnGb6jvfUIQu7basWR+frN3rF2zFF8XoY=; b=ejegZVbfSrQIsj4DbPjatkpbyn
	jTO4woQ4gsJNmhDIU2diju2WT9y+Tams8Q4LmbqRCyEKGJxGct/Al74TCEnaAHO/gJzhnQhzmUzD/
	eYj3resewV3Rg+51vWmZallTovjtVtZXrKl2T2UmkxKOlfvW54Pok7lE8qn/Wm7g4wcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNbSj-00DfQM-2f; Sun, 01 Nov 2026 20:43:29 +0100
Date: Sun, 1 Nov 2026 20:43:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kalpesh Solanki <skalpesh942@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before
 dereference
Message-ID: <776e6791-2677-4bd1-ac00-4eef07d5a4a6@lunn.ch>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
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
In-Reply-To: <20261101092219.1278751-1-skalpesh942@gmail.com>

On Sun, Nov 01, 2026 at 02:52:19PM +0530, Kalpesh Solanki wrote:
> A virtual network device (such as a TUN interface) can have its link
> type set to ARPHRD_IEEE802154 via ioctl(tun_fd, TUNSETLINK,
> ARPHRD_IEEE802154). However, such devices do not have an IEEE 802.15.4
> private context allocated (dev->ieee802154_ptr is NULL) and do not
> register MAC operations (dev->ml_priv / ieee802154_mlme_ops(dev) is NULL).

> Fix this by ensuring dev->ieee802154_ptr and ieee802154_mlme_ops(dev)
> are non-NULL before proceeding in ieee802154_nl_get_dev(),
> ieee802154_dump_iface(), and ieee802154_llsec_dump_table().

Did you consider the other fix? Is there a use case for setting a TUN
interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
EINVAL?

	Andrew

