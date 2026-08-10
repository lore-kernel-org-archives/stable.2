Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6942BEB7;
	Mon, 10 Aug 2026 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380513; cv=fail; b=aXiiFpWroUXdYH8Fq8aB41FaVVejfl6Gy/1jwd0SVRjZzOPsIYVUS0BqTGQr4wSqLfJ1tjJRydXDDf27hQrxd1QKCuLZfB5YSA5xw3Se4fkep6r1deX4QHSz+Wbu/AVy6YURUarVYspJiTQflhVYwc3byMwNoRGPjq7xs0M+nlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380513; c=relaxed/simple;
	bh=lRT4Ij/dMQ6lt9ooD8lQUggcN+01C/4e/AJ52JEW1/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCJ/DW6zhAq5JzR/zBiYlwWmS/kbGm0V52SLBMZIasA4d6wdQ5n84HkbtpnycH0o5eZ4BCxoXhZ3FGtsH3hfp4nzB0IJAyNDEo5JZeKCS0AL5UbgOTyxbIMDqWrHMLLqVX9147U2A0NlM3uqaxnWEF+W5t142j15GBxfRtdLW64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oRr+JW23; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M3WUQsQp; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oRr+JW23";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M3WUQsQp"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67AGEgUx3825610;
	Mon, 10 Aug 2026 11:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=kTBu/Gc1hoAQbQm
	+9R0m0Knc9LuLZb/rh5PYtLkujGQ=; b=oRr+JW23Zz9ldfZVUwBRtW/8V6uD2Kh
	9Oet24BuHXlwiSh2NKAbqK6uGyauQJsGLPoZWvqgrBdKvF/hYX/kU/61gZoFCBvT
	e4zR7loBfoV02/zTHFOk6IrEQ+X0uWT0uiWwK5Mi+NdJGO9Cp9MR0vQJevPBPPC6
	GONyTdb/qFDWZ5vfkBLqM/4qTqYCSRzWi0uTlLci1HxImIWeiWSyfxmQ3J15TNyR
	cSWYbo0jEaORR9dUtKqu9tS/p1D5sd1TMoZK0V2+4v7OEP0aifIhARlaFf10xbnp
	3HXfZhjDV9+LhFFqGPN5ByWFsu7EEkb8NhAD4xbcxdDkv8lzOjM2TNA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fydt7a9ac-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:48:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuV0e5GfPfFdfGntT4N+gsKH1IP5MaBZ8Qf7Wz4Zsv9kgmALyPledBIm5V5mjckwGggJ7DQ22hsZ8trZuotJENfKBzX1zTjvG61DmQ3S4BfbQXd13IKbojmBGjbC+9svA6YLS+l7vOCAI8V/34zDXaDyKxz0dWTqLeScP3F59Mcj+kW27gtvA9oZWuI0B/3qq97hKOwI3X4ika//ae0d35pdE0Z1AdZSRbnmaMqv6dSD8UzkROeWMVxngdMgbnwVBnyaBoPT3KdyOYE1ET6NS5xvYL+7+Ynbcvj26iWKEEoUpCBKFYMks3gSXYrxPEZR60g/sXQ7XDsSxxF1Nc9yJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTBu/Gc1hoAQbQm+9R0m0Knc9LuLZb/rh5PYtLkujGQ=;
 b=wXjscZnROpeeSmniUqoEorBEYUjK7yHdn043KayLttGdkJ2wpTgz6sKIsz2ny2CWDQRwo27sasAGqzFbxSB08TecFTXVmI8JHJXa6ZVQMpbRlw9IlRaHzA4bZzIbLImHZH1JviALIIpXFnEm/168/KEydUoPZgtop4Gw3O94wavx5R+1eyZ9jp3PZMRIzYTyoGlP+Vl3FLEwSqHpJRsOp+UgfIdfEK4RmY9LrSI40Fg59fVht4svXy/qb64g6EyVVL0c4HcxVntipyUBIC8hnVVdG5w46BL42U7we3D97uVS+L1pQ5RIutgzwNgMZxYyV3sES0I2KxeQ1GvXjuUxWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTBu/Gc1hoAQbQm+9R0m0Knc9LuLZb/rh5PYtLkujGQ=;
 b=M3WUQsQpZ+v5RX8bEtQmpuD7B8RqMya+9EPq04CKNmM9pnNVe4zq5dmxNNdOoT4HpxAAQSpvibToMMrVza56GJKz1oWG1yLACsnn494Xq7PlCsRcejdsLtVXBX3gBKjxcsZTkgWX1idhHydAcc6s67mzybx6N99L26X9NwRdr2o=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by DM4PR10MB6280.namprd10.prod.outlook.com (2603:10b6:8:bb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 16:48:18 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::3f) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 16:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 16:48:18 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 11:48:13 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 11:48:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 10 Aug 2026 11:48:12 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67AGmC0H3523969;
	Mon, 10 Aug 2026 11:48:12 -0500
Date: Mon, 10 Aug 2026 11:48:12 -0500
From: Kendall Willis <k-willis@ti.com>
To: Brandon Brnich <b-brnich@ti.com>
CC: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jai.luthra@ideasonboard.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] media: imagination: e5010: Move e5010_init_device
 to Runtime Resume Hook
Message-ID: <20260810164812.jvmixkoazqzqelhl@uda0506412>
References: <20260810155448.3628054-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810155448.3628054-1-b-brnich@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DM4PR10MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 733db76c-4ebb-4611-12db-08def6ff2dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nizuJwM9UoaR7siik0wF8qikQmEZOWagGhdjwVqHHruT6/GMB32lWvvXohq0O2gheHk710mS71bx4w5Ds7tYc0vqW2O3VxBjnn/YDZDbrcReff4Ne0ZTrG4tHLLowKXVCkVsNssny4GP4JZe2e5WU0hi3XyGGH7tokRqvMExcGE3bT0t1vIBWbFnUN1nx5rHx4rfEpDPfcsTRkcuzf7HlsHSPTtEJ/d0l6LyVDCZ5NAgM6F3TeX68LwWVTLVeJpHINV3YqzfOWuvBa9/FoyDfkUhLUcrAdinKRejd+jVU3sj0VrUzvoWZOa/AgcxJoi8vIqbpc2f0MlHpAh3p4Qj9jbc1nuZ8nLU4pSCUkewS+nJ1QypAnsHr6WoAwFrVckPnof9zt7rqYmbe7V7O4wpY/WzWGQq79HXmJYJI1VRvria4TRVASBR7b7nwVQbRISAKnlDGjaeMpYbFGLAP4QYl7PpH9xQKmRXlLN86ZOGknIHUwB12OVoisg0Fu6EVcSo+/mHiwwFSmJA7EOcWH0u2lSluaG7NcsrarKB9WYbNAyy7qqpupfUH+PK9MhtRRqa+lTjsRHCc9g57c6o2sUVGSCyY7mpcgx938YFGz30KUSRB068UXeZuRd7zMSQGh49VaGSkMuUzkaWa50o9sS6dMdu0HVLXy5fmmcITR47zQ2rgaHXBzEfv3oNmVZBnSkrx1RAf3ipgFqQ2zsRekkXLQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TFCzNnsro2lS9dzJiaLnHvSY4ldJbbLwr8fH/bRCugRm2nUwDIIzXpQg/rbnISxrmfkVZdqIu+vlRAnrGr2fjED9FxdQM04QJeMg1dHzoEpXqnzoSBYbbn162w4ibmHUqwrhpz3+LBcchhqvYJKBOQHQ4NNuJyYw/0ltnZEjYI7KYUrGwGPxj4X4p/3I6ZSoCbkcyU3ba0OPtmvnPSAfrGj9jIFNnH/sOeDUFQpc8IfM3BSO5wKDgcWgSV7CEPlkE7IkPvbpX5+Dfslfp95dckGHuwVknJEMPPEBQIwN/aqmRntRkcvstr7ZrM2M3rzs+efiq73bA5lbhRRsyLaftVwx84FNEXiHisaHVyjFr9GSti1uPkua/uOa+IXF93D7VXmZWCvKWh2q3WV0Bs3x/MePXa+wcQhAUWpMtkCn6WCPDaG32dQfWywxQ40DFtck
X-Exchange-RoutingPolicyChecked:
	DA0vdvwOsYg/f98ccuUtD3Px2zwlutzzwL0a+Y1OP0sKV+FvMKN0IiRJ9Tad0d2xCD28Fl07Psf0CKlyYJP7by62N3SlqnsTcEKjajcUE4WH4xSyggzTZ1PoNa8gYYh7gqoqnGwIcYTAvdt0NQbGAAeXT4l+3eCULNFQCHzi4TPXhmK35+Pv559ke0KFW7GNJsQ1nFviq238qzj85vehQ2zNXA9QfKT0wXEhU+29B4V5giCzYZvgU9n5q5v/0E1mxy9qFINqcyWDHijqsVd4qCFTtrScPXXqN4w/J0/jkGqLXC0BDx0suL5qcevsFwy4xknYJrNOW4zt0vZqi8hy9g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:48:18.0731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733db76c-4ebb-4611-12db-08def6ff2dff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6280
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0NCBTYWx0ZWRfXwrBaKlDX5FHh
 pUIBuiugzpIevhQEXnzycJ51s1noYeT8Iha2PflsoQCCgKWnxqT9gvzaOpT8AMgymG2Dsp25hWL
 K/fiq9H35XDbj/7OWp/m+TVR60ndmduvEW7mAhXeai8sJGRJksbLUqmkEJO3SYOYFrLnMLPqzB3
 VwW7t8jR6euISLcimRV+R/lb+z6QbkcQMw4fa70Y3BrzH61eLRVD1SnN6fYjHWZgE4+cTQkuFeM
 dPmKyU1668cYAvu5djJFcW0mIZFE9QUP0fHRSPFUAjb4cbpU3O9Ia0jTjD73WMqsi6w4ExjG2Hn
 HC+ju0bETJirl3DisVb1n+or/Du0uz5IjYzpf7LteHB+820wHtimbNvmy3Vu+LobZJ3BiwWiguz
 xS/7Oc5x93Kj7Po3RxwHWWOGSD6hnoAK5//V9xWrgqJLQFwEjC3JUmyLUmMD4AIgOWyPfVoI0Q6
 k533W/u3G+pFDjmHC9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0NCBTYWx0ZWRfX5Eg4QnmiBkIz
 cVKeNmTER5WaCStyEXKn2H21K+C4wFNnxK/BNqeeEmgdrEUKrmbMAfo+dkBRJMOb5ZVXFfbMZ4E
 oM523HEm8UAfemjyvoR6RSO/UPkvDzw=
X-Proofpoint-GUID: 7VL9m5OAyE5HVvzMRNqVReVR4yfsT_dO
X-Proofpoint-ORIG-GUID: 7VL9m5OAyE5HVvzMRNqVReVR4yfsT_dO
X-Authority-Analysis: v=2.4 cv=F85nsKhN c=1 sm=1 tr=0 ts=6a7a00d5 cx=c_pps
 a=v0elvT+g34jhj2ItdigShQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8 a=V-9SEFE5XLpnScR90R4A:9 a=CjuIK1q_8ugA:10
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100144

On 10:54-20260810, Brandon Brnich wrote:
> The PM framework skips the runtime resume hook if the device was never on
> in the first place. This results in a crash in the system resume hook when
> a call to e5010_init_device attempts a write to a powered down device.
> 
> Move e5010_init_device to the resume hook to ensure register write only
> occurs when device is properly powered on.
> 
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>

Reviewed-by: Kendall Willis <k-willis@ti.com>

> ---
>  drivers/media/platform/imagination/e5010-jpeg-enc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> index 42ad9ee3993b4..2b98d230429d1 100644
> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> @@ -1501,6 +1501,13 @@ static int e5010_runtime_resume(struct device *dev)
>  		return ret;
>  	}
>  
> +	ret = e5010_init_device(e5010);
> +	if (ret) {
> +		dev_err(dev, "Failed to re-enable e5010 device\n");
> +		clk_disable_unprepare(e5010->clk);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1533,12 +1540,6 @@ static int e5010_resume(struct device *dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = e5010_init_device(e5010);
> -	if (ret) {
> -		dev_err(dev, "Failed to re-enable e5010 device\n");
> -		return ret;
> -	}
> -
>  	v4l2_m2m_resume(e5010->m2m_dev);
>  
>  	return ret;
> -- 
> 2.43.0
> 
