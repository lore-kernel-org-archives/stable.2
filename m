Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792651991;
	b=Jj7f+oNAE1VHduwCrhxBcEasWTGMRl9W53oAnBIXA8DC9u9Kjnbuk9QY+rO6aVAITN3W
	 2xHIsVZG+gxDETfYYz4xdJFFGhrxIbdQTk6xCSEn3JaxWS1u5Rj0kjXXhe/Ut5SXKT/63
	 yKnsAyUwiLyfpRB0LL/i5PTldKHuvUyK6J6q9h8d57OLe1N+Ls5YneCngeqIdSjIac1jl
	 VZH59DG2D6V13tOPK1SZ9ho/67ixOE4HcfwPqisRYAEdaBq8p4nWVUFygCCowabLA1VHs
	 cbn2u9EHpelALBLTAIbGhEKZPJUhh+RQY7TKgkQqGj5X2r/CiEqavfxCFxwc2VTU6cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rg3MYkiixfpOGWKpQ3X74Jm8FS7vqinp1afZZUlph/Y=;
	b=AF+fsFIVE8JCr3HGbt6GBae2IJNqRP454+BMIXibFtXKENRqWyHqmwpGpJGC7A5PCPeW
	 GRuw40S4QDimt74+JkmA2iLEV5zrx19/mPP19od7xHXMGjrJkyvsCnu/erXD3nAFReAin
	 srSwAFIslGlJxDIXoHOQEB1lvre6DK/NELoaOndK4FXKMWi0xpmYmK1/2jaK13rwzmbWl
	 1stF+3TBDCT2IuhPTIy6mTIE07xEgcV3s6lNPbcbk9yk3uOzR9PgK1c8CIxRV5FSEPa7x
	 IDcDlbaXc1VFvc/1JZXzIBh9YvaEBYfkdV0p41tAY2buvliFa8PU4POl3BM/vrE7WPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UASPXeKT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ED4606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 06:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87ED4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UASPXeKT
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4677aad67bso160206266b.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 23:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792651989; cv=none;
        d=google.com; s=arc-20260327;
        b=BahEt9sd44b8OrZoANH2lgz2ZxcdITm3KlMnI1G58+OKar+uSNwv+7Xx+JdyJj+3+B
         QvesBJ1Eq2H7ep+STZQN/M7Tmmu3iOviO1ZcoTDA24w18CtU1+BmIe8yXHpD6gkFutWb
         hc7W51pUvoSi3tvHxJDO/1pRR3QORZ1DJyxp7eqqkzTM/Ycz2lZl9xj/9oOf/1rvQ20B
         M9YvyllD9D2LCAmAOiWUsAkhaQo3w+ZMZT07pAkbW9Lk28Y86NUjQRlEKUTavjhQmSsP
         9WnlIRFWMGMr9PtmPnNEMTyeL++NksQbu3Nl476VZMvjVH8XPBXG3A9T34p3j4qv9oX5
         baBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rg3MYkiixfpOGWKpQ3X74Jm8FS7vqinp1afZZUlph/Y=;
        fh=G8U0Sksy2Gt1tVyaNJgVFWmtmpxkaiiPNEBgSWHTcLg=;
        b=j+O7MBlE/iCnWh60DZL5gbShIKG9tN7d7XRLHJ+JMVwDQv/9VAj4EKagay1piEDOdH
         ZMWLzSar7N8oh9g6Re6FMNRE6cTiMTtEZIyiI+upAgfodQjtUs6bLJjEgQttWI42F9N4
         oYaCA1VGmN2naDTUinCSM0BDeD69KqytR+u7qPQWHVe323b15YCD4aJO4e+9PERFuzSg
         WUsHSsvP5m+Aqq8DG9hzfRWKVcpJYPxAhhYXVhUiR6nGdjvl/jbe0vYEyQxwF9xQhyjI
         eHlOxym96mKy3THnyuYh8umNKW+jKlnKapsBpgSb3fCu3FhX5WJV1T+AUWQ3hC6nMb05
         ouaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651989; x=1793256789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rg3MYkiixfpOGWKpQ3X74Jm8FS7vqinp1afZZUlph/Y=;
        b=UASPXeKTAHaKwh8vbwoCb/VP+qE0e0U+GD6HxVbCrAk7FwuV+0cbhRwR2DbD8/Qnuq
         jh+AVCTR1VepsqN50RlZ4ixYRGFq+hph0bslye8bPQSntnR//lSPcGGIvXj6KNRFygCt
         hsZCSAGnJ2aSJcCi++AIXqcNN3/S3slWciZgiBQJF93Q4NetY1Mj7+kD4u9mxSl4YM2n
         5Qc9TCicOf+DFPRVErJO66r5A+5JLHeUECasDJytIQA7vD+aisQTkH5DvJKb4AdBE7VS
         +XGiovP0nPUKgRz6O1d++2NDRZnlysGRTjdWlyFPbZfAUzEnCkgQr3CAHbEn8DVgrTXr
         xM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651989; x=1793256789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rg3MYkiixfpOGWKpQ3X74Jm8FS7vqinp1afZZUlph/Y=;
        b=UB0sFOtqumPOZipIxsE2yuCCApKsPUhBLYSB4/+N4JsvF5PW7eP0uxrEkFPy+2WT+D
         AhakToBZB15RSXFK8hRuLTrDCiR6b7x6ZlyhsOmAWcYaf7GcYn2SS3Y9Fp9OiG3PEmoA
         5ORViqk4B9S6k0hf/+Egw11J5zVU6xeGp6nQsvsd5HXcmDvV54zc4O6EU3hqrbhyOHnb
         O8zyTCmTr5Q9n79pipcmWIUO3A0LENND9oELoKnnQERAyFuNfNWNtZ3yx+dlkO7ONL2p
         mRCQX8sd8bUIORvt/aaVhrnF63KrMOQ3up0KSfOiclGCKTlxRE3ot3+mTZKiBaqiICja
         FqMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzX5Tgo3T/ggIgaXSoobzQBUliGxYfSh4dxD1120RGJ7xkgxN3yocw+8Ell3ErC9iWFlSH7aZI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFnzypICO4Kj4BE2f4S9hMkLz33xT6FHI5mVWpSnDShrGkNfTC
	5A9KnGsI2X4FUyl/HVJ+tF7V6OEOEzXItsAfFHNC1ImFGye4sx/vlig3+pjf2CJGWV8KHtowUQ0
	N6ToI6eUb4VX541SRaEw2kV+fzp8kqU0=
X-Gm-Gg: AYBFou0Z6+fG4QH2Roi6r43XGSblVHXiukfwWspFgwJKPp6w1Hz7gAiXBBVbs4rLYBk
	ELNdd2LqXgOPjro+u4Uh2hwsiXB7VLh6Hn8x6n194zjGIcmStQYc2ya6RlwBG9ErZs3yoxAL7SC
	MBqBOKOh4V5mXabqUJ8mry/cH9Onc1tHr706KIB0ZWAMEt7jJ+f9tEm3HYxfg9SPsG9zDsaxV0H
	AqlPON1Kn/qsdRt0Uys4E+aoCTeZ5p/54s4L/YWuoOpHuCDGcbbUDU43ozlFLVZDzmG3IqYcCXs
	xlaf3p0p8i/3st3FFRXnYyt7chiRxJmxZxNJn7tNoyUG9hsFSvyaI3SAxzizOxmJ+bFHu9ibogu
	qNojHqEcRddT7FfhP5BytV6r+1xcqX7VSBTTX8/xQGOsss/04nPN9R1XCVEhbSrnAu0TkNVQ=
X-Received: by 2002:a17:907:3e8a:b0:c37:8c7c:a840 with SMTP id
 a640c23a62f3a-c467966c0c2mr359451866b.18.1792651989383; Wed, 21 Oct 2026
 23:53:09 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019160615.2348500-1-nphamcs@gmail.com> <CAMgjq7AEg6XEUJPaM3mMBQAeS_KiDv8_za4w-R2WaZ=ZGenvuw@mail.gmail.com>
 <CAKEwX=O=PL3DEaEDe=F-=zhQ=VW3_UtcqesdX9fH_cr6orb2wQ@mail.gmail.com>
In-Reply-To: <CAKEwX=O=PL3DEaEDe=F-=zhQ=VW3_UtcqesdX9fH_cr6orb2wQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 22 Oct 2026 14:52:32 +0800
X-Gm-Features: AclHuK_1506PMfDGxQQ_jKcqLOauYM9YVlFaV9ZgB9uWuZJ7dc_z3c4TC8n9H3w
Message-ID: <CAMgjq7BSzYTbrzbA4vGqMbvegoHnDtJ0vA9PcwCet-m6Ow3ouA@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nhat Pham <nphamcs@gmail.com> =E4=BA=8E 2026=E5=B9=B410=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=B8=89 04:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 20, 2026 at 10:58=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > On Tue, Oct 20, 2026 at 1:41=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > swap_cluster_populate() can publish a cluster's table with the cluste=
r
> > > lock dropped. A cached allocator can use and empty it before the
> > > populating allocator reacquires the lock. The resumed scan can then
> > > dereference a NULL table.
> > >
> > > For example, CPU1 can retain a cached cluster offset on an SSD with
> > > per-page discard disabled:
> > >
> > >     CPU0                          CPU1
> > >     ----                          ----
> > >     swap_cluster_populate()
> > >       swap_cluster_alloc_table() fails
> > >       spin_unlock(&ci->lock)
> > >       local_unlock(&percpu_swap_cluster.lock)
> > >       swap_cluster_alloc_table()
> > >         rcu_assign_pointer(ci->table, table)
> >
> > Nice catch!
> >
> > I think the real problem is that it turns out calling
> > swap_cluster_alloc_table() without holding ci lock is bad idea... I
> > think this patch still leaves some other call site too?
>
> Do we have another callsite? There's a callsite in setup code, but I
> assume that's safe...?
>
> But at this point, who knows any more. The caching only stores a
> swapfile struct, and an offset. I wonder if there is a potential race
> between swapoff-then-re-swapon and cached allocation? That'd be pretty
> wild.
>
>
> >
> > We may instead add a "bool locked" to swap_cluster_alloc_table, and
> > let it lock the ci first before it does any assign (not the alloc) if
> > the allocation context is not locked. That is, keep the
> > sleep-allocated tables private until swap_cluster_populate()
> > reacquires local/global/ci, then install them under ci->lock,
> > something like pre-cdd77f84d966, always assign it atomically.
>
> Hmm so a bitlock?
>
> Lemme think about it a bit.

Ah, no, not that complex, just something like:

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -449,9 +449,13 @@ static void swap_cluster_free_table(struct
swap_cluster_info *ci)
        swap_cluster_free_count_table(table);
 }

-static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gf=
p)
+static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gf=
p,
+               bool locked)
 {
        struct swap_table *table =3D NULL;
+       struct swap_memcg_table *memcg_table =3D NULL;
+       unsigned long *zeromap =3D NULL;
+
        struct folio *folio;

        /* The cluster must be empty and not on any list during allocation.=
 */
@@ -472,8 +476,8 @@ static int swap_cluster_alloc_table(struct
swap_cluster_info *ci, gfp_t gfp)
 #ifdef CONFIG_MEMCG
        if (!mem_cgroup_disabled()) {
                VM_WARN_ON_ONCE(ci->memcg_table);
-               ci->memcg_table =3D kzalloc_obj(*ci->memcg_table, gfp);
-               if (!ci->memcg_table) {
+               memcg_table =3D kzalloc_obj(*ci->memcg_table, gfp);
+               if (!memcg_table) {
                        swap_cluster_free_count_table(table);
                        return -ENOMEM;
                }
@@ -484,8 +488,8 @@ static int swap_cluster_alloc_table(struct
swap_cluster_info *ci, gfp_t gfp)
        VM_WARN_ON_ONCE(ci->zero_bitmap);
        ci->zero_bitmap =3D bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
        if (!ci->zero_bitmap) {
-               swap_cluster_free_table(ci);
                swap_cluster_free_count_table(table);
+               kfree(memcg_table);
                return -ENOMEM;
        }
 #endif
@@ -494,6 +498,20 @@ static int swap_cluster_alloc_table(struct
swap_cluster_info *ci, gfp_t gfp)
         * Make tables visible to cluster_is_usable() after everything is
         * ready.
         */
+       if (!locked) {
+               / * Lock it here before assign, not after the asssign
and return */
...

This should fix all potential issues I think?
