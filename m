Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32055403135;
	Wed, 16 Sep 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588630; cv=fail; b=dNLjV4+wUqP6bAdGKzd9W9jq/Z6iYUL5vEpeFAsE7FSBiYAACb/v5PQxgeBWos+rQcECzV5e0ReIYFwtJ+K8oCx6lCz/7r6JYiFUUDiV58coLvfADy2v/vaaoGLp+KsCXJDYHwVjJgNRg4mD7SugriJ0BKNyDEHE2UMGEuOJ0+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588630; c=relaxed/simple;
	bh=vDj2IpRKVuh33/CdcwEAomBuFVXb9Ui6pannbUpk2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LcYVUZt9ubByNqnPC2zbxMnlMcTNOAxhkv4oHPlCN6QDNJJU9PgIMZNG/U3pYpKUVhS+9gn/zGzyPknQQ92UUHvkLj/0E+ZDIxSPfxA5nMoyLEBJoS/3owmp0lGHuZMOzQc98i1Gy3aXoMK/VaVcqEsG5TRXoEq7qGMtOsurviE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Zqkk/akV; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zqkk/akV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S55V50Oz4rPusjJIPOJyIJIDNl9yr5LXx9/LSJg2rBpadi388Nc3sUj0d969tR6pdakd3PKZMwghAfaJs3Yh6CERDLyL7JE4ALXwNIHqYDaT8341Ka0yEUI7WQfVAhbigwGznrJK7h/bEx0m48GjRnZzJmB/VN33L7MsfVIuMFSMGkDLH1bXQoUx8Kh4q4tuSIN2VriCbmJHKb2fiPFhlmtfZk510H4XnS13VoBCYHxU4r8TIf1s0b6yPcx4eVM+4bUCl7chLtXHEPICT/PF5Pb5PwgEELvAxv35N1BOUzwE+GWxBOUq7Kyvz+L6xx1gaHDAcnI5nNsSQXX/XQJVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLfiDBJSsjgR89r20q8F1fzBtxo5uAkYAqJ43L7vZ5c=;
 b=UYDQk3mjyaO+SXvAt47Rwk6KK3OWMV+rAGQJYJw/DGph+8ORl/r/+KTIdH86jpm1GYYT/1Cwv6LvbZfoY0HqloDWem3RihRvXNJYS5ZFLo5njmzJRrO0jnWy5RsYq8WMT3q+/vqC7Ha8mXdGeBLaE/IqcvJYagptW5BtUt7n6jhCkO/Ji1Pc5oiSxjIgEzCej0a8jrXNaYYDhwkeM3Nh98QZHpruoZzjIFLfk/3FB8uk8AWV2oGwZccodQ2PQoP3sZaAz9csE6Z634OwJIPP1waAqOvaxkCP3fWa/CxhlZzwpKhVVONQXqM0giKICGcXOW5E2Or2s0QR1qKluAQ65g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLfiDBJSsjgR89r20q8F1fzBtxo5uAkYAqJ43L7vZ5c=;
 b=Zqkk/akV6hFZjXzGIPKBf2lItCQvTOcjxo6lIxoKCP8uX9o4WsZTEmexbYbp55GX39KSGXKBvhLzpyP+53MWVjKOjswEevG0H5cJcTfrp33KsKart39LR4hrj8AOlSlcjzYUlaqfvHriz3hAZXIQqi+IXgmTKaRYtmLg+42jNJW7DV4SSUDdTtNkxNVbeylIa1wRbRQkXnbOuQ9ZDB9bqHzzPs3CAVX9VrMOW91Ld6Zyr1EZIzd0YYmk8hT47CCr3jCMHyszOZyUUi506QMR7YAOAtacSLf5luhWmm07llelcsim85xAdu8E0/swLPlmpVXTDDCrBooEbjsnU1ckjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB333174.eurprd04.prod.outlook.com (2603:10a6:102:54f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 19:56:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Wed, 16 Sep 2026
 19:56:51 +0000
Date: Wed, 16 Sep 2026 15:56:44 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Frank.Li@nxp.com, alexandre.belloni@bootlin.com, arnd@arndb.de,
	bbrezillon@kernel.org, gregkh@linuxfoundation.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i3c: master: Fix of_node reference leak in
 of_i3c_master_add_i2c_boardinfo()
Message-ID: <aqr0fHT3EcOlExAj@lizhi-Precision-Tower-5810>
References: <20260916160654.2081795-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916160654.2081795-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: CY8PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:930:4b::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB333174:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8100dc-5976-4e36-30f8-08df142ca68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|23010399003|1800799024|11063799006|56012099006|5023799004|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u1Gt5D+8HWRIMLOOMH9oGFoqQvX2FxZnYABWsLAmD6gVTwwlvr2a2bRfAOs4ksF5f8ExEYRjiWS+zSbrIj4hTn6uXknFwtp0txbuQ/B4RYtzog9Ce8v/24TRG3kxbhhfZNI6P+ltKfNpVgDsrBRD+Un9F5BdbGFo/NSKLh0VUP1WkfUp6SmC1jt8EyKusdUNFl8fDSGHtETLWYx0hgZVuXURQeJv6KnRaniHJbFkDqJ6XeXIGLNRdwmGAuTM58rtp9/u+XfGglbeUzyA5qggotxEUoMiLf3hzPt7uKml1Pdx125zJA8WgHaW1WDnOfMBUawjE3cVXQ0tOUdSNr3HNHpLX0fLEmvpUnIhckuQf7srW5pbWxPRr4Nv99mGtwhEcwvOLARhFyhkgTGrOZqK5A8x4SxHFtdlpJNkrKz6JKX0xqJeA74yWMbiihgxhtc0YRgaPkeZ5qx28cc5LnfHiI24KW85wSLkNucupoRSpY275xwVUU6Nee7G9WEZk8V014Pti9zJAmBr9MFy9hHilvCvrFoMxpS43JpUGKl0ZUdv4EMVgggeP7RSSGHZN+gdODP5d4xZKZ0iYQnaP6BWTjcGerzqP1M1XuASiY5eThmlUs8ZlmSDSle6iaOVAUFtFq0PYFNTVNw/S0mfqLknVwHTvDCCxSDGYzG2O1CTwx4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfwLOhjePDtGFWpSkIk/xF1a/Ev23YBEfPkMPaxjM85ypz4BdW61qS1lP4b9?=
 =?us-ascii?Q?hdjFs49O+tRoRS7kqClSD5rXDw1CQ5QhT48qhrWWPjcxaO3Gt3hNEJwjOH8k?=
 =?us-ascii?Q?7BuD3/woTClh1o0w0JDTRBuxoGl/DeSqp+1JmqFPjdIpKgXwdgaFNt74h1LP?=
 =?us-ascii?Q?AM8vGCKWn6k9r/Fmjbo3xzbcR67yrsQ/YZ+Tmena74/r4ttZzqj3T243Jxqw?=
 =?us-ascii?Q?sM6zaDoJ/hNPIuXl8syce0D1b2rYq1V6VgNtlYf7h2F4QIGiJxKuy0Y7F5l7?=
 =?us-ascii?Q?uLaxsTsAXf9Jw+LmMX9fmn5oMftfXzJitlhL7PAuTPeW8oxKQZ9aYwaJb1sz?=
 =?us-ascii?Q?N1bB1FQ3+ssyrzyeD6Xw2HbWbAOwxGoQniStanjD1DjK497gNdMa/eJOBKWM?=
 =?us-ascii?Q?W2dEXISGD7d4CPAAWHwiCzNJrrQVwPvJsbs4NvCajzVF53H01Nir/queCU1d?=
 =?us-ascii?Q?VM2pOKSImgtgUqn1azSwGK9HS2WT70dWMfZ+MroRWTEkNXgtSHPIp0bMimq/?=
 =?us-ascii?Q?F9yG0KxxAI+Gh1Ed2IVG8QPVX7Ki5EswVOQyyDyJdGyTh70I36i04FFVuphI?=
 =?us-ascii?Q?yst7KgBjnHk+OKCERaui3WqWhKIeRFEUEdnLydlrQNofXCbVxsbjLSlUMt6T?=
 =?us-ascii?Q?f6W4HVC9tUBD5oInA2qelRZZxdOao6vy68UXHaSI4u/k7XuPhsw1ZQbD2D6a?=
 =?us-ascii?Q?CxmCRsDPZsuahIyYmL9dmnUnF1RWaUQcqK7HKvUqRmYW7KFPYZj0IThstLVH?=
 =?us-ascii?Q?uhaDcuaUmrAr9MKsUzHNDo07sP7W2j/DGYRN3wtzAJ+pJvAtmAUNRvlmS40I?=
 =?us-ascii?Q?ZeMXx+0wiDUIOxx9aSdeK3CrRDeJwRk6uuvHPcYAp9sZJs71QiPFRTZC5vlu?=
 =?us-ascii?Q?TZYEFtVhx/zL2cbLM6vG4QoiSsAvE9/K02EjeCeG669voHyvlbZZecwHLyaH?=
 =?us-ascii?Q?W3smRCY/yLuxU+wOCtjDJgQSDM+7IhTUeMVJWXyDFCGoOGKW4sjPgrqo5oc5?=
 =?us-ascii?Q?Rl1m1/aOM2K8SdXDWmuaHjGGhM/t+jIQmtVJb4LN92enAjZOcXzz3zfJ4TUO?=
 =?us-ascii?Q?dsAkSWztViM4F3xD1X+ccsJbr+9pMiC/DU0TYWGDaQrlUtv1b12dbIEznYvy?=
 =?us-ascii?Q?+ihghUEX3V/RtmXC7lq4F/pl1tVE7xp18v9ZNkmAbFHd2B05ZfzxTIBK8MPn?=
 =?us-ascii?Q?IosIbBdAjg8KzvosXuxjJOdoWngSEE4XfaxKmynDpuqoQ7jv3oI3QwNIaubE?=
 =?us-ascii?Q?BzOtvn16yobWaLRbY20hAWUt6ZhbF1SoYgqgMsFEzSppkzXJ/WEhVSOMywZ7?=
 =?us-ascii?Q?nEr/Vplg+pTW4LqkruzXitnRmHlcbxo/kZeIZ91eLSGfh36wIdZBYYJC0cpg?=
 =?us-ascii?Q?QxKoddtCYJJ52+NMrnnuPB3DYDeJEM1LJDkgmqzYvPBB6/Xvz6iprnKJoRrq?=
 =?us-ascii?Q?QfC6tCsEnTi6n6xyDQ32UGtBARB4Ouvvcpr+AwSbBrqbAe1F1G2CPohovdM/?=
 =?us-ascii?Q?WjiR2KOwfp1mvVdEQFVYGg1gbj103QfLrHBac/Nm9AJo0nTn+60LA5MM4vCp?=
 =?us-ascii?Q?qJivFX7k5sVgJxQZjeFaNF45BD5ksr8rABzv+D36rKK/wJ7KQHizPRTCEX8Y?=
 =?us-ascii?Q?wNmSeGrvjacVNAh6ES3s/LJ0+kcs1+MKt3j4cco6EAlrLxE8GrEcZRVxS5wl?=
 =?us-ascii?Q?eZvB+YjD1NNsafmmW6NpR3yncYcGpIimAad66m6/gGXhZ5yOlx5+kwcTcC/P?=
 =?us-ascii?Q?+jR1NUgRDBn+rkTsZ0xf4QdhQ3Y6VeY3LH3hTKouafVhDYvqSwts?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8100dc-5976-4e36-30f8-08df142ca68e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:56:51.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT1BKAHg/lF9q6rVOLBZi4DuMpvI6wlJAZx8rk1Yl9oJ08VzffjnvTumTOaViWjICmOnB9aWFdSZ5whftHyphprOq45erv4DDMbICzjLIeA3R35JguP8VasAKnLK0frV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB333174

On Wed, Sep 16, 2026 at 04:06:54PM +0000, Wentao Liang wrote:
> of_i2c_get_board_info() stores the device node in the board info's fwnode
> without taking a reference, so the board info relies on the trailing
> of_node_get() to keep the node alive. Nothing ever drops that reference:
> the board info is devres-allocated and has no release callback.
>
> Register the reference as a device-managed action of the I3C master so it
> is released on registration failure and on controller teardown.
>
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i3c/master.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 23f490a00591..30b3822c530c 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2407,6 +2407,11 @@ EXPORT_SYMBOL_GPL(i3c_master_add_i3c_dev_locked);
>
>  #define OF_I3C_REG1_IS_I2C_DEV			BIT(31)
>
> +static void of_i3c_master_put_node(void *data)
> +{
> +	of_node_put(data);
> +}
> +
>  static int
>  of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
>  				struct device_node *node, u32 *reg)

which code base do you use, now use of_i2c_get_board_info()

Frank
> @@ -2437,9 +2442,9 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
>  	boardinfo->lvr = reg[2];
>
>  	list_add_tail(&boardinfo->node, &master->boardinfo.i2c);
> -	of_node_get(node);
>
> -	return 0;
> +	return devm_add_action_or_reset(dev, of_i3c_master_put_node,
> +					of_node_get(node));
>  }
>
>  static int
> --
> 2.34.1
>
