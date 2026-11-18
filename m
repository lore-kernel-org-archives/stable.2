Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795026105;
	b=KYrKHWQNl8su1i8U3+7NZ8MtESE1MMvzcXsgXy8U5QkaSN/5bde/EJDH2VorSbNVInGr
	 sb7r3UkA8VdPLfnQNGqmcBVb49DagR6ylEnqrixeabZQ8I8mRPWELsgR8K/gYbXQK81ar
	 kDb6BLZfslpTuhycJ225yBjpBRBQQd/sG8b/Y12eOcOH22PiJrfIQw6tDFP4c4mb6CD8S
	 QGO9DFHNg8tXjAysMxPb+XH2OZMojONSAqB38uvtHS/XnsxGOwynmFA9dKjkJE1Yw97OT
	 YBmfn+q0Qk4tzPA4i5wwgBe9dUGR5CqKUOjtDZY4+eBrv1anUk02uwRphMWn0LvtDwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026105;
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
	bh=+RjrsMo1wlOqEsK/cd65y47zWVlQQUb8SgKleyWEtTw=;
	b=nSRdVB2uTCU8ti4nWquOlZ7xmt/IXqgHaTXyUhvqIN4IYK96aTN88HcFqkj4mzPcVwkg
	 ayr7vd/L9h2bUtfF2645iSUuhBwTZz1S2Z8N6XDeITsBqJlO+76nYIsyiOtZABHO2Abch
	 a+K2t5gWKbS0AbIYJeULAdBeJ9skaQYw0Gw6/7REP7DS32Ehrx8RIU2gobV8DjVtPTAHH
	 IETCrpXKuX2lGsY9rgy71JtAlgf4Kj/CL6e+fwpQ6CUnKq/WMRTFXK5e5i9jFcy+K1wh9
	 b+dKqPRGrlSwdeEs4leLx6KjIW/f60MwTbS+QyI4ZAvvDy99o8MdiI1DkVgNffm/jsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TJnW3jsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.27
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1654606A31C;
	Wed, 18 Nov 2026 18:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1654606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TJnW3jsu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2RVYGk3Y/E7yNCEGAvsxflffKmCYyD/ZdoKM3FFt0is+ii5HASuOQZZI986pz0vkhyyMWX32k9hsoOCxiaL36vf7nAy81Pdyofo6LfseIJBWScdJs8pjifuB7r/9KIwut7vyQc6uJ1RYWJCyfYnUAOyj9rknZj1LZws6st99hLvI4CyIuGRjLq08ttA8O0tMRgXvdzBia3PLhVXMyiDX6MFlQB6c6JlBUxZh+Ad4nhQg9pDiFTs2QTDCCtJRvNmH2M0MkLoO3tAcCOqJ6AB4LOEc+OEK1+YWFHjqr9CGkQLyOTj1yS6BlFjW1z6/Q5MIhYDJ+T6qbd01boIjGrbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RjrsMo1wlOqEsK/cd65y47zWVlQQUb8SgKleyWEtTw=;
 b=YRjoNh2jCwu1mqHgj8IJhCOZZqoTqHeqpJwE54wcMp+XbuBxCs2x5KprRmugSgM2QC/oZWQL1jOoLwSC+S0UTuWEW/NBk5Jx7oe87AR/wvci6X20/58Vj5cd2X5Z/TRUF8wVdptXoqHRWiqLFIRPTach2vbdQ14qIS/u4wpePkIRGHfQVyRsLS8WHpcP0e1HARFCrxfDslVWXo+e7aT2Dk89nb+Ck6kqcM6S5s8Jy0JCByYlzudeHJl3SaxtxZIASQxOj8VD4a1YspcW3xaZ4TZIsZp2DnGV3gSgZHdrCyED3KoBWZojIuy35jk2bgGXMbfZMkYelRX9lcaPtB+BtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RjrsMo1wlOqEsK/cd65y47zWVlQQUb8SgKleyWEtTw=;
 b=TJnW3jsuTHbpRq3Ve9zPi3LfyHDfHmuolNlMLNHt31TYgaS+4+YV+EyepnCB0sUS5XyzgENh6HWKUdP3K6W9fRXWCKSeOUxWFlHmEoPcGZbJrT3sH5yFM712sSvimrJncQ1cPY3Kp02ecUDGVg4n2gA282Vui4/qulJ5r8OBkhjbpCUXkD227rjIBJKfZxg4zA67jmYNaR8ra5VFQUYHQpYNFQXWL71GTh/djS0R/Pcuujo8evZa3RJ4eTIpdeJtL/byFCRhg8ojCXwuzhklqF8VdJoAf1FWXqeOSN0/P0hdlTkrC2sMZce2zWQ4mrrhVWsgkmPsrkISFQ+692DgwA==
Received: from MA2P292CA0027.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::16) by
 AS2PR10MB6896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Wed, 18 Nov
 2026 18:21:40 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:250:0:cafe::a7) by MA2P292CA0027.outlook.office365.com
 (2603:10a6:250::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 18:21:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:21:40 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 19:22:41 +0100
Received: from [10.252.8.55] (10.252.8.55) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 19:21:39 +0100
Message-ID: <512ee5b6-e257-4b77-846f-41ab8f6f90d0@foss.st.com>
Date: Wed, 18 Nov 2026 19:21:38 +0100
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
Subject: Re: [PATCH v2] dmaengine: stm32-dmamux: don't call runtime PM under a
 spinlock
To: Hyunjung Ko <hj351016@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
	<Frank.Li@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, <dmaengine@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <90b4417d-f2fe-498a-8128-3229eb284d8c@foss.st.com>
 <20261118152843.1126665-1-hj351016@gmail.com>
Content-Language: en-US
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <20261118152843.1126665-1-hj351016@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B0:EE_|AS2PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 50157988-218b-4bef-bd70-08df45a0ca9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|6133799003|261009223027099003|13003099007|56012099006|261026121527099003|4143699003|261026140227099003|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bsk6whgrCxGg5d05pXP8PiDsk77TkXPhrH9+M1/gh6yOwS1mEHUj36pKQkLkwL+LZZxFJl8TqP2enmDMGzA4zXtI73ZJ3CgBL5puljXTgRJQ+bLcH26UcxEoGsOVy3WrXv/Tet6cBGY118mdpDdQFK05eH5zVRRop8SZvedxoY/ahmbVe28wn7Zh6ktpPzT+AhKm/Sp5P7hTc6by/4qUyU6V+8XXjCUQLGO7FWxWY92FPjz9+CKID1nIJc0YZhFuJCMFZgvP4cfxpVuwCCIcuvbOibfiaIoJlBdtnCoH7ouhEsbcxw13OyP/5KL947q28WpzzAHfNEaXBW6Nu1YmNwlSOGsG27uD5cnCML2nbWYaOtYTqm+6JNv4M73maByHp2M03VrvDTZJBbtg26hx417F7KhdY4Jjxavny9rAhYNkm+FH1nav+96tUhQO34XCL0yPymgaxNRrTEELIZX7mq+md2JdkUUPxKgsep5iow+BYeWjc7/7Yykz+OEmhcD2948IqRvqpZWlvqsAZrlOjfHk2x8zrnkKYfYWPJbleQnFSr66UzUAo9tRU24l+YeMowP5R9bYcl3w1OfXsle5bU8zcRFBGZdM1Fyvf+zDAy/jS0n6A76INFNnA4EQ8qr7ksbV1lTWGi4g3C6cwRJYJg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(56012099006)(261026121527099003)(4143699003)(261026140227099003)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eQtNnHY8fsBammgSgKr4rz9dPEJDEU133FY4aV142vU3fx6TP8emmej14Fu+mlXEVlUGt0KA6wOQuec8xVUCGcefz+x3UMmNE5nGOQrZhBzlj47vIveXuwTNXhZLCJgExSID1NUaoK6Db910uzk+7CqQuFXUJVWb+hICaKck9M0oRsUkdHmt/ZlNuXicM02zqtqfgKy7mZR4hRgBqFx1kfYlafIqU6QZsTowkJeie16oGqvKdv3kfNaAcOOXsPg9TLFG4kRvtaUQZm+d3B8aAzL5Igt+qQTlpkOKXTpqD+4y+awMMq8cVmZ/4sTvN2h36NKLcT41Dmr+aJK+E9NFjFJxnx/61xjfFOPf5He05/tYoPHloHDDUdDCjejE3++jarxXaUmpBRI+WMbmGYtAaEQFEviWCK7CEA3GtLukuJgC3GO/gilaUsHcAmmJ3ltG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:21:40.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50157988-218b-4bef-bd70-08df45a0ca9b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6896

On 11/18/26 16:28, Hyunjung Ko wrote:
> stm32_dmamux_route_allocate() calls pm_runtime_resume_and_get() while
> holding dmamux->lock with interrupts disabled, and stm32_dmamux_free()
> calls pm_runtime_put_sync() in the same way.  The runtime callbacks
> enable and disable the clock with clk_prepare_enable() /
> clk_disable_unprepare(), which can sleep, and the device is not marked
> pm_runtime_irq_safe(), so both sleep in atomic context.
> 
> The lock was in the wrong place: it did not protect the runtime PM call,
> while the CCR write in stm32_dmamux_route_allocate() was left unlocked
> even though stm32_dmamux_free() writes the same register under the lock.
> Move the runtime PM calls outside the lock in both functions and take
> the lock for the CCR write instead, matching stm32_dmamux_free().
> 
> Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
> Cc: stable@vger.kernel.org
> Suggested-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>

I’ve tested your patch on the stm32mp157f-dk2. Thanks!

Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Tested-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

> ---
> v2: Amelie Delaunay pointed out that v1 was correct but incomplete:
>      - also take dmamux->lock for the CCR write in
>        stm32_dmamux_route_allocate(), which stm32_dmamux_free() already
>        does for the same register;
>      - also move pm_runtime_put_sync() out of the lock in
>        stm32_dmamux_free(), which has the same sleep-in-atomic problem.
>      Link to v1: https://lore.kernel.org/all/20261118082853.926607-1-hj351016@gmail.com/
> 
>   drivers/dma/stm32/stm32-dmamux.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
> index 5731871..8290122 100644
> --- a/drivers/dma/stm32/stm32-dmamux.c
> +++ b/drivers/dma/stm32/stm32-dmamux.c
> @@ -73,10 +73,10 @@ static void stm32_dmamux_free(struct device *dev, void *route_data)
>   	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
>   	clear_bit(mux->chan_id, dmamux->dma_inuse);
>   
> -	pm_runtime_put_sync(dev);
> -
>   	spin_unlock_irqrestore(&dmamux->lock, flags);
>   
> +	pm_runtime_put_sync(dev);
> +
>   	dev_dbg(dev, "Unmapping DMAMUX(%u) to DMA%u(%u)\n",
>   		mux->request, mux->master, mux->chan_id);
>   
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
> @@ -156,8 +152,11 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>   	dma_spec->args[0] = mux->chan_id - min;
>   	dma_spec->args_count = 4;
>   
> +	spin_lock_irqsave(&dmamux->lock, flags);
>   	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id),
>   			   mux->request);
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
>   	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
>   		mux->request, mux->master, mux->chan_id);
>   

