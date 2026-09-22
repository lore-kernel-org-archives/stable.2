Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5545628F
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075375; cv=pass; b=TGHmWCm/7mEgScxFicqvYhS13RU1dQ1ZpQuEVgua6zb2Zu8VX+Ll1ZGkLTxJYRF5fmPNG1lwMpevfpxKe8L/BYCwtoWWu2FbkxO0VbN/sFRXZ/3K+z8NTv1IomSCDeW2dfn5Kanq3voTT4uggmkACeF7UBn5aVPlOPOYpLmGT/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075375; c=relaxed/simple;
	bh=6GVB7x9ben233bUd/Gl4RRPxsbae5e6i40S+8Q0zN4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHHM8bPzDwKuSVqDWjZDZyf7GfOLZro0fbGD56qFD18wp2IPqB7ehqAeoeKk70Qv7u5c/T+SnwV5UA7mf+KnHhleA3yrUj8ckT9BHOH2PD1+2EKEDgt7rO2grANW9VX242THMIFezGcilkXzyMQQFr813dpb26RvqXMocUX9UOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT3/B50d; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT3/B50d"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c294ad260fdso125010966b.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790075372; cv=none;
        d=google.com; s=arc-20260327;
        b=KqFVPzlzqoz45v9Bvr1zSbN91SPeJXETNP2BnjdqBm/JxCQbEUahQOE24+PLN3QToC
         y9qxDEZuROINrTa8qTpeXUf+VK8XN81bqrKtXQe6Fy5sEGAV6RsIS5MZ1sZcW8ryrSD4
         ABKHzhJIb+ZMI8Vzw01VOUfj72hm9FSMRz0UIT26rNmHqTKI+NEceSOsrnF7axQJgh4K
         5WmKsI0Q0wR2gQDUk1oECtDekvBsxF6kwM6pjDC137RPwb7wxmMuXOZAydO7ejG54KnR
         jAGmzexIk/tjknTAGqDoHRj207gwyfaYwiWKmam7ar5GoS3OYHKHIXXV2UozDVhalRAy
         +F9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bYkI/YWQ8yKeluntLIACqYIRC6CpwK4iAnqdkQvaVCg=;
        fh=cyR9Xd7Bl1EUClZF2vo7jnmQevVRG2bhH0mCn+j92FI=;
        b=SG2D28dBKtfWuOnLaL3br7mi4nbqKO0WFo9C762dIr9ctsyR7hsymz1kdVM9jjWiZg
         OK70bgE72HTXxrxdtZqj9mUNRXtwRaaTdcxxcAMDmBD6KUrjqaKL1v58zFZe+5GdVN9w
         n9A0O+jCkGE78dMQSwQ1rQeOgI6vy4kWFDVi32n2xNT2/nBpYMuRvDCC4d/FJJfzTmj+
         rt2fyRI9d2JP68+tHOTCBRWLPCrPw8L2M6e69ftmRKUBHYjwI1JRFan6QJc0+ZMLE82k
         eV8EjNKra5KbwS5AsGoBg7cEiIWj0s6Yzh7ThImh4txaZ5GjhEtaGyL/XbbfDUirIQe2
         67MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075372; x=1790680172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYkI/YWQ8yKeluntLIACqYIRC6CpwK4iAnqdkQvaVCg=;
        b=HT3/B50d4ZrdjbN7WnmcXIP6V1M9sdOiAR8RPhxHjiWviVaDgZOW6ATuMyK60LVTy6
         THxPvcCRZq+n4YUbfVJClT1SjC7sBS9Yty/7saJyXzqBvGIBtT37FKPJdyWSkA4ZOGDs
         Odn0MwyLTV14KiRLLR928cuHnxuin26acRRJ9OIjGaVQOU3bo2FwSfiQT/mWAfYMqWQM
         KC7Jl3V1x0b9/PYtoivt9ZqcJFlvpJ7TqL2bUddQ78KrExlpi2CzOGREjz/jyN1uv5xI
         xxBbiWztfXYC3GALY9bHK8MxRGjQq9Bq0m+4/mF+mtgJMfhb/rGsItkXU0fU/sOjBDtT
         LpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075372; x=1790680172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYkI/YWQ8yKeluntLIACqYIRC6CpwK4iAnqdkQvaVCg=;
        b=Pw1LOuIxpegFv4nHn9wV/71CM/JaQNSGWh+S1+YXG884kKEWnByLlYU+pbE6FQtLig
         rvrkP/l+TrKHppp1hyPWtKYAIu33wKRNkaol8BsgIa2R0TVX9kzHnpWN3erCPIZjqN7m
         AMtlSqvZZriJW5FDHR8vXkWbdk/mml/gkFGB7DVUcP8Tuu5wvW5rTBE8GxWT2Z0LMkH6
         3S57Hn6UvnYYhtsO2u2CiEIfvs5ImMuHW6HdJPpE7UqQLhM63mIdHxSaj+f7fu5244sG
         G12Q1VGaHjvqNTbicgIAG0cYu8X2MM5IaHsbIp6SWFcgW342DIr3YThgzFKgKE1Qk5Ea
         Klkw==
X-Forwarded-Encrypted: i=1; AKwUvBwGtE0BFGSnumjdBAsTcarTTX/8H6pDUQlEUlQtopz6nk0QxRlH09TYM1wg3QV2xOfj270p8SA=@vger.kernel.org
X-Gm-Message-State: AFuF++kkadapTA01T/i6wfdC5CUJT1cOWTYKAexXK5ETTeilsVmPI+0P
	/p8GTEiAfoS867zLDfCptShQXhlXRkmHsneTTrgWQY+hdwpRtQgoFOJDqCLAqMMxpKKJS2Bj7Iv
	Bwbsu1MXa4pypyfNLWeL6PyhKlVS3f9Q=
X-Gm-Gg: AYBFou3NptVH5vgzXPD5aBW2MpEV6rclzBAPNp5R3/lkoKvsOi3l2fmCpR0crpjY9ku
	Jdyr6HHz9u+R+1RIjxPHknTn0ytOYedtp5T3ETbuPRwVu5h1lWMrMlw3epgtI3J8PM0dIYoKiv5
	K/hi3BsxklpJtfFDMZEyOwmm+Q9Bcc7XWZ8lpBGV1qXM7veTWUxcdKErlWnHQon9qrD5gol3sO/
	RAuQ68xTFi0S1EadoXz22K042VFYe5LY2Aqx8qAf4siappi7QJQwraKmOXKUuuV4H8l6xan/3q5
	OqifQ/C7hwGbdvEwockhI9mlWgfZbd3gxsFGgiyltpgM3MISknNohk8mMs/i1Q4Kn5rv3lvg7x6
	lC+NOo/+GgxbJBMyW3QQYsDmI9RC6H+rN6LGjXs8=
X-Received: by 2002:a17:907:1c1d:b0:c25:4d9e:bb28 with SMTP id
 a640c23a62f3a-c2a8d44e967mr204909166b.3.1790075371598; Tue, 22 Sep 2026
 04:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824225610.18471-1-meatuni001@gmail.com> <20260824225610.18471-3-meatuni001@gmail.com>
 <a67d4e52-5e87-0e76-4c91-cb8ba2be31f9@linux.intel.com> <CADqcGBnGHd+rRn6b=eWVjhWDU-NQ4CFb-3B9cgwBeouN-sbw4Q@mail.gmail.com>
 <ab2078e1-4388-6311-0363-afdfc131ea60@linux.intel.com>
In-Reply-To: <ab2078e1-4388-6311-0363-afdfc131ea60@linux.intel.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 22 Sep 2026 16:09:20 +0500
X-Gm-Features: AcwNN1UiG-gE9yMoTAKVEMCJSlXjpgp0-QY2lWEbGt4QUYok2K-kPFaSQ5j-SHY
Message-ID: <CADqcGBnuzxwKiQ-r94gin0+8oWpvsWQ+tL=PRpK=tee7A2okdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and
 buffer desync in hp_get_string_from_buffer()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: jorge.lopez2@hp.com, Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That makes sense, thanks for the pointers. Here's what I found and a
concrete proposal.

string_escape_mem() (lib/string_helpers.c) does exactly what the
manual loop is trying to do, safely: it takes a source byte buffer and
length, writes escaped output into dst up to osz without ever writing
past it, and returns the true escaped length so truncation is
detectable by comparing the return value to osz. I checked
escape_passthrough(), the fallback for anything not matched by a flag:
it copies the byte through unchanged. ESCAPE_SPACE covers \n \r \t \v
\f, ESCAPE_SPECIAL covers \\ \a \e and ". All of those are ASCII
values below 0x80, so none of them can collide with a UTF-8
continuation or lead byte (those are always >=3D 0x80). So running
string_escape_mem() over already-converted UTF-8 output is safe
without needing to be UTF-8-aware itself.

Proposed shape: convert with utf16s_to_utf8s() into a scratch buffer,
then string_escape_mem() that scratch buffer into dst.

char utf8_buf[MAX_BUFF_SIZE];
int utf8_len;
int escaped_len;

utf8_len =3D utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN,
utf8_buf, sizeof(utf8_buf));

escaped_len =3D string_escape_mem(utf8_buf, utf8_len, dst, dst_size - 1,
ESCAPE_SPACE | ESCAPE_SPECIAL, NULL);
dst[escaped_len] =3D 0;

I want to flag the scratch buffer sizing specifically, since I got
this wrong in my first pass at this reply and want to be upfront about
it. src_size is attacker/firmware controlled (a u16 read straight from
the WMI buffer), so orig_size can be up to ~32767 u16 units, worst
case UTF-8 expansion of that is close to 100KB, nowhere near safe for
a fixed-size stack buffer, and the kernel doesn't allow sizing a stack
array off a runtime value. I checked all three call sites in this
file: dst_size is 512 (MAX_BUFF_SIZE) at every one of them, no
exceptions. So the above caps the conversion at MAX_BUFF_SIZE
regardless of what orig_size claims, same capping discipline the
current code already applies to conv_dst_size, just applied a step
earlier, before the escape-inflated count. Open to a different
constant or a kmalloc'd buffer instead if you'd rather not hardcode a
dependency on MAX_BUFF_SIZE inside this function.

Two more things I want your input on:

1. Quote handling changes. ESCAPE_SPECIAL turns " into \", the current
code turns it into ' instead (no backslash). Switching to the library
means losing that substitution, a visible output change I'd rather
confirm than assume is fine.

2. \v and \f get escaped now, where they weren't before. Matches what
you said about \v being an oversight, just flagging that \f comes
along with it from the same flag, there's no way to get one without
the other from ESCAPE_SPACE.

On utf8clen(): found it, static inline and duplicated in both
fs/unicode/mkutf8data.c and fs/unicode/utf8-norm.c, unusable from a
driver as is. I don't think this fix needs it though,
string_escape_mem() is already byte-transparent to UTF-8 as noted
above. The only thing utf8clen() would buy is guaranteeing a dst_size
truncation never lands mid-character. Given this is short BIOS
attribute strings, I'd lean toward leaving that as a known, minor
limitation for now rather than pulling in a separate cross-subsystem
cleanup patch to fs/unicode just for it. Let me know if you'd rather I
do that properly first.

Thanks,
Muhammad

On Mon, Sep 21, 2026 at 7:29=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 19 Sep 2026, Muhammad Bilal wrote:
>
> > Confirmed, you're right about the redundancy.
> >
> > utf16s_to_utf8s() takes src by value, so it can't advance the caller's
> > src pointer. The second loop then restarts from the same position and
> > overwrites everything the conversion just wrote, using dst[i] =3D *src,
> > a raw truncating cast with no UTF-8 encoding. So step 2 is currently
> > dead work, and the function is ASCII-only in practice: any character
> > above 0x7f gets truncated to garbage instead of being properly
> > encoded.
> >
> > Two ways to fix that, and I'd like your preference before I send
> > anything more for it:
> >
> > (a) Keep utf16s_to_utf8s() as the real conversion, and rewrite the
> > second loop to do escaping as a pass over its UTF-8 output instead of
> > re-deriving from UTF-16 src.
>
> Not exactly this, but somewhere there.
>
> You should not try to build the escaping nor utf-8 parsing/length
> calculation within the driver but use generic code for that.
>
> To give some directions...
>
> There seems to be some escaping function in lib/string_helpers.c but sinc=
e
> we're dealing with an UTF-8 string here, there might not be a readily
> available function for string inputs/outputs.
>
> escape_space() seems to also cover escaping \v, which wasn't among the
> characters this driver escapes. You might need to check that particular
> character in driver before calling the library's escape funtion though
> I'm more thinking along the lines of not escaping it was an oversight fro=
m
> the original submitter (given the questionable quality of this driver to
> begin with).
>
> utf8clen() seems to exists, but is currently in inconvinient place (and
> already duplicated so it should be placed into some header anyway).
>
> > (b) Drop utf16s_to_utf8s() entirely if ASCII-only was always the
> > intent, and keep only the manual loop, fixing its bounds instead..
>
> I think ASCII only was not the intent, but it just happens to work in
> many cases which is why this has survived so far.
>
> --
>  i.
>
