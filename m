Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35887386441
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061128; cv=none; b=h5ig2k4ouYj74zEjiB5wWizR/ddIpnZhQAKyCcwbGweiccWqO9uat3XcNaBE2XFPzP5AjZWw2D0iLkm34DWrCfmOTv7uDUdwVJhuxmNZ3ztLYQQk9mPWwbdbCJ9osrw7MXjJU6Tl/1vLWdp9O/7dM9F1V0g7yz6wzvDq9JPEdJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061128; c=relaxed/simple;
	bh=z4lCII1ZehUTz9Sz3H0Z4D5t89Ta0fqSUqyBnBq0R54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwiKbX24mgm4NujMwlvdHKB96S3PQbLQPF+cNtwCRq6hZS/ogMCbl1xrOTXKFTBjv1YLQg1qFgDBPW5PyzLp8hG/Rk1Oz6pthfKC26CfsFUlMmrXVRV5/gQcbdKaCbcD4ypdq2gWx5K3FDS1alY3lf4TcLCEGHwVa4LdDJdBqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiSvtWqm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbPy4i11; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiSvtWqm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbPy4i11"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rwmk3126426
	for <stable@vger.kernel.org>; Fri, 3 Jul 2026 06:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kfCsJor6zr9JsHaxgfb1o+ZCD1IlPkC0zKCAWBS/gS0=; b=hiSvtWqmwcoBj3sD
	tQKWAXmYbaBpniUdOco+jxUBFPFfnfA1KU2X1Gj+q2byMnkhAQmjPGABzhlMMB0U
	1iiqZndY8/9DJECEnS2XQprlGyO5NiWAS59woH22eEsD33aw+RL3njkNRlDI15o1
	JBbFoO6aK18sC43z/EuypdbGTH3QUeT+7LCFxLTzDsyxGzZSTZv4juAeqGEVqObH
	iyXX+56/D88FqYqg1tAgW/KzOY0V7W1MXPKozIleggk0vp16UF0F42srXGTFf02q
	jjYvRK35i+mqueQN7Rj9zDal/GEeJdD135GOUI9EeCDpA1QYwsZE56W2csLkggAo
	sCWJgg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnk4g7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 03 Jul 2026 06:45:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c860544c077so719144a12.3
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783061125; x=1783665925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfCsJor6zr9JsHaxgfb1o+ZCD1IlPkC0zKCAWBS/gS0=;
        b=LbPy4i11EiGOBd7uQ59Je/9zeAaq8sJPy8Jhg4U8SZoPg8CsctfT1I0U/FOIXfvwzh
         tm1xP/00k0KAUu8PeuZo+pn77j46YD46kVwp8VcGxxhGg+Fr8y07MkWrqF+fma6GLy31
         PfmDx1CsLUbKs18kW5eSkk9yGTX5IkvwAbIMuwhF6O1R0P5WO1/fhArLnbuSey+j9QI2
         yBqhHERWfDj4svNdYpEchKgTNffKLovHoLBf2zgl76rSiTMnZBH3RqN+t+fAAuGTA9Vt
         gXIGczkSjjbk5xRTfy8vdBLQu93UUUGnbD7Fvi7NocG9JaSiTjDYmFmtGZqilrtXR4ii
         +YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061125; x=1783665925;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfCsJor6zr9JsHaxgfb1o+ZCD1IlPkC0zKCAWBS/gS0=;
        b=frjuWF6gy9tl8C5np26/RSzd2TlD1FWHCGloy69My+sDeF+WLfTeoq6PW+jsn17i1m
         nq4Bbvi/JIsFh0dVS7z0B71FpQXILG/tKfrik/Fr8+AcDhaiIhg0VW991ONAIYGVGmiQ
         hlnDHCOcs5wWdEDr/THjOzokHOrYUd0HGMsLtdIR/KS11wAX1JTbWmnAc8OIzjv3EwyY
         jSqiffc3w0O0TUk/8BH3DGsyDKb4nHe4uRBtRnB2bSg60ur+VYwHmhTEa10O1Cb2h7PO
         PuyyrSSt/Oeq8H1K046KfFvWe/jt/dLSynqAChfUz3+odKhTb+dPn2Gwts3ArHUeQLoq
         rAYw==
X-Forwarded-Encrypted: i=1; AFNElJ/CMd0qqUO+/JMVvRcipBx266uzi9P2craCU7XAr+hl2ZXzhhJuLa4FVuWlERCACAtDxDE44xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkdrBd74eGK03q026eS1dHT6L1kJcE8OIXCRgQUB9yTzYQfdK0
	Gibc4SlJeoN5aidBstFxSCerE3aYSGrli0SoDveI5owMguHKBMbFrxV6ZzJ59HqKBRljG1fwKbL
	NQJBY5PwnpI9NlTBewZzRJeHNc0CeT9sD/OQJhwLvh47LqJL7DY4NKhFqGAo=
X-Gm-Gg: AfdE7clsKnUptSudylTmDw0pjX41dJpE92ifAVGyxgYoIvS0ectAkQ+voJ0Q85jDoMc
	cw73+oOrP32WhD27v9WDOed7mKGkN5hLM2s1zhlwhEmm7ZDD0J7vFdAw2j6bMCuu8ctaMgW0vYE
	UvmDmC1Y2G7H13QYnjWdHxX/kbEpQPDrZITsKMe5QbqPMcmgsVsv1yrwFZ0xsPzw3QYY84ommaA
	wTf4k5K03n33l9m+gW0AUG54wTy/pQRQBy3hvtS8yRRQIlxgBmIVy9fwRlaEv0+iNt2HCB7eqz3
	T6IEhtCq/pU0e/i7RHvg13OV2bKGhiRss5v3p3wN7nOZEs4JXFtFLbUr5G1+efW4Pf+1AvEfVFE
	J3aq+VQCXjHzY9YFFXo7jpiX3Aw+nyJW0qv6BiqI6vBvkBr3XLqbSFwxqc9JcFOLvSvGxKiHqRY
	cFCAoRt0fP
X-Received: by 2002:a05:6a20:3ca7:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3bff42daee4mr11446773637.50.1783061125022;
        Thu, 02 Jul 2026 23:45:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:3ca7:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3bff42daee4mr11446741637.50.1783061124596;
        Thu, 02 Jul 2026 23:45:24 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm2367706a12.5.2026.07.02.23.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:45:24 -0700 (PDT)
Message-ID: <f304041f-c570-4db3-b27b-86d85dd41ec5@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:45:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix potential buffer underflow in
 ath11k_hal_rx_msdu_list_get()
To: Dmitry Morgun <d.morgun@ispras.ru>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20260530114252.42615-1-d.morgun@ispras.ru>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260530114252.42615-1-d.morgun@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: S4bWMHk-11wRLxutI26AQ7CflQnSDFJi
X-Proofpoint-ORIG-GUID: S4bWMHk-11wRLxutI26AQ7CflQnSDFJi
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a475a86 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=HH5vDtPzAAAA:8 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=zEb-VJRgp1rxa82pEt8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA2MiBTYWx0ZWRfX/pQvxj876s7f
 0WOs66oX6o5lF/JJJOyOaWNcoiiKibXChx+mZx9jYdZbhDEx8mxi2soAWblzj7719oxb1FGImD7
 r78Tiupil/ebEPEDalJt8JCGzIAzPmo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA2MiBTYWx0ZWRfX7GvZFSJnsojE
 pnsXuHdKcypw4mbl0Khj5IeZgPsbdqxovYKHAwOZrmGFJivJ7LpiK89Gjjt4tzmHjfNl8A9Qck9
 1QsbqGmuDMGB4GKoM/U95bVc17zU+6ECEFgGrUK75k56Ms7dmIq8yZjDKvEMI8Ql7sYzlB+0fxP
 N77adJm7PRwNMNRKLewDSIHKwz530DHUY64C9yYEIsQAPAlcRZOqtxmuXQtxsqBpzIHn7/l86yZ
 vjqr5UJP8uwkLmoNo2SY9UK2pFfHQlyMeuQ4QV0F9N/EU4G6DufUi7C/uLQzg32KynhR3eivUXx
 gri4nhIHSj+zXEziApM27zAUmWUwSjsXKgFjHtynhQ60yYKxuBe9Iw0BjflKWq5H1syChg+J4xP
 xMYPWcSwig7VNcumbAy3yYC/f8T0dAg/C4dIiJrXPM/l+k+u1Zk3VrdTowuJjSH4JuC3PNs6LxT
 jJk7HWZji2Pjd+yrEBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030062



On 5/30/2026 7:42 PM, Dmitry Morgun wrote:
> When the first entry in msdu_details has a zero buffer address,
> the code accesses msdu_details[i - 1] with i == 0, causing a
> buffer underflow.
> 
> Fix similarly to ath12k_wifi7_hal_rx_msdu_list_get() by adding
> a separate check for i == 0 before the main condition to prevent
> the out-of-bounds access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Dmitry Morgun <d.morgun@ispras.ru>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
