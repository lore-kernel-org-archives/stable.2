Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57A49B5DA;
	Mon, 19 Oct 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399207; cv=fail; b=KZCTxins5irEP/SK040d4IU0cSBRIVGSlFiWX7/sD2X5wmjxIMAjd9v0B4Nkx6A43oT8pePY40LW3H7TWsi9sgMOX9j4PeeEJFpfNEPbuRCOzqYWYfg58Xk80OjkBbJQopC9vBsTinPHpHk5y1NYuTBVpInQd8up4e/jPLpQSbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399207; c=relaxed/simple;
	bh=Y8UFk/JuGfYTidNS2ablmI3bM1RgME1YG5NttS4kUII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbNco0OCCYihdlPeVd+XpaCRtaMY397wpr6JztPFRHavh28aqh1GpE4NjFAlfHYEdEl8Rjx+dGBQijjHUYy+tcupgzO/ijAuoCmVlxGcAu7kJ6NeRzVfsF8GbWveriT9NvMgtWTEMjnQrJFO01+gHfJ4Rr/FFfYMotrGl442Skw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gXUupkC3; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=spJzVfVd; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gXUupkC3";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="spJzVfVd"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4lusc1390653;
	Mon, 19 Oct 2026 03:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=0zJ2qdzTUvkgZ1up3Y
	znq4cISuqiVIvYqsT95By7Ilw=; b=gXUupkC35SuYRsJ/0/0T/BMjaPk8q693o0
	vGlRh6ADBX0UKZspUDG4J1jTd9KEc8FZ1ezxVsPYidFE2b7GKRbAsAxcXnUWXxV5
	XbJL79KiSFfpackPtL9OFI1r6Hrgna9x7iDyMGcgD1WWdseyJ1sUgDWR7AiM3spv
	jRSL9LLpBI3HYd7t0y3D82KFknB++lVxj2S7QDrvt+9PqennOYHznTXJC9MrdDRg
	znUgqf3wxXypPepZUhXnwYPQ2vo1rYHVDW93gKtiVmK4leDdQ/xc2ngnRozWSUvo
	MUFucsJGZOxxvDwyDEP2BMqqjxvvEdrZUKLRI7fI48tQpYn9nAbg==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020114.outbound.protection.outlook.com [52.101.46.114])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hc5ej1te9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 03:39:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+Qs5dFzz28cxtahySPgmwzbbcmTw/mqq7T+e08sblo7bjzZpQZ6AgHafIp9n7zigXGiil0fF7yCDcbBZ9Ekf6Vwd1CXZRRncryQ9ifJgX9i+S8WE06c8GFJcm1OFA3OHCNDgK1WycSXl7rV0GnxQlSxOkDowaB2kQYCdZFMvTwQHSsUtl5j2Pvzo4Oobf6meCkQ2GwA61MabwTQNsydIloOcuXb9FE2uBt5tE6NioyfYCo3KjWzjETxtWE5CwlYtBvGp6tvANuhQ0510QVMhcNzbaGNj5RuwGu2aWqvZ+pGzDCIMeOwoicRFnGI63RzlXxwcgNlTUgF5NBsNJOAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zJ2qdzTUvkgZ1up3Yznq4cISuqiVIvYqsT95By7Ilw=;
 b=vRydaUQyMtO6tvC1XEssNXn10U89VE5dD9k7/9xiOQ5bw3ASeOEcx2kOvVam+kTRP9Vce5wVTQvYDBWiMgJsUvsOamiTGcm/4WaV9J2yLlMgtTDt3dM+64tc++tyHIbv+tYZKbV1Kqebi/YqXWYZW54t4mO1FzvY/XR93L/2ZXW7cpyAI7KXlXnDlijxmuUfze8Y0Fh1uFU/6LNL4eASjqgy1DycxXlJFLcCDAgoxev3JwDgdQOyMET2wOu/J/djdxGe6gxgk6UxSaYPV+MtNgZI61YOr6G01K7cOznxDLV8BivoSmV7b4ALHT9wvg8W3lQoL5yLyx7HZ+aCZc1YvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zJ2qdzTUvkgZ1up3Yznq4cISuqiVIvYqsT95By7Ilw=;
 b=spJzVfVdQ3Rji2pTUfKmYw5t4FVWWngxEQrlED0ZwZrebN20l/tENleWkzTKJ4Bp3est87HMc5vZnB7lzbcoeV7yh0ly/d4bDCyuVoK3R+Xjd6v7R90A/BC1+uVjMuQOfXA7o+YbOwYrS10r+HikxqcXzp05Q5DLVRYKwXQknJE=
Received: from MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::18)
 by DS0PR19MB7792.namprd19.prod.outlook.com (2603:10b6:8:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:39:34 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::83) by MW4P223CA0013.outlook.office365.com
 (2603:10b6:303:80::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 08:39:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.0
 via Frontend Transport; Mon, 19 Oct 2026 08:39:33 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D9BE4406540;
	Mon, 19 Oct 2026 08:39:31 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id AF881822566;
	Mon, 19 Oct 2026 08:39:31 +0000 (UTC)
Date: Mon, 19 Oct 2026 09:39:30 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: SDCA: enable pm_runtime before taking the
 initial reference
Message-ID: <atXXQv+d+AGd2VIO@opensource.cirrus.com>
References: <20261018192359.287987-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261018192359.287987-3-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018192359.287987-3-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|DS0PR19MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ecdb24-108d-482c-ba56-08df2dbc7fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|23010399003|7416014|30052699003|376014|82310400026|56012099006|4143699003|11063799006|261009223027099003|261009221727099003|261009223327099003|261009221227099003|261009220027099003|10067099003|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	sf0a1noKt0FNnwv0DvsBqj/zS2Ny809S5Qw6nR4pqSLWT7YQvY/pshKU703hCH2DoNr16QhdlLpoIwFOuYZ4xsmVKUj+e6+IuPxtRCjVd9DudYZe8CNdzPEEZmNDvk9o92cvLAw3uvWDz2LjEKIX3nkdG5lv/FuOQyos4XyAvRJrGvKMADlK/et12W4EbalqQilz/uThYBvjCcmU1xFyY/seOUDaCvRzgsZwpBNRslZAmD79eJk/nuA8gp7GqqWghTC4PKbnBDTsCJ6e+9aoMkkPgFW57GNzhVNPV1GRpE3Ru2eO3H5GE3BFF+DRxRBOP0JL6avYAS9ejnLBMGsf/dSiRXH+YyNuh1hud/3zEhHQF2KMUCLKnvFJcRDBn3i6JJ5vKgYBY9tcmX5EKbPzIql1t/cy10PsHkWyd5cwFyof1uYn4mzw5SX4n0g7JAaCJFz8WnXQmUHJt6e51/QCdcGabFmvoH94A5AmE6LdZl1j3esU/a2/v/VTytEj4eKgeppZeovZxkmPB10FTwHhKl4kq3CwIcpPk8BOh3/PXs1DJJwC/nWqB+Q+TXShOvNNIUtUwAfwh8yM84SzOvv7UUrOJcRPMszfdXHjyvRwjUqF8sPalCK/XX+zVoSy1+WlivgqajWlPgo1O6LNNCAJSbtoXdUs/xJHy3I1zjbPoGnBmgmuD8c6Q/tOvmHhqHQQ+I6i4Xc/1HQUUpgZbpUIFg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(23010399003)(7416014)(30052699003)(376014)(82310400026)(56012099006)(4143699003)(11063799006)(261009223027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009220027099003)(10067099003)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QuQXEdGPMprJ/aFwfOPcbQ+GxBfEzKbFAdZk+I7cYIIMAholDOTMu6u/WV1tuakbcegdxTDvs4zHt9Fk8JcwuGAmSmPeo43o+3WbVJwVlZJMWKOdXCrc/JyZySYCMUFkV8nLoj6K5HNJrozVgJMta57erWAuvkIzNArIRmxUSY9WkzWV9TKnUwETwkiv9hmLtSMSZWPz+jXn31WMUlhddDs4QBBZtBmHzpyB3aQnyHZjGa1Oqrh0iz+cFokcCKIofDuI7GZxzsxkonu7tVUOwNcl1qd5Lqa+vtto2M79w1pXB0fzdjMT6yrVop5CELmnit/rs47Kfwz6L/CQt8OwLnV5TLu0/Zh60GXJp77WydzEBtmb36Pvm6ST3ohBjvlS3ncPyZ+PaX1BHLoYWQL2OypnKY3on4tcFUKGtH/xLwWQGXLVUwX7F1Dc1fyrUZhN
X-Exchange-RoutingPolicyChecked:
	SEIv84k1rInfr7YgaepwK0f3cNkycoqYtdRob2GZ8JeWLSO2+ZQZ2biKzgupDtIPTmjajPJBe1RqeU8Y7S9XyC9ytjKQP56RtX/lPTKrLpA1LjwOuYuZrj1XjIS2y0gSMsADXGD/LH9TkIB+Szu4dLFmBp73yR6Wlb8C7MQU2IQYLCacgmcjPRmLb4+JCikZ+oxIb8Oc4PRK3fi7cHHqJ27TX4tGI/KY3YiRu4SAcfyC7uDdHrP7GgQ7f/LWXy3I1o/EUIp9eSrR8Qv3qkTZHeNsM/ScrJ7ZWfDk7qlfr69hh3cr5KRGH6CQgRkCwps9GyHBr0qtu+GTreBEESP87w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:39:33.1423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ecdb24-108d-482c-ba56-08df2dbc7fff
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB7792
X-Proofpoint-ORIG-GUID: oaOeBxs3qhGPo9ku2fh8pP9wYLBh47GM
X-Proofpoint-GUID: oaOeBxs3qhGPo9ku2fh8pP9wYLBh47GM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX6IwkkrKQ6Ktk
 gomwnENuyVwoZ7IBF/CT0YY3ElZqVTs7B/OOJnvPtaqidq0mjAhKsKFKFoMn360Hb5vcubAeSQG
 yoNZtSBtPQuyIK+nhN5YDQZxYRi7eNs=
X-Authority-Analysis: v=2.4 cv=KrjYSmWN c=1 sm=1 tr=0 ts=6ad5d74b cx=c_pps
 a=LvphRkG1ZSFrSK8rCZP5oA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tWsxO1MQLS2mnJrXP54A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNCBTYWx0ZWRfX3irHGEetfR0b
 QudXye1b0CYYmAEmkO6yLAytXtSCDF4lTab84gu8ihluhBpzbXQkVz/8sJhJJbebAaxmqo4e7So
 lJEDSd9C8bEqHAQHFm5cGfElfkawR36/Mb5ZqzU/pHC3XH4oE392U+lSGm5y0UV+Vj1S+eCPmbm
 7k2YOXyAPQljDnvzV71cddXbPC07mzBkCIvkdmjKLPzFMuiySyOJDgSWLHRxZi3x/4oMRVMg/b0
 Qqwz+MN78pZHbZS9/u584oetpW6pjqES7dy9O35wXnpxETPlcO4t24p3wCXNu4h+2eOsF38GOqh
 fv9+unEZSqt9FDaU7WWvi6aHZYeS4WYg/8vxDO06SlbUDQtPVaZ0kZN3mPCD7KCglp7mWXD0hXo
 ATMUOJSkANAZ3AhdCkcg3Ql4/RRJMsO6hWBlOfxRd9DadVVb6P0pBXxBHrk9Kgu8L/Oqkq4giqf
 BdF3iIsynmJRN4Y3HQQ==
X-Proofpoint-Spam-Reason: safe

On Sun, Oct 18, 2026 at 08:23:57PM +0100, Srinivas Kandagatla wrote:
> If devm_pm_runtime_enable() failed, the usage count taken earlier by
> pm_runtime_get_noresume() was never dropped. Reorder so the get only
> happens once enable has succeeded.
> 
> Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  sound/soc/sdca/sdca_class.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sdca/sdca_class.c b/sound/soc/sdca/sdca_class.c
> index bcc660aeb739..3361db188046 100644
> --- a/sound/soc/sdca/sdca_class.c
> +++ b/sound/soc/sdca/sdca_class.c
> @@ -194,12 +194,13 @@ int sdca_class_probe(struct sdw_slave *sdw,
>  	pm_runtime_set_autosuspend_delay(dev, 250);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_active(dev);
> -	pm_runtime_get_noresume(dev);
>  
>  	ret = devm_pm_runtime_enable(dev);
>  	if (ret)
>  		return ret;
>  
> +	pm_runtime_get_noresume(dev);

I think it would be better to drop the reference on the error
path. Doing it this way round there is a very small chance that
the device auto-suspends between the enable and get_noresume.
The intention was to keep everything powered on until bring up
was complete.

Thanks,
Charles
