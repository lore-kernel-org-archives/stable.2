Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815930;
	b=HjstLumnf8ZhzhKOK7y21Hms9debbbL9/fz3DFFHDq6aH7vyX7sU0UlhhsuRDBxHKbeg
	 u9aEx6yb3fR6Q6lmdeMc4G9rvxZblVgothAEQZrZfltHb48SCfjEdlEbHGGZpXqg8L40X
	 8r0gnjsQ4YDnFxwEH91hP3FMk0AgCBa5NrQ4Sn4rM8kZYPKcWkLmmqNHxjo9NB7ILz3su
	 lio8foDI95fBblgHARAPLG5OIypRhRGRjE58427kYlrj+314MhPQLoeYbYRkPSJPDRG5G
	 Bv+5J3RRvowGg5F9RBwXRUFkLAuhqOlR3kliXCU6uybDy0XnkcUh0/2Q/Tkq3ve1Aww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
	b=QOlp5dIa6EN1ZEXQOtGOjTtEP1jWZY/E6QUal6vZWWtxXmNNixo5G6qPp9zY0wOSWTXJ
	 xi9Zd3925S58+lxi8KPHZhRIbKcmhhe038+Z5K2cdudtLApy+Foncs9pkzi7HHWT5Gx17
	 9GOAXBuX0xktXkphffy2U1NtzeXRZX0EWkG8ASyPK0s2L9dUZTLeLJC98FaVeZIcn5MlW
	 TtoaMrty7hbeOwaDhwAEqs4bI3h35NdO2sA7mq88DLNNSqx6gcnHzKV+IlX/lyy59p5Wg
	 fszTgaSW4dS9gxzhhmq3g0oLx/c2TBR1Ec8cHwN7z2wVG76QtMWrWoAW+i+ZVsNZc9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="m/LM6ars";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5307606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5307606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m/LM6ars
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so6958785e9.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815928; x=1795420728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=m/LM6ars18o8GDKRmm846P52W5VTEeLVl3zm4E6+Ukoew1PNUWaySYAFTHbhwbIHY6
         8zyWRJ3E+soSg5cVCg675JZQUuiKrI7PnShT86jC05Ju/0/IRheNzvGNmD+npQLbnkn0
         fy8Il1K6Vm+A5YZwCa+xzQ2+KQuOMrOvsBIKg/ExEvAa5Y/VxNmGrq1rCHU6BtXLMwTC
         Wsvn5VDRjOEmowS+ZSTEWPRIhLKHrJyNPuqywDI23KP2brkj28XF72ButTpsWAH9l4pR
         IypEgitHhE/vdzZkz5m5Ua6ccTEUz62Pa2MJahrsFOhrSRlAMMkSQY6/3R5U6hM1aN5V
         0hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815928; x=1795420728;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=gcDY9KDOSzd6G/p4nlM10ctiwYPXBM5NjHDJnnez1gjljUruv26u3nLrEvYURcG4GP
         DOTmzwpqJgKVSBJcCHnrXUVSC1PXjdWWTrMbm0cCGtef4xWPkQezwzeFvUVmy3e2/DZI
         HGCAYt653H7jPXDpSH0+Edj6/ZVsN7CEHlnU9RiLOKXFp87bJsUanwCwOxxV7D41l9rA
         ZwK2V9RLfBPv5x3KchKI93tN3dkds1Plpi00ZN6MHf4k4435iuk3ZKCv2ohBG9HlcH8O
         at29PHxIG/6S+WAAYoU0u6CXPzuk0z7fgbmQXiANt1mqklgsQM+I8UbncJGCQTANajpX
         sk6Q==
X-Forwarded-Encrypted: i=1; AL+hErEl/rKWwVHIqlJNn+5VsgsDRIwRvCLQgqOXTu9C8VE8zRstLvSJh/0iSBWKOn7BUkycfx/q53g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rmS/ANu4UxvrYjtzxGeDsTrkigBISD7Ln3wui/UhuPE0PBng4
	A8Qz2ocLlAg+AUCHWcHGB0V7mZ03zf3tk+QSDnAgtUPiXP9HkOgxlcVfUwbcwTpLEgB/
X-Gm-Gg: AYBFou26eVz0BAdAedVj/74n8K5BvJedcL6ZGcZ+tpOabVxfR9/1Z6IeM80Cm8aHp3K
	1/FyxKCFwv+Q7HIgli4zNaqw7lDLuxFEMrNuhnYNzGeCt336SiRCUTEBqrt36nvtBUB6NtPav/v
	+B4N9gk47F7wtcTB71HFEerlCvvB4rGRU/LXHcYH6enJY/Ckod7PDpisT0mDGoVDO7Sm43lcBY4
	OV3nQiT9cQR7eOlB8dqx1DnlzN/Q7Gkuvhehvtb1POtyyXGCE2vfaWwxpjotU/6Moxn16I6KwE+
	2bB4p0LExO7ffMAAV20cXapTmadWFfdXb71AFV612RbUsu3adF91tNl7ZOay2L8zTeCxv8engE1
	Uc79HfAWkTgD0QniNFPIiOETBePnE4SBdcy1zqgLDq+/K7XnCin+ZJy/KWpzbYeN4HvcDD/tzXQ
	rxFCLT/pbZhNU2J5QGKFaqfQ/yA4wnHUP3dujxM26cPgC3nSRYJui22cPtfIzKJ8jveCbmYmrEZ
	GC9AQsq4NeCD89PKJ3+Scu+bptdZ92FU74ve/7D6eWVAUHglYAWUKRYCDH1cvFLMlNCYnX3jWK7
	LcDPizfHZX/Ie44npMhaXal0eDUrmJbAY8v8Kb7VDM6FbbbJ5mcai8iUnNVtglw=
X-Received: by 2002:a05:600c:3b07:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb5de1f216mr172834365e9.1.1794815928232;
        Sun, 15 Nov 2026 23:58:48 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm375768305e9.2.2026.11.15.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:47 -0800 (PST)
Message-ID: <aa32167cd3865049bfe0281b8b651c47f5e1c05d.camel@amutable.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:58:46 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns
> that into -EFAULT like any other short copy.
>=20
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/sh/kernel/crash_dump.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 19ce6a950aaca..85c0e58f1a59f 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> =C2=A0	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0
