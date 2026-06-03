Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02F43C07D;
	Wed,  3 Jun 2026 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476879; cv=fail; b=Gb8Fb/TJFyZn0pZiFLyDdaval5B4sS3pwx/gt8nU060DNZL3sT4k7GoHII4muNcx9dECY9V1u2N2a79ZvEvxnx0Zd1T3v/1fLk6frPQYGuRBJfQELl9rCq+efx+ydQ7sT0OPVTGKVnNXOlQbiISOP5N4B1HwCmYxgtWzrj6O5zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476879; c=relaxed/simple;
	bh=8lj2BJQ/l9jdqkvWNq2Smi003zDdsI9kSGtn79NN/bA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vADgmsnwMgvbFsUML5sKdo0raYq6EiHZAnvU7xjhliLz/wEF+bF2wez2UDQJWtlBw1L3Euee6Px8kRqWbws37+e258ZGeDc1NiSmPtjF7FpLgedEsq8zx5Or8k22G+tBkbK9Fe6cwr8Y81kQ0sd9HxUoSzXJf/G2721a/y+L0RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDHKVTfV; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDHKVTfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780476877; x=1812012877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8lj2BJQ/l9jdqkvWNq2Smi003zDdsI9kSGtn79NN/bA=;
  b=oDHKVTfVFVjefKLnVbWPHpsVU97n0RwW9kXnafcdvwYtzrC1xuiyABPI
   lohYAtl+cUs42rXzrTSV+KLF4SmXk/YXO5zwx3H3byJb844D7bG3aPdat
   4h+x9lMmD+NEkfBXC6UvIZYp6446sbccuMzPvWV0YTSvW1J9wmmcCFJtF
   8sWYK2i++vjgL9eiAh48J/zpYpY4UVHScjogTfLpmDjY+9lwoopJcC6Xi
   6HwAS+dg63Uzti4mvS3GPmqEfGJSIXhCY8PmIunpVi2N7VoJohFgLpoo1
   B9uOCyBLXOPxYlEJ8EiPrL8/cy5++aX/NdBxlRFLmkcYk5g+rh7BbuI62
   A==;
X-CSE-ConnectionGUID: LL7ycPE/TsKfKpv7ZhUWhA==
X-CSE-MsgGUID: BhgWzfzHR7So/qRP+Tud9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81337725"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81337725"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:54:36 -0700
X-CSE-ConnectionGUID: u5EqKBl0QG+mh7THLdY9AQ==
X-CSE-MsgGUID: dDr7gVpnQVqQm+yZUN5dmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="239702571"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 01:54:36 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 01:54:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 01:54:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 01:54:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTOLq3YtYrdqg3joD4Em448nSOUfU+7RA+pMHZ57hTm/7wHdN6wR0JfjfNF3RL3ewk6OWmRkLqE+mGVyzxWc6TlJ5egDDrTsWFcX1FudK2twUzd4clcyGg2LPJdvgm9p+IJzu8g2OOICwt0f3ogQyYYllmnpDNo6WLvTWw+a5OgAaCWBvph25kZQ2dwm3TT5iO+AGw3oLHykX6fNWbdd4wXhMiiKq6CIjMVQXZ4zsSTr2ZNDJi3DpbamwiOknF8BHLqJ2luwufmPAPqsvl27auKLtKmCUkcl9GhGbvJVL0pZ2QuGWKG/gjdWsgNwM34PLrjRyRVCZc3IXoji9fdakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lj2BJQ/l9jdqkvWNq2Smi003zDdsI9kSGtn79NN/bA=;
 b=HI56cGbpgx8HownxkA3JqeDdnd1kFwukYscPybgWmbf7goFd9LWye9ByQK0ndfshPXNI1lip67Q5ys3Klra4QjyELESzHjeL31XLht89rm1gcktOk3L2Nq+mfTOE0xn/+NdpnV+zZvWeSOKQgboy+aFGu3lkYsYH3t6uFDq7FnJiD1/4zlIUnVTIFZMI5H2cXK+tt66CYXG69pCKzPh4h70zFlN54sWxlNRRV3EsP3aXAl8QxAKAJrjlLTYHburt/uf0WCVltnLRIFncLqVqyQhFXr/OrWK+vVE7cIzXNzjAP41AiaBh4Mj2VBVNkhdrRdRiuuwJLbmIxELuR4HQsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by BY1PR11MB8006.namprd11.prod.outlook.com (2603:10b6:a03:52d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:54:27 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%6]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 08:54:27 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: Simon Horman <horms@kernel.org>, Dawid Osuchowski
	<dawid.osuchowski@linux.intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Medvedkin, Vladimir"
	<vladimir.medvedkin@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] ice: fix VF interrupts cleanup
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] ice: fix VF interrupts cleanup
Thread-Index: AQHc47/nUijr3LMUJ0qX/ptkj5hNmrYVmXEAgBcMLtA=
Date: Wed, 3 Jun 2026 08:54:27 +0000
Message-ID: <IA3PR11MB9301C3B37420682E93B3AF738A132@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260514163555.8243-1-dawid.osuchowski@linux.intel.com>
 <20260519165644.GI98116@horms.kernel.org>
In-Reply-To: <20260519165644.GI98116@horms.kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|BY1PR11MB8006:EE_
x-ms-office365-filtering-correlation-id: bec672d5-3cc7-472d-53cc-08dec14db7e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: kI7lSXAkTgT4bIlPt8YGm8inuImNqdMHGRKlvJfjcvfRdABm4wuLwSevHGJrlgUDT3Kg2s350SCbY4yk+FXGg4a0jyhBiK5f5zZb+TXgTX7Kbvoe1OLCFuc4ToxpqaBr/JLrYpZEEu0hQKz32qEcvvnhMkeWXxzZUrhXmSDGnf9n43si33KDjV6SBCibnlzi++D4U7P0i+9IFqZ5PfhWfpOKXoMQw+VxxP3YcaXFqirS2TBDA1qKw8wZf8okrX92RO93ZWLGSqPtLAccFQs1zHpYkOBWyFIt2dfnhGFhVUPhoqg4TZcDQEfZQ7gHUedPQOlkH0/AfQ9JaY0WqdHtLzDlwFAGPWmYhpZADYJx4NoOqDLG+GjEtu7Jcnmz0xQxbH37QYRoPKlRsCuYejiV46/p38t4T0Koa72zRH0my0wEFSBwLjGC52RF7/v6fz6m9+Pz5h1WsYzuYBFEdiOp7RJjbiWKaqf9dUeqKOaxayXwblkLZ3lDsTkpYW/m6X9lBwBcpDp18xgjMXm+xEJyGzCNgY8OKG1ripRJpnxtBruyh8FHMVY9V5rYy5hbqljnN10lAoyESzJnKlGEssIAGx6CZsiZH6UzAQ8tFYKAA7h1Od9mG2tz0aQC8Yh7AVSdbZ17UXhDlDPkmHXSUDsYF3mGcNIU0+TZyb3pJsHlyrJoTkoexo2YuZN38pPsCiprYsOg61YQiYVzaRpaXVYMdpGSIjj2sJbj+XfZ+wiqEp7k/InhvWS6+VD8xc3gNzm4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OiepsI+wi7Qd5MY/8AFZvZXIY9jZ5Y30o99sgD2AbYR+tBboUanSHsOJMn?=
 =?iso-8859-1?Q?wUb3iKd4objce7LkrK3vzWchXCrdq0VS3UTwIrNLdisIavBzFj9ajRJ2my?=
 =?iso-8859-1?Q?LI0vHXQMka2/AhiEs2dQVYSz65waBc7e3s3cnX7qBfZc4LPNSF6nQCIscX?=
 =?iso-8859-1?Q?tGUH2SfCMxiFc6XeKQfOezc7FhsYkrL3ZgCJuG75Poqjs9bexlThlh46qV?=
 =?iso-8859-1?Q?8q1q3w/r7OQBWXHvboJNOdzHA2GkZq/fIA1MsmOsF/GpiL+eC1Sl0WN+5z?=
 =?iso-8859-1?Q?RSswbcE8pv0QaBIASeTFA5mVX+vsrTt7HoCAttVfAFd/8dbgAshz/rOoe+?=
 =?iso-8859-1?Q?LhfSNSElUIqIuP1CwojwOuEYPw4lIOfx90JQNbwAl2eosCigLMJqDsGxqh?=
 =?iso-8859-1?Q?x4pc3SKXV1fJLKrakKYn7ptQsXFnqdOvZsBEoR0uO1Ud0/6ttxtCROGheX?=
 =?iso-8859-1?Q?LWI6n9FkBfCBVypxS+zqxLRUi7hYSZIBX6LM9sCtQzi23Dfl+SL55tLSYy?=
 =?iso-8859-1?Q?pkCoWtnv0jU9FnMxalZQsNad4aUPUKNTn6Zswzrs5acQfh1Cbey0KkQjwW?=
 =?iso-8859-1?Q?92ZlSYc9vQAURLrvT6AtuKRCNjsVFiLO1zfX2vZ/KNDZ3Y2+wd/aw/BrHY?=
 =?iso-8859-1?Q?GhfyEtdoa/6+u8SueftmjHpMJ+BhuoskgbBtXMHPwRsMepf6hMXgjVRB94?=
 =?iso-8859-1?Q?0qAWChoEDUIKa/uogtKg/GJuC1MERur2Q6QtKWfs/luxtqZr0jG0Or0WxK?=
 =?iso-8859-1?Q?Ia9nbuMy3HlTgm9fKrpSxGRtTKVYUICxCS8/C7yIXJ4umxgFHIX56F+B+h?=
 =?iso-8859-1?Q?yfQYacbt/TmFCQCK7pYQ30IfLaFiWqMhgqRHtbwzU8r0dwu0gPctp4RooV?=
 =?iso-8859-1?Q?DBmPGorQ4Idb4MClG42vMz4ZYpo46FE5K3aPmIXsYVuuZTGVBnUsWDbvg9?=
 =?iso-8859-1?Q?YHVTqcZIPeHan8tjmrATZP+k/Taj12zu26qd+RYvmCKJWBOPckpdsauvyb?=
 =?iso-8859-1?Q?EG9shB7SGCKKoMr+G/4OJ9exyr3WZhl7CTd8cXDHRap0a936w487Fg0PNN?=
 =?iso-8859-1?Q?wEBPWkIPFAU6FQIVYndoIPOUbvvuiLwWlerHV0teclB9ZQEozDBoVIVSiy?=
 =?iso-8859-1?Q?45uIsLM4KHo65wWWS/Xjk/gRuNgt9tJuIAK0fNnQmmxj7ofoTpZxMrG1yk?=
 =?iso-8859-1?Q?foA4S03jAOFI4hAizN2EMgt4iy6SRt3o43RwmO3MC9Xn6jFrNol2TNP7CA?=
 =?iso-8859-1?Q?xHauIbomys4UB/UM1cE+TV41O3ZQoKRS+PM4OjKRLhHLaN5ORx6xt6wPsc?=
 =?iso-8859-1?Q?gFQoMxasDwfa0+WAwZ7YX4k3MrNFayapbBA2fmjjjrGJ2Ep3eDgjfqWXAL?=
 =?iso-8859-1?Q?U5AaKE/Ogrn1jOuA1YpTJytukbPCZqYnaUNiRqdr3MngFkA09mqwz21eOH?=
 =?iso-8859-1?Q?v6pFTIB3p8tLYrm2Gctoye5uywp17U8OLAB1qNTMSR8Ej5WcjCP4BZFH41?=
 =?iso-8859-1?Q?PMdImmoQ5GsERYsRH/DSALcngR6dnRNRVOoFS5sHnSHrJENPQU7zpZRdyF?=
 =?iso-8859-1?Q?dsiBTFkWpgLHlOU+a3ydx0QE6xfYlQtRurfDxbrV2Ou3xieIRzmUNbM4SV?=
 =?iso-8859-1?Q?8p+e90JCEIy4wH1ZWtk4iiQcZAvCd22QDVHGX5/vfiw+WCTao2TtM7N18V?=
 =?iso-8859-1?Q?UwwIXaZSz8kfTpjKri53Jclh/SVjBLt+ZGdhc08loYDlpiUGnYfoTTzVNS?=
 =?iso-8859-1?Q?Zx4lJmySYFd/k1ZsYkbeFz9ky5uppRu7mn3tEfhe/1b/rC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KVmvvnF8XuHRz7jrvNaBZg6lcP6hwXaOnRXaAy/H3O47E1ILljt2hF6Ct7J+vmCnNt/1+4b/Jlv6HzeimlfhQ0YdGa7BaRrpMOpd9o8c9HgBnNB1mTLxOEOFk53smbH0bxPKNe6NYuQgxThI5+CrMPVOxhcUUJdrhuR1dvbqKYbb2GYBYbFrCP42dFO8SiuBbHXFKeq91tO/xoiip6aZSPnHHOgD3ccVaOc/2CnAhSuoCSO5TN4Bq/pEYza0sD1iM0H7M29SEYWeCalFwlZP2iijW6ILjfS56FOhfPTByaJitYcm9ufa6JIHs/o0GNZIhZ+a+BhmOG5U1FVcqg01kg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec672d5-3cc7-472d-53cc-08dec14db7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 08:54:27.4871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXqtpCZRyTwReYRbTvqeE+AHzwDIhdcMjDLiHpZpy6zl+MXhlygRuLMjmapskPwB5HL/pHx0QBu1RseXg1PSgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8006
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Simon Horman
> Sent: Tuesday, May 19, 2026 6:57 PM
> To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org;
> stable@vger.kernel.org; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>
> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: fix VF interrupts cle=
anup
>=20
> On Thu, May 14, 2026 at 06:35:55PM +0200, Dawid Osuchowski wrote:
> > When a virtual function sends an IRQ map command, the PF will set up
> > interrupts according to that request. However, because these
> > interrupts are never reset, the next time Virtual Function
> > initializes, the interrupts are still enabled for a given VF, which
> > leads to performance degradation in certain cases (e.g. Data Plane
> > Development Kit) due to interrupts being unexpectedly enabled and thus
> causing interrupt floods.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 1071a8358a28 ("ice: Implement virtchnl commands for AVF
> > support")
> > Suggested-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


