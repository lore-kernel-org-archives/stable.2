Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940F652379B;
	Thu,  1 Oct 2026 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866328; cv=fail; b=XCq+LLFzpqB/CZMcrBY2RR2XaXDjLbX7uqIRq3Oaa52YFMYDHsmcdwiLuz72RdnpnidBV/xEm1DJB3QwLB/XbmJgm1dkl2fNIrh1pbXamk4IF8+7fglmMPb8P9Cp2rLIeyW3kXlciL0bjysosAemen1ZkGlB/ftcNaFT6lxDS5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866328; c=relaxed/simple;
	bh=UQBwldZF4J+Hu0HklMFVlHdEYOiHhNSQo3acNI1ba+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nEv6jT2OiT0YilHowlyjDCEK4YAA/hmJOr92mpzRY/U9oCmH9S6Jyq/JvTceDfD6D+Qod2SGZ/zlaDEZZn7wSLlfqQ+cymDbkHMrSQprU/xNnM6dUHjbqNs4VqaK92o3WgQ+nIR/KqQVVaEmYUG++uo14pu3SpyMPZc7hsZGmsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q7es+QYD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yalLQcZn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q7es+QYD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yalLQcZn"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMWdb2256758;
	Thu, 1 Oct 2026 14:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jmGk17dKi10wRgkth825iTibFUERug1dl3uknvUru7A=; b=
	q7es+QYDI2UMri9oakrwifr/aJObErZGZI3+1kLqy/R23YnPC8TnxuVUIqh1bDRH
	60ito0wJETqAXWrqCIE8NOEDZAKQ/ERaykHAi7Em8ug3pYcbDfKzZB5YPuBb9lp1
	gdaM8OdrETxJ9h2llblNQR8rPFy3f95RDu1cYHj5iYq+GVLCqorYnY3xud6buXTL
	Mi1z6IzwJGHSNGeounjI/zldIpMP3K6qyB4Q/Z2u1L4pUO+UFCDntfO2yJK10q97
	q1wa/k4ZD4NZDHlcSKOYx9+yMI/NvX0N217THfhJuu+m05eaWoxPoEhRG5lTm/Pc
	IyLTSjJqtjtn3ornHsBZGQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnnV4011499;
	Thu, 1 Oct 2026 14:51:57 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gepjer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3bbjvwG6VGo/1y6qppyZAMqcaKdtvyBx79cAjE3YhihlNrasmEBFA0UQwyQQ18TAG9/xXr5YeVMln7bnDFLR+tW6zQj3L4bi+5ianLsPEPe9YYQvHdoHEVBpqMJ5o53qgRDCrYfskoUPfDjv4mKFJSDotq1uWcZh0AQVkIwHGGrrrlCakPU+xjY8O2uEgaxGo+M3YPHaz2nNcqfSuI6siCSF+2V6HSzXyGGJhhL8ilnkbyo0bYSgLWTezKXKQtH4/2tovzI1eXtGYulmEFkBaFWsYUKRi/tRJV0Wqli+YkJ+kvySegr85LwjgpqUNx3nJKeci1VwMiEpO6IUOZW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmGk17dKi10wRgkth825iTibFUERug1dl3uknvUru7A=;
 b=ADOEJ5gDde/wPboOPleFUEWFr1Y/cRxRAi3BkD8371CRuF6Ok/BGiCU+f4Tgmn0bj5mWITwgS4neM72m7EiICH4iOnafr9PW3mQxSAdbRGTfUrGjf+ypeiQlAL2DBllBg0vEhQwNJgvk6hVxs7qP0Pf0YxLXOh2ZTXdeeSkfaDkory+eZKGu2M8Pzj/4GpENhwq0z8eXb2rZLpf81mhn1zUfwPmAl3FabcPfGsNCKihX8H7cfAosw6dSIE2zatt8wfUixmnV68p4Ibw0nFcV21eBjD8eHvUoLy/jhRPGdTqBFRmFic9F4mZeUVdsL7lob67WJczDXYFlOyM2wkdlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmGk17dKi10wRgkth825iTibFUERug1dl3uknvUru7A=;
 b=yalLQcZnQxCcs3gNuBV5NRiqccrSTykY292JnZZRCfe5VQItoBNzByb1PgqSWguC8I/4J3EqJxNbzSqRF4r/MYARPmxnqwJLvvtvpw3ShZG3cCt04PWe67QCrVFTFAVw0GV/9BJQgevN1JgB5kxJOEka/1VavIpPdT4Zub4Ri48=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 IA6PR10MB997681.namprd10.prod.outlook.com (2603:10b6:208:5e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 14:51:54 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:53 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.6 6/6] xfs: fix unmount hang with unflushable inodes stuck in the AIL
Date: Thu,  1 Oct 2026 20:21:03 +0530
Message-ID: <a284ea2b166d2356f93ccffd4052b1df2b0bc703.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864521.git.siddh.raman.pant@oracle.com>
References: <cover.1790864521.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|IA6PR10MB997681:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc89ba0-8399-4c25-6299-08df1fcb85c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|23010399003|10067099003|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WjXJ7Y/uJ/UlWAqNFwOMK8RUcaz3kWIDN/ba6owlsO/9LGPnimgLAhcfEVIwnvBFWLu6QGTAakfqfakQtlpN74xYc6chQJpn+pCsGLGyNs0tpWS2TPK68JRrVNDShELl57CKK/K5ZrS69uDlZ8W+V9rEL7qJXmffcz/9LzQuo+EJkNoTZNj0K32tnV+GjGNDQ7Y2aRbLabUTIR4LieM51TPnJtgy4fX+MPh1FCpQJGNlNxT+Qx6s+tdwfqs99M3xfoak8Jgm8E3fpcfrvkuRnRH5gCk510xsdvtnNfIpPWEdbTXl80llDooi/wiXbKCyNO9x6Erj/1kl5X0wYBWxluIJD8wkXElKtm/jB7wlym1y93iwd6bmthk6n8BU5Y49SE1KEyvh6VSvdzyIaI46w0+bwAN1+Ou6rsyOEUk+Xnm2yktoxAxatZgEqff9u1biHmsVDIAaaF0m09KvGoP2Tn5a+KJtlgCx00mejWG3E0D6+XEtzwx8F0ZcvJH5ppwNGS+Wy1MCYoEyDhsK42LKm9POk4YrXRV1lkYdL8LQccXmWZ/SO2V8WLatg5pZQwwPZOkcu/rhaqc/Hs/e2OiXoeJntUVEG8ff+AHxTYwcqH1jou2AWTIv8w9GHIPwng5l5SbuG67o1XYex3ROlTOcIyihmYutgEBZOe4c6fNf4fM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(23010399003)(10067099003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+unI687aNpLG9doKzcGfbPzlx9cSKATnnIZOWfo4Q1QfaQX2bJXlQY9SX2s5?=
 =?us-ascii?Q?jLG3bHAiQZt2wpOrh+PRYtfYQpe+uouRJ/hzrjuyCV7kpEbG94Rxfz9jp1Rv?=
 =?us-ascii?Q?BSPrK7xMUuJXgmYfzMCwMTgBTOJsoWQShT/cc6oZ7u4kUsgo4GEjgi5sG1m/?=
 =?us-ascii?Q?DdiAOcqa5p1KbG1ydkOgYQURBFr86uiua0eJqRWheZvX4fOhmLjB7YKhzpAQ?=
 =?us-ascii?Q?WNRtmylmDRYSZKUK62vlQCuu4CWa+FFDUd5N+AzQ+ymlJxq9HE35m7MwOLNy?=
 =?us-ascii?Q?lccoS68rWCRXCM7zmEJ4wuIwwh9k2H2tK+8DomPjJiSIo5UlI1J1lI/dLad8?=
 =?us-ascii?Q?+QxV2NibA3p3xL33X4Y6Jwx5WFDC+yeNkpyHnIxs//6lzgArvhg7zwNg6Y9F?=
 =?us-ascii?Q?QWi57WTq00xfQq8bbxoHKu6mZR+2WB3no2ewTiPa5uTAQ0hz3jbWbG1OGqSg?=
 =?us-ascii?Q?SSm1EnWiS/iRjsMwjJtPwEVQdN+ag00L1ptn9NJHk8gOGFZQ/Sfgvpf+bann?=
 =?us-ascii?Q?pvgfYqvhNXixjKCvDrk/pkGlEIMtow7x16R384EmkQ+FQae4YckrW7u4+BVg?=
 =?us-ascii?Q?o4DWni763i2+f6XEAif2fmUGD2fXDLiWSTp0nyt/zYm6OnpJjYq1TQXyQB9x?=
 =?us-ascii?Q?Dt+XhsEe3T6CxS+zakWR7pVhAq9OL8/notXQR7MW61prQCG2PhVgmxIOjGsG?=
 =?us-ascii?Q?/vztiFwyrnWNbnZPWO6J9Bkygia0SDYN3iFjDAv+Zoq7dSG2q8lkb/jdx9fR?=
 =?us-ascii?Q?aux5Ar0L/IGd2BMw67PU+76err+tjNuxqvFPAb0VZSN0LeHfYgvhfFmQAYKC?=
 =?us-ascii?Q?0ALUXgyl8f4ilZXa6d2XkNdQqBGcx2lA+wGRREK5eB/kYLYnl2rL9jPHStrU?=
 =?us-ascii?Q?GScKAdJn9kCcod07m5dASpVPZVpwtDPSI5cJBEAwSlfKGom2cJSByzHHrFO4?=
 =?us-ascii?Q?ZLME9zb8dpxNbSNdabp8GnP1rmgj7ltNaztANBtQqlMXGPagqAdROe9t0qh7?=
 =?us-ascii?Q?RuRC4aQPrDiUsjlg/eAygzSiywVRkevFo1njU7wtOYThkJBxWfQNmXwVgZTN?=
 =?us-ascii?Q?idLfVqkQ7bOVExYbWIWnNo3K9YscBh9n6qfMMEJP+W5VA1KT+rIPy5l2zQq3?=
 =?us-ascii?Q?6tvpMU7I4KeBw4o4+6+BcRElLj4Zd67w6EODttOv1Vgcsl/IiWpZCazZ4L/f?=
 =?us-ascii?Q?B+Qre/TDwhaMXW3HViVfrFA6pN3PfXPie68fW50FGxEWy8YyxW+MKTCFhwRc?=
 =?us-ascii?Q?moAt8nmsTyCKm6KbAD3/0yDT48FZeQ3BjOiceMsOTBCCI3hB6m2hz0x5+N9B?=
 =?us-ascii?Q?MAyhJ8Ntv9o8xC/blMvl9i1tE00u5f63skBT+omz9UaAwHuLaHq85dW/oxnX?=
 =?us-ascii?Q?M29GUZ0gTps1TdJm1Ee/TdvEWBkowq1Q+gMlVLo7ESBIQaTJU4GQYgBZsVJV?=
 =?us-ascii?Q?7ATRr8W+qK4pKLMLy++gTguu30Q5jWpbNzlgO1WrnBg7Pt+GbbxaA74QrKdy?=
 =?us-ascii?Q?4y7HQiqzBkwfasINDnECuH87rua3q5u4ts49LjZ952Ix+/0uImr/3Z3Ogk2+?=
 =?us-ascii?Q?SIerdGxbpc8ib8gjgykCcgmZIOlZJQ1Hb6fasDebq9crfmyNhtvmaspbH1EA?=
 =?us-ascii?Q?JmG3xg+A1+ICYnCeXbQEoI7NQuOwukAcamyWc4eUQC7DbRcXwdRZdJ/GYu/f?=
 =?us-ascii?Q?ps7NwAmdy6YcVdpRHBizsaCQXpJaXxX8V1nYqI1apQLF+r8nyUipz0YOftb2?=
 =?us-ascii?Q?HGsEAQGrRiOYDHAaW0r2ckSRGEHqsxT+NuJGlc7lZ8+wF9VDDX/Sn4yY1uE9?=
X-MS-Exchange-AntiSpam-MessageData-1: PT7wHTgBWYhBOT1mECin3/FpznqI4ofFt+M=
X-Exchange-RoutingPolicyChecked:
	bFG8ESF5jss4tjQnUqtB+eDl7hCtE4VImS482qxDmszlUgt5FszTsouG02vT+/RK4OPgSVVGLXbo0ULEcf5J7rvU/d+rsjL1aU5ib+gaf30Q0xbagdpLso6RnONqTOmFjscD+H6LJpXVdBIbEckKi+WOIXjBVrU8Mrtsu9fWN6X6e14QcbSXJr9uLd7b7uUvvxqnThA4vYOrU+VcYIs5sm5Ck2IW3EjwcZOegc9isae+ygnQl7yzPmls7R6RFNJ0jTUGy/jduQTSa4AEyn0vkdN+84OTdePEBjmm1OJRrcvYAYvEHhCSlSXivc75qePl7GT/2XdKXa97Z+QA+2VMsQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GfFj9K7MeoxJsYd1DSpYngKipURb1Ppu8wCLMG6C1Z94cxhXFlu/V3I0redZygyoHkuAcxf8WTR+zYHXKDGmmXmxs5c6mcg4JyOK+vUbBbkKlr0AoTRcM+f7sjZtmSTI8YCszxDgjam3I4i0KmFK31D3BT2bz1LcwMHWSulfIo8mrQ6seHavsAE2H4XrQUvdeGWYXSjn+KPd7fKABpVLzk3kcd8/kjXvFeyMNx5lbKmPzHgkPVJot4ml5PZKBmKibg8Faz9NCIIQojAxefNCtxFHx+qdWh1bxZHH+ef/LguyKOfWP7j1RKk9+VE1pVDzAunwu4WZ3fogIKPAiFWZgUNYFe0uZnd+gDDvqqDHA3Kpyx24ZnN89T0go4KHiGfKwp8T8QUJBT329ab7FIlvu3m/W5UDy4W69l6j67TBKkTLpgRUCgSklZGIGfnnXp2M3SQ8frfa9GT0HdJ11Mc7T13PUjX7GUfH7Fk07GU515/JB+krHNnFflG9JYIcnt0WKXnKLyoS9g1RIUO+F0r1kHmq+NlPi3y7Ke45PHTXI6CI6Ch4dfT8BjsT8VG/ZXNvVfbNOCIVFy8SuXavrZVRy0tD8K8pqmSVG1MbwLT4iD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc89ba0-8399-4c25-6299-08df1fcb85c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:49.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es4/Zc6CULH8S6LCsvaMMx87HdT/XpO+W0TklmW42YwIkCcDj8RfHqF4A3JVEoj7U+QppieGKVWyxWmGY0gzsP6jGzAX9eLPsseJKUNL2AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4cHfzsUsyl/8
 wKz5sUlOArRyI4WuA2db33N69nGhHqrmpwaPY0ZNDZW3n9cIxCBItcx4eCF9De5HxA9fUvtKeW9
 QXoiJzbAqAGZiPNkvoqcPYmYJ4mB2YjRixK8q5acXDxA2zMBowUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4En/t5u6zFsi
 fKtW93o4p0OnPUF2hjqRY/4RDr4r+prBpOyShOGLKI9swkf+wz6/K5pXL1pbyGqF1zPrkPVWY0Y
 /JSWytVswkxFdIPIsUY4q57JoJkuSRS1aMd/X2hCLpUbjU1m8ywFQniGz4sIHDY1Xs/UoW1mGE1
 mXRMAjhaXLlWifhdXYvhHFMflKiE2O8pF/bTpogL5B5dFgW6oE01cCatZs+ND0IsCE4zQd0wpob
 S57+IAubiAesSLwGB4Nlq0npt1rxw3+1VD+HqIA6lJveDe05AZ9BPtyT/8ZovkIt/DJpmq+R+Th
 cnzagwNX508zIcp6JCMqHMMj0L/f7jKqtRuP0zwKELD3zEO/uQz2Yu6VFuhxAv9BIdPhJZ076D3
 Giu3AnlkxMfQ9JyJnTDcTB2KTYJYBqWGbxo5aKquSQnF7aXtGxMfh6ziSP/am8jvFk6IpF0J2Tf
 fJYhzSsA+UeYj6s+Dzg==
X-Proofpoint-ORIG-GUID: U-UYaxMOkEDNmsALcCkcwRBHVR0U0QCZ
X-Proofpoint-GUID: U-UYaxMOkEDNmsALcCkcwRBHVR0U0QCZ
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe738e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=6pTqLFfXKm7bnsEQBbsA:9

From: Dave Chinner <dchinner@redhat.com>

Unmount of a shutdown filesystem can hang with stale inode cluster
buffers in the AIL like so:

[95964.140623] Call Trace:
[95964.144641]  __schedule+0x699/0xb70
[95964.154003]  schedule+0x64/0xd0
[95964.156851]  xfs_ail_push_all_sync+0x9b/0xf0
[95964.164816]  xfs_unmount_flush_inodes+0x41/0x70
[95964.168698]  xfs_unmountfs+0x7f/0x170
[95964.171846]  xfs_fs_put_super+0x3b/0x90
[95964.175216]  generic_shutdown_super+0x77/0x160
[95964.178060]  kill_block_super+0x1b/0x40
[95964.180553]  xfs_kill_sb+0x12/0x30
[95964.182796]  deactivate_locked_super+0x38/0x100
[95964.185735]  deactivate_super+0x41/0x50
[95964.188245]  cleanup_mnt+0x9f/0x160
[95964.190519]  __cleanup_mnt+0x12/0x20
[95964.192899]  task_work_run+0x89/0xb0
[95964.195221]  resume_user_mode_work+0x4f/0x60
[95964.197931]  syscall_exit_to_user_mode+0x76/0xb0
[95964.201003]  do_syscall_64+0x74/0x130

$ pstree -N mnt |grep umount
	     |-check-parallel---nsexec---run_test.sh---753---umount

It always seems to be generic/753 that triggers this, and repeating
a quick group test run triggers it every 10-15 iterations. Hence it
generally triggers once up every 30-40 minutes of test time. just
running generic/753 by itself or concurrently with a limited group
of tests doesn't reproduce this issue at all.

Tracing on a hung system shows the AIL repeating every 50ms a log
force followed by an attempt to push pinned, aborted inodes from the
AIL (trimmed for brevity):

 xfs_log_force:   lsn 0x1c caller xfsaild+0x18e
 xfs_log_force:   lsn 0x0 caller xlog_cil_flush+0xbd
 xfs_log_force:   lsn 0x1c caller xfs_log_force+0x77
 xfs_ail_pinned:  lip 0xffff88826014afa0 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88814000a708 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88810b850c80 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88810b850af0 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff888165cf0a28 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 xfs_ail_pinned:  lip 0xffff88810b850bb8 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
 ....

The inode log items are marked as aborted, which means that either:

a) a transaction commit has occurred, seen an error or shutdown, and
called xfs_trans_free_items() to abort the items. This should happen
before any pinning of log items occurs.

or

b) a dirty transaction has been cancelled. This should also happen
before any pinning of log items occurs.

or

c) AIL insertion at journal IO completion is marked as aborted. In
this case, the log item is pinned by the CIL until journal IO
completes and hence needs to be unpinned. This is then done after
the ->iop_committed() callback is run, so the pin count should be
balanced correctly.

Yet none of these seemed to be occurring. Further tracing indicated
this:

d) Shutdown during CIL pushing resulting in log item completion
being called from checkpoint abort processing. Items are unpinned
and released without serialisation against each other, journal IO
completion or transaction commit completion.

In this case, we may still have a transaction commit in flight that
holds a reference to a xfs_buf_log_item (BLI) after CIL insertion.
e.g. a synchronous transaction will flush the CIL before the
transaction is torn down.  The concurrent CIL push then aborts
insertion it and drops the commit/AIL reference to the BLI. This can
leave the transaction commit context with the last reference to the
BLI which is dropped here:

xfs_trans_free_items()
  ->iop_release
    xfs_buf_item_release
      xfs_buf_item_put
        if (XFS_LI_ABORTED)
	  xfs_trans_ail_delete
	xfs_buf_item_relse()

Unlike the journal completion ->iop_unpin path, this path does not
run stale buffer completion process when it drops the last
reference, hence leaving the stale inodes attached to the buffer
sitting the AIL. There are no other references to those inodes, so
there is no other mechanism to remove them from the AIL. Hence
unmount hangs.

The buffer lock context for stale buffers is passed to the last BLI
reference. This is normally the last BLI unpin on journal IO
completion. The unpin then processes the stale buffer completion and
releases the buffer lock.  However, if the final unpin from journal
IO completion (or CIL push abort) does not hold the last reference
to the BLI, there -must- still be a transaction context that
references the BLI, and so that context must perform the stale
buffer completion processing before the buffer is unlocked and the
BLI torn down.

The fix for this is to rework the xfs_buf_item_relse() path to run
stale buffer completion processing if it drops the last reference to
the BLI. We still hold the buffer locked, so the buffer owner and
lock context is the same as if we passed the BLI and buffer to the
->iop_unpin() context to finish stale process on journal commit.

However, we have to be careful here. In a shutdown state, we can be
freeing dirty BLIs from xfs_buf_item_put() via xfs_trans_brelse()
and xfs_trans_bdetach().  The existing code handles this case by
considering shutdown state as "aborted", but in doing so
largely masks the failure to clean up stale BLI state from the
xfs_buf_item_relse() path. i.e  regardless of the shutdown state and
whether the item is in the AIL, we must finish the stale buffer
cleanup if we are are dropping the last BLI reference from the
->iop_relse path in transaction commit context.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 7b5f775be14ac1532c049022feadcfe44769566d)
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 121 +++++++++++++++++++++++++++++-------------
 fs/xfs/xfs_buf_item.h |   2 +-
 2 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index f13df8adcf4a..af128e06e841 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -707,43 +707,42 @@ xfs_buf_item_push(
  * Drop the buffer log item refcount and take appropriate action. This helper
  * determines whether the bli must be freed or not, since a decrement to zero
  * does not necessarily mean the bli is unused.
- *
- * Return true if the bli is freed, false otherwise.
  */
-bool
+void
 xfs_buf_item_put(
 	struct xfs_buf_log_item	*bip)
 {
-	struct xfs_log_item	*lip = &bip->bli_item;
-	bool			aborted;
-	bool			dirty;
+
+	ASSERT(xfs_buf_islocked(bip->bli_buf));
 
 	/* drop the bli ref and return if it wasn't the last one */
 	if (!atomic_dec_and_test(&bip->bli_refcount))
-		return false;
+		return;
 
-	/*
-	 * We dropped the last ref and must free the item if clean or aborted.
-	 * If the bli is dirty and non-aborted, the buffer was clean in the
-	 * transaction but still awaiting writeback from previous changes. In
-	 * that case, the bli is freed on buffer writeback completion.
-	 */
-	aborted = test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-			xlog_is_shutdown(lip->li_log);
-	dirty = bip->bli_flags & XFS_BLI_DIRTY;
-	if (dirty && !aborted)
-		return false;
+	/* If the BLI is in the AIL, then it is still dirty and in use */
+	if (test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags)) {
+		ASSERT(bip->bli_flags & XFS_BLI_DIRTY);
+		return;
+	}
 
 	/*
-	 * The bli is aborted or clean. An aborted item may be in the AIL
-	 * regardless of dirty state.  For example, consider an aborted
-	 * transaction that invalidated a dirty bli and cleared the dirty
-	 * state.
+	 * In shutdown conditions, we can be asked to free a dirty BLI that
+	 * isn't in the AIL. This can occur due to a checkpoint aborting a BLI
+	 * instead of inserting it into the AIL at checkpoint IO completion. If
+	 * there's another bli reference (e.g. a btree cursor holds a clean
+	 * reference) and it is released via xfs_trans_brelse(), we can get here
+	 * with that aborted, dirty BLI. In this case, it is safe to free the
+	 * dirty BLI immediately, as it is not in the AIL and there are no
+	 * other references to it.
+	 *
+	 * We should never get here with a stale BLI via that path as
+	 * xfs_trans_brelse() specifically holds onto stale buffers rather than
+	 * releasing them.
 	 */
-	if (aborted)
-		xfs_trans_ail_delete(lip, 0);
+	ASSERT(!(bip->bli_flags & XFS_BLI_DIRTY) ||
+			test_bit(XFS_LI_ABORTED, &bip->bli_item.li_flags));
+	ASSERT(!(bip->bli_flags & XFS_BLI_STALE));
 	xfs_buf_item_relse(bip);
-	return true;
 }
 
 /*
@@ -764,6 +763,15 @@ xfs_buf_item_put(
  * if necessary but do not unlock the buffer.  This is for support of
  * xfs_trans_bhold(). Make sure the XFS_BLI_HOLD field is cleared if we don't
  * free the item.
+ *
+ * If the XFS_BLI_STALE flag is set, the last reference to the BLI *must*
+ * perform a completion abort of any objects attached to the buffer for IO
+ * tracking purposes. This generally only happens in shutdown situations,
+ * normally xfs_buf_item_unpin() will drop the last BLI reference and perform
+ * completion processing. However, because transaction completion can race with
+ * checkpoint completion during a shutdown, this release context may end up
+ * being the last active reference to the BLI and so needs to perform this
+ * cleanup.
  */
 STATIC void
 xfs_buf_item_release(
@@ -771,18 +779,19 @@ xfs_buf_item_release(
 {
 	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
 	struct xfs_buf		*bp = bip->bli_buf;
-	bool			released;
 	bool			hold = bip->bli_flags & XFS_BLI_HOLD;
 	bool			stale = bip->bli_flags & XFS_BLI_STALE;
-#if defined(DEBUG) || defined(XFS_WARN)
-	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
-	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
 	bool			aborted = test_bit(XFS_LI_ABORTED,
 						   &lip->li_flags);
+	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
+#if defined(DEBUG) || defined(XFS_WARN)
+	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
 #endif
 
 	trace_xfs_buf_item_release(bip);
 
+	ASSERT(xfs_buf_islocked(bp));
+
 	/*
 	 * The bli dirty state should match whether the blf has logged segments
 	 * except for ordered buffers, where only the bli should be dirty.
@@ -798,16 +807,56 @@ xfs_buf_item_release(
 	bp->b_transp = NULL;
 	bip->bli_flags &= ~(XFS_BLI_LOGGED | XFS_BLI_HOLD | XFS_BLI_ORDERED);
 
+	/* If there are other references, then we have nothing to do. */
+	if (!atomic_dec_and_test(&bip->bli_refcount))
+		goto out_release;
+
+	/*
+	 * Stale buffer completion frees the BLI, unlocks and releases the
+	 * buffer. Neither the BLI or buffer are safe to reference after this
+	 * call, so there's nothing more we need to do here.
+	 *
+	 * If we get here with a stale buffer and references to the BLI remain,
+	 * we must not unlock the buffer as the last BLI reference owns lock
+	 * context, not us.
+	 */
+	if (stale) {
+		xfs_buf_item_finish_stale(bip);
+		xfs_buf_relse(bp);
+		ASSERT(!hold);
+		return;
+	}
+
+	/*
+	 * Dirty or clean, aborted items are done and need to be removed from
+	 * the AIL and released. This frees the BLI, but leaves the buffer
+	 * locked and referenced.
+	 */
+	if (aborted || xlog_is_shutdown(lip->li_log)) {
+		ASSERT(list_empty(&bip->bli_buf->b_li_list));
+		xfs_buf_item_done(bp);
+		goto out_release;
+	}
+
+	/*
+	 * Clean, unreferenced BLIs can be immediately freed, leaving the buffer
+	 * locked and referenced.
+	 *
+	 * Dirty, unreferenced BLIs *must* be in the AIL awaiting writeback.
+	 */
+	if (!dirty)
+		xfs_buf_item_relse(bip);
+	else
+		ASSERT(test_bit(XFS_LI_IN_AIL, &lip->li_flags));
+
+	/* Not safe to reference the BLI from here */
+out_release:
 	/*
-	 * Unref the item and unlock the buffer unless held or stale. Stale
-	 * buffers remain locked until final unpin unless the bli is freed by
-	 * the unref call. The latter implies shutdown because buffer
-	 * invalidation dirties the bli and transaction.
+	 * If we get here with a stale buffer, we must not unlock the
+	 * buffer as the last BLI reference owns lock context, not us.
 	 */
-	released = xfs_buf_item_put(bip);
-	if (hold || (stale && !released))
+	if (stale || hold)
 		return;
-	ASSERT(!stale || aborted);
 	xfs_buf_relse(bp);
 }
 
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8a8a46e698be..141c3780a36b 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -49,7 +49,7 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-bool	xfs_buf_item_put(struct xfs_buf_log_item *);
+void	xfs_buf_item_put(struct xfs_buf_log_item *bip);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
 void	xfs_buf_inode_iodone(struct xfs_buf *);
-- 
2.53.0

