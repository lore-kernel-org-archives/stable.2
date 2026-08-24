Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398C34E75D;
	Mon, 24 Aug 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599859; cv=fail; b=L3SYJWWWiSoHo8IuTuYKibomTPszzpM+TvE2ke42xhwy/O8KmWc1NQbictpDib3tvzHYlhRvIup4R7yF2fFWcJKP+J915JQUy0IOl0jAe3D1WMneIRQpAiKpXUHKLVVVUxaXZM1DMeVJ3K87FTabJP7SNwCAtXwKwWpds/r4l0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599859; c=relaxed/simple;
	bh=1UthckVIs0QWC3XsgXFfyctcerlQbaddA3tqmI8upl0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cgh7lWFAEDLg1/6esK/+PNCn6nGg0NvuGeQ/6PWNq+ZJLIN57WCn4aEHU/RlU1P9B7Vf+z7fNYU2apefNY/17PwdqfxlASZEM05GUyjIVbGRoARiJX6rcyHXRZ/ss6BWwWDg83K7lBdRz0oKY8h360ow3kWbqosGYB+Iek3uyz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iJCrb27K; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iJCrb27K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787599857; x=1819135857;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1UthckVIs0QWC3XsgXFfyctcerlQbaddA3tqmI8upl0=;
  b=iJCrb27KAHTmx4N+s4oE+ReFvJs/5Da5LLAfymA/t1LV1ipO//1+6Bf/
   uwFaL3F4FFPtbRXqPEjFp2j3oovomY7tTbnbjbOG1gzDn+nXZptzSgVtL
   7TbBIJIDF7jOfnkVwpBmSK8RpjFL8Rk+8lyMAYMqka/QjsZVZCzfKs68v
   LeIusK+Bm4gdIhdXv0iIF7mxqFJIhR5MNM6OI8iy3l+abNu/C3JS3X4nJ
   rP3j24K36Qbu/AjV+7Mk2nuYcA3xiryUlaib1isSABaQkWjqbzNJ+u6Ve
   vIU3xBx9ziRPhvWhEyxy8nVB2kiSvYsbCh7zYFntj3xvU8XcZll6xRBNL
   w==;
X-CSE-ConnectionGUID: j8nrUgRPTxG3nV25AIAvAA==
X-CSE-MsgGUID: 1B8o0BFiRDaUZkntuOS7ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="98736638"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="98736638"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:30:42 -0700
X-CSE-ConnectionGUID: XhEOwr1gSR2LmDs/nTKiHQ==
X-CSE-MsgGUID: POSZpDOoQkmoqesbf4ru2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="291935412"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 12:30:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:30:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 12:30:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.54) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 12:30:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol6ms+QiZD7Pv4y03xf4LABFQFVjfBfzHYcDFLXPbFKu/WwzJHy/Zh6Y34O3dtJIvcfQ6/HeNlLaScGMymzBZWaN0FTEbxPm8Vh8jHkAIM0hdn7OTsbyHqTN74p412f1RUIuUAfK6hZEblFhXAVV0dzjW/b+wQx1x4ay1VNSbbsH+V742NdNGzSaKAjUBNYSdRzmQKPRPnfCzpjUNQkxbRiSEo3FINW2jTSngClgzNe1Jj96XFvNoCSNvqd4bBnq99IwOoH2G2AiDWCBnGnUA/Bu9LZpUe6Xv1kwb80TSQS4AR6p9dkAbANLI4qalmUcHQ9vbf7gmxZDi1j2s2HJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B+Hbvq8WhNXAcqn/as6kwHtszP3nmxJqG3aK4Xv3Go=;
 b=rv3khNBsO/LCYzGlRN2/KH5zdCglGUZ3+EuF6ka8heQ5R8SsHx87JZdZPhlZrb7AGtiRkIxluqbDeodDFXT1yb0p5mRfWkTn2DE743DSZ77SN5mRb8Yrwb5tRVRbGWO590qn9trZF1BTd9ulnKTo6L+4TSD/D9c8ZkB0jWoOWdteffct7/J4/DosQxQbJrFjVqErq6o3K4w5dU+A0CxGQ3TXPvLVdhXLwJSKfixZi6dUNnsXGxfN1c9+AUob0F8+xVrfdfbGIhBzQOPxDnIPGQUxd58Iv9nCbTLC8690UhUFhvlDqKmFEPxxwJ8w9AZ10jdT7TtgrcDgmwLrDevUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by CH0PR11MB8168.namprd11.prod.outlook.com (2603:10b6:610:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 19:30:30 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 19:30:30 +0000
Date: Mon, 24 Aug 2026 15:30:25 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, Raag Jadav
	<raag.jadav@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andi Shyti
	<andi.shyti@kernel.org>, Ramesh Babu B <ramesh.babu.b@intel.com>, "Michael J.
 Ruhl" <michael.j.ruhl@intel.com>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] i2c: designware: Global register definitions
Message-ID: <aoyb0WYzCd-DEIWC@intel.com>
References: <20260811121008.1493015-1-heikki.krogerus@linux.intel.com>
 <20260811121008.1493015-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811121008.1493015-2-heikki.krogerus@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|CH0PR11MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e99406-b254-4bca-1285-08df02162897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: iKJnYPwHhrArtTmwHGCifAoTceiTM4Djzxph7pN6WUAGAVGiT6t/BC4AEVfGLZXUU7AQLq9wh4S60ctlJ648fyLHPpcDUjnoDg59v+EmeycNrrFIViFpCIT4+0STlltmeh9L3OOaujrBsdZviMBv2IJmHQGU55WP5hO62zZawzo8LZH1JjzW1W8+TCJEptYYIV2m3m0ae+3q6P6mLZrCPkVk1TpKV6rRqV1BD9HPz+GgIc1/MsQfizAtegind/Pe4xgmApJZsnZVLxJ6UXqLvHX4IW4PZY9uJZMwpFTHrQZPQX9GAjRNMSHuRpT8htjwX2qe1gHiPU9M5ulhP5dCNrqkMstE+kL3Nt1hV7quH+jQdV+PjkSQ7i+cvOXBl9D5Xw54G8K8+qCjFL3OKfZ3hRwU1tjc3Z3VsnMLuKtYq9J/1fDgAeQKsfOH0PCBd5+CDp1VOF9hbPKNw0Fbh3QzrTC1SmoSXej/uFlLHcBfsF/j0aFtbrkvA+ycKXGhYnNSFM9hZjQVMlGOK0R14m3seeS1d8MlDwGroOvyjfxH9N4lLqPeCNQS20+YXlS2n3Kfn2GTGNRk7LVNC85lSZ5csUgCmbcTTZy+tvkhA1Iw7RyU+nE0KqJTXv8KDpbINaP+jVm0T5OZfnoK0C8FvjyaxyM+WPOthAZKHZaeXw3jAoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7752.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H2CpCDAi3l1Xcn5XIb2taZZULo6UL4NGurhdJc9/9ssEBOl4McE2cAd8z5qA?=
 =?us-ascii?Q?NE9rnGX2WxYMTKvFcEPz8OEDaMK8T9T1tgCZg/IO/lg1rG9+qECrbn2ZVU90?=
 =?us-ascii?Q?0JGTK4NBkrniSeMVX6EGZmmX1aqEHDg7AWjQ/jLUdnkmrCF7FwgjHgACyn/5?=
 =?us-ascii?Q?xBbImRJznoFWrSuivvTt1mYtXHy9mn8tSYOApr1BPgNzOE8lc+EOkOec/bDC?=
 =?us-ascii?Q?crqvhTKKc9Fw2ekYW34CGul9BcyC9Eem18hhpMRBhMSeUn2LUVlOhBkbLrZn?=
 =?us-ascii?Q?DDntzNwDMNeaVWo5dwrcDEujmLhJErtN8Ubj5sV66NqVHVZokxfpzWg2dGX7?=
 =?us-ascii?Q?/kouDlRYe3V6L21Vbejq19hUbC0bFPvRETvYzTrZCWcfvfwO59qa0iux4hdr?=
 =?us-ascii?Q?qm49rwi6bgbXiYavmWnya/NvH9vEE1j9SMXReVoIU1ibyCCLkzyuZSUfOlLb?=
 =?us-ascii?Q?aTT5HDv2vUQfn9Q4rBE0wWPywipvgZ7RXXJn3eyJUA3f1Fq3R4YOR3wUPLz+?=
 =?us-ascii?Q?eDkCLodpqkomVTDZIBNsmxtj5hzXxoxJ6qpLeIXo0nUG8gz7XaPF0VhSmhmO?=
 =?us-ascii?Q?GyHWIR9L+kX6yK7T94K8wIBFa3wSrR67hlWnUT9qa8FAGo3UbiiKFQZm19/7?=
 =?us-ascii?Q?wdCthdZLIfFY/a1sNucRz2c8j1HBd4mttjJKOt0OvXOlxk2e61/hfEAEg/tu?=
 =?us-ascii?Q?tijDIFz0A6TGAXoSVOxLjUDr2DdEdSPo6MSShqNq2QC1fheYBZFOcNxOv4Hm?=
 =?us-ascii?Q?rw7A96ru0qOyKSMYp2Z7Gt1ojWjkS3GsNawqk16YI/0PQnvt5O9A7WtswAZK?=
 =?us-ascii?Q?4UYgGaFlcfDhGk/i2d6ddl8uJ2IaIR9aaSOqnV4Ta+XZxvB4wIHI7PbUBlMq?=
 =?us-ascii?Q?zr43M+9Q4yC8WeihdSE3gvtrCHKFw13hHwiMkmAlp6fT9rLY1fZGUgItI/pY?=
 =?us-ascii?Q?48phknCHy518YhN5rXKVJpiS+X20B/rJbWRcs/1tE2IWx276KC31utUSOKIO?=
 =?us-ascii?Q?cHqHg6WW732gBT3D8/M93SBlsJX0GOWVbKg1cBY5j8lwlqFAymP0MDrqHdEP?=
 =?us-ascii?Q?FlSrWw7wLSihqtcSoHtcqcfAMQOFLgbxDEygkxPLn+A19xRZ7Y4US0BW3rqI?=
 =?us-ascii?Q?fR5bgBLOqyHvmOnhLlte0mcvYKBjgQR8vTB85wTatf9j2XZ+FBwHiTWGn3hp?=
 =?us-ascii?Q?6K4b2Q6bt3mazdyFzCG5STVID+ZH/RGMiNa4XyZ/QQ6dFZ0Qphl8uyF8hk4m?=
 =?us-ascii?Q?QDYrPT3LYjeveDIQCyA5wRGRphQAOXLDSVlfuzOIR63V0Xjgbj4q+88BfbV/?=
 =?us-ascii?Q?AOS3n0HYPHPKL0WBnCmXoOzbHCVCUA19rPL7+4Xcl+hrHb8/6a2ZPvvFn0JJ?=
 =?us-ascii?Q?JzBZ92Gm2N/Xbqys12zEqg+/7mW8/9w4L8EBNtpH/gv015lHfDhoCwxtdps0?=
 =?us-ascii?Q?tTz9zWIVOGyqU0OQJ6CufGZ9uQniBLnCu+R7D4uUvVetoKSwPe71FKSZFySz?=
 =?us-ascii?Q?Ooxouy7RfyjCdtEaJevF0VRYoaFEEsBn7w250opejDLoIE+DBSVvWJjSTDSL?=
 =?us-ascii?Q?VMIof+MrYOt2aJyLU2hn4cu9k5i1YXJwCzhd4yRJB9WF6pJF84N9OOZHB06Z?=
 =?us-ascii?Q?X43Wx/b3IP8PD3CWUoQRvm2PWjvcGL9Nr5WdwlEiIVjpjiNhVPp3b5DiwDtx?=
 =?us-ascii?Q?ratT7lu6u/kizCkIq531S0lqmv/XxLZQNnmxMlEwegT44vI7i/C62e2nI0IA?=
 =?us-ascii?Q?zAFnFkyNIg=3D=3D?=
X-Exchange-RoutingPolicyChecked: g5FtNe4Y48Rqo3LZ2EAz9gZDRh/GvWzbwYl/0i3A5i6/AyORRox/dLblYbyZwrQP/qREBBZNJ2uASM6P/+ctC2BVUBw3qzDtdcYL1j2QU4ZKyB98UfD566MDUh2bMkq8z1jh1tHe79GLcQi5uAgcdLs/HSEQ2LbnO4BHgDbmJSEvf+rD5PN1lsqc1sjmw+tjAckehefz88hiWAsRGLuoo4WsH8lFu6IHNAzPkAYI06frnsiqMRWFk3uiku7mOm//Rdn0fWAkWfPYirvE+TBlDcvqOK/Ir6eQFTd9EXkDEEUG7xbIcYIP5HOuZTRAD9JyDYKOELSqaEy1EpQPxWPrvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e99406-b254-4bca-1285-08df02162897
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 19:30:30.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FEMNHW8+UoEHWsMUCoAd2/+/96U/L4vfT4AkhYz90+2+IQxgb99kXLJXTGbRpJpFlYstLhzX6FidnNEDNiyoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8168
X-OriginatorOrg: intel.com

On Tue, Aug 11, 2026 at 02:10:06PM +0200, Heikki Krogerus wrote:
> Moving the register definitions to a global header file
> include/linux/designware_i2c.h. That removes the need to
> duplicate them in the adaptation layers for this driver
> outside of drivers/i2c/busses/. There is at least one of
> those in drivers/gpu/drm/xe/xe_i2c.c.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Andi, Mika, are you okay to get this merged through drm-xe-next?

Thanks,
Rodrigo.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  MAINTAINERS                                |   1 +
>  drivers/i2c/busses/i2c-designware-common.c |   2 +
>  drivers/i2c/busses/i2c-designware-core.h   |  85 +---------------
>  drivers/i2c/busses/i2c-designware-master.c |   2 +
>  drivers/i2c/busses/i2c-designware-slave.c  |   2 +
>  include/linux/designware_i2c.h             | 107 +++++++++++++++++++++
>  6 files changed, 116 insertions(+), 83 deletions(-)
>  create mode 100644 include/linux/designware_i2c.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 928b3ba23a76b..1d0685b2cfdb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26253,6 +26253,7 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  L:	linux-i2c@vger.kernel.org
>  S:	Supported
>  F:	drivers/i2c/busses/i2c-designware-*
> +F:	include/linux/designware_i2c.h
>  
>  SYNOPSYS DESIGNWARE I2C DRIVER - AMDISP
>  M:	Nirujogi Pratap <pratap.nirujogi@amd.com>
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index e4dfa2ec58bb7..a1eca6cd4b75e 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -33,6 +33,8 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include <linux/designware_i2c.h>
> +
>  #include "i2c-designware-core.h"
>  
>  #define DW_IC_DEFAULT_BUS_CAPACITANCE_pF	100
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index c71aa2dd368d5..2c929a6e8da2a 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -18,6 +18,8 @@
>  #include <linux/regmap.h>
>  #include <linux/types.h>
>  
> +#include <linux/designware_i2c.h>
> +
>  #define DW_IC_DEFAULT_FUNCTIONALITY		(I2C_FUNC_I2C | \
>  						 I2C_FUNC_SMBUS_BYTE | \
>  						 I2C_FUNC_SMBUS_BYTE_DATA | \
> @@ -25,23 +27,6 @@
>  						 I2C_FUNC_SMBUS_BLOCK_DATA | \
>  						 I2C_FUNC_SMBUS_I2C_BLOCK)
>  
> -#define DW_IC_CON_MASTER			BIT(0)
> -#define DW_IC_CON_SPEED_STD			(1 << 1)
> -#define DW_IC_CON_SPEED_FAST			(2 << 1)
> -#define DW_IC_CON_SPEED_HIGH			(3 << 1)
> -#define DW_IC_CON_SPEED_MASK			GENMASK(2, 1)
> -#define DW_IC_CON_10BITADDR_SLAVE		BIT(3)
> -#define DW_IC_CON_10BITADDR_MASTER		BIT(4)
> -#define DW_IC_CON_RESTART_EN			BIT(5)
> -#define DW_IC_CON_SLAVE_DISABLE			BIT(6)
> -#define DW_IC_CON_STOP_DET_IFADDRESSED		BIT(7)
> -#define DW_IC_CON_TX_EMPTY_CTRL			BIT(8)
> -#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL		BIT(9)
> -#define DW_IC_CON_BUS_CLEAR_CTRL		BIT(11)
> -
> -#define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
> -#define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
> -
>  /*
>   * Register access parameters
>   */
> @@ -55,65 +40,9 @@
>  #define DW_IC_FIFO_RX_FIELD			GENMASK(15, 8)
>  #define DW_IC_FIFO_MIN_DEPTH			2
>  
> -/*
> - * Registers offset
> - */
> -#define DW_IC_CON				0x00
> -#define DW_IC_TAR				0x04
> -#define DW_IC_SAR				0x08
> -#define DW_IC_DATA_CMD				0x10
> -#define DW_IC_SS_SCL_HCNT			0x14
> -#define DW_IC_SS_SCL_LCNT			0x18
> -#define DW_IC_FS_SCL_HCNT			0x1c
> -#define DW_IC_FS_SCL_LCNT			0x20
> -#define DW_IC_HS_SCL_HCNT			0x24
> -#define DW_IC_HS_SCL_LCNT			0x28
> -#define DW_IC_INTR_STAT				0x2c
> -#define DW_IC_INTR_MASK				0x30
> -#define DW_IC_RAW_INTR_STAT			0x34
> -#define DW_IC_RX_TL				0x38
> -#define DW_IC_TX_TL				0x3c
> -#define DW_IC_CLR_INTR				0x40
> -#define DW_IC_CLR_RX_UNDER			0x44
> -#define DW_IC_CLR_RX_OVER			0x48
> -#define DW_IC_CLR_TX_OVER			0x4c
> -#define DW_IC_CLR_RD_REQ			0x50
> -#define DW_IC_CLR_TX_ABRT			0x54
> -#define DW_IC_CLR_RX_DONE			0x58
> -#define DW_IC_CLR_ACTIVITY			0x5c
> -#define DW_IC_CLR_STOP_DET			0x60
> -#define DW_IC_CLR_START_DET			0x64
> -#define DW_IC_CLR_GEN_CALL			0x68
> -#define DW_IC_ENABLE				0x6c
> -#define DW_IC_STATUS				0x70
> -#define DW_IC_TXFLR				0x74
> -#define DW_IC_RXFLR				0x78
> -#define DW_IC_SDA_HOLD				0x7c
> -#define DW_IC_TX_ABRT_SOURCE			0x80
> -#define DW_IC_ENABLE_STATUS			0x9c
> -#define DW_IC_CLR_RESTART_DET			0xa8
> -#define DW_IC_SMBUS_INTR_MASK			0xcc
> -#define DW_IC_COMP_PARAM_1			0xf4
> -#define DW_IC_COMP_VERSION			0xf8
>  #define DW_IC_SDA_HOLD_MIN_VERS			0x3131312A /* "111*" == v1.11* */
> -#define DW_IC_COMP_TYPE				0xfc
>  #define DW_IC_COMP_TYPE_VALUE			0x44570140 /* "DW" + 0x0140 */
>  
> -#define DW_IC_INTR_RX_UNDER			BIT(0)
> -#define DW_IC_INTR_RX_OVER			BIT(1)
> -#define DW_IC_INTR_RX_FULL			BIT(2)
> -#define DW_IC_INTR_TX_OVER			BIT(3)
> -#define DW_IC_INTR_TX_EMPTY			BIT(4)
> -#define DW_IC_INTR_RD_REQ			BIT(5)
> -#define DW_IC_INTR_TX_ABRT			BIT(6)
> -#define DW_IC_INTR_RX_DONE			BIT(7)
> -#define DW_IC_INTR_ACTIVITY			BIT(8)
> -#define DW_IC_INTR_STOP_DET			BIT(9)
> -#define DW_IC_INTR_START_DET			BIT(10)
> -#define DW_IC_INTR_GEN_CALL			BIT(11)
> -#define DW_IC_INTR_RESTART_DET			BIT(12)
> -#define DW_IC_INTR_MST_ON_HOLD			BIT(13)
> -
>  #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
>  						 DW_IC_INTR_TX_ABRT | \
>  						 DW_IC_INTR_STOP_DET)
> @@ -123,16 +52,6 @@
>  						 DW_IC_INTR_RX_UNDER | \
>  						 DW_IC_INTR_RD_REQ)
>  
> -#define DW_IC_ENABLE_ENABLE			BIT(0)
> -#define DW_IC_ENABLE_ABORT			BIT(1)
> -
> -#define DW_IC_STATUS_ACTIVITY			BIT(0)
> -#define DW_IC_STATUS_TFE			BIT(2)
> -#define DW_IC_STATUS_RFNE			BIT(3)
> -#define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
> -#define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
> -#define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
> -
>  #define DW_IC_SDA_HOLD_RX_SHIFT			16
>  #define DW_IC_SDA_HOLD_RX_MASK			GENMASK(23, 16)
>  
> diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
> index 7a301c8b604ef..a1bcc3797e4ff 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -25,6 +25,8 @@
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> +#include <linux/designware_i2c.h>
> +
>  #include "i2c-designware-core.h"
>  
>  #define AMD_TIMEOUT_MIN_US	25
> diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
> index ad0d5fbfa6d5e..0abcc7757b231 100644
> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -19,6 +19,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/designware_i2c.h>
> +
>  #include "i2c-designware-core.h"
>  
>  int i2c_dw_reg_slave(struct i2c_client *slave)
> diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
> new file mode 100644
> index 0000000000000..53f37f18a7229
> --- /dev/null
> +++ b/include/linux/designware_i2c.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Synopsys DesignWare I2C register definitions
> + *
> + * Copyright (C) 2026, Intel Corporation
> + */
> +
> +#ifndef __LINUX_DESIGNWARE_I2C_H
> +#define __LINUX_DESIGNWARE_I2C_H
> +
> +#include <linux/bits.h>
> +
> +/*
> + * Registers offset
> + */
> +#define DW_IC_CON				0x00
> +#define DW_IC_TAR				0x04
> +#define DW_IC_SAR				0x08
> +#define DW_IC_DATA_CMD				0x10
> +#define DW_IC_SS_SCL_HCNT			0x14
> +#define DW_IC_SS_SCL_LCNT			0x18
> +#define DW_IC_FS_SCL_HCNT			0x1c
> +#define DW_IC_FS_SCL_LCNT			0x20
> +#define DW_IC_HS_SCL_HCNT			0x24
> +#define DW_IC_HS_SCL_LCNT			0x28
> +#define DW_IC_INTR_STAT				0x2c
> +#define DW_IC_INTR_MASK				0x30
> +#define DW_IC_RAW_INTR_STAT			0x34
> +#define DW_IC_RX_TL				0x38
> +#define DW_IC_TX_TL				0x3c
> +#define DW_IC_CLR_INTR				0x40
> +#define DW_IC_CLR_RX_UNDER			0x44
> +#define DW_IC_CLR_RX_OVER			0x48
> +#define DW_IC_CLR_TX_OVER			0x4c
> +#define DW_IC_CLR_RD_REQ			0x50
> +#define DW_IC_CLR_TX_ABRT			0x54
> +#define DW_IC_CLR_RX_DONE			0x58
> +#define DW_IC_CLR_ACTIVITY			0x5c
> +#define DW_IC_CLR_STOP_DET			0x60
> +#define DW_IC_CLR_START_DET			0x64
> +#define DW_IC_CLR_GEN_CALL			0x68
> +#define DW_IC_ENABLE				0x6c
> +#define DW_IC_STATUS				0x70
> +#define DW_IC_TXFLR				0x74
> +#define DW_IC_RXFLR				0x78
> +#define DW_IC_SDA_HOLD				0x7c
> +#define DW_IC_TX_ABRT_SOURCE			0x80
> +#define DW_IC_ENABLE_STATUS			0x9c
> +#define DW_IC_CLR_RESTART_DET			0xa8
> +#define DW_IC_SMBUS_INTR_STAT			0xc8
> +#define DW_IC_SMBUS_INTR_MASK			0xcc
> +#define DW_IC_CLR_SMBUS_INTR			0xd4
> +#define DW_IC_COMP_PARAM_1			0xf4
> +#define DW_IC_COMP_VERSION			0xf8
> +#define DW_IC_COMP_TYPE				0xfc
> +
> +/* DW_IC_CON bits */
> +#define DW_IC_CON_MASTER			BIT(0)
> +#define DW_IC_CON_SPEED_STD			(1 << 1)
> +#define DW_IC_CON_SPEED_FAST			(2 << 1)
> +#define DW_IC_CON_SPEED_HIGH			(3 << 1)
> +#define DW_IC_CON_SPEED_MASK			GENMASK(2, 1)
> +#define DW_IC_CON_10BITADDR_SLAVE		BIT(3)
> +#define DW_IC_CON_10BITADDR_MASTER		BIT(4)
> +#define DW_IC_CON_RESTART_EN			BIT(5)
> +#define DW_IC_CON_SLAVE_DISABLE			BIT(6)
> +#define DW_IC_CON_STOP_DET_IFADDRESSED		BIT(7)
> +#define DW_IC_CON_TX_EMPTY_CTRL			BIT(8)
> +#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL		BIT(9)
> +#define DW_IC_CON_BUS_CLEAR_CTRL		BIT(11)
> +
> +/* DW_IC_DATA_CMD bits */
> +#define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
> +#define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
> +
> +/* DW_IC_INTR_* bits */
> +#define DW_IC_INTR_RX_UNDER			BIT(0)
> +#define DW_IC_INTR_RX_OVER			BIT(1)
> +#define DW_IC_INTR_RX_FULL			BIT(2)
> +#define DW_IC_INTR_TX_OVER			BIT(3)
> +#define DW_IC_INTR_TX_EMPTY			BIT(4)
> +#define DW_IC_INTR_RD_REQ			BIT(5)
> +#define DW_IC_INTR_TX_ABRT			BIT(6)
> +#define DW_IC_INTR_RX_DONE			BIT(7)
> +#define DW_IC_INTR_ACTIVITY			BIT(8)
> +#define DW_IC_INTR_STOP_DET			BIT(9)
> +#define DW_IC_INTR_START_DET			BIT(10)
> +#define DW_IC_INTR_GEN_CALL			BIT(11)
> +#define DW_IC_INTR_RESTART_DET			BIT(12)
> +#define DW_IC_INTR_MST_ON_HOLD			BIT(13)
> +
> +/* DW_IC_ENABLE bits */
> +#define DW_IC_ENABLE_ENABLE			BIT(0)
> +#define DW_IC_ENABLE_ABORT			BIT(1)
> +
> +/* DW_IC_STATUS bits */
> +#define DW_IC_STATUS_ACTIVITY			BIT(0)
> +#define DW_IC_STATUS_TFE			BIT(2)
> +#define DW_IC_STATUS_RFNE			BIT(3)
> +#define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
> +#define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
> +#define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
> +
> +/* DW_IC_SMBUS_INTR_* bits */
> +#define DW_IC_SMBUS_INTR_ALERT			BIT(10)
> +
> +#endif /* __LINUX_DESIGNWARE_I2C_H */
> -- 
> 2.50.1
> 
