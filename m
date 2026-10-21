Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792576562;
	b=MyZrmju+A3XuEwoBnvv9X7iP1T0s4B3rD/3MtKgb4atAtV38OWZ/aj6VsnZEjWqgW4Sd
	 KKV54813XcMh/WuXGB20UrSzkouTa2rFg9NYnmkgYq+Qc54h0wTpQqYJFsvRm3rnN2rVH
	 I37t4lo0ciVInAAafU26AKycCYyCY5zenhACKH6tx9Fx1bh2JMIvf+86i4zTWYqOXDiT5
	 vMdFc5eugy9lg88tFRWYfjrNGqMLPSUvCQJ9mKD/2pSrSXFog2MbcskTY0T/FkGZs8gV2
	 eJNB/OXMVxCfhWikdsCat30P9GkFWb0M5BHnLO/Ds51ygS5/HwDIzq/ccwaYJPIBJTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576562;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
	bh=c0PZ7XEiW1uaunGrWzLD7qM4z5rSaxhqheSWWN14B8U=;
	b=vQkPwk8McJ1xM5AK2uL27jejDKrDjTxqMDaWhNv3dKy8IIC0scGYlhcftGDmZflMt2EZ
	 L7fLScRhKPlY7tudWUmCCez+WaJCgcCB9Hno2d6ed5Yy7k1k2uzCl5yILsNmepI8W4JeU
	 r/2bk9ZDtxGWKWPZ1EdPdEltIhCFfX56NDXrw5dLnRKeWn5lsAyWJpwUz4opCc3aDvSrn
	 nGLoQfMaE5NMg88LwSm9UL9FKr2R8G83Ag9zfKWGSFVG1mjfYQBStExNu05c75O/ou/QY
	 uRsBINHKSdkY249BC4v3fi8ELKaz27hrNOmGHu6RKJ1sLcHvWKJq4VvYK5sIOLVzRDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eWZeiy+O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.6
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E0606A31E;
	Wed, 21 Oct 2026 09:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841E0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eWZeiy+O
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYi7BGCWlctD2bXcvFUMyMdejwXbOsc79QrjsHwpSenpjEGuWyqkSQfJCFapHNUUPJS9Gk9aZUmaOoeTdfA9A7R4kMUTIhOsYopt0ueAL195bDmZfnGrJSqrGJNclIw1vVWt0LwsFQ0HEZhfAvN4slz7uyZYCoth5r9COPR0wDKcOlQD5+5CLMY7Juk+tNis8JkFFL1XmJdt48rz4ZGFTW1rsFjJ4v52OrKpbBPSC3J+kbpcNdHTQh5a+LUSqSac+sNbc4Y7wRPmcncoxoZLxynisG0lFXgfm0gWeGDnn79dGmW5vPRPA779FhKqnaBGm/ZvtP0zr+s4idgWip2lWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0PZ7XEiW1uaunGrWzLD7qM4z5rSaxhqheSWWN14B8U=;
 b=cvXCk20e1nxFX0cJFDk5R8gYt5LkNKogfphUxLMDV2UWgEEd74IA5sv8BMezDPxXEjP7PVXNSGlkxzKgz1zs4rLx2u1othYuEbGaV7saHpB/l/orSo1N0TDFmvwWRh+Yb5gXb4yPm1R55Q338+V3G/oG7nm5F07bJhupNBtKc9JFMZCJ5CM1TZS+QFKOWgyD3lZuGJy4yaLrglx1bK86CRZDaLMgrKB34gclXvA5CPSnRyTId7R5KyaTczi3+LueXEZVE7inYuOGLGTFMAj5epkbBibMHgQyUU6RyU5QOkCXyPvU62UYWeLiJ7JLdJ4s13H4GFbXswQaUFDaHRGhbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0PZ7XEiW1uaunGrWzLD7qM4z5rSaxhqheSWWN14B8U=;
 b=eWZeiy+O60yMmbrcSfUeF9AhD575hLnUdA5PXaernPM5yd8CPRfid0NHNTVheZvq5PhaN4KgMsUxyaZm97zt+QpoCdLsPY6Im31diSoVdLpoiOeSd/fcWvQoXqjLnoe5A0mFYpUvBPvs5xmyi3L7RGD2TDaVPNwkV/tZE7O7JGWT+nO3KM6+zRBCGT4OlmYncb8wzDfwt9ght9lFvDc3y9nOqFFqp3qwF37MY5BTO5v7DP6ucoPZKzOuNDXbv6evR42t3g7/BDeGaN0XH9V6ddtAdUczDp+sSwtgu95pvwAQXg9Tp/dW1+IUTCPkcCWZpxJZdqFT7Z1ikPv7zJ+hFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 09:55:58 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:55:58 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Wed, 21 Oct 2026 12:55:53 +0300
Message-ID: <20261021095551.3283369-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <athgpsDd9oIusdx8@ashevche-desk.local>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com> <20261016-gpiolib-chip-removal-v2-5-aambrozewicz@nvidia.com> <atIpg2E8PeJ0oGNS@ashevche-desk.local> <20261020125921.2896041-7-aambrozewicz@nvidia.com> <athgpsDd9oIusdx8@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0041.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::33) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4098:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b3f35c-c4e7-4ce3-2272-08df2f5981c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MwyCxfrOGHegt9xIRTLbDifGI+XfLz6hw2YxRnNxh/jh5flMv1iIS+D2eLD7xmMis6Jm5W2JqyjgCCaX7y/3ehZDLtWDURqQXVttpUTrA3wWTdUAA9LmpVl9YQIUagdD6oAtGRyfBs/FKTqhlarW9xMavPTx9m2xRwU2ELfp7KbykjigRvpVdUO82SiuJnPNV9hCob/HdO3FG186/6UHF8SuIF7IkXZSb80a185ypbKegn9WN7jazrVwsW0RDoiQ/1Jm8ipq07r9X6Mku2znjrmA4Smvn0CvzPPZ1bRxAeJnAzIbIaOmCj0kbVcDQIGjnSwPBWQUqdmO5ghl+Mr6KqS0eT7T/2CAgGOXOL+XnwHoANy6cePuDK1YeY7vIFaDmLkV4KdUPf6ykswEr9ghrgROKCEZv2U0A7xKeLbsKlugXFpHo0vC0C0ObpgEHAnKoY4pni/mLGWjswWxk+9h3dooDnK6FwS/nsH+tuHWPTGrTfpq1Yg0BakIGhiehRx2ky46n3a7uZOo/ZWCvyGw4lfxBCOjWJX8BE3iXxxj6DqIYojKkxWD66AY7urC0df4hk8rQfrfguQq+ntgjVzQqpkvCZOZu0AjkW9gT9o162S4w2SW1/A6spei4W/MmptWGF5nd3PQiVa8shEssR4KaBM1z9sy691Si3kJDxRKCIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vpA0eokDNfEa2sfy/oNTLcO2b/Bl9yZNlmgUgvh6OvLDhb1915Dihpdd80Lr?=
 =?us-ascii?Q?t4fx2YkAs8mz5GrRgOot4SGxbtYxX75ZU8i5RBEoMswduyuCtVnpHRk+553L?=
 =?us-ascii?Q?KqS5AHFlnPBOkZlLTAfvZqGyzNOmczUOxOsZQxeC7yb2JmAczAeORa0sxnl2?=
 =?us-ascii?Q?ryLUNJ+tARS5y9VR/gK3r97TUbQIgV7vicTZWwrZuZAxC2ilyxD6xHinzMwb?=
 =?us-ascii?Q?xDo6U8YlJSsBCo3lqVkCzIlkU1tF+c670IH71nlJKshvtLh07UJ7yE54aj/G?=
 =?us-ascii?Q?9RQabovsrpd6vyz0mAsZcZxOy3RkoVxrp/MxzogR7z1ZlvdT3062uDZuh/+K?=
 =?us-ascii?Q?IPMGKiLEAIFJpM3nPh5UBDkxCcUSpEKPubUfj8LSC5H8YrmjQvTnD8mpsgJ6?=
 =?us-ascii?Q?kpc9EWFj5G63KhATfrSMq7tl3m48PGAGgY/LW87i0U+uptsJk6RVrYrZvHI3?=
 =?us-ascii?Q?VOZ4a18R9WaBeshU2ttwkf8EPJnd9h0hr8md7LPS3043uHqWb+dRGRla3uZS?=
 =?us-ascii?Q?M9WD41cM07VVwPKitiyFny+Av+IjHG3zCR5imImuZqO0FtsxfiWgBsvqCHdi?=
 =?us-ascii?Q?pUwpGCedID8GA09tsKjjG3SNbHySUZQ5ZErec4JXSVNpLSCcR4Zz4cGuyYTS?=
 =?us-ascii?Q?N6QjiLJqDni+TPlsOgMPeIoiTAfS389kO7J/aD30P+n3BEYr1q12OqIFUFKm?=
 =?us-ascii?Q?FiiVitkBYzoPZaetp4IPkAAQpg38fwgxTr0WfvBHugx4o81nddwx50lLvNZJ?=
 =?us-ascii?Q?hBIMG6ACRCl5a5AY90/zo1o0EMnK6ZXVZrgP5GLm32xCw8ecswchb4e3ax7V?=
 =?us-ascii?Q?tXikNNDVGlj+DGyx678Mkp4IiOjFjrydABdtKmGv35Nx1ZNwdlQy7GH4wf+7?=
 =?us-ascii?Q?o0dpFeAGxw/I5FXtp++VI1TAeBSXfGyAhRI7z7Smzd3no+W5eKk2+HQbKNIe?=
 =?us-ascii?Q?1atxM5lnHTif3t9YKPMQfS8xu4sMgezp0Tplmy1d2SJSI6YYl4PGigYHtiR5?=
 =?us-ascii?Q?YF0Qte7VWCRxqsZ1ZM2qBXE2QaroSq93sc2srP5V+l/px6nlVdmTCOmKQtVz?=
 =?us-ascii?Q?mza8k1SkPPWjkGJ9hLy42698YOQnShQGKj5eoBY3X4NesMa2Wp1DGnR0ShxT?=
 =?us-ascii?Q?nMCVMjv+EMsNHIjMeuiU/otKJAPUCxk6Hr85o32wkXvktXYVEfTT1tKjknta?=
 =?us-ascii?Q?wTZAYUUu1B7nM8vUPr4EJcdpQbB8pNpBVD32bI89zNuETQx6p8jqAuHQmef1?=
 =?us-ascii?Q?dCcx+7oCnl4Eofl36wK5SssvBnq+nkRrkRhF/4WGyM/LocihUCLhLDpIcq0K?=
 =?us-ascii?Q?8yqe7E4EDl6hCAlSmXPiKanzz8ebBF5ockXRtUzfyGlQ3uyDIil6KGLtOLZt?=
 =?us-ascii?Q?jXQdBwqgeqnUr1S/QkhsS84zTDgHm37kDFeEh6gBtStwcBDVhVQGN0XooMic?=
 =?us-ascii?Q?2QuGdASJ8LVYqc6zVwUSY1eY1UR2ZsFU+/g4GjLCt9acjZjlbmEjCtXW3NlM?=
 =?us-ascii?Q?shxSrvThVVh5vg1pEl6xSoQ0TVeHzP5bwKnSudgNNUSghe01VI+SA/4OKDw9?=
 =?us-ascii?Q?Gq3A9t6kqXUiCVXmuUboURxnuGvXmH+oI1iyr6UvJtsZAW+3be2KH6R8U0le?=
 =?us-ascii?Q?E+alae+rMvDGhlVCb+SkKq8P6wWQ18ES9kAjHXqKP+6OBr78x5qOBK9jKoxw?=
 =?us-ascii?Q?4s5PzE7SmzXfjCwySaG4D7HWko/fMm6KQ/VuMC4xkzN8RowQPAI79nup8TEh?=
 =?us-ascii?Q?r/snfxKdug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b3f35c-c4e7-4ce3-2272-08df2f5981c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:55:58.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxrApKQScx1+eyimkW6sH/NI++2bZyPxz/ZNkRmwv0U2FbZV2h/zd+R1skNBXK/22Q5JbHWKMqWdsfydtuZSPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098

On Wed, Oct 21, 2026 at 09:50:14AM +0300, Andy Shevchenko wrote:
> But if you move it up, can't you get rid of the 4-byte hole?

No, the hole moves rather than goes: with irq_label above irq, irq ends
at offset 28 and edflags (u64) still starts at 32. irq is the only
4-byte member without a partner (req_seqno/line_seqno and
sw_debounced/level pair up), so the struct is 232 bytes either way, and
288 with CONFIG_HTE.

Adrian
