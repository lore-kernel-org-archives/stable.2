Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478752;
	b=1e1KSB9wXkvWzAirLy+YArgbppOMJxL07XptRJisgI5T7C9/9LIH4VWjf6ZGwcpsfO/7
	 K3MDGbsgzxxUZ90e5MRoaEC9hhe28TW6dcVYvBAXTb69rH52gvNkTyMnBmkaKCYa4FNGW
	 ByTuVA5180kdKneU/NLaPbhlTH4sGOQ27jpFZMhFJLpdGwLx/zi69eK0GX74CTub8HfYY
	 F5FeJFRDuac0ti+ymJDO1KTme0rO30QFGyXtkeRaIA3Q4mkXWb0mx7J1k7VhVV5RYYqL1
	 C3ec09nO3tMdnSqCtXYT24wp3EYQVpcoJX3NWBT2THOl9qTyESzewvNc8PlrnrI2jlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478752;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=4VYAg36bzRQtNXdY1YRHBQr5BBzsOdbEIoK2oKxUoYs=;
	b=lH+xHunFXdazjY6f2wdBsZ0miWwNgcZ+klZPxE8WXDJn99wJAa+ixvRZKr6weOK86DkA
	 xn4Gp+7XVFNgF2RcGKMPqNLupbF7eOvEDLuWg0gA0r3F8/ldfDe5YgcrPSiAQ9t4dD9xu
	 DlGZx28c+kKyct8xLJGtEpvWk05LRvOG5VGx14iWh/Z7mHOJle5q8PNbGlu9cBxfdt4e0
	 Ht7LVnGPHOP0sQtbz3CGesWeY0g7RINk2IHgL2KygKXz9U48I+jV2KNjBfE0nrLAQPgen
	 mzkZ7tb5YO0c1Wh3nUsTfsIBoZr4SdL6tN+OOB6ug06q4CULua1bL59szt+yPEh6png==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O2obj9vK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C802606A327;
	Thu, 12 Nov 2026 10:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C802606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O2obj9vK
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AB9A52004B4;
	Thu, 12 Nov 2026 11:19:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794478748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VYAg36bzRQtNXdY1YRHBQr5BBzsOdbEIoK2oKxUoYs=;
	b=O2obj9vKiy8RAL651Nw17SsNvscVe5NWLWrqBbtOf9f80E051DzurxZ5OQYThZs3dXJ2k4
	/ebUywrJhNmQfBlHi+sb3M05tnDQhOhljmDvzHvo1WO6hdc1U7OVG2Gk/v5TRevHcdH0LK
	nJI/UveHe++PxIq4gA6ZNuW7bRITk5ZHKI0oJd3q0px1QQ4TxHrUVt0R+HY+nz+Hqxx917
	LA0cD7I2mO3svbqPN0u4p/A9zs1QzmBvfucPyq14aUkjq4aisup+MfhHNmMg+4pxP49474
	J3HyUe9VApmCLPvRzpoB28CB27qwsfeZqjLvZzIC3t1dEF6Xo9jnIW2m89W2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794478748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VYAg36bzRQtNXdY1YRHBQr5BBzsOdbEIoK2oKxUoYs=;
	b=I8gkf2050xIArn/XEyvo/83XwaJRBj6azNQtTxCIY/yHi1zw5BMzwmu2qnZZy1X7mQ5VGh
	V1P0QqzSsNmUbXj9tlqnz8IZQPft8lZorV1UfB97uNQsZ93nEnFjvx4mP51dkut4P0X3xT
	Ol74lUP3wYXUYjIVHAvPEhgubRqHz1eaycsHlgqIfIopSZDDM224iHY0mCcRIq9Msn49gP
	4cLLl2D5M7jyh2RScnIqkV4BXnZEPcIbQiyH2DI9r3tdYqd3hIfso3AN/o1yc1DyW0mu/b
	NX82H8D0tkR16DHyUOyXubWYHS1PWtZJI+kSBhng9Fcr0ytHIAFwRff9Ht+3Ng==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794478748; a=rsa-sha256;
	cv=none;
	b=W+c+029ZeAryrNgfB9iWvxS2lleQ2C711z4nB4g3GeDXtMKxKc7ELfNYPFWYjZupXyKggP
	tl6Nz/nc7FLu+lPISIGmTRveYzBb1eOkXI9C/x+2ygShAMTY9TXnTxMTB70MkC490pRe4j
	ALNoS9ncXsgUd3XvPtsR4rZqPnyiC59vBeWrpYLZDlNgUxS9KPzx2jN+Hs7A8TMNSYJz35
	GEmyDVJzc53dZGlSWpw/XdhKEwcnySj/IHE6FsbBlrE8roZADzuLSigBOxOxEoGppeY3Ru
	la9EADd/9144U70sk+XDQX1hvWa2270oiXD99nIr35CCDerYr4IukA9uHM0VzA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <c97eef1ba88daf83d231d2ecc78b47fcf524385c.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/6] media: verisilicon: Don't hold the VPU in reset
 after remove
From: Philipp Zabel <p.zabel@pengutronix.de>
To: aiyengar1990@gmail.com, Nicolas Dufresne
 <nicolas.dufresne@collabora.com>,  Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Nicolas Frattaroli	 <frattaroli.nicolas@gmail.com>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,  Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Hans Verkuil <hverkuil@kernel.org>, Jernej
 Skrabec	 <jernej.skrabec@gmail.com>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>,
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 11:19:08 +0100
In-Reply-To: <20261112-hantro-robust-v2-2-18561fd48838@gmail.com>
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
	 <20261112-hantro-robust-v2-2-18561fd48838@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Do, 2026-11-12 at 08:30 +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> On the RK3588, the resets of the AV1 decoder include the AXI and APB
> bus interface resets (SRST_A_AV1_BIU, SRST_P_AV1_BIU), which also cover
> the Verisilicon IOMMU of the decoder. When the driver is unbound, the
> driver core runtime resumes the device and, through the runtime PM
> device link, its IOMMU. hantro_remove() then asserts the resets, and
> when the IOMMU autosuspends 100 ms later, vsi_iommu_suspend() writes to
> its registers while they are held in reset, which raises an SError and
> panics the system:

If vsi-iommu accesses require these bus interface resets to be
deasserted at certain points, why doesn't it request its own reset
controls?

Depending on implicit assumptions like another driver not asserting its
exclusively controlled resets seems fragile.

regards
Philipp
