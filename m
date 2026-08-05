Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C7418A4B;
	Wed,  5 Aug 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923824; cv=fail; b=A671nAGgWGchuH05CIN65PkPZEU7iTiyNNtIiHzLhtaQM5kZf+AfdAJ3szXzJnCkxUJaxDz+Ap0fH7JdbTddNOhJw+XPZGLdZTRvus5cIVoNBa5UECgo4DFosqn6nTxuca0+EG0K1eJu1cCvKk7NH/ErnZOo/9HWuXFpVJdvx9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923824; c=relaxed/simple;
	bh=yVsbKVKMX2kJtFLAo1wo91hXJtA4+tfqF7XYuHYtnw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmAsw68WxYvDFpQu2mOhmT+nMGL2SWIVHFLfgaelLILaJv26SVfAQffFDvLvjXPQbaxR+hHrvRxDF9WqF72EKyfq3ChCo1H1x76YFRGh13lT6kUW+zkfpP5flw2m2lGkhAoeQG5EwUtJHpvO6kWwXwMp6UpFVWVXg/Vc4EzO/IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dh/uEOqp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=SBEsioT6; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dh/uEOqp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="SBEsioT6"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674HY9x02306777;
	Wed, 5 Aug 2026 04:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zVuc2W/QQgxkgxpfDTJBJzL4Ke52RYjZZf5HdsVTPqg=; b=
	dh/uEOqpVEkapQ+T4ltm3luaYqFnrdjuwAn5SFOnwq2S7Vuo2Br+j2qGBW99DF+G
	uQGsOyDT1Qt4QH9hGhZwyCmoFrbTNwqdRZcd3iXv0Xdjyy3tZhdwolUR8ttyNbNU
	VF3EChzh6FEBFRFjG4CM93u+Grno4oYB8Cea0olpIjjXR1ph5QheLK99vFueUUnq
	XBIi6SHV4/N1vJs0sFDPIDEAtj3nO8nDLRphPEFNZ3mcJUmYXTRwhru8ZOB77Qr3
	JmOLvEgGFWIMNOLWdDEFtR/EmbRwKIxNojrFQyzBzaKTMSCXlvhGvcxwYipiwknb
	YVoUN8W5ET1y/y0liivWDw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022099.outbound.protection.outlook.com [40.107.209.99])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fse6vnf67-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:56:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpO/U7voIP8T8KdKS18tU9RACKU1B9MJVwmgtXJc/7lHVONR/ccrEnX9nJH4T6ZYj393TfboGEz24i6bhDMGFdPZI3C1FXL2s7ofImY1jjyi6c90a3j7qsyV0mR6p2DxXQmqPOapEWOWF71EchjRaHsN1354J5sd0J99RNg6kPQmIaYsN53K36F+IkNTBo/JaU0tLMzd25WkxbU4zfCy9GrSw5yg8wkhnCQ7xEs/ilawK3hA/hZuqQYEkmxE0U5XYfUECPoZjSvqfhBBRtT0ileNkQSDAMfPp3aFbnCcBMoVl8d5DmbHbkZOkehqgxh+HgHwcMukvqWUrzaUhnJ9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVuc2W/QQgxkgxpfDTJBJzL4Ke52RYjZZf5HdsVTPqg=;
 b=AO74N0wtkdCXFApcNOeITw5adHbszpf9qYL41hitstlwIJ15wRI6LGqzvWLQV3JZ7nY0PSSpWWyzCDp1hGRuP+BR+QCTc7sst4nRZCZUAY+8Sn8umYl5HjBpNqYy+TGQNBAJbVDf10FhTVqUF5HrtrWypunuCNN9sLU8kbRVgBEHpx1a7KGQL1Ulhz5fwmhX4I0p3M/P2yoXI2yx/u+QzJLhS+AP38Ha4CKNCyRUz+tURgN+zAzAyNAJGmqvogJDTz2vHDZgv7cxyljOqD0VK4H9/NDDnBeOoRKbTbGYnawlAylbfmebAxGV2Q9tj1eWWMM5J88v/Jrbz8DAGqiSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVuc2W/QQgxkgxpfDTJBJzL4Ke52RYjZZf5HdsVTPqg=;
 b=SBEsioT6mt/jIkpD4IHZ2QTkzA3dywDU2TtXiOUuGqElaEAXlLVVGkVXuIPby30c+i8EvBi1ZJmpapWcB/KxHJOoYELVkNTF/pt1LdqVRyXi+pucysprcq4ppdCShQU943Vi4PTZGL7m6mu6PwLOXC6ynL5LJeaoDF+zT67Eey8=
Received: from CH2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:610:5a::23)
 by LV3PR19MB8229.namprd19.prod.outlook.com (2603:10b6:408:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:56:53 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::65) by CH2PR08CA0013.outlook.office365.com
 (2603:10b6:610:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.20 via Frontend Transport; Wed, 5
 Aug 2026 09:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 09:56:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0F5E0406544;
	Wed,  5 Aug 2026 09:56:51 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id E7C5B82025A;
	Wed,  5 Aug 2026 09:56:50 +0000 (UTC)
Message-ID: <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 10:56:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|LV3PR19MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 543993c4-55f0-44a9-f146-08def2d7e010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|61400799027|16102099003|22082099003|18002099003|11063799006|56012099006|5023799004|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	fq8Xgi68DJFlB9DamBU9hrPMvTHreQbYxGM0MqEbXc/7FlGnCcvfefAl34V6i7IOj0R3p9sU+x+eA+gYST0qRflVTh2vCwBEsaztlKbapUsi2e+t09Ke7eJYGxMBbRZpf4z4nS8XO/1kFosWQNEIDfPrhWkpdN1s71MvQHZETd/AK0S0xj4No3Y3RDJuFbpW/ze31DgiWfRkCLmdNGO1wSl+4VtmRZmJrpzmjnntFDB2e8QpfjYLmy4tk1Sns3vTa2hecl1OdrFayv2NzaMQyz/XcVufikpQ/w94hyguFJyHMRf9esy4PL/rpUSzEEcGvxewPpCtAtQmz6KaKGPVN2xa3lTSe2RFEmMuQQbtm3en47APtcSlearNedWgCp1DfYCTuISnXOh7MHcfudc1s3b0g+Q7kFZ9pmAeHu777okBgrsHin9S63tJEnNMkHPX+vFgQJnfv5agq7Vhy//xdKcBIdoS0bPSQk6M5+zbpkwfAVlpDNZHV4xLcAgep7y5nBDWuT/3MwJNJa0TmN6OYIDAFjodwzxGX1ngI522rI5VZDX0jiyxTHIHz4QaNug8h8BOMo8tB3yJDStOmlkSoXAT0/j01SG5wIZqLWpukHDhKY7clmVecPC9qRHAUZZrcdAQuoskP6CbmRKQ73gQHtn40MTiyZ8rcpMfXu2MsSPT4qDnQkGtvzydPeaL9N4YmmN8rPEg9SKlirjtnicnsg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(61400799027)(16102099003)(22082099003)(18002099003)(11063799006)(56012099006)(5023799004)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Ltzkt2Pnrs0oIWgslKs+ZBO1srQfQu1hlDPYznfVoRdAa4Y3SFQs6/93IZKORGZUnL52cE49GsH+xm0rzB8OM1lPNOYdj1C4uZkhsRVyG1EtpvfiqSp1SIOQjzhAIv7nVX4jmb/py/ZVgi7lQe2C7hVFaeKgTEveZo9tV75Diimy72J0uhvw90akWlP9vVgPszsbBg6L883NoobayDpA6NV36Jlqn0pXsBQEAlu1W+e5FAuLsrYDJeCSft8ITcvTJlSUQJ7s2i0Mtxn3IoO4AvkBxUmHbKNEue4Ala07EN2WbNApFZhBiLMo/wX/1s3D/11Fh2ffelLynG7lBtT9cb2KkP/KTXFoo6MEc9lsZ5D1Ppd0yS6ja8gE3yk6q9CRqEj6qLDqbJ5zPJpa3yjP+ikqHDSCmdpay1wuK89yQwId6RR1u/wzcEdea1VF9Hb
X-Exchange-RoutingPolicyChecked:
	QtjIocgQ44QjpK1HGvwYj4f+JkaEph2LdrvBL0Fo7pHf/egFQ5RDPkMUVk4KjT6ZVUO/lSpKGpsuDESuE2ytkGfpoexPKDmPV9ZG9aSJ1XY5J4NdwMRNQY0EFpq7AdF+nYHIQUuDOkpeblCzQ/nYcISED6Nh9gcm0kwT6cBk6/aCvh+DjwKGUg+vwnXP36xDM0b6uyZR7ed3DBlmsBduLHtuA1I4rtUot6akbhrQkjoa2MwSxUEaN7BKdfruhg3Ht3+BtJ9Gew0qppxs8rFD7WInjNih61b9V1LAvkDcAsgmgVSxi5rU3wNcEw/J55+bi/vWciG/WlHIIM5SVUSQlA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:56:52.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 543993c4-55f0-44a9-f146-08def2d7e010
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8229
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3OCBTYWx0ZWRfX5LrAEUxZv0j8
 VXOtTQTzQHxo+i1vvwHGFd1WeiGrIwrTfwkDhsbZt7nsIN5jqgmmtDckh98QFLIjto7CI0IQwVn
 LYoFCHLihCzAyfn74mpOyrrJCyOlUiY=
X-Proofpoint-GUID: qR_HmNmevjqPTUFt8IoW49OpbFTdkFch
X-Proofpoint-ORIG-GUID: qR_HmNmevjqPTUFt8IoW49OpbFTdkFch
X-Authority-Analysis: v=2.4 cv=N+MZ0W9B c=1 sm=1 tr=0 ts=6a7308e8 cx=c_pps
 a=TyCWzW9CAQ5Ogo61w8w6wA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=bh8BFq48CNL9zBbSfrgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3OCBTYWx0ZWRfX2N8h/I+5D5si
 YsfQacVMwKjD/e7TNV6fgeL3A1Lsn5ZGWJuQSmjNVTit+8iRSY6E7Rh2SyVFt6tA5+4PSfXqvor
 yastG7VwEpU6cIgvNsCoFwquxsYlCKtSc7HpaCgmfbS3oBrBGE6HIRijKHJj0bzriaLx8dV/qb9
 OShPcLHq7uY6Ap/IwIPGKIdZNKcjOZdjDL8rnbc0elOTJX8q/ojg+XhSdXiDRfPCIk5DyBXwmXW
 w1/FGHwU78RaUuH85Gz37nXJRLSp79xFfdcco/OSXqvFId22Yiu1A3UWXbGblpZc+n5VtfcQKcn
 FjnsLC/NFoursQovCcg8oiulbN284yr9PdN0W69PVnZyVCwqgJSTfuT5KVeUMkY42yTASSJ+rYD
 vu9h5rLuJVzXZOdkIGXRvuJmYv+8jU1BMAemDx66SSDiqxffES0s7pAeK6JgFUs48p6YIYjhtXj
 /UuN180IR9RkEvUwIbQ==
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 10:52 am, Péter Ujfalusi wrote:
> 
> 
> On 05/08/2026 12:38, Richard Fitzgerald wrote:
>> On 05/08/2026 10:25 am, Charles Keepax wrote:
>>> On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
>>>> On 05/08/2026 12:00, Richard Fitzgerald wrote:
>>>>>>> Found by an audit of all reg_defaults tables under sound/, the
>>>>>>> SoundWire
>>>>>>> codec drivers are fixed by a separate series.
>>>>>>
>>>>>> Wow. Would it make sense to have a regmap helper to double-check the
>>>>>> addresses are indeed in-order in those reg_default tables?
>>>>>> I am not sure how this requirement can be enforced by just
>>>>>> inspection, a
>>>>>> warning would help detect this sort of issues on more platforms.
>>>>>>
>>>>> It does seem probable that anything that relies on people just
>>>>> remembering to keep a large table sorted is prone to breaking,
>>>>> especially if the addresses are provided by named constant instead of
>>>>> a list of hardcoded numbers.
>>>>>
>>>>> Should regmap check the table when the regmap is first created?
>>>>> As it has to search the table during normal use anyway, one extra walk
>>>>> when the regmap is created probably isn't a serious overhead.
>>>>
>>>> But it will be done for _all_ devices which uses regmap on boot, small
>>>> things do add up, see my reply to Pierre-Louis.
>>>
>>> Indeed, if we were to add some sort of auto-checker it should
>>> be guarded behind something like perhaps a Kconfig option or the
>>> DEBUG define.
>>>
>>> Thanks,
>>> Charles
>>
>> regcache_init() already walks the defaults table checking the stride
>>
>>      for (i = 0; i < config->num_reg_defaults; i++)
>>          if (config->reg_defaults[i].reg % map->reg_stride)
>>              return -EINVAL;
>>
>> so checking that each entry is larger than previous is trivial extra
>> overhead. I think most regmaps are cached.
> 
> Right, I think this should work:
> 
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> index aa8f2efed779..ce4b11d8a758 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -123,6 +123,7 @@ static void regcache_hw_exit(struct regmap *map)
>   
>   int regcache_init(struct regmap *map, const struct regmap_config *config)
>   {
> +	bool sort_defaults = false;
>   	int count = 0;
>   	int ret;
>   	int i;
> @@ -149,10 +150,15 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
>   		return -EINVAL;
>   	}
>   
> -	for (i = 0; i < config->num_reg_defaults; i++)
> +	for (i = 0; i < config->num_reg_defaults; i++) {
>   		if (config->reg_defaults[i].reg % map->reg_stride)
>   			return -EINVAL;
>   
> +		if (i && config->reg_defaults[i - 1].reg >

You could test the stride of defaults[0] first before the loop, and
start the loop at i = 1. Then on each loop you can test [i] against
[i - 1] without the need to check i != 0 every time.

I don't think we need to sort them. Just fail, so that an unsorted table
must be fixed.

