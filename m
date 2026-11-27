Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798905;
	b=ZsVHOYL7efHJj2xFxPHtuhVFweC9TohfCr/gD1NfbGaqY5Hg2s0R7l0B+GVhXhOFhnww
	 q6jLhPtSijyL4dil9roAP77kvICY3fnY75uvK0+eDNvR+e2CmFHXlV3lKT9JyrVzG4+Jp
	 HBFxa/1z3xCSP4oPgBLWNQwzPwizaeyvV1Bl7U0cKdo2tznBIIcKToBcm8LNVePNvawqR
	 GaKZOSCX6gDbaqqJ33m2PvyNNbcZYZP2R08mzqa9af6JjKQ/C0lbZroDmMjM29jZ/bcO1
	 g16NFO8vd36aMr6+t4hS1/o40ApbMSexj+tlWdMGlzgldE1XKtIbMzmkQhHa0ILVIGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gmDBznwXkxDqv5A0rN/N1rTTmTG+4Cws3rW7DxhgFTc=;
	b=TmDBH0L+8DgWSrl6kwyAOKJntTTge8+7HCcflb3lK/EC0zT+Ia6l4Jl+owNKPkwGklWD
	 Woy5gchEl9ATZfMlwLfOJpz+7YLd13V++S/rg2DXCy4fzydq7O3tSKovcUxI5huUh0J20
	 CnA2Lt038E5gnvAmhhCnkk6oFgWQe5U+oceOTX3SXpgf0q7aGxtVCSyJXStGUbI3Ji06s
	 a4nw229ifNRnVwQnqCKxX/1V2m3c1dyGMq3jkX9iXJVMy2D/9yrAa8u+U4S3FckYwGWim
	 b4SnMro1a44S4u8g+2EUH0TiSf9MKDXwQk+ijSUh9ukYwx6cwV/etcJowxJHewQgo/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hY8qt++w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC8C606A331;
	Fri, 27 Nov 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hY8qt++w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D55B1F00897;
	Fri, 27 Nov 2026 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798904;
	bh=gmDBznwXkxDqv5A0rN/N1rTTmTG+4Cws3rW7DxhgFTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hY8qt++wozYsI/i58rJEucUjZdHw2uPO07CMyoO9HTLBYp+RrXuPtPqNY7jT0qEz7
	 LCJvFY9tE2VGu4mSj7XVlNS5j0aIl3lHf6mqPLZxGmH0tMs9MEifwG8ByYQRn+3wZm
	 L5nL8mLEPHEhpAemFmr7SyExiUCZfapU30baz/UJFon+7xetADEBsVpystDsMimByU
	 d8lDKV3ykGHdHfmltXlhHG6smRrKx4WR6FgzAbL7nUSppQZczqhvDkLBy7BhWEcaFb
	 AqUGYbEZ7l74ouwbi62PEQLKgsyusbw+Ij1tPtw4WBZP+4oMjwtv6rXPJlO9PKxBrh
	 hkbB7wt5x4Q0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jamesburton@meta.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.18.y] netlink: do not free nlk->groups while lockless readers can use it
Date: Fri, 27 Nov 2026 12:00:55 -0500
Message-ID: <2026-11-26-1-daily-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125192338.48141-1-artem@trailofbits.com>
References: <20261125192338.48141-1-artem@trailofbits.com>
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

> netlink_realloc_groups() uses krealloc() under netlink_table_grab().
> Whenever NLGRPSZ(groups) lands in a different kmalloc bucket, the old
> bitmap is freed immediately.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
