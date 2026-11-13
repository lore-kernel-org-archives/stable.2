Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600445;
	b=bhpwMqpZ7nkpFRPcvjc95VNI5z+8NQkvpN+COAjW6GmUYTXGHqX3VppeTBIW/sr6eZ4R
	 M5SCbUgFmBqGCmZABpln9iZdiOaAYGTD7WDVBlw/pxlq8B2NFv3UgSmAP9h4vnyLpAY9R
	 wuLyZn+J7XooKnuLP4aEnHLrqJ0BGOXYoTNx4zmwzC6Mn7S4lQZvY+C34zZgfb2EI0aNF
	 xMdoYRhW1vMSR4QvK3bd9I3HcqmCGACyykOeWefnKGVYnt5hLzQcvv7KHhTUiMuRo8UAH
	 9GYoyy69A23L0rfe2N/amaQEY5G5aZAMDD0z835zYXQ7JdI99p7m2d2tIpGooALlTxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600445;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=msklUxZA1M+CX4sQQ8uuNswgev8L/HmjGBNvfeRpkLg=;
	b=E3fnLMmTyXJX/K5qGadJaUY8NgCI2Ms4aY54N62EEiMqkvkaqocWtt8cshF6RKX9Vj8W
	 8f3cXnJX4dzfaidHQJDHQtf3aQ13+PbLFKEe5/J7DTt0ftfvNoAj76HE+QWStOBhigQum
	 ff8TjVszn1YzuRw7Y7wGfQCfRX18ShvCCYR2IfUCbgCTgpS8AWphy4rypZKSPW3KE06aS
	 Tpz4OtCTIMZA0FYp/tMgvZj9eALwHN3PbqZZQQI3/PrjqB67TBG2D7fog0tiUxELo3lDL
	 9lnvOo7jimtF9O7VD6iOz++Mdg4N94BWOgrxKMHqa0WbtAKNvVJ2H/SYNI7xft5uZ0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WHaqPg7m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.42
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17D606A333;
	Fri, 13 Nov 2026 20:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D17D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WHaqPg7m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGkGhmI83qGW8G6xfelTrmpgNSqa3i+pOjrQIBZEfpMBXd4YBY6jtwc+v2PAjaJ0F9tsfgknOqsrnv9KM2QBkOTMubkDx6kiyUoikxIL1tEkxIbei13Kipx+jS7NjjCMnCoF/qw3zCM7JEXJ7RrCAELIOQFW2jbxzYHvhgehz284JAswsyIiijHaKULv67z1XKWtSTv9FjrC8e+zOM1tSdY73ylnRFvk/fFFK47bkfN2FiUa8E9jYm3I7dh7iiaAjohRhAow7ubqCJLYu4M1tVu6j7FRPBbMG6g/sZGuIWiHFrGT0Z0C7Af+U57ABXY98/+2fiVk6njFHTatR4rvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msklUxZA1M+CX4sQQ8uuNswgev8L/HmjGBNvfeRpkLg=;
 b=TdAE2X5+uY67aIm0/GVyUFxzqGJmk8VPwu8K9QKV0TpElU2A1Ne9tqRt7tZkEvWl6ykDO6+8NmflE+HE9Z+wAnOGp57HJZCQHJcnFF0fb0ny6cYQ0j6JSVONrL6Ib7uddf/QojdT4HUZizJDm4KmcRUVANAu3YgfOhDbk8Hpg3Th+JiWpYNCqwNHhdR78oL6xEUSm8qn4fRLg0A4Qp8MjcCpZbUI/uqs017lTmBxLzhA0X7B+HKaNhMzI9k+AmT87qCsYfwQPy0CkW+PndqnEfeM5HQHs9DS3uvmAEggLKS5adVBClm0QuycgWD4qt+Yam4ppPxQoGX0+FUUHKGtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msklUxZA1M+CX4sQQ8uuNswgev8L/HmjGBNvfeRpkLg=;
 b=WHaqPg7mSlbzaXHEZ2XmzXor1z4XSKzQ4mLckviSpdxv9DPwpqHNlIkhAFXVPfWGcS1JYQttJT/vlhVqO4VKtkcMe1BG9E1Va4KlZ3uUlsrscx0kSvkw+sg7npAL/IKfbRXkIF0fWP1YxY0Cdtuz/yCwI3GaE0Qk7lRBdFi9o956OqDqheFDIjv4SOXFqxLmX2T/K+XMyV0Gtv2uXjK/r8Y/j47JNdGzoa0B8bFKJWSUMETxgQvNmChS/cYopTvI0P9uG3/W3gUXAiIri7TUdk2PWd3miIKX+zZAtNbsJzDzuONCBR2eQHp+ADL8tR+6BTuVNJ/aoIo1TRuvMJxsiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 20:03:05 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 20:03:05 +0000
Date: Fri, 13 Nov 2026 16:03:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	leon@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	kas@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
	rppt@kernel.org, stable@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-ID: <20261113200303.GA395967@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113195536.2660763-1-gourry@gourry.net>
X-ClientProxiedBy: YT1PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::30) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c70baa-a9e8-41cd-932f-08df41c12136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|3023799007|56012099006|261026121527099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MTETyMA6svgshOe5CyFhz5injvIjfTxBmsE+bPXwfET0y8wkY6F/NIkhELwe0bFXA9ixc+lYPUHikAjCkYmCRJ9ahkiURI+l6xL5biTLG70jfX4Hm+g50rsnK5BTyJszfzwCjx/8wPRhejsmsqsCrO+UehwI7RSasOuUSpXWqbSuCHb+GXizbPYczwl958MXrZOid7Ls+NySOykMs5jttbhHU3XbQ/fstz5ZVKWHCrx9Ltfxk2oLzZGgA7gPtTpCF4b7T/8uQC/cqYQz5rFrSLfwSw134W2KgIQNjBMQ77qJ+Pq3MbFR6N9DDr3BTi+kMXQyFcHkI8z6/4+E/zF9KMEpoXK/bV7ge5jcWhffUQ9hjXndS0tG1rjvS5wlYdz8v5xkorjifhItqVHL+XlShlVU3izAEBqoOnSY85qIszkZ3nlGr8rgUDICU384UkhdNc+b7kvXoplAz4eRy1tOp+eqgO2+xA6udesLqyPeLXtz87CVUYNnfan1x+TOUaS/2kuWLbqf6R/RYpMjto8HS/OoBP4UDmtHKcZ+8rOtErfcxI4nee1ma4+6kDYT6yEC/6Q6pnHoSa78uW1+xb5EThIb1Y00m4xrE8TEX/cY+0nkjyXwH8kqZLvmesMlGHJbPWkp8KdQTckR510NZ1coDD40JSnu4/QI1Yw3E/oN98o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(261026121527099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIOpdomXA+76ySEZkQ1GnTlI+9acNpZ9Pm9E+3NKraI/h3TqD9gFHDSEej8f?=
 =?us-ascii?Q?k5hDpjdrsisMixW8s8KHNgC+cGc7lQltfpC0RKc1cs3tjODoYaTqWkgkKkWz?=
 =?us-ascii?Q?3tm0ZC+41zkU6QFO28pgMkO8XqDW65dKV0O8pjihMNsbAvTewPFARWrr7N1q?=
 =?us-ascii?Q?vhO/uRoxCL/KsiMwBjlBji72DdCMBKvrz/rfQjeg4LK/EgKZ1K5svInOfJG9?=
 =?us-ascii?Q?wY1HkIC7/doSB41vMgzVIe0YMhqDYV3NEQ+ZWaRt6yK4ZGb+mKPZL11XtMRj?=
 =?us-ascii?Q?JP9ZX91zMJfi7DAev8bSft9Stn9xIyPhVQhjVia9OKDX5cf7nESUTsZcYLUP?=
 =?us-ascii?Q?ZIQKWCNQ3Ix9Zs7Fe6/fenlRlYZysMYsrRbAcMeFYg6dOCI8vCZjfdBJlxsW?=
 =?us-ascii?Q?GdccHaf+FhiUsFtjrHnJyPUwenCXTOUUaiUpeC3CykDbncxhRRlbXvMTzpIG?=
 =?us-ascii?Q?geResm/m+6kiro9NhqxTkaI0Iza8cIomqGUNNo4arKEkFvL8f80IqRGKfZbB?=
 =?us-ascii?Q?z2Jn0GnjMnorrAT92hH9NXIUkxuvOfduXtUm7jTY5yO6YjQUBPwgYF4ucPaA?=
 =?us-ascii?Q?9cZVL62mp2fjUMj1C2y+NGxcCaBUvHmcdRcG15wdaLWmaiZ97/qWDustZhDq?=
 =?us-ascii?Q?rmPMZ5nQyGectIOn+qMe0zIZEcmU22pPy32Eij9B9tnaK9bOeAH4qXOFlrUo?=
 =?us-ascii?Q?mseIEzN4Z9b36fAkBGnB7WY6UB2Qu3Y2jQjGMOzcs8oojsatPWIe8PCnuJZM?=
 =?us-ascii?Q?VyeTauqY2sxa9Uo7PAzBP9JY6KlHJuw6O8RXBPDDqq86H1rPR9Vcian9GGDJ?=
 =?us-ascii?Q?agn1SCBb63NyjJo2ILFauS0p2DLRDkZtn7ot+1Wlj0m7zLD9uU3d0LZCCxKI?=
 =?us-ascii?Q?1UFoblZxZai+bqAn9BPYQRCJ795pp3sFyPr6+F9q0gFjpSSr5cdTV3fkQwLk?=
 =?us-ascii?Q?llBfMSckKXvZGH7reK7p7Ddl40CuD+ErJiee7HQ59MsmurfdDNIb20hkM3lR?=
 =?us-ascii?Q?pr6ExP3oGCHTdT6MWJAl7hzRQhO3AjA3iYBfH9y+blt8J42u7uPGS/ADi91z?=
 =?us-ascii?Q?tt0p8KXZlGbmeTOR9rcR88T776izlueKOsiSls/Fr+68h//kgdM3bs5S62UQ?=
 =?us-ascii?Q?CzY77cXhCHTHjrdqC8V5iy+/vLih6sYeTLq6uARu911J2bVKEhRpfdbrN7qw?=
 =?us-ascii?Q?prRGPkWDAIruNs3rASwz+g+Ys6gm/vuMRIKUjNHbhJcnGnFv7Z0lka2pDUNA?=
 =?us-ascii?Q?1C7OOWrFrg0ilScxscKyoLsXlKbBUBl1491vfCh0J85jZABwxTqFCQ9OzbUm?=
 =?us-ascii?Q?7Epn6Jy1kP3bPHsEfpDGU1MmXiXVxYn6FicPhTT1ls03LW4hSO8eSKhdI1da?=
 =?us-ascii?Q?TO6AoZ3DR74r91pxZi27VujUfoMZU9TIEOI+rS2cGE2GYPI2KtP5vbTTu/rN?=
 =?us-ascii?Q?a5t7Va8InUYv8JMaNq020sUZ2NVxwxItAtQoW+SJdcvvXcuri/QwP7o7tJxy?=
 =?us-ascii?Q?FeEo20bm/5543arfTI/cU82fak6vedC02DCG0D4TA/G65HhA+69IvUUKVMgN?=
 =?us-ascii?Q?JbUPCpjjUatr3I6wfHYE0cV8Q6rCe5MU6Y/EMWBU3HZO7xBk2MKmhOl64E6+?=
 =?us-ascii?Q?LPKpjJXFuZ2apcindUYfUixgPSFUjD3Sbvxbkw53e8kph/D8z/PPJUvYO42H?=
 =?us-ascii?Q?nvmNCJU21PmCpYJnJO5/GsKpi6q/y+1F+SNkiPLjwZ13k1q1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c70baa-a9e8-41cd-932f-08df41c12136
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:03:05.3215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ9YVm30fvigh+aD9tF6cawEQZU3C2V2IVws70thKvtrySZNsaZDLfMfpXh5/8ug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> HMM can grant ordinary device write access to a userspace shadow stack.
> On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> can be returned with HMM_PFN_WRITE without taking a CPU write fault.

I'm not sure I understand this? The pte is writable but you don't want
only DMA to write to it?

Is there something special on x86 that makes the shadow stack pte
non-writable by the CPU?

A few more words here would help

Regardless, this seems reasonable to me, there is no use case to
write to the shadow stack..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
