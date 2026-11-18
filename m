Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015524;
	b=MeEC2GcZPwD4UxmD5ahrjJiv0F2s4btfDirrBT6OVcirO4a2RIRn1U/jPNVUTxqECwh3
	 jljUClymY8Lvo3qnAFrcjkFrn3drHPAxik0K9g1UorLkR6RQ1Q2odlyRiSI2Icc98M7ch
	 OzmlubRUjpdsPCNuQAy28Lh8IZcz0qvMARkFJn5p7Ng5iECNvG+CDO6S/HaJ4w38eEGbj
	 0BaEE34QdhvysLLhuzTSsKboUmY4of/RUai6Y7r1jznW1+Gnt+nQL0S1U6vPesNAwgcZ6
	 XwE8UqoM3pEYEdM0w/DSjoMEYTsRisi9yWrSDWTMi3ZoGE4VxLDNUZtfq9EhtGCW3ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015524;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=g0g4io6Yi9vEUzFvaHJk5/CKxY8b3/ttJE+tckycN6o=;
	b=kW+67PC4GSbDluWCRYfhB9IFZjSLYp7PZVxJIQYwI9qLub5SlMr2TTFX064Ooi3eIqlJ
	 mz7CP3UZZpq2Bz16Wf/Ehwdlj5LswHiKLWTS/z5tfA7ufz9u73mjwI5d6YkqwEj3zmap9
	 fnBhCHMqOSt1B9hdyEweYEb1N9WL9cZlPVa/9L7FhKH93x4o8C3cBf//KiB2vqDepMvR1
	 hTwye9WTU4upCvj2LJHsO8XOPJOm944sRV9yiMjDIwF9EUKoSINysN5qOe7MfaUmlXAHN
	 6lEH293w/CExruMvAechpAG2ajnxpFdxbvkxQV+xw9w3Tw6pAgeFFH2bQRH1HsPiv2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=CdmbG308;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.24
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B75E60A260A;
	Wed, 18 Nov 2026 15:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B75E60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=CdmbG308
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiqQtg54g4/fl9SZveqeHlEHbnZx6Aibcrz29Pf6rsmnGYc/8GR8dyU/L52riSeEYo4JSndImxjOPVCEOB9rvUJjO5fJOFKevDgS/4PFalmQ2LNyT4AelSTqikMkrTffz2u3CWGnzBw5TwAs6AcztNIWB76UBl9S0GhI6Ub3sco5BNyNNsvNQynGYYbgXC5VXge4H6BgmjeyOay98gEeLWjGx36RYzbF7yJe1u5bvbOJCCF2Iyjcda6lXvW6OqjC11WCSgFLzp5zYDLqFk1bb35C4n6D75quiCJa11fF6l+wBlNlaOE88S4hJsSbq+04BoP7qkbpWancuPh1aKpM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0g4io6Yi9vEUzFvaHJk5/CKxY8b3/ttJE+tckycN6o=;
 b=vNCj0QyBnViYs/x4PEFoxdSFRKkyC0h9koXO8gsvTst9NaL1KlbJDtrmRYq+i9Qm/dKx/NhOwq+xc0p1IuCWYm7DLxIqh/bhLMlXnh7BMgHug3k+0TAKYk1jSgfsFffaey2dux2bVxmZaPTUZPxDIuxNcniEFhkKbygXuFoVlX2qoXmC6JEpqPPwnnimJidyn/sII1OB/7CoPfKMznFLOKNmnLp7EqQ208eGjn7gFUrZP0S87cB+o9InfKqpFWPKFjK8tMSavZGkvzf46NdM+zbRgmbuxcMwNZfSsEPkciioCG9jYAP/zGei3/7EU7Eun6oBM6aKjbNGLHHgOzi4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0g4io6Yi9vEUzFvaHJk5/CKxY8b3/ttJE+tckycN6o=;
 b=CdmbG308Nija/Ttbt8p0j1YU7DIdq8nsDemGHe1NqQZU48YrxmKZXrApKqOz8Gq92KyFlj7EE5q7yj6egZoccqHEpv4D7LzHE/fanlirV/2Zyn1GfB4QNjA37nj9sE4MTjVhMz124mV9G1DgakvvyHDm3D8Hxqzke0ZNjtZFQ7yquyLckEQC4T0CMmi06A6+r7SYKBDzyho4VEr67+UoIifm4qPp0oQbMd3UqgxsA7Ym1eFwf4hL9fWC9JzzgOpgPU2HICtla9b+6FW6rhT7ZNnJnITCnXI8QDpNWe0O7bNQbSh2E+9CrwgCEO1r2aWbEU52rCpNjFjWCB+FEybptg==
Received: from DUZPR01CA0052.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::8) by AS8PR10MB7899.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:629::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 15:25:18 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::37) by DUZPR01CA0052.outlook.office365.com
 (2603:10a6:10:469::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:25:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:25:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:26:03 +0100
Received: from [10.252.8.55] (10.252.8.55) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:25:17 +0100
Message-ID: <90b4417d-f2fe-498a-8128-3229eb284d8c@foss.st.com>
Date: Wed, 18 Nov 2026 16:25:00 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: stm32-dmamux: don't resume runtime PM under a
 spinlock
To: Hyunjung Ko <hj351016@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<Frank.Li@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, <dmaengine@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261118082853.926607-1-hj351016@gmail.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20261118082853.926607-1-hj351016@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AS8PR10MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdc56de-c934-40c1-a3c8-08df4588272b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u1MvC4h1jMw/+vmtWaQo1IymemcZ3c5IJVCDppvzONik5enmucdj/r0xh1H2oheeVkgwFxM7uz/2DZ/RIZU9/9dFxE/3wVf5U8qaVUN7cpAgalYxfxkK9A5LWMETCOzHnGv2tcwXjHa/g3OjgsKMNEdmKdxotWRGH7te9SfW6yzjyMo7JWzdIgRbM1KyCcL/XRrw3thPCX81VRu+E9/elMtujawJpzrSubpsv5V7kCMClio5TxfnbB8TFf6is8GnY/U6iKp60QwlTtr4STGAw1HW258x6/n28M9oB7jdlSt3YOzBwhHP22+6u4MDeW/HtAhoFkmw46pAQVrQY3qCRQ/8lEFER5+9op4iqaqt8PsHAEABqq0kvarph6ZL2V2qDuGRu3mccPMyX/6iLyT+Zrw7nCOEJEsD99omSCHF+jFEB/5MAhtP4UdiDOhLm86LMR79jjL1EUADCASc0TOvWhKLHAaNV7W48xIyBJdvvMyfgj/+4R3DistfusIwpZEZaonyy7lPmIxvt1n27Eg79FU43zAl9RTQclY4E9Re+hTS/Jm6QQZlv0XN03fpl4avYXThEpxzAOQGd5F+nHAXxIsTkh2sr1EJ9594Y6buOrFQpBB243rpsPfUvhCDHsT3cEJmM8yFy3RN8p5a93sqW6uir2wBWLJnulms7k2tQiyplRp5jjTKx4iMbsthF/pg6bSyQELmVkRA7FF3BX5UuQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ZEjy5k8nT+CmOpSq8y/yMGSE72+IvlX21TYWyXIaNNbXeU5qI7eQvTbaSV4vHZf7cOycr6lz6v+wbBAHB5JPQEnbbQpTUP4dGwRvAS843V5nfT2t4pvr3kRGKEW7YZ++fEdihSK0coWpy8YY8FBmva78k8JCXhAmE5CwMKh+MrOZo811AoAIcRLEW5zyBdilRV5KD9KW9+P8evUgltYh7aTyIoKM9WFnZe234ZQDuQ5umocsel7dL7HplFZt315W6m2xdy38naHRMcdwrWgH3b06o3QUVNLkM/YhblpGGkRD8ojL0cVSfhZkvE1cr8WO+Qwm4rdQRKpITWdY5r5iwgTXciUQH+KqdjMx9gHw3f88AtKBL0CYZQ3qS8tn958Ej3FhAKakTZGMcXqXjdREnGJRH0WPJBE+5EjIyeBHEDZA8ej4mji7Fl3vg8GbgbV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:25:18.3811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdc56de-c934-40c1-a3c8-08df4588272b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7899

Hi,

On 11/18/26 09:28, Hyunjung Ko wrote:
> stm32_dmamux_route_allocate() calls pm_runtime_resume_and_get() while
> holding dmamux->lock with interrupts disabled. The runtime-resume
> callback stm32_dmamux_runtime_resume() calls clk_prepare_enable(), which
> can sleep, and the device is not marked pm_runtime_irq_safe(), so this
> can sleep in atomic context.

Indeed.

> 
> The lock does not protect anything here: the dma_inuse bitmap is already
> updated under the lock earlier in the function, and this second critical
> section only wraps the pm_runtime call. Drop the lock around it.

The lock is misplaced and completely useless here. Your patch is correct 
but incomplete.
The lock should instead protect the CCR register write, as in 
stm32_dmamux_free(), which also needs to be fixed.

> 
> Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>   drivers/dma/stm32/stm32-dmamux.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
> index 57318715d9f3..890328b3d302 100644
> --- a/drivers/dma/stm32/stm32-dmamux.c
> +++ b/drivers/dma/stm32/stm32-dmamux.c
> @@ -139,13 +139,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	}
>   
>   	/* Set dma request */
> -	spin_lock_irqsave(&dmamux->lock, flags);
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0) {
> -		spin_unlock_irqrestore(&dmamux->lock, flags);
> +	if (ret < 0)
>   		goto err_put_dma_spec_np;
> -	}
> -	spin_unlock_irqrestore(&dmamux->lock, flags);
>   
>   	mux->request = dma_spec->args[0];
>   

In addition, I suggest:
@@
-	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id),
-			   mux->request);
+	spin_lock_irqsave(&dmamux->lock, flags);
+	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id),
+			   mux->request);
+	spin_unlock_irqrestore(&dmamux->lock, flags);
+

And moving pm_runtime_put_sync() in stm32_dmamux_free():
@@ static void stm32_dmamux_free(struct device *dev, void *route_data)
      /* Clear dma request */
      spin_lock_irqsave(&dmamux->lock, flags);

      stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
      clear_bit(mux->chan_id, dmamux->dma_inuse);

-	pm_runtime_put_sync(dev);
-
      spin_unlock_irqrestore(&dmamux->lock, flags);

+	pm_runtime_put_sync(dev);
+
      dev_dbg(dev, "Unmapping DMAMUX(%u) to DMA%u(%u)\n",
          mux->request, mux->master, mux->chan_id);


Runtime PM calls are made outside the lock, which is held only for the 
CCR write and the dma_inuse bitmap.

Regards,
Amelie
