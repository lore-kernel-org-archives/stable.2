Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794291204;
	b=gjnWn3+/Q/iBH7xLO6nRu/3a5pnMunUpLxDq4YHFwBLMRIZDys2AB6FQE8NtFT4+bu8h
	 KRSKrgXs7I3/JppHuMVMuOF7ntebdePVYRG9A60JZ3VSRmXJ0tsoe545sca1Bym9msGyO
	 HID5vAgr90bnImOYsoog0KqhdvFXqJAvF13Wz5BRtsDz91QTswoepKMlqDQY9FG5Oh3Fh
	 chrlZ5/lrU5SiikLVjkrwsljjlL+/4VF4+gYD9jS1KlQcBpJbqITGORGiwAe+DQDewaFx
	 h6JDwp/GexMxFgFJxZ1nvrCGtk1/HlcHx/nD43hEz/LNZowG5p7gIXzMcBlDsC5bjxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291204;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=yNICF1ZpLg76f7m9HNycyafMdQwfCqA8TIvcqyOW2GM=;
	b=EeGXy84ux3vRvj/IcUyhCfACNIwXvS5a2JAH1sYrNlRMuriRcjlIw7XzqVAsxWzLm3bG
	 QB64R4RzotzP2xtI3DWnytBDDrQWXR7E6sS8XdUjFJVGBlvC1dZWEZOAKtylGSEetyu3S
	 AW78erwJLAgZzHATJW72eTY3qzmLh6vBGaot2adP9I+Nw3I7mXOrpDMrJNqMu7WXCXFEW
	 4zp9CCfzxNoWzy6iMzXXMLRp1AX67VS43II4kuCG4AG5L7zAAzJ8aH46Pv+mPrueHfPFc
	 HP3gpQfizdndUHQryPWsVfRGa2R8SqOh63rSxzrAj0PqFfr7J9GTS1EY2cyWq9H9otQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=K2HF3Fph;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.29
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3F606A33B;
	Tue, 10 Nov 2026 06:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF3F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=K2HF3Fph
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYq6/OATTwxSHl4ZJxrSCt3bH3PKZDG0XJLBmQZRiNzctkn3h+Si7KVIICeIyyy+gTBXX2hvowPEBl7i8rZt5sqmy6wFmIKVC35aWrkn8CZzkdcq7nzq+Os/oJ1nc9EzXtIMfBtfHIOVYNtoYEyc5YqFMn8+88b0tjgBJFLAprobOyG5MBaYfTXrpDm+T6dkZDRfva0agC3YZGE8f42Xec6vXDGiMf0ugVGq+yB5lRdgnX3wjHG/EeS0FsXPQliEUF1a0TLMnB7WymJrlPZN4u5bL5xravwM5myrVUwmwFf5w2JJx/AVj1tHkyzXVkFv7v3D19QPuxfPjd7mUN4QyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNICF1ZpLg76f7m9HNycyafMdQwfCqA8TIvcqyOW2GM=;
 b=I0TDE426dWfdm1k0AtY6K1lEYaXCw6hCoHNhtVDs08eUS12p1/+GsAOs8OmMVHl6fS7qQYqd16UymDRo4Et+7Bf4AGpFrE1iJ8e9y6B6LRa34jHVypNja7ZSFD3UK07KkwZmat/qJdkFS1V8qk1xhaBcM+WxfqjQiCWLdJ5Qls1Qxq7uDhxQi7+/saNUNUhyykK9+cCZt5LwLJ6pK4mtFHurkzSRPXxiobBccFb+DDYLx8p/rHBs168levcnKCHrELQCAree2/YEqTVz2jpIlOqu7hYvdcjJnkjcLXwz3OXSqQZQ88gfw19EqdY0yEA6XnDEI2zgzJKy68+sQ70OZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNICF1ZpLg76f7m9HNycyafMdQwfCqA8TIvcqyOW2GM=;
 b=K2HF3FphTeWV8DTmk/byEZyuy7w3tsYKG/dOzxREiXNbdpU+ELQB2ZVaPOJqBnWGcAx/e63dEaurBNWmQ1iruGxPSQW6QaZmEM5M+pJyqTichh4KCxatfcbCHbe7yykXz7kqhGJ5lHLDhVjTTNGKBQ67a31uCHAuqCzmwAQqxtmQLlWv+8v/eigbTqfPP31vN9Qt9FWqPtn6E2zz6MmdyvHeuZQoqCJBaxK0EEXPyU6CL8P4tKvOY/16JHPnfINMInh89nrW7sO0IN6gnRhs0gXYkZFKjctMKgcBe6OVwNxS4p3svjWpguduQBLc/Cvm2oMGwvUrInEFeY5eOml8VA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12)
 by PH8PR03MB989187.namprd03.prod.outlook.com (2603:10b6:510:3b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 06:13:21 +0000
Received: from SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80]) by SJ0PR03MB6581.namprd03.prod.outlook.com
 ([fe80::e335:b86:cf59:8b80%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 06:13:21 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] clk: socfpga: stratix10: register the SP timer clocks early
Date: Tue, 10 Nov 2026 14:12:40 +0800
Message-ID: <139e1280180f614bcdd06157c6b55116b1fd3fd5.1794287244.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1794287244.git.adrian.ho.yin.ng@altera.com>
References: <cover.1794287244.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::9) To SJ0PR03MB6581.namprd03.prod.outlook.com
 (2603:10b6:a03:393::12)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6581:EE_|PH8PR03MB989187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1edb0c-af22-41a9-ff60-08df3ef1b8b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|55112099003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	rtSYqdeyaRIlt+rg0y84RKOr4UCY1zl1aR/o298agtetJl8K2Qlhm4iNlmDPWlQgGzglA4z0vY5/M1SZrQOx12GeOXIFbzWO20RPH7UU+PBX32eA83SN54rkz/YXZQyZxnrLxqJZZuoP9cvpbhqW4QRnIWTYsLPjkdCJlF2wOlCisb8nXAqJSIWjL4LvoiQ/UFCuyp5p7nvFujHr59yY1FC+ZgDcBVMqE64/NwI0UOAqJk9uUHC4juDj/ccN05OtY5r7TeydfZEcVugasvZz9YxbNsooxYWwz1SEwRcED8yqN3+p+7AFZ8/dxuV2D4uqi5CelsTjKsEBrQRGKp57tjkPWEGLFXlzuiUDck1lP5JnWBuulpCMAs7lHsVK8THo4qUng7qjEe6cZ5U5lT7bg114UquZc24C3wOlzsvT0BD4t9dHLQcBT2Hfhzgim+Iaj9RFh3+BNXb1j5aP9RBiowcvAxEZR97jSZbdURq5r3qDPIVUYDz+Fk6kQMkVZoZdDWD0gGKs+B5tB+Nvn042M9BejYPCJq4ymuyTvMSExGEuMATIuxg56L+asemAaYtV2oSSzKVVrucNDz4lv/cY1K9P2SEC5OMVINb0Tk6nZ61vR83jj7oVA2aYlfMDM15B/0UFWPvvXm6sy5DmSKTo655A0peY0QCUOqkW/9hCmQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6581.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(55112099003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?51bxopERmT+vH4FfZVh/GhLIudR4QgrpMqYwj9PFsCutyuGRUTkr0I73O7DF?=
 =?us-ascii?Q?Kj2VqVMz3wgitsDGeeQXInBRDb9hrbhNcS5R+lIcmGWUEi3Ru5MucUt5DXBU?=
 =?us-ascii?Q?O87SZbkeQXYx8ImL+njaQh4zq3tJNPkk/J2xI28qpnhOjThqwhx+8WwU4m2h?=
 =?us-ascii?Q?6Wl/1Iu0V31FCIbJ6L4CarYk2rgBnhM0HP4IYJ4X+HpxszoAG7b3wU/O0g6v?=
 =?us-ascii?Q?cvNrZs1mWFYdbfMtbkalkDoYsWk5MaQi6PaZohlc9FHhB5/J7DiwOHXFywxf?=
 =?us-ascii?Q?a46mLsKHe5ceX3nJVD3Y943O0+oZrNOFOyfgVrtFCZd3QGiCz8q+Zmh/IqXm?=
 =?us-ascii?Q?zenl8ZU9nk8IotD2tjD+Txb4hHXmtDZ803IdD+qPoowdO3JUx+h5B502V8Zx?=
 =?us-ascii?Q?yW2SuiXB1104HyA9d+mGgY+BJ3MYrzvraDgsdNqhFH/j9a0XIcc57WhE3Dam?=
 =?us-ascii?Q?9eENaw25C/yX9CCo2LAGs0+/bj8pknCleYvMMMRznpNYgvAAaihudYU0hMBD?=
 =?us-ascii?Q?IUe49o9tLLTukFVSKUP9pLXx/eDl7gOcifE6GBBwF4AfPb5FAXt1LD8mZtdE?=
 =?us-ascii?Q?1+2hTlsOc/jpyC4VqG44XXAhc80y4Agdg1HBiWesH506YsumJpNkdhkEGDSM?=
 =?us-ascii?Q?/1jRFUNJiFQIHYLQyQyRdOkfN5tdOh4X9Wh8OAr7iRrGjUFSTYusiJAJxO6e?=
 =?us-ascii?Q?waYmZOAiSQfU0cnhHrViGQOGutLWwt4HHUIE5YZd/C2E569QT+IWEVNVztY1?=
 =?us-ascii?Q?cU7QGWqbse6/zmZxNvXrcsH/4Dl7v6TUyqUtaGnnE4nk5nlLkOuANTZCUznf?=
 =?us-ascii?Q?1KnYm3avb62x3nv5TJhrR2jTmIjW5eM/QfRwg+bE9jI/DT20Kc7TVrWV1ZUE?=
 =?us-ascii?Q?k0WNjrwghqEidMvXxdTjGlRWVczdO1SONaEO9pNM1Kz3b6bnliEwHwg7qHC1?=
 =?us-ascii?Q?xWiSqXSKQmNYrhDtfcW7ZYgzJUzmqCnEmz7qWaT9v/B/jS25XPmhBiwZROEq?=
 =?us-ascii?Q?brxfJH1+Ft3kGDTSiuTjedhTVqF5Kx7djBkaut04zuflh4AJ2JEFQpRSEzf3?=
 =?us-ascii?Q?G7d//eb9WQW1vkvhvSg+yliVhNjzTiW+0G9sS+hi/+TpyMqX1XMBYkmZoqHA?=
 =?us-ascii?Q?6C4GoMVyxgnHFpdWsjbXopCM3YzE0mGDLRSpHY2CLDTw+V1CLRTw93XFzyj/?=
 =?us-ascii?Q?Kj0Av4M7JRiZbSxPv9Juim/WGggDzzZmkrtL1nrP7jvim7Xlf0oRY6Ue53mq?=
 =?us-ascii?Q?gTx3gl9/SXMeEzmiY09m9ULbGu2vIlWlbaJMWNc5Y2z7xA6pwfASyuGcZ6eF?=
 =?us-ascii?Q?LqGMHwMGsNCWhd2z8kltIaROT4oUKkB0Wfkg2uDj8Ot3ClNs4G7AGLoFXM72?=
 =?us-ascii?Q?xJqE5RmI4erHs5ohtpwfurC1XzLu7MDLia7thUQMgczjEBREjV6+2DAM1Li1?=
 =?us-ascii?Q?ZYEwOPXB+DFmLV8FddOaHeJBfeA0WCstbBULoqe6JBFaW25R7RDzYARn1cyK?=
 =?us-ascii?Q?Oy2qZy2nvuinmfCnoWFF4F4FqEuXIXGNI9WEXDX9hgFWse0OEdzexHDZj3sr?=
 =?us-ascii?Q?2pDqHpS9YKShMXukyYdHmoNd+6wXWAJLI164S9YeeibbcnlFEyF2rjZGKpWj?=
 =?us-ascii?Q?Ak/VM0owUUcNC/ZJMttoOWG2qXgN/9hX8E81NlFuTnEyiyzkj6T0lKqmR1Gc?=
 =?us-ascii?Q?YtazyqcbmXDaSPW9pILxC0rZZoLbY4K0g9WJLSpSscORonwv/lN/XKLldQOl?=
 =?us-ascii?Q?yGGs8iQgjmUKHcqL2a4SizmDyiDZkTo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1edb0c-af22-41a9-ff60-08df3ef1b8b1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6581.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:13:21.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPrdQuz6y1dWbCGVpm3rLQvm+UbtjZQZe+zu/gl0/L6C67p+AfLQd+vK4L1XiT0ZapGp8EW+lnjIxFx5EoHXZwF7wXThEqj66tlhAIh1S7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989187

The DW APB timers are probed through TIMER_OF_DECLARE() from time_init()
and cannot defer, but the clock manager is a platform driver registered
at core_initcall(). The timer's clk_get() therefore fails and the timer
is never brought up.

Register only l4_sp_clk and its parents (boot_clk, main_pll, periph_pll,
main_noc_base_clk, peri_noc_base_clk and noc_free_clk) from
of_clk_init() using CLK_OF_DECLARE_DRIVER(), with every other clock left
as -EPROBE_DEFER. The remaining clocks are still registered when the
platform driver probes, which reuses the early provider.

Fixes: 07afb8db7340 ("clk: socfpga: stratix10: add clock driver for Stratix10 platform")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 drivers/clk/socfpga/clk-s10.c | 146 ++++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index b4bf4e2d38e1..1976789b5166 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/stratix10-clock.h>
@@ -188,20 +189,36 @@ static const struct stratix10_pll_clock s10_pll_clks[] = {
 	  0, 0xe4},
 };
 
+/*
+ * The SP timers are probed from time_init() and cannot defer, so their
+ * l4_sp_clk and its parents are registered from of_clk_init(). Everything
+ * else is registered when the platform driver probes.
+ */
+static const struct stratix10_perip_c_clock s10_early_perip_c_clks[] = {
+	{ STRATIX10_MAIN_NOC_BASE_CLK, "main_noc_base_clk", "main_pll", NULL, 1, 0, 0x88},
+	{ STRATIX10_PERI_NOC_BASE_CLK, "peri_noc_base_clk", "periph_pll", NULL, 1, 0,
+	  0xF8},
+};
+
+static const struct stratix10_perip_cnt_clock s10_early_perip_cnt_clks[] = {
+	{ STRATIX10_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_SIZE(noc_free_mux),
+	  0, 0x4C, 0, 0x3C, 1},
+};
+
+static const struct stratix10_gate_clock s10_early_gate_clks[] = {
+	{ STRATIX10_L4_SP_CLK, "l4_sp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux),
+	  CLK_IS_CRITICAL, 0x30, 3, 0x70, 16, 2, 0x3C, 1, 0},
+};
+
 static const struct stratix10_perip_c_clock s10_main_perip_c_clks[] = {
 	{ STRATIX10_MAIN_MPU_BASE_CLK, "main_mpu_base_clk", "main_pll", NULL, 1, 0, 0x84},
-	{ STRATIX10_MAIN_NOC_BASE_CLK, "main_noc_base_clk", "main_pll", NULL, 1, 0, 0x88},
 	{ STRATIX10_PERI_MPU_BASE_CLK, "peri_mpu_base_clk", "periph_pll", NULL, 1, 0,
 	  0xF4},
-	{ STRATIX10_PERI_NOC_BASE_CLK, "peri_noc_base_clk", "periph_pll", NULL, 1, 0,
-	  0xF8},
 };
 
 static const struct stratix10_perip_cnt_clock s10_main_perip_cnt_clks[] = {
 	{ STRATIX10_MPU_FREE_CLK, "mpu_free_clk", NULL, mpu_free_mux, ARRAY_SIZE(mpu_free_mux),
 	   0, 0x48, 0, 0, 0},
-	{ STRATIX10_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_SIZE(noc_free_mux),
-	  0, 0x4C, 0, 0x3C, 1},
 	{ STRATIX10_MAIN_EMACA_CLK, "main_emaca_clk", "main_noc_base_clk", NULL, 1, 0,
 	  0x50, 0, 0, 0},
 	{ STRATIX10_MAIN_EMACB_CLK, "main_emacb_clk", "main_noc_base_clk", NULL, 1, 0,
@@ -263,8 +280,6 @@ static const struct stratix10_gate_clock s10_gate_clks[] = {
 	  1, 0x70, 0, 2, 0x3C, 1, 0},
 	{ STRATIX10_L4_MP_CLK, "l4_mp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0, 0x30,
 	  2, 0x70, 8, 2, 0x3C, 1, 0},
-	{ STRATIX10_L4_SP_CLK, "l4_sp_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), CLK_IS_CRITICAL, 0x30,
-	  3, 0x70, 16, 2, 0x3C, 1, 0},
 	{ STRATIX10_CS_AT_CLK, "cs_at_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0, 0x30,
 	  4, 0x70, 24, 2, 0x3C, 1, 0},
 	{ STRATIX10_CS_TRACE_CLK, "cs_trace_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0, 0x30,
@@ -382,33 +397,111 @@ static int s10_clk_register_pll(const struct stratix10_pll_clock *clks,
 	return 0;
 }
 
-static int s10_clkmgr_init(struct platform_device *pdev)
+static struct stratix10_clock_data *s10_clk_data;
+
+static struct stratix10_clock_data *s10_clk_data_alloc(void __iomem *base)
+{
+	struct stratix10_clock_data *clk_data;
+	int i;
+
+	clk_data = kzalloc(struct_size(clk_data, clk_data.hws, STRATIX10_NUM_CLKS),
+			   GFP_KERNEL);
+	if (!clk_data)
+		return NULL;
+
+	clk_data->base = base;
+	clk_data->clk_data.num = STRATIX10_NUM_CLKS;
+
+	for (i = 0; i < STRATIX10_NUM_CLKS; i++)
+		clk_data->clk_data.hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	return clk_data;
+}
+
+static void s10_clk_register_early(struct stratix10_clock_data *clk_data)
+{
+	s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
+
+	s10_clk_register_c_perip(s10_early_perip_c_clks,
+				 ARRAY_SIZE(s10_early_perip_c_clks), clk_data);
+
+	s10_clk_register_cnt_perip(s10_early_perip_cnt_clks,
+				   ARRAY_SIZE(s10_early_perip_cnt_clks),
+				   clk_data);
+
+	s10_clk_register_gate(s10_early_gate_clks,
+			      ARRAY_SIZE(s10_early_gate_clks), clk_data);
+}
+
+/*
+ * The registered clocks keep using the mapping and clk_data, so neither is
+ * released once the early clocks have been registered.
+ */
+static int s10_clkmgr_setup(struct device_node *np)
 {
-	struct device_node *np = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
 	struct stratix10_clock_data *clk_data;
 	void __iomem *base;
-	int i, num_clks;
 
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
+	base = of_iomap(np, 0);
+	if (!base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		return PTR_ERR(base);
+		return -ENOMEM;
 	}
 
-	num_clks = STRATIX10_NUM_CLKS;
-	clk_data = devm_kzalloc(dev, struct_size(clk_data, clk_data.hws,
-						 num_clks), GFP_KERNEL);
-	if (!clk_data)
+	clk_data = s10_clk_data_alloc(base);
+	if (!clk_data) {
+		iounmap(base);
 		return -ENOMEM;
+	}
 
-	clk_data->base = base;
-	clk_data->clk_data.num = num_clks;
+	s10_clk_register_early(clk_data);
+	s10_clk_data = clk_data;
 
-	for (i = 0; i < num_clks; i++)
-		clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+	return 0;
+}
 
-	s10_clk_register_pll(s10_pll_clks, ARRAY_SIZE(s10_pll_clks), clk_data);
+static int s10_clkmgr_add_provider(struct device_node *np)
+{
+	static bool added;
+	int ret;
+
+	if (added)
+		return 0;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				     &s10_clk_data->clk_data);
+	if (ret)
+		return ret;
+
+	added = true;
+
+	return 0;
+}
+
+static void __init s10_clkmgr_early_init(struct device_node *np)
+{
+	if (s10_clkmgr_setup(np))
+		return;
+
+	if (s10_clkmgr_add_provider(np))
+		pr_err("%s: failed to add clock provider\n", __func__);
+}
+
+CLK_OF_DECLARE_DRIVER(stratix10_clkmgr, "intel,stratix10-clkmgr",
+		      s10_clkmgr_early_init);
+
+static int s10_clkmgr_init(struct platform_device *pdev)
+{
+	struct stratix10_clock_data *clk_data;
+	int i, ret;
+
+	if (!s10_clk_data) {
+		ret = s10_clkmgr_setup(pdev->dev.of_node);
+		if (ret)
+			return ret;
+	}
+
+	clk_data = s10_clk_data;
 
 	s10_clk_register_c_perip(s10_main_perip_c_clks,
 				 ARRAY_SIZE(s10_main_perip_c_clks), clk_data);
@@ -420,8 +513,11 @@ static int s10_clkmgr_init(struct platform_device *pdev)
 	s10_clk_register_gate(s10_gate_clks, ARRAY_SIZE(s10_gate_clks),
 			      clk_data);
 
-	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &clk_data->clk_data);
-	return 0;
+	for (i = 0; i < STRATIX10_NUM_CLKS; i++)
+		if (clk_data->clk_data.hws[i] == ERR_PTR(-EPROBE_DEFER))
+			clk_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	return s10_clkmgr_add_provider(pdev->dev.of_node);
 }
 
 static int s10_clkmgr_probe(struct platform_device *pdev)
-- 
2.49.GIT

