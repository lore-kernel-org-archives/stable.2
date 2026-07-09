Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C123379EF2;
	Thu,  9 Jul 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592992; cv=fail; b=QrMx+so10V3GM7CoV0HmnG8clSY1FBMEvjV99mdnC104ilZOsSzo1KoB7tx+oZjHnTDMi1HtwyCFThXaGmmCZGh0r7GVbTiE4rHtN0c50rhRO3jlPs6a/E+JO43GBKzeR/517yvuO+V70pwve3iyBizDbqJT0jmkew24O7ZLlB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592992; c=relaxed/simple;
	bh=TFmJe76MLdqlYvcHiPDtsECB+D+XKqb3XLabUPVKzFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JvJZUUkQYXPsVPNVEhyr4Bhbqr6wAlDE5x9J9MRRLrgHZY8pJG7GMQ0KjRjxsfhITdObA8x/uEuX5DAqMmCJdqwVuO7oAeK3X9amRtK0FS5vohKf/mX832qzFELJMF91liPFeWqi+ircaXhKGqweiZKMx66tvdxOPSWFbysPzqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=mD7bsHa2; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pgjZXwst; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="mD7bsHa2";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pgjZXwst"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 669ALGC03965701;
	Thu, 9 Jul 2026 05:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=mrALA0qlaSpVFBRRKjvtyoVyIuv3XMrmafJJVKX8G
	S0=; b=mD7bsHa28qUU5cF0vMJY0N1ZQ1vxnTEpJuaZ2ZGnKxqGLjrJUwteCr5lg
	PPH2SdBxqaAKj4h35CoYfraAY0Z/nN7W1TeuRtqcTfEFdG0k6FSM9SISooUXYQQj
	693z+wD0cn1zu/Oj7E/OXTmkkTj+Ptda+fpFIlUkGq+Hf/wvl4PeSxSXChSjY8QW
	3or7zp7HcApfYWja3rkS8Cj9HQl+zcAjBSjBpYTj3xOja2x7tE0NmDDMtNfsToX9
	0HC8fre9vPEj1aHstGcYuCuZKkUVbRe7F3g9+DK1MNWGhpfWToM+oZliMr9cmzco
	/RmGmxQFScirsLiar2drT+bayVlIw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by m0384305.ppops.net (PPS) with ESMTPS id 4f9nft7ypb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:29:15 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1LrI6u5YQ+jY9Wtyluzdqh76G3IqB14E4m5qUlRcj3pYO1faXlRiGaJcMCSFffr2t3Y7yn6/ULXQgWi8xp3uLjr6PucV5se8bFkmho0aBPqF+nYfHuno651c0GQs6RrKgzoqlTJhVe/f4oIY6j9TBQwRTIyS/Tx8EwtkL/ja5Ls2UwuW2+1X1Ik7ZqPaNoB6M4iFsWfsMAf0PuY36QEjph4EE3TMp2gsCIqriDJDUnFGHstIj/Wang+4LBlNLikm97hNjKSm/+ScXtiuflIkpaK2RWT05s+tsARjk1Erp3p8qwx4+t8Qvsu0dapgEnSVRwTBebN/Qfs9DkAdtakMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrALA0qlaSpVFBRRKjvtyoVyIuv3XMrmafJJVKX8GS0=;
 b=dMk445d8O1rYTUj4TIRdfIvmn6XoTCKUmHjtsxeqMJKMpRVjR+BkH34WypBiUaZMgbkt0ScsJYbyHMZiaH1eqke/vmSMOEghUD/NpRPaEhZuauKnkw88uh1dmcZL6/qaOhVFcqtUbWav3rqIxVOCDPrONvwzC/BIPS7LSE7lQinuAQrfVzQXiMCQbqr4f4oTEmazrphT0MnWbkahoSuScVpkuNg8ti5viOBrpgcsRUDcRglsXFPzj/tjMfjjlI0pDNgMFirj5KhKOpH95UTRoMmzMjGt0uL9v6k6WtJDjsSaVN6qq5wVx0nnBq/c40MPVVG2pE/nZFq4myB6kd8Ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrALA0qlaSpVFBRRKjvtyoVyIuv3XMrmafJJVKX8GS0=;
 b=pgjZXwstoUdDZMp2Fs6XB4Gqa6o/vjEgP/n/lofcb5yDGm6VANdRna/wIlMsN0b3vDavzbHX4vsDPNFiizJSgRPAW6S5RE/ACkwD/QkCSFwUlDM+NpFPyCJYLQ7HkEWTDSx+wN+J07ImmSRynjACUyCpycouVIoqRrYI14cugFI=
Received: from CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18)
 by PH7PR10MB7838.namprd10.prod.outlook.com (2603:10b6:510:30a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 10:29:12 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::e) by CH2PR10CA0008.outlook.office365.com
 (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 10:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 10:29:10 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 05:28:58 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 05:28:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 9 Jul 2026 05:28:58 -0500
Received: from [10.24.52.205] (a0512632.dhcp.ti.com [10.24.52.205])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 669ASqmd1018716;
	Thu, 9 Jul 2026 05:28:53 -0500
Message-ID: <30c5e272-142e-4e4a-aafc-4a47e37dafc3@ti.com>
Date: Thu, 9 Jul 2026 15:58:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags via
 atomic_check
To: Leonardo Costa <leoreis.costa@gmail.com>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>, <francesco@dolcini.it>,
        <leonardo.costa@toradex.com>, <stable@vger.kernel.org>
References: <20260706132440.1594239-1-leoreis.costa@gmail.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <20260706132440.1594239-1-leoreis.costa@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|PH7PR10MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: e209b99e-fef2-4096-d36c-08dedda4ea66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|921020|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	71C2TKs8XZKsxEk+W4YHfIub+imvVeqXynGL+RArCZ+UJYIp6VIwFeCzA5X12B5/TGpHtE9rTDZh3ezZGBl60LBfNqfdDNf9StwGE8m7CE3TKW5yYsfSJ6jdGPulsQ6C1NkS1R4CcCZRyAFXcyWWTHRU678zFHXpqtZwCIezDNITts2+HmAOdg2w/x/ggS9z5Ix9hiLoh2tGaaAhAZ2Ac0WLP7mXBvMhFvFQid0jqx7AObfnsxsA3FLMj2qoCDaTma5Yr41TvmBJUqbs8P2j+ti2rgHaH0yBXmF0bMMEDouqSQo+FaU0CFoVMBmdJFQAnT31dJsjLrhOhpqwr9VqbOFHkBf3FMFqnAq3CznWfR3+dV0mYYMCnZIVoikfZlFyYeU0MwqZzXUPqlIu5tvVk5llUbcmcnG+gpycnmX40HKJiKWSLUnfux8uxpkjDssoMTsIV8pDlV62UAfuDZAq92woZwCIjK0MzNzFu4b6qq7nj9RUz4x3SVr6r0mk5AodqNYh8/GV7fM/QUi1BV1yS3fHyO3v6ql7+08FeNy699EZr58pJoIIbAFiQSwPRWVL/Po4gEQqp08DTvwlf0eRjjjeyb3cs5ZCN6yK2AjboinEjx6xBCyiAdse8S80DuXXeATTLd8rr6qgJpOBR/VAeIILsqVTyJeVWiewPjmKdgvQ+RJKKHfr0dmwbydKhPFWYOlZfO9CZUKgL3VtV8fNYhNE56pQD77ZowQZVMimCdaBF0iHLFJrXOB/0ehQUk68
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(921020)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+A/rgXRC/E48Ozjw/UhW6Nhhig0Rr9LSlyqAYWzMaQv49Ufg/fHmm0XnBwhWap8yNWE9swqIHBTZbDvyGeXm6gbZ/pvsLbQ0ZDEkFzOZT2jR0k9jOQBL9FTLm1FGDwxEj4sWOw13XC3gBLDNFVXbethqlu+9niD96x3B6RNhDRmIm9izm2DHQAgNAQr72jr57SZaGkJih0YZTSnO8/N4Z5Fpeoe/4TAOIgVLNVYz9r+DHDDXNMd//AJnGC1Cp3HePP7XmeQLlCgqci/VQdK4rgpbVdmBxAk/bnOCn9QcNZ1CNGcDYLGZMYzVZFUg2yub1JYcYq+KpO8yuL69LbWCKL6ZMPm4M39OW7tAjXceuN4A/ni6/MKeadjr6J4G0RhcsMkt4MkiqkAYaKl8rczaKXFoEqnbFbjl5pqqAmz8pdYkUxQFCoq4SEk5RHPJMx2B
X-Exchange-RoutingPolicyChecked:
	knCb1ke4Bv3dA/b5uqjSDGCyyhSM02bm5hxmcprym8R56lU2+XKzGd1WbuYjx+6VEeoCIq8Bs/9YXaEW+pNKB6femDKaV3EgKE37QFkCSs4mtNq3mICn23FhUZWQwNcocdRU6RGOuwfWxhBS8KkrV0sY+LEWfnTZ9LgmzAh75Lg302/DNTLnJ9jILZAzE/pGdaPtNMeYO236kYmF0RHkTtuUIOg9JNNfMvQHR6C+qb+KuHFlJIZUtvHjyM6MJBqXVA4MVyz5Ro9IS9qpj8YGoR3rRyMn3mQpfXsEJa8uGHxpy3J+g/NcWFhMov70b2d7Y4ahkW8znkE+X8DZUvclMQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:29:10.9231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e209b99e-fef2-4096-d36c-08dedda4ea66
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7838
X-Authority-Analysis: v=2.4 cv=AaOB2XXG c=1 sm=1 tr=0 ts=6a4f77fb cx=c_pps
 a=zrdfMquBAX+f6GZXohoIpQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=m8ToADvmAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=_MTHnaqviV9odgy0GJsA:9 a=QEXdDO2ut3YA:10 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-GUID: AcFrRoG4CWCpGSTlLLJihsudaHv3Qq6N
X-Proofpoint-ORIG-GUID: AcFrRoG4CWCpGSTlLLJihsudaHv3Qq6N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX+Ea21I0Xd4Xu
 8hrRTLF0AwDIMSeZFzKojLTh/BJQgNfdiRw4l/TJBSIzdO5MKyH+JGwHXrkZbx0vU7Xqesa30L6
 0QYSTFmcEZdj787bWs+637+4H0OKDnk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX8sfy6pjVG0Ak
 jXoMYSGRgOzyKVHBq9ypqNd7jyHINvWiGMdAqNAPKtlG8Ww+5AtvmwjJ6RV0IH94MFjcCCN71VP
 ra+QhjcKST5CsocRLmembvvB8PPiNJwIKj2tPnfNbs9AkuT4obmi6lb7iw4zMPQNFolVfFlstGC
 5LzFeEiwmyS6t9g40M/ZRVimr1x3RO1P5lbkcoF9EXSHTEdXE8eP5ZEHiM2y6fWEfdXahR8xaoK
 OD2O4TyuLx/aEcJcCA7JHa2XdX0mEHS6GIJXmFbfV6nYdyk/PHG447W9Qz+5FVtr4SYYV9PRaPB
 35Y1Vg+DpQjXHmSuwpE0G2Pm/JnPCoLEVuf9eSgKAh69QgdWaPrhHTuXu2eFQjmIgjSQd6UJOCR
 wZrmrmRb/x8767q/4AZL+CUgM+oW4jstfHQkBnNaF5zUFgP3oRWf+YqRC2Wl5ZdV/9LsdrE1bGz
 JhhQ5czoIWkSfGEKBVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090099



On 7/6/26 18:54, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---

Reviewed-by: Swamil Jain <s-jain1@ti.com>

[...]
