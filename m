Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793718528;
	b=axTkfaycci2hST5Oaa7MdIEef7ZOHF/dIhcs2oYC1228Ofxb49EN/c3Kb52OcHmjyfEC
	 8NRr8roTsYm3Zc2NCEM7tlzqQi3yHzyyDTIddVIcFeA/E7MsutHHTkcS37DHIOgEN2ydO
	 Da4tfcM//USfHARauP0y4jRUspLziJCPIjmX+RpNQ+dQKXmw0mQh7H9ar3iLtsX4+gQ+C
	 +TORiXTdtM8r9tsRq5bbe9yeFteHHcxD8BtDnYRsMOZbRsZIUOGuGWa5uYPh6A7cn+NfQ
	 o6iN0ueDrklLDfpuR4yZw0anGm+gPi3nxVbRnwvW/y/qs4HHI0a3adw9p+rDRV2l9nA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718528;
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
	bh=h2RX86/Rq0AYMdjirmxoC74rPEC6xO5dfRvSVTm5GFU=;
	b=3/g71k1rh3TYodThy8tZiIBkFzrXsiHtGtRRayVdvhwUgJym8fOGaZ8OmFW38XSyqFgg
	 6aQqGjbXteDWCvqSEWDucdK2Ac3uefLq15R//WWFhV7B2GjKjuBYufw9ohm2guebJXOPK
	 7ylsdRMTIyauKhLEjjlZ6oiR7PUdz46V+OQ+KGXGpjixP7V+B3JLAhv7qDYmu0N+cP0x3
	 uj9GMRFyCxp8cAsf188sa+pno1oZfqtn+aCCOQ2oZ+l49LRr5bm30zNkIzWaT/ic295IT
	 3X9SvkUQaysqpe1MboZtUbYk4c5znsfNw2jVhuIUorkjv2wfGiaRJiJ6ueYZQInAMiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PZEM6k+K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.23
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8A606F62B;
	Tue,  3 Nov 2026 15:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE8A606F62B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=PZEM6k+K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va3/tiQFUhQhljf6uZJUo2mrl+tt1LbKQb6HGG1nTNzjBUIyX0gSR9i1J/k2Dh0i6FvRX17ingyV/yw/ML7GGZHW5RgMgznt3WDxf0yE2NsTIouOzw6GgWtDD4VljrxzSfizOxAJp+vK4eUtO3o337Ib0xvi5oQ7xQbVGr/TPTNevZqvL850fNymWNRVyOc1ozMeLJRU796aH6zWhIm/mb87r9JFO4BE7PNLJ2VnZM/UuVMwTcWX3CG4+6ns5I8bgZgw8kFtN4nzusDscJ0v/r/6SNyLYgBKwW4LJ8WvLn7dHsXXfNHSXQWq86SS8d9P+wrsm4t27I8J3Ym225BYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2RX86/Rq0AYMdjirmxoC74rPEC6xO5dfRvSVTm5GFU=;
 b=hMoyY8QB9Z2qUIDcOzjNdTWd5uzqCn/akwnGxU6vgXW8vMw5VaAdl0psBTCtzcnUseoEQ2ftoxn/ug7MhC+yjvoGGS7i8Nc5eSQklxcKu5c0Ws2RPYU/e3zz2vtQe/WtLGr4M4BIRP2jW06hNbHe20sJRpODN+dVDAcoHWoIp9HBI3mQH94puVpaFHhBBYDjtEqy/igxqjcCn5umWova37bjO9y8yKSlxRPMxJHjtCt9lZU5jDFFr2ihALO1ucZpRAOgTFENUfcdyS0zzJwAicOPbCg18gTbLoG7dSCviNxKQhQgh+iEHtwjy+S28qeVMaTG9teKVsjQ0fXzuzcMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=posteo.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2RX86/Rq0AYMdjirmxoC74rPEC6xO5dfRvSVTm5GFU=;
 b=PZEM6k+KBdZZl66jCuLMV841rjtRmbAG6eZWl9v20OMIoF6I8EMbooGtYQQulCeZNpRIDEQm7ATC+uV6yHGOugsP+PzTHgI1jM5E9l6I/x3g6lfOg9dLcbncN/+4u+f7FLhdLp8jIyMJFtOGbRi6pDf4ss0SVbPzIoph++/o7FIefgwSYATNCIBkDYnwFXZ7P0oj4b6m0Hla2SCwDUe8WowSHb9uUx7T3Bavuni71Sz2u9YIOEhkFA5s9oZFaRBjemJeMaK0t/Wy0kFx67RkPzWLOH0f5ygSQYIWD+gsE11LsmERfYmlgEHu+SvrXH4ancLRLcErAK5bh+JjOeOyKw==
Received: from AS9PR05CA0116.eurprd05.prod.outlook.com (2603:10a6:20b:498::10)
 by AS1PR10MB5747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:08:44 +0000
Received: from AMS1EPF00000097.eurprd02.prod.outlook.com
 (2603:10a6:20b:498:cafe::71) by AS9PR05CA0116.outlook.office365.com
 (2603:10a6:20b:498::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 15:08:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000097.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 15:08:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 3 Nov
 2026 16:09:20 +0100
Received: from [10.48.86.101] (10.48.86.101) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 3 Nov
 2026 16:08:35 +0100
Message-ID: <10bc732a-e36b-4067-ac97-1e8ac15ba1f9@foss.st.com>
Date: Tue, 3 Nov 2026 16:08:33 +0100
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
Subject: Re: [PATCH 2/3] mmc: mmci: stm32: do not use NEGEDGE in HS200 mode
To: <mateusz.nowicki@posteo.net>
CC: Ulf Hansson <ulfh@kernel.org>, <linux-mmc@vger.kernel.org>, Russell King
	<linux@armlinux.org.uk>, Linus Walleij <linusw@kernel.org>, Yann Gautier
	<yann.gautier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
 <20261031120700.42576-3-mateusz.nowicki@posteo.net>
 <a5fff7cd-686a-4fef-b9f7-87e19b870fa9@foss.st.com>
 <f9358cbe526c22c6a8fcbdde814820e3@posteo.net>
Content-Language: en-US
From: Christophe KERELLO <christophe.kerello@foss.st.com>
In-Reply-To: <f9358cbe526c22c6a8fcbdde814820e3@posteo.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000097:EE_|AS1PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 0908601a-5475-49c0-afe3-08df39bc5a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|11063799006|4143699003|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	w8QI4t3mVex1VP/hzd63P2PmLvrk2TzOaQvFVJGm8t3SKQgqUYsOnWWAM5URvmyyz8In89RQu5KC1F3hfp6ES8x6JKJi7M7errXdOf9UG8ABOtvJjYrpU9ScjaHwE/4JVbLQPP4sLeFf87ulJJT/pDHk8s+qGpQCAGPiEVmsugULonQWtJ+kBW0sUR3hp30x6YVbT698jZOb6jWp5XZOV9p84dLGc5+vv9STJ6MosHSCDabtMDGJU1nN2CnVuOG3OnzbF7DhTsUyx5Q7RUc9grRukdroQ2K9x3DMIQRVqx0w/0F7sMFJ6dtFCR/OQChUaQKzU/cJ4wsu839FMbH9NdV4GFbkisQIqSYSpaFsSuVH+l3M/Fkf899v12FK7pZ4B6FTuTKwkQ1neXLwf48lanu9lnDHZenTWvK2GCD1LNPxCetMRwfdiJ255og2OFJNUFXT0/6R8euKWE7rUFVOQDlHpGFaxSZd/hI8DIKOBJF3f9YjOLToK4fFI+oZvHju59bTFVkFRWrJgZjgAOFqPzO9tXtoHsGlUJ9QjvkJIU+5KaNZr13Y6AxQwgT3zI9shwYd1BHGLubu+9nmZhfluz7QMY2zzJNEdoupaO+hbetqT8nagYzF+lkSeQ2OmT2KDG+LvJ4pD0veZ5eO8Fd3hjenPKlrjo2x8CrxxnueWg0uzR7pzbrqzOhRAUEbQKqsii5df4z/mxeLdjPF3GRYBw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(4143699003)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XS0AL6yw6D9+Sb9T14IJ8ryV5WU5JXRwZoRqQFh2nbsXiXoohRop8c8/dtV09DnPa7I8oLbI95SHbIiZEekTJSPz0ZdrIT8p9b4DxA/M7GWQT0NsAErR5sUZK7erdecakp4C4/JdnvxrTZL1Us4X0z0HuVJKhLHnAwx3/1SArczxXBLgcT6Rj8iLXxY2Xd6xwegH+KdKf2qZTkseH9d553GzgE0V9n7ybfMZt6YNd6ARt+YSVf5KdTjnFj5e7Uo4glG7n2pa2hM6ow3ffC737rvNWLPpfoMc00W0NNZMpcL+FzVQS05PaoYGX8uVwVFb9yWD7BuARS3zp5+8H36RL50wjhRyCMzU1HClm99bMOz6+kNL63+7Rk4kBOjcxGQtho4YJQsTAnuysqRhZ+DCkrWYSA2upQMFt+ZIYgjnHcbrXydPmE9En0s2YMEYxkfQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:08:43.7610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0908601a-5475-49c0-afe3-08df39bc5a1d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5747

Hello Mateusz,

On 11/3/26 12:40, mateusz.nowicki@posteo.net wrote:
> Hello Christophe,
>
>> No, it is not what it is written in the RM. If clkdiv is equal to 0, 
>> NEGEDGE has no effect.
>> NEGEDGE has an effect only when clkdiv > 0, so it can be used with 
>> HS200.
>
> You're right, thanks for the correction. I read the NA in table 268 as
> "not allowed in HS200", but it is only there because CLKDIV is 0 in that
> configuration. I'll drop this patch.
>
>> On ST downstream Linux Kernel, you can find following patch not 
>> already upstream:
>> mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25 SoC 
>> (Commit ca3b1cf)
>> By applying previous downstream patch + patch 3 of this patchset + 
>> using  original slew rate that was upstream on
>> this board (slew rate set to 2 for the clock IO, 1 for the others 
>> IOs), HS200 should run on a ST MP25 DK board at 100 MHz.
>
> Thanks for the pointer, that was the missing piece. I went back to the
> DK and tested it with the SDMMC2 kernel clock at 200 MHz, so HS200 runs
> at 100 MHz like in mainline. Without ca3b1cf every write test failed,
> no matter whether NEGEDGE was set or which pin group I used. With
> ca3b1cf all runs were clean, with pins_a as well as with pins_b. I also
> checked 150 MHz (no divider, delay block in use), and it works with
> both pin groups too.
>
> So NEGEDGE was never the problem, it was the delay block running at
> 100 MHz. I'll include ca3b1cf and 01d3cac in v2, with you as the author.

Thank you very much for confirming that everything works correctly in 
both configurations.
I let you submit these two patches upstream; while the commit titles and 
messages can be adjusted,
we simply ask that you retain the original author information as well as 
the "Signed-off-by" line
when the patches originate from the ST downstream branch. Thank you in 
advance.

>
> One more thing about the pins. I added the pins_b groups (faster slew
> rate) to the DK device tree in 7.4 because pins_a seemed to corrupt data
> in HS200 at 100 MHz. Looking at it now, that was the same delay block
> issue. Would you like me to send a patch that switches the DK back to
> pins_a and drops pins_b?

Yes, using pins_a on the DK board is preferable to using pins_b.
This helps avoid overshoots on the SDMMC clock signal, which would 
otherwise occur with faster input/output (I/O) pins.
These overshoots can interfere with other functional blocks, such as the 
USB; therefore, it is better to use I/O pins
that provide a "smoother" signal. Since pins_b is not being used, it is 
best to remove the pins_b configurations for SDMMC2.

Regards,
Christophe Kerello.

>
>> This patch breaks also MP13 SoC that is supporting HS200.
>
> Understood, sorry about that.
>
> Regards,
> Mateusz
>

