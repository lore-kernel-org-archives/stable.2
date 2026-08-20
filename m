Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5DB2931F7
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213833; cv=none; b=YcCSRQ3qoAc6aUJkhamzW/Ok8VmxhUzIMJoLxNRnzRGP3sAfQIko4zGOLBUfjqGXLc90bYpITiTEOBDfEw5GjF6oNASf+j4S4XwVZm6lXe5v7ZLDbA4smoB2dUnm9X2ghaOSsuAfTnr2zQUa+tMSsPussuoJmFAGwE59Qu3XSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213833; c=relaxed/simple;
	bh=azdjVMN3GQau7neihQ/6K+zOum2258xhwA7RSd6+FXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRAWjfvIb8S039tAqHZfBg6qVqkk664InAdU60DP06HiMTikk3jp3Qy04Ci+dSzyf2q0yRRhjDbQVFjTvDvLOv4uP2On7nV5NXF6uo5fHZ8J1bGS1bwwrGZ+gfcarPEEedNi04ypxKKTAc6XwRHWcC0jIaVMEms9OIq8yoWdli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lScmViJZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QvnIo7gH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lScmViJZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QvnIo7gH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K5vcQs1354528
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6kOKQx9GSDpN8SDqnvj/Olccsae+NtZfsVGGwbJTEyI=; b=lScmViJZvfvcDB5j
	iXaxpckD4fHZ8OeUNmwNYINlb9Q4vcB4yRa8dJuVLDOkLrmhbn+4CZqMNmoeQHCv
	z/MYpXV/1Zt8WEqOGaip83lFyzWmLFt2+jH5mrj6KSL2qa+G94jRuYDRc+kYau9G
	D4rHa94eYPbV5c3c1qeAmkkoKTS76KtzdBfVY4k6D2u+joovijf8gRRItm7X9yF+
	5WcdlApr9hlr3rVyidwFMYXPNuPCtWar/ZLHQxZmpr8+31veQYxdrNTsGAdxXYJP
	JGI/Lz1HBHBnjTMRiFPKgdKmZhgpBA8ttC1W58Y+SSHCxamgo3JaoxRhX2KE8h+6
	hroTjg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es5bwge-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 08:17:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d35a38fafso336311cf.3
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787213829; x=1787818629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kOKQx9GSDpN8SDqnvj/Olccsae+NtZfsVGGwbJTEyI=;
        b=QvnIo7gH6mE16+N6EbmWzgHIyDaQME4Vkd/KSvxilUtVtXX7B1YW5CH3XSdGuvHqre
         iki1U2/Rd1m943NgyF1RNNzi9zSvGlS4yUzaDXNEZ8ESILz9gU65rm6Tmw9AwPNhZEis
         Jw4NXvqZD/VN22/7ahL1rKrrgBqvXNiBbcYOxwWPD7NcoEYa8bkOCU6TVEpOkEwiUn7f
         IXW16q0eb2jvIFrVFo2hmsxplLnv0ETy/Va5vnrZqlOkFrFNeKHwx2P975vmY2uxlUyL
         ojFNFWDNiJUNeWPVW8E0GQfCGTF2FkyufjcNDJ2hw+UfnkRU7LRYNh8qlZ9UjfF65sjs
         pgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213829; x=1787818629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kOKQx9GSDpN8SDqnvj/Olccsae+NtZfsVGGwbJTEyI=;
        b=Vye7nFTUqJs1O9KpBITGLGf3sCLCrwxaYqnJCkdIRwm/b0b43vhR1EuWAvYb0ahsJM
         OUFuUrepzf8J4yhe2n2ORbrITAbSi2p7ShQlhtjJiKnht9iIiJANhNMQNV4JVq9rPfDz
         fECE056dOF/PGj18PF/uyC00ZYdlSUWkD/n77XpwnRk37v75PAE9c766iZvnE+b79n+8
         WAwEc7S0/wUqZUbQJ6LSwaWZ3zEt+rqdQdIq5WWCNf/hlmLJyfP9eAzF/pmO1+6n5onm
         MsLpf89zDs6d6eKS2WKkKlWEIHoZOUDsP/xohLvewnvqBf04mWuEugQf6dChZIWzvK4h
         rQaw==
X-Forwarded-Encrypted: i=1; AHgh+RpVazsoxBTFJgBm6R1owi8QraFrRAOdr8kRXksjqCi0KroO8tgD63aGt87urhQsYrZkhRjzNbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5DlZcKy5B9BisboGu2K8DCypXw43xls8aRlqmh6W+V33J8g0
	tbSgZQz2hGoaiPRkl5emZcoWkcN1Yd0/diyZoBSCuRPa5gWGAAm8R6T1vP5X/X6/DAeq7n3TXPG
	378gRfabomUgwmW4Sz8hrKXnVP4v1mDMmgzRMOVkJZETDP/Qtfr++Bop7oBs=
X-Gm-Gg: AR+sD11LRK6L8fNXNPeD/4PxMfBJ8lt9KptyXzn83evYD/hS0ePm/LMEmGx3dMLRLRV
	XFr8IiFdGtU87yQYc/f73wB3MR/wZT/0AUTsa4xrMdzQ+q5x6d9ebrbOJ3mnG7v/o37Eg5q3pEJ
	RKhnajcW6GOv0Kd46y6bCPL8HRFoTLwny7++DJBPpA/U9LRqmLJ6s/W8dxt1QdEH3eZTMZRp5Sz
	liHiNyfXvd7Zl9W1pX4l2YGGf2ys07WYzzvjn3UZe0WP3jRiSN/61Lad2Rd5gMFC2cBRYuF9SnD
	UFkCGj56p5Vkjgh/Guh9bxatVuN+//9BOL+QDEnA0lMhrCgd2q/bev7A6CcDO+ZzKSabCb7sWTm
	Tu+3mQYi5W3GLRWt91nJ3roxU
X-Received: by 2002:a05:622a:588:b0:51b:f9e0:87b0 with SMTP id d75a77b69052e-52dd579195emr73714221cf.2.1787213829201;
        Thu, 20 Aug 2026 01:17:09 -0700 (PDT)
X-Received: by 2002:a05:622a:588:b0:51b:f9e0:87b0 with SMTP id d75a77b69052e-52dd579195emr73714011cf.2.1787213828773;
        Thu, 20 Aug 2026 01:17:08 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b094c4sm41825266b.22.2026.08.20.01.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 01:17:08 -0700 (PDT)
Message-ID: <79fa9d60-f8e9-4e5b-8c01-9ddb3a86e3fd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 10:17:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic: cancel reset_work on stop
To: Fan Wu <fanwu01@zju.edu.cn>, linux-usb@vger.kernel.org
Cc: bryan.odonoghue@linaro.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260819161448.76597-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260819161448.76597-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: KRT1oi-mt3qwbArfcXJOt-ufp4D31OJT
X-Proofpoint-GUID: KRT1oi-mt3qwbArfcXJOt-ufp4D31OJT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1OSBTYWx0ZWRfXybvAGha+sMMP
 OSd9qmUJc4lQ9dvC0EUjI7nIzgGCy+ha70HQDGqodO1w6hvK+G+JQFZUOnKJtjc7hZjofum4T82
 RfAUMmMdrSUAVEQjB+SFLiDzcTaVBPE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1OSBTYWx0ZWRfX7sgBzWKqu2le
 Nigtp5BpO11K9oyVemgudFiiobOZsBAaD+pIs7oiUcFz6odn6hpftKU6aB3HKRIBO2rahXT7TGk
 xkFnEF8RLRqzXreaxa32J/a2Blop5reH6gHng7ZQhD9SzG7VQt3fpYADU7e2ltJfxRyWCXznEBM
 caXNnVe1mP5mzFjYMufvnZpKq7RchIDWD/hZLA0DiZIQqGOdYnSBz8wuMzq+pWgpMeEU6m1O/B1
 oOTJeKLtM9keTdbpVhNdF53KIj+nP9lOqf/fCHMFjt8JuWtKn0ue4KeTBoMoece/qgYV3CoJusE
 Ls8geN5sresmuWRUHLMEh2/cMrCgqEgBsgHvPw1dkXNI1+WCrxzTlxYpASIbToRkqkkzEkaxVzM
 zw50J7Qp/cnH084zdaZvjIVF6DwX9nMG9k0lXCRziY9Q5cUIoQ37k781RNp5CaR/2IDoClOxXZ0
 WpDvrLWANg3x4TYKrIg==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a86b805 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EsPibtQv_QutKtu_k7wA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200059

On 8/19/26 6:14 PM, Fan Wu wrote:
> pdphy_stop() disables IRQs but leaves reset_work pending.  If the IRQ
> handler schedules it just before disable_irq(), the work runs after
> remove() frees the struct via devm.
> 
> Call cancel_work_sync() after disabling IRQs to close the window.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
