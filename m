Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8554788
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001677; cv=none; b=FIlMgrtHfDXD8bgsWxb8Vl/8H6093TA6/Lv1KFXDOOOE6YssWSXwJ+rhjyp+14jH2aS1N66aHt8VHFSTwaM1UJt2WOHGZqTS/JDnK24n1r41gAveS+BrDQazmx/dW3ib5iyCCHyK0Zu3VmUC6IM8IWxxA5w4yH8puurDMXKlj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001677; c=relaxed/simple;
	bh=0xZRLtjrtR+HvX5WMpR87g3TkrchkPbA8nYPE3i7Og8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txu+RB7eI+PJ66dAJg1u1GWLt3+1+0bNyDwvPKaKhi0fIpgYqU3bC32e6URKB5ervknLqb0Mx0kq970IBqPLFV4swTJyZXLCwbNW+DpQmS++R/P9AUjFNioS1OHHBRBiYR7uuz/2sWQLuPRQxoVtUGMgK9lQr5nyK+k7vUxrlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kq92W1cG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MQso5Lg3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kq92W1cG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQso5Lg3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIQuIV2722332
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	afGPz63xhnfu36cg2pExGdt2huuSxFMXAiZn4lO4fFk=; b=kq92W1cGIWEdWLaf
	6Lr9bVT0Ad/PfCwJseAKtIg1aWldvuvXcWqUWD+3XZw3xQ/ibRLf3NVZWYZFWycW
	py/1jpBEHkvE5nik4Wv9NGPiC6DWYSrA9S0qDAXFSdC0apaeIvEnKAsDZLnEckLl
	p+FhB0s59Sx/1DKUv3Tqu+/Xhs7szAdW/GL2dPE4rw2EDPhOTM9Wt7C4hJQAdsux
	LSpBAux5EkMi26r6116C6U9lmfCGJ1npQcVO+fqfg1h7XFp46UME6+v+tM2D0X2f
	+kIEf7qDmIoOOVvAqyxxaVvQ1WYh1cFQJXs8QgDfo9ZgbvoSP3zDUIGT82qz9VYp
	7t1C3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xw8k33g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 21:21:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2caf4173b1cso72449825ad.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787001674; x=1787606474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afGPz63xhnfu36cg2pExGdt2huuSxFMXAiZn4lO4fFk=;
        b=MQso5Lg32pVmaQe0OSdqpqcjO2P4ekdux4j5+usCM4uZJwTogYcSAZcHJpq2q783YR
         0znRbddxuSBEnv/JVXtokdfgPOzNKwoRNa3saIn+wuq6/nyGx3cXZV5S8FotoFiWUC8X
         7fplK3AUigBJqqL1e8Y96VMKBnjK8dRZJwVIzBrku449n8wmbXU4wZUG6dLryDDs1Pc4
         jUthEEvGFTL6Qh9pyjsiEeJhW7p+pumEEYuFkrzhPbCowcs2dtPU1WdtejWe0d8cfsTn
         IAkbgRXL2EFdkg90taEpTxGEFH1uEheH674huIGTtCiSgpDAcyqUc2aVkGa/2Is4ukw9
         1ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001674; x=1787606474;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afGPz63xhnfu36cg2pExGdt2huuSxFMXAiZn4lO4fFk=;
        b=ANnGA8Ub+5gWSWk46wIUKOAQpfa+HzgYGV5WYpqGdkVXWac+PrV9vO+EhdNnbINAR2
         oqlbqpnG2LjrEzNCJRKh6hTtIldiY3hIQ3nIQkr61u6bGp3tY2RxNdTD2rsL8Rq4c6yM
         N7akrQDOhf05yWzn9ay895tWoitR6LdvQahDgmfSMIXv5Dlc6r8HebtyEobjfBC4WqOu
         j9w7PdLSk7iJttehihMObIXM96ZaXGerHf8wFoO5jxhi62ZvHeO7lsqBGLVXtSiOMWPI
         EtElOSqxpNxZhYc6UkNGQ2o8bUs7VRgkfpg34gyOKbakOAmk9yUILFhzSbBW4l3j3YTr
         fqpw==
X-Forwarded-Encrypted: i=1; AHgh+RpldOsnYbB68RpBB6pl15YzVoFe+SqJO3UHnutrELKqihs39qyUq4iNCMjSWnsQ8ERgYpmbw/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTf6+cfXpn92c4j1rZMzgnmgUwgRAKoCji9L5FefM/gEY2/Tk
	572Hw2j4G8RiM2FIMWudo16LFXy7Wtw0gWmJc2riTCV9xwwK9ctyZbPC3nPX3i9psnFOqlwH9IY
	lJNTaM2bGSpUv5CAWrwI9FrXF9aGZX+qcT1HlpV6oOHmZtslj7p7NYFvDiG8=
X-Gm-Gg: AR+sD10cHXqf4ZIPQ/OrFPCg2PBdEKD/LnwMnS7rfHWcxdtQ3t4x5fehpAQbKtYpD3h
	6MDky2cWgDFuO06moNpssGiKrja5z4NJiAh1Y4nYJ3w+QxSpajiJZCazbi+0ui3LkBm63pNVjDv
	vXPvfXUHy5u5zb2pj+5tjHLhTRar6MXuv2lJkn3TOEdxJ6P+drqDD6SYyEKxLhWi6z0x4y20xb4
	ohXDU12lgiIh2BSonbSRhBUkbiKChSutlKIJLW5SwIQ5reep/akQZi6McaFXHh6WP05qU7tEDGU
	Ci/RvKgpKE30Ubtae87cCk7CpppPkDDK7ODrkpLYgKA5C+1wu9612nRtAxr6B2Eu7I54e8qcA4s
	HPsDOqEdH9qZmijv/o1L1erm74uKSk8YDeFQQ+u0HpAJuEsi9v4qc8w==
X-Received: by 2002:a17:903:18b:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d3b080be2dmr285934555ad.4.1787001673968;
        Mon, 17 Aug 2026 14:21:13 -0700 (PDT)
X-Received: by 2002:a17:903:18b:b0:2cf:ccc2:6088 with SMTP id d9443c01a7336-2d3b080be2dmr285933505ad.4.1787001673418;
        Mon, 17 Aug 2026 14:21:13 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10948965eec.13.2026.08.17.14.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 14:21:12 -0700 (PDT)
Message-ID: <cd46dda6-3436-4b1a-986d-e925e6fd6bb8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:21:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: check for NULL master in drm_getunique() and
 drm_getmagic()
To: moonafterrain@outlook.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Melissa Wen <mwen@igalia.com>, Dave Airlie <airlied@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260815-drm-accel-null-master-v1-1-93bdd3ba52f1@outlook.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260815-drm-accel-null-master-v1-1-93bdd3ba52f1@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pR2SeF-g4GxX6frC9jrY2x9jnHelZBjp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE2MiBTYWx0ZWRfX3VcyOShcsWl8
 TB6intBfzvUwbE8CqUoVvoDPuuDPoaaGpEE6GYYlIv+eXPYvUWIPP8pX58P5d+eNUZMsfBmavco
 2FSorfMZycz2PC3tu6qDbeNfsv+dIto=
X-Authority-Analysis: v=2.4 cv=SuCgLvO0 c=1 sm=1 tr=0 ts=6a837b4b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=UqCG9HQmAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=djIpYLbIsOyqsb7DCLUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: pR2SeF-g4GxX6frC9jrY2x9jnHelZBjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE2MiBTYWx0ZWRfX1PR4osbLEVM/
 VaC/8ayph+LONwygD2Io1OQKC2NlJq3oblmTrADuJrdmm/VqDL66wHUs7guIw50Dfrdw3e57a+k
 9RhRlUtMqsuqDCF3pnSBeaNvNhEDSP/HmdOivaJ5kjOBNKjZUAK6vXqLTh22YQhPfCXk9afsnNz
 kDEnSjEWI81zdGEHiE7wsf6/bcXjmkkVgtbAwtAbuKRV5oVCboN/W9PX/CtE1Y7ZtuwHKAYvjac
 6nYGjrN7azvHS5kJR1eJtkpY1xoAdOhAfmFQ8wXl/1Aztl5bUEBVoCaknKAI+PVBsXF3jiDJLQj
 WXaKIK2Fxmxm6qBCK/Dl8wgqfXRFtcR5PuGpSJx6Ho1kSJhKcQ4UO8TQm1HtPI5FAceoiTm5pVI
 EGTzcYK2MVrDZQdOPx3aDRdGDmJFaXCbHtxT0swO5jsEEYVL7jw7V33zI3AF3qaJ6VXbBGqJVMQ
 U2PZTKZmno7zSufZ8AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170162

On 8/15/2026 12:37 AM, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> drm_getunique() and drm_getmagic() dereference file_priv->master without
> checking it, and both ioctls are registered with flags of 0.
> drm_open_helper() only calls drm_master_open() for primary clients, so a
> drm_file opened on a non-primary minor keeps master == NULL. Render
> clients are already rejected by the DRM_RENDER_ALLOW test in
> drm_ioctl_permit(), so before commit 2c204f3d5321 ("accel: add dedicated
> minor for accelerator devices") every drm_file reaching these ioctls had
> a master.
> 
> DRM_MINOR_ACCEL is neither primary nor render: it gets no master in
> drm_open_helper() and is not covered by drm_is_render_client(). Issuing
> DRM_IOCTL_GET_UNIQUE or DRM_IOCTL_GET_MAGIC on /dev/accel/accel* leads
> to a NULL pointer dereference, in drm_getunique() with dev->master_mutex
> held. The compat entry point reaches drm_getunique() through
> drm_ioctl_kernel() with flags of 0 as well.
> 
> Return -EINVAL when master is NULL, matching drm_setmaster_ioctl().
> 
> Fixes: 2c204f3d5321 ("accel: add dedicated minor for accelerator devices")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
