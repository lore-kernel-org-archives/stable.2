Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF203403E8;
	Sat, 19 Sep 2026 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789801032; cv=none; b=kbHUAtrDcSudQe9cbhiOxjRHDMTqx0MpUuF0T0AYZsHEEltxoht6FLP33X5SlDOcyrNXIpXvt/+KOKewD0ZWMCQpYZXnibHFNk4tPIDIddpaAJsSxTd67MaRZk5KDxjV9lLVl2vZsAKBN7R1os/dDoZXJzxhEQ+rY0nXsKf2PH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789801032; c=relaxed/simple;
	bh=45MegNFsAtWYZexybcxxREXKZcERntxf2K3y+Plbqwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkbRCIsVN07Y1r290wWDHRktzyTOxT/My5ALATt1y30Jpl5gIxzeMwlnkRY6zLxHJ44f9GVPAKgGcxKXaYIG2qA/8ip3YNg84AQoUHHJOLfHtd5yTiUUmvqjLrKykiQpHI7jKZ1Kud7vj6DR4e74xfutp4px78AgIlvBNVsCId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=U/CB9llW; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="U/CB9llW"
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hn0fT5GN9z4Hxr;
	Sat, 19 Sep 2026 08:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789801025;
	bh=45MegNFsAtWYZexybcxxREXKZcERntxf2K3y+Plbqwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U/CB9llWNSX1S9/H1CeQaSFueCxQ7sLv0IYESdRM5+9dlWxE366shfod4dIM71S2x
	 FWGB/buUtdsU18ZfaUlORZ8Sihx2tJuDp9hNTgbTCvwo8dJoyBDpZIoe36NRFX9hgs
	 YhoUwtz2AjdhEuo387ng5Qn2YfFIQH5aMMGU9eOsr3sFY/GItlvuBSTBVvqATv6rlC
	 iV9pZsGYpY6h63uL1svqQAPNA3efL+tQpbduO8G4G8oowwJTQ8Qme7I5EEM24iaAfC
	 0V1+U/m5JRtRry1IBIFmNK3+iZ1H+eWrETQaLG7UuA4lN4waVfdqMJGA3roSClErkd
	 VF/kj0rhM5lyw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4hn0fT4Xccz4HxW;
	Sat, 19 Sep 2026 08:57:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hn0fR751Sz8tg2;
	Sat, 19 Sep 2026 08:57:03 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 24A405FA32;
	Sat, 19 Sep 2026 08:57:03 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <344d9e26-769e-4551-9dba-f48ccbd6793b@leemhuis.info>
Date: Sat, 19 Sep 2026 08:57:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
To: Bjorn Helgaas <helgaas@kernel.org>, Soeren Moch <smoch@web.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, stable@vger.kernel.org,
 Manivannan Sadhasivam <mani@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260918230015.GA1205610@bhelgaas>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260918230015.GA1205610@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178980102368.147768.7933732274283946620@mxe9fb.netcup.net>
X-NC-CID: sWpGcjgseDQL8M6+YmxU2Mdbf5E3igADS7Oh7gQWPZPo/0Cxv9Y=

On 9/19/26 01:00, Bjorn Helgaas wrote:
> [+cc Thorsten, possible regzbot confusion?]
> 
> On Mon, Apr 27, 2026 at 01:58:04PM +0200, Soeren Moch wrote:
>> Also on the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
>> the iMSI-RX MSI controller if the Root Port MSI capability is disabled.
>>
>> Even though the Root Port MSIs won't be received by the iMSI-RX controller
>> due to design, this chipset has some weird hardware bug that prevents
>> the endpoint MSIs from reaching when the Root Port MSI capability is
>> disabled.
>>
>> Hence, always keep the Root Port MSI capability for this chipset.
>>
>> Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
>> PME and others won't be received by default. So users need to use
>> workarounds such as passing 'pcie_pme=nomsi' cmdline param.
>>
>> Fixes: 3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to work around hardware bug")
>> Cc: <stable@vger.kernel.org> # 7.0.x
>> Signed-off-by: Soeren Moch <smoch@web.de>
> 
> This thread is still listed as a regression:
> https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20260427115804.134231-1-smoch@web.de/

My fault, afaics; sorry.

> But I *think* it's been resolved by:
> 
>   b4bee12ebecc ("PCI: imx6: Keep i.MX6 Root Port MSI/MSI-X Capabilities with iMSI-RX to work around hardware bug")> 
> Can you confirm?
>
> Maybe regzbot is confused by the fact that the regression was first
> attributed to 3a4e8302e72f, and then later attributed to
> f5cd8a929c825?

The main problem is something different: Sometimes one commit causes
multiple issues that in rare cases might even be reported by the same
person -- and regzbot needs to keep them and fixes for them apart. Which
is why it is cautions and will only auto-close a tracked regressions
when a Link:/Closes: tags points to what regzbot considers the report,
as Linus demands those anyway. And b4bee12ebeccfc didn't to that. No
problem, happens all the time, normally I notice these things and tell
regzbot manually. And I kinda did when I noticed that a fix was in the
works, but then the subject of the fix changed later -- and I missed that.

These things happen and in a ideal world regzbot should be little more
gentle and likely auto-close tracked regressions when a Fixes: tag
combined with a Reported-by: or Tested-by: matches. That is kinda on the
todo list, but not near the top (wait for by LPC talk). Anyway, thx for
mentioning it and let me update regzbot:

#regzbot fix: b4bee12ebecc

Ciao, Thorsten
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
>>  drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
>> index 6d6a1688e7eb..3d461bdef967 100644
>> --- a/drivers/pci/controller/dwc/pci-imx6.c
>> +++ b/drivers/pci/controller/dwc/pci-imx6.c
>> @@ -1865,7 +1865,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
>>  			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>> -			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
>> +			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
>>  		.dbi_length = 0x200,
>>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>>  		.ltssm_off = IOMUXC_GPR12,
>> -- 
>> 2.43.0
>>

