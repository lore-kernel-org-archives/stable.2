Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764FF388876;
	Mon, 24 Aug 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605467; cv=fail; b=tz/X2Xt4yoebn0bQdbN1o5h4bFOKfmyjla+qrEW8IQsSlBmGgzIORQUtplj4hMnAJsPyTGXoLYOAUAQHcutUAVR2tnIsJQh2KoSvKqP+iTJRLPdhLRIbvkTzVZFWO0fOc5SqoC/ZvEN0aFZ7bLm/QqdNpcRVtrCzSUUa1wWqCLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605467; c=relaxed/simple;
	bh=XKP4ukFQSGxvTEt2og3pnmtR+vvMCa71CWpoklULaW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A1yhlnNmmUQ4NrxJUXT2GMP7CZjVRrpteqNVmf58gY9I/e1aDHzaXzFZaYrGVFOLGRYqGpQ2JqkRosDN/R4YIz0OG+mOxXdwKgXhUUyFII+Jm+TE9k1ImHW5mrP09H/+cMQ7VpCoDtXgzEZxZ4MuCnN+WaiLYOMTXf5eCZrWurU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2oyTaeLN; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2oyTaeLN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IemwIrBwKd8M5BmNCZQQKcVENpyQuObvPiJZ1S+1prTiPz6AmF7i6qhmQGaOcXyVPnsJrltHqyHKCJ3JyjppPPnZTww3Zkjv9Q+1z6iLQ5kYkDHt7iejf5+ZaLyLW3oKKwwZNEBjM1CfhzlBm0Gm+PXhZlOl9gLKpflzZ/EU1npxbL5rULBCLMcqB2jPeJQsAgHAyXcm33GT4BaGOcX5oTjIYivMGEPZdhJ+lY/I4XAoCSAcTOCCY6GIyWP3lQYPcjkyw9ETSlvxM1jeKCaCNgX6Gyz0NbxQkWjmfJoAdzmY0dW3HYzq+hLHMHMgETaNuf40DsIS2ZW+SfVjNJ+LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9mlxSw9rWk94Lbp+x5UxTc10xGGR6OkhDEOoauon4k=;
 b=PchEIM+4vaBQwY6R04Az8IlFRvCQ2KYdqGnbp9kFMqE8Jkiqo3jEw31l/W1NF58Ywx7mo2BzBimzqGoOpZByTYnNORBr0AnjN68v6Uf2Rdpndt1JvEvQFrdpWAYH8uoIQv6fljn3m7MPVBqbZQpp0aG1plRTbqkhW0Huo80m/dDp6qmvp4gVO1LRgcaQkIaz8lO3KW8+G9mxxIUkyYpCIEt0SDzUQ47oLZCgt4XPn/Gww7AURE+KEYiOq6AUgc3KjrFr77BzWu1T9bRpbd35u9TuFA+aqziETwFQ/Pp//HF4jV92TvCrvg4K1pYVLvAVtovoryqS0syied1kOelXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9mlxSw9rWk94Lbp+x5UxTc10xGGR6OkhDEOoauon4k=;
 b=2oyTaeLNyQHSHGPm20h7zzyUZylUMUp+e3NQ1VC1gT5pcqOY96FStBOQ3ZrY3Bs4kpCSLU5aNp+/gGtPxMEv2jbFAorHbsmwQuaGmF5qzNLofitqW04kmAFjlZ3aw53njXx34KGwe9grvmZq9nKj8XAENf8GVCTzI12J/GgH3rg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Mon, 24 Aug
 2026 21:04:20 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 21:04:20 +0000
Date: Mon, 24 Aug 2026 17:04:11 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260824210411.GA1500179@yaz-khff2.amd.com>
References: <20260814214255.83127-1-jason.andryuk@amd.com>
 <20260814214255.83127-2-jason.andryuk@amd.com>
 <49f2616d-e37c-4420-9d8c-81f978386ce6@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f2616d-e37c-4420-9d8c-81f978386ce6@amd.com>
X-ClientProxiedBy: BN8PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:408:d4::37) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9a0731-d1fb-41b7-ec26-08df02234404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Q2gbdLDJ8t1FnUdxnXsRC03WAbE+NqVBELiTDsUBlSGDBUKg49jPA/ZxjFIIdfBJutIl8Alk548Pfyha7SAknsFBoNvmGYyB9HidqjcaMAjyxMhD8iBM8DMhLppSeNJvitf/yAB9h8oCVaiSuDiqZC9CPJ5ypOkRIN+H5h0P247tVrWXccC1NDhC5Xi335gtRsbH+gyOn/X++yGP41vDoiKMbnlSYZQ0LbhOMHSPlRIYevQrITkl5sw4zY8c/skTUbgZPAxWtVtXN+u8yceTurYpEX0gXmjcZOZyUX17FXAgvrkVlrOhLTqGCNISIHSq+21bZDmkWw5c2y5xTBoVHjdMmfVPN6vEe27og/+3kxXBKGMU5kWz+YljcSNaDpAmKqemxqI1Dwtzj+vMLCRt9j77ctpdNzb4RNPQIDbJYo2mA53uGs43TPoH+Pw5Swfes5vluyv6Lci7nTpecD28ypJghp78J6FW0bJ0eGc0IJBRV76CrJx8/30ZkfIOyxKFe+UV/aZWXxHJRu3AHyeAclptvOIbmKZTKFaF3FnUyNSaTK3f+lk/igqXunhN/Udc0eJoijn1jUHkDoEo7UtxWZYRYyLzMsjxXH0HZ/4tPFkLiBmCz9X+4VxuDr3E7p1J6na4wgjaRnMjjOeAtnl5XqPwwpy7lEvWe+dB2BC0Lno=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HgO9RHwTt3tBHsCCjGqK4X+e8sYDyIA7403y+TfG8sXYO+X3th2jXcHKLeWi?=
 =?us-ascii?Q?d2TtH75CWvwUJB6XXSSKJRx2mqDCzmj/kaNPngwQc+Oq9AyeuDoj/Bqk4Vbj?=
 =?us-ascii?Q?n74665O9mLd27K9ZYm3moQzzNIZVKM6Y1Gxx/LIa4vx9+HxBmeo1NjWyl1B4?=
 =?us-ascii?Q?MbwSiOktNz83cWS+9zi2vz+soboh2cg1Whby+wp8omVua/W0K3vyyxnu4Xii?=
 =?us-ascii?Q?ljWNCP1IgOJtIVmgqipXtjEFrYHQe4QX/AGfJTyufAoSifpKuLvAt8CCVbKw?=
 =?us-ascii?Q?irydsePBRB+QRlI/PMqL+/TQkqJOl0bPbXUtogNDHy1e17LL/Y5z2JoLqkuI?=
 =?us-ascii?Q?/F1IMh9sjkT4cBT8Qr6oGulsfUC6zpnDgaq11U+BpmbyP8bmu5mFwytJ9Tx1?=
 =?us-ascii?Q?5QPXH6G0rsk39+Jb3AZv+eilYCFb28Fq7lD4AIb7MTfO3+bgByE2PDRxI+e+?=
 =?us-ascii?Q?JEkfz2qjOStA0/bGsf3EIU0+obupH/yjI/CrJNRuvooBtoB7PRvdC22Zp8+a?=
 =?us-ascii?Q?L4gWYrgnrQLmjp/h8mf0um6r+dfyxGyvjN6Aqm9gEP5Bjr7f8hUBG2xq50ox?=
 =?us-ascii?Q?41LymmrDrsZ6iWO79ELi9vm48qvZ4gpeUTEgdjAgWH+skWw8jhc7MfZcWIo2?=
 =?us-ascii?Q?Skgqmj+EERivDXZoohWZCe9WLmmCP9nd05Sh+XhZsuMwn91uE6u2wFb4sWtJ?=
 =?us-ascii?Q?kyGSroqncEtnkNQm8hZHvIMv9C9et1Crn2DaWA62ACf6T5Fwcy9fSEjPQ+O9?=
 =?us-ascii?Q?YRd3nfI9XOcwDrJRLfrwSrwQNxUcozMn+TdFe5edd2Hp7fio96hlnX1C6h3o?=
 =?us-ascii?Q?HalDnbaz6rd6H9vd9bvxIYsNaCzZHX/yIGC3+rrgSSE3c5W/1cXAH7HZs8Lr?=
 =?us-ascii?Q?tF7lILdzK2zkAkSuFGUxcMsR/e0LWAfIDrvlwBqZwtQVW0xxEsZ2ygsHDFSh?=
 =?us-ascii?Q?VOMnDpoby+ypQIU1cIy3zTVXuKBcBUgJzwZke0mtmwLDLq7iKGNYpV6vBcFQ?=
 =?us-ascii?Q?n4AkqIHyy9hU/njC4BJkMaYly2/ccynXa1uJ3W5+Hpbcfq6GMlaTE/nkO+mx?=
 =?us-ascii?Q?ILrDjwgcY0xDbwFACAnLrjUuQooytbdZRqq5latvRJRMPC8pQivzRhB17WBX?=
 =?us-ascii?Q?LcML+8cbILkLoe2U6Irei+z3WuWpeSW8fMdKzPlWXbYXttHGfEj1KYLwubz+?=
 =?us-ascii?Q?NaMk3HKcN/SeI2z7XJTu4UTqQeWtsHIiGPYINrHg28Ti8Bp+iG5/9kejofl1?=
 =?us-ascii?Q?+2HShcCiM4qu7/nlKVHsfsbbthWRVBlldLohUIuASn+tgEtvPVfZzwp56yvE?=
 =?us-ascii?Q?fFKeoWHxna3zfBcFWw6Mk7kRqZJztrt+zi69GEVC4JtzbyZzgo2meYhK1Io8?=
 =?us-ascii?Q?czrUFvYVAruXhWob+0jaia/5BqqVBM/JYfR6Z3PGEjwkbzZqcRLCDo5VW5lh?=
 =?us-ascii?Q?7Mgjft2DnZ+8dfYgDVb9Pyz4pKu/KZk5zSu7RvIiBX9bN3Ssg1Stfgq0IYIF?=
 =?us-ascii?Q?iGDVyWvNa0ImgL4iWh7hl8uIzz9PS0U154RyNpzIKAmKJGSEC0ULEEJw6MvN?=
 =?us-ascii?Q?2eA6HD/ILx9TnYxjEBwHTJzbUVUCb85O1TwCOjTUR/pNQORm4RAsSYjYmhNp?=
 =?us-ascii?Q?b2GZPVuGEYyMT+VOfUxIW0OSfFThdiFBLCPcjPlDVcZc9OjdqtOIgvesmvgS?=
 =?us-ascii?Q?nWtdSQJPcpqsqyVC1NY5BXiMtLtLW9GtbqLkJNSU7q95lwgA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9a0731-d1fb-41b7-ec26-08df02234404
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 21:04:20.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyD6jbfPS1Lij8BR27n4d1LgPLi4QltdtlXky0NpcTk9ELndMpO667SUfMK5j+tvXfv7jk9rr24iE0Z8LgWvSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

On Mon, Aug 24, 2026 at 04:05:40PM -0400, Jason Andryuk wrote:
> Hi,
> 
> On 2026-08-14 17:42, Jason Andryuk wrote:
> > On a virtualized system, the number of nodes does not have a
> > relationship to the number of roots.  A Xen PVH dom0 can calculate
> > roots_per_node as 0, which crashes with a divide by zero in:
> > 
> >      if (count++ % roots_per_node)
> > 
> > The issue is seen with Xen, but it could affect other systems.
> > 
> > Change roots_per_node == 0 to 1 to allow the system to boot.  Print a
> > warning when this is performed for non-virtualized systems.
> > 
> > Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> 
> Any feedback here?
> 
> Thanks,
> Jason
> 
> > ---
> > v2:
> > Print as a warning instead of error
> > Use "!" instead of "== 0".
> > 
> > X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
> > ---
> >   arch/x86/kernel/amd_node.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> > index 0be01725a2a4..c3e214925d9c 100644
> > --- a/arch/x86/kernel/amd_node.c
> > +++ b/arch/x86/kernel/amd_node.c
> > @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
> >   		return -ENOMEM;
> >   	roots_per_node = num_roots / num_nodes;
> > +	if (!roots_per_node) {
> > +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> > +			pr_warn(FW_BUG "Error detecting roots per node.");
> > +		roots_per_node = 1;
> > +	}

Minor nit: add a newline after the closing brace.

> >   	count = 0;
> >   	node = 0;
> 

Overall, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
