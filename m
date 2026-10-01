Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559F52ED4A;
	Thu,  1 Oct 2026 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866428; cv=fail; b=aF9pywjRCsN4kZW6rLNuT24D+Jl/nByyTqq4xsg52J5CKVwCC4YsTqJzJScSvHjf9rLPjAJpjCAHucRanqgmSZnlV6xy3wfVug7yMf9k3dB4ocF6o/R2DdKcHlCT2GcLWFmvwyJ8zyD14miKwylF+k2Qm5J2z5n4YCI5quYDEfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866428; c=relaxed/simple;
	bh=99jHL3j2KqJhaOoaT27NbvEhK65eKRAbkLqKKzQeFB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxgTwVZsHkD+zoyTvFp2jVK0uHv1LtWuEHVsWlmptErZgNyGnOhGmuUatiZ0YENNkL6I+J2LRz44vVehZsE9R3yf2WFyZQjzKYOaFL+ITyZU980h0Bg+Rp/C+4Kp7rE5ueUER7LP0yXe83QVYt6A70vIvUFlVBwNlNbHGYHv1nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b3wjUHlX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f97uM9hM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3wjUHlX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f97uM9hM"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMvse490561;
	Thu, 1 Oct 2026 14:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1wl6mv/NUzJkaG5icea4YbfxX2BKeLofZ3qrK7gVKT8=; b=
	b3wjUHlX8Ue/C7Fvgz+UwvT4N3EIqQpGhOHcWK2d/TGZDvSuVYmr+A7/0FWka3Yz
	rsqxL/B1+Jy/vIN6boXvobOPOlBVQIRHXJYsn38UPdj28F5E1CCnmG2iagHbW2MW
	qKltTejWGv9eGgIOUpEMTFymLj7cZjRgqmnS+YAdZGk5ct8awVSk3Kmk1Z02GiVU
	cwEUS05LAiBLG/dZhsVAMeFz1iX2HU/wzBegidpe21sk9wbKiEd21MAl1Q3Ma6Iu
	ZD3T7UIYwShT7tQDnrd8/QHhSGkQWYYCTtk/Fe07lEDbiahHyhSPaPsD4xsXoAyr
	GDcjLh7YD5h3lqS8nEpSMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6ks9476-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:53:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoSm6027827;
	Thu, 1 Oct 2026 14:53:28 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010006.outbound.protection.outlook.com [52.101.201.6])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsnv2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:53:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx4SqDwczbpbtcB790gDD73b7dCiIDkEtbYkAhX1VjBbg2TKQ2qGAnC0rXuoqdPglvn0PwU8hpxZdF6NaJL7dho9CQath/TBA5RLyTjhO8mTi3AnaBGxlstdnZ0GJwnCqTsjnJLC+TtkVRjuamK2ht3pV+KYV1rbw5pN8fXrkvBNud3cA7URKIuHSh7H+1eP+L6yE4UD66nJTCGVHyM3h7nZkMc5aKgvaB+MVdqErjzQjRsiQM0BRby1PwOPNGhPJ5+0x/Wx40eVPlzC+mr62MOyG9BKjhJgVhFo++19kctmjBfJps9cU16wvgMV8I/a15HNMYETk5+VHGtXvbAFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wl6mv/NUzJkaG5icea4YbfxX2BKeLofZ3qrK7gVKT8=;
 b=OBqtN5DsCxrqMGlFQTCggCogpOrpf6DB87qTnXXI7Gbz7dnpRNk3QUMd5Lz19TRZK04YaB2VvW7ubAyut9qLMzRo9vlYLLkIZHnDSXC9igIiRzI75s92EYtCDzE4KM2l31dbqlJGGRtcg/tT67UHv29C3NmCqknxrhmyaGUEzaf3UbOwg1qX7uL66b40xhtMvfnzXrV7JoCYYb5tRZYOGIoNPAEdqNzQ7L0fpPPZkdsxKWzzJ9efJW95z6lpqIQSoZlCOlBRPHsshyhBmOLCE6f26QXpAETRdZblXT5ncyqTG3JDN2gxXwh9u3ojh2ZeyXMqTnk/JC/ZQSOx4MJMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wl6mv/NUzJkaG5icea4YbfxX2BKeLofZ3qrK7gVKT8=;
 b=f97uM9hMODWTYGH9a90+IwBudkhMU3O2c2WR/q09zbvUrGnE8huifHkX3GsjyH7J+oQZUyTZnnEdwf4oHWV7LRfsA51Q7FZE/+lCBrWHRzGM67rRQxCq42Fizw77v5JYMDU9lsQNDI+74H1+3EWho5GaZ04YQJ5N8YaVIzKpmTM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:53:24 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:53:24 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 16/21] xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
Date: Thu,  1 Oct 2026 20:21:29 +0530
Message-ID: <2890a07c14d2aa497af4be13ea9bd51167524ee4.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::14) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c13bed-8ab1-460d-61e2-08df1fcbbe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	I/gWxsX/bDBsv8jarLigeBBBUnSGFbJwgJbR63g0/KGLIvL/+HKYpVKcHBO3NGaLxeSqKDy89ea+SWsP7epVTYdyztk7mKi0wfONoMCjXyaus+8E/9DPkHycI84yMEoSwG/MxTzzXh6APOH5sJMGwwPVYlNwYOuNOokKXKlcGjOT1pEyTL+tJi7b/LXE76j93w6J49Sdwm1Sl3UqUpTc2vV22+lCsKi8w9+CBT0UEgp3kEEoAJD+Ks+zQu8gbaxPMJeLo+8OmgYotAliY17IYaAJuBV7wI8yjFUMxiQGkuPowiTxjn0db1rFOh/BQvcxVWG9nQ8gsr7Jo/AdeMcZwrk4GdzZdLZMIyvLddbMH0JcXGaVZi0mrDVKoTbIcvh8qt7Qw/OQb2dk5T8T1YXob0AwKqAODosWzucI17Mv76lImXxK4Ly0qDGr89X01ubyho89hBrdoxCiIlqz1NaZ5oEIktun/hELfXwTCWYPYG5wrwqE9007frUQ/PRZb2hXIe8kq4RbyDwg2IcP/3gbMVicKA2oddb1upnd4XdA6vIdpCyP9wro0TV28nnNFs1kZtBguBlSEUJi0nttKC3HIEUIHkP1CmSYy8KHTnCzTntc6uxrybeAR/PGKb73LODiTYalr79ZHUmrL1m6J5Epge34081R8rp4Ykqa0Eq80sU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6EAs0KZMB2Yehe6bSIKkbDIiO5Gf1OtlU4J7Zi561p/fPSrZwIsnxJrDChW?=
 =?us-ascii?Q?4cs7y+qedrcY4fajsJhcbIWq6B5LfPRSorF3ZnvrPeijWAFlOF5sQdyPqc9I?=
 =?us-ascii?Q?F2n7JMCZoYb02qBGzXYQHiClB9CVZr7URGVkcICOkE+tHkH7gapKI94Tlr8V?=
 =?us-ascii?Q?dkuk5HQUQqhuHw6a0WlCzmufVFaxz89hwQS7FLs3vtHXAEaS03XKlhsIcBT/?=
 =?us-ascii?Q?Pc4onDQwIhgmWkdqH/5pzRRDnM8UFPhq8fU7pfL6dG80KcK78DPhYCB7yRkH?=
 =?us-ascii?Q?ajNKEj+bhk5DDyAy+sWCbhYay33ReYYsZplUG0Xct6pl1DksuiQnFJ7zdmWC?=
 =?us-ascii?Q?uzYJhdZ2pV3JEtPfAPJD/22oWVBHfN8wqxVg8ILo13p4byLCxpkMGvf/3i4E?=
 =?us-ascii?Q?DfIyhPLNlb7Tlmac/peJez3LOECCL4NHIrErmFx7I/zfmW7SK2UtORLN9F7p?=
 =?us-ascii?Q?QjCq4UbIkFw0JAVs7vtgTp0N6/whrDS4/oAZtnItRA0j1uzJVC9gmiAx7rdF?=
 =?us-ascii?Q?KSh3g/tojNepKqzL+/+V0ylw4o5/7n6uzfRlpPxM4w4EBZsVEPncbRzcYIls?=
 =?us-ascii?Q?Tis8lLRCATNNf0Iywbof+pRNtHx4Obgt9TjH3sbDFzzBiZxp7/8y2BaN+P6K?=
 =?us-ascii?Q?UW1rUENKGA+dqtuDCNdUYBLCR1w84NYb2qSK7mQQEl7gPb0sOb5WpEvvaqmA?=
 =?us-ascii?Q?D6LuWCtKKTTlcierHbEa57FyUVJC3uVfWUrqT4z5tZcqCakuKioqcofRIBaX?=
 =?us-ascii?Q?tvJYhCbGWP7Pi539F2dNsQQP4bgyc0uYdq7SHyj0Z/jk04P7y5O02Dj8/mL+?=
 =?us-ascii?Q?0PBSR2fXD9Jvn+4eOpYcm6bCOh/gUsEYU3MIw+rSB2fpdEkulwmPyLmJELJo?=
 =?us-ascii?Q?Ks3fufiBcmP3ht5MQNE+tkn2t6lvzfE0kQ4kLE1pr4audpaei6IkjpTt4bmS?=
 =?us-ascii?Q?QEpypX6nswf5W3kU2LWEirMuLhohS+zoMVDk9dNu5Bu+lPpbZyVO/JetEXaZ?=
 =?us-ascii?Q?HLduvBTUWweLz4SGo+feZx343Ij/n47AUwlzDsD0D9SW4oDGFEA7A9cnC+RT?=
 =?us-ascii?Q?uohzP+e9/5+53jO4r/VL2QOAmEaEgbMvXndIqNf+HiwdlTy1WuhGcCVdC07n?=
 =?us-ascii?Q?K9M/n0i6WGDDr+Jjb6XDIj8TkGvBN+R9NLrwUn0AqIYj4/OleWEJuuCjarJa?=
 =?us-ascii?Q?2sFW79lPx9tDpzwoL6GSzVMSdmxN3PNNYWY05m0DGy1VpAYNPteEDd8+nQF3?=
 =?us-ascii?Q?l3cdb+4qgdZkaiMs/bp84B2KHFqoSut2zGoQ4POEgL2ujVeRihFi8zg084/U?=
 =?us-ascii?Q?upNGGwmmQXGdUcoXIjtX/xD4XYlKjllCxc4dVxUCVYyoLAAN3GGfCueGQqQj?=
 =?us-ascii?Q?y4jHiuUXqM2HZqtiX1ZqpBB4XS/dVLEJXlKIKI4XHMNdWHAG7O6C/BWvRVSY?=
 =?us-ascii?Q?tRJLUU9n3Xf2txknsOY0O0gIQcM3v12n8OgMIAcyWVLdvV6s5pPrGOrZPZ7G?=
 =?us-ascii?Q?RTPi0Vv1k3Rsp0LUYXHQqxbyCoEhWOMog9l/0W/V7Al7Eg3K/W2i1k4KP7cy?=
 =?us-ascii?Q?tq3+mDFC8tFsIq4x9yWARbnq8fbtn6oEtQ5Ww9JgnkY/VqaZioRH0Qw4Rmzg?=
 =?us-ascii?Q?+IRe3EP6cFHIBZSoCSVNw4yr0PN47nJVLtiYfLvciNXGxXx18sB4PeaROmEt?=
 =?us-ascii?Q?ZF/NwfANqHe9vuLh1MLyYVSQrfSJRTP+wZzkTiegqKbwfLdubVfbmFwrqy1w?=
 =?us-ascii?Q?rQOcbPZekCJSdWS271Vlioq76cwBZA78Eff39cE1LDSmTlhVeYXBN1FaaVg2?=
X-MS-Exchange-AntiSpam-MessageData-1: 1dOtnbGwsJVlcNcDPQwHQfNGfrHComw1Mdg=
X-Exchange-RoutingPolicyChecked:
	ylQmDTDm46A/Ug6d0aQ81VhbxvLFat2qM07Zmc+OMsYDz7a4kph0NQEJiA6IDRLkb+YIGJkuHgCWLdVdgYz4l8rvtnFnHWpQ4l+0uhuM22kZU51GuR+2HMvQ7zkCyHK+tfkEMCotlRJxt+Hd472WEBLv7BAJJA6eLuxzn341mcOMh8JPVTBeiglmumwg68+8hEiDs4OsUBjWpdm5NUjNrBl/xSH3ERtpbmEPdAmRbb7vQnJMN5xqKG11Yj48zSf1Bp8biuTZEiUOd7aNTdJZtC/9yHdw0r3CyQX5ZlxxCdR00YaGNIBMZ001VUaO/rqV5zeqOOntTKk+3oUZd/I0IA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ulUcHlSm6wzud/mEyskBQIWEb7X5FALEuLDKp8AX/QiKADQrQ4yl8AfBYAOkr6huQ86wk9hC2tlal7oQHhtKpt5n6Qtd4XdWZ8EcplYFeUsASabvsr1BWxg7ucFW8n9UG03YmOn+0K1em/mUeIuFIqGTRYrP6xxLwo7RClVqtmYI7+KYhJvPs/BNSrhHE/CJfoEQyZ0KztEE31S4N5T9XOehcAIBIWJyhUkDV9JlvI6YNrpfhmrRK0415qDdEPAMUaudhl0Jp8Ec4y7WCHZNE++PbjUrQQnq/hRLNOuSKamCNHgdRTMqIhmpLgJxxc8FRRmpoka2CT7bB53ZYswEfFWb18A206MJ3xJJuVJbphWFCtdSkxNsue6Jg9MKOCtbh4MVGdtKs6Z3xwxSFSI8LKixoGRjfj/Ulmn0VTmQNrzZtbh/ghaRiq1He8V1ciUQJlEgNbQakjiF+GFn9E6mzWoJ8sFjaZvqRrtzMqfzoN3LhfLdOiYmOt9d1/WuvcpuqiQUDPzCs2xmC8Siv9YLYQe+SsX8ImKU5W+SRJJOSmCpJ68Ibhfa3oJ9HYO7FbUeHdvbLbeYDnYo6ve1UBqqWQ4lnR4JkdGzVmMLz5zeUTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c13bed-8ab1-460d-61e2-08df1fcbbe2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:53:24.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DknP/c/FSyYKpWEwl0kGfAYXgSw90cYBlcGlGjZDsjM9PgBd97Wc41iC2JqSTry8ASbEOKbk02HgUtw0gXwfNH3EcSCQ0MccgUqYQpfcqTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-GUID: raPjjpCh2IKV8G82WcZk6tOtvzn68fEG
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abe73e9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0iG5kSdWG1Uo
 bgAC/yE+hkCPh+/ForJonpNdtJMBaotS9qh1CsMhzUa0365g3rO4AtPzVDCxKZjUioVP9sOAZk8
 AmPASOT1FWMzJu49+gD/uUwZuacviQOt/jud/W0aUKeqOYPpLY8n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX374pQhbyEnE2
 B+svcgBMNIq1UeBmnArnP3oH/2RZKyXPNn/YgMOAFz0dEIhdcWLQHVSH4q7Yd1PFHr8+ww7Bxfj
 PZS9z/mKwq6oDKdYWML2I6jxQchE51IGdmn2mudpqLBexi/fhjNpfdhfvJcVEYTfYAcc/doaZql
 l/3ejlcBikOlztfLEKXeUcBtJAX78+2uxrFRihQ1HTUFpyRq6ye+BxafESuOlBKmKfVqS5VIkOU
 LNQrVBSRYeK9D6+MReqI/EhfopwmYT7gNyJr6LEARwFdyADml1kFL+P3unx+Zi7WMotz1w8GnmJ
 zuVaJ3WiMUIFNNS3PAs/ac31YbsSk9lSR8HK1v8mg8kkHSuUvBJFavrI+zXbsdF9YDz/d0mehhJ
 aR4BYjQtOQx+Lf8D8aBJTsO6skD5dQakNEBQMoN2Mn8ikbrurZ2S6aAfl0DeQBwwi+T6hga3rYo
 fbg4zKmclHG0ZX0etB9nkzSGf388nua0DPuQeyz4=
X-Proofpoint-ORIG-GUID: raPjjpCh2IKV8G82WcZk6tOtvzn68fEG

From: Dave Chinner <dchinner@redhat.com>

Lock order of xfs_ifree_cluster() is cluster buffer -> try ILOCK
-> IFLUSHING, except for the last inode in the cluster that is
triggering the free. In that case, the lock order is ILOCK ->
cluster buffer -> IFLUSHING.

xfs_iflush_cluster() uses cluster buffer -> try ILOCK -> IFLUSHING,
so this can safely run concurrently with xfs_ifree_cluster().

xfs_inode_item_precommit() uses ILOCK -> cluster buffer, but this
cannot race with xfs_ifree_cluster() so being in a different order
will not trigger a deadlock.

xfs_reclaim_inode() during a filesystem shutdown uses ILOCK ->
IFLUSHING -> cluster buffer via xfs_iflush_shutdown_abort(), and
this deadlocks against xfs_ifree_cluster() like so:

 sysrq: Show Blocked State
 task:kworker/10:37   state:D stack:12560 pid:276182 tgid:276182 ppid:2      flags:0x00004000
 Workqueue: xfs-inodegc/dm-3 xfs_inodegc_worker
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x8b/0x180
  schedule_timeout_uninterruptible+0x1e/0x30
  xfs_ifree+0x326/0x730
  xfs_inactive_ifree+0xcb/0x230
  xfs_inactive+0x2c8/0x380
  xfs_inodegc_worker+0xaa/0x180
  process_scheduled_works+0x1d4/0x400
  worker_thread+0x234/0x2e0
  kthread+0x147/0x170
  ret_from_fork+0x3e/0x50
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 task:fsync-tester    state:D stack:12160 pid:2255943 tgid:2255943 ppid:3988702 flags:0x00004006
 Call Trace:
  <TASK>
  __schedule+0x650/0xb10
  schedule+0x6d/0xf0
  schedule_timeout+0x31/0x180
  __down_common+0xbe/0x1f0
  __down+0x1d/0x30
  down+0x48/0x50
  xfs_buf_lock+0x3d/0xe0
  xfs_iflush_shutdown_abort+0x51/0x1e0
  xfs_icwalk_ag+0x386/0x690
  xfs_reclaim_inodes_nr+0x114/0x160
  xfs_fs_free_cached_objects+0x19/0x20
  super_cache_scan+0x17b/0x1a0
  do_shrink_slab+0x180/0x350
  shrink_slab+0xf8/0x430
  drop_slab+0x97/0xf0
  drop_caches_sysctl_handler+0x59/0xc0
  proc_sys_call_handler+0x189/0x280
  proc_sys_write+0x13/0x20
  vfs_write+0x33d/0x3f0
  ksys_write+0x7c/0xf0
  __x64_sys_write+0x1b/0x30
  x64_sys_call+0x271d/0x2ee0
  do_syscall_64+0x68/0x130
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

We can't change the lock order of xfs_ifree_cluster() - XFS_ISTALE
and XFS_IFLUSHING are serialised through to journal IO completion
by the cluster buffer lock being held.

There's quite a few asserts in the code that check that XFS_ISTALE
does not occur out of sync with buffer locking (e.g. in
xfs_iflush_cluster). There's also a dependency on the inode log item
being removed from the buffer before XFS_IFLUSHING is cleared, also
with asserts that trigger on this.

Further, we don't have a requirement for the inode to be locked when
completing or aborting inode flushing because all the inode state
updates are serialised by holding the cluster buffer lock across the
IO to completion.

We can't check for XFS_IRECLAIM in xfs_ifree_mark_inode_stale() and
skip the inode, because there is no guarantee that the inode will be
reclaimed. Hence it *must* be marked XFS_ISTALE regardless of
whether reclaim is preparing to free that inode. Similarly, we can't
check for IFLUSHING before locking the inode because that would
result in dirty inodes not being marked with ISTALE in the event of
racing with XFS_IRECLAIM.

Hence we have to address this issue from the xfs_reclaim_inode()
side. It is clear that we cannot hold the inode locked here when
calling xfs_iflush_shutdown_abort() because it is the inode->buffer
lock order that causes the deadlock against xfs_ifree_cluster().

Hence we need to drop the ILOCK before aborting the inode in the
shutdown case. Once we've aborted the inode, we can grab the ILOCK
again and then immediately reclaim it as it is now guaranteed to be
clean.

Note that dropping the ILOCK in xfs_reclaim_inode() means that it
can now be locked by xfs_ifree_mark_inode_stale() and seen whilst in
this state. This is safe because we have left the XFS_IFLUSHING flag
on the inode and so xfs_ifree_mark_inode_stale() will simply set
XFS_ISTALE and move to the next inode. An ASSERT check in this path
needs to be tweaked to take into account this new shutdown
interaction.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 09234a632be42573d9743ac5ff6773622d233ad0)

5.10: Add header.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_icache.c | 8 ++++++++
 fs/xfs/xfs_inode.c  | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index d973eca1a881..f52737051b49 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1040,7 +1040,15 @@ xfs_reclaim_inode(
 
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount)) {
 		xfs_iunpin_wait(ip);
+		/*
+		 * Avoid a ABBA deadlock on the inode cluster buffer vs
+		 * concurrent xfs_ifree_cluster() trying to mark the inode
+		 * stale. We don't need the inode locked to run the flush abort
+		 * code, but the flush abort needs to lock the cluster buffer.
+		 */
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		xfs_iflush_shutdown_abort(ip);
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
 		goto reclaim;
 	}
 	if (xfs_ipincount(ip))
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 5c04c61964ce..a36843bfb6ef 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -33,6 +33,7 @@
 #include "xfs_symlink.h"
 #include "xfs_trans_priv.h"
 #include "xfs_log.h"
+#include "xfs_log_priv.h"
 #include "xfs_bmap_btree.h"
 #include "xfs_reflink.h"
 
@@ -2553,7 +2554,7 @@ xfs_ifree_mark_inode_stale(
 	iip = ip->i_itemp;
 	if (__xfs_iflags_test(ip, XFS_IFLUSHING)) {
 		ASSERT(!list_empty(&iip->ili_item.li_bio_list));
-		ASSERT(iip->ili_last_fields);
+		ASSERT(iip->ili_last_fields || xlog_is_shutdown(mp->m_log));
 		goto out_iunlock;
 	}
 
-- 
2.53.0

