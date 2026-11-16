Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794816409;
	b=gzhBYBST2cMohO3/z5fdKq7vBJgia9FbnE9qGjUM3ZZBKj3w9mwWVzB6JJmmt3g/Ymad
	 hXwgtuN9TOZUjOGVGfZmReMi6axPSKE1wgve8QZBH18RauibpiXfr393GRqzWPxjXc0r5
	 9qB2nAKEvkuC14HcWrcf4XhTzdh2eosnV9opKmoh1A8oAl3FtigVRu8dEeDpjyewVVPhn
	 2zbuQYFtIF49/P1HZOBYmfQSNqEia6WrDzP0zLtRYnTCm3UOAk1KCVge9YznMJmaCGXxN
	 sl/MsTNeYRmk94I5kaXkv89NGCAStLi4hz3x3JnITASTYsdDbKd+kLE13DfLVt85UiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816409;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=ru0UVv3xr4gryqXsGdFkarR2n1+SP2x/tAOcKQIeiRE=;
	b=ZW9Im73Z9UkZHQi6fv23kKxEAUakyrNkyQnQm0QgqN31TBqPrvzL56phRHDKMv/85VQc
	 pg6Y58IHmVagm/5U3mO7BvfuoS/XMq5/F/9gr7TTs8EqNdsYIHPR4QX2r+vbIPrjgvcH6
	 6h5fho91ZHldaG+AWtSC3zC0oun6VB/yheU4umZ827bpURf2/b1ZsvFK8MB/A3wziG11/
	 5xh3jzgjSfIHVx4DtlI0YwgsDqLEhjpZHl1JBj/egc2HsWk3DTrtLzgY/18Ek6iZGH35S
	 0xnO5FpzatDjcEK5Z/3Uh4HZfiDpKkqVIP+cTr3Qq0S1pa/ILJXjRzFeiX8wHCxJMKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=sn8cIMNj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.89
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023089.outbound.protection.outlook.com [40.107.162.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52991606A32F;
	Mon, 16 Nov 2026 08:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52991606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=sn8cIMNj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toazZ4FWMF3IKznykN1pNcN6OsgIeO9j4DcaeSzLGg2DO9Ykk0ermCxl/1c5c8euAIlJgFiorXocEFAnAXs1fF5SBb3UjDB/4ykX5m9tM/UOAkReKmibTsc8TI2nTBKkxOwv8rB8tdups0rtCABLBS0s7YfwP0IYv8TtJtxo4ZzYpMQSlVP7gXZtY8LDnW1OaVf4u1QkQ857admoz1YBQht12IGSchVXR8WLr7u3+yFMc40xed6+8Yi0xAE3LrYTRpW+1gZYY8/qAo8n2juApw4IchAKHTm9jX3CtABGDPawI4vSBNM5TPrN7AWC5xWyzMUAMl1n9RusylzHw4/TFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ru0UVv3xr4gryqXsGdFkarR2n1+SP2x/tAOcKQIeiRE=;
 b=LB+n494UTHxipyaZ280OOBc/4LjkoqNfwN0vkrPRmBCHmaoR+ILEvEFjsOVR9P1W+oWGkVW2XVEuaX2X6oNs4PKqgjhVTgbnOYsxatUmIeZ3v0hBWKDIEn3Dl7Zp40qYaoxtAJ+xWYbzuWSo4zGCu9mj4EXSzZeKmjrokqNn4NZHz15nWEWPQ8qu65UFjIFTfFhmaA4Y+agzm6dCjVkuNYs68xVgkK5kmlV6HZ/J9N55tWDldIizV94BrVsSGUuVS4MZh82jHW3E10pu/D/v7mmyGJFCVy3RMHwMy8IV+wZDIcuGkqhSoLIcZuvKwAfV4Ur8LWZlj6JmQEfVzOnlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ru0UVv3xr4gryqXsGdFkarR2n1+SP2x/tAOcKQIeiRE=;
 b=sn8cIMNjzvZ1tyWEzuMpDKX6l1bQg6yLoUQOZ5PMz7QYAoWQHz2M1IZ9SlhSJXv05wm9fSUVhUDZPLycp0YErtkTX++ROJSCY+7n/UqHAqlzyI3yGtYSslBCJZf0kIeyMeZCmO0HvW5VAz3YIabBwEd18kPAsCSbW2jxHYTDMFUlgLBe9ZG/SHvMy/apdmcRsbYL2fkFl6cKf9zQD0C5rW16+fSrtXiQeKAGBThNR6p/umYTjlaYKnUwg2HRnPrrtkbtiJYo++WC6bC+wTCtdxgPS7vb9dQecIBAL4SxfPvSwPw2vGxXGntECUHjljTjqLPbBX9qzV57pUZRKUIDxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by GV2PR06MB10207.eurprd06.prod.outlook.com (2603:10a6:150:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 08:06:39 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 08:06:39 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 16 Nov 2026 08:06:28 +0000
Subject: [PATCH v3 1/2] serial: core: do not hold the port mutex while
 waiting for references
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-serial-core-remove-deadlock-v3-1-899237225221@vaisala.com>
References: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
In-Reply-To: <20261116-serial-core-remove-deadlock-v3-0-899237225221@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794816397; l=2624;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=CDVl3aYvbTd++Zksyu3p9VN13IUQKKqMkyWMz5rDals=;
 b=h6cuSq7AJ1eZShJyUvDzyKZY6JCVP2a1khh9c27oSntyxHcPXduak+a6cOICCI8RehKYqlHkB
 MkSGpRjlFh/CTCDUk8cFNxPCkJkdXz2mPeUMsmNaWMGloEg2JWh+oxj
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0145.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::19) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|GV2PR06MB10207:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f35ca4-6bbe-49d4-e75e-08df43b88adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|11063799006|56012099006|261021123027099003|261022075727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261009223027099003|261009221227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JJ/Bv0cdwB0IMgoGT8j2+g0Tbiks9otTedk5ivBm/Xo0OucF6BqBqN9xK3qcv3UFv9hRg/0RZdOr4J40UbGpuhqZoosfe1uccsTRPe3OFI7OmqQSYzcolZ7Z5PLeQNf9eYNz5GQtasysIkZxkyc9UqPorGE6sAkZDHZsKcrcL3dnv+mzMX4L3o1uGhWVQRZPnreMdPspJ4UKxa4AmevdtuB5fXwoXjnWX0w/HZ191rKQoNN6UQN2iFPX3Kshti126W//kAdpsksxsUewWbO/vdGn8Vhpx/v/TSa1PP0Qza81bfRNoU3WNOhex8sCX4TT+Q17E5+AKhmSBdVc8BE0w2d7bW3LW+9LW5OF1kJpq50ub2BUEdlZ64Gt0uzMN6nhtZSroWol8OmZ+c2hB+tPCHojxJwXAYxqvS7Mvw66nGTm24yzCDshD5iWtthPxKNxW1IBBLBCV1wqELUSMYLkVR8cXIqJLxBoX3J3pKy911RdBQVVkQ3AgdjPOiSOaL5v/u6rI5Hd9DLKhgcNXpkEQVaOYqjUdITDNspTXcBxr8RP4MRarxoB/8kTa4AspqL31GFq/WwHyxC0sr9AAYhtcfFTOajyETN74MVt7vr/2E+avabbDVBxMHJFsmu+Rl1PzD8/Vdi9m9Ebe9AtKwINrJxk8S6OgojoqEWBfxPC/4xomBF8sQgBLAaho46Jt9Xx5Li9qZDL7RXkD7sbsTQPCsp4FuQqSJwCD5g0dVesfd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVueVBPMCs1ZWFiV0dNSG9LMmlWcGJndkhNMTV4UEMrWVdjd2h0bUJ3YzVF?=
 =?utf-8?B?Zi9qQ2g5eExMMlZlS1dhdmxselZERDhXaDk1ejFqNU5PS29KMXFrRGMrbWdo?=
 =?utf-8?B?L0hUZE84TTM4TGpnT0dhNXh1cHJWVWMrczM1R2hYaFIzTnh6MHk0c2lud1Fr?=
 =?utf-8?B?S3IyUE9WSyt0c1ByY3hoTXkzOElLSERuUHlXc1F3OWNhTlM0ekFBYm5EVldv?=
 =?utf-8?B?eDNtSzg4WnZnZ2RzRFRSelFpbGd4SERVWmtnS2p6V2R2YnlXWEgxWU41MFVM?=
 =?utf-8?B?bEVOeitqK2p4YzFxcjh5TU92djB3SXZjS3RYVnFQR242TjZLM3hkSDRuTFgw?=
 =?utf-8?B?WVRQdGd2bnIvZSt1eFBmZTJENWZjdUFnMVJhVWxiZU4xaTdNWnNIaEdwSllk?=
 =?utf-8?B?em9xK25LS0x5OHg4V2pabmRxR25ySnRCRWJFUnFxUlJHdkFlTW81SGxqRkIz?=
 =?utf-8?B?blJZK1pjbDdPbUlGdEFrMWZydnBGZXFpQmJYUnBZVVk0NXFVNjJOQU5IRm52?=
 =?utf-8?B?QnpzOUZHOWFGWFJKRFIyTFNwSEREdDFMNjZvTE9HQUQ0VEVxVE1qUHJ5UFMy?=
 =?utf-8?B?dE9HQlF6OUl3YkNwRVJZS0gwU3Y1UGFJZ1MzMmxSUWlwZS96OXBXbjQ5a2la?=
 =?utf-8?B?cWhlSXAxQlI4N1VvVzJzb3lHTHRoZ0hVY0FWTGpJZ091VG1Vdzd6WkdGOGFw?=
 =?utf-8?B?Z3YyUnJuTWk2U3lUNlVRcytqY2I4V1ZIV0pDd2laRG90NGxTMkp0NHU5aExj?=
 =?utf-8?B?V0x2L0pQR3VwR21oSDQ5U2RiM1ZpZ2Z4a28xYW1zL1pib3U4aTFURWVKQnB3?=
 =?utf-8?B?S3JsVjhqL1BlN1pWN2hRa3I1ZWd3QXhFcnpSWWh0OE9KVmZNckRpazhqRW5Z?=
 =?utf-8?B?WGJnV0dFelFTcmgyclErWERnZ0tIQ0NqL1VoMEJFeTJGeW9PUy85bWNRYjBM?=
 =?utf-8?B?MmtMRVd2TTZNRDcxUHlzVTZxcGdybTAvWjBhUE1zZ2h4SWU1aFBWNVZOYUcr?=
 =?utf-8?B?KzVhbi9rRk9yVmJscGVUaUZnNm93RE9OcTl1VTNreEpXOC9NWnNCL1hPMUxQ?=
 =?utf-8?B?aXhuckl0eHFJZ3RiViswbzZFelZMWmNnSUlzN0hoUGU3Q3NrWTJyWXI4c3ZB?=
 =?utf-8?B?YlVPWEZnaTkyQzhGbXBXNzdaOWNoQUc2QjlUd1NKWWVpOHpkUmNtVTBQMXhs?=
 =?utf-8?B?a1lJcWhWdFpkNFI4eXlqdDNxZFhFdXY4UjYvNGxHRVRUTHRCM3NLWDhLZVVD?=
 =?utf-8?B?WUxBb21nckM2aysyRkJOY2FEdVRxTlhXbkkzM1c1bEs3NUMvNHdWTkp2ay9O?=
 =?utf-8?B?V2NKS0ttcW5ETDdpQ2pDN1VSRXo1OEtNb042YjRVdkZMcHZPZlFDVnprdUFj?=
 =?utf-8?B?R0RzUWlIRzVFeWRUMC9IRlM5Nmt0NXpJSitMWnJ3Ri91OTJsQ05zaDJwN3Qx?=
 =?utf-8?B?eTQ5cEZiQ3g1clBSeEZVNURCS1RxbzI1dFM0YVNiL0M5WEoyR0FFNlNwWnh1?=
 =?utf-8?B?LzB5QTl4ckJmS0h3Y3BSUmFCQ3ZWd1dnRGdqU1NFcjlzbmZqczRBbFZ4S0pn?=
 =?utf-8?B?eXVQYjFKZ0dOTXFDRk1JNm0xOUN6T01WeXExM0VVS0JNY0s3Z1I0eWRyZUx0?=
 =?utf-8?B?VXA0M0pjWlk1TnZBSE55SXBkSzNrZ3hZNm1DbzJZdzdyS3ZtWVRBdUNFNTdv?=
 =?utf-8?B?N2tMMUFiVklacTNPR3lFMjN5S0w1bk1SSnBUL3FnK21QRmwxVitWM1A2eUVV?=
 =?utf-8?B?RzZjd2krL3BDdFFsWS92NGtlMDFKb3ZDMGJmNU9veEFYeGozRUw0SE5lZnRm?=
 =?utf-8?B?cS9HWnBwbUpzU1JoSXViUXZUaGc2aFYvYkkzb2txQmtUYTdWN3RXRllFMU5k?=
 =?utf-8?B?YURJOW50YVB2RzBYZHoxY1dkcDRqaHh1L1Rzc1QxdktFZm5UYkpYc0RLSDFR?=
 =?utf-8?B?L3B3VnlXTmNGbUNpWWdaQXRuSjB4TTRVQzVHNnY0eEpWc1R3LzNoUXZTUStC?=
 =?utf-8?B?NmxreXhSL2lFd1F4Q3hxbC9LL0tPMnJzTUwyRURCeVhJb3JWLzJKUVBEVHov?=
 =?utf-8?B?T2tjU3FPK0tKNGU1eStWWGF3ZTdjUG9zU1U3QW4xaCtHSTdLdjRjYksrc3VV?=
 =?utf-8?B?c0lpZnJiMThqZzlMSG1uZEs0VWczSGhjelBGanhqcnpHWTFSdFpXMy9TQ2lW?=
 =?utf-8?B?dFh2bmUrS3pUcXNRdktoUExGRDFVVXpaYzhhU0NieVlYbmU2YWo0dUZEOFFp?=
 =?utf-8?B?ekU0Yk5wejIxVVNNb1crOU1jNUpLWTlZNTdPLzR2RkI0UUZwZmd1L0haL29S?=
 =?utf-8?B?SGNTQmFNcnR6L0tVdVFkZVkyQmduNG95S2poZnM0RDZGN3MxTlNyeDNXbm53?=
 =?utf-8?Q?195+VBE4QLTVGuaU=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f35ca4-6bbe-49d4-e75e-08df43b88adc
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 08:06:39.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8TJuClRXaGfnZiM+iIM0KToWjESUWLAsoQ8ayrlv1TM1ZtVv5qzAoQUtaL4lmpjC3Sp5TV1PzRB6hCHUYiCQeRU4svbCIaZQMCgUvncxEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR06MB10207

serial_core_remove_one_port() takes the port mutex and then waits for
the uart_port_ref() holders to drop their references. Since commit
8ca59f7baee7 ("serial: fix ioctl hangup race") uart_wait_until_sent()
takes the port mutex on every poll iteration to check for the hangup
before it touches the hardware, while holding its reference for the
whole wait. A tcdrain() in flight when the port is removed therefore
deadlocks: the removal holds the mutex and waits for the reference,
the drain holds the reference and waits for the mutex. Both tasks sit
uninterruptible, and the port is unusable until a reboot.

Reproduced by unbinding a UART driver while a process drains a few
kilobytes at 300 baud: the unbind blocks in wait_event() under the
mutex, the drain in mutex_lock(), and reading the driver's proc file
blocks on the same mutex.

Drop the mutex around the decrement and the wait. The decrement is an
atomic paired with uart_port_ref() and uart_port_deref(), which never
take the mutex; the clearing of the port pointer stays under it, where
uart_port_check() readers expect it. Between the hangup and this wait
the removal already runs without the mutex, so a mutex holder seeing
the released port is not a new state.
uart_wait_modem_status() takes a reference and then the mutex in the
same way, with a smaller window, and is covered by the same change.

Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Cc: <stable@vger.kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Tested-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af41db10de15ccca4169c603d9cebf6..2e53d194ecfe853ade1ac6f33e047eb8ff11e283 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3266,10 +3266,17 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	uport->type = PORT_UNKNOWN;
 	uport->port_dev = NULL;
 
-	guard(mutex)(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
+
+	/*
+	 * A reference holder may need the port mutex to see the hangup
+	 * (uart_wait_until_sent() does), so wait for the references
+	 * without holding it.
+	 */
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
-	state->uart_port = NULL;
+
+	scoped_guard(mutex, &port->mutex)
+		state->uart_port = NULL;
 }
 
 static struct serial_ctrl_device *

-- 
2.47.3

