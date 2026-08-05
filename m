Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3E3DF00B;
	Wed,  5 Aug 2026 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920355; cv=fail; b=T1g5WnrYOZvW3ZUpNbXwKsAAS5c4MlVWr3f982V6g2GMtFV+eYj49lG6JmHE+xdUNFp0pG9aCwQDTcLUCA4YVlDvI13tbl9fGdVxTV9Eaf201UFipAHWXYgzo17WGtDkAGbfDpGMBxuqDQU3UMn+0Xuln4D8RNDpt7n/bAa1pJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920355; c=relaxed/simple;
	bh=/KsFIWtAZLSbe5JgWUyaNgW/32E2pVw3eSXh5l+k19k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFqN6er8I073HCFHmAmnpjhGcSSUFimVF8lBwbqa7aANgyMaqJQMZ6UqRXmjlk+ZLjNcerLS60lM4rr9eaLkK8nksO5jnvPQW5XVtTePUILfbbvzm0fes9kvU6Bw0XqHrPqsZzZ6gRcZI8ePr57NBTAslxG+HKTdgcwsZcjyQYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ZMIZh4Ll; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=wSTA8h49; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ZMIZh4Ll";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="wSTA8h49"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6754V8X43379452;
	Wed, 5 Aug 2026 03:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=9+VtS+NHavgC57TVb4
	q2bgxlyqtg8u4hWiVsfQd1rME=; b=ZMIZh4LlZbU6H5xulf9glUSNpgDW18vvn7
	KKiAhyj4CXBMLPc7vauddAAf1SZSUwYixNh1SYIMegkESt2yOiZf8v5TGNfQ3WVZ
	Nw9BPhCDDwfhbyWsDr3HuQRCZG1KTr1BXudRLKdZGMWVzll1W552cvRYOFpHPvqs
	xiyNu1uvSoid7Ecwcq7+aBe40Il+7borZaFBJeuQQISTBHd6JTaSDlfpfK2AbRxz
	vO9m7fmp+ML5I3/lLAl6bjT+y4CgPZW6iocNQWThtgjehBLgQArANiC7rvUBzKKW
	m4KGD8SEEx/pkasz0fhCi47XJBz6AcE2YVc5mGF9lC6g7EDiEvJw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020133.outbound.protection.outlook.com [52.101.56.133])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fse6vnd31-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 03:59:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N82SZR8oMlEc41P7E4Gl+WmrDGRDswT78EEMN3hVTH/gyOEHu3qChQgasUx6MJW85HKmljrEcBajkN5Q/i6NKiungWIeQeVVIzFYqTD3o7Izp0Is88LQMKWFP+x/lYH2shALk9ZfM+0k+OtGVS5Fa4cpnVYRtMaN5xE2oiaFJjlNbSki1nezya/Jx454nxrWc2egipdBS/hOeRUIPNdv1854Fah/GKpcTzEF97GUJ3YLC/u79kItSEy2DmzPYXZSpEnJTrTRBenNW/l7yQ3W3rLqRfWE+HOKZnJ99F6RfvAghQIXLjwNMYxeUvC+flne986gpaU+uKuI2xS3xmVI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+VtS+NHavgC57TVb4q2bgxlyqtg8u4hWiVsfQd1rME=;
 b=rny5tQSjzwfpDeVpioVKgrbw4Y4JraXT6HIDg6DbvXD6a/oOmn39Xpnbdmxgv+bVm8ibysVaEsEw6Lafci0atpJaqVjh9wOOAyOVyaCQHoIzLLouo7bq7/lJ8uMhhPD5gJX7lhcYLXNlPNjI0/gXrkd4LJDx4MvIbUFVGm31onXGHpX/hmTEjtFP+a61yQj01hbEH2rvjZ7qTJxVGBUOrQjPFDlJuwLI4gi5SAei8F9hZG/cPsmdzotQVI/fz7bT29XwyslykhA8oEAq0PWpyiHmqrampWIAn79lxaaI0Kns1yuuqEDXRz4jcw3ZufLGquQJrSutOpfN0WeFusSAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+VtS+NHavgC57TVb4q2bgxlyqtg8u4hWiVsfQd1rME=;
 b=wSTA8h49lNnyNhnnkzPmP3+4Dp666U1mpjIVxlQFPYMQySSscBSTN6DWm7qslweNAWMEAao1dmyuFDIBRV+oEWYUR5kASJwJ3dOK+7uL3JNpPDdXMoXLmJyEhmwBrbu86CVHowt6laBpbx5cUCFkIQRIjSbso3a8YqmPYWayCPE=
Received: from BN1PR13CA0012.namprd13.prod.outlook.com (2603:10b6:408:e2::17)
 by CH0PR19MB7933.namprd19.prod.outlook.com (2603:10b6:610:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 08:59:03 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::8a) by BN1PR13CA0012.outlook.office365.com
 (2603:10b6:408:e2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 08:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 08:59:03 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 74715406544;
	Wed,  5 Aug 2026 08:59:02 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 57FBB82025A;
	Wed,  5 Aug 2026 08:59:02 +0000 (UTC)
Date: Wed, 5 Aug 2026 09:59:01 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
Message-ID: <anL7VWnBUBeHvg5d@opensource.cirrus.com>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH0PR19MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a01e06-7cea-49bb-41b2-08def2cfcc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|61400799027|82310400026|10067099003|56012099006|11063799006|16102099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RnCPp8MWtftBTBae718gqlbCHqut+f8p3xYVJBH5K3lirQDrVpgT+qYNne1wPEAZePL5ETq/7XtCK0yfTOs8gJYJzs7QisEZbUIYPil3Ai6ADwxbH5NkUBUt3iJxAsEivjdHSaBWK9u42nQzZVn6QXHb+vBWiR1Gjqt6+bz1jKuB+7T2pT1IvfV3AuLZ/AWg+FN3sPryGoag/SccoM2nN328eaJ2SoGmbHjBG2uBtdVQ6EHzsHbOrP5vuNGncIHKUQau2JTIL7yueOUJ/zVXms0yQ3qtKKlrXxKFmECvH6wzcsoXfebxnn1SdI6hscr9a0z422K3PpvzO8xGtP9NiGnVMcjbuZtxL58Yw3ergJiCNcqKWMKW4f1lTQGs73Aa79sw1Q+LJeYB7zj2ClV/Qj/BhyBAErIa3aPNoVRtpdrYUU1TwDpgJR6OnzqteQV6P26A8oLsae5VC7MwCk0FvRioki0Mz5UPDR3XpjqdIPOYZbKSV7zkQBVcBGXxQD7asadotWO0E4c92YZZu28pgTOtk/3jZc3Ze9lLG3+zZnL9mvJAa8Qi+IQ55uHdgUkXPLRY/aVW+IzgdOpKCW3Pt34wtgjL9zOjod/nbyhRVp0F68WXrZQmrJN/RmCh7qSgQJG0Ykc/Z62GvshhhHamUVOHNph5vGg+Kktflhg11VsybbaC/Y3aSNbbESYGS8lX
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(61400799027)(82310400026)(10067099003)(56012099006)(11063799006)(16102099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PxcEDPmPig20mTE4SxH9CTNFVr4JZ7mzb3B1KzP5VHRh+Ii3LTppMpdJGmatG4yt8+uZZ+7+7Ji0hzelT7Jrr3WF5JwKbufd1Lduqctsz7TWYltdjuqy2XfdVbe5nUEjITunFDdvEK60ddh+L7kK5H7vxqn+OoGvA4DFLkhlqnBonffJZLD4lMJct+Tgb/aN/pdm6PVW5gykMgmSkZWVXJDmd9FN+woIvt/K1PENAw8NlqhxuJ+fqZsID1Pwls0cp4oxhTYVjIp0QPXlzPUlCUm6OmIiK8qvOp3CLTH6wJqLNYrPCeFAuisSCUzICQnWbQ3zHaDGZrtHEIUjcAAIfqejrcFe8cjwzq1EH/OGYHsV85+xrKeaapg7TzMYuTow2gnUSC4AWbFvV49XtPrLcxaISQqkxD63HB4a1HeRXJ8v+2Au034bvgK9rpk384FH
X-Exchange-RoutingPolicyChecked:
	jTdYLkCGjIp6j8Er4ZAbs+HNP/tjL7mSw6feRNKyVCtaq8wPW3UNuW4j7gJHhkQlAIAK9rlYhbY83Sb2z6gUZdX40ui3cD6W1r2GrfS8QSIsyy8wk+YyCDN1Kky+5A07ms/rV60+XOzobpmcU/jKgXnYkKvD43ZIZSx7ldFiGNoOJA/Pi20CbYRY0AZ8q8vjWFZbGb7vS7uDkrtfhQ23A3vQMET4WW9vUiT4hU/s1gSbx7Stg3au3adWC+LGHT3l1yfFK+eSWbwkjkEiF3DtaA5vHDIzMEj3/2dI5XcF8RG2gh8tz2Fd5VVcOzcVllDve+PaalTtWuXst908XX1F4g==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:59:03.2723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a01e06-7cea-49bb-41b2-08def2cfcc6a
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7933
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3MCBTYWx0ZWRfX7i3UBFfml2Dq
 tTz5uwyDxp11Atu+SFjlp/ZljmObMvb7I10MJDO5UkzhcA5IX6wyGvGsbAT7Ka1oSZNLqJw/ccT
 CupRVlCvAQK5oKidGEOJgsMG4B0OwkU=
X-Proofpoint-GUID: 7-auZgFD-BfGBLu6IhEEorT_-7X9uSn8
X-Proofpoint-ORIG-GUID: 7-auZgFD-BfGBLu6IhEEorT_-7X9uSn8
X-Authority-Analysis: v=2.4 cv=N+MZ0W9B c=1 sm=1 tr=0 ts=6a72fb5d cx=c_pps
 a=q7ul7JX4f8a5wKXmg0eXeg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=w1d2syhTAAAA:8 a=dk5BPZE5SugFf6V4HIAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3MCBTYWx0ZWRfX8PzJpfSNjwi3
 rSN+e9pWJrbyGeFw2aFeIwhp6MEo5bxAaj4RLDjr2ASA8gg9ouE3mmn593l6KdNvoM2ofSapW7K
 qEcsqeUKoERwwKoFUGZrf+BIpp6RZK0VHUlL7UCU7fDpMrYxreAnW2my5KECSJ8nXf6Ubj3gfQ6
 Myn3qoj9wJjt694GhiFd3NPYGA4Quq67ZigsWVv0pbyUGG68NCzvwcVVOCLpqdyZa1YnsjWe6+d
 XVZrtKJb22+pomZor9SdwR1Nd6twjPqKrqNHmnR2Cc7OFDTKAOK8ha/+r5yLaucFwTQ0aVqC6Cm
 Bje4DEQA0khaI2T+GzANRsJeegUVq/0asq3cR/kdZhex4q4bnMv6UsU9fuxnMwPBkhdWXH+5X9n
 3Hy6KO3m8qiY5DoE3HSy+rDTpZeeh/GGVNS6KkXVSE4CZoujIljGPyTkTBgNqFhTBRnBo4FQgAE
 2c3WSJR3d3C6UxWQMvw==
X-Proofpoint-Spam-Reason: safe

On Wed, Aug 05, 2026 at 11:24:10AM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> reg_defaults must be sorted by ascending register address as
> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> These three tables have entries which are out of order, so the binary search
> does not find part of them.  For those registers regcache_reg_needs_sync()
> cannot compare the cached value against the default and reports that a sync
> is needed, so they are written to the device on every regcache_sync() even
> when they were never touched.
> 
> The patches only reorder the existing entries, the text of every entry is
> kept verbatim and no default value is changed.  Each table was verified by
> evaluating the register addresses and replaying lib/bsearch.c on them.
> 
> Entries not reachable by the binary search, per table:
> 
>   cs35l41_reg           2 (of 47)
>   cs35l45_defaults     36 (of 73)
>   cs4265_reg_defaults   3 (of 16)
> 
> For cs35l45 this is nearly half of the table: the DSP1_RX*_RATE and
> DSP1_TX*_RATE registers sit in the middle of it while their addresses are
> far above everything else, which cuts the search off from the whole
> 0x4c40 - 0xf010 range.
> 
> Found by an audit of all reg_defaults tables under sound/, the SoundWire
> codec drivers are fixed by a separate series.
> 
> Regards,
> Peter
> 
> Peter Ujfalusi (3):
>   ASoC: cs35l41: sort the register default table
>   ASoC: cs35l45: sort the register default table
>   ASoC: cs4265: sort the register default table
> 
>  sound/soc/codecs/cs35l41-lib.c    |  2 +-
>  sound/soc/codecs/cs35l45-tables.c | 32 +++++++++++++++----------------
>  sound/soc/codecs/cs4265.c         |  4 ++--
>  3 files changed, 19 insertions(+), 19 deletions(-)

Good spot.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
