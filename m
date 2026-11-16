Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839854;
	b=B6zGlPjKUfglcM4x2+3uMwuYGvlib7DlVYWlznv0z4/WMOwal/Mf2JAP2UGWfDHhTUrk
	 OTjjBkEipGSO/4KDIgdIDA2QOcef4d78ivl8eJuj+9raZ08UhhaCQvyRhEe1GfDyNGV5Y
	 YKA8gyIApn891AkK7Bt+78hMukxVrfeOPk43JPtTld3MmMMJwug/gaU2Ssjrxow04S6Y5
	 8/f8oNZEwNDwdte1m+52OtrQSuxDbiIorm2SZsz7yjXDTLYnDVrTWqQ4StfeXVWJb3+MP
	 rzIzsT5wRkEgJqt7DSN0TSFd0qVIfHL0CtJtn+CxPkkS8g/HTNqFHzhqTNirg+frf3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839854;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=mJeLQgSQR6c585+OnRTLrz3aLLmsqMPrzGqWlEQ9tMU=;
	b=AuV/8xthwZF2kRoDIZubFZCxQD0SLephfuv9qfAqH4dKBkvidWQrduMrD8Z71OD0b2wi
	 QagsFXE46w/tZGdbi7/NPAlEDzhqVBhIjR6EKvLjGy9JT02btO0P8afFSz9B1DCHUs43x
	 h4drdC78iUzdQ+rQ+3ZdYqPSWjKGKuW0STH6/hAP00oeByQyIGcaHJJaqYOdanab3a9Vp
	 yhrvpKQX6maWFweVdIthHqclP9fL9dCH1o1UqvcPXSBCNq4i5H/RtOxSxjbXM+NZpcbfe
	 bIIv812JIy+kuvJLFiCgRELDTInRHj1lMhvtjFPhRJ7Gp2DZAZ0MugO5iyrpAsQYPJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kdPYqeFZ;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21519606A880;
	Mon, 16 Nov 2026 14:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21519606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kdPYqeFZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6EB91C4EFD7;
	Mon, 16 Nov 2026 14:37:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7157A6023F;
	Mon, 16 Nov 2026 14:37:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 478D611BC0BA0;
	Mon, 16 Nov 2026 15:37:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794839849; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mJeLQgSQR6c585+OnRTLrz3aLLmsqMPrzGqWlEQ9tMU=;
	b=kdPYqeFZxICkUypT+YwqNpM0KDvu1zvvTu+50gtmxz4duKX6XyKrYBlAFeK7ZG9P1HlhKo
	ep/qBBo/MqUXgWAJEVr/FeU/Gyb7bekwaj7zRsZjMKbZBSILKKQJrUvGKwnnL24lxd8Wr8
	SYy4591p56rBsSToCPEMsAA2i5q18/b6Ep1FlRzPXA5MMjJgQRuLyxKH/ze5KJ13jZApVO
	YnT6CjG4UPV/sAuWr8uaSBF9NeA/LduzIe4zVebqP+oBiUzmKxZeNnwvn0JCulzLv6bczf
	MYfWqL/wqRU6XPtuEtai5IJzAS4mtIocYRp/vwMlwKh3n7UL2+Wlz1RgFt35uA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kalpesh Solanki <skalpesh942@gmail.com>,  alex.aring@gmail.com,
  stefan@datenfreihafen.org,  davem@davemloft.net,  edumazet@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  horms@kernel.org,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  syzbot+9ea34da5ca6100593c90@syzkaller.appspotmail.com,
  stable@vger.kernel.org
Subject: Re: [PATCH] ieee802154: nl-mac: validate device pointers before
 dereference
In-Reply-To: <776e6791-2677-4bd1-ac00-4eef07d5a4a6@lunn.ch> (Andrew Lunn's
	message of "Sun, 1 Nov 2026 20:43:29 +0100")
References: <20261101092219.1278751-1-skalpesh942@gmail.com>
	<776e6791-2677-4bd1-ac00-4eef07d5a4a6@lunn.ch>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Nov 2026 15:37:23 +0100
Message-ID: <878q2ssuzg.fsf@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 01/11/2026 at 20:43:29 +01, Andrew Lunn <andrew@lunn.ch> wrote:

> On Sun, Nov 01, 2026 at 02:52:19PM +0530, Kalpesh Solanki wrote:
>> A virtual network device (such as a TUN interface) can have its link
>> type set to ARPHRD_IEEE802154 via ioctl(tun_fd, TUNSETLINK,
>> ARPHRD_IEEE802154). However, such devices do not have an IEEE 802.15.4
>> private context allocated (dev->ieee802154_ptr is NULL) and do not
>> register MAC operations (dev->ml_priv / ieee802154_mlme_ops(dev) is NULL=
).
>
>> Fix this by ensuring dev->ieee802154_ptr and ieee802154_mlme_ops(dev)
>> are non-NULL before proceeding in ieee802154_nl_get_dev(),
>> ieee802154_dump_iface(), and ieee802154_llsec_dump_table().
>
> Did you consider the other fix? Is there a use case for setting a TUN
> interface to ARPHRD_IEEE802154? If not, maybe return EOPNOTSUPP, or
> EINVAL?

Sorry for the delay, I was away for two weeks, but I definitely agree
that I (we?) never intended to add tun support for WPAN devices. I don't
think it really makes sense anyway. So yes, preventing the 802154 "TUN
type" is likely the way to go IMHO.

Thanks,
Miqu=C3=A8l
