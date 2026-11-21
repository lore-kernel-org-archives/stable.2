Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274883;
	b=ieUfgFmdyxzvbOSexO4oRpMtAQgAAee6B2GABjiU8TNk+PDOg9XUfH5or9Mkx1oM0H2/
	 v+Ge9GfEj1Eq4yCs9x2KVFzipmvMeSz/3OGXSxWrSTi2RIRfyPgl0A7M4o8yJAcNqUVbw
	 8pVYU/ZS5F5NLsjGwG54nXIdn1efA31qoDBZmYvKGUUcw390/PZfg3z5mkjqdqisLkvHw
	 nD0+lGwv3sctnbUWsgGUfWRJU6XNZVDJloU3JiRuCZ2Fd7+yEpeqt05Ahyny/QilSxuJ0
	 7X8/Nt+V24K43clVFYTxiaBq2GmjG/MrEPxHqGlmNh26GR9R+yTpMO53q7x54DepLfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lJ/fWhgBloQZsX6j0MNO3hBJ+KCzL/RhpmbCOG327kw=;
	b=18s7MnKfOgZU9zJfQT5nCXSopnQEYc+GvaMLh63nTdI0+oi47Fzxc49kZxAqZDMkBgKp
	 mOItWMJThWVbXwSiVE4BHYW7vbaDHmphXT9MHTZqd5BrrIa0B67WeFBruTPPUanPVabTu
	 YZEn66gwZO6lAMO5g3vg1xTBB7VTUd0tgpqEKvhV/UzgePCfdsIYFTTu34FshdDjd8lYd
	 99CXbM6zVT5+vPd2rAHowvyoZVu6bsuEe/n0VWd1P4zGUSK0BBGZO7azZ2/CsXFWzvch8
	 OSwzBGjjyoiZ30vf+jwpFhEdmqSDwiLoMFdq1BR0a8zkn3+Ycjnx67qGjFZCfhvWeUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej5vQJ2P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4B606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ej5vQJ2P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729EE1F000C4;
	Sat, 21 Nov 2026 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274883;
	bh=lJ/fWhgBloQZsX6j0MNO3hBJ+KCzL/RhpmbCOG327kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ej5vQJ2PEHiD+DPRnYOmT8GoDfxBzlr1VIYliTNbIQ5fgCsiPJA+V+MBbv4tnjJKG
	 zEdOYFmGLS8hvMvYYiulD5pitH7U++hbZcxJv9ayzreQRsX2aYxiC88JUy7tJTuw2A
	 G+HzzsCtJgWrT47nZY1osYcK9ZI4X24Jmpq9QwQSbjpkNWaUt10FkwnwadJrKS8gAo
	 13wl50pEJEaXY+J77nDjzNPo6N9v4FVAp4xx3BVZMCI1CiKqXxDstxHBUO6ClTMbX3
	 y3XCcbyF6nA5qx0uChj+xSgajmLdJjw8yfxcEZ6cc8jTYNYyN82AV/I6DbXDp12qHt
	 fSiCc6ft2dPOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	tianyaxiong@kylinos.cn,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Freitag?= <andre@brainchimps.com>
Subject: Re: [stable request] 6.18: tracing/kprobes: Skip setup_boot_kprobe_events() when no cmdline event
Date: Sat, 21 Nov 2026 10:27:43 -0500
Message-ID: <2026-11-21-1-daily-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEF_Rj8MFeLOXr+08ykGeASYXc7gCFwNuABiZDm3oC1DxCwoZQ@mail.gmail.com>
References: <CAEF_Rj8MFeLOXr+08ykGeASYXc7gCFwNuABiZDm3oC1DxCwoZQ@mail.gmail.com>
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

> please consider this upstream commit for 6.18.y:
>
>   2cdfe39dc944 ("tracing/kprobes: Skip setup_boot_kprobe_events() when
> no cmdline event")

This is a boot-time optimization rather than a fix, and it has no Fixes: or
stable tag upstream, so I'm going to pass on it for 6.18.

-- 
Thanks,
Sasha
