Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795688967;
	b=YAGksOwdXr55dfLP0cdj6xS59p6d5mpmM4AG80d3wEFcDCm9+wfR+w/n7L7YCnIVmzz0
	 Jp4fNwZ9TtAzBT4pvroi8H3bLZ+nHvJu3ijCCy6cq1rEa0b3M8WE7GYxnR2oytPBdipcy
	 TGOom4lXk6UDcCb3cqIMh87nJsQaxpirWcaSgNyEQFLfGNyiNRsbHwgA105yWVBNqX6/J
	 Ivynejj9OH+nB00O4yqFkVuPyEKD+X0wt1NgrfgtVS52dClt7K+YwZTfcU5zfsRg4Fzs7
	 eNkL3JpsFBF0cexyyl6vHFgl3Xock6CSS8gIjH2EodyqcFH14aOkrY1MRexsyJhDs0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688967;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=R33yX9nAn5ueo+L3PguTyNu2G67OUvgyjUIQeSdgidg=;
	b=WEi3bGljmqZgUYnGo2Utza7JGVa6w2BZVpkJAcJa6bVUje6w9f5Lc3ObE+6pb13bX2SF
	 3dDeMbn0nuuLtfGAQGSM9Y9FFv4U0Zlz/7XKqCoGwoNoOrTK8txzqfZ5BtvujHQJkvF/p
	 DfiTamJgbXKXjeD33GCYVrb/VSg2RdLeYckp8f8xUy0qpjTp3B/aFa+e8cC6bEQLJQodf
	 gufqqyFsQHQ+HsOfW4bBf12nDv98XhiieIbj68B2YwZ8tNoFQ49IlvtQ1H5Imu8462CiD
	 V+wpG6O4wtMQInT3/OV9nYfWeZDa6StlOiKnpaj3hk9qqcAocgQ+qdcSrhMPBKVNrhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pKXmeBso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.8
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071C606A333;
	Thu, 26 Nov 2026 10:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7071C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pKXmeBso
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pza/7E5APAD/7A9vtNvAlVtIQMGMQdhV96/2YZiovR7yoiTTV0GV3XlF/U/Q0ajbZZ0qRO3eolToOyyAh1eHq/yjal+6K1ZjBi3qhZl+rmFG9xZ1dOSlor3HqKDKC9LhF3tns8T2QYrMuMvpsoQQ4ED+KhXeRoAZN4/mcUA/4eJx1nPsl3MynJT3tlKQ97bOGAA1Am/yHsdhL5A7+4q8F/OVZznH6HMfoyjNgZ/uap4sdxGR19i+Tmu7iQ3uzPkDFgGrh3ACiM+IyE4Ig2Uh67S36l+7Cu3wcg3tcQV50wA5IABYQRjl5AcwEbgwxVg5BuhH9YofaOKC9bUMqbd0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R33yX9nAn5ueo+L3PguTyNu2G67OUvgyjUIQeSdgidg=;
 b=aukYxJbflcelnufB/So7ApG+m5LKX+Vax3P0iwyRf5RxUq4+pe+m1mTg4/caEQgNOTcAvZQzZOVN9zo80Q57BHc8l5+oLfh9/P6pXz8sK8acUwtaz+64oQT/Ne/rCQ/B+ZUv5UsKur+JDpgJPixUodVT2kOR8LtONs0MUfZv/a+v9PbLfZGch9rg5c+EgWmAn9Zl6NiVHykypguZ+DqM90rzqO/DLgYnSL65GgNUPLIKRt5pcUwN4XvE1bvlC49Tjmbz7xDm1cCIjUWUBbwFiZ2ZAK2Hzq9VORM6jVAg4LuO1YhYMu/IfnQ1inOWomXikIJk4DWIQynkZ5n3dsGwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R33yX9nAn5ueo+L3PguTyNu2G67OUvgyjUIQeSdgidg=;
 b=pKXmeBsoKHnRwksQWshfs4C3ssuNIiAoieCtpln3cvLbP4ySydgL/ja+gzL+fp7u8LpVSs4IkfprPrG7P7Es0fInnN8iQC3O6dms0QwUMzhhGWrQs6pSkvEjuzWo/F0CvUvaAOBtgxySK9PADSSAStOxWP/1YxY/L3CJjQpSXcBoyDTPf0MUQVVBbvOkl60byKBR+Qy0FHxqJktz3/dVs6erNN9EYd4dUeH3BnmnugX+n0lR0bKO/VtiNdn16FLn3R2rK6EqqzO10yd3o+xnm7t38Zbq0udS4ETKSlFOfE5BoI81+UOz+Uae0jlLBhWqXxhEmogQKcRp0+sYjMdxOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 10:27:19 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 10:27:19 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject:
 Re: [PATCH 2/2] thermal/drivers/tegra: Avoid SOC_THERM calculation overflow
 on Tegra114
Date: Thu, 26 Nov 2026 19:27:14 +0900
Message-ID: <jzsqrUIsQr-O1Le8sEld7g@nvidia.com>
In-Reply-To:
 <20261106-upstream-soctherm-t114-v1-2-c875d1921084@tsv-stahl-riesa.de>
References:
 <20261106-upstream-soctherm-t114-v1-0-c875d1921084@tsv-stahl-riesa.de>
 <20261106-upstream-soctherm-t114-v1-2-c875d1921084@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 97203f0f-792b-4111-ee8b-08df4ba7d96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|6133799003|22082099003|261009223027099003|18002099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|56012099006|261022105027099003|4143699003|261022075727099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Tnxw8iazmJjBAEUsDb9KzFDYyPT4SOj5KRc2DRqzy5PBk0FYQEzxjE0sTo0DEAWkd1MrArYXuBL5aALEmSWBJw/d1Imp8mqLTDBlGKhhwEAlQ0ReU0a34sLexeu7F0jN8tsFC/m0VgTlMq9rUrD2hMbeGIEB1frLekf8BU9Ivi9lNlmWBsDx0IrqkBcnKXVGL/g6j7A/VKFMfAVIelbUK1pAkX4QjpRnS6o3a7IB/sU3kjtMGgGFxNDky2SCjsYxULa8G7kCDmgH0KUzJWXQfovQe3+mnNHRfD6B/mu0mTNraPzsagXolDnwZfq9lrbdFLWK0ZActxSXarBgp9qbU93lO8+O3Ntuvwr7RkwCsuImd1PAUW7qcrwgq4A46BA5DBZ31w3TOjHODUE0E6gT0Cwsmq/LN+Wq1RsMjEmQq5a6l+PrtXtIlljM6GPzNBOAS+DzZp6M53RxVelz2C2IC9P9Tb3ptxMXxj0Qwy/UYk+i+msPtzc1P2V7DWv17ugDX9WRrUSWNd4TSGBgfXTdh3oVOVSsKq3phc1nYs88Txe1tUEqjRkQoATFTGX/BlwBuBQed22bUDYNJPDHlQVIkyaHksmR3j3vWBFFwZ9Feu21frRwoEeTm5p5Pd96wsTEu4ZwfE/4FUdjKaJirZh21v0dPLh1WHQAhAPwv+vpoaM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(6133799003)(22082099003)(261009223027099003)(18002099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(261022105027099003)(4143699003)(261022075727099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aExrUnhkdExtbG1BVmQzN3RBcDlWU2s1amNkZitHWXI2TmhES0VGVk50ZkU1?=
 =?utf-8?B?NnlRWG01WTZmb2dqL1g2NWFsVVFsR0pTYi9pQ0NtNjRxaDR0YkE1Wm1YcjhE?=
 =?utf-8?B?NnR3dnZ5VEpERitrOTgyRUFDU0ZjU0dVK2JLM2VPWkJwdEc1VHY2SFJJTERp?=
 =?utf-8?B?Um1qU0szaTFONUVJNkQxZHJhOHVxRDRZcVhDTGxMMVFuL3RHZ3NhaGNNT0NJ?=
 =?utf-8?B?K2lMUjlxTHdrbTlzN1orRTByZ2hhMHVTSEU3cEpBd25NNFY2VVU3K2dDZlVk?=
 =?utf-8?B?RVpFTVRYNzBzRytxRVlFYUNlZEpOdHM4Mnc4Vy84QmpDYThtbzdyd2kzb0dD?=
 =?utf-8?B?d05ybklFU2FkeFo2WXRSMm5BSHZUU0VqM1MwWHNvYitPTlNaY2k0N1oveXNq?=
 =?utf-8?B?d2ZCZEl5TGFzc0ozcjhDUExoTTFSblp5ZHNpbHBISnpjb3VINkZKWWRpNFJY?=
 =?utf-8?B?byszdm5CcFVsNkI2REFPMzFjdWhKZmx3T3FFcGZ0UUN5eXgzYnh1RitEYXBE?=
 =?utf-8?B?SVhwcEdOaG1uQWZJWHZIRG1xT0lmNWJVUWU0TUxNeHI0MzFnQVNhUE1RVWp5?=
 =?utf-8?B?Wko2eXY0WmdKMWJsSnQrSFoxTjF0NlgrUDBES3hLb2tCYXpSNUpFU3AweEdy?=
 =?utf-8?B?dTk3N25QVWlXMFdmMWNJanV5KzVKWWRiY2FYbllDWXVTVzRiTmlzVFBBL0Vs?=
 =?utf-8?B?V1d6anRwaER4MjFKZWordlJIZml0YVpjLzlIeW4xSlRxOG9IYUEzRXY3Nmx4?=
 =?utf-8?B?MGdkQmJKQXJIRGk2WlFPeFdYd2dsK2d3eU0vU0VOZGVYdzFKZGFSU1cvaVc4?=
 =?utf-8?B?SzUzQTltN3NFUk9ENi9GeXljZDNnNzVKeXNrSzRCT2lZOTNra2xpWHpsbXVU?=
 =?utf-8?B?VFVjK3VtRE1FR2ZPS2xmakI0MDNGYS9mRS8wanF3K3FLcVpQNUtSSEJyZ2Zw?=
 =?utf-8?B?VGNOZmR1WnFEVERPdjBtN0RKeFgvMEkrTGE5dTNuT0E3TnZLb3ovNEY3Nld3?=
 =?utf-8?B?eGI5eUVwRDVGV2dBRHRva3ZXZmRiVHd0dDRmUmRqb2tHMURucXR6S2RBalB5?=
 =?utf-8?B?eWIrUjQxRSt5ZmxpMTQ5bGU3dHg0dTUwQXdzRlhCM3R6ZjhaWUR4VGxjNWw5?=
 =?utf-8?B?WVBFZCtkaktvRFVuTDcySXNjeTYvR21pZU1qRXk1eTNTK0VVRFdBczg2UUUz?=
 =?utf-8?B?VEZGUUh1VDA0QmM3U0tsNnU1V0RJUVRKNTF5VXNHMFZDZFBHeUNXSENvSDRO?=
 =?utf-8?B?NUFJbU9kM3U3UytrRzgyK2lzMERHUFZlN0tQdlA0OXVtVlFscVJiRHBHVld3?=
 =?utf-8?B?WmFnNGkxOEhpc01KbGJUQjNVcDNWR3FOVGEybEZRaHJwNUwxNTE0UnR1aFlH?=
 =?utf-8?B?eVVUS0NoYU5BOWxNcVlxRGswT25LbXU1MTk4bnQ2K3V3d01pdTdEekx0NzR5?=
 =?utf-8?B?TDNZUDRsalhzcGxiNGpjZG1ZV2ZlU0xieDg0YklKNjlOQnBVUkNGc1R1VXZH?=
 =?utf-8?B?RVdOSlZIUE9zWmh4ODE5RWxiM050bXJCb3BTcHV1VHdwaHZ4UHo5aHNOWHIv?=
 =?utf-8?B?YklxdlhaNHJpek9qRFhia1dPVGsyYjZnZmUwOHlSdmNQdUNwVnhYSmZxNW93?=
 =?utf-8?B?NVhQUHErYUd5b1BpQWVYeVBFNXFzZGtsTk44RHhTdlRjSzNWbm9EZFJ3aDZl?=
 =?utf-8?B?RC9vYmt3SEo1dzcwS3N5d1phTnlXQytZUWNqY0NzWjhNUkxCLzdzQlRWVFYw?=
 =?utf-8?B?T1JJVEFlVFlKSnBMYWdGUU1jOGVGUzNRaEZPaHM4dEYrVytlUG5rdG9XeHFr?=
 =?utf-8?B?MExXNEF0VU04enpLUEZFOWE5eXhFRDh0SXorcVNIUjl3a1JzT3lJVUJKY3Bi?=
 =?utf-8?B?WXNXaXNoL01NZzYzeHdhZ2hzQkpDL0pyK043b2ZsMmdHNUdFM0grRXR3VzFv?=
 =?utf-8?B?anZDUDVYWTVGb1Z4OGV0Q2hDczcxRGlFVTY2c3hOMUNGcXIxT0VqRFhnUVlp?=
 =?utf-8?B?cTZyTjk0RG1yVHZJN2YrSDM4clFmbFcxM21Rb3FKVE92Y2hWUkZSZUZmbW05?=
 =?utf-8?B?NWMxdnE3RnFYb3NXTEFDcm9pamZqVkhPdUFUOWxhd2Foem1vT21LSDE4eG5w?=
 =?utf-8?B?NGRDSldzeUptbnBma3hvbkRrSkhoMWoydXQ1bFlOQUlZQTFpVE5lU01CNGhj?=
 =?utf-8?B?Y2prMlFINmJaNTBXRXJ2UDVIWEpaRWdrK29LYXFKZG9LRDNwZmxFNGNFYzEw?=
 =?utf-8?B?SVZGUG4yWTNYS1ZjdjJYZ1cxeW5JNWJnNDNCNCtxN1J6UDdYMTJQZUhDODdV?=
 =?utf-8?B?WEpsdHMzK1p2N0F4QnJsa1JRY1NKSWRlY2ZHMWYrSmJBc1RMNUJIWW8ra1gv?=
 =?utf-8?Q?Uf50zMgPFZ3RkKmv+U7E1vt//qbAo++s6kqj5zKGx5fa4?=
X-MS-Exchange-AntiSpam-MessageData-1: FCN+5aD81e21Uw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97203f0f-792b-4111-ee8b-08df4ba7d96b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:27:19.1327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytJrAaUrnTd4aLSuhSJAJmPXTrjUJUtOJD+3lqSyZcjCVRsJnqxtSDZeoH5P/HzmbNW2ricc2CnbMOzyfElYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987

On Saturday, November 7, 2026 5:31=E2=80=AFAM Patrick Fischer via B4 Relay =
wrote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> SOC_THERM calculates each sensor temperature in units of 0.5 C as
> THERMA * capture / 2^13 + THERMB. On Tegra114 the intermediate product
> THERMA * capture has to stay below 2^24. Above that the hardware sets
> TCALC_OVER in SENSOR_CONFIG0, clears TEMP_VALID in SENSOR_STATUS1 and
> the sensor drops out of its group. On a Tegra Note 7, 80 out of 80
> samples matched this rule: TEMP_VALID was set exactly when
> THERMA * capture < 2^24 (largest valid product 16747731, smallest
> invalid one 16877718).
>=20
> The fuse calibration itself is fine. As Mikko pointed out in the review
> of the Tegra114 series, the fuse corrections are in 0.5 C units on
> Tegra114 just as on Tegra124 and Tegra210, and
> 2 * NOMINAL_CALIB_XX + shifted_xx is correct. This patch keeps it that
> way. The problem is the range: with T in C,
> THERMA * capture =3D (2 * T - THERMB) * 2^13, so a sensor only gives a
> valid result for T < (2048 + THERMB) / 2. On Tegra114 THERMB is close
> to -2000 (between -2117 and -1812 on the chip tested), which leaves
> almost no headroom. On that chip the sensors were valid only up to
> 45 C (cpu2), 53 C (pllx) and 32 C (gpu), and cpu0, cpu1 and cpu3 not
> even at room temperature. The gpu zone therefore always reads 0 C, the
> cpu zone stops following the CPU at about 45 C, and neither the
> throttle levels nor thermtrip ever see the temperatures they are
> programmed for.
>=20
> NVIDIA's downstream driver runs Tegra114 in "lower precision" mode for
> this reason (tegra11_soctherm.c: "We must use lower precision (0) due
> to cp_fuse corrections"): the sensors count in 1 C units, the readback
> is scaled by two and all thresholds are in 2 C steps.
>=20
> Do the same with a lower_precision flag in the SoC data:
>=20
> - keep the fuse calibration in 0.5 C units and halve THERMA and THERMB
>   only in the final rounding step, so THERMA * capture stays around
>   2^23 and the sensors report the same temperatures at half the
>   resolution,
> - double the readback in translate_temp(),
> - use a threshold grain of 2000 so that thermtrip, the throttle levels
>   and the trip interrupts are programmed in 2 C steps.
>=20
> The use_lower_precision option in v3 of the Tegra114 series and the
> downstream driver halve the calibration temperatures before the
> calculation instead, which applies fuse_corr_beta at twice its weight.
> Here the result is exactly the current calibration divided by two. The
> PLLX hotspot offsets are left as they are, as in the downstream driver.
> Tegra124, Tegra132 and Tegra210 are unchanged.

It looks like this was fixed at some point in downstream, not all=20
published kernels have the issue.

>=20
> Tested on an NVIDIA Tegra Note 7 (P1640) together with the shifted_cp
> fix: THERMA * capture now stays between 7.7 and 9.2 million, and all
> eight sensors report TEMP_VALID in idle and after 60 s of load on all
> four cores at 1.12 GHz. The zones read cpu 43, gpu 39, pllx 43, mem
> 39 C in idle (board thermistor 34 C) and cpu 63, gpu 55, pllx 62, mem
> 53 C under load. Before, the gpu zone read 0 C and the cpu zone stopped
> at about 45 C. The thermtrip, throttle and trip thresholds are
> programmed as 51, 50 and 45, i.e. 102, 100 and 90 C.

This commit message is too long and hard to follow. Here is what I would=20
suggest:

The SOC_THERM hardware calculates each sensor temperature in units of=20
0.5 C as 'THERMA * capture / 2^13 + THERMB'. On Tegra114 the=20
intermediate product 'THERMA * capture' has to fit into 24 bits; if not,=20
TEMP_VALID is not set for the sensor.

With the fuse values on the tested devices, this leaves very little=20
range given the current logic for calculating THERMA and THERMB, topping=20
out at values below room temperature and 53C depending on sensor.

Fix the issue by introducing a lower precision mode where THERMA and=20
THERMB are halved before programming them into the hardware, and=20
correspondingly doubling the temperature values read from hardware.=20
TEGRA114_THRESH_GRAIN is also doubled so conversion of temperatures into=20
hardware threshold values divides by two. This is the same approach as=20
used by the downstream kernel.

Tested on an NVIDIA Tegra Note 7 (P1640).

--

Please adjust future commit messages accordingly. In terms of code,=20
everything looks good to me.

Cheers
Mikko

>=20
> Fixes: 9d522a877b6f ("thermal/drivers/tegra: Add Tegra114 specific SOCTHE=
RM driver")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/22816196.EfDdHjke4D@senjougahara/
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/thermal/tegra/soctherm-fuse.c     | 15 ++++++++++++---
>  drivers/thermal/tegra/soctherm.c          | 21 +++++++++++++--------
>  drivers/thermal/tegra/soctherm.h          |  6 ++++++
>  drivers/thermal/tegra/tegra114-soctherm.c |  4 +++-
>  4 files changed, 34 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal/tegr=
a/soctherm-fuse.c
> index 2de1d0cb676e..bba563961da7 100644
> --- a/drivers/thermal/tegra/soctherm-fuse.c
> +++ b/drivers/thermal/tegra/soctherm-fuse.c
> @@ -118,7 +118,7 @@ int tegra_calc_tsensor_calib(const struct tegra_tsens=
or *sensor,
>  	u32 val, calib;
>  	s32 actual_tsensor_ft, actual_tsensor_cp;
>  	s32 delta_sens, delta_temp;
> -	s32 mult, div;
> +	s32 mult, div, coeff;
>  	s16 therma, thermb;
>  	s64 temp;
>  	int err;
> @@ -147,11 +147,20 @@ int tegra_calc_tsensor_calib(const struct tegra_tse=
nsor *sensor,
>  		((s64)actual_tsensor_cp * shared->actual_temp_ft);
>  	thermb =3D div64_s64_precise(temp, delta_sens);
> =20
> +	/*
> +	 * With lower precision the sensors count in 1 C units, which keeps
> +	 * THERMA * capture within the 24 bits the hardware calculates with.
> +	 * Halve both coefficients in the final rounding step.
> +	 */
> +	coeff =3D CALIB_COEFFICIENT;
> +	if (shared->lower_precision)
> +		coeff *=3D 2;
> +
>  	temp =3D (s64)therma * sensor->fuse_corr_alpha;
> -	therma =3D div64_s64_precise(temp, CALIB_COEFFICIENT);
> +	therma =3D div64_s64_precise(temp, coeff);
> =20
>  	temp =3D (s64)thermb * sensor->fuse_corr_alpha + sensor->fuse_corr_beta=
;
> -	thermb =3D div64_s64_precise(temp, CALIB_COEFFICIENT);
> +	thermb =3D div64_s64_precise(temp, coeff);
> =20
>  	calib =3D ((u16)therma << SENSOR_CONFIG2_THERMA_SHIFT) |
>  		((u16)thermb << SENSOR_CONFIG2_THERMB_SHIFT);
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soc=
therm.c
> index f74acf13b24d..0f6e5455ebb4 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -413,9 +413,10 @@ static void enable_tsensor(struct tegra_soctherm *te=
gra, unsigned int i)
>   *   TTTTTTTT H______N
>   * where T's contain the temperature in Celsius,
>   * H denotes an addition of 0.5 Celsius and N denotes negation
> - * of the final value.
> + * of the final value. With lower precision all of this is in
> + * units of 2 Celsius.
>   */
> -static int translate_temp(u16 val)
> +static int translate_temp(const struct tegra_soctherm *ts, u16 val)
>  {
>  	int t;
> =20
> @@ -424,6 +425,8 @@ static int translate_temp(u16 val)
>  		t +=3D 500;
>  	if (val & READBACK_NEGATE)
>  		t *=3D -1;
> +	if (ts->soc->lower_precision)
> +		t *=3D 2;
> =20
>  	return t;
>  }
> @@ -435,7 +438,7 @@ static int tegra_thermctl_get_temp(struct thermal_zon=
e_device *tz, int *out_temp
> =20
>  	val =3D readl(zone->reg);
>  	val =3D REG_GET_MASK(val, zone->sg->sensor_temp_mask);
> -	*out_temp =3D translate_temp(val);
> +	*out_temp =3D translate_temp(zone->ts, val);
> =20
>  	return 0;
>  }
> @@ -1287,7 +1290,7 @@ static int regs_show(struct seq_file *s, void *data=
)
>  		state =3D REG_GET_MASK(r, SENSOR_STATUS1_TEMP_VALID_MASK);
>  		seq_printf(s, "Temp(%d/", state);
>  		state =3D REG_GET_MASK(r, SENSOR_STATUS1_TEMP_MASK);
> -		seq_printf(s, "%d) ", translate_temp(state));
> +		seq_printf(s, "%d) ", translate_temp(ts, state));
> =20
>  		r =3D readl(ts->regs + tsensors[i].base + SENSOR_STATUS0);
>  		state =3D REG_GET_MASK(r, SENSOR_STATUS0_VALID_MASK);
> @@ -1325,14 +1328,14 @@ static int regs_show(struct seq_file *s, void *da=
ta)
> =20
>  	r =3D readl(ts->regs + SENSOR_TEMP1);
>  	state =3D REG_GET_MASK(r, SENSOR_TEMP1_CPU_TEMP_MASK);
> -	seq_printf(s, "Temperatures: CPU(%d) ", translate_temp(state));
> +	seq_printf(s, "Temperatures: CPU(%d) ", translate_temp(ts, state));
>  	state =3D REG_GET_MASK(r, SENSOR_TEMP1_GPU_TEMP_MASK);
> -	seq_printf(s, " GPU(%d) ", translate_temp(state));
> +	seq_printf(s, " GPU(%d) ", translate_temp(ts, state));
>  	r =3D readl(ts->regs + SENSOR_TEMP2);
>  	state =3D REG_GET_MASK(r, SENSOR_TEMP2_PLLX_TEMP_MASK);
> -	seq_printf(s, " PLLX(%d) ", translate_temp(state));
> +	seq_printf(s, " PLLX(%d) ", translate_temp(ts, state));
>  	state =3D REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
> -	seq_printf(s, " MEM(%d)\n", translate_temp(state));
> +	seq_printf(s, " MEM(%d)\n", translate_temp(ts, state));
> =20
>  	for (i =3D 0; i < ts->soc->num_ttgs; i++) {
>  		seq_printf(s, "%s:\n", ttgs[i]->name);
> @@ -2159,6 +2162,8 @@ static int tegra_soctherm_probe(struct platform_dev=
ice *pdev)
>  	if (err)
>  		return err;
> =20
> +	shared_calib.lower_precision =3D soc->lower_precision;
> +
>  	/* calculate tsensor calibration data */
>  	for (i =3D 0; i < soc->num_tsensors; ++i) {
>  		err =3D tegra_calc_tsensor_calib(&soc->tsensors[i],
> diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegra/soc=
therm.h
> index aa4af9268b05..67d4ca149e59 100644
> --- a/drivers/thermal/tegra/soctherm.h
> +++ b/drivers/thermal/tegra/soctherm.h
> @@ -122,6 +122,7 @@ struct tegra_soctherm_fuse {
>  struct tsensor_shared_calib {
>  	u32 base_cp, base_ft;
>  	u32 actual_temp_cp, actual_temp_ft;
> +	bool lower_precision;
>  };
> =20
>  struct tegra_soctherm_soc {
> @@ -133,6 +134,11 @@ struct tegra_soctherm_soc {
>  	const int thresh_grain;
>  	const unsigned int bptt;
>  	const bool use_ccroc;
> +	/*
> +	 * Sensors count in 1 C instead of 0.5 C units: the readback and
> +	 * the thresholds are in 2 C steps then.
> +	 */
> +	const bool lower_precision;
>  	struct tsensor_group_thermtrips *thermtrips;
>  };
> =20
> diff --git a/drivers/thermal/tegra/tegra114-soctherm.c b/drivers/thermal/=
tegra/tegra114-soctherm.c
> index 688104f28052..0a30103c3f74 100644
> --- a/drivers/thermal/tegra/tegra114-soctherm.c
> +++ b/drivers/thermal/tegra/tegra114-soctherm.c
> @@ -23,7 +23,8 @@
>  #define TEGRA114_THERMCTL_LVL0_UP_THRESH_MASK	(0xff << 17)
>  #define TEGRA114_THERMCTL_LVL0_DN_THRESH_MASK	(0xff << 9)
> =20
> -#define TEGRA114_THRESH_GRAIN			1000
> +/* thresholds are in 2 C steps because of the lower precision */
> +#define TEGRA114_THRESH_GRAIN			2000
>  #define TEGRA114_BPTT				8
> =20
>  static const struct tegra_tsensor_configuration tegra114_tsensor_config =
=3D {
> @@ -206,4 +207,5 @@ const struct tegra_soctherm_soc tegra114_soctherm =3D=
 {
>  	.thresh_grain =3D TEGRA114_THRESH_GRAIN,
>  	.bptt =3D TEGRA114_BPTT,
>  	.use_ccroc =3D false,
> +	.lower_precision =3D true,
>  };
>=20
> --=20
> 2.56.0
>=20
>=20
>=20




