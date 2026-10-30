Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793375693;
	b=fbHz1HJz5+irFp+3AEkn4syI279vq9jQUUxHcbcl7zEoD1mqv98ykaT6UGLxE/x7/HXE
	 grr7NIytzZKSPndf050kQj4u9gCLwCsySMaXkP73nHr68Hzb2NHeLlRR6lHWPZgHgAMKt
	 nXv6fPQ3ETlE0GWM9kZE/Tiwsdsbu/qQK/JefOCH6L9AY84+PBNJCGeM60AQSAQvszswn
	 2YdhxwhkPF+LkMTXhwNnme2uTHgvHd9UQs9mlORAzZYGAnUAsuMbhmfxRMj+sGdbQ/ze9
	 lfkhcMOn8lpBjzBwocn5uirMCmqAVFKhPHr8Rx2M4W6v3Qxibg6qejZLECkDnEe+NFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375693;
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
	bh=9piS1VIPUw2CNNhWzFkKAiqafbUcNitFDG8k7SAvXnQ=;
	b=1zCAmnlVsnNd4kka4eib7w7nhcGdgEVnLWeXk7/HyNOHZrnsdjKOHy+sFD6WnsrFMqRc
	 asS2BiGJxbGGIZ6HN3iGkHElp6GS85byYPXh7zjmCbFp3ul+FCdg3CFpnzzFANTRwU0GY
	 Gd3N62v2/4sADV1UF9LUZKxeG2XXO2BP6jWqhMC8WT5vZ7rpZOGhc7g2NBER5hqLHkHLY
	 zVo1/TdDIiR7AvGwHHrSmIK9A779Ubnv/o9tOrXfwQu+nQTN1DlYPboukuth5CD4P1aK/
	 QVlCej2qpeewOAJvElwf+PKZq0fSM/MV957AjkA8XS0RPaMHCbmQ/4gW3TCqMH1CerA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=j0Ijzi5k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.62
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA7606A31E;
	Fri, 30 Oct 2026 15:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BA7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=j0Ijzi5k
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIHooV/Ytw0qeGGc8qquGTfry1r9iuGqvrloSUmNWGlrwC3Ft21Xhx7FXLLUkWgQlUFXQFuqGyj/pPigzWdgT8RbVu/zGQWLn3RzsmDd7TIOzUX3p8uOqAbzK2t22FR65agE/iuLzDQzujwrWHn3U3ENTVUWED9S9i9Dr7m8FfFs6qoYwBlYzbW9VRh+ifB7pjr0MuWuLKNWuqoa5/B69yMm0mipbC95H/ycNtZyjrnY2fbj6K1ipKxh/hMtOUskP+VLlpkxyeRTG2kpkGpMGnio+Gt1OiTyfgDMcm4rtPiOAQJhEWr/hl6CtOxYcTVWHkQMmCr7zUkVNjUs+58V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9piS1VIPUw2CNNhWzFkKAiqafbUcNitFDG8k7SAvXnQ=;
 b=R6KC6TMnJxIBQG+cFK4QojvrCeiZoWPK25cXd9FH6yWv8eCCHFPwhwFloWGM9TKFeYdpUdKt7R1xvUzNLvi+2CQEhj63UfiajY1mJEH9g5IwqwMSSAk0GR6QmYNLkG4gltWNl0ZYcqS+hR9Sa27OZGmQGvLt3Jq1OBF1m8/YezSBedN7uW/dwPTE1HidkN3/oyyhlNewooQPjLYqVSAV+1EM1mUDXTAMElekhwavn8e3k6iDdCWLHxDrbGvgoirkS1kL2wlM4nMgJFYO8uug9v1KrMgv31Sj+A8jvELdekEgWbFRM/x4oBl20rgQcgJngSAvDnTLFkmuOPxXKDw/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9piS1VIPUw2CNNhWzFkKAiqafbUcNitFDG8k7SAvXnQ=;
 b=j0Ijzi5k7y7x7fbyYPLFUZFGmt1AeXU0AYL1K4odSUNfs6rBNYy0kk0W4fZ+QnI8S2sVuVOVn53IKvoRcywbG100dm6GgwKD14lj1RMYMHWG00kxrttEU5UKpL3/KC1IMepLD8C6Vmh5VPxD9IJi2VTkiu9rUnH0xtH2GeZoMZvGyQABlSRVXgQd3nwsMG6Hetg2Jbc9pHppCuxk5mAZ9xG4zXJ83nj0LdYChnwjH45FjiWAVlBMWs/d3UX0d0+sJeatPisDg0dVAt6ziVWxbiq1WtiRoaATxpjj2GpFCuD13v1kd6NuN0qpwwlVqZJYcPwERGGsGjMumxqsB8tbNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21) by VI0PR04MB888289.eurprd04.prod.outlook.com
 (2603:10a6:800:366::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 15:54:49 +0000
Received: from AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06]) by AMBPR04MB12445.eurprd04.prod.outlook.com
 ([fe80::ba23:1fa4:ce58:ff06%3]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 15:54:49 +0000
Date: Fri, 30 Oct 2026 10:54:39 -0500
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
Subject: Re: [PATCH v4 7/7] dmaengine: dw: Prevent tx-status calling DMA-desc
 callback
Message-ID: <auS9vz9Pp1K07K-N@SMW015318>
References: <20261029-submit-dw-dma-synchronize-v1-v4-0-fea447d9f285@gmail.com>
 <20261029-submit-dw-dma-synchronize-v1-v4-7-fea447d9f285@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-submit-dw-dma-synchronize-v1-v4-7-fea447d9f285@gmail.com>
X-ClientProxiedBy: DS7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::27) To AMBPR04MB12445.eurprd04.prod.outlook.com
 (2603:10a6:20b:75e::21)
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
X-MS-TrafficTypeDiagnostic: AMBPR04MB12445:EE_|VI0PR04MB888289:EE_
X-MS-Office365-Filtering-Correlation-Id: c6abd9ab-0415-4607-544d-08df369e209f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003|261028144727099003|261022075727099003|261026121527099003|261022105027099003|10067099003|261026140227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	kfNp0WNaDPV+48UNKL85UnoSDRDNCsbED435e1neDVitK+fnd8iszNjoadmU0HniaAJqp9kzNNinPw6Ju0sQDzCZCwd0H4W8s/HZbc0uSDa0elr36pDdMUHIWsMZPrUAZn1ZIJHTsNIdX16mUseDs7UlkEN0Wy3XBDFwJs/35gBcsnWgU9PVUWHUsvA/6MPBtpRpomlib7Fqfe8ummKl1lRHOuoht9SWpM7e/QRoQ5cKepzA1emRRXmCUx4GEWXRZXQTpMg+h3Eb2Vohte751oWwIh5hm6mLfnv73rJ1pd/iTXuXRIxTgpCb+PgY93DHtWDMHLg51CTsyzWdYlVnZn4pE/EPGUMK5IimLFlrWYF2kYdOj1ZIFtox5RfcM7o25Zv9GMjuaQUAUBja2/AXv8pB0/MyxMIsn2TVb14lbcj+YfSJvmhZZPPNC1/S8y05ge5kUCTRVusXzxizNwih6KjGdcOgiLRHEGY1kwDeBhQlB4MNjY/FyRSlR09fZgzx7AVT001D8/4GnEYy69JVxbayPdgWnN6DdxcowNxxGfmGPBeEYVIixkH/cQ8QN54ZJZwfHMk6vOZOVP5RLr37mqDOC9UkxCmofC/jjK6ZtlmN73yypmHmSHX5EIn3XyVfeVm4qRoRu/nZpcY9LT1dsz+o3fuz3hFPMFpngqtrMYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB12445.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003)(261028144727099003)(261022075727099003)(261026121527099003)(261022105027099003)(10067099003)(261026140227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idQe5+BIQcSOYp2tarOsissgvRcIb2C5VHzU7wy52Y/vvSGM+8xWghsl0x5J?=
 =?us-ascii?Q?CaGUGwqfSDo45ciFOaHMqq/9GmBaP4/nGp3gh4AzJtMPVWL/bQ2QPTVgBK2Y?=
 =?us-ascii?Q?A7yvWjESYVJpgBPzvXh+7jMXYnwIN6FuabjzowSBLLTg6CNNAJAaONzLRKlC?=
 =?us-ascii?Q?fzccULwpmZu+S+Y3BwAt1WaV88KzT1WaOo6jYJEugGbAcOssnDJhWK3wQhIY?=
 =?us-ascii?Q?XYqVOx+vqv90cL6Ep28KNyRR659IVwWpxju+9OwZz73Z9RMSvFgy4wXoZa6o?=
 =?us-ascii?Q?YJhdKeO1BzvFl+8yR9cZB+iIOrQueqGfqUbvsgbCCXf5Q59YWWZAFNQSkmZp?=
 =?us-ascii?Q?SW3JVsBcagQE+Wf8ZJUD0WK56o6TQRhKYOouX81/rXqk3ND7D7sKeZdF7OQL?=
 =?us-ascii?Q?v0jdOnpNgpx1CC3BlfNKvKYM1fMqh55Tk9mTKyycK0QyPiJ2Kp2162v5tFe/?=
 =?us-ascii?Q?BaOPXGzbS39pF3nArcwXFxbnpy4MRDesefDJVYdTs2N0Dsg85tAVfiKR4w6H?=
 =?us-ascii?Q?C0/crK2RMWL3LlG2XbSiZPqDYjUnJtbdIeARL8ZEi5LDoDPgK3W7iSf8RcF1?=
 =?us-ascii?Q?Nf1G/Vn0Ezr757rumVTmKZWiyMRjQ7p05tsnMkyGpc6pc5EHwIsh+yzwvAyV?=
 =?us-ascii?Q?RkDDhqdhbZTc3Ti0NQlbyg/21cVJ5cv2tfZ0RpBel0exh4I0i4xloyCPCSir?=
 =?us-ascii?Q?4kJS7nkV+uK99OvJ1gIuPeiaos7oiWrs2s3CaMDs3hrM0awbdNpuGDhrhGp7?=
 =?us-ascii?Q?lEZYj20G0Rmv6OkE9EsxUTlK3Heu+1T1f8Ey9D5iZLtqdzlGB9n60BijEqII?=
 =?us-ascii?Q?IWEd1j8o1LSvs/YrheWs13KjHuEc8xQKK2PXGWLQXkno2Q9Y5//vUDF5rTrh?=
 =?us-ascii?Q?MlSJCBky4QzNVCocIGCpqKxBpaPV7prNYudNxP0+jb+d1MtCUTH0wh97UCb/?=
 =?us-ascii?Q?YKYQqTyGm8CPnFB0717wlM+Vrb5w3rIC6zqmAANlI7Eqgl85pjM/NahjZzVm?=
 =?us-ascii?Q?JbI1NdhXR1yIpvQ1lze4N8j6IhSAIjdkj7vdm1jkJ+8eeoDeYdPdacwo8mDE?=
 =?us-ascii?Q?HJJJRo2gTRNQulHfcmmLFeyengli38roeg/0m/YXB1SVMZWJGZlEk/GnZjTA?=
 =?us-ascii?Q?NJ6wSzOhBwOIn02yNZgDCD4p81KRdof0IyCV4ywwxoEMSBIfGTGbM4D4Zu4c?=
 =?us-ascii?Q?FIGQ+UvAmd8qmv+esetW6y/kkK165+z6YZBC+Y/t0YympjmUd7Uigic4vuyS?=
 =?us-ascii?Q?JHV7fTxaZHdkIhyjcJ7AhI2RRFzZDOXveTYaurMqLVQwqKGyn3TO+zdVqq7F?=
 =?us-ascii?Q?uZzjcscHwZe/q7HG5fVNsUuYcMWnyQJ2hm7+h7UMnlU1oic4QDbshWHRfWWk?=
 =?us-ascii?Q?edFkw8dzmFoLlY1buSUEz+6/KoMSxS+8Drwf5pE/f+C9QnXsu1Yvr+n3DHAv?=
 =?us-ascii?Q?G0nw9O3Jf8yAbtToS1Qxq8cWqGhbuhC51If67sxf+bQiUyaK4k+w0LfOj8zA?=
 =?us-ascii?Q?Vxem1ZTaJ1ewGaZwtgFbIKBzor5xuqBjS1pxLU+SfhLAOhTb6Jr3kKqtjh8k?=
 =?us-ascii?Q?fPLdJEaUAD9//+cgDD+Pdp5XWlamU5eV3GdKvuX610itPQrAaDWx3l5ioSZj?=
 =?us-ascii?Q?0znlS2wHlvonEPV47DQWZ0ufGVJKSy7MTvds9/BeaKro0UDWSXHs0vyEKvhc?=
 =?us-ascii?Q?l18DSoXwSZsn1/mVMpZw55ObdLzxCq3ti2TNr/zN08gNlo8IdA5Ca8GpUnLl?=
 =?us-ascii?Q?yfXFj+BXWy0frNrfCTD/x0FzP9Ju6fnT3LWc70mcZtwdtPltpMe7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6abd9ab-0415-4607-544d-08df369e209f
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB12445.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:54:49.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaWNP4f1sRhwPuuok+gYLu5UqBqaB7u1dpSqVUpLtbHi48WiHc+KrQWMAYM2tEUJOjO1y7aA3NRXZZ8WCxHOUT5afGcLtkCVPO0RI2UL2CyX+ef6FIqHQ999lvWg0NVJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB888289

On Thu, Oct 29, 2026 at 04:29:41PM -0600, James Hilliard wrote:
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
>
> ---
>
> Changelog RFC:
> - Instead of just dropping the dwc_scan_descriptors() method invocation
>   calculate the residue in the Tx-status getter.
> ---
>  drivers/dma/dw/core.c | 111 ++++++++++++++++++++++++++++++--------------------
>  drivers/dma/dw/regs.h |   1 +
>  2 files changed, 68 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 66065d7b26ae..d80be93f0c49 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -262,6 +262,22 @@ dwc_descriptor_free(struct dw_dma_chan *dwc, struct dw_desc *desc,
>  	dmaengine_desc_callback_invoke(&cb, NULL);
>  }
>
> +static void dwc_complete(struct dw_dma_chan *dwc)
> +{

dwc_free() ?

> +	struct dw_desc *desc, *_desc;
> +	unsigned long flags;
> +	LIST_HEAD(list);
> +
> +	spin_lock_irqsave(&dwc->lock, flags);
> +	list_splice_tail_init(&dwc->completed, &list);
> +	spin_unlock_irqrestore(&dwc->lock, flags);
> +
> +	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +		list_del_init(&desc->desc_node);
> +		dwc_descriptor_free(dwc, desc, true);
> +	}
> +}
> +
>  /* Returns how many bytes were already received from source */
>  static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  {
> @@ -274,19 +290,17 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
> -	struct dw_desc *desc, *_desc;
> +	struct dw_desc *desc;
>  	struct dw_desc *child;
> -	unsigned long flags;
> -	LIST_HEAD(list);
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	lockdep_assert_held(&dwc->lock);
>
>  	if (!(dma_readl(dw, RAW.XFER) & dwc->mask))
> -		goto unlock;
> +		return;
>
>  	dma_writel(dw, CLEAR.XFER, dwc->mask);
>  	if (list_empty(&dwc->active_list))
> -		goto unlock;
> +		return;
>
>  	desc = dwc_first_active(dwc);
>  	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> @@ -304,7 +318,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>
>  			/* Submit next block, including for polled transfers. */
>  			dwc_do_single_block(dwc, child);
> -			goto unlock;
> +			return;
>  		}
>
>  		clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
> @@ -319,15 +333,8 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	}
>
>  	dma_cookie_complete(&desc->txd);
> -	list_move_tail(&desc->desc_node, &list);
> +	list_move_tail(&desc->desc_node, &dwc->completed);
>  	dwc_dostart_first_queued(dwc);
> -unlock:
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> -
> -	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> -		list_del_init(&desc->desc_node);
> -		dwc_descriptor_free(dwc, desc, true);
> -	}
>  }
>
>  static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
> @@ -344,18 +351,17 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
>  	struct dw_desc *bad_desc;
>  	struct dw_desc *child;
> -	unsigned long flags;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	lockdep_assert_held(&dwc->lock);
>
>  	/* Termination may have cleared the error since the tasklet sampled it. */
>  	if (!(dma_readl(dw, RAW.ERROR) & dwc->mask))
> -		goto unlock;
> +		return;
>
>  	dwc_chan_disable(dw, dwc);
>  	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
>  	if (list_empty(&dwc->active_list))
> -		goto unlock;
> +		return;
>
>  	/*
>  	 * The descriptor currently at the head of the active list is
> @@ -381,40 +387,41 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
>
>  	/* Pretend the descriptor completed successfully */
>  	dma_cookie_complete(&bad_desc->txd);
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	list_add_tail(&bad_desc->desc_node, &dwc->completed);
> +}
>
> -	dwc_descriptor_free(dwc, bad_desc, true);
> -	return;
> +static void dwc_handle_channel(struct dw_dma *dw, struct dw_dma_chan *dwc)
> +{
> +	lockdep_assert_held(&dwc->lock);
>
> -unlock:
> -	spin_unlock_irqrestore(&dwc->lock, flags);
> +	if (dma_readl(dw, RAW.ERROR) & dwc->mask)
> +		dwc_handle_error(dw, dwc);
> +	else
> +		dwc_scan_descriptors(dw, dwc);
>  }
>
>  static void dw_dma_tasklet(struct tasklet_struct *t)
>  {
>  	struct dw_dma *dw = from_tasklet(dw, t, tasklet);
>  	struct dw_dma_chan *dwc;
> -	u32 status_xfer;
> -	u32 status_err;
> +	unsigned long flags;
>  	unsigned int i;
> +	u32 status;
>
>  	/* Channel release may have drained a polled completion before this run. */
>  	if (!dw->in_use)
>  		return;
>
> -	status_xfer = dma_readl(dw, RAW.XFER);
> -	status_err = dma_readl(dw, RAW.ERROR);
> -
> -	dev_vdbg(dw->dma.dev, "%s: status_err=%x\n", __func__, status_err);
> +	status = dma_readl(dw, RAW.XFER) | dma_readl(dw, RAW.ERROR);
>
>  	for (i = 0; i < dw->dma.chancnt; i++) {
>  		dwc = &dw->chan[i];
> -		if (test_bit(DW_DMA_IS_CYCLIC, &dwc->flags))
> -			dev_vdbg(dw->dma.dev, "Cyclic xfer is not implemented\n");
> -		else if (status_err & (1 << i))
> -			dwc_handle_error(dw, dwc);
> -		else if (status_xfer & (1 << i))
> -			dwc_scan_descriptors(dw, dwc);
> +		spin_lock_irqsave(&dwc->lock, flags);
> +		/* The snapshot selects work; recheck events under the channel lock. */
> +		if (status & dwc->mask)
> +			dwc_handle_channel(dw, dwc);
> +		spin_unlock_irqrestore(&dwc->lock, flags);
> +		dwc_complete(dwc);
>  	}
>
>  	/* Re-enable interrupts */
> @@ -890,6 +897,7 @@ static int dwc_terminate_all(struct dma_chan *chan)
>  	list_splice_init(&dwc->active_list, &list);
>  	list_for_each_entry(desc, &list, desc_node)
>  		dma_cookie_complete(&desc->txd);
> +	list_splice_init(&dwc->completed, &list);
>
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>
> @@ -960,10 +968,9 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
>  				      enum dma_status *status)
>  {
>  	struct dw_desc *desc;
> -	unsigned long flags;
>  	u32 residue;
>
> -	spin_lock_irqsave(&dwc->lock, flags);
> +	lockdep_assert_held(&dwc->lock);
>
>  	desc = dwc_find_desc(dwc, cookie);
>  	if (desc) {
> @@ -983,7 +990,6 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
>  		residue = 0;
>  	}
>
> -	spin_unlock_irqrestore(&dwc->lock, flags);
>  	return residue;
>  }
>
> @@ -993,19 +999,26 @@ dwc_tx_status(struct dma_chan *chan,
>  	      struct dma_tx_state *txstate)
>  {
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
> +	struct dw_dma		*dw = to_dw_dma(chan->device);
>  	enum dma_status		ret;
> +	unsigned long		flags;
>
> +	spin_lock_irqsave(&dwc->lock, flags);
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
> @@ -1082,8 +1095,11 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  {
>  	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
>  	struct dw_dma		*dw = to_dw_dma(chan->device);
> +	struct dw_desc		*desc, *_desc;
>  	unsigned long		flags;
> +	LIST_HEAD(list);
>
> +	/* Polled completion can leave descriptors waiting for the tasklet. */
>  	tasklet_disable(&dw->tasklet);
>
>  	dev_dbg(chan2dev(chan), "%s: descs allocated=%u\n", __func__,
> @@ -1095,6 +1111,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>  	BUG_ON(dma_readl(to_dw_dma(chan->device), CH_EN) & dwc->mask);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
> +	list_splice_init(&dwc->completed, &list);
>
>  	/* Clear custom channel configuration */
>  	memset(&dwc->dws, 0, sizeof(struct dw_dma_slave));
> @@ -1106,6 +1123,11 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
>
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>
> +	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
> +		list_del_init(&desc->desc_node);
> +		dwc_descriptor_free(dwc, desc, false);
> +	}
> +

modify dwc_complete() and call it from here also ?

Frank

>  	/* Disable controller in case it was a last user */
>  	dw->in_use &= ~dwc->mask;
>  	if (!dw->in_use)
> @@ -1243,6 +1265,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
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
