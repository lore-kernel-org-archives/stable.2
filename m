Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673E416CE5;
	Thu, 23 Jul 2026 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798143; cv=fail; b=YOOD6wF3MhjyEzWhTnXShLlRxHS9cu2wRl2EeO2FIeecHL1Z3DAQJQfVpH9OZuczgkY5jetxc3ksqeSdyJCSG56Op2Eu0qph9uLFNzw4x9Btz8TG4Ftn4OHHOXpwTndTvX4NLGXvM/8I9HKyKSHpOMkXCd7o0Y1MiC+8muOd2Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798143; c=relaxed/simple;
	bh=ZkWBwR9j0LiElHK7MKBb9IsGhKz7gUycGkLCkUBJZZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uidktohWgZN5r/TQ+Jrcxf83erEb+pMHG/jPKwlHwikiivU41buCA7oXl40qG3ocRT2pNXpMcJwbx0jT1dwWu0BJxoDH8sWRA0rzGQLr9x3QM7nPpk4KZw7Ckh1eqj1tpnND1uDsCfFQxayjR7RNtQtq89/zSIvFrPIXIeba4HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iueMQi8W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iueMQi8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798141; x=1816334141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZkWBwR9j0LiElHK7MKBb9IsGhKz7gUycGkLCkUBJZZc=;
  b=iueMQi8WgGygolQyIfXFTI5s3HsbaQiiCvUqmxPbFJlD5L/eLeDgrXj9
   YVb7mKPvt6hU9xDF3S2SKQZQkZwKNIXvBKkeIfXCqKZIamvDhrCwoBwlu
   5hcPnLzf4co0UJStEOcrZk4qtwv3GelbshlhcxSLq3OhHQ/8xNvAlfDa6
   3PB04H2LYTkriKqF32vQvlaqO5RWiMSWOofBiDc79jk/TIIB+uvu8nZRC
   4Wg9/VSBPzFMZvOn2yxjl8cDOCnKtZmAexcMpIdGd+jov6hdw5hY6Yg3V
   VBRN3EiSK4CMq4bY8NusVU+JVFZZ3u/ERPIIvjj0Dnxoct9fINFOlR6Os
   Q==;
X-CSE-ConnectionGUID: ZQtDxOJuT6+8F7xLtLWQLA==
X-CSE-MsgGUID: o/0V00xVT/Kz12j3DJqfwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96963397"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96963397"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:15:37 -0700
X-CSE-ConnectionGUID: jRkrRpSFRx6A/IBJoMQPAA==
X-CSE-MsgGUID: 1QI0FOl7TPixjgwxrL5aoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="263325369"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:15:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:15:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:15:35 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.33)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:15:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de8u6SSeKeYQv4OJBJZN7hZkkPeV0Lul8Wk/H7yRROyo4GeGLpIyhuP1GZOvnwod85MFYE0t+wnmecSpQIiRKc6fWqZpkyQ4Mx1AfAs+C8Iv4GH7ZWC081ZswXhrn+jcSJCj1hsv5tO6Oy9vM90TpsI9d76ZnCOsAA+zYbP/43LjHyjcY4kXZEA8nFROcLooe3ALqVflD7B0QLp6qpaphy184Q7gEPDS5DNfU8iuX6/uPhe4t2jxBbc6AO2mUPi8VvBzYrfz7P0sMuVpqWjb+/KJSOxsgsmpPnevdZLlaUmSiy/Wt4GBFvY6M9a6dXZRW2dohhAEQPesE6wNsaKOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BH6rJlasZaIf0pY9FKHcGh35sYGLi4B2quqoyVU6Is=;
 b=RQdyG/8qrznl4uyy4vbROmYMdnsN5bib0zQKQ/oGymo3a0/Y8CJ+h+GEcN3mJgJmTlBid5LCCvlBUN76XgTtCF76zkJcPoIsCUr/dNqNLNMP1dyivWgQI4oP1fDglg6+l3FFJYvVsFnK+tWH5sGAw9EPRL6K4tlgk+CeN2UyP/fRReprOHXUUEck0Bh5DVttHCiP98r55Ho6VuGVHcmw4yNyWVRRayXEujmMObeNLF8QEuHJ2Q2wn6TOgQYQfGDyWL6nj781K1SIFCxSNntKmgpIKkm4/tRuIHFcp1dnnZxnWxdWCya9pOWoONC11/oPxk18MkHyN4cLmbitUFFqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:15:27 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:15:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "tj@kernel.org"
	<tj@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
 items before device removal
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
 items before device removal
Thread-Index: AQHdGPzjuMMsL7rm2EyjeVwPzIIi9LZ61Yug
Date: Thu, 23 Jul 2026 09:15:27 +0000
Message-ID: <IA3PR11MB8986FB1EAD0AD7D9EAD17F9FE5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: b5717b97-611d-40da-952a-08dee89aef5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YHxxK3tWsGoFn8c1EDAhcNm9Mpqn+qTI3TX1mMDgmpTeyM8QD9WoCb8uyuWz2kDu+an2oV8WvmfubmrzJiVbC2CRozCLLhRIY+s7BChwO66RhYVDQyqLuRtzlS/b7YkbP19qGcALSpKWkdLGLqH8mHJOUUsbuBiF0RadEKL4PN5Is708VrjZSXVjnQxo4UIZT8vISl1s3Il6a5pXgj7VGNLO1j07wkA0JoNhibeOIx8lC11J8XBOZdqdAFpmtBE47ogEfHTEH5MKMrf4iL2nd2hm2/qkJTSyGtgEH+djNRe19SPhj2MijaBWZNgzLJXVL2hQxABtTf0jR2qvMv00aT/fqekrMmNXbc1O9cvD9UaXFhnnYH0I8abtpaajPQic+ej89xfZY/bx6gLTFG5AvY50ry7jeY5IkuBj/dhwmCh0/zoyp/KBlI4e3t6YoHvU+CWqi/PTFJKvLGRJszPsc7bPzF0j/XLetW9FSSSu2Y2T3FraUxpvhT5wOHQKL/nqWYJPWbkbuHQXvuQ/wwwHgVNMghGB/86bZ26trelTFDvbXFrUxbYaZOiR/HIH/gTGhk6MmiVi8IJxxh9XLchduBpum1fZm2mHaGFsbqqisQ1kSykqvBTcNqGaornjRCE6uOEnRwjy8mmqDntr0wgZ3CvBGNbOHUQ39nSZH0eqdzaA4qToXC02sUkKiXg9n/qSOtYDVp1q/+1U1rCXx1J8vTf6EbEdnbqIl1+Txurf5fc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?acKrZ6dqVG5H9FbBbK5QWuQc7f5rR1lBRBIap5OqfSEnubqyM5b6ap3DrZDU?=
 =?us-ascii?Q?6SBCsBBvzEGp/UH42ULA9vegosrzSOWmWxtwKUiHu1zuu8WhYBxfet+lcdsd?=
 =?us-ascii?Q?S65Ela4e0uuY08F6Xof9K7WQzYhB0qsedghSrlyJP5jx2KNm0yvf0CMi1fOn?=
 =?us-ascii?Q?zBNn7rSXQKACPhlUtwY+zp/NC+/C6kQLfpAdqkGwz3P4d85z4oIOZ+4puZKX?=
 =?us-ascii?Q?8TYGVJOraz+7XP4mFsP8tD7Ws+OnIn6ZeacBNcU5d4wT9zIBmApKbf28MYcV?=
 =?us-ascii?Q?vq/jKzIum7034NJbzom2UxAtP2P9PkkHBl0AyNNibGkAOnkD9waoWLA/JazX?=
 =?us-ascii?Q?fbuQPW4VTtmrM5gBxF+ED07tPWknWmLzjSt9mgl4mC1hpcLj90PnY8LiGcDw?=
 =?us-ascii?Q?zCkOAdxo8YahXTdWcFB4YickxBz79pad2QGoL/Q2y6RkfBLOjmHS3Y314UEo?=
 =?us-ascii?Q?qYQQDTIw6OUv1ZE5qtto36j7t2c2jd6hPxlpaLp3lEflYjPpDawxtWcUAzmA?=
 =?us-ascii?Q?T8QfQ1eoqx+iAOUqEcohmYMsMpJnM8eqpIElQ4WirEWzfGbg/qpIwN4ESzig?=
 =?us-ascii?Q?9sVxr19temUJj1wr4xmQaDh4/uPpGHExnt7lYn9zzAz+NkDRqclf1VdgyhSs?=
 =?us-ascii?Q?wWG8bx8YW7zC+BJ1rvWiOfdLcYEltveYisbMAcmfddA/c5RlDG9vapjOpD+K?=
 =?us-ascii?Q?zqJOVvoz1gQvV16Z/yDtnhVuF+ZpSjKCBCJa0Ju19ELiNTM+adZzU0HE2gco?=
 =?us-ascii?Q?9p6rHYC5o1S2JqBEiFY+mcxyq/cnuDh9dWEuTXvG6KgiibaZTIPzTuhUEya6?=
 =?us-ascii?Q?W+99hP8+Tqm2UmaSe3nYMyTvlKHl7HHDjFVNmrkSz+2mRNAMZtaHRM6wIUXO?=
 =?us-ascii?Q?2F80hHRTg4q1f2dr2gyYo8Kn/9IFyC6F0hcqQfxlEt9V55UVHTcZ3Xmc20RK?=
 =?us-ascii?Q?sVHGGAUV01kpOpqXPUBh40Gmo7h7hr76eWn2hX7j5jf13NOWIEGYHDe55sXp?=
 =?us-ascii?Q?tiMGdNJUgvtSvI0Lc+HGNLZwAhtZTrKdb3xG0Ptox7lvNg1oCo23jNd/IDvk?=
 =?us-ascii?Q?zfoEsaw5GeJVcAyXFyFut8Hgu+gn0BCpGMYoSPySLrfwwDeDLQy3+5Ey3dph?=
 =?us-ascii?Q?YnI1+wGy2WxGXEeIOD1Ofb7KatfUYoi4GTUbLQiPExUONQDlJleIwQ7ZJr4l?=
 =?us-ascii?Q?abM5qZ212gDoRYjl7wUcSqHsltSVVlH8W8AH4lb/2VnxgeN8CwbZltpL4jYz?=
 =?us-ascii?Q?bDZbOX9jmaWIYQEcC+St4uirz5nIfSpAkbV8AVLN2/8e7uUKZ/Bf+Lcvj1te?=
 =?us-ascii?Q?olyHTp17+z5ueZCfRfkZhvRNNM0kP071809ybA5LPn/llUShK0kK5OuGsRFs?=
 =?us-ascii?Q?nplDR2e5B9Fa3aSvTAsZVPGaMNe+SgtYcRZYhvhckQQgUSybGqpKYkN34guU?=
 =?us-ascii?Q?4PdDriN40VZUaS2V6kgPEknQKIkH05CSYUXHDDIwlgJ4hI2BZCQR6hMxop79?=
 =?us-ascii?Q?1bLRa+cUiyO6DhAkE1B86hMl7MeBnH1NPUQdU28HAtQtTcHqc4B7I4Qr9M2Z?=
 =?us-ascii?Q?BgENznGulaWCUiUAIFHl/fpVgPwC0YmY9XKIfvnjKkKgkcuY5JCzb3VLNsnL?=
 =?us-ascii?Q?BVyIRczR6l7lC+juW2AIw4qjPJdBFVPvEe33Zkk3AzvMYRa7klox3EtW2Fjp?=
 =?us-ascii?Q?FBE0dgUKoWkVkD0sHmdzwX0XTXJ+Z+qqgJhv58sSFxzHU6piC8HLmQItt8N2?=
 =?us-ascii?Q?0YLO7JcSLIo8wj8icr6f3s4nBuDa2WU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FurneZcQmHjZPI+3R77bAZ0Efy9Y6LDRcMa9oS3MkraC5oYjSUX3UJmULwt98PGRfvZA0CwdB4uRfhK4XbMySDwwjc6Z267ReuBnE90X7DAJ72iJOrE/f3YmloCwx0Df7KcxnMtB8oNcuOZMV6MDlzWblfmYhVL9idXPzbnljkJbQWbrEPOJNcd/m6CsWaTYsRloSkW/WG4SFZYZAqCl9JJpF6TCFst38BPfPBpstzjL+PilLZxBwwsZXdI3t5C5BVS7tFNz6mB11srDRhpjrSPv2SqYuhRbyIbA08QvGSfeGPaz+94t0ezLD2irP64Tcamil+6YtnTWYQKgjbYJNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5717b97-611d-40da-952a-08dee89aef5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:15:27.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0lf4BbDfSERpqObjzr8SDPvqzSAbOvfQVRjBxp/Zkaoj/KOiWwQIAr2N61tRyCT4BlLCpi2pVbCu7uZbfysi7Eahokb3/Yj/ukkGdbKwAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of xuanqiang.luo@linux.dev
> Sent: Tuesday, July 21, 2026 12:36 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; tj@kernel.org; netdev@vger.kernel.org; Xuanqiang
> Luo <luoxuanqiang@kylinos.cn>; stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
> items before device removal
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> A watchdog work item that is already running can queue the reset work
> after the remove path has canceled it. The netdev Tx timeout handler
> can also queue the reset work until unregister_netdev() shuts the
> interface down.
> In igb, device reset interrupts provide another enqueue path. The
> reset work may then run after free_netdev(), resulting in access to
> the freed adapter memory.
>=20
> Although igb_reset_task() checks __IGB_DOWN, checking the bit already
> dereferences the adapter and therefore cannot protect its lifetime.
>=20
> Disable the watchdog work first and the reset work second in both
> drivers.
> Disabling the work items also prevents racing attempts to queue them
> during device removal.
>=20
> Fixes: 760141a53e5d ("igb[v],ixgbe: don't use flush_scheduled_work()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
> drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index a1e89a375744c..5ffc0ad318914 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3887,8 +3887,8 @@ static void igb_remove(struct pci_dev *pdev)
>  	timer_delete_sync(&adapter->watchdog_timer);
>  	timer_delete_sync(&adapter->phy_info_timer);
>=20
> -	cancel_work_sync(&adapter->reset_task);
> -	cancel_work_sync(&adapter->watchdog_task);
> +	disable_work_sync(&adapter->watchdog_task);
> +	disable_work_sync(&adapter->reset_task);
>=20
>  #ifdef CONFIG_IGB_DCA
>  	if (adapter->flags & IGB_FLAG_DCA_ENABLED) { diff --git
> a/drivers/net/ethernet/intel/igbvf/netdev.c
> b/drivers/net/ethernet/intel/igbvf/netdev.c
> index ec308a5f5302a..c5ae15fcdca75 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -2906,8 +2906,8 @@ static void igbvf_remove(struct pci_dev *pdev)
>  	set_bit(__IGBVF_DOWN, &adapter->state);
>  	timer_delete_sync(&adapter->watchdog_timer);
>=20
> -	cancel_work_sync(&adapter->reset_task);
> -	cancel_work_sync(&adapter->watchdog_task);
> +	disable_work_sync(&adapter->watchdog_task);
> +	disable_work_sync(&adapter->reset_task);
>=20
>  	unregister_netdev(netdev);
>=20
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

