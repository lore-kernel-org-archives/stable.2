Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BA4E73C1;
	Mon, 28 Sep 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609157; cv=fail; b=YZTQnBeEwq/Hpu8FVunG4yFLVdaCl1GlDHRYZlewK8RNBvojnqzMdV75WK68X3aHHLG2h+AWHyovsCYDE1w6A/zhNkOFALJ6B7yHzbk2+6TrbrxxH4z32Nui5fgdUCJ8NZ5t9Vp1kSr2OlIPrldIoYgRh0zdxfdYe6VkfBvHMRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609157; c=relaxed/simple;
	bh=FNcW8tYi5gcYoJN5BWK44GSKjkTy/ZSsvbbvTMVANlA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CCCD+q7osHAk3ABUxISGaWERZJ5qmYtfT/MviNtFMAdFytCd9/AqQ0XU4iJSbf1hyFkMO2fAC2BzJ7LrFMQyTcO4PnlIMPMpWLGk6FDGwAEJYq3QnHk+Tkm/QkMdO6Qa99fu09xhQAz2zdoP/jyA0wRCpLaAeGQWNVpQ6wetJV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CwpTY1la; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CwpTY1la"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGSlPfNMU3atzOwX7rRoiDsum79S49DzOkIMA2ae8DMlbv2PnZObsAXvk3o01gE5McHSoUojnXam9UZaJARjKk1qNwzaYNUTz2cFz2YHkwH5KKMLmYTG/NfoylLuTslhFMgFm1Tz5bKfDw5dXJGlWuNLHVApPmPlSV8GFu/zWXJFgQdmz/9jrsixP2qyceyeuzBzIF0VE2k/7NTHGGNXuMzalrGeVpdjeBFY0w2rTRXpFEm2l81hLf3pK6Q0Dp3ARFvfPlK3LpIj938cAQGjeOB0A6B+AvrfFxfS7qPAPx1i6fatrsCWGH0RYjM26jCR7NdJms2QA/gYy+OVN34auA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmBksL4s93Ij0mx6bDZ5mJD6NSlyYetLvjYdCMhbDdc=;
 b=N+pakEzt2VmwNbp4dZiXrviSITYJ9FaWk+xN9qE6G6I1agJ8jHzhlYQfq6lSsEQSh+MHyljcWqG+s/d5Hi3xW211os11yJ2EffN2hKDGhbsZjU9IWUusvbGuGPUzpu9q9bFmqwwHyqtIdc8/yzcPpvq8H2milTiTJjNbqrRqKI+znWklNhGPS84FnVnO6FwBJtlkXZcxtRNchxQkun1+t4mlWWEyEzaQPYKIhRPl8z1fUl72+bDGtY0ssWS3WUSqM9LT6n6xOSEzWlJXzuyCCzHs3t9Kz9Wv+avBxI9YHd8QbfJiEWphB0aBbyumtpI9/y68r2tHMmP0tQctT16w4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmBksL4s93Ij0mx6bDZ5mJD6NSlyYetLvjYdCMhbDdc=;
 b=CwpTY1la59lrtdIR9YtiBSsZ7RmvvSdroxo7XSoOmLz+tQQNr7m8V8+C3Qaje51626UV8IHpYJGBQXlgFQ7AZmgd1xy+Kp/XsJFhKtdn3RZvUFM+N9qX/D96iX4nKdckLdO1ooVk9PNMd2t2KL3YACgG+TN2ULzJhlBPnXqin1A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 00/15] NTB: ntb_transport: Miscellaneous fixes
Date: Tue, 29 Sep 2026 00:25:35 +0900
Message-ID: <20260928152550.3354675-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7522e5-906b-463c-68e2-08df1d74c837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PBjlct7qPIBXb4mEbzN/4WSzswLCqbEFZ/4ukIF+LmQ7Q9YwQxkJg7SFYkFYtHgIJ8M+AAwsmZhnEo4qCkZtIw14xEBcPdIQrqBmAoNirOcEXowN/Asdi4oVwtcFt4ihv5/oyvHHqYarenVKoeaNTN97GKaD0wsNgcnBCpsCfRKq8eF++WjGMg9iHgjmu0/oxP1UzPj/6bX7d2QK9YD9YDUMlc/CR+B3ZEqo549H96waNateWf3h6E5ihfRbI9o8hO4e/TG/WAFobqE5/yR6p9ypnIyeQ8rzn8NQ/8KOWQSO88zjDG+ps4CSarruteT/y2DyzmBRBor/l2EUMemlKtWsYaxvspe6jxPSWi4OTwrC6mTMpf/wCKy2dzxbfJY7uLBKAXToedm8UQH3gV3fJtnDcJNwXrrU17nnHdsLQyOTLaRtXG4PIfq1aPZ9PMEDMWhcbHUj4+Ojcrp78B3kOBtyWST504iwvHq9nb+DeKPszkZgIglz8ISph2wTHLGRsii0mH7WuXNUdeE+HzsQfuOXPJaqf+aNLiEC7P4viAix+2y+PaU4zM1xteYDwKEWZpMa7voZ7uHAZjv7DU6MXHbWDM5epUp9ypI+DArP9bqufpveXkD2ehROSmmB6d0E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7md/VMrbiCqkzG0HI1bUo1/4xG6l2GPzqPY+wBIQzwYW1ZKH7URWiNK+Cf4?=
 =?us-ascii?Q?3uM5H7P5DgcQe2gVKGyfrthemh+RgfWhyJivu9x+oYJzCtcLk6JBcfzTQiQB?=
 =?us-ascii?Q?lX0ieLjR59A+l0D/PzwxxmvfpjVRh1zFxVGSbyio2ciQPKrLElROZ+yJwqfV?=
 =?us-ascii?Q?rqpe6pxNEyaFROSrfWXlEJyo19JaKxmSEhGBY9TQ9UCuSQ81ikcQ3nAqYJL8?=
 =?us-ascii?Q?RczUVjLhZ3fTirqlieWmvVKj4P7eQMEJDDohg4jNZmVXRzXMqaA8euEVlnjs?=
 =?us-ascii?Q?Bn7P5S4bFRHgj30kQWF1vDdKxaXdiVQiYiqQPJ1qeBruapbtGn//MGjrE+RV?=
 =?us-ascii?Q?50J78rKoERN1s5sBR2NAomF82WhjSg+HD1CztAKBItK/4wNrMNrVzBHWKg+k?=
 =?us-ascii?Q?Zs3HPdP8Fom87WjuFCg3WM21mQvSHTF6l9KcROdelLAKBNAHcZiNoH4pqTKk?=
 =?us-ascii?Q?ajWxglvtTxScaZzk5SYDOdkRGYCeuPUzatdxfPk/jHtmnE+klP4TZHYk2jip?=
 =?us-ascii?Q?OLXFKCvgytpxEQ0C2LkYEi+A3xx5Lr8ZFPN3EezGM93JwTcu8h37YhWaUHEO?=
 =?us-ascii?Q?JL+jfpNutboh0BkOASlwRiM4V+UZzioNo8tFzEF8Oe5+Eyy96FKdWFuOMwlR?=
 =?us-ascii?Q?bk3/hMoqYpbHRJW9lHOOwL285NIEwKtzdjzrUZdbntahmf3jkKK+wxGDQy7K?=
 =?us-ascii?Q?e8vUcbrYmgXTBR+j4UVAeA48kwD7NV/Wx9ApHaQOT4Ix6+ABHdz5pPC/1hh2?=
 =?us-ascii?Q?ZvIunUkfB6p57MkqCHtrL3zhtrCYODfhQl3B20Uz6M14wQ3FGHXgZVl463qL?=
 =?us-ascii?Q?F+BqAGqkprGWnqdZKsnTOUvDWIZwnL8y+KLxohrGR75pfj+I91jXL+oxAWjV?=
 =?us-ascii?Q?SXZ+jmvYLlfY9TBl1Eu/U05TAb4FViKyB3YqSNNStafa2V8Js+rKr066HMNP?=
 =?us-ascii?Q?0dQ+NhjiHvzr29DQCwQQG4FxzqrmZYSNHLEgLt68ypnQLjRz3gjb5oLJV9cG?=
 =?us-ascii?Q?vnxeeZpWbLYHqBZHLoVHafthPzy/x2VFe71GdEs3mvox+3ZYNGGkJ5OTuspn?=
 =?us-ascii?Q?FGcsU48pAwi6Kzzw5AcHDsAfWq5uTvcS6x3Mx1AdWaxFKsbljWMBw+S8zHUB?=
 =?us-ascii?Q?Rs/ZqA84sbB3jLnhAFi3Y//JVTkxgWkkMyQ3MjT+wZI4tSkoTY+q+fCgdgZz?=
 =?us-ascii?Q?TQieKblC1Ki+Xc0M0VveHU4wCVoXHHYgOk69L/zJYc+LY3FmrP+5135WJamt?=
 =?us-ascii?Q?4TQnENo9KUlszf97KluSH8gmdyq/i2KmDzlvyL3UIaO0dVgoedDBdaeNSGOS?=
 =?us-ascii?Q?Cc9+8apDLEuaThXQ7ISu6YItOENMN7Kt3cjvZX+MktQacjQmgPQbtSE7DcVk?=
 =?us-ascii?Q?DZJ5zPDlUxt1Vo2hVH3K9dd7YGDaeeudAFaMVRet6meiTNp6BFozuGsVIoWD?=
 =?us-ascii?Q?oS941xziAJxdKmzfms1YVnGTGCfhlStjiytmxNt5UjXXrTCFQO52fJhEM0xT?=
 =?us-ascii?Q?Q2H8wqzrrwRwoiv65PlISgqTb9PlDufKsjoOi3I5xB8Cx2bZg5/nrb20DPbJ?=
 =?us-ascii?Q?6BVMKwbJh82kiuuM0tKgHMI+xnFjSFMNh2Wx4dL/5KwxFhXr6VLaYf/JjRku?=
 =?us-ascii?Q?rqjd9hMs04y4bqegtq5ZezG48u213igdY/cUmaEsGYL262Y0vcrJ5AsY8ul9?=
 =?us-ascii?Q?smrbNWOuqw0+WCkSHcnPq3f7aDJuxL5tRl+KNiZ53O+361jcFwSTbtxqveUo?=
 =?us-ascii?Q?3UlBBg9V4zwRU7dvNu2aq6P73vk2L9O/nDe7XasffyPjdymXpmec?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7522e5-906b-463c-68e2-08df1d74c837
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:52.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYDPQf6OZtl28e7sP+geW42DWuGtwU8s1mk4023DhFdA8WPbawBy4yuAbm0KbB8d0D0ePE5hIebkVU9uBJBKsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

Hi,

This series attempts to fix miscellaneous issues in ntb_transport. Some
of these were split from the direct TX/RX series v1 [1], as they stand
on their own. Based on v7.3-rc2.

Dave, Frank and Logan, for v3, patches 3 and 6 don't yet have
Reviewed-by tags. Could you take a look?

Best regards,
Koichiro

[1] https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/
---
Changes in v3:
  - Convert flags to atomic_t in a new prep patch. (Frank)
  - Drop the redundant TX credit assertion. (Sashiko)
  - Collect Reviewed-by tags. Thanks to Frank, Logan and Dave.

Changes in v2:
  - Address Sashiko feedback, including regressions introduced by v1,
    with new patches 5 and 10.
    Note that to keep the series manageable, this revision does not
    attempt to fix all the reported pre-existing issues.
  - Add a fix for client removal ordering (patch 14).
  - Reorder patches, moving v1 patch 4 after the fixes it depends on.
  - Add missing Cc: stable@vger.kernel.org.

v2: https://lore.kernel.org/r/20260910040836.3792333-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260907142429.951930-1-den@valinux.co.jp/


Koichiro Den (15):
  NTB: ntb_transport: Remove the device debugfs directory
  NTB: ntb_transport: Start TX offload thread after queue setup
  NTB: ntb_transport: Make link setup flags atomic
  NTB: ntb_transport: Avoid deadlock when cancelling link work
  NTB: ntb_transport: Publish link state after QP setup
  NTB: ntb_transport: Avoid losing QP link-up requests
  NTB: ntb_transport: Clear link state before QP cleanup
  NTB: ntb_transport: Stop QP work before freeing a queue
  NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
  NTB: ntb_transport: Drain RX tasklets during link cleanup
  NTB: ntb_transport: Wait for RX completions before resetting a QP
  NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
  NTB: ntb_transport: Clear QP pointers when freeing an MW
  NTB: ntb_transport: Abort link setup on QP MW allocation failure
  NTB: ntb_transport: Remove clients before freeing transport resources

 drivers/ntb/ntb_transport.c | 244 ++++++++++++++++++++++++------------
 1 file changed, 167 insertions(+), 77 deletions(-)

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.51.0

