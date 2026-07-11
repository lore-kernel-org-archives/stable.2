Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64227816C
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780767; cv=none; b=E328LeNU6Ku7uptSv32rS0CbM2LeVDZasYEXcC3vJACFz3qQ5YrAg9/7JC1QKfWuGxopTW3jDjecJdQ/5ylm7/gBGkKn0GFiYY/xZ7UjK5NlDfHrZiYjnbs8APyz2m27ekPr/rnaai/dzINKaXZ051t10IZdakZbvgz0BrAa8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780767; c=relaxed/simple;
	bh=bHJSREHLOyeJy4p6jBRHOGdQGuFnsieQsfyomvA9tug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBpZxxIfoD+wUhSlyjEutPkTRTJB/JSUhePake/9iVx1lwoS8M6F3/a60yE6Ut+PIPwoRWeXblwxla+ksswSYDiSvU94v+qLs24flplTTJmUBNLUxUVqPd5UdQFy4fGq74mj3ryRoPtIgekY9CLHQ36d9UHXdTqnDv7PXWJwH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZm3DDMD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZXVE6Dke; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZm3DDMD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZXVE6Dke"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BEOAqg4163126
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 14:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JFcBrz+ATTEO32h1LBnAmASwgy9v0i/Zqwdy0coRdUs=; b=kZm3DDMDw6zlPf8G
	+52iH2A4kfZ+Y20FnRemYz572E319RGziefo+z9NRV2jvM/1Y7t49jOOuUM30GXn
	g/4lL/p/wLMgP3/PJRxCxIjq+rsCNNcyHTzjsnrSuoi7pAZIz5tbbHY8+s1H7yg9
	1E1aQgKcMy0TtL/va+D/DTEHro8vXnm+3l63vQ8SizjjNXJFV3jE8o4EkcTVV1xJ
	oRvxEYwx/n8mh2lSBhsEEdm1ZByHCj+UlW8fpADqE9S3znKr5Ps8bQcCGDA+941y
	8LdnEJHH0EDfAtQl4ju+Nkwt/U4irjVBi0roGJync+yehisIkGNrftdJbWzOjPuv
	kZgp6Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeaf8yrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 14:39:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c890bac374eso3736188a12.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783780762; x=1784385562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JFcBrz+ATTEO32h1LBnAmASwgy9v0i/Zqwdy0coRdUs=;
        b=ZXVE6DkeX6ARqvfuPqiP0M5tT78+SkSCvzNWOLnMO4810cKdowqZz4FQ37x3+3lWzd
         uWetNk2tzi+x7FPe0uwHR2vGVh37KLf33o2TXYamsuS891ftDynHTQm4AflIt+FJi28q
         VjTXp3LqcN3BHqe3Mxuh6/SvSzvSEUK4IFOrGcmTiKIVgjYEyYHXUBOeDYndPe8YrB3T
         lS+oFPOMjfFLz2oj04DvtWZi+KJe0KmnhRuDNrB6WNmwNbp1DTHaUHWfijnHRBey9nnB
         N/cLWvLaJxjoGBXGC5JsyhZVoQmlyGQcwTpIor9xhdoKh3jtcYGNAEzwayfrHVF5GRe3
         Zt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783780762; x=1784385562;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JFcBrz+ATTEO32h1LBnAmASwgy9v0i/Zqwdy0coRdUs=;
        b=C3JAJXt+idfJuxa9/WfhZfi412LquiglELkoNBV4HYGrkKgIuWzYQ1f4yG4xKQ5FSy
         p8V9JmY4neIzAQ7B+S7J+9tyVyxkAeZvK0ln7EiV9AMgKEpiPfYDIiyTltvHwYoj3DBT
         2JOxnJT6TsOk7yLrjbVc6KD3+JWPuMhz4itbZQ+2Yd+ZVPodyGNuEhTF7lSEZgxfr5xt
         Zqz/tbp7RvvKnyW0wIMwI8mIA9XOnCiT1nFWc6uIr2XPB7FSP+UivLRst19qcg0dyabd
         f6w/AfHOFIKwCyfKD5yJYEQIXUCBDXMwKwPYJlWYNQPk+Wv2zT2p/6/yIFk6eNypAjeO
         6vaw==
X-Forwarded-Encrypted: i=1; AHgh+RqRmtwTYA3DGqCkezrZFrv6ookXvCtehRj5TifwW/2BRVwDJup5TdJsnU+lRP46NaXTM9SIT/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8A41t/bra/A+MujDqsqDsZln6k1hhFG+YTSW7z9OKymswggg
	ue4uAkDRnA0ptM4oDo4kTTxgmNkYyhcfN/ZCZMpzGS2HyFsgGGi0/bdk4VtOzhjH2xFDzh/8Idu
	jL0TR3PRPnZhLpy7aE/OWd2l708fTqbd7gJTNMmo6KupByxMdxXug++ZJhAk=
X-Gm-Gg: AfdE7cmHNrgo+0bmsVaK4wsGK7++aSLCBxk+5CgPAdiecTjNHYMEA3orQiC93jmZziz
	ajaIzuIy8yXoFdtz2hFpqncTH37L8JxhAPE6mJ9XE7j5MfDYoBKQRq/4me5dVr2rvbMdZ7KceSQ
	Rf2uXP70ggC0/0ZFcoVcwG9v/Us6F0+ktDKFrs64lMsKLxhcb3kRCDLeN6b1g+IVBzKeQP5kN2t
	2U0VgrBGejRtkP7ubHuUahqyoqEUoo+Qbd9stBxbU8yffa6+zbUJykLfKwcbj6pxtg14vk94WrL
	cRbNNbMrR1p8E5WSGIWw/XDUeipYZQb7VvlKm+wxErXOcTPZBnb68OoIVZ78S0COihEpBSeA2xQ
	Ez61v2aaxGBF2em2IKsKGHzbjuOz6+22W6XbLxZhdf4YkAwg2+x+RFg7aixSEcCICUei3
X-Received: by 2002:a05:6a21:d83:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c110a1b5b6mr3074871637.57.1783780761695;
        Sat, 11 Jul 2026 07:39:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:d83:b0:3bf:6c08:fb97 with SMTP id adf61e73a8af0-3c110a1b5b6mr3074849637.57.1783780761218;
        Sat, 11 Jul 2026 07:39:21 -0700 (PDT)
Received: from [192.168.1.11] (15.sub-75-218-246.myvzw.com. [75.218.246.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8a5992c9sm11166393c88.4.2026.07.11.07.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 07:39:20 -0700 (PDT)
Message-ID: <779ee099-5132-4752-bdb8-354dfdc53926@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 07:39:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: validate assoc info lengths in the WMI
 connect event
To: Doruk Tan Ozturk <doruk@0sec.ai>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711071336.58324-1-doruk@0sec.ai>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711071336.58324-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FtBSrl5q7eWo4P1gy7P9PEukpKLpC5zl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE0NiBTYWx0ZWRfX2FjXgqq0xOFt
 eeY9JYEmj6A58Xa5UeLCX4mNj46QwCjmum1jr2Wr/VNH1dPK7AJIODnoJcW6/WezUigWR8JY2Wk
 tXTWy2jJAcV0hDziaAoK62Pp5c15QtRm4+wybUyf2i+XlA5Dlpgz5kaJdAue1DHFEJvcHzHGOuD
 SpmCfS88v+WI65YToaKDIwh+tIh3NGqMLD0fhlvDCCgpTcHqKdVYCYCD9CNcaCRnDDNQ6FSR0zi
 /fyPH9EJkFQMHGW3kxlqn3zMtHPM61spoMzfAqJikDfwbI/gW7KkmblxW3OT7QBYUl8pdondWkS
 REiom5lAiiBpki13dToIaJ1oaeY4ED+6mY6w6xlFPeUJdAZCqxHrN5ofJTb6OwKKz+pSShT1WXi
 yMQbPioaF8DJtYDwQsrsyS9/OEIfcKBdjJObw5/UEpDhcWuForQeYWc7lp8XL9cLY7fLLA+DlC6
 xbP64/1++qDOqYLrKcQ==
X-Authority-Analysis: v=2.4 cv=O5MJeh9W c=1 sm=1 tr=0 ts=6a52559d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=6VQYfvmiyQ8t40WkS/mQdw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=skqKI5o7AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=XR8jsSC4JSa_CXHFb9AA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=Cs8KYam2t1nZR3VcZU7f:22
X-Proofpoint-GUID: FtBSrl5q7eWo4P1gy7P9PEukpKLpC5zl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE0NiBTYWx0ZWRfXzSJXHy3l1q9W
 nR5blNlpb9rcfo0z/U6dPHEvznmogppl+VLIq8Pq4+i77AJT0/a94Ro1BofoF1hvuWXt8tUsW6u
 li8BEDmCtOAF4BB/kAlo9L5N8H4ujyo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110146

On 7/11/2026 12:13 AM, Doruk Tan Ozturk wrote:
> ath6kl_wmi_connect_event_rx() only checks that the received event is at
> least sizeof(struct wmi_connect_event); it never checks that the trailing
> beacon_ie_len + assoc_req_len + assoc_resp_len fields fit within the
> received buffer. Those attacker/AP-influenced lengths then drive two
> out-of-bounds accesses:
> 
>   - The WMM information-element scan builds
>     peie = assoc_info + beacon_ie_len + assoc_req_len + assoc_resp_len
>     and walks up to it, reading past the end of the event buffer when the
>     declared lengths exceed the buffer. The walk also dereferences
>     pie[1..6] and pie[1] (for the advance) without checking they stay
>     within peie.
> 
>   - ath6kl_cfg80211_connect_event() subtracts fixed offsets from
>     assoc_req_len (-= 4) and assoc_resp_len (-= 6), both u8, with no lower
>     bound. A short assoc request/response underflows the length to ~250,
>     which cfg80211_connect_result() / cfg80211_roamed() then treat as the
>     IE length and copy out of bounds from the small assoc_info buffer,
>     disclosing adjacent slab memory to user space via nl80211.
> 
> Bound the declared IE lengths against the received buffer, bound the WMM
> element reads against peie, and clamp the assoc request/response lengths
> before the subtraction. The sibling wil6210 driver already performs the
> equivalent length check for the same WMI connect event.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> missing bounds are evident from source and cross-checked against the
> sibling wil6210 driver. Compile-tested.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Some aspects of your patch are already addressed by:
https://lore.kernel.org/all/20260421135009.348084-3-tristmd@gmail.com

So you will need to rebase once that lands.

/jeff
