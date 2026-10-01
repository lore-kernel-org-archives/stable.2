Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71D5221D3;
	Thu,  1 Oct 2026 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866474; cv=fail; b=U06MJXyduTZ6XIR8BCNkhIhxrn1jVAqvvk2Qr9ZlFdivXoOvSh/hzg4VdVyBVd5xTP1VSATskkzf7WBzChW/4iyOFlJqxCOKQ5k/2P4D7STXAw1gXAdVtOY/v6wRowjDC5I7r/eTQMxlB58QjPUy9HrEARZ2Zze4rxFPZXopKZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866474; c=relaxed/simple;
	bh=+yO7IWjUULpcRC4yRAhiZxR6ZQ8tLLWfk1fz8yE1BTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfJrUKlQewuwTbWHE/b6p5yFOBLEXWg6n3vbeRsuBpFpix8FLtA1huUWxUvRVjHxTO2oZubwRg64vz/V9q8fGjuSxxmhyc2Es780UdrrzT7cqoxNA8H5WzEVizTc/P3NpglpDZeO6ikldXdqfWGgols1BNgZ0kvJpMjM+M9z2Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bo8acs97; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jOAvgb5e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bo8acs97";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jOAvgb5e"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMZTD2256852;
	Thu, 1 Oct 2026 14:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OorLu7hwqbbuPzkLX0a4Bh8Yfc+F7lgX2uES7OePuAk=; b=
	Bo8acs97F1DCYStPpDeNPfdF1A7FpLDu84CrQXB/nUJtGv+e9dzoMEsR5Lnv7mfq
	InlxR/oKDqCIu8eBt2RqAIVaosTkKb+ke8GyQjDG2jg17OgeL7sqgKFtQDzPsEHy
	/ON8t7Ki69+R9RH5AZlNhreGk12P89BzsU3OiB7XFMWs1euVOGNLfmZxBRo5MnUX
	z9Vacjjc+CAMt18+fazpJfPbV7rr6foDZ6c4zVUWlVu8ekOh1TDfd3deqB2Pox5C
	/ScwBv0dBub651Du20lgsH7QsZl6f/FnG7p0nE74dhhNtVwIBk2LS0TKzYI6EUXY
	EyjavLP7SLCZufx21Sxbpw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:54:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoSJ5031727;
	Thu, 1 Oct 2026 14:54:27 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd5pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:54:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko9bpGunxRnU6dkJ1jm+nuYKhnCWbp6mUwgrHwI6rCJz9TA9VhIvk+TBHsFUpl0p8mTjOgkx0fnqRO14KY47OnXmAMH11RughoQ8cv60d+puSwawwKU0AOejNE1yuV2DqDAWIDr+mwv8tZSeh3vTvNTxAERKeN2ASa9qmXdd1cThjoaDr5/XwTBFYkgCxkzMMoEqdxmYsC4j7xIsdtPYUFC6m5k+QLqlxOa+IxbJIuS72AWC+uBBivIa8yDRUmNEvyMRdUQYCShDKYv3B7abOoDZ4p+0Uy8X22OFoYJer5liP6FMwpQDux7p2vFke4s7/MHXxFIl7xHGe1+tjnD+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OorLu7hwqbbuPzkLX0a4Bh8Yfc+F7lgX2uES7OePuAk=;
 b=o97PhsGTD7ZCvMY9PmATRMQk+fIAMkNdx8CSjb+mikqPhqvZqdqYJfpqCl3S78j/qaRqo25c39thtioQeLP4fSvL9uIAex9HQC7naXtHyfeO/Amgq5XZcCnyIOcj7ErLy60QUR3rEolmNLNoXVmtJPLa5rrZWu3iojvR+CegsTFYQe2u5smbj3ChCC+oiTFBhoW0O5T28CerjQiWk8GtEzrIcKvJQc752PT7W98ouFtuyb8crsUrxkF6smkZwXo8IfbvReFAp5BcH/OHmVEEHbrENNexTnKkHmCiKPL2nJs5bsH/0nMECHZUZVlRa80kAkmgOcOSA65gu44MfIfOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OorLu7hwqbbuPzkLX0a4Bh8Yfc+F7lgX2uES7OePuAk=;
 b=jOAvgb5eOsxLDOchbP8VqOZfuQdlpUfHLtS1tM/Wz6sueCHeY9W/kaglNRIARm5N6bo2cDlzCcLmFXdkGL2gWMBEWikqmBZ2kfLyOFy625KcD+18NV+W9cXbEtkr/H9TZxRcSJ1TT18g0hwsLe2xhPIQysZ2E8WdWJiqcUC1B2s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:54:23 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:54:22 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 08/11] xfs: avoid dquot buffer pin deadlock
Date: Thu,  1 Oct 2026 20:21:23 +0530
Message-ID: <ceb861c5bbeb00914798bd9280d4e05e4e9835e8.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864545.git.siddh.raman.pant@oracle.com>
References: <cover.1790864545.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a09d66-402d-4e03-f9e4-08df1fcbe120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|260925021911599003|260925022911599003|5023799004|260925021311599003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	LHQBZEy8CUavJqGMWEYBv7w/8YyNJGLuAl0aa0Ph6uoAEWoUcWxyMfxtHYVr5oqIbt1hA9cmcDFN/HP0wlmMJV+Q7VP5ep22h3iPq2F04ujlFUsUbV6UKT8jJNHWFAyxwHmdHaOKAL8xSeL2POgQSq8oyPVBPXCLzjxnZbw88suVn72ehA15DEFctqCC7EO6OxiR6Acm4nZaGgDr0NmMd67E7dlFd+tcbzwiXorKu0DcFRfeZNYQa0b0ec/iKartErHCspuaG0tRIVEI8RlSi9klwDDrHbgfs64XwsXEOWdRjLBiU81/0kpzjT6xB0XyDbihvz7IpUaFhn2TRn80d0yd+cRJY54cH7b/nN7OAJnEHvfTi5Ta1TM/BzFGECiM3tGuRFRcL73UPlhtvWj3AWFmpJZc8J/UlGBbA50o5fMIEnY9Yy8iRHunFC2oec/8SWXR6E95aOTsMPP2MlfZdR6dnTgk1fbEemZimfit1/mc7ngIPFxyUwUuYH9kjqSbf9fx7q47flkPRfowT20viaURGlAz2P4LjNpeU7KAIXDoLrnzyRH9M7bNlUW4pbT6KQohRa6LUR9fr3dJpG9WOmR549KZdfqE/XLQ1Jy1F3EhK5ynKm9KRwxEf3dFNbzNwyPgdZPTOPwSdWB9yRbr6Ea8vzREU2+bGAKMEnRJ+h4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(260925021911599003)(260925022911599003)(5023799004)(260925021311599003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4tNm8dU/t9YlXvDKL2RO+63Jq6CJs1p43HTHfsRibzVei2oMlXGbbYIlXtqM?=
 =?us-ascii?Q?yDt8EkWPJ+f2NpdXD9chz5DT00dnmMQbav5GLgtaIYDHVE9ItTatnAG0VC+o?=
 =?us-ascii?Q?eJsgKNGL+NQpgGR1+lR2Y0F0P9cZeFsIEd3XHM9hi8Bnpj7p9QLA+Pi37VXU?=
 =?us-ascii?Q?kwgTLTP0Ay3/mCcBK3Qvek0fq+nCirBM+xTYGjQGvH0BgOW9YToWbvqRO5kj?=
 =?us-ascii?Q?up2lyUuwJN6OYMgVEDWWcN339OvAxZ9frMh47GCEmUbaH2ThrCtXuQTA1p87?=
 =?us-ascii?Q?NcBPeCWWxndbQHk8mdt1M1A0yqw+xsGsVzLaPF14o0u9MpZE7yei+HCN3ArR?=
 =?us-ascii?Q?DfoVVoLQ60oriQCZOYB/r0BGT1k81IMXjHDNsLWir6KN5jceWWM4jaPB6vF4?=
 =?us-ascii?Q?kjG+dnslf+4lPlTa7Un7mW9GyrBP5J1DaTUQ4iTozEiIstsZG4pFfbDpOqSk?=
 =?us-ascii?Q?AkC3P1jxY1/GgZ6eGIz7/k1t/QIBYEuJLmCZ5LXzW0ebfjgK8MRlGQs2y/KE?=
 =?us-ascii?Q?oXS15br9Y84/tsq+mKkK1i/+AH0jBhXjNSbGeScp3vbpzdiuMHSFzmnedTRw?=
 =?us-ascii?Q?YdT3h50f342JikxtmfIM+2/aMwKxcTZDmZiz3gDPiWHPTHAyNyEn7iv5inHk?=
 =?us-ascii?Q?TU5iBsjtLsw6Q2p4fR03s9rAebyEr6uV3npVJEOlUrg6kgIRsXmdaUEetoe8?=
 =?us-ascii?Q?mD3LkTcBadagDcB4lTekaOa/XVC7f8V11nEmo4hexYvQancyEcgzXVLh0CXF?=
 =?us-ascii?Q?J/f8zxkb+EzkdeOUMfa7qizKinXMjp2Znsibv16ifNFu/XgHfHVkvIPfI2m8?=
 =?us-ascii?Q?0u1h/bpkn9cPiLUmxQnfLgY330a7m/CFeXZron19xueni8+tHIZqzDN4x6jb?=
 =?us-ascii?Q?GD/yVk2Kh/FVg4bM1C5oiaZ1GHup08Q9YpDEHRPSGy7vBEsa+yxMn4+GS1tF?=
 =?us-ascii?Q?U2p+J9xR7h8Wz1TQNMPjTOtlzn5S/+1PLyT+S30G873mRWCMUcuF9zCFY8LS?=
 =?us-ascii?Q?fRMAtcxKM/YLbYj5/gun7KNND/pyTps046WmOz7thzkH0B4EBTqIqjQlZIwi?=
 =?us-ascii?Q?bmHsdNug5/FMcWlLDHWtTLyExrUh0Ig/natkR56YrE0sAsuOn5Fms67i7KuT?=
 =?us-ascii?Q?Xg0pjO5mgueupba+TvTSVwHyjP/mwPCHl9As81fOGiOycPpZWQl/y2BZwr2N?=
 =?us-ascii?Q?5ZR7JP0LCoV2UqU5l8hSJpIE5fsTLXoYZf0TpOVrlpIm0gjGIJvcxcjBGPek?=
 =?us-ascii?Q?mSAyl6SEOecZQT8OzG2OgxrDGouaYxQFg8tU0LeKvMHbQojb+StTnLCdRF5t?=
 =?us-ascii?Q?DrgPMF2upJAdh2+aoCxaIWhLKXvJj2Glxxv3w2WIejLLCkRjJs52BVfMaYQn?=
 =?us-ascii?Q?yJ2tatgsuoB+YMRrOvJU6D4dh+qPBlDZVh4/LCvflXjHBVaD83vQOmyVnYz1?=
 =?us-ascii?Q?6BdZ+niBe32ycYCGwfSRMt9ul2JX949/eaS4qRDeOLzcSP3THZRECOgIhdAu?=
 =?us-ascii?Q?aUG9h9cenZEIkBukf0MFid85cccLZVGYOiFt+OiL7FTmMKEyz/CshOPgWfUO?=
 =?us-ascii?Q?ZnLqHHLdzkozkxbEfwjQUv3eU2V3mKVqYaRfAO/66S4RGOnN0QJZeFHaLy3M?=
 =?us-ascii?Q?pwLbSjoxTyI4Qb+2tDHcWekt4bh0N6VuObSD4CXti+XiiriZPm79nBdZplIJ?=
 =?us-ascii?Q?UR0cXpuLA9Of3GL6B4ket9L+kP2BrJ36KqbjWwvdsW5GuLBV9MgQDj3CXKLk?=
 =?us-ascii?Q?OkVkooiLnVcgkC5BBukBBY5pK89aCk3zbEgnJRsbO/WbAnKxf/sslfZvBVKZ?=
X-MS-Exchange-AntiSpam-MessageData-1: g/DzS+SVa5aMuGDi4eQAhGY4VVQ/VG2IsBo=
X-Exchange-RoutingPolicyChecked:
	h/guKAFDzxBQRhh8D3ZlmwpqqLqDHk+JokW+wRRxtDDQfH1+EWxZS0IvDVTaMSm0nXGZ8ChNkAs1ygPZ5AdqUODkUoK5K0rm4POwGWV34jX3X3KqQr4lu879EOVc8rVALcbi1kEBFB8WAqe6cI3EVpqiPBmjqrfFX6a+JGo9j7uKVfY7vaW1ot+xaqu1pOh8diIlXcFu3rddSC23dqMU6A82kR2Qh1hCc3sIMqDxgiIcu0xAsRouh1i93ck+WtV19jrWIbtExuSYvkVM8qTVOOgyOoXEFRu4djGnm+UZpFoEZaEllqV2I+wHfsCDcB7mfkrv+1Qz5F/+tE4qRcN5qg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lZiIq63IKrfUm3aCZ3DsT/iqHiq9Ll6xH8lkUGz67qeUiuJ7PCAftaz5vmCh5Ld5Pw/jEkLXPmFZuMfJYUsqAAGoXWuA/cWfthu1wHONprR/P0hErVWGlClrTivrts4gXrYd0f8+cbEwoQHl8EaisQvp+baSxMq5E8Mft9gglR0ORISHWU8X6CqdEgg2TccC//h4aLQVzmNM49KaeSiGP9tYJ4vFZrHFNo3J9gyu5Nj9oqSNIUNPKkVMLRCojqrEE2lsZ2m06OxgYtkpdEe3oYRqacJKw9E6i6slN9tY1Siay+6cEaESh7QVVhKPM7NYkoq+QKuXaxbR8C6XFOqOZCbXa4sL35o2WBewNlKgxxzxAu2Pm51Vs8GI60KN6HX3LgqakVewYqzMpcwqG/tiM0kupfVWiH6VypQDEaoEgW3/Kt8UOmxTdXsjcwlrPHisvxBpAZym9qw2EK6f3gAdsY5sS9X6V3ryu95vCte/4ZjuQFOtQrdX4zuzZLTdNcwx//Rwmknxbd9synbwCo1deg3jRYK1wowIAs2BOFtFHInq5gCj2DF5XHnmluRQC7OkExRieyxfSxR4zIaRqlBCwvre8EicxgaFKgEfZwBsReQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a09d66-402d-4e03-f9e4-08df1fcbe120
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:54:22.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie5Aa2UAKrmNYDDl+y8ujg+fI9OfQN5cZL4EVluO5p8b9ubAC/EDSH6+UqC1wIA2rZ0DcYoJoVI2UjFAM8Im/ONUW+yY64qcIOZn2n940A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX2S8g9YKoDghZ
 WyhunFnt4dSkHDk9RUcF0KeEXhsxvx8F3Htwbk8X9sNlcH8Rr+5iTnObCNhurO92xvEbvXHVzC9
 gTXEm43S10pbaYEI1WrDWl5i77hgTWU7M5oWJP/hhegGeH4U59vA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX9EmjDEXnxZ/U
 tsokgyqqWac/lx0OD13+IPvWCP+XSEjyyeNhSaWnr/vwV8FarK5ZfhV6U8z+nwiEnOCgEVDJKVU
 rgeUvZZRuC/EF+G+7SuAZxCdHs7yKsOI8SU7esF/RjlkrIIMeT8oS0T7K9vdZmTE3aXjFbad3M5
 WDT7A28d/VEybWvd1ZapN7l8D5BdcBxje/+OWQNuvjuVDMkcxLDPl0ogupDRn9wK/qGvtuYZFmd
 7a9ww+DsAmkGm385oIt5/a2uU5r75OhCWugvUX8akYWjtYKxnBcRnqXwz8MBqvhzs4/YmIhW6dZ
 IdOUXnNCuV7hWXs/eVLdfGdrhMNT3GHoEmSh/dDq/6ZML80m8Sz6LNVZ3AEFDJDTOUnx0DxgO1l
 D5wz90DisL7HmKfpEGkolUjylHapptf4RbFU+FAl9+hycMSf/ZipFOK0jtXRNENXxBOeI3ud89H
 Q3rxVdG2OdhFWQWfS/fTHg2/PbZwTc99wMrFbpvg=
X-Proofpoint-ORIG-GUID: VSEgEYnIPBGNGreFPGlsjESJG8E7gnzC
X-Proofpoint-GUID: VSEgEYnIPBGNGreFPGlsjESJG8E7gnzC
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7423 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=s_x9I6ZcpGuAll3zZK4A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537

From: Dave Chinner <dchinner@redhat.com>

On shutdown when quotas are enabled, the shutdown can deadlock
trying to unpin the dquot buffer buf_log_item like so:

[ 3319.483590] task:kworker/20:0H   state:D stack:14360 pid:1962230 tgid:1962230 ppid:2      task_flags:0x4208060 flags:0x00004000
[ 3319.493966] Workqueue: xfs-log/dm-6 xlog_ioend_work
[ 3319.498458] Call Trace:
[ 3319.500800]  <TASK>
[ 3319.502809]  __schedule+0x699/0xb70
[ 3319.512672]  schedule+0x64/0xd0
[ 3319.515573]  schedule_timeout+0x30/0xf0
[ 3319.528125]  __down_common+0xc3/0x200
[ 3319.531488]  __down+0x1d/0x30
[ 3319.534186]  down+0x48/0x50
[ 3319.540501]  xfs_buf_lock+0x3d/0xe0
[ 3319.543609]  xfs_buf_item_unpin+0x85/0x1b0
[ 3319.547248]  xlog_cil_committed+0x289/0x570
[ 3319.571411]  xlog_cil_process_committed+0x6d/0x90
[ 3319.575590]  xlog_state_shutdown_callbacks+0x52/0x110
[ 3319.580017]  xlog_force_shutdown+0x169/0x1a0
[ 3319.583780]  xlog_ioend_work+0x7c/0xb0
[ 3319.587049]  process_scheduled_works+0x1d6/0x400
[ 3319.591127]  worker_thread+0x202/0x2e0
[ 3319.594452]  kthread+0x20c/0x240

The CIL push has seen the deadlock, so it has aborted the push and
is running CIL checkpoint completion to abort all the items in the
checkpoint. This calls ->iop_unpin(remove = true) to clean up the
log items in the checkpoint.

When a buffer log item is unpined like this, it needs to lock the
buffer to run io completion to correctly fail the buffer and run all
the required completions to fail attached log items as well. In this
case, the attempt to lock the buffer on unpin is hanging because the
buffer is already locked.

I suspected a leaked XFS_BLI_HOLD state because of XFS_BLI_STALE
handling changes I was testing, so I went looking for
pin events on HOLD buffers and unpin events on locked buffer. That
isolated this one buffer with these two events:

xfs_buf_item_pin:     dev 251:6 daddr 0xa910 bbcount 0x2 hold 2 pincount 0 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags HOLD|DIRTY|LOGGED liflags DIRTY
....
xfs_buf_item_unpin:   dev 251:6 daddr 0xa910 bbcount 0x2 hold 4 pincount 1 lock 0 flags DONE|KMEM recur 0 refcount 1 bliflags DIRTY liflags ABORTED

Firstly, bbcount = 0x2, which means it is not a single sector
structure. That rules out every xfs_trans_bhold() case except one:
dquot buffers.

Then hung task dumping gave this trace:

[ 3197.312078] task:fsync-tester    state:D stack:12080 pid:2051125 tgid:2051125 ppid:1643233 task_flags:0x400000 flags:0x00004002
[ 3197.323007] Call Trace:
[ 3197.325581]  <TASK>
[ 3197.327727]  __schedule+0x699/0xb70
[ 3197.334582]  schedule+0x64/0xd0
[ 3197.337672]  schedule_timeout+0x30/0xf0
[ 3197.350139]  wait_for_completion+0xbd/0x180
[ 3197.354235]  __flush_workqueue+0xef/0x4e0
[ 3197.362229]  xlog_cil_force_seq+0xa0/0x300
[ 3197.374447]  xfs_log_force+0x77/0x230
[ 3197.378015]  xfs_qm_dqunpin_wait+0x49/0xf0
[ 3197.382010]  xfs_qm_dqflush+0x55/0x460
[ 3197.385663]  xfs_qm_dquot_isolate+0x29e/0x4d0
[ 3197.389977]  __list_lru_walk_one+0x141/0x220
[ 3197.398867]  list_lru_walk_one+0x10/0x20
[ 3197.402713]  xfs_qm_shrink_scan+0x6a/0x100
[ 3197.406699]  do_shrink_slab+0x18a/0x350
[ 3197.410512]  shrink_slab+0xf7/0x430
[ 3197.413967]  drop_slab+0x97/0xf0
[ 3197.417121]  drop_caches_sysctl_handler+0x59/0xc0
[ 3197.421654]  proc_sys_call_handler+0x18b/0x280
[ 3197.426050]  proc_sys_write+0x13/0x20
[ 3197.429750]  vfs_write+0x2b8/0x3e0
[ 3197.438532]  ksys_write+0x7e/0xf0
[ 3197.441742]  __x64_sys_write+0x1b/0x30
[ 3197.445363]  x64_sys_call+0x2c72/0x2f60
[ 3197.449044]  do_syscall_64+0x6c/0x140
[ 3197.456341]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Yup, another test run by check-parallel is running drop_caches
concurrently and the dquot shrinker for the hung filesystem is
running. That's trying to flush a dirty dquot from reclaim context,
and it waiting on a log force to complete. xfs_qm_dqflush is called
with the dquot buffer held locked, and so we've called
xfs_log_force() with that buffer locked.

Now the log force is waiting for a workqueue flush to complete, and
that workqueue flush is waiting of CIL checkpoint processing to
finish.

The CIL checkpoint processing is aborting all the log items it has,
and that requires locking aborted buffers to cancel them.

Now, normally this isn't a problem if we are issuing a log force
to unpin an object, because the ->iop_unpin() method wakes pin
waiters first. That results in the pin waiter finishing off whatever
it was doing, dropping the lock and then xfs_buf_item_unpin() can
lock the buffer and fail it.

However, xfs_qm_dqflush() is waiting on the -dquot- unpin event, not
the dquot buffer unpin event, and so it never gets woken and so does
not drop the buffer lock.

Inodes do not have this problem, as they can only be written from
one spot (->iop_push) whilst dquots can be written from multiple
places (memory reclaim, ->iop_push, xfs_dq_dqpurge, and quotacheck).

The reason that the dquot buffer has an attached buffer log item is
that it has been recently allocated. Initialisation of the dquot
buffer logs the buffer directly, thereby pinning it in memory. We
then modify the dquot in a separate operation, and have memory
reclaim racing with a shutdown and we trigger this deadlock.

check-parallel reproduces this reliably on 1kB FSB filesystems with
quota enabled because it does all of these things concurrently
without having to explicitly write tests to exercise these corner
case conditions.

xfs_qm_dquot_logitem_push() doesn't have this deadlock because it
checks if the dquot is pinned before locking the dquot buffer and
skipping it if it is pinned. This means the xfs_qm_dqunpin_wait()
log force in xfs_qm_dqflush() never triggers and we unlock the
buffer safely allowing a concurrent shutdown to fail the buffer
appropriately.

xfs_qm_dqpurge() could have this problem as it is called from
quotacheck and we might have allocated dquot buffers when recording
the quota updates. This can be fixed by calling
xfs_qm_dqunpin_wait() before we lock the dquot buffer. Because we
hold the dquot locked, nothing will be able to add to the pin count
between the unpin_wait and the dqflush callout, so this now makes
xfs_qm_dqpurge() safe against this race.

xfs_qm_dquot_isolate() can also be fixed this same way but, quite
frankly, we shouldn't be doing IO in memory reclaim context. If the
dquot is pinned or dirty, simply rotate it and let memory reclaim
come back to it later, same as we do for inodes.

This then gets rid of the nasty issue in xfs_qm_flush_one() where
quotacheck writeback races with memory reclaim flushing the dquots.
We can lift xfs_qm_dqunpin_wait() up into this code, then get rid of
the "can't get the dqflush lock" buffer write to cycle the dqlfush
lock and enable it to be flushed again.  checking if the dquot is
pinned and returning -EAGAIN so that the dquot walk will revisit the
dquot again later.

Finally, with xfs_qm_dqunpin_wait() lifted into all the callers,
we can remove it from the xfs_qm_dqflush() code.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d62016b1a2df24c8608fe83cd3ae8090412881b3)

6.12:

Fix conflicts due to following missing commits:

fs/xfs/xfs_buf.c:
	eb43b0b5cab8 ("xfs: simplify xfs_buf_delwri_pushbuf")

fs/xfs/xfs_qm.c:
	da0c02516c50 ("mm/list_lru: simplify the list_lru walk callback function")
	fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")

We delete the code so we don't really need to add them.

6.6:

Fix conflicts similarly due to following missing commit:

fs/xfs/xfs_dquot.c, fs/xfs/xfs_qm.c:
	08c7027e43a2 ("xfs: separate dquot buffer reads from xfs_dqflush")

5.15:

Fix conflicts similarly due to following missing commits:

fs/xfs/xfs_buf.c:
	231f91ab504e ("xfs: xfs_buf cache destroy isn't RCU safe")

fs/xfs/xfs_qm.c:
	85c73bf726e4 ("xfs: rework xfs_buf_incore() API")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf.c   | 55 --------------------------------
 fs/xfs/xfs_buf.h   |  1 -
 fs/xfs/xfs_dquot.c |  3 +-
 fs/xfs/xfs_qm.c    | 79 +++++++++++-----------------------------------
 fs/xfs/xfs_trace.h |  1 -
 5 files changed, 20 insertions(+), 119 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 5fa6cd947dd4..71d0615e6754 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2200,61 +2200,6 @@ xfs_buf_delwri_submit(
 	return error;
 }
 
-/*
- * Push a single buffer on a delwri queue.
- *
- * The purpose of this function is to submit a single buffer of a delwri queue
- * and return with the buffer still on the original queue. The waiting delwri
- * buffer submission infrastructure guarantees transfer of the delwri queue
- * buffer reference to a temporary wait list. We reuse this infrastructure to
- * transfer the buffer back to the original queue.
- *
- * Note the buffer transitions from the queued state, to the submitted and wait
- * listed state and back to the queued state during this call. The buffer
- * locking and queue management logic between _delwri_pushbuf() and
- * _delwri_queue() guarantee that the buffer cannot be queued to another list
- * before returning.
- */
-int
-xfs_buf_delwri_pushbuf(
-	struct xfs_buf		*bp,
-	struct list_head	*buffer_list)
-{
-	LIST_HEAD		(submit_list);
-	int			error;
-
-	ASSERT(bp->b_flags & _XBF_DELWRI_Q);
-
-	trace_xfs_buf_delwri_pushbuf(bp, _RET_IP_);
-
-	/*
-	 * Isolate the buffer to a new local list so we can submit it for I/O
-	 * independently from the rest of the original list.
-	 */
-	xfs_buf_lock(bp);
-	list_move(&bp->b_list, &submit_list);
-	xfs_buf_unlock(bp);
-
-	/*
-	 * Delwri submission clears the DELWRI_Q buffer flag and returns with
-	 * the buffer on the wait list with the original reference. Rather than
-	 * bounce the buffer from a local wait list back to the original list
-	 * after I/O completion, reuse the original list as the wait list.
-	 */
-	xfs_buf_delwri_submit_buffers(&submit_list, buffer_list);
-
-	/*
-	 * The buffer is now locked, under I/O and wait listed on the original
-	 * delwri queue. Wait for I/O completion, restore the DELWRI_Q flag and
-	 * return with the buffer unlocked and on the original queue.
-	 */
-	error = xfs_buf_iowait(bp);
-	bp->b_flags |= _XBF_DELWRI_Q;
-	xfs_buf_unlock(bp);
-
-	return error;
-}
-
 int __init
 xfs_buf_init(void)
 {
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 6b0200b8007d..d200f70ad006 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -291,7 +291,6 @@ extern void xfs_buf_delwri_cancel(struct list_head *);
 extern bool xfs_buf_delwri_queue(struct xfs_buf *, struct list_head *);
 extern int xfs_buf_delwri_submit(struct list_head *);
 extern int xfs_buf_delwri_submit_nowait(struct list_head *);
-extern int xfs_buf_delwri_pushbuf(struct xfs_buf *, struct list_head *);
 
 /* Buffer Daemon Setup Routines */
 extern int xfs_buf_init(void);
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 96b9cc3569dd..252f7a6cf697 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1251,13 +1251,12 @@ xfs_qm_dqflush(
 
 	ASSERT(XFS_DQ_IS_LOCKED(dqp));
 	ASSERT(!completion_done(&dqp->q_flush));
+	ASSERT(atomic_read(&dqp->q_pincount) == 0);
 
 	trace_xfs_dqflush(dqp);
 
 	*bpp = NULL;
 
-	xfs_qm_dqunpin_wait(dqp);
-
 	/*
 	 * Get the buffer containing the on-disk dquot
 	 */
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index ff563c544b61..17533f04d17a 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -131,6 +131,7 @@ xfs_qm_dqpurge(
 
 	dqp->q_flags |= XFS_DQFLAG_FREEING;
 
+	xfs_qm_dqunpin_wait(dqp);
 	xfs_dqflock(dqp);
 
 	/*
@@ -418,6 +419,7 @@ xfs_qm_dquot_isolate(
 	struct xfs_dquot	*dqp = container_of(item,
 						struct xfs_dquot, q_lru);
 	struct xfs_qm_isolate	*isol = arg;
+	enum lru_status		ret = LRU_SKIP;
 
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
@@ -430,6 +432,16 @@ xfs_qm_dquot_isolate(
 	if (dqp->q_flags & XFS_DQFLAG_FREEING)
 		goto out_miss_unlock;
 
+	/*
+	 * If the dquot is pinned or dirty, rotate it to the end of the LRU to
+	 * give some time for it to be cleaned before we try to isolate it
+	 * again.
+	 */
+	ret = LRU_ROTATE;
+	if (XFS_DQ_IS_DIRTY(dqp) || atomic_read(&dqp->q_pincount) > 0) {
+		goto out_miss_unlock;
+	}
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -445,30 +457,14 @@ xfs_qm_dquot_isolate(
 	}
 
 	/*
-	 * If the dquot is dirty, flush it. If it's already being flushed, just
-	 * skip it so there is time for the IO to complete before we try to
-	 * reclaim it again on the next LRU pass.
+	 * The dquot may still be under IO, in which case the flush lock will be
+	 * held. If we can't get the flush lock now, just skip over the dquot as
+	 * if it was dirty.
 	 */
 	if (!xfs_dqflock_nowait(dqp))
 		goto out_miss_unlock;
 
-	if (XFS_DQ_IS_DIRTY(dqp)) {
-		struct xfs_buf	*bp = NULL;
-		int		error;
-
-		trace_xfs_dqreclaim_dirty(dqp);
-
-		/* we have to drop the LRU lock to flush the dquot */
-		spin_unlock(lru_lock);
-
-		error = xfs_qm_dqflush(dqp, &bp);
-		if (error)
-			goto out_unlock_dirty;
-
-		xfs_buf_delwri_queue(bp, &isol->buffers);
-		xfs_buf_relse(bp);
-		goto out_unlock_dirty;
-	}
+	ASSERT(!XFS_DQ_IS_DIRTY(dqp));
 	xfs_dqfunlock(dqp);
 
 	/*
@@ -489,14 +485,7 @@ xfs_qm_dquot_isolate(
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	return LRU_SKIP;
-
-out_unlock_dirty:
-	trace_xfs_dqreclaim_busy(dqp);
-	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-	xfs_dqunlock(dqp);
-	spin_lock(lru_lock);
-	return LRU_RETRY;
+	return ret;
 }
 
 static unsigned long
@@ -1225,7 +1214,6 @@ xfs_qm_flush_one(
 	struct xfs_dquot	*dqp,
 	void			*data)
 {
-	struct xfs_mount	*mp = dqp->q_mount;
 	struct list_head	*buffer_list = data;
 	struct xfs_buf		*bp = NULL;
 	int			error = 0;
@@ -1236,37 +1224,8 @@ xfs_qm_flush_one(
 	if (!XFS_DQ_IS_DIRTY(dqp))
 		goto out_unlock;
 
-	/*
-	 * The only way the dquot is already flush locked by the time quotacheck
-	 * gets here is if reclaim flushed it before the dqadjust walk dirtied
-	 * it for the final time. Quotacheck collects all dquot bufs in the
-	 * local delwri queue before dquots are dirtied, so reclaim can't have
-	 * possibly queued it for I/O. The only way out is to push the buffer to
-	 * cycle the flush lock.
-	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		/* buf is pinned in-core by delwri list */
-		bp = xfs_buf_incore(mp->m_ddev_targp, dqp->q_blkno,
-				mp->m_quotainfo->qi_dqchunklen, 0);
-		if (!bp) {
-			error = -EINVAL;
-			goto out_unlock;
-		}
-
-		if (!(bp->b_flags & _XBF_DELWRI_Q)) {
-			error = -EAGAIN;
-			xfs_buf_relse(bp);
-			goto out_unlock;
-		}
-
-		xfs_buf_unlock(bp);
-
-		xfs_buf_delwri_pushbuf(bp, buffer_list);
-		xfs_buf_rele(bp);
-
-		error = -EAGAIN;
-		goto out_unlock;
-	}
+	xfs_qm_dqunpin_wait(dqp);
+	xfs_dqflock(dqp);
 
 	error = xfs_qm_dqflush(dqp, &bp);
 	if (error)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 3682dd11581a..ea6f59e5aac0 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -462,7 +462,6 @@ DEFINE_BUF_EVENT(xfs_buf_iowait_done);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queue);
 DEFINE_BUF_EVENT(xfs_buf_delwri_queued);
 DEFINE_BUF_EVENT(xfs_buf_delwri_split);
-DEFINE_BUF_EVENT(xfs_buf_delwri_pushbuf);
 DEFINE_BUF_EVENT(xfs_buf_get_uncached);
 DEFINE_BUF_EVENT(xfs_buf_item_relse);
 DEFINE_BUF_EVENT(xfs_buf_iodone_async);
-- 
2.53.0

