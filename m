Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8591385509;
	Wed,  3 Jun 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478238; cv=none; b=pFGmPRoK23EcPQEwrHRwAzuZ/WJiHbGLJR0slFKsWh5U6X20Q9dTwvmWC9Xu1EFgiskDzXWClz6k+aKQz8IKE9GJM/jLs5Xmlin4EHisUsqxm54yt7D5NsM7AcEHKHNY8z9nd3oM+IuL8eXjKjNNbVBfvHeL7yAoFMxuK/6LJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478238; c=relaxed/simple;
	bh=fVEQwUhLoVNS2/4eGVtXLnWvltW4cAklpOycSiFtU34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chx9An11nFhgLK7M3mw7jACOTHUWajqI4pmiTVvreiKLuXulSBjkjaVUzeboza3rF7YMOXjQRXdA3+bMpFgxVBgy2P4wcH6AmekCkWGL22yPQxWYp8LAT7FxeQ7LURzoxya1zI60//E7Pf9aI6XdRyO52AIPM/EfgJ16jSb7z58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNnUdHOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNnUdHOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27D11F00898;
	Wed,  3 Jun 2026 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780478233;
	bh=MQcYvCT3a1VhxRUtA3yBud3Cov811xvbS3O5Ig1I1EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eNnUdHOONZj/Uqfobds326We859nRyj5alnrvuw22DWztlicGiTtvdh/lPqUMHomH
	 eusa4H1OccADhexFj1ZDOpYnipOmGEVGsmmWLCqRXYHX6GeVbfE6sq6sEw0wlYbVpb
	 +pFWjneZKUQta42+/f8Nf1T6gFffvQ3ehLIzBzKTvSASlplK9weKercZg/MIhicvyh
	 xyKmyPwJTFKDYktmLbUpzKaaPXn5ri57SqdVgp7qgrSzD/hvcjXWEHeIwAoTJpKh8N
	 ASglMn8rh4GxR0GHGJwf+npyEvFk+88ZWdOtDh+WbDtescacZBZp3AhSbo/HcvL7Sn
	 afoMjRs6v8nyQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id D04F1F40069;
	Wed,  3 Jun 2026 05:17:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 05:17:11 -0400
X-ME-Sender: <xms:F_EfanZcvCdn_IXcFRLd4iKDazSop5vjxZl1ouYp9GeOxqA5nRavYA>
    <xme:F_EfaoyIf5rFHeBAAQeAbqI69rWQlwaEF6zrVKizOgD_i4CgwUw9RCyta3eCRGdFM
    9HdhRUIPOkIjB5TCakGwIqkpMFTJ-BN7jt9Xeo28JQodLGaTX1Tc1E>
X-ME-Received: <xmr:F_EfajPtnZ9KNOhTYs4_uvPIl61OW-YIyf7DhoYiXTlhBYTrlVlY1g8BhsxveQ>
X-ME-Proxy-Cause: dmFkZTEezkExBEAIasghnBjiLysnYWt/PY0pVmQQaVS2AHfOsx523B0oS6FXtB65660IUX
    Ik7qeiMI7PD1c2/VWZGwROrAwi/xjvTxBVXtAeKDoQTzSe4rcT7tz5VEeOidVy1nkIsUJw
    qMPOdTqvhppr6iBrbU5iKf5PbS34JKc7KWpNMXWq1iVfFe86W2okDBZ7BsLYh2sxJXDph5
    WPj/raJ/oHFgrbYK7fCJEbDyu56K4mVEhEsrwg8DfdXEyRID3Id62znlLnyAXMSO7DqL/v
    6ud7XPsjkkElM2rszubqPIZFZyPZCVQXpSeF3Vo1JRkGbK6ITAKQbE9lwWpkpp9ZZbNLEI
    1E7YAFlvx6zOFsgMTeUSEtVbXlXsKL1XV/Jpq7Zay7VdPwgSJGtXu8hg77KrmAs1fNKomh
    XOuW2GO7NEgX1KY9JugpJ6hC0eBYlX70fuOf7c1+NrFxOH/Th16u7rkJNzCXYhBdNvy3Ct
    8ksInv+Hp3fIa4yqVA/JS40Fre0RM0bto9HQ5nsmCF2XotFbHo0V7fOgiyXcRW4CD3VR70
    sf+5PrMtdU/v5qRMJ3KMZJclBdzVDnYic3o383/5L0KefvqeNTz7pAYVnZNMqn6B475kwJ
    QKWZZLCwpz33f/ujUS9CAXEfSaWe2FpYzxuZpdLbT7PhSijxsfF0Um9zUntg
X-ME-Proxy: <xmx:F_Efagx8HkpG9ov_-pm8rTOFX4E5eMtiHJzbN_1TM0Dd4anhnaXGyg>
    <xmx:F_EfalCi8PbrH6J7VCPFstQ77JnqVE2F699dViPj9tuSiFP9KA1ONA>
    <xmx:F_EfarMrzoXMp6lunk_04ZhhPiGoB_SMYETpVC0V2f-c2SUz-5AZ3A>
    <xmx:F_EfamYDrvz_hD_WXX9b291GPjGzmQ0qmS6BZW8S0jOJggTlP_GKhQ>
    <xmx:F_EfahJZ_12Jbk3MrZtBOfiKCh1BeMskekjHnRrNiN2w48UMPjI9aUoz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 05:17:11 -0400 (EDT)
Date: Wed, 3 Jun 2026 10:17:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Pedro Falcato <pfalcato@suse.de>, 
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 6/6] userfaultfd: build __VMA_UFFD_FLAGS from
 config-gated masks
Message-ID: <ah_xBwbAexZ7ew0t@thinkstation>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-7-kas@kernel.org>
 <ah6VNjfXXx-3Nh9l@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6VNjfXXx-3Nh9l@kernel.org>

On Tue, Jun 02, 2026 at 11:32:54AM +0300, Mike Rapoport wrote:
> On Fri, May 29, 2026 at 06:23:30PM +0100, Kiryl Shutsemau (Meta) wrote:
> > The VMA flags bitmap is a single word today: NUM_VMA_FLAG_BITS is
> > BITS_PER_LONG, so on 32-bit vma_flags_t holds only 32 bits. (The bitmap
> > type exists so this can grow past BITS_PER_LONG later; until it does,
> > anything declared above the first word is out of range on 32-bit.) The bit
> > enum nevertheless declares some bits unconditionally above BITS_PER_LONG --
> > VMA_UFFD_MINOR_BIT is 41, with VM_UFFD_MINOR == VM_NONE on 32-bit so no VMA
> > actually carries the bit.
> > 
> > __VMA_UFFD_FLAGS feeds VMA_UFFD_MINOR_BIT to mk_vma_flags() unconditionally.
> > On 32-bit that becomes __set_bit(41, &one_long), a write one word past the
> > end of the single-word bitmap. The compiler folds the out-of-bounds store
> > with wraparound (1UL << (41 % 32) == bit 9) into the first word; bit 9 is
> > already in __VMA_UFFD_FLAGS so the mask happens to come out right today, but
> > it is an out-of-bounds write all the same, and any high-numbered bit whose
> > mod-BITS_PER_LONG position is otherwise unused would silently OR an extra
> > bit into the mask.
> > 
> > Rather than feed bit numbers that may not exist on the current build to
> > mk_vma_flags(), build the mask from whole per-mode masks that collapse to
> > EMPTY_VMA_FLAGS when their feature is unavailable. Add
> > mk_vma_flags_from_masks() for that, and define VMA_UFFD_MISSING / _WP /
> > _MINOR alongside the VM_UFFD_* flags, gating VMA_UFFD_MINOR on the same
> > config as VM_UFFD_MINOR (which implies 64BIT, where bit 41 fits). An
> > out-of-range bit is then never materialised, on any arch, and the in-range
> > fast path stays a compile-time constant.
> > 
> > Fixes: 9ea35a25d51b ("mm: introduce VMA flags bitmap type")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> > Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-8
> 
> Can you ask claude to produce more concise changelogs and better split it
> to paragraphs?

Will do!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
