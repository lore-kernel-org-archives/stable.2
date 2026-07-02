Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC73603F8
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782968216; cv=pass; b=oIGNMjhnIQbvF5jFI9xTcwaXKFgY+opSbb87HoQ1uqBl0Bxh0I9nQQpqNW+LMpmLKuwUgNmho3dRrrx5pxP5W9hiy9xMsF8Vqr3Ksv3DdKqBeU/tvPDyGcMQ9jQZBQUsjF/PzKF5jwBfXDri5Al3HiCpw+9DzXnnkT1Y/KoS2Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782968216; c=relaxed/simple;
	bh=s65isEOLkWD56800G/UwzuLsNE2vVm3cYxQLdhlGrm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIKEqQbTxpwu/IZRaKUU+ufzlFJCXNBsQunPBbGG9OozNU9tkSYyqCRjRojm8CsaS7LiJsKf3bjiNzFsjVCcVM2zuaBsP6S27Z2SxMQdlJ33Y/0f31N+Cb/9+zea0Ww1OrE8OreFj0APwQyYggqvDvEZbweNm+YsZWmEFzcLS1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IcGYTzxT; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IcGYTzxT"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so19473e87.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 21:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782968213; cv=none;
        d=google.com; s=arc-20260327;
        b=VFvn7nezWf4F1RvKygKBybWby6XDlwTv+mF/6UoJ+etLZMzX+8Ca0jR9poQImzza9o
         rSQM5kkehWKOAAbaWsPEF6m1MU5MkA4qiLYxVEESDaOBBbiKDPSslOohMPMEbWfJuK59
         iRpFrjWQ9kNgFcMz+797sucd03c49JwdE1WNjGUWYsk2Sbn0MZmhDfTEJoJ2FaRGD5u3
         Rww5akjCE2BxSd4dzS40Ln3yL/Qe7FizO+z+jiujAq4avPUQRIYZdgzjaS3Zf8rNbq5I
         WZbgB/JI9d8g+4oJpMSbre3WoY9eLEp7U1UfXjCdM71s34F2MoEg5z9N6x/mxJlFtwLz
         vNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
        fh=Y1rE1uiaDvATlhuqCQyZ1bOrwREHZ9yFcLwtplCpA+k=;
        b=GeXUWgadK+cvs+JYrw56lNjOPSrSZYrsFIIHsIHcsqeIy3O8jfFUZH0NYwaqrbEqsV
         6nLzEWulCa1t50ZI4nzcSYJwE1uVbCpSJbBOZldnfoKtCYyyv2TlnOev3P32n1g9J4Nb
         H/v4UNItCdKB/XUsB/L/pJ0c37fPyF3nlpGcG1epQJxV/ut6wcybRFawp6fMKXVrWNWb
         zqaH3tBAJtntEumOOIkOIzAGE1AB29AwSZ+hdXYUJ5WdXU86OdOO7A6NQtQeeKLS1ByU
         135Dnik6xOMJt5xHCv17ymi0pts3QlTxADGX9M9dyKD3AtLbg2nhO3N5LcSnuhYx1mhy
         waSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782968213; x=1783573013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
        b=IcGYTzxTrVa88w07rOjCJrKkEt6dwztGc2tb3XaZBZn7XKf7BTNtm393I6p09Z3yIB
         k8WidCtzBqdakvnidlb31NxcFCPjW3/9b23xwJV+BtA/ePwzWYRUK2tk8KdYBktyVxfC
         BAmmpHijvWmEtZG9W7I/es50e7bHE9fIPSl2niaGVjajYGQWd8W7OhfiEuPRZBdmgSxG
         nIHIISqNlfw769Y88cCaa33+6WvHhouiMfGbkA5BM518pIcfLqNd1QoHPoKj7rkDPkVA
         Afg19gLsmRU1kqgMeDzJvggUbrxwp1d/8zZHbVIZxlfNYeLwbfwdqhBQ/jowUef6MJtE
         eJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782968213; x=1783573013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
        b=a1ovEzIWwF4NsWTx1dysKPXr48kklEBN6ufMD+GqUvdqmxe07Fn3I5TgSytNQOwGa2
         0ZUkOhvIiBPnM/cBoIpvjb0ds4RhHPiqECIj1Aucod/UT+kiGjebd6itqKcMVvPEcUqO
         MUwA5pqgewp5YY6P1lIe1/mzExxoMObQrTjcJLytynXshlmYyecXje8zegYVR7yGKt+X
         qpcrmdrIvEhpOz4Z7yI9kZcLuwLsjUKU04eIyzoV0XrujaY+VgGHP8ZrKskS+i20clM8
         p7g2eNzfD0ksIQgAipAWZ5iUG3E95EKRqLYWCr3z2JXCYNF7/NGf/YXtUhXaSYmE0rKv
         V2Kg==
X-Forwarded-Encrypted: i=1; AHgh+RpLwPDH3s242TN6Yu0Fjy4PA2zsuSJ/h+HinZBAdvnKgk2B3pNzvNXnNLnw1hqb56admze7IeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMDAD6HrhIHqax+hHM8a7hQRLXWB1sm3kHlZzoXhP6MZJ9kk2
	mvbYJ7gCmJZAYk8rB70SPh3YX7VG5k5LYn/yIXYjVNXzectxcLNoHGBXR8kZBdctl+omyhP2uB/
	+yZcrBe6mHxWcoEHTstpcv962HvIUFxEp1wDkojo=
X-Gm-Gg: AfdE7cmCm1NAYwx/50u32vZdbNG3L1QQ3kCj43ncQO4IyrGuMwD+IA3iJEe9jtaZN3I
	J5HWHt4/dNQGwicUjcMdwFnZeoi4N1O7od6zcpc//GfivJII93vu+/k6HgQlpRQKPd99HCiZh1w
	YDr9K3d++AGoNg0JYPRSWBxLzU66BhboS7NI6wUU2joBmeN6Ck4uWS9CB3GAzOIrmbLmVlLSMad
	QctZclUvkSgr/ED8xwlBX+kQONyMF3w0+bhGeyIXnTZX4AGIr1P2GBZPVF1X/c6gcSsmeozW/+P
	cQIq7cG6lI8h43s3DenviWMb4W9/JQ==
X-Received: by 2002:a05:6512:2243:b0:5ae:b843:9470 with SMTP id
 2adb3069b0e04-5aecc237a55mr33635e87.5.1782968212825; Wed, 01 Jul 2026
 21:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
In-Reply-To: <20260630124252.GD7525@ziepe.ca>
From: David Hu <xuehaohu@google.com>
Date: Thu, 2 Jul 2026 00:56:40 -0400
X-Gm-Features: AVVi8CdtQ5k1Gu0I7l3KP5nC_hRlM4qrUkGZrb3FkW53eA2H-q-z2clu4KZkrHc
Message-ID: <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Laight <david.laight.linux@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	kpberry@google.com, chriscli@google.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
>
> > > If we restrict incoming dmabuf transfers to fit within VFS-centric
> > > limits (2GB), we impose unnecessary overhead on the RDMA stack, forci=
ng
> > > it to manage a significantly higher number of memory registrations. B=
y
> > > cleanly splitting these massive contiguous device buffers into
> > > page-aligned SGL entries, we directly improve the efficiency of P2P
> > > transfers and memory registration.
> >
> > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affec=
ts
> > a lot of io) when the quotient is always 1.
> > Splitting into 2G chunks is a lot cheaper.
>
> Doesn't matter this isn't fast path stuff. It is better to use fewer
> SGL entries, IHMO.
>
> > > Since this change doesn't seem to have a negative impact on standard =
file
> > > I/O or break existing VFS constraints, I'm curious why we shouldn't
> > > support splitting these >4GB P2P transfers? Am I missing something?
> >
> > I was only wondering whether it was needed...
> > It does bring up the question of why the >4GB transfers even need split=
ting.
> > But that is another question.
>
> SGL can only store an unsigned int size, so any large physical range
> has to be split down.
>
> rdma now a days has code to process the sgl and restore back the > 4G
> sizes since mode RDMA HW can accept that.
>
> commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> Author: Michael Margolin <mrgolin@amazon.com>
> Date:   Mon Feb 17 14:16:23 2025 +0000
>
>     RDMA/core: Fix best page size finding when it can cross SG entries
>
> So whatever this produces needs to be compatible with that to undo it.

Thank you everyone. It looks like most open issues are sorted out.
I'll wait for maintainers to weigh in before sending out v3 (which
will remove the type cast for min() per David L.'s feedback, and
revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).

Hi Jason,

Thank you for your feedback. I took a closer look at the commit to
ensure compatibility. This patch is perfectly complementary, and
actually prevents a failure in an edge case for the latest
`ib_umem_find_best_pgsz` [1].

Regards,
David

[1] For dma-buf split with `0xFFFFFFFF`, in case of a discontinguity
in later buffers, we will hit this code path in
`ib_umem_find_best_pgsz`

```
if (i !=3D 0)
    mask |=3D va;
```
(*After `va` had been incremented by `0xFFFFFFFF`, due to `va +=3D
sg_dma_len(sg) - pgoff`)
(*Which will set the lowest bit of `mask` to 1)

Because `count_trailing_zeros(mask) returns 0`,
`ib_umem_find_best_pgsz()` will always return 0 in such cases.
