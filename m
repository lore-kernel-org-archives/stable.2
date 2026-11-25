Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601766;
	b=16u/ol4dUyIeVWbhNAj+74k3fb6HJytF+7WoY6tCR3Kxz6dCWesiW+Td5SmMxNSy4M8e
	 Uqr/NK+mBPHd/gIMVLkOXGIGaZNstRbujKgAAgZyiHlwDqvpepM1c0v46lfEnEo+Iedbp
	 pqnObWWazBPB1kcLt89XU4pSBuhlKqARy6PthUL5OHLNcqZGczQohGLhbZtOBvCxT797r
	 eCmiSWtRjN7vDkDODp+O1nl/iV103w5bpclLX/lDwaK2/QDnzx24vKzMDGr+//mLDNkD8
	 fhCpIuT+j+tPtWAf2em9FGu7vPhANTkjl+6Ff42HS6teehj27lQPP+y3exh5fulNG9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601766;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=8hqibYh/g6E67vpD3DM/hceeU3qTFoSGKDTGH8gSBNM=;
	b=xjOqpZEayjexFNT69f5nhMkDRiWwqUlC47OQEesGfnSRUPMBlGF8sN9ZnrugP5cbigoC
	 NPXg97ilTXBAgBy7V/6iMb1+EKWZ9B+BcPFA/lR2tcLekZ1K1YuOFYRyYdH+wVc09HQYR
	 1V80edx6OSe7jsPJ/yff/HIZGhyU0vsrHlAdl+8iBr65/zcyqCJc8RP4vxn2nlXARNsyF
	 E/nXSse3IWuBGeMbNxpilIo0jtO3d8Ts+2oVdlbMgMvslNx8xcGk7VNrTHd8sjuUDjmuA
	 uwcFQyTW1q4KnO3+Uxc6vqnQUUIcgzY5mmqZb49kCbT0Tn7q7le7/yElKUhcl/xtg2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=o+dgep5b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.3
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E78606A327;
	Wed, 25 Nov 2026 10:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E78606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=o+dgep5b
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWeOn7rILS377PT6qsn7CgfUW9/ysxBbkxqbqDBjLhT7GyhWOlk16zUrr9IPxKZwg9/yGnm8RR1l+R8Qy1P+pZn4MEEFzklNtXYk07Q0F1/vGjd6Rhk1xaZnAImKktB6ftKTG5YpJOZa+LYv2rvBJ2pH3TUEgjr/3hdkYUvjAycyzXubS78/5RnWUDB2SHUBZvMFQKzlB4rWYrqzEbMicTtjRKHDPA00wQFoXd7+2jFJP8yqT6zCLGk69Huaxy2ktvOF/D2ki8ASyODvNYeSsOpckrIaGhohCBfcVyJ+vHXvHvxqKaDJK8ujJagZZoR8xMnwz/GIWJj7165N6J1ThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hqibYh/g6E67vpD3DM/hceeU3qTFoSGKDTGH8gSBNM=;
 b=QKVgCQSnnkjAMTnr5GR1ck+NaJZDRFFNsyjK0G1dkqXMGCZ41K1ubafLhTGeEPMn6Jy9gnlXC1o2JIvgjnIJMUXzRDPwtZkUNUSuu0Jepu1XSOfa7T5O85DxEGTZEUbs45VLgOKMV4rVDxBxbeBxA7cw80SDBpZQAVU+QiZh6NmbOTWFd1BNFvnOwdENaFjWtInVu75xBdU+u99xUlL5lNNGo0UPLMkYCUAVTu6jcAwuPQ7YMHLQw0y4O9vfJUzUG4xoCKzC5dQ0KHCnkLFWoBqgvoF0JH0nvhpvhdL9xMU0lUhTDH6iXbWkpfq+SXZrXxtR+BWmF8nmMwLoiQD7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hqibYh/g6E67vpD3DM/hceeU3qTFoSGKDTGH8gSBNM=;
 b=o+dgep5bOrgDxQhKq97aVL+L6VktyCCSWtomVSnHOPhz/9Cn6m7dUOMWhylYs3Mdv8Gc15cHPd7CdwE3dDkgL0GlQLW48OW9/Ci/iqheFFesVoByqUKIJZNYMO/aXtXKZjpCGyjFABaRP1kfvv5i4fc9BZp5qWo90TfDBTweMXQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY4PR01MB15109.jpnprd01.prod.outlook.com (2603:1096:405:283::5)
 by TY7PR01MB13826.jpnprd01.prod.outlook.com (2603:1096:405:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:15:57 +0000
Received: from TY4PR01MB15109.jpnprd01.prod.outlook.com
 ([fe80::eaac:e6c3:ef79:e511]) by TY4PR01MB15109.jpnprd01.prod.outlook.com
 ([fe80::eaac:e6c3:ef79:e511%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 10:15:57 +0000
Message-ID: <a394e1f4-1a4e-4dda-a39a-5ae7322dc849@renesas.com>
Date: Wed, 25 Nov 2026 10:15:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c: renesas: Fix MDYAD(x) field length
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-v1-1-2250225e6d20@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::8) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
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
X-MS-TrafficTypeDiagnostic: TY4PR01MB15109:EE_|TY7PR01MB13826:EE_
X-MS-Office365-Filtering-Correlation-Id: a8109cfc-51cf-43be-eb25-08df4add186f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261009221227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kzia0ciUKd4Rpyppbeo1YA55a7jWRc1SIGuUCdDP9psh5J4Ps0d9evpkuleVFSXuEW8txZKZ5pDUGO3u+4d8kWUJQ+coZBwNVmOdj2JLH2CfSAs5Bi2dLQgJ2HaUvI3R91R5YrnKC4cZeaOC1u2EsLUnDyfW5pyBN5IDSQ4DHqwvhuKWjCeHVn8oLApP5/Dvn/4+PuTEL7QeRstrIu1n14/G/y6EQDU/wULtYMqJ6ogTMfW5N3n62hr9pihncusLP8KIBuZsn81YoTWdItz4m9R98WsV9DZ1SOs16eEJrGsUEY6zc+nLcERk/qo2nXcGtxc4eZPrPWo6IorwURHL08tgmKTLQozBO/sFVYjBOvnkKvmeBhNjGz8V+NLU81RAbwO1EBuYl9x7U9M0qdOZ0XNaIC7Ospjh4/tDUCf8TQRPbSFWpwRZp8JgiCzMFf2hY8/agPqN/e7kU8aVdGITqfnB6fRk3QkgBI/+nUH/8M/5zZvmiLTUsZTLC4ykhMv5mb9kF0cu+gSNciep6zkwoudHv0+ce1U6ljWaQhCqMW5K6BPOhLXJUe5rz4QVMhwLpkou34/pxWCz4filS+fJroYDAdB4vtT+6n3sZL7A+rERk4keKeI2Cc3IO7eeOhHGekwMU/hc5MMYZAMzGev+2YoO2zm/5IL8LaVn2py+/SQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY4PR01MB15109.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytDWWt2UkZ4NmdxUzlIeEd4dWpFN3VEcEdwQS9xVG9lelNSQnRVTnN1RHpX?=
 =?utf-8?B?Q2dFc2s0VmVKalBucEo2SkpHSkFLVG5ZWEd0SCtETmptNCs0alVlMHdCZjhM?=
 =?utf-8?B?cGxlb25FeHJtTTJwVG5aVmpvcW82ZU1tdHhRdlZNL0tRN2tkbEhiRFJ0ay9O?=
 =?utf-8?B?UGVYOXl0RTBKaGdMSmlwZzliTnRQUXU5azNEVDVxMy85dG5jZE1xN1lCQlll?=
 =?utf-8?B?Y0R0dGM5am9TeFRzVFlZOEE2MUJsTHRhb2ZtbFA0d3Y4eVZGWnovUzZGRVpp?=
 =?utf-8?B?bGh0NUtFdXA3MWdjUUpNM1VPRUlkdElnT3J6UDJCMTFSZFB2OXFCQWhCL2F5?=
 =?utf-8?B?L1NLdU5wVXpnenBjcmptbmdDM1RzYW80amZ3WFprMzZuL1dWSjNWZno4Zk5P?=
 =?utf-8?B?Q2ZLZUt4QzZqWTYycmdSMTdSZ3JoTm9NblRzUUcxb2dwbnJneFdPQUQ2bWpa?=
 =?utf-8?B?Q2tkaW5rRVEyMnlsUll0d1FIYkhwZnVGbFUxQXlPbmZQcmVwd1dxTGNFMHlj?=
 =?utf-8?B?Qm1sZWljS25Jc1lLMHl2MCtFa1JRcGU0a2hoV2pialRqUE1rcjJDY0QyNTZ3?=
 =?utf-8?B?UXhpeDhZZXhLNm92T1N6ZUZIaDZpYllhTGFwQXJabU9wMzAwa2tGeGEyL2gv?=
 =?utf-8?B?b2JldVhDK1hwUGpoZE9QR0orMGVlakhBVFI0aE1DMlF2QzY3RkcvNWd6TjFF?=
 =?utf-8?B?WjdSZUwrT1dmMkxhaFpsTUQ2NU1UZ1VzalNSK1JOaGF3eGQ4ajRFaDVOYkQ4?=
 =?utf-8?B?TmgrbklFUVZzZDBjdXR3M0d0dU11Rm10UVgyaG1kSC8wa2o2NWd1RUpSaXF0?=
 =?utf-8?B?cUh0K00zb3JpK3BJNmh2SkI4eFlYWlk1Q25QS3pxak1ueThJZW9JUkZDc2Jv?=
 =?utf-8?B?VEZLVWdHcmtkYzF2cEYza0NXdUIxNGdzM3JOcHdoNktzVWpyMjViUFJWOGZi?=
 =?utf-8?B?TTlQSlZ5ejVsajI5ckhYRFNQOFQvYWdFRHRORmlNQ3ByNnBKTlRZcnQwL01I?=
 =?utf-8?B?TE95TjB0c3NaVWlhcFVBYlMxMWtRRy9VbEtRTFVxZ0NyRHJ5VTJ3ditxcXJ6?=
 =?utf-8?B?R3YrQUtiOUZNVldMU2laU0kzK3dGaTZnMnc5UXU4OUNTVEJINU1ZalRPdmZD?=
 =?utf-8?B?YmpYbFhrVmhiUnZ6NUZZYi8zRFFjRGd4eldJZk5vaExlUDQ5SElVOCtSVU1U?=
 =?utf-8?B?TDA5YXdMQk5USVRUWllPMk1ZRDBaUWlkbVdNNllJRlBPWlRqTURvam5jVzRp?=
 =?utf-8?B?eWx4ZWtuazM1STJsL2JxNUo4NTVMUDRlRzBhaFBKNWtaNk1wc1Vua2JiSnp3?=
 =?utf-8?B?RVk1d2lnd2l4ZU9zakRWR3ViemtNUG9GaU5jU3g4OW5nNnNrTlNNQXBRUFhx?=
 =?utf-8?B?bzd3UUlpRFZXT1EvbWszMVRaSWdSQ05VS0duSzdyOVdKN2tiQnh1SytIWTFw?=
 =?utf-8?B?OVQ5RGREMVpwNG1WcHFFUGhYdVdiU05YdVkwd05oNHp0WTRST0dKVzgyY3NE?=
 =?utf-8?B?VzlERVB6YmdYWll6aDJlZUFORmFCWC82V0xzVVpjOWxhQ3VxNk15ekR0dDF6?=
 =?utf-8?B?aTBhUW8wVHRTc0JrQ3ovTVdoR0pPQkdUQXJONGluREM3dlJYeE42ZXROd2g1?=
 =?utf-8?B?V2NSeEJGMzdvaUpXTTVZOFI2aVhWS3hzUnFIUEdNSXNrUEJkOTNHaklucGd6?=
 =?utf-8?B?aEs5MkRTUmVQZFh5VjU4blJVbWp4MTVYK05lZm9LZWlLdDlLbXQyRStvNk9P?=
 =?utf-8?B?aHVZK0Rmd2xIazBGaXVWVHlkZUs3ZVNmalNIWW0za3p1MFVLTUs5djMzd2xP?=
 =?utf-8?B?S1E2ZzN0VjNyOE5Ta2dHSmdsdEQxTUZRc2htZ1dmWGRXT1hsOTgvWjVHenFH?=
 =?utf-8?B?K0pUeFRlSGo1NUwzbERPL2RIcnRMQnB3WDNrcFU2S1h5M2NPSDlVRU4rQXFE?=
 =?utf-8?B?WFM3Z2xYcHNyejM0amZFUFRlcWFLRU9HbFlvK2t3SG5wcGFNZnp6ZXVKN3hT?=
 =?utf-8?B?OFYxUThDckZiU0NrY1M1cUdQanZSSHhmdTg2MWtQdVIzelVMTHliZnQ2ZEov?=
 =?utf-8?B?dE5yamwxd2l1MVBpYTRXbjFnQ1FGQXFBVnVMcktWR3dsd0c0LzBTKzc4RENP?=
 =?utf-8?B?VGo3ZWxaaUw1NGo3QnkyMUZjejZ6ci9rQkpjR1czUCtIVENoaWhoSFBGZU8r?=
 =?utf-8?B?dEU0UlZERExFdlBITVl5SjdrK2dIb3duWm9jdnc0dzJuT3cyVFhwVDdSa0px?=
 =?utf-8?B?anBJcXE5aHNnemRwdmMxWWY2Q2h0WDgrbXpHL1FQWHRsUkcwUm5IdFBkSDRR?=
 =?utf-8?B?dDUvKzZPZ0ZwYm9RSkY3b25jVUc0blFmOGhwS1dCWEJoQXFDdTlMdz09?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8109cfc-51cf-43be-eb25-08df4add186f
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:15:57.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnn5oAqwF+X2Sc6s9rLa9d3z4nzRvm/D3g1wWE84RJGitCpYXUJg4E9o6keyzT10qd8N6m3todlqy9ZoQ937Rw+9k2kSLd9a+rvtikQrVN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13826

Hi all,

On 10/1/2026 4:10 PM, Diogo Ivo wrote:
> Fix the length of the MDYAD(x) macro to be 7 bits as it represents an
> I3C address, which is 7 bits. The length of this field was confirmed on
> the documentation of the RZ/G3{E,L,S} SoCs.
> 
> Fixes: d028219a9f148 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
> ---
>   drivers/i3c/master/renesas-i3c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
> index 28c0927a0179..8b264f72e55c 100644
> --- a/drivers/i3c/master/renesas-i3c.c
> +++ b/drivers/i3c/master/renesas-i3c.c
> @@ -37,7 +37,7 @@
>   #define  BCTL_BUSE		BIT(31)
>   
>   #define MSDVAD			0x18
> -#define  MSDVAD_MDYAD(x)	FIELD_PREP(GENMASK(21, 16), x)
> +#define  MSDVAD_MDYAD(x)	FIELD_PREP(GENMASK(22, 16), x)
>   #define  MSDVAD_MDYADV		BIT(31)
>   
>   #define RSTCTL			0x20
> 
> ---
> base-commit: 66b734f67a4a0a4c2313afb89033d5ab8b8f7523
> change-id: 20261001-divo-ssgrlpcsrc-2966-i3c_mdyad-0ba701c9add9
> 
> Best regards,
> --
> Diogo Ivo <diogo.ivo.sx@renesas.com>

Gentle ping on this patch.

Thanks,
Diogo
