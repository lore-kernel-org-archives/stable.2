Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793212396;
	b=ffWMfZTQ+KAjGcB7KY0JiaPwOdc2QMvIVxAtBGqn65hMiFM0LCzZZD9kulXmURZazF3W
	 AGmwh33N/XDSPD/cUsdt0JgzYcIU4+B2AphJjxs52OAS6tdwuNlYqzwwyeNtghISe0WpP
	 5SWe5BfkpSBOMeTSlAHPdvKKpaszBdGS0heWVe7MKBHcRgyjRYwSCcfQdYh1pqDJt8pwe
	 0f6WtC+nEkZwb9Faq7kLL3erEWCPD3Ak4wzgLjLmwOoldAfpAaOkH0J5WQZOpVfm0Rkrz
	 iQG7FdbkcFExZIyyTDoojr0dM3/kqwcwtxelaGRoVlTX8n09w3+WXg429Z8/4hlqhLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212396;
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
	bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
	b=VAmeQhbRSBBISF22pyE/AyiTYKOtJ++LIj+/WO2zJ/lyqsSoRjK+G8LfLYVxrZFBxePI
	 Nz08umnLnkU+m1os3vCo3+2DycbWcWL8ZNrlwrT2PIMvXYDKyFMW63SG7WZmWg84BVoSh
	 TQtd2PLJaoxdgr14F6dAdnfm8dEpnA8QFkXZZ3Xhzd6tbfB1yGKy2yZCpoA9EXWGZidze
	 aSCHqLjT4TR8ba9FZOOxmeWjHPXx+rATypB9eLaxFxLvnGBPCVF+DNZZSf2GjIzvkTO7o
	 VmVZOl72Yo0ueIabHJNkcyKR+VJAvomzFbDJ834Rjxf+b1zohF+o5o7gyDMznnWUYeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D0uYaM4T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F17606A31E;
	Wed, 28 Oct 2026 18:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F17606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D0uYaM4T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793212395; x=1824748395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
  b=D0uYaM4TOxnGUvcNJXeDWHAblLF9ExUxHlj5Cug5SanaE6WyrlvMu2HU
   56V79D+BXMfLQPlTqktu8iOc19aHSufLaIt/khVOS2N/I5mBOWB7Wauc9
   1rAHW9/vzCOjlHt8fWOGY7otI+PcAV4hMIsPAatCCTUSLkYpD/59tZkux
   lQlWB7jlXWl3s3WeOxFoRx+sANrrQXqSafND/PHASUVIZQiCFhDdtoqAq
   VGlfHIz3Bm85ct9tL7u+1+eiJ6YzruVfui/HlUuvw845C86iKptXwm8Qy
   hJsSz0+f3YFHqfU+sFXeV3p5+rmHoIzVUC47Sw02Oyu/X9wWNEuEVQaNk
   g==;
X-CSE-ConnectionGUID: lgBxyiK5S3Wn/BYKi9cBjw==
X-CSE-MsgGUID: OrKhSQ1QT6CYGd//tPdOiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1959496"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1959496"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 11:33:15 -0700
X-CSE-ConnectionGUID: bC7shjSgTNapr/XCBjAykw==
X-CSE-MsgGUID: 2d8Aj3lPROqXyX89ZKi7HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6683003"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 11:33:15 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 11:33:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 11:33:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 11:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd+0X/DsJ/aA7iEMz7gWZSTXc5EoDQoG+L10xVmB92doXPprSY9ZA5avvGsW6FPmvF9gEIyMRRjmY6+Xh06CVT5yTWjx/KKRZILiddfLPDvrVw1fJF3XxEH7HSlKtNoPNH5Nt81HjNev06Pb8QSt/SrX55lRUaVH/5X7JLgLaOjECsOMzImSDa5A7WxXMpm9wQ70sAukLxN+vSsuTL8BAc92ohy+tPuBvYTTlwjPMXEGDd6JX8MT4FrfsflDfBhnU5ylUGnF9Bmz18wksuR6e5RnR0jeUDytmXCrOk+86Zufoz9sICWvnEzFVXKZ5grI8vdGTqCoL2TxeEkQNpe3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZJ1ohIB7vDxLIAXfLO0nVJPtisqtWdct2oI4DvTGvk=;
 b=QaUcFQiO+bt9I7MVAXp+S1Y2+9mR5tLld9SnxPtlwFJIwRvQIa1fzT7PsCS5FGNpzGcEoADoKvXSqEqU9oGuwXWc4EB0RodQvN1Zu4zLxG2mndb9tBaJlrk7RPs7eRy3yudYJisD11Z+bajf9NierCB1yvkRnCibOZ7Y4nZ7OqMCJ9gXrD5yG0Ml/6iQAAaWq9w9dSsIllchq6K1awnHLQDAFpeM+RgkhtLc98TZt4+kgDXyF+dS7Uz6hrhx8yXGIhQuYanelXqC/nEiJcEU3QRZQJZ9hIIdZI6BELJaDtodakxL5Ch8HYGYOu4mtt96U1cdkWxP48LIMDKjAElVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by SJ0PR11MB8272.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 18:33:10 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 18:33:10 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "choiniere.vincent@hydroquebec.com" <choiniere.vincent@hydroquebec.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net] ice: fix NULL dereference after disabling RDMA
Thread-Topic: [PATCH iwl-net] ice: fix NULL dereference after disabling RDMA
Thread-Index: AQHdZU4+zzBG5aXNJ0ym4ZC6J6qNKrcTSuHQ
Date: Wed, 28 Oct 2026 18:33:10 +0000
Message-ID: <CH3PR11MB5668958AB7C8DBC881F0E5ECEAE56F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <20261026-ice-deinit-rdma-null-v1-1-7d2130d1809a@hydroquebec.com>
In-Reply-To: <20261026-ice-deinit-rdma-null-v1-1-7d2130d1809a@hydroquebec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|SJ0PR11MB8272:EE_
x-ms-office365-filtering-correlation-id: 963d7cd9-a7a2-485f-679e-08df3521eaef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|921020|5023799004|11063799006|56012099006|261021121427099003|261026121527099003|261021123027099003|261021135927099003|10067099003|261009223027099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: VdpRAm7E2+/sFmT+EDfC82olLc+hFP/TCmcAP+xft7xg123zbvP1RGA+UvxwmBhgJ0neXThuJmaNE6oTyTa/S9WcAXmSn/8Piw78k6fMgLhvpugaHJ0m793IW8nuknLAkCtMXckSX6lQORjQlNP5PqbFRGa8xi+3+gkf6LLRAcZPTMZVgGPxV52fGe79ngLW/i0Vb9fPofUiGbGn00/AH/4sCbOS7oTYblpY64BawgN9JntEMutwoFp1hJ0YrcMuwHFnuN7ZLSGO0rb/Y1VRfg73Z3ictaG6BcKV33VGPx00WlUG12cligL+U5s8JojZvIEyU9Z9GytaAC+a04543p6T6i0ECcdcYkt3+fV/z+oYMFFQ9YP7i0FdFbS2iNucJ/BQazdPM8ro8tYiO6ViC6VALTNaJTDFu4Em7GvPcBxySL5L4EsyaGLPVH5GXPUjNplmOza+av5aBTdDI/rTJpoVgsEkzPeoqyaEytbmRFW+QWCDF5Yf4atBwBFX5LWfVuepVpEj00OGyD1kd/q1kai1UKFVJ51N+r0/QZ9PGHfAREBl1J8L5GC+OUfkmkiaPqxukVTCXLoRdfe1hF4RD1/JR8D9gyIaTtgQsK8iJUscIMTm7boayGEW9GWmr/E59iG8HSn4zs2oa2IIZ/9tSsnJ6WVUJPbJQuC4+y5ld3H/+3I4I2LuH5fGfHrTFIqBCzqcBIVEMBGdPV69eoDhMflZWXrxbNu+GVRoFcv6CWl+0OQ8FKwwm1aYN3dePhEW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(921020)(5023799004)(11063799006)(56012099006)(261021121427099003)(261026121527099003)(261021123027099003)(261021135927099003)(10067099003)(261009223027099003)(261022075727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEorSHZYMkdVQmVRdysvUE42Y0JnQzFsaEtZYXd6bGtlWUV0QkNRMjNiMXBE?=
 =?utf-8?B?QTBSZUpVNEF0Vnh5dmVjUUMxUkdsaks0elJab3ZBODdyYnlKUUdXOGRaeGE5?=
 =?utf-8?B?TGhiR2FRaXAyaVRsU1ZXRlJSR2tiU0puVFIwYnp3aEdsUWgzeXdVQ0hlUFZJ?=
 =?utf-8?B?QnRyVWVacXlkMHE0STU1WlltUFNHSDVDQjVyQ0huck1aRDdRRnhaVmorVW53?=
 =?utf-8?B?NkdQRk5FMnFCUnMraGVxOE5qTTE4WnBXTXJmTWcrQWxFSkFWQU01Z2xhb2lj?=
 =?utf-8?B?aUIxRzFGcVYwazFJQVA4QlIyRW11TkoxQjJhN1JJblYwc25KTkExSDkrVm0x?=
 =?utf-8?B?NmsrSnEyYzZQNkN5S1p1UVovcWphTUpaamQ5SVl2UjBQbkROWDkyaHJMSXBU?=
 =?utf-8?B?MEVsOG0ycWVZbnNsZHZCUjJ4L2VjeW8ydEVxTk5uaDJTaTRtaGcrUHdXdnEw?=
 =?utf-8?B?TEJ3bFM4N2lXa3FSVjFjdUc2MzA4dDI0WjRlMUZKY2V4K1BIZElsMStWRFd5?=
 =?utf-8?B?VEhNbHBYQTY2eU9MY3lMdHErTUlCQUpramF1U3hjeGNTdnJXQmExMHpGZTl2?=
 =?utf-8?B?K3RVZ3RuYkloajRzcklLbHRVS2xTM3c1aHpuaHVHYWlCU2VyWm5YMHdnbWZy?=
 =?utf-8?B?UWE3SDRSTGl6cU5VWm15ZStraW5uV0htQksvNkUwRzVkcEM3WFBBSDZUVjBH?=
 =?utf-8?B?RG5aY2FPams5T2FXazIyeGJwY3doMUpTUkRJMzd0OXF1UWgzeDVucVdYdmh2?=
 =?utf-8?B?V1psYW1QRHhrM2R3UUtWclc0U3QzeWpZMzkvZkdrZG9FQXR6Nmlja0I3Y2JE?=
 =?utf-8?B?Q1krdUp4UEJDLzBrZXdiYmR4TXFvOWxyTVdIemkzRnNZMy9Ka0hxVFZQNk44?=
 =?utf-8?B?LzI0azFucEtpZUQySFRVd1huRCs2ZnZJZHNUWnV6T2pGbmZhV0M0WklyVkxR?=
 =?utf-8?B?K2JkZ1NQTVQ3ejBWS2VMRnRURjhxdjA4cm53Vk45NndtSWd0NDdPTjlGbVRY?=
 =?utf-8?B?VDQ2WVdSVXB1V1N4cGdNU0s5OHZmRkJzQ1VUaG4reFRVbllEV1Q3OVdSTEJR?=
 =?utf-8?B?OVVSZ1B5alFrWUxLbnFlOWQ0SGhKckJ4THpiT1ZGaVc0NmxZdGI4SmFmZVlB?=
 =?utf-8?B?Q3RkL2RmL0VQdjdBNjEyRmEzSjV3NFhjZmZmSzNBcnlwTEpqNGF1VVg5RnVP?=
 =?utf-8?B?WHhhQ3NMM3V6L2hrTGNheVdHOHVQeS8xcjBsVkNsWGJWV2FSVTlEdFo5UXVy?=
 =?utf-8?B?b2t2Q2VhSUFZY0JXTityQk9nZnZEYlk5ZWVpajFwaVpnSTZFcENFSG52SFBo?=
 =?utf-8?B?QytVMkpBT1dlTWVFREJTcDdtbE5QS0Z3WHE3VUhHdXMwRHp0UU9pbmlOVFZx?=
 =?utf-8?B?YVNJQS8rUURwWFdqTTJsWDZKdmRJb3A2SFo0eWgwNDlGYXJPNTNtS1gvLzRk?=
 =?utf-8?B?V1NiR0NDa3FOR09BOHVSMGVTemJHekE2a1FuaEV4bU5UQkZrZmpyTVlFWnQ3?=
 =?utf-8?B?aEhTUlZMODgyRlF4QmYxY2sxdTVvd21BS1JBa0tNQ1h5bnVEMktHVlJITFE2?=
 =?utf-8?B?T2d3by9LQWpMaEVtcm5SVkdvQnA1QjFyeUR3MTJmRHhGYjdWWmU1RUtQcG9u?=
 =?utf-8?B?VVhENXUxSFNDTjBaZWI3dEloRzRwclltampDV24wcHgva3FlSjdKZCt5M3Fn?=
 =?utf-8?B?QnBNaURFS0Z5THhoZTFwajlJVmY1clhuKzFVNURBYVoxY3oyQkY0Yy9LS09a?=
 =?utf-8?B?bXdWcWs0TGRtSkJIbG02d3BGb2ltd0I5bDAzVnZxa3ovVTQ2NmVrNVV3d1Zw?=
 =?utf-8?B?WWkyZFZZbEdJME9sb1ovOWhoUGZvaVRWemZkcjJUUE5uQXd3L0ZEWk5BSmxa?=
 =?utf-8?B?dXhKdzAyRkFGbzVuR2pSQVlEMmhELytvZ0FIanFWM0JwMzI3ZFg2TWExVllK?=
 =?utf-8?B?V25IUFkzNlJrREd0Wmc2ZnRaT2JRMGJrM0VlSksxbDA2eVpDTXhXNHpDR0RX?=
 =?utf-8?B?NVpoMVllRDUzV0xkaDlHR1JaR1JrYkpxRThEak5XVU50ZkhSczVmNjhjcXBW?=
 =?utf-8?B?clJFN01pemcvN1VOZFViNGtXOU5PWlhJUC9ERmNDeWlKOWdHWmFGWlNnQ0Yy?=
 =?utf-8?B?WlYrOXo1aXVDc0Y1WEFoNVVjZVZ4RjhSNEpPK2JDMW4wYkYva1JZWUFTeWVW?=
 =?utf-8?B?WXlyTFFFelVUZldnLzJhWmFvMzBibkZFbld1dndyWWs3SGRnQkNPK3hOdFdD?=
 =?utf-8?B?OTdHbStMOGxFd1YrVmRsR3JkZktsckh0cW5VQTdmZmpXL1V4VE1HRVhGVDIz?=
 =?utf-8?B?Q3RUdHBwaEZQY1BsaGx2VDZqb2VveVBITkhSTVJ1dU1VVU01dGRsOVBidGNq?=
 =?utf-8?Q?1G7xFC4lP+UVC8y8=3D?=
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
X-Exchange-RoutingPolicyChecked: kXgFlo/iPWC9dgCASEELYKxkfUqhy65RaV8kybK5BseT6W3wlREk4nq75rUPyvW4d4NHdrsj2kMf5UGyfgclk5UxsrZVVg4OxdRhTsbZKMbQNStXVA40zt4MpiFXGHccxAaD1H832Ji90sbYup2aZIO85gbkT1W5RXLKGXb2Lj4Pc6npviY0Pr0H29xAkkrFNWW2gmqqBaH0Ugwo84fCy7qN7n/8MCjwS8WFV+TIjYA/8+H+IafdPKbtra/H6S1dzTA8mA+xusbi61+uDJ5G4le96ZUhZbBI1C8s4rYkan/2I8MhyKnz09Wteq9DxNB1mZozV8Cc3V/KdySJJufbRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963d7cd9-a7a2-485f-679e-08df3521eaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 18:33:10.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3uDC53w0TRAPcIyLlAGWc1icKr9QTnlhESLKq5d+BaP+DzDbytKVpMATM4rC5EyySrFBXhrVK4xeaeMmkGDIxxqi6L+7lNm2Q0wpVmh7woY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8272
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmluY2VudCBDaG9pbmll
cmUgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK2Nob2luaWVyZS52aW5jZW50Lmh5ZHJvcXVlYmVj
LmNvbUBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjYsIDIwMjYgMjozMCBQ
TQ0KPiBUbzogTmd1eWVuLCBBbnRob255IEwgPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29tPjsg
S2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47IEFu
ZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+Ow0KPiBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQNCj4gPGVkdW1hemV0QGtlcm5lbC5vcmc+
OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPHBhYmVu
aUByZWRoYXQuY29tPg0KPiBDYzogTWljaGFsIFN3aWF0a293c2tpIDxtaWNoYWwuc3dpYXRrb3dz
a2lAbGludXguaW50ZWwuY29tPjsgaW50ZWwtDQo+IHdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3Jn
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgVmluY2VudCBDaG9pbmllcmUNCj4gPGNob2luaWVy
ZS52aW5jZW50QGh5ZHJvcXVlYmVjLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIGl3bC1uZXRdIGlj
ZTogZml4IE5VTEwgZGVyZWZlcmVuY2UgYWZ0ZXIgZGlzYWJsaW5nIFJETUENCj4gDQo+IEZyb206
IFZpbmNlbnQgQ2hvaW5pZXJlIDxjaG9pbmllcmUudmluY2VudEBoeWRyb3F1ZWJlYy5jb20+DQo+
IA0KPiBpY2VfZGVpbml0X3JkbWEoKSBjaGVja3MgaWNlX2lzX3JkbWFfZW5hKCkgYmVmb3JlIGRl
cmVmZXJlbmNpbmcNCj4gcGYtPmNkZXZfaW5mby4gV2hpbGUgdGhlIGVuYWJsZV9yZG1hIGRldmxp
bmsgZHJpdmVyaW5pdCBwYXJhbWV0ZXIgaXMNCj4gcmVnaXN0ZXJlZCwgdGhhdCBoZWxwZXIgcmV0
dXJucyB0aGUgcGFyYW1ldGVyIHZhbHVlLiBPbmNlIHRoZSBwYXJhbWV0ZXINCj4gaXMgdW5yZWdp
c3RlcmVkLCBpdCBmYWxscyBiYWNrIHRvIElDRV9GTEFHX1JETUFfRU5BLg0KPiANCj4gV2hlbiBl
bmFibGVfcmRtYSBpcyBzZXQgdG8gZmFsc2UgYW5kIGFwcGxpZWQgYnkgYSBkZXZsaW5rIHJlbG9h
ZCwNCj4gaWNlX2luaXRfcmRtYSgpIHJldHVybnMgZWFybHksIGxlYXZpbmcgcGYtPmNkZXZfaW5m
byBOVUxMLiBEdXJpbmcgZHJpdmVyDQo+IHJlbW92YWwsIGljZV9yZW1vdmUoKSBjYWxscyBpY2Vf
ZGVpbml0X2RldmxpbmsoKSBiZWZvcmUgaWNlX3VubG9hZCgpLg0KPiBUaGUgcGFyYW1ldGVycyBh
cmUgdGhlcmVmb3JlIHVucmVnaXN0ZXJlZCBiZWZvcmUgaWNlX2RlaW5pdF9yZG1hKCkgcnVucy4N
Cj4gT24gYW4gUkRNQS1jYXBhYmxlIGRldmljZSwgaWNlX2lzX3JkbWFfZW5hKCkgdGhlbiByZXR1
cm5zIHRydWUsIGFsbG93aW5nDQo+IGljZV9kZWluaXRfcmRtYSgpIHRvIGRlcmVmZXJlbmNlIHRo
ZSBOVUxMIHBvaW50ZXIuDQo+IA0KPiBUaGlzIGNhbiBjYXVzZSBhIHBhbmljIGR1cmluZyByZWJv
b3QsIG1vZHVsZSByZW1vdmFsIG9yIFBDSSB1bmJpbmQuDQo+IFJlcHJvZHVjZWQgb24gYW4gRTgx
MCBQRiB3aXRoIFVidW50dSBrZXJuZWwgNy4wLjAtMTQgKFBSRUVNUFRfUlQpOg0KPiANCj4gIGRl
dmxpbmsgZGV2IHBhcmFtIHNldCBwY2kvMDAwMDowMjowMC4wIG5hbWUgZW5hYmxlX3JkbWEgdmFs
dWUgZmFsc2UgXA0KPiAgICAgICAgICBjbW9kZSBkcml2ZXJpbml0DQo+ICBkZXZsaW5rIGRldiBy
ZWxvYWQgcGNpLzAwMDA6MDI6MDAuMCBhY3Rpb24gZHJpdmVyX3JlaW5pdCAgc3lzdGVtY3RsDQo+
IHJlYm9vdA0KPiANCj4gIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRk
cmVzczogMDAwMDAwMDAwMDAwMDAxOA0KPiAgUklQOiAwMDEwOmljZV9kZWluaXRfcmRtYSsweDMw
LzB4NjAgW2ljZV0NCj4gICBpY2VfdW5sb2FkKzB4M2YvMHgxNTAgW2ljZV0NCj4gICBpY2VfcmVt
b3ZlKzB4YjUvMHgxZDAgW2ljZV0NCj4gICBpY2Vfc2h1dGRvd24rMHgxYi8weDYwIFtpY2VdDQo+
ICAgcGNpX2RldmljZV9zaHV0ZG93bg0KPiAgIGRldmljZV9zaHV0ZG93bg0KPiAgIGtlcm5lbF9y
ZXN0YXJ0DQo+ICBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtpbGwg
aW5pdCENCj4gDQo+IENoZWNrIHBmLT5jZGV2X2luZm8gYmVmb3JlIGRlcmVmZXJlbmNpbmcgaXQs
IGFzDQo+IGljZV9yZG1hX3VwZGF0ZV92c2lfZmlsdGVyKCkgYWxyZWFkeSBkb2VzLiBUaGlzIHBy
ZXNlcnZlcyB0aGUgZXhpc3RpbmcNCj4gZW5hYmxlX3JkbWEgc2VtYW50aWNzIHdpdGhvdXQgY2hh
bmdpbmcgb3RoZXIgaWNlX2lzX3JkbWFfZW5hKCkgY2FsbGVycy4NCj4gDQo+IEZpeGVzOiA4NzE4
MWNkNjk4NWYgKCJpY2U6IGVuYWJsZV9yZG1hIGRldmxpbmsgcGFyYW0iKQ0KPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IENob2luaWVyZSA8Y2hv
aW5pZXJlLnZpbmNlbnRAaHlkcm9xdWViZWMuY29tPg0KPiAtLS0NCj4gVGVzdGluZyB3YXMgcGVy
Zm9ybWVkIG9uIGFuIEU4MTAgUEYgcGFzc2VkIHRocm91Z2ggdG8gYSBLVk0gZ3Vlc3QsIHVzaW5n
DQo+IFVidW50dSBrZXJuZWwgNy4wLjAtMzggKFBSRUVNUFRfUlQpLiBUd28ga2VybmVscyBkaWZm
ZXJpbmcgb25seSBieSB0aGlzDQo+IHBhdGNoIHdlcmUgY29tcGFyZWQuIEVhY2ggdGVzdCBzZXQg
ZW5hYmxlX3JkbWE9ZmFsc2UgYW5kIGFwcGxpZWQgaXQgd2l0aA0KPiBkZXZsaW5rIHJlbG9hZCBk
cml2ZXJfcmVpbml0IGJlZm9yZSB0aGUgcmVtb3ZhbCBzdGVwLg0KPiANCj4gICBSZW1vdmFsIHBh
dGggICAgICBXaXRob3V0IHBhdGNoICAgICAgICAgICBXaXRoIHBhdGNoDQo+ICAgcmVib290ICh4
MykgICAgICAgTlVMTCBkZXJlZiwgcGFuaWMgKDMvMykgY2xlYW4gKDMvMykNCj4gICBybW1vZCBp
Y2UgICAgICAgICBOVUxMIGRlcmVmICAgICAgICAgICAgICBjbGVhbg0KPiAgIFBDSSB1bmJpbmQg
ICAgICAgIE5VTEwgZGVyZWYgICAgICAgICAgICAgIGNsZWFuDQo+IA0KPiBBZGRpdGlvbmFsIGNo
ZWNrcyBvbiB0aGUgcGF0Y2hlZCBrZXJuZWw6DQo+ICAgLSBSZWJvb3Qgd2l0aG91dCBhIHByZWNl
ZGluZyBkZXZsaW5rIHJlbG9hZCBjb21wbGV0ZWQgY2xlYW5seS4NCj4gICAtIGlyZG1hIGRldmlj
ZXMgcmV0dXJuZWQgYWZ0ZXIgUENJIHVuYmluZC9iaW5kLg0KPiAgIC0gaXJkbWEgZGV2aWNlcyBy
ZXR1cm5lZCBhZnRlciBhbiBlbmFibGVfcmRtYSBmYWxzZSAtPiB0cnVlIHJlbG9hZA0KPiAgICAg
Y3ljbGUuDQo+IA0KPiBObyBLQVNBTiBvciBrbWVtbGVhayB0ZXN0aW5nIHdhcyBwZXJmb3JtZWQu
DQo+IA0KPiBUaGUgZXhhY3QgdGFyZ2V0IHRyZWUgKG5ldCwgNzA3NmY2ODRkNTEzMmU2YSkgd2Fz
IG5vdCBidWlsdCBvciB0ZXN0ZWQuDQo+IGljZV9kZWluaXRfcmRtYSgpIGFuZCBpY2VfaXNfcmRt
YV9lbmEoKSBhcmUgdW5jaGFuZ2VkIHRoZXJlIGNvbXBhcmVkDQo+IHdpdGggdGhlIHRlc3RlZCBj
b2RlLg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2VfaWRjLmMg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX2lk
Yy5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9pZGMuYw0KPiBpbmRl
eCAxMDJkNjNjMzAuLjA5ZGZjZmZlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWNlL2ljZV9pZGMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX2lkYy5jDQo+IEBAIC00NTQsNyArNDU0LDcgQEAgaW50IGljZV9pbml0X3JkbWEo
c3RydWN0IGljZV9wZiAqcGYpDQo+ICAgKi8NCj4gIHZvaWQgaWNlX2RlaW5pdF9yZG1hKHN0cnVj
dCBpY2VfcGYgKnBmKSAgew0KPiAtCWlmICghaWNlX2lzX3JkbWFfZW5hKHBmKSkNCj4gKwlpZiAo
IWljZV9pc19yZG1hX2VuYShwZikgfHwgIXBmLT5jZGV2X2luZm8pDQo+ICAJCXJldHVybjsNCj4g
DQo+ICAJeGFfZXJhc2UoJmljZV9hdXhfaWQsIHBmLT5hdXhfaWR4KTsNCj4gDQo+IC0tLQ0KPiBi
YXNlLWNvbW1pdDogNzA3NmY2ODRkNTEzMmU2YTYxNDVlMWRhMmZhNzQ3NzFlY2QwNTJlNQ0KPiBj
aGFuZ2UtaWQ6IDIwMjYxMDI1LWljZS1kZWluaXQtcmRtYS1udWxsLTYxM2YxYmUzM2Y3Mg0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IEFsZWtzYW5kciBMb2t0aW9ub3YgPGFsZWtzYW5kci5sb2t0aW9ub3ZA
aW50ZWwuY29tPg0KDQo=
