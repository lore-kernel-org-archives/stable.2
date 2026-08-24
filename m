Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60F330B30
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563375; cv=none; b=PZW80thjOlOyzuIsWP3SFP1V2OvWwUrGxORuxtrSfDN16f7/IZ/i66SN5XyfsTbcAQZRKnnNjyqOUoGFfIbX740QzJOq6iyKQwbiBlYeE/5UrtUjTCOSgO7gCdOLA1BNnHWU/RMRAzrQEMBnYewu3ksMsNQoav601vnjfCIxaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563375; c=relaxed/simple;
	bh=Oip9GBI6mALpKmq9dgyitq6Uj+sBoyWs5jaVXDmyBUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVUo1ZziFVYMJZ0t3QEOyTrsGHiRUh/Ci+GUK90M6da/q5tKYGUjtpqV43lrMwO7er5SOpXHbEgngqJrDJagTbTj6WXe0iL8Y4s4Xb0oLXCrv1Xt+DJYkqQUNrgzdak82GERdFpiAOeRn07AHc5s1SZUWeqQX2UIjnXiGv5yJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GoPKN2Ys; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d4P5pUJE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GoPKN2Ys";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4P5pUJE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9A2GP1509602
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L1VbiPgmhqGT50egQYPEisH9b0+8udwN8dyBpOi8YZI=; b=GoPKN2YsoZ1Ncxq5
	Mjs8jTslU/ZT/BXIaBFrlbt+3n/FhxGSjZ1GsPknYmQt7U2EyFHSaguo/pJbLaft
	H9axYsH0KFUBct8yOX3FTqztTPFMsD7y/d3U1k/otTfYqvAHWqr7UQQBD1FbKLeX
	5TGcXgw8CoMvgH3zm3KO0NTlZdQn/yP8UWOwNBbe7Y1ybhKu/tRZekLZbcHSFeis
	3kzaiUwOes7bb2+S8bVZma5BMuDzBKnXSm2UGBeeRMO9N/wSHT02jFVBmoxF/5qB
	xwmrSzrhCW3yFWMjrYLGGGT1pNrGiYlI5xZpN2jl0Sro3wjWxZjoETHJ6xh7iG6w
	oeRsbA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhe9dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:22:50 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-756fd28d906so81030137.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787563370; x=1788168170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L1VbiPgmhqGT50egQYPEisH9b0+8udwN8dyBpOi8YZI=;
        b=d4P5pUJESNih+xSx1nPit3irRuRouWq1at1QX6X9gSGq1ueqdcIBP6bdlkf4PsiD5e
         M0ifJ1ueW1q6VVDRrB2oXzijlI4D02IKl2Y0lQdUmzH9XsITJKbgpe+NxtS1ZVL2umls
         Ra1383wVEBa4NkgM7xjaPeKErNjnbDrTONqOUIODrUBYlvvTDzMY5vjgyc3DTb8jdoRI
         sDIkF9TyKeYF/Hia3SxN+rdJs8OEyS/1NTG8kbFS1UnCMkELkDuHwUJsK+eS2t/LAMwp
         8hcd/KKX6tpbw3/9rSW/01kXGsU2ZOf3ZxTPvr4rUhOmgme2hSDLlDaVI5gV8UBuCkB1
         B+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787563370; x=1788168170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L1VbiPgmhqGT50egQYPEisH9b0+8udwN8dyBpOi8YZI=;
        b=Kj2tquiDDDY8ZDimU4x0AyUezu7Hc8zQbfrZo0D9Ru2LSSyjuCzLzTJgsCC/eZgcvF
         yaLYUEl6w/494xsqwD5S8nABudoSKXQlc+LOXfn27EuVCRinxJ2CRNnSH1WD32klJlQL
         zU3t+YpcywFWiYumh6QH7t5DIifWABUWLauNxbkMGkarhaYpLu7dK80vY7kLH5P5CJoQ
         lU9N6bQ/c8/XPQw3aCN8i2BVUNJ1FkXreZj+6V8RQiH4/p9VDXA01/Ij0C946iCl1Ew9
         eqSS44kHSQ/hyaO2GCWC8m3tzmGJ7wLVgnAl+X21AXKLsfhZ8Z1Voi1apuR6Jn+NhTez
         0IBg==
X-Forwarded-Encrypted: i=1; AHgh+RotWJaIgBW1jNQSBfIglzdPbs985nM33U3rIaJoceXsEq226dHBobFegrDHRMWtNSLNo6RLUxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nbvq19qIGcSzHK+mKloWKOSdGXivhO3smn2Au9UA9g/PFzu/L6
	Lbdir2lBRG6j0cBWTSyyr5V6tuYm0UgIWUTmNFSuOySKdWM4t2NTA5ychf3s9pwsorXM2t3Bm4g
	rU3aYfMxkdg7bCPYzo/4RV2YRdvXBuGWgFsX8Qo+WmFGLJ60ToSB1i84xumI=
X-Gm-Gg: AR+sD10g1LY80TaJoBqb9QS4ZbCGz/tXtVcQwLQ8pQ4vG7hqZ2dcpJF9uhXNRltE5Gd
	QK17kAHJddXTdVkTfFPD6LeZnT1cOzYU9uN6gSB4g6rigwpRodQ017Lp9BL40DYrLOkCIB9yWGl
	p1/3X4S9Nb6DwRTWimkR6nEtqXgjs6sxr2NdniSWsJLkxQ49JYW4wtCP5R0ezc2v5z5qXyP7eDZ
	z/X4Zvb1qYtPVoWrUI6/2xoEsNVS7gKRuorRqh4XhvJNzYahFhLz6C4uV/ODw+EKizYVB+Hm26w
	aLZNlV94APuidv1BvyqgU3TA5dQZIWG+SEhdDKgOiN8TwaGDcUIWqUpTpxzu9YYXhyln0tTdET9
	+RlRXJBVx6Ux4Ct+HFdCCnVv7
X-Received: by 2002:a67:fe89:0:b0:77b:b14e:b72c with SMTP id ada2fe7eead31-77bb14ee6famr1714031137.0.1787563369794;
        Mon, 24 Aug 2026 02:22:49 -0700 (PDT)
X-Received: by 2002:a67:fe89:0:b0:77b:b14e:b72c with SMTP id ada2fe7eead31-77bb14ee6famr1714021137.0.1787563369384;
        Mon, 24 Aug 2026 02:22:49 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e0190d3sm7681403a12.9.2026.08.24.02.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:22:48 -0700 (PDT)
Message-ID: <fbeaf7b6-8eee-481a-bea2-d1468ced4677@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:22:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
 <e3b06684-496c-4efe-9bc4-65d29583cb7a@oss.qualcomm.com>
 <62eedb1a-1da7-4e65-99db-7c510844bd99@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <62eedb1a-1da7-4e65-99db-7c510844bd99@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jKeT8SdZYsqsGbJ09AK7PwWiZB5nNrK0
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8c0d6a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6pWSofttRPDz3FuI-oQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfX8YCJcF4up7VS
 9lsZFrAkbF6RaS8bDiSnCU9ySucGHBdkJjxk+DP+jLTrm9MWRxMV0JpT1HrigHge7H1xjRvied7
 neKd/KEeCDOutjT6qi4VW2WzjRcJNhu8EDocex+L6n252Gw++BjJIS+NRZdDVanqE3GrDpjGbBq
 hIjTOnynCnJUR7hoXBY/ceLuVOKK/nsOgYnbVXmDFeJ2lFO4vT9k7+N/B6rub6TSIqkQCwlg8CQ
 LHMRQgxt5ltgA+hvJzHLeoFn4ah1psI4OrjgdEQ4g1TrpucMkGz4Xtd5XCB766oFdiZQ5EF/LwP
 MmStJFKw3f4HYxZElkzdd24uSnC7f0xUjq/lJ94gF/AFzRkcvCl9DL1J1vlf6+a1rXpyCZwxZwd
 LyFQo4r7Qxd7DkSufVOnW9xhPAB/KsvYGFWiYB/Usb7Esx6D6T8zo8kM46cZH1UhAh25S/XD8je
 Xos2x3Av9p+/4adEhMw==
X-Proofpoint-GUID: jKeT8SdZYsqsGbJ09AK7PwWiZB5nNrK0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4MiBTYWx0ZWRfXzxu68KaGUhfR
 u3ZMhRc2DKkH3tXGKEWZAhZEYgFEjozDiesUMMGCoi2fb+2Hk0JbO7Ue9f/4vUaIwfRfPvU3HOA
 L0s26WbQzyyg0Cz9QNvY9Vx2YVJ0cwI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240082

On 8/18/26 12:58 PM, Kathiravan Thirumoorthy wrote:
> 
> On 8/17/2026 7:25 PM, Konrad Dybcio wrote:
>> On 8/12/26 10:30 AM, Kathiravan Thirumoorthy wrote:
>>> In IPQ5424, to meet the setup and hold timing requirements in the
>>> standard mode, update the frequency table with the values recommended by
>>> HW design team.
>> Does this have any ipq5424 specifics, or are these just adjusted for
>> the generic case of srcclk=32mhz?
> 
> As far as I know, IPQ5424 is the first SoC which uses srcclk as 32MHz. IPQ5210 and IPQ9650 also uses srcclk as 32MHz which leverages the same SCL configuration.

OK, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
