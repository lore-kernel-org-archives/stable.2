Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795715348;
	b=ErBUqKzwJos99WEorExLm6wYu5T9d8xJ7+g6v3GnRRt5Ebfr8VR6eS6O/qak0fGNDkdz
	 PUm3DZIXD/JvY2iiLU+m0ck+dqF2NazitelFpq6vOiklF+IVBDVsSRjLgreKYKTr4iOHn
	 6u/7LS1rE/MkDeIyc7WWNug+TSXcvYXi4MH72tZgxrYOkL5r/nGn/7PYECMZ8PPzk5RiI
	 WnjutCzZKRyXPWT6uYz54f5EBSIB+FlBOhei6v6kKkUEEK/dneTaFDw+OCHhhyEaaAfZF
	 zckYT0+bkcSTrnTOfPsdB5hHyOxbpE8n+6em8J8GENlJzbVVeM5XVV+YtFTLS5OqCHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715348;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:Reply-To:References:Content-Type:Content-Disposition:
	 In-Reply-To:Organization:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=9r2RjU4+2ttXHfUbA5R3rS9p5JIUze5EpOZ8S7A4l7A=;
	b=IWfeJxasn68hW2oUnZIi01sIIroYnwaOhe2Y/rYtIu9O//LQU3BXMIhxmn0s+eDcrCfu
	 7o5kXv7YJHxZzeCsknw0l5y0XsSnbjPUn639mT6ELsIO6/ZRE5uXOWsBKK87nROAQayHj
	 2BPe2vFNjt474NtGyi4kpuAHW/n/tTklCxCAo8Ky2reC2dTgUgGgqq85gPRmEti93hWt5
	 kh4QcVwye5nm7fjGy5JYZsJAvVpnSaDFCm1Nc2uGe2F4VV1rXRTsYYGSQtSJdq/sVVYbL
	 EYGDeBAW1NRzvR2PwfT7Zds/EydE5/2XPwxXZR0pyAEzuhKXVrs6qmRdUM5FVR0iF3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ceLYJL27;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k8EkSnBo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E2606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 136E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ceLYJL27;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=k8EkSnBo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795715348; x=1827251348;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=YWO9jQwjaXM+WLTCnmQ9jJsRV8QMIWpjzTs86QDDgLk=;
  b=ceLYJL27rlU5JQTwln6efOXLcJdwSG8W7/8YZjKOzR3dBXTl3Nfigvo8
   YAB1piUsEqbx6ZdsneDyVQvoYMh6spPROvUPFPDGykNq21+VucU2AVfj4
   Rc73gmlugsDMPF4zwpde6k73+ng263nlYwnhBy5dU6SAe/A2z1KxGsWET
   KYP2/LGdgU5YPL3V3CD6dT8fCxZoWi7nxhxQ2DmqOJI8ls9ULAox5lmhr
   QY6If5kgq8PXDtossiKyNSdSU49UVikGWtd1JA/IPSXA0sC9GyP/kcDuu
   y/R1Up/W/VN5JSy5lvjM8GinVQlSqZOkk0uC8Yxod7OUdOdJhaJ3lP9Ak
   A==;
X-CSE-ConnectionGUID: OLPetVJSSeep4iuJDJocIg==
X-CSE-MsgGUID: ELV4KT3jTPG5UeEg9d5NpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4648554"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4648554"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 09:49:07 -0800
X-CSE-ConnectionGUID: Dw4hzKzZSoOfnHz3ZOAf0Q==
X-CSE-MsgGUID: fEVuS/EMRKmZpcCMRcGbqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12225877"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 09:49:07 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 09:49:06 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 09:49:06 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 09:49:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDGWWRYGWkjOPyH1+k6IwVuO7pTLNxZLhhhUDycu/DrWr4CZA463gu1NWDNDG5WgPNzg3JcwjnsP5A0qg7s18eLuZdzBhFm0IAmtPaZqpVQAc4g2vC72w1NLovXxJQpHxtw79IOkVHeXovtwNBxHJkhEdpjc2SBpQOpw/Qq4kXOGNLWEZZkExOWn9KXUXWYrYq08kp9eRjW8HCffljJFTvIRZEdkgH3ko/RkGf+KexrMZYS/JNnd9cua/B95qDIsNleMzErZTFAgsurImZ9uiir8H5VbFpv0GJQOr7bCrg9tNIeWEkuvbU0hbftW+GjX2ah7491NlVGOhZwLjkDqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r2RjU4+2ttXHfUbA5R3rS9p5JIUze5EpOZ8S7A4l7A=;
 b=NQAR1CE6Geo8A6dae8XnjlryOuve9cbWIPSqpzR0Hkata9mlCRIXTaeN0GF7RVqI7XZ6+e+fZnqp6sB3STF+n5LRT+Sm2xHGUijN6qHlky1iA14v9GYRartPwMEk04W+rCSlH5elZItPNXXTTTv3luFRhqkobSsxb2AZe2dBoN2rrJUW1Azux6QNWzdJCOoLUdvDbBF+dMZ9uIyG6YwYaWcPCDVfqx8roDOreYxU+2jBvodQaDiDEVtTSUPVDaeR8kD7NVB0qV5fX3ssiXY3Hqkby930WwvGuWL6yNQ5nNHtcRMVsWasxJW5jujtpMnnwvJfS9R2OFR3L/1z4suNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9r2RjU4+2ttXHfUbA5R3rS9p5JIUze5EpOZ8S7A4l7A=;
 b=k8EkSnBoAxCF6E6WPI5FbPzuGtmKkZfbRD6Qhw3IxWhhw3ZS3EKAC/066jVml5/yNFlgqg90XFz6p8zstscdzWz3kCRxOU+Pe8ZGdIQMz6ykwh/74N1KxyhQVJC+/5OmNjPD2E9MbAYXvwtkHu0W3y57aOJqVAC2NiS6MxG96Bk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 17:49:04 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 17:49:04 +0000
Date: Thu, 26 Nov 2026 19:48:57 +0200
From: Imre Deak <imre.deak@intel.com>
To: Frederik Schwan <freswa@archlinux.org>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>, "Jani
 Nikula" <jani.nikula@intel.com>, <dri-devel@lists.freedesktop.org>, "Dave
 Airlie" <airlied@redhat.com>, Frederik Schwan <freswa@archlinux.org>,
	<stable@vger.kernel.org>
Subject: Re: [CI] drm/i915/dp: Fix source PHY updates for UHBR links with
 LTTPRs
Message-ID: <awhxCe7xsZ12eA75@ideak-desk.lan>
Reply-To: <imre.deak@intel.com>
References: <avtDzWO1sOXYvxZ2@mail.tty42.de>
 <20261123120954.1115838-1-imre.deak@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123120954.1115838-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-ClientProxiedBy: GVX0EPF0005F691.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::13a) To IA3PR11MB9273.namprd11.prod.outlook.com
 (2603:10b6:208:573::17)
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
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b3f2ba-620c-4e06-cf6b-08df4be58f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|6133799003|261009223027099003|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006|261028144727099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: t8SCJUP6KL381P9fuJDto9ItOMJEgvVMCs0SBW9XJbT7QoOf5ipWJho/Al8Dv2Cf0oDXIJ5Lb9HYRIUGubj/NdpNraPJ+QFy9k/wn9q3ixsaKzSfOrl7o+KNvdYVhFcx3p9ysYNe/DgFqe7bbGZf4hOZqgr9dyRHaOb3VT19OpAIMlWl0NYjKr0Q2EpSBGsy3jGA7j8LV3DCHH5faghzZGzxKCOD1pJgrhdP2zeaSpaH2CDzEh/9wyHoYY04klXPXzorskfX6CD+X1D+JwuTw8XuBseMzuO8WGRHC8kh1vjsIbbt9zvh4K+b5AdkntbR4+BTE474cxdTHpFdju+hMJFxcuTz0iHbUeuFnaCYh8ms6IiRBPSlA1mFLTFeGypp3MZRqD7kO9BX/XIzERLd+c2RRCrhjSOPE5zE2tFp/hgKmWtN42YC7FIHvFSINW5q8YVFqR5FFC+kxSTT61AbW5IxKfCQTJpiBdgzeJH3yN33srnGV2undrlvuxgz3gRK3Kawsc7lVsDT/eyyix5Xb0AAMpYCLgkwTbKlzV5x5JA7yWCbqfn12srrSGengafNLQBrn3SgHFVbd5R81hPxMObrYoUDgecorbu/pXhki40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(6133799003)(261009223027099003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006)(261028144727099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pbYf6ts5g4inw0qj7bRJZts8qJ/epXzsZDyH6kcWnAxJ5gVvVGTWZB3w9rNy?=
 =?us-ascii?Q?A7WhzlDHzfkziymmZNk3IBPDfOxAeIrrT2CeN7ZZXtp8QySyW0jVGM96a5SV?=
 =?us-ascii?Q?nMj4ncCK3YeYEELMbY7DQoT3uhy4EVKxdjXnvZTCSYLCVi/GCRCFZxYt7rpv?=
 =?us-ascii?Q?amKuEX0+M+A14BFndmO6zC9UpNwJTcZie95E/LZ2ET8kDnEAIvSsb+9DoizI?=
 =?us-ascii?Q?7Hg3VmedmbRKjmOenw49mH5hixjV0qGAqd3En3dFQyu8HDTkurI0aQRUYAUY?=
 =?us-ascii?Q?eDMPCUbfEYNIPhItawTlcHuZYKjSLDruA9whxQF0U+paxo+Naj23fbH0iITw?=
 =?us-ascii?Q?vQvmPCT/gjzTaEIJKMcJ4rIDPHSPn3rkoJ3tiiWQRxvLaOfvX+stP43bK4Xd?=
 =?us-ascii?Q?T+MAK2nBIunTSgjHVhrXGZRRrcgwddGQqea9EdmcgaijO/OZ0PSAONLTkKL1?=
 =?us-ascii?Q?lhVJ/nS4xL7JHUpNv0fGYzWnJbTLC/4bZQ43yaPeXIulZwqj9BlPfaS/pZsY?=
 =?us-ascii?Q?01JsZP0GrrgVqEB/iWTAvh98GMgqKI3Y1DGuvWsOkl/+QXCqQMXGCx+T9caW?=
 =?us-ascii?Q?fSzhaZdqATPWzUyDFiVc2bO2t3pyDOlKTDP/xX2t5SUCbjyuStts62UUqimt?=
 =?us-ascii?Q?DxLgOZ7VmBkt7eVVrEI/ZwLDV4HvbyY2TQhjydOLvh2v24Ikn1a6UxeXpZU0?=
 =?us-ascii?Q?76A49lv8sqqZAEMcxJDDV21RwN/YNyL90cQu87n1MrPJwemyUCRkF7feOKht?=
 =?us-ascii?Q?0flp0Wg1zkKbiQn/3qDhAhXfJX/oVdIiZeKsp8sGKYKEADnL94E6tWBSpu2W?=
 =?us-ascii?Q?FaoXhrQ31CKRpx0il6lFvntOAfCI7YDZ1VgXFdNy+zJbYRkGi/ioYWEOxcd3?=
 =?us-ascii?Q?lvb+0Fs/xxFXrzlylHv29JA9iiiXxs2u7YHidkkW683JCqkSctuQxbi6f39A?=
 =?us-ascii?Q?xBk6CPP8YADpq24L3XjO3dXeyw/jNTM5AyIPJ7Gv10YjZzUVX6qMw1FMpRFg?=
 =?us-ascii?Q?G3MJla8UUlanOEE+VtsZZuFnt476P7WqEjejWGcwcsaChA3eIdRXIglBuNti?=
 =?us-ascii?Q?co2/ZQSyY0OaLwGM2QvBKCXtKmp1M5cIPovuozZTQ2/yEw9dtHWvRq8iT+Nn?=
 =?us-ascii?Q?WJ/aOSbuiOf3jNretJApOlW8VrCbJgCd5TmNpSuLcWhn21WKJJF7BwhxhNTX?=
 =?us-ascii?Q?+cGJqm5py26x4dXj8fAYpBEDzL/Jtz4BTHEnxuLybHnk2oOJq4/9o9UlHeJL?=
 =?us-ascii?Q?DO6+Q8s48fPowNRzbb6FzNVSl9cZScwSvx9MWCqNx7zr+MpFmOCCZct1YOeX?=
 =?us-ascii?Q?mHu7hXztWKraoM7Hvvo0owyc+g5DAHoZLRjqiVZR+uljHYONRkneiw/7LS1J?=
 =?us-ascii?Q?8degJh4n4B5Q236gonUEIdaJ+WOKw0iSsLu2svPfGVktQIiuypgYIy1rpDaU?=
 =?us-ascii?Q?YTqhCdoRMQfvBQEW6Etvoo/fx+RvAnszDi/awetUtmDpOtTSfBoumuc3KKDD?=
 =?us-ascii?Q?bzUDPRgxgGcguqtHB1BMjF/5foy22AFinbSqkhuGkC8f7DRQYJqpJmRK6p2W?=
 =?us-ascii?Q?ZnOwu2gMFdpwrsaKC9u+4S51SWHNvrwk3O4dG4r2Ef4t2EhD5kT2lB7mTIH8?=
 =?us-ascii?Q?vOPWfE1XapITh67wYD1j1ZAXmJl/mF4wQBf3rM0qQHT90jNb3GZlPKDIu44c?=
 =?us-ascii?Q?T8Rr2oVMW7v/aVLlkNYsYP6lgu9H4WTYw7B4OR1/5E+N/0hds+ITpC0HtTEl?=
 =?us-ascii?Q?cUxbjKnj9A=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ta9RGVg/NN5Ja3Kc3HdlCmGX+OXpkkERPddly01BObTtqg8lVGsK3MYNfejO6kqXzZ6dk3RFDfUg5e0ft3t8YwW0ngzSbi5zI1hvBp3nAo0u0G95ENeLmyLra/Vd5ZWEaggIGuQGcEaWkmZwTUr+blZDz+1JW3jzDodddGcs6RPsEq3VIflOmQjLciVny96E3na1OIYezRYFrAAJpIEcatluono2QULCA7/Pa166dtQYG51SDWqutRynUdwv+4kobb9eDCgz8S0Tg6ilMEVZpfPYm97T1djMQjn9cCIwTmQXYPjv5Bw3ICVwPSD1McKfoL4gv3nOth9cDuoeuBPViw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b3f2ba-620c-4e06-cf6b-08df4be58f96
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 17:49:03.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uy4hqoQGzHrx3mUCYjZZEV9pkGKpPXQUc+bQUC5QfdwkXBSQXtMMB707mKZQG67/GFj6P882JY3+KC79IpmHvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com

Thanks for the patch, it's pushed to drm-intel-next.

On Mon, Nov 23, 2026 at 02:09:54PM +0200, Imre Deak wrote:
> From: Frederik Schwan <freswa@archlinux.org>
> 
> 128b/132b links use LTTPR-transparent training even when LTTPRs are
> present. The DPRX is trained directly in a single phase, without first
> training each LTTPR PHY separately. The source must therefore program
> its FFE parameters during this DPRX training phase.
> 
> The source signal-level update is currently guarded by
> intel_dp_phy_is_downstream_of_source(). With LTTPRs present, this only
> accepts the source-adjacent LTTPR PHY and rejects DP_PHY_DPRX. That is
> appropriate for non-transparent 8b/10b training, but skips the source
> FFE update during 128b/132b training. This affects legacy and DP-alt
> port modes; in TBT-alt mode the Thunderbolt subsystem owns and programs
> the source PHY.
> 
> Program the source signal levels for UHBR regardless of the detected
> LTTPRs. Also make the per-lane capability check used by
> intel_dp_get_lane_adjust_tx_ffe_preset() use the source PHY's capability
> for UHBR, rather than treating the DPRX as a separately trained
> receiver behind an LTTPR. Preserve the existing 8b/10b behavior.
> 
> Enabling UHBR tunneling exposed this older bug on a ThinkPad P1 Gen 8
> with a ThinkPad Thunderbolt 5 Smart Dock 7500. Updating the source FFE
> presets restores four-lane UHBR20 training and both DP displays.
> 
> Fixes: a421d8a99216 ("drm/i915/dp: rewrite DP 2.0 128b/132b link training based on errata")
> Cc: stable@vger.kernel.org # v5.18+
> Link: https://lore.kernel.org/regressions/40e2af4139b94eaeecd41fcdccb4ec1ef3dc098a@intel.com/
> Assisted-by: Codex:gpt-6
> Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> Acked-by: Imre Deak <imre.deak@intel.com>
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  .../drm/i915/display/intel_dp_link_training.c    | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> index ac1aff6edf052..1efc78b329a69 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> @@ -773,11 +773,14 @@ static u8 intel_dp_phy_preemph_max(struct intel_dp *intel_dp,
>  }
>  
>  static bool has_per_lane_signal_levels(struct intel_dp *intel_dp,
> +				       const struct intel_crtc_state *crtc_state,
>  				       enum drm_dp_phy dp_phy)
>  {
>  	struct intel_display *display = to_intel_display(intel_dp);
>  
> -	return !intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) ||
> +	/* UHBR training always adjusts the source PHY, even with LTTPRs. */
> +	return (!intel_dp_is_uhbr(crtc_state) &&
> +		!intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy)) ||
>  		DISPLAY_VER(display) >= 10 || display->platform.broxton;
>  }
>  
> @@ -790,7 +793,7 @@ static u8 intel_dp_get_lane_adjust_tx_ffe_preset(struct intel_dp *intel_dp,
>  {
>  	u8 tx_ffe = 0;
>  
> -	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
> +	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
>  		lane = min(lane, crtc_state->lane_count - 1);
>  		tx_ffe = drm_dp_get_adjust_tx_ffe_preset(link_status, lane);
>  	} else {
> @@ -813,7 +816,7 @@ static u8 intel_dp_get_lane_adjust_vswing_preemph(struct intel_dp *intel_dp,
>  	u8 voltage_max;
>  	u8 preemph_max;
>  
> -	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
> +	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
>  		lane = min(lane, crtc_state->lane_count - 1);
>  
>  		v = drm_dp_get_adjust_request_voltage(link_status, lane);
> @@ -1021,7 +1024,12 @@ void intel_dp_set_signal_levels(struct intel_dp *intel_dp,
>  		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
>  	}
>  
> -	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> +	/*
> +	 * UHBR links use transparent training, so the source PHY must be
> +	 * programmed during the DPRX training phase even with LTTPRs present.
> +	 */
> +	if (intel_dp_is_uhbr(crtc_state) ||
> +	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
>  		encoder->set_signal_levels(encoder, crtc_state);
>  }
>  
> -- 
> 2.49.1
> 
