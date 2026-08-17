Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806C3EC2E6;
	Mon, 17 Aug 2026 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958985; cv=fail; b=NrlCfSIF3drr16uOk/ds0woVR/Cm4ZaIYP21AG3U9dybTYXKiQs9DVQAcpqw1Qplyr0w1vztTY3LWBdAcONtYLbxPFt1v0vF0ZIutHO4pgEKwX7Q667FNjYDDYF7UQNsHThVJ4kumKDK6HdOiPTzJjr9sUBK3b528esaicYg9DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958985; c=relaxed/simple;
	bh=gt2mUa7mhT8xJZpCeyAI9QJzYBefJ5t+NXLAj9HVCSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iaaxmJTvk/HTSfDQ52osoCfxQdCZCAn7VZpmf3y7wsV2hwYkGs5kuXpzswbZ7tv9lf0QG3aWyY1bMZLJRFz8mRLDpMxil9vdzLPsYrGbKgFqt63XgcLoTeesXcIDpbJ+No8mCm5jdzg4z50C/m9i8OTvHSlNEacGt6wzr6uBH7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com; spf=pass smtp.mailfrom=nebius.com; dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b=KmObfpyP; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nebius.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebius.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebius.com header.i=@nebius.com header.b="KmObfpyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5L83+nogyjxQ9O9VWCp/5/o7gpfcaz3119i63SrPP0muw0t1Yo6fYkppRNpA6n+HnfRNvB0XKWDHUHvuqzhABl6N+qShieEobG58HnG0HailcCXXjfynScWsjpumXNZgQjFIYchRqenr3luGhE1kefl2o1s8RZbxVTj1W6J5cOkI3l6teYl/AfsHXPwmhtl62QLd2cD6bSNPWZRPI+5bP+V+rXrXd/MRdIbNScz46p+Qns5wNoiIioPckpxlk3wlDHLC1YHXSUteEQmU6S/UR1ti0xDooQd7iKJ/F+0rgcUYLNhrr7BsdelH1lZnNLaGDE45F7E9i39kV5sfRc2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt2mUa7mhT8xJZpCeyAI9QJzYBefJ5t+NXLAj9HVCSs=;
 b=R+O1HemKHDGGEAJn1KOAPCOCXNF98tP4ogCtYndWDEEe4trGNYXPDhGwnxqSE/iYT0IrhZ6YCYbHT8TqeEbhqnxIGBiPFEYU8T8M4YWEyZzIwprxMN4i8Ht0Ku59WNEnmXhwrth+j8iWuZuE2UBPVvPu69jwNNCU6rGiOEzBz+YmDpoJnqB6mmuM7plrp+ie2tMT54TpjMN4CNB5GFkm0R4d8tLUXbVFXkHgup2z1soA78PkKLYle7voFbBCoRCZAkFQOLkrA3JP/N2ZfVhit+5Z+IzUUnk1Drq5sWg1K3GF5HmQHtwy0rCrTKyhY6YLbBZ8GXuZABCn4TxbIcs36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt2mUa7mhT8xJZpCeyAI9QJzYBefJ5t+NXLAj9HVCSs=;
 b=KmObfpyPLnmoZwpIGE6AoxT+4ya8oz89WQDsYiZ2gf/yvYz2ZcKRv3IhNTMWbM9C+cyZV5UEal82pvtxejxb1wZ52m0fCzUCzW17jL0LyzLV/12Q6Q4Llhz/BJCZokpjtYWYz+zuyhw0t2nxPJggN1muKDPuHlT9LZPZdpNgeEb2h0nQ0ywZgyTLhdVJC4F8wbSZR7LH797V6Syxn616GHxc8yOaR3pzFyzfbuGryXjv2wwlwSnE2IF5gdeq+bjinMuMb2CAKM0PfEK+2jnK2we0Qt4b13YozxxYnUaVWU5aJQfpdfEYWV1RmXkH7pK6LqlhRpr9Mt1mPSXWoerLvg==
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4fb::18)
 by AS1P190MB1774.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:29:10 +0000
Received: from PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0]) by PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
 ([fe80::d0eb:eb62:7779:c6f0%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:29:10 +0000
From: Dmitry Malkin <dma@nebius.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Topic: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Thread-Index: AQHdK9Pu+fg3Gt/XVU6V74nnaDIiLLad0o6AgAARZHGAADf9gIAD4JGA
Date: Mon, 17 Aug 2026 09:29:10 +0000
Message-ID:
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
References:
 <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
In-Reply-To: <20260814221103.GE510472@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1P190MB2557:EE_|AS1P190MB1774:EE_
x-ms-office365-filtering-correlation-id: b19e48f5-00da-4535-84f5-08defc41fe4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 YlPlKj4y12Brphi175mIk6/vW/8z/n8uha07mOWZKFT0prWMEfPcTxqgnjpeSa/1E2RNX/TkUWgluJd5yj9MLqHX00oXoKK3G7c8oIFx9GogcAkjle1gjncOy0XtArFOAMHGR1h8hfEPp4BYqYjpznOqYFjU+bHlj7zrJJtBgHG0sZWABE6mZmr24ThUgPE7b1uAodr65NJp3BNho+xJugslLTyvMk0YCBBRb0k95+b3flCON1rMdzUiLEUCgtg6uBnLnRSk5+snI83ZjcYMfEDBE8AD+E8rNprsL1uE1CRx+zqzc0N7Fjya+/I76zUHI8ZB9R0qN1GtRJRd33jVT7ZZuNHqPr96YszMjRSffZkbY/wjj6jaUiYaGseFhecOOlbVisc1/WgqChbCT5xgRwTsj3sj79cbsnYsBYknbm75mA+a5R82EJjxx3J/6W6mcOgdLMTqO1axShhrt2VggVGPDEVGI/zrU9wVp64rakHvmv1yKSQ1pRPMtm5Qfj3S/aO7hX9bv6uiTMKeazEAUkqRz0Qy1bERRy5sVp9JrxBYZ0NwDRrXYVTVRP4mAbkqCG9FPEWLDDRFtWfiwZI3N2VjfGzeUp66tVZUr9k7eWkVc/YOM0QKlZgj9hnz8I8JmSqqKi7ouq9f/pzQE4sub2a8MEHplPW85ggINAkSDJ6tpKxtDQrV8Lw5Ai3REVsHx8VC5z6YTiGr/uPeAY1OY2hmrN+a1VmO8pyM3sy3Cac=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1P190MB2557.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cTjdIyKGCzI2/ashkG4bcCZXh5CZYP7FaSfwDiFhsL1B58ktB7fJpBh6k7Lg?=
 =?us-ascii?Q?wucGCoEkrLVHRCeZTMZwKinwBBY1UXCY+yIwM49FBZ1NrvX8u7OSVJGR/GlE?=
 =?us-ascii?Q?ThhrvXwWK3G60sKt/fRoMuVH9FZ+w6bycmu/BfqbgplfFgt9xSfWep8f3vJ/?=
 =?us-ascii?Q?+BwrOHHxv5CPV+VOPYubvTi/eqxjSr76MtrnvfKSNfqU4UhjA4Z755VorBTh?=
 =?us-ascii?Q?y7RcZ285of8bA5TM/Mds7ICAm4cO3Rm7vlmBmAUF9ne0eT9EkMZJbuiQ1dUK?=
 =?us-ascii?Q?22apMWsme1kcdywAkN+sazyjEf0P7Y9n4ZEwF0hB8zrRmqWNF3NRbU4yXpnr?=
 =?us-ascii?Q?pLZkC4EINQq5Da62S7kQSAlQwQReu0QKZgRasna+ZADbMa2lTTmA93isU+uY?=
 =?us-ascii?Q?U2Xx74D8pp3XNlJg6RKJOhjabva9M+3wcFVrrvIGYKWonx3NOptEQl/gFsiC?=
 =?us-ascii?Q?iAT0YuKwoqOAgBT0mds67z4OhMnPWoit3xlDSQbAPNoxZGQT+akpGiGhF09v?=
 =?us-ascii?Q?mAdIlLGtu6hm4MMoFPpXir5vMwZVpzS046gZJCb9PoaAPrdDBhOWzgOtJYoC?=
 =?us-ascii?Q?jkw7WnZSf+tErdRsJsHgJRVbxlD/ruvdXAXJeC0wzJTgvXF/FzboywHH8KfX?=
 =?us-ascii?Q?6HkVu5/627Y7xVLZXT8MOsG3/HWRJqP7Wr0FVK/mVbADx01N09SRE29ip4s5?=
 =?us-ascii?Q?0R8sp3hOsKAFlh44+QOunO44r+ivFVl5b2t8g4Ypb3xxdRAIlmdHMTxqs/gt?=
 =?us-ascii?Q?Ww3ZGAs3QKMZC6zC72cFj3F1VrX222bv1AcRQtNTy9oqbCVhSAHwMs+ZkSVV?=
 =?us-ascii?Q?vN6Wf93gR0fejYOG5XrNfb6PryJ7Jq4Fte8/3wiN8Pm9bC3gsCQShi9E0de2?=
 =?us-ascii?Q?Z+etv+o2QaHiC1xt2U2QPNHo4bNKfQWS+dXS4egwDiLXmgrpetI3wiKvHz4w?=
 =?us-ascii?Q?GZ2rlqtOKrImW5lcNx0sXoId0KkMRB0AZTole9nFA9Ta1YJVLiKA7AKJneNF?=
 =?us-ascii?Q?dnWgLen9IF1aUAD/KWNhHwUZrds+dg9RDEBDge8PQ+NblMku9Rq1J53EEO42?=
 =?us-ascii?Q?U41Rsht9HHPzRYGuWpWMUyTp97dBrJFZxJA7ZG5U2tjStvzH1OuyzGtAvZei?=
 =?us-ascii?Q?JxltRRBrFNSjZCgFhv0Lsl/t6C0PtD2hz2GsO3bsJ+M2Wrc1JaLX86ynKm6x?=
 =?us-ascii?Q?cRusOlm/EsSGyQUVo7r0nWRsC4gO8GK7f9RW6FEzRZZZQbo6LMs92mE79p2b?=
 =?us-ascii?Q?tXvPjei85YxyP8Qaor7f80s1rpHQfaJsoLgVifvNLdc1FtLik3mTX4dpSa7C?=
 =?us-ascii?Q?MnKfsqyCXttxB7VNEYG2KHLMOa07jSwcxGHsqx3xyzZEstT5bM3bXlMiq0+t?=
 =?us-ascii?Q?w0Tsjjl7+GUl9/XJ68whquLbdeRhZdEEu7XKBBanHanQt+m6zn2QnNclTN4E?=
 =?us-ascii?Q?MoQ9GNcp7YuCMiQbWE0Yx9CVlRe2raaAubghvV5vcESJQiNpYCWihcBvtNu/?=
 =?us-ascii?Q?Cqh9X9jkHulrNwmE1bYA4uJvL6ePztxbNQLKq9aIQuvwLzPwU70pJpc0RpEm?=
 =?us-ascii?Q?vYKj8nWkF7X1nKfP2JX+YB5N/s4FFeeTmd+4DnyE24AhVbeshoqNNKJlucKx?=
 =?us-ascii?Q?o/CSe4yK3JvtmB32anQjmZET05MojV+c3eqRK7emfP9Gi52wuNcLHU11Ahl3?=
 =?us-ascii?Q?e9I6rVWxmzwAc1+f13BxDTr1GKRIuhEWKEF5QUzsTXcbjtJ/WdUXHTmPJK86?=
 =?us-ascii?Q?DubSh/uBywT10TXLUEzGjeZ7MmkZUyztSc2bhg35/g+S2yiNEI+0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1P190MB2557.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b19e48f5-00da-4535-84f5-08defc41fe4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 09:29:10.2359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arkweaoZr5aJ/6z17715u9txY9VvSbAsgOjStH2i60GsKtDZ5FqSiYzksQJ0uXbT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1774

> Don't use it that way?

Why not? We use pci=3Dconfig_acs to configure ACS at kernel startup and ena=
ble direct PCIe peer-to-peer traffic between GPUs and NICs. All affected de=
vices are assigned to the same VM and IOMMU domain, which also reduces the =
memory footprint by reducing the number of page tables and lowers IOTLB pre=
ssure.

________________________________________
From: Jason Gunthorpe <jgg@nvidia.com>
Sent: Saturday, August 15, 2026 12:11 AM
To: Dmitry Malkin
Cc: Will Deacon; Robin Murphy; Joerg Roedel; Nicolin Chen; iommu@lists.linu=
x.dev; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; =
regressions@lists.linux.dev; stable@vger.kernel.org; NB-Core Team
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI bri=
dges without vDEVICE

On Fri, Aug 14, 2026 at 06:56:05PM +0000, Dmitry Malkin wrote:
> Hi Jason,
>
> > If viommu should support multi-device groups, I'm not sure. I want to
> > know why you even have multi-device groups in the first place because
> > that is not normal at all.
>
> That is because of the 'pci=3Dconfig_acs' kernel command-line
> parameter. This causes the kernel to create a single IOMMU group
> containing multiple PCIe devices, including the bridge (PCIe Root
> Port).

Don't use it that way?

If this is an nvidia system you should talk to your support team.

Jason
