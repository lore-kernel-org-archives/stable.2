Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7575A381E9A;
	Fri,  7 Aug 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128242; cv=none; b=a4hydrCjnkvLlLQ81rddmu2U/7FOd5tnRFfIYtNuRkJn9UlsO+sfK9rfwKMXtrqwl6qPPkrXIxx/PSeyUptxaN3/DsEWObRXwe5XFUQ1d8q1pP/qcY+4faQ6gbFzMaCNzr0aoTnAWA5j9VWGt3SA3jgCJCRmXv5A+txstYtNKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128242; c=relaxed/simple;
	bh=Li2bF1Qa1Kne42S2clg+CXLFGUErXVc50f7GFkXcp38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K27SaKJ0s4QKOk25mkpLcrXQ8q3c/vfw7lYWR4QT/D4s5nwKFjn3c49rRxScyRln7/xo2WHH9kCd5XOjjpAHrNW61kPUIYM5fLB+cwIVkh1ozw+bXDKDWBZctpuEB9LsoNbmAsWu8UW5/91z9QE+0lmsB9pj5fG7hJxSSTCR8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNBUlcaH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNBUlcaH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786128240; x=1817664240;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Li2bF1Qa1Kne42S2clg+CXLFGUErXVc50f7GFkXcp38=;
  b=fNBUlcaHg3Eg3VEiBXgPSeq5EwSEigEAXdoTHI3rQQlNPOii/lsWEHIU
   /LiRAlVIzqN0DEGrp1nAOvyNh5H3A4lvh5Y7KhgCbuIbzV9FxPqVmYMkd
   pXZwqI7UBTiUIwqf7UarhCgTRTXhyW2tJENst426UyrKEfbRIiYwO9+Gn
   5jMQ++nYTBAQ2E0S48zUQrxKc3cQ+hjdeuj5DvvgzIpHiwQhged7wUwRR
   csvkkZ32A+ydIJ/F8F89OdZBX6jlezExc0lkpPXFXtQJkzNx6PeiGiK0h
   S+semB3LnrTOtjHk/I9urj+GGMRTcsavqxjjskjCcSLkjvPLDgRPtpxdx
   Q==;
X-CSE-ConnectionGUID: aDVHFwYbStmNoB8munSmfQ==
X-CSE-MsgGUID: Xjs6SeJgQNSRIfHR2YBZTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104141374"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="104141374"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 11:43:58 -0700
X-CSE-ConnectionGUID: YHSRs9BSTBm5Sp0UH0hGhQ==
X-CSE-MsgGUID: CqO1PwEYQHuBYLDjdtWBEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="260718813"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.41])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 11:43:58 -0700
Message-ID: <930a4677a7c8a65f621893549b1527a8f3ecb536.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: ISST: Validate level in perf mask
 ioctls
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 07 Aug 2026 11:43:57 -0700
In-Reply-To: <20260807144003.3498972-3-sammiee5311@gmail.com>
References: <20260807144003.3498972-1-sammiee5311@gmail.com>
	 <20260807144003.3498972-3-sammiee5311@gmail.com>
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
> isst_if_get_perf_level_mask() and isst_if_get_base_freq_mask() use
> the
> user-provided level as an index into perf_levels[] via
> _read_pp_level_info() and _read_bf_level_info(), but neither helper
> validates it first.
>=20
> The adjacent level-info helpers reject levels above max_level before
> reading the same per-level register block. Add the same bounds checks
> to
> the mask helpers, and reject disabled SST-PP levels in
> isst_if_get_perf_level_mask() to match isst_if_get_perf_level_info().
>=20
> This prevents out-of-bounds reads from the per-level offset table on
> invalid ioctl input.
>=20
> Fixes: ea009e4769fa3 ("platform/x86: ISST: Add SST-PP support via
> TPMI")
> Fixes: 06a61df83209 ("platform/x86: ISST: Add SST-BF support via
> TPMI")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0.../platform/x86/intel/speed_select_if/isst_tpmi_core.c=C2=A0 | 9
> +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git
> a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index b2965baeaa36..f1b6109521c5 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -1263,6 +1263,12 @@ static int isst_if_get_perf_level_mask(void
> __user *argp)
> =C2=A0	if (!power_domain_info)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (cpumask.level > power_domain_info->max_level)
> +		return -EINVAL;
> +
> +	if (!(power_domain_info->pp_header.level_en_mask &
> BIT(cpumask.level)))
> +		return -EINVAL;
> +
> =C2=A0	_read_pp_level_info("mask", mask, cpumask.level,
> SST_PP_INFO_2_OFFSET,
> =C2=A0			=C2=A0=C2=A0=C2=A0 SST_PP_RSLVD_CORE_MASK_START,
> SST_PP_RSLVD_CORE_MASK_WIDTH,
> =C2=A0			=C2=A0=C2=A0=C2=A0 SST_MUL_FACTOR_NONE)
> @@ -1344,6 +1350,9 @@ static int isst_if_get_base_freq_mask(void
> __user *argp)
> =C2=A0	if (!power_domain_info)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (cpumask.level > power_domain_info->max_level)
> +		return -EINVAL;
> +
> =C2=A0	_read_bf_level_info("BF-cpumask", mask, cpumask.level,
> SST_BF_INFO_1_OFFSET,
> =C2=A0			=C2=A0=C2=A0=C2=A0 P1_HI_CORE_MASK_START,
> P1_HI_CORE_MASK_WIDTH,
> =C2=A0			=C2=A0=C2=A0=C2=A0 SST_MUL_FACTOR_NONE)
