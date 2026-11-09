Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252778;
	b=Zt4kgoVxzsGucXbhSyFd96mKTpl58PCLn3MBNid/cRZzfaJa288p0V2/UP3pRDbA0Pon
	 MuArOjPsUqlzstvDqL0IvPxfjgdwcqLekGR6JZ2VcTyZtTpjn36qjR+jQknisQBqmSxMC
	 SDxDe9dEoFfkbDS1KgejSj09lzdF2vHu3jGjxLVrn6LBB5jCvg4QYRN8ytLClJVZHeN8Y
	 AIEJfp9CEkZUN3Mbw/+JhdAQFpxciB+pHlnxCVd6t+/MGbB/90CW1nw5Zz5LKS4+zNTSv
	 wIXazTMbXBJrRkcdkW/0bq9W1XJ6svX70MXZAmk8jE0uwdCM5bM78yW/O/l+oOvDnHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252778;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZSXwxMGlWr7Pug/wFJpYva3xMFynMrQ7GhmKdoJ3OIo=;
	b=H5FsO8cDOZyifhzMQRO5nT57AfD0nWOmMnt/YMZMGeSjkHO4WAzlAT3COog0iKT7vN0j
	 U+/kZDBM1otjMmFlWmqGqq8KYwW96CcSC1s1bvBaH6Mgw10i9KAAsNk0eLf+51mxyMr4i
	 hZfSXoz5h5YFkXpcCidv3XQzRSXuP5bIxJMEhH2GHhbUiATlc9UnpnZJrGEO/Bbe95sGq
	 +f2U5FygKqq7q40xFAzPCFPxLhjFFwOH4kfgKM/78PU3vDRh4n1Q7rIIu+8G30gWGK/L7
	 7T7wLQ+cRbb5hpbW8wjyhf7sy2f8Z3IXfM8IdRNK1xsrQvFcIhJOVVSvs/NN8QVIZJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpmZFujX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0D606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OpmZFujX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCD41F008AB
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794252777;
	bh=ZSXwxMGlWr7Pug/wFJpYva3xMFynMrQ7GhmKdoJ3OIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OpmZFujXDy+AsRO4cxYAzcxYgwPcZv2pyd+LWDtfhwwCRmac8SLG4bcdkoe7qECFT
	 5c6ym7VHxc5h2TqPE04YC9BWuZbJxN2m8UyDWv6M/n1nAC2CUjP0JBUEW00Wy/qzLI
	 UlY+TbfWrbqHG/COHQt7b1d6X5CO0hrm3ep+ZEb4u1mTndMWtBYc2q+XMfwjSqfGo2
	 67hImHoq1xsos9aMDVkOrRUR419ceHvYCAMAfjEr4gvi9z7ouY/NV4ZHVI+57JILff
	 yX2k7j7l7TvveaIY8ZO0sBPUfYwR5ZPrxlN/ldD+pNx3mBT9/IH+xogujB4zLR8iTO
	 YpPafuUC0MPMA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3acff56a300so11200891fa.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:32:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFT+xcvhgWbhNCFb29cucTwyOKhOJ82EINpfrYzxsG2TaDG6mVFPaSIYzEMW6AEM+vR3H1lauk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8szfi3HYR6nLY7yDUtVGwUwl/1ckM1yrGHRo6C2Ln8asns8PdI
	COp2lTd23A7Ol6HnMxOOAnm1neZ5I3/VroQ0ikouApxkj7o0xtTH1K2Z2psx51AdpWDSpE7s3FH
	a1so53Hu42gvkwW97Sip20clLNIwefVU=
X-Received: by 2002:a05:651c:1545:b0:3ad:f2f4:3fad with SMTP id
 38308e7fff4ca-3ae09612925mr549691fa.6.1794252775536; Mon, 09 Nov 2026
 11:32:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179272791966.20251.3697951431087014523@gmail.com> <20261024054711.21587-1-vicajilau@gmail.com>
In-Reply-To: <20261024054711.21587-1-vicajilau@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 9 Nov 2026 20:32:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
X-Gm-Features: AclHuK9-c9Ryfl5N2jtyPvBQFb4rzVSGuwMbl24Es4rYrolQlF2DS_ZomWSF_9g
Message-ID: <CAJZ5v0iqOoS8t-5PFeLPuaJrpeByx2Yr-dnpYU2fT6yTb6-7=A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594
 dGPU root port
To: Victor Carreras <vicajilau@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 7:47=E2=80=AFAM Victor Carreras <vicajilau@gmail.co=
m> wrote:
>
> On MSI Summit E16 Flip A12UCT (motherboard MS-1592, BIOS E1592IMS.111)
> and MSI Prestige 16 Studio A13VE / Summit E16 Flip A13VET (motherboard
> MS-1594, BIOS E1594IMS.115), the I2C touchpad (ELAN0305:00, 04F3:31FD)
> permanently stops generating interrupts as soon as the discrete NVIDIA
> GPU (0000:01:00.0) and its parent PCIe Root Port (0000:00:06.0,
> \_SB.PC00.PEG0) enter D3cold.
>
> In the platform's SSDT (MSI_NB / AdlP_Rvp), \_SB.PC00.PEG0 sets its wake
> GPIO (WAKG) from the BIOS NVS variable P1WP, which erroneously points to
> GPP_A20 (INTC1055:00 pin 62) -- the GPIO interrupt line wired to the
> touchpad.
>
> During boot, \_SB.PC00.PEG0.PON() calls \_SB.SHPO(WAKG, One), setting
> PAD_CFG0_GPP_A20.GPIROUTSCI =3D 0 and HostSwOwn =3D 1 so the OS GPIO driv=
er
> owns the pin. However, when the root port runtime-suspends to D3cold,
> Linux enables ACPI wakeup via \_SB.PC00.PEG0._DSW(1, 0, 3), which sets
> WKEN =3D 1. Subsequent evaluation of \_SB.PC00.PEG0.PXP._OFF -> POFF()
> executes:
>
>   If (CondRefOf (WAKG))
>   {
>       If (((WAKG !=3D Zero) && WKEN))
>       {
>           \_SB.SHPO (WAKG, Zero)
>       }
>   }
>
> This switches GPP_A20 ownership to ACPI GPE mode (HostSwOwn =3D 0,
> GPIROUTSCI =3D 1), silencing the touchpad interrupt until the dGPU wakes
> back up to D0. Under Windows, _DSW is not armed for S0 D3cold on this
> root port, leaving WKEN =3D 0 so POFF() powers off the dGPU (\PIN.OFF(PWR=
G))
> without touching GPP_A20.
>
> Add a PCI quirk in drivers/acpi/x86/utils.c for boards MS-1592 and
> MS-1594 on root port 0000:00:06.0 (8086:464d on 12th Gen Alder Lake-P
> and 8086:a74d on 13th Gen Raptor Lake-P/H) to disable wakeup capability.
> This keeps WKEN =3D 0 so the root port and dGPU still reach D3cold
> normally while leaving GPP_A20 owned by the GPIO driver.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220725
> Cc: stable@vger.kernel.org
> Signed-off-by: Victor Carreras <vicajilau@gmail.com>

Please see Sashiko's feedback on this one and let me know what you
think about it:

https://sashiko.dev/#/patchset/20261024054711.21587-1-vicajilau%40gmail.com

> ---
> Changes in v2:
> - Move the quirk from drivers/pci/quirks.c to drivers/acpi/x86/utils.c
>   as it is x86-specific (Lukas Wunner).
> - Drop clearing adev->wakeup.flags.valid in the final fixup so ACPI
>   power resource dependent tracking between pci_acpi_setup() and
>   pci_acpi_cleanup() remains balanced.
> - Link to v1: https://lore.kernel.org/r/179272791966.20251.36979514310870=
14523@gmail.com
>
>  drivers/acpi/x86/utils.c | 47 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 4189516..84a6ca7 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -665,3 +665,50 @@ void __init acpi_proc_quirk_mwait_check(void)
>          */
>         dmi_check_system(acpi_proc_quirk_mwait_dmi_table);
>  }
> +
> +/*
> + * On MSI Summit E16 Flip A12UCT (board MS-1592) and MSI Prestige 16 Stu=
dio
> + * A13VE / Summit E16 Flip A13VET (board MS-1594), the BIOS SSDT (MSI_NB=
 /
> + * AdlP_Rvp) assigns the touchpad's GPIO interrupt pin (GPP_A20) as the =
PCIe
> + * wake GPIO (WAKG / P1WP) for the dGPU root port (\_SB.PC00.PEG0, 0000:=
00:06.0).
> + *
> + * When ACPI wakeup is armed on this root port via _DSW (setting WKEN =
=3D 1),
> + * subsequent D3cold transitions (\_SB.PC00.PEG0.PXP._OFF -> POFF) call
> + * \_SB.SHPO(WAKG, Zero), switching GPP_A20 ownership from GPIO driver m=
ode
> + * to ACPI GPE mode and permanently freezing the I2C touchpad (ELAN0305:=
00).
> + *
> + * Disable wakeup on this root port so _DSW is not armed and WKEN remain=
s zero
> + * during D3cold transitions.
> + */
> +static const struct dmi_system_id msi_peg0_no_wakeup_dmi_table[] =3D {
> +       {
> +               .ident =3D "MSI MS-1592",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star Internati=
onal Co., Ltd."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "MS-1592"),
> +               },
> +       },
> +       {
> +               .ident =3D "MSI MS-1594",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star Internati=
onal Co., Ltd."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "MS-1594"),
> +               },
> +       },
> +       {}
> +};
> +
> +static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
> +{
> +       if (pci_dev_id(dev) !=3D PCI_DEVID(0, PCI_DEVFN(6, 0)))
> +               return;
> +
> +       if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
> +               return;
> +
> +       pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPI=
O (GPP_A20) takeover in D3cold\n");
> +       device_wakeup_disable(&dev->dev);
> +       device_set_wakeup_capable(&dev->dev, false);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_w=
akeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_w=
akeup);
> --
> 2.55.0
>
