Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181753;
	b=dcWRpXQb8WUrCaqNKWSgP11dO15BBfcF3zZouZXi8/MZ2omDg9ZleJw7B8kxpEmAMxlu
	 T+HvGLdc+N9g1QphxsTZqLCK++FWZftQUNW3l9qn4y9DRJlEn+KkTc6TvfyVvUqhPPEDF
	 PS+0WzLubwAQpLo16kbManvlfPWyfwdwRCDG272rIwU49PSq7kh5k7yXvkw8+T8lU8UtI
	 vBJiH6L1Rx9Y3HEq/GqYUZakmb3vDYX3UT4AbssL6Yur8b6Vy9JcUu4WV+RQXrBQlg1xk
	 64w/uaGJEsHGXHuWmYWsduIePYUyMJrzWAvvgwQJjMpGlU1aJ6+nCOSJBtpji5HGYlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181753;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2xVdSngyq9+KdrBSI1ti/liUynFrDra0f34hu1gxcgw=;
	b=w0BkJ0qZF0D9khXRmryEoReHiUYMVaCqV87Z4Qr9akE0o5iqgwp3F2fgHg9/7CwWP8kH
	 uqAZc07Mo9Oh0YhAOGksbXKSBzOz1YXmdcvnAAeOsaJnKbJVibDjA2VanZKa+gNufNhXS
	 69hZ+zVC+Nsrkdi+KEemFpCRAfyc/2W3Pxwjz5hSi+hdDSuKM5EPAmrRyIACm8mwnoabT
	 edepwCIotDCjIoedoDnulOEl4gGYS7vOfssTzv+sqzyzs1ADIGomdG2VK2fj21Wow2PvX
	 7qWKaNPIAVC5Jkn95k1qTy20lUUjLe6apXuo0RQ8moOvYZ1zr14HOki51M339jzeOow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=montenegro.gl;
	spf=pass smtp.mailfrom=montenegro.gl;
	dkim=pass header.d=montenegro.gl header.i=@montenegro.gl header.a=rsa-sha256 header.s=protonmail2 header.b=UWIJ8CJi;
	arc=none smtp.remote-ip=79.135.106.100
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch [79.135.106.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4C606A31C;
	Sun,  8 Nov 2026 23:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E4C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=montenegro.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=montenegro.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=montenegro.gl header.i=@montenegro.gl header.a=rsa-sha256 header.s=protonmail2 header.b=UWIJ8CJi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=montenegro.gl;
	s=protonmail2; t=1794181748; x=1794440948;
	bh=2xVdSngyq9+KdrBSI1ti/liUynFrDra0f34hu1gxcgw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UWIJ8CJi4zU7UDITR3aFe0USM5Ipj3NRaGSRTyNZ36+Wzf7IhZpKBMv3i0CS9Ad8L
	 uSHwAIddoTXahaP7Bgp+EbOsumhd0jj/fuPJdCMHJ1jZk/X6f+xT9Ce5cKbLhcXx3b
	 ZGBTWfnQHgdlYsXmwIr4FA2z7VAqPPIIorqncwgUtCbtslGR+7IbIpOrn4OWrPF5bZ
	 LabqchvRIa2c1k6RJX9sKyOikYiYWHMPV50dB7Lr9nJFjh3+d8u5ZjG9O/jWaFaJzJ
	 vEOCgiABWxMPMLMB8ZqZEAgV93LAhjkZ5kgamd4T2d4E2WIF51mrDhIRX/nRNGEh0U
	 SnrB7Wi97iFIg==
Date: Sun, 08 Nov 2026 23:49:04 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Antonio Montenegro <antonio@montenegro.gl>
Cc: Denis Pauk <pauk.denis@gmail.com>, Guenter Roeck <linux@roeck-us.net>, "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: [STABLE REQUEST] hwmon: (nct6775) ASUS X870 WMI board list for 6.18.y and 6.12.y
Message-ID: <OocP7QvaznNsJNvvrIUTZiKro-kv7JbjucsOkkgAjvGbO7C_udRcQGssHVLfd9_Kvlw1ILWT2dCdB87IIu_5xVdg1bLvtRvsPvHH5OtlDXI=@montenegro.gl>
Feedback-ID: 178316558:user:proton
X-Pm-Message-ID: e420e8c0504a24c9f959743fbad7b408edf3788d
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Please consider these two upstream commits for 6.18.y and 6.12.y:

03897f9baf3e hwmon: (nct6775) Add ASUS ROG STRIX X870E-H GAMING WIFI7
21518579cbde hwmon: (nct6775) Add ASUS X870/W480 to WMI monitoring list

Both only add board names to the ASUS WMI lists, so that nct6775 can access=
 the Super I/O chip on X870-series boards. Without them, sensors on boards =
like the ProArt X870E-CREATOR WIFI only work if you boot with acpi_enforce_=
resources=3Dlax.

AUTOSEL picked up 21518579cbde for 7.0 and 6.19 only. 03897f9baf3e is neede=
d as context: with it applied first, both commits apply cleanly to v6.18.62=
 and v6.12.113.

For background, TrueNAS SCALE ships the 6.12 and 6.18 LTS kernels, and X870=
 boards are a common choice for home NAS builds.

Thanks,
Antonio Montenegro
