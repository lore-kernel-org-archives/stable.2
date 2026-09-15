Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BE395AC7;
	Tue, 15 Sep 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502007; cv=none; b=Id55WZp8HaI2qpAaOhCFeH2fYKrnFGtWPfopEeGZGDZRebIsh5IeLsseZotIm3y5tj3BjGKcDCkF+3Epuv9Q339Ngrl/7UTm1MwTEcA5O041UBIDSbSLGdOrkUP5AzjwWy8JPazTvs4MtbyZW+qXx4itYXqUXR0KLh+5c99Eha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502007; c=relaxed/simple;
	bh=5vrLOBOf2DsC8q3DxMNW2WwQdoteFseLhphXDCc/qH0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LOB63rYMsE/OV5WJi44j+CVeSIpQTSPqyn7JjHM2Dmoxfu2XKotOqjRwUGJgIbg55PqmGU6bG1BHk1833Ai+JM0X8Uk0ba5tg6KBP4mtvxKpV++0BhTGw8HvsFEgRW4I7+XbMGSrW3WCUMoGt4S/RtTFqBn2u86WaEevgVV9xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQwiGmnw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQwiGmnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789502006; x=1821038006;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5vrLOBOf2DsC8q3DxMNW2WwQdoteFseLhphXDCc/qH0=;
  b=aQwiGmnwClcw04hnUYoGeLU5cvBnsHPf9XXIlDofmcWALfTGs6faeo7L
   yNx7+uOe1KoduYBssgHOcla9sh04PSVYW95ez8idv4ZqvARd7uQe5DeJU
   g4yeb+oMtbVmDtGORkkGNRbiz9dyS/n4r59eocXW+aZh/JifzqyPNW0qH
   jlookZzI8sYgkkec3gds+KT+vl3mTyhdUXvNP6PKku9B2380nVgVOZB/U
   /pUhKJbaz0xqqrKJsHvZP8nWtXrBXIIPQe9kShjql+UOtU3cenxtvteWe
   q5jSLrgIGPVx0MVgsAZ5pvmDKSbHqNJ6s2cclDkhm4ztsNbFRM8O1M2/D
   A==;
X-CSE-ConnectionGUID: 40GmM/M0QFWPYxslYjsJgA==
X-CSE-MsgGUID: cTBNcLfdQXWDWWk1UeW0fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107245789"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107245789"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 12:53:24 -0700
X-CSE-ConnectionGUID: P2HGi6J3Tfmiu8ue4BFa+g==
X-CSE-MsgGUID: VtJuuZSBRA682d3X8dKKvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1344636"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 12:53:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Sep 2026 22:53:18 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: hp-bioscfg: fix slab-out-of-bounds
 write in hp_convert_hexstr_to_str
In-Reply-To: <20260915174615.63924-1-meatuni001@gmail.com>
Message-ID: <0380b8d6-cff5-383f-b47f-700d1d17fefa@linux.intel.com>
References: <20260915174615.63924-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1934819062-1789501998=:1365"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1934819062-1789501998=:1365
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 15 Sep 2026, Muhammad Bilal wrote:

> hp_convert_hexstr_to_str() decodes an ACPI string made up of
> space-separated ASCII hex-byte tokens of the form "0xHH". For
> example, the four-byte input "0x41" decodes to the single
> character 'A', and the nine-byte input "0x09 0x41" decodes to
> "\tA": each token is read in a five-byte step (four characters for
> the token, one for the trailing delimiter), and produces one output
> byte, or two if that byte is '\\', '\r', '\n', or '\t', which are
> written back out as a backslash followed by the matching letter.
>=20
> The output buffer is sized with kmalloc(input_len, GFP_KERNEL), the
> raw encoded length of the input, not the decoded length. For
> well-formed input this is generous, since five input bytes never
> decode to more than two output bytes. But input_len comes directly
> from the ACPI string length reported by firmware and isn't
> guaranteed to respect the five-byte encoding, so a short input_len
> can undersize the allocation. With input_len =3D=3D 1, only one byte is
> allocated, yet decoding still produces at least one output byte
> plus the NUL terminator written unconditionally afterwards, so two
> bytes are needed. That terminator write then lands one byte past
> the end of the allocation.

Thanks, very clear now.

I've applied this to the review-ilpo-next branch now, but please see=20
below for one additional thing.

> KASAN caught exactly this during BIOS attribute enumeration on
> boot, triggered by a one-byte encoded input value:
>=20
> BUG: KASAN: slab-out-of-bounds in hp_convert_hexstr_to_str+0x6d8/0x710 [h=
p_bioscfg]
> Write of size 1 at addr ffff8881032e5d81 by task (udev-worker)/520
> The buggy address is located 0 bytes to the right of
> allocated 1-byte region [ffff8881032e5d80, ffff8881032e5d81)
>=20
> Size the allocation to the worst-case decoded length instead of the
> raw input length: two output bytes for every five-byte input chunk
> (DIV_ROUND_UP(input_len, 5)), plus one byte for the terminator.
>=20
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> v2: Expand the commit message to spell out the hex-token input
>     format and decoded output with a worked example, and explain
>     exactly how a short input_len undersizes the allocation, per
>     Ilpo J=C3=A4rvinen's review. No code change from v1.
>=20
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platf=
orm/x86/hp/hp-bioscfg/bioscfg.c
> index 22c198680903..42331cf90581 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -442,7 +442,7 @@ int hp_convert_hexstr_to_str(const char *input, u32 i=
nput_len, char **str, int *
>  =09*len =3D 0;
>  =09*str =3D NULL;
> =20
> -=09new_str =3D kmalloc(input_len, GFP_KERNEL);
> +=09new_str =3D kmalloc(2 * DIV_ROUND_UP(input_len, 5) + 1, GFP_KERNEL);
>  =09if (!new_str)
>  =09=09return -ENOMEM;
> =20
>=20

I think the buffer should be allocated with kzalloc() to ensure there's no=
=20
potential leakage when/if the output buffer is filled only partially=20
which seems well possible given your description. So it would warrant=20
another patch on top of this change (as I've applied this now).


And your other patches are not forgotten, I'll get to them while=20
processing the rest of the patch queue.


--=20
 i.

--8323328-1934819062-1789501998=:1365--
