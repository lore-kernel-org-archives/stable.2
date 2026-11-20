Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157683;
	b=eLOh6jLkVqlCf26nFNQFkX4PnA6rbaxYR8zsxz05W0WYN2Ch129/gmWV9yHX81V/DxR2
	 JZ/vOVUOXg5iX8TOq3n7KsfpTOkkqQaG/tS9uCY6e35UMSRZWUyA7b12hE4r2bN/JvADB
	 iGodt7gM/awZKD+K5FhlM5wtj6PneHtzWaRZvN974WiDjrlCZpYe4t1wgjP7k0mG/Vp4Y
	 v69NNS5TfJO26eEjwFU2gRmNRyCGnQIdJ/tjfIejUxhqbsOlv8gyP/N2SDgF3LalFVsLC
	 NTlqoDuFlcuwczOge+x3stIW+HmMQmLB2j2irRbjXAhggQlEml0euSp6GMCIJt/mCMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157683;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=anwn7a6qDcaeKHWenZvq0aw1XKqnidgd6hR3gDwHk1A=;
	b=wmWmEXmF+HmWFHkQ5/AZJvHV5PM85KW5No2vURSlQwxCReZlDZbIDdaCKG/nbpigq5wV
	 1Ucu0HZOFYl67y939/F5w8sccASeXHSKd5uvTYWdT6ltDZhs7tmXSE0qK/BAZlvI4xq7k
	 LWyALDAIXRSBziVXkTsJQ4vDArGPVblQKgZO+PYVLyVuZAbY2XFZuM2P+NONgQY2ALnXb
	 kEjJSH50zufjfkuWYpU5OFYSkv2afdEV4w5D019PO4+WSxIgUmkl9MT3Yqy5gMGjWfffT
	 eY0F6kWASyWqYzETnwqPVKlg2wpJqN0nlMNAApaz7EuZgv2YhzCtmSEVGtau3pYZnsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d34J71e3;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AZCivrhz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28F606A32A;
	Fri, 20 Nov 2026 06:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE28F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d34J71e3;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AZCivrhz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795157683; x=1826693683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LHU6Dzqgq4RlHqMG6u9qTmcUEQHUK26H1G52BrlsJVw=;
  b=d34J71e3tOFaS4Z8756wVqaRYUXokG8+uZZ8Pef2ft7vyLt1AYoWySzI
   77jInfoNKclIf89jPWWBVMr4bZlfS0z05HCCsxenPTn68Y6W9gpzmKEIj
   f0SpMTOY3WrMT6tKempSJ0jx+6H3wQsrh6dZB1eqbOKJBh7oEn+zFn8pp
   DFVlleiO+3rMSl0UnEyzMOslf8Q81wSEQcWq/t71aHtLKopbN1hjcRC8b
   L7h36TpfioxPRptRi0Zj4e8TchHDmvp/O/O3TN4CGNRhPu6FUvj97/ujR
   BZDU09Cqlu1RiXvZMsBQ4diluDYIEtB8sm1lD/eeRnT6dQWhPD0+rsBsT
   A==;
X-CSE-ConnectionGUID: paPRJ0XgSGGs64ntoYxQgg==
X-CSE-MsgGUID: AY87oVzJRWivb5zmHLp+EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3917863"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3917863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:54:42 -0800
X-CSE-ConnectionGUID: 2hg2IPMAQ1iOUBCR7Z6DTg==
X-CSE-MsgGUID: oEvk9v0PQDeR0Gia2KClcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10859997"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 22:54:40 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:54:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 22:54:38 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:54:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQV5LyaMD5mXWSo4siVJ7uzzUJnEqHe/Zabfb0d7vR95d8bEQBaTrDoF+tdUw208zM6wgVz9S9sZdyPxWR/x+gWy0z/Y0Dy8o9EUi9SmhdMdx8L3WgNTARlcubkvN+mNjrtBhSpBUD4xnJNijZ99mI6/D7zvt95RoFtDvQ6a6bLfK6tDpySocuwxgnWUqom/89A85HCG9KXUrtoMdIBXEzUpIlVG+fmm9CHyHVvb5wEbOVlIrVNvhLlyojh0Shvf5x4yT+hL6yH9HD7JYlWIYIyCTqqRixQCuZrVO+FxY8weuY1KUrhMUnUtGZXKRhkGluzaNGMsQzYAACmuXk1FyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anwn7a6qDcaeKHWenZvq0aw1XKqnidgd6hR3gDwHk1A=;
 b=BMdJhu3aaGUiuFfN0slMYmCWoMNnBCFlwkkcGPv7qth2D+7NCj/i9OfeaSDiQnpP7qV+bylKfcIOamX6X1KdbaquTvyxBReoee/p6lJeyFwYrTOcu8ntbPIXj+AMP4mR65gngYMoAsTfHt+OY0MdDoJ/7ItjpwvvtIu+s6G9BRBCoKVSiISj5nwIl6hbNXdDnn98kOLV43xhu4m2cy+DeeJJbvpm8IC3NM6tmQHf6nE4ikaKqA0g++m3KmdS9lm1q+2Z86dmqx4clTsDA8phyyU2S2fEhD1ZDd5xkR/7N9ASjEE9daA/8RQdun+jKlFG9Nj1dx0fJa+Ms/XoFMhWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anwn7a6qDcaeKHWenZvq0aw1XKqnidgd6hR3gDwHk1A=;
 b=AZCivrhzkxtwAcFRgP1u0E/+8Kn2GsU6vdf9gZr9Evhymx5bin1/XvvJ4SuDkihozp1VnKI/94hw8RgffWXSJWCVQW4/vilY2PvkZQZ/W9mVjMiXQ52V6ae88jWOvYsBKtBUsP2zGN308BW6dvOYUrisBRO3io7FJmusY9a3Nzs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB8380.namprd11.prod.outlook.com (2603:10b6:208:485::21)
 by DM4PR11MB5263.namprd11.prod.outlook.com (2603:10b6:5:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:54:36 +0000
Received: from IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d]) by IA0PR11MB8380.namprd11.prod.outlook.com
 ([fe80::ea8e:eec4:f8d3:f95d%5]) with mapi id 15.21.0615.009; Fri, 20 Nov 2026
 06:54:36 +0000
Date: Fri, 20 Nov 2026 14:54:25 +0800
From: Chao Gao <chao.gao@intel.com>
To: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/mce/intel: Skip storm tracking on CPUs without CMCI
Message-ID: <av_uoSlMShJiJsff@intel.com>
References: <20261119-x86-mce-storm-no-cmci-v1-1-bc593e90abaf@ahmedabdelfattah.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-x86-mce-storm-no-cmci-v1-1-bc593e90abaf@ahmedabdelfattah.dev>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To IA0PR11MB8380.namprd11.prod.outlook.com
 (2603:10b6:208:485::21)
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
X-MS-TrafficTypeDiagnostic: IA0PR11MB8380:EE_|DM4PR11MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6751c8-5b4b-48e1-3726-08df46d323ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WlG6SvwWXIzdkxCQZ33j1ZWJ7HQzMPo08HKeZLpzXao4i24XP/aASUxewF1UhosKDshMCifRlQsAfXpNgcLzd+PQBZYBnoE93gqFWqxCmTFA3TLcewb7hyxdIgvWhzZUloxdc0Dy7Kc3c9tPk+cWUft67/4/Tyf4eQi+vX1pfK+CFRYIRjwfBo1mwX93bjRPkdy7WVhHb8ds44LWQmgnZpUxdEbKCIK41YhBZyRbl/+OF7cFtd/ZCy6X8+KP/1ESO6ZkQuRFzdWa/WY/C7YUu2f5xH9EPg7NHB9fDpO/OCO/VzIOeAf7cdVe93qkKt0VbvQZnR50GpBjQmRvHA8svxhtCg5LDP1lQMNwdqpUjsU2qltm4gf0ga5Qez79ra8oTwzReE/fVMppMry5xRnhLBQEC3VmgD+dLenP7zV1KKtRzDC9k8QaNxbCpWCX0zF+b46mDzDbjbfzYFuJ22sf8paevQJ36+MBBX7JNo/hc2/CBesKzet3WkUPX/KHKYfOLBYrb07MWm5Zqc054O0O9ByQTnmtoMX+nTQFriS7TYrqRFRUmaBtgiu57+MDZvz9Gl/tefHZ7WHr+MdiOBUKF9p5+yp/+sr11HShlu34PCdYzqKiGOrGm5e2yeHOgOV4Y9mEDuZJGC5EiTD0y+vutkwyTktvJ+f40sU9CqhHMCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grEcgjLyjwQMunksJqaCAS7uL67Fwv9IEFi3Qu9fDhoZhJDDto9aLIhT5drQ?=
 =?us-ascii?Q?1yEyCzhN1yFyMrTCmkCuh6XvWYSuuijQNKt2fqPqc/J+5M+xl3pUtL6C4I/Y?=
 =?us-ascii?Q?sPiCqGcsBIM+aVOCLya4cpQ8keSv9oeDj7nlsXfeJbU7NYYosbp091f35WLy?=
 =?us-ascii?Q?TBQhqdZco641Qzk2yYQehCZDJjW0AwLMFirrvwDesnLxp62sGsiF7LuCW5jh?=
 =?us-ascii?Q?hBc6RiQidgDqihgYrYya/lIJfqnFL0J0Qv/yERbk2lSPdzsS8JTA0IiRCNzn?=
 =?us-ascii?Q?5uNKezONgViRBuJwifzkOZnzDEBQB0qNXicdeu8tMNTKTPWIQBxcaUgB0D/C?=
 =?us-ascii?Q?Z3/YdQzBqGa2uqkcVRlj7cEcWLlvv2CYnOltQaE7J35c1HO7/6sOZAJjLuBy?=
 =?us-ascii?Q?To0E42XC+9dGtJjqEqPwFVaXaWvF5V9YAKdUxH9OiVYncS2vq2ZwnTfDQRKz?=
 =?us-ascii?Q?0Q+AglCvbkTbvPLscUU4lzBfz104RDWrRbUKXPJa0Nye9Ep0ou84ecORktU6?=
 =?us-ascii?Q?eZ54kEe31aS5N+8gb8IRKrq37BGz3buzh7/H2z0hwcvKB99n7RpYvJD9HGbV?=
 =?us-ascii?Q?IkyGzkiskdOSB/c51pQ0P3BSjEvIJWO2TBkYA/EUp0oHqAr99mMuJv2IBFl5?=
 =?us-ascii?Q?kvBAYBbFblX5R0uZKzO/Be+zu7YrivLOIvVQIaR6lr2/nEP05p8u//juiKlX?=
 =?us-ascii?Q?hjDow/8YedTy15A1rExMZ66IzIViE3lLnzdpfLlOeuLWPlYo4JVf5EoNGs+p?=
 =?us-ascii?Q?rSt36N1JumTHmJTBRpXZ1XEIDw9RP895Dlt/ylJYWbJ2i6KIFPZ/hzNBlXlc?=
 =?us-ascii?Q?B5sw0R3CB+LmInHoBjMAFPAVgqFOhfxJcWQ8izjKzL7Mr14+u4MX5z5qdMTG?=
 =?us-ascii?Q?/VHwMDvvkojbkr/Ox0zQI1gUeaGvZQponjfzy0zBtwSI2M8cfe1I+ElMz2tg?=
 =?us-ascii?Q?i3NOQ0c6jzysduf/2+Sv3Ype5pAC7cRN3pEtWiVapfcltDpujlsRFtOi4H3q?=
 =?us-ascii?Q?JKk98ZnXTcivzuVI0JJYaz6Oxhztm7Pkez0M8G2zcEn+QOV8j6MjnqZ4wFnI?=
 =?us-ascii?Q?RmNLOHLQUTPamdr8TQUqX/zm64rRxsJAVdLYveESSsDF+eb7r29rn4FhhVor?=
 =?us-ascii?Q?aaxmsiMmzzQEqmPScjLP20YsN5Cllt4n+ocStMRQxOHTmdnPLYqgzbYYMav9?=
 =?us-ascii?Q?akvt62I3eVPsEM9tdUwCD4AzzOCgvNcljiZPd3JV4VF1FvpbYJgtsfMVWmdQ?=
 =?us-ascii?Q?OWthGy2xTqBVIcuIc+aFPW7Dc5zTBbAEsxONClG/xxi5I0YKEX7F9gcaNLpT?=
 =?us-ascii?Q?JhGj/KoKZ1jjs9XakjArNlhTb7pnt/Php20rKzdrvWhXosNGIQuWk4nU/UG6?=
 =?us-ascii?Q?n1q1Att3Eg7nfVVdUW89SgBGo7hLwshk5hYZ8wVuXg/HsAj8nH7cYgLtFi4v?=
 =?us-ascii?Q?GtRFQL2jCr2FPWV0mtiRHhIbYt3p2dVeb32TIRdidD6fhXD77Z0DZVOpyj34?=
 =?us-ascii?Q?A2IGwcmu2S2fhb20GZjxOTWgyy6cTL7Tk3oeS8O4WOKB6SaODBW3CVuIF1Ad?=
 =?us-ascii?Q?IvtuBwF8ZvbmjY4W89AMNAk94ABPtFyAWRWBTh8ukcULyV8ZEdwiml/hOUO/?=
 =?us-ascii?Q?vXEHThqB8oY9Hu3QOmT2htdnYagU1A/DsLR1rSEFSZc63jiWnz37GNAEcNqT?=
 =?us-ascii?Q?uAq2w22neVK0Nm/GfTKTvRa5lPQU2R+dowRCma+O6+evhtnVPfXMAAOqlWbn?=
 =?us-ascii?Q?mN2PB+tQPA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ev0ArHxK8JgGfvNLI0rwsCTGpBHbYhz20wnDt8cYuFrCHY+C3NGk/JAmNKklrOGMly7qgx+CiHwO6FgNtutsp3N+GQkgfcA98nhmcURiH8G5HzQXGdYd2NwehgRY6DqM0E7KS1V3Uju221rIFifIcVL4OvyT+fHOf3TWsHAsaTJXYOSZd6jHbnL8QmpI72BH4vlNMmzJqyjGkKrIB93pYZlUg4soI5TAog4FiFp70Ai+sEWuhj0HYB6Qf6SVIEe4TLbepnrQu7mR5VXwbuRw3bWuPNbxjw/OPRUWspuUzKU5vRjbb2fnVQanperKE0ru8gKtk8ZPeCxQe0rgYvt0aA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6751c8-5b4b-48e1-3726-08df46d323ba
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:54:36.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJaPkay41/+JEaNcHUIVXdwK2srUhjTZ31Xh5oM1IMH3vgYpWzO5gyk7wtFLTzAROiGh8Mv2ckxPMgG3+tSKsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5263
X-OriginatorOrg: intel.com

On Thu, Nov 19, 2026 at 08:34:29PM +0200, Ahmed Abdelfattah wrote:
>On an Intel CPU without CMCI (MCG_CAP[10] clear) the MCE timer polls
>every bank, and machine_check_poll() hands each of them to
>mce_track_storm(). That skips a bank only when its poll_only flag is
>set, and only cmci_claim_bank() sets the flag, which never runs when
>cmci_supported() is false.
>
>So a bank that has a corrected error on five polls in a row is taken
>for a CMCI storm, and then:
>
> - mce_intel_handle_storm() reads and writes IA32_MCi_CTL2, which does
>   not exist without CMCI, and both accesses fault ("unchecked MSR
>   access error: RDMSR from 0x289" and "WRMSR to 0x289").
>
> - When the storm subsides, cmci_storm_end() clears the bank's bit in
>   mce_poll_banks. On a CPU with CMCI this hands the bank back to the
>   interrupt. Without CMCI nothing sets the bit again, so the CPU never
>   polls that bank again and later errors in it are not reported.
>
>KVM guests run into this easily, as QEMU does not offer CMCI.
>
>Mark every bank poll_only when CMCI is not supported. Clear the flag
>in cmci_claim_bank() when CMCI does get enabled on a bank, so that it
>stays right if CMCI is switched on through sysfs after booting with
>mce=no_cmci.
>
>Fixes: 1f68ce2a0272 ("x86/mce: Handle Intel threshold interrupt storms")
>Cc: stable@vger.kernel.org
>Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
>---
>This showed up in a KVM guest on QEMU, whose vCPUs don't set
>MCG_CAP.CMCI_P: five corrected errors in one bank on successive polls
>are enough to start a "CMCI storm".
>
>Tested on v7.4-rc3+ (4405c18c95d2) in that guest, with check_interval
>set to 1 s and corrected errors injected into bank 9 through QEMU's
>monitor. Without the patch the fifth error logs "CPU0 BANK9 CMCI storm

My understanding is that QEMU gets host memory errors only through
SIGBUS, and the host kernel does not send SIGBUS for corrected errors.
So QEMU never forwards corrected errors to a guest, and a guest sees
them only when someone injects them by hand.

Can you reproduce this on bare metal, or in a guest without manual injection?
If not, this does not look like a practical issue to me.
