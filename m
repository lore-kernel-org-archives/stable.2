Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CF4F85B8;
	Thu,  1 Oct 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866374; cv=fail; b=r3ZkgdON2/YwNQ55v+SxwkUTqlUxJFrIIS4e1tlO6fC1r+XzWw8J7+TfY/isB4/QZP0z6HLJ/476sDUZjV/OudPLTgb8Y1RVlIQVUscBUrn8ZBf8QqOl8Er3ur/a2A3Ot4DXabbJx/4iRfnJ93AiX08PkhHP6HwNxzNUjTpyiz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866374; c=relaxed/simple;
	bh=Nnoa0vu70ss3DbiAl71w0JKE9WVMReNq7LowQYH0pbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ot/mAlquaXpljY01YHDa33UZiy+z8Yqjl+/PncV/CPAcoKf9BuPv3uP6bR863wqgHgz5Yl/eM+c6MNOojSCxFiG7tjTemUBVLfYiPb5w2KFZKlrKAbFtmdKW3cMIjNqfmBW3/0ayJjxPPy3RPZj5pBR/0JzyGWBw93gAdoXznQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aWUpESn9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApqIQC7r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aWUpESn9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApqIQC7r"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DMW7u624303;
	Thu, 1 Oct 2026 14:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xnXFJlowAbH33sUZegxon7NLwItV9gCjeigtC38feQc=; b=
	aWUpESn9hOtmUalHIhANZgHH4pitQEYzNLl2LV2uh03QusJz4hPRx1HLB0DXYxKT
	k5l6DHaKmMNfSpBZl0sP+qgAoBVi+Jl7kASBZWKEl5DvTl2lFE86NPCKTDyJb+Yc
	Ewz1wJENm3WLz4uSdGwDHNH6Nsk9pkDYNwF2KKgZgaTnVGFIUckMaEQc5aOuhESO
	RY3cfDsVZ4znHkRyH84HHzq44AbTDMWH0gi/yXOENo9NnKb6mLyi/p6FDx8Q5sXq
	PCswWDYBU73ThW8R0Fn+8eFYWlgZH0kHNfH6y5aclh+msxKzm8slQRjlJWvfqzh2
	WjaYek44ZXrqSXrMDbJI3A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns106x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:52:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EnpY5017265;
	Thu, 1 Oct 2026 14:52:44 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gey0qe-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:52:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKaPnAH8jNM5wUNahbGpWweE8BsV+UeJyqVS0ZYvezVEbKCfgneTwF1UTTReBbnCfR6wi7TJEajaaA/WWjOceAxE76y5MUHiuquM2z7d6fH/0HjEYbemx5Daz9QKdUlI0/3a3Gt2tqwo2IGKiE6dau23C9RZtnu3ocOGWlES/sU2nrWND/h3oPibxPrrdoFbt06bhEnPSM9HIV2H8DVr6OZoV6nD3L2XwO77ZkzUxaBDYsUklNwVulWjJkUbpyQxFpPyUTi+7qHr24lFtVFgoaypa3GyQ/olU7VDL08Cq51E7P28uz4rj+jNMjqt8SOguLOavwDgr86k67qFTXW07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnXFJlowAbH33sUZegxon7NLwItV9gCjeigtC38feQc=;
 b=YnktWHMSQErVi2McpvmB4JBDSVciBLFO1PbHhavVydDJ5PzUX79oG2AHa5Arlzk2MR26yhOsSOUeep8CdMkO0/xvKlgoilyZJgaTVXr0aKQnI47VUlujRDqiF1LOnWW9yJQP+e7Vq7ePdq6THh/yUbj+Fs7OgSTH5tA3COJY5XUYg8S5ztzRYq7kGVo/0CGA28keFXT+cDQP/3Eu9dQHcyCzO0ZlkYdCFU/0yxrbHKI7gmX3TBBgHfi8v/xSUMbIA0QpRaPylQ+Ioc9uctDKtkIQkq1IE2crgcrFHh3MtkZbHsCCzAiLpUQhMcOuk+VVh9XkYpXmroi7aitroHKqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnXFJlowAbH33sUZegxon7NLwItV9gCjeigtC38feQc=;
 b=ApqIQC7rNu6zRD9WiN6iCmZZtvjeNNGhW5xuV/SRQC34Mqto2dvrqaMWCJlAF3sc5GbbaGi3AbEK5Q9QxrjQtbiaUcOX46hyyndX8RgfZWIydfNxbQlscBq33tTt6RciWlQOpynhZaojzCCRiS2t6MFyh5pBwT7TrakKO6h2fYc=
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
Subject: [PATCH 5.10 05/21] xfs: hoist recovered refcount intent checks out of xfs_cui_item_recover
Date: Thu,  1 Oct 2026 20:21:18 +0530
Message-ID: <9f3bfebcf9420de791c977cadb5a3a49e9bcfee7.1790866131.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790866131.git.siddh.raman.pant@oracle.com>
References: <cover.1790866131.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::16) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e98e69d-fc24-4dee-8c28-08df1fcb9100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N6A+u6DkO61OAEM1A4WVk7sAUn0G6PoSOvmf7EdRU/cfw3v5BPAViUeA31YHeOboqxOasGDQ5CP81xp6wbLbNVAM7s5omd7oKFixC67fK2wXtU+d+XwHRxx7I+I5HiELuw2+aIdessczOe/W+SGrleuDEWE6F6qzgb6WlZkoUefe1vXPVIT/T/pKJlIeOl3KDPlP/hfxbCBAi52PCXKyb4BNA/p7Vwzc/hEQU0jII7GRhZuljkY5aPovAWl435mOI3oHsmcTmZiocImKKNixY8KdT29lHjfTrThjoCKV5iaAQ52xbWltci37eaCmPVz4YUV93A0IaKzCSJgYK0XX5KGO7UmgM3GY2o8+UeaHScj6ReUC4cPY3rX2Cd5mYi7+1zVoBXMtJWqG6b/0jhz4Wmzy+TaNPqFl5RVpPZHSNrLXGWanlXMLHB1dqNNBJA7PpTg2Z+UKHNbzp3T8i2UFBhUYpJLlTTKEsL1a4yyAAJsdEbKdS8Iy8bwNI0sJ4Tw6rWiyK+SL2Vy3VAdqu9wpRYzDxXwAw+Kq7l6AEf6mZVvg64Ibw30j9nfw0f44cWURLZTTINkHjbc7WE5TdqLCUtYk3t/VAfAN36BMhzVme5P3Bv+58mvbTs/ifjpGMtEp1zq0JmkHljbHuCBKWZUto6rslKDOGlOaHV2SA2QCyJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4f57RvSc5NiIAMRAJKT5YyYvJBFYWXzTRRM/0wXwf9qZV2NRLqjf79NW2tS?=
 =?us-ascii?Q?tOYWmWY4qEwYFjfeWHRJEiK3IjMlMvRxyhabQh32x+jB9VjyvCkHsshXDD5b?=
 =?us-ascii?Q?FAu3C6tYuUAy8ojU2nLKvuANoJI0M9e7xeMthyPL2enNDdH89b+6W+jKXBQH?=
 =?us-ascii?Q?KFP/csW/i2NJ8lTFyjO0CCI+IQi59SFnWPFhomdJiXU0RAjM5WbTXJO+KvlH?=
 =?us-ascii?Q?Oc4vnrgeTu07Tqt/eDgD+Svu/B1BW8hIRjBVuvbna3x4K0EFARQRlgRuLwP7?=
 =?us-ascii?Q?xu+8ypNJeoYYEUYFrJTXoSoEQbJp84t9Id7blsuZoQZOp2PPTtHert+ujX25?=
 =?us-ascii?Q?70PNFgsc4fqfFYnCaaAaRL/KeKx+Y1AJQEhbMb4b33hzUUjHbkjmkVVnbz24?=
 =?us-ascii?Q?V6IJvOiKpPlJ1xzvaQ+/NdncZY7Z5BuzrYLrGj87w3ip0pK+aZXFvWbFJCox?=
 =?us-ascii?Q?46TDtXtQ+J4HCyRNCrAQE0Jt2hVgCN5/KMYpwiPjiyfVlo69s1heqvCxpIjW?=
 =?us-ascii?Q?6430GybNQPIo3LVmGMYOEF/F5SrBZRHRBnV0KzW7Nzk0WzwsDlrgqyTlWiAG?=
 =?us-ascii?Q?UcS2GZDiMaYcRJjqej7Zs8tsLLnyINZcBAI4QfVdktDYnuesMZEilVk9k+I6?=
 =?us-ascii?Q?WiuHmL8BVh0qDSlftZ7Qw/P6vpShwTcbUmywFQ7djTILj5pSHDmF3qe/3HYo?=
 =?us-ascii?Q?j/BlrMEnbYginPqUxGev/UaL5HhNWt/nxzGSIz5Ho9Sxz1+DRcP5JTwpmt2m?=
 =?us-ascii?Q?ZGs+I2aqhdEI8dpNL8B7SDqBYQNQogUtYmh4vCbCh989fZDYJjgKcQfrQ9ey?=
 =?us-ascii?Q?zsmla4Se3EjQelwWcw8DVp0OxQ5WQ67TlYmT1qSw/N6CaXp2s8yOR+s30dVy?=
 =?us-ascii?Q?aI7MFUW7cPfM5Eupwx34spdQOKPMkrZJgz8XPy54R2JbOtYGzS2qaUyJGsCB?=
 =?us-ascii?Q?LSlhFEBsv95IWE7hhnhCd5hVTFPkU4b+ei4Slac6iBlt8O5GXZyVH3+VMNdb?=
 =?us-ascii?Q?PJMP4pKARTd6TLoQvUM+54WWswJ0ihyz0ZqJRNbGVMzDP4EgkbEZQL3M3f20?=
 =?us-ascii?Q?thFW0exhCU1Zc1y1ARusn9eSx063Glfdf5NDbUR2nI4mYzfD0Ysg2rlSWJOr?=
 =?us-ascii?Q?bF5Ksi7Xba6M4KJDE/QEHojVz9CJC88gFZRQOsqyrxEQ6l8tr8XYhDQrfHB+?=
 =?us-ascii?Q?80DOVnDYv6PGbjSP8LmAOXrRPX/YMAQRvDODb95Gz/6Aez7ycoOxjOXqswJ0?=
 =?us-ascii?Q?+RQN4TN8CkhJ8em1zprerbGzkPzQtGSCtf/IUNxS6KWojwPFZ0Jqw4N4MLWL?=
 =?us-ascii?Q?aD/RySI4fcNm0P+m/mJ8rIZUoS592k3IrPtkjiHIQHytyDERE4Io3TmY11Tm?=
 =?us-ascii?Q?zmjzCcmkAK8SMmyiWVbEBbS4l9o5xpRbDC2QrddP5bh50N49qa7p73iYH6sO?=
 =?us-ascii?Q?QdltzQS2wCF9EovA9Fd8eXtZBVcTwBsI/GluVStBR2oS3sp86KsGflFvG1sW?=
 =?us-ascii?Q?dlcq8isoAAnt37HzGm13K4Z0Np6dbsdjY4xnTVobTeiU/RVM06ParvDAXhK2?=
 =?us-ascii?Q?yc15rr5XYPu67xvpr4YdynW/9+Nf5h4irWNLfTtkB15IFEfh5TJXf6TSOyMg?=
 =?us-ascii?Q?y2Iwx0B/mHIH+t/0wVKKVRH9GmwYoVrS+iu6hdEk3VeTyK5Iph9lIfOAhi7x?=
 =?us-ascii?Q?gKhkPx14ZPv0q/JrPBVmi1QCi1Kk/8ft3WLaxKNQweoQ1Zj4MJc1oBCyeSd7?=
 =?us-ascii?Q?9OzigI0VjfajTjrltdyKN2EvtahL8oHqK9DBJ1ecgcBMKSBlZg8ZyMFTkMmW?=
X-MS-Exchange-AntiSpam-MessageData-1: PKOlWTR6nM1H28n7vi/trOQDFDZfiTR7ap0=
X-Exchange-RoutingPolicyChecked:
	vRtfS76U/5XpeVQ0/Mv10XNTabjZ/+Wvv5I1km5VCcyYBBcBaonlur/uqT6rZfyAsZlE93Upbycl0IfG5bswhnafWvClvlFzXXyT5zX9TeSLhMLRq/xcok+FLg+0f0as4kz1IWu3Gp+A0s91WnNAwWONBuMLVkHqXukmYS5sK6SAdV3FUZ0GWCf8zlC5dTcQ/nOkCJRgNbeWTqfWMXbEU8RfuRYPbcD4ev3GYxTPu++vy5+gD29dxXcG6SotRenIxCpOWnNAXpTF4doXQasGZ2bB0xD4dJjptFLk9K8yTw9U3ONoYXiEyu8IGfGPtOZNIAzPy52Gl1VUL3JQwVpqsw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X5P9rCP16ILjC/bpAWO895yJz4ETu08szxte0HXZMPGi8MOk5HMIMnpRumwPEeqqTobvt43SE7bl/glVG4jDzaZK2xDqn62EkprykjZ827bHj1yX83dO5JPCexxp65Pt9R92kv0aNlZJ1zffvubMZBJ8SjKeeIBn+Q7LDazu5vJznyMK7CDSM+vplJw5Tf0Z9JvdvYqnI9vPx2bN3M/SsfzkpZPFRf0KOoKjSpLbPaKEXDWAZB+SfFYy0cbi54BxIjyRU01D2MKBm5jRjDqf6CIcOylabnfwzKemWv28zThjRZpI+AHT14NbM/aaJc6wFOP8Vq4XRV3dj7tLgoCT6cBfAou0VfmN3MWlSXExWy3QWxLhMs2LC5tQDKmiJ+zKNxHjxPqtFos1cOZqdHJ4ItNxEr0izDHbbB0KeKYNkAeyfPX3PFYKPMvXFnPJf7n5idodt7BnnniANKgwyp/zaCQALzOF2rrb91fMsuBjnZzTcvbDeyUvgNGs5sS1NG7ADUZoDgEVFryFCq3GPM7QPp55ZJZ8PLCMNls+T8P0nQmIIxGwg2UlMFppke5WzUVu9BRNKnrbs3QcezW1clwemGNb/NFn7f9W9UKqUZ0I7BE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e98e69d-fc24-4dee-8c28-08df1fcb9100
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:52:08.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWAA05vIzuWhWCd+j0KQ3g3t4qYzKhzaf59yq0rZAuXmLyURYxlywPLcWXn42aF0ap3E6HK10z1EA2s2cF7nUPTVxL5QH6i/0o8kqRfvB6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1CtMI8qG5cWL
 4Rz7OJDTt/5jyIjgQhqQnfrYEGE9SVE7c1BK6+Y2AZsGYAQhqj7+tATYic+OEt3suveA9kqoldT
 piObDFKOom5jJg0xXZ6m04a4m1WIOfTVfYd7uKPxXOWDEAQDIMl+GWDtDFyoEY6zKpIIbGfRmav
 NAwpDHbi7V1iuJFrfn/RRAeFLeMgxX7lWObvrwIlohq2AnvN4EN2CfB1JccVzAzk3PmUO2wSSjp
 b1VrSsSnO5vO0sNAEY1o6ThfEFjBiM7Ui1iApndEV/QwLbWCv2HyTAB/+jCfKuMY4j8ttSsM4PX
 /aOxb3QHwml7n8ZUJ+Wu2vcTZL51sxQ+u9s3EY8BemAaOKgAybSQuyVl456P0bDON+vMq/Ml+Uc
 L0NfTD/w22fXSsdYqZJYZOFTktZp1WYCNZe1B7aiixY27dxnhL5Tv6YlFNtYw9FKcuEbLsfnZ+7
 TgCklm4w8BQlkIMzaXQ==
X-Proofpoint-GUID: x1h-B8UAQtmXKtzmvuoCzBGc5BDA1ND8
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abe73bd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=XUHDQfcMxKEf4e_NL1gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX63d5NiAMDtLy
 2pYD+nupbYPNvOnftRifHijdK/i8Sq6zECqatyt3sLMamIBf54BoZiZKZ/6dVhTiWXzw8qT4TnS
 9Dd4vEf2CY34STvXSMphslYvxHGIl5WSFk9v99qYEH1fzi8yCDju
X-Proofpoint-ORIG-GUID: x1h-B8UAQtmXKtzmvuoCzBGc5BDA1ND8

From: "Darrick J. Wong" <darrick.wong@oracle.com>

When we recover a refcount intent from the log, we need to validate its
contents before we try to replay them.  Hoist the checking code into a
separate function in preparation to refactor this code to use validation
helpers.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
(cherry picked from commit ed64f8343aafa62e762c74dfb400f640b6fa6c15)
Stable-dep-of: 7b5f775be14a ("xfs: fix unmount hang with unflushable inodes stuck in the AIL")
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_refcount_item.c | 59 ++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 0dee316283a9..83dddec08f3c 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -417,6 +417,38 @@ const struct xfs_defer_op_type xfs_refcount_update_defer_type = {
 	.cancel_item	= xfs_refcount_update_cancel_item,
 };
 
+/* Is this recovered CUI ok? */
+static inline bool
+xfs_cui_validate_phys(
+	struct xfs_mount		*mp,
+	struct xfs_phys_extent		*refc)
+{
+	xfs_fsblock_t			startblock_fsb;
+	bool				op_ok;
+
+	startblock_fsb = XFS_BB_TO_FSB(mp,
+			   XFS_FSB_TO_DADDR(mp, refc->pe_startblock));
+	switch (refc->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK) {
+	case XFS_REFCOUNT_INCREASE:
+	case XFS_REFCOUNT_DECREASE:
+	case XFS_REFCOUNT_ALLOC_COW:
+	case XFS_REFCOUNT_FREE_COW:
+		op_ok = true;
+		break;
+	default:
+		op_ok = false;
+		break;
+	}
+	if (!op_ok || startblock_fsb == 0 ||
+	    refc->pe_len == 0 ||
+	    startblock_fsb >= mp->m_sb.sb_dblocks ||
+	    refc->pe_len >= mp->m_sb.sb_agblocks ||
+	    (refc->pe_flags & ~XFS_REFCOUNT_EXTENT_FLAGS))
+		return false;
+
+	return true;
+}
+
 /*
  * Process a refcount update intent item that was recovered from the log.
  * We need to update the refcountbt.
@@ -433,11 +465,9 @@ xfs_cui_item_recover(
 	struct xfs_trans		*tp;
 	struct xfs_btree_cur		*rcur = NULL;
 	struct xfs_mount		*mp = lip->li_mountp;
-	xfs_fsblock_t			startblock_fsb;
 	xfs_fsblock_t			new_fsb;
 	xfs_extlen_t			new_len;
 	unsigned int			refc_type;
-	bool				op_ok;
 	bool				requeue_only = false;
 	enum xfs_refcount_intent_type	type;
 	int				i;
@@ -449,26 +479,13 @@ xfs_cui_item_recover(
 	 * just toss the CUI.
 	 */
 	for (i = 0; i < cuip->cui_format.cui_nextents; i++) {
-		refc = &cuip->cui_format.cui_extents[i];
-		startblock_fsb = XFS_BB_TO_FSB(mp,
-				   XFS_FSB_TO_DADDR(mp, refc->pe_startblock));
-		switch (refc->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK) {
-		case XFS_REFCOUNT_INCREASE:
-		case XFS_REFCOUNT_DECREASE:
-		case XFS_REFCOUNT_ALLOC_COW:
-		case XFS_REFCOUNT_FREE_COW:
-			op_ok = true;
-			break;
-		default:
-			op_ok = false;
-			break;
-		}
-		if (!op_ok || startblock_fsb == 0 ||
-		    refc->pe_len == 0 ||
-		    startblock_fsb >= mp->m_sb.sb_dblocks ||
-		    refc->pe_len >= mp->m_sb.sb_agblocks ||
-		    (refc->pe_flags & ~XFS_REFCOUNT_EXTENT_FLAGS))
+		if (!xfs_cui_validate_phys(mp,
+					&cuip->cui_format.cui_extents[i])) {
+			XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
+					&cuip->cui_format,
+					sizeof(cuip->cui_format));
 			return -EFSCORRUPTED;
+		}
 	}
 
 	/*
-- 
2.53.0

