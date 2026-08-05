Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA1279DC3;
	Wed,  5 Aug 2026 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924654; cv=fail; b=LeSHkEu7nTsPfclz5EbObSgzpQlhLIkOJ7G5kzGDPjoiGGrPvO4oO+dukf3JjQ4fhHt2N5a9/2jEdefSh2z4zon2Wy4WmiwEmY90Z3pQOxrJAgfPT27UkzfxZUJoKrilTRwoKM3eMfSxY7O2akKg8nOIumwiv645Ya90pjnffeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924654; c=relaxed/simple;
	bh=DA2smCffOh4qDT+v2kh/uDVul1lD44oZFNM1j2mbazI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB26NeVJ6zk2eSFkh3Fp1mxdc7gtQUNVdG2ROnCn3vbluEbS71AGq49kumIrJwzC7fIwFRWasa0NFQ5bT28QqKLJAjbyyvkl7aJ6Wuq8q81xQtc0enZsTvno1ouo40DJnAEKKP0+uiZb5SEGT0g7LJ3fhJzzNhVwnGK9A1QclgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ERnVOm+a; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=mlNXz+zY reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ERnVOm+a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="mlNXz+zY"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6754V8bu3379452;
	Wed, 5 Aug 2026 05:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=M4PfbIz+b+mDqCGSC3fdKlxiUPFxJs/bRKfXF2KEEtc=; b=
	ERnVOm+aZr7OLaHbI9O80kkYRCpdOQyylFJdKJRl9s3Coa9CyRNit8MLJIj1orzs
	wMwQrvWF85zf3Mh7xFxA3lFkeNvVbJEbEP1gee1WsNuzKE7SFg9Tr/yw3r4YMnQi
	g9ljjla3/NI5jK478MebgKbV9w/yM9YxKR67+qXdSSTyU/8IRCqU0yO66sGM1ke6
	QFbUu+yLSWKNZPCh4QG/8MvKgeNmCvxGkB18BHvg/OTpwlujsooMchw3eaH74Nr2
	wUW6OWSsnKcbELzfwdzBmJ6m2Mx+GneZ3ybo3ajcWV1mVPwubVb+qM6XbNIDLPcQ
	d26zeAbc4sAsI6/uxPqZJw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023108.outbound.protection.outlook.com [40.93.196.108])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fse6vnfqk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:10:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQTJ+7YIvsEDXpn0xsgNwWFTDkY+B+YY2aWvV+kl23XrnRw7zU9cUovO2miLLcY5faCKRPLPfsYwJ+DiXGpRgJ18/SdCuXkBZZoV4kvn9J6V1cS4x2HUFMFCGfcinxZi69+slmkLIeLsEZc4fbl4yl3AvVz+XiYa/wIi60kgcxNpf58BkuOLi3z38Tj88IEKBm7cXvN8xy22+x4v9/SBlVO4PiKOmSC4iXhSxM+isXS/WRzqPK5MniJkAoSJHebJfhZZ9/10C4AR2JRBt0fzTk1p1am/EV51hS6PCCsCORw5rThVYLABYm0tNg6amIEl08/9PGXepW8t0uc6qELqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiG+gr81rXfO6d6a3ZI+GGZrijI6/gM8AcGIZ/yoAo4=;
 b=x0pCwu++q1UBUgQ5C20FWOlMfcJyHuplUnbjn7khWRKPGOeb5mAwJNTL7AkTVspvZSDfNj8bktJrww0V6f058vntDLi8XtClJGsfWY9KT7qk80uUT/jDhLVNbKR8cnbSAffblQ5ooY+7enjLxe5vURNjL9DMrG0bxG8cCfejeujHC1mIAmO92rsvc9BZbqfzcJgwbDU86v3VlkPCfVF4LAYJw5GwxLWoi6Q9BnrWfAk9gyjWG4Mav0JZ/y1wXkO9h6sJJIiw8kh0+DFrpEwK8lQE28n8Vq7GL//NPOSZXnCvyR9XKWgHUNfgKsKR/yN1WhPOftqGYiK+fxwalt2ojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiG+gr81rXfO6d6a3ZI+GGZrijI6/gM8AcGIZ/yoAo4=;
 b=mlNXz+zYyg/blgtTZMtU3cnObmTWKjVnBvk6b7u+tlZabTNDQP+ylvW8ReBWJ5e72v1es74qwDpYLS1RjX4PU62Fyv6QHsPDU4AQ7HlHoOCT1+LoGIHi2vJfGo7c7/UcfJFsaxkSDqcQ72zIY9V2Jy2XarB22KGWJW8cWXL+Gmo=
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by EAYPR19MB623050.namprd19.prod.outlook.com (2603:10b6:303:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 10:10:43 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3f) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 10:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 10:10:43 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D103C406544;
	Wed,  5 Aug 2026 10:10:41 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id B58DB82025A;
	Wed,  5 Aug 2026 10:10:41 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:10:40 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
Message-ID: <anMMIH29hLtOH3kX@opensource.cirrus.com>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
 <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
 <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|EAYPR19MB623050:EE_
X-MS-Office365-Filtering-Correlation-Id: ab341c90-7650-4cf3-cd06-08def2d9cf6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|61400799027|16102099003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	wpFuvdewou3UDI+cs+1WQIEoRO97zO+2Cda+9LHVVjNdCj0gis+ARfmB3kWCwKpaS2P5wD7v2LD/A1cqkv8UV/hTPp8U+6Bt6Vpn784GqxYXeh7fAg3py0nOOii6G5wg8YsLj5e33xsZPK4NHigUMjFyucwlavBhHUk1+3GmB7yNQN4nr3CYA67ieXNhq83F3rY/IgeMywHt+IPPEgE73SdwE3Pa6bzWSddT5pMdWXGuVy6jt6sj0NcGXOmtzoKP9dhhte/FJC7vAN5JTksjVDzohOgxnA13ypmYh79bBKXCKtySGTiORZ2cuGKsV3wvzOqiEc3y3j9BwKUuELWckbZJbvUsuAyAbmaUXMwq/I1Ck9bF5SWPXJwbYanCyUTNP0WwnmJit8n/X9YHcXHfD9uRUnFURw7RjUqYlos0gsAtccaY5vzLeNaDwqbFz3okNfInsha7BNEV1Opd1T6SeDI/qJ5otYh1RfO6KTBM4UGyhpnKFtWN+MyCDzUSquClMYyaFRz80FdiUi4X+WmGwlxIjuu8RW/6wWteEwBeNDwA40NLKGxV44GMoxp6MQpNNulwhx3xMc5YY6yY1a6ui4DsHiliscNGS0bcwPxnjqGvBZgUpd2Ip3ql39dVmGuX8clgr8GXcek4eQrpF7wnghf8qjFpbMaJNt+cbHJV8TDNptY7YyriVWm3nYLO1ocEyTpoSSoTsm76bVbGM6LYQQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(61400799027)(16102099003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	78wQK+j6cuOWltbOAEAmdSzXM3gsfFRDCTNSSVRt1QYHvgZTZiT9chGT6TpZ37hnHvLjlbu5n2mqtNmYOdRiuFAt8BZXZYOvWlg7npimqqGaiN3kUl2teBgKdJXrWQczbXADMNtH+ZhSj5ZQ0/6sCc0gzb6V3Xwp2hC4/O0pKqqX6fWPZ9CXKylhkgFMay2koSVYKzaBj6j5bNBGrvpd2cRsxs4qdE5l3PJSkPLC+3kcFcI9Mmp/BoqsroFwDRK3Kd8PgYrxF+0ZeL6hzSHhda5ctthRU3X08rJ6ZKyxUl4O8eEpLiF+RJsnAtdgSXyiWOxPGhDw+z3JaHGs6BWKgAX80qsrw7OEKdcQ+9hQvjDFCYCFp2rKyeQdb1nOf/rlqMqeuY9d3VXQoDd8IrThQ/1RMzHVB7gaOn3dgdrdGoyDiYILmkv/xTLB+4XLkHVG
X-Exchange-RoutingPolicyChecked:
	Vr/29y+xgIyxBkm1DXZn0W96jbbM8LOWo1tLzp4Iq8PFSMzgil8mWNkA0RLcvrOaNOOMOGGKE+tpQkqr3zTxMZT02dshHrqSKwIbS52ByferE4hzihYuomR697MDkp7uZJH58UfbbYhmip5l1q3LgeVRU7G0K1Loc0yfKxkPO5JgsVk9IVzontscI2QkyQJDhBSvlPWFDzr1oo9rITticouwAOuhJl5YS4/j8IZyaNqbSisg8Gw+0JDRi5WRFrhhtYGeD88eJhNUJQtCH/atzB7EiRqPvpH7ex+kUmjzrPixJ4Q3TYpCraekl0m5tuS7274XmmAq26xnu4bZw/LO+A==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:10:43.1880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab341c90-7650-4cf3-cd06-08def2d9cf6d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR19MB623050
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4MCBTYWx0ZWRfX5mF6U26flfb7
 WgYG5E8xf3NMKVVXAqiGyFfINrUFyZUkWAJOed/vYRvSPD8g3CWk5hL/yv+U6oqmU2Fdzed7ofU
 +xD9WVr4LuNttYOQaeJdyW7AxnXj+KQ=
X-Proofpoint-GUID: I7egILH19nI6i5i5fQvSXBHVe6HEi7f9
X-Proofpoint-ORIG-GUID: I7egILH19nI6i5i5fQvSXBHVe6HEi7f9
X-Authority-Analysis: v=2.4 cv=N+MZ0W9B c=1 sm=1 tr=0 ts=6a730c27 cx=c_pps
 a=5+C5dWQ2lNXIGJ5Pv9T82A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=JcWHgKfPyNlQ4kCdQnYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4MCBTYWx0ZWRfX7PsIjnQ/G0fu
 VWiO27HggU4CnHy6bxAsc1Tlt12Cl7VwSRJlJRoaqplVIvp3M973OZ4V208e6EmnqKpNP9Pfggv
 rS03g3No/S2X0L8T2i5BWIp7XuYvwbN+48QWwy5AYHjD487GCsd6PMjhJzHhudSvhViwhXW64c0
 pv82DKxBxCBwo686irPQPuMqPQlmllu1qUEQqyimXLdqJtUVqYxY/iMB6AHvWyF1CHCArJK2bj8
 2PB2LSffogUuoLfvE8vQKuPjtWDDdZwvpcQe/U0sOwMcT2L2qkngiAa3LUbfUx3tIqW34ODq7eS
 GCVebPxESbFNg2wthOHoPGZ8dbR+EC2VGAEzd4yOBx2VhZNCf2A16cJvnj2KdDVbznH3ZgOPBkw
 xItBzSI7AKQTdj5dy0gUtH9Kzqsc6TTmlNyZbkK+P2yF1h6JdEtRoMXpvTKf6iqSc9RvUugPRVB
 H2dJ3kgA/h7UBO4ujiw==
X-Proofpoint-Spam-Reason: safe

On Wed, Aug 05, 2026 at 12:59:30PM +0300, Péter Ujfalusi wrote:
> On 05/08/2026 12:56, Richard Fitzgerald wrote:
> > On 05/08/2026 10:52 am, Péter Ujfalusi wrote:
> >> On 05/08/2026 12:38, Richard Fitzgerald wrote:
> >>> On 05/08/2026 10:25 am, Charles Keepax wrote:
> >>>> On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
> >>>>> On 05/08/2026 12:00, Richard Fitzgerald wrote:
> >> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/
> >> regcache.c
> >> index aa8f2efed779..ce4b11d8a758 100644
> >> --- a/drivers/base/regmap/regcache.c
> >> +++ b/drivers/base/regmap/regcache.c
> >> @@ -123,6 +123,7 @@ static void regcache_hw_exit(struct regmap *map)
> >>     int regcache_init(struct regmap *map, const struct regmap_config
> >> *config)
> >>   {
> >> +    bool sort_defaults = false;
> >>       int count = 0;
> >>       int ret;
> >>       int i;
> >> @@ -149,10 +150,15 @@ int regcache_init(struct regmap *map, const
> >> struct regmap_config *config)
> >>           return -EINVAL;
> >>       }
> >>   -    for (i = 0; i < config->num_reg_defaults; i++)
> >> +    for (i = 0; i < config->num_reg_defaults; i++) {
> >>           if (config->reg_defaults[i].reg % map->reg_stride)
> >>               return -EINVAL;
> >>   +        if (i && config->reg_defaults[i - 1].reg >
> 
> > I don't think we need to sort them. Just fail, so that an unsorted table
> > must be fixed.
> 
> That would be a big regression all around the place, ordering w/ the
> debug message if developer is interested is much better.

I think I would come down between the two of you. I definitely
agree with Richard on don't sort them, just encourages drivers to
be wrong. But I also agree with you, don't hard fail. I would
vote for just print an error message and carry on. That way no
regressions, but also a nice big warning message to let people
know what is wrong when they see problems.

Thanks,
Charles
