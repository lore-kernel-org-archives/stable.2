Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795732767;
	b=YeGvfmMLfgGKPxL7xbXrr4wWbB45PMDjTnDcL1m8V2sQvGo/5nlmHYaqdSwhu7DIhlkI
	 NkC+QlwIT0Iynm6UnxA56oytvGEPlaYh45WfdpoDrCnmPtv6kcLXQfureGUO3YoyPIU5h
	 rgrVXhh5k5NocKnWVrDyk/lRXqfTZP8hvGL4GxjVz6UZbGxjUs692JRJ7ZjJmX0COSnjF
	 5072P+NvMjiWbLe8Pav0qk1FoMQsbMRSVWdyfAZmqRzT1333JWS/5rq8FXLc7e6d0146y
	 0FzSaDalU8JNobLCyEE4BIVx2UeUDV2v5PLhckvk380ln2W+6I86felBaWRLJj9EhKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795732767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XLVLk6tx9szQj4RRuuOODEHNywl+w3WIa0JhuMX+CyM=;
	b=nW2+OMik9jFHd6C1gRxBdPEK49iz8NpJ/NJprdom/12/Xp3o8rpC7Cxoy0FotOYa8sBB
	 bTSv3sCvwFB6Ud4W+em/nk7OC8OxhLKEPRdTAmVHxix2rkZBexQWmke+9F6V8gfuZ3SpW
	 pEzcebDOtU25ZM5/I068PHcvK/CEXQxyrSijG/ZDiKtSkLjpKKOf3O6jD8ccXSWe+PSCX
	 BfRDRThyZKspAlPhzIgZO7cwiD24L+JJc4MQ9ZwEKNjRyrlRheihf0waBsFMipjk8VnMt
	 YvvSNwxMrInBE8tHXCLkH27nKBG6cG8aT8RnpS7cgjxo0vhSJarlvW+CTSyCHsD14gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQso9WKs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C699606A33F
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQso9WKs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C581F00919;
	Thu, 26 Nov 2026 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795732766;
	bh=XLVLk6tx9szQj4RRuuOODEHNywl+w3WIa0JhuMX+CyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQso9WKsFUOitjfiBczWc7E2vu7kya1POvG2vyenxG+FvBJQhqOz117aHPsMaSU1s
	 ETZ4lxC/KRqGHDJtjqO5xaCT6s5WdFu9eIfb3klcwiMGDYmu82ul4OpmVoLDy1W5Tw
	 camdKe6A6fggExcu0lM232x9+wYszRuT1To1kY6pqSNhwEr8+PkHCFViD/g1N0hnHg
	 F25tPkIzyZgH5jbemwJViHqMwpcM9qLEhvZDQ0gVh7npgHnBMRiOEODhuVr0d9zJ6k
	 Xz7o40Hb7S8of/8Yp7irOBxWSnno2CBc6HIzNhzexqEwvp0nNpezDrj3Af09JsgkGz
	 HC0cZkuGpi6fw==
From: Sasha Levin <sashal@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Salvatore Dipietro <dipiets@amazon.it>,
	stable@vger.kernel.org,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y v2 0/2] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Thu, 26 Nov 2026 17:39:17 -0500
Message-ID: <20261126223918.1165617-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5b47ee1e-0b0c-4b0c-9db9-43c9fbaaec96@kernel.org>
References: <20261113110259.2901456-1-dipiets@amazon.it> <20261116111734.3798483-1-dipiets@amazon.it> <5b47ee1e-0b0c-4b0c-9db9-43c9fbaaec96@kernel.org>
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

On Wed, Nov 25, 2026 at 10:51:16AM +0100, Vlastimil Babka (SUSE) wrote:
> without also b480cbb071020bd590a0dc0166635b448e9fc46b and especially
> 9f2fd03c9bde366c928c9242fc9b2e2c5111a134. We didn't initially thought those
> worth backporting, but now they should, otherwise we have a weird
> combination of behavior for highatomic pageblocks in the stable kernels.
> Sasha can you see if those apply easily wherever 6ee3d87b9408 went, or need
> help? Thanks.

7.3 already has both b480cbb07102 ("mm/page_alloc: don't increase
highatomic reserve after pcp alloc") and 9f2fd03c9bde ("mm/page_alloc:
use existing highatomic reserves on the buddy fastpath") from mainline.

6.18 and 6.12: both apply with context changes only (on 6.18 the
gfp_to_alloc_flags() context differs for 9f2fd03c9bde, on 6.12
cond_accept_memory() still takes two arguments next to the
b480cbb07102 hunk). I'll queue them for those two trees.

6.6 and 6.1: b480cbb07102 doesn't apply. __rmqueue_pcplist() has no
nr_pcp_alloc() there, and reserve_highatomic_pageblock() takes
(page, zone) on 6.6 and (page, zone, order) on 6.1. These need real
backports.

5.15: rmqueue() does "page = rmqueue_pcplist(...); goto out;" with no
fallback to the buddy allocator, so b480cbb07102's "return NULL" for
ALLOC_HIGHATOMIC would fail the allocation instead of sending it to
the reserve. That one needs a rework.

5.10 doesn't have 6ee3d87b9408 and needs nothing.

fe21f930d1e6 and 0e05a469c294 stay queued as they are. Backports for
6.6, 6.1 and 5.15 would be welcome.

-- 
Thanks,
Sasha
