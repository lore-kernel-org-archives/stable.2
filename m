Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969442;
	b=ka3R3c9OeI6EbTSVetNT2tUUma7MTqUS4OhKhwWzRIJPuwWLs0sphYq+2Lp71Y4TYGcy
	 aTYoG3wcRWjcBWGfzp2vo8m7tBPxbPj8SpJFpiFMT+ZGj5ViDglybXt8IJ4e9ILJxDioJ
	 UivAbLZm3b2LkfqPi//tVM7j25hjw49LePfc45sTR2Hgaei2yVNqasGcRgql2KjgRFHsS
	 PUT9kJ0ZleBjCaYyu5Ap9h3biAaEBk2M7d0fqCqhkVbQt5AZk8FUni1blq+vlH7c3Ddt+
	 SIi0mxJqjvWExUApXB4Y/BrhzcUEtiwrWrb9z5bN8raQ1o8MdgRv46TsfV7sNo2jWHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969442;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=FBjIBgDWbZCo9SaA6U+cSq8TU+erFs29CF/2hr/QbOQ=;
	b=rs33cMiQ4p/3lauanmdpOydODjrRuRgHmZwDoeDe4hTrEJYR1GtilB8b70yZ9gtMzjkS
	 h+fw02flY3XVQIjg4ifO6RpydDT8AjNnXp1Z6fXaTojDpcaSEAHrDBnP0Xmu6pMM/x79u
	 oeP5nUXw13XL9f3PcKyzy/jv9h7UbQAa0Jb292aEHttURjm/MxX3Khd6QIe7Tlq6ynpLW
	 coPWkuafxbomvE+eTA4ogrvCGsaDSk+6D9tF6N5I+vF+tOpEpcmVfdgj0yQJKjB27oP9s
	 45YD63jPs3ncn6UybHHfgUm2LkGGAxp59AHJK8BvFqCsvqT7l6GHAgWUkKuKKnrMBjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=WHEv8Bmz;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A1606A330;
	Fri,  6 Nov 2026 12:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 078A1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=WHEv8Bmz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=FBjIBgDWbZCo9SaA6U+cSq8TU+erFs29CF/2hr/QbOQ=; b=WHEv8BmzZlBskbtiRsC4Yz/6tF
	lVJsH/z7pFdPbcrteUfO96lrIzu6yFa42ask2ACLtB8O6uGMAjJ5FkSqxMKs8yMyT7o7Hs0ZuH/2N
	4GkPXRnZ7UYI7WmuDLcVG55y5hJJHUVGaRsnVFAvyX9zV/fjb9Uw1RfdJCS97gPuNrho07j/aW+1F
	pOJern4i9oeuE7j8otJl9949EwHRfUv+7LRx9Kd4TbmcROCdlLLufc3Qteg0RmyjsU3rG6JeoPs2K
	k++dAKZdxZIbbcOTn+0G93w14T0clcHEu2gUYgi3SOM1wcSDowGQdPNb/nXXKvmf4sWXrtqwqUcHH
	TaIrvW+A==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, 1579567540@qq.com
Cc: Cunhao Lu <1579567540@qq.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH net v7 0/7] can: fix bus-off restart and device close races
Date: Fri, 06 Nov 2026 13:50:20 +0100
Message-ID: <16255046.uLZWGnKmhe@diego>
In-Reply-To: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
References: <20261106-rockchip-canfd-restart-close-v7-0-accdb11bc845@qq.com>
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

Am Freitag, 6. November 2026, 10:37:19 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Cunhao Lu via B4 Relay:
> This work started from a real failure on a production robot using a
> LubanCat-5IO with an RK3588. RX continued, but the TX queue remained
> stopped and subsequent sends returned ENOBUFS. The interface still
> reported ERROR-ACTIVE, and the hardware indicated neither a bus-off
> condition nor a pending TX request.

[...]

> This series depends on the three patches in "can: skb: make CAN skb
> freeing safe in any IRQ context" [1] and the three patches in "can:
> rockchip_canfd: fix TX stalls and races" [2].
>=20
> [1] https://lore.kernel.org/linux-can/tencent_CD05F020BAFB2537F5D1F4CBB42=
5588EA80A@qq.com/
> [2] https://lore.kernel.org/linux-can/tencent_E25C9BE6689264E4138A464803B=
810FDFD09@qq.com/

Both these series are from july and seemingly from before you started
using the b4-relay. So they may or may not have survived the kernel
releases and their threading is broken both on lore and in any maibox
they arrived in.

And if there haven't been any responses to them since then, I'd think
they have been lost or so.

So I'd suggest rolling both your dependencies forward on top of the can
tree and sending them as a new version, so that reviewers can find them?


Heiko


