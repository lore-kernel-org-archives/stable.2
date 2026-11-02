Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640646;
	b=w/ZDAGl3YxZl1N94YEA7wJ3ZIx3e8meiPHtSc2l2TRtxqi41jZ00hIxj38Fi1yp0pvJH
	 v3kKVujlG/wtqk4PM5oYpgccR8EQMnA3RX34pjAzHgr4Bf0kRxf/Jo0JZmo2k9dNR2/Nr
	 7g9xhIjJtfGDqz4H5PbKWGM1yiPdBr3sj9kSXNZh9TSlwQpDR85XJfpNpCtgnipTWZXnJ
	 FC2WwsX8QlPLjokl8BTT7t5aOhutkmgihBO57EVi24AXt1dP1y8eM/bD5zHNsiorbcaY5
	 xfSYgCElN8djDLQOzkzL7hAcvXJkc+JHjPn5vjpSQEHRhdvoJfVHAd7KF0rgFwOj7eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640646;
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
	bh=5gMCAI2r8wjs+GW1NHX+0znrDTSn/AIc2zVBR1Zyqlc=;
	b=hA5PL9/j+54DUMZ6eJBp1GS5dNd8Sv0Hk7m+HjkFoJlZym+lOysnMLF+RLrVdv0I++7Z
	 yeRogKerjWNR8uT85ADtbF/OdHciyo20rT5n1UmbJARefzTJU54Uwc6s8tdNZupN/Oi54
	 hAxmduCvC4GFPKkgvIio/xY10GImdiaxPI6dQe4sCTT+NDdQQ+IO9PfjP3vCwg5aaqQrw
	 Q/z/PPKhVVGqjSAhbdhU7pShp9WThCU3LpVni7fK40dHnN+mQq1ebpqUk2D9Um5o+y0Qi
	 txqSVbIR3T5CwqQ+eF0zLb1kOCbsjfYm39GW3YxRGBSuo/z/PB5MUir7QJ8tqK+QPdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bNcDgChk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F42606A595;
	Mon,  2 Nov 2026 17:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F42606A595
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bNcDgChk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793640645; x=1825176645;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mj1wJqzpMlAGp6leGayreSKmkvxsxjyNMFkSN2+UnHc=;
  b=bNcDgChk11bV3uH8P0pz0owVkDaGq01WLVkEzhCm+Pm4RkNc7ERoHOOg
   MlvZOffWq7dIR8g/1qi6s9zrK11mcP62hHxbNvOO857HRrKTtkzeOpISj
   I/kQ1RnJN+UktcqTOOEp4dQLTqaicTVsbZqBHf3DX+cJ1NRpWkPiqTJD/
   d/gA9rTp3Jqz+mLqjXk19DAqhM0m9/7g1h2n74VpGOh50TWPWhCKfTuvY
   sK5B7r/pOkTAMo8AFX9aP4t1JdV5QZDVRfbD4B5aIDqLlTEJ1uhtm+7rf
   dkOyY5oJxrtT2uPIOGw2UlxaYbiw2CcExBYpUgc/NRYeDskZAyRJ5DpNn
   w==;
X-CSE-ConnectionGUID: 8gF0pyquRKi32WbLLA3ZzQ==
X-CSE-MsgGUID: AUj+KewETCSYn90DNt6ulA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2355183"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2355183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:30:35 -0800
X-CSE-ConnectionGUID: F2RL8YO4TCaOLneGyvTaPw==
X-CSE-MsgGUID: c0QsIw37T6aPdBMdspD8sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6514804"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:30:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:30:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:30:34 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:30:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDUf/JcKEzJF19Q5md5N5oA2DRd4pK4IdMxe+SsxkCqGLc7wraAKNyxn5FWbQcqx58IVn4L+0l5XBKLNBCUvcX7MpOHG2AFKevIJZdP3J4oEdVF2ioyoBKf2wkXPlt/E/OAjtd7sm4SUcYUvLfj9nrc3jUfF0kPIiFyEv0g2n3wDhxo/4QvbwiIeH1O6YitxF9EuYqGbKFGytgiJptmAg5zT0TeBSnZLhqp6Sf8iT7c9n1XENQWe1A9Q29VQ5bH1akMxCgqWkitk7LmRa2lvyqM0zrG3bSYGs9CTHHvYf0htTA03+NP+1Hd+seg5jZGadoYwJOP8P7pCzp/u+JYPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gMCAI2r8wjs+GW1NHX+0znrDTSn/AIc2zVBR1Zyqlc=;
 b=WmflaqjEJ+rGycN1FI0b4ZXom0LbG14lyJwM+nqbgxD3VYLU/A2ooU5ovlE5nFI5Bvq5jdjP3XaH2gJgVeuKaNZ/icS6Mn0NWpEx5SlbtTPmpG8zRDTeySOKTFldek12eNHOKUcG0wQ6wl6DcDLHhW62dvNCwkZVf451SoMGX6OukheRJVSTrbxg/ohNRDnER0o842ZYHn0sRvAYLPDtmgYLigKmoOyCFJ/BuO41MDv8MSeeIg6HENrDhKF8TQSahaRtXR5f7ZbioaB2b3Mex0NrbKeKpWX+AJaqvcavWBcY8977n2juICTkXydYc//HG72W12BTSWyg6K0qQZSksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8)
 by CH4PR11MB335913.namprd11.prod.outlook.com (2603:10b6:610:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:30:30 +0000
Received: from PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3]) by PH0PR11MB7522.namprd11.prod.outlook.com
 ([fe80::ba5b:e8f1:5eb8:3ca3%2]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:30:30 +0000
From: "Mekala, SunithaX D" <sunithax.d.mekala@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word
 in igb_set_eeprom()
Thread-Topic: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word
 in igb_set_eeprom()
Thread-Index: AQHdReLRo/ViUveT00mts/pPdKRM4bcbUvtA
Date: Mon, 2 Nov 2026 17:30:30 +0000
Message-ID: <PH0PR11MB75223DF8615A173566FBBE1EA06A2@PH0PR11MB7522.namprd11.prod.outlook.com>
References: <20260916135254.1016847-1-xiaolinkui@126.com>
In-Reply-To: <20260916135254.1016847-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7522:EE_|CH4PR11MB335913:EE_
x-ms-office365-filtering-correlation-id: b541fe99-a9c8-4f65-19b8-08df3906fde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|921020|261102123227099003|38070700021|261021121427099003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261022115727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: OmmNU9gRMmz34QAkv47qsSzqydT7ylk3xh+Lp0PjtLjOtz1NErb4MusqJCDur7VBZf17bTS010vGHawtionbinSKzBZrha3EupQdcoyPDlj2xnCt6ieWQiOB1XDdu5X1EGenhvCMaIi4JrZ8Ino0zEEcvfRVygdMO6NxSyIaKtCi09+x86R6zXxr5beu7yLfVnNZGqhtCkxnTzKVwq59MXiakB79Ccaf9p3i2lHmLHTAhzCTGL3OZ2pbzRJbBQIuo6K5HeVCu3O5dovTY6AemFct+LkqYRFsNn9b0eQ182aR4KhKZ+2TuQNcg2mo9bxZbCYjF02Hhbbq8ayh7zeHrEcvhbNb+kMiWV6Slz1Iwj2ZaBkdXDAWHUuM8156acTzCT4FcoTOpZFJL2ByYjfluBE6IwsSHyl0A9QMb7wGBpBj/K9lslMtl630eWqfrAap/JOiMq6oQTAAj78aUnYMFMgK4vI7Fow3IgFgVmUqSCS961gSvvzaFaV9bmWXGAta7Wscgj96NhPiFzvx8rmltq/3y2WylMzsVNicNH0bvbpv0JpVwYRM9Mq3AoyGInpt3s3AuBry/M2uRt6miZODgSDjKLFmzjcBsTUUU4tJUnVWD6BGRYswwshBxWSUIrVWbkSi1r78K5OKrJiTZYR0zw+zg8LFSF5J61Z9vGTxkwp5J2uy2BgV5tSpdrmkz3yzBZUUn1QGrGD2pB6d5H2oFxSN4tATe6m9C1DnDf2V26SJbXZvxBgpcfExySNhUIQi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(921020)(261102123227099003)(38070700021)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261022115727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CQbFvGqUmRyfRoQuM5h8tfCz/q267fOB9hh4NeZU1m5w9h420DJZeo/QWVkM?=
 =?us-ascii?Q?p3zfnHQLUVONRf4o5pa+QvTmkenFcPAgltOhEVv02hL7PgLM7wpTpMb+hb5x?=
 =?us-ascii?Q?nQmowgSf6/QYoeAkek6GWNS9ubsQV5+WySWsq13buiwxmsC9HFMPw8whc14R?=
 =?us-ascii?Q?VTk2W2vU68GGGuDsmu7X1twkrwBwuVYPj+fSwDpKCUzLrDhIWE/KpY4qBLYs?=
 =?us-ascii?Q?Nbb9Tc8a6mC/AFWeea2iGoE56/hgw2Q7B2csWVUPg24wxXqMk7mvPyx1FXi6?=
 =?us-ascii?Q?/lq3lobPLHFKwdkWXyVutFytNY7kMhfsVc8vYCPdfnC3j82tii5JPgK317oc?=
 =?us-ascii?Q?TLbnp0rSIGgovktc9fNMqQEoeTBPTRNbn2P7I+MKtpr21U77LrJ6BNJaafQY?=
 =?us-ascii?Q?+OR3Bpz+lDZRujHu/m4wEq6lTkNReoQKAb/hYT388WnqurMMambCrITWnzqA?=
 =?us-ascii?Q?FBgB54QAf9EZid41g072UsCZMzjdenb4ogNeOcFqGeBepY/PgmkxPd6cBPYg?=
 =?us-ascii?Q?h977i8vEmjrPrbBfwNeKAc+xsPKQuNkWPiRGCkxVYcXhzPqGr4mmZ6jqWyBT?=
 =?us-ascii?Q?M4vo2VEHaZM72Jed13ty8FcgxUDAKBsCnZy7IKwmFsJn077wg7U+TjUDeVdw?=
 =?us-ascii?Q?Q39KqiPrP/jhZ2dGY+1VSWwVWW1C+nWeOobWvCfEavdO/UAWVC06bap0WLXf?=
 =?us-ascii?Q?sjjxzy5UvcCJNgiCQdugquc3U3qq3G3Y+eSl8hjuX5wM9V48pKnV0gd7icV+?=
 =?us-ascii?Q?euZJGrl8PrRibsGMBWTc15AckosfbnwszlJOrN+rg/e16qOViV2fSsf/dnSm?=
 =?us-ascii?Q?4omYD1on2u1EZHVbJHwu3brvIceMzsvmU6KUVkzhVm7URqQnYRxzlwkRoEc/?=
 =?us-ascii?Q?tIFQNvFpeLtopG1ZrIWodSvyKGIaI2Zx2rAgMO3qG7yDbRweMoUz2ROQIhLD?=
 =?us-ascii?Q?0H3QfvDV7auG8d/1n2tm6uZET12zFAhnCh+ulaXz0lRiu3UyYuKFWW81gIm8?=
 =?us-ascii?Q?4A+gGr8mOObJ7XqHeWRQah9L314tipQY0aBpXta1/loXEyFgT0wJrzjY1zcS?=
 =?us-ascii?Q?JkbVillx9lDBezL1bXctVJq15nc8ZpF27fT32lD2WVeDk6rxNDrPYcv2H/D3?=
 =?us-ascii?Q?5hJwTEeemIGHpFYV2Z10/0GtYJ8L2cF2lafXBoKm6fA+6QQ9UTTyi0XGNWXS?=
 =?us-ascii?Q?aEjd0o3UfvIHyCdDjfcbUnVkjwJhgflJmMyJXT7W9S+uhBr//mBXcpRfT6Be?=
 =?us-ascii?Q?G3Qmhh8ye+VtK9SWtXY+7fIPaKvMuMaDRsJSzNrmFZra9wFk3vvqfmAyATsg?=
 =?us-ascii?Q?WBKSUkuMJblKnQn0wWicCokJLjA7qPTRkssMygIjJUxpEB6JA48Tdnrv7iLm?=
 =?us-ascii?Q?191kGjHQTZTkgR3JIqXsvZzSktYsBe7Sn7mc9nkaFYldZS7bNRLghtnB0yoB?=
 =?us-ascii?Q?hFJAPl3atpCF0gAt71mrfyXnN8TZ4s9hCvKUt9RgOkbCdQIyWYTuQXX+TH6v?=
 =?us-ascii?Q?QkPn8FOxOBJTdinTWNcS/vJxx3C2Zx9ZImYkBXH9Rs2wp1SXlQMeB844RWPQ?=
 =?us-ascii?Q?Eb7cuvO4ZXpSSJsm6VbPVqdxiWF4rxRcfZPH5catKRkyzaZp9eX5PRp21zyu?=
 =?us-ascii?Q?FIeN4ktP3M6vDT57zG0Ghj0Qcw0bB5/xiZWw7rt+CA/8WSbjDo5GcA4hFdNx?=
 =?us-ascii?Q?bV98qg/R8BGmvEJC+p4MQ9uTntrLDzJc6JCJd+ri+9Xcw9Dm411XDC/AC5Q1?=
 =?us-ascii?Q?5UcX44eTxQ=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: YLONiJiyybM12N0BoTD+aD9jiB+CUON5q4/gwHrjysZK4rs0Uk5lJU30+iVEhAFgudVpWDPhgfSMxuSR4nwLEV0e2vjhP3+meiI/8VIuDrpqYkGrTgUQgedVvwJqeQNPtW8jATnGRxV1KZOpWbxtYddImgE6xeSL7jidRbv9is1EpwNwzuW1sOHzywraEcAckeF0H6cEj4autnrCCpAAxNNk3IO+afQJhOxI5VdLUSvfxe9lTDk44+itcIvS9HR74rBHZU1GeCQH/hNIGRl1PQTkuE7NhuBw/+5o+l8QDRduHqnQBWmvs1WIaWPnQYfEsVE4YnOzmlsU+RlUd9/KQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b541fe99-a9c8-4f65-19b8-08df3906fde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 17:30:30.1666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AQtPo3VR7HPFCRhXxmdExaB6bcwO5Ie6iXlUp0WejZZSrLJJeiehpFUIjOIgIEFdzh5lj0ti0KaY1UDd+cpl5T7stTfwknE97kwIK2s9JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR11MB335913
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>=20
> Sent: Wednesday, September 16, 2026 6:53 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; >kuba@kernel.org; pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kerne=
l@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>; stable@vger.kernel.=
org
> Subject: [Intel-wired-lan] [PATCH net] igb: fix uninitialized first word =
in igb_set_eeprom()
>
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>
> igb_set_eeprom() does a read/modify/write of the first EEPROM word when
> the requested range does not start on a word boundary. The error from
> that read is stored in ret_val but never checked, so the function keeps
> going with an eeprom_buff[0] that kmalloc() left uninitialised and
> programs it into the NVM. The read failure is not even reported, because
> ret_val is overwritten by the result of the write below.
>
> The write is followed by nvm.ops.update(), so the corrupted word is
> covered by a fresh checksum and the damage survives a reload.
>
> The read of the last word already bails out on error, do the same for the
> first one. Skipping the write also keeps the stale ret_val from being
> lost, and igb_set_fw_version() is correctly not called since the NVM was
> left untouched.
>
> Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worke=
r at Intel)
