Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A83E40F3;
	Fri, 16 Oct 2026 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186886; cv=none; b=UnSjcU/lNWSZRLkW2SSAs6LvIUNjWXbvgCmMcG+etm0GxWb5Z4Mg8YFp/8LU5A6a/i7SXELpfjr94d9CZFOqAVzMlFCxPqh45saz8yVJ/9B+w641T8fDBx25Cpghzn+78T2MAZM1Xbjsr1FjuSMqFHtQtt0BVTQr+z0lbpakmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186886; c=relaxed/simple;
	bh=QIgnUXlbiLx9EEgz8FvAf9L1rd4SgT2sOP93nNhslrI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fe5ip5/oLDFUzQNsWiwC93riaiaHLDY66F7AP/kJWAiIY2TaxfLPj/NP6tMuHkyEsVeIQSouHjFhr0nf9zM2l2lwu57Kp3YBcxqDQ4geHoH7w0NeB4+vPyjshszY0WjywnLjqVq8D2XgLj447QrtqMi6MIazwQK0d7bUX40lGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDMeX8KF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDMeX8KF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28DE1F000C4;
	Fri, 16 Oct 2026 21:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792186885;
	bh=JUDBnrW28gehfNTEclfWXj2rC2kKDVBh4m1iqdq7Kcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RDMeX8KFOkhHjI8n3QCztKH7owT2CMLZhL2q5VLujdEJw+F4BpxLmbj+krUwuj60e
	 ug7DziDcFJAmUFfFuwzP/qT/s961bofdw52yR5MBmPNIQxVE3w9XXKa0JoIyG+zGls
	 eGgjtLt/d5t3jBZ8/CVH4Si+A4WKbemwC+YCBDHffEscD5+L57E8oD+T4m5Sj2FlrI
	 dWXuAGDu6R+nKnvAmZRdMw9AdXh8VT5XfHI8HWlChBHmYDdE+BtxFa5p/e1OEiuTid
	 is1AD8152LCBSmcbiN7Nin+Y/7DbbIcLhFQLCG0kO38QqlfixDzjHs583rHrHohvnv
	 ePl6EdRzIlN4A==
Date: Fri, 16 Oct 2026 16:41:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if
 runtime-suspended
Message-ID: <20261016214123.GA1884818@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923022511.24932-1-navonjohnlukose@gmail.com>

[+cc Francisco, tangentially related to your series at
https://lore.kernel.org/linux-pci/20260930141914.6678-1-fbeltranmillalen@gmail.com/t/#u]

On Wed, Sep 23, 2026 at 07:55:11AM +0530, Navon John Lukose wrote:
> pci_pm_suspend_noirq() saves config space unconditionally when the driver
> of the device has no PM callbacks, which includes unbound devices.  If
> such a device is runtime-suspended, the bridge above it may be in a
> low-power state with the link down.  Depending on the platform, the
> config reads then either hang the CPU or return all ones, which overwrite
> the snapshot taken at runtime suspend and are written back to the device
> on resume.

Right, bridges in non-D0 states don't forward requests downstream, so
they end with Unsupported Request (PCIe r7.0, sec 5.3.1) or master
abort (PCI PM r1.2, sec 6).  It's up to the host bridge to choose how
to report those.

> Skip the save if the device is runtime-suspended, as pci_pm_freeze()
> does, since pci_pm_runtime_suspend() has already saved the config space.

pci_pm_freeze() doesn't call pci_save_state() itself, so I guess it's
the combination of pci_pm_freeze() and pci_pm_freeze_noirq(), where if
not runtime-suspended, pci_pm_freeze() clears dev->state_saved so
pci_pm_freeze_noirq() will call pci_save_state()?

> Use pm_runtime_status_suspended(), because runtime PM is disabled by the
> noirq phase and pm_runtime_suspended() would always be false.
> 
> Fixes: 931ff68a5a53 ("PCI PM: Restore config spaces of all devices during early resume")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>

Seems ok to me, but would be good to get Rafael's ack.

> ---
> Found on a Lenovo Yoga 83KF (Arrow Lake-H).  A driverless O2 Micro SD
> reader at 57:00.0 with power/control=auto lets its root port 00:1c.0
> runtime-suspend to D3hot.  The port then swallows the ECAM reads in
> pci_save_state(), and the forward-progress watchdog raises a fatal machine
> check at the ECAM load in pci_mmcfg_read().
> 
> The same port returns all ones for CF8/CFC reads.  A local quirk hid the
> reader's extended config space so the save did only those reads, and it
> was tried once on each kernel.  The unpatched kernel still died, and the
> patched one resumed with no "restore config" writes for the reader.
> 
> !pci_dev->state_saved would only work for one cycle per boot, because
> pci_restore_state() clears it and pci_pm_runtime_suspend() does not run
> again for a device left in RPM_SUSPENDED.
> 
> Stable starts at v6.19 because the fix relies on a2f1e22390ac2 ("PCI/ERR:
> Ensure error recoverability at all times").  Older trees still return
> early from pci_restore_state() when state_saved is false, so a backport
> there also needs "pci_dev->state_saved = true;" on the skip path.
> 
> Tested on 7.2.5 with the root port in D3hot, three suspend/resume cycles
> in one boot.  The unpatched kernel dies on the first.  W=1 and sparse
> clean.
> 
>  drivers/pci/pci-driver.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e16aa59dd..bdc8bad57 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -915,7 +915,15 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  		return pci_legacy_suspend_late(dev);
>  
>  	if (!pm) {
> -		pci_save_state(pci_dev);
> +		/*
> +		 * The bridge above a runtime-suspended device may be in a
> +		 * low-power state with the link down, which makes the device's
> +		 * config space inaccessible.  pci_pm_runtime_suspend() has
> +		 * saved it already.
> +		 */
> +		if (!pm_runtime_status_suspended(dev))
> +			pci_save_state(pci_dev);
> +
>  		goto set_unknown;
>  	}
>  
> -- 
> 2.55.0
> 
