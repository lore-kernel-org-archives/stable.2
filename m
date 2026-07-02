Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020095.outbound.protection.outlook.com [52.101.196.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BE3CF68C;
	Thu,  2 Jul 2026 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990628; cv=fail; b=Tl2wz861XydKoEiCotZh/jVtrbkFMXmB6ikmuOrIMP+KLIgeo1djsPTFT65+mgUXftD8uPAIJh489/6XxMUDmqJ7/8/eEZ++Z22dAZ0eoXYKfd58jS4AhmgmO1GLTeABFubL3AK+rWHnMLZDEFuLS2D60kM8dDbq5IJBLiWUa1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990628; c=relaxed/simple;
	bh=+JuotDIyjtmqyI1DbJOW21E74Qr+nym/XWj0cxsdU04=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=htU8axjowz01NVWtyHvijk2RIPpDN+9FY1Csq4SBd0RT6MyTJd4AqBZ9Z+XMbPWjN+Jn9eiq2NLM9Fw7sFpDbfblNKAK0Gg5yXbMMnmf9SH5CBQL6vde7kBSuX+bM2ZfROXQq/l3atiVQMX+2ktv3arKbnFf89hNzv98J6DHmII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Un6V487N; arc=fail smtp.client-ip=52.101.196.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Un6V487N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFAZ5skoHXsDQTeQfvukowH0qDhgq6Hc9ph23HOR5GLMGiAfAyV43YFHdqztJRG9SvUa7WEL9yU5Xmw167MEDd5DtU4ZtloirheeE3BF5rNQ2mDEPTada59oebPdyCo4JYwRW5jgaYCCWVEZZQANMP0YKxi+cfU6t9Nvyiyz2snlsOzLJ3gVZZx+L/uqRRbwy9CrgunlXMrj9enwL0x4/SE2f3kJlIqc7epmzfpMp99BzhVaMDomKmxGNOVHpsrqXjoyhYlpxEfJ8aQe7g0Np7EF8DqvuK7Bji+e7ocNLW9j4tM6dzUUfxrErOYOfw6ZQtmucFjtBL4LQ0w3qYHrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLLWEB7zOJa2ShqTd0du3YrzKmxh+4cOT+mMQNRMBRs=;
 b=OVMR4BUDbK8kgPaBLvFNzXz93TejV+8YIaLNzhs4CmkEMfl5BwWrMBLKmHygAo+SPfh4pyftSyy7B0VRX8EZApTnyGarSVOJAJ7hkKlnudFRGpYJjeau4Mj7FpIVz55HDnKYMC/M3WFTmXhVp7GcS1L+gqSgfO5yGTxtpOWyYHK9XR7VhZigxtWme+SghwuG6VULNIzOAOfmE6UCJUSrY/mwt44f0sLewrr3IWjqt0X7L4ofiRH1Uki71Q0cVD6WKJtDR4Y1fO4ALYRef4dxGlDjP8OmJFELrvATpKZJZeCaaiS5aHBmI/TuGVAT0nt8nzEV2eppNEdk0OHxzwGEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLLWEB7zOJa2ShqTd0du3YrzKmxh+4cOT+mMQNRMBRs=;
 b=Un6V487Nr/sMCY231A7/9bUM8xyoqHW8tfipw/dCNu8avUKftliCosBjRm3QrQEtM9w722DyALR9nOPxT6XWDHsq1luvpLVo1i2W2Zegwei9UdZW6stimrDwzYuqMNrS2E60lpXKl+6Anodz/jrdFYC50bUQ0hyrzbKDM2oiP7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6288.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:186::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 11:10:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 11:10:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 12:10:19 +0100
Message-Id: <DJO1FAZG7ORU.2LBITFAHV0WGG@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>, "Sashiko"
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH] rust: devres: fix race between concurrent revokers
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <lyude@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260628174451.2275679-1-dakr@kernel.org>
In-Reply-To: <20260628174451.2275679-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: a35e7c5c-5d41-4893-05d9-08ded82a813d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|10070799003|376014|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	6XXXhaqI3Rx8uyqqZS56j2ykrrR74FxYvZhrIkYJc9ADxvG/QU86TwObiIbVqM/1b2anFMd/bMkInTFrT1uzTdfAwd8h4NL98b6iWrkA2QMIvrFYeDQDYUrT0sqhI0ZsmSObxHRT0H8mFpBJYQEPOmhAl7eOUDVqjwK2PS3d3Cve8kOfHlZhhRiZLGDUmFgNWpdAK4f31kveD37iUQeqtGuTweNn+g1NEltpSIl/bcu3QI0P9CdmilQ6wtZ7FhDitT6M9pD3E/Qonca58/biwwixUWQkaiuSA1U/316YlQjJEECHwxmVcN93QB11wFBTYX73ooIjnvTgFVB0bBd2Y4gMvbxLrxbjTVL0L+RjZucEsy4lM++aWRHkxBVH1/qnAJ63V3ylBpTzq59O6SqZ5uOAibAgV8qHIIztBsujZoBITGKfK+fuH6/XG6vRv0x5mRFRJLqvlY/hgxwc2jLpuRTClk6tZ2g9MqEObAyfwQqA5HCpQUFP4TYOSxP7+3ir+HFewpXeZdiCl73j+qTY9eZPHQdXCicFi4EEAMMBaY6p4M2iBK7AM/Np+UnLhJl1EAQWHnk/Lk0lebxGVVRBjlQX5iRlepG4FEFgCxa8VXXC96FGTLAM92/lqJsJnQJvyUnzOygzDCShIkCQiabkBy23tpWbh+bGWqqwX4rmcovdj6BghlnWvwPdRh2Cd+Cuxg+Xfbhi9HFAF/CFa56c2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(10070799003)(376014)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ZtMTV1c24zMmJUK2MwN0h6K0NTNFptNFl2dnNRbGI2cGV6cnJ4M3ZRNGcw?=
 =?utf-8?B?VmwvMHJnczE3am1FTlBNVU1GcENsYnNWdWtQclFRNkFoTzlGUEFUc1pEM3JR?=
 =?utf-8?B?NDh3T2lkV1lIOTNadFpodlR6b2hKTm43MlNTWTdDQWxBRkZIR2VWWWlIY0ZD?=
 =?utf-8?B?T2VPdTN5TkxKTHFlMkZQNVBBVDFUZ3g0cEM0MnIxdkI2UkpCcUx4djYzVUFw?=
 =?utf-8?B?R0YydmwzZmdXeTdhU0xKZkc0N3ArNU1xQnV0ZEVCWFpjVXd2cnpHc3JDOVBO?=
 =?utf-8?B?cFBrOW1FVXg4Ujl5NXBWcE9YUGhBZk1oK01iYkxtWnNCU2JxUktlN1Vjd29s?=
 =?utf-8?B?N3FSK01JcHJBMkkzZ2VaS1lMUU1nWGpIbzBhMEhRL1prbGk1bmg0LzEyUUNW?=
 =?utf-8?B?TVVsSEJSUTIwYXBlMThSb0UzZmVmeVZibzRCWmsyZkVkaHE4RjV4UGpBRjVJ?=
 =?utf-8?B?bGRjWi84bi9yMUNweWRYdy8yNXJNaFdEMHNGUUhRMTJRWWRyY3h4WUZxN3RX?=
 =?utf-8?B?NG16TUpRemtLdU4wUTVOUXdRd2tKU3BZeHA4WXZPTHRMZ043Y2ZFYWtvWXlJ?=
 =?utf-8?B?VzVzRy9uYXloNDBFclFuS3llRWM4YTJJVnJ2K0h2ckNOWlBXdUU4M3Exb1RG?=
 =?utf-8?B?a0VZZU43Tjd5d2hDSmE1VlNzQTMwb0tsUU5Zb2hGKzQxcVFsck53TGdFU2dm?=
 =?utf-8?B?Z3RzVHRFK2ZqVGdTMzlWTlJNejdLbGdGOXc5QXczYkRSTEY5ZE42Zm8yODBV?=
 =?utf-8?B?VitDRzFwZ0Mwb2JKaUFQSmF1Y05xbEpwWUIzOSs0MmxCQ2RlbEQvM092dk5G?=
 =?utf-8?B?N3E4OFBncU14SkxrekpHYXZudlVlY3cyOHdzalRROHV1ZnNyRW9zZGQ2cHpV?=
 =?utf-8?B?MSt4YzNGUURJeGF5K3RHNmwwczMvV2tuV2FsWVVxMlpEZWU1ZkQ2OEdsVWQw?=
 =?utf-8?B?cWp3ODNHM1RDeWtxWUI1bG5DNVllSjB2bU1rcHhtRG5yblg2QnJVSmZoay9B?=
 =?utf-8?B?RDdFTUVmSENmZ2Y2M1FnL003V2JBZGpVbFBFS0V4c1FuUnNGRWR0bnlZZEpn?=
 =?utf-8?B?WlRXc2V2UEVWdGZncUh2NHIrYTVST2RxWVJuQm9WRzZkZkY5RGNyL1ZPUW11?=
 =?utf-8?B?d0Y3YTFibGlUSmtEYmxmSFlJQm0wL0ZxRDI3V3BMbDdPZ1hqVG9qMVlFdGcx?=
 =?utf-8?B?dW9rd1F6b2VNaWpIUWxJVDJmbS9oOTRvN1J0TGxTZGc3dUdCSks4UGJEejNY?=
 =?utf-8?B?K1dUK04xV05vM0tJdkVhL1JBdlFXTUFuL2s3TWNmMGVQcFloTGxHdzhPc0xl?=
 =?utf-8?B?ejBhSzFVTXhHNUZJTUVYMFZIRVZUOTNHS083WHQ1REI5T2g0Um5VNHF5THBs?=
 =?utf-8?B?aXVjVlZYdDRNRFZuTkxGUUtHdzYxWS9GTjZ0aWVzVVZCc0t1VnJrYWJpUC9Y?=
 =?utf-8?B?SERGeFF6N1ZlOTVENk1nRUI3RlAwVVBPblVXaGhnUSt0ZTFqeTNhY1ByVVdx?=
 =?utf-8?B?aHBORXFBNXVDeUtyOUl3aUpvK2pTV0I0aU1CY0JZaHBXMW5kcUtXZm0vZnli?=
 =?utf-8?B?SWdsbG41dEEwMm9KNWRweUlFN3BGMHVMUWFVeXZBTXpyckZaTUZLdjRncU1L?=
 =?utf-8?B?Tmp4bHZ5Q3plTmptemVwaGkvY09WR0tkdnAzMzdNWmRJdFpXWjlBUVZPeWRW?=
 =?utf-8?B?UmpQc01wS3FFbWtYNFZVTHdNREtTb1h1b2pxUXpmeVZsVmorYmw5V0Q3UDUz?=
 =?utf-8?B?bVdrTHREOWVLeSt1WVdhUzBFNS9VNnYrajVLM2F6WS9sN1ErNi9zNGlVWUVp?=
 =?utf-8?B?dzIyVWJ3UXQ5MjEzckhNcHpuZGxYSGh3Q3BBUDJ1c096Skk0T2J1M1NUMGtZ?=
 =?utf-8?B?T2V2Y3phaWo5VXpLQktWM095ZVpJRjk2dC9SMDE0THZwb2o4TkVod2J2L1RB?=
 =?utf-8?B?Vkd5UjRsSHlFS0NIVWZNSjZVUzlHc2RnY0FrUXRPaGpGQkNSVzhrMGtIRW15?=
 =?utf-8?B?MSs5bEk0R2MrRHA5dXpjNGpVNzRMc3FlSUdZVG9nODFVYlR3TStZRXRyWjdJ?=
 =?utf-8?B?V1dVUEY1S0xzYzl3V29wdVppYkJyZ0dXQ2lPVTJlbVFoajJud2NVRmk5bDQv?=
 =?utf-8?B?TDg4NlREV1Y0SjBOMENUbTREZGtZSVN6ZEZ6bzZqa0hIclN2NlFUTEVNZ0Z0?=
 =?utf-8?B?UHVZaTJNK2ttSkhid3RGeHZadmRGYjhMQjdxRXVyZTUzVVhsNjZXWWFiYm5O?=
 =?utf-8?B?SnlPeU9mNWFGcWNDMmw5a2hwNmxBZGk3Wk5pd0dHMUdlTHdpMEJyZDFIVlJC?=
 =?utf-8?B?ektoYWRmR3RWTURDV3JPK0J1RFltTG5iVi9MYU45U3VKbzgvR3JIdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a35e7c5c-5d41-4893-05d9-08ded82a813d
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 11:10:20.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5cc1JOxeON2cgBqBqOw4qd1RTTmUy4YYbw0BCg9so8U2583mm2klB4abctPQmmW3w9lfqYBu76UsyJk3PhYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6288

On Sun Jun 28, 2026 at 6:44 PM BST, Danilo Krummrich wrote:
> There is a potential race condition when two paths try to revoke a
> Devres concurrently.
>=20
> The driver core's devres_release_all() calls Revocable::revoke() via the
> release callback, while Devres::drop() calls revoke_nosync() on another
> CPU.
>=20
> The revoker that does not claim the is_available swap returns
> immediately, but the revoker that did may still be executing
> drop_in_place() on the inner data. This can cause a use-after-free when
> the other revoker's caller proceeds to drop adjacent resources that
> drop_in_place() still references (e.g., Devres<DmaMappedSgt> racing with
> SGTable freeing the backing sg_table and pages).
>=20
> Fix this by adding a Completion. The release callback signals the
> Completion after revoke() finishes, and Devres::drop() waits for it when
> it loses the is_available swap. This ensures the wrapped object is fully
> torn down before Devres::drop() returns.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260612202841.2577C1F000E9@smt=
p.kernel.org/
> Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/devres.rs | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

