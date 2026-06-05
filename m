Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E92EEE65;
	Fri,  5 Jun 2026 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655300; cv=fail; b=RqfCNQOjTqPksOLm2QUFW/TZQe0O0CluHNOA0BITXPLcLfbNKdsxKVFKSFMzLn0YpPiar/hUcTIAjCn/Y+T62k0tOP5B1nyRRfUDPoTmnzYdG4bcLPGyD08d0ZC6ufy2ve/nEAwsBfbW3Em9/jQ0uVPcBaScvsQF6V7Y054P1BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655300; c=relaxed/simple;
	bh=hGOW2vc4LqU6Xl7E0sb3cqsBWE307hXWVIP42y0EB9E=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lV2V/Tznjz2jmZjkdO46Jn0OyTVPvZOrdOOAg3DgyL8pmDvMtI+inuk9o80a8nUBIvUmefvGycuSdpKsHJ4I4O1ngdNSktm8wU26nV2YAH1Zjyz7SXC+r1k8MNMF4INk4I7+1t/0iggZ+r9JmYmRke9piYwDijbcEjCPrAjZMLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mrsM2YSR; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mrsM2YSR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbVLYxY/ofJ/uRGfcccDIzNOPrrV2vbaYTdQ9eJgh2a461W8AIq60KwdqUXTeeBLR8WWlsse2NN3bG6agYdP4q8ZFYiL0QkObJUJSjsLyXI1eu6DfG89HM3MNP6eKnlk43hjek4qSMPP3FEAab4/S4cBlIOTywhEyKKWjmeWwn9NwLn92NOwDDjO85scoDQHyWBWL0MEeabv+KGg9envtMznU+BVdLD9IZGUGEpGaVsl0A6rX4xXI3zq9NVNPVpT/zPdq+vEy+L+Iy6QbXAwCz6U5ig/OJPe4Hd+heEoyuwFhIJNzim/BVNmtr11EF5bx0zr+cuK3vvJxkd6Sbof1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta0xxaO37yInfpkCKevb/HnfntbtFiZLgycNBNNN9pc=;
 b=QyAWaPGYn9CbG255AviGCiKv7AUGO8BkOUFVzBs0AG77I/jCniThRR248bSZejTpbcZZvEFi8FgT7+mDboo0x3FtYc0BsUpWveU6YHOIz5O4GISaeuY1G8TNU3mnNv5XyzLjchI9qCanwwiJjtQtNbAYIntwLkLfBx1J5Y5zXqxBtWGsVyZABW1V4YEFUvR8G5Bljm3XdrfZ9pAmjJcrN15LsPBM3y6UIZ2VD1ZoF0ULGuWA45I1nNrKpKWsKiZljPHfNg/d/v4/Q+K/Iqx5JkUsAIX1gwWB0g11FraseyPl4s24U6O8AvrQ31R12Yf2fWXCOPnXDuk8deeAftFGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta0xxaO37yInfpkCKevb/HnfntbtFiZLgycNBNNN9pc=;
 b=mrsM2YSRGFDPcimXcfgvNFVRC1+cdFpDBWMO4hihTzJwIP0UNU40vSHby8uVSWwaFf+dquS+oGYwBYAgIPEe8w9AHHrrxnvOQiBxT7UAdaUzDnjkxN/9mA3uwoB8eWxTiWkGNHOOKnPoG+oM+M6RMuVKrNp0+oCdRaTvdJU3QkJsGhHI+3SgP/h4GW/sHNH+zic1zTqxi4IFMSio2ZH44a499g0mSLQKJhJ4mN/TuNbDDfS2r8vf+XVzKJ+d3WvDl7TzEzkLgd96ZLjcay/5y6I8XacOmlBGV6LkKXrEcy7+MxP1y7/q63uPQSQy6vwgakjYk5UQFK7/B7jHYusNhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:28:15 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 10:28:15 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v3 0/2] device property: fix child iteration issues with
 secondary fwnodes
Date: Fri, 05 Jun 2026 18:31:16 +0800
Message-Id: <20260605-fixes_fwnode_iteration-v3-0-44c18472e1d1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSlImoC/4WNQQ7CIBBFr9KwFgNDiq0r72FMA+1gWQgNEKxpe
 ndpN7oxLt/PvDcLiRgsRnKuFhIw22i9KyAOFelH5e5I7VCYAAPJaqipsTPGzjydH7CzCYNKRaF
 aGQlDI7lgNSnyFHC/LO71Vni0Mfnw2v9kvq1/k5lTRhWHlgmjoeXtxc3TsfcPsgUzfCKSiZ8RK
 BGmUDTcNPqkvyLrur4BInejwP8AAAA=
X-Change-ID: 20260525-fixes_fwnode_iteration-baf62d861305
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780655483; l=2394;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=hGOW2vc4LqU6Xl7E0sb3cqsBWE307hXWVIP42y0EB9E=;
 b=R3Su18lLpgInV9CeyywPrNpl7s2fQhuyS7uYP5LxKR7ogdeTiI77ywNQuYQdLVjR4eiY72z5+
 g75VantxeJQCif9xjVEM573D63ZUpj1NzYGKMoF3Shy1lnn4akmAMtN
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: MA5P287CA0328.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::15) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|VE1PR04MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 8435b51e-4db4-49ab-6dea-08dec2ed2719
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
 ir4u5SLBlvRSnaVO6SzT/UrsdMsk5El8pCByD1ZUm0cPku9zlshcLqupDN8tlVSP4fwdhyoUzcO3b7kcJXUcN8+z4tDtF8TNpA3A7zUqf8DLZWlu21+8x3pK60d2vYzEtFqTPCiF+385tPNv2pl4zzo59NDOO2fQxBkzVjhyehfr2+dMM6JDWUCqq+gMLfQ/Uv1cf5UVCdF+jBaACcWX5fbUexIWuQJ7A2CRSf4KZbFejMRxzdmQ3Xris85rgRj4UmSqPT/Pj3oiPIZwUmex1XVDFOfK/qL8gJhEnPcm+1cyfM90p72rtI+54/y1E7zNcxfYMkkJzW1BZDMSgKcEkoOIdsuU3oAXsw+pAqLPtvMWyrUyHNlqY/s0JliBWynbURCLCJ9fm74a6nu+lhWYVn8zmrxm83ud5oi0zSpFn1t+X38wdb4ZG51slePqcTKbUIYSqfwVUHdNZh+3SHZnceNIKEqb2VRQPT3EL/57vLKChfrIOfDSnSsOnpprwgshjaqlNTXTXDioVOlCXktCqhSDW2rWyuzXMnMk9+/G/AXE9GagtTixRFsctqPVKel0PXw5GqaKgonBnAcz5jYUfSDvD4xSjW6pt4wuDPA6zxpPu19QUbZLitl6mkwvFKWN5Jz7rLxXtwyZwdgFe1lNmg==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWI5YUxWb21NU2R0VnYwcTIzb0dkdTFKbjlTcFFWMFVTbC9mYkZUZVVkVVlM?=
 =?utf-8?B?cXlvSE5BZHMwelhUckpDM1BSUGxhWDhIeU9Pc3MzdklkbTl0c3NoS29UWXBL?=
 =?utf-8?B?VkZDOHQzQVdqeno3a3hiR1pJTkgxbURKQjJLdUlkRkZkUDdGd0J3clhScWln?=
 =?utf-8?B?TUhna013QjZBNHloV1NPWU11YTgrdElpTXhaMkxLMWo0QXBQTEY4VWkwS1cy?=
 =?utf-8?B?UjFybXJPNFoxZlowTlozbXVnUVc3aWZmcWRlU29Vamc4OC9IS0VpVzJkbWRU?=
 =?utf-8?B?Zk5NNEtZM05qdGErSEk4N3l5Wi82bkJFK1ZwTDd3cDRLUmRLUzFIb01OdTMy?=
 =?utf-8?B?TWlKWXFacys4UGlZcFhKU2VwZkFkSk1FbEhSL0FTMHA3aEhWY3BlU0hVZDZV?=
 =?utf-8?B?OGxva21nSUJPc3dGK2IyeS9hcm1jaUFMWkVSTk0xUTNYNWxhejVlbE8xa0pB?=
 =?utf-8?B?M1BUKzNZU0xTUW1EL1ZDRzBvR0FsVmpXVnlJNnBHbnh2dXRQR2Z5QkUxUGZZ?=
 =?utf-8?B?Zk5sekM5ZkxpN1dLbXp1Zm5HWERGWEN1TWppc2tUZ0p6d2dVU3FycVZCSHBy?=
 =?utf-8?B?NG01OE92cW5HUVRIWnk3alNJQ0Z4L0pzcHVmSTFsSDBtSThCNWVjOHFGQ043?=
 =?utf-8?B?dExwMHBhcG42VFpiWWcrUjNLWkM3MEp1cVJ4QUZDbzdLclFxQ3Z6Y2h1Ti8z?=
 =?utf-8?B?SFBVdjRqbmMweXRBSXdDZUEyYTV6S2FEb3lzblo1eEhiaSs4MHVUelZHUVB1?=
 =?utf-8?B?OW4yRS81OVQ0Wi8wQVJpY3lXOWZNTUF4bFhDM0lNT1hyaXFUb0tkL1E4UEF2?=
 =?utf-8?B?ejA3Y1FqQnNsb3MrZ3JRSWN4blNkaysxRU51cEZ2YTNYOUEreWgyU29KNzJU?=
 =?utf-8?B?Mk14SzFZU1U1Mm5aQnltdWNYZTJpdkdETExja3VsMzhEOGduT3NPM2M2cFl3?=
 =?utf-8?B?dVZkaHNwVGhVci9qanpNMnJ1azA4WVFtY2JsRG1vT2tENllBMDZKdHpYUTR5?=
 =?utf-8?B?V2pMMWovc1FRdm8wOFdSRUxGbjE3YTBRODVTOHcxWENqRy9JdXFwRmk0a0l3?=
 =?utf-8?B?MklpMzV4Q3g5YmFZSXNaeWNFWnVkVGFmbTZ6L09IQ1hQNFE4NURkbHhjWmgv?=
 =?utf-8?B?UXVBUWxQV2syQlVReXB1M01Sd2ZneDc0TTMrQk55YW45L2pTMFU5TDJPWVZQ?=
 =?utf-8?B?RFFyYUI4UGRHZW1nRENoZDhyL20yem0yb3duTVJLOWFpdnIyczBKbkJIUFFF?=
 =?utf-8?B?dUhkdGZtclhVYVdYbVk0SDBodkZWUno3c2xtZ2RzSitMVU9EallhR0lpMElU?=
 =?utf-8?B?YkM1VnRvWFJrNDkyVTlVdzRWQzV3Tk0vSWZjRWx4T3VlVUkyWnZneEtZQVZW?=
 =?utf-8?B?OWE2aUhpK002bHNKK0pCVHN3TnhwNTVwaUQvSjV3TU84WkpneXY5YS9pWFJq?=
 =?utf-8?B?WW5Eck9kcTczdW56dG40d083aW5OS1N5cFZsTllBM0RDMC9sWkk2c3poeDBS?=
 =?utf-8?B?cDFKUXFOajZ6Rnl4UC9RT1pwanhEQ0diY3doS2dwT2kzQUhobytucWNjaHJL?=
 =?utf-8?B?V3ZkdGhkWkJ0Vi81N1RMcU5rRUowVUZvOW1lT0J2ZERRL2xUSEk4VTdaQzVK?=
 =?utf-8?B?ZW1ISi83NnN2STN4UVlzeE4zUVBHeE13d3lhTkJYNTdYbWZCakVRNjN5c1BG?=
 =?utf-8?B?SEhhWm1KZzQ0ajRZM09mc2J0ekdGbHMzbmQ0N3JOM2ZHS3d4Wm5kZi9WdGd2?=
 =?utf-8?B?bm54SEVTOHdJY3FiMzNmYS9xNHV6TU85QlpWZDNpSUtXZGVkTlpmS3JrRHNx?=
 =?utf-8?B?Z2h3aFZoQndmanY1YTF0R0xQRDRDNTQ2Tis1SjZTcFRZdDc2dnFmREtIYnJz?=
 =?utf-8?B?YllUU2N0S2JEeklhSkhRNzA2MmNBejVaNzNScm10Y2xUSXZsdkJDd0xHcFht?=
 =?utf-8?B?dVM3eG9IMDVwR3dGZlR0ZjhHL1FjellOaHNwc1pZTFNGbGFxTHJwNk5XYVYy?=
 =?utf-8?B?dm5iYlZPL1FFdFB6TXdzQVZqSDhOamZLV21CaC8rditRSUMzVWdERTFrTEY4?=
 =?utf-8?B?SG5sbjNqY2ZISmdXU3hoYS9MTGNxcmU1ZGJOSDJ1blB6dlNLRHcreWRPbFVI?=
 =?utf-8?B?b3daR3k1cjlQWUI0eGFIdkMvUVpLM2RtODZrN0dPKzlVWGpYR2xNQWh2aFZh?=
 =?utf-8?B?ME5oSWF0YTc1MWdVZmsxVE15K1NYaHZ5RFUzVUMxR2ZHZ1ZLM011cmpTdDMx?=
 =?utf-8?B?L2ZkRVlOS1dsUEdsYWVSVi9PS0xjYjhMbFRpeUpkb1RKaUxjaHJxN3NnNTdx?=
 =?utf-8?B?V1BQS0R4eHEzUkhTTmlmd1o5VS9HWXoxMlIraDdiMmFPODl4ZFNvbE9pWG9z?=
 =?utf-8?Q?AdwJ+1n/Zsanzg2kReE5F5BnQbBVcIDeJxnBG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8435b51e-4db4-49ab-6dea-08dec2ed2719
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:28:15.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kePdChQ54XYOI768OAb3TcohM+5Qb3E/IW3DSHJX5cdhZApgRGhb3XnAJqCjnQGTOAbwgFIvMaU+hvNA00y/joJ7bXwcL8ppCXmlEfA2wQ0RjBPjD9RF1dqpJT9I94eD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471

This series fixes two issues in the fwnode child iteration logic when
a secondary fwnode is present.

The first issue is  a refcount imbalance in software_node_get_next_child().
When a software node is used as a secondary fwnode, the iteration code may
incorrectly decrement the refcount of child nodes that do not belong to the
software node hierarchy. This results in refcount underflow and possible
use-after-free.

The second issue is an infinite loop in fwnode_for_each_child_node(), caused
by improper handling of iteration state across primary and secondary fwnodes.
When iterating over children from both primary and secondary fwnodes, the code
may incorrectly resume iteration from the primary fwnode even when the current
child belongs to the secondary, leading to repeated traversal and a loop.

Both issues are triggered when mixing different fwnode types through the
secondary mechanism, and stem from incorrect assumptions about ownership
and traversal context of child nodes.

---
Changes in v3:
- remove software node patch 
- add a kunit test case suggested by Andy Shevchenko
- Link to v2: https://patch.msgid.link/20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com

Changes in v2:
- use __free() to cleanup parent fwnode
- Link to v1: https://lore.kernel.org/r/20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com

To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Scally <djrscally@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

---
Xu Yang (2):
      device property: fix infinite loop in fwnode_for_each_child_node()
      drivers: base: test: add test cases for fwnode_for_each_child_node()

 drivers/base/property.c                 |  18 ++++-
 drivers/base/test/Kconfig               |   1 +
 drivers/base/test/property-entry-test.c | 136 ++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 3 deletions(-)
---
base-commit: b7bee4ca5688e30ca50fbc87b1b8f7eed7006c17
change-id: 20260525-fixes_fwnode_iteration-baf62d861305

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

