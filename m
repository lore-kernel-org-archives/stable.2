Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A186B459AF2
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146389; cv=none; b=hEeXeijkW6Sf6/YHSuPyRfIcttEIb56ZxUs5yunbuohB15fOCbO2lys9os+CbUsaLv53M50ve5r/KS5KZS4Bmh/TLwjVVZ3Q7nBZboiAYdKyBuJdDf04j7nCOifRoiw5WbZE6RvXRHRbVdXh8Xq+CeSFFX50YkGlx/nTWCkD5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146389; c=relaxed/simple;
	bh=jdfOT46mMGVnTtjhHdZMClmhgx/5Uauj11P8htZhivE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8XWAn6J6a3u4mxlbo11CBfaZf6DsyoRyOHoN+Lfkvul4s12zHc968SyhAD1XcG1xkjqkWEKx1e/qjCT5qAAn+d478Ubm+4x0+yGamBVHsN0VwOx8/UP48O9uxJ+uZl8GAQcMwKZnG6dtDi+uBbJnzlb9D8h7yOwbvs3wS22c5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QYTMrLgn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CeHo1rj7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QYTMrLgn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CeHo1rj7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BElxJ7269248
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jdfOT46mMGVnTtjhHdZMClmhgx/5Uauj11P8htZhivE=; b=QYTMrLgnJnLKE5is
	90WEf9uLcWVU08WxMgSpv12yf220SbNrnaxMqDSnA9pTp7lYmvWONr/D1dPOsknI
	KG/N5luh6LpoC//eBJOHAxJcZZPUg95qaFIFIQwQrRAuQgWpkYmg+O2hSdMxBti9
	a1UBAOVhMz7PeEGvVNKB5MAVwbVxvjUZhPG4WRQBntR2ebzv/qqVPxBc+rClG8Ux
	Bq3+0vZvSVenPWyRf4el19VVd42a5Do81HOeW0j5VjjYyR257Rvms6nweDsicZwS
	GOMHtsqQiNnqZmqmdkBWynYCIUzfyb15PKONtnBQrQrDEEQF9r5Z19WsnRbhxl3K
	nLzfEw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd52wjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:06:24 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b37620eb73so1565749b6e.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789146384; x=1789751184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jdfOT46mMGVnTtjhHdZMClmhgx/5Uauj11P8htZhivE=;
        b=CeHo1rj7iU4MobTBMuyfmdo/z2zkpo3kODA9WnXbARaviPtJXUKFkb2G3SFnXJSMHc
         UhXdED1HMAGmxHsg/nr2O1rkqPZUMJSWJU6W4rgRirsENkEpOI2kSI5n70lEx0ypfJb5
         JYXJd+s7WLLm+oGrKRi8XHxgb7h+MA8d9V/sCkpkz3yIPj/CA54Xe5OJbQ66bUgwXqnF
         jSrp6Rxs0tMsvaXYH8rkjxTvedNpa1I0DANryS3GfscZdCkwFpViSTMh7z4DrO7rFLJM
         +HeUaeHeflwUnPQrujp8maGnY1fisBfK62bsf9qWlOYfY1nWNAFx76/EECsZSZi3aUvp
         v/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789146384; x=1789751184;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdfOT46mMGVnTtjhHdZMClmhgx/5Uauj11P8htZhivE=;
        b=V4sjGoosJOfHXehzxw0aCWb4B4UskF0pmuWEZLKRTuiljjTUtuKjqCP+ZMRjJBsrsw
         wzrXFtZStxQjDOqILkplFy40gbVKSHWroMoXoUaMcvVqtIl59+G/Bj60vSPsmH/GAYym
         9khYJzXf5DXHOthwz2XER2sGzamXQB44usj7LXB7uWvdIbipACn9cItO/6zKEggxWVHj
         gbrQ37SrXaBE885DO2RTX2xf0Xz+680dTene/XeiJvqR8HUZU187VFDs0Ehk88CfCirr
         GeDvxMw0nZZgNCj6qRQ2Xm+mcsaUT3clffARc8jfgG5oAJcx25hnMvtysDE/cfuakyrR
         SlYA==
X-Forwarded-Encrypted: i=1; AKwUvByLTXHeuc3YlkupQWh/L/M+SaYbf5aE4fnXX7yIz8vVPD7m7iLr+5vs8EYEwEm7HpigfH0Yas4=@vger.kernel.org
X-Gm-Message-State: AFuF++m9UID49Xwd1ikM8VwhX4hEK6E6j5qFFdcnAXZB91i3AiiIsgv/
	heEKxvze+HZrZ4VfZta+8aAgHSwDscRpCEfuGTHR1VDRoRbGgpFUwWWqP3ZxGKCJKlxryMvMwb9
	xXROrFb7AkWz7l3xEaFd7w6VXHw7vVGXQrmGRnYGS6fe++yyGz/iGPELzW0M=
X-Gm-Gg: AYBFou1ejlHx3pscI+pt6JVGbf1JTx1cpUcbN2iDCFZ5P4dCxnBJxK9yHJ4oWqof76K
	kL6WJV5nTWYYtDh6jiIX8X2EbamzX6PO9LyeB+XyPdCzjyZrbJks7tKW/Xzp1I4nDNpgekPPWEo
	TJybFWf+Oz1JiBBf0dUe93bFM/ISQgWuZwUzKhBGqux58Ot4EMYns8XYE7dmqyFFhZhcp/yHQjF
	9gRk0vOclRsMVGCJa69Vk7NTDQmCBq5A0Eugr1IqloHlJCVWwsOvJjNnSEQbk0AZ+aJjClg7sC+
	beWn/2W3BKFjEVimH/CWUiJc/B7ZzNhteOdbNPDwAmDNn+HABrdpxVjpZPk78s/O/k3JUC58uHE
	fnLJaa/DQTUgt6da5FTnT+fosVr4r3gKtgHwnYoInLp0L3M5UHzloVfWRabL8
X-Received: by 2002:a05:6820:5605:b0:6b1:b33a:db69 with SMTP id 006d021491bc7-6c0bb3f863cmr4855889eaf.15.1789146383961;
        Fri, 11 Sep 2026 10:06:23 -0700 (PDT)
X-Received: by 2002:a05:6820:5605:b0:6b1:b33a:db69 with SMTP id 006d021491bc7-6c0bb3f863cmr4855837eaf.15.1789146383555;
        Fri, 11 Sep 2026 10:06:23 -0700 (PDT)
Received: from [10.227.105.111] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09a122443sm3710647eaf.9.2026.09.11.10.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 10:06:23 -0700 (PDT)
Message-ID: <5f892b6a-7c02-483f-84c3-43c1161ef251@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 10:06:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] wifi: ath9k: stop a failed register read from
 opening the RX filter
To: =?UTF-8?Q?Nerijus_Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>,
        toke@toke.dk
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260911014653.1566388-1-nerijus.bendziunas@gmail.com>
 <20260911014653.1566388-2-nerijus.bendziunas@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260911014653.1566388-2-nerijus.bendziunas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Iefemjcpcsb_vjxaAQ6MeUkMZJKzTdhi
X-Proofpoint-ORIG-GUID: Iefemjcpcsb_vjxaAQ6MeUkMZJKzTdhi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIzOSBTYWx0ZWRfX3I1FAOIh1XD6
 mbKwI9t3IFqiOIP6Pc2FpMKi0b3+nfCsfKZFRE4TSNonojYwf2LxekXnZ/hTygY/NJ0Ss9A054F
 QbyVsGPOKtEPwpHb92J7gJ3oWW32irg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIzOSBTYWx0ZWRfX5dlev2O99P1s
 6dHopRMFqLe7iWbORi8LAsGCNnwsZcktfl6MSWth9WkU6pDPJwMAow7aC1WI4zAqH+YGHb755II
 Uz1oTVL5yPF6Wx1UrNALqhthzgO0rHi5gPx2ZNn/2gpK5xFhjkt1nGIIBn05nvCJ5ELfpx9ysUS
 nT2KeVmDY1QEiJW2lo7JAowSG7M+vFlWN4MVBZf7kqZ+xNQKGMSL9jQBE9/GauvoBvQZO3Ywpwl
 qTFRXFDp/rvF10ecm7PMHwjwLgwFRsPe2vWSD8GNje7Uy8IJ202zopmQ8M5s2aRNFelWhTBDsEW
 g2Kotd0/DFXRR+ffQEELsO7KT8xVlFgWb4E4LTQkacWnVK9Uc87BTHckuATvkAnrrvYTW2pwFTB
 Zc22T51DLUxdOcpImUZgCr477CRNKvrYe5zvN4HL67kpcqjk1DOJXQuOVqqcidIEQfPtL2jFhUS
 cmWKCWQawVaIPfubddg==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa43510 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=oCg_hTeQ7_Ete_IDjq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110239

On 9/10/2026 6:46 PM, Nerijus Bendžiūnas wrote:
> +/*
> + * Set bits in the RX filter without reading it back: on USB a failed read
> + * returns all ones, and writing that back would open every filter bit.
> + */
> +void ath9k_hw_enable_rxfilter(struct ath_hw *ah, u32 bits)

there is a standard for kernel function documentation

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation

