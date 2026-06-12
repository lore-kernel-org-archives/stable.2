Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1B78F2E;
	Fri, 12 Jun 2026 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246952; cv=fail; b=mqUFsv7aW4s2tsBNj2gnNXYSbaZ0Tb2J951umZncJlgoEAQ88joNtIXhB2mpsQiTqV9CR9P4P+c1Yr7qcWj5KgX7RSilYso/VJn85Sgo5aqWGorkVPN+Es3IKKw5RlBoTsT0HiRs2+doYtEEv8HxDnKkr2fd4Gkgw+E3ma3XI7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246952; c=relaxed/simple;
	bh=Q0YDZ7ybVBjLb1nVmTMTWgkRP0jtGXBBUpG0ZyBKyjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KCUKWiTdFh6d/WVBqXtzyKwgKPUh7TOT7rymclJRHEfx+ZB0Sx/JeLip0UWN0x4Urn7wnSEy9GyswfwysVso4di1HPym7RGEOCI4HL4qzcUmxhm+z2wyXi2NwqK5J8aWOguAEj1ytMrGxZXZrCRK4ndI9RE5eTKGLIw0bKS5lus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hTS2vmdQ; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hTS2vmdQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdS/KpltISfdX+3wENA+Lw1coQhAK6DJw5ykkad3SvHkjRJ1CAWGAhagJnps/ArZPAW8gPrH38EZO7YviQXXW9iQDTXMlaPJU+nAmFHvPp4fD1Ann9tW9qDargHqw/OY2ukCqjH6w7dJidSxtRLx2MtEgmzkSVIZhuKpXAOGQ2YOulfb7wib240pHmQDUPgHzBzo5za8D8x4QwdsChWKR7pcZjfx/5eAqB3LEApLlzxTxgvQKoaT5Au4QA+vRDYUA2VjKljXsG62heqV7ntvnhyjxUZcd8evZhsmzoDc82IaFZM5uvkgyT1PtZNq20Ui2ItgqLJQmTsEFt6e1ksesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7L3s2FXTmQgoKRK52YmPDONLXI29fOxpk5psFTWp8A=;
 b=e8139zAc0W1nvayRy8YkcSlw6xECqGgJkI6lI+jN+2RkFRTdVnOhibOohG7vOSYogL9wG14iLKWcziCRUdUwOAPNdHYWSiGZd0W6GYPXimepDgswXAcFe3nZSEkTyDMuMx25BZQjBOU2ns0JMgfm8QAoT1gLdoxUkKscZOHP6FjMJo9BSePn76krW3VZkI7UDGGJzh4bmXFoq725kEHvGEXTNNsQVjKYluDcEL0JUvs9Eu9Xg176qvvio5gMo/o8fxiW/RWTQaI87JHSeltTC+P7Lb59shhCxKgFWARE5r4YMvEfZilZMKh28Pcb8Frfi+B+Wfi7qWmPds6ov8a/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7L3s2FXTmQgoKRK52YmPDONLXI29fOxpk5psFTWp8A=;
 b=hTS2vmdQznrmW4gbDzx6lCrUhK4RurC57E5kRSKddLvVzw26Jac6phFek+TfzclzinVId3B6jQ1EzbQidqTd/AjtQcPujX4kZG++afZ963FLAiqVSfWixjXoCHf88PAaY1LkTTqQX2fYeZgA6dLuBJAu47k4jZASsBGkXLgoJ7VvuiQlXlmggpD5QD19LzI5htHIk54uCW4d++Y6N/gg9Cr8FsIi2DYIoDgaekUnaW7oaw41A5SGGVAjNZNjJrspAtX8AuVXLLRrDfFO1bviha9tagM59M9fPS3POu8Mfa8+x1jsdFNUtsfRHc/yUPNzT0H3TGLZrCIahmDClsymRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AM8PR04MB7314.eurprd04.prod.outlook.com (2603:10a6:20b:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:49:05 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:49:05 +0000
Date: Fri, 12 Jun 2026 14:47:59 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] device property: fix infinite loop in
 fwnode_for_each_child_node()
Message-ID: <7ienv6gppkiqksrwsztuiqapu6jt7zdkjyppxjta6g2te3oeit@vqflcob2oyjz>
References: <20260611203537.1786399-1-andriy.shevchenko@linux.intel.com>
 <20260611203537.1786399-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611203537.1786399-2-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: FR4P281CA0361.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::17) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AM8PR04MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cc08e1-9d89-46c4-b371-08dec84eb1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|23010399003|18002099003|22082099003|4143699003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	n/S0TSqHvRHLITxLpl4XiXWYWiohP69ZxcipzCqmEMOmPona6gm6LI3DlNhBSHxEsicA3dSJeVI+kAX5S+IwZm+cCZdAviOJVhE7kzMGhHj/R9mETYkrL1Q4Z8UNwh1yCGIvCXXjJ+EYcJdI+E0TkGPx91MYun6ZuA+4JTDZdX3yZFhTbU1k08Gk9kVJsu0GuINrXIKZErhFnm67ZwtngfKJo8tXubqh9cfTY9WSjQCFfcFqxeIcVxrlyNnylA1x/atlxDNBXP69AvP1UG6f18FpzzFFQudtq2gRmvnycQ1y2OnUQd48lS29pYCXyh3ZEj8Xo0zvJz291gOi94K58FX7q480RD4hPJBJxj3UDAFuPFaXYDWd1Tcd+r802nHcD2mqTacYsy2dPXoH6C8Nd2Vc5/Nve4iP0vdtVgg+GsXkU14taLA9PbEmbBZh4Rb03JFfvBEZvVQyz/gnEMkR4FLrdFKXJZXEtLpGSZ/x3E9vhUJdLswfO3BUN/tMCCTSB6zB1i0Kyr9oPU9iO39koksnmzWbNfgdGRwO6a53FwiEjIesLCkhvUwDrUFNqn6g5jYoJZuL2sJCgoejm7zgW1/wMnVoSGvjOnn6KC8rf6Yb2gY7HpomElvvh2G4aic3rxfvN+Jgft/A+WfYgEu5wqZy1THan4CeQsC5C1bUiWphK4KOGTbr6IYGdYlAbgHc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDdDdnBkSUVDNWRuTytEYnNwTWdnTGVrOHBxZklXRCtsaUwycXdsRkxKS2k5?=
 =?utf-8?B?QzNlSk0xZXVkSGlYTGlwUisxNG1WMVRzTjdqcUNLdUdDMDFUWFV3eHdmZW8x?=
 =?utf-8?B?V24zZHBmcFZaanRPSlFsdXN2ODQwSlhuTHk5dmhFNXJpdFJnVXhjelpVSXZl?=
 =?utf-8?B?WjRNUnpwMGtseTBrVTJYUlBQSlYrdzB0Q2loaFJDRG9CSUVhekRUSjNLdWw5?=
 =?utf-8?B?eGpHOFloYVdya0pZVTZMZS9udnp5S08xVzJNanVHUk92YUJ4TUUxaHljeTJ1?=
 =?utf-8?B?OUNnazIrcndwMTkwb0FiM1N1UnZoZmdNM2xrNldkQlQvbmxGODF5cndIQVpE?=
 =?utf-8?B?RHAwY1Z4aWg0OVZtZk5SUFRIU3RhdElnYUtrUnEvTFFDcmY2aktwbEptbm1Q?=
 =?utf-8?B?T1dKQW55eUJxUld2QXVRZUxCTUFlekZ6c2F6elRZWmpubm1NWFZWeFptU0Nm?=
 =?utf-8?B?bGFLNmJ1ZThBZVZzSWxDZzlMUjhhUS8vdWIwV1craXRkMjlRQzlBVDkxOWFI?=
 =?utf-8?B?RkhPWUNHcW9NMjRSeUNCeVBtc2hONTU4Wks0b0xZbkRQQjF5ZG4rNmJjWVFr?=
 =?utf-8?B?bWdwTTI4dmZxNmFhOU1nZE1Ob1VCL3czazJpcGwxWE1BdlJSNFFMamRZUzN4?=
 =?utf-8?B?MkF2Um5GL1hycjg3dlFIWG8xV2V3bmtVdDQvSlhvTWV3SFBqNGkyZjhScmJa?=
 =?utf-8?B?b2tvMWx4SnQvNHhpQURtaDRkRVVlNHZJN0VZaUsyeUxxcE9TcEFNWnU0N24w?=
 =?utf-8?B?RGdwS2x6dFBWZld1V0tiaTYwN2xlRVduZHlHYXRTYmRNakhwalo3MWR4YnZx?=
 =?utf-8?B?MWszSWR1eHltRExSeEtqZVRFajFJVzBPZEhBajZLaTE5RCthc2hxbFhMZWFE?=
 =?utf-8?B?OFJqYU1jbHhPWE0xcmEzcTJHOGpOYU5NUWpycmFmMkhHSUtNRG9hdERDcFVj?=
 =?utf-8?B?bG1uelVMTVRwY01Dd0ZuWlJnRnBPcS9TeVhBYXlYOGhHczA1dDVmbmRYUnhB?=
 =?utf-8?B?WHRCV0hXaXI1Mmp1QmxhQUhiYnR1UEFaempHdFNUaFEzcXBBZVEyQ0tEMVpD?=
 =?utf-8?B?VjE4SDZicEZxZkduWDZOZkVlVlpWbFdDalMwQ2xaNUprZW5adm9sang3U2s2?=
 =?utf-8?B?RldpTmlhSTcxekN4T0tRbkRKU2llZDNENFkxc0p0K3M4R3ozd0xMOFRiUytQ?=
 =?utf-8?B?eU96Sk1vZW1IVE81eXFxcUhmeW1tSk9BWkptYitReC9yRkJ2aldVV3JXZjU0?=
 =?utf-8?B?S1FYMWVzQXd2dFpDWGptaG92UGpMRXB6R2k0d0NyMFgzblVOR2xUZXBWSndN?=
 =?utf-8?B?aHJhU2NpcS9NNG9BcHlWZVRwTHFmNy9La2Q2b0c0dDgrTXdQZzVHWXZLTW1R?=
 =?utf-8?B?dlNYaythejg2NXJHYWhFRTBHa3RGVGR1Zy9UMnowaTFoaU9LUXR3OWVaeUJ2?=
 =?utf-8?B?WFNNTytTcU9MNHpKNGtKYXp2WGJqYThvaGc2cU4zeUlDanVCQWkzdWpiSmlC?=
 =?utf-8?B?VmhaN3NsRXE5ZFBXanFpaHUzNnFUTFZtVENZdHpDcWpFWXJBekVwVFdGMDdN?=
 =?utf-8?B?amtIN011czYzTnV1VVh2NWZmbkpCUWNGQTRBTU1MNlZPVXBGZTVDS1pDYmlK?=
 =?utf-8?B?MUxvVUlHR2dNUnpCV3NWT01KMjJRM3ZtRUQyNTU2RFhlZ3Y2N3VKdmNONS9p?=
 =?utf-8?B?Y2R2QnRtMVF4anFES25aTFVzMHdBNFRPdEJCVVE2M2ZxRllzN1hJclptQUh3?=
 =?utf-8?B?YmFqVlQyaVU2cEZSSytPaUJicXlDdDA4Mzh2TC9QM2g5RUdPajR1MkRhWXkr?=
 =?utf-8?B?S2Y2eE5jWVNpOUU2YWNZeUFWU2xteEE4TkwxRTNHcHpXbEw3TlNKd3FZc001?=
 =?utf-8?B?WW1aRUo4blRWLyt0cVRXTW83OG9XRFdJdncwWjVJeXUwTUJqSCtpdmNhMkhD?=
 =?utf-8?B?bFFpTDdjaWYrME45cWo0c2ZPeXU5M1VTbkRHWUVkWVhIL1YxL04yT05yTHdu?=
 =?utf-8?B?L0ZaUVZXcXNldE5WNjVxZmNocEhsbUw3VUQ1WkVDdVBRSTAzV2UxOUVIV3RL?=
 =?utf-8?B?SDI1YUsyNFRmTk5Ua2FsL2xXQ2ZtZExxZmk1VkdXS3NtQ3ZKRHFKMUxLcndC?=
 =?utf-8?B?ZStmYTRRVVB5U0VBdG5BRzBCT0Y5TSs0dTUrbjIxRVNnczFScDNqbU51KzIz?=
 =?utf-8?B?YjN1UVJFd2RWY2VybllPcDlYZHN6dzh4YkhHUkl1SlhhVWJ5djQ0elNDemlk?=
 =?utf-8?B?V0ZvMHZCKzNYTnZlVDBkUjVpVDFuRUMrckNuZWt2dWRhKzFIU0hhNFRhazJB?=
 =?utf-8?B?NXJVRDFNdVRkMUMzSnVhZ2VXRk9RM04xMHdiVWJVV2N2SHVqTHVNaWJ3djgx?=
 =?utf-8?Q?/2J5Qn9VY5eX+4G+CuJUMaKKcOs2/1BUe5lXW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cc08e1-9d89-46c4-b371-08dec84eb1f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:49:05.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn293Mm/dIbvl/wpYFW9Z3k19BxcWV5JeESIYuohgVrI522OuoqqerfH7CvqZwi6nzB0Ll/vOrW8tMe/Yx30p6S94TcG9mCp7DtcbsliKswmbfTDAWGsX1MDpE2kVYgJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7314

On Thu, Jun 11, 2026 at 10:31:06PM +0200, Andy Shevchenko wrote:
> From: Xu Yang <xu.yang_2@nxp.com>
> 
> When iterate over children of a fwnode that has a secondary fwnode,
> fwnode_get_next_child_node() can enter an infinite loop if the secondary
> fwnode has more than one child.
> 
>                        Parent        Child
>       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
>     (Secondary fwnode)   FWb:   {FWb1, FWb2}
> 
> In this case:
> 
>  ┌─> fwnode_get_next_child_node(FWa, FWa1)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
>  │
>  │   ...
>  │
>  │   fwnode_get_next_child_node(FWa, FWa3)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
>  │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
>  │
>  │   fwnode_get_next_child_node(FWa, FWb1)
>  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
>  └────┘
> 
> This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
> output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
> 
> The root cause is that when the current child (FWb1) belongs to the
> secondary fwnode, calling get_next_child_node() on the parimary fwnode
> incorrectly returns the first child (FWa1) again instead of NULL.
> 
> Fix this by dynamically checking the parent fwnode of the current child
> before calling get_next_child_node(). This approach follows the pattern
> established in commit b5b41ab6b0c1 ("device property: Check
> fwnode->secondary in fwnode_graph_get_next_endpoint()").
> 
> Fixes: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Xu Yang <xu.yang_2@nxp.com>

Thanks,
Xu Yang

> ---
>  drivers/base/property.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 8e0148a37fff..f7b30d9c8716 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -807,18 +807,31 @@ struct fwnode_handle *
>  fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
>  			   struct fwnode_handle *child)
>  {
> +	const struct fwnode_handle *parent;
> +	struct fwnode_handle *child_parent __free(fwnode_handle) = NULL;
>  	struct fwnode_handle *next;
>  
> -	if (IS_ERR_OR_NULL(fwnode))
> +	/*
> +	 * If this function is in a loop and the previous iteration returned
> +	 * an child from fwnode->secondary, then we need to use the secondary
> +	 * as parent rather than @fwnode.
> +	 */
> +	if (child) {
> +		child_parent = fwnode_get_parent(child);
> +		parent = child_parent;
> +	} else {
> +		parent = fwnode;
> +	}
> +	if (IS_ERR_OR_NULL(parent))
>  		return NULL;
>  
>  	/* Try to find a child in primary fwnode */
> -	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
> +	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
>  	if (next)
>  		return next;
>  
>  	/* When no more children in primary, continue with secondary */
> -	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
> +	return fwnode_get_next_child_node(parent->secondary, NULL);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
>  
> -- 
> 2.50.1
> 
