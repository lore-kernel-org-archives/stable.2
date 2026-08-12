Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B536352018
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564522; cv=pass; b=bq30WRl+QYd7PTYpEJRink9tIGWIbVs8NnYxl+/Zr/oQHkIt2I2ykXIExzyFOr/vPsO+rFnqj0wmNQpcPr6ICaQNRW1LcmIOtvEdTe/pDF662tksDvR1zG2psz3ZyaZvr5Ke3KA0h8kOHAl10ivZ/hsWGfF2LLoKAR3RN5xyza4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564522; c=relaxed/simple;
	bh=aVHP6aOrXDQiPayu7rSfj+AIL/ngK9HNzzA4FQjdLwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSQVtD37EDLrijW9dbSx9N1Ab3ww72pxoQtybH62ictivDs/8a1v8u2Zq+g7ehxxKZWkSCNAvF7+Xi/boDQrbMllAahVvCS61AW5COa6JWpyrGe8j1S64jpZgcc1Wa+jkW5XXjqZxlJkTj26PLSFt+5Z/JPMIwSpQmahzPWwuTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hINF1b9A; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hINF1b9A"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9696319e14dso520037241.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564520; cv=none;
        d=google.com; s=arc-20260327;
        b=sPX8L6oilWiokT8P051ApX/hlO+1ZyADu67DsS6r2SF6zhxyLl5RGWNhNZp3zs/c/O
         0Rx2SuIk4/Jby7lGgve+nJpygzi0+Pth5Pg3TU5DjVpuGvyzkEepRM7ovOrcytYwYxU2
         v42qAgtsx/smvjjnPY8qa871XSFMyitBnSecIMnZlz6d4yAKp9CIC7lotwx3W8tDdRhw
         Xk2E6pAsIJgc6ooDvX30KU+Kn+gV2n6Zx4BEYXka/WOotcRX73gwXxA1E3dV1TITf/Es
         KdpeOyhqvoDe95gn2d9yy+IPKJ+VAKUIJXqShRUsN+GJ2eobGPYW+8rHX2fOYPHqlNjk
         tqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZFWm2XK5v11eaF0/gNKBVs8omlTqaxmWHtBXtEHdpg=;
        fh=FklBGKakCN/CRDd48LqJ+GesX3tzOqHd4LD59FdWLWw=;
        b=Om2TyJvxJfqRZYS3Qqw+FXJcbrAAqp5fcBjF1vUUCj98S0pjONtMpkQLxdRu0+s/vY
         hYtYWyImY0qOX+kje9ESVgbynH7SPKQcK4NJ5YpVbGNpN3DclRxwRD5E2fasbu11PZXV
         Cpt9GG07F7OFOEJatRBkAWMwBCbuItri6Ys5UJK9XV8P0qD5+GMjkFeuZbmcp5/fFFa/
         4/OuX+mEpwKUKqPk8Oulb5DS5y8e4CGqDffRGeliclyToRrh+hcYDEk4Cgf+aEIsvt65
         XeAHwGfaeyo/XjGSpD0OxluB1cUsRkxKaIzRIzzRSsi87igWtuFfZiastqbbTuB/m96k
         k38w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564520; x=1787169320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZFWm2XK5v11eaF0/gNKBVs8omlTqaxmWHtBXtEHdpg=;
        b=hINF1b9A/ajp2mUM6O8F/fcjTeQXVcatvxiPFE7qzOQ/l9t5IalThPXg7fVHIb2su1
         dxrfVnfEXKkTLEa+81L6hO0OAPr17RBWbizwpx3vqn+tFonHhjrHlzo7csBPYx4OWnKi
         hk5mt0iPFxl9nUaOI9RavPgLEAHutJwfoV5qunFoz7HER8vQgpJo76BLvYjkTrnOfrnq
         fTts9cWmqj9SziUSH0pU3Nr0uB9sfUwVsOdyhEmOAFdEM2EtOgxlMJr/ebxlT3ynDQk+
         JFTXtmDM2yV5zMhotcTEfnTnEXG95Shdk3Uw8EjI7WiJ2kgZXN45NWbQcXUEiSlLTFHU
         QGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564520; x=1787169320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZFWm2XK5v11eaF0/gNKBVs8omlTqaxmWHtBXtEHdpg=;
        b=WGsC6rqWSHpIJbEj1rLQioO0IdKmU84jeQsQY2G5+pwzUI4xFkcmF9y6Ovh2MOHToP
         hRkz8rCiE9J2NgzmznBeyWCIRzgTRbqkR8L09PBHTCI7Hhqxrud+1c7la2HA6XYOXHEP
         tWjUiNSxgXfs4dJhAqUlYHBYfR8ecCO+y2+jzZAcDVWGzHPP8Pg4i/hRbG3KF7CYAHQg
         dOXxe534Ta+yqyLT8hBjWUK1CxRm/jZ+TLOcdJnPTvYGaP8ra8Cvb20RVCxtUBQXvpPa
         xydUmVU12z0gnZ8pRZy/ayVIL4u+LU62Z9bpjehoAUqmwcB28ptBte3HpA6y1IXKuWXa
         dHqA==
X-Forwarded-Encrypted: i=1; AHgh+RoJ5XvgWj8MZbm7UdjlNixCKnIPe4Vqinp2oJhCUJ5VjHPKDtb7fQrKSnyiNuZtnGBmekwsIjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNUoM0naY1onnQEBhdnjAhXo7ewa6gieM2MVHveAQk8Cj4COn
	fcWQRqJff9/BRfhlcIBhauwfTYPHpW3tbGYhgA3pvEwkxMc3LPUuQNcKDgqwVf35f9QItk+xOsL
	o2k5I9BbLQnYW5eaJ3eJu5ozTmACDnaY=
X-Gm-Gg: AR+sD10xWjRWg9uEB/pTpmIIQY074HB1a+PHQUWwMoKt2KmQjEiIV3Luvi9NZ1VrJ6l
	b2wWWR9iqsjTnvGPXV+MSKwZFasjamVP55wOJ8WX5+5GvLGKsN5Qyzmt8zBoM9we7rGaxYjoL8K
	yt91QN8TuCzMR623H1Jgk61Pqi+mTzNajE+J0vgA9CiedpFdj94gYd0h6mxV6lIouMnqeYz7K+b
	cmaQTA9TWAMkvxH8CRwBOo/xrxHbCsnxTU+BcJzoA69qTkSchldKjq/ooaQNp0KjbP3TMUUP/fa
	5YKcPr1M2BcWJcZ+wp8T6neGEFnJmGRIRnbXGVnBfldjgXMNB8dCRNrI07qphOA3VyzpIC9CutK
	8YoeH1D/DqnPZ
X-Received: by 2002:a05:6102:2b85:b0:74a:b1ee:e034 with SMTP id
 ada2fe7eead31-76db6884b10mr227289137.8.1786564519957; Wed, 12 Aug 2026
 12:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702114034.917507-12-amarkuze@redhat.com> <20260708053941.90316-1-jhapavitra98@gmail.com>
In-Reply-To: <20260708053941.90316-1-jhapavitra98@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:55:07 +0200
X-Gm-Features: AUfX_myzt3DZxzwoVJieGS3PuCqaD99jyI5Z3-nuBvhafXSZMGJzvxBTER8UqCI
Message-ID: <CAOi1vP-14HiHikaQuiKPjaMd35ujMu+dE0+V__7Km1o=JHvcDg@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: fix OOB read in decode_watchers() via missing
 bounds check
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: amarkuze@redhat.com, slava@dubeyko.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 7:40=E2=80=AFAM Pavitra Jha <jhapavitra98@gmail.com>=
 wrote:
>
> ceph_start_decoding() validates that struct_len bytes remain in the
> buffer after the encoding header, but accepts struct_len=3D0 as valid:
> ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
> compromised OSD sends an obj_list_watch_response_t reply with
> struct_len=3D0, ceph_start_decoding() returns success with p =3D=3D end,
> leaving zero bytes guaranteed for subsequent reads.
>
> The immediately following ceph_decode_32(p) in decode_watchers() has
> no preceding bounds check. With p =3D=3D end this is a 4-byte read past
> the validated buffer boundary. The garbage value is then passed
> directly to kzalloc_objs() as the watcher count.
>
> The sibling function decode_watcher() already uses the safe variants
> (ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
> after its own ceph_start_decoding() call. decode_watchers() is the
> only site that uses the bare variant, confirming an oversight.
>
> Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
> *num_watchers, bad), consistent with the established pattern.
>
> KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
>
>   [   72.047085] ceph_oob_poc: buf=3Dffff8880085936c8 end=3Dffff888008593=
6ce
>   [   72.048685] ceph_oob_poc: ceph_start_decoding OK: struct_v=3D1
>   struct_len=3D0 p=3D=3Dend: 1
>   [   72.049477] ceph_oob_poc: triggering OOB read past slab boundary...
>   [   72.050699] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   [   72.051427] BUG: KASAN: slab-out-of-bounds in
>   ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
>   [   72.051427] Read of size 4 at addr ffff8880085936ce by task insmod/6=
1
>   [   72.051427] CPU: 0 UID: 0 PID: 61 Comm: insmod Tainted: G O
>   [   72.051427]  7.0.0-rc7-g9c2abf69da83-dirty #14 PREEMPT(lazy)
>   [   72.051427] Call Trace:
>   [   72.051427]  dump_stack_lvl+0x4d/0x70
>   [   72.051427]  print_report+0x170/0x4f3
>   [   72.051427]  kasan_report+0xda/0x110
>   [   72.051427]  kasan_check_range+0x125/0x200
>   [   72.051427]  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
>   [   72.051427]  do_one_initcall+0x9a/0x310
>   [   72.051427]  do_init_module+0x186/0x410
>   [   72.051427]  load_module+0x2ba7/0x2e50
>   [   72.051427]  init_module_from_file+0x15c/0x180
>   [   72.051427]  idempotent_init_module+0x19f/0x430
>   [   72.051427]  __x64_sys_finit_module+0x78/0xc0
>   [   72.051427]  do_syscall_64+0xe2/0x570
>   [   72.051427]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   [   72.051427] The buggy address belongs to the object at ffff888008593=
6c8
>   [   72.051427]  which belongs to the cache kmalloc-8 of size 8
>   [   72.051427] The buggy address is located 0 bytes to the right of
>   [   72.051427]  allocated 6-byte region [ffff8880085936c8, ffff88800859=
36ce)
>   [   72.051427] Memory state around the buggy address:
>   [   72.051427] >ffff888008593680: fc fc fc fc fc fc fc fc fc 06 fc fc f=
c fc fc fc
>   [   72.051427]                                               ^
>   [   72.051427] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>   [   72.129720] ceph_oob_poc: num_watchers=3D3435973836 (OOB garbage)
>
> 0xCCCCCCCC (3435973836) is KASAN redzone poison, confirming the read
> landed in the slab redzone immediately past the 6-byte allocation.
>
> Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> deployment (e.g. cloud) can trigger this against any kernel client
> that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
> beyond OSD session establishment.
>
> Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
> Cc: stable@vger.kernel.org
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v4: Rebase against current linux/master and ceph-testing/testing.
>     No functional changes from Slava's reviewed v3.
> v3: Rename error label e_inval -> bad per Slava Dubeyko's review.
> v2: Correct commit message; retracted overstated impact claims,
>     verified with follow-up KASAN harness.
> ---
>  net/ceph/osd_client.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c..2cdac81a6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
>         if (ret)
>                 return ret;
>
> -       *num_watchers =3D ceph_decode_32(p);
> +       ceph_decode_32_safe(p, end, *num_watchers, bad);
>         *watchers =3D kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
>         if (!*watchers)
>                 return -ENOMEM;
> @@ -5044,6 +5044,8 @@ static int decode_watchers(void **p, void *end,
>         }
>
>         return 0;
> +bad:
> +       return -EINVAL;
>  }
>
>  /*
> --
> 2.53.0
>

Applied.

Thanks,

                Ilya
