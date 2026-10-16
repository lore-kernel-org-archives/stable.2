Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202E9383983
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119405; cv=none; b=Ib2iKomybaLSsnTs8wFKZIRqMZPy56YpHHpppPeVKORZe+jCMlidmamsA1bI8ErEZrI7kplkry/AYE/GSPspj0XA6E8ctCYG2edPfbKTYEXflwZz+MoutlnxErtM6w7lJRyd+iUue+XYRbQR5Q93bqdi1Vu0IOh5WsMrBny/ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119405; c=relaxed/simple;
	bh=mtxB1OwQH2CyH4ORbA6Epab3sPneNPWVVjItMLtc0ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX+MRtjXAZfWST54pT2Uc1pgoKejAzw21ftFMrnGOy9mFDygKsxis5uR2FSXAEmgyOc/f0DTJV29o6C+oNmc+9POk3rUcoVLFHx3IfCKv14asb+1n7XW8ZWP7NsoPhAUmAdurSODv8Ex/nw2fBFi6n3592fP7/f7+fJW0M0F2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=LU4rTv8f; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="LU4rTv8f"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-49e1251674cso880328fac.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792119403; x=1792724203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KoU7NlRc2WHo1VRPn8/Lg64nT3xPfPjPfg5kvwFTx1I=;
        b=LU4rTv8fYJHDgSUUXQfyb9ZSq742mZu40njPSSAk5QJ2dhCOVui20sLPixqnc8IKUu
         4MxYX4UIILmKWvpk9pJjEdEyiX5it9nFlhMmYBzGmzzquj7Cxd45y0yec0jGgjwycsbU
         ukVksPfsUx710HybB2vjUp2VIcXMlt2FJkNF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119403; x=1792724203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoU7NlRc2WHo1VRPn8/Lg64nT3xPfPjPfg5kvwFTx1I=;
        b=kY8bKY6bS4YHEtLjd4q5fID4M91dp+C3j4MzU4kI85+4fOJZDt9Uh97h/oU0qRWxcP
         rj0RsEAuEau8RPuyDjLQfKdpIQwuvuOMFIsnzAGcQJe7Giz/rWYViAbkVAE+gF6kbRzj
         nuzqXDMmJjNaR71IDvkvs7Vgd0jPzWgsCx+8O3hEosGm/4a8BH8wFy5W77v+dVWRR4lZ
         dHbToRLpq/CRLgQQfN3Rb8Ae0e/HSxPr4M3nb9ATFt0neA3HCcphc+xc1kadbS5IsSpz
         vSSKY0cjRGmzD/MK7Ot6FfqnZrKrMrwJmv8pbAixAeTtPfzqdfFjZaitPNd5sYzNhZDA
         smtA==
X-Forwarded-Encrypted: i=1; AKwUvBy2m7A0IHvo3Qdbgxg9c0IKUUJCZM8IcT3vFbdChFlKSw+GV5BmqUbRrZNWsr9vSko48vn0Fww=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVw9ctcbUymjBm0nCnk8YuFsfIPVSW/FCXUwRiuV54475DLdKk
	DcQYn7/0b9rtM6Fs4WE+/7y8uRsJiVRdQmrdDccQt5zQUX1ns779q7j+s/3KI1TZEpY=
X-Gm-Gg: AYBFou0/qiBNSMV7/nk7MzuUi71V+ddoAaI1/zzFUZ2n+bKkvs2KMcms69ve/4Ldi+g
	iYkTbxJGMxaMmxI4O+7ri5TSU9I6gzt0f+OXp5kYiw+Rnr1PGHhd1Fgj+rhGB+0z2yqkQnhoHUf
	EHOIPCKOX7Uwb8OfP21dl12mZ/2NsY9Tg/tZSbQsBwdK0BHCF2peIcA1ISuFr4Q9x9SxjZJsauK
	DwG0gxlJRpi1iQPLEaztzxPjKfo3JMAQqQ7EVL7h/jcoUvCkXwqYWzfrLpQFMDB0l0TyWjVx2+b
	8jmusCsmWx3QSdboxOJQw6dor/GrkYhLnoNVvqb6T7RLejALJ8Ekg42V2iKxIXFY+T5/kbOt4eO
	2BlIV4UtWTAgfQsey7oVeQr5h7Pjm0t0t6u5QDX7hCqGAAQ5LdEqsZhP8XUbGSSjUK5nqiONy+c
	ktERd24NYc+6AfsYQgcNdOFBWg4ykfI0QlzGE2grZcNTqd0u19A3hb0ssyp+lLX8Y2LAeaPfMkw
	YG+gMhdBu6mYPxwcQANkkTuHM75J7Zcmbn9b+QxEnCone+xGFKKm8C3itDWn8KGjD7XxgRZ9y7Y
	7sT88L+91pi7nCcZEzqVU0HQB7txgOkTbdZ671pLrDNwJPny6QHNqaYr
X-Received: by 2002:a05:6808:4f24:b0:4bc:be93:3506 with SMTP id 5614622812f47-50c415e0b76mr18984605b6e.3.1792119402912;
        Thu, 15 Oct 2026 19:56:42 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388c16d862sm537575b6e.9.2026.10.15.19.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:56:42 -0700 (PDT)
Date: Thu, 15 Oct 2026 19:56:38 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: continue past nonmatching huge PMDs
Message-ID: <atGSZkBHtsnJ4k1A@com-75606>
References: <20261016011549.61146-1-kylebot@openai.com>
 <20261015192020.5336a49bc516219e8254dfdf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015192020.5336a49bc516219e8254dfdf@linux-foundation.org>

On Thu, Oct 15, 2026 at 07:20:20PM -0700, Andrew Morton wrote:
> On Thu, 15 Oct 2026 18:15:49 -0700 Kyle Zeng <kylebot@openai.com> wrote:
> 
> > A PTE-mapped large folio can straddle PMD boundaries after an unaligned
> > mremap().  If the first part is discarded and replaced with an unrelated
> > huge PMD, page_vma_mapped_walk() stops instead of looking for the rest
> > of the folio in subsequent PMDs.
> > 
> > This also affects migration entries.  A walk that stops at an unrelated
> > huge PMD can leave migration PTEs behind when migration or an anonymous
> > folio split restores the mappings.  Those entries do not hold mapping
> > references and can outlive the source folio.
> > 
> > Skip the current PMD rather than ending the walk on a flag or PFN
> > mismatch.  Do the same if the PMD became nonpresent before the locked
> > recheck.  Release the PMD lock, clear the per-PMD state and advance with
> > step_forward(), so the existing range limit controls termination.
> > This covers present, migration and device-private huge PMDs while
> > preserving the matching-PMD and split-to-PTE paths.
> 
> As always, when fixing a bug please describe the worst-case
> userspace-visible effects of the bug.
> 
> I asked $LLM and was told
> 
> : The worst credible effects are permanent application hangs, kernel
> : crashes, and potentially system-wide denial of service.  Stale
> : migration entries can refer to freed and reused physical pages, causing
> : page faults to access unrelated folio metadata.  Memory corruption is
> : possible but unproven; cross-process information disclosure has not
> : been established.
> 
> But you have an LLM too!  So please never again send a bugfix without
> this info.
> 
> Also please explain whether there's a reproducer and if so, at least
> describe it and confirm the before-and-after results.
> 
> Thanks.
> 

Hi Andrew,

This issue can lead to memory corruption and I have a reproducer for it.
I can update the description and send in a v2 if you think it is proper.

Best,
Kyle
