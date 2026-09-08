Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503A3EB108;
	Tue,  8 Sep 2026 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855623; cv=fail; b=EG8//U8JWbxGbAcdzkhQHSa2ssd08kf7CBXMsWhqhe90Sl6eFcltwYO8xRUc81xJRun4ACvMgW4ZjLmKxQW7+7I3mA9BSe9bRR/hpEf0pa1W7xhFEXSMUQiYzfS89txleDlny7YOy0aZEbHLqmQHENQkjNdnETdCyA0QyFgxJ00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855623; c=relaxed/simple;
	bh=Bj+3UaTLswBu1uuUmUEs+8wxkAfbC+3OrWZUiXM7g0I=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=AVCF6jJG8M2HVCxRx+B7UirzaiC5nvvnwwIrU4qJUPNYas0zOvEjzF+WiWLhHeT+Kdl5ITggNeHi40CJWRxDymGML9K85wa02ZnU95t9P8+8QI7ElqJtmDXJeqAeYME7JEhhsFVjTfr72vwNDg5dzTeuz3098jTkta4ta8lpo+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=HV1kXMfT; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=W/z/lzwo; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="HV1kXMfT";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="W/z/lzwo"
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886S26n3114748;
	Tue, 8 Sep 2026 10:20:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	270620241; bh=Yllmo4Ufa+GSuhuZr7sRnBsdWktSH5Uf+h1Tlnz+7vM=; b=HV
	1kXMfTR7vME+XVYTwB6l0j7+85Pe+KfFDyn07H9JrRp1pDRF5sJu72FCRf9cRSV7
	s/8szj/ToJzUBUIPzWb9ZhvBUDKEl4Ryf/h8YNm+1tV63FiQbAFrYkEJ2wF83TDw
	wsB3UsLMese6f+RXCYkYw3+LcUhb/WB4DcgUiKQTo1qXmGYNLyy1Qh3MiLLLfMrf
	OePBImwwvlHLufo/VU5nhxmk0gMj/oSqS2d8X6Ph01/Wktd10mNgFbVtl9VKA4Ur
	bMR/GWtPK8PWTDvybjCJDoS/T9fsAx3jNwlvOJL+QDnUVTzxT2lvVfe6ezEEFFdg
	m/HzWO4sJ8NLXCV7sZJw==
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11021076.outbound.protection.outlook.com [52.101.65.76])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 4gjd3r8402-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 10:20:06 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC9ocfXUqKtgNufbqqU2dwfWtWyAYTqnV0T16YgRh0Ag6wRnu8cSPoFYyEFP7EEQPW94p2ZyI3iQDRjxd+U9JCBG4vfetbtOCyzGS0VwWbWpXUtI65+mBYwFw4jTW+vSety+bxenfppeLIiPoWmvBNXmfC23tXVqmt9+bPmlmj6o/k94PP+2+M9xWhgY632IcDiFW6qp54ywIcDQMR8Fe8hE+L50NFaMRBCs6Pnt5STjcStbn9/XTldKngBkoNsnhbbHMBsi8W84maDmOXHlbg5bjTWTOsVdm5l0rsLLKT2gNNEb2qeQFZVXuDkQKncHcQU9FEtbifwRx97OPKRPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yllmo4Ufa+GSuhuZr7sRnBsdWktSH5Uf+h1Tlnz+7vM=;
 b=tQFlekoreLHKltAcgPrAnN4WHRhTZzyRW9ENWOWjCU8m8Tww2yw+65Cw2Peg7jgXqHQd3lr27weO5VXgD3s7MzcvMdYWjmaoSVXHBAZiQRsKMKNywvUpVZ5ByBeR+iGrndhINjGGGBo5R5rO88NHSQgAzK012bH/k04hQZFjFrcm+IfcPbLtFCmZQxn3zXlsTZMrc1K29Y7fHxCkEggOXlA6enLQNJ2kANhul79FJYXX0oFdDKdlWtkuE3vNMXBSl4926eDiCdsMW8eFJzqiEDin+vYj5BIGom4uGJf1we3buiqYJMHpj5oEWB9SF9QjjpFUygtmUnrvjPb0RDPtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yllmo4Ufa+GSuhuZr7sRnBsdWktSH5Uf+h1Tlnz+7vM=;
 b=W/z/lzwoqw/Fi2lHxs4jxNZ6V4fjhfIq9XrsrY88Z1TVC+1IW6tvSwuKVCUzEfEAdv9XssTLyYhbePC7Wg0oO3I2DqHBux5UJzaYsf1WrfvJWDt3W3He2GWNpN778CKh30q9rSO6dRt4R/lrRGdfGRTset1+y7oXVecFF/VpPi0=
Received: from PA3P192MB2868.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d7::12)
 by ZR6P192MB935545.EURP192.PROD.OUTLOOK.COM (2603:10a6:910:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:20:04 +0000
Received: from PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
 ([fe80::bd96:8c85:982d:19ce]) by PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
 ([fe80::bd96:8c85:982d:19ce%4]) with mapi id 15.21.0360.008; Tue, 8 Sep 2026
 08:20:04 +0000
Date: Tue, 8 Sep 2026 10:19:55 +0200
From: Michael Pfeifroth <micpf@westermo.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org
Subject: [PATCH 6.12.y] tcp: fix potential race in tcp_v6_syn_recv_sock()
Message-ID: <ap/FK8NXnWtBZFDs@mpf-ESPRIMO-P9012>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: GVYP280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::27) To PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:4d7::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3P192MB2868:EE_|ZR6P192MB935545:EE_
X-MS-Office365-Filtering-Correlation-Id: b317424e-23b0-4fe2-3ebc-08df0d81fc2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	9BxzOYLKqPtabHrEiHAqWBKSG58Cs11r7dc+sUM0mSH8jzAAhVhqipp/BSzYy23fJzhqS9Ofq5EeDdYbjClq2Xj332rvKRhziX6+HpDsCNonLi2lg4CjHM7KFMwRguecKj3F6QGGea+khFqSf6FPuSrwpQyxphc/+3caQCegd3AtY2szurcbrOlgzWDxWgts5oK+amL3sQ/Im+CR9FM9gOT/dMcjD7Rj04FkJSALIhqZvLxnJ5hWq0GnIJ4xHN13jNIIOnSZ1OmQ/YRXGWfBR3Nsw5w1cMdjZJ+m5AygMegxOy7mWh8HX4xvP3qV8jx7elvw7t7lbIInCM/URZNs87RfXl7+SWqckXJh/HltVOjsho/HKnXmM3Nt3A0aScfUl0fAirpXN7z0IQlhktAREr9jrndCXl5gCvzx8hdFtooJGiLtOi/1OXt9W06C9hI7YEMjRKEzO2/ik9PdObWRiyoMV6sX9GcU1kVJ8My8DIbV533DX2Svfj4b3XEe0xgFz7oiDsSZRixZ6awitii1UifGeQB9qb3hjxGmE6lKnNU0UW4qA7antsjVoCp/BIuJj8W715XwN55KEBZURApRPMn1XWZIAhtGoROUunPo6Hi5X9kJYbfDMgmVm8dL/I5AOprM/N0BmTeFHPEbRxlUwjqApWFN/6qsL2lteiPUTT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3P192MB2868.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YtUhCWDJSCnFb0YU2BduAeWS7fwjNCIYtmVEfAZzEWBCFBfbZZcG1TR+CwU?=
 =?us-ascii?Q?6S6lJDG6Pt5Z/gtFSUV/rFugrsZQml/zeQUQUc9+6fqe05srUQxTo/+0CPE9?=
 =?us-ascii?Q?8fTs9Shn8kyc8/f1OlzMED1LfFr1pyo0AqO5Mvs1/9+scF1cAdg1zW0s3J+K?=
 =?us-ascii?Q?eEMx6Nk57Y77ZRJomnbcKlvAbgbexJqc2RLGWmmLECG2Y/Fmz18vhQdu6I+T?=
 =?us-ascii?Q?noib6bOhcG6/tUKDiyLcs1fEfG04p6W6C3aqspBGFNyK1QUWNkfFLB8Neq/d?=
 =?us-ascii?Q?ACEwfjpT3RUGEJh76TR77GuaZkkVBSYz5/mdZjgEzTDOViJMZoJk+1IMFoQK?=
 =?us-ascii?Q?KiXL5GubKIjkV3M7A6R6iPGmRoxwapq6tNGUhwdyKcplvyp/jRtCLatWSM7J?=
 =?us-ascii?Q?zlKG2qwrpfTNVmQnNE5uoPrGxiszV20Gae3fC0VMUqG5YAAvShsV/wWM1E/C?=
 =?us-ascii?Q?b+aXOGWxqwU89dZMerM32hchL7I5FIdpmnWMm3wW+9wya0oLSFwkJxOlsJh6?=
 =?us-ascii?Q?UCaBA9ER4Whb4ndo0wkxljEHJL/wER+AePp9v0NtjQ1Y8SIwLyc3I4t6JZS5?=
 =?us-ascii?Q?dax4FRoAg+8yC6IRusOJuDs6hg2x+2a0LYi22pYZUE+0UXNRtImPVLhED5Nw?=
 =?us-ascii?Q?Zra1fYg183CLCxG+++trqZbAu5kjPvjOjpPEkY4RKbzyY19gk59jFJzdvTjE?=
 =?us-ascii?Q?JZkf/a6a3OaA1z72BihI9KY3I6SQnoVwPZYB1o7UPIDCO9oqRdkYY+JtzkH5?=
 =?us-ascii?Q?lm0wfm3cx6QFbeJYxsx51kYPv7xhL3iHeQM/fbCpDDKVrisXDSNte8JvaXUX?=
 =?us-ascii?Q?loiMvbfkKkBaIG5jHU6PN2wLjfDAHb14K+SRwfa1aaJJ7nHXQZXHupMfyqTP?=
 =?us-ascii?Q?GJcvgldM0QA2qUSicfLzz7FLmWbbnJ3YQmulIWnuomv7hEeVe+zVgakeCExd?=
 =?us-ascii?Q?W5/+sy1FitLb2SIiLwiNnB16POG8aNDrY/EdVCK7FP9t289F1zAg3EEwsUyc?=
 =?us-ascii?Q?5SEMqjfPLWhfbEjodrtb3SUF5cbEMrFhvOeGk0H2+Xcz2ex/8zZ/f2Y42PJY?=
 =?us-ascii?Q?OOUMb3eamDZk2bjoAMA9D22PvXYZSUw7dLLpr7tt8wV73QVAWaG6ZA9Fmt1X?=
 =?us-ascii?Q?7qT7Vsv8liKvfSMHZDsUkNzQbcGWGPNmcB1aNZINFb9JU9sBd0WecFgDibaH?=
 =?us-ascii?Q?lDflSm/PxQRtxEcB6J0XqWmo3bZtcJEKxaKMH68/RfVyx48o4FwYc3oSwzlJ?=
 =?us-ascii?Q?qLow60CmjMBOQvNKtijBVm8Sd7mF0AD+Kd0jlhAGk1QSW5JIxjROjkQSD9vp?=
 =?us-ascii?Q?LVDdDN/Dy78/tM3QuP2X9pjfB4DEP+LPT4YD2shwZe0y7lZNvNLxlqGxEyuR?=
 =?us-ascii?Q?4uEqIipPWCrEIaCc2+Ov5hog1MAprcHSh5rqiYKemj5xYvz7zrWH+zRqdoT4?=
 =?us-ascii?Q?gDubDix2RIcek7y9tRL+yUu0JwAc2iU9st9r46IzHb+bz3CIdk3BZ2Uj4UTH?=
 =?us-ascii?Q?Sc0AUs9+VyaCAy90qS6mEVZwXqbqm+xj4vCfRcE0e1VPpZFfNbZzM3Yd8aDy?=
 =?us-ascii?Q?ZRszYJG70atYWX1zFUPpI6G3mniKNPQJnWE9PKAJ4bv/JdNsV6XO7EKx7KnE?=
 =?us-ascii?Q?Jtj/SHt28xlKLwG+kDswb8WTIcjeWOBXCO3oVHXwGMnIw8s6r4QtkCGO61qv?=
 =?us-ascii?Q?1EDfIkZ+FAo5Oz/X97Jpw9TpoeaTRPF0eom+t7J2znlQQB5GE20qu07BisLO?=
 =?us-ascii?Q?mD0irDKI5g=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	T8lPDbTORO6z6uqSpFrR3//9UbDNNUAgAsMrUaSOlnPYKkrvTy0UCYgE4IlGJhzHLut5gqi3LwDwkM97UnWguXRTOWqpn7sNFlPjgbWhr3lt94Q6+Y7AO77+ME+5f/Iv2hzQHo8ibuDnJ9mE14eE1vMXtfWT3Z6W+vFA+E3rUaAUt8eklle4xeHP0b2YKZ1h7rlTrZ1wq3bwswCecL8rvDQO265dQ+m8Kj/PAKKu2om6GKnCUOn2nvfWP6Q8Mayopgu5D3X4dTa5xVfWb0K9ztZ1lSyO4jru5jCeF8Aau1M8xfr38JIYE60K0LBi36L4wlaaGey1Ux1Egj7/WLgmGA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KwK8NIW1hvfwrkXd+o2WX7YDgHeMQKc10zvyBA00ecxEo7/0JY6vW2lD3CI04Hr2wKmT+yKFr40Tbq9XvwIiq5MVML1rWXJ2Do7aam2IzazwZS1K3URD96yWHUBlEcxkWph61Zz3//ZvsSbSi54y//DhnkG2K2S6w60gaHgigtdxkU1tM2AvjqC2mIvcfi8VHwR3739x/3j/MyCKo+OGcPGNJVfZdYItfxJF+GWrjTKgUYDqEV2U7Sd+rfMBqNen7O+6Ry4WtzRIzbqGOG3ClVI9tGPsZtVPpuXIjuYRT6lkXk9ivuVTN43lH8QD8A26DszU/OsEMcpINplSP6Tun+s3cO17ZFTBA7jNsBt25mPfmCtsGTmmI1rR5r8Yd/5BApM4MuEnJPcnTdFxO7mCyUHqOAiPDjM7ifXJ50dzehOl/qfAgqxUlAjlWz/s3XZgf4uQoOV99kgfx9/SY+0rVJcwiwanPjFJdNG/0P3Vdb1+CLhL6kegQXYqTRG8DbsKKe4hEi20RvPA8Ja/EoFxgLXko+eBsBqKJfECXPkOVwEsU0/r9UVjWlVXgNElW2A3HNczKTcM/Iae2ivS/q9TwJHrZnlZvGvLWcy4rH2qFio8DjacxHNfWvmuFZoa1ofV
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b317424e-23b0-4fe2-3ebc-08df0d81fc2b
X-MS-Exchange-CrossTenant-AuthSource: PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:20:04.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajFx2A4TF1VHHzv4dMy3Ss945CFloCuN09UHc3GEJ2CyiQR+E4t4s6heYhTaS1UrNVWYp5fNHta0yBzxX5BHaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6P192MB935545
X-MS-Exchange-CrossPremises-AuthSource: PA3P192MB2868.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: ZR6P192MB935545.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4NSBTYWx0ZWRfX8WhFaattrIJd
 ZjZxQnbxKw4ATQzzXrkWxxRliXjH3i7DPwq+vZUSXqZC+S0xNclUdhkB8cdTNgl+7u04WPDnot8
 81COzgxOgoPLSjGNx27xnw/FmzE5wPI=
X-Proofpoint-GUID: 78-CC5hbNH_7S7R8R1Z0e4Pz0kQcnlQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4NSBTYWx0ZWRfX5MiFPaqwdJ45
 TpuMUeL3RveaV5MyUOGtUd+sBh4N3DIOn0E5P48xB3wT0YZyDkzEAdSnMD1sN3vAjTJhQzV6tFK
 GlLCeqpJ7U+LgvPjoi8UY7qeho2oS/uzfl8R2SgCFRlIAYU9Cd+gsLGY6DbRZvSWw/47uH8bVQn
 dcMtRF3J2HZhrElOKHAwyRXo3aYbgSRWdinvCZme1KGFetscd4XdMHfYCuk28J05opYAUkrht5Y
 wD4V5rOIKA84eiH6nBaVQ/LTZrUg2H1oBdO33OtarKoZREuYC9PY9YEfe/xZhaOHI9IwXjiUmkM
 EfqNjg9Itwc3eu/NQgqpiE9wJfb1oF3arZON5tH81sSbyl3ys7vkEmiwTIPDlaiYFlLmtW8j97v
 +Q4I4pDG8AM6yNQX7P4dcUae2fTJTSpQ3RTUOL5KMMNj5cwQ5eNAANCNndcCIAc8t1itlrIBvYO
 soEY9YOcIUPYYVjcCvw==
X-Authority-Analysis: v=2.4 cv=S4nRUosP c=1 sm=1 tr=0 ts=6a9fc536 cx=c_pps
 a=5yo4gTqKlo/l2WGmbt5Y4Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=8gLI3H-aZtYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tr3XZvuDWTETL0Uaxejn:22 a=WQ4YJ39tjzx_Hbm9pN5v:22
 a=hSkVLCK3AAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=N9GNhs4bAAAA:8
 a=tJmNqNUn_Fm3tCaVaUgA:9 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-ORIG-GUID: 78-CC5hbNH_7S7R8R1Z0e4Pz0kQcnlQx

[ Upstream commit 858d2a4f67ff69e645a43487ef7ea7f28f06deae ]

Code in tcp_v6_syn_recv_sock() after the call to tcp_v4_syn_recv_sock()
is done too late.

After tcp_v4_syn_recv_sock(), the child socket is already visible
from TCP ehash table and other cpus might use it.

Since newinet->pinet6 is still pointing to the listener ipv6_pinfo
bad things can happen as syzbot found.

Move the problematic code in tcp_v6_mapped_child_init()
and call this new helper from tcp_v4_syn_recv_sock() before
the ehash insertion.

This allows the removal of one tcp_sync_mss(), since
tcp_v4_syn_recv_sock() will call it with the correct
context.

Backport notes (6.12.y):
  The mainline commit does not apply cleanly to 6.12 because
  ipv6_fl_list was later moved from struct ipv6_pinfo into
  struct inet_sock. On 6.12 ipv6_fl_list still lives inside
  ipv6_pinfo, so the memcpy of the parent ipv6_pinfo into the
  child covers it, and the new helper must therefore keep the
  ipv6_fl_list initialization in the post-memcpy block (as done
  here). No other logic changes.

  CVE-2026-43198

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+937b5bbb6a815b3e5d0b@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[mpf: backport to 6.12.y; keep ipv6_fl_list initialization in the
      post-memcpy block since ipv6_fl_list still lives in struct
      ipv6_pinfo on 6.12 (mainline moved it into struct inet_sock
      after 6.12)]
Signed-off-by: Michael Pfeifroth <michael.pfeifroth@westermo.com>
---
Index: b/include/net/inet_connection_sock.h
===================================================================
--- a/include/net/inet_connection_sock.h	2026-07-04 13:42:28.000000000 +0200
+++ b/include/net/inet_connection_sock.h	2026-08-03 11:15:50.785059353 +0200
@@ -42,7 +42,9 @@ struct inet_connection_sock_af_ops {
 				      struct request_sock *req,
 				      struct dst_entry *dst,
 				      struct request_sock *req_unhash,
-				      bool *own_req);
+				      bool *own_req,
+				      void (*opt_child_init)(struct sock *newsk,
+							     const struct sock *sk));
 	u16	    net_header_len;
 	u16	    net_frag_header_len;
 	u16	    sockaddr_len;
Index: b/include/net/tcp.h
===================================================================
--- a/include/net/tcp.h	2026-08-03 11:15:41.286991513 +0200
+++ b/include/net/tcp.h	2026-08-03 11:15:50.789059382 +0200
@@ -460,7 +460,9 @@ struct sock *tcp_v4_syn_recv_sock(const
 				  struct request_sock *req,
 				  struct dst_entry *dst,
 				  struct request_sock *req_unhash,
-				  bool *own_req);
+				  bool *own_req,
+				  void (*opt_child_init)(struct sock *newsk,
+							 const struct sock *sk));
 int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
 int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int tcp_connect(struct sock *sk);
Index: b/net/ipv4/syncookies.c
===================================================================
--- a/net/ipv4/syncookies.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/ipv4/syncookies.c	2026-08-03 11:15:50.792059404 +0200
@@ -199,7 +199,7 @@ struct sock *tcp_get_cookie_sock(struct
 	bool own_req;
 
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
-						 NULL, &own_req);
+						 NULL, &own_req, NULL);
 	if (child) {
 		refcount_set(&req->rsk_refcnt, 1);
 		tcp_sk(child)->tsoffset = tsoff;
Index: b/net/ipv4/tcp_fastopen.c
===================================================================
--- a/net/ipv4/tcp_fastopen.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/ipv4/tcp_fastopen.c	2026-08-03 11:15:50.795059426 +0200
@@ -247,7 +247,7 @@ static struct sock *tcp_fastopen_create_
 	bool own_req;
 
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 NULL, &own_req);
+							 NULL, &own_req, NULL);
 	if (!child)
 		return NULL;
 
Index: b/net/ipv4/tcp_ipv4.c
===================================================================
--- a/net/ipv4/tcp_ipv4.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/ipv4/tcp_ipv4.c	2026-08-03 11:15:50.799059455 +0200
@@ -1564,7 +1564,9 @@ struct sock *tcp_v4_syn_recv_sock(const
 				  struct request_sock *req,
 				  struct dst_entry *dst,
 				  struct request_sock *req_unhash,
-				  bool *own_req)
+				  bool *own_req,
+				  void (*opt_child_init)(struct sock *newsk,
+							 const struct sock *sk))
 {
 	struct inet_request_sock *ireq;
 	bool found_dup_sk = false;
@@ -1620,6 +1622,10 @@ struct sock *tcp_v4_syn_recv_sock(const
 	}
 	sk_setup_caps(newsk, dst);
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (opt_child_init)
+		opt_child_init(newsk, sk);
+#endif
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst_mtu(dst));
Index: b/net/ipv4/tcp_minisocks.c
===================================================================
--- a/net/ipv4/tcp_minisocks.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/ipv4/tcp_minisocks.c	2026-08-03 11:15:50.802059477 +0200
@@ -798,7 +798,7 @@ struct sock *tcp_check_req(struct sock *
 	 * socket is created, wait for troubles.
 	 */
 	child = inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
-							 req, &own_req);
+							 req, &own_req, NULL);
 	if (!child)
 		goto listen_overflow;
 
Index: b/net/ipv6/tcp_ipv6.c
===================================================================
--- a/net/ipv6/tcp_ipv6.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/ipv6/tcp_ipv6.c	2026-08-03 11:16:23.691310616 +0200
@@ -1186,11 +1186,48 @@ static void tcp_v6_restore_cb(struct sk_
 		sizeof(struct inet6_skb_parm));
 }
 
+/* Called from tcp_v4_syn_recv_sock() for v6_mapped children. */
+static void tcp_v6_mapped_child_init(struct sock *newsk, const struct sock *sk)
+{
+	struct inet_sock *newinet = inet_sk(newsk);
+	struct ipv6_pinfo *newnp;
+
+	newinet->pinet6 = newnp = tcp_inet6_sk(newsk);
+
+	memcpy(newnp, tcp_inet6_sk(sk), sizeof(struct ipv6_pinfo));
+
+	newnp->saddr = newsk->sk_v6_rcv_saddr;
+
+	inet_csk(newsk)->icsk_af_ops = &ipv6_mapped;
+	if (sk_is_mptcp(newsk))
+		mptcpv6_handle_mapped(newsk, true);
+	newsk->sk_backlog_rcv = tcp_v4_do_rcv;
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+	tcp_sk(newsk)->af_specific = &tcp_sock_ipv6_mapped_specific;
+#endif
+
+	newnp->ipv6_mc_list = NULL;
+	newnp->ipv6_ac_list = NULL;
+	newnp->ipv6_fl_list = NULL;
+	newnp->pktoptions  = NULL;
+	newnp->opt	   = NULL;
+
+	/* tcp_v4_syn_recv_sock() has initialized newinet->mc_{index,ttl} */
+	newnp->mcast_oif   = newinet->mc_index;
+	newnp->mcast_hops  = newinet->mc_ttl;
+
+	newnp->rcv_flowinfo = 0;
+	if (inet6_test_bit(REPFLOW, sk))
+		newnp->flow_label = 0;
+}
+
 static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 					 struct request_sock *req,
 					 struct dst_entry *dst,
 					 struct request_sock *req_unhash,
-					 bool *own_req)
+					 bool *own_req,
+					 void (*opt_child_init)(struct sock *newsk,
+								const struct sock *sk))
 {
 	struct inet_request_sock *ireq;
 	struct ipv6_pinfo *newnp;
@@ -1206,59 +1243,10 @@ static struct sock *tcp_v6_syn_recv_sock
 #endif
 	struct flowi6 fl6;
 
-	if (skb->protocol == htons(ETH_P_IP)) {
-		/*
-		 *	v6 mapped
-		 */
-
-		newsk = tcp_v4_syn_recv_sock(sk, skb, req, dst,
-					     req_unhash, own_req);
-
-		if (!newsk)
-			return NULL;
-
-		inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
-
-		newnp = tcp_inet6_sk(newsk);
-		newtp = tcp_sk(newsk);
-
-		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
-
-		newnp->saddr = newsk->sk_v6_rcv_saddr;
-
-		inet_csk(newsk)->icsk_af_ops = &ipv6_mapped;
-		if (sk_is_mptcp(newsk))
-			mptcpv6_handle_mapped(newsk, true);
-		newsk->sk_backlog_rcv = tcp_v4_do_rcv;
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-		newtp->af_specific = &tcp_sock_ipv6_mapped_specific;
-#endif
-
-		newnp->ipv6_mc_list = NULL;
-		newnp->ipv6_ac_list = NULL;
-		newnp->ipv6_fl_list = NULL;
-		newnp->pktoptions  = NULL;
-		newnp->opt	   = NULL;
-		newnp->mcast_oif   = inet_iif(skb);
-		newnp->mcast_hops  = ip_hdr(skb)->ttl;
-		newnp->rcv_flowinfo = 0;
-		if (inet6_test_bit(REPFLOW, sk))
-			newnp->flow_label = 0;
-
-		/*
-		 * No need to charge this sock to the relevant IPv6 refcnt debug socks count
-		 * here, tcp_create_openreq_child now does this for us, see the comment in
-		 * that function for the gory details. -acme
-		 */
-
-		/* It is tricky place. Until this moment IPv4 tcp
-		   worked with IPv6 icsk.icsk_af_ops.
-		   Sync it now.
-		 */
-		tcp_sync_mss(newsk, inet_csk(newsk)->icsk_pmtu_cookie);
-
-		return newsk;
-	}
+	if (skb->protocol == htons(ETH_P_IP))
+		return tcp_v4_syn_recv_sock(sk, skb, req, dst,
+					    req_unhash, own_req,
+					    tcp_v6_mapped_child_init);
 
 	ireq = inet_rsk(req);
 
Index: b/net/mptcp/subflow.c
===================================================================
--- a/net/mptcp/subflow.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/mptcp/subflow.c	2026-08-03 11:15:50.805059498 +0200
@@ -788,7 +788,9 @@ static struct sock *subflow_syn_recv_soc
 					  struct request_sock *req,
 					  struct dst_entry *dst,
 					  struct request_sock *req_unhash,
-					  bool *own_req)
+					  bool *own_req,
+					  void (*opt_child_init)(struct sock *newsk,
+								 const struct sock *sk))
 {
 	struct mptcp_subflow_context *listener = mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
@@ -834,7 +836,7 @@ static struct sock *subflow_syn_recv_soc
 
 create_child:
 	child = listener->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
-						     req_unhash, own_req);
+						     req_unhash, own_req, opt_child_init);
 
 	if (child && *own_req) {
 		struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(child);
Index: b/net/smc/af_smc.c
===================================================================
--- a/net/smc/af_smc.c	2026-07-04 13:42:28.000000000 +0200
+++ b/net/smc/af_smc.c	2026-08-03 11:15:50.809059527 +0200
@@ -119,7 +119,9 @@ static struct sock *smc_tcp_syn_recv_soc
 					  struct request_sock *req,
 					  struct dst_entry *dst,
 					  struct request_sock *req_unhash,
-					  bool *own_req)
+					  bool *own_req,
+					  void (*opt_child_init)(struct sock *newsk,
+								 const struct sock *sk))
 {
 	struct smc_sock *smc;
 	struct sock *child;
@@ -144,7 +146,7 @@ static struct sock *smc_tcp_syn_recv_soc
 
 	/* passthrough to original syn recv sock fct */
 	child = smc->ori_af_ops->syn_recv_sock(sk, skb, req, dst, req_unhash,
-					       own_req);
+					       own_req, opt_child_init);
 	/* child must not inherit smc or its ops */
 	if (child) {
 		rcu_assign_sk_user_data(child, NULL);
