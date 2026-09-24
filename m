Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477625B091;
	Thu, 24 Sep 2026 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239451; cv=fail; b=GIGAsw4c1PSBtPybsk2vQ/qYFOlPFRDnf4i0i0PT8mN+7MvTlTqVY2Djo4aR25o5aWttG0U6gR51LQN3If7LyZ6W/QfCa1ET1G1677Hf80vCTq8eqqu7uMyRB2jjsbggz5a2RCOahggbyLqSylMFp+/nvNkP9N0YFzBiJMIQvdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239451; c=relaxed/simple;
	bh=tI3fFnQq6BtECV4oAp67jCJVHYdBG73jqpjEJPn4lHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IROQcfnkslwlWn6FsBxJ97FXkNspdRT8Y+pTKyQR/O7endvBOxVCWryN/y82+rD79zoG1YfzgQkCCuZhSzkSMVt12uQS95vIyu1g0cMZyb20icQS+YPIap9PlK6TL5gmZasrfE2ePWH0ZzaSqqU1YvSQnxDW4Wz28tPirVfmgmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ehOgruOV; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ehOgruOV"
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5c0Il907761;
	Thu, 24 Sep 2026 04:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f5DTq
	641cEaEOUsF+RhIUmrzXHwEzTaIy9i2X9Lgtt8=; b=ehOgruOVhG2khL3r7iPbq
	ntAatZ6J9DEIWWHEpBqWVFJ6wW9DWjvRwyN6iPEMf9wFdC3SuiJHPlEElfva3BD+
	rD6z4ju4x37Q7tvmu6l1ZBTU3OwlpcEoClmU9RFnFs8ExxqUDQf1yADUymkuPVrS
	EkKNhF0JegPwLvRo/S/NzEpcOYsgbKij1iaE8G9i0g1GVtlhhpn766xnmGVbsCFD
	ET7Hdz0Vr3fuC5w6VOIeSoR9VvwMZlCKkvFU3h8JZLJ//lk2NiX0T3EFigkjW3od
	LcHd4gwkWS9jG4tK9RHzKSHqbwFxwV896llIlsUkxzlDJC8NhxZj+/y93Of+OhqL
	g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gvum6s8nw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 04:43:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGSzxLdM2LI0Z50FKaQI75CnlpGaoU2ySZBun7ArJlxDcClVLazZuyvjNy0d99cEC9PFg2AxAZoflCiU6EQVZfjYpkWKXFC21uOcASYmkfIGiSGxnWDa8wcj9c83JtMZQY2zG0f1iHfTr1M9f9iIeexDGfsEWKDbReIU07Oq2TdEeVbxiRuBGIv5/ENKBzEhRf1ROluvkjN0gXEt42V1m6s+z+70VLmA8PnfkZ/YB5Xfz5c2D9xcsu+P3+7F6lPioWA6xIHHcgYiwiG6Pm/qNBI7/yZ/Taactsl6kir9buUNyLVUNRZ1QBSxY4W8EA2xhFLbd7TdbceMTYq7y0DQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5DTq641cEaEOUsF+RhIUmrzXHwEzTaIy9i2X9Lgtt8=;
 b=jAU0sdEZzwBmzYkXdMv6kNPiIKplOK2xU83nwMSByMm+5O7v/WSMy/lue3FGcJm6PpCIS9lcVRClrjPRynJ4yWQsaimNxC/3eW431Qh4RTeHW98Uy7PAFkV2CfYWls0vvwMXehi7t8GOb6MFXA7CG3xKD7MlLpuYBsdara5LqFipV/TnsBVfmMi1prWmOm6DhJuvhKmUm/SZao5msLj/ejdF3JQ6zP+uwWzgkbYqI7u5Fq5LuK+bum5vh97ESZntij0nyLzVUm/IZDF1Dql03GlulkkHIx20uDql4eLG/d3eVVQy/254+R/HGHDmy22xXGcoLgUTJKlS+bpyzvGNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6013.namprd03.prod.outlook.com (2603:10b6:5:388::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:43:50 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:43:50 +0000
Date: Thu, 24 Sep 2026 09:45:07 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix use-after-free on unbind
Message-ID: <arTioh-Dax9Ogizj@nsa>
References: <20260923094807.503690-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923094807.503690-1-fanwu01@zju.edu.cn>
X-ClientProxiedBy: MA3P292CA0034.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::6) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebf1d5b-fe52-4b99-5cc4-08df1a17f435
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
 j6XaxQ6Gc8hQ7gQYCYyqSaNHzHYuJifnOtu/m2PfpZMxw4ZbrW4TiGkCBmURNXQpeCH6OWDL05Tuw0J8rsy9bgLTaJHqpLn6s65gXeauKY36DniZKIPhzcBD4vWzBTaSOjBYJvAIwSvAa3aT4vlxdF7VYipI0d7g0j0AnAgJW4FCQHu2sZyNh9OPAxWmGV4BQBlud7nQzNjMKscOV0VUANQFv9CwaKl/XOHQ3tTuuGVGefULuWRDynl/ar5tBcg2sLpxJB0U37irkIwXBy1VC/0+HP3un7cTTAEr4lV4W5QEDoUlDPMOwkqGDE4QPmjaGLvECz6s/GzAavqToKo7fytriznIKKKq43xy9VlylPNiwBUefk0pF6A7LOmkjp5UZKK7Kf6U2JuMXpuuXcusyxPXGpineWgnKd7jMpvrZ1MSksehqU+GZ/lTOtRxnxscPsNwswAxGcAdnXKocobkkKREUdRVvw9QvdSm19ReXPZaHz1KgCNvABgANKRFDL1zYoc1YBKHgZ3LrySe+ZNdLSne9X6oRobkH9qajNbHca9g4LqE1d07urL0ZcivzMKGVRplr/SNV299ZSWN6FxbDmcQq4Cha7TZpuicjkB11Sg9h87Yf40Hsy5+wx13ZYgQJmjmpXeBjXYAqhkyCauXo04WW2UPbmO11acHKNKaTuM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WkZoanR3VjN0dGZxaUFSVzZHdzFrSDR4MEJUSUp2bURvUTcrQ3dTQWhDUHVZ?=
 =?utf-8?B?b1VuQnNxTkNNWGhzS2R1c3d2MDJkdXZBcTc0ZDIweFl5eXpyZDNhekQ4VzZr?=
 =?utf-8?B?ZzRXM3czWmlpMnhpS2lKYlFoL0hZV2tYZVFiUHREZFN2SklMSWtXdDBsSURx?=
 =?utf-8?B?dkFsc242NFA1TWM3enptM3VYUktjWmM0N1dsUGswajFkSUxtYyt2RnlYZDR2?=
 =?utf-8?B?Um9mTWJXWFVyVElxSjdoUnpDMGxKbUVyL1pDVUd0MTdMSDlrMzZ0WUJZMnk3?=
 =?utf-8?B?UC9iellXdVQzaGlYaTBROXN2bVNHeVlSZHBtemFyQ1NQMzBZNHVoTDE5Nldz?=
 =?utf-8?B?SkhQT3VISTdidWNXbHlqcFdleDJkcGVxUFlGNGxRZlFCVHQ5UkNWSzJJb3N5?=
 =?utf-8?B?RExFc2NENWhhbCtPeEVha3FVSVVubUQzSXAzMEJTVW5PYkM3VjkvSlo2d1Q1?=
 =?utf-8?B?NzA2NUtIWFhTMGZxYnJOSkRBVGxXeXljZDVjZ25hQk5NQ3pMZ0YzeVBNeERt?=
 =?utf-8?B?ZWNRU0l6ZkR5b0FZYmliZG0vanJ0cndHSk16a0R5NnBZQ28rMFVMYmV6RUhU?=
 =?utf-8?B?ZzJENjlvZEhZS2ZQZmQ1dFZZcjJPR0NaZjBVODBIYTZ0YUxnWVV0dmhPZWpY?=
 =?utf-8?B?T2YwYWVrZmw3bHE3YjB0QXpBRzJ2N1o0MUx5ZzdkZEo1dkU0Q2dxNlZSakdM?=
 =?utf-8?B?czNXSnRKbEwwRFR1STZDek54TWczdVFCTTNCV2Nldkdad3VsOWw1d2NjNGNS?=
 =?utf-8?B?RHhhbHZLUDNtcTRGUjQzdlVGeFdJNU1zZXdycURGWG1JU3NsMVcralJKaXhv?=
 =?utf-8?B?K3ZXS2tWbGtmR25xOHlia3ZvRlZRaWhNd041ZVV5UVI3cFprN1ZQWTRrbDg0?=
 =?utf-8?B?ZXkwS3NXbFRxNHg3QWE3TmlCVFYxYXJ5b1htWEVPV0N6TkROSjRENDBNSy9J?=
 =?utf-8?B?dFV0SlBlM29KK2EyTVpCWHk3QWY2L0hib1ZqNGJlNVpndzdzSTFSSEtsSzFj?=
 =?utf-8?B?T3V1cXo0Nmc3dzhtY2xac3RIVVNJQm9NVXl6b01GNFhuMGFtNk1SaVZZZVFZ?=
 =?utf-8?B?ZDROc2hudFF5Mm12VGJsOFlTNEhtZXdtZmdpNnlVdDN3MjE4WGIwZzdNeXRu?=
 =?utf-8?B?YjJ4WFp6N1RqRnF5TXhEMWhpNFdrWDUvNkZuZU5HL3BuMDZaaWNjZWtGdTN3?=
 =?utf-8?B?SjU3ZkcrYTNsd3AwV0h0M1VWaXdObE9DdlFqRjBCZVdFQld4T3V4WVN0ekhB?=
 =?utf-8?B?VEJ3QTJqY1FEeXZMZDFvTjNKRlYvVWxUVFk4TEd3QU1FM3B5WTQ1bGRQVEhV?=
 =?utf-8?B?Qmpsc094ZXl4V1lzTWNBRVJGaDRWL1I0SnRpSG1mV2tzMVg0V09qa2hmSy94?=
 =?utf-8?B?MnF1a1NOdmg1WmNGcytvV1FaRDBzR1gyUXFQeVdyRk5WR1JvajFXQ3lMT0tp?=
 =?utf-8?B?b1VncnZpcTVaN01EVXBiUU5pcUpnMnNITlhkUmMyS0RxWjVNUHg0MEMydlFV?=
 =?utf-8?B?YjhIRUdqM0Y0WEVmc0xVbEVlSDIrZncwUHJCdzBTazVwN3ZXejhvZUpWN3lU?=
 =?utf-8?B?bTRyTjBiWnR6RWJVNjhZRFpMOG5GVjhtTVZLbFBlVkl6M3FjQUlqS3Bzb3lF?=
 =?utf-8?B?Zk9iazNoVG1ldjE0eUZtaHFwSkhDcDJSNnZ2N1ArMW5KWk9KOTk5OEFWd3p2?=
 =?utf-8?B?V0E2bzBiSGFRZ2dXQndRMWlLcWVRQkg1Z3FDT1RJeVU2QlpncWxmMHJpNHhF?=
 =?utf-8?B?TW10U1M0WFlLY0FHaWRuVDZPWDJtbHNLSU42azUyMXJ2UXdTQldNWHoyZVYr?=
 =?utf-8?B?V1hNSHBON2xQV0UzTEtOajNuVXV6d2RUVnlFQ3kvZDZBMHpMOFJXbzdwY1F3?=
 =?utf-8?B?eGN3YjA2KzF1VHFrRUhkUWltVHZkTTFwN3d6ckQ5ZmdjNEs1R3ZVVjUyWXl3?=
 =?utf-8?B?UUU5eGFkRlVRMmk2OUhkVHV1ZzhETlNweDM3WFpkdUYxako3dllmMmtkWm5j?=
 =?utf-8?B?SjNQY1hwenYzc2hvTGdUajhQRWcyeHR1U0J2WDRPbUR3c2w5ZG9CN21yUzhD?=
 =?utf-8?B?dHdvZmpkT1MxcjFKTDBkYmM5MFcwU0RPRkIrNkt3SUZ6bkJHdDlrWkQxb0la?=
 =?utf-8?B?Z2FlTFRFZVB3YzREaGxWUVUxNmIzbU5ZSDc4V21kM2hNMlZKNWw5OG5ZVll1?=
 =?utf-8?B?bENPem02eUIvQzNJdmJhZ3UzdXlHVk5oYml1UG16cUluYmNNL2lxdVkrci9l?=
 =?utf-8?B?c3NRSFlLeFN0cFVRY0d1bUwxWG1iQ2h0Z2dXMzJMTVhtaDhuTVpXUEtyNnlD?=
 =?utf-8?B?dUNvNVJ3NkxSQkJjVDEvQkJ6MEZaWEt3ekM4NldpWlVCaTA4WWRMQT09?=
X-Exchange-RoutingPolicyChecked:
	5VqJRdauT81OX61zI5fP327RvDkByaztJ06hGFqLK6RgTKL9PPq8DwoMjVEjdZBmAYZh7NbX1nFPs3LSfxBVdQ0/HxE5hQbcTK2/kVVsDPzl9CGrvStfixQ/fe3ZT+ojVTtzkRlTnFb9NVfnxv81PGmy1NhOEywIF4cHJ0ydwoW5/zH5GrCxZfyrt6VXw/PS53vLtKVonJyFBU8Sf+keT4FTtC/MFTdWp1aFxuH5Db0yIf86AaXLjoegmnR7Jj9m8PN0OEFj1I04bcJp3HhMnXEZ9sMgm7AWxxVu6KJm2uiT6s+kkmGQN63t/V7+wdyMj6EKYdG63DvtQnorgXDMRA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf1d5b-fe52-4b99-5cc4-08df1a17f435
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:43:50.0636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL/2bxTgi9BNDV9Amm/IGDbQ5hW5u/z9svT6sv1apcXyQBklGcDod8cA7gNXAeTHiALOiJ223I+4fG60vjNAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6013
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfX94roYbSd1zW5
 bKm61KJBkStft9HOzouWFcq3R+7zJ1aWaAnUgELGJs6vje+S2Ow553+dOOXr1kE95BJtnMbEzK0
 ZlkxX+WXosw1ikqYGJ6BNvEPte4MroSEFvksXAJIds8ThzqACQB4nQP2bhCXwDe5lI2QG1wAUxM
 WC05IIO9r671ADxMwkZrFmcBDZ110MBT9794l5Yxqro3fCrmVwMMzYUngh27FnGCg1u1jcdyHN5
 4vajqt0vEJPOztEr790TWYAV87RlKczUmQbjohbb0x8GpBmi54Tz5bAkYWPoLDpOP1EfUq8lyxY
 ah2bXv//ayz8ETlGVH/P4hLP4N5sybdiOfr9jFIAQyIa0TYpPHYhtskwsBd23T5yMWv6UPW0b/z
 J/POxRkpZ1fSXK5MFX72uPF3xGPcfN5zW+TP/3jSqM5v4E1OJvQ5yB4t42S3H7K5J4nT2VVAP27
 2MYgZtyoYmf/8O+ETNw==
X-Authority-Analysis: v=2.4 cv=ff84WEQF c=1 sm=1 tr=0 ts=6ab4e2c9 cx=c_pps
 a=HGE+/hAEzspoXCOliImplg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=hQTi3ywRaQtkDvEopYMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9sKW3LJersVBWe-VI4tU3Wj9Sj78ircZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNiBTYWx0ZWRfXwpib/dWzu85A
 3TAMugw14GALBHuiQrRNc5LBAeB0Eh+BxZUmaJMexp6t9T+hKxwNJkupImfiEMGPqDsD+QPDXVu
 y32URN/a1wIIsceC1g1a7Td5DX+5Ia0O8RcGaw6h6RZGzrkGlAgX
X-Proofpoint-ORIG-GUID: 9sKW3LJersVBWe-VI4tU3Wj9Sj78ircZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240036

On Wed, Sep 23, 2026 at 09:48:07AM +0000, Fan Wu wrote:
> ad_sd_buffer_postenable() allocates sigma_delta->samples_buf with
> devm_krealloc() at runtime, so its devres entry sits after all
> probe-time entries of the driver. devm resources are released in
> reverse allocation order, which means unbind frees samples_buf before
> iio_device_unregister() disables the buffers and detaches the trigger
> pollfunc. The data ready IRQ is still enabled at that point, so
> ad_sd_trigger_handler() can still run and memcpy() incoming samples
> into the freed samples_buf.
> 
> Fix this by preallocating the buffer in
> devm_ad_sd_setup_buffer_and_trigger(), before the triggered buffer and
> the IRQ are set up, so it is freed only after iio_device_unregister()
> has drained the trigger handler via free_irq(). Size it for the worst
> case of all sequencer slots being active; ad_sd_validate_scan_mask()
> already caps the number of active channels at num_slots.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 8bea9af887de ("iio: adc: ad_sigma_delta: Add sequencer support")
> Cc: stable@vger.kernel.org
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Makes sense to me! One minor nit Jonathan might be ale to tweak when
applying. With that:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad_sigma_delta.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 1b41029..4f982c6 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -498,7 +498,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
>  	struct spi_transfer *xfer = sigma_delta->sample_xfer;
>  	unsigned int i, slot, channel;
> -	u8 *samples_buf;
>  	int ret;
>  
>  	if (sigma_delta->num_slots == 1) {
> @@ -530,7 +529,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  		xfer[1].bits_per_word = scan_type->realbits;
>  		xfer[1].len = spi_bpw_to_bytes(scan_type->realbits);
>  	} else {
> -		unsigned int samples_buf_size, scan_size;
> +		unsigned int scan_size;
>  
>  		if (sigma_delta->active_slots > 1) {
>  			ret = ad_sigma_delta_append_status(sigma_delta, true);
> @@ -538,17 +537,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  				return ret;
>  		}
>  
> -		samples_buf_size =
> -			ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits),
> -			      sizeof(s64));
> -		samples_buf_size += sizeof(s64);
> -		samples_buf = devm_krealloc(&sigma_delta->spi->dev,
> -					    sigma_delta->samples_buf,
> -					    samples_buf_size, GFP_KERNEL);
> -		if (!samples_buf)
> -			return -ENOMEM;
> -
> -		sigma_delta->samples_buf = samples_buf;
>  		scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
>  		/* For 24-bit data, there is an extra byte of padding. */
>  		xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
> @@ -855,6 +843,24 @@ int devm_ad_sd_setup_buffer_and_trigger(struct device *dev, struct iio_dev *indi
>  
>  		indio_dev->setup_ops = &ad_sd_buffer_setup_ops;
>  	} else {
> +		const struct iio_scan_type *scan_type =
> +			&indio_dev->channels[0].scan_type;
> +		unsigned int samples_buf_size;
> +
> +		/*
> +		 * Worst-case size: all sequencer slots can be active, capped
> +		 * at num_slots by ad_sd_validate_scan_mask().
> +		 */
> +		samples_buf_size =
> +			ALIGN(sigma_delta->num_slots *
> +			      BITS_TO_BYTES(scan_type->storagebits),
> +			      sizeof(s64));
> +		samples_buf_size += sizeof(s64);
> +		sigma_delta->samples_buf =
> +			devm_kzalloc(dev, samples_buf_size, GFP_KERNEL);

Why the line break for devm_kzalloc(). Keep it in the same line please.
Tbh same for for the ALIGN() call but at least that one is coherent with
the original code.

- Nuno Sá

> +		if (!sigma_delta->samples_buf)
> +			return -ENOMEM;
> +
>  		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  						      &iio_pollfunc_store_time,
>  						      &ad_sd_trigger_handler,
> 
