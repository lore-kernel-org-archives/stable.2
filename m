Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE9518150
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682785; cv=none; b=CjYYfkcQ/hRMBaTmfvwxsWWt1jV+rflOXhljSqgHZESRAKaJbe0R5gDnd9Fl0j34QTzXN1CUZ/xRQxz4Yy2LcN+Kr0RQC6YzHwTdOkmLRvN3nxoA3TVNIj+D/jIUN1++l7pOn/11u5RTHBttSLkBj18huJG/YhuAnCmLiXNQD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682785; c=relaxed/simple;
	bh=Qq4LyVpNA3VxrY74dQ66xruuSGokXlWRSJ3ANyBO3G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp6yWMBeBeqQmtOFoWRCH/5a0F9Bp0Ap+3m5W1sDk19Sn8Ema/v2+Kz7O8lPu5aAdnQAvnAKfQVusIcw8xLfOceVbg6xYwuWaBOsDiWrJJtmvzZd9OYNnnMl3Dj22fi7AFsd2iYit3iXeMvI1RZ+T9ETmxT3vbauc1ppUF9LP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fr/eb0uD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SnbRiSVt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fr/eb0uD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SnbRiSVt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAj1Kj576905
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wc8pBobLAB4TatrDh20UoHLU9V5aquvkKxmU9lFHUQc=; b=Fr/eb0uDuIOoxz1s
	57noKmRlC7krHWZUNMOqhCDKFgmqSrdsqW7Rt0HX6ilWZSQP+g1IJJSBPVZY4gt0
	RPfS0bjdmCIk78dBXOcDsfX+GVJ4xw1goNCNAs89N3EZqjUX6OztyzwdeN9EiGuU
	ZCBfpJCZUO5nFqy0BvqpQRNDfdOdwkZbLcRH/JYgS5mKMKoAMW42H6+m0fJxl5wP
	4XctCd3mTpEI6p3Wra8mwmi5dwvLlzyXy8L0sOGitjhqWZzMZeBPPtNko1YOxBGR
	1RTN1HGo3yU677qVXaitJ6dCpqSpximPO5VSxMeK5qNw4JXimmsYnmA9RT/Hhbkp
	LIc0+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0h7jr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:53:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df8484f12cso40661785ad.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790682782; x=1791287582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wc8pBobLAB4TatrDh20UoHLU9V5aquvkKxmU9lFHUQc=;
        b=SnbRiSVtmeMpb5qmiiPgIwk5tKlCxkv+Tq1YYvzom5CDJhtdw1N3C3/xqMcRumKD0D
         7xwA/1KnL3CRZsVudXg7j2yuH9du1PFhqSdEj1aTh1JqXE0FLuSx7Yk4knEn3MK4HAxG
         JsPwlovv95Tz4HVYAwotPFPnwU9oAgfsZmzOq05KGTEVtAZuc4YiZxvpGztmhOG614ok
         xB/nKFs9sizjLwYULHxBq44FaeSbp5uQnE5/9oXir4f4jG8J371fW809IWRpqafzuWbY
         WxgW7/uP9NoMu7jPkmhqf9RAJEiaic/5IqzKB1XU6su1RJ0nLUGv6FUUO9GGPyr5XZEK
         P+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790682782; x=1791287582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wc8pBobLAB4TatrDh20UoHLU9V5aquvkKxmU9lFHUQc=;
        b=tyIurJ6+SdVOfgoeuDgstnS/tHwprnL5V3oqmK5igXkXlI6yiIrxWDd5ylxIi0SQVN
         tS41Eyz48WgnWnnNGBFsrZHFiIH5+8i4pBuZJYYq6gQ43EzrhxjZWfoLNgYL+j/f+FrU
         +TY45C1TqspguRPGnsKjsGs6EGuomSlil98ZN9rSytAI/biC/uKr7PtyNV/lMosa4CeH
         ywrOkzLIHjiTyqf9Hd686YUXXVgGr08+zv65I398UkfzbM5lgESP+P7XjT367mRz0XUb
         cKJhWB5fMOEnkQEFBdY1swOzxbfvI8shqL2IEPbxwP65MmrQZJ1bJqK3igs0TcTDdY/c
         SNTw==
X-Forwarded-Encrypted: i=1; AKwUvBxNfupuL81uwF4E0aDewns+heM4Zpx6oPsDGB6BBWImdXcFrJ6ckUIwkzDU2TI+zw+Ci9M1rJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJf3Q7GTH7FdWodluqe3T6fdD/xdYWe/pk/fwp7BTKp0LA4dFAM
	oA9yt/6/eYaL4xy5hPp+LTkWUYBD+pVRbYRQPn30jsBmUdQ5noQBfmTnBtqVBpP0NBJvqtMse/n
	7GYaZ7Z3dh4xhgn+7UMGDDtsW6VLSdqb5NGMAGOr9EEWoPR+bwdzQzxQ+tZs=
X-Gm-Gg: AYBFou00ElJENpiylRqMutBkwe/DjBzdIE3QrJHkO392pSAK0SKpznuogrrNVoodVtY
	WE01hj7QHbyyI7x7/peaG1f5QLwJslIoiVw9nfXQl/eafuZFs0/eQVVMxYEbzqeyogaMZneUs8i
	GnCcf1sl59x/BSSEsTkIc6t20PxIGfMAj3KVqzfIxk4t+SrR0UfDSnaBxklJWGpocKmkTRABKQn
	pPoH5Qn9SbDbdsIsPC49ixpspqPMlW+bBAReI7FIfMsWQjQfclkRDxOZNQ9rL2a0w1JwWOx3gIm
	xmORzB3+o7ZCZCv3Z/044IWa7X+Do4gf6+gT65BShQFVt0VBqKz/o12ZVuHVwSNyjs3oZdMVVFo
	GljSD1Z/sCMWM/p2oIFqwjaeCDYW9XVLLBqgCC2tUCh2MUveGy8SpuTPFd3+Vk6CP9KC8iwqJy0
	HWNS7b6CU7BNlW4nOlmA==
X-Received: by 2002:a17:903:26c5:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2df7dfd63f0mr137881695ad.57.1790682782192;
        Tue, 29 Sep 2026 04:53:02 -0700 (PDT)
X-Received: by 2002:a17:903:26c5:b0:2dd:c0ff:e727 with SMTP id d9443c01a7336-2df7dfd63f0mr137881535ad.57.1790682781734;
        Tue, 29 Sep 2026 04:53:01 -0700 (PDT)
Received: from [10.79.116.160] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9146ed7csm53972585ad.80.2026.09.29.04.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 04:53:01 -0700 (PDT)
Message-ID: <4ee090bb-b404-4b0d-a239-5eecd93263c5@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 17:22:54 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/14] crypto: qce - Fix crypto self-test failures
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King
 <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NyBTYWx0ZWRfX7H1xPgwLqngN
 6NFYfVwzD4BYe5rZh8iL1fY8eQA4xMX/xkZUpSPIzaASG7xSnJwPojsPNaWdXtL8nS2PDwajdSw
 lZ60flPS/8apUnO8bd8RvBqFInxT9Ow=
X-Proofpoint-ORIG-GUID: ua5AhVq-RDmdIkQ6JKOlAF0njnIA6W8W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NyBTYWx0ZWRfX1kLQ8lnLujNS
 s4ew3Mg9Z3AVx2qLc0kQ7/nqcBf2/On9tguddcn+FiuUCLipzQStvigbpuqVFn9N83eYD0+yLb1
 3rj7E2YIBRNt1z90XxVo7wk/pJTUXqkqpNvxwyK9ARzIqdvzJjQ7BtyJlklmLm1V25b1X8DqQdP
 BCAQ/SB8XAbyvm3nH91/jRxw1B3ljXTZKeO1hdwHoPty2wLaCIgMA725bSC8GIge91BoWwbxq+0
 O3brlxAyUTqvR3nEmlgUPRqKk1SVEN959kOPk1fD9OV/imiYqQlBOTjEPIi8XiyWrJWHVCheidO
 7M0JBu5ZilA/iXr06G6y4iqwO2k56uC3vCBH+3f+CTcLr1tUpZmbQcDKaxIf/yO1Bc26dY5fVG/
 Orozf9JRME+3vewtvHaeCI1CUi7tW/rPR810ZrxD7XlUXnPLolK+WVDpLQYrTmVNp1thgmEty8y
 Vikk3UVg/1TZ1t6CF+A==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abba69f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4UECf4yVBZO8k2hVk_IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ua5AhVq-RDmdIkQ6JKOlAF0njnIA6W8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290047

On 9/22/2026 6:27 PM, Bartosz Golaszewski wrote:
> This iteration - in addition to the previous fixes - proposes to split
> the QCE driver into a core part necessary to bind to the QCE DT node and
> enable runtime power management in order to allow to drop the
> interconnect votes, and the crypto part registering the crypto
> algorithms. The core module is then enabled in arm64 defconfig while the
> crypto part stays disabled by default. In addition: the actual
> registration of crypto algos is gated with a module parameter that
> default to false.
> 
> Note that remaining reported bugs will still be fixed in follow-up
> series. This series addresses self-tests and disables the algos by
> default.
> 
> The QCE hardware crypto engine has several limitations that cause it to
> produce incorrect results or stall on certain inputs. This series fixes
> several bugs and adds workaround allowing the deiver to pass crypto
> self-tests.
> 

Tested on Glymur-CRD, the s2r suspend blocking vote from crypto gets
removed during suspend.
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>

[...]

