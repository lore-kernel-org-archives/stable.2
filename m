Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793803583;
	b=4/8cno6qunt6AoxqID7U8M8qpc7762hkKgvPxtY0mLs9mv74O7DFo/TzvMK1TEpNhnC8
	 07JEvmuyhXIekQ5cRPOoISPmvHn8BB+xab49MBLCbI7dCM3LsXolcXpCGAsAvR4N1uiTv
	 k1ebLpZj9DHjaISERENuegq+ssNB09q9YtuwJ6oKr8TFeAIAen5xDxHMie6igUsf6+Y+n
	 JC+7WsvnDZri8dxng9iXLjapmubexT9SUskHbUmat49+Hfyt5iYhvnKz7pbyYEA73b9tm
	 /hrIS47QpKqArYCuHJXk6NmC6gGqqTXegA5DHJ9b0NJjyNXodfFbvDyx3S/epaT2Fog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793803583;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XvwysgLfyIs5+DpWw1HKgaTFW31+lgpV5TFO7hfqvV4=;
	b=HZ0uPoNtA8BKDpQQZbtIYGP8ry1PvX96NUHD1rNHK6DI0fHpUu60EXG2Yjjj2LOqlW6c
	 Q0AT6hajDE/zJYsJfywg8VIh1Z5JEUY+KqKYlal/cmmlUinyxg1GANK28JrbqEoBxBG7e
	 ASAEd6tpm86PKNBjpHhb5QYlOAvrpm2U9JHZ4QPbSNm+X1CYNfTXZHB38nkaZ/3cqkuoQ
	 uRHHGrJEI1A0CyEgIckdSyTuCjTK5l5/qJzA8+IHdcfYKJvg6vbuS0AX0LpU55WkwGz1w
	 CgOXx9uApXiYeceZ0+w+mrcV8Q95xp9n3TI0+acJ9c8geCQ+2C+eKc9tRk2X5k+dG8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMZW0dBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960D606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMZW0dBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02FB1F000C1;
	Wed,  4 Nov 2026 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793803583;
	bh=XvwysgLfyIs5+DpWw1HKgaTFW31+lgpV5TFO7hfqvV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GMZW0dBRIx8mvbM2KDH5Mq/dO3W2/K2tCDu3B35/dJTuD9Z5x/7s8I3oCZQnzZz9l
	 FhYKV8usOtxuEBFqs40vBPLEHiOPRUebcoIvqC3AbzVEC5tDV9avRLG4Mj/ddAc2fk
	 CQzZHnMsyuJOgDBfxWUgB+Ia3D4sFJD5rmGSkFkZJGzyCKP+AuHyP+NuD5TgLLopen
	 pnIYiBAUIsXgMOvrdcqKgb4OliCnCgRK4B2EpUpMPeV6VEwY+ASmgiunVXcDk9EYW7
	 Jtg2C8BK1OgAntrhhbw24OjOmRpacmQBVd78pWRcxIyahSg4q9Lz9fpbc3emUnlPM1
	 /+AgkxC2K+gcQ==
Date: Wed, 4 Nov 2026 14:46:17 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm/mremap: fix accounting on a partial move
Message-ID: <autE7-oTy_W1WJ4V@gremlin>
References: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
 <20261102162304.c3585fc3fb88644118c152d7@linux-foundation.org>
 <d2efe4f22fe0ed9390e4d9224b81d78f.josef@toxicpanda.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2efe4f22fe0ed9390e4d9224b81d78f.josef@toxicpanda.com>

On Wed, Nov 04, 2026 at 02:32:35PM +0000, Josef Bacik wrote:
> The Committed_AS bugs need an allocation to fail during the unmap at the
> end of the move.  mremap() checks the map count and sealing before it
> gets there, so what's left is small GFP_KERNEL allocations, which in
> practice means a process that is already being OOM killed.  I only hit
> it with fault injection, so I left those with just Fixes and let the
> stable folks decide. If you want them cc'ed it's no problem to add.

Generally would prefer the fault-injection ones _not_ to be backported,
they're essentially technical fixes since to actually hit them <4 KiB
allocs would have to fail meaning OOM + fatal signal -> process dying soon
anyway so doesn't matter.

--
Cheers, Lorenzo
