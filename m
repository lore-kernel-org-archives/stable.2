Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336E478E20;
	Mon, 21 Sep 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002024; cv=none; b=rKA5o/7PU1pzjAXZ69jSyVYj2KTBBPKi6XgVnsAwZdgkzWnLKlEZqwtkm2uKQVWKv7c1HPyPZbHj7EALd+JuU8fAE/Be/EnkaYva7X1ntsolK8/9j64YWnmEgqAhn27dspk46ERHuEUY1ca89cqX0N7ZeRYRTT8+GOt08iTzbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002024; c=relaxed/simple;
	bh=XfmWMsNyU4Xs7fZq4urf6ghCDU85y2X+vPQbSZlaygU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuOb/BXAKmjTTnTE8XcXx4MQYJBeKQvGUkNa7Q/OTmGo+Lf0E1en4kgHDT4uJItDTcGFrQfiaicFJOCBc59tUBZ62iJts/DUS+sSImQxrzDhl7YasxCcMoKZzBNkTamKMsBKBAzm9KfIWSDAbeO0sha6OcsEZ04/TgiJSEmp6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=E5wnfoAg; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="E5wnfoAg"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hpQzY1QSPzMlDv;
	Mon, 21 Sep 2026 16:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790002009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3enihJHYZmOm2PLsVe1+ufKeMP1zdXy551QL6AebGT8=;
	b=E5wnfoAg79Pyi0OIOhN96jFYpOcGk8E58PDv5uNz01h+axmAQ7zEvhH39xsvft5frqb2hF
	2QX/3S9IF+2maSXynV8gkycKF+VeUvr0JiK/BAvBkuYl/V7dZPOFCN89IyI78FGMLLdsKQ
	nEUQ79dKUv3K9jjRD2xvb2z5FAK41RD47azM8Ha6+STsivnKwKAxfYsneNj9OdSlLjy+SK
	uTXlvZdY4BUbp0LPPgrf31nUtqZGmG95IFWeIv2vz7rxCv6sBtW9uNumfHOqVPD49g3C/l
	1vJj4ij31SEO1Ux8ZE7oEjMohSOYanwJNhAxlLJgKWQWWA4Ym2VdMCFqXQujQg==
Message-ID: <a3db8ebd-0a99-4436-821a-f12d353ea6fc@mailbox.org>
Date: Mon, 21 Sep 2026 16:46:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: keystone: deinitialize endpoint on remove
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Yuho Choi <dbgh9129@gmail.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Koichiro Den <den@valinux.co.jp>,
 stable@vger.kernel.org, Nishanth Menon <nm@ti.com>
References: <20260916080030.2960608-1-lgs201920130244@gmail.com>
 <736ff398-98fa-43bc-9771-1b0d4c2a591c@mailbox.org>
 <CANUHTR_AAKH13fRAwLY5wzMjhWuzwET=-359ZMNh0VU4tULrKg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CANUHTR_AAKH13fRAwLY5wzMjhWuzwET=-359ZMNh0VU4tULrKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5b282cc8359349ccb17
X-MBO-RS-META: 4ziniwh9xinf443pgfj1sjqcpie9y49p

On 9/21/26 4:15 PM, Guangshuo Li wrote:
> Hi Marek,
> 
> Thanks for the review.
> 
> On Thu, 17 Sept 2026 at 06:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 9/16/26 10:00 AM, Guangshuo Li wrote:
>>> ks_pcie_probe() initializes the DesignWare PCIe endpoint with
>>> dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
>>> when endpoint register initialization fails, but the remove path does
>>> not perform the corresponding endpoint teardown after a successful
>>> probe.
>>>
>>> The successful endpoint initialization also calls pci_epc_init_notify().
>>> Without the matching teardown on removal, the EPC initialization state
>>> and resources allocated by the DesignWare endpoint core are left
>>> active after the driver is removed.
>>>
>>> Notify the endpoint framework about deinitialization and call
>>> dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.
>>>
>>> This issue was found by manual code inspection.
>>>
>>> Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>>> ---
>>>    drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
>>>    1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>>> index 602516239a57..35787e727c5c 100644
>>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>>> @@ -1349,9 +1349,17 @@ static void ks_pcie_remove(struct platform_device *pdev)
>>>    {
>>>        struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
>>>        struct device_link **link = ks_pcie->link;
>>> +     struct dw_pcie *pci = ks_pcie->pci;
>>> +     const struct ks_pcie_of_data *data;
>>>        int num_lanes = ks_pcie->num_lanes;
>>>        struct device *dev = &pdev->dev;
>>>
>>> +     data = of_device_get_match_data(dev);
>>
>> Could you maybe cache the mode in struct keystone_pcie {} instead ?
>>
>>> +     if (data->mode == DW_PCIE_EP_TYPE) {
>>> +             pci_epc_deinit_notify(pci->ep.epc);
>>> +             dw_pcie_ep_deinit(&pci->ep);
>>
>> Would it make sense to make dw_pcie_ep_deinit() call
>> pci_epc_deinit_notify() , to avoid duplication in controller drivers ?
>>
>>> +     }
>>> +
>>>        pm_runtime_put(dev);
>>>        pm_runtime_disable(dev);
>>>        ks_pcie_disable_phy(ks_pcie);
>>
>> --
>> Best regards,
>> Marek Vasut
> 
> Agreed. I'll cache the mode in struct keystone_pcie and move
> pci_epc_deinit_notify() into dw_pcie_ep_deinit() so controller drivers
> do not need to duplicate it. I'll send a v2 with those changes.
Thank you
