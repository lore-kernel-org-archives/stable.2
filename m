Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEB2D3727;
	Thu,  3 Sep 2026 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477468; cv=none; b=KiH6xMut56g49ynKJ7k1FJBSP675AAFza/FG1bs/QXog0XbGrJWeHZgWAHba4an0B+mC2O/1Wf0fL2xfj4oMKnJuU7eLU6E8rJvw86WMSJEtioDM2JsnwOwkQchXPTCe7L1GMDXckbpW9ReFvGo9VrB0Mj63UuuY9FvKbgy6/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477468; c=relaxed/simple;
	bh=ZWJ/3x3w0sMhzhHInutTUJVlWfz/6mJWEh0x3bSQ4jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Axc5koUfe5U2PvfaZZBw+hqW3V9OI3kQVRuaUKxnwlS+wAd2fRDV26CQpGsNeW2YfQEDcdQ7t+R6R/SLX7a3xCnz7rTet8jJs7RZ7jTZk51PGnauJHG65cwrz0LXinMvQyCXT/LxmWy4hHYhZffiGS9xmngjmHoF5uJP3mWECI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n81RaHiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n81RaHiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBF41F000E9;
	Thu,  3 Sep 2026 23:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477466;
	bh=lfMVJP15CNby6GYqMdk4jgXZ17b/0NA9rJTRDrei0gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=n81RaHiKX/N1T4V7MBRnI8STBkRiyRbfxYT5/VggpJrQ1jn33d/1/dZX5fJI/P2uI
	 CdTxUq3noSsLyYCt79zposcbGE91xCQTX5S+0OUcmz2Q2cfQOV6rTQ9d/J5x2V67ky
	 CqXZbMB6J6LoXzDNvz7IcHxoSY0KVqXj14AjUxXAekuYv1Ku+Jkrw1SVi2CKfOUFfn
	 Nx5gxaH66lXbXNAUFYA894SkUdH9JZtR5YjLnjtL/sjpj1pLssAhAk7Coz9FHZNrME
	 hr0Toa5eaHxEJ+1+L6Sw+zgIoZA1uk+KtSDkEimn5G73dn+ehW6RqK49YFpxDT/XPJ
	 /nNTpusVeSaEg==
Date: Thu, 3 Sep 2026 18:17:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Angel J <iamanaws@httpd.dev>, Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"robh@kernel.org" <robh@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
Message-ID: <20260903231744.GA2281658@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>

[+to Herve, Lizhi for PCI dynamic OF node stuff]

On Sun, Aug 23, 2026 at 02:14:25AM +0000, Angel J wrote:
> Hello,
> 
> This regression was introduced in v6.17-rc1 and remains in the dynamic
> PCI OF node code. Linux 6.18 fails very early during boot on my Dell XPS
> 8940 when CONFIG_PCI_DYNAMIC_OF_NODES=y. The display goes black before
> any useful console or pstore output appears, and the machine remains
> hung.

Oof, sorry, that's a terrible failure to debug.  Thanks for your
persistence in chasing it.

I don't think 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
is a likely culprit by itself because there's just nothing there that
looks like it would relate to a Dell XPS 8940.

> Disabling CONFIG_PCI_DYNAMIC_OF_NODES makes the same kernel boot normally.
> Linux v6.19-rc5 also boots because the RP1 driver stopped selecting that
> option, not because the dynamic PCI OF node code changed.
> 
> Hardware:
> 
>   System: Dell XPS 8940, board 0K3CM7, BIOS 2.27.1 (2025-04-03)
>   CPU: Intel Core i7-11700 (Rocket Lake)
>   Triggering device: 0000:00:00.0, Intel 8086:4c43
>   Firmware boot: UEFI, ACPI-based x86_64
> 
> Test results:
> 
>   Linux 6.12.103: good
>   Linux v6.17-rc1: bad
>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y: bad
>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=n: good
>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y, skip invalid bridge: good
>   Linux v6.19-rc4: bad
>   Linux v6.19-rc5: good
>   Linux 4621c338d33f: bad
>   Linux e55feea3a03a: good
> 
> The first-parent boundary between the last two tests is:
> 
>   e55feea3a03a ("Merge tag 'soc-fixes-6.19' ...")
> 
> That merge contains ce26f588c831 ("misc: rp1: drop overlay support"), which
> removes:
> 
>   select PCI_DYNAMIC_OF_NODES
> 
> from MISC_RP1. The generated configurations differed only by:
> 
>   -CONFIG_PCI_DYNAMIC_OF_NODES=y
>   +# CONFIG_PCI_DYNAMIC_OF_NODES is not set
> 
> CONFIG_MISC_RP1=m in both. The known-bad 4621c338d33f and Linux 6.18.44
> both boot after disabling PCI_DYNAMIC_OF_NODES (and MISC_RP1, whose Kconfig
> select otherwise forces it on).
> 
> There is no RP1 device in this machine, and its driver does not probe.
> MISC_RP1 affects this x86 system only because its Kconfig select enables
> PCI_DYNAMIC_OF_NODES globally.
> 
> I narrowed the hang to dynamic OF node creation for 0000:00:00.0
> (8086:4c43), the Intel Rocket Lake-S integrated memory controller. On
> this machine it reports PCI class 0604 and header type 1, but it is bound
> to icl_uncore and is not a usable forwarding bridge:
> 
>   Bus: primary=ff, secondary=ff, subordinate=ff
>   I/O and memory bridge windows: invalid/all ones
>   kernel: bridge configuration invalid ([bus ff-ff]), reconfiguring
> 
> A minimal dynamic node for this device boots. Adding only
> device_type="pci" makes it hang. Full PCI dynamic OF node generation also
> boots when only 0000:00:00.0 is skipped.
> 
> I also tested a generic guard in of_pci_make_dev_node(). It reads
> PCI_PRIMARY_BUS and skips node creation if the primary bus does not match
> pdev->bus->number, the secondary bus is not greater than the primary bus,
> or the secondary bus is greater than the subordinate bus. Linux 6.18.44
> boots with CONFIG_PCI_DYNAMIC_OF_NODES=y and logs:
> 
>   pci 0000:00:00.0: skipping dynamic OF node for invalid bridge
> 
> The regression was introduced by 49d63971f963 in v6.17-rc1. Commit
> ce26f588c831 made v6.19-rc5 boot by removing MISC_RP1's select of
> PCI_DYNAMIC_OF_NODES. That avoids the failing path in the tested
> configuration but does not change of_pci_make_dev_node().
> 
> I do not have a log from the failed boots. No output appeared with
> earlyprintk=efi,keep, keep_bootcon, ignore_loglevel, loglevel=8,
> initcall_debug, and EFI pstore enabled. Blacklisting both GPU drivers and
> disabling the Intel IOMMU did not make the bad kernel boot.
> 
> Should of_pci_make_dev_node() reject devices with invalid bridge bus
> configuration, or should 8086:4c43 use a device-specific quirk? I can
> prepare and test a patch for either approach. For Linux 6.18 stable,
> would that fix be preferable to backporting ce26f588c831 and its
> dependencies?

A quirk doesn't sound right because AFAICS there isn't any hardware
defect with the 00:00.0 bridge.

> #regzbot introduced: 49d63971f963
> #regzbot title: PCI_DYNAMIC_OF_NODES early boot hang on ACPI x86
> 
> Thanks,
> Angel J
> 
> 
> 
> 
> 



