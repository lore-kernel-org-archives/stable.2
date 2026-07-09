Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EA3E3163
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608596; cv=none; b=FyxghuG/4vkr/y63HXfWeoXRXts1GBWydo1X0EnvYl9zeHDntB8oYVeepw1sYoPXWVSRRmhvYhIR7C7A2xNf3KDaTQAlDRd2eUN6T077grkEIi8CNPHXs9arJRF2uKMlKG+8rKVJtWpL9J7g/uE57QSFQmuaXRmVsiB3N9zwFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608596; c=relaxed/simple;
	bh=xjlOmzHN0GfF3tGvOD8NpCrKYbRGI5NF7iSKFD5Sc14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OtOaGsnAuOQHVm0UYflVOy1uALY+9tcpiW8ecjkgEA4SAlxheuNlQVUQp7SnrDh89T0LrvtD6L443wTBVVFN1oH4QrlXOezcP8tsNFGNB8eWGWTbooyxJ1Ch6Qd4be8Q1+s6l0BKzqGGdu6Btec8kePzRQ1ctXamH2l0oC3nQvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evaVopnI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L8v7NQGw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="evaVopnI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L8v7NQGw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Dw6Ya2013010
	for <stable@vger.kernel.org>; Thu, 9 Jul 2026 14:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C0rBF8eoOikPGKXr1eu52DTy3xRy33I6NKD14j5lOg=; b=evaVopnIYdtIrxlE
	srq5IuYeqWHxBUDcUV3oioLeZrvgX9crPa0W7ctGEoaShFxlYVt5dd3GOQ0TjE0T
	sDDV04DITc26MtBtwHgv44sZdBT7Aqe0Tn8oh7Xz6UaEZJ8Ksqiv+xWw+zGDl1UO
	PQzMMpAUIfVKhAJz7ijdSSYWie2ut0rnzu29Nk1EGDhb4E8ZRlFORi1G2NL3vZQ/
	U1Ezp/E8JrsBK2bk/vg8xkBYXSFOb6zpgNQNOFzQcXDjpbDUAMbvl1lKOS55tT7N
	IIF7XlaTS5p4CJmyJ/NG2DwnEDH4hecPtrdpUAgn36LaKw0LG1cmnPxCauH0a2Je
	ewJxSQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418jsvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:49:54 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8099ed7adc6so61617207b3.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608593; x=1784213393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4C0rBF8eoOikPGKXr1eu52DTy3xRy33I6NKD14j5lOg=;
        b=L8v7NQGwf9BlGppCyHnvI+ZqCOCEx/J4RfE4+87x/Vgdls3zDJC5Ntqkspzy5cPLTe
         rTKCmSFFb/w9/gXZmIR2Chg5cUEO0NCTmcW1odXR+Z7os2xYt28ZYEwwEFSWm5WXSPn1
         cFkznnMF1RmcDZyooX7UXflcICH/bmuOepyxxj4yEM2qYtqV/ieKPFp8qU+GSCenyMXf
         5ZxyJds1h8W0OyCb7RHzxTYopexMGGesSI+5fasC+xrdFSSvCUdDOYTau/AZ3yZncWsT
         WxM1/M811jJLpP+7IZNSYR2cgS5LFFlS5lmVIi2IN1zXIIcHWmKCPWyQqn6SPadzPpYQ
         ek3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608593; x=1784213393;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4C0rBF8eoOikPGKXr1eu52DTy3xRy33I6NKD14j5lOg=;
        b=eJTiK7+p0sWdLMjc9QVWnmn+OUpvoZSsrFDKSgMVZgl9gIs6upLbMRPOFI46IPjo1R
         9lRVhbSxU2gGkutZMirPtmVYz3jPpyXGyYwS9vd+Z/Uoel9qyqHKNTDMjkiFpk9quHlH
         YAzm0YnOlLUpYIknbV4iWv4GMTi4l9VJ6Sz6t2gdBML5sLSuf9hgogGelTHNaNc4Bg5u
         yn7qMsVzr+RmECM2tFY7P+ZWtp6n7fkwLzbAUaCWu5xwmD9DfCoiNp415AGGP/eAMmIv
         khUwpKvgZYNYGQexj7xwkqmc/VrXNAyXOSJf5e1XPJqc0a/YLhWCe5ikHNQUKM7wQ6nq
         Yp6A==
X-Forwarded-Encrypted: i=1; AHgh+RqxigY+l0bT2Ra5GLy2286Np4cUeAoWG7HSmiorvSdXnUiP0gMsJldqRykEkw8G7T8A4+xo5b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdiZ/NdhnNy0EW/98g1P3c93rsV2kBmItGuz4caDqqzbHtRXQB
	MURxDZ3Dc6Wsjze6FXjE26QJdSNcWWBLyPJELvz4VW8eR6XpJdHBbGH7v1SGn9xFHRu1tc3llqQ
	lJGQsI9w7nPAnfvjEQrFeqE5EpgKVoxCaIEdmzfdqMbpjSZml25P+sLlANwo=
X-Gm-Gg: AfdE7clGQyTeymusvm4DWd9b2kCIWiqMzs3rsBGjqLzjqArNRkZQjTMpyoOoMc0HTZP
	OzpB/xtbDhOax549/QViwDuTxXeQZhDTmvVQViv9WJIBpU9r7CEvGmu2gefm/hlygHdkwTxVNGz
	btWQJaVIlOMzdbe3Ypj+Q1p/N9hSrSDhhYxPek5IOP/40ZlNiK2itn3W/UBbzJXCFJ5FynkTykz
	HM/Qd2svCO+IIuPBFyTtFbga0eocEx8GtL5RWYYw55koIs3Fa3O1MFqKaVwRRJl/pvBtrq/litt
	5ZkuvkFPj7KbJ8f43OPvx3fymdiXLDOthgxetgFmL1sZmw/dvQ4P5r3U5r4tOH3dBUizlP9tL7i
	rCeGQH4y0FpwMS2Sf+ionVs2daA6kI9+MPW0RhswL/c2YKToFsPHDZU9bcLuNvSYFPw==
X-Received: by 2002:a05:690c:6c07:b0:7ff:1a06:472 with SMTP id 00721157ae682-81dbbe3759dmr63673677b3.4.1783608593593;
        Thu, 09 Jul 2026 07:49:53 -0700 (PDT)
X-Received: by 2002:a05:690c:6c07:b0:7ff:1a06:472 with SMTP id 00721157ae682-81dbbe3759dmr63673477b3.4.1783608593194;
        Thu, 09 Jul 2026 07:49:53 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm4989277b3.26.2026.07.09.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:51 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Dmitry Morgun <d.morgun@ispras.ru>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
In-Reply-To: <20260530114252.42615-1-d.morgun@ispras.ru>
References: <20260530114252.42615-1-d.morgun@ispras.ru>
Subject: Re: [PATCH] wifi: ath11k: fix potential buffer underflow in
 ath11k_hal_rx_msdu_list_get()
Message-Id: <178360859072.1031194.307534761156277733.b4-ty@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 07:49:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4fb512 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=R6p_8CvzZLfSnjKUPdYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX74n3vl6Py9d1
 ET1Jmbufn77lDFT8zOfHnN0Mhbrk64vSvVWjBqx4epfoZ6qShr40i7FbNXOolIdIOg0I6v16kEP
 EXyqagk8t4rIb32dI7cjQ4QoV4RaxeKizM0C/WD5ciCwl/URiAQFLiMhsqdL5RP0hDGIyN/B29S
 iRvmLiUh1k+F4yDWAWC5hGCYz+kcmvEL5x0dVWoNUWEPezafIHqcwjdI7hd8uNtV32jyTQ7mrLI
 eHVfqNJB3E3YDsDlWF2p+nwvuFBCcjVoCAe5y9j2gPVCIopiv7UEu1939ZIUODW8qowzn/A0Lhn
 rXQiyRnHT4qtWaTFGKZie98Ga7N8081R038ui/PI1QmEtLWqSJISNAhZIccN6lKnsT2sDibQYfG
 um4x1zedOuJyBvyAq6+e9DccnnOo5bUza42v1tH7gVzeZ0q6yIsDjNJlQOszkE61LmSb8C29Q+I
 zaYMa8Kk9hCtA4F2DTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXxOMV9KTR+QMq
 DUMsMewwt6szkQQeUbT2ULx6kMjqzNVMJjpHLuBqYNQXuaZS8a/2WQgi5nSIMjnKQlkHThgMi/t
 JphDdQYvtwh+3DNepIL+Mi3nFazMfao=
X-Proofpoint-GUID: eItAxuOfpthcHP3TrIkpIkmenw7GfI1y
X-Proofpoint-ORIG-GUID: eItAxuOfpthcHP3TrIkpIkmenw7GfI1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146


On Sat, 30 May 2026 11:42:52 +0000, Dmitry Morgun wrote:
> When the first entry in msdu_details has a zero buffer address,
> the code accesses msdu_details[i - 1] with i == 0, causing a
> buffer underflow.
> 
> Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
> a separate check for i == 0 before the main condition to prevent
> the out-of-bounds access.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix potential buffer underflow in ath11k_hal_rx_msdu_list_get()
      commit: 7f11e70629650ff6ea140984e5ce188b775b2683

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>

