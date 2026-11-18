Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795021497;
	b=ebC42lUkiJfDYMJRGCry827/vdBSRoAm8u3k4NjnEWb31yxJJRWR+Z5OD6r4WeydOAY4
	 ZxPSNL49ViRrNL7cLMuQcBywSWaw8pdNGsWhWCz95wd6SxlqFUN9weDwyMaCBvMpHWcJB
	 u1sCodErzVy5HgNIRk4fKrQrWrR7LAS5Te5EC3E3qZssgwXmyup9QTjRNUZSIGJ91kZiz
	 fHbHmp8XmCA3hapdU0naPyVEDi2ra9ciyB9HmhRC6DgzqOwEjwLG5tPzwUaHz/tS9p+oa
	 Ak56czBon0XV0qTnCWdvpKg9CrK4MCWYEIoH0AgZiDLyMoh+gModAYAzf/1kw3N9SsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021497;
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
	bh=GAO6IYhoBQXWxy//8MhmCY3Mz+rDP6zjTTPSdyEpsA4=;
	b=PdNQlvtTA0jWYIpc1J5sp/Yl5N+GWcRtAdAv5tJ5074AjCi5TqRr22lboJt0o/6K2L45
	 l93qt90/2XUFZ61Jx2jopFoOo5ifdbbC7ddlJm2mcg3oXe5RYS7pLrtw0SD30FgFKnQvm
	 UCeBpkJqDE80eqaUNzZbzkvK8rmTVExLJn0E7gUZABkMRNSxLa69K2XQB+9AS28Opr+cw
	 xKs6RtLHP6tGFMeaBmvAUd/cMtJDll5JVnClTKglii3KUY2e4sZpqsvUlqZXpAHfdRhvk
	 ar6jI7F42DHQ1TfH7SS4lp3wzbXcKGp6R68FL99JR2dMNCUTh0vQ3uWNmfIQ7f+RNXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nNcgR2xs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8660A2608;
	Wed, 18 Nov 2026 17:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA8660A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nNcgR2xs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy3y+mFsBSxXSlnDN0u9HkYtyV9SfueZot4AkEWro1tm5fuhgyQCdGrvaoerHsOgjxGAgNTNsGrxdczcEArKUg267R78M2wc7SsoIaprCbRg0+GjfT6zi1UoxF0sAZojgnARaDDnjE+H7B7Px0P5ri4wKokVPcfN87Vns0hJJRWntjRDPSv0x+9duonswP+hQ6qhjourJWHMC648VjK7XPoTvw1rEK84EORsT1Np7y5meuA6gg3hNySQFUa3+Cf0tbBEgHIyen3iudNKEVAF0JdXhuTB5xJyulWIYbPU5Ibj0CGKVuQJ7SehmLfdV/Y2s1iGqi5c3V7JeWmzN11L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAO6IYhoBQXWxy//8MhmCY3Mz+rDP6zjTTPSdyEpsA4=;
 b=ILJTuZdeABNeDTlTEuAv5kvcZKGHh2WjxKVMi9+qn2YIfYlv81zUrkZHgxIsgkyAMjtmNvS7gd+uYvLkITDG3SedTEqeC4KQRzQaU4DHvYdidddWlokq7KUdoU0oZ3zwA+qeICzoyxf/Th4HUtuVMCf5xltnX/PTHUZ6jwRPwpCPf7MXKWPkPVLZnJQvYtk8CVz1YHvwj47DUMTMYmCviRTiZQNi8INysy3523QrK1UTAcz6oKpjCP36bM5hHBuCkZJsMl+w+tDwJoBt4KQCTD+js9j2w/HhzWN4T6UTooEg24Lxiwwdwmobv2T0mGymCLAzygnuuBHm8as4oaYg+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAO6IYhoBQXWxy//8MhmCY3Mz+rDP6zjTTPSdyEpsA4=;
 b=nNcgR2xs2C9YLuiFmtOWb/ZuKl+fm0TTZTFmO6IITUhWtjG3UbBnh16oKJThDMom4yYolTcLpcFk0dbG4keqP0i+wD59nR0zIgmnlvRjvyU0T84iCIj1YKwYQnlnm6Gcl23iUnR0VE16eilnf5U9PAryyQrKE0nBO84+UH5yUhL55Us7FnKgVlnoiUFolu5dx3hx9N0UGXbfHGJIPWH5Y5AcyYcDdFsV1a7jsQ6Lk06vmEQ25m9jj6TJ0Zy9Yu53SLTmXBoxSR/suTLosJ9LxoUyVs0TWUZqbJTYM6/gbk9F86v6hYBfsRlGOho33dVpMLI8pmCyZ/9ioPlw2RNMHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAWPR04MB9814.eurprd04.prod.outlook.com (2603:10a6:102:37f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:04:52 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:04:52 +0000
Date: Wed, 18 Nov 2026 11:04:44 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Amita Mishra <amitamishra@google.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: terminate channel on timeout or error
Message-ID: <av3arNfXL8zWJv3P@SMW015318>
References: <20261118100839.3090172-1-amitamishra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118100839.3090172-1-amitamishra@google.com>
X-ClientProxiedBy: PH2PEPF0000385A.namprd17.prod.outlook.com
 (2603:10b6:518:1::7c) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAWPR04MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a8e5b1-7504-4e9f-7dc9-08df45960fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jXuQPOj1f1o5zQwiSVC0hjPhSFKTJ5cxrBf02sXOOrZ+FtAKJ0slChPDjM3WeJJx54NgFKIc8gWc0IC1pxvW3FNodUEtiI5zh4xX4ggC1FhQTIrgWuG15aGRAWv0pIMYnJGd99oV6WGI5HA2GshZxdbAvK08UchnXgJ6oK4j7PpSO/CBDjm5i4R+52nWclQkgaZhI/1iDe7XB3pF1C69DzdKYHLAdFQCHHZ2ynztXihDly4c5EVT8feKhOFyQuqOLUPu3+Q9GvB6UQiu4csHLK035/56X1vUehHbVeAjin9QlBix4VI4UjOLLX9w82ORByKvEcFR6ssguLJYajGmCZea+PSf7jmmK+gEk2EUPTMc70mGRL467JxQDn6o2W60+zNQc34ZzigOkIig7+XCxBTL5sxDhktw55tCnrziO8F86TM4sXh9jsWC7puoOngKLTZt0ceYGCN5sHx1cyPDFzXxLks/Z4tQqPA0S2vGfWWdXF15AV1XsfHkacuLoQ1Bk5Ycwj7VDByBZM21nQyY4IhA7t5d6tXQchRLN/lJr7yXwhVhF3655ilTtTXh/nu9LrDaR467eBADpH8MPqebJ15x3mrXlc4aPWJOxm2cV1DEmT2i81wSdKil0A5tPQkYTaPACMCyty8uhAC7Gjv032g86pF+F7YJ88WoThheCuI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rXV5JSo/9EUmkOn+9Kk8XPCx1usYsQZ0AGvZHmtRkxiDp3Lv5Fo7vZSLRkl4?=
 =?us-ascii?Q?98qicUatuWIsSQZje0qDwucQYNJhOUGyis9dUbBaOewe4/iw76uDzgh2ZB2U?=
 =?us-ascii?Q?8ETznaxD/yss3E89mhIcqa33qyez/C0ZmC9ErSBLMnXGJnIY8JhrbnwD1lgY?=
 =?us-ascii?Q?anjrsH9uJ31O0JogZvRTh7DajS1JJ7m7uFQWMgtMHityeBIaCuJXq4ehZTFL?=
 =?us-ascii?Q?MEWuelfJwfr5eMGMe06ciTMm/+gzwqJsMhXX3C6j2WHg2rxMF8wKX3tZk4ky?=
 =?us-ascii?Q?7F14qwRR0Xh96n8igEtc52AcutBb//CFqFloNa4trEjy3pgmA9uwtvhBwMbo?=
 =?us-ascii?Q?WhVuOA97VgJb/5+6JwiNPaIN8v7nypV+tH32olcyNABD70Zdacy/AddjmpMF?=
 =?us-ascii?Q?JDpyfcwhgOSvwBfn/CmjTC9B2eSZOd5Nf/7n3kYNTj/3MgY2vi+jDKP5IF3x?=
 =?us-ascii?Q?7TFfDIQcEnfU11HKt3vRr5eLhVYVt6gI1xWpgWyjipsxOJYfUV8G8hFga5OJ?=
 =?us-ascii?Q?vXYNO0qIDGoTa1MXJ6tn7QUsfYJk77Xgu7hAVhUUuHj/zu0miJVgeaLiQl62?=
 =?us-ascii?Q?OBML80AeEDQ/sJqb4Y11tVBTsjTB8shmMKYio0S6g74FY9CASCdzhKkaPld4?=
 =?us-ascii?Q?/NFvM4Zl4Kjwir4b05qx3MP8npfLI/JLn325IgAOjWicraprKKbdrLvbYr7i?=
 =?us-ascii?Q?LreE+xDdwv3ioM7F6UU2+gV6eH9CS88IReOu/sK7fkq9qlcRhOBL3jpoLG5F?=
 =?us-ascii?Q?A6xANnSN5Kz8/g4FvbcyBhMBiNvO+JpOezK7o3XXIQ/LBngGui64yI8ofSvg?=
 =?us-ascii?Q?MRi0kQuJVsV2Np1rZ4mLk9KfnqiOFZve9oJss6n2UieaMRm3usZuXNr9kl5K?=
 =?us-ascii?Q?qMnSyQv1QGWQFmRnaIEqQNbD2U0OR0uh75SMv7dOr5xe6tmLPbHjTWtlzxqZ?=
 =?us-ascii?Q?+zbuE9AcjMlWyLd3mm6qOPqnMV77RCogIelNWUwZN4c9sFZ4deqYFL34Qo4z?=
 =?us-ascii?Q?CHRQctUt03VVNbMPsFoYV6YyqNNo7EFzTGXkSDeV/VZ9eef90b2efOWvi+Bc?=
 =?us-ascii?Q?8NFZWKOqh4taoidnHuCMFFNrVeoa1oiuCsl5HX8WGrQJcueIO+HSQ+0v3YFw?=
 =?us-ascii?Q?teCA2zPnuNNGGSSUDNvGHkKnSbea/Hs48lDqjTlPFwO2lJq4lyTrzub6e5jk?=
 =?us-ascii?Q?Rfbcyhg+60ZruBvQpLteTFX05huRdOGkFkjVaWK8mxFhXXBbd3Et6Uox4RAA?=
 =?us-ascii?Q?6Y4MZAjmk+nYlDwf977eu9fazqCS80eAk5V6JiQH/3bGXhkBOU6P6QK3i0yb?=
 =?us-ascii?Q?0nsvu5GA3hYb29X9yIsPbYPkOhxs98MSpsQW0w2wDKcvVoPBWohuu1UAaLRo?=
 =?us-ascii?Q?9LiFhApFihZ1lfbWqsfaDBzlkikxL8qMV9iE63hakEi45bRr6BLPpf3LDGyG?=
 =?us-ascii?Q?RcDtXmNPEOpf/7TfOCQCYw+ub3dHoQORKi4X4MKbJqNIUplQlm6tPbW8NdJm?=
 =?us-ascii?Q?IOEfQB/3u2k0aqYvs30Sbt4prQGvbWZoap+WnP2iE2sSUyXHv839sLny31Rh?=
 =?us-ascii?Q?ZXD3sUGaT0G1KKqBJHkeN6D5O7U0t7JQBuPc4szo24vUg3mM3zxpPZ0/XgHs?=
 =?us-ascii?Q?FJ3NpaOmWMudx996RCIHnYcC5/EzWAx3XibO5rdTahFAD8Jmtl3PIDIvAZv0?=
 =?us-ascii?Q?HjZqAkWxmy5o6mDizYm6QF4z3EAgPX6FpF6v3Er+WWfEyehlSIPFcs4FcNxf?=
 =?us-ascii?Q?WQNIFeI0YyUfCVjrCfthKAnTGZPq0uGGszjzuqN5oycNLat5Uk+K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a8e5b1-7504-4e9f-7dc9-08df45960fe4
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:04:52.4799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGyKO1zeePtj5irvJ6PK5vuyzvpihmrsK4lymO3vmrMkYd0hewfqw6MrkGXCL2Krc+U65wB8q3D/ot8LWKPYvnns8oiHivBkgwQeTiRP4BoR42MZPbY5+dsCvHHIVaCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9814

On Wed, Nov 18, 2026 at 10:08:39AM +0000, Amita Mishra wrote:
> [You don't often get email from amitamishra@google.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> In interrupt mode (!params->polled), when wait_event_freezable_timeout()
> times out (!done->done) or dma_async_is_tx_complete() reports a
> non-DMA_COMPLETE status, dmatest_func() jumps to error_unmap_continue and
> calls dmaengine_unmap_put() without terminating the DMA channel first.
> Channel termination via dmaengine_terminate_sync() only happens later
> when the test thread exits, unlike the polled path which terminates the
> channel immediately after dma_sync_wait().
>
> If the DMA controller is still actively transferring when the source and
> destination buffers are unmapped, an IOMMU-backed DMA engine will trigger
> use-after-unmap translation faults, or overwrite the buffers while the
> next iteration reinitializes them. In addition, if the timed-out transfer
> completes during a subsequent iteration, its callback sets the shared
> per-thread done flag and wakes done_wait prematurely, causing the next
> iteration to fail with "completion busy status".
>
> Terminate the channel with dmaengine_terminate_sync() on both the timeout
> and non-DMA_COMPLETE error paths before unmapping the buffers, skipping
> the redundant call on timeout when params->polled has already terminated
> the channel.
>
> Fixes: 4076e755dbec ("dmatest: convert to dmaengine_unmap_data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amita Mishra <amitamishra@google.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dmatest.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 2ae3469397f3..950b7a9e7769 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -852,6 +852,8 @@ static int dmatest_func(void *data)
>                 }
>
>                 if (!done->done) {
> +                       if (!params->polled)
> +                               dmaengine_terminate_sync(chan);
>                         result("test timed out", total_tests, src->off, dst->off,
>                                len, 0);
>                         goto error_unmap_continue;
> @@ -859,6 +861,7 @@ static int dmatest_func(void *data)
>                            !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
>                                          dev->cap_mask) &&
>                              status == DMA_OUT_OF_ORDER)) {
> +                       dmaengine_terminate_sync(chan);
>                         result(status == DMA_ERROR ?
>                                "completion error status" :
>                                "completion busy status", total_tests, src->off,
>
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> --
> 2.56.1.703.gf848ed807c-goog
>
