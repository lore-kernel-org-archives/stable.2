Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794400175;
	b=QCGBQce6qMFFIRZlIzIrhzVORpG5yDqr807Jvze2BDpQ8o6j6opWUauML+bFFmAbGutb
	 /TD2acAIhQ8Q3A7wj8PsCevcuz04EBqBFQzZhYdwCP7efP1zy0qlv+vDXe5GIXay6pJV7
	 X+EVz2ZP4YhDhDXJWi8E93fMoXM2mqqSn2EimklTPgWwEXDq2fH+pf0iXHOvqBtwF54qH
	 qbn0uR/Dxomt4h1UdXMrpEtTrV0CpF0aa5SSIQRMldN4w9Ic9nepKtmy9FW6wAiY/iikN
	 /xMSAYmDCNO/uT5g28JQpKgm6aZO6RkBClssLE5qUa1dntAEkOj3wQYfthUnOkq19cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
	b=khERNbKvLp2M9DAYVDgq8gNsX20ZevKt/58cJcpVi+bABDlZOuR/8XAGbDLYjaRzovDY
	 OtQhGd8b9C4ymXNK6B8rfWTip6d770rTylHCYUAgQFKvgoBt5bez117Uk1gMHRDvrt0w/
	 yBCEpU1q3YpmOsSoooVQbxEYcKiJ4HlIfpNOFjNSivzCPKBOpELgKiH+eZYVmTelnV3YH
	 R5EH4GUzxeuITGBQXaZIX5pOuUHK/Nhc0nQBpLYXdX7HAo48X5ldYdDnEJNkFMx3Rdrne
	 xOppl90op0/dVDjrJqZgmVlYne57AAL3VaPGt6tR6ce/aXHtJ+ZVVWEBzLKjhFqqGwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYWO8fA5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.198
Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E508E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYWO8fA5
Received: by mail-oi2-f6.google.com with SMTP id 5614622812f47-545a4fb8d5dso1315189b6e.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:29:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794400174; cv=none;
        d=google.com; s=arc-20260327;
        b=f58ct++H4VLdxKuOROyS/a7fX4fjuxWbzSFMO8kkclIw/6nCDkAOxzIUIcNYgnGVWM
         j4lJIAtsl6xE0FA8G6OmyxJ2VZrPYjpqosgV2uGYkYsEnrRLXrr4qi0EKKcGVpWD0/um
         wwTWmsrdNq4m4bVBVQz/h0jKgU2Hy4ZHipEWs5NqddmuWBZvmPrna4sYD3jrl7j5+jTq
         VBvbh9VZETXEescbo7m0ZYx0Uh2Cz+gJPMy+zqw9AprdhtfbgFHA80fs6j32zAx83YUi
         KHYW+2p/eTHsOe4xBmgVaJjBNvJWY6b38SJbOEKh5KjfbenGOrGHzWzoIlNOvJ2G71zf
         vmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
        fh=Hg3Tig0oGhVe+V0p0hC6t5ZHN18Mgimi6ajRtLoQzUo=;
        b=FYmkKeIp5pUqJQmWgw5KNIKju+021BjSRThXbWRaZu+zWSVo0t7I/3VgCK1M8yjJsC
         A7b+9z+7O8mXPvktsc0WFo1H4kpCDe/eqLLVWVWCduPQpYPrBjoRZZWUlG0T3wASKUDf
         fYbQvjdokrytlP1clzY81TTjK2YeYhS6nX8hktUcSNSVGPL46j01Md7zF85jhaChtxvQ
         +cF/0UOAcSjRxKIMH2wPQ+JwVnAwl7sM6zx4NkoU0VWn20MYW5VF97hZC7wR1R8EfDnY
         rBS7BIeWJd9bq9dYzbxuGzrhGVRbKIX+8uWV+QFVwcl9kMKOe2edPVN2S67gH0OK+shK
         ytdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794400174; x=1795004974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
        b=PYWO8fA5gRWaYW8Qean7e52jZfOMsPHQuM6ciQ8I2KUqOeKzZ5GvpOXxNAPtY5AhhB
         Cad6nYp76jWYyg20Wx2CHvHn9HHzxxDLTgndd12baYuY+6C0DGzHUKTim5OkboBpeoId
         vehG+laM1C+esKuEV/5zMQt153Kiad9BC2j3B1+a1CrK/kqexT//HR+RqgX6LEVIzh6G
         6CfowtQUsymmzNYPoNwPuVEBXU04FHcImiZvdMF/Eg158rbV/NBP+TjTiJG/F9g2CSS2
         XcOKlfCa9GpvzMZfuzMW+fnlwfT2t7ncVQfJ47mwGVV2PjW5NvbR/mbXWLsk64EGQxIk
         wOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794400174; x=1795004974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ugQNukoG8zuOSCl9kH/Kdlpjvp5xVSCQl/EVqkaF+xc=;
        b=VCLV4gh8JCPtcj298p1jv9HynrZgLovNnLZtpljLyAWN9Y2YI+jxZqxPCp0rcvLU6D
         SxeyvjT1az/6naqaiGtXQY7VcAiQy14wXBcuzHPk9a7SRRRyuwAS3aip5uDJV+eFqNVy
         GpfovziWoLQy+9CwKUWEypeL+dptaU/mcC+hsorC0TMKxb6EMDqyrK6wCEUtCCRwEWWJ
         oKQn3YlHGKJkFNRk3AU8SgvI4ns0VdcVudQp6l5XPZvtWY0KbJvu345RtSWLC9jWn2qP
         iOIgrHGZuPI2IgPIy8cynrepkzt3zcNyt63G80XjMZMCq/xLu4g5wvo3I6fsq517lzju
         S6ew==
X-Forwarded-Encrypted: i=1; AL+hErGF+bET8N4u8nxuV1oIbqnfE7/ef0dtGeZWa+GpcTgIOIxg4PLJTKnyUvl/QeAL5JcnkH7Z5ZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z86KPVP++XZDM7Z0THv5j0Xv7FXXeLXNploVoT/gjbd28//pdzW
	tQV+0ccLxC6YPTJl3Mejbo5/F7AY+pB/g7eb4kTzx/6wulbl40uUfDG9SkKiNyYdaEYwkoV3rnZ
	LWdbpf1PVI2V38hxGMYCnk6z6Mrslydc=
X-Gm-Gg: AYBFou3mwCUbS9JmGBoaLWcv2NLzyAJAM+QaU7+AFvSkkm19U8GR9Nz6JE71yamBcrX
	Xp4kAoGXVEofoD/NnRPyLiERm+VGx7rWiFEOcZSGF9lNeUIIOKIHLlYqzBk5F5q2EyGNTejRlF0
	gNlCYtWIFImzbQZt1/+sKa/+tJYT42HSs3nAZTDzMVUsA0WlYbiMghdV3arNGuc0AqSQryJGcqZ
	xPtAKyeqHmtCeorFZ00p57Ij4CqLMUN7mjTSV47SAb454doZaHlZXZEmOowke/5J29uNsGx6TPH
	M+W5CuMtGTCeNJUy1U176SL1nS3T0PzVwQCtR/MjZxaPidDGcJOb8vP7mlFwQX9P5V6OFxNh4oG
	Ow9AjuiDKXAm+faCrTATxwVK79ybUFFAcBRIcif0n8WfUqARuSjTumZ6FMauiclpDGp45hNAGrA
	fnrWD9Jre1MQoj7k1ts62azaDWcB+V5C1gXZJzRMs4xFCFE4X4TlLDoA==
X-Received: by 2002:a05:6808:4f13:b0:55c:888:2a15 with SMTP id
 5614622812f47-56b97d216eamr1759866b6e.53.1794400173914; Wed, 11 Nov 2026
 04:29:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103185909.71843-1-dennylin0707@gmail.com>
In-Reply-To: <20261103185909.71843-1-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Wed, 11 Nov 2026 04:29:23 -0800
X-Gm-Features: AclHuK_f_I8U-R4ghS55caM--h46bxgyAYf2JvxTYf0GJGfw8SL-RER2v_qKYxk
Message-ID: <CAGEkeHfW2ADNSV7g5JMss8B80T+x8US17Bo51Ypp+1nnoxSPzA@mail.gmail.com>
Subject: Re: [PATCH v3] block: fix discard alignment for non-power-of-two granularities
To: axboe@kernel.dk
Cc: hch@infradead.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, mtsai@redhat.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

Could you pick up this discard alignment fix? Christoph has reviewed v3.

Thanks,
Hungyu
