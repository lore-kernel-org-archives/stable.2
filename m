Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528234DCCD;
	Fri, 25 Sep 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327355; cv=fail; b=d7yvY66W8Le5RhKQevCrbysJysWHFtKCbax+xk8AVm1ZJ7iL0uqIrrM81IcOXusTY3OdbBas+R2QNaqXEd9pL/oqyU4mrscPZMxoFPb3Bfxp0FAVFR+ay/qOZhO11v1CjLIKCvpOyihkVHszr2qOsZdjplG0Opyh3B+d9zmjAvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327355; c=relaxed/simple;
	bh=h9P2qbdSG8IYIEC5hd5nlvcLcz+ijzw4aFcmIIB7smQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDNEUBxqMyZgC+SKjtdQ4ABEsib4y02WUURWGjzHQ45hqvQhC61CbfT6Z33lI9BOZCwctxtdwZbtwyBpU2+hPWajsb2JB9gSCkTFck4pi1urjwqzbLZtCjH1Yq1J/BKaH5byuTR8cVYwZWyMF0hvgW/uBJDw2fGZzwv8F1hLe78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ab7tT5Ji; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Nql7pbKq; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ab7tT5Ji";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Nql7pbKq"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P7nlq92207596;
	Fri, 25 Sep 2026 04:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=NxMGOFsPIz5eZTvKZC
	oC4gcTW+M8tNT+45+0DnIZkmc=; b=ab7tT5JiKAGqx9qjuHHeolrnNgYnRRE3ul
	sPCVB+nnHHotQ6PIOXyNxmu2/TtdnbdJvlgeUGTtM73aUdTTlh9W1/m3zWrpHiy0
	136cm0wn+4f1YSM9rJNZxhO/kGJE24jsQZY4nvbwrgzRmQ4jB8tsLBGIXaXOSqsV
	4uLn67LfDk9coaLmRRId5nljDN56ezkbjYtR9urAegaw0q2ou1MIWdQXhCOf4CbH
	AK18inkcqOh06bAhhBtLmImd6rpflRPBgs/uyq+ZZvBrqfcXlHQ45Jzgyrx2c2hQ
	+RUiaQ271/ymYi5Ilz2TjDu6gpd54bSpdlhdVVeyehB0qetnEIZg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023108.outbound.protection.outlook.com [40.93.196.108])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gw698h0s2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:08:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBejMexnHiupgIVF4WBEmVrKMhFODKzPOtupDBIAs5njSjzzCH5lzXKEIfQ3qj27D6HyYGp4cjgjcV/8z6eBB+O6K388nF8EPQt7F0a9LCyS2mmNYvQZEaLylRn97dRCr0zEth2y7+ADoenel5kz4U9rESkiLKMxs+qzkU/YJOVMLVIidFdVM4/n5ryw3Xn1ZpZtHrrPlBf/uDgu9iEuODti9C/ReNlG7HG/1+R5tXRmsG3/JvQ/TKZK2SnWK+oCHGzoRjbGfO9GKY1g9v2G42xPlFG1QVlHKYMdMwH3138NSFkGA4cpD1MXi5xU6BHETbbJ+a8jJPrexpeOuAWtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxMGOFsPIz5eZTvKZCoC4gcTW+M8tNT+45+0DnIZkmc=;
 b=yRcUoGJNVxpg+LKTktTHmYA4E8Jpy7xF6Zu4Gtxa/JGKumyhpL0vKJTzjB+1c4HCp8DG0/czIF7O+LO/1T0CQPoNoc/elSvApJ65zpGcRBQJ/tHYw2mCFoFD11rXuTznQYGAA5xO+eT2uUsyZP/StLL4YKXnVPDG5vVxzX0EvpO8weaCzONX0jxrDnGwko5lpQLASDyXKn41NUDidb3hrUBXe3enhKk6mykYLyEuDu443VbQYQnRRXa+FwMRnzLgaQN7pFk1UhhCnWf71jd83Lu9qSnFoh7MR/0Mz2D1M1LzItunCBcgr1iEr5WueQ6MzI2492+/pDnuxnJPvRTzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxMGOFsPIz5eZTvKZCoC4gcTW+M8tNT+45+0DnIZkmc=;
 b=Nql7pbKqODwTQEOkaV4c+kNQYyDWo7KWFqVlcpWU7IdZAwPTe0WR+A40sCuHlJMrun9W9o2u7zJGGgmIUXDD/8caT7z29FRExVpJChuJNX8MjvOOsPm91Z84XcZUCCUuZwUpPOJUGjlU+Tir0BTaqko7F3iln2/swzkOpJnNJtQ=
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by DM3PPF636AABA4F.namprd19.prod.outlook.com (2603:10b6:f:fc00::72e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 09:08:45 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::18) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 09:08:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 09:08:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 5B4DB406540;
	Fri, 25 Sep 2026 09:08:43 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 218F1820247;
	Fri, 25 Sep 2026 09:08:43 +0000 (UTC)
Date: Fri, 25 Sep 2026 10:08:41 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: mhun512@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ae878000@gmail.com
Subject: Re: [PATCH v3] ASoC: wm8962: Stop IRQ from requeuing mic_work on
 remove
Message-ID: <arY6GbRBjKxJDKVn@opensource.cirrus.com>
References: <CAGEsz8G_s8_HRnHH8s+NvXWXV8Uz2xRDY+He9M57v_fW4H42VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEsz8G_s8_HRnHH8s+NvXWXV8Uz2xRDY+He9M57v_fW4H42VA@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|DM3PPF636AABA4F:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b3942b-888e-49ff-e73b-08df1ae499f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|376014|82310400026|36860700016|10067099003|22082099003|56012099006|11063799006|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bLy5UCWjGn0Vuk1daKtnul/T1TQSfUTX+NXoKtPe2NdlaBjckwkTmCBbRxifxHYa1EVEmMU0LDHA54Q694cqYXjHvoaApBsZeTY93vU9n5YjmPys33erpeLRiUo6WcFu/MGRGmAneuSpthECjq4uuA+UQMHjRIgs2Rp50AXUEZYjeOG97epjhwqLeHEBOXDt5wCtw18GPeTEaAPfJG4JSBNmWF6gMzSBlacegR225DkDPZr+j5P6HUHqLMnQso8alPeVqFqLVwU5KGhMQ6ER0yPzIOXDtWoqipL245eVkuzVrdWmf7D7mLgCp2aP7oniecDNlPgl9s+mqg/BmeWupMpG4B+gG+2jhPruGiU+ASc2sCv3mFzYwjefPfDuF9A73BJw9kQRu15zLmlCNxAWm4xHay4ued2Y78VCMUKpnmyRez6aTB5ZIXk0t7qoRoq396bV6IZEV1/u1UcVHmcl/2+DGMSCNSHBytThkMOZgo6hLKJN0rCrx2l41imqSdAv+4snckaHL3Y+NiiwCrinYC8AzrEEP/5wgW/K+UJKGzfZ5hkwPadqjS3VK2c8CG8G9n4+N9nAEQqH/ZfqjrPAlyp/l3uDGBkAXJggFIBN/p3dfeAgUFg4uVNTZ75K5w28V28Pyv1QWebCQPQkHJpffhXaA+GeWeCp75gqsqkQAT/CnKGBxmLyBHtfBLwiIPCy2lqwcX/q5x47gno7C05yRw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(22082099003)(56012099006)(11063799006)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qAdEcwds88N9C68YqAwdVghFwPdxGeDxdR8hhOGwDmNkuXzgsEkfKaZW49qJcDk8pEuwbk7eTVaDQwZqbOLhWy9E9DAAlmfmvc4NisHgk/1+/VkYA1GgHLieXVagX881AkNmG9tySmvIynL24yWNJy4nh5d74lUy/13sduITTVz2JrLIasWErn0yRgKMxpjK207uRwuKzWqDTL9wugfYheN3T7Zy2liC29rV3sskEK3R+sg4etHtyTwl+qDNB755KhrtDBBqNR3HGOeNmW2hjltrR+tyGYg+UoQPrpseyw3lLykFELDrHiIh9xN2sCW0T3JDTdg+LNZMLQqUjRv3RaMtnS/KHLzdjQkF1wKLAR2dBk5OAbQdWQckIvzQFJWctnp2bNLdT+pyTZFlPwD4gHspdxqWXvPEGpBS9D7p4uTLphH7BJwZ+PEBTHwyqeUk
X-Exchange-RoutingPolicyChecked:
	f8c2Eh/kep7wANP4Op+nUrtv2TQrOBxO95MAJrzISAO+ZPuUGcyK8F7cW5QZSTs0pvl2KssEpk5Fz7vEMSagA68UzkMLUZBLc/Sdh5xZW+S2ePATZL2eNuXXUeCNixe0NTB5VSALqxQoC860bWpsiaUid+QCdf0pyd9Ky9AEVMU0S3icv4Gnigemn8cMaVW2lTSXlMV/rB6cHR/Q7sMFTkc+5ssOmsAmbeLg20g/vXcdr4aSUMXUh0lgjm06pXip2/VgzVXxusxgbslfIpRpoxzE/AsSuedaeAznOsaSAWdQXjzqRH5xNRzfc68K8/50i73j0YlaD/Nozu5BKSISaA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:08:44.5320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b3942b-888e-49ff-e73b-08df1ae499f0
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF636AABA4F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX0qKXlPNhnPRP
 mQz2X7PsmhuL6Sfvx4MP8EWI45GsF8nrtuM32SwV0S6hdnCgT7ITnIMbRstkgG9u3zc+gsO49F+
 UzW1p6jleUdgal9875ok2NvibHLk3DUwgTx37VIFvKL/qpKEzxSRebO4hj79gPXK0W+w4JsNOtA
 kyXN38X4FzU6uIp3pDa1fNnmRzOdfqW1FtZtYazw8opUNBQrUUakYo6BgdDwPBUktEDfI3bx4ux
 tW9LUnATYvc0WgsNRINNfVRJm96NA/aqe5r8wFy5BX6Yga6eV2r5eBStS1NedA1uen46Rc+CX7Q
 1h96e4krOK9Rs5dKz00uej8QICXX2ueQm8py2Dhr1ubyRYOfHOfFMn8jdYPPw+tcpwqskyPS/Ab
 DHrZaTSnCvk332UTvqER/PRDngrTN2e1YNspdTwdij6uvfbkZGgqRpnL3hwA7X7JttDqyf+XP/j
 1anFsjfiGdYC0dtZ7Bw==
X-Proofpoint-GUID: eb1CHC1OKcjUwn-_BVM0HWspmsxbk9HN
X-Authority-Analysis: v=2.4 cv=Zu94uN7G c=1 sm=1 tr=0 ts=6ab63a22 cx=c_pps
 a=5+C5dWQ2lNXIGJ5Pv9T82A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=pGLkceISAAAA:8 a=a0J8J_ENjLl8oPq8yEYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX1My8f/zIZiG3
 75JtUpQ9TFILv1h1Fu+hN/OsAqV7b2bt7xHzEyYkHm5qGX3VW8T3CqyU6nibE4jBmEq6+tCkz4K
 kjXbEwnnNtA0uOyg9F6SNw/76UTdr/0=
X-Proofpoint-ORIG-GUID: eb1CHC1OKcjUwn-_BVM0HWspmsxbk9HN
X-Proofpoint-Spam-Reason: safe

On Thu, Sep 24, 2026 at 03:05:41PM -0700, mhun512@gmail.com wrote:
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 8a9598161b35..7b09de65a009 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3230,21 +3230,22 @@ int wm8962_mic_detect(struct snd_soc_component
> *component, struct snd_soc_jack *
>  {
>  	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
>  	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
> -	int irq_mask, enable;
> -
> -	wm8962->jack = jack;
> -	if (jack) {
> -		irq_mask = 0;
> -		enable = WM8962_MICDET_ENA;
> -	} else {
> -		irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
> -		enable = 0;
> -	}
> +	int mic_irq_mask = WM8962_MICD_EINT | WM8962_MICSCD_EINT;
> 
> +	/* Mask microphone events, then drain the IRQ and work before
> changing the jack. */

Your email client appears to be corrupting the patch here, this
won't apply.

>  	snd_soc_component_update_bits(component, WM8962_INTERRUPT_STATUS_2_MASK,
> -			    WM8962_MICD_EINT | WM8962_MICSCD_EINT, irq_mask);
> +				    mic_irq_mask, mic_irq_mask);
>  	snd_soc_component_update_bits(component, WM8962_ADDITIONAL_CONTROL_4,
> -			    WM8962_MICDET_ENA, enable);
> +				    WM8962_MICDET_ENA, jack ? WM8962_MICDET_ENA : 0);

I would be tempted to just always disable here.

> +	if (wm8962->irq)
> +		synchronize_irq(wm8962->irq);
> +	cancel_delayed_work_sync(&wm8962->mic_work);
> +
> +	wm8962->jack = jack;
> +	if (jack)
> +		snd_soc_component_update_bits(component,
> +					      WM8962_INTERRUPT_STATUS_2_MASK,
> +					      mic_irq_mask, 0);

And then enable here, if needed. The current patch changes from
enabling after the IRQ is unmasked to enabling whilst it is
masked. Since neither of us have hardware its probably better not
to change that sequencing.

> 
>  	/* Send an initial empty report */
>  	snd_soc_jack_report(wm8962->jack, 0,
> @@ -3592,9 +3593,7 @@ static int wm8962_probe(struct snd_soc_component
> *component)
> 
>  static void wm8962_remove(struct snd_soc_component *component)
>  {
> -	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
> -
> -	cancel_delayed_work_sync(&wm8962->mic_work);
> +	wm8962_mic_detect(component, NULL);
> 
>  	wm8962_free_gpio(component);
>  	wm8962_free_beep(component);
> diff --git a/sound/soc/tegra/tegra_wm8962.c b/sound/soc/tegra/tegra_wm8962.c
> index 31f9d9181595..a79d464b6a80 100644
> --- a/sound/soc/tegra/tegra_wm8962.c
> +++ b/sound/soc/tegra/tegra_wm8962.c
> @@ -97,18 +97,6 @@ static int tegra_wm8962_init(struct snd_soc_pcm_runtime *rtd)
>  	return 0;
>  }
> 
> -static int tegra_wm8962_remove(struct snd_soc_card *card)
> -{
> -	struct snd_soc_dai_link *link = &card->dai_link[0];
> -	struct snd_soc_pcm_runtime *rtd = snd_soc_get_pcm_runtime(card, link);
> -	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
> -	struct snd_soc_component *component = codec_dai->component;
> -
> -	wm8962_mic_detect(component, NULL);
> -
> -	return 0;
> -}

I don't think you should remove this. It is possible to remove
the machine driver but not the codec driver, and in that case you
still want the mic_detect disabled.

Thanks,
Charles
