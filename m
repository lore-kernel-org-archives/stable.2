Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795648428;
	b=tmVL7VQQvTXMMG1CP8rCfoc6YCW9d9SGBqEB6GYneFqEw08VoGPlmAMfpxIUVYZjxR6t
	 vamSG8AET3EpfIoV3MeousceN+640tJmnyTLMi3sD/RCxUhdjANKJeXDnS7gjbs+/Nrwr
	 X4s1fDwNBnnBoVUendahAA7CGpquu9u1J8o7RAG1ZPW+Zk98f9VqyrqNcBSHv2dNl5sJu
	 7svDuyn++8aSDIBX+uUF5+vZH3zYLR16y33qg+IQpf3Ssh4MATbDH/zum44y0PLTj6SqJ
	 C99cYPgxg89z/EKDKKOvsrWMndWJmoY4JEM0v45FG+ni/UBUQW4M1t1TNtgC2uMNm9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
	b=EEzQ+OsaSrANqouF+gTg2FCQdDZezlk1nNby1nXvKn6nL+RNY/0ZxUO9gnW7onKQlyrE
	 XhmszNchOQqY6jqeZ3Zb7XPY07veGIayAAP+tkPdr9XtL32tGf+CxM1MkZv6a53aMW0gk
	 RdYwFYTqxQGZcWDtMpM5HsMP15LGSa9HRwDv8BiOMjHr9MpY9xmlX8L+6KJx0rf980JNI
	 NVUYfm1BjX9HPI8tvBsJxNzOC5V6+u5vEV4Qv/vs5OXlpXw5m8f7zmoOoJ0qaNKmUdK2g
	 y+dTHBW20978LSQ56EWrTidX9LIm75t+TmcgcvMtHccrzkGlB8NWECmiUcYiR0EMyXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SKxm+SOB;
	arc=fail smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAF606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 23:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SKxm+SOB
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb5b33e2ffso201775e9.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:13:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795648426; cv=none;
        d=google.com; s=arc-20260327;
        b=Is9c94B911wT5iusb7Ny2Y05yi2VnhPYaJu4l7IEuy8DjI1Tlsx7/lkF0L97f5QlWA
         IRTHFhc0ydH/mYMBs/DnII7bkqh9hkYKy1JH0MPyE5xSsnXv/KBJR9pHVsmIghL3FUB8
         5oHjhYO/w/vMOwyW09k4QsncsiwJUXd+pjpgeXKAq8a+Zrfs9YxFjIBg1RWcvPXiGfg3
         5Ia1nLZAlFD/bOvGNjMicjR+n1Qo4HkIMTidw0XIFOzl8Nch6CaCGpSKzzLtJv5QcQd5
         8Ntwh4/FpEjKb0MQIkbmpN3P2ILXfjBZlgFh0zjyvDSymFXBcACiME+CnjEOhZL3L9tS
         nJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
        fh=iP1VLhVvmDHLwo0yIH+qbn/zYXcbEfFXfp+jkgfK2l0=;
        b=UscwzXwkQBvBvi9OgX9yr6VxuauB9vNhLyLGIj8p4TEJtBMnZQNeLi9nB9CZaE7dx/
         6qgyJd8IzOP686ybiGLXhJWR6y4ebKNFNUWvhirdQP0HCUut/oAj8SshOjuxhVIp4GJf
         H1RWnl6RppRsUnIjlOUVp+WdXvxc6dsBRfuhGD2++DDbzcEL5LtOcwpb4XIPzLtvlKek
         r4HS43zbX2GFDuHq6WWJuR/AFe24ICkRkcCyLP6yUwpjiDjijVL4R1IbA1L+1jno2OwD
         V97Y09pr/1HJefQTCubHex3LJrBSlDONthKQztivZ3joInpwuI5hOFhIsh8VOWJI+kKv
         plSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795648426; x=1796253226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
        b=SKxm+SOBB2ex/3j7AvV3T8YCOiYE5m3HgMGKpVoiU7GWNsXILHhg2MYsqT8e48n447
         3niUHGYlUJjgaE8qahNqsQA9/LJvBYAY/hs8KDbDqJjbsPi2KHAzQ0WUDY1PdH9HaSHE
         6JvuRmyYaTX7TwrNM7VBtsCvx7+iTh9uSXjROu8IqxPp0KApXfhZgpjZqIkP0C4iEH5m
         duqemOKs35oQuCy4TFOu9lUoYFPtIofX1QF4ccSvT54gOpIzT5/Y2A2pEKG4q6nWxkf1
         5OBBy3+F2DbM0Y25RYM3i7eUo27n5QvgdsE9QZYyQ+SpyGWyU4w9qKWCBsIBk9spnEN4
         83lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795648426; x=1796253226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmbARk3XHehA8pJF1qNbcXvK1JM9BX8FvFU7vWFVqag=;
        b=P4Je+1GGx3vrqoOvExi5CORa4/cD53/B2vFSKTkKOQziQZ2caq4Zf2X8rrtAuwvTQ0
         JFDLkldx78dKaO5ySgHRFIoPSRgm1CAGOVxTmsbJr+hHkVJPs3CtR5bgXiQ+kYfqwBZd
         BC1IC3xUPFewFjrBhwi+xzHQDZxOk0Tya7IYmZxc3tQ1MH7PsKqH1LOeG8ah9y2Pjq+v
         vp0w50Scz9Sh1ACYhYIwlUI4e8/hhkcW4VOx8miowgbl5cwyRNRAcIy/LVrxKT88OJ8Z
         tyRBvdu/XnB3uwEM3qrju7XpQPEeEIZ+GwE1qNiYDJ0iMj3hfP0kyTVDNbBRyHyBnBpM
         MlNQ==
X-Forwarded-Encrypted: i=1; AL+hErF+3thDRDPOrll0hcwxv/p6MablqvPlN62TMUKZ3Lw/JobHRtyNO9DMFnfog1/lFcJOOYf+mIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cja2LP3bhm8dwq7s6+i9QsnJJrdJDHdMPra5IDKgR1MkIocBZ
	LIKV1kLAwJ/h/DMAVY0W+9LekYIQC/+vhtYMgIJUwwHUjTyrX7WKynSQX/atRyxKshU7WQwo/aO
	00M+mksP7OzwMACuSG+lcQ86bZrVjK400M+0UV3os
X-Gm-Gg: AZFdTZcluqPXDCZ94gpDXMvL9j7bJFNer9mooxzq7j8UVy9PxXSVcXZ5Q4xI9pJ1Sk2
	UHYa2TplmWrr7XT+wK/48cpCBZpIj39GSRyy0GNtpDG2fCdJ7UJ3PzCCGpKT8LPWWvZcXX7nWiY
	vCvlGQShI/U0gw2pPu7f8NJ5sygBpI+QWa397/PvfOWwOy8aV+dtNnw1rujhe87qKPS+03PzqmM
	HQN12VwVaDpUafvaE3SCObxgOXUzotX3IdwAa+ktvla3/OaQoFbixSZCr3icwnePkDWrw9oRzlt
	Q3H5dAEjfYLPurB6dHlzXhLO8SC26UfW7Wg7I1FJgw4cNKWUr/cNbpNqGq3KL/v+K6y1Uwg7yqz
	JJRZdebvUINBVwOHBiIpJhB2MWLIVxhI8SHbsoGVCmfyDKcG9ImHK5BcnNVVDeeU1RlwEFA==
X-Received: by 2002:a05:600c:26cb:b0:4a1:fb0b:1c9c with SMTP id
 5b1f17b1804b1-4bb9169f045mr2044145e9.10.1795648425836; Wed, 25 Nov 2026
 15:13:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org> <20261125-hugetlb_fixes_2-v1-7-db27fd2f71a8@kernel.org>
In-Reply-To: <20261125-hugetlb_fixes_2-v1-7-db27fd2f71a8@kernel.org>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 25 Nov 2026 15:13:32 -0800
X-Gm-Features: Aa3M54o0VivDc1V8RDqLgeYd6VEevBgWlfFAdGAu_CvY1Dn7_qwvILYBeMeboYQ
Message-ID: <CACw3F51O9kQut0+uOCgP4BEB6VmsmhFVLFxvLXGJPeD-dk0n5Q@mail.gmail.com>
Subject: Re: [PATCH 07/21] hugetlbfs: don't zero poisoned pages in a hole punch
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Jinmeng Zhou <jinmengzhou22@gmail.com>, 
	Hongfu Li <lihongfu@kylinos.cn>, Andrea Arcangeli <aarcange@redhat.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Dave Airlie <airlied@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, Mel Gorman <mel@csn.ul.ie>, 
	Dave McCracken <dave.mccracken@oracle.com>, Andy Whitcroft <apw@shadowen.org>, 
	Adam Litke <agl@us.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	James Houghton <jthoughton@google.com>, Yang Shi <shy828301@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Matthew Brost <matthew.brost@intel.com>, 
	Byungchul Park <byungchul@sk.com>, Alistair Popple <apopple@nvidia.com>, 
	Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
	Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, Joern Engel <joern@logfs.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, Sasha Levin <sasha.levin@oracle.com>, 
	Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>, linux-mm@kvack.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:35=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> Since commit 8625147cafaa ("hugetlbfs: don't delete error page from
> pagecache"), a poisoned hugetlb folio stays in the page cache, and we
> must not access its poisoned pages.
>
> However, hugetlbfs_zero_partial_page() zeroes the partial folio of an
> unaligned hole punch without checking for poison, which can cause
> issues like machine-checks.
>
> Let's fix it by simply not zeroing poisoned folios. We don't really care
> about their content: the folio can no longer be mapped, and read() only
> returns data up to the first poisoned page.
>
> Only zeroing the pages that are not poisoned would need more thought, as
> we cannot reliably identify the poisoned pages; that is future work.
>
> Note that a folio that gets poisoned concurrently, after we checked it,
> can still be zeroed, and sync'ing with memory failure handling is also
> left as future work.
>
> This has low urgency, as it requires a hole punch on a poisoned folio.
>
> Fixes: 8625147cafaa ("hugetlbfs: don't delete error page from pagecache")
> Cc: <stable@vger.kernel.org>
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/hugetlbfs/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 2e8672ae2fd52..5437a55d14f1c 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -656,7 +656,8 @@ static void hugetlbfs_zero_partial_page(struct hstate=
 *h,
>         if (!end)
>                 end =3D huge_page_size(h);
>
> -       folio_zero_segment(folio, (size_t)start, (size_t)end);
> +       if (!folio_test_hwpoison(folio))
> +               folio_zero_segment(folio, (size_t)start, (size_t)end);

Clean fix, LGTM.

Reviewed-by: Jiaqi Yan <jiaqiyan@google.com>

>
>         folio_unlock(folio);
>         folio_put(folio);
>
> --
> 2.56.1
>
>
