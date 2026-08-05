Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA32E484232;
	Wed,  5 Aug 2026 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948768; cv=fail; b=I487kaWOGy0SfmadI5wIM5zpjrRdQWD2zLSss7E3FfbyMOaAmJMGDz5nkN6cpXpFkVqg0bXsBa4fDIluLES3sj8traQo/+HAwzPHr6clqecadhSO8MW4LL0EPMluLgk9k965WEST/kWDNA/82gKIlQ6gYh+U6AGnGeSw3d/Ta8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948768; c=relaxed/simple;
	bh=OYmBmNtP7AiP+qIbgnI7lo1BUnE7fHOPWAnnzAVI++E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXVJq9SYEO6m9x6dTgv6RqpnVarR+t/7M5nWL1LKaErb8o79DI3IgUrc2kdTvUq682YdOjIToczRtQi5O8R7y+XbUohF68kjytxnQp9ncAntRxFhyBVW5o5Qraq8iFOE0aVCZkAwac35rP4dRQVMB0HlnvUhyPPxf8SjjVUhaTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N3BOD1gF; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N3BOD1gF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdLxJ0K4DL0PmS1u48vNiaXoxgVmq1gCLjc+Q0Y0sZMiDxZZLHKwdyk3JOD0xZkMe5whQhJzWaANS2+KvqhOgF/skGoTxp0Br5sSWPcAc3VhWgvKUIF3R69oSXx69xB4wB49quYCMrPMYYxjzNcrDPGkjeYWNHYqom1CWBbVQh12qGOLzQxgisQDhUp0uEFpKhaVeCaRMQtbwqYMpLOzzObTIZH3KJ9eS/UpkYe7f20lXneSp0KJRfcBUpxcu+6OUX2SgYuzlm+H2U7+JhUkZdvcCBBdZz16U0U2Da87aa636vvc2IfREHB4QI+b67tiqtuJDMwmbP11Ric4r3LBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5NBZ0p18ZUUQUw5PM+69x5Ctt0r8EdS52dDgl+VMzU=;
 b=SoWB4UF5nyc5X9XW51D/RSOcIyACeRlJJxvIoChpsD2PwVBwqtzjIw7lgbW3+tZJPtZ1f1wuuex7AEYtj+upx5errmVbT3JoV/bMa/j7jV0X3BbRmVVYhF6yq/gPfexJcVKvsN01F1/h5DXZCEYJsnIAT9ERHQZ8qG42/4oyaQ+QuETPJUz18th09M1G+w3/MS5Iw6VAKV8gv8ttkOOlYd2pPY6q19RjF5cOybXh8H1H0kCZ3Li66UVO9qU86jLJlnvlKXfgfHt+77rfvhRFve92C+6Jwp8IQgHBba+qdBWmsmfTFWXcCMP38uuAt6kpy0fdygk+mjU/BCHGTfN2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5NBZ0p18ZUUQUw5PM+69x5Ctt0r8EdS52dDgl+VMzU=;
 b=N3BOD1gF9c9ou7RuGC47S/27FNDtOltFh7+ziZrhfqmHfW2L4L3dk0WsRgk3fcYYEFUuOZx5pdRcNVfSdMzx0GurxqCKmIFADsIIbEnfIpSL1NOTg07F88vsLgteqR9lKnar91yXIY920gk8v2DRvL60xBpSjCvTWeC6v3v+oSY+Q+JSudqRmDxWoy1ZAVjSxZLj9NgQd3alMN0aBB/FOHOe4giRaigvEmo5U7LxIyozkXomc/n3nM4UqrZLejXclJ/M3VM2dyM2ItHWgZLaTQgokK/dITpmVPKddj4V/GvGElGmXXPf45rSP3+PUGxh7LKU4ZKkFnuvSE7T5LMlbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:52:42 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 16:52:42 +0000
Date: Wed, 5 Aug 2026 13:52:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: let special huge VMAs bypass the THP
 policy check
Message-ID: <20260805165240.GR27883@nvidia.com>
References: <20260805055544.1568534-1-clg@redhat.com>
 <20260805121524.GM27883@nvidia.com>
 <anNkjl0qNHK47WTD@lucifer>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anNkjl0qNHK47WTD@lucifer>
X-ClientProxiedBy: BN9PR03CA0414.namprd03.prod.outlook.com
 (2603:10b6:408:111::29) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dfbed6-4b30-46e9-b3e8-08def311f75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8oWdL/KpjkvXHd2fLfIVrnHscq/UKicDrCwbwVmNgchTxJ5r6qfBzjvs4NmZcnqhXp+/QT04ljWC7TXp6pB6KGr8s52nnwqDJ1gBDBpMJVl3OlQptARN6hzGnQ2PfFoXwltUubZ4XNXTHatxxMWEBQJo4gEnUQkLGgiv0uLltpXZ2qMGXWrfZ4hCxAYtoLgQbBjlhcgkz74z7ojeuGBw7/chtHvT2HMyOTrtI7hQkZtBtuWIH8worpFZ346uEV8g5c6TTSdv9Aedw0HuPK7tFUC5RCcr5u/Rb1KZBuNGZZ0y9so2R0GsJ3AanRX6dVVtsqTXLg7S0+Kc5/TIrMmy8kPa5uZq2aNknMmb3VOlT2r5UaThgzyVbpIIgINhNPN8j8GNu2SwlVcrKfm/ca6zTUaQ+rs/Nq4qXjpgcdZ+MMavMutfokqMKVZ5cOvSF7zyPYGWcLQI6B8hHexj7RZD1YXlHcXJdIgU6CITizacjeU+FiQ4Qf/V5Jx5oKPp8kSqv/Vyn8aFj711QO+34AdU/hfJ2Ai2AtcQy9R9yv9weTtWm6oRnOd5ffciLuSpsIizor5XIflaGB3yHprfQgk2UO9faWD6U7rlgvGqdeJrM9rSb0rq8WW4czPMyKUKughoH7t+S84b5Hmv2BEOQAh5+sRD96Xjli27q8I6jQ/13KM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHlleXMycW1VMmN2Mkh5V01rMDlRQ3g2V29uTlo1NVdKa1ZERzI1UHYxeStY?=
 =?utf-8?B?dk5uNE1YVEp5ZlAxQ01xOXVkMTQ3M2lVT25BTnJNNUNFNGFVeWpmS04yMWwv?=
 =?utf-8?B?RndsM2ZkNmtKVmRtZGdKTmtIVXIwMVppWGlRQ2ljVnVRbHpBTjZlRWQzQlh6?=
 =?utf-8?B?YlRkVTEveGtjUVpxQWtwTXFLdE5NU1k4WnhlbDU0U2U3YXNWYzVqSldiMldL?=
 =?utf-8?B?bTBkOHZsUjhoMXlvMlpIbnN3Wmg0a0JPTktORUlNYnhGalZWT0JJajVFczBE?=
 =?utf-8?B?TDYxRHNZdDZCTURDcVYwczU5K3JlVmlkMW12blY3M2FSYjBLUTJPVzRITVd6?=
 =?utf-8?B?SnVuNUhiblU3bCt1eDJ1SUM4eng1SElmOWF0VnVkQmdKdUNDWDVYN09Ec2hJ?=
 =?utf-8?B?RHBYVWpoRyt1aVV1TDRlRGpsVkFJRE40QXR4Ny9BSXBsdzlGS2g1b3VmWkd6?=
 =?utf-8?B?YVp4UUIydnByWERTWHRGckYzS1IwdVlmV0F3d3ltZis2MSttcHhhbUViQUQy?=
 =?utf-8?B?M2tLNlo3YW9vREVGK2pZbHQyQkJhampnQzV4K1BGdjhxZ2crYU9tc3hVemU0?=
 =?utf-8?B?a1luSFZUNHhXMlowZVI4TW1IVmpuTVVLaUlDbkhHa1dLV3dPRVhmcnRHU2Zr?=
 =?utf-8?B?QVRDMWdBWDFCb01HeWV2T09lcjUxeFRESFlHVnhiaTJMUTFpNTJJREZkZHB3?=
 =?utf-8?B?WjJPdEtJU2dqMDJTOVhQYmxkcjBVZTl3bkJ3amhHVHhpYmNZZkVWcmJ2dkFi?=
 =?utf-8?B?M2hzd2ljV09EejJpTythdXdpUXdxWUhGMHpoSG9xMklJVVZ5NlFSOGRqL3Jx?=
 =?utf-8?B?QlRCdk9jY2prNG5Kd1lsYzdZR3ZVNS92alZCMXA2TGxiUXl4N0RwZWdVc0F1?=
 =?utf-8?B?bGxDZnM3aXphM0VoSitZbVBjRndVcUFwZXpXZHJsUlVTcDd3VXF4VzhYMEhy?=
 =?utf-8?B?MEI4ckN1UnpIWTBqWjZXZElib2Eya1RxSkZxdmdYUXZndVpzVHJIbnZpbXBL?=
 =?utf-8?B?ZzVScC9rTkJpb24xYnI1MHBVc3owSmRiQU11b3FUWnJwa0Rid09UK3plVFZp?=
 =?utf-8?B?ZWJTZ0MwYk1vcG9IWFIvakpucUhpMHdvSlpGZWZNeE9CMkZyK2cvTVZTNS9B?=
 =?utf-8?B?MnBrR2RKbk4xK1ZZMUdtdW5ObjRnSGtValBZdUNHdk1PQlNrWXNDajZvZTFB?=
 =?utf-8?B?bGFxU3FhdTQveWtrTExvR0RRdS9ONjRrQWowYVZYSmpPQjEwSmNKcWJuQzkv?=
 =?utf-8?B?SG00dWkwNitnRWg1V0VleHlYMEduRld5b3pKQ3pzR2NmQm9oSGZ6QUJGQzNQ?=
 =?utf-8?B?Skd3TUhDaFdDMDNEMEFlcHJsTjZvcEdzMC9rR2pUL2JOL0syN010NHBMdENC?=
 =?utf-8?B?azRKT0piZnZBNHlHQUZDTGZFdHVFbDhWVXR4bXdZTHdvWjdLcU42WkZWSnRx?=
 =?utf-8?B?bWlTS3JUSy91VGlFYXFDV0xUcGswamxsQkZzblk4cmhvekJTSjNqb2czaWh5?=
 =?utf-8?B?aG81QWxBYTBIWC9BRFpYVDlCZlBDS3Ewb0NKejRxYm9XVGVhSG1WZTI5dmdZ?=
 =?utf-8?B?STQxMHZQdkF4eVUvYTQvcjhTc3R3OWFyTmk2aDd5ejJqRUFWMUNVVlB1cXhZ?=
 =?utf-8?B?c0x4UmR0bjZ2U1lLTEhHS2N2VER6cDgxb0lGckFsMmQ3NFdmOHMzcy9HYjVv?=
 =?utf-8?B?Tk1mTnVKLzJiU251MEIxWVBqd1VrRkxMUTVLYUE2N2dXR3FCeFRvb3pPSmdK?=
 =?utf-8?B?S25TR3FSRjk2SVowbDZnL3dxTXZqYjh4S2ljbjhBT3M1UXAxQ3JhQ2ZHNkI2?=
 =?utf-8?B?M2h1a01qVkZPQlhnRDQyZXZFNjZjajRTT1dBTnZQL1B0WmJIT0xydnZ3Q0tL?=
 =?utf-8?B?RWJ6T2ZtZVRGUnROUnJMVlQ1emlzMVJ6ZVhFUU5scEhBM0ZzT2NFRW9wcWdi?=
 =?utf-8?B?RUhFc21tb25KbGdMY0hsU1JudTlsamV1ZnFhMmZ4ejJYa0x6Z2Q0bVQ4MlVz?=
 =?utf-8?B?RmhqWGs0TU9HSWZ3N1ZzU2pBTElRZ2RwZGtyN3o0RVdheDFEUUxyKzlFdVZ2?=
 =?utf-8?B?cGc1Y3RlZWtHNzZyL2JkMG5pWmxLOGZTWko2a2hTQjVKaDhjZXcxcGpSelhm?=
 =?utf-8?B?d0FjVTRSMlpvb254eWx3b0c5emFya1QySFpLeUtpQml2OXRoS2x3RU1NZW1h?=
 =?utf-8?B?Wm1lejJaU1VoeVk5TFVCS3AyeXdFcDhuQ2g4ejZkYUpPSU1zMk5BOFNrWFQr?=
 =?utf-8?B?cU55MnE4L09yNkIzYW9acGZXMWJZdTU1MENIelE0QjBIM1dEcWdnMW56cjcr?=
 =?utf-8?B?a0JBdXNwOU9jUjdvT2szbFhwdjRxTU5mYUpqTjd2UzVNKys5VHR5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dfbed6-4b30-46e9-b3e8-08def311f75f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:52:42.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiLnvLNLC/JUw/a4E3o6TIETpR8BnLdK4J9BAYFKgfutRqGofAfU4k5o6FbXPLWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121

On Wed, Aug 05, 2026 at 05:29:34PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Aug 05, 2026 at 09:15:24AM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 05, 2026 at 07:55:40AM +0200, Cédric Le Goater wrote:
> >
> > > The result: each 256 GB BAR is mapped at 4 KiB granularity -- 67 million
> > > page faults per GPU instead of a few thousand PMD/PUD faults. On hosts
> > > with 8 GPUs (2 TB of BAR space), this causes VM boot times to degrade
> > > severely, with 99.98% of CPU time spent in the VFIO BAR mapping path.
> >
> > Broadly upstream we expect people to use iommufd and dmabuf for these
> > configurations to avoid all this nonsense overhead. :\
> 
> Point taken on that :) but I think it's generally reasonable in line with the
> huge PFN map changes to do something like I suggested.

Yeah, for cases like this working with pure PFNs from some non-folio
source the size should be entirely delegated to the driver, and driver
should always have the opportunity to place a maximally sized PTE.

It is definately wrong to intermix it with any THP logic. DAX isn't a
special case, it was just the first place to partially implement
something that looks like this.

Jason
