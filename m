Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91E3515D3;
	Mon, 10 Aug 2026 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346644; cv=fail; b=cwUYIwSeElPFnTXSj7bd3uaWvE2IQbjOt9kKdiqLAnaLUs7IY8/2jEg+dXYXFSNm+2PxSbiXJj0Zo1YlcwERrPtFaI70P7KpXIRnPrZl+I5t6uSL2rAu0RWArBlkZrYT9yvQACCjm4jQimWq7BBCd3cOAtEo1ntOCGlaCEpQnxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346644; c=relaxed/simple;
	bh=0lnu+jOXDSIO30tr6IgYA2YjFemq3gUKsmYcLvK3R94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IgvY2dVORY26ux9MAfGg7t06UIvCWAu9K8Hn1ZSsQkuM08YOI1+PPNBabxgXYo6QCSYFq9fG+60ZzL/ENGQXrhcQZxMW0/gVJAkF6bOByTQbZnTWIkhKJVOtH4bRBXfgyL91TyCw76TiqvDFEPh3mH7d5EHy3KnrnyrVuxiQHl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AmsE2dJi; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AmsE2dJi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v34lLJtS19Eb+lxOqxTqd/mHjKvDHSQgbp27s3x93u25/f2REnRilAIZTS6TUXjg539wVRQZcQPu0qjUz47zxgpDkJWFBzktyrfHevP14lB6ez4ytaIXBc8cUBkY0ofxYwnR+XVinopGDjDekBNzk9ybp/iE+itvRPN7QxXQH3UHeR/38YIcR2fO3P7P7dVREUnSCNkoxcfSRj0ytHzsNqCzildlSscly8KWNCIlJes6bKjU3eqADNVkXHyD/8GncVBLAnwootYyJrqdTSnMNRwgNr5VIMlyBptCkqBPhGwdERvwyeeQPDIDIBKxLoYYkF3TSQ6dF/mzmscntxbEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja/bsTECoiQjpMeI8kGTh6JTyf3dpfSM90iffH9sd1Q=;
 b=RUJxB75C4v3ukQY/cQQNrBuRxxM6CMyyi4l7Xey9X8yGdwvoYs7LsljGrIANPpu3wjtcY7vrJVZ9jgUeM3koUAbpJAovVa7YUE1hYGPqFuaIOABEFg+0PtUrfZymYG5wGc1DhzkVJ6cIVgz+/HQhh9oWeK6OCfpXLGOgyc0QYf2ZRj/WsPhXK0d8EnoKnt4Cnixjj85sPYpoTFKzO2atkzB+T07yUHmTCGXihMXwyXVC9XsIEXYNZyd9JyRTWDy/IlEKFTB7klhFkfX27qI0UxK2lquujpfxNCfzdAzzHSM07IxOsBloeK4xfGW2w1r27eivgLBy4lyhTnX6UfrDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja/bsTECoiQjpMeI8kGTh6JTyf3dpfSM90iffH9sd1Q=;
 b=AmsE2dJi+xMfDt3y2+EYjTf0TUCmfB2QjxvBtYee/w332PkzxhtW1dfUZsoDfWmB1keNnrb0bL0Vk/mGhAIbFpQMM2+wPEiGXyM9DiOOez0pb7PIEZoZ2AteAQMJhS81MlblbT5S3MsJ9rY1Tc8riqIGdi06qpKcu7kL90aBqR++1K7ehJDNle15zWD8x3HIyvtRNL1Sr6Vg2IKy3fX3Szcseminlvr6/lyfnivcBIl8YM+bsXiN2pbSKi9ScAjH2/Ofn7023TAuKjeMFdy2tPs+SS5miBGGu3hb5R+UuhECmGkBLb83nQzar3JwBkNEMzjD/Fy68lVL9whaa3Fglg==
Received: from PR1P264CA0059.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ca::14)
 by PA1PR10MB8766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:440::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 07:23:57 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:2ca:cafe::3d) by PR1P264CA0059.outlook.office365.com
 (2603:10a6:102:2ca::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 07:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Mon, 10 Aug 2026 07:23:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 09:28:50 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 09:23:55 +0200
Message-ID: <24b0e7dc-3b98-41a6-924f-c3eb4b547990@foss.st.com>
Date: Mon, 10 Aug 2026 09:23:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ASoC: sti-sas: sort the register default table
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Mark Brown
	<broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
CC: <linux-sound@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260805122811.13713-1-peter.ujfalusi@linux.intel.com>
 <20260805122811.13713-5-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260805122811.13713-5-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|PA1PR10MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: c356321d-6646-4cd9-77b2-08def6b0567f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e44S4rEBfK4QtkSzoEq0yg17WBLgaJTbEwplgmDZhIeYuu7yvmIEtyDsNET2A/DVKFgh5hTRNatjZumJ0RzaGOX9bn412MZp3AQz69vKqBu9iIc4y/lMXWTgm4X/RU58LRkoA92rS/VUtnvul1ZqHCtQQ9OweRDJBHz6qTY1+QE2ZAbmS8ZEuvdWRO8ah9iUSw5svkJYCrlapxM0ONUCc8dd1gHwMm5uM/A3aNysDLGK8LVF2yU0EM2YI7hheaJhP5En3gHiwfguksrxlMYaORg7o97zPO2ZnQrypm0cQ9dvH/ugnPVFS9GLoB9dAVtI44/88NZTqKqjLfz2cVgqKcuGjMjI1e3jjulSeWecQ6wrxpjy/birlM/rqK9Nj3PccmNQtTVXfhVMdGCISPDEj8vmDCDuzT9/nG3WIO2gC5DUoPwkRHzfbKuFmLD7po/KiqbiMPeMmuRr414yR0uXLumiwwyPXsYPhTrzwL1TOlhZKUVjk+ePcdctXUiPgxYg7kFthcogmWQbW14ofwS9ZlKBHKZQq96RNySQF7yYL3dxdAaOLzKHvd2TZumQ4/BvRVW4cBbz4Gyh8qrIzSEyFXFO48KLCwJ2scN4qwWHQEyTTPyWx+igW7FpXitt3jaiSybclW9T1vkJM8mksjqI4tnciSiscWBMJh+TqgWdhqdoO78kcbs4GGk4Es7nGnvOytUCcSyGlbB3jctzK0lMJQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lzCqncxrTI+ggb7g5I6mOMs0m4CR+tLd6D3vHzW7RGFVck5s+P0qvaaWJVfi57Ho7Y975AjHoLBHn5+mOjoNChqYHFMLm5CocRlSRxa6MRCFyNY5ImIcxffMMI3MYaVsmfGy6AFdZasgPdLEWOHFb2+Blo1XVbA4kHhPvNsIwp7Spgqr6ywUbH8jWVy4aOYce4sZFc00UQ6TNERWIxVeqzax2Gw4EXbJJ75c6y/hiO6MbEA3IYABq97NSycKXJJe5G0l0tp974PzCAGWiR4uDOz/iaFxGrfI6xyIxcO0WUfZD3EKttfV7RjExI8qWlvjslrXG/pNoinIbqqVWp+Wyz/W7rLT2CnVh8s3Hl0VUYyNIA6ZWln6BTcS0UCecfjQ2kRaNP8Jsh4BQkZkKJfzKazK63hoL7OXl83WuOgjOLcx/zlWdNPAJjIKHEVVKPsT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 07:23:55.8211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c356321d-6646-4cd9-77b2-08def6b0567f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8766



On 8/5/26 14:28, Peter Ujfalusi wrote:
> reg_defaults must be sorted by ascending register address, as
> regcache_lookup_reg() locates entries in it with bsearch().  See commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> STIH407_AUDIO_DAC_CTRL (0xa8) is listed before
> STIH407_AUDIO_GLUE_CTRL (0xa4), which makes the latter unreachable.
> regcache_reg_needs_sync() then cannot compare it against its default and
> reports that a sync is needed, so it is written to the device on every
> regcache_sync() even when it was never touched.
> 
> Sort the table by register address.
> 
> Fixes: 165a57a3df02 ("ASoC: sti-sas: clean legacy in sti-sas")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  sound/soc/codecs/sti-sas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
> index 4ab15be69f3a..b7eaf4795d8b 100644
> --- a/sound/soc/codecs/sti-sas.c
> +++ b/sound/soc/codecs/sti-sas.c
> @@ -44,8 +44,8 @@ enum {
>  };
>  
>  static const struct reg_default stih407_sas_reg_defaults[] = {
> -	{ STIH407_AUDIO_DAC_CTRL, 0x000000000 },
>  	{ STIH407_AUDIO_GLUE_CTRL, 0x00000040 },
> +	{ STIH407_AUDIO_DAC_CTRL, 0x000000000 },
>  };
>  
>  struct sti_dac_audio {


Hi Peter

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
