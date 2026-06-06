Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A03B2FF1;
	Sat,  6 Jun 2026 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752697; cv=none; b=HLlRPqG0X+k55xldb+5duwT+3SFumegp/7nkrgOHlSpXNZS28x1Ou7HBrR/Fka0/YgEnCPFF7O/n9ZaGFcRO5ziPv3ws7YHyiSRzKPqEw+VJCqzaOAOx8Zc9WOyrPpcCWkxDqFYtQlH3b8aUYVMUgFHZkaVKLx6CQ45aukY9k+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752697; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTOhKgGg7Jida1r7J8gdhsMZS0ht8zt/ZTlrtrhVYScppLOSbcKpqA+fq7c9yUjXHx/W/uKD1AQAg1pqzaNSb6kjxdYFg2XRg8vAq4iWAy5dYt53TRnoU/PleAgIC4aq2KBH89TnvQ7opsPFi9/iQ/dCk8LXeyZnzMUmUrRXc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb8qMDq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb8qMDq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B91F00899;
	Sat,  6 Jun 2026 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752693;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cb8qMDq7EkDP5+UtGVouj9wv6ricBE4nwU36/63nVZRa0HgEFXFFVDj+IaweH324M
	 pFX4vH4lUMX3lMX/jKz2TZuFzH86UcU+lv87pPeVEz2TPK29kZpd2WfFoJf6OF56L7
	 nTqumVUNJz4MzcuNoW318jRzY4yJAs+rKSz6XjxbX8Jv7bp6mP901pQhvhSWdQ/3MR
	 fIMRXF+80DaPl8LPPT7WQufjolOoUjCC4NUj0RgixqjaQN9yqBDMSQ5F0D8IBiIjGN
	 Yzu1li6pAkydqCTyNaWbzSylOjwlipmljMVEhynLDMObIv2A+SyvJa31MMQyRc8wls
	 iiJbB8lstVOAA==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Sat,  6 Jun 2026 09:31:19 -0400
Message-ID: <20260606-stable-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605141254.1177152-1-simonlie@amazon.de>
References: <20260605141254.1177152-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
