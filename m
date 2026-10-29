Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.52.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242057;
	b=RdqHNbWjc/hkA0boAQyhOdYrvW3CmgZS8PevZtfSA9/onesmev3USofw1gBmWxF4u/G9
	 bFZQMuSkHkga+cRXf4ZfzAFBykXTDUK3AZrqWueYjyzXtZbbeHz+CS/LqxWWBb1juTV2P
	 mjTRatEnNVuoE54G/U8GSrIT8+lnLa5VQLJMla3+BUSH/FKQ0w6vjI4DR85t1gK8eXFQd
	 8fDo15wIWkhmLTg6h8g29TISYrV1FfR7gZ7sL770JmD/YNgco7epLTrwcgDnOD0uFDJ11
	 Td4Th+yJOOzw35HgA7RzKCuXxBZU9YReXrrCNvpcbWL0K7H1ZnZVoiEoZXb7Qj4tW5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242057;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=P4kFPjdmmuMnKWuiUCtc2eA601bnJ5qrrs2UlBY4bxw=;
	b=1h2C3nCn30gienGJXWnYBNA2qpvGjV6lZ41afn9Ua2HxhsqYsvKIur+Oe/LGeG/od+tH
	 g7ETrVE2OH1lY7pBy88tvY+/vxdiWVcf/Vbxe+fPppEKyNdm/5nNAJLBNIY+GSdpoQRSw
	 TD2T2MlW2zvKffB/UFfgp1Sd5VLYAW0stcG/QVYZS1H6aiEd9lHNSlnoi5Oxm1UUoTvj9
	 CnMj6NKQAyqLv6ouw6eDRPF1JmN5CCYGmRg/dOsSWIcCY4GaP2PBpri/6v6Gf6+2qazI5
	 SP0T4LQId6mG2Y5lwA1bbEoa3X1/iOvemko8dUlHJfm9VjXx4l39d3HVfY4pMMPZxGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=GVdu7rDm;
	arc=none smtp.remote-ip=160.236.52.230
Received: from mail-m16023652230.xmail.ntesmail.com (mail-m16023652230.xmail.ntesmail.com [160.236.52.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102D606A31C;
	Thu, 29 Oct 2026 02:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F102D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=GVdu7rDm
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 52bb79f0a;
	Thu, 29 Oct 2026 10:47:23 +0800 (GMT+08:00)
Message-ID: <ae7dfffd-1158-4c64-b092-b1daee468a05@rock-chips.com>
Date: Thu, 29 Oct 2026 10:47:19 +0800
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
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 linux-rockchip@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Fix NULL pointer dereference in sysfs
 show/store callbacks
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1791596305-153177-1-git-send-email-shawn.lin@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1791596305-153177-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1858e145003a4kunmb39a80931137a4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE1IVh0fTklOQ09JHh1MHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=GVdu7rDmLDTnuxmsfcUG6qP3YA8PQrnkBCdzP9LSwH20xV2Yj865P6A7aDC19bypHzMSzSdoiv0i6c85+Y8mghuhqVjMMYI27DAZFf8GwhTC9tk0VWD/Unz7i/FNP0kG/MSyeEKpT4VWkO58hhfFZqmeFSYha8aacCECkdTJlqI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=P4kFPjdmmuMnKWuiUCtc2eA601bnJ5qrrs2UlBY4bxw=;
	h=date:mime-version:subject:message-id:from;

Hi Bjorn

在 2026/10/10 星期六 9:38, Shawn Lin 写道:
> Reading or writing a link state sysfs attribute after the upstream
> bridge's pcie_link_state has been freed triggers a NULL pointer
> dereference.
> 

Gentle ping...


> This was first seen on a 6.12 based kernel by userspace stress testing a
> PCIe endpoint on an RK3588 EVB1 (Intel I350 dual-port NIC behind the
> root port). The same NULL pointer dereference exists in upstream and can
> be reproduced reliably on:
> 
>    # lspci
>    00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3588 (rev 01)
>    01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
>    01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network Connection (rev 01)
> 
> by running:
> 
>    echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
>    cat /sys/bus/pci/devices/0000:01:00.1/link/l1_aspm
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
> Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000000106959000
> [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1]  SMP
> Modules linked in:
> CPU: 3 UID: 0 PID: 646 Comm: cat Not tainted 7.3.0-rc6-next-20261007-00007-gf2fe32674ebe-dirty #134 PREEMPT(full)
> Hardware name: Rockchip RK3588 EVB1 V10 Board (DT)
> pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : l1_aspm_show+0x64/0x88
> lr : dev_attr_show+0x24/0x68
> sp : ffff800086f9bbf0
> x29: ffff800086f9bbf0 x28: ffff0001036c0000 x27: 0000000000000000
> x26: 0000000000000000 x25: 000000007ffff001 x24: 0000000000000001
> x23: ffff800081781630 x22: ffff0001008d3c00 x21: ffff0001053b9000
> x20: ffff0001020880d0 x19: ffff800082441c28 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 00000000ffffe000
> x11: ffff0001053b9000 x10: 0000000000c00010 x9 : 0000000000000070
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000004
> x2 : ffff0001053b9000 x1 : ffff800082441c28 x0 : ffff0001053b9000
> Call trace:
>   l1_aspm_show+0x64/0x88 (P)
>   dev_attr_show+0x24/0x68
>   sysfs_kf_seq_show+0xb8/0x138
>   kernfs_seq_show+0x2c/0x38
>   seq_read_iter+0x120/0x3e0
>   kernfs_fop_read_iter+0x60/0x188
>   vfs_read+0x200/0x2b8
>   ksys_read+0x74/0xe8
>   __arm64_sys_read+0x1c/0x28
>   invoke_syscall+0x44/0xec
>   el0_svc_common+0x8c/0xd8
>   do_el0_svc+0x1c/0x28
>   el0_svc+0x3c/0x98
>   el0t_64_sync_handler+0x84/0x12c
>   el0t_64_sync+0x198/0x19c
> Code: aa1f03e8 d503233f a9bf7bfd 910003fd (b9403108)
>   ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: disabled
> CPU features: 0x0,70000000,0070002a,01180a42,0800e20b
> Memory Limit: none
>   ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> 
> The sysfs attributes are created for every device below the link, but
> the link state is freed by pcie_aspm_exit_link_state() when function 0
> of the downstream component is removed. A sibling function or a sysfs
> reader still holding a reference can then call into the show/store
> callbacks while pcie_aspm_get_link() returns NULL.
> 
> aspm_attr_show_common(), aspm_attr_store_common(), clkpm_show() and
> clkpm_store() all dereference the link pointer unconditionally. Add the
> missing NULL checks, mirroring pcie_aspm_enabled(), and return -ENODEV.
> 
> Cc: stable@vger.kernel.org
> Fixes: 72ea91afbfb0 ("PCI/ASPM: Add sysfs attributes for controlling ASPM link states")
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>   drivers/pci/pcie/aspm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index f8e6497..0e0ba0e6 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1777,6 +1777,9 @@ static ssize_t aspm_attr_show_common(struct device *dev,
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>   
> +	if (!link)
> +		return -ENODEV;
> +
>   	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
>   }
>   
> @@ -1788,6 +1791,9 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>   	bool state_enable;
>   
> +	if (!link)
> +		return -ENODEV;
> +
>   	if (kstrtobool(buf, &state_enable) < 0)
>   		return -EINVAL;
>   
> @@ -1836,6 +1842,9 @@ static ssize_t clkpm_show(struct device *dev,
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>   
> +	if (!link)
> +		return -ENODEV;
> +
>   	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
>   }
>   
> @@ -1847,6 +1856,9 @@ static ssize_t clkpm_store(struct device *dev,
>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>   	bool state_enable;
>   
> +	if (!link)
> +		return -ENODEV;
> +
>   	if (kstrtobool(buf, &state_enable) < 0)
>   		return -EINVAL;
>   

