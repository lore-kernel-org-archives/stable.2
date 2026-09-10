Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1D379C5A;
	Thu, 10 Sep 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022499; cv=fail; b=dfrN3KUdEDA6f/12iWtlUEc0nmCZ8PsHAxEHcW8/vh7siXnJGYrWhf8MTorULbaFb1b6VH2Lt+E3F2xhjD1qkywVxYqNlTJ0oFdlVEzWtQfpKJRcVC1dqoEsbIRqZCUK0r6Zo6YTw96SI/fIYufwYYTng3Zu3dH2d4lwQOHs2UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022499; c=relaxed/simple;
	bh=5qGyp/SUS1q0mhgWZafLnR1BmTjux44tFJyYNDAwb48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jETYWZJrKyjxAlocOPb5cIx/0V7bth+B6uWIbV7Wzwc5OKfT2LfrsnyBuesz5JKOH8lqtNYIstHsM8gWgQr97K2q4w/JltOh0Ul9L3cUpgV8aCNd3qi8hU2i3FxYGvb35O8884ED+C/2LepTNucnZAUb9XrGrPx1PBQX20wuatE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NHjmRvll; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NHjmRvll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfSn+vg76SGX2z0tLqId7C7ea7OxHYbuU/IQypPA8yPGD/J6MwUTdu1Yu+B5LMq6iK9Tr+wPFnAsu0ZQkRe9VCDu9D4QtJjd7WYjm+xTod1VLSc5DBbhKIhKcFKYumIcU1rqQcFegqe9X5OPY2uZSDySvNtFz1fu2e2MtZKUvrcZm0m/qvi2jqWdeYxLsE5qgJhW2PnmUV7p1ziiRLWxX0GZxJi5Jbpw3WYRidgo3vX0dMMszYefu3LgS205+vTujXSwEnW1Hb+cB0dat3MO+EdyFD2TcRMBBKFofOZ1sU0BQB3Lc4l69uW31nbWwebRCDR//or+2ALoCI7WSXlmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4de2wGPEH2xDVLD7pi1WmiCPE2rVZwaK7DYj99P8NY=;
 b=JkZi9qmK7rpea+BKCpEcgC9UoLeWwQZRL7xILivDG6AF6QLIIAPX/cOdT9j49rwAWaqITkHVhqN0K1aJQKysyd5XmOk/THsp08v3nOdfjbhmBuRTyngTTa3OGw+4FrdoBwQKk20r6r93yaepclJRHTl+UNfK1WR3CxFO5CEfevK63vyjqNuP6C0Mdh0CDxBGWfKSXHOvQAHFUvWBLvMlwbJHVYh1z0b+oVDCCsLSKJIyzRhVs523JvhUh5gYZUeyWmLThnCNUGiPGQuWm7pcpFSUTFovNbn3KycdBFvoUPIrzYdngDM0GIpBW/uO1ReCmUbE4SzWYRQlnz5a0OIOfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4de2wGPEH2xDVLD7pi1WmiCPE2rVZwaK7DYj99P8NY=;
 b=NHjmRvllWQoSRYrbwcOwMsY3Ki69So4AXA6FcjaXxwyxcRUciqB+sd7d4z6AAASN8w7XZBvABTWZIaohjzpYggACQdtdPyXMTt8SPL7G8q34dC3kI5ih2KTfuu2qulKoJx8oCCI/VEcfRnG+LDWtZvhwAr5e2qsTmh3PEO/pUSrRnD2hB951M60IeMCIFyN1euhv4kjI0nnjH5jSLSI7+2ZDqpB3ddnvaxNKbLRpDreeDdbWr2Xx9tQLTzuDSHTCx6f493DYTFsaXeCrxPTEuj8QkhcVuiqafq6OXLmQOHd9PibC1s5RXdmoakUa7xG6vxc/zBitFkge/6Cj35XdwQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DB9PR04MB8431.eurprd04.prod.outlook.com
 (2603:10a6:10:24e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 06:41:34 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 06:41:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"me@cherr.cc" <me@cherr.cc>
CC: Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"troy.kisky@boundarydevices.com" <troy.kisky@boundarydevices.com>,
	"fugang.duan@nxp.com" <fugang.duan@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "horms@kernel.org" <horms@kernel.org>,
	"phucduc.bui@gmail.com" <phucduc.bui@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v3 1/2] net: fec: stop the PTP clock after the netdev
 is unregistered
Thread-Topic: [PATCH net v3 1/2] net: fec: stop the PTP clock after the netdev
 is unregistered
Thread-Index: AQHdP6/dMH7O9YfD/ESmj0TrqmRxrbbHPGkAgAAZY+A=
Date: Thu, 10 Sep 2026 06:41:34 +0000
Message-ID:
 <GV2PR04MB117391BE42F1A9C27C76EB5A888BF2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260909-fec-ptp-pps-event-uaf-v3-1-bead12c29a16@cherr.cc>
 <178901496609.219967.4341484781884273489@kernel.org>
In-Reply-To: <178901496609.219967.4341484781884273489@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DB9PR04MB8431:EE_
x-ms-office365-filtering-correlation-id: 8162b025-62b0-4ef1-33b8-08df0f068eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|19092799006|366016|22082099003|18002099003|38070700021|10067099003|3023799007|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info:
 GM+3J0Sdmd2Sm5lQpt2l7Zz+Q4urGV7R1KkdNu3Pa4CAWnrIdEKW1nX1t623qD7ebZYJUdlWSetrhStKGu44Ac5GbKWcz4SD1LaylFMtIUU3pfQYh0e6I07I06AhA8cD6j8gyi7cHFO76UdAS2ek91jbAHEPsKMcG757ygAqSeZyRVHvBhPSjFVFeLFHMy/evRoVViEtR5kVrBDlCL5lGIOZFRxxZuO2oj0dfdo3K/z3T4LMKeN4Re8u2a6wwO85rbSDlBFE4grsK1scWmAUapv0I2xpuOA2rSbnd3qX+JtYTwtOlk+mZ8Sit+vyp8YOiYtaxyW84WqjwkzyX8Essush6v3MEarDUhSr28dK1jQtUu6ID7srwn8Ug01qQa1GJ2qYdDaHUU8CpidATjuZZ1BLuNG3QV4lDqhNdlWHlUMqcUyvynlHpKF8OeGMHEQWzGEQnBWtOUviVvGMdG4pyMVt5Ukm743ZN6St+QMLAaz6BWRTOsfXIyNYo9jSP/Cd8Ny6YoBGLRWDGjaO72sZIfpFE8BtdhF4mGdzfiiyiUtbMZHGYS5gfAe21uLbPcAN2BXYV5h91W89RIdNY2L8s8J0ODBp1CTQNo8OSzJBYVGwlcBgG3nzrMHQcS82S7BjzEMvQcPEm3YNeaSekSEfmMWjZyrbz9RCeHrJ6OQResBH2MyRcICs4ycEIQuwijyHDZa2pZvcUF0ayVI9cP+YaFwlYuLhsGs/714VBG/MeUQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(19092799006)(366016)(22082099003)(18002099003)(38070700021)(10067099003)(3023799007)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jcY7az+TyZXIR57bWZfkayLuQuX8WaXvoJ+VDXuJsn/BmgIRVhSgO2MoferM?=
 =?us-ascii?Q?gOeid8X+jaKc3eZCs5S+WCtQp8pWF6ry1fJKxdB3ZxtJWmTusQuQF4v6vgmu?=
 =?us-ascii?Q?QWnvPDTgW6YBKvfAd2F2RYiRYcsDCdhcHZj4s5Msx/u89cu66akcXyGLSOWc?=
 =?us-ascii?Q?uibMsRlxiz8lGXlu/BddtvOZVM8d061kYTWH/Hxaqy/bY1T1BOheKuOoGii3?=
 =?us-ascii?Q?AL7n9TvGbNussS3fh5LRzA9pjnUiLbxOFrME8Xk1ctHlRPccKRFMCRCdcbdb?=
 =?us-ascii?Q?Xz8JquKMw3Ap713u0I0EbWgCky5dWXOu6PRUE8T6FG1UQfUME/opWHy0MAa8?=
 =?us-ascii?Q?XQQW1eoZNBBQinpS9OVO22b65b4A9sm+ONU61+GDWuk5HQv4FuTyKhX68bHy?=
 =?us-ascii?Q?pcx6xTSQKpJNa/gVHFwd6P4m4WD11bw/M40pUXI2DuYwRCk80hlOC3WYbkRp?=
 =?us-ascii?Q?cKsh6hw4henv/h2uCYpexd+kTzrorOjNMIGQRFyieMGMB5ITzx91ROo0sO9L?=
 =?us-ascii?Q?QDqbsYM2eBL2uGYFxHb1dCQXhusLEV6FSBCRPu79vb0C7VZvpYL3Pnd5nfFH?=
 =?us-ascii?Q?aKWBebbXP3kH+SFFA9L5OXl4ktn4Oz2uC1V8fT4C2DXfgjvj5i9vhzm8BZGQ?=
 =?us-ascii?Q?2CtJlsG+1cmFaR340/R/+WCCxmV0BNZogcwGHOyjpGKUunZgojPhI1FJWiMR?=
 =?us-ascii?Q?bJerGsiuNLfJkBTV+FCEVAA56JU3k1iAGHxqD2yoejydXaIWt3yj2A15iytL?=
 =?us-ascii?Q?arw0h4BEEdhwRWIEj6P0C0hdpwe96WZ544Tbpi66OP2q1LR/juxyvwEUv1t7?=
 =?us-ascii?Q?YdqsrsDNg3jfRjE+NMMtdUeEGnO7dqlsZzkEM0vHIEwt92h4JM4kVgfFZOZp?=
 =?us-ascii?Q?ijlYSX8WC2VqIEOdG+QfghcQVhxlvmMqd49RhDb5WYKcMiKQsjd9nhGFnOvU?=
 =?us-ascii?Q?hvg/dYHhSTa+QW+ADLEgkDgbP7SkW6gSPMS9e8FkRzCtwfDJPINVACrxe1C9?=
 =?us-ascii?Q?vpi10CW7YxkxiiW3P7WCQhIIGUIjOaMnBAwN/Vm3PuYdHrQDXShhCl9tV03X?=
 =?us-ascii?Q?Rj7Bxzc10pk+/VtGkoKJH3jOto3opgwzHKp7o6KrID4dcxZENIF6piJM3mAV?=
 =?us-ascii?Q?BUnaLxAYrH3pjm71QnkKUOzbQfIIgKbYWJtnzBhwrQrSoeZo1Xuykpsed4dn?=
 =?us-ascii?Q?/hVIx71E3gdgDMN/JcP93GyrQFUPN7Ss5m/WLlSr/Y3d1AidTYwge+RrXMk8?=
 =?us-ascii?Q?IkJJ1WOmbSZVODz8R4Oev2Me5iDS0R7GBX8DTqXT8a8U4U44lnYxJBjH/PwT?=
 =?us-ascii?Q?s9/3Sz6Qw1tTecABieIlN46eUZU71anyEfUz56Sh0NIlyZmGBcRH/+bIeP8g?=
 =?us-ascii?Q?54TNb72NnPxLDDGAiNsu6nLkvQc2XbBrprHu9pVwU9Z+YVSPDQMUZAp5RCV4?=
 =?us-ascii?Q?pxlPAeREUJv3ZsOciivSm0xIzOcvEfdpSp5YIXmZg9oIxINDM/3WBkSMBNZZ?=
 =?us-ascii?Q?hrTytCU86JLoIqr9rD/zzHEoS3c30/g56O+W+gjXtYL7XvUFEIIs1PUjQdKv?=
 =?us-ascii?Q?h7PjwN9et24NX5fZ0/2h+IVVqF6zLXJE+lGrBPXYiTDLZX14vWBneZOPW5j+?=
 =?us-ascii?Q?4KJrDC5KSX3Hjihx1AfjEXO0ka4C9PxM7QafEdiVA8TibeIrXBbp7b8SoC6t?=
 =?us-ascii?Q?haVGt6JHF7mo7DYRTTl8axg/QsocxITdgNRbjBboYhn7nET7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8162b025-62b0-4ef1-33b8-08df0f068eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 06:41:34.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVy8MYhhMGjk4g44sAbXXhBxyLeKzCHrjhtegv+rHL4TpS0pVu3euV1CK0DLcRkEwqW+o4zYDlLmDMDx6G0Mdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

> > +	unregister_netdev(ndev);
> >  	if (fep->bufdesc_ex)
> >  		fec_ptp_stop(pdev);
>=20
> [Severity: Medium]
> With this ordering, does fec_ptp_stop() now touch the 1588 registers whil=
e
> clk_ptp is gated?
>=20
> unregister_netdev() -> dev_close() -> fec_enet_close() runs first, and fo=
r
> bufdesc_ex it goes through fec_stop():
>=20
> fec_main.c:fec_stop() {
> 	...
> 		fec_ptp_start_cyclecounter(ndev);
> 		fec_ptp_restore_state(fep);
> }
>=20
> fec_ptp_restore_state() re-arms PPS via fec_ptp_enable_pps(fep, 1) when P=
PS
> was enabled, so fep->pps_enable is 1 on return.  fec_enet_close() then
> does:
>=20
> fec_main.c:fec_enet_close() {
> 	...
> 	fec_enet_clk_enable(ndev, false);
> }
>=20
> which does clk_disable_unprepare(fep->clk_ptp) and clears fep->ptp_clk_on=
.
>=20
> Control then returns to fec_drv_remove() and fec_ptp_stop() runs:
>=20
> fec_ptp.c:fec_ptp_stop() {
> 	if (fep->pps_enable)
> 		fec_ptp_enable_pps(fep, 0);
>=20
> 	cancel_delayed_work_sync(&fep->time_keep);
> 	hrtimer_cancel(&fep->perout_timer);
> 	...
> }
>=20
> fec_ptp_enable_pps() reaches the disable branch with no ptp_clk_on or
> ptp_clk_mutex guard:
>=20
> fec_ptp.c:fec_ptp_enable_pps() {
> 	...
> 	} else {
> 		writel(0, fep->hwp + FEC_TCSR(fep->pps_channel));
> 	}
> }
>=20
> Every other 1588 register path in the driver (fec_ptp_gettime, fec_ptp_se=
ttime,
> the PEROUT branch of fec_ptp_enable, fec_time_keep) bails out
> when !fep->ptp_clk_on.  If this write is not latched with the clock gated=
, does
> the output-compare channel and its TIE interrupt enable stay armed while
> software records pps_enable =3D 0?
>=20

I think this is a false positive, the register cannot be accessed when the =
ipg
clock is disabled rather than the ptp clock. And the ipg clock is enabled a=
t
the beginning of fec_drv_remove(), it calls pm_runtime_get_sync() -->
fec_runtime_resume() --> clk_prepare_enable(fep->clk_ipg).

See commit 91c0d987a978 ("net: fec: ptp: avoid register access when ipg clo=
ck is disabled")
for more details.

