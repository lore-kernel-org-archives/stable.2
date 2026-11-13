Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590894;
	b=nte3jgg/uJE4nKG+bRtgsvXPPtB/FSsjrSu1bEpu0y0nh8MVxUQwEwTxA+rBq76kUD/r
	 9qkCnpo2qetvj8JEJVGtt8zjdQen1Eh9VHP5c8QNmZYxa6IpkbPWfTbAdsNUnFm+ONAwd
	 Jxczh3MqRcQ/hkuttkY/EtrfTTZDBpWhFZ6cuj9pug46ug68wxrIn3ccMZfu+27fkYeBy
	 mCEYBYIKhUgnW7r1I3ktXgv82OXFEJVQM0kvaxWVR90/g+X2zz+zt5zYK1WPPWoUiTHF0
	 6m++LTpByVLuw10kMAfkwKS/0rTKqZcYtUFwVzcAvsJ8a4A73oT6SqO/chiWJlfi+5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590894;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ziSO+YmPUxunJfjCoEZ5Rsa7KblfwfRchxzctNwTgbc=;
	b=sePbRH7s7V/4Kj63rqTelE+0kZpDdEyo5RlEAcr74JIqkcLi3OavpnJsp2NVUDe4dypi
	 LZ+9rrC4Rwg3R0WtbZEzfe5ib6uHKfMge9mx+ORhzIwFyYXbYPcFk9ozir+9Us6ARPwoX
	 k7bFkDQFp8GIXgpaixPMK34e7K9JULCym4+R2z5gbznFG7lRFz0NydXjEIDFV4xz7dIBc
	 qTv57KNLUJVTMUw3gTDAH/WscPWxH0LCn0IUyNxXPEwNl1ZnXsOe1HCuYseMw6i6dsXgW
	 ODgUJ4o2QpVY5YrR8BO4ASXeZP4tj5VpNKXHsaB98mQXVdJgpbAYoqCIVpNFRgnYu3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="B/wsx2Kq";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85D606E216;
	Fri, 13 Nov 2026 17:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD85D606E216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B/wsx2Kq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794590893; x=1826126893;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=16waxDqNSYau/xhki9mDXaindSEi2mDzGfPV5tNqWpo=;
  b=B/wsx2KqI6nvYAVt7h4RtIfMIh+Lstn+3i2MBcHAm7oi60sqL/hFzRiK
   RGXHkwid+y+yahqSC/mCLwvpuqfgfJT0dHbAWjiNhSyeYagB7MyRkxjYF
   WkJFxp/ZiSJDvYQLL73jfEbZyuUGUSMiOzg3zMjhQcDFRpgYZvf4NM0Ta
   VJ+fliT8i+yFAX9qTURaJtX/lRw70/aTaoMUaWswbfDBVAyb1U8j4Tr00
   vL9Ne9c1OJv/EsQdktaUU5rAd8NVhlQx/cSUvmEhbpFvCLBXKcTccFCHI
   p5EoCShK7ALcYDUOwoLZx/fnMaZE7Rstfu6KDzySHv3sUdeLeSucaUpqv
   Q==;
X-CSE-ConnectionGUID: 5tvrC0lBTxuV9/pCaMp+2A==
X-CSE-MsgGUID: cIr0SZBmQ/GZgY2hJ1QW9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3293893"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3293893"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 09:28:12 -0800
X-CSE-ConnectionGUID: AVoqca5TQXCY+xN4GC9JEQ==
X-CSE-MsgGUID: Y9yyWH/rRM+pifxsca/I+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9138763"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 09:28:12 -0800
Message-ID: <dc5506e2d145bf98ea55b861cac74d7805137470.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Fix Nova Lake-S
 PCI device ID
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sankara Tankala <sankara.narayana@intel.com>, rafael@kernel.org, 
	daniel.lezcano@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 13 Nov 2026 09:28:11 -0800
In-Reply-To: <20261113154001.2081-1-sankara.narayana@intel.com>
References: <20261113154001.2081-1-sankara.narayana@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-13 at 21:10 +0530, Sankara Tankala wrote:
> Nova Lake-S uses the same processor thermal PCI device ID as Nova
> Lake-H, 0xD703. The 0xAD03 ID added for Nova Lake-S is the Arrow
> Lake-S ID (PCI_DEVICE_ID_INTEL_ARL_S_THERMAL).
>=20
> The ARL-S entry comes first in the PCI ID table, so the NVL-S entry
> never matched. However, proc_thermal_rfim_add() matches on the device
> ID alone, so Arrow Lake-S, which has DLVR, wrongly gets the Nova Lake
> DLVR register map.
>=20
> Replace the separate NVL_H and NVL_S IDs with a single NVL ID,
> 0xD703,
> and drop the 0xAD03 entries.
>=20
> Fixes: af1b80b94126 ("thermal: int340x: processor_thermal: Add Nova
> Lake processor thermal device")
> Fixes: dbd911a07f14 ("thermal: intel: int340x: Add DLVR support for
> Nova Lake")
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sankara Tankala <sankara.narayana@intel.com>

    Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
> =C2=A0.../intel/int340x_thermal/processor_thermal_device.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 3 +--
> =C2=A0.../intel/int340x_thermal/processor_thermal_device_pci.c=C2=A0=C2=
=A0 | 7 +----
> --
> =C2=A0.../thermal/intel/int340x_thermal/processor_thermal_rfim.c | 3 +--
> =C2=A03 files changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index b79937a386ec..87d8ff9c7173 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -27,8 +27,7 @@
> =C2=A0#define PCI_DEVICE_ID_INTEL_JSL_THERMAL	0x4E03
> =C2=A0#define PCI_DEVICE_ID_INTEL_LNLM_THERMAL	0x641D
> =C2=A0#define PCI_DEVICE_ID_INTEL_MTLP_THERMAL	0x7D03
> -#define PCI_DEVICE_ID_INTEL_NVL_H_THERMAL	0xD703
> -#define PCI_DEVICE_ID_INTEL_NVL_S_THERMAL	0xAD03
> +#define PCI_DEVICE_ID_INTEL_NVL_THERMAL	0xD703
> =C2=A0#define PCI_DEVICE_ID_INTEL_RPL_THERMAL	0xA71D
> =C2=A0#define PCI_DEVICE_ID_INTEL_SKL_THERMAL	0x1903
> =C2=A0#define PCI_DEVICE_ID_INTEL_TGL_THERMAL	0x9A03
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> index 7d6fee59ade2..f218ee247ab4 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> @@ -501,12 +501,7 @@ static const struct pci_device_id
> proc_thermal_pci_ids[] =3D {
> =C2=A0	=C2=A0 PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
> =C2=A0	=C2=A0 PROC_THERMAL_FEATURE_POWER_FLOOR |
> PROC_THERMAL_FEATURE_PTC |
> =C2=A0	=C2=A0 PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
> -	{ PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL,
> PROC_THERMAL_FEATURE_RAPL |
> -	=C2=A0 PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> -	=C2=A0 PROC_THERMAL_FEATURE_MSI_SUPPORT |
> PROC_THERMAL_FEATURE_WT_HINT |
> -	=C2=A0 PROC_THERMAL_FEATURE_POWER_FLOOR |
> PROC_THERMAL_FEATURE_PTC |
> -	=C2=A0 PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
> -	{ PCI_DEVICE_DATA(INTEL, NVL_S_THERMAL,
> PROC_THERMAL_FEATURE_RAPL |
> +	{ PCI_DEVICE_DATA(INTEL, NVL_THERMAL,
> PROC_THERMAL_FEATURE_RAPL |
> =C2=A0	=C2=A0 PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> =C2=A0	=C2=A0 PROC_THERMAL_FEATURE_MSI_SUPPORT |
> PROC_THERMAL_FEATURE_WT_HINT |
> =C2=A0	=C2=A0 PROC_THERMAL_FEATURE_POWER_FLOOR |
> PROC_THERMAL_FEATURE_PTC |
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 96279756177f..1832f13634d8 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -472,8 +472,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev,
> struct proc_thermal_device *proc
> =C2=A0			dlvr_mmio_regs_table =3D lnl_dlvr_mmio_regs;
> =C2=A0			dlvr_mapping =3D lnl_dlvr_mapping;
> =C2=A0			break;
> -		case PCI_DEVICE_ID_INTEL_NVL_H_THERMAL:
> -		case PCI_DEVICE_ID_INTEL_NVL_S_THERMAL:
> +		case PCI_DEVICE_ID_INTEL_NVL_THERMAL:
> =C2=A0			dlvr_mmio_regs_table =3D nvl_dlvr_mmio_regs;
> =C2=A0			ddr_data_rate_reg =3D &nvl_ddr_data_rate_reg;
> =C2=A0			break;
