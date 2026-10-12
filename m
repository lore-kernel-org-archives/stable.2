Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8175A3451AB;
	Mon, 12 Oct 2026 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799220; cv=none; b=SaAFHqplxu9A63q3evbESiGrYKaiEsQJSCnu+IsNHyGaM9y3khbXyUPm5TE8oU6IdMc0dX4/7oVQLl6/vP4+qziMSlceR3k+0/GmHzPvBRglcBJD5eo2UnatB/i2XPXw+4nsGi15Tkqf2LShdqZUlLzEY9PnELydk5Yg3L7/WHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799220; c=relaxed/simple;
	bh=eckr1AbnlJ0HgqpnIooxBmBFUQOzQp5LR4cSQ65/Sv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuziBRmZSNHy5Y52shYfR+9/y4mPqQLmyd5BgJnZEMEUV12dC2ZRJhvDQ97cj0TZDEcIXTxpkRJ9Mv8HT3hB2DE1YAiJZQYzaj2Td1VvefUEM6UtcVCuR/LtNJlq37z1JDIzHwfrlh14OZKsbabvq+Oy1vfcasjhe3+QYQOJ0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpNNfIpo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpNNfIpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C671F0089B;
	Mon, 12 Oct 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799219;
	bh=lO4/itdKD6CCMFfIDvwdmBR6vekfHvlwTW6PI9ipQ+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JpNNfIpoGhnPu+tzNngBzBta550ZvF4Q2C2gbIhRPZhBtk+SE4mlVrDnCkyJGSx2z
	 qMVxpGfviWXd7ddNy5A36EUH7zrndO2RyWJvlfoiueRpgYeTPyTqoS7FU8uab/K9NT
	 9Gd6OZtTYsS7Br5UkZYbEdjeLL9u69NYe4qSiTxgDyihDvJgJanyj13wn0yufGXWk0
	 i6VY1ZYoHW4Cmf9ln9+G9mtAkUlBjEgiiAFt/NkMQN1rpaMYQFldC7ekAFJNR1Ai+7
	 uMtEn1egMAA9jY0JSnhI+BPI2zst2b2Tyz+b9HzNHDQCcDVKMP4AGklouwuOQxtTTR
	 zK0Cp8vv7BbXA==
Date: Mon, 12 Oct 2026 11:00:14 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: samarth.colleges@gmail.com
Cc: akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, 
	vbabka@kernel.org, jannh@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: keep the hardware dirty bit in MADV_COLD's
 THP path
Message-ID: <asyvgymRz9jtjWKz@gremlin>
References: <20261011132227.413217-1-samarth.colleges@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011132227.413217-1-samarth.colleges@gmail.com>

On Sun, Oct 11, 2026 at 06:22:27AM -0700, samarth.colleges@gmail.com wrote:
> From: Samarth Narang <samarth.colleges@gmail.com>
>
> For a young, PMD-mapped THP, madvise_cold_or_pageout_pte_range() handles
> MADV_COLD by reading orig_pmd = *pmd, calling pmdp_invalidate(),
> discarding its return value, and writing back pmd_mkold(orig_pmd):
>
> 	if (!pageout && pmd_young(orig_pmd)) {
> 		pmdp_invalidate(vma, addr, pmd);
> 		orig_pmd = pmd_mkold(orig_pmd);
> 		set_pmd_at(mm, addr, pmd, orig_pmd);
> 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> 	}
>
> pmdp_invalidate() atomically clears the present bit and returns the PMD
> as it was in the page table at that instant.  A store from another CPU
> that lands after orig_pmd is read but before the invalidate sets the
> hardware dirty bit in the live entry.  Because the written-back value is
> derived from the stale orig_pmd, that dirty bit is erased.
>
> If the THP had been marked lazyfree (MADV_FREE), reclaim later finds a
> clean PMD and a clean folio and discards it rather than swapping it out
> (__discard_anon_folio_pmd_locked()).  The store is then silently lost: a
> subsequent read returns stale/zero data, although the MADV_FREE contract
> is that a write after the advice call cancels the free.
>
> pmdp_invalidate() returns the pre-invalidate entry precisely so callers
> can carry the accessed/dirty bits hardware may have set concurrently
> (d52605d7cb30).  change_huge_pmd() and set_pmd_migration_entry()
> (8a8683ad9ba4) already do this; the MADV_COLD path does not.  Rebuild
> orig_pmd from the returned entry.
>
> Reproduced unprivileged on x86-64: a 2 MiB anon THP is marked MADV_FREE,
> then MADV_COLD races a store from another CPU, then MADV_PAGEOUT; the
> stored byte reads back zero.  On current mainline built and booted under
> KVM, the race lost 131 of 8000 stores before this patch and 0 of 8000
> after; a store-before-COLD control and a MADV_NORMAL control lose none.
>
> Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>

Thanks for the report.

As this seems to be AI-generated, a member of the core team will take over
this.

> ---
>  mm/madvise.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -426,8 +426,14 @@
>  		}
>
>  		if (!pageout && pmd_young(orig_pmd)) {
> -			pmdp_invalidate(vma, addr, pmd);
> -			orig_pmd = pmd_mkold(orig_pmd);
> +			/*
> +			 * Rebuild from the entry pmdp_invalidate() exchanged
> +			 * out, not from orig_pmd: hardware may have set the
> +			 * dirty bit since orig_pmd was read, and a MADV_FREE'd
> +			 * (lazyfree) THP whose dirty bit is lost is discarded
> +			 * by reclaim, silently dropping the store.
> +			 */
> +			orig_pmd = pmd_mkold(pmdp_invalidate(vma, addr, pmd));
>
>  			set_pmd_at(mm, addr, pmd, orig_pmd);
>  			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> --
> 2.40.0

--
Cheers, Lorenzo
