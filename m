Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD950EC1E;
	Thu,  3 Sep 2026 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468229; cv=none; b=XJdGT33NDpciyiJ/a4XnnW0yFRj7KjUCWhgYDwiLLrXTZZTLvPj1QFIDu7z/GNGq1z0s+fruRQJWQ+5KRuWg3Y+gKwp+pHdzMqeuN+j8RYFrf/DfbyzTTe4QHwfcPS+hIzOZFSUgDJ2fnDn1987P6FOwGj47u31iV6iS0tj1Irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468229; c=relaxed/simple;
	bh=n230phlDry5CJrh5PIzytyNR8M2YhLWFFnSbFH3+k9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih5R5nyJL/d6LCCWEr9SMH7oSE7NE0p85kkThOzssjspp7CEqmYd1F2z4c3lh2+CmxOI3LuS6b8AE/qsD9LmDC8bHQ7TTsodR/oQonJ9lFMpC4FY4CBUg6OfxFDz9Vw1wzIs0JMuAHjIHtMaxECw+xgsdCqcrKL3HkWHHlaFhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OOWEPmm1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OOWEPmm1"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbWlR4T5rzMlKT;
	Thu, 03 Sep 2026 22:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788468211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIsRbrscXRi7iMtDvkhseMV3Mlo2LVQZR4emqeAYj8g=;
	b=OOWEPmm1ls2kMiw4GL0nBSfXHHHbXC4TTOc98t1P2Sur9K22gOf/5LYvi764QLsU1n10iT
	1rKOyxb28OICxAynQNgzrkpyq/4t46fGj6Jn9Taa488CxOkyazwjXa+3trTMcveY4NslJN
	bufHO/3hAzlfZqyl2FeSZ9eYIWwzUIYw6Pd7shg8Y6W0r36pBjHeFxiXXqXxkYqe/QGNoQ
	XxfgZ79a1IkMJf62XzOjShxXk/ZU8qHFdwR6bxTq8Z7SABa69miAGj/ctn8/JY2DbKrpl/
	zsYal4wkrSucbyXMQ6v0gVWzlk3/YWalYArTONrF38Slsverx4qHKSUpvgjfZQ==
Message-ID: <c130c46d-586d-454d-b700-5bbe2c6eca40@mailbox.org>
Date: Thu, 3 Sep 2026 22:43:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
To: Bjorn Helgaas <helgaas@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Ziyao Li <liziyao@uniontech.com>, Rong Zhang <i@rong.moe>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20260903202706.GA2234456@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260903202706.GA2234456@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d4f7364284db7387202
X-MBO-RS-META: 83s5f6unfcj19mhdywbq5hzh85mjtkig

Hello Bjorn,

On 9/3/26 10:27 PM, Bjorn Helgaas wrote:
> On Thu, Sep 03, 2026 at 08:51:06PM +0200, Marek Vasut wrote:
>> Hello Bjorn,
>>
>> On 9/3/26 7:32 PM, Bjorn Helgaas wrote:
>>> [+cc Ziyao, Rong, Huacai for similar Loongson MRRS issue]
>>>
>>> On Fri, Aug 21, 2026 at 04:05:51AM +0200, Marek Vasut wrote:
>>>> R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
>>>> Max_Payload_Size (MPS). PCIe specification indicates that the MPS
>>>> must not exceed minimum MPS of any element along the packet path.
>>>> Force limit Max_Payload_Size to at most 256 Bytes for each device
>>>> connected to this PCIe controller.
>>>
>>> IIUC the PCI core already enforces this limit, and what this patch
>>> does is double-check that this limit is observed with this check,
>>> right?
>>
>> That is correct, this was changed in V3, I missed the commit message update,
>> sorry.
>>
>> Would you like me to respin the patch one more time with an updated commit
>> message, or would you be willing to fix it up in tree ?
> 
> I fixed the commit log, no problem.

Thank you.

>>>     +	WARN_ON(pcie_get_mps(dev) > 256);
>>>
>>> More below.
>>
>>
>> [...]
>>
>>>> +	bridge->no_inc_mrrs = 1;
>>>> +	if (pcie_get_readrq(dev) > 256) {
>>>> +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
>>>> +		pcie_set_readrq(dev, 256);
>>>> +	}
>>>
>>> It would be nice if all the platforms that need no_inc_mrrs could
>>> apply it the same way, but I assume you saw loongson_mrrs_quirk() and
>>> loongson_set_min_mrrs_quirk() in the process of finding no_inc_mrrs,
>>> and chose a different implementation strategy for some reason, e.g.,
>>> this way doesn't have to include device IDs for all the Root Ports?
>>
>> The loongson quirk won't work if the PCIe controller driver is built as a
>> module, which the R-Car Gen4 PCIe driver can be, and in fact is often built
>> as a module, because it depends on firmware which is loaded from filesystem.
>>
>> If the controller driver is built as a module, then
>> DECLARE_PCI_FIXUP_ENABLE() is not applied, the DECLARE_PCI_FIXUP_ENABLE() is
>> applied only on boot and therefore only for built-in drivers.
>>
>> I got burnt by DECLARE_PCI_FIXUP_ENABLE() in V1 of this patch.
> 
> Ouch, that does hurt.

I also mentioned this to TI a while back, because I think the 
pci-keystone.c has the same (module) issue. ( +CC Nishanth here too )

>> However, there is also another part to this -- the
>> rcar_gen4_pcie_enable_device() is called for every device on the bus and
>> applies the MRRS limitation to every device on the bus that is downstream of
>> the controller, not only the controller. This is necessary on this
>> controller variant, else hardware like PCIe SSDs with MRRS higher than the
>> controller break.
>>
>>> Maybe we should rework no_inc_mrrs in such a way that drivers could
>>> set a max MRRS in the struct pci_host_bridge and make
>>> pcie_write_mrrs() and pcie_set_readrq() pay attention to it?  That
>>> might let us get rid of the FIXUP approach.
>>
>> In light of the last paragraph above, that the MRRS has to be limited also
>> on all devices downstream of this particular controller, I would like to ask
>> -- does the Loongson controller have the same limitation or not ? If not,
>> then I would argue this quirk should be isolated to this controller variant
>> ; else, I am happy to start on the core patches.
> 
> I don't know if we'll get a real answer for Loongson (there's no
> maintainer listed for it, hint hint :)), but my guess is that it does
> apply to all devices downstream of the Loongson controller.
> 
> I think MRRS is mostly interesting for DMA because MMIO from CPUs is
> usually small sizes, far below the 128-byte or larger transfers that
> devices may do.

I agree with that, and DMA is what triggers the fault in my case.

Looking at the TI ks_pcie_quirk() FIXUP, I wonder if that might be a 
third instance of the same behavior. TI uses it to work around errata 
i2037 PCIe: PCI-Express May Corrupt Inbound Data [1] page 19 . But I now 
wonder, whether this behavior might be some common behavior of the DWC 
PCIe controller core ? Is there someone from Synopsys who might comment 
on that ?

[1] https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
