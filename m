Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583183112BC;
	Thu,  4 Jun 2026 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586567; cv=fail; b=J+FvHJweuFo4qPlkBAN9276DlQSAdU6+BgJk63ili/nQHRaoo4RGbxZ6YpSgDTlFQrkdX2wxKNkfMla6R+WEXeZh9naFdLCEA0ObZqBqO6b813jxCSLsy/C516YDd//cKgQ4FOgzgQTXNk5/O8BWCZIAJN3DkP/lxHjga8EPud8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586567; c=relaxed/simple;
	bh=mHd9YEhRRlOzxShcomAanDfb7gyMpRRo7y8S6g9LaSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AXThrdlktbBioSqyN6EmHBubXwgOlggWkGIi3Vfbk5lNpCRo9K82julebtO5gBFBX7+wo4+zj2u/L2P2MR2ayoX1cE5Gk68HKxMD7HkNWUdSIANO9CEVu5zcGPmJFf0Oq3y0BY0r3n1guwaFLVwSAHpI9zeRF6Sd4ADqQB0EoXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rz4mhFni; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rz4mhFni"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMHnqgJnFpCIYpe36Emqm4Exee/1nSvoM1XIWv+a/KNkGgRP0BQuyAZdtv995SA62BAHepDXkgFBWclXRPLRO5utxyb1QTsbhaRATH4PhDBxjRm1bsCbOLUh2p+Uwbux5d6rrZHN2VyBVsJcTQH/9ZktsWWPu/uVYdNtgoa6KA7D4miufzT4p/CYcQOF/0mOWWQGhQud4zKwCAqGY7P9Y5biQiMHlX/8j0a5oQPdsSu4ZURbDOsaq56s1bF3zPyVhQLuE4TcCnKRWDhRgBnOWqfDgcw1Jvkhl6qAJWbLbLL1kRLyUX89jula9e5Jk4AE8+jZQ1HJL7958KGz7b+4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CLHKDjyG7xXNQ3uJdukg5xiQokKOtbGTdOPO1LWpG4=;
 b=YMsqPvwrjwqIyxXnF/YXbIFy87OuHxDIJpbRqEz3tAUm+B5ZRdrB7mG9LPnX2/5GcwYMjQXK34lJHDL0NtHd8xtGsd0ZTyT3JD03gKfqHPQWZH6X+SXL11v0Ju+e3TiY9jRR/uVdqVkFAOtxvG/X2embUl7ankWYjBXhu/ujsHpj+aJsef0qBY0TudbH9PDqhquRqvz7YBALMKN8iNTOJMBZEgXKLMB9TP2wvsFG7JthOdzXzOAFvY0uw05z9h3IcngO/lQilfUqM1EbD29opS2F3eNfzggWPL2hSfl31dSTfkA4zJfiW0grsoTY0lnFVRXKGWcM3Ur63JxNNVDNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CLHKDjyG7xXNQ3uJdukg5xiQokKOtbGTdOPO1LWpG4=;
 b=rz4mhFni8o30bvLTQ3dZcNAyITUielmcspAZV1ZBRTcSPZmsg4c7x62w9fiG9zL6EZlcsu+/jGCK7+WO0mTk40HRaqo1r0YEfMhSy5jpjvmn79sP03k9hpGLgvszwFp4YsuwDen71uJGVuDRzw71ILiovSkFz0GAe3qWQagxuaF/7HYla/9hqEKPfAXzVSb/a7s+CooKAV5IlCkULPDiNaWwjG9UaLJ5qp/LCVG+AHDyMJr9npyYGxZcj6vhZfrY6elM/QlhbESOZpRzz9kvYc4IwbNlsYaXs+gEHpi7ecPlVStllQew1OL8O4IemNt41Qs5iTN2fr507VC4bs+e6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 15:22:41 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 15:22:41 +0000
Date: Thu, 4 Jun 2026 23:21:38 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] device property: fix infinite loop in
 fwnode_for_each_child_node()
Message-ID: <o3ag4fwtan7ig2upiahin446tjekdbkgrlunejqfsnvs6rxsed@lk5plqjkzcyc>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-2-0ae381f8b7b9@nxp.com>
 <ah_5NgZPc2U0_FPO@ashevche-desk.local>
 <x5liep46c3yzqh3wfsfa2euku6j6yka32clpiwf2zkqdm6czds@b2rll3k67yhd>
 <CAMRc=MeV=FcojNs6rJoBcCwWoDKe5Dwc4MXrHSzEMdHin6j+BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeV=FcojNs6rJoBcCwWoDKe5Dwc4MXrHSzEMdHin6j+BQ@mail.gmail.com>
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: 1543d84b-28ec-4238-0339-08dec24d1e93
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|19092799006|56012099006|18002099003|3023799007|4143699003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
 scdk/lG7dQVGURU0Z4y4lACZhKqW4F4sL+vd3utgLHA1DQ2Z583rb5+KKl3nCO/7ofEz8y1IKbr3aAgFYmz4LXltWaWKYV3KNG6kuLdlHDSpfCcc3Fl1v5lYJgvyl3EjUPT3OjOYNxExbSjGHU65qJrKOamaa2X8codIW/j6xQfZhj4hPdvy9WqYVD3W1RUsDT7jWEuNbmnvxuTTD4NFeMNYPL6m5va6oTwYDmN5Uk+b389bq5F0lzfKATJO0DNh0acTHqL4I9HMTJ4e0IsnAM2g7NEXBaVoJc7U9rwtFoeg/BI+GfCu2qdz1ULHuDP7jiImd7mv00H2DWJEK+SmfKFy/4ixfmDCHj52Ls+8KDl+f2RNzVJ0ifIthqVczJKX6k23MFrXTOBu6YzCpLp6AJR+l2SevlkP/4D88/JZphM6mhngyKm5CmlYFBG/Q3qwUH+5HcEBPw5NBllU7sC1/Mdi+CeP8xYCDxX0kVw5RL0/SlnuOhzmZENpe4s/BOTs3aHUKim7JWeNaVmYMzQiRnYI/zI8EEjrC57C0N3VGcT0ci58wvv5qpMkLliKuHbiLEK4HuIqzhnYI8g1VEhs0cj8NeZHgwnrfFXxvIp9GXGJnQ6e66kjrvKsNNNhKN5kTk/GkTk4iWwAulm0E6H5kR74kEJdxvZGsOiV5IlrvQq9iqltxVxYwMz0zy9xEI5n
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(19092799006)(56012099006)(18002099003)(3023799007)(4143699003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZG9LbkJ2aWtIZWRHWmtUdXRTQ2dsRVlLeHMzTkRMQ1ozeGZla1pLUHFxcXZB?=
 =?utf-8?B?MnMzOHFXZHdRVE9pRzJLNk00c2pIMURvcXNRR3ZUQ1hlVTNjR3MwMVI3b1RU?=
 =?utf-8?B?NG9PUGRzTmplc0hJOFhEMVV6dEtFdkdsem5jaUZuSStCa2FESzA5RTVsR0c5?=
 =?utf-8?B?aDNQZ3dWZ1Z5S2Izc25YYmU3dmU0dHY5N2pWbUJZWWZKWDBZMWNnajB0dThs?=
 =?utf-8?B?V0p0dlVqL0VkNkNqeGVrV0pjQVVnWE8wTE5OMjVJRldVbzE0cjl1S01iQTFZ?=
 =?utf-8?B?b3YrV1gvZW9aSURkMlNjb3IwbXpjcUZpZzJYYjJBMC9Zc05yYlkyMHgvdTEv?=
 =?utf-8?B?UjAzMnB2bGZVa1JzeWR0MVMxd1JZbFNsREhLa2VDQnEzdjRjTHNCTXZBWFhV?=
 =?utf-8?B?T0hKcnBDSVZBZXBuTXdyWUpld2I5SWZNVk1IVzdYZU1kc2VkMW54K3YwZkRS?=
 =?utf-8?B?Mm53RFdNcG04eTQxVS9XT2NUWFRxbE5abE9iSmw0cmZkbVBmeVBVVmJCNVU2?=
 =?utf-8?B?U3pYSElGdGh1TkJGWmFNaGE2Wkp0RWZNckhjUXpEV0htLzBjOTlUZkxseTF2?=
 =?utf-8?B?SlZBc0V0T0p6TGNZaG84b3o5ZmlnZSs5TjFZb2NXOG5wbCtpeG9oQjE0RnVs?=
 =?utf-8?B?VWhLaU53VmJING1GT1dENGM5a3NKSmIrdzhoSmt2M1g0KzRaSWZvR09GQ1NG?=
 =?utf-8?B?cThjczk1QTVnYmJLZjFxRTkralpYaUdZZHRqOWp1K0haK3ZlTDdheVNJV0Jk?=
 =?utf-8?B?dWF2aGRteU0wdXFQdEpEbVorOTR2Tm1weCt6NDdsVkZ2RmduN2JzeWEzK2Fw?=
 =?utf-8?B?M05PVVNmMEF6SDI0SHpFWWNrNmR4VnZ1KzRocG1zTDRjS3BTTmFIc0JsTGRR?=
 =?utf-8?B?SFM1b2Jvak83S0IvZWdrNDVoUlZsUzJsRUlKUjFZZXNBc295U29FMDNIeTlq?=
 =?utf-8?B?TitHeVlpWU5OVldBWUFpd3JaTDZab3RhUnVSaE9RYThwMXpwMjE5cEN0OHZv?=
 =?utf-8?B?K3lkTFZxT1I3TzBOUVpKMEZQMnBrVGpwSUlLcWZUcUNqc2ZVUXBUYXRsN0o1?=
 =?utf-8?B?WHdzS3RUMm9PWTZJS05Pd29VTDZqSk1YTDAzYzhXYkZBc1k5aUQwVWNwM1BK?=
 =?utf-8?B?ekJSUE1lVFpaVXNSTyt5V1ppMXo1NVMyRjQ0bmczQ2xTUEd0MnFTaUxrTnhW?=
 =?utf-8?B?ZG91VTI5SEFRMG1PZ0FNQmI0RE85UFlKMTdCTzdrelZndmlNeDh6TUpNOUdF?=
 =?utf-8?B?V2RYMUNrWUd0azFVYWthaTVlUXBUcUZSNGZEeWJqbnZ4bXJjQml2eGtmbWd5?=
 =?utf-8?B?U2xPLzl6cGhxUXJrZTJmaEFPK1lWcXB2UitJQzNvVG9JbFduRjB2ZUNGYzJs?=
 =?utf-8?B?SVRRQkMrMk93YVdaSVVraDdrdXlMRnFjWGo3bjlqNlFyMWJ2MVk4MzhOVXAv?=
 =?utf-8?B?YWJLTGxqRTZrZWtKc05SYkJVRWlyWGNJZ0tyYW1XUm9ISW9SZTlxTXR2L2l3?=
 =?utf-8?B?WjVXTEhQSFpEWmJlZ3ljaTQzZHJYTmpHS0JSb2R2SGdrNmx3MkxneTVwRUcy?=
 =?utf-8?B?bjl6MUw0NlZpRmpxcjlGc0tsdmVNL0dJYXU0alZyM01lTjNURWhoK1RiWU1Y?=
 =?utf-8?B?TlBLdWxHRHRFZWNJS3czZUl5MC9ML3hmYzFWbm5wZlFPTzAxeEpxOStNVHpL?=
 =?utf-8?B?UmZiNWRaQjM1bTdUaERBVHFJbitaSmlxcFFILzZjMHozU0FkRWJCWG8vVlR5?=
 =?utf-8?B?bGZMVXl1bWRYdjkwZHJDUlFxTStqekJUOFhHSU5LZGlzMSs2WTFUaDc2WFJp?=
 =?utf-8?B?ZlZJSjZyVzdtSXV5dDdhZG8xa0ZLLzZpUGZiWjJwYm5yeTk1UzVUdnVuTmNn?=
 =?utf-8?B?MGZnT2Mxbm1OTmNpYVlmMFB4QXo3bktmUk10d203bEhnSXpyeFp0bW94WjFj?=
 =?utf-8?B?K0xET2p3U2w3VFdpV2g0VVRHcExnUHpIbWNXcmMxQnJScjJ2dVVBM0gyS3dq?=
 =?utf-8?B?ZTVSa0pERjhkcjlPTFV1ZWk0T1EreEZqREFCQmx2bE1CR2VyNHlkUFJGMkJo?=
 =?utf-8?B?SGIvZTMzSzJWS3hWQzBaZ2d3UkpEVDBaVTRyZmVjd0dEMkJlRmJTaURHSWhO?=
 =?utf-8?B?Z3ZGcnJ6ZjNDeGpTeTZISzBLWVdqNDdUYmJHK2h2Vkg4d2tmWC8zb2hhU0pK?=
 =?utf-8?B?YjhhclFoK21qN01rY3lZTzJnTmprUjROcHBwWmRiaHh2VUo1ZEk2dklQQlFG?=
 =?utf-8?B?QjVrejkrc1JMT2dWZ0tPZzMzcGNLa1VudmpSNkVGSWlTaFYyeENxOXNWWElz?=
 =?utf-8?B?cHhGVU16Y2h5cFBQY1Q1MGdCQnVNWXl3eC9MZ0ZUaFBiRnB3TFJuYlZtYnVp?=
 =?utf-8?Q?gNSBP9CCWEprlVKYnSj7dk5PG5w1cqk3YpUy/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1543d84b-28ec-4238-0339-08dec24d1e93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:22:41.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Uc5bRifh8Von9AhIXCl3hfbLN3PRiZAGcGH84QVp0fMnzAqcFMx784DI++4YQI9PjGS2o3n7IoRVG3ULMi6Q9eXCeJ93MLO6VmOsCvwW7Ulc6fD8ygTh3oL4TLiBsVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

On Thu, Jun 04, 2026 at 06:43:38AM -0700, Bartosz Golaszewski wrote:
> On Thu, 4 Jun 2026 13:05:23 +0200, Xu Yang <xu.yang_2@oss.nxp.com> said:
> > On Wed, Jun 03, 2026 at 12:51:50PM +0300, Andy Shevchenko wrote:
> >> On Wed, Jun 03, 2026 at 04:44:32PM +0800, Xu Yang wrote:
> >>
> >> > When iterate over children of a fwnode that has a secondary fwnode,
> >> > fwnode_get_next_child_node() can enter an infinite loop if the secondary
> >> > fwnode has more than one child.
> >> >
> >> >                        Parent        Child
> >> >       (Primary fwnode)   FWa:   {FWa1, FWa2, FWa3}
> >> >     (Secondary fwnode)   FWb:   {FWb1, FWb2}
> >> >
> >> > In this case:
> >> >
> >> >  ┌─> fwnode_get_next_child_node(FWa, FWa1)
> >> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa1) returns FWa2
> >> >  │
> >> >  │   ...
> >> >  │
> >> >  │   fwnode_get_next_child_node(FWa, FWa3)
> >> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWa3) returns NULL
> >> >  │    - fwnode_call_ptr_op(FWb, get_next_child_node, FWa3) returns FWb1
> >> >  │
> >> >  │   fwnode_get_next_child_node(FWa, FWb1)
> >> >  │    - fwnode_call_ptr_op(FWa, get_next_child_node, FWb1) returns FWa1
> >> >  └────┘
> >> >
> >> > This cause fwnode_for_each_child_node() to loop indefinitely, reapeatedly
> >> > output {FWa1, FWa2, FWa3, FWb1, FWa1, ...}.
> >> >
> >> > The root cause is that when the current child (FWb1) belongs to the
> >> > secondary fwnode, calling get_next_child_node() on the parimary fwnode
> >> > incorrectly returns the first child (FWa1) again instead of NULL.
> >> >
> >> > Fix this by dynamically checking the parent fwnode of the current child
> >> > before calling get_next_child_node(). This approach follows the pattern
> >> > established in commit b5b41ab6b0c1 ("device property: Check
> >> > fwnode->secondary in fwnode_graph_get_next_endpoint()").
> >>
> >> ...
> >>
> >> TBH, this code becomes twisted and complicated. Can we add some test cases to
> >> show the problem? Also we need to add other possible combinations (somewhat
> >> about ~5-6) of the different types of fwnode in a relationship.
> >
> > I agree that adding test cases would be helpful. But It's not straightforward to
> > get swnode refcount as swnode is an internal structure. Any suggestions on this?
> >
> 
> You should be able to replicate the problem with the firmware node API without
> accessing the internal swnode structure. You can use dummy OF nodes as the
> primary fwnodes.

Got it. I thought it's the refcount leak one. Then no needs to get refcount.

Thanks,
Xu Yang

> 
> Bart
