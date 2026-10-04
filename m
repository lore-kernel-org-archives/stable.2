Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2E3A1B5;
	Sun,  4 Oct 2026 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094164; cv=none; b=iIBrZ1+eABnHt+FTv1E2be0bf1w7NdkBYkfHdd/aDT81uRZiPT/9lCpEx79gpwPukm8MaDv4iKeNfqzG1GHMUJuJDGnFfz6t7T+fGGrAO5DrVE/qasj8+XzRtLU+bWLqvAONGqhjfd1nSSNRucKt0lrMyxvZtPw8ng1+GX/Bui0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094164; c=relaxed/simple;
	bh=O6a5GD560vAX33Ar+emmCzvLoVAprIoEHkr06ZJgLlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjbp1OPYWx35TjCR4jlFTH3E2Xnr6ewTC6EqlQoNuKHnsP5KJRRFG7piDT7vfYJSUIrX8HaxWXzivtDVfGAWEQQ21pokhdN3TueBRnYjA5SuUylkI0BeYLtUT2ogvf/HV7UjMA1t3UuhODl1BSYj/nQ2iMVCNCPvabCJoYNrHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JFNRDWk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JFNRDWk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EA31F000FF;
	Sun,  4 Oct 2026 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791094162;
	bh=EVbh1l7mNCsDih/vczI2UHe85J45dzFKTW/M+SXfY6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JFNRDWk7ypo/9FZnK+elI1DWPVSqaDp42sZt9lLyE3G8lpQgmoIVuP/z2s8L7/lwR
	 DmgHezusB3m5SZuSkWJWNVqIbsWumbq9s10C0GiwV351UFoKnhNJpOnr1glWSBbcOR
	 j820s/QftF5OLlK+OylzNRCfZOAla5NhMIVqEYUA=
Date: Sun, 4 Oct 2026 08:09:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Golden Stickwood <Stickwood_Jr@hotmail.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Sanath S <sanath.s@amd.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] thunderbolt: Preserve pre-boot PCIe tunnels for active
 storage devices
Message-ID: <2026100403-twice-paparazzi-7a07@gregkh>
References: <BN8PR19MB275472A84381924206F01AE0FD882@BN8PR19MB2754.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR19MB275472A84381924206F01AE0FD882@BN8PR19MB2754.namprd19.prod.outlook.com>

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
> 
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

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
