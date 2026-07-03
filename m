Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D663CF210;
	Fri,  3 Jul 2026 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079847; cv=fail; b=psreZtZhAuJ7azBju54b7pW7pWVJj1+u3NeOMWKTiLCgGAUZ6a3qD+V6W3XRVaDKpIpenaltdgPvAxWAc13aUpaUxNXFkAPfnBLFkZdMZtqDOhPznxIrKjkDVHwwTAzxfun7aSqhj475Ir9VdH1bnrm+acxIAz+hg6OK83yxz+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079847; c=relaxed/simple;
	bh=Id6mE7B4l3k7X3IfDmfoBqHUWLT8zQo9UWLHhS68ZWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKAY2QfvUp8dN4QhV0+oDBv3wlGdDo5UuO3M2gUTu4kmLDU3uQ/p1FaFmaXFfXfk4LgESwbUw1GnKTp0mTxOkuvckTsWmFgpLtJA84ytuiTPAb8dVs2jGEkbiqbOQGcMAiJcKrnVIGxIwVMDflF+ajZWVE+Cvz5Hk2hBcPY8oqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hsylK4qL; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hsylK4qL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVAAetJFYMfUu+GOh8iMBPA6c7iKtNPJ0tXW2d5GXS6D9FOgGKghMWMJHe4N5IDWRjRQiTOFxcw1KQz6ju3jfGsZRmCigevSK3bZTDWUykEf7lVd1MWqlJJxtGS20tGifV7u1Wso+C15sz/Q8R39AxeKItO6FNXWJSzTrlGHGfA0tOysZPkXBwCrT5St5GkjizJCDht4QOqCINnU6CGce5u1zZzslk/P0ZOaE9vqNi8dg3Xav5Kdtj+I0ZBwkox7D1lXuu93x1ffG6gEtiXbFc8CUj7slaxKmi8fETcYieGFgB+Ia0Cbnf4n3eHRvx0uYYmiIRUQmJjzyZV+IvqWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QOsL4+2T7q9ePiZXmkOSuVYk0E3Uz6GSKVaw5t4FdE=;
 b=Uzwdf2dEcNmB8stecPTK9DNVPAE7+x1uYmStr8KMTXudXlWqP7tDiljy5IR4BJg/QYz2dHXRbOVRxLp1CHTMrcG9+X/nhH/OprU7GkOjayy/UayVqWQFZmIT4RwPTzh/NZQ+dYZ+0WUA2I23m9PhmxEVJInx9HVaSLuAAVAjirJgKJ+Rr0HbEo83zz++R5Wss23kc4RxnY827Z/VfjQOAt3AA5bumBKH90nLtd0sWdf/rODVbgOp6+1HSAQ+DPBvXCQXeH5/oPrgKZ+zvumLcAJ7A+sEALzBkAxaLlKhwqViKiPDB7qxTolTlhIQCCbH3B/S5gnkXQ1G9NC1BbY7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QOsL4+2T7q9ePiZXmkOSuVYk0E3Uz6GSKVaw5t4FdE=;
 b=hsylK4qLbtU9T0W30C5yL1qgjHfifg28jJFwers3ODa4h0CMEJDLcd2t/el3B0MB00ztf9KMo0ZVs4WMw6DAwVsYJwQQehhBYkBQ/Cx0gPAQoAxuTJQaU13cUQI+D0mrLPdqi/nD2Jkagbu3c/R99bBn7PsE0i9G8PEkmAwtGN5j/0yqmmXxUR7FY6PB9OpUs8PukgxLRIQou3VtHAe9BQ3k5hUjHWQmfvbRnBFTbnDTocpDPOxPNniBDluOohgm5xGQSCzlAm/DTMfaEzr7XCCeo2zN34jkwqRc0AOtZGs7nP7c6TN3hI6Q0NK941SrqzpqNVPMxjar6TplyWXlfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 11:57:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 11:57:17 +0000
Date: Fri, 3 Jul 2026 08:57:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kees@kernel.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260703115716.GO7481@nvidia.com>
References: <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
 <akUX3T3fIoN42sdM@google.com>
 <20260702144157.GM7481@nvidia.com>
 <aka7N6oLVq3CoBqn@nvidia.com>
 <20260702235004.GN7481@nvidia.com>
 <akctXFSALBNfYWww@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akctXFSALBNfYWww@nvidia.com>
X-ClientProxiedBy: YT4P288CA0029.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2cb71b-272e-4238-735d-08ded8fa3ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|3023799007|6133799003|4143699003|18002099003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	6Ptx5s1AupBvftBJTYb7t2HNFrkz6XjNqjcfPHeuzLeCvNFOg8SCAZsnO6S5u18Nnva4zNtAZTGsiXTnMNWa0jRQcp6UKXr5YrpuIlwAaNYX2jEL9VbfuOMAr1oMe5/tVJKHRDnS3c0mXklUCdoolG2bdZWudHFjQmWGNfvGVjBF5QlKQvFGhilBYgH9FH0QlZjdEvTj/4fjpT73OYLueP+Ln9Fy6BmFWIb7Ob/msQ50RYmgKqQmPtHD4dTVQnzJD6tyP4rUW63F96ba2RHtb0YbDF0Urr36rbMrI2bcgH/EGHchZzpU9An5Du++RgoDK0kBI8sRlbSy1lLg4HLip1WyqoMAbSoNUxSH49ncauMlv0eilX2x7H4v+dKFzDtWawvMElcCslZSvqqfm3RalCVVwqgqD5eRDAPuS1O6or9mwXu2dFSoY5YZPAQ9GoobbtMBqXSEgbBTgBwIvFMDv0WiQorXOGTLl96rqPceTUqKiOQwLbqVn87MkXYqQtPh3NLlRLrZp4/hnAsEOELKk2C0sXtaDs4EYBjdd0t0R1HhJTsUg/6bBWMaZkbqmXbaIN3qP3iQo9/qG8lRs3fm+1On+hTEp5++XGSyyfOBqzBz26hTdL3Bbx54ttaZ5WAe2NMbZJ7TngLkabnB3aGptZR+F5uToIFsFJEFPV3OVrU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(3023799007)(6133799003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTFi51um9lE8YwodncoKRAnj1A1zEfUN3GO6NFhP0cswvJJtzsOIrdJ0J2mw?=
 =?us-ascii?Q?C3Q1f0ZDUt7SDag+yveH525ZpdjLNnYZVH2k0rrUtnosRpAKhb1fs/Hc8fWF?=
 =?us-ascii?Q?EcGD+cukTvVdd7ymAnzSKiYOlBqsmzzVuQPxubYLZI9WJzAwVHt53W01Ttl8?=
 =?us-ascii?Q?sVzUAM9ps5BUBTyE83pO1Sq3K25ZnMHy5D8kN1Ur1eXPCrYGFOJ4ShZvsxfK?=
 =?us-ascii?Q?bYPDAIUd4W+i0q/X5O9Gfd6J2SRK33Q0jbRumTgmo5ihBjuiuWuNCyOZP4p/?=
 =?us-ascii?Q?dOh5QcbHIk41/I2IG9aO1K4lmiRK34wngliGFxz9cALqY6e2RcqC/kXrv/KB?=
 =?us-ascii?Q?XVYgjmgVJsocijGPP1335ENyLSK5nfEde8sWCiO5aNOZODYGkhZs9f5uTzBk?=
 =?us-ascii?Q?jNqSe/JLapzNIY9RgVFa8SPywa1uG7SAGif9ZCVnViIwnCHQZoxZvBBEpa71?=
 =?us-ascii?Q?TK9IqNL18kKPxdTfnPjGw46uvBAOTxcHjtSfFZbIkcYnUfeRfK19cnZ/G8IP?=
 =?us-ascii?Q?R6+EMCeGOx3BV8HAQivoDBrud4sVqcpo3d8X48nRiVYjewIW00HPme9NEEOw?=
 =?us-ascii?Q?WT6ZeyZJChET4MaT6BEstM3VdYKQQCvAxwDgNQeEgNN6smH/yPDpv0wZWsgI?=
 =?us-ascii?Q?/Z3Sh8NkfbJLy4z+RfMzDmb5yVqgXYbJ31FvAy10/0PLvGeEUIFewA+1tadM?=
 =?us-ascii?Q?51oTzvYKi3PR40yHNaXAZHeSi5jDSSxRyMNGWeCRgtJ0O3W9qh9DjoyUlV5c?=
 =?us-ascii?Q?YTWYYQzByX727NciP8RJVC9StONx+tA0O3aFjbf3ZfmSgZVIMZFCOccKQ+a8?=
 =?us-ascii?Q?eM458ASdGE+6wlxfyblK6m36w34y+PJoZXzCA95xxyxi32V9v9H3Ha+brf8O?=
 =?us-ascii?Q?YKxno5D+7rK1wxkxL4QgQU66w3Pq/EKIFuNhLl2tjCZ5y13MPP/W1OwkIbA6?=
 =?us-ascii?Q?aX++fcRO3owqPn1PDwSXOHZMxtvM9ykCZ9MoWyyRTiJzJA8qve8kzJo+uQaS?=
 =?us-ascii?Q?X1PAnh/Zi0nlqxNjS3YYMBxZsRTm2LSyEJbSsQVrndZoLW1LlG35oh+aRKI4?=
 =?us-ascii?Q?DjjWdcuirN1wSquj/Xv1Ku3r+tdMPlbnXp+zS2aNQbA6NDNL295yDv9kITtr?=
 =?us-ascii?Q?TM8zn+ZIikoaFgcAutTTl3yhmpKZzBTEuWaVEXZDBj8+mTYl8+JdUi/IeGY5?=
 =?us-ascii?Q?R4ZzG3dydZQPc/5t28+iH1qnYNkh4470N1ZE0KjpeZk7iXOXAT0KHegmT4OS?=
 =?us-ascii?Q?EQihF6bQZdFZw3NjA1NwOxxmHp76cfhxI2JAUXKPcfoRQsmbUtyQ1lw3af1U?=
 =?us-ascii?Q?XgfhrLj87WVtB8ozmDTAjA+zrQse7Gu94n0kX4BE1HDlPI7SQireFJrjOs7b?=
 =?us-ascii?Q?TrXM6z+HWP4hCZqlcog2heamKbf9GXaq0zyKLsARvapYqYXmh/16zAGURPnz?=
 =?us-ascii?Q?DsKaB4nr8pQjKkLD7hHHJ8h2L1XrUM4tWQu+WESZphpt4GvkLgDoHZZXbdLe?=
 =?us-ascii?Q?/7Ls5p1CYyPfc1sezZSe8tCl8vYdq7+Wuo6JbbxlzzyV6qQnthcroakLjMOT?=
 =?us-ascii?Q?4PtgisBn3V54ZFReVP3M1p9za+6LoiitCOVs//B57OFIyUsvmx1ek05ieR0a?=
 =?us-ascii?Q?Y29A+46CCkK7/1P93OHMKDOM2DSqtv6MiErchDeG0LXgdO/xHmtne+1CcLyR?=
 =?us-ascii?Q?LREJIUUd9TgIzFslx9szM7FsRvsuwArOrl9uxyLhmmdRs1dm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2cb71b-272e-4238-735d-08ded8fa3ad6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:17.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDaWodpwAtCrT0Xoe+BGveaJaDINtFOOV8eZXFG7WztN5gtvB93vDF34TBJIePzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541

On Thu, Jul 02, 2026 at 08:32:44PM -0700, Nicolin Chen wrote:
> On Thu, Jul 02, 2026 at 08:50:04PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 02, 2026 at 12:25:43PM -0700, Nicolin Chen wrote:
> > > On Thu, Jul 02, 2026 at 11:41:57AM -0300, Jason Gunthorpe wrote:
> > > > The VMIDs that are in-used by the adopted stream table have to be
> > > > removed from the idr as well (and similarly for ASID if we don't have
> > > > VMID HW support).
> > > > 
> > > > Then the VMIDs that may be dirtied by the prior kernel remain isolated
> > > > and are never re-used by the new kernel. When the new kernel wants to
> > > > do DMA it will replace the STE with a new, clean VMID, and there is no
> > > > problem.
> > > 
> > > I see. I assume the reserved VMID for the kdump kernel will be a
> > > clean VMID (!=0). That should guarantee different cache tags.
> > 
> > You will also have to change things to allocate the kernel global vmid
> > from the IDR, it will usually be 0 but not for kdump. Then you have to
> > find all the places where the 0 is implicitly placed and put in the
> > actual value.
> 
> Hmm, I just realized that all the EL2 commands do not take VMID.

If the EL2 commands are being used then there is no S2 support and no
VMID support.

So if you disable kdump when S2 is not supported it also disables it
when EL2 would be used, which effectively means it is not supported in
a VM.

Jason
