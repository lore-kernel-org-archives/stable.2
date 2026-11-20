Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160359;
	b=0zLSxPyvaQO9xxzgEVBKiXE7vXAU7NBfgmYp7KsvXFfQwwV+5Ag7E+nh1NRYO4yL8Dhl
	 FB0bIhktc1CKl/TT9tS2QBH2zLppNQsoR9ko+DkHhNq5wO5LXnKVdPZNF7tKn/NfqWWo1
	 dK75prHHp7gbVjssX8JHNXdkqtcyF8+QpTLP4kaXeZ+FF9vm/oWz24RsOp4WAk6Mr/aTL
	 l6MqMBB/tqmIP52B8iIHzvDnMBKQVhZ4cDjyPmhKPiHc5b1ickV2fIQpjQ5Ys+aa4F8kE
	 Bol+AtZvpXThX2E9A3gZQ8ircd5J3enUX93v7fUN0/VR+9g0Y73H/ykAVWy/JcNfUFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160359;
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
	bh=AKF5NNuuy9eHrKifE6TWwWI10h+snqFLbyGNLycuw24=;
	b=3yljrwRjrJN+cG65sYd6Qzvo30wryihlT2Qk7TyxVRQl0MVhGyCs3RS87i5ot0cASHB/
	 oLOITstDaUZZewvPNYxK8a+PV5F4J+n0IC8lJDXCUProtOruRAj1subhjjnYpbEuuljhB
	 nRqICqdEBXMWmIR0rXbn5YoHvNDfTUAldXTO9YPPFLxmXLM6vIMCJBsxZU7jI3Owm6uXX
	 5XCmkacQy7a8lhfHacbFu4gMKu332Gn+a1pm6KWgzZsK+sK175EBup+aBLBm/cYfosBWW
	 G8GTCRMG6iThgoHFnvIzfjg1ADKX/OjkzHgNQYSMurGRK7Sz5qz0oOeNPy5d1RpQavg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=VLhLEb8N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.115
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023115.outbound.protection.outlook.com [52.101.72.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD80606A331;
	Fri, 20 Nov 2026 07:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD80606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=VLhLEb8N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEvTa8lgB3ZX7odSQ01eiwD1PFwm20wC2xHY+wZkC3Q8h/kvCoZYpQJgWUw8fVq6LOt8KlIWqFFfRvCI6fKM1FYJw0bqTUvrQlGSWf/fBLEX6UadNCuQ4+MoJfloFQtlVG7dJ3sPV24pRsJQwFJA/ki7PVO7KsbI38+KPk7doRMV4c8WuvBXxQyG4RLMkoQPVnnnr6uxZQ7d//zVlwdH+pOBlIuTkMF784CMnwCpxGrbK1ocNvyGF2Gd3dPCWMgBIwJfb8xY84gpxKq+kBoBXstW3FagJ2hmyvqkO1dl3d7+Ztvd9ZKDX9zdp0Equ59/rsa0ilpmjYejY6Vg4jRKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKF5NNuuy9eHrKifE6TWwWI10h+snqFLbyGNLycuw24=;
 b=TQT3ncfpO5lBhJQjeo6KK/sYUTeGWQ6aH6MIGgP016Bv9sqnitIAtQxvD3m9tmaCWnxHHMmx/wJrNHJBnqca+zrSIsDf11VXmH8O8jhQclPNQkJgjR7OcSp2RzbaNFAbB9FZSszL9qh+6lVOoRzcTB42P6MqF5YU1FdCakDZSId86XIX6fJkGm9o2TShDjCRHmu3DXLfYxpMBjlzd6oG0ZIbnGrEczPs/Jo5Rd6hhzjUrc7kLx5SBciS5nKqKxfB+RHyOHU2qVY/HF/S5MjPTXOdknLA6RO7XEdcJT7k14peDDBKUUUxZbReMpKMKVQKTTFe679e78adhUz5+CMIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKF5NNuuy9eHrKifE6TWwWI10h+snqFLbyGNLycuw24=;
 b=VLhLEb8Nw2TjcnJrOaRG87dm7usfLeqy22oyowQOtKYgihx2G54T0ey/dPVtjEiZR3YyriVLnM0m/isIKmkKVzy0HfeKhPtUDIHP7kf12tuQjM88btSXWpG+YIWeQKu2EpDMjCDpZGSKN3W3XMnpgN/wgMP7FFnOvJ1jSQLwd6plTiSsUvJ/s7ZbHgQqnWmg8bLQ6t6cLNcJZ7ijCW2AzukJFGxqyYfyCiFAwh8cjUPp/Lv7WAZimhFkk5+ptbTGgqEwyTjt9PptFCu9ZAOvTKplBESnFhvwKNyMkoNDFNUOH0rQo86pdQHKZLcr3Ssr7tfQcBdpa0S2Aj1Xt7aX0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by PR3PR06MB7034.eurprd06.prod.outlook.com (2603:10a6:102:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 07:39:13 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:39:13 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 20 Nov 2026 07:39:06 +0000
Subject: [PATCH] serial: max310x: look at the port once after enabling its
 interrupts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-max310x-startup-irq-status-v1-1-aee4e1416cf6@vaisala.com>
X-B4-Tracking: v=1; b=H4sIABn5/2oC/x3MMQ7CMAxA0atUnrEUpyIEroI6RNQtHijFTlGkq
 HdvYPtv+RWMVdjg1lVQ/orJe2mgUwePZ1pmRhmbwTsfiCjiK5WeXEHLSfO2oujn13kzdKG/Rhc
 S+csZ2mBVnqT85/dh3w+PIKvNbAAAAA==
X-Change-ID: 20261118-max310x-startup-irq-status-0639806a1275
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160352; l=6120;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ZXbD0+bC56QqIEj8XGG2k7cc4nxEWp8Qp2/Sic/cQfg=;
 b=fQOtX67UNTBrA+J11EVlNTXbQ18NKNfdCiQ5SwMA9JF+dCv+f+F0dILgZAM6X5hyQAh7C/rXp
 X+HV075cFbXDQrn1q5bHobekA8OmpOXfB/UqxPry1EBcd0keRisVdHq
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:272::8) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|PR3PR06MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 376dac2e-1ce6-4006-b87b-08df46d95f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|52116014|366016|1800799024|38350700014|10067099003|5023799004|11063799006|56012099006|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	KzxzXkbT0LJOCaKBXaDTqw1hpM0kiICpbeXRD0rmNlD5bGSWyiCnf0Woi3CHftvOYADi8HQqKqYMxV3FUgVhxUh5ueoT/VTXWkg5boJqakQVCpZ7OSwV6odFy7DK7Ea9X1jQ6swL9NOyX6B8uj3SHVcFCZFIGfJ1vyQ8PuW5tCfnmH2qUFDzZwXP1EPSxf09kEUwIcQN4BOUxYxtkd+4GwIryQw43rOosrjOffB9CEOhNPMrZFbTXJDdagXWh9q6pV5VWLaapEaTX2JZFBFBLOaeMqCl4bfNEvXU8SqlNRNqjQuorI45kXdg2UTYBrQJRa4XL1nFbGnnX5yxCRkVysk34iTsFbdg/KGC7IsicIqwj3rvLpjM7ItoqI/7ExgqroWPwb/9iIykNQcA6MB7uZDDekGYQjKgWttW5cM9rQTwKrRohDA22j7dPeOVm6DfXwvrtuRxCWTyZbJqVDjE8egfnkcbjxfyXNiJqJeN0UTb0HU71sPI2h07RhSA0WUfCxJVBEiLUNW1v7VEZYzGXFRR2fIkQkBmIHA254hHNIlfLWm5Xgci/p79DzyFS/oxiubOONJBInLFoGG15R66v3HzU8YxNLUkTW1K4My/v45Am1KjVjnuNnef0zw546Cwn8Kuxv0PAOsWvxO5BfkQ3rix3MVVjUXzCrMFwq9QMmURdUfgBVk+ngeF1/HrMInGrDqG5C6Zw/h62i/IJFk4zlJe0d+0WAz41EE+YmBgQSw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(52116014)(366016)(1800799024)(38350700014)(10067099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGlneHh0RW5iK2V1anJ6dUNWQ2orZmRQZVBwUGhjSWllUURYN3djSEZNMzJm?=
 =?utf-8?B?VUZycFoxRmY5cEl2dTFsS2NEMkJXbEhFVTFDMlhudWtESTdvZjN3cTF4VXdB?=
 =?utf-8?B?L1NmTi9QMWpHVTNEa1V3MGs5UEFmdGUwRWV1QStvcVlxSi9KblN4U1ZKcDhk?=
 =?utf-8?B?L0RsOWIrUi9hNW1jQlBSeXY3OTBMNWEycEFXbTlTT0tPa1kvUDRLdVZRMHBj?=
 =?utf-8?B?dkZ6aHBvNHJLUC9PUHpkQXZZYzVNbzluR1hNSkg2WHZRdjJWeGJtVDJ1TC9S?=
 =?utf-8?B?SjBtck9jK3ZaNEpSTjl1aS9aaDBFNnNFb0V5aUFCaHVuRFU0bk14UHQ0UWdR?=
 =?utf-8?B?UWRieStudk5ES2lQVk9KK2FaWmppdHM0VWV2Z0VYOUFFY1hwbFBCUU96WUJR?=
 =?utf-8?B?UmVMRllLcU1JK0ZUcHNlOUh6d2Q5N3hwNU93dDBHWEUwUWh5Zmw3eWVPRXJv?=
 =?utf-8?B?ZEc0OEVPVVBsOHczZUMxRmJwd3ErUzlZZ2I2YlhEVlowdmt4WWkvZVdnZzMr?=
 =?utf-8?B?R1c0ZkJpVzNLT1ozRmFTM09KOFpoUm9mQXR1dHd6SDFoSTdyeGtYWllHYUVu?=
 =?utf-8?B?QjdadStsN29xalpGclhBdnllVFV3ejZFaDFveCswa2RuQ0ljQlhYaTlOZW93?=
 =?utf-8?B?ckdQOW5kbGNOZ21mRFczZXV6NVp0MXE1cFpoM0ZkRmEvaGFnVEtLTnlmanRQ?=
 =?utf-8?B?clF3MFRhTWNOeGlFTll3a1VsbTJ0MjRQRDFCY3hISlBVL0MxZXFXT3B2eTdx?=
 =?utf-8?B?bjE3dFo3NnowTlZqcnlYRVBpa29RL0FJR01NdURUVkJMWVVRK1NkUjJuU01m?=
 =?utf-8?B?aGNvUHdVczB5U2tYKytNN21RZDNLQ2VuSytVL1p0cEd2SU44YjE5RTNqVWNj?=
 =?utf-8?B?ZzlLLzNBWTg4amMvNkZMYjV0dUhiQjZ5MG1SNmkybDRsdy9WdzVhK2NuK2NT?=
 =?utf-8?B?Z1g3WWlCMEhEK05uN0NQdUs5Vm1FZnVvODRTRFBXelpDelI3MytkVzJqWGVu?=
 =?utf-8?B?QUNTL1JwZWl3NE1UcEhuUmlPbHFQNkdLM0NyWXBkclF1ZlRLQnZZWStUMjc1?=
 =?utf-8?B?eDNxSmx2SEtWNE1neElITmx5QVJTYmhNdlA4K0hEUzM3b0lheDdRL3FUWnJo?=
 =?utf-8?B?TGdiSDdjd043UDBRWlpNUisvWkVzL0hYd0d2Y2xRekdJTHc4QkR0aHlvaUg4?=
 =?utf-8?B?RlliU2dKb1kya05oS3M0MmgxMGRqeGNiVTVraHd2SmxzMzZzQUo5SXpIbzNn?=
 =?utf-8?B?bXdxaE1jdzJTbEhFVkJRUm9jRDVrcUNNSTJtODVxUlhDSDRqeDdNZWx6d1ZT?=
 =?utf-8?B?QjZtYXJZbGx5ZVhYTGMxanpQUDRFak5UdFBsdDJReHAzMjIvWTJsRzB3Sm5R?=
 =?utf-8?B?THBHdGZGcXB0WXgwMnpLS25HZmlZQ0wwTkIrRHZyT2Y4TGZybWZtOHR1SUNa?=
 =?utf-8?B?TFZTd2diQ2pyRFZjRll4M3lOZFVQUDFuMWhYTFp0ZlYyMkdsZ0RNMzFCRXFZ?=
 =?utf-8?B?UnI4T3g2bzc4SjZxS000aEppM0lSZ1hLVHQxeVhZd2NJTFpmQyt2RGIycHM0?=
 =?utf-8?B?VlhSL0Y5TTdEa2E3ek9RbW9tZ3VRTlpyUWd6bnBjckxVWkMzcTJhL0ljTndZ?=
 =?utf-8?B?d2RJZG9jS0EybDI0cDJQL002a2NoRkJjNXJmV1hEbFFCRTRLVHlQWjg4dkdu?=
 =?utf-8?B?Y1d3eW8xWHhDZklIalgxcTNZQ3Y0OTcvaXJaVWRWZ1I4Mm5HRDloUi81YzRj?=
 =?utf-8?B?ZGo2S3l5cE56M1RTRXg3SHNZQjhzNHR1WVY0a2pKTXdkRVdnczU4VitrSUt6?=
 =?utf-8?B?cFlyRTlSenBQKy9RRytrSElzNXZTcXFXdmNGMG1WKzVoNXJUNlpHc1NPYlJW?=
 =?utf-8?B?a3dtTzlkRm53UUNCeTNWSk5nSmorL3ltYWFwanREdHZOQ0tMUEh0cDFSNFZ6?=
 =?utf-8?B?WjZwYWVYamtydllweTdsNlFuTXZDUHo2SVh3NDY0OTNCRy9md3ZoeWRZbXdT?=
 =?utf-8?B?MGNPc0VleVBGRXBBZkJ6eENKVjV0RVhtTzZDYTllaUVOZDNEdlpIT1F5ZmIz?=
 =?utf-8?B?cXY0cVFSWEJYdWVOc2xFbXlPZ01kNVRydjdoOGV0cFYwMDd6Mm85L1JYaW9H?=
 =?utf-8?B?QlFEaFVzaXV6RnlEQ3h6bGkwL2VNWWN2ejNRRmwySHlIVWNFWDFIaFZHM01Z?=
 =?utf-8?B?emkydytyZnBZTVg3ZUhFSFBsbm1ER1l5OW9UUWZ6ajRROCtWZHVERFh1and6?=
 =?utf-8?B?WFlxVWtaTWxSbm4xMTRIVlQ2dmU2RFVGbjF3cFAwVVR5ejJIcmpBZGsyWVh0?=
 =?utf-8?B?NDNTSU9QZFRzVXd0ZHpFK1RURXdpMnFrMDNhcHJ5SGxVUnBjeXBuYUhlbUZI?=
 =?utf-8?Q?NqMr56xW00mbWMMA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376dac2e-1ce6-4006-b87b-08df46d95f6c
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:39:13.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbyWFM5aYH3GKEsRkoRY2bUSO0Y4P1docMJc08R7e1oidSBUMbphnqtvgVsFW9vKoLrs4ByCDpa/+qmd00N0WfIBntikAvH/JLoA9ztGiWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7034

max310x_startup() resets the FIFOs, writes the RS-485 and flow control
registers, then reads the interrupt status register to clear it and
enables the interrupts. The receiver runs from the moment the FIFO
reset is released, so a character that arrives before the status read
sets the receive status bit, and the read clears it again.

That bit is an edge: with RxEmtyInv set the chip raises it when the
receive FIFO goes from empty to not empty. The character stays in the
FIFO, so the edge does not repeat, and since the rework this is the
only receive interrupt the driver enables. No interrupt arrives and
the port receives nothing until it is closed and opened again.

Opening a port on a line that carries a continuous stream left it deaf
in 14 of 48 attempts at 9600 baud and in nearly every attempt from
38400 baud up.

Wake the interrupt thread once after the interrupts are enabled. The
port handler reads the receive FIFO level besides the status register,
so it picks up the character without its interrupt. On a chip with
more than one port the thread only visits ports that the global
interrupt register names, so mark the port in a mask that the thread
takes in addition.

The wake relies on the driver's own interrupt thread. Behind an
interrupt controller that uses nested threading there is none, the
wake does nothing and the port can still come up deaf as before.

Reading the status register before the FIFO reset is released would
keep the event without a wake, but after the release the register
reads CTSInt, RFifoEmptyInt and TFifoEmptyInt on every open. The read
after the configuration is what discards them; without it every open
raises an interrupt and reports a CTS change that did not happen.

Fixes: 10d8b34a4217 ("serial: max310x: Driver rework")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
A port of a MAX310x chip that is opened while characters arrive on its
line can come up deaf: it receives nothing until it is closed and
opened again. The commit message has the mechanism.

Tested on a MAX14830 (four ports, SPI) on v7.4-rc3. A second device
sends a continuous stream to the port while it is opened in four ways
(plain open, open with a flush, with a termios change, with an RS-485
configuration).

Without the patch, 14 of 48 opens at 9600 baud came up deaf, and
almost every open from 38400 baud up.

With the patch:

- one port receiving, 48 opens each at 9600, 38400 and 115200 baud,
  run twice: 0 of 288 deaf;
- the same stream on all four ports of the chip, all four opened at
  the same time and one opened while the other three receive, at 9600,
  19200 and 38400 baud: 0 of 315 deaf;
- 24 opens on an idle line: no interrupt and no CTS change counted.

An alternative was tried first: reading the status register while the
FIFO reset is still asserted, so that nothing can be lost afterwards.
It cured the deafness as well, but the chip then reports CTSInt,
RFifoEmptyInt and TFifoEmptyInt on the first status read after the
interrupts are enabled, so every open raised an interrupt and reported
a CTS change that did not happen. Waking the thread leaves the status
handling as it is.

irq_wake_thread() with a mask that the thread reads in addition to the
hardware status is what pciehp_request() does with pending_events, and
oa_tc6_init() wakes its thread the same way for an event that predates
the handler.

The patch is independent of the other MAX310x fixes on the list.

The patch was written and reviewed with help from an LLM assistant
(Claude), used for code reading, review of the drafts and the test
scripts; the analysis, the change and the testing on hardware are
mine.
---
 drivers/tty/serial/max310x.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index de8a1f05cf30ed121e5d62140f2e8dccb851a4ed..cdd1655c9f35c51e0559d8c24b3bfd7c1fb79ff8 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -331,6 +331,7 @@ struct max310x_port {
 	const struct max310x_if_cfg *if_cfg;
 	struct regmap		*regmap;
 	struct clk		*clk;
+	unsigned long		poll_ports;	/* ports to service once without an IRQ */
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
 #endif
@@ -1076,7 +1077,7 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 			WARN_ON_ONCE(regmap_read(s->regmap,
 						 MAX310X_GLOBALIRQ_REG, &val));
 
-			irq = val;
+			irq = val & ~xchg(&s->poll_ports, 0);
 
 			for_each_clear_bit(port, &irq, s->devtype->nr) {
 				done = false;
@@ -1539,6 +1540,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_port *s = dev_get_drvdata(port->dev);
 	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
@@ -1595,11 +1597,19 @@ static int max310x_startup(struct uart_port *port)
 	val = MAX310X_IRQ_RXEMPTY_BIT | MAX310X_IRQ_TXEMPTY_BIT;
 	max310x_port_write(port, MAX310X_IRQEN_REG, val | MAX310X_IRQ_CTS_BIT);
 
+	/*
+	 * A character received since the FIFO reset has lost its interrupt
+	 * to the status read above: have the handler look at this port once.
+	 */
+	set_bit(one - s->p, &s->poll_ports);
+	irq_wake_thread(port->irq, s);
+
 	return 0;
 }
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_port *s = dev_get_drvdata(port->dev);
 	struct max310x_one *one = to_max310x_port(port);
 
 	/*
@@ -1612,6 +1622,7 @@ static void max310x_shutdown(struct uart_port *port)
 	scoped_guard(spinlock_irqsave, &port->lock)
 		one->tx_teardown = true;
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
+	clear_bit(one - s->p, &s->poll_ports);
 
 	/*
 	 * Stop the transmitter: the character in flight completes, data

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-max310x-startup-irq-status-0639806a1275

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

