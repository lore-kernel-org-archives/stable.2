Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF53A4535;
	Sun, 30 Aug 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788079004; cv=fail; b=HvKiY3ZWY/sEhpzkaD4Se3N4CF4F0DAHJL0sE9fBZxzWb7EzJ5dq/1HaFPTejRYPjRZcEQzqNIpW2xuyQhPSeUa8JZ0hW1KE67DdyLe4Hdsw+QHaMmQftui+dm6vYhbGipYaDyYmTOiptkDVVITqj1ujKcntJDu5B6vKZp4f6as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788079004; c=relaxed/simple;
	bh=SpdZ/xc30NHWsQ7siUAomjkfXL9xxFzsX/kZSDFTGOg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQHIs++MwZFRnztKuXJbbeoT+325w1utQNHT9/ERFcAueSzmz9btgVBiOB5xHTsMpEVv1DebOO/lff+dr+mIK/opiT6Hh5CbWQRQD+nxx8CMgVQk170MOJb7I3TOeoxQk2ANOMCw5Iqdr/jfhl93yatTQUl5l8ijYDo0vDdToN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCr7wpAd; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCr7wpAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788078994; x=1819614994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SpdZ/xc30NHWsQ7siUAomjkfXL9xxFzsX/kZSDFTGOg=;
  b=KCr7wpAd6LPM/MVMB2uXM73lYnDEGxDcV3CQmobwWucWLwK0y+vEsTVf
   1SAqI+wlbQGtqAGOSGIKX0KxAxex7vVtZIwKkNyF+aO7uq4ocXiYnoQ8R
   FUHZBgSoZvOlVQAF+HtHSixr8I5ClbfuPZa78yRdRCPgPXXJl+uZupdWO
   n4tT92LgG43TBz8uZvx8iHGKRoxvB0I9CYP87nD2/rkMXKVwYghOLE2cL
   +77M5M59McprvWHPWkVhF2TY5iknkO8hRfzQ8XeHx3u2Ca2MCw9MKTfjM
   ptkrmCEsLD6RNV+nO/9AjLkNPwvW917Wl54NGoXxk2Bqcj+YAcmGj+u3t
   A==;
X-CSE-ConnectionGUID: ITs+WL9RRJCMQdB612h4ew==
X-CSE-MsgGUID: AbaiMUnUTZKohkm5vL2PFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87461729"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="87461729"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 01:36:28 -0700
X-CSE-ConnectionGUID: uGdd/yYASrmjtcRQ2pLzHQ==
X-CSE-MsgGUID: +Kz3diUsRGyJx9OPDpyyHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="266724678"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 01:36:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 01:36:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 30 Aug 2026 01:36:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 01:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWGfD1zYgFVWb19TDlpBees7LeMQQ5mHD+NKxHvA+Wc/PW1Ab0tgdIenjcGg3hrno3EiYnutUSrjuiISLVvhZcyA3cagL7xyarJNxmQh7+2qJkRLKXhRqKLNtTYKiQtS9naCCc+xKBDXklqoL82wRL0oF7m76PXgBCzkonGtFbx1dPcSJHRAWsusFjSOVWsNrbsM/klbdTqES0helXEZRSgdF7QZiBZkvotSmDGZUfStwaUgQAz04SYfdRZFdoLLh0fpyAEWCVa1xLtYcRArBjPAvjbCvaRqBqk10xw0jrp0PfgNGDFZoO9GEHiGTzyddk/zgG24j2zzjvkYEbNyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpdZ/xc30NHWsQ7siUAomjkfXL9xxFzsX/kZSDFTGOg=;
 b=ghAXMZ/m3OTYnwsQa/5BqG6D531ordluNve4yzelMGvKZO/mXBqQ4Lih08+95MVmS8nFhKTBqOgcfyPFWcXBd/fxNvpTsXaSuw3Fx3VTexwV92t2oKc2S7aywOgsrrbN8lw2lhTaur89S7zW2NR10MldsPO14j3n2uiouy7Tst3BRLz7sOvJ9MKA8pAfL4wBEHW9hDRA+e0uARRnXqjaCTB3RX9pfbQmp3tXrYGhdw4SYwn9fQGjdJgmlhHZlS/Zr8RbdjXC24JPJ2nOElXHpKbUITVkBLWpfLtBvk+0kxQEs+NEDnv59m8bDvl83PSAGUejMbB+Z9jnZ5Xcx1O8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SA3PR11MB169024.namprd11.prod.outlook.com (2603:10b6:806:588::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 08:36:21 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%6]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 08:36:21 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: "nirbhayykumarr@proton.me" <nirbhayykumarr@proton.me>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
	<arnd@arndb.de>
CC: "w@1wt.eu" <w@1wt.eu>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v4] misc: mei: fix race condition between client teardown
 and read completion
Thread-Topic: [PATCH v4] misc: mei: fix race condition between client teardown
 and read completion
Thread-Index: AQHdM9V0M2wJag6F3k2lDFH3E4f5p7a2FciA
Date: Sun, 30 Aug 2026 08:36:21 +0000
Message-ID: <CY5PR11MB63661742670108288F61A179EDAA2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <ftGV8Hp-LYTtUVnxctTg6RSMnglJf1Dkgx65y7bRorozRtAeBBPU3zTQNG8Bmj-wNjNl0hTO5m2hyGMw8TktWQ2bijbJzdmGsRmlv-XLk3A=@proton.me>
In-Reply-To: <ftGV8Hp-LYTtUVnxctTg6RSMnglJf1Dkgx65y7bRorozRtAeBBPU3zTQNG8Bmj-wNjNl0hTO5m2hyGMw8TktWQ2bijbJzdmGsRmlv-XLk3A=@proton.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SA3PR11MB169024:EE_
x-ms-office365-filtering-correlation-id: 0e246940-cc59-4f57-c32f-08df0671c4df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|23010399003|1800799024|366016|38070700021|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info: a1484mCm2CqQu6wyaKZJQ8Ut1UId2vOS0sITHOn5PFkpgh7Gwe1OCAIwt/ccdtsu1TlRmhaWIyIMetAxgRpX4Yie+RInXR08j5cCiefkbNn26zs8HoSS+Oq+Fah30Jkt5hMziMUn5THGJZhlOSMJAWNI/xT2GpwSW87liNbW9UPjT+8heoZooIkGM5uIF+NXTpo6XrlfDUjQLQv7Cpt3lejw8PNXsXl7x39MlLUZy/hWpnehcGGDOlNGfYuwhHj3Hl4bEIBhBiuo7cESoOgf/AL8ciJfDZd8rbXeQS1l1wG8zLI7NTb4UllVzvKs0WD/18+h9zndcF/dVjl6QtYBXezYtS0LGmumedRrCdaIWkvld1ZeXN+r7M5o9ycd9iy1EXuwB+6f6EWKvWLFfRNeZuhGKZnEmFJLBRsHo37VdUpdnUymVfhm7ZliQo5xKq2/nlBo5hBEs4HYtQRZdqQo5JkWR2rYWNEbOo/L9EyayZ0XUp05qyCBvD4gp84qNl6YEux7BpIDdjM686YpIwrb1eYgamoxIlageHx3YBrxhMopmfCah/RAaDlBvFb84KPqYVIV1QgD9UpPhUScX3Mzzz5xtebu4kAT6u8nj0/oFiwf0dOovuqPHqv2C0IVT68BobE8Ov3/gXsvggYPOaUhweEk97N9fmGGaVWwdm1WdLvScugaewkx145C8/86pqKa7EvxRB6odaYhQYHhzFT2l7zvdBtA9xT8WrmHsehNQE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE1idCtodis4dGFuVFF4Q090bDMvWFlNOGZkQVVSdC9iT3JSaVNQMW1pUTBy?=
 =?utf-8?B?bUVUMFdJQVdCNkE0blFSRDh5aW9ESWtTVnBGQ3RPYitBU1hZSzFtUTB6ZFFl?=
 =?utf-8?B?QnJzR2ttUktYQStIMFJ2b2RINXJMeGpCNUJ1ZklhN3p2VkNpMWdVSFZwWDRn?=
 =?utf-8?B?QU93T1FlMjN3d2RKSmdacHZYSzJ5OU1kU241T1kyU0EvUm1icE41NEgzV1Bj?=
 =?utf-8?B?a1AvekNaMkEzQm5GMGJmVkVhQTJ3c2QvVzRyelMzTGZKTDJneGJFdFhOUXVP?=
 =?utf-8?B?MkFWTS9ac2ZKditqNTVpOTZnVllDQjI5dGMrcytGQlFFeXpUd3Rad3lva3Fi?=
 =?utf-8?B?bEJIeVFCS01VQS9adEo4WVcyS2FDQXdFS0txQUY3V3ZaZ2RnekRhbE5OKy9N?=
 =?utf-8?B?OW4ydWNRc1BzSjUyMDBYMXN0ZmluSXgrOUJYdy9nSlJIMUUvUVFQZzRieENk?=
 =?utf-8?B?Z0swNXd3VXA2RG4va2lNZGZFcEZmcTBxd2xHQk9GQm1wZ2ErWE53U3hPYkNY?=
 =?utf-8?B?Z3pPL0NIVllYWlpnbVk2SVp5ek5RZ2tUdWVQV3ptMjhYaE9jclNUTFRJYSty?=
 =?utf-8?B?amExeXMzNVkzWUR0dWRMdGtEbGI0Y0k4RFpNS2VGWjd0NnNhWFM1eEI5VXdx?=
 =?utf-8?B?d1ppVWpnTGZhK2RyelI3dVdzWjZwK1FBZWJDV3FkV0Q5b0ZEYUM3Z0R2QzlI?=
 =?utf-8?B?WHYrb05XVzhBVmZMdXBxc3kwZlZsN0h6cHVRb2pEN1FQUVkrcDI1bnQyM2Jn?=
 =?utf-8?B?SW9PYURtUGFaT2pxU1kyakk5T0gyUHNDc05aQW5IemFtaFQwL2ZvNVNJcnIz?=
 =?utf-8?B?OXk2MVF1bE9DVmVoMG5WMjNJVmFHSlhETHpTYkhrUjhKSXN1TGV1Z2t1emMz?=
 =?utf-8?B?U2pRTnFJS3VkS0JVSUxtR29yZ3hRMkxGbEFpWlQ2U2tNZW4ySWEvejRUd1pq?=
 =?utf-8?B?Z0hrMW8zeHRZbERaWkFnRitPWkNrbU9IbmpPOFVSclM0OStCMTd2VHAydTVt?=
 =?utf-8?B?YnVRSFI0Z01PdW9oVzRxYnlHWWJLbDk2ejA3YXlGZlIrUHZDTW43NWgyTDNm?=
 =?utf-8?B?cmJtNUR2UW5QdWlDNHpGeWNQcktlS3dqZjlDSk5wemNMSEdGVHc3U3gvbjJO?=
 =?utf-8?B?T1ZDTFhaN1RYdmZMdnFwMXQyUVpnbUMwUS9lTGVBMUVyVHlZL2dIS2YwMnJm?=
 =?utf-8?B?U3licThxWE9yYldYWTIwZ1NBMUpIM1BFWFlCRmQ0UU9vZVV6dWt0RkhjR3dU?=
 =?utf-8?B?WjRxQjBOM1lxWmJ0dTBKL0ljRUhQNFhGZHBhemtrdXQvWW8xWU1QV3cvQUNk?=
 =?utf-8?B?Z09iVnFUTTVXQXVoVkZpUTUzN2ZMaytZYUJCdEx3Q2dpSnhQRzlRSWQ1NDJJ?=
 =?utf-8?B?SGRqQ1Q1S1UxRDRVME9kMHlvdzV6eGhoby9YZ1Rkc1p5SGJCazFKQ1g1dER3?=
 =?utf-8?B?aFgvcERkZWp3NUp4TDdla3Y0VkhML0JNUnc1aFBNWHk5ak5TVHQ0bzdlcm9x?=
 =?utf-8?B?M1JVWFhzdFhRZDhJcG1TK2ZSUmZJMlVDekdsbWNIOWdXbnIxdUxXWG13ZWZi?=
 =?utf-8?B?UUQrK1dPY3pKTHZldWVVb2VCbDJSUmZLbTdlQnlNZUtlQnZKeDc2M1RBNEhh?=
 =?utf-8?B?RURDWEszVzRHSjFWVkhFTmVTandsb21oTzJzVzhZVzUwbTR6V2orN2NKd0E1?=
 =?utf-8?B?K2k4TXZ0bURhVW9QcmxYZ2VoOGpZZmhNV3JwVUxOQUprWDRFd3g0dVpzeUdS?=
 =?utf-8?B?NU5RNmlJTDJacTVUUDdVZGtFVkVMQ3o2UEw5OUNvTG9keFQ3YndLTGtIcCtC?=
 =?utf-8?B?ZzJiazYvdk9PU012Lys0dXR6bjVnQ1BHaU8wUWJFSm8xbUx4RzZaempGdXly?=
 =?utf-8?B?REdVRGF1K1p0MjhzNkdsUThBaFI3QUp6REdEN2h0MGpFOTRpSUxuSTVUWUNJ?=
 =?utf-8?B?MDNPbmx1VzhyTVZvUUJFeGsrVU9jT0x2ajdEYU83Q2hFajU4dUVrUUp5ekdH?=
 =?utf-8?B?R0lSeFd2dUdtckJXcjlOZjdvQXFVZENqSm93OXRrcjhhODIrajM5bGJQaFRO?=
 =?utf-8?B?SGdXTXRwSHBnMm55L3JIV3p0dDA1MSswYzNuKzNnNFdST0dLVEoyTXl3T2hK?=
 =?utf-8?B?RjNncHUrT1pPYi9mMnFXL2JOeTFMdWVNSlFLNEJLTTZZK1lHVFFNWFE2bmp6?=
 =?utf-8?B?R04wT2k5cU9wRkQxM0dlMzEvWG02cHFINENTWVJ0RHhTekw5ZWQyVXBseENF?=
 =?utf-8?B?TC91c1NZMVJhc2JsYXBQODZ2SXk5RldoaUdKajR0UTRndWNuaDVjNU84cEJv?=
 =?utf-8?B?QWF5eFVDL0pOU3VDbHlMNjQ4cEtwdWFIbGZVUDhMVFhiY3oxQ2phL1hOMlNr?=
 =?utf-8?Q?aJvFNVJ2/48s2cRpGuizqm9hqFa+nDOJCzlfP8Jf9UjCw?=
x-ms-exchange-antispam-messagedata-1: ZGZHkdYMVEsNeQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2RJmry+9kqZP8S2cSzz5hIOZtONMnFw8f79xPQjcVVkBOCnKwCUq9z0NhOflbkBHmcVfDzY9+hSV99OMxV4BWT2qYCNV+tOVyk27v5XCwcU0h4WhbUbyTC1XZq7omghrV0jrFX84AcU5AzuKi3vbkiv8VtV5BBGnomxTkjXrbm2YPfall/iA4CRvvrYGJ0x/PCA+R6+iajqnSx6EDUpMsj3iME3lH81zr35vipG2dD0vCqIASahZcIEYDueTUJL64wYxFIzuY8Rw+P6dk9qsr5XymVv1R0owDrtlwnicP1e2BUmclCuh+75dkyBwegaa0EZRe+xmEdTy+m/JpKfwNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e246940-cc59-4f57-c32f-08df0671c4df
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2026 08:36:21.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JQgT3+Q8qlZ9j8jJqLHW/UikjIC0fc4xSgQzmavnD7ZCjDNO/9J4aylBewzi3RxqQ0CRC6jtxquUnOJxXv7xE6t2LTheors8I1U93KtW3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB169024
X-OriginatorOrg: intel.com

PiBTdWJqZWN0OiBbUEFUQ0ggdjRdIG1pc2M6IG1laTogZml4IHJhY2UgY29uZGl0aW9uIGJldHdl
ZW4gY2xpZW50IHRlYXJkb3duIGFuZA0KPiByZWFkIGNvbXBsZXRpb24NCj4gDQo+IFRoaXMgaXNz
dWUgd2FzIGRpc2NvdmVyZWQgdXNpbmcgYSBjdXN0b20gbXVsdGktdGhyZWFkZWQgQyBmdXp6ZXIN
Cj4gZGVzaWduZWQgdG8gc3RyZXNzLXRlc3QgSEVDSSBjbGllbnQgbGlmZWN5Y2xlcyBvdmVyIC9k
ZXYvbWVpMC4gQnkNCj4gcnVubmluZyBvbmUgdGhyZWFkIHRoYXQgc3RyZWFtcyBhc3luY2hyb25v
dXMgTUtISSByZXF1ZXN0cyB3aGlsZSBhDQo+IHNlY29uZCB0aHJlYWQgY29uY3VycmVudGx5IGRy
aXZlcyByYXBpZCBvcGVuL2Nsb3NlL3JlY29ubmVjdCBjeWNsZXMsDQo+IGEgcmFjZSBjb25kaXRp
b24gaXMgdHJpZ2dlcmVkIGR1cmluZyBjbGllbnQgdGVhcmRvd24uDQo+IA0KPiBJbiBtZWlfcmVs
ZWFzZSgpLCBhIGhvc3QgY2xpZW50IGlzIHRvcm4gZG93biB1cG9uIGNsb3NlKCkuIER1cmluZyB0
aGlzDQo+IHNlcXVlbmNlLCBtZWlfY2xfZGlzY29ubmVjdCgpIGlzIGludm9rZWQsIHdoaWNoIHRl
bXBvcmFyaWx5IHJlbGVhc2VzDQo+IGRldi0+ZGV2aWNlX2xvY2sgd2hpbGUgd2FpdGluZyBmb3Ig
dGhlIGZpcm13YXJlIHJlc3BvbnNlLg0KPiANCj4gSWYgYW4gaW4tZmxpZ2h0IHJlYWQgcmVxdWVz
dCB3YXMgcHJldmlvdXNseSBzdWJtaXR0ZWQsIGFuIGluY29taW5nDQo+IGNvbXBsZXRpb24gaW50
ZXJydXB0IHByb2Nlc3NlZCBjb25jdXJyZW50bHkgYnkgdGhlIE1FSSBpbnRlcnJ1cHQNCj4gaGFu
ZGxlciBjYW4gYWRkIGEgY29tcGxldGVkIGNhbGxiYWNrIGludG8gY2wtPnJkX2NvbXBsZXRlZCB2
aWENCj4gbWVpX2NsX2FkZF9yZF9jb21wbGV0ZWQoKS4NCj4gDQo+IEJlY2F1c2UgbWVpX2NsX2Zs
dXNoX3F1ZXVlcyhjbCwgTlVMTCkgd2FzIGludm9rZWQgYmVmb3JlDQo+IG1laV9jbF91bmxpbmso
Y2wpLCBhbiBpbmNvbWluZyBjb21wbGV0aW9uIGNhbGxiYWNrIGNhbiBzbGlwIGludG8NCj4gY2wt
PnJkX2NvbXBsZXRlZCBhZnRlciB0aGUgZmx1c2ggaGFzIGNvbXBsZXRlZCBidXQgYmVmb3JlIHRo
ZSBjbGllbnQNCj4gaXMgdW5saW5rZWQgZnJvbSBkZXYtPmZpbGVfbGlzdC4gV2hlbiBtZWlfY2xf
dW5saW5rKCkgaXMgc3Vic2VxdWVudGx5DQo+IGNhbGxlZCwgdGhlIGludmFyaWFudCBjaGVjayBh
dCBkcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jOjY5OCB0cmlnZ2VyczoNCj4gDQo+ICAgV0FSTl9P
TighbGlzdF9lbXB0eSgmY2wtPnJkX2NvbXBsZXRlZCkgfHwNCj4gICAgICAgICAgICFsaXN0X2Vt
cHR5KCZjbC0+cmRfcGVuZGluZykgfHwNCj4gICAgICAgICAgICFsaXN0X2VtcHR5KCZjbC0+bGlu
aykpOw0KPiANCj4gQ2FsbCB0cmFjZToNCj4gICBXQVJOSU5HOiBDUFU6IDIgUElEOiA1MDU2IGF0
IGRyaXZlcnMvbWlzYy9tZWkvY2xpZW50LmM6Njk4DQo+IG1laV9jbF91bmxpbmsrMHhhYS8weDE0
MCBbbWVpXQ0KPiAgIFJJUDogMDAxMDptZWlfY2xfdW5saW5rKzB4YWEvMHgxNDAgW21laV0NCj4g
ICBDYWxsIFRyYWNlOg0KPiAgICA8VEFTSz4NCj4gICAgbWVpX3JlbGVhc2UrMHgyMDIvMHgyNzAg
W21laV0NCj4gICAgX19mcHV0KzB4MTA1LzB4MmUwDQo+ICAgIF9feDY0X3N5c19jbG9zZSsweDkw
LzB4MTQwDQo+ICAgIGRvX3N5c2NhbGxfNjQrMHhhYS8weDY2MA0KPiAgICBlbnRyeV9TWVNDQUxM
XzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQo+ICAgIDwvVEFTSz4NCj4gDQo+IEltbWVkaWF0
ZWx5IGZvbGxvd2luZyBtZWlfY2xfdW5saW5rKCksIG1laV9yZWxlYXNlKCkgY2FsbHMga2ZyZWUo
Y2wpLg0KPiBJZiBhbnkgcmVtYWluaW5nIG9yIGRlZmVycmVkIGNhbGxiYWNrIHJlZmVyZW5jZXMg
dGhlIGZyZWVkIGNsaWVudCwgYQ0KPiB1c2UtYWZ0ZXItZnJlZSBvY2N1cnMuDQo+IA0KPiBGaXgg
dGhpcyBieSBmbHVzaGluZyBxdWV1ZXMgYWZ0ZXIgdW5saW5raW5nIHRoZSBjbGllbnQgZnJvbQ0K
PiBkZXYtPmZpbGVfbGlzdCBpbnNpZGUgbWVpX2NsX3VubGluaygpLCBwcmV2ZW50aW5nIGNvbmN1
cnJlbnQgSVJRDQo+IGNvbXBsZXRpb25zIGZyb20gcG9wdWxhdGluZyB0aGUgY29tcGxldGVkIHF1
ZXVlIGR1cmluZyB0ZWFyZG93bi4NCj4gDQo+IE5vdGU6IEFuIExMTSB3YXMgdXNlZCBzb2xlbHkg
dG8gYXNzaXN0IHdpdGggdGhlIHByb3BlciBwaHJhc2luZyBhbmQNCj4gZm9ybWF0dGluZyBvZiB0
aGlzIGNvbW1pdCBtZXNzYWdlLiBUaGUgdnVsbmVyYWJpbGl0eSBkaXNjb3ZlcnksDQo+IGZ1enpl
ciBkZXZlbG9wbWVudCwgYW5kIGNvZGUgZml4IGFyZSBlbnRpcmVseSBvcmlnaW5hbCBhdXRob3In
cyB3b3JrLg0KPiANCj4gRml4ZXM6IGYzNWZlNWY0N2VkMCAoIm1laTogYWRkIGEgdnRhZyBtYXAg
Zm9yIGVhY2ggY2xpZW50IikNCj4gU2lnbmVkLW9mZi1ieTogTmlyYmhheSBLdW1hciA8bmlyYmhh
eXlrdW1hcnJAcHJvdG9uLm1lPg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiAtLS0N
Cj4gdjQ6DQo+ICAtIEFkZGVkIHRoZSBmdXp6ZXIgbWV0aG9kb2xvZ3kgdG8gdGhlIGNvbW1pdCBt
ZXNzYWdlIHBlciBtYWludGFpbmVyDQo+IHJlcXVlc3QuDQo+ICAtIERvY3VtZW50ZWQgTExNIHVz
YWdlIGZvciBDaGFuZ2Vsb2cgZm9ybWF0dGluZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+ICAt
IE1hbnVhbGx5IHdyYXBwZWQgY29tbWl0IG1lc3NhZ2UgbGluZXMgdG8gNzIgY2hhcmFjdGVycy4N
Cj4gdjM6DQo+ICAtIFJlbW92ZWQgbm9uLXN0YW5kYXJkIEhlbHBlZC1ieSB0YWdzLg0KPiB2MjoN
Cj4gIC0gUmVtb3ZlZCByZWR1bmRhbnQgUmVwb3J0ZWQtYnkgdGFnLg0KPiAgLSBBZGRlZCBGaXhl
cyB0YWcgcG9pbnRpbmcgdG8gY29tbWl0IGYzNWZlNWY0N2VkMC4NCj4gDQo+ICBkcml2ZXJzL21p
c2MvbWVpL2NsaWVudC5jIHwgMiArKw0KPiAgZHJpdmVycy9taXNjL21laS9tYWluLmMgICB8IDEg
LQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2NsaWVudC5jIGIvZHJpdmVycy9taXNj
L21laS9jbGllbnQuYw0KPiBpbmRleCA2NDNiMDAzLi4zOGI1NzkyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL21pc2MvbWVpL2NsaWVudC5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvY2xpZW50
LmMNCj4gQEAgLTY5NSw2ICs2OTUsOCBAQCBpbnQgbWVpX2NsX3VubGluayhzdHJ1Y3QgbWVpX2Ns
ICpjbCkNCj4gIAljbC0+c3RhdGUgPSBNRUlfRklMRV9VTklOSVRJQUxJWkVEOw0KPiAgCWNsLT53
cml0aW5nX3N0YXRlID0gTUVJX0lETEU7DQo+IA0KPiArCW1laV9jbF9mbHVzaF9xdWV1ZXMoY2ws
IE5VTEwpOw0KPiArDQo+ICAJV0FSTl9PTighbGlzdF9lbXB0eSgmY2wtPnJkX2NvbXBsZXRlZCkg
fHwNCj4gIAkJIWxpc3RfZW1wdHkoJmNsLT5yZF9wZW5kaW5nKSB8fA0KPiAgCQkhbGlzdF9lbXB0
eSgmY2wtPmxpbmspKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9tZWkvbWFpbi5jIGIv
ZHJpdmVycy9taXNjL21laS9tYWluLmMNCj4gaW5kZXggNGZiZjBiMy4uOWUxNGFiNCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9taXNjL21laS9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL21l
aS9tYWluLmMNCj4gQEAgLTE0OCw3ICsxNDgsNiBAQCBzdGF0aWMgaW50IG1laV9yZWxlYXNlKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlDQo+ICpmaWxlKQ0KPiAgCQlnb3RvIG91dDsN
Cj4gIAl9DQo+IA0KPiAtCW1laV9jbF9mbHVzaF9xdWV1ZXMoY2wsIE5VTEwpOw0KPiAgCWNsX2Ri
ZyhkZXYsIGNsLCAicmVtb3ZpbmdcbiIpOw0KPiANCj4gIAltZWlfY2xfdW5saW5rKGNsKTsNCg0K
VGhpcyBjaGFuZ2UgbG9vayBsaWtlIG5vLW9wIGluIHRoaXMgZmxvdyBhcyB5b3UgbW92ZWQgbWVp
X2NsX2ZsdXNoX3F1ZXVlcygpIGluc2lkZSB0aGUgbWVpX2NsX3VubGluaygpLA0KYnV0IG1laV9j
bF91bmxpbmsoKSBpcyBjYWxsZWQgaGVyZSBzdHJhaWdodCBhZnRlciBtZWlfY2xfZmx1c2hfcXVl
dWVzKCkgd2l0aG91dCByZWxlYXNpbmcgZGV2aWNlX2xvY2suDQoNClNlZW1zIGxpa2UgdGhlIGZh
aWx1cmUgaXMgcmVhbCBidXQgYW5hbHlzaXMgYW5kIHBhdGNoIGlzIHdyb25nLg0KSSBzdXBwb3Nl
IHRoZXJlIGlzIGFub3RoZXIgcGF0aCB0aGF0IGNhbGwgbWVpX2NsX3VubGluaygpIHdpdGhvdXQg
cHJvcGVyIHF1ZXVlIGNsZWFudXAuDQoNCi0gLSANClRoYW5rcywNClNhc2hhDQoNCg0KDQoNCj4g
LS0NCj4gMi41NS4wDQo=
