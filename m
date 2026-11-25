Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633288;
	b=GPVpDxIAIQX0hxhyrTDiaCDbykkAHo0vGtvg8YcFuydkfwDjKsrLwsOjE3YqfgqiQL9y
	 Af0yNKo1bugVVU8b8RY3acKbkcOdAlFPJpywjpLAgEgPTbuMHxyuPp+T0sbZle7mFpu+a
	 NQB9ErTXgnlDSzGF+ZNmON5qtNYvSSoifTZumnPxAgdDAzJPdJ3q/S1j3NQ0+ZqaCP0ny
	 xCjbW8SKzTU8k7zRPDTkWkmNsnVHkbd2HWYYnjAmUp24FL0bIbq+AaBcLNeBEh5vC1wfT
	 YhDG3nsC5bnv0MWqwxUBKzVCIj7x+h6z1yPjJtYmH1ihClcLP3ZRi5yDO8UYx49VZxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633288;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=zojeydOkrm7T3sUbaNi5feZanSAroETzalIABitAJDE=;
	b=Zzw4q7vJH9ZcsGfK8CaozEJ+kKdm04vtDJ7gdG3qTpIcJQvxrLNEhRHj+4aElNyYshr7
	 WjScLRXnt2yuRh8v5nGh5/69jZ11Vkj7K5QAzv47y79LKoKVP+KFDeasq1EAcA3RiH6Xt
	 wmC+ceNlq7Pjuwvxis3Oya+QBsYJPnhzkjd3VTjOsfpjxelySP3aEcXAdStdm5tnqfyvs
	 /qkAoTUT9CnOJWuS+HBD6FUgTC7KZk+sBa5AAeELmqHhsb0oLzKZB7bSYm1Hj13DG1thD
	 R7lK2/NO536GWLawfHdIaQGvb5eLBIP6ALLkoVDeqlP+sLnciQGMzbPwTHj4cKUdBuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AggoYzfL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.26
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB2606A323;
	Wed, 25 Nov 2026 19:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CFB2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AggoYzfL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtNx0b3Z3bJHericOFi3hKQ7TbD/+wY0NpWixYVy4NPjhXVGOwZ7BF1MY0IUb4W9wTOTZU5VzMgzuavESSoXk3hvaeC5uIVNZD6JviorgnvauzkU75pEC4BReGVwS3YCtrJq3OxZwnjLsyQ/G74/zH89pVSMrbP7DUgYXAfA1Pm1VbptpGrebxxW1PL/fo1jrfVAWyGKrcMVF8WcoDIoWHMd50+M808psERbgt4x/zZ+cXpVYay5mCVF1VXrbQ/sABFOWjR6nz4AtUIqdOBwHs89Fcn8ahQ6um7yP2f+2cFWFOds6byFcqBXYB2umR0ULgK5hmDdhqZbzWNLe1Zc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zojeydOkrm7T3sUbaNi5feZanSAroETzalIABitAJDE=;
 b=tc/HsQcGXpTCD8srCUsNQYR7ZnqTMOMJguHuLD+GxcRQ4YTX34bsMXnFIv+KBCz55ec/k0nnq3aejSSb9sf7vtajUb16TRZKF/yOnLInnZUtXumcrge9Wkx0ZCNpY0RGRbtkvqDO4dgtH3C4OgQNm7r3xYsU1vB+Kd3q6Brat2IMnxcyY8ZQm/7k596vljT7bTPVrYYvusPzB8IsKYbuz2BCI2XMSVvdfe88YHAlNS2iwzU4Bv8uU7DTnrTnKFVtWB0WxA4aTpHUyofJwMtR8wXEDwy/jWfxGJWxl78J9FxcS4Wzx0LzlkjwZ2jbpirXQFiQAXJ9XeaQafq3bKNy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zojeydOkrm7T3sUbaNi5feZanSAroETzalIABitAJDE=;
 b=AggoYzfLVbKlvQoF5hUaXsHm3a160Ler+wmwaKU1xgBWJ3K4xRm5fkY4PxaT5EUv0Dx50XKC7nctPDSNDoUhpeT9XNTwZdH1pBN3zFQPPBG7GG4PzHluf0vaLHbbbJkPzO3aMJa8Zo89jFrHtJQ+i7/9y29y0DAANrPsmK4rXrED7GY3IMGBeJp0tvM15IXoy1+sRhCNpgi8KyjMiqM6AL2Xsme04oYeUOQ2WCvOcot53tdrBOUryARQ9f5K/gmHhf9jNd5GgTnnaoSABC9ajMOkLGtIxnlmaO9wDT1gthCCN275sTLCYq0tZz5mpKKCMMUao6ZOLyeq9rfIieBQNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 19:01:22 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 19:01:22 +0000
Date: Wed, 25 Nov 2026 21:01:13 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org, kuniyu@google.com
Cc: n0ps1edzz@gmail.com, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, hangbin.liu@linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: route: fix use-after-free in
 ip6_confirm_neigh()
Message-ID: <20261125190113.GA421469@shredder>
References: <20261123133000.1.n0ps1edzz@gmail.com>
 <179550368695.3135.12579094604954175182@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179550368695.3135.12579094604954175182@kernel.org>
X-ClientProxiedBy: TL2P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::11) To LV8PR12MB9407.namprd12.prod.outlook.com
 (2603:10b6:408:1f9::13)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: eac5e0fc-4d86-4265-9f4a-08df4b267f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|5023799004|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SzoRh3t5IpKRQ0phvrYdZFCYJCKeDObCOr/7QH4BxhKfG/ZQAJUQZtr1sv4PLAWAUUN27ZuJXQgqU3Cu9fu5KveTgWY+L72gCk2KP60g3rWbAF1UpminvE/sfZw962I8Pae3ZcG+vp/1fV0q9ZrDfFOVGclJaEEVGt7NZXz6Nuxff29BR9cXHcW1+Nw56BBd4LWNius/qYeKEiIfPrA6zKW6uE0MD5I1z3VzpCaK+hk7ydYaGLgzo3MZo2zgJjAXRgIA+KmoJTin7L1NKkJlVEY+wbdiINtx0sHOwQKYwsqSGbPZeTItZVv4JgTOYQ0h5Qqc9ruW41ga2J30sGh3QWLaKY4kcXdTSZVCp5X8FwkN9c2k9vO2pznKtCrOBWWwa9HPol+PvO7vN9BQGRUliKdIccSQ1QorEKzh7X+kbYpDcKu99I9XrjLuWm1RHxFdPsdPdOg9H84WftawzBnyqFofrSX6ii5vMuAddwSDaEXYUonYp4FXXZMBiEE8GZgOY3FD9rFcy//Pbt6aDYTnXKWdDO2YRjeZdi7DVspppsjI4sCfr86ooDpiFVAfHV4LJyQw59v76RRwsrhCrstsHF6tbZYiaYta7/rilBxmSfDJqu9FMfOB0hTHJrOuW1fcxl4Um6wwaNa5LzamRIefrR0z3OMfyMRjxAHpH1mwpnQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(5023799004)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eViZ/znjeJ6QDGW+F6Bp9N7xLz6/Im5l0bFL1QGS8zTe+s1wPvMcAWowqPJh?=
 =?us-ascii?Q?pYEBVufSonqXahJ1A6Gnm1lSsAkbuZ/CCfqCHd0urK2Fc3Xadx24ASGTHohI?=
 =?us-ascii?Q?whbZxFVXIKM+Sxnr906XETP0MJOjNm5S8gJFFc6umomxvAvWDyFowo3yJIPe?=
 =?us-ascii?Q?90euhq116u4x16Wnxz2f8HtL9zk8pJtl6cJGLpdHwipOT1p8rstIxi2kq6bm?=
 =?us-ascii?Q?1Z5RErpu3ZVH8nwx6o1xRm0FI+5mV928elogX4jJB5mxrVaDhVMhU8+Da4vm?=
 =?us-ascii?Q?Bn+tuaE33yY4pMNrjbPMrOyiG7C0e7+O+deCHIGkRAM1BGkVBsPMHuGXotlm?=
 =?us-ascii?Q?8y/q7wkthVUANL12wJ895gnwunncn0FNotrAAp62Oif0937bdacsKdzVbcUX?=
 =?us-ascii?Q?ZVsteA2nnweyaxfWibp2slVPm3+KQahBWSUAepPfx3uEkGwe672WZBddaZcN?=
 =?us-ascii?Q?9pUFANGtFy/jg4mcNTl1ctZoTXgCsfz1HHWFcxdbcMwotX4NUjWSXU2NWu1o?=
 =?us-ascii?Q?ACSltnPYkZXGdIauyV7kzMBDXnrvffcKAGJNuezN9kYOZoqAzQ6pYF2g/KFf?=
 =?us-ascii?Q?aPOxdGTKsBQ1hZiIXEnn2NU4yjSjPVZzv7u3TKFG1bM1qTtBylIhBZno3czt?=
 =?us-ascii?Q?/MnzLrKcGoilbKBU9+KIWIAh1ooBcyMPhlxGjKYleatbeQkasNbaZSmRVRnE?=
 =?us-ascii?Q?94vOrolhhVrRk4HMt71S486b1qdK4Ww5dAJVLjmAXgh5U2EPb5VJHmNPnsSl?=
 =?us-ascii?Q?H2+HGZnSIJEl7OkUeNmtwyFofE0O5QCiXfYNSBBpQ67KrtJipp8VUwKhXVpA?=
 =?us-ascii?Q?e0LnL5G88p77Ys572nyEHjIlYuzdHnWK9LmRYKv54BJODBd00hArCGb+YBC5?=
 =?us-ascii?Q?/da9Ha0Y9ixukIG1x63ixJ8Sb/uFIpCVMElpJitn4iDmFGOy0kai1OjWi8Ek?=
 =?us-ascii?Q?KDzzo+hLS55B2e6D3xWSTPt9gond9iXwV1zTr8mkdchOXH9bGlxF69obTcay?=
 =?us-ascii?Q?yx6LqLPJreyEwI5CK0m0jYrkPq/K1oseBj10mfLLt8Ufg7UBEgKOVlV9soIY?=
 =?us-ascii?Q?sFez+2uTHWqXKDHZwG8qxVVpn/7pdJLlghr7jTQHfBtnpdPJspFcmXolvX5w?=
 =?us-ascii?Q?kIPo1ibmrJdB5Mt4A8shaSiubkHucRTnWTEjVgAAV5BD3Ny71LqONjyqxLqe?=
 =?us-ascii?Q?rpv0cZDlfB7EkPEsg7H61dWIKwpawCiIizKnYTskNuvwgzMHXJOiYOhfy5AS?=
 =?us-ascii?Q?LGlrsXCSdr0YVniKYRd937Cb8MLH+9Rnw1ovXvRdyeLH3ocADvDyNsVEHQD4?=
 =?us-ascii?Q?SIq05gvxDe2TgX2OzAXyKc78YbN8BUNSonpMyJ6Mi2NKeN+3U+EmaOg8AUk6?=
 =?us-ascii?Q?34JdjVGRsnqM4GX8oC/3CDj3kGg4zV0ZC3bLkwjP6ysRncxK3SFLRDgln4Ln?=
 =?us-ascii?Q?lsC9zUyOH+d6jcvz1A9/sC/zWKocw8eP44qfQcnmGDJps+1Q5h/Ksd8FUroB?=
 =?us-ascii?Q?KI6mK+tZ1IMoMIhOqWICxl0Ih/F3pAJwfmYEF7OMPpGSA7OJjknyrnHEoCNo?=
 =?us-ascii?Q?kbNhMoofPNNwVXBUJMXk6ffjyKOGtxPzwvPREi5bs+ZBfNcQzDGH4JyhRJIF?=
 =?us-ascii?Q?95zAe3uicna1gdcbI0zWqtyMjmZlRd39t0f60aS6GasvCK3QgNnHIgVmdpY6?=
 =?us-ascii?Q?PtOVENcHrkfHrUj6i4X0qw3y+IwROSgLbLEt3eQmX21yGb4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac5e0fc-4d86-4265-9f4a-08df4b267f12
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:01:22.4875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gn5BEcdKZ89dbrDfDyGuWUXhx08ebvh5b0Cz52+00bzyGEcaSdK4gkXA0T2/uE55NgvI+Av9hRe5ROaocziOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

On Tue, Nov 24, 2026 at 07:01:26AM +0000, netdev-bot+sashiko@kernel.org wrote:
> ipv6: route: fix use-after-free in ip6_confirm_neigh()
> 
> This commit takes rcu_read_lock() in ip6_confirm_neigh(), loads the device
> with dst_dev_rcu() and holds the section through the dev->flags test and
> __ipv6_confirm_neigh(). It is meant to stop a use-after-free when route
> teardown swaps dst->dev to blackhole_netdev and the old net_device is freed.
> That race is reached from rawv6_sendmsg() and udpv6_sendmsg() with
> MSG_CONFIRM|MSG_PROBE.
> 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 1b2dcc066e198..6bdd4423ce784 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -257,16 +257,21 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
> >  static void ip6_confirm_neigh(const struct dst_entry *dst, const void *daddr)
> >  {
> >  	const struct rt6_info *rt = dst_rt6_info(dst);
> > -	struct net_device *dev = dst_dev(dst);
> > +	struct net_device *dev;
> > +
> > +	rcu_read_lock();
> > +	dev = dst_dev_rcu(dst);
> 
> [Severity: High]
> Does this RCU section cover the uncached-route flush that the commit
> message names as one of the two teardown paths?
> 
> Since commit f12d2907992db7 ("ipv6: Batch rt6_uncached_list_flush_dev() in
> netdev_run_todo()."), rt6_uncached_list_flush_dev(dev) returns early when
> dev->dismantle is set. During unregister, the pointer swap now happens
> from netdev_run_todo(), after that function's only rcu_barrier():
> 
> net/core/dev.c:netdev_run_todo() {
>     ...
> 	if (!list_empty(&list))
> 		rcu_barrier();
>     ...
> 	if (!list_empty(&list)) {
> 		rt_flush_dev(NULL);
> 		rt6_uncached_list_flush_dev(NULL);
> 	}
> 
> 	cnt = 0;
> 	while (!list_empty(&list)) {
> 		...
> 		dev = netdev_wait_allrefs_any(&list);
> 		...
> 		kobject_put(&dev->dev.kobj);
>     ...
> }
> 
> rt6_uncached_list_flush_dev(NULL) does:
> 
> 	rcu_assign_pointer(rt->dst.dev_rcu, blackhole_netdev);
> 	netdev_ref_replace(rt_dev, blackhole_netdev,
> 			   &rt->dst.dev_tracker,
> 			   GFP_ATOMIC);
> 
> netdev_wait_allrefs_any() returns as soon as netdev_refcnt_read(dev) == 1.
> kobject_put() then reaches netdev_release(), which frees the device right
> away:
> 
> 	/* no need to wait for rcu grace period:
> 	 * device is dead and about to be freed.
> 	 */
> 	kfree(rcu_access_pointer(dev->ifalias));
> 	kvfree(dev);
> 
> free_netdev() only reaches synchronize_net() through netdev_napi_exit()
> when the device has NAPI instances. Dummy devices have none.
> 
> As far as I can tell, nothing between the swap and the free waits for
> current RCU readers. Can a task that loaded the old device here with
> dst_dev_rcu() just before the swap still read dev->flags, or dev_net(dev)
> in __ipv6_neigh_lookup_noref(), after the device has been freed?
> 
> User space can get such a dst. rawv6_sendmsg() sets FLOWI_FLAG_KNOWN_NH for
> hdrincl sockets, and ip6_pol_route() then puts the route on
> rt6_uncached_list. MSG_CONFIRM|MSG_PROBE then reaches dst_confirm_neigh().
> This is the same rawv6_sendmsg() path as in the KASAN report.
> 
> The dst_dev_put() path looks covered, because the NETDEV_UNREGISTER
> notifiers are followed by synchronize_net() in
> unregister_netdevice_many_notify().
> 
> Would netdev_run_todo() need a synchronize_net() or synchronize_rcu() after
> the rt_flush_dev(NULL)/rt6_uncached_list_flush_dev(NULL) batch, before the
> device can be freed, to close the uncached-flush case?

I believe the bot is correct, but I don't think the problem is specific
to uncached routes. Regular per-CPU routes are released from an RCU
callback (e.g., free_fib_info_rcu()) and these callbacks can start
running after the last synchronize_net() in
unregister_netdevice_many_notify() together with an RCU reader.

The callback then drops the last reference on the dst->dev used by the
RCU reader and nothing in netdev_run_todo() waits for the reader before
freeing the net device.

We probably need:

diff --git a/net/core/dev.c b/net/core/dev.c
index 6140fd9d11cd..3fbd375c12dc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12037,6 +12037,7 @@ void netdev_run_todo(void)
 	if (!list_empty(&list)) {
 		rt_flush_dev(NULL);
 		rt6_uncached_list_flush_dev(NULL);
+		synchronize_net();
 	}
 
 	cnt = 0;

With:

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")

Kuniyuki, WDYT?

> 
> >  
> >  	daddr = choose_neigh_daddr(rt6_nexthop(rt, &in6addr_any), NULL, daddr);
> >  	if (!daddr)
> > -		return;
> > +		goto out;
> >  	if (dev->flags & (IFF_NOARP | IFF_LOOPBACK))
> > -		return;
> > +		goto out;
> >  	if (ipv6_addr_is_multicast((const struct in6_addr *)daddr))
> > -		return;
> > +		goto out;
> >  	__ipv6_confirm_neigh(dev, daddr);
> > +out:
> > +	rcu_read_unlock();
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the IPv4 callback
> ipv4_confirm_neigh() in net/ipv4/route.c have the same use-after-free?

Fixed by:

https://lore.kernel.org/netdev/20261123133000.2.n0ps1edzz@gmail.com/

Both should be in the same patchset.

[...]

> [Severity: High]
> This is a pre-existing issue, but ip6_dst_neigh_lookup(), just above this
> hunk, still uses the unpinned load that this patch removes from
> ip6_confirm_neigh():
> 
> net/ipv6/route.c:ip6_dst_neigh_lookup() {
> 	const struct rt6_info *rt = dst_rt6_info(dst);
> 
> 	return __ip6_dst_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
> 				      dst_dev(dst), skb, daddr);
> }
> 
> __ip6_dst_neigh_lookup() calls __ipv6_neigh_lookup(dev, daddr), which only
> takes rcu_read_lock() after the pointer was loaded. On a cache miss it
> calls ipv6_neigh_create(dev, daddr), which leads to ___neigh_create():
> 
> net/core/neighbour.c:___neigh_create() {
>     ...
> 	n->dev = dev;
> 	netdev_hold(dev, &n->dev_tracker, GFP_ATOMIC);
>     ...
> }
> 
> After that it calls dev->netdev_ops->ndo_neigh_construct.
> 
> Suppose dst_dev_put() or the uncached-route flush moves the dst to
> blackhole_netdev, and the old device is freed between the load and these
> uses. Could netdev_hold() then increment a refcount in a freed net_device?
> 
> Some callers get here holding only a dst reference. For example,
> irdma_addr_resolve_neigh_ipv6() in drivers/infiniband/hw/irdma/cm.c calls
> dst_neigh_lookup() after ip6_route_output() without rcu_read_lock().
> 
> The IPv4 counterpart ipv4_dst_neigh_lookup() already holds rcu_read_lock()
> around dst_dev_rcu() and the lookup/create.

Please add a patch for this.

Let's wait for Kuniyuki before posting v2. Ideally v2 should include
four patches:

* The missing synchronize_net() in netdev_run_todo().
* The IPv4 patch.
* The two IPv6 patches.

pw-bot: cr
