Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F2360ECE;
	Thu,  2 Jul 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013905; cv=fail; b=dMEG4l/cZnEdQ22CQVWKMlDFDeTsotZ0ZzVB/xH7rBgn0quk/dKqYj9HF007DwZl7LEO20qHX0Tewpn1b3/yTKMcCw/RlZC9ilR9LGGlZdQPBbDZ49Xt8ya60V7VwdHxYrRrgH4TL5HdF2JsmarI6rM/D5WMjMWYgUxH/7f3huw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013905; c=relaxed/simple;
	bh=gKsQ52+4PRIWiGTEYxgvqAi4sxaesNaul+RTNC8eKQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ijHCXxg7tsQDx7fKNL3Ukp4uxdz5Sx6oloLDaSf9JMYxdT0nStC19iHD2qiMr5iy0WLBzKMxWzBGgMtTETQLQI+ZTRQTvRQKcAxZc5lyoUXYQqJ5qcfOghTTTCUlwBAednKV6ZaVOXCKOV0GDmoCAmsofrpcGLnU+YyFrhEQmG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h1nX/r04; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h1nX/r04"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFESYDwYzTcdyRY52cSNetBN19yjoaQUxhq9bNTTbPaw5tNPD+NrQGrpM1pVK7BWSWyhl4vumcN0Hc/F3V93GZ7MbM1nSNDLKXec82SpGXxNuKIy4ESrnMHG7efJfgrlm7g0QGwfNFWLtpted9KiF7iBBpIE02H7n4Ym0qXdY0Ito+ToUlJ6p5waxzg2GBTAxSAqUNYyYFm8QnOFCGuw+OMCQwYxQ1pREY/mD1PqsQ5kNeg7IcUDaRDNXhtECPkHf+sA/4bqyDU4R6g16c7EV6ytO+AUalDj11N45r5K3LViBDfc6dCBHO/tbgXiD0v8gkH5sAFIyFOZh3zTiOz+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6wSSTwMjt5bQQB1e1/hnWJQ9SLyeDeXDodfdXIF2Ug=;
 b=auy7V9ADUY07oZRSoizRsZrLCZXZ0nfBqs2Gi+5yGwuZdYpGpGprmMBA4Bs0YktZJlcjDIT//pvZOnezlL+SEB0AyUjZoGtws24M1QWULXdq/t/Vj9F0jClFFcAA13ql2ZyYlzZB74JkKDyN7jugV4c7iKCwjy6u7RIlq+SAvevPg31i5+I4cFSsvK4MSbSp94ZmjI0bGIvhj690ppTlfDpQVqbGmTJFC+dAvg5kWMptsF4YKMksyy3GQPaq8/iX2059XVnHs+V2FftPvKIMfWqF4w1kvEioCuonklIGlEoQ2IKxFqH1CB0hQ9mnJjYSg+xh281sqQ2HBqtz0tgEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=iscas.ac.cn smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6wSSTwMjt5bQQB1e1/hnWJQ9SLyeDeXDodfdXIF2Ug=;
 b=h1nX/r04JgSqZeK1TTY2U7w7/Aj8AYMQry6acjhAHXu9fRCoeLZx+LzQdvXwSfMHiPWv/eSv4UCu9MqE6EcdJhwojPSHrF3pZso9zZ8sHQpbvAU4Q9/gPrhVNwED0DrJuJILmrb/DXG/47lAteL2Q999StrHZ4e8YncOKYVgA3k=
Received: from MW4PR03CA0131.namprd03.prod.outlook.com (2603:10b6:303:8c::16)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:38:11 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::2a) by MW4PR03CA0131.outlook.office365.com
 (2603:10b6:303:8c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Thu, 2
 Jul 2026 17:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 17:38:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 12:38:10 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 12:38:10 -0500
Message-ID: <b54fae05-4e8f-90c1-ab4c-59a6c2e02833@amd.com>
Date: Thu, 2 Jul 2026 10:38:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix use-after-free in
 amdxdna_gem_dmabuf_mmap()
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, <mamin506@gmail.com>,
	<ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260625113239.49764-1-vulab@iscas.ac.cn>
 <cb0d1d74-2be5-8b54-4638-4c9629b15055@amd.com>
In-Reply-To: <cb0d1d74-2be5-8b54-4638-4c9629b15055@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 21135994-eaba-45b6-3db2-08ded860afbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XxgCjjDFWu0wN4SZNgEb8o7voKrGfG7q5cli0HL0Seb9Y0kruVoi89zmdVKfXwfWjDeUloMQeGt+lBOZt3+4w+o2uAQR4sqjyC12VvJ5IDE277fD+lL/lTl4hzpGV0umfifX8RRkIS6Lhje1Pn7v2kllaeUZKf2G8HoX3jjuwL0RCiPr5MOCfCWGsaOrLYuPihEyY1I9G8aHqLC74I7W2SFKFATtKmVvWcyzrl3X4CvbRrb7p1vnDHf1e7RUTYBuILdsBMXAO6iknffqtqMf4goO0FpMMDE0juAW//BisDXZQwW6tNcJmFHW152mn/4+n6SzP92sNk8kkM3H7/gOK8LrmzeuWK0WhQzuBSjuLoZtYPW/fjDK6VSrvg4pShN5GuGjR5FjtYRrFatMStjZPZow++pd9GzhQeXqn5lq0DJ2XXRjua1h6M4PcVTdzd2o75dERToK3dpRX2WZJdhMKGcaa650roZC/sCFcyxJU3Ntm2Ot64QlAZ7bOJWKJRU1TRhq9LcvAyNTc8+rLFm5F38UMURZWckOwWAy/EvJ1xPxAb5HbIYVCIuu0+kvbhX1vxLMMODq16QW1PV1WWN0uuj55R9u5YNpsq9+745jIFSxOHyz52Ot2St9hQApTnc+/AprrOydB/aMgwgv+JkTsp3trFabOfcGUWLVjb7ZI/qqu128hPxJy7PUhdFKyzio12j+WaUQ5HE1ZFOw/AZK/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ADvJwDi94yuEEc75lqmiLqHZAyn8dZRYKtERSvYUahiMxr0ZUjeGRcCjD5C1YZgEXHmH/k2Iv2qxqIzknI3GmPPjb/z8midDr0JFMDjK+4MYObFXtReRW0Xs7hSyrl198TZwU13hf/dnctg2AnI5YeKFj3IG4If18AcTCDHHZhuwAnXd9BfwN4TubY0fC78t08Ie+XpuUTC7jpUiljqMZqW2ZMyyz+NR2qKRsDO33Cnff5PFXV4kgZhnJ3hfrklyNd2NQwzIN/6rDKzYinmbDump+in+e/gIeojWYFpxEDxVfxB2ut8XeBiLZsnLpkqh/L6HquTkFlQcPaDq8u1srCss6RfnqAmsCbG5o9XLPFdGENNFwY3qH3NAMo3E4nGWfoaAzjV9FWUFAc2En1SOn10D6k0co2uIXWFnH8zkCXFp7jK3rYS0s73TseM1iles
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:38:10.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21135994-eaba-45b6-3db2-08ded860afbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974

Applied to drm-misc-fixes

On 6/26/26 09:47, Lizhi Hou wrote:
>
> On 6/25/26 04:32, Wentao Liang wrote:
>> When vm_insert_pages() fails, the error path calls 
>> vma->vm_ops->close(vma)
>> which internally calls drm_gem_vm_close() → drm_gem_object_put(),
>> releasing the GEM object reference acquired at the start of the 
>> function.
>> However, the close_vma label then falls through to put_obj, which calls
>> drm_gem_object_put() a second time on the same object.
>>
>> If the first put releases the last reference, the object is freed and 
>> the
>> second put accesses freed memory, causing a use-after-free.
>>
>> Fix by returning directly from close_vma instead of falling through to
>> put_obj, since the close handler already performs all necessary cleanup
>> including the object put.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 6e367ddb9e1b..fec9763c518c 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -469,6 +469,7 @@ static int amdxdna_gem_dmabuf_mmap(struct dma_buf 
>> *dma_buf, struct vm_area_struc
>>     close_vma:
>>       vma->vm_ops->close(vma);
>> +    return ret;
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>   put_obj:
>>       drm_gem_object_put(gobj);
>>       return ret;
