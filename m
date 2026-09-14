Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938B2E5429;
	Mon, 14 Sep 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351191; cv=fail; b=U0hQTjI/90i44zVjzELIlswtvpgrZZ/cBsvYC/7z7C3r/bWwt5bx+zCqPUjEcIq5dBQAry7NIGgqABb93g91Bn0fNCNyMYGemSBxymOOWuUO97ORlpixlQY5WxdiK7bwRjyGd0JmEbs5d8VL+xcyQqU54V4OzpAWbdx2yRYGz2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351191; c=relaxed/simple;
	bh=p3zvrDqIiJfqGWR0FTpHVlkTK/DWrqR8wRxivoIH0kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sB4adcLmREUdVc1ZS3Nn8XWWeqkSBZ6snQvgtDQUBwpFI4jKGBu1d3qx293HM7Z5lKTC/qo5z4SN/v9XL2nV1zz55dTTyrm2mqNTgkwDZ+4CY5pr9ZzeDjEI3zCfZ6nn+uDOpkIenDskQf4aMx0JKiDArxCgE5Ft3ZyeMUOQWiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFlu+Nvz; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFlu+Nvz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789351189; x=1820887189;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p3zvrDqIiJfqGWR0FTpHVlkTK/DWrqR8wRxivoIH0kA=;
  b=nFlu+Nvz26MuE+NQJZmBLFf/Rfv6aahAShAZKccJ1MiZn1jUrKnKwe1d
   fQNIBrZxRwrKNoZgTMPxUN7BduwRbTsXlUM51SMc4ApF/i4W4FBB5Qtgs
   GOeWlpaZXsPRAWqGHGXZpgWDeiVsnp5zO6BJiL5IC9IrMvUb1uQBrYMhZ
   ZDj939DSNEXuMLg70Zy4xSVCitwgI9hvpTcbFo3q+F7YYnQifSC66UGnb
   NgOVioGQij5QYuqwBgUQ08SEwSFD6nHYG1I9MH4vjsDKHnwgz2i09xOEr
   r0tRDGTLV8JNjwvxH9Fi1cI9vLdS87RWKcu0aQkOpIT5uGkbCNQ7audRo
   w==;
X-CSE-ConnectionGUID: BZmo/oo6T+2xREmCZR8h9A==
X-CSE-MsgGUID: loiIAF41QkOV14wPX+omJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89734048"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="89734048"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:59:49 -0700
X-CSE-ConnectionGUID: ty+3NIwLRL2MnioYyLdCqQ==
X-CSE-MsgGUID: YlsqKRkXRhSAE0h1fgj+jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="728927"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 18:59:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 18:59:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 13 Sep 2026 18:59:48 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 18:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w2+e8AfJZmjy9IcIim6UW2hAqT1PxSZvYRw5NIHWUztgwF5UfjWv742G8CkmGS1Iy9AZ4xtS9aMqz4EctIxj2LqmAxqCThaVO6b1c0wtmYVkYmQboFuy5UH0JHki76xFcC3JPhPRdKVSdR5i7/91G6Q1J8szatw+Liiy3PSaqL33G57HCvFjJKpXq8HoWSj+gfZFMgAAE4RcCaPUQkHvOvAS2FJu5fNifeVAaldy79qfYBL54UV45YCbmNpxzaS9LlHgMH9Dv0/C8VwQu6kzyyU75TLTvMsAgudDO/J1He7xY2EtlPGAE9la0Hg0Vi9htbfVwnQjVDtwjWSOt6ovUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ/5izopJsqsZdtvr8OifQLyUfYiDUjKEfuUTZNhN2s=;
 b=SifUPvWSM1oB8OMFOd9yMcb6npG/K3OymtyadDbF9usdtvQ4XdjXytwZDQht/EcsOORM+0ugkqILt1QSfwGgSb/vrtjESZFpb93Zox66BXac56X5QmUew4CBdD7O4/2VX94Ar6Fu0WSBzNZlh5xT/danEzM7RZuOGK9dizBD1RLmV4ZerpSpPwrUKpPr4UafrM6wLRg9p279ji0p8a3FEp/qVYiT7f8NCp0zQvhTpSxWSEHuGaKEPUhKqXvc49dt8E9tEf4ZnylZhihX8bHJtN42cqBYRriJ2/JY1SD94BFy6dg8iUX9SXjWaEH2GpJEzGpGGXlXCKLawqaIA24BIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 01:59:40 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 01:59:40 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the
 response to report_buf
Thread-Topic: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the
 response to report_buf
Thread-Index: AQHdQ+y0dI1e0evkBkqTYXG13uC5OQ==
Date: Mon, 14 Sep 2026 01:59:40 +0000
Message-ID: <SJ0PR11MB770440858F3C8A9E500DB79FF4BB2@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
 <20260820111558.475304-3-sammiee5311@gmail.com>
In-Reply-To: <20260820111558.475304-3-sammiee5311@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|DM4PR11MB6263:EE_
x-ms-office365-filtering-correlation-id: 02af4c70-f497-46b0-4f51-08df1203d6a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|3023799007|38070700021|4143699003|10067099003|56012099006|11063799006|5023799004;
x-microsoft-antispam-message-info: nkpnydJ8XdkqXUjKyqOCmVyShxfQ1ciz1k4+eOg07vE3aeAd7MwCKXsEp0xHrawOsL35VOSAv+/6/b14TcSorUbBJSzVjRIc9xnK/gFkvX0U/ggbPizOVhSGCDfKFeCbZBGJgR9NglQfYQIJaDO+kMY8RXYqBwbcwpNOOvv0VvZfBNPkm/xBK59U7bjzBnoeSSSDGShZOcQUK6q5QihWblvyjz8ZlVu2j96dKOhhlJ2naJhZQUBoztei0ygVC6g3Slqg5RcvP29Wj0KImQBt5yXH7QSxq41AXMH9PNr/98muY6fiQGRkjN0X2wANTUOAvu/QGXXwF/HbdE81cjCxgnGVethiE6c1uzkY7jE1kecgwXoSwCUliLgVGvMRRDvXSetvrcrUSP2tyTFfg2aSMjN+l5EolT9R1PJRnDIPGsiVisn6IdoLHwNmCfOuIuPn0tDpbT/CLR6JB0HufUqEv1QyQTKjnJMLuQZIdZeDgaRtmGZFg44+yqFzxrAgVSriix4ny9djdrotb3hHB5ihWxVrl2/ZP9S/e7ivJb5jrrCye34vhi5aoL6RlrfJpjoYOUkWan1PoefBtfsgjNgxmEefJCk3OOJZAzh5tHN7ZcJYbHiGInnPphxG5IP2CsDPMSTGZrTCfS/aCenlUXqQNof0mxKjogghCEg6/7Perd66alfKG8phG7LhWdqjDs2LT8Ld1u1ktaAEqOZMUkj0nqx0ovbJ5/IKcrkjTZj6IHI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QBuJETQocyM52gu6fFCEU2Q8YlGa/39KHCrEqkCuALit+ABjXwkKQElqIbvK?=
 =?us-ascii?Q?V0a+Uj9cKnufUCh9Z2PsPFACjAc0agKO5Mux+udsvGVW9Z+BjKBJOu/VPW2T?=
 =?us-ascii?Q?iHc7+wR5F9hEysICkwj2gvhZN2KA5zBxqCNkvQk/x3w+4ruVCcHcpoHtkM9z?=
 =?us-ascii?Q?OJYUPsyecZOn0lR+tNeADLPtvgwypbAfmydit5mu+EYpgHjL/1vNjy/M6sLn?=
 =?us-ascii?Q?2wAUhU+gbpmR1fVtAo4WZ705Wipl1wRv6ca++A5TtpVtSnDQxr6QQlueFxNx?=
 =?us-ascii?Q?9BONVMCyhe6lM3b0BouGLBKm47Om76tuEpxgEdAkhS76R0wlEcbb9HBPdu6K?=
 =?us-ascii?Q?cy9JxwxEkNCnvsblBlzDBd9fTugq9iVvkaB1Ut4bPAHzLG31PslIqOXbRrI1?=
 =?us-ascii?Q?EWqkK8pw4huo72ndb5np/2Zff3ONL5t95rklQJOvQiBfM2+14e7G1HVBtYl/?=
 =?us-ascii?Q?q/qBojXz3ywWSY20IQYyoDYG8O6JtJvGU1fCA+VIXgueMnsSxPorM26iWUl8?=
 =?us-ascii?Q?NXorob/xbCkgRV/akES07BRyISiqgBmdCht+AP0IZDXNSS7Qdeg37ej7WUl8?=
 =?us-ascii?Q?iJjwBkMQzMqxPsJjur1LtL3ImXG38wvyaQRY9Ykj/F4oYcUmjdHiSffGro/t?=
 =?us-ascii?Q?QV5EHkDbTp+yVP9fUb205EikTDqMYuSv0bqisPpb2Iq7kZ8E+CZqGsyPzZqy?=
 =?us-ascii?Q?SKVTjlzH1S4z+aKroACcfLKThDLOWbKDIanDVCgHU/JLslOOsXjNWMGaL/qk?=
 =?us-ascii?Q?9fQ42uYYoRSejMuug4wpHWIVC9q2D803Lfh4+Fix5B2y13iZnDP7PPn5G8tJ?=
 =?us-ascii?Q?NbwLsPkUYFk43OZ3X8Ab/8UCMSzezvP7svl6ObNFRKtotngTeTip9o7u4k7/?=
 =?us-ascii?Q?2ny4QcDvzEYVnw/Ogld7DdIk9eyahT4VODkzX10WuX+3PjlKqpPUmrxRdSVM?=
 =?us-ascii?Q?zhSPOxexM29LMxK7VYbsAUhcaPom2gZ/jvBLPZkBFufT/lhcROiawEGSqieq?=
 =?us-ascii?Q?NeEE8ivYI/ZEvX2J+FXTGLFu5c1OFub0lTAbu2tJcMNqz7FLa0WD72TdzHfn?=
 =?us-ascii?Q?fWU6nVWQgaekTHDL+rherPz+ycC746FBR3opWC7qFyrjYlkCLVifyQoCva7t?=
 =?us-ascii?Q?W2Ogv0YDsd+G1T3xvsF0fqD6KAq13BWm84ZBHGj5Ztiqv5xEi27AXbnAE9Uc?=
 =?us-ascii?Q?lC2JV++SWS0LjWkyrNpfaF68wcCGs49NDEOnfNqS1ov7hzEf1MxG/fgcOknw?=
 =?us-ascii?Q?S4471KxpdGbiO1JTGItWP7VNrNj8lsmzX7sErqLJeSZ2CRdkY4g5k41Y7PFL?=
 =?us-ascii?Q?iLCG520UytDWCCHvaPb0g6R0lqj7bI40gShLP82sjPzElGnGQNwW3pcVdgst?=
 =?us-ascii?Q?b6+Q8GoDsJWGYtOnlnAMt2Vrj47ebCtJ5ONUR8SN4xuCTeYibdDc87fhz7ib?=
 =?us-ascii?Q?J1IuI2hbcHX+iIIMI1z3xxA3Xa9Lj85DJD1mGcQGiucZDn+GmHCBIfbAu1vp?=
 =?us-ascii?Q?+M0jG1EEQmla1qh18ldZuIn7V7AcK3UlKOZX3Cx3QdpZaTlzBMaX/AKkDGJp?=
 =?us-ascii?Q?TkuD1PGMsnbeuKK0V0YCEjwRfyqzQ/mdNMD6vEQMvxFV5fOg69OPRydEDnX0?=
 =?us-ascii?Q?pRcEtKxPzceyUdxUECPZ5CyOJijenFMcGQSh0Wtv5A9jrRAKY0VcKRwHp2Qj?=
 =?us-ascii?Q?0M9AJfMMhj9Zc7qxIq5dnxpxyz2FibbJ8z3MEb6CZsMOTLjd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oV8Ts5jqaVsjO9TE3BWJ6gJ7QFTZGCb/wCDkEc9U95PW6RJFLZyhO+HooKv2fIjK/ZBJKHGaVaeP8a6Bh8EjCYUOB+73ZWPNPEeAN782FLGsFRQ4rDp8WVunUIKOEN04+2rV6akju0H3C2aI4COb/INH9YHC4Z4be6Rozf6NGygw3EWmQfQtvY/sNeNk1qWMJE/6gwBSLgWHClugMJz/2pFLgPDzVLUeUPqC+M0+5srTdXIJIKgdHMGnImhJocNnw0YwcovPOnu+4MVbYx6UNNF+3tn0PeLw+JNaAdyANjVm73Wh8kP799YWzJxNPKLnbtQFLD48rgBB5L9EPI9JjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af4c70-f497-46b0-4f51-08df1203d6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 01:59:40.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rjyn8R4NadQ8db6lFxtZTmCnYdzGGQoaR/k5TePKR9iRB8pvtoEuJ3YKs+xeLn7R19TqcC8jF6cPr5TTgZNa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: HyeongJun An <sammiee5311@gmail.com>
> Sent: Thursday, August 20, 2026 7:16 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; HyeongJun An <sammiee5311@gmail.com>
> Subject: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the respon=
se to
> report_buf
>=20
> quickspi_handle_input_data() copies a GET_FEATURE or GET_INPUT_REPORT
> response into qsdev->report_buf using a length the controller supplied.
> The only check it passes is against buf_len, the number of bytes the DMA
> delivered, which says nothing about the destination.  report_buf holds

This is a special capability of the THC hardware. At the hardware level, TH=
C supports the HID-over-SPI protocol, which means it understands every HIDS=
PI message it receives. When THC initiates a DMA transfer to fetch data, it=
 verifies whether the received data size, including both the packet size de=
clared in the header and the actual size of the transmitted packet, complie=
s with the MAX Packet Size requirement. The packet is accepted only if it d=
oes. If the size exceeds the limit, THC reports a DMA buffer overflow, and =
the packet is discarded.

This capability of handling software logic in hardware can greatly simplify=
 the driver's processing logic and maximize data-transfer performance. This=
 is also why Intel created the THC IP.

> HIDSPI_OUTPUT_REPORT_SIZE(max(max_output_len, max_input_len)), 68 bytes
> for a controller reporting 64 for both, while the copy is bounded only by=
 the 4K
> DMA packet.
>=20
> The REPORT_DESCRIPTOR_RESPONSE case a few lines up validates against the
> size of its own destination.  Do the same here and let the waiter in
> quickspi_get_report() time out, as the other malformed-frame checks do.
>=20
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI prot=
ocol
> implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
> This needs commit a59cf84441f9 ("HID: intel-thc-hid: intel-quickspi:
> validate report size before copy") for qsdev->report_buf_size, which is i=
n hid.git
> for-next but not mainline yet.  Same Fixes: tag, so a stable backport wan=
ts the
> two in that order.
>=20
>  .../intel-thc-hid/intel-quickspi/quickspi-protocol.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index 847c5ec55569..7d34cc22a11a 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -161,6 +161,7 @@ void quickspi_handle_input_data(struct quickspi_devic=
e
> *qsdev, u32 buf_len)
>  	struct input_report_body *input_body;
>  	u8 *input_report;
>  	u32 input_len;
> +	u32 report_len;
>  	int ret =3D 0;
>=20
>  	input_body =3D (struct input_report_body *)qsdev->input_buf; @@ -210,10
> +211,17 @@ void quickspi_handle_input_data(struct quickspi_device *qsdev,
> u32 buf_len)
>=20
>  	case GET_FEATURE_RESPONSE:
>  	case GET_INPUT_REPORT_RESPONSE:
> -		qsdev->report_len =3D sizeof(body_hdr->content_id) + input_len;
> +		report_len =3D sizeof(body_hdr->content_id) + input_len;
> +		if (report_len > qsdev->report_buf_size) {
> +			dev_err_once(qsdev->dev, "Get report response too
> big: %u\n",
> +				     report_len);
> +			return;
> +		}
> +
> +		qsdev->report_len =3D report_len;
>  		input_report =3D input_body->content - sizeof(body_hdr-
> >content_id);
>=20
> -		memcpy(qsdev->report_buf, input_report, qsdev->report_len);
> +		memcpy(qsdev->report_buf, input_report, report_len);

According to above explanation, this logic checking isn't a problem, becaus=
e THC hardware will check it and guarantee the safe size.

Thanks for your patch!

Best Regards,
Even Xu

>=20
>  		qsdev->get_report_cmpl =3D true;
>  		wake_up_interruptible(&qsdev->get_report_cmpl_wq);
> --
> 2.43.0

