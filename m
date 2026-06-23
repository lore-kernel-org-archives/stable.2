Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12D1376A1C;
	Tue, 23 Jun 2026 01:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177798; cv=none; b=njwBtnGTN2B3inEeiLqu8xBEJYwLCM0+P47ORKxL0KZr2nvdzxOuKWmh7nAQesGz37f0EKf3W+AgMJinwCVKenzIg9hfeQVxk+6WZvM+ZHPs/n7HZZT+Vr8DwpZKdRP7fKWuMpcPhxP3eAoO4F1sKlo6hXHHm/PHuFsCDK4C6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177798; c=relaxed/simple;
	bh=oVkYBhX4ckMADZ3BY2MLMBmfbpRJYIkPG2KM5nCiBJo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oj9do+y2e/TXQEzJZ8iy6MEWybI1qPC31XlPlC+BMAa2uL8iikiTscmVxyMEHuKb1pDRAgPPawkilqAJag+/c5QeNEh2ZfgyBGGNZyLMJLB0kgh2rDJANj7vq7JcXSzl2Uqncbv70MPSqdCJj8L1xAbUncaldGy+YJWaYdWM47w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Loy16NaQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Loy16NaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782177797; x=1813713797;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oVkYBhX4ckMADZ3BY2MLMBmfbpRJYIkPG2KM5nCiBJo=;
  b=Loy16NaQziyN+r3ydQxUnRjNEZ/nr5zTjBwig97VZbET27LP4xGnq/tM
   9n5McKLo2UZLAxAnEo2ekfUST72rHfacgMrBnDW4HtQ46H4qyWnXJnuf5
   5HE+G98Hwj8Os9e9YXehCYzGdYpSrVj541ZQCUswHZjQxjmG87vKQVjDM
   Xz8IX/k6RDPdBOW4wJ+7WEFkrwRG7nJapFbQol43/ML7Cy+4eQURvZUEB
   tgLB4dzp12llw/IlZuXySMUwSe0psWbp+GKK7SRvMWqBgxyADfWFPvCZT
   +T/Uqc2aJcIDmC0DPgiOOWA730ObDpUwJ7Tl5c9kztsO7JU+8Jo9FHiai
   w==;
X-CSE-ConnectionGUID: nmL3BiC4TzOlQobXCRNeLw==
X-CSE-MsgGUID: B0r7XL/OTD6hD4U03OVnKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94303208"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="94303208"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:23:16 -0700
X-CSE-ConnectionGUID: QiZhHHMER5erNt3qq39K2g==
X-CSE-MsgGUID: 5HwxqJ1yTL6Lpu0EaOu/Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="249505213"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.223.41])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 18:23:16 -0700
Message-ID: <ec8074628da9ec3e628f4c40fda7ffb3cb8fe001.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform/x86: ishtp_eclite: Fix ACPI device
 reference leak in probe error path
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ma Ke <make_ruc2021@163.com>, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, sumesh.k.naduvalath@intel.com, 
	mgross@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org
Date: Mon, 22 Jun 2026 18:23:08 -0700
In-Reply-To: <20260623010539.2367634-1-make_ruc2021@163.com>
References: <20260623010539.2367634-1-make_ruc2021@163.com>
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

On Tue, 2026-06-23 at 09:05 +0800, Ma Ke wrote:
> ecl_ishtp_cl_probe() acquires a reference to an ACPI device via
> acpi_find_eclite_device() but fails to release it in the error path
> when acpi_opregion_init() fails. This results in a reference count
> leak, preventing proper cleanup of the ACPI device.
>=20
> Calling path: acpi_find_eclite_device() ->
> acpi_dev_get_first_match_dev() -> acpi_dev_get_next_match_dev() ->
> bus_find_device() -> get_device().
>=20
> Found by code review.
>=20
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org
> Fixes: 7b6bf51de974 ("platform/x86: Add Intel ishtp eclite driver")
> ---
Whenever you post a new version, you should add change log here,
showing what is the new in this version.

But here I think you only capitalized the first letter for "Fix".

Thanks,
Srinivas


> =C2=A0drivers/platform/x86/intel/ishtp_eclite.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel/ishtp_eclite.c
> b/drivers/platform/x86/intel/ishtp_eclite.c
> index 93ac8b2dbf38..bca7e217878b 100644
> --- a/drivers/platform/x86/intel/ishtp_eclite.c
> +++ b/drivers/platform/x86/intel/ishtp_eclite.c
> @@ -600,13 +600,16 @@ static int ecl_ishtp_cl_probe(struct
> ishtp_cl_device *cl_device)
> =C2=A0	rv =3D acpi_opregion_init(opr_dev);
> =C2=A0	if (rv) {
> =C2=A0		dev_err(cl_data_to_dev(opr_dev), "ACPI opregion init
> failed\n");
> -		goto err_exit;
> +		goto err_put;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Reprobe devices depending on ECLite - battery, fan, etc.
> */
> =C2=A0	acpi_dev_clear_dependencies(opr_dev->adev);
> =C2=A0
> =C2=A0	return 0;
> +
> +err_put:
> +	acpi_dev_put(opr_dev->adev);
> =C2=A0err_exit:
> =C2=A0	ishtp_set_connection_state(ecl_ishtp_cl,
> ISHTP_CL_DISCONNECTING);
> =C2=A0	ishtp_cl_disconnect(ecl_ishtp_cl);
