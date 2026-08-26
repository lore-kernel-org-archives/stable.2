Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760B46D096;
	Wed, 26 Aug 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766670; cv=fail; b=p/vvk1PmHTOFlpqrukuYHKS7sSj91aEvRSF6erzH6+B4Arav+AzvHBRBP0B7BlzOFXFLW25lFU1yD1IHlHeK1arWUWfUPYBcET+fNHhWUILEqUTTWF1iiJIL1j7Nd5O3jCdjET3+WW7Ta9cgkimr1u37UhIViiAeT87rDiFXnQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766670; c=relaxed/simple;
	bh=D5FnVKOtF/5UDFmoR+bkMqfWAq85p4eA1xLBG6eWjfk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FKkRNSwIIEsTbWnNYeozqkmihqBiDyyQOgaLT2qIF8aTuRaJhrnzn3IrM+MrAKF7qNRMMC0BW63DuQSOD7zpBwaYJoDSL464yaPGKMa/HX7C2lUteFlcF7N0RT4SfO46yBh71Uc73/MKZT1hPOpduUTgJcwYIPtJg0AP1XxzkzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HwPIXNM+; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HwPIXNM+"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QGwvbS024374;
	Wed, 26 Aug 2026 10:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=TgF363gDe
	XG7dZtz2hAyCECUApJI4plfPFCzZcbYjqU=; b=HwPIXNM+L0O3AUDyNYAp7xnt+
	pdiWNvFKyEgIqLgYP3IEtPHkij/McJzO5nxeUxVhEsN0yQq/jkCN8/524iZQhYVx
	GO/T/J5C872dnnTG/s3VJoG6HY+imHPGb8vDp4hvfeWU+SkkNfF8powHASumR/Xv
	Kht6P5dmrkWdwgrMKwPt4HpkW7SDSNKUBGCF2Y602+95RApTam2Q6xqKaSyJZ6UB
	Lz7zAAwMpKGVCU1odPKscqfMmtFkbqtgQSAoRwqaWJA/PmZ/7nABb3LY+g9Zvcgi
	QEiIudlEP/5d0xS6AVAcDcTp1E9CEIL6p4yqOBFb4N9I843lYQ2rcpnahJHIQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021140.outbound.protection.outlook.com [52.101.62.140])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4g7721q4pc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 10:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU194PuqZGimZJ0tzgmL7ixRuie1NkFHl/imUalDUIAiICK8avbiMI43hazdzTmjRenU3wN+jd1ycJ1+HDAa1DTUqeWd1wrQcc2J9EJG1+lgJzEfYEh0/GAN2XHFz8Kv4iF3k2aeeEtldZoU3ph0ml5BsH9QG0ULxuT4Kf9KDffirGvR3Fnu8kXEGwcZ/Ov9QRgc9PLrJbqyuqEtOXFRewvXOcNhDDD2YKzBsSBnvuHbjyov7hFrSEsK7IuObsPpIp1oPHv714jp0O9FVbRT932FbnGbaUjPJhflPjIRteDRYBKYVaUfhm5zuI2ne8+NQhX0dz2+YJLo6j6/Ujamxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgF363gDeXG7dZtz2hAyCECUApJI4plfPFCzZcbYjqU=;
 b=bXioWr+2s7ToHVv3JixZr6EGootxarcpHnPA/YB8aSD03O3MkhilFsbTXhIuXBHZ8/hrkB/xruZ3jCvW1hWNdQI1Bym9HFGZsdFuOeqbiSMXKXo/pZXwaYv19QEpx/qg0SoBXgqwWIj6J8nNW0hkB0oyheOK4MC4l658PIbLVeTL16kSnRZKrfZiidC7acMMIIqpnsd+eaoSFQUGhxvmDXk87idssht/hIhe2IWlwx/csm68lVHS8/zD9oxDu1UtC2xRmDIHSF1WsjBMlbvMaRijj0gvN/pJ0/y9dEyNUNXl4hTT4WyoMYTPp47ZL6cJ2A2cwFfjzCiH9cCmT8BzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 17:50:29 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 17:50:29 +0000
From: =?UTF-8?q?Juhandr=C3=A9=20Knoetze?= <juhandre.knoetze@windriver.com>
To: stable@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
        Dmitiry Korovkin <dmitriy.korovkin@windriver.com>,
        netdev@vger.kernel.org
Subject: [PATCH linux-6.1.y 0/1] inet: backport of RAW sockets dropping incoming ICMP
Date: Wed, 26 Aug 2026 13:50:08 -0400
Message-ID: <20260826175018.131474-1-juhandre.knoetze@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787766292; l=460; i=juhandre.knoetze@windriver.com; s=20260821; h=from:subject; bh=D5FnVKOtF/5UDFmoR+bkMqfWAq85p4eA1xLBG6eWjfk=; b=4idGg12E0VkLgzIyjxWt3DNb+TCS2LAzw7jMNFHFYMru6aPE4VocdU8w9+S7aN9A0rFSPoNpu MzwRkkZQN3VCnJJO090NT2x5JIg94YqLlGmjqlMXGMoh3bv65klqD52
X-Developer-Key: i=juhandre.knoetze@windriver.com; a=ed25519; pk=C2rmFq2p61pIoyBkOTAC8McUtyOS6pLmoNnXTPuDe7M=
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: a17c1670-82a5-4752-a62d-08df039a83de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|10067099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	rTIt5xr15ybd1OP52+BazMy/qb4yglUEh3MDcea3qJb+EFBuMRfGEq9k26uqglvNheaLk6+nYxLhuplHFfT2H+rYByoKJVPHIidkSwxSbTf6cE0e9rwFHlH1dthI/IFdcf5j8nt/dmHINScPSDGiSe3Lz0GLoKEzX+oSvYBikeaaGd2aSZKWyL9M7skuVymWuHJUBSgQA5c9q9wuiojawuIpKFzTXg8Gbss/Pvo7kvfEh+eqZpiA04zYQZV3TOy6GayFKUHWkL8Eqcft0wjKjuNhKXbIIKqOh0ZPvSs4yPcVafb0hCpT78vC6u0g1JaIBfKYZKlNQnTW4N1CXtA3MlOLBqrFn9jfM5RlUHJud61a9OZju180iFq3zuMWbShcr1eshyhyJA6I0vXe3YTgTnxTdQk4ayXbXWuhPAx75ATQeV6xEdm5S4D0B+1/ATaiKOmJFsC4dSTpJKZswP46w8glNya/eCqrTXC3B7oCjhuacee/DsiRidM2pmQSVwyjrZGvbC7W6MYtBzjpiVdcSvWiqvJd21Nse09b8eCG99cOtonPYok/JrJ9z7USFMeaaNce7d1LI0ROR5XR/fqbUfQogv82wRELW1M5NImr993Hk8eOFB/sX9XoTvelNrPJhi1uZ4VnWZ+GRVu8djwQ4QqCEh961bNOWnI0di8Sw6trmmLg2ur7focn1q1zJnAfurQ+uBlcNwnx3zw/Nywc/PfSUY3QPXd0gVx7nxS31Tw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(10067099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0dhY0RTd2NadUg4WUx1dnp1T1IrTnZHZ2tKTE52NVBIUmI3MnljZUxTaW90?=
 =?utf-8?B?Y0oxakFKdWZpc0pmdVZTc3I5MmQ4Z3JocmUxR3JIdDFlY1R3LzlTNGxHbHJh?=
 =?utf-8?B?eVlvRXo4Q1Nqb2ROZzRGMktMbUNqeTlHajI2WDM2SHdVcVBoRjBwUEdPT0la?=
 =?utf-8?B?L3hDYTh0SjRJRXZ3anNWQk14dit5TmVHYk8yRXFDRjU1cEdUM2ZUTXZGalRZ?=
 =?utf-8?B?T01xM3dkdTlwQitadUNzTWp2aURxZDBWK1FjL3lEcllrWFZXdTR0ZStWNHpM?=
 =?utf-8?B?YmJxVUw4clg1WTkyL3IwR1Uwc0ZNNENza0tYdjdtR25TcjYxWHkvWnpYb2Qr?=
 =?utf-8?B?K29mNDlpemNYWW9FMkF3aFMzNUJvSGlJOE9qS2JMQVZtS0poMjJydTN6aHdq?=
 =?utf-8?B?UnFsZTB5VUl1bzNNTEI4RlBUblNVbjZIUjlHYUdvRG9vRWdqSWJ4UUJXSEpH?=
 =?utf-8?B?NFA4ZjB3UjlNQktVMHplMHQ3aU9zQlBLcTRvcldsOU5TMlRvUHE5K0FJNSto?=
 =?utf-8?B?UzFwczJnd1pzQ2ZaRHU4WGswcGxrcXBNb21OKzlRb3U5ZlVBWU1FYlNjRzRG?=
 =?utf-8?B?cXI0eVZZbXBGVitVMzF6SlBQOVp6dWZKWXVXVU9XMThBeXFFVWFRMkdYVkFH?=
 =?utf-8?B?UjlKN0k3clBJNWZuTmZCSlV6Q1R0SFFGSjBIdEhodmtlMzhsd3V5Vms0ZGh2?=
 =?utf-8?B?RGFKTkdzZW9zNnZNalptc2FsajVmcXFLWWZwZDRnTVVPT0tVNS9SaVlUL2Rh?=
 =?utf-8?B?ZC9UbHRJSldWT0h0QUJoeE04Slc4bFNMMm9sdEdKbG5LbU5pWXZUZ2l1b2lj?=
 =?utf-8?B?UGo5TC9pdjVpckZPdEFCVCtkdDNjOVlzb2dVVkpLOVJNeVJuOUtGU3oxQ0Vo?=
 =?utf-8?B?ejVTR1htZWtma2lxeFROcTF5dVhoTmpDS1diNDQ3V2NtTHBCSHFZTkRGbnQz?=
 =?utf-8?B?Mi9ReWpKU3UvS1dZY0NlUjlrYUZraWhFK0dPUWNZOU1WRS9SZGdNVGVtNHFK?=
 =?utf-8?B?KzlKakpBZmtVcEhnZVhoUzVBS1prbVZpT1hqcGxOMERkMkZaQm1tL2J5MW5j?=
 =?utf-8?B?Y01GWDQ2d1B6VEhuSzlrNjVSWlVhSVNLVDgwaG1nWVFKUnovMkkrRGVBZkVK?=
 =?utf-8?B?T1I5Q1RmNUJmNmk4KzNRaHJKK1FnZXlDUkQvSE1udVZFMkt1Y05TTURQU09q?=
 =?utf-8?B?aTFkdUQyZUwzZ1hobjJURzc1dmdHL09aa1JHbmJvT0doZUFDK0ZsOGtZN0F0?=
 =?utf-8?B?MHg1eXRkVFg5V2xFNFQxdGdndkdBVWlLbm5jMlExUGRiRzV0Z2xQNUJtOEJH?=
 =?utf-8?B?eGtYSkRqU3ZKSmJFNGl3dU5rNURxZmY5RDN4SFB2SlRMVzRIR1BBQnE4UXFC?=
 =?utf-8?B?NkNlRHZRdDd4SkJoNkFsQnc1UUdzbG5SR2RCRmczTXNNeEs4R0tBUXhmME9u?=
 =?utf-8?B?eEhFWlBLNldYUEpqNWxNbTdOcDEyUWVhbjVINHFUUVN5RzFneXgrN2FKSS8x?=
 =?utf-8?B?Y1ZwdTg2QmUyc1ZiNUpaZHg3dFdEYmpyUWh3WEJVTXZOSXE2N2xFeUdISFEy?=
 =?utf-8?B?cjZiUmo4T3BKZEtFZm9TOXcxRlJBeEtOc29zWFNhVE56ZVgxcU12dWN0UGpx?=
 =?utf-8?B?OXgvZVJvT2JtN3hIMjFvNHlZb3l4Zy9MdWplWWVQSWZLM0p6L2p3SHVVT2lL?=
 =?utf-8?B?NWNXNW5ib1BVNUhYQ0VYSEY4TmJGN1VsUVl2UWJiQ0YvVDdySFZoeitBWUdl?=
 =?utf-8?B?cjU4VWV2Zm5mK25Hemlmbzl6d1ZnaGdIWlhWU1pOM2RpU3JwdVNmSVpqSXJq?=
 =?utf-8?B?VVNhVkdJZzhGN1dEUEM0cjIyekNsSzhKZlg4UVAvMzNBYnkrSi9OTDBSZGlo?=
 =?utf-8?B?Tzh5THNpbG0rOUZYalBIMysrUG16cWdnWlVxc0FvYWI2VkZwZVFmMWlWV2w3?=
 =?utf-8?B?VDUwMTJoSXVNN3lqc1FWeUYvWll0QVZqNjU2d1R4V2hFa0dsNzdmUjNxSm9x?=
 =?utf-8?B?ZXl4c3ZWSU1qZXlCWlZza01MWEFjZXBDSEFaSExxMEk0ZTFaOUdQT3dqQVZ2?=
 =?utf-8?B?ekErV0ViRnRmd3hURk5Lc0tTbGxvSUdQVjVvUHpLRlYweDMrSStJSm9xSnBa?=
 =?utf-8?B?bStoeWdjRXhXTlkwSHdwWHg1dnVHaXVITnBHVU9GSTVMZTByMTU1RjdFbGNC?=
 =?utf-8?B?WGQ1MzFDY1ZYVjRyK0F3MVZLV1M4NlFPMlhhU1pXODk1NEttTUkyc05YSit4?=
 =?utf-8?B?cHRpeG9oVWlvcFlNeGJhQzc4OHZFWEsvT0tQMGNSWUhBTnZidU9ZQTkrUmJo?=
 =?utf-8?B?dGttay9nRkRDSHZ6YWpMckJGc3p5OGpwZXh4OHhldmpjNkZrM05vT09OcGdx?=
 =?utf-8?Q?D923u3KAKRGMdLwQMIg74zZq8WNawlDpNPUM1?=
X-Exchange-RoutingPolicyChecked:
	Xk+1q2SnnjN/9oRhcQ0GX3w7VdwClRQLrONAsVjJ5DEx8EbTUUZJrLoDkm6jeoWe2FJPKiqtmzQT27mC7VsNrlXqkd5lbfXjV95HrTMaqFxNbOa/8syItkzQ1r0frTYW9bwogbiQSzd+OX13cNIZyXYUB1Uh3jPQCNmRWpcFk3DsLVIvM79/VkKMD7khlG+kROPtuu7yEaBoDZkRpYRD80Ya5bqBhqksTg2YkLAuFtHuSevStvAj6wttQZLwH1VktRh89ju84N0Uj5MvU7Z/7RGlzhmvk4vaT5JpxtgLPg6Ggk4rOB3OomgYG6MPO1SMA8T1y7aN1roIgME+b/VZZA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17c1670-82a5-4752-a62d-08df039a83de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:50:29.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF4x1ff2OvK9YqOl7DPNLKfe0A0TWspalsVu0BBKqq2xRG4FZWy7lQ8au1UMWxq26oO7x+61WOHKrfB8przriGuY7Lp9bCliTkMrUr0DMTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a8f2768 cx=c_pps
 a=3OKKl51w8sN2have8IVhxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=UuuhR-qwCkgnlNMBG1sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lTqlgbVemvr_uBxVmrq7a6Q6h6Jr8o_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX0x+bRPF4s4Bf
 OLjzX3WY5ctcJdt95cxbjXMy8OeWBqsNx5tkdPpzipInHRhjWhrL9ffJM6JpxQh5NXbi+sf77IA
 5ZeOZ5gpa0nuFJ8xPdojOoN8+JIKEiZhGe0hP7PYnZgsxP+JnG0llHPd4ybOcm/2e5tKh0gHdCr
 r9V0f8WVEMdPsGx2+wSobHHIjOeu9Ro3NuB+RQmuwwZIHwAy/TdWlzOoqOAjPnox1kr2yb+lKf5
 9tAUzyI7cMJPHIsTDJfnV8Z8V3fi1I6kGzHI3XJhAzb6nlLY0dzUlDV96SICBWuTP0S15UMUtYd
 eBsz5yxYk9wEAjNp7h9vcJbCMtoHDgZC5U7NjVd4G7SXsMZMwIMF2Y3QvcF9bFMBGKlSIPjLl5C
 fLFGjdvCwDXWSAzH1MEqO6XuB23kEQ/1XBy8gcytGu4uO1Ds111wsTI8TjQmpej+u88vX1jvoXN
 g55JRnz/IhgXE8/OWvg==
X-Proofpoint-GUID: lTqlgbVemvr_uBxVmrq7a6Q6h6Jr8o_e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX8DbxadN/wtdV
 Yi9kUa3IJUAT5uA2YsRaviYHTfbNKQtR5rDXBTRU65GD1GKZx0Gp7jivcxTaEke0xssrC0h6sv7
 oInllGzSX+fMhyOUcHOl1bvmk1xCM1TnwNFoYEJlLRuIYsQz+DY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260149

Attached is a backport of upstream commit c89477ad7944 for 6.1.y. The
main difference between 6.1.y and the upstream commit is that in 6.1.y
the function 'icmpv6_notify()' in 'net/ipv6/icmp.c' returns void
opposed to a 'skb_drop_reason'.

Eric Dumazet (1):
  inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP

 net/ipv4/icmp.c | 14 ++++++++++----
 net/ipv6/icmp.c |  3 +++
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0

