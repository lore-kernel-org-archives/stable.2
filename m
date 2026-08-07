Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0B37DAA6;
	Fri,  7 Aug 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128271; cv=none; b=oNyqlSgLjuAiCWuDzQ9zKDHq1B6yqdAUXP4ocKDQhM/OwzxBq1W4U3jS/Sqf7U1qtR9udvHgumIxOVQ2eJ+2ejpN8r102L6lCQirLtvsD/pHAFOrWv5xID3chEGJNaqcpsPvkSjrq8WclDPshjpdJH1GNvyhHv5WqnJF5CUDAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128271; c=relaxed/simple;
	bh=KFObHX1iI+l/6qrQhGhFFBiQyOqRqeWlGZE4C0B+E/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E05BoymIu7a5N7C2TGwQkVhSNh3L6YDBl95KEZ5xh3kRcrBEfJVhP2jaG907drAEBww3mdV6cTKkPsZy6OIi0p3IFDpFj1uGw0oD/TvuRuUY+KvEQGytXwvDhRiQSelEExiuHhJGbb3STrrQxEhczfEyQTJzDfzNjtLwnktPWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWHlAF3+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWHlAF3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786128270; x=1817664270;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KFObHX1iI+l/6qrQhGhFFBiQyOqRqeWlGZE4C0B+E/c=;
  b=EWHlAF3+jaOci7i79lA0QLK9hk+jJy3s08ZNQTRGL7AqJ7q6xe3rX1hZ
   pAXbJXBOZ5hC84rFBit1t5N7B+VtI7KdXwCSG5K0Z1bXiN8sh9FcGSOZM
   yWmUBWRMQREogalODMnPAMxTFjeZq/pu3XMgx+3UeIie5ZyKxE2hCzvV3
   6GSR0Juhe6Q6ip0qa6gj9at6JDmXKpfFgX1jAG5kpsAUDzSCY2dm4zQs4
   ksmLFjGYIiGJzbCuThJDQonSv13LvEtpdTghpgLNnaEeuewlModJ9yfUe
   mcvbt4MfFXX8NLM47wzXPP7EdkaYE8PQCMk3YyetibTP5aNnNND5soJg8
   Q==;
X-CSE-ConnectionGUID: n2G9/mzWSIWIDERZWN5y3A==
X-CSE-MsgGUID: 6jRQGXcJSMquSB8588OPeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86754004"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86754004"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 11:44:29 -0700
X-CSE-ConnectionGUID: wNxO9ySrQpK10FPvC7PH0g==
X-CSE-MsgGUID: 8MXiUvy9SuuFwHxoelSR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="287162162"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 11:44:28 -0700
Message-ID: <184506c48a92d6ada2696360a59d10c0cc641ee1.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] platform/x86: ISST: Two ioctl input validation fixes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 07 Aug 2026 11:44:28 -0700
In-Reply-To: <20260807144003.3498972-1-sammiee5311@gmail.com>
References: <20260807144003.3498972-1-sammiee5311@gmail.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-07 at 23:40 +0900, HyeongJun An wrote:
> Two out-of-bounds accesses reachable from the ISST character device
> ioctls, both from user-supplied index values that are not bounded
> before
> use.
>=20
> The first is an off-by-one on socket_id in the CLOS association
> ioctl,
> plus a missing NULL check on the resulting instance pointer. The same
> file already gets both of these right in get_instance(), which
> rejects
> pkg_id with in_range(pkg_id, 0, topology_max_packages()) and then
> checks
> the instance for NULL before returning it.
>=20
> The second is a missing level bound in the two perf-mask ioctls. The
> four adjacent helpers that read the same per-level register block all
> reject a level above max_level first.
>=20
> Neither path is behind CAP_SYS_ADMIN. Commit 69cd1ca440a9
> ("platform/x86:
> ISST: Check for admin capability for write commands") describes
> deployments that relax the permissions on /dev/isst_interface so that
> non-root users can read SST capabilities, and deliberately gates only
> the
> write commands.
>=20
> Found by inspection, not reproduced on hardware.

Thanks for the fixes.

-Srinivas

>=20
> HyeongJun An (2):
> =C2=A0 platform/x86: ISST: Validate socket ID in clos_assoc ioctl
> =C2=A0 platform/x86: ISST: Validate level in perf mask ioctls
>=20
> =C2=A0.../x86/intel/speed_select_if/isst_tpmi_core.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 13
> ++++++++++++-
> =C2=A01 file changed, 12 insertions(+), 1 deletion(-)
