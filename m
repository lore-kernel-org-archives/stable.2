Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626397;
	b=Lcdr3+2F7wSyioKmBcVhuU28Xuq5Uw6894JuZJ32EuyYFx8YOTQDjMAFJlhsVf4e+5lX
	 yzqY/iWh4Zu7/YoGiY8NyigHlfOPR8aU/rII+efMg/5WHysidQxB+z2tov1gWYIqSWGwW
	 8P6hBoGEvcKcG0pTTwYwlrq2S6yEBdt9CN6ZRCgOo21oAto4x3UbW8hrSBWG0MF5kznrC
	 0g6MDfLDdmahe+9K4P1AJO9j27eDdChLhPy+xlGbPaZkA4VHzkjIV/5k4cKQGEMTbcKYU
	 J3ktcZVo6cr0g7m4nITjCttLeCOIYpJ4v1Gy03Z3qrkN4AupjA/C1ZuBtWiu3dkZeiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aowsUPHoeJ6TRxLopFtshuzGGcc2yKO7O61+U0ZSsuE=;
	b=u8iUugIX48H2KQmAAif/BGwdDLmOJAhKRfRzqPyoGwULW/jYpmbW+sUZKYe6GfziP+6i
	 eFIpbsQZpWkvZLyW8q62qPQm1s1Y/BgiG0b2/soG1H0PKRi2Hke4kCX+qDeHoYo10x4lF
	 2m3o2aoPbpNFX6sV9sENF5OCs0EEFeqQi35aDm1eTaEFs26+0vKOKtTIz/MvSB372AlTv
	 LVoMv0wARidV2KSAQArviGv7CMhsaucW3DW6gY4DnQo3N544uSUUWEwemTYlyAqdx59S0
	 GPfN556TYZVGrdQeOFuRDC9gNikDk6NCU0O1aupLYw2R9XTCQeTDpK8J6AyJOERu+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XJRgvgs2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e04Nl3DS;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE1606A330
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36EE1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XJRgvgs2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e04Nl3DS
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAMir756936
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 13:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aowsUPHoeJ6TRxLopFtshuzGGcc2yKO7O61+U0ZSsuE=; b=XJRgvgs2K7pC/6Lm
	SZ36PdLYrisZ/czYvLmC49YHwxRf3wrSKeKQUihz6zD6Y4jk4LAwWrl43n9hbmfW
	J8IlAHd4S6kt23FwWReAxVDGrPgYUZE0J8CO0Ynu3f9DC2W7a/Ofedb+oyGWTq70
	N/BRV7TK/dQ/IjNVHYNZ6TS1o2b8/MLcyCFI49j1uc3U9PyT2utnUbzjo6PeyRL7
	wx4x8WZaSLbiSltuVYTkL2Hn1P+63eMdd4J8HUUIIRIcwf6ujBrZc4PA4a8W9bup
	n4EBZnh6gQ6fHQ7mVUqrfRrdqswuYLqKVdcT25N60JmpWU1zDATE/el/LTBpARhB
	DBv5Xw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1stcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:33:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so5901734eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626395; x=1794231195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aowsUPHoeJ6TRxLopFtshuzGGcc2yKO7O61+U0ZSsuE=;
        b=e04Nl3DSbYAKPrkhaZFZF0oWYiClkp0edkG14YOd+lizqibM1IrcsNbdKfXtSARDe5
         PxVbUbnAoCR8FBe58g3qFfpOGUPcdal+XJXT/OnR5B8TzuzHmpsh0guSs95ZDZRS8ykt
         EGDwRglr6F7JIm9hmntaNExOo0AblRVkzBeO5ewRhdlw+rPOUVp5iiiB6TPojFCsDwQq
         OGbHqE+x+wl6Pd+fp03W0f1jugvO4LzterwgW8HNeH7DziWY+0ugff3Vcin7L5oZv/3p
         OxbNFj0xCkRXfHyBf3R4ltplemQrJmz7uT3tx4kE3/7mGM9AHj4pTTa3DqXGuTlQ5648
         9l1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626395; x=1794231195;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aowsUPHoeJ6TRxLopFtshuzGGcc2yKO7O61+U0ZSsuE=;
        b=BYbUIzUcwKDjYGChWMK67CUfhr/RAV1QQpFyWK29np2BEMF80RW24KGEArsRm0vxH8
         SkXfM+JrgqbWF9SzW92oV5RZ/zLMRl7bXlW6WpqKNZ+PbSOF+SKcx6IthpayvNeoADK1
         hflYdecoKgmcG1bvqmSURS/WI4pbvYY+NQxGeGQ0vjhdKWBOvqHkj5q1j8O8mesvaMLi
         Q4wMsfSJLJ38PdhT026hyc6Y+jQPTSJrRQczMTbNQVtqMNxme2HNX+/LJoPINhfdsemH
         SONzZJJ3dTFcc1B0uY9Cfg1he98/P6HnSwEsube4N84AuyaY531kwG5WwMMD+iyNvwJt
         eyOg==
X-Forwarded-Encrypted: i=1; AKwUvBz92TnPy9x9KQqg111zmpQZ+z3quqi6UStBTUn5nlGX9sr5wNF0TuyC/oxNiFg1ODJ6z9nmfCc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGbfC4l6+npVxd0vUN3EFf15ZCm5+xqI+KS1z2POSjxUVHbkWT
	HbUyUtjyP8pUT6etO3rVDGh+sgl0kl7cplkFTdyAbqDXf/P+LnMelMghZpT9mtiXw3etHb5HEGd
	sDxVsN36BMY2FjYJjwmKDb22SxhSfFO55LBEgsT4KfeIvZvaj3wlky+Pu+s8=
X-Gm-Gg: AYBFou2luO5J5gSRiWAYYSgL9AJ2ZCupBku/2L/kTOpfR2rRnSE3Tdi9quuE0hvchp/
	iZOGlJAbkOJSVwq3A5PSXS8IG1WGIob73OttghJ5Ohib7qym787+NtrknL3Y70vy27ddqZBRfCk
	KF32w4TCFO/qMQgl4LHkupdlE35YnEtdjXk0ueQMGKb6ndGItPWY0f2RHeoU3XnDt8epdD3v3xp
	F+V6+oT+lJspp+G5KAZH2hDyP+qk5p+7wi1IsB28+c3I6yPMlmwADsgzddHsO9zs2HYIH1gBNWQ
	FO5FpoPBOI1oCDYr0h19um8wriiDdgSB9TmbkCi8370fyFwt4AjuNWjz4FlBvYvyxmf7xnVdNdm
	I9DTGmO8EC+uCb+Gf6iUvcDgQfbRCv6mBY1XbnNbrpcsJufLFjQDjuomux8ul2X5um8csQ/x/b4
	RJi9ASzA==
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id 5a478bee46e88-36a42345b05mr20153314eec.11.1793626394664;
        Mon, 02 Nov 2026 05:33:14 -0800 (PST)
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id 5a478bee46e88-36a42345b05mr20153258eec.11.1793626394081;
        Mon, 02 Nov 2026 05:33:14 -0800 (PST)
Received: from [10.204.101.201] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36639936eec.6.2026.11.02.05.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:33:13 -0800 (PST)
Message-ID: <cc56469f-8f9a-4f89-85a9-d6f396ccd3c2@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 19:03:07 +0530
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
Subject: Re: [PATCH 2/3] media: iris: Disable the system error work on removal
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
References: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
 <20261017-iris-handle-unbind-v1-2-7809148eb90f@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261017-iris-handle-unbind-v1-2-7809148eb90f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GoSkXINpqIq_HXrP0ARF9Eu1cM_6-81j
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8911b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OnH3Zg2X3O9LORF0kDoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX2vqadUwxO2SO
 GK0GqRqhc9CLnh6JlJlhGL/7WS0DUYBg+BnkggH2KO0X6EQTG0ViZwTae6XMLcx1GdxrMkErkNz
 QfuPVdgFr30GmXetKC4kv52zjZfbOBVKkFezDzT/hQtkJWzVxIaUn2yf4G8olo2eHAgaqH+AQbw
 ybezwugz4rko9DwUzBEk6CS43jkewB+gxTY88zJOFI2bHvFcr6XHtusrL3NPtv/KPiKJR4gverm
 A47zuo9lbz68caPDmTAwIaoXGXWzwaJldFAauwNwxCxX7QsUTnXQbmNU+th1CbOIN5lWAhI+T0k
 /G1Hi2KZ4vo6AxXdJ1zGVNDpGb9chPHE/BkGbFEENOmNPKmqpC3ffHKQ1gHLKZV4YhSl3q01mg9
 4W7sZwyn0q8/L2BAST6rfZkgehSMXp1qTUPxK6LnS+2uble1ZQMuu9PbMKiPQdq94nqtzCMbWTc
 VSX7GM4VLAyf4WvMWUw==
X-Proofpoint-GUID: GoSkXINpqIq_HXrP0ARF9Eu1cM_6-81j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX0lU3W9fUH7Sc
 AUKTFBYG5Q577FMePDdpfVXLAUOnDHlA0u3VixEYOQchkFu8xvgbF53E/2cHMxLmN+1SSFDeIcb
 3sQ0eeKIjZzC1dCpVhXx+f/WWFOENlU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020053



On 10/17/2026 8:46 AM, Vishnu Reddy wrote:
> iris_remove() calls cancel_delayed_work_sync() to stop the system error
> work. This cancels a pending work and waits for a running one. It does
> not stop the work from being queued again afterwards.
> 
> A system error interrupt can still arrive after that call. The
> interrupt handler queues the work again. The work then runs after the
> removal and uses resources that are already freed.
> 
> Use disable_delayed_work_sync() instead. Once it returns no new work
> can be queued. The work cannot run again during or after the removal.
> 
> Fixes: 452480931648 ("media: iris: cancel sys error work on driver removal")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_probe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
