Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793206600;
	b=224HBLDeUz5upaYw5a30WjUHIjNSY1F1ZxXMYztGLEI8ozifBYWJn5+3Ymw/oog17/E8
	 UWWq/jYGkzY1rSUI1hXFWxLpkyNaT+VutbfNr9hZoNx/D2ibwMb1TPAuPlsjOMZMyCg8E
	 sQRaeYibqxKBsUS08x6OLglzhXoTkpYB27USSA4U9BoTzQ/B2yO+EqQHyb/sTPLcMg34u
	 pt0tS5nB/FnpknwVcsuXh+VeogSuCRUBfD8gQPlBMCtOEhjpRUjP3a0onWfBHRcGp71Ae
	 LUik2lT8yFDQpeUjadE+8gXFfNCudSS+Rkyr1W5mf5QHVbbkxe4MNbMpK7oIHR+1aAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206600;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=U4nX669HHp8a5NvBRL2WUsJEhMCI9Bov6TZI0tVx5ao=;
	b=xnSCjUiItgs/hGOOdXW17ijHWv8EcHTuVw5G1j+ha+8TkuV8vAuBkn4HjiQcJuz+SFTs
	 uqVYIEqLzj5sDm4NkEhFQPdWmYzbU5TnDrOoqj3MUt1A4bmi6x5IJmoZ6uuv6woZEFW1O
	 h8kbR+7rRu48JBDquyYuCpuBE0TFlArYByAxw3VkirgfDTPdr0y4T7ogyWDrDaS2j7Nml
	 5uB8eEXf/mm9qR908HubYxjhpRKhbC4WFa/485ByO+l2uSnQJr0gvI97ojKILD2mPHfIg
	 wf0ShDMj/fqCHm+iodEJxFW+NlnCaE+1W2H7PSrmxyOXR5jUhnXPRSNaKuS5swClT7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=geA3rrua;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9B60A381B
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 16:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAF9B60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=geA3rrua
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793206600; x=1824742600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ewGY8Vb4mTZARcK3Fqfq93UtQrQfkm3QJ6v92iR7PHY=;
  b=geA3rruaFYlTOoptwSNoyusmxTdLlwKJIll0yG1cCY3rddrcW0NLGNeg
   2gOIsxRgTIrU4uMdtWxUrk5oEoipJVJcLiT3m74lLgi0agPQjN09qViLx
   prY5P/sLfLK5nXaFrgZ0jthnkyyykApoKM5ZhhY/HsNAithKbXrzqHS6T
   1boCJMJffTdKHAfm0LXDMWJ4ACchqHPepaxPtH264JT5+avlF/Lnf+Ztn
   UJxdv7zQoAZ71VsLhrypOxXil7reDV6yr46hl/kWEpVarxPSRarl5Ml+H
   zdRO1fsJjEqK2o1XxhldeL51E0/ADffFK9iit7g0T0wCHBZfn1tRH8PLk
   g==;
X-CSE-ConnectionGUID: Cq7mvJn2RneOl2jjyC9UxQ==
X-CSE-MsgGUID: 3T0MfuLkRPax6F4ELv7vNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1829501"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1829501"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 09:56:39 -0700
X-CSE-ConnectionGUID: Rbbj2vvnQ5alBMLia2NlQg==
X-CSE-MsgGUID: n5PLCxETS6KfBgY0VZg2/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5231624"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 09:56:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 09:56:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 09:56:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 09:56:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r616Ea3lE1Tnmijcm/cjLQDpEtPgvtgjmuK6UTrVF4NYUhPvJkfzNQj+gIdmBCFEHLTlt0j6IZIV+7IPl7tYzO2YAVBPxc+xXBmN6H41Lsjf/jDlo2XelHaKoQJSZOHko3DXjlANqyD4J8qJkaSw3jkHWInMjKnASpofqkF8KFUaTqbtmdqM7A5N4qI7V+rfdUcDhNU3j40RTras2YFeCfdQcxsKG+QGclVF8pphl1WYhK8AvUKsO74biD+VEtpIskgVAKJmZUi9xV5DgPwvpUKSVMmnUQEFQa/0T/QeDgUQLE6tPyPI/uzhzDmVUyo4gcIZ/Lfl+Aqf1WCog4l+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4nX669HHp8a5NvBRL2WUsJEhMCI9Bov6TZI0tVx5ao=;
 b=DyOQrW5oIUCUMv4g2MbLKC7iqz9boKq5k4gwvYRzckOtCKdkCn9uaj/GTfvsr5qafv5I4dWUbC/l2WWZhBnHaufgAN+eaUwWVWtORL71Q55dfTRERmCJ50fRU5sovDfE9IngRmrUGj8aRWj9nfs9Jh46VQbHdT3WHFrnTWsGDGM3d6xEfLkxCR4b1A/vkp76qeEcuo+53Sa4JvGiXnKocQpEWIKzF5P8wC5g1Vxcf8rOslOOlnBUjJavfn8mw4bh22AuiSg7+SsxQxaA7XWegXv0fQneDzenGDXnvsqsZM8VopRPuACU4N/3Li+pmJsO09zgBZfS7jF9WOGoM1qprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12)
 by DS4PR11MB045416.namprd11.prod.outlook.com (2603:10b6:8:4bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 16:56:37 +0000
Received: from SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0]) by SA1PR11MB8253.namprd11.prod.outlook.com
 ([fe80::b584:d8d0:f097:14e0%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:56:37 +0000
From: "Srinivas, Vidya" <vidya.srinivas@intel.com>
To: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Shankar, Uma"
	<uma.shankar@intel.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>, "Lin, Charlton" <charlton.lin@intel.com>
Subject: RE: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on WCL
Thread-Topic: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on WCL
Thread-Index: AQHdZqvzQW1+UCGndU6+uh1C8duaubcTG0jwgAAQ0OA=
Date: Wed, 28 Oct 2026 16:56:36 +0000
Message-ID: <SA1PR11MB82530357E3DF904AFA9DAE9C896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-2-vidya.srinivas@intel.com>
 <SA1PR11MB8253464494AEA3E4C79FFDC9896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB8253464494AEA3E4C79FFDC9896F2@SA1PR11MB8253.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8253:EE_|DS4PR11MB045416:EE_
x-ms-office365-filtering-correlation-id: cad94981-3cdd-41ac-d97c-08df35146de9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|261021123027099003|261021121427099003|261009223027099003|38070700021|260925022911599003|260925021911599003|260925021311599003;
x-microsoft-antispam-message-info: 0M1slFL1kTcxgkH/FyjanrjQxdF0w/oFpxN8MuUOG6KN6nIggsvzZnbyfD6medZF55LbYj0G8PwdwgY5UMfRGqqOSUatSz9jJEfW2vN5g+kHEqsp3KaaqTLtAW/htBFQiNCwa+MTyQvR2EesOkQFggWwftqlQUDwcQa9SuCKABr55VpVGVC/zOUxEgcBfAQf+HlRsxAr61Bh+3quQapMrfMU5WrZpGNOUb47Jx1Ku3FibkquAEG0EfaAn5AS/ZRbcFu88g8gpmbMQ0JY5Gg9MBWop4yLOFqYv0drHtX8L8LAOOJIcXWfrMMpEOGLVz8Nl2E1QKPpobgplzYpq282JHwrEysrn/74ezgi/ZsGTUFFyzM1kqix+lUdd2hWUG5fGlSPf+ndBMptL1FcByaecKzxfLuhVf9iM9usEjndKsEFc8VDfwLSr1SMW95ujZ/XwoK24zCuU7BtKuWi6UZUY4C8JbAZ9AhhCXGNerKCpWQbSOr11EgLhklUrbyztap4kMBimrNZR5GZbTS5OEw365eKCSApGbCe4DnQni/MdpHgsxeuyVoh3jfQPRSsAUiUUjsdp3nbprF2bN/lf1/x93fCmQOQ4jgK2RQTsgdQ8G24k+6gavP0TPaDByyNcBuBz0Qu8Ia3oEuPY27UIaUi6hJ6DVZWCWOHTdZwjrmJ3r4ZvF1J77lboTRv6YgqXJfxyIFnKkJ6ImUjKzq1KY8zBFCEmckCBX1NhOh8UPtVqF0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8253.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(38070700021)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lkwc1Xu7TkPMUtlzPiMi62ldb4F5xXzFkmoGuBe+zKDpL+r5HpmpIbjrz2N1?=
 =?us-ascii?Q?oJ4+qWXyk9prpGfKNMU5xaM9A8UC2m9sxrf1MY37/V7ehVXkij+FygPEQzhE?=
 =?us-ascii?Q?lNgVALrztjy99B28Op1jS+oQ2rBGiBQfwhEj8olt9fJW8mrJGBaKemjV7T9j?=
 =?us-ascii?Q?eEoHCD9WI5woJBp4bMK2KxU1vCMB/lcTXrSOBtY6oAgN5hyjNcuX56YUNyEI?=
 =?us-ascii?Q?jrDrPoakQ0cKu+rGHU3qBVtIazmcm9maJRgiLPn2t+MhNO7ZvJI8HnFAvjbe?=
 =?us-ascii?Q?bmz4spSVXYc6kVoCpMJfJlGvjHIALviuEn8lxNaBGdrvb/mfm5/7ZJbUuud+?=
 =?us-ascii?Q?kqRGMjtmIPJ+XZ59OiwBrFhLMvSOJoz8p0il92Y+93Uoq8wUeqsyWtFg7w84?=
 =?us-ascii?Q?ozLZSJqJzJ490w85BOMOSWKE2ZEyKld3GyScqa2XvG2axlXjS1hH+h815c8L?=
 =?us-ascii?Q?Jsc/BtRVjsl/JI370riL/UJ+Em1zLGWix3lKsj6o5cV8G8XPzyZo9wv9yV1B?=
 =?us-ascii?Q?Lf2NmX6PlJefSQL1upOWdwBoYIQzDIsZs/LOg/3W2Y6lSPvX6grC1jFSB4uB?=
 =?us-ascii?Q?HDbeKIHlqj42O7PRmL/v4xsMuw25RR/4rnW1j/Vu3grAHu7TvFy7Air0gKQA?=
 =?us-ascii?Q?UpCF95ktAwnbQXEUBEu4UAD5P/COhKWHldvnXTXQ+0vFUDy5pWAfqLW9En4d?=
 =?us-ascii?Q?CdkEqNpKWPlYMzrtQeM/p29eKEm4ZOnw5kaJwMSYfo9+58RQ57ovFn3glvE0?=
 =?us-ascii?Q?HvAlP5dp/dXdfaBMkeBkpgW4l3QRqVMbCKvaY4IzE4o3c5sN4BUudz6M+EMd?=
 =?us-ascii?Q?MlPbtFsnYPq3gV+zgpQNf4F0uAwZV3psVIfuc4tnc5li/NPHe3yv4R2SuKhJ?=
 =?us-ascii?Q?80vn1Fg3TxouUNqf1frv3bsKkl6kNy4Tq7nwqln8UEYc2O8A32rYSvQEBdho?=
 =?us-ascii?Q?482XCBl/8Cp1A6JuT/qZOTZ6oRNsPrk6onSGhdK1rY6UOCFOZ1/sdJ44JVC+?=
 =?us-ascii?Q?P3eCbwpuizaJLKVbKpEm2yOunUb6HMN30X74ps8U7H773J1cary6tP5Sb6K0?=
 =?us-ascii?Q?1GJaqSjf3cQS1/7aLr7JlyrCFtMCtZyOuzzjKjyEkNfrdooLJesbkOjAKn6Z?=
 =?us-ascii?Q?iPg+5FigyuqKvGcP5FvWhoEwzZ7iQsDxw5lVdUK0QuuCW+yahgpZq+TOeAyi?=
 =?us-ascii?Q?cyekxR6gL+i1QwpLjx7538/SoFrT4jdNqZupgqcW1Eo4n+bsr4OROIHb80HV?=
 =?us-ascii?Q?hhjn+Vi8mTOW7av4UeH5kgtU80kkhYym4SLzwMBt/hPatd19gns7LTQsTULS?=
 =?us-ascii?Q?jM8zFJ7FI0UUolJA3HuE3/BPuHnJSJ4S04NX+aS52/AXFs8yEvpC5i26PEmp?=
 =?us-ascii?Q?EyZrIH2iah5DuB3Ng967vck1mnKsyvnmYDWbd1EdOGO9ghRFbAmcCo2SQvJB?=
 =?us-ascii?Q?PvJ5Dp+xZRun8HvwYE6KyTgtqkbbw6RZXNpFlkoJjLr/CZor9J7lr0ya3NNq?=
 =?us-ascii?Q?rmHWrrZuI9s8ZO5vsvalorv3wJ0dbhyo+L8s/qM9ORIuUfJjIhwb7e1msIUE?=
 =?us-ascii?Q?dBUnAJFE7ttcjC0W2KhQEVUk/y641C9pvMc2ePLlKDy03OrkPWWCeWJEx2mk?=
 =?us-ascii?Q?+2KnJ+fABbYDOg5pPMyZIAIM7JFO5vtY8E8kC7FD7UgKKlA49Wos5cHTdI25?=
 =?us-ascii?Q?Yf3NF0wHQmFPFj0ZYSP63b0NhgWndWTADDCeAvgjbfzSUNA0IAYvSO2SQY8G?=
 =?us-ascii?Q?inK2/+bUkw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hTaMJ8aQWGo+1Ii+2hnO0gFWYLuoyQf1WXspxauPywPKuvmw3fO6AuR86Ov/Pbc5m4gruM8QzUr8A+jfSzc0bolI68PIaveVQ2N6ox56CZ1fkY3hYwOMf82HjpgNACMcnOTEXFCendQjRk4glwsWvScUz4uX2fH9Qc+Gd5s6r2JjFWRRd/yV23dhGQqVcxd+bgPZI2ahLjjQ6JU++6+dxVq6UrPvdj9qOK2lIIQVhEPGvM8nMVky7nfrez42/lg4PS5WI+wxift/ny8OnNgki66AZjwGPNtoUUe1VSJfmMa2AgoTdUbi/4tu+wAnTPXjaGq9+oj66dsNuR/w1SpJQw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8253.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad94981-3cdd-41ac-d97c-08df35146de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 16:56:36.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9T2t80/0ESpmUbrHHalF9dD0TsdgQOeWNRmoBfsd9Xwv3W1soSONAA6gDGoEC2JIXq2kTT7GGl1bN8Q5HRg/uhqAbai6zBGFOjDiKRC78g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB045416
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Srinivas, Vidya
> Sent: 28 October 2026 21:28
> To: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar, Uma
> <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Lin, Charlton
> <Charlton.Lin@intel.com>
> Subject: RE: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on W=
CL
>=20
>=20
>=20
> > -----Original Message-----
> > From: Srinivas, Vidya <vidya.srinivas@intel.com>
> > Sent: 28 October 2026 12:34
> > To: intel-gfx@lists.freedesktop.org
> > Cc: intel-xe@lists.freedesktop.org; stable@vger.kernel.org; Shankar,
> > Uma <uma.shankar@intel.com>; jani.nikula@linux.intel.com; Srinivas,
> > Vidya <vidya.srinivas@intel.com>; Lin, Charlton
> > <charlton.lin@intel.com>
> > Subject: [PATCH v4 1/2] drm/i915/display: Single scaler per pipe on
> > WCL
> >
> > WCL has only one scaler per pipe. Set num_scalers to 1 for WCL.
> >
> > v2: Rebase onto latest upstream
> > v3: Fix up the commit message
> > v4: Split the scaler and joiner changes into separate patches (Jani)
>=20
> Adding fixes tag:
> Fixes: 632633d095b6 ("drm/i915/wcl: Add display device info")
>=20

  Sorry, since pipe auto-discovery via DFSM was already
  effective when 30.02 was enabled, the joiner was wrongly allowed from
  f8e1c3e07db1 onwards. Updating fixes tag:
=20
  Fixes: f8e1c3e07db1 ("drm/i915/xe3lpd: Add support for display version 30=
.02")

> >
> > Bspec: 74286
> > Cc: stable@vger.kernel.org
> > Suggested-by: Charlton Lin <charlton.lin@intel.com>
> > Reviewed-by: Uma Shankar <uma.shankar@intel.com>
> > Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display_device.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c
> > b/drivers/gpu/drm/i915/display/intel_display_device.c
> > index f17fc2c68472..c74256359c25 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_device.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display_device.c
> > @@ -1813,7 +1813,10 @@ static void
> > __intel_display_device_info_runtime_init(struct intel_display *displ
> >  	if (intel_display_wa(display, INTEL_DISPLAY_WA_14011765242))
> >  		for_each_pipe(display, pipe)
> >  			display_runtime->num_scalers[pipe] =3D 0;
> > -	else if (DISPLAY_VER(display) >=3D 11) {
> > +	else if (DISPLAY_VERx100(display) =3D=3D 3002) {
> > +		for_each_pipe(display, pipe)
> > +			display_runtime->num_scalers[pipe] =3D 1;
> > +	} else if (DISPLAY_VER(display) >=3D 11) {
> >  		for_each_pipe(display, pipe)
> >  			display_runtime->num_scalers[pipe] =3D 2;
> >  	} else if (DISPLAY_VER(display) >=3D 9) {
> > --
> > 2.45.2

