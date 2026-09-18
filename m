Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0874FD281;
	Fri, 18 Sep 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743455; cv=fail; b=YlhqKRpozcC2bUfICtbTKIPM6QScBcdoTIxdD5v1Ju2kCjtQztTiTqDYBwkStv+DFTIlweMC0kEIuYsTKhFBUQqQjH6FkAFRqEcYSTmZ3JT+UisICBTNqtGsDE+6Vg2+4DnJqje4mpi/D8hjV7DKUKEg9OMm+pnwoiNADbSv074=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743455; c=relaxed/simple;
	bh=12ChgY/Swxgp5buM9vGq4qv2DAuFI0Uu+vF7PtyopiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjCeOyxN2X5fgO/YjaL+KFDUzWs2WdadXozZDy1oMDQaIsvB3LG3YjmagWPA40jEuJjTV85WV9Vy0+Ss9rVu5AAQcuPKRQzRcMd+1JGdPF6hNTsnBUkf7xk6KmtwgTqAZm0cZUdjn1S32+7dZwP1A/vpnC86V9W7xNwVz9oDVi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gKDI+0sT; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=PD+Hs1lI; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gKDI+0sT";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="PD+Hs1lI"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IEDjno2648216;
	Fri, 18 Sep 2026 09:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=kpyhXyUg79AAFYBuAG
	KtwzN9IkQZXsVcAtDTjLHfliA=; b=gKDI+0sTXFtSHX4kv21XrXGTlwzXCSg65n
	uC3CKW0pKNPM3FFMqWIMbFexYqLsbgioF9dHH56qP0D1TNiP0t6gBjBURMj+a10s
	uRBLlHxtGzBsv9GYvxSa1vjpmaiCP5vhs9xeIIFGnna3aNHm4S+vIu5+tF/DgatR
	HEcqY4PnkaGe46Kx11N7MggPQVPgXp/dnRj9ikTBXoZZ4RztLkYqnQJTVlDO/RVL
	XDIEDewaXYXOtMMOGS0V/d1ND7kv8esSdTFTIfNkDPaG/TFVz7Vxse2fas+ajn9W
	EnqOXqVPUlalmly+HWBiRAXqOLcG0Pa1Wh740AtvNHH4PjBhP6uQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020108.outbound.protection.outlook.com [52.101.193.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gs6vmr2s5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 09:57:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL5CIgbjFrQGYMfHCczisF63JgP66AJgEhWfRVsnuRu5aBGETRlfQw6aCQvjWonxslR4WHNKlSHaehtI6H2EaiDlbaXjPfEylPRuFAd5HCuj1WNdNu335ZnU2Zv6cDx24vxY44RZMvomZtuvJJoXJGMMKZ7CksPFa+aqkhwMER8878gjowGPAFFyG3ZsVvUwxnXEmqYYMstCcp4TBALHcKnQ2qTeiskXeMO2VEHlotSnlxrGk2skL3TxYQKhP8ShiQpYQSiSP/FEODAAt12skw34Knun9taRYa0PWDvwaXay+fY+t2gCx2ya7ViJvAcJK3b3k+rQuWxnyT+JtP8e5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpyhXyUg79AAFYBuAGKtwzN9IkQZXsVcAtDTjLHfliA=;
 b=dV9MKJbLc2vvHrJbHhQ9wieiyNrZ1tQu8gk6dDQVRhcrP7eTk+lUP0WTmH2Y8U45Y4036fTajTTYv0jvcGKIga1mWWO2O1m0TB4UqMO/z9UqvHOFvFpY/oW0XjJvz8iJ7/3eHNWXPw9yoA/Hu0ekZpbTghgU5s8dr/sO9Ft9o6BtVXRwKVrU8VALMom72b/FHYchgONWFyjyTnKxOCiAKxM9I3QLCIjg8MNqcZvDHrKXMH/GxXcue2YEMtgONsW85tzwwGXzBiCYAcWQfNe7iJzVOa7ctoBSzmDdoqfl9TKCXOg9AYSe6H9zjDSf1gcvLrNsfXYkiUCksotwa3zRuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpyhXyUg79AAFYBuAGKtwzN9IkQZXsVcAtDTjLHfliA=;
 b=PD+Hs1lIv1F9U9x/kebVPzesAdc9ELmsNpT4fBK1Xep/Mo/icLfKzVDoUwh4jHZXiyWmYs+C6FXf2U4wcXizOVVQG1XBjQ8CREotVbBeSSlVdo95sQlxToA7jfdKmDRKaoQMD8VzMurzUcMnuy3MYcXwDsgZg3R9VQM7/42OhoY=
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by CH6PR19MB329215.namprd19.prod.outlook.com (2603:10b6:610:303::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 14:57:14 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:303:86:cafe::73) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 14:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 18 Sep 2026 14:57:12 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8A648406542;
	Fri, 18 Sep 2026 14:57:11 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7341482254B;
	Fri, 18 Sep 2026 14:57:11 +0000 (UTC)
Date: Fri, 18 Sep 2026 15:57:10 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, krzk@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, perex@perex.cz, s.nawrocki@samsung.com,
        tiwai@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wm8994: Fix runtime PM leak in
 wm8994_mic_detect()
Message-ID: <aq1RRlQQB2BTikJF@opensource.cirrus.com>
References: <20260917165130.2163278-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917165130.2163278-1-vulab@iscas.ac.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|CH6PR19MB329215:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f4fa23-6450-46e1-16c8-08df15951f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|23010399003|7416014|376014|36860700016|6133799003|22082099003|10067099003|11063799006|56012099006|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O6Xyix02fJWKl/z/CUW301KqZDEsvuQj1JUa3uFWJWNAtlx5okkYUh4O2xM/2iZgiHTyp2+Mj6e7miuAxSSg7I0cuObMmIiRuADm5jzrjGn8W6BYz6ZJ0APVsaKIaVr1H2EqphvCsYZYIz3HyfLM6nV0Vwr2U472WCBUazomkXnYIxN3yQ8o5sfuQqTGSYrVFDxtmH15bW+e5PFkmHEA/2jwJ033qJgIbXy3M80daTnMu3ELaESQAJNJ5z/plsCpPorVt5AViu7lqxyJa6rzviZwcFQMUpZjVXKKN8hLw3GtGqBB04k9PFEWKM8yUPWpn5FutUIyihQZMQQ2xasIVTG0UgahHgaYVAD4NFvFwGgScW9i2SaJYJhyvmQxAFNKQX/5DYUH5y0KaOyzsjkqMJj4ZpZN/nrmoiSmg32dwDFE07xmLQLfv7NFbCtCNcLummhPKH0Hmzww2sa2SaTlvieLD9YRFjczfAd+/l66cOtK1uxnqx7PkrAx2SRQe3dBJnlYWT9w3ryUyZ9/lkYueIiUIoBaCsos8gIndkHyYFkd/NVoSCsptyWo9GLnPhE58nQBA9/fmE0X/Nk2Jr01TRcn9scrVrBqpwsP8P4ZY+OLnx4q2NyWg4Ld2zJsovt1RPB5zJrLnevx72TeWZHfUpsPs++YooTsRTTAY4WIL1ujdXy2XM468e+5GzJVQ2I0Oy0RrUQxZZ69y8ZI4UK4ig==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(23010399003)(7416014)(376014)(36860700016)(6133799003)(22082099003)(10067099003)(11063799006)(56012099006)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RTf+jiMTfbFgJ4j0e3uZtAxqLTKvSwwY1wKoNmNoCuWgJRpNEUBYiyOPZDD5JRSMjXkBNVNBFfn16dC1BqTcm+GSJZhwjJe0K5Y+Lutu9aGSh5yK+8J9AELfH9kzOjplD9EjZuA4AmYgQr6OVXmR0y++VDk6Qik62IleBqJM7JwFWTvtwocPFWbV+a4OBS9QAtPf9+MZQZEbcdDDfzUYeavPtWTZBPLNscmB8OYQXsan8MlSk9q2q+d69eiINSJUJBAz6u79mgjDSA6GWKwjTHphQGXWsunDe+YGB54GjVHQWG2/sVryW2BOARRtFRcluQW5SFtTaAK3+0u6Sws9c0zfQSsyrK0T0+Evz5EEDNR1sL6YB44l7hVG477voyw7IjAHSp1doE8FKb/tdnXxW7ARwe/rpm9kEkP9VDGjG0+wlK5GT9uBOhUv4JCaG4DL
X-Exchange-RoutingPolicyChecked:
	Z8R0feZRuQZ4NCUgCw0sCDs6g6pNqw/fzdVVoMsWZjFcjaD6MeNkXlZIO1obuuqLEc5bsIUoFZTiowVeOfcarQdMGfW3UsVwkmk2gdfRBm6fotbFaiO/Om9to49d2jtc/cHkTLIG4apgsKMtz+cahBv0zotIbix8Bswb7Fm3GkxZRHvY/ylC55CIlcbyHMZPjlJUept1OYu56EnWHB5zQh3cM1hmeBUOS0VVdh+zYbEcP2lCs1HgJjqzNG1X0jZxQjAt7Hs/Xap/C3oVPVaLA42ZFzNmaMzHTq2ZK041LMitej85wgkm59z7OIcrU40ji3Km70RmkUzRQtN2glJvxA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 14:57:12.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4fa23-6450-46e1-16c8-08df15951f7a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH6PR19MB329215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxMyBTYWx0ZWRfX5buYLpdoIgbE
 bym5RWBvLxarw8t7webmrB8jevNTWk0szQ/XUoyqlH5fuXUL/4A0nEtBz2Grzxx/O04J39iYPa/
 hCyVTe1MqR0Ilcw/wTSe+ROS/CT64ykApQXcxGxK5lJDjpjrDc9oR1hSS2cxprtVfGTpF2qvZc8
 ld8Hzp/ZrPNPuy6r/a9dERU14HUkOpaL5xiA9rtWALrao7ZHQnwVJbVS9sF/JaYe3eOj9Inrtm0
 CdCnaSf85NyasILKa7JPTj4+brSwkICX+jQwH2pJ1vxKkfo959lV4tGzWRabtdiM/SfSo79lb2F
 I4rt42Xm87Xqigqyft/H3q4tgZGEcRBmXkFquyr+MAamnOIcFb2K5nyumv98ZNbwBKyUsrrXDuY
 ps6u2OQJlVe8Zrzfi6krE2CBiSHCXdTW65DghFxzqfTimk7FZQG8myzw3GkYbkNTLTufmlw1u99
 zeCVNacjG0aOzWNjFYw==
X-Authority-Analysis: v=2.4 cv=YawodARf c=1 sm=1 tr=0 ts=6aad514f cx=c_pps
 a=3vymZyyPHrzzyqIQw/cfUw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=ykPtkzD1fplRG1xO3x8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxMyBTYWx0ZWRfX/tHBcRF4E4aZ
 InyV/+r8HjFNdKjTQKjVadcS/ZPsucIQuCn/Ka91pd9RvSgkEkoPRMe6ugL3fPpH+ClmV0WFuW3
 h+h9dxL/QSb/VBtqe1AVj/12VnVNlWQ=
X-Proofpoint-GUID: j50s-ml-RhNvKcp4ZEy5an7ZykTGt2WT
X-Proofpoint-ORIG-GUID: j50s-ml-RhNvKcp4ZEy5an7ZykTGt2WT
X-Proofpoint-Spam-Reason: safe

On Thu, Sep 17, 2026 at 04:51:30PM +0000, Wentao Liang wrote:
> wm8994_mic_detect() resumes the component before configuring the MICBIAS
> pins, but the default case of the micbias switch returns -EINVAL right
> after taking that reference, skipping the pm_runtime_put() on the
> success path. This leaks a runtime PM reference on every call with an
> invalid micbias.
> 
> Release the reference before returning -EINVAL.
> 
> Fixes: f5a2cda4f1db ("ASoC: wm8994: Ensure the device is resumed in wm89xx_mic_detect functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
