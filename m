Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793177862;
	b=lIJ0wJaqvwKRY4LmmwuHfdkpOjgffApXjaWWngq2b2uukOV03XwyKos8MTYXqG1oW0mz
	 k/ERpMjYaQfpGBCDs4/B24B5MDP2+ogWxnyjQqy0f2iR4RCCzj897+24GiD6D1jT/Fv/+
	 UpE9Jb3sbigdK2JHm4oEUneJTdrH+MNjeidZAjX+GPXVGi5Ma2ju00nK+xHcXuUja7VLj
	 /ItmOAoPIiZQifPGM3FEbNEv04m+C1M4KKlo7fgq0hIszYMOLOF4oI0fUJjGNbd/aRVVq
	 lSbLi7ju7vGtibMfrLQYlJevThO8HHnRFJ35tjYiB750n7thgZVzLy1RzWXHGxe+psg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177862;
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
	bh=BOtqFdoQHyXoF6mn/EeRTxVMHmnxSwJwoN5DcztaWow=;
	b=YhsBuZn9p20mstYkSr2Av1CFptVZLSkO+ysDR6fDnJCGISFONZTbmUHNO5P6RqmftXx9
	 s+qvUyRgU7+3JoabZPeK4WqIYlZRxlKh6bduf9OrqgWPapgyJpxzwURx75XJ4wZtKjs+s
	 gnkFGH1Lzez1bXuBASS5YIzZX7EgvU6jRfHfnxMAl0F4oQR4kokeFeS82lDD9M/ILhdQI
	 mtLzmUb3wXwekksrVnoGETrOSPKqceRzYJWhpBt6NtICKhz+B1rAqJU+nC402K5Za6djE
	 GZuohA5Mj1DbNyp6m6Q8UvF7kWVqrIRnp06KdR+TsAfe7voJhSzNjw77yWn+cYMVlGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hTn20zbj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09801606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09801606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hTn20zbj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793177861; x=1824713861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BOtqFdoQHyXoF6mn/EeRTxVMHmnxSwJwoN5DcztaWow=;
  b=hTn20zbjjN2lE+a6EFT0bLlWsoZ9Z5/3OIe23gFNjrcJFVqjMTptCCdw
   Bhl1ZZuczqV+GBTeb5lKb7Wpvzwvp7dfF4yM6/zPe1T4X8HG5iw7S+ZGU
   xNO43i9RfhAndJyP5CGI+toJrTuHK2qkYKWF0KWxNxhTTbFaj7n0ojRu/
   GbSEVd50XNOMahh5OeCmmfw5tD/zqRSoxtlgwJPdPhmSi+apri8YpEU5U
   nsDtpllK5Gr9gdAS3ebhfmCrVnNZdrREuJnUxixa+bLFSnie0QkoEujRz
   O7i1SEQcMkpD7vgJg9KBlrQ9nwW0x+GRl1Lyxvl7z/bvNuM/XjNf7R42z
   A==;
X-CSE-ConnectionGUID: 0Q9kRGfwT627fHZn92zgZg==
X-CSE-MsgGUID: ESML4O13QkmGepjYuMGSrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1883626"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1883626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:57:41 -0700
X-CSE-ConnectionGUID: YC2A3tMtSimNsFW0jzjv5Q==
X-CSE-MsgGUID: ZmjmA96fSFethFJQVdPCPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5105975"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:57:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 01:57:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 01:57:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 01:57:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiOjQDiLy46CtRqW5NPN/6UqfSCEFvocsR9ywK1u1F/A4KU5e81ePQb7/pH0y0IACFZrIWr42egsNxxz841vcdJdhlqvioPatvk3gPTYhvbYAkHbMROPz1I+K3wyAEv4t256t9U7zsj8H4E6FdyoQ0J5pZHz0+N89SRgk1ge+0dFI+ntK30VLACWrPZAOHh0joJv5YNa058MomVeEcFG440xBmwUmKMQatfbW9ZW/CA1ljdPLWMVAxvw8A/odFP9D7h5PkQL+DLX+r/mPCfo3UHmAT+0PBDE/g/xotR1nnAARL0ZfwwiyoeQVN7dLVitsOZxHt1CIr2/ijCICGhcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOtqFdoQHyXoF6mn/EeRTxVMHmnxSwJwoN5DcztaWow=;
 b=AngqSCAckW8jTep7TDRVBGtduEk2juz+JAslkgqKd7SA+ltPL+SnrRfTyy0Kmw/703rwDcDBX0yDiZYuDQSPTbDzfT/iWH/szOUFK+mCAuIecOSjm6UulQ5ghu5saIawLjhmViLnOx41GhQNd7G2+mqbOUXtO3C2iqT4NnyU/atwYUq8vQzpppz/CPEIiQ0HMup+zzWX3db8akmExf/HCXM1RzgXsEymSjp1f2qduekXquV/E45UoU474b+NzTVE5rptVWbCKd5aobIIgwUdH8n90JDzTvULev0ajcpOX77Z/kmtlxqC0I4TQOstOtIV3Es45VLmGMlMz4idEtbePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB8252.namprd11.prod.outlook.com (2603:10b6:510:1aa::14)
 by CY8PR11MB7396.namprd11.prod.outlook.com (2603:10b6:930:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 08:57:37 +0000
Received: from PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::9f66:9d6f:3199:78b2]) by PH7PR11MB8252.namprd11.prod.outlook.com
 ([fe80::9f66:9d6f:3199:78b2%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:57:37 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Topic: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Thread-Index: AQHdZqv2N/K1IP074U+vOvCtUeUWMbcSogiAgAAEZgA=
Date: Wed, 28 Oct 2026 08:57:37 +0000
Message-ID: <PH7PR11MB82526C4A1D72F22D44331A7B896F2@PH7PR11MB8252.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-3-vidya.srinivas@intel.com>
 <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
In-Reply-To: <94c3c16c-50ce-444c-985f-0fc0fb009242@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8252:EE_|CY8PR11MB7396:EE_
x-ms-office365-filtering-correlation-id: ed265cd1-81be-4563-1698-08df34d183a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|38070700021|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: XjCJG+sw9k+AB6ILhKapmxgsWVaPGphKoDIbbsZNuaVFYvdI2wkrHemVeTcbtWaGIGXkaWoPV2x/TPbjuQm05EzFlSMuN/CW2Sfuh2dx0SGl2Dt+1paC1XnlUZrazl+K/i7R3OhjgGiKSo9vob+kh7nIWCL7cgRIo4wICyo1YeQ4tIXxP5SpoL9IaKUL4s29mBrjv6SFRk6tDIJIX7DrJcP9pIeW+r6KP+cvCt3fAF8nMnzwFIimbIqbwW5nOZh9gmrmL/qW7V6XUgyJ+Sco3ODFSuvfTMmYvyhW/0R+Vapo49ejbW+UWUbENSTB5utPGmS3fck2XXE3SG/oWBZq0BxzeLRZkfffYUsFkwOjXA+cGEZO6J8q0ssSch4eZSbXHS0gm/iATEklmb0xAygrwL1ZanglXxI6MPc7avrz+B5Uq8u6/g4CzrFKv5gi50IlLAsVHfkgnqFrKXDsDOXkrFJq06f5i4T3SG6+OX6H3wuXBMuXl6QJowMVFIzNykDuwbWPz4ViNB8Z8j2SS8qdg23B/36ISBcdsBhsNXTVbHZJrlfgr2PNPhV/JP3JtExpSI3XItQ+FiuOeBzaqB0XQRMj8X1i5E9CRa6STftuza5wT/goaGk3uAGz7CZUuvz5UprIfLafxYQhoIjfwyHl/hZHVffeDuZVWKIiZfEWNLTMYL8iIasjf4Kj+8BknEC7up/uTb+zm5tmrwsEHFLm8HBC3s36R4eUrkuUnWGFCqo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8252.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Umg0TENFN0JQZ1MrUS9zSEtPSWlNQzNlSkVEQm1PK2hhOG5ScHJ3OGxIVEV1?=
 =?utf-8?B?Z3JIMVZkQ1VBTlFZeXpMVzM4Ky9aUGZyMVBSYUY4SnlhT2d4TWZ3WFR6d0VZ?=
 =?utf-8?B?aVFVVkJMQURGMDdoRFhwbjhjSk5BTmx4R09zWE02TklCUkNoUWFmSHJMcmpJ?=
 =?utf-8?B?L1RGYWs0UU9hZ2hKL0N5SzVGZEYzQTlHTDN2WENsZ2x2em82MTdHcGd2aW0z?=
 =?utf-8?B?Nmp2SFUxS3FQZ3FkZUNPY212SWJvQ3JtV2NhaVVCVmtQQ1JlUkdWOWZnRkEy?=
 =?utf-8?B?eWpINU9lRTVCUWxha2ZVTVhYREJLbEYzN29ZdEd4dlg3Y092bGRwaWY4MmJm?=
 =?utf-8?B?OE5mczZqTUFDRkZ0aDhMWm5wMDZJbEF0RTNIaEduTjlreVFvUVJUUGRFZlhT?=
 =?utf-8?B?bGVGbyt6bjUyZGpMNU90dWR4SlZSQVV4VlpQZk40RTN4T21NaHBRM1pEM1Zj?=
 =?utf-8?B?cG9Oc0NwNU8vVlFiS1VZenpYc1c3QjdwQzROdUcrV2RrMmhBY0ZhZEtOb1BF?=
 =?utf-8?B?VHFaOWNpQmVNd0pPamtac1NuTGZFYjF3aVJSMDJ2N3ZjcEFtMDhQcHB1b1N4?=
 =?utf-8?B?cVphVWtRaWNCNFhQSVV2eDlBUW0ydDZUSlRXT0NOYmlYYXlMKzEvdU04OUFK?=
 =?utf-8?B?bWRHTnhsSmRTOWJ4UlhGbklDcmw0alNIOUs1eHA3NVF1VGIzb2hhNHk1YWxB?=
 =?utf-8?B?cG1Gaml2RVNtMEY4cDZ5RTRDR0R4MWoxbEUwTlVZRHBRR1Z2OGNkK2dwRFRs?=
 =?utf-8?B?dzE3ZWd5aUVVK1hnMTg3SUJ5YTVGbkQzdk9JcVJER1dWZ3gvZTNyc0JYUjE3?=
 =?utf-8?B?VjFES25rNTlaR25PTVdvK2NFWEVrdkRNY2xjZ0dOTzlRTDl6UzNEOWRlUGRN?=
 =?utf-8?B?blFwYUs4S3liZlBUODFKRzQ5MENkVlRRRm9xdUI2RmNWWmthZUI3elJCVmlQ?=
 =?utf-8?B?SjhBUFFjdWNMMXNiVU91ZTFKSEo0VCtvSmhJaUMvSG5VS0tpWFM3UTc4Yzhj?=
 =?utf-8?B?UjNVUWU1ZzZBcXNCNmZvS3BZTmtBYW9GYm5yWW1Ob0gxbmxiRU4yaTM0QlBs?=
 =?utf-8?B?ZVlrUlUwcC9TcktBU3dTaGtQQW9PWEtMOFhLdGlhQXNwQWo3N3Q4cUYrVU93?=
 =?utf-8?B?UTdad2tJYnBoZm84TVAvS3hDNkd4N3d1SHY3cFprT3N4UEk0WndVdzloSGh2?=
 =?utf-8?B?KzRLRGdzNXNhdVVGbEdUS3hVK1FlUWhmMHBXNHBES1c5QUhWK2NQM0REdW9K?=
 =?utf-8?B?emNldEc2ZVRITkR1bmRMM2Qrc1pRTUE0cEhCTnFML3hHMVVwa25CMkZEc2E4?=
 =?utf-8?B?a3NreU9Manh4cThEV010Tk1MaTdRYzRzekoyS0VRWFJYcUpXZ0xVMWQweG1P?=
 =?utf-8?B?eVJBdzBxWkkrOGRqbGFScDdSODV6S0ZFKzRQMWg4V0RVcFI1RUF2WW9XVmNF?=
 =?utf-8?B?STREeXVwTVFDcDMxRzNNNzN3cnc2MXlZNm8zTkpCUjhjUXFrUkZIU09kZ2VK?=
 =?utf-8?B?b2JZWklBcWJwVjE1WnNXSDVYYUpEbW1UM2MzcDVnQmhnQjJTbmpCYnJIeDV1?=
 =?utf-8?B?NzlrZWdvR3RVVzRaQ2ZEa25lRVUxb3dkY1l6R3BRM3g0emE0NW14aSt2K3hq?=
 =?utf-8?B?V0llKytwd0l2bHg0SUF2c0xFSXdCbkFlVXJ0NG9kVEswbnFWN00zM0xnU0p2?=
 =?utf-8?B?VElQLzNnMmI1SXRSbUdZMHoyQXM0d1pMUzZ5VVhxVm9HUWVBdzI1SVprdjdV?=
 =?utf-8?B?bHE1cklQdDBGRzRyS2RXbGdvSW9nYWhhSC9iYXk3TG9HOW56STZZdmsreHpx?=
 =?utf-8?B?ZENPeTczUmRHNTk3TlJ6dDA0VnpLcy9hM0p0MzJaZVZNV3QxUFhRN201ZTFM?=
 =?utf-8?B?K0RNSDNRUHJGSk0zNXArOGprUkQ2bUZNeEZBeXdlL1QvWFc0K2lJOFBHS1l1?=
 =?utf-8?B?a1dmb2tDd00zSzNlZXlnSFhTV3BCWXpJQ1NzZTJiUXFydjc4ZW5NOGxXODVr?=
 =?utf-8?B?Z3pUSytzMHVXTlFJSmYzWGpMRGpodmpVRk5ya1pGcWJ6M25DenljM2dDWFpO?=
 =?utf-8?B?ZW5tcDNDc0hrWnFoWk82L1ZkU1dVYkM3akdVMFA4YThMR0t0ZEk5YWFZT2RY?=
 =?utf-8?B?T3F3ZC8yK0dyUGsyQ2kzdzVBR1FZS3FUV28rZHJMT0loK1htV1o4V3VyRWNy?=
 =?utf-8?B?M0xvM3VMbjRoVm9FdEhFaDhLQ2lod2FBeUhsbUpMYld5WVpsdjBmRE9JQTRn?=
 =?utf-8?B?cmRiMWlpNjd0UXNyTlhzbkI2VEVCYU0vUGsrUXUwK1pTRzRsZFEvNW1USFI4?=
 =?utf-8?B?dU9KSTBRU1c4V2dFTWdDZklTZitaVGtoZlpGU2lhZHVPMkdGS1FNUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ImlLwSmvwdT2OxeEbjXUH9zoT1ng43xumIyko6/wRc2dJQzxmLl+FeyGVUHKEHGN+Tu3aEXHyEch25QROeMXIpTpTD3MVW3WzsX62qt2xGyubtf4qzuGss2hkblR2gnuKYdf2jabmmeXX9JtB9xQx6DFzG3QxYkRzicNHnSlIe1fjNyxnQZdtMFBh5IS+zs5vFlDGXBh5zkA3E12Nu050epUQoQjxeGfdL3QOpXWaFJWSeuGQj1jn7LT6JWdFi3tVPQ0Mg7oz4hFJNbse/jZjanzIw8tnD0HWGN+vT550n0oMNCN4wUYaLE25s9E19VKnUEm9eHh9lsyzsoQG9w7CA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8252.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed265cd1-81be-4563-1698-08df34d183a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 08:57:37.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBtRdDNxrJ08emF2FZaIVR4WNCZYi3ROR/Xn4gqeROLRAJOeRM7BZ9nGkI5ScWxYFR0hH9pDApKPivWXvJALyn2TNykKzLdr2XquOozSv78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7396
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yYWgsIENoYWl0YW55
YSBLdW1hciA8Y2hhaXRhbnlhLmt1bWFyLmJvcmFoQGludGVsLmNvbT4NCj4gU2VudDogMjggT2N0
b2JlciAyMDI2IDE0OjA4DQo+IFRvOiBTcmluaXZhcywgVmlkeWEgPHZpZHlhLnNyaW5pdmFzQGlu
dGVsLmNvbT47IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IGludGVsLXhl
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU2hhbmthciwg
VW1hDQo+IDx1bWEuc2hhbmthckBpbnRlbC5jb20+OyBqYW5pLm5pa3VsYUBsaW51eC5pbnRlbC5j
b207IExpbiwgQ2hhcmx0b24NCj4gPGNoYXJsdG9uLmxpbkBpbnRlbC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMi8yXSBkcm0vaTkxNS9kaXNwbGF5OiBEaXNhYmxlIHBpcGUgam9pbmVy
IG9uIFdDTA0KPiANCj4gDQo+IA0KPiBPbiAxMC8yOC8yMDI2IDEyOjM0IFBNLCBWaWR5YSBTcmlu
aXZhcyB3cm90ZToNCj4gPiBQaXBlIGpvaW5pbmcgaXMgbm90IHN1cHBvcnRlZCBpbiB0aGUgV0NM
IGRpc3BsYXkgY29uZmlndXJhdGlvbi4NCj4gPiBSZXBvcnQgbm8gam9pbmVyIHN1cHBvcnQgb24g
V0NMIHNvIHRoYXQgbW9kZXMgd2hpY2ggd291bGQgcmVxdWlyZQ0KPiA+IGpvaW5pbmcgYXJlIHJl
amVjdGVkLCBtYXRjaGluZyB0aGUgNGsgNjBIeiBtYXhpbXVtIHJlc29sdXRpb24NCj4gPiBkb2N1
bWVudGVkIGZvciB0aGUgcGxhdGZvcm0uDQo+ID4NCj4gPiB2MjogUmViYXNlIG9udG8gbGF0ZXN0
IHVwc3RyZWFtDQo+ID4gdjM6IEZpeCB1cCB0aGUgY29tbWl0IG1lc3NhZ2UNCj4gPiB2NDogU3Bs
aXQgdGhlIHNjYWxlciBhbmQgam9pbmVyIGNoYW5nZXMgaW50byBzZXBhcmF0ZSBwYXRjaGVzIChK
YW5pKQ0KPiA+DQo+ID4gQnNwZWM6IDc0Mjg2DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gDQo+IFdvbid0IHdlIG5lZWQgYSBGaXhlcyB0YWcgdG8gdGVsbCB3aGVyZSB0aGlzIGNo
YW5nZSBuZWVkIHRvIGdvIHRvPw0KDQpIZWxsbyBDaGFpdGFueWEsDQoNClRoYW5rIHlvdS4gWWVz
LCBJIGRpZCBjaGVjayBjaGVja3BhdGNoIGdhdmUgdGhlIHNhbWUgd2FybmluZyBidXQgSSBjb3Vs
ZG7igJl0IGZpbmQgdGhlIGV4YWN0IHBhdGNoIHRvIGNhbGwgb3V0IHRoZSBmaXhlcw0KVGhlcmUg
YXJlIHBhdGNoZXMgbGlrZSBFeHRlbmQgdGhlIG1heCBkb3RjbG9jayBsaW1pdCB0byBXQ0wsIFJl
c3RyaWN0IG1heCBzb3VyY2UgcmF0ZSBmb3IgV0NMIHRvIEhCUjMsDQpkcm0vaTkxNS93Y2w6IEFk
ZCBkaXNwbGF5IGRldmljZSBpbmZvLCBBZGQgcG93ZXIgd2VsbCBtYXBwaW5nIGZvciBXQ0wgZXRj
Lg0KZ2l0IGxvZyBzaG93cyB1bmRlciBtZXJnZSB0YWcgdGhlICJBZGQgc3VwcG9ydCBmb3IgV2ls
ZGNhdCBMYWtlIChXQ0wpIGRpc3BsYXksIHZlcnNpb24gMzAuMDIiDQpTbywgY291bGQgbm90IGZp
bmQgdGhlIHBhdGNoIGZvciB3aGljaCBJIGNvdWxkIG1lbnRpb24gZml4ZXMuDQoNClJlZ2FyZHMN
ClZpZHlhDQoNCj4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBDaGFybHRvbiBMaW4gPGNoYXJsdG9uLmxp
bkBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFVtYSBTaGFua2FyIDx1bWEuc2hhbmthckBp
bnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmlkeWEgU3Jpbml2YXMgPHZpZHlhLnNyaW5p
dmFzQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZHAuYyB8IDQgKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vaTkxNS9kaXNwbGF5L2ludGVsX2RwLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZHAuYw0KPiA+IGluZGV4IDAwZTAyZTAxOWQyNS4uZWYxNjRhNzk3NjE4IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHAuYw0KPiA+IEBA
IC00ODUsOSArNDg1LDkgQEAgYm9vbCBpbnRlbF9kcF9oYXNfam9pbmVyKHN0cnVjdCBpbnRlbF9k
cCAqaW50ZWxfZHApDQo+ID4gICAJCQlyZXR1cm4gZmFsc2U7DQo+ID4gICAJfQ0KPiA+DQo+ID4g
LQlyZXR1cm4gRElTUExBWV9WRVIoZGlzcGxheSkgPj0gMTIgfHwNCj4gPiArCXJldHVybiAoKERJ
U1BMQVlfVkVSKGRpc3BsYXkpID49IDEyICYmIERJU1BMQVlfVkVSeDEwMChkaXNwbGF5KSAhPQ0K
PiA+ICszMDAyKSB8fA0KPiA+ICAgCQkoRElTUExBWV9WRVIoZGlzcGxheSkgPT0gMTEgJiYNCj4g
PiAtCQkgZW5jb2Rlci0+cG9ydCAhPSBQT1JUX0EpOw0KPiA+ICsJCSBlbmNvZGVyLT5wb3J0ICE9
IFBPUlRfQSkpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IGRnMl9tYXhfc291cmNl
X3JhdGUoc3RydWN0IGludGVsX2RwICppbnRlbF9kcCkNCg0K
