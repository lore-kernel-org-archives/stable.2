Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795091774;
	b=Vwh/QsP6T0/BVYBFwRL6I4aYi6U+bNj974QpxLcXWQJxMY6lgSJbYAbBgEY379Gx5A62
	 HI8aFLQZp7bmIAD6vV+sryoOb3Z1jugV6GgGZsiD29fr8bHlB9QAPkNLZn6ELu2ByTTAx
	 HPPOG3bd2m+KQy74JI683BH38vtexGcYh30i79eET6Uh+QFRDJvhD4m0ArKcMNZ3k/1p5
	 tQvtCG68eCjulrEIFqWTVMj0p+mAbxobKNofnRze2nATl49DwBbCDAx3aCL8cbc4Blk3L
	 4os7VlJKdPD60EAratLwTUMKU4pyYGo6RtrPtPKSXmUo1svvYD5l2sX95g0SFsX5AXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091774;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+KA/KpdHTUH6uAjxryWtvY4vcFl1r+u/CT/u5iSwnF8=;
	b=se/lixNZ6BkdtwptgsVbRTRFZmUDc3dXGxqdzZ21RdDI/jj4Z75L4SdZ5+H5bV4v+kch
	 ou4lqbHV4D10bawptq+0Xj85aPmJwtOS82r/1Zsigkurw9uq26OV5CQ17sI47HLTBgeNk
	 jUm2hapfR8JtCUUOLVMf15KlCdwmQnogZgShiQEt2iK7SyM0VQSGTd8H5bzMYyGyhiCQ3
	 iV/C5NNZLPtXEf0f17R3A80XAN2URxJbbl5bt9h3oEGJcFZpxsJ8k3CtQ+o7Syuoe4faT
	 uFAv6CSaEDEF39oBffmKJu5NYLkd2EjDraknv4w4e1Dmw2RzxT0MVJzhENgT9NenUfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=EnzoGyEn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C55606A324;
	Thu, 19 Nov 2026 12:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C55606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=EnzoGyEn
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBioD1983585;
	Thu, 19 Nov 2026 04:35:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=+KA/KpdHTUH6uAjxryWtvY4vcFl1r+u/CT/u5iSwnF8=; b=
	EnzoGyEnECSwrnL5JriN5yRBT5j74Y6be0RFJaPDM68tQNmflJJBY3bQOuKCqUce
	hVmWivJrTAjFYIbErXdEt1p3b+ImoQFySdQGPllI0aF+5SYoULWkVwAQW1cuRGVe
	UWHBqo+Y2/QEORYN7kXt2kezUVQSz7n7w7c/fsADECSgezwvMeVgHpOAHZfJu/y/
	sBGa1qTwxYDg/lYJ6RaJPOH/b9GGqfkk19DS5WtNFbZZS3M80Xb43QIG+RKDIpFJ
	PiRkdWhrBvSS5zoHz/Hs2F5va5sG78aYlmCANYU1wzXqdrEa0yg7d6Zq99+WawJS
	/w1oyvOXIcNJm+Y1TO+4Ow==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022138.outbound.protection.outlook.com [52.101.53.138])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j0yvdp412-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 04:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pl11HDvU3Nb8zq6g1K1R5CAWmHJYcFE4JdBRsY9B4qwr85kEhG8iF/MtQ/JPrBfh7QHurlLIHtOxcFpmw343foaKcKGHvx5xCz9MktKUIu5xZ37eHukXHNZHb5MyKMFEZQ9G8tH/GtNVIRRcYUv6zsrRri9aggLOmVaLRQAjrhLXT/OZo4P7o6WUfdBpGK4mHZhGAZRigS8GRBsobs1flQJnfCcVZlNWX2Mv8tYSwKUIBUK2hI5nEwnzvxJa0aopXtP2LIAd+lv7hhKRCi71BehshwjXLqakMr01cuXGjqD2fiBYn6iYnYpofXneuB9PFyPJWP6V5JtO2Az+BSP+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KA/KpdHTUH6uAjxryWtvY4vcFl1r+u/CT/u5iSwnF8=;
 b=vbtMtHHNqrKoszcQqP2DvXYgyB7pWeYI/vwmnXxGaz9tqdCT13BbaEVCJzTtBJ5LfRZyKOw0qoHot31aUq46Iry7FiQYRzaxBtsSOlTQPshTs7DTY+o5iygyf/xTpgpqLKVVMq4N4rMdt5jeKqZRsg0AfC6ZYoPMFuPyS9gYzBi60LqCRan7GLHkzYvkStIxFcFyBJI1eCjhc+4VCUIQEtAMXdeA6ibwljLYO5g4Yu6yUQqcKCtEajD3BGT1TFJcw3PjtVjLtVhwbfYDa9i/P5bB3zUytHknJaDJBmRTLGvglMP4pGL9NRmxVW45GYo1qnDV8VXGCEOyD+3RYPMuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DSWPR11MB9848.namprd11.prod.outlook.com (2603:10b6:8:4e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 12:35:40 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 12:35:40 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>, lukas@wunner.de,
        sebott@linux.ibm.com, schnelle@linux.ibm.com, bblock@linux.ibm.com,
        linux@roeck-us.net, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 1/1] PCI: Don't block bridge config access while waiting for the device lock
Date: Thu, 19 Nov 2026 14:35:04 +0200
Message-ID: <20261119123504.25906-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119123504.25906-1-ionut.nechita@windriver.com>
References: <20261119123504.25906-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0297.eurprd07.prod.outlook.com
 (2603:10a6:800:130::25) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DSWPR11MB9848:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d8ab32-ed4a-4dab-189d-08df46399ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|23010399003|38350700014|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	03eXcu/vDwe6dFjh+70ut48bPscYPwWP6fqOaFd6gc4OrvAehRi3NF7bnA3wssuKe9VVYBZF57xzmkDhcefTZ4Wz44fdBVPoQF/WxT5+/ceFXjdb4DHqpy6igfSnlcc2hOPVRmM0gV3TYigQOpC4lkQNHjNwfQXZfcuzXfYsVhRMkJoAI78NuGJtAUZfPHVicAbWMDYQaCGmsxXjdMy0UGjnircsKQ3tNXNro4h0oI+n7z9h/YmeAGFmF/ouIaNOVVY7P4jrszTKyPPBo161CEY/eiouXcS2AgeMVJ2MvHY9MYZPCoilJS4HdFWClORjjnLryW+tvukkGKft3UVvSxU9KBG4PEbS9P4nBMoZLWw+/4bMvVQQrJ7SY0QMnmvnuRF6ypwBKwBB00ESJOfArs2UwN2IGeRT+6qK8nBtw6W8Xd/4gfAZaNaCFn/pXQUiPEXMMRVERKfJEbFhZFqptetJ9eK7Na2bHHYVVAHk9l4HBqUNdkJ/9beUwPxVywkSHrli83CfchqKY1q5w27/TS+r1lC/l9u9hGAXE0lmpKXVSNRcaGZxv6JK7zBSyJs/CGYu3hTT2bpJbMjoIb3nBYmlQBFy7toIEBl1j/2ziij9UqPqcVzdn5K849Zjfx+QZsB1jhMfm4S9onmVycqmPbQBYajYezR2Y6qxFB4x/2BbqOhrdhO6K1BG5Ylgn3LTxL7P8pM7G1cAF2HqTkAEyQB1unEhJo9Bq4+6Ymr+ufM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(23010399003)(38350700014)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEnZN4DZTVg7Dd0YtYIHOCHlGiD0wXfcUuLOXiAAX+ClOzF2lZQulno3UmX1?=
 =?us-ascii?Q?mD7eX9F/9ihCF5ILgaO0vgZWM0FvFHc5TwJ9BnUzO6zZDrNJHgh5Od46EtVb?=
 =?us-ascii?Q?TtNUDTZ2TY9jV7bKmgwSMzlNlU9a/bIFzksrZqbMZ7tFqY0yqvKRSF8YFhkf?=
 =?us-ascii?Q?bWupDfRQwZVK06wW8IVgxwWGAs4G8Y0AHnVHxUxnWa0OuarJETKpUUsw3OyD?=
 =?us-ascii?Q?S3UiehVG9YRDXSxnuV44l+XuwrCbGNrlgFSazY9Na9etK9qPwN3lL0HJkvhL?=
 =?us-ascii?Q?BlYGBSQqL+lP2cv17YCfeQzFMxuvhWdmfNlvUS5fPGrZXxnqBkO5dX1wADvI?=
 =?us-ascii?Q?K11F5xCEX1AtrsBy9UniJIext74yOyR7NojgslcXJoSO7n4feTKgwmQuWu/u?=
 =?us-ascii?Q?bNiqj6ahqlZBD5uG+x00WmGMA40jw6/vszOdDWrsVDARCcdJ5Lid9MlXYYje?=
 =?us-ascii?Q?Dlq1uxnkBBrY5/U2yewSZSETbrmmDaXp6oi8w9x/aO9bXCLXX1PKjrCmk1vo?=
 =?us-ascii?Q?oU4K+7qeRHlulJcF9avwapnIi/vmRYK+uWWts+/LR0T6zmuTtMdSdJtGl8T0?=
 =?us-ascii?Q?xO/4RAVhhh6vq1JCQlkZ65Zky35dq/1fU8arDSqcD+1vruYaIA3q4X/vcnyR?=
 =?us-ascii?Q?/EbAGAkucL3rrEnXQVjZImw76wgcYAzocfjzoxVyaPZHse660VcwI+tFaIdd?=
 =?us-ascii?Q?OFdzAEAinVc35YSEdPSgBUvaPD1EItFAbIegKv45tF0Q+zHAv5V+lOJ2tYPw?=
 =?us-ascii?Q?FiIQY9YA0lt+rYHAjoqmeumo9yBNBOZjZUEB0dc6eYKsRXoV0Swmf2Q9v5A3?=
 =?us-ascii?Q?9wz2i3TSUJpZ8Z1kxMXlTFYz/4yz+A/GK7roQAvhAqZyWPSjh4tT01g23a+u?=
 =?us-ascii?Q?wW8QUUxc5gaIOY5gLqOXHaxmOBysx5pGj2xuWcGGs9aLzeuDusNmaxPJBltw?=
 =?us-ascii?Q?YYVP9sCKQ0b8GZBChL8szOSzcb4dhq16OZq0IfteJW1LGLOloV2tlUoSClDK?=
 =?us-ascii?Q?NwF6xBayVlKX8WDjnuY+DJGAVE1Qa3MuO6TgmUrthogg8NpFUDmun0LKbBlV?=
 =?us-ascii?Q?s4YdCWvFHq0I1Q2dijWOhRdbSvSGM4Y65v+VH8iJ2ZzZGsoY6e0+P3XTYzGw?=
 =?us-ascii?Q?tKriqYnQuaRn0OtzwC//7gAtOWXYnHZK47y5lY7kCu3kxRGTKil6wYK1YMJw?=
 =?us-ascii?Q?ZJZYqM4swvHDrP71vNYiAn94iCLbxJ9KYeToXzckB0Q1mRdMCSDzeFkc+nYt?=
 =?us-ascii?Q?9SgxasA9QJ7BVNutfFsPBzorR8DGBkDNecE7aKXc0TALrkEyD0vKLKvo0sVc?=
 =?us-ascii?Q?tPpEbsuZJXnzGaqvaYU0tmlDwxff+EMd2F3ynU0zvZkaNTMVzclIrdknFotG?=
 =?us-ascii?Q?0y6XgpRZQTWSGUl3uJMwVbVejo/mW8P1EF9TYOgmtDtHrXTbS5ALLhhXnHTD?=
 =?us-ascii?Q?2TmbB7DY0r1BXVAqlCaXXWalc+UkmjdCnOCoAVfq1eyAaIOQQomj4QL5FB37?=
 =?us-ascii?Q?Qfy5ZzvRRm4lDGNgfXb+sLMRZ0/LcEVYqNXI5S/atliH7KswZwpI/a5JxbsX?=
 =?us-ascii?Q?KrUX4AqpCpFZlpnpIk2iT6W0kGXxDoz8QWchGzvkYp3qh7nxYQiQJQ8klxpJ?=
 =?us-ascii?Q?RPlz9K+7MPyjUMrQYfLKxa1RrWE5GtOyEuILCL4gQ+INoq1b1xZ0tI1tDfEd?=
 =?us-ascii?Q?qrIQxs24T5vTq8hOYUptzLAfJvdNnutQkdF4ekc+EDeFNND5O70H8ZQg807g?=
 =?us-ascii?Q?Uej5qlRkcjDEat2qX3Ia3Lv/O2KfwHo=3D?=
X-Exchange-RoutingPolicyChecked:
	2Xzp3GXs0LRER9pWBKREMsz463XgJQkgypX8VE73SMqrSfE9CSzdNg+eDMQTY3GstWNi/xwobvBvXICy7VOsv53pkzgSIQYAMGjMJsORh1gKywZb+O6oyKngd2TcdokxzwBM0zn3GOhHqiYz/o5YxiGg7ZXJsGbdVjgAAhtAJ5xzeCbE92XmaX6QaOc/lZBe10n7+Yu+s97W1D+YWk8ck5LWFiqnw1RiPDSJRoh+avhyFu1Pw4/sBNnpoafCK6/MqTbuvZ0/Iy3RHVt0DHsyTEqwDSF9//al4oIx6OmBPn2g+0Vt5AvrQrVQoGVXprFY69+ID2JTib6HFwkjx+HUvA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d8ab32-ed4a-4dab-189d-08df46399ef2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 12:35:40.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiOKYeN5ZBtYnR+CyMv5pj7gIcqVmGMZV34ujH5hsV36CTmQaoWEWlqlGsB3EwjWcv3NbeFnNkusts5A2PZmWoUG/7CWHK4RLjTnCjmMMG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9848
X-Authority-Analysis: v=2.4 cv=XL2l2ghE c=1 sm=1 tr=0 ts=6afeed1f cx=c_pps
 a=xT6463nTkSV8JPoIR211kA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=LmCsGYQYZx2BudehtVQA:9 a=O8hF6Hzn-FEA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX7YrjaP4LxiJ9
 oBjXtyadhE+OFOhsL8tMX83vfkpuUG92TxyH6Nr1s5ZHU2AfwqAreVvbVzHQ6Kw/ePuKXvsqR/W
 xjRHsVKDy59ZZR5qYbEayb3Jm4b9lA3MVOgM5zP9uicWiS9RI/UCsRY424X/6P0aP+LyVLGElMF
 VN5YC7upXW+9k1JQV+K+nY6dAY1y0puC7fts7LFeYpbsrwv5kBkJjEss337vMr0B/DjkUVgDITA
 axZzvaAd2FzS0OaMGOkBmxqQb9dKiGN/oVqwPcjMy2wSK9oERtRKNBtMCH56wpaY8VwzLLF2tNS
 UtWkWFG6kyknRLCWyihfM/0ur+t6EPab8bX9eP9ERKreMSrj+8iVBKrK7Gy+N3odgxUmrqAtcgv
 1bVYXpQPU6PmXeSTmDlMBndWMa8q25bcteh2sAZXSYr78lKgAm+0WS0/T+YKOuFHrCUQ0M/FaAa
 hnue4C7ey++zMN36aHA==
X-Proofpoint-ORIG-GUID: -efzP7zGHBVzahy6DJyqYnN6QfoL7rJZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0OSBTYWx0ZWRfX9phzNv1P25sW
 rZnrZZl0cWhfakYQeMz6sGnU893spG+LirFvDvWpjzrUbCp4BwDEa/OxHytJxatUEyd3UWCOhow
 mVdLr1p0c6imnrIgwwHYYC3qu0yMgxaEL6amM8LGyHsdelFsb3wx
X-Proofpoint-GUID: -efzP7zGHBVzahy6DJyqYnN6QfoL7rJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190049

From: Ionut Nechita <ionut.nechita@windriver.com>

pci_reset_function() locks the upstream bridge with pci_dev_lock(),
which takes the bridge's device lock and then blocks config access to
the bridge, and only then takes the device lock of the function being
reset. If another task holds that device lock, the reset sleeps with
config access to the bridge blocked, and every user config read of the
bridge sleeps in pci_wait_cfg() for as long.

This happens with vfio-pci when a userspace driver keeps a VF open:

  1. A driver unbind of the VF waits in vfio_unregister_group_dev()
     for the user to release the device, holding the VF device lock.
  2. Writing 0 to sriov_numvfs on the PF takes the PF device lock and
     waits in sriov_disable() for the VF device lock.
  3. Writing 1 to the PF "reset" attribute calls pci_reset_function(),
     which blocks config access to the PF's upstream bridge and waits
     for the PF device lock.

From then on lspci, which reads the config space of every device,
hangs in D state, and so does any tool or agent that runs it, until
the userspace driver releases the VF:

  lspci           D
    pci_wait_cfg+0x60/0xc0
    pci_user_read_config_dword+0xcc/0xf0
    pci_read_config+0xf5/0x290
    kernfs_fop_read_iter+0xb6/0x1b0
    vfs_read+0x21f/0x340

This was hit with an Intel FPGA PAC N3000 FEC device bound to vfio-pci
(PF and VFs), where the SR-IOV FEC operator reconfigures the PF while a
DPDK application holds one of its VFs.

Take the device locks first, bridge before device as before, and block
config access to the bridge and the device only once both are held.
The order between the two device locks is unchanged. Config access is
now blocked only while the reset runs, not while waiting for a lock.

The reset itself still waits for the device lock, so the tasks in
steps 1-3 stay blocked until the user releases the VF. Only config
reads of unrelated callers stop being blocked.

Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
Cc: stable@vger.kernel.org
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/pci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d79f73b28..9c8d5dda9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5345,19 +5345,35 @@ int pci_reset_function(struct pci_dev *dev)
 	 * no upstream bridge configuration to hold consistent.
 	 */
 	bridge = pci_upstream_bridge(dev);
+
+	/*
+	 * Take the device locks, bridge before device, before blocking
+	 * config access to either of them.  device_lock() can sleep for as
+	 * long as another task holds it, e.g. a driver unbind waiting for
+	 * a vfio user to release the device.  If config access to the
+	 * bridge were already blocked at that point, every config read of
+	 * the bridge (lspci, sysfs "config") would sleep in pci_wait_cfg()
+	 * for the same time.
+	 */
 	if (bridge)
-		pci_dev_lock(bridge);
+		device_lock(&bridge->dev);
+	device_lock(&dev->dev);
+	if (bridge)
+		pci_cfg_access_lock(bridge);
+	pci_cfg_access_lock(dev);
 
-	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev);
 
 	pci_dev_restore(dev);
-	pci_dev_unlock(dev);
 
+	pci_cfg_access_unlock(dev);
 	if (bridge)
-		pci_dev_unlock(bridge);
+		pci_cfg_access_unlock(bridge);
+	device_unlock(&dev->dev);
+	if (bridge)
+		device_unlock(&bridge->dev);
 
 	return rc;
 }
-- 
2.55.0

