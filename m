Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700570;
	b=UOih+P5xV4tZU91AkIrf/IHNV7HS0rWjcRPFv3aD+F2QbQ3NPrp9IAK1sgWc2t9v79YV
	 sslAAlZQMkyEAGQgvO2ScieDSV9GKzEF7bWQx0DrAog+zXWg+TltMJoeZ/XG3JFHshOZM
	 Vch4yw9jyR21CV96RJg5bUJtEySRtjCzaRAIvODA9FebJi4Qzhn9V/XRoXVo/fjGEjwSM
	 TAKq95I+uUeSfGBfCaGIdGSjKubNM8u6A1yejps7sVf5HCAkUeSBx55bpVrdor4dFwz7G
	 POMcKuc1XZUM7tiLm4ccTA8ooi5fJ4jfGfnelXpzDrIJt/rDK9qnsWZZW5Xi1fLxhgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6+OZ7UAj4wpyLIvTVHWqEA215IR1A8qQvTEaOHFShS4=;
	b=h6bZpIY+1+7ZdSH0GPJOdAew41KI/fuKC9XqP/s95UN0joTJ/jqyKraHjV+JV2TLzNyt
	 3vbgpZn1k36mCdhyS7K7fFtD/MBkd40+n0Bzz+FcTT9Sugf6iwnrLE3yif/T76WxMSNAw
	 1XRUPja/gIda6NXqXjcvyPQg+Ov32kG9Zw3TCAzwZ9Y8C6B/2BXifCnIsjZVIsIIZRJmZ
	 tSUYwGBT62bxgc6uUQ3YwQm7DmLo1ib35OP1342rKzmh7NyIT4BdKZqOCej1f+069HtEf
	 jbDfYqtA7jM+y9DCR2jGobzbVLDdQsfadVoxqrdGVo5/vlcWx17yTGGjFu+i8TQSquw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="LX/PbAP3";
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7891606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 20:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7891606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=LX/PbAP3
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8ac9d666d4eso2383517b3.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792700569; x=1793305369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+OZ7UAj4wpyLIvTVHWqEA215IR1A8qQvTEaOHFShS4=;
        b=LX/PbAP3SVuSBH9kbpXY0xPdGlqMqb9hUY2i/eVrUHvo3AcBCIjUXvpkN7qNFuEUkr
         IMaSW6GIzwyYRoM26Eot6lV+mYkFX2IuQYXc5XA7qVqnyKO/PRNtI2qD4+8h3vUl7mgy
         P+snby1i4L73rC75zcNABoO4L/fcZDb0n8LmliR9IH1LUnjYxyZ/d2AwP0fmlMHS52hF
         /vrIwBii/xYYYsz9D4A03iWhrSJMERu4FLL5tDehyr9tza6Hlykp4tDWhgZOJspflkMY
         kB1G8Mm/JSqUSN2hj6p/w6SCHo//aJzhqBb7k9G7u7Mtyz9BP3iAVGUxsu5OPo0ydvt4
         F35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700569; x=1793305369;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6+OZ7UAj4wpyLIvTVHWqEA215IR1A8qQvTEaOHFShS4=;
        b=d8un5xpL7miaOpI+ixAN4yckyCcpp2Raho0H9LVrzhgy93/rR20Pxu9W8cnaWVmHd7
         oKdGakVg5GBbZAeQAZ9WOPn6AjkokOGt+M5OOJ9NFIuNtfjIKjOCqnucAQBeBW5XZBMG
         ucjA2I/ZP+GsvMcGA3z/p+svdRpdCKFf3MALcVvSaWGIhWh845kjzEoOfEt+LzTpaUp4
         DSQ8I33tsVfVlYqs3biw654PkeHgluZ+CYxJwKU/rYoxCsPMcXMHC2+qVZNzc1K/EpmI
         VsSHEcqI1MOX/mvjdPYmdwVvFhRGPCnwRqpwMPjlH5dymekbkv1smn1qwaHme+8wdEfr
         V0YQ==
X-Forwarded-Encrypted: i=1; AKwUvBxj03PXkuiAYeirITCIaxYOVL9qqbp+xKyBYmitoqzGYiBeYVazU5HbQffp5ECXgmN9RILbcqU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBG4RbLbMWJiI2bBugRaqIPz7YpVGrDAaW//oFU1KqM1fVJxvR
	gbLScwGfLUJ2uCkM/qRyUBq9EJ00Lor9PqcJZAFFHu9vrFxnGG9L2QYorGqbvQXAIPnR73VxMpA
	r6MIEo6o=
X-Gm-Gg: AYBFou1vdlI64+dVWcJQHEfGTOjB7J2/OHG+47wnqWTxUbW84MC7AwYwrulayvJdu2H
	dwtqVeZIXCHCtP0Wtj45jjqMZVtgV0/N4KXdh8Ddv2Ow1zrAqVsE9UeUmyUNGjIS4AC6r3Q5h41
	IMZ0hYINs7aUgqt88OMTG5mhAHl8zKxCtpuJBj9O2SYnDd6odOothbdfPFxJU4sfh10ljt/z8nI
	HrkzLKwoHe9rFo+0HJ37E2/kO5w8r0mX8yK8T9W6Yyub5q0g4Cq3aP1/l3jcqW+QFqRKES+UfJZ
	hkMJlTU3AwX1bElkVxtSIE6nB/v0CShuGoX1k57o99a+I8fP0QqwWTqeio6N5cagBaiMwMaQ1I4
	eQYZy4IYw0gZHzrd8leHSsbzYlqKaIir9G4W0o+6Z2QK98eaP80N+QOGHVMTWlRv67xTT0njogQ
	/Otc1SOcmFB8OfKKACmsvbEUeujfXoYgX4uggK3JGy4AFWoUFDkGW3Npcf16LniUNl+Pfn7vsAG
	RbsKxCKGQ4trgiCio0TknONBgYgct9C6Q3ojckaEPUgPNnVyCPsaO1BUwz6Krm7MHTWJGR3AHRZ
	p0m+wFCxlFhTuwCircNzn7w3a1p55OrnREW0pAsD43L2wRmHYCK7DPRH5+UDgYJvmVyR+T7Tr20
	vOkCaz6nSE/HDVRRrGJbRdqSerSpdwWkPgkDlekgtB7jbkQ==
X-Received: by 2002:a05:690c:60c7:b0:8af:e4ee:a91c with SMTP id 00721157ae682-8b157dd761cmr909137b3.41.1792700568859;
        Thu, 22 Oct 2026 13:22:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:d350:a0e4:db9b:3217? ([2600:1700:6476:1430:d350:a0e4:db9b:3217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1561e365fsm3568247b3.45.2026.10.22.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:22:48 -0700 (PDT)
Message-ID: <4d28ca686fee764bb0eb3710f390a6f5fc9c0d4a.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: fix truncated xattr names in listxattr()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, kees@kernel.org, 
	justinstitt@google.com, maurycy@maurycy.com, linux-fsdevel@vger.kernel.org,
 	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 22 Oct 2026 13:22:46 -0700
In-Reply-To: <20261022111700.1288273-1-hengyul@cs.unc.edu>
References: <20261022111700.1288273-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 07:17 -0400, Hengyu Liang wrote:
> From: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
>=20
> Commit 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use
> strncpy")
> made copy_name() build names in the osx. namespace with scnprintf().
>=20
> However, the size passed to scnprintf() leaves no room for the
> terminating NUL, so the last character of the name is dropped. As of
> now, listxattr() returns every osx. name without its last character,
> and these names cannot be passed back to getxattr().

Yeah, I see the point now. Thanks for clear explanation. The main=20
point that scnprintf() expects buffer size that includes terminating
NUL too.

>=20
> The issue can be reproduced with:
>=20
> =C2=A0=C2=A0=C2=A0 truncate -s 64M hfs.img
> =C2=A0=C2=A0=C2=A0 mkfs.hfsplus hfs.img
> =C2=A0=C2=A0=C2=A0 mount -o loop hfs.img /mnt
> =C2=A0=C2=A0=C2=A0 touch /mnt/file
> =C2=A0=C2=A0=C2=A0 setfattr -n osx.test -v 1 /mnt/file
> =C2=A0=C2=A0=C2=A0 getfattr -m - /mnt/file
>=20
> Without this patch, getfattr lists "osx.com.apple.FinderInf" and
> "osx.tes". With this patch, it lists "osx.com.apple.FinderInfo" and
> "osx.test".
>=20
> This patch adds room for the NUL to the size passed to scnprintf().

Usually, "This patch" is not good idea to use. :) It will be better
another way: "Add room for the NUL to the size passed to scnprintf()".

>=20
> Fixes: 7dcbf17e3f91 ("hfsplus: refactor copy_name to not use
> strncpy")
> Cc: stable@vger.kernel.org=C2=A0# v6.10+
> Signed-off-by: Maurycy Pawlowski-Wieronski <maurycy@maurycy.com>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Changes in v2:
> - Rewrite the commit message. No code change.
> - v1:
> https://lore.kernel.org/r/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378=
c@maurycy.com
>=20
> Maurycy, v1 got no follow-up, so I am resending it as Viacheslav
> asked
> in the thread below, with you kept as the author. Let me know if you
> would rather send it yourself.
> https://lore.kernel.org/r/dc187921249a3f6716b829624853e64c10321cd1.camel@=
dubeyko.com
>=20
> Answers to the questions on v1:
> - generic/377 passes with and without this patch. It only uses user.
> =C2=A0 names, which go through the strscpy() branch. That branch already
> =C2=A0 passes name_len + 1. No xfstests test uses osx. names.
> - Why + 1 helps: the prefix and the name are name_len +
> =C2=A0 XATTR_MAC_OSX_PREFIX_LEN characters long, and scnprintf() writes a=
t
> =C2=A0 most size - 1 characters before the NUL. Zeroing the buffer first
> =C2=A0 does not help, as the last character is never written.
> - Why the write stays in bounds: both callers check that the buffer
> =C2=A0 has room for name_len() bytes, which covers the prefix, the name
> and
> =C2=A0 the NUL, before calling copy_name(). This is also the number of
> bytes
> =C2=A0 copy_name() wrote before commit 7dcbf17e3f91.
> - All xfstests: see the full run below.
>=20
> Tested in KVM with KASAN on a804c5742bff, without and with this
> patch:
> - The commands above, and a C test that compares listxattr() with the
> =C2=A0 names set on files and a directory: short, long (up to 127
> =C2=A0 characters) and non-ASCII osx. names, FinderInfo, and user. and
> =C2=A0 trusted. names. Without the patch, every osx. name loses its last
> =C2=A0 character, fewer bytes are copied than the size query returns, a
> =C2=A0 buffer one byte short does not get -ERANGE, and getxattr() fails o=
n
> =C2=A0 the listed osx. names. With it, the names match, the copied length
> =C2=A0 equals the size query, and a buffer one byte short gets -ERANGE.
> =C2=A0 KASAN reported nothing with exact-size buffers.
> - generic/377 and generic/062: 5/5 passed on both kernels.
> - Full fstests (805 generic tests, 608 not run on both kernels): 188
> =C2=A0 passed and 9 failed without the patch, 187 and 10 with it. The onl=
y
> =C2=A0 difference is generic/617, which fails on both kernels most of the
> =C2=A0 time (19 of 20 reruns without the patch, 18 of 20 with it).
> =C2=A0 fsck.hfsplus -fn reported no errors.

The xfstests cannot help with testing osx. names. This is how I missed
the issue. It will be great to have a KUnit test(s) dedicated to
testing HFS+ xattr functionality.

>=20
> =C2=A0fs/hfsplus/xattr.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 71364e093fa7..470f090b2699 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -515,8 +515,8 @@ static ssize_t copy_name(char *buffer, const char
> *xattr_name, size_t name_len)
> =C2=A0	memset(buffer, 0, name_len);
> =C2=A0
> =C2=A0	if (!is_known_namespace(xattr_name)) {
> -		len =3D scnprintf(buffer, name_len +
> XATTR_MAC_OSX_PREFIX_LEN,
> -				 "%s%s", XATTR_MAC_OSX_PREFIX,
> xattr_name);
> +		len =3D scnprintf(buffer, name_len +
> XATTR_MAC_OSX_PREFIX_LEN + 1,
> +				"%s%s", XATTR_MAC_OSX_PREFIX,
> xattr_name);
> =C2=A0	} else {
> =C2=A0		len =3D strscpy(buffer, xattr_name, name_len + 1);
> =C2=A0		if (len < 0) {
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
