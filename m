Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273449;
	b=in5xlS5bRskDQbzmyuyRRXVqQad4eHN2umsrWCW6rA/7WdLccnBpbo8Kvo2WQMUEUoCv
	 Saq2IuiXIAbHDXOY+zse5HL9mf1jKL5niwANnzT3D1Luqa4NsmWXoI1n8677TCcOW0Nxe
	 ix0rWHy4Lk65Pumom5Fox3O0G1W4n536n4Vdo+ya6yYdeRzDGgUomyZ1KK6T0zO+VKepY
	 +reL0LbH6GoRsKvTWmkM1SX83ojNxME7ZbtUkhhSweshG6n5Zztk/btJIa0rYLnEH0FuN
	 E34Faq4Pq7D6q+VTMrw3MHHUd9bmHcOoe9+QV3JFrNY7iAl40gdHiYE+b48Nttp/jZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273449;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Organization:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=Yj6/uZqtQV9hz+xyp+nQKvMUS3WkKgWpTy4mg3XL1cQ=;
	b=MVvVTP5gFCqmXlIO1Kt+9hcWy8yJW0j6fiEMB++M3aUyGnc/e3uMjFQZtQru8RY2we+5
	 BuzCOpfnOe9NsLQ7FhvxEqd4+5rEBRwxo1Xgg5j6RhvmUwm5jJkv6JzvPOfXwEsV60r52
	 q8wSJfZFaTdMCrU03tlDTv94/7h3LepaAO2SDm/uBOQ93JE9/DEyE6zrXi+AjYWFETmNZ
	 QNhJXs/5a/enumi3zYofGWaHyK9ZizUE3UqpjAKKA+11KrNYnAAiTtRdt3F2ey5eXj8e1
	 exvBmI5JprVKiQQNf99bFuVV+KeaSms7iQwACOR18utCGpPhnHJoUGw3ZPDpOZti+JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Of//ZRko";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE5606A320
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0AE5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Of//ZRko
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793273448; x=1824809448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=FP2fdbOhEt7B9/i1WpBp52WJ3YXgqhlBEmIv3WUs/PY=;
  b=Of//ZRkoRLw1NQ4yMP6qV7DKzQMFrGclK7bWuXtX9lcYFBQSmCcBHHO5
   nYBrBAAZ0xKg36vbkPakIXo97R7vFCQyRnlzqXUIykEfaajsgvFWl5RoF
   Rz9HrbHF/pOCrUrTjnYix+vnedEhsSelaXmsDpySBA1sDPUB0M4laI/0e
   ll+KxjY3slpDKUVvrULPSVHZn7IIsoz2LtCjR1gF+YPj2t05MQYto0q3H
   j0GNw25Ug4XFsNfyFNoZjWFPVRTYaK8fbCIWA833yqnxVWn92DbfwtwLX
   LlQDyBknSIUIaiI1cfgopFfwIZncRKrOJZjGttBtAGQU5wqHEWfUzGBoo
   w==;
X-CSE-ConnectionGUID: XV+LS6OISRCiZ1nE3l5o6A==
X-CSE-MsgGUID: XJvwoGrETNKo186dD3PBhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2047298"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2047298"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:45 -0700
X-CSE-ConnectionGUID: 4LsPDTQmSCe5N+qaXJ/8Ng==
X-CSE-MsgGUID: Ddbewy6ATxOe0mGSdnp+/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5026898"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:30:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 04:30:45 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 04:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK9nPKv9TGKmnaeX/Kuju0t/Ngy3y4uytj74dx17cCYZJWxfS1d+e8RLb4rkcxbVFYoGVTtobYdXhmo45yl+jb6pI0ZwtbUr8SmaYljTXYcLDNsoRbQco32QresQvHnvHiiMhSHhFs9lh4QIlaAqxJcMyDTpzcYr/wJQsOELtGsPCdzHlwsU0SJTa7tiuY9Bsoe5TohLaQ42GeqbnPYBjf7VlkkgcA7HbjWlrGn9VtAaKqeh/2N7bv+w732ecsPMWKqs0kisf1Yq4y3M39BY++U2FTQcBxQc7/1gl9fLSLsK55keBobI7TqbRdVfg2o/CB5Ae1WV/jTKvwtS3aKz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj6/uZqtQV9hz+xyp+nQKvMUS3WkKgWpTy4mg3XL1cQ=;
 b=ncsGHCXNLqTr0QFBW3DNgNU+lnZpJ/fUeH4Q7jTx8GgsljdqOxsbi6zOW5yeLIeH7M7VJDrnALqoxnfOI3xgl8Lng7Apz5WDscsUZ31IZrtlWKs/YBVerTKZC2XfKOv0rprvLFSxdWQz6IK3HcdhbyzVNlLEKMVE/FvhI88GEQU5+olQry+/IN6EX5DyHon06Cpb6S+DQozjVYElZZLGm77ay3i+m419Spq+HPJQ5dDPSL+xoMZ7DrE+IZCwokt0bhHeyoY/J25f18jy9Ix4h3N05Z6Mdx6ko6wFZm2RH04VG7Hw9AIm9HhTqCdDKSG/XZFueoeW607Ur4DKo7NI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA3PR11MB9273.namprd11.prod.outlook.com (2603:10b6:208:573::17)
 by DSWPR11MB9823.namprd11.prod.outlook.com (2603:10b6:8:4e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:30:28 +0000
Received: from IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa]) by IA3PR11MB9273.namprd11.prod.outlook.com
 ([fe80::31a4:58c:e3b5:43fa%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 11:30:28 +0000
From: Imre Deak <imre.deak@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH 3/6] drm/i915/pps: Reset PPS state after TypeC port init on resume
Date: Thu, 29 Oct 2026 13:30:14 +0200
Message-ID: <20261029113017.618286-4-imre.deak@intel.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20261029113017.618286-1-imre.deak@intel.com>
References: <20261029113017.618286-1-imre.deak@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC22.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::119) To IA3PR11MB9273.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA3PR11MB9273:EE_|DSWPR11MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 931c3ad5-a711-4853-db73-08df35b00852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|56012099006|11063799006|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bEMqYwvSYrkEfBoNGzXlpx7WWdEl3BfAMsxqa5ug/YH48CGGmUqXxNN5+oBOHCoV3q0WbuUiJS6bPUw7Ui9BTABLzhxpPzIPHjLKLgLy5A1fYgiXX+2mv5I+AstUWiF7vR1HbT6FNX1BrBPgsgmf7YnISRuvBek7e+pXUfGzKJhaVUYNIuSsBNFgXe2CrSxRfL4aIN3ZJYOiSl4jTUeXenjAs3KJ7Nxadc/yYhNhw99JPdwgdeQ4g8Nv0msad2Fu6/TL+DO4Q9wz/u1fjJdQvjDL+sU9fr6C1ZaO1IkHaYx3biZqYWHbj3F2s/+snNFp28aR5ZFEnNjy6Y+2zTBih/SK7OCj2PzedzxOGNmMdtZ/btFBeIynI18SpCQmkgpmeVG+XYW8SLJOkh1Xo9N7cJqJMqDQPdiw1rWibPlHWNGyUHs4qg9t7O/JKFd7wH5lKh+DFGU01+xPFUkLriRVPtMHwTGOI9p1G/FamOdyTsRvUe7NX+SustHZdyBRhUb8SwkxjvdY95mriLrdM/ZN+fvaTe3m/lgtc6G/LEIVUROo+kreLx0reP+dLKzwRj34dOix2vqiIEGDO+LiDrisOJ0no+jzMirbHgR34c6ng8PdBWagWy5tDv3kvvgJlv7rD4fHM9lqMMOYmYvfc6hiRxD77Jr7EPOEGRrULao8coo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9273.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PrXebIW6+/uFLsDlTdxrv3LQZNMSJLh5tUFYuci+padqFrDwsKx+Ff0CThgg?=
 =?us-ascii?Q?jpRofbi+t3L0Mh6Tw4lb33HKa0jNTDw3sLReb+WYYsv3U9yorp6IqJ8Odq21?=
 =?us-ascii?Q?kjLdRNCBDSHzGoRXX8Bw+Xw6bzwl6MkcuqNFbfcYrYW7DvLxatpzNSRiB0RR?=
 =?us-ascii?Q?eTEHclXGK5pxo19tUhUevjRrEmNitBRVMMxjkAFQv7G6SUiI0V888+lbg4/e?=
 =?us-ascii?Q?lDJmVFrp2fPrTiJ4KAn7iFJ2yGDiOLxqNR/jdk2FCmvk/lOi3EFit5fImHMj?=
 =?us-ascii?Q?v5QmwiVRBXJAJyto/J0o5IIXY6TwTp+aokHvu1VwxuaZqb2++6jdouKwEY5c?=
 =?us-ascii?Q?itx2ZIn0PN2FWM9LGfZxLfQjXcg7Vz8LSa21KcLucU4b65yrQtEuFuBfuGFn?=
 =?us-ascii?Q?YP/60bqUfG4HVFdMe85p7JI5vw18/oUIDSxnGM+kIR71JLEm5jjl+CAmh831?=
 =?us-ascii?Q?UyIKao1sqEzYMxTrKYPKSiM5VgWVUuEsJTHWkyinNtQO3Z4qoJuHWXnF6uIp?=
 =?us-ascii?Q?1T+GHPuYAbRfF2WuTxCUANDj9xXdvn6LU7mAAfUwf4Uk1PNV2FHNwEsFCgta?=
 =?us-ascii?Q?7BJz9ZBHozIh8omoTgoEz5CAETR+s58QHBjv6AtQ+SOwVMUeJA0nxZsRC94u?=
 =?us-ascii?Q?vbg4A55rabZHkBmatKuqYEpIG2QXQwDOXA/fOFRNQe3AyLcUeeuoTHTls6z1?=
 =?us-ascii?Q?XzmQBBhg5QlrPPGL2jCgmz7njQ2MG55asD1Pl4YGgC911iUvERCUdNwWzLda?=
 =?us-ascii?Q?3OQ7tLKZ4fG79iQPSd5yMxM578aoIKaHyj0uj0xSMXXS1fjmWllRb/4Q9RQJ?=
 =?us-ascii?Q?V46g3fYZ/W8tErvMvwji2x0LWO1uqXk38y1tC1/nn38Jvz8zhdLFzv7yWPeN?=
 =?us-ascii?Q?HLCch6B9d6oiwCmaDplXEcxr5KZHum0Wok4rRBUppXBv1gF6Vw+NPZ5a8qDw?=
 =?us-ascii?Q?gS54YD5s4HDRTXKdXFGuMnBuMYar8p087cmb4lUf/1DWv2alcm6XxVUWye0I?=
 =?us-ascii?Q?2Sk8eXj+qwPHDcfMS3LHvHWUk8LhOpnpaqUKVt0Om780pWtMBwKEEixGmcKg?=
 =?us-ascii?Q?USHBePSX1/4GrNzz/w5dR+CrT83MCLP/vx38qC+afOGZcHQad6G2xaB7r2Eg?=
 =?us-ascii?Q?bJeJNyvVltzBVNUnIoBn+IaLpgKYByheO4ra6bx1311pl0qQNOFQAcz+WKbi?=
 =?us-ascii?Q?BGRoZFZCHRh7x6ArhBe0F9CGRieAtt/qWLNOH8z50JCl10G/pqw4i/ROrs6C?=
 =?us-ascii?Q?aq8Vgronoz+sQCRstIbwFqiMnsTP0mui/vNS7KkM9hhnRzl+2R4gTeGxlkcO?=
 =?us-ascii?Q?7dTBV6d4XMazi0lxRsayeoxqsY1NZ3K+wp18eDMmbMmxOUqMiXzv+pZrnAsJ?=
 =?us-ascii?Q?yWSLJP3WrUc3JqbjNPMmqhBlc6ig+zVGjBrC649OK5GPDVe+X7TYCd4BhW4l?=
 =?us-ascii?Q?fYJN4ANdg+g2B91zd1G8gp/DT4yMz/LPTTtWdkjyShq1m7Omk4FrsvWEvDOO?=
 =?us-ascii?Q?aZu+jvuTcKCWRYPWpd348HZ3ZWJBBmN5NoEH8WwmejrJQn2boAqdVh96soy7?=
 =?us-ascii?Q?SiFwDlb9qdOK3/sg/4NEa9szAZuORBRK+eFw/a0H5gFnE19d2ydy1JApcKhP?=
 =?us-ascii?Q?38FpU8T52CE1X7KzaZPR+F73dPzK4HDDoIbtjmc2ofHMuxEQ6ZP8xbTvSK6q?=
 =?us-ascii?Q?dNhZ3d8RG8eraY1KZVNsb1BCDtKaR3/GuML9DstxA3Z0lZBHeqnGc1Vm/7+h?=
 =?us-ascii?Q?cV38kvTSYQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: GeC2j0THkl89fhW5QVqHeWwZ560rTqxA4F3fJ0zNPd0mT8Ogswz5JAWaT72JQ2HBdio2pvu1aC+TopPc0Np/o4hfJZpVXn+6CXG0ROrAN96LoFeluaI937nKATzqqzU6gVKFCSp4N4nU2pB8sCDivcGa6pltNwpGIHv7o0lkz1svNIBcQpTB3aFzZvRVwswR3JJHRqEO+lT/yvtq4KWpbA1zkmGZy3JJ6riPbqEFQhEAXmFHsJnYPWLJ4YwYj18X5BpzPVtCjcKgSpYJFviJTLRzdvEw+00p3Zqzenq8vIJLzCuMEXvZH63b19Txhm/5vA8oIThEQw3FnHUmHtb4LQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 931c3ad5-a711-4853-db73-08df35b00852
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9273.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:30:28.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTkprEt6u7HZijBb5NkuleALduuLNa2m4kO29itqcHxkVpj1NTxN6sh9Ub9ClPIud3G02Rdlmk94P376uAD4+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9823
X-OriginatorOrg: intel.com

Resetting the PPS state involves acquiring an AUX power domain
reference. On TypeC ports, the AUX power domain depends on the TypeC
mode of the port using the PPS.

An upcoming change will set the port/PHY type to TypeC for eDP ports on
PTL+ platforms with an eDP DDI mapped to a TypeC PHY. Prepare for this by
resetting the PPS state on resume only after initializing the port's
TypeC mode.

CC: stable@vger.kernel.org # 6.14+
Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index a46ab5d3d70fc..dda95709c7c73 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4723,10 +4723,10 @@ static void intel_ddi_encoder_reset(struct drm_encoder *encoder)
 	intel_dp->reset_link_params = true;
 	intel_dp_invalidate_source_oui(intel_dp);
 
-	intel_pps_encoder_reset(intel_dp);
-
 	if (intel_encoder_is_tc(&dig_port->base))
 		intel_tc_port_init_mode(dig_port);
+
+	intel_pps_encoder_reset(intel_dp);
 }
 
 static int intel_ddi_encoder_late_register(struct drm_encoder *_encoder)
-- 
2.49.1

