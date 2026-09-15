Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013042.outbound.protection.outlook.com [40.107.162.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46C480941;
	Tue, 15 Sep 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464909; cv=fail; b=gwQbq7Hm4ZsJ3e9HrYX1Ipkj6bMq2MXwjs2E2hgsPx460danJBqEadwucXediYTonwidukFb2YcZebhUT2ex+GlcptfvR8+b62WQ7z5cpTjihbwi3RwVTNKjNmhmzdflnyq1fkXbXcBoxKRGBMKMXEFGCd8vzDyWsXNl71visj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464909; c=relaxed/simple;
	bh=rcRnBoejtHzQkxdMGdonyf4WcQWjp1CZYXcuXaij3oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MebdLW95E8tZ79gMSow1dgk3ZgiFxZ9V1HCl8YHi4wbXRgB2SAiQfZTwxvK5Y5Ij04rcPMGj+S+FFyt18qt9H+EYjMWE1uBz6OF0uWD7SRpwJPg0tZxabRZGlPGWnxpSyeGkZnhoMN1tX1JKpSZYFmr/0hJbCESpb82X4hfqNd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=H15hngsu; arc=fail smtp.client-ip=40.107.162.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="H15hngsu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdjvdyFtvTVN4Iw7W2IEAzqqhxUu5dQlbcY4sErJG+HeLCeDFIxenhnYHfXKptb8CWNLd2MvszI7Iy0LnxmtfcJZt+FMzVVBoTy2J7OeEyJsrPHcqY61X4yAOYe+x8U5mhK3yEw5pKwq+exGjC3A7hKDJInGtFOWspN4zj5BcITt2ybqGqvFrXKSBBb4BcjJRNVpYriNwCjLAB0wVYxDgHaGgee37eOsFCTYyx+2g5TZ9dDAWm4NPszZc4x6gUs6BSIhadPS/0U1F2qnp27SJUvttn0+pFKDUIhp7DTXvyPAg/4JlKJUVu0qunwGBDfP+FJ42SxNCwExLr7ds2NtwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTbcXClwwsu10AbW2WQ4gz0c4Cr6/fUav+mNCCmUa4w=;
 b=cyfJKwWfskF4I/GiI3wwLx+QQAN/RBN2zbNMuTxIZBckAG83w/HeSBd3iFes5P1VvtGxsxWqU5s1GlN9E3sMCHAyNmE0cwZawY+gCN1l9RGhKfNxRZc8pVol8r3p0hQ83EwUATL1CDiv8gE9mK+UYuwTDw71U0dbw5GH57GAP12DowhME8vr5k3xKaAyMCinXt8ZFfklGRkxLwG+TIWUwP0zaCPJ6T+t9P4mRSfbphiOkeqXO9SXWJ1hM1yQ+ETB+hoC0ja0ySdhUGR8KG176wgqlHgivMh661yzplGEN80lsqVODFUvWCBmN/URxFwcRQL8tOCpEvEGYl8MZKchIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTbcXClwwsu10AbW2WQ4gz0c4Cr6/fUav+mNCCmUa4w=;
 b=H15hngsu1shgYCuP5tIghBCPAwgJ1ZQNtU3sYuG4WMZiTBCjnvN7CJKhRV0h8A5QVESXzItmxhAda6jDu+sym+JuGD0svY58Vl99I1pQLPNKyT/pPg0MzTsp05puDpQA+GuTTBJNZ1jA4YAPxd9D0luC408y6xZ4OPnn84f6WWHYUqhlWpefngj7+Jih6h3DbU7qq+BUxxkLIV1Rf54QpiDckUjAjC9gOnrU9ydTK49FLmxChyRS45anOh31LW6ZtXAGin7w2aUNRcY+d2ngVD9fsS/dpFnuwQFqEy8xa+oTg7JfDE97paR52oyvm18VassI4Wun3CdxZVi9iwQbcw==
Received: from DU2PR04CA0216.eurprd04.prod.outlook.com (2603:10a6:10:2b1::11)
 by AM8PR10MB4003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:35:02 +0000
Received: from MAD0EPF000008AA.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::59) by DU2PR04CA0216.outlook.office365.com
 (2603:10a6:10:2b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 09:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008AA.mail.protection.outlook.com (10.167.241.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 09:35:01 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 11:41:04 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 11:34:59 +0200
Message-ID: <94c33607-00e7-4e2e-8e98-3466bc522fbf@foss.st.com>
Date: Tue, 15 Sep 2026 11:34:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: ohci-st: disable controller wakeup on removal
To: Myeonghun Pak <mhun512@gmail.com>, Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin
	<peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260915012011.61874-1-mhun512@gmail.com>
 <20260915012011.61874-5-mhun512@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260915012011.61874-5-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AA:EE_|AM8PR10MB4003:EE_
X-MS-Office365-Filtering-Correlation-Id: 2686f930-bb19-4efb-c41f-08df130c9ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|82310400026|376014|36860700016|18002099003|22082099003|5023799004|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SnLCPi1AV6OuOA3sbCCYJHyj6QTCtntGCsJBjGalHTvOAx20/CeLlT5AWM2EcUMgfXC9gdvpgY4zbygABtKwp+N0fLqB4FTHFdWUOfZs/kpp3jDK9PdcDIAL0ZV6g0MySDmPv4cxNmPxhaT7RBGFFOVPPTqT8mDEVagGyQBqW8LzGTBeNZpEoUHkBuw+DNoB3iP2pfYnXE8eQ592ovBiXhYspzG9B6l+8erJdWDqfHl5ZywIkjcRpNxt5mQs1Jzec2csTxSuGDFAA+PAKWFlGx/gw3McMlwECrYRJKevvayQZ2EPRoid+PBRf2U346PMjfwq8Is/S9SO5qxLUw2+pF9IxD4rVWJrhmGoOe21yW9fk0tYdQMGWiuwmouGlWdNnogCUtuPbhMkRHvAI6+TcvyCJkdIMcHZc5wZJi51KrpBMvWZ0nPTnAbL7G8aEP3AcuuurAFWFOd22cyS9vXgUM7E4tmfKomZhStUsAUE1hab6eUdAbxo8e56ek7ge9drtRmzrmbVmlGjqi1INYjQE8dELgHsS06h4V8kBFe+bvoU1TrRbOSUaEmfHrgYqAN9x9KCNOwHAsy7nNC5V4qrQype3KZeHyoz2pM+TPNISOXmudLJWkOVRRFAVw0wrUhVQ3kITbWHjvn5pepR2yGhmJsRHrcDaI0HsEkCVpZe3BmqlD+W9Z+94wjCab7bRBT92deDmJS63WcrMZY7x0eivA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(5023799004)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xmjSmNdjAUCkM6JK0SqS/wfq+emg7iF+kklTHMQ6Cw24bhtvIM1tsdiF/SP/9kHrOiwyUatcMF1+ns840pMfJ2qdFMpH/rRsTD5s57tnXDY9A9A8jEDr8Z/oywh3pzEHG4/z8T2WLvjiq2fBx/ISQwCUOtQkfGNLzwIPRSvo2cQ0woG/XozO1BW/HDOCMPrT4b61jk0L/aYnZUMF02LzHHk7GXBz3v9OUfOAkD5En9uqqMZB6wGcIsY/VejmNorBy/3Ga3pMKmIFECtjIRjZiN7bBoM7ojSRWtyvI9P/DNqxPgIE6GGk4knf/3GsiqEBMBY9E1QMsuKXNF+2+SfA6n+RrioRweHEupONQM/EoC/AKK3K4mjtbB5aRja9vNLvCggaNB8vqMKM7Y61JvOyXizHM9IvYi40G4qmlcGej8C7ETvdpGkbTXFdNliQL8KG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:35:01.7759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2686f930-bb19-4efb-c41f-08df130c9ddc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AA.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4003



On 9/15/26 03:20, Myeonghun Pak wrote:
> Probe enables controller wakeup after the OHCI core marks controllers with
> RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
> wakeup source can remain attached after driver unbind.
> 
> Disable controller wakeup after removing the HCD.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: d115837259ad ("usb: host: ohci-st: Add OHCI driver support for ST STB devices")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/usb/host/ohci-st.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
> --- a/drivers/usb/host/ohci-st.c
> +++ b/drivers/usb/host/ohci-st.c
> @@ -235,6 +235,7 @@
>  	int clk;
>  
>  	usb_remove_hcd(hcd);
> +	device_wakeup_disable(hcd->self.controller);
>  
>  	if (pdata->power_off)
>  		pdata->power_off(dev);
Hi Myeonghun

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
