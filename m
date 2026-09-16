Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4404EE845
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563909; cv=none; b=i3aEJ44PC1cB6ll33FxW+VExWtJBi2vBJ1r7Ew7RobfBhqf5H8g41J5Xnxqi5Oppxa8DsIIdw7qX3aC2hfRXkO1q/hcMdaR2lTBwZH+hb0mejuWjpArhdku/yblcJp1DOOD5GwAloBz0/wIXs8p6FMySoS0Rbit1RfJSgslTSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563909; c=relaxed/simple;
	bh=9NZXR7HhTGbr+mFdcM0XPcLA5Upvyt8WzL9X7DcFzCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTeUSEopgCQ5R5lPyUOD1FMq4jLbwDamcTXrXiNQdmjFymHyhUwCIqtYp2WH3MFrnTEdqh4MpdXaaIzf6a4RyehwZK080mAZ5Z0wGUAJmoKGVV1qqj0LHeQ1gTVowF+AcYiobOYET+5Ivjuhhpz6XH9aIriSGX4vcbP3I70BgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=seVU1oNG; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="seVU1oNG"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d0d5ae11so9811281cf.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789563905; x=1790168705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZYdUhGpjeA7km3CAfItuHpRj6rsHx55A/+kIwM9brrI=;
        b=seVU1oNGgv5W2fQrn9aGhIrSuoaSy4y3MHq390I0qAkT25tTb56zJw0ywmrFlK4QY4
         HN/wyyvkoRnU9AEuFm+s5eDHjelzvKqvp+rPbKSlaP2Zy+IAovBdpREzLuwgOPsN9RPk
         DV5RCcgRSPPUkXPN8x3lFe9S6ktY8epVIlgwyg9S9b/J5ihc0iKpqprHa7XputVy6Jq6
         e/Y1zv/ipZDJJCXHhoft+7M8bJHnC7qalCq40VZWGRLjk78D7LsdLuB2zR2ihqRPwCcf
         3wkvTw8FapAWc5U4eC10vPqaUusKR7ZJS0vwaomrrEixYgaxYO8+sUxquefLy4+fqAd6
         /npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789563905; x=1790168705;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYdUhGpjeA7km3CAfItuHpRj6rsHx55A/+kIwM9brrI=;
        b=IHSryMsVp7l+eBKNM6hP+OnzlC268yZl263RitdQkLGUKIkuh2NIDwButA8B7PBK13
         INYX8pBw26YbUHhCxfOT2r11HxWUChExpTc6n+zhSWDPeuSuVHNlVn0Eua2z08YOKttf
         vp0pQaSo4YNkbA6Ssl2t0i7SFdwgkk3S6wtn/sIodH/ECub63UlczepY0iLO2JZXJfcv
         NJtsP0iB9nMaGq49wglzvUUnEHK2WwMTvQpXucRhBl4LaZSf5u1IPykENQXDREBb0FNM
         S5s5n9NNDrg07QumuU/c71N2fgmh19KwKGay9XYnhIusadyWGpFIaWKwjnlVBfP9Wo4X
         /w5w==
X-Forwarded-Encrypted: i=1; AKwUvByPWGz1P1YKZLFW9nx7XL/ogvH845E+ZZRx53WBFcSypbwbkCpGwbkHRQmD9AHjJGZUn7y9+VA=@vger.kernel.org
X-Gm-Message-State: AFuF++lppaDoizSETN3NkrRIiPB9RL/l/TQ6mglXq0Nar0lOA12hsoed
	1oDczzIHtHDTmQJKbpaonl8f0KZy6TYbJqtfBi7KrCLAWdjelGe9OOSjJAiL5VGNbUM=
X-Gm-Gg: AYBFou1zan8fQXdEEeDtcIPwoVHnnWOMzt94sK6XX/A5FcCGfEYfgM8yoc8gwlXIy2n
	cirGTF6X8p5JNwFe3/dsSQ46Pa3IE9EL6wawDz8IHuL1Yd9nqbKnOUARkgXXTRGgCLoNgaN2qgo
	cNa0dI/1cZ9XSwQUKqZvsv41PsM5UEBMfrzlxaLql+FU7Wsz18vxLmb4tJ5Gu6V5aEQPCzmHxDB
	SMQqgd0rKD+xBlpcim4iMzphRE/K52s578nW+HouKPt8KNtkXGJdbLG2EtDfQ39dKjRetASQO3S
	dbbma2JK670dQ82nX54viXYyz6NWJn3UB8EqNrRVDxLv5yi+cPRK37QYyINkZBc9PDoNdx/TVfu
	+dvi6Xwz+0uehSjUs0D+AGw5ZniipNxcCdx6sXwvJ1HgxKtcGYb4vFyyJczW5i+4Gbplb9WWwn1
	h7EkM1dWOb2ZPdtc/XBnsywZLmLbU57uKoORbRN/d0ADorGdmcghqTGtiIV2AxBvfvXeTidF2cE
	sxtu9SrZ5h4e82JtFEPhrB6nMIMewAWdNvzPuk4kw+laA5C+fv6vlI=
X-Received: by 2002:ac8:5742:0:b0:530:eb7e:79fb with SMTP id d75a77b69052e-5327f05f9e4mr43255651cf.45.1789563905323;
        Wed, 16 Sep 2026 06:05:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53261fd7e5bsm21409661cf.7.2026.09.16.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:05:04 -0700 (PDT)
Date: Wed, 16 Sep 2026 09:05:03 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, 
	jannh@google.com, sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/madvise: use folio_trylock() in the
 cold/pageout PMD split
Message-ID: <aqqTl7JwYzM7azlF@gourry-fedora-PF4VCD3F>
References: <20260912110540.3203010-1-gourry@gourry.net>
 <2f63b25e-71ca-4af6-83d2-70be2388a55a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f63b25e-71ca-4af6-83d2-70be2388a55a@kernel.org>

On Wed, Sep 16, 2026 at 08:25:01AM +0200, David Hildenbrand (Arm) wrote:
> On 9/12/26 13:05, Gregory Price wrote:
> > MADV_COLD or MADV_PAGEOUT over part of a PMD splits the THP in
> > madvise_cold_or_pageout_pte_range().  Two threads doing that to
> > the same THP create spurious failures.
> > 
> >   CPU0                          CPU1
> >   ----                          ----
> >   folio_get()
> >   spin_unlock(ptl)
> >   folio_lock()
> >                                 folio_get()
> >                                 spin_unlock(ptl)
> >                                 folio_lock()  <- blocks, keeps its ref
> >   split_folio()
> >     folio_expected_ref_count(folio) != folio_ref_count(folio) - 1
> >     -EAGAIN
> > 
> > CPU1 cannot drop its reference until it gets the lock CPU0 holds, so CPU0's
> > split always fails.  folio_trylock() makes CPU1 leave without ever taking a
> > reference.  The PTE branch of this same function already does this, as do
> > madvise_free_pte_range() and madvise_free_huge_pmd().
> > 
> > Reproducer: 400 rounds of eight threads calling MADV_COLD on half of each
> > of eight THPs, re-formed with MADV_COLLAPSE between rounds.  From
> > /proc/vmstat:
> > 
> >                      thp_split_page   thp_split_page_failed
> >     before                     3186                     860
> >     after                      3200                       0
> > 
> > The short before count is rounds where every thread failed and the
> > advice was dropped for that THP entirely.

bleh i thought i rewrote this sentence.

reading madvise is driving me crazy.

> 
> While the split now succeeds, one of both calls will just effectively skip
> processing the page table. SO while CPU0 will succeed with the split, CPU1 would
> just skip the page table.
> 
> And what happened before?
> 
> Split on CPU0 failed and it would skip the page table. Split on CPU1, however,
> would likely have succeeded?
> 

Yes., all correct.

> So this is all far from perfect.
> 
> ... but this matches what we do further down in the PTE scenario.
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>

Thank you!
~gregory
