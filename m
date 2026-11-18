Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025850;
	b=eDIzEou4Y8L/a5OdqBNsGutAwDhwZVDa7tYskONodFCLpHhhjdHe27fzK1ZxriwKIArn
	 HWqIlkjQQawkxcPrmwwCXMZHtLNvzglJ8nK2VN+Tk/gS1/m3IDrZrs4fTH34D6n34Xuoe
	 xQLbJ4wjCUBBYxwIn5sdzPsnQv0ubHUtEH46m50ccDD/yDyZoSEXXNFSsDwRcyzNZN9Uk
	 pzNtWRADTO84kPEDj6nmHEV1eKr/4i8b5HJziybHkQeF1GP6O6upjjUURBjb8rnD8iGJ1
	 KbuVxVV3u3StO2eJU8kuTemiClEaokRY33A5TF70GEWINtd2D09r1GexmPNavsTvXPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025850;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=QFi6ON0IVPesKyoOed28jaNLBYpzvgql4GXNjTa8VZQ=;
	b=GkvX2r9Hyhm4TpTDi0PcDW9WuW0FJP6QuHTHtz2jSroZhwmUlNeJ3VBMkEGvVbI2jaLH
	 xO5HyfeqXPs+C9AmsgczrZKQqw32XPDariEbg/DBoD75AT+C9q2IKKoh4CbDJlhhoVa/W
	 DSGmREly9LmJMxmFco9uOqdogFtwPk8s+HdhNVl0Usr3kdd+CNsJglV8cau3ZHo9xySYj
	 4EAGzge+PMon/mY2MxRQnF8ZkJUucAPiPSNTOx/ffBr0Bo/Nxr9hTaiqCsD6ty2X7VQ/m
	 oH9jJk3aHanJC5r39CLZEdHlXP0rTAi8D+WbVBAe07i+4cw3qQCWf901AhcWzDZeCMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=N08A494f;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89B60A2628
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 18:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE89B60A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=N08A494f
DKIM2-Signature:  i=1; m=1; t=1795025847;
 mf=PGRlbGxlckBnbXguZGU+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:qgwAT8wUmE/jXSa7ERPcfQa+XoHk
   Coboz6noIdKQ6dDpOWGo2gZCJFqsMs1fkmJRHoKmOaN2v5k5YM+ojeNjp8Ep+xNMjL4VBdJGTHv
   SSD3wofTi7aAn4vT2RdnNk9q7n1xYahwYT/W72pw6ydjvU5O5WZtW6078iaXpjo617H5hPwO/9M
   Z1WyFIg0Dsm7Oo16a465XZZabp5NjXJEJfD/yk1JVHg/++bXC8UdJiUfN0MHvcEcCzCB+IbdCYH
   qk52xiQCJf9XxdDARqirIeMwcu0wEgro2MKqx/CCVWgpTzJ5BcgB3tLMqth4RPD2T8Mn7pRxCNJ
   NbeJnzz0Kovisw==;
Message-Instance:  m=1;
 h=sha256:
   AtvjaJLVSj1u+nnLcAE8ZSsIz0xw0AwmAGhLu+Wjb/o=:
   QFi6ON0IVPesKyoOed28jaNLBYpzvgql4GXNjTa8VZQ=,
  sha512:
   rDoxJZdkihihxGyaE5Y/FDUQDmDoDJ2b8Md9BPfdEMhDxWxF2Exm/U1sAAk4aNizApAw21fqfQ31E3ml/AGilQ==:
   4p5bRxj8Iy3V5IHtHEGpVwBuGlnuCRcQTHNnxUxG36pc6zWBgoAXz4Mvz4zjz5ZQlHMfi1g2z/cXsHYjKwvDQw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795025830; x=1795630630; i=deller@gmx.de;
	bh=QFi6ON0IVPesKyoOed28jaNLBYpzvgql4GXNjTa8VZQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N08A494fPdj9jI6fDSMMHNTMnGVUYr5RofYMpzW/hpUyNS3e6Fs2fLgh5RJlUdOe
	 kCPhqZF2zOgyOlPzWREbzg5quraeQqgZXmzZrMa/7u0FvONP26EBragSk0e6EOrQW
	 uXm7ga22aT3FX3nMMoUMMsv1HSkx0xVIsLijgHyFB/OZqSTFw0q6cqBA4BzSeCiMJ
	 LhZlSOyLzc4J/VuZ66G91kXKJeuA7y0bhBHv+3ippXkUsU+FLFC+rT9raCCwTzPXK
	 C8/msfW2rK+Bp3ZAWngJj12P1teowj4IUfWUIeSo55+nCybyuXkqjmwixTtf2jiDe
	 KaZnjtTTHySGQ9L6aA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1wdc0x0LxV-00jtjh; Wed, 18
 Nov 2026 19:17:10 +0100
Message-ID: <4fba8bdb-de77-4418-8ffc-7ad6982e8027@gmx.de>
Date: Wed, 18 Nov 2026 19:17:08 +0100
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
Subject: Re: [PATCH] fbdev: s3c-fb: Fix potential registration corruption on
 probe failure
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261118-324f82bd41-fbdev-0@mail.sdu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CS5thO9Vz7ncrpzF4u+A0XsRZT1JUgMDZIqig++ovEyZ32z6ph4
 kyQ445WwQiOfCrjXvcU7mZty8ZbCTIi6gP27Yfkvu4s4izE2D2AwZfCDiH5oEbTenVMGz71
 es283fAO9oDwaiwivSo1uA9hESRutCrfaFIe7xuiZ/lCp6O2h9oSeZPiplQpkWdS4AuIXUh
 WTfBiTGEHeYmrOc/JnUsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wd92r12GhO0=;xUzwAbIVCtbpM8Pnl9dY8shBWDz
 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
 5LJ3C+LMxY4k34Ct0qk5IM5Ogdf31rK7MIT5Q==

On 11/18/26 15:22, Guangshuo Li wrote:
> Probe failure cleanup calls unregister_framebuffer() even when the
> window has not been registered. Its zero-initialized node can then
> remove another framebuffer from registered_fb[0].
>=20
> Track successful registration and only unregister those framebuffers.
> Also skip empty window slots while unwinding a failed probe.
>=20
> This issue was found by our static analysis tool under development.

I think s3c_fb_probe_win() needs to clean up when some things
like cmap fail to be allocated.
Your patch seems to just work around one of the possible pitfalls.

Helge
