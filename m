Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E33382F0F;
	Sun,  6 Sep 2026 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788678585; cv=none; b=PcLokD0h92t4KCE5jtUORkN4Si6B8kIPtJlA0DPUuJ5t7pimTBtf4deyfsXI/gJMXAjOV3IE07QZcZYy6vYHo06eD66YH3+PewkMnfL1PbNENpTU2f0vZc8dyXVcqYRDhjBxIJFWh4JmbhsDsDROYMqD8JflqExbkorMlxtBIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788678585; c=relaxed/simple;
	bh=nsZCOwoyPne1CMbhMeg/R0tgtHypCmcpilYIufjMp3I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IyVo3WVRI3u6D5lC1ceQddNYrtaur3fDb5vnooDfhGw0jjgu0SfaSgnko69nfxEUMbHiyuMpr62fN13Xsgo6C0cyDy9E9W6uOomzIKC14izYCsLJq0aKNO+tY2UXkE7Y3fbEIVM6Weu9DspxT1ZVAjHwXiw5d0ApII5i+ToiRN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=k9lxunKi; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="k9lxunKi"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hd1Xr4k76zKmTw;
	Sun, 06 Sep 2026 09:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788678572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gyn4fPqGTOF40mffXejqlLjAKh4vqNHJDhi4UbrP1d8=;
	b=k9lxunKitmp3hMYebAHJ24mQL5In+6gG++q6e9SSB1dxZSes5i47LAH/8jobBDS0gmvK5P
	LWGMwBlxsc+91H1o/etvw0eZqT3VXFNs2drPQ4E+mAmqcAYG3XevO3n3YlUwW1KJwVpsJu
	P4uX9ULd9FA4pyMo6Gz1eKnMCJQB4FUq13/HVW+g5mE7Y1oWfzrDK+irtrqDgBU2UmDbTn
	xujc/FdSQ2obGVLWqWSISXjYiCOjjjJ5XGKPVkVUgra8rBKJl7bYaX/pgjQwW7GeK6+rmp
	Xy/0gQXRT2H7DpWruNfF1F+7S5QJXCNfe/zNBkPerCfl43bTGco0IfDAKWkabg==
Message-ID: <9f0d8887-9332-4919-bee9-c165361e2ea3@mailbox.org>
Date: Fri, 4 Sep 2026 23:53:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
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
Content-Language: en-US
In-Reply-To: <41f323cbed2da4fa3913dfd62b5595bc3d5228da.camel@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4ydkocobnf67bucge1hj8x51ydhjbots
X-MBO-RS-ID: d82f86a892c3b203f9a

On 9/4/26 7:42 PM, Rong Zhang wrote:

Hello everyone,

>>> In light of the last paragraph above, that the MRRS has to be limited also
>>> on all devices downstream of this particular controller, I would like to ask
>>> -- does the Loongson controller have the same limitation or not ? If not,
>>> then I would argue this quirk should be isolated to this controller variant
>>> ; else, I am happy to start on the core patches.
> 
> ACK. I agreed that it should make our life easier.
> 
>>
>> I don't know if we'll get a real answer for Loongson (there's no
>> maintainer listed for it, hint hint :)),
>>
> 
> (+CC Jiaxun)
> 
> The driver was introduced by Jiaxun without updating MAINTAINERS. I guess
> he'd be willing to be listed as a maintainer.
> 
> I don't work for Loongson, but I do maintain several MIPS-based Loongson
> devices for the Golang community with my colleagues and personally own a
> MIPS-based Loongson-LS3A4000-7A1000-NUC-SE mini PC. I do some PCIe
> experiments on it from time to time for fun. So I am OK if someone wants
> to list me as a maintainer or reviewer :)
> 
>> but my guess is that it does
>> apply to all devices downstream of the Loongson controller.
> 
> I believe this is the case. Maybe Jiaxun can shed a light on it too.
> 
> Just checked the kmsg log from April, the firmware seemed to only clamp
> MRRS for devices directly connected to the root ports. IOW, it seemed to
> only clamp MRRS for the upstream port of a PCIe switch, so
> loongson_set_min_mrrs_quirk() had to fix up downstream ports.
> 
> If you need more information I can do some more experiments with the PCIe
> switch card.

Please look at the commit message [1] , that lists the exact test and 
the PCIe NVMe SSD which triggers the data corruption (let me know if 
something is unclear). I think any PCIe NVMe SSD which is non-HMB with 
MRRS on the SSD size that is > MRRS on the controller side will trigger 
this issue too. If you could reproduce it on the Loongson, then yes, it 
is affected. You might have to disable the current MRRS workaround in 
the Loongson PCIe driver though as it might hide the issue.

Thank you for your help !

+CC NXP, because they have similar controller on MX95 (and others, but 
the MX95 is closest to this I think)

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=37ca1997d2eeec86ad065008d6387fd15d18934c
