Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453F4E3799
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858870; cv=fail; b=JqoFaK5+WawHEk/jkMythbLbR2NHnlzpS0SFsFNTR3dJC4KN+/LobQgA8i9DlMsLhJNY8ScS4F0kvi6V0xPHNr3cNaIC7/C1vWh06IUiBui7eXHLdKrGpC52XW9SLC8NYa9XfHEf9J67dpLMy6no4UTk1GvUuqzxXO2tIdC0KDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858870; c=relaxed/simple;
	bh=nlufL0ee2ra408xEL1w64KNgPg8K12WgFznKNK/VJn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/3fhoLAKmdRoxOJ5B9DU1k1pia+qxzkzuA4LtGn5mE8E+se6NJiyvLbr0Lnc3LV7hOSSXYtlihfZr6etZgm/KuLkInQ+SmEzb0egmQNSsL07+d2o+sbJ9NkbHt7sWHTHIbtnMnbcH/yFbVoSPEWYZkHDkuW452/FaPDmBO+IRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ihgBs0py; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ihgBs0py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788858868; x=1820394868;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=nlufL0ee2ra408xEL1w64KNgPg8K12WgFznKNK/VJn0=;
  b=ihgBs0pybO3SSLRC/PjKYs0I37qq6yDO2tgYwynnwxilcRehyskq0vrB
   ARD727bQS4Muo0zyMUnom0tdbgZS5pwBMtzR5XO1+8n/40ltflk1eYvrQ
   hRcR/j82mYIDQEKgzzLIxY8itynkD6B6BOpbc6H3kXHQaf0pq1pEhH6Cm
   sLFUFk3DQ2fAfXC9x5GnaRsivK4MPRB+JUem0zCawPbC3PclwXmmr93Qs
   +3yJlNbLuqAlh7LDbM5nlvcj9Tl60W4Fq9yTD9FdsdrPlOBKYttSCe3Qp
   GVHG9ODTnLKeAtMtPgotvG5Z6GQARp1dXmQS6eD1YofcnE5TEa0p2hjSN
   g==;
X-CSE-ConnectionGUID: SWLV3T++QGGIOrACr5SD/Q==
X-CSE-MsgGUID: tigJIYGOTwK9UtiwOSJGKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89286041"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89286041"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:13:52 -0700
X-CSE-ConnectionGUID: +5cqDdcJQSuRlC4jmRidtA==
X-CSE-MsgGUID: BMFgOkUuQ/2XbVGwrV3Ung==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="269614278"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:13:51 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:13:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 02:13:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 02:13:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqdloia+NuAthtFnMDxOwLCrHeMWLGX5vDrNjebvpnZXiHViyLTnKCwQS7IV+9Rq8dbaf2QYdwV4z7ZQCixymLeu1rmfk26UPwLKFZ2Bc+Ru9ITOYrOh+pVjBdvk4GykL4PknswB6lOgrJlJJajnHzDE0G+PmKt7zsQcM/Y7d5ZNr3kww3q1V1VzM9HGD6WTfJjlCHjbrpEEwKHL1hi0Qu3zKQC1IeF0hQFobjqdANlN0Ph3Yh/EBcUSWlwbFqP1XXqs4c+l0Vz9sVUHeGzww4AKv/IWnqDTbooFGdNuWySepkPJCblmG0ElLa88Y8bNtCY4Q4CHN7RNYCuMZqHbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kMvd3ax+/yhmhtBxKIRjw3CT2e4isZuhbpP5WfBEsI=;
 b=JYzw6MbqNmbqEHug5Dm70iJVdWlPuF7n0XKyNXdk5eGWki8mj1/19lKsUjWRpN32MRNAx+/x2Sg77YVvcsDygvzqvAQbiWzhi4IHCgbGQms6nIi1kkIqzfClMxt13E06m/Q0lDpXmqlM16NmTb+g6fb9Gk5vvBUzjnRXTNNuVsLbstQRcYiHPjzcG7KFTBAHKrCMkgNdmHFnCjka8Jv5oxIENJdjSm0VWwRz5WBvkS1plPI8HX70ebErZ6Vh+IqYgSy14kqp8MyWFnDyctij9trQPe6xDyGBPltu6OBFYHICdYX1YPNDgFy2DFLxTS2GJmLaC9du8dhUjr5eQP32GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF57F27BA08.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::82b) by CY8PR11MB7134.namprd11.prod.outlook.com
 (2603:10b6:930:62::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 09:13:48 +0000
Received: from SJ5PPF57F27BA08.namprd11.prod.outlook.com
 ([fe80::68e:cafc:75a:3e02]) by SJ5PPF57F27BA08.namprd11.prod.outlook.com
 ([fe80::68e:cafc:75a:3e02%8]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 09:13:47 +0000
Date: Tue, 8 Sep 2026 12:13:33 +0300
From: Imre Deak <imre.deak@intel.com>
To: "Murthy, Arun R" <arun.r.murthy@intel.com>
CC: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a
 disconnected stream
Message-ID: <ap_Q6_BX4Rv0DntW@ideak-desk.lan>
Reply-To: <imre.deak@intel.com>
References: <20260907174413.741851-1-imre.deak@intel.com>
 <CH3PR11MB7300904CF56A4A0DDA801FB4BAB12@CH3PR11MB7300.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR11MB7300904CF56A4A0DDA801FB4BAB12@CH3PR11MB7300.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To DS4PPF69AE895C5.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2b)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF57F27BA08:EE_|CY8PR11MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 6071a587-b317-4e4b-3641-08df0d897c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e9hEKmBcgGh/gNKo0tBIz9pJRZxKimsIcKtq5nzC0UdLScMn9ccKHqRxp0sX+fLN1jEGkDX3+bnTwHp9mFU2hIE1jrT7vzibsTPmnBv+A93tqxNPchcCwkh5bVyRGl6E6jra1ffCVZCGGJGJdTCtHyyDnmY+idoiJiowbhqK1lrA8fkj0uQvEnt5ih+OBk+JEHDnYSy58OUIeu5DeYwwBKSKdh+OYdBl7Prp0jBeWRn2212UaNbgepj8SCnK2T7UP2F9vte1HpaUGbL+Xw+va6T9MzGHrVM3RAnmDmmn5YaDy5rR6FdykAR1ooHwt4O71L+QZ9pp4gdXkDbqd0qqDCzqgXOxVoRvpwgpxdhqxZlDjguBQGKzM73pF5Id6io0E6PEdORbsHyFnP6tVozBhb0usUc4tXSDyeW+eosoJeauQzKa+u+G3hmv7LVgDrLHtrLVzlUvfAxdWwayfWCg/tCPmwUAkLxemDO366YjEgbNx6tyF+nNCAbRr8zgxo4bDvTwBRUEUwzy9cvNAcx1cVQYOvMrEo4kKdtgE761vzkcKVyZR2YJZWRYoEgOjv88he5BMDqApUvRLejpMCFO5IWuyRZPc2mAgFk0lD/5yiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF57F27BA08.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7x+NbO4IxNXo4zYSlKMGG3TKwXWeXpuAC8abw9itIz7nAV4sS4F982OvswT2?=
 =?us-ascii?Q?COGFpoJlpDOkxpRkpQc0AbW0W5TAW6jF9YgDzN/crlupxJB5/iRD6jhIduv7?=
 =?us-ascii?Q?YPt0FIrBP07vdTJru0kiF92EmCpwunBYtOMw7ss1hRmJu8WN3WlxtKJsJdv+?=
 =?us-ascii?Q?KoX+QteUZAOIX+5TnoY1dVExxZHiWA+LU6LnCvjWnMbJCCGknMUO33Nri3LZ?=
 =?us-ascii?Q?vbHp2qx0CZeF0C0EQp1YwpDbjHz/vcu6kJ70cRH6DXDg5FqTwZiqRcGQ0DwZ?=
 =?us-ascii?Q?y195/2B0hGZWTGofEy/fPjv1XABBSIfXaJlypKkQ+xmLNRfp8ugjj0/3Cj7W?=
 =?us-ascii?Q?OZ+T3MDmztZnLDMCE7WzX6Un8jgR5v9fiT5bQaLpCWjXtHm4v3pFWNnv4c7t?=
 =?us-ascii?Q?Tqmsc7aDpZtsHoyIBr5WSfu61TqCSCGP/+vzud/Un0f0zd3G5ccCYNt7CGN9?=
 =?us-ascii?Q?waE58QuNhzrSQ9IWSgsBv6NeRuDS5Rx9uQ54v8W3GzsSXbnEdPqHBduhFndV?=
 =?us-ascii?Q?DSfnz00vnC6KmTW8eSdPDp6G2niKNHsuygN7ej85vT1fyU2aqBpJsjHpCK36?=
 =?us-ascii?Q?rzHCbuc3UHIieTbSxl39A8mbqsAvxNTx0pY4An6rU7c6TE9ErUw2cs4eRYHA?=
 =?us-ascii?Q?CTAI3CfDlNWS2X5WXtk4GfrAhWVAb+o4Twdkj4jaItpGbjKHOeYCkKIKBz6u?=
 =?us-ascii?Q?tpOxV0m/e7c6BYC3eKvxPa6QOwb9XYMFhz3hELHgX1MZAhjNpOj2ZEabZlXT?=
 =?us-ascii?Q?fTwfzQtzid4y0gHQzjPUXV6lbCyhzw+qWwA/BAIHxRkZ0fDGGSa9r1dKOehM?=
 =?us-ascii?Q?YOzxJV/SYLkHY5d13iMHdqlvNIGi2SEa21IZB2lsn1EXcHAzhawvRXkImn2u?=
 =?us-ascii?Q?1Gs4OpB/oCana2+lNc2NLymBvfULt/imD0ymui+Hiqm6ec0mpMlqTGoeOk6N?=
 =?us-ascii?Q?OuFb8ecMQ+ZOmtA3np5ujU55eKjUIBFXMmZzEeyR1yFnTjU0qlgWW+eR6PQO?=
 =?us-ascii?Q?tazSqemkq5799kimYZ2VW/+Z/BGu+HybV+Asg4951o8oXzN3StEvuW8Xv/Rs?=
 =?us-ascii?Q?xVnJ0dKZ+kT+JcrvVT8Bozhh44DLD4sXkFv0nITx5ZXtm9ESIBpAU5n7JhQJ?=
 =?us-ascii?Q?FeN+IW030mtGKC8H83YCoR9XR/yzjY6QxOA3rmGilPuJ5+QXruXhmv1k8y3L?=
 =?us-ascii?Q?ff8J08L1zcordwEVMJfHx+SDDs6MobflhzuWUwBvhD4s0WrCPbf+F5oQPFP9?=
 =?us-ascii?Q?7ovMlkRfu3ljwuNE7S631GAl2ftpuDWibUwsOiFWywZgIzN7AfuceOwJGljr?=
 =?us-ascii?Q?+a23HxHN5gpa1yKMTvrtgkbAXOy+30uwp7mQcPUPzZM63Go1zFRu1bRuOCUF?=
 =?us-ascii?Q?VSyJYXF1GmAEAkb5lQraJ36HQ/gtsx06swEbsYq9/d6FXIsRGmIBupb0AnUx?=
 =?us-ascii?Q?xu/Iv3VmDxjirzt7aPNCJQIaPpSlyWY9aUp8rvAHKoaFKkieB5Nq/r/NNsDm?=
 =?us-ascii?Q?IZXEum8l/Cgxegrt7TyCNDQnz9GpIrHN3/Unj2vhKPgh0LXuTpy44goj8YoW?=
 =?us-ascii?Q?ghP9yQpOhggus3zU70f3RdkfraWfv8OOzRlPKxPxg5jtAoTv+AWTWojk6c7T?=
 =?us-ascii?Q?jL9cDPLcLypIzYapOHsne/odiMELYViUX3yLJZexfYbj/tkAIULX1KzrZWYc?=
 =?us-ascii?Q?TORIrVy/nsYUJf6NwQEoZyRg3tQpVbHE10YDSjHVdpT71hGu+E9Dl+aTjmQH?=
 =?us-ascii?Q?GOpS7xrZ8w=3D=3D?=
X-Exchange-RoutingPolicyChecked: i7CJLl0ejQ3pqNWpqlmg4aMQRN7foThCWDvij8anGir2kmh6McqcKgxDZo9PzZz931mlFxkDnMdcNvO1gF8+cA8RxY2CfrszqCFjStkYsHNbzWXTL4kunbkq2hwuN/xV7eGfGoZ2wxNszjQr3a8FdxDnaiW1ysyXg5WvrEH6JfLF7yFDE+ecEbyp1bWBy4cuOJmyOI86x/CwB3qpOCdbigTI8nOQGYIc75N53F2XMbcnafgwjgVUfIUk4O5Fc2+/rcUmm++9kvkVV10P4fLONYHm01qrwZ+ChqP150/I3Slcy0NfScZ08w+Pk+y0GZzUQgHU8kQiacxCLJJKvq0qqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6071a587-b317-4e4b-3641-08df0d897c54
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF69AE895C5.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:13:47.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOFV+dAoIXXijaflQ7HeA+GQ7M7W+EgaiOYVQ3/KBEQyPLfDcg6/vK8EXMqyxdlGZtRdzX2g1F0OSh/OzWXpCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7134
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 06:25:04AM +0300, Murthy, Arun R wrote:
> 
> > -----Original Message-----
> > From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Imre
> > Deak
> > Sent: Monday, September 7, 2026 11:14 PM
> > To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> > Cc: stable@vger.kernel.org
> > Subject: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a disconnected
> > stream
> > 
> > During an atomic commit after all the MST stream CRTC state is computed the
> > driver ensures that the FEC is configured the same way (enabled or
> > disabled) for all the streams on a given MST topology's link.
> > drm_dp_mst_port_downstream_of_parent() used to determine if a stream is
> > downstream of an MST port will return false if the whole topology is
> > disconnected, since in that case it can't verify that the port/ parent_port passed
> > to it is in the given MST topology. This is a problem during the above FEC
> > configuration check, since
> > intel_dp_mst_check_dsc_change()->get_pipes_downstream_of_mst_ports()
> > will not return all the stream CRTCs/pipes for the topology as expected.
> > Since passing parent_port==NULL to get_pipes_downstream_of_mst_port()
> > is meant to return all the streams for the given topology (i.e. mst_mgr) skip
> > checking if an MST port is downstream of a parent port in this case.
> > 
> I already have a fix for this posted long back.
> https://patchwork.freedesktop.org/series/168570/

I explained the problem of that patchset in:
https://lore.kernel.org/all/ah60jJkzbbw25R-L@ideak-desk.lan

> Thanks and Regards,
> Arun R Murthy
> --------------------
> > This fixes a problem where the FEC configuration check explained above failed
> > to ensure that all streams' FEC is configured the same way if the topology was
> > disconnected, leading to a FEC state mismatch error.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
> > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > index 6a869d0f6ffc0..20766b6c0bcfa 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > @@ -856,7 +856,8 @@ static u8 get_pipes_downstream_of_mst_port(struct
> > intel_atomic_state *state,
> >  		if (&connector->mst.dp->mst.mgr != mst_mgr)
> >  			continue;
> > 
> > -		if (connector->mst.port != parent_port &&
> > +		if (parent_port &&
> > +		    connector->mst.port != parent_port &&
> >  		    !drm_dp_mst_port_downstream_of_parent(mst_mgr,
> >  							  connector->mst.port,
> >  							  parent_port))
> > --
> > 2.49.1
> 
