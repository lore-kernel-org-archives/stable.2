Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795766520;
	b=iH+SYBObd3hmnaxwLqyW03D9b/sxxLy6YpyJfxtALFiPPECJ7o50dTnjP2bKn4lnjMH0
	 bInH1RKDyB36M1tMYoldhS2vty739lmKxj5NrUJ/APzeqUC9UUpte6cL+t5yU6k5M8OHA
	 HtKX4zBxRdfUt8vLrDoTDcbBRxjvY27BoYTyQgZDR1iYme0Isnk6Z0KKymdVhJI6FFUKu
	 0PwfdWOWDUY74bi6tG+tRhOwlGSq02r3OHz2cWuNZljAwJw5+yGRQOifhIAS5tgp9M4qY
	 dEbMafhK3PMZ8AXencUAxY2NyZs3QiVOaaAF+d5pnb6FJM3F9jeaAq5DaAqQEgx+ddg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766520;
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
	bh=NabU33ou25vRtlCirCsNBQ2ftHhWhbDaCuP/EbnJjXQ=;
	b=Jh69lc/lPkwLvo+UZmJC/ijesjDZ7jY0IGSWl0qwOM9mJt4DhAQNaEBF9wddYy8QGXYo
	 69xLxzby+e4FZMoSeh9J4/ZOVhOzOYJEMCeSA03aEomadMEZJPlofwBEwxGOKvdYmfuB5
	 JQfBrUBhruETzCCyUwdcaiaasRs+KgIQ1rULZ67Yyv1W8jEVRelBMP55uSCqCk8YB1unl
	 T8gCwwP4f4s33lID/nKJttm47bos8ET6wDHPa6Zc+k010t6hXm4+crNWU+9uuyb0B8kKL
	 AlMkUQkogaCjyBn6U6mqCfnnH8lvClTcvoPP3PmeWnhKLYvSqywMlgf/C7IrVkLd5cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=noGbgx9c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.81
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021081.outbound.protection.outlook.com [52.101.125.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1D606A326;
	Fri, 27 Nov 2026 08:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A1D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=noGbgx9c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY0LOxzZvmFcFb7clt5eHJpXBhZzJ3JggznNbFiWL6/X6Giwi/YugZTrSRiGVw2HYmNr2seMC1ZuHUsPZ12l74lerTI4obyYetOD+6goq/Y/KXr02/h0lHaSJosty2B0/XiO+AhB0jUpOnXmHzP+3Npl0AvqZlSYfBt+7B3Ql4Suspg0b1X0jsIyieGPHB2fAVcB5s3NkPUwHt5N2fKP9Ej86AXHrPdMeG3ZLlFb+eq/k5+N6AGmSJ94vTxEjHAtn+uIH375Upq25aqV8WYh9nUSKdu6CaBzn2TJAxGT3rikrlCO+hTioYIT1iCtjlWXmFlhcS+a14p/WCK6e7hKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NabU33ou25vRtlCirCsNBQ2ftHhWhbDaCuP/EbnJjXQ=;
 b=PRg1eJbmyW3tcU6EYHkqhPS2Z1GucqyMjj2QywNzOWFFcz4t30UgjVcsgh2sCEK+Rq47eJjjj8Yy4ycfejFQ3KWo2D9Y9jonJy/aW6ixsiRT8YW0/4pgPET9V/tel1kS5vV1xd81rB16uqgGVLa/NVI+1ylrOt+zctcOd+Asoe2ZQ4GyXiFbtsRkhopZBVeWvcuqkwF/KQCJ1mUj+MsKXa1C96hYGTqF8h1mbRbconN0C03QGoyOZ/TFlmLWmNveI/AHWAnKAvwOb10fpGFWNEUBofTmKkGhBnWRLr67y2ZAx8RDE3C2PgoMAnrz712le0eevVzhbmtHMjFDmKuizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NabU33ou25vRtlCirCsNBQ2ftHhWhbDaCuP/EbnJjXQ=;
 b=noGbgx9clRwbc/j0zXOryEuNA9w6w9FMxzoP8oUfOxKmrBlUMchq6u+0/YeTu2CudR3R68k389/KBlPqJKZyFCCo0o39n4BT2hyFTM2EPLRbDPI3BHPl7tB1OXPF3AuxBRHPMDNw9EOebRPpUN3g+Pl2HkZZ+nAwPHyi+Vp12m4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5188.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:351::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 08:01:54 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 08:01:54 +0000
Date: Fri, 27 Nov 2026 17:01:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, yangqixiao <yangqixiao@inspur.com>
Subject: Re: [PATCH] ntb: ntb_tool: accept hexadecimal addresses in
 peer_mw_trans again
Message-ID: <awkzEjrVEz2jB1Ma@z790sl>
References: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com>
X-ClientProxiedBy: TYCP286CA0323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::15) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 0402aa95-2b79-4579-3d0b-08df4c5cb366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|23010399003|366016|6133799003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261021135927099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	i/Vl/GRtfs3DvDGw3XxracGPy6gM0PwR8YfDyChRCP3fOx8qp5Q6zZERoPZV7/+fowrGbUFYDfMe14X+dNxKIx8xLjG3mi2jOz0764bsuel0yZbjF4N+7Nu2SAHJVq5hrWoLZKvyzuRHsGfa3DAMqaPFznLaM/015m31nb51HOnVHMQy4X0FAMO+GoYi3oxO9IWVThwBWSSyJJ+7RYZjPpk1Bgc5iKo+J6+qO826brd85VrLOI+QlHDxjzgTPyp8KBNZu2uTpf9SdVKQsVTEHVy82IaMhxEKe9m2kIzS4PHQn9rwVCbhvTGfcKbk8h9j4tp2BzcQ0UnEHY9uZrK0Khh5FcZgxMBDeG8ReXYx5JwyOP8sMMPSTRTbTt58WT96X6j54fsci9xZMpVRkcQMpO7+ileMmJnGwITr1LdRLhy4GZljki8MCloWoSl7qTWPNI4z8Ske5OPjH0AC5WKlGF/Gc+SkTv8sP6qrs+Yp56Ao3GkYACQLq8Ayj6HywmUROlXtLsZmBowd5Evo/2XTDPkdD2ReoZGmgNBeMChID3R3txSwWeKvWPQ2YKl0m99eHqSfi7zESwlT6oHCDDvDOlNDHq2HNMmvhreHfaZajXD73tkRhB9ZI7LNAbwrUJLPF7vAhiSOGNZ7OVZQMRhxdfQ2NCHXVMCQNszyRg/6X3Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbjG0XaYEVOyysXREe1rv694V0Fo/gVKoC5/+n6fKhjC3RSMH4Vw3xPYq6pP?=
 =?us-ascii?Q?0JC0kjcXfuBsBMhxAnqZ/4lQP9iwOxoN90zqT/U4ItSewQ2mKNm5DSc7OpOb?=
 =?us-ascii?Q?LI4C012g9MlzrziCH1LFLYSAe4gMn2UuJg9JQkKacJ7/ePbts0vBxIvNWjAi?=
 =?us-ascii?Q?MhIsAUmB2QYpVrTUQA4YyR9lOu+var4ak4fQIIamOEkjYlM+595izvxRzfBl?=
 =?us-ascii?Q?r0h/lNI11yVHu5PuD9tGsrog6CPXz0Mb7lW0lZn40KK5CI7Rcc6tpg9tnh1N?=
 =?us-ascii?Q?FghACDT0XUrn3LU7jIiIPOxcOdisK263+ypLID8brZroMLdE7mV6XKzfa5lX?=
 =?us-ascii?Q?dZWz0TmyqT1rWrSh3/b9ImIScS9lqwS3J/RZM5qTDHNMmrGHqF4lyd0ExOW0?=
 =?us-ascii?Q?AEcAQv7gSvDuMWCcxzg9+xy968VuYXH/EQVha7O62biszlCDZ+nJabGKpl0R?=
 =?us-ascii?Q?CUB9JbixQ5ETUZ0I538fiaXjA9QekpSoR9FNFtvxq1NTl2wR3q8iPmVVEgKo?=
 =?us-ascii?Q?xz7gJRL88NqLfPfFKYVuSTvDFDu2zGY2dgeJ4ztPkOGLsq4Q/j3n2CcU7QxM?=
 =?us-ascii?Q?GlpWofW4pDJHi0kmBUs4bEd7bfWK0mJNvhWsiX3SrvOZvXSgo9CuGzSC8PX3?=
 =?us-ascii?Q?9iNj3Jk5Tu8JZRcRX+1upfRpvyrkH53OsdFVJVP7xsGb+jVttiGJuYCp+1lT?=
 =?us-ascii?Q?I+Mp0qJxU/j8RTMvoBj/SQRHIDXt8G45Aq1LJCWDyCgRpWrL/z01QmYCuLU1?=
 =?us-ascii?Q?Pkt7sHkDrWDJc4b8tbDXd0NV0obcdm93uSm72GAOUyrEOuOpMpholA3kgGjd?=
 =?us-ascii?Q?hR+A0wprZiWV1nFzrwW5ZCIzVhkISjSuWwxbkBq23tbh+lvJlADhJ8Gnbkiy?=
 =?us-ascii?Q?IlJ02Um1pEtoSXrrcNXQ9zbaglnRePUoo18+NHZ5xfQTMAsKs2SqGzMj+vi1?=
 =?us-ascii?Q?x8X9EI+8KB6K8D8Kmm16nqf/h4x6nhrxKfhHWuBSLs+wK04qzmc2BA/AP2LT?=
 =?us-ascii?Q?RZ7/xnXc0gkOHGD7GAZ8ateOc0m5quXl8VENXD4+znvVqry1QyPbJjmSHyOu?=
 =?us-ascii?Q?TJN1JvxH/JdCraRWtFKrIduUERrugBE+J7RrTqH5eL7JJj3Mw7J2Mfjq8AD3?=
 =?us-ascii?Q?Wy0RR/tGQGl03C0amT4FR+YVG4gZx1DR8gOIsr722IVG9Is6onuT13/UgYLb?=
 =?us-ascii?Q?//o927U5eJPqA2u4d25rA4jZS2KvZbSjaiG0PSadeEfUvONbwSZBbPWAM3Vg?=
 =?us-ascii?Q?nLVSsTGAWnK29XGNCcPEYCYd84AU8JROA3ZLQA0ipTRsNFauv4fzdDSMm3An?=
 =?us-ascii?Q?owUJun8BoI4iBATiWSXtC5soPMmjudv/OF5AKdpwzU09iOCr3HXYmT8wICNJ?=
 =?us-ascii?Q?1amQMngwmVETj5xrMpnJx0v9uQjpa/Jrb1CbTfeMWurOZ2TL07k1CcT9MGq3?=
 =?us-ascii?Q?n4ARJf8nsXw9rnN3KoptsgnT3/DXeUl0VZk01SjqcydLT4NTxDxswj1YWUVJ?=
 =?us-ascii?Q?Dc++BKrYGw1fGioMcwnYT1h/X9sS14A3yC6bfVOu2ZcPrKF+TommhzVNA8XZ?=
 =?us-ascii?Q?rD7gRJUh9RlsyBIib1sYUMmohT4sJRT+qbKZstYslgIcu78KJJT+Anx7frhY?=
 =?us-ascii?Q?aX6/K/2gyPtHHuPxY2UKiqCrStlN9NxYk19Qq4do1OzflGj6KPge/pIkNtZ3?=
 =?us-ascii?Q?WG56IKplWosaVglChJTCfzgfKCDTiYtJWjZfLews6vF6kLl1wTakPeAxY1i1?=
 =?us-ascii?Q?5JNZurIwyca1BergzmBnjaAw9Ze4o7Ck6Q7KsEU4qbLYQDojw/rC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0402aa95-2b79-4579-3d0b-08df4c5cb366
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:01:54.2211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Sk++nugrARfvkkh57eFZ3V/PyLT1ULoYil+X/W82jS580oihhKyVfGRx/bWnryHo+64CdRDKXab81ZkKJRYXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5188

On Thu, Nov 26, 2026 at 06:15:06AM +0300, Oguzhan KAYNAK wrote:
> Commit 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and
> size_t in tool_peer_mw_trans_write") changed the format of the
> peer_mw_trans parser from "%lli:%zi" to "%llu:%zu". Unlike %lli, the
> kernel's vsscanf() parses %llu in base 10 only, so an address written in
> hexadecimal is read as 0, the ':' in the format no longer matches, and
> the write fails with -EINVAL.
> 
> This breaks the usage documented at the top of ntb_tool.c
> ("echo 0xADD0BA5E:16384 > $DBG_DIR/peer0/peer_mw_trans0") and the NTB
> selftest. tools/testing/selftests/ntb/ntb_test.sh writes back the "DMA
> Address" that mw_trans<N> prints with %pad, i.e. in hexadecimal. As the
> address format comes from ntb_tool itself, the first memory window test
> fails this way independent of the NTB hardware driver:
> 
>   Running mw0 tests on: 0000:00:04.0 /  0000:00:05.0
>   ntb_test.sh: line 117: echo: write error: Invalid argument
> 
> Parse the address with %lli again, which accepts any base, as before
> that commit. To keep the format and the argument type matching, which
> was the point of that commit, store it in a long long; it is passed on
> as u64 as before. A negative address is accepted and converted to u64,
> as it was before that commit. Keep %zu for the size.
> 
> Found by running the NTB selftest against a virtual NTB device in
> QEMU; the fix was tested the same way (the unmodified selftest passes,
> and hexadecimal writes to peer_mw_trans0 succeed 10 out of 10 times).
> 
> Fixes: 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and size_t in tool_peer_mw_trans_write")
> Cc: stable@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Cc: yangqixiao <yangqixiao@inspur.com>
> Assisted-by: LLM
> Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -928,7 +928,7 @@ static ssize_t tool_peer_mw_trans_write(
>  	size_t buf_size, wsize;
>  	char buf[TOOL_BUF_LEN];
>  	int ret, n;
> -	u64 addr;
> +	long long addr;
>  
>  	buf_size = min(size, (sizeof(buf) - 1));
>  	if (copy_from_user(buf, ubuf, buf_size))
> @@ -936,7 +936,7 @@ static ssize_t tool_peer_mw_trans_write(
>  
>  	buf[buf_size] = '\0';
>  
> -	n = sscanf(buf, "%llu:%zu", &addr, &wsize);
> +	n = sscanf(buf, "%lli:%zu", &addr, &wsize);

Just to clarify, do we have any rule about negative values for the address part,
like in "-1:4096"? 21fbdc4d0b1e mentions "-1" as a possible input for the size
part, but doesn't mention it for the address part. (For either part, "-1" is
really odd, but that's not the point.) As you mention, your patch starts
accepting it for the address part again. Perhaps we should keep rejecting it
there?

If so, to cover the cases broguht up so far, perhaps it would be an option to
split the input at ":" with strsep() and use kstrtou64() with base 0 for the
address?
That said, this looks like a nice and small improvement to me.

  Reviewed-by: Koichiro Den <den@valinux.co.jp>

Thanks!

Best regards,
Koichiro Den

>  	if (n != 2)
>  		return -EINVAL;
>  
> -- 
> 2.34.1
> 
