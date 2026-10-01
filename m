Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BC51DE1B;
	Thu,  1 Oct 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866317; cv=fail; b=F5GKNIl1ojc2kTBIploUrHUBcnL2RRdlXm9g8eXILOAsVRkPlbdg5zBfDIo+M6pNjvOnFtiYs+AxmvZC6Uj1IC2w1RwAsiZViztkyHPFMQCnaJKh8pH0HSs9AHxd2cHqqwqjEoe3cILNMzXs2W/FroiGaOUXAB3a+Y1AZF5xup4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866317; c=relaxed/simple;
	bh=Zb+I8QJTNpeIlLVciD5I8dfeFJ5F2eCY4/UOCufXetg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbyJQpm05RXG31GBBLGWkuZ/f+xvrz+egXG44jHKGdE5VESMIAGHsyP88pyUekC0XRO1ZfNhbwRvHCoLV3QX12qpPZpBNR8x6PJrTMsCeIuLffP8Gbxlxevh7yy2CaOXNCWWza5t85i7M4W4EEDyMAGv/7uraIG7GHHo6l2VJtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CzB6yt1A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gTVGy4b1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CzB6yt1A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gTVGy4b1"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691DN2dq2257279;
	Thu, 1 Oct 2026 14:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zneNpJYmZjeie/vbEbCauOSZEK0UMSvZsU1kj4iHnm8=; b=
	CzB6yt1AJiFXlTSwJjdtZlzQ2piyDTGQRaRqMd9MENByJK4Zc9Cltmzlmz/KyJkp
	4cNk7GZA8YhJFEi7Nsb644tsswu+KeCQy/hRkeG60Dm1Cc0eSMj9n5tXlVFz2o46
	YBkV0sUokpljBzDIjA8pXUe9k0tn6ZTFbHrIcKEDAf5l0T3heQR9ATZ0b2S8eEST
	CPB4lDpoxanl6RKHNShTcuLzblxHLqz7ldO5dRxfDgqy1UPXCWqKc/8azgBkayrI
	R8jR+Yqsa20ho8OKZpI3dOoDjJYxvhbf/HVClE36BSWsjyiLosY73ir3Hoz4T7WX
	hQl82psgHwcAHImZ+H9zjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c13cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 14:51:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691EoQnL031659;
	Thu, 1 Oct 2026 14:51:44 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gsd32q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 14:51:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyzIPDKVHCL8km0jjQxOhTvx0CBTHosha4y6GnEX3iM4zDJtt1cHM3lT0cMbAsqxM0rrUwOGWPOuFY8a3eLoxyvx8BVobdwaui1rUm3pm/4QoA6pBvWCQCLC2L7YvxNYpt6+MBfrSz+/qRM/DkFSbmiht2CYSo1ZdG9t6fusrBjqS8TUNzQ/UAa49BdrCKUF2OLwpglg1HXcm9ejIeADGeiCFaOQYnBc2l0SSwXb/8VgiCeUpaEr50VTzwgCY9nl4s5l0Atuzb4zH6XB1PI+0KsIC9EZF8fhxljRq5VYHfGkalt2ZOE6TcHbHfl51fcyfYhLmi01Py3tr2OdyCmymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zneNpJYmZjeie/vbEbCauOSZEK0UMSvZsU1kj4iHnm8=;
 b=ZPF3RzRw6ahciXCPzylFkmOZ3tg3vwvJRjKlt1TqhFHWGhiGzCa24nKJpE45T3rB94sjNTb2EjYi1tlmzlddZta0kwwO/WkZ4vfWRdx0TXoFYCi+uVotrewyCIIydgtPJ262F8k2yfsArQH/zUG9LkVxY+vQPjgdF/2BNYwL6uU60MABN7+13xV8F4VRae01Y2W+VPYVg98FzCA+4jIwz9BmBHvGxQY0Yn5B3dNR+GKHVKgSaSd7uu/F+kY/Zx4yY21oJ8Sh4QSiJ3QXoeeltNoHNPJjPPnViYPVjXspziNKPO3+IydhvFIBAmDXz//Nla+8GrCfxmiEnOoOk73ceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zneNpJYmZjeie/vbEbCauOSZEK0UMSvZsU1kj4iHnm8=;
 b=gTVGy4b1x56VgTpxOovR77jwQ7Jd8q0jlZ1zcTZWFeJphrS2s15JUYzt4EsZcBTLe8NnEhZvNXB0gnTeaEvUi3ivASf60MUAn8uk8Ntt6k0q9S6Zroqv0YU0KRfLsDzkoBEhTpRdSJA+CxOlQAw9A8qycO7zN+VZYxIolVl88GA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 DS2PR10MB530506.namprd10.prod.outlook.com (2603:10b6:8:709::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 14:51:41 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 14:51:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Mark Tinguely <mark.tinguely@oracle.com>
Subject: [PATCH 6.6 4/6] xfs: rearrange code in xfs_buf_item.c
Date: Thu,  1 Oct 2026 20:21:01 +0530
Message-ID: <fd83b5f099c2bf01ab29fc68b9613d49adaf7786.1790864521.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790864521.git.siddh.raman.pant@oracle.com>
References: <cover.1790864521.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|DS2PR10MB530506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c02f769-a1a4-4350-8dff-08df1fcb804d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|376014|366016|6133799003|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RpjePfPhk2YbSeXt8sVZWri6VlpXgtyCr18OL1yrMQFs1KbJJiJTycHlYymUdm4fG88fPjL55x9g/VApVUzCRLZsjUscAFOZTtZRejWVKfmw3Ytrst9SGkoYUmwjattxqTzEAfAOZP3SFlBblTrSdOWDoRSx/3jKxkf70FBi5W9ma6jNhD8WM30aWZbuMvsu2DQWVcJAVGWw1Rn93M3xPoWm+X7HlwBRn7liKhBOLldu/Ow4veAPwuAsFgOKqno0HzuAQ5C7ZaY9z5xUYYroF9GytEZZ0c4LWv35KHPchLppXw0BnFBqV7QcdCuMni2YSfW/uwtkeyqjAwmqGPSGibcQdO9UCSspdaop9ljd+1mg9NuiGOprDpZFLcd+U8rH0qLNsoai/XU2pl7IgKbH5d3m1zKwujh6Nll0nIQy5C+Dt6cwJSYCvvZh/kXialTKBirZGn4IgPkTLeBoXFb2Sw6SBLSlVI0vsAb0vVZUqDmxNVpTAbHxgnTg9SGyaGmEFhHh41cFuWEQi6/h1ld/SBvjT7FU5KZLRZKcQcrlsezjDDkmRpZzsFBv3Uo1UftSMXUFCapm9ldhwN5I3KaBaGrKg+bUAF9qdn1Oqmx2JRuTczKGQwRrkeWcI6Bp2OYPr4n0DRsm0IW2xlP7xXRZe4tXLp8cyfEz2eAjV3dYeAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3I8Bfe+I1LHNDfwq0BTBdDY/MS+vddAamPfvQu1BWh5/LdTpSnI7T64yaX9?=
 =?us-ascii?Q?+IcPsu2BoHrTbAP/GGZf/lnbmDyN72S7qtGcEXD0X1ZgvXl1bUBw36DO+vWQ?=
 =?us-ascii?Q?V29EV86aoWtch3qAe0w2nJpqhpkk+qgZhOEGArwc7v7JXCP2Tks/r2QzAP+P?=
 =?us-ascii?Q?7DMMEEuJHFgIYK+SnmCWS9Oaae/C2CHjQ1V8KcLB97pER5iPNHguyaNvWknW?=
 =?us-ascii?Q?RnV1L/QrPynHfZNg0/axCKbXx8UWcJeeO6nOyUZd5qME17D+c/B95Z+2yRLn?=
 =?us-ascii?Q?Jg3sN9TfSuEkxTh/eZiJvSnARrbUqeqE1IytgLb5M4E4AFMcThIS7QW3vvTy?=
 =?us-ascii?Q?b+HXpYBDfVYPL6sKKqlKvnHMZSUSt1Y5FPpj9OVaySvF1CbHT9GrV1eLqkRE?=
 =?us-ascii?Q?zg3cNRvKVGG7B26n69JqFCVHTdyJKATF3GX1wd0ZZVo+H3S85IwdzDR8HsRc?=
 =?us-ascii?Q?smzmxl6/22NLFdhgbjTuRzT3pB4wN8FN90r1J8us1/M1fgMg2igogpSobPWU?=
 =?us-ascii?Q?oozRUXTFVKInMqEjpHwcN1O2gxZP2Hz+lYarYfwr9GYI8vr44GXlN7j3oNuf?=
 =?us-ascii?Q?EDBSVc9Cee+etGBeA9eYt7wakDmvkHPbBTii13xomhcikl+Nxr9x4zL+cDBF?=
 =?us-ascii?Q?lWQXz5IUzHNLb4Mhe83mV0CX0L60LKMDw2ffKb55s2tNABy0nViEWJ3QAMCu?=
 =?us-ascii?Q?REZZ5hardOeJVRl59+6/zM1+HrotldVfvjhMSQaG5LvljQm8rQL+thjifulI?=
 =?us-ascii?Q?58JtI60bIHXz7HKmDA7u+Lfxr8+muAFYJ6EspHTA8/nzsWq5/dX99666tG5Z?=
 =?us-ascii?Q?1GTJjVWweWBK84lffaaSPgdqK7ABssFFJnvvKXYwUyCoiGp4/A8OM4Za9e9M?=
 =?us-ascii?Q?8ItPOI0fAzwPA7S1/i7apqcz3wOT2FHDW49ePVEj4saiAgYKn6jWqLcv0hPU?=
 =?us-ascii?Q?+0/qe6kS4bQYN4F7jHXHfiDO+nEh0BhOQ8ZeH0Ft5rTGGclqWPoOS5uNWBEk?=
 =?us-ascii?Q?IFkdtUDTK5xUE8PjHMixIyBMUlKzio9Q0RC9scDxAOy/rrT2/1K1GjJWEZ+z?=
 =?us-ascii?Q?2199tOEp9G6hWGtNhIn+XwmMnixwNDPPL14K8aMT8Z0B8FutOmMlcCRDvfhz?=
 =?us-ascii?Q?UzOaCI02L7CUfR1FBLAIvW/eDq5lqfka5zAPfD19l2o4n/2BH1Cg3X7y/kJd?=
 =?us-ascii?Q?wiy3TMg12GVc4JnU9TVeHTKR0Qq9I28Pu8P0dtIP93WKmPxRxarVJY5TkD9J?=
 =?us-ascii?Q?F/KixL89qux97i8f9DA029jC4HonRvxX9W9LpuZ+Y0Vl5Wo2dz6WCVZEF8Vq?=
 =?us-ascii?Q?9+/NA+0YPj2tMzu5BSDl1f0nC7ih+/TUd6bCAlgfCFTxfwOlP6bOZNEUWNCw?=
 =?us-ascii?Q?X8OywNgV6j9Vnw1IzygHwiFMAGzHdyuyp+uwBW1WrsyYNdZF3EGFwXFCBk2g?=
 =?us-ascii?Q?FGQo5URDN8RRajFr5o+uvddIKENO1J9q52wqVp5U/tlmUUyw1z91CL4W/Dop?=
 =?us-ascii?Q?DVkBbdUNbUMz25wQkHrL0OVZAtElMcLqnKcjBPfHG+TrROaXu7+fASUapuq9?=
 =?us-ascii?Q?HIHdH6RuZpqoeeH5Mcdqop4lcCaPUvZRlZjuIKhMETjpT4u3gTbFQKUGSepv?=
 =?us-ascii?Q?dWwr20X+ouqP3VpBPYGkCqAQMlGJm22k7dQGFjyzEWsrj3e/ffDJVxlSoyhb?=
 =?us-ascii?Q?h2NKDGi0poW+QBfRp/ya/4cBK0PCORR0xuT6CMMss5DHIEbAo6uPvq8F3e4Q?=
 =?us-ascii?Q?vmPyPP4y1xJEShP2UGFPOpOT6L3ufYiVvZfQCnQCHXQ7mS+j+e8C7RMrcuCo?=
X-MS-Exchange-AntiSpam-MessageData-1: Dy6UsjHx1wO2FYLVVQ8pyxcJTzxm60AghGc=
X-Exchange-RoutingPolicyChecked:
	oAGRIE2pxAAlj9wh0j1BF8/B7zhvAZpAKbduCui+chYmMdk0qwtARNNzf48rCfpMHnXf/xK0hRWfSWpAS4GCkxlnZTAIFnSlXsAePdWcRdl1Ds/zJIC6QaKWlJNsN22bLH+gMTbSIuVeRgd8AP901WrhFXjR8LXFb6tHKjMvKKuLDBpdRQKekl3w+sBueTaUTUtYjlx/IBhC3T1PbykK6i5bt9dsPGW+Zmdy6TjV1VBPFOEwWQX4rQnY1BKyOYwhdc45UaWjIKwuI+GjMfieU3UKMNvKQjBUEdgMhFM231PR6mx5koRQoeyNp+fFzH+LGG9O5BJqiUr6MNVhUqrpQQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zd/1HRrIpCxHtOC/IGKNm4cZuD9tYv+jU3n1/PQJBQVrdD2Le1pJOiuhHaj/lbB7Liff8B56l2s+8QAWQiIb8NaLtS7TSWL7bkht4CPFGNF8V4a3HgR2tPLFkRG4yIObqcqBf+djsHKzw/g+cEKVCbam1Qsdiqh+FX9C+4blqLuFaMKNNjkZBouBSiOrVREr7qnymYuakWlCB8FhW8x+1wCHNsrPj2im6MaqXx7SG1XDrFY7la9HoJyddo26Mgxu0rs2KwkgPxSO8wDwgGnffTFq8r8aKAbKcjzTT4pmHyMzMvPXfjrOHONm/Gvjz0jB2qCXSHfJaoL9FCcL2rJJBpj80PN/5S65Jjn50H+a1/xuSJb4p+5xus2P7zvArQsMb8aDW0zUiByaPVeFmfCeFBbaVuHi2UPECYO6xI+hGHUDvPE17L0IZTIyHuME0cLGYKZ07ex6zJFSjILlBcq1rgETxj4Fi4PwabfWKms1QGH2pQsmYtOqo1k3zmiGX63ozMvtAfOhgrjhRKYQFYjnxWSHtLyvVhCmXmu3l7PbuD79mIncROpex8YiZM+Fb81Fdels45orVp0sakjlZ9nG2yxmbXSL+FAi5tni38kKfDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c02f769-a1a4-4350-8dff-08df1fcb804d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:51:40.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuMvDl+2SFIop+bvDHk7mrHn+dV6zowVorMeIbCWK2VHHl4Lrhmt2ZTBHWb+EcayVLzgjrwqQJnUakP9tA7GsgGp8aFNZJfvRLhUUyYSHoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR10MB530506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610010059
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX1kTeQ2RSH/PU
 7/HfbYn6Gy4PDC0hsGgouMkr7clvVxn1i4xKxPw+zUh4QWBNDLhhGZWZrDhZsrlJrsQqIKJfNCh
 N8SEpH62d2D3Ie7pD52rvkL9oagrIkwWqWYrWf2QikQLnXS9d6i0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX4jnMxnHzfe6A
 23MPVv62wz2fKY6Q6Bd3Y5iEHqVgWmSsaqiewLsPWyc+1Xe1mKf0csnkqfu7KE4VizgroiAraLK
 ozY9NRalrT3BK8gq2e20GV47XuTbpHJ41ROgXvztbuKkeP6d3DA2r88/3xhLYzSQvtbVrpIpafO
 tJkTd+13xo66Inljb6mtKhYtBC7lyyEpSxhW8xXaYTX1K0uSqq+6X2cZbup4ydaWDzoAW94MHmP
 AV03MTXvRsWNzNIo1aUUmg31yYSNAYc9PGZ27DBdFZ8SOpPMNyxt+pS0on0HtsIxKjRRkacacLm
 9Ewi7vCJtNbl5ThSDxnoMOAhHoCYYHVwn8UJhHRbeIh3KmF8cpcpa1SQCYVpPUlq+VRlVaNooih
 HZfdqOvA7sFtmUlwnqW1XKATenwXF6vmm8/r9j+/Lt/1HeegTEal74w/30Ngk0VPCfsVFsYQjTV
 Twr6PfVxHwn3N7au0e3CYpo/KPVtdIxkoCqknY60=
X-Proofpoint-ORIG-GUID: ExXbeQECKe4FZx6ak4XD6O3gdU1vHn_a
X-Proofpoint-GUID: ExXbeQECKe4FZx6ak4XD6O3gdU1vHn_a
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abe7380 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=-BFCJ2bJgao7vN__fc8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537

From: Dave Chinner <dchinner@redhat.com>

The code to initialise, release and free items is all the way down
the bottom of the file. Upcoming fixes need to these functions
earlier in the file, so move them to the top.

There is one code change in this move - the parameter to
xfs_buf_item_relse() is changed from the xfs_buf to the
xfs_buf_log_item - the thing that the function is releasing.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d2fe5c4c8d25999862d615f616aea7befdd62799)

6.6:

Fixed conflict due to the following missing commits:
	[Continuous range: 10634530f7ba^..d4c75a1b40cd]
	d4c75a1b40cd ("xfs: convert remaining kmem_free() to kfree()")
	49292576136f ("xfs: convert kmem_free() for kvmalloc users to kvfree()")
	afdc115559c5 ("xfs: move kmem_to_page()")
	f078d4ea8276 ("xfs: convert kmem_alloc() to kmalloc()")
	10634530f7ba ("xfs: convert kmem_zalloc() to kzalloc()")

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 fs/xfs/xfs_buf_item.c | 116 +++++++++++++++++++++---------------------
 fs/xfs/xfs_buf_item.h |   1 -
 2 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 72d6e2dd5ef5..033ec1e2f2df 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -32,6 +32,61 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
 	return container_of(lip, struct xfs_buf_log_item, bli_item);
 }
 
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
+				0);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kmem_free(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kmem_free(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_cache, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+	ASSERT(atomic_read(&bip->bli_refcount) == 0);
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
 /* Is this log iovec plausibly large enough to contain the buffer log format? */
 bool
 xfs_buf_log_check_iovec(
@@ -563,7 +618,7 @@ xfs_buf_item_unpin(
 			ASSERT(list_empty(&bp->b_li_list));
 		} else {
 			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
+			xfs_buf_item_relse(bip);
 			ASSERT(bp->b_log_item == NULL);
 		}
 		xfs_buf_relse(bp);
@@ -673,7 +728,7 @@ xfs_buf_item_put(
 	 */
 	if (aborted)
 		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
+	xfs_buf_item_relse(bip);
 	return true;
 }
 
@@ -824,33 +879,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
 	.iop_push	= xfs_buf_item_push,
 };
 
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
-				0);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kmem_free(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
 /*
  * Allocate a new buf log item to go with the given buffer.
  * Set the buffer's b_log_item field to point to the new
@@ -1072,34 +1100,6 @@ xfs_buf_item_dirty_format(
 	return false;
 }
 
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_cache, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	if (atomic_read(&bip->bli_refcount))
-		return;
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
 void
 xfs_buf_item_done(
 	struct xfs_buf		*bp)
@@ -1119,5 +1119,5 @@ xfs_buf_item_done(
 	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
 			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
 			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
 }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 7ddda0aa9dac..8a8a46e698be 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -49,7 +49,6 @@ struct xfs_buf_log_item {
 
 int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
 void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
 bool	xfs_buf_item_put(struct xfs_buf_log_item *);
 void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
 bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
-- 
2.53.0

