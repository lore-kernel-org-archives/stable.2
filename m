Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013021.outbound.protection.outlook.com [52.101.83.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA650254F;
	Wed, 30 Sep 2026 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790786506; cv=fail; b=YxBrpBRvoWBQCTFJcS9RHkMh+TJ+KJDBiLXLy1bP7OKtolThf7n491YvfCuuuU28Liupx7D685cLwz7E4/g6NyliB431Oef9LtI9k7kMEHy+mJonxr4B6eiflkCdPArP8X48zGuIgAwKU8+ktojJn2Yvua2PQyjXqbBDO7ddjNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790786506; c=relaxed/simple;
	bh=/pZIrm17AZJgkx8kabDhk0yC7CGoWxLDgJ5MFCseNnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i+wejKhfHYjws3B6RzAu6W/9qYRAyyDxafZVndXtfGajOBnT30KngYZhfekjzLUjDxiDo+63qzIho5DBlbH0aOAWtTB3KBVxnRUmtAojWMckWPgsUM/WdLmgO0hjy+j3cXnoSvFzkXhuAyoxGD/tqzJBs3VBUi7L/ny/buOe+Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BMIO9Fl1; arc=fail smtp.client-ip=52.101.83.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BMIO9Fl1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sov2T8O93NsrTkb2xND+twoOQk0DGR9AE53KzPxIYk/OhudzVGAOFtigWPs90DBDGE7naPCiGU7atxiJwlITZecoRcZ0o/esKzZnDkKbHgJP7L1H8JAksRfAGiBazXp0eYlEgYR653Dn8CCM1oj7qVQ1ATN1Z/rM26E6kNwgHexH/OgfOkKccFnOg4gAeIrBUft1lX56WXNX9sOpUkNPy5WR/UxDP3fSDELBzhpqnvL0k9I2iUFo4TsJo/GovgpDgxm3Z4qjnkIJezt5ub0+pD87NFxRgT1uzoOCBy2uqmFcTImhE4Yc3iB9Dm24QWZFJSNOuxtAzbv81ycv8b1ytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34BUEuaQYUZ84U5Tu3lHI2XVLvNBSZd+6FjRG7uCRH8=;
 b=VWXsW3PiYKpFkI5ehM53dMSw+ca1g302zNTr1eyB3bwOcwS/2VoEtP58lIFS3+kVJchzdg9Yvpbj9cCN40K0DoFfUuctqTZNLNE2HQD8s9e3LzA6s92KA9HODLskZoPrkLAOa8ADArO5JSRLBV/rWr/NrubGTjaxNg73rxVSWNGsL9dBrwrFKitSfuOCk1x2Dj0BLMeVYfmNy+r65pP7+mFjzfzVIXECzTXb6OR7QQaYaJVuacJC34Nv+ODjF13dOdiBSWsQATjwgbtVX3X8QVnxbV2cSUfqhDNh2F7wjypRVgM4E9/8GAiTvarAhbIFmYW+4r6yynpH/G/ZqII7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34BUEuaQYUZ84U5Tu3lHI2XVLvNBSZd+6FjRG7uCRH8=;
 b=BMIO9Fl1zCKglS7dPiXzLTCfRbjOTQfmqjDZqqAPRbb6x5GIaAVMBic+Ma1Bnjnl+rFAyg2zwMmJEW90s03JRDyxK2ByyPVVaDuiw4Oh2S3upO7hu4JPrVThvcuzeVY+p1AZ+NCxR8AojGs/2UmYyeArToVloG2MYQUsdnWFa1QnxLCt/gZHcBTOEAQdZhbG+JFnwoYts3tYn5j3pMh6tLsWmpgdBquLtDeyoi2OYu3FPh4fZ8K04KbZkWg6N/zPZtPyN7JRfmBRtP+u5P+TvptEI13tbPN6lIbmWbKs8y/7qFPMsuRqZGLqijphd4l5w8Ovwqrj/mNCzB2H0OvKsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11529.eurprd04.prod.outlook.com (2603:10a6:102:4e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 16:41:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 16:41:40 +0000
Date: Wed, 30 Sep 2026 11:41:29 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: jeffbarnes@linux.microsoft.com
Cc: linux-pci@vger.kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
	roy.zang@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: use default error response behavior
Message-ID: <ar07ubdYLk-Tje1q@SMW015318>
References: <20260929194339.233271-1-jeffbarnes@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929194339.233271-1-jeffbarnes@linux.microsoft.com>
X-ClientProxiedBy: PH0PR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:510:4::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11529:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c68e4ed-0f28-4817-25db-08df1f11b3af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|19092799006|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	VixQH2WRvFYTgTmM54j3R7/RJzxTzo6J72LF1dthBhRqFybIz7H3bJx1a4n27wiu2jbsa7RL3o6nOwTvxFFTl/kAsYejVH6Ppbh2I8iNZ/iIVfx8nh4dfQSV30KvmOFlJ3TpvOAdQhUbcAIvyRX52W8lxprUyWGiigjA6SynhdFcGmQgGfKdIr5aAaqPZAyjitAAp9op43nejHK7fzxA8MwqKD8XldJFAnkrX0H/4WWXxSEhW71yDXddFL9xBHGqpQtAWt6ZqDvoN8iLs2d9X7UrgrBi1pYCW/F/UXPtSU4CYoyllfOJ3FBWa0zWSE8eXwquFCsMKbF1I7weFT7ywN6lsrPy/Oif44CPUUkL3ApcZVIWe5KJFuEpJtSJGb86OlllZf9gLhT346Wo33LLtXzrqNMCcpRryOasHkwlL3SDpceGpMLrDvIxGJ+L30Q0wMalkSSNRIgL5iDKvUfZXE3TsBnWXYM2UgefLjAg8vKkpFSLVOOhmDPNldJOQJG4t2LoNfn/V3dZMdFsgAwDc2eFbRl4FJ6myh4AihEAygXlW5iQDvopbILb8HJgl6LyC5kvnAnI8mjt59J8s+2xKx5MwXu4kXLrtxN6BV8vDvkl7sMHYx1SC1335k0jyJQ13QP7mpPRaKmVBAwxTnyqs0PzbvkxmVDZyGkGSrHV1io=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(19092799006)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUuxcvPEQiY3GJ7yH81EpQngfRFHZJeAnbnvje7PX5bRy/caPfU+t1amYI6U?=
 =?us-ascii?Q?UeDL6UbuPlZunWped6mo4Hj3+oUl0YBnOS39VFEp/F4BavXPXbMsmLi4Ivjh?=
 =?us-ascii?Q?2IcjgaSWVMMzipI/yLZFOCUEZIqyxNT732bDs2jNxybHHLqfPopV9X7rVYzd?=
 =?us-ascii?Q?0YIbnDggjbAa8B9JtO7gzxtlAIkb+s4ei4J/xPgflMoVD911nJQ4DljgcD4v?=
 =?us-ascii?Q?uPeNN1ZEJkRbTe9UxgW8K6g+3CakpOMtMqvqwBk4OVxGiKOlnO/l9Tfwl9ij?=
 =?us-ascii?Q?dhjeDQ5ok5dCpQU01pk3p8BTPnzMHD12UHxsUxvmPmSj8r0U1/5mJJqRqqyL?=
 =?us-ascii?Q?ZNmh+kFerZrCerW7PfECS5jEuYbZNDYNhmo5a1KmZBWz4LjFAtVg8gjY/ttv?=
 =?us-ascii?Q?jIDSFDMJsxUK5OdDo4qu2H3uUKLWvFVMptaLsqfk5GCPD4q7zdn2xppOQdYo?=
 =?us-ascii?Q?SMvUpekZrTJCgVZzWP+D6dGsKKABLPtkWv/EdjfNvm6z2UgHr/kdIZsLjdxS?=
 =?us-ascii?Q?1u9W7rHsD/Zvp0+eqBFR2LXPHLOLf5j6vm8i7deBMxAR4u9k/krhUcj7Wf9B?=
 =?us-ascii?Q?/z0fK5uBKJlZF3feSDPsbAB30iDzyQr68bvCy1QWEa0vHUW3trVNsG4i1Yau?=
 =?us-ascii?Q?ixXQCCdP1DwYxlvDmKlXK+TqFBM3yyM3FgDmcdtx7HdiwZ83yRpslmHa58LD?=
 =?us-ascii?Q?OLJVGlG/oygTOTi87JjXHHX0RHUXVoo4ASdCzXJJLd/W7311ajjXMNsZevTN?=
 =?us-ascii?Q?NtyjZ5etoYJYSNx7Id2hMX3FkPPg5qbIjsbAwg6QPl2P/UMFPPaxwbYoPEqm?=
 =?us-ascii?Q?7mfCzHxI5aIHIQxiFmrtwbbHy5uYbfWQjFW9zsrsb+7Y8btN41/NCaapVSSe?=
 =?us-ascii?Q?FH7RF7FVkd82tbHhZEB6ePfb/YPbhPdN/Iq1KjA7gy2NFQCprNhdmzpG2hED?=
 =?us-ascii?Q?z1dAPNZ9esUyegKNiZmXtLPykGdPDX1moDSpMdJbpKcv0XMig51BGcnQ4YDY?=
 =?us-ascii?Q?TjwGxELQB2bBwIwc8EbrdG9iEAnZvuXHDPa/uhIIIHpu7Qt8QzxvlJcfbbAh?=
 =?us-ascii?Q?PoYgpK8iDxHRTAw+6YB/5REirtumKHsA+Ipd2HId+amIgBsEwchI9KjhceQy?=
 =?us-ascii?Q?6J6U4UhMU1UAZZLoI+gbPmEmdxf3nynMp5Wwpova7j29Bw6i6y4LQWI9qHaw?=
 =?us-ascii?Q?CZTuxCD5qwCqX6r7qP95x1CDO6CUA+Yw0AtK4dLt9vyAZAXrcAUoXgG1anfz?=
 =?us-ascii?Q?VoPy8E7iE6tlDnO+7l1bM6Qt5xTdabEVLmP/tBfwRfPku2lk1d3m73rYR2zX?=
 =?us-ascii?Q?hf7kfUULoSB6csQYFIgatdbnNupF9ZHqRw8SzTu5YJKjx9vZy+WwlmedBCty?=
 =?us-ascii?Q?qKa5fqdUQEQQddB78J3jqbMgDKuHVsoeC1DuQnVJhviuNycGDRMdTTUS+LtM?=
 =?us-ascii?Q?DvJTDckYCRNqM0eMJcJ8xDao6BtRGq1v1vhmnIElm7Rg+tbfMrdZmkzEN06y?=
 =?us-ascii?Q?voLeLodGlXslo+mlvVC4jNfULW0Lh8patbKXvtYg4gGH8+pZT5zt9hKkKwME?=
 =?us-ascii?Q?uliIUFi17LjFUUv9DvqDHSYc7bvPyLnF8ytChjPkcFE6B8qWjqi2sQHbRO7J?=
 =?us-ascii?Q?3EnduCX96/dPtTJFfY3MCVEA+My75AytHsH0/KqBFJbNaT0OVVWxZdEZc99u?=
 =?us-ascii?Q?aYh3Ksy22ssv/yCTUx/STrp7Swwr2wuuuiG2bhm+6b9W6E5c2Rv6mZ0G34iT?=
 =?us-ascii?Q?Bf5WUGodPxdTyEJHzG1mfmjewTYE2hCp13k8/1AgqvjxdJLdc4Ha?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c68e4ed-0f28-4817-25db-08df1f11b3af
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:41:40.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlyl3iGwVClp/U6xmhu2Oqgxb+n9fkGk9rff4OQ5Tidhn3AFzMT3O2BYj9MQTJGF7B38oV7YEnisOCDKAd/FUiI5hmc+tHEu17iGtJYHkh//zy4Z7OkxCABPdzjuImnx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11529

On Tue, Sep 29, 2026 at 03:43:39PM -0400, jeffbarnes@linux.microsoft.com wrote:
> [You don't often get email from jeffbarnes@linux.microsoft.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
>
> The Layerscape PCIe driver programs PCIE_ABSERR to forward errors from
> outbound non-posted requests to the internal AXI interface.
>
> A PCI configuration access can race with the link going down after
> dw_pcie_other_conf_map_bus() checks the link but before the MMIO access
> is performed. When the resulting Completion Timeout is forwarded to
> AXI, it causes an asynchronous SError and kernel panic.
>
> For example:
>
>   Kernel panic - not syncing: Asynchronous SError Interrupt
>   ...
>   Call trace:
>    arm64_serror_panic+0x78/0x90
>    do_serror+0x84/0x90
>    el1h_64_error_handler+0x30/0x40
>    el1h_64_error+0x68/0x70
>    pci_generic_config_read+0x64/0xb0
>    dw_pcie_rd_other_conf+0x1c/0x68
>    pci_bus_read_config_word+0x68/0x118
>    pcie_capability_read_word+0xa8/0xd8
>    find_device_iter+0x8c/0x160
>    pci_walk_bus+0x60/0xb8
>    find_source_device+0x78/0xb0
>    aer_isr+0x1dc/0x230
>
> Restore the controller's default error response behavior instead of
> forwarding these errors to AXI.
>
> Reproduce the race by instrumenting dw_pcie_rd_other_conf() to call
> map_bus() while the link is up, then schedule a worker on another CPU
> to set PCI_EXP_LNKCTL_LD. Synchronize the CPUs immediately before the
> Link Disable DBI write, then perform readl() using the address returned
> by map_bus() concurrently with the link transition.
>
> Without this change, the overlapping configuration read results in an
> asynchronous SError and kernel panic. With this change, the same test
> returns 0xffffffff from the configuration read. In this test, AER
> reports a non-fatal Completion Timeout, and no SError or kernel panic
> occurs.
>
> This effectively reverts the error response behavior introduced by
> commit 84d897d69938
> ("PCI: layerscape: Change default error response behavior").

Subject should be revert ...

I am not sure what's expect behavior by other dwc PCI controller. returns
0xfffffffff or report bus error.

Frank

>
> Fixes: 84d897d69938 ("PCI: layerscape: Change default error response behavior")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 14d6ac4fc53f..d333f1ae8a41 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -28,8 +28,6 @@
>
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1           0x71c /* Symbol Timer & Filter Mask Register1 */
> -#define PCIE_ABSERR            0x8d0 /* Bridge Slave Error Response Register */
> -#define PCIE_ABSERR_SETTING    0x9401 /* Forward error of non-posted request */
>
>  /* PF Message Command Register */
>  #define LS_PCIE_PF_MCR         0x2c
> @@ -103,14 +101,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
>         iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
>  }
>
> -/* Forward error response of outbound non-posted requests */
> -static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
> -{
> -       struct dw_pcie *pci = pcie->pci;
> -
> -       iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
> -}
> -
>  static u32 ls_pcie_pf_lut_readl(struct ls_pcie *pcie, u32 off)
>  {
>         if (pcie->big_endian)
> @@ -180,8 +170,6 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>         struct ls_pcie *pcie = to_ls_pcie(pci);
>
> -       ls_pcie_fix_error_response(pcie);
> -
>         dw_pcie_dbi_ro_wr_en(pci);
>         ls_pcie_clear_multifunction(pcie);
>         dw_pcie_dbi_ro_wr_dis(pci);
> --
> 2.43.0
>
>
