Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526320;
	b=PYwjbgvRrq0lFq+XOZJGMGMrT5M3k1CKb2ibf3XpQivmQ8l9pTOKwPXKwo+bc+SXfcMl
	 xoNKKd9mQ8C06W1+EZpyhuY6LgsvtNTmOg4QLRSKJ2du7Eh7KCmXbSxovZxmkajD7iY1F
	 Kv8Vn4vH5TS8bpTYjJ6mPcqj71lo8EVCDt8CVw5yClqTMI3XThz84ueUdoAEEd1SSX3X0
	 1lncrAbskgy2oS/wjeBBgfa0Wx6i5C6G3A3tvGP3yF3JjgUl2+J7zS6VVpcEG9zZ6Znmi
	 rM5444/XCH0akC8rYgrgsVM1vV0sw1i/uFoiGQaqJ/HkZdAnFVAc4jPiktgiiKyuz4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=kMzA7RdrHgK7flc6um3AlTABD686DqJETvpWPCal8Zw=;
	b=ZnyrcG1RNLKXnJSo5gMLz0sgQTz/d0n0pVG9CObjchUV/VD/ZUXswPyrjsrR97rNLit8
	 xkezvEDfaChh+es3wkMKZNU1e+Bz/00H1Z6ySeu5pHOy1gfJnsEqKvVowMMTx5Mco1DUl
	 BSuLcXb8GzYlH9zqViUDIwhoy7Amt4e97Zhq7DgzafPzfN1g+qis6mWyP9Y8YAM3Qwcmo
	 71qzn55f2460m+l2NyRX7Gb2IJR5Fmpa2xjUfNA6PLhxcnEdTEz9bQkEJex/wWk4z35YY
	 L8YtjHy0kGg4EZcj4k/VQlFsLizUt6NNqWOlrpTFgycXuNug7iH8Hy/zpkvkadtGdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VzWPUERq;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFA606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05DFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VzWPUERq
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so131184b3a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794526318; x=1795131118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kMzA7RdrHgK7flc6um3AlTABD686DqJETvpWPCal8Zw=;
        b=VzWPUERqqSmQqQM5hDEsdSFki9n/UIur1VKToOCJ+u7iNAsnJjDwlsAXYeJLLJNrIC
         DRBtJ9rMTryt7Mjghelz7Vtc0JMaAAG/tOICpWH6hEIGIb3nQN7QjgDRo/z1hKg4VeWe
         8xSl1upKsD0Cn9UV1DMYg088MTCGOgpC8pQsxVQ1rZM+Dzzftddx07AoAobG2ki5Qy4p
         DUNVzKWZO/uCmXmZdr/mOrxgJcCFozcNCSHKAKN6+Q4GHfXDTYXp8whxShRhLWt/3IPp
         T09dgztMTHpowzzy9ZH/UlDTtAhXo9SGPilZraGS1Sp3RVlG24Z1EvoTJGKVX3UUyNfO
         rpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794526318; x=1795131118;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMzA7RdrHgK7flc6um3AlTABD686DqJETvpWPCal8Zw=;
        b=VzyJ4HfY5slkuTtiERF2GMWaFVF6U3o4/BCIoHgcSghzI/8XEEpx8EkqkMJhe3fEzG
         f2JOsxkiRPaEXhOvSY2RXiDkWKmT/EZFOnrg0cSGz4FDkewDm2HjnSHX52JJEFM3FdFz
         IoQ2NRFRMbhQGTCJPGcoIZzOkoveAZfiLmZxQfCmNWDEUByQHVMRRc5rrDnZ6xoNtTdS
         NJBI2VEZ49FizoaMqyJRkIiV46kh93LC4XGbdUtD7hL7s6eCpu8n/F00uBcmnsv7AZSe
         WRAvAqdOUEIv8bGj/JmEtul8dMl4m5tNfGR9wrs/80BCT5uUQQ/n0moRBMtVxqmTinDw
         iWvA==
X-Forwarded-Encrypted: i=1; AL+hErE0ZgrSdPy16lpbHskigWMCimb5jwjZSdHhob40qsSGlXcQIOE612vOZauEOBFjPmFrzkV6uUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9agU6CztE37qVC142I91N9gtUjCDrESriKkG8wlw64Woi+PIq0
	FnrN7US0i2845QromxdICdWoyfmqkTuadSNb3AB33PwUaU2Ls4LM7136
X-Gm-Gg: AYBFou16c5VU92BLn96zQFTMOGdZLMiJlvwTmqnwRtcZrJyTHAuoIBieKiWWD0IzO4e
	gqIjkbZRTsu7D5tc3NxRFiFQI3ohUsXW8CS2IpJ8p0uKDlmuxp0lu+tBtAgWUM0pAvPBLrmMeoM
	V4FfCSC/3CCRlOMyPQX/NUglz6t0Y1Yz/7pMaBldBQTJ041eHjYibSt8cGK4Wgz05uuBRR3fsM7
	tXIDvvYysXv7+vXyO5NyxuKkQiImHb3HKahq30FHW0ZmaeDKlVqFCnUTFlbmiTHEMmnzr3pTTj/
	lp/Q4ba2vXlm4Y4yd39bDBDkq48qf1wLq2xuLHJ7/mXxgcyyAFRQBGz16u15AYpulUOnoC0CfDA
	d+dL0Pb0a+yBlioLbsIWSzreQKcX5Nu2+f27qdmTXgbnot0qVuA2T5225Zp7VKHmAftE9ypNqOU
	3jRDrvHKG6LLOwMqND/dfyDX8+HurtB5tQjfzQqbuEVkreWEY49HUMy08IhqS8eMlfdS3kePDie
	lyxM0bAYNHHbzVe8KArVmdN3vdXqm4tVkEjRykPDUV+2ytQu9SxV6nWrCpCT9WREZ5eNxTTmiWn
	348NJLLus0TJGN0zrBQgxOlDRr0jnqlvKFhL0RaMI9o5zHbLOP/n8zVrXWmO20yGr2PjDSbf810
	ULmvkkrgZv9pa99rugTnsH71kKj37
X-Received: by 2002:a05:6a21:6f09:b0:3e8:b7fd:6265 with SMTP id adf61e73a8af0-3f7a72ba1d5mr589620637.23.1794526318165;
        Thu, 12 Nov 2026 15:31:58 -0800 (PST)
Received: from prox-debian13-dev.listerlab.win (203-96-142-148.dsl-dynamic.connections.net.nz. [203.96.142.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18adce4sm317815a12.23.2026.11.12.15.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 15:31:57 -0800 (PST)
Date: Fri, 13 Nov 2026 12:31:37 +1300
From: Patrick Lister <patrick.lister.dev@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Keith Packard <keithpac@amazon.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Nick Clifton <nickc@redhat.com>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Ramana Radhakrishnan <ramanara@nvidia.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	Riku Voipio <riku.voipio@iki.fi>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	luis.machado.foss@gmail.com, thiago.bauermann@linaro.org
Subject: Re: [PATCH] ARM: nwfpe: use task_pt_regs() to find user registers
Message-ID: <avZMWY2UBFdBLrqW@prox-debian13-dev.listerlab.win>
References: <20261112025159.473997-1-patrick.lister.dev@gmail.com>
 <0384a52a-31f6-4bbd-9de8-8efe73610e28@app.fastmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0384a52a-31f6-4bbd-9de8-8efe73610e28@app.fastmail.com>

On Thu, Nov 12, 2026 at 08:58:53AM +0100, Arnd Bergmann wrote:
> The patch looks fine, and it's clearly harmless to merge as there
> are no users, so please add it to the patch tracker according to
> the instructions at https://www.arm.linux.org.uk/developer/patches/info.php

I have submitted patch 9527/1 as requested, thanks!
