Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ED82E2EEE
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209630; cv=pass; b=my9JWQ8D3cQBBe+rUvkxAos3aS2SA/zrn2dnPUvHbvWwy+UCcp//zM2TqT6p98uUZ5uQ5++Y/3HSYl2K2mNPK71Bq53KIcLFhrjUcqs5V81oucXIHgdL3TDlXj2WSFN12uAhURELr03sHBQwMqvSwX4WqDDb+OFEUltgXTEQHEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209630; c=relaxed/simple;
	bh=qCgyLB7my1vWRWw/muT+Op3J5Znv5fE9KgUG5d0QKl8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZl4wryOC8NAk9tFYQ1wASbr27BW9L7eUbI3c/LOiVIbtIXI2EJmvxJQ8YLifNHt1FgNIBZCER53jASESOfLDysvMiJJnFFW9zX7JGBOWWp7OBmIpGWBsuh/gRzIWvmDPPV1ZCE/zIHBdsSsH7sEHgsUBB7oT7bLDtGiNb9GQ0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyLu8JvZ; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyLu8JvZ"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91059280d58so10269366d6.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 17:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790209627; cv=none;
        d=google.com; s=arc-20260327;
        b=QAWZy/CrYPZkur/9vo5pFrrp8afZGpjpq/aTzgAI5eeRztvOFOkzSY0AAjFCQiNi4E
         +uNiWVI0RShXlq91J9nSCVikqQInRQpesmDjJcB5CKsKJ7lDOgmXMQBwhdKWIAqqHE/0
         GRm5BYJpTE+dA13sOLwoAp8YiSVvgFXyJ8ndBFd91/VKLpaLFhYj1zd1ECMXcm1CPrRI
         TW8MEkgF+aFKZy2yxhEs88etjWzm7p500l6ojszlbj8Or2J+8IQpCCmhEv9cTkQidYg4
         PYwAWzY5HCUen7DKDGwRx041h/o9kvb0Y3cxd5lZbeuxvTWp4ryZEZ+Q+GHGoftQDVAG
         QRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=r6WrRa8X4LwIKolmxRxI8EL2z5U2C2576pcH4SsNYg8=;
        fh=qjak6jdQQFhQoaXzKTSCq7ufrJix3Zs8zExiH+3Lmxk=;
        b=fW457Lg5fF2MHXY38G9eD9QOm+bmOmHU6pomOzWbhMm5G5be5iTOdXUEl6T7jQMvUn
         OPSA7yomi1KKmi5YGOdLXroTq4efA/g43KwBgpOVYnvMK0yxwVL7k6DR59uKoBZYInUg
         DEBgYCvu+zW7qjUhyjxvEq96YWE07guVtTut6wmUdbt/w2nulln8dxpB+v1qgRedg2Bn
         cPCpBg8Q4oUBAy/f2vtBdRML7uOfsjLDPhuVpcr/F+0jx87FOo9S4QsOmkODOmxACl6s
         GHlKsK4qYFNXZAMZDBhIkuYRGWgfLgK+pieBHIdHmY3naYExaOGzusbfXZDV6LXQZZHV
         8bUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209627; x=1790814427; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6WrRa8X4LwIKolmxRxI8EL2z5U2C2576pcH4SsNYg8=;
        b=pyLu8JvZJ9jhhMbt6scQm2X6o58uSSsDGt9P3yNHoQ2jBjctwQyzHuRzHXm5IEBkcu
         vZYc7WBJ/lFJpQBYy86h1oBS1CGnbjhJrXUgiJWj1JwFPO0I5CsnwspooCXzq6FlRcaO
         PTxhVm490rdedLgJzTUeRwbUS242lAuHZEjWyWI+EH89abnHgU1z9AiUfKR7gyeuUHmx
         Bjrkfg7LkQALX9DlRlcXijhnh8qg9rO/wplp7jy6wSDH950MsBF09uHtHcg3Wm4XSZNP
         kxozQDrh1oAPhLApIQv1AIZZEj9PUc1gOxFeaU7vAw/lJj0VqAEWTneS1acRafGwCQTF
         eXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209627; x=1790814427;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6WrRa8X4LwIKolmxRxI8EL2z5U2C2576pcH4SsNYg8=;
        b=oivVEWLOVFvNGQ+dawiGh/YnHNDw6Gb9pTa92Xdb+5ziY24N+YC4h7eo6QWBpBa1Vq
         3/58Gv13ggbE6jlvQxv6uLgojAwPNjaHNCBvnPt2h4De5llVsGSLXSKKzO2GZtHhMQpJ
         vpLVhzzXKAu7A4lMsCOPi8Gcughgfm/qkg3pCBUE5J2+PyhACL1iOQYxMBYEC0joWLSK
         dMvy7H2WefRLjh+f/nSXm+ux8RfbRN4FNjsEXZOVzG59wovMhrS1hgWaDPOh09qhGW/n
         9KlkLdIzvdQ6XJuPGMI9+L0i39JmyGM8xd2iV9y8q2W5nKCy7q6+c3pZTbYPbD+DXqzD
         Lsxg==
X-Forwarded-Encrypted: i=1; AKwUvByjyRuVblyvvcQIHyepikP626eGyAM9xPx357Tnm0gcw553RWxB0b3js0DlFTqoZR3juL1vFkU=@vger.kernel.org
X-Gm-Message-State: AFuF++k+qeGqScCm4HGO5P1r9XNH2qwaYto+FwOrgpf69vu6rX79GsPs
	3jJq3wWHmm/kQAdzNO+1ANrMBV3zWEOfDt6EWJCP3bwWai8ErGLs393HEN4HFxAmKrjOOlSb5iO
	uL8OhmYe4QhgZNqiYR6uwLsDlXDSiExF+nqWPl4lj
X-Gm-Gg: AYBFou09hLOHRFfMECegwoGzgWnI/Tiwkqkj6ABmAW8dQS+ghVXbriHa+OPPGM3vKQo
	28CzKE0fEM19atNBAl9kktHHt1ReNaxj3jH6ziF2lpyUTZa1mb5AoP0OFYoLZyR7D3a2TYRLqK5
	nGAueM5qbpIjxCFYa/lvs7thylBclOd4U2OVph0jjByAGLJFk5XH7l8oqGjyqtE55YbwfwMyUIo
	AXnUKZnvvbL2kayDe9KA+cPlmFUmDfoHuug5JpLlS1CqdqygUqeLOxc5XIRxjwamKyvM35FGi08
	Ip0cwTax+wHjKuaoEA4wX4Tg1USPlxTMreOlYJRkoJtJqwcuVbuWY5GvckCS2JXVjjBawJCXAod
	Go1oocg+CH20D5i3ABToRyF4MaKc1wtDC+u6MyHodmWv7gYOyF02d
X-Received: by 2002:a05:6214:4908:b0:912:5a5c:780d with SMTP id
 6a1803df08f44-91421c7b50bmr1075226d6.5.1790209626640; Wed, 23 Sep 2026
 17:27:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 17:27:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Sep 2026 17:27:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260923220912.46905-1-kmehltretter@gmail.com>
References: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
 <20260916201307.5618114cbac4af52d98aecfa@linux-foundation.org> <20260923220912.46905-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 17:27:05 -0700
X-Gm-Features: AclHuK9WI-ITD8-bQR_EogJlGkU1PbBu_FVIl6mxYc8DTRj175UHw6OErcti6u4
Message-ID: <CAEvNRgHZTYUuFBXS3sGyyjiveQOeLHuPxvud8o+R3NCCwM6Ukw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
To: Karl Mehltretter <kmehltretter@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
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

> On Wed, 16 Sep 2026 20:13:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>> So if downstream people (-stable maintainers, others) follow our
>> recommendations, some kernels will get two of these patches, other
>> kernel versions will get three and some lucky kernels might get all
>> four.  Are you confident that the patches can be split apart in this
>> fashion and still produce a good result?
>
> Two things I noticed while testing this series on v7.3-rc3 (x86_64
> QEMU, one CPU):
>

Thank you so much for testing!

> 1. It overlaps with two fixes already queued in mm.git, so I've added
>    their authors to Cc:
>
>    - 3/4 rewrites the same out_subpool_put: block as Zhao Li's
>      "mm/hugetlb: fix max-only subpool accounting on
>      alloc_hugetlb_folio failure" (mm-hotfixes-unstable), and has the
>      same Fixes: tag.

Andrew also brought this up on v2 of this series [3].

>    - 2/4 rewrites the same out_put_pages: block as Jinmeng Zhou's
>      "mm/hugetlb: fix subpool minimum reservation rollback"
>      (mm-unstable).
>

Just took a quick look, this fix doesn't address the case where there
might be another CPU that updates subpool state. In that race, the
global state will be messed up.

>    3/4 doesn't apply to mm-hotfixes-unstable, and 2/4-4/4 don't apply
>    to mm-unstable. If I read them right, the queued fixes only handle
>    mounts with size=, while 2/4 and 3/4 also cover min_size mounts, so
>    they would probably replace them.
>

Yes, this set of fixes should be a superset of what's fixed in the other
patches. My vote is to switch over to this set. Would it be okay to drop
the other fixes from mm-*unstable?

> 2. On splitting: 1/4 applies cleanly on top of both queued fixes, but
>    in my tests it made min_size-only mounts worse on its own. As far
>    as I can tell, that's because it starts tracking used_hpages on
>    those mounts, while the two error paths only release it after 2/4
>    and 3/4.
>
>    HugePages_Rsvd, expected value in parentheses. Q = the two queued
>    fixes, wrap = 18446744073709551615:
>
>                                    rc3   +Q  +1/4  +Q+1/4  +1/4..4/4
>    min_size=4M only:
>      SIGBUS faults [1], no files (2)  2    2     0      0      2
>    min_size=8M only:
>      failed mmap [2], umounted (0)    0    0     3      3      0
>    size=8M,min_size=4M:
>      SIGBUS faults [1], no files (2)  0    0     0      0      2
>    size=10M,min_size=8M:
>      failed mmap [2], umounted (0)  wrap   0  wrap      0      0
>
>    With 1/4 alone, the min_size-only mount loses its reservation, and
>    in the failed-mmap case three huge pages stay reserved after umount,
>    presumably because the subpool is never freed.
>
> So it looks to me like 1/4 shouldn't go anywhere without 2/4 and 3/4.

Thanks for testing this! IIUC from your table, 1/4 introduces
regressions.

How do we handle this, should I squash patches 1/2/3 together, or is
there some way to use the Fixes: tags to require those 3 to go together?

> I haven't tested older stable trees. With all four patches applied,
> all the cases above give the expected values, and so does the
> partial-truncate case from the 1/4 changelog (Rsvd drops to 0 after
> the truncate instead of staying at 1).
>
> I'm happy to rerun these tests on a rebased v4.
>
> [1] https://lore.kernel.org/r/20260923065714.20781-1-kmehltretter@gmail.com/
> [2] the scenario from Jinmeng's changelog:
>     https://lore.kernel.org/20260907132055.26696-1-zhoujinmeng@bytedance.com
>
> Thanks,
> Karl

[3] https://lore.kernel.org/all/CAEvNRgHbzY30n1hz2vv7BiBMMhci+NEv_ubP1LjQNmBuu6Kjgw@mail.gmail.com/
