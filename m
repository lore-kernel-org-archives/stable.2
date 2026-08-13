Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA93546DF;
	Thu, 13 Aug 2026 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651095; cv=fail; b=LtsjO8OjS8H+tNA4hluErr4+xP24IvxNRuEoM42UJO2F4ghKyDI/0VnVHU3eSo1ojtSnXMWdpy1SpQhejZN+pSWiMQdVelr3JIzitCWKhzvv34zXLVNPyTqydmPkyIK1z+xRAb3kFDP1QiWDmxcTbejF/zmO7VYxcwtvchFtWIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651095; c=relaxed/simple;
	bh=mRXAnG7Bzr8o9gitFu+jiprIaPu7preDvIfbHDoSxnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BbfsSCdGWsogKzHwDTvcZSYV14+oLtXEqilWehfGBPT+yA9ZSmEyJ3gBj92ObbcblYruW41GMqwhqRTy4Io//68q46gHtNRuGtgoKKzeqdbShIzUP+85eWoe5gXh8Bvr4L0atFIh4yP3jf1fu79m6L6hXEFu5j5nf7kYDWnB1PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oBcXUSPI; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fyMbCdR+; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oBcXUSPI";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fyMbCdR+"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67DIfQ183917904;
	Thu, 13 Aug 2026 14:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=lV5VKIVt/+eyZiCmLlLTB+92JixUIskGcFMYaRUV6
	Xo=; b=oBcXUSPI4warnwe9LZG/ktWOZliMw94K2YaxecRSRP1AEib2+THg+SrOt
	3gxi2rE9cL/f6CwKEDQR3WB0RO8IpvWM0tC6qtC6og2ONlVSbsItOuyYhBKSK6eO
	GPyr+dJEJuYvmGdtNOEbwJ463MyO3qc/JMYi9Ic/Y6z7j2lXrWadj4H5Bhzf3tds
	ZPHFhljt764X4SDUjeDpdoc69NOL+ssa+ybZXbw5SqEB5pwGIEX8NLH1z9Qm81UT
	dKgGCN7+QVRQolgPoo1qvdrXXZcPFxMZcKMiwIjA+x0Gd/KaPd9AHybvfqd2hnve
	gJ98yUy+8c7vuYrW58AgDXJzQuY0Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	by m0384305.ppops.net (PPS) with ESMTPS id 4g1a67m77j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:57:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yphK9Y0Xwn2lVRa9E7aM3VuIOQHYDhJ2K0HwqlZtmcoWucQHOMrzA+4pFgypCuu1pUgGzg29gVgF61WIJeAFi1plIscLm+UsPwbn1pHCTHApf+oycehE9sSF51sGCOLTyIB1Y/5akRQpLpGG4JiQmbGgDWaoJ5SogJfvMzoiEw2vRNTY09UG+3hftvfHIJMGB0YEhNO7CjOZfzUyX9T+IC2shYwRjtiOwCJHlsl7DKZ+PbEu38w237U3Y35qCvJBZNXzJzS6yTZIilPZbYSglBkMCvpgoWXi5eatYLGQmlqCv2I5U3Cs6Jyg56Aef/aKlXwOTfWh9NmnLnsYKoKcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV5VKIVt/+eyZiCmLlLTB+92JixUIskGcFMYaRUV6Xo=;
 b=qOSJdepbi9H9HYzkpc7YxHgAx9bowCkCOqco8hTBYVbzpnHiDWyG/j7HOeV4BMQfRVjqNVrm72f+HQCWn5cgrhlIO9NXRKbwPxDwdiUnSzx5nGlxwVVIWm3sWhEJl35OnMSSYG5ZIn5uQzRDLduaEtvVYKf0MyaCTaqSpdoVSXjEHQccl6WHwyOJWDMJT43sBVqCH6v2/VUr9ElP8VkBNj2GBZ/3lCOulGP3Ww201ea8fipbHj82wzEd15QaKM6toyLkfaDfHXuu6PdOuJgsc40a8oTxuDbiNoyLWLWjeDhXj4mZHCad748qb7C9nYvQzyU3xePIjOqhjEnrDVXAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lV5VKIVt/+eyZiCmLlLTB+92JixUIskGcFMYaRUV6Xo=;
 b=fyMbCdR+ru1X1DcEhUBO+mEFrXuMzNhMvf6GYNpxIzdt9tIqZlK3kwKDQ+++1ZY1BvAfbW0Re7QR43f1BV3vBRGmui28bdEYUePtgoANBiB3sL/VoS2o3XD4fZDg8m/5ieJo9JncDA26s1NJ44HyWIy9N6EPZ+vxm3Ry6AkvQLI=
Received: from SA0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:806:130::30)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 19:57:53 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:130:cafe::8a) by SA0PR13CA0025.outlook.office365.com
 (2603:10b6:806:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Thu, 13
 Aug 2026 19:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 19:57:53 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 14:57:52 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 14:57:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 14:57:52 -0500
Received: from [10.249.64.201] ([10.249.64.201])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67DJvqcv1434084;
	Thu, 13 Aug 2026 14:57:52 -0500
Message-ID: <b4ed6b46-07c3-4ebf-9fc8-b9ae0dc03a51@ti.com>
Date: Thu, 13 Aug 2026 14:57:52 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Set MMC clock pins as
 OUTPUT
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Moteen Shah <m-shah@ti.com>,
        <stable@vger.kernel.org>
References: <20260813111238.56892-1-francesco@dolcini.it>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260813111238.56892-1-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1137c263-22b7-4e67-f0a3-08def9752931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|56012099006|10067099003|3023799007|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	7gotDR1rF449l+/brF7bByT7MPjoZpvZb3tiXrNir/8HecN4i6lPdQ8W9/R2c1YwUCiJg1bsn+Z67b1kVD5z0CIiVV2vN37bmMiaZlPKKIaAJmkSye92pg2Y87/S1wpgCoIs6zJ8+GxAHlAZcwV2M0DQjz6GLySzlRaxFYE2sfpuAtAp5GutlaOwzV9+mI+AHLL91kSfwX+UvfEpJAFKUdSo9QF5cHLxTgxB7Tikp0WxeRZLfyuQ1unuF+j36H6xdvT1FIJqAxJloS3gtg7yboNIg/BNyfnkJ+mbvqVT9MwdQyeAZCp75GYU1bC7k+ypmMikBE+oUjS+oSyvGf7gxNg2BuKdFTS2xWq6fIJrnv8QfbHFc+t53h3zAk67jBOjNJKlSSSBtM+Oy4SvuS8Dli13/G/fwoBobMQbh9Z4jUE5WCr0JZKT1g4T8FuVZe8aMiLqhNYzb2lfNgh79dMYvQoFlsp4AOQ5vnq7LDloEastPkfUcMoPmi3uKatP6XN1iaem6k/JeVPhSZjElBrCLS81fcVGcOOFwv9GcsiUp9JXJ+JrfZxK9S0n0a6ToVIg6US11F/igDPDfy1KwtY96GBLlyB+KE/6UbGBs7RsmmrcTQp2X6/ItYi/mIWo2m3F639DzLUuTWg2fwO+tKkhssCg+a63zMAjbqVbNVRJemaqkgycLrZFMZNvgFjGjkZLlvKH9wWhWkJCVC9t+1aXtw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ay3egwIVJXdBqLDYsxaN1Wlcxj30OzBZ+8yRzNGEEPnipqfCmXfqcI3cQmq44QMIwyMAg4IcU/+yZ15ikBgISa4R+CLO14DX31tlPeU1O8EWbJ+HXF+SAgkf+BUDPGd6Zpag2Ycqv04BfMcBiqHgXfDpz0AjskU3QJeNBv665s448EvTBZPDv7XFQXcS6G18C/2fhSWp39p6MRd/1JZJ6icI4L5t6fjxcdw8edio7XqWLU1RSKzHGaUO9i/22Bos81RllOtY6bn/oVfNMerIaIAl0D0jorrAQ13S5aKlTGImo1RXffbwok1aDwuplK9nwQgA4JRSUmjNYc5GOSAc/8PbdcC8LylrYij2fQi4AStBoZw+02gCx31chXye+sEQzWKXbq1auX6A5F2vepKEvIBVfXgzcMSvYMUejf4pwPs72atsm7eQB4n41EoKwta8
X-Exchange-RoutingPolicyChecked:
	ClO7CODwT0fj8Bgn7jEjn3iCjWzw9m1J5sbSHkRWiCggsaNoN+L3HAthvwhJ+t+fepy7o5pQ4BXrZX/rELaw2sEebS3CiRSqHu898cz9S3wzcCU146qdZTOUrnS+IcBVk5fyVuzqmCqUjSb7xxLYZaas+gR9cmIt5S4/asySEYqQhFv3fmWzleiXLmKa5cGHawFbJf3uWW0IjfBeqYRFTMq1Xy/Ejbk4mEXD/1lRvNb4sKW12ucIbr6ZtOKjLbhElvp0KYBywpOjar2AZqzbglzyYQU3PJB29HhpvnBQpVQyPb2JefFg77VsTShdJCVeoLkyZ2OUKa+Z03UPslvkdg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 19:57:53.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1137c263-22b7-4e67-f0a3-08def9752931
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE0NCBTYWx0ZWRfX0W9Xlo1AD4lw
 l0UvxIokAndlLSBehFYMIiUx9zHcQmyPvUDdMxQvXYVw3Ex5RQCpJ735OYg/e1joBkUHIXyCPy2
 +qQpYyoKKvn6OjGf7wmiP96XonjlLWh/EvPPmbw0SIf2KBJKv1F5QPdcvR4f5tVSViVeDdPhLg0
 4b/WL6eVpk6q7zZqFvDPmUBUUe9aJ0AEey9gCZuXYJ1Wjj3ICsb1BmZu2vpQ//tvoxOFs/ZZote
 N2vBCVjE7RoxBNinSKo8ZTxida4AzBMdtVqH3atS3kkkBd0IVyddytWhxUy1VaNpUy35GfQMkTy
 hZhtuYu0vdt7cK/luEqdG7xNaFHpT1Y0fTcmGel+jRj01fYxYIJjoC9kWMAcHbL7IlmWrCSQjSZ
 lDaFyC5xMnjqGJEbWSLyZqsHGbydWrN7ps72/io2UkbINxgh7o3rXeuuToacqTkvmH9U9jDGV8k
 q5Kl/xCg6hhzIZKMwdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE0NCBTYWx0ZWRfX4DAH7COpNJFl
 8I4VXOZI2YaMgjwVPpghf043Lwi+dPoKf7vbOM7JLJtBr4uen0s9+88ogxs2m/iQ76er/9uVWpx
 8CaWgIzCkjbnThzh/TRiqgX/MvkFjW4=
X-Proofpoint-ORIG-GUID: 6JXF0udlJguaHkFJ8jNgl5MXfJtj_rPq
X-Authority-Analysis: v=2.4 cv=D/J37PRj c=1 sm=1 tr=0 ts=6a7e21c5 cx=c_pps
 a=Za6wG3+qag5e9bFCWm8neg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=m8ToADvmAAAA:8 a=VwQbUJbxAAAA:8 a=DUBBNdmAkku80Pm9GmMA:9 a=QEXdDO2ut3YA:10
 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-GUID: 6JXF0udlJguaHkFJ8jNgl5MXfJtj_rPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130144

Hi Francesco,

On 8/13/2026 6:12 AM, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> MMC clock pins must be configured as OUTPUT-only per TRM [0] with
> receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
> PIN_INPUT to PIN_OUTPUT to match documentation.
> 
> Link: https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals [0]
> Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
> Cc: stable@vger.kernel.org
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Assuming defaults are set.

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index e97b2b047d10..895b1b7dcac7 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -573,7 +573,7 @@ AM62X_IOPAD(0x15c, PIN_INPUT, 0)  /* (AB22) MDIO0_MDIO */ /* ETH_1_MDIO, SODIMM
>   	pinctrl_sdhci0: main-mmc0-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x220, PIN_INPUT,        0) /*  (Y3) MMC0_CMD  */
> -			AM62X_IOPAD(0x218, PIN_INPUT,        0) /* (AB1) MMC0_CLK  */
> +			AM62X_IOPAD(0x218, PIN_OUTPUT,       0) /* (AB1) MMC0_CLK  */
>   			AM62X_IOPAD(0x214, PIN_INPUT,        0) /* (AA2) MMC0_DAT0 */
>   			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
>   			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
> @@ -589,7 +589,7 @@ AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
>   	pinctrl_sdhci1: main-mmc1-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x23c, PIN_INPUT,        0) /* (A21) MMC1_CMD  */ /* SODIMM 74 */
> -			AM62X_IOPAD(0x234, PIN_INPUT,        0) /* (B22) MMC1_CLK  */ /* SODIMM 78 */
> +			AM62X_IOPAD(0x234, PIN_OUTPUT,       0) /* (B22) MMC1_CLK  */ /* SODIMM 78 */
>   			AM62X_IOPAD(0x230, PIN_INPUT,        0) /* (A22) MMC1_DAT0 */ /* SODIMM 80 */
>   			AM62X_IOPAD(0x22c, PIN_INPUT,        0) /* (B21) MMC1_DAT1 */ /* SODIMM 82 */
>   			AM62X_IOPAD(0x228, PIN_INPUT,        0) /* (C21) MMC1_DAT2 */ /* SODIMM 70 */
> @@ -601,7 +601,7 @@ AM62X_IOPAD(0x224, PIN_INPUT,        0) /* (D22) MMC1_DAT3 */ /* SODIMM 72 */
>   	pinctrl_sdhci2: main-mmc2-default-pins {
>   		pinctrl-single,pins = <
>   			AM62X_IOPAD(0x120, PIN_INPUT, 0) /* (C24) MMC2_CMD   */ /* WiFi_SDIO_CMD   */
> -			AM62X_IOPAD(0x118, PIN_INPUT, 0) /* (D25) MMC2_CLK   */ /* WiFi_SDIO_CLK   */
> +			AM62X_IOPAD(0x118, PIN_OUTPUT,0) /* (D25) MMC2_CLK   */ /* WiFi_SDIO_CLK   */
>   			AM62X_IOPAD(0x114, PIN_INPUT, 0) /* (B24) MMC2_DAT0  */ /* WiFi_SDIO_DATA0 */
>   			AM62X_IOPAD(0x110, PIN_INPUT, 0) /* (C25) MMC2_DAT1  */ /* WiFi_SDIO_DATA1 */
>   			AM62X_IOPAD(0x10c, PIN_INPUT, 0) /* (E23) MMC2_DAT2  */ /* WiFi_SDIO_DATA2 */

