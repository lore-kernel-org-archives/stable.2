Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678152;
	b=NTV7+Gp6IcEmG71XLIPTZwb0EqbfCM/U3SnQmiGhHMWnDFS/2xuFpKP8wSHdJenb67Qx
	 E0/UDWZIed3JSvBrcxB3EETvZ3uw4x06xY0e7OKNKyylK2VIS9m6nSb8ZXguMvK3S9+h7
	 LOTVhDh0X6tOgwFvSmlLTjXp1oKvSYil1I3feS1xKOAv7BrPVYsZlXxTGrnBykPjgmF8z
	 p6q4TPG+CesHpoLhbvzevYznC4upREx/IBvpRW2DiePg13qPQMAI6mE3iTmJcUTXVP0GA
	 7hJH2eF43l878se+9zBcRkFIi41PvaRk26B1CY+72WdDsWBEQT1YmhiGimyHC/+frOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678152;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Us5TKEL+fX6OUB2Gsdj5qlvWJj4EmV34LDJmR5WNSx8=;
	b=4tJq/O0zi0LueSDiC/FQh7uTwlxMtFVAlAIO8F0wD+YvSkni1k1Ul1D5MfuHC6V+WO3i
	 nH63XcGeutgHD9E5AeHwtHLvmelNEFndff5TkXYuCg3URSZnXycp+buYqNRYS5rWYeaBs
	 x25slU8WtIifg2VOyV0JaU679qYkXSTs+U6RFmLZ57+y+MRQgN7ZcCTP87b/MQFY1p7FQ
	 PeZTY+BGl0QwMhI3BzGW/ZIR4IDRJXOQrLtX8mYoet78Ww742ylrp0ce7AvFMAhKw49OR
	 mSfG2eOzKAmI/+jKzxFUmtNs9iTKuf+8+2AUsyGFChU43aoOZtU7eTx+N8COrifQOtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SLVs/8tv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F4606A331;
	Sat, 14 Nov 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SLVs/8tv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E4B1F000C4;
	Sat, 14 Nov 2026 17:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678152;
	bh=Us5TKEL+fX6OUB2Gsdj5qlvWJj4EmV34LDJmR5WNSx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLVs/8tvqn9s9+FTfo9w1DsAEiDv4T1kKCcErXYW0XExXSxAVjZx2jAt1K7baDpr5
	 WGooRuZEKyfSSNQWiPBOpYyfEMyhOJiyp0jEiMKuSUIAC9ZU/URJbcajtjpqqlrL1J
	 EtcmvX5j2CYkB9fK50+wrPqWIvyOmVFyc1OdPsGJfQUewDj6/Bt6LeGbfnQGvpDSn/
	 Vx0vTZI3ClZeonuu8xXCf21StPutdlnP3bK36jjvDna05PGJiS14Pzs+xRbK/Jo2mc
	 GHJLxx0xa4375GUtmbziQVD/cNSde/blx6BZn+nPxJ8xELcs5yFh0NENZrZBZiTrgk
	 eErWbUY7/WfgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Samiullah Khawaja <skhawaja@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Daniel Machon <daniel.machon@microchip.com>,
	Chris J Arges <carges@cloudflare.com>
Subject: Re: [PATCH 7.3.y] net: Use a dedicated flag to track disabled napi instances
Date: Sat, 14 Nov 2026 12:42:17 -0500
Message-ID: <draft-agent5-0006-re-napi-disabled-flag-73@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113-napi-disabled-backport-7-3-v1-1-99560caf8bca@cloudflare.com>
References: <20261113-napi-disabled-backport-7-3-v1-1-99560caf8bca@cloudflare.com>
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

On 2026-11-13, Chris J Arges <carges@cloudflare.com> wrote:
> commit 8dc87fc5d6a0eb337744737008177342a708bf36
> ("net: Use a dedicated flag to track disabled napi instances") upstream.

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
