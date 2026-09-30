Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C274E4322;
	Wed, 30 Sep 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776354; cv=fail; b=REefRZTb2z1J+V67n9gXhcdC/8fj60sZWLILzVxx2BUWVR9VLwq/U//qhvSz5m6F/FVjGtR8Czmi5Mn/UuECl1g9sDazITL8DkJmeW+muFLSaQqT6UF0Q5Q4lBzOGZg2vN4rEY4ZvVxyPFjSt9f0wFGGzKJXL+SU9eEIRg3UgqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776354; c=relaxed/simple;
	bh=AdodLzuPkv3ymNl7GBDfKxvuq764E4TMRtulLlF2uLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gh32rfT9bh0P9N+cP/+bYncnmWbfcyaQbRICrKsyJo7gWznyEhFGD8Ydks5vS37MeO2x4x6aK25gPtgTC27KSDBebaipI/8qZmHEtPR/iGjCZesJgZJFtdf23bExVmNqh9DlaUnYebN9ik/MgMoRVwQIVK6vE6KeatnFYMsHMss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=i6HU7vCc; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=oX5g4d4A; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="i6HU7vCc";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="oX5g4d4A"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68UB5a782989885;
	Wed, 30 Sep 2026 08:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=sJYd3h2LG7COwxltwKr2LmDFk7KGxcP0KYU1VDZlE
	Ro=; b=i6HU7vCc+lHAV/YRB3lKC8ubkRHTgZU15TCfj4SHjSL6+X6TnhzGd1Y6d
	5SGGV0mn0/5D1KhlANc/Dr31bt3Yt/pLeo5BTl4OMnDS/YcrjOMxD+ajpK9lYyhr
	e/YZIgYwz/krtwBBEFVqmcq42DtvtxoF/qUIKtHVdjldHKUSdA5zxPlbRqYy9zHk
	rqrt5I+MtpIeKCAXTD2kkcyexwVGTqAtiuKl7iRzR6P40iVBYDGRSfqt0xseDWbu
	Jke7KW9Yx75Pzn6yoaKuHJE8CfmW+5fAiZutLmsF/8ggNmfcgjXjs+3/ZgD4vodn
	LGHSCgZ6ojJOSONIUmOE1fW7s8NVQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	by m0380145.ppops.net (PPS) with ESMTPS id 4h10t1s36t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 08:52:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRGHynpWIzcf1BqneLglrj+iPEBuCCa9lPAxq7Kr94xYOSe07NnW9t/x6yuXOdALBnc8pcF2pI0mws/txKRCh4C+R+h5BGxD2sNpHO+xvbhErM7PiI/2sRRyI4plqetVWSrgCXRkl+jQnsNWj5AjsIK6Sf90sQyuq4hPouDLGP8ROQdsbR+SDbHrbKsRYOhVW19IBrJdG5xYUejBaZuTkkzcYTH6bNLJFzzfMM6T1hYT8ykvdFlndJ3Ha6d1GM/swcgxAiGTBXaxJD9J3B+fSJ0zx5EkX3zLa7W5pmEJaGovGVYrsZva5VX3yugVirmuhUaTPVugQbw7aD+SI8GGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJYd3h2LG7COwxltwKr2LmDFk7KGxcP0KYU1VDZlERo=;
 b=h2CM0iUFBUBvz2GkTvczuBrPSOHYm7dz88c5lCM3rz70IlEDw4uavwn+85ZUl9XMgAXUzDNF3CVJzgiKkGL1+FrrGdwbzft2VS8Uer2mCsi52CBrkQMFSeLJnzUHx9+6K02BffVMuSpNF7GIaaXZGTdxXD2/4uMpaNljNqB5wZ9PFBegzJJnTt2YdtBcI60O2Z69usZIqi0sb3+IqJsjUjzu9CNwsMvnH5t8fCjT04uZL9JK7/XwS2SebN3wxuo3cUYni2WHhPEPuCiV1XcfEq/eUBZdKpP4PV+s5DCjc8Ge8SJlMYzughgdEv9lBIDjNAGQYzKdvm5EDBPR12a7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJYd3h2LG7COwxltwKr2LmDFk7KGxcP0KYU1VDZlERo=;
 b=oX5g4d4AsNuXUF2ui0LR9drNZbMU4ZGdS9vOY7tATtXOD6yzMyanoOsIXHg71u0DSKdSJ3L9vWiu3Hn5vSjhS01RVv5vPEIDzhEfoUgOu8QvvaRHmLT0nN03clRWxk5mNTcGfChZ7R6INSD2wDxtEkHAM5+HIC4q5tgIf8Vs990=
Received: from MW4P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::28)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 13:52:08 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::56) by MW4P220CA0023.outlook.office365.com
 (2603:10b6:303:115::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 13:52:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 13:52:04 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 08:51:15 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 30 Sep
 2026 08:51:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 30 Sep 2026 08:51:15 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com [10.24.51.87])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68UDpC8O3230266;
	Wed, 30 Sep 2026 08:51:13 -0500
Message-ID: <fc08a754-1e0b-42ab-ac53-94bff728aef3@ti.com>
Date: Wed, 30 Sep 2026 19:21:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: imagination: e5010: release m2m device on probe
 failure
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        =?UTF-8?B?67CV66qF7ZuI?=
	<mhun512@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Brandon Brnich <b-brnich@ti.com>
References: <20260424-e5010-m2m-probe-unwind-v1-1-mhun512@gmail.com>
 <59097bca6ad101c160c1d519556fbee378801dcd.camel@ndufresne.ca>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <59097bca6ad101c160c1d519556fbee378801dcd.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc6e0b3-28e1-46d1-2180-08df1efa027c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|22082099003|18002099003|13003099007|10067099003|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	bb6XanNbBdB9/w7wQTgC2VvPSXo9ydGsygMEGyEEL7KcynoNxvomPtscRfYRe9hozxn+JNG6WIFKp+qdpWqxad3d3uK8pzwa0bghAkON3Xyi9FkfD5Uot/ZTbJXuBDkiNJAZBzhiLMp4LCoBBooG6f0OkaLfSLbgXQSsgQIIXZ/w3CWYQZEJWtWLTJONynr85IlSIn1fqvhxCvGwdruIWAapJSZhcslOPlemUp6Vgx2W3q3Tg1r/wFHr+Rv4AQfAf0i0yhmWTH0ua7oqMJH9T7zo9h+xccWhkJgrptl397p4Y69lOkb7QIMXjcIf55FNcAoJWXcvOwHyd8XmMJeDYd4kdDMNy/r/cLJG2ElGd0IZf5dHL+vI/fO7cz9aI5f9ZeJfeoiQOGafRQDKjslQqmOH0peGy9bI0yrW3LiY6RHBm6xMrCg9rtVQO+VBHxWctS3+ZuIauNrbHPR3YhKGikHiwa4yhNWBt1aEiWeO/YklHN0CSMCDQEIKYJt8reCyVO9Wxz68SIztkdCtdYu6+Tw6n1a/2BQgnu+nziYO2cbsYbSN4EMYdRfTDhDLO03KU/39rlVm8u8HsyWuSzhubXVbsii/VaUMoKRTTEXEfe6/LdAowepTTpUazlx8sgX9q/ypej5yD8cLizRn1YsqNMeTCKRlVPQSs0sy3UP2OGI=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(13003099007)(10067099003)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vOHtqmkGYel2PNi1HKTBIaFRW0Cy+FjiEE8s9xAhTsv16rKSsr+pBXhT5FVgIf9AJdil/mr46FekvbohAugJLh0/wu0jG5mtfjVp/H/FyKGHlVcWjFjieQNwcWVbkjGKnVVWsaaQWs583CQ/mmeVsM5DDMmlQpZ9u6Qzsaynj0DpufUBkHNQByY1K8eVdkYip0DUejRBnpVfVACfbEbkh1wWo+1s7pXFqXS0W+SIdHrvO++o4v3wh3LS97I7LBRsQs93HGU5CWUudb7CctKxVWb3nUHZadBbaeseuo6fhtFIHztd3P0xp3Sjw5oz8W9spSIiTSAJ4J+AL3mPQrK/pnXHr3xsoTVG31jAoFmspbYrufXPFCE53LdODD43Ahbjy3UxW/m16zuBs1xg/QwTmLElAIYBL/ooGGNyhyn/udm0hiShk6fZVecc64YJEUeb
X-Exchange-RoutingPolicyChecked:
	wVi/9i88hSl80BvO+YzUTzPvr5tpUOxLHLVUesyc8jiRkLnHjZ8ylCBEUWYLedekQb1VWncdvGdjbRTtnIAhROtwNKnI+10AJJ3xFmPeAW8z/sfL9w6U6rE5gv8+Q9thojHimDBZcXRm0JLuFZ8q1XPqz2pYpq3Q6UMVKWZJmEYAqqSVx24lFcZOV/ZE1AQWI632JGjoXE93Y4gEUUrP8sAoT9FMXnGMVNTZ4OzTNMH6iTUSh1g6JqVstzkgO+LnFU/JYdxYbInAHcPpKwpCjY61qOTSD+45LtnngmE0CWESNRJfr5qTKBXqMSBuCbyVG4wQNS3vF5CJLVg4JbBdqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:52:04.0999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc6e0b3-28e1-46d1-2180-08df1efa027c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NSBTYWx0ZWRfX/GNl2iGhq73Y
 t3NX26SY5f5qbOVygKUH2GqbGTk/CtQ0e0m+ErlKjQPLYqbRoa8PDAT1FG1Phs1pyPehdj74x0J
 MQHlWPE3ElRjEMXTuAp7DdPyiG15jrQ=
X-Proofpoint-ORIG-GUID: 2a73D3tGZWEjanoqEShtyYVFFyLU-VPw
X-Authority-Analysis: v=2.4 cv=C7R8WgP+ c=1 sm=1 tr=0 ts=6abd140c cx=c_pps
 a=5+b0Cb5m1vs/r/JsbObUdA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8
 a=Na_iDZEeDH6X7TjMGrQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 2a73D3tGZWEjanoqEShtyYVFFyLU-VPw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NSBTYWx0ZWRfX+HhEJPbG5LVE
 0yKgnEZiM3BSiihWsRgSJl+du7XgPPh50tMTjK+RuFnQQqVI1ViwjHc+1WmS8fhu6hXExgJRqw7
 zzhyc3i3QP0QskBn0O1ZPRW6Hs0DLmU2vv8a/ygVSFa+YMH3SRXrpP5ypiP7k4h3jzqSAawPOwf
 WGhQFOtcVqfTDivr1HKSTd67rrPQ7DlTsCnVi/PemyQ+tBufqF6IMENdAsPgGQ4RsiIMYXZOXJq
 wTOWoCqM38kjxCsYibcTC6KY2N0a3DX1O+2K2wwDelRJ+ft2KBm5UsT+wVQ1I7uKCuNiXYe3Q1Z
 I8vq6sHYZnhClroLaO2i1XkaGmmuSIT0tBMA5vrF9uKHJNWhVIuGFoT+b8s5R5K28fHQOIcJdxE
 8kWPcCPeG0Bxy16fMUuP/jbrFCEJG47ws/UN3xehoMmU7bUPyB+bDTgJVhMPm/HNbU6vXEndTGA
 Gf6wya4lx1OFVixlCkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300055

Hi Myeonghun, Nicolas,

On 29/09/26 00:58, Nicolas Dufresne wrote:
> Hi,
> 
> sorry for the long delay, finally getting to this one, comment below...
> 

Apologies from my side too. I too completely missed it.

> Le samedi 25 avril 2026 à 01:58 +0900, 박명훈 a écrit :
>> From: Myeonghun Pak <mhun512@gmail.com>
>>
>> The probe path allocates the mem2mem device with v4l2_m2m_init(),
>> but several later failures jump directly to the v4l2_device_unregister()
>> unwind path. Since the driver core does not call .remove() after a failed
>> probe, those paths leak the m2m device.
>>
>> Route post-v4l2_m2m_init() failures through
Brandonm
Could you drop the existing m2m release step
>> before unregistering the v4l2 device.
>>
>> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>> ---
>>   drivers/media/platform/imagination/e5010-jpeg-enc.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
>> index 42ad9ee399..4c250e2275 100644
>> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
>> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
>> @@ -1072,14 +1072,14 @@ static int e5010_probe(struct platform_device *pdev)
>>   	if (IS_ERR(e5010->core_base)) {
>>   		ret = PTR_ERR(e5010->core_base);
>>   		dev_err_probe(dev, ret, "Missing 'core' resources area\n");
>> -		goto fail_after_v4l2_register;
>> +		goto fail_after_m2m_init;

I'd prefer naming convention as goto fail_after_v4l2_m2m_init to be 
consistent w.r.t naming for other labels (goto fail_after_v4l2_register)
>>   	}
>>   
>>   	e5010->mmu_base = devm_platform_ioremap_resource_byname(pdev, "mmu");
>>   	if (IS_ERR(e5010->mmu_base)) {
>>   		ret = PTR_ERR(e5010->mmu_base);
>>   		dev_err_probe(dev, ret, "Missing 'mmu' resources area\n");
>> -		goto fail_after_v4l2_register;
>> +		goto fail_after_m2m_init;

goto fail_after_v4l2_m2m_init;

>>   	}
>>   
>>   	e5010->last_context_run = NULL;
>> @@ -1089,14 +1089,14 @@ static int e5010_probe(struct platform_device *pdev)
>>   			       E5010_MODULE_NAME, e5010);                            >>   	if (ret) {
>>   		dev_err_probe(dev, ret, "failed to register IRQ %d\n", irq);
>> -		goto fail_after_v4l2_register;
>> +		goto fail_after_m2m_init;
>>   	}
>>   
>>   	e5010->clk = devm_clk_get(dev, NULL);
>>   	if (IS_ERR(e5010->clk)) {
>>   		ret = PTR_ERR(e5010->clk);
>>   		dev_err_probe(dev, ret, "failed to get clock\n");
>> -		goto fail_after_v4l2_register;
>> +		goto fail_after_m2m_init;

goto fail_after_v4l2_m2m_init;

>>   	}
>>   
>>   	pm_runtime_enable(dev);
>> @@ -1113,6 +1113,7 @@ static int e5010_probe(struct platform_device *pdev)
>>   	return 0;
>>   
>>   fail_after_video_register_device:

I don't think we need above label anymore.

>> +fail_after_m2m_init:

fail_after_v4l2_m2m_init;
> 
> Can't you simply use fail_after_video_register_device label ?
> 

Actually it was a bit of mislabeling from my end when I authored this 
originally as below :

         ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0); 

          if (ret) { 

                 dev_err_probe(dev, ret, "failed to register video 
device\n");
                 goto fail_after_video_register_device; -> This should 
be fail_after_v4l2_m2_init too
         }

I think same thing I commented here too [0] which seems to address 
similar problem.

Basically you don't need fail_after_video_register_device label here, as 
there is nothing much after it which needs and intead user here goto 
fail_after_v4l2_m2m_init

[0]:https://lore.kernel.org/all/39a03dcb-bebd-4794-a2bf-ff1b56cb632b@ti.com/#t

Regards
Devarsh


> Nicolas
> 
>>   	v4l2_m2m_release(e5010->m2m_dev);
>>   fail_after_v4l2_register:
>>   	v4l2_device_unregister(&e5010->v4l2_dev);

