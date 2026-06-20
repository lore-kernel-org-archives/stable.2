Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F37A40D57C
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781921472; cv=none; b=O93XDN7gbAII9V82mNgLXJCBud8tyvj2c8H6A996mS9+4xFH36/n9BEH9Z2tlXhOgiazwKOKhyJ8epMZ3BL7u381HkE6i70UXHUW9XW22sfHDfB3ML6ixn5wUlIBqsP1D4hD3Xi2pKQiJtOSb2jUgY8HMYcp/jwyaU1x0L560tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781921472; c=relaxed/simple;
	bh=hRaGWtk2/prMxroXKPI8Y/buaQBOJTQAL/3M7NDnNik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gah9EjBoU4fYkiDwJoSoVRfygF4WsBZcv6vXtL3TbLzl3f6q0L8p6ulVYtC4CV4QDDoid+THMhgM7S6KxBzIdYP3+K40hJDQCOa9y2Omnh93tzXhv+WpJIMHfQ0+CPDPwfg3kBp06Fj/BPin7Nz3Xb90QVh271+LFcElQDr4VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcqhNV+7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcqhNV+7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec450b950dso374185966b.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 19:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781921469; x=1782526269; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g6texoIe/Wti2e0fTI/Tf7IkHkYNk4fMe8DtPT8ks4=;
        b=OcqhNV+7I5BNiD4lhQquoUZbSs54xkn43WoUw/cAsK3zgniS/XK5xjG7NUO0MRcP/J
         DuNyACyNgrOouNFyUvjWo3r0DIOKBIDkXuuRu+TVHTdIOLNF2xJBhJmQzcPXRAPQZopW
         gb+1pgDwWRRNbN/e6XLexgfhaMLq5y+gEnW/NzfFIB1iLKUguE+x21nZBhBj9gQottH0
         v4gTGHQ8V7jsZS8bbvDGoTTT94nYfVls2aAL1zIi+Xh9H1AyAj7yQDYXktexPbqJ4PnM
         c3C4anoy8SPVaUqaRyRq0/uWx/VjPT5uKrExDILXsRe0MXJbjtTr449e2+nowdqIifCO
         4ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781921469; x=1782526269;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g6texoIe/Wti2e0fTI/Tf7IkHkYNk4fMe8DtPT8ks4=;
        b=CgS2YO/blCBRwHzJ1bqjtRDN5v3NVD9D1FoEZCk8DnmZDK6gcCWWSCeKiGmSZnf5Ue
         0LGNwygzYCkQUgpOb/ubGl/foilBWr16HfqtedFgxjb/B427q+cg27c1V5Xljr5Xn8J5
         yLSzZMllHF2bQXDqSefGTi0Ufqgj8MHsu9PjAiO3+O3XmRVzYvTuGm5g3TfhL6PZcm1Y
         qQ7R43tZ+wo32v0v+rgKDk2TzOjYuzcLAFW4i4iBHfBEAz9OxfZnom7OujKf+eNLU78r
         e7YRfqR8BI34iGX1tdAtwgSgXQGa+6E3L4lcvg+fKG7GwQhqihSTALvhnMGqdIVl1bF9
         +0Cw==
X-Forwarded-Encrypted: i=1; AFNElJ8mQSzHVKbAuyLfR9gyuFmWNy+aYVM8WU4zV6jFFPfBdffwDUu9o18QXCwIEyYwSeVuCuOWQH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1Jc/DIS8u28z/q4D4UvwnRp9MD7LwY9v88tnGdmKzvBQMBcF
	OVdyjCPiljBZYszvsStkMO6iUhaG8bmGRkb/pgA/jMivdq/joHO51LtN
X-Gm-Gg: AfdE7clfWAGkRTi0PaRd5pkqhKNmvnrRw29g9rqvr5xXmUIyUuG79XszDYJVaI5fdr7
	M6c4a0duzC60HpmtvqWH2CVRukSmtoD+7r7X+VQwZPJwbjnfdo7EolWwkmVkSx9El5M0d9PUzpd
	RFDa9E2GBrBs27h14rxeM7Ri6oKiLAxFfkjeySehQ4FWshudmtwSrpn82pg1CAQaHHoZ2NMphiL
	lYICEgqO6kKDnuZ7OShh5C3wlr1ApeovKQEghp6HxILQtlHWJGH9BTBwFi9448TM09ZUvqf8miQ
	XTW5zUQ/GIr5pk6zc/xwUqo6DB7QCdyy34FbLicvsPEm/MCK7D2y6R0ue+Gqh+fnsPJlcC1Vsi3
	TwxyQEkNptB6M2D7H+8CxVbj/1BwaQIMjBHjjBGN2LbGaPwxnC7cXZTnaYa1Ih6URF1F9UIqs1A
	VObXSH1sZWXoE=
X-Received: by 2002:a17:907:3ea6:b0:bfe:ed06:565e with SMTP id a640c23a62f3a-c0b75a8f179mr251081266b.51.1781921468894;
        Fri, 19 Jun 2026 19:11:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e497e88sm48240866b.11.2026.06.19.19.11.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2026 19:11:07 -0700 (PDT)
Date: Sat, 20 Jun 2026 02:11:06 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	david@kernel.org, riel@surriel.com, liam@infradead.org,
	vbabka@kernel.org, harry@kernel.org, jannh@google.com,
	balbirs@nvidia.com, ziy@nvidia.com, sj@kernel.org,
	linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <20260620021106.u7gebygzqrp4ghg5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <ajUXNjRMraKb6k2n@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajUXNjRMraKb6k2n@lucifer>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 19, 2026 at 11:44:13AM +0100, Lorenzo Stoakes wrote:
>-cc wrong email
>
>On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
>> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
>> before return the pmd entry:
>>
>>   * re-validate pmd entry after PTL
>>   * check PVMW_MIGRATION
>>   * check_pmd()
>>   * handle on pte level if split under us
>>
>> But for device-private pmd, we just return after pmd_lock().
>>
>> This may return improper entry, e.g. if we are looking for a migration
>> entry, device-private entry could still be returned, which leads to data
>> corruption.
>
>I don't thik this is quite clear?
>
>How about:
>
>	If a softleaf entry is present, the existing code simply acquires the

How about: If a softleaf entry is present, e.g. device-private pmd, 

>	PMD lock and returns success even if PVMW_MIGRATION is set (indicating a
>	migration entry is sought), meaning that the caller can incorrectly
>	interpret the entry as something it is not, causing data corruption.
>

Looks better, thanks.

>>
>> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
>> support device-private entries") by following the same pattern as
>> pmd_trans_huge() and pmd_is_migration_entry() for device private entry.
>>
>> While at it, it cleanups the pmd entry handling in page_vma_mapped_walk().
>>
>>   * Instead of handling trans huge/migration entry/device private entry
>>     in a mixed manner, we put each case into its own if condition and
>>     handle with the same pattern.
>>   * Also we grab PTL and make sure pmd is not changed under us after
>>     above check instead of do the check with PTL hold.
>>   * restart the process if pmd is changed under us
>
>You're doing quite a bit for a fix and you're putting it all in one place.
>
>How about do the fix as 1 patch, and then cleanups as other ones? It helps with
>review too :)
>

Got it.

>It's a general rule of thumb that if you do more than one of moving, refactoring
>or changing code, to do them as separate patches so a reviewer/somebody
>bisecting can clearly separate each.
>
>Also PLEASE do not add new functionality (this lock recheck) in a fixes
>patch. We'll end up backporting new logic that way.
>
>Make the fixes bit _minimal_.
>
>I think in general Andrew prefers separate fixes patches so I'd just make the
>_minimal_ change that fixes this for the backport, and the cleanup stuff as a
>separate series.
>
>>
>> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
>
>Hmm seems the device private stuff has had a rocky road of late!
>
>I wonder if we need some more test coverage on this?
>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> Suggested-by: David Hildenbrand <david@kernel.org>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: SeongJae Park <sj@kernel.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
>Annoying nag: You sent to my correct email ljs@kernel.org (thanks!) but also
>cc'd the incorrect one, please only send to ljs@kernel.org thanks :)
>

Yeah, I pasted it from commit log of the fix commit. But get your kernel.org
email from get_maintainer.pl...

Will pay attention

>> Cc: <stable@vger.kernel.org>
>
>Be better to just have this with the Fixes tag, Andrew adds the Cc's from the
>actual cc- list anyway.
>

OK, will move it close to Fixes tag.


-- 
Wei Yang
Help you, Help me
