Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03868346E4E;
	Fri,  5 Jun 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651061; cv=fail; b=lHmfx8oyAlZ5rU6ZRo+RU/wmqn1Iu3HCvJMHvyT8LZg8ATIbiLbzPTiobrLCoQPTpqt/aMcCUiSZJyuXqUvEhzFf4B5wFUDDgfX4fR/a0y0UI6NoauPi/fsZQ2LHQfofBl1gARTJPxY2dBj4IxBwTolgRl+nOdemFlQGzomwhwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651061; c=relaxed/simple;
	bh=2kZAGtAPAaq1x3BFgapj0YUECg/eoiiaGEAb8rV3j8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HM4vrz2pcwNN30wvq9WyowLsX5wBbYxitbXdvKz1a3s1qX7NssEGZSpgz3yauRpoGd8+QuGGBMtsbShK2EowqpK2MsP+pC15VHDrE7BxP55cnq51qHyypoSF8ZVoOPWk6unjqSFBiDHD7JjI3FdN2Gk2RLN/xx+6Fg+4Dh2ESbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gpW1BP6J; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gpW1BP6J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZLD97rGzCSsgtPTYSzjKa9Ksvuv0b9Bm3uI3sCi0diC7w9fuUkDhkymClB0ieMxa5cvUfVZmJYIyvORZ8X7T2mo4L75QGWbjN2rGphXUOgg+f9jKhGCyowf/MWBO/G82vRC5Dz421ga6QVYCgXZql1Q0CBeohdzo8HwHU1E0OWcTTnCsBlUDjXCa0xni47ZC1r9WxgtmQuQviZxCGgcxZGrBNi2i3tvFGmh83fchtZNblRFQ17eZUShWF9mT3q+BGSaGyTzVBgLdXnGMwE2fOAiNh2BUnAT1BCV6auSkgEVbA8ExEixFtUXeYjZY8vHivNPhz80BcMBsvfGORRVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc8EQfFcb5Z1L87apXtM+8DYDV74y7gwEJLl4/cMzzc=;
 b=TFnnY7VQGD0ODaODZk3o1USfCxlcQ57qzCaV+YhNr/bXFK3kz3M3DAPALfIljTDCn7R8XuAB9RcNE9ZpLBUD1KtVvIk/VaxMUidbdyJ6/k+vTwIISUw0+0OWJqI/KdK4cNS68IKd5knJ2JeNR01AgG13FKX+CJmwUcsZOFZ81h8fk+WqSh4lkh2AS1p1xGH2+i2kUiSFmPgy3vVMzH9kVKvcB8i7ZQcUlfn+aGOcLA4iWJ6ITZg8RZeaSlzEF3uViO3H/8fXsUt5qsPGqa9mkdWfv7dxZkU9RJVu5+O2a4UA6mlEwPTJ+OZ6PVDYmogyIhuxfxEzhLeE7iIHr31bQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc8EQfFcb5Z1L87apXtM+8DYDV74y7gwEJLl4/cMzzc=;
 b=gpW1BP6J8+cK7QKnUyJdBuczxK49DNgCexvWXIQ8XMDlUPzLhrmZ49Ue5MJ5FgMKok6RQFvIVjJOlu6zB1kT+cW6o+Q/p5dnG+I8sUDOElulRjzboyBXsMkKSzlhH8Bf5I12gpRNnyepTzmrBeXWdDoLXz1zuZONMmqonHyLOTSHuGEWImXQHzAyuqY5xlfWtObS7d2SGSaxEbSzGBjBtpuNFtBlDcmGlNUS3VAPLsgn7XM7YvZZEBHZ5wJKqnbVRF9JQoZI3j/euappF5tiTGMoymIJ9nJlb8riqJ+oeFOpJUumrXYkPVtXFfDey573uTbx4Xjfmws4XTSjbUtiMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by OSKPR04MB11414.eurprd04.prod.outlook.com (2603:10a6:e10:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 09:17:36 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 09:17:36 +0000
Date: Fri, 5 Jun 2026 17:16:32 +0800
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
Message-ID: <6keyevnyndjeovbpiiufp7ejrtz6sfelu65evhg7odgb2tyxrf@xtmiqmko2kuo>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
 <ah_2i-jWq2kBRJpe@ashevche-desk.local>
 <soxsu3t7ntgnbeeic5mygklzdpohyic7echo5trnzuphbpe6b6@avr5wwkbojvm>
 <aiG62GXa3tYhhMBQ@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiG62GXa3tYhhMBQ@ashevche-desk.local>
X-ClientProxiedBy: AS4P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::25) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|OSKPR04MB11414:EE_
X-MS-Office365-Filtering-Correlation-Id: 074f288d-f086-4364-293d-08dec2e3483a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 O0J+b9jnxA1TZhgrccaGbTqCIYvDmHCRDLbWeATTNZptgwlqhD3RNvP6dxLaQnLfRTpkb0cCdiCVHDKdQbeTMVxfTVtYDj68JCFYt+xGLzf0lmH1JahhtIaLY9S3cMDlrucWIC884c48v4tzA3F/ve+cxMXZmA4c9y4ZpXQLxzLM28TxhZke2KqhAVyVygjVxrpPOcp5zw38cZZLjOOKdXojK+pC+trEvbblGkMzVAdvlEd/fOIxly1xdO3c2vX8/fiDYyTaipsZ+dr9FEsTk+AG8zP/RWxE6u6YeKHp5d4qMS7BNBhYnXo0qSlcmGBBZdn796sXCt2msFr2MFfY5ZVEvofLwQWHnBf8MT4DL06SVTSsARtOTpAcny3SKpJlp7neX5yOA37Q0fr4ef/3vYXbmvu+15sLrzkpGx7AuYKEgwUAuEezPZL+YOTkiCO3gI49pXrCakku81eD0ASjjCyR8PYO92SBMc+CxGFxjewMTBkP3SuyXFapBdzUul00xFfQEV4PAPzEY3pyqs+C9U+k0/NU37MJ7cKiYksDWbi6SZ/alwS5l+MQeLssiB7NueN+wUKdX3rF6KtKSOuL3WYS1AaUW/q0kzt2zOlKYyilaROxc5EYE2Cb3+6bzJyZQO48mAoB3or9z4alnzgB93oe/GQF1yIojuDNTKy0ZDMySVLnI8S8444whG3v5p+1
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?MfSWYIfCOU641ksCW97KFxMrbY95sb0veyLjx5L2xxrIw0HM8rNI7zcZ+GtZ?=
 =?us-ascii?Q?6JZhJ+09tUvusx3mk7BDCbTNdFy6/bctSmqNuNULXqYD7W/8mYiSx7qiS0gr?=
 =?us-ascii?Q?61ONU+a8W8oDuWRLhHRkmMD5mtMcdnecOofPt1Lm4Vi/2E4TFB6bxTSRB4np?=
 =?us-ascii?Q?Fm8qb3E1B6spuVGUoHF56nMf+5BCa8+it2OP/W02A1UGnpRfRTJrYo4E/lah?=
 =?us-ascii?Q?y5cVT4ev0w5kwA3OymkWVvzKzJrRJ6xM5gm186rEQFlNC5MPVLBr+R6d3TpR?=
 =?us-ascii?Q?qFu4GFc8X0HBQSK0Uqq/xkgr3DRUSC0cBtWcYz6mgR/8WwwWbVqDhStchTaJ?=
 =?us-ascii?Q?aTwM0RGpYnkd2J1pIkzOCV/RUzXSP2nzp/FLkVH/1sBW5mAB2u/dWAfY69Vh?=
 =?us-ascii?Q?GvQZsHyzien+5bnT8OaV1NgPT52Qf2rCx2aWjyBHQSJbNW222z72x1wXSFoe?=
 =?us-ascii?Q?uYbCnqMhpth+49/omLG7wazRB7Hu8nqMUDnerNqCkElqg00FlyjsfOy4WciF?=
 =?us-ascii?Q?elqCfAt/WC0xq8SIlhuRSzYlyX3Ce31/Nj8xJ2YCkdFYB4q5EFkh50nAea82?=
 =?us-ascii?Q?j6gl07lxNZDviQdHTk236YKjr3kONK959SIXr4qb5wEOI5EZZWHhvB3RELgG?=
 =?us-ascii?Q?tsqsbNxxxicIQND62O/keQ9cdGBH1E6yluE0QrZbhcZPFUELmLKsgCRtj2K2?=
 =?us-ascii?Q?TOe5+w3YFlnklrjmZZi9nwtUwlF5GOESi35v2Lw61C7aj5IFzbnFbQXBqae7?=
 =?us-ascii?Q?90zM63800x7mvOEDc2vRi/o4pBsG/5L2N8BJqNQzFkSF9hXIbpOYuGvyth18?=
 =?us-ascii?Q?mfNOOk8yfyR8PDrSodvg+lXHG+bJVMAFLrj3hw0jmSDNPRJ+gU3zBfFJcKh+?=
 =?us-ascii?Q?T6magtYgVX4MPnJI6j0ZXjT0b25cUUYXyFqheyL+LD99qQ74UZFnhQXNXlqG?=
 =?us-ascii?Q?h08mvbyH0aXO9CttrVo6CoLuwpzpkoKq0Mm5nV84C1wzbl00m78yMRwTuEkJ?=
 =?us-ascii?Q?kK3VilNC9ZwB6hK2cNE8LviuImNvXBWAcS1an8aGbPfBPdHUnjPG3IssMUby?=
 =?us-ascii?Q?Nkc7RXur2U4thBB2SyFuDFJNzf0OnQuQ0OWfuVVyPheiCD5dVWi/CrmwvMS/?=
 =?us-ascii?Q?UHg5hjG21/YKN3+4TmwNpH+64hHChhXUAFWD0YhAIk0YEUywTKligr7oL4hi?=
 =?us-ascii?Q?4sTkaJ6jWLf/qoIpWSszPpc1JBxYuZ2oMXxSw+q9HFdwfXnPEhwqYsVAg3+3?=
 =?us-ascii?Q?VIhUmPVs/Xb1a5L+h8Mo5QWzwH5u1j7V0pu4eoQpZCZ/oEkLS3eY+ra3H2Ja?=
 =?us-ascii?Q?6z3CXm2M2RtTP2ujRIDdUrqn8RCeVzViah75L9UxYvgzYmnsYaR/+u6tLgMp?=
 =?us-ascii?Q?Gu+ANAp4Upd3g9knxMd5lrJsM3gIK5L2TnIXIp2TXiizPGNlXTgxuaZRA1R/?=
 =?us-ascii?Q?lIZUPFXUKQ4vkmTHughamYDy5Qr4gQxR5J07ubAnHShWlop9N31c4tAcCgYT?=
 =?us-ascii?Q?RGOOl7Yd/X3lC+sSnblfMLXxx3NJeJYDY+kixdNttY0gjx60YST9ZG24S6Pk?=
 =?us-ascii?Q?BfOJ9zD4OSkPzDUaAveF6a0SpTJXkjqvsm8ZEimpUzKmujX2wVODxgOleKq5?=
 =?us-ascii?Q?H7+Kz1sWJXbZaZfbb6bDNtol+7WVU4eSqJmUGwQDNc5DgBtNwOkMGxyJFP2F?=
 =?us-ascii?Q?8vulzV3sE0thvCYbiS47DbHJ6I38w8f3vbgld7qoQMP6dEAzW/DKgefuz9us?=
 =?us-ascii?Q?x9RNX/W/mNCBL0sCFFmDWafRDh0hERRQQkQsMY0t96/5fFQq5YcV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074f288d-f086-4364-293d-08dec2e3483a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:17:36.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6beK/pJJ6RTJK/e/goUsk3E787glLYpnmaR2E8+6WKfNR0ZtSHo4EPncVYwpfn0NsX8Z+7ZT9ou7dKCpWlWcA7EBach0hEUbpo2+lqb/u8Ks2U0md6JII9ORp1bZpEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11414

On Thu, Jun 04, 2026 at 08:50:16PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 04, 2026 at 07:15:26PM +0800, Xu Yang wrote:
> > On Wed, Jun 03, 2026 at 12:40:27PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 03, 2026 at 04:44:31PM +0800, Xu Yang wrote:
> 
> ...
> 
> > > >  	struct swnode *p = to_swnode(fwnode);
> > > >  	struct swnode *c = to_swnode(child);
> > > >  
> > > > -	if (!p || list_empty(&p->children) ||
> > > > -	    (c && list_is_last(&c->entry, &p->children))) {
> > > > -		fwnode_handle_put(child);
> > > 
> > > Wouldn't be better to use swnode_get() / swnode_put() instead?
> > > *Yes, we might need to add some NULL checks there.
> > 
> > It's not newly added by me. The software_node_get_next_child() has been using
> > fwnode_handle_get() / fwnode_handle_put() before. In my opinion, this should
> > be fine since they do the same thing here for a swnode.
> 
> It doesn't matter who added that. But according to the point of this patch
> (correct me if I am wrong) is to avoid bumping or dropping reference count for
> the nodes that are *not* of swnode type. Moving away from fwnode_handle_*()
> loop we make the point clear.

Yes.

> 
> See the of_get_next_status_child() implementation, it does *not* use
> fwnode_handle_*() at all. So, making it here to use same approach should
> fix your issue, no?

You are right. I had also noticed this before. Actually, the difference between
OF node and swnode is that OF node uses to_of_node() to filter out non-OF type
fwnodes. Similarly, swnode uses to_swnode() to filter out non-swnode type fwnodes.
So replace fwnode_handle_get() / fwnode_handle_put() with software_node_get() /
software_node_put() does fix the issue.

When I reviewed patch #1 again, I found it already fixes the refcount leak issue
because when it switches to the secondary fwnode, it no longer passes the primary
child to secondary fwnode. So the patch #1 is not needed anymore. I will remove
it in v3.

Thanks for your review!

Thanks,
Xu Yang

> 
> > > > +	if (!p || list_empty(&p->children))
> > > >  		return NULL;
> > > > -	}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
