Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205A361956
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236835; cv=none; b=RoT4e9RklerWYHB9DwTBbU66CtDkoI5vnRpqtJaP7LhdDx+Ha2d+SzCx7EAGleiGGh/DFZMILKqViZ6+3wQbS5FzjueiXKxZOM9UjZ8JFU1PkPqBVgbqQPj8yOJjWYt8BJmfiMBRlZTslcdyzE1n5ABOskJwACu78/va+UyVZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236835; c=relaxed/simple;
	bh=Ch0bNTUrZrdhGWjR+v/vzmIz0s6OQlTQ1MsLie08Hls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc17f4vBJ5Lmi/bysg3XtJlFtThEOj3c4FtZSmzTpRctkkS6R39r00WX2JSpkq1OkK1AmC+Srj6y72gOTVSDwx1mxtUWWDtBFj8ov+O9h+fyoqTTifrvWflVur2vEatmk1aHe8tIELCyYdQCz45ssQwPoMO7BmO4ss0R0oT4VQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kPH/9l1m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i+Ykh1gE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kPH/9l1m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i+Ykh1gE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7WSe3559817
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bULlRsmm21KR6nA5VCIlR2YU5yJGOIf9AWnYowD50+A=; b=kPH/9l1mFLZiX2zr
	TObXnAxpjIee6cv16jNerUkFWh+5Lj0neZEOTLePNk3YvmX0NYL+mmXoGVBiz2EG
	iAnEI6Y0ZYjqkoeMsUF2lgRsLS8AfFBgJ7hcPHnXZCsODBXFHKvyKUO5wr0obYOy
	W97g+AjwZWNo7T2zdAQf37uTrrzamFpA1WmbKAvmSh9GZ0wseELGicWcaxRfeQZm
	SfjlgFxLEYCGU8i4asgsuJ2kAh7V3tNeRQuUbUW0RK/vA1SzXq7mFbRkMtAwjrON
	2LJjCToeg5/FqNYEGkHFkTAQAsCYWD9nx1pdj9+Rp2kj2NHvxIeZKp/43gefo6VI
	Syl+Ig==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk19nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:40:32 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97c3746cd0bso8375241.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787236832; x=1787841632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bULlRsmm21KR6nA5VCIlR2YU5yJGOIf9AWnYowD50+A=;
        b=i+Ykh1gELlgqjFmD+T75hMNrhhrKyU2cDjla5wUcGW9eGrYuZkQWsRVqryzzh7Mo9W
         jEPto22SbG+BLJS+Y/B0BVYX4niM1PGv8aySkptNj+CLl4HUsqmMWgMCncJLAcRpLEm+
         cU4wPRXcFY9KSfH7pvZZkgKYrYo0G08hvwd8OlmGcKZSCSYSPAkeOf1x1y3K7gn5eZRn
         oV4u6knRjlM1wZ5n9gpY6k9gEOoaDMLgYZs4B3QmS4dUBta+ZtJxgTXHJH8MK5NvfXO8
         XrdN2RWo07g/caT1ywCUDnCxFNUGazs7t1S7CTzpkv2JAv0Bmf7/BlWKsuqY2ZOevjPF
         ZVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236832; x=1787841632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bULlRsmm21KR6nA5VCIlR2YU5yJGOIf9AWnYowD50+A=;
        b=FJX279fJTHWGtf7W80/Dt3KZ2lEKLoeYQ4malNM61Z2/U2wRiznVTQkmuIYiyk9oA3
         mvK3ja/ppapgKlKJQth0nvFN2nKR9WiQ23Z/u+ZvRVWdwTgvjgGrKQts0OqNSoqbWy0h
         M9t5JZ7JAjCxSff4o76gSDpSfZE91pASketRhWVAh3ZkAnhDzAW/CGTNVuvbG0pSrDyF
         P1EXp8r1T23j5YApIARB2gUHfvzETAgt/PoN9UEX2QKdP3mbHJ/QzAzkRhGEryot0gDd
         6DYut2Vsh7MbWI4mtuWNvO3Dmr15WMd2O26MiwFtBpqPdZi/iu9uWehWIls5wHgDV9/c
         blkg==
X-Forwarded-Encrypted: i=1; AHgh+RpJKG9ppkfMDuL0kqzukrGW5StisQfIkyJFHXK63z/cV3FQ18RytIj00/OPiIL3rStaUIXVRsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnh5UlLNkVebvAaR1bZ3vRc+ss//ofH3SClIjhukZYCZiG60Q
	836jDvMzzZ/o4duZv2+oTMtykha57Gwx3zoX8R2DwYU8E0t1+xwPC1IkwLrsnsVM+dRkkaXJ46b
	u0P2n9C9bs/KytUVKtvUa+tu+75O0PWcef9UNM2+c99CC3XTGcnLa8FgODMHOB6FrZL0=
X-Gm-Gg: AR+sD13nG+90eSsaZxoHyEp/5zFkZzwuwtnMk50WQg5FDEN7n7evZgsRRTvjm0AObSu
	u1PAUXXzs7B9XZKO3fpqfGaHgNwLQHmHlSE+TFrp9yijAkB2lvOZfxBdA7w2ep7bJYHI/gbbwdd
	o0U/DyNoxSE/PBg5FQN7yMoGTfpATqzfqLIsidQUDngOkmxAFvH2wdQl9PCFGqtWJXb/tqX6YPd
	gp4V+Kp5aCC0t2G8MGwp0gisztsUiOOclO2skVUxyQ7fn/W4OJWyTrkT7eUqvQRe790LYxCv/7q
	dPxwbXFtzX6odkHmL3v9n0ahhRwBdRBnpxEQAVkmDMes+I7PZOaGGxC39fJbOJAT6XZnwk5Z5z0
	uKsC4P2jNca0nThe5VcDvmnPs
X-Received: by 2002:a05:6102:14a8:b0:778:9d46:6dbf with SMTP id ada2fe7eead31-7789d46e53cmr1458791137.1.1787236832104;
        Thu, 20 Aug 2026 07:40:32 -0700 (PDT)
X-Received: by 2002:a05:6102:14a8:b0:778:9d46:6dbf with SMTP id ada2fe7eead31-7789d46e53cmr1458778137.1.1787236831752;
        Thu, 20 Aug 2026 07:40:31 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478860c85sm1333752e87.35.2026.08.20.07.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:40:30 -0700 (PDT)
Message-ID: <24b878e2-6073-491b-a454-efbd6c21e89f@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:40:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] soc: qcom: geni-se: Fix endian conversion for
 serial_protocol comparison
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com>
 <20260820-fix-write-to-read-only-firmware-buffer-v2-1-7badcdc455fe@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260820-fix-write-to-read-only-firmware-buffer-v2-1-7badcdc455fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jtGD48P_mpyDkkWTbtg21SFfqoVlagDO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX8pftZDbF5Oi+
 6R8hM8/ro405AUDes/irB/aceBsNYrqEE22HQY40cjh/ImJZ9rdpmUuEMBO3Bha8GN6o1qp3cVM
 aT47ivKTc42Wy94L6X6k6MWTDuaGkKw=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a8711e0 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iJG6fKeWqX_QHOf8h_cA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX0rvpyuZDeuoT
 2mR9nFXrGx5f1WqE5MwVvmqubcXopYIRVWMsX1Egwf6h9Na2WFv3zccVCGkdwjky00+q81D2IY0
 OtIK6hdtygdGC17meimcoYXACzrK5jiQdSwA4/apLd3hW5kbU9bUc+G2QitSRxbkOtWJF/wW3AW
 gc2wJ8HSigb7Hor2lxANjH/qjij3HLZkS6bE9YNUPn0BOdUSa4xln/ZmlNvwpIp7Nmx4L8NlbnC
 r6Y6wMG/vgarQhzN0nJjNTFAZ5O1ZpyZbGOnMxla9xwEGOqL7yd3KRvbnbgagfCsaw4PxJ7RTYs
 Hum8uyDtBXOJLSBFyfBmQAwmu/VDHzh3DyiBwHaI7NQv9/78DG/Qty2iDhdJrxDG3qSqbUwLnmc
 9NijXb2jJ+/mGc/IHSbQl/X9uHPUvL12wMUEJE47Ulrk0AdTyD1NSVxEtVOfjXHz4aX4SOjkMYA
 IkPdesShlgaLEN97qxA==
X-Proofpoint-ORIG-GUID: jtGD48P_mpyDkkWTbtg21SFfqoVlagDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200109

On 8/20/26 4:30 PM, Viken Dadhaniya wrote:
> serial_protocol is declared as __le16 in struct se_fw_hdr, but was
> decoded with le32_to_cpu(). On big-endian systems the extra byte swap
> causes the field to always compare unequal to the protocol argument,
> so no firmware segment is ever selected.
> 
> Use le16_to_cpu() to match the field width.
> 
> Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
