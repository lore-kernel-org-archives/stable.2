Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FFA52E07C;
	Thu,  1 Oct 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866399; cv=fail; b=FuhQlEtT213VmPGb90Fa1ycfZOSx0sQtmxFGYwRPDHWJvdi8YN2oL4CzQzp1zDQpzAT8W4QQpXBDyf7rpapr47sqGE3F4xz4z2Jn60n5Prxz861gzf9sp5OSGSOCx5Eh73JtFWHXPFToN9J46wWvqtOwJdzwWpZJLPT0gn5Oe/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866399; c=relaxed/simple;
	bh=ZIEOBBjkOndk6QGlDfeXKGnnG/h0LP9VQ0+gPC044kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jWLHc0MbNWtHOC11Ea9fBPwe7Q62S7oDqb92RUt3jYMQ6i6HWP/tMYOxnDhyjP+H4f62yaEoTuZi5uToXHeQFR4S25N3DaZPg1NOaxg7GKYVriRZUoyhxqeeAoK/XEIBiJ1iCv2zKwp7Fpj0wad6A/w0yoGqJ76N0LLVPkZDL0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1J0K/sN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9RKv/Jc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1J0K/sN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9RKv/Jc"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMuF0490541;
	Thu, 1 Oct 2026 14:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8AwYal9rs8omGQI/P5HqcqkytBqUaEzZEF7HYOJ0/kg=; b=
	g1J0K/sNn2Yf3QQtjYBDD1hcRBV9Zq0Co584jYhQAWUTQ7GE/ks3OLN28ge252Ej
	zP/+kYcCmtk7xBCB5gxwADkVuNmJyyDsYpxprqFlvgu9ixM2JSSKD6jxtSEY11zu
	rd1aCL5HcJjWziNtB8j60YrFURyWi1URoGwwcPZtY7bP7jWatY4qwDLlpzBMiGQc
	2K6sqzh2w7M8XlUYA3wKmdsqwefsDWF9gRDcsEEDgEw0thQKVeKOC6p81FyiD3qW
	VHkEl5W1vFwqREKxuMGjHJlJsqwvTDZUsR3XdmgpVZkdJ6CZrmh8OrVQ5UCKFJIi
	FSLOi+5jwaHeaWBPxEyD8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6ks946a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:53:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691Enn2V011474;
	Thu, 1 Oct 2026 14:53:12 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gepkqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:53:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbQqxVmgDp1+UNwzQZIc76bWAdW9x39bijGrUCy83DxIDMjHghBQrKkxZIkGfn8JWgpxvjNcSUaTfIG8sLWsCSxrLT4kpaKLa0d0dZ5/uk5cPeeH42drhnUpDnhilVT6Kv0iEs/57MUzmzWbYDGyXu4AYCxS6hKPtSZHapC2QrXIUpRgs3VhbnYJoj2CdX15x3SU6on0jQQIIaMjArDEC1apO95wRSHUhXa99p6OUgq35M6fom4YZ3h5poBObKtZCism9saG4TxRTTdp1Crn93zogz+YgDEMjMsDdxnw6uF1hf5681Rko7ODDbnhZQp3l+Io0N2QO4kGC0S1LwPjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AwYal9rs8omGQI/P5HqcqkytBqUaEzZEF7HYOJ0/kg=;
 b=orNqE5xbbCo9Db+d3SteA4cqC0nT8fd0sChz+koPkjQYbzVPMmItvo4FPdiOiqd94EGzCVaY5/CNiYG/9ekbWHQ4COq/7cy77efiTAZA3kagxMWaRdvHQKPpmcjzDIJmQoPVGO2V06tCFHZcCjxg+89FEkD6cuzp7rwu6tNZvcaLOu1q1uTFIAQOF/oKLK59W3P6xM1TyejKjdIBAjrUsMyJhmRCjPWb5lE/XsV7PmByW2kf3OQYEw3jJrAQKRLzwYl6RJ6fF74LurKvpz377ZSUoOZ6+D1pYL68MOf3jtp+r3N3YJ0QE4JSl//uvmTWdRrA78oksYzlMSq1aAhqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AwYal9rs8omGQI/P5HqcqkytBqUaEzZEF7HYOJ0/kg=;
 b=g9RKv/JcWo4M+rc4pKkb2hW3VIO/jJsbPKACpW/a7TqucXRE1/meg+lcC+dXU0LjvsmfE6lm4c5EGYw+wlBTm81mfcC31ov1bNh71nYAzhJcnKZPcFgYPU9ZFkl1WRi+YAo3VmPFWttUYws/SCLDLPcFIym48IWuWnPSwe6RHgU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 PH7PR10MB6556.namprd10.prod.outlook.com (2603:10b6:510:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Thu, 1 Oct
 2026 14:53:09 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:53:09 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 5.10 14/21] xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
Date: Thu,  1 Oct 2026 20:21:27 +0530
Message-ID: <606f056ed4255f90d04a86d076c03d08e305ee38.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::21) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|PH7PR10MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: ed25d4fc-d2e6-441e-dd0b-08df1fcbb532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3NZg+bTrvSSTVRXx0jA9nSGeTKcTEBcqwECrFlJfj6alDh/JGdCwU1JErtiy6fViSjU4vnrFZr0amWsdfcy5W+8AL6tmbMDbuaBOHHBsxcoMBouxai0iks7TJb6huZ9xg3Fg/usUleBu4Wu+HmYyprA9hKTe7GF1WVWI4YgxJrLzgTmKDnTMJILXvsKL8bUv2wmkmKFs47+Xw9ElikcX84QKy8JVNTMfE9/dZ1OIwrL9xbVHX738Vm39qie3XUVn3Er2vZu4B2MSZMcuxrD9rPf17ppIm8Uq35cicb1W+t4//lpfD/I94DgHL7g3gpI2X4RkbzV/q1oXBWe20saHLVtHlpMppwTNqae88wxK00etToG3u6hjJeV3wQtTkShZ/gCnSUdaPS8urrTP8yA2j/asENkWMz/ObWgHl7ykag1KuIAX0jvNAEKVO9gsgzcazlWpHM5vVyus8V1y3s1zQz+iVkX88YxAyS6Tw54nNKzjunvGmsmBUeqzvayIG0EjrhhIoa+yjGQ1xu8BFIxxT03xT5RcFJ+1F3GJfvprYK7c6xTypl2bTyK5kzItktHlBTqIQgH+3ayvYW71c1jAEQVyg/4zq5IBKFaJ57o8PNXjFU1UPuKhGqmSAWLZ884yhIyEtHrsG2ylT32CErjxMGb6BIBJwivM1QvdklnXNqo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7kKMpar8b0/eothmjgtYEr2CJpJRbjPouSEuJj8tuL8MCZOSLec3tE9jogZ4?=
 =?us-ascii?Q?3TqBigz4G9IWnQ2kmtNl1PGjcrtMD06tB2JK9+JguPMRWrvtAqDFaBQ8jn1h?=
 =?us-ascii?Q?xNvmg7g/10bA+ADJAbSmRB8PjCVK3gB9Ns14iNzLsZTfZ8+IT0F0ckdKIXBb?=
 =?us-ascii?Q?bi+iZNUD8BQOhbTDvg7uJIIwMRw5ylMzf/GNI4tLVrxQpzAKmnpy2u6Q+Ih9?=
 =?us-ascii?Q?S+K8yxx2kXddccYnrNeHOlz3Jw65Vz/o9JFeVHXrcLKvMpUCOELw3uevbRzS?=
 =?us-ascii?Q?2adKmYLAbUjjfZyft3e18TmQCkLkB85da8iN+aEhS2aRvKva/hjagA51E/Oj?=
 =?us-ascii?Q?3M9/GPhWfX8stIVvVdfI8SYGPO8KEdyZfdbGHsmlGvlzKE5YdXjcH/ql7rNd?=
 =?us-ascii?Q?hZGKnF4tcH7//e5yvv6IzULyo7lxaiAKYqJoVpnBOnoFi0ukvTlNmR+CGui7?=
 =?us-ascii?Q?qQx4QmZX/jPMAzNXcWlNXiO0RsXtR68NUYFneGRdZvmTEJ/hoZ0Whotpft0t?=
 =?us-ascii?Q?iWV68E9fj1m/WigJeRKhBIARFbohWiqUyWMVuHavZ4SUrKFjkR6fsd44YNRC?=
 =?us-ascii?Q?cMyOxnx89HYdz30ac7vY3PnyvVuum0mhvqhPrMfTNqydAYWFmTIyetnUBNhu?=
 =?us-ascii?Q?YKoQUqiH6QTaCyACEeozmXtm1ag9hwLf51gSWuiL2UbBT6VXASTxismIZ4xZ?=
 =?us-ascii?Q?1zmkj+XOZ0dj4BUJElx8PV7k0687UfPcsEHwstUn2sxnet9kULpaupn+tkLj?=
 =?us-ascii?Q?9QrAA6TUH8XrqJ+Lwjg8Y8nd9hZo1WMsDb88LoQcHQeI8eX4TjA02C1h531s?=
 =?us-ascii?Q?WJSmYvbiFXR9Yy/nlmKhH9fk9UTrL0XIxOSjTgqft14SgstF80Gxk4/iJ6W6?=
 =?us-ascii?Q?rrBLrTXdciqzXgZvVdPs77cwDllBpf7mX5bg+TVUd2Mw66x32Cel1QcIipuG?=
 =?us-ascii?Q?drR5lBrqQ8vdZ1RqEG1jhZ/lr5zaGu6JkMgS2vX5wNZRels28CktZLh7dtYg?=
 =?us-ascii?Q?W67cD6Is9zYfLBVOnG0fe/zWRX9hrwtjxlJmLn6UiDARk00JBIEN6I7UGuQd?=
 =?us-ascii?Q?t5DClHPHiXKaC9Uhkl5R+5+gqNG/F5lMYLBuZdoBGiOj4UrtJPv6PWocVeLZ?=
 =?us-ascii?Q?3SmDN6+xBx1Eo802wQ4Upoi2MGcpgOx8R1ot4bTRKu0bE7eLh97CWv4NjpPr?=
 =?us-ascii?Q?vBYMhQrAgUuq7WcrL8HIGnyNnQitDShzooIpsOMZ2dNVx76gHKlAjBNGRePp?=
 =?us-ascii?Q?Rr1wY5cuug00cnHiEnTiEHlU3tt+mHRcKJq6KTPu1Y6FP2vkKUFi2qhtiPBE?=
 =?us-ascii?Q?/pml5OUl569sy4NPFjhzoFBjIQo3foWH+1yV1UMBv0qzx3RWX7SBqrLeVIFF?=
 =?us-ascii?Q?oPgMSm6IGAx36Ag2cKvhbcRICsJV9uYRBKL0yh40G7p+pM7DMNkUUNacCl4A?=
 =?us-ascii?Q?+irTo0tYTJtMY2HnB2Bodx+oOua8HZs7gyVvJ0G+zDBFt0OemMm+6xT3IcBh?=
 =?us-ascii?Q?ohEMd7wV2scXAD1KW2JGQmqGKEWr6ZA9Ay+WYbiplR6f8O1v+zaZ2q/BsWBz?=
 =?us-ascii?Q?ab8/szlfQoNELK4s5SleNvt+O0AcZsjwQUzBKAZq+xjUlA4WNSJSGdfvnyeb?=
 =?us-ascii?Q?p0se9zppvBhuuHpKjiwqYwnZS3vOisjwV30VaieiSKVS8RTr8H0ohXiR/Iku?=
 =?us-ascii?Q?FlFwSYUuajYjjRU44eYlfLPfhijdhAG/FMVnefYjtGibzq7ijlpJOndgTclO?=
 =?us-ascii?Q?sR2yN0M0hRYsrv7CK3ntLkf2sn7D3meFB9kcoS/pveZ7J9qwSDfcfYtYyCMB?=
X-MS-Exchange-AntiSpam-MessageData-1: Ugg6SH71NhPsieNPYot9cmj0JBbE+gqeKVM=
X-Exchange-RoutingPolicyChecked:
	DifU3daNO55bC++gDI5cqw5c40rlLC8OcZXMv7a9dXDqc/mVkaDAw7FXb8zpG8//q7o+u1Ne5oN7fZXtzXkcAeh1pKKz1ZuWiguvs0Iwek2cus4lfrBP6KEntlFrq4mR0N7obmH9q5CQcgI/DGVfrS9RMK34+7tKpTSLNBadTWSa25JYyeXIJZcx86Pfsox/xHRlQe9YjeYgmrlppRXY8hgI2tJ/5ct1jbbLTrY+zJlcEcSKCe6bGs3oiD30xXaiL3UVmCstBGc4ARoF1oTfs9vjabXnGIsOqJC3TIF5zgb+QIJPFxEKX47ZTwYxZ04NvQW6wXn2mMO+LaZap/SL3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pb6lr9kZOX8xi7qavcJB28WND40M3YL9SGyravJAgDLB28fQAqr4mPvD+BnbjSM1Kjm5qa42nKurXHmqq9wogHuTZU28XPx9UbgIHndGktzyp1HpWuAq480QGC0tNpsWw/7TFwe7GVmlMy36a2ZvLD8Y19gNDQiKihs/hjrZjGDu/fDKMhcsRDOvKsyrd9HMFCwmQYQo0K5fFXS1HhZ9Pw0yCZfs+ekoZ+7gAzmW9pVtfbhPrMOsovffL/cKlws592zBduGwKewZR/OGS3oN94ShU4wMKtBwgN7bdy01u/No6WUT2bJQIsJzvGpdz5DxnHzy1JMB9UTokdyy/Tgut3KvY3hu3Ct1I0TiQ4viow0YIsLQEqypaUbE4XwZeV3F9KTlbNuEU1TZR/fjn37d2GWxAG/jHgy1Mx1H8PxNhX08yXzoPr1IopCZlsE1og5ZLVunF5zJdZbOuF0nI4PAjEpxcpsO29u/q7VLk4MaWVONr3chxcBJ8mjWgWVjjW900/Wz73bOaE4gS66KIJ4b6wK+2CKtRyh89iU8Qpzp9HFnAQEEpKXk1b3svC10m7KplLh/IUcDLBoAY/2O5iPZFQp8uSdRFDokKQtnlGCNn28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed25d4fc-d2e6-441e-dd0b-08df1fcbb532
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:53:09.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/SqGS+ZFsLUv3df4nI7U5t4fz6asQDaill/UhLxc3kvpIq7ab+nY6Ukz7PVb0jKOvflrZOJwP4FU4lK0L4BPIHR8j7ejGVhThoXB35elqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6556
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-GUID: pN9fVQj6xaCKBdHxpirzrilqlztAeNv9
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abe73d9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=Y-dKFtfkpH2uyWHDAdsA:9
 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXz2uXy6oJ2zWU
 y6TX+FHkZ/CGtTTSJGo6tgnb6uyuNsCViJ8Izenndv/1FQsi7/tHT+agOr8ioH1up1+0GSfA9U1
 jttWBcshs8mm2FszjuK5uEtVv5xGKJqHCB/zdlhjjsxUz4kZjSaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX93MYcAKklVsx
 1vFLU/rgTPICrKv9uMwhO2epzyL+GWJNXI5jE/kTZ9S6rveXgKqv3ZIfulwt6ozSzGkwK68Tgoz
 TgUR1lpiFpGobPPqM5CIbDVpMq/df+NNwoPxKhgdoU8/sH/+BF4jv5S5SB9XOV6RuGF1SiGuU1/
 rp3VmiSYWfi4Uc6wVqeiJBbINDIb0QjI/VFWldYJNellkbDEwHFMacKfBIo3XlI3V2p1BHieqiK
 B4tp3uQO8BI1RcKwmfmtBEPJ6lWWem04W7U9Ozvcbibu+vyN0TwsJ7H3VL+wm1Sz23jovVKoKp9
 byiUQSgRupPbmRIzuiCm+nc/JvOhv/JN1+sMUY5ObWS71fr0IJInKTscdnCIzgQHk9ka2RfzxP8
 6f0Fswof1bTYNmabaqF06OMGgZtS9kPcGe+kHa/SlLdnxjbF7wJ4hNge3teJCaKc+wlUzEdqZc5
 SVnHuSP1SdCsCoeRe+Q==
X-Proofpoint-ORIG-GUID: pN9fVQj6xaCKBdHxpirzrilqlztAeNv9

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit 52f31ed228212ba572c44e15e818a3a5c74122c0 ]

Resulting in a UAF if the shrinker races with some other dquot
freeing mechanism that sets XFS_DQFLAG_FREEING before the dquot is
removed from the LRU. This can occur if a dquot purge races with
drop_caches.

Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com
Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit d2b4752119ca629b175d599d9a68b90ae010abfb)
Stable-dep-of: d62016b1a2df ("xfs: avoid dquot buffer pin deadlock")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_qm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 907819e7873e..a3d728883a10 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -426,6 +426,14 @@ xfs_qm_dquot_isolate(
 	if (!xfs_dqlock_nowait(dqp))
 		goto out_miss_busy;
 
+	/*
+	 * If something else is freeing this dquot and hasn't yet removed it
+	 * from the LRU, leave it for the freeing task to complete the freeing
+	 * process rather than risk it being free from under us here.
+	 */
+	if (dqp->q_flags & XFS_DQFLAG_FREEING)
+		goto out_miss_unlock;
+
 	/*
 	 * This dquot has acquired a reference in the meantime remove it from
 	 * the freelist and try again.
@@ -445,10 +453,8 @@ xfs_qm_dquot_isolate(
 	 * skip it so there is time for the IO to complete before we try to
 	 * reclaim it again on the next LRU pass.
 	 */
-	if (!xfs_dqflock_nowait(dqp)) {
-		xfs_dqunlock(dqp);
-		goto out_miss_busy;
-	}
+	if (!xfs_dqflock_nowait(dqp))
+		goto out_miss_unlock;
 
 	if (XFS_DQ_IS_DIRTY(dqp)) {
 		struct xfs_buf	*bp = NULL;
@@ -482,6 +488,8 @@ xfs_qm_dquot_isolate(
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaims);
 	return LRU_REMOVED;
 
+out_miss_unlock:
+	xfs_dqunlock(dqp);
 out_miss_busy:
 	trace_xfs_dqreclaim_busy(dqp);
 	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
-- 
2.53.0

