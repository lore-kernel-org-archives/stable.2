Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D525221FD;
	Tue,  8 Sep 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873285; cv=fail; b=YE0Iir1BIcuAq0EyqTXPRsZ9S8ltkH/zxzkmOIwlE/tHjhCDR1hW/KpllKRbErMXEZP+t80LR6PSRFA+mCh5uIT10//nOGqNM81fKsVsw9J4XHoiuvUi2zBV2ylNHTiheJ5zXLO8lE0fd8pspBm+diMawEAC67bRIkp+9TuhjOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873285; c=relaxed/simple;
	bh=t399ww7Jhq1J0ZnWk6h+BPZhZpYtsf3+/lG8z97CWg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foUyK7cSUKAsk3liLFOPQKoickIAoobIWo9/WWotmoWurBYhYR1ATFmkwulX0zKamku2FofssoYVx+wo2Wu0aKTdHJ/EIV0zCC8vM9B0N7oRrqM/xkOctopPmiikjvkUvnwKCzz47/TnjqEVTfvCMBUSh+q2+HrJOXJJ5IRdkSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TepXF0EC; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TepXF0EC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873279; x=1820409279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t399ww7Jhq1J0ZnWk6h+BPZhZpYtsf3+/lG8z97CWg0=;
  b=TepXF0ECmcuZ3vTffjGzq9QN6hxo/z3wc5DzPrIQoUOJ+nyegptxpV1o
   Qw7ppNlPhvpYwNeSIFwrYIBnqJWt1HfK0MjWVvuHo5iyGQyUs7EBDSYf6
   82A1z2axEkZXhOdvR7jQgrFXiX8qv5kLBwLLSrahjgGf6QoXRkUoqUbxd
   Qls7ofOtm07IWPnEnLojIBuAMu9aQ75575kJUANELuAm9grMHYEdWKK1i
   XmeitvpZyTixv/i/WO9YlqhPJmpXdog0OgB9+DTJyJJjGRR50c218iQKH
   IgclE2Q5pAlRcwMMTxoz4HTFQfUAWYCnVHy2hfCQ2ttieP+uhnCp2Xwn+
   w==;
X-CSE-ConnectionGUID: NNb/AdiVRb2qSftiOSdsdA==
X-CSE-MsgGUID: lGJGYmQcSyKwYercqesAiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="91785721"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="91785721"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:14:34 -0700
X-CSE-ConnectionGUID: ZujWaguTRX+lgsMX4bPh2w==
X-CSE-MsgGUID: 8fTy/CLfTgqUoL8TLOfWsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="294499181"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:14:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 06:14:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 06:14:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nb1RowVkRO4rf3pr0+zguKDcH3P4KSpXwFIBnw2YqdKqzvBSqD5AIvOpJ506X5IpxbT9lk6xnViT8nsCI8Waz1QTMwejTY82U/HttxoTxbGjBxP3i3hms0RdHrTLPYkJOdZsIPcolSfAWhGakUPtV7ctCzS5ewLNeGdUhXDDOOFn1PZBXXkGvnz6i6z5zvl5SrUTxdJKAP2dcmQTmlEqhINf64ie3gI6Jji8DNkmecqckrpneiq3BEAoYy+84+qtd/Vq17UaSURmoqQm4hzz3okmCtmKoj6SVsKxM4mMVs2C4HoovsCli38q4jS/0q5AcJwLnledSFEDGUwstn213w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwsYeRpTQ0D/YL8PBayE47IV/KiX8bVrzp7yKxQwO38=;
 b=dmqYzi0VIa51RvaXIHROorB1+ZwqsPPJeaTvNSROm4bQnIULm4JBmBvBHCYAvOWCbvUim7olYwepDm8IeCieizg2CVjWUlcxExrL2XW6ylP+Hi+V91xBPzDq1JRoLUME04KIyhfOPtknqm0glME/Zu1IbktV6Uin5JX8Qntqoyhb6bAxWQdEl8zQRoK5cnUxjgQtecNSorHzB2ZINBjOTwIWWAYfuDmSv8uXs0wPNQHmyO2GJv3thI9uo9dDqfZBtg9fRI58BIHiD8A9UQC9YjPpiX97SqFiYZghLqKSLoHB9rXQkhlnXtMwNe3+Gxv6dYQsvcIxROHmu8pd5K3F3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB7748.namprd11.prod.outlook.com (2603:10b6:930:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:14:31 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 13:14:31 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Zhang Yunfei <zhangyunfei1@kylinos.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Thread-Topic: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
 leak in interrupt request
Thread-Index: AQHdPIOhsAghvpo9ukSzrE3O2utT0bbEruLw
Date: Tue, 8 Sep 2026 13:14:30 +0000
Message-ID: <IA3PR11MB898652715785B4094C61E50FE5B12@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
In-Reply-To: <20260904091827.911123-1-zhangyunfei1@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB7748:EE_
x-ms-office365-filtering-correlation-id: 3165caa4-1733-4878-2226-08df0dab1e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003;
x-microsoft-antispam-message-info: 8nHQk8ORYUyQNNRlTZVPIfgv8td9QUuKFPZ6MA1oBiexAOim5wS+RtZXsx+7QUJQUVqZEoiUCzAS0D+VKYEn/Z+Nx6aDtoHHVF4CFaNe2OsolEjJWcHifJQoAsrbqo7w4xfy2Tilg1F4TSI+R1EpvygZ3/RySAJWAm+3CyCvkF/iAO/93bLrAgWjYHXSCAeR+mFcl4xhgARBQebfvEsMqSOlj0PldHAfDE+mHoZm5eXJs9CUz4cBN8VdYeHSrxWDkVlIK5krcN15b+FIdPrCnpMAWOlCeNjCyjZcTigqddKaDfINAumDwDlZ/dujxqDKcqqaMLe50+mvhnXzShCzRWIr6l2NjKeHrSe1P4UlDDs4n/2ERzwavyRcQfN7fy4iDR0bs5XL6/ZNyT4BlbDrv+gKXwNfcethmq+UW+zV/Gri31NKjIJjFDRp+EY970y3+ZPEswz9sZ4XXL+BCReh5OLHbxnEei6MLKFRpBrUQILCC7dqeWoXBOEgsCPrjCN9Ko5SoAPZRpxfVSSC73X/1QZaCqfHskMKiva3VR9aJtKjgY+9jM+HQKPTo5RzcL8m1xwtTxWikEiKGR34h24a9J4zW5LhKaVwLmxw+bHBS7a+l5duekdqhS/RvM7JwSTBPSQwFFXVVYOg9Py/ddPMmmIWRxLrbyFnbpMl71xxJh8mPgigl/npZeSVafCo887N4Mf8XqVBYH+meBG5+dY7EjQA4xotTLCJ/oCoBRwzlhQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/W11Kra/olATpGpWddBEjkAtFl7XQIgmZ/bSScgherszQj8kKvXGzDjh9qe4?=
 =?us-ascii?Q?vXKFEQyDMJOK9VMWjdItDtldG+ObiiN0wCKT4YOyiPL0QFGqrpVqaEWnjPrz?=
 =?us-ascii?Q?yorugOgTYmzbK+XdjtORnJSoot0WXQLhVECJxloFHultl+IrYbn0MOhwkutn?=
 =?us-ascii?Q?jCVPInFrT/qKfZtGx6jIzo5ciyyo1TcNLzbjukZHiZAa2Z2HEdZemvPQMOJL?=
 =?us-ascii?Q?9xsIK1MJY2oIpPdCpE8j5KLlLeIKlp3GOSL6aSelqJ/5ypGMKtrnKqXSJB87?=
 =?us-ascii?Q?Uz4AF1Qds0lmf4+Ookkn8DZumx6LhG5DiakzJXhN2HscvEU7jGAOZrlEtyBH?=
 =?us-ascii?Q?53sz6/ljB8d9kikpemJmEKtFnV5hcSIQ0ZwyQ00pNll1rATU9K3+m6jxLsRl?=
 =?us-ascii?Q?1XEaz8M0MvPAtcnu8AEHO/wjDUZuiDAzulxieLgZGMrkY6XAZwI+dGYLhxJ2?=
 =?us-ascii?Q?QrAfGWG4v+5J+yCnxoNYOhJnkSgiLtJBwu7njAnJnpzQb84Fw8iWo0uDY39V?=
 =?us-ascii?Q?YfrA7mptsgsUO3qQComxELZnLYAEcxy1iVto96o/JxurL5Vrw7S8Pd9b2l0C?=
 =?us-ascii?Q?n8UIYYmgMuqkO5kCUQ+Nl6RuML9eBpMcec3ZG1Q4NDbxoMlAEPc8rFMjGmYO?=
 =?us-ascii?Q?2yKrxJice+PSG3OTYUhAzhywJJpAqw0MJi2U2p6ldxdhavu02F/dnGP5GbzC?=
 =?us-ascii?Q?b8ixcWYXdOFbkKQ/2e9MtJ8qz0m3V2gyp66dq+p2C/+GaanOstpVv1co6uFA?=
 =?us-ascii?Q?3kbadOXXXTGmIjP5xJtIcVSJrDl8f5GJ3pOrsikztPq4BRAuO9CIIIzBUQ0v?=
 =?us-ascii?Q?+agt1n/wOxk40D/biMS3kmupDn9FXffx2wCGUr+NXBbUVu2SX3gS9a0Asg4e?=
 =?us-ascii?Q?3cT7ZpSPCXMGoivN5gxsODqvCfRqzHL0Hz81tV0imn4D1KsoUIBaCjN4WceF?=
 =?us-ascii?Q?LXm3ft2aNU7XmJXyrjkCkiXPLzw3WOoaH7GrxKnI5h/e2bxPFtu3NtBmvNgq?=
 =?us-ascii?Q?wdq/WMSuvdih7VIVsUXH+XiSYnK+Nm0UyC6xt/mVOF06MtH/CQRuYyV90eGU?=
 =?us-ascii?Q?fRz/I5NYcUffaBAuBqtDM3+gRBzCtGaX/2iQRWEZgTl+1naFeedYzbhZd7PA?=
 =?us-ascii?Q?qPVbfS2MLEUwMQYbKFqjieGa05F9YZaveJMUbyDtlKVEW2R1qCT7CNhVEO7F?=
 =?us-ascii?Q?//AjnPmdygQ/HErbLyi8yIk0emVSnmAs4DrRFnnykqL03krDY85pOt14SKbl?=
 =?us-ascii?Q?8pEY9H+Xa0TD2my1QsPNMj4UpqFj6+euYd1TtQBrFmU9t2a9arp5YWwU+wGb?=
 =?us-ascii?Q?jfPszxcuSLFZ+BTWWGWfSPxDnv2EyDV7jZJOzVl4MRIaIqw2W2Y4ilIOzAN0?=
 =?us-ascii?Q?zZyA0ga8ZQNjvX7ftHkutAxylIKReaFkfFTqF4iAumSJASEisfetV+6aurcy?=
 =?us-ascii?Q?fF00vGYhRS7KdYVl7ZE8Zlf9RkVszzDrM8HBQsP+EYuchsoEcczMEdDlkvsw?=
 =?us-ascii?Q?Est0EZF9c2wkh9pLt1DsKRet/BfrCXYMXPEm+8R6BYNt3ZkjpX0+hKV5sinG?=
 =?us-ascii?Q?DCdfJOpviJvNWohG9ePumgqoOd3yHCoNhjMfLDgo0bE6IjZrwpSeaUPQrgFq?=
 =?us-ascii?Q?z/pKfF/wJTpnQl13hOuPhzhdQR9vl2KSK8O4D1see6vd/W8sLcHAo7RoWu36?=
 =?us-ascii?Q?2l1H+3GwSdHnRqMYNFPU8U7X7sy0CEgnn1iJ8CPvb4IzZ80U9C7WrBvckLtm?=
 =?us-ascii?Q?uDYTKfV2XbeyJP6A0FtVgYZkuSFk9Og=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jL++GpxRgk8sMMVf09GSkqcBIC/mp2gGdNH2xH6oOjFneUjdzLT+KTy7o8t9VheNIJah8XP+/hl9yZaK7g5YjO3lOkGK83gZiOg+smIenAr9WGma/vKrDQAYeOELqhMr+LLbGgBqIIZDB88vMKPeoUc8nX3CURx06Wihdy47+nmTaER+1om2rs8FWpEVNXB4avreT7W7OzyKNNZSEGtBvS8wlkdiAYLrNzidbBQ4mJgKzHOSfULNXbdnWIrVk62FaSHJ0yX+sQ9iB59cZD8pywirWX5iiNXr+JRJvqfwVFzXkOxjfHAcvD5mrF1O1m+Jym9XtDiyvwrY9mXk7xpDCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3165caa4-1733-4878-2226-08df0dab1e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 13:14:30.9376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXehZqGNR0QRbqnvQ0chsI3J8SpnrIaH2vvxvQn0EVOpdNEBUkeW7OiAZ9+RQHJbU9QLEh9VA8L1QCWYLgtTwVNUc2WUFvVV3OklTnTeqaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7748
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> Sent: Friday, September 4, 2026 11:18 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory
> leak in interrupt request
>=20
> The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
> memory pressure, but the result is passed directly to request_irq()
> without a NULL check. The IRQ core then stores this pointer as
> action->name and dereferences it later from /proc/interrupts and
> procfs, leading to a NULL pointer dereference.
>=20
> Add a NULL check after kasprintf() and bail out with -ENOMEM.
>=20
> Additionally, when request_irq() fails, request_threaded_irq() frees
> the irqaction itself without taking ownership of the name string, so
> the caller-allocated name is leaked. Free it on the error path only.
> On the success path the name is owned by the irq action and released
> later via kfree(free_irq(...)) in the cleanup loop, so it must not be
> freed here.
>=20
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Cc: stable@vger.kernel.org # 6.7
> Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 24b91be25676..86dedf5c1c09 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4063,12 +4063,17 @@ static int idpf_vport_intr_req_irq(struct
> idpf_vport *vport,
>=20
>  		name =3D kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name,
> if_name,
>  				 vec_name, vector);
> +		if (!name) {
> +			err =3D -ENOMEM;
> +			goto free_q_irqs;
> +		}
>=20
>  		err =3D request_irq(irq_num, idpf_vport_intr_clean_queues,
> 0,
>  				  name, q_vector);
>  		if (err) {
>  			netdev_err(vport->netdev,
>  				   "Request_irq failed, error: %d\n", err);
> +			kfree(name);
>  			goto free_q_irqs;
>  		}
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
