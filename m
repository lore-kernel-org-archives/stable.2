Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794678159;
	b=FRT0+0Wc+kXl6uYgsYiwr4Q5RYlxxqZpQOSgPlpGGK/fxj82paEvoiCfaB27jVxAVTBc
	 On37YOE9+1hL4D6uj/7MWI1Q0owKfCAumGssNPuMrcInfUAcQcp5btMgfQBhDDxqD45cJ
	 hCX+/NhJ1eCxmqkbj7IClo5fWAAt9ltjfjTesQMd0YtoREAK7AU2G9LAdBjUcS+Lq70Ac
	 dPdTEl2Q2+QcD1GVXfYE2vwEQ7IrK8QPSqUyYWLHIAO9FHUzuuQFslaMDFzbZ6QE3wOHv
	 GKOUNx/F8/fNMeBiKt52oRq7x1gLZMtW50g9TPYVtE0WyG5hkkzKZxkm/Fha6C1dcdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794678159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gqa0FzeWxF+NdVIavyzYQpx7SrVw5PS23jn8ZooNPKo=;
	b=zmxZvxBBTwA/83X53drRmM/RKNV5HZ99WGWB0/2w2g6PiRPcHIC6bm991kKtPy95pYBS
	 W2FYCioEX6DiaDSvlmv3/QSSNdwG9eizOv6hs526vNB26I3w/vjwsKeNp906+mm72rpuN
	 Fl8uOi3DmFiWZlzw1HXXN71bnhZTYDgaDxuQrx26iWIXYJL/K8SqOxrR6bcMeswdf8j+Z
	 Kd+kqcHt2wbNYPXDiavaZ7bKE0Fz3MwmxzHCspo3eGC/VI0EYrOK9EVpQ7BWrW0qKrEYQ
	 n0ndk1hvXhCdrzSJceYct4T5EKwwFURWs+3R7jITIZ7r9cZt+rIGfaF0BNZDwidbUQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGQNHSLJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337F606A8B8
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGQNHSLJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43381F000C5;
	Sat, 14 Nov 2026 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794678158;
	bh=gqa0FzeWxF+NdVIavyzYQpx7SrVw5PS23jn8ZooNPKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jGQNHSLJaRMpNWaKocOb5kVC1u8T6ym5tspwQCNo28G8KEHUB0n+aWcXjBr/AAsvC
	 b6XmShoXN0W7vdh2RQ48t8St2Lt9hfRfa59KmbMo1dfPsBFt8ZZMKAdpXfi14186sj
	 MPwCRI8MViVbDQY4mc/ZbRbTv09loMvCd0GPh6PH3bvQAc0ZekrECsHw/VTfdWizCq
	 CFP75JSOGM7L8zCGtidO+1vz2Lt9em12PIE2im7h4CkpT2+sNwlYla6G1CjketcsG3
	 Fio09EVTMRbJn0zG9342FQtwikFjc9ymAX02BhIujq+ilEF7U+c/P2v2D3zv93g6gB
	 NgPgGU21JZY9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Salvatore Dipietro <dipiets@amazon.it>
Subject: Re: [PATCH 6.18.y 0/3] mm/page_alloc: fix iomap buffered write regression from 5d8edfb900d5
Date: Sat, 14 Nov 2026 12:42:22 -0500
Message-ID: <draft-agent5-0011-re-page-alloc-iomap-618@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110259.2901456-1-dipiets@amazon.it>
References: <20261113110259.2901456-1-dipiets@amazon.it>
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

On 2026-11-13, Salvatore Dipietro <dipiets@amazon.it> wrote:
> Patches 1-2 are its prerequisites from the same mainline merge (Cc:
> stable), only moved from mm/page_alloc.h to mm/internal.h.

6ee3d87b9408 ("mm: page_alloc: do not give all non-blocking requests reserve
access") is now queued for 6.18, 6.12, 6.6, 6.1 and 5.15 from a separate
backport, so you can leave it out. A v2 only needs fe21f930d1e6 ("mm:
page_alloc: remove ALLOC_NON_BLOCK from ALLOC_RESERVES") and 0e05a469c294
("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY
allocations"), with your Signed-off-by on both.

-- 
Thanks,
Sasha
