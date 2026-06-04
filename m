Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6184C97;
	Thu,  4 Jun 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570787; cv=fail; b=oj52e+ea2lswfKZp6buX0Fii5hLU1BYgYcHDifuYkapSeOtXbaoqeLYHCjR3NPXHYFSrwxowSkyPbfznvZczu4U/hMQz30uyV6ZQLZ/IX7DzoWV/jwd+5ZUqDwpmHOryab9PS2hr9R6jA4WHpEFO0lW6E8eJe59Xh2uc2LzXpug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570787; c=relaxed/simple;
	bh=TbMkSYwdJfj/9Ozkh+EFXkbKnFZa2j+ZfgB3GPhL/bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5lIP/O5vYOyrtaj4cAEzJGSxdUSHiyPYdnZSjWTip/vuIaq/gO59BIzsFh5zMS51Z/cZMl2zTRZ5bWLThfuvZPGlBh9OznLZss5GAWqQ+bmGOPBQWgQdhxlqCkPDk8o2VTgy7d4VSsbDDRhibNtrStcdDZxNxPOsxowV6LA2TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gJAuX8fS; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gJAuX8fS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+mxofohGUUq0xFUpeJBVA6IX9GjSUZtWgJAtenm7y6A2x7ea1XoHuAAtePVwusabrg7XBPHSpNJczpAMmuJfBQ41rkYkomKcYmi4R08V9An3jPlpgPBMMwtQZA1PjaTe5EaohWR8lCa8tqEPwdh5B1g3UZ7Vrm0UC9uRFC/CAQSOuA6jnVxdF559RDMIh9sl8dp2xSDCZKnVwUf7N7ioyvfNOra9ILgM76M+Ayl+PHCySNV5xtl3FCejuMI9DnORgup+AnX5E2cJzCrTGV/7ds1tr0xIY8/TfBn4HeRlTNlp0HVrmyYHQXI/YuJpLegY5hPRT3xl05zyj4XZyenHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWZsxl7CXALoPCZLYErcHpAoAvxXkiQ96eyHH8Nx8hI=;
 b=Ss4jQCgqixkJBjbjEe3xUeM1KHtNtRw13mN7oxeAMHjfombpKMuuSmOXdk4eM8hPClMoxgNvpHPi0ZxkfG5u8g43MYx3z3hTPmSW0HvA3bAfmv6gILaY5XKoW8e5gaUV16t8nfgJMFKQjpcrLkc5uhWDJJpnnZleMOP/vWAf6miavuTuMI/FsbrU9OVgwvszmKwFHzgjSgAQPJihqey9ajxeIJnlOy+vl2OcUoD8qaz2VtbLFPQFCOrVYegc6gkHYgThEX0tFkzimvhnNKeFHvfalxiiOTsZuKl340mNeQgKay6PACSk2mxnCU2TuZzN1u3wvH5JipFwHQJfWjt1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWZsxl7CXALoPCZLYErcHpAoAvxXkiQ96eyHH8Nx8hI=;
 b=gJAuX8fS4TrJyD8AfTlH9z2ievdxEf4kXSq4pdbVkI/aOWBmSArfmukQwGwBhI8KS6UifVC8yqvo8M5LoY1cBa8DvrNZn3LFoQPPhU/n7ymQlLcR8V3KWBIVEnYL35cLaVTetH7sDiSY9ZMx3jEFJz61L7VvSosiGt86C9+sfKenHzrKgxnzq5yeyLEeudq1Xww7DRAVU9l1d0Pq0FO6xkxl/RkqXsRAymzCpV2DTs8uASoRIRRYxtiFgySESgMqfTvtl4aTJKqMV4Fvc4B+WEectcVoxZ9XMsoE68WI6aRxZAxnMJl3qyb2x/cNbe6/BIHFf/dTIafTWWLd4JX3/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by DB9PR04MB9724.eurprd04.prod.outlook.com (2603:10a6:10:4c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 10:59:43 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:59:43 +0000
Date: Thu, 4 Jun 2026 18:58:41 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] device property: fix child iteration issues with
 secondary fwnodes
Message-ID: <6j2yk2x23mmtr2xbwkp3ind76qyy3mu7y23psseqqvbjlqepld@n4nsvswt2euz>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <ah_3KmASlE44X4Xw@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_3KmASlE44X4Xw@ashevche-desk.local>
X-ClientProxiedBy: FR4P281CA0365.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::8) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|DB9PR04MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: abbef28f-c1b0-4539-ac64-08dec22861dc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
 g8u5FTPksBCQUMVZHlG0yBQ9h+NX0eHqsYEicsnXdcJbo7BLiCRQIxpO+zLJUx4uRzYtoRZ6HHLBGg2lDjKEGuKf8hbgaqLhUm8EQdT3wf2m7bJPk9WQnNgE7Fa1sPR48gekKenhh8urcWt57RQIqz4oPCYNQ2wFp/82Cp8kFHTJsAKEPJikH80O0HKQ78BvLF7EkocN1fmDgix8y/QdHh+pM3wu5L2xLPsxgiR+C5hf1ADzwIfbjaLc07Dz7AMhABzK4DjW3Hx7+yCv/LHx+BD3oYwpnGQkb4DLxU2hW2J1y/tQCkiY05X6oKrITNal0lOjdEdZ4jw0cBZRfLs6xsbUGCNqKYdqaG9rougPvIM+JI3hT5Txev7dUmmODjQBwHw8BF/qPSGkLBQu4Y2Z8n+xNj6jDRg/ewshr9z/xLP4fNyGJkCMl5plviQINiDKP2pqPdaH/a+5nwOhWus/d1XGHpAKbBc+HC7XVwrpX4NasMAeQaPErbKVbbBxzcmaCjqzBOMchGUj2QPg8Kk8YLz3Eh1VjfG5o6tzcFUjc+8TrWQfb9IJ+9BTQtgJ2IvSdwdpxJYyLzcljl3TnM9yxmAiCBSP34AOTiqnDxUhqm3mF8j6XtZNGjB7nRXbYgAXGS4Sp7mexqIYsMdDhoPpgsrpknRt70FtAZML81xBWnz+ppuueM90ZU2ue9ZP7eyn
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jA8EZ80TLTt9YdMPNF4O9KEsx+ZjD8d3V1i+w7AV0lbC+9bJyNoztTIR/kbK?=
 =?us-ascii?Q?dy0XdnFpMFgQi6SWhrkk8GRCshEbnP9xGvb2ZCVPormuRsvwWjDdWSB/ZoaY?=
 =?us-ascii?Q?/IZ9JZJFQAtzDSj43lGyjKK1GC+KbjqL46F4ha347wpzICaufV6xLp+OpNbJ?=
 =?us-ascii?Q?8WRTMwHZduQCdtLhf8m7cki8eDBn9Bk9vqevk5QAACbFdbt0qDIh9pcCx2T0?=
 =?us-ascii?Q?NJxrst7PbGqNUKZuel7Vcw0OCqWyoFLy5H/LBXuFhwBsozflMwupxSifPIIL?=
 =?us-ascii?Q?ecWjUdQa2qm4n5SSghcAGh3ELYii5sySK68/Vm05a65WfaHb7JtFZo9BLlFD?=
 =?us-ascii?Q?gyQGTMglVe6jkVEZ2qvYpJ3OYOlQ6yo9sqjKw7v7BywQ36WTPnZ0A9SVLnlX?=
 =?us-ascii?Q?Bj2+5cJR+VcVmIck4ikQPz9mhjEnDobx8FP7v0hJyu+VD5ifmVPriB3ZY16k?=
 =?us-ascii?Q?xxsna+n9a2Y0+rg+9hQMszN4bXjQv/zEPspf5cuRc4YZI4ud7BuuhOcJyD9l?=
 =?us-ascii?Q?Iz20mOv265QtzNgOxlTv/i212wv5PmS9HqLVhzzTtEsKNeJ5xI3D1RwIzN5Q?=
 =?us-ascii?Q?APJ0qVSAo6aUrU6fFTwBT/wWKx7aq7VjwjbSptr1bjj4Q2/HHizVFL0I/+P8?=
 =?us-ascii?Q?mw9QC91KJw3U3vMZs6cM2vM0kBKLe/jWkKU0X6Fm7aK3sSKbIvKDR25ICBly?=
 =?us-ascii?Q?EGUJaigeUvli4n1Yr4sZziblZYwp2kLfVjeJBqOyQ+liFw37/lTY8QzhrMK7?=
 =?us-ascii?Q?+0jueeVCWABdGOGEoD3M/XfP8ywFEBOCaIMubpEygVdTjSAUdD0IMmqVKDDs?=
 =?us-ascii?Q?csgdxJC0JadzhupBt5joN9UIqxkpBTn/GUnJ61D9M6A3R5lLiNSMze0S4QFI?=
 =?us-ascii?Q?iLK0aPnphruMKvgAJjnwgIHEXkepoy6JqpJwErR2Cn0A3Lvmo5jRGDcwgxkj?=
 =?us-ascii?Q?S6iqOdXz0m250pFUo9ZLhjcXiFOFm1cRJXlsSVIcbN2EkfyO3Du5q5DoZF0k?=
 =?us-ascii?Q?89rUB7aIcVcebSpMIjmgodE60jQweGfOAlLiOS1EcoxNjeSS3zWVVkv+ofiz?=
 =?us-ascii?Q?+19fnxU86jEJEgExlylMUgP1tBsECzv4ppsrMqvStGE9wcGaArADLUDNi9GW?=
 =?us-ascii?Q?10+IEjdpWZzoycNncrHo0CQOKfWtl3LKFhdiwQd5XVMv1LqlTSgVjwP6Hyfr?=
 =?us-ascii?Q?hIymYUclOsNbVoyMdSyvVsQJBmV5za/ZxQratHGmULhdtNGi/uizgOIHAMYg?=
 =?us-ascii?Q?MaPQ/uXAboECo5a4WojshY7v2WRgoBNwjdykuNqkUr874xqsJCJ7qidd0+2g?=
 =?us-ascii?Q?snJfeNEj/rKKRapXF9u42yIUbdHRk8RoozSXdZ9Oz+tcFiRXcigzS+emF8TM?=
 =?us-ascii?Q?O+CHWNwovyC0j/nVQYIvTnF6cJP1d/3/eIuSWWxDOp2/pVOnAaTFF7JZ2cd7?=
 =?us-ascii?Q?yujo0fpoLNfYlKUdJVFYosBHNTbtKl3K4aOUFAF+lR+SGcmLGu+yp/AWMmV0?=
 =?us-ascii?Q?QpGogDwOZ/3AovcxxJWbJFhlTCENIOcXvqlrBYHpuyCTYRNdPGtxWGuNb4xD?=
 =?us-ascii?Q?bo1uTHhpEe2Sn3fri2vSi8TFfCcWpOay0kR67SJQYm1uSt6WQzd1qwVjNUnq?=
 =?us-ascii?Q?xyAWPWsiuN3yLk4DqVdZDlOWh/4wMOsHCc1hB1ncOCjUXOaiVOmj7OcAiZwG?=
 =?us-ascii?Q?yjblWpGcFYjC985Pan/vg5mxny3+uL91ffbPHlDIe+FskzBay9rTRi3yZ7f6?=
 =?us-ascii?Q?eNZDoI2HRGXE6mdX/PO/Ky22KfPhx1xrjIHKcHAWBKO721V0onVO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbef28f-c1b0-4539-ac64-08dec22861dc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:59:43.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+/qfylh7ZVc5uwMy6jjEjCf6RByMPqGhCTVm3yJQmjn/CEq6eMGFZp676yYW9/1vo69IyES/jRijhEU8DhZjNmZSOPdxDBngdGkOyvSzVfz82jM+oXiAEXE+AJbKsSu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9724

On Wed, Jun 03, 2026 at 12:43:06PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 04:44:30PM +0800, Xu Yang wrote:
> > This series fixes two issues in the fwnode child iteration logic when
> > a secondary fwnode is present.
> > 
> > The first patch addresses a refcount imbalance in
> > software_node_get_next_child(). When a software node is used as a
> > secondary fwnode, the iteration code may incorrectly decrement the
> > refcount of child nodes that do not belong to the software node
> > hierarchy. This results in refcount underflow and possible use-after-free.
> > 
> > The second patch fixes an infinite loop in
> > fwnode_for_each_child_node(), caused by improper handling of iteration
> > state across primary and secondary fwnodes. When iterating over children
> > from both primary and secondary fwnodes, the code may incorrectly
> > resume iteration from the primary fwnode even when the current child
> > belongs to the secondary, leading to repeated traversal and a loop.
> > 
> > Both issues are triggered when mixing different fwnode types through the
> > secondary mechanism, and stem from incorrect assumptions about ownership
> > and traversal context of child nodes.
> 
> Please, Cc Bart who is heavily working on software nodes these days.

Ah, the Cc list is generated by B4. Will Cc Bart in the future.

Thanks,
Xu Yang
