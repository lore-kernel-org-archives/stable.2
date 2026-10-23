Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770085;
	b=IPFr7jawbC7ZKDgL3qFnLMIDDImC7fFc8Mw9qAzooTOvtJl/W72zJQwFOdLa9nLKePHZ
	 Fld0hRCzF82tMZWC1SmauCTKu4TrFaZhGbKUw2xaaNuJV0sJA2Y04ylv7pLCorfHCVDg2
	 HB9LhXri9VxuUvV0vkvQAdQCen4jVFWi0hVICn9KBYTJHD3Vr2xev2itZsDZoRuAoHneW
	 70WYFIsP7v94DPHW7g4i2uDbLhs8YQ/d1Wu2kFDjbYZh6DIMsiXbUFYVlMSl0EZhX9zR9
	 pt9vj251Uun3yrwg3ciScd2H07UKg/Qe/I/U4gj12Sxk7EcfzNLHYADzrA+bAHALnWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770085;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
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
	bh=p4hh99SKEORXQeLjZQntEfDdHiIu0Ik3OVZji7JvLGY=;
	b=Yb+1Yq6dIgZ3KsT1xoHf72GHAOM55KMVEtUXwqHLIpIlSesVkPjRLbmkfsyC85sceSJp
	 5sHHFNvwerFaKyTLn5Wk1iObBTtgsP0JNEBSV8fNh6OIMMU6jIaSghpzKfAUMJ/CCl2du
	 hmdl/ta4CTaZyqcsFqgz0EJZMC9uERiGHJ0etn+A3sN3uPiq4bJQ3BRRP67laruGeEjw9
	 Dk3OxesJP44/O6Lvjyxp6Lh0qVTfeM1cfY7kEdprir9DG5cXZGpe0+iluEvlIDVfiQXhx
	 UQdyCxaBp9TW09eLTDdlUfsCDgxGuc9eZhBWAdQdZ8ubdpbcVdz+cOlHHanF7y8zhFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.116
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020116.outbound.protection.outlook.com [52.101.196.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D660A2604;
	Fri, 23 Oct 2026 15:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9D660A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxZLYW8DAbEcCK3kAmWk5vrwFa/32hGGpmsi7kn9nvTf4e8sddXlgooX6PnC+x4p/UXPkJM87MQVUhTCCWas4NX2mseq6jQbsgGrl/hVoTtDLFdeVeHPEEjT/iom4CG70nVEfCC7oGcsHCPQHQWmsvw7uM7GpHORYnk50dpcinkkuPQDXP7Cxdi8FL88hKgB6K/tQVVBVHtrWWN23AxLOIQ2EFE0Kj5+nSZj8jTWTj8vzoOBlrxxPF7w3+av8MZVO+dkNT0sdzr+YUDWlHpSLtJVtZ+Quc0Z60ED8jE/1J1GGvr80SP/F3mlYB/jnqyGOt4z9CC2I2QHEmMGe3OgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=p4hh99SKEORXQeLjZQntEfDdHiIu0Ik3OVZji7JvLGY=;
 b=O4Pr76sOiZrtmVNUnvNCmjzUdiHP42dH8oqaNDlIxObSxhPJ/mCMrLYUlm/qrSMneCccLMlhodsSvVHuoSgNH+MGsXcerEGZkLE9o5NHq+CZoLP49od92HwiFVR33EPIJXegfAuVpe9BqGqqMWweMBfvUWWDCW5jHq4WiCQXXuY/9XZxUY+WQgGOjjj2flyUDfyqxW5LOh0QVrwTnS5o0vGrnmaYBbPLUljj/SCd2CttecSHW/HOxClf6yxhYgyFHY6EOzkppNtgnXc9PPsbAMyfdoI6hwMu87JC7XZGTPMzJx/WsJquHbYSD5TOjQ9sBJCVFwKu6LUhc70M6f5tsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB8015.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 15:41:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 15:41:10 +0000
Date: Fri, 23 Oct 2026 11:41:06 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: axboe@kernel.dk
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, marco.crivellari@suse.com, 
	neelx@suse.com
Subject: Re: [PATCH v4] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <eavtifw74jn2uspz4ccis6c2gcntk6lnlv6sup5drgj5usq2ng@fha6al7bmyng>
References: <20261022034737.47820-1-atomlin@atomlin.com>
 <atoDZ85GTNGyaNPL@localhost.localdomain>
 <w2wpzfonupkljzzcngpie7lkn23kjrr7om7okqtvyhrttxj7ra@dzvrunt3ovp4>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w2wpzfonupkljzzcngpie7lkn23kjrr7om7okqtvyhrttxj7ra@dzvrunt3ovp4>
X-ClientProxiedBy: BN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:408:ee::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f26eaf-f8fe-40e6-c958-08df311c0fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|18002099003|22082099003|3023799007|56012099006|4143699003|261022105027099003|261022075727099003|261021121427099003|10067099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	FRVY9RBCwy2h3UX0b6rVgslf0KjXgx+o+C3oTvyPPri7WJert0jcsV7/7Xl1VoGNKhEPoLP50D0hXQd2efNaIDj0ON6OpRTLajq/8dtsGQvG2N0vNRNNqTu4E3/uSBmA7HxZ8mObsyKBOe9UIGukklDD4LZXrk/DJfUtzlArlFho2E1B5kDOPEuOQVEI0zpmhJdD0wrpf5OZmt/jDhuBVttx0psjkO/MpSMrpKaTpPsS+5cU36WkzM2hNolq+URJ8ImdnxkpH5fQyP/MKtxAxGiTddiSLosJn4eUHDsfkxvERq+5lhAt2sEA4HH5TunHqMKBDG1tfB7L2k3UlA4Ovv3/O95q+yK6E8GQ15ndZyeJxBqOeNdkxNRUiKefFY/rNXLHf43IFKYOy7VW1RZHt+J8oUFHNhieOrW1OUMxI53ZXP6zou+KyiOZ/5ANPyhWP/uwYc8jlaltDXcZ/WviThcBYyqvdCkMeN8DZ3uL2a1NxSm/10KLOuxF2n/VIvz1ZQ9RjUzd6WdcKDB3sPWDJLQkGaDt0MHIHK+KLPM/sktyczoDVpBRuF2kA7ORN/1HmCfl4AteKyBM2599UNoRbpRkTrCBqQWU11O7fg3TCLbBiL8XDsuN895YtVNqnn3p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXRhWnNGcEdnZGpiVVQxdnJtQitzVkhzbkVEdXE3SEFVTVBOYUVBek9zWjVQ?=
 =?utf-8?B?QkFMM3B5cnRmdS9jTU5OSnFuZTcxbUdTRXlUN1lGcko4emZPNUhLdXhtM2Z5?=
 =?utf-8?B?aGVYSEpxV3JUckhQQVM2Ymtsa2VmUDFCWit0L0paTHlYRXNuenBJUFgyQmhi?=
 =?utf-8?B?M2ErNkdEeVNCVjlUSlFrWjUvQit4S01mdFJUbFNBZ1ZTcE45QmhhU0NoNkQw?=
 =?utf-8?B?Y1NGaWV2cGtUaGpGdk51NERSbzk3SDE0S1lzZVFaT29QVEJYalBaSks5VGow?=
 =?utf-8?B?Qm9nU1BleEcxSnlyQ29tK0dpVXl1OWpsK0xDSVI1LzJ5eTEyWEk4azY0dFBF?=
 =?utf-8?B?Yk56WFVLSkVqZmNkSjQydmZ3YkpqVkNjUG9WdDl6aXNHRXpsakloS1ZoN0tG?=
 =?utf-8?B?QUpiLy84QkhxUTNkcHBNMUYvNGNOVWN1WE1Ja1NiTk9sUVY4YzhPYnd3TE9T?=
 =?utf-8?B?UjhaalVFZjhCNWdER3E0dnA1UnI3UEZlQ2hPendZOUx1R0h1ak93dHdkZUFF?=
 =?utf-8?B?eTB2eE9FWkJHVHY5VXdWSVpZMGlXR24rclNVY2Eyc09qZU1BN3gvbk1kaU1a?=
 =?utf-8?B?L2x2M3J1ZHVydFdrRC9hb096eEVBMkNXN1huWHRHdE0zNk1qMWdBV1h3UnY5?=
 =?utf-8?B?VmZVMnFSdFFyRmRTSEJzZVE2QS90Wkw2WGdCRGNVaHloVktNVldqTEd3WVAy?=
 =?utf-8?B?cE5weVdCOE03YkYvaU84dWY5S1lwb2F2OTlnbmRTeTl1eFBBOVdyOU1GUTB3?=
 =?utf-8?B?K2RXekxKdkN3S090TnlXazlscUhzNjk5NEFxbmZzOXZrSXMvbzllOW90dTdw?=
 =?utf-8?B?bTU1S2F0VnMvbkFIMFg2V2drSldGMXBaZ3YrWTh1QWdva0RFNDVPWlhEY01t?=
 =?utf-8?B?aDlNNXVHdDcvNXpSeWVpRWtnN3E2K1o2VVVYZkZaNm8rYWtjc0lMNS9lcGQx?=
 =?utf-8?B?K0NNN3RsWGFIRGd4VHF5TVVLQlMzQy9QeWRnSC80dTVRS3pvaExQS05HSWd1?=
 =?utf-8?B?bzV2ZFVuNFBuRndBNDh3RTdWeXh4TWRFakFtYURwYVlobmZZNU9lc0FNRm9S?=
 =?utf-8?B?TmRhQXBzRTdHK0c0amhsR0M4cEtmZ2RUUlFQZ0ZPVlh2cXVoMDdNNkw0d0E3?=
 =?utf-8?B?ejFDbXE4S3ZiYWxTclQwVkU4QzZwVDg0WXFsK2xjMmtsU2QwTzJTamxBYURZ?=
 =?utf-8?B?b1hMNkw0MDhXbVlZd3hxK0Q3ODVDQXRIT3E0NmhkeTIzTXU5RUFreXRoMXF2?=
 =?utf-8?B?ZE0yOUdJbkh0NTUvemlwZGVUQWltdU9GNzNJY0d3S214bEFLakk1cUF3OXlh?=
 =?utf-8?B?VlpGeUh5bjZ4SzBta2dZdFZaWWFGM3ZuREp4R2JkeXp4OXI2engzY0wwMzhL?=
 =?utf-8?B?OVFUNld4ZHJieGZQbmk0eU9XUVBIWTBrTDJXQ2VGdkp4K1NrTHhwcnZkNDlU?=
 =?utf-8?B?RVVpaHgrbzZXbmxucFAvUFFrSjhrNkd0VlNWKzVyUXNmSlNmbVphWnpsaXVN?=
 =?utf-8?B?M3RCL2xpMEhHTk1HZDVCbzdRVkJ2YVpFbitHV0lTOURQbm5IUjhTcFhwWWQ1?=
 =?utf-8?B?emRaVURuVzdnYzdCcWE0V1d6bWZsd3p0b0piUGlsNUprbk15WnFGSEhpWkZQ?=
 =?utf-8?B?dFYwMmpiYUwxL25sUCtyajExbU1TNzBGL0hsZklucHhCK3FLTmtzdjEwdUlP?=
 =?utf-8?B?QmR1dXV1Rzlvb3o3RDIvK0tBdmhxWjVuSkJUMjA5ZVlIRVRuRUp5ZjFNLzdJ?=
 =?utf-8?B?bU4yeW9YVVlMRlczK05UekUvS1JZY3lmUGpjWG1hK3FJMFNmM2FKVWE0RW5l?=
 =?utf-8?B?cHE5R2FDVVlwSm1VUGlHSlkycUpUbGZHTXZmTVI2S1pqYzlIUy93citOdUdT?=
 =?utf-8?B?M2ZOYVQ2OUxJS0VJN2FYaStWdC9oeXNZVW5wOTBhZVpoT3ZBRTRubm9YQlpB?=
 =?utf-8?B?MDlrNDNOcTY1Y1E3ZzFMSy9ieER6K1MzNE80N3ZIT3ZYa2VqaDQ3Sk5EUnBu?=
 =?utf-8?B?WjNTUkRnZW9lbnpMSGZrQ1FEUE9PaGFjWmdPU05meW1RM2dlMERyR0FZUGU5?=
 =?utf-8?B?YjlkQXFWeUZPWlQrVk56ckMzUFBRVHJoVm50TTRsb1RGdDM3UXRaWkMxOTBl?=
 =?utf-8?B?enJ4M1RrckRzUUM4SkhHL0Y4YlNVazJpcWJNV0NxOUhwZjVhaStOYk9oSTZC?=
 =?utf-8?B?dWNqVjBndjI2cndwV0VMUmMzazdzWElxTHBYTFNjaTNkb1hiMW9WeSt5NnNE?=
 =?utf-8?B?ek4vVUp0SXQzZHZoK3g5NUtVOWZJc0lmbkNxY0ppZHJMY3NmZDVwYzhzMnV6?=
 =?utf-8?B?RDI4SHpkbjlxVWVRaEwxK1RsUnlvVm5pZ0xDbmZWMFVOcXNrcDd5QT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f26eaf-f8fe-40e6-c958-08df311c0fcf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 15:41:10.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qayR7kCy1m2gIbl+M8FVpDquiV5f+S4/2PHzaF9J5Ws/6mrK+Qnr/FP+m5zOEcvLz7/11xgAu/bCGnUlTUgwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB8015

On Thu, Oct 22, 2026 at 09:20:59AM -0400, Aaron Tomlin wrote:
> On Thu, Oct 22, 2026 at 02:36:55PM +0200, Frederic Weisbecker wrote:
> > (Adding Marco)
> > 
> > Le Wed, Oct 21, 2026 at 11:47:37PM -0400, Aaron Tomlin a écrit :
> > > Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> > > CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> > > threads from executing block work on isolated CPUs. When all CPUs mapped
> > > to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> > > evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> > > the intention of offloading execution.
> > > 
> > > However, kblockd_workqueue is allocated as a per-CPU workqueue
> > > (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> > > workqueue core resolves the target CPU via raw_smp_processor_id().
> > > Consequently, if a task executing on an isolated CPU submits I/O and
> > > triggers an asynchronous queue dispatch with zero delay (e.g. upon
> > > hardware queue congestion, tag/resource exhaustion returning
> > > BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> > > the local isolated CPU's worker pool. This causes the local per-CPU
> > > high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> > > the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> > > will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> > > in addition to introducing unwanted latency jitter on nohz_full cores,
> > > thereby defeating the original objective of commit a46c27026da1.
> > > 
> > > Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> > > from housekeeping_cpumask(HK_TYPE_DOMAIN) via
> > > cpumask_any_and_distribute() when executing on an isolated CPU, and
> > > otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
> > > unbound fallback paths in blk_mq_hctx_next_cpu().
> > > 
> > > Additionally, for single-queue devices, gate the check behind the static
> > > key housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure that
> > > common configurations without CPU isolation incur zero overhead on the
> > > fast path.
> > > 
> > > This ensures that:
> > >     1.  When executing on an isolated CPU, deferred queue work is
> > >         cleanly offloaded to an online housekeeping CPU across single-queue
> > >         devices, hardware queues with empty cpumasks, and offline CPU
> > >         fallback paths.
> > > 
> > >     2.  The per-CPU high-priority kworker on the isolated CPU is not
> > >         scheduled, avoiding priority inversion and latency jitter.
> > > 
> > >     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
> > >         preserved, maintaining optimal local execution with zero CPU
> > >         bouncing while avoiding timer pinning hazards.
> > > 
> > >     4.  On systems without CPU isolation, single-queue devices maintain
> > >         the zero-overhead fast path via a static key.
> > > 
> > > Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> > > Cc: Ming Lei <ming.lei@redhat.com>
> > > Cc: Jens Axboe <axboe@kernel.dk>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > ---
> > > Changes since v3:
> > > 
> > >  - Create companion blktests test case (block/050) to reproduce this issue
> > >    and verify the fix (Daniel Wagner)
> > > 
> > >  - Gate the single-queue (nr_hw_queues == 1) check behind the static key
> > >    housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure the
> > >    common case without CPU isolation incurs zero overhead on the fast
> > >    path (Jens Axboe)
> > > 
> > >  - Wrap the evaluation of cpu_is_isolated() inside guard(rcu)() in
> > >    blk_mq_hctx_unbound_cpu() to prevent an RCU lockdep warning and ensure
> > >    safe dereferencing of the housekeeping cpumask while concurrent cpuset
> > >    updates occur
> > > 
> > >  - Disable preemption via guard(preempt)() around cpumask_any_and_distribute()
> > >    to prevent a preemption warning under CONFIG_PREEMPT_RCU and avoid
> > >    data races when accessing per-CPU distribution state
> > > 
> > >  - Link to v3: https://lore.kernel.org/all/20261016052203.489760-1-atomlin@atomlin.com/
> > > 
> > > Changes since v2:
> > > 
> > >  - Query housekeeping_cpumask(HK_TYPE_DOMAIN) instead of HK_TYPE_TIMER
> > >    to align with cpu_is_isolated(), workqueue affinity rules, and cpuset
> > >    isolated partitions
> > > 
> > >  - Query the housekeeping cpumask under guard(rcu)() to safely handle
> > >    dynamic cpuset updates without lockdep warnings
> > > 
> > >  - Validate that cpumask_any_and_distribute() returns a valid cpu ID
> > >    before returning, falling back cleanly to WORK_CPU_UNBOUND
> > > 
> > >  - Link to v2: https://lore.kernel.org/lkml/20261015020225.422107-1-atomlin@atomlin.com/
> > > 
> > > Changes since v1:
> > > 
> > >  - Introduce the blk_mq_hctx_unbound_cpu() helper to steer deferred work
> > >    to an online housekeeping CPU only when executing on an isolated
> > >    core, preserving WORK_CPU_UNBOUND and local cache locality for
> > >    housekeeping cores
> > > 
> > >  - Apply blk_mq_hctx_unbound_cpu() across all unbound fallback paths in
> > >    blk_mq_hctx_next_cpu(), comprehensively covering single-queue devices
> > >    (nr_hw_queues == 1), empty hardware queue cpumasks, and the offline
> > >    CPU fallback path.
> > > 
> > >  - Elaborate in the commit log on the triggers for asynchronous queue
> > >    dispatch (e.g. tag exhaustion, BLK_STS_RESOURCE backpressure, and
> > >    plugging) and the SCHED_FIFO worker starvation hazard on isolated
> > >    cores
> > > 
> > >  - Link to v1: https://lore.kernel.org/lkml/20261012012905.267920-1-atomlin@atomlin.com/
> > > ---
> > >  block/blk-mq.c | 31 ++++++++++++++++++++++++++++---
> > >  1 file changed, 28 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 025a799f35b9..f8f862a0e525 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -2241,6 +2241,23 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
> > >          return hctx->next_cpu >= nr_cpu_ids;
> > >  }
> > >  
> > > +static inline int blk_mq_hctx_unbound_cpu(void)
> > > +{
> > > +	guard(rcu)();
> > > +
> > > +	if (cpu_is_isolated(raw_smp_processor_id())) {
> > > +		int cpu;
> > > +
> > > +		guard(preempt)();
> > > +		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
> > > +						 cpu_online_mask);
> > > +		if (cpu < nr_cpu_ids)
> > > +			return cpu;
> > > +	}
> > > +
> > > +	return WORK_CPU_UNBOUND;
> > > +}
> > 
> > Just for future record, we are working on a WQ_PREFER_PERCPU workqueue flag that
> > should automatically handle this sort of things. It's not ready for now so these
> > hacks are still necessary but keep in mind this is a good candidare for future
> > simplication.
> > 
> > Thanks.
> > 
> > -- 
> > Frederic Weisbecker
> > SUSE Labs
> 
> Hi Frederic,
> 
> Noted and thank you for sharing.
> 
> Sean and I observed this behaviour on a kernel with commit a46c27026da1
> ("blk-mq: don't schedule block kworker on isolated CPUs") applied.
> 
> We will certainly keep WQ_PREFER_PERCPU in mind as a cleaner long-term
> path.

Hi Jens,

Would this patch be suitable for inclusion while we await the introduction
of WQ_PREFER_PERCPU?

Kind regards,
-- 
Aaron Tomlin
