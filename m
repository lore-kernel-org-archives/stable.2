Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D88448381
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043552; cv=none; b=ZpgnA9E7SZbRETQbceCVwxU33rym6LJeJ/nenOZ6L1GRL+8GZq7ZJLXpayz5JpGIWJJhApOFMcjl6QlC9CqQrG96GYlzXz6C9TX4SAP1C6iPmGsmlNi0iNRGHRPXVvn07lnejzZH217v4qqhswrDSw06diBeGhLAzlmCHd9bM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043552; c=relaxed/simple;
	bh=2p32/JOiOUGkzMruOJtrpMcYlWH5TB77HdwhMlQYP5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C21I22Ay3PTE6AnJtm0rrUlrKptrrNpAuW+vbKF2vw2aLdRzvRlrSUiIRpP1zHStOTxbQ9Tvy9yDOvCAbD5vIs9OVB88yXFj6lFL5QzJUOc++GPKq/59TZKn8Ooa4XAVfXCNZI70ZxcieiBdGFLkDk7Vs5qiDKte0nFKfhJ0zRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcCVT0kz; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcCVT0kz"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb61bbeb25so638069a34.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784043549; x=1784648349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2jZPg8BmRJ0mbFQa7ElFHkaNBrmZCQEMsa0xC0hHN8=;
        b=GcCVT0kzYiQOrqrtVMyNzTe9FRn8eXNMmPigxErccptVbBohoP8WZt01cd+GmEbGfR
         nN2RvqBjYhkRRnN9tf/mY7dGgh6l4GwGiQc5d4l32id3DgdJKPc9h9YZQLGajjGrK4GT
         ONZTRGpUPU63ow4/VmXijus1pXAZYjNQF67s1QllfPfzIH+XGf/Oir5OCuHvBxFLSYE8
         eIaDggUt6bz0Ujt4XDi+AdOT+koNePhMaMnNGUuLwWol41LltE1haqQx2OJaPeOaqjCf
         g6hrgZNo7rSta4LpL0ePACQnQA4lJFD80DA5WJkxWkeEitcJHXOHRH6rVMZwpK2tiGlD
         9+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043549; x=1784648349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h2jZPg8BmRJ0mbFQa7ElFHkaNBrmZCQEMsa0xC0hHN8=;
        b=H/8hpkL125m7ESNU7gxYFWmKu7ayIf96xZmhyqBY3nRRdVO2aqAWZvEzqQNMY5oYvG
         OP3ZBMFGq7Ba6OtP7xbn7bV8pvu98TabVJlkQX/t2r/FHKN6dwRyJSw2Pkknf8LuEHoJ
         5nRhWiyKnvXipYMYXRhTPVZcfeiFurIralbJEhhOaWtqA99zR6BPOIQaYTEsJ9/3KEj5
         unPOLdVCc6JVCpFfevFNZ0giOTq/ooOeuA7Mw4Vxt8uLbfQ2zey4o/n3KKASDBhgaZmv
         2jcGnqUNSYRhZjT2gumJvZDsUJ6O7sBzQuWqroJI1o9c02+EpiOJtMLAMqbJdUExcVmL
         UqTg==
X-Forwarded-Encrypted: i=1; AFNElJ+1DKjnheQ3Ms4fFdXRTJmU0tjztZ2otAsFBCBo7L9UC2+Q5GU5Xb/wU03DGenomb89jmco/A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGwunGtY+cb1F2xZXcoUY0FJm7ycMjVdwAaElnNBMNJfcWF68
	MEBOsiO/B4MAoXaCfNvMrczCyGw9RmitkMHr7UobOVL89X9jb9mpa9/v
X-Gm-Gg: AfdE7cnDvLZg8zOx0yyv2yjRbFhp1Oo8NuFFDu2WOqO35XLY+z+c9ytxW7tWRLk4PNq
	NVOJNwhOcWB78CNO4MXvBupi8I1ObpW9OgXx9OAc5kWzI1pbC1AlRRL0Qp2SwixiRoKEm3lb0Jw
	Ie9YqmGo6VHb1xFUV9HXY4eURd9Ek6a7ELaz6RNq7Fz/Bytshf+kzZVaIxnHib6u/pIWnTWPbl6
	Vb8YPeqBS2enHbnvIa6an7pOlLs5eP+46Qy6gKOHfzfJm8b5n2XoJ4qWf2zw9TOfHz1ufg0TZgX
	OTyB5gE51PONw9HG63EfmbLzPCGDlmf3k+fByWtYsOBCciKVR6GXJCY6ZrkQaiGTrIQWUBTQA8j
	ehGguV+7uf3dViASWWE1ItXmp5orogLfeN3Y2mD8EnjbBCtEfk7qxjt6qQmpJ2VcKfDGPEBTKwL
	N83ION3ywxtXxFg47sVIEpI4rp/qODbnzwaLlCEzHdZBg=
X-Received: by 2002:a05:6830:6ae6:b0:7e6:e385:4c1e with SMTP id 46e09a7af769-7ec096027c1mr8121305a34.4.1784043549120;
        Tue, 14 Jul 2026 08:39:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f2b86sm15347657a34.26.2026.07.14.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:39:08 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Wupeng Ma <mawupeng1@huawei.com>,
	fvdl@google.com,
	rientjes@google.com,
	jthoughton@google.com,
	vannapurve@google.com,
	erdemaktas@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	lance.yang@linux.dev
Subject: Re: [PATCH v2 2/5] mm: hugetlb: Fix subpool usage leak on allocation failure
Date: Tue, 14 Jul 2026 08:39:06 -0700
Message-ID: <20260714153906.772019-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEvNRgGN0HSJ2iLSDD2haSKOxifa-uhkO9Hwossh0+Q_d9fzOw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 9 Jul 2026 15:15:50 -0700 Ackerley Tng <ackerleytng@google.com> wrote:

> Ackerley Tng <ackerleytng@google.com> writes:
> 
> > Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> >
> >> Hi Ackerley,
> >>
> >> Thank you for this series. I really wanted to work on hugeTLB accounting
> >> fixes but never got the time to get to it. I'm very grateful that you
> >> are taking a look!!
> >>
> >>> From: Ackerley Tng <ackerleytng@google.com>
> >>>
> >>> When alloc_hugetlb_folio() fails early (e.g. buddy allocation failure or
> >>> hugetlb cgroup charging failure) and gbl_chg == 1 (meaning a reservation
> >>> was not used, but a global page was allocated instead), the subpool page
> >>> acquired via hugepage_subpool_get_pages() must still be returned.
> >>>
> >>> Currently, the error path out_subpool_put: only calls
> >>> hugepage_subpool_put_pages() if !gbl_chg is true. If gbl_chg is 1, it
> >>> skips it, permanently leaking the subpool's used_hpages counter.
> >>>
> >>> With the earlier patch to always track used_hpages in the subpool, always
> >>> call hugepage_subpool_put_pages() if map_chg is true to consistently
> >>> restore the page to the subpool. Only call hugetlb_acct_memory() to adjust
> >>> global reservations if gbl_chg == 0 since gbl_chg == 0 indicates a
> >>> subpool (and global) reservation was used.
> >>
> >> So I think that I've seen that this part of the accounting specifically
> >> is a bit suspicious. There have been two attempts in the past to fix
> >> this area [1] [2]. I think functionally they are quite similar to this
> >> fix, they just open-code the contents of the put_pages function inside
> >> the condition. I've Cc-ed the authors of those two patches in case
> >> they wanted to chime in.
> >>
> >
> > Thanks for connecting us! I didn't realize this was already being worked
> > on. Also adding Lance, who commented at [3].
> >
> >> I reference these fixes because I think they handle the minimum
> >> subpage case a bit differently. To be honest, I recall reading those
> >> fixes a while back and getting a bit confused on what exactly happens
> >> when the page is absorbed to fulfill the minimum size...
> >>
> >> It does seem like Sashiko also notes this as a possible concern.
> >> WDYT? Does your reproducer for this issue also work when a minimum
> >> size is set (let's say, to 1?)
> >>
> >
> > Let me look into this more!
> >

Hi Ackerley, sorry that the reply took a while : -(

> I was looking at Sashiko's comment [4] and Sashiko is right that there
> could be a race. Specifically, at the time of
> hugepage_subpool_get_page(), I might be using a reservation, hence
> returning 1 (thread A), but at the time of hugepage_subpool_put_page(),
> some other thread (B) might already have restored a reservation to the
> subpool.
> 
> With used_hpages tracking within the subpool, we can rely on the return value of
> hugepage_subpool_put_page():
> 
> + Return 1: Reservation should be returned elsewhere (pool has enough pages to
>   satisfy minimum, or doesn't track minimums)
> + Return 0: Reservation does not need to be returned elsewhere
> 
> But calling hugepage_subpool_put_pages(1) doesn't say anything about whether the
> 1 (in this case, 1 doesn't always represent a page, since specifically on the
> error cases, the page wasn't allocated) consumed a reservation or not.
> 
> + gbl_chg == 0 means a reservation was used, and
> + gbl_chg == 1 means a reservation *should be used*, but
> + gbl_chg == 1 does not necessarily mean a reservation should be used, since
>   h->resv_huge_pages may not have been decremented yet. (See goto
>   out_subpool_put and goto out_uncharge_cgroup_reservation in
>   alloc_hugetlb_folio())

Yeah... this kind of tripped me up.

> So, we need to track if h->resv_huge_pages-- happened (with some local variable
> like reservation_consumed)
> 
> | reservation_consumed | hugepage_subpool_put_pages() return value |
> h->resv_huge_pages++ |
> |----------------------|-------------------------------------------|----------------------|
> | 1                    | 1                                         |
> Yes                  |
> | 1                    | 0                                         |
> No                   |
> | 0                    | 1                                         |
> No                   |
> | 0                    | 0                                         |
> No                   |
> 
> TLDR: replace !gbl_chg with reservation_consumed?

This seems like quite a reasonable approach. It's new information that
we can't derive from the existing flags we have.

>     <<== reservation_consumed = true
> 
> 	if (!gbl_chg) {
> 		folio_set_hugetlb_restore_reserve(folio);
> 		h->resv_huge_pages--;
>         <<== reservation_consumed = true
> 	}
> 
> 	if (map_chg) {
> 		long gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> 
> 		if (!gbl_chg)  <<== this should be reservation_consumed
> 			hugetlb_acct_memory(h, -gbl_reserve);
> 	}
> 
> I believe this depends on always tracking used_hpages in subpools, in order to
> know for sure, just based on a number (with no page information), if the page is
> supposed to use a reservation.
> 
> 
> Perhaps related: does it make sense to flipping the reservation tracking
> to instead track an "available" page count? This is basically the
> mathematical opposite of rsvd_huge_pages, as in,
> 
>   available_pages = free_huge_pages - resv_huge_pages
> 
> This way, there's no need to synchronize the number of reserved pages in
> both the subpool and global hstate.
> 
> It's quite confusing now, that reserved_pages-- can be either "used a
> reservation" or "unreserve". If we track the opposite, available_pages--
> will definitely mean the page's availability is removed from the global
> hstate and transferred to the subpool, and allocating page doesn't
> involve updating both the subpool and hstate.

I think I like the semantic change, since it does make the code a lot
more obvious on why and where we are making the accounting changes.
One fear that I have is that this churn could introduce some new
subtle accounting errors, since we have been fixing this area for
quite some time now. Let's audit very carefully to make sure that
there are no new accounting errors that will be introduced : -)

> One downside I can think of is that creating hugepages (surplus, or
> promote/demote, or hotplug, or runtime echo 1 > nr_hugepages) would need
> to update the global hstate's available_pages count, but I imagine that
> would be less frequent than allocating huge pages?

Yup I think so. You might be more familiar with the new usecase you
are adding as part of the guest_memfd, but I have not really seen a
usecase for hugeTLB that would require userspace to do many hugeTLB
allocations (that THP wouldn't be able to serve). Having this accuracy
seems to be much more important than the rare contention we will see.

Thanks again for the fixes and ideas Ackerley! Looking forward to your
new approach : -)
Joshua

> >>
> >> [...snip...]
> >>
> >>
> >> [1] https://lore.kernel.org/linux-mm/20260428113037.88766-2-enderaoelyther@gmail.com/
> >> [2] https://lore.kernel.org/linux-mm/20260515202902.461539-1-devnexen@gmail.com/
> > [3] https://lore.kernel.org/linux-mm/20260428113059.79001-1-lance.yang@linux.dev/
> [4] https://sashiko.dev/#/patchset/20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b%40google.com?part=2,
