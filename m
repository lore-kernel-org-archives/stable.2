Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0423CF205;
	Tue,  9 Jun 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988893; cv=fail; b=eX3g2C8S1JZCvuBP7ejrgPbG2oGTVLiLpirFHvgofnKaqNKtg72xP6QuH2F5hysfyPKy2o/72NnhtQX+bADiJbFpdI8VRBEkROgy6LBEirwyH0Q+cm6XrtqzntbNRsecVaAKKOgHZmaxUrTnVyAD6W4OzLnRgjQrwlxLg5vGKZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988893; c=relaxed/simple;
	bh=GqtThMscBIu1FkhM1iVu76vxnOvPq89RsmSjEF6eYEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pjoU3E3SimGDpWGDsnn12QuX1vKmjE/rJWru1++jvOctQR6HHrp9YuxOgDOagY50L8DEq5/hOc+1YACCxKcCuW5SClNxIN8DW2E28GmAtenU8e7dBerzUu4MSgtNEDO5eakXwexTGNePQ6su5ddbNeO6CZH1Qkf2zvIx4sy6hC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIaXSIb4; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIaXSIb4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhd08zzROgelZ/WRUBlQLlZ5tq82pnuxqXkHLRTZa05yHzjXW/1p+V4MO26k8m1yj3+/Ex0aJucXd8pzoBtjc1259LkWl5pgyVMnRSKxQ3K/PwP5eOFaLlw1T5U1hontxJsdBgabG3tItxMaIEW7dmTwORS7s2CfxHsGlag3vR/InKwZa/wiVSe/BbfQx7x67r1Tj9Q9c9GkDwdQyi/2tvjoh0tXvYw/LbGQI1pq/TIpJ49OFW2kPVdj0TRS7slwbT8DcKM+Xyc60JeH/6bAM6vM8MQVui5E5UBy0op/RdA41QxSXsFp37Y1CISXPHfZwfKIxYP2Q5FxxS5U2giJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZSjVX3ApNNp3H/U7sKRVNaas8yAmnovyU4SUxhtiGg=;
 b=SDiH5HNW0bClKGLIqr92KP+n5YrN/DBH8370MqXhYxTZSIttXWmpLkahj1k3nbVTdE5cnG25+Rcnck3QggnIMnNWk8pf/nbZESn8Z3VkdHr8puV3Hps8WWrGM60H44ctFk4rNmr9mps9clyGUzUze210Q/G3YUpj1TCQweEu/rZQmByv1deqZEzl7FlqcecPhBZiYrGsNEzwadShv2mrtmbvWT7Y/BO5DkVgCCsU6KybLo/uDkLFjPGGJIMtX4QHHxhMbjERtrMouj/iYgtcOSilF2anopfzdjPzYL6hZjZ6R9B3Ezjztge0BkdaLdGTTl5RaEkwrTGN/xx1mPtwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZSjVX3ApNNp3H/U7sKRVNaas8yAmnovyU4SUxhtiGg=;
 b=nIaXSIb4uNP+tRzJaXRBtq22om2dbmIYic3ssADnZf9MmEpid3E9RrU8abN+c/DgvoJwLg7bu+NDegv1qP4M+hx2Blpqt01fkx4WC17QDI4lqUEprTUkuslMLkDNLT3kzJ5gWPT6j3q8cxDFjKlKf+Us/8jRAUyIRc2WBeIq//Ci6NXwikdk35D+/WRA6TScLiUIeMuNItshYiC5ova9/yE7WSIOeoQs5LpPQuc3QtYjxaNtuQqum1u7a0DWU8ghBzUO3yeVnP70TFAtWYQNb8lxPnEKJgwxdLE3nHwgWfmvvkg361LpE7eB7vE+fjPAivQSfq1b16wQGbQkitF+Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Tue, 9 Jun 2026
 07:08:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:08:07 +0000
Date: Tue, 9 Jun 2026 15:07:59 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djb@kernel.org>, 
	PradeepVineshReddy.Kodamati@amd.com, Benjamin.Cheatham@amd.com, rrichter@amd.com, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
	Li Ming <ming.li@zohomail.com>, Tony Luck <tony.luck@intel.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
Message-ID: <aie4BQ-Kd_YPwGUg@MWDK4CY14F>
References: <20260605180610.2249458-1-terry.bowman@amd.com>
 <b91e5e09-34d5-49e6-85dd-28d4a5eb3014@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91e5e09-34d5-49e6-85dd-28d4a5eb3014@intel.com>
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d9839b-0280-4d75-2053-08dec5f5db5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|56012099006|4143699003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8Ts7UwqKUouyDNIJ3KKhBnt/dZ36hq4oD6GRKHb+i5lcaeFHalEor/z8+fX4VcZlEmNCZzig3duvUI6qIXAttcIIf2wx9W1+Qt4Uxys6/cY45oktbsKSANA6tGlzT51WHEnl5+THrOHJe49zdKfDMLVg8GVqnHc2m3SG2bEAmiyQ8KHA5edMMxfAvs7Bm5tSQmWO8MmOxgm9Q+5HyIeLeTcCyEftjuPcgquGoqWOFZcivKTJjHNdh+8Lvr8+jT0cnLRkkxuGHz83pOEDKBAjjAFLTfUgEqha1wYSyITKBXGdXxl3f4mxEWhwCbzwrBBthw2kIlGic2r35aU0srrqfS7XFqEttDN9ZyB3aGrywPxiW8ZqT/G5XttdDV0+pP48KsB5psiccPIalw1Sc8Aq8UubGivD37BWCkLNwbPnZYIDbn1T2IWg+F0IYriudLWmxYIDkT4BhEobX/KyBRLkZ/1vkJk5kKz9ioV0tHcwVOtpkSmjbtODbGNoRsDUCbNmLtiCLV+/AUh3HuMLhSs9UEvJVyuREboye4TaMhooBGR76t3obzJrjCQ2E3QAHG1cMDEaOv1dqz5wu7BS3YzjTMuCsqM/Lrg/sYhWrE9B+bD++VFiwd3lTn1FcWSeV9z4fqO+L0MnyodY6o34kZ3kPlaX5PB/TAP5OnaebNXiH4a7sQzlZRLKt9ST5Ch4HEIT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(56012099006)(4143699003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mHnHgqdZZy4l6TXIEOewIwuF+U9q3P2JwYpwa/rhUzaN9iTgvQ/BSx+8xvYD?=
 =?us-ascii?Q?HeBhBIzq/mg9yBjVYqdDdeIpPkfoYf45knMPcbq1209JLdDXOBb83zOy+ifj?=
 =?us-ascii?Q?My4dL/R7ALapjqxUlQmEQrwmu2KrQeasfXXv99fsmRFx3LHL0sTGJwRDYURf?=
 =?us-ascii?Q?AqpvhhEIujJlCejB3AXsS687L/1/sDJkFmNi86Wf0ylI1/A1mUkUxbbvH++V?=
 =?us-ascii?Q?ZaDE4UMotMhawyju/o0C+l4pbzYTwSNPKP66x08qU0fOlw6tdwB5mhhZuCUG?=
 =?us-ascii?Q?nmxjisWnEgoiuJ5skN1CTioKeoe/BW8Aa6guduWMgeI5CuX/aJ2Yw57N2k2I?=
 =?us-ascii?Q?0N87zjF6cQee83omEcy3+RtDVTfVNTL+MJgbGeIW0EApQz2OtCXSOveyEpZ6?=
 =?us-ascii?Q?cmrWHvHvl5ZoHH2XsGaOaq+xh+ytlatCqSIYnMeuhOfmX7maniiBDjG5n9+W?=
 =?us-ascii?Q?mFOzEDZVLQUP6pBZZShVAhaWE6++VC9UUxKFK3fitZkpDlVjcRsbCUkmHYtT?=
 =?us-ascii?Q?Ui0bxvQYpfDUMoCGagenfq5nhUcsIIOOzI+FoOpTyDy+HWAP/wKDMnoOep9U?=
 =?us-ascii?Q?f/to1K0VyhLciiZGI2mvRPVuB8/TLBVBeDk3Ya5E7FY2mY59hNspgQKNIC7g?=
 =?us-ascii?Q?yiuNuGIdduYEmGcAPOyraTDgcUa6MVcChYlTLhTo9Ojc2k5gZfqIwzsqKxa2?=
 =?us-ascii?Q?x6TzDjnL0mYyOOhOvAEHbtTByQ/cKoryoMciHxqIouboyGrf2dYB8iNi1EuC?=
 =?us-ascii?Q?tPxTsT0lP41cqfkBdwp2xENbalDI9E3bpv3Tq5UGGkFEedFMDCPutua9X2EJ?=
 =?us-ascii?Q?pW1GYabnq/3cuWNPiNYREeAWastkWZMrIH0zHPdx2AVlLnm31tCa8PVJ8Dov?=
 =?us-ascii?Q?QPo3Vky0HhronJc9o2c5tHr4t4MjXnOdRU7QTti72J3Z9LB5CHHYcOEM2I3t?=
 =?us-ascii?Q?CNNeWj5RGvGilwnOIkgfc1BPmMMA3p+oxEHxOUlJyL6viN+vLb40qeX064TK?=
 =?us-ascii?Q?R+aVBxGlSXsK7UcQUBnPNAMkyy3P33RpfnU0hW0LhTlunf7rChOEEurCKzi2?=
 =?us-ascii?Q?9WJ0QOffh5+mWoQzLccIqOrPqJZSSB2YOmwPvveIgY7lw62A1IA8KcY6t87A?=
 =?us-ascii?Q?yFqwf+phE/+kEFgHbixlK6N7GUKSonQdww8cOeNAnTWyI3Xx7Mw1IZuKw4lY?=
 =?us-ascii?Q?cS3dxarfkxYuf4uwejdLFM2eAtMBguIbj/sMeQmNe8CPJSgXnULSaxjHGkRE?=
 =?us-ascii?Q?oYEvp3w8/8j44NokiJBCpctvTwaIZMYXJJFTbVR+qFOyFcm+xfGphcfY502a?=
 =?us-ascii?Q?uqPMJOJRT9HiIpSFqquuH45weGjdYoL4dK1CjCWdNfnw9ijEdr1D9iItichd?=
 =?us-ascii?Q?BNyClLI1kFTz4Zm8vwXrTEviBMhru+m3KuaeqCuY4YSTQRyojwNA99FodPFJ?=
 =?us-ascii?Q?+2tiPVfcL0gA1XESHPN32Z0yRpBKyaSrwJ3U+moK8j9CatR0qMwwEvO1mZEU?=
 =?us-ascii?Q?fC8dJ/tZdve3DAfiDoDlW0voJ8SX1KA3fwA++O2j2Fq7YTVFUwI+rH7NLvh5?=
 =?us-ascii?Q?IrrtiAfqDiLl9v5WSX1OURFGf8lPgfUPxp7RAFEjuTDng/cTFdV2w1UEu3UF?=
 =?us-ascii?Q?x2Eh5LiVDa2Irvsm738yR2VpwzTCxfhSFalqIsu+iq89zEEC1XuqdvsKMwOY?=
 =?us-ascii?Q?nESgK4o2tizEBnYScm4cJFQgt6oNv1CZVeWVv5ND2QW2IHZuI5cQdcywOjPG?=
 =?us-ascii?Q?2q1LNvlm/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d9839b-0280-4d75-2053-08dec5f5db5b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:08:07.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFlAL3hU+BR3TgWlFpvsFQilR+EmVifEtxCahJNuxsZAGhy0ODXebectRh0Qb5Kt12O/McWanf/8/x1DYOq4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

On Fri, Jun 05, 2026 at 02:28:01PM +0800, Dave Jiang wrote:
> 
> 
> On 6/5/26 11:06 AM, Terry Bowman wrote:
> > The CXL r4.0 8.2.4.17.7 RAS Capability Structure has total length 0x58
> > bytes (CXL_RAS_CAPABILITY_LENGTH); the Header Log occupies the trailing
> > 64 bytes at offset 0x18.  CXL_HEADERLOG_SIZE was defined as SZ_512,
> > eight times the actual on-device size.
> > 
> > header_log_copy() reads CXL_HEADERLOG_SIZE_U32 (128) dwords from the
> > RAS capability iomap, overrunning the 88-byte mapping by 448 bytes.
> > The cxl_aer_uncorrectable_error trace event memcpy()s CXL_HEADERLOG_SIZE
> > (512) bytes from its source.  For the CPER caller the source is
> > struct cxl_ras_capability_regs::header_log[16] (64 bytes) embedded in a
> > stack-local cxl_cper_prot_err_work_data, so the memcpy reads 448 bytes
> > of kernel stack into the trace event ring buffer where userspace can
> > read it via tracefs.
> > 
> > Set CXL_HEADERLOG_SIZE to 64 and derive CXL_HEADERLOG_SIZE_U32 from it,
> > bringing all iomap readers into agreement on 16 dwords.  Userspace tools
> > such as rasdaemon have grown a dependency on the buggy 512-byte (128 u32)
> > header_log layout in the cxl_aer_uncorrectable_error trace event.  Add
> > CXL_HEADERLOG_TRACE_SIZE_U32 = 128 and use it for the trace event
> > __array and its memcpy to preserve that ABI.  Both callers now pass a
> > zero-filled u32[CXL_HEADERLOG_TRACE_SIZE_U32] staging buffer with only
> > the first CXL_HEADERLOG_SIZE_U32 (16) entries populated from hardware;
> > the remaining 112 u32s are zero-padded, keeping the 512-byte trace ring
> > buffer layout intact.
> > 
> > Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> > Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>
 
Just a little nit below.

> > ---
> >  drivers/cxl/core/ras.c   | 27 ++++++++++++++++++++-------
> >  drivers/cxl/core/trace.h | 24 ++++++++++++++++--------
> >  drivers/cxl/cxl.h        | 14 ++++++++++++--
> >  3 files changed, 48 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> > index 006c6ffc2f56..99fb00949c2f 100644
> > --- a/drivers/cxl/core/ras.c
> > +++ b/drivers/cxl/core/ras.c
> > @@ -8,6 +8,10 @@
> >  #include <cxlpci.h>
> >  #include "trace.h"
> >  
> > +/* Check that UCE header definition is maintained to keep ABI intact  */
> > +static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
> > +	      "rasdaemon ABI requires exactly 128 u32s");
> > +
> >  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> >  					      struct cxl_ras_capability_regs ras_cap)
> >  {
> > @@ -19,6 +23,7 @@ static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> >  static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> >  						struct cxl_ras_capability_regs ras_cap)
> >  {
> > +	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> >  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> >  	u32 fe;
> >  
> > @@ -28,8 +33,8 @@ static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> >  	else
> >  		fe = status;
> >  
> > -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe,
> > -					       ras_cap.header_log);
> > +	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> > +	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
> >  }
> >  
> >  static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> > @@ -44,6 +49,7 @@ static void
> >  cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> >  			       struct cxl_ras_capability_regs ras_cap)
> >  {
> > +	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> >  	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> >  	u32 fe;
> >  
> > @@ -53,8 +59,15 @@ cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> >  	else
> >  		fe = status;
> >  
> > -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe,
> > -					  ras_cap.header_log);
> > +	/*
> > +	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
> > +	 * dwords.  Copy them into the front of a zero-filled
> > +	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
> > +	 * event memcpy sees a full 512-byte source and the userspace ABI
> > +	 * (rasdaemon) is preserved.
> > +	 */
> > +	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> > +	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> >  }
> >  
> >  static int match_memdev_by_parent(struct device *dev, const void *uport)
> > @@ -204,12 +217,12 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
> >  {
> >  	void __iomem *addr;
> >  	u32 *log_addr;
> > -	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
> > +	int i;
> >  
> >  	addr = ras_base + CXL_RAS_HEADER_LOG_OFFSET;
> >  	log_addr = log;
> >  
> > -	for (i = 0; i < log_u32_size; i++) {
> > +	for (i = 0; i < CXL_HEADERLOG_SIZE_U32; i++) {
> >  		*log_addr = readl(addr);
> >  		log_addr++;
> >  		addr += sizeof(u32);
> > @@ -222,7 +235,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
> >   */
> >  bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
> >  {
> > -	u32 hl[CXL_HEADERLOG_SIZE_U32];
> > +	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> >  	void __iomem *addr;
> >  	u32 status;
> >  	u32 fe;
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index a972e4ef1936..d37876096dd7 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -56,7 +56,7 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> >  		__string(host, dev_name(dev->parent))
> >  		__field(u32, status)
> >  		__field(u32, first_error)
> > -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> > +		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
> >  	),
> >  	TP_fast_assign(
> >  		__assign_str(device);
> > @@ -64,10 +64,14 @@ TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> >  		__entry->status = status;
> >  		__entry->first_error = fe;
> >  		/*
> > -		 * Embed the 512B headerlog data for user app retrieval and
> > -		 * parsing, but no need to print this in the trace buffer.
> > +		 * Embed headerlog data for user app retrieval and parsing,
> > +		 * but no need to print in the trace buffer. Only
> > +		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
> > +		 * the remaining entries preserve the 512-byte ABI layout
> > +		 * rasdaemon depends on and are zero-filled by the caller.
> >  		 */
> > -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> > +		memcpy(__entry->header_log, hl,
> > +			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
> >  	),
> >  	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> >  		  __get_str(device), __get_str(host),
> > @@ -85,7 +89,7 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> >  		__field(u64, serial)
> >  		__field(u32, status)
> >  		__field(u32, first_error)
> > -		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> > +		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
> >  	),
> >  	TP_fast_assign(
> >  		__assign_str(memdev);
> > @@ -94,10 +98,14 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
> >  		__entry->status = status;
> >  		__entry->first_error = fe;
> >  		/*
> > -		 * Embed the 512B headerlog data for user app retrieval and
> > -		 * parsing, but no need to print this in the trace buffer.
> > +		 * Embed headerlog data for user app retrieval and parsing,
> > +		 * but no need to print in the trace buffer. Only
> > +		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
> > +		 * the remaining entries preserve the 512-byte ABI layout
> > +		 * rasdaemon depends on and are zero-filled by the caller.
> >  		 */
> > -		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> > +		memcpy(__entry->header_log, hl,
> > +			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
> >  	),
> >  	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> >  		  __get_str(memdev), __get_str(host), __entry->serial,
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 9b947286eb9b..906fb480dad5 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -148,8 +148,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
> >  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
> >  #define CXL_RAS_CAPABILITY_LENGTH 0x58
> > -#define CXL_HEADERLOG_SIZE SZ_512
> > -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> > +#define CXL_HEADERLOG_SIZE 64

Should we make it consistent as SZ_64 ?

Best regards,
Richard Cheng.

> > +#define CXL_HEADERLOG_SIZE_U32 (CXL_HEADERLOG_SIZE / sizeof(u32))
> > +
> > +/*
> > + * The RAS UCE trace event header array was originally sized at SZ_512/sizeof(u32)
> > + * = 128 u32s due to a bug. Userspace tools (rasdaemon) have grown a dependency
> > + * on that 512-byte layout. Keep the trace array at 128 u32s to preserve the
> > + * ABI; only CXL_HEADERLOG_SIZE_U32 (16) dwords are valid hardware data, the
> > + * remainder are zero-filled.
> > + */
> > +#define CXL_HEADERLOG_TRACE_SIZE SZ_512
> > +#define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
> >  
> >  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
> >  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
> 
> 
