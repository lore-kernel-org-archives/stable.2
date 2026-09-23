Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8C48C8DC;
	Wed, 23 Sep 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159281; cv=none; b=TWq87w4nzpW9hyNpn4EX9qURblAg938dsq7/x/C5Cjz/hLt8Sr9AxhBeXZ8U4oemudVUymgB3Lox0YbeHYJ63SqGhhwS51+H0Lcz3lmc2LtTtrOJMkhgTwmeNEmVNZyjw2fz8Jbluks+ZiNctQf0/XYOFcClTVPT7OQGedaHad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159281; c=relaxed/simple;
	bh=8bsRzgiDz06/1Ig7A3wbd46dRe7z3zLwUB654q1EDak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHCKEUoPqVOzDl67G4bMJmXr0htq4G563Q9I8r83bleUw0L3KRgIRZBFxZG/LlZg+Bxf1C9kjPJ9XpFNHGOqIGyz9emr1GB+64ADxYD/bgV54UaX9z3LhMf1qiiNaMiGnC2u+46r30XoMRN1Lpp6gPoMUMajdoSD9okRWYe2KfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 91F3E1685;
	Wed, 23 Sep 2026 12:27:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 404CE6235255; Wed, 23 Sep 2026 12:27:27 +0200 (CEST)
Date: Wed, 23 Sep 2026 12:27:27 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Skip the suspend_noirq config save if
 runtime-suspended
Message-ID: <arOpj4C67BnrNreM@wunner.de>
References: <20260923022511.24932-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923022511.24932-1-navonjohnlukose@gmail.com>

On Wed, Sep 23, 2026 at 07:55:11AM +0530, Navon John Lukose wrote:
> pci_pm_suspend_noirq() saves config space unconditionally when the driver
> of the device has no PM callbacks, which includes unbound devices.  If
> such a device is runtime-suspended, the bridge above it may be in a
> low-power state with the link down.  Depending on the platform, the
> config reads then either hang the CPU or return all ones, which overwrite
> the snapshot taken at runtime suspend and are written back to the device
> on resume.
> 
> Skip the save if the device is runtime-suspended, as pci_pm_freeze()
> does, since pci_pm_runtime_suspend() has already saved the config space.
> Use pm_runtime_status_suspended(), because runtime PM is disabled by the
> noirq phase and pm_runtime_suspended() would always be false.
> 
> Fixes: 931ff68a5a53 ("PCI PM: Restore config spaces of all devices during early resume")
> Cc: stable@vger.kernel.org # v6.19+
> Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
> ---
> Found on a Lenovo Yoga 83KF (Arrow Lake-H).  A driverless O2 Micro SD
> reader at 57:00.0 with power/control=auto lets its root port 00:1c.0
> runtime-suspend to D3hot.  The port then swallows the ECAM reads in
> pci_save_state(), and the forward-progress watchdog raises a fatal machine
> check at the ECAM load in pci_mmcfg_read().

Hm, pci_pm_suspend_noirq() should bail out earlier because of the
dev_pm_skip_suspend() check.  That check resolves to:

  dev_pm_smart_suspend(dev) && pm_runtime_status_suspended(dev)

The code comment in device_prepare_smart_suspend() explains that
smart_suspend is true for devices without PM callbacks.  But only
if the parent has smart suspend enabled as well.  I guess that's
the sticking point?  That the port above the card reader doesn't
have smart suspend enabled?

Thanks,

Lukas
