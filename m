Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794767967;
	b=HTq+O0FLpPUmEJGYvF+uRWjK4UO/XzSIDPVYQ6ZqYJTjpp6G0wb4dVxyuCTwBp0vrcTL
	 yloCKJVP4aXsjL29nGu9ylWOgCFkFePmJ7G9Te0FhfLRADN3dP9DqPcl23yqQX7Tsfi16
	 silQvdi5ZKV2AKArC2kn9UVvEObonjga3M7N9T2IQU+Jcwy3A1oR7StlP7zTaO6sHr7+C
	 Qob51+QBMh1EcNXc3PK8NbHGJ97aOgE08+K87qn52z0YukDDg4hZj02VtAmdk27LnbzA8
	 9IRziwUVfssH/neOQcPBj19gVPNnDGRNqoasatbCVN5LKtdGduUEFGrC/ebWXhwuRNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794767967;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=U0QYZMkI+aHL2rJZs8Panb3OQBENH9JOHq63W5JMa0A=;
	b=dHn8Hz0suD9LvHxlVB0/cO6yp1JsDWJd6pm2lQTrWbkziP9H17ajhGgH2GZ86Y214u1Y
	 WB8UjNY9DSnAFHhGuQqmmm/nt67ghc+/SIz6+yv+TDGJ0aMuaACl2EeWWaBmXCCLl0rMU
	 JA/Xlb7vNK9R+DN9VIupTboJ/FWXr3/N5jdvSkxGSdo2BXGd8M3dG98is2kWy73fZOmn6
	 sPuuujGYKiyCAgA5A4kvy5zad9v5WzkBRAGji/UTUDPwYvn1kt+zRuKHP6a9yC3qEXxUZ
	 QFfatWmUVeJax87DZo+RJgiYjiPHqwBkk12UogFYIuquBLPbu2lOk26+LFWGe/AUGhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qv8J5o1P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E8606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qv8J5o1P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AE31F000C8
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794767967;
	bh=U0QYZMkI+aHL2rJZs8Panb3OQBENH9JOHq63W5JMa0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qv8J5o1PQ0O70GFi+RsF9YDWNG0YcQ289szn3ZPVRl2GWdRWNPoYDsXTezmRG7sN8
	 k7d6nX1GpJSGv/KIXJrZ1er+OLQH7pU55OJkyuwNvOarF1oOyZmv+aSFJvkcg/op9g
	 vQJgS5vPHmocAvPP4qxzVdd9r1aLDmo6a1fW75LLmINcKwXjRuJ0PiAj7jsMI4uYGM
	 mqSl5dfG3gBRIJeIC8IBz87NlNmZLMyb+e41D8MpBnlwyz3TneTag6zjRgkblez7jX
	 Dvr8NbTfpTW1kmHecSoaNsS7UdjafdpEkNaePUaq5toslF3zB62EEzCpUlXPultBJJ
	 BOT/3kvXkdTEQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso2329150e87.2
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGVOUEnqZkhOhqkF+NG4JMxI3osx+aJXRYfyHMLQLNvm3bMHd2vKZA0r6irU4rZKD3JPdSS7mw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZExBof3sAxfXG0DzqNsXttUacXRFZnXwaBKtfWxqrmGUFaakE
	LTcH5mVvwWhobeq2XcqadTjNAcNc5ONRyVyS0kOu4PqWERVY1Eup1RtIBWLd4UtmoUW5AT60BLs
	dYksHOI9MIKsINgfv1g3w55HWc7MWzJE=
X-Received: by 2002:a05:6512:228d:b0:5c1:79b4:4424 with SMTP id
 2adb3069b0e04-5c179b4459cmr2054409e87.53.1794767965565; Sun, 15 Nov 2026
 10:39:25 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113154001.2081-1-sankara.narayana@intel.com> <dc5506e2d145bf98ea55b861cac74d7805137470.camel@linux.intel.com>
In-Reply-To: <dc5506e2d145bf98ea55b861cac74d7805137470.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sun, 15 Nov 2026 19:39:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gnYpBs8B9Gok2Lm=00arAyN=+=HcG3HqsHKc1oDnDv0A@mail.gmail.com>
X-Gm-Features: AclHuK-UZ2oD5yEqZKUPb9JSapjunu6M1-qXX4TN9O_342wenyQn0cJHAr-7Kpw
Message-ID: <CAJZ5v0gnYpBs8B9Gok2Lm=00arAyN=+=HcG3HqsHKc1oDnDv0A@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Fix Nova Lake-S PCI
 device ID
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Sankara Tankala <sankara.narayana@intel.com>
Cc: daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 6:28=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2026-11-13 at 21:10 +0530, Sankara Tankala wrote:
> > Nova Lake-S uses the same processor thermal PCI device ID as Nova
> > Lake-H, 0xD703. The 0xAD03 ID added for Nova Lake-S is the Arrow
> > Lake-S ID (PCI_DEVICE_ID_INTEL_ARL_S_THERMAL).
> >
> > The ARL-S entry comes first in the PCI ID table, so the NVL-S entry
> > never matched. However, proc_thermal_rfim_add() matches on the device
> > ID alone, so Arrow Lake-S, which has DLVR, wrongly gets the Nova Lake
> > DLVR register map.
> >
> > Replace the separate NVL_H and NVL_S IDs with a single NVL ID,
> > 0xD703,
> > and drop the 0xAD03 entries.
> >
> > Fixes: af1b80b94126 ("thermal: int340x: processor_thermal: Add Nova
> > Lake processor thermal device")
> > Fixes: dbd911a07f14 ("thermal: intel: int340x: Add DLVR support for
> > Nova Lake")
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sankara Tankala <sankara.narayana@intel.com>
>
>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 7.4-rc material, thanks!

> > ---
> >  .../intel/int340x_thermal/processor_thermal_device.h       | 3 +--
> >  .../intel/int340x_thermal/processor_thermal_device_pci.c   | 7 +----
> > --
> >  .../thermal/intel/int340x_thermal/processor_thermal_rfim.c | 3 +--
> >  3 files changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > index b79937a386ec..87d8ff9c7173 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> > @@ -27,8 +27,7 @@
> >  #define PCI_DEVICE_ID_INTEL_JSL_THERMAL      0x4E03
> >  #define PCI_DEVICE_ID_INTEL_LNLM_THERMAL     0x641D
> >  #define PCI_DEVICE_ID_INTEL_MTLP_THERMAL     0x7D03
> > -#define PCI_DEVICE_ID_INTEL_NVL_H_THERMAL    0xD703
> > -#define PCI_DEVICE_ID_INTEL_NVL_S_THERMAL    0xAD03
> > +#define PCI_DEVICE_ID_INTEL_NVL_THERMAL      0xD703
> >  #define PCI_DEVICE_ID_INTEL_RPL_THERMAL      0xA71D
> >  #define PCI_DEVICE_ID_INTEL_SKL_THERMAL      0x1903
> >  #define PCI_DEVICE_ID_INTEL_TGL_THERMAL      0x9A03
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> > c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> > c
> > index 7d6fee59ade2..f218ee247ab4 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> > c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> > c
> > @@ -501,12 +501,7 @@ static const struct pci_device_id
> > proc_thermal_pci_ids[] =3D {
> >         PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_WT_HINT |
> >         PROC_THERMAL_FEATURE_POWER_FLOOR |
> > PROC_THERMAL_FEATURE_PTC |
> >         PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
> > -     { PCI_DEVICE_DATA(INTEL, NVL_H_THERMAL,
> > PROC_THERMAL_FEATURE_RAPL |
> > -       PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> > -       PROC_THERMAL_FEATURE_MSI_SUPPORT |
> > PROC_THERMAL_FEATURE_WT_HINT |
> > -       PROC_THERMAL_FEATURE_POWER_FLOOR |
> > PROC_THERMAL_FEATURE_PTC |
> > -       PROC_THERMAL_FEATURE_SOC_POWER_SLIDER) },
> > -     { PCI_DEVICE_DATA(INTEL, NVL_S_THERMAL,
> > PROC_THERMAL_FEATURE_RAPL |
> > +     { PCI_DEVICE_DATA(INTEL, NVL_THERMAL,
> > PROC_THERMAL_FEATURE_RAPL |
> >         PROC_THERMAL_FEATURE_DLVR | PROC_THERMAL_FEATURE_DVFS |
> >         PROC_THERMAL_FEATURE_MSI_SUPPORT |
> > PROC_THERMAL_FEATURE_WT_HINT |
> >         PROC_THERMAL_FEATURE_POWER_FLOOR |
> > PROC_THERMAL_FEATURE_PTC |
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > index 96279756177f..1832f13634d8 100644
> > --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> > @@ -472,8 +472,7 @@ int proc_thermal_rfim_add(struct pci_dev *pdev,
> > struct proc_thermal_device *proc
> >                       dlvr_mmio_regs_table =3D lnl_dlvr_mmio_regs;
> >                       dlvr_mapping =3D lnl_dlvr_mapping;
> >                       break;
> > -             case PCI_DEVICE_ID_INTEL_NVL_H_THERMAL:
> > -             case PCI_DEVICE_ID_INTEL_NVL_S_THERMAL:
> > +             case PCI_DEVICE_ID_INTEL_NVL_THERMAL:
> >                       dlvr_mmio_regs_table =3D nvl_dlvr_mmio_regs;
> >                       ddr_data_rate_reg =3D &nvl_ddr_data_rate_reg;
> >                       break;
