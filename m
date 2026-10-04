Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3512F585;
	Sun,  4 Oct 2026 04:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791089147; cv=none; b=qT8vceONtHpVAeaoIciTb2GL94vrLBRRY+BbjWkWTzfnO3WXKwYUExyPGYf+Op6L1ZkLKTAIv8UtOGYrxRJrYM2s6q+y2tI9QFHHiRyjRqbOGF/8D/CXwEWKY8Nho6rZ7Pq2bLJcVsS/OP50HtOiCaVbuK8P7c88aJ39vaphjWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791089147; c=relaxed/simple;
	bh=Y8hTEDXvb6yCaNb8FTRRoDawRaRSofceknZzXqrMGTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU5xyvTnTq+OUjbpFLKSFRVuFbw+8sTfPlgYt+AtTHAUmC8HPT7D5kMgCf81BIRf9XQ1bB5JKTYcg8iTinpY1zrfmuCucgf34QFztbVbFWnjuCvXVlSV1Q6cJ1YU4C42qNF86PkHfvbrGlInGSboIggehyL6HV6y6Vgf2euOHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkLEpaDa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkLEpaDa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791089145; x=1822625145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8hTEDXvb6yCaNb8FTRRoDawRaRSofceknZzXqrMGTA=;
  b=YkLEpaDaTEWItIIBLbJAqrU/II64e53/s4Kys3wWZzuaTe7pAwzI7nVa
   NnPQeyqQfN8hzc3SOcnvNJNkC5Tmm9Mi2GBpVI50BPqJlWgaLm5mRSKmK
   f0zNq5PG+H48GOKg48tPEC6DkIPacDlqlEYm2Yaxc77aOZ5li4MvOT97K
   0GDPQa+Qb/gwE+zX/5Fa+HnebsF6qP2LwEENFF94VDJKxfvdl/e3EVJc/
   shalXu5DTmhO7vzSKRBNSeKLOP0Jd64GFKTj+fNiGDrCRpU93eFM+FVE8
   wN72ytqsnMGjHKOU0N3HUQ+F1TREtQX1uxpdgqAqWgobZoT0NR/pu6bFb
   Q==;
X-CSE-ConnectionGUID: cXv0FhtXQW63PFlH37mV2g==
X-CSE-MsgGUID: YYD7E3r6RgGsjJbxL+Gd+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90652949"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="90652949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 21:45:44 -0700
X-CSE-ConnectionGUID: Pwwv5itGSjGiIJRsw2CMiQ==
X-CSE-MsgGUID: ImmaXyUUTtCsMqscUS5IuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="314548899"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2026 21:45:42 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 84DC199; Sun, 04 Oct 2026 06:45:41 +0200 (CEST)
Date: Sun, 4 Oct 2026 06:45:41 +0200
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: Golden Stickwood <Stickwood_Jr@hotmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Sanath S <sanath.s@amd.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Preserve pre-boot PCIe tunnels for active
 storage devices
Message-ID: <20261004044541.GH176164@black.igk.intel.com>
References: <BN8PR19MB275472A84381924206F01AE0FD882@BN8PR19MB2754.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN8PR19MB275472A84381924206F01AE0FD882@BN8PR19MB2754.namprd19.prod.outlook.com>

Hi,

On Sat, Oct 03, 2026 at 06:45:14PM +0000, Golden Stickwood wrote:
> In Linux 6.8+, commits 0fc70886569c ("thunderbolt: Reset USB4 v2 host
> router") and 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot
> firmware") enabled default host router resetting (host_reset = true).
> 
> On systems where the UEFI firmware created a PCIe tunnel to an external
> storage device (such as an NVMe drive hosting the root filesystem),
> issuing nhi_reset() in nhi_probe() on USB4 v2 or calling tb_switch_reset()
> in tb_start() on USB4 v1 abruptly tears down the physical PCIe tunnel while
> the kernel or initramfs is booting. This leaves downstream NVMe devices
> inaccessible (-ENODEV), triggers pciehp removal races, and results in a
> kernel panic or dracut boot timeout.

If you have the TB driver as part of the initramfs it should load and
recreate tunnels before the rootfs is mounted. You need to make sure there
is something in the initscripts that actually enables PCIe tunnel though.

> The Thunderbolt driver already contains infrastructure to handle boot
> devices: tb_discover_tunnels() traverses existing PCIe tunnels, marks
> the upstream switches as sw->boot = true, and tb_scan_finalize_switch()
> authorizes them. However, unconditional host_reset and discover = false
> short-circuits this entire mechanism.
> 
> Fix this regression cleanly by:
> 1. Adding nhi_has_active_storage() in drivers/thunderbolt/nhi.c to walk
>    sibling PCIe bridges using pci_walk_bus() and specifically verify the
>    presence of PCI_BASE_CLASS_STORAGE devices (e.g. NVMe SSDs) before
>    issuing REG_RESET_HRR.
> 2. In tb_start(), checking if the host router has an active PCIe downstream
>    adapter enabled by firmware before resetting. If active PCIe boot tunnels
>    or downstream storage devices are present, keep discover = true, skip
>    destructive resets, and allow tb_discover_tunnels() to adopt and
>    authorize the boot device.
> 
> Hardware Verification & Telemetry:
> - Platform A: Intel Core Ultra 9 275HX (Arrow Lake-HX) with Meteor Lake-P
>   Thunderbolt 4 NHI [8086:7ec2] + ASMedia ASM2464PD (PCIe Gen 4 x4) +
>   WD_BLACK SN7100 2TB NVMe SSD. Confirmed zero AER errors, zero IOMMU
>   page faults, and Host Memory Buffer (HMB) 64 MiB cleanly established.
> - Platform B: AMD Hawk Point USB4 Host Router [1022:1502] (ASUS Zenbook 14
>   UM3406HA, Launchpad LP #2159575). Boot succeeds cleanly without link drop.
> - Platform C: Intel Core Ultra (Dell Latitude 5550, Launchpad LP #2078573).
> 

You are misisng Assisted-by: LLM, no?

> Fixes: 0fc70886569c ("thunderbolt: Reset USB4 v2 host router")
> Fixes: 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot firmware")
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2167764
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: StickwoodJr <stickwood_jr@hotmail.com>
> ---
>  drivers/thunderbolt/nhi.c | 54 ++++++++++++++++++++++++++++++++++++++-
>  drivers/thunderbolt/tb.c  | 24 ++++++++++++++++++++--
>  2 files changed, 75 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 8b9f71c48012..d3c907a014e2 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -17,6 +17,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>

There is no way TB driver is going to call PCI functions or look what is
behind the PCIe tunnels.
