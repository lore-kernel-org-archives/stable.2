Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792460996;
	b=4iVEJTnLm90VECO9KD2hbciRJQw8f7MQort5kaFDOmCtYBG82+A3QFI6VeJD2Mkhi6Jb
	 eiQzbez09yspzZmMe5Mr+tnxmVfUzeJXq3x687cE+Vx3Whpy5NMJM3BP9/9I8+Yq3MeYD
	 YX++sgGdgyPMXRZ0Wv4QWArSqDtGpKS7yGZjRyeAlBZWqFvR5rAi7jlttfeuawxv/bCx/
	 VaMKDuoaIuKzf2tbu3kDws7KAFIQQS+fXA+4qfnNNxGeBBkMIlyT+RU/d+yTLN1Eb/OSi
	 Z2K26K7b+2BU/EIaY/0ouxzPs8vHS2fassa+kTyZEnNM948cHkxgh198ibYAje1by0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460996;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mF31aDORRIzuK63GEkmX6WSOV2bPci9TuR9qODT3V00=;
	b=ca3EomEXl0F39dbn+DwJvl4+clGVGZewDss2neMRoqTQVIlc4ph8eq8uNR0eWAKPVAiD
	 fMiqL83x2ftlgJgh5uXr3GpZ7nMqRG5FAHokf3vB8dDkckKOdwiIf7i5wiQEpG+TutcHB
	 xyPj6bXDvFdbb5mB4DWv9lifQsFVlBFyafQOKz/NYDvHB1AG6kl2m9cOXCRJVD665qYT8
	 h8+gb0IIYzVwkD6awlrebMEoh7RdE12DJ+vAxhy2vyh0/sPngkuqDX4hzqtCm+9Ty3lXW
	 A+wZTkPzpEsInEAwZ3cU804fOJjIC70tDguIkq2B5Me1Q1U97Bxa+bkZ26uNUPFS8gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uQOLiZDl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.45
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D160606A31B;
	Tue, 20 Oct 2026 01:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D160606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uQOLiZDl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2V/TQPy8eO6ZXl8ZucU5ab03En7yZgHMjtWxMhOQnhJ01oWhQDRpnH6FNkF38iKaI8MzSIrJf4JsTo91yNkZ0Zzuk4VDhXu6a/u3/CIJcMRQukHZhTme31b7D3yMrScbOb+64NSWt7n0fs75mh3nyDnRZ1eMJ5MpCnq4Uh/LSKN1Nu4boc9xFeQmdHf4lmp67NJXiKEFa1LnUpXAQQ/HoVMsKj+QqZml9Vd5G9lNkbzkNDrohDu1UUuqk0PuNg2H1mOy0+KnKjVBsZXz2D9iCyO605B/5kfUpaVWEV3ZHcq3shoB3DewOODrmUMcQDurq+LtE34yleWA3AMbZAllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF31aDORRIzuK63GEkmX6WSOV2bPci9TuR9qODT3V00=;
 b=mPCwlWaueDIJOC6PLz6nps6s/CaxAjTAfVyOFxAQFq/JFtcxo1g7jtniN5EBh8xwTC1zyn3XDojREXazH200dFvp3BJVdZdgEw0TmEz3U8g0zf3MlwoCz6JiIb0YBLR27wTcupZko4q9EnpkkYT8bqKkpyDxpUUeMhRs6AaauzAMBSl6KSvDXq1CIbCbo/AE4IACc8EPAkdtn4wdVtszpZ/Oz5JHlF3+AkvEEH0u4FVpAXGjHzls9Ed89H7CMxIDt6hPx+DJkFgkMTRFTfjD+mW9uQawecomJDudXjURnKgj1uU9kyyDWJ1qTiQ/UblokzrWFF4Sf/GLHLe9vlfItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF31aDORRIzuK63GEkmX6WSOV2bPci9TuR9qODT3V00=;
 b=uQOLiZDlYy5VEO9b+U2kEnKwXWQsk4dOAfA+ZUCLVc6XfCbKNr1FqcigiBQQn8f+24wqtvOKpahNiAmsg7JWaaPTW0oivQ3Yke/+N567pg+1mG7DJ90Dfuk16Je2MlYQnc58JJppZ2cxQFnCvjcpDazrhxHR/D9J2EEytJNqDuPCIqSsMgB8c4zDKt8WLW13ObvHGD6IRooAYL6Wn0vMiqcKMJ1VEB/alh/3uyr6xEItlXGVvxprZTM9Hf+moFIPUGMR7eVYSZFxEIfsD5v121GpFvAs54ijebayZYnGGMUclDRGB4CEETpgr2lPsPVZQO6Wg+bXhEWkbr1v2eYGxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by SA1PR12MB999084.namprd12.prod.outlook.com (2603:10b6:806:4a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 01:49:52 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0522.016; Tue, 20 Oct 2026
 01:49:46 +0000
Message-ID: <b7aab691-ae63-498c-8d0c-1696592eea60@nvidia.com>
Date: Tue, 20 Oct 2026 12:49:37 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmscan: reclaim every zone in per-node proactive
 reclaim
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, hannes@cmpxchg.org, david@kernel.org,
 mhocko@kernel.org, ljs@kernel.org, dave@stgolabs.net,
 roman.gushchin@linux.dev, stable@vger.kernel.org
References: <20261019185002.3428594-1-gourry@gourry.net>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20261019185002.3428594-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0199.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1da::8) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|SA1PR12MB999084:EE_
X-MS-Office365-Filtering-Correlation-Id: dc524603-2c27-4e55-9b07-08df2e4c6b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	ezS14ieRgtwI1+NtzXo8NFj9+fgOYg4to7PYORye+UyPj8GOw9TLDYKjRs6Kvpab4S37mWDQmWf1UuIW/wRAz8HHFhtIOQkRaT9CW3jGEk9wgAaTkUUQCrP+z9lWTD5J1hYe6Etyma4yh3j8IGQjrcVfu+jffFYhQhEZQvh4yp+OnKubhxTR/61iwm3AT5AqJErRfxRy7kcV2xF/TFdzQsaz7u81eM2R65C73tiDy+8vEGZt1M4Cse5fA6SN53mWusgh/xCBgRjDIBern1J0SQXyxBWYiBBGV6kM7KSIyIB0WQQQFTDeZntiPBULvZnRh3j2zT5G+ewoOnLX17enJVvH/cW9TbXUxTqWFv4ENX0SQHACN8e5yInoCph1YwcszDdyMCzs7qwVYZts6pDC1r11mc6K2svVCyFzdSvwbrLXKFFavwaP9WpjtlPjrYH9eMGruNhe2AXq6W0nMchYsC3SWVLbpnMkW3jDVWgjikBkBLUkqFP8uc5nr1O24JQEn061XIzb5SbNrRFAgE1NfQuUKu/1vGdCks1NbrSF2uq/hBs3CEZkHTN+pijT9fNlzF9UzaIDX7rjdYKBtcsSUJm81vWlVMx7CRSMmtFHZ0svz4/scbaAHDmOrbKogoJbo0Lh/d9FL4wIjkH76l8eSdbbjdsWDjIxrSsInainijQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUJYNkl3Nk1jUDdaL0ZDbXhnNlJtaytSYzhBb1RsUlIwdFdyeUwyeUxFR3NQ?=
 =?utf-8?B?NGgxNnhmVGphWWdHSGF0d1J2Vk9lWkI5T0x6NmhxWVFuZ3hRQUgydmxvTmp3?=
 =?utf-8?B?c1NoWGZuL1JUQ1BEWk0zNTlHaDUyU0hBVFdSbGdTU1UyTVh2RXVQS3dLT1Mw?=
 =?utf-8?B?Ti9XU2NQMnZIMmpodjVtTFJwWjVlcXZnUk9scVdqMW0zeUlkcGJJNG9HbmNI?=
 =?utf-8?B?NjZHWnJsVzJhRWVuWmdkZ3RFUUwxWXJKaUVtb3NaeXZ6Y3pJQ0ZnM1FTbGIr?=
 =?utf-8?B?ZkxsaC9EWmIveTM0Y01PRWsyanl1WkNoek42U1JkWmg2ck1Vc2RLaEo1Y01t?=
 =?utf-8?B?LzRaSXJwSkdOelo5V2gyWmZWZUZWY3FUL2REWWZqNWNLb2dDeFBxMmlpUVpw?=
 =?utf-8?B?eG1rd1dKOHZwZFhIT2lSTjZkNXlreDBsWUhDdjlpNmFDZW13OFdKL3BNZlF4?=
 =?utf-8?B?RFBJMXlNM2VBdGdpbWR6WXV0K3pab2pCSncraGZpOXkzRW9jb09MdldCZDJU?=
 =?utf-8?B?YkJBNDN4M3V0a3phQUVCRjRhb25VMitvTzlFVmlVSlVOWXlhRTdpNDFnY0g5?=
 =?utf-8?B?Y3BEd2swL203RGtPMGt1cFp1RzhKT2ZRbGdXcnhTbVFIUWkzaXZ2eVNraGZj?=
 =?utf-8?B?MGlMdTNma0Ezcmd5c3Jwb0lxYnZTcGhxSHdiQldVeTMvc1VXVDA2WEVmMW9t?=
 =?utf-8?B?R2lCanJkbms1UGVMRno1UWtKeWpScUlhaWRxaHIyVHRwUk05WEl0Z3paK010?=
 =?utf-8?B?OUI3c1VIM29UUktUS1l0bWYyMlMrS1ppUUNzallUZ2xRSlpGUmFRQ2FXN21n?=
 =?utf-8?B?TVZUV0RwM0w1WnI4eE10cnd1TWIwTHNqUUxrd2Q4bU9QNnRGYWlDL1hQQTFM?=
 =?utf-8?B?NS83SnJsblJEdkx5YnVrcGI4N1EzMkMwVXpISTlwUFFuMXR1QkVUZ3dYRmVO?=
 =?utf-8?B?UlppWlVaOHJFRk1jRndkcEQ1Nm54QVJjMHM0aEJZeDdQQVR4N1phNGZFVlhI?=
 =?utf-8?B?amRUcjdwNGFkckFodFJrdlErUVM3OEJIc2h4V1k3Zmx3V2VqOUFZN2huLy82?=
 =?utf-8?B?QkwyV1V4bnlPYVlrRnE5UEFUMVphaG1XYXRsUEQ3eDIvZElZMUdpbi9hWUl3?=
 =?utf-8?B?K3NlQVMxTDk3NjdqVW51a1lRVHZueWJIMDl1Z3h4MmtJVGxRQVNWT09EL1U1?=
 =?utf-8?B?L3puYkNUUUZjWTQrSmlUbTRtdFlKYjNCYXNMQy8vdXJ1NWJDcVIwcWdqd08y?=
 =?utf-8?B?cUd1amsrUG5NR2xqZVU3Ulh4eS9rM3BKTVg4UEsvVFZ5ZG9KdEFEWjh1WUV1?=
 =?utf-8?B?YnN3YWYxR3F1Z2VGdVNkaWZiZ2FUNHRjMEtUcHBrNWNyQ0pNQ05WZUZvcG52?=
 =?utf-8?B?MXl5eWVZdmlKWVNRcjk1b1NOZFliaWNKNnZkdHJUcmhvdngzeXJPcFBpdUtm?=
 =?utf-8?B?cGttdEZtRW1tRk51ajViMFM4OFNDTmhWTWFTcWpsaktZcmtESWJYREZGTXkx?=
 =?utf-8?B?eEtnN3FpbDBHQkg1YkhKSnpoZk9ibFg2dWhwNmhhK1MrQm4rRGc5T3liVFcr?=
 =?utf-8?B?WjFqUDNyRFQ0bmlIeDhpOFlUSVRxMXpTS1NJeThEdVVhOG5scE4zeTRwQ3V0?=
 =?utf-8?B?ZzB6aWlDUUpkajRyUzdVMTB0NHpjZGhuRWdPSDk1b1hGRDd3VGh1TjZDaEZo?=
 =?utf-8?B?S0tuSHFlZWtZMC9JSUp0V0lvV21aL25FNjN6S3IzVll1ZldOdWp6UndEL0N6?=
 =?utf-8?B?a2ZtTnhFdGEza3hjQ0YwaUM1RU5uS2dNd2UzSUxtalN5UGYvQVdMWnRnekh1?=
 =?utf-8?B?ODROaWNGNkYxRkdXd0ExdTNnU1lCZ24vUnZvNUhjT1NqVDZUOUR0d1Urb05i?=
 =?utf-8?B?RktGUU1CWjRZZ1MyVzBTSUF0dm5EUHZLcUVtWTh1K1prd3BLTHpnQXhmS1lZ?=
 =?utf-8?B?OFVBQkIxeE0xcUNxQnB0TVNQa0c1MzRLMUN6ZnJmWlZrQnVmNXNQbEVYQWRZ?=
 =?utf-8?B?WFoyNUZBREJzcStWQzYreTFnNGpEVEFBVk96MWx0cFRsckZ5NHREL2xwM3Bk?=
 =?utf-8?B?VzFKZFpPK0liNmIwSnkxdGh1U2sxdVFUaHU5M0t3VENzaWFxZ25JZG84bnMz?=
 =?utf-8?B?QStaOFBRSldmZ1htV2pERnN0L2RVQlNqdCt6eFJOOXZDc2ZGNXIzUmNuVjJz?=
 =?utf-8?B?TVJiTVNoWmhvNytVZkR4OGhjbXg4ZExwQ2FUdVBVWWsxU1kzK0ZKNDVBSEIy?=
 =?utf-8?B?bnhjTHZ4SHpST2lFYlRSc2JPZW43SHU1akdtSWd1cm9jVGJSdEhkaGh0dEMw?=
 =?utf-8?B?akhKQ3dYbDM4WWJDNzAwRXBBUXozUFk0K1drSDBwakMyOFpCNUpYQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc524603-2c27-4e55-9b07-08df2e4c6b8b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 01:49:46.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJUNicu0IOQsyPjoXBjmI0FTFdBNscNXZTum0y9cuhx2qi4KkZNDrxNnq9a6H8DulKX3Dt1eksuqiRVjQtqfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999084

On 10/20/26 5:50 AM, Gregory Price (Meta) wrote:
> user_proactive_reclaim() limits per-node reclaim to
> gfp_zone(GFP_KERNEL), which is ZONE_NORMAL. Proactive reclaim serves no
> allocation, but that limit makes shrink_node() skip every ZONE_MOVABLE
> folio, so writing to /sys/devices/system/node/nodeN/reclaim never
> reclaims a node's movable memory. A movable-only node, such as dax/kmem
> or hotplugged memory onlined movable, reclaims nothing and fails with
> -EAGAIN.
> 
> To reproduce, fill a movable-only node with clean page cache and write
> 200M to its nodeN/reclaim: the write fails with -EAGAIN and the page
> cache stays. The same write to a ZONE_NORMAL node frees 200MB.
> 
> Scan every zone, as memory.reclaim does.
> 
> Fixes: b980077899ea4 ("mm: introduce per-node proactive reclaim interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e82ba737c028d..90f7a7bf4e426 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -8180,7 +8180,7 @@ int user_proactive_reclaim(char *buf,
>  		} else {
>  			struct scan_control sc = {
>  				.gfp_mask = current_gfp_context(gfp_mask),
> -				.reclaim_idx = gfp_zone(gfp_mask),
> +				.reclaim_idx = MAX_NR_ZONES - 1,
>  				.proactive_swappiness = swappiness == -1 ? NULL : &swappiness,
>  				.priority = DEF_PRIORITY,
>  				.may_writepage = 1,


I just noticed some other issues with this code, in terms of honouring
zone_reclaim_node (not related to this patch). I'll send out fixes, for
this patch.

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
