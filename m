Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89416A395;
	Mon,  8 Jun 2026 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886224; cv=fail; b=Z75wGPybtnDPsiUd8rPWnJKBAiME85TZ0AUsHtiDy5rcngT40uw4XhzySyjG3uYDsh0bPUPBdfbsR2eASPSFXRtZSaylS5AK52Pd8+N17Vd2neinAJTEyE74JshRndAeoQQbS+XQ8780N9yfUmunQA3b9uufOyT3hcSxAA9PLOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886224; c=relaxed/simple;
	bh=XcD4UFJYLOL5D+8+USPFfaD8FASj73zEJzDUaOJnjf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/IuenZaRraLAz/J4eGV0oRo1AmJQkqlqf7G/iQi/hl3yKIk8X6q0f+HIfhtVJJ3wsKGJNRm+7naNUA2Milfk63J7zRh3t+Kc/uFn6Fn9QVRq43WA67m/excq9++cXvZLVf13HtYJtug8h1efT1N6WAW3eZlVx4z3lQv03no9hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d0+ScN0Q; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d0+ScN0Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8zlnr7W5Tkf97Z0u3Dq3xUaj0Jaz/3z+4yEG0IkU3Z9MVMv5AEt7hKpYvqymtrlhSE1vAo5VaatcEh1FanpgArQZ0oy51wrgNay73S4f+tmZiTXpA54XaNrEvNU6rqOgymwaO6Utoh/dpQhpUfcwRjntQPsa10v73T+vPj6fDzVEJxMvtoBTBpug1DxSq8oKwMweowuPB4tZPbqdSwY72IJCU/wUq1DcFXxsgJW7SRH7vUzm4aoqNNGg2juzYF/Zf1EmpkJXZ6XNgklwWrTptjtX0mzYs8hPrjrCnygKhV1Myj1tHDHkfV9G4h/CFPLkytjNLlRq9upWnaU0oIvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWgaGR5AH1ATyxfFn4NWnEM99Yzf2WrOc/Vahs1AQHk=;
 b=uliqec5AsjUseqLpfBUI6NNdK0eGZpqbvQbGzhWnthHoHUGHQKrFxDTFtwOf066SLYMnzoLcHXbzuwn1QVlmwhF9QbVoKym0nXWj7kpuQNq/WDdZsL2MPQ3pzJz7158i3hXBmihx6rURS+3UUtvkOF1fL78ybThg/NJU2NYQzCqp79O4burAvrYo3l3RAe+QtuU6edqBZl+IQhVN5B4GikdS/mrDFZoE81m1RAAZf/N4St2zKjTJshFiL0F3NXQpUaxwqubepuWiMSQPJUfQYpK7EBG7h15MOre+KK6D6qTNhSJ7tUTTN9xPqGsmxeK+nZOC7XYAdDEDlipEtCpgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWgaGR5AH1ATyxfFn4NWnEM99Yzf2WrOc/Vahs1AQHk=;
 b=d0+ScN0QFci3ybZPWWb1yurZDmxauRNHA1PHkr5lLiZrGP751rtj/bXQQotpzpnanTdn5+qF7PbVTtZDz6di2BGcf9bly8x0MKHhvBz6MV1CpI4XmZgNM9vL0LeFE/fQHpjJ/0W9WMuiZLSN1SA8Vhpu2Fjey1JSukHm+dsIlENNXsTKIyZSdaRGENfOJTX41DbmGwDPwHVuYmwru1kq9zXoMhnFU0wRWKJRflXV+wu4VX7UrWXGcq37EsmzaFcEH+y1q/zsgPss74VllqAaUxnHNaCf1JOeC+UzDce5g8blX7yHQ6fsloGzRkCZ4mG1vwy9dyhCA3gW7EElMAwmSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB10656.eurprd04.prod.outlook.com (2603:10a6:150:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 02:36:58 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 02:36:58 +0000
Date: Mon, 8 Jun 2026 10:35:53 +0800
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
Message-ID: <5uaimvg4wpps4ipw6vdnrsxovkyccset7smdfo23cwl6667e6l@pwxagodfr45j>
References: <20260603-fixes_fwnode_iteration-v2-0-0ae381f8b7b9@nxp.com>
 <20260603-fixes_fwnode_iteration-v2-1-0ae381f8b7b9@nxp.com>
 <ah_2i-jWq2kBRJpe@ashevche-desk.local>
 <soxsu3t7ntgnbeeic5mygklzdpohyic7echo5trnzuphbpe6b6@avr5wwkbojvm>
 <aiG62GXa3tYhhMBQ@ashevche-desk.local>
 <6keyevnyndjeovbpiiufp7ejrtz6sfelu65evhg7odgb2tyxrf@xtmiqmko2kuo>
 <aiLpVIjws1DO9l4J@ashevche-desk.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLpVIjws1DO9l4J@ashevche-desk.local>
X-ClientProxiedBy: AS4P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::9) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB10656:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fcde48-0ddb-45d9-85e5-08dec506cffa
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
 xt+SLVvyOJ96Uhga0peEl7q0yk5WI1lBSmhNkksn+yWAAB1I3/T2i0LNmjd/6lwYL/4bkIhKAVq2n7CR+EDqStWweD3zU2nZLdQoW6DWklx9bSvjjgTJQeNa6mW1+alItKmwwlMCi800WMmuldEB/a0ILzM1QlAuuZEjpXmV8SItDaQhsCSaK5vITBkISfd4lY4p5WSMTn9Lscxfe/MuxcolPKybsJ+6Ckuey3PdItGMp3iOPg8jJTv7uZOLlDzS1enpDis+RsWz0MJ60B/atW5eO+gXx1daJo289MGhBUxsg439HBt2ahItIL5Jf3Wtqjol9rjyrTlzNr3WjPj0G2Z9W/xvLbR3Z7gRlbbTC0V5J+SDr85oHhijbJnZRPNy3Ubn52lVkWe+VU12D6hGR821R6LBSujgN8W8XitCRxfDa9o82SDcX5jHcwlUFwJ2Zx4Z6tsz7G1HsnQf+mS8xMtZynDyZkbiGaD8CJv1eLs1I8PF364Ms6uq7eEVkVxSDSg5vIcyp0vh9eea7LTyn9EbfD/hhtodLywOFS+MlaNeFvMyLhfth7+n8YkFAIP4ByI/6A+cCsCgbi8y6sImMNZ9nr+TUUo4uNqbp3bM8E4Xwz2Kgj8C9duY1epmXYwh674KTb7ddtqFYqwuI95zmHWg0j8NLR7c0VriVAfGPOuv9QA9InESOVjRYhS1Sbdi
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?/jwR9CXJ6CGTQcveCvcPbkucBBxpz4dhVcbuFvyPS2Un1X/LM63vIy4T4+0v?=
 =?us-ascii?Q?SYAxlOy6fvIYEHrCllS9wDEHfAzczYHAmV/6ac5rEL6BgRv813Nr/+x3H8P9?=
 =?us-ascii?Q?pqXZqJJDT5oZhfNueMZUR08xBFLqem5bOX6s5HCjHAesrAfu3EgIzwL66kjX?=
 =?us-ascii?Q?wTtnEN4QG/VVChTy0SXT6ISnLgmtD6zgozarcuThqZxUcMMlqaJB3niU94mu?=
 =?us-ascii?Q?uYo3iusUgJ9kXw6AE6gpdmCZUw96+LPM3BX+QJ67wISCCc4XpwDbDhfh8hXC?=
 =?us-ascii?Q?J/+WKWNpmMzpFD/HWprr5FIhQRxog1Bi3T+eQcZ8ADHYS+ErTWX7OGDqEn7r?=
 =?us-ascii?Q?R7FPzB0Y8aZWosNuXTEBSXuNwrSaBY2TlhdKBexjzltv9tE+gLbq58E0i1z6?=
 =?us-ascii?Q?zLgnAP3088FjDvCQwqTUtsGgLHGcuWvcZDXP1nn6vHTgsgioxsIawYdJwE3D?=
 =?us-ascii?Q?melpJzGPF+rvIiJif7bYNd46W1tr0gSQ7+n6E0PU0jeRvOiJ6TEXcuKxaLmp?=
 =?us-ascii?Q?zYNNZXdn0AAvsJlbWpBUbpnKI3LpNA5g/VSMiiaA6dp0ebQpHP0kck3FHljf?=
 =?us-ascii?Q?JfvDmFZ4ixy5uoheVE7kFjcv9qHGQC6XsLDdeQqQoVpUYqU4UWDEwqdAf8rZ?=
 =?us-ascii?Q?FGpol5WFm2urMLA8Esauchls7fg3cblUVMwlBskCMjiCwHl6zFRuxCdsiOux?=
 =?us-ascii?Q?994LiJ/gTzeN7KLdvazx9qGMU56OKBG0EgB8wRTkdZmk75nwAqEi7ekjG6e5?=
 =?us-ascii?Q?FArLzmDdEp3hKQovPVwMcboEo5xvTEqSRH/d1Ta0pgq4seskSkrLbfXRfuDY?=
 =?us-ascii?Q?NkNL6syzqmhTlV7ntrku877TQ+uRRdX7DLKUix0a3El8Gcs484xViTo5gcc4?=
 =?us-ascii?Q?eLMhiIMRN+UWuQTtbhqp2bQP59sdpVynLT7O2TwvlefUjCq9dVPK8s/fJfZI?=
 =?us-ascii?Q?ieCbecKqs4rc2vdbVuBARRQReYxa7BRJXLpTIbDT1znbAX1DZ0uaIaE2kKAq?=
 =?us-ascii?Q?GxC9B3jy/xsoHLfuuos5B/puN2irdP/82xBzj0De92JLdWI+hF/MyDGmRqyL?=
 =?us-ascii?Q?tZPlUOdJJAKN7xymqjYLHbMLzpYgNQeWj5kEczyAy7qc/uZS7SQ4wkJKARl2?=
 =?us-ascii?Q?9e81kj4Cu1CpdbQNw1iJw1UePeP9ep4wJO0J+BX1hzt42KWJz+PKYdlCaHJW?=
 =?us-ascii?Q?sksj1gF6QC47aL5IIyla5N2f5YN72eLtsJZaYECcoZAaoDwBsnhWsJVUBzsr?=
 =?us-ascii?Q?vRJ5931e5ijS4fsu3eLjd7s+ecizXouMQ4sSlE3vC/zvdnjXvJmzUoVrKh3M?=
 =?us-ascii?Q?5jpA6hmCWl8FQftXLaCDMW0xcwLfUsBqVPAYeSQ92ftbB861qcC7Io/0FQaL?=
 =?us-ascii?Q?Qs03sLvsNjUmA71+ZaHBOFXgqLS30ToO54SkXPvUMmgMIOxFJ64bQQdwpZK9?=
 =?us-ascii?Q?+i5Rsyi/e8nREsszYtkFLw+ZEc37HaR8lBUdBxawg8itmC/Zjny7IEEBdkSt?=
 =?us-ascii?Q?KeKOTwZ8tS34bgR5RW17Pdul1fWrLUCzGThwluTAUlMOYaZwwJKmPmH7GOPW?=
 =?us-ascii?Q?dWZum7Pp699qrTcTvRCF34N3IMRxC4hmgUoEZAMTHurVxCNKHtZIMBF8+chI?=
 =?us-ascii?Q?1RHl7eQHfSANCwVcBhE/v30Za/HRBSOG12/HOe84kZDE0U+xlxAdsRwRC6rK?=
 =?us-ascii?Q?8aL0Z81i6b/1iEqwSq0WYIF7wLIArl75/Pml/UazO67w5UDtMz/C5ZvX8oWT?=
 =?us-ascii?Q?DZYHj+111Qg5IxBkxHkDZhJI3SioYKhKCx+31V81GczfOpMFOKCj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fcde48-0ddb-45d9-85e5-08dec506cffa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 02:36:58.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbO8DhFXqSdGJgmsmXgwze2yttcA12RJrDOMBLvipVBl7EhaY3XbxoObDAp8HoWe46z6woEOx7enUuEi8cZqtETNFbavYGPLsRq3TFjCeTENtahHC0ao3P8D2O78vWQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10656

On Fri, Jun 05, 2026 at 06:20:52PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 05, 2026 at 05:16:32PM +0800, Xu Yang wrote:
> > On Thu, Jun 04, 2026 at 08:50:16PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 04, 2026 at 07:15:26PM +0800, Xu Yang wrote:
> > > > On Wed, Jun 03, 2026 at 12:40:27PM +0300, Andy Shevchenko wrote:
> > > > > On Wed, Jun 03, 2026 at 04:44:31PM +0800, Xu Yang wrote:
> 
> ...
> 
> > > > > >  	struct swnode *p = to_swnode(fwnode);
> > > > > >  	struct swnode *c = to_swnode(child);
> > > > > >  
> > > > > > -	if (!p || list_empty(&p->children) ||
> > > > > > -	    (c && list_is_last(&c->entry, &p->children))) {
> > > > > > -		fwnode_handle_put(child);
> > > > > 
> > > > > Wouldn't be better to use swnode_get() / swnode_put() instead?
> > > > > *Yes, we might need to add some NULL checks there.
> > > > 
> > > > It's not newly added by me. The software_node_get_next_child() has been using
> > > > fwnode_handle_get() / fwnode_handle_put() before. In my opinion, this should
> > > > be fine since they do the same thing here for a swnode.
> > > 
> > > It doesn't matter who added that. But according to the point of this patch
> > > (correct me if I am wrong) is to avoid bumping or dropping reference count for
> > > the nodes that are *not* of swnode type. Moving away from fwnode_handle_*()
> > > loop we make the point clear.
> > 
> > Yes.
> > 
> > > See the of_get_next_status_child() implementation, it does *not* use
> > > fwnode_handle_*() at all. So, making it here to use same approach should
> > > fix your issue, no?
> > 
> > You are right. I had also noticed this before. Actually, the difference between
> > OF node and swnode is that OF node uses to_of_node() to filter out non-OF type
> > fwnodes. Similarly, swnode uses to_swnode() to filter out non-swnode type fwnodes.
> > So replace fwnode_handle_get() / fwnode_handle_put() with software_node_get() /
> > software_node_put() does fix the issue.
> > 
> > When I reviewed patch #1 again, I found it already fixes the refcount leak issue
> > because when it switches to the secondary fwnode, it no longer passes the primary
> > child to secondary fwnode. So the patch #1 is not needed anymore. I will remove
> > it in v3.
> 
> I'm lost in here. My expectation that patch 1 should fix the issue as it won't
> let the fwnode_handle_*() be called against wrong type of fwnode. What did I
> miss?

Sorry, I meant "When I reviewed patch #2 again, ..."

Let me clarify the issues here, patch #1 fixes refcount leak issue and patch #2 fixes
the infinite loop issue. Although replacing fwnode_handle_*() with software_node_*()
in patch #1 can fix refcount issue in another way, it can not fix the infinite loop
issue. So patch #2 is still required. When patch #2 changes:

return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
                                                                   |
to                                                                 |
                                                                   v
return fwnode_call_ptr_op(parent->secondary, get_next_child_node, NULL);

the secondary fwnode will no longer deal with primary fwnode's child. So patch #2 has
already fixed the refcount leak issue. Therefore, patch #1 can be removed.

Thanks,
Xu Yang
