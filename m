Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C123D283
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837917; cv=fail; b=Mpl6mbgOcxm/0NlxeNrBF4XGkja4wDoz0qKLIxi7z4fzcPiEIMfv4KZtM4cBEg2satVmT8TADFX1Hz2hRgPp1pQEN7j22BPSar4N+cy+Q3f9Givck885jY4/0lYaWolUR3iWfaUTcuXU/hUQOQXYMnJg7GnoJCtuk1F92I6y6lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837917; c=relaxed/simple;
	bh=fRTqqFva9mcnU/6IIe0gdQlQSPGy2r0bVgXdy2o8NH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhJicyYTDs26dY3GyRCo8L0uj16duUL7LeQ/XLvkuHpT4IHP3L+D+4VRQphwNIIHxim2et+fotZNjdzteqkXTIInTAnRJ7TWJdA4G1VOFJ5b/SQQzEMl0nlwu/pVI65uuCBMy26AN87bZVx7+gR68beGP0tkCMJri26qSI+bqPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mo9M3CqJ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mo9M3CqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788837915; x=1820373915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fRTqqFva9mcnU/6IIe0gdQlQSPGy2r0bVgXdy2o8NH0=;
  b=mo9M3CqJzsfTrvplnL/5TLYWrkpW1fe1zfztBK2a+x0atYlP3h/k9LYa
   1Y1l+lgz8i7VxNPh6BOc4uIERkoGB5cocZBlLzWjChUSgeBsodEzx+i+b
   sEjSzHP+bnruq1WG6e7SPl8D43eii4DAHL5vlrEzvJ4zKSBbQZrOo3hUi
   L0Qj3AaQJqzoWXcDGRnGYAV1/YeRti7it0ZAvCUb+Q+wnbrRlT7HBR5nq
   /CYKyNIvlD69H4Pj47BbVspAqfH31WVz525ziOxCNB6tZTCmBw8gWM7Id
   VDCOZeAliKe1ujDwaA+mOUcIZGaZf8m8xVKMvMkDK3pev8sy5erwdMgjM
   w==;
X-CSE-ConnectionGUID: 3VvHAdoYTqmeZILO0LF3sQ==
X-CSE-MsgGUID: H+4CexNsSoyorQRd2KZNRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99890981"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99890981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 20:25:14 -0700
X-CSE-ConnectionGUID: Ou5A7IrORsqjayymd/IcTQ==
X-CSE-MsgGUID: GpP1iherR/+OOEbDNppLyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="269133528"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 20:25:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:25:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 20:25:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.4) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aasRZ3b8gVN5B+j6ct/TszFWASXy9tuYI8BsqMhgg26IdZX29jzgewIFzccnq5yYWRDdIAKpo+wf37ChQkgusrf0wPkmXuOf4R+mV/MV8kjN24x7IrQw7gSn8SYOavsGwrOX0qMaTW5g5qILboIMss8orivvUjjqpDg5zU7+hJ01vfevdO076T8c/zSj/zKo0+rUBozLByjCXLBj4whcnVjH3CJtKHcdZ1p3WMH5a3Vm6eKFTWXvh14gFbw7y1vVxXylFC94W0CBLworqQlyD7W7W2xz2qZsNCCnf/hSdzV4iTUF0hZLrJ87m0vZt7U3fh5+EtbgZvSbyaJQruFfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0Nw7HE0OcdwMMwuE6RDJ6syh4wVcwlguBG15BdB55U=;
 b=Vr5sX2TUOXt8bW40HV7QhxyrgtDON+1uFBThBDAq5qI4kyfCT6mN+FPoBnh2e9DTdpuYCSj+Pu6ltyGHMD6Bg9Y6wceURp/iLBXYy4AheFDKZCC79XvN5T2VoAtiT4OEHUo611ReezwjKPSt01QakwhcT0PyZTR0kmn63hwZ5FFAx0Q97bC+L7HSQ6gNz3KmXtetf51qw5K4deFai63Bca+NWwZ8lWtCZBJMyktKOvkE2rCNLduc9ncaaXUOs8v6oPIwidWHwrTC1on0ap0b1L/1m50JHxEHUJXPY1w6WFHmXNQJtKRbwFFPHi1NY2BLaE8XPv1xXPME7y46ANuZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 03:25:04 +0000
Received: from CH3PR11MB7300.namprd11.prod.outlook.com
 ([fe80::c319:6d18:282a:cac8]) by CH3PR11MB7300.namprd11.prod.outlook.com
 ([fe80::c319:6d18:282a:cac8%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:25:04 +0000
From: "Murthy, Arun R" <arun.r.murthy@intel.com>
To: "Deak, Imre" <imre.deak@intel.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a
 disconnected stream
Thread-Topic: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a
 disconnected stream
Thread-Index: AQHdPvCeEbvLqJDdjk2T52ot77VDHbbEBPLA
Date: Tue, 8 Sep 2026 03:25:04 +0000
Message-ID: <CH3PR11MB7300904CF56A4A0DDA801FB4BAB12@CH3PR11MB7300.namprd11.prod.outlook.com>
References: <20260907174413.741851-1-imre.deak@intel.com>
In-Reply-To: <20260907174413.741851-1-imre.deak@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7300:EE_|DM4PR11MB6335:EE_
x-ms-office365-filtering-correlation-id: 10ac8bb7-4764-4a69-698d-08df0d58c644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: BMUEJVUvm5LzZszziM+ToVHwWPr+Xa18fvroFNhjEJIECxxxSUBy3r3GbwW5NrVTdooDgBEY34RsveaXJFERmJ16PGW5k25ea7mnM432N5P7BbSG8QmMMv9B+GDYBh73N86yUFZiyb9gXPaOY0EnY/bjKdNkGBaQ288LpK5kUbk1VIO2aQ7eGvpFEiJq9E+3OERRPSPEhDmuMTZhD2ybWGwvhVWpLYn9HtyQR7Jla0CeGYFuRYdkMPez6eMrU0/aHVtPwK7ZJXwTSUvUwnMf7rUA4RLE+xgU3FoqqUUBAGSm2L0pPJCE1/j4JdeZCruRZ2Lfka2Ohdq/HJhUhFHh8PgQ3tu/Ma98fy7h1quujxGCMzjsoDOqXxYVbeeSZ/+CE8R6o8ZUbQIoAUrKsDDtWKpY/KnkWEfnprg7ch0g6K4bKwpiTwrlcF16CedviGKvImM6fYsRlDOdVOe+e0n6OZ+HA87AuDP1qFW1of//UZ8qtYmRjDTwP/CiNiIyPp6FCqz9LyFwch1LGZOXvx94KuyrAf1uvhXvAGqjhQ8anFvZSpKFs9mEuN1mMzknhCShjSG0HPK5yLwSLUEj5Wmmz6+0QGROJmV77v+qJL3u20ISQHDR9JSaOdheFva1fe8HToPvSIMIJ4Lh13FLpGsK/j7Oo3t3z/DDf/nfo59+Dfo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XgdYEjPmrwt0gQTKvenb9nGigVNCpC/TmRTHnnSsgPM01PyrtT+P6bozvZg?=
 =?us-ascii?Q?zs5I+84WKU21hijCpuMbLzLTWI1/esTHgP2dZfmk8P77FjNwwLwlem+vob4q?=
 =?us-ascii?Q?Qn3EnfvbjMtbvPef7sNK0Rl+CW7Yv6opaKS11asJCkf/0KSpKivoGyMXXjvw?=
 =?us-ascii?Q?7Pxazi4sPfk+d/qDz2GYH2Cjqi+x2Ij9off6moJi7nZXFuTkKxoSH15xNRYd?=
 =?us-ascii?Q?JAjs8Zv49RkixJF5jDn1tPEEzg0gK6FKmUL3u2UlQcHpq/panoC8hu8dHO4m?=
 =?us-ascii?Q?IXNHGUFBN/d5L7UHtNFk9MoC4qWirMqbMp+JbzZDwOB7uLNuj5Kpnwx6JBc9?=
 =?us-ascii?Q?6UH1cYWtmUv4+WU8N3ydziSRo4s4f56lalawV2aonmfnvq9rXMJhMMSNoaeZ?=
 =?us-ascii?Q?tMobilpDc+Zt0kYtVSQ9RajVtGH8UII/62V6NtHxGAIx+kpzohEX9sNhZsd6?=
 =?us-ascii?Q?3oweybome5CwrS804bjSxZJ4k59hvGty1nhWs120I54rsy2UG3l1cJ4F2Hnu?=
 =?us-ascii?Q?K1MqhVJs3bo5gLVPh6oTog6ifWOnLPTWJTgu02ALR5iGAlfvm6e08bPA/Q01?=
 =?us-ascii?Q?EmHUcbw1ziB2vJ7Yi210lvyT3lxauygKy1ov96SQCE3A9XFUtBE3mZMQ+u/k?=
 =?us-ascii?Q?78AWk49yazMT1GWpSadIXzkCzzzKF4aR2THIyUzMHNlbqa+4JogHHDzbdYhI?=
 =?us-ascii?Q?zdhw+aCJM3kqY3ELldgB2hxaVeqmADnmduMG8CGbpxFbxZ9Onb4ODDYEilYK?=
 =?us-ascii?Q?wIkv7Uu0uBsG08wM57QG/KzOpW9kBFkSr5hfWcMJVsghw8VeP0r5BuQPmOjr?=
 =?us-ascii?Q?lyhLqG4yA9fvvR4d8p+GWkva4u4sBf0rJQxkGvwjefr8kMUelRioym4k4ju2?=
 =?us-ascii?Q?dRhCwNTFWRtHUCTdCSAAGQ/cet4EmIcQsnchs5zV2rs4z4/KNgIYVFQVwg3j?=
 =?us-ascii?Q?3aPGPBOtsxglsdHpKJidjUvWHdbbgElq5u/XfE3lHHb0gtsgK+CT67aFLcEQ?=
 =?us-ascii?Q?zEahmMuGam8MaluPV8RFChibMkUlH8Au4Fr/R+pAnXFnxBWa6oSWh2a+RT7S?=
 =?us-ascii?Q?yGqpULNNRqySopbPdhGIv2YOiaCABK4mT5zAbYoj5vsppzr4t87o8lPy90qt?=
 =?us-ascii?Q?29A7Nl621EVfdR0cjoaOYlDjFO3hXxNW+mms5e9V+YvgeroxbIVi29C0izGR?=
 =?us-ascii?Q?m/5IuOMTcw0BdC352+UaaT364pfpRiG9yRJAC89xhaTur5lusN0y5a45pMDt?=
 =?us-ascii?Q?XNQ4d8vgv9ZWa1L/HYtHfBv5wZVzs4jdPcPsynnDQttuwbc2drUDcwvtIjia?=
 =?us-ascii?Q?8PXZNVPcXTzQukF56G3XEOKkL4CmNHr/B5kGzKXra2IzM3D/NejKRLQyhSt+?=
 =?us-ascii?Q?2D0phFMzn/vJOIe8Io4KWQn4/M1MTUdXNoH1yEMZLFl1ZR5+U86F3F4b8Td4?=
 =?us-ascii?Q?ITFtAaK6Fgy7zH6KTSCXADyIAoDgpXUr/aiu+7ADnbNAPZRh8pSbYs3XrMP0?=
 =?us-ascii?Q?B8Xjwc+8g58xl7bDm9FMw5JBxRVGAhWLJ+HNx2Uy2ubYAPcS5B/znh6q85fA?=
 =?us-ascii?Q?O0ZGBWTaMLRLEP6zZgoYJ7i1FEER/yYPc+W70e8VQbwpmzhSHavEPVu0lWDj?=
 =?us-ascii?Q?visXhxEXxkA/fLLFuMTFgrZBEEtL6wr9lVzMj0wi65vOpd3pULlx9t18X48S?=
 =?us-ascii?Q?EhWwyPlyCdtsVnymWrh2E/hIqjrkZDxMqd8ACrZhsTy1Bgn2VWzO/amGKzzc?=
 =?us-ascii?Q?NOk1AmVQZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: etUVyyJVY8N65Ap4lb3XVYvEzZA0qqSl5axxE7rVy03Yq9LFbQuAwZ9Hr0PKs+k+k0pUB9gL3qxQTTY+gzrS6JLnRIOdvqlp79H8CYAsyfOrSDydWXUg7PJMcyjvJD18fTmc6DEMwDxX5he+YC/ET7wvmvHvH5+hVX5qZryV4cbNLT+lIUUPjy/esvYAiMTw9sXnLnFezZTwR5OrDAQW6UlXa0gg5c/JYF6JqjHkDe+uWpPmNcoOEXnZ82A05nDkJdI69/PBQ8zLT2c/uOjyFg/U3DKvSAhz6UTTTO93gGDtnZICPWfUlkamYs/Fx+OtawwBZvzP7sMq9TLpHMPbtg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac8bb7-4764-4a69-698d-08df0d58c644
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 03:25:04.4275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oa1I23n43EBEO/ekGoEURwHJkioHauWzCOqs7CzJVhYWdqkIRrr0NWUpC44JU9MfZ7/u/uQkwuhz0sntRyVhjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com


> -----Original Message-----
> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of Im=
re
> Deak
> Sent: Monday, September 7, 2026 11:14 PM
> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH 1/2] drm/i915/dp_mst: Fix configuring FEC for a disconnec=
ted
> stream
>=20
> During an atomic commit after all the MST stream CRTC state is computed t=
he
> driver ensures that the FEC is configured the same way (enabled or
> disabled) for all the streams on a given MST topology's link.
> drm_dp_mst_port_downstream_of_parent() used to determine if a stream is
> downstream of an MST port will return false if the whole topology is
> disconnected, since in that case it can't verify that the port/ parent_po=
rt passed
> to it is in the given MST topology. This is a problem during the above FE=
C
> configuration check, since
> intel_dp_mst_check_dsc_change()->get_pipes_downstream_of_mst_ports()
> will not return all the stream CRTCs/pipes for the topology as expected.
> Since passing parent_port=3D=3DNULL to get_pipes_downstream_of_mst_port()
> is meant to return all the streams for the given topology (i.e. mst_mgr) =
skip
> checking if an MST port is downstream of a parent port in this case.
>=20
I already have a fix for this posted long back.
https://patchwork.freedesktop.org/series/168570/

Thanks and Regards,
Arun R Murthy
--------------------
> This fixes a problem where the FEC configuration check explained above fa=
iled
> to ensure that all streams' FEC is configured the same way if the topolog=
y was
> disconnected, leading to a FEC state mismatch error.
>=20
> Cc: stable@vger.kernel.org # v6.10+
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 6a869d0f6ffc0..20766b6c0bcfa 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -856,7 +856,8 @@ static u8 get_pipes_downstream_of_mst_port(struct
> intel_atomic_state *state,
>  		if (&connector->mst.dp->mst.mgr !=3D mst_mgr)
>  			continue;
>=20
> -		if (connector->mst.port !=3D parent_port &&
> +		if (parent_port &&
> +		    connector->mst.port !=3D parent_port &&
>  		    !drm_dp_mst_port_downstream_of_parent(mst_mgr,
>  							  connector->mst.port,
>  							  parent_port))
> --
> 2.49.1

