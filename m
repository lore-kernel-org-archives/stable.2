Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DCB524AE2;
	Tue, 29 Sep 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684901; cv=none; b=KPX0mRn4ARLBGLbuL1MPSJdTvxRbJSADuUim2STPVzEESDTCwCkXu4+YRj3wqZBF46/wZ40P10jpnVo8ZAsMWpiplHuLyrJBusln2W6q/SH7aCWQ8U6iZSPLFsnunpu6zWq9frOYvsNsIkmA4IUUSpaArNJv7M7mkztcZoBmMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684901; c=relaxed/simple;
	bh=+cG7fXhfH44GPpiihqc3jolsI1hs19xeXjug1n8pdWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsjsRnW3LA79y4of8IKElQaa7RJwXEWknZwrVTIKjHG4wmuydMtrLZDBzlEW6oMVq7tLVJvIolmnabLyJTpbCrGZmQpC7Ucju+3LKwzfDTj9q4jSBiyyZiQZTxAIgEpTsJohAab0v83lkcal3Ekfe+aSGdFCGYSy6AensIu8gVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=II4lA4oa; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="II4lA4oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1790684867; x=1791289667; i=smoch@web.de;
	bh=oSS1t8WVp6yXjorGxUEQVe4Eoumrkf3qihxiPmIzoFs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=II4lA4oa9nTzLCCS5maEzR0VokcWkRkvWajF3905q/x5m05kjTw6kQVVsD7I4MVJ
	 zODm+w8enKybioS605JccPx2qHZyHgKpz/yCuMsjobsqEkqHSzhu4eERRGRCJRSei
	 MvJvBAxeyt6wTILfI0zJ7zw/rt1HU4w/sgV0iL1o3KLvQme/ACGPzp3uoVKNDvGkO
	 E0p/eeWrtj2a70s6lywXaAU5Q2Qhm/p4baifuMT+dVJUvvm6Z6vGpa2eQgJzSCtwu
	 iedQnLd2xc9xOVTHO/LjIsSTJMqMMdcvs8jFPrJAkhvJCvWDNePAn/RXfDeIeLVbq
	 dAurBwb3EeIc4y3MwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG996-1wxCXf2V3M-001Z0a; Tue, 29
 Sep 2026 14:27:47 +0200
Message-ID: <2025e3e9-3aa5-4ea6-a68f-42f0d148e3f4@web.de>
Date: Tue, 29 Sep 2026 14:27:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20260918230015.GA1205610@bhelgaas>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20260918230015.GA1205610@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wujC/WkaY9lOA+mB6vPQiQOEcEi33u+tKOG+kdOCeaxGmY9qUni
 p5RhgDNs5k75m5Og0ZtjH2oiQzbd8tOoH3oizE5+JOgFAf3buYNI2ZK4tzXeHnlI8EbIY4D
 62BZWP2bMNFcfh7U+oEkhNpW+BJE6PhEPrPOiw+q3BBeuEmocFr2UlxPNY0E5CC6OH/iSSB
 8lVH2Li1orERYpRUGcs4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GHqZXL0rVlk=;1pr4uY8SXuuoim2ZlC9Y+/6HF7x
 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



On 19.09.26 01:00, Bjorn Helgaas wrote:
> [+cc Thorsten, possible regzbot confusion?]
>
> On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
>> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be receive=
d by
>> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>>
>> Even though the Root Port MSIs won't be received by the iMSI-RX control=
ler
>> due to design, this chipset has some weird hardware bug that prevents
>> the endpoint MSIs from reaching when the Root Port MSI capability is
>> disabled.
>>
>> Hence, always keep the Root Port MSI capability for this chipset.
>>
>> Note that by keeping Root Port MSI capability, Root Port MSIs such as A=
ER,
>> PME and others won't be received by default. So users need to use
>> workarounds such as passing 'pcie_pme=3Dnomsi' cmdline param.
>>
>> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMS=
I-RX to work around hardware bug")
>> Cc: <stable@vger.kernel.org> # 7.0.x
>> Signed-off-by: Soeren Moch <smoch@web.de>
> This thread is still listed as a regression:
> https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20260427=
115804.134231-1-smoch@web.de/
>
> But I *think* it's been resolved by:
>
>    b4bee12ebecc ("PCI: imx6: Keep i.MX6 Root Port MSI/MSI-X Capabilities=
 with iMSI-RX to work around hardware bug")
>
> Can you confirm?

It was fixed for 7.2.0, in 7.2.5 I saw a similar (?) problem again, in=20
7.2.8 this is (finally?) fixed. I did not test the stable versions in=20
between.

So I can confirm this is fixed, yes.

Thanks,
Soeren
>
> Maybe regzbot is confused by the fact that the regression was first
> attributed to 3a4e8302e72f, and then later attributed to
> f5cd8a929c825?
>
>> ---
>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Frank Li <Frank.Li@nxp.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: imx@lists.linux.dev
>> Cc: linux-kernel@vger.kernel.org
>>
>> Tested on a tbs2910 board [1]
>> [1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts
>> ---
>>   drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/contro=
ller/dwc/pci-imx6.c
>> index 6d6a1688e7eb..3d461bdef967 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] =
=3D {
>>   		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
>>   			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>>   			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
>> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>>   		.dbi_length =3D 0x200,
>>   		.gpr =3D "fsl,imx6q-iomuxc-gpr",
>>   		.ltssm_off =3D IOMUXC_GPR12,
>> --=20
>> 2.43.0
>>

