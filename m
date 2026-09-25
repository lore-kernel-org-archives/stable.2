Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3748643C;
	Fri, 25 Sep 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328681; cv=fail; b=jESdqQH0k6NRsPDhe0abtAE5NQknlZ8umlhAZFHBcvdjRo+q0sbyGw4gRX5xJAKJ5GYz+25TicvtGE0Mg9wLtOuY1CJ8J44uLT05CUEjO6TtdmLFZokhy7GeoFg643TUSgNkIHQdREvP9Vz3GW/9fCrL2yRUx6kAvxmFU3pY4MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328681; c=relaxed/simple;
	bh=8S6nMS58qPmmfFYXaaQoeTsU6AWZEQO+Rernezey3Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khbZin2EM96NGRRwUUHch44zskAzF5jBxYQtnqml/dD4CltU9Leco8VHOrA9UmnMwhVcYkb/NBSfKNB16XnIcPtSiVrLEkns4pZFmf+IfYyOR6G8LaRzOyhQc1aTO4hHng1cjaMdGos96BKaXEQjzoY4rc/ioSvNXhotX5pfSlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=T6+2zWC5; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=tNVqSs1Z; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T6+2zWC5";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="tNVqSs1Z"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P8wJhF2323021;
	Fri, 25 Sep 2026 04:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=z+RiC+cedgXEbHpSXR
	2+usT2iY38bebBeDWr25GdfwM=; b=T6+2zWC5Pi+oYz9JnIiAkNm2xj0mGkEIpK
	kIZLMOsNLEzC+xjCQZygJv+TLgDkcUXFmiLEor5MHqdiaxXm/AzGK4shcZt00AFV
	vyQ/xefjYoDu1wsef5hiFuxnG4Ykp7l9JD3sdTGxSmJU9PIuQehlEmbqKYg9BOVA
	waEc64ZKkkm+JkQ4QXG/nATKlSRoGQqJKlzk9G6553FyYVCAEdDtdOSZISRvQZac
	xMk1IsEu98ILwgS26RpUXT2QGVIFnpH14zRr0tzuqlRWXRjGp0tVIxMGGg2zwByV
	de2xUWqQH8V1BRwghkuvDxKELjKaLfQ6gJ4jIv1f25XJEX/DdEDw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021091.outbound.protection.outlook.com [52.101.52.91])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gw698h1e2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 04:31:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhI4v6Y9yCF1TZzcN6FioXLZ7EcKsxSfHkTpcCejIkCVschwSncyLIjsMQzDOgSYiOz3LJ8NJU4BI48SVlaNO06FwMAmw1ctyHSXXhXt4B99euWVrkzs9ZsmnIF44YEZBeZlbwxCb9wuCNHIAcUDQpctTaRn1igaJThGBLUO14RQVVxHnt1UOYNCDfaGP2MRo4oBIfvcpS6kumFi14WzYCmjJLTpV6DJUJT5CR4pT9qUQ+eTzgSmUDQM2Kp11+8xGwdkdFzF84RHO1hCDcwDdNgtLQTs+1u4n4+GZlSsQ2hGwidxpVicxO4oFIqq23JTSjiUW9fs5Dk99HDyvx+8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+RiC+cedgXEbHpSXR2+usT2iY38bebBeDWr25GdfwM=;
 b=h2ZN2C0N+MYeC5YQSBybMFuU4oPfmu23XJ525glgcDq1gJalq/EdnxRIXhhlW0dIpwKQpeXfPSwMl2lbQ643M5GJMZsElQu5Dp4wpqjp9neZnd0AnY77hZbTNJKOWkt9k/kqlHt4OIMlzKC6X9IArqhr6biAyQjeHj3ftQBgQQw5L92oYCMTAczy/C6N3WKsulblmJsQJq/OGFBg0pltqMvPoaunLWT5qGGjcI3Ics7pTc7YfC331HMFa4N5W3HtwlH48AjgT7v8FZyt1p32FPJfplLyN3wa2GRmKze413ggKwfEipQ7xPnACJgppjnpWq3clRcSR0ZMI/lnakFEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+RiC+cedgXEbHpSXR2+usT2iY38bebBeDWr25GdfwM=;
 b=tNVqSs1ZDzTBNAWr9Uc5NucJhhLepIEEySt+ZfMS2nxDCb+RTS242XJTfCYI06SI2bmYjRVGJw9Ra3Vo900MaojkqP0EHxuEZe+vO/5rNmkK2z9zSc2r8b6Qk5ZoGXY2vvGbcOd56SLDcMeegMYefKNve+JucW4TGJlDXih3jQY=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by SJ2PR19MB7557.namprd19.prod.outlook.com (2603:10b6:a03:4cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 09:31:04 +0000
Received: from BN7PEPF000000A5.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::ac) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 09:31:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN7PEPF000000A5.mail.protection.outlook.com (10.167.245.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Fri, 25 Sep 2026 09:31:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 90A05406540;
	Fri, 25 Sep 2026 09:31:02 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 5B0E5820247;
	Fri, 25 Sep 2026 09:31:02 +0000 (UTC)
Date: Fri, 25 Sep 2026 10:31:01 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: mhun512@gmail.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ae878000@gmail.com
Subject: Re: [PATCH v3] ASoC: wm8962: Stop IRQ from requeuing mic_work on
 remove
Message-ID: <arY/VSKn/sq32sr0@opensource.cirrus.com>
References: <CAGEsz8G_s8_HRnHH8s+NvXWXV8Uz2xRDY+He9M57v_fW4H42VA@mail.gmail.com>
 <arY6GbRBjKxJDKVn@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arY6GbRBjKxJDKVn@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A5:EE_|SJ2PR19MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6569c5-5b50-4974-22ff-08df1ae7b804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|61400799027|22082099003|16102099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	7YRggNE6dVJqNFUX4yrHGz/ME84VV0sIPS3ZR8D+CpxfrE6ZRJmF1Cju0nWbr2+AMgqafXYVL6Y4HISkUg34tDePAQqc9KracEonpBW7yywf8qUQkgrJ2snqAyQXHT4bK+FNyOhcKxpoLPiqh7U+pfqSvN7sJ1VESem1z7/z+NbghWSW4lckPIk8XhVJaSSqqfYvw3QXXpJj32KTKklo74a3WuLlYHnq4w/5aHp4FNrODKxaUSJClC3FymCrBIOu1RQOMxdOrrOTmtJCYNrP3odC2LFNTjnnASYt220DhSZpTvq6ZnWYxqZbTzfQEctlY4Z5qhrQFPtIpZzRqdUrJzbYgbNFSKJhilKVwekYIT7/uguplwcpRXqZuKw2xUHzX8D0vrQ+8EIzVwSq3gZjYdgoRBhpZZBXYzu+nCJT8XgsEV/esJB28iZJyz2JzLktk9fW92LDaJ9Ol6U7v9cpL6AVW3gd2//78+/zZcOEt2XXJ4Uonwq+ugqLwAMJhlXHcPSMqs1R2b0MlW1gGJk1oVfPxNk5EVYDi1KGK3m+HP8pqNt9gi+MFtLNHr2kO5X3GDoWtk5Zz+8Ag4iPUXIcQ/8eCIBfkZz0wJ5A0YK+v05aJSzd8SQeY7D8HHp5V1IufsOVTM+xf48cQTWcSRpU2UgQO657o/82NLl/+7mIaGGAqm2wgK0Fhp3ecpfQnbyHipM8UwsVLFKgpl70YgFVTQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(61400799027)(22082099003)(16102099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WoPaBBqFzv270psYxJd4ItRQxaYafGB0MBDe68bkZD0C0Jk0nTidSor4qODXkYQcxji5qIOY6e3qg2QGOLTTxqV0BDslIjepBpP8YDnWv2voZF/HXwtiIkIgfuwupHYQw83g1BBEn5A6NVRWHwVLHagzHDpBdrWMHhiUBwHt2r4qsgxkAt3fcxoSpiAm/uUbGzwk2yHPmwTdjLXxzMYYq/IPGcU4KITdUes4Loxi+teJ3ktgX+AKdp1uEtfmsdori/FmnGbP6/2+7H+C3lrOnpDnVkdE+CwdbPyDPLbezBVAOLWxC5jbgG8hvIFSSpG+rXOGsxA+oT+ah3+ZMqxO3aXPWGljd+MzwCOT4o7MLRUINX0tIJ086NdW7By9j35FmRjyKQmNQxgQhEC3B6SUegTP2FM5u3RETKOUMBRTqzCZRjc6H2bzrRAjCHZuByYX
X-Exchange-RoutingPolicyChecked:
	BwfgI0L1mPiXXDkeCuwgc7uCFtUB/wjddsBkgNJovpgkM+Xmo+RgHTFn5w8hfkOyGClA7vBN+/g+Hj9zzgiJbPC9JmTh6M9DnfNTHYLD8Fegi6a0nJERGvUv4pmfGQgC0lz1SGQSBO9zOy2QJ0saAw/UAC73GOZokG+FbOnx/iY7NVl4rkJGW+UTqq1miEmJxQnQHH3dRBXFHsKLogEbk5D9BlVI+mmS58iYVk6ZUaumMx1AuPQoDf3B1No7MRyaFInu6aXIDGCnZP4f34a+BCSfRnEIXfvnI7Rviys36sTbc8jqoGi7xt5G3cZ9Ilyfs5McZAD2q//xrY7XLHouhw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 09:31:03.4791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6569c5-5b50-4974-22ff-08df1ae7b804
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN7PEPF000000A5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB7557
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNyBTYWx0ZWRfX/528yT9tO+//
 lQOCSoiN6LOYXhGJnf8PzgoMcQe6waWNRzl7kOtQHvGCUMyEqNyPUf/WTF3seFshVdGuj5eSOwW
 ODdyFGQP+V7/MQDckqVIoDMNGSkLfS54ldUw8Oh1baYexRH+axbJgghAzNqpziyeTbVfK1Z2YSx
 UPkUAEzLRo3lXGDcgLTaDJPoBRMEPXFbdi6wg1e52ior3wcZDb9O/ag0j6FW7ArX0kq9Cmj4gXy
 wJM8ZgC37ICcXvzZ4NDPV7WvDS6Zn/IlOX1j/fPqASvOfnWgSECphTcv/ZcwWo+aFVee7CknFzQ
 oWNSxdaoCHm8yWqJilRrSD3NO5lt3oCxQw85qeiX3Xv4eEh5mKBIL4wj0H1MftM29ZGBjo+F38/
 fmfOrLJl5ltKBQuHvyDwz+SFqmSDnfiEqKftn97VQXLP8v+30RPlYCA4wUMyQOsJPOFsh7DSiNl
 9/h0TzJ/rVQEWpq9oTw==
X-Proofpoint-GUID: yiCI2z-ccvGc1FoIhld3eAEw6P6_5nTk
X-Authority-Analysis: v=2.4 cv=Zu94uN7G c=1 sm=1 tr=0 ts=6ab63f5c cx=c_pps
 a=xaVsnCbK3fgrqDKomIvovg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=pGLkceISAAAA:8 a=K-Uf-SQeT4GICe94HiYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNyBTYWx0ZWRfX5eCtaDSvafNe
 UAKHsajWDSIPOhnkDJTHhfRjpUf7PL0GcVB69YyV4TcvzuNggG2cH7wn4LyTdW0kOpyMPNmivIv
 AG3kgpVreDnzE4i0v13YlXNCbSY9w8o=
X-Proofpoint-ORIG-GUID: yiCI2z-ccvGc1FoIhld3eAEw6P6_5nTk
X-Proofpoint-Spam-Reason: safe

On Fri, Sep 25, 2026 at 10:08:41AM +0100, Charles Keepax wrote:
> On Thu, Sep 24, 2026 at 03:05:41PM -0700, mhun512@gmail.com wrote:
> >  	/* Send an initial empty report */
> >  	snd_soc_jack_report(wm8962->jack, 0,
> > @@ -3592,9 +3593,7 @@ static int wm8962_probe(struct snd_soc_component
> > *component)
> > 
> >  static void wm8962_remove(struct snd_soc_component *component)
> >  {
> > -	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
> > -
> > -	cancel_delayed_work_sync(&wm8962->mic_work);
> > +	wm8962_mic_detect(component, NULL);
> > 
> >  	wm8962_free_gpio(component);
> >  	wm8962_free_beep(component);
> > diff --git a/sound/soc/tegra/tegra_wm8962.c b/sound/soc/tegra/tegra_wm8962.c
> > index 31f9d9181595..a79d464b6a80 100644
> > --- a/sound/soc/tegra/tegra_wm8962.c
> > +++ b/sound/soc/tegra/tegra_wm8962.c
> > @@ -97,18 +97,6 @@ static int tegra_wm8962_init(struct snd_soc_pcm_runtime *rtd)
> >  	return 0;
> >  }
> > 
> > -static int tegra_wm8962_remove(struct snd_soc_card *card)
> > -{
> > -	struct snd_soc_dai_link *link = &card->dai_link[0];
> > -	struct snd_soc_pcm_runtime *rtd = snd_soc_get_pcm_runtime(card, link);
> > -	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
> > -	struct snd_soc_component *component = codec_dai->component;
> > -
> > -	wm8962_mic_detect(component, NULL);
> > -
> > -	return 0;
> > -}
> 
> I don't think you should remove this. It is possible to remove
> the machine driver but not the codec driver, and in that case you
> still want the mic_detect disabled.

Sorry mistake on my part, as we are doing wm8962_mic_detect in
component remove, not bus remove you probably can drop this.

Thanks,
Charles
