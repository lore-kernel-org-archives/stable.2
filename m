Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3586334;
	Mon, 13 Jul 2026 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923060; cv=fail; b=kqNFvKmOpGCA8kBlxiN7lRHYJzC2TJGJH+uA27T5klDSzMkxb0zpSHB/I/RY4lE4WeU+DTTyr+o9Dzz2lQP8DEInM4mIV91OWGvw2N7htfLjbTJgXPbw9BgXQPoODlCOyulcdQNo+9iAicFJMTtvlVvBbHEqE18z8k+GAWEhXL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923060; c=relaxed/simple;
	bh=IT0ecoy0E3W0OnuRYQJlOWOV4lmLoEsSdVGkNZGDoPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoVfHmZ8olJvizGTcS+qIqRx190Fq5ye7XdPRQIeOtF3SkjGKThGJHdVqo7Z6B6Q6q6y3OonCmiIRQ3Bkqch0TD/FQgGomihwQmgn/aO0/1p8waglWVA/NtTYlQGtxWH4rALVTdsGfq9KMO39lnDY1eJAC3iLg/7VGtAyYmAo2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jg/7rDwe; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jg/7rDwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783923060; x=1815459060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IT0ecoy0E3W0OnuRYQJlOWOV4lmLoEsSdVGkNZGDoPw=;
  b=jg/7rDwerTEVvBrlF7i78olqIpALngx6TXHQoCr/kY2JEr1PaKSj9Toq
   HBnTlU6T30Fe1FStIx9pnINAAUrFqJp9uEUYNFdfxIqiIj0GC0hHPQ4My
   1rHVMiEZmX/4Vc4PLWK8cci3NO2Cu+KGoRuTU13fSpGqQtdecrYFP7qcr
   Hc6pTAiFLzwzX6zwKVu+JAQv+HqFj+eh8/y+ayhaPJUwTilkZ46ArBz/b
   rWR4D0/wuidS8G1bNDkqUP7vKNcUEUlnmTHBvNpDdawCKY6D03Q0OMqx0
   AKWzGs+/ikjn2TCsEkQPvKdZuH/67xJxcxZBLRQjVmKs70PfNgFN7wdG2
   Q==;
X-CSE-ConnectionGUID: htqpqB3oTmi9Zx0IvUkT2A==
X-CSE-MsgGUID: IGEU/qanR6eWF76L6fUdEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84491070"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84491070"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:10:59 -0700
X-CSE-ConnectionGUID: M9CJxGDaQnudG92tB5ljZQ==
X-CSE-MsgGUID: CubUmqsiSB6m4ll7AFcUjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251515959"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:10:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:10:57 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 23:10:57 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGTpKHZntEu+R1vtj4NCodrLF3ZMSqmiXQc4cst7OZLGmNMfyJlqPTjjXzYcod7tHgf3h3qYWuq20cOHn7A/8zvVHVR4LUIm1NEZ5Ib8sTyzjGlPLrzs+vDVpEyPTITNRomX4K5UfpBylRtNKnt9RVBdGM5b3dtJ9outBTeKS2qrZBLwJZR5aAFEwfoMqZ3h7RawZbmIAsuaJXBWME7goA0FdZgDwL4OvZ/W0Nhh0y0IM/mXf4YHFRroikDfaQxy2l+Cl3apespUWdPrKOVAdxjCQl+maeYA6FTzhXGRjRIAjPQWpGrzsY5TxQu3+zurHbTkvm5aqLNk0x9iHkckWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IT0ecoy0E3W0OnuRYQJlOWOV4lmLoEsSdVGkNZGDoPw=;
 b=vODOKaGLqmEX7sA9iMGAhkD9ql/ptEJqIxshvt6jv0GP9XD6HnhenWBwU+A3TayNzp5g+uS51I9JDz2IYlWty0lGJlcv/Y9hsXu2NXjomzqXS3gSCcsDzwJx91sYNTm4vwB3ZWlYzw4KqqeRnkBqDhj7QQZ+Jk8KyAmLrATn3a0J2gg/6bUrwRV4CtaNI9Viq2rswHDZzjenMPMXlL02k+uCNxz5+nj7fBL0QfO+XpyqOiEpH7uj9l8/OQaW9UlCWahPNeskJ7CRwxz+1k+RYXhmekV0aONRTuBLp2gE328XUpepUkBZW8+JACaNqVE9RV0yywvsxxBDEXLakPIChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA3PR11MB8920.namprd11.prod.outlook.com (2603:10b6:208:578::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:10:50 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.016; Mon, 13 Jul 2026
 06:10:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "syzkaller@googlegroups.com"
	<syzkaller@googlegroups.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Reject DMABUF pages from the access pin path
Thread-Topic: [PATCH] iommufd: Reject DMABUF pages from the access pin path
Thread-Index: AQHdD2FFcDDejy411kCYFMYx4ClAnbZq/cGw
Date: Mon, 13 Jul 2026 06:10:49 +0000
Message-ID: <CO1PR11MB48356388B36743AE8E083A3B8CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <E8540D7D05768C91+8b2ef227-3368-494e-909d-7b28e1489dfb@smail.nju.edu.cn>
 <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <CD68F549BF3761B7+20260709050800.520607-1-peiyang_he@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA3PR11MB8920:EE_
x-ms-office365-filtering-correlation-id: 0dc3a592-5320-4397-ce9c-08dee0a57ca0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info: kVS9l2DPu4ezYKjPT8W97wHLEvBludYG2rEeiad1yqVcCqXVgR9wtpWG0A1T1+qXr8riQWQru74v1T3+yyuOPtEHtMWqSpMX3PqaSZ/EC+Ev95zeSDokLHE2TTWOjn9051ZK5tHwAZ2MW94zRIrU54gFdX5KBd6zSpn8JUN0TaVjIWU79xHd/TdmTYNTIjgopc7ptByzmNf1daQWwj2VpxQmV9J4QGbrlqqpR25C8OWtk3ROf++8QugqL9iv2jVFz3xkKv8FnjPEVrt5pMO5xVVWZflLfKX7j3MlMbIwNtXubiayvUhOeCQi3guAGgCSAfr5seGYuvz+58YlX7i1c7BezBMnC8vM1vA38FGgoJAsVg74NuZxeQ/LSdIrWiBDxHd02o1JnVxJprHa+oYq8ViWSE1m1/y3JnIeSXZjJ71pPScGTfKrbVCg/kYosBEMK5x5ZmyHLF/pD5OmSN8m6YkMytaFOmreCrI+5BqIjotW5eEvJm+D4+XijqR6Ui3jcNs0USCmHOl/Ftq3M7XThJPaVnB/y1vsgwOGFatqkGARCvAeJ0phnPdPONbrE5V9F8tn/tJx8L17FUDCA0ptKCBFhaxvsEpGq7ywekLJU18mclPoYKHmrz8gbU8yPZvSFLwy8Bb5umPtaUKMjgIeKl7OPvJVBAbSBHliDm0gG/4QgIbn5ZAeWsCUUWrh/rb6/fVEUe/CsXiV82GqRsst6tQu+vuf2tZljVkt8TmBfKU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TJyZWFDNBoMCNFwXSJlzJ7QWVKke1OgcshI7Zo/7FaQ2KXfAx1kBSl0CGQqR?=
 =?us-ascii?Q?Nte9FBRzziOwY3FMzrKf61r3AjL0xtAkYyyQyBWIVFQ3fL9EW5YamsWbMCuF?=
 =?us-ascii?Q?InV4xMMBOb1GkU1TQ5cJr/jM+r/p+idTD8gnou8nsI1HZlqfKZzxZswZPQv3?=
 =?us-ascii?Q?VdcajKgBtfwCGOYy+0xzJD3eFG0T69uAfEwaOAF/9v2xQEAqGVLZfUOGgiXE?=
 =?us-ascii?Q?BSYie9GbjLg9QVz5JBae79yAbNDohF+XPtl5ZWJuFr+WQhZnXw5YJFErtvtQ?=
 =?us-ascii?Q?1MQoUvLDxWYg4yvy5JSeN4VG3gpJ0fUjs4rVa55CZ17KaPjmNIC+VYnLvgdr?=
 =?us-ascii?Q?09zIS5zT+6UD4T7nP3lrQ6yA/kmm0Uk6u7bwfmT60tvTMs7oAil7tajn5Z49?=
 =?us-ascii?Q?lk4qd/6XM2z1lGnA3pZTDZmYmptKUmBOcyiwfnG8le3ceRuj08MnhcBzJEEF?=
 =?us-ascii?Q?quT+Dzjo3jZ0dBo2SAE/eOAjkcUGK7Tb+dyiNviBhzDGpHDWSBHhPvmiuD8F?=
 =?us-ascii?Q?7y6MdCUYqRDQMQ9oGDTkPl+m1DyZGkwACxbxS9WZeg38FFN9EkObvqALF1S6?=
 =?us-ascii?Q?GcuD7V4LZWpUC7ezFcTYr4n9sIf+RyJl1Fwz0vm9IMZIJEglWfDKTbIAz9up?=
 =?us-ascii?Q?8Ku53yZa7h7cICscVAArHImSk1hXl9uLjOSsvHHtWXlkJ0RIlkVFbrfY33l0?=
 =?us-ascii?Q?eXcnLUmd3effzfQaAUaAj7h4K5ieOgGASMyIkUyPj4QmwkZYukFcZ4wmAvTu?=
 =?us-ascii?Q?zaXTO9bNU6BQsbH4JBcABYrKRfE+VfvjmpP7+w7DZF3zh8if8IQPy9u6GD9h?=
 =?us-ascii?Q?TOwNSok1YtGsL6UlHIUWb0KfgHZQB0GKZI4/fyeX89RFERQOxtroGTXKLpCo?=
 =?us-ascii?Q?yEQ/JoUh+iBX0gHxL0MVAxQQwq+c31goYYpuLk4iRniX9XVX2iV+de2K4nwe?=
 =?us-ascii?Q?E+8l1fFnkNKQWmMCRnju0d3JunbCo9VG1r1MOmx+/dDU94BLbQ4lM697ScZH?=
 =?us-ascii?Q?FwfWu6nx0SbT1nPSbOPPyiCmrUWT6eJb9SRvql4MRUwozOUWvr2HGBTlTv4I?=
 =?us-ascii?Q?Ubdr1aChyWzKDfiv3qQQnEHJfl8yajahSDFLfC1M81QvbwZBuXyOAqIrQWt0?=
 =?us-ascii?Q?uKkXb6AtqZzy6fwCquc92twdBUs4UchhRtuBrwJ8U2TGOxOJ1vtoYzrO/sxm?=
 =?us-ascii?Q?u/1oJcGvu2FY4v2WNgqoL8ue8pGWCbI+25/TV04nC0oTxNCuDoXxqg7bODv8?=
 =?us-ascii?Q?44iNjX4CslKdgGstj8RASJ1n3ts3JOFx2l0IbCMfBcjK0pxcE9jvuTyRE7//?=
 =?us-ascii?Q?CbmuWUqgjJHMLz8S4OhCYEi4xyltVpjsUxZqsYWtZ8uuIjAkG0LHz4N1gB/Z?=
 =?us-ascii?Q?0h4hMbLoJnG6pi6GGAsXAaa4PEhWJkg0/5TE6ZjTTWmzzvE1I2HDZgsp2XHX?=
 =?us-ascii?Q?pUDOGab/CJDI27tTp5w499Eq6hKwV0ZBDd0T2McJHgv439PNBFcKKM5mW/97?=
 =?us-ascii?Q?adAabAdN4ji6TC6F6FhmyNWZiyy9LQJs37gUCpQIXQKZowp1DZgpH7bRa9ng?=
 =?us-ascii?Q?+7LApUB3mIaD7kc6+bBM5CaXtuhdNBZ5aoojPaB/JCaR2ZHqSoSrp8i6WAmq?=
 =?us-ascii?Q?+38RBcbS5bIV2r1GK+nXwFJwaBgrIsmPWp/huPfaaMyyB1wNh02+Qh1VDBO3?=
 =?us-ascii?Q?c5wu82qQMf1n7jhBX0qyWou5ZfkeQhi5PnsYsWxkzo7ep4/6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Yx61PRf/txOfJXRr7r+WstCxcYklufzmXoGs5yHCk3BBqROOpr/7WN4WmhMEBQVkGk3yxtpEndc3BipTCDaKC94fkwMgHwWUizxTu25Bb1gDTAmWgQ7h117jWd9Rwin7ijZGW60c7Fj/TEHV6WYcs4Nn+wx1q/DHPsJdMlVxY+qvB53UPDPZ8+L878brDJDWtwPog7tKb7H9SjUnIDrZ39a+sA+slSM+xYyhUcDXC8TmVk0yEqpdVce0ghNRRPY1gZlVdgCJzrbjIYEhL5PPSdIUL3mYC/tcf43YhNZiw9JSihb4qTTBKZwHN9E+p7fEWBZq69tzpsYq23iteM+qog==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc3a592-5320-4397-ce9c-08dee0a57ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 06:10:49.8031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdTR6WEKf4gcekYz+7jH2z2sQcjmguYihm+OY/zdXvHjNzS+Xk3jjKmw4l+pribJWiUkbOiqD0avFcgi4HvHVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8920
X-OriginatorOrg: intel.com

> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Sent: Thursday, July 9, 2026 1:08 PM
>=20
> DMABUF pages are not supported for iommufd access pinning.
> iommufd_access_pin_pages() returns struct page pointers for
> in-kernel CPU access, but DMABUF-backed iopt_pages do not carry
> a userspace address that can be passed to the GUP path.
>=20
> iopt_pages_rw_access() already rejects IOPT_ADDRESS_DMABUF before
> doing
> CPU access. Apply the same rejection to iopt_area_add_access() before it
> takes pages->mutex and calls iopt_pages_fill_xarray().
> Otherwise a DMABUF-backed iopt_pages can reach the hole-fill path, where
> pfn_reader_user_pin() interprets the union as uptr and
> calls pin_user_pages_fast()/pin_user_pages_remote().
>=20
> This fix also avoids the lockdep warning reported from that path, where
> pages_dmabuf_mutex_key is held while gup_fast_fallback() may acquire
> mmap_lock.
>=20
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

this is not required when you are the author

> Closes: https://lore.kernel.org/all/E8540D7D05768C91+8b2ef227-3368-494e-
> 909d-7b28e1489dfb@smail.nju.edu.cn/
> Fixes: 71db84a092c3 ("iommufd: Add DMABUF to iopt_pages")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
