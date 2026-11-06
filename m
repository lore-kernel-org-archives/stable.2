Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972438;
	b=m/jNWiOxt1NyswDXDizSZ3Eg8tm+A4qTZSWlXJjjXSHsGP+dZ3zmO/YNnWwaWtAXMYc6
	 BEsGgZUksR9a4QOzq4nJZIEwg6BULIBjDW/ab64T3TvNJ31EyinvwEMWAjukzRdqQShKz
	 btqNJjYs7kybtr9DKP/8L1m9DhafEDKGhtysWpkn17zMJlO+AEyR5aYtC5AmqSk9FM2SJ
	 dnMV087Y5prWNxTg1VNVNuOcBpRkgt0ltKEyO41gqYEEVBScsoqXXOaVaW7P+fz44W1qo
	 dERoLCI2ELCjb1SGp1tdoZ8o7G3AfQKCgzEP84jgqGa+w9DjJRN78uiMR1B7t+0RJiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GDCcjK22s0dpHL/t9oPLo+bDI5LKQyG+roTno8WQGAY=;
	b=zWh5Hppb58tt8EwvEHjJDzVnDcFib4vJuhWn9P1DEpEQlKkbB8fJjdtOwzoX8al3tHoH
	 7TeR27GbKNq5VwlgCBIVYIILrGN1lTo2XCpKb0tO/0krH+m8FucXG88+BbQWzVGuduKFh
	 DXYMy9Vv8lFwxV45IB6sC1nj5XFp2OHSr73kplZqcSLcPsGbswxiBWkiHmE9WsbtmNnTv
	 Fl72r+0OhylaQgVw0ksjwAaF6U8iYWCOdg0adoVdey1SpOuExLNiU3nF1RdLndOZZLdth
	 M+bAOsgG/KO3OuUrU/US1bF3VR14W2BNKm5/tZ7OVxSfHRgXpSSnsmZ9tEtGuK6RP9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mt21uQwH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PwIpTiIW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552BC606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 552BC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mt21uQwH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PwIpTiIW
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6APNi62076363
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 13:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GDCcjK22s0dpHL/t9oPLo+bDI5LKQyG+roTno8WQGAY=; b=mt21uQwH60jZV5YW
	bmP8efFpPjP5ibdMaideJXA1mUJKEe2ENerXsynsr0DD+DuxPZeEvQ7ENDmjz9wD
	dVk+4Lcw6/2YyzReaW+ztxb+6XVhqvQgwyx/DkdCWobxvYkwgZy/nw1wnPZH2tDm
	kISJQSojSv+jL9sQP9oTMVlv757YeREFCcCJ/2R3gcWNeiD2Lgd9f0g0nIE6azfe
	D9fzMwya7PVB4RgOiXaJ5419mGvRKlQKdFy4efXoqwZaw1PuPfFxuln7olNuGMW9
	xuPl4KrTSugyBOPvK7GBE2GFbJKGUgV9Ot4L90AGBGLtpjIXKZ7LZno4xJu7chzG
	Onc5sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pcay30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 13:40:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ea6b66e53so14859385a.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793972436; x=1794577236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDCcjK22s0dpHL/t9oPLo+bDI5LKQyG+roTno8WQGAY=;
        b=PwIpTiIWw8FIUerBBkwWbF6MBvu8kbY7uFo22a1BtDQ6A2dVoNuQNxUbMrHLVQTayv
         Imcu1jkUFlsGD6gZFl3eZHEtRd4xwYRxRleGCIKoe89HJR5aqY8qOTsbSEgUTCatzKPR
         ozV94ZZNc26HS7SsJWvhvpKS/ZhqsCIXPlpDSxHjTV5lSPBbFufsKiMBwh6YHwF4eUT5
         sXnmUdAyFkXeAZ73o3TbkHjfMzqzQy7TX59tTK46dYAqH3vl9Sp7Ovsi2xJXy07Jy2IZ
         p7smqCvIzOOQgfSlgHF584hXQ5MpfS8Aaa/+Pm/Z1wXSIKWBeupjVGcpXqrgQFcNnEBi
         18lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972436; x=1794577236;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDCcjK22s0dpHL/t9oPLo+bDI5LKQyG+roTno8WQGAY=;
        b=Dm7a8sq7ET2XKC0hUikqOu+9B+OVfFbO7BXE0WED/8kyhMDpT6d80wUDIgjmz5Gq9B
         tIqNh3ikaffmh8iA2QjUGxjGVsFDV9tSFE1svUTfm2LiCsFK1eoniworXdnfSwSBvCJe
         nHDSo6c+qjNf14UdKNLRnPJGBRQMGAMT8ntL1cjce0QKqHJHd+t0r8nF6sv9q+STul3j
         8Wra8Ct2jb5i5qMqK5iIXCQmg3YKoZb53vk1Eq4MMAxC98gpwxx7YVoNP7Cs8P2scrHH
         rhyHZ+aFfoRX5ocwbfI5YwXBkUDlLMkijpEos9qHkntXcZb0jQCD17Qx5NVgeCtuveXy
         /BpA==
X-Forwarded-Encrypted: i=1; AKwUvBwAiqIZ0aFGTR0PpKyR8MQEO6Uhhw4mvXfIWaX8wch+svLW5+kdtI+tBTDzlrHHWZNWfrpaj7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vI+T2410kgz9GzBLAO0HOQ0T0elz2ZlJU5P/areHmO06zWPCw
	KftLJyd7KY3On12sYq7XMRR1cXiG3GJmsfQ82Za+NOCMEpRItKbyKIaMXK9FKOQRWCKh+hyP7bO
	kujpuJO+dBSuLWH7lGIaQFMcRBR2hizydd7aaQSCxEQLNiTi7nNl40aTYe+w=
X-Gm-Gg: AYBFou359E6KUl9GPLRu9OH6BKw0IxH1Uy+p0qFG3P6AK2XxXa/86jAJuCjPBYSY2s1
	v3Ahd+n3e0Ed6uG+OJqD7JZ1RnJiiQmc523S1YEOEi8Ab0lGSuoJNRqtToPj5OMxMJ8oYl6a0FX
	6HuF2Lk6BaQppUvNeNrq9PtG5GxDwCZZzZZbnnZObHsHvmwISxaSUcRq3GP6iMjjs3EK+6neXr8
	o+Z+QHKpuiA1VsgUaVjce7SDCRITfbxinhKwsYzK5luQELfl6XjSPRb5TL0AoLokS7teqEyZcD4
	LSp32CQy1U1qFp4cnTVssED9sn/JY1AQpg9araTy/8IQ0hVyiS9gPSsOM22a1NygFxDFuMV6MI/
	7vMiLHoFNXL+QSr14YRZW3d/76CFG0MuuND4X8srWaQvwqasQ9Kl3KPFbz2rRmdjeB0eP+Q==
X-Received: by 2002:a05:620a:2055:b0:92e:6485:f640 with SMTP id af79cd13be357-945f357ff62mr327791385a.4.1793972436428;
        Fri, 06 Nov 2026 05:40:36 -0800 (PST)
X-Received: by 2002:a05:620a:2055:b0:92e:6485:f640 with SMTP id af79cd13be357-945f357ff62mr327788885a.4.1793972435896;
        Fri, 06 Nov 2026 05:40:35 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d35673731sm79647366b.44.2026.11.06.05.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 05:40:35 -0800 (PST)
Message-ID: <1e3638fd-ed06-457f-bc8d-1f541caf4c50@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 14:40:33 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: qcom: fix a use-after-free bug in system
 shutdown path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261105-pinctrl-qcom-uaf-v1-1-c9cbc0a93161@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261105-pinctrl-qcom-uaf-v1-1-c9cbc0a93161@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hJ7JMCglUWtSzcn9Owt5EifJl15vG8cj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX8XvNjqJJKO6c
 FBO9kNPQCjnEmrUomuSSjQZNVZSFannKhzRen8dcl1wxdEcdnbQ6nATB7fY/gtPPYPp8PgvvTUs
 0J5fk9/0wAt8zL2W1GWiqFgRzdVCYUMCP2abj+0En0zPaJBnLy/1HRLnLztJ7k8aTFgyh637Am4
 KigLlwQZuXH9Wdbv6j0aMj3NxrInvYrzvpcIZ+HUw5Wc5tnzAljbIzUTOnoKf7+HXVW/RQBTR12
 6geXcPG7hzQj9+qdjvqkPJAygJBOqX8DWRTFMA4/Y2GAJCBNgApa3+dIvjfkvBMEDYFKUZ13/hH
 MA+HcUaWa5j3+S7p64rDHcTT4VCuMFON9VjgGULKIO2/UpgJRe5tiEcdtCfaV6uAZ0KVr6tJtRW
 rVXrJ8EKIEC2ot7hapawYNh3mHcsfziSRYE82UWJPcNSJvG2CgNoNeOTJtCLqNZtSrn9vnsUTfU
 Cl2AJvnr4C1MRaiu6nw==
X-Proofpoint-GUID: hJ7JMCglUWtSzcn9Owt5EifJl15vG8cj
X-Authority-Analysis: v=2.4 cv=TI3Q2Fla c=1 sm=1 tr=0 ts=6aedd8d5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a_ps4GQ-2PcO9Fe_iXEA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX7CaBMmGGGohJ
 JykbOY+0SPRmn1Ryco4EE1rjpYuce2+0O3JhEaL4/ialUb7guegYNmAK60m+IqLTxFtYOprM+UV
 yg9V24UShBS4t62jMAqqAomEHmC/XuM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054

On 11/5/26 5:09 PM, Bartosz Golaszewski wrote:
> msm_pinctrl_probe() allocates the pctrl structure via devm_kzalloc() and
> unconditionally populates the global variables poweroff_pctrl and
> pm_power_off.
> 
> If msm_pinctrl_probe() subsequently fails, devres resources - including
> the memory allocated for pctrl - are automatically freed. However, the
> global pointers are never cleared, resulting in a use-after-free during
> kernel_power_off().
> 
> Schedule a devres action clearing the global pointers that runs before
> the pctrl memory is freed.
> 
> Cc: stable@vger.kernel.org
> Closes: https://sashiko.dev/#/bug/linux-0c3a18a4-3de8-489b-abc9-e9e3a8641ed2
> Fixes: ad64498762dd ("pinctrl: qcom: Hook pm_power_down for shutdown support")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
