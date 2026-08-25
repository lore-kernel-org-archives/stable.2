Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA7348C76
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787629523; cv=fail; b=hIaKCe9mShnChu2lGqh0la0Id/JYnHF6IGP/fLiVpE4aAnvSbmvA1cMoop46HocD8qm3xM4qqOldf/fPI5+mkxQpqaSEP+VxvusinHYZmrPCfWpSzx/UYUZJJJBejUWir9DxNUQoDauDTgbh0QpZysiPVcxtwoBywYIV9kKpFus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787629523; c=relaxed/simple;
	bh=KyZPUSKdiYJQOKxWE+qBB3NBCWSQjs0ZznoU25DXYzE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=he+KUJmaj7xKnqaDe4mmUB0bT6fFAnWTNIurOtkbwL4X2fd55CKsuDrK8VJyGHAvlnYhSUOLdIqoggoimsIYDMVxmBvTZIAKeK77TDC4SeL88wRyzKzkAjBkUEwwXAIbB0rUJLPJoQyYN+cwS1qsV3S3nfrPo4IcNpMiMT9vke0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBv5lEGT; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBv5lEGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787629522; x=1819165522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KyZPUSKdiYJQOKxWE+qBB3NBCWSQjs0ZznoU25DXYzE=;
  b=fBv5lEGTF5jag41CiYgEGIbGwAJyizNBaUIVzg025rohHbVBvFmD8O0p
   5lO5OJA/vSqvFvUbEZtpNvu421wg9CYLRxvMfH8DeMUYq89uRdi8bCnq5
   Iyh7NGrRsWt/zGPz/M8ba3yFV0OOh+nPvd1xD0MiILeGVNOTpsP7AucWx
   NvXEQftS4EX4lwiNVYnMoaBpKnqs20vtsQ35Imkbpe4/BUooPfCkyub8W
   JONUMMsjxeo9lWSU+gIZxcpz10rhLYO+/G+wHk0Vwzrn2TPAcNHWxhym/
   vHLWG63/cNwMOP3poRGNibGuzgU4NokX8V9p8lSQPbbc6UXm457HBoT2r
   g==;
X-CSE-ConnectionGUID: 4jSE3qHfRH+YzWEBBoKF3g==
X-CSE-MsgGUID: 2uXx/0fiRQi6WkkXKhrCng==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87038720"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="87038720"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:45:21 -0700
X-CSE-ConnectionGUID: uIz2j+M2RK6LHGIc8tfjow==
X-CSE-MsgGUID: 4n54yROORveH+NCYDfrvng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="270641799"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 20:45:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 20:45:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 20:45:21 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 20:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbhKZPjyQFLQ8gzinkSqj9ZzGs5nf6FGTKII+I0aS5iqrwE24P8v0YG8zXSJ44REHvY0QQUFApNhZVnISIgGBXasg4WAHUas8t9W0VEtr3nEDCWUtFCTLrOZdyDthTdGgbmex51V15ACqOJSvWgsFBTM23wQXR4fpq6WOkOd/oqDmuw2PXQVz7tnmfQOAhRvFD2cVICCuyzxIk6MHTlEfgE5rCUhbwnpLe5prkL8QCw9zak+WucB0PQtIikj1L2obecoDj7hzA4BgGMiILERP02i1+w/3eHZKQoBcJ2LJfph9X1n9BY4+3PCWAx7wTh0HQwlOxpb7ay1XOgOzY18ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ciw+LxFa5x3WpZBuHOPLDL4axgCpGow67RKviK8+2hw=;
 b=s7e9guN+FiiZwVl/gqsdQppZndlRXFeVWZu04194/b3Zmz+vYTrFRnguFQQ+Qba7MhBOPvYl4oHL7RcrBGjNBTFdsS0Zc93u36MtZIUmj8xlQQWkG+aqFqGURcjtL29Tv3BOnxydrHe9pFokltUg+zxuxBbMFOWzmyDsnQ4ldC4tKxs3BTXdPOcRyDMfp8RusckHnItCxMLOjWgXOOcqqhE8dPBMfqyTIRQUdxsPLsS9Cbxr/3mA/lWdV91ND1q7I9Iy/xzwTEv++DPjnSzFXvmNOAOCP1Hz2RdryUOZ/aXT2YqxMmWk1cBA+YnVSVN7feuzOavGR34chM5ZjV3uUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 03:45:15 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 03:45:14 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Thread-Topic: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate BO
Thread-Index: AQHdM+jyPaU0dlF810C399fyt0BMC7atbQEAgAACRfCAALCPsA==
Date: Tue, 25 Aug 2026 03:45:14 +0000
Message-ID: <PH8PR11MB8040FC3EA4D1AAA6A521AFBBF4AF2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260824165208.498797-1-jia.yao@intel.com>
 <2026082417-detonate-glacial-6417@gregkh>
 <PH8PR11MB80403BD1E790D1130A21BC9AF4A02@PH8PR11MB8040.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB80403BD1E790D1130A21BC9AF4A02@PH8PR11MB8040.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|SJ1PR11MB6225:EE_
x-ms-office365-filtering-correlation-id: 068963bc-e14c-42a6-809e-08df025b45d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|42112799006|23010399003|376014|22082099003|18002099003|11063799006|56012099006|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info: TyWrfe4w9FRrmoH2kg+M0jZALr/sHqx+7DZAZm8w6EEdvTu+4VHJ4kCjO905MqHQzEWGS7sniaBm0jpoS2EtDg47gQBw/TACi7xvZtNzk1hQvp8lwq3SZdTJJv9viKng0kT05pqa3j1vHeChU0opc8LDcOpTrUPScJ4CvVRpjJ4bsTVkOpdTLRHVB/AqCyM6+l2gdREIs9EhzEWfbn9od3lsIAF1cei8oO8Wax8o+Cf64Od3oTzapWZMJcW4yFmPB4ozaggtwpeRS5C+j1DYsGvjtCb5mt+e1z3tN3MM1EPQXcUGfGNTgXoRVHtRJ1cpn4yUNBc9q7hJYyUwlvHtwbvC67UUYwI5MMqS0C0zLvhYjLEO65SXoOx6bFFxY9yQXJfnw1LrsavrE8wg+CiSwcTlO+uxVWUBol7D4nWAnpwxD2Y+JPCvzhQpd0P9vrIsH+KAusOnzc0ciSKcRxpi/4PogkxmPyOdUiSgFze++JHLhTX7ulaW8KYDkIRldY5sPV+09QkyiKLzSIp6rgiRSxHrxkyhxqhwjQn06YXbaSba265Un3wxx1gQzt6ikkU9yaHEAmgAPnRAweMznQJEQa9bWVHDkUCLppfiJpnOHUsMZFPjB8lc3FMDkzR/TFF6+73v5R/00TuEM+DzyQ+VhVlmI5Ulwb0+CrnAsc0K9ilot+MxVsSlwA8DjUdqXojM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(42112799006)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eZbN9DbrO2JziKP1aVLaRdCv2z6fkYDSiWz0TBhVZ5uqkZFJIltFg7vlQb?=
 =?iso-8859-1?Q?559etoM+CzudZ8yMFbp1BpjUzfvjkq1dxKRHs4f5RaPNWDQqK2+xxDotVo?=
 =?iso-8859-1?Q?R0aPlMg4iXDwkHhxjlo9m1uqZ7fGWEHGBPQByvrWmiRULd+984KF/+w3U/?=
 =?iso-8859-1?Q?FiKP6CFAx31mqTU+IMq17HLK71eQNoREK6mxsLAfRLDW8Nx5pHoqmPm3ea?=
 =?iso-8859-1?Q?H8APuus1IvInMxXNsf6rbVi2QX9cVgrEhoJEXp7cNrXlBJar8ph8jt2EEf?=
 =?iso-8859-1?Q?eOYKfCT6BTFlACATFh1VnAD8fWwAztQhIDq+a4l2BwfyyBseQL18Tpt+MU?=
 =?iso-8859-1?Q?l7fCGAOYWif0/Ym5w0HFy1J5b4gUO4796dPF1lvftl+jyV4U7ifumti5Tq?=
 =?iso-8859-1?Q?cpgATfkWeJ9Pk90oJeMawFN2wP54AHQta1Jzbp0KF/ddvq5pIa97XBlmcG?=
 =?iso-8859-1?Q?AiIvk9DwksNjHFuxluBiQ+oVUxOUxn4HyVleY0Eb0jSZpHfi85VgbepifO?=
 =?iso-8859-1?Q?9TueYovNnt5TKO+LJPlyX0ptQk7GNSS3anMeM8gHRKcP+XE0Ra/f9FTTLu?=
 =?iso-8859-1?Q?jzAEqheZO0j1pXZyMFisgNB9HBOaNyBhkryl8hvYXkyc7nEsKd0TkSpaHe?=
 =?iso-8859-1?Q?mjkRgZd46TpTRLEf4mVGKDbP1TLfJLfxY5bEp97ylKvAx87pdwMbJFmu7x?=
 =?iso-8859-1?Q?ha293sXlFHb8wtOUAeWVKb8TGMVqQ9plKhjdA+oQ+s/zlglnJham0N+/fK?=
 =?iso-8859-1?Q?QqquNVGMGtcQaTn+9s0ky43f81VqzP/gnmo3AXVXNVpHH8/j/AXQtfNLlZ?=
 =?iso-8859-1?Q?krTYlSzkrJTfz4l+CR9Jwqvt8Os1E5kntQu19/UOVkh5tv8SKC/sCUJfDM?=
 =?iso-8859-1?Q?8YK4jxowQmSFpoNSorpfbYiTOjkpoVEsST45ZGRG9yzdF19PrpplkqS/7l?=
 =?iso-8859-1?Q?7hYC8VLePaw1JtSsZRvqla8wsw4V5h6goNisv93TOSI6AzJApwzLkJNLVt?=
 =?iso-8859-1?Q?cmDZYKOxVdTBGDJNU831u4FSLqX7yE/GHH7IBxEp+idAmoXUC16zKBgsx/?=
 =?iso-8859-1?Q?kq6wGJsHg6pYasKNs0IIvOb/fb5G/R5qF1BZ/5Eg5kh2xq+K5MS18d9yLU?=
 =?iso-8859-1?Q?nJ+rKMq3mMPBQ2tYNDzdUqzEaZPasPdFk/ZdlcJ2Mwu8q8vm7tl2naXP5I?=
 =?iso-8859-1?Q?KEqLu94uhEEug0nBMneE4SCu2Y5tvHVi9hbd64dxsEBAIYquehrgMsSqTl?=
 =?iso-8859-1?Q?7+pGqgRfrIYk+7oIqHVPIg6fytV3jaNe70tI+j4pXQkWtI/QuaiQMWeyWb?=
 =?iso-8859-1?Q?sV2TBBcFuQgsUtGV1wJytDAvbwRVnSG+6TF8caEe69IrIbuspnfulO/QrE?=
 =?iso-8859-1?Q?VUuJ9D6HDIU/9VQlhuQ2v1biogYai44ZK4pFR32bCWnGB83dl1opZepd3M?=
 =?iso-8859-1?Q?+NHBYR/S/lPy1RNVMS656MwuNMbCZzCWffSU8ADlRtlMrSiolmLYL60CqB?=
 =?iso-8859-1?Q?CXGOcwKwrbXZqkg43M8wYMoSzyro0X4bAF6sA9Xf9O8AxOlCymdWKH+FME?=
 =?iso-8859-1?Q?CO4yjD64xJPsyGWvL+TEVYRN/FLp432L+l1EQaul9+jksKoODdUzyRGr1q?=
 =?iso-8859-1?Q?e8doIXf0LkMlEiunbm8ScMAQcA0e36lO3nawgwdIrww6QrpKNfgnk/XiHv?=
 =?iso-8859-1?Q?j8uPM4xFCqjQtEiolQVSIKOcP2iUjOhk3bMvMYzczQU+I3pCKBDHLnfDvz?=
 =?iso-8859-1?Q?LtomYWTK+cyfMGX0TLjZn9MYRq499uQfk9C2mot6GR5Q91?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UcghqMGL3NDuqqcqT5G+9mPdO5hrV3H0RblWEysvYeTW6dYqt0KsPCQrg0sqW0xq3mq94AszlyH1ANsYHwqNjn2ZUc+OeV52fHl65v9lRQ3yP0Dk2YmDvOUexwo9TFd5PxJXwAf45Ug90oMyQTScuJ6zkhCshnHm/Qd5b1Fvjy2mPvakbSHuJ4toCwPDrubAthQUkJ9RVXCHgwXx6w9zks2uLOZwEfytNgQ6S1X06IF5EfbtbQzFcAAqtmwumcL88UKR8df1vwuZHhz76LKQuQdXxhpDd+gLtSiQ1n29upeY4ULcgqyJ6qf3D+QAaZsa0+oQROdV3UwaoB3WLDkgpw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 068963bc-e14c-42a6-809e-08df025b45d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 03:45:14.6207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +gBH6iZIgpcJ9ogBemVlW3qzuro94/Gi9+gUrslghwKJyVjquqOSJHjrvHCFTf7Su5PRWadCGEZ0eqh8dFYJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
X-OriginatorOrg: intel.com

Resent the patches after removing the redundant cherry-pick information and=
 adding the correct subject.

> -----Original Message-----
> From: Yao, Jia
> Sent: Monday, August 24, 2026 10:13 AM
> To: 'Greg KH' <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <Gwan-
> gyeong.Mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Subject: RE: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a separate
> BO
>=20
> This fix is intended for all stable trees containing commit 9c57bc08652a
> ("drm/xe/lnl: Drop force_probe requirement").
>=20
> Regarding the duplicate cherry-pick annotations, 99b01815957b was itself
> cherry-picked from 6af05de0dc19 and the extra annotation was carried over
> inadvertently. One of the cherry-picked lines can be dropped.
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, August 24, 2026 10:03 AM
> > To: Yao, Jia <jia.yao@intel.com>
> > Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <gwan-
> > gyeong.mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas
> > Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > Subject: Re: [PATCH 1/3] drm/xe/guc_ads: allocate UM queues in a
> > separate BO
> >
> > On Mon, Aug 24, 2026 at 04:52:06PM +0000, Jia Yao wrote:
> > > Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> > > CPU memset operations on it, which eliminates the CPU as a potential
> > > cacheline-polluting agent and helps maintain consistency between GAM
> > > writes and GuC reads.
> > >
> > > We also need to ensure the base_dpa for the queue is contiguous on
> > > hw where this is used instead of a GGTT address. Another good reason
> > > to split this out to a separate BO.
> > >
> > > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.12+
> > > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Link:
> > > https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> > > (cherry picked from commit
> > 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
> > > Signed-off-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > > (cherry picked from commit
> > 99b01815957bd7d848420cb697f79ed11f7f215c)
> > > ---
> > >  drivers/gpu/drm/xe/xe_bo.h            | 14 +++++
> > >  drivers/gpu/drm/xe/xe_guc.c           |  6 ++
> > >  drivers/gpu/drm/xe/xe_guc_ads.c       | 90 +++++++++++++++++--------=
--
> > >  drivers/gpu/drm/xe/xe_guc_ads_types.h |  5 ++
> > >  4 files changed, 83 insertions(+), 32 deletions(-)
> >
> > What stable tree(s) are these patches for?
> >
> > And what's with the crazy 2 cherry picked lines?  You all know better
> > than to attempt to mess this up even more...
