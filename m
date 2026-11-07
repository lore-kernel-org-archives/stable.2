Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794074584;
	b=ED7yon85hqUl4gaZKP1Tt/JmcDznz30FfyAR2WOfbqjRf14yudRSzVgK3bf4hhB2Mnmf
	 H7ZVG9c9X9kY9UfZTHdkkZrvLFql5KRhXPHZW15JgpWmzIejTRnrannggfJnHy7ggzkq+
	 zlhzVaHAQgfNR1x+5K1v21n9y078DYfgKoVcxxTz1n943zo7OfDqvF+o+xS0T8fd0BUKB
	 unRC2kdKhC74l7UkOzhJLOLc7KcWndjcZZtH1I8DqJRBQ+oWqYtYSIWr4RqddOLBd58OS
	 hBbGCHiYUsyPbtor8dyCRbBK8EIeDKQBLgpcphhVE/38mBw3c3W2klJ19u01QW0kGWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/I+DSuPvds4ikStzUhuSfn+6bMaR5mQijHneFdoPCEY=;
	b=fMYtV+cdaX/w3edT4GQbpJc9vsQz+UXBSLlytRcqMJ64xFeaUW1/UQxfKyd4kTNu6SSn
	 YzAstGs2gwiAlZjteWiaNbAmiXAXb79ntN6Cmk+QHdlBylAFISVhLuRW54/upEDVpoA3r
	 IvU629RUo8amcPKn1SnW4uUO8SyHxQpYONXiJzOBcSUfQtmuxykEn4dRsMRea2Rx1zd+V
	 YV88tnZAZDtCB/KNpgV6p1O+xou+ePlz5bmgnTLSI/JlwmwDwMy/TgGd6A2IUusITNdHy
	 o+YoCAyeGWjHUqYaf4rgNKQifjmaVXYyHrL8oIEnNuHGt/O8mgZqzPgammusD6t2m9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZR/JeADN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D9606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E84D9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZR/JeADN
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d581da0aaso37307666b.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 10:03:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794074582; cv=none;
        d=google.com; s=arc-20260327;
        b=FjvVfRN8l0tU9cw7DCGPcTmWumiKGSuv1pPfIqiUsKinv7qcehhj3B4zYaNOd8DVhu
         r04CBbdAPPLiYLcqZ6NHyAiPuRBSpYsIgG+g7MaJgXBkuuy6CNRMv+qeXhI7S8moOSZL
         e2CtpLWJn4aHLOypDgnF9v9vSBZebOHuJDr8hBbMoQgHeOYQyie/7qWHxrvlyRXHCAFq
         EeQ1yr36SvAucfYwaNh8QcCuK9KYpONxcd/g0sWqj6QvePZp6BuZCGx84JqpQIk62Ru4
         wiQ9oMGTbQm652YNDdtl0hqHrmotVQB+H0XTNCwYg3yMMXRJR4a2RTvraEhLi3ZVhQOZ
         vWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/I+DSuPvds4ikStzUhuSfn+6bMaR5mQijHneFdoPCEY=;
        fh=KveREcGeBjU9gttaWXNmSdazVfa6rpQsrHWuJqK7X4A=;
        b=Ibt/7ZNmzXyLJiPXUzGwX+UkauZZnidFZCTF5jIRwoOrCHUvF9WC8AF+lkmRoimAtu
         PR4JEISIECdx4kF09qyDg25p3rP/Ci5ne22g5uXq8gNRQKrOKKQwyOtPLxdtkwBBUulp
         w4CQ7WNZ+5ojUh1da2x16h0hfqvEnojA13J8GJnyla3GyEKr6D5T5WuflZJnEjfzpbcU
         c8xql0YfMozvSfeiWGFjFlo4jzF5TkNSdGe68dzZSZCbjmJzK2p4yV5XHLSGu146KTpf
         +wWlGR0x70C4ctnA7rchH5TTmXi50LkoUp/mPmAVoU22LfYJKCQa+02r2SOmUaXT59Dl
         +LCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794074582; x=1794679382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/I+DSuPvds4ikStzUhuSfn+6bMaR5mQijHneFdoPCEY=;
        b=ZR/JeADNCmqYCdLsgCwp0KL8ZQ429paZGckzqgNsdK+M6NuuieEsZpFcsmTEv+MWGx
         4Ce6coANmKFIzDyGhn0IRophZayRYEegrEdzPl8wrV4Y10VjWuLYmPA/kJcTJduSYMjs
         D9Nf77vQr1hIIYIiW/KljrhhEHRXPRiDNVGtB3MTW7ZImNtXu7x4aiVeabi+58f8q+bK
         iP9hy8poGp4bbZsE/JpLOtQKE3HovYPlo+XjXyUGqys+HrUkHIVGXvVvKqpzDEyLNNrv
         3wFcf3kPx+Fd7xne5qDMmjkl2m9cPvssl+I3OXX+tWZ7h/aidM0OI4ed7HYXMVK55n9F
         iscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794074582; x=1794679382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/I+DSuPvds4ikStzUhuSfn+6bMaR5mQijHneFdoPCEY=;
        b=LUso2R/RiXrVqD08cMC5feVvpeTD5ih00TB2dobv9hES2nYHq1zpw55qwXRDdAMqtG
         STLIATtFjwMvYQSdMxiJlxLTdpBg1GRvQ4MVwbBrabsOgAnYEvOVawfOuX5NnI94S0h1
         shqtEYeBAPcv1SDH3nix0e8ohA3QDPQR7IyigDYObIjYASzqmsi+nrQWiE6RnYjY61GX
         UB4zWgFQ0QEdRraCI5RU9g4s+JnNci+zGABNH5s8wBcpezX7pm7UNv7u4kVqkXdqlAdP
         J5vTAU0U48QqqJKM05VwoVFLfLL0DzM7OmL+7Okne1ESx2yu2P/Q8FzvWiE70RfvocGn
         gdvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBZesn0a8FNCxv3XTRsQ3Y4vsb/CngdL3xPRio57KoTJtrLRjRij/8kTSqXcpxlRRGcylM68w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VZPJb7+FLC3nWlWami42xhBeIysY0KA8UR9pmqdY9DsKVDmuX
	mo/QeZRMh81fiVNC/s0fVGxjkVBilB1qc99kg3HPDikdwHqcUru4JX+xnV0VMdaZC6cJwJnWSwM
	vAEe3n8Y7gOpQxAsiGpuHwLoU3y+nYRU=
X-Gm-Gg: AYBFou2CtCTXLv22T8byDIDLJgZOZZwe38SfNguozv7AhgrNvv6w8LxGCFOVNFGXo4D
	/BRQ9FmAGQSUh3PF9FeNyNE1Aksc5/4xbX2Qs050+vl+GRgdpChZdsrJktzs+YA7IU+aUuozLDd
	5bo9ctgMtxvo5XA2mL3iFEEwFoO3N6qVWvTc9viUfC0ROYz9artqW+7DegR9ifsG2VCSGKaapi1
	0wpspIbFZBonaHvAPYBX+T+FY/+fju8EdmdJMMc3nzlbU4Z3IDl2VZexGfXTSE4JIit3p0GUOlK
	VBrUxrzXTasdoeGxafR1qLG7RjIirhuKNzfQiNRShjClBYAwoRFLPGnkeetsFoYV84xj3cBDf29
	Wr4bRxF6lxGhk05bkGtxYZ2McSOFKdK01CHnVXdruBimDsSR8Fhi4c8/TMG6hqE+kLWtNXQ==
X-Received: by 2002:a17:906:c150:b0:c46:9ca9:f524 with SMTP id
 a640c23a62f3a-c4d354b9d04mr488402166b.32.1794074582110; Sat, 07 Nov 2026
 10:03:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106160432.2552507-1-nphamcs@gmail.com> <20261106160432.2552507-3-nphamcs@gmail.com>
 <CAKEwX=PiM8vc27jOVdinOGO9AdCOpbKozu=Hj_b55y10-ynFyA@mail.gmail.com>
In-Reply-To: <CAKEwX=PiM8vc27jOVdinOGO9AdCOpbKozu=Hj_b55y10-ynFyA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 8 Nov 2026 02:02:24 +0800
X-Gm-Features: AclHuK9RPnAApTAFi0PfukcJ0UQmuTrX5qH0AJlbdKfeuTMpH9rclGGAWt7gGFg
Message-ID: <CAMgjq7BuAKZ1BjTmdTmXHV+SZCpGMT2YL+q1qvbDOSeqYA==Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/swap: publish cluster tables after reacquiring
 allocator locks
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev, brauner@kernel.org, 
	chrisl@kernel.org, david@kernel.org, hannes@cmpxchg.org, ljs@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, weixugc@google.com, willy@infradead.org, 
	youngjun.park@lge.com, yuanchu@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 3:59=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 9:04=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > Under memory pressure, swap_cluster_populate() can publish a table
> > while its locks are dropped for a sleeping allocation. A cached
> > allocator can consume and free that table before the populating
> > allocator resumes, leaving the resumed scan with a NULL table.
> >
> >     CPU0                           CPU1
> >     swap_cluster_populate()
> >       drop local/global/ci locks
> >       allocate and publish table
> >                                    swap_alloc_fast()
> >                                      consume the table
> >                                    charge failure cleanup
> >                                      free the table
> >       reacquire local/global/ci
> >       return ci
> >     alloc_swap_scan_cluster()
> >       read the missing table
> >
> > Keep the count table, cgroup table and zero bitmap private until
> > swap_cluster_alloc_table() restores all allocator locks. Install them
> > under the cluster lock and retain it through the scan. Initial bad-slot
> > setup takes only the cluster lock because the device is unpublished.
> >
> > A stale reclaimer can return the isolated cluster to allocation while
> > its locks are dropped. Abandon installation if the list state changes o=
r
> > a table appears, freeing only private allocations. Restore locks on
> > allocation failure too, so the caller can return a still-isolated
> > cluster to its free list.
> >
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org/
> > Link: https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org/
> > Co-developed-by: Kairui Song <ryncsn@gmail.com>
>
> I think I need a
>
> Signed-off-by: Kairui Song <ryncsn@gmail.com>
>
> here as well...
>
> (Kairui - up to you if you feel like Co-developed-by + Signed-off-by
> or Suggested-by + Acked-by is more appropriate here. I just filled in
> the sketch you gave me.)

Let's go with Suggested-by then :), I didn't even check if that sketch
actually works, so thanks for taking care of that!
