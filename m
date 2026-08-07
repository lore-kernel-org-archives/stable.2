Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E739374195;
	Fri,  7 Aug 2026 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128193; cv=none; b=diZdJGiTlPnHNgWtzrpZKKubDxemUHJTCUwG4CvccMxerBurLjQU1EbDrcyUawbxSHh0bEeuUFlaL6h7kQuQjtkKKVgYJCkVSGhFWWM7r8zQtb7/aXy5Lu3x/g6+sm3H2b8NsFJxmSQBffYd5ZfQqI+W8jx6YsUCu8TEvGuYEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128193; c=relaxed/simple;
	bh=SoTuwKA3BkWL/NHeL8b9r41+rq5IGM6tczn+0UacSKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/l4MmEThIG6nTvhFqUV7IFOYdBQvb2rL9a0dVx444EYk8XlHU26EBJ3Bi5IfPVgRf9jTvAMC5DkIgmJQZODx9PCiz+ceoTb18uEvyw8kZEO3w8i68YfxaD6ZvU+NTg6eUWNN2y4XqG+WkpueHGbGYyK7xJOMPRAJ2gAgZzunXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5FlBlQz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5FlBlQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786128191; x=1817664191;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=SoTuwKA3BkWL/NHeL8b9r41+rq5IGM6tczn+0UacSKU=;
  b=P5FlBlQzbr8+WTBX5HP4Vp9CzfB0R+o5gkWfU0WzuIZ+tSSTW84Js9N+
   SFxGSTu63RtQxpWSJy5CAd+xhzxwNV4SOtl82HHryqhQVpE45n5Kd/b81
   fSmJ7Kt3TZTOAXrHrsb/CZEpWS/J5bNF/Z8zvrALkTqsmTfFSbUJMCHQs
   41m8FZtcR8ZoOgN4E79isWGVYNv9Vqz0xxBdC+9ktbkegKn1kkDEKycu6
   xykcn8gEq8/sJSS+EeM5ci5LYWMAldKbv3wlXIJUQn5VBHDN2QG+yLiX9
   NcPme9qdvujHZZiQRX0zgkIvdHZoWnLkLGBYgcQNWXdU+czy8IX+B9VIR
   w==;
X-CSE-ConnectionGUID: SdUByA90RO+wLerkWorxsg==
X-CSE-MsgGUID: tD/SGrewRAmrsU7FDwT0gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86682991"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86682991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 11:43:10 -0700
X-CSE-ConnectionGUID: bwRb/FjfS0GiKHWOZaDBHw==
X-CSE-MsgGUID: FVYq6/jVQR2k8B9eZ60k0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="261176612"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 11:43:09 -0700
Message-ID: <188a703dcb1334750fb389cd7142e262bddae72c.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: ISST: Validate socket ID in
 clos_assoc ioctl
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 07 Aug 2026 11:43:03 -0700
In-Reply-To: <20260807144003.3498972-2-sammiee5311@gmail.com>
References: <20260807144003.3498972-1-sammiee5311@gmail.com>
	 <20260807144003.3498972-2-sammiee5311@gmail.com>
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
> isst_if_clos_assoc() validates the user-supplied socket_id with
> 'socket_id > topology_max_packages()', but isst_common.sst_inst[] is
> allocated with topology_max_packages() entries, so the valid index
> range
> is [0, topology_max_packages()).=C2=A0 The '>' comparison lets
> socket_id =3D=3D topology_max_packages() pass and index one entry past
> the
> array.
>=20
> In addition, isst_common.sst_inst[socket_id] is NULL for an in-range
> package that has no bound TPMI SST instance, and the pointer is used
> without a NULL check.=C2=A0 Both the out-of-bounds entry and the NULL
> pointer
> are then dereferenced by map_partition_power_domain_id() and the
> following power_domain_info access.
>=20
> Reject socket_id >=3D topology_max_packages() and a NULL sst_inst,
> matching
> the checks already performed by get_instance().
>=20
> Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via
> TPMI")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 4 +++=
-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git
> a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 24334ae70d82..b2965baeaa36 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -729,7 +729,7 @@ static long isst_if_clos_assoc(void __user *argp)
> =C2=A0		if (copy_from_user(&clos_assoc, ptr,
> sizeof(clos_assoc)))
> =C2=A0			return -EFAULT;
> =C2=A0
> -		if (clos_assoc.socket_id > topology_max_packages())
> +		if (clos_assoc.socket_id >=3D topology_max_packages())
> =C2=A0			return -EINVAL;
> =C2=A0
> =C2=A0		cpu =3D clos_assoc.logical_cpu;
> @@ -747,6 +747,8 @@ static long isst_if_clos_assoc(void __user *argp)
> =C2=A0		pkg_id =3D clos_assoc.socket_id;
> =C2=A0
> =C2=A0		sst_inst =3D isst_common.sst_inst[pkg_id];
> +		if (!sst_inst)
> +			return -EINVAL;
> =C2=A0
> =C2=A0		punit_id =3D map_partition_power_domain_id(sst_inst,
> punit_id, &part);
> =C2=A0		if (punit_id < 0)
