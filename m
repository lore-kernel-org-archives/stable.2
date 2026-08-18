Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00C3B71C4;
	Tue, 18 Aug 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054718; cv=none; b=X3rxDxHonx8a43gfYaJHQY5hOkxsKB75v8z1rw5OS+98pAV0wAv/K5ojebCx9niLJEDHgjRLOX8ReKgg00BzrcKlQQgyM2yDZ4m2jea/4ZZuJ74Osx8SgNuAUzL7SvYVrnaMxssYRqGbqV+8NO8iJmy+K7ELinISXDgbUQvYFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054718; c=relaxed/simple;
	bh=BDOY1kqwlsEz41jHpULvr1BP52pH9abN3Za9/K3wVww=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o+/oOFzyN59kPbTGOxTkRpd8WReNrh+OnOIt28FMHf9QIMPj4RVhdBJEEyAWDr4XsCjy/fuGIAtHBCt60UYUrRrXz0IpWQTN3btLbLa8AVG0iXgrnSakz89Av1ie8c05GdGjVojkpelfovdBjAPhlRxPQir/CxwsUnCLyWv1Z8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrmBLjyw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrmBLjyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787054717; x=1818590717;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BDOY1kqwlsEz41jHpULvr1BP52pH9abN3Za9/K3wVww=;
  b=XrmBLjywvlDDQvmGeFIIsrNVv3gE88OT9V4kRGEAY7Irj0jBpYXpbHLq
   uUlUmURyNm1WELDyVu/Ounz7ndE+GQOyeWS53ktXWT/cmlRhTGqMNQmD0
   i8nH8zdh5q+Kh83y8Fm3vOGiAo149gPND/O6iUklJYdgRMNehe4kge4am
   JAELyipwOKiyVC44aYyBfZiP5UPbCQJmEwKuAtu6pt53ddl8I4Q1BTVJh
   YSkSGl7+VSGIKqyIRqti4hb7rDZ+8XPP/7aYqCHqIkLwiEt3TWSaK+i5l
   /HyXQuiVg4nbN8TmFZysbvmmgVVHcKvC+uCXz5UA7t/v+izABXfp92Ptl
   Q==;
X-CSE-ConnectionGUID: FLrxnPBeSfmiXCJ1qmkhcA==
X-CSE-MsgGUID: qVehN7pyRiiz+FeV4Qq+oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="97882024"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="97882024"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 05:05:17 -0700
X-CSE-ConnectionGUID: MBn+J0b1RnO3zH2okKTd0w==
X-CSE-MsgGUID: BkulBdoHTWmi8RI3iqrQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="290018599"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 05:05:13 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 18 Aug 2026 15:05:09 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>, Josh Snyder <josh@code406.com>
cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
    Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/9] platform/x86: hp-bioscfg: fix 16-byte heap overflow
 for empty auth token
In-Reply-To: <20260812111829.172273-5-meatuni001@gmail.com>
Message-ID: <6d9508e0-a4f2-a97a-d5c2-09941b36fe3e@linux.intel.com>
References: <20260812111829.172273-1-meatuni001@gmail.com> <20260812111829.172273-5-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Aug 2026, Muhammad Bilal wrote:

> hp_calculate_security_buffer() special-cases an empty authentication
> string and returns a fixed 4 bytes (sizeof(u16) * 2). But
> hp_populate_security_buffer() does not special-case that same input:
> for any authentication string that does not start with BEAM_PREFIX,
> including the empty string, it always builds "UTF_PREFIX +
> authentication" and converts the result to UTF-16, writing a 2-byte
> length header plus 2 bytes per character of "<utf-16/>" (9 characters),
> 20 bytes total, regardless of how long "authentication" itself is.
> 
> The caller, hp_set_attribute(), sizes its kmalloc() buffer using
> hp_calculate_security_buffer()'s return value, so for an empty
> authentication token it allocates 4 bytes for the security area but
> hp_populate_security_buffer() then writes 20 bytes into it, a 16-byte
> heap buffer overflow.
> 
> The authentication token used here is the current admin/setup
> password, which is an empty string by default until one is
> configured. Any write to a writable BIOS attribute while no admin
> password has been set reaches this path.
> 
> Fix by removing the special-case short return for an empty string in
> hp_calculate_security_buffer() and letting the normal formula run,
> which already accounts for the UTF_PREFIX correctly for the non-empty
> case; for an empty string this naturally yields the same 20 bytes
> that hp_populate_security_buffer() writes.
> 
> Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> index 4d94e48c1a4c..2d4a3720f80c 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -48,7 +48,7 @@ size_t hp_calculate_security_buffer(const char *authentication)
>  
>  	authlen = strlen(authentication);
>  	if (!authlen)
> -		return sizeof(u16) * 2;
> +		return sizeof(u16) + strlen(UTF_PREFIX) * sizeof(u16);

There was an earlier attempt to fix this from Josh Snyder (added as 
recipient) by removing the entire return which looks better approach to me 
as it avoid code duplication for a special case:

  https://lore.kernel.org/platform-driver-x86/20260402-hp-bioscfg-overflow-v1-1-6985f8c9e67c@code406.com/

I'm not sure why there never was v2 of that patch from Josh with improved 
changelog text. Josh?

>  	size = sizeof(u16) + authlen * sizeof(u16);
>  	if (!strstarts(authentication, BEAM_PREFIX))
> 


-- 
 i.

