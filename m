Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9063644D4;
	Tue, 14 Jul 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039071; cv=fail; b=Daff4DW3jaZrcuN8xBjI1NBXIvxdrf+kMh37WOVvP6KLph4HwzCGc7ZY3MQARrqiCKUIzajF1DrlWoaliECD22oMUyYfm3XhIa280ZKTLhf95+1Fh5jN8C0Zo3JXO4PpXSgGpcj75Tc2vbDdBcvNSNKGWcjPX7aWrxy85+3UQVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039071; c=relaxed/simple;
	bh=L6Z8h8qtDaHh8YtZCIEw0r/9H60zP4f4+AuDWBJFB4M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hwkguruUq6FQvdd+CwFIg1R3kFZGZEFLIBFgEtDNKdxlzHs3fCole1G9ZH+BZpE8nBrKZHNfqvTMrqyYkx+etCWx6N0KnPEYhV5sUT0MgD59sCZUaEcTPvd4NQX3uLvbYf07d0JNJ92IEteC0ZjwpjYAv/59INAfkWPQT6fYfL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gR5Fz5H3; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gR5Fz5H3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784039068; x=1815575068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L6Z8h8qtDaHh8YtZCIEw0r/9H60zP4f4+AuDWBJFB4M=;
  b=gR5Fz5H3ZCbTy485o2BX7X2ztaWYzt7BJDn3uKULURVwC2K4UqU4Rybb
   1FtgjQLN6ZWgQigT7VA8K8/b9xxfZP2bw/J+oV1Vw3HkL5gqm6c4z29jy
   kWbGf2JqhzYXB3SFQrl22Gw5NGVN3quy0Rb4sDt585e8U9nWvcwhfA84X
   u1DqqFl4WcoftI5HpQiLu+hJ0ttKVQHr8cJKCdlOzczpmWHBqV0Tov7ER
   UtFo0yQ9crC+EV/M3MoclsLJA9uXm5OzG1jWJqU86DqJOs3CM/0FLOkAV
   CBeBmO+o8XrCFajIPX+rLBQMSOOxXrTOOfnkosBCAJw6TAT8CQjxNrxBM
   w==;
X-CSE-ConnectionGUID: adTl5YL9T7mS0YTX1JKbyQ==
X-CSE-MsgGUID: JnhI/f7aR1qOTi19GdkSYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="107454638"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="107454638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:24:27 -0700
X-CSE-ConnectionGUID: vSeOF4w3S9WZ5bECWAYSpw==
X-CSE-MsgGUID: IWK2rQ6uRXKV0eKEs3KdHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="252488247"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:24:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 07:24:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 07:24:26 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 07:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOI4rQ2TH5wJ1QVj6UdJTuPWPpWQSInt7kJG/RnxWNZ7RWnK79IoSW/dlfXgzj0NOZ19YL4wq8SYhFw0I8dcE4hcYphDIzWqFZiKNXYHI6CWskEKut8Vo1NtkxcP26pg74vh021kURzsnjaIJjT729K1os+lOrl6cfDk8ivqQ27hWuT5o2ZKMylUyShVeS/Q/MQdB0Q9UO25oIsDFIrTkM+JWdu2waQr9+gdJkDoY+nf41uhH8rMe2lGl/8GtItwZDkD78rSXwQrXdD3IiWxdcomGub/EC51F4H6MreTCzfEtdaIUp6P0MXMfe9wq2DUpGPqoRNKJ/aShXw9Jec0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oyr3I05tNd8vdGvg92PZDq7hnabiyyU241YZNG+DEnM=;
 b=Kqcbh6a3KywOIn1jyjc7/Bvze3uAb3rDIAotZQfndGiBhLyPZXGpVGGlflNPDM3lFQcgfhq+wq43Lx7/cseuC7R4I26+CjVsPNVK0DzVpsXz4+sill0oUpIAH+SBXZIu9F4pCFq1A0iShzfCDHOkiYD1/BWaQ1sZtTBvzi0PwTCymAMv1hgW/bBuhCeb67gAiKPvuh+ss3k8MUpmLCLj5pnfvZZM9JYNmf7i3PwCAP2kWUUxDeRVFfqipCrpskgFIzRQKKw8B8Z/Z0moyERQMRpArJzjrNASO6JR/zGLeUSXFHlNlQ9sX3ge5ckb7h0SIocKavpvr6CZH/tX3wrpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 14:24:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 14:24:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"Drewek, Wojciech" <wojciech.drewek@intel.com>, "piotr.raczynski@intel.com"
	<piotr.raczynski@intel.com>, "michal.swiatkowski@linux.intel.com"
	<michal.swiatkowski@linux.intel.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
Thread-Index: AQHdE1vUxn7xPS/6+UahYPzQyRSgTbZtEiDA
Date: Tue, 14 Jul 2026 14:24:17 +0000
Message-ID: <IA3PR11MB89860941F0C6CEDC9FE676F7E5F92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CO1PR11MB4913:EE_
x-ms-office365-filtering-correlation-id: 634f583f-e648-4de9-95bc-08dee1b3969b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|38070700021|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: CyX48CPbopN5vWAq02zSQajOz/Ttt7+4JlSHEJhnQvFjKZKTOGpx42g3Ui9WF87vzYyyBBtvRXiGRcfZjty1OlX5uH7eISOyOMOZIFYUu+zM9pEuS4cozfJxCRmPjY76ATPVPFEYhE+UU1c6dB4hZVuM3PGCQLueLc47rUe0WF/psSzUcHaf7bk44Gn5Hb4t2W60imeDdUl80QIxmPC6exxSOjqMUIPo/dGMNXHHF/rFDFH9gsotFhAEkSzpA9ixPxc1pOIO6VDMgYs6g/8VOMLyjA/+tAz/M0L2X3jTxAtDozHzLJw2AnVFxHtlsfVFhQ3Lp/bthvvDgOb2fMfhdZtVmQV5Uz2ACZJaTFDDC8NCOzOyyPD898xRtdFG0PZMpLSTmNNvPiJMpwmM55M4cGoW/TuTmZZtBjYKZU4aySQ+KipKvNzTF1/j1y5OgCi3sRWQkGf6AG/nKUazFggh7xiefcAarD4NFtBWRyZYbj4jEoMm/6LNmeLfHt1OJCKIPASv/T9dOLpXjlxIcrE+yGizdxAhkwKdoGFnphQEvoghTvzXxtlznybW+YvBbgtuPox+oqAgM4FqpJd8PylGtAZwlqFiNoz0hX33X5QllxL+QYZI4Zl81Mg194DAEJMPEpO96Dt1Ask7gU1rE10sXCR5kKQnpLAeEt3OZl0Giog8rMTy1H2EN9ny7iau5oTts91OjTBd00ErirKsp3XE/2MNy6QFErJzdn1lB8UjOBI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hsy62Vcaqhrw9aycYDNUpjXtamX5SmhJFfpFz76vEzlTWFHYNEeVo9FpbfVJ?=
 =?us-ascii?Q?gAHQqlolnPtVL482ag600XoNtcC/AhLptErBj3QUJhWDq76RbwU8dG2N+rso?=
 =?us-ascii?Q?GnehXlce4IvjqOtFpvmF5ZrT0jc6r1y3gJXWHHPru8Xv0wCvecc7trreJkKb?=
 =?us-ascii?Q?EGhaTY++hJA47++r/z3SP6O7tXHXlRhIExtO0Ogjp/1C/emIK9n0DI5b38sv?=
 =?us-ascii?Q?pUidVBN2FmFtNQU+QZRkHkYPMivpjrduGWQjic+YMVkIdpCNLSd7jqih8x3Q?=
 =?us-ascii?Q?p1nIvk71laIsQpJR6Zm7AP7WpMCM3A5ko3ttH7ejxr8k/VNRBFrTUrj0s+Jh?=
 =?us-ascii?Q?KQ9Fh2IK79Y36iPuBiEuHm0vE5Q4+Ka+c+rkjZbEZyaaCYIp2psPDuvybjs4?=
 =?us-ascii?Q?JKEL8cPDainZHlAPVxDN5rDybr3DL8O+j5MbzdTrtQx67BOanmbgz+T1BPJf?=
 =?us-ascii?Q?XP7yc12A0xAoGfRLQ8Tp7GekWHm3TzDt/7tVSZLV08mqp1HoQ3XC1L/Cx9gN?=
 =?us-ascii?Q?8adF3kv21nFdHd9B4tHTETM0cQE4i9eaPhTWDlUPzCOcJXHw58q+kCyEUhNr?=
 =?us-ascii?Q?+/cWp4HuEA6bU6bzVlEK6SUFWgx746VyHOvDA0uelRkizUGMzKrj7G3MqEV8?=
 =?us-ascii?Q?Slz5Ry7HZW1hFZl6/i4P5eb7A8nZUBIypq6AV6As+1fiDPjZw2BVY7SViYaq?=
 =?us-ascii?Q?zefRkfyTKvQuRqu1mIkmOhsODbzZJZB/MtAIO+WsdTX5y0patu4/3fTIQEjA?=
 =?us-ascii?Q?YN08UO2CihrAfciTfSpWtFcu1RCi+jI/6ecuSnTN2gZXKoeCvz3nybuj1llE?=
 =?us-ascii?Q?H6Zehq35xCFil0+5AdOxkEGqb56Kiqm78I1lUpyORZQI48INpEMKTpZs8NLC?=
 =?us-ascii?Q?OW7g2C5CzqCz74tzwdlJ50h82IbNq+o0L1k32rCl5aopcHpYnohhiZa3a8wD?=
 =?us-ascii?Q?l76DToCRJUDvfsF5eINHr49JOX5tizYcjmszounkE+/HxvTFLpiv6Euyznvd?=
 =?us-ascii?Q?NFMqqz7QmYpkFAZ2CJw42LYYKr78fp2mZEXnT+xbRLvGBp49whHS+dXHMsF2?=
 =?us-ascii?Q?Akkxgxxr+mCdGmN0+ELTJKCqEAAQJPxNh9QrhRcLBhGt/Omipt7+ArII1N0f?=
 =?us-ascii?Q?+NfFLW/3/i+nXrH5tr1+S28/UEvmHJ2u1KOlwfSHIH6WT9bpEOwSmf0qfs8S?=
 =?us-ascii?Q?yFqyksjyIm5ecKxc9dapz/y2APnkqxIW9lmTrRE8nQ1ZxWYnVfTy2RB5RUF+?=
 =?us-ascii?Q?7010YgdmUAssYvrsaIkpyZ16x2prAlhqJl4MEvx3W435O67EKTmC54ytEcwB?=
 =?us-ascii?Q?HaHpxXVNej0MPT2C6oKctdcDvA7wNdhgTxJVIsCSjE4gEfgzWXxI/MQGd/dV?=
 =?us-ascii?Q?wt2jfuZCsquGjv6LK0ock5xCLgxLZHpl2u2NwF0EvowxfoxzfAzxsgjVguql?=
 =?us-ascii?Q?tvt/2VX6QsULKK2MwTkH3xSVcRnOtJvvhUHz7qvaoP78TW6hBTxZmJDjkGjn?=
 =?us-ascii?Q?lQFLWvPsVohb4rDOmzgQDIu5aL60Umjw7AoVqCNgjOChTfpbNGk06khJSh3s?=
 =?us-ascii?Q?JLfkYh0FOuqZp+XvXsag+yiFk2ICCqeo7lDgFKRebfpq8DchlU1eh5Ef4NqN?=
 =?us-ascii?Q?Zr46ii1/hFsnAaIk/pEs3J3Z0rARKbEJq15062kAzPhyLylRqpdzU4yns4Pa?=
 =?us-ascii?Q?OmPHcc4XsruG0Xujmf80I6CcdiSEnzRXNmz1oBDDtble1lxU/NuVH6IwOb2C?=
 =?us-ascii?Q?ek4NRx4GGZBbn+YFW7OsTyb6zCvulNg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IDwVeqLo/V/Mf/5eREN43cO6H4Ebxy3WeAUWLOB4KpRc5IyU7qg5SxcPeG2hof0PHz4wu7jXHox9XgtXPOLQlTxpeb96nFuPSbi1lLg9hA7jgvnVnqPE5rb2e+wTUTnC6B8/Ws9LFtPYjb0kNmKa5XYQic/dA1qTorzVBkiLvqQD+9gH4jyur7vaISu30Pgd3nzMbyZ9HJ2iKyADUlTEZ+F+Ayw3Iyo5g8kINAJkWp/yfNZ6xiXY+MCgmAZ0y0E0TIdv5oQ9CiOsI/bi0udvEcg1Kk40LEaD8Pg+vT3PLTQrwPvIpmB7PrnmUoVjl1JaEfBPkiwbfgKABid5hPKghg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634f583f-e648-4de9-95bc-08dee1b3969b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 14:24:17.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzY/pC1Cc68dc31UVLlsD4iTSxGShPslTJ7awqcUZKng41AOMF86LaPzF4zpIkI0iPAvF/Kid4oNRrOA0JmSGxHADM3QHzYdfxQQvGMlx+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of xuanqiang.luo@linux.dev
> Sent: Tuesday, July 14, 2026 8:40 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> Samudrala, Sridhar <sridhar.samudrala@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>; piotr.raczynski@intel.com;
> michal.swiatkowski@linux.intel.com; Keller, Jacob E
> <jacob.e.keller@intel.com>; netdev@vger.kernel.org; Xuanqiang Luo
> <luoxuanqiang@kylinos.cn>; stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free
> in dynamic port cleanup
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the
> dynamic port from pf->dyn_ports. However, it frees the VSI before
> reading the index for the erase, resulting in a use-after-free.
>=20
> Follow the reverse of the allocation order in ice_alloc_dynamic_port()
> by erasing the xarray entry before freeing the VSI.
>=20
> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c
> b/drivers/net/ethernet/intel/ice/devlink/port.c
> index 2a2e56777f9f7..3ede246490027 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
> @@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct
> ice_dynamic_port *dyn_port)
>=20
>  	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>  	ice_eswitch_detach_sf(pf, dyn_port);
> -	ice_vsi_free(dyn_port->vsi);
>  	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
> +	ice_vsi_free(dyn_port->vsi);
>  	kfree(dyn_port);
>  }
>=20
> --
> 2.43.0


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
