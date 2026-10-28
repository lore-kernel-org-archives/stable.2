Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183613;
	b=pUiGmVLl/JSgBfJKDduAbm7TMrXSpbs8qBQg5wcfRmw4ho36G9EMfxbIn6de2wTzgAnT
	 2OJMfzPR2AOqPS7hhJCu9dN0s2IswFxVkFiurDPGDfx+wB1zWtAUCOXV3nYQCdrSAM8UX
	 26VMa+ZkCDdHI+ORhHX77xZIdstAg+AWLognm5OSps69IMvchm/lZZtIN0vXyEpL33ay3
	 900ndZ3cx8ZHerZjRiey21n7eY9ROgbWdvSBk7ewq6AjSSlS5Sf8kzl/9RVYjrHeSHWcR
	 JWSssNX89l4ukZrcrOHggdA9jnfSyrlE0PkB2jLugeCvGiZS4WOVbRfrPnznVQ6ISJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183613;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 In-Reply-To:Organization:References:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RMchR7ILtmjbNKbv7Rj853D+bvHKsZ/Jxvm7AvGtLRI=;
	b=RXcZ74VrIIenL2Qg5rZaqEAfrAVtY+V0VmjHNAAiX4Y0VvqbihwwbK2e6j3S2DZ9WgNU
	 KtFoVIyQaC1dmF9MqLRpe0IQCju0MnU91RM54k25xv3drM8t+dngYJuW0R3ka3Yty9BMO
	 4Q43XymmAAoxJA4gpGU7Bd0T0agsqIvePqTWusOnCg8OQ2vtgBP5CmQ0y1XleIsS5nsaU
	 b954ba6X51VI7jGuZ6V0PkF1L7jbe/cwYAuzbt2RHXVvwWPXet4MfSAznTRc3m/ah1woe
	 6lt9M4OeO4MPBuwzke4eJD8Y/s9YgCEX+UQui7+oCeGMDxTihSNBCV2l9BEKLhKK3dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bu6ESi5X;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE5606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bu6ESi5X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793183612; x=1824719612;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=RMchR7ILtmjbNKbv7Rj853D+bvHKsZ/Jxvm7AvGtLRI=;
  b=Bu6ESi5X3kZUjwGUMIyzNThhwQ0Pg6t7wu566vLo8WIqhXAFWJsBv978
   xM9A+Bhcj0QJ0F94TxVBDOwshPNwVF6q4rTgmo7zXk5T08y7o5JTQjskP
   w2Szj+MeLuT6rPxhLGaN7ORJLwI0H58WamsSRvo0dI/ISIIMDLRIa6SED
   1CU6aK5ygFdWgutBDlctsXwL2ILfI1hbFSjv27PwfcGQ2+igv+vTDkyA6
   fB0UqX+UAupIQ2CXygtpWWp3/vawFoKv5j5dRyUY91KKlknEPPwBxACnq
   /QZrZtCkW4TtKaIQrQbzhAq1E6vWXtlrdWDF9mtQ5hUfkBZvZ7G1qv6Um
   Q==;
X-CSE-ConnectionGUID: 5o/pdYDERM6JQwEbTSDtrQ==
X-CSE-MsgGUID: mgVUZG9sQzOSCGIc3TLD1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1912640"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1912640"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 03:33:32 -0700
X-CSE-ConnectionGUID: +I51gv/KQvejHVn6aiYEzg==
X-CSE-MsgGUID: EyIG9h1pRPmyXudR2oLfCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4789382"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 03:33:30 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Srinivas, Vidya" <vidya.srinivas@intel.com>, "Borah, Chaitanya Kumar"
 <chaitanya.kumar.borah@intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>
Cc: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
 <uma.shankar@intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
In-Reply-To: <PH7PR11MB8252C032AB2E00046CC69C14896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
 <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
 <PH7PR11MB82526C4A1D72F22D44331A7B896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
 <48da0157-6fb3-4e93-a43c-0443c5bcbbb2@intel.com>
 <fe7b9725-be64-4a34-a8b1-b2551fb0ae91@intel.com>
 <PH7PR11MB8252C032AB2E00046CC69C14896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
Date: Wed, 28 Oct 2026 12:33:26 +0200
Message-ID: <126b26709bd8fcd42552c81ec551ecd21dbdc614@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026, "Srinivas, Vidya" <vidya.srinivas@intel.com> wrote:
>> -----Original Message-----
>> From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>> Sent: 28 October 2026 15:07
>> To: Srinivas, Vidya <vidya.srinivas@intel.com>; intel-gfx@lists.freedesk=
top.org
>> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
>> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Lin, Charlton
>> <charlton.lin@intel.com>
>> Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
>>=20
>>=20
>>=20
>> On 10/28/2026 2:58 PM, Borah, Chaitanya Kumar wrote:
>> >
>> >
>> > On 10/28/2026 2:27 PM, Srinivas, Vidya wrote:
>> >>
>> >>
>> >>> -----Original Message-----
>> >>> From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>> >>> Sent: 28 October 2026 14:08
>> >>> To: Srinivas, Vidya <vidya.srinivas@intel.com>; intel-
>> >>> gfx@lists.freedesktop.org
>> >>> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar,
>> >>> Uma <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Lin,
>> >>> Charlton <charlton.lin@intel.com>
>> >>> Subject: Re: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on
>> >>> WCL
>> >>>
>> >>>
>> >>>
>> >>> On 10/28/2026 12:34 PM, Vidya Srinivas wrote:
>> >>>> Pipe joining is not supported in the WCL display configuration.
>> >>>> Report no joiner support on WCL so that modes which would require
>> >>>> joining are rejected, matching the 4k 60Hz maximum resolution
>> >>>> documented for the platform.
>> >>>>
>> >>>> v2: Rebase onto latest upstream
>> >>>> v3: Fix up the commit message
>> >>>> v4: Split the scaler and joiner changes into separate patches
>> >>>> (Jani)
>> >>>>
>> >>>> Bspec: 74286
>> >>>> Cc: stable@vger.kernel.org
>> >>>
>> >>> Won't we need a Fixes tag to tell where this change need to go to?
>> >>
>> >> Hello Chaitanya,
>> >>
>> >> Thank you. Yes, I did check checkpatch gave the same warning but I
>> >> couldn=E2=80=99t find the exact patch to call out the fixes There are=
 patches
>> >> like Extend the max dotclock limit to WCL, Restrict max source rate
>> >> for WCL to HBR3,
>> >> drm/i915/wcl: Add display device info, Add power well mapping for WCL
>> >> etc.
>> >> git log shows under merge tag the "Add support for Wildcat Lake (WCL)
>> >> display, version 30.02"
>> >> So, could not find the patch for which I could mention fixes.
>> >
>> > Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")
>> >
>> > Should be sufficient.
>> >
>>=20
>> Sorry, support for the device id was added even before that.
>>=20
>> Better fit.
>>=20
>> Fixes: f8e1c3e07db1 ("drm/i915/xe3lpd: Add support for display version
>> 30.02")
>>=20
>> It would be worth checking though if these patches applies as is or might
>> need some rebase.
>
> Thank you Chaitanya. Will use this and float again.

You *never* need to resend patches just to add git commit message
trailers.

Doing so means another round of CI and delay for absolutely nothing.

We apply patches using b4, and simply replying with the trailers is
enough to have them picked up.

BR,
Jani.


>
> Regards
> Vidya
>
>>=20
>> =3D=3D
>> Chaitanya
>>=20
>> >>
>> >> Regards
>> >> Vidya
>> >>
>> >>>
>> >>>> Suggested-by: Charlton Lin <charlton.lin@intel.com>
>> >>>> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
>> >>>> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
>> >>>> ---
>> >>>> =C2=A0=C2=A0 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
>> >>>> =C2=A0=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>> >>>>
>> >>>> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
>> >>>> b/drivers/gpu/drm/i915/display/intel_dp.c
>> >>>> index 00e02e019d25..ef164a797618 100644
>> >>>> --- a/drivers/gpu/drm/i915/display/intel_dp.c
>> >>>> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
>> >>>> @@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp
>> >>>> *intel_dp)
>> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return false;
>> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> >>>>
>> >>>> -=C2=A0=C2=A0=C2=A0 return DISPLAY_VER(display) >=3D 12 ||
>> >>>> +=C2=A0=C2=A0=C2=A0 return ((DISPLAY_VER(display) >=3D 12 &&
>> >>>> +DISPLAY_VERx100(display) !=3D
>> >>>> +3002) ||
>> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (DISPL=
AY_VER(display) =3D=3D 11 &&
>> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 encoder->port !=
=3D PORT_A);
>> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 encoder->port !=
=3D PORT_A));
>> >>>> =C2=A0=C2=A0 }
>> >>>>
>> >>>> =C2=A0=C2=A0 static int dg2_max_source_rate(struct intel_dp *intel_=
dp)
>> >>
>> >
>

--=20
Jani Nikula, Intel
