Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0E481661
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336381; cv=fail; b=VBqr72jfhhT1V8b5h1urIPR6i+zodkxnB3c0r2Ql3sy0Sj3lsCdfxkR1TU85ZocEKFDEBY+NPsLNOemr68w8WaxY5WUnuCUJE/+hY847Hw1BD01bSTm2f3dAnzK/9cWXiNwMZA21/BcziX04D6N6DZwtVb25kEdpsJeUcdUiW8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336381; c=relaxed/simple;
	bh=TSdu8gNepro0/MiyRieKw94aZ6/hGAMaxeCXfsC+H/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nsAxPG8j7LnwHMCyY1aV2A7RxOyYxLgy1sKFRS9dFsLKWueJPrH5yB7qV7gFNrYYl8vbcGYxZc5fLdYsAPwy56SM2c9rB6BcOoeFjiNlSvCnGA7ePQNbUxP4aOv3sYtObkHVZLVRCL4rpioKz9OUbY0tfqJD95K5ugkHEXQa0yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5HddSv9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5HddSv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785336378; x=1816872378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TSdu8gNepro0/MiyRieKw94aZ6/hGAMaxeCXfsC+H/I=;
  b=M5HddSv9WrG/6rS1Qc+xwNmGfNA2qIUKYGrbe6i9X3j9/qR5u8IOgOOS
   DnDhjCN3VfuK368jYJhon7JeK+KJ8JO5WGmsljcoHF9DUWh6sFTaA7mHV
   U5bD8+5bDhUJ3/52l08tOtIZyAVZRpYTiwOzjdQPng2VE7kKUJ7BRwXAA
   vg0uAnt5hE6OfpAVrLwao58pRTl5nXX3DMhgVwm1TpY48pvsNRooknuap
   UgBZRu8lTYT8CVlTE6Uhvp0LgeksShVK/bS+7MCOvJ5jaGi/0x8bsgYEt
   PoevptsIAPkSFDVfc/Uz3PUTI0Ya/HRpdzpQVo+g4AdVb8CmHKTyAK5JO
   A==;
X-CSE-ConnectionGUID: Hd3GKXylS+aqmbwYFDkUQw==
X-CSE-MsgGUID: 05LEvdB6Q0qjRYUVunQsFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="97456707"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="97456707"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:46:17 -0700
X-CSE-ConnectionGUID: bxVDnj+7RGGuCT3xWEmk9A==
X-CSE-MsgGUID: 6R/zOnRoTp6ATXpwRPXShg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="265061047"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 07:46:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 07:46:16 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 07:46:16 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 07:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yZ6aU3lCu1enS+hLACBL+z+MUFTJZXUS5a0VXoAJptQRX7iZgVS7bQ/t93S3JOKJgwlU0o7zHfEVRg5RxdlVmqYE2s9VP/jKD+DFRiNPT0iBuiIw8Ii6ypPQNExITOMbzpiEnHu5D8thwlB4gY1p5KnOFC48bPtZgdkF0BIks98JxIlBKP+mJqUqF5z+kM2VfQHTcdagz3WgusyfqGl2JHj9ae2gs3JaKCY35jkAfiPfbSprEEpXkb6CVZRNupFui37b07pQA+xXLOgXdt1TNPAI7vM7dgjvR+G8m6lOCCqKSRvMaLjWTUFlMWSGTcr3UrrWhNy3A0nP4K39rmG4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM0T0xFw1ylMlZxyqDE+13VAZAVw872kN6md/bGocuI=;
 b=JjyUrmWeHapYPTBC2onmmFf2fv4+W1KX8/hmY9oYD3rNtST18hE8VCP0DVa42s5crhtweuw7shjXnz1AOxctLf4Nr+THBRmwTdSkP4hgEDSJNURzuNgmNC8hjq/7dmgZyhCYcqB+v2zl5ZsO+rq+uuOWxdtp0duxxqzXH40Mjedo1LW34YxbrR3tr6sY2+t8B8hULTfKI1kV7C/6oMorK6xaEaUjaVzTv/L+6MkqBMrPBbmmdL/JAxtVvtcF9cPsCGHn7IkfU07Mqz8MiFE9KwVT9XyjOF4m7EVzwP7Ycw1fU1MbCHITo7kpsvqE2Ag8DPpjgSjJTKKcrMeoQJdiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 14:46:07 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 14:46:07 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Mathew, Alwin"
	<alwin.mathew@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>, "Brost,
 Matthew" <matthew.brost@intel.com>, "Mrozek, Michal"
	<michal.mrozek@intel.com>, "Lin, Shuicheng" <shuicheng.lin@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/uapi: Reject coh_none PAT index for
 CPU_ADDR_MIRROR" failed to apply to 7.1-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/uapi: Reject coh_none PAT index
 for CPU_ADDR_MIRROR" failed to apply to 7.1-stable tree
Thread-Index: AQHdH0ZJJKtvVzFi2EWIGa+xN0LIF7aEk12g
Date: Wed, 29 Jul 2026 14:46:07 +0000
Message-ID: <PH8PR11MB80404D07718D6CF61BFD47DFF4CA2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <2026072909-boil-smartness-3be9@gregkh>
In-Reply-To: <2026072909-boil-smartness-3be9@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|CH3PR11MB8752:EE_
x-ms-office365-filtering-correlation-id: 5452b98d-727a-47d4-bcbb-08deed801f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|11063799006|3023799007|921020|18002099003|22082099003;
x-microsoft-antispam-message-info: LptDBAEkUP2CbpfnS1c51Irdk2eZJA+EvhSi9EJxo2YZJkoLvniXnq19O/NSAJiECGTMSguIcCvZz/YmxlKdRpT80+fi7i6e1PmtSA4TdhRxEWo9SpFMRljw+UYEBIPWJQLNPfDRedbzmUBJderb3hBgGsiu1ZVr7m24y54gn/Rd46R5wdnShQtM3m+c4rbyHU2YyrU32eW4/USBovIGiT45cSFxP3MtwJ29DY9YJ5Co2s50NeFQPXIbTdyH9VXwnNNRbjQznCO2HGIesu08mZ6QK0trrLNQ3a5Owb1jInAn2aE0LzKzUF2dr3paDUUyY2MCxNUoO1KRHAobsLR2jYYUSMZvHnQOZIRHs33nbBNacrpIa+RolvzrSBm/uF1JtixzkPRDLxyfQnxXrYvMxEoCEG8zMWxaqqvXUWnGK8cCCym63sgxoWxcVlxmweTu3SaOunu/mDNLOTCVmyWbp1nJo+b/VX5YCg5Oxyn90hc6+DV46zO9p82JGpZXPuK5Bi4KF6sNKYzPz/xC4EO0jzSW+z8yeJ3k6GnebnAsfOxSYDwy64KvaVUjYlI4acGhqjGv50gG6CSJs24tO8AIiljThd1uwpIC6HdezfiwkIjE1zvT2yF5YjCmabVlNrpO8AYusq9gdy//6QM8r5gVPtRpNi5/S2P5ZOmyIubaHrD7CGx/R3tInVxLBfdTv3lK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(3023799007)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3aewJ3j7PD22PiB6HrXmO6nAB/pP9i1YCJpcHXKMP2K+qa2ud46PqCf5ffh9?=
 =?us-ascii?Q?elKpCvU9fK9jEkoCnuyv2JYrq2ipSfUhFNLr1RAXr7SH2Fmiw0XzqhvKFcnc?=
 =?us-ascii?Q?X6ILJXfWwJbgktUxzLt1Zfouv7U+WEmTI0YbqwMRWhup9dh41thtg7n+N8ie?=
 =?us-ascii?Q?EPStlDBo/VJtVK+M3PRgaqZeoMcyN+loKia5jq1IfFyRES5MwzdfpW2WgzI1?=
 =?us-ascii?Q?kitLmgeVLjo+fCiVl3OmEBCnAzg1zPht830TDTOx4k50FXCQsPVqEe6208Kn?=
 =?us-ascii?Q?h1kbWzpGnfOsBWz7qW1sGc1+HD6OYlGcIkqVZya2xssUihPYZmL4NNiSf6cD?=
 =?us-ascii?Q?UcUDBY9w+4vKPycSFE9e7JQJ6k09z8oh2DLHYrhfKZ1VNQ+mLieseQ3fexAT?=
 =?us-ascii?Q?ktE1P46gOtin5a3OATQd0YwtUEORb2BcM5vPvavuDcfjvjLY92vicrpQlj1J?=
 =?us-ascii?Q?/mkl+g04See2FzkNFENjW17EMo4CO4VKjE2q0NStYbyBxLgjer8J/60j0/k4?=
 =?us-ascii?Q?WG8MZs4KDHs8Ttlt9knMH0FKG3OSzqkiE4V+BNfrLdv9seujEe00+Das+iPx?=
 =?us-ascii?Q?SWZ64uQJyg/8WOQbNbBa1HLo1VStwWbUsT3iiD4+LYWiweWImwx3AWDvtOej?=
 =?us-ascii?Q?GHPLjCG9ffApM8QAkpV3cyLG2ygA6GqoBUlBVlle0m5Qj9omqlZZriYkfCGd?=
 =?us-ascii?Q?TIIB7NLvuDx786MeE7LEmb/8v/qdKQ9XkI1s9hfLcjdIu6vKfLHjS42c+blO?=
 =?us-ascii?Q?2NBHENEWHg2iVqCXJLAn4KIqQN6TlDYGbCThJOryMSOWeaqN0qRZPvG9sgBm?=
 =?us-ascii?Q?paOBvEYO8WFsz4/gGJYAFDHZnWuZIJou8SjplTn2ndMtDnSGPNhbK4SZ9IGn?=
 =?us-ascii?Q?pLPeGS8/jxL/9i/qeUnuo5wj90gUhb2YJli5vlXrgUC4gAiQBQR5HVKeqFQH?=
 =?us-ascii?Q?CtYDSW5GQqjlhMK3e0G5Dpm5ME6mVCanKgf4zQJ9tTftJuZHMzTPVETrfMcm?=
 =?us-ascii?Q?R0gAJ7h3e6kbanQKvhjGOlgPEjmpANylKdTVSktRXQsFLJaa7drApQF7i1wu?=
 =?us-ascii?Q?wzQg2hv1iq7Mm+gAe2JZc7aKZmC0L4xmuRvY+qzAyHYbg+LoK8zt0UqpgQ7f?=
 =?us-ascii?Q?E30LWuORm+PEU2DLa1isT66boXZsRUd/SBjfdpDI4N+ACMzWe8mqajLhbXVc?=
 =?us-ascii?Q?+BtdyXMVQdu65CK3tDe0Nu1Z+SQXz4czif/6UHVwN2Au0V+i94AP9/Miw0Nm?=
 =?us-ascii?Q?3BqezzPXY+8MunNaLGUEla607WB8Jn3dW3e5uHu32N0KVFsEWDlhA1aN8W7n?=
 =?us-ascii?Q?BIJG99JsisOSrQ9AUP88jEcyLAblLB0LWxOhM01DQqxGg6hdHsfO205066ZN?=
 =?us-ascii?Q?aFzklrn4FYPpAUdjDtbhwBbisn0hSXFWcHvgCGDjrSINKSNRSYCtKAjskQZ/?=
 =?us-ascii?Q?IOQ8SIti5W/ndktCbSVs2ck26gDwy90LZqcLtL9ZU3F6MrOrUKw3c9M8P4Ua?=
 =?us-ascii?Q?yKqQ8QQALVvTiGEoPrv+YB8yNOc2u1sryLqmirCn4C7QAU/1n8kcPZnKtGLS?=
 =?us-ascii?Q?1IyQCfP0uuLUw0kCIR1CHDSyNnAD0oRNohFOyG2vrmlSQx9WdLTBNFPF1EKY?=
 =?us-ascii?Q?kveJNRWhPl1OWaWKoh1Ibxi4vN8frFda+MbHHBoWAzlWUDGa1ApTwdn36Dmf?=
 =?us-ascii?Q?z3szdcdnCLngWFTq06xjh5CCS+FLlDH6aiRRhtkZze/mM7Ns?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eAFduMt9Zr5PpXX6I6KHXB1f5OOq4RXYc4DFuEOv7YSIcS/Yc7NzLGVPn8WeQo8JrV1fRDv16mjnP85maYIbAj+z4yoThcoYch92Qfmi/AOqktoIsUKvldvR6lOu9iHxvIC+6c776H6TNo39zn+wWb34e9xDZsyxBQziEzobyfgdM5Cj7+QpXUdQzaFsz6OXdy4zYPA0F9/j6wK1IAn+xGH7LNKmrBD3D5t/UfqRVW0rptMmlPBOfQmCCx60SVXZgp68sCVpy0SS4r8MUTzISp9JvDwIdoWqe9fSUzuslO68N1HLIn7T2QVD9KBCcDHJDuz2A12Myp9f8VsYs8Svlw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5452b98d-727a-47d4-bcbb-08deed801f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 14:46:07.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EwiJcXaHkNCw33nvD+D6ac8B/jwbyItV4r+SY5Y+29dFMnQBs4G9+dR3V+AfEHkdMW08kkTNTwcBWf3TfYbHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

The fix is already present in linux-7.1.y at xe_vm.c:3694. No action needed=
.

> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Wednesday, July 29, 2026 3:37 AM
> To: Yao, Jia <jia.yao@intel.com>; Mathew, Alwin <alwin.mathew@intel.com>;
> Auld, Matthew <matthew.auld@intel.com>; Brost, Matthew
> <matthew.brost@intel.com>; Mrozek, Michal <michal.mrozek@intel.com>;
> Lin, Shuicheng <shuicheng.lin@intel.com>; stable@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: FAILED: patch "[PATCH] drm/xe/uapi: Reject coh_none PAT index fo=
r
> CPU_ADDR_MIRROR" failed to apply to 7.1-stable tree
>=20
>=20
> The patch below does not apply to the 7.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm tre=
e,
> then please email the backport, including the original git commit id to
> <stable@vger.kernel.org>.
>=20
> To reproduce the conflict and resubmit, you may use the following command=
s:
>=20
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/
> linux-7.1.y git checkout FETCH_HEAD git cherry-pick -x
> 4d58d7535e826a3175527b6174502f0db319d7f6
> # <resolve conflicts, build, test, etc.> git commit -s git send-email --t=
o
> '<stable@vger.kernel.org>' --in-reply-to '2026072909-boil-smartness-
> 3be9@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'
>=20
> Possible dependencies:
>=20
>=20
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------------ original commit in Linus's tree ------------------
>=20
> From 4d58d7535e826a3175527b6174502f0db319d7f6 Mon Sep 17
> 00:00:00 2001
> From: Jia Yao <jia.yao@intel.com>
> Date: Fri, 17 Apr 2026 05:59:17 +0000
> Subject: [PATCH] drm/xe/uapi: Reject coh_none PAT index for
> CPU_ADDR_MIRROR
>=20
> Add validation in xe_vm_bind_ioctl() to reject PAT indices with XE_COH_NO=
NE
> coherency mode when used with
> DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR.
>=20
> CPU address mirror mappings use system memory that is CPU cached, which
> makes them incompatible with COH_NONE PAT indices. Allowing COH_NONE
> with CPU cached buffers is a security risk, as the GPU may bypass CPU cac=
hes
> and read stale sensitive data from DRAM.
>=20
> Although CPU_ADDR_MIRROR does not create an immediate mapping, the
> backing system memory is still CPU cached.
> Apply the same PAT coherency restrictions as
> DRM_XE_VM_BIND_OP_MAP_USERPTR.
>=20
> v2:
> - Correct fix tag
>=20
> v6:
> - No change
>=20
> v7:
> - Correct fix tag
>=20
> v8:
> - Rebase
>=20
> v9:
> - Limit the restrictions to iGPU
>=20
> v10:
> - Just add the iGPU logic but keep dGPU logic
>=20
> Fixes: b43e864af0d4 ("drm/xe/uapi: Add
> DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
> Cc: <stable@vger.kernel.org> # v6.15+
> Cc: Shuicheng Lin <shuicheng.lin@intel.com>
> Cc: Mathew Alwin <alwin.mathew@intel.com>
> Cc: Michal Mrozek <michal.mrozek@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Jia Yao <jia.yao@intel.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> Acked-by: Michal Mrozek <michal.mrozek@intel.com>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Link: https://patch.msgid.link/20260417055917.2027459-3-
> jia.yao@intel.com
>=20
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c inde=
x
> 5f4220125c76..c3836f6eab35 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -3658,6 +3658,8 @@ static int vm_bind_ioctl_check_args(struct
> xe_device *xe, struct xe_vm *vm,
>  				 op =3D=3D
> DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
>  		    XE_IOCTL_DBG(xe, coh_mode =3D=3D XE_COH_NONE &&
>  				 op =3D=3D
> DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
> +		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode =3D=3D
> XE_COH_NONE &&
> +				 is_cpu_addr_mirror) ||
>  		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
>  				 (op =3D=3D
> DRM_XE_VM_BIND_OP_MAP_USERPTR ||
>  				  is_cpu_addr_mirror) &&

