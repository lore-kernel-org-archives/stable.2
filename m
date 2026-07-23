Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B560B41930C;
	Thu, 23 Jul 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798346; cv=fail; b=NEGvCoP4MKaL36vJYTKPEaru6eEzzhAk0OUczvZyzJCfUo+CnfaAAwDKfWx86Mr0JQAtJZr8YZorpBNpk/LeyAo/7K1fOkAxrJPZG+KNW3+qQ72W1sqAtOybkquPUFQXD0pjCm+tOpGco0+ULyghH2B5oNWsgjqKwS3X0Iyi6tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798346; c=relaxed/simple;
	bh=PMnamTQgDQa12PMv75u9npfAo3+qnke2lmCl5UD94DA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FC94NJ2T7HmsQixofQVtlf6RHoqdVutLeH65Q2lmmMI3cqTtLdyzWjCMkdi4ZgTV5XLp9R9cLZ+VHLmWBwGMCbRgwDdZRZ6ZaDprwL3TnF1EDmR7NalBzSjvHkLn/FCotJM9Ti3xaDpAczG48mIFELZKID7V+2tRkP0OXh73Cu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PycvB0BB; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PycvB0BB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798341; x=1816334341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PMnamTQgDQa12PMv75u9npfAo3+qnke2lmCl5UD94DA=;
  b=PycvB0BBn2YxMoNfoMUHhDkKDk/sGOBBn9AoW+0WaHEgsrR0uraUhOpY
   YFOpn5z74VzQLC7Hk3ShwlVncg3qYnBKgiCAGMiLplPIpQ7a6civscqEp
   QF4G6CebUqum0LPm3I9EghK8hlm5NEvUXi0jtfMEEMo15uxWZXNOJgX/M
   09svUYBQi64EmkcpCGX/ewiAigMalRkl5RTdbasBJOQPcJNdDzfEiUPwV
   JS3tGoS7ngHU//MrWwpr6kGCnAgwq0adFmJkqXcT/hRdKKaaQDi2PGT4B
   kxAXzTyCOXA6Ly+4PRc5j1OINNYJ/aOKFCQjIPWXZEKfaEX1f9JNtfhtq
   g==;
X-CSE-ConnectionGUID: RDjoubIbTEqzwpIdANBNDQ==
X-CSE-MsgGUID: o33G4B7oRZWGXsCpnPLG8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96963882"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96963882"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:18:58 -0700
X-CSE-ConnectionGUID: dDkfv1vFSaakxR0piNVjOw==
X-CSE-MsgGUID: 7fJDGTYXRa2CPomv6NkXnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="263326584"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:18:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:18:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:18:57 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xj2UBIm6vulieD/zXXndLiIzROsIG3PFSV7ZEprLISHDFZGk3/EnYSNhFVMLfQs2k8ogeDBSAiSeWBuZpqLQ8yEnztUx8EXxjm1RofadS51OSKDFco4mcp1UpD3Dh2hIno9Avgmo3yR+KlcJ34/7WVkVAh9GrpCcrlOOlV88VaT+ffSI/Le759gE2+Xoa/NHsjBAeOox7J3fYqMwyCVKUd4/AxskAhXBUxNj061q03TIgRJjqW5mXXKYfrvrY0YqCIgeQRLyUf3NWVAAmHRcMwKb2mPe+B6MYQQDcUQgycKquuwdK9EPhnchb0NlJmq3IXqyGgapK+WK8PvAIJVMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfhedul19UdoLLHPY0jCaxTuGO3DPtL1AMjmf8stYDM=;
 b=I1qRSvUWOdkEHekoP6w6v/2Z/UgdoKU8xgKspX4aJ4iCUe+FVXyHKGOj+yGK3Q/VHpg50dQFURcY1V1JsOH+ss+/zF+q/esEkAIeNQpYoFVxnOrRzZGZROnEWQ8UYFIom4GwzpmwXAGhKyq9ClrcWXQhSdxbUqzVaSiFFRACgtI3+ZJJT38q3tE7CYN85VbQqwqB3jirssGrS5hBN9FCMimHQDFdPf62LukiENdomyyAJURQSkri369i6PdZijuaaLo6kiy8jKc8moVrOs3UajC/5plTTcFHxJoVLqMCynb2C505QKesvfUds0bp5lh7gCHUig2gs3wS+wLP4ahklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA1PR11MB9633.namprd11.prod.outlook.com (2603:10b6:806:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:18:50 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:18:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Philipp David <pd-lkml@3b.pm>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached after
 resume if interface is down
Thread-Topic: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached after
 resume if interface is down
Thread-Index: AQHdFf9cU8EawxtZsEauVsUMZulIsLZ63H4Q
Date: Thu, 23 Jul 2026 09:18:50 +0000
Message-ID: <IA3PR11MB8986D164F76EFE059EF2EA23E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260717092159.35496-2-pd-lkml@3b.pm>
In-Reply-To: <20260717092159.35496-2-pd-lkml@3b.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA1PR11MB9633:EE_
x-ms-office365-filtering-correlation-id: 4e2236cb-784c-47ff-b18e-08dee89b68af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: CgIU3NQuW7icQL6RIy39n66w4uIa++YkD1c1VedDr5irUXOK1cbo47k+jUYHAF0khN569kSluiD/8+WnWufbHLeBGAE0UCr87pkcf4QNozQczt0I66IvfXM2GgDEbIden8wGEYlyU7zcdhmJNqkYPxsphH5GBAHNxDil5B6GTu7TE5VTfFFGMAHW4eD4mVaF7YiMu7z/KJkSXkZesHdmofAaT1nPrKpMlKuYCQWxAaHUO9Qc3H4IqYrMzIdWjT3unYDCpBP2rB6sq/WHdLXPWRDWCbckeM204A4ZcBhx/RsuTqZ/uPNIzOOAQiTC+QN34yH64UmQ3jyWWM4xU954L2KJzULbPyGfYt4QOuDOwIO6wz98dfVQIYNiOkRVWYvznwpztsMz0tXpmmEgyffww0NSS06ZfTqcSzjVtPfJ7/E/cyjJC/TGEXDHLo7gprGBQTOeCke3MxbR5fu/2ry2CwrZ4mkGdP1gaBfRvR24hyrg2a8UusPNKY5Tmxfjqqfh6Xh3cZtlLwbuYMAKQG4MUy90VzZwYS41A709rGZbQAIu/SLn63RlSEOaez3Mxu393vlrvlUmesp9OMV593D2iY9GbRX4BthGXVsocYxGUwmYjjjppedLFIk7vh3fu1Snh+3H9TmzO2mDhMZIpWsjlXQehZLVxrquvmnYlgC0WFXd8qEqa0WYI7og8s07ieZ+dAP75jA1xxytPZ22MKXNN/P94RndPTO5hahwT7rX5QA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J/VilK61YEcM9oJeX69wClk6u3qtciNSapkwcft08aCqLOTCkVgbXjDlfQHt?=
 =?us-ascii?Q?qTpmXFWIiMvyBveHEiZxLXrIYoOKrjFmXSIqsRiabBhmyqy/QcinOUfDpPNU?=
 =?us-ascii?Q?n9LdYk0t5wIainpBWm7LWlqV62EPddN3+4cuf6UhOdPHPYte8ThMeFpORsUg?=
 =?us-ascii?Q?bsYu2Si/MxsmyCqDNz8Brjb3bDVCZUkDaM0TuCtPCFMwZYCswYzzH+VQfPM8?=
 =?us-ascii?Q?AoJPelykS5G0k2tvTh+ZP/WYHLRvS6mYYaP8OdaI4hgbjgpFWI5C9saWjZSz?=
 =?us-ascii?Q?hvdVkpTyr6m7tmvCEcofpu1JKbFUSUPAb0+WZFlR18bZ9FbTBXV6jfGOmOHL?=
 =?us-ascii?Q?UzMp8U+AKo1iiOFNVTKUg9uosLgdXv9qkYrB9a0M0uWYJsC6WMVwLZhZ2xd1?=
 =?us-ascii?Q?dvs1B6zMQ1Zykvwy4Ltg5CIuv/LhXwxUCD7/AKflpTt6BqLMDmZB68YUelJN?=
 =?us-ascii?Q?KjmxVtGNglA851VxxwGv/Cy3iy/BKmL74mHviAN4ksdVwBU7F76GvqGVLGqE?=
 =?us-ascii?Q?5U8Ofj0iZLrFZfyNOtk9AN9gv4g35loisyVA0MaOj9TiQCfZQ9vEW07ySbeE?=
 =?us-ascii?Q?rhBo/rzQ/ftIMa4WZQN2dgrzLl1reHVPdYZ/RHWQFXu+aDrEbiZrBT7MjSi8?=
 =?us-ascii?Q?DPTyUGru3uITqmpcGGmvM4LgDUlQSvvxEphtYtm3AgDhuF2443XKbzIW/Fgg?=
 =?us-ascii?Q?XuQ5rviW0+edeY2Bn09sxqFjQOE1aMtmW6mxx1GjoIRJJbRz8EcSF8F32ri2?=
 =?us-ascii?Q?cthKSnseUMu6bMfojV7KtedVDM4Ig2fWu6JPq50bKtuMKPrQdCmUyzgORiN8?=
 =?us-ascii?Q?xrRqp2GWaqYx53NcV+pOUxhOfOps5Y7gJkeDq01W/I6EKt5UrPsJcOND5Y1B?=
 =?us-ascii?Q?vWsklukEiNV/TuFcNnAhavzzED33cnCplzlchckbBpP3RxYRx/SRmqlvGq5/?=
 =?us-ascii?Q?K6QleRD9eIIH8ZrbLSJ+0QQJTUWLL4TdoHDvkzxDD4u7E2JIpWfuo/82hU2w?=
 =?us-ascii?Q?6sZ/42dXmU3+2+R5+2qIGHMbrDgXEsQbLEykLW33wNN2rz1dLeoFXYgc+Kvr?=
 =?us-ascii?Q?Jdr4J6ZZifa1KNUHv4njlbHlzwYQpugsHm5NjvU86Gu5mztYlYOWsU01Vo3h?=
 =?us-ascii?Q?/miBygek0p7LrvdZJZ7ImUz7UT5TBQczPulyWUzyTAztNUcDjKNqm4co0yG3?=
 =?us-ascii?Q?nQjpNWshDtm2wGub7DqfCggvmOd2T6tx9WjP4t4qucKKLNb3KN40m1s3RJxG?=
 =?us-ascii?Q?+ScCJBS+CzjcccoV4LD5QHXzu0ZLDMTXIwu5Uk91SB+AcHe9zWJDJylUH7wu?=
 =?us-ascii?Q?fTq8OufFLZ0LahdjQMfgMfaDRWmWI0vlYwEY6377gSBzbNHkmj20he+TgXTE?=
 =?us-ascii?Q?T5yrTxunxWGMUtwAmNIczNFObC5qWWri8lwxvLL1t8JG+tlR1ODsZZ2j7rst?=
 =?us-ascii?Q?H4mY+WqukbkCGn94to9TIfxxYnaieeBjnGimIvx2WimY9E9cn/8VEimgavsi?=
 =?us-ascii?Q?KhmuMWX+c7BrOee4uqpIxXtnMWXxL3yRXAabKcJBt4og0asOZgSHTpLfU9jF?=
 =?us-ascii?Q?qMhAdzjaiNBwyzcuL11QJ3JpCOauKAEiBnBxnWQYw6CWdDydXBJPltl3bCTV?=
 =?us-ascii?Q?KDbram++LSManPNGhJx0up443aItJT20PAVpOzAB3x6cvuJlyoJxWN+M/ebG?=
 =?us-ascii?Q?DL4W4YUKTwoDjuMbwQKo79OVcXE8h0K8VxO/sTkEfPaXuvn0dlhwEo+jHfgR?=
 =?us-ascii?Q?uvn1WmUjV/1c99JXF9yKKDc/EaF9HQI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m7N4kh9GFvokONLOgSO0Pinq1qxhScbI9rEBI9kFpo+0vHAsdMNCKgCrbA3lfKkLTuCs9aSM6aYR8MUCdVr/z/8Hax6l/NU6K3kge5Xd9Yi9TBuDEck4dgziNcX28v41lp1k3uxwMdYf9bOwdZyFEFgFsy9GMBb+Z+FXIC+a5xN7n5iVNMdk+6e833xXZI2OSnesbwHOIium+xBronjd8U2juGOoL18MQfrxpfhlv30YSlf35aKXoEbz3tKjRXxhBqo5j1WYu6IH8/HPlMT9hZO/ybLXfDFx0gTAgRRSyJQD0Sn1pJzViU79fN/UFMuyEWeAB/Q8CT8YM2YO5lFdTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2236cb-784c-47ff-b18e-08dee89b68af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:18:50.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXtxy7SD1QXZ9nmtrNcCWcPNAd3zIUl0d8v47YYUDv8Xuwl/oyHXMnjm8T04m/xOYJpTH4ondxvmb8GAExjp1vDdpGSiNJkd4HS0scGNo5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9633
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Philipp David via Intel-wired-lan
> Sent: Friday, July 17, 2026 11:22 AM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Philipp David <pd-lkml@3b.pm>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached
> after resume if interface is down
>=20
> __igc_resume() calls netif_device_attach() only inside the
> netif_running() branch, so an interface that was down during suspend
> is never re-attached on resume. It then stays in the not-present state
> that __igc_shutdown() set via netif_device_detach(): ethtool reports
> ENODEV and every attempt to bring the interface up fails the
> netif_device_present() check in __dev_open() with -ENODEV, silently,
> since __igc_resume() returns 0. Only reloading the driver recovers the
> device.
>=20
> This is easy to hit in practice because NetworkManager brings managed
> interfaces down before sleep unless Wake-on-LAN is configured, making
> the adapter unusable after every suspend/resume cycle with WoL
> disabled.
>=20
> Re-attach the netdev on every successful resume, as igb and e1000e do.
>=20
> Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Philipp David <pd-lkml@3b.pm>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2c9e2dfd8499..e777c2df0b73 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7586,11 +7586,13 @@ static int __igc_resume(struct device *dev,
> bool rpm)
>  		err =3D __igc_open(netdev, true);
>  		if (!rpm)
>  			rtnl_unlock();
> -		if (!err)
> -			netif_device_attach(netdev);
> +		if (err)
> +			return err;
>  	}
>=20
> -	return err;
> +	netif_device_attach(netdev);
> +
> +	return 0;
>  }
>=20
>  static int igc_resume(struct device *dev)
> --
> 2.54.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
