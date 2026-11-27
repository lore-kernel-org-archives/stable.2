Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795747406;
	b=A3MNfhJ2nx648S3Lx1vxhl9kUf8eGjaSvEKSnUhLPY/nszuMGABsGL2Q8zRuNQu2qjO+
	 aLVg4/vDzK1TxmKbok58aQT5QcareQX/7pWUTcdQu8WklvUCIlLBoj9/9SynF+CDipoME
	 2xDbeTbpEPEuMaWEfxr6quQUPvyUTNsbLzPmvm7JmrfUOKsldD65gQUz/tjgNt6NXrt6j
	 7vkQkRTYaNXy+PbV4F6L7Z8gEl2PE9IxWjaYEyy9xvIAKCXkVY0Ur50qYwZOZKgFr06cH
	 N0NEoNNKm1CkU4P0RdkOGYI3QWZeIPdV2CU5uF1XpZMk6Jh+hSzwdF3uV7QC8nOQGZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747406;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
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
	bh=uCPzGimMjvfdmMVUNlNum178zWJ7xEVDIet5PXiJQ+4=;
	b=kPVDz2h0zuuWF/v7mgD9jMYPX+CBA79KcRpKsIkpTFU+eEokAsiU640KTCU62qBfh+ly
	 uJDNARvH4q3jcp8WJgfWj12wAdnf/RrIKHhy7rLBK4vch2xMgmO+gz7T++ftQSVtUyJzq
	 negR5nzL8UD+xTRAxmH1FxJeGlp/CKwn18fqXPfJr4Xe65IdVANdD7ZI6aYdoeinp2mIe
	 AQg45F191rKm+nvTd/1oQl63IK9vZuzcSemnSk7x8uO7kCOSbM6UpIVpBaI801882oSme
	 e31y+p0BK1iCafYDBHHkYpIPF6tyHBZ26Mijpzfg0zfXPZ2LZCQC8JPuEUp/QzcmlZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m4MIkMnx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.49
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53143606A321;
	Fri, 27 Nov 2026 02:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53143606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=m4MIkMnx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHFOPm6+XwMhgXxRI8K8IT5y+xYNY4HZ1Qk3ELxuGgXMhj6v21phyerrh25lFNwrPvb+m63NoJCW5trnumqafa1AJoBuEkYRuIFZugzc2DDDhEhjfNrVVtbDRE0f/8f/DG7NU0Vxt9PKt8zSBqAjwCbtk0xjI+ragE7HU0dSAchqbVi8HwcCeXKERYRgdE3B5H4X28Q5WgkBH9/GeBaCP7lJkyNYwqLHY8NtyAkS0q6PQrxtFxK4hSYDZxv5mjzoEnZpnDEcL1BkyR/TiJRa5wSSj33nJV7VjJ+1Fa9clSepzOW6sKBkW19ni4GwNYGSYXcqzX8zIWh+GWYFXmS9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCPzGimMjvfdmMVUNlNum178zWJ7xEVDIet5PXiJQ+4=;
 b=L7pizEbcH7TEU/YyI48CEkfo9GwnI+d7CA4rD0dmzu2pH+ow3e5K0i7yh3bQVY0kcQy4dwz148wVzYX8UBZms7nCHQv3vwtTLNl5MKM7mfdnyO4gFZ6t/0gq2vkc95VodB3nOnBoT/MGlW6Qyo+dsM00q/0qoHSffIgRz64fTJL4DRfCLdpx6HxB4wMSSksNA7706wQjFiYEsLgazUikW0Edm29Ez9yxwJAcyqb5yECYGTSQfb6LW2uOx6SZVp3/eWphd8c7nEdghfmj2YLWwUBv6GmcoTNpdrLbNUWhOp6g72hRFf8VfhV58FvvXDQhlNd/lNWyBrPFoiscz4I+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCPzGimMjvfdmMVUNlNum178zWJ7xEVDIet5PXiJQ+4=;
 b=m4MIkMnx+oGgQeotdx7fsSSoY+ULAz0NzXRfA6snC65AqkcE9NJ6Pk5x1UhkHrNp34aHLxcj0SSeLauU0mgd3rqC7//VUd98uZwRl0sO+U1I/SumVk/AO+GHBacU5kmPs8cVONPnxZF1aNGuLsBNu5EXwAh+kFTg5AttqtReLTVHLjM827FGgVv7xvyWLXJETX07Grmpf6uVGsF+eR3hwaN8CokQl5aj080VaKI4HmqlaYJ3GUsxkKhNfSDUjXzSZZAyQC9ewESU73cOC24ve1xwLsOAtifPJ0xRwhsb+tFkuCjpHI53F0c+DwZwOcGvRs+opL8Lk6uCqVCBvnSgDg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by MI7PR04MB109212.eurprd04.prod.outlook.com (2603:10a6:290:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 02:43:23 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 02:43:23 +0000
Message-ID: <7652e6ad-a34c-453b-a461-6105d9c86813@oss.nxp.com>
Date: Fri, 27 Nov 2026 10:43:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: imx93-11x11-frdm: fix ethernet PHY reset
 GPIOs
To: Frank Li <Frank.li@oss.nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, lei.xu@nxp.com, haidong.zheng@nxp.com,
 francesco@valla.it, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Steven Yang <steven.yang@nxp.com>
References: <20261126160835.1811145-1-daniel.baluta@nxp.com>
 <awhiRigXGZ50RoDo@SMW015318>
Content-Language: en-US
From: Joseph Guo <qijian.guo@oss.nxp.com>
In-Reply-To: <awhiRigXGZ50RoDo@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|MI7PR04MB109212:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d60a214-b4ff-4b69-df75-08df4c30347c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|7416014|23010399003|3023799007|4143699003|261009223027099003|18002099003|22082099003|56012099006|10067099003|261102123227099003|261021121427099003|11063799006|261026140227099003|261021123027099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	IX+h9hUygGsOkvEsUQN/aElVJIXabjOdpVbCiYyLU6pa2anDwnEySzm6So/votyX2o2pd8LlIUUL7wKUyUowjV80iqBSnLFz6aGhfRq0JI6qeKXdbVqrNFv1V802Vr33cuvGS8zlPdFbe5tlqjiJoYAHu1x/7jGeBOz2ALhBSIkBOkxAd/vqyTnnfZOCwnVuHJlqBfIgHS42j8cyoOuUPfOtoVw9zaB69WCYks3XKDxBDpPfzcZOTY4hR/gW/nelnY7CD7wg8xFcJH5vKCvv93FJgrf89YMjLuneQrEHiO7ikOKMIlJJ0UstzFQx0KT/BOy8tusgr0z5x0Io4NBZqqHJ+5M4GQyMpsmxYnaWmlutg3Yl7JqKpysa5W+1Cxp4/G0wKVfPh2CffSdZnZo675oA7A9aKOr9oPKm1oaf1RlAgpZny9bUda7Ufi6QGTJOqXB4DB3usxh9KJR9FnReaSIKP7xYgEk6wuvLhgH6u/xfeJ+Ltc2bNUUBKQbO8hbKupnM3lR9Qg9kzt3Qf9NqHHz1QyFe8oH9zW2hT3oCXtP8oljY+eosF4jDzCbhBtS5Czlpwe+KYn60Qv+IR/ZRgovLGtF3JNwa7Wea86BkMuQB/KKzOHbZZGGAS+MINGObeG82o68L/243dpcYN/3qBDa5KbtLZuwCVbqEu05ua28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12117.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(23010399003)(3023799007)(4143699003)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(261102123227099003)(261021121427099003)(11063799006)(261026140227099003)(261021123027099003)(261028144727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1NLcmVGeDVvRTJBa1BYbkRMRmhOV1d2NndibU9wRnJEd3F3bUdHOXpKQ1pL?=
 =?utf-8?B?eFU0SktPR0xrelp0RVVsRktpRWxIQThIVXhvVk9SbzFNSVUwKzJnQkxxYVQ3?=
 =?utf-8?B?Vk5RUjYxbjV1cmpvWldXNmkxanZ2WkVlS3MxTDRQazQreXFkTVRGMVZzMW13?=
 =?utf-8?B?UW5QVjVTTXlQNFJNRHdKM0hOTmpJbnJ5ZFFTeDhrTVIxUHJkSEVJSE1vRC8r?=
 =?utf-8?B?K2ltTmVHeTRxbUJyTlJzaUppYjBPbDdKdnVMY0RPZjVOQmkwUTVMT3UyTzh6?=
 =?utf-8?B?QlFHcGM3VnRmejBHZWtyM24vTitPQVBIcVZhZ2t0ckxxN09ZcmRlWHdlN0Zj?=
 =?utf-8?B?UHNwcWVwQ3ZuSzZucDRHZmlBWno5VHRhVHFGRitSNUZXcWp2VjduNUZqQTBP?=
 =?utf-8?B?amhxSHgvTElielVIdUE3MkxvaENvbnJDL3RlU2pnUFlFZlNNNmJURFhMM3d6?=
 =?utf-8?B?d1JadFAzb2JZQ0diREJhelJaU20wb2dRVC9Pemk1TDM2K0JmbWhMZ2hPanhJ?=
 =?utf-8?B?ZkJ3bFl2U2NXL255QnM3YWdTTkJiWFRscytuRk1lMjNaMzRWaHdYV2hXVjFS?=
 =?utf-8?B?ZXd6RVAzREZSdUI4c1Q1WVdsU0FDTzhrVkRHRW8xTUkyWU5kSk9HaEMwQmE0?=
 =?utf-8?B?M2FhVDZmeE9kaGhYR2RzbGxBVHIxU285cTQvZ3BVczhKYUtYdXUrTk9iODBx?=
 =?utf-8?B?UEZMeVQrNFd1OHVLWklWNXhXVVBFNWFER3EvNjVpeFdubmxMR3FsT1NaZ3ls?=
 =?utf-8?B?aHA1anNwRzhLY2gyNlVYb0grT3ZCMEJhNlpjTTlmakVkYmJycXBjS2YrNjh2?=
 =?utf-8?B?dERzNG4xUVZTc3hEK0IyZzNweEFSTmVXVW9aUnppVlB3RWJYU0M0VGJ5N1Rp?=
 =?utf-8?B?aklXUERYYUg2dVhSeFBsN0pOK3ZGbU5wSER6SWhOeWRKVm1hNGtrWTRtR0ZF?=
 =?utf-8?B?L3BveHZyeTRsOFVDVk0rbkw0TlF6SzEyWlRpVWVQV2UxSGFqNGx2a2ZFamFD?=
 =?utf-8?B?aFR3bmdwNllwd0lSNU1IZEJoZ2k2YmRacDUvbzdOSlJWM3hIcjZqVkhtMERO?=
 =?utf-8?B?aVYzMnhmc2IyNXNvaFRCZUw1ZFlabTRQTlZvRG1YNS82bS83SkxtNWZiV3Ay?=
 =?utf-8?B?K0l2Y0xaZE4wNGpoN2h3KzRrZUVjOVNHTUhORTFYZmFTOGlzR1JkSzlqOW1D?=
 =?utf-8?B?YXoybFhnOEdIQUVlTm42ZEtYczdWZHR6OXZQRUZta2Z1SU10RGwwazVmL0I0?=
 =?utf-8?B?OXdhdDhPMGxzN0Y3SWRPSHNzRHVROElDNVY0N09UUlJnUEcvejREdDRudERk?=
 =?utf-8?B?b0ZvY3hSeENSNnJBRG1mRFRqanhaWHdtcEhlYXljOU5YS0FTOTlyVlNwZ05K?=
 =?utf-8?B?bDE0MjBzd0JuMzE0K1FaeG5LNi9qUzc1MVkybmJpZ2F2dnUvSzdGZ2doODVI?=
 =?utf-8?B?ejg2cFhRaEV4TG92RVF6SGMzM2FrMlVDcWRzVVduSnRGcTJ4UWFhbTNzYWs1?=
 =?utf-8?B?cmtoMmpweEVuQVRsM3JwSklwYThTd09rWHBMTWNqVWQrZXVFSHRSQUwwUFZX?=
 =?utf-8?B?ejNBY0poODNSb1U0OE1HdENGekVrOGI3RWovSkRRcmJlRXNqZGorQW8za21S?=
 =?utf-8?B?VXdWR2p1Zys3Ym8xMk9LUmMwQjI2bVF6akcxcy9sZHJ1V2c4UmlYVmdDbE1n?=
 =?utf-8?B?bUk2cHoxNkRGWGRNQVQxNEJyOWR1aUFYWGJuWFFoeGpybzl0K2dHNDVWVEZL?=
 =?utf-8?B?VzMwc0NvZHBJaElVRm5pTmdsaFNScTEwNEMxeUoxcnRpUHdOajEwSUF5bk5w?=
 =?utf-8?B?aTZoQVRQVlI5M1JoaFdEcDFlNDA2dU1keEJOWGdlZWsxcHhWTm1XWnBKRVNT?=
 =?utf-8?B?SUt3RGVzaU5UTDk0Mi85WGhDK0ZUdW1ZcHNLTlBvTytwV05BMmpXRU1LOENL?=
 =?utf-8?B?YkJVVWE2bnNwQjE4dng5cys1WTd4TE41MUw2aWg0eFV3WUdpR3JoM09Rcjl1?=
 =?utf-8?B?MVZLeWl0S1I2b0dVQ1dYejdza0d5eDg4VjQ3MTcyenBUVlFodzY2ZktOZVNF?=
 =?utf-8?B?RTdXVUErRWpCK25za2NqUmp4azk5N3VhRHJvUE1ZbDR3dWNETnhhc3ZCd21j?=
 =?utf-8?B?dVdNdXlDcGtmTHR2WUFic1RPNkdnM0s4ZWRpTmZIOEd2NDRDNUhtZmwvUGx1?=
 =?utf-8?B?NWFEaXV6c2lyUW4xVkl2SVVuM2tROUh3aHJtM0lGQStRWnk2alJkVzFINzdF?=
 =?utf-8?B?dTU0aERXWXB5bjY0RDdvUXBhNnNmaVlxaUpyQ0pqMEFRVWtBeDJTaTNpYzZh?=
 =?utf-8?B?RlEvWXhEQmpTZnFTR0RSMkNWL1ByNUNoSExad1Q1dGFLdXlSd1NxZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d60a214-b4ff-4b69-df75-08df4c30347c
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:43:23.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIFv03uTi0gHL3vgiu/9O5w/paf5XP+5NKbvLJlk5eDYdXP8CkDLZ2U78GK6BxzIEDv2PNZZuSj3qopYvZS3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB109212



On 11/27/2026 12:45 AM, Frank Li wrote:
> On Thu, Nov 26, 2026 at 06:08:34PM +0200, Daniel Baluta wrote:
>> From: Steven Yang <steven.yang@nxp.com>
>>
>> The reset-gpios of both ethernet PHYs point to the PHY interrupt lines
>> instead of the PHY reset lines.
>>
>> On the FRDM-IMX93 board (schematic SPF-94611 rev B2), the PCAL6524 GPIO
>> expander lines going to each PHY are labelled:
>>
>>    P0_4 (line 4)  ENET1_nINT
>>    P1_1 (line 9)  ENET2_nINT
>>    P1_7 (line 15) ENET1_nRST
>>    P2_0 (line 16) ENET2_nRST
> 
> schematic error? Should fix schematic also?
> 
> Frank
> 

The rev B3 schematic already fix it.

Regards,
Joseph

---
Sorry my email client setting revert to default and it contains HTML in 
last reply.
>>
>> However, on the PHY side the nRST and nINT nets are swapped, so:
>>
>>    ENET1_nINT (line 4)  -> ENET1 PHY RESET_N
>>    ENET1_nRST (line 15) -> ENET1 PHY INT_N
>>    ENET2_nINT (line 9)  -> ENET2 PHY RESET_N
>>    ENET2_nRST (line 16) -> ENET2 PHY INT_N
>>
>> The device tree followed the expander-side net names and uses lines 15
>> and 16 as reset-gpios. As a result, the PHY reset sequence toggles the
>> INT_N pins, while the real RESET_N pins stay deasserted by their
>> pull-ups and the PHYs are never reset by software.
>>
>> Use lines 4 and 9, which are connected to the PHY RESET_N pins.
>>
>> Fixes: eb2f28413e23 ("arm64: dts: freescale: add support for NXP i.MX93 FRDM")
>> Signed-off-by: Steven Yang <steven.yang@nxp.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi
>> index 33ed26aafde88..8c7b08894bc0d 100644
>> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi
>> @@ -145,7 +145,7 @@ ethphy1: ethernet-phy@1 {
>>   			reg = <1>;
>>   			reset-assert-us = <10000>;
>>   			reset-deassert-us = <80000>;
>> -			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
>> +			reset-gpios = <&pcal6524 4 GPIO_ACTIVE_LOW>;
>>   			realtek,clkout-disable;
>>   		};
>>   	};
>> @@ -169,7 +169,7 @@ ethphy2: ethernet-phy@2 {
>>   			reg = <2>;
>>   			reset-assert-us = <10000>;
>>   			reset-deassert-us = <80000>;
>> -			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
>> +			reset-gpios = <&pcal6524 9 GPIO_ACTIVE_LOW>;
>>   			realtek,clkout-disable;
>>   		};
>>   	};
>> --
>> 2.45.2
>>
>>
> 

