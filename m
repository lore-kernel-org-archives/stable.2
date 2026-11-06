Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982978;
	b=yDdfZtvbQ10eK2q0xz40pU2iEU28oLpbsXz4kTrKgflufobxEzt8Ar/ArW7vcSQQKOMF
	 gROdAm5KcKgRqT4T7HHQwGLwlW+N3VN6X+hmrS1aKyeFEMIqtQiFyqojrFjLI5DIRwUom
	 p4v7SNogFhpqHVLx741E3/Fmi/E4d4L4ZzZbPftVkQWSi4a4rWBgD16zi5J1l9t6NG/1e
	 WsXGKh91RJlCxxbIAODyJZnx5gDlWtHBfeJpoZmdwULSvaPSZmGckurj5RqFJ9aC5URlG
	 Nij2XHg1n0I7iVHouN7IBQf3CifN+50Y1LVy/awmjZF4Gy7lQXaIf2c5dj3+6n7/bRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YOpzMaze85kA6XBFXM861p8qWghg+m3macQSZJE7kdw=;
	b=a4yZ2y0OZba8hoJih/ObPXQNj1E42WSF4ObAKow/iJxsP8GS9UC2PYCGW2FthivLo5GZ
	 WZyrCv1g5n+Y/z6k7dPzPLMdpOLlhHO9T+5BoSUZFR4m0ny0m1UrF2Fh6H2LbxTkufoAk
	 kHbzfcIwNEBQlcAQXH4XSuNwlwDI2redpIVp3yzEDgSsY1z5CUvamIcsCdsxDw3CMDfda
	 L/zbZCrGR1wt61/V6OefP6Bo6529HfvKg+jlF34odvpaoe0wYkK2645xkVcnjKWdVEl1+
	 z+FpEtIoh3hlbKom801PJNkIkm9ud/HFVo7BD8e5l2NgHfOiZ2ld9qTWW/iVYBIpMyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFPtyt1W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C6A606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFPtyt1W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C63A1F008A2;
	Fri,  6 Nov 2026 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982977;
	bh=YOpzMaze85kA6XBFXM861p8qWghg+m3macQSZJE7kdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFPtyt1W+JPFYy4NQPQqI1CvxeELRgPbFlF6Bc1SIFP1TEZNH99seVoKh64cP2FHO
	 t/JO3hexch6BiIsLSjze6zk+LOXwhJmLLAMpA1KqqFNwcQ2iIvSCVHOoE3Ofx+EJox
	 Lp4cyVhE7+7Rjwr3rPMMhvrtlk9UpiHrxrTtxT+W9oVJWHI0s1T5yUHSjN2urByVim
	 NyprraPbisZsOBJyPTd7xZt6ZmjJdku2UQRzGCGuCbkntaK2GOP5COVmBCO1xNO8rD
	 cG+4QhhGy+gK4tGEKTF6TwHPjjIRZBpHNUVsnhJut38Vn3xVDK2MEDFxWRsp9X3LRw
	 RmAfxb6xjkuEw==
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
Subject: Re: [PATCH 5.10] mm: replace free hugepage folios after migration
Date: Fri,  6 Nov 2026 11:35:53 -0500
Message-ID: <2026-11-06-1-daily-reply-0018-mm-hugepage-folios@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105070150.3093908-1-mkbund@amazon.com>
References: <20261105070150.3093908-1-mkbund@amazon.com>
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

David points out in the 5.15 thread that this reduced backport is only right
for 5.10: 5.15, 6.1, 6.6 and 6.12 all have hugetlb migration in
alloc_contig_range(), so they need the whole of 04f13d241b8b ("mm: replace free
hugepage folios after migration"), including replace_free_hugepage_folios().

Could you respin 6.12, 6.6, 6.1 and 5.15 with the full backport? The acked 5.10
patch stays on hold until those newer trees are covered.

-- 
Thanks,
Sasha
