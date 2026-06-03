Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D6E30C162;
	Wed,  3 Jun 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456824; cv=fail; b=jxxaWRtsOGszjE8ekb+Lya0FWcF4VlMGebHWGpU23ngB/2iWkNQrGu6mwDmR1Q39qAd52lKwcyb7gd7YN6+sAXJZ+pz0q40w7QoS+VEyw0vSmD9gDpL9Tdhminhd4Ji6rJ0yxBiOYoK21iv7yje3RJ5HNuMmbaiDNem9hWxKLKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456824; c=relaxed/simple;
	bh=iOMmKwGMg78d3IsTMgmU8Dx8sUOLqtKKQtk1QWQodWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bl1BPwg1FxITxCw2qmUTgbGvN9GUzyU5uhJa1+IvZ9g144PtJQ3yc6iDxGJNFmoIfhMeW73Nb47MBjUT5dVLVSdSMTs5LmWty7ZMSOtcbaZmJp/UNPVpLmABsliqWWiW80LmD8rFJlR7ua9Nd40QmuOsAqPQ+cjj9d2fk+dx6cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DCbOrn+Z; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DCbOrn+Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3X5orr1hO/DRjzUVJMyIhCAQddPjwkyRy+693TEBYBepM224eJFKplnyOA0vXMPUdrwINf8G/0BFU+j3ifYGArKpXTrePBwiKL5ezNYyBKoccKN7fCSZjoyZ7dsILETTDdUEwZSIvfByUbyTDmag9c2oEakgMAiT4o25+K6o2UUIfsKt7T9mocNntDkJv9kZpcc0cvBSwGNigOR4CvEnScMXYGqPAF08cxjhvNiBCZdxecTT3RPLaN8iX8nLRuUz3jiT2cM83EZuU9mRPKIVKHlMkKADU+51sEMMrHSdLBm1BP7QxGOOga701ByY3bBX8Hcx7g8Z2cCdA2WqaQ/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3+wNMs4WTw7lwLNwzn4gkVQa5VFZbZv6kK7IJkScTc=;
 b=lqDDxYWGP/+qngP1VeeJV2ttTUxMhjs3x3ZS3WiVtnnkEjN56gMb7E/j/P/P8X1q6aPDY+whFrlyoRH6my/b/gA0qu3rjijdpRGwkjUrUYrdPWwnYypUnZEq6i0sPl1oWFZIKRDzdeRdYh2lP/Akr2wyYp9radVRJEdhIlpLh3gSQfwrOFGG1+EFraoFHCilftJeSNpzN0ub0UCBgfkBGl51sSAHGJBUVkZVI/mCmY80913ZlrPxoEpKkP/mvNZSt8NQaM1+DlU7mPzGFEevKiZJ+SKSvt75R2LTMROOC3bFAij6obFamY/RR8a15AoqbZatTT/eN5/k71ypS3F9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3+wNMs4WTw7lwLNwzn4gkVQa5VFZbZv6kK7IJkScTc=;
 b=DCbOrn+Z1pKdLM6YniAUSdM9FvkzrRkYThKge2odXNa15/pG0rFAH6KuPDaCtiKZRgEd432y2zIy4BZumijBwX78574xuKaWKcMgOC17A4bc9WH2vlKsbn1hHKejnemoBRI4QOpZnMEu3GFsZPqg+ALZhNZnVe8To8Wze1PYFbA7yg8/t6Zqr0lp8x4D4qGBqxydR3gWFf0RyPBxuCGzhjNqWxiVb61IkMqa0tHY1iMED7k0QMcNvLYZpPHc03moCl6aKWmDbAI+8yD2eMgszSCEel+wT2thx94ET5g3uUJL7tOnyx0h+DeAX31g3nn3BvuLy0cHUR+PLk+HuysEAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AS8PR04MB9064.eurprd04.prod.outlook.com (2603:10a6:20b:447::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 03:20:19 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 03:20:19 +0000
Date: Wed, 3 Jun 2026 11:19:16 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Message-ID: <cycl4uyuoxx4cyhkq3dv4jvzorpjqasfo6fuatfglvloztwuol@ppu7ywx2nvbs>
References: <20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com>
 <20260525-fixes_fwnode_iteration-v1-2-a12903fb2919@nxp.com>
 <ah91lJp-PNkyB11n@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah91lJp-PNkyB11n@ashevche-desk.local>
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AS8PR04MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc54be5-947c-460b-833d-08dec11f0a25
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 jg+H3wSQQ7X0y89i/fiYDM3oX/MH7WY3g4wCIrrb6b6V6L65FG8i7DDTTEYtVYZoMh+ItDcPqrlh3jvDaXC/kcsv4pGZ/50p0CEqJC4TQGj1NAmE3dcK2+2CMQJIu3g9edrtex3zja9JXkawUoNeW32RjFvTyXrdmjQaXKAWvIh/W1OV39vo4+b5nVEo+EJmKt/ZY8cJvt7OORIoJ3onAvE8c19Ac3+GOqE037EeuHYP4aEdtNRUvp5M3gpUvjZva4ufYBg2IvblQo9x7DPC4pnse5fSNwShLEIFBzWzFcTCP+hTrWg7JuVl0UDPAhACMMLkAe32gJ5WKTgtotyTH0i7EbjTEZIAVvYU81irtIV0d5PcH6d0AubY61xvMxoGE1ubpFT9m4vyzdmURm0rapE8sZ+bfHq/bMpR+UPmaQHp5IeQEiJBaylRGsEW97kBKuIJnxSSiTvVy8BGHUmNwNxPserzPkzYLADiKijnUOOpQkN6l5fNTE1eZH/1A7b4EPwkuSiWjYhXfmhpWYs+6yzUQdxvcpm0qgcKhrpDAeA9lzmUnWVRBPl//LsVmmNEN7YIQY4M7I0I2H+mXQ66l4/yFcLVl7gM8lFvuYNHj/OfoB7hB9x5vLnLgJWr+0/ACFBs5KHZuDffwVZ+2KC+cOCt2mHeOSGbYEw+9xse2JO8TMdnP28Pjd7Q6jtgALTj
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VG95WnlQUXMvazZDdUFnTWtWcUlnVzdDNm1BdDZoME9kK1IwaTV4eXNOS2RE?=
 =?utf-8?B?bCtSNXphNCtMRklEVWZZQ3FjRkkwcEU4c05CanpiMlhlekNUdTRZMHdYQ1hP?=
 =?utf-8?B?Z0Z4a0J1S2JuZ3FnaklmT0Y4a2xNbk5xSHNGdFlxbmJQVnorRXJwQ1pnTnJ3?=
 =?utf-8?B?Kzk5ZGlKRFBoSFZYekdjV2lTWVpmZ2pmM3FKYmJBbldNZG5WbE9jOUExdTBy?=
 =?utf-8?B?UHFwd2I0WWE4ZWM4MnBjUHBwajFzSlQ3bmdEaSt2Znl3elVCaVV4WXFiOURh?=
 =?utf-8?B?Yk54VEVyYmJyYTRPR1F1V1RUczd0RGtUaWlRRVNIblZnTnIyMThNWVdwOWxy?=
 =?utf-8?B?SU82dFlzbGJWQ094cFBlOUNnbjY4OFZlL0M0N1pGVTNvb211NDRTTkUwMjEy?=
 =?utf-8?B?R1JweHlLQytIUGRoanFyaTc4RUNMSWRMdkJoU1ZuaU16MEhjOUhMTTE3ZTFW?=
 =?utf-8?B?NDZnYllJTUl6dTI2TytCa2tpNStOcG1rM0pPU2xiRXJGeEVnNFFQelQ0b1Qz?=
 =?utf-8?B?S25teU5hQSs1TkFqTEUycGFLMGZFek9MUkg5S2VPNG9YV21iUmFmUlFMVENY?=
 =?utf-8?B?OVlsSTRPenBDVytWdG5YTW9FRFpOWG85VmZwVzMvYW1mV2hZWCtyYVRnd2Yv?=
 =?utf-8?B?RnRpc2M4b1crNXptRXBseWFQdmE3dHpkdUUwcFNiMVZFZ3RZYmFaK29DcEVZ?=
 =?utf-8?B?aUt0UFBmNWt3VG5sb01maVBZbHJrSy9WaDRPZUdyMHZxbmh1RkV3eG5uelFt?=
 =?utf-8?B?OW5Bc1NFd2hibkZTY1dOT1VwYnV5cmhhQjZ5SHZBOFdTYUw3cWpXTG5aOXFW?=
 =?utf-8?B?bUNna2tZR3hIK0VNSER3bys4KzB2UU5RSWlJL0lDM1Z1Q3djRnhiYktoclpo?=
 =?utf-8?B?djE3QXRFTkZtRnB0V0FHVi9HMWpQMzNHUkRNSjVvV2lzNFpaUGU0eUFrMnE5?=
 =?utf-8?B?NFFlYTNzOHRHaGdnN0RSMkN3OFJ2UlhxbDlnTlpqRXRBRTc5NVFReVZ1SFBr?=
 =?utf-8?B?a3NJOGlHTGo0bUM5QU9mWjYrMTNVMHZzZGdNeDRpbWJZc0Y3S05QS2lLa0Zh?=
 =?utf-8?B?cGtmQkFtZ25nei95UUZnNzVKdVc2ZVRSWnMzbmg3ZlhwWWIzRXk4bjc3WlhM?=
 =?utf-8?B?b2JoanJmbVB5bHJoVTFmdnZ2WjZwalZ1azRiNnY0TFVtVmRPUmhKMmJ4b3E4?=
 =?utf-8?B?VFdSUEtVNXJPL1VGRFo3bjEyOCsrZ0hIN3psVTIrajNzaVNOYkxLTFNieEx1?=
 =?utf-8?B?MnhmMHJyazhmVnc4WHFuampnRzRDQWxxdmFaOFpuTlNjYkIrQnBOb1ZtSndO?=
 =?utf-8?B?Wm91LzRGQ3pGTEFQU3FoVHQ2WVg0SmZWSEhXUnBwcjVMczA3STViazhkNmUr?=
 =?utf-8?B?dkxVOFNkd3FEWVppVTV2WW95VlUwMklFSXJwNm9QalpOWW9yakVQTkx3Q0xy?=
 =?utf-8?B?M3h6ZTRNcGppVUF0UUZrSU9WOWVySXd3ZThMQjVJeUFSWmFuWlg4K3ZzUjZF?=
 =?utf-8?B?QlM4YWVvbTllN25QQVkvN0lOREpWQXR6ZTE2am1PSDc3UWw1MC8zeWlrWFFS?=
 =?utf-8?B?QXR4NG9nNnZxaGw4T2prWUVRKzBUZlAwNCtiWnhDWWphdFBZQ0tVTklvbStP?=
 =?utf-8?B?L1R1OG5Bc3gvbklGa21tZ1Y0bVZvaEhMYU1BejBGa0F4YklubVlzaUcwR1Vl?=
 =?utf-8?B?ajdhaXlkZXNhVm9McEtTbVZ2RllRNzRGbXIra242RC9EVnNwbm1GYXQwRzJO?=
 =?utf-8?B?ZGVOa2VuWHBJSjdac1FjMFNWR0VUbzJTNURwaUlwZ25hTkFmYUx3bDZMb3Q4?=
 =?utf-8?B?TEFWc0RSSkVLYURsUFpKVXh5QnFkNENEbEhqREJWNXF1L3pEZ2ZjVnVHMCs5?=
 =?utf-8?B?QysyR0NndEZjdXR1TzVMYnBpRlFuWHFxend1eEZEclFOT3FQSk1QR3dYV29l?=
 =?utf-8?B?RXJXYmxONGNEVmNFdGhiUzhQN1YxaFprYWZ4eUlKZzJtaEM4d3VSQTZFbk5R?=
 =?utf-8?B?MGtXWTh1Q0d2Vk9yWDhLZ0c5ZU1xeXRUR1VZc25ONEZERHc4ZEY2R3gvdm1K?=
 =?utf-8?B?WjBRZFpVZjlYNEtOeXJCdlErcnF3dE1OR2RoM3dqcXUzNWNWdEQrMkM1dmlG?=
 =?utf-8?B?eE9SKzlzME5sbnBhcHBWNjRnZkNRRUVhbnZYOU5acGF4Y1pBKzVDMmtRdVh3?=
 =?utf-8?B?ZjdHRkVyV2x4RDJid1dMQTN4a2pCOERjeWdFb2RWMHhscHNPckhSd09jcGhZ?=
 =?utf-8?B?eU1vTitTb1g1SHpZUWdYTzZ4TjRSamtQWS9QeE5LRDZncnNrUFR0Z3MyZUgw?=
 =?utf-8?B?L1g4TXc3ZjhWMFY1SHhDRGFJL3E0LzI3b2djTG5iZWpNcWttN1VmK3dkUWNn?=
 =?utf-8?Q?ZpSOPN1k5wxbBpqqNyqsMENirwXBfl9bhuGRx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc54be5-947c-460b-833d-08dec11f0a25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 03:20:19.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtkkYQGSAI3AtHpu2T0bEAg0d3/FN6WP601BF8w93yyUyNKAPqzneHrWhVvhOs/stHcU986yvMdX7tAWBULqPQYyowPtOWGtSbVluc4IcqGguLFVe2qDZFzVrDD8+4fb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9064

On Wed, Jun 03, 2026 at 03:30:12AM +0300, Andy Shevchenko wrote:
> On Mon, May 25, 2026 at 02:09:20PM +0800, Xu Yang wrote:
> > When iterate over children of a fwnode that has a secondary fwnode,
> > fwnode_get_next_child_node() can enter an infinite loop if the secondary
> > fwnode has more than one child.
> > 
> >                        Parent        Child
> >       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
> >     (Secondary fwnode)   FWb:   {FWb1, FWb2}
> > 
> > In this case:
> > 
> >  ┌─> fwnode_get_next_child_node(FWa, FWa1)
> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
> >  │
> >  │   ...
> >  │
> >  │   fwnode_get_next_child_node(FWa, FWa3)
> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
> >  │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
> >  │
> >  │   fwnode_get_next_child_node(FWa, FWb1)
> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
> >  └────┘
> > 
> > This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
> > output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
> > 
> > The root cause is that when the current child (FWb1) belongs to the
> > secondary fwnode, calling get_next_child_node() on the parimary fwnode
> > incorrectly returns the first child (FWa1) again instead of NULL.
> > 
> > Fix this by dynamically checking the parent fwnode of the current child
> > before calling get_next_child_node(). This approach follows the pattern
> > established in commit b5b41ab6b0c1 ("device property: Check
> > fwnode->secondary in fwnode_graph_get_next_endpoint()").
> 
> ...
> 
> Can we utilise __free() instead?

Sure. Will add it in v2.

Thanks,
Xu Yang
