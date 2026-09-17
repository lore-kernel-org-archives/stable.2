Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA75363C48;
	Thu, 17 Sep 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636403; cv=fail; b=I9UKVW9NPYilYCQ5/2JQrTiokLYNHfyNQ/NjEBNISKZKSx8IY4YKgvNIFfjqlanGVFwlkaSBNCkyoOltz6RJD6igGpeAf+lCWCcU0PkrNx0yUOfKUkeL0ShacP/H2lOunD8Pi9qHVWRvCDL687ASeLynQqOz0LVux9aSW2HeXjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636403; c=relaxed/simple;
	bh=aliPio6CqLVgNs018s5LaNz6VwQkLeU40mTy6s1lx/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q4Au2oB6Di/t4AkxUSfek4JA/oLKuj9m4o+kCRrbsu1ytoiqf/uEsm6p1+fxUuUTdrMESbth6+SJCaPltB/DmajOiBpD0lwuFKnDvKUu/7HeCWEUgNx0InZEyKH4aQAJIGUBsRfJ1+mzp6zjlz3Y+YpPuyuFW+QXGmXvK5cyxMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oyHEq2wx; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oyHEq2wx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJewXL7C4MxFyInEJNPxLSgOm2Uwl1T3tme3VvotBrqAJEZ3Xod+kgchcA+6tXZUogE4fcY0dCJyO2N0uhbHSfEBItSIc+9fzxS7POixSwAiI6aQBPZqiSyEHkbTH4fFaUQov5M9xL+g/fC57z5QN4HGKEJMd2h8Q6ZfMTh4jcIP8P4lRmiq+nj8sVro/rhbq6aRqIbHGaYM7Nu+RXWvG33GQwbqpzrDVxN+vlRf+TVE/KrFj31w77lky7QqyneEgE+whg0NOxGF8j7raExyMUJHxx77uHiHLIx+4W6iBzlozmSutowv49JmjwEqOXk/QcHrvRwzmAeALMKqi2vCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEkb0gFEltBX2Uk9A1CIk5tOYIox/3vPW4obLKIjOOg=;
 b=YKb+CNGDaI5+qO2YFXJGAeIU9vPbyznFQKnfZ4Xi7fayvY1o1ZSNQ/YggvB7hcF4X6rHzlJ7rm0UHGZeiN47rFZTqYwcJGJGM8H9pKB24wmawk+bkCiIQN3NSQ4YeueodXV7hhPGl4/VhgxdvEbK8chdb2hsFP8O1ll5dH8rvlZtS9t9NkG+jSQ8+Jdtk5mgGIb0U8P83ENVI3hRevIyHJFWWj/SkG8D6wkYSpKfLrZy3NuHg0DF8HocMHzWRFU5+X7opYUGL/6y3PUF5a9+POhVoroW7G/sPD8saLAf1tHa28ORDMNSKhty75RDLNy6dAkbkEi0cOCxKLDaRGe7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEkb0gFEltBX2Uk9A1CIk5tOYIox/3vPW4obLKIjOOg=;
 b=oyHEq2wxa59GPyEDqIAxr8PSjV2r2KVks1jIS481AAuKF+RA2FNa1nxoUcQPFXFgwn4k55RtZTmdVC4sh372xQOX68BuqthScceVbkw2yUEnH/tGT/laX1+JTLFns2ujtDXLVzc/xz0vYwu1OBoqy7sfQcPBwIOAz0Y4sFdprmcsFvUk6egCchtivvmb4JNsJveHOcJr9lQCyFfoVT0dUB0dwnhnBxYszOxvtVaa1Qh2nG5T0J3PSAIJDL9xavLUcZ/BQiw9DIKik+VmEbq9l4BabF+prm7w5t9yxEK8uE0mSaMaoCudQ+l4AD+SKiiOlp4+S0vmlv91hLkfgE5fPQ==
Received: from AS4P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::19)
 by DU0PR10MB6297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:13:18 +0000
Received: from AMS1EPF0000008F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::aa) by AS4P192CA0025.outlook.office365.com
 (2603:10a6:20b:5e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000008F.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 09:13:17 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:19:21 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:13:15 +0200
Message-ID: <c5cf542c-46eb-47c5-9424-a7bc3ce630ab@foss.st.com>
Date: Thu, 17 Sep 2026 11:13:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: st: Fix clock reference leak in st_i2c_probe()
To: Wentao Liang <vulab@iscas.ac.cn>, <andi.shyti@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.coquelin@st.com>, <wsa@kernel.org>,
	<stable@vger.kernel.org>
References: <20260916160235.2080462-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260916160235.2080462-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008F:EE_|DU0PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d1b721-c90a-46a5-68f4-08df149be900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QgSH8mSelrECj7AZf9WgOYSUZK8Hz8eqY4eoB8FHynPdHcMRqgjzUE9ExhBfZr+ZcTw1cnBLuj0aqVneXQ8W49F+zu1hTIjr7k74CgPeqYFVsZMfhGGtMeYLLLKuQ06DPcCXPncghPHKfpL+BGAafjKm32OFxEk5118LBhxuXPkSQWqMaDYnG+Z6GLCvCzO2IeN+8EcFwuyPV2XRUZSxThK1AF3yZpUWQz1+L971RZEVVvNCe8Blv7wAzlhUUW8Okg6/93tveqPZb8ZlWBb6txxyASAvsigdeSKsI4Fj7MFFE1SKt5WEfENFS7dTtY423umL1WD/qiBZpzBZKjB4tw535Z8moXWrw/v5+2chalEK46713aDXlMd+C/WrnlS5RxfIELP4QqoM06Or3vGSFRjoKaZWhM9ObC/4CKyKsfxaukm9obr5JkvnY/yObrVWMmoO/qMPAOU1MuRXsYHkiirvBotHsnCd9oiWkt1iyQGV/AFiGz5HLZFTRcs4lrfHZ4O/WAujkOnAUlIXh1mCvHwJVuvosOtMF3SE00qb7OKrGEsDzX4H6hcJCwAx4SFKn2lxt+8pMTjkppEEzjIQ9p/9Hg0w++w7mDQEpb03D10V/1IwoAdSaMjRf5coXPvaDdVlPtZDP/YWqIdQvNB2l1TLSBs5SXTmvn8Jcu2SB+2OtyNRmcMOrrgz5LYJXl18dv8p5W5Gc4J4PXr6q3aoHA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GdUEP4MD0BmtndjGshK4P+shW0rJ63O46t23KWmspFIwdZeRkkY8swSBQsUnkLwHmEoJp7vGqHFQ2B9fYhd+hzkvyAuy6vBt1NwIjToZh7iFFGYGV77Fg3Idr8RQVMZYJ2Aq8qssEbGBU2OOwqZQG0qHfaTzSlS1n/R9bOfWlH6w5Yf9YK1jut4zbhtvjzgfh/toev9BjWbrN+7aAsuoLiAY7yzNcjdWttzB/v2s8GFkceenUX6TjuHMlKdZxD0PIWAI4Mwo6OEsrSmsEOBZUWGSJoBt0QXgHpMVLLqICbWs1Z23yu+METC3XKKGaNsU+aEHGx21rP2yUzTsbyBYavBJISaraQ8pP0XoJ2qk/vz0ZKmrwTu+mRQuFaoVKEG2kcdcqHrIQ6FCOSs6MZ6rt2pC7NgOu9N7xCPy5H2iv/dTbj8zeigHjuoJQEQMDeJX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:13:17.0705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d1b721-c90a-46a5-68f4-08df149be900
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6297



On 9/16/26 18:02, Wentao Liang wrote:
> The clock obtained with of_clk_get_by_name() is never released: the
> probe error paths after it, irq request failure, deglitch setup
> failure and adapter registration failure, return without clk_put(),
> and st_i2c_remove() does not drop the reference either.
> 
> Add a cleanup label that drops the clock reference on the probe error
> paths and release the reference in the remove path.
> 
> Fixes: 85b4fab26960 ("i2c: i2c-st: Add ST I2C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i2c/busses/i2c-st.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-st.c b/drivers/i2c/busses/i2c-st.c
> index 751ea421caaf..2049bbce3656 100644
> --- a/drivers/i2c/busses/i2c-st.c
> +++ b/drivers/i2c/busses/i2c-st.c
> @@ -831,7 +831,7 @@ static int st_i2c_probe(struct platform_device *pdev)
>  			IRQF_ONESHOT, pdev->name, i2c_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
> -		return ret;
> +		goto err_clk;
>  	}
>  
>  	pinctrl_pm_select_default_state(i2c_dev->dev);
> @@ -840,7 +840,7 @@ static int st_i2c_probe(struct platform_device *pdev)
>  
>  	ret = st_i2c_of_get_deglitch(np, i2c_dev);
>  	if (ret)
> -		return ret;
> +		goto err_clk;
>  
>  	adap = &i2c_dev->adap;
>  	i2c_set_adapdata(adap, i2c_dev);
> @@ -857,13 +857,17 @@ static int st_i2c_probe(struct platform_device *pdev)
>  
>  	ret = i2c_add_adapter(adap);
>  	if (ret)
> -		return ret;
> +		goto err_clk;
>  
>  	platform_set_drvdata(pdev, i2c_dev);
>  
>  	dev_info(i2c_dev->dev, "%s initialized\n", adap->name);
>  
>  	return 0;
> +
> +err_clk:
> +	clk_put(i2c_dev->clk);
> +	return ret;
>  }
>  
>  static void st_i2c_remove(struct platform_device *pdev)
> @@ -871,6 +875,7 @@ static void st_i2c_remove(struct platform_device *pdev)
>  	struct st_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
>  
>  	i2c_del_adapter(&i2c_dev->adap);
> +	clk_put(i2c_dev->clk);
>  }
>  
>  static const struct of_device_id st_i2c_match[] = {

Hi Wentao

This patch need to be rebased on last kernel.

Thanks
Patrice
