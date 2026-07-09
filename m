Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDB3CD8DE;
	Thu,  9 Jul 2026 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579168; cv=fail; b=UWzH4B58PW3zEExnbg79P+NIM0ewdsBC4dCius0QAuk+nJ2JXY6Mtj9KLThkj6EgcFm1ZbvVri10ui58S2eQK7OnnyC0fdR3ImtCip/83YP+BeQLUyHTZMFNusMGuRNRUDSm6F6P2K+yd4ZDGX8R8EU8JiNSc5KPmrT8sOmTgJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579168; c=relaxed/simple;
	bh=qk+8zu9vyLIS1Tsw99VVz4HCxBCZWtpD8P0N1OZ/nis=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uOYp4Nt/DeCepN+b3M3fAgCwo5PRNvXeIivvRNjyU/Mhf0MKYhL/exr1hDZEEe/NzDj4FGqhWhluzEwBBYzgQa1ypC1XlXZ6MxWjbZjtvp1XvZx/9Gmv6TxPeBQlff7AoEMnUpJPHRlAq0PjXZe+HBm/YiBHZAn8aUzKBz4x/Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nI3ddhpN; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nI3ddhpN"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960uY31727364;
	Wed, 8 Jul 2026 23:38:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=WCmWeQiPv
	2dgBUkx6liEsfIuok+HgtO1Z1WSZ9xigSM=; b=nI3ddhpNG1rwaWYi3h6P7QXZf
	IPQ8lUdcfEaGG33yxhsLDCE1NqGSQTr0mixX2rYFiMcJAEG2oC9/PBiNxwc3LUTx
	AdbRSoARXcwDevzcVKswRmOWdO+Hc3nD9ozLEzNkQqbWUSYR32MhszGCm4sdFf1y
	aRzp/0h7lrDpOKCcYscT6yDzOHNj+WG5N9fAU0C9JckBWy0AJsthzRanl30Cjs5C
	0Y37JUTVtbghz7eLVt+hcXZnas5T9UrWOMR894vG+VZA9eXJeVzIAh+nit8LaiUK
	lzf4glGWVNeRGUgdeM2gxyl79FmPanVFsxg3MNq29C8o+y7pbOWd31QCvm/+g==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1gy8cjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 23:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+QDB1iVPi+dVXv5DZfJkfnTI6Cyn6Ucv9+Qk6J1SeFlZE/Cjl8mdtx+LXpz/Xs0W5QMeIUA2PH/FcA8CeKUZxep+65czgur9MxvTwSyIgyFHdaOe65g4MNdvnikvPXfWrPdWSwqRdT2FArbZC6+3n1UC7KQLNMK6hAUlKafJ6fGsM1wFI2+M3JJj8RjTOZw5MkIVaIc1LlMrEryeuqjOfCpx3f4ixqHGjhoAV5vZCYZVffnGLzWuYdo+rMOUEaJy9NdDMaHBpoMRyDpq2fP64VMc1fcj0J0Q+VNGgw2rzS1LGfcYlG6pGeowJ04bu/CGcOiw82RtKa+Swb4/CXLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCmWeQiPv2dgBUkx6liEsfIuok+HgtO1Z1WSZ9xigSM=;
 b=g+Zx0MbjpoKSDoxnfS+W6VQcUg4TykAdbC1Cz32kGnFyjF3sFRIkLwwfkf9O9dSX0vJ3Fsb9NXNHFEIzOW4lh0FN+nt6tEIwy7rIv/SOmW0K6MCgLZPaxb09+nQqQ+hlk9Q1vtsrIzX+hzuJ9PBDhreLbZI/j7tJHiDP0b9ZQzp78JnrMcCthyYotXxHxhbJT04HY0sIu++RaiCNz5mMqjKSxktKfjCaVoWdt5+6juaKScg/Hx9f2q7jzUs/LaAEMb6mYmLDLiGzRYGTpolZbanky+3j0JlbLqNZeRtUiEO9/81XdFQa9jlxTaXdO5oDPFd/e1ve3J74oYiYnVbs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6401.namprd11.prod.outlook.com (2603:10b6:510:1fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 06:38:21 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 06:38:20 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, bvanassche@acm.org, clrkwllms@kernel.org,
        rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
        mkhalfella@purestorage.com, chris.friesen@windriver.com,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v8 0/1] block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention on RT
Date: Thu,  9 Jul 2026 09:38:02 +0300
Message-ID: <20260709063803.23538-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:50::18) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d6849c-1637-4534-71df-08dedd84aaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|1800799024|376014|10070799003|7416014|366016|18002099003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	LKIogkfbTE+k7i3H0TSnX+e/5fU3a3vSl8aEuQMpkGhwv6ftCZYPcACt2ccry8H3DWlTobGynJNYfO8jB7E3dUjUAjN0KaUcOgoUlJpRgoL1H5ihwK/xKsvfrf37B/W+sT653ZzTO2kAQNehPh/i1Eqm5yojdPGze3XVY757X/ygivN4MbRfpOOg/CFQ1oPt4euonpOBIdrzxyDK9Krf7g8yUClmd1Q9QomOeyPwLsH/+rcb810ResMYKanAp54OymhMEkttXoW0/NGs9bNX/YbzFPMZW4vhdLZOpfjgfTtvrU6TNKmbQBcAS1223Ka/C9ZoFyDLfAoZnx1+TUrNBd0cVB5clSgvS0WAXD5k/qSiKlg+YIIVLjhy70ofL05oHa7Buu/RKtavm2qgW34R+Fp4VoGuNyxomjzYadvCFIgBFVFaw8wfkWG+nxHFyckz5wNtngJFevuStwbFgBtr9bNK9ie0gJ+3huf5MOL4SeYWgGtAG5jd0jzisZSHREtfnlU1f8n2wRga4yLc6JVJpfZbtIOHvzSJpMDVADXo4watItaeiruFP52gGAZ5xcjtWjBZhZ1T4iq7HN8WLfqDw5X91LZLWP8hHhSix+GqRm81N7jmwCEieq6dK/w8oShrK32VtMb5MGjXi9MQpli5A8HifF1h3IJA7L2rM6HkMjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(10070799003)(7416014)(366016)(18002099003)(5023799004)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tI+Mq9C909CsCJvizz1IErmZI0cUkFewkbFNPhoCNm3vtI6/LN8Hec8fDOZX?=
 =?us-ascii?Q?Fw0iAyuM4bHVutEbIPC+qEyDwFYPg/r+9tm4tF97WpOqvPBp5QsKTi0mvGpS?=
 =?us-ascii?Q?BJe6Q2s1cpHbHf79pw48GCANyfW9Emn2cBQF1Q6mHJquUcYsAWWmtWRNmR07?=
 =?us-ascii?Q?2nZyZakb4FNntlb/dTRDryQaE90JyJbejV9J9mPS9mI5HRWAe7xwaMnEUrru?=
 =?us-ascii?Q?OCZX2fmANZXJW/5OmOQ4yjhf0HC8Z6+15MoVZKK1b5o/uUExBqrP2iWEL/5D?=
 =?us-ascii?Q?NpyUImX+XTq8D3Gobb+CUZfNjULNRydv/oleWpt2iF75EiOowC5YRXmGDWG+?=
 =?us-ascii?Q?HXz+4Tat32nvr+TOp1eBCzpbtzfAHbn+EWeqltqF3hj49tjzjpHv1KosSwh3?=
 =?us-ascii?Q?Jvwck4wrAxhqCkRZHvkfBGKGks1aW4fWXWF5uK9JTe68DITw53HoRUB5+kLa?=
 =?us-ascii?Q?nJTcsTZ7qmrs/EAymN7Xof1XRXbdj7VpC4jVMHSYSHxrdnP4grjGkUj4WpXj?=
 =?us-ascii?Q?GxkNeXOQrUbyMfx8jdOZhB+s1YTMLdHvtSW7yycYonFvr7e7DIVkVFu8rPcD?=
 =?us-ascii?Q?wMXltmOvPG1tKmp27SsPhxjO4bXb6neaWDcf8IS7B+GxXWx/kmDmTFyiWQMl?=
 =?us-ascii?Q?BzAwzpOcJ9zY03TyWhpVNdJ+EhYCC0gm7ywZ1oJGUZ+kbsyPIqrUVBSfcNTq?=
 =?us-ascii?Q?B1dN+3lrvgEWol0LyWhqbszncuV0xbV33jalCfXvWHhQrwMb/JV8//fADbMv?=
 =?us-ascii?Q?D5rLhQ8YhL2UQgSc/I92skwsP2Ik37CTqhAl4xp3QMJ8RpmoFOhWlk7yu9OC?=
 =?us-ascii?Q?2a8vAPSMVdgCsL+ks5Gb/SV/glemH9XUNm1/IMXINGetq1UwSRFmnsZyywr5?=
 =?us-ascii?Q?JenKlbQJcFtZVIxQIcG+Bn75Jiy+mys6nMomorPbUmXr35MxJMXdxvLLtft3?=
 =?us-ascii?Q?Bavmhk0C9uSf8K5zYBRTTzaGAT1GGSkf7PAAFT9ONE+HIic1ciIt1zgQqzsP?=
 =?us-ascii?Q?U2o2KN9UXeJ/Kl8yCK3LpN30RtsdWBH+kjgGQ60yNSaNSh6ytFUPk3WmQLaG?=
 =?us-ascii?Q?3ITnRaI1YCe8p7BsNMPhqcYPwFfXnV2eVS4591AKyJqK7//mERF/tI5lDFWi?=
 =?us-ascii?Q?FBoD3Mqikko2Kh5v64gp1byV/1hjPpToiuxNYbvQmGpxsWuTagGBI9nkYYOV?=
 =?us-ascii?Q?nAGDjo+2U1c1yid3/A9AsC2wTYbZ3/yo9zjDMwqZzxXSImNcbSAEMahe2E15?=
 =?us-ascii?Q?+TraF6ssttcZ4akAsTQ2h4dFlr5IareG9qvcRupUSnxTa6Ldj9lGkPnpPOyw?=
 =?us-ascii?Q?GBaU4a7Is2vUhjGXxTjRn2cDSmct8E0Maid3Ewcj6WTljP4hhcbm7pUf/JvA?=
 =?us-ascii?Q?DYJO7IyfBeOrEBmBfy8swq3aEqH860JBKCn5GxaTnJv3uuZ9ee6Sy9wSrIal?=
 =?us-ascii?Q?Ag4Ok4gdgdk+POAUVFSHd+vlOruT/SWsQ0+HbxMyywj67LED8VErt7Hec5yH?=
 =?us-ascii?Q?XEMxrMay2LaeWLl6RRmyE7s1waGKOqvEiuBJCKlVUiWyW1XuS44nmLb7LIXK?=
 =?us-ascii?Q?Kq6JsZi3ng8An2bQZj98igndblB6TWt7DBFTGv9RwQv7M5SQ0C24xtCeWGzc?=
 =?us-ascii?Q?7+5lInxqs73YC8nTMiirHId7sM51AY1uFyy8KpiKXff5SC5CBYXV1e8J7Kl8?=
 =?us-ascii?Q?sThpJYiPj76ne59VKLIzGdqwQ3gsVIipQx76yI8wImnRL5hBEahP8rIjrK+E?=
 =?us-ascii?Q?XXSUgM80Dh/Zue+Vh+RDQwk9GXFnfGASOFHb9ZCofkDuaVV6qUHpf+18zXtQ?=
X-MS-Exchange-AntiSpam-MessageData-1: forBVa46BBF3KXZCfUGMnBTFf0nZGmRslMI=
X-Exchange-RoutingPolicyChecked:
	gHvphhFBj9MR+qWp98OCt2z8hZAcG5H3vsusfR+Un2kNUPH1Bl78ExS1yl2fyyDAM+UUQ97qA1MOEw4S47IPznCcqeOMqx1alXWq1yOzCFVPHyK8q+ijKFczioSyZmfBWWXGi8DVmvd3ZcYnVOhffZGRwLY2XhGdm4KXHCLlmw1ZFKRZNZwczKmEpQ4mFm/lViqCe3dEmnuyqtqnxkZzRoPrzlXVseJ52KrMY+T56sceLJnDbtTihrRwOP7Gdz/hTpFsHk8k2k4/n5DRlC6KIQeQOQM6eMKFQjh2g1G2bqaGmWwhU2y7fVQmL8uLCQ23lJkAS2CD1m0QQyPrHMDpyw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d6849c-1637-4534-71df-08dedd84aaaa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:38:20.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rzF8Vt5pcSZy3PqalRehbPSWkdIcwLU8GZ3omtBhRoRRGvH52NZCXh8miHaW4jydbiUzCN7/4dh3bL4ctV9ah/3IrsDjgPGYaKRJ9Q59T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6401
X-Proofpoint-ORIG-GUID: Bb9D6O6gjnA7VffF9r7bFcxLg37nx2WY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfXw69yKgPUe4NP
 j2Wj3N4coVzYKCgoFsr7Pk8u1DCFbaxBVHcLF44NZxILEO5auUH19PZf+xPsUBc5I9aAjhFlQHH
 G8eaTgrHFfB3CdSsi7UHz4/eWYGvyDdGWIIqxbBxfuzO2jkfMDl2
X-Proofpoint-GUID: Bb9D6O6gjnA7VffF9r7bFcxLg37nx2WY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2MCBTYWx0ZWRfXykPytBtal3IV
 TLgvgMR/ezUjc8LBYx2MA/3nfrQ2WcVSto0FKFsabkrrgK27rdhWXuvq9wCjW8SeaM7+O7ytDcH
 pt97PsAHTcahewI0B79A3AJ9n3bg0OHfB0GIE7h37pcZ0fN9qIXP37VCBd/dZ2peCez3gkFlrs5
 EtbH4AXVR5jhxS8ikHUSatZfVuLypKHmgxin9p8d4QqIH1QOGaTi1huRAsyVWp9bVUGm4eU0/y7
 LOLjSqnXSJS/WEkR0cptwy7JI0lh5bjpNwTrr4nKyThPsFaanO0r4FqXfsWR2Rx0YperIdIHn1q
 X3ddyYvfTW3CyCXrWZT1+OZFFaZcj4B3w5K0BWMozTf9QHyehfpQLz+FYYt8AkDTh2kz+31tXRH
 5IgmzWgoLrIKQGgoVWKRYGObzqqYwEqRCqNj0d0K1Rjtzm5JWYpfQZV47ZihnwS1CVGCr9BvNQs
 gTkHCKJwgOH26shrDTw==
X-Authority-Analysis: v=2.4 cv=P7IKQCAu c=1 sm=1 tr=0 ts=6a4f41e1 cx=c_pps
 a=NooIwpZNnZK4GOBrdp331w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=N54-gffFAAAA:8 a=dHdCeM95kWKZMF7KfRQA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090060

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Jens,

This is v8 of the fix for the PREEMPT_RT performance regression caused by
commit 6bda857bcbb86 ("block: fix ordering between checking
QUEUE_FLAG_QUIESCED request adding").

Changes since v7 (May 12):
- No code or commit-message-body changes; this is a tags-only respin.
  Rebased on linux-next (next-20260708); the patch applies cleanly with
  no context changes.
- Picked up Reviewed-by: Bart Van Assche <bvanassche@acm.org> on 1/1.
- Added an "Assisted-by:" trailer per the new AI contribution guidance in
  Documentation/process/coding-assistants.rst, to record that Claude
  assisted with this patch and that checkpatch was the analysis tool run.
  As that document requires, the Signed-off-by / DCO certification is
  and remains mine as the human submitter; no Signed-off-by was added by
  the AI.

Changes since v6 (May 6):
- Reader-side barrier in blk_mq_run_hw_queue() changed from smp_rmb() to
  smp_mb().  The race closed by commit 6bda857bcbb86 is a store-buffer
  pattern: one CPU inserts a request and then reads the quiesce state,
  another CPU unquiesces and then reads "has pending work".  A full
  barrier is needed on *both* sides, not just a read barrier on the
  reader, so smp_mb() now pairs with the existing writer-side
  smp_mb__after_atomic().  Thanks to Bart Van Assche for pointing out
  that smp_rmb() was insufficient.
- Rewrote the in-code comments and the commit message to spell out which
  ordering the removed q->queue_lock acquisitions provided and how it is
  preserved.

The problem: on PREEMPT_RT, the spinlock_t q->queue_lock that commit
6bda857bcbb86 added to blk_mq_run_hw_queue() converts to a sleeping
rt_mutex.  blk_mq_run_hw_queue() runs from every MSI-X IRQ thread and
hits that lock on the common "nothing pending" path, so all IRQ threads
serialise and go to D-state.  On a Broadcom/LSI MegaRAID 12GSAS/PCIe
Secure SAS39xx (megaraid_sas, 128 MSI-X vectors, 120 hw queues),
throughput drops from 640 MB/s to 153 MB/s.

The fix takes the memory-barrier alternative and folds the quiesce
indicator into quiesce_depth itself: quiesce_depth becomes atomic_t,
QUEUE_FLAG_QUIESCED goes away, and no lock is left on the dispatch hot
path.

v7: https://lore.kernel.org/linux-block/20260512062815.10815-1-ionut.nechita@windriver.com/

Ionut Nechita (1):
  block/blk-mq: use atomic_t for quiesce_depth to avoid lock contention
    on RT

 block/blk-core.c       |  1 +
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         | 69 ++++++++++++++++++++++++++----------------
 include/linux/blkdev.h |  9 ++++--
 4 files changed, 50 insertions(+), 30 deletions(-)


base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
--
2.54.0

