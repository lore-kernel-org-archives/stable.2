Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239638;
	b=uNJQrYplE51rvDXjX03zK3HZQjlptM9Oi1mHN5N9WICqAXZaAgIgtu3CZdcFingloJ4t
	 3grxHrr4B+bjwLnvdDmkSB1KCa8d2vnH5QWiyvNrX/TNGysp3ANkWPpV5mx43m36QlGAU
	 PqTHVdWUe6ZJ+CZR80RnidbrwCbUz/1SpOKmtnoCaihnh4KH4cXrerqJFutuv/nJjd9e7
	 7jSBEHoLQGLvErqjwVcyNmNcVRedpClUuNeKK320/LEMCsl3e5lfQOwvW25R4eaqidyWt
	 2iqT2pitnJijHl6pENYmp9GwN2tEau5A79CHkzGHHVG7VhB3vHUKSEYUT4aSEUx5B9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YHo8jJzjTgHiLDH4pdwyc+USO6nCTbTpjFSkB/FTifc=;
	b=43na/ChweeweQJw+dkfppxczh1MNim6gwsEIM3Cp8/DkrHjraxpYw3iKEWlicSbQG+Fo
	 ElnqmNfMP+7ef6X3zwpyUCdxptFoVrU5ofQrVCLICzMuiDhd5PhiZ87kc+0dIcfKauE0q
	 Xoy8OTWt74JCBjHBAc75o9hsyQDhwx4oVVBAPYsc0453AX5cMA1vJ5BLjhN1kAy4+VNR6
	 fdVscdaUWBAiy+WYE5JhEXT/w6Yde+l9E9ZOGSElMC3lava9CFTYAmxSYRthfh0JsqlHS
	 bll34YCyMfXCQTvGZoiS8nYCdqLhHElmrQoRKKoWaWmQ05ux+eGNZ2NP3uD4rQQiXHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCeFzQ08;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8916606EE87
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCeFzQ08
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8731F008A2;
	Mon,  9 Nov 2026 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239638;
	bh=YHo8jJzjTgHiLDH4pdwyc+USO6nCTbTpjFSkB/FTifc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BCeFzQ08yP+CW3R5bwXr0fB8HSPzkXreN8OWTz2COd2VVmJFUvg+e0SmZxW33aBpg
	 HTBoN6pkx6EcHoWvlU0U0W/R8L3ZadEaj/jPwEO2+Ki0X3k47L+9DjHf4LqQmU7NA0
	 V/5eK8SeqH1n3lGckZO5rV7SUxKc9lLyW6iPcVk6gQIyFiKg6CvNVotv1oOgQIpo8p
	 IyWyrSMyw14c6smWP8cCkxgDbXOq0+O3drM6Kwlo0rTW6Iu3IZB1o5+NnmChURDw8Y
	 K13Q8Qu3gTrFIXtbtU3x+RhyQWURbqIqRMpYzwGjLvCoOAoF2pq0yW9GjEstvDcURN
	 p/B8Z9+mysx0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	hannes@cmpxchg.org,
	david@kernel.org,
	harry@kernel.org,
	usama.arif@linux.dev,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	ziy@nvidia.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Kiryl Shutsemau <kirill@shutemov.name>
Subject: Re: [PATCH 6.18.y] mm: page_alloc: make defrag_mode retries follow the promoted order
Date: Mon,  9 Nov 2026 10:53:13 -0500
Message-ID: <2026-11-09-1-daily-reply-0031-page-alloc-defrag-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109113007.46714-1-kirill@shutemov.name>
References: <20261109113007.46714-1-kirill@shutemov.name>
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

> mm: page_alloc: make defrag_mode retries follow the promoted order

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
