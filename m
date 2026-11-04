Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793779132;
	b=IeHkQ012mAxIZfqivIiyMxj93UXc7QPY0T1QkFm7ZFl2gcSXXJQjgoziHj9xJV1vX0ql
	 x4+4/tZkRtc2zFpomj4kuDQE0l0O6dVdX0P9C32WIno1A8LNj/eHW5k1L7R4ca2Zu49mP
	 LktTGTf4/++OdYcc/ihWswgVwkMJjN3BMc5GLVobwYFw9rQm03MlriI3micakAnsvxo25
	 vRkcVX1YPuq8WoAOEG9sVtw+K+1FtitlZXsuX9/PZo3501eZZSrQAlaIr4FcJq7r6gNaP
	 HXkrHczTeB3KLanZEDLgFsczLoPxWAX/RtOrvxloo3DsjTCebVG4TNo0IlW8PhZyAtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779132;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=rzbAzjDeu1zo3YSPX3OluEXxbWNGnH1U4aROax8eG/s=;
	b=DuY8Tauq8A5wFI6lYLvk5Z/mzgKEM++M7a/0GPIVtGAYvYFEt1XkfwI6ouEfgLs04QK/
	 blFec13Jn/lETFVcHaNex4dyFx5imxRSy9HU3kS/AWxPxl2rj6axqatbVxCKWs0soswnF
	 dFmQ8d10Za+wW66G0JAI8jIMO8ItjQncBZ5N6rtMad5eYX5YqfQDovd4ooV47I4zTH0kj
	 TBHD5nSTf7qNFroKTyNAz4eKb2P2Ua7Fv6yLImbFBCK41Zs/X3EnPC7bA+AtckwuOzIOc
	 QdHftKmJKoOK9vR1UNQhsbE0BsU9lh/9LkOcJH6AK2G2QtchoZF28pCxDPfI5heQJQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=migR1ePj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.112
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023112.outbound.protection.outlook.com [40.107.159.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCCB606A31B;
	Wed,  4 Nov 2026 07:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DCCB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=migR1ePj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe7CEFm7jwJ8IHvdIaEmPA4xxftoYpul6jeg9zxme/K7trDEdo4ycKhHmVhiLWCCUNpThI8tEPrSpIPtqDX3H6nEWnKJfqlFNZInfYExINBYYnV2geYvTFFT5Y6furpXxDZd61kZGTPBTRJUgonj6uqrWsoyK0PB5/g/0xRah3c/Qh299i1pqCok5GzmpmFzkZJubZ9+nMP0gqM5m92jiISDJjj2sNR14LtwfsME2NjIsGIo9cL1Ext4dqijn7RrRXTAPiOHYhWGPg2wofQnjjJJJwHU/FHzOb7XzVv/d032D68fxdNvOxPJDGHJO3SefJsDmds6QLuboJyh3Bf1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzbAzjDeu1zo3YSPX3OluEXxbWNGnH1U4aROax8eG/s=;
 b=JWYxHeqGfashwr9d6lMHsTn2mhKuypxKEGcryhFcQHOv2CGI/Vwxt3Kfm3TL5tvmNF8VqTWbVX6HGkzi4i1R5xLUBI6UZHChtmyWYJQIhBcyZ2NWa8iCXVEkagY+5WXPg/ShLrySkJRHjHpXHSPJOrKmOPahJDnB1U/730fogC0NtQXKIF1G9RD1Y70Nd87hlZKtGkogKgzCJdO2RexLvXMiSHHayICfhvYb0lGYwj7+usNFvjyExOd99CUlwRy+f+AWy2k5TgIWerr99It84RqdvMRw4tMetaf14HtRpP8b4T55aMwD/9O3GLFs6onCJsiznkF5xze/Z92p0VzsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzbAzjDeu1zo3YSPX3OluEXxbWNGnH1U4aROax8eG/s=;
 b=migR1ePj/JvdKaTTfj8pANAtrqH5m3HqsP+9FOGfFdR9Ooue4oRSzZ+kJq1ai5NuarjSpimUJ1WIh3YsuzMfcs7YnhX/awVZoSMT8K5h5+WlMzq1Mgs3/CFHPbHuw6f87MYJ8rHDRr+hDIfKzTvYu9G8RP3d+6OxFYDv2w9RE6BtymqDg23FgsWjdOEPD65DsDZVbXJgM4xGyNshXGP2WGEacIa1Qi0jU+AeY6ZFxinp3Hvwe3gzk2d8G+QPgGKmI5bS6TRRClkt9+OP+dZhoLlb8iGN/FjlsRcxhqr3tBq4AbLsxeTLkJT717AlSZJuoZoMcIU8qfLlTz4az6wZYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AM8PR06MB6914.eurprd06.prod.outlook.com (2603:10a6:20b:1d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 07:58:44 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 07:58:44 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 04 Nov 2026 07:58:35 +0000
Subject: [PATCH net] net: dsa: microchip: initialize the IRQ access mutex
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ksz-irq-mutex-init-v1-1-e3bb7d9dbd80@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAKrl6moC/x3MTQqAIBBA4avErBvQAo2uEi36GWuIrNQiCu+et
 PwW773gyTF5qLMXHF3sebMJMs9gmDs7EfKYDIUolJSixMU/yO7A9Qx0I1sOSKYyldJ67IWCFO6
 ODN//tAFLAdoYPy4N8H1pAAAA
X-Change-ID: 20261103-ksz-irq-mutex-init-ef8f8677db06
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristram Ha <Tristram.Ha@microchip.com>, stable@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793779123; l=2254;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=SL6qASyJoAuWXydJJODTB04OPwGfv6tLcsG/sZNVOIw=;
 b=y4GCJgIUm2FmVpVaBSaxeXObl3f0pUAc3/pCNOV/tm5BEhm0792cM6saPenEqiWDiYfVX5x0k
 LSk+iQy/zc1BWxZ+nVk5m4QbaULCKf3qvV9/Ww59S2WMt6XzTm7yrSa
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::34) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AM8PR06MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 66894509-a8d1-4d9e-a276-08df3a49727f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|23010399003|376014|366016|1800799024|6133799003|10067099003|18002099003|11063799006|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261026140227099003|261022115727099003|261026121527099003|261021121427099003|56012099006|261009223027099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	oXCF+mlxZY6c3DvD3W6epNibXFoUW6gcQyWRdnUoI8tRpRPtm0jyaFa0nPaUp2BwMs4NO3Q8FiEf6FDCgVzObB7z7410sttzt229599n543MC33AMHTGaxytq/PT3Sga3iVFGNspEnGvHjwopCVUgKXk184ahIhFfD0EO0avqXWpNl24OUs1WY/jn7mEyEouczKCfORzqueQwR5hGYAraueleXCuJyIkLUmDzvJSfkFolDcWQCiSCtqckHAqy3GtMBw02BjZQCX3OTGE2CXSeWrMtySAbwBSXoaRxkUCQmmgt9lRkjIzlxiYn+5G1TZgVaXMRHSXZuIRiwx8mK0ZbHF8yd/Y5+9sY8M0M9/3RBumzXpaZDRg6xkMrMC2a8jBYOte2Ri2qRLXIw9OTrOU5gCgfS2BycZP3Y+DKX90M88GXQiB0MKQmVeVmQV9kwC97Ykk8vOtoWb1lq2gtcj1ljWG4k+6oOlt7M+S0uSMAcH/M2iiUl7P0Sj4agGlbB1Mqj7BDOcHddFyEnEy2y9vXbtxbrQooHn9PgCDwwxRr0bhgT1dCG+sVkhZgiy1RrFbHLatSj9yfQsLZScpi7lt5WH9OckP880NFVbQXGkKMcwMaeUZu0l9DMHF4jsfCkSHyBzTQHIKEzaOte8TUttZtJXXRPR/Ipzd+9GQgdZPTC6b+GSt78lBN8oxvxHSrScg43GZaF7qeMf9VQI4+/TZ7kNHVCWw/k+KBt7oPk9PZyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(11063799006)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022115727099003)(261026121527099003)(261021121427099003)(56012099006)(261009223027099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ZwWDU3cDBCRFh5eUllRTdKSWhpSVpuRUF2RDVxSisyODhnU05ua3JydEN3?=
 =?utf-8?B?VGs1bTZqdUhFdU9TNTExTmcxNHpyZUFpb3Y2WDBVQ0xnOEs5RWdHd043RG9Y?=
 =?utf-8?B?VzJCNlIyV2NWbDlWVzJOZXZkU1FGdzJXclQ4S3NETnpjRWhLSlhlTmlmZmZF?=
 =?utf-8?B?Q2YxejBvaGFjVHh5UDBNR3Ivd3l0RWNibHYyWmRMV3VEUlRhM1dqa0YybkpL?=
 =?utf-8?B?WFB3bnB1bDdYM0RwQThFbCtoTU83MGxrbGtVRzVxMkFDMkVUenlYSytINmZM?=
 =?utf-8?B?NTJtelFyMWpXb3NiS3RqS0xWeWhWeS9zY2hibVpKMTFVWEVSdHN0QnFZbnNO?=
 =?utf-8?B?UzhxUlgwRFVyL1EyY0pKeTlLdXpkVnptSXdUZjFxZEFPT3R5bEhnN1VYT3dO?=
 =?utf-8?B?bHEwaWs1MTVBK0UzTzBhaDd5aE13eW5NU1Rianl2YW01aDRRdXpoTDVsMWtK?=
 =?utf-8?B?NHF1N0kvOWxDVW4wVzc2dUtHclRnM2h0akRHcDhoNTBqcTlmcHQ4NHNvUU9z?=
 =?utf-8?B?ZWlScVJ6R2ZISHpCc3ZrWFpJcHZmL1QwN0R0TjFkdktzbU9Lc1FvU2tKMHJ6?=
 =?utf-8?B?S1pMc2ZhRG13VW02L1hMdHExQWYrRGJGbU9yTmVtejhwejBYSGVLVFlxSEFQ?=
 =?utf-8?B?SHFBWU5FeUxoSFp2ZStJU0t3RXNOR3VSR3Zhcy9wUFpmdjJTQnNWOVlvMmR4?=
 =?utf-8?B?b0ZsQ1d2VDA4NW9CY2p2YzQxWmJxOEk2c25RTmV0NWF4S0tKUGRoeHk2NWdw?=
 =?utf-8?B?STVPWXBRL1Q1Z0N1R3h3SUJ0Ymt2VUJjRkVsNlpNZUdBUW1NcEd0NmhJNVFj?=
 =?utf-8?B?ZnlRcDZUUlAycVdYQUtLYXJuNjMrQXFNZWsyQjR0REJDY3BnV004Nk40Mmgr?=
 =?utf-8?B?YktRUXZMMEpNZXliMTFSVkQ1ZHErMjByYWtvNi92QjFzZTY3U1NMV0xuVHBW?=
 =?utf-8?B?NXAzY29xTCtjWlpDQnJ5WDVYaXRTd3FWb3U1ZXR3bXFhaFc1UjZLVlFyNzZr?=
 =?utf-8?B?cnNYazh2OTk3cjF1QUFEZjltTlRWSDRKRzdaTTg2alZCS1F3eCtqTlkvbWU5?=
 =?utf-8?B?TWNJSmZ3WFg3bzVQSVJKTXVJdGZueGNSWUZoQXhzY2J1YmpBdTV3ZjhRZXdI?=
 =?utf-8?B?Umw2VkdpNDU1Y2plb2lmRm9BTVpWQ29UR0lhaDNxaktGZVNDb2srK0x2TnBa?=
 =?utf-8?B?QVd6ZTdwUzZubnpaQlg0L2d2dGdoYVZMeTlGNURSS3hHR1pQUUNqNm96RlMx?=
 =?utf-8?B?eDZvZElmRFFDZk00UFpBRkJ0ZjByYWdiczFwUDk2L0gza2tyTmg2bXZxYTB2?=
 =?utf-8?B?eWdaUEc4Z3R2cVRVMmVQMlF2SFRMR1ZlNHhBTUk5OVQxV2dyL1JkKzA5WVhw?=
 =?utf-8?B?VEFuVFJYd0IydnZzS0VSQzdIOHI0V2ZMSTFwT0llRUQzYlQrYmtUMjRIbHdU?=
 =?utf-8?B?UDR3Z0I4enI0bVNIWTVLK2ZkTlNLNTQrYW1wNWpOWldGSGFybTlORVJxVnJi?=
 =?utf-8?B?VFZwQStHQ0RnbDI1L1JQYTVZaGJLK1ZOdmRSa25jQ3lDSDYzb1ltcHYrN0pU?=
 =?utf-8?B?eHgvdjlaWHIwZlJWdFhwK0Vad25wQ3VaSFJOYVJiRkRHajU3bEpVTGl0akJh?=
 =?utf-8?B?OFI4cnA1TExDRXBzUVU5SS9IbGhKalV1emlSeEp5dVpPWWFDby9MZlNuOHVZ?=
 =?utf-8?B?YzF5QVM2YWZnc0huN1IzS094TGlaOCtqNEt1Q0VyQXVRUzl4S1pTTUZGZ2pw?=
 =?utf-8?B?UnVrUWFYdWw5QlNFSEFycExEWkM5UjA2dFErWVJmelpvWHdlTERIQmRweFBL?=
 =?utf-8?B?cEhFcXNhRDhmMFZqNGZYa2tSdGgxb21QdmNBUHZQU29vRDlwQnpqSDh0Zy9u?=
 =?utf-8?B?YmlEK2pXYkgyNk9UMTFUNkh6dFVzb2ZKbVZaKzZqLzQrNndtN2lndXdqdWRY?=
 =?utf-8?B?UjRIa3NDY1NJbGVYSnNVTzZHRTR0NHo2b1lsUWJBR1BpUHVlbkNaMXR6MFZk?=
 =?utf-8?B?dEJFTjZ3b1BPWFhIWnZHMEVQQm5OY1lPRHZDRWZMcHJaVzV0eDByR1psTEJ0?=
 =?utf-8?B?Wi9ac3pSVllPdDNMYjM4Z29QOS94bitKTFFwMENwV1VrSUZlc1NjNFM4bEww?=
 =?utf-8?B?NUlQdGQyZ1pmdSttWkFhQWZSdThPZ0J6RkJIa0tQbVdPeDJBZVczSS9jYitD?=
 =?utf-8?B?T0JxMFlBMjRLZExyM0ExanZFZ3JrVUY4M0FBYnFrWU43ZVMxdTQrU1Q4c08x?=
 =?utf-8?B?eHYzbFdGcFdMNXZnSVg2RGhvNFBwaFVmaTF4ZTRSUzlXZmtkNDFQRVpGOHdw?=
 =?utf-8?B?WHR0dEYrclRRV0xLWHZVaTFmNWd3bUFPU3YrNWhLMHRmMzBTWlBmTGl3aURo?=
 =?utf-8?Q?s6crgCJwX/jz/ac0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66894509-a8d1-4d9e-a276-08df3a49727f
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 07:58:43.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3gi82dSP9uojpPyEBEdKKLzCMA2eb4m6j6uvHFCz7Ze06kSLnRmQjtANhLbbxiLemcJDeIv/DnSt7HG9vRHr3RsvYPYUckDO1KH0gELvYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB6914

ksz_switch_register() initializes dev_mutex, regmap_mutex, alu_mutex and
vlan_mutex but not lock_irq, which the IRQ chip takes in its bus lock
callbacks on every mask and unmask of a switch interrupt, and the PTP
code takes the same way. The zeroed mutex happens to work on the
uncontended fast path, but with CONFIG_DEBUG_MUTEXES the first lock,
from the IRQ domain mapping during probe, warns:

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: kernel/locking/mutex.c:625 at __mutex_lock
  ...
  ksz_irq_domain_map
  irq_domain_associate_locked
  irq_create_mapping_affinity
  ksz_irq_common_setup
  ksz9477_setup
  dsa_register_switch
  ksz_spi_probe

and turns lock debugging off for the rest of the boot.

Initialize it with the other mutexes.

Triggered at every boot of a KSZ9897S over SPI on an i.MX6 SoloX board
with CONFIG_DEBUG_MUTEXES, on v7.4-rc1 and earlier. With this patch the
same board boots with lock debugging enabled and it stays enabled
(debug_locks 1) through two hours of unrelated stress tests.

Fixes: c9cd961c0d43 ("net: dsa: microchip: lan937x: add interrupt support for port phy link")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Claude Code (Anthropic) located the missing initialization from the
warning's stack and drafted the commit message; I reviewed the code path
and the Fixes target, and ran the boots with and without the patch.
---
 drivers/net/dsa/microchip/ksz_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 767c8fe8e819a5c2b76d73d1537e1457b4408582..00ddb692ede013c41a0fe515570d023e35182b52 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -4023,6 +4023,7 @@ int ksz_switch_register(struct ksz_device *dev)
 	mutex_init(&dev->regmap_mutex);
 	mutex_init(&dev->alu_mutex);
 	mutex_init(&dev->vlan_mutex);
+	mutex_init(&dev->lock_irq);
 
 	ret = ksz_switch_detect(dev);
 	if (ret)

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-ksz-irq-mutex-init-ef8f8677db06

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

