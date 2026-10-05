Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6932544682E;
	Mon,  5 Oct 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241368; cv=none; b=ECDKh56092dvmRR/8Hm1PzbSlxpNw4yqNoqrdpFezdqXsV+VthCYQmXzFHGw1vaKrGcIPZHCwdtC/51SXtIgqLZz16cFDtUhMsdXG6WXJxAcQgfrWgBgsvMF5NMxsD2Z4qohLeRyTBAwUhdFyuBKwfP3eok/kP7+7v3pcQ45100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241368; c=relaxed/simple;
	bh=gkbRjPmdRWgGn8j7vcI8rmJs6bN9/LXGWeo+jDEoQdk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K4VGaa6u0C8+DRzX9tOce0KS0J6UQQo83axOUJ90Fs5CreCk5znMycrUPkccz+1Pnb1PH0hv9Gkx+sbsVonHR7pqjudHB1flVJEtei7WMdv2A1xVq04kmdotUjHHG6wj+sAcq41bpTMNNWlTBrAXmDdT2Z3WJFUciMVs3zwD4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5bbcGwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5bbcGwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283BD1F00893;
	Mon,  5 Oct 2026 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241367;
	bh=xXsl2dsCGxNVOfwWuosDoCl8g6qp+UwKPTctGHWqXF8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i5bbcGwmo20x9S/4QHpYfSVEMo+9Dcy+LLa6zIYS+CeudW341DHqj1SUhALQ8vm7T
	 oLvVPVx6M6ApTxAmgmiGcoEwr8zUFm3ysg4v1ojRqwz6GniCYSXYK/vu1j1rJ5Tbpg
	 pDGWVmFstHFYEKPMeRfv0q1a0oo4wFoQoEhcGFylM1mhZF1ufr6IKhLzs5iBaGZXsc
	 SfCllcJeAgynYk2G60dQ7FLB6ReS4MIZPpJows4GqrqXOiHd/y2cbamRh5Eshtf1zR
	 +aeO1gp7UbQnzv+EYIEF9AEZV/BUErqN3nNYEy3sJQUmqenvCMB4N/DQyUVPIb2HaM
	 MulS48rCrNq9A==
Subject: Re: [PATCH net 5/6] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 florian.bezdeka@siemens.com, meng.ding@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com,
 dima.ruinskiy@intel.com, raanan.avargil@intel.com, gil.fine@intel.com,
 stable@vger.kernel.org, javier.herrera@afronta.com,
 aleksandr.loktionov@intel.com
Date: Mon, 05 Oct 2026 23:02:45 +0000
Message-ID: <179124136574.434549.6280763039812570100@kernel.org>
In-Reply-To: <20261001222443.3500206-6-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-6-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch checks the size of BAR0 only.

--

e1000e: Fix out-of-bounds MMIO access by validating BAR0 size

This commit makes e1000_probe() reject devices whose BAR0 is smaller than
SZ_64K, before ioremap() is called. It fixes a syzkaller-reported oops.
In that report a foreign device with a 4K BAR0 was bound through new_id,
and probe read EEMNGCTL past the end of the mapping.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 746a395869998..ad9b88c9af225 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7455,6 +7455,12 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	mmio_len = pci_resource_len(pdev, 0);
>  
>  	err = -EIO;
> +	/* Smallest BAR0 that covers every register the driver accesses */
> +	if (mmio_len < SZ_64K) {
> +		dev_err(&pdev->dev, "MMIO len is too small\n");
> +		goto err_ioremap;
> +	}
> +
>  	adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
>  	if (!adapter->hw.hw_addr)
>  		goto err_ioremap;

[Severity: Medium]
Does this check also cover the flash registers on ICH/PCH parts older
than SPT?

The commit message says:

  This accounts not only for standard registers up to E1000_SYSSTMPH,
  but also for flash registers mapped on ICH/PCH chipsets (up to offset
  0xE074 / ~57.1 KB). Since PCI BAR sizes are power-of-two aligned,
  SZ_64K is the minimum valid BAR0 size required to ensure all
  subsequent MMIO accesses remain strictly within the mapped boundary.

That seems true only for e1000_pch_spt and later. On those parts,
e1000_init_nvm_params_ich8lan() puts the flash registers inside BAR0:

	hw->flash_address = hw->hw_addr + E1000_FLASH_BASE_ADDR;

On ICH8/9/10, PCH, PCH2 and PCH_LPT the flash registers are in BAR1.
e1000_probe() maps BAR1 right after this hunk, with no minimum length:

	if ((adapter->flags & FLAG_HAS_FLASH) &&
	    (pci_resource_flags(pdev, 1) & IORESOURCE_MEM) &&
	    (hw->mac.type < e1000_pch_spt)) {
		flash_start = pci_resource_start(pdev, 1);
		flash_len = pci_resource_len(pdev, 1);
		adapter->hw.flash_address = ioremap(flash_start, flash_len);

Probe then reads and writes fixed offsets in that mapping. The second
step runs because FLAG_READ_ONLY_NVM is on by default for ICH parts:

e1000_probe()
  ei->get_variants()
    e1000_init_nvm_params_ich8lan()
      er32flash(ICH_FLASH_GFPREG)             /* 0x0 */
  e1000e_write_protect_nvm_ich8lan()
    er32flash(ICH_FLASH_PR0)                  /* 0x74 */
    ew32flash(ICH_FLASH_PR0, pr0.regval)
    er16flash(ICH_FLASH_HSFSTS)
    ew32flash(ICH_FLASH_HSFSTS, hsfsts.regval)

new_id_store() accepts a 7-field new_id. The driver_data can match any
existing table entry, such as board_ich8lan, board_pchlan or
board_pch_lpt. So the reproducer from the commit message can still be
used against a foreign device that has:

  - a BAR0 of at least 64K, which passes the new check
  - a memory BAR1 smaller than 0x78 bytes (PCI allows memory BARs as
    small as 16 bytes)

Would the PR0 read-modify-write at offset 0x74 then go past the end of
the BAR1 mapping? If the small BAR sits at the end of a page, this
could fault like the EEMNGCTL oops. Otherwise it could read and write
registers of whatever device decodes the next addresses.

The later "e1000e: add system to disable K1 list" patch in this series
does not appear to change this path.

Would BAR1 need its own minimum size check for the commit message's
claim to hold? That could be at least ICH_FLASH_PR0 + 4, or SZ_4K to
match real hardware.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001222443.3500206-1-anthony.l.nguyen%40intel.com
