Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC421E5B63;
	Mon, 10 Aug 2026 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323207; cv=fail; b=KnTBYt0UKDWr8u11IJLhQjVV9cgi7CK6rtr9fb8484RJEhB1hDSpPpEwKaK0Fyq0ejYHM8UpfSssI1EakrQIZ8jijHt9TyVn4EhP6zwElv5p2Kw1SIoQyYGUnf0zsgeUQE2l5XmXsfLnOeibNtMJ/rc18OHY8jXtkf1YGILR4sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323207; c=relaxed/simple;
	bh=TqkPpt77JapiQ29AeVlhXn7X7V0K9lEH3BGU/0wTedI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ny4Kbp6NyehMrX/kuRfgwKGAJgPiFwmPKziAb+vDCSA9cu6E8Uj/4FN05JwBy2hMqjMtOkRGLLiDWSwC1Jb3uDMAX40Gn9LLc1ydeNBphNH3pMtj7hPT+rK2Yyjq+CUh3iGnXWKwzPc+y0hRq02647vR5GpozYcpQZrMpRBca2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2XSBhMj; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2XSBhMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786323205; x=1817859205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TqkPpt77JapiQ29AeVlhXn7X7V0K9lEH3BGU/0wTedI=;
  b=f2XSBhMjhdwix+/2g3IVvQZC3E28TdjOqUWlepcT6ZKQATnfiV51RuHO
   cxXvU4Z0Q1G8wo6KQHz4/km3W0XsxLUxi7nCtoCDzI4UX60+NvpB4yu7p
   1cRl+l93ncrs8CXvKE6qWOVgwPoa2jWFprGBo9Cs+mRgv9d43lqp/E4L4
   iUl4dt76BFhgukJmX706A4M2MYnFuvu697p9DeWFbyKDEWRkrGERAEQ+N
   lRVJ1qvJ2B0ViT5PLtzGYYbE//CbrkSoS0eEkPuViJm8a0DrlkBwCbqqH
   X+6wnY3qOukQyj5Zi+XX2EwUKtZv9Vx4Tf1Vcm26v+5bcvnQIqmCZ/yTI
   w==;
X-CSE-ConnectionGUID: 0Jd8MHNPR6G4+5VFZVFNUw==
X-CSE-MsgGUID: GZqEMk6nTsScAv2d95sPZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="109623678"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="109623678"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 17:53:25 -0700
X-CSE-ConnectionGUID: 5UqAmH+uSBylpEaL+HRKew==
X-CSE-MsgGUID: 9uDBthXPSnyBPAopy2W28Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="267149174"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 17:53:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 17:53:23 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 17:53:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 17:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtzZVpfvWM7BDnaKRXEqQ7yb1LZC7VoDAO+x9IEDzzJspT85eG/pX+Ry7sHBlZf/31OeoQrQkXuGDf+kRtqZJmyqdVxTI7jCyqCyb6CfrPG34ouLcpQQZzWmWlpecxvkHRLNCLp8WF43XDbdb7i4Uuq8plBZjPrFT8EyCx+wBCTCpbBamHxHzgW7uCLdMwLYXRR4D8feTRWp5wCTL0wRpT1P+skKLvZ9Sn9CYln44WtcJ2KQkTbZnwnHQedJjQkKFdAQKqnu4BKzNSFF932TcDIA2rN04IGZOV7H8FAyNdNEDWSQ+a4k90fgm+OGOm8WR7+6LBIDfWEqy+OW99cp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TibZ4BS3/ZWRa1d9mbWaTVXzCOn5QDprLHnynIwT8jc=;
 b=yBujUesc8B/IJnVmh0Zje1atU6nBDk0SaP6J850sZswUWbk9uT3rClFZxeKhSfXPLOq+JDSgtOYtX8bYcglziV3Butz5WYWG3gjdZ5Bjxnp8ApyF3jW59pgDxmfeI3D849v3klRidQ9ek0pEybWAoYIO/qcyKSgug85AlzdhgrtY81NA+PE57QnMvvE6XSunwZ0QQ0PuhvvL6/T6nprVYXa6gBZvHaL7hsIANwjc6lTWt5AN/kDRO6JiDcmshT690UYqBVsNrC8nsiFWMZtXwgbTa/Raz/T1IFOXbTGuxJtGU0GDTnFp4C4d+m7RcQIPDeUr0P0Phyq6X9m4tqf0/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 00:53:19 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 00:53:19 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend
 cleanup during teardown
Thread-Index: AQHdJ0aodacfd+9hRU+wW7V0zzFmTbaWdojA
Date: Mon, 10 Aug 2026 00:53:19 +0000
Message-ID: <IA1PR11MB6098DEE7D7CBA03B4012D155F4DE2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260808145748.2926096-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808145748.2926096-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH8PR11MB6609:EE_
x-ms-office365-filtering-correlation-id: aeec79dd-df72-4278-83ac-08def679c558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|921020|38070700021;
x-microsoft-antispam-message-info: pImhmWZNuR2oftePcyzRw+vW9Lzq5HSpZNxCSKzMHCvuhqHkyr+k+4mxq+IEHzKj5v4r7JcAJQfZ1a0RLMWWyyQkYPfXY5JZeYtQKzbNdzxokePesOfxisjTlK92RJqcMCZUVof/i71hc55vtuaciTXc/Aj5O1R8yfxUHdAxx4WFdb9UBOtecd0tERmsYjGll3QmlmecDofH2HhFOZGKsfueiCOKxnfellu9b9WekXmMIzpjPuY5N2CPZsd6r0RGEsxu+1RM3SOZmYoR7LeVQQ1Sw2bv4j2cCJFuQMIGc0NgVihkZWe44TGC/tEgEtIU3o3VDMYvNlPoeFUO5w0B1u+Cn8E/QhgjKnsNIB8E2X3PzeJ35q2KkHTO6xXqNvsO7o2W5d7crr5VPoYnWi0QqUXpQt6/Cx2FKb0kpybmB7Wxt9tR+AEVEp5QNrZvkUl4IeE/RD+9siNHUsZ+C0mb6ozUCP9lVn+OnQ/3i5d6NE6hld1nLFF3+7z5oewP4CRWW5A2e2+dJau8v1uN02hX63W7OaE+7cTdjkkqshkidZQZ70QaWliMd63seqGcukj6Pr5q16X8mE2h1q/J+L++gXlmJ0IzUp4t916R666I/2KRr6SGCedggsaPmbQhX9g+BGDFKnrb8q4a+UOjqd3z08y54VbaIYJMkHXJMWF6g8NuqYJddEIUZNY6C7/aqohrumrD2l22zwIHqjF7dUYI0q6tTOuLMYS5Y0Bj1nMmhwDItuMxKcACt2PZCVlckPA0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mvCGTgeo54FWukdPxbUfoqMICzGS6YRQyyghAa4s5gW6E55L32Q/SEyv5ef8?=
 =?us-ascii?Q?UfvbIPDL87ZektT2/jZraCrzM8KfYGk7lIpYo8HcYt4hL9OXASAgwEoRKHbv?=
 =?us-ascii?Q?YPSOKSLEtWOgVEP5QaAZeyGTvg6lTonKXaPwKPyXrJagABbRqJSqkjnuMH7n?=
 =?us-ascii?Q?AvE6FXv0PirWbhnntSSFwkEucZSaFIZdjR7ZeC6ZNR/emjrZ+DO2ufJqwaRD?=
 =?us-ascii?Q?qkNMEfQyFEUOAZRoWjhtlcjepwNjQ0D9u4FmkrBm9GxlqANogRwUVptKZleg?=
 =?us-ascii?Q?HFJiJIs2oOB2KXhrH+fdQCMYa8tTSUwIPvVZyTAXgvBnsYiieoMdiJIeB26r?=
 =?us-ascii?Q?gWTX8SWNDyXxeJpgAaL4YfIKUDfDx0D1utzP996mXAQmxLwiF3Ap9Kcj+s7I?=
 =?us-ascii?Q?Od5F59ydm0W+UDGbtR4/fmGNYd868E49seVGvVHvYdenjt/KW8kt48sNzTfi?=
 =?us-ascii?Q?LTUigiTebJ93m/0MZwpxaAjk6onGHnULbLPu5+ghVj54X7yit+RmcVddYESu?=
 =?us-ascii?Q?ySfxxvIkPEcj6axgLWvV9xbULF+Zp5v1on7tqpl58lHhw0hItUAeQ84tzpc5?=
 =?us-ascii?Q?dfcUexYKAthKi1foGbEGWwq3zd7ThYb7wcLJexBc5RotcIiqXKC+3T7CxDs6?=
 =?us-ascii?Q?FPAI8IC+ur21gprrW5fRjBvhBBJc0SSRDdtEaF3eIwYEyTE99J9VftDQvsXG?=
 =?us-ascii?Q?Za8mf852+278vCXgGfHInG0U8eTry+UYamIuiw6D3ePQKKa7TGWBo7iAR/0g?=
 =?us-ascii?Q?L5EbHdyDaOWPF/wm12hchiMvvbt4mi/xr4O8k0j/XSWGsciU5q06Cnz+O2BM?=
 =?us-ascii?Q?hK9r/bJlpabZ+OxqIbokx7ryZCp9xDaQAQD6nP3xZov4Fffv+O88pOGsRGOY?=
 =?us-ascii?Q?DRovfBA29FXdkNpJDSejOZyvF9Zvb+Cwfqf1CumX6gmqDvi3HBJVeLK1iRQx?=
 =?us-ascii?Q?Jd7JrQFZYjdpAbrjWIulwNvAb7OtIYfCkmemvMENlNDhGAlwfuBtmSSnyiG0?=
 =?us-ascii?Q?dxn1h5hXIjP/7SSQvKHw5gahM5qB+Jn1tlpiuP4F2DshWMf4ONRnrPKElHve?=
 =?us-ascii?Q?wTyWn+BF4K7kESe2KnQ6uzwe49eoW59PaS9zKh1yHFio45aGuYHUgHOMbQ7u?=
 =?us-ascii?Q?sIe1y2yA6VV3VivpBEII296olss9tOOc904+R7qu9WO8bV7dKhyfk/lc77Zt?=
 =?us-ascii?Q?bBoStQM0x29fNB956AEQNVUqC+IBCnoKnarzeLQ4rW+0rT9c5oH0w8njX0wX?=
 =?us-ascii?Q?rkQ40FjSCZqm20LJaiBEMSGE5FRAIf3sJ9c0ij+LcetuvX+8wGq1Ee1KFrdY?=
 =?us-ascii?Q?OfdBOEOryuvXStwdPhoWWO/Svljw5gt7rNYBR5urS/ko1uGuc3hF8myrlfL/?=
 =?us-ascii?Q?m4Ka+Ic2Giw13kK11wPD5pa7msVPqCYFSHXHS55nmNLv8MEZJCP0Byn3tgrN?=
 =?us-ascii?Q?6Iit+CXk8w3CGhtDtCwLnf8xWuy9hR/+9cPSuNJuQQkiasUXIjsFXs+3jd8Q?=
 =?us-ascii?Q?h4vCw6MMYtWKHKeG2t7VwbN2S45DdziDPEdffIeMNat7D2XF5KgBNVZgVeFB?=
 =?us-ascii?Q?StKVi3p6PPiWw5XupKWLQaY+jBB859W1lWzPbdTMKCI7OR26pTfacsUG5TUn?=
 =?us-ascii?Q?pCpC/zVq3sLRNnnL5DtcMCUecjGXlAKb0KP2NjAvnA1lCK1h0w7c4Vrx8P2a?=
 =?us-ascii?Q?hvTipl30pQNqFI57GCHj2IBTH87UMUPyESTvQPO74wl/WJzL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s6zlFZDZUu2adCck6DxXo5YOjeiUU36dWaciRM2hBgK4J8/qCWzeoC0zBQurc1/lAjX1bZwpWPqm/AnQFykUxd2xM1vnk6OiM9WLzA9pQGrFjWXgJKhL82KsGOTPyaDn318BWKLiOXIlTRJE713BqX5LUTjus/aJmsGDJrU9NPEQZadyZVPrGmraFmtTiL8coAYFV3pvE6wqRxC/jl63A8ccP/UYuV789OC1oYEo8GiyPNZTME0ryEmOmttxmhBKXbcluP/HHVAcIv1G3RY8EeEq3oedE29+HQDALprQBdIeLxQFSVv4ox71XdXhY2gPfPwqU6si/7ffMw1OoibBGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeec79dd-df72-4278-83ac-08def679c558
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 00:53:19.5356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HG0cJR1NkRXxciuRJHtJJ+KJRXBvnL2Hhh3sz1TYfBuCwmtj/Ae0Y88p/9G8K3vI9OH6LgVhgZM2fzVfgKLy3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Guangshuo Li <lgs201920130244@gmail.com>
> Sent: Saturday, August 8, 2026 10:58 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Sakar=
i Ailus
> <sakari.ailus@linux.intel.com>; Guangshuo Li <lgs201920130244@gmail.com>;
> Mark Pearson <mpearson-lenovo@squebb.ca>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; linux-input@vger.kernel.org; linux=
-
> kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend clea=
nup during
> teardown
>=20
> quicki2c_probe() calls pm_runtime_use_autosuspend(), but
> quicki2c_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
>=20
> If the autosuspend delay is set to a negative value while autosuspend is =
enabled,
> the runtime PM core increments usage_count to prevent runtime suspend.
> Without calling pm_runtime_dont_use_autosuspend() during teardown, this
> reference is not dropped.
>=20
> The documentation for pm_runtime_use_autosuspend() also notes that it is
> important to undo it with pm_runtime_dont_use_autosuspend() at driver exi=
t
> time, unless runtime PM was initially enabled with devm_pm_runtime_enable=
().
>=20
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver remo=
ve
> path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 5f420e8215c6 ("HID: intel-thc-hid: intel-quicki2c: Add PM
> implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 46d3e9a01999..4126c2408d98 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -774,6 +774,7 @@ static void quicki2c_remove(struct pci_dev *pdev)
>  	quicki2c_hid_remove(qcdev);
>  	quicki2c_dma_deinit(qcdev);
>=20
> +	pm_runtime_dont_use_autosuspend(qcdev->dev);

Thanks for the patch!
Reviewed-by: Even Xu <even.xu@intel.com>

>  	pm_runtime_get_noresume(qcdev->dev);
>=20
>  	quicki2c_dev_deinit(qcdev);
> --
> 2.43.0

