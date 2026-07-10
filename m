Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD73DCD85;
	Fri, 10 Jul 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676441; cv=none; b=Y0AotF1snHlgM0jU9UxYRKP1W3J3eUaOyc3VzW2TK0yUmdLWy2UBXTh03jqiP9q0CpjyaSIZ0z699iF/B77yY7tOWmKU2lT4SADfwF6wQQTBJHQZz14gMlOhfw8Y19/0UAEFrMJjgB6zLToAtOxBsy50icWtA+hR8Gj/CEo9uQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676441; c=relaxed/simple;
	bh=Bco30pkmBJ3vHbq74KBJPgFzC6EKt2iNizjU2jr6nII=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VCXTaR/fhyWUc59n5NJTh24vn0xohKiiKHRnNXIv/qagiA2E/DD7DLdZFict5x+RKyWbfHiicJt8S8G1O1vA4g8DrF/Zc1Il7KvRsEhFnmZYga4eluk/Sl7xDLHtzcEAXWxyp8de+u8ooQ8Li9B1xeWfgqNln6Et476jxfxXMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Byla+G3R; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Byla+G3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783676440; x=1815212440;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Bco30pkmBJ3vHbq74KBJPgFzC6EKt2iNizjU2jr6nII=;
  b=Byla+G3RtlMf6UqHUHTl3Nseg/0RpaozCVhixUY7Yb9qlCROMQlngKoY
   nYIUTvOSy4H4Q2XApSJv+nE0nVSJpHIi/0Ip0oRVsaMtGllRSOr1qmRfJ
   tRA0GhcIzE63i+Lx4KjPqAEBrVl9inqMINHjHyd+7zn5BId01rkzZNxZe
   qokoOhfkPpeux20NU5plCn9HXGf0CXI5In6oh8LtAFA8ZLWPd/iNleOVT
   cJ4olBngV4/KGWO5QjKWXJFEf/7KPfvEMVy7lT+XjuqfDGpcJTYTppWe2
   wpROBzNO6KmdcHNJyjDlcjx1fA4OXRgijT9e4Z9JoQHNa8ldPtpEDGmyz
   A==;
X-CSE-ConnectionGUID: 8FCqRLecRTizNz8rIJAyKQ==
X-CSE-MsgGUID: dpQDdMxZTX2XODDE111Jsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101799407"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101799407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:40:39 -0700
X-CSE-ConnectionGUID: jhSTWVnWSIuYaigQ1B9dMQ==
X-CSE-MsgGUID: /8RuRA+qT929N+IA37LA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="250431205"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:40:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Jul 2026 12:40:32 +0300 (EEST)
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
cc: s.shravan@intel.com, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: int1092: Fix potential memory leak in
 sar_probe()
In-Reply-To: <20260710052806.100107-1-nihaal@cse.iitm.ac.in>
Message-ID: <a83ad3d5-107c-0a24-93f6-44fe64405b02@linux.intel.com>
References: <20260710052806.100107-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-628998968-1783676432=:1178"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-628998968-1783676432=:1178
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Jul 2026, Abdun Nihaal wrote:

> The memory allocated for device_mode_info in parse_package() called by
> sar_get_data() is not freed in some of the error paths in sar_probe().
> Fix that by converting to use device managed allocations.
>=20
> Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
>=20
> v1->v2:
> - Changed the patch to instead use device managed allocations for both
>   the device_mode_info and the context structure, as suggested by Ilpo
>   J=C3=A4rvinen.
>=20
> Link to v1: https://patchwork.kernel.org/project/platform-driver-x86/patc=
h/20260707070524.953741-1-nihaal@cse.iitm.ac.in/
>=20
>  .../platform/x86/intel/int1092/intel_sar.c    | 30 +++++--------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/pla=
tform/x86/intel/int1092/intel_sar.c
> index 849f7b415c1e..f234e1f55aec 100644
> --- a/drivers/platform/x86/intel/int1092/intel_sar.c
> +++ b/drivers/platform/x86/intel/int1092/intel_sar.c
> @@ -91,8 +91,8 @@ static acpi_status parse_package(struct wwan_sar_contex=
t *context, union acpi_ob
>  =09    item->package.count <=3D data->total_dev_mode)
>  =09=09return AE_ERROR;
> =20
> -=09data->device_mode_info =3D kmalloc_objs(struct wwan_device_mode_info,
> -=09=09=09=09=09      data->total_dev_mode);
> +=09data->device_mode_info =3D devm_kmalloc_array(&context->sar_device->d=
ev,
> +=09=09=09data->total_dev_mode, sizeof(*data->device_mode_info), GFP_KERN=
EL);

Hi,

You could add second patch to this series to convert it into=20
devm_kcalloc() to have the memory zeroed. In that patch, please align=20
the parameters to (.

sashiko seemed to even find a way to expose the uninitialized memory into=
=20
userspace (Reported-by: sashiko.dev + Closes: https://sashiko.dev/#/patchse=
t/20260710052806.100107-1-nihaal%40cse.iitm.ac.in)

>  =09if (!data->device_mode_info)
>  =09=09return AE_ERROR;
> =20
> @@ -253,7 +253,7 @@ static int sar_probe(struct platform_device *device)
>  =09if (!handle)
>  =09=09return -ENODEV;
> =20
> -=09context =3D kzalloc_obj(*context);
> +=09context =3D devm_kzalloc(&device->dev, sizeof(*context), GFP_KERNEL);
>  =09if (!context)
>  =09=09return -ENOMEM;
> =20
> @@ -264,7 +264,7 @@ static int sar_probe(struct platform_device *device)
>  =09result =3D guid_parse(SAR_DSM_UUID, &context->guid);
>  =09if (result) {
>  =09=09dev_err(&device->dev, "SAR UUID parse error: %d\n", result);
> -=09=09goto r_free;
> +=09=09return result;
>  =09}
> =20
>  =09for (reg =3D 0; reg < MAX_REGULATORY; reg++)
> @@ -272,43 +272,29 @@ static int sar_probe(struct platform_device *device=
)
> =20
>  =09if (sar_get_device_mode(device) !=3D AE_OK) {
>  =09=09dev_err(&device->dev, "Failed to get device mode\n");
> -=09=09result =3D -EIO;
> -=09=09goto r_free;
> +=09=09return -EIO;
>  =09}
> =20
>  =09result =3D sysfs_create_group(&device->dev.kobj, &intcsar_group);
>  =09if (result) {
>  =09=09dev_err(&device->dev, "sysfs creation failed\n");
> -=09=09goto r_free;
> +=09=09return result;
>  =09}
> =20
>  =09if (acpi_install_notify_handler(ACPI_HANDLE(&device->dev), ACPI_DEVIC=
E_NOTIFY,
>  =09=09=09=09=09sar_notify, (void *)device) !=3D AE_OK) {
>  =09=09dev_err(&device->dev, "Failed acpi_install_notify_handler\n");
> -=09=09result =3D -EIO;
> -=09=09goto r_sys;
> +=09=09sysfs_remove_group(&device->dev.kobj, &intcsar_group);
> +=09=09return -EIO;
>  =09}
>  =09return 0;
> -
> -r_sys:
> -=09sysfs_remove_group(&device->dev.kobj, &intcsar_group);
> -r_free:
> -=09kfree(context);
> -=09return result;
>  }
> =20
>  static void sar_remove(struct platform_device *device)
>  {
> -=09struct wwan_sar_context *context =3D dev_get_drvdata(&device->dev);
> -=09int reg;
> -
>  =09acpi_remove_notify_handler(ACPI_HANDLE(&device->dev),
>  =09=09=09=09   ACPI_DEVICE_NOTIFY, sar_notify);
>  =09sysfs_remove_group(&device->dev.kobj, &intcsar_group);
> -=09for (reg =3D 0; reg < MAX_REGULATORY; reg++)
> -=09=09kfree(context->config_data[reg].device_mode_info);
> -
> -=09kfree(context);
>  }
> =20
>  static struct platform_driver sar_driver =3D {
>=20

--=20
 i.

--8323328-628998968-1783676432=:1178--
