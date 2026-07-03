Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36DB3B2FD8
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082433; cv=none; b=AuO7C3SjfWuNyx6zy5y1EqZf9YUNBNbvo0co8atect30NJIVH1ftjZHNBC/HTAHb+++XHKGUmP3S9zNI5ACTgGAmA1afH9wTq3uWZz8ameM6VBiKEYrwV4h7+esagyyyKcNpk75/b+DV8V8lBJC4VyE5zTt7klvNxEFi/2JSQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082433; c=relaxed/simple;
	bh=RqXUJkOyhp13Tul5eNzp6T7Q9dijUoEpw+x8tQewJBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btncd2xO6jvj8EBmrr5jc6osPmu8GiJukhWyZNdqa0kThVT01EC3yH8FHti9UPG9A34vHuQDHQDr3xmqNw+r6ByZG1p5bi7Uw5jgeYBA52e/YCEgZ5AhjkyEFhDd2yjwbiVO8MIOPwOSrmMUs76p+cr5e+r/2Qets6/nmyS0z2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ33ArFe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ33ArFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783082432; x=1814618432;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=RqXUJkOyhp13Tul5eNzp6T7Q9dijUoEpw+x8tQewJBw=;
  b=TQ33ArFewT84+pRt9xGtjGNkl2Gf/TRsmgkwUsXYAMKb4+0gGbSZmq93
   lZbnhNicovc8lXgR6CrDaa/2w2qzpeRbkVlGZoUpl0jENzELTOgdgoQHX
   Nu4l+qrsPO61BRwlnnmfZLwOBVXbEwGXUBw6M/XrEggKRxjXXVV1DVEHA
   onrVz7+gcPR67vKkRJqdpRGrm7/TkRbDsKnknibukiEoPDSQrzTrhn0FE
   kItbrxzKtg8cCpgxsyYFOpWDgRD5vtUILob0BDCU1EQFhGAzyRQFZ0zmZ
   fvIG/sMDaM6PM+fJpGHNVIpShEXrM6Gd3RTavdXf7TY8WaktZ/kXAP3ZB
   w==;
X-CSE-ConnectionGUID: 7rTKvtIVSFGm/4A1eUHaJQ==
X-CSE-MsgGUID: COdAZr3aR8GzLUhJiYxOag==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83700743"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="83700743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:40:32 -0700
X-CSE-ConnectionGUID: VFtAGfzOTwusE2z63MPhnw==
X-CSE-MsgGUID: ysk8ldwxSoGXaAMWJ7Xg9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="283194553"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.157])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:40:29 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: imre.deak@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Martin
 Hodo <martin.hodo@intel.com>, stable@vger.kernel.org, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] drm/i915/mst: limit DP MST ESI service loop
In-Reply-To: <akU3qOVL4eh2E9ma@ideak-desk.lan>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260625142204.1078287-1-jani.nikula@intel.com>
 <akU3qOVL4eh2E9ma@ideak-desk.lan>
Date: Fri, 03 Jul 2026 15:40:26 +0300
Message-ID: <bd3a4590aa21a61c433bb7d8506e91123231b9d2@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Jul 2026, Imre Deak <imre.deak@intel.com> wrote:
> On Thu, Jun 25, 2026 at 05:22:04PM +0300, Jani Nikula wrote:
>> The loop in intel_dp_check_mst_status() keeps servicing interrupts
>> originating from the sink without bound. Add an upper bound to the new
>> interrupts occurring during interrupt processing to not get stuck on
>> potentially stuck sink devices. Use arbitrary 32 tries to clear incoming
>> interrupts in one go.
>>=20
>> Discovered using AI-assisted static analysis confirmed by Intel Product
>> Security.
>>=20
>> Note: The condition likely pre-dates the commit in the Fixes: tag, but
>> this is about as far back as a backport has any chance of
>> succeeding. Before that, the retry had a goto.
>>=20
>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>> Fixes: 3c0ec2c2d594 ("drm/i915: Flatten intel_dp_check_mst_status() a bi=
t")
>> Cc: <stable@vger.kernel.org> # v5.8+
>> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> Cc: Imre Deak <imre.deak@intel.com>
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Imre Deak <imre.deak@intel.com>

Thanks, pushed to din.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_dp.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i=
915/display/intel_dp.c
>> index 6e3fa6662cbe..ade7e51e7590 100644
>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> @@ -5590,8 +5590,9 @@ intel_dp_check_mst_status(struct intel_dp *intel_d=
p)
>>  	struct intel_display *display =3D to_intel_display(intel_dp);
>>  	bool force_retrain =3D intel_dp_link_training_get_force_retrain(intel_=
dp->link.training);
>>  	bool reprobe_needed =3D false;
>> +	int tries =3D 33;
>>=20=20
>> -	for (;;) {
>> +	while (--tries) {
>>  		u8 esi[4] =3D {};
>>  		u8 ack[4] =3D {};
>>  		bool new_irqs;
>> @@ -5634,6 +5635,11 @@ intel_dp_check_mst_status(struct intel_dp *intel_=
dp)
>>  			break;
>>  	}
>>=20=20
>> +	if (!tries) {
>> +		drm_dbg_kms(display->drm, "DPRX ESI not clearing, device may be stuck=
\n");
>> +		reprobe_needed =3D true;
>> +	}
>> +
>>  	return !reprobe_needed;
>>  }
>>=20=20
>> --=20
>> 2.47.3
>>=20

--=20
Jani Nikula, Intel
