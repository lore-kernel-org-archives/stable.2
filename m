Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.139
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793762887;
	b=X6/a7QEStjpJH3cVCPnXxmm1DCEuAVVorXa8sgNwAL8Ajn6zdOzrSw8n9NoajEccGJAx
	 7xqj8wlDiZjdEJARZ4TFfh7na0Lk5VVCO4yzP1lHLVktEZEZZVy4tQ8Ux0v1B0nbUJkoz
	 n0b0znruKgL1VKEZoc+MLEWrfrmrVIFtzuary1jk1iuED/s9IQcSLUt8fvR3TGwVE8SWS
	 Yw4C8deB0sO1wWzKYpCHvcZMWtgCwW2iHJ0OoYfEbE5g83B69uS/r551Tw/xSl/YIalBh
	 kbAg3HKKm0Q2rFLKEhLgHUWIGVq0zCvfqwoYUyMQqmNaymBwm8lVMgG4rkIyjIDO5QQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TKN5fm3lE6PDFTg4E4wZZqhp3eyt6dK1s1483aTN3Bo=;
	b=3oULxr5tILHYyLZFfmrqZ0D9AdqQID9TKSpUMFfkzJQySiUaLuLttiN8ml5Pey4AqLMe
	 LUafyCtso1PikbT3LHPei2wPEnSmy9cutBPygpGgkDMSszMBCiJ8QIFxGxA1FQB/tkaPh
	 zDuhJ9t3jkXzhFPznCStKud23qf3Vj1yM6eEDsEkFxkehbxyHW6vPP8n0Uo4RFhjMSIBK
	 DgLFcEdRsGY8NB+Q3y/o3FHvlNd2p9Jp/A3CVI8P/TvbbkW0rLf6oJFAU957E8sWcA9q/
	 WUsBw9LDv6hohkJP5Gg4OkzwbT2zYj9nkDQTlAaz21KdXJnQjCBmBjT1zLm8g4nOb+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw1w6O5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.139
Received: from mail-yx2-f11.google.com (mail-yx2-f11.google.com [74.125.224.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6657606A329
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6657606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw1w6O5E
Received: by mail-yx2-f11.google.com with SMTP id 956f58d0204a3-67a51292ce3so147880d50.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 19:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793762886; cv=none;
        d=google.com; s=arc-20260327;
        b=J19xRSrykRqIlHgvnbcoOIZbwiUntYJHo8w7ZIMbgtCQDKVpFH/ygckr65KujVhdlX
         7E3ZV9vyYF6996XQ9TlCnVirG1h1uTcOd1RqrnsZ6o/StMB8YuqzJWfyz0WPA5m7ynsP
         1uxuNHspfZXBgMWduYOa6DWl8SsJ5JPyePnb8JTr3B8N3NpIH3rgW0EgXdWus0UVnnwq
         ikwT+4DqjrIm6vpDQ6o0gXNzyeiFROBpVun5iQbAvqnKALe4kpuqbhX9CI+92dd1IU5E
         NEo3Wkg3NjAC9nbYFLIWe1QHaLEouKCHPF03uc2i++lr2hYH91XPfu1gfHfKJqfGK9Hd
         dIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKN5fm3lE6PDFTg4E4wZZqhp3eyt6dK1s1483aTN3Bo=;
        fh=94S+/3ICg/02l3x8FEo3vjl/P24+b/K5kFv0NpiRf3Y=;
        b=qPb9QAgpqHnnE/765IgPL5AaGOvTH+x8AD53lKwLGoiezGeW7+4QhtrUDh/FNDdzh0
         6QOb1VGxR+srCgm7r9r0V4sj3tz9JYm+aZSnaHbhbT1Zh/4fA7TN4eqmXwK1QqCxjIDd
         dtZl5W3WOT6YGeOqpAeJLmwzGnZlYpKyXpp0e+siHKNT3Maip+2paB5YwwK7iwuPW9SQ
         sDDO4f93040pGQGB5eQ8Mx46CCIzSVkb5YS2pWPH9UPFN+XvV8Pwv6EDlAEY0hSRnLwf
         nJVXHGxbGgWmOTNyZIK47L8WZM1A2WC8MNQcJPvzRheUHZCbKJ4oYUPzxRQ8c14kd0wh
         LCCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793762886; x=1794367686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TKN5fm3lE6PDFTg4E4wZZqhp3eyt6dK1s1483aTN3Bo=;
        b=Dw1w6O5EUnpm393XQ2xHXvpYnx4DuRvEb75Qu6TwCtbbIxjyYM0Vb88t/Vc/UeEVVD
         5B7ypa7o5ZhemJ5Yvh77dquQToqee/RAyTWH74SrjIpeqD1tqkRJAhPnu7cTIkWul2bF
         eQalHBHwFKvLUQV9hdCGpbhUgbkd7RiMhkYOU2oD1V+niZVKMMaN4Ep5Dqxq9bsclcB0
         SQVeemz6NVgahtYGmTIoM6/vQeRfLFt1Vn/mNVSAT+d73T39tCXkoBKrn1ScqCl7AFf0
         iVRTJkV8FfiGoVTaNJSLcEfa084ZVqJa5OFGa6JMYCgFQCNVfuxCaG4za6Drh12gGSCF
         Bg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793762886; x=1794367686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKN5fm3lE6PDFTg4E4wZZqhp3eyt6dK1s1483aTN3Bo=;
        b=KZ2dgM4dObYLDjWEv5MooP62uQR7Eks1Yh/tNg2AiqIcxgf1b8DC2fJfPPCt2tdWMc
         L5ALGhZ+neEjPLDPh617LfvSCg5XjZmYh95ea3eBeV5VGa910rj0gjuHgerc6DlqsNzE
         viSosLrg+hfQLzgEVBvav/tGXBUbObb0hWDtoQXFkyV6CBQYL3AuN77iSOrhy9BPA6vG
         sPEYnePTAinq9DmGAlkFKWQ9KUnA3UM6QEavSpaF1NhT9MmkwvA7U3q2+umNxM+NjYih
         oQDWsFlMupIYL8cF33YqH+0waa/MQy+fR0J+8VHYNKvpukZvsVAN6d2csMM9UTq1eZND
         Sr3w==
X-Forwarded-Encrypted: i=1; AKwUvBz7xM8y/Zz/Ihgkxmo+zXHCGGDMxsoq+7BT8//J73CQjnphRJ61Pq83XIICwS/+g7djsKZ/flw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YAPiGhAek49PTshrZ7Gm6T7Cj5XBm7EUbFaiADTeB0Eg+tEU6
	4WR82ZZq11lt5vk1yQXUrc42ylu/joFZpHizOPQeDPrpy1a55utH8cLt5pJt+tkEBRBIQqiFQRb
	YUy1uHWNKryFYAlzAYW3dJrj6OwX9itU=
X-Gm-Gg: AYBFou1WFW6AQNAdIyAFOv+WHNShnPpOBerkYHNEV71jlX9eB7bYNCN6nci9DeRW5x8
	NKaCq15TCP+TS7wpzz611sJHS11ApOYj+fiLoysRvBLm3YoR5IfZy1dK6B8FTl16WkrpcGXhLgh
	tAPuNhkeBuN1G86rXr2a0KuFB/nZQMJMKe9/DTzArImYgaApXu0buR+B36HmzCnc/5Wta8mNrEa
	AJT4L2775WDqi+VpdokIcLg+Uldr3cdHAKeeZVaqX7yNU/Kh73xlkrmpJbd6nl3yyvEUXESbYEr
	ry/r7MAVh5s4G6BbIvKcDN6r4Eyx/x7YFUSoHICzYVujov3oTn6Z+bQvlAL0MllbrSNRXv9g7LB
	pqdDGva4L+CZ6lgjaBeW0S60UEqPAl1gv/YlCJ9YNr/PY2422tnkO81+m4qtOjsW/aIPSTZ5BZV
	kJbi8gFluAZxd049Y=
X-Received: by 2002:a05:690e:484f:b0:679:bf13:c01b with SMTP id
 956f58d0204a3-67ba4e968d9mr7976806d50.17.1793762885716; Tue, 03 Nov 2026
 19:28:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103144148.14430-1-jianyungao89@gmail.com> <aun6-mywXYg2VTL4@nidhogg.toxiclabs.cc>
In-Reply-To: <aun6-mywXYg2VTL4@nidhogg.toxiclabs.cc>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Wed, 4 Nov 2026 11:27:54 +0800
X-Gm-Features: AclHuK8-QaZQophNFvzc0AoFSF-bpUKDXP10OLzU1_aqdxeGYmQPW2wekA4osYg
Message-ID: <CAHP3+4ChRtv5OCoRrF9-D2GYXJnu0kS4_3O7kXqYRbTtLAt8mA@mail.gmail.com>
Subject: Re: [PATCH] xfs: fix spurious len double-counting in rmap three-way
 merge check
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eric Sandeen <sandeen@redhat.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, 
	Dave Chinner <dchinner@redhat.com>, 
	"open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

Thanks for the review. To answer your questions:

How I found it: I found this while reviewing the merge logic in
xfs_rmap_map. After tracing the left-edge merge path, I noticed that
ltrec.rm_blockcount is already updated at line 1119
(ltrec.rm_blockcount +=3D len), so adding len again in the overflow check
is redundant. When the real merged length is still within
XFS_RMAP_LEN_MAX but the inflated value exceeds it, the three-way merge
is incorrectly rejected, leaving the right record unmerged.

Testing: I ran the rmap-specific regression tests with this patch
applied, using kvm-xfstests on a 4k-block XFS configuration with
rmapbt=3D1 and reflink=3D1:

  kvm-xfstests -c xfs/4k xfs/236 xfs/578

Results:
  xfs/236      Pass     6s
  xfs/578      Pass     34s
Totals: 2 tests, 0 skipped, 0 failures, 0 errors

xfs/236 directly exercises the rmap btree grow/shrink paths affected by
this change. I did not observe any regressions or warnings.
If there are specific test cases you'd like me to run, please let me know.

Thanks,
Jianyun

On Tue, Nov 3, 2026 at 11:33=E2=80=AFPM Carlos Maiolino <cem@kernel.org> wr=
ote:
>
> On Tue, Nov 03, 2026 at 10:41:44PM +0800, jianyungao89@gmail.com wrote:
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > In xfs_rmap_map, the left-edge merge path already executes
> > ltrec.rm_blockcount +=3D len at line 1119 before checking whether the
> > right record is also contiguous and can be merged.  The subsequent
> > overflow guard therefore must compare the already-incremented
> > ltrec.rm_blockcount plus gtrec.rm_blockcount against XFS_RMAP_LEN_MAX,
> > but it incorrectly adds len a second time:
> >
> > (unsigned long)ltrec.rm_blockcount + len +
> >    gtrec.rm_blockcount <=3D XFS_RMAP_LEN_MAX
> >
> > The extra len makes the check too strict: when the real merged length
> > does not overflow but the inflated value exceeds XFS_RMAP_LEN_MAX, the
> > three-way merge is rejected and the code falls back to a two-way merge,
> > leaving the right record unmerged.  This produces rmap btree
> > fragmentation but does not corrupt on-disk metadata.
> >
> > Remove the spurious len from the overflow check.
> >
> > Fixes: 0a1b0b3855cf7 ("xfs: add an extent to the rmap btree")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
>
> Hi, even though this looks reasonably correct, how did you find this
> issue?
> Did you test this at all against any regressions (i.e. running it
> against xfstests)? This is touching critical logic on the rmap trees
> which can potentially end really bad.
>
> Cheers.
>
> > ---
> >  fs/xfs/libxfs/xfs_rmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
> > index 14aef87837a9..c2b2f8e7502d 100644
> > --- a/fs/xfs/libxfs/xfs_rmap.c
> > +++ b/fs/xfs/libxfs/xfs_rmap.c
> > @@ -1120,7 +1120,7 @@ xfs_rmap_map(
> >               if (have_gt &&
> >                   bno + len =3D=3D gtrec.rm_startblock &&
> >                   (ignore_off || offset + len =3D=3D gtrec.rm_offset) &=
&
> > -                 (unsigned long)ltrec.rm_blockcount + len +
> > +                 (unsigned long)ltrec.rm_blockcount +
> >                               gtrec.rm_blockcount <=3D XFS_RMAP_LEN_MAX=
) {
> >                       /*
> >                        * right edge also contiguous, delete right recor=
d
> > --
> > 2.34.1
> >
> >
