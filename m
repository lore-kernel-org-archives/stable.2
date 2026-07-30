Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAE408017;
	Thu, 30 Jul 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403397; cv=fail; b=gKr+9HEG6IyIFc2nwIQSy9cZsXV5rliQLRk8W073LdFg0rrwbhGCFn3QJge24JcmfHT9DU4qV4cPSPU+p8WadPieYsFsaFISwC7J74zRWdoUW2qjZ3mDZyadQRt6zfoCQERA3b1ouRPA5t7l0KU9SixzpMfQ9lf1ozxxnRL8GFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403397; c=relaxed/simple;
	bh=obH2T2spzL5LFtShfIGtpUpifmes4xuNCvsC1iX01So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M0u0T2FbPjllY/GeIFDhFD/+XVypCOZdGU7FRy6chb/rBC3QLW8le1hsOQrRDJ2njuGzNvqfLS/H4ZCUmpmyBFZoWs8XuegTMowazoGMMoLE3Por+4BZtSghgHNrddBQEShWa/94ScOTN4GVjJQ86foq9VDkdxhw9PFKEDG/KUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fth9ojCD; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fth9ojCD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7EUlwzJYutezox4B2DgJ6Dq16kY7sKK2KnPebOzcRtGWWsVTFEnw5+q58t/CM5c7O1fTPVaXQwugxr6VOOHVSISOKpSEgXJDAf0IvAryGbqgGtpYPCdqHVP3fLxJx9PCYuO2cd9k7rDTnRcY/9rOkoAQQaYCs8oot4RmjKaEJRrllYZVWDcAh6FHjAxj5Yk4wjP6xcQSRZizs5koef9/ZA143p3T1u6tGLBMNQ9/vYWF2qw/M+t/Q/vBy90WW25FGfjd46rzzoVFs/cBwXJHssmlTnEawb0O/Lhub1zJgFtf3fEGtp+t3XGCuZvUhwGFmyITNwdBtPDN0DzP4OfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7DRnnNGSiO+5KKNm+SWtpXNFt80lLAdU2S8Jio7DkI=;
 b=hdgqIoUc+SEZDL+crPvjsXBNOtZ3peUfUOzSwvgJh8FrnTnn9nB+IkINLGpY+V1EWf48Qct9Qk002gSW2NqYDov7+VqV8bZ99HspfKCdNLp6W7Rgt05V/IlH75n/aSCoQGKmlhMKu/6wkdFexlz6UPghSY7+ymGsoIaxsU/+JFVCF2NX+orqVMpwjb701Myl+JaQjH1Pdr9UOgj/HmuRjCJ+H2Y8fjS0lAuH1B8j+AQr4k0c7RQVezt71wxoMyIBIYwbgmdIXnwTOq7icPyTCOAz1UdHrGQcmnMnj6Dq04eFvi5pjXwibe6izQ+QH8o6Js0Gr+ibQJlDOXnaGC9GbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7DRnnNGSiO+5KKNm+SWtpXNFt80lLAdU2S8Jio7DkI=;
 b=fth9ojCDZgZq+FmKtKyhfcFX29erLyqwTqMbbEi2/z+4njFXt9SnPGk4P7SawRJs5WqMhFUMtp8xdsyv/P300hf2k+VGA5GbOwEn6EtNuuQnUksLhswBzasRocU2LXBLBcosOFG7MF8siunXVHW/RD10lDA8CvACbMx9jT3/4LIWK98eu+/QMXZPTy1sk30D5VSslT/yikybbOchrmS+5ohqZnSbM0x+t0AufE/L9uGbxexhEcMTUBYjAM00nP1WtGBzuSxm13tHJckzZNk23JGn9fze+0SpIkm/w0whfKV7b4Gdw9DJVH6EAkw+tLw2pUHM/iABLeqcBQDidvHSOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 09:23:12 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:23:12 +0000
Date: Thu, 30 Jul 2026 17:21:41 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org, xu.yang_2@nxp.com, Frank.Li@nxp.com, 
	kees@kernel.org, panjunzhong@linux.spacemit.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: uvc: Fix Null Pointer Dereference in
 uvcg_video_init()
Message-ID: <h4azn6c6p4vxsctlj37gs3jzzjndq5rrphaodcmknbsrf3ayr3@etv5qa6l6xzu>
References: <20260730082320.9597-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730082320.9597-1-jeffinphilip14@gmail.com>
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: da0fd347-905e-4032-4614-08deee1c2d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|1800799024|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XC9D12Y2nt99VSbirjsFJ6EqApBbi2xH/rvaclkhcWJaWOKS+cG0Bv5raHXYmHv7hic7Rg+nEbtL9Py9LG4SpL8KUY/As3k7RPJhwi225G4D8i6T6kFOdtzgE5vtVeCNdvCYFKAWfPPu7U44B/q5Gy0EJDZUNu6221n++nJJp5YdwQcAKI5elw0qS1DM0P5jVYPUkgssQLQQtobOsD8RKTn7q0C4NWWAift3nC+/f/3klEoBP8yqTR4xGX2df6q6GXulOMXrWMXOnOO+y66LEr3sIbWFGI4DwWEKHX4AN3DhkGMCsVRlJPIzc2/obxd7EL6lB4rFzXXaD2+8u22ALv/tPKOJXX772FonLyLpIGx0UHAIJGr8VcpiBgxsXEr0cjnmQMv8ctRlpTY2/Wc4paJW6MeuODbhGKkvZlik/EjhSetaNzRj+dZcQkRTlmWdNy9/WVv0oLsHr84zf06cVjAt94nuEUqloF4C3zlUVLQPjThTiUaMKazc7iaZU9pFHGVGN9kSfkKoeiJKvlr+pVexHqmdm6BOjSPlugrWPLejlw+T37NAKH8mjQ2YliivU66EB8uCO41Duqe+47/TbNYaaVhVwHIYTBFfHNqJciImZnMrhtE9aU+rufVDiqn2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Is+/sT1AcD479PN4bNB5MNpNnAwem7VAzmKX/xpPWQH6G3XNcuuDpt8nsfx?=
 =?us-ascii?Q?LA0uKdyVA0HHs4AwGPqWBRB4VqXLwDwyv226BXSa26BRNAmmyuOob8V4j1Hl?=
 =?us-ascii?Q?vjss7S2waUA9u3H6vZ42wEUbcQl2eFDBdGWhKF+dui9aQLnGlnTGKOJmp70W?=
 =?us-ascii?Q?bWDU4EklPsjzi2gltpj5KQ1hcMQ9yy6zK7kha/8ZsSn/XpbaPZTQ8YlUQC0Z?=
 =?us-ascii?Q?6Y4togb+nLDpkWynKzjAljrUCo7KvofjzMIqYmwOjIpHwDp+P6xztj1O0meq?=
 =?us-ascii?Q?tBWdpx0zeNJLcih75z2McjR4Tf9REn50KUqpo4lhTSMYBYwjD+PPsrG/71w2?=
 =?us-ascii?Q?Hz6acwFIFg0fVbtts44qgUq61rE9vLehVACJFl3uYfh/AcW+UvdffuSKkLF7?=
 =?us-ascii?Q?K51oBQhHlppFIyXwqGU0UY4IJxpb8xcCVR/61I8ND9QU2w4mqcFwy7MquRoY?=
 =?us-ascii?Q?ChD+3tz/i2osgfdXZwiJoHE/L9ElUt7WoFaTqSmBaxLkQVG31bJOEeCOZLbi?=
 =?us-ascii?Q?CaImfCHKlPUL4LThoHs8y75BwZAV+4VZWCWgDBtyBnbWYWjZIQXkcbnasNVl?=
 =?us-ascii?Q?zD6nGCNQgKRxnY2gVspTthwHLkn+fXe/uo2hkX1M3AHU13bVup8k8QxZpLpz?=
 =?us-ascii?Q?CL4/4FDGifP31PwuB8oByzFZCrK5CJqvUkfELALnx5aDINJZ2pilFuZrYyhu?=
 =?us-ascii?Q?JAPjmAmz6Pi9D/KI6ty5UkDv3F02o+cukYCygqIGr6Ejgj8EuBpjfgU6BULV?=
 =?us-ascii?Q?kwFnm7+DyCmOfywZxsnAMtAD+1Wz00aPYcTuvzR0rSuOlQmB7VV0vFxXkzZc?=
 =?us-ascii?Q?/4nV3O4V290dkUDssEuugOWDf/vT8Gp3KD/2s1vULJcMWphOGyuaAJBxJh2I?=
 =?us-ascii?Q?oteVyokQfrkZsUQe58lA3x2W2bBaoQlaIrQIAlm2IHRQT1+1PmTGsc/sOffK?=
 =?us-ascii?Q?HylIqltzbfsyv+p8AohQ8t8f7dhXNfD0KpUhHNVuhwL0iHOM2Eqtn1HcaycW?=
 =?us-ascii?Q?cUcMNo9hyzLzUPThYnNtGEWsa/mZ4lKRYyMggDJqzI7dPvP9JsqbPi6jpnJp?=
 =?us-ascii?Q?PJQOjHNJvU0X0uY4s1GL0m+t7JaU/It50e03bz0t2vjpwMt+IlIM352iFROM?=
 =?us-ascii?Q?hBYBHafkdJbPvYo3yD+EGzQP6HIJv42/pQ21Dny/9DzvBY9PaayVs6CXnzUf?=
 =?us-ascii?Q?TBEfxMdyobPICBI3v8szPLQb5PemlR9VRjQIRJHc6I9hPkCI4dq9qtrunKND?=
 =?us-ascii?Q?hiQJN4HxuglWclFtxaSmbCChM6cYPIdY3iXOlIKgNkJo2DlzrfrF26scIOAn?=
 =?us-ascii?Q?wTCrmnPL6Z58KgwXzg1cE6XH8PcMCFm09kc4mB9NknPTHPFKEfUeiCF4ME0t?=
 =?us-ascii?Q?HnMlNEvLel4eBWeGLBskLYjQhELP3HY3DNwfDTUeNz4VlPMElbALijk+mKKm?=
 =?us-ascii?Q?fRGncwimA8gi/F8PisTxBrUXroLziMGUqX3qRNMbWiXxE5s0hqMB0GjUMGsv?=
 =?us-ascii?Q?27x4cMNZBc4+YOoaytaJ6SiB/aO7rDMRzOqMQffDi5NxxtAY9cGxutY6nwyr?=
 =?us-ascii?Q?YolQqkfLMCYasCBzCY3SLCMP7CSLzK1MWu6wyVoNE3CW8XgeWIPoPi1zx8zw?=
 =?us-ascii?Q?gIZ5dLbimm1oVIJdtd5mgU8QqwlvrJZ+u49mSsYyFGfEhMHx6LdQwED151D8?=
 =?us-ascii?Q?SuazHqctI5fUCWfs+csq9wSAaM58qvOjG9Wqds0dJcjx03RUvUY4Vz/TlQxX?=
 =?us-ascii?Q?ov5TBdKgya0YNsuKU4cOJDorokL4tfHjJleSNpR4rRvZ0onGRBrP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0fd347-905e-4032-4614-08deee1c2d4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:23:12.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYth3Bgfu8f3NDAiXW04LcATKUh2SOOXZxgnwY6mb2GApZD5n0q8YLfW0MfqmG4nB1ttPHi52ckmMI19YXTMj5wA+vaSOh+rw9D7sL7U66NBbeBIN0AlgNvnHFAYB5Rn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784

On Thu, Jul 30, 2026 at 01:53:20PM +0530, Jeffin Philip wrote:
> In uvcg_video_init(), if kthread_run_worker() fails,
> the error logged uses uvcg_err(), however, the pointer it uses:
> video->uvc is not assigned at this point, triggering a null
> pointer dereference. Fix this by directly using uvc->func which
> is assigned already.
> 
> Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
> Fixes: 7ea95b110811 (usb: gadget: uvc: rename functions to avoid conflicts with host uvc)

The issue was introduced by below commit instead:
  Fixes: f0bbfbd16b3b ("usb: gadget: uvc: rework to enqueue in pump worker from encoded queue")

Thanks,
Xu Yang
