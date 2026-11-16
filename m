Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794824743;
	b=s0SQEkAO+/vRzP0E1B8tvx828YtPottJh0Dng0ZYfnp5J3EDxMWFjyiSpQcwlXjnV++C
	 4U1Tujz9IIfMZhk4iyLWOiluNH/myRXPqWfMW4cN692vPmWl3i6Tzy/zyv4gXTevMNk/d
	 dUndvySP0oABw/4RXfzbXcR5BzpnxODOGlm78XiOGVzMHgbsGMAMZP92KU6Scz3NVmubY
	 eNOnj6I5BVFMT8fr+aP+eObVfSitjx2j/kWqlsNBrM8HuIYb8scoVbt12FrwKTHnblD+v
	 F205D485qKfPir1MKaJNpp2wvdwQDVXJZB4zOWvs+Vasv1t8x4/bPZtghy7SM0VBMKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
	b=ZxJUxdGObIzXejHJmmNuTEZ4XMLkRMLOlgIXMprhSsLlXS4QO/hdiPBWsTWD6coWE0T9
	 aQzILjmqYmN1q/Ippe4T0XFw8TFtgtIEytw0ywiAEdwxmftZD/Yn7oPmKzIdjiMc8GIm3
	 psJxZnXsWYSitRJx4Bgokm7/Cz8pxOGmWtsvoZNkFxFCD3TrMEB+NEodpdk1hTlqxJqmV
	 zswMvF+/vkbEVWTDir9SUMyEm/6ZK8cCkhZ3xjworfOHJBreQzDS8umsPOhJ7bsWqIAOl
	 OXpiXSnAtuMLyeNICKJ2DvvpCmQRD4J7/5NC5UC8XLTFEE1L5r+LXGnNwsRAD62YDYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoxpA8a5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A259606A333
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A259606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoxpA8a5
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b7efd3bc26so1639695a12.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794824741; cv=none;
        d=google.com; s=arc-20260327;
        b=Qv4azYhBWFhNWIYM1e1+H3eI+o+9kX58LtLU5rmPSikQfKPCZZNeFglR+0SHueE0GY
         7l8+qrEZ5LEdZzFCE767/f5J6Pu/DsrCtsjTZx49QuwxFTVwYiYzXOvAvnnBBkHcmI9y
         ohW7riOFspktADci15c/xfNc6Cm+Wcuzosy2HRUn0yip4uenKaWuWMg5gxJybVmEOdMP
         rThPaTHLHAKBmpJsn8oIJvjlNHFV8dm2WjROdq+FWabk8wDVhweLqP4FE1KK6N5DSsKK
         0xn2s5FeTtbOoF2NLVooePr5J/8hLoDztuQftRLNSapQXTOsmTM00xa1NwE+nHdA2Acy
         F+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
        fh=2b5hPJH+fvagjzZKN0g4qIKRYcGm4+ilTa+pk2aTba8=;
        b=RfmHhhWuBQlk2PkrGflnizu9ntis2MKQu6umC9XI2k9UsnQzz2K+pBV/fzFp44Puv8
         /8fu8XgiL5xLyCZW7XVmFpzgswoqC3Ro69YjpX/LRQj7XASqSkE3ZswRIqp2ledkyidR
         yQNYce5Ht7hg5b3ZxEITUaFmZJyQMCmhak5nh7tVkB9IIhS4GmsBZxUiOuN3dIRIlahS
         YTSLlCICgjLb9NOU/kRKfmh1spRT3pWtWdaESS1C4K0zRfeggKG0Azwyjuw08tPpQzn9
         xlTVyw4l8PaqOO/oBLHhJNwwHS19sYzDMq0CgD76Zz19o33ItXEamc7ZrTtBZBVJOBAY
         xfnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824741; x=1795429541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
        b=FoxpA8a5gWZOiOu4kERAMuUcjyr54gqPoKqiCFVaESBeI/u9TZiW1xZ/8iGXSeL3Ru
         wggr7cd49XGc3Nzx9fjFQIzsVPlWqwNb/33jZlPsYOLZl9dBJczNhPUF9HTIZ3+Sq2DL
         HgpJEHIaYVeehKTXuwao+M7tue+uYok+bSoKtMvnZ5q2JhxF1YJGNEIyjjhAMWVM/k2r
         A7liHN/ZMi28w7H+f9Am4XfgAPAwWkrkdyk0qm/IIwAEOLKwHVBWyQ0GoCjPXrJsVgVn
         jcUnTibHbnEUKqt0uWhMgZLL/kfLxFZVkPj5NQhU8tT0FPGJSUD4UjZqKzOqU/uj6cub
         Zl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824741; x=1795429541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GcZLw9WZbtrok71apo+O/eYnzOL1rHeQ56wrw50NMY=;
        b=EguJrZec1DDVYRdGl0OWJbRG83d3kIiU/idGwsjY7/SAU5/o93X/Xy/NVyQwi/EpqX
         0N7VXY5cA2O8JK5eHTPBnbKsf/6Bn9SE0k4vQNVJGYECHu9LzVuly+UTJZHfB/GOSBoh
         K5iLdW8piiFNU2j/0x+1pbSPletJecT6SetcvsbAagG+AoyojTTayozahliv97RuH92e
         sMDqoxZXoERbzN54orR5rxIKJv7RAbF/6W4cCjrI+hLqJX3YPBVVA6mZldT/CPnzXOh9
         rrSiwVNdkGr4vt1Jhj9NRIzDh+3nP9zvx9P9yvEQwPn6YI4xArDZwvK3gJYLJ7AgDY9S
         uLXQ==
X-Forwarded-Encrypted: i=1; AL+hErGt6Ycyf8Pl510wYfReXEGSLfnHI43qHbyFSEqTN9LTBtlSA+cpuqDL0ZsKat0ImUtW6F+aGX4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NQJWsvRgMGESyCJD+hYIIGshh22ECD5eb3XrE3/MQjBAyHSBG
	pS4VAS/geDncMBgf6EN0zdEA3lvj/4CF7Xxoudso9frPD2Bp0cEg3iB2mAjZhJdc6vXBe0RIlRi
	RA+oBt5ATrjYTPqstQ44OcVGGMPAvLVw=
X-Gm-Gg: AYBFou0f6IKxB/VpDhnoF5M/CxGJpGUWIuJy0rmSM1NKC27xgLozrAl2unTSarPG8bv
	qW3EamovZqbnxR/+4GA6pHv0VoTXPc3VBwl1MgTh1hGL3fJZtkHJMcjB/AlK/btkAt3o+AlH8YZ
	KTTxOEDLVfXondw5G+w7BM916qtZLpycVvuZqbWeG4N0pnvEvCdEp43wEvQE9Y/I0iF665Eyl9M
	KJpemwlytcnetZvrwLdDjvh3GvWtvuixfdFg55YaDJN7lBKbBbOVLF5Bkx/0HE0ZGCK5BHV9pbc
	W70vFY604zCSmZPPShD5QMXedPx6+IdFHj58+wfWGRF1lwvN1JRCfwCEy26OJq8dtYFoukoj+eu
	77bzh8nkvix8g80cmcIwmBYkvr+6UWB7ehN1kn6D6zSL3tj28+Qq46jjNzrS1Z/8bw8ut4fY=
X-Received: by 2002:a05:6402:44d4:b0:6b5:79f4:8d52 with SMTP id
 4fb4d7f45d1cf-6b7c0bdfec5mr5191329a12.20.1794824740409; Mon, 16 Nov 2026
 02:25:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com> <20261115210952.2140036-2-graypanda.inzag@gmail.com>
In-Reply-To: <20261115210952.2140036-2-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:25:28 +0100
X-Gm-Features: AclHuK_tvQFpSUcAQinoG9gfJrRW-rTLlA06tTqM7lEBJqVuldEYzXKf_TrLdL0
Message-ID: <CAOQ4uxhZS1w24GXWphu-PNPbGxVJUDwOfqHdRZcb05+_HVv=aA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: reject embedded NULs in readdir entry names
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Junyoung Jang
<graypanda.inzag@gmail.com> wrote:
>
> parse_dirfile() and parse_dirplusfile() reject '/' in dirent->name, but
> do not check for embedded NUL bytes.
>
> Unlike plain getdents() buffers covered by verify_dirent_name() in
> fs/readdir.c, FUSE READDIRPLUS passes dirent->namelen directly to
> QSTR_INIT() in fuse_direntplus_link() and instantiates or aliases live
> dentries via d_splice_alias(). A dirent name containing an embedded NUL
> produces a dentry whose d_name.len extends past the NUL terminator,
> which allows callers such as inotify to copy uninitialized kernel slab
> memory past the NUL byte to userspace.
>
> Reject dirent names containing NUL alongside '/' in the FUSE readdir
> parsers.

My concern is that there are innocent buggy servers that pass NUL
maybe even because of length including the terminating NUL.

It would be more considerate to make this check in fuse_direntplus_link()
rather than to fail the readdir.

See precedent in:
78d04af4995a1 NFS: nfs_prime_dcache must validate the filename

Also, verify_dirent_name() never checks for embedded NUL, so all the
other filesystems can get away with this without failing readdir.

Thanks,
Amir.

>
> Fixes: 0b05b18381ee ("fuse: implement NFS-like readdirplus support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
>  fs/fuse/readdir.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 1f6cf565477f..e8b47c2a9103 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -126,6 +126,12 @@ static bool fuse_emit(struct file *file, struct dir_=
context *ctx,
>                         dirent->type | FILLDIR_FLAG_NOINTR);
>  }
>
> +static bool fuse_invalid_dirent_name(const struct fuse_dirent *dirent)
> +{
> +       return memchr(dirent->name, '/', dirent->namelen) ||
> +              memchr(dirent->name, '\0', dirent->namelen);
> +}
> +
>  static int parse_dirfile(char *buf, size_t nbytes, struct file *file,
>                          struct dir_context *ctx)
>  {
> @@ -136,7 +142,7 @@ static int parse_dirfile(char *buf, size_t nbytes, st=
ruct file *file,
>                         return -EIO;
>                 if (reclen > nbytes)
>                         break;
> -               if (memchr(dirent->name, '/', dirent->namelen) !=3D NULL)
> +               if (fuse_invalid_dirent_name(dirent))
>                         return -EIO;
>
>                 if (!fuse_emit(file, ctx, dirent))
> @@ -307,7 +313,7 @@ static int parse_dirplusfile(char *buf, size_t nbytes=
, struct file *file,
>                         return -EIO;
>                 if (reclen > nbytes)
>                         break;
> -               if (memchr(dirent->name, '/', dirent->namelen) !=3D NULL)
> +               if (fuse_invalid_dirent_name(dirent))
>                         return -EIO;
>
>                 if (!over) {
> @@ -461,7 +467,7 @@ static enum fuse_parse_result fuse_parse_cache(struct=
 fuse_file *ff,
>                         return FOUND_ERR;
>                 if (WARN_ON(reclen > nbytes))
>                         return FOUND_ERR;
> -               if (WARN_ON(memchr(dirent->name, '/', dirent->namelen) !=
=3D NULL))
> +               if (WARN_ON(fuse_invalid_dirent_name(dirent)))
>                         return FOUND_ERR;
>
>                 if (ff->readdir.pos =3D=3D ctx->pos) {
> --
> 2.43.0
