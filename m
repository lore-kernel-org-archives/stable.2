Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804621;
	b=g+osSH5R23QBp5O7lBlDNI1G5oIErChljfY3O3EjjcqWpfEzCh+Wcap6yVvFiM6ddaJu
	 SPWXiApbTfQRJo+GsFRHjs1AJZVzwHxcsSwCkw5rOOjxuiYQdVC0R9WU+Qwg31rIczs8S
	 5UCd1peqsgXSYfG+HhlekZ6/rkIipgOa5eVCIm8H/6hItUwpUWJFegTxdupC8UqG++Mfa
	 T+lrEKElQy3oA90gfWyhO4PRb6UFN7h7h/FiJXkfq9E3EXzeoSKk87w0oSa4/qWWY3LTj
	 j8/WLrGyX2TlGq7qUsy0a/YjOBn0YKT70EtZ4cNHDJmlHVpR0ZRVewTS2bvXMk8A5Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gTKTRW98e1c/rnf3PvLTQEFwYsZRITBgx+gdr/F34gQ=;
	b=R0ZeZgG2RQlYogJZ75LwCRDL7u5ESF5E9UEY4frS7klD6UbjujBsv//kOqARIjGOS5/G
	 pKpt/DpdkjV/Kj2DepYCVmi+w71auj5Xd8w2KJC/omXliHTwg9rZ8ByQ+jbUoF/Jwv+fl
	 aQ8BFIUULuxADKFe6rfcFwuSEJxy+T0XujqQD9ydY2szJ5Fa/GuHld9hP2idxFtkpL8mh
	 DQL9i1dyZ56bjl2ya1O43iCFpd9AxinwR4jhy5OVxidwk8VZRQxNoX1osrSfF8YazS4qD
	 Wpg5+MOcbouo0gt3h+qKKp1C1k2PCizkyOXryFhuahnLyj7A+ZqRc3N/wAfPRO5lQZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4hZMF9e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67536606EE93
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4hZMF9e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622981F00A22;
	Wed,  4 Nov 2026 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804621;
	bh=gTKTRW98e1c/rnf3PvLTQEFwYsZRITBgx+gdr/F34gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4hZMF9eSjuzIhWF1WML7g3DTT8TS+8SENRZm4tfXzZJMYf1q+zWqmgKljXmbUS48
	 C1QBlgpWOMOGdWj9TEsQdKmQfGWD+5ROndZRCJsWR2FTbi8yW5ZnWREIiMYG4WJo0n
	 v6l1/2iWG9cPnjPFN0e/6PGu1I7ccBvqCv6Pf/GWerkN96WUJhiHY9b/nKJDLJwXq2
	 RF9YBC4DI9+VPv6rI3GI0c2YK3+OQQJOP9zfHb/q2g3dHD4Bm6dfQ10gtvWbxgy4jb
	 HsHf/I6TeIFBYn9kMbbg7ZEheZ7UHSbF07Lc9GQ4wkeEP1ErgHxK/Su2CIxUmWYhUB
	 ZWpQkASnFVgAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jianqi Ren <jianqi.ren.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Shun Ota <shun.ota@miraclelinux.com>
Subject: Re: [PATCH 5.10.y RESEND] net/sched: flower: Fix chain template offload
Date: Wed,  4 Nov 2026 10:03:21 -0500
Message-ID: <2026-11-04-1-daily-reply-0012-re-flower-chain-tmplt-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104063528.130078-1-shun.ota@miraclelinux.com>
References: <20261104063528.130078-1-shun.ota@miraclelinux.com>
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

On 2026-11-04, Shun Ota <shun.ota@miraclelinux.com> wrote:
> [ Upstream commit 32f2a0afa95fae0d1ceec2ff06e0e816939964b8 ]

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
