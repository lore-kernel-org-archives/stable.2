Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E035957
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023216; cv=none; b=MjZ6/w/RQdmzBcOk3dh4/Z/Qmy7r90VAYJ6KewMVxnKkkiQzqPtqtoxtjqEG0vxTKRzmzGCh9Mcp/J4PpxrBkayy4AhsCERncqq+a7Y2SZqSf6bT6E6XfC9EWv9tlLEGE46yRwPX2fGbMBhlsP8s1yKQG71hHhrgGw361fqNWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023216; c=relaxed/simple;
	bh=4M2EqRPZqYal0zwl7C85gywotFWWt19OAlwAn0O/m9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vil9gbWQWTaWZXnV+8EflGzT2dg8YzqFhg2aDVEmjwMlF4Mxpxo0dV5mHNjUP0xId5M+01pnqFc3UQd5/w1hLC3a/WbTW3YsyXIEyHbmFEpivtJFRiAZpgXChnU9b1BDVPd21ZBJBXY1mGVObd9Kg7mIoIodxgIarV07hX29+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQM8FvOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQM8FvOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B971F000C4;
	Thu, 15 Oct 2026 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792023215;
	bh=wloXvAw4VLAs7Q2MzPshv8uNxbkgW8DhbrN4DcpdVGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQM8FvOLFG1dIYNAsW0fEjziwwvtHWa2uipltWDUoCBm4L9GKBpsYHP3ML1ucEzhp
	 zlls+B6KLSbHrhdACFczFew6ior6vJLcsombpG6p6MYKCXhdHQhhYnbvI/WS2glGGf
	 S8hir23xG470a2b6oq5w1YjePnu93o6t/Ty8lIPI5MksEJb0cE92vSa+sh04+dUMsJ
	 KWbIWfyFS3tpcIF8VkE5GAaHrE/krzJ7A4gi6PmTHgojuM8g8W8L1jyixTh2pKUMQr
	 gz1In7naCXHfATkXzgcFIOqSbulX0XqrGFRRKwGrd5zzTz9i3fLE3QbT9f61E7dwkg
	 qYf+SYo3ESrGg==
From: SJ Park <sj@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: Re: [PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD
Date: Wed, 14 Oct 2026 17:13:27 -0700
Message-ID: <20261015001327.4037-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013191719.95502-1-pfalcato@suse.de>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 20:17:19 +0100 Pedro Falcato <pfalcato@suse.de> wrote:

> As-is, madvise_cold_or_pageout_pte_range() discards the hardware young
> bit by invalidating the PMD, doing pmd_mkold() and subsequently writing
> to the pmd again. However, it does so in a racy manner, looking at a
> possibly-stale snapshot. It's entirely possible that a write elsewhere
> set the hardware D bit, which this logic now loses.
> 
> Fix it by using pmdp_test_and_clear_young(). This is an atomic
> modification of the PMD entry, and thus safe against any possible racing
> writes. As a (nice) side-effect, this elides one non-required TLB flush
> in pmdp_invalidate().
> 
> This bug can interact with the swapping system in complicated ways, leading
> to data loss. For instance, if a folio is marked lazyfree, but was later
> read from, and then MADV_COLD'd while racing a write to that same THP,
> dropping the dirty bit may lead to data loss as reclaim/MADV_PAGEOUT drops
> the "clean" anon folio:

Thank you for nice description.  Makes sense to me.

[...]
> 
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Cc: stable@vger.kernel.org
> Reported-by: Samarth Narang <samarth.colleges@gmail.com>
> Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
