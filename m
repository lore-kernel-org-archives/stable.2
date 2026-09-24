Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9CB3D3301;
	Thu, 24 Sep 2026 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216126; cv=fail; b=cxNSyG8x9AL8ctaLVhM2NmciIy9u28aD/KZAB7Y/W4IW6qHO+bcGkvBkMHgObgGGS1f8jb2wuXdy6qY58oImDA2mMhLJG8+86BMLb5l+VSJi0NlxIZC/qyP/sk3Iw7Vjh7ykgIGe46YTso9VJuIUkoahDy7q6DFeKSueH7B68CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216126; c=relaxed/simple;
	bh=DbB1OX5IfP+Aa4JJZFZeQmu0GaeD9cYFh6QIpCUPBa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cM7Ny3Kn5ooYGb8/bN/PQ50CunQqyQNgqeO64rJNcw71EnJ5pPkw8XhozX+RoyBk2LKj0tVCMsODKYMrs/8zPBjuQ1XXtXoOSsrAH4VAdPC+Hynf2qKLV9O0lKEFRfwTNy5uo0FvY85bRZv053eq5tWCZ9DIZZ9DAUIOTckdg30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P+mBGn9A; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+mBGn9A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ls/3t/JSeW4YVSMD/MVRSQfcM3Yc17Cyh0JCkn92LsEn2RnKB8+yu7cEOcx0C4iNGnLaDRHaoSuA9XlBwfPNybEsNCJWN9WPR523yJT28Hr7E68chodJebacKA7Kt2DXGIQokgASZTPBmlzOMJfEIWo+tveE1FDFRPbpK6q5QH4L2bnSNiOYzlf7Q6lHzzshjjaZ8/pN1O4tLE5+xnczbe6DfBR+F1+/wFfOeVyhHr42EYWa6fjEQl9b+WbwApEZ87jJ4211YeI7xEe0advMZLHnngGoz20gft5v3s4Ey5kLhHaqSO/Vnx0lR155mQhVjYSlBIaxlP+Fc7+Avm262g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7SxZfaMUcFZGp8qT/QV79t6+TbCtHEhX+9VAx/x1dk=;
 b=WSZLvECA8nn987/GisuNwApRe/YfpO0nnZ2S+Pe+jlg8ZgPAFXdiQOj8YYR8UBA7dlWnZWaP9dxrmVqnACly4r9tl0Viz24bZi5p9NHVRCXf1Q8wIECGqs64qpsdzs+og3fzPVkRBuuZ2QN1F7sXM4LkExtbiFTS2xIxhTakziHd0yqq0phs4pfG7P0EObJ78Z+JK+tbTwpXdy3rbARgP7m6dvGkQMGzHiZytbAxYylpg80LX8ZL4jvP3Dq+Ktkp//jyD3oPuWmi2z/rtI1FZLU7m8q5nxt+xwxA404bMLaCOIUCPgnAJv9pGQXVqASxNmWT1hVLuRInXLSWKTMpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7SxZfaMUcFZGp8qT/QV79t6+TbCtHEhX+9VAx/x1dk=;
 b=P+mBGn9AuRNqrGCndE3Zhj9+hKjv0UWIUm+XqPy0PLmYMUH5HjB9bWA9v0DWSinRMpTTEW9KP6h1rBMFR4M4R36gNcCfFn3pTfqd3J5HYQ3F43Ksr9HtL+C9ZQZ9f96Ijh4x0xyJ2RO6rj2rW/ngcuV9KlE5AtbU9/1GHyNlggUzxV8X+mJvHVwo8nU0+5rHQEIcKdc+PXeDb1blbtNL/Km3YJGuuvmAWVJ7GSNn3mModxb8ovrxFEGV9NSR3QOUoN7Ewva2qK95ForzMiiZPqSBexzaAZXkR6H4MIzWZCEmczTtbLLZ/zs8lbcC8haFjDn95k1wHqumd6bbeSWPXw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 02:15:17 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0428.018; Thu, 24 Sep 2026
 02:15:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, Frank Li <frank.li@nxp.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sashiko
	<sashiko-bot@kernel.org>
Subject: RE: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Thread-Topic: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Thread-Index: AQHdS5tstlaag/g0dkmYtQrGXydJr7bc/JGQ
Date: Thu, 24 Sep 2026 02:15:17 +0000
Message-ID:
 <AS4PR04MB9338DCEE973A1AF4F6F59AF288812@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260923203738.1583735-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923203738.1583735-1-qwe.aldo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|AS1PR04MB9698:EE_
x-ms-office365-filtering-correlation-id: 4b007be0-5cc8-4814-b855-08df19e1ad67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|23010399003|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 6/9jxG/Xq3D2EMtDRAV4snqcNE+R5aTLx7JRL5nDUZNnzLNKLpLDWNH88QHt53IScnfwO8sVZwUurUciZyMrZ1lSYMQXDLf3eEE45xuMuGsmvCTj6MkIGilkvNlDMJ2tjd47MiXglDyHtrb0KqEtaB+wDzO3Ht9G1t8aHSsCIa8gtvqnSuEkO/NKY/Uz7cOunSUQojNO196GQc0lE+zesXVCREsjsxEh/2FXKZMogYpiu19GhLiJwuVFVmTm2gStPjvEfV1JrUR+cFKS/rQeB7ZCsvXD/Zr5eAgVaN23d6aPlzwnoJBbIkUFABUlNBo4EbTT4hQc9B6ImndbeB7oCRGqtG+pFGfeSPhV6MvLwXTZffSbvBExRRmvu+e0mDMT9F2yKXG5YIn/IRWZFM5Z6yjiXuuFD8VBKdcJLxfGvhmfy0LVNPAUlThVMva2q/rDvIMkyLAsnpE6K0lcIjAtGJiEiQl8UY8A2iENZkKDeT/m8cjrHWBnMXj6m5if8fArmyPVF+v7Go63TYnapDgBAUpvCsS5k2sujA0O5DK8HtmE1U7PZVR5DwWu7oujx/J/zldMXuR07gZBsG/JbDKmS88+Jx04+1y136NftXyCHUGzgVSY+jXaoOEN/EnV5BEK/ZyyExhWPsPdA4cScivt697EAtFxCoqXB0Jw6FvVtSk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ttTjrnFKLiA83162XoORP/aI4D2jxQhyJQXin0FhEWoq49aqT4ZxUWx9NhNQ?=
 =?us-ascii?Q?zH+zv4P9YZekcKCoOyl/652W1uylbtffwu4ZU7Pyi/1lk42LZgHXpjpAa9Mp?=
 =?us-ascii?Q?30BNTEduhoT4QJGsaUKr2IK86DyeLu/e7MQgApCX/Yo3lLUvKRtw1BHXOqnW?=
 =?us-ascii?Q?Esv8ePgzblEhRbYRdopwJZcPBOqccONeez0n2qJGyiQJ7QqfwDu1kM2KeKbT?=
 =?us-ascii?Q?OglXEaiztU5Tq+I9/t4TCUv5MJNP8mRtiXJ0LbswNlW0dGZTL1OR57+EEt5C?=
 =?us-ascii?Q?mxEY63dF3ogWQW7AamY+B2JcFrBlkoSlODLdPnYg13GZ1lWt0MM/wIqtVWDF?=
 =?us-ascii?Q?gnAcC+Dea3fX0SCtdpLnbEjIf2G2NObDmzmn9MhQSE38i7fldv/Ml668A9ZH?=
 =?us-ascii?Q?qQ8kygL59rU1D2CnaEu5A+OlbDPG7GDXHcr1yqArYBEkmNMzyCpCr6CM7xRw?=
 =?us-ascii?Q?hxSNRfomSkhQumrauUFd1be8+vqSn056yS/ijm+uufFSWQr/6twQkjyq+mjX?=
 =?us-ascii?Q?Zx6jFgC7dXFUI/8BYrWOG4e/h86GAJjHaAFTYpgrV77vTtPVW4fAwjfZlMDx?=
 =?us-ascii?Q?Cq0+ezqBfrzqYEdiqZXzzNHz38aroBnHBd4b3Ph8K7lnwMjJN7hhcpBGomH9?=
 =?us-ascii?Q?Tfdc2cnbEpPQxg6M6eYJyVNYY633y1JMD4i2gj6rsvdJAzsmAKATth1zYatj?=
 =?us-ascii?Q?eN2lXQ5IKJvOVO7Li2COOLi1uhurdVhy+vWg0SpCjnZZlgPds8/mTaSRXDT5?=
 =?us-ascii?Q?l6sf5at1hOqyMaobKnJKTJvr1lmOGlYGK+SNUvb5/vO4LtjukjR7CS0VW9VK?=
 =?us-ascii?Q?KGRU01d2LMd/nsfbdijAt+pNgae4UOyWqzCBFIM1xHkAGw30WBtV8MgD52wf?=
 =?us-ascii?Q?u0e9nIezk1okeM9RHN/idqyl3ZDqmQc5xCVBm3AnLgqn8mapsSpKBLlWle/E?=
 =?us-ascii?Q?O9aXAm/56J7s3wkfimHAujGlGq7+xw99XVE7vUdq4ZI87qoEMjVp34hEIpEz?=
 =?us-ascii?Q?PuSXjjcOh2GaqFwW6RCnvl71jYhwJCfrrLWFbqiBqwp2bW7Qb8AWmwXCeGfV?=
 =?us-ascii?Q?B1fWuPTGO0HIDHg1dq/h3nwYwpJBZHzR4mEnCy+l51lM2za5Mc3LAHRgmq/K?=
 =?us-ascii?Q?979rOm/5lJauy6zr9PBweeY+xa46Cg0bSBFYS3qL7eRYC1XIWz1qefFnSPHV?=
 =?us-ascii?Q?MkH4BPh/KJszfvc70v9wdFvjqLnS7NTqe6hMfTh39nRyK9UNyJdm6ZGB6U8T?=
 =?us-ascii?Q?QJqHCmckTbPYvZ1s47/Ydp1m406UyOsV1ySGQ1CiQhTKankW59wvwHoMBRhA?=
 =?us-ascii?Q?SXp8QL38bA/RU/Sb4ZhJ4+fbC8UTDr3uRZmSnjZsVIIkqKNBrw657Rjp6hNE?=
 =?us-ascii?Q?Iuuvd+eSstHCYQkCl914JW+j+28u+9Jp5smTvQHallcWXcimVqQZk3IRFqJo?=
 =?us-ascii?Q?Qk6mMHwrMiAIJCgQtM8vXyOQNM/3m64PdT/lb/WA6NEC/RAqwMW0igOX5XcH?=
 =?us-ascii?Q?Yf8XMquh7fI1b5Lf1H0kI0Zm0RItrgYyafh6Uf5sRQb6b3X5P0MC460xNtsf?=
 =?us-ascii?Q?0k7rO08fuaEdelQ5P+CcO4mmzxay+v+G8BrW1nRte1o/6okJTFsrwr8vXfAH?=
 =?us-ascii?Q?avVFIu9dt0625L14jZeeh1ZOVfuwGR5nytEO2ct8TsNKlRF9iO45neuBI68t?=
 =?us-ascii?Q?gSikwAkjc5Bjk5NMBigVkQhc3bdIxdHnBiDvVV2w5qPgluLG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b007be0-5cc8-4814-b855-08df19e1ad67
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 02:15:17.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ByZHVa6FLjr5UfnTYwxXzElVvQN+6OukoljMPNH1EPavMxqfGRYPAj+GSgcUi7MecNMHOS6ahy7+PiNwsSzHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

> fec_enet_txq_submit_frag_skb() and fec_enet_txq_submit_skb() copy
> transmit data into a per-ring bounce buffer when the source address is
> misaligned or the FEC_QUIRK_SWAP_FRAME quirk is active. The bounce
> buffers are allocated as kmalloc(FEC_ENET_TX_FRSIZE) where
> FEC_ENET_TX_FRSIZE is 2048 bytes.
>=20
> However, skb_frag_size() can return up to PAGE_SIZE (4096 on most
> architectures) for scatter-gather fragments, and skb_headlen() can
> exceed 2048 for certain GSO packets. When this happens the memcpy
> overflows the bounce buffer by up to 2048 bytes, corrupting adjacent
> heap objects.
>=20
> Add a length check before each bounce-buffer copy. If the data exceeds
> the bounce buffer capacity, fall through to the error path rather than
> performing the out-of-bounds write.
>=20
> Fixes: 6605b730c061 ("FEC: Add alignment handling for FEC driver")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 794ec42..8614984 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -558,6 +558,8 @@ fec_enet_txq_submit_frag_skb(struct
> fec_enet_priv_tx_q *txq,
>  		index =3D fec_enet_get_bd_index(bdp, &txq->bd);
>  		if (((unsigned long) bufaddr) & fep->tx_align ||
>  			fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> +			if (frag_len > FEC_ENET_TX_FRSIZE)
> +				goto dma_mapping_error;
>  			memcpy(txq->tx_bounce[index], bufaddr, frag_len);
>  			bufaddr =3D txq->tx_bounce[index];
>=20
> @@ -634,6 +636,8 @@ static int fec_enet_txq_submit_skb(struct
> fec_enet_priv_tx_q *txq,
>  	index =3D fec_enet_get_bd_index(bdp, &txq->bd);
>  	if (((unsigned long) bufaddr) & fep->tx_align ||
>  		fep->quirks & FEC_QUIRK_SWAP_FRAME) {
> +		if (buflen > FEC_ENET_TX_FRSIZE)
> +			goto release;

Where is the 'release' label, I could not find it in latest net tree.

Also, do not repost a new version within 24 hours.
https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/process/main=
tainer-netdev.rst#L15

