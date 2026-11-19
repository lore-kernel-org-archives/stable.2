Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130156;
	b=LnRTkKJGDXIBwA3WANgYCAhJSckI82GeTn74WeDvhvLi/ey2TVnGbxqKXcb9YBjoyZGL
	 Tec4dPN6EDBIFeHzB5D8HKcOnGZE29gyPVi4f0TNR8iDr5XRpDGmd/yXZ+5gVUh3W3qGe
	 LvJHw0Ezvp5L65hu2se6jiOapW4wzutGxnhOl/PR2qn7VqT2folbTUjhQVzmBnRrFqj7e
	 3D41Y/G38R/TlqcvoEzp9/vSJssG+qQN1MJ1gS7DPfyULp5Vehnf2NpgliaSB5AO3EArV
	 qS6KMOd907wc5I5KFHHuF+PR1l8XaJFvRW0sYoHXWkxmLPa3PTYn+lfGKaGVsRFk8xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130156;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/AEBL7pRx3plWi6SAC4boa6FbyMyXgpHUpi1zf+uhYQ=;
	b=26jcP/XoeccOwcAl3w+f33PEXmWrRcHzpOafA1RNHPSscvcfBjACT0m4XV+MKQRhRMgX
	 4ExCf41FIRXC4rwLWscdG164u61Ed88NpXhwrFk518rekPstIxoACYnJmUWMtiZsy5rdS
	 xxN+9Natyzumy5v53xk+9XVpaNz/NmbowbXshb4upsGBHFfIFF8KTviMC7Qo4eqLOWDBL
	 botriA/Z61yOarsPG0kZiUibNHiQxT2OEwfRv2G5fMahKJOnYd5PE1p1KnMcZbVft8avA
	 +crIlULpCuwSxhJyCOpr+raJWYBrpDW2u5bDwoHosWGgKwiib1AWoZi1yTEhXpDFIuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iI8o1s+9;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97C606A320;
	Thu, 19 Nov 2026 23:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA97C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=iI8o1s+9
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id E07A120B7166; Thu, 19 Nov 2026 15:15:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E07A120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795130147;
	bh=/AEBL7pRx3plWi6SAC4boa6FbyMyXgpHUpi1zf+uhYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iI8o1s+9j7EdRqJ9G7ioInm1lgoalXCSFec8cFj2NGOLFqDea/zeczZ31mzHC8Pvg
	 n9jPP4ODyBDn2c8YTli6fXIqBvqyZPJZ4dWB/FhF4VowjLHhprLSWLz9eSPbMcHKJo
	 wMM0f2b97+6WWEMR6TFZAj0MXdEyrSlXy5rRsHSY=
Date: Thu, 19 Nov 2026 18:15:47 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, davem@davemloft.net, jakeo@microsoft.com,
	saeedm@mellanox.com, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	abhamidipati@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Don't use container_of() on non-vPCI buses in
 config block ops
Message-ID: <av+DI3Ff6qwD2yGc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261119192937.570043-1-decui@microsoft.com>
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
In-Reply-To: <20261119192937.570043-1-decui@microsoft.com>

On Thu, Nov 19, 2026 at 11:29:37AM -0800, Dexuan Cui wrote:
> From: Aditya Bhamidipati <abhamidipati@microsoft.com>
> 
> hv_read_config_block(), hv_write_config_block() and
> hv_register_block_invalidate() are exported through hvpci_block_ops for
> mlx5_core, which calls them for its PCI function whenever it runs in a
> Hyper-V guest. They assume that pdev->bus->sysdata is embedded in a
> struct hv_pcibus_device and use container_of() on it.
> 
> That only holds for buses created by pci-hyperv. A Hyper-V guest can also
> have PCI devices behind other host bridges, for example the ACPI-enumerated
> ECAM root ports used for ePCIe (emulated PCIe) device assignment on Azure.
> For such a device, container_of() yields a bogus hv_pcibus_device, and
> mlx5_core crashes on a ConnectX VF. On a 7.0-based kernel it crashes in
> get_pcichild_wslot(), called from hv_register_block_invalidate() while
> the VF probes. On a 7.3-based kernel the VHCA invalidate work sends a
> packet on a bogus channel; UBSAN flags the spinlock, and a paging fault
> follows:
> 
>   UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.h:68:9
>   index 2129 is out of range for type 'long unsigned int [512]'
>   Workqueue: mlx5_hv_vhca mlx5_hv_vhca_invalidate_work [mlx5_core]
>   Call trace:
>    queued_spin_lock_slowpath+0x644/0x6e0
>    _raw_spin_lock_irqsave+0x98/0xf0
>    hv_ringbuffer_write+0x98/0x340
>    vmbus_sendpacket+0x9c/0x100
>    hv_read_config_block+0xf4/0x1b0
>    hyperv_read_cfg_blk+0x28/0x80
>    mlx5_hv_read_config+0x6c/0x130 [mlx5_core]
>    mlx5_hv_vhca_control_agent_invalidate+0x8c/0x280 [mlx5_core]
>    mlx5_hv_vhca_invalidate_work+0x88/0x120 [mlx5_core]
>    process_one_work+0x1dc/0x5b8
> 
> Commit 0d5acba6331c ("Drivers: hv: vmbus: Export hv_vmbus_exists() and
> use it in pci-hyperv") fixed the same crash for guests without VMBus, by
> not installing the ops at all. These guests do have VMBus, and their NIC
> and OS disk are on vPCI buses, so the ops are installed and a per-device
> check is still needed.
> 
> Treat the bus as a vPCI bus only if its ops are hv_pcifront_ops, and
> return -EOPNOTSUPP otherwise. mlx5_core ignores a failure to register the
> Hyper-V VHCA invalidate callback, so the VF probes normally.
> 
> Tested on an Azure ARM64 VM with 8 ConnectX VFs behind ACPI ePCIe host
> bridges, with a 7.0- and a 7.3-based kernel: all 8 VFs probe and their IB
> ports go Active, and a test module confirms that all three ops
> return -EOPNOTSUPP for a device that is not on a vPCI bus.
> 
> Fixes: e5d2f910cfec ("PCI: hv: Add a paravirtual backchannel in software")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Bhamidipati <abhamidipati@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> It's based on the PCI tree's for-linus branch, and can also apply cleanly
> to v7.4-rc3, pci/next, hyperv-next and linux-next.
> 
>  drivers/pci/controller/pci-hyperv.c | 36 +++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 824cf27e85e67..029d66a171216 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1451,6 +1451,21 @@ struct hv_read_config_compl {
>  	unsigned int bytes_returned;
>  };
>  
> +/*
> + * The config block ops are exported through hvpci_block_ops and can be called
> + * for any PCI device, including devices behind a non-Hyper-V host bridge
> + * (for example, ACPI-enumerated ePCIe roots). Only devices on a bus created by
> + * this driver are backed by a struct hv_pcibus_device.
> + */
> +static struct hv_pcibus_device *hv_pci_dev_to_hbus(struct pci_dev *pdev)

nit: seems like this would be a good candidate for inlining.

> +{
> +	if (pdev->bus->ops != &hv_pcifront_ops)

It's worth checking for !pci_is_root_bus(pdev->bus) here as well (since
pci-hyperv only creates the root bus).

Hamza

> +		return NULL;
> +
> +	return container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> +			    sysdata);
> +}
> +
>  /**
>   * hv_pci_read_config_compl() - Invoked when a response packet
>   * for a read config block operation arrives.
> @@ -1500,9 +1515,7 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
>  				unsigned int len, unsigned int block_id,
>  				unsigned int *bytes_returned)
>  {
> -	struct hv_pcibus_device *hbus =
> -		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> -			     sysdata);
> +	struct hv_pcibus_device *hbus = hv_pci_dev_to_hbus(pdev);
>  	struct {
>  		struct pci_packet pkt;
>  		char buf[sizeof(struct pci_read_block)];
> @@ -1511,6 +1524,9 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
>  	struct pci_read_block *read_blk;
>  	int ret;
>  
> +	if (!hbus)
> +		return -EOPNOTSUPP;
> +
>  	if (len == 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
>  
> @@ -1581,9 +1597,7 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
>  static int hv_write_config_block(struct pci_dev *pdev, void *buf,
>  				unsigned int len, unsigned int block_id)
>  {
> -	struct hv_pcibus_device *hbus =
> -		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> -			     sysdata);
> +	struct hv_pcibus_device *hbus = hv_pci_dev_to_hbus(pdev);
>  	struct {
>  		struct pci_packet pkt;
>  		char buf[sizeof(struct pci_write_block)];
> @@ -1594,6 +1608,9 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
>  	u32 pkt_size;
>  	int ret;
>  
> +	if (!hbus)
> +		return -EOPNOTSUPP;
> +
>  	if (len == 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
>  
> @@ -1652,11 +1669,12 @@ static int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
>  					void (*block_invalidate)(void *context,
>  								 u64 block_mask))
>  {
> -	struct hv_pcibus_device *hbus =
> -		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> -			     sysdata);
> +	struct hv_pcibus_device *hbus = hv_pci_dev_to_hbus(pdev);
>  	struct hv_pci_dev *hpdev;
>  
> +	if (!hbus)
> +		return -EOPNOTSUPP;
> +
>  	hpdev = get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
>  	if (!hpdev)
>  		return -ENODEV;
> 
> base-commit: e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff
> -- 
> 2.55.0
> 
