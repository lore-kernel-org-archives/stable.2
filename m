Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6449391842;
	Wed, 26 Aug 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748694; cv=fail; b=LPmrHPg6b196YF6e5zmPChQAXZDaK/737k02jEwPhZ5ocsKDY6twG6Thix9JjJJ8e4gXLsFhB6uiVkEmYgK8o60T9u6T3NWCyuJPBM0i6fQF2NZPcnjSIZGQczPVSIcDbyHwpwrmzJOu8aSHck/tmGMOjKCk8wazv8saEeGN2WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748694; c=relaxed/simple;
	bh=V2wqeoZ3SkrfoUGPjKcJ1XCusNNGlRny3w1+O7pcGU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSOMP0zQI1NfqK6EWHRjr0XcXve85t0KGgGmlVSlxJVG1rXT7lgFKBe5BwV5IWG/s54lvmO41vgidV+LQIk28FYZIUPo55UHLNVXlMlvkxE5nB0e7UuoawUIdq7qmQQ/YrBtqV5Vt+l+ba/BBKhHDZvx7RKCvlrDoXabpXQxNGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDA+1aJX; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDA+1aJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787748692; x=1819284692;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V2wqeoZ3SkrfoUGPjKcJ1XCusNNGlRny3w1+O7pcGU4=;
  b=bDA+1aJXQdMu2B0QVWksbsEjZZDWy6RruxB11p4waMQhsXtSj0dNT47G
   DbIJE30UIMXRqh1A6YfQKJGsKDGVzAXTQxDqbpMboNVnEb8eTBsU3h6iU
   sS1Ppz6MZEsD6WQpon965v64fGrbi4uHu4wArN1A3pM0MSHAwphSYyNUu
   Nv1yDJlHspqCAZnl2ElF8F4e58uOQQSHvLFPhf1xhVKPfed+tJfLNNJaX
   /WOI0Lfo0nOH9fohL35xJSqo+ZJ18IuBtSQp8JY3M1PzSFxcbYfEMYsBV
   bwj7nBXE6AVsQ83T4soPfbB3iwjcWn3aRtGnlZUFqIByFG26LkGXGZgUd
   Q==;
X-CSE-ConnectionGUID: njqUu4HsQf+hgjZ9ZN2ldw==
X-CSE-MsgGUID: cP6htBmYQwmGop/GOXS+KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99749338"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="99749338"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 05:51:32 -0700
X-CSE-ConnectionGUID: aT5TtPbIRjS2vbDUcXiGgg==
X-CSE-MsgGUID: Xq/JfuFWRX6kzrjeDNpDdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="305795266"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 05:51:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 26 Aug 2026 05:51:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 26 Aug 2026 05:51:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 05:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uahVPZ3vTQmMhXvj4reecdwrFHuetT6dR8EUdvTkcqeXZb7bWyJb6lJgPwuMM6fyYI0l6FRoMLzLOPrFEcjXm5iiOqkLPw+uGopHmEWPxFVCefGN6QKV4MGOljCU+hmwADkfDCPGDEwNr4WWy8rP3u57jXDGyhO09B/L9sG4C2voj7JzqT1snBm3Ee50UQdVcY6B4+NHPcvnEw+KRRvoS8+WrHWSfjjYfc8Z8caZsnIUq8XlXLGS8uaOefgvoEzPwiUxVntq0ZHCm/mKt/oiKCLBOw7m4lFJ9lgew8RnXZ0yWUmdL2FXYMmM1V7hP83ucnTWym+LE1OQZCMvriAz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2wqeoZ3SkrfoUGPjKcJ1XCusNNGlRny3w1+O7pcGU4=;
 b=m6v4Q2byp6NmIqQrPMWPsOP75/biNUGMLT2ZsTrqVvwi12qotbJrbxsFD4hg3LxCYlX+0KsjXAUt1cDShetOKBY8kUoI/dUWw8IOkfFJe+hH2BGTDo5YOPtKxtwWhMQ7HVIOmR02ch1CIfeW0u2VTjt9iuC5zzId7It1Pu5ri8B6csqRYDMQ+62xgLijFuawZ3hFYVmKXB/o4O1XxKFckSArtw3zwDHnOZSgQEZd6haBKZZcmAWYkN5l6yjC2NcvTKJNIaOBNnNUedfVzGxDin0LXgKm4Gm4VBUBsyn0WSiPFqQngcs0k2/qBUgp1T8pnJiTLHFE5/z9ykLnA2qXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 26 Aug
 2026 12:51:26 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 12:51:26 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Paul Moses <p@1g4.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Fijalkowski,
 Maciej" <maciej.fijalkowski@intel.com>, "andre.guedes@intel.com"
	<andre.guedes@intel.com>, "vedang.patel@intel.com" <vedang.patel@intel.com>,
	"jithu.joseph@intel.com" <jithu.joseph@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "tkusters@aweta.nl" <tkusters@aweta.nl>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] igc: only strip RX timestamp header from first buffer
Thread-Topic: [PATCH net] igc: only strip RX timestamp header from first
 buffer
Thread-Index: AQHdNO2R6jqyjjKiv0GE6VYbCwfpNbawSTHA
Date: Wed, 26 Aug 2026 12:51:26 +0000
Message-ID: <IA3PR11MB898675B237F0A38CA850BED4E5AE2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260825235530.3278670-1-p@1g4.org>
In-Reply-To: <20260825235530.3278670-1-p@1g4.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA2PR11MB5052:EE_
x-ms-office365-filtering-correlation-id: efc9dd9b-79aa-4020-5a61-08df0370bded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|56012099006|38070700021|6133799003|11063799006|10067099003;
x-microsoft-antispam-message-info: 7AzGbL3u7bDzEn8wz+yreEZPjAb5Z8zILFpNz6NFNo8UszSV2+aHD1bhK3aM1UpEU7RRdOV8kFOnNkrn1yJDAfWgnBwPVwrwcJxUpzcMBU97plmQWOuc6dTbj6kIKlHE9sj7+gjONNw+e2ufdzyGzQMV1Hlj3wmAU54W5furdrtaPhlSJiYyeo0ZZFQyiyVWVMGp+1ofP6RpbxVUQ0a34s9r736n/T9f1GmrAW9CbT2IXjKyYw+u2sT4KJPHEmfNwD5DTNrtkArXlk/gV3efBPrZAfT7mSTv4t04rdbodWGD+d4wtxrmN5ZO1xUxNAMzdaiX0aTkwmmAfm3CEVnoNC32lJGxMiytIzsb6wLzXw+4SWIanS3TBeAT2NcSWJmN9DLcCa1LCwr8vyKj+g81vLA7rzhJiE9bS0F8LszLvje/9uONlrn9YmVaFrgSn6de2Ae0cW7/0w9/ibAfJo3LLUZqYbiQIntV3vfA8FuknHh+pqWYAoDl9CEmXg4SFyDe9ubdKwppC1G3VmO6j8ZQKWU7mpGWWADxL4SiAT5wmAgEXnuyOd8+EKk44qnG/xLZGl7zEO2dEGlZDptRI0Brmg45J6MTdE5F0zwvTdL/5LVB5ciWYK7BjEkHQ1/Joph0VJ7yfwdXw5PWe/F0Y68I+aq564A7NVPRQ5D4+tRQCLB/p7g2i8SNrgVgktl3VHE5nX020bg9lGft71PfOC26PI2eNHl0OkE5hfA+DVGgzx8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(56012099006)(38070700021)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXd3MzNVVjl4QThIOGFqMEdJWlBzNk1QWGZZcXg5RVdjakRKdWRlZHQ2SkJZ?=
 =?utf-8?B?RjVYbTlIam1QcVRPaU1vZEcxV1orQWNXVk1jYSs2T01SaWJTSVhHcTBWOHB0?=
 =?utf-8?B?TEd5b2xKa1BJUjVISEE1VjNjQnhwR0lYVy95bGZYMTI0R2RTK1pyQjBhZmVR?=
 =?utf-8?B?S3lvYkRWVmlMazQydmJvT3RHeXZBRE53dUl6ZVlYVUFDdmZLN1NyZnFaOW11?=
 =?utf-8?B?eGNVWG0zeEprUVBRQUEyVWEvSkpqaTV3bThhOWVLKzA2K2FhUVBvd2dnZEh1?=
 =?utf-8?B?YWN0NkUvYk53dGNjZVRvVjhLYTFnQnpJbTdrdzloM2JqbUdZRndGN3V6MDdH?=
 =?utf-8?B?Q2FvZWl2N2J1ZUpSWlpGUHJoSnZ2dERrREV4NURhaW5EU2xyWTFKUXIwdlor?=
 =?utf-8?B?ZHFWeUE3emlFMXhWcXJMQkorTkZFMFNodjR0UXVCMXVxaisrdm5xN09EU0dk?=
 =?utf-8?B?NWpmaDU2RFY0VElzZkI2Sjc0UUFXanY4eHZyYThNOW4vZlAvQWw3ZUJJMmpG?=
 =?utf-8?B?Z2FDajdaOHpJbDd2RkZ5VTF3RlJoRVJWQUF2L3NTeGkzVHU4Q3h2eU8vQ1pF?=
 =?utf-8?B?YVJrVGVJb25zVmJrc0VPRWs3YVlGM2xaeUpSYUtQKzZDWmI3NFlsbnpjanQv?=
 =?utf-8?B?d3NGVW12TFUwU3c2NFhWWmRyUXUyeFZlMHY0L2JKRUJFaE5yZ29BSnN3RjZB?=
 =?utf-8?B?czM0WmYrTTMwcm13Q016cmt2eXQvcHE0YVFjQzZoUHlodTJMWm1jYXJTOXMr?=
 =?utf-8?B?ZzQ3VDNzLzBKY0JYN2VPY0NhTmNkMS9sNjN3U3ljbUp2RkFyME4xcjdMVVli?=
 =?utf-8?B?dmlvVzhodFFmdXpGdE5wUW0zcTNOQlArL1FDZ1ZTVURHUVYyTWJHWU5uVHo4?=
 =?utf-8?B?VFVNOTFEdkxIRVVwMHh2bmNhWU8rcGNoNU4vTVR3MHBScXA3cHFsM1BoWkph?=
 =?utf-8?B?RXdSY3BzWTJqeVRXVHZZZThhcXBYR05ZU1Y0VUdkNC9sWjNBQlI5aW5ZOTVL?=
 =?utf-8?B?cmpRSnBHMDRtNWNGQ3kxck9nd2RaWENRZ0dTMVF0aUlYaWFZOGh3NDVRK2ts?=
 =?utf-8?B?d1g0ZFdCd3kvQWJQOEVDcEpnWmFpYkVLYmZFSFBGTWljRFdMYUo4eTBnOHpp?=
 =?utf-8?B?T1dTNSt4cnRLaVRXWHpNTUlhbVF0M2p2S2VBQXZIdEpZMk9jbVZnTUtVQTJ2?=
 =?utf-8?B?WUJSeW9XYy9MdDN3NUxtM2RnKytnNzluR1FweDFBb2ZTN0Y3Vlh3WG4zSVN2?=
 =?utf-8?B?YXR4NDdleDZhWGNVb2I0RkpvK2IrMmdsbXA5eml1TytvYXVobUJJU0NwS1lW?=
 =?utf-8?B?Z3JTcW10RnZoNW9ZVGJxVlBkbmFRY2s2TzlIaDU1NXhPZmhyYlhkZi9Vc3F3?=
 =?utf-8?B?QWtGOFNLTTRXd1lsVTIvaFNXNTAvUlR6LzgzR3drbWpZODB1RVY0ekZPc0M0?=
 =?utf-8?B?SWZzdUM3K1hJK0NCNS8yOE9ZOEUwejh0MUczN2JlQVNYOGlCaXV0Y1FiNllO?=
 =?utf-8?B?OWxFU2ZkeHpwemZFeVkyMUwzOCtLV1loTis1WWMrVlRFREUwT0ViU1hBSWxQ?=
 =?utf-8?B?SkRURVBXbXVteWhXT3VlK01yRlBTbWxYYlQyVXU5OGljeDhPR3FUYlE1YURP?=
 =?utf-8?B?RjlNblRERzFoQVkxNTBGOHBzekdNaEs4L3VOVW12WlFlK0J3RE14TFpvcWpB?=
 =?utf-8?B?VWU5UFE4NXkyRGdVSWJoL09VNWNHVHNuMjVaNFBWcTJQVlk5RUtKNGhYSkRJ?=
 =?utf-8?B?OHBzSDRIdmRkLzI1UEhpMVkwL0VBRG40anNRTGRuU21BKzFtSE1NVWFZN1FM?=
 =?utf-8?B?Mzcrd284aWtKZllUdjRCdGs0THY3dFJQL0NsQmZKeUM1Zi9MdlJpN2ZkVWVn?=
 =?utf-8?B?b0UwTitjZE1TYUQ4NFRrRnF2anZqVzUrOXplSUZOMXYyam9CQXpoN3NWd2xi?=
 =?utf-8?B?WFlKemRoOVdqTlVDS2l0aGxGZDIrZXFOUEErbGU0czJGU20wM0ZtY00vczdO?=
 =?utf-8?B?OGxVN1BkZkZmTVlXdlE5Y1c0TVJCTkh3N084aGVsUTJ4ZVdpbmVnRXdZZ2FY?=
 =?utf-8?B?d0pTMzBVSHFHY2MzaHRhTWlCb0xDWEFCTnRxRGtiS0hqcFBHOUEwQlUvREhk?=
 =?utf-8?B?cHhJZWM4ZlFJKytPYk1HTGZ1THRtbmRRRzZXTno1ZEg3U3orbHNwaFlaNzJM?=
 =?utf-8?B?N3oxSUxxZ1hxK0o5TThPaS9oZFE0VjZGWXh5bEJkTnAzZlNGd0oySjJhY0p6?=
 =?utf-8?B?OGtubko4eDhIaFVGajhjSDYveVZ5Ty9vSUF0ZlBmOGxpK0J2K0dBc1lPWFJn?=
 =?utf-8?B?bnlyNVE5VVdzRmE2OG1nU2R4NlNRdU1RdXRCWnlVeklqNXNmb01ScDBpQVpy?=
 =?utf-8?Q?LQkXNYLhHKzLdwzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: eG+mF2/hTA/UVe4uB3Nhf8oNMoH1zzAJFK5V1ES/WTEIV6ABIZtiXlfPYQQexNgggv0LFGWg+Z27Wk5G3Ih3v2sm4ZUcU9TRnb80A/vXcnxwI2ESrocpQZP8YINnXkFXOnFJAQe+JGrtZQDqFzjii6/JFZUtyDne+v7WaA+3ETE/XLqUV3p9h0MJU4z7k8jIjdH0SfI9AD50vsLbomx7qqYNNvgw/wkxd0RaIjLY7OI52q/UenvmZ+8eguNK6Jfmis9cBQ/fhR34vqvtzzyuX6E4FWDP+nMF14eORJoSgOC3rK46FG6cYaVPubuy4VD+UaRLG64Uf0IC8+DDgtl4aw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc9dd9b-79aa-4020-5a61-08df0370bded
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 12:51:26.7395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUluX7SKHAWoadgHxJQ/s3vqE+KC4KnbLMqGMFuC21RibBMqwMepryK2uO3gIgqq5RPZzwwbqX2K2efUeTvU9TgC7MZ2KBHQQM2g8xliLxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNb3NlcyA8cEAx
ZzQub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyNiwgMjAyNiAxOjU2IEFNDQo+IFRv
OiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTmd1eWVuLA0KPiBBbnRob255
IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8
cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IGFuZHJldytuZXRkZXZAbHVubi5jaDsNCj4g
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3Jn
Ow0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgRmlqYWxrb3dza2ksIE1hY2llaiA8bWFjaWVqLmZpamFs
a293c2tpQGludGVsLmNvbT47DQo+IGFuZHJlLmd1ZWRlc0BpbnRlbC5jb207IHZlZGFuZy5wYXRl
bEBpbnRlbC5jb207DQo+IGppdGh1Lmpvc2VwaEBpbnRlbC5jb207IHJpY2hhcmRjb2NocmFuQGdt
YWlsLmNvbTsgdGt1c3RlcnNAYXdldGEubmw7DQo+IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogW1BBVENIIG5ldF0gaWdjOiBvbmx5IHN0cmlwIFJYIHRpbWVzdGFtcCBoZWFkZXIg
ZnJvbSBmaXJzdA0KPiBidWZmZXINCj4gDQo+IGlnY19jbGVhbl9yeF9pcnEoKSBzdHJpcHMgSUdD
X1RTX0hEUl9MRU4gd2hlbmV2ZXIgYSBkZXNjcmlwdG9yIHJlcG9ydHMNCj4gSUdDX1JYREFEVl9T
VEFUX1RTSVAuIEZvciBtdWx0aS1idWZmZXIgcGFja2V0cywgY29udGludWF0aW9uDQo+IGRlc2Ny
aXB0b3JzDQo+IHJldGFpbiBUU0lQIGV2ZW4gdGhvdWdoIHRoZSBpbmxpbmUgdGltZXN0YW1wIGlz
IHByZXNlbnQgb25seSBpbiB0aGUNCj4gZmlyc3QNCj4gUlggYnVmZmVyLg0KPiANCj4gU3VidHJh
Y3RpbmcgdGhlIGhlYWRlciBsZW5ndGggZnJvbSBlYWNoIGNvbnRpbnVhdGlvbiBidWZmZXIgdHJ1
bmNhdGVzDQo+IGp1bWJvIHBhY2tldHMgYnkgMTYgYnl0ZXMgcGVyIGNvbnRpbnVhdGlvbiBhbmQg
bGVhdmVzIHRoZSBwYWNrZXQNCj4gbGVuZ3RoDQo+IGxhcmdlciB0aGFuIHRoZSByZWNlaXZlZCBk
YXRhLg0KPiANCj4gT25seSBjb25zdW1lIHRoZSB0aW1lc3RhbXAgaGVhZGVyIHdoZW4gc2tiIGlz
IE5VTEwsIHdoaWNoIGlkZW50aWZpZXMNCj4gdGhlDQo+IGZpcnN0IGJ1ZmZlciBvZiBhIG5ldyBw
YWNrZXQuIEFuIHNrYiBjYXJyaWVkIGluIHJ4X3JpbmctPnNrYiByZW1haW5zDQo+IG5vbi1OVUxM
IHdoZW4gcGFja2V0IGFzc2VtYmx5IHJlc3VtZXMgaW4gYSBsYXRlciBOQVBJIHBvbGwuDQo+IA0K
PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjA2MjUtaWdiLXJ4LXRzLWZp
eC12My0xLQ0KPiA5OWIzZWZhMDhkY2FAYXdldGEubmwvDQo+IEZpeGVzOiBlMWVkNGY5MmE2MjUg
KCJpZ2M6IFJlZmFjdG9yIFJ4IHRpbWVzdGFtcCBoYW5kbGluZyIpDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFBhdWwgTW9zZXMgPHBAMWc0Lm9yZz4NCj4g
LS0tDQo+ICMNCj4gIyBSRVBSTw0KPiAjDQo+ICMgUmVjZWl2ZXI6IGlnYyAvIGVucDFzMCAvIDEw
LjAuNS4xNzUNCj4gIyBTZW5kZXI6ICAgUlRMODEyNUIgLyBlblA0cDY1czAgLyAxMC4wLjUuMTY1
DQo+IA0KPiAjIEJvdGggaG9zdHMNCj4gc3VkbyBpcCBsaW5rIHNldCBkZXYgZW5wMXMwIG10dSA5
MDAwDQo+IHN1ZG8gaXAgbGluayBzZXQgZGV2IGVuUDRwNjVzMCBtdHUgOTAwMA0KPiANCj4gIyBC
YXNlbGluZTogUlggdGltZXN0YW1waW5nIG9mZg0KPiBzdWRvIGh3c3RhbXBfY3RsIC1pIGVucDFz
MCAtdCAwIC1yIDANCj4gcGluZyAtbiAtTSBkbyAtYyA1IC1zIDg5NzIgMTAuMC41LjE3NQ0KPiAj
IDUvNSByZWNlaXZlZA0KPiANCj4gIyBFbmFibGUgUlggdGltZXN0YW1waW5nIG9ubHkNCj4gc3Vk
byBod3N0YW1wX2N0bCAtaSBlbnAxczAgLXQgMCAtciAxDQo+IA0KPiAjIFJlY2VpdmVyDQo+IHN1
ZG8gdGltZW91dCAyMCB0Y3BkdW1wIC1uaSBlbnAxczAgLXMgMCAtdyAvdG1wL2lnYy1qdW1iby5w
Y2FwIFwNCj4gICAnaWNtcCBhbmQgaG9zdCAxMC4wLjUuMTY1Jw0KPiANCj4gIyBTZW5kZXINCj4g
cGluZyAtbiAtTSBkbyAtYyA1IC1XIDIgLXMgODk3MiAxMC4wLjUuMTc1DQo+ICMgMC81IHJlY2Vp
dmVkDQo+IA0KPiAjIFJlY2VpdmVyDQo+IHN1ZG8gdGNwZHVtcCAtbm4gLWUgLXZ2diAtciAvdG1w
L2lnYy1qdW1iby5wY2FwDQo+ICMgbGVuZ3RoIDg5NTANCj4gIyBbdG90YWwgbGVuZ3RoIDkwMDAg
PiBsZW5ndGggODkzNl0gKGludmFsaWQpDQo+ICMgd3JvbmcgaWNtcCBja3N1bQ0KPiANCj4gIyBF
eHBlY3RlZCBFdGhlcm5ldCBsZW5ndGg6IDkwMTQNCj4gIyBDYXB0dXJlZCBsZW5ndGg6ICAgICAg
ICAgIDg5NTANCj4gIyBMb3NzOiAgICAgICAgICAgICAgICAgICAgICAgNjQgPSA0IGNvbnRpbnVh
dGlvbiBidWZmZXJzICogMTYgYnl0ZXMNCj4gDQo+ICMgRGlzYWJsZSBSWCB0aW1lc3RhbXBpbmcg
YWdhaW4NCj4gc3VkbyBod3N0YW1wX2N0bCAtaSBlbnAxczAgLXQgMCAtciAwDQo+IHBpbmcgLW4g
LU0gZG8gLWMgNSAtcyA4OTcyIDEwLjAuNS4xNzUNCj4gIyA1LzUgcmVjZWl2ZWQNCj4gDQo+IC0t
LQ0KPiANCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jIHwgMyAr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4u
Yw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+IGluZGV4
IDFmYjVmM2NiZTkzYy4uNDFiMjkzZGMxMGMzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPiBAQCAtMjYzOSw3ICsyNjM5LDggQEAgc3RhdGljIGlu
dCBpZ2NfY2xlYW5fcnhfaXJxKHN0cnVjdCBpZ2NfcV92ZWN0b3INCj4gKnFfdmVjdG9yLCBjb25z
dCBpbnQgYnVkZ2V0KQ0KPiANCj4gIAkJcGt0YnVmID0gcGFnZV9hZGRyZXNzKHJ4X2J1ZmZlci0+
cGFnZSkgKyByeF9idWZmZXItDQo+ID5wYWdlX29mZnNldDsNCj4gDQo+IC0JCWlmIChpZ2NfdGVz
dF9zdGF0ZXJyKHJ4X2Rlc2MsIElHQ19SWERBRFZfU1RBVF9UU0lQKSkgew0KPiArCQlpZiAoIXNr
YiAmJg0KPiArCQkgICAgaWdjX3Rlc3Rfc3RhdGVycihyeF9kZXNjLCBJR0NfUlhEQURWX1NUQVRf
VFNJUCkpIHsNCj4gIAkJCWN0eC5yeF90cyA9IHBrdGJ1ZjsNCj4gIAkJCXBrdF9vZmZzZXQgPSBJ
R0NfVFNfSERSX0xFTjsNCj4gIAkJCXNpemUgLT0gSUdDX1RTX0hEUl9MRU47DQo+IC0tDQo+IDIu
NTUuR0lUDQo+IA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExva3Rpb25vdiA8YWxla3NhbmRy
Lmxva3Rpb25vdkBpbnRlbC5jb20+DQo=
