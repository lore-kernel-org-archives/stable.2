Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793703935;
	b=FgFT75svxqjb75tCoHDsp/cd4V6z/nXPV1cFhh688pdljV1IxpLOMK4e3MNxDLMYjYR0
	 3Ik+RDtKfDxBD5lMJbTk2HLNWl7D04O9t2BTlfI4KU6y9E87dkdc+xT12yKMfSEFXUTp7
	 69m10v6fsx/ecRoDTpA5DYFLquFa5OJb2qD0V1yQhrcHu1Jp/+vcerORtlOUvtkL4cvvr
	 0OT7+vrx/Ept++TUG4+XeuYUmH7kQwZwa8UNELU1A/3jjml7+eHHS6SZESg2ucXkqlgz2
	 OVHkaEDRvVOYZ5N/DQ6S0F77wpJgfDXWy3mBKtP+iauaKAhK4ONXyUAv0Bg7GDm0flQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703935;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lqyP9znsQRdwaRYsM/qRC2zMR6bDJM+e2NWUwALCoAw=;
	b=uGmCXpMx4VSU+BiddRQq5xSsvsl+9R1Uvhee+JRK9/6coyF1lAwV1dCKy2NHWLF8l/fI
	 BvyqVLaqR0Kp/JZJbNC6tCpIzP1TzGbvJDUDWFQAYpJtDTxQv/NbqHgEVG1lbfBKyBnUJ
	 lbEfJjwKzsNblO+1DVk7rlURLm74x00nLqCHWGvB5lsU9ILVrjbXocVs9V196Ey1/pv7E
	 WoD5TQlhdmhfwmk4hSqbzIyPcCBNgOSzVwNkgilcdaQxZW3+qw2Vhhrm8i+Gfs8g4GoN9
	 3GwPVTciWC3j0IsHv7u/u4hgwIpkgx7E2rWeV6L5DOR3RMXRxACFAn3qGO/tc1hVInw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gaep7FO3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.10
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DA606BF8C;
	Tue,  3 Nov 2026 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC0DA606BF8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gaep7FO3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZwcSM8Y/Y6i6H5PtKjlADwCOqZ8CBa+0lfQZk59fHDl4O6ntjfOzRq+O4M5HmeaDTw/HeKhRaSk8nBbrDFYYpp9KAFZfu7mbSqMacyO6AzEYoP9S7mkPUgPE7kKYuNGHYoqZpZ4AiIwZYO/D7dtjDRNbn9hUZ526VSiAcvN5GgkgIz+h3sVVfEkmum7URoyYrywRSXje+sJeAu/J+/dAmln8YfQZKUYckwH9/JLdOfL/rsN2begaEdXu5LR7uCwkjPeNe4sUpUL4QmSUH/+u0f6WTli3LrP9la0ZzRVMIoLcXE7ZKxMO/3PFPAqGq6ee9GhvVcbqEaKUhoQzA/siQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqyP9znsQRdwaRYsM/qRC2zMR6bDJM+e2NWUwALCoAw=;
 b=d1b4Sr0CkWrUiytFL9bw5A60jmNV8NImIB+HPvwm0vf9Fcz/Wrlf10ZLtJ7C8VrQheey80HCupp4TTWrmHtGef/xUThneULTrbmohMf+ofjbG0RGQGYyLkKulEXZYKy1VhpLGVZMkvUWoJt99bJCYCd/V1qeAwG89fQEzrl3RkZ8sEZjAdjSpm64i7Zujm59a8LTh+Hiwa8Jx2h4EOAEokuZ9mLuFNPnwRXmBgYWdrh+BX2nqwJLLqAhmd8/Ry/kpPDNlyKjtH8lSTvW99b/bj51SRdeZK2zVMiXKLSVnS4zS70Xsb15vNnmKNTweqih3hL+AB5YJP2qLiSnOMV8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqyP9znsQRdwaRYsM/qRC2zMR6bDJM+e2NWUwALCoAw=;
 b=gaep7FO3quECL69iCTl3DUrlK14hJm0D3zz04/anrC+w22NsdZy2OIAeQVFRzOmJ5pzZQmTf6Wq7KeoKfL4FK6iKUIxrWCrVORS0wLSswKFldcwwCyAtgrL1euIHw9Yy5XmsFHzO5PpkfnZVWiQjP/d/NITWxsnZtBzmY5kPoo+N+szWdAOt+mdGDk6rd7FYL84zA3IqbkGx+YUhIo19qhLiv7ssKgBQNtdtXBHfKnIDEkeXdyR7l8jYmZqRxoEnUdUnSE9T4OgKGhk9Xw/6pH346CwEA7Gvlp5VbAmdbXa2K9ITBLo8mOeudCnYSo4Q4y8wu6N6UZwTHBbu5GKO9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by GVXPR04MB10235.eurprd04.prod.outlook.com
 (2603:10a6:150:1be::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 11:05:31 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 11:05:31 +0000
Date: Tue, 3 Nov 2026 13:05:27 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] dpaa2-switch: fix port cleanup on probe errors
Message-ID: <dxi7unnmj4n2ge7qv4hucyiygobwcbm6tool37eejrhczq63b3@lycuwgvixkhw>
References: <20261102071310.3004332-1-lee@jaeyeong.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102071310.3004332-1-lee@jaeyeong.cc>
X-ClientProxiedBy: AS9PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:20b:46a::24) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: 753f9edb-a804-482c-6855-08df399a6059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|1800799024|366016|10067099003|18002099003|22082099003|56012099006|11063799006|261021123027099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|27256017;
X-Microsoft-Antispam-Message-Info:
	IrOcdAb1QPLqZumxlXy48qgHGQqQ+/GlvTZcNV0INH+fr7i52jymyejmpkmhZdARVEyLKrPtP7sQfgPqEY2mC5O7WYBUDGZLJAFjp4/JXGVh1SJCNMlFyO6id6Q8aWGBqjJjtJyfvTwDRy5b7LK4J3Uh4eGyXGrgmdZGUTskErHD/iNyjMtYEn1Mfxk70BsjkeqXlW9h2CR72UVCqrYngidzmCA8sivW/5HNt0u/5bmWYQ8mLBn8h4zfDn4iWzeAW7ZVX2x9VTJrKf84KVHEE7TMtbfwBuFZ5H1CvmyfjiuX8RexQZ3T/5A7ETdap/kVLtLC5Cayz7myYTnA43+Fl48g0qfROyRiEwStV9ixQJZvqO6VcWfvqkvGK1t3qJqXkOmNWkm6+KKCcIKYo28rexMg1U+AQ8pd7DWQT4g43YdwY066MpSPNEToJNT78ol3opm0bNXRBT9+l5mWtXzfRB+uupUGmRyYLK2f9s2r9IA007RXyU4NlTWOnQPyC/uy0MFHzJ9Dc9ZihU+5F7rskKceiAbnTZBAfJcIt8gEnIBQeEAe/NqXu/CFMPCU2YuyhYWcg0B07zl6ugH2Um68GZVsx0QeSm3Rehkd7gceEwQfI7lj4cB4oh/fQAWmxa1gZjRvZFJVjFzr4LcxkGrpWWwHWwR+ROnUMfeMgXsTi5nSnWQAKJd1Btb6ucepH++ezwxhDwtjbTfyP7ONFGf14w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPLF3suYnxDVVszewCBK9npdfxOc3mG+m/ekMn+z/leZtyxUhbdnl7atjOoi?=
 =?us-ascii?Q?Cdt5CqXJZre4xHwnv6TRLtie4vb+c7dxFBLsQZcMCxHRG+uw91mew1rRQ4GD?=
 =?us-ascii?Q?d4JkF8ULLr5vuKlIgCExL+6LAScE6uiUTQrEl51VClbNCOkqF5VO/gA7j/P1?=
 =?us-ascii?Q?jxqA3yF2gxUt9q4ATkwNFYGNJII9Vqs381l0FrYIkrbNNiT0zRyhEYrxkmdK?=
 =?us-ascii?Q?P6OA4Kan1D1CzRapTbv6kMzb4zlTyJ7AzFFj69qtzyoDWvGJ37w4s/e3lt0L?=
 =?us-ascii?Q?02branknO5CbCPEHnN+nlCCyT/oF8hBO+SFoASYoJ8G1+0O2VS20akIMR79k?=
 =?us-ascii?Q?6CcmcNyOM+XXCYTRI9eVripwzq6YMl1/OLthzO/ROM++uvI3VJj4wsykOllX?=
 =?us-ascii?Q?56/EeTEXGH2OruskPRsdQo39XhjJZ+WRac42aRh81aEcOf/LMuJR9W4cqdKJ?=
 =?us-ascii?Q?DAfp+RqhmKG/RZFE9D6JdY1tk7+coUqSS6d19QVq07MnCiVgEhzrOSASas81?=
 =?us-ascii?Q?4fwsc4cd9PWoKtZy2SfX1Dj3efCPhMcw8P8ctnTzl4PtRC2OSvxMN7XUlqdK?=
 =?us-ascii?Q?Z0RK+vy/cAmIkvnI8hBs1Nb22t59ISYkHM3Csyfk8esTK3pUaCzadh+CBlhg?=
 =?us-ascii?Q?Slb9u7Q3u2um+SMtHvothXgu2g6YOxChofZAohJSshaHmfT6I9sfNmTCT4CV?=
 =?us-ascii?Q?IphdpE0jtTY7ZAx+byUDZPun/sxuQi8nyFu7WfnQEyMxK75wuQr+sd+KQ0yy?=
 =?us-ascii?Q?wTubKSFydD6LBg8k4CKlBUAjh4RLpB5mIOEsJ+iUJeX+h5HdO44h51WIOQGy?=
 =?us-ascii?Q?nvcBgFwlc1V7tQ+/suuP9ObZr6L6R9xfPAtu3hiOG1c5H9kbUNCaACTBfd7c?=
 =?us-ascii?Q?lA5FpX20+5pNQO0Fr57USDeECaoh2fAP4FeuqPo7QeSEkfY++zmzJQpaF8zr?=
 =?us-ascii?Q?+2HSoydds6TlYfNHggJcml9Xxfs2X6fjH9y+LognyZVhjnCBduQSbtVrsAO8?=
 =?us-ascii?Q?30TsMgq1R+8Kjt/LJgRbUASW9ClLeakiGA/IuUJ1wkQEZRP9c/xneeme04Sh?=
 =?us-ascii?Q?2Ki7SKkFXEYMu433E39x6G5Odr21+vTDMk/Is60yU/LeAa+tjN9O1ySxun72?=
 =?us-ascii?Q?Oe5Fae94XUIKfOkxePXKLiikuAa2pWKkZ+hAtiON+0FJuXLNZ8CeDNhs31aC?=
 =?us-ascii?Q?OxbFYsOzo5X9ry7C8Vkg6dnzjUha+zOWXurZ1QkZngrcmsrXmPPr6zmhd67x?=
 =?us-ascii?Q?TpSipMQVwWaUaYRr70OYIinG6bmOLh5igMBWHJ/Gu3CBpNwMMrr9gQwGH/tA?=
 =?us-ascii?Q?fYqh9KO9dwi6TGYg7bMeYMiyhQ5iHH0Ix35R9aS/HT5J8blhxKIYCY3Vye9C?=
 =?us-ascii?Q?fHOIkTGJMMlffKXYY2beclwruCY/cwSzQgU/ZLDuXLOAjeLUkVl7BJUHV3R6?=
 =?us-ascii?Q?7wvLx7VoMOUJkdnE1kd1BhaZsoh69Iyg/BploN+iqZn9AcUAbAagZjml3Aqm?=
 =?us-ascii?Q?WAddWZn8greTPhWcIZexudD6E1OGzphCdYHLEAax2OBIvndl/eJ1SuOuGuDn?=
 =?us-ascii?Q?Isoh/ci6vR7xRSNDbUVij0t0ye8Y6YS3/Sa/un8r478hHUM+TuuzgIjyiGXG?=
 =?us-ascii?Q?I4NoMQbUS50CqhIunWkSQCNrZgrsKtob1FY9S7gMjJw21eV3DsP1aPlxyai6?=
 =?us-ascii?Q?1qAiE4bCPit8ZIMF0xfU22a03DLXzURZYyVvt0Eo2RuqesJTtdejoduFT54L?=
 =?us-ascii?Q?00cAwMv04Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753f9edb-a804-482c-6855-08df399a6059
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 11:05:31.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+bHVJhSO5fXabEf/P2IOR5tJ85G4rzxh1ZrlopYNxL5+GSooSdtXFtQfIPl86qMLLUmx2SgznIKYdRraUOiPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235

On Mon, Nov 02, 2026 at 07:13:18AM +0000, Jaeyeong Lee wrote:
> dpaa2_switch_probe() reuses i while probing ports, adding NAPI
> instances, registering netdevs, and unwinding failures. Consequently,
> the value reaching the port removal loop does not always represent the
> number of successfully probed ports.
> 
> If IRQ setup fails, i is left equal to DPAA2_SWITCH_RX_NUM_FQS. A
> switch with one interface then causes the unwind path to access
> ports[1] out of bounds, while a switch with more than two interfaces
> leaks all ports after ports[1].
> 
> If register_netdev() fails, the unregister loop consumes i down to -1.
> The following port removal loop is therefore skipped, leaking every
> port netdev and its MAC endpoint reference. The NAPI instances attached
> to port 0 also remain linked while their enclosing ethsw is freed.
> 
> The issue was discovered by a static analysis tool and confirmed by
> manually tracing the probe error paths.
> 
> Track successfully probed and registered ports independently. On
> post-NAPI failures, unregister only successfully registered netdevs,
> delete the NAPI instances, and then remove every successfully probed
> port.
> 
> Fixes: 0b1b71370458 ("staging: dpaa2-switch: handle Rx path on control interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

