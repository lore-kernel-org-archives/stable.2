Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B443F094
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835557; cv=fail; b=LSKy6fqIN033AJPHuSYO6XdKe2KJIxX809VKK22KdKb5IDlVCqI8G0cExTUTXj16FeKhUSP26cRvbttWzGQUZZnRoCgXT9aMd3oOUTaKdj4a8QYFiJGcm1gFv4pcDFyVRqScAKmsk6jEy+o4urtXLiVP8Bv/qf6AzFT4WE9JRck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835557; c=relaxed/simple;
	bh=nYUqSUeRCrGiM8stk2x0v7sdwoJgE5IFgh6kbpKQuRk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/VLiA5kDBevanP0gH7u1GXT/UiuqJpXj8FTM/EUUhiS8QShoN3hYwVaP2djJ6SMfL6u9sCzEf3fhvDFjr9dBIqagOBNLKiSn+nQ3sfz5dvgyofP13II7naSR3rrOIZ5X3OM5QUExA17eFdzey/FBqkiG5hFczu3M/rpv/AWhfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nxmcrvwq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nxmcrvwq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785835555; x=1817371555;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nYUqSUeRCrGiM8stk2x0v7sdwoJgE5IFgh6kbpKQuRk=;
  b=NxmcrvwqfEg2puriCqRtIG4sywKES092HtZt10rHT4cECx+F7jSWv51u
   sDiE3VVjQNQ72u6x3KqZHi1I2IUUe54ZlIRhK3RK9WenKGbCaLjhYC2sf
   qLnxgwduCMfKVxCKNMUXH7IohZv0VAPSsGxD3/rDGA/KK1qyDaQbWX2Uf
   f8evX80yoS1QAic7Br+73ZjUr5F0+hkgrQWpDXHiPDAuc6sWjgI+hjmHu
   WsaVX7RzCiohhVxeMmvId4AkjbPHANenhJ/04vxw5B68/y9wB+5b0653N
   7MGNpr2LtmCaQFaUDeT42tx4CZ5NPU/x+d2zQoryfXUfmh5L0dXGhX1rj
   A==;
X-CSE-ConnectionGUID: vSriYf7oQqawGyF7bH7AxQ==
X-CSE-MsgGUID: a5+PyI/9QSqW+ETRgroQbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86327803"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86327803"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:25:54 -0700
X-CSE-ConnectionGUID: Ye94YnSHTsKOG3H8S2Oatg==
X-CSE-MsgGUID: i1599nRHSsCw456WL6XODQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="299695070"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 02:25:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 02:25:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 02:25:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 02:25:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnAO8p3Aeciv6DCYNCZdYuw/QcYy5fURYImCCuG2/Qi1LmONZ94gCFmEsrTthMIShXQ5MizwwpQTINRP3+K76RnRr2fv9ueQXzbgaQQlB0xYE48tWZZ1gCXxHvdi4+WU1Gwjqa6UAgffofD0HzbpE1uBe3j4dt2HHJPv15Nnk1DDZvkOB8hibxEDYa2/lYpqTRNKliJwAVU0w9AphaMXVZn99Ed2eq+yQ4RR1/JcPj/Zr3sFjNvofry6WbzH+fqOKtufCjNYjL+iozM+Bs4DpEVd05us/4EEyjXikhfUwAm++O3czkpR0ktBL0QGFnKji0YfBc9gGqzyVVSQdOTMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5lujPcgWWBkTc23SM8V92VkzHRT+AXlj0KrJABzk5s=;
 b=ItHx2fyptma6g6f6xOcu2itUlVkSgOOkQD2q9H+EZDDAcKMFeB17R9tu91sfHe61LBmOPTHiD8A2za5FFw0d+iFIS4sIO7q2vPhIRG7lVSJcbKMyDHvgeWwNunX4oGjzJV3LCvtPN1bcTG9A6wmCBcuNAGW+Ya8JbOlPwkpK0VGK5BNT+AhTadphnqb5H3PXVZDNOKX7YYWx7AD9Qup2jgSyY0wn8Uh8l7L6YvvKs6Wx8DC7cntzZBzFJxY9miXdAe2MqqTldO10jW5+PyPMNnFI67HJDtAV+45eRcFH2MEEWfbd5CzHD38yu3io+fUIgXHEWJrKi8Vw/Dnp7tUE5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:25:48 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:25:47 +0000
Date: Tue, 4 Aug 2026 02:25:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: Jia Yao <jia.yao@intel.com>, <intel-xe@lists.freedesktop.org>,
	"Gwan-gyeong Mun" <gwan-gyeong.mun@intel.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] drm/xe/guc_ads: allocate UM queues in a separate
 BO
Message-ID: <anGwGd94veAeFIJ/@gsse-cloud1.jf.intel.com>
References: <20260803200838.98826-1-jia.yao@intel.com>
 <20260803200838.98826-2-jia.yao@intel.com>
 <fff60c87-460c-4713-a65a-e9c3841bbf2b@intel.com>
 <anGo2nE/j1QUKE0J@gsse-cloud1.jf.intel.com>
 <23d6d8e8-a885-4bed-8384-d2b0b8dc5e11@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23d6d8e8-a885-4bed-8384-d2b0b8dc5e11@intel.com>
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: c25166da-fa8c-46cb-967c-08def20a5e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|5023799004|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G07PSB1i09/Dk80FQzTX0RzJqyeEvnXO/WX9MaDLtTrlFBPMe7lBmT3l5nx5HlyFaEbsRNRtOH+UR/zMZjZunnQ7CEOeEAWaF7TKvEfGoJLWtTdidDTBB8DWN7VaMW/DdQrMgh4VFOsuj8XXSk7J1T3+sDb+9R2B/4J9nlLCjC4k9XvlQvJSf1F+86PHeoJcPXEfeLvRQmhXF44CdCTqu08reWuYRYhgl5AOX+vyNFcViVMe4NBtJPJwJhPrT6so+PbYxdetIUePcFfncwV0KjJGQeuMvZJStvIQRS47DOUi3IDIT9cVSXhjAu3AkgApZDwyTPLGyHNIE8VY5HOTnna5pILTMPacnUTZWAmyaGJkiSg3X8d9/JdOrWuXtUf6LdGeG+DMnGaAdGKN+lRAWTkSkeNXhd4SnWpMbAWNV7BFC0VfvJBWG1kbMmymKheZQt3ymdzjBLC3rDgMmpZQakTfo0LDy80Nivwd9QNIStuvwlnYcTz0cF8EQsrOeZuO0Apqj0eB+AntAOSEP5Yfg8uywhSgAOLJjet/Sl4HXFqBZPbns8hjUK0zEwy5JKtG/XsIZpu+gySzZ7MPwb+0ii7r7DGXDBd0wYvZ4C4FGFWvdhbxLkglU7a+5IkDvoUdZTnR4JWPJH44eoG4jkp8TX2vB2idKF1gBfD/Hex5jlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ar8dmp46tz/PH+7YwaShR44grmzqVzhnSCLG87du6qJReFTaY7asKoYDn0A?=
 =?us-ascii?Q?fx/kyMxM8gvYL6rMDIhjJSUiJHnNdVBzglo/0oN25TNRz5PjwM9nakrecwwg?=
 =?us-ascii?Q?wciPmzQpGlSzXuts2ntfSt8Vo0u6Iw4P/r09Ply0sqpeEoyZjdcBoTqrJVZ/?=
 =?us-ascii?Q?FJXJSN19bFozs2TKPDONOd2qmiEw/60h3e5sXGL50uXDbG5Ms2WAUCPB0OiU?=
 =?us-ascii?Q?ZC2lS3m4f8qR3Kknw52wUlFAET31cHEsOXMtuvA8I4IOfcfvQFeims8frhJv?=
 =?us-ascii?Q?bzfOb7p5DkLgUg2UXdOGyAD7uyrB1cydm+Y41K8w4SznDKUqr3CmJ/xRC7WF?=
 =?us-ascii?Q?/OfBvKWtLskZJj/3TRRut1zvi2DDypNs3Y1CR6ofLzkV3VL3JY7YSTjNVtqI?=
 =?us-ascii?Q?Cnkl1E7E17iCqiVbYdjjDU3cxTFCzoY2eAlEP0WYKLLl9vGawRSYA63qoDsu?=
 =?us-ascii?Q?nYXjhgMrapC1NwSTq+Pboa4RQtCoeKPhDSktCKB+TQuc+RUzM7blWf3OBFXJ?=
 =?us-ascii?Q?10ngsTxursUn44SQzdksD5R1jlzo4MUYD9hfz3NMdEx0cH2H61vEar4KQ8R/?=
 =?us-ascii?Q?aGu5TL5yV4uUWlSEM4gr+jDqqOvkaKjxKRFpf6KgCHH8cNosQbyzUHL6YI1q?=
 =?us-ascii?Q?er+66jCAKHsSyUruyTVlVVJ0hxJLHPj9JFgiQWOKmNAc5SPh8pGlK/Hntsdq?=
 =?us-ascii?Q?6l3oGyjrsDH7QEXsdwFyAFz1N70BoGfnrpRca+aCoiy8K8KSMgbOmOt/Jii/?=
 =?us-ascii?Q?m/4QF4bskjot3E80ts/CtY5VdDSh5TpM3dteNv3BO8Qawdbfd8Gcc4Zpa7jy?=
 =?us-ascii?Q?T6IVnXn3RmNGqxVM5DDAZFWaz3xMtLrphYVc58g+IZvjByhzw/Kf6D39p2F5?=
 =?us-ascii?Q?TFG0IxNlw6djotJqWx3XTen93uHEJF6JE5O4WI4rLVgy56cmmkP7ufN1o0h+?=
 =?us-ascii?Q?lU91whjKwAKIbBvChH21V8oVuEJBzi4pGd5PsyE9ov1NCq4sh8eheWfgvVvk?=
 =?us-ascii?Q?fbeUEajyVvB+vsCgCS1stCgy2poUuKyVrBUTt2mCU1UcCm2W4psPHi8L1Rbz?=
 =?us-ascii?Q?7siNOSo5p/UJI0D+fdcCwUI7zxz/FOeEgcM5wnMuWfbY48Otxb0PlTjQQlLk?=
 =?us-ascii?Q?feTLeNTQPlgF08BfI42ggITjyoxjJPRJSibvXbqIg+pQpul46UTfPCgOV4OO?=
 =?us-ascii?Q?eOia4J/McAZNft4c+QQoUxLcAL7YbMVPUZdaFRLqX5VfIP9bfeBdn0gYp+DB?=
 =?us-ascii?Q?eCnJguZAnYMI7r9CfgFnoPPAUg35p0Jk6TVJruJHl50wLbfYgdv9v9QQpuFz?=
 =?us-ascii?Q?uu2SUD4CVHWrTBfbT7de2frHuEdY6nHDmxLjiVfZl+Lx8Jqee+1UhVvbghEb?=
 =?us-ascii?Q?IpER3fy9iPnKcq9VyviRESBB5MEldKGzHIvb1We5P/ydRHKdaJWM4e7QEvv6?=
 =?us-ascii?Q?UfvlUFNkLO2CQQDFaktXODcW2sUFs+5iyOPPNlS3etcJ4w3+HAoGH4XYHyfR?=
 =?us-ascii?Q?7mmFe1pcoS2eOat4BHOsM1PDvFier7BDh7C7L3/dcpJOrbfRhmk01cGCL5ui?=
 =?us-ascii?Q?Rh1RGrqF1Nm4/COTRsEoWJ9YDH+KQd3Xgq0tlALkkWhvYe1gRkbX0uDE9Ye5?=
 =?us-ascii?Q?4qy+0bl1w93c2q+zejjMBOLDjZphU6VkL4l4Vh872/lpFmLgIp+o0r+ASd2B?=
 =?us-ascii?Q?+m8AaJGd0hcZWffdqvtMhku9ikszyQ4i76T8faMWijLvDku4FXVlzBFNBjVh?=
 =?us-ascii?Q?Ot6CCKZcNjs5Rhjk8Qv7qQflej4QrL8=3D?=
X-Exchange-RoutingPolicyChecked: QgQhcF4icgAuu3zZMS3TGRGKU6hzN2nbwFEJC5ETH1iN6ksKsROYPq3Yjjy36jQW9z9MV16LZu69qgbs11PBYaAHi7jk6OeFSG8jQhJ8pqfSZUIj+605p/0hQSqqvsoBJRphgv0l0GnHVi4BA9FMUmcg7vY6OozBfWyzPTMeLSFTFOaMDfEOrh34E8UhFCyfFVijSQu/g4ZqMK5ZDMF/IpNz5W2T78yhvWxL/zLKRdAfRzOfIoqVENHRHfERp9C3JM2qa9MFRof6qIIRjUQpSOXz3T7WVOpCHuPRi1qpChWRE435HKEleE+g4BQDSpigeIZ/xX8vRwmLWzqa4WE8Sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c25166da-fa8c-46cb-967c-08def20a5e29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:25:47.8255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+W7ufuoQdTQtEX2QTBo2w5m69Fm1+iULjsXDsT/ne0Og8LSUBLXo7lIv0BvnQlQsh/jEb+7WccoGXHUftCZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

On Tue, Aug 04, 2026 at 10:16:07AM +0100, Matthew Auld wrote:
> On 04/08/2026 09:54, Matthew Brost wrote:
> > On Tue, Aug 04, 2026 at 09:00:19AM +0100, Matthew Auld wrote:
> > > On 03/08/2026 21:08, Jia Yao wrote:
> > > > Move the UM queues into a dedicated UC BO (ads->um_queue_bo) and avoid
> > > > CPU memset operations on it, which eliminates the CPU as a potential
> > > > cacheline-polluting agent and helps maintain consistency between GAM
> > > > writes and GuC reads.
> > > > 
> > > > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > > > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: <stable@vger.kernel.org> # v6.12+
> > > > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > > > ---
> > > >    drivers/gpu/drm/xe/xe_guc.c           |  6 ++
> > > >    drivers/gpu/drm/xe/xe_guc_ads.c       | 89 +++++++++++++++++----------
> > > >    drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
> > > >    3 files changed, 68 insertions(+), 32 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
> > > > index 4286bd05c686..4f132bf8539d 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc.c
> > > > +++ b/drivers/gpu/drm/xe/xe_guc.c
> > > > @@ -732,6 +732,12 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
> > > >    	if (ret)
> > > >    		return ret;
> > 
> > Add a newline here.
> > 
> > > > +	if (guc->ads.um_queue_bo) {
> > > > +		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > >    	return 0;
> > > >    }
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > index f0ac00586d3a..ef8e9cc35c8c 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_ads.c
> > > > @@ -8,6 +8,7 @@
> > > >    #include <linux/fault-inject.h>
> > > >    #include <drm/drm_managed.h>
> > > > +#include <drm/drm_prime.h>
> > > >    #include <generated/xe_wa_oob.h>
> > > > @@ -64,10 +65,14 @@ ads_to_map(struct xe_guc_ads *ads)
> > > >    /*
> > > >     * The Additional Data Struct (ADS) has pointers for different buffers used by
> > > > - * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
> > > > - * all the extra buffers indirectly linked via the ADS struct's entries.
> > > > + * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
> > > > + * and most of the extra buffers linked via the ADS struct's entries.  The UM
> > > > + * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
> > > > + * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
> > > > + * performed on every GT reset does not discard fault descriptors already
> > > > + * written into the rings by the GPU.
> > > >     *
> > > > - * Layout of the ADS blob allocated for the GuC:
> > > > + * Layout of the ADS blob (ads->bo):
> > > >     *
> > > >     *      +---------------------------------------+ <== base
> > > >     *      | guc_ads                               |
> > > > @@ -99,10 +104,6 @@ ads_to_map(struct xe_guc_ads *ads)
> > > >     *      +---------------------------------------+
> > > >     *      | padding                               |
> > > >     *      +---------------------------------------+ <== 4K aligned
> > > > - *      | UM queues                             |
> > > > - *      +---------------------------------------+
> > > > - *      | padding                               |
> > > > - *      +---------------------------------------+ <== 4K aligned
> > > >     *      | private data                          |
> > > >     *      +---------------------------------------+
> > > >     *      | padding                               |
> > > > @@ -156,16 +157,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
> > > >    	return PAGE_ALIGN(ads->capture_size);
> > > >    }
> > > > -static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
> > > > -{
> > > > -	struct xe_device *xe = ads_to_xe(ads);
> > > > -
> > > > -	if (!xe->info.has_usm)
> > > > -		return 0;
> > > > -
> > > > -	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
> > > > -}
> > > > -
> > > >    static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
> > > >    {
> > > >    	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
> > > > @@ -206,22 +197,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
> > > >    	return PAGE_ALIGN(offset);
> > > >    }
> > > > -static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
> > > > -{
> > > > -	u32 offset;
> > > > -
> > > > -	offset = guc_ads_capture_offset(ads) +
> > > > -		 guc_ads_capture_size(ads);
> > > > -
> > > > -	return PAGE_ALIGN(offset);
> > > > -}
> > > > -
> > > >    static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
> > > >    {
> > > >    	size_t offset;
> > > > -	offset = guc_ads_um_queues_offset(ads) +
> > > > -		guc_ads_um_queues_size(ads);
> > > > +	offset = guc_ads_capture_offset(ads) +
> > > > +		guc_ads_capture_size(ads);
> > > >    	return PAGE_ALIGN(offset);
> > > >    }
> > > > @@ -461,6 +442,44 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
> > > >    	ads->bo = bo;
> > > > +	if (xe->info.has_usm) {
> > > > +		/*
> > > > +		 * Allocate a separate BO for the HW fault ring (UM queues).
> > > > +		 *
> > > > +		 * Round the size up to the next power of two so that
> > > > +		 * (system memory, no IOMMU) the TTM pool issues a single
> > > > +		 * alloc_pages(order=N) call, maximising the chance of getting
> > > > +		 * a physically contiguous block.  GuC requires contiguous DPA.
> > > > +		 */
> > > > +		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
> > > > +						    GUC_UM_HW_QUEUE_MAX);
> > > > +
> > > > +		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
> > > > +						  XE_BO_FLAG_SYSTEM |
> > > > +						  XE_BO_FLAG_GGTT |
> > > > +						  XE_BO_FLAG_GGTT_INVALIDATE |
> > > > +						  XE_BO_FLAG_PINNED_NORESTORE);
> > > > +		if (IS_ERR(bo))
> > > > +			return PTR_ERR(bo);
> > > > +
> > > > +		/*
> > > > +		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
> > > > +		 * ring via base_dpa, which must be a contiguous DMA address
> > > > +		 * range.  Verify that the allocated pages are contiguous in
> > > > +		 * DMA address space.
> > > > +		 */
> > > > +		if (xe_bo_sg(bo) &&
> > > 
> > > 
> > > There is a comment from Sashiko that there might not be a valid tt for vram
> > > buffers, so perhaps just make this check !xe_bo_is_vram() instead?
> > > 
> > > > +		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
> > > > +		    unlikely(drm_prime_get_contiguous_size(xe_bo_sg(bo)) <
> > 
> > Using drm_prime_* really is the wrong layering. Either this helper
> > should be some drm or sg generic or IMO we implement this helper
> > ourselves until we have a proper one in drm or sg generic.
> > 
> > e.g., for SG specific BOs, something like this should work.
> > 
> > xe_bo_sg_is_contigous(struct xe_bo *bo)
> > {
> > 	struct xe_res_cursor cur;
> > 
> > 	xe_assert(xe_bo_device(bo), xe_bo_sg(bo));
> > 	xe_res_first_sg(xe_bo_sg(bo), 0, xe_bo_size(bo), &cur);
> > 
> > 	return cur.size == xe_bo_size(bo);
> > }
> 
> AFAICT I don't think it's the same since you could potentially get multiple
> sg entries underneath, where they still occupy something contig as a whole,

Yes, that is possible but SG segment in Xe is 1 or 2G iirc.

> and xe_res_first_sg() doesn't try to coalesce. Maybe it should? The

As long as segment is at least 1G then it doesn't really matter for
existing use cases. 

> !xe_bo_sg_is_contigous() will be fatal, so I think we should try as hard as
> possible for the check.
> 
> Agreed drm_prime_get_contiguous_size() is a bit odd, but essentially we were
> previously implementing the same thing.

Maybe move this into xe_bo helper to make this slighly more palatable
(i.e., at least only BO layer is looking at prime).

e.g.,

xe_bo_sg_is_contigous(bo, len)
	return drm_prime_get_contiguous_size(xe_bo_sg(bo)) >= len;

or

xe_bo_sg_is_contigous(bo)
	return drm_prime_get_contiguous_size(xe_bo_sg(bo)) == xe_bo_size(bo);

Matt

> 
> > 
> > Matt
> > 
> > > > +			     GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX)) {
> > > > +			drm_err(&xe->drm,
> > > > +				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
> > > > +			return -ENOMEM;
> > > > +		}
> > > > +
> > > > +		ads->um_queue_bo = bo;
> > > > +	}
> > > > +
> > > >    	return 0;
> > > >    }
> > > >    ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
> > > > @@ -893,7 +912,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
> > > >    static void guc_um_init_params(struct xe_guc_ads *ads)
> > > >    {
> > > > -	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
> > > > +	struct xe_bo *um_bo = ads->um_queue_bo;
> > > >    	struct xe_guc *guc = ads_to_guc(ads);
> > > >    	struct xe_device *xe = ads_to_xe(ads);
> > > >    	u64 base_dpa;
> > > > @@ -903,8 +922,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
> > > >    	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
> > > > -	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
> > > > -	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
> > > > +	if (um_bo) {
> > > > +		/* All USM platforms: UM queues in dedicated um_queue_bo */
> > > > +		base_ggtt = xe_bo_ggtt_addr(um_bo);
> > > > +		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
> > > > +	} else {
> > > > +		/* Platform does not support USM: no UM queues, nothing to do */
> > > > +		return;
> > > > +	}
> > > >    	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
> > > >    		/*
> > > > diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> > > > index 48a8e092023f..845c1fbd93a4 100644
> > > > --- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
> > > > +++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
> > > > @@ -16,6 +16,11 @@ struct xe_bo;
> > > >    struct xe_guc_ads {
> > > >    	/** @bo: Xe BO for GuC ads blob */
> > > >    	struct xe_bo *bo;
> > > > +	/**
> > > > +	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
> > > > +	 * NULL if the platform does not support USM.
> > > > +	 */
> > > > +	struct xe_bo *um_queue_bo;
> > > >    	/** @golden_lrc_size: golden LRC size */
> > > >    	size_t golden_lrc_size;
> > > >    	/** @regset_size: size of register set passed to GuC for save/restore */
> > > 
> 
