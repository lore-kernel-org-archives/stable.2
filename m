Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67F430CEB;
	Wed,  5 Aug 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929747; cv=fail; b=tXNbCbtWq+M1qVQudfhF2Hys2qEABgMHiEkTs1UQhfeYsSyLKDDADsVAaEUWnttAIajKwMm1ZtKfue8yGYfhYi5jnjqvMBMmlHh9oqwooQmE3EuG9zfZ4bHwxygz3iBkhGCjEAdmmO5nLbPlUdl8kWVN+2ngTuh4AdoirZ8851k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929747; c=relaxed/simple;
	bh=ilB1CNnqDsKvJWfOBBUdczBHYfZmmklMe1TXYgTR78w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGq9s8dU3Lq4tm2dfznFWFZJUQtqTOu0u9dwVy3K3HT1N9VKWj1ndSMtBGyeFM07+tuaY5Trz20zdSxZZmAJLwjkHP0LM2W7WZtfNuvz2yl5jx/YZTGnvdIEQceEmFVs24KpAH323J+jcyAMGesMArv6afGAvgFG14OBySqxrhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=bvSdfOYZ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=slqnmeGc; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="bvSdfOYZ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="slqnmeGc"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674NPTxV2014368;
	Wed, 5 Aug 2026 06:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=PQoFqsIKXp1z+5dVFSNCGfZ0FzL1ywduS2mmREN72XQ=; b=
	bvSdfOYZnm2i52Q+2JcENqU46WWYaJCZ5ZwLK6mVfwYUlG0rpjBQmIy3wP9kG9Np
	Tb8q0tJ9Lefy+PfhXcYJ/sTuRUY3T0tBN79XynaQXB5sj7daMTrTEfbz+fxFpSH/
	aAagPk+wRySSIimdEcB6juOK2VVUHOOSCzrV1cPo/1qZ90X4tsvYd2r4+2xVbV35
	MKYTpQ7Hdrh66LMmLD1HbqOyO3WS1YVPB2XjapzHnYT5uFrSPK6P06v5T1QyV53C
	DaOzYV2mxGoL6umHhoflpWGOcOq5VGnKE5BsfS9STiUIreDit7SkXYrabOPNeqif
	HyZ34y7HnPcegtETXboBuA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022088.outbound.protection.outlook.com [52.101.43.88])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5m85-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:35:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpuNw0gPDSKilmQFS0566KudsKmm/tyfRXl75sl9W77qba9FacraOy4PPBP2HrVvFxu82OLAxmYeGEAZEaxNX4sDXyZRWYys4qDH1dPiR5/SBav7q/JwV5DNYRJ2BvPO7d1FhfCqzypNQs5Mdde1niYS/T87HN+QmbPL5qjuLNOgWPY60ExqSypUQgauwZ3g6ycVD4U5EXHCAi8t0i5HtSjYQYZDOJVsOx7dyJSWfo485Y9nqsRUuuSL84a5dI6dMk7zKBhoUYR0YcYIJNk6E9mPXuspyYu66CW0pswbnao8QujNBdm2PS73iHeUMH94Wd3DqkGOfQ5bcJQbVNVk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQoFqsIKXp1z+5dVFSNCGfZ0FzL1ywduS2mmREN72XQ=;
 b=Ft4Q2+NrEhhthJgrR/tA54vD1UK/rEYYIpLxrJQcWwrIWMSwSaVeje7+r/B0VG3pThzmr5jY0jh9SeGTtbSGKUyNWQzRcFPfVOkZA+NhEitO1dQZsR5RByWiEKhBMI5xRp97HZPh2wAAA4sWu29pnlPfcD+N2vI7lnrTbg9fMuDMzhfaAoEAFCG5UYHnfcBU8WrkmcGjv92ahxYdLhfz/4HKuK1A1Dmad+HN7JUzaExS8NGV/gq9YKICrP3E8+qBGLx0NV6HhSsqA5E/1uqPgxSDtAIWqCECdL5jMeAS5L3L9Cvpg1bNsTIVBqXFD5/AaB+sA3YldrNwz1m/4t4FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQoFqsIKXp1z+5dVFSNCGfZ0FzL1ywduS2mmREN72XQ=;
 b=slqnmeGcLDTNl8SzFGx9Bm6px8WjzhswV1KMtZytVoeV1k1NtOKuFa5m6iMjNj7NnRecxTJlStkuTIR86fTKX0h2/5MdHN3fL2BrKBkzh39TBdZ/uu9fd9uBbDYbs8xOy8VkUlgpuG4iss2MjrBIFv6gMJu19eYInE/qaEzE0NE=
Received: from BY3PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:217::24)
 by LVWPR19MB997421.namprd19.prod.outlook.com (2603:10b6:408:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 11:35:37 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::5) by BY3PR04CA0019.outlook.office365.com
 (2603:10b6:a03:217::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 11:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 11:35:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id A297B406544;
	Wed,  5 Aug 2026 11:35:34 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 8A9DC82025A;
	Wed,  5 Aug 2026 11:35:34 +0000 (UTC)
Message-ID: <c556f164-448e-443a-816f-6ebe16c28bba@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 12:35:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: cs35l45: sort the register default table
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <20260805082413.26174-3-peter.ujfalusi@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20260805082413.26174-3-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|LVWPR19MB997421:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d03059-2604-4e86-b14b-08def2e5ab3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|61400799027|82310400026|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	W9wAMu6QcIhGXnDurWR96SSgyj1gfGBnNuTeWcGN0jLBEmkIG7mpO41F0vTT+LYVZirf7Qsa3UA9emTNYG0Dj8CH2BmdUGBzMCXJcCmLDx16ni+T9nYOQvZj74tkfXniyhjuxOkkXy7saxpFOnh1PgDL8OM3yARYGmeKu9Chi58FSBj8QiGfpBbBB2gSBe7p9Fk+Di8Eb21v50jYlUZbV4PN+9GMRXxSSXqCrQw5mhSD2yCVzGkSZylgvxjMg4a9CUKUyIYDFY7gqQFfb6yLAeuBgk23eeivfklIo1kj7OLS9N7shQwUe9eK02NH1kB8vsAoaBDmM2ZI0wN+ITBfnGAiM9Xa7IhRBX9JE0sUERTyOmpi9BPjybw5F70MJbKnMOG9ok78NVoDhRzEwtVheFkWepRF25yv9vg1EyCDyro41/2gjfYf7vyVGgqD6uIuEv5M7CUmMAtWxUcxScxxhsjLMU5Nhyyx8ewuD5OMnQyXhxGVU/SUn7Ry7ron5i/eXa47C1aZ1Fyg/5lHkWxhW4WxJCq2FE8F96EU4SVFnvtVusDKP0mG71UUJrH/CbhaTAl2tyGBrk5yDViq5cmGF1AU57piVj4Msa5m3rT5kXfwI0d7BFjvs4C8vx3mmllKc6/B7PlXoVIAOnLyqAT1B3/GLD5ZIxOGwe15oDWWYTTfivjf2sDEStHOGiFAEl9r
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(61400799027)(82310400026)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NNJTsQ/yf8/lrmEVgSWrRedaDEdU2mQnljh9SErfY3atqhT32AvEAZBOQVm/bHsxLO3JqbrexLzxO205TaNwrWDbKjTHYymzFN4ILyYwCHsEcgRjtPz/FR+/oCb/YVDXOH+cPsVkHP5zt8MOE84VsuCBCWtQQ9G72G0uzHqBVK0OGs1h8fxVIQ3PLvgeu5SXWQaSDLLvVKyOv4uxOhM1a8xUVa9YxvQN1RbGJakj0D3zkpy7sZCIgplnpPvcvdkPeJ3BR0sSMEjkbDbd7f1K1b7EAKxzUyW4fQ+ub+i/UPaNmirLt5Joxc4xVu0rAcfWw4VhbJYoj4tGbVIdXIvxIMyLvyWK6JF4v1Zc1vx6g3xswYowr+RxEgGbIAn3W6138m+OKoLh7eICtnISuqdM5Tv1h5kl7dxkBmf8iUTN6lnS+z0K0hRTUd6NnSodRA43
X-Exchange-RoutingPolicyChecked:
	N445h6/zaPdsJVkM4vXt9OcRJxqTcS9yBujtpYvcz6FiGcPBVKPC7KV6kJK/SvO98SPoFVhD6uGma75mm/AxYYTKNfoyrlxXzH8ocbj0jtPwkcVqtPVogpnhSFJGmbJx4Qns/otCZ3nPuZ57r9WICkqkU1R2ECk2+sbZZNhO9UqZ9BhgC/PFZg1o2fobt48Qz7WKaFV6LJXGMYrXrviY5EyQtZVonapbiYCl7s0oFsKrSRtHPpz0wCgSxVby77Wst2jLCzdlyfOh+sgDondp4NMVbyEx3qmqupZgBJ0zssiW/61s2EctYvKbordsh+A67G1IzzvWf1f9ca/Lg+FgsA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:35:36.4409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d03059-2604-4e86-b14b-08def2e5ab3e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR19MB997421
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a73200d cx=c_pps
 a=R/EmBLgrFYJi0SEZwJtDOg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=cKAiRvT5zUihyPChg0UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FfANxO6EVl9nIRQfzkUMg7iAeE35JwOJ
X-Proofpoint-ORIG-GUID: FfANxO6EVl9nIRQfzkUMg7iAeE35JwOJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MiBTYWx0ZWRfX5msGpDnXZdn/
 JQLWmERrxks/w8hxMxGZpUlhE0RKXTqsnJwunRq5O3Ov+p7mcMQNQFVu6C5cuTWLNuT3Uv/4EwX
 AsZLcC1WzObNzCBoWFuJUotTrVITpzmebo6gw/rEtDR6GOhDVdc0lAzCplQp2DWAkgoP1WvumjL
 +EoT4W0oq5JUhxQqUOtm2aQWu7mWnc6pcYLfudhxyqVWMkeDq6BkxYipp8/ONox3VZHa4YIVf25
 U/VY6spT4Lx1pMnYas6+rxRNJ6tbO9IceXcpKAeE8ZjVZe+UrqkdUinbdEo0AioAbsqq+5rRif4
 sOnJsMOUMUCtLJXGOFhdnCGAHxsEK1Vlv9zsJEv6poMOo+aPIGJC/NOS/9IZtYQ7o2PT4/vHNTs
 6q0wxNnfUN4MkiG9g5kCVyRgDufjEzX+jwrmKkyWmdzkIYhI4uwkEI5gk9dXETlydy1uoJqIfXc
 BEhalSn0eZxDgxTf94g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MiBTYWx0ZWRfX8jS/iGLveJcY
 kVc6P3GKbylmxxDHnDnYlIbhcRO/WskY3CmhZW3Q9I+a815eV3NHhFDxugHWGAbYNw6+jcuV2QN
 WfM5Ee+OVVK+4HO2ehZ5v5i632KPwKk=
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 9:24 am, Peter Ujfalusi wrote:
> reg_defaults must be sorted by ascending register address, as
> regcache_lookup_reg() locates entries in it with bsearch().  See commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> cs35l45_defaults[] lists the DSP1_RX*_RATE and DSP1_TX*_RATE registers
> (0x02b80080 - 0x02b802b8) in the middle of the table, ahead of entries with
> much lower addresses, so the binary search does not find 36 of its 73
> entries.  regcache_reg_needs_sync() then cannot compare those against their
> default and reports that a sync is needed, so they are written to the
> device on every regcache_sync() even when they were never touched.
> 
> Sort the table by register address.

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

