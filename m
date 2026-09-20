Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CD3AFCFD;
	Sun, 20 Sep 2026 02:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871249; cv=fail; b=C2FaQjI7Ln1EQaRZ0bjYTA80ETuV1led//pvHL3tRusmyBJhKJcfrHsaLwGW/1Vs5c0hEGeTdJ0Rm6T7FaRz8i7hr/rw2CDR2JavOdtZZf5/wU7tqnpliVV0DWu0Dsb1ddr5jrx+QqzTqHM+VvZB3NO1rSuEF1lhsDvKdeKYnzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871249; c=relaxed/simple;
	bh=rL8qEFFyNaUx8q83y41HPzUQ8r8X2SwnlLG5cFrmTSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WC4AqPf7DEGBfhAPVZkROztCl45hbjUnJKVzJ0M3I+uzzJXOAB/UbEApTr4bEfaK0q+M9Si2sbwQuTIAKi2wG+c0Blpgk9vDVr8TDEAIYC5JaZRLCIhfbIt2QbTX8dteDiyPEJBfSz+1wHCmpITYEg7/5EISovUJmC5S9qL1Spo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OstW+w8M; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OstW+w8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789871245; x=1821407245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rL8qEFFyNaUx8q83y41HPzUQ8r8X2SwnlLG5cFrmTSk=;
  b=OstW+w8M3Jb9fxfcWkr1jDF7TR29jDLlQv+ADHHVAbGCqfNR1HIb6c1b
   XL20HMzapkHC8oE1bVmSGRzjZyNsJruO9HrDRcG7j/kBmXIdKMs4UElEc
   j3xDOe8unLYR/Uj3Ee6CsfobygkPt46MwKuli/H3H5Y9LpbvWdom04URc
   EYIB96HAbHkXoFjKKcPoKVQh3sXL1y/O+BPZl6dx7R65XQgHHvfFjyuGr
   RTaK4AeeBd7D0os6rHpprxcmiGYDV5KBjpqD/EafYE2uDEIigHh9Lletz
   JGWm/cMw7DlXomzNFKzaRjzxN9/Db0uK39woxueENtllY6+9gkJuVqgpb
   w==;
X-CSE-ConnectionGUID: TYhm53H8TSmIJ7QPlMJ1mA==
X-CSE-MsgGUID: HraD/nebR9ufOr/OQQkvlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="100979930"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="100979930"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 19:27:22 -0700
X-CSE-ConnectionGUID: pq9gSVi9QEWzaXl1CqTSGw==
X-CSE-MsgGUID: dbAry6+/R/KfyFqm4+RowQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="270682885"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 19:27:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 19:27:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 19:27:22 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 19:27:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IiIerMvuyGkergEzGN7soK69xkw82wRYj8BT3joboJifyVlJgn/M1bEfUnzY3oiYI/WjeiwH3pXUy19aUL9GwLfvnjy0HBhpokl0OzCrSBBeXQWzN01nC0ftxlANKK1I33EnEtddGCT27uSsqc3vQZziYkGHCb3NXfLqXB/MtzCUWkBqzuhDjxdO5rq7tu5YVMV8zECz716ADzcTIS91H8Q5WupS7r3NhCYGzpjaAvkGH35vYyaUPFK4W//qVZzrND1tBuBRl6wh0SfSrNuJ7y8Oslhqlr6Kh5MrVayPyEtEdJ2RNVgbVD/hdOm4GilF1D5wsHOzT5velgVWy8imjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyvotENuXOLdlL2QwrwjOqjive97JEhpF7NWGQG0Pug=;
 b=Zlbj1DLTCj2z8AXwVqkAsPia/lKLMjwOifKS4e0WdM4jlqBZFk5I8CAu73ZdaEJ9Ly4ltY9MS3r9OU4HTO491lof5AervSWe1gGPGyz3xDN0/zW7JPz1n9ANCPvYs8My01UUkFbpcULFuKRkPL+Qv9sN4wRNayz3RyFdpTBKAZdZXNdY4TqSiv9IM4DOxCliPAcV+Th0G+1g9OjC5bhhuLgiyRWpXs0CUMjHvLYSykAK1q5dK2Kb3D9UTeVGWdQN5jClFW56GrlgVJdPjWxHgFL+PnqPquQcgESXc6L99aQIN0+5jOWmU6vhcvwJ8CcK2a0GT7yiTa/C+aGHY1QnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sun, 20 Sep
 2026 02:27:16 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 02:27:15 +0000
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
Thread-Index: AQHdQ+y0dI1e0evkBkqTYXG13uC5ObbWxz5w
Date: Sun, 20 Sep 2026 02:27:15 +0000
Message-ID: <SJ0PR11MB7704BCE6371D2BB598367BDEF4852@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
 <20260820111558.475304-3-sammiee5311@gmail.com>
 <SJ0PR11MB770440858F3C8A9E500DB79FF4BB2@SJ0PR11MB7704.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB770440858F3C8A9E500DB79FF4BB2@SJ0PR11MB7704.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 1ecd3108-230c-4b6a-a378-08df16beaf78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|5023799004|11063799006|56012099006|4143699003|38070700021|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: v3q6+UmlwBWyvxp9HplZOG4KCLFgB5PCHNjoGUFQF/IBxkBJsPZxwkbxyn3lBlm1y9tOTSp5VQ8QqhHcgmJnr3WlqMssdxmYskNAvqTj5w8lPyk11jbAWuPfDConKJMSj2hy3eXXYTssCgiaV0QazGZT6JP5aAupmncG/szVY39oUS0NDHu2pvsewvHDJ1EuojZF4t8qmM5BLefQ1HMn/8mKWYn0QZTaGLYcK1nifcHtPDxqNNjiM0HaP3VOZGBbIwt/UCiccSIOP6TG9j5wha+hQpz968Cc5uDdQfPCdW6YcmWRuDlhMNg/fYigNXRPTVUeLYWcMMUkYDOLq4exKg3N003eio3T+25HxBJ//mRcdf4oaGcuWr25yIkNnIP5Yj2HqWa61JGHRkaVAF68Y2k+AypQtUgGcgf2UMAKKs2x7OaUK4ui2T8PbVFQ2+tOWs6ulc/2YSC18WqRRoEuRaNj40Sbwuc107WdxYWz26Zou+CopsRNM0BQtblV9xf4vtWFfZD8oXl5rnQ6WMqia50e+Ip1s2uDwbFZ/MPWuVtNwApcVh4t2MPj4v14RgoVQvF8Lkb/Tm8FqcNTCO4oWcp6BkCJKcdfTZGLIvpGUePmp+ezDxRl264Xa6lztogFXvzyB1NEn/hnI8tkMKEwRTHLedSjcgBM6L8lx7yMizmxNjqepTRsLHPl3IDvREA6Xd2/vuIS4onsqQM0Fmtg7Z1xBcV/TIhzpLQG7fb8fgE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1nnCqC9F6xGWk1jAqsDRZZDG7ATbdj9B9nx8zOBNVFl7e3fsUaAtMxqcDKUl?=
 =?us-ascii?Q?jfF5fzs9X/TRt8mkFIThqdOs7kL/PtngO42HO4s3bDBCKycCcCVXoIKHOEha?=
 =?us-ascii?Q?dJoJREyqJByigG2HlQrPLWZvcf38+RofrSR8zYAxvpiQLurJVrYZPwmHf7sS?=
 =?us-ascii?Q?68CRDMH6+RNqpJvi2syy6G+x+7hNusqzEREMUurXHWs+8A7jsTc+9ZpCxjHG?=
 =?us-ascii?Q?Ytp7FN/A22n1B/GcpRMh0cWMbzUs5BAJjgrtchV6w2q+hSEZcneJMXnpeM+w?=
 =?us-ascii?Q?8FXsnwy9Po/4g5L5YQL/QQKxzEW7ifJsiBZUoXDv/5jfoseevlnnojigxSdE?=
 =?us-ascii?Q?lDTQHkVg4I7mWdYZgV+Qp99VwqPL8RwNiDvDL6Y6qDNjaIGxPvD5oQJs97xo?=
 =?us-ascii?Q?Vk40FIqQNpoIqoheeFb1wF1fvlTFKG6fa9vDn+X/EdADstaBWCi+drlFXd61?=
 =?us-ascii?Q?isO5Knv3kj3L9OwofRHUnNaNhvD079Tl8OAma0ny8wT95fsQ/bAMssZM/OUc?=
 =?us-ascii?Q?tU7LGFGLLPjks+KAWcbz8a058ubE2LQ4MF8iK1RxJzr3LFKpFGYUlIG5OjPV?=
 =?us-ascii?Q?l52tmCLWRELPW3cMEpR/X7oQRffPy7foaE1hVXVZ1f5bAt6AtEKuYKGnl38u?=
 =?us-ascii?Q?Uovid+7k/3xaokwMmDrVyVjGKOyIGBW7IRKtTKSoLyL20nskUG2b899+AUfR?=
 =?us-ascii?Q?tjApSPLy52Wh6Ogi1777MOBlsnO9+vCPYjwEdXcyJC/V9EXyIMdqnAkayVlf?=
 =?us-ascii?Q?h703EOgOSAXfOi8nq3wp//BBUx21MbAi7JC+bqCg7G81SVg8O5yGd7Js0iEN?=
 =?us-ascii?Q?se4avZmcZ0sas9boyFZTcyXkTe4VTTTdxt/MvsdfTnQ858ph4jK1q2zKLCg3?=
 =?us-ascii?Q?le9KJGVADZx5KzWnEQwus9XQ8gcbrUDmKkcBkXeUrcVn6NIxaSMYIhkOtGi9?=
 =?us-ascii?Q?VOeQVuzSUdJqKjBqsvLF3IdKkW69xO+6KBStUIVyJ71Ih0+enjXnUcRBU3uO?=
 =?us-ascii?Q?OE8oX52WEf95xmGFnx5y/PtA3WbpjtZkR6Lpi4Jj6p1rW4lkFSFbokTQVSuL?=
 =?us-ascii?Q?uAEJmqH/wN5pYJ+7WKxI1AQAthufFh6yh1WxrDC3oK1kxUEF/4Sw6L4b2zQr?=
 =?us-ascii?Q?D8stUfhWfKaNloDDhu8etsZuGADWFscKhLWfqIiWEHYmry2woh1LDMDjeUZt?=
 =?us-ascii?Q?X6kFzTn/sa492OjhQnZXzIjHcrx5xGObftDwWrAVuY7uwKyi2LGR5/wFNmn6?=
 =?us-ascii?Q?o0lu/do8KdPmbuwCpsfaMl/9HBFxxl6/w5I+5EGZpsi9alIYWglK26TzIdra?=
 =?us-ascii?Q?GR7R7m0DxF8sHlIKP/0fazdrtDmLaGjsAgzcRWbjwvDc+HSzehAShSb68RMy?=
 =?us-ascii?Q?7Hg11S0CGWi9tlOBfRgeqmpfkhhqBE4UpunM4x0SUgL2JtFm+fLp+j0V+YYG?=
 =?us-ascii?Q?u4ZmPgCjVvkztsCWUnsDkiHJQISqPqbX43zp+8Sxbh9lGrxmOEDyxXWvDmFW?=
 =?us-ascii?Q?xJS7S47troNHmlXduskX9lIVBbqbVYYMWI1mltUH7k0ZRnMKsobbPt429z7N?=
 =?us-ascii?Q?Mgv7wO/Za/+CaJiihrmjVewSykfKTaNMjD7eP6PtIq4BGWnPTc+m+/5bEzdm?=
 =?us-ascii?Q?i/50LvkAmzXLs/KoPJF4LVwK8TBzPaj7XND+d5KfNfV6lQHDK31HsTaZOfl9?=
 =?us-ascii?Q?A63BK9MUGZJbL/UQzIHd15I9Fsv7zAUvXII0Od0DfL8yKs/8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fHeiD/uKKAvjYBfE6HinLuz1OJIuBQiiLLl/sP19mEYFqMGD4TVr9JGEbI4cdn8Ee+k5rJnXjf43AcEnWEt2ScWCnVbCriboY1J4NAaobwm7nKi2gmGyay+AZxIJszcz6xmzez+vyoQlrKHYkYIZtDn36rmR7nnXGgmN1LS/JpNqEXKc+NWNHzOjolY2BV+Rx6i06vBcBxejUtVe7ZJuV8/JDLDmM2n7b0+J5Gn7BsbfNEczOeUUiHTe3pXXa3Q0l8ZL7h9KrK+qCGdNH2yG2xzB41ektOzRJHlP88VEGD47tMpBktlNhGttM1GDb5tgFaE59mMdQJKEnMzX1S1cHA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecd3108-230c-4b6a-a378-08df16beaf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 02:27:15.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +z8oLAyYerZ+UM+cAKzQ0TRbThYRgHt/S0lRvnpHr9UqdwuOYyjw883NZ3meOwbY2xP5jmGDCqCjcq5yUyYXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Xu, Even
> Sent: Monday, September 14, 2026 10:00 AM
> To: 'HyeongJun An' <sammiee5311@gmail.com>; Sun, Xinpeng
> <Xinpeng.Sun@intel.com>; Jiri Kosina <jikos@kernel.org>; Benjamin Tissoir=
es
> <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org
> Subject: RE: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the re=
sponse to
> report_buf
>=20
>=20
>=20
> > -----Original Message-----
> > From: HyeongJun An <sammiee5311@gmail.com>
> > Sent: Thursday, August 20, 2026 7:16 PM
> > To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng
> > <xinpeng.sun@intel.com>; Jiri Kosina <jikos@kernel.org>; Benjamin
> > Tissoires <bentiss@kernel.org>
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> > stable@vger.kernel.org; HyeongJun An <sammiee5311@gmail.com>
> > Subject: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the
> > response to report_buf
> >
> > quickspi_handle_input_data() copies a GET_FEATURE or GET_INPUT_REPORT
> > response into qsdev->report_buf using a length the controller supplied.
> > The only check it passes is against buf_len, the number of bytes the
> > DMA delivered, which says nothing about the destination.  report_buf
> > holds
>=20
> This is a special capability of the THC hardware. At the hardware level, =
THC
> supports the HID-over-SPI protocol, which means it understands every HIDS=
PI
> message it receives. When THC initiates a DMA transfer to fetch data, it =
verifies
> whether the received data size, including both the packet size declared i=
n the
> header and the actual size of the transmitted packet, complies with the M=
AX
> Packet Size requirement. The packet is accepted only if it does. If the s=
ize
> exceeds the limit, THC reports a DMA buffer overflow, and the packet is
> discarded.
>=20
> This capability of handling software logic in hardware can greatly simpli=
fy the
> driver's processing logic and maximize data-transfer performance. This is=
 also
> why Intel created the THC IP.
>=20
> > HIDSPI_OUTPUT_REPORT_SIZE(max(max_output_len, max_input_len)), 68
> > bytes for a controller reporting 64 for both, while the copy is
> > bounded only by the 4K DMA packet.
> >
> > The REPORT_DESCRIPTOR_RESPONSE case a few lines up validates against
> > the size of its own destination.  Do the same here and let the waiter
> > in
> > quickspi_get_report() time out, as the other malformed-frame checks do.
> >
> > Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI
> > protocol
> > implementation")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> > ---
> > This needs commit a59cf84441f9 ("HID: intel-thc-hid: intel-quickspi:
> > validate report size before copy") for qsdev->report_buf_size, which
> > is in hid.git for-next but not mainline yet.  Same Fixes: tag, so a
> > stable backport wants the two in that order.
> >
> >  .../intel-thc-hid/intel-quickspi/quickspi-protocol.c | 12
> > ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> > b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> > index 847c5ec55569..7d34cc22a11a 100644
> > --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> > +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> > @@ -161,6 +161,7 @@ void quickspi_handle_input_data(struct
> > quickspi_device *qsdev, u32 buf_len)
> >  	struct input_report_body *input_body;
> >  	u8 *input_report;
> >  	u32 input_len;
> > +	u32 report_len;
> >  	int ret =3D 0;
> >
> >  	input_body =3D (struct input_report_body *)qsdev->input_buf; @@
> > -210,10
> > +211,17 @@ void quickspi_handle_input_data(struct quickspi_device
> > +*qsdev,
> > u32 buf_len)
> >
> >  	case GET_FEATURE_RESPONSE:
> >  	case GET_INPUT_REPORT_RESPONSE:
> > -		qsdev->report_len =3D sizeof(body_hdr->content_id) + input_len;
> > +		report_len =3D sizeof(body_hdr->content_id) + input_len;
> > +		if (report_len > qsdev->report_buf_size) {
> > +			dev_err_once(qsdev->dev, "Get report response too
> > big: %u\n",
> > +				     report_len);
> > +			return;
> > +		}
> > +
> > +		qsdev->report_len =3D report_len;
> >  		input_report =3D input_body->content - sizeof(body_hdr-
> > >content_id);
> >
> > -		memcpy(qsdev->report_buf, input_report, qsdev->report_len);
> > +		memcpy(qsdev->report_buf, input_report, report_len);
>=20
> According to above explanation, this logic checking isn't a problem, beca=
use THC
> hardware will check it and guarantee the safe size.
>=20
> Thanks for your patch!
>=20
> Best Regards,
> Even Xu

Recently, just realized a case:
THC hardware depends on touch controller's report length to determine the c=
orrect package length and buffer overflow.
If there is something wrong in the touch controller side, such as: touch co=
ntroller's behavior is wrong, or data lost in bus transferring such as bus =
noise, THC hardware will receive wrong data.
We need to avoid this in software driver.
From that viewpoint, this patch is valuable.

Reviewed-by: Even Xu <even.xu@intel.com>

Hi, Jiri and Benjamin,

Could you help merge this patch?
Thank you very much!

Best Regards,
Even Xu

>=20
> >
> >  		qsdev->get_report_cmpl =3D true;
> >  		wake_up_interruptible(&qsdev->get_report_cmpl_wq);
> > --
> > 2.43.0

