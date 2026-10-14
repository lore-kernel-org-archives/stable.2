Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841348B37B;
	Wed, 14 Oct 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007658; cv=none; b=PSrhqMnDbr0Cy36VfH3kyOgrtm9ZNCK/ZWZv1x9h3qG8xJ7x8IoLEIyniVQxegKu8W++MBoEVPnaoLPlQUiR5tW18Ks1Z69ZP14sucJ0yiAilorNLKWdvicsIq0mbIwrh9u4AV0ViNGKS73xmK0jHbIlQaonPRUAwYg5vIQxOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007658; c=relaxed/simple;
	bh=abx4cqLQ35N2zaMiMweelUHiSw3je1JRyqEgURBmIFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXpHDST0dcJIxwqIDV0/2b3qMdaVT3swkrq4VreL+DwOECNIdwYvyW6Y0sh9rWZadPlcbz2nVEFtqexO6UAQGp7Y1xV7AmANBH70sI+78VjjZ99EO5TvvP0ppp4xxbY2SwxlgXuSzyysuClN7ZOC0W+9WDmvLW0L8ZxYVzmFZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5s4qmCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5s4qmCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD71A1F000C4;
	Wed, 14 Oct 2026 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007656;
	bh=GOJVABY0IvwuLtUWnjxpl472DCTwt9A3UmESRE0DpRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5s4qmCrX8HZiY94A0AOUdfYCOTj+NBZ7bTxuqXD6YMP5G22pg4OY+JD1CNj8S1Ah
	 JS8ZH36xCjJwhT2pchAEQJ+4OozFHNw4cZRZR8Tez6midV/Utnc0N0eFIuYJP7H1Fp
	 G2woX7jKWWNkVcz4y10Fg82SrlSFssjtgV5VoK4NKc86EZ2Xwg291m5Za4Kh9Exw0g
	 oTuzuDnvXv/KqTTuGPZOro03vjDrLkxMNUiFPv0q0/oKJfvblslWvRF4dPZHoBE0iR
	 JBuLCVTUp+zVkrd7g8ZfEVi7YeUzOBou3sylmun2AveSWN/e/xfDWInTrXxE5sItCj
	 fz6iLNYWFfUSg==
From: "Harry Yoo (Meta)" <harry@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Imre Kaloz <kaloz@kernel.org>
Cc: kernel-team@meta.com,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Jose A . Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2] mm/slab: sample slab_state once in kmem_cache_destroy()
Date: Wed, 14 Oct 2026 20:54:05 +0100
Message-ID: <179200759984.3589452.3981388920201754777.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014150844.8536-1-kaloz@kernel.org>
References: <20261014150844.8536-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Oct 2026 17:08:43 +0200, Imre Kaloz wrote:
> kmem_cache_release() tests slab_state >= FULL after kmem_cache_destroy()
> has dropped slab_mutex and unlinked the cache, and for a
> SLAB_TYPESAFE_BY_RCU cache after rcu_barrier(). If slab_late_init() runs
> before that test it sets slab_state to FULL but skips the unlinked cache,
> which never got a sysfs entry, so sysfs_slab_release() calls kobject_put()
> on a kobject that was never initialized:
> 
> [...]

Applied to mm/slab.git slab/for-next, thanks!

[1/1] mm/slab: sample slab_state once in kmem_cache_destroy()
      commit: 6d9bc3d860e64e2c5dbfd7531954df9ea8c388aa

-- 
Cheers,
Harry / Hyeonggon

