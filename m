Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872688;
	b=he0VMiGv1VkgPOKy4WPVC2VUcv5UTaipOnGvLhA/YziEtZPulaBNM94x+zTOEfeIrM7E
	 eytGQ6VfQpQWys6pIAc4py3sgZx1RK1axnCStcnZQIX0yq6J8idN6kl+PL5BaTIuxzK8+
	 nIIeBJGhpXl5x+Rlew4A7iWHyaqPoWI0H2wcDR+z8TL9EDU9mj8gxfFQFx5FvuTogjTVv
	 6BwBA8Ml764oNvNmJyTwWQGMoXWLGpfxpZsnt5Y66XebCNjBLg2akD4uDM70mC0ZEu4bl
	 iUs4FNNBrgK5fcXjANy/Vt573VhlCwFtimEM7U/RgFElfcGaxAIIccG5QHcjGdyr6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T/qRbD8t//11F3moDl24EV6PjDvmcez3jUawZFRfmy4=;
	b=s3p9u/EmYZA1dJP+D+a0mkmqQZcz8yv0jQBCyuT4bvSyNUbFLPlHr+3fRjPCdCok/rsm
	 kiXf1NMoFBjXiGU/5vB/a22oDNS2dirH0g3rMS0oRM2BzZEpG+6okxYFMifK2GdkDa0pn
	 wcfgze2wDaHy/eubszIEtJPxCCfxGu8YJIp3u8xRJdGIC7TS2Awm+Kp0fOQAg6jTK9nai
	 pdljjkLr5OW6kqh9grjwMuueqVfQHQG74LiNMI11RLRNWPKrOOGqqCtt1FzOqY0fBN/dS
	 yR7NZv5aSwePfEB3R82g3Bb5SFchls4WA2ccOMuH+UgRNYIGIXVBUt358aL8XyDJ0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiEGHloZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DA606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiEGHloZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14EB1F01828;
	Sat, 24 Oct 2026 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872687;
	bh=T/qRbD8t//11F3moDl24EV6PjDvmcez3jUawZFRfmy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IiEGHloZAUhUF2tqN587ZVgP8LaE8sK3l2jeBXNmq4syTjESNVx8cVH2ogKcxsoIo
	 2FBzMb1q3UflC1lXxzwBb8XEN7H/opnfJ6kBhldXBUjneSTqQkvXuQ8BiABZTcPi5h
	 Qil/BSQNvlFmaBl7QbF3ZD4sT8CsBiBPa0ukQF7kFNBW007/a5fOF6D5WxppwPPDYj
	 yAlhaFf9FnItWll8BhMESfXkGV81Qp/25A9dNdthkTmswEdkWNv+yjDNguxOMX7ktS
	 qg8iQKOGkbj2fMdy8Vom/VGxAuHWBtxA7qa5bEg6hmHqkFGAnB2hF7CYTOfSLiA58X
	 EHzvEQ20PfcCA==
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
Subject: Re: [PATCH 5.15.y] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Sat, 24 Oct 2026 16:11:02 -0400
Message-ID: <2026-10-24-1-daily-reply-0004-mm-huge-memory-pmd-dirty-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024083848.496-1-ue081723@gmail.com>
References: <20261024083848.496-1-ue081723@gmail.com>
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

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
