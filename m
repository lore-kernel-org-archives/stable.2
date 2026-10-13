Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6822431E84B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853389; cv=pass; b=e6JYLGFWR0eaxc/oJiERnYLwyXEZZq3+Z8Om8S3LvFh3DhXjLJ089VPS9TiZ1odXfYC+xgzLBcXDWgwsfKbHUF5TPf/nNeDr76dkJlZO4u2zHP52ZiJ1jscdzwFIWYsrOp5ZnZWESS6srmQsqDBFEQNn/mS3XSHSg2PDzGofW30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853389; c=relaxed/simple;
	bh=lowpFmrvsNjlgMHo2szT6XZJz28KEXOM+3vhDqNGI3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AX+JOS/eJTdrkCr40Y8SJV5LFx3T68EOyfKMvPDm/q8nFsLUvWhSVmBAZwkaUGiy9vn9bF9UJETs5uIOdx15UkCJJYiye8kuGULhHOZzuWTxDozERkWd+reMY3PEgsVDsdmLZ4PH7I1sajoGejyHBGFbHm+QXkPf/ni9Zz9QVak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0Pd+vdV; arc=pass smtp.client-ip=74.125.224.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Pd+vdV"
Received: by mail-yx2-f2.google.com with SMTP id 956f58d0204a3-6753d1555a6so874684d50.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791853387; cv=none;
        d=google.com; s=arc-20260327;
        b=UDpeZ9nGMww/2ja7aFjVXhQ55U8nWohbKSJSbI1rqODTP//+dSYl/d17ntDIaejKQ1
         7rqG3v9zKA4HWogQHwBeczxlcgkcO10A96gthaXYXcAY3rNjdJEXAitytlyxBzFo1MkH
         KfMMT4kx3y5y5cCqUoBYC3Z/JyKTNWpN+BAioJVYIEltDOnoxWMxGHDeGVdV3A9VGc7j
         ls3Uhanx+NaNX+w2kSiFiJHdT6ItHCF5q/4ZLBEOQ1YWH4ao+JPyk2ivv7gwuulsqzKf
         POBVQNK5XsInT/SFqvgSQDB6JIULArd69sjQkinz68NuYkjFiyG10Mk5Z3d97+kHdteP
         Sibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UTuAYK18jDYjig15mU1GjIAjcvhGQddvH30uBR7Fy04=;
        fh=OlMRtR3lDlQ6QunpWfh8XMG2m3e+Tv5EgGTcCudgc6w=;
        b=PAgvXVHHLYVNLUsyb5tlLJFZqQx4MkV5wapwPYQbbEpviHKNXk9PEyX6DI5CqHD+RB
         VVrb6VtTxzGDNTueV+UvzViqQBc5gxZPIoNOiwhs9t/FTldc2TgWIqiKeaAU6UyWaav/
         ny2NG0V949RGiOsj6C87IBquR8sB+P0uXszzxDdc758kwU6lm8+ooYtFHlVTWE6cLbbj
         JbCwoy80rhfFLHgar8Y3tfvh/pLDY2FibAd0jbb+Jq39p93Vdg/rM0f3LxZPOumW2jEV
         uq5YQcABOttPr7OYNuiPb5abe0Qslkr+odgb7iaqWkwkZHXpzVqJf91S/qlRUmG6UZBA
         bnQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791853387; x=1792458187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTuAYK18jDYjig15mU1GjIAjcvhGQddvH30uBR7Fy04=;
        b=l0Pd+vdVYxaIyeC3wlw8iz6yekNOjFLzUxorbnIHaO3rH/NPSXb+NfFWPmsMenEmEv
         bN0V5yjapEJ40ueLuITXA8FQniQFbfwC9nIFuE0+6qBL1XWxkosbkJMuqNjwNhxwwQ4Y
         PDlN7gCV/0iikMfpolnJlH3r2IokWltkciwHdptBCnfhnb8u2CIvQ0mUH4uBdWI71gmy
         dvU2895amFkfOdb9xsSCFGqSM26xjPvnQ3cmd6Zc03pYTHudPdOavVG60fJOmBpaYGQw
         0KTDDz4oa+vrQ3WR/KR44iBG7XEI2IGg+XCfsdu0LZUBkKwytGC3cn4BALtHd7W5+pKF
         2FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791853387; x=1792458187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTuAYK18jDYjig15mU1GjIAjcvhGQddvH30uBR7Fy04=;
        b=lMamG1dUHlBme2spV9yszIN54jNvK4xv7cCmotvo656z9fiy0Vh9mAKNPkSMVXIbGT
         QVh93nxg9F+5Uxdgo87LN/ITAb0Eq8iBcQjk42DDirLxr4RVsRVxlBxvMkD0weseS5LB
         f/JQSKK/6UWntYUV9FFK/hQMHSVj6KEAfZty5lxtq6Mn2acX5rm/scXE7CLffXA+pk4F
         RxX2JSPL/izF8XRylIaMryPvoGd7n/17cQW+1NYy7DconPGMhfv/4I619wjfQJk5DjNc
         872bp0/OR5pE6FHqO2ZvV5MNcY+AbRP+6W+AIA0w+4PW6JhOJCaJ8twF1p7Pf13pqs2h
         eeYg==
X-Forwarded-Encrypted: i=1; AKwUvBzhtGwmVx21amI+8xFNuJ9xewbK7RV9Z0nazQxBq/CKlR6N5ICZ9h7en9G3X+yGUKbqkQzn7og=@vger.kernel.org
X-Gm-Message-State: AFq9FYJi1xVaHz4pBlmHsMZj5BQ4Dw55wNC0N53RSP4QjYIG49SXXmoY
	e/LURsaCOFem7b+fj92nRDzspQfbD+NEZxPAKdOlx+0X5UQcel1ZpKZmwLSz/Azcm9Qzhj3n72j
	TtOEPbbL/1F5riuR0EnIFM6PeShJRTM0=
X-Gm-Gg: AYBFou1wfFf26paqZCpWbik57ziK5VI7Ikgxe5QKJir12fTdTHnXTq0+NvsyRxNRztC
	6LI5Ytsr9smZR9K3dZoqv7dkxgCH4BMnTJkMrvDWYYa5qQr9779LslaUEwUsLD3qONFlujqtGx+
	QLm0jstpa9/9qfDS9XBeZNumvt12txIqjYAPSvfA5d2Un5ALocMelNM9zNVkleQFn8Q8dFCZvO5
	3QsiRwCrFqReS62iQ6EzTdxj4hdkkza0OAUpmaYGw9Crx9U4GaGhMm2nKakAwjCJzMDf0u03IgS
	gUf/vzSEUaPejxTnWJCYugdN+WgMmoMwWoOf4hnog1gcTbHjar2ZhUM=
X-Received: by 2002:a05:690e:1688:b0:679:42c1:d156 with SMTP id
 956f58d0204a3-67942c1d3e2mr2820147d50.137.1791853387325; Mon, 12 Oct 2026
 18:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012151857.22534-1-jianyungao89@gmail.com> <as1nmV342j-eUOYm@aschofie-mobl2.lan>
In-Reply-To: <as1nmV342j-eUOYm@aschofie-mobl2.lan>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Tue, 13 Oct 2026 09:02:56 +0800
X-Gm-Features: AclHuK9sFgO33rPYLTn8ixdiEhdZBta4PDJKOZxl9dlxJLJscw0iQpyhSfFl2bw
Message-ID: <CAHP3+4Dr-XsZggVSf=THU7NBb8RANc5MCREHORkXV5shcgk22w@mail.gmail.com>
Subject: Re: [PATCH v2] dax: fix dax_core_init error return code
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:DEVICE DIRECT ACCESS (DAX)" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thank you for reviewing the patch! The revised commit message looks
great to me. I'm OK with it.

Best regards,
Jianyun

On Tue, Oct 13, 2026 at 7:05=E2=80=AFAM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Mon, Oct 12, 2026 at 11:18:57PM +0800, jianyungao89@gmail.com wrote:
> > From: Jianyun Gao <jianyungao89@gmail.com>
> >
> > dax_core_init() mistakenly returns 0 on error paths. Change the
> > error return to use rc so the actual error code is propagated
> > to the caller.
>
>
> Hi Jianyun,
>
> Thanks for the patch. The change looks good to me.
>
> I'd like to expand the commit message to explain the impact of the bug,
> not just describe the correction. I've proposed a revised message below.
>
>         dax: Return errors from dax_core_init()
>
>         dax_core_init() returns success when either the character device
>         number allocation or DAX bus registration fails, even though the
>         error paths have already released the initialized resources.
>
>         For modular DAX, this allows the module to remain loaded despite
>         failed initialization, leaving subsequent users and module remova=
l
>         to access resources that have already been released.
>
>         Return the error code from the failed operation so that module
>         loading fails rather than reporting successful initialization
>         after the resources have been released.
>
> Please let me know if you're OK with the above, and I'll amend the commit
> message and merge the patch.
>
> -- Alison
>
>
> >
> > Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Drop unnecessary goto label, keep direct return for dax_fs_init() err=
or
> > - Add Fixes tag and Cc stable
> >
> > Link: https://lore.kernel.org/lkml/20261011132017.31131-1-jianyungao89@=
gmail.com/ # v1
> >
> >  drivers/dax/super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 45f84b0eb909..210f4af479f0 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -738,7 +738,7 @@ static int __init dax_core_init(void)
> >       unregister_chrdev_region(dax_devt, MINORMASK+1);
> >  err_chrdev:
> >       dax_fs_exit();
> > -     return 0;
> > +     return rc;
> >  }
> >
> >  static void __exit dax_core_exit(void)
> > --
> > 2.34.1
> >
