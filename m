Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434103;
	b=Fjp6kOJ4yH8ucH3n+FNp9ooHoQiyl55obHG3w6qH/VI/aCWJ0y1y8Eer3VSrrMawdcx3
	 p79sOg/qtZYnR+dvqS7qLXr4l5E4bAySHGxWsf5delaefjjZdfKwoPKR35eYgomb7r31r
	 Ukq0e8i4wHClnTwUWECYDvAr9epNAPjTZQAqPXkS5zVS0Qb2ct1R9iOLquc5N0D/Ssjwk
	 TugOCfxNQ74CapOb8v4KpCYf8dgrcvSeg8LVDViw4yeAn2zJVCNiNpp7z1uomuirXKn2Y
	 LHPv1xw+d5WuC7UT/Sr5qtLeTW0L/eOVeoB3iS5mCPOSaILlSGpoFROP2hp+TC5dzFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lJ/sa7cOLCqV3ZffJzIa3c5oX7IqQgiTiV0JIpQYDkA=;
	b=MyNqL8PrKNmBIwZfvYxUckXPJK6B7d/u/ZmO3w3G9NkPPQfr8nuzFCM5+aohGor5dhYt
	 2BEfwIzWhcTUf1qyeaU1k0M5h1x5v1bprZuOWJ2EAKoUxEr6S7A3C27oj+5kdkgQJsImJ
	 sc/gmqOVwgkLhwqIUD81eyHtE9wrDYXkyGLi7xvCDQe5vguznSn/rgopKElXeDZjbxxK3
	 Rqa7P9VPY/W6449wQNEZtjaKPxsPy0/6YkDP7R+BrYhA1BykaoFDgbt5ZuCzCdQckLRvC
	 QW/7kw7Al8IUgJkVIhI9+OhAfVksF1amhxkWRmEY+nJ/KAU+SnhGrqSU0Om4ZpiYwUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V06NWR6G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8060A5BC8
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V06NWR6G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7381F00A10;
	Wed, 11 Nov 2026 21:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434103;
	bh=lJ/sa7cOLCqV3ZffJzIa3c5oX7IqQgiTiV0JIpQYDkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V06NWR6GjnFct+lknI0ByIl1X1wmHvJw2r0WRZSCITDWYtZmVSbH1UIeT2VylYkrp
	 1VWGVp00oX+QFeAlsdj3xQ6Ti+/2r0U3y9iWAoTHRFqmnV70VfX7RnQZ+WRi8hXP/a
	 hTlsPyA1AWtitT3uiYZMbn/QQIXrMQP4q+qTxlj+yiOSaNPBhMCw9tLmk7bdU2hYWv
	 Y9NWwWTtO+ZOAE76xa/1b8XVs7Md+y6IXUBUqGfSjnFakE29zzIi5dCAI3nuDCY61D
	 vjtPiOp9uZ2ka5lBjcnu4chWJK1ycABxTPIQMaoiZgZFiYNFAZSv3kcn1hiOqPDGNQ
	 Rh4Zsz549/uPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Federico Musto <federico@rimpianto.com>
Subject: Re: [PATCH 5.10.y v2] net: atl1c: drop oversized RX frames instead of panicking
Date: Wed, 11 Nov 2026 16:54:35 -0500
Message-ID: <2026-11-11-1-daily-reply-0002-7bea16eb5824a831f575@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111042846.78846-1-federico@rimpianto.com>
References: <20261111042846.78846-1-federico@rimpianto.com>
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

> [PATCH 5.10.y v2] net: atl1c: drop oversized RX frames instead of panicking
Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
