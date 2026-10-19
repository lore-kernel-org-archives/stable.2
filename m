Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D63FB7DE;
	Mon, 19 Oct 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415151; cv=fail; b=tu5ZqG+83zGAbJ4B0cFcGq6JwL90xmmr8ltttpQezdXbuverjoqNrnQ49/L4pXPBR1whAfhtfq32bl7w1edkHVJz5QQ7x2q21bhOxXFjpRqaPAid1QQYXh3NKSdFRz10JXFEXlPYLnGPfM36pKZVnwcNZl2gihRN6iIvPPI+WFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415151; c=relaxed/simple;
	bh=WrSzJMktk1a9r9X0r/SN/rrqjWVkahLeSXibidoVxjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+CSQCrCTzfrn/vz+IGlnjkWGzQVTy9AQa0R3r6gv5x4yX454wJE2HJ7JlzEYRT3+43cu4W8d2DXPobRqOqjMDZ+AzQeuWPK9i3bF3e3ORAYLLBYqsbW9VQDayGt2I3KfmimTo9WJWfZauTH8jY9HYHbHhQ5otepS+vGPCSz11k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJpUmi9e; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJpUmi9e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwg/v4G8LGDp+Nqx91OwVl8MJ204BfvAwMrkcPBXhJMSbvviU9x7Q+8BMW5WuhNLeXWusOYuFAVQ/PFp5eG75gCNU6q2oE7kvDXqSzkscxjWQ9TW+uTK3BqQ5YSC3myBw9I5381ocA/9gxJVHFinSfRcqIHLm2gUMeyfL5nV7GDLvzEUnYtgK5ctUDDeMWyjPDacQ5/4DMaHYAPCRHcmrC6m6ELALYPj8z+MS4HZKzKKCWnPXWiRpWiPapj5zMoFUeFrypaGwHwy9Dzb7pTdTz6cY99UdA/BHWIN6UGMX7URKl4/BN9tMNUFL+0ru/xdv3CGtWrb+siqu1KY52G9vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV9mNTSUg7EC72LOwcSOQqQ6ZUexSemRPO01pc7mC6s=;
 b=Dn4NzwicSpq2mQ+3Sv9qc+Taxgkmp+K08uS59065d4ZzcM0r5rf+ENksX6zR/7l4kTNu75FouH+j32wPOt/dUF8cuUvMF1efXDqutjounpZBfy1O4/T2JUCrUm22Nj+wiW0KVi6U8zugNmM/w8MHgEc9hpOeLmelSpocUUQff+PN4VXFq06qzDKPPLvCVOF1khyS24PaVzlgy1zcM5CA7vEim0TnX8Wsv/6To7OVuTNorMi3G8QWDSbsP7Cl1HLt2OAnVMb2qo1H8p5+7DsYhHxao53o92iP2SRbCf7z46wEEBMZjBiRcFt+H7NTu+zeF+lPk+eWA48fBzPDu0E2ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV9mNTSUg7EC72LOwcSOQqQ6ZUexSemRPO01pc7mC6s=;
 b=GJpUmi9eyDnZetujbrpgpjn5vPWsS/8Qiy57Oa7rWE4xzwEf3hgsd9rlWGmrweA1F6ZCLOsbCR21OrX9fByYcy+lvN9vNDA3PeZo3tQAUa6TuT4cs/utcAx4imOy4CiwtSbhHQKN3jRzHZWH6Cxw2Qr+bjvJ7r/krA8Afo38WfI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 13:05:44 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:05:44 +0000
Date: Mon, 19 Oct 2026 09:05:35 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Guixiong Wei <weiguixiong@bytedance.com>,
	Tony Luck <tony.luck@intel.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/mce_amd: Add missing long names for SMCA bank types
Message-ID: <20261019130535.GA1517@yaz-khff2.amd.com>
References: <20261009020447.90758-2-weiguixiong@bytedance.com>
 <20261012140330.GC15198@yaz-khff2.amd.com>
 <20261017195145.GAatPR0dQVZGEMHglh@fat_crate.local>
 <20261018223431.GA3236@yaz-khff2.amd.com>
 <451788d5e97cba38274e663d2b7952c593e959be.461d4034.890c.4720.915c.a7839a9cc59e@bytedance.com>
 <20261019041909.GDatWaPatyL2pHDLKo@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019041909.GDatWaPatyL2pHDLKo@fat_crate.local>
X-ClientProxiedBy: MN2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:208:23c::33) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cd5b01-f382-4c0e-9fa8-08df2de1af5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L8wlniowukMJw6327P8Pyfa2RmGvrf5RyPhVRMgIoggaVcP0sHW3GATOIJ15C3OAy79d7aelZpQ2OuWse1P3THVQB2g+mBoNtHgpNZn1T/XNxBZglU4KW4AfrjldtQP6hp5umVuIWqtWokIoqq1TI2SEJBe1BXpVT+1+bNL+7L4NaX1BaLd2NY2yHApHNDc7WUxJbm25BJ5js/7lQZX5phv8WgOhJvst4JMikaRK43Wp/N2oL7Dhog7CfGmD9nBRQsUF1DmhvwjLYSne81IRyc8XXW2mXCIc4kTuL3qLQNnsVnZu+3ia5qrOVycI5dev8AOtQaaeS6Ao4vfJ9ImdLQBx6Amp1uzaS052dtV4tOYvrF8caNKTQ7CsPqcAxmYeobngvHRoSJ7WA/puausCJdXFh9H7IgKjxwimf952QIFrDDDehYS9/YtSoBsmKvpyWUYsMB0f8aoX4z58nK94ZGkmwpiq5fRkCgMwC39PLXF79BUZxne+MHeGkai8Tr0ZhBSYNaUAp3FzXA6RgHVJHmseLyA4d9h/u5X2CHE4/EkWiAVw6pMk1qtuaAAox5G8NFUYWs0aIUrMAW4VLkdsuWPfRfFS6J2R/+VOS1s5ZK3C9vPqUC/DxPcuYD6N68LTj2uasTjIpTRXtW7YlylwxX2dRWjPim9DaiYs03Pwfhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbRKYbA1rdPdwM45PhG/i/qYdvKi+55tl3clisY2lC8+Z1lY6fvbICJ7lRam?=
 =?us-ascii?Q?4M934mL/jitB+M1VICyQfOzjKto0Kdma9KHYojsL7l8ZvGLsOfh96WuVN2Ml?=
 =?us-ascii?Q?/Hrm3RKNcjlNuMOBf9/PlIV9xj9iKTNGBGIjqRW0W8RgXJ6HV4i/F8PGlfjl?=
 =?us-ascii?Q?eb/iAGvNbA4jIx8gDuZAXMPNmnLY6PB+rgBVlV6r0k9laWdZGgEBgxqGOZPJ?=
 =?us-ascii?Q?Xu5cYiBKbdtm35Ez3xbT9s8d7u/wWOzELUn8aN8YhNcbmmJ3taG5T7ataP6V?=
 =?us-ascii?Q?OPsxNt08mdlJRdb9M1cdvaHtu9YIjERDUY+cDv7GdaRLkjlJyxtO/YKWfUfJ?=
 =?us-ascii?Q?KgFlYvx+3U1RrjYMI+sVIZT5xhvnFK+z8vdqc9ie8Pam84pWund64puK61M0?=
 =?us-ascii?Q?zJ5cv+OIbs48TEz/9/5ZEShOGGXVWpKvy9Cbq+9kOEsqu7eyh6PTBi294EOb?=
 =?us-ascii?Q?81ejY4Pa8A44SrG2g6zdxNA8IgfPImpu3PaEpvVchiG4PWatCf8yVWPREZs5?=
 =?us-ascii?Q?2UmiTL+2nBYHuzgkx88DLA0S92DmOMLmsPYTolg4iwbM9Rd2dZWW8azuVRp8?=
 =?us-ascii?Q?V9bCoZ/z78Smc0VQ1PXl0vGnZeL1ez2ETWs6xxu7SRaLD50D7IfXcgopcxr1?=
 =?us-ascii?Q?yHVyJHQqMfCPalyKEf7dfsczHsspHzhGMFYqj7BPD3m2hOh4MAvYNyDkZTH7?=
 =?us-ascii?Q?EC3V93boSAMwq0RZFFyWII/CNSnfyP1NKskxpuaPpJRuvUFswjoovCGn9zCu?=
 =?us-ascii?Q?1LFqFwyngveoUpWjKMs1dkI4GkBLo2UhJEoTwahrlNF/GD5qv4Y3lpGmLVj8?=
 =?us-ascii?Q?IU8ZrXxwrc6Z2fA52qh1AsCgCWG2Hon83I4xekak0AHknzZrVkudOFisSOIj?=
 =?us-ascii?Q?onyFcIY7afRby5S7SUMQZyPfJwsUoY+Ub5vXq1hytFqhJ4Wp9JU3xJowo1yQ?=
 =?us-ascii?Q?EPVQhdvBd/R2SNyTbKguprdqGnOjbGW60CCKQ4PBQr3MH4gQ/vQ99IzVCI7m?=
 =?us-ascii?Q?ODmn/r5bwpRTEu0+PucjtY45tZr2gU2mCB8TQ3uWSn1M8iuwXxPxjD3NJdhv?=
 =?us-ascii?Q?gWsnW64fx/ut0lsm329miJw+173sAJnCMsZ2l4BjCZp9px7Odcqfb7y2//CT?=
 =?us-ascii?Q?PogbqlSKw/xNQ7AnTSMPzAsdFVks89EnKRlDhgCusupliH49OKAFyWxRRnfL?=
 =?us-ascii?Q?k8eFHbrFBi9/aVZC0dycHuB2cgA0cQ0n2xTNKK/nCjwcuyRJOKS5XGv4zkWr?=
 =?us-ascii?Q?MyIF+QfKPcNlP76pkTKauC4jAZ9YFUw0na+z4P9pRou6P9OBJVhpSIfliD8T?=
 =?us-ascii?Q?dIo4uVfdmoycy47EaE9mhZk8coh6mOrufyXkkRq38g2VnqjBkuxEl8z6B/H/?=
 =?us-ascii?Q?bqo9NpsEPaMZXBYX6xIxj2H9OfuS0SxiZD5sdzxHj8UAsqPZprjjmh8b3/0J?=
 =?us-ascii?Q?CyKW7udDy9vfXE3D+j9A5ELw6YmU4mw0sX616tUNjApdN8hQfPrpflZhGE5v?=
 =?us-ascii?Q?85lTYtP2q5IAtyb4Z+L9TzOd+YSDxCwcgh4Ba5StKhU09mH8f0G4jZ4qJ8ja?=
 =?us-ascii?Q?a5EiwLNuq7rblEbyaCrU5KhhDB/GuLrHzjcx/FobQC9Wj/qw0btvEeM07S4r?=
 =?us-ascii?Q?5K8jGB5jtr1mdcke8gfgFNBFXejFeKdsncDx9eFGeTNppigIi9IYC7paL5mc?=
 =?us-ascii?Q?xu2i0/ymugTbIu7mNLJAkfE8Z4RGxmCVph6kIa9UgYmeFlpu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cd5b01-f382-4c0e-9fa8-08df2de1af5d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 13:05:44.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBJf15pcut+M8NAetL2Utoh8rgmUz9CYlWw4GpAJnKkkqxI1LzdUTEbZXEyvZSmihQ6KJpo3C75lgKQISWmUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101

On Sun, Oct 18, 2026 at 09:19:09PM -0700, Borislav Petkov wrote:
> On Mon, Oct 19, 2026 at 10:16:32AM +0800, Guixiong Wei wrote:
> > Regarding Boris's earlier comment, I agree that the Cc: stable tag
> > was not justified here and will drop it.
> 
> You don't have to resend - I'll fix it up.
> 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
