Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368335A397
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895472; cv=fail; b=udN6tKTTubmi5pqEtgsaMLKCwaY2MjzmiX9G7R9xrfc6kVzsIiaNzgvQuYgbxoe0eTJeYUaTErw4aevml0CHGTB+azSLycgQ05SyTjsB3SeffEFahZNa9GQblFsj1M/hzfditAmaGFivzq8q0su3lYnjtq990cAY7zUh0Vvuaj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895472; c=relaxed/simple;
	bh=CijpppdFbfypmzqKxeYvoxt8Zu8P0IUZXIZ+C8Jz388=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jNEbQCEdhH2cqNd09/3FeT59B0mKwvXXE9tZrAB9uhbquwmyd9Od3WiDGeB2adYbL3QDdoGWQwqSsomUiGB3pTlWmjo85gkrx5CnpELtBjpqtVeWfreLV+iepjHtcWLAAElR0JHoCRgneEU/V5esc1UjqrY/wUx3cQSP14Lv2BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNqdzqWj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNqdzqWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787895470; x=1819431470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CijpppdFbfypmzqKxeYvoxt8Zu8P0IUZXIZ+C8Jz388=;
  b=BNqdzqWjYw3L5wxBjjd0xxwGNcTJAb4+9K43TnkWPBQmdk1volzuonUa
   BvzSRW0CEihmYcyRLQZS1Z8aUIU8XyYWSe8ukIoZk9rDhBRdb9hxJz0j3
   oGaxCNzSRD0o5A/VBc3nMdvJ2ApXYCcaL1S21h13E8Tng6A1Ud80EUwc1
   TpVtFjq+AZRfU8AgM+ZLP7YMsKk+bjfdcOcfSzEWOTpOxY175WLdY3lKf
   1wlhqeQPeHIeqR7wq55w+wZX5wGkrXXIl64ckPVJoXkdLW8Q1KJhaMU1A
   N9P4lxgTahurdkSyF7icy9sLtnWFhpjPsr23bDoX671EA9qYu3Y2/GpuU
   A==;
X-CSE-ConnectionGUID: SYVPAQAiSc+tgGn3y3Ofbw==
X-CSE-MsgGUID: 8Rfso17nSfyB1uS+cYC2Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99069775"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99069775"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 22:37:48 -0700
X-CSE-ConnectionGUID: 1AblZG98RW6clsAu9vrJkg==
X-CSE-MsgGUID: jm6370QHR+aSxR+98h9OBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="265462061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 22:37:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 22:37:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 22:37:44 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 22:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFKJ5dsq/bqW5ESkswvBtWY4cGnuBlT+kZ7+Si1ap5gX23wPdIhc/bU4xv3/9NxZdybK8YFZFFaAEl68e6tP+n/3QwsRg5JoNRbWUx7sLUlDHVenn1pCLo8MYvlnVf85edLPrIoamzOhe+vQHFnwlSQXHidcoU2uiZLRyEjYaOxb2VNOHKfdbAaiwdo1zH1R+Aawc4D7Olwgtw1o9j6s81GxVvn4usiAPXTz3nlev+npNafLMfCzZaHqbm1Rp+qucJLX1+pflWO/Ov2AxVwgvfbdI+3EKDbZZXc2SsVVsean4F0hTPWmR2zPdragkrifi07gNcDgOp4jsY67pLMWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FILTJf85v5uPI2xKy5s8S/OwlkoZAwjX79vP2q8+75M=;
 b=Mm85b3Hd7H9u4oceIegfCvYgGmGrC7gly5ZzOXix6M/fat9/fVd5j+HHjNa56koplAQNsdHonfc4aTIkkJvGaRxrfLQERSACQ2XDHliv33UR2EAGFp2BzjE4xh3CcZ5jF67H82mf58Z5PBki8s3gVZmbw/O72mzbutJN5/uBFDM0el8C4aAlq3E4LQZYUlbQ/TNkmrQlWk2w5tc8y2hZy9PkP2nqRC1XVWwYFyLOD0+GZMWuvEQ2SrvPtxb+CGt1Ap6skdt61cJDAoFWsPiSVXQ4Gqq7Bp1BU7orjtx/GD8HxLyi5m9xG0UYIUf9hyhgak3Mkd4ZdwEdLJhvC+wQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Fri, 28 Aug
 2026 05:37:42 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0360.006; Fri, 28 Aug 2026
 05:37:41 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "Mun, Gwan-gyeong" <gwan-gyeong.mun@intel.com>, "Auld, Matthew"
	<matthew.auld@intel.com>, =?iso-8859-1?Q?Thomas_Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Topic: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Index: AQHdNEOsiSEBcNzQHky6KoIO5zqwNraxXlEAgACibUCAALmEAA==
Date: Fri, 28 Aug 2026 05:37:41 +0000
Message-ID: <PH8PR11MB80408900F1872082BFB05809F4AC2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260825034113.642528-1-jia.yao@intel.com>
 <20260827050834.10008.stable-daily@kernel.org>
 <PH8PR11MB8040873E3763B18A18D7C81FF4AD2@PH8PR11MB8040.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB8040873E3763B18A18D7C81FF4AD2@PH8PR11MB8040.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|MW3PR11MB4588:EE_
x-ms-office365-filtering-correlation-id: 53517a14-5047-451e-0d45-08df04c67abf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|42112799006|376014|22082099003|6133799003|10067099003|56012099006|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: FU1QnNbA3lqsIW/MfucbyWK640L3OzX9akI2VRZZjg3TrskHgzTBXBCOh+/v8EKkcOvAvzh1RDHs+lSbkEyRrKO2OaLxxXmuMfiMzs9rKlaZ/VXLV/n7SwDCM1oRWNr7F91DTO+P7dDgbiywk/s1Xn2C2Is5I2R4xIh23vB9zmVkPqYX7XzUK0Y/c0E+sV0koA2wiI6+YU1oSDa17dNp9yP9GoEOXqwg11kGnoxGRPxDsVdp2WviARt5ZOjdC+L/v9ecL1ysCZftNaynGXHas2Bl5MP+rWt5jG8nnnJ2LfuGTtSUMP9/lFu69FpDqqBtSur9Dp155ncWVeXiMpX2sJ+w8f+yhgla3PnYED9b7ivJHr91jyHfl+EtCng6Ab6ntzFzxHEhM25vUviTb3JdYVj7jTUoBQD3mQ1BwD1ng1+wlHCdmoa8jrwgd7G03k/wP/92HzxtZe7J35GMAGpqqTaisGs2uoTp+OC+4DEMUYtLIjvGbb+ZP4NSI1tomf6Uz4R+Mf23VRZkWdRYA18+NQKUhg4u5hVkqmzyk4N1Xn560o2YYFH3AuSGUaW8FWK2rx3Ls7HfWk6rmqMouI2XZ/PolKrsUZ1YVOBonBGiZ0MhwvOysnYefhS+GpugyBCzlHpmcgEldR0Gr+Sdh6WjEyvkgme8SJa14wq+L8Twqty6GrViNH9oYZJb/0/wP0D+MFNmNz+Xd7lKhY2erteHnpRPDCkxhwhphzhMFDuuHZs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(42112799006)(376014)(22082099003)(6133799003)(10067099003)(56012099006)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jSZb6p/6W8R1SBoCTko3k2bTdFhyI3olQNwb1QZwXd/zyEU3W+7P8xU/jf?=
 =?iso-8859-1?Q?IX1g+7xN38DgDaieQYPg7C4eyLpZev5XEdeFvmFpK/BIprmkFE4Jd8Ra8k?=
 =?iso-8859-1?Q?RImnNtPucI4SjLwimRWnl4slC5vMZh+mws4eyIyiqkD1sy9EhATv2Ea6FB?=
 =?iso-8859-1?Q?d6WStyLFziRU1E3hS38uBj98fZ++LokXldM8MiIwDw5PCKGGQaWPE88gnO?=
 =?iso-8859-1?Q?mhhps8zL3quZibFso1Sa79WSzAmFVn93i869V2U2rdXSy2QLL8G0Wg/YxT?=
 =?iso-8859-1?Q?JcuzDLDwfOkh8+O8OC3BDlul5kYKwrkyhqR390XGriwdPZkpjJ4rifSdZn?=
 =?iso-8859-1?Q?x9IsakRLYaQeIMCJd/PEAv1AFsYnzGPuAvEIWmQGMMXXiFvVxcYWsw65c9?=
 =?iso-8859-1?Q?mK+zrSt8w+8/L0TXj4qIHAyybiKoqt+nl+HUsBCJf9c1LroCjfLfQC2VIZ?=
 =?iso-8859-1?Q?5fv6Ev6HhB4H6jrsfQ/ILQwrrUy4W3tMv9JSTApUTQ5+fTaCoUKazj40m0?=
 =?iso-8859-1?Q?58Av/wkJqJhzA0BDSfDuKlFjziyAPLB98x11goqMzTe7ruTTLxx9zzRjRH?=
 =?iso-8859-1?Q?dnXWQ5s74iMgrhiJ3FoKvcXz0zUUIhJj6gc6f0okqeWB0qnnZ2O7/Y3Slo?=
 =?iso-8859-1?Q?DZzIhn6Zpmk6N9K9BAqZe18NEYztdwYMkDiwrtevqbaLt9byCoIwPd7CzA?=
 =?iso-8859-1?Q?T7kjxCWBSngKcidL+Ccr6ZaFMA3rdTK6LK3f02FZNbqA/IBnrnjtqx/AOr?=
 =?iso-8859-1?Q?ghl0Vf2Mlbpd/uNXVZbaXl5ckOi516pWtaH0DqiR9vm2H/NZ1RbcAB6Gzh?=
 =?iso-8859-1?Q?fxWIuF5sx+kotdUyMLGjKIEzPAn5X3GDXH5UsF3riKlSnNMcVA06Nri32m?=
 =?iso-8859-1?Q?Ps1JdOXVhFvFEQnxKUdWa573JKF7RMstPf1xKYvu0lc4fhoAGhNUCWZJgB?=
 =?iso-8859-1?Q?QA/WwA8TFVMLSFjaptM9y5Smdy56ia89xomcjeq7hNx1WzBfNU7woon2XQ?=
 =?iso-8859-1?Q?1wXUoistffCQlzWcbMrG65XRufs5zeBNYdhDcXb6s5iuna9N0eAdzSd0SI?=
 =?iso-8859-1?Q?/eLhw5oylKfUKMto2gfq+XZjpBA3+R6M6na2FLKaA0XrALjgsqNhWWa6Bz?=
 =?iso-8859-1?Q?DKlY3953P2OePzBH4LbPNfFmMKC0ivGZy0hhQlQD9tl308r8/5NN5iadiX?=
 =?iso-8859-1?Q?FqehAwwQCDSDNvAAPsoLLGnb0AdzXRM2n0vj8Vk6Y78MzFYyQHo6SB8mOs?=
 =?iso-8859-1?Q?CgOHXMeMRtC1tSBw7UH45wc+4S4yKmOKEuqtOjztBHPay9CQi0hUsOAxG1?=
 =?iso-8859-1?Q?Q+NCEzkB3g7hdM0kdwXGp3s6cjAW98tsofCt51RW05uNu94IpU+pqQFjv3?=
 =?iso-8859-1?Q?4SLqqWevQlEq14M3SKdzxGcYL2RIoH002O7LbWd2kDhZjWW4EFmnm2fmFq?=
 =?iso-8859-1?Q?eMJrGsNTLP64ex6IpvWlth6ZGqkEhO1JL+mx4zNLjs2Mm7OTPH5GSw6vOi?=
 =?iso-8859-1?Q?xOFxMifikvGYPnM9bR/UaECM46ALPCDAj9RZO2N1/k2LYKgk2/3i8ozWm7?=
 =?iso-8859-1?Q?PJhceDQW20oOfjXcxtkN2nevWg/bf4/EJcCiNylRcNUXVFdFl8G0h2sC/P?=
 =?iso-8859-1?Q?kN88Gl5jRR9pirbadAYPsm0w9mMHTKlbvE6EtHBKOyMMrY+ZTlKOBRbb/q?=
 =?iso-8859-1?Q?0U/z6NRW6lOkmESYmVCana1jty5O6B44JagbNhWI+SR8FuXYT5UPwg3b0A?=
 =?iso-8859-1?Q?wMs4ysPQ7piWOPH/7IqCY8qEGgV693Gs3DvQasgm5oEqjtGVurqCBQ7oS8?=
 =?iso-8859-1?Q?kWsOYMtMYBFZjUctgAoVyOxvMDxw8+E83JKjmkXolzB+HHFpnbUb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LvoiWcVOClMmdXdHK2J1eGRQYgGAAVme0F8cTGJGEI3QdaHgCscE7KbzR4kuWfOKbpIqm0Nv9UCUVp30Ji670yMJTEMr763a0yJYcM6ZaNByZJCh/Hmm6Rh65GSwRZprouJJ60J8w38QbINiIcjjEB6z2zT+wyVADdZKNtugGKgcdN2NLeMu5EeUXPt6yoLBaEJCqDde/2+IdShh0u9YpMi3EG7jr3WI7dkDF62tbUgt7swL4Ru0BscxqPja3HkO3v0z4sFkweUXLli50Ew+bAxsPenAbeD3H1RR/NnaF5caRld9ZISu8nJaIV2TyxQIPbGsybsMXPuh+KCAbJIZuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53517a14-5047-451e-0d45-08df04c67abf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 05:37:41.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FE8RyXvLAioSPbKvLJl2pvffPDO/KNr5MLJd2NMukTFpVTvSkpIA22PcGDl6Bf8e8i2tul/R6WcjluDAGIm58w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com

After further investigation and testing, I found that 6.12 only supports up=
 to Xe2 platforms. The original issue is reported on Xe3 hardware.=20
The cases that trigger Xe3 issues work well at Xe2+6.12, no test evidence d=
emonstrating a benefit on 6.12.
As a result, the patch is not needed for 6.12.y.
> -----Original Message-----
> From: Yao, Jia
> Sent: Thursday, August 27, 2026 8:04 AM
> To: 'Sasha Levin' <sashal@kernel.org>; stable@vger.kernel.org
> Cc: Mun, Gwan-gyeong <Gwan-gyeong.Mun@intel.com>; Auld, Matthew
> <matthew.auld@intel.com>; Thomas Hellstr=F6m
> <thomas.hellstrom@linux.intel.com>
> Subject: RE: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
> separate BO
>=20
> Thanks, the original test case is not applicable to Linux 6.12. A new tes=
t case is
> being developed to verify the effectiveness of this fix on 6.12, and test=
ing is
> still in progress.
> Will provide v2 once it is done.
>=20
> > -----Original Message-----
> > From: Sasha Levin <sashal@kernel.org>
> > Sent: Wednesday, August 26, 2026 10:18 PM
> > To: stable@vger.kernel.org
> > Cc: Sasha Levin <sashal@kernel.org>; Yao, Jia <jia.yao@intel.com>;
> > Mun, Gwan-gyeong <gwan-gyeong.mun@intel.com>; Auld, Matthew
> > <matthew.auld@intel.com>; Thomas Hellstr=F6m
> > <thomas.hellstrom@linux.intel.com>
> > Subject: Re: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in
> > a separate BO
> >
> > > (cherry picked from commit
> 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
> >
> > This series needs a v2 before we can take it...
> >
> > The cherry-pick lines name drm-xe-next commits that are not in Linus' t=
ree.
> >
> > The series also does not build on 6.12, and 2/3 is not safe there:
> >
> >  - XE_BO_FLAG_PINNED_NORESTORE does not exist on 6.12; it arrives with
> >    045448da87bf ("drm/xe: Add XE_BO_FLAG_PINNED_NORESTORE") in
> v6.16.
> >  - xe_guc_using_main_gamctrl_queues() does not exist either. It comes
> from
> >    94edd6518613 ("drm/xe/xe3p_lpm: Configure
> > MAIN_GAMCTRL_QUEUE_SELECT").
> >    You dropped it from guc_um_init_params(), but the second call site i=
n
> >    xe_guc_ads_init() is still there.
> >  - On 6.12, xe_guc_ads_init() runs before xe_vram_probe(), so 2/3's
> >    XE_BO_FLAG_VRAM_IF_DGFX reaches add_vram() with no VRAM
> manager
> > yet: a
> >    NULL deref at probe on Battlemage. 2/3 also removes the
> >    xe_managed_bo_reinit_in_vram() call, which is 6.12's only working VR=
AM
> >    path.
> >
> > --
> > Thanks,
> > Sasha
