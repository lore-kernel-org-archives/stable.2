Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293502;
	b=00qBgCxY4lrOyMSCofn1l04uwFDlcVBk69Dd4Wxqt1MmopEsLbbatuRHzQK7HuruLAon
	 ++aHHeSYJS03AmGYpJ2G3FYAcznoKxJrzvKbxMNDnZtSNhgRLLepSLaf57IgVBf8f/OyE
	 YEWHzltfSSZlYW5yEBH0CKmfk/SJ04clCfRfZrTtxqYunX+wnpFjcbkfk+9m+BHy4ej6r
	 zu1Nk3RMSFHLbUG/vVhliUu1VO/dsQb5m6MTXdkAtcO9pEWmqsk4EevsqKfGyqGLQ336d
	 vIblkUqRYsgV8bEkkL2lp4Qav4V7rpqnqH94jm7N3EECoNc2bFiR2aq8P5vmR7wouXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293502;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=awtTdRvodLPJGwyKgti0ipUO+MDHSKcEJgflthB/U+A=;
	b=JCniJ2i408qB8ydsFuXPcp58dYiOTVvQlrcrVXvoJJR09fijX8gC1TjoUwra7NNj9TIw
	 nmiGnbsudLS6+ggOvErggiXsz3W0iX3fPKKCrXlXCn9x+bcJcGCikSKvIqr3fuUfS0Pkp
	 EW71WGKeplN1tFFLhY+QXUDyJAkdS56KMp/4yO/gPGcFo+XIENLB2QcmYdAU1XSNjV6Yn
	 Vfu3oB46Y47xk8v+2Xft5q9tfq7eqGWW41rqRsZ6K7ZwojHwQXu8jZhvIk4xbbQzlSQ5a
	 8JxRl40zWf7xbFTwepy9eeAntxMo4nOufzm93SVfPJzBqWQXFSE1+JRp5PRqtJz/fug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=KVpTQ7bb;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C983606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 20:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C983606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=KVpTQ7bb
DKIM2-Signature:  i=1; m=1; t=1795293499;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:ot2DvCToJaYgdbitb/QZHQrrAycH
   xZ9BZQQSpYkVHc386WMo0bQJi5D16YVhNlvLhZMsYd+4MKbzFFY2ciEEM5ajgaDZmd3Ilj6nize
   0XsTcUFrkn2dwrkSysCrDTvpni+cXaxGt/L3eRBPhr2qBdluoSG6o4B4LwJOBZi6ywfBoYbd86U
   gWi8MS4/6ArRCSl5EgIy0WaPWgIi+WhvNG6nQT9AFVsMl5sW/EFmp+67pBvgm3vvKs7RT0770lD
   2C/c7yP+aPtc77MlctxlHN6M9iNBaHRt49kiym89r3g5fDJqC7bRJqonMelx7RFaT5iu2cWut0W
   h8d6nIqzeiQwRA==;
Message-Instance:  m=1;
 h=sha256:
   KtoJh0HXmcHQI/lO1I1JXzHYm/fbIBcXM9B+y0FGrzE=:
   awtTdRvodLPJGwyKgti0ipUO+MDHSKcEJgflthB/U+A=,
  sha512:
   29jnx5SQ8g+2K4RpqqSRfOhOg09jO4EYzBwCGwFh0TN6j6YEzhMwFgkiSepBZNMcCp2TfmgyAPmqaM3R571Cpw==:
   AhIEscdb/wjAzfyAPOwXBJmKDWw+dxxZ50xc2n3MMiix9Ya/faWz1kzKS1qcYoR6CwS/GqELQLlbn2hDifz7jw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1795293484; x=1795898284; i=wahrenst@gmx.net;
	bh=awtTdRvodLPJGwyKgti0ipUO+MDHSKcEJgflthB/U+A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KVpTQ7bb2GvUGCpSpOAQH5WeM5F8b962azXQSa0HBJzq1KmnqZoqbPqD+Sjbw6UZ
	 dRPZQtdtwfGPpFlaMEl4IqSaOqXh6IuyBZ9s1Vfk8TmmJnlCW3wjom42qAbD0XB6S
	 Vu4+umqqf0XCEjHoXXedziyulpqFu3EFH45Aa4rrF+cIGCLh9c2RTIGOjlY5k2rPi
	 Pixp22LfwSdlCCwI7dmhsu/b1KuBjHp9vpGx7QOZywCVabwE4fEnh5soV9jqzmaee
	 C+7QSZ7facoLFNXqzPXwv9+8GyThwlXhusWfaHOEDrjJwU3ftHm9PcYriWGrFWpOB
	 DA2v/GF6pvYVm+2FfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1yb3YG3Ulv-00sdWY; Sat, 21
 Nov 2026 21:38:03 +0100
Message-ID: <af32cbc3-9c24-4e43-a7ca-f4716f48cb34@gmx.net>
Date: Sat, 21 Nov 2026 21:38:01 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] usb: dwc2: fix recovery after PM domain off
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, stable@vger.kernel.org
References: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
 <20261117-dwc2-low-power-fixes-stm32-v5-1-0f197e0e6362@foss.st.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20261117-dwc2-low-power-fixes-stm32-v5-1-0f197e0e6362@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZLPUYS+TfJWVobb7coDLF/dj5rUgqLewsT0DgbDSt75UJRKTgHi
 4/cHMYIuVb0N9xuj5EUkhhNI8su6H4YcI1xoOEvi9MqEThNqeMnMpHw0s/oeFu8eFs/WzN7
 jPbNKdppozpqtc8N5SSdKj/gWb+Y+AT7BVXGEujNCwj0FgkOnzYNluCarDA+eltQEmDN7lH
 umRAtRkNGxhcrDPoQZOfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3wPnk0QI+4w=;RekfQ+4N6OHidYJckaKduNQexIm
 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
 M7YY=

Hi Fabrice,

Am 17.11.26 um 18:06 schrieb Fabrice Gasnier:
> When the power domain containing the DWC2 controller is disabled during
> suspend, its registers are lost. Reading registers to back them up from
> dwc2_suspend() after clock gating can hang STM32MP1 in both host and
> device mode. Host suspend enters clock gating directly; in device mode,
> this can happen if the host suspended the USB bus before system suspend.
sorry for breaking this platform, but I only had the Raspberry Pi for=20
testing and I didn't get much feedback last year.

I'm not familiar with STM32MP1, could you please clarify based on the=20
compatible which is affected?

Could you please explain, why backing up the registers before clock=20
gating isn't an option?

Best regards
