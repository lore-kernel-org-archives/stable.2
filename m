Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400213B584
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091447; cv=none; b=AKrCeFhhd5rMENv4cBXFaR8m/oNBtPORdGrXV0vDisYPNwa+TFQDG4FHCMIWbIWJ7sgw4NGEwB0LKmVOZzxurlKP9oj7CKsOS0ddhUKeWkex3QLQglUKSwoapE8v6TQTvCQNCNsN1J8GgOsZk663yQnVneld7zBKo2LR/tIH33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091447; c=relaxed/simple;
	bh=y+xulUJw17QH78JAOFjQW4zFoEctJz+Os9f4taGkQnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCig9S6GgbetDAmjcBTJv96DPNfa5FvWI2+8Q1l/+nfP/vBmy7U2GXbKVspDdV073QnrxAWqBsqXp5XAesfNCxg7mGIAQu4BIeHFj8jyY0SlpQBxhLWiZ2P6KG+uYIP3X92Ptca3t+o6CRWbKj6G+ZSF0YPIyMiHS7u2nHWlNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hdJ1UvSS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FATjwDNK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hdJ1UvSS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FATjwDNK"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH70MO1126648
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 18:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XXZUU3ezSC5J99mvDVW8COuRxpOmKWwBThMDg2OTDCk=; b=hdJ1UvSSugPo8JVR
	TL9Ay/MC3998iF7Ngk3iAtmcS9YNxbXGmAV8CIMaE3Y/Jbt0S0ZfNJqJF9nEdj8+
	1IZjXmDommTE5nq9SIm7X2L7BEDNGMmDVIuF0YJY14Ha/YUVaJtp02J/QJMp9fl2
	OdoFUxQ2T1L3KDvDjs+Ty2JmY/a0ufZkeHLnnhJXhzW1jk7tRhq1s6tEPinQKMhB
	TcrLp9P1ec3U9SFLvEpVcpYvkAI4J33EHfqegHDW4irevLTKqPXgpgkwpJuw33wG
	8Kksk4n96wSzo6Nu5CUvpxNSuCc/eRumYc51LstfxuW3kAz7GRcbQUSQt0GRnX7v
	yLaLUg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnweucjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 18:44:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so3204737a91.0
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785091444; x=1785696244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XXZUU3ezSC5J99mvDVW8COuRxpOmKWwBThMDg2OTDCk=;
        b=FATjwDNKzxXnA3IPOnZONqi1LgtEnJ+O6MpmjtDotBm2GoU8eoEMxCeX+MNMVioXaw
         2n2LMRpKdlALqDZU1kMpS+4QLR+uhGekQin2TXeJG1d+HQTa2jZ3FG7bsVHLaOaMMsME
         fVW19wWaCOuxO7XTiIEuVzAOzQayosGc4d1ApEvnkZZ34bEmkB5o1DUeudtO9nlNghtg
         efeSsg8+1XjrurQh7LqEVdRZcjqiuoliT8dWToxE2dZsIlX9pI2uyiiy9I5WxpAyCRaH
         orPaK0ogzwL/sMHXxcst0iswkSCaZp7f8vnmVBzi5WZ1TH5Plh+8o2GFRPMMC6wvSVDp
         xkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091444; x=1785696244;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XXZUU3ezSC5J99mvDVW8COuRxpOmKWwBThMDg2OTDCk=;
        b=gTX1+2Zu9vV0fJxgU3Ouz9AeFWE2U65/yIE1PwiFbsimw7Kk5tqEZtSoE2PE6Hge6L
         tBnxGh7xAkuXkuGA3YDWMkrjXOFsVxTK3OZ5wZDPXEezAGvdLGIiiL/Fe6alNdxAq4jf
         /vc2nit3utJkytCO/UaUydzeW3bRxs/L0tmowjyFj3M41Fx3NXnLLeVBg1BR/gIbAaGe
         RKUS1dDRngIYnJBZChF8DIUX0YU3FFFYMvBoCZkZgBI8c+RG+xMo0EoavS4FLv9BqpaD
         02b7yeoJJq+BfIYmNvsFJzyopFn/DthlW6yhG6wf6l7l4sqdmTlB/0beWIJi/+YBLKRs
         sX2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqv54wOyzf5b+eSSVjACAk0SSnqE3uD0Vx4v/z1OhXwx5Zr1ZtLrAj7yuuIbjzRdOZ9HzQebr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzqei/yYW2Y7zmRInl4k7sMfMrFyhpACk/M30jsoYOsUfMvi+g
	goPA6NG/PiyMlKOt2qlLrLMqCqqU4aPKCsI8nGC568Ldd8nCuSkm86GTEAUpM/A4Z9Pa0nk5Vu4
	kLjMy+Oe5JRojIbJ+eeQuQnF8cDdD6xH5t2aS0pByYsvqObK8iAGd8CMkc8wpaEYVJwA=
X-Gm-Gg: AR+sD12MZQNwboDTTPdH6+cDq0i+Z6R/saQGHVsHGz4cyMwkfHvPQXELwQdXhIN8nhL
	J9/U/Z+1AT+xsPNuTvPl0IJsm5nbwAcG9WMr0uLv6abils52e3cjHAIwABrgn2b/IdYj0r13Je8
	/pJiWFjPVWBqfVr6eks8bHCVp9XnHta0w3rhP2nw9Fs7SejGyzqxOeUM4UGSoPR8CHgsnD41oXe
	jInuC8ef2mlTjBddeEDeNCo/IGf6IZ35qAAhxuhHlU1zt8ERcqTjLFygsZjNey/NWgy+oF18Zhn
	1Zr0dobj1WDU0r9JBnAO1fw4QVVwBYi3oJoFIrVZ+br4knTUGVaRv13wBAorpzqte/67F/XU3+k
	c5JYHMz+M14txCTiFupk9PTLNrwuf8hkr4kxt0O6wJd8jVWsrd7mg8eFB6w==
X-Received: by 2002:a17:90b:3bce:b0:38e:e0b:320d with SMTP id 98e67ed59e1d1-38f297812c8mr5478924a91.41.1785091444192;
        Sun, 26 Jul 2026 11:44:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3bce:b0:38e:e0b:320d with SMTP id 98e67ed59e1d1-38f297812c8mr5478907a91.41.1785091443755;
        Sun, 26 Jul 2026 11:44:03 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e127asm37823640eec.2.2026.07.26.11.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 11:44:03 -0700 (PDT)
Message-ID: <a08afc30-48fd-4dd2-80b1-f793a9ac0451@oss.qualcomm.com>
Date: Sun, 26 Jul 2026 11:44:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: prevent assoc info length underflow
To: Doruk Tan Ozturk <doruk@0sec.ai>, linux-wireless@vger.kernel.org
Cc: tristan@talencesecurity.com, vasanthakumar.thiagarajan@oss.qualcomm.com,
        stable@vger.kernel.org
References: <20260421135009.348084-3-tristmd@gmail.com>
 <2714a585c88febf28ef49cbc39f2c14dbcc15183.1785006304.git.peak@peaktwilight.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2714a585c88febf28ef49cbc39f2c14dbcc15183.1785006304.git.peak@peaktwilight.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDE5MCBTYWx0ZWRfX46RQnhxFC8+v
 Eo15gaKEqRUUNyRj5f8345a43eqffn8G1CJezm6EKY4jiJ+roFsZk6qz6cCNWsM1e/qDVFJ5dQO
 bTG6o7g2KrqTvu3RhNDe2Lr1jW7uiefouTK4OHqcNEADqa2FbGnvgI+kHPBa72MIyBsTmz7qrjt
 Wyu9rGe7gDMWjprvdGKpPKlMABTFIKqG7Vc5C08EpbjQp6PBkOZXRtBXvHS9M5lhXxfe4V0NMWQ
 FHZMvdyy/yA4rFEs9pKDkqzCl0KXJJ+XXKU2gUcB4Pw6VLSegtsWtZ50fiDqzOgygy30HXdVmCA
 gBZR1tIxL2nBTqFYSjXbJ1Q3hOi44g+mNvD8dZ7WsmxzaVXDLR71Qvgq+9ZI11m48p1ImnCH0Io
 kqh5xWFZzRwuXJ8dqjkiR3XFeqlxi7a6iae2mDit0feExz8iUCyjzo7vA7jniuL3gMBkolv4+UC
 HyXYyl9WKuLteBkmbxQ==
X-Proofpoint-GUID: _kFrKTlGo0EeEBmBW6fYHL-HOjN4cI5F
X-Authority-Analysis: v=2.4 cv=S77pBosP c=1 sm=1 tr=0 ts=6a665574 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=98FGZP51sEc7qZ92nCIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: _kFrKTlGo0EeEBmBW6fYHL-HOjN4cI5F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDE5MCBTYWx0ZWRfXyKGCHEhZtHiS
 it+nwW716per9HECJRNUNsi8Ql6Fth32r2Go8azc83miv+iEdh4cvN72XAi7hXjdSpgEPm7bME8
 rLnDMlB0FkzR1eGofA2MYM0K1dMI0JU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260190

On 7/25/2026 12:05 PM, Doruk Tan Ozturk wrote:
> The WMI connect event carries association request and response lengths as
> u8. ath6kl_cfg80211_connect_event() subtracts their 4- and 6-byte fixed
> headers without a lower-bound check. A shorter frame wraps the resulting
> IE length and lets cfg80211 copy beyond assoc_info.
> 
> Clamp both lengths to their respective fixed header sizes before
> subtracting, so short frames provide no IEs.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>  drivers/net/wireless/ath/ath6kl/cfg80211.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> index cc0f2c45fc..62f663c0da 100644
> --- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> @@ -754,6 +754,11 @@ void ath6kl_cfg80211_connect_event(struct ath6kl_vif *vif, u16 channel,
>  	u8 *assoc_resp_ie = assoc_info + beacon_ie_len + assoc_req_len +
>  	    assoc_resp_ie_offset;
>  
> +	if (assoc_req_len < assoc_req_ie_offset)
> +		assoc_req_len = assoc_req_ie_offset;
> +	if (assoc_resp_len < assoc_resp_ie_offset)
> +		assoc_resp_len = assoc_resp_ie_offset;
> +
>  	assoc_req_len -= assoc_req_ie_offset;
>  	assoc_resp_len -= assoc_resp_ie_offset;
>  

The actual patch looks identical to
https://lore.kernel.org/linux-wireless/20260713213251.21161-1-doruk@0sec.ai/

Why repost with different commit text? Should I drop the former one and pick
this one up?

/jeff
