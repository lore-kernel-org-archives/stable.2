Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CD3B19AC;
	Thu,  1 Oct 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866274; cv=fail; b=GbkPDPbgq5x6xuK5Gv7XOPI6I+3nEh5sRjgYoGwY5fbZysMkAkCZ4TvMRt3+gwYAgveXK7FgLjnf0yNDWONn0gW1uYVFXaU2rYGFLFHQSrB+DoPTmCQkNqKdAKfOPYyWS2AlH4AAF7YzPh92l6TyLnxnf/T5/kJC1NLBmzXlUOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866274; c=relaxed/simple;
	bh=NdcDBYtzFhsxHeCTVFkLjp5xS+Y6QX39I0P6psPdzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3Uw1h1LaniUlwA7wLyM2UDqJyzNWieoETl1ALQiLNqiO2OZpQrtQD8tNCAw6Xcz7MF4h2VUD3wWFGRW/0wpK7rvjjkMYPTyyWk9Wkv5CyncbtDcYte70gKLAfBSJuJvHk1NJ6UkuC995+bjIP93ZOaEt5kf//PNQAP9XvsefRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFEnCnXn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UpmdKVER; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFEnCnXn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UpmdKVER"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMco82256887;
	Thu, 1 Oct 2026 14:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wFsqW2CMOiOxAcbE6P+wRHwTtDvVPd2uvY7sckcHFnA=; b=
	MFEnCnXnCThomyzWRJ4V8ay08j6i67PtdFkx2LeBIQj8V/YgulqLDX1KlR3XISCZ
	/L5lB8eEoADjddtEbZR43tMq+xKEX1GkqfJX2P4Zb1wcFJ9+E9CFFBMBH33ZUjWT
	oe08xyHS0B1NyuRKU1UeLR4tl32x5VrMjltjbduII8omtM5kwouW94Baovp1EdFR
	mKD6lpnmAkOe23w1Bsc+6eC7SinibS2r5lPXnhXUPN07qSnkuWNkBx9O2xwsWCVl
	yK62k65anTrmFICLi/hKhTQltKQs/MTWzJ6yQ2DOun6TzSOSRsu2kvTvyS3c+Jcb
	dG6HN7h4xk0VC7xdB4gTQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Eo4jP011787;
	Thu, 1 Oct 2026 14:51:06 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gdxr76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksE7lZZKJB8J2o7e7TxEVEnWLuP8Nx1a2NInma7pRxU9h3XTPQonhvS85w5hCv9/aec/tLwUaP0NYbAIl3FxNuAIJ1YJhsWgv8R12izxsq+EEgxiUod0sIQ2eGa7bDaYUPIyNdPmZbCblyOXJqXvNp6kdHKXwwcEEZLvxuRlzztgPFo9c1MhD/6sAsT92aXI2h9z8o6ma2xLFHtORKcts3OFt2wE2BuQI+edbBZoUEBINujZ7uJwxrYRD0JPsnJ2fmEAC2Peuj1BoHW0vveH+2KtuHlEUpCbqnNd52cEeuyVE5RwnEdSJqz7DpXA8zdPKsNKYrEE0GKpY/NX6GuU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFsqW2CMOiOxAcbE6P+wRHwTtDvVPd2uvY7sckcHFnA=;
 b=g9uLUUXOS0bDxPkgMKj85iTJCcg5/A/+HpUNua+7WkNNm+KBua4L4SPhVbtRaxAzjwJn4QuQotYgnvEHUAPI6eg14rH9koMozchH+Di6FcnpfNfldmCkZQaAbsT2Bo4i6524FiWir2EWVKWFKuMzl5SQBdCVB83kJncXI/Juep3HFKJKn96cqtfCiENpuBIXVD/StJsLshNG9bfU+VvPOETzLUspr6hkuXTEYFYuucq5+0WOqStykrDRe+BB0Y0vvfEyLdfXWghu+42pvfXPxL456VNxPsxGSlproscIDW9Uzlrv3qvTDmJFAHVjnUlEwgXYW/r8CSaSSismGEV2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFsqW2CMOiOxAcbE6P+wRHwTtDvVPd2uvY7sckcHFnA=;
 b=UpmdKVERkDmEeySWabo1iPwz396+2FsVhc2h2+Yje2o1shod15bmYkQbcmZa9bKIB6WDFEhwFkyijxJB7B/gLBFfnJMdIURORD605/pRL/D0WBpEm000RTDClU++6v1OCBsPh29YdRhmyMqAzUHPWNt/nAG3At2k3B1tczU0EmI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH8PR10MB6411.namprd10.prod.outlook.com (2603:10b6:510:1c6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14; Thu, 1 Oct 2026 14:50:59 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:50:59 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.12 0/6] Backport of XFS umount hang fixes
Date: Thu,  1 Oct 2026 20:20:46 +0530
Message-ID: <cover.1790864403.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090954-revisit-dowry-37ee@gregkh>
References: <2026090954-revisit-dowry-37ee@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH8PR10MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: c23045b3-ac25-4f5f-5a7b-08df1fcb67d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|10070799003|1800799024|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	thl3e0UQQCJ8aoPEAmQzwTHDjEP2MTdH2iulmTwpyRItDQe45kPA9Ao4HrjBHviS+VPzS4Y3Fn0vHim8h85chwUaV0xKIBjXRNe+oZvzhSFLPqMJqOc6eLJhtqn01HmVrB4KawfxO0Y4PrNA9OHgdvTT5pz38SiwP9j+6HVvo3aggKaY/GmT4OwqYi1hRtem5InEqqXmumPx0X3MlwQpa/Phc8WwPCDPsjUnGiMQfuxQVds2OxdAadw/cFPwoUkCVKMwbEEDgo84V+6cGGkbxQbzEL/p115QTeTD4AyB0RvXuYHLoKVcrMDk0J2PoJJKMdh0gzMYMX0A1kRsoJevYEsAW/oMSa/zp1fmWXy/CQiwjfCL1Pd35lNN68u9d2NKYgcUytsF/GVCODBAFGbpGSU1MqlFZlywxsLdj1lI7U0Ja4GdQP8IBi1cle+S8aa1Mx70QDAYFDkn1hA7zFLmwcUUJODMw7SSpMUXKRnNSkTt8yOb2LysZnmTMdt4ZizthHOhCFuAt4fwhhcGiZK8c4d7CEjsL/ssxPgd1mM7HLjrwBGJgbazPd6cDYmBzY2k4AKfyCgaeW3S7pyRbZX+I3Sxvp7y6Te3IrZWGeCSMji1ElK3PVnl6oat2bvPcJiYMchdykVGwlufhqcX0wSwO2w8C+1CQ907JNBgZPFYY2A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(10070799003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9qIVgs+XitH3qx7WhKxH3PjkxdONP4YB6JLUNpnEUXZvhqYO3JDRAYANW6W?=
 =?us-ascii?Q?/ENVjjiDrCqZ5VMKmLnIkk0SSOATPWTClArYXYxCmgOpUfO1u8slj+W2KXWH?=
 =?us-ascii?Q?h2SAnhunXWSEHBjjILmc+Xi4IMtiuSHJpPQju3I4lfCH9L4Cj4MTth12iFb+?=
 =?us-ascii?Q?sGvMLd6uSpemCaE0cruyDt0jytUkLp2EfZwkx2EJmwiEJMXDG81r7sNvq995?=
 =?us-ascii?Q?HYyOJFEZ/uWkGh/IErCKDDAF1y/RGbQwwZdeUKsGk8Jd7M52G+87DYusdbWB?=
 =?us-ascii?Q?HDssiJA5IvDlnr1hw1HFGK0EkVTBj2LeHUYgispX/weCLuOARChwq5C+GHJQ?=
 =?us-ascii?Q?Ie2YIINc6/dvYh5DJO1LJXjYNE1WhtA4kQTKpzjRZbqD8mMgxy9Mg7p13cYX?=
 =?us-ascii?Q?BNo0clwooVZ8CO4+hc2LJXO02d7f3///NbgSIdQ6zXDqe2fPcYn88UHQDQGs?=
 =?us-ascii?Q?1/KCpHe4G6zFJHLp1N6/4ujaQQfk+upZ5aHR7IdvMcRVLdTE+gUNeicrF8TF?=
 =?us-ascii?Q?cjAiAm12QzK7BgXk0Q+cPmLXxWvqvkVob2gaxMJ5qq1/VrLwMpHRfdL9FgZ7?=
 =?us-ascii?Q?Rqv3W2AbQooc5JTsibyg1nQX4Jx8WPPfE+tWvnY2BBFWGGj5mZsqzdY5zEEd?=
 =?us-ascii?Q?X3RQDIsC+dXE7gBCtl8MD/R9LXe910C0HVKdHzC0wwMn/Hq/KGjyvA/GFQbZ?=
 =?us-ascii?Q?P/AK44+bpu5MxMjND8K1ARjNzQyZBSTeAB5nv2k5Erk8uVkn2lQQJENShH5q?=
 =?us-ascii?Q?iI45Oz7k3z4YRYKcXWID1YlAbc+8Tk+brHQCsMSJ3TEj2roxtWijAr4ztcfh?=
 =?us-ascii?Q?KQ8RTS8FyUHxAXV2PfCzGSLmRO/3lIPrMfdMMZS1sP8Zs+MPcDy4OvjF21/Z?=
 =?us-ascii?Q?Ql57U8rYynvo6WudRkMzAul0YaoSrzmmrMJ42K27UzKWk3DazKPXgPRhppy0?=
 =?us-ascii?Q?j27T3lVlGD9f2xA29mDq0kroBtkSiNYug+dVRwEn9iSPj6c+vN/Q5EvUDdAC?=
 =?us-ascii?Q?dl+FdWZHutKrFuhbA7ghJyN44AyusQ4ETHfbiut87SrWlpR8GWn6vGzlcTE0?=
 =?us-ascii?Q?VbgOVPSTcIP8Cl0pmLeNOqLOYfx4NOVSFhDhP1DMpoqdJGlfbbzpH1VaLwKb?=
 =?us-ascii?Q?RxBqQCCIJu41RtPRaDHIt/sj+m36zLxS0d8kB4cbCjXvXgG/A2QjJNLzXAhY?=
 =?us-ascii?Q?JbQi/nVYKElR2u5p2s1cijyUAZ+XkOovxSDxssnrhV5igcZ6Fh4SE1Zz9j89?=
 =?us-ascii?Q?ZQoB4MyxgJc1zKXncOPjXuA0vx1bpL29VynKF4cjbC/KQby1Yhu+npAt0UiP?=
 =?us-ascii?Q?/h8hohy3fzYmTO0avR6Gf6PJBO9tOrfDmk4gd1M+7WI1jGtb+Yme34OOoynZ?=
 =?us-ascii?Q?YGFxA3wv6B7VcSlRvd6+REOuUGgCaFl2FABTXRHKVI3oiQ2Tpm7Hbw6o+s+w?=
 =?us-ascii?Q?/VjcslP72E9kOYfkJEBbMTpX3gzE5A9UIqUH8gkczGc0q3XlZHfWlSpnTk0N?=
 =?us-ascii?Q?lteTA3jbP5LxDc7inxDrG1VeEnG1t+wgnXuWXU/xKaw47/CHmeU2EW+hpDYl?=
 =?us-ascii?Q?M664JN/j1HFAmyOeERvryX3WbbcpKNLn4VY+Pu+rT2Efk5bw9LHcqJDkTVKz?=
 =?us-ascii?Q?MMuulP1f/XPGtM+phbFX1oeS6j5PWEO76M48mTI+BeHV1Zsa3sfPzzEsEpGc?=
 =?us-ascii?Q?JzBI45tWzKqaJ/g3BZSY3e4pD5Nk/EAkzR6xRO5bmy0xh5u10AAw0hjxjp4a?=
 =?us-ascii?Q?Ql5olAEsYorln6BSrPENn3l1Kepi5jQtyvVPMKxVYl4jkm0WRkFsoyGeTYmA?=
X-MS-Exchange-AntiSpam-MessageData-1: IoCdiuKH7nMrPXVE2YDYgGttiSmqafvQn6A=
X-Exchange-RoutingPolicyChecked:
	PURzLJ9UG/J2fSjs0vKN1+lqmPBRthIdktrh8/qVi3T2rFs/dXzryP8Czkxg0qcw0uWgGdoJ0bii8Oh1h+q16PSsg/tD8qJyjcAaudnUeycEtExogXToRYaH71UHhe6vWAwaiqP/kT6Dy7+W8m6j57JDjPtuFG837oI9c3Lg+v+EfYYoQqiON06eg7QCvug4bgGVnLgvoL4oS5OFpf4JAx1DmVXJChiXFt8VMb3bw4I0b0qH2RiOTw8LdNBb/qj8yqNMlkVCp+tvnpsEGlPxd/u1M1IDuyeNMz3Xks60KUjNIBUNJvkYL0bhoUepUWe7VIZaQMJ6T5E1/BkazPUc0Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GOrUOPRUukcgyKlQiOI1EvW1om3b321UxeOg6NzAuk1rDDqosFatkCZEQBu3eKYOskvZOlGXP6sAclhIv3dcHTTlcWHTyj+f2LP8SG1m+k7ZHvQ7eq+lyWMGQ16Ft2qVtKbPtGzFQeU3NApCebGVhudhHU3Dn19mYytPnddZGwCcPN+N3xAYjpCYSzixQE+uUq1ljT9dz6WmGi7gw6PtqgzG1rhOpveAWhv6AOUjOldKckcXA6LA5ETGnK1dtWPbkzKapMW3LxTCWIFR3Sqk6xph87Qkl3LM4CU3ud029uLcmfAN/+2H1D8Y4xwYyZeoV4IeUUi/2dgMH7EKsKobT+A5l9pkPa50e07Tqn9DsdoJaECpP3yfeTNI6J+SqChuPf6nslWGws7LC1otS8QLypzbooTVKudL8yhHiw0a0HZdl8Xh118XM7aVzxKSio75UkDp/41yaL6yJknY7CE6+UzE7AyQ0710RkD6DicdmJGwpjTiwgfeHk39Ixa1qWeRkpQkmGXsfNTAfvzdI6BjGw1yYMoYtD4fLdEeou3LyhsqNrNl85pZIoTo/gNZMGK6k+ZXpmupvd7/GGFD4u/s/JaMxbHb94+K6sxx+xPoLHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23045b3-ac25-4f5f-5a7b-08df1fcb67d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:50:59.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhN7DYNPyTWbUj75+V7LUSD9fSt9iK67P5CeaaucAcE5/IIpHCMdHYm6Vr60YrDkngM+rUK3VMdFbT9UHIcgI9F7UvVfrJU9rSlH+fD50jQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=885 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX3D3RDef2MOGL
 mTZUyVx8BfSjftjMRSyly/wY5oLAA4zcG+7665qcJI6CTLf7UX1GvpBoA9M5N7t2SbQpWEWvgog
 LrAjan3Bjt36ZRyGBU6MPI0ozyw6XlGR0rX1YKY81peUXpR3uhBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8eZyRh9iERmi
 XxJgzZPdn7iXCwDRw8b/yVHyI/Mhq7cwE7YBkHil5y0PtvtJYs4vJn83zKODTUPZV92ajtbQFaF
 BUyPp1py5C5f/tSIctpG5bNzBPhOMJcYeNcVcXhKviphvH71yfSsMfaptgRLPGqb4X8puEJhXjv
 CDf4QhoX7ATmmPvPohUMM6EDdTpTvOAELW3iMGwxNugBfm8fNR1EZuSPhRmKHmdT/tF0VbdXKm4
 CxRGThgJ8yaMu6uxHEcbU8mf4kdT7OP7CNYTHAgUVEaFrMqOFXVJGrcBFZfXm1C2QqY4drjgRPq
 Bri6dSzBcEoEJ6IbK0dM1eU0Uxug9bJKF1O/hRCF5/sK892IJAGN2vdkix5crXbPgleC/fTjnMI
 4usu78/CRMy+X58EO12kIOO0cv8betWzVU7FxvfQr24RIyfAd72zCO9YAGLWFfd2BP0gletk86u
 kWKp5GcRWqtieUEDmtQ==
X-Proofpoint-ORIG-GUID: DxLC7RNB0I1xQJcCvIXOnC1mvBhc7MhS
X-Proofpoint-GUID: DxLC7RNB0I1xQJcCvIXOnC1mvBhc7MhS
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe735b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=3OcxSVRvUSqaRT7DloUA:9 a=WmVTiCyuxqgg3mnwYu6p:22 a=biEYGPWJfzWAr4FL6Ov7:22

Backport of this series:
https://lore.kernel.org/all/20250625224957.1436116-1-david@fromorbit.com/

I have added information in commit message upon conflict resolutions.

Dave Chinner (6):
  xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
  xfs: catch stale AGF/AGF metadata
  xfs: avoid dquot buffer pin deadlock
  xfs: rearrange code in xfs_buf_item.c
  xfs: factor out stale buffer item completion
  xfs: fix unmount hang with unflushable inodes stuck in the AIL

 fs/xfs/libxfs/xfs_alloc.c  |  41 +++++-
 fs/xfs/libxfs/xfs_ialloc.c |  31 +++-
 fs/xfs/xfs_buf.c           |  55 -------
 fs/xfs/xfs_buf.h           |   1 -
 fs/xfs/xfs_buf_item.c      | 295 ++++++++++++++++++++++---------------
 fs/xfs/xfs_buf_item.h      |   3 +-
 fs/xfs/xfs_dquot.c         |   4 +-
 fs/xfs/xfs_icache.c        |   8 +
 fs/xfs/xfs_inode.c         |   2 +-
 fs/xfs/xfs_qm.c            |  87 +++--------
 fs/xfs/xfs_trace.h         |   1 -
 11 files changed, 269 insertions(+), 259 deletions(-)

-- 
2.53.0

