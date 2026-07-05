Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D66433E71;
	Sun,  5 Jul 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783242644; cv=none; b=KtZKbDib6CICB5gR+NHexNUz8r7LXtldpTQ0H0/ghidCEHBaqy7RhI3xlZrzu2OOaXCNbWpzWuvFDnR2lPkrkxqxrskUmkHFxOZxgU6NElcrLeDB5OSPY8ZpEqtaQmpcjFJzRA8bcJYj2KCOueBTMEjOnQ0I1OFHq+MdvWKb8xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783242644; c=relaxed/simple;
	bh=iS5G+xYG7iAyoNXePhTxtqj1OocT+t5iw3ftcUJ9ibQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSESYq3wX9K1J4z4e+r8Xu65T3stsJjOg2eiFR9Zl1HGgpypqla2A3GbtWfcibJcEwH82xO+sL32WDA3ZTTVR+uoyo74w1cMp6b0AHDAWwmdKKwkMVIgwsKTLE8dvla257OQ9sgt9/XwkjmBw+1eWnuqpVPkrOfRtlvBUyKFbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=saiz0Q0M; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="saiz0Q0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783242634; x=1783847434; i=smoch@web.de;
	bh=dmcS/2Z8c7bLB3cq33oZxXF1hzP0249gNKxn5kuNito=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=saiz0Q0MT6ko5S6w+4uAmxWH/lWIa4M1YOwDNKmlRIz2t5kMDaBlA5vusOrmCZVo
	 ortqj590Ccjt0RF1hfboPTvc5W8A4bdOlyyz6ooDxCOKKLl/4GvV1BezdS2vEhTwZ
	 HT1zu09TSVilySZhahnHOBsL5rmqsK+0XTcrq4OTjJQCPCdp4Vmrfl6LKAAOwL1kG
	 W7MsFWpgsEtHzGTwBVqaokBZXAnACtpolc/bfZGY+bu1i3H2pHEv4LDHmGbaw9r4C
	 QSX4yN9U8lRA0W1joe5RpJr7m+LJgk4ybezS2lfwR4CsN+ZEpvoNkg4ihOxCpdcHh
	 OJuMePGK60rdezSzyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1wsy400Ta6-00EJUi; Sun, 05
 Jul 2026 11:10:34 +0200
Message-ID: <ba9ff61d-8840-48c1-828a-842ab0956e3b@web.de>
Date: Sun, 5 Jul 2026 11:10:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <frank.li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260427115804.134231-1-smoch@web.de>
 <AM0PR04MB5220EBE4BF61ECBFAF162A4D8C372@AM0PR04MB5220.eurprd04.prod.outlook.com>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <AM0PR04MB5220EBE4BF61ECBFAF162A4D8C372@AM0PR04MB5220.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:28JiQIGXKLlJZQRTCEmyBOJ7EjmP3jqOkDtW/WELL8i5gVpU2uX
 JdmEND69icmVdefpzNuQ52R0Wffdq8iEKqOTtWNlk1QTSk/ZrZl4ICElnJO5KkojaA3kWlq
 dZm5wVgPHctVPaObsQcFIjADYKuQusNEWAIlHLD52fuaWjbIua/HEAu/JCdXfJROOEZoLJ2
 BCQo4Q3FAuH7yjnY/HFeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C7gBAdrINs4=;n2uDLsfH8MEC7pHphums0T4Ws5a
 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
 pbokcNn7xj2V7CA1/o=

On 28.04.26 04:19, Hongxing Zhu wrote:
>> -----Original Message-----
>> From: Soeren Moch <smoch@web.de>
>> Sent: Monday, April 27, 2026 7:58 PM
>> To: Hongxing Zhu <hongxing.zhu@nxp.com>
>> Cc: Soeren Moch <smoch@web.de>; stable@vger.kernel.org; Manivannan
>> Sadhasivam <mani@kernel.org>; Lucas Stach <l.stach@pengutronix.de>; Bjo=
rn
>> Helgaas <bhelgaas@google.com>; Frank Li <frank.li@nxp.com>; Fabio Estev=
am
>> <festevam@gmail.com>; linux-pci@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; imx@lists.linux.dev; linux-kernel@vger.kern=
el.org
>> Subject: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX=
6Q
>>
>> [You don't often get email from smoch@web.de. Learn why this is importa=
nt at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be receive=
d by
>> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>>
>> Even though the Root Port MSIs won't be received by the iMSI-RX control=
ler due
>> to design, this chipset has some weird hardware bug that prevents the e=
ndpoint
>> MSIs from reaching when the Root Port MSI capability is disabled.
>>
>> Hence, always keep the Root Port MSI capability for this chipset.
>>
>> Note that by keeping Root Port MSI capability, Root Port MSIs such as A=
ER, PME
>> and others won't be received by default. So users need to use workaroun=
ds such
>> as passing 'pcie_pme=3Dnomsi' cmdline param.
>>
>> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMS=
I-RX to
>> work around hardware bug")
>> Cc: <stable@vger.kernel.org> # 7.0.x
>> Signed-off-by: Soeren Moch <smoch@web.de>
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

This patch is a regression fix for linux-7.0.
It is still not part of linux-7.2-rc1 .

Can I do something to get this merged, is something still missing from=20
my side?

Thanks,
Soeren

>=20
> Best Regards
> Richard Zhu
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
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
>> b/drivers/pci/controller/dwc/pci-imx6.c
>> index 6d6a1688e7eb..3d461bdef967 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] =
=3D {
>>                  .flags =3D IMX_PCIE_FLAG_IMX_PHY |
>>                           IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>>                           IMX_PCIE_FLAG_BROKEN_SUSPEND |
>> -                        IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>> +                        IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
>> +                        IMX_PCIE_FLAG_KEEP_MSI_CAP,
>>                  .dbi_length =3D 0x200,
>>                  .gpr =3D "fsl,imx6q-iomuxc-gpr",
>>                  .ltssm_off =3D IOMUXC_GPR12,
>> --
>> 2.43.0
>=20

