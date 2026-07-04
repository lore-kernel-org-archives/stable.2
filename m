Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367673431EF
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130753; cv=none; b=uxPYCWwCr4lwkws4+EHVSwhvyoo+mdt6cuRlX7qmkY/HwZsgN+lmYEquxSUnXz8ODLqLTTvuTbfoVXwKTFhF0vTj/e3jPNm5wuh9NrgOYW1Q/9XR4xOX5AoY8eT9dsqZ9E5E4MRWLgx+BTsTeV9ps1lhikLv7stnZz4L4clPHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130753; c=relaxed/simple;
	bh=Q3ox1ykldMB+RPfbyJfbbmtpYBFHtLCejRo0F7ZvOLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1m23GONfmSFs4a5sxjVZ+KknqHTBWs7/bLtHOAdFjmeLVIKdQBjNarPnLKtyYlIwUXGjGENjdMEX2RM8k+G+saCMiBfiL/PjOQjdzR20n3rYeG+cdJ9HuyqLcdFxeaB6FvAsx7dgSw9i6BEjBW/dPBeUmi8CdEJ9O4LvhtX+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMGXJ6m6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMGXJ6m6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D431F000E9;
	Sat,  4 Jul 2026 02:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130751;
	bh=dbG8pPJZPyZe1HUmxzeVIu/5PHJoTNcjJhS47UFBiIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMGXJ6m6Xdbrs3kCMegcRvn6ajfD5xGM3UaqHjr94aLpqZjDAsZdBv+PW4vWtD/l1
	 tIPh3LWppoS+VjcTy/T2tV7YOQFDvVieERqt8SegbHCnAr+QM00j0x41BnxeShv4DZ
	 9mK9YYjW3Q1EdyupAQkC1FtjM6cyfpvvyYjSNIoIKSLPUivf1IEcHQwRuyFfxF5PqA
	 kIE4S+vdxkq8XakHquIEuQFPFWGedOHLJ2RpcxfNZJEmvstQOFb7R7TPzuWDQlzPGG
	 rGSLI/rVLw2ABfmO/ZX0+SPEdVMZWA/jXWLhQ/eJSy+8NMxirbcmuz6n3684YDyqel
	 9P5DnCnAvzAaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sashiko AI review <sashiko-bot@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 6.12.y] userfaultfd: gate must_wait writability check on pte_present()
Date: Fri,  3 Jul 2026 22:05:14 -0400
Message-ID: <2026070315-stable-reply-0020@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702154905.975477-1-kas@kernel.org>
References: <20260702154905.975477-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 02, 2026 at 16:49:05 +0100, Kiryl Shutsemau wrote:
> userfaultfd_must_wait() and userfaultfd_huge_must_wait() read the PTE
> without taking the page table lock and then apply pte_write() /
> huge_pte_write() to it.  Those accessors decode bits from the present
> encoding only; on a swap or migration entry they read the offset bits that
> happen to share the same position and return an undefined result.

Queued for 6.12.y, thanks!

-- 
Thanks,
Sasha
