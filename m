Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F024014A0;
	Wed,  8 Jul 2026 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500755; cv=none; b=V1qY3Y7psT5Xz2MNUtrJHok90DqdFQf4WPWO53/aLGbLHE4Xc0cMjwqJsCntD+1ZD3Qgd6hDcGidZT+sXvyJ5guQengAOtBuynRbUnwxNsKKqy3rFg3dBXqo3WzRxso4WH80ge1GN2L9PdLIHfiAbdxZDRA2oH6vXeMegIzcI+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500755; c=relaxed/simple;
	bh=4aV2kosGG8VZesf/U7LyoVktRZk6LKuio236GZg1D0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTMpkEtLEyNgjAKEoGRFAPrQ41cGnQCNF7853YrgpCDNbrT6BQPiflCozAgJFF5A3I/LgBKlBEXOCCUT4EJsrwkWXmIs8rSdUiIJPZGj0SnSVW/YxiA5JAswesg97HyVxlL1QwPBSqmFAYHhZV1jJIdJ7MbI9j2naVbqSdk+l3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=Rztz1Qnu; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="Rztz1Qnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1783500745; x=1784105545; i=smoch@web.de;
	bh=WuPKROSQy27f5ERjnaD6zbbcpGwAHoy0QqlJnlvWWtU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rztz1QnuFJJxNf+nnrx7X+5oxqGIVlf66cDrijUNLiewgDhTDjVpI+5R0aI7Ael+
	 zUrr5U/VDcfsOqa+ylGIZvFECsLfFh72NsLav1kgquH7mhrdWi+L9pUULdBCmf1hQ
	 wQD/xIKQ/3vOblOsIcTkQHn0CUcOT7kLXpBjke4SDfzFrhc2uQ7mkBEta98ojdKRI
	 cyRuI1R7yUFwuvpQWyHE6cBxDOgWDOCa3jIHX5Z/nsp7jRYyLMRgnoWjZdDRJKruH
	 OSZu3DzrQo12s8ikGwseCpBUp7KZkt5xz5BPf+ZQU5UM1v74/2Xb9lq3QXv0QA4VV
	 6MfktrdQCou4L+1yVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3uS-1xINSl0X8c-00hfKp; Wed, 08
 Jul 2026 10:52:25 +0200
Message-ID: <465b1dcc-8e96-4edb-aebd-52937b8076d0@web.de>
Date: Wed, 8 Jul 2026 10:52:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260427115804.134231-1-smoch@web.de>
 <2cbqhvfjszzuanp4i3rohntkxpfgftfjvzt66te3wkohsvw26g@yv4txuy74tvu>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <2cbqhvfjszzuanp4i3rohntkxpfgftfjvzt66te3wkohsvw26g@yv4txuy74tvu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bniRGk3ERbiABV48aeodYQQ7GWcqv8Lv0DhFRhMbwEBxuuqxbck
 dIZQ9OW86X9fOMphpajhazA9JajXv2pvbdQdL0955UeGVUH1eAECkfB5zTy4rJ7Gm9a0bkK
 pt6RsrKix3ZARjsIyy4TwBPVSCp9MLUUJ3GPY7ET4XGRAi3c7OYtmeUiu0GAu63WwkWIoZf
 mZlNGH+/lSecz9iAZV/tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jyx664a9ju0=;9YdqFhZc1Q8CqFjGW2gykeWkyFq
 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
 dWh7fMXkvmoAjshKAOS+5V9++KxrDx+EDbMFKT5

On 06.07.26 12:29, Manivannan Sadhasivam wrote:
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
> This is not the correct fixes tag. Correct one is:
> f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iM=
SI-RX is used as MSI controller")
Thanks for the fix of the fixes tag!
>> Cc: <stable@vger.kernel.org> # 7.0.x
>> Signed-off-by: Soeren Moch <smoch@web.de>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>
> @Bjorn: Can you merge this patch for 7.2-rcS with correct fixes tag?
I can send a v2 of the patch if you prefer.

Thanks,
Soeren
>
> - Mani
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

