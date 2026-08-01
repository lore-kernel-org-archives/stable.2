Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4E377ECF
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.141.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545029; cv=none; b=XFrCX+vETPhDijQZPzokRW47ecBDtN1PCyhrISPHj4VLsCyhLz+lBhaDLjkCaXQSPaEdG0wr/fqI0l214eLT2WXeb64e7J+3VcSQWkxGN7DRx3Bvk5IZx5J7rBOuqJS7hn6tre/aDkvdr0oEAA0hxdhk75Zumt7AFWBIO+rE9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545029; c=relaxed/simple;
	bh=WLbDmhynmJRBzvC9VtSa8CA/TwQCDnMB1XDczh4z4q8=;
	h=From:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 To:Cc:Content-Type; b=bCLwVbamRp9riqq/lpz59X827DMirGy3QeewFFP/j22qyxdwUTDAs4U2h+t67+TFFVMoFWQZI9FNkWtwbREK32RG4KKncUuj/xHAIJfJlj/YCeqBIeQOpV7Htq1m9ZpKfQXeuGDsaiqrtmx6pubsxXtjm1EFJQqQFC93Bm4axuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io; spf=pass smtp.mailfrom=em.honeycomb.io; dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b=PDVRuyYe; arc=none smtp.client-ip=149.72.141.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=honeycomb.io header.i=@honeycomb.io header.b="PDVRuyYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1785545025;
	bh=4SwiOz+P6AlBXRHcbsCHn1Zsa4G7NoAJXzm3uhDPdUA=;
	b=PDVRuyYent1tun5KWBF3vbAWgrwHjbnCcxSpnfdtJkTNrWuN0b3imKY0cA3aQ1JB28ku
	4EoMxHhlnKg2vn6sOXJ7RnBit8j8GYrhuHbM85dW2OmH0rotouGWs3f+gPPYA36CdFbnQX
	M5s6TEB0rWOdaHf/Xf2VodDUomlGqcPx/mI8roterZzJFZemeawBjkWFqmk7V1bIMe8dqk
	xzcstw/KwQh4W7Fl8rukesRyIYngoo5DEVFytN40yyaeIJfnX0Zw5qutkKew7OKZP8ylqC
	rcB+5htrvrZ1Td9oKUU81iwyXSnas8vGPRjhE1j+te8ewAeqSy7F7p+DQfxSapeA==
Received: by recvd-d665d4899-9s8c2 with SMTP id recvd-d665d4899-9s8c2-1-6A6D4141-20
	2026-08-01 00:43:45.526568514 +0000 UTC m=+280227.423264102
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-20 (SG)
	with ESMTP
	id pSmtPvnkSPWTzLuzNDcNbQ
	Sat, 01 Aug 2026 00:43:45.325 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: Re: [PATCH v3] PCI: Fix BAR resize for devices on a root bus
Date: Sat, 01 Aug 2026 00:43:45 +0000 (UTC)
Message-ID: <20260801004343.9113-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
References: <CABhMZUX+8tjN1Hz=tf6bm+K7BV4r=1RxctiN6W_UPz9+yxG+Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmea+EGMmQ+7m8?=
 =?us-ascii?Q?q1YMDv9WRF2I0+Tf2E1B7irUgU3SAaJXuuqFSwt?=
 =?us-ascii?Q?Y4hB2Sh=2FFbMouJJVRl=2FYE7eebbo9KYuy5q50CsG?=
 =?us-ascii?Q?7IeNvRl=2FDJs5E5nUXCCrA4t=2F1CR7EWaWRdYqLwl?=
 =?us-ascii?Q?hglGOjc3uzyGe58vIbzZxLK+S8ccu1Doa1c8oAH?= =?us-ascii?Q?gwlU?=
To: bjorn.helgaas@gmail.com
Cc: amd-gfx@lists.freedesktop.org, bhelgaas@google.com, bjorn@helgaas.com,
	helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, jacob.martin@canonical.com,
	jon.nettleton@gmail.com, jon@solid-run.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lizf@honeycomb.io, regressions@lists.linux.dev,
	stable@vger.kernel.org
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

> I guess this must be the drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> driver.

Close, but not in this configuration -- that driver binds on the
U-Boot/devicetree variant of this platform. This machine runs the
UEFI/ACPI firmware variant (EDK II), where each PCIe controller is
exposed as a plain PNP0A08 host bridge with standard ECAM (MCFG OEM
"NXP LX2160", 2 entries, one per segment), so it goes through the
generic ACPI ECAM path with no controller-specific driver and no MCFG
quirk.

> so the GPU is on bus 01, which isn't a nice round bus number like
> root buses usually are.  The typical thing would be a root port on
> bus 00 with a secondary bus 01, and amdgpu being on that bus 01.

The firmware genuinely declares the root bus as 01: the host bridge
_CRS bus range is [bus 01-ff], there is no bus 00 in the segment at
all, and no root port device is visible anywhere -- the endpoint is
enumerated directly on the root bus. Both segments follow the same
pattern (NVMe on 0002:01:00.0, GPU on 0004:01:00.0). I'll defer to Jon
(CC'd) on why the firmware hides the root port, but the OS-visible
topology is unambiguous.

> Can you share a dmesg log?

Relevant excerpt below; happy to send the full log off-list or attach
to the Launchpad bug. Note this boot is running with the
amdgpu.rebar=0 workaround on a 7.0.0-28 distro kernel, so amdgpu
initializes successfully (on the native 256MB BAR) -- the host bridge
and topology enumeration is identical on the boots that fail.

  ACPI: MCFG 0x00000000EBE28E98 00004C (v01 NXP    LX2160   000000FF INTL 20151124)
  ...
  ACPI: MCFG table detected, 2 entries
  ...
  ACPI: PCI Root Bridge [PCI0] (domain 0002 [bus 01-ff])
  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
  acpi PNP0A08:00: ECAM area [mem 0x9000100000-0x900fffffff] reserved by PNP0C02:00
  acpi PNP0A08:00: ECAM at [mem 0x9000100000-0x900fffffff] for [bus 01-ff]
  PCI host bridge to bus 0002:01
  pci_bus 0002:01: root bus resource [mem 0x9040000000-0x90ffffffff window] (bus address [0x40000000-0xffffffff])
  pci_bus 0002:01: root bus resource [mem 0x9400000000-0x97ffffffff window]
  pci_bus 0002:01: root bus resource [io  0x0000-0xffff window]
  pci_bus 0002:01: root bus resource [bus 01-ff]
  pci 0002:01:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
  pci 0002:01:00.0: BAR 0 [mem 0x9400000000-0x9400003fff 64bit]
  pci 0002:01:00.0: BAR 0 [mem 0x9400000000-0x9400003fff 64bit]: assigned
  ACPI: PCI Root Bridge [PCI1] (domain 0004 [bus 01-ff])
  acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
  acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
  acpi PNP0A08:01: ECAM area [mem 0xa000100000-0xa00fffffff] reserved by PNP0C02:00
  acpi PNP0A08:01: ECAM at [mem 0xa000100000-0xa00fffffff] for [bus 01-ff]
  PCI host bridge to bus 0004:01
  pci_bus 0004:01: root bus resource [mem 0xa040000000-0xa0ffffffff window] (bus address [0x40000000-0xffffffff])
  pci_bus 0004:01: root bus resource [mem 0xa400000000-0xa7ffffffff window]
  pci_bus 0004:01: root bus resource [io  0x10000-0x1ffff window] (bus address [0x0000-0xffff])
  pci_bus 0004:01: root bus resource [bus 01-ff]
  pci 0004:01:00.0: [1002:6981] type 00 class 0x030000 PCIe Legacy Endpoint
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]
  pci 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]
  pci 0004:01:00.0: BAR 4 [io  0x10000-0x100ff]
  pci 0004:01:00.0: BAR 5 [mem 0xa046000000-0xa04603ffff]
  pci 0004:01:00.0: ROM [mem 0xa0fffe0000-0xa0ffffffff pref]
  pci 0004:01:00.1: [1002:aae0] type 00 class 0x040300 PCIe Legacy Endpoint
  pci 0004:01:00.1: BAR 0 [mem 0xa410200000-0xa410203fff 64bit]
  pci 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: assigned
  pci 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: assigned
  pci 0004:01:00.0: BAR 5 [mem 0xa040000000-0xa04003ffff]: assigned
  pci 0004:01:00.0: ROM [mem 0xa040040000-0xa04005ffff pref]: assigned
  pci 0004:01:00.1: BAR 0 [mem 0xa410200000-0xa410203fff 64bit]: assigned
  pci 0004:01:00.0: BAR 4 [io  0x10000-0x100ff]: assigned
  pci_bus 0004:01: resource 4 [mem 0xa040000000-0xa0ffffffff window]
  pci_bus 0004:01: resource 5 [mem 0xa400000000-0xa7ffffffff window]
  pci_bus 0004:01: resource 6 [io  0x10000-0x1ffff window]
