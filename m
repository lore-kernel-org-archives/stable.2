Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634662;
	b=prDOUDUQHl7dRIKWXaox8wqSuuZCBtT/gE4Ev5kAc+Ww/YrrgbVPhe2LFHbZBdbMr7Zs
	 FZH2D7xHjCgvdP3Ey9zmBjibYD+FD6TTIrMxRJdZeh8GmuHKF5KkmoTaGzew4vJv8XYbN
	 NPqTbYPF3JpetVQBrz9jpbVEAzcoF1e9IitZTQTZye697Fin1GDqURZCMcv+qtVmpyMSZ
	 fzolpm3PRDhvG+OwXn0p2AVG0yISqe/EeMLdTn9n54/N7GnYZGTUEno/gaFYe7qQuacg5
	 aUStjY6jr4pWIhsb2oakOX+wy5G9qUl6ao+neuSuW+sZZE2JY5nepyv/tCJWaqYG3xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634662;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dccJrQdejDRTZVRPmUSOIlKFhJo8jTHrF+T2wh0y7FY=;
	b=gEymzab6ZlCP7n8axZkCuJ62PdMxqwvKZix63goYZdNbz1X8541GYE2twtjcn0bzGQs2
	 jcuz+SprT9N2iqqcotihsujjb3KaMXfzoQD2MAxDqq8jEKgwrdp+dZvE5q3BRyEbcpYrm
	 6r+Z6r9qsA/K9IGOl9F5/jcMVKqvrtA6iVff1r6f/PQvr+dMufxXf07x4Aj3eAlHgsnF6
	 9Qst2ml0x63n0XpqZEr3WzHV1g9/XMmlEyO43ELdj+r2POshkHbzbNjiIxLAfw9IkFEbT
	 UOarSUe998RatsXzkRiPx7NDX1zdghC2jByju4/WZfQpORjG7/JJxQ8L16kDKaBe60Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPHHx8pb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317E606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPHHx8pb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5841F000C8;
	Thu, 22 Oct 2026 02:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634661;
	bh=dccJrQdejDRTZVRPmUSOIlKFhJo8jTHrF+T2wh0y7FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cPHHx8pbQyUym30j3H6tjutNPBPGsqW0Wp4Ro2O2nkJVQGREkjrKBrET6a6B/mQVk
	 xURzL9fG0H1LiY+/OIHjbenkeLpMenMs4nHUCY7HoxiMnLE2NqfSNPbBNxsdqLij1i
	 b9Ct9WOEu8Ra8/vbPr1wEsvDrgzYO66DeraahX42HINSBW5idg2p0eDd3q/pqmYmrE
	 atkU8+4eeoIEAbeMvcNmb78er+zqb6T0pFTAQKyUt0tluC2T+HOpzIqGgobm8gYB1j
	 IOZTEetaJlwqZHDBBZstP6MK7CwY2SNobKE16VBK3p0jueo3csiApGm5E/qJE02n4r
	 0s+6q6D57JIeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	security@kernel.org,
	Willy Tarreau <w@1wt.eu>,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Wed, 21 Oct 2026 22:03:46 -0400
Message-ID: <2026-10-21-1-daily-reply-0021-nft-byteorder-security-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179239012164.14465.16534329674629579851@gmail.com>
References: <179239012164.14465.16534329674629579851@gmail.com>
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

> Stable maintainers: would you prefer this minimal init patch or a backport
> of bb061d3de4170741?  Either works from my side.

Queued that commit for 6.12 and 6.18, thanks. 6.18 has the identical
leak.

-- 
Thanks,
Sasha
