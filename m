Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBC4A7CA4;
	Mon, 28 Sep 2026 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595183; cv=none; b=OqiF4ERpW1m2h1SR+LOB/L+ZdYtkK/D6ApfCYDyflCIVWKijXnos7IYmAQUnAMLYvV84Zdv3dLfyWGAkzUfb39WsqlrOWDs+11WfOhEwG2lPn9SBJ49pLVlAw0Jy1ZyUjfniTW4DGoE9w/z+MCJ0VjFyP43aJxtGQkNCs/soxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595183; c=relaxed/simple;
	bh=BcK3JmHuZIvQ0oDLBUN9X2B5rxyXqVjo7wMzF/ein/Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VYpIdOB277x7J4TRWo+Ah6wqQdbUfF1Fn3QsbZzoRTcdeP0gt4r1pu33KxsoT+HLDyAzdF+m7MOTWpLSrphKELmEHm2SY2Qxmw8+DX2HkletVPNGgDf+PO5Kh0n+2hEsxnoui54XqcPN4CyFt0Acj8ZE71Z1R/uBosahKZXqq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxYw3tIc; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxYw3tIc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790595181; x=1822131181;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=BcK3JmHuZIvQ0oDLBUN9X2B5rxyXqVjo7wMzF/ein/Y=;
  b=OxYw3tIca/kh1pN5JRLyKqntCY1DmfygRCp12tgqeHePzYt8MX/Zw1g4
   ydYBTtJ8qXVNfRf+kqdqT4sMscXouhU/JaC4IOSDQe2FSLUOKdfe7xnF2
   hY/BG/phAHqzkwcGh5yd/ICOkVnxBo83N/qAQxGtUihFcVo6NErCljye2
   cSTBdZFahBotboCHFZR5C5FT6dYhSjrufd/PB0ITe9lftxOt/9LjLtkr+
   LGHfqpcxpA2iDaAXDAaCAy1H6hE5sWP6ItzcGEzBKGq4pIzyhu489pLpn
   /x6fdmb3pMQmIrxSx/RtvpQvw+atheD+1odDYEv6oAlgg4ckzy73aMrqL
   g==;
X-CSE-ConnectionGUID: ls2stXsvRx6MDXx99q5NOw==
X-CSE-MsgGUID: AYEeky7QSTGyKie57cNmbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="102663306"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="102663306"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:32:54 -0700
X-CSE-ConnectionGUID: uUBZeTZ7TZKNTiBcAVm+Tg==
X-CSE-MsgGUID: Ovm3y2DHTayHTlVkG3w3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274255192"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 04:32:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 28 Sep 2026 14:32:48 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and
 non-ASCII truncation in hp_get_string_from_buffer()
In-Reply-To: <20260926205708.384308-2-meatuni001@gmail.com>
Message-ID: <1d04a020-bd2a-4f77-b9d9-cf3b80115743@linux.intel.com>
References: <20260926205708.384308-1-meatuni001@gmail.com> <20260926205708.384308-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1967676766-1790593284=:1168"
Content-ID: <0da0b184-598b-5495-0b65-ec4ec16dad77@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1967676766-1790593284=:1168
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6a5e1535-133e-98fc-62e3-d2a333480540@linux.intel.com>

On Sun, 27 Sep 2026, Muhammad Bilal wrote:

> hp_get_string_from_buffer() has three problems.
>=20
> First, the loop that counts how many characters will need
> backslash-escaping uses the same variable as both the accumulator and
> the loop bound, so once an escape character is found near the end of
> the valid range the loop keeps going past the buffer's true character
> count, reading out of bounds.
>=20
> Second, the bounds check 'if (*buffer_size < src_size)' runs after
> src has already stepped over the 2-byte length prefix, so if
> *buffer_size equals src_size, reading src_size bytes reads 2 bytes
> past the end of the input buffer. The pointer and remaining size are
> then advanced using the escape-inflated count rather than the actual
> number of bytes consumed, desyncing subsequent property parsers.
>=20
> Third, found during review of the fix for the first two:

This kind of notes (how the patch came to be) are not content that should=
=20
be put into changelog. Generally (there may be some exceptions), just=20
explain what the problem is, not focusing on how it was found. The=20
reporter can be credited with Reported-by or Suggested-by tag depending on=
=20
which of them is more suitable for the particular case.

> utf16s_to_utf8s() takes src by value, so the real UTF-16-to-UTF-8
> conversion it performs never reaches dst.

While true from the end result point of view that nothing of the=20
intermediate write remains, "never reaches dst" doesn't sound correct=20
description of what happens here.=20

> A second loop immediately
> overwrites dst by re-walking the same src position and copying each
> UTF-16 code unit with a truncating cast (dst[i] =3D *src), escaping
> '\\', '\r', '\n', '\t' and turning '"' into '\''. Any character above
> 0x7f is truncated to its low byte instead of being encoded, so the
> function is ASCII-only in practice. For example, given the
> two-character UTF-16 string 'eA' with the first character U+00E9
> (e-acute),

Nit, it's actually possible to include non-ascii characters in the=20
changelog. It might be still be useful to retain the textual explanation=20
if something manages to mangle the character despite everything but=20
normally it just works. (My surname has been mangled countless of times,=20
but much less these days. In the early days when git tools were not as=20
mature as today, one could even count how many times it got mangled while=
=20
getting passed from person/tool to another :-D).

> the function currently writes the two raw bytes 0xe9 0x41
> into dst, an invalid, truncated sequence, instead of the three bytes
> 0xc3 0xa9 0x41, the correct UTF-8 encoding of U+00E9 followed by 'A'.
>=20
> Fix all three by keeping the true character count separate from the
> escape-inflated one, checking *buffer_size against the full prefix
> plus string length before reading, and replacing the redundant
> conversion with a real one: convert into a fixed-size scratch buffer
> with utf16s_to_utf8s(), then escape that UTF-8 into dst with
> string_escape_mem(). The scratch buffer is sized to MAX_BUFF_SIZE
> rather than to src_size, since src_size comes straight from the WMI
> buffer and dst_size is MAX_BUFF_SIZE at every caller in this file.

It's preferrable, if possible, to fix the problems one by one. If it's=20
strictly impossible for some reason I cannot see, only then combine what=20
has to be combined.

This applies also to cases where something new comes up during a review of=
=20
a patch, if the newly found problem is separate from what the commented=20
patch was fixing, it should appear in own patch because it's logically a=20
separate problem.

Normally we aim to do logically minimal patches, and as many patches as=20
needed in a series to fix all logically disjoint problems one by one.
This allows more focused (and shorter) changelog per patch, and normally=20
makes review much simpler than one bigger spaghetti change where it's=20
hard for the reviewer to see what relates to which problem.

> string_escape_mem() has no flag that escapes only a backslash without
> also touching '"', so this depends on a separate patch that adds
> ESCAPE_BACKSLASH to string_escape_mem().

Not true anymore because you fixed that in the first patch ;-) so don't=20
write stale information into the subsequent changelogs. There's also no=20
need to tell something like "feature x was added to y" (in case you're=20
tempted to change the wording towards something along those lines).

We work in very much present time when writing a changelog, so if the=20
previous patch fixed a problem, we assume in the next patch's changelog=20
the problem no longer exists so there's no need to even mention it.

(There may be exceptions in case of very complex, interjoining problems=20
but that's not relevant here.)

> ESCAPE_SPACE together with
> ESCAPE_BACKSLASH escapes '\\', '\f', '\n', '\r', '\t' and '\v'; '\v'
> and '\f' were not escaped before, matching Ilpo's comment that this
> was likely an oversight rather than intentional. The existing
> substitution of '"' for '\'' is kept as an explicit strreplace()
> afterward, since string_escape_mem() has no substitution concept and
> switching '"' handling to backslash-escaping was ruled out in review.
>=20
> string_escape_mem()'s return value can exceed the destination size
> when the input does not fit, so the NUL terminator position is
> clamped to dst_size - 1 before use; writing dst[<return value>] =3D 0
> unconditionally would reintroduce a heap OOB write of exactly the
> kind this patch fixes.
>=20
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---

As this series is small, I suggest you send the next version of the entire=
=20
series to all interest parties. Those looking at patch 1 would want to=20
know about this change so to understand the use case, therefore make it=20
easy to find for the reviewers by including them.

I didn't look much into the diff itself as I believe it gets cleaner once=
=20
you split the change logically into a series of patches.

--=20
 i.

>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 78 ++++++++------------
>  1 file changed, 31 insertions(+), 47 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platf=
orm/x86/hp/hp-bioscfg/bioscfg.c
> index 309634c..82c228c 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/printk.h>
>  #include <linux/string.h>
> +#include <linux/string_helpers.h>
>  #include <linux/wmi.h>
>  #include "bioscfg.h"
>  #include "../../firmware_attributes_class.h"
> @@ -55,72 +56,55 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffe=
r_size, char *dst, u32 dst_
>  {
>  =09u16 *src =3D (u16 *)*buffer;
>  =09u16 src_size;
> -
> -=09u16 size;
> -=09int i;
> +=09u16 orig_size;
> +=09char utf8_buf[MAX_BUFF_SIZE];
> +=09int utf8_len;
>  =09int conv_dst_size;
> +=09int escaped_len;
> =20
>  =09if (*buffer_size < sizeof(u16))
>  =09=09return -EINVAL;
> =20
> -=09src_size =3D *(src++);
> -=09/* size value in u16 chars */
> -=09size =3D src_size / sizeof(u16);
> +=09src_size =3D *src;
> =20
>  =09/* Ensure there is enough space remaining to read and convert
>  =09 * the string
>  =09 */
> -=09if (*buffer_size < src_size)
> +=09if (*buffer_size < sizeof(u16) + src_size)
>  =09=09return -EINVAL;
> =20
> -=09for (i =3D 0; i < size; i++)
> -=09=09if (src[i] =3D=3D '\\' ||
> -=09=09    src[i] =3D=3D '\r' ||
> -=09=09    src[i] =3D=3D '\n' ||
> -=09=09    src[i] =3D=3D '\t')
> -=09=09=09size++;
> +=09src++;
> +=09/* size value in u16 chars */
> +=09orig_size =3D src_size / sizeof(u16);
> =20
>  =09/*
> -=09 * Conversion is limited to destination string max number of
> -=09 * bytes.
> +=09 * Convert from UTF-16 to UTF-8 into a scratch buffer first, then
> +=09 * escape the result into dst. utf16s_to_utf8s() is capped at
> +=09 * sizeof(utf8_buf) regardless of orig_size: orig_size comes
> +=09 * straight from the WMI buffer, and dst_size is MAX_BUFF_SIZE at
> +=09 * every caller in this file.
>  =09 */
> -=09conv_dst_size =3D size;
> -=09if (size >=3D dst_size)
> -=09=09conv_dst_size =3D dst_size - 1;
> +=09utf8_len =3D utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN,
> +=09=09=09=09   utf8_buf, sizeof(utf8_buf));
> +
> +=09conv_dst_size =3D dst_size - 1;
> +=09escaped_len =3D string_escape_mem(utf8_buf, utf8_len, dst, conv_dst_s=
ize,
> +=09=09=09=09=09ESCAPE_SPACE | ESCAPE_BACKSLASH, NULL);
> +=09if (escaped_len > conv_dst_size)
> +=09=09escaped_len =3D conv_dst_size;
> +=09dst[escaped_len] =3D 0;
> =20
>  =09/*
> -=09 * convert from UTF-16 unicode to ASCII
> +=09 * string_escape_mem() has no equivalent of the original quote
> +=09 * substitution; keep turning '"' into a plain single quote instead
> +=09 * of escaping it, to match existing behaviour.
>  =09 */
> -=09utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size)=
;
> -=09dst[conv_dst_size] =3D 0;
> -
> -=09for (i =3D 0; i < conv_dst_size; i++) {
> -=09=09if (*src =3D=3D '\\' ||
> -=09=09    *src =3D=3D '\r' ||
> -=09=09    *src =3D=3D '\n' ||
> -=09=09    *src =3D=3D '\t') {
> -=09=09=09dst[i++] =3D '\\';
> -=09=09=09if (i =3D=3D conv_dst_size)
> -=09=09=09=09break;
> -=09=09}
> -
> -=09=09if (*src =3D=3D '\r')
> -=09=09=09dst[i] =3D 'r';
> -=09=09else if (*src =3D=3D '\n')
> -=09=09=09dst[i] =3D 'n';
> -=09=09else if (*src =3D=3D '\t')
> -=09=09=09dst[i] =3D 't';
> -=09=09else if (*src =3D=3D '"')
> -=09=09=09dst[i] =3D '\'';
> -=09=09else
> -=09=09=09dst[i] =3D *src;
> -=09=09src++;
> -=09}
> +=09strreplace(dst, '"', '\'');
> =20
> -=09*buffer =3D (u8 *)src;
> -=09*buffer_size -=3D size * sizeof(u16);
> +=09*buffer +=3D sizeof(u16) + src_size;
> +=09*buffer_size -=3D sizeof(u16) + src_size;
> =20
> -=09return size;
> +=09return escaped_len;
>  }
> =20
>  int hp_get_common_data_from_buffer(u8 **buffer_ptr, u32 *buffer_size,
>=20
--8323328-1967676766-1790593284=:1168--
