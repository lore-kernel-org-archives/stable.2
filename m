Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BC2BDC13;
	Mon, 14 Sep 2026 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789347524; cv=fail; b=dKkJ5aTiZYeIbF2wdt6HBXZ3nsvNTl/C13dcJrVJOmu7R1n6GimFwWw5ePF3OT6nfrwBi/qXW4CnArF7pgBr/Gb7MeiQLf8E4gMF04afzNSN9SWRbMDh+Pn1mQjVeOZuSO9FVoBs1/7ckJQ8tFW0yY2KgS3Xi7kHlo3XccKKZvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789347524; c=relaxed/simple;
	bh=p9YFEsQjOR9H4+HlmkdHt75kaBiEUtmXH8B7SIllOYg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSdzq8vcKnTveAJhDv7yEThyEvPtUsCBzMC4eVWq9D4vVOwZ8tSo277Pomwln9imaKncfqkgoikgfwDneuGxD7rQ/UAu05yNpE3V8/QBCIxkwqseITqHZyhZJAcmGGWMjeQQln2Qn00EtYo8imwinDMRhR1GO/HFFhExfVPD9uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FkxV+tzp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FkxV+tzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789347522; x=1820883522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9YFEsQjOR9H4+HlmkdHt75kaBiEUtmXH8B7SIllOYg=;
  b=FkxV+tzpfFhhoVZXhUm0sOjyk1+lfewvHQLdYJk5Ly5uAIR+QAO+I9I7
   DRiNzRfXLluUNt51ZsbzuLPpSVB2q3LidVC89vp2N+WtjiathI3H2UAmk
   lTzTlSrhm0gLg5p8YbaMi4JMrEL0R+1QgXmf2jk8qJMyjM+yolYZLJJ6b
   QTzXjShbqoIsi+U+vI4n2f491YZaSWgKK7sGHELhN2Y1Zn89dgSGZfv8a
   v5rYOQ8a5cBlSndw2CoX0FnMy9R2AV57BjmRom6vpWQBQ2w1N4KliOSGD
   SLPjBaIb/rTc/D6+/g7sheh4IX526yt/Jquiua6FZ7kM31BKxv5+rhETQ
   g==;
X-CSE-ConnectionGUID: pSL+30X2QQepxBhW2hZi9Q==
X-CSE-MsgGUID: 0mSCWDEHRSe9d79Sm+u57A==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93574021"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="93574021"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 17:58:40 -0700
X-CSE-ConnectionGUID: n4EaOZV5QDSzCGITPzdGlg==
X-CSE-MsgGUID: XIay59VQRhqYok7dxhLgSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="730936"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 17:58:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 17:58:39 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 13 Sep 2026 17:58:39 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 17:58:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnNAw1ecICfqqOaLNcz5Cf9Kg7WmBWbNbkycLGGSw+VsEDApynYWpMlxYbHSTeyeEKoKcTo3fAiBUjyE57uIxuKm/og7TwSZRdADbkBdP3Cmhkbq7T++S3MCBwfJVaFZoK7dC+hCF7zkbc7G2s+6VblR0NZIpjvM+3p2qiBu+43HPQrpjlhGof7/jkwFPQGAW8p2YBwTwk5Xph+Re5Ka+9aKKQnufVZrQKBXmkVIyYo1+G7z6NLgMf07xdfrzLYksq287fGfr6AncehU8foecUUsdpS9tfk71uHh7SLYPp5baOzl06lHyEwU/lg1sLDvteWQ9JiDEMTL2hqUT+yuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ6l82xphLTTUkG+hJDfCAqqKw/8b80BMnn9T7ml5VA=;
 b=hT7C5kMRdwwOYLUm3SbBYai2Jra/alFaZtl9/usGAt1LTJDQy94CG0CTboeo+9cIpRkphNTualalTnr+F3Qy7jOjFhHOe+Yu6t3NZmGKY4njh7wSZsjxttLdzDOfoSKOkvHkUnXZxZKXdPDIGEOWXxbEXboeWk8JA3y0lKm6Kbu2ReHJOPgzd5PqkcjRemCmouO7qDTn2ur3Xa+0cIKZ9OcgTbnx5qA/omzIYsVinwpzkEJZbxEtH1akamdCz3d0NnuLiSqzsOQxPycnnKdVW+je/ehyo+1lbm1Rmwe2Jl8oGRMIqvU2otgaotthNQUuGtuMXgkuE0GcAZAsYqqYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5)
 by IA4PR11MB9323.namprd11.prod.outlook.com (2603:10b6:208:565::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 00:58:35 +0000
Received: from SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5]) by SJ0PR11MB7704.namprd11.prod.outlook.com
 ([fe80::a8b5:7722:c11b:63c5%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 00:58:35 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] HID: intel-thc-hid: intel-quickspi: size the input
 buffer for the DMA
Thread-Topic: [PATCH 1/2] HID: intel-thc-hid: intel-quickspi: size the input
 buffer for the DMA
Thread-Index: AQHdMJVW2V3SeqVWnkqfbOv3Qp+OTbbNZuLA
Date: Mon, 14 Sep 2026 00:58:35 +0000
Message-ID: <SJ0PR11MB7704FF688BCB38E40B8F4C91F4BB2@SJ0PR11MB7704.namprd11.prod.outlook.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
 <20260820111558.475304-2-sammiee5311@gmail.com>
In-Reply-To: <20260820111558.475304-2-sammiee5311@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB7704:EE_|IA4PR11MB9323:EE_
x-ms-office365-filtering-correlation-id: 470113b2-fb19-4891-e258-08df11fb4e52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|38070700021|5023799004|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: FMbi6QmOLifeP09TO0OOPiv1RBmkd4JvDN0LgUycl4gtG80E2ifbBakx8N3oNislABcLJw4ghuq1kUHZJpdH55OpsbgzVsmExh+q7Y0SuJp1To7L/tIDrQyvq/Cg+xRYJRzYZ0njEVQXGFUwIDtq176NGi11UoijWMyikR1TCWari4Gw/HIs5k+Y7w2DSlZIj2tf4pMGIgtB9g3AqJcLfMQllBoVwSpI7XMtxxxOGH9+aFNoitvss2A6Cto2qf0RCuV54zWv31ms2IMZne5Edn/X+fBGzcmaUeqEFq64qFck1c4hPC62vCW9yI/WMQVUJjK8MOkuM2mc4LBZSTyHbZ0VubjxIj8tlDLQCBTPKU2DkR3bpyxRW5xQlrY2x4BnjqKuGvmsMsHqMrcuOk3rXNl2O+ht9/Zj9kMGdXkx50glsJT2Lw7VlN6rDLLyxsjRGoSvkerjNrRBKWVIprH6YYIOQjRdy4kcmgO3NlPy7tFaxS3/mBe+4h0TK3J0fU69IowmIpPQ9vfq22zJlcdrJlRMzYQ1agANfdlzfNp+V9Ym7gd5ONFkZhE7VTV4ACdXaVmlUEDOgNifigQqarWXHTlRre8ihuvg1Pwuwf9xFZzCquOSghhnEJBfbuxJO1vPfyGBlTC+6Os8bYhfIlZv8oY160atO0Kgu8BjrPSvQjEYYOPAl+Dqel3rZkV699DLhLzDYkwBHb76HwFjPKKGO6w6WM4yIj3M09+TgyH8Ajs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB7704.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(5023799004)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fmME5Ns/ZYBFDa7/3q9HVBzt1j8gnTh6HzdTVqBiTqvij/DnSgrqfmIAhNIX?=
 =?us-ascii?Q?A/jInnFrfZ8zhoSK1ar7dq4QkaEAdr+oiLZkREzB9jPR7/Bma4JBcr1m85az?=
 =?us-ascii?Q?IK4UBRhmEMRtcvBtiBjInGtJlICoYwWLny+P4cIfqYVSgtzIMbfwOEZW5uVP?=
 =?us-ascii?Q?YAv9adyZvnquZXitNMq1p+znSWBbEbr8+E1wXhCi+rC1HUuLXXq/GRZatdQ5?=
 =?us-ascii?Q?emsqi5DzFXFpk7NHCsbmB6rPA8WrV+4PVW1VSQsXNFXDhID3mpWhdkwqTQIT?=
 =?us-ascii?Q?/eiW3JILrTTEO0EhKnQ12BLyJhVaKb1voxfXBEGY40wPVgz8iADo+/wreAdd?=
 =?us-ascii?Q?Yt+6Rz1qKYD9x8ZIP7LXwIXZV3ibFYCQD9n1EMhLF52RYgR6+jNcsphLXPRK?=
 =?us-ascii?Q?vi4AOmHR7vWflZM2xRkZmXpTwozooiR6AuCoVcpBxZbxJmw8inREE3ps8Mkl?=
 =?us-ascii?Q?uX9P/f4Z/tO5h6hipJygBuPm1iX/WbeNChk4uqrikiYiibZ97aC6YTUURaxK?=
 =?us-ascii?Q?DcJrmTg8B/+synCVSeeo6Fc+nvctSoCIBmup2gscNu/49quQwY4gycs53cjL?=
 =?us-ascii?Q?YJ/RGJUkExGRdGdtWzCiLRMutT9PLrLRCSQb62c5n7arZGg/BaPiaZvvynnx?=
 =?us-ascii?Q?BRQ/+rsUMomkw/ufW48IwHvc+oI63u55NLCsno9UUFIVpuQJdb3kQUATJV69?=
 =?us-ascii?Q?gvaoj1nIcPxRVaFGZmngbtySpehk0karKKjXFas8CQ5Ire/GyEA9dwPBKsZ0?=
 =?us-ascii?Q?+5ymlP7ByjHtz8P7kt3XbQXZJQwSPIUXnMyo9pc2Oyjocuj8Qf+BTDPo9Zvy?=
 =?us-ascii?Q?uxlEei8xWELCEKHL5H4X3h6plKLGguRTrwvtzCFMCSiYvTKeQWYBsvMFSPSo?=
 =?us-ascii?Q?7wIZNWxpprc7qEgvjVwi3BFW2TgY4Egyf0pqir0mN8W+82CnS4A96rwvr9JW?=
 =?us-ascii?Q?wsBo5OioqSeWPBaEsgUYFH6B2dgvIQ3dWlQ1DUUyXBoJBeeR5/Mqkr0XM6WS?=
 =?us-ascii?Q?YtC1fzGfYWDJn5SUipBArXfwZ0uTC6zKBxVUMSNCOIRkj/RU0gAgU7jBEh1+?=
 =?us-ascii?Q?vmo9Z2XHJk20vcqBmJe9fDEkDCJqni5/nd3hK/acw8G6EQNILkPdVqMup7aV?=
 =?us-ascii?Q?hOB0jKqI7JZvS2OB1wFUyjFo37cbZ84g44gHdRRJP+yBaZojtESFEYVDmrzA?=
 =?us-ascii?Q?c1WJtDkTix5VQZInPj39SeLANiho9vCwxr0KJyVXN3b+NTgULgeO0PRhyOob?=
 =?us-ascii?Q?vl/sxJGTlYke31YaP/pLvQmQPS2Y2/PGRN0an3NmX+8auYqUn6kMczeSxvc+?=
 =?us-ascii?Q?cxbUNuLQ5EnFJ2fzqxn6z6EfHNDZW7+P6qKzv+IcMZvmHn0OdZ5r1r7MQCuy?=
 =?us-ascii?Q?gxr8l87Z0BQgA09rgRCCgA9T5CfoEi8kdnwVWKFtJVQCHmc8STyvrfOOChAS?=
 =?us-ascii?Q?xfhR6us0GmJwj8i+BUd6ort/T6ZP7w8yzNtOBqIfKwPg2L9a16A1JMHaiiX8?=
 =?us-ascii?Q?rzDLcnznpXng5MKkowMsXlVgbrlKsMb0XG4e23zKD18F6jdKcw2SoMxJqKld?=
 =?us-ascii?Q?BFnvwIR3NM+dUwQ4EgVRJtac9cjdHX6J7qTeHl9OyiHKoRMUDnu5nB8tCaqQ?=
 =?us-ascii?Q?DHtB7MIDZQGks+lgxd4u7ZF2nj2I1vdhoUi4L4IENCgfeIKKFmzAPPmDtu6l?=
 =?us-ascii?Q?9jV87GyBr/jvdV/ICLvothr+dGJL1AGxf3Lfwfbkuxg3gsdg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ma/LLTGdp8SQeQ49muLLB7yOiLPq+3c6YV3gWCAetMBjccc+hixS1mImtVd/XjBd5ATOtoAC8pjqziWz/mdFleYijbtFUCQ5+g0WFJdsb9F9pJ6Mzw2jHibm+PuGGUyU9NPRaEZZffCyMUdFLlfmauq0h1AzYUJ/9IAn5sHMbJaBNEfOSd6K+wB5dORpoPsB3MJFH6GOt9UWqtX3lne8N6PYwbJbU5Q7zRX55JD298Es3jzmEYLdz6Lv37Dd4zskr92BV9uiWUtLXyep+OqhEA1eWneqVlwYL+w5OqQgeMesTrpFBaCedEju8BzDvgDdHXWhwhZseGzVdeB1xAOQtg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB7704.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470113b2-fb19-4891-e258-08df11fb4e52
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 00:58:35.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqTLeR9yTy/uSqv81ajb8Qp0VCnDngmV85UGiTRGM7+En/1UsfkHBvb6e1VF1sVup24SGaJCZO4cmqL4rDL0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9323
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: HyeongJun An <sammiee5311@gmail.com>
> Sent: Thursday, August 20, 2026 7:16 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; HyeongJun An <sammiee5311@gmail.com>
> Subject: [PATCH 1/2] HID: intel-thc-hid: intel-quickspi: size the input b=
uffer for the
> DMA
>=20
> quickspi_alloc_report_buf() sizes input_buf from max_input_len, but the
> RXDMA2 channel it feeds is programmed with ALIGN(max_input_len, SZ_4K):
> quickspi_dma_init() passes the raw value and dma_set_max_packet_size()
> rounds it up.  setup_dma_buffers() maps that rounded size and
> read_dma_buffer() bounds the message against it, so a controller reportin=
g
> max_input_len 64 and rep_desc_len 600 gets a 600 byte buffer behind a 409=
6
> byte DMA.  thc_rxdma_read() has no capacity argument, so nothing downstre=
am
> can catch it.
>=20
> The intel-quicki2c sibling floors its input buffer at SZ_4K for this reas=
on, with the
> comment "give default 4K buffer to avoid DMA buffer overrun".  Round up t=
he
> same way the DMA does.
>=20
> Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC Qu=
ickSPI
> driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 89226f5ce45e..9ef33574c202 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
>  #include <linux/pci.h>
> +#include <linux/sizes.h>
>  #include <linux/pm_runtime.h>
>=20
>  #include <linux/gpio/consumer.h>
> @@ -549,8 +550,12 @@ static int quickspi_alloc_report_buf(struct
> quickspi_device *qsdev)
>  	if (!qsdev->report_descriptor)
>  		return -ENOMEM;
>=20
> -	max_input_len =3D max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
> -			    le16_to_cpu(qsdev->dev_desc.max_input_len));
> +	/*
> +	 * thc_dma_set_max_packet_sizes() rounds the RXDMA2 packet size up
> to
> +	 * 4K, so the DMA can hand back more than max_input_len bytes.
> +	 */
> +	max_input_len =3D max_t(size_t, le16_to_cpu(qsdev-
> >dev_desc.rep_desc_len),
> +			      ALIGN(le16_to_cpu(qsdev-
> >dev_desc.max_input_len), SZ_4K));

This is the same case I explained in quicki2c patch https://lore.kernel.org=
/linux-input/IA1PR11MB609867952C6FAA206ECDAE32F4AD2@IA1PR11MB6098.namprd11.=
prod.outlook.com/
It's not a real issue.

Best Regards,
Even Xu

>=20
>  	qsdev->input_buf =3D devm_kzalloc(qsdev->dev, max_input_len,
> GFP_KERNEL);
>  	if (!qsdev->input_buf)
> --
> 2.43.0

