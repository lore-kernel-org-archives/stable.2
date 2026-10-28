Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793203163;
	b=CgqSW/YKvue8EggULBJvwr1m9U4Rg/BG+co3luY1SHpy9MaYV2tdq81vzXnhFfFnjDVv
	 cuUOa81gWNEoB5VRlNxTSYtX817AM9JmpMDJxc78Nh2fpRXcuLK7VTHGPaBuI2qFfI0Gj
	 FdCfp78aDIz9f/vJmhnhebcJGPQWTlNrQwLK4Cz/tYTLxtCJa0Gq6N2VNffNlPqaHr0wn
	 Dq6BhQa4QelonfzmIi7gASFxwE9MLfMOy2gdzYw02lCGyMuEGzqSGhDSce7Vvsk0mZJUJ
	 o4UPh12Q2eTVbo0cqIHd1Wya3NH2RlwKjEqcStrndOVJKtxhcIKxo20kSMk/wa/CLOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203163;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=GM+lZ7K9QQIzf3mRoIJHXtq31e1KZddmM5MBzn6tyg8=;
	b=py/O6rJIANknIj3RUPwYqj4xx0ZhePijfgECeRaHb0yVBshUu525UQmieP0RLWtjufqE
	 tjt3weDFZaKN0Fk/KzXlyeLRKdTxMPaMMSL4dDkDDNywD6dNjN7dqmmtpnNjvEpnOz4zd
	 Pyid+g/rrshVimKeGkQgtEFkpYUtJdr73gNiseUP+cy1rY0sAs/UVWdqcouJ21bD5p/TB
	 izBs3QSafOznVHlK5TDlM2XK5nF5lkj+fNGxiZV5Dy23DKtvgp3WMPa1InZdqdMpZesbk
	 OXf45FMGZSTIrVXO5DvlGrC2Zqi8XknlB9p9A1aOxQFSYKUUV6KW0/BrnTKezRUDVLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyxChh1K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6160A263B
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FD6160A263B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AyxChh1K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793203163; x=1824739163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UTNKYTi91cwLhThx4Nb64z8W5bLPTFOL6n23IjiRZYw=;
  b=AyxChh1KKqQuieohSqOGfnEAsJj8BtN0RYdDTtlttBkT2caPJ14v+OLT
   CrxqOCKvp7IJmKhWvwW+CpJsfSdOwKInFF8jmx4N6UFdiOD+jsJGJmUTr
   ta8VQKGg5uG55AKF6GGmVDoCZi6TC5jxz5A4W1nG10ze3fxUlaZ6IzSK/
   HIOH4jClPrZeL73T5294I3/JU6L93c1cnRMAzJScSOHIvvtf5zb9Y0R1F
   UG44jb2AXxeuihYnMIXl4LvsqjZ9S5SVA4sIOqpUzpKqA0BcUqvwOkea+
   bpUzbCFMJf5Tmr/7lR8TgZ0ofU7lBdMGcYTsKwxM2WT5AN2goT8fJ7gfo
   A==;
X-CSE-ConnectionGUID: OSQosolbSgSlnEAcgjiJkg==
X-CSE-MsgGUID: /qVQbeIlQ4OijWtnmHZxXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1941807"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1941807"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:59:23 -0700
X-CSE-ConnectionGUID: CoQuZv9YReGlKW8ZAq+ANA==
X-CSE-MsgGUID: QQEPgZCmQWq9r9zWwEe2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4909020"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 08:59:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 08:59:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 08:59:22 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 08:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMVy1vcWEQVfOAqBBeBKAPXHPUdn9ns0KEG9NHlOXjxmTSmZ5X6hrFbRrczBNZU/EFL8XOQLNHeOFizwG6KELrTCzKT7/d/s+DEJl9U31AgfSrO7SDUcQkLczpy7efG5f+F7o1PruEG37HoDBrNARDb5mk0/p1Ht7EqeoEJFgcMccmSXztN7Nj4tz7Aj1XvGfKE0uH/TDfNIK3efUFD4hvYbzbE7aJkb7/0D0dt7Ah59xo90xpieKfvcFzRciaV51c4whNlAq2LAmZ1RVvWcEqeiIFKtDvjvRx7LlojcXs7ixtSX24fTeT61eqovPSkQ+HM8iSS83+f8ZUZCLJPBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM+lZ7K9QQIzf3mRoIJHXtq31e1KZddmM5MBzn6tyg8=;
 b=ikDVjBDVOBxfHRBz8bNiuQ3G8Nl3hPI4nctb9DPbhryUJiboAOqtT219zUbUREpfhLsarzpcy+p5hV1EbtFEn4rAzGSYtwZoS1Eo03p303T/2wlh364hqvXSmTJQcTEmsljRWFfPmD4HE6032aYEIW+n14fU3l3gDZDJaf+2zhLPsvUXTugSWmVN5e/lPIqGKRke5Sc29LR5JA09cR8A9Q5KkwCk9R2WRYtYUq4efQzV3Y4ATDvGcSEDZRKcbeiVEGm4trqK5ZSc+fT6wFTkqzrZpxKSVr0pU3S7ForN41LW/QumOBe/9bsJQW3WRpk5+RCmosF5nTse8Q6nkf0O/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:59:20 +0000
Received: from SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0]) by SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:59:20 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Topic: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Index: AQHdZqv2N/K1IP074U+vOvCtUeUWMbcTHQ9w
Date: Wed, 28 Oct 2026 15:59:20 +0000
Message-ID: <SA1PR11MB82535FFAA9B82BF346F899CD896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
In-Reply-To: <20261028070404.1913843-3-vidya.srinivas@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8253:EE_|PH8PR11MB7070:EE_
x-ms-office365-filtering-correlation-id: b2cf2a93-9024-4333-afd5-08df350c6d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261026140227099003|261021123027099003|38070700021|261028144727099003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261022075727099003|261022105027099003|10067099003|261026121527099003|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: o0lVl22KqH8+TLXSCM7kmHXK/tTGZEBVOi335B0Eut8v8XrFZ2zlcDmdxhZUYB5igYiK6a91aFnUVNX0TGwSpVkmQxreYMhKfObTwOPxJ6TZUbi3u5k/EncOUSD7kVQBC9BaYYmJkXVHDGkFC/VYnbPgJAMb8+YT/JtHP25JPYq0lyN17a9o3falYw6/ym8zn9a33cR5pqtWhoevDncrKQF4toiOytzeeFcSUiST+eV62y17ow+aNxBT56ZrvkwN1O6ycP0S/Fmr8rLv5kRFA0E9kJQO+G0vuASJu9VN3t9IzXc3Z32Ha0s+cfmnOEL2bAXiL4aMIEB+0mPj9D+UiHgBNat9wEp3aJoIzI47M6Sp0IXI3k+nqiqtCaGWXFS/VVNgqrMImDdS+q2SQ/rJs49OOYchv6HuqO12y/1891quEVYPhHyfZNS5h85xWSQZW1q1tn3llrHn/FWor1jzACI4EDj/UvTddsfdjdoRlsVpYpdWySPY0BERfWWTFNpXWL0rSJMiFlo813fq9OVhxG3faOz33mrEVoanBDlFq5lSDkTQ+ImxVM18VXbQHBKPM5nXEvhLW3UV3jDSo+aGpPJ/AotnD2oMsRB5dLYEvbWcwhUrZiCy+ee/BPAJm617wHy37mfvLki6dh6elCSiWobcunjtDe8Awist85tANa+UbYXhHM+QC/oyHfgVdybRr6aXBMaySPALS4QvYkWQfRZPP+yOVuxcNLY7XI/3DZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261026140227099003)(261021123027099003)(38070700021)(261028144727099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261022075727099003)(261022105027099003)(10067099003)(261026121527099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QxAMzoo9b9IIJo+rRFab2oi1KE0SIK6YEDlXL2BmQgVDXFSAsCGGXv/gs5T6?=
 =?us-ascii?Q?S2N2ndsUm3IPlheK1aZkDbNun8XUGilspNpxfcT/yZ7wogBC42oZzS0RUX5j?=
 =?us-ascii?Q?Qpq8v149htR5HVc13dFZ0lx5AXRBKHuRRK/sbyvCTtKNbRnoOManu14tGg3j?=
 =?us-ascii?Q?hnnfJo9AdYVd9uU5QvqxfK6WbXF/f3zY9pgiTZPlTrYhiJDf0Ham46Cf5pYT?=
 =?us-ascii?Q?7cWGfWnCsNRX1ugqKRTZLLUgP0EdbTy/B4MpH/odTH7pu7vSQtbDVmjhBaZ1?=
 =?us-ascii?Q?6xjNsxcEx91aEkw2lIm8apWS3NudflNHd0QeCSZqCUnr2VWNQHDTD3u2eu6o?=
 =?us-ascii?Q?NFuXo7TR9fbLp9FT30twR9Et4hWm5/2Go5opSRKn81K1OAWI81rIPv0aGvDo?=
 =?us-ascii?Q?yEiRqxc1Qg6r2Wc4VbbYokF5ZVpO4H5LpvVtXSzrkK4Y6yPRaLyI0xfNsbd2?=
 =?us-ascii?Q?nOD7G3GBUeAIDz8/wMsdDgDZomImDhYlOTfEkaPzRez2oSi3wVan7cWA7KZZ?=
 =?us-ascii?Q?yIE4/9u6KvtyskcNzMJI/tBPt7VEE0PW+zWdYv8oqVyisCIjlFTjF0HHcXem?=
 =?us-ascii?Q?HwmrYwAP3br1rdQcJYL1dc8ajewgkGn0lMdXf0HRNpmBdqeEIqoubB/113bJ?=
 =?us-ascii?Q?eU9DobUCOCkdEPViwfUZrLj1Sn4nSSRPCeiXdVOY6233MOihmtmBCKiZsIYa?=
 =?us-ascii?Q?LUh+dv2XvXnMvOqGobM9oyY1lWJIy9jsj4WfkFTYYSydUq/Ql4mvnij/PnYO?=
 =?us-ascii?Q?dmVbZVU9xCZ1xfuwUluF9PLR+1GGqXlseIVqf2IMBylc2N9Eo2th3HbCkrAj?=
 =?us-ascii?Q?FoAg1ppaEvEKk3dbaPznGw3kHVOLUTmZUG9c2niPOQnxF6bhRYFKaTxC4dXK?=
 =?us-ascii?Q?Uc+4LKiZHzjUctAZvwU9/e8F1FjSepeRX9kWxecFuw+7ABRPQamzVTgre4JM?=
 =?us-ascii?Q?XsoD0J2XC2HFShew7jDAekXeyjdTapzNj/B8OqBQXdfPH5g/sf9rXQRLjne+?=
 =?us-ascii?Q?zGl2Ullj2Qm/1Ygm2I9BpzU6cVtVdzMJjv8BoO48PKyQgkngyi5fTHlJcaNT?=
 =?us-ascii?Q?G7kYVQJIXGdk8hysz7XnsXL28DVvIxoGMdepUMmC4sHJM3lGKy3iklRFczg3?=
 =?us-ascii?Q?IaIW5OCY19eQCJkuaTJh+cgjTb6nD2Q58I+FKVUYE2zTIzUCPn7es50BeEUo?=
 =?us-ascii?Q?Do3CmDGeCRVoFpnd4SBDWa5Ar6XHuZaEvL1/le42IzR7RwZaIn1zHCea1Net?=
 =?us-ascii?Q?uIsPlH4+ocvMbVF8vesDCme3+cK01GkqBvD97Ybec8w4MsBA3AtHSogmGeEy?=
 =?us-ascii?Q?N9uA5rvK1RC+Sts9z6If11JHkSLIm1fpWrbnpgh9eSj3vFTMEZNqfYdDdxxb?=
 =?us-ascii?Q?bdxPc6J8Y+3MIxBp8U1iZxWqAwgfywl5rxzXzHYrZiE07w9H/08fDPt3RH2v?=
 =?us-ascii?Q?8x6Xr/RnxIMG3Zi9kCt+8IpfP8bxciBetltLP13M0UKjQ+U+Crft3VDbT3it?=
 =?us-ascii?Q?KXlNeVixGEdKvF9NKeKtPcW4KphK8FtaCSm5fXOIDUbVzjdrImGSq5wn6UzT?=
 =?us-ascii?Q?JtNfU9NNIOr++FNLcAt4Amzmwv0Wr+r/ggmDKsh23JPY9ZulZzuPwJPQ8sb3?=
 =?us-ascii?Q?LAQ0JcTaXuo79cY3pFjDGJR1MNmR0zYoH2gcKoHV6MK9Of8Yl/GnLBmbrDvy?=
 =?us-ascii?Q?bey1T+R5jsQUXPjlhkrVnvO/apPxETI7s9QUrQKwaX1GH30r8ZipADjOUDkN?=
 =?us-ascii?Q?EHzZsnjpQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PNyJBQSBnw1FGZ/UBFJn5vdsf/7fBIA20R3mcYwP5SygNz+Uot8+0CUHIuO0rrxrJ6wOKa0E+w+mVOKYS0+Sf8eFduzDxdLJrsKYQFZhqTzC52UWebBahIuef00aAgeX0+erfxKk6dX14L9O0W/FfSM+c34Ln2GWCnXN7MdBlIUBc6kr2k7thCV/bcRti20UjYZWgBfsd9Go+6OfO9YTK9jUQVuh4ogsmyZZTLClyC/LxR2eyaimw42Db+KQ8/lyBimF/dIlSHVl2KO/yeN5Xp45/jTzl2b/MdWWqkWxEp7yXSwQcuh3I75hFwOjk3+FtSQgdCKAn+bASEeQ1Zrjjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8253.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cf2a93-9024-4333-afd5-08df350c6d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 15:59:20.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sif0E0/m6APcNobN68iYvFq/D4nBa/p7HxAhhuOuOlEiqgOz/Bz0puzP7vyEnufLgVFkG/QRZ3h3FAgf/j1si5NDBep9xOTlV1p7gKag/xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Srinivas, Vidya <vidya.srinivas@intel.com>
> Sent: 28 October 2026 12:34
> To: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Srinivas, Vidya
> <vidya.srinivas@intel.com>; Lin, Charlton <charlton.lin@intel.com>
> Subject: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
>=20
> Pipe joining is not supported in the WCL display configuration.
> Report no joiner support on WCL so that modes which would require joining
> are rejected, matching the 4k 60Hz maximum resolution documented for the
> platform.
>=20
> v2: Rebase onto latest upstream
> v3: Fix up the commit message
> v4: Split the scaler and joiner changes into separate patches (Jani)

Thanks Jani and Chaitanya. Adding fixes tag:

Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")

>=20
> Bspec: 74286
> Cc: stable@vger.kernel.org
> Suggested-by: Charlton Lin <charlton.lin@intel.com>
> Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> b/drivers/gpu/drm/i915/display/intel_dp.c
> index 00e02e019d25..ef164a797618 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
>  			return false;
>  	}
>=20
> -	return DISPLAY_VER(display) >=3D 12 ||
> +	return ((DISPLAY_VER(display) >=3D 12 && DISPLAY_VERx100(display) !=3D
> +3002) ||
>  		(DISPLAY_VER(display) =3D=3D 11 &&
> -		 encoder->port !=3D PORT_A);
> +		 encoder->port !=3D PORT_A));
>  }
>=20
>  static int dg2_max_source_rate(struct intel_dp *intel_dp)
> --
> 2.45.2

