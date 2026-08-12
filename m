Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CEC43802F;
	Wed, 12 Aug 2026 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536766; cv=fail; b=DEQAMPVa3dj1qtHgQ5u36PNa6dTZHssn//QXsC42p9Rps7WrekA/43AWPHUvlg0N6t+1Dslpmy9HgC/G1EqUkijYb8PhPzB6UP1N2aQk8yud/h6X267Rstus3p315ySbbawzwQ2Kiu/Ivo5jlAI6koMSeS2H/Uii8jgS9H1GOjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536766; c=relaxed/simple;
	bh=5n0ULwUSYtHKl80WYXMylNsrvxTUbGIaqg++YGb4yBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dz4bpe+2AAliurJRXzGIC0IxeXT8pEsKFRXC5W+ePMumI+UTB1F56vNIVDWSCFWuibW+ChHcK5NEehmhiPVnd45MUZ188Bp/hTvi87ybJCeHkvKatVzDQZ4Y9BZgkincOO2ZJJIDgwjxcaO1GUZvFeYIiCZMFUSKMfZEnl0HAnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3zFa3+f; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3zFa3+f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4aDqgCI9w7fkOMZpeSj/KX2sqr37jZspA0j+KK35YOSJxg0kHppOCPM1G7WNu/WtoZdjy1NBjVZmpH+8ooAwAcUSTTpZI6TBBXn5HHMKedzYPJhBFo7MxGXTW1FG11tYBmEHQ/UNufOrfAmeSeyuRYiiD11q4gfihpFUKBV9ldG0BISEVKJH0A5OGZMONbJ9QgxtLi8mik38WGqOyn1XWeoAoEeqHZUqYoi5XztaGjfSWSSslh4AQ3V9PqYeIgr09kBOFIfGfzoEYXCOAc6XYOiwK61T2AMlMJc3I1sgWtYC5CX6ap9N1FLYWwtCpvXBSMKDcu0dPv4ukmQu7Zg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwVaOPU9ewiHSWutdWOkHcYrC7B/uD8vDzdspyHCgcY=;
 b=wzSE3EuQubltfC9VcsV2m3P0AHz0SEg0DhIsGT2e0F/iEkTrN2wvrYSVudzVxbkOLAD9B0MTQc4BkN8sHqIApdcUUnAerxLK8fHLGdXVJWVUMr84Iau4bJiieCt+ApP61u3DUO4K8e8syTIRZ++Csx4o2Bvn3yu9IzoczkPPhg4mj/Mj89nmGbJVSMfdWm+qMoG9xoQOfZmPPz48iSI/8TY8/dHC+1vWrfHq1cCLEdlQS55MZtzvttvrgW5NhZ+3NLBua8t2bfxjiRhPfiPoYleu3bE16EL5BKYVy7iNW5ssMrH4Zlr6euWwxKCO2HuVlvtuR3QHGcHkVNqlnIlLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwVaOPU9ewiHSWutdWOkHcYrC7B/uD8vDzdspyHCgcY=;
 b=W3zFa3+f+fDNsHAkKx8A03KHXyQ8BZayU1c20dIb8LuhPqLIlC68lFxTCPLDvSeUQIrgafyZpeVFvhlvJVgFBv3OgiW6oRDm4DB8Q2wsDiTPWDsbR450m+hB18Qz0gL0xPA5/C2VU34eaAERn+dj5WLHcCITEoyi/j5G7+WDW5nezOvEsebbQnYkSfGOOMglLAepvrNJj0CSqBf3OcrFfg8b1+g3zIBGuphdnGBHkrGqzzL/3tJddroJSlyCFC8vBFkLGrXgz6Tx0JPQOoobyZUaUNIIf2lCvZQoo3CbtE6k1hrPBYksMBOzWHJaR1gByKUR0c5ml27XfFmDtX/CBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 12:12:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:12:40 +0000
Date: Wed, 12 Aug 2026 09:12:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, steven.sistare@oracle.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/iommufd: Fix NULL pointer deref in
 iommufd_ioas_change_process when racing with iopt_map_file_pages
Message-ID: <20260812121239.GB638489@nvidia.com>
References: <7344B7A7B9957A65+20260806045059.1884737-1-peiyang_he@smail.nju.edu.cn>
 <178639198310.282103.12552740515074532170.b4-review@b4>
 <EB366C0363529CC0+1f720b7e-4256-4523-8e43-f14ace92f200@smail.nju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB366C0363529CC0+1f720b7e-4256-4523-8e43-f14ace92f200@smail.nju.edu.cn>
X-ClientProxiedBy: YT4PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 124c3a4b-47f8-4133-abdf-08def86b0146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|56012099006|11063799006|22082099003|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+BltAkNT+f6tIXpgcHBdbYwfB+844d0enFvmnBg2A/bfkl5kfurE1fwdsgGwCyxURI1I+2bNjTABmgzcvY9zMwDxzDxIufrOhBfJaEJy+db42YF0DogdzBCyXK6/idAhXZt9vw8um97n0i1JsfsZ0AgHQigQl4GonPnZXcGlGDv0gMLfMhFIawZmTXmcGZkLJL2Ri/moqJMAbzHpZ8/jBSuTv6k2OiJLFLFkN6zG3TUpycdiHibV9/yGr1sd39A0P2cBoMBigcBhu/PltNh8vM5++PVyjK1AO/cEx5YlF1i+jxiGHC9dF/z089K0I6nZg9ovyxXdZ7sxPCsVrS4iKhfFJZi+SPT0MLykqL3TYjy+UyXy0hk0tYglfTF4PxZJNl0hfSlPPkw8qBSuBWtrkmFTblCV2ok+0uYHhQXz4pQYWWY9TkChylILVLSC7Ue/fZzdWpW6jfct0EiNHWYiHF0uSanqR4gd6pGYjYxo9KyZKaaMCWvb92JCAGF9tyHogbYKTTbCABvZdbjVupiW9us0TC0M/2iyO9WA4T9JPpCGozWuvFRgvWCanCv6XJwiAvn7QG5biXRu7KOdz5vyZRJMVwLFHFWHbWsZ4DhnLWAiAVYv4eSS/hYPYJ9xtxWhDj2md2ZIk3KzmQTJK2DyXr2zL4Rc7CHYyFzYjOetJAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(22082099003)(6133799003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wvhV3aZJSeM7B2aDEPDes9V2eXiUE5BVRAVttp2LNZVvjMSC1gTQALnmn8JW?=
 =?us-ascii?Q?jn8gAv+ClJAWOQ1ul1srTFLV2Iu0DUTd7u3BWnBQcQqblTtvW7S8bNF+hT9+?=
 =?us-ascii?Q?oIx3VGZB3xybX+RGo9WwS9IDvuqWWUxnRcuB4RTEWdKZi1rtwq5G6kYK8OnH?=
 =?us-ascii?Q?3rHlSXjKPkoESa9LWGrcBYhDyhKhS9KI5S03xzAS1OcYmRNYNesNeUNCV0je?=
 =?us-ascii?Q?u9vwDpAtpsGxTCo4t5++fRHhf2v1CxFBjEDVDtnD3jqUN1OrYXyTOOfFHtX4?=
 =?us-ascii?Q?1J9+2USRKHV4VnS9+s5lcHyQ/hf3gqvZbQpEes9sD6ZEfpHRc1yKEeavszXO?=
 =?us-ascii?Q?XCEAVQ6rnJ++8b3ZDteENQ8sKB8ZmaZUQkeCe6Zten7IwQhol13TdnR7EjiJ?=
 =?us-ascii?Q?6rNO+z3lhFdKNtHiS1ecNvc+DvYmN3DDpWSlhzU1opiVtWfaxBkv1mxITYVz?=
 =?us-ascii?Q?X8sGELuaUHOWHMNPG9ccYN4VL1DDNBuQ9ccYSwpfmWIa8NSqJL7i2+etXdgs?=
 =?us-ascii?Q?uiD6fbwYl1FtFkGlEi4f0S8uVlg30O5VLuP0t5qmCNXsuf41y6IVFNI4Au5K?=
 =?us-ascii?Q?Tk6fhYTX+EuZDzmVirii/GFZq+hYR97+9sFbpiEnjZT8d07Cr4F0q3XR0imz?=
 =?us-ascii?Q?+iigX96awqel8KoITDD0e4W/ety+1Xpz59N0ADUGRB39BjhK0wr4tV+VE3ul?=
 =?us-ascii?Q?SOlGMbUt/uerxU+LKRjk/NdwX/Wm1Bk6ovqJkD6biL3ENNxOwrHVjDuzNQML?=
 =?us-ascii?Q?vdhSuwVA2KCi86cR9nXr/jRYD4kOqFNbLAQKWaUf+85pTKsEog//JZ4ss9Vq?=
 =?us-ascii?Q?4/UcrtMScxPJBQ2kiFaE4SXPS/GFHYcqnqGzjDUpCMjj/H1BNjoXeggOb0W8?=
 =?us-ascii?Q?4X3v3K4RRYcbcvzGzRbVVy9YNTMQtyJIvwV+B9lL7b8JCwWALhz/qVC/Ubmt?=
 =?us-ascii?Q?sIy2SLPVxrmLUrEjMx//Y8bc5eP48wtfmkyTBz4P/NA5AAlDXZxT+nc+mlko?=
 =?us-ascii?Q?q49rRx7vLFAgz/fUaVnP6cU2rYQQ0ikBdD/7K5w7Q2rFjbMgbL1oxP17ocVQ?=
 =?us-ascii?Q?5HpWu14K16BFmCUtfNcdVl+JYZfOgGhHiqwgZsGO9tVGsr4YsqO4Rl1nSRx6?=
 =?us-ascii?Q?TADyd0Xl+eJ5Zw9t4DleqoXQ+4uILpKAZ5frNa98w4cAExuKwW5hBJNtPnot?=
 =?us-ascii?Q?MZPczblksPX2P2MdeDtrv3QeiuQMKb0VgonxjSWAEcGffdugiKD/ejkaHdJ6?=
 =?us-ascii?Q?tLnZKrA66lhV8cmqp4ikbcr7g1fha3cdURbsEy3ku2ZY/WaJy6PzmTyiOELs?=
 =?us-ascii?Q?0sfrffpPuZ+5VeKRHk1NAEAkYHS+CTdpKYuHf1/xmXXtCo+MXdul3rvCTKZr?=
 =?us-ascii?Q?E3UaH9VP0hUA7iMGX1mx63Ul/YgqUSsFZuysQfSGABznm53b/f0Z075T4VaI?=
 =?us-ascii?Q?iIw0vU8MAeCpwVHqTnvWrRN1KtrQgt7lYP3XPP95p/d7gjerIsJZfVoxiq1g?=
 =?us-ascii?Q?+NaQA1tvz0KG9BW8ZgROQ40lYM6njL0GXPkYi9e4m/NFKkxQHaUkj/xabtJk?=
 =?us-ascii?Q?s7ZUOtUWR5Q+xYwf3/ZmLP6xSUM9KtiH4xaZhOZL5ycWBGKWCfcmcrb2PjrI?=
 =?us-ascii?Q?fRhFMJgCV2/piM4Nw+Ec0VjQBpi+tm4W7UI/uaYjTS+Qo/0KHJFNcO+wUPTG?=
 =?us-ascii?Q?Vt7VrTY0QOG7OmKtkv5Z7wWEhcBGugsHALBccYUqdezFzJfchCFpW6jgjOrg?=
 =?us-ascii?Q?cJYQmlJajA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124c3a4b-47f8-4133-abdf-08def86b0146
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 12:12:40.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxNx3GQ/66sftFaVj2Xkk3pxHJ8eFSAHhnOqpo+C8asLh+MSa58gwnef/1bPOwTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187

On Wed, Aug 12, 2026 at 12:35:04PM +0800, Peiyang He wrote:
> On 2026/8/11 03:59, Jason Gunthorpe wrote:
> >> @@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
> >>  		return rc;
> >>  
> >>  	for_each_ioas_area(&ioas_list, index, ioas, area)  {
> >> +		if (!area->pages) {
> >> +			rc = -EBUSY;
> >> +			goto out;
> >> +		}
> >>  		if (area->pages->type != IOPT_ADDRESS_FILE) {
> >>  			rc = -EINVAL;
> >>  			goto out;
> > 
> > If we do this then a concurrent map will get corrupted accounting. I think we
> 
> From my understanding, if iommufd_ioas_change_process() returns with EBUSY when
> detecting a NULL area->pages, later accounting logic in iommufd_ioas_change_process()
> won't be executed. I may be missing something, feel free to point it
> out.

The map side will be racing and it has already partially setup some of
its accounting, but I guess you are saying since the change process
aborts that is OK?

> Taking domains_rwsem in iommufd_take_all_iova_rwsem() alone may not prevent the NULL pointer deref.
> For example:
>     change_process: take domains_rwsem for write
>     map:            take iova_rwsem for write, insert an area with area->pages == NULL, and release iova_rwsem
>     map:            try to take domains_rwsem for read and block
>     change_process: take iova_rwsem for write and iterate the area


Yes, I guess it does unlock as it runs too bad

So this patch is probably the best option

Jason
