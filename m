Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A645FFB6
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787053708; cv=none; b=noAJFQ6V5plhbUJghmuZ76Yb0BWtcdo7fbOM12E9MfzqRvXdY3e7O6c4zOVClOkpyiFJnXf2tzY2Q1wg9Z+bdj44pXlp0GWFnFwf6KED5ixcTqjCla2UWNezZjZwMFHXTnmYXCiYg9GT93QpteWXyGKpJj3/kUDT15iOmUtqkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787053708; c=relaxed/simple;
	bh=00JK8r+xOSOxAAFZmO92NvtQ9aCpSK3VHMbFQ6Xcwsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAlReNHjncKvefVKn6NIDZHMjD60pSPp6uLXrOvYyd4XAyxmSb0xcSSscT+rNmBJ9NcW91Fv49+OEZ/vzqsP8PPdOhU2N/BwtxRLEP/qMiQhhXkaFv3vAsYokucw/LFdsEY6xEgKaOG9EjUUoAV3zNXRf1SMZT3OJW8JeAVu8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=po1LRa6W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TJrx7RCH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="po1LRa6W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TJrx7RCH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IBgQDW1196966
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y6QFDJmo+aFscDi6EaPtAdK0x37xaU22YvjDJxvKySw=; b=po1LRa6W1GNsV/IX
	KLZRf6B9gMOmLluFVmuoYxPyKotJI22L0oEyz5Zcae2TJUhN0H9PJE9GPhRMYA+A
	a0qSLKOj74Qf1U2uLsM6DKPLOs8fhvI8kl43fBUynqwRRnQ5GCkxXG3570n10/9f
	vKUTU3dX8a79RHj5rnzfdh+4n8z1AHxRpuDGmZLzQmkZ6rWiJEUYpoykMMcAKR83
	meRtB7CpaiJ5IlfMHEnczAzsiGJS9pUtCj67IHM/K0/GLetcH+FZ36Ee8WEKwfdY
	COYJAR1y2udl6omEZ50MoxcD/xj5RXWvflNfPiukJXGfELXFaPD9qJPnjf95j5SW
	Hty6ow==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4prn00x0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 11:48:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934a8cd3a8bso46525285a.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787053701; x=1787658501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6QFDJmo+aFscDi6EaPtAdK0x37xaU22YvjDJxvKySw=;
        b=TJrx7RCHJ3QlZDCqpXwoOq40q8RdAQ22pKd7ZOtwooadvj5VgB4YvVawXmHsAXYIYc
         456LR+uXpjkhLwnlEjgcx8ZMdiz+olP3LNdr4+bDUlxKzMsd1tyu2c0exly290BXffjQ
         GoBNagWnFrDpwvsdwFABYOTgPremqW+apw16+Xu+eUf4mtAMePXzEsapCBdy+jrrEXf8
         aeLZKSO1HsMnGjF8g9VBRWkKc7xQUfHlaP6h2mOl4q4cY8xAk+CuSrXoSJpVLWjkm+FB
         hqfmFET4W1ltZE11dgaBvC474ANdD2Wkyxtw4v8Xfdd+S7vWFBh405NiVZmtlw63KXfd
         G72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787053701; x=1787658501;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y6QFDJmo+aFscDi6EaPtAdK0x37xaU22YvjDJxvKySw=;
        b=TLYMWHgX2JW3o/tKY4p9RJ3bdsQczGAWy/vhfLOmQXaBWsxPwcLEYI14AjflvANy58
         aMlP1hRjzkkj5vNTrmjR3ASUCdrmUL5C27qq0BZ8W0Bu9lryC3dSXk0NCm6SqTGvK6g7
         KTv1o02WqZ3UGYbcPgIS6b58bDrfHxJbHll/i56JSGhx8MGKZauPE/vwx4mp7ndzdiST
         mAIzS+JeWyIY+Un1PZdmhok7hoyn8qywFNsen5f6TOw2LKKgUB0LZ2lQ+S/VVkB3hvav
         WPwajYfXsjQT3OzVl8QvLLz/umtpxyfsSwAyxeBmJ11Fqu0U9lWpwcie0Q/T4xTrsj+Q
         JElA==
X-Forwarded-Encrypted: i=1; AHgh+Roe0sFFLM8wfuwK96Fu8adnotUNp9FiqaW6zh1KXrzdCPrM7nhInj6G9srIcZ4msAFpoCZSTLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGicjysPSpCZvsYWeykeJ9G36nu3siX6yhMG4PW7gPvODZ4cU7
	9AL8kJXC29MTn7HGUTyaLA0hwObpsgKOUgsIE41uEHDpynN2fdcxjiCQFN32nxUyT6H1rp2jqe3
	nbso7RqhiOcUNY2GkHFJqWuLlclZXql8EI3BPkdsWecvIbCcPnO2HernR9oY=
X-Gm-Gg: AR+sD13HqR2SHOTl6KtScGfwEpSCjjgOHMVE6UoP/X4KqY3mqWGCC0G8gU64JqVrExT
	3c3l8K1PDjZXTeIGOu0U9jmp0Zhe30xZC+DZfRtc6Z3TnnJyg2cIfnus26j61zJ8VNbZ3je/Pgo
	jM0Ur/pHx9nwC5dwLXxp3KgIlXqXdGtQkNDEtfEsW7tZpFn3360BtJIynq/FW/4fwme6nJJOrXB
	8ayNTDJzt9oVsfHPgbp1bco9olIvV5lHUMe1HVftcDbKal0HBFWYIDmkN0KoqYCdSMs9IT53k8o
	uUl3Oa4CPDqeEkRraH6+7Oz1AheYnVsS8L6wh5G/lXJzEw3PyE0htVAFYX0dkHfQ5PSRUgIWVeh
	GRKp93J9/Kp8AXjPCjUbs79N1
X-Received: by 2002:a05:620a:6008:b0:92e:6071:7cc4 with SMTP id af79cd13be357-936d23a402amr2233062085a.4.1787053701018;
        Tue, 18 Aug 2026 04:48:21 -0700 (PDT)
X-Received: by 2002:a05:620a:6008:b0:92e:6071:7cc4 with SMTP id af79cd13be357-936d23a402amr2233058885a.4.1787053700466;
        Tue, 18 Aug 2026 04:48:20 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fe6aa89sm173781266b.2.2026.08.18.04.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:48:19 -0700 (PDT)
Message-ID: <c556f7f5-a339-479f-af59-e5460606a7b6@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:48:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-lg: fix sdcard pinctrl nodes
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Anton Bambura <jenneron@protonmail.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>
References: <20260802-judyln-sdcard-fix-v1-1-b3477cfc42cc@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260802-judyln-sdcard-fix-v1-1-b3477cfc42cc@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX9TGGQ7yUOHHK
 AEixj58qC5U0MAVI8XXbk3ry3Upm1lfDPk4pTxP9FVK+AoL2MKRXjdssoK+o8HeQ39RviE/m8r+
 84Is+c8keWS7oN4CXidOMTMSbMtj7kU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfXyau6JVg5wr53
 UlNFkMxxM6UEe0RdAdaNGZRGFa/Pkyt1LNXH4rTghHtxzvNvluUlewwjWlx6HB3WPWY6yYlm1Ti
 gK1SHdv7w8G7RcR8Onks8OKyF37D1wCxf+Uk2od1w6lH6MIQTa12aQtnTuqJ2/R05sH9PpkVlRG
 /llKt9TcHB731aChQ18KRkkVHK4EMsPZcqJ13I9NIkG+WZ0uLpOXCgIifja9X8hr72BoGh0F4S3
 HGPVJZ0kcBBoTn++dbhNjxuP7+ih67pGqpIWSse4P1pHg1dzNkHysvPa87LhTFz8HLxmXribpwp
 0KEhq5uAruq471B5vqyKuXXxhnFAphF4gP+qTl1H0+m0OHMwcAhNUPBYiSUZ1gB5bCdngf8jSqT
 IyxNhMXaXitzO/fyTAM9n/HRuZnLhgktR71RXkLNnBSEC0GmFMFDs7O88jJ9pO43FZkjDVboB39
 ctPAnZkBycgUStmJ7iw==
X-Proofpoint-ORIG-GUID: Hyijhkg7Ip0QkOBVNwijkt55BEDxn1_y
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=6a844689 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OQN141zOAAAA:20 a=Gbw9aFdXAAAA:8 a=EUspDBNiAAAA:8 a=4ygO6UpHBw7eDzxwrK4A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=9vIz8raoGPyDa4jBFAYH:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: Hyijhkg7Ip0QkOBVNwijkt55BEDxn1_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180087

On 8/2/26 9:06 PM, Paul Sajna wrote:
> sdcard was previously rather unreliable during boot on sdm845-lg-judyln
> 
> Identified and applied correct settings from downstream lineageos kernel.
> 
> Verified card was properly detected over 5 reboots with rootfs on sdcard.
> 
> Refer to downstream: https://github.com/LineageOS/android_kernel_lge_sdm845/blob/efa8458f79dffeb380d43b38b9403407f87d9f05/arch/arm64/boot/dts/qcom/sdm845-pinctrl.dtsi#L148-L303
> 
> Fixes: 28ae8aa3923c ("arm64: dts: qcom: add device tree for LG G7 and LG V35")
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
