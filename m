Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013051.outbound.protection.outlook.com [52.101.83.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DB476CF2;
	Tue, 15 Sep 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464865; cv=fail; b=QEq1YwQ8lcd27+Hnn4NNHeq6/v7r2NZQav7BnD9GfeHprub7bicMs0OMVxfrjfQO5hr5jqEXmQMOTl/RG/K8rOHbMlEXUhLtj9zu05XRKoBHk9VbSBV70a7AWFBQocoSs6szzazHmdUG6whQIgJ1iejbA60HzkJzpqSv8cf94f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464865; c=relaxed/simple;
	bh=84fiu0VgRoknUWoX60GEwc/1brRCMDqkb2o9S+B3XXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AuxBMxYaxgjfrH6OgctBK0F92EMXNbEkBADw795XeiBvBoFYmoBWb+ZEVMbxu8yvcZesGPbUxI82tUAKLrCP/vDgBo2+UjSPeoLEbmAqXZPeri3w25y6TDFztGEg5g59E3N5jf76ZYiit6nxSEtp0PDPM6DIkXKaqRchXJJsANU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GTUeMh2+; arc=fail smtp.client-ip=52.101.83.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GTUeMh2+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgkUWgxfTWZn9PKclD2xg74PBq1INhGrzQh9aidoNAxC6Fbgx0w4Tl1IEX4zMEiRx4dlmJv5DbiTvPSgdAheM4E5JzHhVLWKTtXPhW1m4Wgh1SCOddUqgcvrtgk5XSMqF5wPuZEV5skPGXmjMSlyn3SOF+SMz0/mgglwGC/+nAfiRzyIDsnSmibZGGQA+p+BINgX3GA1PSsauByMBsexPNuuONMnfE6TPh4/gTlHvuw69DEY7gzeA5ABndelEPPrRSHZq5o76LsXcMEHLaQZB4tpl9aVOXPomI87kviGio4E2SAv/KtkCRbXuBSQDMdDvrJRJ84NcckceFHxEbPN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnuu09FHWZODLJHjkXf1sJv+xU2doLW3WiUmVfq2LeA=;
 b=lpHaKyV9s1x4veKqvxlmfDL4yo4Rb1FL9ROQbz51YDA24gNWWG0AlQU+K9H24Qgd7k7wX4Lq88WhV1BoxOV72UJZRhGdx4a1ZqolH7wJsp6enaiGZO+aQbg0NNfgd1s/QvFHLZ7I15De7ox65IdTJHu7J+eemw5qmRXs9EBlFW8cm5qMRNm821yWFra7vDjVfa6wuNwZwhIjiDbXVfedusuo1a3r6LBtBjZCJPuf5FFtzNOP7ZvoHcsAwo5SpcFwwzDoOcGKcQvj+TlRSCh0/h7F8T0yuvu9Ejqq197JnCdJh1rLEijXAX8ISTZA3HCTrkFdZPzj0MBe+mpSq+9uPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnuu09FHWZODLJHjkXf1sJv+xU2doLW3WiUmVfq2LeA=;
 b=GTUeMh2+BXyHdQxH16mqx+siYjodPoNP+VFbju/M6Yr20CORUpM+dIayrUhkklHh5NeHN29ZI9lxUIX9d5FNVn04d16V7bUAvtHJSPcxPfaIGY3r++cOtCSLJ7BEz9ccAvXLyMKFeBHnTh4T8bMPHhhDD4dpt97sFPHGb/5mME9k+ayicNjmWMlisvVqaNEJWeq3h3OLqUwkPIhciOx930TYq+zROfUlvy5iS+LsJ5sfGsGpV73ezpcKO7qHl4mNA6CehOGaXIZjQfA68aL2nt0NZnVcF42lCjesNhuNPerkFueVbiMMdEnsjy+OWfEKHx+pRJ9j/NAcsGwhhrWKCw==
Received: from DB8P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::11)
 by PR3PR10MB3755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:34:19 +0000
Received: from MAD0EPF000008AD.eurprd04.prod.outlook.com
 (2603:10a6:10:130:cafe::7f) by DB8P191CA0001.outlook.office365.com
 (2603:10a6:10:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Tue,
 15 Sep 2026 09:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008AD.mail.protection.outlook.com (10.167.241.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 09:34:18 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 11:40:19 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 11:34:14 +0200
Message-ID: <8d9057d8-3ba1-46b9-90e6-fd1911332806@foss.st.com>
Date: Tue, 15 Sep 2026 11:34:13 +0200
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
X-MS-TrafficTypeDiagnostic: MAD0EPF000008AD:EE_|PR3PR10MB3755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b53d905-2ae7-4a3e-911f-08df130c8403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	GHUaM7RYJ8UXA/LvzfrqEvck9mqIzrow55Rk76/7RfISWu5pG/rpvVZkZBqXRvMC+Fn9K6dPxWyplH1npDoiBdt45P2t1KgeNeY7cvw2Tu+j7ulIV5Kr2CKyLQFkupRf1MDznsQyp4BnGe+ZJoJp6YwQjw62I92No5MlP7R3zQxtu0Kz9pVpbmS29VxZKsZA6CVcda2a+oKBmgxqVwy1pWcgVRXHgvBett9BD3/IzMWVpFOgQf9lGA6v0EG7aSK+SzCCwYtjTwJOgTHu+sqvlHPI+s1Q0c1GvkibAheBbFxiskHAnisCsk+eWlmtPr5LSrsIAXAckmUhgNJflkPlWB2kUvpavGTEMPopOL/46WOOMdli8Daw6tJluCsS2iz4I4QBgzBl7q5iE8ixQSsDW5XbzEO5PSZK6tMJkMHvEMSd4LmXD0/DBGNfxHLuRrSK3nmsWcJP4OJTUvH2otxloZbfHnvoMwdHfvxNIpZq/Eg3nmUejrGA8DaKpoe0DgaZ5CutxoL6XIOITO3b9rbY7+RXPQ3ale2ec5E55Nhe30IM6IBiWk0bHx02qhUDI1RjDBFPDzj3GbA1R1pq8AonmNJ0WiN4+l7a5YvpJIzyngx6VBKoUcULN1au/CdHlCcnh0VY2B+6VK2Gqr0+V5jZdoV9gT3wOk2xasy9z0Q4gQqU08zd610Q/Ot506jMpMDrdMRTBtgrO0TQ/aRK5X7JEQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MuxblD3NyFuw0ihcTZZ9OWCQjDGiRYCXHtjem4gWMjro7+KYBME9GKuuBs86YTQYtjLGoknRvulrPjI4QEDWzEGMG9WeupzDyekpll0dgrPcLN/E0uoc8cR9TPLhgGAO4wnuusshGPUwAUHYuaGUt1xelyxXEdzXMTASyMo1C5Elxgc2+fMywh2iBpOmG1kJtJaZUGx+TDjWybiFBJY6cG+XFOiilnyif8vFK22B5M8opBeVyMfQlyHmCR2aDDB55ied4Z+kRdS8kxkAbWSBafajv+25ey95qjlz8xF0wGqPM4Dfk6APOKjARHuaUEhdPx+v2rbEDR9q4uFvYgBnGaRsaG+C7iqxdifTHDwoD3ntTaor3fw/CK41qiMLAuFAkrxNvTyOz16QpDuh6MsVcqSbEJDzWzRSKMQz9TgMn3oT8bztTFJw9FEF6Gbu7VFu
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:34:18.4003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b53d905-2ae7-4a3e-911f-08df130c8403
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3755



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

