Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122720;
	b=zLmGzKrVhp/H13WHEKgo1atza+yn/Va3FhUDT1Y3CfjeBrWZ5AzCGR49rA6qVHahLLdA
	 cPRq6+RdjqUNmdQCzXl9gH0kRW8DRYjeP71Fr7UU3F8lQED7GRN73Y6xwQSD3Rzd+G2rU
	 HT3TFfXj0ae7k1YupfMHFj0E1OADdgOEzJN8mihAmJn8B+0LEK345FQP4heXta1j2Lq3u
	 gnzKSyG1+RM8yxx80dM0ZAW3gJU1JZlLx7XcGcgYcQZcaAjOAD+dDll/ZZv9rUfVXCFpp
	 jxkJf6f9S6TApetHpf+k+rFSSoPcap+aqiTzKe2guSEp1pQ2mGEtZBR6pCWKRuOzGCw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
	b=Kb189WDZvbbXBKwMNOrwhW/qiQkD9YCd4Jr+gBcxotvROYHOcvUR6ajIO1IIINlX1d41
	 m9BCpRdMh0nBqRJRkvFWVfuPaIZeIoOH3uAMCO9LDd2fk43HHZpOReYMF+nEQXMdrESEv
	 45AcH7c69/G91TQ+du9AI8YLD12Bw40zjrMGWr0d8blJ4XCvpbZZUMDJRAv8ggcIsUjss
	 Wof9ECOKyiz18iFE4PV5+/rBVpms2uN4E4CS3Y2TeW3JOiwiAmCT5NDIApYD0KbTa8xzr
	 4c7pQ1E42/KHMek78DlON3Nyd1m7lhtq8PY0teAiaNAxE1w3LXHjxgwTPaerklIq5Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EFE606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 17:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80EFE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1011a12.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 10:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122719; cv=none;
        d=google.com; s=arc-20260327;
        b=Li+JaGU86we1bTCQWjkIskPkifKFycV0MKHM67s8/TBy112MjnOmRfI2pJpUgpXhbB
         LL5gyVzk9AY0Y8ufEosr9iszeFP81vg4/6SIB6xeZt+pw85/6RBuPkfvP3LkqvaRo6+x
         mnIwvviR1qVoqXfkbut8XUtelRVU9GF1AsaszfykYixxtKzMaw7oEo1pfCTXaNNK7hiK
         PzkocvT5vDvpTndLS4frEqs8XhvIMblvI+Eht8zGkhpRGcFfIBQF+E77sCdS88PESoH6
         rPfvRsBJ5h1OkeeqnHPibdImGBMGddQ9QLsvWm9jOtNWidHTQAkHougaVBW/jWhnIzex
         dTLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        fh=c20XU3+zQR8JTknIygg380MkLZ2qIA0JsNT3o1DB25M=;
        b=JbCmfx5Ioz5qt7CVwEbY7vWnNn6AuEoe6VFr+qLeio9bXsZZnI/WjhqAFXoTSgrVVG
         jemVsMDUzSvHJpJz3ALIeyF/K2pK4pigesfQ5H+MxsqogQpFa0dVvTZGjgiEuQSoQP7G
         qIzlWDg3pz6VnUHU5dNG6LFJprCEMYfawFKeWsruZFgj0moy1xfq9lwQuOCT+jS1fnEM
         gxjKZpyDp3W+Q5yulWGZXDgw9Vx2c6msvp93hdS9ljGCBE6coqnf2O7R9al5x2W6voIe
         WyhyUC29QMX80Qj6ZPXA0JNfzWxQtP50e3+vbUHMp71APDTFf2mxqvaOcEEwT9Sr1MbM
         b3Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122719; x=1793727519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=TMbu8PxLhpBm5Jxc+UmD3OrKaB4W+TrO+HcdLK/qemtnz4THsUOJblzPEUuFNQdsAX
         xVppISd9HZVk1k52dXnBDZH5JY2olDDSO95++GZTKXt09LrvWQXh0bdmoGTLejAK1OLt
         bxZAkxblGRQiGMML4G9URFa8xQWaDlL49VzCVKznumP2+MyKHmYFopFrp7Vomsp36yZT
         yCc03PZELOyQAfukDHyz3vOgAGIADyvURsSBd2Fsfa6RJBwz/JWJp+HSEvxtvlpPmo9U
         hDMP72JYBeOYHs8QzW38V9/J7Ub9YckAD4l0ZmHIvx0H8IlISifANZcUpwjvV3oxhTkL
         uyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122719; x=1793727519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=vG8pPsNm5h1SeDBykUXW3i/T5AddX8ZFpyNd69viAaqxU1rXHjQcYSFRs6cS/dEWq6
         NLxRRJ+YXXb1ewizGFDl2E/i4tclcicibulRYr6kOVSfRJJd+C7eqp5ooeNsvgsluglh
         fEmbfakb3219MhNg3MgRaKzeliBSMzgQQDMAtlMhtw/H6uNZIhJEww4fjOPgfHt/NjNQ
         5Vir3ExufSDxTKurMF6qyF7lXayyOsloxU3okfLefEe9m8LoFN96L+MNMNY7o2FB8xx2
         2epRe4p03ApxHWa4vrfRrtzM19dzZAhfxoVopXQuqEeskFK7IyFXGVOG5PD9yrCVmQz6
         xU1w==
X-Forwarded-Encrypted: i=1; AKwUvBxiYsN0ZB2Bs9+sfSkOLwzOw9U9Cj1B6G0O8quoMfV8Z4wx61tv45vp4OxJN5k3hJtNpU+mBEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6hui9N6NSTJLB0uQjbaKNg0yBFky81duMGkWwNRhuAMXgJmtI
	2qQOwEEoFiETYwZZNwqgWV7WOr6/t3yXgCOgWfzvKFAVYpwBVqw5Qt4R5gez+/fO8w5ksGq0KLi
	sG/9pNsGno06hv54D0tkFwM7wBPZ6N+mZpvdES4eN
X-Gm-Gg: AYBFou3wzTeZAHvq/3IKPnFRHOQAOUmWh4efEscpC8Iu8RyX1yCuW23NPHpBMVZGvoR
	O68ebhYroDEkc/bwBMKlm4XGiHf362pBJMJFOH6r5sG5LSlla+LwU6/Bl8VcWBHUbKV0210EmU4
	eJmHzfDPZEhDwGbHbfwN79gZYEJMbLw7cyqYHsUUCm1C+d8SQWYtZKOKRmk5bKLYrJZpXWQpfHz
	+ZyuU0rrBVL3yx053Vh7U3t33keCZq11OQuSLotB7dQPsnWFZuMoJiokpmCI1qy2jdmcB+tJSXr
	4IlQ9rFUfu2AlG8JFiMgAAgi24jpcZrH3gQGAD+fEI4kilbFNKfhVh4clOXejpJSF+dlV/DLQe3
	MvDQ1uoA/RQLisbyeo8opfPMu+mKVzcl+5LzmqYM70RkFmZJBOyiFVQ4JZ93HFYR4BA==
X-Received: by 2002:a05:6402:a2cf:10b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b4994c5b30mr2214a12.5.1793122718174; Tue, 27 Oct 2026 10:38:38
 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org> <auBityGTDQjXURWg@gremlin>
In-Reply-To: <auBityGTDQjXURWg@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 10:38:22 -0700
X-Gm-Features: AclHuK8I8xcfhrxH9JH4rYz28CrMoohsxda9QortkIHbiI93aH5ozWron9iLPAM
Message-ID: <CAJuCfpHEHPNj9DKOGbVHYCUsmLf==-XkhzBAR94gNt_ErhdnnA@mail.gmail.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:43=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> > userfaultfd_unregister() wakes pending missing faults before clearing t=
he
> > VMA's userfaultfd registration. With per-VMA fault locking, holding
> > mmap_lock for write does not prevent another fault from queuing after
> > the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> > waiter can then remain asleep indefinitely.
>
> Oof.
>
> I guess userfaultfd_clear_vma() only implicitly takes the VMA write lock =
via
> vma_modify_flags_uffd().
>
> >
> > Call vma_start_write() before waking waiters. Existing fault handlers
> > queue themselves before dropping the VMA read lock, and new readers are
> > excluded until mmap_write_unlock().
>
> Clearly an oversight from the VMA locks work. I guess was always a Hercul=
ean
> task to catch every single point at which there is an implicit assumption=
 that
> mmap write lock ~ readers (esp. faults) excluded.
>
> >
> > Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> > Cc: stable@vger.kernel.org
> > Reported-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/userfaultfd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 669f71d485d02..7e30b5ff17be1 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >                       start =3D vma->vm_start;
> >               vma_end =3D min(end, vma->vm_end);
> >
> > +             /* Prevent new userfaults from being queued after the wak=
eup. */
> > +             vma_start_write(vma);
> > +
> >               if (userfaultfd_missing(vma)) {
> >                       /*
> >                        * Wake any concurrent pending userfault while
> >
> > --
> > 2.43.0
> >
>
> --
> Cheers, Lorenzo
