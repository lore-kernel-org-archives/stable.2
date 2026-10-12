Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C546D0A9;
	Mon, 12 Oct 2026 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795846; cv=fail; b=ExLpNF1LmGrzODsW7CT1DOtoPbkGqIgWP5gA0at2lG2O5O15WI7M5QTKUNcJGqTkdBq5Ns10Qy1P1ZyrgLcjHCj3xqwn+cuuNEkYLv85hmDlIfNm4SOSF+mSth+jIhYQ3Lzqd6bzQiNZRTV3iK7aSj/qamoeDtB8QYJMX764F8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795846; c=relaxed/simple;
	bh=1xuSubFPfJHsj6inIbGJ+el4XG2iNKkjWvyxm2PShxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eMBD+aIvBK6L8nQXUA9dlMmXaj+tV1mDbWSUCfGu8DVa/B0gCgN+9KejRy/Agf9CnpVxOGZC2O2jhU5zKyPQMG+55AW/IYinADc9erRpNHGSZiPX71FwaWHa9Ky1oUUwmc/JxmLSOSPhWcYsIUYZ5oLbWk4Hu1czG3zi7DMVMsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MT4tbQsz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MT4tbQsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791795844; x=1823331844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1xuSubFPfJHsj6inIbGJ+el4XG2iNKkjWvyxm2PShxA=;
  b=MT4tbQszvz0Mt9Xbra3zCY72MT5I3+geUZJrXpWhQasl6ICCZ/a2ck+V
   8xQUGeXjA96NvaTyf3Gc/BNr90iGHhTMz1l8oBS8Jow4iCHQAnted2XT7
   bJkBtDg3x6up2QucIsHQQ5+QpfVTY8x0CvW1ZAxUTFqBEbIIuB/9yWyL4
   Ctxfx7mb1OA3NOKQ8MrTLzdE37wyag0sLe7qOCa+EXWZiYHBDcaWBpjZC
   jRx55VcvkUqEAA5rbu0UhQaJjqdXWU8Tlc7HeT9TGLHu9EgiYJ3aw7DMe
   saQZPKtloeX87orEA1iR7i28g1BhGIkyP6ftv9D3GdPp8jhDL4BfMyQp+
   g==;
X-CSE-ConnectionGUID: XiqKpR6KSDOlgVYcV3clBg==
X-CSE-MsgGUID: rfCvExAzQMynkzyfPFoFQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="386205"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="386205"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:04:04 -0700
X-CSE-ConnectionGUID: fiPxTo+gRLCtbTcwTmOO+g==
X-CSE-MsgGUID: Gu2G3/YASHS3532LEqT0pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="2682753"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:04:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:04:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 02:04:02 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 02:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY8xl4YpWj8fqiRPMafQacvNpt54lUyblnzj7NmavVt8r4QixxWLhxzVHsKSe63b0s9HKi65EXuwkE6Ud/8nXClENu137/xp2m8GPs2LSDqsWyd58ClbgXp9Vx051dcdYDDAePlsZbbYjFAAHRKjIEutB9+Gj0MPnQucvTB09PNPZ/TNafbjQZLMQM5VKcDIQXFkeOOkKL6RJ9Iu+U+ChdrOOZehdzQeGuDwtGYlxU0yPQ01nYZK8pOQAA3xP3WjsJgo0RP3LJgPvTENqJ2LlFT/ybnyVss+kNDrwIkAAKH5WZ0eGrx9gmnk7YSp6UgKCDy4IJkkkGA+GrMcK8qrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL57RewRwNhufsIfcolTiOHJJ451wDjbV/sCD5GpM0c=;
 b=TQw1oiCBCiRlLgpd34VO7GdNSpFj2bd7ql6JUZ+OqFUiA9HZWfWTPXMJvyzqM2xUn6sCuOTFHkU5LYbImtvaGKe1NAHFau6ADDOht1wmpuNRUCyp1jhgVbE2NowXX6zrGsM8sGIolkMUqME0E2tnHSzGrEYfYla115E3iGS8YODFG+C+yMjsvGAVZmryInzpBlsqmZohUMa1+YS04WhQ72QfxnjYJap6pVXzxWdq2rbMz+aYXvsznHLCqJ2GdniAUnNpLuH+R5Gnjz9g7Jp7oNaNFB1uQtTpNqYpnnIyLr02GoFm5ZtMdEQUVLgiHCCEpe4ys09mvj/2687faF29Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:04:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:04:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
 start fails
Thread-Topic: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
 start fails
Thread-Index: AQHdVyTNW1J8Cz+ULkq3k2M5MzvNVbb5orUw
Date: Mon, 12 Oct 2026 09:04:00 +0000
Message-ID: <IA3PR11MB8986209E6FF5BFDF54A54044E59F2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-4-xiaolinkui@126.com>
In-Reply-To: <20261008125754.3520773-4-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|PH8PR11MB6802:EE_
x-ms-office365-filtering-correlation-id: 7eb6ad6d-5730-4063-0692-08df283fc14a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|921020|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: uwQKXM3jnLFMGyQa78KjD6prqjCByU9UuM0ULcAkIPcRhW5Vj646kMtJQIqF0RVJppX2eTO1T8P/oHnSqpi7oBHvxYMQHwGWCLWCT5kfd9pGNMFiH8BLizo2TLf9q/krUa5D0IlT10ukNOpL+nwiYAH+2ezYRroP/fKnfOlnGgB2mmYyC7bRK8KNXfRYaNk1DwMdWMMWzCnoe4aNMpf4O+EWdO688ATKrJEuu2wQVj1g+67LzMNoQkrrmlPrE2cbyujBBW8iwmMel7KI+unxKIH6nZX//XR5Z6my1X6MN+nkJbn0fE42GQ4OxySwdiqslP8bFn8vUax00A4scljy3+XpJQXZDFoEHPyrVzj4DLmUWFjhlfTA1VWNHAkS5+FkWJ3mnqM9rskN5ILqfKl6M0oTj0FcQtOcB5M+8REigWzKFwdOgKl69B78TxvWVE4jqmjHryHPF9Ocq9F7xq7827T+Pu9yGUL0tlLcqlQV0FoljZW9LKOF+CzWFQBQgyEq54dxI2JyTtzmSQl2pkvEf2Vvk3rMmyXFppb95LzwJSeYNEBMEX48cxsN7xVDey65BwVHMVnRJ9ql3gsL5StvofbiHTDNeXptb3AG9+y3aFLaqGDaLbovk9VDcBRIFgE2nIIzW5qwZ4W5rAKTtiR+FOkXsSfoFtgnRf5R+k1MGAaKj7h6t4II6weQI0Vjoa06mAlpdjV7qHDE5aelssctlhGkuGdtIMQ/6EsZ0pxAURFXFqML41oZuxzRkKFj8bj3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(921020)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9atQPsydqhuU9N8v+bI76RkPj9wCLhyR/qXTj3WTLWJu4eAbnOeR/3bAw7O8?=
 =?us-ascii?Q?NkVw7ZDduOVaFU8kX8v1eVs1EQo8v9xfJw5kFcg1wDsLJzzXnDnJLqj9wJTx?=
 =?us-ascii?Q?ohHJdRo70zeF9wIOBxOsSumSvzQkVCw3sWgoWe8Fl7S9uu/iST0zjl9GqOTw?=
 =?us-ascii?Q?MS7dKclSOiU/nnxMb4beaBKm/hZgX3VU5aH1MUfqaMPzJWC4/fC2P3pKlIFK?=
 =?us-ascii?Q?b83Ua0EMvggLYVLI97YcWo7tqVjMyEHHLSUgTKOPgF+gDpWPl1TEGIsOOTvH?=
 =?us-ascii?Q?dNvHn19/mslL2zwTZCtdVocdF9uEplwW1N9is21KexDwQ5jO6/icYxKv3CKR?=
 =?us-ascii?Q?klDvtADYVnDEqaSHLBdVz9MRcA4N0sfZzqdhqmzGYdFI3wy51mJsSv542MyX?=
 =?us-ascii?Q?0zlHADhFkVH7MAu/mv/4NcaVBga0U1CY4w8vMe38PVEA7b7Q5f7CCS/HGBmD?=
 =?us-ascii?Q?osGipdEbPZ6W8G/jB+UiOyd89vl0r9Y4L1+l2jmjFW/dMShqGjuElA+bdcVR?=
 =?us-ascii?Q?QSdz0X81yw5gOE4x7b3L/Li+Xlxuo1YTG1UzCd2GgShhhYRDfjtZWu2UO8/2?=
 =?us-ascii?Q?/Cx/1choSpK7PvrrvSxO/8yKMNYJtAervH/mqYWbQBbACGX0fZOUtmRFwXTM?=
 =?us-ascii?Q?vB7pRT2ZS0Qk3wWWFbK/zJsFtATUxjfPVY79UYyWhlBRe2+e6NoRjRYhXrs2?=
 =?us-ascii?Q?oOCZGlfS5utVhGF/0AwMQm5w43C/1dc/NWCjuI0NLKbcFH7hifjUM/KPSyL8?=
 =?us-ascii?Q?ZGqbNj7ZWyBV/NZJRgJObM7TkM9yzdQLB6wQ4szdIT0zq7AyFuTHKkhoN5pb?=
 =?us-ascii?Q?jkbskACYnkDDh8noh+RLW/j/K0fkWDEjXWQa+KMDrjdat7krIDkk2BhrKc59?=
 =?us-ascii?Q?QMF1kZ4KsqawqDP96WZei5MoGmbY+XOUM7grQ0zBONDOuyZxXC0FhyKaGHcX?=
 =?us-ascii?Q?UMBjPIxaVpBw9nP1mrjOaX4y6BHgorF+AmyMrhwmykbacg5jq7WkDa4RhWqB?=
 =?us-ascii?Q?kFKTQJs4JxAOIhejVSaBBOzc59160b20ZMMHOqpBTOHv6RZ98pif6aO4uaRW?=
 =?us-ascii?Q?JUQhcJH98qybvCobqjAyk+DFXzulMYPOod57Ap91/ekemdY4/D5F9mMfbxGf?=
 =?us-ascii?Q?GOIOdLM+NDdihsE9iNn7yvNvHAGtVfbrxuSIOpiWwnDDiMchdNta8uC8NqnL?=
 =?us-ascii?Q?A7TqnT2dFgt+M34nWNyn/TonQmJJi0zssCn3yIDXIyznZpXBt7lClvfye4MM?=
 =?us-ascii?Q?AnMP5lcTr5E/VYWYYEU7Gu3UwJ3jYbYWVUmy0PTqEfqRkE2bRYNQ63Z5LEiV?=
 =?us-ascii?Q?8pnD39juTpOShI03Vqz6VaIIMRP3mUvr40vgN8e0XZPtybW28IZDQeVyBoKS?=
 =?us-ascii?Q?tqfY9A9LeXHmEsGQ4qpmWRzBrMRVfKwmrbhG9cdbgB63ShhLH6jClF/34ryW?=
 =?us-ascii?Q?PBkCaOODskQ1yOCCDXWlZsIKktD+a7AVMdknjyc+tTAcxdJYv75dH7yjgk5J?=
 =?us-ascii?Q?C9Tfl+0zuOzEDLGYMIw7q8Xx8R1xAuQewlNIxYuRDLwUmeZyblZCPmBaPdzH?=
 =?us-ascii?Q?whxd9zGDrdSvKgqo9nmG9sUNVWj1Qa0wUSkPBVXFWw2qvdjGU5HarUekwkdO?=
 =?us-ascii?Q?YTI9vmBpoktzTxEaZn+yafvgB6cSq4R9Ynq5F2rsGNNYJS8nYX7r14c9943M?=
 =?us-ascii?Q?zy955eXV76w/Y10vQiMv9YHgXHY0etPEQBMFCK06VP/4tbGs6dkc+VAltT/J?=
 =?us-ascii?Q?hRp/lRSmVzeSsFCtomY8iqHCm1oZpbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AnsENh817gajb5i9mOTqh2rL8GlNKfSMiqzQmywud0LTvQzCaKtP0QU6BhsRGbXmKN8nHRO5UtRZOO/tJ92fN7k7OlZSjUQ9yEHicQn8DhovE9Do20cTynmWY4faqLU9+QgSiew2bMs3Am5t6Ijb72pwVO+XZQZfCHX33NwEtWuswzVjPoww+YmzdTi7bW5cpmBg7GvC03cbI0+1VScKmyS0WL5mJIoAa5LYf/OR9+4JzFOxy45+ZuFFfOU1tc4aRC7tyiMaGtao6TxzS35kYD/9BlNAlf0spKiNQaDe4GlaRYyMoNtSLy0GrSkkcf8XL/VzXX19hPf9yC21yZD4Qg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb6ad6d-5730-4063-0692-08df283fc14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 09:04:00.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBRwENdwCNl/g5PuAp2xVJ3W9PTqK3gnPEskBO13TG1wv8xOTC+v20vcgv0W2etCJn0G9InFo50J3iHcM+xrjZ2XqBM0T6x+yXiHEVHrbL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Thursday, October 8, 2026 2:58 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH iwl-net v3 3/3] ice: free the VF MSI-X vectors when VF
> start fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_init_vf_vsi_res() reserves vf->num_msix vectors out of
> pf->virt_irq_tracker with ice_virt_get_irqs() as its very first step,
> but neither of the two error paths below it gives them back. A NULL from
> ice_vf_vsi_setup() returns -ENOMEM straight away, and the release_vsi
> label only releases the VSI.
>=20
> ice_start_vfs() leaks the same vectors. Its teardown loop undoes the
> queue mappings and the VF VSI of the VFs it already started, and the
> eswitch attach failure path releases the VSI of the VF it is working on,
> but neither calls ice_virt_free_irqs(). The caller then runs
> ice_free_vf_entries(), which drops the last reference on every VF, so
> nothing further down the error path can release the reservation either.
>=20
> The tracker bitmap is only freed in ice_deinit_virt_irq_tracker(), so
> the leaked vectors stay reserved for the whole lifetime of the driver
> instance. Every failed "echo N > sriov_numvfs" permanently shrinks the
> pool that ice_set_per_vf_res() divides up, and after enough retries
> ice_virt_get_irqs() fails with -ENOENT for good even though the hardware
> vectors are idle. ice_dis_vf_mappings() meanwhile re-points
> GLINT_VECT2FUNC of exactly those vectors back at the PF while the bitmap
> still books them to the VF.
>=20
> Release the vectors on all three paths, the way ice_free_vfs() does for
> a VF that is torn down normally.
>=20
> Found by code inspection of the VF setup and teardown error paths. It
> was not triggered and no stack trace or error message was observed.
> Compile-tested only, not run on hardware.
>=20
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v3:
> - Correct the Fixes: tag. The leak starts at 4d38cb44bd32, which
> replaced the
>   computed first vector index with a reservation from the bitmap and
> left the
>   error paths below it unchanged; a203163274a4 only renamed that helper
> and
>   moved the tracker, so it is not the commit that introduced the leak.
> - Include how the issue was found, that it has not been triggered, and
> that the
>   change is compile tested only, as netdev-bot asked for.
> - Free the IRQs before the VSI is released on the eswitch attach failure
>   path, as Tomasz asked for, and keep the teardown loop in that same
> order.
>   The teardown loop hunk now sits inside vf->cfg_lock instead of next to
>   the detach, so the Reviewed-by tags from Tomasz Lichwala and Aleksandr
>   Loktionov are not carried over.
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 470aec8849b6..444d05a9bcb0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -458,8 +458,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  		return -ENOMEM;
>=20
>  	vsi =3D ice_vf_vsi_setup(vf);
> -	if (!vsi)
> -		return -ENOMEM;
> +	if (!vsi) {
> +		err =3D -ENOMEM;
> +		goto free_irqs;
> +	}
>=20
>  	err =3D ice_vf_init_host_cfg(vf, vsi);
>  	if (err)
> @@ -469,6 +471,8 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>=20
>  release_vsi:
>  	ice_vf_vsi_release(vf);
> +free_irqs:
> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
>  	return err;
>  }
>=20
> @@ -501,6 +505,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>  			if (retval) {
>  				dev_err(ice_pf_to_dev(pf), "Failed to attach
> VF %d to eswitch, error %d",
>  					vf->vf_id, retval);
> +				ice_virt_free_irqs(pf, vf->first_vector_idx,
> +						   vf->num_msix);
>  				ice_vf_vsi_release(vf);
>  				goto teardown;
>  			}
> @@ -537,6 +543,7 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		ice_eswitch_detach_vf(pf, vf);
>=20
>  		mutex_lock(&vf->cfg_lock);
> +		ice_virt_free_irqs(pf, vf->first_vector_idx, vf-
> >num_msix);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
>  		mutex_unlock(&vf->cfg_lock);
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
