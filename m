Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65113F9F38;
	Fri,  5 Jun 2026 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655305; cv=fail; b=IJ8URovzzYDIZBWBCdcwh+LfYRz5S6fVyJhr/az8ogW+mwu3l7PpYIopeRR1Cve1zxQtFQYP6jHV4/dMqKTFQvWAMj5yrESJ6N1CwRWv3dM2dlv/0ckjT7fkE9DqKjYb4zwKO+BnKbuGoY3vefU8Yg6b/du/szpKQTaSP8phTzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655305; c=relaxed/simple;
	bh=RONRCG5rrrGEvGtvnfBp7czcLcWILpUdvW/7vNSc578=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YlA0LzO2ZaOSfs7YAU2uc/xwksQ/unoI0Kp8Sw5LYgSnWfUZRpW8+FlD9OZP4rTkFWNLkl41Ez8nLQkyNQACznOz1ZCyHEaCoIMBshhdbow/w7JtQ/6naxGBuWRwNG6Vy5jD5UZqZBYfhKA0fDiMjbjXCAjDYFT+6qlhSpmz9Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Px2k4YAb; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Px2k4YAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTjaqxht6raPNiFY/W6OM/xOAxuF0WemeKXS+aqiTd3Rg/UYo0sw2TXCt1NEc6whcGlxT9L2D/vLZLXLsqB7aC6vUDA+e6vC/S3hG827JhamPrMGxvlAbguJPlifIzobKBNVqUzTq1hQNOSrU6pi+oZ6IN4lSHp71/EqJclgTnc0kvQknj9ebpkyygN9C/DSSPxZtViy2tUChv6b69mlJAbT7Gv1X0lNDN4Z+8wTF1EslgSAWO5LqlS9jawHk+sXxYYpYYOt1zPqzXFfytaUgTPEJV9QpHRS7yj/FFy0OQH24MGicUX5LBcEnRaU+7Dr+/LMPxy+8uswNHZiPH/70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcJkjccLI8WxjMSTLJwtETeBDxiKfKo8u1FFdT+rX9k=;
 b=CCVqCWU426i2AmH4Tjl7x1wrZpaBDmvViJzdj6i8+w9pU2Ujob3t4eZTzVUfzqjAfFOWqWXrcAnLZUt1h4Q9XSGjkqYhmW4QA74JY4BCCOLuNyJGslHxlzr2l7sYF92t0k9iLBlQ2kiPXrjiuZEi6qA4gb8QvW9Pto1ed7mPqMSipqDTn526tVQTbBC87Rgwfm1ObQVM5tWjufMgax25B3ih6Pu75t8ynefPxA7X2dWqqSH/OLT6P6ll/rzw0LSAtCD8mkfBnNXL8qfawF5j9Zcns/jJEs3Aj7r0PfPa/W1bEYkvFKD77vmJ6OEx6r8SKdYy7YD9/xKn2vhqy5qh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcJkjccLI8WxjMSTLJwtETeBDxiKfKo8u1FFdT+rX9k=;
 b=Px2k4YAb6ZHdNH8gGDiHmyg/YjsaIG17kd/UWBfn7yOqkcZOESAVGmsjz3l258rRc5jA6r2SbE07R2mUrWxZfvkZ9PS+OcDbUV/p4KVPgREEtfVamvYzGqjqVibS20fg5DvbUShsuCMG72zYu1aUjaWZSfPazZ9lAZ3t97qFX+1n+C7dNDEHDDz8+6UoPho9D0qrG/wEKqTFfFH63FKFUBmEYnKgkEyljCktoYBqdtEItJUAPZcI2XWgYLAMOsIZGxBqWxH6TSCQjOwIo/Lt6wsKEeeOgnwgeD+li9emad0Xcmzk2adIseq3C4Gu4bDDniBT2u3R5GfD+XQEdUsHtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:28:20 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 10:28:20 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Fri, 05 Jun 2026 18:31:17 +0800
Subject: [PATCH v3 1/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-fixes_fwnode_iteration-v3-1-44c18472e1d1@nxp.com>
References: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
In-Reply-To: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, 
 Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780655483; l=3186;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=1zc0uNhPzjSEis2ycOBYHenGCecrvbg+91m+tf/E8AE=;
 b=Wz+u1KG6BuVmWSCIdVhXy0DcsCT1NH5TgQe9iExMKHOThHgbpstmocJOljX96nfSaeek1He7F
 jIkrx9GmnaCBgFAC4lE1n/HOOYKfSWLYLtSvl4leU2ewyvN9hPsF6NA
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: MA5P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::8) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc62404-a91d-4cfd-7c19-08dec2ed2a45
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 HmQEM3qEFARTZ9E+D3KrHgsoHrKWf6CsK9t4UI9KqXxhkNuhDtaOsxI88dYoivvRKVWEmx1MTi35odtR7JN9vpeX8SElQzC/HnHgVowRnGOEkcOVKzD+KmRhIigeh9qjmjCAv/mV681j2U8UMS210rOCBsXCWKPjxrxVscu0eQWDFlehHnySk2zqhA2zZsBv2HGhQAEn9KDbDokoxGj9UirLOU/oi7xjiwMWCrd4I2DvocliRhbTpz69RSCr7LgoZJCCV2E2g2JQgxumZP88wj4SOOOlpciWhy/3l7f5NMeFRzm71tzQVBU3rA7hz5moCNghY9CRZkQtLahkT10RG9GuuGt1Zoik39dL+XoD92r84POjgir3Q8DVdL3n85i4qpQZsf9iuCgSgkn5gHJR9bneSTUja0qFkvmOohs9hz9QU9BEhVhGfFLv13u12FR4/i4lFZPS596CNcPYBp+JwiuGkhh39Buh7JDi512jYa6TcIE1WATSwTNW96GR68oLCmHkYNdleXe5Saie0/cgy6qtZIrPe+IN72yWTPlc8Iqls3V8XtTrLHdNIqN5BTaugl17mZoq1VvZrhuIudB210ZKCStfAtWUENWqjxXOoJU+KYn++UTe0QHzmDWIZWgZfaobOSL+UwwxBmuFcKFnFp7y/wP1hLdDSEyrqydrXjE9Dv+Em2WmHwYYXGaoBUjV
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y1NobFNtc1ZCd2l1c0J3MDNoV2hjU2NYenNSSE1YOUFKSnYwZlc0UFBSZ0xX?=
 =?utf-8?B?UDhOcGQvcGw2S1RvRTF1eU1Hb2lZWG51cGVtb001amxadTlPcS9iSmYxTkht?=
 =?utf-8?B?SWwrYmtSQUROWmNidVVFOFppSDEzVDI0ZTNFYjAwdzJpbi9DT1BYeXBTZE5s?=
 =?utf-8?B?MExPLytvK2hCM1B1L1J0OW53VGZ5RG5UbkM2S05TY2drbjJjUnV2SkpFQVRF?=
 =?utf-8?B?YWQrVlBrbmpsczRtZ0c1c21wMkk3WGQxcmMwUU9pR3FuM1F5aHk4bkpaRjFI?=
 =?utf-8?B?NXpCS1ZCY0lOempnejVqTXBzUXVoTjZjcndFV2E1QW5lL3QxMU5jM0kzYy9w?=
 =?utf-8?B?bW5jdnZQaGlhN3F5ZjVKV3U2RGZQZ1lxN0RiQ2xkOVhVamJhdHc5WmdQZnNJ?=
 =?utf-8?B?ZENGWklaaWlSdDVKSWljSEpvbzNDMmN0bDBJa05Ld0NkcS8wWm1KaS8rRTNj?=
 =?utf-8?B?L1lkZ3V2UjE5ZTljbXI3a2RERWQ1NU1DQmM0cU5ZQUpmbzFRb3Z1Z0luLzh2?=
 =?utf-8?B?U05UV0k0UnU4QUJ5a1ZIdXgwSS9uUkZaT3lFTnh4MnRmUExReGVVRitYeDBq?=
 =?utf-8?B?SVh1VU8rM2ladmxFb1pYTE1kbjM1NDZ3bWJ4WVIwR1VIUDNNQ3NTOHRyZzJ3?=
 =?utf-8?B?OGJBV1ZXSTZBRlE3a0pCZ2JMSkxvdDJ3NEpqSWlrZFFYb0NEZitpNkFMWDJK?=
 =?utf-8?B?ZEdxUTdLOElCVEdaTVdaZmo5a1ZiM0dnWWxWOTU3ZmYxOWw5d3ZvUlJGL0pL?=
 =?utf-8?B?MkVJTmxHK2RORlpKemE1ZDUxTVdJYTB3Q2hLQzdxU3JZdkZwcmpLRWoxMUNt?=
 =?utf-8?B?QWxHTEVrQzV2VmFVT1UwOS9IWWxsaTVFS1YveFk1NEtOeEtvNFRqb3BCSUJB?=
 =?utf-8?B?bWlZNlBsK2N4RzZKUWk0QlpDbmlIRUpJcDFUaFZpRElpRHRZdGFEZVd4cndi?=
 =?utf-8?B?c2pjNmdNNWNVTzF0VXc2V1ZpSzNPVGY0bzk1ckpQL2pCSVN6WWFLVkxMWTRh?=
 =?utf-8?B?NzZXTkxoWWZrcmd4QjdpSmVrdy9Sb3pMZk41S1JPaDFId0E4dDNnb1lxdGov?=
 =?utf-8?B?L0JmU2t3NmYraU1LRW1Ea0t4d0dhRkdHakl6T053V1FlZ3AxUWc2TXhINmZr?=
 =?utf-8?B?ZFY4QkNOdHZrdHgrdGtVWXdLRS84VElIL1BQQjFLQVNwVUZ4TFRFaGt4bkZY?=
 =?utf-8?B?UGRUSC9kYU4yUzVuM0sxcGYvVzJjaTdzYWxqYVdCT3JIdWtpS0VoMCtQNkx4?=
 =?utf-8?B?U3k1L0R3K1RuYzZhdXdyOHZZbHJLdUw4V1o2SzZLYXBkbUdDSUdRazhWZVd0?=
 =?utf-8?B?VTZsck1NKzcySytETERSMkNqaEtxS3B5cjZ0Z0x6ZnRTekZyVFNzcDNTbFlo?=
 =?utf-8?B?S05jaVB2N3B1TGFIV1RHUmtoVFJGcmo4RDM5SGY5dmk2RTVsd1NIdkRKdmJo?=
 =?utf-8?B?NHJhRWxxa1o0ZXArNnVnZURReTE3cVRITnlndS9vQ0ZjTVFrc3ZmeklPb1lK?=
 =?utf-8?B?cEU0Y0hpMFYrUFl0TGlXUjk1dTZwN1Z3dUwyY3V2bkkzVmFxM09KcENLSVRk?=
 =?utf-8?B?d0JwUkxyckx6b0loUS9scThhSTUzZnYzTTJwVTVZQUQvcjZNRlA3TGlGS01o?=
 =?utf-8?B?akhLNjJxOEsvd2VOZkxWd3pIck5zbkNXZHk4d0tjK3NvRUVWLzlaRnRNYmVL?=
 =?utf-8?B?ZTJHL2xVOWJ2amxQVUM5VkJFclJSalh6NU9TUVh6SUliSGxSQm83UjlSb3NC?=
 =?utf-8?B?TGlPUStEbDZPSUR2QSs4UlBYVzltK0NjQ0RqN1ExU2paVEVPSGhMVHd4bHlJ?=
 =?utf-8?B?NE5BMTFJY3NiZC9LeGRiMjFnbTgrWnVLMGhKeFFVWGMzWkpGRmc0M2JOMm1o?=
 =?utf-8?B?S0hNbUJxZURLTXEyM3ZaOHowdDdMSzFwUFlzRHVuaGpqeDRyVmg4SkwxNjZQ?=
 =?utf-8?B?TElKWERVOWs1N1U4UUR6aDEvL0E3Q2VWVFN3ZXhMVE9NY0dOaTR0eUVFYzd4?=
 =?utf-8?B?akdvVWxlcERObWtlR1NGS0gwTmYzSDA0OVRxS0pMa2RYM1JLaWR4WXl0Q0s1?=
 =?utf-8?B?OU9NMThoaXU5MHFQVmVqWUl0cDNpdGdnNlBYMzN4WTN3QXFUVnh6Vm1CQW1M?=
 =?utf-8?B?MGh2QTFIMXpvTFBnSzEwaEVtWkNVZlRLQnZCdVk3UjZSYjk3d0lUczV3RFk5?=
 =?utf-8?B?bWExU1lDYmp0TUxxQVJhS25UcVpxSUwwNENhSHovWW85dlhOalZka2VrRU1v?=
 =?utf-8?B?YThSR3g1L3pXUkU2dTBUL0pZUGV0T1A3RGpHTmNYTXlLR0lvUnJwS0VmM3E3?=
 =?utf-8?B?aGlhS3pjMExvcDdWWHVYMmM3MGU2dnJNdXh0SUFRQVNKZG9GTngwdmJMZ1Z4?=
 =?utf-8?Q?Ql+F+FlEPBB66h+7IpaL586MWZ1r2mxODz5oC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc62404-a91d-4cfd-7c19-08dec2ed2a45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:28:20.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDKNX3VZwoSexao/s2TFFc8iV59GTiTOeaNP/N1OofYJg6e8x2U4+P+y1+ddKa+Jx3Fyn6NUwJTVYoaBJcGSTKJPTxKdGMELOK2Gdd/EXURcPx91Id5dsHDWywaCwYfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471

From: Xu Yang <xu.yang_2@nxp.com>

When iterate over children of a fwnode that has a secondary fwnode,
fwnode_get_next_child_node() can enter an infinite loop if the secondary
fwnode has more than one child.

                       Parent        Child
      (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
    (Secondary fwnode)   FWb:   {FWb1, FWb2}

In this case:

 ┌─> fwnode_get_next_child_node(FWa, FWa1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
 │
 │   ...
 │
 │   fwnode_get_next_child_node(FWa, FWa3)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
 │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
 │
 │   fwnode_get_next_child_node(FWa, FWb1)
 │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
 └────┘

This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.

The root cause is that when the current child (FWb1) belongs to the
secondary fwnode, calling get_next_child_node() on the parimary fwnode
incorrectly returns the first child (FWa1) again instead of NULL.

Fix this by dynamically checking the parent fwnode of the current child
before calling get_next_child_node(). This approach follows the pattern
established in commit b5b41ab6b0c1 ("device property: Check
fwnode->secondary in fwnode_graph_get_next_endpoint()").

Fixes: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v3:
 - remove previous softnode patch as the refcount leak issue can be
   fixed by this one
Changes in v2:
 - use __free() to put parent fwnode
---
 drivers/base/property.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e08eadd66f4f..f51087065bf6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -808,17 +808,29 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
 	struct fwnode_handle *next;
+	const struct fwnode_handle *parent;
+	struct fwnode_handle *child_parent __free(fwnode_handle) = NULL;
 
 	if (IS_ERR_OR_NULL(fwnode))
 		return NULL;
+	/*
+	 * If this function is in a loop and the previous iteration returned
+	 * an child from fwnode->secondary, then we need to use the secondary
+	 * as parent rather than @fwnode.
+	 */
+	if (child) {
+		child_parent = fwnode_get_parent(child);
+		parent = child_parent;
+	} else {
+		parent = fwnode;
+	}
 
-	/* Try to find a child in primary fwnode */
-	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
+	return fwnode_call_ptr_op(parent->secondary, get_next_child_node, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 

-- 
2.34.1

