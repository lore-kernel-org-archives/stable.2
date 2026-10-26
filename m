Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007144;
	b=gIumt67hdQMBmJd37gCd2PlHPW/VWSUk0vLnQZuw4aZ/cjmMyPEBfJkJT6dfiIHcFpqP
	 LP/ycLINh6YULIRPbNG86P/MAuBgfsRgQyylOyCnGX2iT7LTP/97x0n17OUetZCyPTKFQ
	 uX06CKJpgojIDVzzN1exmZE7UvNVuadP5Z/8JouivlVPFttehoLfGGuTLFsQVoAKtOudj
	 nzyU4vGERpBWrT6hFTJ7guERV8mpD0w1ZM0jmALRyGznBYJ5HbYcBGgUg8nKdW8oDDCW2
	 5GXYY/DescYpR33rvu/N88TeWngHiRwVFcftgdlFTPAeD1yEMY6keX6YksEpIWlWmjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
	b=dKaJKus45USxb5G+7ysKK8kZG3DtBkYDz2lsEL42JL2G/CBXOxgBsfRA+WgYP5htMx6w
	 N6T0MlYXHyc1qG70/jV5GRGsDGucw2eBFVRC2ZlJCDkvkDPLNd7qufStThe1bNVWerV5S
	 pIsmR6vykHvm/PW/4qVwfkoYin+bvWbQ2D56fWhUl4fCl8XhVO3pesGuHImuIlA0wxA89
	 ZHBrOsPTcxBemMIRkNV9WJvsuQp8l4EGuYj7gAbL4VMN556UDoGY8q/Mnco06rdRMfZbQ
	 jyEqy5itR8+M3pvnxPXWS/5u79MaW+mfnISklvv9rsTAwb+XpY9wow+RGebkglrGteg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJgZ1kRT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0527606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 09:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0527606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jJgZ1kRT
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3598165a12.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007142; cv=none;
        d=google.com; s=arc-20260327;
        b=b+3N5grGtDxmIpizgudsAZSMEuVnxVi3fjBMQCtM6bRb6+nMiiK7FLLzpQ+KJyi0xe
         ODFHJNgCNzHypAc3MyuGqr8EoM0b/UEuyA66pHO0IDm/EkZ1UMRFM9aYQCGQOzu29e9V
         2spWXZnYH9Jara9gTiW390Gqm90i5i/MsfxcS9pv8yJNcYo+aUCRJihjX8lOZ3waELw3
         g2alnaLMMKHsZWlQRcf2L6lMOthTh/ioBrpGNUZgODd+AeCFYBntuUPkSNJZh4rPlLCJ
         1v9exq+NndSxhRWFLW0RNSZ9Fc3zcUkFWx/jCTAXc8ycW6rBTos+LNaal4wz2L9hBIex
         2sKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
        fh=J/IDY19Jz9+lBT2tlJDd6Ere+BzhjH+CpNWDdN0CuVc=;
        b=rnXiyYdpoAOs2ZYNsgJcn6CDHuBE/mqDTscOB2osIA7CfFi9p2Mz7LRS9s6LfTdMbq
         Cs6fdv/pdmU4Yp3oLlsiUYVxheqOYE2pVSvFQNcHNIr6fg7P18JugSGjWAyzJet5eIEq
         NND/SSWtNrMN4qONPS55aHJ39rO4GpVxRr/fVHkj0PX8AyG8QcToliN58DxV4tnHlg+j
         4JIR9jjlnxwX5dqvX84KFJ62OFqUgqJOFIpX/ThAvf+3TEm7zPY71XPHsy1lYxERaizt
         aV7Tt8A1iuc1jhsTdSSS8xXCAZgD0s7mYtNoj4T9L1g0TTxK76yhoczbriztVNzTtq4o
         9ghA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793007142; x=1793611942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
        b=jJgZ1kRTnuHOfldZYkyTH7Q7gInsSNyGbuCrnkEaHqjGU+VEafB1g6eX0BhRsyA26h
         k9t9loRX2tqzrB67q32zXLg2ywkofxQa2Ee3xXwnj8CAcr1J6eskhZ+H+zhsNQzP5Q5H
         FyarA3x4ZYdySiwD1GinjcyzHt7LsXxfaYgLLKqX6iQxFx4lD9CcFYC5e7NAoEoCYaTT
         mN2wjFzP7BNoREeHxvonn9fZeN0FPKjAPCTbFc46ZCt+/p03GLv1K1Hjzy4+DNvKBIl3
         3hbaoGRy7A5EjdV2igBOGhFgsyTh3RfLOHjFt+QFFckflFF+d9TWjVow5YoWI+Hf3HNC
         JPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007142; x=1793611942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ecBvG4CyxdXuobVHi4VrXk03Jx/FAmyBpo68trKAaEw=;
        b=Ed1+IgpyqR18P6uAgSXUhHOpOy1ZKQjkgKjLZBCzFMg0bqPH5md4U5t76MwfCAZaKy
         jUSU3PFHyN/b5SdSDH268X65JNhOQ8HSwuirgwSATcfQ2oCHKSel/xulZI1QBa9HXId3
         FITA3AHdFEEfkiLKcEs2LEq6suigJ7SL8TjerUmnaGfAdLwi0PpsidpUOb/xRWg7/uMQ
         4bX/dNOE/0+vGR1ZCoMGFbbtDfLk2v3ayFKYtb+iP80Uhr8IXyynp2Y3PsL4OT9dHVj7
         CtUHoCGRmWXOu5sTDOPTCq/J87dFuzWWnnMN7sn3LXIDfacce7LxiP9HlM/qebwrDKHZ
         wn+g==
X-Forwarded-Encrypted: i=1; AKwUvBwZHF8Km3XUOqsMeA0ynCIWYQypkMjyMm6zPGEZdNuk4IVlH8117U84cRUBukDxaDouomjn17M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIRHr2I8pxHiAaG1Zsa1cmd40e3cc1LaDE2M/hSw9CdBb+d0mq
	jPX+Cxx6S69ePtDaW74VG6ynSCNaJiY503JsAOIyRIFXxEfHjIKSk77J+Q4xAYnISuJIFX0rdAf
	I7OX1YMaS0swl14aJqGM5ODBvDcWn/qU=
X-Gm-Gg: AYBFou3+F+zH1i1M3QS/v6WarH6IZC2zQyug3A31IZ5w6/u8CVEDUZu+c724pEXIcil
	L7rRfjL0zPY0ikXIYX+FKENrufF5tB85VYdkU0OqSk/baYNtWwkj8xsWFZ9jETSimBJoDfHt8oh
	t5PqbsBgDKgbMYwrd7Bxr+0Tro5iUvgYEeZIdsYksuHFO2lDw8Yr6bHjPra9sHrD8EhC4o99QPq
	nJ+N0yFdyCjLfz+Et/QofnzuyLOtKS3zf3oCOK69JF3LHtIwlU+APisUGc1J+kWEx1gvQYcmqYA
	LyeEnA8w3rFXVAyPDvhlATVPKWg2uMmcxotFZm0klvglld8SxiqWp6wgsEdnyF7dO8vO4aXYGC6
	nyQPYXgHWFL/CyigZ4xhaieicgK30Nr28nHNnwzUZsHgl31gkK/E+kBZ1+4VhrvGUe2+FfEZtC0
	0P9CwqRE/FKrTreyY=
X-Received: by 2002:a05:6402:a515:10b0:6b4:2fc3:7d85 with SMTP id
 4fb4d7f45d1cf-6b442fe9a23mr5162442a12.26.1793007141857; Mon, 26 Oct 2026
 02:32:21 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025232251.58252-1-dennylin0707@gmail.com>
In-Reply-To: <20261025232251.58252-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 Oct 2026 11:32:10 +0200
X-Gm-Features: AclHuK9HrNxGfGq3Xk8d9bF60_YyoNgGHS0nIQi_8ycsJWClOpl0dBjTH6NbKO0
Message-ID: <CAOQ4uxifE0G4r=cpevTB4mzq+HhGdVsNhddzFNuH=BN9YrD6Ag@mail.gmail.com>
Subject: Re: [PATCH] inotify: do not coalesce events with different rename cookies
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 1:23=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> inotify compares the mask, watch descriptor and name when coalescing
> adjacent unread events, but ignores their rename cookies. Distinct
> renames can therefore lose an event even with IN_ALL_EVENTS.

oops. Somehow I remembered that we never merge MOVE events.
Maybe that's even a simpler check. IDK.

>
> For example, prepare two files in an unwatched staging directory and
> rename each onto the same pathname in a watched destination directory
> before reading the events. Only the first IN_MOVED_TO event is retained,
> although the two renames have different cookies.

Thing is, the "wrong" rename TO cookie is meaningless without the FROM pair=
.
If the second source has a FROM, then the two TO won't merge.
Could you really reproduce this case?

> Similarly, coalescing
> distinct IN_MOVED_FROM events can discard the cookie needed to match a
> subsequent IN_MOVED_TO event.

THIS looks like a case that can be reproduced.
Can you provide an inotify LTP test for this case please.

>
> The original inotify implementation compared cookies before coalescing.
> The fsnotify conversion lost this comparison. Compare sync_cookie as well
> to preserve distinct rename events, while retaining coalescing for
> ordinary events with zero cookies.
>
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/notify/inotify/inotify_fsnotify.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 7c326ec2e8a8..6456d9c0e408 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -40,6 +40,7 @@ static bool event_compare(struct fsnotify_event *old_fs=
n,
>                 return false;
>         if ((old->mask =3D=3D new->mask) &&
>             (old->wd =3D=3D new->wd) &&
> +           (old->sync_cookie =3D=3D new->sync_cookie) &&
>             (old->name_len =3D=3D new->name_len) &&
>             (!old->name_len || !strcmp(old->name, new->name)))
>                 return true;
> --
> 2.43.0
>

Practically, this means that MOVED events can never be merged,
so a slightly cheaper and simpler test would be
if ((old->mask =3D=3D new->mask) && (old->mask & INOTIFY_MERGEABLE_EVENTS) =
&& ...

Thanks,
Amir.
