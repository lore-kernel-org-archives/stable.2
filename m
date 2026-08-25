Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3B485CE2;
	Tue, 25 Aug 2026 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669665; cv=fail; b=UkCKBU5dxEn4dp0PqcLboVS8XTZYIr7DZA8SDOm480SRjaLROlHlvPUmOTP98ZlaJ716ZtVZRiVVXMI0lsQw/bhRySP5A2CpAzGAz3m718vLKI0ycoptg39S8NZnQbf5VjbhIoy85rjosO03e7mX+u8KduPU2Q1AJeordweZ/js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669665; c=relaxed/simple;
	bh=FypnKfNCcSfJpdh796UtI7vQlb18s7IqFHfl3vF6edo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVLvtzhTHfgn18m841PHNO4HNOV44X7haV5wukp+m8a4NOwl8do+OBu+K7o2JEBQXizd3oI7/y2WWRgW6s0+febP6BO9KxdY81e8X1FEu1Lpv4qU+ZIk3C45RGW5o/Dy2A6Vi3at6Wxbjt32IahbmK1r20fOt5vYG2FUzXkMdXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eMbQ6Nmo; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RvCuncy6; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eMbQ6Nmo";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RvCuncy6"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEVbTA2046003;
	Tue, 25 Aug 2026 09:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=proofpoint-05-2026; bh=3i4pEUMDOgEDCHU
	aQCN8HIE8Gk/70xvhaNdtUv6g7Ek=; b=eMbQ6NmosXzKCRBGaCBTNE9U/iBter2
	vEgHI6ieM9qqqHqDIx43kB+MJdlhWwG2Z5+2+tIiY6btH0tBewwNo8i232AOE/ud
	k5RZ5erHTZC6vSCOFRk8y8NSfUPUWdKds/FkbWgY9YpQwLoqO0O2EA3CV3K+my+Z
	DqCqB2xvSaLwO06upxLjewuC0HwFK5Aj/tSGZ+8VDzM3ZNUIcvIJA88snB+O6YTc
	Z8yQCY1Fimrr5Eqpo46DNx8A8M2AavF5r7oL4eDksVvgXDkbXqZjpH3sH81hUf2l
	+WjlU4FrLcEzspa8mIZm/PrFWuJqzedQMpV3hujPgJt8BI5cpGxXCBg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g92xnkdt6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 09:53:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea4XDS2mr/u5ENC4/Ww+u+pf/rWrPk9/u6mhHCwXI42BALEiTvVve3fklgUC1nJLWC+G1uIV+17THEhaBA2H5LGIVqPg1IPdXcOhe//IcpkTmXXRDEC59UPsyR9ikPzRun0EgG7HNToE69LnZ39xY8npXUjJGep5Ir4LZg+MCj5/G7R2ZbY8zHasrucdh8hPK4dSFYeyXYMYkYxuv+jYvZaWtFRcUblNmdo/xTRxL91kK2taWxr/ai0B+cT6reBVP4pOPteuVFiaUOQaskGmAM4HAzu/hQypX0E+J3vq+txX9vRywdNjpMYr7mZV3st1U44AweZUbaUMCjs82HeCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i4pEUMDOgEDCHUaQCN8HIE8Gk/70xvhaNdtUv6g7Ek=;
 b=ROH+ZZ5E/5yiBKWguHTNCTY+7ip6PlCwcP/AOmdELKDy3YiURJd6VZIS7Nu6uEqFGYzXd8SjJ2RRQgHezXn2JW2js3cY9wY6h/PBrsqH6qF6Qa8hyvl3Cx9GCUAEXcG5NHzDF/za1IKn4MrJr6VjgzsgFrmz8JwnzHkp02ONCLSsm+sDAIaNJmK6mPjqfY9foKLIyWZSHJmr6yRL7DF62wvFrIffbmRwvbj2VNWoQlltjk9KpIIHyZrXtJ+moFoZ6em0CaQ8/+0y2T3WkoncZheoPtMhMbLFFjhxIcG44MqSfN2o/M3FV+gG6qReYDJbbhuWLlT75iLgt7A24FtlCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i4pEUMDOgEDCHUaQCN8HIE8Gk/70xvhaNdtUv6g7Ek=;
 b=RvCuncy6LCVHzp74xz4kNdbBKv2o6fu7JxIzv0HOFFzh4yShFG8sugmCj8vbXmsO/HbPT3etGLO+tP7a/sRhqSPtQvvOUzNFsuqe3yRsO8BFhWAIY4SZ0Z2cEGyMP/KMoqYytfDD9yCmQkhea36NF9eoTV6R/SvDNnylnVkAQZI=
Received: from BL1P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::11)
 by SJ0PR10MB998056.namprd10.prod.outlook.com (2603:10b6:a03:40d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Tue, 25 Aug
 2026 14:53:41 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::1a) by BL1P221CA0032.outlook.office365.com
 (2603:10b6:208:5b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 14:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 14:53:39 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:52:58 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 09:52:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 25 Aug 2026 09:52:58 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67PEqwVX1206558;
	Tue, 25 Aug 2026 09:52:58 -0500
Date: Tue, 25 Aug 2026 09:52:58 -0500
From: Kendall Willis <k-willis@ti.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Tony
 Lindgren" <tony@atomide.com>, <s-kochidanadu@ti.com>,
        <a-kaur@ti.com>, <s-tripathi1@ti.com>, <vishalm@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_omap: fix wake irq cleared during suspend
Message-ID: <20260825145258.nlnfj6jr5tqys53c@uda0506412>
References: <20260824-uart-wakeirq-fix-v1-1-6d81a230a1c4@ti.com>
 <20260825072712.jR_IlVlw@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260825072712.jR_IlVlw@linutronix.de>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|SJ0PR10MB998056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a70fd24-c5ae-44dd-82a4-08df02b8a5f6
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zggWfwZIkVpEIv1nsEvTrCmeqd9tCphfXahAYQaCpWKo73uiregm6FcMId+dTzxqjVYaHi8tVUD+5T7He8LjZpIkscnEbANKSIdPG53WamOvB5IY4UJdIplOU4O9E/k8YROJHfntgiMbrpLSmsCVrfTQVHrdqd02Tqtw5FGXD7nDp1cM9hkyA6ehB91WsnuhQkf3sjqGURwBQRwMHXX8ghjLFTzhbuNftD30DNZXStXfLmzD9WlM55ALeKKcGoO71JhMFnztXsvWJAH8R3GR/i4DJ8c+J53lWI8suYE/80wP3NOdTHD8WkK6TqP1jYEMLU+IHSTVDjiXa8yx2G7HLwhYsZ7v61Wpty/TVSbETqUJneab+i4G5jO+I2A0LbUPcAlHyH+gkEmM9p/n8y5IITF349/sRKhgZ1uUdYQutbHTQ1RxtF7tvrXUkLYvgsfIcKbmYs5G3IKX4Nm49/LDLOUB0nZPoOJ+00Lt/tb8j0maN7RchdQ/PGao7J6WKCfOqg9OAM+4Sktz16+iBDf505ODwWwVtTTlSOBOPE42A2l1bjglzmxUcqZ7nTolZ+gD78aNmJJlqnFUJgxaqjQZ8TgjhqopepANRn2qpe5qt3T5dhcEQRD1U43HtDInYtqPWGrfjYD1wxIPrEqlqgu8xZkOgchziKmePyR/liaboCrz/aqLxqA12ompgWvcsKWkb9kLYRkcj7Q6Yr/1ITZSBg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9e4KkCtoZ5NtB5oFgHdtZ0dzVkO9cMfeTm9sOE5/DgeD+D+Bq2LZ2uW+Hz0X0ktGNrB4JxW8Y0xcE2PufQD6nchifaXr9ay7z8Ca7udbiaL2Y5lz350cuZ8G3DVB0zgSw+Sc75qNJzONAxeqfhHRfCm+QJQoXs6jqYWBy0aFWLRPflXAuMg1liSwmNqGIIYcFE6D2EpSxiamhztpIsODPCqerkw8JkCtQkmS8czh3xdr/IxcdmdDlmwdWiHH5NzxAyWUVJFZfZ2McwNdAR0bNN9jUQKFFtDSBC/a5zopl4p7k/nydQBjGGVdOqqhsQ7GpX/x0Paz+MbfFfs/6AeE7pbxKkrPS2LYCXYbRybif8Qqejo3cs6/KO37spRZy3BOgMq8Nb4H6F5UOCyaNYO/GJGdx42JomY+G7CtoyvUMhRm6+mrz1Jf+hNxXDRkZKxX
X-Exchange-RoutingPolicyChecked:
	f7F7kvL1aSGgydIWtIKSvKGiu/sb7TGZV2mBEF5Ygku+N1KViEqJPbR9653ibzhWjs/77UkABIFzPjcOo8ayl0dXXJnJXGjAsVusAfWf13Ky13mt2lyh5WKbJZYMW/nbi1p1yH1yn4WJZQSXHwWV4cH3wZblKcUxvwFAm/axyfT8h3dH6yIJ6pSniWrtyAXlRfxvIt1N1zUGnWH/wOvWLx8++jtxkq3Udb7I+/wAid/pAR7ZaO28MgXLYomc4KWnyhS/a/hLhax4xqcJVKhhBYvG1cOGJ3BT2KYmMv31OfP0AoWi0ccaQB7gjUF5ze/8IFr1e6UtHKGb59OG4Neyrg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:53:39.0389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a70fd24-c5ae-44dd-82a4-08df02b8a5f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB998056
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfX7DizhN3xeW7l
 lA36Y0vOL9ys0yJZESbmcoHCHgj121VK8UEmdwWkGkLTJ8tSKD1kOqJ3UxAvNDXRpr3Tno3si0z
 Zh0f70xoNffw3ao8z8MQostOaB8XAyI=
X-Proofpoint-GUID: sgneNSOWSX_6-O6WEQnI7QU8rQLioxTW
X-Proofpoint-ORIG-GUID: sgneNSOWSX_6-O6WEQnI7QU8rQLioxTW
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a8dac78 cx=c_pps
 a=fOo0+MOGfjr111H4QC4BGg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=TgeY1WT-rtaAFZimDk0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfX/Q3UYwMxE+83
 sPlfnZQZxEbN0ExS6CYdA6is25qyVpj4wQoHtPWfnsG/N1ue3SP3GpcSrrXI42rGs7Njj9DFdRM
 DfachZfBkKX6cv119eIAsatMCsU9BfHoG1BzM9O9QuXvgVpU05hSSKPrijMY9/+rldo5gXLrUc7
 lJ4MxxAlYAyUjJlCsMay6Tt6yEh7KC8RjkBuPzRvSjogrrUES9XgQvSzSe0IqbXlI5z/FIEJX9H
 G6YShSegkR0oa1Ghpe5WZiRWIYhTnxR5G9j7f4RupfoDEdGPsy5KHAWzlGbhzmqS0EKvCPZoGnr
 WCqt5aC3plhrrJ0PeeX/Ny0iTFVuWAZkSFdLTAbkcQZ1l+V56ystrcog02xHjWLIoPDI2cLYnkV
 nmdOnbGC2OabM/DKEAVvhchvShgl2wt8d2ZsPdgV8o81Owr4WaBCtxdVwbHNgH7HhzRzVWeD6oU
 8iJolqVxoj/DwgDGgxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250126

On 09:27-20260825, Sebastian Andrzej Siewior wrote:
> On 2026-08-24 11:28:51 [-0500], Kendall Willis wrote:
> > The wake irq was cleared in shutdown(), which runs during the suspend
> > sequence, making it impossible to wake the system via UART.
> > Move wake irq setup to probe() and teardown to remove() so the irq
> > remains armed during suspend when the UART is a wakeup source.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 61929cf0169d ("tty: serial: Add 8250-core based omap driver")
> > Signed-off-by: Kendall Willis <k-willis@ti.com>
> 
> I leave this to Tony. I tested it back then on bbb and wake up from idle
> was a requirement which worked. Tony had other boards which passed the
> test, too.
> The omap driver had and has the same logic here.
> 
> Sebastian

Hi Sebastian,

When I was testing the dedicated wake irq on AM62P EVM, I was not seeing
the interrupt count increase for the wake irq in /proc/interrupts after
resume. This patch fixes that and after resume the wake irq interrupt
count increases when UART is a wakeup source.

Best,
Kendall
