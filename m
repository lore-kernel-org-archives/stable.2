Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BA2353A7F
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572752; cv=pass; b=uzx9HebNp1bFc3otzTYM+ZwbOESWTxdWkw+XkqYxjFvt0IFmFPkuUxasoGILLSxxHT3vbdowDbwg2kAtv1ok3JPzSgA8L3bB4/zL9rKoniMihPjHWOQWWwd4cfrov1lsobxsvxOl8RvvDEs9BQg3XmLvRvc39YU5djekF+4WGUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572752; c=relaxed/simple;
	bh=eMZ7NWgSIj9tWcw6NNo8sy+jc9H3QenfA/we/snsRR0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMmQfiBh2TnCvGxilSrYONagm8XnQFcGrnwu0RYIOGDTYRYNxkyyJ6akll4TpzXfU2IZqGPImI4XPUCHjrLyXbHXu4tSB1OJMvvBLKqhx1gUkIjACSRX7hH2A7xff4hAjpUo/Hfuqsb96n84wIdHPQcNEc6eN8zfkyTtGz5Ys50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kfjB5HEG; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kfjB5HEG"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bef17c191so234581685a.2
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790572749; cv=none;
        d=google.com; s=arc-20260327;
        b=ewuwDCFWrg+vx3iUAMVhrEvddJbQJaFN3dLyGE9N2J3STVTpQAp7ZfHKMUsuJY2HMY
         n0czgUuv5vrCEhWw0ANXlzuBn8282z86iUKHTRhbx9vUSeq6DXa/MHmQJzcVug+N9gm5
         TXveKhutBLR/dWH2K2/eeiYQ8jAx7li0cGkzdh6GXGXZO/RqpXqeiVjVlobGJggfWe93
         8jbZ/O6peZoUDv0Phe9TBH94AbymfDtYoqRXVFc3ySQ8hXg/rmkTSwCHLzU5ckBSmsAU
         jitRNQFYkfpJlI4FAyEWTxKbsWizJNkoj3M4tlIVE7joVD2zVvC5g0Xr/2DvZ6UE5quV
         C/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uhC9VdyJZAhlbxrqH3B0Xp+V5ADIoAIUT4+FDcJgkb0=;
        fh=llwnj5rM6BGxmDSH8q5jgYiKgvK1Hx23GHvEnbz5mGc=;
        b=F9d9fn/ocNksEaWm6L1SrjuLlJuCxeWcIoPDZJ928uTKcY05zN+7CktjQrYLBe+pCJ
         Lf+tjaSiqoR63TgxSVM+2bjiDlkxJEgQZMFZAvuhSHR6KHRtb2v+FGGfokYLXeR/NHyW
         0JFSThcO5fF8HH1bp2U2ydYPpF35TsO/eYH12gEqfOY6aDbSpJI5kA4AaBkqoLfgtXs3
         x5DKzcIQFL+5Le/vxHT77nvi0RR58zq6LPGbZYEZbSGaTYGJODBz4oQ6TDCmpafzsUCT
         stzEc0SaO63WYdMaCsXi1koSmvFkl2z5tRYNw4c/MUjbKMIaUZkBFiN0+gnMsNB2ee08
         KaQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790572749; x=1791177549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhC9VdyJZAhlbxrqH3B0Xp+V5ADIoAIUT4+FDcJgkb0=;
        b=kfjB5HEGm7YPH4RmeTlIXpCdy7Dc4DodlT4fgGG8w/fPkLyZQVLeE2KcdW+jsmtMWH
         DFEI+c7Z1d+yte6Iqv2M2D51TEPuJtAC2O6vLZ7CFCMd/aibGCWf8IlQcbaKnwzjmKEp
         j2KwbgGB/C5S611H7j3gomTOd9vPIK2wGGjn2pYIf5trnRqe9us2pgyRPQZUHpVp36PP
         WDQbvS8+dH5pJJi8IRP42weniDT6Qc2PwIIS4kFlKCH5e5U3XunHJA3R/Aro2FUhaMX7
         Hh/9ewKuS5nGuem4Cbs5gYJ2RC1yacx+3ggn0Tp8SJDkC5Wwy3Y4W+eGTQlVM1hR6/7K
         EqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790572749; x=1791177549;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhC9VdyJZAhlbxrqH3B0Xp+V5ADIoAIUT4+FDcJgkb0=;
        b=s8TXmHN6noVR+GfNdrJi4sRQ9jKrPHUYPveRDg+m5C/AkNbefmLZ4nuivlHCRHqUQ3
         Ss+2AbTSq04kctgaVJAOVMnJuYeTDDBAYDUaM7HU0vp72pxo8iD6xxyngd9Wg6i8cbbg
         65mVDQPz95eVe2sN0A5xJ86zmtJSXwpeIT68nypU5vhZb8lzDE8bmmY6JLbqdD3HNyLv
         FRvW9u28eEL8c6Dv/CCsEU/9+WXgF0y4Yz7EASnCYAJbMv94F4JOiSYeGjd72UzIw5p0
         QGFZXpUgY07RTioasnAB9VrN0NXb8UD3WGtWBrUiHxT/fSRzXe7LPfzc+B+GFFPta0sz
         EKIw==
X-Forwarded-Encrypted: i=1; AKwUvBzqy3IfF3N7GXLWVXgWBHXPlAyWrak7JVLwbOou45BaANIhqekeqGw5ZWz3MRAXg47w9M6/3Bg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkYhsDPOGdQ+K/Cu8HK+XQhJaEvH2fErhHMLnRpc6wepQQHySB
	TCG9pxCm+s/iJpaN5fyXmF+nciVbghctzcAbe2qJnqGm8S1h/xkJ0BO0in16esuyFPNgcsA8J7N
	292Lb0zD+2vzv5F3TlhmfILyIkVuAFA9TidxmRLN4
X-Gm-Gg: AYBFou0sthUnlmUJJ78B9VccJm9rcwnAG1ezH7m4JdpIj6WH9v1CTyN1P3mzWT/jLN9
	vBn/9bdr1Cv+V7ArkuUa/rHjWAKBaRVFrnq8ZcgbksJZHoXWWWvVvvhdJh74aWWI3WgYMOqteDj
	bWpO947K/Ph8Yan6cE+jYZ9EMLBp+o+abOi8PvGQ1ylfhcHEk5n0vXRiF/g6uS5SXyd/mCxBsLi
	XNzoETH9+b/UZ7dQEXD6fiGfEAeOS2tn066R0wVebHGRDe8TD78qPjt8uKRibjAsu6AQCe9cFBr
	tMS+8Ya+tZtZ8AI8DLF4Yi6qdUCuWzTuXoACgHa9/Dk0GFV6eCUHCPQk6I76eqpqsBfmaL8FQFC
	+aufd/xsKUQ==
X-Received: by 2002:a05:6214:2f89:b0:912:4680:c96f with SMTP id
 6a1803df08f44-9142f6c3868mr213059746d6.3.1790572748944; Sun, 27 Sep 2026
 22:19:08 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Sep 2026 22:19:08 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Sep 2026 22:19:08 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260927170426.2467-1-kmehltretter@gmail.com>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
 <20260916-hugetlb-subpool-always-track-used-v3-3-38aae9b5ccdd@google.com> <20260927170426.2467-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2026 22:19:08 -0700
X-Gm-Features: AclHuK90KfcXyQWpd0DwfKVy3z309tVx_VOzduTxOGd0bveF-6OiNV1sFaSOIFs
Message-ID: <CAEvNRgHQLifmcD1NO6cd7EVcCiQb6gJgNUo4HkFhZAvzuwMq0w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: hugetlb: Fix subpool usage leak on allocation failure
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Zhao Li <enderaoelyther@gmail.com>, Jinmeng Zhou <zhoujinmeng@bytedance.com>, 
	Alex Shi <alexs@kernel.org>, David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Michal Hocko <mhocko@kernel.org>, Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
	Yanteng Si <si.yanteng@linux.dev>, Naoya Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com, 
	jthoughton@google.com, rientjes@google.com, vannapurve@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Karl Mehltretter <kmehltretter@gmail.com> writes:

> On Wed, 16 Sep 2026 16:39:03 -0700, Ackerley Tng wrote:
>>  out_subpool_put:
>> +	if (map_chg) {
>> +		long gbl_resv_put = hugepage_subpool_put_pages(spool, 1);
>> +
>> +		hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
>>  	}
>
> I reproduced the same fallible-positive-adjustment problem in this
> calculation.
>
> The complete subpool put is locally correct, but it can expose capacity
> which another operation consumes before this call tries to restore the
> corresponding global reservation. A positive hugetlb_acct_memory() can
> then fail with -ENOMEM, and its return value is ignored.
>
> I tested the exact patch prefixes on v7.3-rc3 in x86-64 QEMU with 2 MiB
> huge pages, at both one and four vCPUs. A default-off test hook enforced
> this ordering:
>
> 1. A shared MAP_NORESERVE fault acquires one page from a four-page
>    minimum subpool while the global pool has no spare capacity.
> 2. Folio allocation fails.
> 3. Before rollback, an existing reservation is released and a competing
>    reservation consumes that newly available capacity.
> 4. The subpool put restores the local minimum state, but its required +1
>    global correction fails with -ENOMEM.
>
> Both CPU counts produced the same result:
>
>   Source state  Cleanup result  After file removal / after unmount
>   ------------  --------------  ---------------------------------
>   v7.3-rc3      old cleanup     4 / 0
>   patches 1-2   old local leak  3 / 3
>   patches 1-3   +1, -ENOMEM     3 / ULONG_MAX
>   patches 1-4   +1, -ENOMEM     3 / ULONG_MAX
>
> The expected values are 4 after file removal and 0 after unmount. Patch 3
> removes the local usage leak, but the failed positive correction replaces
> it with globally unbacked subpool reservations and the unmount underflow.
> Patch 4 does not cover this earlier allocation-failure path.
>
> As in the reservation case, the base remains balanced in this controlled
> interleaving. Patch 1 makes the path observable on the minimum-only mount,
> and patch 3 changes the local leak into globally unbacked reservations.
>
> As for 2/4, I think the subpool get must remain provisional until the
> allocation commits or aborts.
>
> A LLM agent helped me with the tests.
>
> Thanks,
> Karl

This is confusing me. Perhaps I've been reading too much LLM output from
myself and from Karl :)


== We have a path forward on top of Zhao and Jinmeng's patches

I tried to integrate Zhao [1] and Jinmeng's [2] patches into a v4 of
this series, and I have path forward for my fixes on top of Zhao and
Jinmeng's patches.

== The path forward requires some small changes to [1/4] of this series

With Zhao and Jinmeng's patches, the necessary subpool tracking is
basically done outside of hugepage_subpool_put_pages() in 2 places
(alloc_hugetlb_folio() and hugetlb_reserve_pages()).

The logic is that patch [1/4] of this series always tracks used_hpages
in the subpool, so I can update those 2 places that Zhao and Jinmeng
updated in alloc_hugetlb_folio() and hugetlb_reserve_pages() to also
always update used_hpages.

I can update those 2 places if we end up going with always tracking
used_hpages in the subpool, which I still believe is a good cleanup.

== But I found more race-related issues

I thought [2/4] and [3/4] of this series would fix all the race-related
issues, but my LLM produced a reproducer that revealed even more
race-related bugs which I don't fully understand.

== Questions for Karl

(Independent of the "Path forward for 7.3/7.4")

1. Does squashing patch [4/4] of this series into [2/4] [3/4] resolve
   any of what you found?
2. Does patch [1/4] introduce new issues, or does it just not fully fix
   all the issues? At this point I think we have so many bugs, it's more
   about fixing bugs progressively (not regressing) than finding a
   complete fix.
3. Would it be ok if you integrate your findings across your two replies
   on [2/4] and [3/4]? They're similar yet slightly different so it's
   kind of confusing. If you have reproducers, it would help to share
   them! :)

== Path forward for 7.3/7.4

Andrew, I think we should merge Zhao and Jinmeng's patches. They
separately fix different issues, not completely, but is good enough of
an improvement given this bigger-than-expected mess.

I want to continue iterating on this series but I'm a little busy over
the next few weeks (LPC) and I don't want to hold things up.

I believe the relative order between those 2 doesn't matter, but I
tested this order: Zhao then Jinmeng. I'll reply to those patches with
Tested-by tags.


Thank you everyone!
