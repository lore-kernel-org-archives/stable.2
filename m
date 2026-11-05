Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.134
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793884591;
	b=VB0b8N6Z9Z0CRh/+oEeuJXxVDE3H2PPOvt9V85CU/Zy5YBAlhiZWzaWmsxRKgt7515bm
	 GgpHpgDbDzdLXrE0yyhvX0WXsgVts8zoSQYSz+eyOBYE6t/3jjzum1j7Uc28+MFOT7eu4
	 msb64vcpNc8jYD+SrhIrLL9gdvDYexRgZnFWW5HA1niR2NB4IVfjO3idOLbhLBI5JibX2
	 xAVsWyGtyb9aQGdzaN/Wwir/NZkbaruKroH/5/kkBjVZpg8vzWaYaDVLb94Whr7Aqaixc
	 I10M0FUdp+J3KYh9HidhWf98rUIr1yNSc7/SesrZZaYMj1AXNp+wwZIQRSnMnOlmMew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0fgN5PaurQZf0bnKLww2WDC3U/fAE8PImoVXNeNjn4s=;
	b=xbo/CF3Fckco8fPokVo68TQEnaHQWBIzy7vN9uUA1/bCXt249U7k7u/pojLyxPs6oiBN
	 T0JeTIui7JIdUFbUqamFEU2wZbWJjL6paqS6T7aZUtgZL3aAHoU2Dw8+JSius/xaAhtCh
	 2VrQ7m2yz4MrhqbpL93em0qzHITr8UvxxecyAeN/9EyQILWOe4uLg3YXKIxEYTkKAsCBk
	 wA8VbiDe57ehwfgc5JChJP3wX8vSfRxYgITIROlfbTLbQYnwf9rEFXELrBbAg7og26b0E
	 V6odjNL82f+M0dmkTrG5YCwQ+5vKV3jq3u5NmILub4kodTJDDjyQcfigBnmjIYzrRWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9d35M+1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.134
Received: from mail-yx2-f6.google.com (mail-yx2-f6.google.com [74.125.224.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8D606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18C8D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9d35M+1
Received: by mail-yx2-f6.google.com with SMTP id 956f58d0204a3-67bfda43022so485526d50.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:16:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793884589; cv=none;
        d=google.com; s=arc-20260327;
        b=F/CNfdOZXfd2f29G6Y2tPm785buhZrWU35MNFLz7zWdVX4rmYbBQYF3SXOy8xELSPO
         KeICn8O+0AgGiqPnOggQHWm7QIPRxegVnbyABCx86gJjvZWas1AkvP+8tap0VdksO1Xb
         XEljuINsoZMXVjNqFQBfXzahF61+xhp4wFMXlLqhyt+IjeV0JFzCfVTNZRw5xF/BWNmm
         mWyOg3rcdHP7aVX4CTTeWL43/jDqVF6HUbQB7selzhuW7Ai305uKcId/d5GqUd1FXWLp
         is2KCC7V+s3xK3Wjw5zM/gVsHYBmmOJqoR50MDEO7jLwSA8o+UQxyBEK8NqB37j32rVb
         XrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0fgN5PaurQZf0bnKLww2WDC3U/fAE8PImoVXNeNjn4s=;
        fh=aI6TX/vNVL+yub/+APgMDZGBuuJ4AkeVHho1nKXTU+I=;
        b=RnUq14DtapiI6TOMPP+01/3maaUZkWsnX+4GVSnEe7KiGMQMlJlk4S/TF2N/z86Lyj
         4FoJTEBRU4WMnn3R9bbXcpVxaSAX2QZv9QnnwnoocbsDBEsEJfRqTsh8eQtMaN4xCVJ6
         /F8BBpchG8Po9iwogOHLnM0pW+1ADMVGGiFoR8xz/LPE3ZzWJlvDr7oBRBf24Td79gE1
         x5sGzOWOw20BG5YU6Bgs2zvVyEvKZvxYDL+4bjrC+/KA6NYE+e2T2g+4ddbWGv/6mb6T
         VUBZSkzQ0qrGZK9mNj/kIJS9oMHKwNuDej6sRdJJ097LIRLrGw70vo2/ls70fpGqZPqc
         6xGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793884589; x=1794489389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0fgN5PaurQZf0bnKLww2WDC3U/fAE8PImoVXNeNjn4s=;
        b=T9d35M+1WnI3C59PijPm+YPFFTG5eVnjEpz2KqMASOHu117WXN05YtNBaN4QxakS8I
         qViwu3cYhS7W/ZwD8HVqVchU65Z07xM8a/HZLPFRVhPHpsQyxTITfiGKvTYQyTgrWdBr
         UZI+YEphZSpXsBaSDwfvYO3tx3eu67G9FhUkjwoYeJcPYLTv2m/OtmYjSankJ4IcN/PP
         wV5oc8+l/5QFxuVlhIRNApaLlfPZqszHteBKiuxgMqVJWl/lFcM/vQg1WaMBGt0f8QHc
         13HKmd3APZBz38bcG6M2KRe1yIdRBcQ9OW3f/mDePVTvoO9/eIEWpMVz8xmaCP/VG8Ul
         f4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884589; x=1794489389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fgN5PaurQZf0bnKLww2WDC3U/fAE8PImoVXNeNjn4s=;
        b=aqH73mbu8YTyfOlKXPquty5TFdvcL61aQJBAYNBPvk92w5VutDmhVSo9zJfLqFJDzF
         btF6aSs1z0CYKnjsrDzFQBrRSMonJJxP2jVBRNV8lg0szIpzKXkx9q5ZtlaEgR+xuTTp
         x2ukGzx00g5PWlxagXhW1ZEiJMrSMU9xXGtyoW0sYqgkcdBVgULMEc57OfBinYDN/cEO
         6j4Cne20dD9pqfvZb+zKRHsz05TJpjIASG67qNqj48CIIQ6iiJktPAzY13nRwU8SLxLl
         0HThPZkCZ09JXN0K9DmCrD0SOAh8Tx5DVo+xdKnd7JvmTpUMv8QQooY/qZKi9qX3359t
         EJXw==
X-Forwarded-Encrypted: i=1; AKwUvBzEhRwvCzI25pBLfcsMSzFLWgZpqgzLzSimFoRQocmupN+ODrLPOZ+PntFnTy0qehscPEQ3Xb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9cjuOA4fpVQB5j/4FYR6k8NOFUxkiG/5GhaAqT4CQwCH46QWut
	0WuFURa52YNjEp66XIgwvKI/8CMN27GqbRnWmyripE+0UX3fR0pE+JaUPr6kEfIkyKhcJ1yHBtG
	JEjk4zI7V95DgnA17FpYwN/iCfDWanGM=
X-Gm-Gg: AYBFou2ibasG85zPHVU4HcP82BTxtDzS/yTX8oSgnWPIt9maCDoOKrikFEu854XD6ly
	iHbDf3PDk6OWq2jzYErm+nVUrkaDcwmLspUwEOu61U7ZTYmZnDhZBtI06vTdGVuUKuRsrTwd6XO
	2WlxZjaKS2KR9Fx4YdbahOjcWzvUdQmsRtsmRNbHaKSSqcjHzi3umMIU/53iKFT6xHZFdFuGfD/
	8R3yYL3cheZGxpwK0M9CW3pz5gSf9mM3k+8zi8Ka9AroKZ8nOEmSOlsVj6dqcHQe0B6pdjJ1fUP
	DE0Lzaly6AuD/kdsfx18j8KBVLjp6f2HYXw09pIlIKkWoZhUPdtWJjrmajTeT+2dUOSEyzi53p4
	l2LAzosX8DjFBFlTlB73BXYYkyEtl3DapMDTdD2zBnu8F5yvcdCm2TE+IWaHWT0xn6xOOU7oN0J
	+igtdIVsNUv/N+oUBG+A==
X-Received: by 2002:a05:690e:1183:b0:679:887f:a2af with SMTP id
 956f58d0204a3-67ba5017fa5mr9815288d50.126.1793884589062; Thu, 05 Nov 2026
 05:16:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103144148.14430-1-jianyungao89@gmail.com>
 <aun6-mywXYg2VTL4@nidhogg.toxiclabs.cc> <CAHP3+4ChRtv5OCoRrF9-D2GYXJnu0kS4_3O7kXqYRbTtLAt8mA@mail.gmail.com>
 <autIEIDr0097CaNS@nidhogg.toxiclabs.cc>
In-Reply-To: <autIEIDr0097CaNS@nidhogg.toxiclabs.cc>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Thu, 5 Nov 2026 21:16:18 +0800
X-Gm-Features: AclHuK-HsRoAU3woefVw2Yrio7whOe0XI8exE-ALNXQ5hLdRjfouZVkMBTd2OPU
Message-ID: <CAHP3+4Dd2t4xpQ2M0HO=QCcWQU6CksPwifuHy69KwzYo0YepAA@mail.gmail.com>
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

Thanks for the feedback. I've now run the full auto group with the patch
applied, and as you suggested, this gives a much more thorough picture
than the two targeted tests.

Command and configuration:
  kvm-xfstests -c xfs/default -g auto -X generic/778
  KERNEL: 7.3.0-rc6-xfstests-00194-gf4a2f5951fee
  CPUS: 8, MEM: ~8G
  xfstests: v2025.11.04-10-gdf376ed02

Results:
  xfs/4k: 1214 tests, 7 failures, 231 skipped, 10890 seconds
  Totals: 1242 tests, 231 skipped, 31 failures, 0 errors, 10122s

Failure analysis:
- generic/633, generic/696, generic/697, generic/753, xfs/018: these are kn=
own
  pre-existing failures on this kernel version (also reported in
recent community test runs);
  they are unrelated to the rmap merge logic.
- xfs/013: the test's own output shows ENOSPC errors leaking from a known
  shell redirection bug that broke the filter_enospc logic; a fix was
  posted upstream in June 2026 but is not present in the v2025.11.04
  snapshot used here.
- xfs/155 (marked flaky at 20%): the full log shows xfs_repair returning
  an unexpected exit code (1) after the test intentionally injected write
  failures via LIBXFS_DEBUG_WRITE_CRASH. This is a userspace tool/test
  interaction issue, not a kernel rmap regression.
- generic/778 was excluded as it is a known flaky/performance-bug test
  (40% flaky in an earlier run), and Darrick's later fix for it is not in
  this xfstests snapshot.

There are no new failures attributable to the rmap three-way merge
change. The xfs/236 run from the previous series also still passes.

Please let me know if you'd like any additional configurations or
specific tests re-run.

Thanks,
Jianyun

On Wed, Nov 4, 2026 at 11:01=E2=80=AFPM Carlos Maiolino <cem@kernel.org> wr=
ote:
>
> On Wed, Nov 04, 2026 at 11:27:54AM +0800, Jianyun Gao wrote:
> > Hi Carlos,
> >
> > Thanks for the review. To answer your questions:
> >
> > How I found it: I found this while reviewing the merge logic in
> > xfs_rmap_map. After tracing the left-edge merge path, I noticed that
> > ltrec.rm_blockcount is already updated at line 1119
> > (ltrec.rm_blockcount +=3D len), so adding len again in the overflow che=
ck
> > is redundant. When the real merged length is still within
> > XFS_RMAP_LEN_MAX but the inflated value exceeds it, the three-way merge
> > is incorrectly rejected, leaving the right record unmerged.
> >
> > Testing: I ran the rmap-specific regression tests with this patch
> > applied, using kvm-xfstests on a 4k-block XFS configuration with
> > rmapbt=3D1 and reflink=3D1:
> >
> >   kvm-xfstests -c xfs/4k xfs/236 xfs/578
> >
> > Results:
> >   xfs/236      Pass     6s
> >   xfs/578      Pass     34s
> > Totals: 2 tests, 0 skipped, 0 failures, 0 errors
> >
> > xfs/236 directly exercises the rmap btree grow/shrink paths affected by
> > this change. I did not observe any regressions or warnings.
> > If there are specific test cases you'd like me to run, please let me kn=
ow.
>
> Ok, I'd expect the tests to be a bit more thorough than two test cases,
> ie. I'd expect this to be ran against at least the auto group too. But
> nevertheless I'm glad you at did at least some of the homework.
>
> The patch also seems fine to me, so
>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
>
> >
> > Thanks,
> > Jianyun
> >
> > On Tue, Nov 3, 2026 at 11:33=E2=80=AFPM Carlos Maiolino <cem@kernel.org=
> wrote:
> > >
> > > On Tue, Nov 03, 2026 at 10:41:44PM +0800, jianyungao89@gmail.com wrot=
e:
> > > > From: Jianyun Gao <jianyungao89@gmail.com>
> > > >
> > > > In xfs_rmap_map, the left-edge merge path already executes
> > > > ltrec.rm_blockcount +=3D len at line 1119 before checking whether t=
he
> > > > right record is also contiguous and can be merged.  The subsequent
> > > > overflow guard therefore must compare the already-incremented
> > > > ltrec.rm_blockcount plus gtrec.rm_blockcount against XFS_RMAP_LEN_M=
AX,
> > > > but it incorrectly adds len a second time:
> > > >
> > > > (unsigned long)ltrec.rm_blockcount + len +
> > > >    gtrec.rm_blockcount <=3D XFS_RMAP_LEN_MAX
> > > >
> > > > The extra len makes the check too strict: when the real merged leng=
th
> > > > does not overflow but the inflated value exceeds XFS_RMAP_LEN_MAX, =
the
> > > > three-way merge is rejected and the code falls back to a two-way me=
rge,
> > > > leaving the right record unmerged.  This produces rmap btree
> > > > fragmentation but does not corrupt on-disk metadata.
> > > >
> > > > Remove the spurious len from the overflow check.
> > > >
> > > > Fixes: 0a1b0b3855cf7 ("xfs: add an extent to the rmap btree")
> > > > Cc: <stable@vger.kernel.org>
> > > > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > >
> > > Hi, even though this looks reasonably correct, how did you find this
> > > issue?
> > > Did you test this at all against any regressions (i.e. running it
> > > against xfstests)? This is touching critical logic on the rmap trees
> > > which can potentially end really bad.
> > >
> > > Cheers.
> > >
> > > > ---
> > > >  fs/xfs/libxfs/xfs_rmap.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
> > > > index 14aef87837a9..c2b2f8e7502d 100644
> > > > --- a/fs/xfs/libxfs/xfs_rmap.c
> > > > +++ b/fs/xfs/libxfs/xfs_rmap.c
> > > > @@ -1120,7 +1120,7 @@ xfs_rmap_map(
> > > >               if (have_gt &&
> > > >                   bno + len =3D=3D gtrec.rm_startblock &&
> > > >                   (ignore_off || offset + len =3D=3D gtrec.rm_offse=
t) &&
> > > > -                 (unsigned long)ltrec.rm_blockcount + len +
> > > > +                 (unsigned long)ltrec.rm_blockcount +
> > > >                               gtrec.rm_blockcount <=3D XFS_RMAP_LEN=
_MAX) {
> > > >                       /*
> > > >                        * right edge also contiguous, delete right r=
ecord
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >
