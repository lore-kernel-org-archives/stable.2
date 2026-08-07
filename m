Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4B35200B
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126440; cv=pass; b=P/f/HPDkhoSu7QRjs47F0TItObcVpXe2O+P8fvxzuQdAWWFFx+zau/wxQxHH/7svj5HIaw5hVho9hPpfxFTpFv4H1YNJsrdpDAUJHcyvQd2y17+yIkpM6qm7QpKJzhFxKMC2bpUXxqbrLNY7fmQbN3KRscMzjGQEcOaYkipL6z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126440; c=relaxed/simple;
	bh=K3Xuf0R4IM+Zbo4XXVROPT6Z2IDLZipVyLye6XobMiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/Q1+EHtQGW2skFS6QoabylR/7WmOt4jb2fnjmwHGl9snNDzsFBW5V3B2dYX2W6ieNCGC/wisOjncO2oNE26jZFm3cesZYWwLNlVaHs4C10DozZ/vBKpLxVvQ6EmghnQMZMvy5ByQyCix3hYyRg7Ff/pGEQn2h+Rb2zuqe7GC0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnmoyMzW; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnmoyMzW"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-74ad03fa605so1910323137.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 11:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786126437; cv=none;
        d=google.com; s=arc-20260327;
        b=i/VGLyPNuoZ9NPEv8fsb9QxyNWVFV/802uvScYQli5ohs9TOwzLRpvuu2uQdnpJpbF
         u7pN2OQQpHboqjHJ+BKHrns4UvpHFAAC3n7I7a7kLXqnvVX0wPO/cD2pfrXAvLd5Te3a
         5I7iwN3Q0C2xyB9i8fEg9ECQLa8OQShrb0Itdc4pcO5XBJbRMMr98SmwoFWHkCcTpjsa
         DqZaydhNEZhrfE6vhJjBwVb2evQqAm+JZud4N45s94pEtqJWbn6bBfuhko8OwmC+kxXN
         sWnwDoSdv6DK01Hv7jQAbgccDy4TjL6pQG50M56VU0/2NvBrXO1g6LM2JN5hsOFNwcSo
         fEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgI6+3KvWcvXEIakyf/wGqB9TCKQvRkK///h7uD9yMM=;
        fh=EX0JApOOjGieIMnh1OCa+ZlBHRTD/EBjDBm3ydigiAY=;
        b=Y+rzqK//AEO1nwAUVg8QrbE+IKSq2cwGpmRrUGSQ4C1J3yOMWYhuZdQdKSiyxMFbpo
         M29wbMJXY3jcsTflplgRc3E5Om3xx+x/dYKmZVPfgMnANldPw4QfPJbWrOami1S0EgAd
         uFE7w9LRkqDBJ4dNnyTh6uRuH7+L38Jq2m8tnkKN1CBVv5LYUznXDpuSjKPcvZcdl6W0
         Evtt27nL1p5u2jRhLy2gO7Ypae4lTpO7rQmBAkF5DJqNl7yDIIMXmD8sXMK/uPeByLVM
         ukm69Qg0j9IsH1fureFS5Ebb33UCTq4n+pc7KkAo1GPOH7oTcA1r5D40XJ2KSRODq9WQ
         HuEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786126437; x=1786731237; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgI6+3KvWcvXEIakyf/wGqB9TCKQvRkK///h7uD9yMM=;
        b=WnmoyMzWba4poxUVruEJ+D1IobNEGN0K/4akehXk5m9BqgN2CO01QABrJv1l3n2OFj
         dJqO85xLp9bCK2LeepIQoETrGHOP+Q2BtxnMyDFvqVK2yFrwWMzkqirDgZ3iwAU3MmaI
         hYbF9toVcWoO7gWgwnf5VAyJiDdSKUKDIUT5tl+PS7czKU8xD5Omi0CKDEDZKeSSjSsS
         adTvHfQZr+u8UUEDSreBCYms0mSNdZ5j0CmNYoXm8Bit1J+g1NixSAE8/KJ7Km7HWbZV
         D72SB9uPMz8meIXkIyLuMe6pyHfDSXKuBllhGgxWWtDKWdrCZBJtpSxUKDfnwV3l2W6A
         r3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126437; x=1786731237;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgI6+3KvWcvXEIakyf/wGqB9TCKQvRkK///h7uD9yMM=;
        b=XTKdfCKYZlRVpyiwFVSR47ylhxuQQ5ceLYYJTPnSZ0Vd5TkXI+i7xiJWRMZB/P6n/f
         W1FzJZP2sXdmyQy/8nP1sy44QqZ1PsLvKXfQ7lHlKC+yNQ2ExEPPeD+Ule+0TQ8vLjAx
         A39T48+ZhrJDt/W2cllkeN7EssJebc3t+dJHfz/TQ3URW56H8p+NXDMHb2u49nxz4L7x
         2aq//GD64r3qleolhOxqw/brzdxGgG4B/dGgLnux/QLy3KF4u1QVu7lE9W2D6NVvkGTt
         eiI/QAHvwWb/fA+z/QnlugaLaHysYWkAaCtqp77fQo8QErbsnkuBWZG9VbtR5QrjloyP
         dUow==
X-Forwarded-Encrypted: i=1; AHgh+RpjcjixC9qAuQgV/qQ5Z4DjQWBYSBd2V55iD/5kzy6G+TKoYY+LoqmwkXPcyYIIG7umjDvPXco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKRQROYl6xBK+FSa/u24y+2nVUOMdKjthi2OZFlWBQ0k7WSbw
	bKHbd0KHm8HggwBQhxFOzp71EjjmpQ4AhWlNCF2mi2dYMOow/0kmSo6aUMYi4tvH5kG+qN3PGCQ
	5SmgeDQ2T/R0WFJA+gYaBP7NrsHBpr9uBEk/0
X-Gm-Gg: AR+sD13Cd5gANOkraVOoZvsrhAQgSi1CtPVSuaOe2+H5ht+uw65PD1IdixuHLria+ip
	/W4RzIww3KZjuLJWl6aFnTqI1uBuJUKNNCUaNYtQCBrz88DBNmGu6oAfkJklRQjwm5cByvq+tCN
	ULJkqoirAaC+LdUnl7nmXnhyZpzK5OEwvkrUhqbSaciIdjfCZaHLEfOvLl2zAxMRiql4O41AqVj
	ep8KrdgSsl8If/pR6cBwl3vPwS5pUSgb+ulmU/lsg3U7nIpw3mE5INvMTzfax0gMdBtHuSVHGEl
	FyGQheKxgXqmLxy3RP7eHVG5tHOFO6uCCumFbdTX2cPYhnUMNXYjfYlD5VgGRgEDbDgl6YuQmOK
	V4w==
X-Received: by 2002:a05:6102:4bcd:b0:74a:b492:3a62 with SMTP id
 ada2fe7eead31-760e7cf60a9mr9067303137.4.1786126436709; Fri, 07 Aug 2026
 11:13:56 -0700 (PDT)
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
Date: Fri, 7 Aug 2026 20:13:44 +0200
X-Gm-Features: AUfX_myaOVIROm8ifzt-g7-Tn9KOW2aJbXRe1sRMeX-CyhuzEZwrcqkF_L5RqaY
Message-ID: <CAOi1vP_4FW-j=UNw0HGUpuK2+7gY8W1bSexu4-92bikYvxoXwg@mail.gmail.com>
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

Sorry, no need to resend.  Slava forgot to add this patch to our
integration branch like he did another similar patch of yours which
is already upstream -- "libceph: fix two unsafe bare decodes in
decode_lockers()".  I'll eventually scrub the list and pick up anything
that was missed this way, at this point likely into 7.3.

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
