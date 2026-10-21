Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600713;
	b=hrHMrAPxh/ILMh0+voH4O98mvrfrx+mIrQW6fuB7DQSU6j8iA6+pC3F4xvJAflLBK9df
	 AYGwlC0HObEs8Wa8s1O4At4/mzdbQ+UUSiN5N31NLdEd2MrcOdR3v/KU+VAv21e00x0C9
	 6riJM2brVQsCD0ffR36wv7VQ8bL1OvWKycIRzG7GjtLFbzFW2OHPGHIlKYggvtDWgCLJg
	 IfgGuV4ZlETE/t/yqGVK7xSZjgixF5yhxhQZvkE6n8s35YXXnfPStymB3F0MElqv8zX7k
	 uocDMkNVKHg5b67c8whDlqz4s9NRQd37cdTcAO9LuVfPqbY9BsKRn3u3e2f1KQENgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600713;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=C2WIUAy49gs6vfvzT/Qt5wlTvvXfJdz0ejU2p9NvaAc=;
	b=JFAAam3svpDYUaYwWRGWLWuNV948hZlQVkxryADLjw73Ar3z1eg0+/f91jac/Wzpiexo
	 7kYWxLCK/C53C2HrdqFhks2b0FzxkSKyUi1OiigmoXjTu8gm2H8IIAqpcLhZJn5sSYz5/
	 u0v+UVGhhZZeTUvWErByCZH4l8I9b5q6nIGwhTe1uDC/Va3ZDD2XbIi+dmZvlvnYwbobF
	 p9BC8kOq4I8nB9yK15fAcoOUKLPN0Z6OYmsSppp8yXbzs6CNySmMwTWY7aU2JV8tO0AJF
	 qBLYJPjXhexE0opjHAxMc+fST4tbO4NvUdh2+gqyezexW2ZZu5CiCOueIt61tZ96dpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VugT8O2x;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CED606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 16:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3CED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VugT8O2x
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 00FE0C5CD40;
	Wed, 21 Oct 2026 16:39:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3392606E3;
	Wed, 21 Oct 2026 16:38:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3ED2103289F5;
	Wed, 21 Oct 2026 18:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792600707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=C2WIUAy49gs6vfvzT/Qt5wlTvvXfJdz0ejU2p9NvaAc=;
	b=VugT8O2x9nWAg/rEXGCa17ZUQ6lahSz+Sl2WieyEiJ5IxxzVbP6J1H5lLIC78yFSJKFVHh
	oPSXnqtRW6U6/nqUSg0ivNHBFQTeSYF5EU7FNHOkPf4vAUD528T4grFxWzoUVHgGDijnff
	DiJoyGIa83mUIW5AR9CTfjl2gJaPFz4wEX1++7CmOMQz6/LyYTM7M3Wur1puttKXJCkCi7
	u9HrDApj4JeLpKGr3HDAzggZ1bt5AbjOImw6jDskwkRyQewuTJS8FmItZzhKTMTGUw6vzV
	ltaAmn17PKXcbCSe/4MOK+V6JD4eUlg3jwtQE7HKNKQe5sYwcnhdo9sa87AJAQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/28] mfd: cgbc: Zero-initialise version buffer in
 cgbc_get_version()
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261021121245.3111563-9-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-9-lee@kernel.org>
Date: Wed, 21 Oct 2026 18:38:18 +0200
Message-Id: <179260069841.1125687.16461366525950099809.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

> If the Board Controller returns a short response to the firmware
> revision query in cgbc_get_version(), cgbc_command() can succeed
> without populating all bytes of the stack-allocated data buffer.
> Those uninitialised stack bytes are then copied into cgbc->version
> and exposed to userspace via the cgbc_version sysfs attribute.
> 
> Zero-initialise the data buffer on the stack to prevent leaking
> uninitialised kernel stack memory.
> 
> Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
> Closes: https://sashiko.dev/#/bug/linux-8c473713-527e-4619-8404-689f28c7654d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
>
> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> index edfac2b60718..7513ba42eb96 100644
> --- a/drivers/mfd/cgbc-core.c
> +++ b/drivers/mfd/cgbc-core.c
> @@ -461,7 +461,7 @@ ATTRIBUTE_GROUPS(cgbc);
>  static int cgbc_get_version(struct cgbc_device_data *cgbc)
>  {
>  	u8 cmd = CGBC_CMD_GET_FW_REV;
> -	u8 data[4];
> +	u8 data[4] = {};
>  	int ret;
>  
>  	ret = cgbc_command(cgbc, &cmd, 1, &data, sizeof(data), NULL);

Yes Sashiko complained multiple times even if I already explained it cannot
happen if cgbc_command succeeds. Anyway I agree that things can be improved
but I would prefer in a generic way:
- add macros for cmd resp size (eg CGBC_CMD_GET_FW_REV_RESP_SIZE) in all cgbc
  drivers
- cgbc_command() should return an error if data buffer size doesn't match
  the number of bytes returned by the hardware, it is not the case today [1].

[1] https://elixir.bootlin.com/linux/v7.3/source/drivers/mfd/cgbc-core.c#L194-L195

I'll prepare a series if you are okay.

Best Regards,
Thomas

-- 
Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
