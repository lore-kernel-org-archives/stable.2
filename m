Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794841836;
	b=gJcAVD0ET2zd4YTdwS0ev0RCw0yqyrB1Cr1/dOIdckg7Yx3iiURmaLBAguVz7F4IBSfv
	 /LIrHi1Q4pdbJDSlNqyDQRoZFI8fAloEspIdkjKYSkA5yu+qG0ymP+o+MdlMXO2JBKfef
	 bCgGg385MKvdAcwp7671DpndWjvc6X4SeRw1CJajWzt+k54E3uAw6/nXAzmaiWBytll1/
	 JQehNVfIV9uS5kdnRlMgTU6ddMgTpfzYQ5zm7Wa4oYn98Vus+B6+FkIaII25zA+53l8ZB
	 YDenSz5z0W2KRP8/dgSL0PZTaPk3tjse2P/vgGIDp4wJqXjz1vqTCkTl1+aUsTzSTMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841836;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lkf3suh1JASFBRSRTOSUlKBZiwkP7oME3ElDlkGHcBM=;
	b=bTITISOeYUyGVihwFt+Jrtcdxa0JII2AQ+fsHekjmBbtIDqbjrom8RbXvJQfBIGU2zOI
	 bcpnsxtigw531Oh+Qztr8sjyBHKyzfmcG2JwepXRe0oOGHsxodsVmFTBVnW9mzG8gqp6V
	 We+sKQKASi1nP6t3aG4NgxMkFeDolaGbw+1RWNSDjkQziKpCRJjP9U1+Dn1zZ8QD0c1/a
	 3pa0f/c+0eT4itO0YM/QuvkOYl0qsHxOdTLrEPjJwF5DXk27pxAaf6pZigo2Qsfk0Xui7
	 PY7UtwvdiVxpWAQlu3QrosoDUfT13q3gaKNIYcRnxy/cpI7HBo8YbIkz87qnh91ooTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AkhsafWW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54759606A331;
	Mon, 16 Nov 2026 15:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54759606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=AkhsafWW
Received: from [127.0.0.1] (unknown [IPv6:2a02:560:5d79:c700:9ebf:dff:fe00:fdb5])
	(Authenticated sender: sha@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 587B62058D6;
	Mon, 16 Nov 2026 16:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794841829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkf3suh1JASFBRSRTOSUlKBZiwkP7oME3ElDlkGHcBM=;
	b=AkhsafWWX1Qe9DGyBsGNgOKu0EKo/B+dKqnYoXyIMJSQhfrcgvDiHKsOXvWFMDR0g3WvPa
	AMyl/e8WD7hHl214nN366txUVoNEl73z+WI7sYbMTQf0DTA785kkXQrpt0DCDU8aPJiY0V
	hORa6KaLvSL7xTI2TVvMmaPDM133lCgDMF9Vy5fg8mcQIyajBM8f/sGRmcSTB0q3kfA8X+
	K+/2L5nsLAzXCVPoZL2zmBfWB2M0IGCRGUpTWQ0aJ+EtC5JecMmIYgpU1XRtJavCFcKOpn
	c4Ol83fFehRFEualYE8aKGSgkrxtgkdKvzOGSj+7dTuJMQNB6xbk77LVDKQEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794841829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lkf3suh1JASFBRSRTOSUlKBZiwkP7oME3ElDlkGHcBM=;
	b=SBcQdXwN+rPjwsF6ULrmdYUqU6z5gYME5JZsWsrW21P34zAhgruDurVi58QiuO7wP3riI7
	YvBEyFYxIBczcA9f2y4TNp/fMjr4i5QHrgRrGHK8+rRn7tGv6NullkvsDP7Yn3m9HJ53xt
	tdAVFLPfFLUsDubGaE0WtUsRIlwx1dy/M7UZlVhrRDZw9KJTZMq9c8YQUdN+LC34m2cCTQ
	WojlMt6Hs9fqAsbs7HFmw2eEcZNUZ1Rvs3otCNH7DqPgJlwTDCgDJm/aIaOoa0BErYCTrE
	udCFetBwiEjxKK0WdrKpO1CSnRrSVvYr0XU+pYoXBGNPDpttqWHSyf7SHsLAWQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794841829; a=rsa-sha256;
	cv=none;
	b=eUUz1nN7/hw1E5Sxn7sW/zQB93v2TSJbe6ctil0rdYIXctiP9b0Ug+40tmrZmhMIZ5EBfe
	HTODOkjB7gdc0BTAKXf99TvoHXAIiYnPKfmqTpui7dz9TbvvZlJFodMXswLLN1KrVXPmNh
	8ztsLvi0/Ebfi2nNG9zH1q1ZxRBww+teL5U3OhgnxuaVVF1Ch5+C/+WwgfsXamN1W+NNuu
	lzU7XE84qb7TTC0wzMhgPF+/uhJ7+J3NC/f5NS3BhxLAqvxHni4wWluKyC7WzDPQZ4vo9v
	V7MxBLVSzVDtcXLpyasutKMrhMNmT+s0t/M11IITwuCdlURU1nnU87kpozYgTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sha@pengutronix.de smtp.mailfrom=s.hauer@pengutronix.de
Message-ID: <1fd9f5b2-6a4d-4335-940b-44ac7a65cac9@pengutronix.de>
From: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3 01/10] media: synopsys: hdmirx: free the driver data
 when the last user is gone
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, "Hans Verkuil" <hverkuil@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Dingxian Wen" <shawn.wen@rock-chips.com>, "Shreeya
 Patel" <shreeya.patel@collabora.com>, "Gerald Loacker" <gerald.loacker@wolfvision.net>, "Lucas
 Sinn" <lucas.sinn@wolfvision.net>, linux-media@vger.kernel.org, devicetree@vger.kernel.org, kernel@collabora.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <717863c4-4654-493d-821e-a7bdda0a3453@kernel.org>
References: <20261005-hdmirx-media-v3-0-71a11a2e3e76@pengutronix.de>
 <20261005-hdmirx-media-v3-1-71a11a2e3e76@pengutronix.de>
 <647b6128-2bd1-40cb-86bb-d36e84378d93@collabora.com>
 <5b3592b1-74b4-43e6-96e8-a600b6fa991c@pengutronix.de>
 <17cb2a11-9c9d-43c9-889e-8581522c7a74@collabora.com>
 <717863c4-4654-493d-821e-a7bdda0a3453@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:10:28 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Hi Hans,

On 2026-11-13 09:44, Hans Verkuil wrote:
> >> This is a long standing problem. See [1] for example for an attempt to
> >> fix it in the core. It seems consencsus at that time was that it must =
be
> >> fixed in the drivers which is what this patch does for the hdmirx.
> >>
> >> [1] https://lore.kernel.org/all/20240610100530.1107771-1-sakari.ailus@=
linux.intel.com/
> >>
> >>>
> >>> What is the user-visible or sanitizer-visible problem? How to reprodu=
ce it?
> >>
> >> It can be reproduced with Kasan on affected drivers, below on the hdmi=
rx
> >> driver, but it should be reproducible like this on hantro and others as
> >> well.
> >> ...
> > Thanks, the patches are good to me (tested on 5b with no problems found=
)=20
> > apart from this one that feels like it's not a proper solution.
> >=20
> > Will be good to have input from the v4l core maintainers, or have this=
=20
> > fix made separately from the series to not hold rest of the patches.
> >=20
>=20
> There are two possible options a driver can use: if the driver has just a=
 single
> video device that it registers, then it can use the release callback of t=
he
> video_device to do the cleanup. If there are multiple video_device struct=
s, then
> the release callback of v4l2_device can be used.
>=20
> Using the release callback of v4l2_device is the more generic option, so =
this
> is fine.
>=20
> Many older v4l2 drivers do this wrong, mostly due to a poor understanding=
 of
> how this worked among media developers at the time.
>=20
> In any case, I'll take this patch. It's good.

I just realized this patches a Use after free. I just sent a patch
fixing it to the list.

Sascha

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

