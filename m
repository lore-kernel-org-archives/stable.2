Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA891340401;
	Thu, 25 Jun 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398351; cv=fail; b=J+43nFToJYlpH0c0zY5o2YLRHiVzDRwtJNDVsgiZGANBIE8Kc+xXP2bXjCAwS8/lSO/sd8e3Hx+XVCzDQB+uqZixPnoz5BCUjcIXSgOuGseAyE8hsGAdLqDsvYwJ5nJrGG/QI4+ckUrRiS55XnXU8ECx3mCPIFFeL/AWA5CJECo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398351; c=relaxed/simple;
	bh=DDfBTrhOqHDNoIBK3I766qM1GyTv3i2BSGOsxDyemG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ERvBYM9gCC87TVDZRReCY6keWI7ZkbRZpZl4GQdp72VQTJ9cI2ISD2IK1AlrZ+5qF///WUL/0xemovr4rnws1+ZYJRGMmjvrrguh3GatwGp+1u2EnKLa4vW3YErjlTa9eFksFvsT6ANs2FLkg+sMQyfaMnDzTeLeFb5Lu0OUAW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NICCn6O6; arc=fail smtp.client-ip=52.101.70.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NICCn6O6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlLg05r3bTUOpsU+FQVo16P/r+Osqp/CJMe1IH+Lub95s69r1pccxjC12JpOH1oyiI4n34C9KrsoW14TE7tOSqxUXyT/PCJZvUmtwY4v1i9PNZ5xd2bxpj+e9pg3iP0i9sr56uLrpNwvdzDPDclIIZfVEkRCxBjconU9UQkgp2IoqZVpJ3EvPEDKTRLELQOZgg+kADAOG/m57rkRZE9s4p1tXa5YqWWG5SeMIgu0pJbCmDIOzpMTMIH0EY8IRrBuNPbmFOSfntmTNyZ/osu4zr9wAbmYcm04FlFiP/kdiHO8NO6ao6bldpOL6dHkAG4is7kSu6aCoZlaqkO4o6nQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf+EJLc7vGKNgmr5B3Ga/GakusVZ8yuB8Sp119qFNPY=;
 b=RCieu/y3OP8o0kP8X3oAh0HcvlolHO8fSWVgMTIADuMZgeoDRyE7JlxNVxDRJVM3Sa4/ys9B96AZ8x/nkEHrR8STEP7uCOKRH1hTVyrP3nMkazMPSRKS1TJiInen5UN1CvRw5MVvtD4PExQvzIzMymfs3nrI6qQPV+tQJR/TlBDbjzQPvvCDGfmVBGCVI5oNxk5fezo8oBxqfAfef54EM3KZXjQBDBxTsWDUOZn0dlj8tjdLEjQjKQlcf4MHd0L9HoiPXcRVPIo24kf/VlL/rWt27UwB9lxPStvckc9Q/p91usJD/egfZWCa250jmWHx3mEr77PE77UHDo1RgFrtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf+EJLc7vGKNgmr5B3Ga/GakusVZ8yuB8Sp119qFNPY=;
 b=NICCn6O6cF6H+NZCv/PIBKJ2ZGe+dC6u+CnPOOb+oMq9MvPpJ5NweRcrJKUc4FFZtFpSxEjvtnYNYH7M/ukA7CwcO06kpug6D7Ib+oSlwt4IUnRNuRQ6rZk+Xappaq1iWZTGofY3M0ZF6Zbr8+1Gbx16aI6XVNCAocqxXao2w/6NOu4n+DdLZiwrpR6Ri3CBfStLJIOfTtnL8F5s4niBxYkLv+D2Zx108WrBvjU6XFs3nGPIAkXR96S/I+q3oFC6g3fKvgD/R3FS8c1DtwtTvAO2AsgO//ARakP4vDSJLghIsAKFVf2/Mtw+y2bd+usi2wtv2iYvuDLuH8LQabgK4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB9078.eurprd04.prod.outlook.com (2603:10a6:20b:445::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 14:39:05 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 14:39:03 +0000
Date: Thu, 25 Jun 2026 10:38:55 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] i3c: master: svc: bound IBI payload to the requested
 max_payload_len
Message-ID: <aj09fw1M1CJ0GTLE@lizhi-Precision-Tower-5810>
References: <178227747353.2931373.15868718612134648277@maoyixie.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178227747353.2931373.15868718612134648277@maoyixie.com>
X-ClientProxiedBy: PH8PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:510:2da::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abd8a79-7ba9-4591-62f9-08ded2c780b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5f5ohEWXLejczYcBcvJpb5avtWa43bNNlKEPxlkdC+Uaau6IgyCYi5adpulHcytGSegRXi5IRGZlUOmAdTU0J9/l0ciqqCOqJUFACZ2NE/+UcQ6wrKBjv0TuZO/y1OWrd/Yrna6g6YfuOXMNC1pOF0BCW95t6SMsLYovqXfcXavj2pAcnLg7P1oEhxmyvrBS93ikyUcY2/slXJRxzk/gN19PQuK+pB9HSkMVsTc/prmBktHSMnhuvilNwyPif5ErIoovh2+QGk5jC5ysunNNVXVVkTx69krAi8hSL2xSVQNPYdDqVCv3q/LJoHHEMgi2C9zB2d5dUnuggPg9SBE2SjbqN8gEMfzN05nOS0h5DjK/1i7jrJNrRMc1wN55BrPuaXZBc3oY2NoViVbZSQRBTLK8tTm54sRQm7FYD09e3EivTB8uwj/queC/1idQTe6mdjH+KfwDxGjTLx6Qj0X8TwJmSlerYTaj3ax8NPr9NB+LTF6TmjRTGq8xyLfvsoF4VHw26npHvoJ6rXNQsAXfrUFZQqnolw7h+1AtaFGDxN4gCZNkdgeqYsDZIgQZNDyunovhefk1w6mfcZBaVYyI2ipZptu+12zgQh6A8VYU5E/XAJJyeYA6p1o3fecxQ2gjSUG4zW1JPnsUnoq9C+xyQlYVXnrEGmvpqPRSwEsY5FQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8DTV8FLHADucuOPf/5koDCAm0uEtb+23oYgl/jwb1cCoTIEcr76gPr99fANR?=
 =?us-ascii?Q?WXYAp5M9I+ut5rkoyC+aunELKTZ4ayqknd9ETtIhj5ykUIcO+weKbpaOELp9?=
 =?us-ascii?Q?AtHKr0wZ8kbE6U7df1UkM8JqlxOcmKOdvnHphhdT5CfmJJhsbelCbHkt7Y3J?=
 =?us-ascii?Q?+OM4MTP0MNkT8FKJo52vfNYqHxJCW2V1w08HP+lDaPokYdYbJhNvH5IoybRu?=
 =?us-ascii?Q?SLGFQ8LgrbYi7Xn5Z9aqfbGgO6N6YIXuF9eLY4HyGM5OnGa1C7Gn+8JbJIxf?=
 =?us-ascii?Q?995E7dhV2P4LMnhNKsKCUhmGW1sdgFMsyqzpvpnNapHYBoWXbAs6P0+dDfSX?=
 =?us-ascii?Q?P+QW+9zCe6+1BjpZZcuYMfs0NSoVOPy5WT3VtF9m1K/l7c5e96sCINQq8dAP?=
 =?us-ascii?Q?AR9NlfEbrVzUeCLx9ybXXhUt+11sutYa7wdJEKBJklIs5sh4DbWqgj35COnm?=
 =?us-ascii?Q?oG6UylHatI8TUDHYYut6Zeq0Rniejwl97o75qI+U2bxo301Gphez5Y6Yyfxn?=
 =?us-ascii?Q?hHoz4j4OEx4c2NhQ4E6puXLkEHAIwuzD9xQndMbgUuh2ELztXW5ww9Jfftma?=
 =?us-ascii?Q?MC7qiFvDOOvuG55qWh9ACEl9OIY/Oz3tyI6o1R1pJ1KwIZ2dUTAHBKZM6V/9?=
 =?us-ascii?Q?Su5SuVa7YUv5Ieq//wNoqQdQlsdfphe9i/PV7gSTmEKC5CGUW7xAY+UANQrL?=
 =?us-ascii?Q?HEBxAnefidVcXLYufHoxcsapm1YvQ/+5ZsKtMBodEycdsmLw7watoTS9OM1g?=
 =?us-ascii?Q?mdEqlzafu2Q05/43sUQzg2VIOp0UUezuyUsde5cJaIFeK9RPOKhTD2AZrE/9?=
 =?us-ascii?Q?TbF5uSahrTNV+idRIQP6o7uTXOLHcpkubW2mpQXwtS3XVPLxWtkaMmkx81LR?=
 =?us-ascii?Q?YD0wUXCRjilogTzZpoK9avvoBh5pP+B+94wR31a6sitJqCFhiisrYQraQUD+?=
 =?us-ascii?Q?vSHiy+5und1SlclH6kELauplFfaJh19sUtjGq56sRpkDrx8oxc2Wl49py1Vf?=
 =?us-ascii?Q?VEiGNR/kAzC1vEiAZFumIHuwgDcSVSHKpuVj6vLnvou1BqONTctrXjGsZs2Q?=
 =?us-ascii?Q?BAEwaCNNndpgsIUEzr6AX3xp6Yw55cjbv0NnHdcBZAs6df/wrJzgXlmBsbDM?=
 =?us-ascii?Q?dMc/MCLZ+NRzEbruqDuSXwxHvHEErZDD8ASqosaJQQNPaK3lvJhuOEtt3v7J?=
 =?us-ascii?Q?0UAh763AObQAW1u6Ewppq1rRiMNTHbWB9v9LOFJV7zfJ5pf8ej2wlgePAos1?=
 =?us-ascii?Q?8icMJjvnodj+qx6Oi51SaihEvYHl1A2rVLxr4J7g6WJDj5HseiySomPbtoAx?=
 =?us-ascii?Q?0ZXqBcov5s/iTicTydPOxEsOHeXVoE4v/uCxzrygxhD9Fg5krvkCzraVNZTT?=
 =?us-ascii?Q?8L+60HNrgM/dsi6NZbFFg/wrFbhTQjS3+sfsDXJJpgTv+NQpzYu6HNuMPEcm?=
 =?us-ascii?Q?zJpvj/ETKqH7BzO4x/vOltR3ihooKPCNalMsEk05Kg8G8VW9EcQVoSuAa3yt?=
 =?us-ascii?Q?+QIh4/Xw2SlLfgdT94cIM/aGQXkIFKA5aQapfeN3d/6IPOWQC6WJqvKWZay3?=
 =?us-ascii?Q?6yWY3dYaHP+ESmNZJw9qIjisl+eD4nEt26O8HvD5sAhNIP7EVMkBubd4C8gw?=
 =?us-ascii?Q?36smci3930cDpme4C5WtPZ4ydzIyc2EEH9ZZtFr9uEwO8ZG/TG4xHWGTiv4m?=
 =?us-ascii?Q?f8LXndCv6t6Dko41/kyKK/vjaiOcmLj1lXglu41bz/b8EYSpG0DWA4MQMpfU?=
 =?us-ascii?Q?SCEg5Tuzy3xQi1bW+5baeWZrBVxDDoHde9zJUifGVJBLrwz6WIKU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abd8a79-7ba9-4591-62f9-08ded2c780b3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:39:03.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vw7QZ/nE+RgHWEMT0GnE+ETa52+x5rbC3bO95udxMnIsdV2qVPuUha/bUPcT6Ni89n4XJgXXVTi87cLn6xKLZFqO6U3Ueav8ntvN0+f+kIBv1OtXuUR3+5bYUF3kd+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9078

On Wed, Jun 24, 2026 at 01:04:33PM +0800, Maoyi Xie wrote:
> svc_i3c_master_handle_ibi() reads the IBI payload from the RX FIFO into
> the IBI slot. The loop is bounded by the hardware FIFO size
> (SVC_I3C_FIFO_SIZE), not by the slot size.
>
> slot->data points into the IBI pool, which i3c_generic_ibi_alloc_pool()
> sizes at max_payload_len per slot. svc_i3c_master_request_ibi() only
> rejects a max_payload_len larger than SVC_I3C_FIFO_SIZE, so a driver can
> request a smaller one. mctp-i3c requests 1. Each readsb() then copies the
> controller RXCOUNT bytes (up to 31) with no check against the slot size.
> A device that sends more bytes than the slot holds writes past
> slot->data, an out-of-bounds write into the IBI pool.
>
> Bound the loop by dev->ibi->max_payload_len and clamp each read to the
> space left in the slot, the same way dw-i3c does. A device can still send
> more than the requested payload. Flush the leftover bytes from the RX FIFO
> so they do not leak into the next transfer.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2:
> - use min() instead of min_t(), the types already match (Frank Li)
> - flush the leftover RX FIFO bytes after the bounded read, so an
>   oversized IBI does not desync the next transfer (Sashiko AI review)
>
>  drivers/i3c/master/svc-i3c-master.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index e2d99a3ac07d..4eb54f9ee2cd 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -465,14 +465,22 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  	buf = slot->data;
>
>  	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
> -	       slot->len < SVC_I3C_FIFO_SIZE) {
> +	       slot->len < dev->ibi->max_payload_len) {
>  		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
>  		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
> +		count = min(count, dev->ibi->max_payload_len - slot->len);
>  		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
>  		slot->len += count;
>  		buf += count;
>  	}
>
> +	/*
> +	 * The device may have sent more than the requested payload. Drop the
> +	 * extra bytes so they do not leak into the next transfer.
> +	 */
> +	if (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS)))
> +		writel(SVC_I3C_MDATACTRL_FLUSHRB, master->regs + SVC_I3C_MDATACTRL);
> +
>  	master->ibi.tbq_slot = slot;
>
>  	return 0;
