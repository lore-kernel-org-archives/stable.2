Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4044F38398F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417471; cv=none; b=vBJl8P6rs/XnPvZ71LnOVhWj4+XY95n8Ubzo7oMlTqJhHjitjrsuQp7rCz+eBpuXoz5TvRVZl+3/5YycOyd26MQ00PhpkJUnzIh9KP2Ya0+OAJ5bVw9FDdaFmqznKtEbeHk7YYsqmPL7lLs/B/R0NrD5OU8bjZ4cv3+m8BfZbf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417471; c=relaxed/simple;
	bh=nZHYuewFovLeJ+5naPia4RsxMaLt2TuGBHxq3tZ9DZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtoll21zgYvm7/M1Ciu0MabxfZuvBNasJuwhqWjW99MoB7moDlxPWajKT++suwvoSIaYkLVnaBkWA3aMjuDj/Dnpk5YORMMPITDaUlXc491jCLjgr6lgyE8UdyUlo4Sa5lshfbc9Rk10XWcgCx/lyaJ2d2gpgNkkmIgGrsY7tz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gQ29/Lxv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G8uscEv0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gQ29/Lxv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G8uscEv0"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835lds8722051
	for <stable@vger.kernel.org>; Thu, 3 Sep 2026 06:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ik3oRHbjgtPPFglG5IuBEq1H2VDBvy4OmSK4g3fZNu0=; b=gQ29/Lxvw3aaA9aF
	S6HVwiejxuZ6+3MXShztUOQM2QUgqxM4vEJXq5P3lSGhLrulD6bAjDFbykrDusgW
	2oLk6AMkIGNF8Rsd54hC6AA9bZ+Y/5ttGUSjvNWnvItf+/FbnIhNtMUdaGvYzTrb
	Q6MPHSKGEIEtP/EzoTt8zQto36q3QMjPnRZNZgaMEIBHhSTWIDZn5tfZsDEvkJje
	8ReyRX2Brcy0C+Gz3Fs8Q1tc04rylv/ggJB+myQp18wVhDQ2KA2W04OZs/V2KDH7
	pgN6NQaBGbyX1JXdL2gjqVmj69nPLTQDgwknjw889DeuOg5CYbF0zq1b4cl9jRp4
	jvilFw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnkmue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 03 Sep 2026 06:37:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ea38b1e7eso4779911cf.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 23:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788417463; x=1789022263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ik3oRHbjgtPPFglG5IuBEq1H2VDBvy4OmSK4g3fZNu0=;
        b=G8uscEv0reXko9JGWWV0Pbr305oo0+T5a9p6ZvaeYBWOaOchhtJRl76mfSX8Ghk2Dy
         RPNfn9+QIP8tDhEp1EwNk0BsceDMULjg+PNhTlRHavMfbUMxmFmyZfOCmrmwDhtrumQF
         xcGa6qz+UR7gLWZzCS1QFp9ZrIFEEVpH+SZ4D15jQy9gL9QTHP+bIQiWf5BdY7CRLV7f
         hPwovIkc6BrYcnZTl6I4BBwzhIPjZYu5DvJqlXZr+zkpzriaPc90ifhvhkIi3GIdbTCv
         34jxKWJrY6SsMUOIuwnPlEymPgRryQBBaUMJgR4MfrB+F2kMb10yl4QOn328UoSAZsNC
         +WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788417463; x=1789022263;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ik3oRHbjgtPPFglG5IuBEq1H2VDBvy4OmSK4g3fZNu0=;
        b=Gi9UnQTr0UgSYGPZwvbctFBaDjUlKzoqlfTmWQLQ90R/4s/VhYUt3QapFWDjRb6smk
         u9Ab2t4G01j3Oz1eX23cPtfWC1Vhk8Z9qftolgKCwsfoKYq//ruBbS0C6uYB3av0Gwre
         lxyfVNVeWq4yg3Dr4iyBErbbBWvYkzlMksZyhJDrDt1ef9NdYFEt8sqxa3PaU/vdWtPk
         O/iLCsTocyxHQvORxK4jZv60moc1PCXMydR2qXAKkcKq8scNgS35gDNw6Eils77/tFjB
         guk2SjOvwr/zR9Vpakniyqgnd3Q+QFilpK1Qc6J3k9iIrExZPWWxzKyp0Ik6DospFP4h
         WWmA==
X-Forwarded-Encrypted: i=1; AKwUvByJXuqV0i5T8BCZL438J46JS+Dcxwo5tebKETu7NQ8pmohl8J815874DN2aaIgo5Lf+b6yJRFU=@vger.kernel.org
X-Gm-Message-State: AFuF++m7Mh91tVHbhK7FrsWEYcQecxeBKiLZHDijPkxUn3eijI4fy1X6
	3504VSNX+RIvpzGGlRB36lJdWYq7tvuMV8gkkCqJMkgBzFfHIAorMsLXMV+4hPG+wKjRJSGtENM
	ZP9EnW8HLbNMZmDNEpE52JWRFwqJXxOpadAdDarMFjVf/RAbcxJ9WBK4yb70=
X-Gm-Gg: AYBFou3EsDJH7DjzRsfqJ+w+LmUk77Q0tZkLd05xaElYn0Q38nqIJoRgyoB3swLb+4+
	4ccYGE4afFU4MtRRVhSDZDS0H/ulhQWx9fVenqr9nEOFDEi2X2jZrVcmuxocyEkuezvPc0rB0xh
	dgITBQIR3STZ5fjXqmbtGN1+4bvcVaBLPBr3jzwPV8qZjb6JdP8dTWwPCiDDAm2uSXT6Hhx0jpH
	AVgSieDOCBdBEyGN216+mRlMsJtgSBRTyu7gPerzF01iLWUIHRB8r2WHTojEOi/p+iLp9sHuYE1
	dNNABpoHdoXoLfMwVTKHI5TuGLXSBQ1CRp7o6UaSrflo1eRuzXrBQb5xXT8MYAO9k5m4eEQBrAj
	wazgf7UFQdoH8tho7WiURiA==
X-Received: by 2002:ac8:5a09:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-53036bb138bmr73180751cf.2.1788417463393;
        Wed, 02 Sep 2026 23:37:43 -0700 (PDT)
X-Received: by 2002:ac8:5a09:0:b0:50f:a53b:9d5 with SMTP id d75a77b69052e-53036bb138bmr73180561cf.2.1788417462938;
        Wed, 02 Sep 2026 23:37:42 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f953223sm1781245a12.28.2026.09.02.23.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 23:37:41 -0700 (PDT)
Message-ID: <c4af75e8-5049-4cfe-a333-5c2b58e1da2e@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 08:37:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm845-google: Set i2c3 frequency
 to 400 kHz
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Acayan <mailingradian@gmail.com>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, stable@vger.kernel.org
References: <20260902-sdm670-sargo-nfc-v1-0-bed1cbbffc46@ixit.cz>
 <20260902-sdm670-sargo-nfc-v1-1-bed1cbbffc46@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260902-sdm670-sargo-nfc-v1-1-bed1cbbffc46@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VnUiw7_rWodlOBy35pVkT0XApwDneiw4
X-Proofpoint-ORIG-GUID: VnUiw7_rWodlOBy35pVkT0XApwDneiw4
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a9915b8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=YOhxEyfzO7YiFk8NLKYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX2x9A2fktYOXz
 XWAM+wVZlI75vjSsKSeQ2Ff90rv95Kb2IcQ1Lyrw3Q/dKPRZ2CUvL0D3jvgznTfQ0a1PvH/f1Wy
 TUQolmRIs1fFrNmQCRSClEdgDLFjny+oDQx3JRXBVjylLMhBleegVB4zlBg2VfS5YhQAsG3YEKj
 EH142MA+HYrB2WAIemIBavHJl7RV4aYFoX4arkw/6Aa/qKEd3E8JZXCDdQs7nAAH93soVi7Xy/l
 GfllbENcabMsIqsGsbsBK2zaEc+ZRPUVlb05EUBpMN4PYcrlxbhEnqaiOMpnFro2QGH+iJOlWS8
 GZ25ppd1jsogm0WZwIs6PeUCUjZkjiHCjbDG5G+HaqmWwlkgPBG4eUkFfWUT1lqi3Y1btySv1MW
 qntduuDYExgNpS/up8GBOagfq4Bvhf6k4VnsZ9AUGNGXN0pCaDkwsAzH2P++AIgjpqf8378kjyt
 PMJxt8dbvwWir//BLFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX9H/M+p5Y4NBX
 AiPqLr/hzvQW+RsTHHkmIEmjZS8xuKUhUifw2VYMsPQbli9LJjE5dU+DyC8XX4my98Ygi9Zcwjy
 sgzT17Umk9ye7DaZDP4Ojs7njBd7QVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030057

On 9/2/26 10:59 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> When downstream value is undefined, it fallback to 400 kHz. Set it in
> mainline too.

"The Device Tree found in the downstream kernel for this device doesn't
explicitly set a bus frequency, resulting in 400 kHz being chosen.

This upstream DT also lacks it, however that results in a different
default value of 100 kHz. Set it to 400 explicitly to match the
downstream kernel."

Konrad
