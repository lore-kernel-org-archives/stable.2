Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E2437841;
	Mon,  3 Aug 2026 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785332; cv=fail; b=K+5BM0AUmjYzc843lw22DJL3YSMTk4H7bU0hYv9odzL6r/T/kPezqt+HNlT8Uq1TvJVrIJBikEguBXkDE3DlHmusXYb+KorT5MlaTeql0cbPrPmMh8giihHQZoC7CZISLI3QvVB7Oa+WdbauzR88YPWcVnkQJzD1QvFKnjrZlJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785332; c=relaxed/simple;
	bh=rQMBxkvkhWAoFOmwrTNNbMt7cvlF1fror5R4ZMSCBOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tHiwyNh2/a1CaojCW/yDK9bSVuX3pXnrISPuf7BR8dMFHIlGg4YwsLLwY1+y5jV7lK7grn5VAtVR4SFMW7x9M5mJJ+/vQifU+ot5Jee3q/YHQHc4Ox4tTmC3x2veEJx4uUQBB1JAumpJYYMTuCrEb8/jfL6Mw6IGNh/zlT+k24s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IttsFYPc; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RqiZnZCV; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IttsFYPc";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RqiZnZCV"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 673Gxw5b1366378;
	Mon, 3 Aug 2026 14:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=fII0+iNQ50ddoM671l3b8DqJvUWDqXi0Ekb1RDJeY
	as=; b=IttsFYPc8AV7gxuEl6JYekuOjoFYcfs6EHbvHojmAFlEchkfnIz1AGzL5
	UlICpwTS9cm6ZQFpn4yau57TqtfbtIDivD5d7wu3jfwIKzCm69iucjdhzJgPUJGY
	Yj4eety9YBb8/rWWPlccyMUFNuXN9QR0VlXrmLDxzQfMsdwKgZqcwXtHxKhZk9ZI
	8aWSczyn4ygWeJ9084JxuyRHGnYIBAo4zKYdY/eqxL59r1kFVPlO20Mqu+75IrA9
	X583TC3GqkUzVSDaSDUtvUYJP/DYEyQuE0kG0qw9FhYI1FflnoAKLku+DozdRm1w
	TensJLaBUuYnvddBTGOabwdC9fCvw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ftt70br1b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:28:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngux11BFgBHut87UmkfrZe84SzrChr3vO1MD8ywJFh6Ea/A+himPCKyNF+JVTrEVGjv2pS0puP9nICi+LLnsAksHY8epu+u3qs+UsULZWI+0EI5BWCsRwggVxKmSHYAGOO7D9j5ArMFM0o0bLju6Ni0OynC60+/iA0Xm5zYpBZ6Xr3iLui+m4D+g2CMmtBPF8eQVw9LYj/GwdsFFMt8QobjN5U55nWmef7aqtkT3ESuUCzbQ4gcKRHaaWWxxRkKnrpvL3MejdpKN8HkSfzXaPS+Dc4CCSNZw9w9hoPaDUY+r8myM5W+9SOjXoi7w7hPa0YkdCQMnUj6UbrM0ZoeVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fII0+iNQ50ddoM671l3b8DqJvUWDqXi0Ekb1RDJeYas=;
 b=ef7BJ4s3DQDm2fFTDtBNA8UPyh2mEHJuaI7SDSRo/NEDYVAQpkIXeuGJFbg8mQRQ4qo9OOnzVIrXf0z/vPFTrJjXAR/Dz6oTptbDIDiIXAgbSKaqFMQOS9UtYrQVbbl6E3K3CNJTudyNWC2E3IGm4NYfjLNFiHmjwkUbvB/viqYDj/neCOkhx7EaKhazIVqsaRObv1Zu1B06l0JPPcQZU6JxV/9cipdh7TGQd4TR+atMpqmNue3/Hc5Kj9FHImIyBVNBRT0BCkRDdsz0SWcQJiIxC7QvYlCkm1o/LJA5kFWzeoU8++kq9JKEhVCwfUL4bzGcxFn2Ek+RV3v/OZMJkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fII0+iNQ50ddoM671l3b8DqJvUWDqXi0Ekb1RDJeYas=;
 b=RqiZnZCVedjwYQe1b4oWrjtgSrDqCVwL9SfBNIwdeCeORVrgOpkO8Du9EEH1uZPQWZR4P3/QsZqJPww4AbxvyCAszrlC/0Q2eQ2GXYRTcEGgvz/Ov6V0SoMt8enA2n3f9UWNN4Me4zWW/8OnQFDDLDRhGYn3BG1hSpVBaOkifj4=
Received: from SA1P222CA0095.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::26)
 by DS5PR10MB997753.namprd10.prod.outlook.com (2603:10b6:8:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 19:28:22 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::6d) by SA1P222CA0095.outlook.office365.com
 (2603:10b6:806:35e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 19:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 19:28:20 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:28:19 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:28:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 14:28:19 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 673JSJFf2334609;
	Mon, 3 Aug 2026 14:28:19 -0500
Message-ID: <148b2a52-152b-438c-be48-06bdb72ae35e@ti.com>
Date: Mon, 3 Aug 2026 14:28:19 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mmc: sdhci_am654: Reset command and data lines on
 failed tuning
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
 <20260803-am654-sdhci-v2-2-a5ee5be86133@bootlin.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260803-am654-sdhci-v2-2-a5ee5be86133@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DS5PR10MB997753:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d388800-52c1-42ed-d08e-08def19560b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5SOyx6YoduftPbw+XV4Ad/6NxMDNk6NmqVg7rpgdLOHSkZhR0/Sv0poE1iEz+W6mESZquzPhrOHV1j+2FAJQw/qH32VENQ4Xe4bbDT87/L4EScCYlZ2t2yL/DujZWAhuf7kQlB+WMRyYXl9ZX2sP2Rw+gAoSx9esjLD4heqjkk0YWnk5fbDzKLGjn0T5u6HB8GcBjUe9tvDGPBpzM8Xhh/EA7FXgHuaLKN3e74OJVBzU9rBs2dv3dAyDz3QS7xnS/iTczs+uj5J9vYv7w0dpCx5r+rnct3+iyx7dzQDPEr7J43PdAhmn+Aj/al3s9lByu6Qi/sIyLCt/3pOcm2vxwDXJIeVcgSnOTj7Yt0ejVGLZAVzI5Ivrmz/+4K9QrNFLVPqhRfqdP73MbTJpe0Uyi4VGPoHqxS8uk8yh9VHc5Cu5Zsf/SnbtUqcEnIugSwiJsiFfjCuhElZ995tDjuP+oj901c4CG935P5VitM0Cc0iPjVzcqSEeoGJoB3U0xEbOl3l8ENkr5rpowm8IiPyK02rfZcc+2CvrgNtqLYp8HWb0QgR5QVQ1qz8qrYHouX6VfjGMKpXrorpHZ5ym9XCkV+rIMivAsUUJrrHprG8x2tQIQgceMq6oOJAF05+DtZ82e3ejkuZ1sTo2NHii+awa4hKTBbn5/hndxYmRkMD/nbZnM2ed7FJ/LX9c0f/ePi7QoSBKSg6yp7BJmVRauuYHmA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	frg+i7f+RaMczDVbQBmCZkx4WYXNus8wtuHTbBpWvy31vW9JkH9nN9sWMwA7tXEe16//RONG44roKDrAcwp3IcnoPB2lE8Ry4zlmfOU/WLE/Zh8b2cAlMVVo/BienDEbQW5k31XgS7v05PtmUhu+gfPTbVWRAEEoYzwp1UrxRXVzOr5yV026QT7VgFcqY4IK6rouQ1ZjQO8lZP0e4GEFOyCxgUa+6JVSxI1ETcaMRzwRShrSBK5acReaRJcous0NekvIXx5dSW8CSHG0HXCi7zwkrdhfyIdy80TLHV/F9iTFZIiWm2hcmOWhA0yt2+4KS1udA3vViEM4vWVzn+TMao3RGJuFUrfBjkIHSsPFSyDYDJjSYcvWUz92QQkACRRq6nSXHnozKdE5TrtOaWBrE2PkstNtPoPIV4BMwha+kJoIJYfi5e1Bl9x9VHvnfaAw
X-Exchange-RoutingPolicyChecked:
	mOjQxJpVEa2i4cBTsddsl8Kc8+Y5i5vdiAive85Ccddj4JkLYTtPc6d1mx65fjzlLcheaAWDzwG+k30ODCgi0xcR0lBwCmoICttSI4WeG3b1JvXUVq+7FcwTYYHx7o+garVbDOjuSex12pm32PypjBf+wcvcVvVor0IwFBlVRsX2Xv8h7vjd9latou49ffv6k1c9upskmL7VSp7tFZvd9grtDU7Wi+cqc626ERuRyYI5SYKL2f/XXODe6kopTOmUbVmhFAIuK7vqdq8wkbCsv5UveIzw6GPzhKpiPuo6Kf+iuxMnRd6pXV/lZN3hgOvHPQuF5a90oLMddmf1Y11NEA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 19:28:20.7190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d388800-52c1-42ed-d08e-08def19560b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997753
X-Proofpoint-ORIG-GUID: bfnBLzGj_DD2vVG2b2RLNZL-FxkzngSB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3MSBTYWx0ZWRfX7jJanopDLDnp
 G3oAX34gf/g4BM2IZVFHfU/3lBCJw3Xtwq65AIrxe0MHbSH6qEZmqBlyYViMn0LZFzbgo54Xxvq
 +5JaLWX/h0kWkFNq/xgLoJINEk6QuEhJ0Bted+AnQ837vJKPfiXudw4zMtHmhTFJpYTux4NAXKd
 Jx9D0winSF0CustA2QKUfh6ctQVy1zQTrXqPU+vmKoEgSo26f9Em06Jju8xRGT7cHCDUqUBUR+u
 u+ZX1PBqhdlWoz4d1wvPx1DCVkNskOhPLggkTCU3w9/RSonQBqS4p96X8WdPA2lXTWRrM0W4gVM
 qZXXK004o/FBfXAvsdI2RWsBHeO1grAGu+viuHuniOOYdRsxEIxW9HMQL1Hqr5FTvfZowHjBeb8
 OaWgVEl9ELYUvkLTf7JJlDlK/fzIvH3eDpwM2WQI10pETGrDKLQ9VuyNxAWyghd91LRwi5on6qt
 XjxSjxJVr1NmQm75myA==
X-Authority-Analysis: v=2.4 cv=MbdcfZ/f c=1 sm=1 tr=0 ts=6a70ebd8 cx=c_pps
 a=F2A7jaVQFOduNxX/8CKReg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=sozttTNsAAAA:8
 a=OJ6v2twLBQN39vWCHAQA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3MSBTYWx0ZWRfX3lybAx5kvG42
 mQPMwGV2LDFFOubQjB4tYj8yrqqTB+Oc00Ld7XItsWCM8M37BNyTlOCDjNl2v34t10r3E41N6A9
 ++NoRPiWHakBfhxGNp18HPRUaWAWKZc=
X-Proofpoint-GUID: bfnBLzGj_DD2vVG2b2RLNZL-FxkzngSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030171

Hi Diogo,

On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
> The CMD/DATA reset after tuning should be performed regardless of
> whether tuning succeeded or failed, since tuning data may remain in
> the buffer in either case. Move the error return after the reset so
> that the controller is always cleaned up.
> 
> Fixes: de31f6ab68a3 ("mmc: sdhci_am654: Reset Command and Data line after tuning")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
> Changes in v2:
>   - No changes
> ---
>   drivers/mmc/host/sdhci_am654.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 35c3efd92112..0db587e702ac 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -442,15 +442,13 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
>   	struct sdhci_host *host = mmc_priv(mmc);
>   	int err = sdhci_execute_tuning(mmc, opcode);
>   
> -	if (err)
> -		return err;
>   	/*
>   	 * Tuning data remains in the buffer after tuning.
>   	 * Do a command and data reset to get rid of it
>   	 */
>   	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>   
> -	return 0;
> +	return err;
>   }
>   
>   static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
> 

