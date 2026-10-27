Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793093206;
	b=l4s6O5zRvo9mTE/ftiKgAVrkvtHXnxLjCwKgGksD3KWupuS4lXxSPfgjNSuraR8VPg0O
	 LgLaUs+4fiAA0A6pzfrX7n9vsqJf1h9aC6rduExb2CTIgI28Cf2ri1Odb5RhYilXhb987
	 7jCkYIwzWttuH2Gb6pCFES0O7936hTLtHVLN+fLUH4RRdLr0mMN8xqHinJ+GGarf5a5UB
	 YjYdDb6pjKLACcs+ZLK34nmZhMOadwSDbhQ2sUSR83MEU+V9A7EokDD+6K0vTyaDjDt7K
	 fkOz316CGuCiGmYW/rcAZd1swVT/RMrBMRXAAUV+uVHBzti3rbj1Vifu2ZgDyK/2NIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793093206;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Rplh0oOXoQ7+N4ERn2FRoB8iHtpoccUtCEgTPwRUEp4=;
	b=NQVp6yxoaBmnPeNW6S3c1L6IKA8Dw+mVCrTJeLnzEqTNiYWoM8ygtPcf4BYbQGIfCUhu
	 by3cyJ9DXR/N1L3xIQw6bCpV95P0zc5w4kua+yDWTqP3cxqhPhiOFZMAqabn6SyJtWJDj
	 J5BA4TXtvj0ABbzOCemyb78Nm2d7ylNuSn+fgqazBWaQv+e6T3oGvLJLa32M6FkhoEAdT
	 MSd+Es1Y1fqg6n+BhNKSit4W4Hff5qBXoMwxOpVFCCbLzAyY18b1vrU/LiX4+leqBzA11
	 1J9Q9SrV9SMNDsXGb3UgT0WEv0trFoZb/SR3xSslxGByg7op1rASf93ZobK/DugeBCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EDiOFQAx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770F606A31A;
	Tue, 27 Oct 2026 09:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B770F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=EDiOFQAx
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0C1D1200F26;
	Tue, 27 Oct 2026 10:26:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793093204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rplh0oOXoQ7+N4ERn2FRoB8iHtpoccUtCEgTPwRUEp4=;
	b=EDiOFQAxihjReR3jmxjxjOWYyzuobVyFLqJU2KSYp2Cb/DazN1TGjXfUPlJ+vtFDLOENjV
	Gu5Id8BttV1KPMuFqJLmjy5hRSjqFb3hwb2Z2/EaNvYaQJaj8Ph+Gu1o/yueRusavlDsIh
	FkJQNppKwAoFPeKUs+KxK+nnvQcFc8tube0NyuCYu0KVlA1CnVLfJogGk82HJmq1/1KRHQ
	X3TVO9dMg4LkZ9FEc8EoTPtvWdRYt+cCUFD6Inh2ehHvYP7aOrDclTlLw7PbJaYQVsblcG
	SI429olUzW18GGTp7miyihYwZZA3+6Xq7sgDM9jbVq7XFXUPs3REit7dhnqH+w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793093204; a=rsa-sha256;
	cv=none;
	b=JtgaLrSOJf9LuKezJg62ApjYtotgBhRkt5xf+/YDGDtNE0OVMXQtOSggFhomn7TssLTTB4
	WQJu7VQTsPQoMctzVVj1AMaRzuodLSPH5l9sptRvh73xMkAN1vkQNRyOjSuGsF6QYLyYqP
	078EcniVXj+ESpiKr6LwLHZ1Ga0Cmx8ZHEfFhMA2STsdjK3cwH4x2iQlupp6fLlxXb3JZV
	iRZNPiXTeS2KDfSTcZ50+ioLakTN3KmBMSE0IhsJkEn79Jyf6zZdvz2uRqVb+vAbSGAUdu
	SQYm6TbuH390Axo9J9su/ytSsMM0uaCzZzgntMFA/N0sJOgMfw7SdwmR/UwWSg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793093204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rplh0oOXoQ7+N4ERn2FRoB8iHtpoccUtCEgTPwRUEp4=;
	b=AL3rt/PcMtSRtg/UlDiNNu1hFhslhYeYEbzqspMiU1Uu+mq4vrXx+lOmqI30Zqsa+N7A4C
	lPwdnlVYOpg7lyp3hxyhKhuAI+2iqzpOzV+xeF+0g/ApVghq3+eHk7JrWS1yvHMa4q/Fn+
	TFQ2J41tfH7OKaZDh+L4bYMc40fm/WLHUFqdInUjkJEVIrlHF0Sn9sq47K094ck/rZQYUU
	hwQRGfHmN7ZSFi/uEaTLPJ0edTFS/7v3UDUqxMQenoLoAigQa7jCMhr8hzMEBHTmwf7t6u
	1xM5n6ZPgBvlE/1yWaNM/Ruu2iqps5RHQW9vRWb3JkdNfVSmS9nOG8ll9FicTA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xLdS7-001PN1-34;
	Tue, 27 Oct 2026 10:26:43 +0100
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A3D245D7AD1;
	Tue, 27 Oct 2026 09:26:43 +0000 (UTC)
Date: Tue, 27 Oct 2026 10:26:43 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mailhol@kernel.org, pfink@christ-es.de, eric@evenchick.com, 
	max@schneidersoft.net, wg@grandegger.com, kernel@pengutronix.de, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kuba@kernel.org
Subject: Re: [PATCH 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
 before register_candev()
Message-ID: <20261027-muscular-amiable-panther-61313f-mkl@pengutronix.de>
References: <20261025-gs_usb-fixes-v1-2-f74ebbd4da36@pengutronix.de>
 <179308664758.3130.9049840508592700660@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alkbsf2kyr24ok6k"
Content-Disposition: inline
In-Reply-To: <179308664758.3130.9049840508592700660@kernel.org>


--alkbsf2kyr24ok6k
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/4] can: gs_usb: gs_usb_probe(): init netdev completely
 before register_candev()
MIME-Version: 1.0

On 27.10.2026 07:37:27, netdev-bot+sashiko@kernel.org wrote:
> A frame with an out-of-range channel id goes to the device_detach label
> instead. That code calls netif_device_detach() on every non-NULL canch[]
> entry, which writes to the state field of the freed netdev.
>
> The window is shorter now that no USB control messages run between
> registrations, but the ordering is the same. gs_usb_disconnect() is not
> affected, because usb_unbind_interface() disables the interface before it
> calls disconnect.
>
> Would it help to unregister all the registered channels first, so the last
> close stops the shared RX URBs, and only then free them?

Will be fixed in v5.

pw-bot: cr

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--alkbsf2kyr24ok6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCauBuUQAKCRDMOmT6rpmt
0mImAP9ju6gebab2cBEqKrrXfA+yymM6Qax5f/CR4JG5tilf9QEA3Y6J3SfXM9Kw
UN2j1Wnh3GRmsXnmtiXwyDukHa+EvQs=
=pvfS
-----END PGP SIGNATURE-----

--alkbsf2kyr24ok6k--
