Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF335328CD;
	Tue,  8 Sep 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868213; cv=fail; b=Xmt7NZrtn2fJrkweZ1iCzY6HAyyrC8uyqFalAivM7MGcuTf3PbLodJARxeqMDRGabNKOQYwDP8Sdfxbqvbckx07RT9hcBJLDWDqd1BO+/X2PpoydSOSlD09/9XVbxM7CxOg8330YTTO0TqhPaExGlMsTfWeXrYeRjpEztH4b8Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868213; c=relaxed/simple;
	bh=QKo81AGn+LsqmiShANTHzqSEx95eJLuWbUQ3H4mHvPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I8UpwAf0QDsf6+MafYRywrHlotBOplyiIPpT1PiD5s1Z3qMAE2DFnH8OMsHu6OuIxbVgOZs92K3SSFb6fzsyhSHtFrrfg1H2hWI764rtgHEKugPojkG2eFtW8MZji+wmOhYFBySdxtpQ5OqwfiK+uDLeYwxHpow8XEiujET5cnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O4sTpMU6; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O4sTpMU6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXijyaNYV+6lSSGwvn6V3jLXHD6my76PksUyH9HtzZbO6s2lgZLGimaxk97qV/en7TV8PCelMTU6q/T18as8SnfXZKJmRUKtsZy89SKsGqfmGPcPr0cZeApSd1sK8Bkbqw9SnJ5X9gd6TWjw7wW25Qu4UYTybLHgqViQuHzgCnFvYy5LAmZMVkloDleX5o9lsnxJJ3BYn5adgS7DHkSf0yrfIWo4ipEd/QAQsHjD9KuRPEr5ODaROKGuBGT+ZmoHaaHHWJCWCInrbc5UAT4CVYIHAEWPCwKld+VQM6o52E3gYJ1azUrzJGf9ETfpzrUTZ5wcB5givSVYzgrjaGqlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEhvgkajVU4szt7a9y8FcAhvhnBSoQRA0Isc2c0LOhc=;
 b=SFE5VU306KV19iqtxdHjUmlHWxqBG9WKQrjwbkFPeELW/MM2vCWPx+AXRFJZFwtlSwgr2INIOe5uDdrePDXHyLgUhgoh0RY+tr6id+NsPqObMXeHcgvhYKDhfv6+xUlarAX5snKprRZWt7UKxhaynjdUjqkkXT/PuZSGPcsZHwVgdp6hacykfINBXTYrpHbdEVX2s5x36oztSZ5yDJ3MpgmWxO00Lqqb2DcrvNoQJV2/lpxWNxbMA08Z2ZBCZA0CEQaBfPdmiDdJr5SymrwlqCa8fIyM0dUqcfzlRErvHJFiuw+StUbGIim85cp+x3ptI/wz9MFA40Ep6CDkEa1uSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEhvgkajVU4szt7a9y8FcAhvhnBSoQRA0Isc2c0LOhc=;
 b=O4sTpMU6wWCaUJnndGO5RCXLhmbPLsVO+IVyroQPwP54zplb8IPrjyErN/gcdfkBcfcMd8FnX5LO/S/2o6gpC85zkWcc5Dyt42zmEV6cgBDoVIW2wz7qhEprrEwjWeGFax3ORRq4EeG0F7FzX+nfYP+Mz9heOgAbfY2okZwyZMeKcj85j64+gsk10VwUNNnA1brqWcMtAkj50uQr24v6vsbXwowsAMI4nOMfAebcSgtdQBWLl5aYBSDbankBhddpdT/rLyXWEOatHxsqzijFclrzoSrIxJOz6j/0heePLt/dH6/oR5hy7TNFuuTQy5KEeiBmBF3FpY5/Q27nhvcJBA==
Received: from AS9PR04CA0095.eurprd04.prod.outlook.com (2603:10a6:20b:50e::7)
 by AS8PR10MB6699.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 11:49:55 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:20b:50e:cafe::7e) by AS9PR04CA0095.outlook.office365.com
 (2603:10a6:20b:50e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:49:55 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 8 Sep
 2026 13:55:55 +0200
Received: from [10.130.78.67] (10.130.78.67) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 8 Sep
 2026 13:49:54 +0200
Message-ID: <4f525802-a776-4bff-88ad-b45a69c85f1c@foss.st.com>
Date: Tue, 8 Sep 2026 13:49:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: i2c: vd56g3: Clean up subdev state on init
 failure
To: Myeonghun Pak <mhun512@gmail.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Sylvain Petinot
	<sylvain.petinot@foss.st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260622121429.47765-1-mhun512@gmail.com>
Content-Language: en-GB
From: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20260622121429.47765-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|AS8PR10MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc528ac-38c5-48b8-8cf3-08df0d9f4d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	75tMw5cEmJzBhFAfyfmIxZcrHXtYCmfixXdCAHdjJkoEKS1CpPZtl/6VlEKBVw6aA8gy3l39dy7OAfaCkgM1joQpg5VG7Nkk88XJVPr9WiuJGVljDSQErEmNO58SijcYaAIy0c5rx+8Ok7SsaG8EYmvGI1EQBh9uTA2o430eh0n2c/at11zUg75xKG8mDuIdYtYAjHH2BKyCiUwrKnX2ra80srrieLaseTDodFbjVZ4uG5omYMULVy6DvstSv9e1a0KiReAsk8SsOYA5si6PI3mwiqyYb6hg2u40GonNYXkHOSZBuLd5W126lhrf4vi4eTC5Juh/kCVI0cBGsy/QGr7hLDxwqPij3f/UiB2V9kf+BdSTP6H0btwjgNWXrrixfKUmLVYS78N2bF6KzUfYK22vyqYar468NlwcF5fXZFoa4Hk2etmLT0MYcn1U+FPzVziAeqHhSddcrXXMuBqaF/MKFvDamRQruLJA6/Imwva/lZoM+oPNsrlMtpnith96FdVZkN5s9imb459C6XLKjwzNuHx2uhoB2q2C6eXOSLk4PIJwrsdEwPEZLTBf8znsFQCiZPhyxh8gcvitQyPvxdhEcOqF6recT7+oXl/g3SwISeTKamxFuZAx4s8yTtlYZe0rSGt6V5l3PkJtfnWm8fd1WmXjPUcfm2rkkIidUFWH/Ori7dey+5jfFFYQKvt5mFPll1I8j1fGoj/+BGBVxQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aIOZlABZOPyWmfEPSmxca5QsZOv2A4UMJSBtsuPkVoZxJZHKvw1FWq1nambBCQ03lHriMqWeZvgRy3nLHjGNnTTSt5eFrlf5mhZvgzPXUfqMDuw2sAdFf5Hy7u3i2CucWoUOG4xt4EXAqGPnRDS133cTvISOFyMAxjs9FmLGYXnrW94DevSsv+ev6m78LG+lg74+fvejjYWfzoLuMfxYjE5gnxMmY79ISSUeoyjBiaFzSJn0pHiRVBwcXU9cRpdbJ2ncCXM3wT0+LwB+5vF/GBJggpebCkrk+6qcYIDVMervCJjoL9qEkLll4S/K74s866FwJPcYZYq0F/SVbbJZBADmRzxSJGrGYYbbMBVcRC4SC/kEYcqp4TKg4P/fWn83q40ScgahYVD9qKOczNRhCxw81yrP1uQsrEcSA2ggMQLBMovmvoprZ4mqYr/12opc
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:49:55.4944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc528ac-38c5-48b8-8cf3-08df0d9f4d33
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6699

Hi Myeonghun,

Sorry for the delay.

Le 22/06/2026 à 14:14, Myeonghun Pak a écrit :
> vd56g3_subdev_init() calls v4l2_subdev_init_finalize(), which allocates
> the subdev active state and requires v4l2_subdev_cleanup() to release it.
> 
> If vd56g3_update_controls() fails after finalize succeeds, the probe error
> path currently skips v4l2_subdev_cleanup() and returns an error. The driver
> .remove() callback is not called after a failed probe, so the active state
> is leaked.
> 
> Move the control update to vd56g3_probe() after vd56g3_subdev_init()
> succeeds, and route failures through the existing err_subdev path. This
> keeps v4l2_subdev_cleanup() in the common vd56g3_subdev_cleanup() helper.
> 
> Fixes: 87aa97fc3157 ("media: i2c: Add driver for ST VD56G3 camera sensor")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.4
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

One more nitpick but otherwise :

Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

> ---
> Changes in v3:
> - Restore the capitalized subject summary.
> - Route vd56g3_update_controls() failures through the probe-side subdev
>   cleanup path instead of adding a second v4l2_subdev_cleanup() call.
> - Add the Assisted-by trailer.
> 
> Changes in v2:
> - Use a lowercase subject summary.
> 
>  drivers/media/i2c/vd56g3.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/i2c/vd56g3.c b/drivers/media/i2c/vd56g3.c
> index 157acea9e2..39fb14bab5 100644
> --- a/drivers/media/i2c/vd56g3.c
> +++ b/drivers/media/i2c/vd56g3.c
> @@ -1388,7 +1388,6 @@ static int vd56g3_detect(struct vd56g3 *sensor)
>  
>  static int vd56g3_subdev_init(struct vd56g3 *sensor)
>  {
> -	struct v4l2_subdev_state *state;
>  	int ret;
>  
>  	/* Init remaining sub device ops */
> @@ -1421,15 +1420,6 @@ static int vd56g3_subdev_init(struct vd56g3 *sensor)
>  		goto err_ctrls;
>  	}
>  
> -	/* Update controls according to the resolution set */
> -	state = v4l2_subdev_lock_and_get_active_state(&sensor->sd);
> -	ret = vd56g3_update_controls(sensor);
> -	v4l2_subdev_unlock_state(state);
> -	if (ret) {
> -		dev_err(sensor->dev, "Controls update failed: %d\n", ret);
> -		goto err_ctrls;

The err_ctrls label could be renamed to something more relevant now.

> -	}
> -
>  	return 0;
>  
>  err_ctrls:
> @@ -1452,6 +1442,7 @@ static void vd56g3_subdev_cleanup(struct vd56g3 *sensor)
>  static int vd56g3_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> +	struct v4l2_subdev_state *state;
>  	struct vd56g3 *sensor;
>  	int ret;
>  
> @@ -1517,6 +1508,15 @@ static int vd56g3_probe(struct i2c_client *client)
>  		goto err_power_off;
>  	}
>  
> +	/* Update controls according to the resolution set */
> +	state = v4l2_subdev_lock_and_get_active_state(&sensor->sd);
> +	ret = vd56g3_update_controls(sensor);
> +	v4l2_subdev_unlock_state(state);
> +	if (ret) {
> +		dev_err(sensor->dev, "Controls update failed: %d\n", ret);
> +		goto err_subdev;
> +	}
> +
>  	ret = v4l2_async_register_subdev(&sensor->sd);
>  	if (ret) {
>  		dev_err(dev, "Async subdev register failed: %d\n", ret);

-- 
Regards,
Benjamin

