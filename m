Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD25175A7C;
	Fri, 24 Jul 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923353; cv=fail; b=HC9Zd0k1ZUakMG3RjwTlzQp8SzKZR1nRxFMJoPHuAwNaZ5Lir0mUK3EzifEQVBCGn0yqqnq6uTt8X4+aZbMXl7ZFFj0Yu4JYZ76JTESebTEIspuIQguLeb+X34y5ePH6Qh/7L73bFk6Q8C4F4sE4K1X71T4cYDqcnteukugfBNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923353; c=relaxed/simple;
	bh=UDwE4V1wsPtnXX8K53tLaXIudOKFi11bpvB2cWTU4HE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RDPrKuYHoBMR02koeT/PL68K7S5F06cfo258ntTWHjvkUC21xhX16jWksqOj9N5E9Qj/E2XqAVz7YwGWqKQ2lctuOPTFOLTgmnHsdp1JUY3B0A202Qag36CB9zEjWYj0cQ312rWMIJM2iVpIKQ4L2g2jsXyMhFw56+IvB52/JnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IiYyTGgm; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IiYyTGgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784923352; x=1816459352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UDwE4V1wsPtnXX8K53tLaXIudOKFi11bpvB2cWTU4HE=;
  b=IiYyTGgmQB8fVQ2IusX/pcZElF2t8HBNgHBamoSItFdZq6LDTTjFaghP
   H97LLfil33UckLv0mV3oNk9EjxHKIFv5sL1nn2HM//5wmzZ+MNqfBGCPM
   aE0tTv7UDpahyXKLo53NjOyHsWKktjmJpjDHN/HcJ9iwmKX7NciIyZu5g
   67iU6kgCOwY3WRizgjZIjTAZ80ehz0nsaU/RKyieeTXvNFhWH2gvx0xS6
   b1E9/ngV+W8WwUFbSsxQbvhPZNm8VqeP+UejVUH4CT83oAClDDKrxCxMC
   3ac3EdRTxdii4f+tN9Rc/fGWTCCi5Q2nvM73i9+Djjlz44DCMNcMVDEPR
   A==;
X-CSE-ConnectionGUID: yi85YixqS2Cl/HJ7gsyodg==
X-CSE-MsgGUID: 8wWoGsO8T96jHZxQcpGhVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85682673"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85682673"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:02:31 -0700
X-CSE-ConnectionGUID: H9ilQvQBRTCZlRfH1dSndQ==
X-CSE-MsgGUID: MT9NFmySRAaued/WCqNWTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262310795"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:02:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 13:02:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 13:02:30 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 13:02:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQ0AF5BPFu3SNYW+X3mk+CsyJP6A2kf1y0vTE3O+GQ3c7k/nNMeVbjFjZNIfwEfSx9IoyXPwulATg0xCLjK7I5cyKturuLTRHsuzto7ORz+qGyKCT+39BmQjwFA0e3QvpUst7o2FvVL6eVlEtI9BGreBM2NcRCvUP2yOi+PJNaOfX4ExUna1kY8BhTv/8/Apiopcykx0U7dwE5PveFyxO9OQ+GR/wISpEVkp6O+FhQw7YyuTmdvHIl7VZ6AN+eQkfX+XYW5QNyDHavcQ7nz5IL2smiG41OhLmayjTbkHmhvTP1BOvn16sxJkF/GnTMcWMKvj9vx22LrGXRXx32DkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe/CJzA40erXOSCf+zdBtxdmNzf4D1+URhLyJF53FF4=;
 b=qhCxaBk8RrhO+eGfaatSr91qlLep3VDmHlMk7kNrmrBjR4GmJH9ywdXb1XkebtTjGd2LZ3lOXogWmcQTjc49XI7hnL+craFsgfPwUPLiWSRA/BTMKuJlT5EvLl0AFFmuGwO3xO27aICgaQHvtxTXeJWCD1O1S+NsUgXGmzaKvSNavOxB0dUnGO0bhtCQb+OtUhgzru4LXLnCxxTmH7ZdEiZqWdTt28ORUqwoDzu0y6uECYZBcCqHCxoHPaBJYmh3WEqcsUQYHpzSEQB6qiqC51+CxHDw2XW3ZG0gkvGeaR7MTIG5DKaOpqPAa+JwDnZ/mH/rgrVALOZ+r4+0MJfgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6438.namprd11.prod.outlook.com (2603:10b6:930:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 20:02:27 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 20:02:27 +0000
Date: Fri, 24 Jul 2026 13:02:19 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/pmem: Format the nvdimm serial number as
 unsigned decimal
Message-ID: <amPEy5Pom580nG7z@aschofie-mobl2.lan>
References: <cover.1782948930.git.alison.schofield@intel.com>
 <e124234e95069cb6512b9e1ab8a1335bf4fbed5e.1782948930.git.alison.schofield@intel.com>
 <akdUTK5ILvXbMW-n@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akdUTK5ILvXbMW-n@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a1f325-3843-436b-e327-08dee9be7c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|3023799007|56012099006|5023799004|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: qTr/J/ZJqI9Cp6CxOdBCMkOy6g9dNAHMwZEfm4WJaS4s1e5N/xTArfNeAdXQCCKsWyyFIyEMQbx1nYSNrIvy7lQZpJdVhERR/eOi1l5+m3wkmsqsowFcgel2ZOblagfRTcdv3ywkhkGXstBfLIG1QGKGbVp9K3egmAewLLNy/FtsY1MYz55MuRavCD9xJA9rgDT+gvIfMqRmdNdFFGRZe3ySYUAgy4V69mFyzv7kwHn424dLYItnT2cJTWXKG59GTD3upRyRa17V11gaZ4Iel7f39A6JZlyJnqMF4spm45odWESNwBs9n2iqN7OINcwJ/54DHwKXL/h5bZ+nu+fJfQmOELpPhiGlbbGPj297wRPp+jfH8K7z1Z6GRjkmdj9uvmIHHqGf1IxKF6iiSXwlqO8KAhQqH2risLajGOc4tCsrF0yTAeuVCvN+y70fjfLfJUkXFf2ZeyEsNe13Q+pbO+OB7iPwuvEsAXzCeKQciXyRF0ARee7J+38cXrvYRbUQ4zvmEhSyPPDZv5RRCxuFfwEutepiTHDIWnQB+LIkFdCxlZGZTsUTr3PUqgtwOQ6zO0mmbM+ChtP+7Z0JDHVZSSYcjkWVyxXNXfE6RgVGO42uF92w6ztx0xXqmCXIu6ITmrYP0oYGus2HIJod1jBFevbo/gIc+Rq1xoo8rug3OdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqPf/rp4q/WBZEHH3r1uxGEF3PzrEnRWlMtK9UD4qwEUZBpiyiknTSu/bi6l?=
 =?us-ascii?Q?mxAKEgoegi/6LdBUCcRxh6KcNul0cTqzKTJC+mC4ftIm9qAGZFb+wShPPfwO?=
 =?us-ascii?Q?Z/Ho8wzhtJDo6S6eCgy3SwkqBOXAm080vZcZPpPYcxJNooZ1PKkEseV9y2K3?=
 =?us-ascii?Q?7vQM0K0230HAGQ9t+90/g7rpC78hK7bggHiYKjVQrwqq4B80f599Hy+ZFSVd?=
 =?us-ascii?Q?dvCS65Rc63AdnILLEC2RXqWCviBNFQZx0krJUpVsTePrkahHKZIPCm2LGKwC?=
 =?us-ascii?Q?9QN9cYFgFMAMy/dugltY+bYVa+TtE9MiGMaFhvSf4clUtR+E2GT41yehx+z4?=
 =?us-ascii?Q?bGiVmLSpKqUWdoBPN0pnCzZ/C5ubnO5joMkGl9lWDBhMOYmkWd7GtS8g2GhE?=
 =?us-ascii?Q?3SRrXw4aiH7zqU7LVCerPLC5Nsfpm/EgYlq4vZhWBZu+AAyJQGPJv3cG+VYR?=
 =?us-ascii?Q?8SDOaVxBH/a6eOlnH7/2cU9zd4lf7TCstFzi3z/QtUtw80pk0hcG0J9T09RS?=
 =?us-ascii?Q?JOAxfYlWTMkEAoYkkURhNp0gLqc5oPM+JkgUdhrrf51F3spP7v0oiDFBmhCO?=
 =?us-ascii?Q?f/EiP/p4hjcR28QsGZq8h+XDfOafwYXUkEMWDTyyZKa/mdKtamqCP23w1kR5?=
 =?us-ascii?Q?frzDd4TTzGTdzmwTWLXsqKql8fPy7Khc/7kk4MkWsjvmo18/fUqKDTwOQBni?=
 =?us-ascii?Q?WziM8zo2e+TOGbpP3KqElUEK+F3EPawHVMhXESkhMqbK1mKpbigr9wUBnNMZ?=
 =?us-ascii?Q?V1fawBJoKYaX/pIVnkqy5nEjwd+CBvySwTnlAEqWS9d2tRjdwwBCLlHWRJ9t?=
 =?us-ascii?Q?gJfSqMrn30OVe+hfhS8Ss4zmFxIWPg58cVA1vZAEs9tUs9Nw06Bcje4+1Aes?=
 =?us-ascii?Q?eEdeefvTxbybyMuLrbkmd6X31grXbzgMOp4e/KeZB5awrLagX/BoQ7nOuaco?=
 =?us-ascii?Q?A/BEPVKOWpLwPk2qPzunnOylgqxbpKIuMSj4zsh1Aajgl8VfIU2pxOM87kE7?=
 =?us-ascii?Q?YnpCsXvFr5VgFt44V1ttwzF0AS98egjUWay6svHzcB9zLc1fhNZlU1ObUxWf?=
 =?us-ascii?Q?8N8Pe2DJpEZNMvxaR/7dlydZ0VDGvsymTmg43EIJ0f3e+q2R7Rz29Kq/evD7?=
 =?us-ascii?Q?Ng//g3mJJL9pKAUdX34oMWQWJGGZYWSdjMSNCmxdLf9ojWbXzHk2Ks+Ts6fX?=
 =?us-ascii?Q?P0vCFyoTG6RsGj+6TMCMDQ8M/jMe31mOFSW0gv+vmEbN0EAQAXhAY/JKeMhH?=
 =?us-ascii?Q?sqQ2FXUvcFVVIu1eBWi2z4gH5yw17bABp1qj6Cw7db41xQI1GfEDG+kUW3UR?=
 =?us-ascii?Q?tK/SDcyYfRZyfYJlBILoi12ZVAYidM3SaCIY5liI0m+YkaJESGdEJqNJiWU/?=
 =?us-ascii?Q?xNFvQ+LeKh8yT+9gcyfII4qpwtA0UHeVe94X9z2GPfQliTTrV/V5tFrQGIGk?=
 =?us-ascii?Q?vfJM3K4G7B+nwHwfrVQX5aU8rCWpnrFMDc+gHsRoKd2cGlWBc5YUTVnIPfJt?=
 =?us-ascii?Q?dlx0aukHsAeGjjnf38j11W/7EsN1BEDfdx3JVFdm8kczXmfGzaSK9rRPpFwu?=
 =?us-ascii?Q?wmxlp26K9TEY7OnyPok6a4E8QCszimWxsxDMlXUPKoxoMvoRSKLlNyeEy2At?=
 =?us-ascii?Q?gqHAgyKH5j4a5RolWAzvM/dfUkuEpwcn10CKQg8H+cDSpdoq6yE9xMneyfBL?=
 =?us-ascii?Q?d+A7qi012s4dUSXQ5kKJfbVf5sCtBAuKgKt2IOHYT1MBR6kOArbfC1N0WHaC?=
 =?us-ascii?Q?YKgeIG6Qf3fds3Vu3LUtATlLHrjkA1E=3D?=
X-Exchange-RoutingPolicyChecked: b4ll1T+VmkmUFSklz7rJL6AZaxULepho8Av7RYAk/aUu71xWAImVXdvvdaTnfIBXtzFvvKCXqknUtHFC0Fi0HXMPNZ+M3HMIo7Jf9gIGshW2x1va28pvz9Jb3z++qTSaM6SHc7Q2gkLWzZGxEFeRwSQ3ViBzd7hYI028o7m/GxT/q3OMvDh3pLEbyCd8UKw4O+fzboSLZoIoi7HA6ilHIzy4bFlibq+uxzU9L+9bhHomdBvY0tZRkmJIvcqYCRaIS9xWLPWDuA64nNrAVGcJXThVRimMXyXmaxTreOYcGIEt2Nz0On69ZyVL/qSKsqbjLIJy9stxm82ZUF4UCmeY3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a1f325-3843-436b-e327-08dee9be7c17
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 20:02:27.0416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moSKoIi8oxiqe2hkyK8JwlFpb2Ab0JvDdZGeLoEbUIWn0nsRbyGFiW3+XzLEZyzh8clYKLIj1yVum0O4y9DF4rv+ll8jFnTepgPfF1vbJ+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6438
X-OriginatorOrg: intel.com

On Fri, Jul 03, 2026 at 02:28:25PM +0800, Richard Cheng wrote:
> On Wed, Jul 01, 2026 at 05:30:44PM +0800, Alison Schofield wrote:
> > The CXL NVDIMM security passphrase key description and the nvdimm 'id'
> > sysfs attribute are both derived from the CXL device serial number,
> > but the serial number is not formatted consistently.
> > 
> > The key description is formatted in hexadecimal while the 'id'
> > attribute is formatted in decimal. As a result, ndctl stores the key
> > using a decimal description while the kernel later looks it up using
> > a hexadecimal description. For serial numbers of 10 and above, the
> > descriptions no longer match, preventing automatic unlock after
> > reboot.
> > 
> > The decimal formatting has a second problem. Both the key description
> > and the 'id' attribute use the signed %lld format for a u64 PCIe
> > Device Serial Number. Devices whose vendor OUI sets bit 63, such as
> > Montage CXL devices, appear with negative decimal serial numbers.
> > 
> > Format the security key description and 'id' attribute as unsigned
> > decimal, %llu, and document that the 'id' attribute is an unsigned
> > decimal value.
> > 
> > The key lookup mismatch was exposed by CXL unit test cxl-security.sh
> > when cxl_test mock serial numbers were extended to 10 and above.
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-nvdimm |  3 ++-
> >  drivers/cxl/core/pmem.c                    | 10 ++++++----
> >  drivers/cxl/cxl.h                          |  3 ++-
> >  drivers/cxl/pmem.c                         |  2 +-
> >  4 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> > index 64eb8f4c6a41..46dafd8482b9 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> > +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> > @@ -48,7 +48,8 @@ What:		/sys/bus/nd/devices/nmemX/cxl/id
> >  Date:		November 2022
> >  KernelVersion:	6.2
> >  Contact:	Dave Jiang <dave.jiang@intel.com>
> > -Description:	(RO) Show the id (serial) of the device. This is CXL specific.
> > +Description:	(RO) Show the id (serial) of the device, formatted as an
> > +		unsigned 64-bit decimal value. This is CXL specific.
> >  
> >  What:		/sys/bus/nd/devices/nmemX/cxl/provider
> >  Date:		November 2022
> > diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> > index 68462e38a977..5a3bb7e8a1f1 100644
> > --- a/drivers/cxl/core/pmem.c
> > +++ b/drivers/cxl/core/pmem.c
> > @@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
> >  	dev->bus = &cxl_bus_type;
> >  	dev->type = &cxl_nvdimm_type;
> >  	/*
> > -	 * A "%llx" string is 17-bytes vs dimm_id that is max
> > -	 * NVDIMM_KEY_DESC_LEN
> > +	 * dev_id is the nvdimm dimm_id used for security key lookup.
> > +	 * It must match id_show(), which emits the CXL serial as an
> > +	 * unsigned decimal. A u64 decimal string is at most 20 digits
> > +	 * plus NUL.
> >  	 */
> > -	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
> > +	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
> >  		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
> > -	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
> > +	sprintf(cxl_nvd->dev_id, "%llu", cxlmd->cxlds->serial);
> > 
> 
> Hi Alison,
> 
> How should existing keys for high-bit serial numbers be migrated?
> 
> This patch changes both the sysfs  ID and kernel key description to unsigned
> decimal. ndctl persists the old sysfs string in the key-blob filename and reloads it unchanged.
> 
> I wonder how's the old key being migrated ? I don't think the patch rename files under /etc/ndctl/keys , so ndctl may reload the existing secret
> while the new kernel searches for the positive new label.

Thanks for the review. I want to add this case to the documented work-
around. I think that the exposure of this issue is very low because
of the lack of CXL pmem out in the wild. Let me know if you had other
thoughts on that belief, becuase that is what drivers me towards
documenting only, and not supply a command or script within the
ndctl tooling to do the migration.

So, only one class of key actually needs action on upgrade: a serial with
bit 63 set, which was saved under a negative-decimal description and
is now requested as unsigned decimal. Serials >= 10 without bit 63 set
never auto-unlocked on the old kernel (the original bug) and are already
named by the positive decimal the fixed kernel requests, so they need no
action.

The one-time re-stage for the bit-63 case is documented  in the work-
around now. Appending that here for reference.


CXL nvdimm auto-unlock: serial-number key-description mismatch
==============================================================

A passphrase-protected CXL nvdimm may fail to auto-unlock after a reboot,
staying "locked" so that the pmem namespaces it backs do not come up. The
cause is a serial-number formatting mismatch between the kernel and ndctl:
the kernel looked the security key up by a hex-formatted serial, while
ndctl saved and named the key blob by the decimal serial. The two spellings
differ for any serial of 10 or greater, so the key the kernel requests is
never found. A second formatting problem affects serials with bit 63 set
(for example Montage devices): the decimal serial was formatted as signed,
so it rendered as a negative value.

This is fixed in Linux 7.3 and later, which format the serial as unsigned
decimal consistently in both the key description and the 'id' attribute.
See commit <TBD-COMMIT> ("cxl/pmem: Format the nvdimm serial number as
unsigned decimal").

This document covers two situations:

- Recovering a dimm on a kernel that still lacks the fix.
- Migrating an already-enrolled key after upgrading to the fixed kernel.


Manual recovery (kernel that lacks the fix)
-------------------------------------------

If a passphrase-protected CXL nvdimm does not auto-unlock after a reboot
-- it stays "locked" and the pmem namespaces it backs do not come up --
use the following to recover on a kernel that lacks the serial fix.

1. Confirm the device is actually locked, and that auto-unlock is what
   failed (not, say, a missing key blob or a hardware/security state
   issue):

     ndctl list -i -d nmemX | jq -r '.[].dimms[0].security'

   This should report "locked". If it reports "disabled" the device has
   no passphrase enrolled and this is a different problem; if it reports
   "unlocked" there is nothing to recover.

2. Confirm the failure is the serial-number format mismatch. The kernel
   looks the key up by a hex-formatted serial, while ndctl saved and
   named it by the decimal serial. They differ for any serial of 10 or
   greater. Compare the two spellings of this device's serial:

     # decimal serial, as ndctl named the key:
     cat /sys/bus/nd/devices/nmemX/cxl/id

     # hex serial, as the kernel looks it up:
     cat /sys/bus/cxl/devices/memY/serial

   If the decimal 'id' is 10 or greater (the hex and decimal forms are
   not the same string), you are hitting this issue. Confirm the key
   blob ndctl saved exists, named by the decimal serial:

     id=$(cat /sys/bus/nd/devices/nmemX/cxl/id)
     ls /etc/ndctl/keys/nvdimm_${id}_$(hostname).blob

   If that blob is missing, the key was never saved and this recovery
   does not apply -- re-enroll the passphrase instead.

3. Stage the same key blob under the hex-formatted serial so that
   load-keys also installs the key the kernel asks for:

     id=$(cat /sys/bus/nd/devices/nmemX/cxl/id)
     hexid=$(printf '%x' "$id")
     host=$(hostname)
     cp /etc/ndctl/keys/nvdimm_${id}_${host}.blob \
        /etc/ndctl/keys/nvdimm_${hexid}_${host}.blob

4. Reload the keys and bring the device up. load-keys derives the key
   description from the blob file name, so the copy is installed as the
   nvdimm:<hex> key the kernel requests:

     ndctl load-keys
     ndctl enable-dimm nmemX

   The device should now report "unlocked":

     ndctl list -i -d nmemX | jq -r '.[].dimms[0].security'

Verified against cxl_test on an unpatched kernel: the dimm unlocks.


Migration after upgrading to the fixed kernel
---------------------------------------------

The recovery above is for a kernel that lacks the fix. After upgrading
to the fixed kernel, one class of already-enrolled key must be migrated.

The fix formats the serial as unsigned decimal (%llu) for both the key
description and the 'id' attribute. The only keys affected on upgrade are
those for a serial with bit 63 set (for example a Montage device): before
the fix id_show() emitted the serial as signed decimal, so ndctl named
the key blob by a negative string, while the fixed kernel now requests
the key by the unsigned decimal. The existing blob is not found and the
dimm fails to auto-unlock.

Serials without bit 63 set need no action. ndctl already named the blob
by the positive decimal the fixed kernel now requests, so they
auto-unlock after the upgrade with no migration.

To migrate a bit-63 serial, stage the existing blob under the unsigned
decimal name the fixed kernel requests. The old blob is already on disk
named by the negative decimal the previous kernel emitted, so locate it
rather than recompute it:

     # unsigned decimal serial, as the fixed kernel now looks it up:
     id=$(cat /sys/bus/nd/devices/nmemX/cxl/id)
     host=$(hostname)

     # the existing blob, named by the old negative decimal:
     ls /etc/ndctl/keys/nvdimm_-*_${host}.blob

     cp /etc/ndctl/keys/nvdimm_<negative-id>_${host}.blob \
        /etc/ndctl/keys/nvdimm_${id}_${host}.blob

Reload the keys and bring the device up. load-keys derives the key
description from the blob file name, so the copy is installed as the
nvdimm:<unsigned-decimal> key the fixed kernel requests:

     ndctl load-keys
     ndctl enable-dimm nmemX

   The device should now report "unlocked":

     ndctl list -i -d nmemX | jq -r '.[].dimms[0].security'



> 
> --Richard
>  
> >  	return cxl_nvd;
> >  }
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index c0e5308e4d1b..d683ae5e0f7d 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -503,7 +503,8 @@ struct cxl_nvdimm_bridge {
> >  	struct nvdimm_bus_descriptor nd_desc;
> >  };
> >  
> > -#define CXL_DEV_ID_LEN 19
> > +/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
> > +#define CXL_DEV_ID_LEN 21
> >  
> >  enum {
> >  	CXL_NVD_F_INVALIDATED = 0,
> > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > index 261dff7ced9f..a9f50281875d 100644
> > --- a/drivers/cxl/pmem.c
> > +++ b/drivers/cxl/pmem.c
> > @@ -52,7 +52,7 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
> >  	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
> >  	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
> >  
> > -	return sysfs_emit(buf, "%lld\n", cxlds->serial);
> > +	return sysfs_emit(buf, "%llu\n", cxlds->serial);
> >  }
> >  static DEVICE_ATTR_RO(id);
> >  
> > -- 
> > 2.37.3
> > 
> > 
> 
