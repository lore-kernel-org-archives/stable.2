Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794842040;
	b=Y5JWb54VyauO7l4vnXmGgn/xWDYeYrUsCBBuzyXJQ+6Q6dIwZ++MK9E6kkHewgktBerD
	 ZFo3sYgCW27Zs29YtARgGHr7Qu5e5SADt1tGtS5BON/T0NEfWtJxxK9iJKV9M0flsi6jQ
	 JM+6RLCere2iNBwMmEi8TxfKGDrWjYXOGE89jBkvdcW6i6HhJH7QOgIJx2wBZ/p6mT2v8
	 C3GW5MIKF61fvazdLz9yjxnl5Cdk/nq8Ws+WJ1UvYPTGF08SExin3hPbl9s9HDm8LFg3H
	 sjBthfOskA4Hp6ur9Dy5ffK7aVpI1Kelq+0FZw3Dw8OCyKsRBYs3nD1rXJA/aYeaW+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842040;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NL9/NGy4Azx8OcFa14jfremQRG4MZtZ9uGEC43e5OxA=;
	b=vqNno4Zu3+QzWPe++kcJvUznbmXZxY1bvXRzQ1RRr3Y/pzOld69fVtLDbFErlUVtkjuc
	 vY8ka6sXdUgOdXW4MdenK2EOPq+izM4ophyJB41Ph4aMgmBgfseBqYzLthEnU90+ihxTr
	 1bW9Ic4Kih/IISKUvspIrOpzNxApRGvH95mItZfl8SJB24y13+1Ch1msi5K3SL1Lbdr4b
	 H4rBEp56QfM3TCyugs0PoTpOhZt5nUx13Wvte5HvIQUHDzaD7MaUSVllJQaD2ln2Cmhzm
	 M/h72XCg1J0Jrbpm/JNW9pq40xlWPh9fOJUZzvC63bmiRkHayzg4z7i0/G+LjiTCRvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RZ6x1HlJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8130D606A323;
	Mon, 16 Nov 2026 15:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8130D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RZ6x1HlJ
Received: from [127.0.0.1] (unknown [IPv6:2a02:560:5d79:c700:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 498CC2058D6;
	Mon, 16 Nov 2026 16:13:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794842033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL9/NGy4Azx8OcFa14jfremQRG4MZtZ9uGEC43e5OxA=;
	b=RZ6x1HlJ3/bdEG+SD9czNNxGbaYVdr2CmzsdvDVFIuYfbx9Jh1YQjVSOm8T2gedc2HrAgU
	m4A0qYY95PRe6vLDuV3ioRSuomOxx46nzGIel01UN4f3DIr+/V0vp6WCchDMkFVh+juZzY
	ceg1iGu9QUeYGcsqUxwePnj9yozohsgj9VZex0KFmtnHffFfx9p5c/hqusb/ngSm0YmSuh
	Y5diGEs8UORnlMCSW+CD131LJH+4SSBNyj0qhWAp8pxS/PJZkP3ps7Kka3gbmrPtFJwL7z
	M72Eo5GQOZxn56vLttU9tv4JtCD9rEwNvNIzVTlyNtVlYEKVw1LnLBLm+ImxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794842033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NL9/NGy4Azx8OcFa14jfremQRG4MZtZ9uGEC43e5OxA=;
	b=KJf6oLIWQY2WF7b8rLroINpeX+mqZUYnGMPMM2MqSKzmQM3vV8FJw9mdCUh8ZWjjAhekoC
	AFLDPQT7vhQEKx0UeRh370ZnIARCcSh+HduKzLyj8xv4Ud8KNXsLRhpAjrtKEVfcbh17F0
	GZdLeDQuiSDv9nfHMajypPV2BDAjKubzv5WeGb4TF4aNtdYhBA+f+qXlqgmcWKqARHmRbi
	i7mWd92IShP7FOHeFcr6TUR6dbTFErdzaJ4bR68bPUEm10uFsoeQmBhEF9qJwxAUoKeqdX
	HlWC0GEhVdbkXyJ3TjiP9V1kEBCUrYWEC3gPFnlH9tIp2yj+ljA9b1KMtGAp1g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794842033; a=rsa-sha256;
	cv=none;
	b=AME0XPZilsuwknU5HV1wmaOmspA6oGNap1AXDdjmE0dciLqSKby3cLlIu7B5Tzcld8jxql
	qT3gdN/ixIVH7ow6EiW6Uns8Z2EEYYc9vURbouF7myRxEvdPMP2kxOxISs2LUAddfsacan
	BwAUwOTX4BwpEDMg9GdCIwYswssAPn7SSCTIRLOnKdyDFc5XmEJKk3P5AVAylxMqRHxeSv
	DhbZZT63Kt6wi234RdYYnYgT6r19pXwQ7EwH807nuJ5C9bqaOar9eMQHXNB4YmHCGB+IlG
	T94nK2lr5L0iLbyYJc5lpRSebUGQkCqbljKF2BUCmTYap8D97px0+MCb8GkjRQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
Message-ID: <ebff012d-7857-4aa2-a8a0-38b5b59128d4@pengutronix.de>
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 00/10] media: synopsys: hdmirx: support an HDMI
 bridge in front of the receiver
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: "Sascha Hauer" <s.hauer@pengutronix.de>, "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, "Hans Verkuil" <hverkuil@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Dingxian Wen" <shawn.wen@rock-chips.com>, "Shreeya
 Patel" <shreeya.patel@collabora.com>, "Gerald Loacker" <gerald.loacker@wolfvision.net>, "Lucas
 Sinn" <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Conor
 Dooley" <conor.dooley@microchip.com>
In-Reply-To: <5042d545-24ae-4567-a39c-a28bcb1d1ed1@kernel.org>
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
 <5042d545-24ae-4567-a39c-a28bcb1d1ed1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:13:52 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

On 2026-11-13 10:01, Hans Verkuil wrote:
> Hi Sascha,
>=20
> On 05/10/2026 15:28, Sascha Hauer wrote:
> > The Synopsys HDMI receiver driver assumes the HDMI connector belongs to
> > it: the connector's +5V line arrives on hpd-gpios, and there is nothing
> > between the source and the receiver. On the board this series comes from
> > that is not the case. An HDMI bridge owns the connector, the receiver
> > sits behind it, and the two are described by an OF graph endpoint.
> >=20
> > Three things follow from that, and the series is arranged in that order.
> >=20
> > Patch 1 comes before them and is a fix for the driver as it is. The
> > driver data is devm allocated, but an open file descriptor keeps the
> > video device alive past unbind, so the last close works on freed memory.
> > The media device the series adds would have been torn down the same way,
> > which is why the fix leads the series. It stands on its own and is
> > marked for stable.
> >=20
> > Patches 2-3 give the driver a media device and register the video device
> > as an entity with a sink pad. On their own they add a graph with one no=
de
> > in it; they exist so that there is somewhere for the bridge to appear.
> >=20
> > Patches 4-5 add the endpoint to the binding and bind the remote subdev
> > through a v4l2 async notifier, linking its source pad to the receiver's
> > sink pad. Such a board cannot provide hpd-gpios, so the binding requires
> > either hpd-gpios or the port. Without an endpoint in the device tree the
> > driver keeps working exactly as before, so boards wired straight to the
> > connector are unaffected.
> >=20
> > Patch 6 is fallout from the wait for signal lock, which was bounded by =
an
> > iteration count whose duration came from the 5V debounce it called
> > each time round. That debounce goes away on a board with no hpd-gpios
> > later in the series, so the wait gets a real timeout first.
> >=20
> > Patches 7-10 are the 5V state itself. Patch 7 stops probe requiring an
> > interrupt for hpd-gpios. Patch 8 makes v4l2_device_unregister_subdev()
> > wait for notifications already in flight. Nothing kept a subdev from
> > notifying a v4l2_device that was unbinding it; that is not new with this
> > series, as asynchronously bound subdevs sending V4L2_EVENT_SOURCE_CHANGE
> > race the same way today. Patch 9 adds V4L2_DEVICE_NOTIFY_RX_POWER_PRESE=
NT,
> > and patch 10 has the receiver set v4l2_dev.notify and take the state fr=
om
> > whatever is bound in front of it. The notification is only an edge, as
> > the 5V interrupt is with hpd-gpios: the hotplug worker then asks the
> > subdev through g_input_status(), so nothing is cached that could go
> > stale against bind or unbind. Without a det_irq there is nothing to
> > disable across suspend and remove either, so patch 10 disables the
> > hotplug work items themselves instead of cancelling them. Patch 8 is
> > what lets the notify callback read sd->v4l2_dev while the subdev is
> > being unbound.
> >=20
> > V4L2_CID_DV_RX_POWER_PRESENT is otherwise the only place this state is
> > published - adv7604, adv7842, tc358743 and tda1997x all set that control
> > from their cable detect interrupt and stop there - while a format change
> > already gets an in-kernel notification through v4l2_subdev_notify_event=
().
> > An earlier version of this series hooked the control with
> > v4l2_ctrl_notify() instead. That reaches into another device's control
> > handler, and the only thing it bought was working with those four
> > drivers unmodified, which turns out to be worth nothing: they are HDMI
> > sinks, so none of them could sit in front of an HDMI receiver anyway.
> >=20
> > Nothing in tree sends the new notification yet. The driver for the devi=
ce
> > on this board does, and the alternative was a mechanism that no in-tree
> > driver could have used either.
> >=20
> > There is no in-tree device tree using the new port yet: the board is not
> > upstream, and the device in front of the receiver, a Lontium LT86102UXE
> > 1:2 HDMI splitter, has no driver upstream either. I would rather send t=
he
> > infrastructure for review now than sit on it until the board lands.
> >=20
> > Tested on that board, and build tested for arm64 at each patch with W=
=3D1.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> As mentioned in my reply to patch 1/10 I'll take that one. But for the re=
maining
> 9 patches I need to see the 'v4l2-compliance -m /dev/mediaX -s' output to=
 make
> sure the media device topology is sane and streaming works as expected.
>=20
> Use the v4l2-compliance version from the v4l-utils git repo so you have t=
he latest
> code.
>=20
> I also need more time to review the v4l2 core notify patches. Apologies f=
or not
> doing that sooner, I hadn't noticed before that this series made core cha=
nges as well.
>=20
> I haven't looked at that notify code for years, so I will need to refresh=
 my
> memory.
>=20
> My plan is to merge patch 1/10 today in our next branch. It is probably b=
est
> if you post a v4 rebased to that and including the v4l2-compliance output=
 in
> the cover letter.

Thanks for looking into this. I'll send a rebased v4 shortly. The
v4l2-compliance test works on this v3 already.

Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

