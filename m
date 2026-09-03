Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853C1F1932;
	Thu,  3 Sep 2026 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788479098; cv=fail; b=TkiMQrxMSFN5Ys7osY5fj0+j7HXQ/gPqnEsfcvJ3Z5rF70fvYodnF0+51D/4u3JQhobv+exaweOGlWNzHQvjddWLkTerCxH42IwVbQfhEJA4GkwHW6ZSYa8IqpcPDMf57gda2Z8mJkXCeaixzh35/efvxh8/uOOYUbZeNIY7h1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788479098; c=relaxed/simple;
	bh=mAdM3sbm2a9vpcuv074hrfRDamT7kRt6q3O+k0Ip0ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HBakigcCNMn5zaCKtNkXNFmsJYbQT56xmk4WBMy4DW9Fw3U4ISZdgX5FmXP8mzXBxV/yu2gHpBdPzj14+xNh0Eou45Mbi7PQXRaNrGEOlYwPMpRGa3uywW/ciKbRbPMeAKh98IdGh6MrZzT4xtniOZsWy/mvdrGoL/SSufUKb7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=fgsJng0s; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="fgsJng0s"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683NgWsu4147040;
	Thu, 3 Sep 2026 23:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=mA
	dM3sbm2a9vpcuv074hrfRDamT7kRt6q3O+k0Ip0ks=; b=fgsJng0sFxBCfLayO5
	vEVLoM3cfFsflWqWxjRSLX/lFclH6qxCWAiV6zidi3fKPUllQkfVCY2CG9OooIXg
	Hm2GWm4qJLPNrxUnK2DDn+19d0y323oQ5Ch8R9tBlCviByQ5fJBuYq9MG3w9o9jv
	6cenO8S3RZzNbyaRth07a3W8SETLxgtERO4HaE9w/Y8sTVAd+dfg3reLDfnlr3pV
	f/gMtYqMvj1cFP7Ta7JFQ++3l1k6vSDp37/HhWZwSpgkzBgN6c8wb411VYroTlbP
	xQM83doNxl4a9EQUDJ9JCoyBu+yF4Pb8TJ9jvBgUZE8NElGaA7V9YCtJ8KQ97Iix
	KAnA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4gfd124x75-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 23:44:38 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 992BD806B1C;
	Thu,  3 Sep 2026 23:44:37 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 11:44:37 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 11:44:37 -1200
Received: from CH4PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 3 Sep
 2026 11:44:32 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZx7YZ84JIk/xuXyVYm54ns3OS9aoh6LVaIwcFqbSlRchiYdU0VtWcUu87prHnFGktL3+jSm5/KEHcSHlWL+okWqSeV7cpB+y2fHjDYh/JgnbY0GUIY5xaunZnI/uNlrLxvvefrhEwhs2C9o4m8lnnNLpVVvnCLdYsBV7ZCCjsjOuVJNCJ8o31/7iYJQvN8alsJ79fh+3xpoGenNSQK0WCdNNi5on/QnNwjhG78TQzlmbFSEjja3ccCtq0grUwEAcyxujGsweWBPPISRz+0nNeYvva1Hjj13ZpOPk4ELpdWzsKuarCe6TbSpZI/xdhgaV6nLVMKy75A0Zlv3K4YZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAdM3sbm2a9vpcuv074hrfRDamT7kRt6q3O+k0Ip0ks=;
 b=CpfEm/I/7jK9iy/eNJH27rLeTfipTZ/n1f52mxfi6gPIcJKsqoA1QdhWY0xZpKS0cA0exqH2mNvS648FrN2enwiy5cSB8Un4f4kHFennC+IhmJYa8Od2eUZ0MnXtOuJ9ol3TQ3JbgWmbIzi2ULnjYfi1yMX1bh2jE78WdIceg7Lc4TBTHlbUL9COnjgtC9w8+GMiCQ1vEyVVOnyUBu0xxt+PVe7NHUcvj3hhr9ML7BZvPT9GTjyNCaNw/qCfg3Pke8rK5Qujf/4xbr8iiAY9rOqqnKgc5LEVnmjB7nj8PQupJUuwByiYISVRz7aP1oC8XMNi8ZVabNVWrgRrK7TZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by MW4PR84MB1684.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 23:44:26 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 23:44:26 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: Peter Rosin <peda@lysator.liu.se>
CC: Wolfram Sang <wsa@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Patrick
 Rudolph <patrick.rudolph@9elements.com>,
        Phil Reid <preid@electromag.com.au>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v2 1/4] i2c: muxes: pca954x: fix cleanup ordering in
 pca954x_cleanup()
Thread-Topic: [PATCH v2 1/4] i2c: muxes: pca954x: fix cleanup ordering in
 pca954x_cleanup()
Thread-Index: AQHdO/4nsGybx41udUm2oPHetJPI0A==
Date: Thu, 3 Sep 2026 23:44:26 +0000
Message-ID: <20260903234410.1896930-2-sanman.pradhan@hpe.com>
References: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260903234410.1896930-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|MW4PR84MB1684:EE_
x-ms-office365-filtering-correlation-id: bb9d2fc1-a723-4b86-0854-08df0a154a35
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|6133799003|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: oz/AKmTY2wXZ8tSRnkXGf1p3y45Vy8MstBmvuFM2eU9eIBwuH5yR/jrRTKNE9yNdH+ywTy0I3AZC2TaUx+JtLb1B9MPGSpCF9d5M2DQ2a+gQmlqgp+kWD2emJDAckQxvwmcjL3FO88abeJG4T8bUSaiHA4vuqNNE9ubSugMf+Vi/1QaRbjvKBEpwyT7SSMeDvAnLuQVkmULR0YfQqFcZp/Kv76/P8F03JoUNYTHYvi8OwcuMgpQZaIci99HLVq6+h6TzD+9vOq2iOj3mE3+/bKptJR3Rd7w6aio9mvKjPZTQ7b4pq4VxRedU8Imcx6lS3804G3raDjx+R3xWLhw15TQ2yx1b/QVY5OGPF69/AjFOi+KfwtTekPn/eQm0YlknqGR5kr8j8HPocQibdfCsooQlhiE7cuFugv1ki2HNFwX3Cc+eeFQi0NvzLwh/dQlmPdo7Oy/evU8zkp2dvVTGwdCIwPm3JDqKrhXUU+Fxhumme2UYXaVtfWBtx33Tu0HhvuW7I65kh90kEraFhCIuoUS3rIl1BapdZG7bOXnhyGqClapSYoNdOqjsrSrnuVmpom2KkxOxrURfAJSE3xGRji28KHLxEADuBki+dBY3w9aXYj3jpNsGvsd1HCTXAajfuFe4Jyog+zj0Tzn63ruuM4mr4EOPE1xKOv/jH+w7erJd3Ak9omOPSJ5Ymam0vVHE19OITlnkBXPwx3y8IkSIYJHdusNueAWVvz2H2+Xilj0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkF6akpzY2ZvL2loQ29vSS94MktHQjJYdFB4ekZ5NXllQ2RlSXl0WGdKNFFx?=
 =?utf-8?B?RVlEa1dVRUZiMnl2VHBZUThBYzkwRTVuc3YyVmw3K2hPRmRGb1VXemRvbjRz?=
 =?utf-8?B?eFNObUZWZ0Zuazh6UmpFT0lRQSt1clU4ek9zSG9PZlBaU2psZi9aeVRXS0Yy?=
 =?utf-8?B?a0tzRFdGcWdzY2VJTHBKNWRGaVZGTERJOHdKVDZkOFVKK0plZXEyTStEaFNV?=
 =?utf-8?B?VkFzZHhsVG9XWWR3SFBKNFlNenQ0LzcwQjdZUjEzYVk4UHNRU3hHdzFic1hZ?=
 =?utf-8?B?a1Fub3IrRitJNElNZFJRdTBGOUtvNi9ncExZWmtyMXJtTVlxbHVUa0RPRm5r?=
 =?utf-8?B?Z0pKS21TbGhRcC9VYm8yRitqNG1GckIxYkxEbisyMVlsRlk1RS9iQjd0ZVlF?=
 =?utf-8?B?dTMraTl3YUxKbnMvdzBNSWpBYkR6YmcrblZIQlVmMC9OSlVyS2cxVVV2bTlM?=
 =?utf-8?B?Rlc2NHlaeDBrRHRNM3N2bzBJUkM4MWp0M2t0SmsyU0NmcGFKdnhuWmFHN0ZT?=
 =?utf-8?B?eVN4UmpjR2FWN0k0ZHNoQ0dzcEZnSWlRNzRNS21wbXN1K0dQS1VsQTl2d0JS?=
 =?utf-8?B?dGRXYlVCeGt6QysvaTREVVdUR01YdTJ1UUM1Yzh3ZHRUVXM5OS9Ub0laa3Z1?=
 =?utf-8?B?Zkw4QXJlOVl3K0plWmVtVHp2UTRjeTNEMFBrWlhQZS9HWmNhMURMUDh2TkdC?=
 =?utf-8?B?eVlWczZVc0tQQldSR2kwa2drR0RBZnVUelpocVVxdnRjWi9uS09kSm9TM2NW?=
 =?utf-8?B?Q08wNUJ4TmxIN2tta2RibW1pYm0rMWFNVUxXRW9SR0dmaDhwUUdvUmxYbWpJ?=
 =?utf-8?B?QU9YNG5QcjJRdnM0ejNLQVo0YTRoZ0Qyc3FpRWdyZVUrMjdBQmZYVGtxQmZw?=
 =?utf-8?B?YW5YTFBkVFExb0NPTzhVd1p2TkhVeWpUaVFjWEJUSHpmRGpGelMvd2JwNmQr?=
 =?utf-8?B?VzBkT05LUnhwKy9tUVBaWlJ4YWJkY2tpRmxHWjlHOFZUYVpjNTYwendpVW9v?=
 =?utf-8?B?SHMzRmtTUktvR3NZb0wvQlIzZ2JrT0VNWFdYWGo0NXNGQ28wT1RuUWR2d1NJ?=
 =?utf-8?B?MXI5UmU2Zkc0SktIN3R3aER5bFNsUWVMSjBXbjZJRERvaXVyb2NNUFVPOUhM?=
 =?utf-8?B?QmRQYkU3VDIwYWY1NnJyQ3NYYWk5Q3BEWlBUSi9jZDhzTVVuQzhBeW5WWDFC?=
 =?utf-8?B?dFM4TVp4OERtSGwzRC84ZkFYVjY5dEZtOVlpekwzSno1Sys0VGorY2k3SmdV?=
 =?utf-8?B?SFVGalBneWg0RGsxVGlTUmVYL1E5ZW9LNDkyMC9ESjhBSmkrOEhaLzFTM3pG?=
 =?utf-8?B?STZ3SWE2VXBsNnA5a3dXbVdyZWhPY0lpK3FkOFBxcnJGR2l2cTlwbjBUdUE4?=
 =?utf-8?B?RjdUbjRSRmNWeXdsRXVJMFZvaVRPYlB5RTdGZHk3MGZpdVl4K0xhbElvZnVk?=
 =?utf-8?B?OVkvUTIrT3NzejdHU0NMaSswN2YremFtTHV3cUJybDF2WWRBaXBDQm1RZjNB?=
 =?utf-8?B?WE1aVEY5bVhlQmVGSDU5NEhmcDNZREJ1YUdBV29aekFmVHRNbm8wUS9uK25P?=
 =?utf-8?B?cFUxVlVROEFNR2pkQmd2dlk5Y1JuSEFGb1NKSmxaVzdrZGZoU3lTdUU3R2lU?=
 =?utf-8?B?ekZVc1RRcmdidlU5Wll5SEJLREozUHVwaitnOWp6UC9WUjlXSmJoVTZtYU53?=
 =?utf-8?B?Sk50TWMxQ2tHSHRBNXU2MHkwS21yV2RqRENaL0VRWmhSZGMyblAwbk9qVHRK?=
 =?utf-8?B?RXBKeWd4Q3lBVlNhczM1UXNDdEVpTkxkcUZIcEltc3hiOXZLQ1VPb21Xa281?=
 =?utf-8?B?Y2ErV1RVelNCMGpnaEpYVDc0b3Ntb1htZ3ZrN3JTK045OUVXWHI5Tm85M2Fu?=
 =?utf-8?B?Q2tuK3l1V1BlT1RtU0MraE9jTVlBNFo0WHVPYmczVFY2VzlMekVxS1QwTHFx?=
 =?utf-8?B?cnNLUmJZaWprOGt1V0dXcGxnMWg3NzZNWWo2SmIvdjY3SkEvVVdtRkYwUjFV?=
 =?utf-8?B?N3NiT2VsY295b0ZaUWNJcGtJOVE3ZlBnWnVGVHE2NzhsODhWUnZtWmVGSDhF?=
 =?utf-8?B?cDNGbzlZU3lLTFF3QWFXZHNQSSsrRlRQcTEvcHJpYlBmbGhCM2Q3ZVk1RFZY?=
 =?utf-8?B?dEJidWNxZ1R1WlNuWHBLdnYrT011aDI1Tnl4UW10M0d6eThrTWJLdnBBVVBR?=
 =?utf-8?B?K01tODMyMW9SMk9Qb3U1UnU0V1ArdlAxazU1a0ZlcVlmejluNE93akFNYVgw?=
 =?utf-8?B?cnlXMk80ZnVpZDR6aFFCdHg4bW9RUDJ6L01Hb3g1a2dzdHdwRzN4RlIrNWF4?=
 =?utf-8?B?Ulg1ZkY4ZWdXMzdWNG5KZWNzVUtjM2hxMHB0Tk1NR2plSk9pWkRqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GHYHC0LpK30UOoX39P3MwwWfy30m0KXRtK1hTIyWScqLUcb0euZ3nTDsArZ9hoA8XvNQmwfqbjkq1Fj+ygEdQwhkRN6RT06oUif+u/B/A7b5WrGzoakEWw+6nyRm+2wIWa01wSQFupRYXCVbxywDr+/mtiv1uSHIuj/XyLOsx4cBtno+pXqBIDGug2K6YVx3r4RPpT5P+nSsqMkhHAG31rYqJvBAm+jwY1d5PUaMG0ApQanYOByL9A7envo8KmnUs9ppVrY3rVuHI4CJTyB9PjgtD3/168ZKcDZx2XEsi/n6l3yAS+yGeqyhwdZVsEy/8iWEYfvF4LX72EJDJ2q+Tw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9d2fc1-a723-4b86-0854-08df0a154a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 23:44:26.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RSS+bpcIBL/UyLsxKGWCfpkd17jdqnakx6ocQSMO5keSTmVkT3wGX2jYWYhIyLVZfbKM2wkZK+89TVcTKx+mbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1684
X-OriginatorOrg: hpe.com
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfXzJgq72j7rbwX
 3ah7K2wdY++Vbw9mTJNiR8P1KTRaOJNpbaxhGGMdDl2VnFf+FFjzExKADhk7kIWBdvPlI2IaLgK
 ZhtDW8RLCKDVfOfWEKG4gvU5XqoXy4g=
X-Proofpoint-ORIG-GUID: VZ9Qw-z7u2IK1RzCmBUPTvFs9pVRnKTO
X-Proofpoint-GUID: RgY0FDbiBR6T5ajfq5yHw-NP6ZVViGoX
X-Authority-Analysis: v=2.4 cv=BumtB4X5 c=1 sm=1 tr=0 ts=6a9a0667 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=hlGQ8jtkdgq3GKTAoccA:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDIwNyBTYWx0ZWRfX/P9tJy5RIJPJ
 9VPBROg0WMoxWvZsD1kFi0RMPJSdbXEfNR5XqCzXkH+VZ74Twb+CrCYGWRxkfhWZrKpsMM5dXcV
 qVPR192gdhG/lHU1zti4V1VwsoIXrN2k3llHifTwdbwg+qcWcajPjqhmsGUlcM3Mdkl3/hBS72a
 ATylApHjn0tto9f2y2MRzq2olL7hcBHFRF55rREdPZuVzhIPvxkVnqyM2RIMCdIW/+nzTd0LckY
 uGKB9hbkHQPrF2PB1ZVKFj06iSp9DXnVnxHbx/Vte5O+s1Pli8ipw5LhvKoIG1qMDQYi5THvwCw
 1m+AN6wR3o/rPwCiNMQFhMqQbKbpNwI6lQnumak2iCQhOw86S+P+gF6KDZrw740Fvymb+ZqtV+d
 G+EryLcDB7V/o+0yuv34ZkjvXhGbrrrmxXc1w6DPOUo/6YxKzWhpaO8NdTFrjDaJmcCDXHZZNMF
 X0hhsQSfzAh4qfXO/3w==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030207

RnJvbTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+CgpwY2E5NTR4X2NsZWFu
dXAoKSBkaXNhYmxlZCB0aGUgcmVndWxhdG9yIHN1cHBseSBiZWZvcmUgcmVtb3ZpbmcgdGhlCmNo
aWxkIG11eCBhZGFwdGVycyB2aWEgaTJjX211eF9kZWxfYWRhcHRlcnMoKS4gIFJlbW92aW5nIGEg
Y2hpbGQgYWRhcHRlcgpydW5zIHRoZSB0ZWFyZG93biBvZiB0aGUgZGV2aWNlcyBiZWhpbmQgdGhh
dCBjaGFubmVsLCBhbmQgc3VjaCB0ZWFyZG93bgptYXkgaXNzdWUgSTJDIHRyYW5zZmVycyB0aHJv
dWdoIHRoZSBtdXguICBGb3IgZXhhbXBsZSwgdGhlIGxtNzUgZHJpdmVyCnJlZ2lzdGVycyBhIGRl
dm0gYWN0aW9uIHRoYXQgcmVzdG9yZXMgdGhlIGNoaXAncyBvcmlnaW5hbCBjb25maWd1cmF0aW9u
CndpdGggcmVnbWFwX3dyaXRlKCkgb24gcmVtb3ZhbC4gIFRob3NlIHRyYW5zZmVycyByZXF1aXJl
IHRoZSBtdXggdG8Kc3RpbGwgYmUgcG93ZXJlZC4KClJlbW92ZSB0aGUgY2hpbGQgYWRhcHRlcnMg
Zmlyc3QsIHRoZW4gdGVhciBkb3duIHRoZSBJUlEgZG9tYWluLCBhbmQKZGlzYWJsZSB0aGUgcmVn
dWxhdG9yIHN1cHBseSBsYXN0IHNvIHRoZSBkZXZpY2Ugc3RheXMgcG93ZXJlZCB3aGlsZSBpdHMK
Y2hpbGRyZW4gYXJlIHJlbW92ZWQuCgpGaXhlczogNmMzMGFjOTE3YTQ2ICgiaTJjOiBtdXhlczog
cGNhOTU0eDogQWRkIHJlZ3VsYXRvciBzdXBwb3J0IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKU2lnbmVkLW9mZi1ieTogU2FubWFuIFByYWRoYW4gPHBzYW5tYW5AanVuaXBlci5uZXQ+Ci0t
LQogZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4LmMgfCA1ICsrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaTJjL211eGVzL2kyYy1tdXgtcGNhOTU0eC5jIGIvZHJpdmVycy9pMmMvbXV4ZXMvaTJj
LW11eC1wY2E5NTR4LmMKaW5kZXggYjlmMzcwYzlmMDE4Yy4uZjBiODg3OWFlNWZhMyAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4LmMKKysrIGIvZHJpdmVycy9p
MmMvbXV4ZXMvaTJjLW11eC1wY2E5NTR4LmMKQEAgLTQ2Niw3ICs0NjYsNyBAQCBzdGF0aWMgdm9p
ZCBwY2E5NTR4X2NsZWFudXAoc3RydWN0IGkyY19tdXhfY29yZSAqbXV4YykKIAlzdHJ1Y3QgcGNh
OTU0eCAqZGF0YSA9IGkyY19tdXhfcHJpdihtdXhjKTsKIAlpbnQgYywgaXJxOwogCi0JcmVndWxh
dG9yX2Rpc2FibGUoZGF0YS0+c3VwcGx5KTsKKwlpMmNfbXV4X2RlbF9hZGFwdGVycyhtdXhjKTsK
IAogCWlmIChkYXRhLT5pcnEpIHsKIAkJZm9yIChjID0gMDsgYyA8IGRhdGEtPmNoaXAtPm5jaGFu
czsgYysrKSB7CkBAIC00NzUsNyArNDc1LDggQEAgc3RhdGljIHZvaWQgcGNhOTU0eF9jbGVhbnVw
KHN0cnVjdCBpMmNfbXV4X2NvcmUgKm11eGMpCiAJCX0KIAkJaXJxX2RvbWFpbl9yZW1vdmUoZGF0
YS0+aXJxKTsKIAl9Ci0JaTJjX211eF9kZWxfYWRhcHRlcnMobXV4Yyk7CisKKwlyZWd1bGF0b3Jf
ZGlzYWJsZShkYXRhLT5zdXBwbHkpOwogfQogCiBzdGF0aWMgaW50IHBjYTk1NHhfaW5pdChzdHJ1
Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBzdHJ1Y3QgcGNhOTU0eCAqZGF0YSkKLS0gCjIuMzQuMQoK
