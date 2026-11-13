Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598237;
	b=IUEi9mF0U+7ErZRQxEm6SYFMwoa6DdxjggdxcUsWo4cKuIJDlP3dOdyoKYLMG9zClYa3
	 VPL/TtQvdh29DX9e9KaqjtmXmZnQy+COqOl7e8M4ZGmlgS+sn4YNnyYTRvjnrEy1LFu/X
	 YCk6w4VKybWu4nD2XyIpmH/jKaI3uPQctayHHlShO6yKGNW73q7Wmd8Tqbq7zSd5t4anz
	 Os4Mje73LpFlHROiLxH1I/+mQccoD5rg0W4Utae17+MV+VjfnftgItA8AqVBL4EiUgtHc
	 HLNA0E8pjVk/7mfAV205B4myPE4gaBof29TykpIzhNItIKNCSbykDP6iCpAIun3m/Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598237;
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
	bh=VcX+AwSVbXhVQjksOCYH15shTR7aQx4iFV0P5PJ1x2Q=;
	b=2SgSsWueN5ew7L7ebUL7Feaa/+9C3vUvpSlkbsVFpwQx7zaVy1FWWpeUVt98iT1h7a4q
	 Iwy/5/Cll1njXG7G9am6WQkJWIM1Vu/LsQ3XSb3MGm870g8yPIuklrpoLuCi913eQQ99m
	 jhpdOgK7KAif44JCHEyZQIb8reJhqqzpcm9ntTbmu+CaaZrSMrZRIycd4S0GcwpElEY0A
	 OSkmhlzRvBIaqJSgLpy1nyMm0tCWCxRN3+zJmQsQ9jCeyGajbitxTyfrXX3yci/r7Qarl
	 BGuYe711yWzfNo7VS5FNEhMAeil6ovKMkMAOodYQtUCEeLHZL/QBBSLf1bfNKEXBeeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Wa7i76jK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.2
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F4606A88B;
	Fri, 13 Nov 2026 19:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E0F4606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Wa7i76jK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJutzeqpoWV82TmU0V2tMzHBQSxcKSoeaGFC5iJt9M3LteWnTAHuhGUK7t2la122V2g95erR/TB2CeSLjzQHRlsKwMKA8al0g0pHfl7oiMSX0t5XMF4gCl4unmyDlEUnXsJjtIwdBs7J2dzh2LAqfZ8rteKZhLunUUXVNAQpv2wP+qeQxm9UBt+weV0bEko3ZHgL2fzN0GX+wL7Hqrq+x7JD1iNayIWszhb43VIap62fqOSeblVFNSupimzmwbxZJzYrtv5RUDGC3XW+IGZLZcWdoBLHu0k9ItkbF3UBSqBdUHDQ/LW/ISD9V9pePU9hw8+lbpIxdaOa8BWMazv9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcX+AwSVbXhVQjksOCYH15shTR7aQx4iFV0P5PJ1x2Q=;
 b=e0EwQneiMGOOCMcadzYfVYF+JHtip26Wg/lFvu9mqkVhUBd6sXV1Ir5S6jqRdFhATdv9LdDc9pP5djRdukI2k4qdQ3+zo6KGJ7YSzoo40j4AcR0+WQrBrKB9HWT6jtkNguzlRApDZn84uZSTxUlF5Lb1NABKTzwwiXXcwfMPZ90EZ1ksGUAFipspm/l6Ope5vPmklmzvKdFHnjXXva9hiMWWaIs2AF6gHlsrXZ/SMVoW8ZXauTqOK6YVe5UdeND08+ALzhE+0MExip6tPeWNXiik8RVJoCwzSJm9+brttb56hv7HZSsSha/eSsVfcUOZKQqEb6fX2A8iJxaVpbgK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcX+AwSVbXhVQjksOCYH15shTR7aQx4iFV0P5PJ1x2Q=;
 b=Wa7i76jKuyZh/LI8AzRVlpu03IlHzRi8sNDNipg9gL9GVV/8uGZTxMfY7zbIzH4th24lLv3Qxs0HmatiA/+ozQc9gWADEq3DZgsDcaEIEca0lBMr2pqAWcc5MllUQ+lYdvNZfNeLuS+vly8e69mc3hVS+XcshovCQPWJBvWW5MXwkeRW9qUmR4ZjWBpX4C0LLPwMNRC0hLF0uLjiIASDh4x0Tu8LEtQqBW45PaAlSiTp5zo3g6D7aaD4KZsZnLLu57iErXNMYAjAJRICFeMgZj27TNwM1smJILMOHmsRV1B0giIp+GwJkjZxWdOmv7NM0Xhc10KgWiBfG7V2g0WqAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM7PR04MB6823.eurprd04.prod.outlook.com (2603:10a6:20b:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 19:30:34 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 19:30:34 +0000
Date: Fri, 13 Nov 2026 14:30:26 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v6 10/10] dmaengine: dw: Prevent tx-status calling
 DMA-desc callback
Message-ID: <avdlUjK85rU08VHB@lizhi-Precision-Tower-5810>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-10-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-10-2ee0c348224d@gmail.com>
X-ClientProxiedBy: DS7PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::11) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM7PR04MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efccd70-b9f6-4e88-8f38-08df41bc9634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|261026140227099003|5023799004|261026121527099003|56012099006|4143699003|261022105027099003|10067099003|261009223027099003|261022075727099003|261021121427099003|261102123227099003|11063799006|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/wKkx6S+JcirQ9f9oeMS6/Ua/L0/a5eJL/y/hja12KiG0SmfOZ9PhfXLBhRpulHHFt3E88URprMMYQWIaPTOS26tsQP89SFsOcbMxh4tPPZfqHjstRRkmT4jEo+5InFc78KjbEi4McTAFGJgzIvQdEuYUArMya62BQl2g6H0dvRqpCdUjo+i41ZyfgDv0I3csIRlts2ul2TUnoUELFueDfXANYSAT52XwuoO5bx459MtCTwBHTAdUNL0dYT/03uRDteOrkKUH9/Z/xO1GyQN4rMLeJgf84yhI27HMMpKLAXzYsZn1duv+bclZQ7Q0OVDGXGlYRWI5hslsi4bfVZ1ic6WUmHafN5r1uUXh4LR83Q+iil9a3dpntX+FuiKrjuGDyRgPxap6Hq1Z/v3HIh6/h+CB6qPpP4LPdfcNTTh4s2rmyvqky4PDJZW6rdtGgF10TOgGeAtu/wwL1REm5K3wfcMORAM8PqC8P/VzYuAaB9BMAbWuTIyMchZYo66xhgXI2dBL9qprZdOExuMolQkAsRItQs7RjJeW1FBjrvdrHeY1QrzAT+Rv+h7jGguv8Nwm5AZgauZq1HZ+GBE6IdyTqWsmaUN1toxEge+zHFbznpf7nAQzBrSQv9TJDgftRNZLJluX+wkbC+aPyUqZFjTJEoD4J3wqrP0wV2gcbSOmZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(261026140227099003)(5023799004)(261026121527099003)(56012099006)(4143699003)(261022105027099003)(10067099003)(261009223027099003)(261022075727099003)(261021121427099003)(261102123227099003)(11063799006)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LmRC4I8SHfiCiZho/MF2O7hHVKZtBia/ivPX4ep6W/QlaQP+iytudFvkReNY?=
 =?us-ascii?Q?DAgQZIkK/DgUG5t6/TgjcpgaYbfKO7XJpXgon1dKYWBfyhA33A/j+GiNytrW?=
 =?us-ascii?Q?rEdIB7JUfIj4VMbzONZBa4WJhLZcaFIqU2Cj45WfJxkTVB/8w5QPv+DSr4b7?=
 =?us-ascii?Q?5MIBZRMxsE4fmiUDT0SMBHHBCCDzbYaHS+Y6Rf/gWm4AdwioQILSaFidNoqu?=
 =?us-ascii?Q?64aEYQ3B+1RoYeQr3X+pR+UUaukvbNvH2BfVBDEBohaifkfvcQk/6H2PEw4E?=
 =?us-ascii?Q?wNBx8GzXySz+ELAm2BMsBrtTAqfOzkHwfoULgOJ/N0VW2kdfshnI+32Egw3q?=
 =?us-ascii?Q?xzF/uvR75DfGTjUyWxoHLGA+Vlh6rN9bz0ZTDxeEzz6v4Kw1x/cLR5AJz2Gc?=
 =?us-ascii?Q?atry8ffjqgYe0wlL3L8yHkBS8X7bFyDpV9v/kinx9siATSK+WtB28AsU03/B?=
 =?us-ascii?Q?LABUyyEMhzC4wV+CJRQjhvqsGLeFkl3qJc+PuagY5kSUqcvKXe/vTzS44Fht?=
 =?us-ascii?Q?SvsjyCuG7Biw3YwdShP/cZb5IkkDISfJk4xFvApeZsQGDdGAJ+ddZgYhln6n?=
 =?us-ascii?Q?jLuhpZE0tPtjr97AcU2H8B+mBuuuWniDX2YkPIiOhvIwnzynwCIzjJMngDle?=
 =?us-ascii?Q?hdGFMHYaCGu1zf4gjBnvKpuBGa21SwbasuTMyCPn1jN5TAwFdGaZiM0+EscK?=
 =?us-ascii?Q?zLHjRho+xRTJoPG58vRnbyhA3RTrYlV1ZXPku05Ij6q2qlSOBbwGUFGM2h2D?=
 =?us-ascii?Q?sTZT7t8lo6lZTBN3jC+dfFWveoOuYfLuOa14pUdb3BizHzSA5axcYmhL5ng2?=
 =?us-ascii?Q?Rf3IvydJQBL8ok6G4+xtHRtH+iVm7bxgPfvYuCAY/O381A2bzxxuwAuSPCRK?=
 =?us-ascii?Q?6vGfiOpE/4FGAwQOowp2YQcgivSoqVcNT82DP3QLERGGUkmNMFZaJhtDRFf4?=
 =?us-ascii?Q?/rwcfevyfL21Ypl7TeD1iGWG4OHGdjtSdcxxgvMV/XzIfZXbZpIzZ3vtepZt?=
 =?us-ascii?Q?V1vw/Bb6Sr9n9nLq2SvxVDpBNRaJt+F4ohPYbNE4PSKMUKcADkxDePPZ+UPh?=
 =?us-ascii?Q?laN7PVnbbOtCsgsR3uV4r+DGz6CyLtvp7ECeE2Gby8lLFEo3G0+TY3ndHSd2?=
 =?us-ascii?Q?IZMEpEkAVjcnLfhuMM1/tLgjgksOYvUkjn/61Xr1H8dWWKodcjwrr2tmCXGS?=
 =?us-ascii?Q?RLMGo3SI7XvE/gjEahbygzzH27WE5WVYHkYl8depSw8qSPzFjqHKoN193U2X?=
 =?us-ascii?Q?ieNRqIzE1MIO7sFMkNxMuxvp58v7bSyR8SBzS3YQrnSO0r5EMcoQgeZFb+JI?=
 =?us-ascii?Q?j8taGwjHATDrUE0JlXhg7Pcq0M27kz/JR7rZOda/48X92HN5542wX77I9z80?=
 =?us-ascii?Q?HO1bSRnAc8HTuU3TnwNUkhwYpIFsaXwZIxL3MZBaj7tzwzxOwl8/VRfN+LwY?=
 =?us-ascii?Q?xmv2sIXZZjRRzXtB/mbI1IjS0zt5AeIiyvd4F+6e3rntJ5zO2nOL3feel/D3?=
 =?us-ascii?Q?knmzNrWjkcmcmsEIl7ZGMB9YVSKSr1RKfudVjXHRJTa308vUBoj9SPDgQmmt?=
 =?us-ascii?Q?3G+2RI5k5svHHR3zsAXU7VDlzRaZSsXXehld7/0nVdPZk39JUXK35aG+7WpS?=
 =?us-ascii?Q?tLbSLCjgloxUyEgJUHPe7MVr4Zr+G/E/hEjtg8oV3LgdyCTn+iM8LQuv0yYW?=
 =?us-ascii?Q?Qe/qwEjoLZURPKqG06WCDcG5gYvdxKF+Ezn5Zb94b32EWYHyshGGddHfi5Yz?=
 =?us-ascii?Q?ywe0KLr4JcK9O7jHhEQ7K1iU8oZiq8q4fBTld7vi/cUxpiYDbNO3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efccd70-b9f6-4e88-8f38-08df41bc9634
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:30:34.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAEPDdzCAiA3HrWnQN/RUu0LzRgM8l22kqEvootOq0XTPaBc3K05+7nUqFA0TIiW7GdUJALwIwWYUikWIEuI5yHhXxDpVCDtVkr7owKub57wj1+IN9Qaz56w9s17YSb9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6823

On Tue, Nov 03, 2026 at 03:26:12PM -0700, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> The DMA transfer status getter can invoke a completion callback from
> dwc_scan_descriptors(). An 8250 RX timeout queries that status while
> holding the UART port lock, and its DMA callback takes the same lock:
>
>   serial8250_handle_irq()
>     uart_port_lock_irqsave(port)
>     serial8250_rx_dma_flush()
>       dmaengine_tx_status()
>         dwc_scan_descriptors()
>           dwc_descriptor_free()
>             dma_rx_complete()
>               uart_port_lock_irqsave(port)
>
> Queue completed descriptors on a channel completion list under the channel
> lock. Let the controller tasklet detach that list and invoke callbacks
> outside the lock. Termination discards notifications still on the shared
> list; the tasklet owns descriptors it has already detached, and the
> synchronization hook waits for that run.
>
> Keep handling raw completion events from tx_status(). Clients such as
> catpt poll transfers without DMA_PREP_INTERRUPT and can mask the controller
> interrupt externally. Polling must still advance software-emulated LLP
> blocks and complete cookies without waiting for tasklet execution. Hold
> the channel lock across event handling and status calculation, then
> schedule the tasklet for deferred notifications.
>
> On channel release, discard queued notifications after draining the
> tasklet, before clearing the controller's in-use state.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: defer notifications while preserving polled completion and cleanup]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
...
> @@ -988,19 +994,26 @@ dwc_tx_status(struct dma_chan *chan,
>  	      struct dma_tx_state *txstate)
>  {
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
> +	struct dw_dma		*dw = to_dw_dma(chan->device);
>  	enum dma_status		ret;
> +	unsigned long		flags;
>
> +	spin_lock_irqsave(&dwc->lock, flags);

use clean up guard to avoid below goto

Frank

>  	ret = dma_cookie_status(chan, cookie, txstate);
>  	if (ret == DMA_COMPLETE)
> -		return ret;
> +		goto unlock;
>
> -	dwc_scan_descriptors(to_dw_dma(chan->device), dwc);
> +	/* Poll completion even when the client has masked the controller IRQ. */
> +	dwc_handle_channel(dw, dwc);
> +	if (!list_empty(&dwc->completed))
> +		tasklet_schedule(&dw->tasklet);
>
>  	ret = dma_cookie_status(chan, cookie, txstate);
> -	if (ret == DMA_COMPLETE)
> -		return ret;
> +	if (ret != DMA_COMPLETE)
> +		dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
>
> -	dma_set_residue(txstate, dwc_get_residue_and_status(dwc, cookie, &ret));
> +unlock:
> +	spin_unlock_irqrestore(&dwc->lock, flags);
>  	return ret;
>  }
>
> @@ -1079,6 +1092,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	struct dw_dma		*dw = to_dw_dma(chan->device);
>  	unsigned long		flags;
>
> +	/* Polled completion can leave descriptors waiting for the tasklet. */
>  	tasklet_disable(&dw->tasklet);
>
>  	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
> @@ -1089,6 +1103,8 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	BUG_ON(!list_empty(&dwc->queue));
>  	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
>
> +	dwc_free_completed(dwc, false);
> +
>  	spin_lock_irqsave(&dwc->lock, flags);
>
>  	/* Clear custom channel configuration */
> @@ -1238,6 +1254,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
>
>  		INIT_LIST_HEAD(&dwc->active_list);
>  		INIT_LIST_HEAD(&dwc->queue);
> +		INIT_LIST_HEAD(&dwc->completed);
>
>  		channel_clear_bit(dw, CH_EN, dwc->mask);
>
> diff --git a/drivers/dma/dw/regs.h b/drivers/dma/dw/regs.h
> index 5969d9cc8d7a..c41f18281efe 100644
> --- a/drivers/dma/dw/regs.h
> +++ b/drivers/dma/dw/regs.h
> @@ -279,6 +279,7 @@ struct dw_dma_chan {
>  	unsigned long		flags;
>  	struct list_head	active_list;
>  	struct list_head	queue;
> +	struct list_head	completed;
>
>  	unsigned int		descs_allocated;
>
>
> --
> 2.53.0
>
