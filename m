Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D38383306
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345309; cv=pass; b=KMPE0l3J4Z/1Me8PvXdMEoureZkolUU8bwhGFM3Eqz1a7fh5xhorNUCxxWKPm1G61G106knzN4K1ARAPyUP7poqQpN630RSSS9Gz3DI9e6zmFbIzKWg7fkQC5Ul43kY0u3HbNYmVumSqfDlGAkX6uIyd01O3v4Z5jS+sf4cZss8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345309; c=relaxed/simple;
	bh=oXioH9F6h9+N+2qMEfoEilJVYHTUF8bwnxNHh1Emalw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcnhkSjwvJvtpB3xb5cbWPivXOslVbSerjIj3uDHRCzd4UVmocNmtG3h06/u/mkjVOr3lqLdbH8mPWYVZda6GsdrQKyD+nnz36L4UpbGx/dbTY6/9MYYpwEUjFP1Pn0CrVd0TOQ/Y5c1kbJuMhcpw+oSvqAIq2kA/oMtkHQTRbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dj8xbZSL; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dj8xbZSL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so17776545ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785345299; cv=none;
        d=google.com; s=arc-20260327;
        b=qLKgK8GPREST8jo60GMZDI5RVg1OPIULpsB2877T/A2EShKzODsP+V5rezfo+Kq/EL
         qT57xunGF9PSmTkHC22I9GsiMgIyBhKSBTZlIGkse0gUiU1b6m4F4jfF/Dx0quPKddIs
         ORYE+z31JkZWe8jtg7dEfXNK2oNEAn4LiHh6TLZuJ2DwGKIj/FRCWQf5a9KPJyqPoF4r
         8jK+zlVkzL4mFrGbKzy3SJhK1IoS4DNJw3LyIVBp8dldPXt2me0BX1aJRqdAySLWTn0Q
         xKyPjTyE1l3BQqKUWE95M/35xyu20OGqmXNNX4qWyQfVItvItghbhL7Y9VvWGV/LWFYu
         qMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=as2evUZR5174x9zbmjMJ18+JiY7zmu358dRWIJklKRA=;
        fh=gAoh+nvE1R8PGMg1kAe7DuDAae3NtTbhpGkf8ysLp1E=;
        b=Xqt2FDaMoz6z++x+PgjCTgTxKbdvO+dtxFrdGULh6Rupl8tJRbUZoZrNuU1JSzdd1U
         UPvEGh0lOu0WWDj8OGB5N4HmIdJ6BVb2QZH6HUacxgkXFY12os+2TGok6S+N1QO8l7Md
         e2IV9+gTeUeuviWRzxErOBbF/EVQiz1H/AcN6vpkCZEVNszqJg1R4OofFiQp7EoT8f7r
         FxXzKvFdvmZmp2aIFfRRfGxbjZW6afJgQlx/dauku3JaF/w6Wt/mfkEk/Q+cQcT85ESk
         2aN6scvIRovbzreHounf/xp9IBxxpbupXoG5vj/n+RiX4UCZbGpOfOq/9ZfYZtbz+yH9
         K5YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785345299; x=1785950099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=as2evUZR5174x9zbmjMJ18+JiY7zmu358dRWIJklKRA=;
        b=Dj8xbZSLM+ujvjQLdY1PQF58SxhEzudI+bCBYQ37LcPfFh0K16t8wZlVyLBUCk+rNa
         AXvKQei3p5025yI59rKKxO+bHhYXxi1D+B7V0xkdGJuPcng7OaRwTmBWShr/95PGII6P
         kzHTVT0muJC/dRJsf142uMTeABCVKDXgYo8RYUAnrLdQveGhpK412rMwOafoF7xGfrx2
         IJo8TqkNAIv8icU6psp72c4mekMhbHqq9NYSgufJYgxns8UFXq22FrEobbl8aOoksreH
         MxSSlLZMC4e21+Z5MmmDlwxjjKkvNRfFXGyOMMQfUWd6i84BqSDPYwIyChEP7/Zr3GVd
         S2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345299; x=1785950099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=as2evUZR5174x9zbmjMJ18+JiY7zmu358dRWIJklKRA=;
        b=ALA7EgvuL8OmEhX/onaLm2LSjvkANZ6De4aB1XHTogOsfij7rIqkfWEgt+6ipAB+iu
         79wMQlAS9WijCmTa45LaVOj0rbFIeGPRX0hKlvbDVFZrBrrxWMTDr7xyF3LKuP3WZpKk
         +LCdHvBJzlmLBaaIojHq4x+dPksdigJpEDmnmDRhBtyWlgUUFXu5JDhB/3aJOeAzfBj+
         X5SeQEYsnmsvTLoja7G7NtMa8ShVsmI308L24pb3qAu6PtKPK2adS6UvUWvUjmKr8rLF
         uq8gwsirZLuWe4WFS0ian28wGX3vBG12QtGzzJaly5ho5xWOcMhMP+2j7gBAGjBQAom6
         FWeQ==
X-Forwarded-Encrypted: i=1; AHgh+RoniK/4LIPPoPYL0/LmJ2U7r3FRLGYwpsaRFhbnywH9ZlcH0gJM9/w5k9cd9v4amGuvL8GolsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPc3b+ED8lpN8tfeWwQCPQrL7mFCeNw7wkNyUG6CiT6e+xZkFh
	rKoIv4wtkHMeSf/JdXVwm79i9g7tEmfI2uA1/vAMSr74sk3CSG8FV0vpzw82d9rFu9h2fnzHRXB
	2PGZyJYNIQ2Ty3XffMo7Qi7L3iPxipK/LvzvmJBLd
X-Gm-Gg: AR+sD12XHpRI4bkfTw1Bz67vJ09F5qmlwA6EAZbn6fAzIi4qi4sUv3Rr1PJDfRVrMBz
	uURfJvn4oi4GrCA1NgJyPN+QX+yOreUVABIJpH92HfBjH7Ce2SS1IeWQVCtRTKqcXWK/94rqpFy
	uXdpToWbRSEi4fNSu1W9vSz1kikpek2t25TOdMpAVg/UjYiPOaMUJZhUQ8/4GgYPQNxpfvraa5B
	i+XO/0WuuHq6BhATArp8+KIbIre5kK1zycQHgpqx0AlONYcYKOvNFNwKpl24KSYxDxdsQBNqI0D
	98+RFIbJQ7tAsblg6fQFqfzR49ihePLqpVS+FEstfPzVqIYNSzzvJOtgC1l0ilv0Lme2VWLnca8
	xaVOTQcZA5L6u/p0tqQlcSlyNN2jrxO4O+Oo=
X-Received: by 2002:a05:6a21:648e:b0:3c4:302e:803c with SMTP id
 adf61e73a8af0-3c8ba61ad2emr9540205637.61.1785345298564; Wed, 29 Jul 2026
 10:14:58 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 10:14:57 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 29 Jul 2026 10:14:57 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260722-hugetlb-alloc-failure-fixes-v4-1-88e8b81970dc@google.com>
References: <20260722-hugetlb-alloc-failure-fixes-v4-0-88e8b81970dc@google.com>
 <20260722-hugetlb-alloc-failure-fixes-v4-1-88e8b81970dc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 10:14:57 -0700
X-Gm-Features: AUfX_mx4FC7g70bp9YMT6qRgtu_ojTY-UB_ArAnlZOfAQDe4XFWSw92oMszySWI
Message-ID: <CAEvNRgGPS7irKKq-TMjuhEK-xjbEvbxJn+X4nM6Qw95GKHbU3A@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] mm: hugetlb: Track used_hpages when
 getting/putting pages from subpool
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	Wupeng Ma <mawupeng1@huawei.com>, fvdl@google.com, rientjes@google.com, 
	jthoughton@google.com, Mike Kravetz <mike.kravetz@oracle.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hongxiang Lou <louhongxiang@huawei.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc: vannapurve@google.com, erdemaktas@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Ackerley Tng <ackerleytng@google.com>
>
> hugepage_subpool_put_pages() currently has two distinct responsibilities
> that conflict:
>
> 1. When size is specified for the mount, max_hpages !=3D -1: Keep track o=
f
>    total active pages (allocated + reserved) and decrement this count
>    (used_hpages) when a page is freed or allocation fails.
> 2. When min_size is specified for the mount, min_hpages !=3D -1: Ensure w=
e
>    don't drop below the guaranteed minimum, and restore a reservation
>    (rsv_hpages) if we do.
>
> This causes trouble because when allocation fails (refer to
> alloc_hugetlb_folio()) if gbl_chg =3D 1 (i.e. no subpool reservation was
> taken):
>
> + To keep used_hpages consistent, HugeTLB needs to call
>   hugepage_subpool_put_pages() to restore undo used_hpages being
>   incremented
> + But can't call hugepage_subpool_put_pages() if no reservation was
>   consumed.
>
> One option would be to conditionally do subpool tracking updates outside =
of
> the hugepage_subpool_put_pages() function, but that would spread logic al=
l
> over.
>
> Instead, always track used_hpages, regardless of whether a max_size was
> requested for the mount, so that the subpool always knows how many pages
> were allocated through it. Every page allocated through the subpool
> increments used_hpages, regardless of whether a reservation was taken fro=
m
> it.
>
> Conceptually, now, every allocation involving a subpool uses a page from
> the subpool, which must be returned to the subpool. Every page taken from
> the subpool tries to use a subpool reservation. Restoring a page to the
> subpool reservations only if the page was taken from subpool
> reservations. (If used_hpages >=3D min_hpages, the page must have not hav=
e
> been taken from the reservations.)
>
> Always tracking used_hpages provides the subpool with information of both
> used and reserved counts to make the correct decision for both max_size a=
nd
> min_size correctly.
>
> With used_hpages always tracked,
>
> + subpool_is_free() can be simplified, such that the subpool can be
>   declared free if there are no more pages in use.
> + open-coding in hugetlb_reserve_pages() can be removed.
>
> Also update the
>
> + Documentation for used_hpages in the subpool struct, since it no longer
>   matters whether the used pages count against the maximum.
> + Docstring for hugepage_subpool_{get,put}_pages
> + Documentation to use active voice, and remove some details in favor of
>   having details documented in the docstring
>
> Also update statfs reporting. Previously, if max_hpages is negative,
> used_hpages is static at 0, so returning max_hpages - used_hpages returns
> -1 and is always correct. Now, if the subpool doesn't have a maximum
> requested size, indicate no limit for free pages (-1). If it does have a
> maximum size, report the difference between the requested size and the
> number of used pages. This difference is always positive, because if the
> mount does have a maximum size, hugepage_subpool_get_pages() ensures that
> the subpool usage never exceeds the maximum.
>
> This fixes a bug in hugetlb_unreserve_pages(), where pages are returned t=
o
> the subpool regardless of whether it consumed a reservation. The
> corresponding bug in the failure handling path of alloc_hugetlb_folio() w=
as
> fixed in a833a693a490e.
>
> Fixes: 1c5ecae3a93fa ("hugetlbfs: add minimum size accounting to subpools=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  Documentation/mm/hugetlbfs_reserv.rst              |  17 +--
>  .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |  11 +-
>  fs/hugetlbfs/inode.c                               |   8 +-
>  include/linux/hugetlb.h                            |   4 +-
>  mm/hugetlb.c                                       | 118 +++++++++++----=
------
>  5 files changed, 75 insertions(+), 83 deletions(-)
>
> diff --git a/Documentation/mm/hugetlbfs_reserv.rst b/Documentation/mm/hug=
etlbfs_reserv.rst
> index a49115db18c76..d244583fdcbc3 100644
> --- a/Documentation/mm/hugetlbfs_reserv.rst
> +++ b/Documentation/mm/hugetlbfs_reserv.rst
> @@ -314,21 +314,8 @@ huge pages.  If they can not be reserved, the mount =
fails.
>  The routines hugepage_subpool_get/put_pages() are called when pages are
>  obtained from or released back to a subpool.  They perform all subpool
>  accounting, and track any reservations associated with the subpool.
> -hugepage_subpool_get/put_pages are passed the number of huge pages by wh=
ich
> -to adjust the subpool 'used page' count (down for get, up for put).  Nor=
mally,
> -they return the same value that was passed or an error if not enough pag=
es
> -exist in the subpool.
> -
> -However, if reserves are associated with the subpool a return value less
> -than the passed value may be returned.  This return value indicates the
> -number of additional global pool adjustments which must be made.  For ex=
ample,
> -suppose a subpool contains 3 reserved huge pages and someone asks for 5.
> -The 3 reserved pages associated with the subpool can be used to satisfy =
part
> -of the request.  But, 2 pages must be obtained from the global pools.  T=
o
> -relay this information to the caller, the value 2 is returned.  The call=
er
> -is then responsible for attempting to obtain the additional two pages fr=
om
> -the global pools.
> -
> +hugepage_subpool_get/put_pages() use the number of huge pages passed to =
adjust
> +the subpool 'used page' count.
>
>  COW and Reservations
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst b/D=
ocumentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
> index 20947f8bd0654..ae1f1f31477fc 100644
> --- a/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
> +++ b/Documentation/translations/zh_CN/mm/hugetlbfs_reserv.rst
> @@ -246,15 +246,8 @@ hugepage_subpool=E7=9A=84min_hpages=E5=AD=97=E6=AE=
=B5=E4=B8=AD=E8=A2=AB=E8=B7=9F=E8=B8=AA=E3=80=82=E5=9C=A8=E6=8C=82=E8=BD=BD=
=E6=97=B6=EF=BC=8Chugetlb_acct_me
>  =E8=A2=AB=E8=B0=83=E7=94=A8=E4=BB=A5=E9=A2=84=E7=95=99=E6=8C=87=E5=AE=9A=
=E6=95=B0=E9=87=8F=E7=9A=84=E5=B7=A8=E9=A1=B5=E3=80=82=E5=A6=82=E6=9E=9C=E5=
=AE=83=E4=BB=AC=E4=B8=8D=E8=83=BD=E8=A2=AB=E9=A2=84=E7=95=99=EF=BC=8C=E6=8C=
=82=E8=BD=BD=E5=B0=B1=E4=BC=9A=E5=A4=B1=E8=B4=A5=E3=80=82
>
>  =E5=BD=93=E4=BB=8E=E5=AD=90=E6=B1=A0=E4=B8=AD=E8=8E=B7=E5=8F=96=E6=88=96=
=E9=87=8A=E6=94=BE=E9=A1=B5=E9=9D=A2=E6=97=B6=EF=BC=8C=E4=BC=9A=E8=B0=83=E7=
=94=A8hugepage_subpool_get/put_pages()=E5=87=BD=E6=95=B0=E3=80=82
> -hugepage_subpool_get/put_pages=E8=A2=AB=E4=BC=A0=E9=80=92=E7=BB=99=E5=B7=
=A8=E9=A1=B5=E6=95=B0=E9=87=8F=EF=BC=8C=E4=BB=A5=E6=AD=A4=E6=9D=A5=E8=B0=83=
=E6=95=B4=E5=AD=90=E6=B1=A0=E7=9A=84 =E2=80=9C=E5=B7=B2=E7=94=A8=E9=A1=B5=
=E9=9D=A2=E2=80=9D =E8=AE=A1=E6=95=B0
> -=EF=BC=88get=E4=B8=BA=E4=B8=8B=E9=99=8D=EF=BC=8Cput=E4=B8=BA=E4=B8=8A=E5=
=8D=87=EF=BC=89=E3=80=82=E9=80=9A=E5=B8=B8=E6=83=85=E5=86=B5=E4=B8=8B=EF=BC=
=8C=E5=A6=82=E6=9E=9C=E5=AD=90=E6=B1=A0=E4=B8=AD=E6=B2=A1=E6=9C=89=E8=B6=B3=
=E5=A4=9F=E7=9A=84=E9=A1=B5=E9=9D=A2=EF=BC=8C=E5=AE=83=E4=BB=AC=E4=BC=9A=E8=
=BF=94=E5=9B=9E=E4=B8=8E=E4=BC=A0=E9=80=92=E7=9A=84=E7=9B=B8=E5=90=8C=E7=9A=
=84=E5=80=BC=E6=88=96
> -=E4=B8=80=E4=B8=AA=E9=94=99=E8=AF=AF=E3=80=82
> -
> -=E7=84=B6=E8=80=8C=EF=BC=8C=E5=A6=82=E6=9E=9C=E9=A2=84=E7=95=99=E4=B8=8E=
=E5=AD=90=E6=B1=A0=E7=9B=B8=E5=85=B3=E8=81=94=EF=BC=8C=E5=8F=AF=E8=83=BD=E4=
=BC=9A=E8=BF=94=E5=9B=9E=E4=B8=80=E4=B8=AA=E5=B0=8F=E4=BA=8E=E4=BC=A0=E9=80=
=92=E5=80=BC=E7=9A=84=E8=BF=94=E5=9B=9E=E5=80=BC=E3=80=82=E8=BF=99=E4=B8=AA=
=E8=BF=94=E5=9B=9E=E5=80=BC=E8=A1=A8=E7=A4=BA=E5=BF=85=E9=A1=BB=E8=BF=9B=E8=
=A1=8C=E7=9A=84=E9=A2=9D=E5=A4=96=E5=85=A8=E5=B1=80
> -=E6=B1=A0=E8=B0=83=E6=95=B4=E7=9A=84=E6=95=B0=E9=87=8F=E3=80=82=E4=BE=8B=
=E5=A6=82=EF=BC=8C=E5=81=87=E8=AE=BE=E4=B8=80=E4=B8=AA=E5=AD=90=E6=B1=A0=E5=
=8C=85=E5=90=AB3=E4=B8=AA=E9=A2=84=E7=95=99=E7=9A=84=E5=B7=A8=E9=A1=B5=EF=
=BC=8C=E6=9C=89=E4=BA=BA=E8=A6=81=E6=B1=825=E4=B8=AA=E3=80=82=E4=B8=8E=E5=
=AD=90=E6=B1=A0=E7=9B=B8=E5=85=B3=E7=9A=843=E4=B8=AA=E9=A2=84=E7=95=99=E9=
=A1=B5=E5=8F=AF=E4=BB=A5=E7=94=A8=E6=9D=A5
> -=E6=BB=A1=E8=B6=B3=E9=83=A8=E5=88=86=E8=AF=B7=E6=B1=82=E3=80=82=E4=BD=86=
=E6=98=AF=EF=BC=8C=E5=BF=85=E9=A1=BB=E4=BB=8E=E5=85=A8=E5=B1=80=E6=B1=A0=E4=
=B8=AD=E8=8E=B7=E5=BE=972=E4=B8=AA=E9=A1=B5=E9=9D=A2=E3=80=82=E4=B8=BA=E4=
=BA=86=E5=90=91=E8=B0=83=E7=94=A8=E8=80=85=E8=BD=AC=E8=BE=BE=E8=BF=99=E4=B8=
=80=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=B0=86=E8=BF=94=E5=9B=9E=E5=80=BC2=E3=80=
=82=E7=84=B6=E5=90=8E=EF=BC=8C=E8=B0=83=E7=94=A8
> -=E8=80=85=E8=A6=81=E8=B4=9F=E8=B4=A3=E4=BB=8E=E5=85=A8=E5=B1=80=E6=B1=A0=
=E4=B8=AD=E8=8E=B7=E5=8F=96=E5=8F=A6=E5=A4=96=E4=B8=A4=E4=B8=AA=E9=A1=B5=E9=
=9D=A2=E3=80=82
> -
> +=E5=AE=83=E4=BB=AC=E8=B4=9F=E8=B4=A3=E6=89=80=E6=9C=89=E5=AD=90=E6=B1=A0=
=E7=9A=84=E7=BB=9F=E8=AE=A1=E6=A0=B8=E7=AE=97=EF=BC=8C=E5=B9=B6=E8=B7=9F=E8=
=B8=AA=E4=B8=8E=E5=AD=90=E6=B1=A0=E7=9B=B8=E5=85=B3=E8=81=94=E7=9A=84=E9=A2=
=84=E7=95=99=E3=80=82
> +hugepage_subpool_get/put_pages()=E5=87=BD=E6=95=B0=E4=BD=BF=E7=94=A8=E4=
=BC=A0=E5=85=A5=E7=9A=84=E5=B7=A8=E9=A1=B5=E6=95=B0=E9=87=8F=E6=9D=A5=E8=B0=
=83=E6=95=B4=E5=AD=90=E6=B1=A0=E7=9A=84=E2=80=9C=E5=B7=B2=E7=94=A8=E9=A1=B5=
=E9=9D=A2=E2=80=9D=E8=AE=A1=E6=95=B0=E3=80=82
>
>  COW=E5=92=8C=E9=A2=84=E7=95=99
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 216e1a0dd0b23..26c0187340636 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1109,8 +1109,12 @@ static int hugetlbfs_statfs(struct dentry *dentry,=
 struct kstatfs *buf)
>
>  			spin_lock_irq(&sbinfo->spool->lock);
>  			buf->f_blocks =3D sbinfo->spool->max_hpages;
> -			free_pages =3D sbinfo->spool->max_hpages
> -				- sbinfo->spool->used_hpages;
> +			if (sbinfo->spool->max_hpages =3D=3D -1) {
> +				free_pages =3D -1;
> +			} else {
> +				free_pages =3D sbinfo->spool->max_hpages -
> +					     sbinfo->spool->used_hpages;
> +			}
>  			buf->f_bavail =3D buf->f_bfree =3D free_pages;
>  			spin_unlock_irq(&sbinfo->spool->lock);
>  			buf->f_files =3D sbinfo->max_inodes;
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2abaf99321e90..34b9a3e1be0fa 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -38,8 +38,8 @@ struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
>  	long max_hpages;	/* Maximum huge pages or -1 if no maximum. */
> -	long used_hpages;	/* Used count against maximum, includes */
> -				/* both allocated and reserved pages. */
> +	long used_hpages;	/* Used page count, includes both */
> +				/* allocated and reserved pages. */
>  	struct hstate *hstate;
>  	long min_hpages;	/* Minimum huge pages or -1 if no minimum. */
>  	long rsv_hpages;	/* Pages reserved against global pool to */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835e..36fa3fb3945d8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -129,12 +129,8 @@ static inline bool subpool_is_free(struct hugepage_s=
ubpool *spool)
>  {
>  	if (spool->count)
>  		return false;
> -	if (spool->max_hpages !=3D -1)
> -		return spool->used_hpages =3D=3D 0;
> -	if (spool->min_hpages !=3D -1)
> -		return spool->rsv_hpages =3D=3D spool->min_hpages;
>
> -	return true;
> +	return spool->used_hpages =3D=3D 0;
>  }
>
>  static inline void unlock_or_release_subpool(struct hugepage_subpool *sp=
ool,
> @@ -187,13 +183,18 @@ void hugepage_put_subpool(struct hugepage_subpool *=
spool)
>  	unlock_or_release_subpool(spool, flags);
>  }
>
> -/*
> - * Subpool accounting for allocating and reserving pages.
> - * Return -ENOMEM if there are not enough resources to satisfy the
> - * request.  Otherwise, return the number of pages by which the
> - * global pools must be adjusted (upward).  The returned value may
> - * only be different than the passed value (delta) in the case where
> - * a subpool minimum size must be maintained.
> +/**
> + * hugepage_subpool_get_pages - Get pages from a subpool
> + * @spool: pointer to subpool structure (may be NULL)
> + * @delta: number of pages to allocate or reserve
> + *
> + * Check and update subpool page usage counts when allocating or
> + * reserving @delta hugepages.
> + *
> + * Context: Takes spool->lock using spin_lock_irq().
> + * Return: Non-negative number of reservations that cannot be
> + *         satisfied by the subpool, or -ENOMEM if the subpool maximum
> + *         limit would be exceeded.
>   */
>  static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>  				      long delta)
> @@ -205,15 +206,14 @@ static long hugepage_subpool_get_pages(struct hugep=
age_subpool *spool,
>
>  	spin_lock_irq(&spool->lock);
>
> -	if (spool->max_hpages !=3D -1) {		/* maximum size accounting */
> -		if ((spool->used_hpages + delta) <=3D spool->max_hpages)
> -			spool->used_hpages +=3D delta;
> -		else {
> -			ret =3D -ENOMEM;
> -			goto unlock_ret;
> -		}
> +	if (spool->max_hpages !=3D -1 &&
> +	    spool->used_hpages + delta > spool->max_hpages) {
> +		ret =3D -ENOMEM;
> +		goto unlock_ret;
>  	}
>
> +	spool->used_hpages +=3D delta;
> +
>  	/* minimum size accounting */
>  	if (spool->min_hpages !=3D -1 && spool->rsv_hpages) {
>  		if (delta > spool->rsv_hpages) {
> @@ -234,11 +234,19 @@ static long hugepage_subpool_get_pages(struct hugep=
age_subpool *spool,
>  	return ret;
>  }
>
> -/*
> - * Subpool accounting for freeing and unreserving pages.
> - * Return the number of global page reservations that must be dropped.
> - * The return value may only be different than the passed value (delta)
> - * in the case where a subpool minimum size must be maintained.
> +/**
> + * hugepage_subpool_put_pages - Release pages back to a subpool
> + * @spool: pointer to subpool structure (may be NULL)
> + * @delta: number of pages to free or unreserve
> + *
> + * Check and update subpool page usage counts when freeing or
> + * unreserving @delta hugepages.
> + *
> + * Context: Takes spool->lock using spin_lock_irqsave(). May release
> + *          and free @spool if its usage count and references reach
> + *          zero.
> + * Return: Non-negative number of reservations that the subpool cannot
> + *         absorb.
>   */
>  static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
>  				       long delta)
> @@ -251,19 +259,24 @@ static long hugepage_subpool_put_pages(struct hugep=
age_subpool *spool,
>
>  	spin_lock_irqsave(&spool->lock, flags);
>
> -	if (spool->max_hpages !=3D -1)		/* maximum size accounting */
> -		spool->used_hpages -=3D delta;
> +	spool->used_hpages -=3D delta;
>
>  	 /* minimum size accounting */
>  	if (spool->min_hpages !=3D -1 && spool->used_hpages < spool->min_hpages=
) {
> -		if (spool->rsv_hpages + delta <=3D spool->min_hpages)
> +		/*
> +		 * limit is the maximum number of reservations that
> +		 * can be restored to this subpool.
> +		 */
> +		long limit =3D spool->min_hpages - spool->used_hpages;
> +
> +		if (spool->rsv_hpages + delta <=3D limit)
>  			ret =3D 0;
>  		else
> -			ret =3D spool->rsv_hpages + delta - spool->min_hpages;
> +			ret =3D spool->rsv_hpages + delta - limit;
>
>  		spool->rsv_hpages +=3D delta;
> -		if (spool->rsv_hpages > spool->min_hpages)
> -			spool->rsv_hpages =3D spool->min_hpages;
> +		if (spool->rsv_hpages > limit)
> +			spool->rsv_hpages =3D limit;
>  	}
>
>  	/*
> @@ -6542,7 +6555,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		struct vm_area_struct *vma,
>  		vma_flags_t vma_flags)
>  {
> -	long chg =3D -1, add =3D -1, spool_resv, gbl_resv;
> +	long chg =3D -1, add =3D -1, gbl_resv;
>  	struct hstate *h =3D hstate_inode(inode);
>  	struct hugepage_subpool *spool =3D subpool_inode(inode);
>  	struct resv_map *resv_map;
> @@ -6622,9 +6635,9 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * the subpool has a minimum size, there may be some global
>  	 * reservations already in place (gbl_reserve).
>  	 */
> -	gbl_reserve =3D hugepage_subpool_get_pages(spool, chg);
> -	if (gbl_reserve < 0) {
> -		err =3D gbl_reserve;
> +	gbl_resv =3D hugepage_subpool_get_pages(spool, chg);
> +	if (gbl_resv < 0) {
> +		err =3D gbl_resv;
>  		goto out_uncharge_cgroup;
>  	}
>
> @@ -6632,7 +6645,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	 * Check enough hugepages are available for the reservation.
>  	 * Hand the pages back to the subpool if there are not
>  	 */
> -	err =3D hugetlb_acct_memory(h, gbl_reserve);
> +	err =3D hugetlb_acct_memory(h, gbl_resv);
>  	if (err < 0)
>  		goto out_put_pages;
>
> @@ -6651,7 +6664,7 @@ long hugetlb_reserve_pages(struct inode *inode,
>  		add =3D region_add(resv_map, from, to, regions_needed, h, h_cg);
>
>  		if (unlikely(add < 0)) {
> -			hugetlb_acct_memory(h, -gbl_reserve);
> +			hugetlb_acct_memory(h, -gbl_resv);
>  			err =3D add;
>  			goto out_put_pages;
>  		} else if (unlikely(chg > add)) {
> @@ -6687,26 +6700,21 @@ long hugetlb_reserve_pages(struct inode *inode,
>  	}
>  	return chg;
>
> -out_put_pages:
> -	spool_resv =3D chg - gbl_reserve;
> -	if (spool_resv) {
> -		/* put sub pool's reservation back, chg - gbl_reserve */
> -		gbl_resv =3D hugepage_subpool_put_pages(spool, spool_resv);
> -		/*
> -		 * subpool's reserved pages can not be put back due to race,
> -		 * return to hstate.
> -		 */
> -		hugetlb_acct_memory(h, -gbl_resv);
> -	}
> -	/* Restore used_hpages for pages that failed global reservation */
> -	if (gbl_reserve && spool) {
> -		unsigned long flags;
> + out_put_pages:
> +	/*
> +	 * Return all that was requested from the subpool, let subpool
> +	 * tell us the new number of reservations that need to be
> +	 * returned to the global pool.
> +	 */
> +	gbl_reserve =3D hugepage_subpool_put_pages(spool, chg);
> +	/*
> +	 * There may be a difference between the number of
> +	 * reservations to consume and the number to restore now if
> +	 * there are multiple threads interacting with the subpool -
> +	 * restore the difference.
> +	 */
> +	hugetlb_acct_memory(h, gbl_resv - gbl_reserve);

Sashiko had a few comments on this patch, the following is the only one
that isn't addressed in a later patch in this same series:

  [Severity: Critical]
  Does this code leave the subpool with phantom global reservations if
  hugetlb_acct_memory() fails?

  If hugetlb_acct_memory() is called with a positive delta here (meaning th=
e
  subpool absorbed some reservations) and it returns -ENOMEM because the gl=
obal
  pool is exhausted, the return value is ignored.

  Could this artificially inflate the subpool's rsv_hpages without backing
  global pages, which would then inflate free_huge_pages out of thin air wh=
en
  the subpool is eventually destroyed?

This is true, but this is a failure path and I'm not really sure how
best to handle an error from hugetlb_acct_memory() in this case. Other
callers of hugetlb_acct_memory() don't handle failures either.


>
> -		spin_lock_irqsave(&spool->lock, flags);
> -		if (spool->max_hpages !=3D -1)
> -			spool->used_hpages -=3D gbl_reserve;
> -		unlock_or_release_subpool(spool, flags);
> -	}
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
>  					    chg * pages_per_huge_page(h), h_cg);
>
> --
> 2.55.0.229.g6434b31f56-goog
