Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F2384CD1;
	Thu,  3 Sep 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461481; cv=none; b=bdbyLnPyjaSbo+mzwJf7Hqv8cp+rl9XmWmq82Bii7jmvg3SKZmMxOThI1uzOWdOrstf2SNnD8heSev2u/gUo7zmBlxPDVzT3I0C57AlfOv9M+l3AWiKdohsbFOQfHHLGLWdD2XLtXT6/j/6pqx8nGnITvomH+lPhCbgVYZhM5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461481; c=relaxed/simple;
	bh=iHcU2RXuw3ix/FqMa08c18FL3/q2t4eEtWuf9N23UNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h95VAX4kv7/y8tZdPj1ORqEwJ+kBJMegXA1uQM/9PgayVSrhhmE0WgC3dsmMrnJDbbzNDo95hpkHOvXvrIeXHKc3yq+2rNtXbd1CD0c4Mp6k+x4PB7jdUnvGNGilezloTI4nTJsEPPqDJU/JrEWl1fX4kM3TURnNU429lpzblaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SAxuB+QN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SAxuB+QN"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hbTFr5LrkzKn76;
	Thu, 03 Sep 2026 20:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788461472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljjuDSq9jtR3ksKnCJ8xHYRcpmhBC+ZvoIAugnI2lCg=;
	b=SAxuB+QNndnOiFRoFsMfH97VfY2vZ/iIwOTMwq6BSSm4IlOMzHXCDyWIpkVw/9e7F2FHD2
	/MTkBoaXPpncw894963YJRSZwVhRAhhp5ilLX0hI2pr5AeeSsV2VghO888P9g3bFaMd0iq
	WtB2JD8s0/E8nadmCxgXvSTYdeRho3pziBbln2nQdFDV0QbMK8RPL1/In1imx0wdWzR4Fv
	Lo0QPdfbnr1+ATdEXgqUYFzr/DS8WziETs9ymf4/zs3by9dDBc6+4gZ3fvTevFckDQMJSW
	tvNvcGx/NtVXWzG2ohyOr4ZtFuRzNpX1yt1oiSbBSeK/3S59aQM7fV+rgDwKFA==
Message-ID: <e5b47840-6c45-4e00-8907-7766dd1d4607@mailbox.org>
Date: Thu, 3 Sep 2026 20:51:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
To: Bjorn Helgaas <helgaas@kernel.org>
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
References: <20260903173216.GA2145418@bhelgaas>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260903173216.GA2145418@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: da9182bb6e4e7c6071b
X-MBO-RS-META: 18qawh44pghaq6gy9km6bho69jfg3f4c

Hello Bjorn,

On 9/3/26 7:32 PM, Bjorn Helgaas wrote:
> [+cc Ziyao, Rong, Huacai for similar Loongson MRRS issue]
> 
> On Fri, Aug 21, 2026 at 04:05:51AM +0200, Marek Vasut wrote:
>> R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
>> Max_Payload_Size (MPS). PCIe specification indicates that the MPS
>> must not exceed minimum MPS of any element along the packet path.
>> Force limit Max_Payload_Size to at most 256 Bytes for each device
>> connected to this PCIe controller.
> 
> IIUC the PCI core already enforces this limit, and what this patch
> does is double-check that this limit is observed with this check,
> right?

That is correct, this was changed in V3, I missed the commit message 
update, sorry.

Would you like me to respin the patch one more time with an updated 
commit message, or would you be willing to fix it up in tree ?

>    +	WARN_ON(pcie_get_mps(dev) > 256);
> 
> More below.


[...]

>> +	bridge->no_inc_mrrs = 1;
>> +	if (pcie_get_readrq(dev) > 256) {
>> +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
>> +		pcie_set_readrq(dev, 256);
>> +	}
> 
> It would be nice if all the platforms that need no_inc_mrrs could
> apply it the same way, but I assume you saw loongson_mrrs_quirk() and
> loongson_set_min_mrrs_quirk() in the process of finding no_inc_mrrs,
> and chose a different implementation strategy for some reason, e.g.,
> this way doesn't have to include device IDs for all the Root Ports?

The loongson quirk won't work if the PCIe controller driver is built as 
a module, which the R-Car Gen4 PCIe driver can be, and in fact is often 
built as a module, because it depends on firmware which is loaded from 
filesystem.

If the controller driver is built as a module, then 
DECLARE_PCI_FIXUP_ENABLE() is not applied, the 
DECLARE_PCI_FIXUP_ENABLE() is applied only on boot and therefore only 
for built-in drivers.

I got burnt by DECLARE_PCI_FIXUP_ENABLE() in V1 of this patch.

However, there is also another part to this -- the 
rcar_gen4_pcie_enable_device() is called for every device on the bus and 
applies the MRRS limitation to every device on the bus that is 
downstream of the controller, not only the controller. This is necessary 
on this controller variant, else hardware like PCIe SSDs with MRRS 
higher than the controller break.

> Maybe we should rework no_inc_mrrs in such a way that drivers could
> set a max MRRS in the struct pci_host_bridge and make
> pcie_write_mrrs() and pcie_set_readrq() pay attention to it?  That
> might let us get rid of the FIXUP approach.
In light of the last paragraph above, that the MRRS has to be limited 
also on all devices downstream of this particular controller, I would 
like to ask -- does the Loongson controller have the same limitation or 
not ? If not, then I would argue this quirk should be isolated to this 
controller variant ; else, I am happy to start on the core patches.

[...]

Thank you for your help !
