Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496117;
	b=fbSxQGvpPD2buTveCyS+xgrLr3+FfGRFyk8AEZ9NGBQD5PurJmc9b2lyxVxwvtNj/eu7
	 GhCnv6H2/SA5SAQI6iX//7E7RrG8h9lRceVJ8jzoA1zfYY+BoRmO2R3AYAV3Myhcy5WoN
	 s2RlTP1zx8+rafpS/z115o8tzndYhwozIvQ+9n3C/Bl/zUvnU798IA8IcnhQGQh7wdn40
	 RsLjIanXQf7kWPfyOGEknJqcEHqy0h8JGWqQRvDD0yBkqbKv5RqvCJK5SPqt26xOQNHrJ
	 70f51LJKZ1B3Vxdzizogf9PmixuyBi9FxDKrfwu4q5qNy6StZdrdDHVakICttBmSjeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496117;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:To:Cc:References:Subject:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=xZA7Tr2LKk5B8OrbMjPyR4PMdE4D5tho/5FlOXNpgxg=;
	b=tuIss6D3kCpPsEO2oBDkb8ajuH8b+y3/LhEWjkKK+zeiAWalLDeUv2ukwCR2hAsZUpxr
	 tKcreQgyZIiNWa4RLX2wDAd9mQL18hPs4xMhMRUWra2dfko/R9O84h+5i8vxb+u48UuAy
	 2Ri1imR0VJHFQ51Qu8InEaaVViuq/ztOaqVj6Gdn5HL3TICTIfkmVSj4xJxf8mG/vqapq
	 gM16oM5P1xmdC59YWuYBGpm1AvlPsxJ1kUpqeETyGuQyuXawXKjTEMSfW3Z1yHzEga9ju
	 zcB7di7sOyTNjcCOmF0SINhfMW/N8dgxaj1vVEwXaM7YKD9cremY4k5hbHq18UgbHxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b="qMp/GECv";
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30573606A326;
	Tue, 20 Oct 2026 11:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30573606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=qMp/GECv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792496108; x=1793100908; i=markus.elfring@web.de;
	bh=xZA7Tr2LKk5B8OrbMjPyR4PMdE4D5tho/5FlOXNpgxg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qMp/GECvP11giPv/so2jT8KeWvi4+4/M4roLRZL8/5NjpjH6DWVCvcu2Udc5jti2
	 VciVeZZ6la/6p7kwiZ2FHVTCHDvlFRoLRiL1RVMBRuT95fbkHxO2n1z3W6pWacAEv
	 9OdFT4if8YHylTsjGdNbVGWq8UzbDmw+X8zgiO/7jsNu0leHkDk9MhHUOQgOt8pdA
	 dib9VTaGAseZGFMvzAULr6FIPfyyThy2yiS42duPuv5XQBt+dV7aeaRY95AKXLRU9
	 MT2n0F32OU0lmjLKlI8EqLsBZj8UgjRAlMu0oQQ4GecfEQgcTi5fUTEbIXjvE4b68
	 w0kxFSeOfYmtfCYX1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1xBxME1i38-00TFsl; Tue, 20
 Oct 2026 13:35:08 +0200
Message-ID: <25bc6c8a-b47a-43bb-b035-5a755ac41531@web.de>
Date: Tue, 20 Oct 2026 13:35:02 +0200
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
To: Val Packett <val@packett.cool>, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
References: <20261020082631.1509275-5-val@packett.cool>
Subject: Re: [PATCH v2 4/4] ASoC: codecs: wcd939x: fix ref leak and NULL deref
 with USB-C audio
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261020082631.1509275-5-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pWBpvJymoNGFjPjkSw7/ZzQDmgOtzd3dWRUMH8S16EdEhrWlt60
 OJmoeaoqaQKDsSnl0jWWpN5NU2Ky9H9Aijt2l9WFSKM3VSG+mhMjbFyXZgGrievC5wGMdO0
 P0ZX7PVYAZ0v4xTS4AxRVIp0WNI320wE0MnvanTbDgLOaxTht/QeU3x5nWrNBIRrIxIpXT9
 CdP7lK2DSvknk9gV5QLiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0tMmUlccOj4=;xd/AhwK0fqEK2TrfK61eimkjUmY
 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
 1d/zOCpo6Mgvwbv2IGJU=

> Some code issues were found during review of a port of typec code from
> wcd939x to wcd937x, pointed out by sashiko-bot:
=E2=80=A6

Would there be a need to offer corresponding adjustments as separate patch=
es?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.3#n81

Regards,
Markus
