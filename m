Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624646;
	b=M3s6JziHOr1H9k7N2cMkEvsm+PdXmRQa+qcBbCAwWpuxB/q4hsHb9dZpK9Kp00QAKjUb
	 Q7KxIQ9jgZYNtyrcBdn7IMTDpc83Ozi472mwhepEjlA5/cPk8Q6o4vG5NccVUA5oGVHJy
	 3j3YdUOycZ+0BNQnt/qTj3f29wWNqDUPilpl8eaBRL7e8gx6c1FbRa7GzfFAAxQlfy5td
	 qlbmQHgiY0PCKKD8pztnglmfJVECxmh3O0rFIUzGvv7xlYG0ZWfholrp6zNyGNLTD/aJP
	 16TIC7IXgnhyq8OlWmAABkWxznNyi0s4VDiPCk7/Ni6XuMpcq4ANQZK8TclbGJFGLyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624646;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9o4pK2PaOnVo7Ci9LX74TqWMbiaEupW8n+0E9uabHwg=;
	b=jDXdordTwBJqdrBGi2Q1iWcUHjQRrSKJp6tfMlWhD13KTupLmeim0nsad02FyUpnFzRF
	 LHW5oTuZhulNNH6XdETxHFIbWTdrFHQqyslm8FuuVP5SaGjIuoo6m6NZ2eQQjBWXxdnSN
	 HvIyTEGElcmnlpGFhfLZp+1oQsvtdHP+uNgaFE/P1h2UaKUCnLmWH8TtqvwJVlrEWJAsI
	 1xshk5t4cgFJ9LaGoJnrc7tG0CgPUTa0TVDeHQc9sdxHK2eh3cD6oLGa+suffkGpu8iSu
	 WrPiPHlzSDgzoJI2tiDEwWMkTCCyofuCvAldHQNxIh80BenkhrLy+CmJvvEUNvQ6e0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=eCilcXeM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.62
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FC606A338;
	Wed, 25 Nov 2026 16:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D33FC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=eCilcXeM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuFDmuc0RJ+ddkgu6uyjsYfYHDBJM04o4yCBqCIwU+LTLqACIrDbs6EWCzS8H8t/0py26jc3AHcJRyB51aX/tFY9TxN5rV7wrf45bP2qg/5DA2BMVQvoNipsrBF4kKHDn2zkcG4KNYblSELYdJvFmz1vy3rmW0U1/j1/TyJDQLMkDwOw7lmoPkn0pXitNPLh86HccXG6n55Cz/bZLW41Y6N3t6NIFq+ETbYTKKcfUy4PlpbsikIZksyU4CJNuemKA7hR93SJal7tMfaML/6Dp13BovuLfTrCFr+B1eAN9kX4+wZspm5ASgL6hEI9dkoD1xmNLvNSIOj8RGtP5D7lww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o4pK2PaOnVo7Ci9LX74TqWMbiaEupW8n+0E9uabHwg=;
 b=gpPLzR9IBXaw4Hz8tOEZI3474AlcVAqgicXz8ibUft2GfZ3eOsfw9twvrGfKiYWLGSTP4bYIhpQ71xC6NNiqT9zzBaGqRrXJtu6awJYSsX4owCkPxsnqTgyorfVKPCbLUu1lLMRlkcbIoX3Z1WW1pp+iuc7bzC4VIXfJeq1BLnXEgXS+bGjh7hlZIRTXZjRDwm/H34lJEVs03kIdStw9OKu50RlJjC//Rwl4lEQViib5jHepWqVXPW85OcirfxsaVVsavj9Sc+mc6PvVwTm7g07SDueQQdkmnfh5ih9mZWK6MjxyB3D5qXFUoVzDTQ7UEhD234RHO6S+vW+fPlfd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmx.net smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o4pK2PaOnVo7Ci9LX74TqWMbiaEupW8n+0E9uabHwg=;
 b=eCilcXeMFjTlp214SYvbkKKmTVOQaY4gdQ6yENguPBQGZ5lFJktm2Nz1fDWv1k1dHV0bawoiJcQMiBcIlaz0KxIEqE5c9xGNZ6ro+RojlG+BoDE9cqcnZZxpp2Svvwb/uupMwB80QXsyCxTM1csIM3sF8OTXsTMZ0f2awkpmmvZdJarDOQqz7s4fieGJhhtY3/V8RRx9M3uUseDNdkJYeU8QuiAVhqdN7GRFBIsciTKTeVNTKhpj7BVUFwPcO+PsJk1w0OFKFJEyBMyvtjqaRERVaMAH6zyXa1A4Hy7S+0jVhA84in2IpAuecBd0xC+fQjwwW5y5lcOVagnha8qaVg==
Received: from DU2PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:10:3b::16)
 by PA1PR10MB8628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:37:15 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::8c) by DU2PR04CA0011.outlook.office365.com
 (2603:10a6:10:3b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 16:37:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:37:15 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:38:20 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:37:13 +0100
Message-ID: <5667c6c4-19ab-4a16-be2e-07d36830259f@foss.st.com>
Date: Wed, 25 Nov 2026 17:37:13 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] usb: dwc2: fix recovery after PM domain off
To: Stefan Wahren <wahrenst@gmx.net>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Douglas Anderson <dianders@chromium.org>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Jisheng Zhang <jszhang@kernel.org>, "Felipe
 Balbi" <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
References: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
 <20261117-dwc2-low-power-fixes-stm32-v5-1-0f197e0e6362@foss.st.com>
 <af32cbc3-9c24-4e43-a7ca-f4716f48cb34@gmx.net>
 <7ffe72c6-6204-43ab-bfb7-5df87341ce7b@foss.st.com>
 <5c2bd597-a279-4523-b702-0af2c6d9d4f3@gmx.net>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <5c2bd597-a279-4523-b702-0af2c6d9d4f3@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|PA1PR10MB8628:EE_
X-MS-Office365-Filtering-Correlation-Id: c37496c0-474d-434b-0541-08df4b125d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|10067099003|56012099006|261026140227099003|261022105027099003|261022075727099003|261026121527099003|4143699003|261028144727099003|11063799006|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vspbfz4VHR+PBhzTNnRGjwMVF0Poki5LU4KXRMhrhfRRlzj7P6vreG761jR9OwqZ7doquPbSUmRYjUz8ruljxeR56k4lj7JbIXjrZyyZ4xPH/SLhACJp26tLE8yZLcTbs8IrErl4pIpgva3z/XCB+ywNPfWU+8FREVDdEW2b2kMTEkwBVT2OwVIgJZgFlkK9wUA7sZ20/+CSkOZNVe0iOQNv16dHaJDw6mn8GLHBz3FnIX5qYyzRMKGDsQoGlPrAembYBhXy0eP1Zym8R1Rli8galpQSFtchuSge0jkFVNsp8wxP8CyeNoQN99i4M9lQHOOKRZCJxHjN6wEjZNbAi7wAAmVU5ctosPVjxFEJKTsXcuEeHp63bK2ha5WixdKm0UUmV8lCFX6lxuhbnMZss9nEoBqZQc62E2rAXNZTWWhck6KoZDNR67iu3F2C/+Vnqe+DWtfcN8f/2Vb4Z8c31NQHUT+n6u44EnxOHdULY4CGj8OckpITFEuKWXeFslb7ijuu/gcqG+nBxYIN85OXLvRKVVC6mDC5MXt8+lgh10uNxQklRSkoispZek5ODfLOE6PaRUMHysKONZasH4ysufU7T85f/BDMFI+PwcD9wcTtavIwx2uEi5pscqxbque1XMZAa26TYrus3TLJzw4zsakmGlv9ch/ZMN4n2LO7NYM=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(4143699003)(261028144727099003)(11063799006)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1wvJn3JB/8pPzXq+GfiuGQ6i7ftKHzm/sC1HPwHWpDAhm9X5t6erSmb+jxdQRfpR0t7FZOJ4JudEqZ2ClNSkSe6BGGKD7nMDgNgjBouEOrP+iYG2h8+OHYywxkyy8IGAdV7/fKIADEvMzrymcglay+WFUvBhKKachPvQ8GNUryuYOQUQwxofs+C13GjwbMYCczM8Z/unidbwF2I5HeBsj1yFJNmMt0TV2DFREaT/C4pG8D1K32uVmBsxizCS7CniSFWH52EeCS7r67+z0LEIblkGVh5Y2ehxc/lZvcWW3BRU/ey3owNn85BEBKniHkYaBKGsp0wxvc0KM92VgkIYJ96ynCgfhjZZzz42b76DFc2OhoW4bJDI17VEP+4KQky9KdnIQmpS8824UBoNngpD5Y7cx8dPaZPj2E+p2Q1nP30owIFWO3/wp9ubZEp0ZFMz
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:37:15.1091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37496c0-474d-434b-0541-08df4b125d08
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8628

On 11/24/26 22:31, Stefan Wahren wrote:
> Hi Fabrice,
> 
> Am 24.11.26 um 11:52 schrieb Fabrice Gasnier:
>> On 11/21/26 21:38, Stefan Wahren wrote:
>>> Hi Fabrice,
>>>
>>> Am 17.11.26 um 18:06 schrieb Fabrice Gasnier:
>>>> When the power domain containing the DWC2 controller is disabled during
>>>> suspend, its registers are lost. Reading registers to back them up from
>>>> dwc2_suspend() after clock gating can hang STM32MP1 in both host and
>>>> device mode. Host suspend enters clock gating directly; in device mode,
>>>> this can happen if the host suspended the USB bus before system suspend.
>> Hi Stefan,
>>
>>> sorry for breaking this platform, but I only had the Raspberry Pi for testing and I didn't get much
>>> feedback last year.
>> I saw your series, sorry about that, but unfortunately I haven't tested in time...
> no worries
>>
>>> I'm not familiar with STM32MP1, could you please clarify based on the compatible which is affected?
>> Yes, "st,stm32mp15-hsotg"
> I think it would be helpful to have at least "stm32mp15" in the commit message

Hi Stefan,

This compatible is used on stm32mp15 and stm32mp13, that's why I mentioned stm32mp1.

>>
>>> Could you please explain, why backing up the registers before clock gating isn't an option?
>> Well, that can probably be an option, thanks on your suggestion!
>>
>> That's not the way I had in mind (power gating and clock gating are two things).
>> This means: prepare for register loss each time the controller is put into clock gating mode (but
>> drop the backup values when exiting clock gating without PM-wide platform suspend, as these are
>> normally not lost).
>>
>> I can rework this in V6:
>> - Add the registers backup call when entering clock gating. This will backup the registers when the
>> bus gets suspended (either as device or host), then a later PM suspend request can skip the backup,
>> if they are already backed-up.
>> - Remains some stale states, as raised by Sashiko: when doing this, most of state flags have to be
>> re-initialized. I'll try to split into separate patch to ease review.
>>
>> Is it basically what you're thinking of ?
> Yes, I'm not an expert here and mostly followed Doug's suggestions. I consider my suggestion as a
> possible fix for my original approach.
> There is a reference manual [1] for the EZR32WG ARM MCU, which also have a DWC2 IP. Even if it's not
> your SoC, the chapter 15.4.8.2 Suspend seems to have helpful information.
> 
> I hope this helps.
> 
> Best regards
> 
> [1] - https://www.silabs.com/documents/public/reference-manuals/EZR32WG-RM.pdf

Thanks for sharing the link!

I just have sent a V6, please let me know if you have further comments there.

Best Regards,
Fabrice

>>
>> Best Regards,
>> Fabrice
>>
>>> Best regards
> 

