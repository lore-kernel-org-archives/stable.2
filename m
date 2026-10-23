Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743093;
	b=vuuIX/7b+ORJ03Egw6VEMp2Hpf0jwbfvlxepCc0BSCqGw1P2SrvJzt/7uoMIRd6xfR6o
	 FwWLe6uZRkwsPAx738mCPwalYp6GL+GZGfXyDpPBLXBH9yLagoeb63pNpvvH8V21knzxC
	 R1p6sLdCju7oljenYz3oLR0CeTWHVmqfyn6xUOd4SyEQriGWDnlmswtnrh0RnI+vR8+Ey
	 ka5FP+4GUzJITzDRWFq2qWSwBda/yXh/9ZA3OKc0I+zGCE4oWSolZ24hgSDQFaRK8bY8C
	 v1lfdNIdBDDJ3uMr/kRUce0QdTfbZXs3Jelva4GrKR5ycmM3pe4kB623i9xj5gPSgCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743093;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VDhlxQBnMuuRhd3rHD9iMGQ3axNSTqn+gIoNOpATh3k=;
	b=1wlwD7TZW2UsrLTqvzZmk3nAc7+vLspt3l82SM6ZY8HsM7jcnFWhjFCwix+VtffFrhvN
	 tBgP4tvD2hkIBHY8g1d0s86IN4PzLjad4CkcP5EdpYRyHYzQaX454g+gIkFDI9vClcEdg
	 xO353YODJuk+pwH3Uzw2pIGHC4lxtnMOc9FWdAe+x7sR5pmFj2JW9Sr6rtclGqQvyCjpQ
	 pkEF2p3ToTvGOMTgaH1Zlb09Y2Wr9UDjnu+iwqt7VTBZeFvYvvgQg/Y7PoA7LwEwFFRot
	 gz2FTUs7kJ18n4IWKKjdG1+XnLAvOIzBajXaRFBCQ6ih1wTbE4Xnt8QLNskyNNDPg1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DD606A328;
	Fri, 23 Oct 2026 08:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F24DD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id AE5323BE;
	Fri, 23 Oct 2026 10:11:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9828A600E2C7; Fri, 23 Oct 2026 10:11:22 +0200 (CEST)
Date: Fri, 23 Oct 2026 10:11:22 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Victor Carreras <vicajilau@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594 dGPU
 root port
Message-ID: <atsWqqpFptswGQKy@wunner.de>
References: <179272791966.20251.3697951431087014523@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179272791966.20251.3697951431087014523@gmail.com>

On Fri, Oct 23, 2026 at 05:58:39AM +0200, Victor Carreras wrote:
> +++ b/drivers/pci/quirks.c
> @@ -3941,6 +3941,56 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>  			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>  			       quirk_apple_poweroff_thunderbolt);
> +
> +/*
> + * On MSI Summit E16 Flip A12UCT (board MS-1592) and MSI Prestige 16 Studio
> + * A13VE / Summit E16 Flip A13VET (board MS-1594), the BIOS SSDT (MSI_NB /
> + * AdlP_Rvp) assigns the touchpad's GPIO interrupt pin (GPP_A20) as the PCIe
> + * wake GPIO (WAKG / P1WP) for the dGPU root port (\_SB.PC00.PEG0, 0000:00:06.0).
> + *
> + * When ACPI wakeup is armed on this root port via _DSW (setting WKEN = 1),
> + * subsequent D3cold transitions (\_SB.PC00.PEG0.PXP._OFF -> POFF) call
> + * \_SB.SHPO(WAKG, Zero), switching GPP_A20 ownership from GPIO driver mode
> + * to ACPI GPE mode and permanently freezing the I2C touchpad (ELAN0305:00).
> + *
> + * Disable ACPI wakeup on this root port so _DSW is not armed and WKEN
> + * remains zero during D3cold transitions.
> + */
> +static const struct dmi_system_id msi_peg0_no_wakeup_dmi_table[] = {
> +	{
> +		.ident = "MSI MS-1592",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
> +			DMI_MATCH(DMI_BOARD_NAME, "MS-1592"),
> +		},
> +	},
> +	{
> +		.ident = "MSI MS-1594",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
> +			DMI_MATCH(DMI_BOARD_NAME, "MS-1594"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> +
> +	if (!adev || pci_dev_id(dev) != PCI_DEVID(0, PCI_DEVFN(6, 0)))
> +		return;
> +
> +	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
> +		return;
> +
> +	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP_A20) takeover in D3cold\n");
> +	device_wakeup_disable(&dev->dev);
> +	device_set_wakeup_capable(&dev->dev, false);
> +	adev->wakeup.flags.valid = 0;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_wakeup);

This is x86-specific but drivers/pci/quirks.c is used by all arches.
It should rather live e.g. in drivers/acpi/x86/utils.c.

Thanks,

Lukas
