Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03D3BF662;
	Mon, 20 Jul 2026 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532560; cv=fail; b=jNybjukXKUACHdUDkujutFEnlHKtQczlz7jL4k/VG5CBVMzkTVdySK463l+GZePtCuRrgdYVxvZOXNvHRa4rx1klY86cF1vmCPYLiZFG0WOelKvHHAIZ43XfZKAxWgphN8Y/mBKSSmCKQ5PT280bHFnhohASMfBRT+mCFrYxz+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532560; c=relaxed/simple;
	bh=2XtIIUx1sAi66csW5cXzIuEbXcb7h0tonvNZADfIzd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ckTeAs6ucMTDBpG2a/2j27ldHESJQG4C05zgYL4o899rg0JkuGOc7aUWtrjzeGW+pGKgFlrQpd+sypnnbYMmPcCfEPJ72zUSunQsBnP1w0/xZrTzrYFJPgQNn2R04HPbLVlYHr3Toik7XAH+iRZI6ehxgrLMwuk/Tk69J9PY4i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgbm+eZZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgbm+eZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784532556; x=1816068556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2XtIIUx1sAi66csW5cXzIuEbXcb7h0tonvNZADfIzd4=;
  b=jgbm+eZZV0hMCf2uiZL4VTz4t8xzqTVoFXjCE60QkTWKl+xrXgjx2cK6
   otU1kchJuMqf3VRYx+3Fq3qUbmd7XCR2xhmJZzJiCNyLUJ1i6LjLlcza9
   qPLdV5VgFNbbyst70R0TyoBhpdYwxGFPplJJneHs82DQwHn5I+k86DGxv
   iZMLQUF+QJPDBhFebd+9A7wHIDIZPZU8sAbiBgOPaVcpbJ5JHU/7/VbCm
   MzeNzk2m4o12HE2lyfDj/4vixt8ogF/CLZDb+6dTYkwEAXt6/T11VmNa0
   unNvMChDegwHErb7yjA/fxJypISxg9EC02wHFrKoy2/BlA6MYO7ZrEwFF
   w==;
X-CSE-ConnectionGUID: sfCc1T9pR72KICzbaoVymw==
X-CSE-MsgGUID: bFaHWf7wRWG3RqfHrxEH2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="84230185"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="84230185"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 00:29:14 -0700
X-CSE-ConnectionGUID: uRuETPw0R8imd3XBdn7GBw==
X-CSE-MsgGUID: 5L22DXe9TbuB7eWqbrs5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="255603810"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 00:29:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:29:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 00:29:11 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 00:29:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/AhyN00gxxh7jZj0onUX3VQnx6eRDXN5xSBNHRFTjiEt8pSj/A7nAKpyMZI7Z5W/EJY3xZuzSeEBWhY0OjSKwySg9d6gagGSR7RBN1cBjkkYKoNuR0HqdNKHg/CYl4sR3O9OXfhiTw1EzoAyHeVyvEScPZ11jLot3sE7vlLQ5+bWyZC65dpQBuZ9YKdY27EkToJezAiihXOkhBCP0nn4o6WNUWBBOpp8IZt6kTsXtp6afxDuHU5u66aFtql3AFg+2pd0hlQY0hELE+U76whLaO4LVbxsIzj5FtTFxkDgHEtlS8do1xxoad7vF9YsrP7jqnrzV7iBFrcNLkuRwYSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XtIIUx1sAi66csW5cXzIuEbXcb7h0tonvNZADfIzd4=;
 b=Ruqk+zYtWZ6Y1dTdKqh+gcMAu51YiNSrqTILeyaumBq3hz2wMNUOsZCdWmz4xd7xaUpi2yNE2J094BC1chmTV6OGbg4acy4vc7lrloYgE/kHWfmcvgUBDedOt9rSTl9z+y0EPcZM/lg9pUElKww16tglNAHdVmYPOp2wdbWAHA3IvGd0f9/ILtfrBfa24qtD61QcELE1HkjPyKeYYbeKPa1Ja51IT45xXQd6lSMUff1n8EpudLJHaFrqY+4/d0XyzVkjV1bGlDEt9W1WQ590D/LfoVa+qfuiR/nDhuNK13i75KXFNvBrGocMpCUmj60jVn3Xcu1/qTI/EJ1MSIKP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA3PR11MB8117.namprd11.prod.outlook.com (2603:10b6:806:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 07:29:03 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%3]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 07:29:03 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jianhao.xu@seu.edu.cn"
	<jianhao.xu@seu.edu.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
 ice_lbtest_prepare_rings()
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
 ice_lbtest_prepare_rings()
Thread-Index: AQHc/ampoGnOYQDpAE26y55O+ImGjrZ2Cj2A
Date: Mon, 20 Jul 2026 07:29:03 +0000
Message-ID: <IA1PR11MB62410DB94FEA8C52C6B180DB8BC32@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260616155742.4052021-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260616155742.4052021-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA3PR11MB8117:EE_
x-ms-office365-filtering-correlation-id: 43c36dca-5364-4277-dfb4-08dee6309314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|56012099006|11063799006|10067099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: BwaVxs4owM4dOSm7KU+ubitWYKjyVZqpl75LUI6hzXjoG/2RnV7lQi8XFnQBChBo3stFUwoaf97+Qg4oMt93oEhoQbC6U9ifTGvtMmvTD9DRcVvxnqCPPnyH8W8jwRTGaiobdyYWWXBwWo4GMq0jBo2czw9KAzueR0ik0Ug44BbTXkf+mmRPWPBJfFHBgoySVJl4rJgRGbxETeWCfZd5jGejkCrSRQBJOztD+JDDS21dIlA/8r5BdE+XxpA/KqKWbMgAu6bIg39+CS4x5UjKV5zsJMRO5ropH0zq1c+/XtZL+ab/7qUT2nmQzm1rRMY6ndk9SSX2xUVRbrth4mmKaouKWkIS8Ut6LkDAMs0N+Z/guZ5jmsWCPUX75f+7NvCrUrPBDuEFAtegjQjJfJxuDT2X37nWIEvBJk43UeQM8XoWAEVIq+UVDc609kR2aRYMfy370I1vzn8r4jTmcisj3cxKctbWKb9cX72jUPSfJrzOeAas1WNmQlXaNAMLEdYRkuX+pc2FJ74SUm+d4m3mV6goJUFpYk/sJLDplZElP7pG/xQPZw9zV1pCR5Q1UoKcuL44+YDSEchCKw+/DGYmpDZsYrPni4VInQNWGZdUUhE/U2gD5ESPiVlH2HUjeihfKGT7EOJWGlNH0vOMKUnOvzhq/cDBEFrdRJB01NATo+A9XgQ2hZRbBRNGtL8p4FqjXpLHUxPMVCfEkZprrLPafGY/lq+wnmUVcIx4OBvSFzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzDBxype5TpkOuR8940NxWQUO3k0rnxYV29aquNvFD44qOtZmP7yKIbyFZ26?=
 =?us-ascii?Q?TK0ltZg8dLH/nPtk+tchR2wSH/w058QKgKTVqY+vlP4iYhO5Y+6ZgdAB6YeL?=
 =?us-ascii?Q?jL5go3TRqYHalyLCYjnswP8gs02QEjAr+AZaDjV02iYFTUU36VVpCGe5M4NN?=
 =?us-ascii?Q?QP86Rm/NI7X8o0748dYZ/JYh5Z/ELoZ/Jhdz+EZI0+HQwHcFEYFWT3sEBw3r?=
 =?us-ascii?Q?CitQEFPYMjq8HPaXOmLvLBugl4xuNiyACVTVOFlhRxAgMVJbwU9xr4Pdv0Q6?=
 =?us-ascii?Q?2lG8nD9jOyQt4TQVsCMbqe6shZupK/k3m+5uF4UA9xQS8VC3sxTgE/GHmjEE?=
 =?us-ascii?Q?q+XkH4jHrpOnUgWRsRb+h6y5nYiZJVh7Hce1sj6HMrbyFFwmVdb+Kx/1Whfe?=
 =?us-ascii?Q?eNAsBjlK2jAxO6dpcRBmfOotAbdGkEv+OYSMMxt5kO3T47tiH5fJe3nDu5H5?=
 =?us-ascii?Q?b1kUDoLq8ysNLb6mQPv5e7E+ompbSsHwFbA5OdqgYUbK08TkinvuLBCxjLTR?=
 =?us-ascii?Q?qTmq95KBdW5cH3UsPIQK4QME2lQgM86xnriAjMEhZjHBOxNwOAfjdALGJu6K?=
 =?us-ascii?Q?ciURe8osVJ3n0EGnkCm2+4NGNBhwVI5Om8jy4TMAM+LTIANcDs7012P4xIOv?=
 =?us-ascii?Q?9+TczzImig47rP1E0QONir0UJZaD9YDlWVPRXYdhW8zQC5SDUNdsCFltAudg?=
 =?us-ascii?Q?4JI03zczCxXowhTG4i7NxvYkudhGzQT2Pghv7eAVEfPe+/Zd6GTAeVqxASHd?=
 =?us-ascii?Q?o/w7yysRTg/UAZSk6UuRTGA7mc8e96JOmtp3BxdATQi6KKYLsR8tYBG+zKGT?=
 =?us-ascii?Q?FsebfuPsA0Cq7nxun7P2cHjZRLHTZvD77DnuY6x4CtEdZ3IANyHvpVcM/nVP?=
 =?us-ascii?Q?s4Y8DIXTOJo1WG/3NuHf6N3I2IJuP119VnGVNCl/PDry+tKRYlRMQNOzLZHM?=
 =?us-ascii?Q?qoCGXh1QYUTeykVZXtzZgibn/QUH/nKTLl8dN2kYYV7sJvJYT8FAHsBAmIKC?=
 =?us-ascii?Q?XwcPej/LVhrs2AIhpM8TRbVAHGcKKbEjjhUYzYVhJVHbHMXII9E6cWlrW3J3?=
 =?us-ascii?Q?1xecHhkK8LF8ETs4IDixIf/S9of4OvaXUqvMAjmHujdhP+g0cCzrlkOhXg8v?=
 =?us-ascii?Q?XKzmJbOlNBAXls9ry+6CRTYjziActOb6tqi45hW48fgInbbRS6p/Ra3eiR7v?=
 =?us-ascii?Q?tNcNngBukCfbmAz6eQtfCErtwkZomBIHlh+DBpbHNbhcM459udVu4ZrhhVFb?=
 =?us-ascii?Q?GeDFvaQltO2JxmPWh52/csBFscBWeuD0ZKumIE+yw+hiunUwTmGqYifd78un?=
 =?us-ascii?Q?vXFzsk7gAslDnVMQgMDkfqF9tz10eoqCL+y+0JGC85s4PvJALvCaPHGFu578?=
 =?us-ascii?Q?tzrGyeblzPfFsZD1xwN2Cppd2A0PttMdu+DC3QGnoQiDuwy81B6Bcxy5tB8P?=
 =?us-ascii?Q?2KoHu85fWNYHgNvLuoPt9TDKpjocMGqJbkeUVfvdNE9wbSUomascz7H4XvEJ?=
 =?us-ascii?Q?/bWE4nAM8uBVaxWLA4QBKgKUiopttW6OhlClHULcQfEDVH1xddMglLKlzYLr?=
 =?us-ascii?Q?iQjBTAXkgBL1QNtk1hsPWaZIQrytk5FV8Z6hRt1hoUnsYjBcQcdofrESLA56?=
 =?us-ascii?Q?MEQkR59TUrwatWG6a/6imz/04avQpH3CbPqGqrBpsZdw/Zc/np7Bbl1WkBui?=
 =?us-ascii?Q?v/nvJTWO94wNuu7PMXLZeJkz4q7PH+Do01KK47u3UVBZhbPC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n0FChOHFoBPFYj5veZaWEaJ47DQ9n1P9ZCsSCtaQSRi2DQVEo2NheCp8a2s67ZQbpJ6+ad2gEZDMLmP1t3z3t4Jamk3cOSg9wFp8nWPa27HJN9ZLf5Wi3WBFQTIoF8o4fPLxxkW3rWtzrAO/0LCAz/WEM1hcGbb49hIukENR9zCjt5jOkzK3LTqEvTCAO38w4ktaS4j5nrbZ6yvwwE/Y98CG8vXCCW7HwyvCb2yq5mgNT8RMOwBcgwQVZa9cJ9lpqxmQHCswhvMJtuco5d9iWuL9d7/GlmMr2BZYw22w8tjERQTFYnTpaHT9fA9bkTF5brMSm6Cl0VeSYzZTJ9Fu8g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c36dca-5364-4277-dfb4-08dee6309314
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 07:29:03.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fAd2fr01pU1P7tvCDZWGuMApDBhOM4xBWOpcmLAvAcpSCglVEPswPR9sLDAnn7SdTdyVBKfPzGI34NJs/cPNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8117
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
awei Feng
> Sent: 16 June 2026 21:28
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <andr=
ew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric Dumazet <e=
dumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@=
redhat.com>; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linu=
x-kernel@vger.kernel.org; jianhao.xu@seu.edu.cn; Dawei Feng <dawei.feng@seu=
.edu.cn>; stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in ice_lbt=
est_prepare_rings()
>
> ice_lbtest_prepare_rings() frees Rx rings only when
> ice_vsi_start_all_rx_rings() fails. If ice_vsi_setup_rx_rings() fails aft=
er allocating some descriptors, or if ice_vsi_cfg_lan() fails after the Rx =
rings were prepared, the function reaches the Tx cleanup path without relea=
sing the initialized Rx resources.
>
> Fix this by adding separate unwind paths for Rx setup failure and LAN con=
figuration failure. The Rx setup failure path releases the partially prepar=
ed Rx rings before freeing Tx rings, while later failures first undo the LA=
N Tx configuration and then release the Rx rings in reverse setup order.
>
> The bug was first flagged by an experimental analysis tool we are develop=
ing for kernel memory-management bugs while analyzing v6.13-rc1. The tool i=
s still under development and is not yet publicly available. Manual inspect=
ion confirms that the bug is still present in v7.1-rc7.
>
> An x86_64 allyesconfig build showed no new warnings. As we do not have an=
 Intel E800 Series adapter available to run the ethtool offline loopback se=
lftest, no runtime testing was able to be performed.
>
> Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
> Changes in v2:
> - Fix cleanup order
>
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
