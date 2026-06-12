Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4E29B8D0;
	Fri, 12 Jun 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278712; cv=fail; b=XQsefe2vIEgkjMNrqfzSFpFRGvL5N7R/y3UoQVDk8C7ToOK8iJuveKHNvotZjTTOTkL6Sjvhv82IcanU6GSCgWDMg9HLAwpaDNCVcJgsMajBXxI3XOwmA578ZuDMDPYpV+eBGaA7tEjeU+404l3/nRhnVVAg2+eFMsouivaRiPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278712; c=relaxed/simple;
	bh=pytUIlRP3g0iPbRj4/cpypYgwa0J6PgJj1rhokEr8r4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Svj7rnUhML7xVXEtb2y6rTELnvjn1dERHPboeGhEjQ/0ykc03Crq9Rg0ki6w7Aj7xxupbA8wtRVLGUl3Z7GgLN6GzA2uQH+jwv+eHfPFzAvnXCzr44kS5F/0nPikb0jhXO/CDcT7e8oTpM2xvirpxsFwktt4jgSTp+TdxRev6WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=LYeqdXbP; arc=fail smtp.client-ip=52.101.84.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="LYeqdXbP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqhndKni74jVAimBa3RoFnZalIWf+OF+DzYTx1hL7I6c1M7VxcobzdYrMxkdVyQw518Nd1BSF9CULASqs9h0aTkJH1+Lc7YCNuiGVclB1uw2gNGKYczaytfajhK2IFho0SKJh+zww4B6YyMSMkR5MgRP2HE4ckhUcXqDZKt2ak3vgsABmdJc5py6nZZwEJt1jVBf2HCrzEqkGfnlqIq8CQGMCbhxVWUE8IVkicBWINiDUzyUUnKXP0g++mKAz/BQlBhIou4vHscgk8sFU1RiBZS+FGu8FcPklrBl/ckc+G91f5zb0E2xoRDWgRpCEu1VGrnKZnHyYw+Ztfc91/4Qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0So+8JPsbzXZdKea5ZjRU+5S2j6kVx66qOfXBHToJQ=;
 b=lvlIG2+tQUTaac4/RVLh513jnbPwGV4aTJRomhsGOjWqNuiJOn60gpzPfNeYEewHFUWkvPYQtCKZ3bSFrfGUT+I4zaUmSdWyC2OscYTzJk3NN5yxWqBdJiKfPcQJOW0oGiCRbS2vzvXQGentRc4hHR23NKR+UL9qgjMAE6n6zFr63LI5zcwqA4W3LPqhtGcs6Uk2/PHaQTT7WoLeFzKYJSypA1Wf+qqC79338nCFlRRL8vUc6Dd+KMrykTqTSr1scx3kf/44s/qmESI7loCkHWeyJiXneGB0Ns4ZRI6bPj0MuDTdpkwsNGy5hF0fh/s44tVqKLHkzSs+WfS2LwdbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0So+8JPsbzXZdKea5ZjRU+5S2j6kVx66qOfXBHToJQ=;
 b=LYeqdXbPOspIglC8VAUk0PMyY5he+k/Df1Zxd5aEBIhzx7b3gT3DjKALFl8HBjYz59hp8g9JbviArWuPifjURfNnh1YQUF7IbEc0dct6KviNpqRSsSzkyzoNROjfnr2Hr1P4udPxM62Ew48ufzi3ouj1OtFwOP2HejTOWFY6bIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB8180.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 15:38:26 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Fri, 12 Jun 2026
 15:38:26 +0000
Message-ID: <2710972a-ba6a-48d3-8551-1db5639d7d98@cherry.de>
Date: Fri, 12 Jun 2026 17:38:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix emmc reset polarity on
 px30-cobra
To: Jakob Unterwurzacher <jakobunt@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Cc: stable@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260609081728.30616-2-jakobunt@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260609081728.30616-2-jakobunt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::19) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: efd90c59-aa3b-42f1-1250-08dec898a4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9qpOl96E49VuQx6/9WNP2jAH1jNKk4fxaHcY/4OgoPAoTEDCEWA0QdvXfTRn+ajy4FkSFfrN/H+9DboQcePPp0sm3wQ/puZ+mRxpHx3wP2XGtPZgMXjox5jeUjgXFyaslFk4GBllHujmh8kUolMsGajIUHavftXf6E02Db2kgD0JmETmj2Hd/0ZD9uzMDOqQRaSE4UQ+Y5bL8t80o1dSQQBe26J24KPJY5oDwgF3esNVczfaFkayxeOOFDh52tER4KLaoG0zR4fby9Qu80+jqRHpNjTC2lNhorV5OGqQk9d291qTOlYzFynZtmECziOx+Zlsih6L8nVBQLvBi04QYphiPfi+A8j8wnM0POzNq5bZSII5zSFGQDtsUjnIyVjVxxOt50ILGXk6YHipnMY3CKZSmyN6PYWTzSN65/7GpoBk0tcz9QuIpgY4NqFzTxvIbqlHZQdjpqniMkb9HF7lc1rXRbYrHUE9H3NDvNQPbHaEC77OCtLCwimjhr6+1rLen9d1TSLYFAWpknv29fGVW4+Juk/d5rGLA4qkrkxdQP0cPPqKfR1nBCb+YcXd6BS3A9vd2eAo6TYYGJgY0poicFmnPmEjK/BmoqPN+s9pgwN956pGD4I4sMlh9fCfA4VE2tBZw1ThmILDEYUlgV8WS8DbgestZBwEgqjQ+sc9tdatw9dSDknoDkB0bIcVit3/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejZPOW5TeXdPMWc0VG5xbnIwSVFxb3pid1JJMExHdm5xWkQrei8rVEsyeStP?=
 =?utf-8?B?Qm9IeGl0dVVaMityaWc3dXJxNHhXbkNTVFJSSzYzSWd0U3JJLzAwUWsyeis0?=
 =?utf-8?B?ZXdYN2p1Z25WLzhWTDVVcGloQ0FtZ0hKaEJFOWF6R2lyM2pUR2FkazI5NTJz?=
 =?utf-8?B?YWREZEtjL1N6YUMrOXUzUTNDamdMc2ZFdXNPS0xORDFkdW9oN1B1OHpBWjYw?=
 =?utf-8?B?Rk5xbHF3Wk9IOVUzZzJIMk01N2xUWXdZS0VVT28zSU54YzFwUi8rQzcvN0Jm?=
 =?utf-8?B?TUkwU0JLaW80MWlGNTdhc1I4amFtZ1lpc2JMVVlBMWx5YVpHTlRBT1hGUTIx?=
 =?utf-8?B?dktJMXNPTFpDRnBzNkVxNG5ubDVUNEdWcWw2Y2Y1VkJkSTMyRlY2d3YzRXFk?=
 =?utf-8?B?Ri9EUGgrTGx2MDFvdmI4VVFzWW1Ob254U0ZsMGIwQ0FBdk9nOEt0dTh3THBa?=
 =?utf-8?B?SnYxRFlvc1drblJzWXQvSWl0SGN4TklDTXBSVFpJcy8vc1ZIMWVSb0c4dHhh?=
 =?utf-8?B?OEYyanFUNXc4NmdXdzI0Tm9wNTAwdUg1cWppaGNraXJEcEROUXBVRjVJc3Ew?=
 =?utf-8?B?UGRRa21GQkhUcEc1K3hxblF2MG9tWnZMSURqUkdJbHVtZFZNR1JOVXpBdE9n?=
 =?utf-8?B?L3lWNll6OWVpZXExT3FZbWVRRkVOajFacXRMb2tkVXgzTlpucFZPdUNSakhq?=
 =?utf-8?B?bkV0NTZ6Tk44NFRKUTlOcFNnZU1Ka3NNTUVnM1BrOTNkZjAvRzhETFpiRzFU?=
 =?utf-8?B?WVp2dkhqWlNCSU5EUDVseXBwa3RwempFMWhTcDFrdXNIelh1VnNOYXJZeVhy?=
 =?utf-8?B?dEE0YWYvbVY5a0d0N1BNN3dueE5XcVg1MEpjaGduMHBHRWkraTJBd2U2TnVD?=
 =?utf-8?B?R1lhaXVpMWl0K3VzTUJ3dFE4bVcwajlaU3ZpOU5nVTIyRElwalU2MjY0clg0?=
 =?utf-8?B?ZjVnZDI2b2xpQmk5UVM3V3hvSmJwL1pMTmVKMDFSMFF1OTlCSy9Ya3RKTWxS?=
 =?utf-8?B?bnlKSG80ckloRFFDZ1FmZGZXdmlkQ3UrM01ReFhNN0xhUTNvRThRS09VenJn?=
 =?utf-8?B?UUhHTWhJbGVXTVQ3bk1URllLU2tKYmhZZXhoempEMEF5ZnRKVXhFQTFLMzFm?=
 =?utf-8?B?cXlraGVXSDZ6cWhDdzRsUzZXYUV1eGFmRXcvanYrWDJKNFc1c2VOaDcyYVlN?=
 =?utf-8?B?bnBnMU9HSXZ4bnRlemF1eWZxSU4yZXRDVWRuTGtZTWdEZm1hQkFnRnhZZGFi?=
 =?utf-8?B?YWpDZmpqb29JdGRlbzlyaXBmQkZlTmdGZStxVjFQZG1wVnBWcUsrWmZVdVB2?=
 =?utf-8?B?bWR3TlNSSWFoU0NRSE83eGlTdmJKRGJMazFkSTVDV2crcnZ6QzR4SnpMMDMz?=
 =?utf-8?B?SnF0c2FWbmNxMHhWUTA1Nzdna0h1RXArbVptVEJ4U3phT25KbWU1c3hjSWpk?=
 =?utf-8?B?UUMvYUhOSGw5QUp3RkZJOFNMYUZSMFJCQ21rT2kxb3EzakVyTzRSbG01ZzRD?=
 =?utf-8?B?dmdLVjF1aEs1SEZ0RFFjY2hURnhMQVcraGlJTi9Cb1ZpaXVJYkNubmNueWJZ?=
 =?utf-8?B?WEZySjJ3aDFBTzFRdUdJdlJFTmNvMUo3cUlDaGplSXVFWHBzYzZSZFhVVk5J?=
 =?utf-8?B?TnhiQlNHaENtY3g1WFZuMlp1UmI1cTZ1bmY5cEtkc1ZKRi9EeCs3UUNobWMz?=
 =?utf-8?B?dm9TaUpWRkdMaXFlek05dHBVRmNTWlRCeTFnTnYxZ2dyWVZMZUVlWmVUUjlX?=
 =?utf-8?B?WFVkZnhHcHRzeXJ4V0d3V2l4aVhMK09IcWFGVjg3dnBVVWxidE9aQ1daOFFP?=
 =?utf-8?B?QzVNR2J4RXBtNEZqOXRwWFh5bjVhUTNmOHlueEVLSWU4cnFVNCtZNUViSFFi?=
 =?utf-8?B?NkxFd0dYc3kvWmE5KzBIS2k5S0pldm8rK2tHc0dMWEp2WEUwN1hOY2g3dTl5?=
 =?utf-8?B?dkRlcU5LWXo1ZDUzclBtNkxaOTBXRC9qRTZuOXk0bFNveEFYNDZtcXRQd3BX?=
 =?utf-8?B?Wk9jcThDb01mN0p5eTJzS2pXeWs2NWdZdDJ4YlFZK0FNVlU3ZDlHb1N3OVM2?=
 =?utf-8?B?eDJ6TEhMT2pVUm4yNlVuRzVpRjlKV1o0S1hUenRyV2JnNm5XaUR6SE5CZzZI?=
 =?utf-8?B?TDZhVysxdXU3R1JQdEpCZnFtZlhrUmp2aUhIdFM1UTM4SVBwTlIvTHlCSEhr?=
 =?utf-8?B?aWEvYjlUQ1ZVWDVCay9kd3N3Njk5OXBXRkpCbTdrWlAyK3QvanVURHpic3ls?=
 =?utf-8?B?Zk91NFlHU0FuR0JJM1NnL1VQTkY3M2NIM2tRNXpZR0RYTUQzdzZiQnJOUE1l?=
 =?utf-8?B?SEVMS3FUcXAwNkQwQ1ZZaG8zWGJKOEN2YjNrdTBKL3k2cEFVK2NLdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: efd90c59-aa3b-42f1-1250-08dec898a4d3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:38:26.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceLR4HtpxOpVMnADfu+qMnnqDYJKbfnEwKc6rURlw38ibRMMTof3B2n0/kfZsLMLVi31gaLUutWlyjL2xfdv7OJRK7tR3owYei0spDSMoc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8180

Hi Jakob,

On 6/9/26 10:17 AM, Jakob Unterwurzacher wrote:
> From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> 
> Technically, the reset signal is active low - it's called RST_n after all.
> 
> But it is ignored completely unless RST_n_FUNCTION=1 (byte 162 in extcsd)
> is set in the emmc. It is 0 per default.
> 
> For emmcs that have RST_n_FUNCTION=1 we failed like this:
> 
> 	[    3.074480] mmc1: Failed to initialize a non-removable card
> 
> With this change they work normally.
> 
> Cc: stable@vger.kernel.org
> Fixes: bb510ddc9d3e ("arm64: dts: rockchip: add px30-cobra base dtsi and board variants")

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
