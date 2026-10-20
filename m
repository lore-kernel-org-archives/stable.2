Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501987;
	b=MLHLZprgN+zXqWd+1K/8mbuINejzq8LL9nJDdWjb9xjB9J/9kR4Po00/6CvGcVJuT762
	 /5v2Ur8vGEpb/wzbO36pf9mJ765bHg5BOOR/f5FlisYYt12tbRVK/oJBu+K9NxdzrZwdw
	 XvN6L8myi7OncXvTv40VqRICNIE/wdTp8G0D+1XhnR2rjeueqEe9S4SQwYS/ijJgnu7UH
	 JNOmzB1Nc55qpn4srP8vg1ytBJkexayb5vcliP3vY9G985Js9nYp3UpzmxA6b+6WBQ4AE
	 g+br6q3MrtPvncEe1MfKV8KNHSF/Le4hO66kEe5LA3tuNRjtNl/8qOSWdGM5cfiHlIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Zm0NOGDk+3cS5Mg2C1v6yh0sZgFnVUEDDk4kvHgijW4=;
	b=kSm63/cd3+ClMxyjEo5orFBbmMxMHom23gpTtAmRsUVltGLHrLFRKKSBQZXmqjAOAr+L
	 BbdYrtPKpk1MLO7uh9Uiq3KKmjWZpO7kJaOBQn8lMm7Yi+C0wXHuwC/XE8TWipst4+URB
	 2Fji+MSBh4dBU4SyupW8ihBCbS3hy99z87btbZGaSEU0DTdIWCmgZk4NcLW/eq6o2rDJg
	 pua0/2aTaiZwZ1LQWbNuvhR5t/lKa9KRCcWIs9V4dyp2MZ3ldLzbkkDW2/zxhRtioK4PS
	 0tFyPlN1oz/0r+ialYgnIpgpHCtoCLlzN905tshtKR3K8N9fgEKK+vZR2CCdCwsL7eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e0bDWaKX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475C606A31D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C475C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e0bDWaKX
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so41205075e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792501985; cv=none;
        d=google.com; s=arc-20260327;
        b=UheKxYJt5WTyxP8F4qwlVMH93FaddgTzumvDZ0am2t93T1znDQQnumAgrj29hOKQad
         FQ78stXQKrDdQi+9t46cmnPBvtLx0XooWWGWNjsiGnx7HgCa+52sRCePO6ZV+Ai1aOqf
         H+UYHHYtBqoOKDgbKE9h0GZvW3/wEqa8zXVtlvQbyPuK3DgANsOMH2nm1YMKQpxdEqYx
         apxgX4QKHFDSK72sbGBUMURu39OAhLxfPINlDZDEtduzYWkfsb6adruC8sWXHDiTI/hg
         PaaYwGPpdBI4mwBIFSM+RoI9IELGqsomhsGqQ/CbO8r98WrETnwdoKc6h+n+3l3gN0SO
         00zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zm0NOGDk+3cS5Mg2C1v6yh0sZgFnVUEDDk4kvHgijW4=;
        fh=BuJGYpUDItO+uVf8Is7WZHb30t6OGBBtHE6EIEq1kSA=;
        b=DLRsT3Y060TjMTYKVuzS0N1h346aFAkDkcTE1QdxgQg+XNc8BbAKwTosIh485tqBM3
         7UNgXpmsWRPD9b1T0wUR6lto63dIRqPJ3R9eTZuztdPjeo3ppIqSKPbLJhcj0zx9fvyB
         AaG9bitD5RCRAVSTRvx8BeMVoIxPQ9XB37dXDNwO2MjIhbkqHzHFljrQh+6jMvxqm7+1
         0uzX4V4gKRRxErOEQ67payfUl1VKBIW1IOWHm/zbyuTBRjgHoEGv+6qU41nULtmiWiEJ
         KtXJmNpsYGsNGDfHyhP9ciD6dGbfguQHxg2t5ldQh1lobdz6RV9Fz+V6DuqB5H4JPdt1
         d6OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501985; x=1793106785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zm0NOGDk+3cS5Mg2C1v6yh0sZgFnVUEDDk4kvHgijW4=;
        b=e0bDWaKXJM9dccxuU72bmtMeBLCiqXf/S4VLaVDa+BdcueDfL4I/e5b+0YIH89CqeW
         Nyq1Qk3zel3lTehD25QUQJ/Ekg+Qd0t0TMkoLmqzNzVCtqRfogv+tKRA/mE7+cYfN8Hm
         4E7yYPY2QG4mFvrPN7o9kuapBbATXjPL5NQkJKFaLP6zVFfx2wtnLydRcH2TrICG4C3k
         CWrOXvrr+2ftCt+R6EiKCxhwDumK4etgvT+8TkK+Lgyuc9EHsiIkcbmqiBZLV0XvbQvq
         MMH0erCeZs+zzrq73EjtB6r1+4zdrIqG4LP9PLsONDg/4nSvI3e5MoUXJND7euKCr65u
         xxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501985; x=1793106785;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zm0NOGDk+3cS5Mg2C1v6yh0sZgFnVUEDDk4kvHgijW4=;
        b=flqHl2XZ0nwhvzMxUcFCV3IVRymimCbFBhVIaoJkHXw0Msj/5tc9mfXx8eAdgbEL0z
         QIN4jwX8p3dc1QWFQfllwgEG3IYJrUmP7TkdDstL6OzsKIjLzqfjzqo62QAH/ettrXT0
         YFtlP3wn/DDl5Fz2TIIHinoD3ssaF+CipNIOOVFD4VLRhyOYBv0t2Kmg4mLrveZtCm3A
         7N/Bx+IR+zicqZfJDow/5VTJIOYlc7w6RlOIUgMnIvOsGIoDE+52sMXZfvxywB46fqCi
         427mR6M2qAG+cLFZV4tHWum5Dli29PeCyf63QgLJsliKiq29+e+cvdJ6vlSOEstqQPdB
         n53A==
X-Forwarded-Encrypted: i=1; AKwUvBwSnIHJQLdI95jILkY4S0rxfVM27FFuoL7TExEj/TKUb7FxbBw3TcyGZNcR3V5rQjRApooRJ6k=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiCVz5exeGKM0yvTJKoBrGyc+XkcZPdrwX2a1iPxmmW1BQQXXJ
	5w8mchKxMhxeNw6ZlwG/HtfGUq0iI+s1vqSsAxBk+qA9CvDzo5dYHx4MnuJLDfKDuTRNB5fdSHQ
	EBu/DLcwt44Nc1llN/W/Fq/9ZTshOFc1LAxqURTnbsg==
X-Gm-Gg: AYBFou2OYemBGzIx7Ud6UnwFu0K05M5Dx/nMU4GBOGtUxeB0XTGD/bKS/35vL6MwhTi
	o1rtUvFdkRrWY5He9LpA6ujwEZFcJ05fbIBOFGhQeqKF1bpX6Nw8M2N0avoy2UzMHj3c/dmWq4U
	B6UQ/Qmu+Brz2LaGMuZaRPzYlDi6yc8UBb+Z14cwFo2CSpWQwA+1Qr0mkduEhJtNd8zNXfi+bTf
	9osxdyaSfXGMUmSFp7corYlfjyR2QxMDiIodUdQ7MI02XtROGiMtQBr+u1eefxAhAoZZPWh0Pd6
	A23buVnppvlTKoUUOjpApweIfJ0QpiBsoIP3DxuIkAbTJdRTE/keptBovONOAObYGfEdlwC4WtL
	GkrgZ+NbluBIvbkl2+vzkHxQcnLCSceMGYwO/kDGWfsnLKiuqSe3qyU/zTccIEOJBDHwNjROWuk
	a43ktmKw==
X-Received: by 2002:a05:600c:8219:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a1d760746amr244503685e9.7.1792501984828; Tue, 20 Oct 2026
 06:13:04 -0700 (PDT)
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
In-Reply-To: <atcRLYvKavedT6Hs@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 20 Oct 2026 06:12:53 -0700
X-Gm-Features: AclHuK-KWlwJ6jupfQN2upeYH99aX1_31TwAq1vK8qUCAkH6OCtgeWVRSWcg6oQ
Message-ID: <CAKEwX=MRvzzd0Fn=UX+LcRo+K9wuqCWSB42NNn7rvZkZukRRrg@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Youngjun Park <youngjun.park@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:58=E2=80=AFPM Youngjun Park <youngjun.park@lge.c=
om> wrote:
>
> On Mon, Oct 19, 2026 at 09:06:15AM -0700, Nhat Pham wrote:
> > swap_cluster_populate() can publish a cluster's table with the cluster
> > lock dropped. A cached allocator can use and empty it before the
> > populating allocator reacquires the lock. The resumed scan can then
> > dereference a NULL table.
> >
> > For example, CPU1 can retain a cached cluster offset on an SSD with
> > per-page discard disabled:
> >
> >     CPU0                          CPU1
> >     ----                          ----
> >     swap_cluster_populate()
> >       swap_cluster_alloc_table() fails
> >       spin_unlock(&ci->lock)
> >       local_unlock(&percpu_swap_cluster.lock)
> >       swap_cluster_alloc_table()
> >         rcu_assign_pointer(ci->table, table)
> >                                   swap_alloc_fast()
> >                                   local_unlock(&percpu_swap_cluster.loc=
k)
> >                                   mem_cgroup_try_charge_swap() fails
> >                                   swap_cache_del_folio()
> >                                     __swap_cluster_free_entries()
> >                                       free_cluster()
> >                                         __free_cluster()
> >                                           swap_cluster_free_table()
> >                                             rcu_assign_pointer(..., NUL=
L)
> >       local_lock(&percpu_swap_cluster.lock)
> >       spin_lock(&ci->lock)
> >       return ci
> >     alloc_swap_scan_cluster()
> >       cluster_scan_range()
> >         __swap_table_get()
>
> Hello Nhat.
>
> Good catch!
>
> > Reject an unusable cluster under its lock before scanning it. Relocate
> > it only while its table is present.
> >
> > Fixes: cdd77f84d966 ("mm, swap: consolidate cluster allocation helpers"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/swapfile.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index c3288910b3e3..988b7316e0a1 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -981,7 +981,11 @@ static unsigned int alloc_swap_scan_cluster(struct=
 swap_info_struct *si,
> >       bool need_reclaim, ret, usable;
> >
> >       lockdep_assert_held(&ci->lock);
> > -     VM_WARN_ON(!cluster_is_usable(ci, order));
> > +     if (!cluster_is_usable(ci, order)) {
> > +             if (cluster_table_is_alloced(ci))
> > +                     relocate_cluster(si, ci);
> > +             goto out_unlock;
> > +     }
>
> If this patch is applied as bloew, does it prevent the issue described he=
re?
>
> https://lore.kernel.org/linux-mm/20260720071342.50742-2-shikemeng@huaweic=
loud.com/
> (This patch publishes cluster table after lock acquired.)
>
> This patch is chagned the way I suggested during review... :(

Ah I missed that patch series and your review! What happened to it?
Did we just never land it?

Looks like we are still doing neither Keming's approach (table
copying) nor your approach (publishing at the end of
swap_cluster_alloc_table()).

>
> As you pointed out, another context can free the table
> without alloc context knwoing this situation.
> I missed this situation.

Yeah I feel like it's still not safe with your approach...
swap_cluster_alloc_table() does not hold nor acquire cluster's lock.
Between its publishing of the table and the subsequent lock
acquisition in its caller (swap_cluster_populate()), someone can still
come in and free the table.

It's tricky. We do not have an explicit contract for the metadata's
lifetime, so it's a bit of reading the tea leaves for me...

I think this is the last gap, and it's rare enough, so this simple
check should suffice to cover the edgiest of the edge cases :) But who
knows :) If bugs re-surfaced again, I think we can spend a bit more
time ironcladding the lifetime of clusters/tables:

1. Allocate outside of lock context, but make swap_cluster_populate()
lock the cluster, check cluster's status, and only then publish the
table (and return with the cluster locked). Basically Keming's
approach.

2. Carefully enforce metadata's lifetime. Perhaps we can add a refcnt?
In addition to occupied slots holding cluster's refcnt, we can allow
for temporary holders. As long as we can acquire a refcnt, we know for
sure the metadata is not freed under us. This is my approach for the
old vswap patch series, but it's tricky, especially with caching in
the picture.

>
> IMHO, Publishing the table only after reacquiring the cluster lock, as Ke=
meng
> suggested, and rejecting an unusable cluster under the lock as in this
> patch both look correct to me!
>
> Reviewed-by: Youngjun Park <youngjun.park@lge.com>

Thanks for the review, Youngjun!

>
