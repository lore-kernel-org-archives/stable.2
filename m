Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCE3815FD;
	Mon, 12 Oct 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813453; cv=fail; b=WUYwneIZAPw3UBNsLZeUiIbN2Wx6h1qf0jlkIKbCKd+J9EYUpsp5Qvgv5qyDe/xNMU0CtHkQAUzeCID8CKuyGNmiByrvJuqDKT+kW74nc7naZS2nYKIUZVyz7ijAvhBeJ/oKHTC37fbczUVikXMkjeVAd0wWwPrv0XjVxicxOyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813453; c=relaxed/simple;
	bh=U+T5SWdgbqxpaTdAto2MSnGJVSXLFDZsZgxyH9CNKEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SDfe6aA0AB+4hCyCfKbZSMzQW5J5FltpYDuO+2MRUW2WN+qN7XD9iTNFbgmzTGdwqAEm6KDbH3B+q7okesx39iD5RwPgtLQuj5tYnqFUv8DO7mXla9RQKscHCHH3L9MroGoTEES9R9eCEpb06NVcKX05E3f0l7eokGGPneuVof4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f6CuMWdd; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6CuMWdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791813452; x=1823349452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U+T5SWdgbqxpaTdAto2MSnGJVSXLFDZsZgxyH9CNKEw=;
  b=f6CuMWddLsJwF7sul1dna/ctM5JDqW9C/iZWUMTB/9gdOlI4IM00e37t
   39ThR9wx1sDUNwgg5LUaQsUVU+6kMVjJVPoKT8wIx8Q8BqzBeSB05TE8K
   BsYUpJflwGZx7iRkhn+/lIB+Zh36vkC5oZURdJfO/QQLfPvBs5K0YP89G
   G5tmkcJWA7NeWqZu5FEkoSFEUcUm4NP+/ZhKEdp40zyPnZgXRyJjkYLt4
   HmmRCNfEBTPDeZDCCTaclD3dEJ02xBOE5Gep9JU37Fu8W6dMeq0Y3TqUB
   bI5kJ+XApXbNnXVE3pxtsRegcAs9pCz+6auHoGe/sPFUyyxE+oLPdy0yr
   Q==;
X-CSE-ConnectionGUID: y2mzC+coTAqiShYhK7iHfQ==
X-CSE-MsgGUID: iKLCPIAaQcikyCMTh4VWcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="544936"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="544936"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 06:57:13 -0700
X-CSE-ConnectionGUID: ar5/9tubRjWL1P2CuZ33iA==
X-CSE-MsgGUID: dgSbEy5tSqGASDTGsxU7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="913175"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 06:56:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:56:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 06:56:29 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 06:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWXJc7CHRq+YqjIkzIA4rBgcEM2Q5LGsB70m1aOl+rn3ZYfZcohf5JZCr3ePdIMWl9fmgA1gxh13Y5rmnvSalGQYiwdWuAoQVliyCfA1dHul8Iz2+tIlEHqUu1Sq8W/454YqbSR0+DvlqDt0M9VdsDSRjftvrdH7T+tgt0/dAe7zmTrUT6JJkGnfQgMJv2JThYhm8z5bUQ/JLCQibGzLEWjUl2I+ny13xpQaS5nH8806cUBDwWx6RhyzJa7MIoPdZCSHIBhwMDw5gkYUx7xSEOGtxI4Qlghpc1wpkQUS0XGB5xWHiKIUk6/BklqcFbvJQZ7ONla5Z4d38SGjNuACdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeXI3TBtvvOwfS7OSPVPh/KJcWLIuUMploMN576Cu4c=;
 b=NJ/RpgUygijARkoeimE0xUDcCEr2fXyGTVWiJwpvnKnIV/PlMrZKO148ujGQGk0lAQcr6u6adG9y9EgLlbrKRQLUINgvyizWDKLZ42wAcpWHQ1n7SIPIwsSCewk7GpBD/4CzuXZyg1Xvg8l/En7JSzNQTw6IYb0BialvUrvQxaVdSXlSEd9Km7ZRvpIBwkVg6AJkbpBxD1L7fF7NpXbAf9L2vSj2mrjxdru2IKkl95/LuRruzY4H9pVAngZLFDmzrtiOvF39yI5dA94vykHTdpS2fsKfU0UX2+/nBUAosymyTZlSOGB7aOwNNHDpe5EGTkBnL33+6mDYBYDYF1EDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9301.namprd11.prod.outlook.com (2603:10b6:208:573::20)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 13:55:37 +0000
Received: from IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c]) by IA3PR11MB9301.namprd11.prod.outlook.com
 ([fe80::714b:7d3e:aa0:104c%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 13:55:37 +0000
From: "Holda, Patryk" <patryk.holda@intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Wentao Liang
	<vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kalyan.kodamagula@intel.com" <kalyan.kodamagula@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Swiatkowski, Michal"
	<michal.swiatkowski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Topic: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Index: AQHdRpZqXDnztcfZrEew4RFsiLmT0bbSoj8AgCdzPeA=
Date: Mon, 12 Oct 2026 13:55:37 +0000
Message-ID: <IA3PR11MB9301A9DD05D22871DDE95AA98A9F2@IA3PR11MB9301.namprd11.prod.outlook.com>
References: <20260917111114.2148482-1-vulab@iscas.ac.cn>
 <IA3PR11MB898619C38AC2792034B229C8E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898619C38AC2792034B229C8E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9301:EE_|MW3PR11MB4652:EE_
x-ms-office365-filtering-correlation-id: 8eb24ac0-3d91-4f0f-7b46-08df28687e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|10067099003|18002099003|38070700021|261009223027099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: dK0cGe0gSsLDreKj34c3bdHBxi8IYhcrWHfl8gYg2OZpSGuRDmLipi3lUQHl2o5HndM/St5deQ/7VTBlmS1NVfblavBwraCvazUpJW+Z0pMr/5ijUNdTvgZMIQo5YUNLkELOF1YMBuBiXf0hoe7r6QK430RnneXWlJMr4/felRgcgzmksIyNqQ3aoLjs1DJioOWMEIz7nzt/aMSmR+zf7yi3hlhxkAP4+St1toz4sEe5LW3yhLgjNNy4+2TVXGrRbWfWxDeVY7u37H0F/LRA1O5ziyPYQN+D8vf/sC4NmRVeLK0eC/0ZPghEeGQxXtNCQuS504aRSawMON5DM1CINxDwBoAftgsVSm5X7gXZg7q1muIhnE7fGb99CkwWiqE4+z19l8SwvZPl8NqG6CyZIw2pHlkFbbofbG7n5nj7W4Stz1vBihCkEfS1eAIrgFVToi/WkVyWbc5ezxHsSaVZdADpHT1Ecbg73Q/oRE8kDN2WalNof9i0faf4GepWlkj6Zi0xfsXU6FqGn8ckIfJ+jMwLb0UQFjQMuFnzJVupgS7baSSwqBgtqDB+/HnKI0v5XojRM580LiZhoiFmBpIdgkcrRjB7AIy68fVekzoY5TZQPx5IrT2vnTRZrjdFVegdFEjBCFISnQ9FIEHjwLDwhIk1lI5yMxgiva/ZlS4VUlLPkAJ7SCeQcR8h0pZFlHF2O1O03bRQTgOkrwp556UzSvl9etD2ZvDgOAOF8yEQNIM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9301.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(10067099003)(18002099003)(38070700021)(261009223027099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T1QxhtSaDOHlS2GRM6JGolTh5l2R3EyQqXp/ooRBxXvBezRaIUnmjdilDx?=
 =?iso-8859-1?Q?fcolVAwMvUIlqiBO6/yffHhdZym7AxbfLxIkWPMcxApJZO7TEnxqXT4eiQ?=
 =?iso-8859-1?Q?qY5ge7GEr84GQhxQb2W11OWRg5wMXC4fR5g96mO0ffF4UNjmrEX1jN6v3S?=
 =?iso-8859-1?Q?EYO1x+J+YSfhzHJLN2u8wBoMtMhTfmCMorLf0DMRQh+0kdAXP3nzrHW2tC?=
 =?iso-8859-1?Q?hNbJpEidrWd/teGDkVlMcJydd6QVMEkcz061fywbYqLvabt4+hx6YgTuCq?=
 =?iso-8859-1?Q?ajwFLbI0t+eC6PIVjfj7El4MZZLVjTQZC+ozwj9WqbFs0hbL+kRX+aZc4n?=
 =?iso-8859-1?Q?RYNrT7wgjtlryUF+VjEWchhNUJtgYPjV7NYZiScgKbIDwRN8M5Co8jO4cz?=
 =?iso-8859-1?Q?ZKPvGcq2VLq4Dgh6mdMI5IiUhTm99/26g0G0EKMTI8hjA0Ij9k55h2BdpF?=
 =?iso-8859-1?Q?+4UfS856n9uCW49us3YdpchrL/7DE0SHTEGW5mIflytZdI+fayFlTB1tzR?=
 =?iso-8859-1?Q?fkgqEUaW0RiNtnFsneYdctVwDOfhzbSF5fQOyvRsm8tW0PBiYRmpQ6sZXT?=
 =?iso-8859-1?Q?rsWVwWDdfapzYeeDiX3GiRc0MiGFPtcwxUYgBLPnpoDCoEEHAjLZuKFBVx?=
 =?iso-8859-1?Q?WAkLqOKPMscT51YCf/dLVHcGY1ucDCv7MKK/xinKl60M2DXDCjvJFaYsAt?=
 =?iso-8859-1?Q?WkkYn0oIQIIV9nIBp78JHmhhP524EzPlSMbQ4H7xphEZtnvqe/C2HxvUOL?=
 =?iso-8859-1?Q?QOTXlVVzYFEVKVLV8rc/7xXTAqZJ3o5LWkjrg+MhRIuvfg05BbNdhCwJOi?=
 =?iso-8859-1?Q?1FlhnNkNmlv62GJbcztQqN9dcRhxR17cokFIiioGb1ITvB5njK9m1Lhbdu?=
 =?iso-8859-1?Q?AH7CnSQf+6yLaJJNt5DjEQc35u5+5uhQ6tVwJl4FON5bGkTZXIhsWE685c?=
 =?iso-8859-1?Q?/C1ZYala72/8bf7j8FWrpF8amY8poLby7xqUTHf+FqaqNj35Wlqd7FO+CT?=
 =?iso-8859-1?Q?U5KIhrIbcUYbNOnzr6gvnaD7OfDIrFTiLRx/FFqV0rsDET5e4WMG2EdDFV?=
 =?iso-8859-1?Q?BQVDidg78ATptP7eI5XiP1NlHjphzHxr8IS1ixv0RAuyGyRZWh0ZhBUBod?=
 =?iso-8859-1?Q?NhlSOij5a8Q5JHLSNpkyxAzBs2UaRVXGp0apaPIKGs6qzzPuBIwMSXTh1C?=
 =?iso-8859-1?Q?oGtDy0POC5mPGd0t/71ACQNqJ3aaifCOAK0FNWLJqHn3coUfFtQgrLF0vu?=
 =?iso-8859-1?Q?MSErX+/H9gRT+LcmxKVMVEbH8+7j6LioyGnV9XXRWM5BMLtKopNQ3sAsPq?=
 =?iso-8859-1?Q?x3kkrnjP1JG1GK9tjIyo2ivo4hFwH5vQ1g/w61UBGDYm2dRd+E+3eCCeIS?=
 =?iso-8859-1?Q?JxG+CGWTD5FbE1Bf2v6ogj1EIUvOy9TuAGe++yR2rXseg7ZW8JcI3L5HtQ?=
 =?iso-8859-1?Q?nP6IDJFmXHGb7QWmU2kyJjyNaUe8l8xmxl8wSUkgU9Rtba5ewh+wESfJvG?=
 =?iso-8859-1?Q?+BEnk4wqpvDtXEQAgso+v+nEHVZ6NVA7WbltAHMsmXo3kcXyHNNPND9Nz7?=
 =?iso-8859-1?Q?p4ll/KjvFvH8dyg3VWy9x7NwgufgcEjSSXmKuHGGBsH6UyNpppisO2gAVQ?=
 =?iso-8859-1?Q?jPRcJjAAln3DzwpKYJHu3ko5rk9NoMb9FC5+eGTu151c/DZAEVaXbhp3gL?=
 =?iso-8859-1?Q?tHKKw0VhWbxUiB+n8qlm2pKHD66r9KfhR4RIPwDFQ1NLz1bxKhHclU8AD3?=
 =?iso-8859-1?Q?tV2RUaVhoBdOy0Ldu+1rWeyMGsuqaP7NGZneFRlLPYBBwE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S4i7jNV5Q43i4xb5Qw4065O2xOFZGYEU6oumDb0acqXL+vdnTSf2LZFtcMKhoeUjLxbH7ErcFJEQbGWKf/YvaLAR8x8+YxjgkEdu5rTpYncK7T5Hgv8kqX7n2eksAGt1jIEA4RDk+TSLNRqymGQgBzq+OfxP7KMbTFQvaWOEOfWwp0G1lq51JXbdr14/0W7Qztxek1M0ZFO+fxlc3I9XpwlAGREkIcatlcegmvtJl6OucHxIYfTW1L54L2OjJ04MHFwKsnezc3BV6PXUr5da8/OvlKiYoDea1YyzqdIjpaJcn7WwXWahMZLRCA2shxyQ5J2bHRPVqYml4uo/oXlDEg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9301.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb24ac0-3d91-4f0f-7b46-08df28687e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 13:55:37.1527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfC2lOQnhPf4aGbN4RtsOf9IUt/2seffCVpbzit2RrMSjINL3JBtpA+cQOzTaoGSIvaCa62CsnG0MzxHfWbNBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Sent: Thursday, September 17, 2026 1:29 PM
> To: Wentao Liang <vulab@iscas.ac.cn>; andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; intel-wired-
> lan@lists.osuosl.org; kalyan.kodamagula@intel.com; kuba@kernel.org; linux=
-
> kernel@vger.kernel.org; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> stable@vger.kernel.org
> Subject: RE: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wentao Liang <vulab@iscas.ac.cn>
> > Sent: Thursday, September 17, 2026 1:11 PM
> > To: andrew+netdev@lunn.ch
> > Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> > davem@davemloft.net; edumazet@google.com; intel-wired-
> > lan@lists.osuosl.org; kalyan.kodamagula@intel.com; kuba@kernel.org;
> > linux-kernel@vger.kernel.org; Swiatkowski, Michal
> > <michal.swiatkowski@intel.com>; netdev@vger.kernel.org;
> > pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> > Wentao Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> > Subject: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
> >
> > ice_get_vf_by_id() takes a reference on the VF, which the caller has
> > to release with ice_put_vf(). The switchdev mode check now happens
> > after the VF is looked up and returns -EOPNOTSUPP without dropping
> > that reference, leaking it.
> >
> > Use the existing out_put_vf label instead.
> >
> > Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > index 7e00e091756d..202224dba1a3 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > @@ -1384,7 +1384,8 @@ int ice_set_vf_trust(struct net_device *netdev,
> > int vf_id, bool trusted)
> >
> >  	if (ice_is_eswitch_mode_switchdev(pf)) {
> >  		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in
> switchdev
> > mode\n");
> > -		return -EOPNOTSUPP;
> > +		ret =3D -EOPNOTSUPP;
> > +		goto out_put_vf;
> >  	}
> >
> >  	ret =3D ice_check_vf_ready_for_cfg(vf);
> > --
> > 2.34.1
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Tested-by: Patryk Holda <patryk.holda@intel.com>=A0


