Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795524580;
	b=URLA1zxCLETHzZ4U4TNdzK122PofhddpYSzqoKaB4n9IS+9b61JSfJoLFHQRhQRr3T56
	 GC2WeeyPvXM/NsUDb5wVbc/43bL08oPqsIO+UBvNxXWoDeGYK+h+eSJLplKVqzmv6/xFC
	 zITwg7OkDUEIKakeUJBc5fyBEUmTx8a4psAZenQeKldtX9OVK9/w9hg7Z1APtOtYDz+jf
	 vGIb5W8NxQmpbEx+EZjPMC+Z8CLtrQGO+Xq5nsaCku9iB0jhS1CzjgWFoZ+fAMrm+x0jL
	 PfctCvpV4HWi1Yss+HMNPibOPjB+K5BKxYUz8jY+j2I4uG0qZnaItA9OIPeaUeYMx4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524580;
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
	bh=jxJdmpwM8fFgrlawPDdUPktgIXAgQYM4wj2Al7xcyeI=;
	b=Esg/XWw3jebtFDdkY0/mRLEWCx0mdl4R1vUj7Hj0BKv5PqkfDGEzpxSrFYxF8bgDy40W
	 UTQYj0HaDAkdnD5LgtYsJnslZlIEgK3TpIfp7axe/o+wvpeDjsa0j7E+W74VOiarfWHbd
	 EksRz8RGAf74BstQcYpyEfIK/Paravvab6URN75TIEimNZqybt2t2DZO2YPQPR4FYZSf/
	 J3akdOLjXeNnoRPZAVcibU8tnwS/z9fDvtCcutfnpCFBuPOIjm/kkuG5skRt8SV7TD3Cs
	 RT6qTP8esEj54h8VLH+K6SCVqlfwQ71Clki9LHIYJ11II7MZFRUcgGnMI8+SI6EemGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OxPy3eYQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.6
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7D606A321;
	Tue, 24 Nov 2026 12:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C7D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OxPy3eYQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdbcIrogRGxoG9og4rXbCQehLx2O/fPsl4IVSB07KZI7QSvOS29QhYKGDKggVVBCyiOmXvlzPNjVJjHrHGK1ze9Si5DdmvCZ6gAXv223897XqoJ99tlACaFKZO4l9H55GQX/GVzvINq+4d0bI8EcYVAsNTIRUAizUg0wgBhqlw+MK5mjPtuOqLcunyo5A4fX1nJubRsa2Wqf33OLZuWVMVVW11WC/db8AfPlXSU6uWM6GRhfmItUU1YZFu4t7WfQZEy9hW+BT+bWOwPRzgYV+b0B1LUXEpdZQJRUOJPWNhrgfk7CmVKdKX+yse716ybAhaBnC/6rvHIoiQDyERFDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxJdmpwM8fFgrlawPDdUPktgIXAgQYM4wj2Al7xcyeI=;
 b=aLVnkzGG+HmzBtFgnxtMHruievdyC8n/aKhe/QjXY7Op7qhd9Z6vCgh+UJg4MeDG+4j567nM0hvcqWW3SLJEx8A4OH+EFO846Jh/bjoGnj1O08WpYn2bXqXzI6W5GBRp6/DIR2klssdcf3M9YDCnTQ0lQh8ZNQBCQUhOa8ax/RlvFLBGc5alMt8X0MtAEEFRjEyMGCDbwUjgUUe2XQP38+C/ar+Jd8iOAglMSUo+qM6dPkIVbGUkTVNAIl8SWiS1/NWlaHLRFMN9NPKwMacaSQJ2z2J0XhslaQ9CJQ5Q+gMxcdAQuQuopS2N/MtFtyuTr0J4fJjCYho1avpXn/nuVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxJdmpwM8fFgrlawPDdUPktgIXAgQYM4wj2Al7xcyeI=;
 b=OxPy3eYQSHboTlaFwv7zLZZviADaVV5pBHmx8txKFFNJoAnPQqLjkG298170Ozb2csKeCTUmjoZpExQCOYcffhObf6zD/ZtHKhbh+KPSWQ1iSWX8Okz/F64gNJgN0UMWqKvXdThomqaU59voCHtCwjiGG9FnE/tbOtvf02fFOUFgq/niXeBwfwGNWxp+jn4IeLl+k0wHXqRRZmTjYYi1gO3kZATjI2Q4Fup/OkQH5hXtYAFPY277jlFTx/8Gwv9zW9tFZA3jNibn93rvUzmmDEgLBCrwvtDCTOIdsgqOeZ4WOVPnH2KlAWIqkwRZpE4kROklQ4+BgDXYnkPPhHtZwA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB7764.namprd12.prod.outlook.com
 (2603:10b6:610:14e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 12:49:34 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 12:49:34 +0000
Date: Tue, 24 Nov 2026 08:49:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Chen <peter.chen@oss.qualcomm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Jack Pham <jack.pham@oss.qualcomm.com>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: Re: [PATCH v2] iommu: Hold group references across bus_iommu_probe()
Message-ID: <20261124124933.GA8680@nvidia.com>
References: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
 <179520803625.1164516.5819106673711321760.b4-review@b4>
 <awU4DyS7irT1a-nu@hu-petche-lv.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awU4DyS7irT1a-nu@hu-petche-lv.qualcomm.com>
X-ClientProxiedBy: YT4PR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::29) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 660a4832-a222-47b4-a4ca-08df4a29643d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|261009223027099003|18002099003|22082099003|261026140227099003|261021123027099003|261022105027099003|261028144727099003|261022075727099003|56012099006|261026121527099003|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	4wxCmkvLYwsc5L0O62RqF3F9LPCv/0iBP5LsyTOKbrvuUB5ldqlXDco09JfEr2nbpE04z1QkdIRuE91zmA8J/IpNovhZ7I9Nlf9KzMtm3RjUre6LmHavgcNmO7YLpmfbyW8Zddo+EWCfotNUR3U1UU4A6ljuKoJG6ivPmnK4TNmtn7v093JVjEQQiKVuUnX8tgqpVnplS3RvzAgJqSZSpW88iRo8H6tVcfYeIgv3SxrgxZG06sbuhpmFmpw1xQfjbdWCZFTq4K0jOAycfxSxEhH7DemrJVCDEwGZBEiAS9Vcsr328GqUT1tgNN2ZwqAQsv+M0eaIC6K4jHSQNarcsheNbEftf4jirBTufU2hElYgS+NE5qh5/b/nsDHY1sXgvMFqiQ7hUbhND17tZYXC3gd+1uN4bJ0VYPkn4mCqAcHKk4ZWYD0Z7c4Fv9/rgENFzDbBQ041hkGDF3Ofz4zlH9svCNOOw4TQTYS+atoRBhRf4d5MN09v0RPXO8+bzOcHfoFhZq0V/04MIgaZLS4MDNNAZr8RBAxJJ5LKctl3KV5sinnbc9MCqTVy/OoYxWjpkhiCXVc3QlV2aUGak1VcNz8B04P1KLaxquXuWZ0MGxerXbOphuU6RqWtnecovSedNwc7DhUxeXFsei6roDIA3jKNHGdZJLAyAMSBarIGm9w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261021123027099003)(261022105027099003)(261028144727099003)(261022075727099003)(56012099006)(261026121527099003)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9N+KFqGkrUotajwMlEebkxPOIYWDPlXiAC16GQZzcsDp4RASdm2K0UT2VEp?=
 =?us-ascii?Q?TlYB1y+Zibaq2IV3NpMJURYnXqV9QdRb0mI35/KpCc9u/6bAOcaEmX4ZZuJB?=
 =?us-ascii?Q?zKQiyqDT84eC+MQBe2VIHbsbCPaFY4salv/YCXdZzwtq5r/L9rTff7cYH1BG?=
 =?us-ascii?Q?xm9mNowAH1qiLDaRG/vdeIngg2DtMONIsIjtsoQmyefl1K8HoMjZXqjIZ/UN?=
 =?us-ascii?Q?Y3iQ3/3LNUwaVQTDfdEgJ6DqI0A1GU5fC6eLkjQSkp6XjCu0dhc0FVRaJdGf?=
 =?us-ascii?Q?NCvsIvQVNQkXLcRZWUIyG1lk7AnvDT5orOHPKljDvRmMR4iviqYFUN61sLBs?=
 =?us-ascii?Q?yPicQBl0bw7xvyn7YZ0NQPqivl7EaT7ZS/f7IAwiVnRfX3cacyPp8w+vtmzK?=
 =?us-ascii?Q?xC/6542ChPUG5ANoQI8usPHFNfWCK6j7jJhmPvCc9NFgL8n0p6Mvw0F+y8ma?=
 =?us-ascii?Q?Fer8zvKbBpu4F/gJTLHH5lmYTS6ouXIgEZ1McDwM7Pgqz1jECAO23h4hYI2B?=
 =?us-ascii?Q?c+Oz57m8B2R43bSsSvUPqCQvO8b0yBmk5os0wyk1L0Phig+460nFuFiS2cBU?=
 =?us-ascii?Q?bPki1VwIExZNu5/qymhOnEzuufrMuj7L1+bg3S66ViYu/FVaaq/ChxhDxMfL?=
 =?us-ascii?Q?gL/bORO909a2JB2INaSOMCG/hdjvx88YUTvaplfHaGK3V+0sHGgVC8QzaimL?=
 =?us-ascii?Q?UleierUrAanERYjrRqBD3uX/ZeblHHlIyH0hJ2+rG43v7tTy5czNvFwOpBNl?=
 =?us-ascii?Q?7qKhteM8kUKsvdca0r/ImOJt4oQlgq5m9StA6FO2JCISMu9bLsDlMthoG61I?=
 =?us-ascii?Q?cp7KXFuS1/v4rPnGdW93Zh2MKuMKKCddrB25f07L3KXfbmUzl2nA5D9pFODC?=
 =?us-ascii?Q?alnfIeAOKEp15LQ/5AOGEWs4H/rFdXjyKlisH0h4b2fQNHcKEJTUJlSieLtd?=
 =?us-ascii?Q?DZ/3uxnEqtGAw17qkGf3YMwA7O2HvJ4Why/zVkj01OSbnmCMby2DaF3smU7t?=
 =?us-ascii?Q?KcQzHjfFlsF1Pxdsngu49IKXTvL3yk1FgpOLbqlI8nYu3I6jDPx86B7e4TVM?=
 =?us-ascii?Q?n0MKqzzCzF6APbQKov7DlzxPB05q1z634eIftI6E+9eurcxjFXTsk/fdbALN?=
 =?us-ascii?Q?ki16I5nml00scg3r5f8/rqjgJ/ZYMegp4KePXwr8ZFiNWieUNS+AFRet1bWA?=
 =?us-ascii?Q?XLttio2iBHm06thm2Gic+RNoJiDDJs7urtxL6fOSR/T87nV+NJnUZcPhwWD6?=
 =?us-ascii?Q?DVi2D6LMgtykk1lSlIFMz/d1wzeJOg/3rJ3SrX5r7xw/rv8Lg3uVC+ywZI3s?=
 =?us-ascii?Q?UTYk/sOGcGKaNZkFDFot1lyLVvDulzsAmMRnoquE2G0DSP5ZB+eK3TmbcEb+?=
 =?us-ascii?Q?JaGqoQyGGHlWhPH3M03JLXh0hsfWPFSdYtjid/6xpy++SSNmPHPg/gUlgwJJ?=
 =?us-ascii?Q?i0bLgQSp2X7FNb4YYkCdJB5InegooHMZqG715h8YRQPDIGPegiMiMEmqFSTK?=
 =?us-ascii?Q?2xe6kBumvrvT+E2QvAzMrBEt0CadHNl9pPIMO5mYBmAcrJBCCxZ57J7lxWql?=
 =?us-ascii?Q?6vyNZWEjrrQjodQNIQKEvMrXo/9v9ItbBBsGssBjsyLdPGPJtLFd1z57Cisj?=
 =?us-ascii?Q?mxP6WbXq2qeLpmSgZgl9MEBIlVwOQFD5QEqW2BusMaZsoVTc7SPBSIkDlj+h?=
 =?us-ascii?Q?Um4UexlC8DxwJ9tRWdy8ASz9gdn/VkC+aomdkQzNTO8CX3a7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660a4832-a222-47b4-a4ca-08df4a29643d
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:49:34.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di5XVpsk3RiKE6oaDC6IuElgIeKnjbFg2cFvL01re3OXgG6ga9896uLvgVyWfsEZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On Mon, Nov 23, 2026 at 11:09:03PM -0800, Peter Chen wrote:
> The glue driver does what upstream dwc3-imx8mp.c does in
> dwc3_imx8mp_probe():
> 
> 	of_platform_populate(node, NULL, NULL, dev);
> 	pdev = of_find_device_by_node(dwc3_np);
> 	dwc = platform_get_drvdata(pdev);
> 	if (!dwc) {
> 		/* core probe deferred, e.g. its SMMU is not there yet */
> 		ret = -EPROBE_DEFER;
> 		goto depopulate;	/* -> platform_device_unregister() */
> 	}

That's not how EPROBE_DEFER is supposed to be handled :(

The driver core is already setup to reprobe the child driver later
inside of_platform_populate()

Your issue is it is quite wrong to try to synchronously reach into a
probed driver's like this from outside. Then when it fails tearing
down the device means you defeat the natural EPROBE_DEFER.

This should be asynchronous, then you won't have ordering problems.

But OK, it is clear how you get into this situation.

> > > @@ -1951,6 +1955,18 @@ static void iommu_group_do_probe_finalize(struct device *dev)
> > >  		ops->probe_finalize(dev);
> > >  }
> > >  
> > > +static void iommu_group_list_put(struct list_head *group_list)
> > > +{
> > > +	struct iommu_group *group, *next;
> > > +
> > > +	list_for_each_entry_safe(group, next, group_list, entry) {
> > > +		mutex_lock(&group->mutex);
> > > +		list_del_init(&group->entry);
> > > +		mutex_unlock(&group->mutex);
> > > +		iommu_group_put(group);
> > 
> > What is the mutex for? The group_list is a stack head so what are we
> > protecting list del against?
> > 
> 
> Yes, the list head is on the stack, but group->entry is in the
> shared group. "Is group->entry empty" is the de-dup flag that
> __iommu_probe_device() tests and sets under group->mutex:
> 
> 	if (list_empty(&group->entry))
> 		list_add_tail(&group->entry, group_list);

A small comment might help. The lock seems necessary

Jason
