Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47015E5DC;
	Sat, 11 Jul 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783778075; cv=none; b=Al+xDGSx7apM/IIO2mLQrjiY9YN5MhBzcHECyl96c1mjtP1fU68XP6Q8QlMpkboF7qNkfayBhcrXhzH+/Dcmrai+yMFgeERpsFAln4BbjAaRDOxianzWgnb4DW96CHdg3m385FtlsYJxFXvwhyUJJ1+TIqyhPxjqKkf3dNLy8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783778075; c=relaxed/simple;
	bh=IyJkGHn8BNCIq4ysDChVnCKN8b4hhg33eCDIwMAfzB8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT+pg6tWiVgNz2IFh8FxqaHUHqriui/dJtwahsyYOmDnxtQ/2JA/luUmcGN0zk5NFdZ6i9e9j8mCGExkmjKiekRUcMbgu3arYFKgFFiQi/OYcd/aa76pnjV9yncH23BIFN/1w6uF81+n/FE4M8oXrq/wRP70JgF0Hb9sH6bPNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ZJSTX1T7; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZJSTX1T7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783778074; x=1815314074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OjcFJ6UCGNLlUKthY71D30gqh+ZGS3IPq879UM/GKa0=;
  b=ZJSTX1T7mQ/UqpUfPhJJTOobA9IdpHwgP1SQfRoy78+oB6mZGhjzCrMA
   uNdbmDe3pfbX6i40Q0UO8JrYMzKSQNyScC3NqpF1LmcktZ+RuPCpGvLo5
   ckobStmbbrqc1i7VuDlbGHVEI7jJnkSSxUATzDyb7vbW5uPJh5lOYBPop
   dnY0su6ED/sPWFTxZdjbOrjtze4RB57wrBLyG/eICJ2dJV5BoUJJR27OR
   5bEKjbxv4YjNS7NxTy2m5fu5WnX6EDTmY0J1jg1vmLbGgzzf5GKMEhAPp
   9dZk6eE/UeCr742hteCXDOPFwIpElqeFxZUdRmukGz8Z+czp/1g3qRh+k
   g==;
X-CSE-ConnectionGUID: MvLBC9XPRjm1fDLcfYC3Dw==
X-CSE-MsgGUID: hhPwLb/oT1u3WzMimVLiBA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23472283"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 13:54:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:30377]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525] with esmtp (Farcaster)
 id 98ec0c57-0cfc-4116-9382-e668306ac0be; Sat, 11 Jul 2026 13:54:31 +0000 (UTC)
X-Farcaster-Flow-ID: 98ec0c57-0cfc-4116-9382-e668306ac0be
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 13:54:30 +0000
Received: from dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com (10.1.57.121)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 13:54:28 +0000
Date: Sat, 11 Jul 2026 13:54:26 +0000
From: Darshit Shah <darnshah@amazon.de>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lukas@wunner.de>, <Jonthan.Cameron@huawei.com>, <bhelgaas@google.com>,
	<darnir@gnu.org>, <feng.tang@linux.alibaba.com>, <kbusch@kernel.org>,
	<kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>, <olof@lixom.net>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3] drivers/pci: Decouple DPC from AER service
Message-ID: <alJKZaVJWhBmPe8S@dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com>
References: <20251211164257.81655-1-darnshah@amazon.de>
 <20260710170057.GA960077@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260710170057.GA960077@bhelgaas>
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

* Bjorn Helgaas <helgaas@kernel.org> [260710 17:00]:
> On Thu, Dec 11, 2025 at 04:42:53PM +0000, Darshit Shah wrote:
> > According to PCIe r7.0, sec. 6.2.11, "Implementation Note: Determination
> > of DPC Control", it is recommended that the Operating System link the
> > enablement of Downstream Port Containment (DPC) to the enablement of
> > Advanced Error Reporting (AER).
> > 
> > However, AER is advertised only on Root Port (RP) or Root Complex Event
> > Collector (RCEC) devices. On the other hand, DPC may be advertised on
> > any PCIe device in the hierarchy. In fact, since the main usecase of DPC
> > is for the switch upstream of an endpoint device to trigger a signal to
> > the host-bridge, it is imperative that it be supported on non-RP,
> > non-RCEC devices.
> > 
> > Previously portdrv has interpreted the spec to mean that the AER service
> > must be available on the same device in order for DPC to be available.
> > This is not what the implementation note meant to imply. If the firmware
> > hands Linux control of AER via _OSC on the host bridge upstream of the
> > device, then Linux should be allowed to assume control of DPC on the device.
> > 
> > The comment above this check alludes to this, by saying:
> >   > With dpc-native, allow Linux to use DPC even if it doesn't have
> >   > permission to use AER.
> > 
> > However, permission to use AER is negotiated at the host bridge, not
> > per-device. So we should not link DPC to enabling AER at the device.
> > Instead, DPC should be enabled if the OS has control of AER for the
> > host bridge that is upstream of the device in question, or if dpc-native
> > was set on the command line.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Darshit Shah <darnshah@amazon.de>
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Sorry for the delay in picking this up.  Thanks for doing this; I
> think it's the right thing.  I think the commit log is not completely
> accurate in terms on which devices advertise AER and DPC, so I propose
> the following.  I also reordered the || operands to make the patch
> easier to read.  Your thoughts?
> 
Thanks. I think the commit log is more succint and accurate now. I'm okay with it.

> 
> commit 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
> Author: Darshit Shah <darnshah@amazon.de>
> Date:   Thu Dec 11 16:42:53 2025 +0000
> 
>     PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER
>     
>     PCIe r7.0, sec 6.2.11, "Implementation Note: Determination of DPC Control",
>     recommends that "... operating systems always link control of DPC to the
>     control of Advanced Error Reporting."
>     
>     Any PCIe device may advertise AER, but only Root Ports and Root Complex
>     Event Collectors can generate AER interrupts, so the AER driver only binds
>     to RPs and RCECs.
>     
>     Any Root Port or Switch Downstream Port may advertise Downstream Port
>     Containment (DPC), but previously the DPC driver was limited to devices the
>     AER driver could bind to, i.e., only RPs that advertised AER.
>     
>     Since any Port with DPC can generate DPC interrupts, allow the DPC driver
>     to bind to such a Port as long as the OS controls AER, regardless of
>     whether the AER driver binds to it.
>     
>     Signed-off-by: Darshit Shah <darnshah@amazon.de>
>     [bhelgaas: commit log, reorder || operands to simplify patch]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Lukas Wunner <lukas@wunner.de>
>     Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>     Cc: stable@vger.kernel.org
>     Link: https://patch.msgid.link/20251211164257.81655-1-darnshah@amazon.de
> 
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 2d6aa488fe7b..65f502602dee 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    (pcie_ports_dpc_native || host->native_aer))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	/* Enable bandwidth control if more than one speed is supported. */
