Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628028;
	b=A+t79mEI8v9jthhAuClVgdQTV4Zp0sgp4wUmGGCKUCa5qPEpvAA+qOukdNkAiwb+qISa
	 /wjxP4Lmvr479XT5ddL9qETg7xzpoMwMN6zcIEyY6KoQSKoKPgGYDbL5uRHNEH7u9k1V5
	 EY3bc47NXmBAmwFtFsw5I02O1Dd7gan5aTZGB/dWUON14ILklEtVfw0WfuGVAe97NuMnG
	 Mbbm5TqJvn9XmctTGjkwhulgTyjPD8gPkvwnlaAPuATx5O2Zaiz9T3tEeV9+cvm1kBBPL
	 Z7l+GVf+dIDt/2DN1KWrVxc6qtaQu6JhgsFFibSCVmBwRR4VRx93ySty3yVapo3lauA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628028;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=2pMvQgzqKW4JHpA5fJ7fTyK99AJQvYuqkYywOmupdlI=;
	b=WwHgrCI8PeloCe891rRuVMUitYiOOLUMFnLVCZmu54fyujt25HEFxWa3GdGk1AC0lplj
	 Xe5Xd5WCvAAyHKxWFRY/GzEi+8pDH7LF+8ziA1cFzX8VXxXCsrcldO3oULvMTlxddP9ay
	 2Ou7sOHunkqIMZ03j03A+Tr28TteNYYLsnXV9fh4lqshb7DDnscfrfJiZEG32HWNi0vvP
	 Z4TjBM9+F/Wems44D849gVDG2W91/fLBdKYrvVG2XXKucHgZyAC2RK/FBIpLwZeggVKIY
	 rgh0Xp/hVzdixmoCfjRswWRBoR4Sv03xQ0ApBc0xiF9rs6BXTcuvjDUU0kwGp8hw7SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QzSZVLpB;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCE606A32F;
	Mon,  2 Nov 2026 14:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45CCE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=QzSZVLpB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2pMvQgzqKW4JHpA5fJ7fTyK99AJQvYuqkYywOmupdlI=; b=QzSZVLpBZ+yBBFUabsSXv7RsM3
	lC1XiEmly6EqfPxp77xnAF9C7vRLCMkcYwJZdX8cDftwTetzlIw8HTV3VPR9xsTRXzjEMO8prDBp5
	U3E14cQTmztTvFGei7hyNLSYGAuVrbPgeQvJKZMsrpMVKq2JZiCx84JpBRf28fcEVlYs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xNsa3-00Dnuc-14; Mon, 02 Nov 2026 15:00:11 +0100
Date: Mon, 2 Nov 2026 15:00:11 +0100
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
Message-ID: <3eba5c55-e1ec-4301-ae09-a3982090d8b0@lunn.ch>
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
 <20261102024721.28129-1-skalpesh942@gmail.com>
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
In-Reply-To: <20261102024721.28129-1-skalpesh942@gmail.com>

On Mon, Nov 02, 2026 at 08:17:21AM +0530, Kalpesh Solanki wrote:
> On Mon, Nov 02, 2026 at 01:13:xx +0100, Andrew Lunn wrote:
> > Did you consider the other fix? Is there a use case for setting a TUN
> > interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
> > EINVAL?
> > 
> > Andrew
> 
> Hi Andrew,
> 
> Thanks for reviewing and raising this point!
> 
> Regarding whether there is a use case for setting a TUN interface to
> ARPHRD_IEEE802154:
> In real hardware/subsystem usage, virtual 802.15.4 interfaces are typically
> handled via mac802154_hwsim or fakelb (which properly allocate wpan_phy and
> dev->ieee802154_ptr), rather than raw TUN. However, tun.c explicitly recognizes
> ARPHRD_IEEE802154 and ARPHRD_IEEE802154_MONITOR in tun_get_addr_len():
> 
> 	case ARPHRD_IEEE802154:
> 	case ARPHRD_IEEE802154_MONITOR:
> 		return IEEE802154_EXTENDED_ADDR_LEN;

I looked at the history. Those two were added along with a bunch of
other ARPHRD_ values. There is nothing i could see to indicate
IEEE802154 was a deliberate choice. So i think you need the IEEE802154
Maintainers to comment on if this is useful or not.

> 1. Subsystem robustness / Defense-in-depth:
>    ieee802154_llsec_dump_table(), ieee802154_dump_iface(), and
>    ieee802154_nl_get_dev() assumed that any netdevice in the namespace
>    with dev->type == ARPHRD_IEEE802154 has valid ieee802154_ptr and
>    mlme_ops. When that assumption fails, it triggers a NULL dereference
>    while holding genl_mutex, leaving the mutex permanently locked and
>    deadlocking generic netlink system-wide for unprivileged users.

Which is good. An Opps with a splat makes it clear there is a bug. If
anybody cares, it will get reported and fixed.

Subsystem robustness / Defense-in-depth generally results in bugs
being hidden, rather than exposed.

The fact ieee802154 has ieee802154_ptr and the code unconditionally
accesses it suggests it is actually needed. So the commit message in
your change needs to argue why TUN is special and does not need
it. The commit message is all about "Why?". Why did you decided to fix
it this way, rather than some other way.

Is the correct fix to actually set ieee802154_ptr to something?

>    Other parts of the ieee802154 subsystem already make this defensive check:
>    - net/ieee802154/6lowpan/core.c (lowpan_newlink):
>        if (wdev->type != ARPHRD_IEEE802154 || !wdev->ieee802154_ptr)
>    - net/ieee802154/socket.c:
>        if (dev->type == ARPHRD_IEEE802154 && dev->ieee802154_ptr && ...)
> 
>    Guarding nl-mac.c ensures the IEEE 802.15.4 netlink handlers are safe
>    regardless of how an ARPHRD_IEEE802154 device was created or modified.

Now look at the history of this. Does the commit message adding this
code suggest why these checks are there?

I also wondered if IEEE802154 is special? struct net_device has:

#if IS_ENABLED(CONFIG_VLAN_8021Q)
        struct vlan_info __rcu  *vlan_info;
#endif
#if IS_ENABLED(CONFIG_NET_DSA)
        struct dsa_port         *dsa_ptr;
#endif
#if IS_ENABLED(CONFIG_TIPC)
        struct tipc_bearer __rcu *tipc_ptr;
#endif
#if IS_ENABLED(CONFIG_CFG80211)
        struct wireless_dev     *ieee80211_ptr;
#endif
#if IS_ENABLED(CONFIG_IEEE802154) || IS_ENABLED(CONFIG_6LOWPAN)
        struct wpan_dev         *ieee802154_ptr;
#endif
#if IS_ENABLED(CONFIG_MPLS_ROUTING)
        struct mpls_dev __rcu   *mpls_ptr;
#endif
#if IS_ENABLED(CONFIG_MCTP)
        struct mctp_dev __rcu   *mctp_ptr;
#endif
#if IS_ENABLED(CONFIG_INET_PSP)
        struct psp_dev __rcu    *psp_dev;
#endif

Did you look at all of these? Can any of them cause issues in the same
way as ieee802154_ptr?

Something you learn after a while. If you find a bug, look around and
see if the same bug exists close by, because it often does.

	Andrew
