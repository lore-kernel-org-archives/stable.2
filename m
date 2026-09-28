Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39948989F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592329; cv=none; b=P4fmlrVWbSnRHo7pfPlTrQ53MT41SfljbDfx/IlLxZ3cE0j1M52jVUCFiXXRO+TZqGnJwWXaVX1OEGTb/UJAcZtgueAFVMsqLiLkMMFZ43KRw/vXBmRQs988h+dFvm9eK/wsUvpYPnbGfw6ZUvXAUvXpWc+QIcKRWs9pVoRft0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592329; c=relaxed/simple;
	bh=idEtOGz0tSPFc6Wku3wNGhIeV5TRsxTorqK2Qyxj7lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxCOR5+zibCVQVZws4q+wB83lN3Nt+F8obisuSlip9uA5SwUi8FCLQlrUh0GOrDa8gIHHzM+5iWwr7MeUXGLnjR7pyn+kAEEGR+yOP2hkezH9q8YXb9SJY/RwRMPIAffhoHIyENb9iFdUtN1pLXQdss7K+neRKuCOD1r4vWmHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N55hHaSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N55hHaSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401FA1F00893;
	Mon, 28 Sep 2026 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790592327;
	bh=pkN3i1kfI7ou6rynJpVZcTVcqK4JP2ip7U/AkgCuNZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N55hHaSiAFoCEqUbcpUK1ba3c7jI4PHLKH+LSqhl4MwioLCLKK8udMtx+wid3aAKv
	 j0wL94J8PRdAKwdMCdLLr0Sgm9vMNCixykC2G5RufrS90JeWUr8yxCaUseMoEEKgra
	 8HhCsnybTPOg6wMMuXmoCQPG/FF1Iv4Xz4PR4PwbTZJ6yFbOkVbVS4rVvqwHjKVUgI
	 dipGK4gL/7U2aZ+wdvx3GXlZMlAsfnO86KRHPY7yjyWS8kvjIL7QN3i7R6vDeA7LvI
	 8tRoxL6C3eg08+NQihufNSV+hUry/ge/Y3AsBQZLwh+L5jHFHPlm516Mmtc/VhROGT
	 lNdUaWjfNv6gw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0ADF0198003A;
	Mon, 28 Sep 2026 06:45:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 06:45:25 -0400
X-ME-Sender: <xms:Q0W6ame47D9MaXBY-G9oKtIF0u9qyGuMcWh-z2_zFY13ibi5h3FpMg>
    <xme:Q0W6agrV11EYmJoOBxuq2ktzvOciho9MYMAFiT5kmXW78D2IBup33aLx_LoiIY49Y
    1vueIlY5LRWfOPCmz7_8meHs3t6DihIw2c6hyVOvML_tBSSsFAU95pJ>
X-ME-Received: <xmr:Q0W6as_0QqgphPDV6kZf_MxU08Xna30sVf_-eX80ZHpUMsQn7wO5WKIDVJU>
X-ME-Proxy-Cause: dmFkZTEQ2M4Yss00TVpFpyzYKayTNLhSmxlk8jgjYdWRC8efZB9dhd1fhy51Ard/y+ZR52
    mQzsiCa3phAmXiUEsipTMcJZKBtf9dU2wz0a/IwoLhZl3hUY9v5yn7wDMUjwGwyJmAh0XC
    bjpflSyPRI5OmclTeYExGhZ5xy1PLjrywhAsS7laXNeXT5atgJLELAXGuiG6jFTyo89i8N
    6QrLqf/9UpPfOJ2VRQ1pffV0SHdsTMeCSkgCgk8VYQb9KnDhpYc08nTyCMw2ppxi1TusCU
    frbp1suLUW4f78RzbWO+LUGjoIyb5F/hrDuH1UVFGbQmOyOePFniGTBH5CX1x2U1eK0tTx
    3CAj7Tq/ETMBGkHKCBBxSzxkd2hwtd2MP8GN1m1ZL8D3ztlRI0inQfX9YZexQE3LnePDsI
    hLJiZrCPKPYIfvxLOJyUytXOdjKpzSmzMbkmjcyAqnkzbEPpf4SgGJawzEm0x0fdIwPwjL
    WUDs8+RNftCaeTHljXiKAoiW0Drmk3JYLBXfpPOAuvxvbfywJHy07rCO+YQQtuk8MrN4hS
    Gjdp+OMmA3A0b+SuFVP2TYpGnsTcGrcLzmgM22cbxKxmJJd4LToubqv0fB9JWIy+7mn9XT
    MJz++EzRZD1yR1mm8QFaqg/rtlE61Yca4OhgDVTw1nD/DjU9h4xDSAVKht2A
X-ME-Proxy: <xmx:Q0W6ah6NgBNPToTjNWoaDm7omAaGWgrC7ZsS_-8lm7O0g2QIPq8ncw>
    <xmx:Q0W6amiC5N-CbhpZ6pkSN_tQeoY6Q9uScOkFbq1js8aBwq4he4mM_Q>
    <xmx:Q0W6aor9HR-Btkv3EH984Ou_Fq34Qwvob97iB9gBtEPcIKifgNOT_Q>
    <xmx:Q0W6aiLViP_tumx3rNT1HgsOVtVpqiNQYGxqh-3WA6npHFMkfpAzRA>
    <xmx:Q0W6alvyKHocqgx1txQ50t5HDAyk0da1pYdclSxqTGrghaw21JLIPODy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 06:45:22 -0400 (EDT)
Date: Mon, 28 Sep 2026 11:45:21 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP
 self-merge
Message-ID: <arpEHIwTy8QxUjI2@thinkstation>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-1-6ffb556f8f8b@kernel.org>

On Sun, Sep 20, 2026 at 03:13:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
> 
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
> 
> Fix another of these - self-merge.
> 
> Self-merge occurs when a VMA is moved in front of or behind itself and the
> attributes of the VMA permit such a merge.
> 
> Practically this can only happen for unfaulted anonymous VMAs due to the
> page offset equality requirement for merge:
> 
>                            |------------|
>                            |            |
>                            |            v
>         |...........||-----------||...........|
>         |           || unfaulted ||           |
>         |...........||-----------||...........|
>               ^            |
>               |            |
>               |------------|
> 
> This becomes problematic if the VMA is configured by the user to
> mlock-on-fault, i.e. the VMA_LOCKED_BIT, VMA_LOCKONFAULT_BIT VMA flags are
> set.
> 
> MREMAP_DONTUNMAP clears mlock flags for the source VMA and maintains them
> for the destination VMA.
> 
> Self-merge makes this impossible (there is only one VMA) and incorrectly
> clears the destination VMA's mlock flags.
> 
> This causes a leak in mm->locked_vm as clearing this flag does not
> decrement the counter and the VMA no longer has VMA_LOCKED_BIT set so it
> is not decremented on unmap.
> 
> Resolve this by simply disallowing a self-merge in this case - the source
> and destination VMAs are kept distinct and then are able to have distinct
> mlock() flags.
> 
> Update dontunmap_complete() to make the now-redundant self-merge check a
> VM_WARN_ON_ONCE() instead to guard against future regressions.
> 
> Also update the VMA userland tests to reflect the change.
> 
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

One thing: mlock semantics of MREMAP_DONTUNMAP are not documented in the
man pages, only in the commit that added the flag. It can be surprising
that the source gets munlocked. I am not even sure it is the right thing
to do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
