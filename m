Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195544DD3C3;
	Wed, 16 Sep 2026 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789599396; cv=none; b=EGDbZBJIvKLBK/N9EIVPJ2c1WSD2ZUaEJF2NoTqDA+EPlV9sCERcUZFrVeh1gsAZE6HoNz8YYbt8Xiw5tAq5x3+2w+yPM/PUku7kuDMcW+0xa9Ypxxhz/srLkCMTON4l5INUsPDrT/PpqhMkSwkrvjjtquPyUHHpOVzTyM3bjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789599396; c=relaxed/simple;
	bh=V0NQklz0omQ5jV3PYnbiIn6Ld5ins4DVKEUP/BM2g9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAWsUmFjFm7BCwxUlolrJAuPdthoKTXtIxhEC5qVL8YLBvWEuDLEFsvwkPcRnB68GrOB4Rf/HIsL7vulMJ1w+fmhzB8LPVvl5WHkOauON5WxzWSELHWxlH4pwoZ/RDAYyYAFY0K/r/EpCh+alD0RGT56bIRrz3M91Bw5jyZMHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FUyhPnMq; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FUyhPnMq"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hlZ4n2HC0zMlH7;
	Thu, 17 Sep 2026 00:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789599385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lb8kwLTKxKN8K2hUoS9WKnJYBE3Zo1Cn++dhZJIItfA=;
	b=FUyhPnMqjHAZCuK2Lp6InntldDu3b7UWDt8u2iDLn+MZIfuhKbB3KLBBs2MXvSlAQwPA1v
	NG5z7h3/960urC0iSla6IR9AvkdqJjDUV+1xtlAYMs+JOedNFH412FY9kAOEY8029Bj3nT
	en9ac8bZrscfXjuWlCpSmBO76xUV9xzVTeEaPCAtYtbVGZc0zPe5/4ugSNlk8bV9eo6+HX
	HUe4Bgsw3LrS1bcDSRuv7CrGb4Qdl+OcSSb6JxrlRcovvJ1plXA0tuPURU+0kCYqufPq4I
	u6aneKg4q/IXClAZpYgGrZ2l0b5d4g9PxghKk/sVDRs8pdhBPYSSzx7H7oWKKw==
Message-ID: <736ff398-98fa-43bc-9771-1b0d4c2a591c@mailbox.org>
Date: Thu, 17 Sep 2026 00:56:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: keystone: deinitialize endpoint on remove
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Yuho Choi <dbgh9129@gmail.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Koichiro Den <den@valinux.co.jp>
Cc: stable@vger.kernel.org
References: <20260916080030.2960608-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916080030.2960608-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qpazee37gqahxxutcsoy1h6otot3w84h
X-MBO-RS-ID: b0302441a57e2d295c3

On 9/16/26 10:00 AM, Guangshuo Li wrote:
> ks_pcie_probe() initializes the DesignWare PCIe endpoint with
> dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
> when endpoint register initialization fails, but the remove path does
> not perform the corresponding endpoint teardown after a successful
> probe.
> 
> The successful endpoint initialization also calls pci_epc_init_notify().
> Without the matching teardown on removal, the EPC initialization state
> and resources allocated by the DesignWare endpoint core are left
> active after the driver is removed.
> 
> Notify the endpoint framework about deinitialization and call
> dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 602516239a57..35787e727c5c 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1349,9 +1349,17 @@ static void ks_pcie_remove(struct platform_device *pdev)
>   {
>   	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
>   	struct device_link **link = ks_pcie->link;
> +	struct dw_pcie *pci = ks_pcie->pci;
> +	const struct ks_pcie_of_data *data;
>   	int num_lanes = ks_pcie->num_lanes;
>   	struct device *dev = &pdev->dev;
>   
> +	data = of_device_get_match_data(dev);

Could you maybe cache the mode in struct keystone_pcie {} instead ?

> +	if (data->mode == DW_PCIE_EP_TYPE) {
> +		pci_epc_deinit_notify(pci->ep.epc);
> +		dw_pcie_ep_deinit(&pci->ep);

Would it make sense to make dw_pcie_ep_deinit() call 
pci_epc_deinit_notify() , to avoid duplication in controller drivers ?

> +	}
> +
>   	pm_runtime_put(dev);
>   	pm_runtime_disable(dev);
>   	ks_pcie_disable_phy(ks_pcie);

-- 
Best regards,
Marek Vasut
