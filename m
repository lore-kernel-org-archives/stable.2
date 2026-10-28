Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793172263;
	b=xfzLHi98qTfRN52dsI2Gd7TbBWQNpcvN0l9Q8wWe6kVpenWYF11b8o7ZJbRn+Z+ZhnuS
	 1gFI5Sn4jCnCzxfDU//uPdoJ+PSdULIRcjGglewwprEll2rurgaG7VYM5nbTZxmpGhhX8
	 GpLWLnSAA+NlnVLazWFY+Tiu0DqnCLp3/AugfT7RLrS5y1SM0exEBTMux+cZFwb0kyJNh
	 WNnbMyhDofZnlasWtSk47Tk7lsFArQd9nhvi/DaPhdihVoYA+/wclH+Bzp5iXNm1X0lqB
	 RnfycJlNDUqW/sBElO+QPbCKun1hx9244L8ZAOyOANX9eHD+QljZbSIzdGcnFiXqr4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172263;
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
	bh=9b5CYFWa0n3BxIWeqyC5Iegaf/shxuTZTHkZRnt5xz0=;
	b=Ckkqufu5jL7prKoQj5Dbk0Q8fi65j/f6ot4EEEOecST0kJU9kCZiy+84gCPAtn5EgxDx
	 6Gch1OLIbNYf3/izUe+kb6VWfeJBKz7eFGB28047PAmNrNkNXRWVVkCsOHerwfZNtEYvD
	 YuUa7gcqU6SbiDv8WQuLlBdViV95JzFg7OLGAwjOXyOy+syul6Fvj1OhH+hLEIphyc5Hq
	 tO3la6+8S/waCmg5MpcGilcF1mLEVlK+6bpkQbG0qxyv3R60ThM4Zr3/nqH8udnYuA3kl
	 CjXL01ka5oTjwu1r/RwjvDYEDmNzej5vE0P5jeW+Nn1WvfLIuqr9eUJ/TJQXd5N2iUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DTaDK9Gm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415B606A31A;
	Wed, 28 Oct 2026 07:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3415B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DTaDK9Gm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793172263; x=1824708263;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=moHPZZuhLWcHJ5c6aY52duL2AED9F5RTWz1JsWwzix8=;
  b=DTaDK9Gm5EYIGhlXMjiOQv+ULSX3i9FkILPhlU/1ihWjx0xv8OsPpT3t
   WECq4Q79QFSS9XIs6yOCXZ4nBL+b+oKu6ZdVZiXqOAmCuqpqfydAXe1ug
   pqk/6FXV6QvINlPNXh6qV4KdFZPkjEYRL9eghmelZRzFoUnk2FsD6WLYH
   1l7KXZJaPn06eEaq4PNrj0MgkjnIyWmP+0nzRNkCqYMiLOD1Klg50ZXo3
   A80TS1trqy+Iz26bRhjLM9Up/tX5amTd4YK2otdzG3VLFqvGunPrBEQUr
   BsWLaMmwVoFrbLCIuAgawAx2JuBV4yzzbyP1sFcTCmqDGj6maHGo3JN/I
   Q==;
X-CSE-ConnectionGUID: FRvnSl+rQ2m3AT+4IuXlZA==
X-CSE-MsgGUID: o1HOcT7aS5q63Lggn1PG5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1900544"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1900544"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:24:22 -0700
X-CSE-ConnectionGUID: daDvyJy3T72jfZT/OZv8iA==
X-CSE-MsgGUID: MMdKvzgwQuWgBJzf+kidTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4628900"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:24:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 00:24:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 00:24:21 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 00:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXXVwI5EOphArn3zS74erITUOu6JQd55wxGqd2uKmeY0qw1lKpgI0Eme5v1XZ8gWnNNvOwfzaenzFj7rLsGQ8zWi9RSqAGD+aI3J7SgQowBzMDxD7aAiOpESDiEh23GmIfJ3LfEGkk17m8RNSXXEuLqt7fZT0p700TViaj+UmG4wgdgyE1dk0kiaw3Xuqiu6hlYv8LTKxO+NaHwqDYTBs4H2wetw4Zn8q7tyQ0hWnCIYQ7EyMlP6PmQbkDI1ltZYUxtnkEP3FEU/VEKS6wUj9OkucJqR4VgbXWVt2XFcpqnOLTSlA8wg2EdZz3qK5NK4O3NG44Rb6VVpQMESa1BJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b5CYFWa0n3BxIWeqyC5Iegaf/shxuTZTHkZRnt5xz0=;
 b=JYwUU/tZZ//YtB/2LtXj1/Y9ggWoJC3xSintOxHHaibgdLGAZmVw9BzXdKbPdYSQbCOXFcqnLvvZxtpOKDy6dB9jy7quINYTDyG56SdVpkhxIcdWROLzsJ/C/0WA0TyfmeRsY74nqnQvx77/f4Dw2ZiiMScZnx3Kd6I4eZ1M9HbP676CiXInT1qIrUMt1kKrwcjvC0h8kBJqR5B96a9IvJ5Uukb8abroa48QFpQ5aB/7UFbshJYH6XavSLy/yu8GCOMQIqZSQC+pX+q0iB5b1aiDz3Q/RaAR7npz+iNcT0F+y6hFgCTQhH/PqyC52vFVTyuDJZKEA7Oq6xmxxdQyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by CO1PR11MB4978.namprd11.prod.outlook.com (2603:10b6:303:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 07:24:19 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 07:24:18 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>
CC: "jikos@kernel.org" <jikos@kernel.org>, "bentiss@kernel.org"
	<bentiss@kernel.org>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "Zhang, Rui1" <rui1.zhang@intel.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate GET
 REPORT response size
Thread-Topic: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate GET
 REPORT response size
Thread-Index: AQHdZb75i2PW22JRLEOpXJ6G9Hm23rcRIysAgAD+goA=
Date: Wed, 28 Oct 2026 07:24:18 +0000
Message-ID: <SJ0PR11MB770409A05C3F3D6C45CC53AEF46F2@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20261027025820.3085067-1-even.xu@intel.com>
 <20261027094124.223069-1-sammiee5311@gmail.com>
In-Reply-To: <20261027094124.223069-1-sammiee5311@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|CO1PR11MB4978:EE_
x-ms-office365-filtering-correlation-id: 219d1377-7864-4ca1-6195-08df34c47ad8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261026140227099003|38070700021|4143699003|11063799006|56012099006|261022075727099003|261022105027099003|261021121427099003|10067099003|18002099003|22082099003|261026121527099003|3023799007;
x-microsoft-antispam-message-info: YVtVCXigoxH73vBgWxKpbcZlGAp9U70MGAwqX3RA7RxoeTq/Eu3vMTaff3bVb4ATvG/H+835SLQioQ374l/pByTf/GTgVN1LreXOnKuds+n15QF30Z959KCoiLK0LZN2msXhbtsbR9sdlNVBQPyobUu7s6AXBFMyCz0Gc8S/V4v1algmEsHvXCxJcS9eYBmt4JOa3XVnKueqiQRrQB0aGmgkcoL2zykCbfo25XzOK4ov2lDkK8SLTyb2waTcMruXZ+MstA0szXTFHnmK3ilVP6h3NXWXxGD/eZ1WDO66UXpmpPKM4ZrYd7wyPmaheHnofCaBkHCU2mu9tbmQZdsyqv2LniNU9ZHZBXoVOgjpuET5jDtvcCX4U5pztU3Wi1ewdGDxK0+NX4Os0fFQC982fctAixYRMqKvZalT8yyPdVoecKSmtOvJv4jK29Y9rYk/dmElVdNDuvNuHC63IRmyyTAgjKWZOlIM6qDwRIjBQx/AotuYjzp1K7jPDgDJtwlxR5z6IccCk3XEzENk06vj4T2M7jaDokFYfoqJgUcwI5QbFB61ejgyhInmqah4Bu7wgdlj09qBBg/6HtdvmhkvFl8cUdx8ePZ/AVPte75mXjGUS7ZYA5Ui/dUrNRCoNWrZfyVzhgTYgo6CPZ8wBDmf0LG7D5LWS54s/0bcisAd9EyPI8YIsLDz+4N4G4/0P59pE0VbsIAqk4oZxpArW2227hCGzSvaXE0C4k6BPEpt3fk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261026140227099003)(38070700021)(4143699003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(261026121527099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2uDxMHphDTFY+exjTQl0r2T/xfUZpK/MTtLHxJsWSy7eLnuGzG/GhjbGYV/x?=
 =?us-ascii?Q?aSAl33EPfIQfZSu+lT/r7IxtzKQ8Z3gAwH1eyZgzNA7+4yU5EEKOAa2AnkmF?=
 =?us-ascii?Q?5j0ZELsRcRiwDLZ7s26aMuhKZRlzX/edbaIqwfTVFkcijYbqpm+s289zv/v/?=
 =?us-ascii?Q?2osTZtIZ/0KX2P7k0J4WYamY50tPKg5+BMdKrRXRbl/cHGOQ5hqg/cE+5vHw?=
 =?us-ascii?Q?QCTXHnyF+ZdPNxOFbjs/VBy/II7E5xkWwRi4IAtlZdxAPxiqH7a/0lC1nx+Y?=
 =?us-ascii?Q?rASVgFxH1FI26Sj8DAP19ZstbYYOTGZSgVVQPYAFvAG/hIMZrr9pvhCJypH/?=
 =?us-ascii?Q?oWnhF+N6l181fScdU5Jqhc0kx7JUwF0iYqRUvH1R5wQxm4aC0vP+uFpLCcHp?=
 =?us-ascii?Q?HzWbGQgY9n3T/X67wy5neC88aaCz/uyiCcp/+bf9FiJ/HmxDeSBEfVxX9IrS?=
 =?us-ascii?Q?uvxRslVwkh/muhgQX672bV35ScFa3YVt+quFAQmp2L0uebTzOo1mmVX8pZjX?=
 =?us-ascii?Q?E2btc6VziV0TZ/o8PKkZ1Kh6/jnp9X1HJuw1z2SzMT0MkUZ+tXHIfXXciEJX?=
 =?us-ascii?Q?FOOFJS6/6hwoYy8OjRtEZKrNSIAnaEeya1Z6nEr4nkiYj9VAuH4W4U1IWFRm?=
 =?us-ascii?Q?iJyxOvNeMv/2KDsnnrzFzVSBOA9uT3d3RePLXadzin8qI6hvSoEsDXXToP9m?=
 =?us-ascii?Q?hb2OvjETzVjCHoOfYqA1/v9/b/cHKKhB+EFSeU9+GpLsl1nUpWMsuvNswgVS?=
 =?us-ascii?Q?GbyjWV1VWCWT39scV9Czqa1qMhYYOcWigmiqzdfx3Vjd+inYty6S6S06jowH?=
 =?us-ascii?Q?T/mPZkDtTRHINDJMAigt9b6QUeNiEm+aCnRl8tqml/CRjoL1zR3y3Js9wkv5?=
 =?us-ascii?Q?e6eGhhJEygqoAYAP7p3Jf1N79qxQN7nFPUbzFr+MwXg5gOa2Kh1zT2WIECRS?=
 =?us-ascii?Q?7zcbJ0XWozRgbQOsteT1H8yyN9gu7D9iYbd009qsimseJ+kuosMnUKWFeN8Z?=
 =?us-ascii?Q?uUmP/SPpmcG08W61go8InewHw8mf+zbfriCcAfAVANYuh4/X/X98hOJYQeWY?=
 =?us-ascii?Q?CuWpDnbqZjZmWS2PYqI6ETuMx2feBhLVMBmTiYuN+U5Qjj1Z2FhuyVD/lu3B?=
 =?us-ascii?Q?n2NkuzhiZUg4oiLyVDpIKHJwOjluBoP2F0BPy2+aaKb+4ssImAo09XJO5uV8?=
 =?us-ascii?Q?StHNLLMO7/1//kmrjWbkAU/6taG+1Qr6mJa1TrxD9ksRBT5p8m0Y6SBBFEY+?=
 =?us-ascii?Q?GHmhdo3cyj2yvchF2VWCHeuEoP4890nlamvTKpKsilQ/YSL/lxuu2p0XJOVe?=
 =?us-ascii?Q?iGUGOxQeb3JY1/Ckc8P/WX8/voQt7J/NAU49pYrrhOwCnP07v3NR9Ahz7ijo?=
 =?us-ascii?Q?kRH/jaRW2XHrk6hxkiT330HTFFVSdObcR3oO6PTpPEvrUAJA0uY4X2KlkYGp?=
 =?us-ascii?Q?twQiRv/ybZrubAeQyKkQar2Z5o2M2GGWiqosSpQEqs2vJbBQSeaCEOrovr0W?=
 =?us-ascii?Q?lmFYAtkr2Od+jhLvh5A92ohTPcpnyurpwxm43Tib3JYW66jyoz3scXRDFSYW?=
 =?us-ascii?Q?X1jvlBzFLZgEWwfiE/ZtNeIBn+ZnFvlIPHsiQ/g/6AisS/IRhioMcjno8mrw?=
 =?us-ascii?Q?3rv8chspnKhlB6/7Rb1drHtswTebrQvs8FkyOg1n5poM41kVxueP/WkW5vsC?=
 =?us-ascii?Q?0aCxPUMdCv51LTMfjhSgLCJwGlkz0zIcH4sWLZ67BgFs8HY+?=
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
X-Exchange-RoutingPolicyChecked: uKXznvKOWI5SbnujPbpLN0z908VcCj9tMXlTB0XLeIc9NEhb3/tN101Yv2R6Gnd4ovyAJp+wEk4eZk1PaP+nDYp7DI4F+RUT9SUvD0DUNhFPJQTWMfoe2f7OVZbhP0rLf2uQl94sEdKRc/qyXJxVf3m/4XqoA0DARRgzchUzjPEZcT095MbHgLwNi1EidaavSuLdwCKwG4x3kdcLYLXHrSGD1MJEz6kMaUp86Hc9HQcVTNhvzwuc3EQ6CMI+g+j6+hyDAE+8DGLB6d5lJlk2XvTbRcnLlTiJKFi1x5rf7LYgZ28uSmbPrxd+NAAixvP3lMh6M6w9KmRIzTZ4qKZcEA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219d1377-7864-4ca1-6195-08df34c47ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 07:24:18.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MVRHsYqmhWorUOjduZFdEoA+idDvusS8WNpKOe99bY2gnV1VvYClfLtVj7gSPF3Idp+wrMcx/3PK3NPGSY5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4978
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: HyeongJun An <sammiee5311@gmail.com>
> Sent: Tuesday, October 27, 2026 5:41 PM
> To: Xu, Even <even.xu@intel.com>
> Cc: jikos@kernel.org; bentiss@kernel.org; srinivas.pandruvada@linux.intel=
.com;
> Zhang, Rui1 <rui1.zhang@intel.com>; linux-input@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate GET =
REPORT
> response size
>=20
> Hello Even,
>=20
> Thank you for picking this up, and thanks to Rui for testing it.
>=20
> On Tue, Oct 27, 2026 at 10:58:20AM +0800, Even Xu wrote:
> > -		qsdev->report_len =3D sizeof(body_hdr->content_id) + input_len;
> > +		report_len =3D sizeof(body_hdr->content_id) + input_len;
> > +		if (report_len > qsdev->report_buf_size) {
>=20
> One question about this bound. The DATA case accepts a content_len up to
> max_input_len, and the GET response adds the content ID on top of that. A
> GET_FEATURE or GET_INPUT_REPORT response of the same size then gives
> report_len =3D max_input_len + 1, which this version rejects when max_inp=
ut_len is
> the larger of the two lengths. v1 compared against the allocation, which =
has the
> output report header to spare.

It's a valid question.
Based on my experience with enabling, touch vendors typically leave some he=
adroom when setting the max input size and max output size, and in most cas=
es, the packet size doesn't reach either limit.

>=20
> Can a response that large happen? If it can, comparing input_len would ke=
ep the
> same limit as the DATA case:
>=20
> 	if (input_len > qsdev->report_buf_size) {

Given that we've left enough headroom, this is a good suggestion. Let's go =
ahead with it.

Best Regards,
Even Xu

>=20
> Best regards,
> HyeongJun
