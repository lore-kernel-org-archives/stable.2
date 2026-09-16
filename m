Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CC4E50D9;
	Wed, 16 Sep 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585071; cv=fail; b=VZQITdDIiyoOMG0XRkVC8IBXkTDyfOP7hZwcoTK+e+Vc5N339YZrU3wKZnOCiD+FtimIe6uQzfcxAVZdiIjNsqigCvrXMSYm4i55jjdbEQ0wSJ965yK4Jr5ErOTgJS5NqTbFxltknyzWxylzN5iIeFWZyRBsXR8mC28FB5PmuOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585071; c=relaxed/simple;
	bh=0GZ2UipZXN07VPosOrQUH03cYtqh45urJydwlxqy7dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OBLT5BOHC23s47VFaiIF7kaLD3bjWUxq1oAaNnjyL8XlFQa+BNMcrpQOOSAbpzPdGby1bHQKQU9lD18CdbijqZayPSd/c/bV0A9fQefACbJIEAyQqrytued0d9dvP/+fPcH6IT/+PNYUZ8GDyQp8L3PvH0yz/2MhwqPcKnpHX4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Vf8bxWJj; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QSnW8R8O; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Vf8bxWJj";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QSnW8R8O"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68GIjAjc1017587;
	Wed, 16 Sep 2026 13:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=A5CZvAHr+ZC2n2j02rCddukx8njUDbyClBRCHEb2g
	N0=; b=Vf8bxWJjjLS8GnOky33B8w2w+IAjMHdslTMdbSgLcATgEdh/+OjGBP6pG
	O039OToCLNtwpQtSM60LR0O2SBuC1tX1wzSuXNUJFvLIJaJuKyKFiIGci9sc7k3L
	0bgEqTg7RCu8NlQkdjNK7uXAt4riL1ui6wDYsmuem5NheEC9VCZ9G17dtQchSHEz
	G7e8WydfjRuOf1LG7EGsw4rAnkbl+RUwX5N8M6g6PLU9Ik3O8SzUIhkWVKKK/n3c
	vQJ2hv0cLd54er9hAPzJdU+vCh210i+o6k9b4+ayYROyzUGKeWv9Q4lc/hnLr7GU
	LPOc+EqFMbZv8/4ayya5hSWE+J+Kg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gqxfp98dv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 13:57:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpt4B61PV0KAHaIJPwo8EPvbSLoG2aPXZVS9nyGsgfi1RHyZr6dXFLIitMrM6LGAtQFyWdr4Xvp7AvON8VTp5rttCII0NWetfFNApJ2PcQNCBsdgfay3RsLy1YnZOn1P0BxGk0/A7UNFLXqox+ZXaUoOx6wLFqkxucbKxQ3PTR0zHS3BW/Pix+O7tkQZn5jqEMzrKrs4PoNyiw1ssnrIBhJz+bP7ICU62WGvW9OO12HkbmY23HyStKiqIqwTBsw3+T+13Z4e1IE2v3YPdRYh/r/I6TRXvfV/TcM+j6SabOZk0tR5fAVD8zHKMVrJDiRfo58ReuH/4Cy4DTFshzh5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5CZvAHr+ZC2n2j02rCddukx8njUDbyClBRCHEb2gN0=;
 b=pG7SptP9vidn/Rhfj4n+xD6hmfMlD+5jlYL5XecFHyFjYzxVTpZ+x2Je7VWYNARR/xhzgFHaHSKvg8kOCZwF17LkqRwDUobSpp6p/pfTCfVTZceRPIypdStoC+hSOp3ScGZJxwvUufKJWWDLuPjAhvyOzXlhxI3lbUQ9VcqlKYR/3R4tKWQC68WHhNdRi71lZJusXjxaf7HrGxH4cMPl6YspBSaB9Y1PhYvjEtiMc0CEl6KqLXk4y0V9XlUjqPsZpbgWZVB7OVsWHEGmMQXBtKaF0UHgaC3NsOdCeMQUA81eDZMW7pe2im2Q4iWWN7rEgaFHYz1A+x1pwvaQzMHaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5CZvAHr+ZC2n2j02rCddukx8njUDbyClBRCHEb2gN0=;
 b=QSnW8R8OfRhrSYlMFvYnZsb+fQbnJAmFAJIqA1n1HwSEO6Pr5BRnhu+pI9NL6alz7bHsg/wST7H7/863GUaBkHlLVPkmC1mc7OFHsc8PQlxxSRi5tkX6Ph+eXB8KxufPz1HhIoBQ5V1OfVhJfwzm+GFJJY4id78Kv94sxuHvHmA=
Received: from CH0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:610:e5::29)
 by MN2PR10MB4222.namprd10.prod.outlook.com (2603:10b6:208:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:57:08 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::4e) by CH0PR03CA0264.outlook.office365.com
 (2603:10b6:610:e5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:57:08 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 13:56:58 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 13:56:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 13:56:58 -0500
Received: from [128.247.75.46] (ltpf5gwk6l.dhcp.ti.com [128.247.75.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68GIuwMC2500259;
	Wed, 16 Sep 2026 13:56:58 -0500
Message-ID: <52c7da0e-a8c3-44bb-b3c5-9df082f7c7aa@ti.com>
Date: Wed, 16 Sep 2026 13:56:58 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Fix runtime PM imbalance in
 __davinci_mcasp_set_clkdiv()
To: Wentao Liang <vulab@iscas.ac.cn>, <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <zonque@gmail.com>, <stable@vger.kernel.org>
References: <20260916073136.1971673-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: "Wang, Sen" <sen@ti.com>
In-Reply-To: <20260916073136.1971673-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MN2PR10MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2ec1ad-f828-4984-cea7-08df14244eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zqbC+IR5tzeYRW89Btrihxobw/sK/DiF2mtPHduC7SlA9yvTAcTDNLgeFVaw4VCsTB4D4u5CCfp3g/mvcKbdhm75q5FWsoEkX9csQ1eiDyVS8epG2yi2ML+24p/yeR6GSAlNy7AScHaAT7feTmMakbCmPf/NeHRi7C2lns9pcM0/G+0X+WH/a2l5phj0gVd+QSLmH3jtlOT91IJYqPbSAcMAvyNxuo7HmOb0N3tQ7+2czeEeMg2J0SM3/6dXbfMVibn0xGhKXnvFOmIk2C2xMFute3oTv825zv9FDUUAbEsNu5ffcpDuJGATAXeV17uoI925tOM4sTO4rtfR5nv5GRCD6hWiY+5ORo1du+naISx4QxuIbQW+1n/SfbpziVkyAeO2rKoyvK/c7xIBnZvP80U8V5TYjsklD4DWA5qtCCP2cxtMfSwlLprdZwFGdGOa74UbVf14hkSYxtczdhKHSrvuE5RkF7CSYEF0bi6EZQ/HomaIouU1Dv3hOn6rCuIzua1sNgS4TUCWkM61HkasTmhcWFjrxYCTP98u2mrb1GVDLvHbE/yL2oMolWI1LEqWMwMeIPePGfK1pNDQlmqJSeMfHRbAOvuQYHosp7BoHvvsWL73/WYsW/OU5+hg6cIDjWt77qKNGXoeKXu80YE1UjtSpVxTSWsvUOQqtKI4TVnE3Oio+sfwY74TBTi16j2xOhvLHg+Wh2ieLwDy5MsJzw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MOs9EAZXzZwAXXARNVifsPotnIdUqWOnjpffL6o/ZJx5Iw2M309zetJW/WKCtjsD8Np5GlvcSt0vb355NAURZ9RWl2JZwD9l/Ry++obe8VVPOaZCvgsyRq34mB3SCDtpho0YuSMb/nIs1uw3r0eRLH2wRl8dwDozASK23UFNtifR2mzQ0qkX4uPdQ8swK3cNsBQgyRVyF9ohNcyaTwbJ4StHnvKGGcZYEMzA6FIHXlthIa4+jaTdFijS0fbpMxvnqfgOHRtDyexKDvRv1a0Y+EjKs/dXfJvqZlWEFXCjTw5aJNsi7W/hXUsa4OIUGZgfOstXo2xihY6XNAp1l7/rpZEvj52kr2iRlgwKOIoyj26qEC6HlkkVw2X1SdoaNy0eBfuze7nD3weLDYA4Ou1GHU2IItWH7NcxaaNwUn45U5e55LJbeMAHdigumYi8yOAr
X-Exchange-RoutingPolicyChecked:
	HDZbEt+CHdzLr24+giZbuOl8HvFv30u9CW/vkhzqfJnUuM6g0Pw+BXwxVg7d9zzIq4+u+dLv6dHOaNlKlQvNq8fNG+hp4Ovi+hblDjbkQZ9kFyxCcRt+BAqYc6UOIWy1cClED/1dvA5zxJUUSUsY3Jsbo167qW52Mxn9QP5g1qZtWgd3f6dcNju68EE8mNE2jmJOhqKp8ycaPRRqp9SPSnhmlVT+hKzZjzkdefpOXVt1H+PioFs+4vqRa28ldiwbPlj2K2s0bo2voB52LSHQ7MEdJcFMqelPtW1NbCYVGmIkGZkgpOZjBwPedzniiysCuFfPV6AKXKXxW8LCy3GAqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:57:08.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2ec1ad-f828-4984-cea7-08df14244eec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4222
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI2MSBTYWx0ZWRfX4cDvq+YAj75z
 GPmO+DXkZFEfxXKO/bzi4UZtEAg/lHO6dnxEV/t+SJJ36KUYDuh3oj2TYYxTTXuC1ZU7BsKBerB
 TpfOVIXFz75+iPqciJXle5G/t7OE0JQ=
X-Authority-Analysis: v=2.4 cv=HaWB3SE8 c=1 sm=1 tr=0 ts=6aaae687 cx=c_pps
 a=AgKHDJP192gAOy1PpHj/Qg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=QAaHeU8HhuINRdRyLMcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nNo1i8gq6xBEJHJgngXSk9vkHKoLSXrh
X-Proofpoint-ORIG-GUID: nNo1i8gq6xBEJHJgngXSk9vkHKoLSXrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI2MSBTYWx0ZWRfX/4nNJDN7ai/z
 T3VMZyVgB904uOBS8z8UnIFVrcj8b9Bo5dRqaqg19fxhShabV/iAoqbESS/cDM+azgBQS5hid5w
 7/0bWJ01NE5Bm4y/xtjKdc2zOfFdNT3AxkJvTYxEBy9qWop4PD1VJQkTDkWsELqpTtWMH7yWU6Y
 3b6bcZKmhRcohOo+Ch78Y02t1FiqEvETjodMhbWPjXoCvnG7dHN2MloeTJVuYT8K8YuhIYJADC4
 vbMU+8kHLGUXPBaCqY10U4RfykgvwCNkwqLfSregBGIpPyoM5r8CXYqY8tvIJqvOm7NBahGsHyo
 SwHM4hBCUGOCNjpi5cjs+EXfdgv1wK3IUgR2jFtrwJeirNZE6DiQitfkO1pfhhTPkLJKEsj/7qA
 4WjG0419mGQWVA0zykFY6UWhZaZ761HNSf0+RdUQ/jl+3+OsVzuY885YTUZ6oTMgcGCroKGaj3y
 /XkJaolGL8hAW9kva+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160261

On 9/16/2026 2:31 AM, Wentao Liang wrote:
> In __davinci_mcasp_set_clkdiv(), pm_runtime_get_sync() is called at the
> entry of the function. If an invalid div_id is provided, the function
> hits the default switch case and directly returns -EINVAL without calling
> pm_runtime_put(), resulting in a runtime PM reference leak.
> 
> Add pm_runtime_put() in the default case before returning -EINVAL.
> 
> Fixes: 4ed8c9b737b6 ("ASoC: McASP: add support for clock dividers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Hi Wentao, thanks for the catch!

Manual runtime PM reference is quite tedious and results in reference 
leak like you've pinpointed, maybe it's better to convert to a 
guard()/ACQUIRE() based approach in the future...

Assuming you took Greg's input if you need to submit a V2:

Tested-by: Sen Wang <sen@ti.com>
