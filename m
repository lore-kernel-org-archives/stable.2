Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5B3E2769;
	Mon, 12 Oct 2026 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846956; cv=fail; b=WwWwxwOJ6TJuxpzW2IvEqoGmT97WyANJdWv81gXwCPb/dC/mflZ711cxmVJpucZBU503pRBLioJaHvhLoWIKAvnnxBD3EyS4/x1Plsg+JjIKYwQfObtK7R9cvPaUu2kpGH1xd5eREYrHEM+J7wtVf7HUTX8OINsxtxUFbkyMQMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846956; c=relaxed/simple;
	bh=7m+Ym/vVFXFxrzzrqAGwNRGYV/9ELW+/9UGbMgGKwdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ovHCm65gYB4PSNEMvLa2VPOzAlTCW/TFim56Gr2ZJlEIznlVTKD2EKqObBPnAyr68plJ3b66BEIuMwSegM7Vas8eLEpeACVeRAJ/MAEPVQtNCcLXF5ytUKMCyj+ObXNJ0dLOtcqycQ18TQBTuX5QL6sBpLwtsj2sFrJ4fWMKAFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAey7F7i; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAey7F7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791846955; x=1823382955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7m+Ym/vVFXFxrzzrqAGwNRGYV/9ELW+/9UGbMgGKwdw=;
  b=VAey7F7i4KIIyC2N9wdbpcTax/ouOf3aVK8UnD36Z/4UPHyI3lzVtY1+
   KkdceRnxZ4w6bVu8QNQPyHd1Pwx0Ns9GZwpeouDbJRZfJ4XkloNt4Sy4u
   EmjmR8UNMgODCtUelPvXCOA1Nzi7ExEwQZS6p5buV3RpdY5mbygs2Cb6g
   hNXqgafyUjxuV2LDbrG6fpUqIPV1EIfAzd5P3tyLnvnFzGoLndBjEr4qN
   AWJHRjY7KswFO9LD+vyZSDXbs4rkseq2zFsNcddqQQ/MspKjMso9Psye/
   zxZHJaRzwSwYOr7+6fwBvIVxkXAdFk8XRc8WCiUldV24s3XU1ZSIKlhSo
   w==;
X-CSE-ConnectionGUID: KUzimdB3RCeLgs/DXbav2A==
X-CSE-MsgGUID: 7DafungJRj2LjjC8+a4Qaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="450050"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="450050"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 16:15:54 -0700
X-CSE-ConnectionGUID: LbOv3pTtSMico0lrKKobmA==
X-CSE-MsgGUID: WYZb5GpZTpqYT218169TGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="943210"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 16:15:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:15:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 16:15:53 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4UYTnElsKbQHXi6I7FgZrX5IVGW/Tn9unZACmEANA+DyUHCYxpscRli84Zb8ut798iYWUn1dQD23ZegzkZMubDEXIymDHyy2Q6+FSRPXMLoxKTU3AtdeY5UOu9EITC/P8MYNNj976HS3vXQUEAiFzu4+jc/YZTlpvfSgPPXS6skRWebXIW3bMxVUBTsBoGR1jGXd4BWDNSrNHMZ0Arrj3QWxrXm06yPPIbZt6EedNC3CQK35XhnG5x4A79PTiWuSunFQGba9W6mnuw6LUomg52eGtan7I3vAZvcZTRO2EXIbqQY5e1M9XWBEa8/v4Q6CVRskgkhq08WmrfIin8C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gqjdIWvChMhpZJOHnGZcEG01trJhGGsSj5yNLa4mIs=;
 b=uAi368mG8Y0td82qMf9GW/9LG9GV+Gf7+pUp6vQ+5nbWe/5zGIpf+vhwBvJPHhsq+xrMtGQ40PRhTtfpQRMBXcVaQetM7rqv5bsajdz8EkcISWMMJaE17zjSlB5aXKRpctOjt786rcTaf5kf+RNNI1QHAxoxBCJC0lXi4XYcoBJJHEChvreydyJSlmFsRX4J0OKd5ivOR+bJYz4TAKfo7rGXz1A5vSCHsnLtM6h0wgC9nZGpyM7s9pk7xuEdOlsixIYBP73kf0PNkARrKyx1WORJ/4dEqoWjG41LSZ9iuDibtWNS/jlcejET7u0xGszUQ7MqHeyYMG6rfn0fsLrV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 23:15:51 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 23:15:50 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "sln@onemain.com"
	<sln@onemain.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Thread-Topic: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
Thread-Index: AQHdRpWmphSp3qsJhUm1TU3el/MzWbb6sNrw
Date: Mon, 12 Oct 2026 23:15:50 +0000
Message-ID: <LV1PR11MB87907F8F98770A06457ED31D909F2@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260917111317.2148568-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111317.2148568-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH7PR11MB6771:EE_
x-ms-office365-filtering-correlation-id: 83a6da43-119e-4708-4c93-08df28b6c199
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|23010399003|11063799006|38070700021|56012099006|18002099003|22082099003|261009223027099003|10067099003;
x-microsoft-antispam-message-info: MEcgky8/Fl2HBQ0lwrAFrKQb+BQziXlZSL1f/CxamJ5A1qKEzRvt7I3QNTakWdGvuVwIQKVUV5EdgrLa0tBNEHu5oSJRyEW8wcsMeBU/T+koHRpcBphI5uYT/f0+6xE+UOB14eXAM3YeeWgtl3UwekzYEDwlclBsfJ+b91cFgsJYeh4A4deyQfVj6o1Uu16i563TW8M0a+Z3l9l8GQ9eRA7BgfFI8QpPf1mjXCcsGEjEVU5pbrAMIwj6d8BmafpkPzdWWuwh18dJJCSJVIEVwiC7uaf58Eg4pPAKLrYSvqoehjLiF7cCu2spBz/L9DIe1y7naUBx2KxLc07WdNi/8KTnegcNOnmNA7IYpo/r8Zhs196c1GOjJkDWlpOGvmVKaPJ8TQeDj22FEiL4wo11JUnYwxv5D9F+jFnR2fbn8Pk67b/AlaEtbfDq3hJUCIZhR3E7LzmumOq9yvC1q64bM4sHcuUaOt7AMxrhxvh8zUNWuQZjPIkgOwGf5oe0UhaL9FLZ6EiuG5PTBUocAwr6JVNOVhg8hgsMwsPnlFDEbp0hGddsPpbRSQhCLKOJbGxWBqwj+1Tu1ga9i9SEP+9aauB5peSKGmWL5UMiBkQqx7r0SgxrRrjRqBgWKBddxBiic3d4Z2rb44iDJrEwDlJyEXZE7+USXecHJTyFMFCBEGiuN527YQ83PIeMz1v8CWMMwjHibKlUYi2KrSXZPe6J/pEK9/O+VEDGnQlyBGA22GM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ACjwkVdiqRFqGe7IbYYbvtuem9u7EXkGwPlcq/B+PQGICqHTLNf+DdadUobG?=
 =?us-ascii?Q?E6vYGpmkcreni6xq8Km0RTc4kui7enR+trF0qAYcuPcHt66WOIu3HwXm2qKD?=
 =?us-ascii?Q?Jsd5ZQfcyBegUhIZQwdaEb4tb2pSw9PMkj0u3ZvMfy6ofq9lFi+z+kp+9Dra?=
 =?us-ascii?Q?wg1pqeq5g2S2M9wgqHPYJV5lPzlbtnCAKf2IYxstBKlDLmeTDXk8JHToc6tC?=
 =?us-ascii?Q?8wuDqPZ1YHgX+Uo5bV9JBvd3vo+HaTEzV0IdjY1frszGTdYY9D8rBEyHr1J0?=
 =?us-ascii?Q?/USQNI3ufqeDzoGEMYXi3ctkJt+5gvUJnOIlykB430dd2P0tu3y6CZBgBePh?=
 =?us-ascii?Q?pTApGmxgu23cU6DRkkxeEQYQ1NJhf6lX10zDdpmVhJLDQxdTuO0PxD1XbKSw?=
 =?us-ascii?Q?O3Nnx7VY8ATvosPzsu3xoYkw76NUHRlOmaNKjUmTLVWl+5tvim2kIku/y38c?=
 =?us-ascii?Q?9FPIq3eLISL0HD1FQRx7OABXPZJlPSa7Go2a2zarmP9yaEIoQ1JnHSXBodQN?=
 =?us-ascii?Q?8KaWPXNmGGIiuP9Hl1JKtDv/mGE62ugSH6uPmKFdBw/SuC9C+X8pAfT97b+L?=
 =?us-ascii?Q?t1UUoii9IFjVbm3jvvOOQweL82+hkGN6Mx0f3C4+zsInsQG7elprjZ8F3sC6?=
 =?us-ascii?Q?6uFC/iMxM3FBg/x/irgtIOZUU7wuX11AzHFAwSmh915xFSb8jXNRNj2DUlU7?=
 =?us-ascii?Q?jrRPbsCrIEMrdcMEEy/l81SnOPFMGahxs5a+QsfSn4fyNjeVfCrrQ03a5Iq7?=
 =?us-ascii?Q?NdUzzF5N5xhqnCxd/Z+Eq6OBbdspsb/TBmOYM8iG4SvslGqGjdaC8TLZR91C?=
 =?us-ascii?Q?lcFrs8mYMBmcrSViKepLOVv4Z29m1tOTVdUkM/h5Klaku4PSsh4Kz4XKgbpE?=
 =?us-ascii?Q?uhSot1FhTIdEQh5T1Ip6C23UQtgeU147I8ID6cr3jt0qFfFnGnXZ9OSlU9nq?=
 =?us-ascii?Q?0Tb7JwOkW5NcHjVF0aPQ4MDF22XY8TAUiNwhOH2+zFRHB8tgG5TQ63VUdt60?=
 =?us-ascii?Q?U4HZDI/zyP51YDkcTOkIwi385d/1WPh/H8EavCqGh9yHNdpd1hYaqL2kLw4P?=
 =?us-ascii?Q?SGlVAE1cZWzTDdWbKV2vfYej2BciuS98i4UmVb9ufSy//ldO/IJDOwp8/X4x?=
 =?us-ascii?Q?dxYSRACQcTVNDMErOlE0gTIX9uprHOmq+rkwESqy4o9ZqsIOiG4nqlCiCC2i?=
 =?us-ascii?Q?hC45J/6hesMXujSQmM9vubids2i/6OaChLQFVF4S7uml225/ThnMJPfjp3ty?=
 =?us-ascii?Q?3+2Gx2rsNWpPu9UgaBy3O09++daQRCx/POkZEgwgLF8rK8WcHtrcWu6YmPCb?=
 =?us-ascii?Q?dwyBmEh0PpRMEy1cC//mQRNok7y/YIq032Jv5XPqa21ggivk/FXi89VGYdEu?=
 =?us-ascii?Q?yZM419CF2KJJoiAu4UkJl2wnaWElp2E1EuFBDmmiZO3oN1kIyF30LI92gsvm?=
 =?us-ascii?Q?hVGEJOUOiJCnKdK5XvV/jxoWfGXbdj/rKl6KMC2LRtEHkPN6I03sgYD8u1M4?=
 =?us-ascii?Q?LTDUGGaJnjRLl6blsox8B2hv+X2gzSDYZYMy52lrm8PC/leIp4MLDPxg6wyw?=
 =?us-ascii?Q?ixsSkDRRNGS5+VcGAtsfiMjD51yRN/cr7acACdmHENNS/Hg3F7lC7pcRj7Qs?=
 =?us-ascii?Q?NtYUqf1lmlKrbXG97PoMQIv13mBR3SqTG1hN3f/mxWuxHC8kIr6u5O4Nsur/?=
 =?us-ascii?Q?Z2VIL28/8EdApVijgDIyQHdnYqK89D/jrQcArPxCCQUHkewu+2JBKFHd0s/a?=
 =?us-ascii?Q?kFf9d/wT9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uDRNgPsq979UGzaj9aCDd43FJYlsIJgSYb7djmi0TVOT5ANwDYyxa7rMbeQ+Fzui55KunhLjN4mg89Bn8z0mu/vyF5/izcE728fnuMVdzpWX4RlIlMEG+YYygwyCNXmPDIRy+H15VjdX02mVDnvwPN3iUm6BecIfbCXxZq7VCUXl8B7lMyYZLxbimUinZfrQrzVVMkGnwjgWnm0gPpqKEW+dVbpwjVmKWq4Zz0Olxxb1Sdk7DjeKNmpsPE+K9irNgaE1E+sCGpq8EKl0xU4/tRnKPQwjOiVpWsGGWg9nwq5zRn5ueSE6dEYL6BC4UXrF2XOE0riVLTgrt8i67wNGqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a6da43-119e-4708-4c93-08df28b6c199
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 23:15:50.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nld+zSKqH7E2VfGGPmw5PZ3omItBTfPVOdBcaMnTm3xMMWeXgbnHKAoiutKnbesFLEbHR0kqAFl7seLhEPGwQrv/e62Vt5sCMr2R48H63qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6771
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>=20
> Sent: Thursday, September 17, 2026 4:13 AM
> To: andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; davem@davemloft.net; =
edumazet@google.com; intel-wired-lan@lists.osuosl.org; kuba@kernel.org; lin=
ux-kernel@vger.kernel.org; netdev@vger.kernel.org; pabeni@redhat.com; Kitsz=
el, Przemyslaw <przemyslaw.kitszel@intel.com>; sln@onemain.com; Wentao Lian=
g <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] ixgbe: fix xfrm_state reference leak in ixgbe_ipsec_rx()
>=20
> ixgbe_ipsec_find_rx_state() returns the state with an extra reference, wh=
ich is handed over to the secpath on the success path. When
> secpath_set() fails, the state has not been stored anywhere yet and the r=
eference is dropped on the floor.
>=20
> Release it before returning.
>=20
> Fixes: 92103199f10a3 ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
