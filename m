Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3623793AC
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564436; cv=pass; b=WxlDsfYe0TH9N76L5B3Df4zkMN2un29k9Nx3s2oZ4JlGhL074KPmBOfxg33CY+cD/dedO4mC9dcqY5uahXeLI1jxShNUQZiJ4zpUr+G4nyX9gvHq9bnwl/2FeQRwDsHfPYWaWZaSHCJItUx4CB0k7H4S/sM61h4w2cL9Tl3uvfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564436; c=relaxed/simple;
	bh=Txboohc0dPKT1VBjRn+5jmfSyGJPi9It5KVsjVxJr5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6UTLQZO7VZV69UqTPd1JA5FehnTUfboH3Xk7dQdGKQefWB+SgNYH+FgBigbGnQ9JKyW7jBYvk1lf9z2YIJWA1LPqElEHo3qGPD1jj+AUWD8K6GfZedDWVgZ24ybbuZidzb1OVlvsnmyv9qdbjrh4LCWpnRJp9F7ck9GCk+e6mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9/FLFhl; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9/FLFhl"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-966e7380109so984958241.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564433; cv=none;
        d=google.com; s=arc-20260327;
        b=gDTOom7xu4fcqzOrY4aK07uftp3aoO0tRzCLpvIPkmTfSB/h+eEg67Q/srzLL3+wdi
         H0HOBrkmA0tmKX5wWkzYRiYWtwzFub9mQbk6+7QHR/jOOK12X4WUmv34u9FuRaWve2o+
         LbmSz1JYosP+glZyVN+OX93cKRLD9feECadBgsertdzhATktq2srutD7PeAEzLn0SI2q
         xLf5g9V/3ZSi/BS8Q8iQMV4TE0V2TTSbMczD+0iODQvQvGOsK9QGhHW0MiHfMVrdESS7
         L1bqBTWv1u/qXsKlfnQZ7MXmo9pwGKUCRxHhzJWEoQP2OnThPOhgmORjv8egtAaSz3/z
         +b6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6T6aaun8GIHJZud9admgmvERHFVhpv+KqPGxhLuR/I=;
        fh=zf0c0PtsLU25FZ2em/s3mqEvmJtoarpHC/6gRXY5BBY=;
        b=FihpJZTtmMDHKuAd2p89baboR7A/1MzNQKp7ekgRBkASxBpFLoiMhMMCDYCOHLAH87
         nXGcbQZFDP3030S6El/T9WFtnDLOT9ZG5IEb/BFOpXgw+FZTtey9H42vephh2XxvJsqK
         63eV8+/v9SAsf9/x/Xm/EH7eMN+74cRuBZIhPFYCh2V0kulDM1mISAZh9q1K/lzASYGu
         8l9HoGkr49MiAXn6yKyEEpujN2ysOrWqji8+0aARtU4GpcvQK/fHQL2wgAktRxc9AKxC
         W5laciqtB2I9pu4pRJ3HMi2/eeLJa1rRqGqb41qrHa2APhLx8X0njm8NW7MRRllaHt2m
         8peQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786564433; x=1787169233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6T6aaun8GIHJZud9admgmvERHFVhpv+KqPGxhLuR/I=;
        b=S9/FLFhl/fAQljHcb4/ra0LojtWSBWJ4Ro2C4eAVACrx9FQMU3or8n0OkYeEbT4w8E
         hTPS6H+3x3nWpIpexdbFodyjM/OEf27PKzReV2lncNiotbB15uTVagiCLuc4E/aJ/ZNI
         2vTMFNqlj5066PGihZTlWQxXOcibCAxD43VwH/BPNSNMel1R9pdr6ebgK2/RzsMhP/s9
         kLu5eFW5MDH2k+in/1uwv/AtkCgB6St1t7QfqjzJwxbNmrApWHjRwbyfN1cqKb8hrG7z
         v3E7Wp86CCBDjNzin+UYUORAepyJDo/1L2JNlMRuIHGo6s1r+CPkypordNMrLZjRk+pB
         73bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786564433; x=1787169233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6T6aaun8GIHJZud9admgmvERHFVhpv+KqPGxhLuR/I=;
        b=nyjJ3KY4KaiQ2K6tQL8zgcCrloCHXIDYKO2ef5NoTuUcxHKOmJws/7ob9E8iIOxJN8
         6L7RJmcYi1u3NUYA3TihB3S5KQFMGe97GwEVr+lIMVL7NW75pywMiZCJo/fTxTjGSofk
         jUD3pIk0hsE6uJpxy1UdM9UBkjBBiB2gKUBLM8SN6P1SHufOXdgEpv2EsUAECqzZ2WbW
         5ejQoounNNtVupHa+T6BLHbrvAMdH8HTXyTnRiYxbjoJfVoHSRZ9HbHzY/E3wQWEmuqG
         RraqLkASvmr28VG8JONVZWnxkBeDr1hgW7iAuelUYspdF39bpEVgGS1LAM7cCRjW4HO9
         D86g==
X-Forwarded-Encrypted: i=1; AHgh+RqM+Gu9gVRyYusbsWmc0LDARWX3sno8ae0wjIrddBQqwsoiluICjO1sH0a1PnbYGHhDTTMgVAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzpCEjBsBirCZyu+7DLLTgBemREB1hfEatNJNQUfTH1UohJEp
	Rt22AkbXhNgGdkDH2RgQGkyR+5FKwm9MsjmVCzEzvh5ou+T16vRKrsNGLFNuWfLODitvNd0fnPD
	zvJFgK7+K7DkWFfw1nFLcdyiSHVanBNY=
X-Gm-Gg: AR+sD11hFQ5iV6TZBQS+cz65ezEtIO4J/QjscZD8YLXvNSPOzDsuNQ0pGF5e7lButhz
	z5ZBSDLKGKfccLirVaPpeuFWaIkSupSyrkdVjodr9EQH78asQbCX+OuwScGcMaP8jErFAnPED5U
	RZrdSgydpHKCrXqspkfWoCJxeRBU0a+XpdTDEuK55FLuznf6BXpeBUx1HvyS1477IFmHUDVO5UT
	3ZvzdVzvKrJFrcSjRs+7lALWvIxh6vW4ScVJqJVN4rlNkmiSaIFPIzRhnqTGZ0fTgS1XMdNsM92
	8LRAmGcSjSg8FNMDtjbfS3A95KX+PfOIrVOBrP50Bkx76GjPLf0u8Dzi7xzf68wkPzYlGYXFwlx
	qBQ==
X-Received: by 2002:a05:6102:5710:b0:74c:11b2:a944 with SMTP id
 ada2fe7eead31-76db887588cmr296208137.14.1786564432588; Wed, 12 Aug 2026
 12:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
 <20260602050219.1043295-1-jhapavitra98@gmail.com> <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
In-Reply-To: <CALFbBicS9nhcGbJDbiiwExxaTXPMVUq4OVgd1Md2xu3azO68DA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 12 Aug 2026 21:53:40 +0200
X-Gm-Features: AUfX_mzvUMHPCEecas1eXo38odx26JmTVRgozyq00E4iJXJ4uRlURPqLza5wv9U
Message-ID: <CAOi1vP9fRZUyS5rkThq0ChszVHJx6B3xWXhESULuj8WX3ECExA@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: fix multiple unsafe decodes in decode_locker()
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Slava.Dubeyko@ibm.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:15=E2=80=AFPM Pavitra Jha <jhapavitra98@gmail.com>=
 wrote:
>
> Ilya,
>
> This has been Reviewed-by'd by Slava since Jun 2 (v3), no outstanding
> comments or NACKs on this one. It's been quiet for two months now.
> Any blocker to applying, or should I rebase and resend?

Hi Pavitra,

On a second look, I didn't see an actual Reviewed-by tag from Slava
on any of the revisions, so formally this patch was still unreviewed.
I went ahead and reviewed it myself, it's now applied with a small
modification to use ceph_decode_skip_string() helper instead of two
separate calls to ceph_decode_32_safe() and ceph_decode_skip_n():

https://github.com/ceph/ceph-client/commit/437b6551cfcc235eea1d735a874f9d42=
1f555e17

Thanks,

                Ilya

>
> thanks,
> Pavitra
>
> On Tue, 2 Jun 2026 at 10:32, Pavitra Jha <jhapavitra98@gmail.com> wrote:
> >
> > decode_locker() in cls_lock_client.c contains three unsafe decode
> > operations that allow a malicious or compromised OSD to trigger
> > slab-out-of-bounds reads:
> >
> > 1. ceph_decode_copy() at the locker_id_t name field has no preceding
> >    bounds check. With p =3D=3D end after ceph_start_decoding() accepts
> >    struct_len=3D0, this reads sizeof(ceph_entity_name) =3D 9 bytes past
> >    the validated buffer boundary.
> >
> > 2. *p +=3D sizeof(struct ceph_timespec) after the locker_info_t header
> >    is an unchecked pointer advance. A malicious OSD can position p
> >    past end, causing all subsequent _safe checks to pass against a
> >    bogus boundary.
> >
> > 3. len =3D ceph_decode_32(p) has no preceding bounds check, and the
> >    immediately following *p +=3D len is uncapped. A malicious OSD can
> >    send len=3D0xffffffff, advancing p gigabytes past end and escaping
> >    the decode window entirely.
> >
> > Fix all three by replacing bare operations with their safe variants:
> >   ceph_decode_copy   -> ceph_decode_copy_safe
> >   *p +=3D sizeof(...)  -> ceph_decode_skip_n
> >   ceph_decode_32(p)  -> ceph_decode_32_safe
> >   *p +=3D len          -> ceph_decode_skip_n
> >
> > A new out_bad: label is added to return -EINVAL on any bounds
> > violation. -EINVAL is appropriate here: the data received from the OSD
> > is structurally malformed, which is an invalid argument to the decode
> > contract regardless of whether the caller or the wire is at fault.
> >
> > KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
> >
> >   [   26.183969] ceph_oob4_poc: buf=3Dffff888009e31000 end=3Dffff888009=
e31fa0
> >   [   26.186087] ceph_oob4_poc: struct_v=3D1 struct_len=3D0 p=3D=3Dend:=
 1
> >   [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past sla=
b boundary...
> >   [   26.187679] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b=
/0xff0 [ceph_oob4_poc]
> >   [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod=
/59
> >   [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G         =
  O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
> >   [   26.188236] Tainted: [O]=3DOOT_MODULE
> >   [   26.188236] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> >   [   26.188236] Call Trace:
> >   [   26.188236]  <TASK>
> >   [   26.188236]  dump_stack_lvl+0x4d/0x70
> >   [   26.188236]  print_report+0x170/0x4f3
> >   [   26.188236]  kasan_report+0xda/0x110
> >   [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
> >   [   26.188236]  do_one_initcall+0x9a/0x3a0
> >   [   26.188236]  do_init_module+0x27c/0x790
> >   [   26.188236]  load_module+0x4a9a/0x6350
> >   [   26.188236]  init_module_from_file+0x15c/0x180
> >   [   26.188236]  idempotent_init_module+0x21f/0x750
> >   [   26.188236]  __x64_sys_finit_module+0xba/0x120
> >   [   26.188236]  do_syscall_64+0xe2/0x570
> >   [   26.188236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >   [   26.188236]  </TASK>
> >   [   26.188236] The buggy address belongs to the object at ffff888009e=
31000
> >   [   26.188236]  which belongs to the cache kmalloc-4k of size 4096
> >   [   26.188236] The buggy address is located 0 bytes to the right of
> >   [   26.188236]  allocated 4000-byte region [ffff888009e31000, ffff888=
009e31fa0)
> >   [   26.188236]  ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc=
 fc fc fc fc
> >   [   26.188236]                                ^
> >   [   26.188236]  ffff888009e32000: fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc fc fc
> >   [   26.188236] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   [   26.255513] ceph_oob4_poc: len=3D0xcccccccc (OOB garbage from KASA=
N redzone)
> >
> >   0xCCCCCCCC is KASAN redzone poison, confirming the read landed in
> >   the slab redzone immediately past the 4000-byte allocation.
> >
> > Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
> > deployment can trigger this against any kernel client that issues the
> > lock.get_info class method (e.g. during RBD exclusive lock acquisition)
> > without any further privileges beyond OSD session establishment.
> >
> > Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> > ---
> > v3: Split ceph_decode_copy_safe call to fit 80-column limit,
> >     per Viacheslav Dubeyko's review of v2.
> > v2: Move inline comments above ceph_decode_skip_n calls, rename
> >     label bad -> out_bad, per Viacheslav Dubeyko's review.
> > ---
> >  net/ceph/cls_lock_client.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
> > index 4e6a6d3e4..79a449897 100644
> > --- a/net/ceph/cls_lock_client.c
> > +++ b/net/ceph/cls_lock_client.c
> > @@ -259,7 +259,8 @@ static int decode_locker(void **p, void *end, struc=
t ceph_locker *locker)
> >         if (ret)
> >                 return ret;
> >
> > -       ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
> > +       ceph_decode_copy_safe(p, end, &locker->id.name,
> > +                             sizeof(locker->id.name), out_bad);
> >         s =3D ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
> >         if (IS_ERR(s))
> >                 return PTR_ERR(s);
> > @@ -270,19 +271,23 @@ static int decode_locker(void **p, void *end, str=
uct ceph_locker *locker)
> >         if (ret)
> >                 return ret;
> >
> > -       *p +=3D sizeof(struct ceph_timespec); /* skip expiration */
> > +       /* skip expiration */
> > +       ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), out_ba=
d);
> >
> >         ret =3D ceph_decode_entity_addr(p, end, &locker->info.addr);
> >         if (ret)
> >                 return ret;
> >
> > -       len =3D ceph_decode_32(p);
> > -       *p +=3D len; /* skip description */
> > +       ceph_decode_32_safe(p, end, len, out_bad);
> > +       /* skip description */
> > +       ceph_decode_skip_n(p, end, len, out_bad);
> >
> >         dout("%s %s%llu cookie %s addr %s\n", __func__,
> >              ENTITY_NAME(locker->id.name), locker->id.cookie,
> >              ceph_pr_addr(&locker->info.addr));
> >         return 0;
> > +out_bad:
> > +       return -EINVAL;
> >  }
> >
> >  static int decode_lockers(void **p, void *end, u8 *type, char **tag,
> > --
> > 2.53.0
> >
