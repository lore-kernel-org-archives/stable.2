Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43298310779;
	Mon, 31 Aug 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173730; cv=fail; b=SR+eMCuXCBKqUY0fIIRznSb1tZkTA7XUZtkG1oC5iSb6xI4eT6U5VoYlS4G5DATCi1JN+qMDhVpOwhHg4NKrl3rNz0eEsNkymlOrAjlav11ZSwPgD7cs8P6e1JXtSWTNFcDNA5P1ZuHALyV1WVv5hyAxXvnJot2kOgb25idg/1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173730; c=relaxed/simple;
	bh=yPhTA8dsTksJ6RknN7Qm4hCLU2TJo5XNUgHL5hyUV/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FWT2FQWsHx7mEKTuIk4vptQVMnJ/bOfA+01OLAQAQ5Ow0TWfkRo5uQA9XCzADmJ65AtYzsZFsVanGOH2M1TWjyDqKrSgQP7X9o35TMtNr/jZRxN+bEqvFQCmacOMoE9t8I19OPQBWqpqVDwo1MuknKEuEAS8keUjqQtLIm0p9UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=SAnUolqe; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VFUh8WLE; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="SAnUolqe";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VFUh8WLE"
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xn9U2929764;
	Mon, 31 Aug 2026 03:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=hV7Ie8prMp8fa
	dj8poR0cj0PWBYdZVglcyxnU0aZXiw=; b=SAnUolqeLggshm99fqbTPFrqdKJ+U
	yX+ojLjb8TtsYN03b719m4M02kheetB754rLELBiQtpiH60bjFg6tuq+iHoCRmej
	Ql0Q8yaJfazoI4hqSLyXN+BNIFZo3zZyXQVIBgv3YfpNiosaAjc4MIFn6TezEm+N
	d5xMahGP50Hp9G3txRxPU/nwoIHrlVjoRYFNX7QfV4nOyaV5owaDy1f4s9kXpmXA
	V9DCnpdcHgzY69C0ZhWqoVDd/CalBRon/Ba+W9jgVX3amW8QLxFc5BcJGmp+hBsc
	/OtTZkyrc9cvKshxP0JhGSsSIySBMtHd3dOybdpihEls0wTJTFkFG7h2w==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021096.outbound.protection.outlook.com [40.107.208.96])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gbxgek4k4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 03:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR4gjDOGb9M7eGU8VaNfPOICtvQYyEEiOG/mTpTtfBoJIzkuolXAJ7DtU3hTJTM91XYwnRPkmzZyV7IOUo/CZiSY3j0Gj2ZBVGLS+i6EEsZjSKXxeMfnbC5QjPADDNYP28rGjgeF0F38wVkpf3TJkOTi5+8sxD32XK7w6UzAmIpQ0St8KMqaJ7JL3tVid+uszbe3MUEiP5xKDJpG2QqEbkpYPvRXA39JcWvg0oUheUBB+wC+ytXwcRsrfv8e5HcJMyaKOgpgjb/RBE+5SL4SfeAP/uYo84oPmN51ATGVkaiCO3AcgYP2M3JPXtZx82BXg44WA/8VrcRw4Ln1kSNL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV7Ie8prMp8fadj8poR0cj0PWBYdZVglcyxnU0aZXiw=;
 b=WBxLl30RZWJz/zQhu36OfV5DWWl+pEfYzf2qO2xm14f6UDHQkeL3S1qVJ/LJ2LdSO6ksgHh91a5Ak/NYl3pgWLxfbpNx4+h28ccxAUh7sFPIX+9qfYwyhzLoG7O7MmoGdS6x+BJbBiL2PFmjg6S63bIsCsgM3vFOqR277b5TWUwtQPJu6hL8Dee5QJVtox+QNZy1cE4HES027Ei3vToSBsKQXDxqHSaizA52jgENv9miU9K1YUZZJEw+1UHBOMwDj5AxuerQccDo8SJgejyMFsgSyz69uQ5bsZTbAW3+/X4BmC1/dBNn60aw4qET7XWf6Ceoo+V2uaGwOtzoRhTsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV7Ie8prMp8fadj8poR0cj0PWBYdZVglcyxnU0aZXiw=;
 b=VFUh8WLEzv+qtH2mi/tTLLsbElQSEXy1UliauwN3Ks0dDswYlIeAImuTwk5QBQSKSfCle+n0XXl1mLkA7pK5xQAvnvRSSgfAMIWtRfB49O/EmCf+ab+hZjnnx/FNhGfm733FkoDzAIdscs1bs82Ap9KqrvP70uDHbKxN8/9QXdriqRxvE7Kh7cvQtLvp+V++r7ET2qlWzkPv+H7OOKo7IBb2xvtY46steaDEpHWFRnfItQbXxUaTteYnqaCAeyMXYBeSut6fSOzikyuErG7gEIsDPBxSChyznHZHEWfHRfAwml64vzSWBQkFHc1MAO/tcteVinJYRFIv/ykZ59ESJQ==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by CC6PR02MB693146.namprd02.prod.outlook.com (2603:10b6:170:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 10:55:05 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 10:55:04 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Oliver Upton <oupton@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Khushit Shah <khushit.shah@nutanix.com>
Subject: [PATCH v1] arm64: errata: pass REVIDR when matching target implementation CPUs
Date: Mon, 31 Aug 2026 10:54:44 +0000
Message-ID: <20260831105444.4065831-1-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|CC6PR02MB693146:EE_
X-MS-Office365-Filtering-Correlation-Id: f0da797a-cdd1-4bb7-c0da-08df074e5037
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wircwWzDEBkt79KrklZsq3tFCQeO8GQ2dk2uZPEkkd2uKNx6U0waU2zJytAKKRb9SBIId4l645ihvMICbGDEEVjrVEMnvStWKY13tnd3Gfm5vKguE25942VqSxTmRF0rPAXiaHMwgHM2uEn2oPOVCuaWsuxMCFrTOZ+kPJtsg+QWIIHwImwo9y7809eM/uMCQvD5Na1VfAd5YqItmwQZ9AToK31/EYIbyRpTH9gCgQ0y4RWlpUyouo8eHupqx4+wuGaQbAaJ5bnssFpR1EGazGRboSZMOkiszieN2IxgYQe0n8d+aOyGyPRIGXI/LLUGZ5gXqfB3OH3rT1vCchu3r9K7iOZgHCQsTFfQgh5AgGp8QXhlbMQIbgNQNnu1h6qlnHK70l2M1YZup8iO4bTEOTgyn9+W1nilcCV2Cz53U7kbSMhjUcSJBDtYQdhyq6AdZ5WBBICo2pFDSKON+3Ry4ju9rE1Af1Re61GceSjcVAQDoZSRQogDhZHr0hFuQbbv8xeJ9hGiA72TNAp3pebuEU4EndNH/XEM4zUvvhqaBJT12Vb/CCKzBrItn1b0i2fxcYUwTp/oCpPKLssz9GCDQ94wmlqpYtJiLPmffb6p+hpJr2SjalNroT2ODfP99Rq1BKshIX8U5f6N72RTls0CUEUprA04d/E0z5rKi8v5vRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR02MB7564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNCOnmW8My7ZfgrZHr2QJZcruPTsGYF3oOzdzDq1OuigrHSYhoFjRK27IU0T?=
 =?us-ascii?Q?DZyESJBg6ib1sYCHg+pfzhNvUEsC9QOYokcPnnmqiPO04dNXpuqpDIY91zVh?=
 =?us-ascii?Q?nmRPs9Ao7PpSJD8oEU4eH2/FQckGQfuEQkh+rJGTf4Hw3Sf022gEnZCFc8GO?=
 =?us-ascii?Q?nRMKUBsN/TQf52lUl7WOOoB3xbWXR0qUdQMp6TDkaKly3l3j2aTXn7aYfL/i?=
 =?us-ascii?Q?sUEGymFpfUQz3I35vhMpM7u1f86K5ZqCxX6pEa6c0bKDvsclqBqCqLvzsiU+?=
 =?us-ascii?Q?/JVpMSVzONeATF6aqVN2ISQNkUN70bj50cf9FTxVZ3mv7sKyZsMi8jrmkhZJ?=
 =?us-ascii?Q?QwdQo3lSN89AJ2HDgsylSn+dU9IcQjhSgX/ZAwHUqn7uGslH+NioFL9w91ge?=
 =?us-ascii?Q?m58jlGxlpCgHEqPrZ4aGe1gfVhkyFmONkSnRcyuTm2qYpvaJIs0RzxQY3z0o?=
 =?us-ascii?Q?GbNBXhjBhaLa6Ia5TNkEv6bf3NtRB7NVLl2UNWZXj3AlyGGeSdRfAV8kH/Cx?=
 =?us-ascii?Q?bVM8pTHuu8lEJB8Hw1a0KV7/z+CpTICg/7oee7VjGZ5kG1Mn2XJiqKAVTdVe?=
 =?us-ascii?Q?eUlDkNt2Do5zCHqIh6MxAYgLal0aZoa0snrql/MdeNZDkkclbyJhUROertSg?=
 =?us-ascii?Q?gmvoW4VuntXPdVeHHnQRaoua5GOaNmo0eT+SKQafd6xo/o4n6Gg46QOuGP7J?=
 =?us-ascii?Q?a4fFWGKOjuEjNEmTAqnp8Eu41V0mRi/TOw5aPyew+dOjRGJ3UpvCqaBxI07n?=
 =?us-ascii?Q?Xi74qpljB9pWCMn3+V1aQgj4BzYPxh+1496ohHC0HsckXV/S7udEnl33z3Ze?=
 =?us-ascii?Q?wb7Fqe7YCTqw3/Ng4pfkRDqlLbO1wK0ziDKw9XC0fEtUd0Hl8CwDkwoXdVlL?=
 =?us-ascii?Q?0UfbVed3rozNx4Wbw01tP6t86716iS7ugecyIoGg1genjF1x/mJ9QS+AtpBX?=
 =?us-ascii?Q?LGH1n831iWQt8CKoOCzv8zpu2tjaCOQF9v6M7FsBTQ4yjmo7adqHN2zrq5Ti?=
 =?us-ascii?Q?TBsBgL/H37JxYRYXhFhlB2D+hd9n2fAZUcCgYDHpUKQoyLwHMaj/jdrQpK8Y?=
 =?us-ascii?Q?w1lbYT5MiwdhwSXT3VDvH3RQc6nUxm3MSgX10zi2CU4SuQOgk6R2KAV1Ss+Q?=
 =?us-ascii?Q?XJ9rcoiDE4WUot172TAIbX7eW8nSpv0/7Zu+VTExLwTKSvLLa6syr6bA7Xet?=
 =?us-ascii?Q?at+vSygjZ8lyyOuyXUh3xcqfBMbLY3CxjLlvuHeahtDa7Q0QtTemnHssBJxd?=
 =?us-ascii?Q?zBktzHgNzhDfcG/nqsr9cpzSsyLQS6Dl8mCg68KOq4bo8tohhInrCExEs7x5?=
 =?us-ascii?Q?5FsqKnOpKDKkly+QnjjmiGcLcQE36gJgrCGq9RKKO5sf5GjxGTW/fr8K4oFV?=
 =?us-ascii?Q?aTJK4V4JChUTgOlms9kkdhL9QIWdZTq2SSSq+hvxOVXS4OaHbi/48IJBBAhZ?=
 =?us-ascii?Q?++esQhwS3OlX/QN35DnH7ZZKhbgRUD10NCy6l1WPKbIgKd2M7BCTjIMqW3A+?=
 =?us-ascii?Q?Om8M5SMNWM+fniDzHqNogiJNCy8CQ6UbIhbdX2XTikrO1or22sfG2b4nWmUL?=
 =?us-ascii?Q?RGOh8xbbWdsSc4ibxhaDtZrsipICgCkWa3zQ4arjftFe4KBadeno8yB4F4tg?=
 =?us-ascii?Q?zffiidTpnJP8xpT7SiVRrJ7bVFOoS9Y/KVBGH+lfveZ5I/2InZhDTSWmChQC?=
 =?us-ascii?Q?CxIaXsdQxaNMz6mZNo1TkNvfxTRZKX0n3+jl2sVAEnVF8eE6U4USLRGVudm0?=
 =?us-ascii?Q?P9oGdzQYZ8rYqanYTULua9dwqt6acjk=3D?=
X-Exchange-RoutingPolicyChecked:
	B0rFsmh8U/5NcQI5rXYA+0Zj46BwPgdvVEvzpwHPZvCGunJX3DsplRcS0lTVL8KjHZhsmEldFkNe5iX9Os6EjL6p9uR2OuVUwAouDKyRVAIZBbpDZQcKNxlowowAfja/HlGmIVoTEN99ktUaTHnEXAFDUAB/5ivAqrI0qIyE1V+dfsoZbMYRQWbSoHcFPP/zXXSklyfRrIdZyp9szex+uU2DXZXKKcj/w6PhlldvNT5xTyOIzdsQaRdBbvHchgG7n2amJ26lYwTToA7kNlAdn8OObi4HJsfXUw+oBxzpZCeOPgPnYxTifSWDLtGILX/7PxYa2OU087EKhWK7dAKD2Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0da797a-cdd1-4bb7-c0da-08df074e5037
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:55:04.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivFO/XTwbMw+iVprBCmyS3L/McPdW57Vcb5D/x7hUYPSTb5OD6altiwg2nywuVqU3fKX3V3MN8I4AX9WJ8SIVXeY3Nh30EhLFFERpaVBVho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR02MB693146
X-Proofpoint-ORIG-GUID: cNOUON-CJtPkmewtdFAulpOdcL4bq19B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MyBTYWx0ZWRfXxpiGY3+/5RNr
 OLupFVxNCxAMbb0DIwYyfvCvW4lzwlfvwI2V3BRSStUxMq0/UaaFrh/r/2yWa1KeV4XoroE0U45
 JoZ9rrRDI0EWf6zn+YtI+R/C1YOalDc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MyBTYWx0ZWRfX1DMfBh9x00NY
 Y9hUHGAWNYE6RambIenSD1B7Wj5Hd6Uwi+ILhaXq1YWdiCRcWE30YjJW8AQ9rSV6Cq3HAwZzX9M
 L3/grBSISNGomGX2JVnbJG8TCUFF/m34QdjzblHX50VvhhgoHhh6/tw9ARpSi1ZnNzEBvPxKOq7
 u0rAHBjAZIXmE028ptEbynuyo9eE5+gp9Fd0skx2T9rixboVVIJYlnwiiiaMsD4FW+1+Fj1RJeB
 k2FBDQAtL2bO9Hkc2h8yBelPFTIm3gf0P2k1ASQNdXN457OT0uoGZSDb/9ydcPrl4v3jyb4YRMG
 teIK+uKKbWVpcvQER6wYtsGf/hAQm2MyIXYr05spufiY8W2vPdUCWtZn+p1PLkB7ftE20fyriaJ
 2zxQ4+KxhcMpi46345oKqPLG2r5dtX2L0oy/+OxR/uT+Uy/7SOKmIHcobPHzRPDtSLHEvl7Pwgv
 TPlAei8j3ohc8/8s1gQ==
X-Proofpoint-GUID: cNOUON-CJtPkmewtdFAulpOdcL4bq19B
X-Authority-Analysis: v=2.4 cv=eZANubEH c=1 sm=1 tr=0 ts=6a955d8b cx=c_pps
 a=TfrkMYnKeonxmUhmTT/BLQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=dW5WgIYIdMNkTvJjAuoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

When target implementation CPUs are provided, is_affected_midr_range()
accidentally passed the MIDR as both arguments to __is_affected_midr_range(),
so the REVIDR mask check operated on the wrong register.

Pass REVIDR as intended.

Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on implementation CPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 arch/arm64/kernel/cpu_errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 5db8f0619e4b..b33dccfafaf8 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -82,7 +82,7 @@ is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
 
 	for (i = 0; i < target_impl_cpu_num; i++) {
 		if (__is_affected_midr_range(entry, target_impl_cpus[i].midr,
-					     target_impl_cpus[i].midr))
+					     target_impl_cpus[i].revidr))
 			return true;
 	}
 	return false;
-- 
2.39.3

