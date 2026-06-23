Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117C31F9A2;
	Tue, 23 Jun 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233630; cv=fail; b=rfkSy8zm+K3M+1X9dr2u8KOub1SVZ+ntm2ZQKyNtMl+0eg1TOGc85KtTtU2jn/4M2LAAXh+kmHpFYK3kfpSjExL0uWh5cLjRgH9VRF0rxtdBqding07WRv8AjZk5grrhbtg55EtxMm4oxBEXwtjLYJ4II+0VQ//qR4cIdrJqkHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233630; c=relaxed/simple;
	bh=xRNbW7jhTsyAdEn1h5nlIPf1dC5dIoGXsZWEhcI5tZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JlskGHtloT7YEkWrPXcxq/Dq1VWxQIu2GdQ7F9Ua/i3s2sRiJtraBiHe0aEIaLF75UyYXSD6tHWfqIJ5+z/nW6feUAsuk/J0PRRPFs6o4ewsBXsnMX2ucrmyeVSgvOQUklpuSMzFK3vjczkDQ8actCwio6bWKwl1KaNCajhxFhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XRJts/U/; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XRJts/U/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfWI0UV4Cr9r6XhZ4nU0Zqy9CEjy1T7IigVeFoXH3FbVnlWjj7ipmr5jV2/M9Zf1QDJL6/RX8Y7aKQ1cV9UGHTwNftmadybbdkpgP7QFkksvG+7IJDqybRGZ90YctbaWaowKvXaSH2FFkkBGARX56Ie9duGIu8NZQ/yLkwQzH1Y2FGjwaNY8KFmcy9i32PM66GqhoPCDbJ9q90f23rht3/8pZi+MeYuZ4afZGzoIdtHhAKfbsYpLzJeWu1nd3ievNDuBHAr4Q1r7QdbnziNnyVd8JzGCksJvfTm+KP3S6HqJqCf8Jt1z+4PAezsxoeUbCo/j0M3ted7IZ0P6VQPCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUtdESHxhaJeGspxCeVPAOwSlReocb252ueqdQIsu4E=;
 b=zDsLXuppGvzQjJGGTLk46LnLfslhKOxOK287cUrVmVZ69It0KM2mJcEFmXI6ftTxt58+mMk0OuDCWJZjGgUp7JoKVoG0IGRmjG0q3lSPMb7/1Vczzz8wOVqRZ1htkklXXRt0luTOBRrn2Pswzt+3fd5luwzN4VCNGhPLaocPBt3wgryGBtqN0Sk0qnK0BcLscz4ZuT+g5ezZJiQ+ebpe8aLk+yee9mBlRbc7yZWAEJGoFoBNI+Vx5FtKN82pg9k4u4067uQudJ9mpfq0kyouQ4zO3qkyf79crpTaRfT+5cKmWa6iclGB7zyp/Na34t0vyEGzIG8Yf1qwfNvtr3OK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUtdESHxhaJeGspxCeVPAOwSlReocb252ueqdQIsu4E=;
 b=XRJts/U/lCWMcP2crBPxv+ZJUkViVHItKeGDDOZ21IEAevMAOkb65veen2GjSFEIbm6GF/unrQkAuoY+J9UX+1GPGLrZflFV+7mcC9cQAM1iVo3I32HRMYW8/VTTihKnwLBsqD6R/Bw3mVEfjxb0KSlUxwGeXUbvOdGDNjzTLBrgGYOyprYQ+l4dZwx5R4iCCMzUMUq9qn4QFneDatiY6PmEbLr+A2HXVZQ3M1zvOAXKH1LrRT5DknImiqOjkHpyN064wqWtDS3gP/4l/i4RbGV4End44WUE2c21G9wFh36jaWpKRM3ISpMYQJiMhFlf8p9I26RVRarboBvXjp9pgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Tue, 23 Jun
 2026 16:53:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Tue, 23 Jun 2026
 16:53:45 +0000
Date: Tue, 23 Jun 2026 12:53:38 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: bound IBI payload to the requested
 max_payload_len
Message-ID: <ajq6EgLq_B5YtPIu@lizhi-Precision-Tower-5810>
References: <178222990006.2767135.12462569914183698733@maoyixie.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178222990006.2767135.12462569914183698733@maoyixie.com>
X-ClientProxiedBy: SN7PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:806:125::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b689a4-fdef-40d8-e673-08ded147fd44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yRIKQOE5h99cJbeeNWCauhfY7rQBUcLqMSOlYEKH6xRXOde+hF584MC42oo4M2VkHvVDZp7qtSqNUGiZA31PF9QROP2feQ5FV4f/Ct/q6fxqsQ35rFoecWvA8bvb4ML3I6l55TAu//jBL1dOuqCmWAvBiAnutvjT/AmLz8x+alDShJdzguYLc5mh/8/NKTRUKMQgneeY5BMBM9l32g3/37Cmtxtmnyn68F9MfX70ucubFSKzHPj6YLd4QJ8Lkyi7Yoga89rt/HKzfHfQYwXBs3x1m73UV7CwNFd6GcWjTR3F/Y8gp6TxreGwt7R2MZr7dqF3wt9PWqdMKpbgYXKEwLuHtX1W3DYjvfwfzJf0HdMdmedMM4q9oqdV5C3j3UjVu4Ko9w14LNthqOxfZZzh8n0eNwFNf3W3kWnTdAT8isfXxLyN7BpSHULlMVcm86kCq9XuGPCg33LpLXbvMsnyZaRSEMBY2tOAPxRJplNI2RyyGeWz1ufBEWL6Uc9M4D8DN2+KaIJlQqDU36led6ZtfCj2WW6v+K/ae9xlH/tJ6sGdzbTcvb3+Img0q9mnYHq2da6DyjNQ+/0ZF9QU/u/tlelTNS+7zc2iiz4zoeF96iEsLdh9reNoP8m4Ebcno+CeKU4dKZ2Zk/nGLtTwcf78F91T3BKXVcL+N73w2KP66DM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PEqPX8FM8G9vzYBhd4PD9w34u2dW3wYCcgs/79Cg68l2CTWkBcD29H2R4e08?=
 =?us-ascii?Q?+qIxn59MsIzSF/VNlZxWNGrS9nM25bj/WXN4cT8nBPsc7z+OFoiQDRfv1JP0?=
 =?us-ascii?Q?sFNjGMd/3KRyiFxOmnlv0Y3IhxZPqlPcXfWLWReiTB7mzYHg1g7XmOC44g9a?=
 =?us-ascii?Q?4EUa6QDK0Sc6fKKP82FqRhdUaoh0iorzoZL2ZhDrCZC3J5LBT+v6Ag9W6laI?=
 =?us-ascii?Q?cwNt4wFa7B3EFhc4P8wr5UqF7g8xlRMHtIOCFsjOIvHeneGNv6M9O+5L+Aa6?=
 =?us-ascii?Q?dAJj/dxporrvUzC9zoW6Jd2CTg941g9W2J78ik+FQyznRAtd5TyklU2OfxWw?=
 =?us-ascii?Q?8oCBx6hq4+PzBuo/RajedPSu8786NnoRuazQsDkEpD0Y4RQIaNh2zN60K5dB?=
 =?us-ascii?Q?IGpTXtQY55XYW1CNUMLNKXMqkwxtFNkI/BpOTRFOao9VaKtR2nfO4JgUAk5c?=
 =?us-ascii?Q?hDO8FJLppT66p0RZKK4hFbazSpm2Bb4298Fu8PIXeMDF52rNaPxjZxzammXF?=
 =?us-ascii?Q?GriQ7ia+Vk9Ksww+EJDTO3KQikLQVg+zlPFmQymkS27MxvR3esA8Jg/0YVO/?=
 =?us-ascii?Q?aKWm3GgL7tlz4AgrEm79dwrwKu3MpLaoMTpY1qcoGIATjFvhlT6s7KWb8BDX?=
 =?us-ascii?Q?RuwWg9cmMJ12mZGJI5lFOHNgBR2HoMKMEYqPuk6mF3cn5ukmRKvTcxt0nQaM?=
 =?us-ascii?Q?7EE3sGSPxt/IVEkVpGJA2BTmHprbcxPdehc3Ll/FKTN96DsNWMyr4pjnfL0d?=
 =?us-ascii?Q?32g1txp7UJLVmaeFiIQU7nymDCnr+Hg6APJrk17HM6cMpuDv/X765FBXj3C2?=
 =?us-ascii?Q?nZAmaq+BfKpl6vHPKu1obrJ2yEQVzfWUI3XBXMVn6xSmFn7M6pNPlqm6XBlN?=
 =?us-ascii?Q?ZeAwE9Ygd2NMmoD6agZ72TdBuZjYM7oiWIzXlbFNGw2N2EzOQERhlUAZuxBE?=
 =?us-ascii?Q?JbOypAwynek68Rw4Bt9JrA2ZAShH1lyFNlCffxSssl3Wtlm2tQBPPc/3eWgA?=
 =?us-ascii?Q?QI3m3ZnQa6pwyoC2wg6uts4NXADdTg/OfXgWFKTonalRAAVp3xIDrRKtxTnZ?=
 =?us-ascii?Q?lGniZ+Y87HQvbSBOcK4KCextkjUL91ZsvOTizdFJtweURa96EsKdnkhEuE+v?=
 =?us-ascii?Q?JkbzEp1OhRzsonZ8gxMa5masQDyPOCWTr/EqQO8uy1jt8QadxQjBPk62R4gQ?=
 =?us-ascii?Q?H7JhVc52t7F7f55rwF71V3YcbzKFjUl2bhAkOTxoF0joBx5uBf4G6Q7Jz/iO?=
 =?us-ascii?Q?L5MCiky2Ren++PcYLU+Jtiu9zbnb3QoYYJT+hFqWcMv3JbWStd2cQC+Z0eEA?=
 =?us-ascii?Q?f7n61AheNIOQiZunjU0KkU7RyChw3gL3nHt2Trx9y4420fYxrQbvbJ7bKQM1?=
 =?us-ascii?Q?g8fKo5mQzbUq+5kNLFYFeetxB23Kj6etSuyU9rlp+/vHTiXgHCFVBKt6V3xn?=
 =?us-ascii?Q?olBGD9Rv7cD7xbU+aii2JQUXyoBSwtfqjv+EGEusQLIUb9bxsimnknwQep6f?=
 =?us-ascii?Q?XIkk24Jz0pnHBzOrcLX2s3FrzYs7P1rUEjxMUcgCYkexP50mfBaLRoxuZQ5S?=
 =?us-ascii?Q?k9g9WtUOvTY8HXiYHEmxqGptSm+5LwSk2wA6BBoUurGLekP4//IGxqwXyFZz?=
 =?us-ascii?Q?ZCLzlOHRNfI1r43TgmZsAVzpcq46ILIoLkUkmiGtexEMsOlJ2cv7y6SNzLOE?=
 =?us-ascii?Q?dEaq5DzvY6qouvrfiOzz6he9vigco2zkRWQG7o0U0vqyuyYCKP8/IaErfqRj?=
 =?us-ascii?Q?zYfd04w7UzL1ud5nOxiSmJPAGwLdKB3LEfNA0UOHbVSmQN4AifFH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b689a4-fdef-40d8-e673-08ded147fd44
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:53:45.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0EsiGOaCPCyYUaNCfSeK8TwtW6Dh5wTtbYukKd9dm02UAXdp4Fx4Nb0Vt0DnohAA1IozeVOGzoFXXlG2Z0QbyNlOXepL/YaHZxzMigmt/a0ecPL0olcQstClDnI4b92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990

On Tue, Jun 23, 2026 at 11:51:40PM +0800, Maoyi Xie wrote:
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
> space left in the slot, the same way dw-i3c does.
>
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index e2d99a3ac07d..7420bfbdd259 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -465,9 +465,11 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
>  	buf = slot->data;
>
>  	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
> -	       slot->len < SVC_I3C_FIFO_SIZE) {
> +	       slot->len < dev->ibi->max_payload_len) {
>  		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
>  		count = SVC_I3C_MDATACTRL_RXCOUNT(mdatactrl);
> +		count = min_t(unsigned int, count,
> +			      dev->ibi->max_payload_len - slot->len);

now needn't min_t, only min() should be good
see:
https://lore.kernel.org/all/20251119224140.8616-1-david.laight.linux@gmail.com/

Frank
>  		readsb(master->regs + SVC_I3C_MRDATAB, buf, count);
>  		slot->len += count;
>  		buf += count;
