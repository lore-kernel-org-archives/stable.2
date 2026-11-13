Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794581427;
	b=ermHH7RucFIRDE1CUasO6efpb0NplCA5aHhbiL1YDyu7OuIU4/9i2TzULnrEoIlGSJI8
	 WrMMrwXqm8lqAfQgUpFQSxlgZdkcwAKye3kAJDZgrUZCHOboPU7tI3Mz/7COT2OLEY6u9
	 IEtshrNsShNJ4rZMaBcyyS1e5n4Oy2qqf539zD7z76JrnIGJVA2/5X1qSZu/YA/V+J6+m
	 RN9vxTpBR5VoiOdjgJ35utnYAZ0dfjVjxwEdPT5FbvypyDvl6NnZVn4qbSNHrnYdxgqpE
	 khiVipA9/hLsrHLMXS3qPy0KjfWUSw9pM9+bzkz/xXAcIcPfc3KMuLTy99iNB4ovpoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581427;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=ECVX/5zk6mejiKBUTdPa4xXiFeXBfKE+Ws1j5PsmeAM=;
	b=WDrMMv8NdP3xy74gLol0rAWwlwlDZuJiQjrckPpWADFhFYMpsrgkzq0VZLGhQH7M5CEJ
	 gKIvzFh4ciynw48mTKOkwjSej+F/brqwY/N46KJFOd3OnVSv0xrxVTlhCEUVBjKpbpYMX
	 Cd/b/vKjPQ8maqrVXQdZtHQlfUHDMPUR6Py1P4mSYHVH5b+u0Vv25NYltmaSelR8lH7Rv
	 eZHxhGP70rz0bKAqQEAZEL9FZtU7plqEIOTGpgPRhlT2hEdHcJsnI2HgZxV9qbLC5Xk06
	 3DnH8yvnWkNSyG0+eHeIxBZ0S5jxGJp3sLV3RosHVtrXm7P/orH3aRWKhg7rv71wR+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=fs0m1kk5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.129
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021129.outbound.protection.outlook.com [52.101.65.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1E606A330;
	Fri, 13 Nov 2026 14:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA1E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=fs0m1kk5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eepy5k/CD27S8Ag6FDsCGmngPT3lK2dB+AZ+MS2VRC0hqwsB5OoxLtzxnehmqB0uZhuV3XtqMMSAf0wqvVlMGJLE/vkBajrZO3XQmAfZenScmWTxC9GsfEMlGlqOB/aj9S5XSbNDuQxYJIlprCrdDJc4/9kaxYXVu+b1IcRczurlmvKhu0LNeRpNRYgllerboS0Cq9dKPDyd/RkJ/+NNZN1WbW6Fpg5UtwcGEvXMF4ooP7zK9O8qshjaNV1t3om2zEvc+nDRHuR5REvP2kaUSEZX2oxeGUERs4VHFP6Fs+HGOW8s8tQqqx8Nvh3w0i5hQ5Pw8uQ7xBUVc1odP97QkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECVX/5zk6mejiKBUTdPa4xXiFeXBfKE+Ws1j5PsmeAM=;
 b=dC4OboFCzxwCuG60fvnV89eipfiVxq9ZsOPNIHqRvIYH0duVs7S4b9XgML7ybJ9qTUnE59E+/X1vF5WFnas1t04naE1DzhirEdhcmUJL37b6xxDF0TuUF1ZuduVEuj55iK4F3qzukJ26Z/GBmOgoY6o48ipt66DENRPLNxcqX44CZcK4azS5OvjiOPaxc8goHQJjKl+MgGZasQdZ04DrQ5SnH61xfZD9meC1LiCL2yx8N87ePRbTfrULdTxy1Y21ZPXXvnz04jJ+PsvMKnGfR+3E5V7NswJqAkPt136yUr8p91yYc41odaCeQp7S0+sH4iP6ehghzz5ecmn/bX2UWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECVX/5zk6mejiKBUTdPa4xXiFeXBfKE+Ws1j5PsmeAM=;
 b=fs0m1kk5KbQFOWcbucg9j+0SFRD0/HGGnB6iKfGqv8VmlgdsXWQjhSqPi4yrtxIqXZTm5dj06B1Vd3YXGzchu8kKQjw8eOSrqtd0TUxH/845/klw5kzm2gRuoK7ba7JOFADmg3NBIdy2E+DktVA6MVoOfKhxYpiXhhReUTpMhJKGKBd8Ek6vDgoSWyJPQaVTfy6EaG6Lg9TvLGS8/nCT2xrTW9Gq0SxzWZMpPnImZMoXr9wnF+MIT+eElZKR82sD8B0N81ejdPdCQA5vYijxvtso+EQqLhbspYLbQpQ9NSH6Zc1OJTs7h0X2EZI2B+qMyi5I5mUbcMHKG85DSapGRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9766.eurprd06.prod.outlook.com (2603:10a6:150:1dc::17)
 by AM8PR06MB7747.eurprd06.prod.outlook.com (2603:10a6:20b:363::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:50:21 +0000
Received: from GVXPR06MB9766.eurprd06.prod.outlook.com
 ([fe80::485c:86c9:bd8:53bc]) by GVXPR06MB9766.eurprd06.prod.outlook.com
 ([fe80::485c:86c9:bd8:53bc%6]) with mapi id 15.21.0592.009; Fri, 13 Nov 2026
 14:50:21 +0000
From: Niko Mauno <niko.mauno@vaisala.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	michal.simek@amd.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jakub.turek@elsta.tech,
	andriy.shevchenko@linux.intel.com,
	Niko Mauno <niko.mauno@vaisala.com>,
	stable@vger.kernel.org
Subject: [PATCH] serial: xilinx_uartps: fix oops when disabling RS-485
Date: Fri, 13 Nov 2026 16:50:00 +0200
Message-ID: <20261113145000.17691-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC3F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2e6) To GVXPR06MB9766.eurprd06.prod.outlook.com
 (2603:10a6:150:1dc::17)
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
X-MS-TrafficTypeDiagnostic: GVXPR06MB9766:EE_|AM8PR06MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c8d2f0-2588-461e-61ac-08df419570cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|52116014|366016|18002099003|261009223027099003|56012099006|261021135927099003|10067099003|261102123227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|261021123027099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	BXOutpn4TcQktM8hDfavhNgv16XQHNxCPB0kbxHsKd/WWQM5WVIT96OwCRTVsUzXCM2NGPzKRTlax5jg+h4Gq32E6VDEMm0YvnMyN8jSTHrSnQzLcRUlJPuL2bCGEitGgysHBxccMSgUmBrkVq5ipTGfb9tAXgFSXS7EkTob639PN1bGiuGQiQWi2BrPYYxtMJPl7nh6gOvu6PLwNzEeBxcOkM85OBeSxyuh7qDhR2PoZvTjX9ojXsmwaPB13kai0GguOpb1x9LCbHV6I1JvN/xzE3SxxMti0mk8TEYXXbfANYiOSa+AgNXdmWo00DEL330eGbG6jtJEjN+3eKbm2bihDHzIC9s3tGV7Eb82L30+lXiWcE3c9Jtnp8TRWfT2VBp5GfoHyI1m/OvIvE1OtcYIh/P4O4wez6PvjLpFu6lEtpXIih+8RYJ1pQyWsK4+U72UHB5Tfv0i8qYZR0oxeVF0/iOl5Cc39JHtiJQDOQWxcom9ABYNTbOvYnRuER+5ywRtvesWq+clmjEd92UAHOt5FAlj3d+frk8QQ0+V/kM7wlaSdDZlqL1wU2DN1uylXEEOy+H3sPcvpJm3764xqmyauulpavRz05CS9Itmvz7E/xx3xDaiIPhU6TsAhf58utgrcmetWM0MBgnZWmnSG84hxqd2xwxog7OCrbm5Y06hEgu1x1uQkMAMIw9LxQP1h0vqMfv1qfU6Mad+ajbF/H5V5QkeHar4eSsAzdaFWHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR06MB9766.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(52116014)(366016)(18002099003)(261009223027099003)(56012099006)(261021135927099003)(10067099003)(261102123227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(261021123027099003)(38350700014)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TihvB/CN1bDsmUiY9k5TV//tc2JSBvBT0DQiG1DxIfMRqVI99bZFbKNys4As?=
 =?us-ascii?Q?AeJbIN/gilYVsNjSHAgI+IAG9t7QP8ZQCxv/l/ztn5wo+BLn6w7oQYeiLBLX?=
 =?us-ascii?Q?CZDih74xlxvF3suIosie+IdtpJRDGsTTpdv31EQ3+ZxAcXgFXr+FFYpfmwPY?=
 =?us-ascii?Q?wvg9ZqMuXviUANG8xB9o3ji7lqqz6tNOtXXfq4B57apBsasEL7Yg1kFQWIze?=
 =?us-ascii?Q?WK0ufuF0SnHY55nbpLeVMbQc0p7P+3LkbmN47/wJZ47uBEDVUH4Txj8yowqI?=
 =?us-ascii?Q?EqLnEItgffy1eTtrYTgrX73LPQVTX+H/Qg23hygnVGKz+ZVwLp607gpA5nTz?=
 =?us-ascii?Q?tQUkJLQ8ZS0LYmQQwnpsdEaRQ2kwY5N4xQ+mynezGjqdNKnYfIIksuKR54D8?=
 =?us-ascii?Q?ShXRQFBOi8/zHXFonoFX/o5FMeTbvEvrNl5kLy8Rs88LRU/b2DZI2q3hLjCE?=
 =?us-ascii?Q?OcLYH64fRmZhleTNJv7Rs+uT6QNeaiY+gQziHkdoJi4YtPRKdq9pdp3Z/bpO?=
 =?us-ascii?Q?fZeIJt6rC64Mx7f0uN4hM597y5XHhQ5XQJ+kJkmiK0b6bbtJZ7GzdI9n9ZAM?=
 =?us-ascii?Q?Kt6gpJgubxddJomiAwcVPuHgCdufjucvNh2euT02XjIwpBkzzNOT2J60xkFH?=
 =?us-ascii?Q?7MCUJ8gQ/WeVFO+D0pzHMsSD/CDy2iksrMHy4txoE4270iz5p2dPYLtXYtZ0?=
 =?us-ascii?Q?nwfRXN3ejYZOrM7OCD2C9rK5JgToM3BbMyRn8HKfi/KYhE+TNawHZT2284Go?=
 =?us-ascii?Q?bxK7Vz7BK7Y1FtOmLBPSIEM/JK1NNWU4UAh9WyeI9HtoaBZvzQBdljhY8b5h?=
 =?us-ascii?Q?6wW5qgcBIz4VqfDeK5fv079aImqQKoOvgsUkAzj7ZDcfbP33tWX1n9b78K5X?=
 =?us-ascii?Q?UvUMhR0F1NV0CGDvsmxLtXSQtSGuSf3zB3MxYpMyQPRCycwb4hPTaCKdX1lc?=
 =?us-ascii?Q?heT7Yx4B3VN+y/Y9EjQt74lqTEaLIfxVFUH44qznvavkuoPOWbASbWi3Iz/Q?=
 =?us-ascii?Q?OrrG8gnFg7G/i11CCb1PWg85eeoQnqF90WfdgnBJKGHIkh2la9M3K1Y5j0zZ?=
 =?us-ascii?Q?wx2s2MD83L4263hbLGlFSHUn0/hz++BR+iiELmz6Zl6WARNgkdIGWMYuorAo?=
 =?us-ascii?Q?Hq/IKKeDh4/+SePrDea8R+fc6pELg+3U7ZwjMLqYIgKu9TN+SQoGsh5W034W?=
 =?us-ascii?Q?bS7BthoQk8CN3z3EHw2RYpTeZi1henrjf+81AJxduZ3RYDj14hb5AkUjYXLr?=
 =?us-ascii?Q?OtgqRCRCYX+hHUM4hBOPt0z7k1fJfwoztz86CTg6x4KuRZ6xEx+U/m8BUS8N?=
 =?us-ascii?Q?BMhdQIyZFCfNIl2l3ieb9XnXBeXirFbkBKPyZFZmuNdMAtydNZKuCCiCGSHZ?=
 =?us-ascii?Q?u98iwVdH6M+aQiOkSjCjNmNwXeNx582i3yj+9aAZ0uBUgYsbizJYVW1GmH/a?=
 =?us-ascii?Q?YZQXSX1b1PJ8Y5z//ByKYrlgvQ4j/ygEqZwzdtH5w02qrekNQBmtPgzQ9wAH?=
 =?us-ascii?Q?6JnaPONqjzDlQD350tsG60I3u4EBbGZyvj13G9SbE76L9wDgHD7jkIzvwC6q?=
 =?us-ascii?Q?IU8XtjaN2jfwyKyo+580v4lPALZsU3dn70ZRcAmrbYdNI+TRqeNRTvbf9Q15?=
 =?us-ascii?Q?AVNjojnP175u7KDrXB6tq7L21dMQL9Q3/yNaYX4R3O/talLUdX/qHlvMq98R?=
 =?us-ascii?Q?espmAUGRzumr3hiVpn57+f/PVI3+N5a07NaBqlRtQCWTMOkHRIRY2HMptNW9?=
 =?us-ascii?Q?H1Rtm3tYTg=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c8d2f0-2588-461e-61ac-08df419570cd
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9766.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:50:20.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PrZ7sflqDS2I/d4OXPA9MkwUZ9aws8NCf6wfZNQs9ESQ3njEi1SznDIwy7KT0ZQs4MIa5DygHzjkbexu/G0wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7747

cdns_rs485_config() sets up tx_timer only when RS-485 is enabled, but
cancels it when RS-485 is disabled. A TIOCSRS485 that disables RS-485
on a port that was never in RS-485 mode cancels a zero-filled hrtimer
and oopses:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000c when read
  PC is at hrtimer_active+0x4/0x94
  LR is at hrtimer_cancel+0x10/0x64
  ...
  Call trace:
   hrtimer_active from hrtimer_cancel+0x10/0x64
   hrtimer_cancel from cdns_rs485_config+0x10c/0x11c
   cdns_rs485_config from uart_ioctl+0x7a4/0xc3c
   uart_ioctl from tty_ioctl+0x3ec/0xbcc

Set the timer up once in probe instead. This also stops a TIOCSRS485
that enables RS-485 again from re-initialising the timer while a
transmit delay may have it queued. The callback is switched at run
time by the existing call sites, so its initial value does not matter.

Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
Cc: stable@vger.kernel.org
Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
Tested on a Zynq-7000 board on 6.12.y: without this patch the first
TIOCSRS485 that disables RS-485 after boot oopses as above; with it,
repeated enable/transmit/disable cycles run clean. Also reproduced and
verified on v7.4-rc1 in QEMU.

 drivers/tty/serial/xilinx_uartps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e8c4b1fa7658..f93e374f6d0e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1620,10 +1620,6 @@ static int cdns_rs485_config(struct uart_port *port, struct ktermios *termios,
 		val &= ~CDNS_UART_MODEMCR_FCM;
 		writel(val, port->membase + CDNS_UART_MODEMCR);
 
-		/* Timer setup */
-		hrtimer_setup(&cdns_uart->tx_timer, &cdns_rs485_tx_callback, CLOCK_MONOTONIC,
-			      HRTIMER_MODE_REL);
-
 		/* Disable transmitter and make Rx setup*/
 		cdns_uart_stop_tx(port);
 	} else {
@@ -1782,6 +1778,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->rs485_config = cdns_rs485_config;
 	port->rs485_supported = cdns_rs485_supported;
 	cdns_uart_data->port = port;
+	hrtimer_setup(&cdns_uart_data->tx_timer, &cdns_rs485_tx_callback,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	platform_set_drvdata(pdev, port);
 
 	rc = uart_get_rs485_mode(port);

base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.47.3

