Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851253;
	b=R5YsRV55CmC/zyW4N+mgoruJmvPA04dRnNOFsRCiLOaFq7stKVF02wU5+FX4vjW782fm
	 U6R6Bcr/gORiMrz8l/VsVGn0nLVYlcSVEbtaL2uo0dVugKvDqhSKSR/kkEtYbGLfGxv3x
	 poxIvDNro+YskV/mlr3z1yaxHNDJcjaVA91d2mDRvPVXU74YrKF4ghoTgLWLQHd7ucy14
	 guZAHU8OlgZjkvevOIgdalFUB9EN9OgGhm4Ynz7q/XQynPQ4pe8z/Kn3xyOC0rkf5uqPk
	 8fqz7EdB5pqQrB3IL2xrOALK6sV8s/hLw3Igyoo/Ves3BcoAPLlUplOLLBkUPNOa0jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851253;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NRUJe6MVEMvrDdXoLeC9w5XnpWEenCh40gdtvYmgW/c=;
	b=Q9lNGZxOzbCuLU/xZ2yvA81vBEMEdC2lazbC8zTKtgYP9CcoAIYvRZhlRyhDGD3FtT7E
	 Bj7k7KjyLNuBU0OfNcP60Ddrv05KsHNdyVBo4dj4uNTptjifAAVJ3E4xuZwJHZ83sz3Ud
	 Xp9Be2EKr37xjFJ+pSepe4OMHG123qVHbnYRzFuvIWKt2ZjRGsLOSLNR3yDqeL5EQQW8B
	 DXTmX56edT7jLNMkZtUpJwi484+l1SCUHFilwcsa6pgrBZBNKfKJzwrUgIzDO9qcOHg6m
	 V7gNrqsMQ5hW0MyvzDHOajtHZzW3P8zzj7+UToHxuXUFjxRC3zeS4ajPOANad6HeQLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aSKO6t5U;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68165606A32F;
	Mon, 16 Nov 2026 17:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68165606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aSKO6t5U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794851253; x=1826387253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z28S/J0MHq2vQ14wwJPl/Jn2BHQeVC0tMuYPC+cnwRY=;
  b=aSKO6t5UzoLo4X+cSLF1Fc1kEnjVj3AFTSy9Q/hBUr6QIp+1q+ZpXyt3
   UEeZuoZwfrt13wySC+X+qYqEhddm6DyO6FATCATgWTjGND84y0jYrJpPI
   qpPd/hfwBflDTFA7ULBvhAA4claRXTu+OQPRqV2tfi4PmL/jrVBakyMb7
   Ehk+vXkB805CV56dHTcnWnChlAjtSLuVb1mBeZlA26KMCbiHTR/HY8w96
   +56GGY0fv3vH+7mousPRUA8Zr+vKr6vVChDdHBXR3cLL8KI6dSnLoHRRW
   vIfl9SEKE/X3Q8vt4yh09eLbk66ctWr0ocwB6QOtc655tQ6nfFto2n890
   g==;
X-CSE-ConnectionGUID: B0aUfti7RAq3c2D4s4b7rg==
X-CSE-MsgGUID: /r1S3BJ8SAm8PniolRCa3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3505386"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3505386"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:47:31 -0800
X-CSE-ConnectionGUID: DT4bHHrmROS7onFpDd5i6g==
X-CSE-MsgGUID: lvzxamG6QfyjjEUiS7TvWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9413140"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 09:47:30 -0800
Message-ID: <e80768e9-b906-4381-9ba5-4d8afc877524@linux.intel.com>
Date: Mon, 16 Nov 2026 09:47:30 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI/PM: Honor PCI_DEV_FLAGS_NO_D3 in
 pci_bridge_d3_possible()
To: Aviv Bakal <avivb@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zeev Zilberman <zeev@amazon.com>,
 stable@vger.kernel.org
References: <20261116165110.2773301-1-avivb@amazon.com>
 <20261116165110.2773301-2-avivb@amazon.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20261116165110.2773301-2-avivb@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/16/26 08:51, Aviv Bakal wrote:
> pci_set_power_state() does not put a device with PCI_DEV_FLAGS_NO_D3
> into D3, but pci_bridge_d3_possible() ignores the flag.
> pcie_portdrv_probe() therefore enables runtime PM on such a port, and
> on runtime suspend pciehp masks the hotplug interrupt while the port
> stays in D0.
> 
> Return false from pci_bridge_d3_possible() when the flag is set.
> pci_bridge_d3_possible() must return the same value for the lifetime
> of the device, and FINAL fixups may set the flag after portdrv has
> probed, so record the flag in pci_pm_init() and check that copy.
> 
> Fixes: d4c79b63d82d ("PCI: Allow D3 for native hotplug-capable Root Ports on non-x86 platforms")
> Cc: stable@vger.kernel.org # 7.3.x
> Co-developed-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Zeev Zilberman <zeev@amazon.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>
> ---
>  drivers/pci/pci.c   | 10 ++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..eb7f2f03d9ae 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3055,6 +3055,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (pci_bridge_d3_disable)
>  			return false;
>  
> +		/* The port is known not to work correctly in D3 */
> +		if (bridge->no_d3)
> +			return false;
> +
>  		/*
>  		 * Hotplug ports handled by platform firmware may not be put
>  		 * into D3 by the OS, e.g. ACPI slots ...
> @@ -3227,6 +3231,12 @@ void pci_pm_init(struct pci_dev *dev)
>  	dev->pm_cap = 0;
>  	dev->pme_support = 0;
>  
> +	/*
> +	 * pci_bridge_d3_possible() must not change after this point, so
> +	 * ignore NO_D3 set by later fixups.
> +	 */
> +	dev->no_d3 = !!(dev->dev_flags & PCI_DEV_FLAGS_NO_D3);

This ignores quirk_plx_pex_no_d3(). It is the only other quirk that
sets NO_D3 on a PCIe port, and it is a FINAL fixup. So
pci_bridge_d3_possible() still returns true for those PLX downstream
ports, and portdrv still enables runtime PM on them.

> +
>  	/* find PCI PM capability in list */
>  	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
>  	if (!pm)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..1238667d643c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -420,6 +420,7 @@ struct pci_dev {
>  	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>  	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
>  	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
> +	unsigned int	no_d3:1;	/* NO_D3 set before PM init */
>  	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
>  	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
>  						   decoding during BAR sizing */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

