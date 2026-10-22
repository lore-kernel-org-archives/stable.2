Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634658;
	b=NirkBeMKkcVJhFT9Q06bACMFnfS6SQCZZhAZJqhostxafREjk13e1NE0btW+LnDtmG7k
	 712eV9yP2uaJDrt/VimmBHXRf2km+onhNQGCjqLDc2ajtCKo2K/r+HWN3H4py6iIOjY6h
	 +3cCSPMsdLRkVZiLm/CZEOde6qMC5WZKaaAA1PVHr0G+jmCkokOVHNXL+ta4YqYjRn5g9
	 iqFyzzUeNxfxTK80iovxC8z6KtUovxLNkJIYSKfAfL6HUb+yRxrmNDVcR3pzzX3RS48by
	 SIZLKssi4ZjazrIzAhwoRL1uvWGT3QHkaiCgwn4nAc9RFqSF6r7qlTPF7fLgf2aBwVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x0tCXONmKAc7czkz0/Sv3TnnrcScjQD3wjpCw+uFnms=;
	b=Aa7mA6ylyEaATXKHBvaunJ4ihpHF+Dup6N+b0/ReXohQcWXMwjb7b86x9c3VCkyw74eO
	 rd/k1rAMm7N3aTkwhM1KmkpKbrAVQXNwBtNCfv76lmP4X/5o/OrbdfALK34I4ymamS8kN
	 sE5s2BLGgEBfhEQgb+S7sfDQALrfTaE6yuohmW20oaV4JqKS6Hw8kDMLAfnmpkye2qdO9
	 yJ64qECIKzoQYbSrj86xG5I1X8hZJXIbFuuenbgbh7UNgZjoGzkMflBzrYyPdlReB+Mwe
	 Z5ZPx74kAOfOXKsGoEv4CEglCHVjzLYo6oIqvSsWkRMT58SEcPTV8Gc/Z2AC75F+5sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4GjDfAX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EA606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4GjDfAX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2DD1F000C2;
	Thu, 22 Oct 2026 02:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634657;
	bh=x0tCXONmKAc7czkz0/Sv3TnnrcScjQD3wjpCw+uFnms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4GjDfAXySB/aif5Mas3P2kPZp7X6DyPKp9AlATXeMmyzJmkaumEgQnSAv3PG/uat
	 gJ08ug2yP1VywyRquwUGb+mZqf9BMgcwUNNJYr6UNybRyD7IRdLesOQecSgguesIHg
	 vYbVDwJfOoVwGJLALXQAiMhSaGK/RZz6LQNhph7hjLaslpK+fw8eH1MCw5V6ctAnEK
	 qm+1G+4I+4ETom64ugO8n2xVud+pkEghVenda1eVDQba/KswE1HtQJFXWXc/QA8He1
	 ziUeTL+v4+Bgf65pe7o0Va37lCwx2YSOwU7O59D11diK3cJxvydQJYHa7DePvDmN7V
	 7EDfrh6A9RcKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Di Shen <di.shen@unisoc.com>,
	Ling Xu <ling_ling.xu@unisoc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 6.1.y] OPP: Fix race between OPP addition and lookup
Date: Wed, 21 Oct 2026 22:03:42 -0400
Message-ID: <2026-10-21-1-daily-reply-0017-opp-add-lookup-race-6-1-already-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74405-6-1-v1-1-3ac1824de8a9@bootlin.com>
References: <20261020-cve-2026-74405-6-1-v1-1-3ac1824de8a9@bootlin.com>
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

> A race exists between dev_pm_opp_add_dynamic() and
> dev_pm_opp_find_freq_exact():

This is already queued for 6.1, so no backport is needed.

-- 
Thanks,
Sasha
