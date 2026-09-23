Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907D3F86E0;
	Wed, 23 Sep 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184777; cv=none; b=C9klZu3zUGc74Dhp+nyfgKniA5bOG10q5uwScaLEFuk3pPdtG4JciH32uCx6veRMXxLEHdd5981VXy+XtfraE2nMYIFwTl1UeKJfRlnhq6H86fPyiZWRF+ZuQJjeOCEcSY69jyxaWJc365RBAX/rBBYpYP5YCSQ4Tc6Otz6zWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184777; c=relaxed/simple;
	bh=FP0Mb8KeKMNrSPUoYIGOFn3+H3dFxB84MIyTNC+Sdfk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VaXRWUmIDWwaDH9CPC2vPicUlEV64pNTXi9Upv54UHhKzcP0EW/PkVwGuXDJXV+v17UupeLFqI5ZgqjlWr8R2wEhgYPPtBbVT5U0+e6zuEoP2nZPWYGdrq7ogjUpcrIVzukPomeNCbCQFsQJdrXttQofYFggSs4D0sIEOcGIXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnX9gc31; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnX9gc31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790184775; x=1821720775;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FP0Mb8KeKMNrSPUoYIGOFn3+H3dFxB84MIyTNC+Sdfk=;
  b=OnX9gc3196253KunqBjVPbzIJYp+ICGWUGyNE0PIXAL3+Z3mLDZd6Kb0
   cIgb9mKsJVnAuPUAEwNPeRM0TxEcp3jS3sfhbh1nIrdOBLxJbMWG3INbF
   U8Nh/YJ44/a4op7GkMYCybQOlBSNHFjspXLIsi5NhC0XY5wJskmHqQstR
   HGX1oNfwR+ppQq3sur5vwvksMY0lxNSsLKA8slZ5mRp7N3aMSvxtS/X4L
   qjRylbmKUOVZP8Oa4LJVZfmmhhiHgNDYm2Fj+4cvBbh27q30VboyLgXaL
   mZzrUUU8/kw96esdjmXfGKKq2+dfdNXtFti9ULoBW2VfwTC/wGzWjhCLi
   g==;
X-CSE-ConnectionGUID: VZgNpU7aSf2gkZ1Wvh1taw==
X-CSE-MsgGUID: GNkUXj77T92PP37+PNlnGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89823713"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="89823713"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:32:54 -0700
X-CSE-ConnectionGUID: FrZCBLnQS4+PQXR1v0NzsQ==
X-CSE-MsgGUID: Y87W2wcrRv2Xh0SamGduoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="301645996"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:32:54 -0700
Message-ID: <6f4801cacb3f4c81905bd85567c32b0b4e3aaa5a.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: Fix use-after-free in
 proc_thermal_pci
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fan Wu <fanwu01@zju.edu.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
Date: Wed, 23 Sep 2026 10:32:53 -0700
In-Reply-To: <20260923072730.487900-1-fanwu01@zju.edu.cn>
References: <20260923072730.487900-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 07:27 +0000, Fan Wu wrote:
> proc_thermal_pci_remove() cancels pci_info->work before disabling the
> interrupt sources that schedule it. A threshold IRQ which arrives
> after
> the cancel but before the THRES_0 and INT_ENABLE_0 MMIO mask makes
> proc_thermal_irq_handler() reschedule the work, so
> proc_thermal_threshold_work_fn() runs after devm cleanup has freed
> pci_info and dereferences pci_info->tzone and proc_priv->mmio_base.
> The
> shared IRQ is never freed in remove(), which widens the window, and
> the
> probe error paths never cancel the work either.
>=20
> Fix this by cutting off the producers before draining: mask the
> THRES_0
> and INT_ENABLE_0 registers, free the MSI interrupts or the shared
> IRQ,
> and only then cancel the delayed work. The probe error paths cancel
> the
> work before the thermal zone is unregistered.
>=20
> The work function re-enables the INT_ENABLE_0 bit, but the IRQs are
> already freed when it is cancelled and THRES_0 stays cleared, so
> nothing
> can schedule the work again.
>=20
> This issue was found by an in-house static analysis tool.
>=20
> Fixes: acd65d5d1cf4 ("thermal/drivers/int340x/processor_thermal: Add
> PCI MMIO based thermal driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0.../processor_thermal_device_pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++++--
> =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> index c693d93..1856e76 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> @@ -409,7 +409,10 @@ static int proc_thermal_pci_probe(struct pci_dev
> *pdev, const struct pci_device_
> =C2=A0err_free_vectors:
> =C2=A0	if (msi_irq)
> =C2=A0		proc_thermal_free_msi(pdev, pci_info);
> +	else
> +		devm_free_irq(&pdev->dev, pdev->irq, pci_info);
> =C2=A0err_ret_tzone:
> +	cancel_delayed_work_sync(&pci_info->work);
> =C2=A0	thermal_zone_device_unregister(pci_info->tzone);
> =C2=A0err_del_legacy:
> =C2=A0	if (!pci_info->no_legacy)
> @@ -424,13 +427,16 @@ static void proc_thermal_pci_remove(struct
> pci_dev *pdev)
> =C2=A0	struct proc_thermal_device *proc_priv =3D
> pci_get_drvdata(pdev);
> =C2=A0	struct proc_thermal_pci *pci_info =3D proc_priv->priv_data;
> =C2=A0
> -	cancel_delayed_work_sync(&pci_info->work);
> -
> =C2=A0	proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_THRES_0,
> 0);
> =C2=A0	proc_thermal_mmio_write(pci_info,
> PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
> =C2=A0
> =C2=A0	if (msi_irq)
> =C2=A0		proc_thermal_free_msi(pdev, pci_info);
> +	else
> +		devm_free_irq(&pdev->dev, pdev->irq, pci_info);
> +
> +	/* Cancel after the IRQs are freed, or the handler may
> reschedule it. */
> +	cancel_delayed_work_sync(&pci_info->work);
> =C2=A0
> =C2=A0	thermal_zone_device_unregister(pci_info->tzone);
> =C2=A0	proc_thermal_mmio_remove(pdev, pci_info->proc_priv);
