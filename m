Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795090277;
	b=rsKi1YTVlGkXVjBwYSst6bhvK/0zDuKqbpw7+TbMz+xNrSpyIERCOTHrgeIr2vLLvZr2
	 jDP5dekgRvTT9exHCGBlwfsT5bxrW4Z4PsQwJ9PMGIHH/Kg5alTYMbAyvMlb8+yVIIFvA
	 3PLxp2KswuPonp/NQWx7Dwpo7CtR6Aos8Eddy13uN127EsYc5sr+8bM6Hb1nshRsAqowB
	 k/x7Y5mV6A+fqWAn1gy2vhGkM2rqfl+TvYIM/cEF2BAF8lrJUzpkUiCDosYS7F1lT+uBt
	 rGdn2dOIl/doLqa/dJW8frFumRopAdFLwsvNad0KWBuM4w7dI0+BRx5Drdc3sJa6mnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090277;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=dWxb7M02KFPlYOvaosjxut40xcQkajq7xF7LFqf2/qc=;
	b=K1pIibwlbhgYijT7lgDrbtN4kqDqvWl/3oSTsW4VPrTtUJojOc1B3VyG0YZcX4O+1pZj
	 37ja68eGRiIwlq6HKETzFYbZGX4SLIDbsu89SWV6F7HQnDqW6WHLsolkxqfDn2CPl6lYL
	 6WMlBo6ysbautOgTH3XnT1fKkNA8U1sVone3e/PY72/jMf7kUJeIvIAaCB7D/pTwlbj6X
	 1+rbM3nFqg0jI/7WFEa5UksT8S5DsbdYPgBX+m5j53ASyOS+TYh9ry4ab0STx4HfhC2+s
	 mjvILv007ChEpawBKrVC/ki3AL82wU0sJt30p5NcNmmVMLqxgycxMHPSAtyS5KYJaiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aLxAOoZY;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JPp8naQl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5C606A324;
	Thu, 19 Nov 2026 12:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF5C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aLxAOoZY;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=JPp8naQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795090277; x=1826626277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dWxb7M02KFPlYOvaosjxut40xcQkajq7xF7LFqf2/qc=;
  b=aLxAOoZYwhxH/iWz/7s70l8vr5n86UMcS28FIIa7B1hGzF7gvgrIWlFL
   wiV3AFpLC0GY7feXbyTA+jfQYxLjWRfSgSdVUmAPeTLGRg03ypM7hnkkY
   NZtl0svfkYSjx9VM7IogaRHfp+TCkJjUQCZLJYcUuA5DMUZLa6xnG3AiK
   ntlo4irajMAgL31JCPRusUlKVHE2G8A8m13eZNKaRc2YsEdaCjnYbUAeO
   c3mfBL7Nm6hlMZw2fMOsPoZ1muiFmu2B5LnMNCCPkNLbTFNZqCo29zJy7
   ydRS5IamkHtwr5uhLIQjjSXqb0PbaZ1WocQfUSCOm0FvgTz3Bh/3sk4yR
   w==;
X-CSE-ConnectionGUID: gJ8eSR4NQi25K3OjlUMyPw==
X-CSE-MsgGUID: 6MPdgx+/QVm76nuOhmPd2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3781419"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3781419"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:11:16 -0800
X-CSE-ConnectionGUID: uHO4MJuVSzm2gJr90mBWGQ==
X-CSE-MsgGUID: bZYv6H4ZSPqkJZY8H+Xy3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10753617"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 04:11:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 04:11:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 04:11:15 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 04:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1u6/GrajoKshOIP2IThAYUXmho31uA+xRsycdxsLmDmEmDs2zleZm90DVdcRjQ41csoqrAUa+s5wr611BVXaroaeRQB/HWEv2Dze+PYk4JNUX4oA1MxrkGoc/ZCb8Qne5Ph8beGzv6KsvkVh8JNynEnX3eZz7Y+zuvso9FoOyhithNN3URT5QbH6zXHbSohZDidB4m6jks0utY13IIQ6BAQxqfC8DF3OHZBR7DvhB/AWrMyyJaP0vkEnF4uOS2T227d0XBYS7/PHffSgUfu4D8biT/H0luzasjffmz0YP7sgpYXK3y5NnbeGc0UOA3piCv6HOxkaqCMmnqv1S166w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWxb7M02KFPlYOvaosjxut40xcQkajq7xF7LFqf2/qc=;
 b=ET3BApZfG9D+XDkRp90e6DAV63eJC0JnLQ7m8vrxGs3zCq/ZxcMAEcdWsPcGLlMElg6LQl/UCkTphestEsJwsZIlYP36RpjDAXwbLKwn6L7xJ2uqos2bBv5nCDE8vdiFTcyY4j/U6+928lpXTtNi8j+XMPv8NBTMVUm7hT/yw/xAiZ5AgjJ2bhvzFCmUpwN/ViPUGUGBelnb97s86f0UIUqy9Q2ws0S1tALNlkz05as/LT472YgUVJ5FswjkDNO/2YGA2XZ+BNpigM8HlqlxqsSxL1evxIDx2Fs+G0yjmNwq0m15e/80HX9nQMOLh+/rfvKuMlN1WkxjPMbf/VeYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWxb7M02KFPlYOvaosjxut40xcQkajq7xF7LFqf2/qc=;
 b=JPp8naQlH24DqngSHxUxwun1pmBrrSUKKO/5f8BY88voZzvhwFnzuHFxwQl3J4yZtildylMjlH9C29jGRyuRNPVQqa/NFyga5dtaz2DM0Ll3N/qjW5+grAp9uPVJ7FveGW3lR5OQShLbHIfYlQ2VyxQe9vXXgeycKKv+hWWugsA=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by PH8PR11MB8260.namprd11.prod.outlook.com
 (2603:10b6:510:1c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 12:11:11 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 12:11:11 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Dominik.Dvorak@econ.muni.cz" <Dominik.Dvorak@econ.muni.cz>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2] ice: fix Rx byte accounting for dropped XDP
 frames
Thread-Topic: [PATCH iwl-net v2] ice: fix Rx byte accounting for dropped XDP
 frames
Thread-Index: AQHdcG58WzOE2FJ1bUmCRPiVsbLG+rc1XTSg
Date: Thu, 19 Nov 2026 12:11:11 +0000
Message-ID: <CH3PR11MB56689596494C5226DA91089269E5792@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261109-ice-xdp-rx-bytes-v2-1-7d6035e687e2@econ.muni.cz>
In-Reply-To: <20261109-ice-xdp-rx-bytes-v2-1-7d6035e687e2@econ.muni.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|PH8PR11MB8260:EE_
x-ms-office365-filtering-correlation-id: 40db467f-4803-4e67-dc43-08df4636339f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|56012099006|261026140227099003|11063799006|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261026121527099003|261021135927099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|261009223027099003|3023799007;
x-microsoft-antispam-message-info: S6QjSnYEnxlhARbzLpz1gWoSqgRAamRtCtNMFEG0GEitexSE6LgcohLghPWie8+vH8GH//C4OA7M9uGGAo2poPg+RolNLAJnT9Xqd3tgAssoYAD4ztvHRW0k1LAaWTuY84hQtbzHBaXNF6tkuWPiireqPynTtcZGFvzuYoSjEr+AHlplq2zbwZLjp13ZJQNooKpqNEb5If7cmDDR8ITc9iV7KdYUL1o+7Bjm88Jl7vrYaXD0k8oYRL/gYhyzZefTNK+W5DQ0iMJfMLPfBmj2nRB62UmMWw+dS/lsxJM9zkg9FQcYm33hfpNsVWW0SsK4ownY/8o7t5v5zuuW/kZ9lZYY+217Zo8YGE6miGJ79Xu/ZF9txQLd0rgXQTmlyEb1ULGQ667ITRZ+MyfeYc1WhXkVbnzJxVtJE7JNfOureSqlpMcWvUqYG+voDKVGPtg3j3N3DDR5d1l7nvjee6FCNOoMSs3EAA2TfloknpnqxiIp1Ahz6s8rAZbhIix58PF1RfpGO0Rz71tGTJM1VsIXAD6W5q4i7y2g9jQhEpQQx1O1O9yQQl3DXLliT5qlnzp216UTHVKPaRfw8h/n9mNj1xaBf7N49M2H2hdFWNXGstPmy4hlvHJlVHKcF9ZYcVP0qwH7CTvENTsTMPIjDxvccxuN+JvJtWO2V8d0YSAcqa0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(56012099006)(261026140227099003)(11063799006)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261026121527099003)(261021135927099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUxPbTBMRi9raTU2WEwrazlzUU8vSUlyNU4wVDdOZ0hiMndNdk84NGYxVGVj?=
 =?utf-8?B?MEFyZnI4ODVLdlJMNzVucUdNZUl4cnhUQ3BFQTc4c2hZWFhLNUlNUFdoMVdx?=
 =?utf-8?B?MlBPS29GM2VUYWZLcmN4clQrUVlYVldPUkRQamRRMys5cUR0RzVmcUJ1RWdv?=
 =?utf-8?B?SUZHWW1RZ21sN2g1WHNBRWVlRVFueHI4U2NLSFgxQU5wRENwMllYUU1vQzY5?=
 =?utf-8?B?cWgxclRXSUovY3AzSEpoVjNLVWJlUmY3UHZNYm0yTnZrd0JyeEJLbDR2TnJ1?=
 =?utf-8?B?eVV6VVNtbmo0OFFhMUprb3FLYTV6TzJPSEt3NGE0QVc2eCtpcnlnaGV3bFJB?=
 =?utf-8?B?d0RxWjNBQlhJWmFwN3N0RElqTDczUFpGc2hqUDQ2T2YySlNoVVpXNUJwSkRC?=
 =?utf-8?B?bWU2bHpSaGZWQWIwdmpXTlF3SUNHVzZTSW55V1hHdzRmcTI4M3ZUSGNWeHVE?=
 =?utf-8?B?SGNqaGgzZ2VCWTFWbEluTXlyZnFBajNMR3dLdE85NGZuYWRVamIyYzJsWGdY?=
 =?utf-8?B?L1E2NnlDR001RkNDWkZjQ05DVXlsOFRtQXZWY2JJaEpVbTZxYi9Yb0o4eG4v?=
 =?utf-8?B?QURFc080QlJwRXpySXViMXZ6WnhOVWpoZEFkcXZRakZSS3E4ZHFjUzdGUG1y?=
 =?utf-8?B?RE9Ic2tsUUtYTHdLcjZRZ1hrb3VnRGgrT1UvNDFFenV4QXJqdTBySWJ6ZWNt?=
 =?utf-8?B?endwV2Z6MW1GM0xwbE1VODJXd3FGeStjNGRMcithUXppWERiMkVxUHc4bGhC?=
 =?utf-8?B?Y29LSHk3UzU5L1dydVg5ekdGVXY4SWRhRTRWZEF5NFpzemdMakdPeUc4RTd6?=
 =?utf-8?B?OXNQV3ZsRGNFTEVJZUZSTDVEVDNveUwwaVZycjVQdkpocm5FbWY3ZzJqYm9a?=
 =?utf-8?B?cy93TlIzY2tIN0FyaG92bVc5RlVkdFlzaUVDR1dPUGdwc0FGQW02WFYzNmNa?=
 =?utf-8?B?bkdkR0RjOHdMbFc3dzhQamE2Mjl5K3JvTDNvcG9MM3ZDRHlWeHp4aFdKRTV4?=
 =?utf-8?B?dklnZW5OaVZTbWRTaEN2d2Z5c3lEblRiTE9nOW9SOEczR2V0S3hlWmQram81?=
 =?utf-8?B?bjl4cmR3bmJvTG1LekcraU9Oa2djYUlFYXRLRlg3ZkVQd21CWWtSb3oyQjJI?=
 =?utf-8?B?NjVoQW5kcnpLUHRtTFRmRnM1RGw5YWdtcWY0NEpzdnZ3VWx1czNuckxrNVlR?=
 =?utf-8?B?b1g3M1UwbGJvUUY5THljRmltVWNNazV5YUZIcWdUbzM0QUVJck9meVlCMGJ4?=
 =?utf-8?B?cWxYck9EM0NrbkVxcDZQYUxvaW8yNVIyT1kxSzd5WHRzdmVGV2gvT2h6SkhD?=
 =?utf-8?B?VjhNRHc1WDN4NEQxVnp6UGpLNjcrSHh1N1hoTW5jbkRPQWN1MUN1ckpsclpo?=
 =?utf-8?B?VktxMkMzSk40ZTV0Z2dQc2IwUnl2Q3FhYm9XZG5rUXo1djJ6blJCSG1YMHB5?=
 =?utf-8?B?VzJjRlg3dHJBOWh0eWY0V0d0NnRRQW56am9ua01CbU4wWERhMlZXeTFzejNX?=
 =?utf-8?B?MnFTaWZDSk5XeHgrMVlod2VoMWIzaGg1ekdEUjRqZzdSempNdFIzeUdLUHVU?=
 =?utf-8?B?Ni81eHVaLzU3cGRsS01HMGZOMWlpM0dST3lHbzdiRC9YUHhiQzFFalplU0d4?=
 =?utf-8?B?YU9IWVJGVWxUbWVOeU9CcXhCNlVSWTNWejlKa3JHVzJEODZ1TkltekN2VlU3?=
 =?utf-8?B?c0RpYktrWk5sdUUxb0F0dDN2ZCtHL3VyQUFmYUdrMlY3TEFRdnJKUWpZL2JG?=
 =?utf-8?B?TlJ1bTNOS1l5VVdhajBQYWpRT0JLS1pnNUR2Q29aUnNkWTVuRWZOMEM3eHRi?=
 =?utf-8?B?bTZLUHo5Vnp3WVF4VTVHUzJKMEd2U0V5TW5WR1ZNK0Z2MzZtL0RpUElwMkhS?=
 =?utf-8?B?QVM4a2h3SjVtampuNGozOHBDTU9EYWN1K2lzZkFwSHY0Y3NHQlVVb0F2cjgz?=
 =?utf-8?B?eWZFNnlIUWZwRlpJTFk3TXhsUzlOcGNGakFmQUp1Z1VmTDNsc2VyeVJ2WlJN?=
 =?utf-8?B?OVYzaW0zRkE1R2xvUEo2Tm5zYThEWUx2TkloaWRPYU1RMUYxbjhQNzR5MkpH?=
 =?utf-8?B?MTlvb0VpOWRqVyt2VjRLNEwvRTFhV2pqOHRCWWttN1ZuK3hDUnpBQWdyMDY4?=
 =?utf-8?B?WStoWUtISEc0cUNHVlJCQnBBbGtBckhxV2ZDQ2EvUHpYQWYrL0xMTVYvTEpN?=
 =?utf-8?B?UVNNRklDRFNkOXFZZG5FUWRJWFRmV1orMkQzVHNYT1EvTjY3SncyS2ptWFQ0?=
 =?utf-8?B?L2xKSkFDVEIrYUdHeGJrSEIrUHZvamlMUDJNSHc2aTdIbHhuRC9OTUFaSXpB?=
 =?utf-8?B?OTNWQUhPcnlyTnZIcGFOVUNvb1k0QW1GOUFFVUN3SkllYXdvaEhYRWNUSTlP?=
 =?utf-8?Q?ReY924D4ubx+JuD0=3D?=
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
X-Exchange-RoutingPolicyChecked: ENAEICPbw1yxFCCrQgGGPYj6Cftf1wp+5LFbkhSs6I2y/8cZbZOYYH++BjdKq69V48FUzJyroQ+AJTAACdNoqMhRuvXMiYBwSYkSpGb1JBeoYN7ZSuhRJjG1OeToDiJ/s4axJJfKOaj6rB0OdvG+brr48emyVKEFndCqJMCbdFC4VIHKQiJmq3D8NV+RPHp3aHIl8aEgM4BjdweBTNH9ZpMTzI3ot9QFzDiBTC0AsfThfMh6CkZ5pAme+xOT57LNWJTzWKM+x4fRk32gywYzmX61O9Qf+Sz0K9qYzhycHh9Y1LrV3OTqnA46H6TKzQhdxVEOJ6UxFBsxIYEbKEQZbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40db467f-4803-4e67-dc43-08df4636339f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 12:11:11.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0g1Ak7LdaLeU0eIEjGuh25tYkFQQmw4PYpjbBFuMcfZivkg91+wyHCJyzqwqsbGjISaK3JWNJj1PcYK8Vr2H5LZ5iP752uAoLNGg6jmtEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8260
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG9taW5payBEdm/FmcOh
ayB2aWEgQjQgUmVsYXkNCj4gPGRldm51bGwrRG9taW5pay5Edm9yYWsuZWNvbi5tdW5pLmN6QGtl
cm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgOSwgMjAyNiA5OjI0IEFNDQo+IFRv
OiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgRmlqYWxrb3dza2ksIE1hY2llag0KPiA8bWFjaWVqLmZpamFsa293c2tpQGludGVs
LmNvbT47IE5ndXllbiwgQW50aG9ueSBMDQo+IDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47
IEtpdHN6ZWwsIFByemVteXNsYXcNCj4gPHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBM
b2Jha2luLCBBbGVrc2FuZGVyDQo+IDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPjsgTWlj
aGFsIEt1YmlhayA8bWljaGFsLmt1Ymlha0BpbnRlbC5jb20+Ow0KPiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnOyBEb21pbmlrIER2b8WZw6FrIDxEb21pbmlrLkR2b3Jha0BlY29uLm11bmkuY3o+DQo+
IFN1YmplY3Q6IFtQQVRDSCBpd2wtbmV0IHYyXSBpY2U6IGZpeCBSeCBieXRlIGFjY291bnRpbmcg
Zm9yIGRyb3BwZWQgWERQDQo+IGZyYW1lcw0KPiANCj4gRnJvbTogRG9taW5payBEdm/FmcOhayA8
RG9taW5pay5Edm9yYWtAZWNvbi5tdW5pLmN6Pg0KPiANCj4gU2luY2UgdGhlIFJ4IHBhdGggd2Fz
IGNvbnZlcnRlZCB0byBwYWdlIHBvb2wgYW5kIGxpYmV0aCwgaWNlX3J1bl94ZHAoKQ0KPiByZXR1
cm5zIHRoZSBidWZmZXIgaXRzZWxmIHZpYSBsaWJldGhfeGRwX3JldHVybl9idWZmKCkgb24gWERQ
X0RST1AsDQo+IFhEUF9BQk9SVEVEIGFuZCBvbiBhIGZhaWxlZCBYRFBfVFggb3IgWERQX1JFRElS
RUNULiBUaGF0IGhlbHBlciBhbHNvDQo+IHNldHMgeGRwLT5kYXRhIHRvIE5VTEwuIGljZV9jbGVh
bl9yeF9pcnEoKSB0aGVuIGNhbGxzIHhkcF9nZXRfYnVmZl9sZW4oKQ0KPiBvbiB0aGUgc2FtZSBi
dWZmZXIgdG8gdXBkYXRlIHRoZSBSeCBieXRlIGNvdW50ZXIsIHdoaWNoIGV2YWx1YXRlcw0KPiB4
ZHAtPmRhdGFfZW5kIC0gTlVMTCBhbmQgYWRkcyB0aGUgbG93IDMyIGJpdHMgb2YgYSBrZXJuZWwg
YWRkcmVzcyB0bw0KPiB0aGUgcmluZydzIGJ5dGUgY291bnRlciBmb3IgZXZlcnkgc3VjaCBmcmFt
ZS4gRm9yIG11bHRpLWJ1ZmZlciBmcmFtZXMgaXQNCj4gd291bGQgYWxzbyByZWFkIHNrYl9zaGFy
ZWRfaW5mbyBmcm9tIGEgcGFnZSB0aGF0IGhhcyBhbHJlYWR5IGJlZW4NCj4gcmV0dXJuZWQgdG8g
dGhlIHBhZ2UgcG9vbC4NCj4gDQo+IE9uIGFuIEU4MTAgd2l0aCBhbiBYRFAgYmxvY2tsaXN0IGF0
dGFjaGVkIHRvIGFuIDgwMi4zYWQgYm9uZCwgdGhpcyBzaG93cw0KPiB1cCBhcyBqdW1wcyBvZiB1
cCB0byA0IEdpQiBpbiB0aGUgcGVyLXF1ZXVlIGFuZCBuZXRkZXYgcnhfYnl0ZXMNCj4gY291bnRl
cnMsIG9uZSBwZXIgZHJvcHBlZCBwYWNrZXQsIHdoaWxlIHRoZSBwYWNrZXQgY291bnRlcnMgYW5k
IHRoZQ0KPiBoYXJkd2FyZSBieXRlIGNvdW50ZXIgKHJ4X2J5dGVzLm5pYykgc3RheSBjb3JyZWN0
LiBUaGUgYm9ndXMgdmFsdWVzIGFyZQ0KPiBhbHNvIGV4cG9zZWQgdG8gdW5wcml2aWxlZ2VkIHVz
ZXJzIHRocm91Z2ggdGhlIG5ldGRldiBzdGF0aXN0aWNzLg0KPiANCj4gQ291bnQgdGhlIGZyYW1l
IGxlbmd0aCBvbmNlLCBiZWZvcmUgcnVubmluZyB0aGUgWERQIHByb2dyYW0sIGFuZCB1c2UgaXQN
Cj4gZm9yIHRoZSBieXRlIGNvdW50ZXIgb24gZXZlcnkgcGF0aDsgdGhpcyBhbHNvIGRyb3BzIHRo
ZSBkdXBsaWNhdGUNCj4gc2tiLT5sZW4gYWNjb3VudGluZyB0aGF0IHRoZSBYRFBfUEFTUyBwYXRo
IGRpZCBhZnRlcndhcmRzLiBUaGUgZnJhbWUNCj4gbGVuZ3RoIGFzIHJlY2VpdmVkIGlzIGNvdW50
ZWQsIHJhdGhlciB0aGFuIHRoZSBsZW5ndGggYWZ0ZXIgYSBwb3NzaWJsZQ0KPiBicGZfeGRwX2Fk
anVzdF9oZWFkKCkvYnBmX3hkcF9hZGp1c3RfdGFpbCgpLg0KPiANCj4gVGhlIHByb2JsZW0gd2Fz
IHRyYWNrZWQgZG93biBhbmQgdGhpcyBmaXggd3JpdHRlbiB3aXRoIHRoZSBoZWxwIG9mDQo+IENs
YXVkZSBPcHVzIDUuNSAoQW50aHJvcGljKSwgd29ya2luZyBmcm9tIG5ldGRldiBhbmQgZXRodG9v
bCBjb3VudGVycw0KPiBjb2xsZWN0ZWQgb24gdGhlIGFmZmVjdGVkIHN5c3RlbSBhbmQgZnJvbSB0
aGUgZHJpdmVyIHNvdXJjZS4NCj4gDQo+IFRlc3RlZCBvbiBhbiBFODEwLVhYViAoNy4wLjE0IGtl
cm5lbCwgc2FtZSBjb2RlIGFzIGN1cnJlbnQgbWFzdGVyKSB3aXRoDQo+IGFuIFhEUCBibG9ja2xp
c3QgYXR0YWNoZWQgdG8gYW4gODAyLjNhZCBib25kOiB3aXRob3V0IHRoZSBmaXgsIGVhY2gNCj4g
ZHJvcHBlZCBwYWNrZXQgYWRkZWQgYWJvdXQgMi41IEdCIHRvIHJ4X3F1ZXVlX05fYnl0ZXM7IHdp
dGggdGhlIGZpeCwgNDANCj4gZHJvcHBlZCBwYWNrZXRzIHByb2R1Y2VkIG5vIHN1Y2gganVtcHMu
DQo+IA0KPiBGaXhlczogOTNmNTNkYjlmOWRjICgiaWNlOiBzd2l0Y2ggdG8gUGFnZSBQb29sIikN
Cj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjE4LngNCj4gTGluazoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2L0RCN1BSMDNNQjQ2MDE1OEI5MEE2NEQwMjU5NjI2NzBF
MEQ1NzcyQERCDQo+IDdQUjAzTUI0NjAxLmV1cnByZDAzLnByb2Qub3V0bG9vay5jb20vDQo+IFNp
Z25lZC1vZmYtYnk6IERvbWluaWsgRHZvxZnDoWsgPERvbWluaWsuRHZvcmFrQGVjb24ubXVuaS5j
ej4NCj4gLS0tDQo+IEJhc2VkIG9uIHRoZSBzdGFibGUgdjcuMC4xNCB0cmVlLCB3aGljaCBpcyB3
aGF0IHRoZSBhZmZlY3RlZCBib3ggcnVuczsNCj4gdGhlIGNoYW5nZWQgY29kZSBpcyBpZGVudGlj
YWwgaW4gY3VycmVudCBtYXN0ZXIuIFRlc3RlZCBvbiB0aGF0IGJveCB3aXRoDQo+IHRoZSBmaXhl
ZCBtb2R1bGUgYnVpbHQgYWdhaW5zdCB0aGUgNy4wLjE0LTI2LXB2ZSBoZWFkZXJzLg0KPiAtLS0N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBBY2NvdW50IGZvciBSeCBieXRlcyBhbmQgcGFja2V0cyBv
bmNlLCBiZWZvcmUgaWNlX3J1bl94ZHAoKSwgYW5kIGRyb3ANCj4gICB0aGUgc2VwYXJhdGUgc2ti
LT5sZW4gYWNjb3VudGluZyBvbiB0aGUgWERQX1BBU1MgcGF0aCAoT2xlaykuDQo+IC0gQWRkIENj
OiBzdGFibGUgd2l0aCB0aGUgbWluaW11bSBhZmZlY3RlZCB2ZXJzaW9uIChPbGVrKS4NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3R4cnguYyB8IDE1ICsrKysr
KystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2Uv
aWNlX3R4cnguYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfdHhyeC5j
DQo+IGluZGV4DQo+IDRjYTFhMDYwMjMwN2QwNzYxNTNmNzc2NzFlOGM5YTZmZjRmOGRkMjguLjhl
NGNkYTlhMzRiNjczYTZjNWE3NWU1YWE3NDkyYw0KPiAxOGJiMGYzZjE5IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3R4cnguYw0KPiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3R4cnguYw0KPiBAQCAtMTAyOCwxNCArMTAy
OCwxOSBAQCBzdGF0aWMgaW50IGljZV9jbGVhbl9yeF9pcnEoc3RydWN0IGljZV9yeF9yaW5nDQo+
ICpyeF9yaW5nLCBpbnQgYnVkZ2V0KQ0KPiAgCQlpZiAoaWNlX2lzX25vbl9lb3AocnhfcmluZywg
cnhfZGVzYykgfHwgdW5saWtlbHkoIXhkcC0NCj4gPmRhdGEpKQ0KPiAgCQkJY29udGludWU7DQo+
IA0KPiArCQkvKiBBY2NvdW50IGZvciBSeCBieXRlcyBoZXJlLCBiZWZvcmUgaWNlX3J1bl94ZHAo
KSBtYXkNCj4gZnJlZSB0aGUNCj4gKwkJICogYnVmZmVyIGFuZCBjbGVhciB4ZHAtPmRhdGE7IHRo
ZSBYRFAgYW5kIHNrYiBwYXRocyBzaGFyZQ0KPiB0aGUNCj4gKwkJICogc2FtZSBsZW5ndGguDQo+
ICsJCSAqLw0KPiArCQl0b3RhbF9yeF9ieXRlcyArPSB4ZHBfZ2V0X2J1ZmZfbGVuKCZ4ZHAtPmJh
c2UpOw0KPiArCQl0b3RhbF9yeF9wa3RzKys7DQo+ICsNCj4gIAkJeGRwX3ZlcmRpY3QgPSBpY2Vf
cnVuX3hkcChyeF9yaW5nLCB4ZHAsIHhkcF9wcm9nLA0KPiB4ZHBfcmluZywgcnhfZGVzYyk7DQo+
ICAJCWlmICh4ZHBfdmVyZGljdCA9PSBJQ0VfWERQX1BBU1MpDQo+ICAJCQlnb3RvIGNvbnN0cnVj
dF9za2I7DQo+IA0KPiAgCQlpZiAoeGRwX3ZlcmRpY3QgJiAoSUNFX1hEUF9UWCB8IElDRV9YRFBf
UkVESVIpKQ0KPiAgCQkJeGRwX3htaXQgfD0geGRwX3ZlcmRpY3Q7DQo+IC0JCXRvdGFsX3J4X2J5
dGVzICs9IHhkcF9nZXRfYnVmZl9sZW4oJnhkcC0+YmFzZSk7DQo+IC0JCXRvdGFsX3J4X3BrdHMr
KzsNCj4gDQo+ICAJCXhkcC0+ZGF0YSA9IE5VTEw7DQo+ICAJCWNvbnRpbnVlOw0KPiBAQCAtMTA1
MywxOCArMTA1OCwxMiBAQCBzdGF0aWMgaW50IGljZV9jbGVhbl9yeF9pcnEoc3RydWN0IGljZV9y
eF9yaW5nDQo+ICpyeF9yaW5nLCBpbnQgYnVkZ2V0KQ0KPiANCj4gIAkJdmxhbl90Y2kgPSBpY2Vf
Z2V0X3ZsYW5fdGNpKHJ4X2Rlc2MpOw0KPiANCj4gLQkJLyogcHJvYmFibHkgYSBsaXR0bGUgc2tl
d2VkIGR1ZSB0byByZW1vdmluZyBDUkMgKi8NCj4gLQkJdG90YWxfcnhfYnl0ZXMgKz0gc2tiLT5s
ZW47DQo+IC0NCj4gIAkJLyogcG9wdWxhdGUgY2hlY2tzdW0sIFZMQU4sIGFuZCBwcm90b2NvbCAq
Lw0KPiAgCQlpY2VfcHJvY2Vzc19za2JfZmllbGRzKHJ4X3JpbmcsIHJ4X2Rlc2MsIHNrYik7DQo+
IA0KPiAgCQlpY2VfdHJhY2UoY2xlYW5fcnhfaXJxX2luZGljYXRlLCByeF9yaW5nLCByeF9kZXNj
LCBza2IpOw0KPiAgCQkvKiBzZW5kIGNvbXBsZXRlZCBza2IgdXAgdGhlIHN0YWNrICovDQo+ICAJ
CWljZV9yZWNlaXZlX3NrYihyeF9yaW5nLCBza2IsIHZsYW5fdGNpKTsNCj4gLQ0KPiAtCQkvKiB1
cGRhdGUgYnVkZ2V0IGFjY291bnRpbmcgKi8NCj4gLQkJdG90YWxfcnhfcGt0cysrOw0KPiAgCX0N
Cj4gDQo+ICAJcnhfcmluZy0+bmV4dF90b19jbGVhbiA9IG50YzsNCj4gDQo+IC0tLQ0KPiBiYXNl
LWNvbW1pdDogNDU4YzYwNzlmYzFkNDFkNTY0YzM3Njc5YzhhY2UwMmNkODNlZTgxNw0KPiBjaGFu
Z2UtaWQ6IDIwMjYxMTA1LWljZS14ZHAtcngtYnl0ZXMtNGFjYTRhYzBlMmMyDQo+IA0KPiBCZXN0
IHJlZ2FyZHMsDQo+IC0tDQo+IERvbWluaWsgRHZvxZnDoWsgPERvbWluaWsuRHZvcmFrQGVjb24u
bXVuaS5jej4NCj4gDQoNClJldmlld2VkLWJ5OiBBbGVrc2FuZHIgTG9rdGlvbm92IDxhbGVrc2Fu
ZHIubG9rdGlvbm92QGludGVsLmNvbT4NCg==
