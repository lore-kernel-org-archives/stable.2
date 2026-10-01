Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EC48A8D8;
	Thu,  1 Oct 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866373; cv=fail; b=WWWI/oSVXoQGjr5lpyUch2LDVRslxqrjI09/1K8SkphQC4tD3ZyyiiQN0/4+rl21x+i/0thqg+zVgzNXzlTBzujHUIyr3wm39w59vEaH2ljHPjn/7zweUr0DcbdT7FRheGAbph1YWH5rPJ73HTeufQpTzcYqtk+QqGe49qEgv6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866373; c=relaxed/simple;
	bh=zXhJWAnX75K/0XuhOWAYhD6mk2mxubLB2IPjoBglScU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FCnpXdHSYHNTobmEJWNZ1n7ystGkWZPSNHPy5kMhrsM0zDPoueRbW/wGHTel7hJIiYrRofB/dUvSRZWLYQKXZ8jHHDCHx3hZGGjvuCP+yTyEOrEV7FfSgf6tpIQ7ez1JeFWcL8HtKhUjFL2qNTfSfi4OftGtmexM0mvufioOces=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fMng0Qig; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gt5tI8FI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fMng0Qig";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gt5tI8FI"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMUgE782677;
	Thu, 1 Oct 2026 14:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ezaQnKvqm7xcjnDZVC9xHX3XnPUA1xb17uZikLAJ3GA=; b=
	fMng0QigSkKb/N9SX/W4UTbmckb0IaYG0YG4HAMMta8aUHZaFKVRDw6s53Tto82R
	qVrxazUAS094lojGpImz/oOp0n4y8AMopJTEA49qplVn+WVt0RwLZw33kizilqJq
	FI8QK/a6FmLst27qqfzVpxXLSRC2z1VQHJUwGrEEzrYJlujyXKLDngjVGbuS90wP
	N9dUB+Yr1OBLTmrDZX95Nsia0ZfCqLTR0zsb0501BiLQBprUbjUZuS9UD12MVmto
	FYrC+RU5mclY0mnGi8lf3qDc7fp/8U7MLBfiqqkYb65y/sbZF73X6qNkoCrTKN9z
	GCkVzKIPcoepZ/u7EhPeKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5x79231-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpY7017265;
	Thu, 1 Oct 2026 14:52:45 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0qe-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOBbeGQ0UOrxc8ZDOg+DFJq7eQhepiSnmQykfk8YmmVa6YjRWo2+i7PRmjZDE1G1/tD+0F8ADeRa4PLRm7gR9oldLOm5kno6MacbgElJDOZXKNvsTQAOLTlOiK+CoUkdfvhl0+7L2sQmETdnPmzw4qQFZrUtciWAZUOWE41LTCHDKwTGkwwxHXaHDkwQB8jCnJfkpSrpR8SWN4Hbb84fgZemlWYUDc0/hZr3paMiqT9Tg2oMkC+hkpeI36+nVVnr6OvnXp6WUhZk0h3IXrcYNfGntnYKmkpXeMhxrvl1izcDeaD0y3RnS+vqKArgMwNSc0iQRoaJABpxVzZfv9nx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezaQnKvqm7xcjnDZVC9xHX3XnPUA1xb17uZikLAJ3GA=;
 b=GAwyRRL8x7YhELtIQRzfyNPFPhorNps6s6onqvwwARm/68QRW7Ty3NGEuU7GwZcm9vuGnrIIOJe5ao32R2L1wrk8PgzCSwUXT5/a98FDCT1P2z5NpqFWaMUFvIqCENbGJ/EVQ1m8qXyzDQ2f/gDXGAmPhEp8M0x0GoGgMvGUl+C+O2m/mLsYb6dygr9CeL5NQ9iOTW/LLMM8Ko321rM4i42nFgYQ9O4eSG9hIcw3CwnCai2e3AhSTPY3KvoLKxuISY/hgvY01VJ0oVjCMJ2t9tauAki7ReZdYajfmZDLAKfQOzAj+LxmeTUcJa09mlt2HhG/NRkpg0zN8lKWBeEJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezaQnKvqm7xcjnDZVC9xHX3XnPUA1xb17uZikLAJ3GA=;
 b=gt5tI8FIDaqf6bTROoTqjFKnIlxTo4DRs3tTcT25fesqD8+9K/XmMBAE7+bUWXJNq7L40J/d6FiXsZTsugcJyfxIHdwe9VAccMj6RrxiJ/HHxt1s0P/zvSuivNZjvy2rgOnISSygaCxtCoTAHqdGmJ//7IpoofwQXTS/iNRBosU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.12; Thu, 1 Oct 2026 14:52:40 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:52:40 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 06/21] xfs: improve the code that checks recovered refcount intent items
Date: Thu,  1 Oct 2026 20:21:19 +0530
Message-ID: <737dd3a07dba9ca1f528b6d69499034d6cebc06b.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::6) To MN6PR10MB7518.namprd10.prod.outlook.com
 (2603:10b6:208:47c::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 432cf2d7-4853-44b7-9e7f-08df1fcb9d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oKUupKAzpY3zzgK7gkTKW29szfnkJG09iHN3FHotxIgyVuZyyCRqcSjYgwCz5rtdIKeWHMgkzbMfpZQ9YmFbzD7pjwxgTG3AAL4lCtrJgqnQ6/WXoK4hZmtVVmfa67oLQBoSwTeyDscOpLopyGUsHLtdhyYjs2mnWSgfeqdFctG+EnE9Er3QjyfrMpZdc9DouKJ9vJeQ7B6IUZJZzRGKZaURkUpFLB6kn7eNdGAEAcMhg1JMvqhPZbaRrSb44li2JN8z923o4lmIPrZoNUrFAHeDhMN/Mu8mEFfkiQmH88ANtzhGJVtzfY9C8LvNoim4Jb0vzxWG3j9OVa37A5GYbuFXJD5Dqeifxo6QT4mvQ68ybkzEO0DBvn687XEPARn3Onzy5rrj2XIVQgAs4BNFmf/+dp66o2EfaSyTvSP9JgrjZSbTtCgBsNjwiVQXwjrVthann38GPq9V3LlYdoywYIsyVSAJWhP2uvntqgZt491i6KHV+TXsbU66yPupGkSSwvjx3SHv5RINwUVxubARCnJ62u768axekx85PUiGMBqVZlkJ0vMC2mVAY6UbLnUYGdOxwLzapbfOn51JY32TK+i5r0MezEkeAyYXMSRtryvvkTDx7/SmtTH9V0d+kIhrFlmCvywd1qYWq20o/cg8a816n0C/1OOasNS6RQlBOOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AxcyNBrfgdIRIGLJE8JstnEFcxHQVTa2ion6KkA4xWRvLsnkho+nBYYBd2Sl?=
 =?us-ascii?Q?7f5K5OjZ/yycMdZQ8J5sY+TJsvScvMaTJneFU2ip0cA5v6XIWtoVas6etZij?=
 =?us-ascii?Q?VSu/gm1kkFauDUc6esWgZPL+bzx06VsYTPR7X7at7LksigTYClpmPoiiWlzY?=
 =?us-ascii?Q?pRJ+yk0vEBmpQOwQw9ISHAhupXFZRP5PGXyo8eW7b1I9dM+nV8vwqe42BdC/?=
 =?us-ascii?Q?Wsj+3+Mnln11YJIUNX2DUvwnjtA1sKqch338RK3dtSmfVIdYEOrzA784TCp1?=
 =?us-ascii?Q?CGnTVBRiLPgyl7D+maaOQDu6D/xqc3vd/ibWvlmuDMWDcfQ7k9ok126bHiRD?=
 =?us-ascii?Q?96d43VR76lstlQKJ9cLyBXcONcuCc4tFg2Lgowc+Ww1ALYHurGnl+r3srt0h?=
 =?us-ascii?Q?XlzRn8Ooovp2+jndA7dWUp/RiVUi6yrXizShqdyh96voSBlzjD8asIMj91rE?=
 =?us-ascii?Q?vYIQlLnhBMplk7ect0bdvL+O+N+dBcKd9bLrpL8r1ACfcAgeb+Q+xtkM9REn?=
 =?us-ascii?Q?kSMjVA+bgY5THlo4zSA14+S+GOu3rDXgn505T/v6RTssB58mRsCnjh+8mjR6?=
 =?us-ascii?Q?5y1Kk3XTFDmR9WQNP8zBXyhF3UoQti7CczQswRMAW+ezHpFWtHcZsSXd26TQ?=
 =?us-ascii?Q?yqBs6jui/bFxE+1x2P7DiY43qhg7uijokLm9RygrCr8RHIRfEvsDTfWqz/vd?=
 =?us-ascii?Q?u9oykY9Ojvb6jXPVcpoLi0Lb100kV+bv6rzv2y3vWnFoVWRyzscgov0gQxjU?=
 =?us-ascii?Q?dqRhmvUMPfP7Scy4om8wEhX6IZEwcyFAvwwezgBmqDJJvHDK6yBS0x4btJ4W?=
 =?us-ascii?Q?6t2/76oXx9uTJ10r+WewvLbht/s2XRbNuJSmC2LURI55Kw3qHQVyrHU1CnE+?=
 =?us-ascii?Q?e9hcQUN+A+VZTCsAsz1zngwWt22J+a5PkL/454XC1xjMVpQJyt1BA6+pabO3?=
 =?us-ascii?Q?woxZQ1gl1Ye48Fwd4vlcl7ZpUiKKe8n74O8PWaD76HNjq8OQgjFydOt9AVkR?=
 =?us-ascii?Q?F1XzTGV5qwF0Ao/t1yU0W1mc+7JEDhh8oImKGuHYuRas7REy3bzLO8toe5qt?=
 =?us-ascii?Q?G2VO+n+UmYJFrhBTgGa5kxDpcGCtWJh5qs2UxDwWjOcT5WQGVFmvZ7BgqCnV?=
 =?us-ascii?Q?DZvnlwaC1rM2ksr20VVEG8YrOKqfwwo1NvKT0y7jYuflWeX5dYIVkVea6QSf?=
 =?us-ascii?Q?NYibhtsTqXeNMMPrTR6bfmjDn7YriS7yn9yLS0yzTKBpSJjIo0ceAipxRJih?=
 =?us-ascii?Q?AYm1ZcowMx1LopRw246HP3Pw4yBTxzevXqBmJ1IHsClgs7cTT8nTbSFQ/wKf?=
 =?us-ascii?Q?trZgcRDoCMJ80GSNGW9PvObd4UrDMMfkt8m2V5Gj6i0akN43GumRtIxjQveb?=
 =?us-ascii?Q?Yxh3lzGyidTdK34OHrNfFX3YdqcHziSQmjNmjLHNb9sVYTqLUdeZ/5rei0yz?=
 =?us-ascii?Q?3Homn1Z5hX45PnSy5F1ucxnF26cYGVTHY62tAJ6s5JjxjdGeKaRSZD1IWSP8?=
 =?us-ascii?Q?E1sxC2q9FuRSLYVkkwLoZKasaIlVUu5uYUZnpDbnteU3EezN65esFqALNrJO?=
 =?us-ascii?Q?VM4lCcIYgaoYSJL0LFSYWMqd3fjn9jZv6/9WnT+uL5g9xg/EuBpiVbgXpEhA?=
 =?us-ascii?Q?I81SKuqDYQRco9NYhxjDMprw/WwNwDHmvg0hNtyFVxgnrxmVqgQ3qklWQ+cp?=
 =?us-ascii?Q?PhUa0sNErcvAT0Y/J6cuW8EiqbaGZVq2urNHY6oaCPZQJMvfBKyr+o7/aamu?=
 =?us-ascii?Q?8h5K/NKWZlrkqFhA9ekceNOidrrbYXC06vlV7GUIxGD+uELZekL4aFQbSSd1?=
X-MS-Exchange-AntiSpam-MessageData-1: GAEaLJrHqnKm4PeTryCvi9V4+tVc2hngNLU=
X-Exchange-RoutingPolicyChecked:
	M4gx8F3wnFZjykXdWjazfwewqkKZNJcJCZFvogLt/i80T9Gawa7kA2NmACMQJ8nc6l7kIA7SS+rv8wfBFba3Yw7/YVboPRuP0GTccV6sKrFNqkT6S4sk47ux78vEuY14S7dHURQjcZSj3EGFEYfXuu8EnsGZR6nXAEL4gIxDfV2a2nrSj4fXgwqT080Cw7fofeXBnFMzmnVYFkJpxjVM8VEx7DhNourOq3+ew1E0F0v41dWo1aPwlEVfC7IP7T1GIACBteDIPI02BrTrpA01QNM7s/7pAWjtuLT9GAebNtjZknqGkAkQF5qt6DQ29HNcPZLGwDWQ0bu1IHu7NjgGOA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vnrjDLDJVs+jm6LoLLuWlzAdlH51KlsR/aIpjyICFye2Yx+lqHCdgHDcdxA7nPy3OT5nlTCxnCTCUl3sDWdchFrkSqnOsr7buUxEprRVWn5LMTPOPNVdkjpPOtu7qDimVqvFF4fIpUX2yXX7zmABlz2ygu6xwXfTEByY9Qdt1xiHyQrKgcFmAJhPlUNrQMPzE79kcGKOp9JFOr0SIe9E3zRyvMpuunI5PUWj+bMhjJpxYd2TvmhDmu6Y1XaMuLPBZJ+IudzgWxVR9XcEh6WqQucDza6k8cYOSb5UKtooBhwnSHUYzt0b1v/gN2cwd5lmyN3QkxQ9CiDPHDGiPynkWUcBddbj8Lk6JILUZ1FTHcA4cUkUevhno5akLRS2Ihkf01TlSO8Vez6YCnjHJl9eXLmrmNBjFdqaH4dC88ZLJ7pdMM+cRTOZcbLxosHONoxI8ZW6TWyOE0k5CokO7fArw4jNZ1F+bjCPBa2d37JDCLl1G+dsmLwnp8BxTIgi3yv3iD3xH5aTB2i2dXR4EFDpulLjn3lFyC0Oss2ibU4tJWcnlUQ05AR5wFMN7miD2HFIUh/3+4XiaNKqXOqbSfo5O7JmBOGZI0Tk8Md4KJdeTOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432cf2d7-4853-44b7-9e7f-08df1fcb9d05
X-MS-Exchange-CrossTenant-AuthSource: MN6PR10MB7518.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:29.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmjXZY2yEpitq4QwRyPrCN1oqP6RoRWDThM/rphhdjM3F/DqYXFTns02Nz0swrdXBVPuqUhKY2ed4GaM2R+olmhMRlyiEannq6STN6QQqOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-ORIG-GUID: KVfilYPU-TTWQSJECzPmDOJDSJdgvqIw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX+u8mcDbaAx2q
 b9exFfUpHufbmeqis4JUyTXdLUFFct//8XopQAI1H+700mMYNq65j6v557pg5DSEDa+j2Rmh3dp
 29vKXodRX8/jVtwS7eBUePceo4fouNF4pT61i+ZdxtWZvoCPZ2G3
X-Authority-Analysis: v=2.4 cv=CP+/zhrD c=1 sm=1 tr=0 ts=6abe73bd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=voHxInD6YWdgVH9rCXkA:9
X-Proofpoint-GUID: KVfilYPU-TTWQSJECzPmDOJDSJdgvqIw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX9fX90wlFEjMU
 gyVvswadRqYaCvzF0VWA+r7hVYbghNmNnIzqK460rL7YfX7lH64f2yg0utmDrnNO5ORcFmsUhl0
 oPRB5sDI8FhYzEwrpCBs3n4NWhocLrmFuPTHsiv/yk2H2mauIqsbmVuvlxaenwHQ1PwZP+4Iycp
 rvGnSLMFYRCosyb3ZY2Fc14qxVFrFNo9UXKypkoNnMY+avt0Xq4pHH8FLmGX3gAEwH5YvecuAbr
 1JtoYaaPZ9cDETdOECObtAhUPgmmUDvNbUly4QuRS5Jeg0HiBVExJmT+ZNWrlLeQ1B0P8Jt/i8B
 6G2MKGfCals8/nJ4zt+mid3p0iKgB+58s+mDxdJXKMF2sHsb39bQ/ywXfSixyic1GX0zm8T1ZaM
 OlaP0LYhJ7HemCPpj8QU4xNfKW3sLvJ6A2jOj+ejqyWWBOQpYwduCY+ZEzkzfTBgFxkLdjxzKdx
 D+BaZHDS9t6WnqRJMbw==

From: "Darrick J. Wong" <darrick.wong@oracle.com>

The code that validates recovered refcount intent items is kind of a
mess -- it doesn't use the standard xfs type validators, and it doesn't
check for things that it should.  Fix the validator function to use the
standard validation helpers and look for more types of obvious errors.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
(cherry picked from commit 0d79781a1aa6a6a567e63294012eee2384f406f2)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_refcount_item.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 83dddec08f3c..2532a2a1cd59 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -423,27 +423,26 @@ xfs_cui_validate_phys(
 	struct xfs_mount		*mp,
 	struct xfs_phys_extent		*refc)
 {
-	xfs_fsblock_t			startblock_fsb;
-	bool				op_ok;
+	if (refc->pe_flags & ~XFS_REFCOUNT_EXTENT_FLAGS)
+		return false;
 
-	startblock_fsb = XFS_BB_TO_FSB(mp,
-			   XFS_FSB_TO_DADDR(mp, refc->pe_startblock));
 	switch (refc->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK) {
 	case XFS_REFCOUNT_INCREASE:
 	case XFS_REFCOUNT_DECREASE:
 	case XFS_REFCOUNT_ALLOC_COW:
 	case XFS_REFCOUNT_FREE_COW:
-		op_ok = true;
 		break;
 	default:
-		op_ok = false;
-		break;
+		return false;
 	}
-	if (!op_ok || startblock_fsb == 0 ||
-	    refc->pe_len == 0 ||
-	    startblock_fsb >= mp->m_sb.sb_dblocks ||
-	    refc->pe_len >= mp->m_sb.sb_agblocks ||
-	    (refc->pe_flags & ~XFS_REFCOUNT_EXTENT_FLAGS))
+
+	if (refc->pe_startblock + refc->pe_len <= refc->pe_startblock)
+		return false;
+
+	if (!xfs_verify_fsbno(mp, refc->pe_startblock))
+		return false;
+
+	if (!xfs_verify_fsbno(mp, refc->pe_startblock + refc->pe_len - 1))
 		return false;
 
 	return true;
-- 
2.53.0

