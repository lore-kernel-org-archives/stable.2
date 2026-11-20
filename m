Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795166316;
	b=4ArTH5xnKI+v+gk69ip/KevaoMF0T1USlB4PFDKj7q0S5wsjlA+d4ja8oF8NawXiUTqP
	 bLpn+qsnwttciHSVSCe5DTdsL9qBkUwcsuhoEJUTrG0WF1/8ps1+ke7F/RxbPblb4OPCO
	 p8G2xyXWyTPItW1r10DJhKBw5o7r2YSa4d+s3fBp/QatOSjPNf25UU641UIXJVWz7hYcj
	 Y20mXAGHu8LN9Ep9BjBGWKcZo+S15CriJE3/awClXYhfAQCYiaf/JL9OrjphKhiTm9wyj
	 Tc5/jgXXCtrLrs831ILc1MCkMVQ8hkpJjuYLrdjYyAqiuhkeckTufGu0hiEiUyC3PCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166316;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=CrWm9yszaSjT1+brCIxSYBYmwnFrRxhTb7bR33nbwck=;
	b=2Wy0s+dGNfGg4uYcB8SkyBaVv+SMjhl0tS2QQLlZhMGfv6z1DfaZUgFg115c+uvCQzv3
	 hK+JnW+aPTs6rl72zNpZfIIcqPhLF1m/YR1PvEkbfRefbeB6w4+askTbf/1E2VVf8Pw8+
	 71XB/OC+RSFKpnU4xFvEUBkEQ9JPoFwECtx2Vlcs802rBqvePZydLqQ3Shs2sNsDAW7XG
	 RcdxYlLhp+dyl57p6RIHpAntMy2Dt7ukKIZh+tbDGSbSX8UZAY/wfcF+bFbeTIXQQlEw6
	 AH7fTtYJxjZ4rFcMZ5tNHtk3SpERLaYzZnGxMridfdFInhuzRHR2DcPLNoRMaKZNK2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LexWIxiw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595E606A33B;
	Fri, 20 Nov 2026 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LexWIxiw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3B11F000C6;
	Fri, 20 Nov 2026 09:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795166316;
	bh=CrWm9yszaSjT1+brCIxSYBYmwnFrRxhTb7bR33nbwck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LexWIxiwxcg/tw3IZ1+li3kQ+ULA1XV7e1Rjupo2+XX1cvX3bNaU7BBWClPBC0dYX
	 DITMTTO/ytU2cJC+gq78MHYFV/w6VXWmYBr7xCcCJSY6VjW6iBQtyTOoZq0TEF8Q+T
	 u5ShNJPnEwECLKzWpMOk2i7a/pMKBM9BYXAJjO664Hyt4amUlNIGgZJFVj2lOsmIXe
	 e6Xt9dj2W69ZXyizcpORRSI+jW/QS9XghD+2O0FHsKL+bHTtNZO1XbYRmvD2MlqugO
	 KH3Lid79RfL+++lKdQxVfrhynX9bF25ZV4OpK+90vCpQ1yzhrh22UqrP9vXPD+e/8m
	 gMHRng1lECYjw==
From: David Hildenbrand <david@kernel.org>
To: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Ying Huang <huang.ying.caritas@gmail.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
References: <20261119-madv_free_thp-v1-1-a312919e1ee5@kernel.org>
Subject: Re: [PATCH] mm/madvise: fix MADV_FREE handling for PMD-mapped THPs
Message-Id: <179516630988.4236.15752843940169828814.b4-ty@b4>
Date: Fri, 20 Nov 2026 10:18:29 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Thu, 19 Nov 2026 17:04:34 +0100, David Hildenbrand (Arm) wrote:
> After MADV_FREE cleared the dirty flag of an anonymous folio, reclaim will
> later free the folio without writing it back if no mappings are dirty.
> 
> If our folio is still in the swap cache, the swap entries then point at
> swap slots that were never written, exposing stale content of the swap
> device. Bad.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/madvise: fix MADV_FREE handling for PMD-mapped THPs
      https://git.kernel.org/mm/core/c/344d84f4

-- 
Cheers,

David

