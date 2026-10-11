Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90735C68E;
	Sun, 11 Oct 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791710593; cv=fail; b=m0thFq0Xduy58CWKj4J1xybDl/A0v+pJMZr3S0BUO83mp0jHXHcqzIh1x+KiKLQ6j0n3gzvkiyrziwwnLuHsMAatm/JqSFMpFOt/lAONzFtL2dzugFHVb5+PNXHZtsmmKC/M3PGffYxNrjk1JLIWVOwwWnpbR8YdzTb8Lul5ExI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791710593; c=relaxed/simple;
	bh=OuVrlMsJQn+ZyDC6DFgikA1+Q5ZyBcXxJooYBj6QTlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDwxbxHGXR7/OLiYMaeMuSFlGMPI7MVeWWpgvCNYz2a3UZNWGK55F/K3tQ4MnQFN/8QmvVUPCAqFiYuKTHPXk4QIL4eUxdu3JXqXeUg9Qz+EncgpMbjMXz0q2a1oHpa95L8NH7ebRhjfP9TnB109xvcW1snB32+717pc31gb/w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLir8q3O; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLir8q3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791710591; x=1823246591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OuVrlMsJQn+ZyDC6DFgikA1+Q5ZyBcXxJooYBj6QTlE=;
  b=lLir8q3Of9h+n73KbTpfr9xdo5T/y/cIvbRqJBCv3aPct6C4G5MHnB0Z
   5s+WNxezSTMN2FdQ0/OaFAYFgRDZbAxdV4HkznK5axIEMSbpGADWVzTjT
   anF3ux8Ry0asHC5CuvdaXVwTvlLLXRMjU5+k8nguxah3+LJ9+pcZlZxAG
   M1eaGZNwcDLN9RZ1gRN3M/UANsIgQWtTq3LPpoI21gvxcF/Q9aFKNp29t
   7wh4x34ZOgZpFbv28ysPY5WYoPv/JWOIAIjXZZmDOIN3GjRC5w5LfTcWE
   ksTOz/SO+2jFJ61KyXg8fn3PG20yFjH48JuZgPKcctPs/GtqTywXuZlVE
   w==;
X-CSE-ConnectionGUID: MO93yBhMRLq2y4GjRkOhfg==
X-CSE-MsgGUID: U90reo2XSVyUZNM8gCTFYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11931"; a="344606"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="344606"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 02:23:10 -0700
X-CSE-ConnectionGUID: bchRfWP1TvWscPPRB0sozQ==
X-CSE-MsgGUID: 9yyJ66/WTACNAzNAZssRWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="992755"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 02:23:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 02:23:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 02:23:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.4) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 02:23:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goEi48ZPJ1UrXAuQOhDSWfovrP2TnDJaQCZ1Y9V785kSnUEHcFVxqurtQaGaxikgPTnkvl8KnZ4QKMSkId9/b9Qq+d0P2VqBsqXg6l5ImUJ9lp4ikakRhvSLZvESMmzK+Ee7qjvXRfQglzP2iUt/T3bxvUSvMkda4MqNgQwwaEjYAq5CdURAv8xl3rWeaVc543h1bkgecPMzVfOzAW+zmLhaXWpdk8jWApy9BPt+bW9+PFncaRQ7mlsgRuHRBULBFawUqt0/9O2yM5xWaMKYiW6fporUIa0II1efpq6I6dXVzLnz4BLPE0KArPbgFICvGou/BYhcZTIa/Kay+vZqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuVrlMsJQn+ZyDC6DFgikA1+Q5ZyBcXxJooYBj6QTlE=;
 b=wfS5Dy8xJHQcAvIt46IOcTRUYKAUjA1aEq38Vwx/G9fM0ghQ0tz6p7swwAB9n1b2RJJ7Bt3Ct6wo5l5NxpHI4zqqMhb6Zepk/txrGhi+7QIW8kSoZEj8YXS3Uol74Wnk6RuRqrCLNsCZAAx9+LYXxjd09rt6AwG/H2n2OgnESXPhXPABGWBV7jhTB4caoE6YOxk65t8T4e0GCe+enhX2Iq5n0Ksmxs3BRTUZ00CduBVBAq1C+/azqvGqwIEwIKWPGKnEiZj3Di1rQJjZyfRP0zb2ge1kS3maWeGr0yX3wZzxLfr5eDGyhXJNeR3u8bHfxjm7WvxhcGDU0h2R8i4LfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPFE241D7F14.namprd11.prod.outlook.com
 (2603:10b6:518:1::d57) by CH8PR11MB9505.namprd11.prod.outlook.com
 (2603:10b6:610:2bb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 09:23:08 +0000
Received: from PH3PPFE241D7F14.namprd11.prod.outlook.com
 ([fe80::4ea1:23b2:56c4:3c54]) by PH3PPFE241D7F14.namprd11.prod.outlook.com
 ([fe80::4ea1:23b2:56c4:3c54%7]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 09:23:07 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Adin, Menachem" <menachem.adin@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Joe Finzel <joe@sudmix.de>
Subject: RE: [PATCH char-misc] mei: me: Revert "mei: me: add adler lake point
 LP DID"
Thread-Topic: [PATCH char-misc] mei: me: Revert "mei: me: add adler lake point
 LP DID"
Thread-Index: AQHdWUnm/TO6zdKiAUO5Z7DM4xA4Jbb37qsAgAAipvA=
Date: Sun, 11 Oct 2026 09:23:07 +0000
Message-ID: <PH3PPFE241D7F14B2822C509470D836EC5BED902@PH3PPFE241D7F14.namprd11.prod.outlook.com>
References: <20261011-remove_adl_lp-v1-1-177758bd617a@intel.com>
 <2026101122-immature-endurable-3ea6@gregkh>
In-Reply-To: <2026101122-immature-endurable-3ea6@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPFE241D7F14:EE_|CH8PR11MB9505:EE_
x-ms-office365-filtering-correlation-id: 19a5eee1-2add-4285-7f94-08df277942fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|23010399003|376014|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: uIP/cIheHJYcRyBj/Tn6r8TQRmt6UXt8r/gTTIPfe2c89Oi2V8UAlSWRLokR04XZ7gFoxankRGGMUQL2INBZyuFfi8MBZFAk0QlcU1+XW0tTKluT8hztR24c3UlsV4O5gezFHfq8G5JZ0/FEZ4/eoVBXFbi3j9X1a5mMNHp1dlzd40ZMqhA+n+ph8WCBsY5Ar1eoub4lki8gXW5rK/lvMb1X16U7xH2BnATTK3cDUInJvooVtQcVx47Nu3Scf2WxLr80irwfeJJMvX/aUrrtU5ttK9xhO61PgE/L9tEEqF1HcKkDUbcu46xwLflJdje4UXtPwvqx3MyX8auTL+ISAGBtEw2PVZ5AIuFsibok+T5b/orLz/uHB3pUVmctfAzMF11cxqDcL2GRNNyxbVswk8yWMJ0nT65CvC+eEHXF5hJGrHlc5qSGsIn+Me0QRP09aHlO0KzY0+kwxBEfwdx0tzEiRcMglKRFC1LQ3/O8l3g2tcL3ZyM4wN5Tppn5E9E+ooEX8UR5GJ0S46F4ppj81SNqxxWj8mqn3dGDSoG8QEYD9mAj4+ROu/CuFnTyNXFsPFskGBC9en9NQJloMCiggbyBcGalKfzZPAfSw7htLih+N09qnRWUepPAeXGyj6xxUHZthSm93ORElOhPkgXH1xM0Y14roZERD4j+RJNgczTkBB5i9y5YxF2jlU+gZEQhNducwXDHCGhLs3Hq9yHc/YIxDJXyya6SXZpIgVm8K28=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE241D7F14.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFJscXNBZU05QXlQNWQ3bkdMZkQrNnNiTTdCOTBJeHEwRk95MVhyak5xeFFH?=
 =?utf-8?B?ZXBpczNPZWtwY0JVTlRnTUcyRi9ubm5uMkJzdFlSZGd1c042SFpoanZzVzVo?=
 =?utf-8?B?TEU1Nyt1OWlScEZ2d0lwaG5LVG5CenZOUlVZdEpYRUtRS3EzaHYwZ1JxbDlp?=
 =?utf-8?B?cldrYnljRHlTQ0sxd2NnTWp6TVdhNDhXV3RQZmUvL3JkSHk5Y0VRdG9lWUNM?=
 =?utf-8?B?ekREZjBFODRuL1NFckEvTExlMUx5T2dRTU9xKzRjNUJESWFScG9qbDRRTG5h?=
 =?utf-8?B?Y2pUdVR2S0VMNGJZOE01Z292OC8zd1llVis3TGRJMm51MlhsMFNWcnlCeEt1?=
 =?utf-8?B?VGprMGM1MnZMeDVXd1JOb0lNQjBlQm5YOExpY2F1UGY3NkxQeGpVUzMwMmxM?=
 =?utf-8?B?VjRTUUlDcWxyV044V2xzWWhvQk9nMEZUN012cjd0YnR2S3dNQWFRMFYwd0V3?=
 =?utf-8?B?b0xkRE9Wbjk0L004MVllekt4Sk8vTW1VcWtTdEVWRzVNYUFVMll0eDR1K3l6?=
 =?utf-8?B?UGtuVXZxeHdDZXdCUnNuc1JxK28zazBFYmtlSEFvYldHZ3pNbURDOGVqQ2NB?=
 =?utf-8?B?K1A1S2FtalJxamNtRzFHZnhpREMydTNNaEp6NTZHeXhmUXdEUHhFMVN5NHZi?=
 =?utf-8?B?bTZpeVFZUGtqd05IY0JicElpMHY3RUVjc0RBZW40RWR3TkVHU253RFpaN1lI?=
 =?utf-8?B?VG9FcFRBS09mcFZhemZITzZRdjIvRGJpdzF3TDZxdERwV1N4NHp2UVdtZmd1?=
 =?utf-8?B?QWFHUG5Nd010MGdBSG1kUEZaRlRjT1lSbTI3WXFDK3F4YVZRWjgzWUZpcTMr?=
 =?utf-8?B?WTBOMWhnZEFEcGYvb2tLcmJpTE5mQ0hqVE1LcmM2Wk0zL1JBMnB3QmFZK0FG?=
 =?utf-8?B?ejRpQVdlMVVGTEJieUNXR3h5NzdoN0VOLzR0dk03aWVtNlBrSHBqN1RkZm0x?=
 =?utf-8?B?WGJWZkZ2SnpQSHZyTkNMWU1UU3FkTjRZaW5zSURHYXVTakh3cU5GWDY1TTFY?=
 =?utf-8?B?NnNMQjlHYUFQS1Q5THd1R3RERzBLd3ErMUVDSFVIZFZEaDV3RFRDUVY0SlJp?=
 =?utf-8?B?N2NST0lRMGlKVnZWZHR3R1NrdTVxMkk1dkN3VENRT3hvaXdvdkcrcTQzYW5M?=
 =?utf-8?B?QTVxZjhkU2plSWNpbWhjWllZWkM2V3NkWHZIdjg3UHNUNkJPVzJLcWdMdndQ?=
 =?utf-8?B?SmRNRks4amhCTWhRMlN3MWZWZ3lrUFBLL2VPalgrZWMzeDF5WXRFK3UrYkNs?=
 =?utf-8?B?V216bEcvYVVsd1RpbWREOG5HRzBtNnhjM0hPKzhjaXdCTUtWYXZWRFpjSUhT?=
 =?utf-8?B?ci8zck5rK2xDTnRNKzduMUx2MHM2OU9idTFuZEY2WHdTK3NTWkFmWjZJcFlH?=
 =?utf-8?B?UFlQcVAvRlRjcDhrQUpseHhsRFpRdXBwN3RxVkx2dUprYWtGaTVtNy9KclBh?=
 =?utf-8?B?am01RUZFSGhXK2c2ZzZaak85NFV6dXBTZmxqY21PV0JONFEyTkNZRlFPc29U?=
 =?utf-8?B?Y25nVDgvVDl0Vm9KdXYxL1hmQXhlZ2FWSkRwQms2eWVWaEZrS2tCc250emh4?=
 =?utf-8?B?WjQ4dmRoYkI2TmhVUms3TVJZbWVpQ1d5c0FlaVR4ZFRSQ2RTTkFBOGd5cE9w?=
 =?utf-8?B?TVRYSHcrY3JDcTRvT2xyRmQ1dFhWZjBScWpGbjFJOFpGRUtIMEpzbXhtRnpq?=
 =?utf-8?B?bjJhbVdWWjFlbnl1Y2hQTlVjYzZiQ2xDd05JZFpRRWZzOWFUcENBcU1KMUU0?=
 =?utf-8?B?UXl3Q3FnV1pqLzVCTjRBNWJnQmtZQ0ZJa01veXlaYU1xOFpBbTg5VDJ3WDBa?=
 =?utf-8?B?cTBDaDVyaEFqVDhYVENVYnluQWhpanZsNG9YbWE5MVMzbC83RjJub1UycUl3?=
 =?utf-8?B?U0dGUXZJWkV4ZVlNRmYwdlhxL2pka0RHK3pzRnB5TmpRRkdhUmpNb0kxS01o?=
 =?utf-8?B?ZjNTazBUMHZ1WmdObDBabGdHcitPSWxTcWxqWm8zVlh5SjE5QTVTdHlTMitV?=
 =?utf-8?B?czZ0NEkvVXVWVEhieW8vY2F5TWNZbGNOQUF1SEwxYXFxSmtrK0tubWRQcjJn?=
 =?utf-8?B?RE8zbTN2ZXBjcFdMRGJBdVN6TVhZRmZJUk16dE5LN0dQS1VWVXBEK2wyN3JQ?=
 =?utf-8?B?YjU3VlRQWDFoc25ncm9PSFJ5dkNyWVVYck40M1dRY0Y5L3g3dStDZUIrYnVU?=
 =?utf-8?B?Y1hQUXVLbkJ5ZmJ4Z2hlQ0phTUhHODN3M3VUTHFtWTdkS2lWV1dOc0tOcjF1?=
 =?utf-8?B?aXZnTjFGc2RwaUovb3hkSUFDand6UTRLMUZZRUtuN29YSDVtbHhMblMveGgy?=
 =?utf-8?B?TTd4enlBV2VTRENFa0tmMW5PSlNqVFc4MWNpNGJaay9PYzR6ajQvSm5HVE51?=
 =?utf-8?Q?+rQ+NHwqCs39BxXWjNk2n+Cg69NTEgG/9iIpfwjfahnvM?=
x-ms-exchange-antispam-messagedata-1: LM599SYwgr0q4A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sH46uX6pD9gerJWrcq9kiNJj8udcq5a8VpO9LeIWGIF/bcHf5jSqsnvyJ4zHgNx/AH8l6xpYiHXvG92o73L85zqMHV5p11zyYOvZc4kV0ZgQlQGpxxkcJ/ZSbDPHEDC8Mcd3Z4AZ33M/YQy0qOIoWX6z6GbtJohKiipLqOc6RcqM1Lcj6h+CQv6Q3SR4brFW+OgiEZo7MGNXY2P7ip/Znttbk1adakZGICXmtTISKeidTbQt2gSfaGU3RrrbB5Z2gsKNB8ygvaX5wze/sdpU233VD1NiRhJpKdrVAf+xrVSA/o/L6mGHVKAWAJl1WIEbmdWXKoHW5a9ju+9EgI1E5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE241D7F14.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a5eee1-2add-4285-7f94-08df277942fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 09:23:07.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /f7bLRWpflqmdC7wCgdeGCn/enmcQnk15zpX7x8vBGwGQ1jZdETmrPiohzK8MJUeUzxLbvjM24UT+kPWDmRafDmkidfqhHmYwFQIE7YhwU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9505
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBSZTogW1BBVENIIGNoYXItbWlzY10gbWVpOiBtZTogUmV2ZXJ0ICJtZWk6IG1l
OiBhZGQgYWRsZXIgbGFrZSBwb2ludA0KPiBMUCBESUQiDQo+IA0KPiBPbiBTdW4sIE9jdCAxMSwg
MjAyNiBhdCAwOToyOToxMkFNICswMzAwLCBBbGV4YW5kZXIgVXN5c2tpbiB3cm90ZToNCj4gPiBU
aGlzIHJldmVydHMgY29tbWl0IDkzMGM5MjJhOTg3YTAyOTM2MDAwZjE1ZWE2Mjk4OGI3YTM5YzI3
ZjUuDQo+ID4NCj4gPiBUaGlzIGRldmljZSBJRCBpcyBub3QgYmVsb25ncyB0byBIRUNJIGFuZCBh
ZGRlZCBieSBtaXN0YWtlLg0KPiANCj4gU2hvdWxkIHRoaXMgc2F5Og0KPiAJVGhpcyBkZXZpY2Ug
SUQgZG9lcyBub3QgYmVsb25nIHRvIEhFQ0kgYW5kIHdhcyBhZGRlZCBieSBtaXN0YWtlLg0KPiAN
Cg0KU3VyZS4NClNvcnJ5LCBteSBFbmdsaXNoIHNvbWV0aW1lcyBiZXRyYXkgbWUuDQoNCldpbGwg
ZG8gdjIgd2l0aCBhYm92ZSB3b3JkaW5nLg0KDQotIC0gDQpUaGFua3MsDQpTYXNoYQ0KDQoNCj4g
Pw0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
