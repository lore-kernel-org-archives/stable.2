Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6C355F5F;
	Wed,  9 Sep 2026 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928678; cv=none; b=cEeh5QDgazWlqFCReAMoYWog3ejiSA7AlxXVT3WnRi6pZjt6cywDu90ZaLXbMRVp6JnXstA2xSLSjssR/+/tBR0CvtxZmczjWqXtlIVIDNDUQ3pqyLc3MeGzFRpi29NLxLyM88uJk59eRRsj2TUczUzM9K9WKXwakTdIsjWxKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928678; c=relaxed/simple;
	bh=lRyIVsgUeJhjJ7BccB4WbwegZoXXAKiZ0z0jlEpN61Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsbyCuwnXwSdUyvmwFPYmPKeKnEM6oSBhzo72R8GhU5tgfZMvGINbZI0bEuF0chma/49f3Q1q3SwX2VUYqUq2Wg64qUmDKbBtxQBRZuiQu9z/EopBxD107F4M86qPIERsXAaz9JumCEz56eOJ7q1VxmVyEmbynCa8GKnQwaGAh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nlJLR6MB; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nlJLR6MB"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hfp2R50Z0zMlBh;
	Wed, 09 Sep 2026 06:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788928671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GN/vfEfIssNYISWQGVk3lddr9BJex5fLw0q2sOxtz78=;
	b=nlJLR6MBBs/x+s+8I9cXqVZVsZ2iZrPgMLKP9O4z8+bokX4JxRa3OM9Hmbw9IVpSDhpkE3
	y2ZF943Az7gl8iroIc4RYFZAFrOkmeXYt075fn6S3HHG9Xe9Go/ZJ157fMX0mklnm8SJsn
	5vKCAHxRI6HKtyzhDRXlumyG0XEtS/XqwtGSW9VDjxExKA0nsYu4uIUCTzG156ZLjTL7mU
	ser9CJGE33mkA2WGDb5vHij1A+YamBVBrfAoMozvyFYTUE22RpDnpAMznRaBiraNDmcVN9
	YZVer3nHh7WOCN63DmcUxiGtLSLGNLvelc0IRZUzhUkdGxNOtE/IQ5AnZd5vXg==
Message-ID: <e563766f-359e-4133-9960-1b691bc0c774@mailbox.org>
Date: Wed, 9 Sep 2026 04:34:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
To: Rong Zhang <i@rong.moe>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pci@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Ziyao Li <liziyao@uniontech.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Richard Zhu <hongxing.zhu@nxp.com>
References: <20260903202706.GA2234456@bhelgaas>
 <41f323cbed2da4fa3913dfd62b5595bc3d5228da.camel@rong.moe>
 <9f0d8887-9332-4919-bee9-c165361e2ea3@mailbox.org>
 <f66d7e55bb388c550e70fc425f1b911e40e0d578.camel@rong.moe>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f66d7e55bb388c550e70fc425f1b911e40e0d578.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: chfpd9wiyfed5n4788txtbqrw9sp9p6f
X-MBO-RS-ID: 7b2f3847791e0361f4b

On 9/6/26 7:07 PM, Rong Zhang wrote:

Hello Rong,

I apologize for my delayed reply.

>>> If you need more information I can do some more experiments with the PCIe
>>> switch card.
>>
>> Please look at the commit message [1] , that lists the exact test and
>> the PCIe NVMe SSD which triggers the data corruption (let me know if
>> something is unclear). I think any PCIe NVMe SSD which is non-HMB with
>> MRRS on the SSD size that is > MRRS on the controller side will trigger
>> this issue too.
>>
> 
> Unfortunately I don't have any non-HMB NVMe SSD, and it's unlikely I'll
> get one anytime soon due to the crazy price. Before the AI supply chain
> crisis, I bought several NVMe SSDs, but I chose HMB ones as they generate
> less heat and consume less electricity.

Maybe this could be reproduced even with another PCIe device with 
MRRS=512 or more, which posts MRd to the PCIe controller with MRRS=128 
or 256. The AHCI controller might be capable of that. I only have the 
SSD as a reproducer, but there could easily be more.

>> If you could reproduce it on the Loongson, then yes, it
>> is affected. You might have to disable the current MRRS workaround in
>> the Loongson PCIe driver though as it might hide the issue.
> 
> Due to the lack of non-HMB NVMe SSDs, I can't reproduce the exact same
> issue. Theoretically I may try to mess around with the AHCI controller
> (see the mentioned commit below) by manually overriding MRRS, as my
> device's firmware already clamps it. We will see...

Does the AHCI controller have MRRS higher than the PCIe controller ?

> The firmware of many Loongson devices (except for some MIPS-based ones,
> see the commit message of commit ef61a0405742 ("PCI: loongson: Limit MRRS
> to 256")) already clamps MRRS for most PCIe devices, which has proven
> that the 7A1000/7A2000 chipset does need the MRRS quirk.

This still only applies the MRRS limit to the PCIe controller, not to 
all devices on the bus, correct ?

I would like to find out whether all the devices (not only the 
controller) on the PCIe bus on Loongson must have MRRS limited or not.
-> If yes, then I should start preparing core patches
-> If no, then this quirk might specific to this controller

> Therefore, you
> can just go ahead with preparing the core patches without the need of
> waiting for my test result. It seems that your approach is not going to
> change the current fixup effects in a significant way, so it should be
> fine.

[...]

Thank you for your help !

-- 
Best regards,
Marek Vasut
