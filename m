Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659890;
	b=lV9J7qgVHSbcMbLLcmmw4pJusYrvP04Sqx2OAnqgGFvyOYI/u9h9aEwTtmaOUD2aS5d4
	 tUhG/l5IFHDKTct8kt+h0iJKuPXVB3EXeXunjgwSH1s13Sd4gY8B3BlMnMIFIuL8LuHNM
	 O+qwrUPxO8qiu2N9QqpFpFuAqFtKociqHt//HSj57+tj+oDF4eJx+7O9G3dUmDMjafjDN
	 fG+oF5PYkhXevuMsaIcuGTWrP89u6fBBANo+f4LC8IV54okRjvVpIrhM2Xajr5BQdzdud
	 w6jR+ed0xDwp6xI/RjnokIvoa+B60pwTw0lwEga4wluGA2kaWQDrxe8WnyoHXBlObfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=D0SnzBaUgKaKCBmz+EoWBqVmXukamKFPd93LngtNdqQ=;
	b=0AQrlfKAtcLQIRDi1pUyJfcHP22O+JmuYC0qwIZFEnK03SciEwQcySS1IzbbMZSPzuzy
	 STsDb+AA7TJVIMSBG+eHU1r/MIfbrib0o32bJsvnXJbf4/QMhdPvB2pFV7RcUf1Lo5eDL
	 6bNJcL8tWEiPAhJcnIgAysaPEEORNTG7thurv10YvK0/6dXmQR5ASt7r6tGm8mcmbylHg
	 q+quAw45s/taBrb0e60K1PyObeb5+etclUf18zVTKHfS1IvWy3SePsr7UTwc3IJPYJWOq
	 RqhZ6v0kjrmkXirUH62oS/PAr15mDj2DYsUOb5EX60k2UyQsadxNpDCTWoraWqits4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QEbChZoX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZLKrdxy;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616F6606A327
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 616F6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QEbChZoX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CZLKrdxy
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M708Wu3517415
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D0SnzBaUgKaKCBmz+EoWBqVmXukamKFPd93LngtNdqQ=; b=QEbChZoXe8SUQilQ
	v1DuEY5ECmVDOGhoRCzNdIMh1N/Ryw3mScFCEO4OAfzCVJg2H/Eg486DW1hyHz21
	0I4WgaeTiQq140nHo2pObmyJJLDzs0u6PQW6oOA758cus8KQJIO7yOiNej/0gNQw
	h6VoFPyBWUlrnTCwMxjKua9/+RfFvDDGITtAwqe1YgzerP7TtaXdLNOkeRnl3LkJ
	ZlRJaAouwQSY4pJCYRrGG5rulR1rKvligTj8SUKbgxnDqRaC8J7ext4KxptOTpHk
	TN8D8uaWbFlpq2F5um8vn3EmbsS2AicPl8ez9B/bGZOJ7C3E4AYur/WHbBXX5hWX
	6Q76NA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bhjgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:04:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93edac58b24so43587785a.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792659887; x=1793264687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D0SnzBaUgKaKCBmz+EoWBqVmXukamKFPd93LngtNdqQ=;
        b=CZLKrdxy+l1e2Qn1k/dbarj/CWmzSzPXXZOnkpqOdGQ+sJXYfZsomv4QvfRb/+sdfM
         cczX6Hbw5wf6fWFNkc0kVol/ivib7jgARWNMyS1Uy0bJVkgYILyxxIYOw3c5KHw2+rOQ
         HzxEnWTMXCZwxe0sGoS+5aAn+PTXk9x4VJVhwaftwjl/I+Npp/PpPrBPZAdKOujwQt3S
         Mvmv7r5xBhSZIyxgBTCzVYP2EvHzOhARHUymon2JC4jXYAF0ds4n88iq+1dFa6qcNbjo
         fHFwuDEzyHBDJOpgRy+O8+29Nh9mARb7zL/rhS4usQm+CSZClLW/KpVbYA4GAJxIiAK7
         53hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659887; x=1793264687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D0SnzBaUgKaKCBmz+EoWBqVmXukamKFPd93LngtNdqQ=;
        b=dHv2woCu59cFI6HC0sKudjqnFlTO4+04t7/WGtG6PiKtVZizpHTy7ha5LtAlq9wr7O
         Xll5vsM0oMnQtt2a39aXHJtHhIRIuW8vAI/JAGA+hNcFRglZdLPi3FqsecXz3ppawhHr
         I+D089RXcvwHg7uSnZcNXO8FDlmu1wWNGJCdHqOfDLJ3WMa0bjZTRNBQhR4j/II+BtXJ
         YJBJQZbq9HkXZ9pJ01wcHYQgjUmKHiAjRlxeh2m7HZmo8YY2VMSKmWrxqhkBvKIB6qad
         jpJof9pCd1zRvZW0GPSe8WSx9ZkGCpgiFjdNw3bcKgF+IGpH4qx9xMGReEpCvicSp9WT
         iVBw==
X-Forwarded-Encrypted: i=1; AKwUvBwTrJ1xzF7lW///IFclv17cF2n4bRoYs/K1JMJB4DVNTJwyj4trA8cKUoHz0i5POJWpN9wL27o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJB8wNJgnsNFQBmte9znys2k8u1Cm4gFEp8e/Y1HNZYmKDCfWmG
	vcIRlZkTPTKq/VW667hJWwnFjhsMso2j+eejP75JvYM7TY4hKKBPyNzo7bjaEl67nEkl8BIigms
	nKvKQZArb7VNNR9JyGFL27rK7ffZyZ7dXKKFUUD/yMAvwtzh1G64LxEfQdn4=
X-Gm-Gg: AYBFou2rW0W6nC+is5cUpO666pPTJk42tRNK/huTVKIvzq7bcbtLx7xLeaIbYemqttj
	zAwvDG/OkNptxOo/k1ucO2Pmmt9eisr4481VBuz8Q+OlG8ftmPRsbCNvlnevPEn8NE6XDwk+C5K
	tY3vcwulkoRrR8pKYSTxy2tTTgW8y5z7+FtmpqV1lBIOBzRzLEn7VZOJ+a7j41g6u3iErw7+/QI
	eNZpVgrf5GQ1Kzx+8VV+Vkaef12uusK1OCa5evFnED7zdy/uRtAP8QZsz4OkKRM7nrq0Y0w6x1Z
	IARfccI45vxAuGMNfs1FmdqNyhp6y5kWrRF+VjbLmnPwyeI83j6AVxHtuovC22gJ9j1bXnWiu84
	qYE9x6fzavbOC3138kmxf9g==
X-Received: by 2002:a05:620a:2b91:b0:93e:e111:2771 with SMTP id af79cd13be357-93f57e9331fmr986294185a.2.1792659887585;
        Thu, 22 Oct 2026 02:04:47 -0700 (PDT)
X-Received: by 2002:a05:620a:2b91:b0:93e:e111:2771 with SMTP id af79cd13be357-93f57e9331fmr986290685a.2.1792659887103;
        Thu, 22 Oct 2026 02:04:47 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a5e13d2sm81040666b.72.2026.10.22.02.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:04:46 -0700 (PDT)
Message-ID: <39e5f5de-c9bf-4817-b0e6-c598d421feeb@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:04:43 +0200
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
Subject: Re: [PATCH v11 2/2] Revert "crypto: qce - Mark QCE as BROKEN"
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King
 <linux@armlinux.org.uk>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Birk Skyum <birk.skyum@pm.me>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
References: <20261022-qce-fixes-broken-label-v11-0-0d33c34fd0c3@oss.qualcomm.com>
 <20261022-qce-fixes-broken-label-v11-2-0d33c34fd0c3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261022-qce-fixes-broken-label-v11-2-0d33c34fd0c3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX7Vkw0qTykV4J
 HaxpbdHWeW1WtWvLfvJXGseMsGGcepDMOLmVMpMB5VyPu6kvUBSFN/8KtGqoH1lXR/FJ73PILeB
 6vVDIrj2k2mlxx5BDQ6dhI19VCgfkcP0Aw6HS0cm5nYVCXGy6jl5jUyV1R3BJ/pJA0p7PfrmZRo
 hkxvCOzFksqHYl6HidHHew/JzwfMWQ+vWlsULr7T16M6iDZPxiNZFb2zquOX1wmbpQZpVaV5c3q
 d1q5JDFXvn79NAYaELZtIdO/uSWi8LNSBSNtRlEN8gNx9BCRiByRQdyiRL0IojftBePtHmFSNOz
 UFc/Tqyr91/jafBDXni0/3kCEAWpDWs9m6s/x97OjqLq+8eonK0wotZucxx8IcsqbqjNUP/bpMP
 iiSfX/UITS0TFkBsFwG/FuPsLOsG9OyXXMIh4Nq6fyfGgOvHxMSqnXGZJnsPKEvVBBLGeSq4bnH
 oobf47Pz+amyczb79Yw==
X-Proofpoint-GUID: fdpqN0_f87iRqQmP9QH8JAIho1aYe1g0
X-Proofpoint-ORIG-GUID: fdpqN0_f87iRqQmP9QH8JAIho1aYe1g0
X-Authority-Analysis: v=2.4 cv=CMy/zhrD c=1 sm=1 tr=0 ts=6ad9d1b0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3IWs9GYwE_XJkEP3BLIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX++9nKv5PdAzU
 Lg1iu9P+3JKMRwM3D6QSqpJ8LPk+yzzNBb6OBfU56t65N5UuTMbpJTVW/hhxuO60rakR3Jw14dv
 fqwYRU/O0cz7RSE2lPEa31Bl4+RVLy8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036

On 10/22/26 10:58 AM, Bartosz Golaszewski wrote:
> The self-tests for this driver have been fixed. The crypto algorithms
> are only registered if the user explicitly requests it with the provided
> module parameter defaulting to false. There's no reason to further keep
> it unbuildable with the BROKEN label so revert commit df373d39c6f0
> ("crypto: qce - Mark QCE as BROKEN").
> 
> While at it: update the Kconfig description by saying this is an
> "offloader" and not an "accelerator".
> 
> Cc: stable@vger.kernel.org
> Fixes: df373d39c6f0 ("crypto: qce - Mark QCE as BROKEN")
> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> Tested-by: Birk Skyum <birk.skyum@pm.me> # X1E80100, Lenovo Yoga Slim 7x
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
