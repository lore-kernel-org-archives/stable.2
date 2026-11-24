Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512073;
	b=wktE/bbWRAZwQ+dZliR7MoLHLXmKKUrJpTm01CzyNILnC20WHQ+QyPIbyL+96frKhgzn
	 gd50v/dkf5/dDtYXzMctdHyE43OvN4JhTYxVepGoF6E/50BkB/K3Y91niUt0LtsaLMICI
	 0OFZNDDnRI2wrYSYOzo5KuoNBzGFZocAzVc4L7cOthGMPjr57oG/GzuxXPVt4tYfQn3uR
	 xMrz3vTQacxiQcJlIgwGLp+iaUMFgrtM7Jjz4PTq/c477y6BoLCXxamMc7VozudIjMVwH
	 y+uFfmLRwXYLN5HJ+lonZyDBVcDMAj+Nevvc8/aahmgDCocEgT/Y3pY9MqCs85D/vPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512073;
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
	bh=qkBrPmFCprGgxvY5g/eOr+XGGjR7A66exCKX5wtywwo=;
	b=OU15xaqEHVQP5CJO5xhlidS6AwqE1qy2LOa1aU5cnVADjJnh5oMluHE5ZzYSLmajE16/
	 7BkOENXxGANUrBkS/y7j96+g0zhTygZWRrocBz04odZIz7pbgPa7B8D9D5iZ1t+RK/fmH
	 a/QZQXHREiWGbVFbcxc8MU4Ii3/ygMwbwEsERlRgbojHibtb5rvSYKp8VHNZ+Nj0FxR3b
	 Fa5HT1NqPTFejNfEiqahxRoKoTzoQEon8EK2SXIyoB8UKdZ4sNpER0nIccDC4twsctIBC
	 zn27h0DCdGhOFZfiHEzTiuPBxbK97elq6le9IiCkB/SHlOMFYA+JXDjck3Mcfbxeemw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q6WGH+b6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.0
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2109606A68F;
	Tue, 24 Nov 2026 09:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2109606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q6WGH+b6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUKa5lRToV5+QpRBZ3FnlAWIxYCFqLOrEahWVkz2RhMqpzItyv0S20CeCRbO+G2NAB/0YELAUu2Pdje/PFrk8xtQFE37M7h9cP99PScsVlJt7S2TqoNTweg6q+/aFMjiLWiPC2PXYk1L5Vc54Ddaa/9Ybij771fLx0E328pluCefnDytLAOGtMwweLdMcnjc4Dx/RcLalPdz6oYsxou1vT70V3ykW4Mp8KaMXZHFk4MA7XBHdEFnOaN0OQp7QnclRIgdRHWhlB3VugaMz6MKOOnpEfJXWvU+d/a6Kg+mTOGHR+F3rLLgYYyuWlPWrdGesSmbVfH2zWFzCmURiu0LVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkBrPmFCprGgxvY5g/eOr+XGGjR7A66exCKX5wtywwo=;
 b=aG1tXuB0DVI8Rov9pwIzlYZkf4jW0p8JHvdnCa+7wHB3Ii01FYetQS45YQ+H2ViZHGbG6HvyD3k4PKG4tGgEsM8ijzSk66jcZ1m7FD9djBimjMAYHODukXnCC52PwXbckKTh91kuUl62mMr8HGbcYBkCNTAVNjFSGw1NQTuOMX+R3dY1kOEPwFP4/qBmbgVxqwZ3L0y0bXhx3n9/kT8uzO2GITlPYk+uHioxIwigM1DhNM0Dmada/FXCP9R+hro9lNMyKARZ9ep4etOmkMMJ+dzVGeCpEzL/8IruI5NMBSZ2g7G4UD+NEeE6W8LLdqSjscYKDZmKL32MRMSBHr5KjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkBrPmFCprGgxvY5g/eOr+XGGjR7A66exCKX5wtywwo=;
 b=Q6WGH+b6mTcK1FboK4eXSSVYc5W3/PrP21dLlknAsPvnyGdA87hZsda9FkBzorpVyMezfv56FtewGsF5JS69l80bWjMDbMsUWptwVbECkpysblOmY/ripLStuxpiWnUamXP+2xF8Nh1QhQ9hC6YU08/FeNqafMj55QQx99rAms6m1/d+mOJb+ZKV/uh//ICyjgnQ3MXIm6QYki0uUOjM8HcCoA8IQVOg7Rv1MqiHCmAQOWFEFRFvN6V7fNXyS14hTkKsgGedFYllq8HkejEV3zJd1PZrQlb8BFrmkXOOvstEgOjHcxZl57ETd0BCz1D5tTOF9I38CGBPvRE1waUgqA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by IA3PR12MB870191.namprd12.prod.outlook.com (2603:10b6:208:712::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:21:05 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:21:05 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v8 6/8] gpiolib: cdev: don't report a failed line read as an edge
Date: Tue, 24 Nov 2026 11:20:37 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|IA3PR12MB870191:EE_
X-MS-Office365-Filtering-Correlation-Id: d22f0894-7ec6-4bc0-f54d-08df4a0c43f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cr4tRAl5tSOipOjn3v8QelsB/ScPQsL3gIvuon+1DP+nOz939MuV9ZCXW2bqrHzb61lJCmboG/osJWmkBhvmPOdWAhlrY2jg5RsrkIjuFqVMx56IfYu89515VLxs+MfNkELAXKDKpuISbGHM+UqkoIEomqAl1so1PCuuirQe8heERAjyV1Yyer37RZZTWF51WV9RP3cxACXibFdBoQBY8cwavmb9uw1Lx30Yf2QdkHz63hRjEEIqTT4VVQbwkbV+XhlEJfgpbvFmI/5GmVC0OLoDDU8D5k9MEcWdnKU2uHO9UKB3LN86XMFJDioJkGqQO2BFyT3dDW/WjsBQhdWAK+MbZhWlFcNF54Ic2h35vCFueiE2YXRBBdpslrlCPHtfdpCJ8WcIjsKQFr1L7l1NS8hxESD79XEa1qw315+DwmkrQOJ5+a2qC/Ga+jN5aIm9ILzRjeZbBx09SieGGSc+PjTNLEAWh/67FpLdaRDEQzPTdPZLD3F9vefT4QYiJWSvsiOXvp9rIvZCJMf1sRL146eDJrXpol30YdQkpM+2qGT5HqbTZCjTgDyTR0prYauAZjOOSyX1D6xuQQOpecFHcnMYhusXc0wnt7HE4AFH7HT5xL5jCc4vAWCBTWGQjbJT4qSwQ/1GLSLcRHVvJHOB9Qhfefi/LOk5cLUMB14TlAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N48hKgUAAUV0wL8bmYFMZa/eHUKXCh7LzrMGjWrfsPzMH3i9+ChnjMNAVa29?=
 =?us-ascii?Q?G9+QYNGh1jB3QyS5XWO6FKn/GixvPv9IZXzRtxcTqnXQDsFF+/N9ODYKO8sO?=
 =?us-ascii?Q?8ArFM+sPpb5aZM3Ul3yvn3leesK3StknkvZu6NLiOqJMpbrvAMAvlgySH4Rh?=
 =?us-ascii?Q?b61ZQabKGuILEyiCfUhQ2B56ORyU14UxFmbbzPwwUTNnqmG8cXCxBatSeWQd?=
 =?us-ascii?Q?/qOYA+07uciWfzuJPOsj5FaSIP6R9ZDwKfiq5yWHtm8hCWgtXDU7JxRXOFDo?=
 =?us-ascii?Q?WVvp5Da3il1W0xfyppzt19uU08VzQw2gLloqou0Hu90Q7JOtNbAQxP51eZS6?=
 =?us-ascii?Q?ylRQ3qKGDy5f6n1ch8rHBwXIxOj3Dbe1eyDb0wwFytHDaNarcz4JNnzbaWEQ?=
 =?us-ascii?Q?n2AeZYtq2FdWfqd971jRsWzeTKI53XJ9TYFy7rOPHs9v4rPeT0tyKgqMv7Jn?=
 =?us-ascii?Q?m27V/B2kSU9zP0yQdPEf39RoLVSdJL9gUlmpkvAzHkoXQRWnEqkrsj3zygZp?=
 =?us-ascii?Q?+MB/NVSMy8v8UiMeQvvjEJpyvea7ENN/CxVuur7UtvkRjZK46a5Zr95rvn6F?=
 =?us-ascii?Q?09oPsaFVxXRy0cU3LCB4T190PZ751JpnsBKYR9EeoT/Layvs40vm/MVXbKpL?=
 =?us-ascii?Q?ff+X0ao59wH/Vv9nb70Y06vG6fwnBCSX5kzrGHWNZ5Fi6EhKIAnzqMyJ6rlT?=
 =?us-ascii?Q?bkbmTvSegIm8VBMmDRfzHhf4155okCej/eWWj4CS4I1y3JeSWelz3i7C8/Jv?=
 =?us-ascii?Q?3/7vSOyLfECLfn0ku3PbL1MsgknSGkHx+6EwjtPNDv1lYWgDyhX48vmcldEV?=
 =?us-ascii?Q?vzIPWBv7ugcoALiHjdeua6qZmuj3j8al3UVS3j6rmN8pt+UYmzQdLXMDJsUD?=
 =?us-ascii?Q?Xe0xx2mNqmueU7Ng29Di4f33XKop3efI+9ZJKqEe0a3dJiF+nJ8OjS79EmAL?=
 =?us-ascii?Q?HRYsbbhfnQjhcVsMkPLNBXRLFGMimhUtAPGNbhEo9AkCOCPbo9qTiuahgmk8?=
 =?us-ascii?Q?UIyzh2NzJcdqtCSplWe4LDF9vpsqFlNFy4KaSxO6sUQN3KfJd2WHcl7e3b6q?=
 =?us-ascii?Q?pE/06K9dS9jN+F5Oay3POwPGdGvSVtUZ/F48qLsTvuZ3e1oPRydsvwai4rlO?=
 =?us-ascii?Q?cRv3cxpWhoCx8c8GF5dEfA39PmDIHmXicpFWYX8ndH+WCZE7VlvueFhBaBJm?=
 =?us-ascii?Q?vky1DDRTbVTwahVXrOtCG/laAZmNx9ww0dj4KJvMM4H0G6mZaBCjzqyGDzf3?=
 =?us-ascii?Q?c1Y+SADmGq1hYZbCwKFV9r2JkD/C2JUujdERtp9SdE57eyZcGMX6uCwpbJKB?=
 =?us-ascii?Q?u5UPtt55P72BqBcgxcYh9Lt39yRwepljymsqnpj+C83l4tOnb39seyfHbqHF?=
 =?us-ascii?Q?vtzY0aaiRkP+RGGFPWVtdElqqw4ByhYmRQOnwrWJYCFhsdv9pOFmFFAYzojg?=
 =?us-ascii?Q?daDqK9w2CM81T5joQeysfNpyUvRDvwflPmMyvPEgcWM7ID9UuVHU9xcfWgXC?=
 =?us-ascii?Q?wmKirK+npMFQWU7WJfNwPkHmjmkmYSAwi1rAlmRWfFlOm2aI4kfvmLMYWJGy?=
 =?us-ascii?Q?qKTMpaxZX7IYAr5uYebCEoNM/zNNFewTyFWcld+qHeDTQB8Z0V4MCsVWyJ4V?=
 =?us-ascii?Q?nQBXm8opcspMFn7x9oxEz1f3XEqP9TxGhYQYiFf6r3PbptpUQDNLj/Q4pVC3?=
 =?us-ascii?Q?tYjp74f+zFahQg4/bH641odoGeneilxWkZl2HOkHwJfZgXMpgCmIs/+LO5Th?=
 =?us-ascii?Q?okYgO+3/tg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f0894-7ec6-4bc0-f54d-08df4a0c43f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:21:05.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNLK9/5zkY3LPDkRAvcf2fiVE/aigSu3xMUHMTFCpAYzMONAYHPZGpEuGq/jstV/ft3WxL3ec4rJerAfwi4AyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB870191

With both edges requested, the IRQ threads read the line to tell a
rising edge from a falling one, and treat an error as a high level.

The read fails when the chip is gone. A driver's ->get() returns an
error once its device stops answering: pcf857x when the I2C transfer
fails, dln2 when the USB adapter is unplugged. Since gdev->chip became
SRCU-protected, the read also returns -ENODEV between gpiochip_remove()
and the IRQ being freed.

Drop the event when the read fails, as debounce_work_func() does.

Tested with gpio-sim removal (test delay in the IRQ threads) and a
test chip whose ->get() returns -EIO: both reported a rising edge, none
with this change. The HTE path was compile-tested.

Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com?part=6
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index fdcd315e776b..d829f7d00b5e 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -644,6 +644,8 @@ static enum hte_return process_hw_ts_thread(void *p)
 		level = (line->raw_level >= 0) ?
 				line->raw_level :
 				gpiod_get_raw_value_cansleep(line->desc);
+		if (level < 0)
+			return HTE_CB_HANDLED;
 
 		if (edflags & GPIO_V2_LINE_FLAG_ACTIVE_LOW)
 			level = !level;
@@ -746,6 +748,7 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 	struct line *line = p;
 	struct linereq *lr = line->req;
 	struct gpio_v2_line_event le;
+	int level;
 
 	/* Do not leak kernel stack to userspace */
 	memset(&le, 0, sizeof(le));
@@ -766,7 +769,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
 
 	switch (READ_ONCE(line->edflags) & GPIO_V2_LINE_EDGE_FLAGS) {
 	case GPIO_V2_LINE_FLAG_EDGE_BOTH:
-		le.id = line_event_id(gpiod_get_value_cansleep(line->desc));
+		level = gpiod_get_value_cansleep(line->desc);
+		if (level < 0)
+			return IRQ_HANDLED;
+		le.id = line_event_id(level);
 		break;
 	case GPIO_V2_LINE_FLAG_EDGE_RISING:
 		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
@@ -2007,6 +2013,8 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 	    && le->eflags & GPIOEVENT_REQUEST_FALLING_EDGE) {
 		int level = gpiod_get_value_cansleep(le->desc);
 
+		if (level < 0)
+			return IRQ_HANDLED;
 		if (level)
 			/* Emit low-to-high event */
 			ge.id = GPIOEVENT_EVENT_RISING_EDGE;
-- 
2.43.0

