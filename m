Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75236F8F2;
	Fri, 10 Jul 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702860; cv=none; b=bhP9mXlaCdl3VifelartX3ajfsTfdF1WbDjBzpQhICJVp49iiuhCbsd/sPgI3RlDXWYPkfhXOvVJCi8vXl+hfrGwOY+bXxK1Jht5CNC9TrWSGDKf2DP5IITc7Vb/LMVVamyvPS53A8gs6SlJFKB2GCKHbweodnebJ4bPjcKB8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702860; c=relaxed/simple;
	bh=ta9uReoNXM9E734F2OwI73vRjMhKCSjm5wGsTTpGPys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JJHmG0uoX8WUmAUx9gszNaS+PnEqm6ru4LfyfwLEbtzP6LveEO8JtYYJCC36pUOstIW1X0N7gyg59UbcbyM62JqD0LWACfx56kbW0hu/8MlRElXgzDXWE6aBRnPI46SuKeX/TViOTaiYNTp3qGhZCoVfthIfGBmTzzw2x+ao2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTyat+rN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTyat+rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D521F000E9;
	Fri, 10 Jul 2026 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702859;
	bh=xqw4aGbDBOtI5MtPNh2QLLbi+BenkFQpG/ie+v9l16I=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=dTyat+rNiQ239nx104E1HxCOu6LvX3TPqwso3sIGO+HtjSiY7Cti4V5AmwOjRANDm
	 l/nT8Lj2FkTnVkiT55T1PFFlrDVkvqWglTv4Ah7lBX5FaQvYKB37ujL0mTsYiPPH83
	 2w9D+IW3CVTA/JMwrwE8Rmb9aVfqwRrTvEroweOaaq0lQo9uX/Qyh7mDYfgTWv4jxI
	 C9rrz3UnYjsh+A7rGlLOoXomy65N2GQ2UHmWFyIQAzwDkUFtnzpsyViRzcmHKxbHeM
	 8CfTT+D5LXcmiEY4N4/1oBbIaPYfHgIr5KbB/0zM2U+ThlIrg+1Iz4udE1vJV/rhk0
	 f2physgXCpJdA==
Date: Fri, 10 Jul 2026 12:00:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Darshit Shah <darnshah@amazon.de>
Cc: lukas@wunner.de, Jonthan.Cameron@huawei.com, bhelgaas@google.com,
	darnir@gnu.org, feng.tang@linux.alibaba.com, kbusch@kernel.org,
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nh-open-source@amazon.com,
	olof@lixom.net, sathyanarayanan.kuppuswamy@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] drivers/pci: Decouple DPC from AER service
Message-ID: <20260710170057.GA960077@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211164257.81655-1-darnshah@amazon.de>

On Thu, Dec 11, 2025 at 04:42:53PM +0000, Darshit Shah wrote:
> According to PCIe r7.0, sec. 6.2.11, "Implementation Note: Determination
> of DPC Control", it is recommended that the Operating System link the
> enablement of Downstream Port Containment (DPC) to the enablement of
> Advanced Error Reporting (AER).
> 
> However, AER is advertised only on Root Port (RP) or Root Complex Event
> Collector (RCEC) devices. On the other hand, DPC may be advertised on
> any PCIe device in the hierarchy. In fact, since the main usecase of DPC
> is for the switch upstream of an endpoint device to trigger a signal to
> the host-bridge, it is imperative that it be supported on non-RP,
> non-RCEC devices.
> 
> Previously portdrv has interpreted the spec to mean that the AER service
> must be available on the same device in order for DPC to be available.
> This is not what the implementation note meant to imply. If the firmware
> hands Linux control of AER via _OSC on the host bridge upstream of the
> device, then Linux should be allowed to assume control of DPC on the device.
> 
> The comment above this check alludes to this, by saying:
>   > With dpc-native, allow Linux to use DPC even if it doesn't have
>   > permission to use AER.
> 
> However, permission to use AER is negotiated at the host bridge, not
> per-device. So we should not link DPC to enabling AER at the device.
> Instead, DPC should be enabled if the OS has control of AER for the
> host bridge that is upstream of the device in question, or if dpc-native
> was set on the command line.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Darshit Shah <darnshah@amazon.de>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Sorry for the delay in picking this up.  Thanks for doing this; I
think it's the right thing.  I think the commit log is not completely
accurate in terms on which devices advertise AER and DPC, so I propose
the following.  I also reordered the || operands to make the patch
easier to read.  Your thoughts?


commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
Author: Darshit Shah <darnshah@amazon.de>
Date:   Thu Dec 11 16:42:53 2025 +0000

    PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER
    
    PCIe r7.0, sec 6.2.11, "Implementation Note: Determination of DPC Control",
    recommends that "... operating systems always link control of DPC to the
    control of Advanced Error Reporting."
    
    Any PCIe device may advertise AER, but only Root Ports and Root Complex
    Event Collectors can generate AER interrupts, so the AER driver only binds
    to RPs and RCECs.
    
    Any Root Port or Switch Downstream Port may advertise Downstream Port
    Containment (DPC), but previously the DPC driver was limited to devices the
    AER driver could bind to, i.e., only RPs that advertised AER.
    
    Since any Port with DPC can generate DPC interrupts, allow the DPC driver
    to bind to such a Port as long as the OS controls AER, regardless of
    whether the AER driver binds to it.
    
    Signed-off-by: Darshit Shah <darnshah@amazon.de>
    [bhelgaas: commit log, reorder || operands to simplify patch]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Lukas Wunner <lukas@wunner.de>
    Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    Cc: stable@vger.kernel.org
    Link: https://patch.msgid.link/20251211164257.81655-1-darnshah@amazon.de


diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 2d6aa488fe7b..65f502602dee 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
 	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    (pcie_ports_dpc_native || host->native_aer))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	/* Enable bandwidth control if more than one speed is supported. */
