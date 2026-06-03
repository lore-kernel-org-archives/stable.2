Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002174657C6;
	Wed,  3 Jun 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476099; cv=fail; b=kscoEcNqB1XL7x+sAniGyDpCmC++OlT/4IXKIGlmn7K2/YHKpp96UTbr707llUsfbjNXxAuckjoYdAIsZvz5CFSJL6rQQF6xpLbdwCrIwScqUUD9eH5sG710jhQ0v6Xk6f1S1edPyeACEX/oOULa/jhhg6HUfKKdLIeHBipyUqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476099; c=relaxed/simple;
	bh=O6BNfb4H0BvQVYaag8TrbUDbehLJlavqm1AaQH6fIyY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZBIW9neAHIY/3W9fsta4g4smavDxv9/mc0i1hb+T59kXV5bkXjVGgh0yzRv/LdcmfG6t9QQSmXYnC9VroQRVxVtQOeOfVQO+aMOvPEmCrCJqB1PArnufRSSDUn9GGcHaKVi6LMpx3evV1w7xPNn/EM87avr7zRlusyCqKKTiHGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WvX1+MKA; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WvX1+MKA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtYk/H/DnCgGfFmJPvY+LMhPJezfQQGpSWGFxQycIm/Ex1pmhoIr0TNXjC4uzURi3Y8X6NlxEomT3yiWcgyXA11ihgs6fFoyBQZbuEbXz8mCxtQz3tVv6YwxtFKHdPLTqXcZH5G3Lv+9vQXQfNEyuduR0dmhI05J4UPIDvwHZls6bd08d/i04rpr61xyNoEUOpzEbmrJxgpszZYGMfJb+ZaI3E7m8/WUhwDlZI2kiY19WlYE1qHbNuEJxW3a3qrfqgx13Lh+gW2q9uxrW/UohzZxACPYcIw7iLWpIPnedqE4cpRddSXkdPg1xMSkbQkPQyjDPuSOQM5cOan6aaNzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Gh2zYvBrSsvuOVhgRkEL/iyXuWAvlT5TmsbR7BOn9U=;
 b=GbkiIqCpvuNMr0ZVhwllq0KbI9bIZb15AgK/4PfmPM2h1OtDPGPJEtpcDU4y8NZIjZwQJrz6XFNvZEufTMN10N53gB8o/dsHwjULlxRogQ8YEh1ORN8dvxs/9A/bhjLJwPI7ewT127NrOqa7MFrX4BdvuQ9Zc/a/HWWKmGZkDRFlFBhBD5KU6ez6H/uJATKmD1t615M5oocEjvI/w87Bc3io839g1VzNxuTsrkjG8Ui5hpep9HWo7XT5zO95lAteIWK5N2zw5ClTWLOWYZKURvS4YxDI29Wcr50UAhsx643txyw952/GxZqJEOM39FkTKdL4AHh9EsHpJgzg9CcwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gh2zYvBrSsvuOVhgRkEL/iyXuWAvlT5TmsbR7BOn9U=;
 b=WvX1+MKAj/9cGkqTQdzBFEgiFQaLNwz14z/cGAUNzj3FcldW04dOtAb0xex2lxRiWamz00TIqfFpN/gyW3buRMM/4AzJ96kAj38JG8x93g+Pxpm+zaFZ9vSbB2HrWSuaPWaJ/udR3yla844WN3EobokmSjKJeZIgly7t5JmE9MdSb6LWuPUvKZpqyMsfO5HlQ8J5LpGwKl0Q2mL+HX2naBuu7jEbnFZNm8d5N18kpfc/CMDeLz8k1ZXNtW5edQ6MZRSbsetlZ6CkxlmXEWwogIB5EA1IecUcwY5Bk0fJM7Zv2rT02Ai3PXrXPfWQdJLVUllNyzGrsdXolRHXakYjMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV4PR04MB11902.eurprd04.prod.outlook.com (2603:10a6:150:2e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:41:33 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 08:41:33 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Wed, 03 Jun 2026 16:44:31 +0800
Subject: [PATCH v2 1/2] software node: fix refcount leak in
 software_node_get_next_child()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
In-Reply-To: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780476273; l=3206;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=Dx5CFiqYsqKIjXOSZ97dhiBcnznlW5VWQSXYapF/P+k=;
 b=Ao+/Xch80mZGE1Fjq/QUhRKmHPdaYGO2HuhBmQ6QXPCTNqoPQX5YZv1gZWZHznb7UZ3zU7xG+
 r2YU/RX95PEDREoXNTrDek+7jr9I8N72igyJVSGYSOYNJD5CuYDBVFa
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV4PR04MB11902:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc7b5e3-c422-483d-5052-08dec14be9b2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 GH0CCwiGbzpkZxzr8/+roYY+YZaJg6E9BG8H63jxOrrBeSxahOQbazcB8Iq6cxSW6Ynmput72S/9uAGgVxJucxbF2v6z4rKberKLXST93BrsJ1AJp9lgew4bKXL15FXCfRJvV5DWTcvtVTKEXmq9Y6ZzVcScOopMtP9JSWMSnz8GLCetbWvz/NAZEHOavxfH0hy2XRPh+tZU+gyew3ebaAVslvhkrCh/2oxFPPnh+28CeDeBgsyA+mIa5dI/nGXatO3rp/FbNjTyl6WXjTsUMkWDQhGZAyRjpRa7uNjHKWlcmZlwOftKVnT91PGiiB2iKAtBP4WGzyqbMTs0ievxCycsAN/DRloPsag3V2aSBuu7RRga3b8cCNSaSuo56ovfy7KSjXmNsntCfEYHajggrjj912BIb+vOYTgyBv3oT2UJgE7q1cDKb5KyhWZStX49B5/dkEazLnKCtko10/ZUPlPDuoCRNKfPhORgCcMaLZf4+YNcaVacReuwu3Hvmw0/CJ5yKaUNH+c22ChB5ths6U2qUfjsUagsGtxAAdnd2o3YI2a7VkoUj+6AaI852Fjs36R8ghn5E2F9Zy9/Mg0ne0obaJWg6kGHMJ0xmxn5nGKBrk8u7d3jvnYLDqlWk8BngfoV2jmIqMYj93v5Uk9DDUwuFRQURs7T1lTvcK+5v86zoBF3U/rPjvxE6yFlA13E
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWs5RkNhVW5hRlhrRlBmNmRLZmc1elR4QksvUnRRb3QzZEFBT0ZTZVIwc3Yv?=
 =?utf-8?B?YnRFSXVIMmlEd3hXd1g2NW43V2dIQzVMSFlVOC9vOEhqaXJoMUo2K1dPdjNU?=
 =?utf-8?B?SHZaUnJUSXhYV05aWnBUNGUxNUtZR01QNGs0d1VVakMzaGE5UDJoMWJ1QVpB?=
 =?utf-8?B?ODNWTm5oS0dpOEJpdUM5dDVkdVQwenArb2JaTkRTeXZoWkoyTkdBWGUwb1VM?=
 =?utf-8?B?VHNwcm8wcnNxdlFMOWRWN3k4NFloOWRLaEMwL1h4YmFHY3pGYzJDSzRhZWJK?=
 =?utf-8?B?STcyNm9ucVF5TjBrMFltSzlMYmdSQzBkNWtKMlZmbUozcDBZVmhlcml5Z01n?=
 =?utf-8?B?cDkyc1dESU5lVEthUExuZFMxRUFZUm9STC9nNlFWVG5SV2VpUFRRTGZucVM3?=
 =?utf-8?B?Y2NhSSsyT1ArZ2svT0NXYjV5dzVXSURTWURVeWZFWWxlV3FpMGJrMm54Ullw?=
 =?utf-8?B?elRCTVhIRkczUnhhMUVvVXdianlVYjU1d3IzT01FdkllWUtpR3Y4Q2RxNm1l?=
 =?utf-8?B?bGFNWCs5aE9zMUVjWWhnbDRTMVJFU0ZiblJUb0NwUkNudW16cGlCVFlqdEY1?=
 =?utf-8?B?bEM1RWZyekRINytoVnQ1TEw3bE4za0lpRFRSMFZmZkR5QkM4Z0VqT1NGOU4v?=
 =?utf-8?B?VlROSmo4bXA1MVlYRjBRYWxpRXpZSzlSMXdzdGJBY1ZtaDZkdXZSdW5BWjg5?=
 =?utf-8?B?ZmpwOEdxdGxOWFZPRStOMmp5U1dEWURSbExFc2t2ald5ZTBGN1JWL0l5Uytu?=
 =?utf-8?B?bi9kSGJqYzh0T3M2TElPZWlickdkZjY3QXF0Q0w4R3l2UlBBbDlualBWU0Ny?=
 =?utf-8?B?bGZDWGk3QzV0Vk90MmRDWkdublBwc0FiV3lPaXVkTUpiSW9MaEVnaEJLWnVn?=
 =?utf-8?B?d04wL1pNS29rYlJvZDNaSGVEbXlIMHNPOWVEUDFZNXlzcE9LamtmZG5CeUhx?=
 =?utf-8?B?UVVadVllN1E0ZC9NRTJnVG9sYVRnVVltbWJDd01hSXAzZ3pDZ3RCdkN2ZlVz?=
 =?utf-8?B?QWZwNkxURjloSEV2VWlrWWhhUkJqaTE2cUY4LzRiUDlmTlpsa0JOOUoxcDUy?=
 =?utf-8?B?Tk4vTzdWR3BIZWZLL0UvVThsL3IwcmNISC9KZUNLRjJzUFBFVW5ra2R0QVhq?=
 =?utf-8?B?VG5oeHl1SW9wRXFXakM0Tmo2U1ZEdHd6VytacElwNDBvcXVNWlVaSjU2eFdw?=
 =?utf-8?B?Mk5jT2c2djJwMk94YkpSTWhYTDRzMjBTYUxNZDJMU3J6Tm81WW5nK2dwQ0NW?=
 =?utf-8?B?YXFxcjFZeXFHMm5wLzhsMjlMSzFUUThYK1JZN0dJU0pjUEZWWDdMVEtmRFYz?=
 =?utf-8?B?N0RlUlBIVUppd0Jpd09vRjhWK2NIUUJRYVdTZlVjQW1wbFBteXdybkZSM0I0?=
 =?utf-8?B?NDFLNkZScGx1VWZ6RkwyVmF2SW1lZm1Rc2ZLZVRrblhGUjMrK2grc0FRYjly?=
 =?utf-8?B?UElpVE1SZWdDWlEyblUyZ3RYQlZlQU43L01JaUdyMmlEWU5ZZGJBYVVIUVRr?=
 =?utf-8?B?MXduUHV6Q2ZPdVZrZlM3S1pxQmZwV1hkZHJFbFp3YkNGWmRNZkxQVlN6TGt4?=
 =?utf-8?B?VzJQTlh4MjdpTmFRUUdSMDEzZC9iM2tqMW90RGNIL1NQNFhGSDdJVmRlcUph?=
 =?utf-8?B?Qlh1blJGcWdUVVViM3ZVcFZER2drbUdpRlVHejR6cTBrV09EUG43V0JCZ3BD?=
 =?utf-8?B?L2ZyZlQ5SHpSZDUxOUIwZ2VOemdjNDRxMk1zTkdWWHc2M1kxa242WUFvc2pV?=
 =?utf-8?B?TXpiU1Fwc1RUeUpSZ3pxY25ZL1J6cVFBUXhSVHVhSFphUVg4WmFHWFdTVHdW?=
 =?utf-8?B?dWxXV3ZXRUdXWVhvS3BWeFF3Y3A3Y1BvRVIxaHZvR0hCSnBacTFGaWxaNWhZ?=
 =?utf-8?B?ekI0QnB3N0VibkNCeGMwdTNKRkJHbXM1VlFRNlZ3OTVvWkh6RjVEUHYrK1pa?=
 =?utf-8?B?N09YcWZtUW5nTjRvZjNGOEQyclVlUkZhMjNLb3ZpcGFnV3FFYVhrWkdobWkr?=
 =?utf-8?B?L2JBek9FUXBLZVNMUHBPdk5MNmNheXRnZ3FHTjYrZnF3c2xDQ2l2YXMxWUJr?=
 =?utf-8?B?RmtsZEVsK0p4MUJkMWloTEhVVjZvSEh6SUNGK1JYSzN1UDlUWG5KYTg5MXN2?=
 =?utf-8?B?M2FZSkxGRmZPRC9xZFRZL214K085L3AwOUtRbldWREdwUm9rUkJvVFdjUHV5?=
 =?utf-8?B?NUdOS2ZubHZNWmhTQ21NKzRxZGNRT2NRVVUvZUpRRzJMQmQzOHJCS1l4MVA0?=
 =?utf-8?B?SXBlRzhVeEdlZXROR2lFUU1uR0JLakhSRVg5V0hLUDBXTEZna0R3YUpPdXQw?=
 =?utf-8?B?cmdGOC85bHQwQ0JyQVc3RkZjRk1SZEhGZ3lWbTZNQVUybnhjVmZ6Q1l3S28w?=
 =?utf-8?Q?nzdy9tmhW2ja8oZI5gp97n/3EyGJcrp/K1M1A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc7b5e3-c422-483d-5052-08dec14be9b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:41:32.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNjTBjYNlGYNffKcmT2qIyGHt3bq794NzphNr02XXfGl/xPz2WUa9LKSA/Imr8urPf73k1CfuGhRaLRteirX9j5TmSpAg/hxNrbT4J27mP7PrA+n6yS8xnZkiVQdLv2P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11902

From: Xu Yang <xu.yang_2@nxp.com>

When a swnode acts as a secondary fwnode and is participates in child
iteration, a refcount leak occurs for the last child of the primary
fwnode's children.

                   Parent      Child
  (Primary fwnode)   FW:   {FW1, FW2, FW3}
(Secondary fwnode)   SW:   {}

In this case, FW3's refcount is decremented twice during iteration:

 fwnode_get_next_child_node(FW, FW3)
  1. fwnode_call_ptr_op(FW, get_next_child_node, FW3) returns NULL and
     decrements FW3's refcount
  2. fwnode_call_ptr_op(SW, get_next_child_node, FW3) returns NULL and
     decrements FW3's refcount again

The same double-decrement issue occurs when SW has children.

The kernel dump as below:

[   25.435805] OF: ERROR: of_node_release() detected bad of_node_put() on /soc/usb@4c010010/usb@4c100000
[   25.445072] CPU: 0 UID: 0 PID: 617 Comm: sh Not tainted 7.1.0-rc4-next-20260522-00011-g7376b330abca #210 PREEMPT
[   25.445080] Hardware name: NXP i.MX95 19X19 board (DT)
[   25.445083] Call trace:
[   25.445086]  show_stack+0x18/0x30 (C)
[   25.445101]  dump_stack_lvl+0x60/0x80
[   25.445108]  dump_stack+0x18/0x24
[   25.445113]  of_node_release+0x158/0x194
[   25.445122]  kobject_put+0xa0/0x120
[   25.445129]  of_node_put+0x18/0x28
[   25.445134]  of_fwnode_put+0x38/0x58
[   25.445141]  software_node_get_next_child+0x54/0x15c
[   25.445150]  fwnode_get_next_child_node+0x70/0x94
[   25.445156]  fwnode_get_next_available_child_node+0x34/0x88
[   25.445162]  device_links_driver_bound+0x2f4/0x334
[   25.445168]  driver_bound+0x68/0xb0
                ...
[   25.445258] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'

Fix this by ensuring software_node_get_next_child() does not decrement
the child's refcount when:
- The parent has no children, OR
- The parent has children but the input child is not a swnode

This prevents the refcount from being incorrectly decremented for
fwnodes that don't belong to the software node hierarchy.

Fixes: fb5ec981adf0 ("media: software_node: Fix refcounts in software_node_get_next_child()")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
---
 drivers/base/swnode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 869228a65cb3..507de464d387 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -474,18 +474,18 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
 	struct swnode *p = to_swnode(fwnode);
 	struct swnode *c = to_swnode(child);
 
-	if (!p || list_empty(&p->children) ||
-	    (c && list_is_last(&c->entry, &p->children))) {
-		fwnode_handle_put(child);
+	if (!p || list_empty(&p->children))
 		return NULL;
-	}
 
-	if (c)
+	if (c) {
+		fwnode_handle_put(child);
+		if (list_is_last(&c->entry, &p->children))
+			return NULL;
 		c = list_next_entry(c, entry);
-	else
+	} else {
 		c = list_first_entry(&p->children, struct swnode, entry);
+	}
 
-	fwnode_handle_put(child);
 	return fwnode_handle_get(&c->fwnode);
 }
 

-- 
2.34.1

