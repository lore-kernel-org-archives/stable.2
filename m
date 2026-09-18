Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62229415F2C;
	Fri, 18 Sep 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727560; cv=none; b=sr1F3or+1V3QZk39lRaeMmoVAsKPmq5LyIvpO0hhL/O+tG0HKfXYFtF29VDb9fV5uecIy5oNDywOTl9JxyPNLj9HcKxsTLAzmCUHMneqUNsLWi+TBJrVUF1YDrwepgabd0D/h9xIhk/XUguRN55QJMZVQFVIpL0WqZ2bFOkcXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727560; c=relaxed/simple;
	bh=ow9Vzb2TFVcMYcSLJbocUzWmCZHBM+RGMk1vfKKnAGE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CwN24U/o3/05LYSPm3D0FCg3b+EPDF+u7QWaBkZm53vcY5//HRz5iCpEDBIIrbcYFB12675vUC2vkOe5JSynMjh+iGkDcMBxyfoRXvpn11av7ThF7X/mctqKinuD7EABtot+7FA0hf8h0gTGzKOCp44G53VtzWVhKATFSOTX8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlnS3bnw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlnS3bnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789727559; x=1821263559;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ow9Vzb2TFVcMYcSLJbocUzWmCZHBM+RGMk1vfKKnAGE=;
  b=IlnS3bnwxzGWj5XH6zYQsnI1/YlWA2v89iml0tZe7t5BOKq0eokS7+BX
   S8ZIYM1eA4QWMPnpMDZdjKK4vGp5K3ECmFmalwqHAAfhIfQFxmUQsa6tI
   GU9zJgUUspO6y70YNaQqlLwsgH0wVMkQ5JjFddLobIVb1VL/dm1nyDAsS
   i6fb/dlvx5FCOpUdngBRyFRYwJWnyFxNfZWFBYE0rA/+aZd9nbJYX6bfD
   dkxxO9kL6OvxneA6gxvSyJBYRRsI7jEQ9eNEGTpt75jNU4S5Pl8IjlURy
   DcCgKJZxzlfJgAFg75vVgFcu4/KGMQ0kaCnE88/EuarEfWSOwSArAUHXt
   A==;
X-CSE-ConnectionGUID: n1zqBEepS7+dUMOx2D2KLQ==
X-CSE-MsgGUID: aUuc5KwuTsiqTZVyAiOXcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90090839"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90090839"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 03:32:38 -0700
X-CSE-ConnectionGUID: L1MaPcwgTXOtRsxI1A2SSg==
X-CSE-MsgGUID: EEjyDNo+QryHsWbHIcY/CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271652556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 03:32:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Sep 2026 13:32:31 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Josh Snyder <josh@code406.com>
Subject: Re: [PATCH v3 1/2] platform/x86: hp-bioscfg: fix 16-byte heap overflow
 for empty auth token
In-Reply-To: <20260818191120.38556-2-meatuni001@gmail.com>
Message-ID: <9d60ef62-a53c-bb13-ff6a-0a195cf2f6f3@linux.intel.com>
References: <20260818191120.38556-1-meatuni001@gmail.com> <20260818191120.38556-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-414600178-1789727551=:15314"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-414600178-1789727551=:15314
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 19 Aug 2026, Muhammad Bilal wrote:

> hp_calculate_security_buffer() special-cases an empty authentication
> string and returns a fixed 4 bytes (sizeof(u16) * 2). But
> hp_populate_security_buffer() does not special-case that same input:
> for any authentication string that does not start with BEAM_PREFIX,
> including the empty string, it always builds "UTF_PREFIX +
> authentication" and converts the result to UTF-16, writing a 2-byte
> length header plus 2 bytes per character of "<utf-16/>" (9 characters),
> 20 bytes total, regardless of how long "authentication" itself is.
>=20
> The caller, hp_set_attribute(), sizes its kmalloc() buffer using
> hp_calculate_security_buffer()'s return value, so for an empty
> authentication token it allocates 4 bytes for the security area but
> hp_populate_security_buffer() then writes 20 bytes into it, causing a
> 16-byte heap buffer overflow.
>=20
> The authentication token used here is the current admin/setup
> password, which is an empty string by default until one is
> configured. Any write to a writable BIOS attribute while no admin
> password has been set reaches this path.
>=20
> Fix by removing the special-case early return for an empty string in
> hp_calculate_security_buffer(). The generic calculation that follows
> already accounts for the UTF_PREFIX correctly, which naturally yields
> the same 20 bytes that hp_populate_security_buffer() writes for an empty
> string, avoiding duplicate logic for special cases.
>=20
> Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
> Reported-by: Josh Snyder <josh@code406.com>
> Closes: https://lore.kernel.org/platform-driver-x86/20260402-hp-bioscfg-o=
verflow-v1-1-6985f8c9e67c@code406.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v3:
>   - Remove the special-case return entirely instead of adjusting its
>     formula, avoiding code duplication as suggested by Ilpo J=C3=A4rvinen=
=2E
>   - Credit Josh Snyder who previously noted this approach.
>=20
> Changes in v2:
>   - None for this patch; resubmitted as part of the v2 series.
>=20
> Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.c=
om [v1]
> Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.=
com [v2]
> ---
>  drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/dri=
vers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> index 4d94e48c1a4c..136585141e6e 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -47,10 +47,6 @@ size_t hp_calculate_security_buffer(const char *authen=
tication)
>  =09if (!authentication)
>  =09=09return sizeof(u16) * 2;
> =20
> -=09authlen =3D strlen(authentication);
> -=09if (!authlen)
> -=09=09return sizeof(u16) * 2;
> -
>  =09authlen =3D strlen(authentication);
>  =09size =3D sizeof(u16) + authlen * sizeof(u16);

authlen is not uninitialized, so only the early return should be dropped.

I've dropped this patch from the review-ilpo-next branch.

--=20
 i.

--8323328-414600178-1789727551=:15314--
