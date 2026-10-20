Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792512313;
	b=OSYpFO3fR6MRZhUyxDQN4bGRGG4aWJkzFqObbPJOzkLoMAc64aAIkKc7i7CjROsZJPf1
	 bZNg4WkYkTEQpLNGMsLWg906YF7V9Z/WTSEHe/usDBzbmvDh9yQ8+zZqS0Hz5rIVdLVED
	 3wRbcipfHV80u9soo+xdVE0/3QvY+SRdwnSIFkI7sP2yl58LdWYQurK0q0bS7iSJnZf7a
	 PSHXehWHe/p5XKRzUpUfoMk2sc3UglK5zMJn8kw8jVfKKuQ77zQDx+nvoOSpb3Navv5Ma
	 ikrFVPLV9Qs+krmJCivdnjL7b0HqoKhTH2t2tH1tBoEhqy3TL4FFAKi6iYvSWYGrYgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512313;
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
	bh=RjgngxyqC08xsSY1LT+j15mujO2l03xgAc95xgxZP0g=;
	b=CkFC3JGtkqYkz0pRf1So+4ijt2Je0gLE1Ef7LLxb5B5aB5lobf2wrp9uS7PpBrPAFM2/
	 6ubeQHWQmVu5iDv6bgtn+jzYU/hLyzoUsdrKYF8lZKees9YkUUoIvHkEqyWkXTQH1rkk2
	 J64OelPpkxyEe4fKNVdZNvpDrjVqpHGAKihY/GTmBXHjZPQylWK3Nj+Dbmuxsfvi1+kvP
	 BMyKCAZZe3PBjSapseZZBk4wbT3W1Yo32F+3KU/fywhT206AaNJMhbVKrKhRmJDtY1UF/
	 7KkI56VbpG80j0TjTacIkNZu7Qai87O9GCYndfI/HfyRC/OMJkevo2sgQtKN6KvtC7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WekQAFwf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.1
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314C606A31B;
	Tue, 20 Oct 2026 16:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F314C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WekQAFwf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjlvnW0iROQmur00vfN4eUqE8NC1Nhk9ptd++VdVpPner/XioXhlVosiuNsx79ghHsSgyzLwS6cxupfHPOLaXDREFTmfVYjUy44mPe339gPrSJRNaS8++arENJIpbibck45NVaG/Sgox56ib9PVjTsZbkz6LJ/Int7jxVIZA7VkPBNr+aZAOOswHHGjpnWVCcSkNfJjkj9Ql1y5Es0fL3FsdP+onaDfY3f1n0xFGJEjse7W/rpysqmXIYNp5h4SMK8iCsE+eY8TurqA05wLbazBXmDIy8xM6qgTNvNmhqEJ54T910Yqrv4IaaRH6jPjk1YkxxRa1iGubWbuh3kMwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjgngxyqC08xsSY1LT+j15mujO2l03xgAc95xgxZP0g=;
 b=JAy8CM5Ptxj8Z91DzU87+CBCXXuCPU3cmD5HNQoqRzsKBpC9SSeHLK7o6gqe3Tpx+0Ic0YIGCwLVaPUrcAwZMomaCoofUdelofsiHcRRaLB3Bzi1JrV+Kxfxdmz+4GFPegNVsVFIt8T+dZ6Xgk+Akyi0uHUbiysmNLYZgWZ4sJva1xNmnb6gO7AA8+ZrQYwnrGFPPZnC0b13qQPhrqWamz4Iq2W9UUhZjidTzjbC7JrKLNYMZII6tT4RAJrsaojDx6xeJ879uu6NiNQuD9fPxj0MddHzGSiO9MGmBibVB+vccysf+LmHunWP1y3V5BUde8Ywok/NLFF6wiBTv3qkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjgngxyqC08xsSY1LT+j15mujO2l03xgAc95xgxZP0g=;
 b=WekQAFwfORz/zCBBfOxjBiG84aZNFTzBgDcnKtwoSd78O6kBIt9NtPDKpT0GF3wujDFXXL/wmJOEzgbHVJNinH2P3pJSI39HOxwumEftCD2oLxKuWKjcUzO+bqNBh5LoQg4scY7IkxcWPRkLahkx0zFSNbWrQEtufXjdPuJS2x0srDFCZyp1R3BZOrwjCOMJPXjzahOhsqCs971weEOJ/mF8iWx/5eBZSTmZw6QjIgJrIEt7oIIBgm7V7qii7qMEWjr16nnPVM2psUzd5rb7UablRWo3An5fRVHTdPBPwZ7eMERAU9RgyTBHdGnOXogh8cJ0iCcyvcc8IBmB+V70zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB11990.eurprd04.prod.outlook.com (2603:10a6:800:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 16:05:08 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 16:05:07 +0000
Date: Tue, 20 Oct 2026 11:04:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] bus: imx-aipstz: reject devices without match data
Message-ID: <ateRKKW9X7hT-MFH@SMW015318>
References: <20261020093637.1654161-1-yaojiale02@163.com>
 <20261020093637.1654161-2-yaojiale02@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020093637.1654161-2-yaojiale02@163.com>
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB11990:EE_
X-MS-Office365-Filtering-Correlation-Id: df1a2f3d-f5fd-4a58-751b-08df2ec3e910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9P5L6GBT1bsultffkRsdomN4om9xLpSmHNiFds/uL/Fwk7zW7XdP9FC6qNfMYotmRlSD6yRhb6D3GJlnYTkSovXqgUYhwzEr+YpYbKoV5EzUmmsBL2oGiXRwTr3pjnKso5n6CkDXCpP6kvke0TmUbNgxOgex0Dst4mBIbT1KjAA+mqAaY2BFHTKl3aODuQtrb56qWY0QETaVnAxyyAAarvADRVAU0Zc8yXXcbJTEYZF/+dIXvAp0VKAOhOglXp7o0VaTB0I+0z9FMFKG6EeqyfDusrXgzk25yaM5w6sVVed5eDtN22/T4At+jo1xqzLfUtNjrn4jMpZhuKZsuGXEwLRHs0CIJbC8xjaC1te61z1EH3F1uzAHzI4+Hh/EhPVDQ5Kjfav6BptdA3EKTLy+CUWH+4R7w+r09CboNreDaMfn54RbUpHktRxTRoWCxLfPASow4bTuIAVDQ7WSLIYro6lD0kA1vlyH3Ds4kb1HsC4sehfKBNFAZNprQzx8iA3dhAuhf9EotQT2ar5M79slOw7UnCv1N5VSuVoPT1LmUCGHrGX97RNHiYnIe19CaMQgwAOlw6MtNgPxpSLY5WHwFTxawGT6hGACWYfFYFPc4VuADG+omQ/KDFlquH+/Q+r0jFKlQ5Dcjl69GVoTCgKilbEcY9vk6+CWNkv0RycyNv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gf1dkcWEmcJHCIHnzegNL2/A8mmt2dVMQnUD4BY2AAVjFP4U0zyZvSHLmeo2?=
 =?us-ascii?Q?7N5kQplg4VETFlGUnsQR0viM7TmbzKtd70JQpLAWfdcZ9n6tpWtTm3vq+9ZO?=
 =?us-ascii?Q?1F7EKS75/xNTX6mHnFZ8FbI3Vq5yzsFaJNichlK8Eh42jHPalCH+cuvVrbc2?=
 =?us-ascii?Q?6pshLQvwFiapcVHBD/cMCyaU9XC7mkZxXDhDE/TgrxANKCe1CIR4eXcwVkro?=
 =?us-ascii?Q?PULkRGioGLN81EawLOkcXX1rw315Yh1Wcn1PuhR4FJbzE/izjfwdXogPM3SQ?=
 =?us-ascii?Q?NZDLqA+uHTvhK+s3sIPPxvXJhWrAU1C4xU6LIK9lXMz8WXdvgvhxvyyDg92w?=
 =?us-ascii?Q?rutYcIhX6LnQPOPS7cdyf5uaj9JWTrik2K9InvWb2j43GyKkxTTAoqcmYnaq?=
 =?us-ascii?Q?mLsvy0VjCh03/zJJgzCGKhQd14i+0P1Acz045sSwcgACb1GRKp3UsnwberP9?=
 =?us-ascii?Q?v87+FUvajsxg9XLVYHfWTroZsliT50DEspkUWlYZ/j8gvElQVVyyh4Ay2b9g?=
 =?us-ascii?Q?1E1rx1rUIFRWD1MnLSCPXDN91htCjxAuuvMLb1xr2fol/X/q0Mzwvm9wJttI?=
 =?us-ascii?Q?eForbif7TRQoi52unqS4zJs25i40xDr6L05PzsPP73S0CHwhsYIQaZTv6Auz?=
 =?us-ascii?Q?CY9XlU6YbVVbk8R6y6AVRLMjdKBSvuCMv7Y5FeaMgaInYm9dllvkgelbARsR?=
 =?us-ascii?Q?6KGGtqtCe1q42VuRivYwnJRoRYVRaJNVwfRLelDEhTEqpzoZ0ZWy97MjaRa6?=
 =?us-ascii?Q?+mGC1DVjg+fx2dB3bvX2sKtCLJBnVRWvLH5e94oCTcyJ6RfGm59a/gkcQ28g?=
 =?us-ascii?Q?YKFoNxy+wwrP7qpAulXyLVxUXzJMSz+euqIzbGAwtnopQju9tDIFEl/54BIy?=
 =?us-ascii?Q?gN/DOUqywi769eU8baVGWHT5vRmwFL/QridRzc6MTjKr3ddDAP1ouNixbwXC?=
 =?us-ascii?Q?0+DfPL4TS+NxctLoR7arD0afPiy0xSEYC8olQOVc5mVbmCppRCq/tTD84mLW?=
 =?us-ascii?Q?WIw6TjrJn5r6oKQzvX3tHkjjyTrlWlaEqiuCXgryXMC74+O6q1Bjwx4g/UEJ?=
 =?us-ascii?Q?Js4lsp/388ij6gEn8FOvJercOPYsmDgQM8YQEp3o9CQMMEjABnyp7B2ySkXT?=
 =?us-ascii?Q?aBfOA++b73W1Ds/4sgpAkDFm8Pk5A6BhO15fFqafY/OOUlIWOksiXgWldbbd?=
 =?us-ascii?Q?ts0zXwWDs7V32W2yof6WUuqzZkkL4+khAcphAanzMHek47VNG73JbFHO+W1U?=
 =?us-ascii?Q?pVkWHzYq2tXI/2vBeQNrntEVcIUmTzk+gkDy6cZ8pMDuPqpMoMDeJx5DaYBB?=
 =?us-ascii?Q?46GTkL+Pe4WNO6xflbV2USaLR6Cuo79ws2tdeXAFVnx2LxT9dMHAwMN4XfkI?=
 =?us-ascii?Q?uxCGIwkngozprWRjBVwF6yZkIOwuhLQ3h55oH4uiSge56jYMVijGnKFMALVl?=
 =?us-ascii?Q?3vw7ySjn6WsR4rKm6FtMUAhKH1gfX+th7ArNZwCXr8gULkwaN2G8kR/IJzqC?=
 =?us-ascii?Q?eEoEkBeR/YbTRPmRr8+gI4h/ppCUvfWxqELvtaeJlUTGXviYItK8mUvie5a3?=
 =?us-ascii?Q?TQ5+5DZpZF7WWmqLJkazaC1JxTIEkPu+kudmybdv+NNKgDa+QU5CKn15PQfA?=
 =?us-ascii?Q?mO6SfJtopKo60niT5g1Bz+0JscY9MJnxqipswnLG1b7eUhzokBp9LKPqLHWv?=
 =?us-ascii?Q?0p4HbvM53i8ae316MPBuqXfecvNIEQE9OvuxoGwF5Ym+hlh0UmpH8UMavd7Q?=
 =?us-ascii?Q?WHkYYi2BVcJJEBJgGpwhNztDXoPjr5NTuleDz5nxLO5AT3cBm8Va?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1a2f3d-f5fd-4a58-751b-08df2ec3e910
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 16:05:07.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgkEouEdVcFLJb8AN1j6iqsOcUjzBrVupDmZuBnRuxRV2EwTfRriLMXmg7vZOHo97kRVCB6Rotqjbm/HpCtnn6rt8BWlk7Gyy37jNN7bVq7JpOinX9+Z8Q70JKwfjSs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11990

On Tue, Oct 20, 2026 at 05:36:33PM +0800, Jiale Yao wrote:
> Platform driver_override can bind a device to this driver without a
> matching OF entry. In that case, of_device_get_match_data() returns
> NULL and imx_aipstz_apply_default() dereferences it.
>
> Reject devices without match data before applying the default
> configuration.

It should never happen. if run to here,  of_device_get_match_data() will
return validate driver data.

Frank

>
> Fixes: 796cba2dd4d9 ("bus: add driver for IMX AIPSTZ bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/bus/imx-aipstz.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bus/imx-aipstz.c b/drivers/bus/imx-aipstz.c
> index 83371e5b35a2..9f74cbcd47ff 100644
> --- a/drivers/bus/imx-aipstz.c
> +++ b/drivers/bus/imx-aipstz.c
> @@ -61,6 +61,8 @@ static int imx_aipstz_probe(struct platform_device *pdev)
>  				     "failed to get/ioremap AC memory\n");
>
>  	data->default_cfg = of_device_get_match_data(&pdev->dev);
> +	if (!data->default_cfg)
> +		return -ENODATA;
>
>  	imx_aipstz_apply_default(data);
>
> --
> 2.34.1
>
>
