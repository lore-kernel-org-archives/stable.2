Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740B33CE86;
	Tue, 18 Aug 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054937; cv=none; b=XON1Ffvi6naG//IG0yvq2/wHCTJJDMulgJ7tG99PfKv51NUgSBpve5QIIbyV0axJrfKW1WoR3GTFyRAqNsxzG9wzciw5vZKPzJca4K5miS05hwn9QS0m0ca+EDT1pSrBgi/fYYx67nKgCZpnoCyVKlaP/v4qXzVjCDCllXUIIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054937; c=relaxed/simple;
	bh=IE4VeFoYWMT5+b5XDCNS0hJiol3t3rbEU15shN43+sY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=thNfd5kEYvLYZe3fJ9xwgPmOvvtHGHoGg7X+uBgBr3eZmmK+dZXoVadn2d1fIDakx9lwN35aC1cTZ9MaPdXrW25Ml68PJRp2D0JC3fMsMt1ioxC5wgkD2/ZKz1fWYj/Oz2JizKxh8g40SnYTSs0r47+AkbWPdEtzeCCVo9fvtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+Ont3Rd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+Ont3Rd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787054936; x=1818590936;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IE4VeFoYWMT5+b5XDCNS0hJiol3t3rbEU15shN43+sY=;
  b=M+Ont3RdhJ8iJBih1MNfrjkn3nYg9shHBfvRo32hMXstIqPLOoi9kuDz
   85U/dDLPt3SkqwYEzE+SK/wxsV9FI1uKKy9w+j0A8fbjr27Am0/cuvyzz
   MXm7ryKEcXFkTudI1rJ9ut+mbQ6s62tM0fWR2tPmWxsRI6U8sUlkryURn
   pBltCsX0HlcfHCvP3+Yo8kA3w/FrUUpQvkkKECKjfofe7GTqnq022s3sV
   psuA3BwgoySIrGaiquqn2oQ+oi4n9yjKek2YdVh0F65nHEvjlvPzVVJXp
   Jtly/CxztF5fV2mASMnUd98CYZNoWeTTMcNDM6s7T1PoFeQyTNIByltx1
   w==;
X-CSE-ConnectionGUID: g9h8Ska/RZSSYqVJiU5w0g==
X-CSE-MsgGUID: N6am/dIuRQGN1v3IfWQ04A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98212228"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98212228"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 05:08:54 -0700
X-CSE-ConnectionGUID: TqvotnzfSO6NXZPx+0BBtQ==
X-CSE-MsgGUID: V+DBIJO9SXOlLC3kTY4msw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="269051825"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 05:08:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Aug 2026 15:08:48 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/9] platform/x86: hp-bioscfg: fix multiple memory
 safety bugs and parsing errors
In-Reply-To: <20260812111829.172273-1-meatuni001@gmail.com>
Message-ID: <056903f7-802d-3db5-f0c8-b1c66d37b8c2@linux.intel.com>
References: <20260812111829.172273-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1113267651-1787054928=:9077"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1113267651-1787054928=:9077
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 12 Aug 2026, Muhammad Bilal wrote:

> This series fixes several bugs in the hp-bioscfg driver:
>=20
> 1. Memory safety issues (patches 1-6):
>    - Off-by-one NUL terminator write in hp_get_string_from_buffer()
>    - Heap OOB read in sk_store()/kek_store() when passing original
>      count instead of trimmed length to hp_wmi_perform_query()
>    - Heap OOB read on empty password write in validate_password_input()
>    - 16-byte heap overflow in hp_calculate_security_buffer() for empty
>      authentication tokens
>    - Off-by-one heap OOB write in audit_log_entries_show() when more
>      than 256 log entries are reported
>    - Missing bounds check in the PSWD_ENCODINGS parsing loop
>=20
> 2. Logic bugs (patches 7-8):
>    - new_password_store() incorrectly passing is_current=3Dtrue, causing
>      writes to land in current_password instead
>    - ORD_LIST_ELEMENTS case using a stale NULL str_value pointer
>      instead of converting the current ACPI element directly
>=20
> 3. ACPI package element index tracking (patch 9):
>    - Five attribute-type parsers (enum, int, string, order-list,
>      passwd) all share the same defect: multi-element array cases
>      consume "size" consecutive elements but the outer loop only
>      advances by one, causing the next iteration to misread a
>      leftover array entry as the next property and abort with -EIO
>=20
> Tested on HP EliteBook 840 G2 (BIOS M71 Ver. 01.31), kernel 7.2.0-rc5+,
> with CONFIG_KASAN_GENERIC=3Dy and CONFIG_SLUB_DEBUG=3Dy.
>=20
> This series applies on top of:
>   commit ea4d8f8ba283 ("platform/x86: hp-bioscfg: fix
>   slab-out-of-bounds write in hp_convert_hexstr_to_str")
>=20
> Changes in v2:
>   - Squash patches 9-13 from v1 into a single patch (now patch 9),
>     as the fix is identical across all five attribute-type parsers.
>     Requested by Ilpo J=C3=A4rvinen.
>=20
> v1: https://lore.kernel.org/all/20260803143037.93105-1-meatuni001@gmail.c=
om/
>=20
> Muhammad Bilal (9):
>   platform/x86: hp-bioscfg: fix off-by-one write in
>     hp_get_string_from_buffer
>   platform/x86: hp-bioscfg: fix heap OOB read in sk_store and kek_store
>   platform/x86: hp-bioscfg: fix heap OOB read on empty password write
>   platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth
>     token
>   platform/x86: hp-bioscfg: fix off-by-one heap OOB write in
>     audit_log_entries_show
>   platform/x86: hp-bioscfg: add missing bounds check in PSWD_ENCODINGS
>     loop
>   platform/x86: hp-bioscfg: fix new_password_store overwriting
>     current_password
>   platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
>   platform/x86: hp-bioscfg: advance elem past consumed array elements

Hi,

Thanks for the update, I've applied patches 1-3 and 6-9 to the=20
review-ilpo-next branch. For patch 4, the approach in Josh's patch seem=20
better (IMO) and patch 5 seemed to be changing dead code (AFAICT).

(And once again, I really hate the amount of unnecessary copy paste in=20
this driver.)

--=20
 i.

>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c        |  2 +-
>  .../platform/x86/hp/hp-bioscfg/enum-attributes.c    |  4 ++++
>  drivers/platform/x86/hp/hp-bioscfg/int-attributes.c |  2 ++
>  .../x86/hp/hp-bioscfg/order-list-attributes.c       |  6 +++++-
>  .../x86/hp/hp-bioscfg/passwdobj-attributes.c        | 13 +++++++++++--
>  .../platform/x86/hp/hp-bioscfg/spmobj-attributes.c  |  6 +++---
>  .../platform/x86/hp/hp-bioscfg/string-attributes.c  |  2 ++
>  .../x86/hp/hp-bioscfg/surestart-attributes.c        |  2 +-
>  8 files changed, 29 insertions(+), 8 deletions(-)
>=20
>=20
--8323328-1113267651-1787054928=:9077--
