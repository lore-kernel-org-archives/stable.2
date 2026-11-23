Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.52.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448546;
	b=MqfyZY9P/jtWwV/ookd0Lt2XTxDXH8VREMc9TFvG6lw00yJkyUN2sdnzmXW9nYaHdLUP
	 /mXQL4a2cD713zV1olEHhbVkZgaCSXvZU2/3xsojv57s59nvnJ5VHc3uxd7MhXkeThz9a
	 1lVQH/IQSrRKH8tTt0DMo3sfPETh5qjD4YyGVoWQ9glGdDA9M+adQrLtEFSpiViRg8SZL
	 1BBPcarMCAfrN9SyP4qHeTzkCJKxYh+5ytYItkkxSNCDyl1KVDpbRWV/MHlAXF9+jTy9N
	 F8qCNkiMSt9RZPVI7UESj8rbvJReDJRBUXUMfnTxT15F+/4Wbfl8rRvvdytvaNEM90w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448546;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=UHmDH4xQTawnQx2c62U2+yzNLbTZSXgZeWsOYcq/ojk=;
	b=XE7w+H0c2TEwxNYaa+GGkcP0kK2bc+spfy2S3XuJlCCfqD08T5IFndAchXVQoMdQdWhx
	 C5zuS9ga9yd/tD57qX/bFW/um3KHf6l3gJf9/IQIM/K3EXgwCvYmoD73+HLlYK34SbmfQ
	 ktG59VsmAsMdb1nFeANMAGRk7nT6oA6m4LT+GMOKmI6+CNd7xA7vSgV+ZTTp0qmBtk1NP
	 wOg97CA1IaluaPG1aJP2uFQUjhK4CwEZH4crJ9V8iRytehWy+CP0FkAEsxBOoCoF0MMpX
	 QeQsNs5sVoURWIHrtCrPssvbQ5XG+fcEzWnYMFUR7izNynJEiJCi975Hid5+EZSd/ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=RQNfh+VH;
	arc=none smtp.remote-ip=160.236.52.251
Received: from mail-m16023652251.xmail.ntesmail.com (mail-m16023652251.xmail.ntesmail.com [160.236.52.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C7606A31A;
	Mon, 23 Nov 2026 15:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F3C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=RQNfh+VH
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55b0ebc65;
	Mon, 23 Nov 2026 23:42:11 +0800 (GMT+08:00)
Message-ID: <fd14d6c1-d9a4-41f9-b1c0-96c3006d40a1@rock-chips.com>
Date: Mon, 23 Nov 2026 23:42:08 +0800
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
Cc: shawn.lin@rock-chips.com,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 James Le Cuirot <chewi@gentoo.org>, stable@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Clear stale link down interrupt before
 unmasking it
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20261123121217.1107902-2-cassel@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20261123121217.1107902-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2091269ec03a4kunm304402a287d7ac
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDQxpDVhpJSh9OGEweSE5NH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RQNfh+VHuuBsHD9f3Wr2F5htjBdHrAM2nyTGba3J3eDhvG54DTy+OlB1qfSRz3OiQ+6hvlroa6vZ5XIjWDbRd2Ixpk22eDa06ICTxenhMVyX4rrMVge3H1kZdmaM3wcr/+2iv4PlWEaUH/ncRZ+qoaBMgGuhcPsAx701rm256kk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=UHmDH4xQTawnQx2c62U2+yzNLbTZSXgZeWsOYcq/ojk=;
	h=date:mime-version:subject:message-id:from;

在 2026/11/23 星期一 20:12, Niklas Cassel 写道:
> PCIE_LINK_REQ_RST_NOT_INT is set by smlh_req_rst_not, which according to
> the RK3568 TRM "is asserted after power-on reset until first link up".
> The bit is thus already pending when the driver unmasks the interrupt
> after resetting the controller, both in probe and in .reset_root_port(),
> so the interrupt fires as soon as it is unmasked, even though the link
> is up. Since each recovery resets the controller again, this results in
> an endless loop, as seen on a Quartz64 Model B (RK3566):
> 
>    pcieport 0000:00:00.0: Recovering Root Port due to Link Down
>    pcieport 0000:00:00.0: Root Port has been reset
>    pcieport 0000:00:00.0: AER: device recovery successful
>    pcieport 0000:00:00.0: Recovering Root Port due to Link Down
> 
> Clear the bit before unmasking the interrupt, and in .reset_root_port()
> only unmask it once the link is back up, like in probe. Also keep the
> interrupt masked while .reset_root_port() resets the controller, so the
> link down caused by the reset itself is not reported.
> 

This looks right to me ,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Fixes: b376b3ff9cb0 ("PCI: dw-rockchip: Implement .reset_root_port() and use for link down")
> Reported-by: James Le Cuirot <chewi@gentoo.org>
> Closes: https://lore.kernel.org/linux-pci/08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index ab2e26699409..2ef7ae97eb10 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -686,6 +686,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
>   
> +static void rockchip_pcie_rc_unmask_link_down(struct rockchip_pcie *rockchip)
> +{
> +	u32 val;
> +
> +	rockchip_pcie_writel_apb(rockchip, PCIE_LINK_REQ_RST_NOT_INT,
> +				 PCIE_CLIENT_INTR_STATUS_MISC);
> +
> +	/* unmask hot reset/link-down reset */
> +	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +}
> +
>   static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   				      struct rockchip_pcie *rockchip)
>   {
> @@ -739,9 +751,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>   		return ret;
>   	}
>   
> -	/* unmask hot reset/link-down reset */
> -	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +	rockchip_pcie_rc_unmask_link_down(rockchip);
>   
>   	return ret;
>   }
> @@ -898,6 +908,9 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>   	u32 val;
>   	int ret;
>   
> +	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 1);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +
>   	dw_pcie_stop_link(pci);
>   	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>   	rockchip_pcie_phy_deinit(rockchip);
> @@ -938,16 +951,13 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
>   		goto deinit_clk;
>   	}
>   
> -	/* unmask hot reset/link-down reset */
> -	val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> -
>   	ret = dw_pcie_start_link(pci);
>   	if (ret)
>   		goto deinit_clk;
>   
>   	/* Ignore errors, the link may come up later */
>   	dw_pcie_wait_for_link(pci);
> +	rockchip_pcie_rc_unmask_link_down(rockchip);
>   	dev_dbg(dev, "Root Port reset completed\n");
>   	return ret;
>   
> 
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f

