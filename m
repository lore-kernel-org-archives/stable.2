Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472387;
	b=pUqlkM7HTrMGzKTCCV0B1JMisBZSQpRWxTfrLUkfYi7gJMtSrYRE6E/fN1JPjKtnMah6
	 8Z0u8w6bRwFG+wRq9up5pez1BwmtZFSK/p6YcWGgmelAdx/xd9J6W1T30/GpHjdCXQD9J
	 JjkBWipLRp8fikcSPZXVm59Y3QgvUAc4+3Ds/n2NiKQI4egfVmsrJmQ3QpshSsQMBMQcR
	 L/TTaQGfo04nbno/hsmbx0fqif8woquRLrpagnQ6cv43a4WJj/T6GqHobJwiKnYKbb9TT
	 ePca7zpP1xeyUfxzogUpRG5fD0uNevPINCqDJTlDOCIqmF15pbcf66oHyMokal7pCTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472387;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Len3Udn6sbD28+Q6LTbgf/hUErCOXt1JZSbfv4wLLms=;
	b=WjE4d0aJXILqtD4qs6RSzjmUFMLRJL2sSVy+1lN70G9sKejNqv6Kv3qrc+QOXwdn+Nvn
	 tBnmcRBLbGXlisg7skASNWg23HaiIvYgXjuUQmRHqV+/N1BaUsSzXIUEkxWQP8QbX2UOJ
	 GAVhcovOOKO/jU0eDoyyF7MKZX7ubdHOoVEULkFLrtAPnfmqRnM6ldx9JQ9sQeHMvdFDQ
	 BwGGkaYXUuds9vRU8ueqqXGt8bROM1Qh4ey4w7CgQcSiX1/0LW++gnn33iXFN283GWkA7
	 s0yaP+a2aTNB3mPU/zkqqUC4ZiM/VGQ0ObLz7AlRBv0Xvd/sUG44tyGemZLDeBcSwJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nDjGUTWu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EwH4+mSz;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C660A6F7A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6C660A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nDjGUTWu;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EwH4+mSz
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Zd8e597386
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Len3Udn6sbD28+Q6LTbgf/hUErCOXt1JZSbfv4wLLms=; b=nDjGUTWuarL0gomG
	UiYUJvOfTJzCppFIuH04vgZteDGys4xua+WQ2rQvyrPYi3J74KvkjbBx+kVUOwds
	t5cZth1KVAxpmdBXvikHsloUpL5yKFQ5A8ZDzalpxse31oahRXVNA+yrbCm4y9Zp
	S+mkzi6A5iFR8RUAPAeQunWmS1H7/JtwDXq5/oB6HllnoevfRCeNWro6AxROawqV
	7QP8xdIXVRh4Te8Dqnl75vH3jn21d7OjC9cs8peg+RxsH3TMj612uLOuVy8vW0CN
	AVfCIKZzuAw+JUtf+Iquw+aZUJX0vuLZzXiWV+yWPJkov+ZtjhWq/u30KxDN8IVw
	OqBWJQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt153urm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:33:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f2c0e6653so771261885a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794472385; x=1795077185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Len3Udn6sbD28+Q6LTbgf/hUErCOXt1JZSbfv4wLLms=;
        b=EwH4+mSzdFw0Fiz8KNZkU7w/+uDzB+PZ9h4gO3ou5mu53eqSGp51JEwVaXOa45P1yI
         3WLJTbyjmApHDs7xPUm6Hr7+kGA089n0Ixx5gDaXuoGsrYue9ZJXeJaj3NRdI9RReBcE
         4K2X0NrdEp2qPES7yQsdBfOmcIh6KJh7M/v67i+aU2hZOyXW8tXkGtZt3/7kAurx4lRD
         ZuYAavcRKqdpoCj4jSr+1LIllsUSsQ0ztoGQW/aEQ1gKW45SFXUZ0rt+3mPop6rSXbQs
         0jf0aXwVtjXsPTYKK3QAOy6mfZtd4Ak/P9mgsnBtHlNbn2OeopORKXGRBBJHzQMj9IQ+
         Eh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794472385; x=1795077185;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Len3Udn6sbD28+Q6LTbgf/hUErCOXt1JZSbfv4wLLms=;
        b=YMmCr5W759TjlQgF6RTV7ibmlrtfOoh0iVqKU2xdRj7IQ5quhd9i8MCN0dRPk5zhh4
         xgqqfkiI1PkQUnFpmpp7qiRDsVTQ2x6WQRzqwmk5gYD+/8n1pi0Tq+qMDrZdrNqtP9zF
         ipnAI7+JKCjdOs+r+GUthXrH1rrCkjdpnIwFbr8WU9TqN5QpTzsAAW/SqLfq32/gq1xV
         jlO6Vzkpj9ieT0N6nJxwrBF50Io7PjNt2tIXFayj6Sv4U6ZGGf1qNfyMOYOj1YCySUIp
         X/wZ63yL59a7D78K1cJ/lOGHKi5ft3rhq+qEcxQKJl6clqaqflXEUGkIcC5cYa6ZHwgT
         +tnQ==
X-Forwarded-Encrypted: i=1; AL+hErGB/iMEZ3z90fU5o+QnQ4fupdxxxZYS5GxS9ZbI2O251llcddKlLUpwOTyuamOs0Tib6S4QLCM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8w9R7Nn9n/rzllxngmEAG5AE3MGMyKSSpVof3we3S3ZFg30ERR
	5Y9qKYA68Y0voAf9pS66eYVtIsXaZsQ17pD7GngvggYeN1O3o7ndB6zdSWt0vEuzqFCqdtUAWLJ
	VYMQhX8DDIvVlaItQANAidlrBfys+ZzRxT4rbJhQdkarXJCbVtG3hHZ++egE=
X-Gm-Gg: AYBFou3CQzzorNR33YAorEEPRVG8rkIrRaUFUzPtpRXIHGwVvxTElxkllbyKMlLlUTi
	4Ua0thoWFQJ5H57Yc5y+y742DWPHEsrp5PAOtG35LYRCvsGHLAvfHQAHa+07CiQ9IeKdmMOTESk
	TN2CN1hgYWpHsczSBk/7pUWRoSAfjwOEdUFWwkP2Al6xiKVgjSM+jI/kiDAkQ0KzeCc9ZjhO9fT
	9VEzUDS6iA+7ZfHl3JA4gkTFRlsiw4DzQ1Ho3mFXh2CdHyiTZgXIPHf0ML93Hc9t5ibH9aCc19a
	f9ZQ9owhYpM1La9whh50s8WymBZlr+2ThMxMmjHVFf46dzRAapyASaJOXfWWbPHhiMUnA7ueWIF
	kddcql/KSlwS842OwkYOhaPGCwCqbGJa/Ryy7AokDaa9qsJuFY6jgCFVSg3GFezyerm1i71P01y
	cz
X-Received: by 2002:a05:620a:258b:b0:93f:2463:f784 with SMTP id af79cd13be357-947b00a70d8mr830040385a.66.1794472385002;
        Thu, 12 Nov 2026 00:33:05 -0800 (PST)
X-Received: by 2002:a05:620a:258b:b0:93f:2463:f784 with SMTP id af79cd13be357-947b00a70d8mr830036685a.66.1794472384376;
        Thu, 12 Nov 2026 00:33:04 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49bad3cd31dsm1070593f8f.56.2026.11.12.00.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:33:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: fix stack out-of-bounds access in gpiochip_add_hog()
Date: Thu, 12 Nov 2026 09:33:01 +0100
Message-ID: <179447237994.4979.16703071994688693548.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110-gpiolib-hog-stack-corruption-v2-1-c5b28cb8dc8e@oss.qualcomm.com>
References: <20261110-gpiolib-hog-stack-corruption-v2-1-c5b28cb8dc8e@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX7N+W99PC8BxC
 wNNMbMoQBdFZJHbSOealMiM1nvHHuP2GF9xfrwEKiskIDLQ6/geEHVE5RvrfJjKkPE5RETk5j0p
 uqcyGTXxkcU/hXuL1FlclJRTUxV4HUk=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af579c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1Ip7nPS8rvKNqrQfddsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: IqEUWu4sbUb9BuyD3Y2Yf4ic3jaRrZEZ
X-Proofpoint-ORIG-GUID: IqEUWu4sbUb9BuyD3Y2Yf4ic3jaRrZEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMyBTYWx0ZWRfX79NWa0TzKo37
 4+eT3x9dXXjLXCJTQwLcH+tr1wpat9BopnZkjw+tEa2U9jZmLN97Io9QUz7LUmgzxCrYX4viJyp
 cd9pBTlkI/nBmaZpfR74+Gzv9PtJkutknA53S9xUmNU5J5HoKd85RHWIUxxQvTSxKW4qiHKL+Sg
 W6qpoEAVw3Qik4U5ayqPWVzZ3AWdm6nR/G/IvC/JjagYynuJlrYeEpA2Z1RtuQO1mR50OsY1r/r
 Me1Sm9b5PxbCZmG0I5HDflkigCmSHrFwaKE2hfmMkvK1SqI37q0GhEaY3iyFUIm4DEWjyaNUr1h
 kvtemYLC4kk4v/gdU42cAXr/SbygaYyRh4NR2WaSXCpv7f22VpbN9nU7aMyfjkG6hrUBQ+zOazn
 q5VWFR9o/iZ6E4ah+FJ8j7I9lAgmSDpp6mUjKaYwgDsLwliz7fuZXyksstVYDAXi1palHCRSjj+
 LVIWU2VxrUVGv9TFlpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120033


On Tue, 10 Nov 2026 11:01:10 +0100, Bartosz Golaszewski wrote:
> In gpiochip_add_hog(), parsing a device tree with an excessively large
> "#gpio-cells" property causes a stack out-of-bounds write when populating
> the GPIO specification.
> 
> The value read from #gpio-cells is used to copy the values into right
> places in struct fwnode_reference_args but that struct's args field is
> an array of size NR_FWNODE_REFERENCE_ARGS so a value larger than it will
> make the loop write past the end of that array.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: fix stack out-of-bounds access in gpiochip_add_hog()
      https://git.kernel.org/brgl/c/f8a4fdf57cedb9cb3f47d94269ff27fea8e819e8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
