Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AAD3EA953
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414546; cv=pass; b=cuctUr3H798Axfo5AcMWW9row2Id451DOQGGb6XwDGLiiIFMjsF3OvDaHgKWseHD4hZxt42LDgXQZGnYxQ2VssX7+eEruJQHG8GmDyi9eejcbhz/SVGJxvzsa2Ox9VgfJU4Kue1JiT+xQBr3J9sGFjvO9cCWAJTx+hXIEhuaEEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414546; c=relaxed/simple;
	bh=oKhZRKSNDQsRxVT0JGr6nA+dxNnWA37kOR8/qGg6Q1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTuRZ5kCyuWo0Fml8hq4wNVmj54ot3Lj4qlnwdNidc6tUVpuWguqHCBdbK3IioXB4izf+Y56HXMpglSkGX2lCePK08u5UzfX8p3H8dFe9srGh2l2CxhdONJzzZoie+8wOgXBwweNNOiTGQKVdaMmGIg6yBbsx1n78GF36DZN72E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=nTWtNnAk; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="nTWtNnAk"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423b08b293so1154197b3a.3
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 08:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780414545; cv=none;
        d=google.com; s=arc-20240605;
        b=ZnRHgxf3U3vjICBuo2X3ohgXaxm+r/a0KEzRUTMJYXjf5z8lmBxYb6Y5rTcxGx3gH5
         a9mwqjv0j9XY3gVBae0Td3S80NKJujtk5SHYaRKNr2ckDiXVqbSrCiLOhaYnvmVHxXwT
         hchiVf7rBS7ZqhkWo9M2AvVux47NEuv+Eo62I+C19io98D+MlZ8C8aipIqxpLEEcTiPU
         EYNeOTryJPdYsz06R2hf5VvitKchawJCWAhxx0lxFW4o1nMH8Hfk4KQZIw00WAHsRqGd
         i3fYkz947DBxc4HU24VQTGnDnDkXWMtSm5VrnSooecXwqMM5z21cn2rC7WM+388h4gqP
         b1BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xIH2uRX8VoTWmyY9T8w1tKTf1uWV1y+wbUzLia8/LPI=;
        fh=TxNxS2rIJJEqMKNZZ00mxDGIXgGrEXSB+078z6eaZv8=;
        b=ldyFtIMvWacK4q4S2PXJoPmTeXzXxHu5SaDkWiYOkyUx0HJqNSEYxM4BjQIGLhVk4E
         z7TWpCJ63TrLqsGLqeFHeFnRJGMMUIxTG7ESpmIdxUP9Z2Mctt6G/m5lDRZPzUipzdqP
         7Ug3L46rglh666POuJ6vmrl3DuG6CEp3IiXaSXKINLMHS9jofALTDeDf5xMzFFuxAhgu
         LA2jFS8ZIOeTR5GooBafS9TAKBnxF3To1CVSjwMs9LVrd8fja6VXKNpZ0GnC6Mkh+5hg
         dXqqedEv7sIpV3AHh+QRSTbaGcMloJ7BBL5htHPPG8wTe6MGJDoHGAWfuA5ze0AMx9Ps
         i55Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1780414545; x=1781019345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xIH2uRX8VoTWmyY9T8w1tKTf1uWV1y+wbUzLia8/LPI=;
        b=nTWtNnAkx2IZWX2abNaxi39nj78ERcYHOQaia/o9AT0DuOcSJkDKIYJ4VnHqmaFVu3
         LfRcqexPGednanrxMWijK6dQdeuj7Pi5A3nx9YKv/CQclRE//vE6DIKj6d62tR4D0wuw
         zpFx2j9j+Re94WhP7QfWxYNIH03BJfbG/Q24E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414545; x=1781019345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIH2uRX8VoTWmyY9T8w1tKTf1uWV1y+wbUzLia8/LPI=;
        b=BFGi4j10YaqIgwdoKiYtlYXOttBNeNoL4fg9ky/5xUoODSifUHpgySIZiEsL3G+1pp
         a18lL/b/A71QuCu8zcVKT2W5UfEYfVI/LYHY+2rTzZwMYVw1oynqBQosR3QBBcLtm9Qw
         CL+LE+ftefw7EXWaWm66JpB4T88lqjZ+lF6fls5TO9ExSGqHlxEXAjd6uoZ6LSqetkjg
         u2vD10H21Q0ApyshrLs0X+HekVlJj85Yec4zG/GpI1LpTHxKckNLQioukHU8ByTLzMrP
         7PIVZK05a6tTt4nfHdJpPLAwRbnLIp0jmNATtw4mrOn8mQc54PfTLx6FV5xvc9fRCVzy
         jWrg==
X-Forwarded-Encrypted: i=1; AFNElJ9yTTQ0dWOjNEAALdPiq/6ECAFDQTO7rjeaQ7hxZF6JQ4wa47afEj8auRkTaX5YI0+djL2a43Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbslztJE9DES7XrNqn1ffvPiQ0HfulHZodMQ3QOpr0vK63TMi7
	iF+7R1SbORz43ux5YXDeJkeuiELkRV2VEf7ALl1p4poyt6E7yqkBwXlchOlma0DU/nRXPXXDR0t
	8AoHb3MqUka0D6G8oawhpHmr6DtNx+kdGMw9boF6+KQ==
X-Gm-Gg: Acq92OFpRpTCbmzvyFnbNxJeHZntzuUyEH1ohbtNx/QMjMDO8ce0XwT97/RdDt+wvwD
	TxCIA2t5x03b6uYPf90Yazx6OIZLHD8eEau46G8Q7M+E0rTEXivHd26585bKcfda66rk1Cp3HOs
	aBXJRAYA2wy/VUraXMHAd6Q2HacNFy+l+fh9liC8pwZF1/I/kXDI0jZRiG8dYHgS60yc9UkRLXL
	u67ptarmu1cOkRyRHBYATfGHB0mxBv5OhU+WneKUxQFRzmGIYA3g2iNNDnZbyV0hrAlIDHM+TDL
	9287Ytl/JDkcqoShUgT4KKae9HDjzTUZMgiUGaQe7I0iFdYEbERhryDtQ/3nJlNNohTT0i2e8Ft
	aeh3eakApGSbiE1L5Qlx2OJUSTFnw0uY3WtHHrvYcLG7pe0DWs5iOIorXECrA2U/tFoVakATrQ6
	nWijkl+uswg90AIlIqtIRoHq15djFwGhoEol641RGG1SyhmTgq6UVDRxWZuBk=
X-Received: by 2002:a05:6a00:1bc5:b0:82f:9985:d4a1 with SMTP id
 d2e1a72fcca58-84282f4be9emr114808b3a.24.1780414544733; Tue, 02 Jun 2026
 08:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601041336.9497-1-daniel@quora.org> <ecavEnqJTDXvfFykc9uJb5No7ioighpjrCdw2CFZ4c8Izr5DxpTs-606Bg7K0RtHTaOqksWivHxWQLzMBP6qow==@protonmail.internalid>
 <20260601041336.9497-2-daniel@quora.org> <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
In-Reply-To: <ec7c564e-745a-4998-af9a-e9632fe063f7@kernel.org>
From: Daniel J Blueman <daniel@quora.org>
Date: Tue, 2 Jun 2026 23:35:32 +0800
X-Gm-Features: AVHnY4Jsj6RGlQW4Ea0C-JB6jRZRFbYG2MvxlnfYpmwEKpWeXFNaNH003Nh9F4U
Message-ID: <CAMVG2ssnyH=KUKrdfnUOtPYU7p17inyzcYWcKhT4EAZxDzDjfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for Iris
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Bryan O'Donoghue" <bod@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 18:27, Bryan O'Donoghue <bod@kernel.org> wrote:
>
> On 01/06/2026 05:13, Daniel J Blueman wrote:
> > On X1-family hamoa platforms, Iris DMA below IOVA 0x25800000 (600MB)
> > triggers unhandled SMMU page faults
>
> How do we know that is a correct address - does it come from qcom
> documentation or trial and error ?

@Vikash, beyond your comment I linked in the patch [1] kindly cite a
source for the different stream-ID <600MB behaviour, and share
specifics, eg if silicon, firmware, or driver and constraint, defect
or otherwise, so I can include a definitive description.

Also good to know if my workaround is good for long-term, or on the
other hand handling streams <600MB is important/useful.

Thanks,
  Dan

[1] https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574

--
Daniel J Blueman
