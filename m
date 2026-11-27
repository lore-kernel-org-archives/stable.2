Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748973;
	b=0i4uWX/0e1NbKHW5YncFUPfBY1SetYCvn8/dOrEr3ObLwuxtI0yKGoLnf2Wo4qwrOLpl
	 lKsYQXM+RhIoAyIMjZIIbNgsiho6k3XjY6btAdg9ovwKYCYmhjnssEQRrFgiQDq09l6Ts
	 MHpQMza3a5hfOzbJpVS90O+ZOo+FeuvyDm0EoLSKcRiA1qQ6g4s5yAKm/r8kgxN8Jsnla
	 f9eejq9XpBietYCfbKKMB82pqEKeP6CJqUXQORE8ZKQEaOoE1lqmlhZKIlHLUExP3F9Cn
	 nHC6l3xPZhEhUUcHL7pLVxm1Y/hCgA8Bw/xEr+Ifz3/m/lPRrdDlsdSOuvAoBAH3lzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lYdXgvNP0+osPYkNvp5kuJoWkPSjofQK2n2XC+K8pfo=;
	b=UlZrQ2lad1EIZN6Yx3lD3SA9slU5L3N8tzOedBcP17VHkrUHwLuXaU4d5mbTZsRZg4lc
	 7qxw8HmuQSPLHVyXWbtsGFAqUOERY+K7zqzdToKJYZZ0A0SltWG2HTHF4oOY4+a3ro79m
	 C8/QcA/BKCm0x4ntk2a6LNjKOt2EMh8T29Cr3u3V2yE74gvSCus65HjaL9S/PpbXIDyV8
	 JPp7lxvpFQYPuTjFW84m9S6PplcvlTe1NaCTRQJfQJqdJlTd1BTQKjIkYgeg54KE2NO7R
	 s+Xnr9ddbCgjUItE9X5bbRSk0mNPOOBuZ9uH0NWG4JyLAxarm7eaglUcs6iPoiV9IbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrii.net;
	spf=pass smtp.mailfrom=andrii.net;
	dkim=pass header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=KB8PH8Fw;
	arc=none smtp.remote-ip=74.125.82.227
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EB606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrii.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrii.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrii.net header.i=@andrii.net header.a=rsa-sha256 header.s=gmail-2025 header.b=KB8PH8Fw
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-385d8a00598so11132664eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 19:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrii.net; s=gmail-2025; t=1795748972; x=1796353772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lYdXgvNP0+osPYkNvp5kuJoWkPSjofQK2n2XC+K8pfo=;
        b=KB8PH8Fw7SgTQKHOGbHoQOc+kp9UfGQLKkah0BG5SMsl7+YyD3yfrOo1szuMxsVfgh
         JDVvNuvpQ+hC5sYQv85XG+7NbrUnp6k7gVeH9CzWaRXyQffIAzDujsLObXfaLm1kJMYC
         hldQSy0znLpSteuiZ09fidyzBGCnWE4JS+ZpFZCSl0Wn8z0PTDM3Z3E/XrMdsHfx47/1
         htaN7bDRZpKdWqST/KLJObhT+GBomN0mug9S3X3cb4ALsnt01OaAMZxTEor3+iKppHmJ
         g0nQdb7at8godzHEgTXNJxhd4BOa7PZeBIx3HCsxHNR7jM762fhqMjAKJjPTAF9qoEkh
         fK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795748972; x=1796353772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lYdXgvNP0+osPYkNvp5kuJoWkPSjofQK2n2XC+K8pfo=;
        b=Se/K6ekuCLnNXrLuW7XMP1zfQuka5WfNFMTf93RsTCPL5QEO4GvuYwvRuNyEoEpI/U
         qXcYP0tVfpahcDrN1f+pHKxNClDUJ0dEag9bbdX3AJGF6TMpuO9ei621zMO7Xnn4m080
         LFgxnxUoxhFXS4ap/P1OhwTgqAjAjDxTOpvBP2lBiVX88m0FdQdRS78aKAq2Dypvrb89
         4Lew7sPNwglHPCB9hqMumBLVuBBd9zhD0XueHoYz3+BG3vp0FKAKpd/Ar2eS1vn5/e5i
         OSJMzefpUZ5JRV8bvnCbkcSbhYAm6yjay/3gWbQ5B/V0IfRJJkaplIEAvj29jNFe65KZ
         +qMg==
X-Forwarded-Encrypted: i=1; AL+hErG0qIOsL09TuSbz1kU1kRu/mNVcCPgDwpX5OY6rjMOQDeFptAYnxWa6KstHtzxWT1TnNupcaYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8voNX4JwgVJYXAfssr/E3WZ/BQ8Iyvx6z1tkGHh+HPYCywRg/e
	4/7Sqyl4jp2DrodZxVf4iSVgbk+I2BGbgygDrBdS6Vn8p8YeSBhX9kA+0JC4EktNafOaK1Su/+b
	4mKWcjK2ZvSPj2pAfJyX2UTbnX6vdg8W6QmkyyiYeN7Dm7/uc11c6
X-Gm-Gg: AZFdTZdAz12Vox9jaCq+w9Ct53UupFlfoiuW1ducPEEq4nRsYkI8ljUfreIeckFEdcP
	JN5qQqEVlAD3ygYX0+sIX2OUOinEq20C6V6nlxy31iBimr7SlluwCOo7mykZKVdTolL2C9bv/mU
	zPueJpw105OodaAdS2flY1J8KO+yXiORPEhXyfQbDxluyJIw2KGv/2BQoeP4D6uCbQsDvHFM4+S
	cISObMcw5IB/852VAXvgo4e8VXI85geSKXIAv80NIrgD5VyDYUpIKBzpKUiHXUYGOJ2PVHXjrF4
	oYXhblMqLZyqxrfNuXKAnGNBZgyIjaPwzYiWKUgykbPzgCIuqdTPD2Ubs+1m7UNl4lWWeyXRWjw
	0l+METlsiN1fXoMzort7uNghGCbE=
X-Received: by 2002:a05:693c:65ca:b0:386:b826:407 with SMTP id 5a478bee46e88-386b826061cmr13259762eec.20.1795748971828;
        Thu, 26 Nov 2026 19:09:31 -0800 (PST)
Received: from andrii.ai (mac.hestia.andrii.net. [2602:f337:ed:4865:7374:6961:204d:6163])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-386c7c627b0sm1659379eec.23.2026.11.26.19.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 19:09:31 -0800 (PST)
X-Relaying-Domain: andrii.net
From: Andrii Tereshchenko <opensource@andrii.net>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ipsec 2/2] xfrm: iptfs: hold the dst while a packet waits on the output queue
Date: Thu, 26 Nov 2026 19:09:28 -0800
Message-ID: <47c34f93-d927-4052-acde-83a84e5ef373@mid.andrii.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <45f802a2-c639-44bd-aba0-5c81e2198c9e@mid.andrii.net>
References: <b56bbced-a8b0-4ae9-80b4-1958ea36684c@mid.andrii.net> <45f802a2-c639-44bd-aba0-5c81e2198c9e@mid.andrii.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this one: Nguyen Ngoc Thang's same fix is already
upstream as b88c75488ecc ("force a dst reference before queueing an
skb", syzbot 622de7e1f18a30fc404a). v2 keeps 1/2 only and follows
as a new thread.

Andrii Tereshchenko
