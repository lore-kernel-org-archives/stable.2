Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062477;
	b=ngAwCTJ3x/hOsjU6KfCiRtNLO+cnM/mEf+/+c6sP6+0Ij6Bwc8Q6MRQz3+Cbv8htigeG
	 F3+ChjqZ6vrB4bnppBJxcsJ+/vVi3g+6dq2oUWji1cR0CgTiNiNx0vSo+u69dXCHcZx/I
	 gOgiw8aij0+cGwTOGAdLBBbVtsTwuK9rJsy9MwkYpR63RPouc8uu7Syzf4SYyt0FsSfBS
	 Cwc3ldCr5v5/XU2NTgafqLoDASu5l/Yc5LVchEK/qvMoVZBb5K0f7zd3QDBApqml38rNJ
	 Muxpz9Z6HhxwL6hXdKeqjPBcBMKxG6lL5RpFKLE28xLhl5aDQ79xERnxv+cDv2oZCTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062477;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=MTKqzeN2qzSEwB7wgpPDqmDOm1XJz5MFsmhF4czrNrI=;
	b=N9/oimPhIKZAihwbnKUqnL+Z0kFf65FNRmsKRu9B756NDyjnS3A8QY0SgnRCQGd7GwGr
	 +QUnwAUv96CQyQNOipA/sX+pwuSUJWgiRxuby4dt4SujRZIJA0KZOHWPVRy7/9LQ+HBUk
	 rl79FtlvlD4JDQNO5C9hj+0/22EQB7qF0y6TJ4JxAHswY5L9+EZRuyfvLfJ1fOp9Fk9hZ
	 qg7PGKBsKCBtxEfvuVtMDyr3kYB7/l79hDmHLrkl5pJsgP7L0oTznaIW0RINge6VRyDFz
	 65mkFDYu1ZATlbc0Dr2RrECn748cUmIwjuMwlhhCcklhhiK3GfXA2iaOKIRJmHsPG/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=AKfQpOEc;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E517606D822;
	Sat,  7 Nov 2026 14:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E517606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=AKfQpOEc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MTKqzeN2qzSEwB7wgpPDqmDOm1XJz5MFsmhF4czrNrI=; b=AKfQpOEcyMJuFY5WDsAYJCTPjL
	pgnw4g5N7gDR3sRbLbFgG73J6zge7zNIO0U5Km4Qo/IoKiabt/e8uLUdTA7R2zZXc/s+9IS57fvvF
	72zVqn2IdV6MrKoyzu9pOjZqKdtb5zyu7j2UkFKUk67ed7AEm0Dh+jLxuLdUY4pItdnHYV8H1Tev5
	vD+2hx89y6foUzJmwrEnK7jzdalIL2ZDOVxos10lo20RajGCi5S8fwui/nYnLxiTYpETen3FkgD0+
	f2wq6OjDIi1cpxq//uoGJdNTDNcF3XxMPt37xeImwXJZqfUKmYQx0vNtV0j1Hj+XlF3mdU7+Hu8F8
	tZjG+fog==;
From: Heiko Stuebner <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel <kernel@pengutronix.de>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Cunhao Lu <1579567540@qq.com>
Cc: linux-can <linux-can@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 netdev <netdev@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
 stable <stable@vger.kernel.org>
Subject:
 Re: [PATCH net v7 0/7] can: fix bus-off restart and device close races
Date: Sat, 07 Nov 2026 15:40:55 +0100
Message-ID: <6105577.1B3tZ46Xf9@phil>
In-Reply-To: <tencent_B3369A1199D0849091BB8015C41BBFF0A607@qq.com>
References:
 <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
 <16255046.uLZWGnKmhe@diego>
 <tencent_B3369A1199D0849091BB8015C41BBFF0A607@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Samstag, 7. November 2026, 03:57:26 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Cunhao Lu:
> > > This series depends on the three patches in "can: skb: make CAN skb
> > > freeing safe in any IRQ context" [1] and the three patches in "can:
> > > rockchip_canfd: fix TX stalls and races" [2].
> > >=20
> > > [1] https://lore.kernel.org/linux-can/tencent_CD05F020BAFB2537F5D1F4C=
BB425588EA80A@qq.com/
> > > [2] https://lore.kernel.org/linux-can/tencent_E25C9BE6689264E4138A464=
803B810FDFD09@qq.com/
> >=20
> > Both these series are from july and seemingly from before you started
> > using the b4-relay. So they may or may not have survived the kernel
> > releases and their threading is broken both on lore and in any maibox
> > they arrived in.
> >=20
> > And if there haven't been any responses to them since then, I'd think
> > they have been lost or so.
> >=20
> > So I'd suggest rolling both your dependencies forward on top of the can
> > tree and sending them as a new version, so that reviewers can find them?
>=20
> Thank you very much for the guidance! :-P
>=20
> I just checked: the "can: skb: make CAN skb freeing safe in any IRQ
> context" series was merged into mainline yesterday, so I won't send a
> new version of it. I'll remove its link from the cover letter.
>=20
> The "can: rockchip_canfd: fix TX stalls and races" series still has some
> issues reported by the bots during submission to the net tree that I
> need to address. Since those patches overlap with this series, I plan
> to fold them into the next version (v8) and send them together.

As that series is also "just" for the Rockchip CAN driver, merging both
sounds like a good plan - especially as it makes it easier to keep track
of things :-) .


Heiko


