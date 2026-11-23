Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795420293;
	b=NK1A+An/QT6xb6MopO6x89oE0KdSM76fOHl1z50GZTIwVDrmiGVKFj+ADday/MJbYdDS
	 AGY4sAAqSLx+Ab7nIG82mx81suh/s+pgPUefnmSJPKGXt43z/S7QI+SSIEe6wVK+e2ZK1
	 J3HFPe08J2WUsMUUzR3eGDPbBRDm3iRbm4vNtA6hp+hgLscCxrkg6Ge5pV3zzC/VWKahp
	 4EQZJZPe4v5BqVo7nHvh4hJlk+QjUcTmaBC7082SKa0Y5ezIDy5NNuVWE/TC0BHILF7QW
	 Y4X1Yv10vDPlsiCUDs7Nb2SHv5GhHYfSOKj2YQeDI6iBx7YJ79r6/onUo7haeJFgFCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420293;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:
	 Message-ID:To:Cc:In-Reply-To:References:Date:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lPWDWRH3aCg4NQBP1++l8KXO5+4HENxaSy3szC6X9Yo=;
	b=CPeH2cNMDbLUr/1STJ5ihsNgEZIqlJLw/t6wUoWx+UZ8d0XpwG7uKS9PAfLt3V8vi58e
	 eahjXQl6jgSA/bUUFWu2CZR7ZXEtLdmieBVpEv5VVv7tn7aLAf5LjWkRJAIX/YsiXML6a
	 mA3wddid9pBgTrp3fL3clGw/gLDHDwky/WlXCWET9RZp3GhaT8/Zy/yp0Kt4lpt2ZuSrR
	 XdHNZpsPH72wpRa0TGcYqF/ARoGbA66tWpeNrskDU/kdfyDBjGReqjMt8AJH7WFckLS83
	 ZGxE9QQvsgWiEZWDQnHajSrD4zj/QbEi77UQjxhOpo9+DX4JqX7LM1GrJ/14kuHE/YQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Wq3aExZP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.66.18
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010018.outbound.protection.outlook.com [52.103.66.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2884B606A337;
	Mon, 23 Nov 2026 07:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2884B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Wq3aExZP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWU6p80xRq3p6yAWnZ7nwQarfVYSxnWsprFLDnpA8ZSdmiVvw1bHszeHayMM0PZSkbUI5aZQKr0sxRJFsYqxA0xZkRbNlDaz9QJAOXdal5PmzRLbJve7+AX6blM5o/lbzREaIIcMJvNA/TW1XP7DbAAG1FWeNm8hgljbw9qcMOXE/jvDfQxV/Bnm+RGGdW7/Fe9M/h260xjwBtVFlyLhBWvkgHbHTc24NZNcpWjIDE5tKZm8YxhvNugd2fCc2Y1lOM65uAVtO7Cy1eMZX81RuEfAtMsjdudDufQ6i8WaSOJ8WPbDevBYqqdbtYfgLtPt5aQIVCFcmRDM2XTip8veCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPWDWRH3aCg4NQBP1++l8KXO5+4HENxaSy3szC6X9Yo=;
 b=YUmvI5RHA73oKVCurytJSWGZwDpiFElJDoOgsFRUL6rbcePeeIzNHZE6Jwu2nLXdTT3RS/cDYyS3eEAxqeF/KafbV9e7iDwPIw8S4mqFIZqBTKleo6nSopKAmffmCfm0fB2aQmabe8zAD3IMJFPWcOkrxkaTqa3elK8ZSsJ0NFrkA1yYrrsGVLxKg8IENjqWJO8lXTwRGN9JU3BlJ0okMngVqmecZ+ca23qnmlrHqjHG2U0P+AhwYDY1INa2wUW6owpValzpJ9AzHieF+og5Lqlu3vUDbnIEbOWkjIP/8JqmvEFZPV4UXcV/qLuRhyEnLDMDE1TAArbhDwrNHRn3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPWDWRH3aCg4NQBP1++l8KXO5+4HENxaSy3szC6X9Yo=;
 b=Wq3aExZPk0LRB+G8JCtA9gBrupeuJKKS5/A9xdCmgqhKEzu3ZFQmS6gov9LOZCQSLlHKbOS1EJu1P/+oA85yhUW8nqn+cRUXG+V8/jbdaKd8cEvk56xszsdjYLevWBnBgjpYspR7t2KYVTJLhYEleCREOhTXbgws5RvAq/nEQC/TveTOMqfOPH/Ygd6rw6wFO74tZks5z+wM8E3JMqBFjD6Om4jQXI48jzMw2Il2AhsMFntpM3GeTexWMXNGDUT50ymqHeXNqytWr3GBHcbZal1Ds9TltthNdzz1JLr6pYbEq9gjt7vFFdIr0yfbr4hBCVTYpTpAGuOEihqnMAWMww==
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com (2603:1096:604:1e1::9)
 by TYYPR01MB7712.jpnprd01.prod.outlook.com (2603:1096:400:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 07:51:28 +0000
Received: from OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9]) by OS3PR01MB10251.jpnprd01.prod.outlook.com
 ([fe80::7edc:2a40:7b8f:56f9%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:51:28 +0000
From: "Jiaming Fan" <fan.jiaming@hotmail.com>
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
Message-ID:
 <OS3PR01MB10251C7A76A9ED480E3C497FEE7452@OS3PR01MB10251.jpnprd01.prod.outlook.com>
To: "YanXin Li" <fadouse@pm.me>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"Jason Wang" <jasowangio@gmail.com>, 
	"=?utf-8?Q?Eugenio_P=C3=A9rez?=" <eperezma@redhat.com>, 
	"Linfeng Sun" <linfeng.sun.dev@gmail.com>, 
	"Fang Xieyan" <fangxy@xiaopeng.com>, <kvm@vger.kernel.org>, 
	<virtualization@lists.linux.dev>, <netdev@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
References: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
Date: Mon, 23 Nov 2026 07:51:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To OS3PR01MB10251.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::9)
X-Microsoft-Original-Message-ID:
 <101fcc7e-2e46-49fd-8b39-fd318a05ddc7@milk.local>
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
X-MS-TrafficTypeDiagnostic: OS3PR01MB10251:EE_|TYYPR01MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4e9ade-134a-4368-8e6c-08df49369461
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRHao5rn7FxoTsezuGRCdYrpB3fEYUlndJs16BFRSBTX2nSySHwG/vtuLwjvW8xsGlXvPG+J+awfPuQ5+VuVVYqEQFN0y5EzgWNb9kMFTrxZ9MvWakqVZ1t6oOmTvMgsT31I0IPKFY7KgS2I9MxYYWLxkw890i3mDldSP8wzldVXEFspTv3QBfQn+EbYo9VjLq8MrnqVNvHxI8X3GoVBRPHKdwjrvblFmxVTwcRBssmFR2duwQe1Mye8KoR63NsDvWnHCC/4zsy6Lr3q1pl2VwsxgNKjPCTQr5IFctRnvf0YuqZiSjqkDOfofBpHQER5GGwCIQQ7hxkoo4V0ylDdoFrD1az7i1fH5MeQ72JcC2Osk3ezvIn7pBjPkKXWJpSsKqeJObsEIfsOUZaYf+xwQjTXHyMIEdtEAtu9uSdFZSWfUQm6ZPbmzA+ABEmsfgDuFJye9Bxd/DKamsdgHXoEJ68sV96UmKtZ0MgRJyyKtwqbAZNpH8iwiG/I0NrQEy/q/jkablEx7lMbSuupLqChI7KT8GTQOak7rzFL3AF4sa8L81pYSUUfPgxJTxpJs2KnALJj/2tSfhGnU3krnVZiMnrAtVG1yWQG00tPBGx5lPOmNoGxjw8BBBa0/HiniuXpANMqFnOjrMm8eECeA0jt+uSgv24iWkGBtvdB6pMu9gAOn/IL9k/uTFHHR4I3qFiH5uQuhmm92axcqyq+dgF7eDVWiNZzKtemJ+6dVvN1Q2CkA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|22091999003|24121999003|15080799012|6090799003|5072599009|23021999003|19110799012|55001999006|24021099003|8060799015|25010399006|4140399003|440099028|3412199025|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REJuS3dFTUdUSXRoMmQ5Q3I2NnA2ZDhCK1hEcy94enUwY1ZQZ3hZTFppWGVw?=
 =?utf-8?B?ZWpXTXJ6R1pEVHpiZUhHVUU3MGtDRXNnRkR4RWZGeGo0YmdKOVFFblk4aHhq?=
 =?utf-8?B?U1dhb3hGT3pNL3Z1UVorT0dscmtRbmdmc05RZU16K2lJLzFkRGRyeTJOUmJ0?=
 =?utf-8?B?MW04eHlTajdqVkpZSnlDT2x1SHNjUXYzSHVUcjYrUTFHTStqbE5qak1ITjdv?=
 =?utf-8?B?Q3ArYnB0VWV2RkFCRVFVTDdHVGpHVGhzVUFoVGFwSUc1elJLTGpxUDZqVkdi?=
 =?utf-8?B?T3JQbkVrNVR0N2w0Y01vbXdwZjRkOXVTYU40MFhKMTNBeDV2ZzRCNFpWUDc3?=
 =?utf-8?B?MTdkNHRxVTNUTE14bkV6bmIvK1J1cU8ySVpsU2tNempEUmtDcUE3TzdMM1FK?=
 =?utf-8?B?SE12T05wc1F5SnZSRTQyd1d2Z01kQURpVE5Fek9rS3l1ZFhNM2tXRnc1dW9v?=
 =?utf-8?B?TUt4MHZQaGkvZHMrVnBSUlllTkNKOGYzb1VZdmFaSEpVS2FCQlN1SHc5MjYz?=
 =?utf-8?B?T1M2UFV3WlFBclNxdHFNR1lEQ3d0VDU0MkdiYmg5M1ExRHY0WlFXZGZseWNk?=
 =?utf-8?B?blV3MDAybUFrM3NGWmF6N2M3ais0OWVuU1BIZzN4bjlTRDUySGRDTE9QRkVI?=
 =?utf-8?B?K2JTcTB3NVVxQVZlVENybnVieWtZbnEwSklYTzJWZk1aSndQYysrRFFxM0RB?=
 =?utf-8?B?bnE3SGJtL29WS1UwUjBEeEVQWHRTZ3AySVorT1FyZm5sN2t0WVA3amtFZHd6?=
 =?utf-8?B?TFB5eXl6SkNQT3hTNk1iZm1YSGoyclBscTVLcXlyYlIxbkwwVVBLblBoRTJl?=
 =?utf-8?B?QzBCU3crelFjdms5QWg0QjA2dVFpVUFwd2wybjZnWWtIcytLaWxMQVJVczhi?=
 =?utf-8?B?NkMrcys0M2VXa1ZCcnJydGlFaU10QXJ6RzYzQ1FKbDBBK09yNll0WFl4STJJ?=
 =?utf-8?B?OGVOcXh5TDV2REgzWTZmYXV2TnRudUdqbmRGK2xSQUpYOFJLVVJkTjhCOWJO?=
 =?utf-8?B?eFJvTnRyUTdld2lldzRpOWJyVEYxVlNXZHdOWjZGTkhHWUVtRVJRenBTVGpL?=
 =?utf-8?B?dndJMVRCcDVHMStkNm80SDJvUzJaZlUvb0cxZHB6S0hBRGlxWGZ3NkRpMFpO?=
 =?utf-8?B?Y0Z4cTFnWFpvZk0yRmFKb1p0S1FjaFJEUzhIbldGNHZrSGUrcUdwMEVIV2p3?=
 =?utf-8?B?SHBZempWN1dCN3Z1aWdWWS8zSS9TTG9OdWYyZjFySzZSaFd2SXRwM1RPdHBm?=
 =?utf-8?B?b2d2dm9qTDYyYVE2ZWdYOGovMVFYZUxvTkhuWUMzOExLMWhBUHp4SjBsOTgx?=
 =?utf-8?B?Vi9DUklRU0xGaTl5RHdZZC92anYvSW5aVENoN3ltaTNYdjdtUGVRZnc2WXZO?=
 =?utf-8?B?M0hyTzRWTlNsMHRka1JWSU5oSWtIc3BLd1RsK2hYbEQ3R0ZPVWlJRk1BeEhv?=
 =?utf-8?B?ejc5VFZGOHFuS0xUV09IaHpBSGV0UUJzY0w0VHhESHB1YzNDc1Q5ZVN3ME1P?=
 =?utf-8?Q?RkpIjk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y05GQkltVGgvY0RkNUIrSXZNbWxXcENwR3JmdmdBcmlIYi9GV08ySEhyclQr?=
 =?utf-8?B?WG5vRE5rVjljZ2U0MVZzeGtKY2RkT0MxWDFOYkd6T1p0emZRUTJvdVI4Mnor?=
 =?utf-8?B?VTlrS1JCOEVEUHQrL29ZeUNJci9mR0FmTnpBZktvRlliQ21GeG5UbU9FUk1o?=
 =?utf-8?B?SURUN0dpS25mN2c3cHJZOTQvaHZqWFRINS8yTlhKLzNnb1dFbkRKbC9kbzlE?=
 =?utf-8?B?ZnpKRlFjVUpCZ1FmSFpEQ2JIK2VGaUpuMEtRWHFkaHkxSEJubWhEQXJRVzYz?=
 =?utf-8?B?dStPS3JnYmJhSFlVNCtYZ3loOU5sTi9RRzVvVkl6cURvdWtNZzhKMWd2aE9Q?=
 =?utf-8?B?Vi9kRnRrekQxN3ZhSVErWW9zUjVBdXgvZlZJWkxkek93Vnk1OWdXc2lKN1FN?=
 =?utf-8?B?NDZjWTFFQ1BVUmtWei8wOFM3ZTRDZkVhUmI0VmJORU9aUWh0RFdkaFVIOUxa?=
 =?utf-8?B?eUpFay9vbFU3V08rYlN0UkE3VTlCSUpVejZVaUhRdERhVzBhZkljTEpiMG5u?=
 =?utf-8?B?Q2I2am4wSUtQTktTckNXalRoaW9OcWE0RXpRa1RZWTN3RktqQXJwd1NZNVRM?=
 =?utf-8?B?Unpoekh4N2hNT1FqcEdhSTJYc0JpTk93T3ZRazluQk00MXFKTlpkUVpNdFRK?=
 =?utf-8?B?WGlpbWwzQWhPS0ZFWGpkRzg3SnpRdG13c2VpMGpabk5nODIyeGlKdHY1aWpH?=
 =?utf-8?B?SVJMbHhPcGZOTEFEY29RRHpyTHBKT1RoZzJnRDRzOFJMTjVsaXNxMktLdUZ3?=
 =?utf-8?B?V0FtUVRQZHFwQ0M4ZlR2K1ViQUJFZlMvQjIxVWtPK00xYjZNWDJPeWVLZzI3?=
 =?utf-8?B?NjBkYVlURzlBTzVnWncyT2FOb1ZCUWNqWk54NXNHK245MytJaHpDVjhJQmdh?=
 =?utf-8?B?NkJrNWRUM2d1YnIzYWdPTmJOZDJmbmVuRkxwOWxwSDU5QWJvZ3VQR2dPVy9J?=
 =?utf-8?B?QngwdVpIUkRVMTlQL2o1N1NkVzZuQy9Wby9ubERjVmdKVjN2TGNTM2ptOWhQ?=
 =?utf-8?B?b3NaTkYxa1lVbW5sNDB6c1ZPZzVYdHRnMGJIRVk1T0VJdjBEZmJzbjNkMC9O?=
 =?utf-8?B?TzczVEsxZTIyV2g5aXBLZ0lxeHZPeVBnTHpKUGN3SHltNWFCTVUyYTJZQW13?=
 =?utf-8?B?cTBvWGc3dUY5dG5KalZldnFCY2dSZzFMMTc4d0hjTitqRG9GTCtBS0V0VkJH?=
 =?utf-8?B?dVc1WnFBY20rcWxMVGR3YU9qUkx3MmtZV0psT0RIRWJKTUVPblpUT1hCa0xm?=
 =?utf-8?B?NXlJOTFZQ3k2ajZ3MmNHY0llTmViNlgzbUdtSUhsakRhM0xXREg1RjlDU0Yw?=
 =?utf-8?B?UE9valVFS2hjMmZFNURCSUFoWVpKS2dDWVZMMnVmQWptVWxmblVJY09sWkVs?=
 =?utf-8?B?clpocEtjTVpnelNPcXFDMTUzcUYzeUtSVUN5eEdFa0FWWnR3L0pCZkJSQy9p?=
 =?utf-8?B?Q0lZNi9IUVF0QlAyNGdTVEp3MFIrYnBtWWdFLytONForVzUyYTdNOG1CbVRm?=
 =?utf-8?B?ZWZzUmlIdllMN1VRWGp0ZWRGQ1RLaHlHbkdnRUw4bUY2TUR6ZWlwZFkzSm5F?=
 =?utf-8?B?RGpkNmV1WFJEU3Jpcjl1a3ZKKzNKTVZZK0NvMHN0VVhmY0J5UFA0WkszVWlv?=
 =?utf-8?B?ZnlmYVFtZ05xcWdEUHNycGxleGtIbWRxUElVckNldnRQTGJVYjZVdGtzd3Q5?=
 =?utf-8?B?N3EveWdVdmVNeHdlV3ZGa1UySEthTnN1Mk8rd1Y3Qjl3c1o0R0IyK0lweEFr?=
 =?utf-8?B?Q2d2MVluMVczVVhsakNEYjBzWGlUYkdSbis2VVlTeEZNbGFILzNKZUVEZGFY?=
 =?utf-8?B?UkJMMlE0RUxlTGtsdzQ3eUczZ0FseGwrYmZJTnBHdzJHbnpWUU1NUGx3YXVv?=
 =?utf-8?Q?NgHQQpEd7q9Up?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4e9ade-134a-4368-8e6c-08df49369461
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10251.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:51:27.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7712

> If the guest refills the available ring while get_rx_bufs() collects
> one mergeable-RX packet, that packet can consume more heads than
> vq->num.

The mask looks right to me. What I don't follow is how `nheads[0]`
gets to 64 on a 32-entry queue. Those buffers haven't been returned to
the driver yet, so what can it put back on the ring? Can this happen
with a conforming driver, or does the test guest reuse descriptors
that are still in flight?

Could you share the RX test program you used?

Thanks,
Jiaming Fan

