Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792519133;
	b=RFLnmWMOWbubLIAWa5sCd/p4XPBNLQcf5q7kRNunPRlIg1LdYzpNt85f/Uz5KolfjUJT
	 KsN+9x9YdLMfyHmRoTKopMyOp8sNxUkUh+b605aHZcsGLe6XwaOSl6fOBuHM9I8zNavYt
	 MQBZJ3LD56LWksahoD5znAtZwuPQSPe+h873k5R9fXquv9JqcoeMFL8E/X/eKueyZ98Fb
	 1nLX9pS9NJPd8lZ0MmHdYc06EUlGM7gMwh7LixkUXCxRvmZh2eghssJ6UCzFDFdjZ8qMq
	 KvYXQaWiBgWKrwKNoBW/O/UQ2qzOfUQ/gMcNLMUBTl8shQCGSXbCxS1VS6CWRZyIYdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Dc+Bo7udqDy3OvFW1e4k6Vi+Psamqa3s48HVUQ/rqV4=;
	b=L1zcQgGPE0CeslNpUVAO4+1CiEqX0oXH5Rxirgr24YFA7vDnErbufMyd9jFHYC99Jnv9
	 hdsSKGXAG8+7OfcSfgTA+dw1QyGrQBZ2ecl9pA64mo0NytC6wUIindAQKFFd7v36kgs0d
	 ILDcaKicQ1gCK+IxhPa+ptUA4i36DYR8mobwV92KOy/IM8GWw4z3JcFjs9WtAt8nmC8ml
	 iU7X1IMgpTWDddDGt5BJauiVnMva9fS3JGeD+9Oto8+Fi9KjE6XTmIBZUAniDergsjA1R
	 5HrTCx3aGcuIxltSEbiGtlqBsh1IzRFf73nsLE/7O7nL20CCV7DRSt1oFspLLK/dCUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oixlCHmd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C2606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 17:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oixlCHmd
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e8c710847so464830466b.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519131; cv=none;
        d=google.com; s=arc-20260327;
        b=fG8d5RtQBFjtJYNRHuULQYuS4ydsQuL/rt93S+PEKBT333dpBHupSD98bvR24aOf/6
         gi3N39xodbAqZbx+pbnQvVXGnay+F5yMgOoYhTI/gyJ/UW2qwKHuD5E/ePM2sAIGWV76
         FvNodGSEhayanrZ5KO8y9UqTUujd54CVwPUbPct+SswR36QMfDTEV5+OXcwYSfi/x74C
         oIhjBVhLpvHb0yfkjo/+NtgmZ+AubojObPpvL0LCaA4o1oU8knn9vvibeJa90CYof8eW
         gqJBVIrZ3Yo0VFoNu/0PEJUWn5ZPE8a4bEsc+EfYECRT5MCbgiXrKxM9v+g9XTUWMA4q
         XaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dc+Bo7udqDy3OvFW1e4k6Vi+Psamqa3s48HVUQ/rqV4=;
        fh=b3G/SozmQksXSWod3F/z6J1xiok0Qzz0sZql+IjZ6Tw=;
        b=sQYDJ8fmFJ0YlinZvqnjQJ3Eq73OBOpwZC/12i8r4xfmu4PuHmri2CPLpdCj+xyXld
         cFKtaEAjCJFf7k9uxbfV2mu1bxFzSXkh1gHBTElnkbcDVp7U+dwjm9s1N83nc3qztYj0
         edqXpqQrt/OcnCU25TnDshSr/3OOVPRY49SNUwPlAvLfdcRcGCRTdZhI8Drb8f9IazR/
         v3ahx+jv5i0Dk0AUk7TJN1XAUZAIz4sLfCB1qVbGmX5mkIvENUzZQHpPT4NNuOGmS7/p
         MqZ8P70okmhj6CYEm0BFi+5iCIj+ZSIsBExZM2BH7OxyQfN4G97E1aARin+Bg/G7Z2f9
         0MJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792519131; x=1793123931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dc+Bo7udqDy3OvFW1e4k6Vi+Psamqa3s48HVUQ/rqV4=;
        b=oixlCHmd8EQKzoAZwp79t3hqtWf3bHlAiEeGnfif0E/BL/nUhlvqZbYEE8eBirxNf7
         7HeBQmzZLK2ZoSJtUjr2TNW9oQNCgURyt7XHBGpJARBp3Gm1yElWMfsp8Psw6Rdx4MYz
         7GQ9PAw+65nnRxtie4faMqQ4Vtmq21L31nhvNU9WzxSh9WGSMY/OXy7g4fDxkDAjSufO
         ETCzkbFkENrv3eSnYfMLFyTFSPGsq5vIeNBnOSmjm+96rIV3mEaJPBFAeFPl6jKsSLPE
         QU0p9dzNxI6zu/zwMB0b3/7rixVLnOfJ2vDDazmRL1z4rTgdrdEIUO9c+0wnSJ87Ekov
         XbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519131; x=1793123931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dc+Bo7udqDy3OvFW1e4k6Vi+Psamqa3s48HVUQ/rqV4=;
        b=TPACFxxV9IEmc73kNqWF0VJ/2CqqF8ulKxDmV9Ff65gLJfMRR+b3KuM+pRdyuW7gcn
         9ojY3I+/FgSOaAB4jAeOcgj9ViXPy3Td0wponJ9uZOPuy0jox/0LQvGjBFdr2I5uvcBC
         k+Fc2jN/PrAeKPE9hiqS+e8kXE8GavuZbJlb3hVQBGRkWPkMCFQCkYJ7NAfi0GzJozo2
         It5KBHY9A2l+xkGQLwfryehsCCMukMVl4mvfBLU3ZDAV0QFv79bbytRi2+1GGvc3AroZ
         fU9T6SWzdQEq6EWust/wq3QEeeN5UiuS5NYlZXzzLAQpyI7dbnHm6p6Quy39tyt4bTVf
         DLxw==
X-Forwarded-Encrypted: i=1; AKwUvByhivBbRvKOrbuk0l41gkR3lu0vKnsZExAgTKoN0JiUT+3KPTV6g/3pf538iZWjXxmQAz5qPlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1nkPjmef1PWepcE+E14OK37knIz366YBUgA2Ad821amximOEw
	6SU/FJQx3GK0OqwAy2nRxxu7PoS0f6xksrpA+IF+3JzpWqDBDKbLQJKc1Yqc36MzRE0bATTaJoQ
	UMjib0uERpNL5CI/FQ79T0jk/E4tWobQ=
X-Gm-Gg: AYBFou0sqHK8sZpA6Eg5hYvL8iHyceQC8pwkLSIyc8sbWDY1ZBPXBOfeOGWgiQJsTkR
	F70TGyoPxrAtlyZZUmPftvSKuwuiqzFFTWrDVtoqlPGCayqIZvOskYCbDhy+6H6GPbiArS3BLFs
	I8q3oDnsohKbT1ZLDg9lU0Yy70T8W4DUiluq7+yDnG+ekieZmDvH3ppxpNUssWOcntuW9C13iMR
	H/3Xuh+Agnheaav43S6p1wQ0WKJQKsYxcH64YRW7NHj/nDv5S/BzcmOfoJs27BrTDwEvwFZXjZq
	y0hHyXBcETd3z1z+AYAjE/+1wPDzjnfwmbUn1N/pTphfk3JQ7kFDNbOJkTlMETWd6V6vPIFQJaU
	qGDX0mSPbgdvm
X-Received: by 2002:a17:907:930e:b0:c31:8c48:e18b with SMTP id
 a640c23a62f3a-c419df3d9e2mr827528166b.14.1792519130900; Tue, 20 Oct 2026
 10:58:50 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019160615.2348500-1-nphamcs@gmail.com> <atcRLYvKavedT6Hs@yjaykim-PowerEdge-T330>
 <CAKEwX=MRvzzd0Fn=UX+LcRo+K9wuqCWSB42NNn7rvZkZukRRrg@mail.gmail.com> <CAKEwX=OwzpxUfdANEXoCeZPBqch+91C4gKwhrcikm6Gj_LBPKw@mail.gmail.com>
In-Reply-To: <CAKEwX=OwzpxUfdANEXoCeZPBqch+91C4gKwhrcikm6Gj_LBPKw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 21 Oct 2026 01:58:11 +0800
X-Gm-Features: AclHuK9UBnCJDKT6vP1WD_aznvQkjk4cpSf1QdPurJznE3HDglLfCYeOaCQoUZk
Message-ID: <CAMgjq7AsUWGw5K5Xk1qz67atXmXB7vYDww-+u9t8Mz7rNAH-6Q@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Nhat Pham <nphamcs@gmail.com>
Cc: Youngjun Park <youngjun.park@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 9:23=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Oct 20, 2026 at 6:12=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Oct 19, 2026 at 11:58=E2=80=AFPM Youngjun Park <youngjun.park@l=
ge.com> wrote:
> > >
> > > On Mon, Oct 19, 2026 at 09:06:15AM -0700, Nhat Pham wrote:
> > > > swap_cluster_populate() can publish a cluster's table with the clus=
ter
> > > > lock dropped. A cached allocator can use and empty it before the
> > > > populating allocator reacquires the lock. The resumed scan can then
> > > > dereference a NULL table.
> > > >
> > > > For example, CPU1 can retain a cached cluster offset on an SSD with
> > > > per-page discard disabled:
> > > >
> > > >     CPU0                          CPU1
> > > >     ----                          ----
> > > >     swap_cluster_populate()
> > > >       swap_cluster_alloc_table() fails
> > > >       spin_unlock(&ci->lock)
> > > >       local_unlock(&percpu_swap_cluster.lock)
> > > >       swap_cluster_alloc_table()
> > > >         rcu_assign_pointer(ci->table, table)
> > > >                                   swap_alloc_fast()
> > > >                                   local_unlock(&percpu_swap_cluster=
.lock)
> > > >                                   mem_cgroup_try_charge_swap() fail=
s
> > > >                                   swap_cache_del_folio()
> > > >                                     __swap_cluster_free_entries()
> > > >                                       free_cluster()
> > > >                                         __free_cluster()
> > > >                                           swap_cluster_free_table()
> > > >                                             rcu_assign_pointer(...,=
 NULL)
> > > >       local_lock(&percpu_swap_cluster.lock)
> > > >       spin_lock(&ci->lock)
> > > >       return ci
> > > >     alloc_swap_scan_cluster()
> > > >       cluster_scan_range()
> > > >         __swap_table_get()
> > >
> > > Hello Nhat.
> > >
> > > Good catch!
> > >
> > > > Reject an unusable cluster under its lock before scanning it. Reloc=
ate
> > > > it only while its table is present.
> > > >
> > > > Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation help=
ers")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  mm/swapfile.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index c3288910b3e3..988b7316e0a1 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -981,7 +981,11 @@ static unsigned int alloc_swap_scan_cluster(st=
ruct swap_info_struct *si,
> > > >       bool need_reclaim, ret, usable;
> > > >
> > > >       lockdep_assert_held(&ci->lock);
> > > > -     VM_WARN_ON(!cluster_is_usable(ci, order));
> > > > +     if (!cluster_is_usable(ci, order)) {
> > > > +             if (cluster_table_is_alloced(ci))
> > > > +                     relocate_cluster(si, ci);
> > > > +             goto out_unlock;
> > > > +     }
> > >
> > > If this patch is applied as bloew, does it prevent the issue describe=
d here?
> > >
> > > https://lore.kernel.org/linux-mm/20260720071342.50742-2-shikemeng@hua=
weicloud.com/
> > > (This patch publishes cluster table after lock acquired.)
> > >
> > > This patch is chagned the way I suggested during review... :(
> >
> > Ah I missed that patch series and your review! What happened to it?
> > Did we just never land it?
> >
> > Looks like we are still doing neither Keming's approach (table
> > copying) nor your approach (publishing at the end of
> > swap_cluster_alloc_table()).
>
> Ah nope, I saw that Kemeng implemented your approach:
>
> https://lore.kernel.org/linux-mm/20260907091356.53026-2-shikemeng@huaweic=
loud.com/
>
> My bad! But yeah I think we still need this small fix (or Kemeng's
> original proposal?), unless I missed something...?

Right I remember that, I acked part of that and was waiting the update
on that sashiko comment, as the first patch isn't perfect, while
Kemeng's mail at "shikemeng@huaweicloud.com" is now bouncing back...
I'm not sure if Kemeng still plans to update that.
