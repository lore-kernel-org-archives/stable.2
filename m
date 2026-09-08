Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D828314C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828866; cv=none; b=FXwNxVfRJHcbTBJPN9bQgn15fWroESH0BKeKYsUx0shyA6VaSO+xNAVQu3Zs6ijlx28BQYttILcv8fGkmO6NER/wXTVZvGISe2uoUZDc/QNBzacY9+UndJ4ODOS+DOBVedVLhHYGFZUrKdiaeYh7/dBtkWF25Hk+C6v6AxO3JXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828866; c=relaxed/simple;
	bh=QUSZoFEbw6nWucqZ1fF3DOrQiMcYAs71cKdlPa8THPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fwa1pyb6cfudmhfMT9DiM4jSO4qFDYsMe2ushV3r0T84NMmIXEO47dUjARIUAneYY+YL79ZF4qg0iob9EpF473Idg5WLUFJm/jvdai9DUwcQiwPuQUnVv0FQHkmNemDngsUI7fGiV1KfMEbWumXmtOEGXT8s/sloNalzp0aEVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPuMbigy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPuMbigy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE6A1F00A3A;
	Tue,  8 Sep 2026 00:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828864;
	bh=XiprHmASwRrOK55vMlrUDU9Z/EPKvTUQh1XN2S5ECek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nPuMbigyq3YVNhsIYjeF5RuVOiSl6RC44KYU/JN0tUgsp0kQ26QCT9hnk6YnSMnXw
	 G1V0q9yO+pVWJrQqcCa1HKlONzxYeU5Bl9h61TmLAV/2rgzZzQid4Zf8jUoQd2rtVc
	 HX8kENpiDMedilPUslHcXf203Rj1TRzC4yHi84cfz1zOjQLKN6XzGGMgqrygziiy7O
	 Y8piKfnvRUEnierPdaThPQ7ldfNwap4BxV0lTfW69dQSAmu74jdQbuJzEgK9Vyg7Xt
	 Ub1LlhNbaONyDeE43a9qVSVRCMSiJTFZVCJoOnTBPVkgk+BPOA2JDRhVYQr4FyFA59
	 X3mtk5BgN/dbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	William Kucharski <william.kucharski@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/huge_memory: use folio's memcg inside __folio_split()
Date: Mon,  7 Sep 2026 20:53:56 -0400
Message-ID: <2026-09-07-daily-reply-0017-mm-huge-memory-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906224955.3049045-1-ziy@nvidia.com>
References: <20260906224955.3049045-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> During a pagecache folio split, an xarray node allocation can happen and
> needs to charge at folio's memcg instead of folio split invoker's memcg,
> because for example folio split can happen during reclaim and reclaim's
> active memcg might not be folio's memcg.  Switch to folio's memcg at the
> beginning and switch back afterwards.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
