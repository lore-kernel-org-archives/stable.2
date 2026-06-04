Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A4318146;
	Thu,  4 Jun 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571794; cv=fail; b=WwZy/g8oyDOP+eGrXGk71NdQiqqCfWYnY/yFy389w5lMmtPxfdwExBU+8Ijk2rs8GTSTRKyqIhacGg2d7pzMgDoky2WPFXLtLTQixmNFYtvK4ODGIXtbSrJbJNqpajOEWFr0nbha/qnFFC/DjPdaMuU3WlOAgBOMbYto0CBofJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571794; c=relaxed/simple;
	bh=a2gH+QlVcPp76YyMCfAMKEaBOV1WpdTC8FyIJs7qxt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VgoeXticuk0suxeNKdH4yRf27QzZ5549LxiIsHCIH9xZaG4yn73xbOVlMCKonVb6MiZ5vzBxxAOATpsdNh99A2h2GaVEikcSwDyMXHPwxF/CXV8myLZM1n6rH8KICMQ/sBL/mFUT0JUHEnCqrtI5de2G0bqqolPhOme2jsoN3Vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CxuuV+dx; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CxuuV+dx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihHZS5oxpNmKs9vrKUO3wSXTS9ErgH0GXPuyDmPR7GdadY3OoC1HgXUOz0SN8N0y0rd+IVRxnBa0af2gSa7ZC4YAg0HF23syUdm0APUG4orlAbx36abW25Y3vda5LDijqooPzk2/OjWxVLqG2mjHBm1Ae/1xb+k1GdtjcRcQA4n4eCyj0QZDeB9N3RVWBAMZljg+MpdyGtMRZxoGyTM/vwjyuWV2FFQKwVki+S+jaab41SIh9ly23Dl0iZJEwCtY+PDgEGYk6+zAWBWeLpv+WUf/DALswK7LgaJzuDOWX4tQPeIttBB2fWsC+TRmhfiRRcwMP2gd+x7FLUrAY1pcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rR+0OP3GRfxyS/UGf9AM4f8VgLwkyYPDXJ0gMIsGSc=;
 b=LYHYmEigqxVxhXyo7Ly/fB9jPHsTzFGQpOxZ7Enm8HSk7CT9mSqRzlNg/JWVoTS4tsc8YnMxCbQpCw+oX0klfwZpgqoDQL+SlNg0yE7t8dOaIqmgyMcXV0Pmm47RQXIx3l+PB12w0XpDA19dZROyq4DksA0/zaGT9LV2JbbbFf91m9SRPY9nrfWMLoQ8uBGojKmUe9pmHtfSVAH66j46lJKb0sGdvs+lNVTZf+XmDRgzWrro1PBEmABak+F0DFDxvfQD3p363W3QKjra1zW4FZBTC9EVC4LzLMNRHA5EfvovylbLf6VfpqVZos1M9L36P6wHwkCg7m+To0JmHprTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rR+0OP3GRfxyS/UGf9AM4f8VgLwkyYPDXJ0gMIsGSc=;
 b=CxuuV+dxCiiKWg/G4jmzeHOpW0/O5ymDo9co9CVJ6cR+v1Ywo/+du4yO7bsOC67DV7RKai5kTG+n7b6WbTjrQYz320EOQK9lBoWHBqzxQlVMF7QpEJpKF2mUDY4NFg2KBjCbWtSlSZdLM7MLTs4A84ylL4t2XnDbqVnGsGD2u4B93D3hzKBxa0ggFQCIpG83KyaFDaFl/PMErJ6R88zzx3ZGm3+rmfD6pRgmRluGCQLTRH4uZHUiwHiLwLsSLUESiFPqcqzbct0WV5YZ2ETScoEQmPnwUoutwieehmu5qDWYD2fp7xWAHcd/05wdIWiQ/rK0TRx8T3j2Wktcwv35jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV2PR04MB11637.eurprd04.prod.outlook.com (2603:10a6:150:2ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:16:29 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:16:29 +0000
Date: Thu, 4 Jun 2026 19:15:26 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] software node: fix refcount leak in
 software_node_get_next_child()
Message-ID: <soxsu3t7ntgnbeeic5mygklzdpohyic7echo5trnzuphbpe6b6@avr5wwkbojvm>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
 <ah_2i-jWq2kBRJpe@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah_2i-jWq2kBRJpe@ashevche-desk.local>
X-ClientProxiedBy: AM0PR02CA0110.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::7) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV2PR04MB11637:EE_
X-MS-Office365-Filtering-Correlation-Id: 02949ab6-4a4e-404f-b4bc-08dec22ab9a7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 pXF/7cfG6dBdm3EyyMnczbIHPt5fplj59creU3l2bsRthQfZN2aGq3L8GSyXoeMsvnmHUjKkbkjXdk5w5EUT16KxIJR8/c0n4WxeUCfp08bjva3r7efxW1r10Q+sZRWA0g7smKwDZPzmNw4Peyira8/QQYNB6WFgaiNYzbvMIgrKMV4X50S489X8N+kDfWpKdgf+ZoQ0SwhIGQGnXs6ixzGafs/CFyGM6xfx/9do9kjO0Wys9OKI8jIKc6W486IUE4fUETSB56IGMhY+MZKe07amuELJYAqY8enYYf8gyrmL1ZZPMZS3UiLer+hkwIZSoP59/cNlDjzNsnT7tZjt2ihQyNqENeL3/foBhCpsAPyvVThdLvFZUVTO0WuIZ1+xepxi1TgALl2Hm2DSEmfvPUuvBLW7hF1glt3bwJbrpGrQtuc+UMMPOuRCt6F9/mVppa3ELULbqKur2rGBvxtTyYsIaVzeRzJaXdbPkItladr9pDKERI8tqJbBeeJW19WzJ9xb9XMn0nUWK01yVol5N9OJ6G+EVPcc41LwoxyCa5sdmbPcPFFIMDVA6QoDqhLxNgPq6llu2fetdegMChm0wUWJWMRFJSDfkT5UEvt2oe+6szSGr+RYDlqxtWM1YXb/vn95Nr1YNnv34tZdD4TRhNsdMXXz9x+BU3NsJ/20F/7P5P25gfPKvBrhSNj7589U
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Prziv3oYE2RuIm4EsoEweJbhkmafO2loQilwJf6R5cLUB/TMIW+2xiW/r+Fn?=
 =?us-ascii?Q?jThEix0yQdJoVDp+NR0WeaIBsuj291mBnl0jdO0ORVa5/IsMZQRvAsaH8tOA?=
 =?us-ascii?Q?dVvC6m+O09DjWPEul/+QG4yaLqarvXaYgHvELu7lDxpqO9AzrYKbgwfzmJJZ?=
 =?us-ascii?Q?t90rpJBBpCxou+SSRXCFHTpAoIKROK0UUKXQoq8JGwV87r8S3dkvRvfqUDUL?=
 =?us-ascii?Q?mHN6RWOYyaxv1uycXR2g2HwsrowkfqzGcWRHdMM+Nr31fc+Sf0DFWSEjLI7N?=
 =?us-ascii?Q?QE2DnBtLeClYe4Sv6u/Cm9Qlf30gU/6Vwny0VS/c72tpK9DBoYVaMBzqgSwc?=
 =?us-ascii?Q?yJC3FoOyGodUkykCj+/eRPxaHdlhc424QA1+iwQ7g4ZMCRLHJpFNOX/0OFCe?=
 =?us-ascii?Q?oe9JB2FbUGpehWP22lVsB2WO9rLTIr8VRpiFtCQnjy5FME/Xr+SsdqD2adBo?=
 =?us-ascii?Q?okFzo8d5amK3QXJs3GdztVAeZRxapTYtfb8RezN2hHV33g7wc5cmDRoaL9HF?=
 =?us-ascii?Q?/ZG9lYZ3vCsCuGxBKbME+RelrB5J2p94124rUdDuZ9XBd2xAs4L+IdztJSUC?=
 =?us-ascii?Q?f08HxuM//hqLT4VqYYVwXZMEejJzTMUTleCjl+Tu85jeXkc/++J2Yf2rJ8Zl?=
 =?us-ascii?Q?ngkBv2CVKuHdb4LJO7rmqr1D110Ek7wtvUPXYEPOvA519oB7Jvzrz6YuLmXI?=
 =?us-ascii?Q?MBtWR/XC9OaKAY8A8+nJS6F12nAKMIvpFHhEg5753MAzyYQll/8e23bwJ067?=
 =?us-ascii?Q?wJYsUWFuXlVJ5S3v4XOxdLkkUusEpHU+WswuYTgg/SKtoBmctwbmzPBHwa5S?=
 =?us-ascii?Q?egwMjTLDQOj+hqdMNpFqWeQ6/maQDJYWHBAbjgGY+i4BbLd0wLSgeNfDKjRT?=
 =?us-ascii?Q?HeMXh+Om3Cvyi1nqP3syDOAfqY8V/2WTt6YAi4J8qjCSwVOiupwxd6LUvInp?=
 =?us-ascii?Q?CbgswpxokIA54+uv9mTuCgo0xMSRFzE+8rWQeYEJLV7GS7ZPLlKwGG8NS09H?=
 =?us-ascii?Q?G80h5Pcf0VKTDIS+DgVMF3KRchXAwwoX8oJKrLYC3drtA2htSaG0EVyjnC9P?=
 =?us-ascii?Q?nkIHcx3KLZEwRflz95SzWjyG3SDbnNtiq4B+G93R99a9y6BUvcBeyhZCHbLs?=
 =?us-ascii?Q?+FgyuKqheD5Ech0PFOyZWeGOdvfzx75mrszCTgvv+F3MseA+l3s4JpIDH0j/?=
 =?us-ascii?Q?yQ+E/A1GScaL+E+8jxCj2qgAhQ/24EXmxU0jAp0HTlbJuiKDx4awBguX8873?=
 =?us-ascii?Q?iPFg2klJrRgQKDP0yk/SigcT7WMfFRLTFMwvCDvhMvAtvUoVyTieMa5+ALRt?=
 =?us-ascii?Q?4NpWaz3r1PzMBy0rUik7jGg3T4dIFxUiZSEA1Owwug4kcuTJrWlRO7Pb0aZl?=
 =?us-ascii?Q?frvR6UtrX7eaWm8E2nfZEh9N7fCGzHF90pPbbFHDcbqUYbTF8MMcI0jT1rgk?=
 =?us-ascii?Q?DCdU8qcnidNCRqPsWWt4vz6kid0B5fApfj9X+Bv9YJOdm9xD8mQGw+Kn3Pwz?=
 =?us-ascii?Q?YrdJIszx6uB/6W793Ek3SlMK1A7RpZy+v8tQl/51OhjaFfb6RgGE2qpXhlJj?=
 =?us-ascii?Q?v4l01kBosDNMUxn4THMUqrOke3GqBUDA7Y5XSUUmfkcbL3W7ToZgMq6DYjLm?=
 =?us-ascii?Q?YRQo/zKBW2wCvGenuFUp2lQryWSNBetaxyN3z3hPIY1u4Uc4Pwfy0WuanXwf?=
 =?us-ascii?Q?kjRR1Mf/DvknCaT9rEsbijxJp33dgmcRAb2sCssRsoepfI9x0S86R72vYM6j?=
 =?us-ascii?Q?pnrGLTsTXfYkyqEFrRznHDlOaBaNZf6NEtboRsIOqYvHo2kaggu/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02949ab6-4a4e-404f-b4bc-08dec22ab9a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 11:16:29.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcRWHsCCi69QpIpLMX5GrOyItj0ao6i9hV2aVnE4A7uzEsbysk/2zrQeE9/5gLGRjmjyjKpX+vcsQRQEXxTPv7lWRDIFHAF8+ztgtTnsm20yGEm3GjATFqea0I6iGKf9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11637

On Wed, Jun 03, 2026 at 12:40:27PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 03, 2026 at 04:44:31PM +0800, Xu Yang wrote:
> 
> > When a swnode acts as a secondary fwnode and is participates in child
> > iteration, a refcount leak occurs for the last child of the primary
> > fwnode's children.
> > 
> >                    Parent      Child
> >   (Primary fwnode)   FW:   {FW1, FW2, FW3}
> > (Secondary fwnode)   SW:   {}
> > 
> > In this case, FW3's refcount is decremented twice during iteration:
> > 
> >  fwnode_get_next_child_node(FW, FW3)
> >   1. fwnode_call_ptr_op(FW, get_next_child_node, FW3) returns NULL and
> >      decrements FW3's refcount
> >   2. fwnode_call_ptr_op(SW, get_next_child_node, FW3) returns NULL and
> >      decrements FW3's refcount again
> > 
> > The same double-decrement issue occurs when SW has children.
> > 
> > The kernel dump as below:
> > 
> > [   25.435805] OF: ERROR: of_node_release() detected bad of_node_put() on /soc/usb@4c010010/usb@4c100000
> > [   25.445072] CPU: 0 UID: 0 PID: 617 Comm: sh Not tainted 7.1.0-rc4-next-20260522-00011-g7376b330abca #210 PREEMPT
> > [   25.445080] Hardware name: NXP i.MX95 19X19 board (DT)
> > [   25.445083] Call trace:
> > [   25.445086]  show_stack+0x18/0x30 (C)
> > [   25.445101]  dump_stack_lvl+0x60/0x80
> > [   25.445108]  dump_stack+0x18/0x24
> > [   25.445113]  of_node_release+0x158/0x194
> > [   25.445122]  kobject_put+0xa0/0x120
> > [   25.445129]  of_node_put+0x18/0x28
> > [   25.445134]  of_fwnode_put+0x38/0x58
> > [   25.445141]  software_node_get_next_child+0x54/0x15c
> > [   25.445150]  fwnode_get_next_child_node+0x70/0x94
> > [   25.445156]  fwnode_get_next_available_child_node+0x34/0x88
> > [   25.445162]  device_links_driver_bound+0x2f4/0x334
> > [   25.445168]  driver_bound+0x68/0xb0
> >                 ...
> > [   25.445258] OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
> > 
> > Fix this by ensuring software_node_get_next_child() does not decrement
> > the child's refcount when:
> > - The parent has no children, OR
> > - The parent has children but the input child is not a swnode
> > 
> > This prevents the refcount from being incorrectly decremented for
> > fwnodes that don't belong to the software node hierarchy.
> 
> ...
> 
> >  	struct swnode *p = to_swnode(fwnode);
> >  	struct swnode *c = to_swnode(child);
> >  
> > -	if (!p || list_empty(&p->children) ||
> > -	    (c && list_is_last(&c->entry, &p->children))) {
> > -		fwnode_handle_put(child);
> 
> Wouldn't be better to use swnode_get() / swnode_put() instead?
> *Yes, we might need to add some NULL checks there.

It's not newly added by me. The software_node_get_next_child() has been using
fwnode_handle_get() / fwnode_handle_put() before. In my opinion, this should
be fine since they do the same thing here for a swnode.

Thanks,
Xu Yang

> 
> > +	if (!p || list_empty(&p->children))
> >  		return NULL;
> > -	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
