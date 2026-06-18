Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32B3B3C08;
	Thu, 18 Jun 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780275; cv=fail; b=XvTwZT72aTuuBFCLR4QDDGNTJfhTuK5d7Lc6m2+Pp6ZkpEtp9niod7RbafuVfd/x0H5r98O2RiXkZNir6rvi+aVUY9ASOTGNKGTsbdum9+pxfkZVPgCIRk8n8jg2SOyZ0AKWWYUV010NOlrrNZE65zi9HSuL5+umJMCmlnHzrOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780275; c=relaxed/simple;
	bh=b6RnM1AJNINGYEUcMFvpie1GMk6l4aWY9shEGYR/vNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ce1B6B/2YSvxAr7lteGC5XaWXhOwDaIyPHjZ7dNIuyPWWBedkFzPb3epDfxivBJJS5Z/Vc15kaGojK8BFLfmyqTHXNr7q7U7p2qLR55nCI3xGB86JehQEZNopMzaKCRT8Xm/alg+CdLXj2PXKP2PeG5+LhSEtWa2oXlQfPNxgjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pd8BV8AM; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pd8BV8AM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781780273; x=1813316273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b6RnM1AJNINGYEUcMFvpie1GMk6l4aWY9shEGYR/vNg=;
  b=Pd8BV8AM4kCLO6YcC+ECERvxsAdM+fGVeDLdeyzrW9zZGQif5Nih6/wU
   CwSgyqkfbppjLdnnCTpncxlSYiUSE65BiAqyAeHBj2Y2pOmjHpFWvdxmx
   xY2zLGNMi3Y6MgnLr3tUAJbuKfTpOPNDfP0X2pwhv9uJVEzdXrd9lAdIJ
   5y1WExjAqeTTvyq4kELE/XZWu49L3Wc/5Ps6IjDCMLnyt1YdbI+CL6PPh
   cO6b+iqwc306qIqfHAUgHwHG9wZHWARH/Unv5UQhJODcOd/M33K2iZCnU
   SzJX194rBjv0KJqB4LIIIFQzJMKP/QZZHAKTZ64Y4YZMVuQ/BSQ9HWh5F
   w==;
X-CSE-ConnectionGUID: 7ylMch84S/W1kkQJcqL4LQ==
X-CSE-MsgGUID: CiMr+9F1RR+sGCXA2/EK5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82379085"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82379085"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:57:52 -0700
X-CSE-ConnectionGUID: xgmyLqzrRuSvY2iPt7F8dg==
X-CSE-MsgGUID: +XZmIOgCQOKL1kTU74j6HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252654044"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:57:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 03:57:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 03:57:50 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 03:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqeHYuLi8cjF8PunDmGgYqKPqXxyfwmGkqoVYs16hIlPas4p9NhgoqeYh5bRg+brcKONCVD4HNQmVysPFwk0I08EYtlBi/Mbb0MC6OtFfavOn+Ug7uPXDqeZahtsGWl645ZBBhnx7KZmuSosgjE8J53e7CdSXJZi1bG6P4Gz8lw0xQelg/8SrfTQAjobDkgvutlpr7VxTZ8rHh24G1zo/IWPggsb5g2R1/c3C7R3QZfBa68BQf1VuIgAED7i/ew+wV6ibnD1PNzZYhALWrbeuN3YfinqoqXNTJnZzRlrtx0+WQ+axzDcCKM8T2Ouu7f/x5LmeCKo7JtpkjMQgH6k0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6RnM1AJNINGYEUcMFvpie1GMk6l4aWY9shEGYR/vNg=;
 b=CJ55Uj1SRVmFO5EUPc3hsFZNy26ElGS7Z0kLcZhScybkceRqwsClJ2QeR626i2N94qPh5Dp+dm4BgB7X1YBQlbornKl8j0M3Cvng2eUEHkhZ8onTdpEcxQrw6gyqayrVFtAR0ewjgtdWUCrDTIqqMbURxVX2ard/CQYgISNzhATgyASDLC8WMOKf9c+1A5WPY2sjk7mIYdWYRWJAT+SBY71EyL2w3NPE/sYG8qs9H2R+kKiohbAdfx65eRx6egopJdYV4D5mcQtvKu56R2Jx+slSNVox6Br7FkdJ3GkkDIi0Ks3Uswwl56mqRxEmXKbt8zlN0DoO5TUXIfnO8wnPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 10:57:48 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 10:57:48 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "yosry@kernel.org"
	<yosry@kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] KVM: nVMX: Decouple INVVPID operand checks from
 flushing of vpid02
Thread-Topic: [PATCH 2/3] KVM: nVMX: Decouple INVVPID operand checks from
 flushing of vpid02
Thread-Index: AQHc/dncm1KZhoiqmUCpSqb2mf9t57ZEJuKA
Date: Thu, 18 Jun 2026 10:57:48 +0000
Message-ID: <3551571b85bc94a7b0a9eaf9e3c5561e46c5423f.camel@intel.com>
References: <20260616214652.2157032-1-yosry@kernel.org>
	 <20260616214652.2157032-3-yosry@kernel.org>
In-Reply-To: <20260616214652.2157032-3-yosry@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: 66147479-d7e5-4765-d6d3-08decd286f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: fADM/LYJDkzEmMdBETBGoSsN/X3c4qjOYobHB7LycnK5QQm54Bw8MHPvdZmJsR2WlHodh7JHiwXeATayE+bHcoelktdhbQBAbiIeomQBtH2OypLAifPmfhA2IerhObHg1S16S/9aX1ACYLJJlC8BpcxewONrdXVk+Lxx5hlBETSupSuKuw1iedo4f5t9BUDnMK4Ehbr5E21YWCMff+l8Z9hec97XINJJcklFid6MbKw5a9f2WhqUR+CNZ4jAOodDEQFOsXIsAajLDbw6WarLRQRjxtp5Haj/YaD1YYwGDdpvy7AecYz+6B919+pDUkr32WiEAHVWzueg0THt1kafoBV2szyt/5/kFUJMEJYHgvkKSGZILGgXodwEatEeVeykEZqs/tlIEG5CwoL/IfE5gLh4x1kHKV/toALqq7oc5vTzF+VPz8UgsjfQe7MRJkDdZxWyZVBsJ/VsewNikeMgarSPkH+umE5r9HOt/+GEmy0Z+/fQdNAchgaBeC5wCvHn7QeqW895s+r+CNcYoCNQ+b5ssW+uL9S5bFzF68KQ+MRwIZLnfD0tIvs8npbYl+bdZI0ql9/ZR7mKUlhCawxxkJKh5ZsrqVqzFZyyw9nUnOtbIKAo7b458v0k7oISwMZq/nesyh++leV7SU7IAkJD+kmiaGsdxtgpE1i6yGvN0ev+YUmWOI3xQLIM2EqM3l5EC7cp1NSJIgeGnOHRJ3Tt5kD3eO56T7FjVSa3Sk6fLLN/mSdLRx0I3b2ALFraxVVD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHNmOWhvclNaaVRqWm0vdmM3SWlrQUcrZnFlMTFIL3R6TjM5MEpIV1NqeCtk?=
 =?utf-8?B?bmpTdFMwVm40VHdSdXlpMU9LNVF0cnFPc01BVzg3MXFqT1Bpa2hscjNJSFNG?=
 =?utf-8?B?dVB5bWRmclRJSCtrSkdubnpzWVhUK3BkTmFhL2hJVk1RUkV6eGJPWTI0enhS?=
 =?utf-8?B?QnFtcXU2L1FHNlVBcTNncDV3alIrbHZvT2hwMVptMFpTK3h5enp2UStHYW45?=
 =?utf-8?B?NytjbUViZU00NWMwMW14d1NHTEo4LzN5R1I2cEhRNkYwOGxyUXV2dCtFK0J6?=
 =?utf-8?B?anRJQUtxbytTRkU3K0ZuZXU4VENZUVZ4QWlqSGJBY2dQMk9UZ05ZSGVpc3Rq?=
 =?utf-8?B?VFdWeExBZ09rOE5uQTh6RS9NUGJjMmJsMW84UXowR2dXTmo1cDJXZThPS0du?=
 =?utf-8?B?L0xmNHZjUGM2YU8reTBCWkxpMWVnaEs4bnJDSHhzNFpkNlFGbnlJbHdLdllG?=
 =?utf-8?B?SWIxK0tQRFJBSnZlNGdmNHQ1UVJGZHdrMmZ1L0l2TWk3a2NHeDRsVHBBR2hy?=
 =?utf-8?B?R3FyVTUxNU9ZUlIxeW14RHMyR29OV1Q1NU4rb2NraENaVGN3WHlnZ1VGdmhO?=
 =?utf-8?B?VFR3Vm0xVEF3cW8wZXZEdXpBelNqcVFMeVNNY2ZKclJNK09SaG1EeC9pOHYy?=
 =?utf-8?B?c0oya2xWcllxZEh1OHZudG40dkR5MndTcThPMGtTOFlIc0EyVFJHR0QzZ0FL?=
 =?utf-8?B?Sko1SGV1N3kwdGQ5OUxYczJTK1VJL1F2MWtmUk9qYSthZ3Y5cDhaMWlJVlM1?=
 =?utf-8?B?R21xdzZUbEszQmdjSk9QZ01Mb3BHckJySzZqN0ZiSDd5TG1UNGthbUw1d1Zz?=
 =?utf-8?B?ZjNEQ0RtRFhwNERyZVg1K1o1MjRWY2hQSnVvRmxwQTFxTnVZVnJFUVdXRlls?=
 =?utf-8?B?ekRUNzczeklINTJ1Q1BCUFZ4RzRpbDJzK1k5c0R6SmZRL2JOM1Rnb0lpZU9o?=
 =?utf-8?B?U1BTVEcvdHh2dEVKdkxUNFlmbDFYbFMyZ3BxMlVKUDJEYzJKcDEvOUQvN3pZ?=
 =?utf-8?B?ODdXaWJkeFd4cFJrMit2ZnVDQU1WRFNoSVJpaTY4bEMyM3gxU005eTIrUXo3?=
 =?utf-8?B?QXNZKzdPQnFqSE1CeFBJVXlxTWZYTU1IVEFaRUl1NFdoYlJ4cTBsZE9RMzFs?=
 =?utf-8?B?K0JMNU1FandEUUd6MmVTMCsvU1paRkx0aS9qazZ0bC9lQTRYOHBSMDc1N3l5?=
 =?utf-8?B?eGNkYmIzN3RuZXkxeXgySGJvSVJQZk40QlF5eVAvMlllU1Rzd3hnUGM0cU54?=
 =?utf-8?B?QUN6QWY2T3BLNU1SL3RzSDZtRGZJYWpMWEo4eWlhdHVwOTV4NW9sSWZ2T0JC?=
 =?utf-8?B?M0pBVThoK3g3bjVuY3kzeitDL01VZ3M5Y2xWdU1JUmZpOGc1Y1FxaTRlU1ZG?=
 =?utf-8?B?eXhlUVB5WWVKeE5yT25tbC9nR290elVHTFdQYmpHZTBneGFYWWxpWnhOT2Y4?=
 =?utf-8?B?L1oxaWp3em91TXhRVHRJREJ2eGd4MEYxTENsV1NoeDFyK1hrK1hJSTE2b3I4?=
 =?utf-8?B?YWNBOUlJaTYxa2lhQm5ud3BpSlBhY05udU1jSkFxdE14S2g4a1BXSDFsY3Bu?=
 =?utf-8?B?a3d6U01MTkFlZm1GdVcxVktHVmJTelNnL0EvZWphMUo3bGRzbzVzVmZKZm83?=
 =?utf-8?B?MEZ5RnYyR3hzdEJ3N1RsaGdzYXVERURIbExYZDg0Z2VtczNhamduQVc0eHhx?=
 =?utf-8?B?NEhlVUlWcFlUaEdaV2Q2STU0eCs3aFRFR2pWSCtycWQ4NEorWkpsbFlHcHl4?=
 =?utf-8?B?SnRDZEVPZ2F6RzZWUjMvblRnS0pVQkN4WUtOaDZPeWJVaDFBcEVaWmVqVDNI?=
 =?utf-8?B?cmVpeEhXc3JyTjJqNFhWa3lzc3JRQlU1TVVRNFRJb0IzODhKZUFjYlZMVC9n?=
 =?utf-8?B?dDBRRHNMRVVSSHBNUXhDOHdrY2YzTko4T3E1VjZnZnNUcWhpMTRYQlFvbXFU?=
 =?utf-8?B?V2Vkbld5RUZIVm9teGF4TWVLdkFTWk0zdjhHWkd3SjJCbUVxMjk2blJRNnFa?=
 =?utf-8?B?cngxZXE5aFpRYm1kYVhtMzlEeSs3ZmdGMUVGeW9YZlNSeFNKQm9UaytiQVRm?=
 =?utf-8?B?Mm9SVEFvNHpiL2dmdUhLQng3R0hvWG5DL3ZqQUwrSTBLbEJ2VERyUjRNZHpU?=
 =?utf-8?B?dWpIWTRZelZIc2FVR2NubjFTcmlyQWc3VStHaCszMDFrS2xpeVoydmZrNWRm?=
 =?utf-8?B?d1JuWnh5ZVo4TCtFSDNGZDl5YzRlN0NZU3hDV2tFMDhlczg3a014STFkSlhC?=
 =?utf-8?B?Y2k0bVZZZFV5c2IvVXBjSUJwNi9nNEVqVmYvaTZWbVNzOGdXNFd1MW1yNXBw?=
 =?utf-8?B?bFRLSlh5cjNwWXB1cEpPWitTTEZwd0M0Z28wVmdRYUlLWmRxeVRYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4964DFF4BF5EF84E9BE15DB77B2F225A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yn5R3tbqX2HLor4En00JeIsu1B+qvwqI5jfUyuII/GD5bbe0ji9vCFSuYtr1bAh8MWfiI4k/qPehpOvu6WgsCz0NnQB54kj/kDFAhNgBlNgTD/FlBt4jghJLZsP1PxDc8DB2IMo1UvsbZurXepbRo4h9L5NLlFbyVv4iEydLLIjaufqrw7rRn5gYbedwvJutx5UkdCDftos5U/NKicuvspGBL7lz8nFTmWQM0TLkKXzbu8XNkvmytBHUsJpHdmPlqQb7SOlXq75suv5sLZrrlNduPDx1asXa/qI3+jRMlA54lwV00U5kUZXpWHqNtGV2T6z+NStiZBqhCVoSC0vkcg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66147479-d7e5-4765-d6d3-08decd286f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 10:57:48.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEZUO3K1L0Ils79Z9uu+m3Izbf2tohYB1z35dJ/pTvPbW9BdjgLUKjNooKgEDAiEl+RCLOb54IlHW4KaI1Z0Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTE2IGF0IDIxOjQ2ICswMDAwLCBZb3NyeSBBaG1lZCB3cm90ZToNCj4g
RnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KPiBTZXBh
cmF0ZSB0aGUgSU5WVlBJRCBvcGVyYW5kIGNoZWNrcyBmcm9tIHRoZSBhY3R1YWwgZmx1c2hpbmcg
b2YgdnBpZDAyIHNvDQo+IHRoZSBmbHVzaGluZyBjYW4gYmUgYWRqdXN0ZWQgdG8gZG8gdGhlIHJp
Z2h0IHRoaW5nIHdoZW4gdm1jczEyIHdhcyBsYXN0DQoNCk5pdDogdm1jczEyIG9yIHZtY3MwMj8N
Cg0KPiBsb2FkZWQgb24gYSBkaWZmZXJlbnQgcENQVSwgd2l0aG91dCBoYXZpbmcgdG8gZHVwbGlj
YXRlIHRoZSBsb2dpYyBhY3Jvc3MNCj4gbXVsdGlwbGUgY2FzZS1zdGF0ZW1lbnRzLg0KPiANCj4g
T3Bwb3J0dW5pc3RpY2FsbHkgbGV0IHRoZSBWTS1GYWlsIHBhdGhzIHBva2Ugb3V0IHBhc3QgODAg
Y2hhcnMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRlZC4NCj4gDQo+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJz
b24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZb3NyeSBBaG1lZCA8eW9z
cnlAa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVs
LmNvbT4NCg==
