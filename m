Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120945;
	b=S+RCunzTrWyqo/hbgnxn+CgyM97TS6a0AJpdMh0nQ9QppQVSvvbl2tKR/Pp7H0wGnrrY
	 bX6mmcydquEA2MVI3pokLKwtOpzOa94GgxO30fMjwOHSPB0iRdv8X1jLHcfuUwGe9IFNK
	 BXRJFKXwNo6KxoOTPZY3G0X74t4uAYEsChXaZDNtHIsmCbi+UYO8lmiM557XZtnxEdep+
	 NZaxHLavdCiFL018GCFK2g1MhwhwtXxSHyn+2S1VOL3SIx0X6ZUCQ+klbnFHkCDbp1w7X
	 haKKx0RC16tryZe+keab6aP8ln7dr2/jaDMH35lOFVYvv0Hm2es3p8kwIZFnjzSrSEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120945;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FC0jpkCEajtCEgP04f4q4LHDf8b4d5kO4xZ4W4T0sE4=;
	b=ktoorhnmlEUsMUi44UvmHeAot3w5Ln/bKJE0IQzp6jHizEFesiwhc40cGqAQkRU0WKjc
	 BWVGahQs0M8WV/YEae8KPuCODZOpTSVrwUnp5zdLWNrcECDOt6MMA2gpJ0N3l//1UiLJY
	 nhvEGsr7GuFzhYFfue27TVB4d8ZV6hen6Adlkq7baQP7SU755YsUgrpxFtKc/H2fmr8jC
	 HolgmOLWjxL64KjM79z1T2G7//SEb5FG9Ipt/8opA3dOhcJeZefbKQwAwVMglUKtZnyZK
	 BWmry3KWmoLaxGGxa2Hall+o2lh3OeiOeuLcNrFHLVBrylFxtrEOG5IAAm68rhrTo3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ZmMUWQwE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.71
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012071.outbound.protection.outlook.com [52.103.14.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD4606A31A;
	Tue, 27 Oct 2026 17:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DFD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ZmMUWQwE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOHjBwF9fDvz9bCBA/h4qHUs4sREOATRgEmogLWsqnk3vCQPFy0jmAlfRBqyc/XfYBQn0C+Vhxp5yHQEz5M51/F6fKeeNrN7Wf8cJ4/sJ+8N9ywgv/ZBNfWkrCW44md9DblpUyO9rlXIxX7W7epr9b07hVNtGKbmOh3kUno2BMcqacnZdcI7P6VEiLgTPvxXn5FD9NuxzE76A1wujc0LAjDjv46BvNRyz/HLQQCL8/Gip/rEjy2oNW5Dzit6CTril76/o1T4fICH6MggtjYs5KcuXVdMcpbeMjt0lCX6dStW/3J8OQW77wjOr/8qCvUW46eZQJWRwg2AOAWVollcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC0jpkCEajtCEgP04f4q4LHDf8b4d5kO4xZ4W4T0sE4=;
 b=pnarP/cqhVNAxF4IWBI6WR5GEOJEl0+P2BK/C919IMcaAZe08RpniuVCxQRhUEjUCSsPUC84aFbqlwECjR0EoExIxyCSTfNXbRdRR0fb79jbK025V5Vsmk9gWgQ8nSoHJP/P82zOc0dCTW/Eb0F65jDggKeSN4m3fmuoUqYZP7ZF52cpV6RvkQUz4VJGArB9lXGWbMXW3hONxsR+MRfbpO/XsgDWdTs+WgyW3mGmGw49YDKy7gRiDx8gbsCI6MxhIuxVQeJH77UtAoiLlmpge8Ra9i2wieQF+bUKpp+9B7DZQT09lnYNOR7cT/Dc0RQiYdJ99IcJ7AgAHPZncgzHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC0jpkCEajtCEgP04f4q4LHDf8b4d5kO4xZ4W4T0sE4=;
 b=ZmMUWQwEotER4m432nXNYPFo/PlDeJHAGqCBP9aAFJEytjsuMSKekK0HzvWq7Qpt5UMES3FQTg2nNzemAR8e1ulafNOxC45N+cVqTF+SCp5LcNv3XEWhYG9SacKNxY9bnorby2QHSuVGCExEdWoBfCMNoBSP5OKnwLBWQBFKPXqq96iVv990e1UImaNdIOB+pTDZ8vCsmAk2GayLWY1VU1iJYai2Z2GoNEK/PkWhjgFyyGIATlF2zZAZuyjqZ/6Il0946FUrES8HCwSID7SZN45qDz4x4f+jaGC0DY027TT/9sdhdyIgNweHod743lgeHGDSkry6vjgrcOjn/aWlVA==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA0PR02MB9751.namprd02.prod.outlook.com (2603:10b6:208:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:09:02 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 17:09:02 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Jiale Yao <yaojiale02@163.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Hemminger
	<stephen@networkplumber.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Kameron Carr
	<kameroncarr@linux.microsoft.com>
Subject: RE: [PATCH v3 1/2] Drivers: hv: vmbus: prevent duplicate dynamic IDs
Thread-Topic: [PATCH v3 1/2] Drivers: hv: vmbus: prevent duplicate dynamic IDs
Thread-Index: AQFxSm9HVMFxOTFM+hFv7ncFU97/HALZK31Zt9MDGVA=
Date: Tue, 27 Oct 2026 17:09:02 +0000
Message-ID:
 <MN2PR02MB6863E937B6E4B8ED6EA22FDED4602@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261027065642.2280297-1-yaojiale02@163.com>
 <20261027065642.2280297-2-yaojiale02@163.com>
In-Reply-To: <20261027065642.2280297-2-yaojiale02@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA0PR02MB9751:EE_
x-ms-office365-filtering-correlation-id: 409c8de8-d2a0-460b-81d7-08df344cfff3
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vRlIBzz/47iMvNNMIfmOdLMs801tnAtL0FVuBRvonS2yTiTdSKOvWea/vhbigNwmsrcXjujhE5qlBsdWuLWBUg0Bd/kx5LKsX10T8mmPGoalTatiKOUn+3FcZrxNlDW15FFOChRyuNRIvA3jB7K/DsXyWdP9mfDkgQGqFku0m7tZO2fNtz7uYJ1eIQy/XZG0Apc0yakvIG1Kt34DG6LS1adISv4JaYfOlkB8t9NOTH/NOS2sz7BKIuQvD1RjWL/05UjKeT5ECQfJwltNgXtzNZvbYuU8KBt2j6uWt40Gi5H/g8gOjgtEohmVNcJTI2mZ8T07f/au4NoByh9fFxJ85iRRCQ+RJFoTmiwig9AsueX6c5LPIeYPklelIwpV2/QKbkFh6S52XBUMsROTL5m5zU0RZr3t+Du+ed9T2YQxyVBuMz7zhUKWDMuQxtzhiRZFEPXewGzmD6s1YWuQlENjz03iY2UyB8JtJ3dOCSfEvMlWd+8SgwGFKdKkZibDR1Swb1I7DnMq88oImgyRJyJWjFHu/0OtFQ7Pa+2wv7cydevRJUaK4LSRFcOU0+7xTNHs/qWXM/4FhDAyN64WUzrL6R0AbHxYDsVi9MIP8I2AlrEnDzE3e/vNn3qZDe21w6/y/WFsIf3gAOG5HlThAGvYe+AWd+us4tcVQe5SfC61IgSpHQRJgselvzboF7SJiTC7rtZG3Bt1olXD2WEysJDNwI4Hitjc0AsYj2M4vwzZYwxLk=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|55001999006|24021099003|51005399006|8062599012|41001999006|8060799015|19110799012|12121999013|13091999003|31061999003|37011999003|25010399006|102099032|3412199025|440099028|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?epSNUlnes2uAR3RDVU6vRkwO/mvxMcFCHP+3C/sDAAxmkuuLkPpdRr/nWax1?=
 =?us-ascii?Q?iOHGUZJL+6BVV5qK3xmr/EzlLsRyFFS8MoniJTWWPGjqGvoItJCPdS3E8Skm?=
 =?us-ascii?Q?KQogf8k3/OrwipskLiv/56/puslKmO3/6wqOxvbQa2twnTB/WRi45+WCJp7/?=
 =?us-ascii?Q?XJG/QzvrxPHkES7AKNjs2osUakISCEtJ7PwHs4KCGtZbVkAGOgNRc6SlQBww?=
 =?us-ascii?Q?odNc3fpVcd2ut80xFcRhzv6vAjBTYbPAoDLe21eGOnuJ+JLk8glr5I0uSMvZ?=
 =?us-ascii?Q?ES5SxyAKaONnyFUrizqTDUgF0mefskxqcuqrLiNqUVHAnVGxAuKwMbm9zM5f?=
 =?us-ascii?Q?LEHUYIkdzd1yxoOm6ysrFyOqb2e/AIqQM87wW7Y4V6aUOERozaMZFwD5oZtS?=
 =?us-ascii?Q?csWlWHpTY6BWQv/6i+cGobVHibHX30T64QF4Rexc3Bx7iccjHTCVbEsVjsS3?=
 =?us-ascii?Q?kxx/Sbmo/IMfYl7u0j5HcUXcPyEXiaSKecpKrlh9M1KYtVU0kzF/G3BakkRG?=
 =?us-ascii?Q?+2NUCXDPloyBdGUAeIi4BfaPVmkwncQ8k4RdPi3TfB1IXvoT6JYzwHjAlgiT?=
 =?us-ascii?Q?UxQSLzK4XHf9iVbBj7DzmW1YhKL6GwSyt4r+ZoZ5zJfEWqZIqV/g7ZGhaFyn?=
 =?us-ascii?Q?IlEl0C/ektpVkkVkXM/kObxoZLLuIBaLh/LSi/IQRqHtCWmLuFwRDcUxszpI?=
 =?us-ascii?Q?7k8wiMDIs67+oI5PiTDqppjabseFg6bdXf/XIiqwuj3U7NW68szE4HrX2xiN?=
 =?us-ascii?Q?bvsI1zpg5T3jLeZnJp0wI6qAWcHwGI+90QZCZytuL7ZYEJWKmCK3CfJM8Dy4?=
 =?us-ascii?Q?8O9pD9t8OCRPn2OB3toZSoZD4aU/mQ/D4FHbgwxwE+djQs9Lull4ShhTXk90?=
 =?us-ascii?Q?BGCzcK7lcbjCpYRYMwAVwpUsHXGh/zAhkUvwfEo9OX6632/XrTisGh8AElwl?=
 =?us-ascii?Q?jEdo/f1r/dxHoFdEbcVk0QEE4KMuoYZ6PPj378mCbLx46+uI5RDWr/I5hqo/?=
 =?us-ascii?Q?LLF6GNP6jYj2+ln831coUghuQRNamtU/oQniLsyHNMceSSfXP8VZKYqnmft2?=
 =?us-ascii?Q?gGl6Z/x7RiAvg+9DmMOQ4Zc9qvXARnizAIHvKcwfNJsd7C33fZg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XXddYEOT9kpnTO5CTws7laztSrL7lCrUd7v7AAtxfSnffLh+LdVT3nIaXaoU?=
 =?us-ascii?Q?ZZYgpHJgb8tTH2OVcP6SsNj5gopKOWmVDUqqo+aGaUjDLnG2PW4lpLRz/mGc?=
 =?us-ascii?Q?6cOr3PY7XiumDxFW7ko2zdYESU8+RaOkKUgF02l2D7ioy4WehFnQEpzKmMJ+?=
 =?us-ascii?Q?t3ZeBrfvpk1X9siOIdf5YUq0LUMf/oUp7izNurN/MiRVYWhuF1oe/gf59Z4m?=
 =?us-ascii?Q?YZVv4bvKD3VfQZPddJAkjjHINsomeHqUBESDDLjEtPt3FF9GNI55/uqvvWM+?=
 =?us-ascii?Q?zB0WVZkGqYSprekKhYJ6vqmUzNqlk7pG7QcWSSOIGCGcNFUadji9at7KWOlF?=
 =?us-ascii?Q?/pbjRX2kc7Sh1VsmQZXkQljLec9H7cl8ZslbCVvSOHhpxbxUbftF2Rh5l21G?=
 =?us-ascii?Q?xhu1PkCdSYVKpeoFC2IpkwqZFIDeA4U9hFZEWL+AzOWsRlWXStzJoPYRLgVS?=
 =?us-ascii?Q?+iErKPZ//u0CA+JIdjGlBJDDAxhgcLrMnSV/hUHeCvMpkP2rD728hQNWJ7T5?=
 =?us-ascii?Q?2Y+llNGL/Rw5MyEVBtDwRz66BIQTRivxMEJOeY4qa6cYCEMTjR+OIsOvZDS7?=
 =?us-ascii?Q?rDiwJskypcWaXSTTl6HiQIE5/riOvbE1IY2swzuhVZZ3KThCPHTf4KkQbPK4?=
 =?us-ascii?Q?zKwoGByP8wyXJQVSN6Y+0JlNyMWu3fHLHKIhgucG/OIqgVNhtAN8DseI7ASQ?=
 =?us-ascii?Q?OgwQNxgZhm2BroMrMJthshzVMKlpHzpGHsWJZl0MRVhzYECGHwAl7MboqUuN?=
 =?us-ascii?Q?18HT+aThVdhKv+VZKhYLdDVwFyv0heEEkqYDk83GSGEnqIsMjkGnL8Fh46SF?=
 =?us-ascii?Q?UF4mz+R0RPdJIvsFB4y2Cj0Ti870nyawzMfGsYRCpLTlnFEBE/a1u+gLf064?=
 =?us-ascii?Q?aNuJQ9MxWnb32XeMs2c6KBA47l0AaSO8JjHx8LjilnATmMJFC4si1RhaE/SL?=
 =?us-ascii?Q?1sDVX/4B6U0/WdqeWE+gQpNpdO8ngCsXjU7w5Ykgz+kud0mqfWMdLVghQRQF?=
 =?us-ascii?Q?A6EiToqzVm5yL5b25W9/vmALbf/tV3IHyXBZ9EuRfSX/efDWv/rbky5dapdv?=
 =?us-ascii?Q?buIhVzEE9sJw277kNtxZYnphaX3P2eA+jZNhYWQobGlbQctLzyIcRVjZ3ndd?=
 =?us-ascii?Q?4lo2UMeDcZHVaIwg9jGHe6LOhSkriOQjITSEyVnRT4hW1zcFbc8KUtyI1qk4?=
 =?us-ascii?Q?YOCYUJW7bj8Ht5u+DEDQG7TA1Mu7h+bflXRYIatFQhDQpRi5dUt3i9nt4/MV?=
 =?us-ascii?Q?geFm6k/S2OtY0vo5Ay6k2cPmXjUNE8+iRH63daECmFJWU0mOaWi4No6Y0a1B?=
 =?us-ascii?Q?Ihwje1QfNj9oAIJtkv+Q1DZiOO7pvQojG8o7KnSQjA7HSnWBK8q+C6ivKA9a?=
 =?us-ascii?Q?YdmLTVc=3D?=
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
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 409c8de8-d2a0-460b-81d7-08df344cfff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 17:09:02.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9751

From: Jiale Yao <yaojiale02@163.com> Sent: Monday, October 26, 2026 11:57 P=
M
>=20
> new_id_store() checks for an existing dynamic ID before calling
> vmbus_add_dynid(), but the check and insertion use separate critical
> sections. Two concurrent writers can therefore both observe that a GUID i=
s
> absent and add duplicate entries. Removing the GUID once then leaves the
> duplicate active.
>=20
> Move the duplicate check into vmbus_add_dynid() so it is performed under
> the same lock as the list insertion.
>=20
> Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
> Cc: stable@vger.kernel.org
> Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> Reviewed-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  drivers/hv/vmbus_drv.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 4692687cdbf3..1037117e2d81 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -737,7 +737,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_=
id(const struct hv_driver *
>   */
>  static int vmbus_add_dynid(struct hv_driver *drv, guid_t *guid)
>  {
> -	struct vmbus_dynid *dynid;
> +	struct vmbus_dynid *dynid, *existing;
>=20
>  	dynid =3D kzalloc_obj(*dynid);
>  	if (!dynid)
> @@ -745,9 +745,16 @@ static int vmbus_add_dynid(struct hv_driver *drv, gu=
id_t *guid)
>=20
>  	dynid->id.guid =3D *guid;
>=20
> -	spin_lock(&drv->dynids.lock);
> -	list_add_tail(&dynid->node, &drv->dynids.list);
> -	spin_unlock(&drv->dynids.lock);
> +	scoped_guard(spinlock, &drv->dynids.lock) {
> +		list_for_each_entry(existing, &drv->dynids.list, node) {
> +			if (guid_equal(&existing->id.guid, guid)) {
> +				kfree(dynid);
> +				return -EEXIST;
> +			}
> +		}
> +
> +		list_add_tail(&dynid->node, &drv->dynids.list);
> +	}
>=20
>  	return driver_attach(&drv->driver);
>  }
> @@ -780,9 +787,6 @@ static ssize_t new_id_store(struct device_driver *dri=
ver, const char *buf,
>  	if (retval)
>  		return retval;
>=20
> -	if (hv_vmbus_dynid_match(drv, &guid))
> -		return -EEXIST;
> -
>  	retval =3D vmbus_add_dynid(drv, &guid);
>  	if (retval)
>  		return retval;
> --
> 2.34.1
>=20

