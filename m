Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52904BC00F;
	Wed, 16 Sep 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552977; cv=fail; b=ggI5qVDqDE6TqdbqDLe8An1Jc8qNX+wg3f7gPub0o5PzqbABcJ7XVxhaLiqRq6iGaYWhoaZCqihLnb/z5+z39jBM3ZUFasvpmH/UnxOM41hDIMl/bOPHBb/5B1+gveM/75soqzBUMI0me18tJAQNd2+c4PQ1edlWBDac0Urx77U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552977; c=relaxed/simple;
	bh=ZBluvK9KoKfCpFmB5C8G89/Zxg+oUG5WDTgSau3pEtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIwp+4yXaYpV3OYalgRBHzDOiZ2yLSZ9QMDPt7dgi1z8dJdhhaKdwcJRsxPEBqV/RGoJimDNeD+ro2pVC1myhHeQzjDuMjYPebHJIiM+TYuRbfySC573yoJVkj40kqkuTt49Ch3thIA2SjSh30TFMzCGWdh/JaKOaKqJJW98sKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LpwXY8sb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=sDoojFGS; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LpwXY8sb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="sDoojFGS"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G4RpBW1336007;
	Wed, 16 Sep 2026 05:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=QA8PFVQ25DFI8VKyYY
	cZ0vOaJ7/pDlBxR/uhFj/tgsY=; b=LpwXY8sb8cOt5Ybcib6Ht/nQAfuUVbifZ/
	QZ/cIGV0cgnPwBLqIn+UbVaq3KQ1IYwhbQs6KpT2qoG/X9TC/M+kzW7Ehi2I96ao
	KqhFS/F+Htg45xAMQCPiperaaqYsLI98D3eVBnmyHR2eiQmuIcRsU5Ur2tx5tYqs
	ZC+xlJDFFzKf3PDtEK8rFPBTe1E9E7kt+ZrktASYrudgXYtzzwY82LQUQtsI2mqu
	4jzNfvSToEzc/emKsHJk8ilQKnUC1IQvfgVgiA8l+WKMpMq5orKRVaBZkAqAEXHS
	giR0OpUx1BGrMpsR8oIRTU4iVipXiN7ZuvLv3UZqoXZ2JGPZKs1A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11023119.outbound.protection.outlook.com [40.93.201.119])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gn44wcwnd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 05:02:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEpRySXierPhKUgd1La7PydFszYAPoWtNTUeAcl+7jtlW676S6Xa83H7dy7mWCfFB9/gXGefkqoFRUGCMnQ+QrrVrf6bKcXGhxbmGu2l0TAPgcDKdA9plyo6binJA+VekuQovICPSArJTMerOFP4XSWDdw39A0EZzD2LiMwByxxsYirMs/GH52pT54Ob2jY3F/heAzC6MTPmcYOlvrObFo6ZaknBfelzcki+u+ykuYLSh6LQqJWl8z393FOh/kdCtajnvnhHIaeJ+w7Ab6rsiKjO3/FNijxHVacc7v6AwzzuqqJWmY3XCHWNIUpFdVvG0OWKOB7xL1cC35D7+gzBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA8PFVQ25DFI8VKyYYcZ0vOaJ7/pDlBxR/uhFj/tgsY=;
 b=fYbRXvpgltj1EQva0pvXFZA+hWGRXK79ySx1cR/ZwdTNq6kBujgD9xNgqVgQTp5hJTLJkcxdO9taM76XmM14b73Dri3IjLg3VHESe4IFIsS3krkaBPvs9bJ6hA1RYmdg6Gw1Yb31IAXAPaY8cxfNdMQGR4GR5PlVpFoLvZLf0NV05ZzYfptvohqH1uIi+FVxgP9DqJgv2i/qPc2utoanecD2iv7FvqPPq3xCVycJAHghN7558qhZG/IHy4yg9aivlGcwnn0nzadCfTpBpwbXHUVwE2n2lYlFi9hBBUP6ni7bhZf0V8hPqg5VHcWJaWiVKmyt1DNL4hoyLUkePZpd7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QA8PFVQ25DFI8VKyYYcZ0vOaJ7/pDlBxR/uhFj/tgsY=;
 b=sDoojFGSRokMXxcD8/6LJQl2jo7cp5wzbALJTnuzGI6NerwGTye4MptCEVn1dipWua3PF8se7dmd0hggC+otm23O8V08qzyVInHSeMtpKyuhZT4Mpuc9tolRQKDJnMOFAsnosDcpiXcyN6K21myAAeTRY72Ad6oRZ0Ak33YQufY=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by SJ0PR19MB4573.namprd19.prod.outlook.com (2603:10b6:a03:281::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:02:20 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::29) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 10:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Wed, 16 Sep 2026 10:02:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id AAF27406542;
	Wed, 16 Sep 2026 10:02:17 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 92C96820247;
	Wed, 16 Sep 2026 10:02:17 +0000 (UTC)
Date: Wed, 16 Sep 2026 11:02:16 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, krzk@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, perex@perex.cz, s.nawrocki@samsung.com,
        tiwai@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8994: Fix runtime PM imbalance in
 wm8994_component_probe()
Message-ID: <aqppKCFK8J52jciy@opensource.cirrus.com>
References: <20260916072737.1970990-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916072737.1970990-1-vulab@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|SJ0PR19MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 393a9a41-4073-4989-fa93-08df13d997e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|61400799027|23010399003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003|16102099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	63BdXjcIb2PpHdz7X27KqJmAEGnnphYXGHllRAHGTo4/8nHEH+tbPytjTqRU35DYdXxgkZXmEdnsbgm81PLN/UedmhLS2+hPLZcCTWkaDhDwtG9oJmox5BYeEv2HdsNYvq8W8yxlHYh1aKRXTQc1OKxsl/DQBDm+Z4SeCKU5u02HRjrvdBcoPW/BX3vV2fYKUkvjZH9uqWGPzpgFRibCsby2cOjzsWGPmxtiWi0xkkNOxzicPvomLvJMsrxmIFrsebmQKyWGr1gNibbxrMAkdsxmzJnkide5WdFo/Q8VEegdWBR++7/VK4LDUmfV5JfRYDzDOb3OzBhgfGg2Dx1lzqqpX8F91wQQjVCxv5Mz42l5Mpj1rNqCkdHpkglipkKTpqpTimOFFvTujisEEW4qDJKePBvYDqZdOimGrwEOODfn+UFVZrnmW19v+GG+f6lLE/fEOIWU+CXP14pd7vwyVjwKWWCxmCZw8RuO1UqPaw3tcGXEZ09+CFuGToUrnsgK647Y4xRrK0Rz6OsNvSG4wS820+LfSAKsfwzBDQqyj3Pg9Y0/p0hqqrfwD+Bd5c7IVytD3xbBYqcfNLcv+yP8wogBC1MzUsnL+VzX1+FQs3wc1/J2euiJSjDc3yz1kQd76366RxKdRf19sWlkrBzDy9JDPDdj4ArwZ/myebfJ6+vA3i4Lvz5CC2ZkxMZXSdqi07zlRKbb9LBNbIttWb3wig==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(61400799027)(23010399003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(16102099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4hkyZcyU9t+jW/y2YpQEQcvZGwcHRP7YOl7rScd1FIPQRelbSVINM5BO1i+mbgZlZ/sHkvIKR/kCDJP9pRWvCZ71TUKQGg8yfnHmduBpRBqVQtclFCEMRv8QBh6ttS9eAOw1P1mfz4qlV63GykBp0V4gUsRRxNNHw0WtwfGn8h+DCloeIz6S+4zVS4mb54Em1r/NoLnPIwH6qki5pv1pi30pHc/oJwouYJDM26LhcRD/I7naYsWT03HUwnUKgle9LbCjEMmiuxZmpnkHkC09cr9iZJef/5Qva75AFfgTDPzWm3+0Ec5cjdFxD21Y2CTib45zqc6NrurKuK1aWNzMfFR8lmN/gvRksNeSF+a5z4WnhsWucNPPeDb9zukHfRldDidNNl0oa7wyfdhzzy1kLW572yM4/M+58FIuSMy4SaOxYa7laRhU+lRp3qUwzC/s
X-Exchange-RoutingPolicyChecked:
	H+c2/YO2wwE6T2nJDPZeDZ6yBjsRVwGcqnloPe3NR2EUq1gxEJQLWkAwGcWU5iQKAbuCTbS8QRaz2cyANVs3xcE0bKghCtwdbLeERWbEhvNS8abl1xSiJiItoiuuV4FvSF53CWgFslwC+vWhgeB00CzheLgEvOIv8ong+dTM1TAmUge+1y4gdFpHRtRs5ZBmt4YPPTyJkiiN+pNqBY3VXiUSVI62blFz/5ZzCkfHHg3qX1HnD1Y+I/izoTQNuz390vJpdG2/adKHvzOeRIdTLN21E5obiRs42gER23kKLAP4ZIlTZbKOsL0WJaFEZAUjMtZ0hImivtirlT5fbkO2sA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:02:18.4897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 393a9a41-4073-4989-fa93-08df13d997e4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4573
X-Authority-Analysis: v=2.4 cv=A+T5rKWG c=1 sm=1 tr=0 ts=6aaa6930 cx=c_pps
 a=GGm21VJdFNnJxsgjDtF6Hw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=MWxMQixJ1Fj_Q_dUTKsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfXzA9xfPaVjK1m
 zpxdhzZdZVB3TW9jig9q42y61/F3A/JOeMdQGnrJxWs+fG0pVV1bdVMWWe0CaaaQ+aBXZ09LHkc
 ClJZif/QxJdfB/P5uc42TOWBTgRXVgmCDOldHiC4rh0DDaYqvOO/UMJCm5kfw1aLGN/DInmZWRL
 yCCKqKmdD3z7WGBoPefyHw7a+5g2vCZxbj4QvbeMQKonGl3Zmjoij1oL3dd43nbljH01rFOZdZo
 AVQxs8yKVLc5DutDQpvfuKuTL9Vmr0ekZPgDKHp3fYQpJ+10P/XbKILgtXndCl9ZUC7Lnb6ukeD
 vpOL817yYLpJgUwNXDRXFl38Uhs3VLx4zkUkEp3my22UjD/+ww5aomHe7zS1UJmYGTEjb7JmK+/
 iJJwrTOIRDf+wST9cUULfvgMOswBBFTKkmV9dl2Xr/0bvkUj7EshVGVQnBhY9r7WT7K4g8raaG4
 eoW8ZOj6PaXv/fOZ6tA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX8yNyHW6Ufa8G
 iPWs8E42E5vwYN2YLYuBork1hXjjDN+VhumY1e3sxLLp7L+CUuR0Z2jdU2O0lxj+x3lgeWwRgYc
 yDDy4QcHQQErZWFbJ2yYvPo4qRm5QHM=
X-Proofpoint-ORIG-GUID: JQ9wyTq_in4MeAhjpPJP_T3zvSlat2j_
X-Proofpoint-GUID: JQ9wyTq_in4MeAhjpPJP_T3zvSlat2j_
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 16, 2026 at 07:27:37AM +0000, Wentao Liang wrote:
> In wm8994_component_probe(), pm_runtime_get_sync() is invoked before
> reading the GPIO configuration registers. If either regmap_read() fails,
> the function jumps to err_irq without calling pm_runtime_put(), leaving
> the runtime PM usage count incremented and causing a leak.
> 
> Add pm_runtime_put() on both GPIO read failure paths before jumping to
> err_irq.
> 
> Fixes: f5a2cda4f1db ("ASoC: wm8994: Ensure the device is resumed in wm89xx_mic_detect functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
