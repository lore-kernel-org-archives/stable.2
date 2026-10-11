Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazhn15010011.outbound.protection.outlook.com [52.102.161.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D9285058;
	Sun, 11 Oct 2026 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.161.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791710873; cv=fail; b=C87cBsZftAlmFcJndasfCn3mYjPXGv9xNBTAuBYeEIGMx6CH/N4D0m7koN6OR+Lzhdpt2t04pjL0payj/ZFzQI+Ey6F8cJCKusySKlP7ghNzBMBFTIAY9m5iB56uamD7CtzqSNKn60urqv2Qs0BDWHPwkDOcrR+Ao3qFh7ltSng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791710873; c=relaxed/simple;
	bh=/VVMoAWI2wQB7xMlbDH0BELRynTsFTBPzhlEHRM8Ns4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fBLLS8LJMbyOCWyZxkULJA3zog36itLHmtd+wFg4hqJtmwir0cHz0GaiUGsWGscSj/YWd0EO+Kc+ArSxHpr8TZIIJUhL9zsNyjn3AdrPnNEZ4hmdPaXp6a/3CDmywW8bEuhFr2Ue57Y/8V9T5AvzVPhaL25VJOqsRo6/3L34vws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=D9rwkP4n; arc=fail smtp.client-ip=52.102.161.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="D9rwkP4n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTEyQLy+uRs7ZNvv64B52hbAEzS5f2kurbApPVyxic1+hv0K21dp/TLD7zcyML4vQHS5tu/sWgFAXHl2enpt+6MpS17kxBN0ZMUX8iaGT/IsdrD0Be8YeT+q96fMpIWFIMeJtOhL/2JEdghRswM+wf5ueXr4YI3ZuER5IRLoPT51wxkUnBbMWpq3OfCOPy2yq6fnNfpulxqs39+H8Pebfo0mFWvi0tWVdsgmP0ae55MaZbybjrpUoKb1oW4DsMhHucmYzx9w2sDHAhl7TAYGpaaT+v18KLgRSZqdd6EEZi15N/gwKdNcLWM1zgv4n8Eu1UFCIeu9xmqFEzBqg7bJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VVMoAWI2wQB7xMlbDH0BELRynTsFTBPzhlEHRM8Ns4=;
 b=Iqa+DHIRhX5AMLlJM/tx3lmt1uiZaAsZerlZKCQvHn9jo6FW/qsQ7CQa+/SXyBBhD2v27eEuH7TQ+vtUIfcQoPZiq1cxNzNAWk9+RB3GLLDpu78H/39X07l0+xQC5bkeINckSQcn1K+H96WJ/+9MCtYr3TdoP/NRICPVoXDL2QlqU4lfVLdl/zcovBUgwlV8+G59xmDDPCrJLbAb60YoA4qBJt6GiqSAinkF8aNqtO3qs1drgbGvXJXFE9BI7AmOH62tQmsn72KgcNdl2y2VfsVHtjnreflAXSx/H0uvBJqPA05DNaYmbPHn15OCeMwy1TVW6hAYXL+d5w2+pycyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=163.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VVMoAWI2wQB7xMlbDH0BELRynTsFTBPzhlEHRM8Ns4=;
 b=D9rwkP4n13W5PsKb9xothQLQEKjKZwp0qKkGeF/9ForIwqo3Ox8FpFBaP4VbeLvE8cclPfglu1D1zDN+UVDVPnZ1nlv/aH21O8euvUJEZeP8NR++2oTXEUjaSokT7T2eQ4U9F26N2W7ko3aCvVpCbu2p43GDhtAN2q38+GmfPPRMBYQVSTnPhY7HzAT32lnBMvRdHnmXesSP2eP9hA+jZWzGMb8JkkG08qL66NHFtpmpA6WEDBKR11ZAhGl9F2EVsr9ygyoBpz/rPxC8NPLyDtSbBeuWqxZCBj+uqnlv6Md2G+udnlv4issC20TXA2rtqLrn8gEKUzYE6xRAhy3STA==
Received: from ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18)
 by GV1PR10MB8606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 09:27:45 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com
 (2603:10a6:910:1c:cafe::11) by ZR0P278CA0031.outlook.office365.com
 (2603:10a6:910:1c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sun, 11
 Oct 2026 09:27:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 11 Oct 2026 09:27:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 11 Oct
 2026 11:27:57 +0200
Received: from [192.168.8.15] (10.252.15.225) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 11 Oct
 2026 11:27:43 +0200
Message-ID: <1026b843380f4bcd6180f798b2f4f9c8a31c0c86.camel@foss.st.com>
Subject: Re: [PATCH] pinctrl: stm32: Fix fwnode reference leak in
 stm32_gpiolib_register_bank()
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Ma Ke <make_ruc2021@163.com>, <linusw@kernel.org>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<andriy.shevchenko@linux.intel.com>, <fabien.dessenne@foss.st.com>
CC: <linux-gpio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <stable@vger.kernel.org>
Date: Sun, 11 Oct 2026 11:27:40 +0200
In-Reply-To: <20261011061722.3159941-1-make_ruc2021@163.com>
References: <20261011061722.3159941-1-make_ruc2021@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008482:EE_|GV1PR10MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 984a2158-cd38-4866-8bf6-08df2779e83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|7416014|34020700016|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006|12100799066;
X-Microsoft-Antispam-Message-Info:
	U7Js78k86F4GvISpx5d3Q5Zl5LnsxPoSWzs832OexkIy4oO3ZNArVcD4aBj0VH8S1NZjzmoGTbjbt8CZ78nM4sIjdrW3KTqRMkG+OxnlSRe+RZlRkQW9K0awOxc3fsfoGbAj6PtYd/biCwGhSEHwFdETuQpbJMmS0Qmtj7SLRFOksVW35MzZqt9JoS7QrUm+PBJnUl2K8EeYCUyNmGN//obMOJuI/xQxCktZqQbb3thth8CH+qD89pfTKno32exNVvlcAGxdcStkGdXLmXyHU0s7dHcYfHlX5jP5TJ5OTECq3QmU/T+Gn28RbDXJP4JgNwAa8JLn0KUI/EuDIE+kEbRBA93b3xu9ugNwvREH8rpdzOy/WUKsLM/EtxP8KeczOg7x6mKQ1TYkS6Q1ZtP4H54DgAtKd5L5ttuuWwm9X1gddREeAndg7J7yzyTX/TMGCXg4wyaO1NgVVJ1+teq2mCEfnazQG7WlsGcM7wBFmzfko11X3IM+kFOVq3SnbyAVWP8Y8ioVziRW107MB/p1mBW6tY4S4lH6YV2kCDnTsPPericzY1Ev9O+SQte5rKJ7dyZ+UkDgFES+d+QTk4q3OKY70wcDFHmybacXenfRkbmpt39pIAJJXExeJeNPp65VJsKaRkxeMNmhY0nhgCTJnv20bLjsdW/tQ+wB6ys77mnEV/XB/xvajnF6QOgwHlNphkTlNulHwRWVSbgcNjeZbg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(7416014)(34020700016)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CiyDXOF4wfqvSZXHbyBAMsExCr3AuqkfNYA0D+NowldPaUR9lxQVsoM3f705h7+UHt5T187u3opCyjZRVKgJfdZgoH5ha3C3HkuxNlAjEJmAq3MsfWa/7XGTm89PtX9EEwS/bvhD711mFORoZ8A5l+xX5hgDzHwrzucQpeURXEl31FJxQKg7hELtdbBt06k3luWgWt6EDkJlmwHsWHbR+dyq5iqLnvGZ7QVFlqbcu04Fhh5hQRG5o3NDQJjaGEqHdV4Q7mSUlZnyizRsRmD7eGuOVlDau9Pt07bHfUsdUbP126u4qp797I6f+RbAgR0vryxjamg+vwx/cvZtnnaeyWb9HNbIbOEA+r8h0B4DOW2xYwr3aePycoVs512UtLYCImhOL92Z7x/yeFovbF3o1hjun/U9aaqJMQUTxocWBE3L4HZiMvyH4J4SJhQmTUBO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 09:27:45.0313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 984a2158-cd38-4866-8bf6-08df2779e83b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8606

On Sun, 2026-10-11 at 14:17 +0800, Ma Ke wrote:
> stm32_gpiolib_register_bank() walks the "gpio-ranges" property with
> fwnode_property_get_reference_args().=C2=A0 As documented in
> drivers/base/property.c:
>=20
> =C2=A0* The caller is responsible for calling fwnode_handle_put() on the
> =C2=A0* returned @args->fwnode pointer.
>=20
> The returned reference is never put.=C2=A0 The function calls the helper
> twice, once directly and then repeatedly in a while loop, and each
> call overwrites args, so only the last reference is even reachable
> and all the earlier ones are leaked for good.
>=20
> Put the reference as soon as args.args[] has been consumed, both for
> the initial call and for every iteration of the loop.
>=20
> Found by code review.
>=20
> Cc: stable@vger.kernel.org
> Fixes: bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_nod=
e() helper")
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
> =C2=A0drivers/pinctrl/stm32/pinctrl-stm32.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm3=
2/pinctrl-stm32.c
> index 6a99708a5a23..93127da05d56 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -1666,8 +1666,12 @@ static int stm32_gpiolib_register_bank(struct stm3=
2_pinctrl *pctl, struct fwnode
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* get the last defined gpio line (offset + nb of p=
ins) */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0npins =3D args.args[0] + args.args[2];
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0while (!fwnode_property_get_reference_args(fwnode, "gpio-=
ranges", NULL, 3, ++i, &args))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0fwnode_handle_put(args.fwnode);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0while (!fwnode_property_get_reference_args(fwnode, "gpio-=
ranges", NULL, 3, ++i, &args)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0npi=
ns =3D max(npins, (int)(args.args[0] + args.args[2]));
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fwnode_ha=
ndle_put(args.fwnode);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bank_nr =3D pctl->nbanks;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bank->gpio_chip.base =3D bank_nr * STM32_GPIO_PINS_=
PER_BANK;

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>

Thanks!
Antonio
