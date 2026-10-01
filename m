Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4045237BA;
	Thu,  1 Oct 2026 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866305; cv=fail; b=aCt9/bBSGzFO1u2LzuDFOBjH8WAxMDLnlZFB9QQLbo4k4s7u7VAQKLwza5f7Y9Ify4lzZ0gpkcou9dOn9LWOZ/V+0Hxxl1+VuC9JbJFE5cT5Uddy7nvTSOnmT8pl614NEAsN6EGH7j8c6vT8EOxIRqIpsZkFU/aTl8s/gItFDYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866305; c=relaxed/simple;
	bh=2o2s5Z+tPcLs8RHZXiP14ThQyVLNexwArTSKelqT3bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AV5TH/wh8h02BUDd0oGSYhdPQ5CjHPm8Ahr3p0k3i6wPOQoNXH9JSOpHLSoDvB81qDWQ3V8DtvyVQTRJTAkK688Ubn4VcYwCs2xihpZIpuABO1KXOWBgiEXxBR4ZkGo8kpPqc21WwYw+5lk0W1L6hjitno3AMFmJfljI0fKCdok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mL+NiCT8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tEhHgpiU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mL+NiCT8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tEhHgpiU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMaU3624350;
	Thu, 1 Oct 2026 14:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fTq3+B291oORKOJAXLqr1LeHjXR0LRHlUPjYpuyIQHo=; b=
	mL+NiCT8BGWLvsdYP0XH19Ushy0KSQZtv7xpo4UJKKqSi9MfEc/gSzyBAmvFUAd9
	dgyIDx7/TL6ZxwW4ERw4a89VEkxs1RE2mDn8Cmh3Q8RKK6x3qKbtHEqVPIEgQcqC
	AQXmiCM0xxwFbkIZAE7xqQQQnvoHMUsJ/q8kFnHi8d2S6hdijn+k+niGF20YMDBt
	YDdzHXYJ4oPcSUtftg67zNpIZjeF/qK4UuL/tWepdnvwdSnhBaC8SkCzUsDBDqR8
	QCx2fa+Kp7Dlt1DSpM9v4GyyvozXTp934bjmmhcylO6+VR7xz9FP1S866GT4wiyu
	l/Gjc+zbE0sIqaQbuIVOSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns1039-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoS8o027813;
	Thu, 1 Oct 2026 14:51:37 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsntbn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxn2/DwWGAX+CCvuE8ABlRScSAii++O4+IOSRRY4lPaRhkWDUd2Mxo/DSRkV0Jx3wEMLMNP1vF4cnh6G6n7NLHTjo4ZHawiqn/6KpG0aou33uE3U0fIhBksEW9XoKWo6b3ae3dJgFjXMI+OOp5kEuvSZErxmkaqRFdMhairCAVqsEQdQVvoJWBOlGkOjdxTcJy1h9BWYmTjzeLLZFOsf85vt0oE/NUrYqCiSVf4KVu9WOFSIIRmbx97JnjIFHjWwtSfiJqn4U9K/3j4zFyJgTqEy1MkAGY82C25nzx4M0WIErh5tlqo+20pFwCUGjbFmDfK8W+2XFUzNbavAdq6S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTq3+B291oORKOJAXLqr1LeHjXR0LRHlUPjYpuyIQHo=;
 b=KohelOYAlyUNU585dRAQopNtnPALmQv/jM3YvFXUkt0CyeRtw6TRzhe1PfnMXZzfroDZtGgyjcXXnLxukdFs4Hi6QM6wr39qvsrSMdzPGbXJlg8lr4dzkwfBy2k/Qy707vl+IXjUR9Qb9B1uWOlG7UbGvRAvRuPp9Jy6bYxChv9EkSu3o4mTCVz3xhLIbb42McCdE7oCAVRIKWpHzbbincY1SlNoiDUU+5cKfSSqfA2Jb2GNdV++79fpORhc6PPLXzT3bcXn4+hzt+38jKfQLMdfQMNxIGkjFy6NT+NBcXENh59FeRl69NxctgFVFdoaMTHvm/jYMjKu8lhpwF4QEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTq3+B291oORKOJAXLqr1LeHjXR0LRHlUPjYpuyIQHo=;
 b=tEhHgpiUmQvJJ4xmbojaNlAdER5zQD0RFHgS8EDLvJqgEE1oR1AJSoyeHxUg6zTvoyrJTDWaF5iD9vg4EGrB4B1teclNuSd643S5TsK5poiAW4oDKisZJ5EDuaRne6DCJ/d1uOQExuM++88VslKctEymDiITOzxzQs9n0EzOIN0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:31 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:31 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.15 00/11] Backport of XFS umount hang fixes
Date: Thu,  1 Oct 2026 20:21:15 +0530
Message-ID: <cover.1790864545.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090954-revisit-dowry-37ee@gregkh>
References: <2026090954-revisit-dowry-37ee@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf857f8-90eb-4bea-5d3a-08df1fcb7b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZvYycHyeXLv0txCLn5B+U/h0kIz2pHWBormJFTHAOa/fMbkEoryQle6a7SUWkhPZEtaK0FbGLMDH84daSgJug/z7IenO7KWGgWqnld857CiJ8W7MZX5rcgKK5oEYSpwrLXhGS/T4N3mZ3xnbTXLEWydMZosSSlebGPq4JFbQG9edFPRpOu7y7FVMrJ0Dpam2am4bNbTzwNrdaWWZMfYyhdIjbQEPjP4ivbFh0tttNw6lJxl3W+3mul8YurlyOnsibYM2y8BlLeHTUDNOlyi5Ly2VmCTvEPS5EXlSXJolxHIqh5+ayRRBnHmFRX/iQEkgNHVx2QwzNEUyxh1cUGxtkCEg88wBL2vDpVniWb458YDfqC7oSeqS5n9G/66ESe5gZexsm4LJjn8in9hU/GNRF/gF7p365FZgp8nfsxKo5gvTJFFuKPjBbTl7Dt/H7fCs/89500qcC8ez5UriPEFjW7I69kQWarxSs7+SAo5Cl6+QGMBK9upjfCh3QzaMWQaxLXNNuuEUfTIi2z33nd607oRiha/fTqjHTBqUB7a9sAnR/KSxMzkeQgllyZFOj45G45rF3mkbBey0/iGXb6Ia8Df83xEC9dYJy1A74IRS153r6DITT8DRpiLatUS6+zH2zYIPUc940Twm4LNa6Zi0LNNa0Daou0tCRN69HfEycqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIpmzK5LpM9LAi7erPHocelCuR3yMFU7KOzPH2diSH+OTpu5VKtZlhiiXrRm?=
 =?us-ascii?Q?E2VlHPEBAzT1WX7+p9nXzxFAx75R4bW4BJT5YC00F+LIJ19K07bmTJD8o7Q5?=
 =?us-ascii?Q?Gw+MUkMgxY3MPubVjUSVvr/35H7Rcw2e11CMIAQscvvah24QarqOTRIGsxbf?=
 =?us-ascii?Q?ZNSN4FAhR++JZGu8Vq+mnFUFshldZos4qYgVIZPoumoujstOO+0a7Gv0P/dM?=
 =?us-ascii?Q?UI6cb9yNeMh+UCiMXQgvDrDoAiuTLUd3ASRSNEA/VZhkzFthqIDXQUtfQFV5?=
 =?us-ascii?Q?fQUuDW1xWeji/X0Q2Wt/oLwSzm2YE8UC+LxK3av2mKdTUlv6+gHGVsHwcrbz?=
 =?us-ascii?Q?uXog21xZx1d9UNn6Pxn02Ll+rYmgzODqs8LmBTjl4z2m69vklX9YKfPV7bTe?=
 =?us-ascii?Q?jtKa9e8ClaTbhkPLuL8keLqJ6pY0fVyPa3a9IEfml5iAU/PLuZVa/9aunE+s?=
 =?us-ascii?Q?XuvU80/GB75Sdtz7A4yFkEcKbbvzUo7BNMk8VjWtPkR7HlG5K8YTfxdgI4SE?=
 =?us-ascii?Q?S1d1fhq3OLZa1Sxogo8Zybx6SNvH43FINAhcGORcI2IaPtxXkdCK+ElvBs8p?=
 =?us-ascii?Q?2bT8VDfnigUPdZCOOPLKRBJm+mxRJxy+DO8OVc8SLmf+bWdTparBbD2g6W+H?=
 =?us-ascii?Q?P8lxS6MpL01Wq9viWjGGr5bLGpzv97zST+Nxo+8bLcE3Cn+lirG8D6VfE+vI?=
 =?us-ascii?Q?x4iBUSaAUdGSwls0fjAEOZb730tmTmS3NmgWo37MN9oUcp14uLzN0YhS67UP?=
 =?us-ascii?Q?aqZHy060M3NbpbF5Rnmiymvp0YupM3DYLL+OIgLwar0piAWbnLGe8E0EUUO4?=
 =?us-ascii?Q?Y4pvK+ZML62WTZ3xXCnoVJYR0YJLE6uKlTDI82xgHppr2DuknHuvoQUlp86u?=
 =?us-ascii?Q?7eFO0GL26ghLVVhOOI2ynOGcpMFuYdvr9gUplIP3dqA6yiNa3k36giiT9VOs?=
 =?us-ascii?Q?J1bQq8PWT2RCftj3q7mVFHgfs2je39Qp8QpGU8mtDZ2tpSndQDdlGNvlP0Fm?=
 =?us-ascii?Q?buVKjIk/gP1zfbNbe0EQ7hGZJyfsUOPk78JLz4v8LfObr0kyIVRrhvX7Hkt/?=
 =?us-ascii?Q?h9cBxl8G2JHyQFx6edwXphp0A9rY51HEFnKW70hxR78OrB5+9y5on3RQ1cpV?=
 =?us-ascii?Q?5Z11YT/WU9QuSN3f5OhQ9lrTAxBBQ/L10CVk5zhPX4vAYwh96tD3d8yb/Mj5?=
 =?us-ascii?Q?T2czqzX1kRlLsrm1ueW42Yy61koKmkmL5MLSNKag4/aUSeVIpLGKMTUiR5ns?=
 =?us-ascii?Q?BTwxMbv0l7zrGQt6ydB4tzXqp9alZ+uIYgxFCUV98mwUuIEXftiw1GkMMbkt?=
 =?us-ascii?Q?g+iM2BZzv0vIBRWpEnNCscoE2o3iamG7/7/NTmgFRmLO7bXqQ+kikGdmH90f?=
 =?us-ascii?Q?sDizar5bspTYHuucQuf1unGRdrCanXoilNiJF3nkE+mS5IMduLMs+tXLr2qu?=
 =?us-ascii?Q?WOD9WLF21k1D3GOfVDflvE2Dol2DsP9CmHJ6hV/71TmUEHxFGNjoYQeO7xzy?=
 =?us-ascii?Q?oHGaYP2jyOl5k6paT6pukkrZCBmsc1KP5/rp/UrJxWPn6K6ikxXKeHXVoeqH?=
 =?us-ascii?Q?aTnlywnn8tUhhFm/5jRcFI+BRcXbhyWEvix7O3vm4s+Tz1QlU4vQiMALNLId?=
 =?us-ascii?Q?GN/t5ZnAv6w7qTL6ovX/4d7XBoc12JmfVSJ+y67ZKFvrvPD7Z9D/heU45W7c?=
 =?us-ascii?Q?aVZcn08zpDYi/B1gIig0IwmUDHjZpGnOyohxHO9DxLqni42xXPO8Rvr1W+Rg?=
 =?us-ascii?Q?cnpJMblFEoovKzqxlDrTGcumwqm3K+kHb2USlsWvjeVG2tcNkBO3VP35Jc2y?=
X-MS-Exchange-AntiSpam-MessageData-1: IZ19mxMophSakDVGzO/Q3krD/3VpUhQbRAA=
X-Exchange-RoutingPolicyChecked:
	lXHIfQVy+5cFk/enaxJ37NFNt5/Kn1h39iPa3KKizh1x8HTYLjJZwG8wPsn7htFCzAiB4edYwoX7b/oIJgiN7LdqWtEHhU2zXr+yF1db8vQuMxHDxF1zNhmQa2eBOrYyWGaWJTcLT3zNGzKj150wQVBvn7UHpYnYy/luhK1r6rrxLVUNu9SemtKbhv8tBGhiWrT5wQtawFPe2W2fdZX9XvJL2zsnUBAppIU/hxwxh/P9zu+Tt00wZvLDREe4DMqgabbKxhU3W65tLp4nkqQXOa3pPRz1A2ubh+Sdntpe0tC8O5Y500Bwow8mqZth0pxBTQk+My0oQcdLdcUhWDYbDQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X0JdR8LClcaC7qxlNpxh9Iwmp4Lj+rdgrfmaPsNEtJxl2eySM/MOE2w1eTCDtdnNRCFmgQeRnpNhJZMstb5OOHw3BRj0ZTTzS8og3UQQSB5BjcxMp5uBnumQEFacWEaPSoG3cWiCawVHEiQHfNMiKDvqZ/8NFCMgJUGfKxyRpogvDKaSGw6bYarOH6PxGTuhlubqFd0nj6Oms6vuQrmWrLPo/zmvi/4FVj2X0FCbmlmwmQjvzevoJXzUUAGfRwWzZLMGV6aJk7kRUJmMQigLBN5QliZL7vB12ELcpCy7Kg+QWlE6zLEFvLGdgRW8+DAJvTDBrOxZXWh6UwtxXUmJrw53O00lbcyUFvxRm+6hPZ0hYwf2XUIF1+0ktpttyWWv5T7SsOGP0JK0OsVhKGMB1GGo6VF3GembnOM8bun7VV9bmm+o9Nzy3GZhf7/41gVB4Vw4F/s/ZJEic5YrRKbhDBiHFzN/0kQ+qt6fvk11oRm1jhiHOG9tMlh4VXqABA3oETws7NSmZ5L9NWIAc4ZwVsS1RHLQdwezGz0BSW5OIujrYMGauMasBRZ8EAJkRV4Om9kwGouCkLJKmPM6uZepZ3h5j1VDsk5ysUvdKDGupLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf857f8-90eb-4bea-5d3a-08df1fcb7b1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:31.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTF8JGneXTCPOvqRsMQ+S5+ZORU7KpmYn1zjnVlJhEw3aJb6RLcIcXXRHSKOD5l6upGZJCFataz7TD3kRVWk5iELDYAxfZ0NzNnjGC+IZDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=932
 mlxscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX0L1gBAlvEo3N
 A4ZPYBd+qXmXCHBnb16cmlLMUTwqcUfcngnAVgNJq3kWoNWBAiKXVIZy9idkbMc+ZofXXveW1Jl
 pcOwkBnxTDxHgJwaGBPAq53iMkwqmC4QdrAHXDyx+BK+k9hT6GJ0AIoIMlDNBD58WwraxfbO0XH
 7uWdZ+kTiVlbJrAOmKFABFG5gz+YZ5mzTi8ylXbPfOePfpZmYJp8gDrzpOZasBCPs0EoSKm6msU
 s2/k2iTbeEyga/e58iNfk8nv5CWln3A6Gymm62ztyBmbsFeUDFbFawLEXMIz58Dc0yoUfb4sz2b
 E6lbadOcMG0Ohnz5XPLTlgOS9wo9dyvtg7K+p3KWgZOfTFTXDvidEQ69unRd0Z+unLBZ2rfaZFB
 tnvrCPXbQuU1uItT0y3/wr6LbJJ0fhDvnWyl3qCWGeNEcf33gL0JfrQRpVw23R558/z2C/OwRcO
 MV7PonRLTgNZO1DOK4CgeAzahPdcO0LSOVnA1S5w=
X-Proofpoint-GUID: JPTMN4G4Xd4Ie2K91--2GNl84amk8C1Q
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe737a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=e5wmsFHVsE9BYVS_jYEA:9 a=biEYGPWJfzWAr4FL6Ov7:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX8+qAvead6DN6
 bCZwMcphviDlRDLyOPoq7wf8IwYL7sAaVi9NPO8p4McSmmmUg88GRCIPp6QlOOUhSHIi1ROyzue
 SkJWupsLXd17siUFU1sJEN9nAwHfeB0c5jyNlA2/x+9eaqKl+rkT
X-Proofpoint-ORIG-GUID: JPTMN4G4Xd4Ie2K91--2GNl84amk8C1Q

Backport of this series:
https://lore.kernel.org/all/20250625224957.1436116-1-david@fromorbit.com/

Along with appropriate pre-requisite commits.

Previous stable backport was used for doing this backport.

I have added information in commit message upon conflict resolutions.

Dave Chinner (10):
  xfs: log items should have a xlog pointer, not a mount
  xfs: aborting inodes on shutdown may need buffer lock
  xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
  xfs: buffer pins need to hold a buffer reference
  xfs: xfs_ifree_cluster vs xfs_iflush_shutdown_abort deadlock
  xfs: catch stale AGF/AGF metadata
  xfs: avoid dquot buffer pin deadlock
  xfs: rearrange code in xfs_buf_item.c
  xfs: factor out stale buffer item completion
  xfs: fix unmount hang with unflushable inodes stuck in the AIL

Guo Xuenan (1):
  xfs: fix super block buf log item UAF during force shutdown

 fs/xfs/libxfs/xfs_alloc.c  |  45 ++++-
 fs/xfs/libxfs/xfs_ialloc.c |  32 +++-
 fs/xfs/xfs_bmap_item.c     |   2 +-
 fs/xfs/xfs_buf.c           |  55 ------
 fs/xfs/xfs_buf.h           |   1 -
 fs/xfs/xfs_buf_item.c      | 378 ++++++++++++++++++++++++-------------
 fs/xfs/xfs_buf_item.h      |   3 +-
 fs/xfs/xfs_dquot.c         |   3 +-
 fs/xfs/xfs_extfree_item.c  |   2 +-
 fs/xfs/xfs_icache.c        |  10 +-
 fs/xfs/xfs_inode.c         |   4 +-
 fs/xfs/xfs_inode_item.c    | 162 +++++++++++++---
 fs/xfs/xfs_inode_item.h    |   1 +
 fs/xfs/xfs_log.c           |   2 +-
 fs/xfs/xfs_log_cil.c       |   2 +-
 fs/xfs/xfs_qm.c            |  95 +++-------
 fs/xfs/xfs_refcount_item.c |   2 +-
 fs/xfs/xfs_rmap_item.c     |   2 +-
 fs/xfs/xfs_trace.h         |   5 +-
 fs/xfs/xfs_trans.c         |   2 +-
 fs/xfs/xfs_trans.h         |   3 +-
 21 files changed, 495 insertions(+), 316 deletions(-)

-- 
2.53.0

