Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81B46EC61;
	Tue, 15 Sep 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464531; cv=fail; b=JyLuwp7kWg4V0KLUh5OkaSqF2K8W7vcO3pVhEJBM7wVr3h3oWfVekTDvRs5JiMFB9nGaRFqln27zKocUBEVgDFi3bRwAmzZPCCE1Ii3St/ZSBPOxf5IgOB+ptY2+1WID4d1n2Fq8QNf40XGCj2FUMjf2wXtxq8ldRm86z5cqimA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464531; c=relaxed/simple;
	bh=en4VwktEestKc7wi3+hokhbYX57OBOWo+QQukZXdliQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FJcTqFKPN/ZDy0HaFUFvS7ihFQJFIrlbzZenqkFiE5wv05kFv+fFjdWwfoWxdLt9+B5LsQ38ycFEUKfrcFCee9CuhJUGuTFFsjy/1cF7U3FrdPt4YuAK7HBU9WUiCBO9fgYzW2KuR8vUI///pWOfTQPzx7DFXYx1/zwIpj9EWwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=kKTLWv1F; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="kKTLWv1F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKeJZaW1UFN/RaYWtrzBR7/CLc77uBr25rk46eoy50JiYrZYyvEr+tE4yAoKgNy1fV41WpRhNJbT5W/o0DD382G4N12CylPicjkAp1ln5Xd0WqvnG5GgjxqzvucoNBjWn0qXAnX9GCpFTrGcU/MP2tbJkAKZ6rgd2s+50cbkmuwB14lI475mEDuXdK94C8Zt4j1W/SaPNxPpvYXTpivX9NR5LsblpOHibgNqldyXi0ROT+2V9/1KJNnRyRkrfJd8fPWTELaGa7FWienQbUP3l5cF9nz6dwXVANk/G/X5bwnAvxO8s7A1YqI18+AFjyixyeiDXaQXkFckVdOAGa/HVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJu9pMXbUu/S5XtdMwkglNmdfanvW2z8asg04Ck3FsU=;
 b=Y+eRefpJZKSX2Hpq6PJ+r8X5fz5z319Ypna1Vp2lluJJThIUHZNBZ5QFr6JBdBxI36aR0Dc8gTR03WK8aEf6xwgEEO5nX5yC/4f7SFfsjaJnzsXMz8A188iQQYV6pos1wvm+25h+PIrCFCBJEkkqYbIzYldzTzV0V0w8o7CLo+XOfh6xtO0wRpwWBvr6DTNzrehT9R+SAAUFEWdLJyR2J7oRN6NV28blHDQJ+dxF42Uq5u3CCBbapSt9wRAL9UVL2LJdA/q6d3U5KDSDASQnqTFYkED/XNbAE33aStPkME7WNAJlm3wULARMiEwOeC1lAzQhfALj3b/rG59sFYW43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJu9pMXbUu/S5XtdMwkglNmdfanvW2z8asg04Ck3FsU=;
 b=kKTLWv1F3xhk8Kl6BSTopIiMTc5CkJSmZ3fS4WKqT6Xrm08aqjTVu6iWEuqnuQdP2rEgtkfi4ty/wt7QeX0iRk6jGwHoSS0p9EU/QXr/WLUhg+Cmv9bGB33+J4k+TPom0dqD+LIlG3kI3WBiZFoivLUjgvVvZnYOA6oUapGrvlCN/FWlsTL3mS1a7APSneZgrK7ScD9lp9sYqpLjQDJb2vjb5APc6i0PoomQ/0dNpWWR7c4euMs9HKjwLw2hvX2PLEqC8OZI1aRXoOyUmlW+4lUP8WuWx5NyfO5wFkmA+tzP/NlWyfwd7uMBMBY8G4X50hKLPt2h5pjC5bV1B7EfmQ==
Received: from WA2P291CA0003.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1e::7) by
 AM7PR10MB3254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:de::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Tue, 15 Sep 2026 09:28:44 +0000
Received: from WA1PEPF00009B3B.eurprd05.prod.outlook.com
 (2603:10a6:1d0:1e:cafe::40) by WA2P291CA0003.outlook.office365.com
 (2603:10a6:1d0:1e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 09:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3B.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 09:28:42 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 11:34:46 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 11:28:41 +0200
Message-ID: <cce8b6fb-eeb8-427e-b002-38ec6e8c9e60@foss.st.com>
Date: Tue, 15 Sep 2026 11:28:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/st_lpc: Fix clock reference leaks
To: Wentao Liang <vulab@iscas.ac.cn>, <daniel.lezcano@kernel.org>
CC: <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <tglx@kernel.org>, <stable@vger.kernel.org>
References: <20260915054804.1729741-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260915054804.1729741-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3B:EE_|AM7PR10MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f79c6d-383e-4249-0281-08df130bbbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fvj4VIC2leO+WFhw7zJaPoRvHjyO8f/KUJmRrzqe23HmLbap0K0ZZ/PeP4K+/8PZcPkV53UOC+bJj+ETiaDHVatZb7UDqt80UUpeVgTNO12lMNDJL1nkRW3P0xejHf7hN6i+r1kOQWjfV3EoTmi8uQp90tfValxt871pgCoMiX7SjHXaGMpT/1w9JAM0/rCPy194Vi0aVK6Nd22+bkU1gsMqacllia8kfiKF58ebUZTAwnFiKdnwMDQU7hHKYqIrmmURObwfAChGF6gSWE1cQVUbNeu0C6eWoBGAGCWrmBpAoC20emQbHK/c6RnITn4PCXaoNoKy+zV1ZPL3KE6FBmtIVPo+rlpPmem7KJp5fLV61X6h35wvVmfNN7hx2DEurZwOT1wHnlyR2RaVDsPmmI3cdoIwQa1dZPIVxUJpR9N5sS6U1npW+DHm9ufA3e59ecOGz21CZGvGsCsTyCcUz2Nfp0a1+WUqqlYG09keUYKkzbPPyZum0XHeksndw2g7vwkuXUjX0kXhhQipw5+4gjCLiRuh5mZ4OrDLYP+F1h0sYR97q6Dwjr2Jte1XBtISfBJ11N2GlCoGI1U1lJV/F1JH7E8eTOKvALv2Lhi+o0PZkvL7/yqoTl56m+4wAbLo31ZISb/jSU/pG0diD5kPcagWe21xAuXWIfA0gEqaoxg/NfeMqCfvc4BbjL7fQt/CR/yZw3b73o4DbcKJgk0vjA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/IvJuYR2nyXY+cqyqT8MJfypgQswKcsnDJyoTA95upFHfVcLPFoU1Nz3gfCFYeZ6dvbMcXdUYJRqXHnE9NsfI2yaUXwPCWuZ8mU/gqhOrmWnJ60DpY7wcSK0DVrP6sdapn9qrj9J4GOv9AY7GH+cXPHYD5wQMCy1tZ3Y+53AqNzu74JPEIMIO0QveaWnAYgF19W2Zh1hGlo/MTog2dR6wfLCqqSyrNKGH+95vIWzvrqKfk7013GbTUudJ+CamrUJxhvAIYqIXQF1P1FOW5qAcDSKHuLSFgoi0W4GleWMzdxUyBcaqSAbXR/O1l025B7IMOcDh+79O/waTFkbUf25PgALH66G/JwJw87dsq5q4PPeU56m2GwidTUJanWU11k5433SRw/RrJkrKmYVn57PARRYxWf1xqIeh5QL4R0/rqBiC6I8JF2MqkeyhAUUJNX9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:28:42.5078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f79c6d-383e-4249-0281-08df130bbbcb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3254



On 9/15/26 07:48, Wentao Liang wrote:
> st_clksrc_setup_clk() obtains the LPC clock with of_clk_get() but
> leaks the consumer reference on two error paths: the
> clk_prepare_enable() failure path returns without any release, and the
> clk_get_rate() == 0 path only does clk_disable_unprepare() without
> clk_put().
> 
> Add the missing clk_put() calls, mirroring the release already done in
> st_clksrc_of_register() error handling.
> 
> Fixes: 70bef01c0f1c ("clocksource: sti: Provide support for the ST LPC Clocksource IP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/clocksource/clksrc_st_lpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clocksource/clksrc_st_lpc.c b/drivers/clocksource/clksrc_st_lpc.c
> index 419a886876e4..574b966eeb34 100644
> --- a/drivers/clocksource/clksrc_st_lpc.c
> +++ b/drivers/clocksource/clksrc_st_lpc.c
> @@ -74,12 +74,14 @@ static int __init st_clksrc_setup_clk(struct device_node *np)
>  
>  	if (clk_prepare_enable(clk)) {
>  		pr_err("clksrc-st-lpc: Failed to enable LPC clock\n");
> +		clk_put(clk);
>  		return -EINVAL;
>  	}
>  
>  	if (!clk_get_rate(clk)) {
>  		pr_err("clksrc-st-lpc: Failed to get LPC clock rate\n");
>  		clk_disable_unprepare(clk);
> +		clk_put(clk);
>  		return -EINVAL;
>  	}
>  


Hi Haotian

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
