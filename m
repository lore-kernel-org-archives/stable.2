Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795338789;
	b=GBuNZdysx8NtcZZ10YohitAj8HFgdTj53wUvwh7n6DsjNUn4ajfZ6xsU6UODCpbN3VJh
	 kUTtNLKFTD2UeWXIyyJQwoAna4wdoiPAmYJbzEwowu+TyO7WIVNtHNszSeOoxDsXZCXeU
	 IFFnsw3r5cVf1lWslIhuL+vodMjL5kG8ZrcB1JS84LLpiCk0wKlScQL0Kkgq2FQS7flda
	 kVaH4C0JY5cYYfv1pFnGKlrm9fo2++4yi0DTHbcfxYrSCptYu+YrJxAJ9lOHMh7Cf2V3z
	 NQBqU7qfvBX5fWfTzlQ7s7EOtz/9qXMDHOsyMQwBK1s5F9aXzZRwRC2c+VR4ZarFL2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795338789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8epGz59D4MdEX407F6itbh+0d06Zih6gwa0uldXtP/Y=;
	b=EX5lVo/BEt2qHGTUBsKg/zbfwUWRPmX6VMWgSHWOoOcYy4w1cLe99PoEl3+Upw5h4mXq
	 y3fGvp+2N7uGTjsshpxdRDjbYBty+zOGBMgcZVvIKR7OcaE+2jE3tUsDRT6Ct22bEF/0e
	 cq/pzAbzAxRalyXkP9/h4Ay+bDqUpkh/jX/J0KZGqNL1hn10r7XFTuO6M3h8apZ4Df/6X
	 BULptn2Rd9jEKnkZPESTlu9/Ns5YGVlPt3PYTaQHIrXCLeSmREGWQ2cTVrG+KnN/l75jf
	 eDQ60uMIqRn5fdlMDA3b893w9LgJJbVTfoVVyHjGjUiY6+8r3JP7ye/aoZUkmQ8NQKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nhix75pl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8423A606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8423A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nhix75pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3adf222704dso2588141fa.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795338788; cv=none;
        d=google.com; s=arc-20260327;
        b=S81Bsk/b0mzEZN2/fLMj2dYc6D3d/X9TxD4vWV3p2Sgckj/T1l/6OQur+2ERez9NAE
         MZ2Oo86o3CRB8KTgsZTuWVF5s7MUeWvet+h/LN39Op6SLXdo5qzGTQ2poCEejXu4MNVt
         mv/zem3VXScg6bmTZgC9pdQuJNvmIBJ1pWGzuOc4gaUSnfCND0YC9DkfzLIxNF0KU0N6
         LrAGyw8Mw11pv9LCd85fayi9Y7UA75/D5mvvY0/cWkZshVuHW+dUpgPuD8NxcO5PhQaa
         eNn4FtAosofuvVwZJ8Dau6hzCmpRhQaRZS8GmfAa/29a9sQzME/GnwOoZrVaUcd9fpje
         OVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8epGz59D4MdEX407F6itbh+0d06Zih6gwa0uldXtP/Y=;
        fh=VLPH8VgGfSXQkjPji08DaNTzATOQpiNC7hpzK00JEPU=;
        b=qMlDdkrkVGS+IYJOdwEqTEuEc5yCl3Luehx0mQvd4cUZWCBpj+EzqQ13xGy7M9yD1X
         lillrHz2W/6PQU5WMsO03gP6SFgB7DZ+iMZSxPvJBk9Tr5oVqEJ2KPrBAJ7DiQFOuR//
         oqNkZswNQpETpfRmb0eI0sr15PJcOf4yEJz3YZ4hnT2MbzqHswjmBqhOpfrXu40WniVU
         MLNKvhXsUC5pL2YJ/EE4xtYyt2IOULvoZlfKFasRNvc1jj+UUVHWi5WwagzM7Bv74T4G
         EKyN0Ia5+qxUqIDL0FE00mSsMC+RzehcTDVrUK8qJjTXNi/twWh5p+Uc+CAbkWMEZkbB
         vDGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795338788; x=1795943588; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8epGz59D4MdEX407F6itbh+0d06Zih6gwa0uldXtP/Y=;
        b=Nhix75plpaCdYQiudOKv0rShuPrvyg53hwlzuk4Dml5eT8xu9SMPaTf+GbNlHPeYD8
         7p4t71dRhnM9DmffJEY4b0u+h3oO1YgqhugpxBFpWgk4AaqZjupXmTxklIZcLY7BHdE+
         P6GLrDXq8buRWmmPL+jwx8Ikog4ZmWeRKXk2Q09O1LG4iD8Ag4w8HMAucLtSRvLLdgyb
         tl3za4m0Vja7nuxGZJgWE+JvKZyuix5P6VKFFlPK6vRbhZciS4fvdlyzTXsxe3h2X8HK
         Zkicap6Jcrfeln/j+/Rj1PsAyGufyu7TTM+4vNIZtMr9xad0P54bU61zzfGFj5LETGfG
         v6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795338788; x=1795943588;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8epGz59D4MdEX407F6itbh+0d06Zih6gwa0uldXtP/Y=;
        b=cXdr8LAW8/G0kr/5YGhECFaI/7E4qMbgaGgq2mM0rARKRNdI6nr0BnHeqa364pI7pi
         HG3yqJfbamBKa5L64vaiTb0djVkU7UCYvFmYMXDOJhSwvKrjjt32o6yi92ti7dFpfDym
         qwPHtRQ+3VO64SpVGp83UVDQYcdh/PcaCYobfaJYflsoIWfnboqoXxLG5fhGS99caCWp
         VrlrXq/p0e+SHfQr8s1QOUnCXuruUnz0Od25X39LoD4czbTBvrBDlHMILSPQxZyNPFFX
         7o/eq6PIUoBWeF8I4rTAxrhodmbOyWJ0cM7q6e9frt2YFRI5bmEP9kAGz/aJqvHpIlGG
         i8tw==
X-Forwarded-Encrypted: i=1; AL+hErEc6LBKHqwwBQeqPqtVzdyuov686h2UBwkoivQetflqZi9UX4fxsfDXTCNravcPCjjvnLDi28E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/h0ESuRtojPE5IXBvR2AAaZnSLm4taccehOxGZj/VI4VgMSee2
	9ts+7AhVEKH6fIG6oS4EmU4YN9FHkKrdp3XveG4lsqx87gqcOX2iJSKvhW/aIDPsEDS9dR0itk/
	maZJ+Taao38V9S1Von2Owg9QOcAQxzdg=
X-Gm-Gg: AZFdTZdpXxsljnDUMjkeVss0B79eQf2q/AacbrHjkfBk04mWCTIVwarXI10i3H/k3nz
	3oyrMSU0aOoVW80EJSaosLoQvStmEdt2iC4mq+vxiEiXL4sDBJIiuWEslWX65ZnPHYwre9AqTy4
	2P6SEaG7TlDsqIi7a3UpC2iZV5YrxVxgn7biMyt8KmMfi/MSPiqbJmzgDULr/ACt8S/uAi/lObQ
	+5Kcy4KlTQ4QBkxYuKDD1b85Gz15j4pOyNlo5ECGvFxX8PKb2B+KfHpPsm+3zQ9cS8mvHfHXNGZ
	TdoAkIorCE1Q3s1TgDn3OvsL+yCcfwiMfHhgR42dcfj68FmOMLih2nNwhoLEqesOBsJN8r5M6US
	8t7qZDc2aTjkxPeyMkOp7sHApKSH24UuWo5+JSAsSFZcRZTqxIq2mDTNEC1X2uOGu1cG8yTs=
X-Received: by 2002:ac2:4c4d:0:b0:5c1:5703:46ed with SMTP id
 2adb3069b0e04-5c308ed81f9mr799710e87.6.1795338787631; Sun, 22 Nov 2026
 01:13:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com> <7dee2bac-9892-42df-b2d3-62d648af3452@lunn.ch>
In-Reply-To: <7dee2bac-9892-42df-b2d3-62d648af3452@lunn.ch>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Sun, 22 Nov 2026 01:12:55 -0800
X-Gm-Features: Aa3M54p83wm_hVpGZBJqvMK9Qxelv-vsaTFx_mZWuVaXR63vDKf_CE4mO6QIPQ0
Message-ID: <CAEy9hNVmG0FiYWR8ENyQjfnCKrcMrNNJtTMJLZQ226FQjQSUGg@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Limit the MTU to one
 descriptor buffer
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Russell King <rmk+kernel@armlinux.org.uk>, Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 21, 2026 at 07:02:38PM +0100, Andrew Lunn wrote:
> Is this problem specific to the dwmac-sun8i?

No. As Russell wrote in his RFC, every core with normal descriptors
gets max_mtu = SKB_MAX_HEAD() while a descriptor buffer holds 2047
bytes. dwmac-sun8i is the only glue always in chain mode and the only
such hardware I have, so that is where I measured it.

I will send a v2 that limits normal descriptors to one buffer in the
core, with the lower sun8i limit on top, tested on the H616 only.
