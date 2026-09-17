Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746274E2F0B;
	Thu, 17 Sep 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647574; cv=fail; b=rVFSkqi36tnMv5nMrwqzHk3xqYtwe6/qeQE7R7w7MtI0ouVNiKDgdwtDvTQ/+tVPekoNl0Tw92aDeKBIVHW7dG+zTzXjcL4RiOXYqOPcfqwJZZ96Uc9U6QGjL6AxnfP0+j2N39aHByOCkihlV7gcyH9mnlxXqpZsonITDy/Imdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647574; c=relaxed/simple;
	bh=sX/tLLv2i0LwA6jF3sdaBxWVtFun4YjVGFfgSRVLC4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIpZsSFZ/M41zFPnevz/TLKl4Ir/XL6HgGSP7PNivsyA2ol6DNcyLkRh7W92v+5CCKDuX1ukhVouMSUedY9Dq+p5BQa4F7R6ioI8tuHVyw+GGoGhy2+3SQ0S+n0+4kw8QV07cjc5PXdRuLGGCvFDRYwLZlsdoXLg11g23/j+ozY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Y8pba/86; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Y8pba/86"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9dcRO496973;
	Thu, 17 Sep 2026 05:19:01 -0700
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020096.outbound.protection.outlook.com [52.101.56.96])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gqqujrcpx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 05:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0C7DYI/2YJp+OzmWJfKSyf1mQoo74JFKZVMausITUh3Gsnxm0mZjtx5NLxBhRTAGVbYziW2RBqOW6xOI3uZlodLVZwnYqR/0nkYTOrrYo9+xo2AWYfPy5F5ftoVAtLe0fAf2zsW/eqQ2DHK+LNzSinstjNSOnN3goH3SQw+xGttE44VJjbRLsU69n1HSHG82/j9UNTwgh0JJIh62Ak9OVdepQgOH3RWFy44aoWNF3Azj3sbclx8xKzg2PLp3u5CCxqDnfuanoSYLk+x6ci56kgZzX3aLxAwHk6CwdMD/F6TF7tyl1u8ijuuSGlPhxX+GEcEHnlMs61pLZN/e+eK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSE3SNcrw03rWa+Zw2tfyOy3xJmX1EoOltK/SEGzNl8=;
 b=KH6sBI/3Ad9zLDb9yPYzNdVyQdMQnQh/hWTGHxhNt1oNo9uJqj5T9Fir+ZfbvLxdvqMYcFlVzseoDdnN3eeFwjQHYVNO5VFlIJb98zLLyOm2IRnRw5Qs13Ut8KDzXM6YNHzux1q/95LjaFryuGPfB6GTpbJzQPaun4kEquSgdIVQU9SDfmSOJadrOzRncrdDQSXHTsB4NQIWlKH3z8clv8lUuLYCDKtRGF2PxUuD9M8+jMGp2KXg6nZa5kJ5suVgE+1R3Wcv3+fcpnRCTXz6RUMbC5a75/eBhNUq4wpgBpZzAx3SZdWzSX8MqdxcauOo1W4P24e9F47VUxw73EwUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSE3SNcrw03rWa+Zw2tfyOy3xJmX1EoOltK/SEGzNl8=;
 b=Y8pba/86ZbtQW4HjDY06pu/7GcLlxJ0T3CSEa8KTEOUFgpfdC/gR7R+ieDjlilbR4jsIoLVVqT05wtXYKENIubIqcrLfVmU4wUI9hOvgZzeqxqvtzxO78H/8MycMigVslxJIWkQ7JqYqueMputOnUpTG1W40mq1CsMlHb8u3mgg=
Received: from BL1PPFB0715B38B.namprd18.prod.outlook.com
 (2603:10b6:20f:fc04::dbb) by MW3PR18MB3484.namprd18.prod.outlook.com
 (2603:10b6:303:52::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 12:18:53 +0000
Received: from BL1PPFB0715B38B.namprd18.prod.outlook.com
 ([fe80::d72d:7d68:4c45:cc20]) by BL1PPFB0715B38B.namprd18.prod.outlook.com
 ([fe80::d72d:7d68:4c45:cc20%7]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 12:18:53 +0000
From: Elad Nachman <enachman@marvell.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "maksym.glubokiy@plvision.eu"
	<maksym.glubokiy@plvision.eu>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH] net: prestera: flower: fix ruleset leak in
 prestera_flower_prio_get()
Thread-Topic: [EXTERNAL] [PATCH] net: prestera: flower: fix ruleset leak in
 prestera_flower_prio_get()
Thread-Index: AQHdRpX0ZuwNSln01EqDBJUtkhkoNbbSr2eA
Date: Thu, 17 Sep 2026 12:18:52 +0000
Message-ID:
 <BL1PPFB0715B38B44DA1B3829001C682744DBB82@BL1PPFB0715B38B.namprd18.prod.outlook.com>
References: <20260917111603.2148710-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111603.2148710-1-vulab@iscas.ac.cn>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PPFB0715B38B:EE_|MW3PR18MB3484:EE_
x-ms-office365-filtering-correlation-id: c2a39727-1e68-4e00-2351-08df14b5d680
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|10070799003|366016|18002099003|22082099003|38070700021|10067099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 99vDKa1j6skW7qYvM66LrkYkXoZFIe4NlpVH8KC27Y+xU3iP8MTVeJb3lblHSbZ3pEhfOpA5musAbBI64uU3TlnnvPnYHzYQPJNiUaZmV2TkvBxUagSMWHojNrwb78jCAxbk8xV002GHAbNHP8xMGV+CXKUYM4AxbmiRIXCDNqUXEq3rNM0ghHlNGA7g/zmm03IN6Q5xBxSfXrG+4Uk90LkFQCBtqgjXz3OXVgPO9iEETofwZiPS09o7vzXkPGRft077xNjrn7cB/WNeh6tkSYBSjLWgdelf5mOUzq847YcX52q0DTdT6s2Gh6INfV+7JQVhtnVmIXCYvs+LYIh9cO6EU+B2uBov8GiouIQccfxNuqoBG1X5xgEFyqvtddPM6djNXXCih/O0tacubNn6Gz5NwSkitqq8h8Ytvt3xq8Oxy0hOZZ+vR7n8zbz5OdeIOsG4GgvqlVVRMbLJFwd46MHsq7QtV+bMkC3E/HnaqS2EZenHIFctQ2McPFt04giN9Rvp6tHpabbUdGlgBxV/XUkbLHNfVRQcX64eeHyaIaA+ygPqOwheqkarDbKP2mIDNmKjWS5+pNgoXKMZoFeOiONM2A79AJPmHhPf7jSsrxIq+5yVA6nOOBPbhFIYmjYlrg95nQ5aSnNPIe9P9o9KfEPLcv6d+W2tvZgpm2bmihaiwf5KMALDKgpswvvy+mk2zIY0H9dVE5iXcLp2fq5JbvgbM7+G9YeDq0D19jRVtTM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PPFB0715B38B.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(38070700021)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2toqZjdFErGBMYLuUQAuVirxq7i55xKqSoLVVrxqPy/OwuvRA/0lLkbyHaWw?=
 =?us-ascii?Q?N50Wseb0UB5f38T/Hz9CwPI8fNH1s2/t/fOe+JQv0tgX2bJAFAtEBosxB9TQ?=
 =?us-ascii?Q?9vGJrOoahFDZkqaM9TwR1ZqTNyb5QV0E57TA67uX1Z71NitHwwuI1h4YmUaq?=
 =?us-ascii?Q?h04LtYZcZO/VjUhflTcZJQxXT/NUxmKJ9MQMhWrpauFGv6jZG2JqCxkbLKSQ?=
 =?us-ascii?Q?NwcgNDgr1rKdZKth37sy3IolxKBlj+PTHHs+PRm1hphFIzTgHRqKIAFKgb1o?=
 =?us-ascii?Q?vP7NvkbE1lCQkXi0CUnu/XApdXI2F9sSI0mC7XibJoI5dct3x+LhbJFD2Cqb?=
 =?us-ascii?Q?XJ0nVehQf4+jqGxy8+Pk3BiJgGj6l7KFnyolls/80nz5x3+cK2dOheXI8EC2?=
 =?us-ascii?Q?2ekiYv2G9Pyo6R0VgQTpMEgDHFNfDFUiowwBlO8dDZpK6i8Ux9uYm/VcG/kq?=
 =?us-ascii?Q?Jaib6aI6dk7PZvN5jWB2ewKDGLDTvwEdn9Bm7p29KDjIWTz5buPMQKtuIEI6?=
 =?us-ascii?Q?APfUGoH7HENhCRu0dDltRbJ3giUbJHu1FlsWHkuP0G5zlox51vFQnkhtZtn8?=
 =?us-ascii?Q?qc+1mB6c17WmgDUcal9dmZKZk/07lJQ84XXkzRQi3dFW3PbQVpboPex5PoWF?=
 =?us-ascii?Q?jdjFVuU2kMV5sgWT5xe6T5UOR/BuXW0YHAdnPsuJ67SrRQ296b1KZoYotUFc?=
 =?us-ascii?Q?pWMeMZ8g3f9ZCn216C6Jhh1L+TXOsC57BXistdJGb28nl2LzZ8NGYC0qe1Tl?=
 =?us-ascii?Q?JK7gVNAhV91EcTm7ktuMQKz6gjWjJArYlGxEbWmcJ863Jr8z8EoutMvQXUnr?=
 =?us-ascii?Q?OD3QQZUc/x6G4+Dvxi4qCAGz14zmq6r3L0OfNmhg5r84JEbmW29MFegn7fg8?=
 =?us-ascii?Q?Jrvj5q9vcN+thw+bor6LMQQigidWz/iYxBHOlQzCY915rZUXYdjWLyaj9eWF?=
 =?us-ascii?Q?YIPEHimNF8Se9mSEqsMp3YC9UWzXwHtoF7U71a5juw3Iwoq0owZrB6RByeoe?=
 =?us-ascii?Q?fCigdjsV6WdKaBxY23zUyoFcSl3QzMSs9C5A5Wlc1FMU0RAtrXtHsxXfumXq?=
 =?us-ascii?Q?K3upNAXYcA0SeEmlZ+Z2uObhrPmVYCMWfYC7GOWgjZGQFSorC43VTP3gtrVX?=
 =?us-ascii?Q?y0WnDQwie9XiN/OIeNLJHOB8piilMEQPF8ruqebUIp/LtrAf7xJjAsEcBhHl?=
 =?us-ascii?Q?hxowCGwflN8wycsAn0e+5RC9jK9G0tEqw1h9lMwuXZ96bpVT3Y/SERZnxoPu?=
 =?us-ascii?Q?0cSooxx6PfRa8TnvLFonn40br050ApMwP3WYIZakYzIIf//M3CSnhXpOTtXK?=
 =?us-ascii?Q?NBreqWjCIZJ9UcSQOg91CgPWRX24by9K8QHdlU8xIE/9UTtmICZhRae4dRyx?=
 =?us-ascii?Q?qiLDviXesD1fPD01Y2Fr5a6V+bxtrlsYr0ZDl6vHk2GJsemoHBOJhy3Bkl0I?=
 =?us-ascii?Q?DGR2q63v/SS6ggKX0JaE6a8HDMXDmpWOknhBCjYuAOb8t09jDOzJNEK8xAIC?=
 =?us-ascii?Q?TTPWN7BmdFdUQdg3Wf5Jn8RlKTtDAonaBC3+hbXlapWpKqvjmjgpRZaQ8Jdf?=
 =?us-ascii?Q?sQIdigLBnnmKXAdPfubrAKjaRxrHNgLFjKv0XxEC9OcsatGXwZwc/EbavfJw?=
 =?us-ascii?Q?5Hr2W531Ne8kUBpYMWEqlohdh6xzmx5djf41mVzwUk69+IcitPxIt6qXj1DJ?=
 =?us-ascii?Q?LngEZrArByZ3rndQXncX/Ub3POd92YRsuqcP5a0YlaUMDEAMDfz5k5YIV59A?=
 =?us-ascii?Q?lzn+kJS6KsPMvLr30Lu4BFu2LT4WLH39oqQLupDznZziWPE6SRgcRc6LS5H+?=
x-ms-exchange-antispam-messagedata-1: 4BdH6YmLxqiHrA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rj0lMiqwH3qtccp1G2scIi6hPsIEs+zJ2ysUx58YOO57g2B7GNuZKhAQQ+oaD3s70DllcrrbNwZNXkhTXbsZ6tAcxHe0PF+8fHIP6VeK2RPD68abW3pD6WYAjxB+v9Li9f5GCnhD1O1Ap6Fi/a6SyojvrFLDk9IJwV6VruTP9/puL5q1biJXLgDMmulGlznAHDigoEut+FFgz3POCLi2I6LmdjY1mRtq8DIZh5qZPqUEmxHW1bDf66mE3UlUYkaVs8OpftuUK3UU6cgVLUHqE2c8ilne13X9B+Ht0syw79PX5CMsCw0nH8+LWZrym3FoX+opGZ151NzmJQ1L8lxDYg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PPFB0715B38B.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a39727-1e68-4e00-2351-08df14b5d680
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 12:18:52.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnxn/moslyP7btA96yybdIujGjuhkpx6IX14I6WZ5M7U37RtVWAqXU3vnTTNH/Q3h2+9A+yJ9Jv4RsW2Xfz2JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3484
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3MiBTYWx0ZWRfX5zA5ntxWgkjr
 qDNSb4ZhWn30UnSIOZeVBDr+38Fq2a7mVg6/hYb4HympOgvn7JZWq+bvlbuUe75PPrbu4lZesAh
 29HcSA34AJtt/xsQf/nKwy6MSOQNnWGB8ufeuhOIg0W1sMvnrb7owBRm5kjLWbgP9T9XvqRdULx
 D7RvIR3x4NTAd/90ioa+JJzULMWOn5m2+Qv4vren+nm3aA4A1YnWIMrYDPpXnKDuw4PbdYCO96X
 37lbiAjlJazO1YRXjP/N1E/UDO9aaiWDU+FaR+8rtuj/tIinTnOlO0mfwspSQg/l4YcS86AEvvD
 dVEIV0MuPxGer5XjL7jQxmu4/8gLIZj0gCHKuHjBJLMrrLje2p+Vw9byzaU6kRde8ZDzLhWEzcA
 zZIGcYsp2k7YDnR8fqVOdw6mAu+klDGx2ZAUbptumi483mFK7C4gDE2EKOJgIpnCgN2BmrMXqts
 zSQX3o9Jaw5wXB2Foew==
X-Proofpoint-GUID: rppCs3IgAErOoKbTKLkRG2GT_b-0UEXw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3MiBTYWx0ZWRfX51d2h8Ii9l7m
 mAO00pzq2N4RHcU6Ptmo9KiR8dojpLPycG50VCKLjvm1yy4qz+8ncbPwCRzcsZkBPHiSd28S3kC
 AotBZdiY5r1FFcdPwVrS67+KVvIUlSo=
X-Authority-Analysis: v=2.4 cv=F6LC5ahN c=1 sm=1 tr=0 ts=6aabdab5 cx=c_pps
 a=NO5CczpcTQW1gtzKHD9VpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=oVJIqqGrwzkRX3ny5XwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: rppCs3IgAErOoKbTKLkRG2GT_b-0UEXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01

> prestera_acl_ruleset_lookup() returns the ruleset with its reference
> count incremented, and the caller is expected to release it with
> prestera_acl_ruleset_put(). prestera_flower_prio_get() only reads the
> priority range and returns without dropping the reference, so the
> ruleset is never destroyed.
>
> Release the reference after the priorities have been read.
>
> Fixes: 44af95718fed5 ("net: prestera: manage matchall and flower prioriti=
es")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_flower.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/dr=
ivers/net/ethernet/marvell/prestera/prestera_flower.c
> index 58b116cabd48..10d7e149822b 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
> @@ -411,6 +411,8 @@ int prestera_flower_prio_get(struct prestera_flow_blo=
ck *block, u32 chain_index,
>               return PTR_ERR(ruleset);
>
>       prestera_acl_ruleset_prio_get(ruleset, prio_min, prio_max);
> +     prestera_acl_ruleset_put(ruleset);
> +
>       return 0;
>  }
>
> --
> 2.34.1

void prestera_acl_ruleset_put(struct prestera_acl_ruleset *ruleset)
{
	if (!refcount_dec_and_test(&ruleset->refcount))
		return;

	prestera_acl_ruleset_destroy(ruleset);
}

If the refcount was one when you called put, this will destroy the ruleset.
Did you verify that the refcount is at least two on this call to prestera_f=
lower_prio_get() ?

Elad.

