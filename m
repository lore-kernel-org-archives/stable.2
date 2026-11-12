Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794494836;
	b=F3CVe71qE7J3KY1GiNndmso5IdU8G5Y4ACLL+BNW1pUkev4SS/B4RdkvS4w0qXMk3N4k
	 VIBu4iPnGVa+YeiWNujsRX13wL95OTo8yXeOT+/G5TduZjHSZv3UFDYR5XgZ8lqbEZQCs
	 dXZx9YEV2P7zKkEUyA1niU7roQptpNywtx5KnHv1vMrZCzIkjCs1cg/9qD9BBZHTec6xt
	 WqzMjV91FtTJCSR6aDrHU5mqUaEJvAAMFOHl+j7vqa5yOpb3uLpYDRSZajbnO15LcCeAm
	 JY+MpRmyiKzvSOJ0BD5pzx1C5VmefmxHHVhm/g1eIkQFUH/YAIsnLlDPjh5jobY8TWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494836;
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
	bh=YJh4IZFYmGeIKD6GLHxG7sL5URbmmG71yB1xSDD3IMs=;
	b=gtoJABqPCTvjET7lW4ILi3SwhmRtx+2qGPX4a46jhodmCSDEITiMFdGvGDy9xElvWw9R
	 Uf0SNM4Fb6B4sZgerNCH4kk/ScJSL0Uab1YvvYzADpEBSF8RmXWLT6bRE0Hv54Kqt9nSS
	 HqVEkN3JscovPOGyxUWrYz7AfDq05zvZZezXlYjiXAVb+yCHXQqLVSQjGx6splBhGeot9
	 ZhyBly9V94Ed6FLRozxovQFmO41lxCFA/Ld1Pawrui2tYOqe42Qgly1nG4bR4eannhhJi
	 7aGziYb7g0mXh7fyL5s3Jr2gct+u2o0nGaRwaU4CsdkI+zgGbh1ciWhEBjHSngOq7sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia.com;
	spf=fail smtp.mailfrom=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=s67bN5bv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.7
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29471606A321;
	Thu, 12 Nov 2026 14:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29471606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=s67bN5bv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYDa05zGfzUPLJiFq2ymk9qNAeoTiFm5edC0YlQIDVrqspFYLqEw48YOs6c16dRtf+ygX3oxU27teYnmEQL3wc3eL/W3US4IFrx7656tL2GPXNKXZ3nBNYTLnMD6CW72RspbJw+jc4ZDiokC+G6GSlsPBzv6Fl1hAeho4DxIW6oyiYPJeuSPdxL+znhcUEcCAW5Xsm2oRFxvO7Su03lxaH4vF55x/W8K5Sy9PVQiBF28lW8LZABI8wzgYgFXQUYDm3BEKWJoGDJhy+L1FG25l/wPiFf8LBFiq4Fk6NXpjzK+gyRj/0Lb657AiT3cjSQM2FRqFNLf4rHmPnxynSsuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJh4IZFYmGeIKD6GLHxG7sL5URbmmG71yB1xSDD3IMs=;
 b=WDqrWoIeHnYIks1+SrtxIWEm+3zjHykFriyRHvHMPvKBYWt3zF0cWDr1XIYBsKQ0TrfpR+YqJwMbiejz9l/cqUy78OKtAwcrxdCklWDFuSMFMSp74v/2sdtDvruf+vDH4C5ALe4nDmn/2r2eOhzNnfB17z09TsBNqFdAqErUk04IK4ZPgQzrROAmwqHjRTiS9c8AAliFlq+lulh+L9eaZVZTH/WPWHGAuN//tWjsnl2sKIB4G5wn4+Txb2tFcSasVR8HiPqobyxHydaZrr9bv4UP2XUJB11X/tol9QN6rBrgMlMn/a1GIvwwnVtqN2+n5j2QmACO9RGbJ0Z+SOl2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJh4IZFYmGeIKD6GLHxG7sL5URbmmG71yB1xSDD3IMs=;
 b=s67bN5bvOcQj+X3bBpnh31/kqdVc5sZTuL4fPpCYiz9RWLvxJtKZTqTO0YosnITLNFguCNqpkgmh3enVShuCHcpVa3BYGC+Lwyoro3QXvAxAhKcIyQlMjIhEkXtt+0oUKSeT/7eYdiyj43uUPmEeIsK5Utgp6rP766HhMOwTzsCXCUZLwpQf2KQiOGEDZnGH1G87e91BD2fsnUeM9Kyfl4wX2AccIW0icFzCNPCpkqCcFoZJ/eEHhiOrjmrGTWT5UffzzVjgo/cbEh4Nc7SLswSkKeiMGNmfDGHNLdo8U0SO8srdCHtYdLcl9375vmhsyyOZG5oa7b3uaMFfSVTQYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by PH0PR08MB972899.namprd08.prod.outlook.com (2603:10b6:510:3b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:47:12 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%4]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 14:47:12 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: gianfar: clear the pending Rx skb when freeing the Rx ring
Date: Thu, 12 Nov 2026 09:47:09 -0500
Message-ID: <20261112144709.1556103-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179449417576.2168702.16619704784193243313@kernel.org>
References: <20261112143140.1395197-1-anthony.pighin@nokia.com> <179449417576.2168702.16619704784193243313@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
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
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|PH0PR08MB972899:EE_
X-MS-Office365-Filtering-Correlation-Id: 3570c51b-ac17-4e10-982e-08df40cbd5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|6133799003|10067099003|261009223027099003|261022075727099003|261021135927099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	TG3pdrhEncy/RqUlyvxYfINwvXjSfolFhZgFvl+tboahApqKB4c3JYMIdGBEzO1WhngbSkydgZsU4MJsIL5yFNkxBHLOnazgiVrP4yzrow3MoLQ5503nbftqI2MwtJtg+ItgnDkLU9t9cMu5LW/qruJ1uR0HnMya5UNuBorLSVx3rL2YyK0VXU3zIlTB8WT4r2FGu0pLPHYOE43TjzVV/S72IrL2krR+rE79LgRBtFZuClDGjs+m74VHADRVneER4z41KvptDEJDe9ZEf2Yk+//E8dZSQKyXpHx2+c54S4yye9L7aMgN0QObeXaqReU2YmxFawjC6HCPfkjRtZiPQF7otP93sBTKfgynKClymksCe9Mj17RhE7AB3MjTn7Il5bx5ha+RRrk8rss8MGj1wNQ7rpWgaUhah6hPld/sAzXOgCII69CvvwjrdoG4fBscLirJcH0n18syp4bQBpbJK8Q8GddjfHQWrXWbCl4Rdw+BWmadnA9kUcSfUDS7Q9vmVpba/Iv4RKCK898O6xO+R7jhZMnHfCt93ZJxFObghYFJlqPBZM9iQwDE3Z2DjpIJ2kUbhbXlajAJeKD+wnPV85iZ28g9EEPPoe35BUpqBfx6WoLp+MpUuIrfLe1I0ge+jHiF5uuLztzOA14qqsf4u/24MdEZb7KdJ5Msu2+SJJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003)(261009223027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jSkZHlRw6yCRmee8UM7piWxu2uzE4gmDoraCN40nXaiDwKXP4xd6s3Pt3SJQ?=
 =?us-ascii?Q?wo8xpqKTIacppt3/mI7l7FOHjXNY/NiKFmfP2NsbYtbZzoq0n8joLprJ4ZEy?=
 =?us-ascii?Q?iUcKwnu0dWCp2Im5azKOYoDeEJg0iY0tgesnXkZGF2REmKLpgDlssxJu1qjM?=
 =?us-ascii?Q?bdhNEHWwCxj/AvQdbd0Bt8lm1wdlaNz81SFWAgg9fOpqfi9BFL3XCJsRbNXx?=
 =?us-ascii?Q?IAdiCFqiidJaJJ2fGPO7wQqmuXFD+ky/djca6++3H5VvUV4/v5mFEWyA+Jy/?=
 =?us-ascii?Q?KrDprpAacyt9H1v2ki+9UBBO+t0geJy2/zm2moTdprE9CAa9afbVk8/gKTG4?=
 =?us-ascii?Q?OqX0w8hO2fr7qhsbWbglQ/iFD0KKli+EQTBvO1rZqvv3dT3a/V25SwHVMSfX?=
 =?us-ascii?Q?E8ecG4kBPo1L3GRNRFtC+1jBQsudJAjwc5i8IVANvV8KOB2/LOcNoxjEDsgY?=
 =?us-ascii?Q?LYeStzxKa6pdcIRxOzm53zODca+xkECb+4Ez+U0zyXSBy5LXj8+76kObPCOc?=
 =?us-ascii?Q?Ow6cHcyOeCR2W80o8BvqegMnDZlLvwFCd84XH2oD6K51kZl7fpjixSJ8eOL7?=
 =?us-ascii?Q?ZRwFqIndLEazF2MonTdz/8BUrvLoOu/shuCDS6UQ2ibfb7Du6w23OQY8oHLs?=
 =?us-ascii?Q?DSVAU+9TQdojhh+vd2Ahm3NheUasI+Pxa4BCeYlCHg1lYPdCEpXsMzp3kSdY?=
 =?us-ascii?Q?87+i+wCHJo1qDurTH/oIQ0xwQ5CxcMFkP5R0TEqsZKf+gLShf9JW8M/ntjzw?=
 =?us-ascii?Q?SfjLYMI4NCcP/Sodp0EzHORW3u6TeJ7g1yoh3QcZtNqXPoBi6ksJL41Brqcu?=
 =?us-ascii?Q?QkqdshGoMMtJubO7mnjuO6F2DcFVAvKnJaj7pJLfhBToMFcAzPDPPq9reDTK?=
 =?us-ascii?Q?0Js8F9FgOtKTpPLqMwpw1av8Z8cbubmROmEoEUol1Kz5Qhc48JVzDfC4hILi?=
 =?us-ascii?Q?cKFWthtG2HUQV9g6hPgmn9z2o/Jkh5FZAW38s6LuwDyr1qAX59o4YJdfWSuo?=
 =?us-ascii?Q?alzdK6pStlV+dxK5TJOuZvpBVgnDSwi7z6MUTJJZJ6pCTBvGqf1ir+tL2y1a?=
 =?us-ascii?Q?jTW4EunLBgSA6QiRSwH6wZnSjaT9HlH57WSzxbGPQoLiFrn4RUKritJdeadb?=
 =?us-ascii?Q?qPl5pkoPRM6AmPS/LYThJ2yP7mSLd2gau80j4NQPYBhgJkbvszoQtlT6b4bL?=
 =?us-ascii?Q?8YllIciilSgQe2wjXyU6D4kw7UslaaxVAMKa8vsLrXenmTULC+JSQ/XVOBZv?=
 =?us-ascii?Q?7es+RaaByilaof6yY2d7gSLsiBVq0fGqdmkv6vIMO/xxU4uwx21CMaRLKEAb?=
 =?us-ascii?Q?/4BV/S0yuVMADPr6mUJ/05kNnX/jW8CnFoKf4/s1UDGfsgSDs5+N3QY1oQzn?=
 =?us-ascii?Q?pulbiA9FyMZrYJsGFhfjtgvhAdpjohx2WvDl2CGsQEGZeH3h6oHLgf9hWUI8?=
 =?us-ascii?Q?cc0oYI4d38PlofznNlUV0oGBstgq2AYsjhNmAPFIHTgzluLjkHaa09Gq0Dlf?=
 =?us-ascii?Q?TDgCzUvXlnAe4DHYac6l3j+KeHu3rMTezboSkVgG34ydRGzIKKgr0Y1l49Q8?=
 =?us-ascii?Q?N+owCJQBgUBoasF8eT4GL4C5gp/+vV4zT6do2FiJuxxJxyBhmOaQdM6TTEeU?=
 =?us-ascii?Q?DKLY7OEEbTHaUh7LT3h/PnukqpS5LZpcC8nG45ZohZ2O21hnhZtJnlBBebyS?=
 =?us-ascii?Q?qC2IUkp2pZyyS8FUjr+jRnplDoiYYTAdNXWqBnDbe1QVpE50bW2mGWtpZUlt?=
 =?us-ascii?Q?EOILjis+/Q=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3570c51b-ac17-4e10-982e-08df40cbd5eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:47:12.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPBFWzJIKE3K8ECvejlvOuxPZXedKE04IUdgNa3+pHJf0ndGAnqb6T3xh9knlVBtyEq4B9PSVRzmeYoRHeVAzR9zQUtX++VXRaQVGwxdzBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB972899

> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

Hit during development, as intermittent kernel panics in our automated
regression on an NXP LS1021A board (eTSEC), in an L2 Ethernet traffic
test that shuts and re-enables ports. It was seen on 6.6, 6.12 and
6.18 based kernels, crashing in unrelated places such as
kmem_cache_alloc() called from build_skb() in gfar_poll_rx_sq().

> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by LLM and not proven at runtime). If it was triggered
>   please include the symptoms, like the stack trace or kernel messages.

Triggered and reproduced. Bouncing an eTSEC port while a traffic
generator sends 9000 byte frames into it at line rate, an unpatched
6.18.62 based kernel panicked within 50 bounces. A temporary WARN in
free_skb_rx_queue() showed a pending skb being freed on nearly every
bounce. The bad PTE values below look like packet contents:

  BUG: Bad page map in process udevd  pte:c40cffffffffffff
  BUG: Bad page map in process udevd  pte:450008c193dd7a
  BUG: Bad page map in process udevd  pte:1140000000004801
  Internal error: : 221 [#1] SMP ARM
  PC is at folio_remove_rmap_ptes+0x3c/0x118
  LR is at unmap_page_range+0x5ec/0xde0
  Kernel panic - not syncing: Fatal exception

With slub_debug=FZU it panicked on the second bounce, in usbnet's
rx_complete() using an skb that SLUB reports as free, last allocated
by gianfar and then freed by the IPv6 stack. That is, the stale free
had released usbnet's skb while usbnet still owned it:

  Unable to handle kernel paging request at virtual address 00040035 when read
  PC is at rx_complete+0x260/0x37c
  Register r6 information: slab skbuff_head_cache start c1e86dc0 data offset 64 pointer offset 0 size 184 allocated at build_skb+0x30/0xac
      build_skb+0x30/0xac
      gfar_poll_rx_sq+0x19c/0x7f0
   Free path:
      kmem_cache_free+0x284/0x438
      kfree_skbmem+0xac/0xb0
      sk_skb_reason_drop+0x68/0x134
      ip6_rcv_core+0x46c/0x830
  ...
   rx_complete from __usb_hcd_giveback_urb+0xa4/0x12c
  Kernel panic - not syncing: Fatal exception in interrupt

> - What hardware the change was tested on. For driver fixes please
>   mention the device (and if relevant firmware version) used for
>   testing, or say that the change was not tested on real hardware.

NXP LS1021A board (eTSEC) on a 6.18.62 based kernel. With the fix, the
same test ran 90 bounces with no warnings or crashes. On top of the net
tree, the patch was only build tested (ARM multi_v7_defconfig, W=1).
