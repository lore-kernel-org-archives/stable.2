Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE444E66B;
	Fri, 11 Sep 2026 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156351; cv=fail; b=OUW3XR8G/o0BhKNqh8UplSHs3xD8N6IG1lQf3dL8C5k2PnaFVyHpZD0KZYwjzcJFUl3wxBwm1mZ0nCYXo5e/YYkIDCcf9VvRUejhcQL7PhUrQxr/KfMyOCvfNklEvDat/3pbwY9kpBGX0Mcxr5YZTnmOmpNoAJ/cx4VWeAtRrQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156351; c=relaxed/simple;
	bh=dBPCTNLmFeXm7IYHNm+CU04JiSiCK0TsBcDsVy7R9n8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rphc/D/VSNtzD6BMVsw0lEO/Dcf7zkMweRV+CmDBCUqyu6tqwMwfh1hqwYJKG02S+wkuJCSiSE+qGlL2YoZwtsTjcu0E78P6n6oBVzu1xqgZE4hahk7X7vh2bz8vhrsStxa4/HkGm0v5P4ctip44/OViXCdQXE6WIigcQsGJDWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MpKjoO8S; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MpKjoO8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRuwJ4a0so6Q9Wx5661cyutxMbJIh1T80m+vlp/CH1F/efs9srrNuavPotTvNLxHLTkAJHh9CjZAz0+n1A9ny8LLwYyz/FXTltg0UrWQSfXvVePigL1I2452Noeb8x/4LkhU6mlA08rb0sjeXFGVFoyJFxAPETbNcqft6vqho9dGeh4e/oLAhZMeHtF2eh22ZbpN66sTziKE0v6645EYNsZrAnsLzwlDV3WkmqEzLMiKrSNCJv2mGYwJDRdQdO5oXNAK+2mQncn7kFdQtJ18i/bXzWbMkLYU2WVfA+X4b0/1vt6RK/anjTg1WotDztQKlnULAvvkFvC3Fr5oIQBV+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfxTXL21cbi2bGa0MdQS3KynUC2XVHyRaHt+2lbcD1Q=;
 b=in2evpsmlIHHzO+1LZ9+XKND69jM2LiFOcKRgcRnLPxEIlQNOEEIqGC1f4bq9J84IHHBwINtt4kL/f31znqycOn/kRRqWDzcphNOb/uiG0naIa1ug/Z4e2BYQ8HJe5CLXAe+rxLVI55gy8U0XHuNdRMoK6ikNKx1yYDRlOiUx4nUtCuFbd7oGYy33OiojaONjAoQuiK9P6TNMc/sjxx/AtZDXKzXj4asoc7LAEw+AA0jZ08iXxFY9b2BpdiMbvWX1o1I3OdEjP4heCePRsJ9i3r+e7E/qZqFo/17o6yLwinqOAKUx7+lIGv+GJrn40pXzXaG+9PSsb4/37B/S3I5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfxTXL21cbi2bGa0MdQS3KynUC2XVHyRaHt+2lbcD1Q=;
 b=MpKjoO8SiNiJj0SMdtO96/xw1n8tEdvQxW5ajuQqeB2UCZ79vgI+u0UzoMQjophNoFaTi6rinHdRrq7r3dRB/GdRWwfVBTdfmMCYrzqkZRpU9NHHgKpHgaI45qojfpyU0SF1+FNjxaXMd61wUUWgHeBnlRwmHtvD4E6b42KpwMFJCxL2CEo6bclTq/gO50ITnzSSaLJapDqR+cXbVCfDLyYJ/zLO7bknnwJNKErIsNOioyor/Ctm647gWJBj00vx7LB33fgEAi41PC1QISeu95cPM5rC31jS66ZLaWlQakLgmndkye2o7qXtmVadOZSeSIAOL/iFac8MyXZ5cGZD5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Fri, 11 Sep 2026 19:52:12 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 19:52:12 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH] rust: allow `unknown_lints` in the generated bindings
Date: Fri, 11 Sep 2026 12:52:09 -0700
Message-ID: <20260911195209.442715-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.55.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 34462a3a-9f98-4fcd-5d79-08df103e2bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|18002099003|6133799003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XReVldijshNpA4BBoaVLVej1Vct1ngLWZVFbv9LLeJOX0KY5olBkqXPMP/DkcnkupbwY3aqWJCMQyZw9ISnP14/UXix/hX+Q7xslLjeEdca0bGtZf09Ikvuw89wQhX1fGJNRaL09A8lWoYiiUz2/9U7e9WtEFhV9OX5fxgEAYbRt/kbnpgAkZU+o2QkzjOyjYKpVARnZvlZY68DUPaSdef9eWG4qV8bhTGbMqTwuH2YLrkFJPy5Yfx5RbuyhdmwYfThYpD/gitCZMZ6wP1gLFBoqQEyZ5yiD2l4XRUxbqK02dLTZQgFTSIQiJpAM/KRebqc1qGDtXT9XWVqhS2RqzJ0h4keiKhEJrBBwQ8HPMoH1NstOzdGAX3OmFxq2CFMhon5HwOm8GZCh+RNkL4N3q9SpgDYDfXR35NvoL7tPyx7+kXe8sn6X9KlmMn6oNQo3DnqifojszK9OG1YSQ3X2/xbfpeu2BO9jsTIvQUvXnzMQZoiiB79TbTJpq1HbwpMxtQZou8iMLQ9AJDAlRD2qB9gV3DZ1PJCmhxd+uiD6rd9Kr7vmOntVa7RuLFwOdqmjZ4OjWfbpOY4B46bLhjWAN+Z82nRW/UcRw40lLBj4WWTHRU0nGpKqlojmzWACrK3AwgA1qEn74QYYwXsDQxN3P0WnGR4ibsCwfg3skoSD/NI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(18002099003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nb3Nf58AcKOkE6GXxYJpnkfc8/HP7o1U25NTHLkGxqRIFPgP85+pBkiubQIq?=
 =?us-ascii?Q?gFuNFroc+lCUsGopRbQkcYW7VLLECrdAt1LemfHll5dEjYOUbw9lQsSE5GbT?=
 =?us-ascii?Q?tKxQNWxrTUxc0K1RJGdFJuE5Wsuhnb/4wmQz1xSmlN+a1ENREIY9FWBFmKru?=
 =?us-ascii?Q?h4Jnv8l7ECJgg11WRluV17U9uFipj0CIRYU+7Z6/CmCqaYehWzY4yRqLcmPP?=
 =?us-ascii?Q?BuMR2Z5ABDi9NvNxZn/PNMggRe8pa3q9jB9NpVXL21LGUWciHVxzQDsVfH6P?=
 =?us-ascii?Q?zUrnq8GstWuwa+udF/ttDqpxlNZnjieDrVwpmSJwzyOQBmQY3HmZrCDG5KBb?=
 =?us-ascii?Q?TwCA5gCz0c/5Sxk/I37gwrCwcDJXHc3/jaaB6BZeEMepdds9GQyK7QZDd1KO?=
 =?us-ascii?Q?i6Ii930ytPyjn45oDYZ1DNwIitpWY/wge669v2eVEgMVp0lNlNapbBuWG+xC?=
 =?us-ascii?Q?MOYX4W6Nbvy282prx2m6xlN4jP0zUizlIy1WWkB1ODIweB1lPVrdlqWQZU23?=
 =?us-ascii?Q?dMhf436CZcXWeGgncQt2CffoCLWJ+XdvGJjlGmJ/A0fxQHbGuEKKpeYt7/f6?=
 =?us-ascii?Q?Rd8h2XcLiQ1PfLvkLHeKvWVlfQropeWz6dEz4EKjPtOfdgnhqp9aVWpJNvQ1?=
 =?us-ascii?Q?/Ouz9SGJOojcDco3WmxBkk5q2midnS0CN22BjANNFNsirq8HrS7MnZT4V4V+?=
 =?us-ascii?Q?xU0Wvr9p0W3hRR3Ukn8a85mffC2Yd7dch5lXRr9IRr3bP1++vJ3/HU5amQlD?=
 =?us-ascii?Q?011O0OzglwhQhVwbfgMHS00LSthJ3DyH65PzF0fcl48oS5eqSxSM89XwqVkU?=
 =?us-ascii?Q?klT2UEDmwVp2VzmQLL1mAuwQqwumkncn/9pLJkuLB7yupnyknhQWIq+xlr92?=
 =?us-ascii?Q?DldqfuP8DVi2r0mP8XQ7ggX3m/s7lnnX7kWF1yRIE5gLhFj+BpGETAgZB7yz?=
 =?us-ascii?Q?vnTP4iwZ7wTfg0PGTjdn6H2AGwK+6vV6kC8tyQmMMOIxHamwsZJerbaYvWX7?=
 =?us-ascii?Q?E1Y9JLdCKGlUrrEBdbk4qJAt+gdrF3vx4v42c6OdcvyOprg9qE2jcYCHZF6L?=
 =?us-ascii?Q?6zYm2CGlcYsf57HVgQ/5k7guLucWM5aWQPzsA4Qv4jT5jit8UsEu+5/1fOoB?=
 =?us-ascii?Q?kV+y4JmONQp2oWS3DAuhT92sXYNxu5h1/CryypGWcKHyCnnOy7VFMa07CoTB?=
 =?us-ascii?Q?vFmd9A0fu5BtdrffAUT1Z4QIca7SxqcwZ7+i1TB3cwCrvtd9aBxY/JOQeuJz?=
 =?us-ascii?Q?dy710cIU7qXIn+LJxmaNQHXnGKtoylyp7D1JVIiqAjTA+g1tDH6XfefmkysR?=
 =?us-ascii?Q?isyZk/b0HZBDmPAYpka/hmTI2iTTq/jxyMsUa2OVPq3y9Y3wTaZQd6rxNcS8?=
 =?us-ascii?Q?U5vytko/8i6mmn+0Sf5PXGAR2H6xhNLFeeZgoAcrt4NAugELBSH8Fpl3MoGY?=
 =?us-ascii?Q?qYSJLhVj5PBoFveLCsnMZq5M7IQB1C0GgT4QtVXgHwoNWWmJFEH63TL1Y3dT?=
 =?us-ascii?Q?dbP0ANT4fcIgLdxHZELtO+ojS+FGU1mrSSfme4vvzP7rBMLq0+2Wm2838x41?=
 =?us-ascii?Q?NN7HCvMqh+9VNRqNEiVnyJxcGPUJUieJMZ6R/JKwvQgryiEbwQYUQcCk67Ln?=
 =?us-ascii?Q?EnyC8j7q2rcciBnlmWRNZjvNC/Pi+HduqnutGLpYUD2wJT8855Nn1siO/vTM?=
 =?us-ascii?Q?B6TAfgwsBOr0xxKU2j6nvyKiOd6r+KCiXl+MT/BzaGOLWwLwx23/YWR0y7L3?=
 =?us-ascii?Q?po9rkdz4d13UXcKGjuJ06yrNBEBpWfc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34462a3a-9f98-4fcd-5d79-08df103e2bd2
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:52:12.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYjgAXQsSVeO4vD+tHfa2Fj3vzp/fiXQTyPrqTlhyQYI5vPrCTl7KRlXLdobgqRzuVkVWBhR9CyZhQhFy99plQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217

A build with bindgen 0.73.2 and the minimum supported rustc, 1.85.0,
emits about 12000 `unknown_lints` warnings, all of them in bindgen's
generated output. CONFIG_WERROR or W=e turns them into a failed build.

Starting with 0.73.0, bindgen writes `#[allow(unnecessary_transmutes)]`
onto every bitfield accessor and constructor it generates. It does so
regardless of `--rust-target`, which rust/Makefile already sets to 1.85.
That lint exists only since rustc 1.88.0.

Commit 7129ea6e242b ("rust: clean Rust 1.88.0's `unnecessary_transmutes`
lint") made the kernel's own attribute conditional, to keep
`unknown_lints` enabled. That condition cannot be put on an attribute
that bindgen writes.

Allow `unknown_lints` in the bindings and uapi crates.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Assisted-by: LLM
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/bindings/lib.rs | 2 ++
 rust/uapi/lib.rs     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 812f8e5a08d5..a3af57d7d137 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -26,6 +26,8 @@
 #[allow(clippy::ptr_as_ptr)]
 #[allow(clippy::ref_as_ptr)]
 #[allow(clippy::undocumented_unsafe_blocks)]
+// `bindgen` emits `#[allow(...)]` for lints newer than the minimum supported `rustc`.
+#[allow(unknown_lints)]
 #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 #[cfg_attr(
     CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 797ead5b5626..361b490acc25 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -23,6 +23,8 @@
     unreachable_pub,
     unsafe_op_in_unsafe_fn
 )]
+// `bindgen` emits `#[allow(...)]` for lints newer than the minimum supported `rustc`.
+#![allow(unknown_lints)]
 #![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 #![cfg_attr(
     CONFIG_RUSTC_HAS_SUSPICIOUS_RUNTIME_SYMBOL_DEFINITIONS,

base-commit: 3026c6e4f223bdded6448fefe53ff85d9cbe51bd
-- 
2.55.0

