Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898281724;
	Mon, 29 Jun 2026 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782704198; cv=fail; b=UTg1N/5FT8P9AxJ2ITJAEmjKYG/NZ3X93A6G4/jXSC5bd1877fmxWIzkGEo7xyMXdKN8phpLJ9dKCAnDNR6ej5H/48LmRC+FTX+EB5K7pO5gDISbZSP/7aSQVKpQgJWBepEeBCCfuPF3VUMkKOT9stw9j7/duAdmL7v6dAha7YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782704198; c=relaxed/simple;
	bh=ZXd04ym0d/0d/Y4VyuNGyN03U1qiRaKfrzeuyYArlZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMHSSwCuqjKMXqAUKgMJsHnECFStneitLlMqVp6lSz0FZ/0EE1mQIGFbfYggM0oW25KLd/ybFznJCL4dQxZW9ciO7wBXnixJLC3uMLkwvnZQSmoftqfcwg6Jrb2KlshFOMLP+sWGn3LcoSRw60QH4hKbwA4CvAZ7YNe3iHBb/zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGlHmSAe; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGlHmSAe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782704197; x=1814240197;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZXd04ym0d/0d/Y4VyuNGyN03U1qiRaKfrzeuyYArlZk=;
  b=OGlHmSAeJVq1czrG46OolhX3kfLFm9j7drIRD4CHmPwELGzuP9ntacy1
   zFPLst8SZpBsG0/tys4dIeiqjvdGhtlI5pIJ1ZTe2d+Qv+dQyUm8mXIWN
   kj+6uCYoN+waf2S8rfu7yf4Kms5qfxdVoez0xEIdXp8HqYzRx/FFpZPRc
   K/++cWJh5XcK3HkvMVfp4jIIm9pp3xLWNUR/opJifl7Uvn5GIuKW5O8+L
   E0M6I/BzHhHdQZ7vTSFqxRpSsssAH/clLUHhJ2t6+VV28OP0qGp16ZGQc
   aEvF6PQ0sNb5hvkP3dtsgIQkjdoei8elvv39Q8ymu2RgHRsMbR98pADZC
   w==;
X-CSE-ConnectionGUID: +FyKg9JxSMGTTKS23O8pew==
X-CSE-MsgGUID: POjp/X7sQnuKN9ELJtADgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83259029"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="83259029"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 20:36:36 -0700
X-CSE-ConnectionGUID: qhPtmwHFTXmkjvym2/ui6A==
X-CSE-MsgGUID: w001dHB7QEyZEsjie1BIyA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2026 20:36:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 28 Jun 2026 20:36:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 28 Jun 2026 20:36:35 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 28 Jun 2026 20:36:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STNZ37pywkzpdkBVMCGpxJaUUpVnFTGGFW0s8j2SzLaGqMxtOSqH83Pz3vre4iC5fRvF4pNkJ9NrXa3456hMJvWwQVQUUa4VTU1kJzWlXP6UP+qwSrLlA/u3S67BjuL/GW1qZdKEFuLHJjjMrzEg+9tDqR5CWN2hEGSebqtPKcxNZulhniEiKbiTsba5eyfKj3bdmb6om1KMwYmfCqZUn8UV+Z8lc+eqSIDqPJP+zq3FTc8hhegWeMLDbtgOhx2Id2VY+D7pgMTnAHFSBMNVxpjrG2gOgJHmPS1McQHCk/ElwWOlSFLxEkdLEIj0WwQ3igjyjk1TSWqFXvqS2HDL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M9ms/0lI2LMJhEkq71nRZcyo6GmOXABCZofXnilZKo=;
 b=TDd7lG4OotO9Asqmmsy14ARtYNCBPc4y+LZhXzcBMNaxYXJTVcJyD1u6MZIQEeuPvOmkYDboAzFGTpG3XmA2nabWs0Tv+OiRM8slgjH8UJS5WCk4uHfzDfp411Yy6n5jqhjZZa3bmqqEYdIwyaRHp0da6Uz/ylnsRWX7wII1GJY60+fE8J1IMGrLbTwMINRUTAvzAvi0J0ew8/ruHFulQToZssvJkB8SIEKgNTsDBXpJzDklhfDQxEbUoslDrV5LkPA7N51h/VUR1l0c5ErL7D1KKpx8PevyuBTUB7AUwYfsYEc0mVDRKLmwssC1pmUyg0bgE5NiBngWh99f2k7/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by MN6PR11MB8172.namprd11.prod.outlook.com
 (2603:10b6:208:478::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 03:36:28 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 03:36:28 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
CC: "kees@kernel.org" <kees@kernel.org>, "dmitry.baryshkov@oss.qualcomm.com"
	<dmitry.baryshkov@oss.qualcomm.com>, "tomi.valkeinen@ideasonboard.com"
	<tomi.valkeinen@ideasonboard.com>, "mcanal@igalia.com" <mcanal@igalia.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH
	<gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v2] drm/display: fix MST branch device refcount leak on
 DPCD write failure
Thread-Topic: [PATCH v2] drm/display: fix MST branch device refcount leak on
 DPCD write failure
Thread-Index: AQHdBwLWGz/v3it1EUWvCBjRieHIM7ZU4oUA
Date: Mon, 29 Jun 2026 03:36:28 +0000
Message-ID: <DS4PPFE901A304F1C4552363F42E65646B1E3E82@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260628133344.46188-1-vulab@iscas.ac.cn>
In-Reply-To: <20260628133344.46188-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|MN6PR11MB8172:EE_
x-ms-office365-filtering-correlation-id: 09923b16-c2ff-4a58-bccc-08ded58f9aa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: E8pjoFhHt3W7ENu9BrypYeuQ0WDg/0xzALTxzqI19KVsnyrdwqy0L/1goEOTorNQlKlsXmaIYHjDbHWCn/hYENYxT9UzWXk0LJ1KAD8ChxddwQgYSAqMt63mWaag5uamBevhHIqY6Qm4McOmqAc2b/pIfH8J2JkVUxYiw6eIttE/WY2dtd2Jb1nUDOtqdRZEysiz0qln0Y79h9jC3MAPhb9vCfD1zOMfhXP0UOxMh8JVl9+nn/O+Lj7fiQfro75LRRBF3WYFCgGH4d/l8l1H2AAL1n5luu9yZqlGIlZ41TkyteclZ3cy3rwQqkQ4kKbHpll95Wqbqk/0lk0GZugsr9bp7xiWzwobzQEOlv6GXNWnMJX3PqzKpN3Ljv94K04ZYhUnKM16uHtcsBkItPA8GP46OjrASUacYa/grwHIFuaaXeT03g71kN8fDr5mKvMHnZZfmyLutWukS02ZDuSCZpvMLR70lCHK1tUTYqnZpThU5JTznMB6P3Mp4OwYvw+97PSm7jZdAKZIfnkkl17TZsg86WHjk6zGuMX9d91cvjFIXiRWI5qrgeL4YDI/k491JPiwvZOVm5ptij5KxARSWX1YzLmwqc8yjBUrCdDP8+6brTXk1NbtV6Hnt6FbIQakUZE5VX7uspJCN0AqAMtiN8EV9+U4Zp+GNrqoOcRijIdYxc4dKBWyvfW544UTR/KSBrWemCYfxd90esPuJWLCmDOq2DQawhWNVjDrjfCOxxU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xUAG+E+SRDZEgCqR6RkTvv2pN+lSZDhaaPCbO/S0y+wh9aBTqIu0GU5jBVko?=
 =?us-ascii?Q?T4zzkIjHt3xk7H3bo3lOL9qSmQtRV1Y+3VpE4Ntk+dW6iFFiPx3gHGtzYUh/?=
 =?us-ascii?Q?dxt5P4TYfcJXO0op798DX+DVIcM/1ilSSztMPPgmopxYwz+IRViQCg/xVWQc?=
 =?us-ascii?Q?3BnuhQM0aTNFPBGXUPKNQfpl2w1oD26itS7oQkHk+TPzPAG953srRMvNnJLw?=
 =?us-ascii?Q?BMerH7ssW8x0ISh0U8n4Ms2EczXt+WoG+MieXcMFwaGl3JPoFgH8jQ5Yi+YY?=
 =?us-ascii?Q?0ZrIlrbrjdAyQYy/mJigN6yuESrL2ATpW1kVP/hIxBzT0+2F5yIQeu7fwha0?=
 =?us-ascii?Q?ClZnLAc4Yzpk5Nj5vL6HZ5ExPTyZhZmwMpXZCAp0ysZqDPN26DKpy4wxiHWa?=
 =?us-ascii?Q?HmT3gcue1uUuKyqYXBZlaitQrc7Pw4URU1lX6qHQNtp5bTq0gVZDTHqtwtmN?=
 =?us-ascii?Q?oZEJMCtxcTE3MMXPP1HwszZGwmDOtlFpf07XJfBf34h15BDvbgqihxkNmqjA?=
 =?us-ascii?Q?0t1MnDolHRPF/H9zhQmKi5W3Efs3UUkUd9oAfx7GIl1KM2PPiRCIzstrs6+V?=
 =?us-ascii?Q?dmk1jGP8cFY6N0zIJ+8UYE3aIrfMjxM1tsdb1PqJFDTmGzEqJePve11Fgj4e?=
 =?us-ascii?Q?4YSDp4nLBLfgRqCvKvnDxaTyd+PlPjTQ4hPfrK/KfbrbDxVTpyAKGYTzbu3g?=
 =?us-ascii?Q?F9CO7h0s9ukS9i+Vi7dLinvWsOy8r61vOtWVvz0UuuDE38bYoTlm6Hc3Er6k?=
 =?us-ascii?Q?MoYaqgE5q72jf4/7uu/xWjcuLtcvWiANK6KT7wbD0waIiD1ZaW5n+2HoygHH?=
 =?us-ascii?Q?lY117gGwgZ04Elt7nJbftyCm0Q+2kz+wp2IRvWLBcEGX8ryJmv/aXUJt2RZr?=
 =?us-ascii?Q?Ouebl1jG/JoCQCF71Q07HonegjQWlH8B7eFWSG+KXll1Fe/AjF435l75fXzE?=
 =?us-ascii?Q?rdEv/N1xVKQsdMVANIIfM0cU71nUpk9hHXf24MyuocsL+VZS6jY0BAePBtC+?=
 =?us-ascii?Q?SNCJh5UDJUkJq6LcWjPufrO4kBgRv7ooRhJIEcyvPzh9bU9K+/+VgUNRCCiF?=
 =?us-ascii?Q?rObn/zJx9ftHBfQuTCBvSVkb6Mnq2MESkSkUWLV1fTea36uzscI0Pq8RQwuT?=
 =?us-ascii?Q?ratkT5E3YH3Gjpjvj0gWXVKyis7GlxXNpMJuZutGGVe4HLXMGd7j04odrA/m?=
 =?us-ascii?Q?VYLBT+tJBrjvPo8YDOwD/nD6+tLD28ZDq58wkAHhvyxg6Dd6C6kZe2wuQYyw?=
 =?us-ascii?Q?F1mmeK3T/3CWapsgh5XOiTGH5BJhv4fOMscjdPMEYludMndH4PGPFIsUeJef?=
 =?us-ascii?Q?sgDVuBL1pJ76YgGe0QrxmSW2xxVWD0WhzNrSl5g7ERUTyMc1cPlF/6CW9VUv?=
 =?us-ascii?Q?L1lz7+hDfUusspUSSr5HE6IQNiYVPGuYyOyaAcBBqp7y02VklfLvLZajsLI+?=
 =?us-ascii?Q?69uEcH+Ma3XLhIV6BOtzKWS14w9LRiBvB7lQlFssG7CBQ0QORSEq79MlWKYa?=
 =?us-ascii?Q?jAiEOYktoXeQ9JFvFgqQZdbFfjjwUqPuzZQAHCBvjmgD9zEYuMpgs1UZjP4Q?=
 =?us-ascii?Q?3c1Xx144O6JlYo+Pjdxn39Ri+0Z/Ng8M9XOL+s9K+2R5gWohsUanqVb/EYI0?=
 =?us-ascii?Q?pMKM2bHHdo7S0l9+UJsO1fXWJ+ew+1uMYuuFbbAZ0/lVDRwflV7u37sJbUIW?=
 =?us-ascii?Q?eRNfTJzkEo+pu+CaRmzoLK4Exv3ByRRsrTzWUeGaA9L/ID47QIhS4OwsnVvO?=
 =?us-ascii?Q?kXqBUeTP0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PySk3v2O0k/4VAFN4JozpfoSMvYevAHWMTrGnjFNNA5VGbPADXxlUWE7VEJRa594ahP3qlaFaoHiho4MyUnFT3V4gmCFbS+bg/9aOYxDmYYp3WYMRjQqcL5IsOv7vZwlS/3Qcx2jwQ605Zp9RHKsdKNLzz452YdV+Tf1VT+3IlgY6MqigpN9BpK9ZHyNYbiW3K+QBv5QkhhhyhQvuqXOCgrEC4IcGetnBKg9+YNnh1KWAnaO/tULNRVgSKCffFJ6Ue4qKmn5BmRoqXdKnoTr0+Al+Z02Ek4/w+Yo7F/g7U2nWqQiVeVif6iJ4z+oD9G/v6texT6jU3MeyHefC0QjOA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09923b16-c2ff-4a58-bccc-08ded58f9aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 03:36:28.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CddaovVtvC4vWgFmEa33L5hkTUNnZjas2hKsnZPSqPLa3mne9+GZ3+zowUN6dDwwx4ONIIMBYwDuDraau/NipQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8172
X-OriginatorOrg: intel.com

> Subject: [PATCH v2] drm/display: fix MST branch device refcount leak on D=
PCD
> write failure
>=20
> drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
> drm_dp_mst_topology_get_mstb increments it to 2. When
> drm_dp_dpcd_write_byte fails, out_unlock performs only one
> drm_dp_mst_topology_put_mstb, leaving the other reference stored in
> mgr->mst_primary. Since MST was not successfully enabled, no disable
> mgr->path
> will clean it up.
>=20
> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in
> drm_dp_mst_topology_mgr_set_mst()")
> Cc: stable@vger.kernel.org
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> ---
> Changes in v2:
> - Fix patch format based on reviewer feedback
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 8757972e8e24..db9441c80cd5 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3679,8 +3679,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct
> drm_dp_mst_topology_mgr *mgr, bool ms
>  					     DP_MST_EN |
>  					     DP_UP_REQ_EN |
>  					     DP_UPSTREAM_IS_SRC);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mgr->mst_primary =3D NULL;
>  			goto out_unlock;
> +		}
>=20
>  		/* Write reset payload */
>  		drm_dp_dpcd_clear_payload(mgr->aux);
> --
> 2.39.5 (Apple Git-154)

