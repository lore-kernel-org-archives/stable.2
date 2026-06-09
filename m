Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A413F0756;
	Tue,  9 Jun 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999653; cv=none; b=cPhJXmgAnRn8ZRVCBLpDXGUEU94EnC/PSUVzYtyUSl14jB+awnNYUN1opMmY6ySliy3lgR8W2e8t3fj5mt4CSkNRXPEBDk3NGjaPO3733hVwVi/NjMvDNKdq6PlWoAmwBMwgAQLDlZCgaqpUSINm5aOv4m2Ss8ya5L/0jBwy7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999653; c=relaxed/simple;
	bh=i0RQ9L5q7Nb7ZNMKArCU9r518QCO22eZWz5kRlb01MM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jooyScuPl5tIo5jGh7Jx7os1cqb0l6nQ6rMLXN27FX4j6amU0nIBJIsBN2Rw1PEq0LsP/8KUxP5YKFCmVJ4+6BI5KAL76Nd2X+M4HyGozPHwx9TI592AFH0O+bLylyZhBBVmv7Aai4yZbF25PrPPSSjgV+uQzWLNgqq56MWsNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7kJs1V3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7kJs1V3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780999649; x=1812535649;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i0RQ9L5q7Nb7ZNMKArCU9r518QCO22eZWz5kRlb01MM=;
  b=S7kJs1V3BOKUUvEHVO9MeVL6hc/X5tEO71qdQw3pzAa8YUGx39FfDxI/
   xjd/6rdsyRwCLq8IIucOMx8UCk9ERtFM8oZeLQpQBBlWVeR0zMEFa1UIp
   LAEtlgBK1FPhQ5Ub6ACv1ryxdRlHRHwOV7yzp3IZdEtddNzieAcm7Fciq
   wz31DALSitDVGcESNgwa14CTNOwO4y5iZ3HHgqzsfrUZOcKUXuVGlWgms
   OEH5NPq8eNi98QgMlE0QmyulSCdxbJcV6Uz/xdqQzcR0iELmpV+TrsI2T
   txUWl5EJ9mYcMmHVi2GwPNVbDE7Z77UTHGt5OHCco8Kkk02TiPTp3L338
   w==;
X-CSE-ConnectionGUID: DNlkgFPsTr6EemgkeJVEng==
X-CSE-MsgGUID: lXGDBBdySleikKLuaqrIwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81733162"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81733162"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 03:07:28 -0700
X-CSE-ConnectionGUID: 967c7j1FR6G0uFI2HQKnGg==
X-CSE-MsgGUID: ndEerP96Qu+2RNE03h422A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="243376747"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 03:07:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 9 Jun 2026 13:07:21 +0300 (EEST)
To: Daniel Gibson <daniel@gibson.sh>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <superm1@kernel.org>, 
    Sindre Henriksen <sindrehenriksen93@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
In-Reply-To: <20260606044758.2213401-2-daniel@gibson.sh>
Message-ID: <5f0dcb89-0e76-d6eb-a6b0-201a0ed1cd22@linux.intel.com>
References: <20260606044758.2213401-1-daniel@gibson.sh> <20260606044758.2213401-2-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1386652776-1780999641=:1206"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1386652776-1780999641=:1206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 6 Jun 2026, Daniel Gibson wrote:

> Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
> nonfunctional keyboard and lid switch after s2idle.
>=20
> It helps to delay suspend by 2.5 seconds so the EC has some time
> to do whatever it needs to get done before suspend - unfortunately
> at least on my 16ABR8 waking it with a timer (wakealarm) still
> triggers the issue, but at least normal resume via keypress or
> lid works fine. On the 14ARP10 wakealarm has been reported to also
> work fine with this patch.
>=20
> This issue has been reported for many different devices, this patch
> has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
> and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
> 15ARP10 (83MM).
>=20
> Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221383
> Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
> Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org
> ---
>  drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
>  drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
>  drivers/platform/x86/amd/pmc/pmc.h        |  1 +
>  3 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform=
/x86/amd/pmc/pmc-quirks.c
> index 24506e342943..74ddf1d8289a 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -18,6 +18,7 @@
>  struct quirk_entry {
>  =09u32 s2idle_bug_mmio;
>  =09bool spurious_8042;
> +=09bool need_suspend_delay;
>  };
> =20
>  static struct quirk_entry quirk_s2idle_bug =3D {
> @@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 =
=3D {
>  =09.spurious_8042 =3D true,
>  };
> =20
> +static struct quirk_entry quirk_s2idle_need_suspend_delay =3D {
> +=09.need_suspend_delay =3D true,
> +};
> +
>  static const struct dmi_system_id fwbug_list[] =3D {
>  =09{
>  =09=09.ident =3D "L14 Gen2 AMD",
> @@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] =3D {
>  =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>  =09=09}
>  =09},
> +=09/* https://bugzilla.kernel.org/show_bug.cgi?id=3D221383 */
> +=09{
> +=09=09.ident =3D "Zen3-based IdeaPad Slim and similar",
> +=09=09.driver_data =3D &quirk_s2idle_need_suspend_delay,
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +=09=09=09/*
> +=09=09=09 * Note: there are also some Zen2-based 82X* devices that
> +=09=09=09 * need different quirks, they're already handled above
> +=09=09=09 */
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82X"),
> +=09=09}
> +=09},
> +=09{
> +=09=09.ident =3D "Zen3+-based IdeaPad Slim and similar",
> +=09=09.driver_data =3D &quirk_s2idle_need_suspend_delay,
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "83K"),
> +=09=09}
> +=09},
> +=09{
> +=09=09.ident =3D "IdeaPad Slim 3 15ARP10 (83MM)",
> +=09=09.driver_data =3D &quirk_s2idle_need_suspend_delay,
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "83MM"),
> +=09=09}
> +=09},
>  =09/* https://bugzilla.kernel.org/show_bug.cgi?id=3D221273 */
>  =09{
>  =09=09.ident =3D "Thinkpad L14 Gen3",
> @@ -356,6 +390,11 @@ void amd_pmc_process_restore_quirks(struct amd_pmc_d=
ev *dev)
>  =09=09amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
>  }
> =20
> +bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev)
> +{
> +=09return dev->quirks && dev->quirks->need_suspend_delay;
> +}
> +
>  void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
>  {
>  =09const struct dmi_system_id *dmi_id;
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/am=
d/pmc/pmc.c
> index 2b9e5730170a..6bafd8661d68 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -611,6 +611,27 @@ static bool amd_pmc_intermediate_wakeup_need_delay(s=
truct amd_pmc_dev *pdev)
>  =09return get_metrics_table(pdev, &table) =3D=3D 0 && table.s0i3_last_en=
try_status;
>  }
> =20
> +static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
> +{
> +=09/*
> +=09 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
> +=09 * me-time before sleeping or they get uncooperative after waking
> +=09 * up and don't send events for keyboard and lid switch anymore.
> +=09 *
> +=09 * Unfortunately this doesn't entirely fix the problem: It can still
> +=09 * happen when resuming with a timer (wakealarm), but at least the
> +=09 * more common usecases (wakeup by opening lid or pressing a key)
> +=09 * work fine with this workaround.
> +=09 *
> +=09 * See https://bugzilla.kernel.org/show_bug.cgi?id=3D221383
> +=09 */
> +=09if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
> +=09=09dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bu=
g\n");
> +=09=09return true;
> +=09}
> +=09return false;
> +}
> +
>  static void amd_pmc_s2idle_prepare(void)
>  {
>  =09struct amd_pmc_dev *pdev =3D &pmc;
> @@ -647,7 +668,8 @@ static void amd_pmc_s2idle_check(void)
>  =09struct amd_pmc_dev *pdev =3D &pmc;
>  =09int rc;
> =20
> -=09if (amd_pmc_intermediate_wakeup_need_delay(pdev))
> +=09if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
> +=09    amd_pmc_want_suspend_delay(pdev))

This doesn't seem to apply to the review-ilpo-next branch. You might have=
=20
left the first patch of the series out from this v4?

Please send v5 to correct the problem.

--=20
 i.

--8323328-1386652776-1780999641=:1206--
