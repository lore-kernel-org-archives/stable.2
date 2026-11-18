Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961207;
	b=W+/XaVARrz8D4ZQeblz/c4Xok6Dv0pA/CIh5h9YxSZpZvsIbyLeyPqv4cgx2ofFc2pKU
	 YHoME6exxQWx1mCmj09j5wAJnYGd0n/hnIaPWekR0gGGl0xhvnpvZzRr02OO1dhxHolHi
	 3GQqw5Y15JTaNt0ALQYg4889OqmSrwzJiGKRyqIuoW9280G2emefvbrFu7wl5NWW2hxyT
	 bJCzxk9uzQPjjBr5qdZna1D2ph2es25aCisiUzUOBmghwXupZbY7wKEuxSAwiVO9ufVS3
	 /J0Pr1toLZnrgE4q+H1W8CxAMQhVULf2R756sRMxhGuxiAxP/EhC67/5mXlLeRqFaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961207;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JRw6fEvSDbVhRU8qh+aETvS7Fbkzj3KZVD4IK2wFBqY=;
	b=vrhPeI1Ic+tT+axS0KZSpYmvc61yc/6JBFzyZifu1ItNcvgSN5S7vk0MC+/YUUMwexdE
	 MBx7MEhuEzVIv1PRkyGzj6E0Aa8iaejM0sQyQZ1Oj9ZtXBYZ65EhGr+ituEHeFfvAgnrg
	 D3z0Bl/towsZKXTvKim3PI3Pb6JuqslY4fvEPnibpgRScOoFFgyztPLsUwCX6NyAdDUmx
	 d4bKRtB/2h6oi5jakJzYYDxeT5Z/yJUqA16E193LeQvLunmD6l8IxtdzoMigTn7ASjAwv
	 6p0qyZM0zxDgi+4lxM1bscO28+tl2BhtoMHJbFe6PzmjstDSEihcn5Vj300w573j32g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nE4t4pYg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69650606A333;
	Wed, 18 Nov 2026 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nE4t4pYg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929D01F000C8;
	Wed, 18 Nov 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961207;
	bh=JRw6fEvSDbVhRU8qh+aETvS7Fbkzj3KZVD4IK2wFBqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nE4t4pYgB1yY9ZNJ1B2RKAkcSkBbt2b+/QxmUfj7BRSEob37v9uJVwIz21Mg+WLYF
	 IYdeailZMAmDZJSHiBV67s+AYO18rH1+21VTDvWQMEAm3MhuIKQr2tRMJ+iR5k6If9
	 oBpllGB6y9jz65V9BhzwSg+Bsd7KDeUe1MZ4i1AXJ0h2OyRioZzhCUXfXSQ1aQKtW5
	 Rwyuayw42nLJteTG0zs1fcob4RnjyOeDjZhlPtGdnkHZm77lKekdFigQE3Rc/QbHyP
	 EIc5CI23OVudhX6KrRMXjIPpRU6LmiSXUasWGvFxuYJ3epiEGHaTuWO1Q1BChVzKth
	 aFr3DEGeNKZtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Mark Polyakov <mark@thundercompute.com>
Subject: Re: Backport request for 6.12.y: mm/damon/reclaim: use parameter context correctly
Date: Tue, 17 Nov 2026 19:19:54 -0500
Message-ID: <2026-11-17-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
References: <CAA5JH2yO-gw1gn_172hv0YWFfQpkXz915a=uoVH+e49P_D8-+Q@mail.gmail.com>
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

> It seems 6.12 gets backports of most DAMON fixes but this one must
> have slipped through.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
