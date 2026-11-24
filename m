Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795517534;
	b=bbTLA0RiBVJyNCJZaGgV8Zks04ZYctJ8HWxT1JDoVn3j3wQ2GcRc8IiGR9Hi9OyFdxZm
	 Ex4lixWqkUtO2TXiqpLTR+4Mr5H7NQtHzsgCHbAFd7TyKfyQN0M1kFSgVNjm7F8Wbs7vH
	 7ZHSOAsB8sfETRHQPjBFR+SuHebFMeuM+a6qJ2wUe3w/gsfkwe/vnqLhmFqZ0Thx8HPtF
	 nf0I4emhyJ2y3FQAzGis5L+t0BFR1gIVYpW7Vn8iIVj2FIEIxcSF5eWRn0gwcMvfvqtWJ
	 1wgbC356uuEbsVemsKGm/xK9wp+AvfBjxUzyDk18q+JgFs+AkSPnKLBboMj4vISWF+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517534;
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
	bh=6OY/g2KahDEwLBaN2yrWMkgC0Tody4yh2gB38BZZHZc=;
	b=WrAoBfR92ScNc8yLwpJH68+0Iue+C0Sn8aC6deDrp6euHOJAzLpWRissRJK7jq/3A1nu
	 ZMBInCq0FiMTsV2xBrK4fif1Jkq+owd+0lYqS1mByq11BOOgPNH5ghgVb53qhumceyVXe
	 2Re2wbh03ySpb8/oRq4pyCvyYD3WM+zEK9rrcJgaArYzD9mQ2H2ibKrc2RDluCiAeGZSO
	 TZ7nL/5E4rFKUO5aZ58wbesj6N93t1L+NXN2xunECWRuc2/DEHPgbjiQ4meyuNy2m2LnZ
	 iQzHCy5yRYB8uiHgevBR+TFh3x5F0D+7emiYT8bqiUY8THPShJr7PIWyhqE+aN4dQmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=UwBS7oLZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.35
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA39606A326;
	Tue, 24 Nov 2026 10:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA39606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=UwBS7oLZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQTlKZ7sUE++K8Ydmt3iMr4r3Ks2Z5MJYaGLIynEfoEcw+yEa1MKeUbLtKCc6KFi2r1DYohAg4I3wFBwA7c5evSo8F+MFOXZzWR9+LHB7Z4x2AlBlusY865KN94JB1pdrwzKLLprO0XK5priJe8C67rrJK5UJU32MLZ9AtLZ3scbXDxvKswrqlgJjCdbUZKhmf/CM1QFvkb777oFit4BJbSXj6vDQguVmuKreGbGxVs1tw5UDIUToozV7V6wESEPzZLlKipitiRDRY52bMvRlxh25UwBBVVzt0FHUpnniJrrhGalEf4l/ovu01YAkgoKUrW57C4XmYZeMuUZ4wqL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OY/g2KahDEwLBaN2yrWMkgC0Tody4yh2gB38BZZHZc=;
 b=PSpLZt5LRPQo3Uxjz94HChrZHDfW5gBG8nPKHQGPFvb0foOFjp/rpj+ZHcx0WWjLIFfUOwAv/K1CNQNZll3bz3tAP0h5ujAaFe7fmZAiXhn6gMa5qjKxtDwgGMsZD6ATiy/Q966M0cps95Nnnns2VFsfFSzil94uCIPDJmYa5/i52kWBCvF51NYI1y9vhRKKp9tVo32t+bjxtpttCOnDnyto0dUUqgk0BMW+qIsPQF4HVn/oSPCRqbtENiBzQK0EfVr/JDeVXrHlGsnZMTDpcs94VrZbfakcu1EbV2abR9U3KpoCV7DCwmrlQn547HgZGz7Hcqa/Hp66c931esW6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmx.net smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OY/g2KahDEwLBaN2yrWMkgC0Tody4yh2gB38BZZHZc=;
 b=UwBS7oLZUvUpWK5f+fcQ/S24KGGY+A6OrQu0UUnl6IOIChyDEU+sYZeq1NI1VlWT7C3u0yWEpB0KmDc5kfClU0aDmYZY8ka+LvcAYRvNJaXm+xQrMU3FQudR7otF6xBAsc8AOG+iM8JVwMf6xJO70jaDM7mOodDDqqgRwSA3r9yXtxdRhzaSMbEBPjwVxOIcbtUQpONTeKHYpMHqd1kJvuG4Fyc772rNovyzb6/QdGS7oWBFhLoImNT9w8rNPwJRaBdRIcYJ6VbhuWYJvDJLeeB3l637n9jUKbYSYukyDgJyHW1tEbgO6B2z/tW56cKekokgXkFKA5JwtlGYayWIcg==
Received: from PA7P264CA0072.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2de::13)
 by GVSPR10MB325529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:714::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 10:52:09 +0000
Received: from MAD0EPF000008C1.eurprd05.prod.outlook.com
 (2603:10a6:102:2de:cafe::7c) by PA7P264CA0072.outlook.office365.com
 (2603:10a6:102:2de::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 10:52:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008C1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 10:52:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 11:52:56 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 24 Nov
 2026 11:52:07 +0100
Message-ID: <7ffe72c6-6204-43ab-bfb7-5df87341ce7b@foss.st.com>
Date: Tue, 24 Nov 2026 11:52:06 +0100
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
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <af32cbc3-9c24-4e43-a7ca-f4716f48cb34@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C1:EE_|GVSPR10MB325529:EE_
X-MS-Office365-Filtering-Correlation-Id: 54703c32-89c1-4a18-1ff4-08df4a18fcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|10067099003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ILp9mCXvw0scW+AgbJzaoKfBily0BSZMOj1k7YG0UNX8fu6GfCHczorBXJix2B8h4jUIFCC6Mi0aPePPqmgOzLsgjkYyl3P28DwnYILs7jIAZ9o5mmn7Y15ynIm+V2ZM5/Y50xAVLedjIwnv3lyemmPCaa2AlcL9Rc0dZipqJfA1CkDrdz/hSJ/1xbtGGp4T5LU4W9hCeLxHUpZbbWxqKsaWKEp9ZhLFyjadSknC2fxXS4gsgpluOpfFtnT8/r24LhW3yszwKPEpmfNuNvuWpntoMgVd1B09tXylDU/GYgfnuNsIhLnrETyGGMSC+yKcl7TeT1dZCpejxMveqbrUsmIPwBUOBG4+LXt5w9BjqwWmhYFsgLzrjZiEX3YjrhuuOfryX6Pq90/kCMCk7RtqMkBRWW/hq6L4YNRyt6kkvz9v6ArPCfaurHi76Y9LGkvltvmFbFht7RScEN47+Q0f4MyZEYY6ojIbKSD4KlI9GRlQSZ12S9HLEbImVSUY+68NAFlfKhW64z93aK59K1BdcnOm41iU2mjkB1eLtWAms9J3crIWlIOn/x1Enj838+p8L48iTSG14xgvgydLTEHwtjuLoiJs9Mfje17VUsavNycjtj/we/33NF4rejv8rFyP8tIGA8fTg8thkCxwdwzjoRNHiRgfs3nLwzWMmnaAEFbwZaPIaHfXUiiD99ykPdgJpDful/ZYJNPpiG1X5NZkvA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mVjCJVm4AFjXDKt0Iy8a+gZI/gPMR4B4n6SqjKz+GZCFdxMa+tRQslqRaq4wnxm7rJN8qt2yVYsIOmWL5rixaiICziwDqGOGJeMEWnToviZ3Ct3VjnWR5rCeeqCo7QUMqnuuwxj6pQdynoRg76duy+ybDMtFUiYHcepfI5LC3+EP+LJgVFu7UqYQKsycjD5UTaOB/kUtl3NebsckVAssRSo2F4UTP7IbZk/+QLXlJYdn4QXEqQ5armrblgHlWAMEtumjvNtoIGJTzOSBfoPqRMcr4gExQpIfLXXRiJvRbkqjBoQX80Bp+yHv6iXO/voshwuH3HIG3ydKoucF5U1z0JB0U5/jIHnNjgOSOKuaRHbJZIDiH4z3XDIaAU8sPYdP24fhNGa+MXYSwRmN0WwbUmk2VNEUW8cMDYnOD98BPW2miQhcJGm8lHusHoQPnI4n
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:52:08.8135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54703c32-89c1-4a18-1ff4-08df4a18fcb4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVSPR10MB325529

On 11/21/26 21:38, Stefan Wahren wrote:
> Hi Fabrice,
> 
> Am 17.11.26 um 18:06 schrieb Fabrice Gasnier:
>> When the power domain containing the DWC2 controller is disabled during
>> suspend, its registers are lost. Reading registers to back them up from
>> dwc2_suspend() after clock gating can hang STM32MP1 in both host and
>> device mode. Host suspend enters clock gating directly; in device mode,
>> this can happen if the host suspended the USB bus before system suspend.

Hi Stefan,

> sorry for breaking this platform, but I only had the Raspberry Pi for testing and I didn't get much
> feedback last year.

I saw your series, sorry about that, but unfortunately I haven't tested in time...

> 
> I'm not familiar with STM32MP1, could you please clarify based on the compatible which is affected?

Yes, "st,stm32mp15-hsotg"

> 
> Could you please explain, why backing up the registers before clock gating isn't an option?

Well, that can probably be an option, thanks on your suggestion!

That's not the way I had in mind (power gating and clock gating are two things).
This means: prepare for register loss each time the controller is put into clock gating mode (but
drop the backup values when exiting clock gating without PM-wide platform suspend, as these are
normally not lost).

I can rework this in V6:
- Add the registers backup call when entering clock gating. This will backup the registers when the
bus gets suspended (either as device or host), then a later PM suspend request can skip the backup,
if they are already backed-up.
- Remains some stale states, as raised by Sashiko: when doing this, most of state flags have to be
re-initialized. I'll try to split into separate patch to ease review.

Is it basically what you're thinking of ?

Best Regards,
Fabrice

> 
> Best regards

