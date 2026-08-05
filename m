Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3041F5EE;
	Wed,  5 Aug 2026 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929914; cv=fail; b=RMDT4oVF8VOhEFlhCT0Ol1rnZen/ijOOhDDmplmABr7I/MvLtHXmFowN4w3brpp8cKW4fjHGBLcqB/92xlcbwc4oG20fJ4u5V5tucKqZoALH1JW3KSACivfNdYJy4WA1exmAF8uK0ptLIJjrPAq1dAH7GNZ1go/GncRpM2hFTGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929914; c=relaxed/simple;
	bh=8X7I6QAPtAGt5xjtLgBm6CjkgY/KyX6MXZnNX3kF9jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4HbkX8IhhwkOFc2bhMC0QI2ZK+YST5wdY1T14OIoSvWuAjcuGU0p0hzTiziVwjr1EDaHkqCBr94JvLzkR7RFTjWCj1e8oB8NSvnwK2IeHS3kxlWyOAOwkUbEETiq0k9VTcdmPQwjvuNsYqsBv9k0grcyYJU4PRAiQzrBwcz1PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XtDIdxAH; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=N+5mk4iF; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XtDIdxAH";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="N+5mk4iF"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6754M1u42512551;
	Wed, 5 Aug 2026 06:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=8e+DmNexixz+rETN9K9gwOF2NP8USFLnFkfDENRwR9A=; b=
	XtDIdxAHLoQ7HWfwXNY8d/iyas3JSxkWIcxaCVG2ZAcY4vEaCKY6Kvs+bqE+sRnI
	iBZLgzf7+uh/0oYMSMxR6lJJYwn2syTLXpu/Vm1LPursgjpEe8eis7rFmaEyumLk
	wI1NPFyZd6VSo1qiIx9i8laU6pIErTilFIz1Dy4K8xS2T553Emb1PW3+KOw8WFrR
	road9N3DjDeZD8rlJQCVnUv9LaOx01EeOHVNwEWE/82NjIMkJ0es3M4IzLopme0Y
	kS30ICCB5FMBG6lvi7KbmN7DbCmlRDmkFd20LNS/X/Bs2kQSUbIzsVoPH1hHIb7+
	UdtqjXyllJwrWMYh9eSEIA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5ma9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:38:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PutPL0XtgV63gYeLO8WMXoIpnUuFLB2DlBIRft8rmGtGvTjOPM8TcqR4MfB0HPprLtO+8Au9U57qZbs/ZCmjivCm6qqkbR2Ur28fyL3+rJpDeM1DR+MMuvuVv2BnXJSU5fZNtdJLdAgmZv0LEyhLGmuwPeJ5nsSXTlMVAJl8lsWATX4qsrjKa15qtJ5UmHTa0QIsCFhXcTOKpSHPVYaNxDWEfTDfxSVjoRwXV5z9Teokr+1myDWge+gTtWKpmGbDCn4mnWIMoCaTbzfmsoJWymTy75Q8fXuo5Z08miwfP2MUXM3Ma6CH0G6yB6ajBoU4Ef+De3WxGLiW2wlCpjf2fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8e+DmNexixz+rETN9K9gwOF2NP8USFLnFkfDENRwR9A=;
 b=JSxXSF2SxXgkiZOWtiTi9myqKcKpRhQgmiOLZWyYa7/SrRPtsGd7lTnGKRKlB1joR76dRGc9niMAwcJa7VMrRc8eQA0/pX3XTNsHQ12zMa15kGKeiSiLRTmVMiTirMQXHkpL1iwdo9TMV5Oxul3Ccbj3a0Z8U4O6POUfd5qzh8fUMyduoPGufhLOz060045YGSTumqHLnlH4vYyWmCGLEEZE/WDF/IoZ9layNq2WGGJ37ILRzPLqfgEgOsSYsZauYMTknhzZ+KULihpy9e0jlNxIDd9MbNUMw/q5nx3KYmwQJd4Wc0mabqh7L9Lq/Pzwz4SSvHyoeS36PFDfZV7b0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e+DmNexixz+rETN9K9gwOF2NP8USFLnFkfDENRwR9A=;
 b=N+5mk4iFevDKvXVjrt8+MUMH+nPEm8gB6QfX5YvhpBDaam4eJwRf1Q8I5+luvbrDxSaDmB/OBo17/zdkyWU0SSOLL41C/6aNG+Ph4rwSVow99VVrpHjBbgkuqVUanq/TsPcBdTLAB42FabsT7L01PbqJXKhAXXvG8pNQXrnXMxY=
Received: from BL1PR13CA0208.namprd13.prod.outlook.com (2603:10b6:208:2be::33)
 by SA1PR19MB8891.namprd19.prod.outlook.com (2603:10b6:806:467::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Wed, 5 Aug
 2026 11:38:18 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:2be:cafe::76) by BL1PR13CA0208.outlook.office365.com
 (2603:10b6:208:2be::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.5 via Frontend Transport; Wed, 5
 Aug 2026 11:38:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.0
 via Frontend Transport; Wed, 5 Aug 2026 11:38:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 27175406544;
	Wed,  5 Aug 2026 11:38:17 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1D76C82025A;
	Wed,  5 Aug 2026 11:38:17 +0000 (UTC)
Message-ID: <32d2938c-4a52-4508-8fbe-b9bb2cfc678f@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 12:38:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
 <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
 <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
 <anMMIH29hLtOH3kX@opensource.cirrus.com>
 <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
 <2585c2ec-1146-4a48-9169-274449d1bbda@opensource.cirrus.com>
 <272f965d-4265-4467-9cd0-20259e107eff@linux.intel.com>
 <anMfDz2CkDDIsVce@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <anMfDz2CkDDIsVce@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|SA1PR19MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d16365e-8edd-4372-46b0-08def2e60b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|61400799027|36860700016|56012099006|16102099003|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vHfW6GJdVyHW7WjVZWn8Cgc2mlho9ol9hIBENHL3QWJqQWcJVMzwdEDfdVy5BCPGGFSljzP+e02HO8YoFNarmysmk0yGOi0LL9kDJva0PmjfWDeNTWo3iq1Z6ZTBb9q2SQWspbydvsT+LoDtFFjIeWzhDdBZWjJB+WXsN+KGxvLVqzyrk8oXcpqhPYF6etaVnNtHkeXJ0IktuJPizoc8zbBPBRyHQIUHO20TeRqaGXzxyvE5HyJ+M5cu2ReqnVa3mbi4LUPYx90yEFDZuE2TMI1Jy5Iv1idfhoqdnGEHEsy/MaIQD6QoJHxaxMhDwx6DbwKtC7nLiXjzMc6AW94X3p5qaMpaIjMFC8YfUtPXBBOZuAkxn85eCBasS56DP+5R14ry/sT71gLH2rLprN1CLeV7YBgMD7fHuNDqWFafcH7UJOkcPZtnu+irCqFSrd65v4oId/PMrpB9DjKuYZcQr6CTrlcZosuyiZ276dCHnMvgILeTbvRGyR0PkQKK2V1y+39FFdnkKuh32Ew/K3+95ZBxkBKvxaKhxB+D4WWkBcX4Qyda3Ps1RIWceIj2ftmDe6yzjIKx9g4qP2TlpJ1HRbMcHWkEDRGJQDwgDu1a7dDw84GTOmyymwKcMtk5gHW9x2A4R6TisFTfePb8RJ8TTrbQkpBAM4bdpZQGeiyyTBBOkyWsJ6k8mC0XzR4cRrv0QkwAJHaYgbom4d6IX5Ro7w==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(61400799027)(36860700016)(56012099006)(16102099003)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4g+XQQwzEz+JEsfUSld6xM0C2sVKBTAzBfkfYDCeOlnuBU1UbZp6BKMxgFv5IAAmpFgH9qjm/fFNtTFNX9GlwazVPOhW8RFvEhV1VQf2k7fvdbzoa0npEI5nnNp2zHj6iRX/0DcxD54Lqhu1C76RF8OESUOQQAOnXJQIYWgtVdmCff1vor9Y/H5aHbli0HPcYGCvGmt4vu08YSpVhO0bHRJLy5H1X+VfKTqoOZB0tMp8wbt/BfVs3Lq/x+3F3HQOuUUQWhvhcTlzLLnXiOyHO5z3FzPqdlTKz3HoDwofBtWNz4xf/RlnQZiGPCztjIKRNzqK0HDGVYM3/amZYCqW9g2jPim9cBbf//QHfhrbOHv71Dstfj2qfi05VGjfr8cnUSPVDzMFseW/gtqvdI5Todgmo5FQ/hs+LWUouue6mYRHiHkQT/v/etM0RPr1JhxL
X-Exchange-RoutingPolicyChecked:
	HsMQiolSP1zSeVnB4fJv0QSjRvStB31SQrhkrWuNYVyAixsoqRqAxmECk2gA4NOVbvDU7/93q+y9qG7AzcMSSKaVAWULKMh8zCrCcBXeDw4KfvjYmTjg8pnKfHgO0YiRP++6sSxHPc3YdOCWko94c4Lx+l3uIR11i4FMHlfgGHsJL8sD8UlusimDirmB7KYVb2BpbX2dzTXlmIs0qe10zY/Oay/Rf0Psh1I8nisCWuUthxeR4McHM6xSFHywDcbMe36K6x0JdaHP7OYbUrWYMkUvijP0RWnsfxkI66trJN+yV1Fn4uC7VNwGBmfqZ27UpnvSNaIkfyTAP+ibcu7iWA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:38:18.0093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d16365e-8edd-4372-46b0-08def2e60b7b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB8891
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a7320b2 cx=c_pps
 a=WTYiPbwPEgbs67/cDcbz6g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=LubeiwFnrlq4pKWvvTYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RPnHHEP6MzY4S1cnagWj_nbUJYvSgJyP
X-Proofpoint-ORIG-GUID: RPnHHEP6MzY4S1cnagWj_nbUJYvSgJyP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MyBTYWx0ZWRfX7dJM96lEeR7s
 2dnOvSrjOZHZ+LkFrEatdJUZiuUGHYYFd7kCeIIbfzAslP6glHXcSHmQCyAdhAGuXQqY38Om9z7
 3kwqbEbmFrWt8T2qI4HhH4JpvQ5u/1QYrwp3BeeupVJpEDmi86Sark17VvCSytAWQ6VuIKqnKlF
 E0JhKk8/kWXfTu7Ng40OQ5xgHRJtZWoaPQavZQxbsEkoOPk1WFancO0P5gCtcGxCN2+b3qkaC06
 Kl90itKzhOsiKv0GAbCvbBxEkQCuK2zeVr7HA3LpHktZ+THMiG65uvUR2LuOUDZewH+3kc5cGt9
 nGkKeSaZwVTIi1EzMAG3dCC/Pu4FTLHug6gwu1UjtL1rU2FwnOhl0hoJAfvcLC4Vmj5pfTOsyJY
 yPyf3YYnDENcVdot1Dm+PLEGUcEW7WN8hqC/Co88wa2HSzd+yqXFUid9gbhJ0mPxAnvzntSBac8
 7rE/wbUAHBY948AQAqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MyBTYWx0ZWRfX/CeGzd25LGW1
 l4sA39AGZCqI4kqkYt2Zu4zZJ/kFDU8uzcsyEVxEhK3qURLUtu/eENjWaLeJfjbl1KbxmcRAXhZ
 LNJk80uI5ZByJtKtBUoRkbeaeedrMVg=
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 12:31 pm, Charles Keepax wrote:
> On Wed, Aug 05, 2026 at 02:25:52PM +0300, Péter Ujfalusi wrote:
>>
>>
>> On 05/08/2026 13:36, Richard Fitzgerald wrote:
>>> On 05/08/2026 11:17 am, Péter Ujfalusi wrote:
>>>>
>>>>
>>>> On 05/08/2026 13:10, Charles Keepax wrote:
>>>>>>> I don't think we need to sort them. Just fail, so that an unsorted
>>>>>>> table
>>>>>>> must be fixed.
>>>>>>
>>>>>> That would be a big regression all around the place, ordering w/ the
>>>>>> debug message if developer is interested is much better.
>>>>>
>>>>> I think I would come down between the two of you. I definitely
>>>>> agree with Richard on don't sort them, just encourages drivers to
>>>>> be wrong. But I also agree with you, don't hard fail. I would
>>>>> vote for just print an error message and carry on. That way no
>>>>> regressions, but also a nice big warning message to let people
>>>>> know what is wrong when they see problems.
>>>>
>>>> I usually try to avoid alarming/annoying users with error messages, on
>>>> the other hand I agree that w/o some pressure, these will never be
>>>> corrected at root either ;)
>>>>
>>>> On the yet another hand, if the regcache have means to fix this, it
>>>> might be put into use as well.
>>>> A dev_warn at max to get attention or info level perhaps and fixing it
>>>> up?
>>>>
>>> I asked Codex (GPT5) to search for all reg_default tables with out-of
>>> order entries or duplicate entries, looking only at those assigned to
>>> struct regmap_config.reg_defaults (some reg_defaults tables are used for
>>> patching - those are allowed to be out-of-order).
>>>
>>> It came up with this:
>>>
>>> Restricting results to tables referenced by struct
>>> regmap_config.reg_defaults, 39 files violate the rule:
>>
>> and some of these have duplicate addresses with different default values.
>>
>> I can send more fixes while I'm at this for the clear cases, for Cirrus,
>> Realtek and TI I have sent few patches.
>>
> 
> I was just having a look at cs42l43 so you can skip that one
> unless you already fixed it up.
> 
> Thanks,
> Charles

And I've sent a patch to fix cs_dsp_mock_regmap.c. That one was actually
defining the table in order but had a typo in one of the addresses.
