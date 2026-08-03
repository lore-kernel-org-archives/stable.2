Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8979433BA2;
	Mon,  3 Aug 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786057; cv=fail; b=HsYmqwoZxgi79hPmeyl2cHhk8O0gSI0A9RhABdsaT2CY5DQlBRV7pNYj7BYk/NixWvb/68cnWM2mrCu82odiJ6VHb/KKA48tE9VzGxtV0dNH4hHsVmhHzCPyiGCDY6tc3SOQi97cV3pmxITIipkmmUwcWFgkEL4JlqkOJoHRYPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786057; c=relaxed/simple;
	bh=mwXch3drW7Cxf73zodcCln/JI9ZiZqW87y6xTGBSBD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AM8lfCIwTqQVDNRR4qnuMUV9OVXIAj3sDBWJvvmpF6FBpuySgyAqLVwtDpyx37B7g+l/TEYXP/FAcT+FpV+Em3nzej5I70YPNcupYQCESsDwpd+fqoKLNOwaukcWQLePevlcM2aSa0+WBqHaTHjALS47exQ7AgtPcmX6L5wrVBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=YdcNmRB3; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tA1irsXH; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="YdcNmRB3";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tA1irsXH"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673H03FJ233731;
	Mon, 3 Aug 2026 14:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CWhSvV8yXLQLBiTcqUn7Qpp9YsTSMUqslaspjnI0h
	A0=; b=YdcNmRB3r+45iuyFrGuF/BDp3I+S72SXLVe5EPeqOxGNu282+R1rPrxiU
	QtRDXUCXyTF+pgBsOmQPk0ilcAOKt30n+Qdad3IMyy329E9bPaRtXdm2JhmEUvP+
	FdEkJOgLsjsvKjdjqCn6mZ0iNuxgYgLDE5uXZFdqsjDaxYzWH4HPUCsAPS5BdHdf
	LzPHq0dsbUoHa8YfC1U/as3NeBIWUMeZR1Q4XS+RKerSgYMf5VT5GW3Eq9EYEUcX
	BMzoi8IUBSgcDpecbklYxwlnqgdUsNYK2PBmoKGLkIUvxeh3Y2rMUuJtB5/DjfjM
	fIbnf9jnHBfofuLToo5EnFYyaYRZA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ftsxpkwhp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:40:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHm9H3mlEe0eL3jfOgd1ebcsbSOtIXEdvINsufjQrxneuOXPTYmZTbtYbVZf9mZVsJjuLFVKedP6iQkFuQPait2v67dsP/SXE1Id8xsp+JKEJFquPVWMUFzsWwobovDkg4fBeRn/UIiiW5VWt2Uf734Rd8JrngG4VBmHA0R62WGdiervkYr9WQY/tgTwK9s9El2E/vPnbyS0gu5RrUb2RIywVYdoXqFe+gy0ygeQAkoKDsvMwHVdqbsOFCjCAWjtnLTYXZD/XHSPr5zUxYvIspdvfX9ZorPgzg6dINarxhH6HPhD99xGkkD35Yx6LntFVxDVFp3JVRHoM7u1eMFuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWhSvV8yXLQLBiTcqUn7Qpp9YsTSMUqslaspjnI0hA0=;
 b=qgnp4lZ8SkdSlNOs7ThoFt2bFmKNArx2KMAnuTdGZLQNFioViP4FB7Sq8eix1RcvjBDpQdJGG8nduIIz1ze8oQglSdqDLad+/bUkVYqcfbu5oEV1EXuBBcNimxcJYrbXkOFlcCG6SZxTEiDqET3XSHXw3IS18KX/vpdj3KsMVmuyT74npzAueGmkIFg66mfsxwOENcENL4lXu2UUhUz5aG0dz7KCbtA9FNsVeXx4+K5hkF0pBKxpdrvEMtuJxNikfXkrRXI4zrh0iqdCmNmtFAI0JzeUCbwoM+hvpu6rkgMB6X1e5L5BIQSElf3x8Bkkgz6G/CDoizkuge+a7G134A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWhSvV8yXLQLBiTcqUn7Qpp9YsTSMUqslaspjnI0hA0=;
 b=tA1irsXHHTOWJgHevMBQVOAejB1X6pgT4AbbC6TexfxLgrf0pjG/JFxu4RKbTQuLdmT2zGGokKzA2uCurj+aFyxn2IuWaa5V5SwsSA2y3cCMcnlyz59rPnpmi+QH2AsjyBTCbLXyR1ui5dCHwo7Jk9mk8TNl4MGcPL9ihZKFS+M=
Received: from MW4PR04CA0081.namprd04.prod.outlook.com (2603:10b6:303:6b::26)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Mon, 3 Aug
 2026 19:40:37 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::ad) by MW4PR04CA0081.outlook.office365.com
 (2603:10b6:303:6b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 19:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 19:40:36 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:40:35 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:40:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 14:40:35 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 673JeZgI2348385;
	Mon, 3 Aug 2026 14:40:35 -0500
Message-ID: <ae76ddd0-5401-49e3-8f52-cc7aab189a7c@ti.com>
Date: Mon, 3 Aug 2026 14:40:35 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mmc: sdhci_am654: Clear ITAPDLY on tuning failure
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pascal
 EBERHARD" <pascal.eberhard@se.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>, <stable@vger.kernel.org>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
 <20260803-am654-sdhci-v2-3-a5ee5be86133@bootlin.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260803-am654-sdhci-v2-3-a5ee5be86133@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b4bc2c-711f-4e1b-5f9a-08def1971717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|10067099003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	rYSShDAPyDTxfGp99DHg1/gWoz5L1WnxCgkJbLW4YvD7QuHR2yF3AZytCSn0uvq2CgmfLooON8IieIN8qaBMtSFYQlRqAafN14o8WIBUNfhY4aAG5UFovCL/yki0OqDgkvUg2JzlkCMd25BOLZFE9IN/tUus/+LJ4tw5tj4EXynTi2c77/H5bdzjya3fkmWJT11FUOmILLi4CiiQOEs2BCwgqZMltUkGa79ozDY/Vh3grwHVZ7FlpZrwiSPfCjYCRkoRNtQR+DJeMOEZOtQ7QVNQgIW2OPbFML+AUPyFtTkZ0pxFZmkaQAkZ8GBAK7MvWyY40GkJKzi9u/VNe0Vrgtzt7Clpxt7ZVWPaS0U+Zpj/avUhUOjk80+PWe6oxgOKepuw+CWwR7LR+O48SXqTQZuhF9jcre4U93j3kpyvlHsaCGD7dNuZCXDCYDzaovHaOBhKiZl/HIswAruud18J7wNaVCbTkYarLEgRr/hJPwrRY0/avwQGdx6yO5SNZT1VXXPffXlfDwpnv5ua9deYF1oM0OfdSNNyq/MWi/Uhe06LlPwX+T9KWKfjmWSW6OYEJRYoF0RY4552152zybSTK7xiM6PqXyz276xIj6sUYlHp4K+UkmqxE8qaBfHweWv5HcuzUPx4Z6Uk5e3TNfu6u/Je+SBKq4xpx1D+1vk7dHA8DOH5V1B81D+KY0tHuf2edM8Ic4Mxpu4qDFt5OEup2w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ofYpILfwyLbe/3oa5BRvAbeawNjKL7onQQWntuMkaXxWH/AxBkm9MIkPF6R6tBEp4f70NXFlN0AUEpzmd2/RNJdRYxXqTOfI2sdxrH+i27Z7gW69f/Tdgfqq4xGAkQKlShwciBX7cWPDEdzAbxAke+5RD5Of7qGWEU0BBxTxM6yWxh7zXII2bQH5wvYjsRYMBlfYDtGeYeqtd2SFMiQLAp6yE3AC0UlDuAGi/9yFuYLyJWDLFvCihm9T++zMK4cR46jmJKbO9IUSZQOghqa6S/zX8NCp1Oyoyau2M/47A8doxOCOSaJo2liRFan5AYRq4YCD7SmyXSdJAoIE6vBmhr0v1V9dKvpJcwiYuUwZnX509pEFAo/kNFtSW3IrB8K4RVDnHmgddOyQWpRIs+VQ7h9q08LkcvIP0wi0ZCJPu8ZuzUV+7kLimIO7LQZQt3kT
X-Exchange-RoutingPolicyChecked:
	HO31kzg/aVRX5bIDtB6FqYHh38OpdpqIWs4/sIOxX50kSq+koMeGYQa1+3V8IVtB1K+9UBiZuXo7Z0GC/bd4cQqpai/fQqkDzVtKPmGvMcWfoWAicTxKo2h86v21T7B4suEqGCRcefHaRwKGaS+8ZTWd41YWgppJR2pRWIxpYNINDlMJIwiM6xhEFRxyRzW8EjZ9iTfczNtEbW+CcxY+T/eJ6hrcIOE1T62skNhAatKgCZzF3mnSPaE/j9ScAbXZwvo3Vfn++VnDIE18o+nUAUznijBmoklJnkWpLyzf3lR5JRSUaAYjh52pZce6G0wFiZ6wcbvkUbJdyxXAnCfKoQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 19:40:36.1731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b4bc2c-711f-4e1b-5f9a-08def1971717
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3MyBTYWx0ZWRfX7120IY1QUWc+
 YHP3OPX09R5voeyFeEh9M2+f2yKPjIdAnJwSolvufSY8N9HzSCiPA8AdFnI+JcbcYqEheUbcB3o
 QGrd4QDbmtVws6/XehxeicXgUeRFYmW6i3a42Wb3b24627hLLHEkrryO+ZuTaKndOYuqgovdz52
 SFouiNtKp6KYb2XCqMgTQRAix3biLwSQiaONkee0PRTt9Gfh5NM4vNCMBN4t41BcVkPpSEHxJgO
 n9E6xe9e7hCz5fLQncDan3DI9tCjZjCIMoOZYxdrnMqS7AOuVqsXMOLi7nfod+SQ/hLdP+lloRk
 QHe1i3BS/ycdbdKt6ENzBi/6GFaYNPXrWOKpIIug0O1QZe1S18wTe4EYt21Qu8oT816wW7ed6G0
 NjzvqU+wHfB2Gx/b5gpyrf44eAu5CRw6oT6BEviZ6bCc7R2o5Os+VNjVpNF3YPhhLmv4QKa2co8
 3/Qob3T5xUDy64VwHtQ==
X-Authority-Analysis: v=2.4 cv=YaaNIQRf c=1 sm=1 tr=0 ts=6a70eebc cx=c_pps
 a=iHXbSHwDNs+yH6wS+48/mw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8 a=t7ESMcVb2SY3lHOZi18A:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: pyOW2VEarA_0gHOWW_wMAebnH9i2Z_ew
X-Proofpoint-GUID: pyOW2VEarA_0gHOWW_wMAebnH9i2Z_ew
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3MyBTYWx0ZWRfX3rgOT57hPmiW
 xwgINnmn5zmkP1CDUiFDT+0MBzdp5/nxpeJ286MedPwRmXC89lUUuLOOL/Amy2tzwm8cIeC0PRY
 sl6rFsjS9xGHoDoXsofcJHY+BwwdDJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030173

Hi Diogo,

Thanks for the fix.

On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
> When tuning fails, stale ITAPDLY values can persist and interfere with
> subsequent I/O accesses, for example in DDR50 mode in cards with no tuning
> support. Move the ITAPDLY enable setting out of the tuning loop to after
> successful tuning, and explicitly clear ITAPDLY (delay and enable) when
> tuning fails so that we are sure only working values are actually left in
> hardware.
> 
> Fixes: 901d16e46296 ("mmc: sdhci_am654: Add retry tuning")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
> Changes in v2:
>   - As suggested by Sashiko clear the values in itap_del_sel[] and itap_del_ena[]
>     so that they agree with what is written in HW and subsequent runtime_suspend()
>     and runtime_resume() can never write stale values.
>   - Remove now unused timing variable
> ---
>   drivers/mmc/host/sdhci_am654.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 0db587e702ac..8ce10422bba0 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -527,7 +527,6 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
>   {
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -	unsigned char timing = host->mmc->ios.timing;
>   	struct window fail_window[ITAPDLY_LENGTH];
>   	struct device *dev = mmc_dev(host->mmc);
>   	u8 curr_pass, itap;
> @@ -536,11 +535,8 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
>   
>   	memset(fail_window, 0, sizeof(fail_window));
>   
> -	/* Enable ITAPDLY */
> -	sdhci_am654->itap_del_ena[timing] = 0x1;
> -
>   	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
> -		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
> +		sdhci_am654_write_itapdly(sdhci_am654, itap, 0x1);
>   
>   		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
>   
> @@ -584,10 +580,16 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>   
>   	if (itapdly < 0) {
>   		dev_err(dev, "Failed to find itapdly, fail tuning\n");
> +		sdhci_am654_write_itapdly(sdhci_am654, 0, 0);
> +		sdhci_am654->itap_del_ena[timing] = 0;
> +		sdhci_am654->itap_del_sel[timing] = 0;
>   		return -1;
>   	}
>   
>   	dev_dbg(dev, "Passed tuning, final itapdly=%d\n", itapdly);
> +
> +	/* Enable ITAPDLY */
> +	sdhci_am654->itap_del_ena[timing] = 0x1;
>   	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
>   	/* Save ITAPDLY */
>   	sdhci_am654->itap_del_sel[timing] = itapdly;
> 

