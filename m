Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872690;
	b=pPrxIF2c7W/YqAov1osSOrwXVU1QIxY+osARYvzZ3NX4K4BM7qinkIvJMwXGKFzKOXOc
	 5yb7LCCAJ2ciLu5Ksxtpt+/82gG/+FkKeFZL95u4sylfzKtu/+K5pLoEgBXWW6n4zk+h/
	 CrRAKCcdRUS7PdVFseCytvktLyeVYyYxjVgkbUgXArwKNBsKGXkVVzIbeM+hkFV6tdfuP
	 zoS+UruBPrl/vhTb+PRzwGUEHLRcJo0B31CjUvSbogNfM+bp/ywqHKXW7bM9yGfI/YMJq
	 3XosIWn5xijKCm81pQkTiADkSmFtXRTylNB4bN3sSvhqYrOGv2q41exFAAM/jRrsgFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872690;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c/A5qluR/18UjYOJbccXGtBTeP8q42nKwehSwy4JkLg=;
	b=vfd3uDR0+aXE/4isuTZbDieSwpNXmc0YwklDUilKRgmIbvvs5ETzcqgC7ULY0irOX+FF
	 xqWxPmUPtMp5SwAVAaboeSchxQKJl7ZGJkfQ+3lP1Zt5AKNGDVg4qdp7DIA0uVUMbdgg8
	 7lsR7m+Ke+60IekZ432w85B7hOYfrTshUdII1dwdLl6YCbFALjjBAe+JcJmtJC9M5d9ug
	 lc294O9D8TFaJDV0QqeOuXEHbUHvVc40Ene2ebOcGJbLLceHqYg1BJijZrVUYgANXX7Tp
	 ymlCRVJJHGXoCVpriCAkwBjZSn4hxGBnv6LefZ+oAdTKXyIiIcSp5cx+fcWBbWA4QHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2nynHIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB1606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2nynHIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48DA1F01825;
	Sat, 24 Oct 2026 20:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872689;
	bh=c/A5qluR/18UjYOJbccXGtBTeP8q42nKwehSwy4JkLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2nynHIi2eIswmOgMIYbyWzEVLsORJwYY+p0xEw1rhuSK0XXnc9nsnP88NOwCKUIv
	 rzpxbhIOrfpbL4elJSk57nthq6LB+v/6IZh+Js/szmf/FbRnAszL3HyikB8D49PpQr
	 xriynuJpuVeprk6GeFLOuVQEAIIjpb0RYM9Oyt1lUdOpEMhhhju7Jcy5OcJR7GhCcY
	 EDdWqPUWwnOZE98WVWqBkax6FFU+CBI+Cb4ZICJ6cEZsXBs0FqOwmPNvn0tOvluGJJ
	 1GTIWBxhs/u6ELM5AlZK9Azg16iazyeRtRbVRMv2xleU8B75ZCJqfmRYqUgPJl3IwH
	 jc5XemnPYMPAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ting-Han Hou <ue081723@gmail.com>
Subject: Re: [PATCH 5.10.y] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Sat, 24 Oct 2026 16:11:03 -0400
Message-ID: <2026-10-24-1-daily-reply-0005-mm-huge-memory-pmd-dirty-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024083857.520-1-ue081723@gmail.com>
References: <20261024083857.520-1-ue081723@gmail.com>
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

> zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> file case, but not the dirty bit.  The pte path does propagate it, in
> zap_present_folio_ptes() and so does the pmd split path, in
> __split_huge_pmd_locked().

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
