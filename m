Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94A4086A;
	Mon, 20 Jul 2026 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512992; cv=fail; b=Tp1GS9g3QS12LrypovbJGdMgaMS/PxVjASQT6zPexryTiNzg/vXNE9Brfm5aiBxqncMSkkG+sNufCXrbCIZI6or7sbpeXEi19KGlBtRl6kPBNJ2577pXb663LguC3AEckXa17yHXfSyxlmwaRrQCEmila5Jv01CfFqfbOeUxZLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512992; c=relaxed/simple;
	bh=gav7pF2QYAM4i9f3B3PICbQLWQoBraLZEXFGV2Bfp/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hwpbgtwNEniP+ZU6QLxxR+ZM7NAT6yUl4yc6cc0aP/SXKnPD12nRaWi/InQcWkv3pKT7gprCRoTc9TrHiK4xm/n7GU1mSLlGE+cNZoIdDZhhDP7O59BAAFFlWswdSw2KyFhbgOjsErud27bpqYT5H6Tp2SjrZZiozJg291FJAZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahwKdfKS; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahwKdfKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784512990; x=1816048990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gav7pF2QYAM4i9f3B3PICbQLWQoBraLZEXFGV2Bfp/s=;
  b=ahwKdfKSC7ueifkrImo2T7/105PPvv/AlBwisXyx+G2kgYIDwIhcjGDI
   h/6KjdF1ysPpWpszJotlXqJi87qvYTjE1437EPRS/2g82ywGgJflF+/Z1
   PvC3bPKKK16yKn73WbPX49cK2EUIUcjYM+rQlYzDq2fwm9apm2Q3OXMOC
   6whKfvdVCWqymylBTQMKYE8DzqoPws95abIUA9PYxTeVV8aDSY8sd7OWL
   Dif74O+AOp+J078BKk03KbnppvbAJcjUjT8RkxY27RijeKFxpoureKXDa
   thr8cYvg4iTZO3ewDixqtqboRvGkaLMs6Cuu4IGkLy8RP2ksshMxs/E8g
   Q==;
X-CSE-ConnectionGUID: kKItUNsuSkqPSvycJDNqDQ==
X-CSE-MsgGUID: HKUSvAn4T4mr4Cpkm4EJNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="102638408"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="102638408"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 19:03:09 -0700
X-CSE-ConnectionGUID: C4ndfXfbTOmzTD1UcuPhWg==
X-CSE-MsgGUID: PC682ctTQmKAF0N48RDcoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261609167"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 19:03:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 19:03:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 19:03:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 19:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWrL3lv/voKJU5fJLU3HYSearg4VcVn6WfHzQns2ece8tOdogIRoAOf8prHN1cV4reBwTw+qP2isf+AFjnhCylh24tEzrgh6rVD7Y4pdU65vmJsjdGkTeEMCwSU3tNr4CdfLdSTWiRJASFcJifCCe+A/jGhZ2eGK/3RhZW6RflWQ1eUb1NYkN1lfJU0USeNvcmjTJv051CSHdMkL4GIdVdT4QiEHV3GQHSOnTvyBNx/Md1dFwZY2wUYNnDqECEbWRIdDSy5lddFN2AAOpGDPuW/jh6dmApz7dmbVWg705eIjiuBNgtjxCSYEQ360nqaMOVeuG/d9nr7giFYRvkcM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbFs1zFkB0eOR/noNWV2gyaNXRV/UA9eWhWUh6sQpL4=;
 b=W65zHRSwPUnr9ddvEfmTXaH1mtnahauc4twZJhszMC8TDjgZ2MueUv6QZWUPxjQtmK1D6ZBdgfJi6N4OdehN7zcVGER1OnobQzVD9P1WLMqaP6OZEuTKcQgnRieksxm9aqdXTIFIDxmC2yo1SclVgXKG6fzkNVtGTEfWULoV4G8Z8rjUeTRk89KmrqtGZZjiM7OagrgT42Ye8drnJZ7HiCNcMQVsGR2xW7GlqQWFegHNcQmNYU1rHjp1+rQMX8m+YALaTXD4H8MVR/2GMoLIpDbXS71zuvhaAM/r6Ivpyx2mk0TmWajNludbrezO6SOu7sncZz1n/NrqmAxlGSgUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:02:59 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:02:59 +0000
From: "Xu, Even" <even.xu@intel.com>
To: HyeongJun An <sammiee5311@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate report
 size before copy
Thread-Topic: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate report
 size before copy
Thread-Index: AQHdFcz+17VPetJXIkydaUyLfa5bibZ1rAyA
Date: Mon, 20 Jul 2026 02:02:59 +0000
Message-ID: <IA1PR11MB6098C7AC805DDA79CC40A016F4C32@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260628133717.941389-1-sammiee5311@gmail.com>
 <20260717091622.1744196-1-sammiee5311@gmail.com>
In-Reply-To: <20260717091622.1744196-1-sammiee5311@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH7PR11MB5863:EE_
x-ms-office365-filtering-correlation-id: 20a6352d-41f6-4ccd-818c-08dee6030613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|3023799007|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 4QujxnO0dhSRDLV9kncIXhwRUVbstzHDoIwaCotU9kiBq2jocqCIzu1Ygx53om9agfBZpp3TJ7DXiDrGF0fgFFrpAMtDBMwCAMkKOH37lP3jnwXFLkfZZvCd6g1UC393qL4ZF9KzmOu76BIDLmkugEDoWIWRSzZeoYg01Osd6ao0+VBuJbiGWUY1EVuY8j13tHnBPe6pscJ4j4f1UwTlxUSeYcY4vCh6UNxJKwJir0sluKMLPTSS7FexGHg5J2pROnPY5QtvwzXyD2zEw1IkcjubZu7ZXMIF2rCmnVb2vJNzk1L/yFelEhr1lRWGmR3Dggq3Jj2U4P5cXdB64dhq49coh2fpRVDT2yBdRm++yoeb2qqjsW/rio0N+A6xBiFKMFEUTphgN0+PpoHqN2wiaJPFJ9QsIDU1btMg+f4DAGe8inWc5rHUQtHRRr01ajdXqsfhitp0pj3ND+9iM6WidYZILrWYzBd7sB3FjMPpdZFX+mqKmni6sOGCXo0jFyKPvvcAAuz7oCHXJ/DKPUnw+XLKo0FJ1QvwcE4f63zmflzd3/g4METhLXrGzS13QwA2Spmkd7MmWczWdROyIuc5hF5EyMYQco/PScEjzCZfhLuCyZo4suq4ZD64wDsN+oNmLw6cBtxqBRCwyzSCIssucnf6WscgstVEbd07RjiBjXAzwCeuoGo/uUqekUr3R1R2oo+Xo1JNZrYQ47w/Mq1ddmw89iP2Pt/z2EricGoOKno=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/ihwOC1qeX8qCweAXoPpjKufASaF7I7BiNcUZdYxQwrkTOCW//0WfxshBcC9?=
 =?us-ascii?Q?yVZKgAm4vwrb6/WgiT21XDIKQQVWcQkyMe8e1SdctEn4/2WVnlc7gIPfAWZF?=
 =?us-ascii?Q?w38BbDEHEPdNVXxUFg50R27BHfuIxz6QoKMLiQScs1LPiAjNg0gNk4ejNt22?=
 =?us-ascii?Q?Rk8QEX35QjO9PEwJ6JahDl27L+icGQ6uF4H+wVdVhKXRPd9XXalYZUjgF+mn?=
 =?us-ascii?Q?fNE3FY75oVhVRGcnO1s46JliIkg8fj00pObfxv0BBNk+fnRWdT2wqG5ffjhn?=
 =?us-ascii?Q?iF+et5leMie2/jroZva7UteWrG3EyWVZGVJXjvpybQKRh2+nDwuZbJhtenly?=
 =?us-ascii?Q?IDt8wkouT+yT/74XJAEJlHsQTgAexfnVvSWWecmWCACsqiAgIoa76pXjo0Rx?=
 =?us-ascii?Q?Hhkk+Ney6G//L0/ALW/SX5os/MdYDnTsr4tZVlH/pwLGzClXWSNOrUyPW8uY?=
 =?us-ascii?Q?4mcj25vxP0EoLoCa8xop1JC3Fmc557mjP4/07AC9xPvF/ankVSZKzhFZCIpH?=
 =?us-ascii?Q?Z6fp6xMt9K9QCMxFHbis/FzZeh9gNsTMeKCOBh6k8KCIrYkynTS98GjeRw8T?=
 =?us-ascii?Q?seWBy2/5j6rLOsLCVfGxLIhuryJYGTv97hK3h9mj5CPwp9kPZ9DYcamjWBgE?=
 =?us-ascii?Q?ynld3yvxJZW6snsEclsn2NIxAVmiwV5ybRGfcnjqNXeYR3EDwx3ZYbMBmmEo?=
 =?us-ascii?Q?DRhFqPEVHMkxRijquXOfqgHooA6qfBajK9kTmAVDWbmdsRzHCGD353LayLhi?=
 =?us-ascii?Q?OxqotZPDblbmlHWlKyUA4us8mhNoJ8yHx1yTPXKMCmz+h7H0UiXATGsyNmtd?=
 =?us-ascii?Q?rbAEIRQZJHaTMUh/jxRCrxKjWo7o5mRCwJ4hJIsTc8yjbRqMPbXP82cq1UZJ?=
 =?us-ascii?Q?uBrRItyKbOVCKCia9ZbgAoAjUzbX1Pw+GmZe37e44DSXMW6D9tSmqh3LcYP3?=
 =?us-ascii?Q?S7J+SlzOET6eOAEf4Y/0Ni8K5a55IHALeLXZyYy3zF3cBKIsubV/oJENoIJd?=
 =?us-ascii?Q?Do8LJyjoAgrjAb3XZFH3X3KW+EJn/NV/Ery7OZYCe2yJLummdmUoSjVaavEV?=
 =?us-ascii?Q?xRXZWMJ85iQuyJ625KySICpNfAwrp8l691jMIvQzuLtA8zLmSKdk0E3OGnUg?=
 =?us-ascii?Q?ABermskHP+fO3f+Uu/89f6/JnmuxObwdIlq88l9gPjEKV3x0/OAIsp7e8FVw?=
 =?us-ascii?Q?pVifFY9/zYFmmDqi+TqBMhDCGHjFDUZlUCuDZqtUr8Lm+Gxz7I1urULC3WtW?=
 =?us-ascii?Q?eWP70myFCzpf1DA/Z/iAB/3DJ/XioxjijcA1imYwuxNMJGUBcTe9u+F89JZt?=
 =?us-ascii?Q?nvOzT6wb2I6FGlY3BvqHbitDjI5KAXETl9WwehLAMXjor4/DR/f8fFx27EKO?=
 =?us-ascii?Q?KDI1BKAf3s83gnIA6O0W/xFqVV24F+ef9qn//O315n3KOVp0wPOBPEfmYOOz?=
 =?us-ascii?Q?KTPevxbnQt0yuUwnGTBLwwj1L0R3fNnlev7E0iUAXQiOam5GYhx2862ulsna?=
 =?us-ascii?Q?nFqEMtaZGWLBpR2UTeu+D2CCninpk+PWaI0l5bE86RnU8QS6tGuLzi+gD220?=
 =?us-ascii?Q?s3Ux9hPS9O6i04Th6g/jktzgpU7pgDi/TXy4qipIm2/tEjmuI7kpHTQvlRYS?=
 =?us-ascii?Q?P+gwX3RXvOQ9V+eYcleGCuN80Jz50Z9/PABYWG51HuoEUBG8BJFvAYDaNvi/?=
 =?us-ascii?Q?bckuOvehpaVIRuAjbCPp6XGz00BM34BYa59BNygV812u18DG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UdTtv/7dkFOOanlI7fRpHO9CqjLaFLmBj5oiqcMcVHRPOzN2eeWrxUWEegNCcJiiYANJ9PrB25GYDO+kScVx/zVWzSIzT4JcBV748CN2OxtKEibu4Y86/6G6vhubD/kmunBmMU4BkG+Rj8mYiqf5V9z+/p0XR0FiIDLIH6CMsgosbweAt6Dy7RQzoYSIS9Y31wRmFboj327nDJCjP65BdH59SCl0P4de4ge5zFMBpPEFHwFOndouLHYouH5v/Xz5u3rwLTuS5LBaHyC45RUwM2lvrXoiZRvIA1UahBnehVo+gsIAcM6CjM82CP7jQTC1p85cWS3NCvZv3/AouyMhYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a6352d-41f6-4ccd-818c-08dee6030613
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 02:02:59.4112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlchTJouOvHz770ZFInYMy/aZfBuF2T5HkyiF8aKSo2fcTEG0RgQEeiuF8zpR1etocD+JA6/uURdG8Ml+PnBxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: HyeongJun An <sammiee5311@gmail.com>
> Sent: Friday, July 17, 2026 5:16 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; HyeongJun An <sammiee5311@gmail.com>
> Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate report s=
ize before
> copy
>=20
> write_cmd_to_txdma() builds an output report in qsdev->report_buf, a heap
> buffer allocated in quickspi_alloc_report_buf() to the device-descriptor =
derived
> max_report_len (a few hundred bytes for a touch controller).  It copies t=
he caller-
> supplied report into that buffer:
>=20
>     memcpy(write_buf->content, report_buf, report_buf_len);
>=20
> The HID core caps a report at HID_MAX_BUFFER_SIZE (16384) by default, and
> quickspi_hid_ll_driver does not set max_buffer_size, so the length reache=
s the
> driver unbounded.  A hidraw SET_REPORT/SET_FEATURE ioctl carrying a repor=
t
> larger than max_report_len therefore overflows report_buf with attacker-
> controlled length and content.
>=20
> Record the report_buf allocation size and reject reports that do not fit =
before
> copying, matching the equivalent guard in the intel-quicki2c sibling
> (quicki2c_init_write_buf()) and the hid-goodix-spi fix.
>=20
> write_cmd_to_txdma() writes the output report header ahead of the content=
 in
> the same buffer, so size the allocation to cover the header as well.
> That keeps the added bound from rejecting a maximum-sized report.
>=20
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI prot=
ocol
> implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
> v2: Size report_buf to cover the output report header as well, so the add=
ed
>     bound cannot reject a valid maximum-sized report (raised by the Sashi=
ko
>     AI review of v1).  No other change.
>=20
> v1: https://lore.kernel.org/all/20260628133717.941389-1-
> sammiee5311@gmail.com/
>=20
>  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c  | 9 ++++++++-
> drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h  | 1 +  .../hid/i=
ntel-thc-
> hid/intel-quickspi/quickspi-protocol.c | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30..da5ecfcd0fbf 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -555,7 +555,14 @@ static int quickspi_alloc_report_buf(struct
> quickspi_device *qsdev)
>  	max_report_len =3D max(le16_to_cpu(qsdev->dev_desc.max_output_len),
>  			     le16_to_cpu(qsdev->dev_desc.max_input_len));
>=20
> -	qsdev->report_buf =3D devm_kzalloc(qsdev->dev, max_report_len,
> GFP_KERNEL);
> +	/*
> +	 * write_cmd_to_txdma() writes the output report header ahead of the
> +	 * content in this buffer, so it has to hold both.
> +	 */
> +	qsdev->report_buf_size =3D
> HIDSPI_OUTPUT_REPORT_SIZE(max_report_len);
> +
> +	qsdev->report_buf =3D devm_kzalloc(qsdev->dev, qsdev->report_buf_size,
> +					 GFP_KERNEL);
>  	if (!qsdev->report_buf)
>  		return -ENOMEM;
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
> index bf5e18f5a5f4..0ed964bfe3dd 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
> @@ -157,6 +157,7 @@ struct quickspi_device {
>  	u8 *report_descriptor;
>  	u8 *input_buf;
>  	u8 *report_buf;
> +	u32 report_buf_size;
>  	u32 report_len;
>=20
>  	wait_queue_head_t reset_ack_wq;
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index cb19057f1191..db6054843e77 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -30,6 +30,9 @@ static int write_cmd_to_txdma(struct quickspi_device
> *qsdev,
>=20
>  	write_buf =3D (struct output_report *)qsdev->report_buf;
>=20
> +	if (HIDSPI_OUTPUT_REPORT_SIZE(report_buf_len) > qsdev-
> >report_buf_size)
> +		return -EINVAL;
> +

Thanks for the patch!
Reviewed-by: Even Xu <even.xu@intel.com>

>  	write_buf->output_hdr.report_type =3D report_type;
>  	write_buf->output_hdr.content_len =3D cpu_to_le16(report_buf_len);
>  	write_buf->output_hdr.content_id =3D report_id;
> --
> 2.43.0

