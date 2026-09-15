Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545C2DF3EA;
	Tue, 15 Sep 2026 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433115; cv=fail; b=Vx5BkpNPoSSIyPfrXLnKKLLhM9I2f6Qrk0aG0bkn8FdY8ucPGCBwd+kPD3mOFVWPCLh7bIeSbUskm5JoUB9xS25VUAPvqs4/1fW/D2wyD9EBXzq7wUkAKm4oXoL17IIPZ7zhJikGgbNREhO+DQ68XJAMrJ9OIIZElp9fJotZoKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433115; c=relaxed/simple;
	bh=qk95etRqhGUs4KvRtBJoeTMFrfVG6+/eIcX0yh1DhA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GmRilUo4wWvX2Euf3Pwf3BrluR91cIMXJSsNmNz4PUqRC8c+UYJvLefift7sV7xjnU+xiyNzogjuUOM+4N+DTTZys9M4fXF8/PVghOvjSf3H+fZEgCpdUkbdnRUF4FqKIk0zPV7mPELwlyj0Qy0eJHyrlpP4y8ZlfSsv92BhrBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmmdRoce; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmmdRoce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789433113; x=1820969113;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qk95etRqhGUs4KvRtBJoeTMFrfVG6+/eIcX0yh1DhA8=;
  b=LmmdRocemQiLddusWal3k67ldZE1cjAjpb+0ViyDHwOwEgpr7jTUhwrt
   orO3tjR62qKSZ9TzFqR01ZQBwk0Fr4fYAWU3B/Nl/lGyNQ/ook/UH5vlP
   qH9+Jhafs0cKIczfWwhAcpKSu9FJ9cUlA/Xg4ZtSOvf/6czeqdPYNyHi5
   1Bn1TloW9O0WPt0noIE30VuIts0SJC/LU4ubwP5flcVZsTEKAqYjvtuwS
   d59NsensTxPt5kRSwg94YJGz6NDT6FyHh85xIbK+YBxScxaNYuzH4kHyr
   rZ/MPXvXbLN7xbEWXoSFberU08os43cfTjLDq1G6NRAymtTPsTSdzwCWU
   Q==;
X-CSE-ConnectionGUID: dE6mxNKwRWy6vEFVOl+ZmQ==
X-CSE-MsgGUID: laTarMIPTPWOAL72gbwh0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77350476"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77350476"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 17:45:12 -0700
X-CSE-ConnectionGUID: kcRNA1/mTuSmACaE9RNJuw==
X-CSE-MsgGUID: YPUMDuTWRbydqlHgvsZZdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="272292612"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 17:45:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 17:45:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 17:45:10 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 17:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKzA0OrmkY7qV5wmrHqk/PdFUHjIA1McUVxFS1e3d41ECXwpEjZTkeTBSQbalv8nQdZiwAHVf9ToLKvmyDs9Nb2QaxiyByL09D1Q4APbHZ+pbC8mcwSipwhmDXXMlpSrNFP/i+zM2H5uOGip+bHG3B6ccZ5G6a0KTpHk25O3I5ZTXgaxtv1jqahdlTXQbjXwcKYav7CqPS/BcOmuGQ8ZOYvhOAQJUHXwP6ySal0t3kXu6vYDrjFt4GKDDzX1Ur5JhDEBP3XEM/8Beh1+ZPUa3R26SkMhflEsY4ITAoQdK6rO6PA7NigCufdggy/LxkyjWNgXE7FgzELJhJI1de9IiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk95etRqhGUs4KvRtBJoeTMFrfVG6+/eIcX0yh1DhA8=;
 b=nBSQqkf7PuWQoXiPnzH99EaJQJwIo2tA9dwE2ANiSjB4kb1wi7um3QqmSSv7ieCwMEZdz1ztGQjUnfBRkoIkllMx/3wmWH2gOT78+2onrfv/viaoQiA7K/2Skiv/lVXJERVc884KlMuXFrDwV0c3oYYDgEnT+kSAWymsb2C3gMUZXEebW4kG8ESgC8zoRsZUaFj5WliKRg3PK3IX32XV1pFF3E2iT7kCXecs/OnebAt75HWjOyRB0t7ZKM9bcBlZRG9rboo5M+hghiVlfywWiDImrbbJp53Cn2YF0xCQQ6JWd88oxDoba10RQkefQnABMtK1YaQuLk+fhz1JAPD9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:45:06 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:45:06 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "tkusters@aweta.nl" <tkusters@aweta.nl>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Kurt
 Kanzenbach" <kurt@linutronix.de>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net v3] igb: only strip Rx timestamp
 header on the first buffer of a frame
Thread-Topic: [Intel-wired-lan] [PATCH net v3] igb: only strip Rx timestamp
 header on the first buffer of a frame
Thread-Index: AQHdBGLoCAAQaetTbEi3S2Zt1UzEX7bPTbrA
Date: Tue, 15 Sep 2026 00:45:05 +0000
Message-ID: <LV1PR11MB8790D11491443603CBFC619490BA2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl>
In-Reply-To: <20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|MW4PR11MB6690:EE_
x-ms-office365-filtering-correlation-id: 77579e6b-0c49-48c0-add1-08df12c2960e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|921020|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: UN5j/2BRYd7/AI68YpVf2tLarhGh5tyZwBCA33kXwfDhGH7zfa5zKl1HI5MUqqYPidaEMX5R6fDtJ7pGJrPb4S6/liIzJ295X5qu1OVM25+XJ0sgSj1bH9HwFDEwxUeniQeUeOUlWC3mjwkcmuIllh2oCCXJwnm7hNeM/AGnYz5Qb7pwPRuKEmsP+rNRwoxVv14jxPpCT1m2Ot1wJvZSYicLx57K+YlYOlUfM7zM4ARJntk63fxQBLSuCMUILI/DKzI7QPG2is4g1MdtaY1CKhhmkp/9j7Y4GPZOCkbIpRvgjm7HlPN4rdlPOq8/5QcHrPD+3xxFvjtRdGPYCUginSsyUIEmdPq8A58JiH+dhahd3sY/j/veJ5z2eqrpZGYlAjVEkwX4xNj47CZFneQ/FwX8zJOXrnc2gkNj8o2KZ3Nt4U+u3jnsSJsdQyvBeuzPOh4FH93UDLWxVhhwUdQuDYRbnhA0Xyc0CgrTdziNS5Gy4X+AEmrlnFFT84fPrRSuH5ekJGmaI89Kfe9V9VW+JRQUaC9D6N6PlEXQAo5u6KIvxBt2zMAS899kwIl0+EVlqySCkCDbm2oLfhaeGR2lNJu+u8HZBBEdduiVQVg6b8X82kQhd9P0/+znZDyEYeXHV1y8FHiYKhrdTsOCQkmmZayKQDB9+kMgxDruqHnMi9zD2bP5fhJbremGAWzMP++C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(921020)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGdlN3pTT2kvY3BQcy82bVFxaTFHYWVVaUt1T3BTWDl4T3YwQ1ZpYnRwS0dV?=
 =?utf-8?B?TmJTdGc4MmsyZktBUlp2ZDdRWTJ4eGFFTzloOTd2RjhzTFhtVTk0d1NtaVdW?=
 =?utf-8?B?bWx3dVVjZUZTUDBTTHorcU5heUNhVXV3RUo5cDc0bFlHTGUzc0hCMEdtdlVV?=
 =?utf-8?B?RFo3c3pPMWpwWGg2cU0rY2YvdGtSbUh0NmtPWFJWeU4vaFc3MXJQREkwSjlw?=
 =?utf-8?B?VVNWc1N2MXI1bzJLSUNsUFVVSDYrMWpvTHBBZ1YyV3FwS0JOVmQ1V3FKQ2Z1?=
 =?utf-8?B?ZjdJZDNhSXlVSjdKaDV2UVBZNkE2SWtCeWE0TVZJNlJ0bHBVNWRMcGFVbDRX?=
 =?utf-8?B?Nk9nYkZMNGZRbkNFOU05RSsyUWExQWJXeW14cTY1dUgxQldOeEpuR1h1N21K?=
 =?utf-8?B?NkVIMTUzYndvNFJSaElrMDZFRDZ0UVFSaWdBa1RBdW4waERENUJWOWVXYVN4?=
 =?utf-8?B?MDhycmVvTTR4dU9nTC9YcW1MRGx5Uzh0akVEUkxMd1pvLytJMEtGYzE1R215?=
 =?utf-8?B?UW5qd05PcWlHNVgwdFJCTkRla1JRQUJ4RGY1QStBbkh3TmQ0bVlhQ2p6OFd1?=
 =?utf-8?B?WVB5MEMzK2ttcEZsSWVMTVhSVFNKYlNkSEhFeWxVNmFwQnM0czQ0bXhYUTdD?=
 =?utf-8?B?OG5vN3J2WGx0OEFNbWhSVEVsazF4Tmx1RU1xcVRTa0F5dUNjcVIvK0VBdWN0?=
 =?utf-8?B?MnVtVkdKTHhFVi9mK3VsQSt4dGQxZjBsRGFkeURlVm5mRXNkdWRKRGFtSmRK?=
 =?utf-8?B?QWpUb0h6aERFTEFhRXpKWHAvSXlHaVZZNjczdjZ0SUNDc2RQSEhHWWhFVGxo?=
 =?utf-8?B?T2hSWnVoZXZyZytSaTV6MVBJbU1kSy93WGFNazdsNWgwaTVpS1pxQ01kdDB4?=
 =?utf-8?B?WWFiZ1ZLdWxzN3BSYUVTVDBBSUR0Z3FVZk9IT2JZZXRTNjNRbjI1NW1CQk15?=
 =?utf-8?B?UThvVXFocktCMytWSVViMlM1ZHdrR0p2eGNzbHYydzRtR0xUUzlqODkxUURZ?=
 =?utf-8?B?SU8zRUk4cnVwOWdtTEt2dCtuczR6c3NyV3pVMGdZWXVRRk45YnNsNjFwN0U1?=
 =?utf-8?B?bHpjZEJyb1liNnhXUXRSZ25UdXhXcnFUUUdNSVNGSW9yc2Nja0pXOWpaMWI2?=
 =?utf-8?B?bjV6Q2JMS0d0MG5hcXh6dkdLUlpWVWhuamNvTWVNY2tndDZmSmd4aUh2ekRq?=
 =?utf-8?B?SmNScVhFUTh6REhBTDRDYndJNzd4bXVxb3J3L082ZFRlUEJpcisxUGJGVDgz?=
 =?utf-8?B?eHJZT0JkYk9qdk53djZTWk1VakRYc29SZVVNOTVFU2wrTVFlWjg5OGJvTW5W?=
 =?utf-8?B?MUNGQm14ZE1FWVFxMG4xTmdDNEI4eVg5dmkzOGMwb2pXUEZMWWMzU1lndTEr?=
 =?utf-8?B?cEpHRi83WFFmaG93M0R6UlhGSGpIZjhDYjlMUnAzWi9IeEE5N2FLWGtXVTd5?=
 =?utf-8?B?V1VhN0NjMWN0QzBjTFB4aVpGM0k3RW5pN2FIWmp3TjFON2xFeFdpWEVaaEhP?=
 =?utf-8?B?VFVoeUtnbmhhS0JqY0pEdlJUZTJQSTk1VkVFaVZvWk83TngxamwrYnIwNmd4?=
 =?utf-8?B?TURpV2cwcFNVUzlwUDBuVHBzZ1BQb3lXN0puY2IrK2RsNy9BV3NrNEVIZTla?=
 =?utf-8?B?Z0N6ODJkVlhSOGNsTDJtSjJBeXg4VElaamkzTTNDbHNRNEg5QzE2SGd6Wmp0?=
 =?utf-8?B?dG1paG14OEwwRzdRT0V3YWNmbmM3d0ZaNGZ6RmczRW5BbThmdDhzU2F5Zjcr?=
 =?utf-8?B?RFRaUFNJdjh2NnBMdlJqYTE2UzBTUHM1MVBpaHRhN2I2N20xM2NDdnYzbjFB?=
 =?utf-8?B?TnNndlZ4bk5KaVlxL0trOUl2eVpsSmhKZUVxeTVTZldraE56ODhmbTZvR25a?=
 =?utf-8?B?NVJNdmZwUzFpYmU0RDlrNjFFUWp1YjBzSEVMUWJxWGpLWnhyaWZhWjZQWTJs?=
 =?utf-8?B?REhvQ3RYSE16RUxIOU1DSjZPeU9ZSlRtNElUNFRKSHlZQ1ZHMFdKdlZBS3oz?=
 =?utf-8?B?NFFORDJRZ09pUWpuNDNHQzczdUkyRzY5QTRvaWRYTDZKS0QrRzd1RU1PWFoz?=
 =?utf-8?B?bVR2Tk8rdXhpR1VidzBSTmF6aGlRV3VWQVNLaCtJSEZZNEVJR08xbnlQWEhs?=
 =?utf-8?B?Wml3OGh6UDMrRThrbEdrRjZZQmlhZ1A0cE9PcGtYb1FRSGgzNlpzSVF5UkpI?=
 =?utf-8?B?MFV4dnhnNFYyYSsraDFHdkxtMkhWelhZVHZNcTF3b3M4NGFnaFVRTVN0YkJW?=
 =?utf-8?B?dUNFVCs2MW5taWdsc0dJWHQ2eENGMWxteDF2RDhIekl6ZnBydFp3TTA2MVZq?=
 =?utf-8?B?TkJqUS9LVFQ5SWFBRGwyUmM1cHV0YkRkVGxkell2bG1pR3IzSTFkQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Id71gCCgQoHJt+D4Kf4dJiM462SSeb+z8pa6nPmgTcAJ++w2lzPNRBdSU3dhdbrwHNZCPFVoV8n++rs/WkSs88tGJRKH9jnvYb+cjsGHdg/U92Goa9+Tlf+uxoKRk4wHf6Rmmy7KddrXadJF61o+kFxVDy9jXOq0xTxa4/SNDgzkuhfTFVHaNUE7R6L7pC50JaJqxY9PtEDyAwpA3vFr5IPit1tN/4/TvpFhpomE7MUqAKhweHm1UQlh7njlBttrdlcdsmWUZH9cOOsavTYwSz/u76pHlohiT8Gr3QHKCO/PPh8SMHxzTN+VY7eVN0m9QzS8x8+wx2VKniwFK9xtjw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77579e6b-0c49-48c0-add1-08df12c2960e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:45:06.0315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmKFsvBkGBHrqAdiYhaY93VsM3iFxJ4JrhwGa/HEigk8KBNQB1K+ja9c5kXCd5pftcH92Klnhm0fZ1X2O1looUcLagJUH0cvGQ81KXHMf5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbnRlbC13aXJlZC1sYW4gPGlu
dGVsLXdpcmVkLWxhbi1ib3VuY2VzQG9zdW9zbC5vcmc+IE9uIEJlaGFsZiBPZiBUamVyayBLdXN0
ZXJzIHZpYSBCNCBSZWxheQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjQsIDIwMjYgMTA6MjQg
UE0NCj4gVG86IE5ndXllbiwgQW50aG9ueSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IEtpdHN6ZWwsIFByemVteXNsYXcgPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRy
ZXcgTHVubiA8YW5kcmV3K25ldGRldkBsdW5uLmNoPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBk
YXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNv
bT47IFJpY2hhcmQgQ29jaHJhbiA8cmljaGFyZGNvY2hyYW5AZ21haWwuY29tPjsgSmVzcGVyIERh
bmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwub3JnPjsgS3VydCBLYW56ZW5iYWNoIDxrdXJ0QGxp
bnV0cm9uaXguZGU+DQo+IENjOiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZzsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3RhYmxl
QHZnZXIua2VybmVsLm9yZzsgS3dhcHVsaW5za2ksIFBpb3RyIDxwaW90ci5rd2FwdWxpbnNraUBp
bnRlbC5jb20+OyBMb2t0aW9ub3YsIEFsZWtzYW5kciA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRl
bC5jb20+OyBUamVyayBLdXN0ZXJzIDx0a3VzdGVyc0Bhd2V0YS5ubD4NCj4gU3ViamVjdDogW0lu
dGVsLXdpcmVkLWxhbl0gW1BBVENIIG5ldCB2M10gaWdiOiBvbmx5IHN0cmlwIFJ4IHRpbWVzdGFt
cCBoZWFkZXIgb24gdGhlIGZpcnN0IGJ1ZmZlciBvZiBhIGZyYW1lDQo+IA0KPiBGcm9tOiBUamVy
ayBLdXN0ZXJzIDx0a3VzdGVyc0Bhd2V0YS5ubD4NCj4gDQo+IFdoZW4gUnggaGFyZHdhcmUgdGlt
ZXN0YW1waW5nIGlzIGVuYWJsZWQgKGUuZy4gcHRwNGwsIHdoaWNoIGNvbmZpZ3VyZXMgSFdUU1RB
TVBfRklMVEVSX0FMTCksIHRoZSBOSUMgcHJlcGVuZHMgYSAxNi1ieXRlIHRpbWVzdGFtcCBoZWFk
ZXIgdG8gdGhlIGZpcnN0IFJ4IGJ1ZmZlciBvZiBldmVyeSByZWNlaXZlZCBmcmFtZS4gaWdiX2Ns
ZWFuX3J4X2lycSgpICBzdHJpcHMgdGhpcyBoZWFkZXIgaW5zaWRlIGl0cyBwZXItYnVmZmVyIGxv
b3A6DQo+IA0KPiAJaWYgKGlnYl90ZXN0X3N0YXRlcnIocnhfZGVzYywgRTEwMDBfUlhEQURWX1NU
QVRfVFNJUCkpIHsNCj4gCQl0c19oZHJfbGVuID0gaWdiX3B0cF9yeF9wa3RzdGFtcChyeF9yaW5n
LT5xX3ZlY3RvciwNCj4gCQkJCQkJIHBrdGJ1ZiwgJnRpbWVzdGFtcCk7DQo+IAkJcGt0X29mZnNl
dCArPSB0c19oZHJfbGVuOw0KPiAJCXNpemUgLT0gdHNfaGRyX2xlbjsNCj4gCX0NCj4gDQo+IEZv
ciBhIGZyYW1lIHRoYXQgc3BhbnMgbW9yZSB0aGFuIG9uZSBSeCBidWZmZXIgKGUuZy4gYSBqdW1i
byBmcmFtZSksIHRoaXMgYmxvY2sgcnVucyBvbmNlIHBlciBidWZmZXIuIFRoZSB0aW1lc3RhbXAg
aGVhZGVyIG9ubHkgZXhpc3RzIGF0IHRoZSBzdGFydCBvZiB0aGUgZmlyc3QgYnVmZmVyLCBidXQg
aWdiX3B0cF9yeF9wa3RzdGFtcCgpIGlzIGNhbGxlZCBmb3IgZXZlcnkgYnVmZmVyLg0KPiANCj4g
T24gYSBjb250aW51YXRpb24gYnVmZmVyIHRoZSBkYXRhIGlzIHBhY2tldCBwYXlsb2FkLCBub3Qg
YSB0aW1lc3RhbXAgaGVhZGVyLiBpZ2JfcHRwX3J4X3BrdHN0YW1wKCkgYWxyZWFkeSBoYXMgdHdv
IGd1YXJkcyBhZ2FpbnN0IGFjdGluZyBvbiBhIG5vbi1oZWFkZXIgYnVmZmVyOiBpdCByZXR1cm5z
IDAgaWYgUFRQIGlzIGRpc2FibGVkLCBhbmQgcmV0dXJucyAwIGlmIHRoZSByZXNlcnZlZCBkd29y
ZHMgKHRoZSBmaXJzdCA4IGJ5dGVzKSBhcmUgbm9uLXplcm8uIE5laXRoZXIgaXMgc3VmZmljaWVu
dA0KPiBoZXJlOiBQVFAgaXMgZW5hYmxlZCwgYW5kIGEgY29udGludWF0aW9uIGJ1ZmZlciB3aG9z
ZSBwYXlsb2FkIGhhcHBlbnMgdG8gYmVnaW4gd2l0aCA4IHplcm8gYnl0ZXMgcGFzc2VzIHRoZSBy
ZXNlcnZlZC1kd29yZCBjaGVjay4gSW4gdGhhdCBjYXNlIHRoZSBwYXlsb2FkIGlzIG1pc3Rha2Vu
IGZvciBhIHZhbGlkIHRpbWVzdGFtcCBoZWFkZXIgYW5kIGlnYl9wdHBfcnhfcGt0c3RhbXAoKSBy
ZXR1cm5zIElHQl9UU19IRFJfTEVOLCBzbyB0aGUgY2FsbGVyIHN0cmlwcyAxNiBieXRlcyBvZiBy
ZWFsIGRhdGEgZnJvbSB0aGF0IGJ1ZmZlci4gQSBmcmFtZSBzcGFubmluZyBOIGJ1ZmZlcnMgd2hv
c2UgY29udGludWF0aW9uIGJ1ZmZlcnMgc3RhcnQgd2l0aCB6ZXJvIGJ5dGVzIHRoZXJlZm9yZSBs
b3NlcyAxNiAqIChOIC0gMSkgYnl0ZXMgZnJvbSBpdHMgdGFpbC4NCj4gDQo+IFRoaXMgaXMgZWFz
aWx5IHRyaWdnZXJlZCBieSBhIEdpZ0UgVmlzaW9uIGNhbWVyYSBzdHJlYW1pbmcgZGFyayBmcmFt
ZXMgKG1vc3RseSAweDAwIHBpeGVsIGRhdGEpIG92ZXIganVtYm8gVURQIHdpdGggUFRQIGFjdGl2
ZSBvbiB0aGUgcmVjZWl2ZXI6DQo+IHRoZSBhbGwtemVybyBmcmFtZXMgYXJyaXZlIHRydW5jYXRl
ZCB3aGlsZSBmcmFtZXMgd2l0aCBub24temVybyBjb250ZW50IGFyZSBmaW5lLiBUaGVyZSBpcyBu
byBlcnJvciBpbmRpY2F0aW9uLg0KPiANCj4gTm8gY29udGVudC1iYXNlZCBjaGVjayBjYW4gcmVs
aWFibHkgdGVsbCBhIGNvbnRpbnVhdGlvbiBidWZmZXIgdGhhdCBiZWdpbnMgd2l0aCB6ZXJvIGJ5
dGVzIGZyb20gYSByZWFsIHRpbWVzdGFtcCBoZWFkZXIsIGJlY2F1c2UgYm90aCBhcmUgYWxsIHpl
cm8uDQo+IEZpeCBpdCBzdHJ1Y3R1cmFsbHkgaW5zdGVhZDogb25seSBhdHRlbXB0IHRoZSBzdHJp
cCBvbiB0aGUgZmlyc3QgYnVmZmVyIG9mIGEgZnJhbWUsIHdoaWNoIGlzIHRoZSBvbmx5IGJ1ZmZl
ciB0aGF0IGNhbiBjb250YWluIGEgdGltZXN0YW1wIGhlYWRlci4gSW4NCj4gaWdiX2NsZWFuX3J4
X2lycSgpIHNrYiBpcyBOVUxMIHVudGlsIHRoZSBmaXJzdCBidWZmZXIgaGFzIGJlZW4gcHJvY2Vz
c2VkLCBzbyBndWFyZGluZyB0aGUgc3RyaXAgd2l0aCAhc2tiIHJlc3RyaWN0cyBpdCB0byB0aGUg
Zmlyc3QgYnVmZmVyIHJlZ2FyZGxlc3Mgb2YgcGF5bG9hZCBjb250ZW50Lg0KPiANCj4gRml4ZXM6
IDUzNzkyNjA4NTJiMCAoImlnYjogRml4IFhEUCB3aXRoIFBUUCBlbmFibGVkIikNCj4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gUmV2aWV3ZWQtYnk6IFBpb3RyIEt3YXB1bGluc2tpIDxw
aW90ci5rd2FwdWxpbnNraUBpbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9r
dGlvbm92IDxhbGVrc2FuZHIubG9rdGlvbm92QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEt1
cnQgS2FuemVuYmFjaCA8a3VydEBsaW51dHJvbml4LmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBUamVy
ayBLdXN0ZXJzIDx0a3VzdGVyc0Bhd2V0YS5ubD4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+
IC0gdXBkYXRlIHRoZSByeC10aW1lc3RhbXAgY29tbWVudCB0byBub3RlIGl0IG9ubHkgYXBwbGll
cyB0byB0aGUgZmlyc3QNCj4gICBidWZmZXIgb2YgYSBmcmFtZSAoUGlvdHIgS3dhcHVsaW5za2kp
DQo+IC0gYWRkIFJldmlld2VkLWJ5IGZyb20gQWxla3NhbmRyIExva3Rpb25vdiBhbmQgUGlvdHIg
S3dhcHVsaW5za2kNCj4gLSBubyBmdW5jdGlvbmFsIGNoYW5nZQ0KPiAtIExpbmsgdG8gdjI6IGh0
dHBzOi8vcGF0Y2gubXNnaWQubGluay8yMDI2MDYxOS1pZ2ItcngtdHMtZml4LXYyLTEtZDNiOGQ2
MDVjYTYyQGF3ZXRhLm5sDQo+IA0KPiBpZ2I6IG9ubHkgc3RyaXAgUnggdGltZXN0YW1wIGhlYWRl
ciBvbiB0aGUgZmlyc3QgYnVmZmVyIG9mIGEgZnJhbWUNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+
ICAtIHJlc2VuZCB2aWEgYjQgKHYxIHdhcyBzZW50IHdpdGggYSBtYWlsIGNsaWVudCkNCj4gIC0g
dXNlIGZ1bGwgYXV0aG9yIG5hbWUgIlRqZXJrIEt1c3RlcnMiIChKYWNvYiBLZWxsZXIpDQo+ICAt
IGFkZCBSZXZpZXdlZC1ieSBmcm9tIEt1cnQgS2FuemVuYmFjaA0KPiAgLSBubyBmdW5jdGlvbmFs
IGNoYW5nZQ0KPiANCj4gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1BB
V1BSMDVNQjEwNjkxMDZENTJGNEUxN0YxRURCOTlDNjdCOTE4MkBQQVdQUjA1TUIxMDY5MS5ldXJw
cmQwNS5wcm9kLm91dGxvb2suY29tLw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lnYi9pZ2JfbWFpbi5jIHwgNyArKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBOb3dsaW4g
PGFsZXhhbmRlci5ub3dsaW5AaW50ZWwuY29tPg0K
