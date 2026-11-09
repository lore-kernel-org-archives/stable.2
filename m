Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184488;
	b=bY3j7ZGnrgYXOpST7HhW42Z19mOpab8mHrGNoBcd0IFbyBMD47WDmC/vFEn49y3QG6Ej
	 SzM3ohA8MsUsz7OOIRiEALWbdyS+FRt7ZU2P+WSAmFuIt2tlWNpbEk/xvoprCNBd3QMzY
	 haq68+7E66VWd8/aCORLCMvzWfKAer0BLb4y/rUBO9/PeXhnBDz3i2Qfy+bSY2OT6cu7F
	 xNYq9pZP8N+B7ibTr4HBKKZ+X9yOg0uxiL16jXKZAGsP0lRVaFhkz/7YQU9dmkz1q0lnR
	 py8RKYJrcTuT2HpuxAeSu/fcnjK9wAWiCtjsvEHzZnkIWV695dkeJJZgi+5frMtyYSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184488;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xMr/7dznR2e6AQLXjKgj8idxsvTRjg4+NbujeiI4b24=;
	b=ehtPZE7ztq8G1jYcAlFo1ZneWu9OaAZTSTHInT/Jas+1T6qbORoQqTFOA+FWZHsQLwy6
	 ZRDL0konLVfytbhU6v+Znii3/hrDswGK9ASlUWvjasSVooH3r/SEDmqg4grXMz1iEu6hj
	 A837mzPdWkPkByAW5HmLNXImsAS8xXRHHvcq3koRVauJzBROc7kyf13IRfcr+v5J58XsV
	 M52tf78N0MQaQB39Jdgc0uJu9/7gCt8QevrCw7MpeYaGS5pbniLud39FU5KaxhH0It4Ly
	 AVk+Y9zEvcj0xQ8sWSC94mtoAAzEfa958++j2VaIG+WCXVlsvZwwLgrsylav9rtulWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBaCPAGo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F0606EE81
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBaCPAGo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EF91F00A0A;
	Mon,  9 Nov 2026 00:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184487;
	bh=xMr/7dznR2e6AQLXjKgj8idxsvTRjg4+NbujeiI4b24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBaCPAGo//NQOEpuqqqFHTSL4k7DihQA5fwABbTUg8mFsVngdSrCan4WHR3xrEGEw
	 thlrO3NU7jRWtIN2LXsyjoQznSo/5VWlk/QPbjjysMh+HGK0adHrYTsABENuzQNRu5
	 mAY1efcTJP5JcMpHB/+llojF6+prBkRXA/y1j7Z5BX2PXbvdiIEhCAbQlkKLEfpsn3
	 T/e37NjmtEW6RYztD2b0rM5yPY7UVjxACQu5Ds5s92FGtaUBQawCqKIsiP9d0lRWIX
	 +678HN/d2pE0mc4ZhOhTpSyqYoLFpDHhBtEceZLvjpE+9YsG+tINoPbcv1D3U561Yo
	 04ru7jwHv4nhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	david@kernel.org,
	yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH v2 6.12 1/2] mm: replace free hugepage folios after migration
Date: Sun,  8 Nov 2026 19:34:33 -0500
Message-ID: <2026-11-08-1-daily-reply-0005-hugetlb-6-12-v3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106220835.2878368-2-mkbund@amazon.com>
References: <20261106220835.2878368-2-mkbund@amazon.com>
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

> [ Upstream commit 04f13d241b8b146b23038bffd907cb8278391d07 ]

This doesn't apply to the current 6.12 queue: 30cef82bc6e8 ("mm/hugetlb: rename
avoid_reserve to cow_from_owner") is queued for 6.12 and the
include/linux/hugetlb.h and mm/hugetlb.c context in this patch no longer
matches.

Could you rebase the 6.12 series on the current queue and send a v3? The 6.6,
6.1 and 5.15 series have to wait until 6.12 is covered.

-- 
Thanks,
Sasha
