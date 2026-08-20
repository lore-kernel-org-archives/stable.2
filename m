Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFF3AC0EB;
	Thu, 20 Aug 2026 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205205; cv=fail; b=sJBdYWQo3htxmW1PnTOcV1DxxA/fjg6cidoEe1RjLD/OYs1py0dpn9UTQFf1U5BQrfMnKephEMYELnz2gW5tPTHOt/+w8Bxx6lu78JofgSHZnSfsdXALdGtanAnB9tFL9eSEyLWu7xE3eLmgF55YcU0T1FaHgev80Kwl56nuMiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205205; c=relaxed/simple;
	bh=Duezec1hBn3COa4OkNoFMP4KleUQvhtV2LulfOs+KtU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EM0S/wtc7aGAFgtbtjoydkRoATqTMP16HGl+h3BGgIOSpcHCVltfYWPkyFh5zHGTv8Es6Q3lzZkj7qHok/8ECP3ojyBshvHVIjsW1dcWMsWGVVD9nzmWFoZAA+qx2mKQeoXiSjbP2PIQbPf3ScGKhzLSbTzpJji+a7XWbLn49+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcpygIiu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcpygIiu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787205203; x=1818741203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Duezec1hBn3COa4OkNoFMP4KleUQvhtV2LulfOs+KtU=;
  b=AcpygIiuuerbWrknGsyWCaMrBYtjiM5f5B4/F+qZvDWaqLhCXRKJF8iN
   V5bfQkJWqtX8QMKLE9u+vjg6FL5iruaAWYC6ZEw0yiUmGRJj9fo1s/Udd
   kPE3L0Uo7tfGE5mI1Ny3dfA/b4XGQ1sdFWW13NuYsgQTiPf/tc7Y4hVGh
   eQHf9aB+gECbsiTiqlib5xlHW6fnpOHJUNTRs9Ay6yIsesKlml5mHFYDf
   +lhMDapM0llj8z0IbQ0Dys5TBlZoJSu+YSrAVLM4QOU477l5tpkB8I9jL
   ABDpPqTOlxEnNXCISyjbssOJpCiFeyz9KP0YWb653Ret4jgnw1i0iB9pZ
   w==;
X-CSE-ConnectionGUID: sWNxHakdT0+yD35hYiP/aw==
X-CSE-MsgGUID: i4705nt8T8+jm/Pv38T1Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87494668"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87494668"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:53:22 -0700
X-CSE-ConnectionGUID: 6GYq7hn6QGyWA0wgQsCtbA==
X-CSE-MsgGUID: VTN/ElfEQWi+oHggEvebPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="290661187"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 22:53:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:53:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 22:53:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 22:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEiSgYxsKuX5XH0uYxSoVsIVyjUCaRLPy9qq5NfFT0JSTeJ+B9XVkcRX7UCqEybnqtbnFTTvwW36Rjg0vtMmKG6PUXpG58KvFvxJUQ+QPWB+rrAUFwatLhcljFVAGfaXFDq6tsrhmVpI2vqRWe9hHFMRBV7DU1n8OxBD9peGh/7nGUFsFkk7ApKqJT59nMR1MuV3oBmDjxB2gcqiB7cu6F7dbrarsKaWZPTVb5ppg+FZaABmBm1YhBUo7B4yKinCGH1Ef0LLJ7ZC6/bfVb+XFcKYS8dhllLkJwpOk9s+Bjf4tEbmJ380Pguc7xa/jDmGHv0h69EGwjruz1v/qDbRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoTx0RuF9KRSj0i+k8i6ir2vtJlBAaj0KYJP9/s1MWM=;
 b=xVydsWhs5nomguZx+61X3evOGwQ2a0yJctaYJi72Vn/ihtPltWoEhSHIm9kyWdmQ/da2rZlRrfWxXyGvrubeyeQj2SYEJCj5X2m6UkR/WR/rv3D93LgywogC9UaZi1X17AG4vXrLxCCGAH7A7UH/gfiDtEdIVL0029q3sAt1SJM9qD3bkDiSaZ+dKvy9Ehpv+IDEbIKvXDckxVHPQH5/gH/JA/9rGEjU7n34heZ7FZmAooRuLT6422qN/6gwjqeTUlLT1JlbJumQW/N73NllCGW4PLGANGew30KW06kDxEeYkbfdTBS4yfYG4WQLWWHE0LfZUpp+QVBBy5OIBTp3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 05:53:17 +0000
Received: from DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c]) by DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 05:53:16 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Vishal Badole <Vishal.Badole@amd.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Liang, Dan"
	<dan.liang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Topic: [PATCH v2] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Index: AQHdK+lL4U7hBml/e0eNpBkCLwTVnbamdEgA
Date: Thu, 20 Aug 2026 05:53:16 +0000
Message-ID: <DS0PR11MB8018E41AB42E110B167251DD92A42@DS0PR11MB8018.namprd11.prod.outlook.com>
References: <20260814123402.3170161-1-Vishal.Badole@amd.com>
In-Reply-To: <20260814123402.3170161-1-Vishal.Badole@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8018:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: 17629cbd-4870-43df-1266-08defe7f54bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|56012099006|11063799006|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: EuCawsmQtcbOBnb2WmPp7gWAvW24XzFwaWlapG8iGCtRV3dfy1UIZjEuCh7qiGaVpM/o172kQXlAEFcAYKFuOmmT6al3t4WaG9eyRGly7cg8ybTsauU8YWUo0lwRCbCC6Z/JAh1XDYfhJUSMm4Vz9ipn2KBmGJXU8BNBfyXS4tMfjqGeyxqPMNV+qmvkjv5aNXWtu5uM7YVQaDMox1FfTh2DLcZDqKW0KNXTfvnQaxtgVoZYI6LZ7G5uhStjR30u4i2fdmyx/U7CdsSVvTbxBZPo0CbKYkTJpHhi93auxo2sCCe+6FvuJZ0QerMAhZeFSNmT3j4zzRPEOQu9kBSxQe7b+X2hPBByfedcc/0UrgkWVRFybk7l7O6sbpBV74ehTf6O+sIgmRPgWPAA2f3CuBibHg5zklk02YnGa9uhJ0yLZwulHp7GaBY9bIoe6MyJzowSFy+tnsDJcJEjn8TUm58wREjqNWM0uc6lDmcVhmAWWmPRoH9vCvvnUxTWH8IEb9oYuNweFCKCClgPAF5P1iSE0KR/ps1eh96CZYerJL3N8X9a6z9N4zZAztdHA0MoqbQJ356CiIArA+qnURLenPeTTypBpB1sOQkaIRVwi8X5FwaCE/R8WE8UoxjGopidp6GyEXbYEXEJMvqWrtu/phj9Yq6lU+iAp9wdQ+Cmy+k8rpr1G7KFzSLhDE0bZXFaluD2v3tI+6UeESJYlHvleg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vh+UzSYfIvpirQ/P91sHBNI+/3y/ix6X3g7DsaIoMO4se6hLFmM8HjYf5QQk?=
 =?us-ascii?Q?a0tBhhKyzu5rjCx3TeGwexY+533oD200N+093CZJCt2mRCrqRDiFDZTG9ZR0?=
 =?us-ascii?Q?ZA8AV27y13zfEF15GOlR09Zopuhku/8kTMgUIbhLrJc5tVyHzs4BUNuKvT3n?=
 =?us-ascii?Q?bpPvcaiMXd4wb3RtAXJJyNEDcNhleyMekZhX8+VkNGc5j2DQWYqRyl4PGOZr?=
 =?us-ascii?Q?ji328dYr5ZFmBFs9Pk/56WIuu3rec6JrvAzrmuj4Ho+gXJ5zCPWprcrqNgbG?=
 =?us-ascii?Q?gjIewLUz5ptM2YjSnK/K2GQaCqqP0Se/kIPDN9JpXZIQnI2mm1dhNh3gie8s?=
 =?us-ascii?Q?b4uuU4m5euHXB/tDdhxBkYK2OWLdqeUkikw89QygcWjA/ZasDB1tpVSIrZvO?=
 =?us-ascii?Q?ofeD3Vu+F7bh7j5E9WrS8ApAloBy6X4Hf+L0T/+nrglFgafZr/b0pvHnifFx?=
 =?us-ascii?Q?l/Us+M2Tbc7fdbxXWOvnvIUvuPUSJkk2J4EenKtZstXBgXyq3x7ACegvOqD1?=
 =?us-ascii?Q?Ai3tu3FpD1RVHhom+3TfGWvZUA14e2Vd4smh/hZd0jWa0r4OZmA+8lEYvm64?=
 =?us-ascii?Q?+Unoa8xKdH9kkgkGDLsXI4N8+d5esPWKZK02rz6xg2toooXnZJKrw1JKUnk2?=
 =?us-ascii?Q?D4Ega1quA/oZtIzCeyckiWxNNoU34XB/nbQ0tQdLIppXwtCy9EBxBPXF0sYB?=
 =?us-ascii?Q?UCtZ2vCSyFNOcSvrAvOiW4EYQxeQiBLUjQHMduUPHwY2amuqomwXlfVl1223?=
 =?us-ascii?Q?sxQZ4x7ba+TOONa1o80xjMaefyj2eEqbXGm4iEUxPB1jX4BnRNDNbt1BqrtT?=
 =?us-ascii?Q?av+qgiSqI+U/EYXXqbKg6wRm6fIadDDqZic8ei95KaEh2kV3MefuZOqefARc?=
 =?us-ascii?Q?wZGZCdsZ7c27cj1DLjoFDVc+TWYSpCvJPYCdasgiRCMPkhIgCxA+8p3xLJ4u?=
 =?us-ascii?Q?D8YkQU2sCeV5KgCtDkG6KqEiylwDuWKKm35LiX0VbZoDAZtOX8zbMdPnPYry?=
 =?us-ascii?Q?mWwzgLEhKUEn82sF1r4GiR0+TtnAe2LNJm9P0zy4EN66itCK+TXINJj1PpPv?=
 =?us-ascii?Q?D3ofjwKa3xk65VZXGrc51Z+kXCeO6t1Ua9ktrzUL2PXd+jPK4hwpLgq+1BCG?=
 =?us-ascii?Q?Lb9sFdlT9ekHUrbMQlZu2XxIC8zX0L3SsRgiqgJ4f/0lVzvQUuBQGiHFreIH?=
 =?us-ascii?Q?QQG0Lm7qHGGHhJO3qX0Pn9W0FyFy/OHkF7vtHCcC9C7thZ6kUkj56G4IHvi5?=
 =?us-ascii?Q?ry0kV+/UzKbyo7mQBeWIELPHqyoYW3hqbyRnkDIWOcMOa1kfFLGCF1BVUXfu?=
 =?us-ascii?Q?5H1ZTjWp/ga/lsxJbvct/zZhwMSXdkU6t+PgDdO6z9/olrUi405N5nbyCsR8?=
 =?us-ascii?Q?1NfZ+jT43oibKh29qB/5pyndbj4728nuXNNsET8a6zGGAjCo/R/EyYGUg/V1?=
 =?us-ascii?Q?z4jVY0W0gmvByTLRXaZGG/KcwaUaSsPDnWhokV2eCZnzPwRiWz3MRr2m5Q5A?=
 =?us-ascii?Q?Oy61QoNxx3W9Csa3gcmo+/z6ByuTY6TmCj7omp+l8kLyk4lziuroHoyCh6H5?=
 =?us-ascii?Q?TNiOKzLpZ4+78QSO6hASzHTJfEa4casVuzUQqNtS72pkt2K61zru2C0AmPUe?=
 =?us-ascii?Q?mcYyuZqeRvoSkq/apYHrPhRo8oM9gk24BZjmyfcqqkLlDKyh9sjhsMRYIrz0?=
 =?us-ascii?Q?57t7oLdddMtxWnudIzTU0Jx7Fa19awZOHBZhI7u0fEz/3cYJ2mS65rMPy8hN?=
 =?us-ascii?Q?dogelfYoeg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mArE+rmnAtGe84fXlV09mMs0f5hTzrmZ+x1TnIi3Sf1wK+xxZprirhfQinfrC8mOHjtOjlA/pwnJOnmxx3brfBfZbACwe5YBNJ/U3f0pQQEvaABy2Hy0mR69zChckM6QI+dOPkQsismwPNJ5RYIrYwELu8cEUqOcN+6ZIh9sq7H9JRY53gK7/ZRG6bRDg4gAjIZ8mLjJpbFHgTs5pgJJMFc6zdFcXgMxFItbHzOp72xpCFRQDcjsm9onFmV3yQRPwayjw9hUM5LnE+1dV22gNNVXMQzPf02XNLAhU1cTfR6nfWot1J0c8GcWdtet+vNpZPDPB/mfdi5ak4PktQZdUQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17629cbd-4870-43df-1266-08defe7f54bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 05:53:16.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol4gS1SrSPQGowOpplyi8WYrfv7dU3GMT0bQmC8a3aWiUTqfFtpeD8U1snTBlfbrB2rEzrJQdyiwlaLZD+JCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com

> +static void capture_cluster_snapshot(void) {

> +	/* Only capture when all present CPUs are online. */
> +	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask)))
...=20
What if there is an ABA problem, some CPU offline during the snapshot creat=
ion but becomes
online before this check, snapshot may capture the torn data but below chec=
k still pass.

> +	/* Drop it if a CPU changed state mid-copy; never latch a torn view. */
> +	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask))) {
> +		for_each_possible_cpu(cpu)
> +			free_cpumask_var(snapshot[cpu]);
> +		kfree(snapshot);
> +		goto out;
> +	}

What about check snapshot against cpu_present_mask?
