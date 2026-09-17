Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46C37AA9F;
	Thu, 17 Sep 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652166; cv=fail; b=XzzQsgBfLt9sIrk4pfUfApRXqJp6ck581LL7nBCOzo0GOxCqq/ZIZMS0T0acW6rHkbtg6pTA4DW/pgeV6U+/LWRtTipEdYXDmFrUmGJlXkKfaozgTnyr9WmtcgRH48kTae9FpaKbXNBcNtRqaZgthQoB3cxnaRe+LUk2qRkfjkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652166; c=relaxed/simple;
	bh=W+da9eMbmr01zUEgNTrhvN1Z+oVmzV1hI5OGz8QoSIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uAdBZId2VjwLkDM/mlGVIcwtixT3xSTr0XKSPfVE7rLxW0Rb6wAx6hIdVBlUNKXSZ/gupkrR933OPTQOCtb6dIvK69/btjiUUIV0wMHCSBKRNTJW7bKMBhbnuqs9whKjBdPKoPiiMej6V9oLJcb4ObJxntVxp0MkMIkxYJMll2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrkPcb05; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrkPcb05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789652153; x=1821188153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W+da9eMbmr01zUEgNTrhvN1Z+oVmzV1hI5OGz8QoSIk=;
  b=HrkPcb05vRG3T2M8x93FLGlJtMSZa3UGbzI5jZ9zCp1bYcsd9pihsBxC
   91tNXpyIgF1vxuhkL1XJJk/vzbJPRa8VmdVBPJPvm1o3R3LO6/goVt695
   bCYpnwQeB+0hIIwv0WXqQzp0jtrBGPTKVAlX5dzi0uGCpPFJKynRyB4Us
   aKDCxVBpYfZws7z/jVuZs/iFbALDkmUVmAH7tcqgBxw//IoyS49n0B+h7
   T8uU/wpI+SvSkPh6+mR7NrFRIYDnNcZnpl6JLIjyEMBMZNZ6lMwLANE37
   zWJXbw1T5RpFI/1/nWc3ynYmzFiKVEaLufeMKdxmQ4GGWCP4IEPdknbkU
   Q==;
X-CSE-ConnectionGUID: PJAL50o7T5SLR5ETQntTcQ==
X-CSE-MsgGUID: f4gpMnroQwuHRfa9sVQmpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92584149"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92584149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 06:35:36 -0700
X-CSE-ConnectionGUID: w9YHRuMFQfSf1Y03W5WgjA==
X-CSE-MsgGUID: PMgRYME6QCO4sc2ybFS32Q==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 06:35:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:35:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 06:35:32 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.38) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U90liW7GUjYESbzMr10Q23UyUM+vfu7OflysNx+5xTe1LaGDw03STnGk8NgEbSy4dllyJyK7zaLow4BpLi+bmGvQwxGk13GUrcsOQmXzbKYWQZi6uvAex646ybSC0KMZlbn4SB1uDQ6BqOA6SJmWQlLFATrGeudfeHzTKh6kl2YlArv7PtzzDvY57mGqvEpeD/23yqT5aPBblWZGl87dhasXHInuiQZR7cmoE+53n2xNIwdjTQ5aZlHtMLOBqaNLTj6o7fh/lAjh3e/EGVwCt62pt5IWh+j3W+Kn3d76MddcbuCYfmLEXd2B+aJzW4Sv+eTIgULUCeSioYTGrXcWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQXphuBW2Kh2vwvYuNJpP1Qarr+AlNvE1tfdpuJXYX0=;
 b=VWgPsiQj+8YGkadUOuTzarzNe/7E0mxFlMilhyPeFs/GjCeO4T5yMLFPYZnUwnei9jxMh+XwVjBNS/Z1YH9k7PK0OQIPD9FQ+lf+r6o9bzrHz1jdCjjUfub/Z80h9DJmgyC8tkFyY3FpaAJb5jiuC1iduWm6o7XoGKoiMhzEuVqpVjllTOhqZFjR+8jt1Xqf+w+d61FNaj3/6psY9ieWHbmq1bmjuyJivBHp8QbSmXcNv4TKF2B+GsIWhVdDHCc9FH5/jJGtm9k10OztY+WRNSQWIkB6Sk1sKX3A7U7bcbXYW7mkM+tmhgOOsR8y31LvmWGQ7XICDF/LrdBqfDa7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8857.namprd11.prod.outlook.com (2603:10b6:806:46b::10)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:35:23 +0000
Received: from SA1PR11MB8857.namprd11.prod.outlook.com
 ([fe80::e847:8fea:6b23:944b]) by SA1PR11MB8857.namprd11.prod.outlook.com
 ([fe80::e847:8fea:6b23:944b%5]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 13:35:23 +0000
From: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To: David Laight <david.laight.linux@gmail.com>, "Bae, Chang Seok"
	<chang.seok.bae@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Thread-Topic: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Thread-Index: AQHdRjLSwVLNxqVpRke88KfQKV6xa7bSfZyAgABHoHA=
Date: Thu, 17 Sep 2026 13:35:18 +0000
Deferred-Delivery: Thu, 17 Sep 2026 13:34:58 +0000
Message-ID: <SA1PR11MB88578272D7F9B15DA85F9ABA92B82@SA1PR11MB8857.namprd11.prod.outlook.com>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
	<20260916225939.1144524-1-chang.seok.bae@intel.com>
 <20260917101455.3e1ac9a5@pumpkin>
In-Reply-To: <20260917101455.3e1ac9a5@pumpkin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8857:EE_|CH3PR11MB8139:EE_
x-ms-office365-filtering-correlation-id: 82ad3bc2-4229-4b72-f5d3-08df14c08660
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: JVgLTbi53+LwFsR7VOsMVuNyBCghxWIXrhaT/UOEVCrKMuasBYDpUXej9bumeUpXFhoFmk9+c6f1sOrzxqEx7gqq27LjtksqrOb15uhS9X/Yen5UJe9ii2GNkH3IhPCl0WN+lYpsOogzXdSnEs3IPisIYLHe60qMY3XAgI/gwo9NwWxt7HjKOBtrBXQ9V6mm/Q9pCU+kuGAr8FXESwv5KqJ9GkkHtvPuA4jxfxAy2yxf0pQ4wqCWlWzNIkurPJRAubJFbajZTOpJ/GjmUHbRyMBhv6rdXqi6ADv3y7xrXZbWOwUuuymDxxRfw6hgWUpQGQfjg3oVr9EYqX/nBQhzDA93a94hRmjv9uxpsYBMKqxqZ+Ztv+/oIbZ4rvNR4BWClH77apKV3WkiZ/8Mf9PdCRY42wyzj6vT949M/uQqKPKFzS3OfA80KyRuMeOD+XOhIY3uOYMAgGZ8hahE9bdBkkuBaGUtn1vHmmKQzD2Sw8OJBX5HrlBv7QkqyvzzHZB+a1Hv3AtpQZ0vXp9m16dyZz5SlvdPvwR80zKr3WGCsf03iTq6Oh0XRB5zjLpjSnVPXZ9xALVd0STnE1fZ5DbBjnGQr62aRMWVPhBZonxg61fxvX5i3+PGDsMPU72oyMvuTsQR6l6ucwjYpOI7Pun87BPJaGhH+gQjy8otCxdtP6BxQoRAZ9W0nH2+riGJlk+7PTjoa1cTiSLeZyyTl7jKsWyA19rYtN1Y7IGONSeniWw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gU4IezNgJ3AHYJ057hne8avCEdbOKj9ya4yiHwQtbJu4DsiZkOOG0sYY1bn9?=
 =?us-ascii?Q?bHatoHfy+2x1ABOhHwGen5qcKE3lrOtnhWaveyoF4XHxET4EmfVvZr+hWsn7?=
 =?us-ascii?Q?pFBFlUHeQ3pcTT+a9fE9u1nB6xk/8GnmQk9dCXMlABNHvOSaszXzKYB3ZWbo?=
 =?us-ascii?Q?AoCJWPby1qELQKfDBPSj0ROkcuVC2/x8gbmVl5ewPs7MANfQiVQpMiAEseJu?=
 =?us-ascii?Q?hHFtrbwYd8I09lmBwwvmLTWw+N1rl8iNxy4UcorKaDrs9/jC8WzBK2cNhIcQ?=
 =?us-ascii?Q?OUHEt8S38nhqB+fNgNE/40fo5mJv1gHAVXn6UK4TbR7VlFa0f7np+6jXepj5?=
 =?us-ascii?Q?MUUTEXs8bsz9wwMmFdCmD1lsM41EK7jn5xzJjo/Imm7uB/0FdjxAA/lBGDsn?=
 =?us-ascii?Q?klsxhc7aKZOvn9BsT5W4+n6+KoI3TrwFsjJaqr6WYHFd9Ycj6UXOt4uqSIMd?=
 =?us-ascii?Q?ayIJFLsWYxODfsBFrjSxJ6cnoyrOJ4JRklmtWjTUPYsK3Q9RIZjXGpABn9ti?=
 =?us-ascii?Q?/9yKl/OymPSjlps6kiJNqy8VdsGmzSOXyMqAGVNsZFOMyTuMK9fgBuB+cqGt?=
 =?us-ascii?Q?4kynikROCfOt77njGE+3GftFQuPqt3rQ0rOagQTo9m0tJvBbYR6OCHaTSqXK?=
 =?us-ascii?Q?xu45sKO65E8IUmHRqhg/GD1ZO/ekAPvuXGA0lrsilp6kd7XU9OyqjbAt6qV2?=
 =?us-ascii?Q?wpiQdJD7GHf5D0tLOaDTqh0sbsEgV+FJc4FKG6gpIgms1pX75YY7rfq9k053?=
 =?us-ascii?Q?lhIm7lnhE7OTVMzrpshQ1UV1HDOcG7OQ3oCoF9wjsZPS5rWTPo7pnggb5aOs?=
 =?us-ascii?Q?UKmuNFKkOMtTgv9dWVdVgrtrt0BxluYYCF0sTep2q5Xc+HSztBGaxVfbgQQi?=
 =?us-ascii?Q?uQxgyVKBIQWXgvqGCzfXQXvoNT7gQWBRQ5qtVFnCLAfbzijt2d/RH9GnvMEd?=
 =?us-ascii?Q?IbKqF0a0E5pHj+T0rXMWsGWUziV1gKEwQUD7vKt9umNsm+ZGxcEz/wyRkcjj?=
 =?us-ascii?Q?tdGav6Vzt3ybiuN8ivK8EbCsDffUJNgUonDMrh/I7OyF7ZxQ3ao/pv0iRHJJ?=
 =?us-ascii?Q?H6AG+67ftILQvUB7wXxjdzFGOetq9+p7ZEicGtYleHdXOfmj27Mi9+B4FgIc?=
 =?us-ascii?Q?3S9OSqYucPZl118CrPQO0HRq8n3HfTjQFaVHLK01uvJ/Tm994vPrWJhTeltq?=
 =?us-ascii?Q?X0yWQgxktZCbRH1bwPBbLUCf62rk33Oy/Fr+dvEPWJMlmTGNIIGTtdvbGNki?=
 =?us-ascii?Q?RlxBBs4fP+cFDKEg5jGvJrtc1Z1FDcJJe8iI9pFTAeWEWfD10Ck0uhAIK27B?=
 =?us-ascii?Q?g5qpyU05lIfdyk9vv8hSjEAZlezLPsG2bhaLpFB1IHqz3kSLxELVtM7NoAVC?=
 =?us-ascii?Q?hVIUixPxq+JpM1MY6q4WxHZ7Gzp+nzZlLiD2ZqsLQbO8dls7ItZvNPNLjfhH?=
 =?us-ascii?Q?1nfhm7nxsfn7VhtDe5K5Jr+gm+AJU/w2gfSAyE7BDtqjfAipUefZOeLV6MQK?=
 =?us-ascii?Q?eJbkEtuMWi/75tsuah0u6RYNY4My1e4lbotvOnbOZW+8uAompK1mW7UBaELY?=
 =?us-ascii?Q?mQH1+HIMZGBcf6JuS9H6KwvQxwmu6PU56mjc6CRMXt0zmcda0LkJ3Z6QOlQg?=
 =?us-ascii?Q?YSuqKqBPJJ7yb4ZZYePJjp7Ni8+LZiyVKg94/EuWk/maRTlkcBbrPKxvxasA?=
 =?us-ascii?Q?fvqzIdH8qNJiXyrojKlqBNWtQvk2XRuGxKIkBy6GSh6Iz/0uvebipD05d89N?=
 =?us-ascii?Q?SvO6G8TOSV/zHymLeNGs97XY7ClA1Xc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fWJ4bqsVZhYSzn48QNbI6Xu5gybSoSplcaP6UOZjqq8Vam0+Yp8KvRv+1vleOgiqbWWTujK7BiWETQUwBUYuJ4c5QqQpZf9q6QRGmbtjZDFeogZcpv3C4I9inR9k9Jr9NwY30WTUkr/16/Q9+vyGZNAR4LRhV2Gxd8RhM9FJhrCU8cVawEC2oQLKvSHmZ2G3PQqKGGcAXUzEpHmqd2sx2AQi1G8QaHpHj7szNtsdMZ5lIEGnWhQXHzApl98s9tFDa1sxFcjQRVl2IAXG8RlIrxYvL+fSg/yi3lA2MnqdSdLGisj3shcv4ZV0vC2rKySj4m4srWDIdVP5T5IOcz2c/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8857.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ad3bc2-4229-4b72-f5d3-08df14c08660
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 13:35:23.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtUWyfzd++VOyvT8sGowAyZW2W8n6hEgkXIJ4SUbQ+s27RKmwLiWPCs7x2MsKnPQA0k4NeA1/mm7N4f5oznbN12DeHk83wRJFhZW3SrT4Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
X-OriginatorOrg: intel.com

> > Microcode updates can usually jump revisions. However, there is an
> > erratum on Granite Rapids systems. If they "jump over" revision
> > 0x1000405, they result in #MC. Avoid it.
>=20
> A probably silly question.
> Is it valid to downgrade microcode?


Within SVN in theory it can be done

In practice, unless you have very special circumstances (and check with Int=
el if the exact downgrade you have in mind has been tested for downgrading)=
 I would very strongly recommend against doing so. It may appear to work, b=
ut note that=20

A -> B -> A=20

Is NOT identical to just

A  (staying at A)

as part of the microcode load, some microcode runs as "setup" which may cha=
nge settings in the CPU (versus runtime behavior changes) -- and that setup=
 step is not undone as you go back to A.... which means you run A with a (p=
artial or whole) setup of B.=20
