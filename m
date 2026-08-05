Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1E40D563;
	Wed,  5 Aug 2026 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923550; cv=fail; b=OJcK/MB9qfXYWJMgdSzLfd3J92zklGWwJ62r1YOEnPvZHfULL25QTNmOpTh9OyKLHiXm5bUsihVJz8P+MWR6q6LtOZlxaftlHuhdrY3HSj9oweou+TaZ5NWh5dSAZpRKqtZuflfn4THXNaRsyHPZ/uA+C8hNL3FJyBu2ZE/gP6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923550; c=relaxed/simple;
	bh=jFbPcDDQtfnHHPLBt1Cgr7IE7DrJ/e6lLSGzDFQt9Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtMaEOfzX1XLL1/CEJ/wHcGrdfQuo8moCdNQ5hVmpWqLhY/dOzHBQmkgUsU2tEVVaaB1ER80npdgJvcbsUdvOPeT/8nNdtDygkZFNBlMS+L60uY1xkhRcJX9OZPbZDBxy4vgkonTz9RQ5NSKhHuxWnBadQFMeWipoO8JAmZjMKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RxZhTgeK; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=QBrIkCqb reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RxZhTgeK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="QBrIkCqb"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67558qwX2591634;
	Wed, 5 Aug 2026 04:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PUmh3pPmCBIwSm1uc51ct6Y0mfq3k4w8gK4ThMMDTqc=; b=
	RxZhTgeKGiGCDs9m7sWjhwSBmqAeQTvhThW7cPtbAn5cxhmeMSIe8Xzyj9tqyTh4
	8sZLuPoQnTKqsxN9siwEP1frY9FLO64I88l1i1En9N3QwtXEKIN0ugPocYOkw5tn
	GGBnPl9phYaq64DQbIH/O5XIWzcKNKGLalItF8REGeoZ0GCsEuVaqwwZ6FICLAJF
	Svcuv5fSdTNarSehVEBP2J9BwTjdgNF5VvH+XRY9VPRJgj+g8CCoRWFBbCT0pmpN
	2ESL12SVf46SEKxaWcc5RQh3TIKfOR2UmS/pcuRgwT4hFhPK2Y9xL9jdFmVi8FGL
	cHvCs3vvKP+LLbcVWHjPSw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020111.outbound.protection.outlook.com [52.101.193.111])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5h2a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:52:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWNeHlXHOn3Ryj1S7YNWtv0qi2Ke7gk7HKwNVbkEzqZj9OCLOWCNrl8XCgLAIA0fql3YVbJvQW+ML02GFUepjVccLXcG2YqR1QJiqUbeUTVI6u//A5Izibff0SL/yJ5ddCy3ZLBzU+9sLUazLnf917SzrI/wcwYr3tOSHsuLGN6k/8j3GiSqsk9rXFr0IrDJdrtt9KyoZ+Ng15oOxQw/qIANosHoU6q3Qy+rzS34/zr7AtF7jy8BWnfD9uzE/hAI6zr2NoWLwFxk84rcHabybXONBnTrTFIz733495IGZ60Y25l+G5k1M2S2e+zRlKgcLmF7qWGKCfQQ+ooRjiWYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PA13qUohLrUpHxlqR9F13OLmdtglnotWhAXzuIpcCO8=;
 b=O+BsaQjpcF8k+KcV7mOjPWHGOznLgRo66T/6Mv83dJf5YYeD7WwdiHZTPweRrW4C+YzQAChclyo7YrEwgy8erfal12z0UWGYK4/i2mSa9IGKw6nPOnJWh8Md5bkhbwmOz3O6/TxPjSZHFotIGbZBW1fFf0PHTdsU61XurIID5+f7qoto4hijZ119BJStbhBaXSzEduWAm8h6dGeeclp4agdmacAuQQcI6YuiahFrvC4FaE2T9H5ySdOz9mDzNDErLLjXdHS3JHFOT6hv+bJguXpgnszPeqCGbDrBxLpAGv/AdTSkAbQzC6HotOjsQC4RNg7B1hGcXYNecL0eqfC/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PA13qUohLrUpHxlqR9F13OLmdtglnotWhAXzuIpcCO8=;
 b=QBrIkCqb/NXre0U7ebvlAT22z4syohWKDJIqbHiFrt2stuo+ZOyg2kC8M5us/9ZbRhrA+ssmsKkfyyKurOCS+fgOSM1f4RCL9yZKfkL1mVFn8+M1PwBerRPrllvNvMs2xo0Ga3p+C1kKNV4W9CdcixfdWGSoo/yEIr9AtwbLwM0=
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by PH7PR19MB6459.namprd19.prod.outlook.com (2603:10b6:510:1fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Wed, 5 Aug
 2026 09:52:17 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::61) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Wed, 5
 Aug 2026 09:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 09:52:16 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3C844406544;
	Wed,  5 Aug 2026 09:52:16 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 238A282025A;
	Wed,  5 Aug 2026 09:52:16 +0000 (UTC)
Date: Wed, 5 Aug 2026 10:52:15 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
Message-ID: <anMHz34y6GMNbLcT@opensource.cirrus.com>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|PH7PR19MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e679ee-00d8-412e-1ad8-08def2d73c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|61400799027|22082099003|16102099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	cuCpy5q2jsm77PMDPOsKkdp7WQv7i77ohFygvo2m6X/fTloEa6glvDWRrlePAveDNxKg7mpTmCbKoskY1IslSTxUHl5q7rtduCltYUnzTG28HNziGHLGbCtLX7EA2bPnSpPFq2/J2v+54YeGeRhQ6KXGzY8wQJ+TVKKGgy0k/StoHkIWjzdKfDpB76SH56p35GgEz2uN77MDUNbRD2qYBlJKM4XQt0QBE13ko5LjDIrXebhC2hrTiZexqe1JuNyxDnJV1OwDO07QsRVL09vQk2lq8goRgNpgkIJxag90umwpZHfwUHEb8b0XG6e2/XXUEOCvU5zsiSuqTtlnkuhL9oMk+u5iwE6mVngwOAYIWEfejn7eulL69XHjAeuhj9GiL5GxEIhpfTlR1/Qjei4EtbKdNYb2vNSjFfZ+x7j/tXL5bWejUcuWsV/6vil8q4JlgX4cIoUNqBTF8ufgpPVd9NCasVEzsb3eyN6n0S5xx4YJDZKjsTVeQQu0Ri6zX06v5SH4uG01AnZh2QEuj9Cu2+yWqpUbil2BXVR6USuBpAY+BtDsajB85xfrTt8/WJ9RsdaiGOWuN1ztwHUtptjxUGDvMx6m6ZTpzIw2WZSerYv4eAtCFS0/NOQGvRv6V9P88awGp/4/ILZ3NXD14JlHz7XOuDyKwE8sqcPSR32+Cxm0dfNT+Z5rr36VWm623vVdpNiCPfKc/ZMKRnUB19CtcQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(61400799027)(22082099003)(16102099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zIq5yTTGOcQX5uT3kdHOixZJVX7Vfg9Unv/dtMhlAyfBk8RDWzgh54uM+E48OxFvqkDhdIFsfoZSEBlaga89BwhKBWwfezIN0SwV/24arfOBPrIpTO+pJdTxwINNgcKQbqn5yQOJuU9iQDzLK15lCgat628NIvCiN3KV5hxjinlkFJDyuiwqoQAAdkHxWWXSjMFtMspeThQkuPOfPhQ7tRzmhk+RFZl2pihXfVgHoGseUtBGV0ZK8gCZr+39O0idPp36bjYOZpo4BZ01gcfkx+BPh2UaVyRWQ5YM4jet+qsGTcsTiBkSG0kanZd6x1Ndy9aP5wm3tibnOPrNie66U7swUUQmIzluY/gMgY9WFlYXMv/ZlRr/lpZ0hIt+pPxdlPR0hukQKHEIXA1+Kp9qd/x/KhcGvvkcRy4vArSaddmefSZDpya5s5tX7DJ+N1en
X-Exchange-RoutingPolicyChecked:
	KsCtlvslKkdN37o2/MoX8wImcDeePC1T8hkmolrE2xfO84710IxmFunTjqfZNpKxr+gq+e5dApPFzhOpq5nHeKdcz4BxFitQtZF4573qv7+6uHZ/NDk7l2iEUEuA3jNrjGQ5FlhjxhlbCAfUTlljWCBrNGnv9h5x53bOSzAI0GmCpLStYzHxQb+hU6A5yfY8W/tw5XW8ptRJT1rYIUqNEpVatjGVF1Lfr6qYjOHm0MQhkwpLp+vdtJItV7gyfktblM2w8pW7O6+8n/pnz/XNsuSdWHkWQ6JA1mJL96Yg+BZBinhIHdOLmSwol70RPSsqeUILA0JwN5yy+BQjKv2o4w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:52:16.9733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e679ee-00d8-412e-1ad8-08def2d73c01
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6459
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a7307d6 cx=c_pps
 a=ZUDVJbHKkZYoAWA4fONUdg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=mGg3SG0tE1E6V9n-nRsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: QKzEaV2dCEwcj9m2z7BIfoj-XHsG7aV8
X-Proofpoint-ORIG-GUID: QKzEaV2dCEwcj9m2z7BIfoj-XHsG7aV8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3OCBTYWx0ZWRfX+vBfAg1EMImR
 7mJOMe/4U/Sqw0DuwaYhMvk7sdBXCH1H29kpiAEijhTF89vOLdKK0zugScp2j4F9BJSvRa5I/n7
 U4GnzHBrr6Nk+0fCJ2DiDp7gj1G7jxzVfrAy7DtwqZAGZdSiAZmT3oTX+H06GUa+jn0Qv8XHbsN
 4ESsUNCBRELM5HvUve7E+LznfSMpOdyjfqkwcx22ahMN68ya/sAvqtxUkIysA0oJW6NZjXoRAQV
 2vxPBBdAH+Xs/JGL3O4oQJnlhxkZsZXjVM6RYC8wyYrNGaBwmJ92yo0gliAENrwMUBnn/HFVcED
 Pa0S5JLyENQqgZGM/Ao9dbiJcb07i3mqJ0lSTkQoIdXAC9GJ9rHnMmveqhRsPqTDFjKU371EQ9s
 dyU/GFB2XrPXZ7NKGcjiFBzd5mOTetDIoe8vneb4rPQK8Zj5ibFkp6GYhaagl7F0vGFLgvvd06i
 kFelCXJYiFaI2/a0PQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3OCBTYWx0ZWRfXxlg3064PVW1/
 URkGqzr0lMH5Rl/SEPt4sVeIrJk+f9cqZs+cokk/LuoHrYBkDBY2tCLA5q6/zT0oiiPrGr4wK3j
 8HqOx822OVifsxqNKGujid4kytc/s5I=
X-Proofpoint-Spam-Reason: safe

On Wed, Aug 05, 2026 at 10:38:24AM +0100, Richard Fitzgerald wrote:
> On 05/08/2026 10:25 am, Charles Keepax wrote:
> > On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
> > > On 05/08/2026 12:00, Richard Fitzgerald wrote:
> > > > > > Found by an audit of all reg_defaults tables under sound/, the SoundWire
> > > > > > codec drivers are fixed by a separate series.
> > > > > 
> > > > > Wow. Would it make sense to have a regmap helper to double-check the
> > > > > addresses are indeed in-order in those reg_default tables?
> > > > > I am not sure how this requirement can be enforced by just inspection, a
> > > > > warning would help detect this sort of issues on more platforms.
> > > > > 
> > > > It does seem probable that anything that relies on people just
> > > > remembering to keep a large table sorted is prone to breaking,
> > > > especially if the addresses are provided by named constant instead of
> > > > a list of hardcoded numbers.
> > > > 
> > > > Should regmap check the table when the regmap is first created?
> > > > As it has to search the table during normal use anyway, one extra walk
> > > > when the regmap is created probably isn't a serious overhead.
> > > 
> > > But it will be done for _all_ devices which uses regmap on boot, small
> > > things do add up, see my reply to Pierre-Louis.
> > 
> > Indeed, if we were to add some sort of auto-checker it should
> > be guarded behind something like perhaps a Kconfig option or the
> > DEBUG define.
> > 
> > Thanks,
> > Charles
> 
> regcache_init() already walks the defaults table checking the stride
> 
> 	for (i = 0; i < config->num_reg_defaults; i++)
> 		if (config->reg_defaults[i].reg % map->reg_stride)
> 			return -EINVAL;
> 
> so checking that each entry is larger than previous is trivial extra
> overhead. I think most regmaps are cached.

Hmm... in that case perhaps we should. Also if the regmap isn't
cached then the defaults don't really serve any purpose so should
cover all the cases that matter I think.

Thanks,
Charles
