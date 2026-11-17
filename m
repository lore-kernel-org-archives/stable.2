Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914367;
	b=hnyVAEs0JkhGfhhxmSohWo+gzzhOFJpR25CxkecwOX63020GOGQHpIFexZzNLob/L6Fd
	 95ll+aaI+vs6C0XRlXaB/j7utEVJdGHJe/JbZZgRMmjXeNn1XonoTgc786tK0QHrPEOw2
	 7suLQ/cDpd7wjHSFxdP8l5jdvdJkIAgiR2XFKRm7rPGwIhNgiKfFgP2whjomRyYNYT+c6
	 44wsH+A66ZILTvXWREIi9HC1Rg6F8u7aE0fpeWohY4h5Ft8A7eQzGIEs2fhqK/uDoUmkJ
	 9PH+xipYTO4nSVLTkB9j35hH77lL6dK2wemkcLnvHwKpYjJ1Nlp/f2Bw/vue4HY2IgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914367;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=jmRxQPVUK3jeDTIVGHnBZg9JSxo3fE9mQz3Nh8K4I5U=;
	b=hTjE0TKr4eqluaR9TapX6AdfEK11QqL8Ca4+ax6UkW1PldNBcNXnjcymShg0QoXlrvZf
	 FnPLEXMlBb+2FTJpRu2STMwA93FSGUTxbnHfs8lQCVBpOEVaIZtDm48Xo/fiJDuszoJ/9
	 EL1v2fF5f1OaGvrMrVYPvC3L3x7lnKH4FG4QZHfiAivzcvZapcIlu0jp2NAnlb2/1vDFE
	 hVu2/sqVr2jVvynzwNtLf2zKwV9pZjzHrxKFvENFFQgtXWHAQDylaXkRwpU5SXfHvS7qv
	 hlAB5UolOT1tifpYIwLBCkfJ/NirMjGnK7vPuAxvds+iZ18oK9ceHbPsCN0J0r6aAMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE5y8BbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F91606A31C;
	Tue, 17 Nov 2026 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EE5y8BbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633921F000C4;
	Tue, 17 Nov 2026 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914366;
	bh=jmRxQPVUK3jeDTIVGHnBZg9JSxo3fE9mQz3Nh8K4I5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EE5y8BbOm8OvZCB0Dah2qA1gwILUqNYMmrizrbU1YH9mbsRr8Tluhiz3XAfeVEpfl
	 TC+VkLiFOOftBWtpkiJylymZkbg8zMJXjdvrgXVmJu5NAZ2CwVTIfbHQ/E9dH03rR8
	 heYzjpTRv4lcel0NgF0Y66YhPt+0dp3LevYRHVMZ+HujsjwFez7YARUziMXHOpRwa1
	 YHuhdm+rUPHZ669DeNRLezXZOs3mfux53dWjtxwn2ssxWZo/gXbUaDqmlMKUwu/f3P
	 6sWcKYaWp+eZGub8XNsfsKzsRVbjxSAlc2zQ2eSMp8jIjG7BpTxihF2Wvt85vvDGvw
	 GwdISJ6ylbWvA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 7DE3D198004A;
	Tue, 17 Nov 2026 06:19:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Nov 2026 06:19:23 -0500
X-ME-Sender: <xms:ODj8asmjZARLlX3WpTJJuVqsPob6BMBBoFDeyMr_4vl6iQXvaDClBA>
    <xme:ODj8ajlG0kRVxiXQZPQ590s70WvKtqzqusjwyZz96ZUMU2A741QhbqFBrgaD7Px1G
    jcdVJNDxNP09I9EcWql0uEajLj7TiI32bb-IPYigLq0XMpLwmjms4fy>
X-ME-Received: <xmr:ODj8apNCnUYvlo-8rdzb5No25ufJ_nmNlfUCIvbretlYp1zmfopiQTdPSSM>
X-ME-Proxy-Cause: dmFkZTFUPiINActD0mDIlZFNb+WeDPVf8Y0W59PjGpKdeovC1oExoWyA7gCtP4JbTeIA1q
    +22xWFGwJcPngXKrCApIQ2f8vk3rGH9HSFNq4esX30kP89EjM27GtzUYiW1B3kU3Y1fyuG
    X9qiWQH9BmDOSudlhjd9tPIRZYCBXG2Rh/l09ZqHR7gz6sJv9eg4j4KMMXUDrJQaPdDpj1
    +JTsoTCvbnfwodM5GhfGE0jEUfvdcNmLHB6euiUvH07IObIDhPq8MOYCYfHrUDEBFjxLZs
    /uy9Yo3FaoZN1mopb9H1+8QNWXHtZUurIGBbMwOmjwAvyIT87LF0X7jBEDiQwTgisY1fmT
    5gUswFuCj1QdGKf+AarXgZnFTVchUh5I6J9xbPswT4c8f1HE7EvbmJeEjjs+Y4O7rL3iZN
    wFu4LLr5G672SSV49Tfke4Z2lyE8wdFSttiGeHj6GVlnolnwjV3dGal8Rricmtx8+uMc3P
    AKabHWZTxt6BtWMp+rUN8dxqW1Gnp15VxHT2QmfpauEKENl/7Ka6ePGarayix6VrVHs12i
    gWjRst9LVYotb4FpOriAyCaLpAUy74KEO2iq5pm3HTD15otJzrVIeVudAG0OKySi8b6Ayi
    Ykc/zdHeHUYs6gx6wU5gP7zDwVg6Oh50mbvQJObQkMp3cOmC2frM3+h9hnVQ
X-ME-Proxy: <xmx:ODj8ai5s3C1EvoiVSPnRF_dzviMywBC6wuPhpvk1bCbKxYmeqomtfw>
    <xmx:OTj8ausONLptqI0PNztWPZDRBSwyXfG6RfEZVXuIxbQHbUecl2dzpw>
    <xmx:OTj8akOFqNm3O7GRfCu56cEQxlIQRSWoms3BjSJ1HfbPv8a8tKt3oQ>
    <xmx:OTj8aiofBDZ6Y7EgzpJFz98dYo6InaP3PFWg5ISTFIzPPBDoTeekJA>
    <xmx:OTj8ahGXFyAkbGMD2MRtCEHEFa1bnGHoyYVGREuF1MaCRcM9ja-pUT-u>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 06:19:20 -0500 (EST)
Date: Tue, 17 Nov 2026 11:19:19 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	Daniel Wade <danjwade95@gmail.com>
Subject: Re: [PATCH] mm/khugepaged: mark ptes dirty and soft-dirty on mTHP
 collapse
Message-ID: <avw4J0mBLJQMzdMc@shutemov.name>
References: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>
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
In-Reply-To: <20261117-khugepaged_mthp_dirty-v1-1-024e4a12c2fa@kernel.org>

On Tue, Nov 17, 2026 at 10:28:18AM +0100, David Hildenbrand (Arm) wrote:
> An mTHP collapse can lose soft-dirty PTE bits if pages were written and
> the VMA was then made read-only, and not setting the PTE dirty in
> VMAs without VM_WRITE can interact with a later MADV_FREE on a COW-shared
> page such that all processes lose the data even though a single process
> MADV_FREE'ed it.
> 
> Collapse does not preserve the soft-dirty bits of the old PTEs, so the
> new entries must be marked soft-dirty. map_anon_folio_pte_nopf() relies
> on pte_mkdirty() to do that, but only calls it if the VMA has VM_WRITE.
> 
> Further, after CoW-sharing such collapsed folios later, all PTEs will be
> clean and the folios will be clean. One process doing a MADV_FREE can mark
> the folios as lazyfree and result in all processes sharing it losing the
> data once memory reclaim zaps it.
> 
> In map_anon_folio_pte_nopf(), call pte_mkdirty() unconditionally, just
> like map_anon_folio_pmd_nopf() already does with pmd_mkdirty().
> 
> Consequently, we always mark these PTEs dirty (including soft-dirty) but
> only set them writable if the VMA has VM_WRITE.
> 
> This essentially reverts Hugh's commit 1ac0cb5d0e22 ("mm: fix anonymous
> dirtying") that back then touched do_anonymous_page() to avoid forcing
> clean anonymous pages through swap instead of discarding them. This no
> longer applies as shrink_folio_list() allocates swap for ordinary
> anonymous folios and unconditionally marks them dirty before unmapping,
> regardless of PTE dirty state. Keeping their PTEs clean does not make
> them discardable.
> 
> This now also marks fresh anonymous PTEs dirty and soft-dirty in read-only
> VMAs when page faults allocate real pages.
> 
> This has low urgency.
> 
> Fixes: e22f2fe72c74 ("mm/khugepaged: generalize collapse_huge_page for mTHP collapse")
> Cc: stable@vger.kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Reported-by: Daniel Wade <danjwade95@gmail.com>
> Closes: https://lore.kernel.org/all/20261117075246.61336-1-danjwade95@gmail.com/
> Reviewed-by: Daniel Wade <danjwade95@gmail.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
