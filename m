Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793984755;
	b=bd/FETMqlbdym6OwCPEhIj4jOt6fBYIeAI63+WW+7wDstNTFWQtQkWSBkXNFSPz9djmZ
	 XeGUdU1ydOfQA/M7nwaFfCs5K9O9ltD/eMJUJpKvxrQY1J164K/ZAsTvU/+ei82Rm9wVB
	 3ezcMV5BvD6KV3l1ela1AIVad7RHN58InAc5myrFYseArZMkGeJ10NPSOV9vllgOVfInx
	 WMSB8XmMrDvZCeFOIxIlc7AlbY8bTD8QCosVigVYuIBqX3y5xkQkpGwvcrBp97gUfVRZD
	 s664aLE+pdks6O1G8HSku7FeSy+EfbbcoFmEXRJ2wf2wnH0UQx6y/QytKNdkTcYTG9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984755;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U3BzNvAjUkUy/A4qgoSPLPmdZVpZ27XAx6m1i7Z9SY8=;
	b=SUObsx4+PLkfWMUiJ/A6nyEkMFB42LN6yV+C5u6Bbquoedwg4RZ+HxzS5amwF91kJx/x
	 mKDD4lSGkk42P0fVTr2Lyi1nZIMju570F1J2EDmpS2pl14FfuafNJUpKxNpEe3igwtPyt
	 XaCyEe9UvaRaF3sadXsfP2ZWrFwjkERYBgy1ZAxq+FvmfZo/+4L1TjxjcE/6UW0W21tqI
	 SJvZ+3bp8xI9RUbZxqMNHn9Kb4ZxRz0qhF0+FSxnldkzfxwZW/2VxFsz3fYLxy2z9Cf8+
	 83/tc1hnJwxd2xuwTSOQazzex2C69MG+UOR0Dt1utI9o/iV9ywTF0J9teDfBcLiSFDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gBfk0KAP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.18
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D914606A329;
	Fri,  6 Nov 2026 17:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D914606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gBfk0KAP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvrmVAW4mbNbgieg1dRiVL0s9Mb+keuxD2Wxiv9GhF9pmpOmTe/p6FaH1BsKRU3uJ86BM9DByIAMAAszz86LqoUpv4AahCflEBtwBqmoQd26zhPZ7+CvswSahxI8zlnnvW+Y3YT4rq+O/DP4SiSzkaoqcPd8y8yVJS7G1pVoABvRyznafKm4kt7KnYNNt7Kb01I7xqGIghgsCgHQE+iIUrhuB91A4V3CxiEhq6lWaWeL7JsGER2xOByd9RW3S/a7pEhGOBWDimooYjeVJ+ZqsRY+DucVtse/KLilTJEVW/zF64J8dXaxX3YcpgLg5wE1jxO9DERKoyzCOXBVNtGZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3BzNvAjUkUy/A4qgoSPLPmdZVpZ27XAx6m1i7Z9SY8=;
 b=fw2PJwsKly89KqQblfzeO4S5yueEhmI3joFbJAHFmpKu1lEB3A5Av7HbzAUtCq51qGbpGtFP13kg0kzUqAjB3FSiMFrWsR5vLuOCUWGUNJirVAiotvXPAFxGGjgdhZawwLHCdMYOGd6NAonPRmCeAWD+nAc2tb7hfgNqCnXTsB+hZDf3DjHuS9zjKgj1TMM3fKSD4Me5Aq17+7d5cHKrD0pNN++7gdyUmnXaZuQUA1vQEehTd5Qy8+n8oXw0FtX7w+1nAFREF8Rsh50jyLvQF+einzmLnlfB101erd1w8b+Sr8qKdJe70sQ11rgHSSnjXu6nLEYSEhgML/HwwJN5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3BzNvAjUkUy/A4qgoSPLPmdZVpZ27XAx6m1i7Z9SY8=;
 b=gBfk0KAPvadjHEKO8F6Ymk1WYsT++DZ59UZDQelH5fQiacZ3PLbfqviK0AvJw30aW16J5OfgruTsyF3y2cFLlwtAIA1KevviQ+Cayu2l3g+mncMsdku6zO/KZepJRnhc/fTHfqp1ZVIsS14SQyZEDPFFSnlNBq/eLwweERXuxJKkuQ3ZTAwp0gS34zWQvox9Gt7Or4RFeCVLue/L6zCPdPhTc5FJImE6/kFx0xoAmmrFbCSMBzc4oqcLs2D+Y8D+j7WNdvxdtJB3XZw2RtV6P8Qhv6j2mfV80lOEHrEimlsUHmU51TXMgdDmEcdMESIfQ6/wowa7iKBMo2oPXttjoQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR2PR04MB122097.eurprd04.prod.outlook.com (2603:10a6:2c8:7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 17:05:52 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 17:05:52 +0000
Date: Fri, 6 Nov 2026 11:05:42 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: qcom_hidma: Fix runtime PM leak in
 hidma_issue_task()
Message-ID: <au4I5haNWglFazT3@SMW015318>
References: <179395457228.2120679.13809646473624751961@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179395457228.2120679.13809646473624751961@iscas.ac.cn>
X-ClientProxiedBy: DM6PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:5:333::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR2PR04MB122097:EE_
X-MS-Office365-Filtering-Correlation-Id: 448bfc90-e8c8-4009-9a81-08df3c283651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|19092799006|261009223027099003|11063799006|5023799004|56012099006|261102123227099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wOMFiLNHi9/y7QUuHb+TejcydAj4URf28BpzEk1D4q0Lt8dOlJZi+ZYWaHKCO3Bah269aYIIN1M6AboBFTapB9Bv5IDcqKG/WS5layaEHUc2t6Bn0WEud0vS250NOd9xQnD4ITcwrXU1TgXit3EeFgGpi3hcmXGddZ73qBOxdrkiHFmX+UfilFD/Zh58TcWRUXjeL4EDzWK6GySkYPq1kDh51S9AuLeUkuCP56WHe2pexv6oJ+1CWp1zljyWgnaGGcRQv7iAkjp7+xB52nUaJ/ZWrVOJZ3/ytQFStAepXHUOGvzyxMp3kILSBdIeYpyNaRmZTdrWRWcUV5qbb9sypZNkt5W7j//XzTm53FIoftn97y5vbyAgwx15C+lLzuRUOrYzqnYl9YEhAxxOamvegUU6IlPpw2vnNFTUDP6hMfUwAdnrQ/OfGrgvpxH88KU1xoOQZ4I28bcHW/wpwUQGV3qzZcrhv/bONl4BUjbYZW0SA1bVPScloWRwjiIT8WxvSzOtFRjpnXEfzL1dcpuu0Qa3tzeEa1WzSk4ziW2LbM5Qifau3TSvYeOdQhE9xidsd94KvT3myo87xJwHGDFWSee3+yKDhfQfyhw1S4ES1gHfBP1cYZTVLI4rIQ927msF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(19092799006)(261009223027099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?76dKIqdEl4MWW3kK9khXWJr4oIWXpmbfLA286mvredVfL+t7iqpIgol7Kc0T?=
 =?us-ascii?Q?SzeM5nEEsJG3xXd9Z7bdPnNoG57vM2AFASLhd4bMdF9BJKmEuq7M64YzH3AJ?=
 =?us-ascii?Q?YCjRuVwHC13NuMgqeky364BcUDSdHL+l//NDKFEZWjGSN3pRRSc+i30S4VYx?=
 =?us-ascii?Q?YXreocg/mMncwPsgjUaExF+MQez60NxUfri8zzrT7TH7bMBzTWsLlBJ1R06A?=
 =?us-ascii?Q?r7ovfmuac+jd+D2jnU7LZJlyauRmOehqEgsSJc7Wd+cOxBIWoBdyukp3hgUc?=
 =?us-ascii?Q?VFnWYnyjqhPYDtm33OYY9g5DUXEc8E4R0fH1EA93oxnKevgeVhNGcXVPt+Pi?=
 =?us-ascii?Q?osgsxyqF7gT1UACPuPeisK+VNOi+xjGCX1FqB5emmjTN1KzwrTGg0tQZ6kfK?=
 =?us-ascii?Q?fFGQ59K5Q+AFIxn43QnnePdXb07riPVbgnLN9Yqdz8m+uiLc16VumlGpNitV?=
 =?us-ascii?Q?liOcz85MXDJVWVRP7et/ooHOzCO3cTPnojZ9sEIxlWG1JDbJ4FzlykwV93UR?=
 =?us-ascii?Q?LL5Oo/P1/2xUnoRcSwa06rF2J64hJQJ6knUhN7NaG2xbxPFOr8oQixIF61Ug?=
 =?us-ascii?Q?jr7sAF1imQ4VEFQqNjtAhiEaJc1941k/Xl48qHMoY0LwbYsL72UGcgKRJAZ6?=
 =?us-ascii?Q?heVQsuONzGVELqvEbsVIKyOriBXkDEuUXgxQe4ov2Zo8KLPgTFgNqa0WyDwb?=
 =?us-ascii?Q?RE4LO8YLB512W5Gsxm2X7ZLSZl6wWX9QmQPFyoiOncqpmNzo/O1CTyxyHZjS?=
 =?us-ascii?Q?jLAOk9er2j1olUYjSblss2/s94WbgtEZWp8vd8SEEx2Qgp1WYmHRVMc+IbvT?=
 =?us-ascii?Q?t/ESo/kHxSOBEgnlElaqFQmP520caZY5BeELcEDsK9EIvtCkD0p//0HqUZg4?=
 =?us-ascii?Q?21zrWCXVFqJKQlRlbttBAHM3cr8IgRgxfvFZ0KT4Q0OCyLUh7FcTNxWYe8AB?=
 =?us-ascii?Q?XHcLxFM8vi5JEdAVEf9T2I3Hp82RILsByvKf08s3bnEgotXkPkR0esJaceVH?=
 =?us-ascii?Q?78zkBsv5njDOsIXnJmbTy1rqw7p6u5dtHNuGYAWexmHY7CQtjl8qwJwHp5ws?=
 =?us-ascii?Q?tkTmN9qccO7KDFG0ypOVFRTS6lb7ALCG+xPD8JX5EEdCOq+6YIrNcKnAyfE5?=
 =?us-ascii?Q?qRERPvJItlonVcjC4oCaRYM9a57nxnCP1XcXn+XcZqcNUk9qs8igP4LW46FV?=
 =?us-ascii?Q?3ORJCbeMp2xlho3gbYaRXy05kjNktI/3177W6XYUNkE2i/eGWxmgUB1FfMwc?=
 =?us-ascii?Q?eUxL2rLlTJQ7arQWFS4N0idcq+nIFNLrW0Guz4Ef4IF/B9ygo2kUwCTILTfj?=
 =?us-ascii?Q?dAu+6nMCUWGtziqaLQfNS3v+y9Sx6J0Mtd8UfkPOC+ng9rQu7siZ3C+CAnDF?=
 =?us-ascii?Q?ye0x/CitgFjig09RXHZd6mI4/AuOFp3LS0wL3liQEmvoi9NUJPDR+UPDVrC+?=
 =?us-ascii?Q?B8CCyYcoIKukCPdPQwLVXUNaOU02DBiHZMiAYy/lBTOYWDzW6IkauJEbLOd6?=
 =?us-ascii?Q?FOTlbbYkLUvfVCFBqW0bLsW6Nhl9EZCXJjcWJqPZ15wA2uIuVZM2DqCKtaMO?=
 =?us-ascii?Q?w//AKcWZyWi1TM47HVXsl4wFGewaLR5re6kEmhDvV9k/2DAbw9Jk8qJQAB+c?=
 =?us-ascii?Q?JPOn8xFPlMiyTwCFjxewiXCaXsFpCJ2aFqsI1B3Gne24QR6AIeJaqU6xDIYU?=
 =?us-ascii?Q?jJDILemo48U/ejRA2xlbWlSsxncGALH4kXvyKaM97b2+m6/98PzVCtzDk5SF?=
 =?us-ascii?Q?VLNTNQ6D4SXfyj8Q3WxFLz29bltBFW1ddikEX7RooX77NkLWld+c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448bfc90-e8c8-4009-9a81-08df3c283651
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:05:51.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZoImhvZM1zRyGvYm8G81We+HHb3lb8SEewQVHbqM5TVq6suJpYyJ1Yp/Rry2+eU5dHIzJ2QleoTMIudacNLDtq/UygRNa5CLug4+RmEF7jRPa4kSIYkNQSXGiCwOPNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB122097

On Fri, Nov 06, 2026 at 08:42:52AM -0000, Wentao Liang wrote:
> hidma_issue_task() bumps the device usage counter with
> pm_runtime_get_sync() without checking the return value. The counter is
> incremented even when the resume fails, e.g. when runtime PM has been
> disabled or the device is suspending, and nothing drops it in that case,
> so each failure leaves the device with an elevated usage count and it can
> no longer runtime suspend.
>
> Use pm_runtime_resume_and_get(), which drops the reference it took when
> the resume fails, and do not start the transfer in that case. The counter
> taken by a successful resume is still dropped by hidma_callback() as
> before.
>
> Fixes: 67a2003e0607 ("dmaengine: add Qualcomm Technologies HIDMA channel driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Krzysztof already report at many threads

https://lore.kernel.org/all/e34e5630-2f3e-4f7f-9f47-4fec11c1a61e@kernel.org/
https://lore.kernel.org/imx/20261104-small-pompous-basilisk-ac9df8@quoll/

vulab@iscas.ac.cn is bot, which is not real person.

If you can't reply and clear this situation, I will mark all patches from
vulab@iscas.ac.cn as not appliable at patchworks for dmaengine.

Frank
