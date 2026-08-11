Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098D40F740;
	Tue, 11 Aug 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459357; cv=fail; b=fgi5ZmUIR7h/X1KQU6t6NvuztqV1mOrX/wIbdyt3GO1yE1YKZnyHzYsiGUFKQ5Vp6ESsMYAMCgyXLRbV7uTA8bXeFW1lmm9YnWS2XIR97tC/UP4BrDhfri3+loEQkRfJ4wLJhvJ/HEmbuEL8oafR4upFI0OSto6wyMT0Kh+uNnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459357; c=relaxed/simple;
	bh=R8HrOWA0D7vBdHz7Z0V5W0Qn1x4frDKRZZ39GSD2NkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gIfpFdF1FroQwdOKJ4VIzSZcsCecyuAOK1ockDhGNbnOvzixCHEUe0kpUbafkbI9a9tNwqYRUZPUwzrnd5PW2l5ciBpJCNwKve1B1dav2WQjNB0E2wildOW5gRbmzeRLdfodoxmyVlSmGSEx7AGnh++03/HjGVtd4RwkxbICnlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=LFaHFy7C; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kAfDskZ0; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="LFaHFy7C";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kAfDskZ0"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67BDWH0g1650161;
	Tue, 11 Aug 2026 09:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=itXkSoRYa3aDVXBSGXTprit2S6lIr63QqpP6k7WSy
	t8=; b=LFaHFy7CO/pRBJrVV20w9WIZxct991yaultaylNz5Fma567a0Jeyv/M2G
	hNnOpC/0JcUVGJ2aPEGYyHbQC/d/MNhRiBQtc9Cevtfivdd7cQ2nlUaXM5wztP5H
	0nbcPe34nwehUOyWnEr7bz3JaWQv0TJM5JWJBAC/sMY5P8cqnxID4lVXQkFbLYIz
	tlBlNjEo0LZtugFimbCiogRtzx/i7yHVJL1XvoBcKbExf7ihEpsotK/EJcrnNhWe
	jscFj3f9yN07vX9tvMry4YO9nyqADYpFZgh9/lY0ZuU8k1v8O+wqG+ZcJMlUvLXd
	6tNaWN+PrqGpD1wAnhIRJaCAO3F1A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by m0380145.ppops.net (PPS) with ESMTPS id 4g02pb9cum-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 09:42:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOZTpxsPb87yChG3YVVNdiSWD8YJHGs9djzBLn5KbHD6SH4EvQ9AqHmdwZaEspV//GZWrL3mPhn+Mh85uXQzm6CxTW2ona3MUmQK86UEoYaXXkCn9pOCfg2irE3A4ezdofRz+LdRmefHqpCLFnMJe5CVzcAu6Yto8kG8PsUA6/1kfScBfKvynU2ALUmvxQf4kFoYf29F0ev6brhHAy2RfHc/QsGUxap+4fTwgJmVnuHZQ0nd28epZWCDH7JO18aI5MZegRNxiT/kY/UL+wvP8nyEHY4vgajgUgn3uaNRkcTX95MOOmsP6lJh2xdvLd8rdMRiaTf/7z1nUG4F/SjeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itXkSoRYa3aDVXBSGXTprit2S6lIr63QqpP6k7WSyt8=;
 b=hBTrVOQ045Rkrw3iKJkWgxY1CS01rieFZx5Oi+WDD3KyLd6tQeTC3GQ1Mu4SYOTIZX+KVqR39sIl5sThO2mFjBNAK7u8SWtVqIPjZHR7ErVhv74nCi89ZzMn6uPtwtEqJ96zjZbIx2hVh3jL0WMyACwFszNcSD7b6f9eZu3Ay+kG6nHiFHDx4NX6GXZoUPF1EjEpTafCy3gUoopbYh3oSfm5BcaO7cwFQWYuR+fy6A7nhmxfd4WJ6q+uH6BbhXSYvu7IZvu/xZpViMIa7oorU64NtRuuyP46RfpFc0FrcHQ2jX1UOeqZPLsb/RuIJVtuBEYXoIs9z0MDaF9LgYnvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itXkSoRYa3aDVXBSGXTprit2S6lIr63QqpP6k7WSyt8=;
 b=kAfDskZ0FgOuqm13/J63SZCvnJPKnY+41L7CIZ7DYjdgUmpHXpUoP6PtYjg46rybsH7iCnzaQFgyb5wz4x8H1yPvUIQ53JGfAj8gAJoxOu0cxrj45iBQrWnKU6xetE2kUC+ej32f6CbTEc5DDIQMo6rPulT9OFQ60NduR7qVQvs=
Received: from SA1PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:2ce::17)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 14:42:17 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::66) by SA1PR04CA0022.outlook.office365.com
 (2603:10b6:806:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 14:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 14:42:15 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 09:41:50 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 11 Aug
 2026 09:41:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 11 Aug 2026 09:41:50 -0500
Received: from [10.249.33.100] ([10.249.33.100])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67BEfns1340181;
	Tue, 11 Aug 2026 09:41:49 -0500
Message-ID: <7ab77c42-34f4-44bd-abb9-b9437a43a7e8@ti.com>
Date: Tue, 11 Aug 2026 09:41:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mmc: sdhci_am654: Fallback to DT-provided itap
 delay on DDR50 tuning failure
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Faiz Abbas
	<faiz_abbas@ti.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pascal
 EBERHARD" <pascal.eberhard@se.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, <stable@vger.kernel.org>
References: <20260807-am654-sdhci-v3-0-acc91d7d7e50@bootlin.com>
 <20260807-am654-sdhci-v3-4-acc91d7d7e50@bootlin.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260807-am654-sdhci-v3-4-acc91d7d7e50@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 7139dcba-e581-401c-56bf-08def7b6bcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Z+6pKHEN1/+N6PNcXT2hyg71VLohZukCUiNe7llXjQbYUykiXVXTNctfb//Fj7ISBjbWOlVBsGepSmIZaIDA3STwEaMZYmrqBdjqsW3pWbkbfKzNLrsMDgYePEhk7vk7n0y27S9xQwLgaoaII23ufNNim5uXrHZrGeWVYwsOQa+jKzmLIgUhioKOG3usZwcgZzg0q4zG6xTfyt98SSTjjyrbBuE4ZMWH3b+nAYWSRj1xnuWlAT0LSh23cMdou2NMBuF1t7VqtpnV17W/uh9ocwKOUEJ4SEKwYjjsYcZMME6p9P4jLeg9ArIeVLXogNSygZ4fw5lwKAT/B9HmziosnMa9aoslkySDjRQrNAplqC4SCwHY31A9d9NiuPiECWUm8prOTwb0F39WmukSnUnesrmvOI3gUkC6CyPcNvo9q/srSNDdaKl/GxY3lrbuUzKrSghfQhn0WikmEnqxUHn8+5UnHXE25JZ8fdTX4NUNGIuyEWPsSfzZnrOPIe9fTxhCS7fgfFDgl0YRZ+1LNvlX2afkAe+76kKODQq1K9d6a9Hhe/+OfVvSlDpKxDEbxuWqqtc04QcvBVsrCqFDu2ZPx+SO2liz/Fbw2UWaeSi1689AvbJEMXd31WKEADalE3JjnMkVgqMh2WMCTvV2u4oiNKMrk8Z1bmNRpLlHq/v/1LOJshxvyxwxZTrvksgSFaTNo3QrP0tW9X7VmmdjEWK9Kw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iiQJCnd4h4HFEF7wSNZ3QAR1v32NXDBpHOusNeAJI47cKU1pHm5V1sOUnZM38we8DUhCh1CNJDLmzMvs96zxYRzxlCS7riEXaJmodCz6AhA3369W82G6cL1qUyTZuzmSAUle31IEP/zmUt+Y1u+yKWMjW2qsg7TDvDF/M1zXV2pI6Sqxias1zarMMxsFEVKa30Z9fwQBLbahyGMz+259Ej4avqgvskA8drR66BODVzXICvM5Z1sFpzaMGJI6PlSMG+phlOHQl+yBkYvAWKoMhkIKZrdbW6BsWAC445GurF9howW+i8povXzWDjjwab+Q1+AaoFK4JwHInsslIO/tjH/uUwsQrI6kfyaWnSaOVmHlu0lLn8JQdfLI10265FUXRHi/slQnBg4YgDyuKd+BiSbOau9+5pFvcgzjGfbfs5Vm+jssKM35MLcPFFBMFfXw
X-Exchange-RoutingPolicyChecked:
	aUlXGFQSZiqT4M5l5q59wpNfCNKfQd3AH3Kqg1Ws4iN2THvO4cN7wQDtDbu16kW2dS2H/4ewu9NskQrHskwtL0aURgPPYa8JFlUuPspZVtcxFBoBT7pRtDK4l1zWAd79TUNJ+PSpyuQ1MctSSq7KJtms7WgHH1yW4bEybC2Fp6jp4QUxC1pVmMRom8/uNtqdG+C25e6Ek/PF1gEXI+6NOgRvRMdoqiFzGvJ/VtIFOdTQCRzguZ14r9dhYahxVPFpNlySYhlmCreP2KE1jtUJslTUp7JA+2PKF2V2wX8Fa2DgofdHDhv95CDP5l3Mhwd7l7naFoxJEemp8RBYZ92eag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:42:15.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7139dcba-e581-401c-56bf-08def7b6bcc2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfX3+o4M3euuhBV
 n2pp1ONO605+rlyRJ7+im+k3nnf/jolcveRWW4qmJYRAWyxCsoiMHQxSEqjrBWFIwQBy48fzydS
 QqERmujKK99qLEsLrkQebVuAxj46APo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMyBTYWx0ZWRfXzjBxig04GdO6
 XqBeSIwioNoVP1fUtYR14QKZzxnVz+3yirSV4jVVAxA0wW939yYb3q8kJoq6k0JT2RMlW2LJb/S
 t5LWPh13vUDT6dD40ID1VhhBTMhR6bUyPHnTJqbZwlrWG4xPxyA97xNxKwk9h8qne1whiQTyky7
 Uojz/lc3W2dsHVXyZ1Q4l56xInnP3sAvBvxMAg7RmAtUvwd+zp2SxJ2dm1IPRsbPQHufGVdfX4W
 BeauQnHXptpcFDOiGCPT9wyojM5Of73u5ssSelzDaOy+Vg1zAiEARTm0mXdqobe+M/CZ3vMt/wG
 FCDh6oexILcaQSjlORbYfxysPJ2rIDAGpdqKHXkGdLSN8uvVp00i6s9rgaMOVFgiOArtql9wawY
 c2kL0qw23uUqPIgrsqqXnYBC5fOJNNeJ3RV/1OdtSdz0Ho3y8+KywOnbB/UHqajw2L5YPHHedGt
 UA/RLVvkOfoxXtwmv5Q==
X-Proofpoint-ORIG-GUID: g_6LgHTzllevsKDZDAhvB3RE6-OozRZw
X-Proofpoint-GUID: g_6LgHTzllevsKDZDAhvB3RE6-OozRZw
X-Authority-Analysis: v=2.4 cv=Ic+3n2qa c=1 sm=1 tr=0 ts=6a7b34cd cx=c_pps
 a=JPzmcyOoIuAgIyAaop9pOg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8
 a=sozttTNsAAAA:8 a=N0WFTywO68r_MLHEiAEA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110123

Hi Diogo,

On 8/7/2026 6:07 AM, Diogo Ivo (Schneider Electric) wrote:
> DDR50 mode is not required to support the tuning command CMD19, meaning
> that calibration may fail on cards that do not implement it, in which
> case a known-good itap delay value should be programmed into the host
> controller.
> 
> Do this by reading the (already defined) itap delay DT property for DDR50
> and, if tuning fails for this mode, fall back to the DT-provided itap delay
> value. If the DT does not provide a value for DDR50 fallback then this
> simply disables using itapdly.
> 
> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
> Changes in v3:
>   - Collect A-b from Adrian
>   - Add debug print when applying DT fallback values
> 
> Changes in v2:
>   - As suggested by Sashiko save values read from DT for DDR50 in separate
>     variables in order to keep them across multiple tuning cycles without
>     overwriting them.
> ---
>   drivers/mmc/host/sdhci_am654.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 8ce10422bba0..8edfab5012ed 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -126,7 +126,7 @@ static const struct timing_data td[] = {
>   				   NULL,
>   				   MMC_CAP_UHS_SDR104},
>   	[MMC_TIMING_UHS_DDR50]	= {"ti,otap-del-sel-ddr50",
> -				   NULL,
> +				   "ti,itap-del-sel-ddr50",
>   				   MMC_CAP_UHS_DDR50},
>   	[MMC_TIMING_MMC_DDR52]	= {"ti,otap-del-sel-ddr52",
>   				   "ti,itap-del-sel-ddr52",
> @@ -144,6 +144,8 @@ struct sdhci_am654_data {
>   	u32 otap_del_sel[ARRAY_SIZE(td)];
>   	u32 itap_del_sel[ARRAY_SIZE(td)];
>   	u32 itap_del_ena[ARRAY_SIZE(td)];
> +	u32 itap_del_sel_dt_ddr50;
> +	u32 itap_del_ena_dt_ddr50;
>   	int clkbuf_sel;
>   	int trm_icp;
>   	int drv_strength;
> @@ -579,10 +581,19 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>   	} while (++tuning_loop < RETRY_TUNING_MAX);
>   
>   	if (itapdly < 0) {
> -		dev_err(dev, "Failed to find itapdly, fail tuning\n");
> -		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
> -		sdhci_am654->itap_del_ena[timing] = 0;
> -		sdhci_am654->itap_del_sel[timing] = 0;
> +		if (timing == MMC_TIMING_UHS_DDR50) {
> +			dev_dbg(dev, "Failed DDR50 tuning, fallback to DT ITAP\n");

Its not a big deal, but it would be a bit better to use itapdly
according to the datasheet instead of itap (:

> +			sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel_dt_ddr50;
> +			sdhci_am654->itap_del_ena[timing] = sdhci_am654->itap_del_ena_dt_ddr50;
> +		} else {
> +			dev_err(dev, "Failed to find itapdly, fail tuning\n");
> +			sdhci_am654->itap_del_ena[timing] = 0;
> +			sdhci_am654->itap_del_sel[timing] = 0;
> +		}
> +
> +		sdhci_am654_write_itapdly(sdhci_am654,
> +					  sdhci_am654->itap_del_sel[timing],
> +					  sdhci_am654->itap_del_ena[timing]);
>   		return -1;
>   	}
>   
> @@ -758,6 +769,11 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>   		}
>   	}
>   
> +	sdhci_am654->itap_del_sel_dt_ddr50 =
> +		sdhci_am654->itap_del_sel[MMC_TIMING_UHS_DDR50];
> +	sdhci_am654->itap_del_ena_dt_ddr50 =
> +		sdhci_am654->itap_del_ena[MMC_TIMING_UHS_DDR50];
> +
>   	return 0;
>   }
>   
> 

