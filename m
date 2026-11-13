Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597013;
	b=OJQmyEIyKFL4J2zlIZoB7pl0MsCzDPdRwJeU9xnp9iiovRZmZXLobUxLiRHe9kI1CiHd
	 wMOyfMoO5GTLLRYdFvj1T2Obj/LEfpfjxBNsZDXES6AbDd98bsQoxuotDa3IOlOr0Yhn0
	 Nvl/PEJ19PwMM+hfRm5NAThGmZBDmd3pqP84/Sh7Fq5NiWh5eZWi64pvxh23a0VUjqZGJ
	 wQJh/vpE33zoQxx+lokDv5N5jVJzuqxxln84r73YraDYZUCW9HB3iwiYyB9+ja8hGFvq4
	 I4dpFD3umGGzofIT0Ouvf+6VNwW8mXxtdhzUOnnH9sL1rXjvyYXTEk8ljW4h3KGThgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597013;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zabQJqh6t7uxEuYlIQWDR7cku3smA7px6dIU8SpBgYA=;
	b=fN/kaNa41IRh7ZixtISv5Vs6q52Y016Ebrp8Cp7mFo1lAIZzxQUhq50LHWW7421qFefN
	 DzI11Ekq+DrMBQopEhvGVIMi1LWZcpri0wN/jirdJbGCLZrMukecucNwQXHsRYHBx0NrM
	 +G+yYgLwWBFLO/JCLnPNIkOTRsKZPylttpNp2oTCa2tBbocX1Ar9gpTMDrTz9nVaGE3mK
	 hG1SH86UHWAjM5nzth6//+6hhBnB4XWvofNkcmj76BQ+zFCjYIi11qwcfn3przs1Dbrxe
	 YWkrsmpLX6deC8Fziiz4CfFFteVX7p/eb/h6S98EuGY1HHA1X3Tgvz4262kfD7W7Knw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWTYQg0C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00A606F33D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SWTYQg0C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB43B1F000C7;
	Fri, 13 Nov 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597013;
	bh=zabQJqh6t7uxEuYlIQWDR7cku3smA7px6dIU8SpBgYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SWTYQg0CgR/xis3k3QzKwIhMJEwlNq0p3qBtiA8bOEVMxTYMo+tzuklGFY+7drVAi
	 HfI5oWBuKY1tqR7EPRtqiVf8A+TdLMExZ6rbKIhg4EMBylI0fl0HplfyLPFWS3JRhD
	 EsgFqbMQioG5krlMtyZjak7X0+SMrM6+tCKGeKhf8U5my6BhLc1LtwtAmyJw4YTpGE
	 RVK/8K5E8VGr3VkICY8Q6d/sZxdxrTRyWqcdzP0KTW8fB/i/kay4R6KZlOViJj2CmP
	 9q9nUu+gRpmM7U9RiDj/XDasZXz5/lMi33X4lJRcB0A2xSsdhG25kaCeZKCgAOJsLp
	 0Imh7sydD26RA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Salvatore Dipietro <dipiets@amazon.it>
Subject: Re: [PATCH 6.18.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Fri, 13 Nov 2026 14:09:57 -0500
Message-ID: <draft-0007-redipietropagealloc6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110259.2901456-1-dipiets@amazon.it>
References: <20261113110259.2901456-1-dipiets@amazon.it>
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

On Fri, Nov 13, 2026, Salvatore Dipietro wrote:
> Patches 1-2 are its prerequisites from the same mainline merge (Cc:
> stable), only moved from mm/page_alloc.h to mm/internal.h. Patch 3 is
> adjusted for this tree, see its changelog.

Patches 1/3 (6ee3d87b9408 ("mm: page_alloc: do not give all non-blocking
requests reserve access")) and 2/3 (fe21f930d1e6 ("mm: page_alloc: remove
ALLOC_NON_BLOCK from ALLOC_RESERVES")) only carry Johannes' and Andrew's
Signed-off-by. Since you are the one sending them, they need your Signed-off-by
as well; only 3/3 has it.

Could you resend the series with your Signed-off-by added to patches 1/3 and
2/3?

-- 
Thanks,
Sasha
