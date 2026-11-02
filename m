Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626371;
	b=TqBReCfXtJWFgmq2olCE0bmgiGs18GyG7ctbNQD7SmT6u78idogWWscnEscB8EbiZvD9
	 WwmhKD5dQxQcCkDQ2jPShD6RcsZvls7IM4WyiMfhJ+QvMlD+rdJyByLnbYwvvmJBvV0cl
	 2x/47h621bI+fXoiaXwLB9zf7V7UbQWLAU9NTpiFK9IN8q6P4pRdRXm5FBBzTMizQSeMb
	 dHV9VvstDmnt5iWufleAMnvfvcBKfLR1PJzSFXO1b9uejTEx+eS0PcyCPKZAQyWbzcxMJ
	 bNf/LzUtt5N0zYS9t2bBxricFNAyZZKXOvX8X3zEVYI6JKwtX/QDfTqElZgKmJsBImQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cFAKXDSGQkk7BEgESnOUdhReDo4Ll1s6Etz17oC2PPY=;
	b=zQxYfIHmErNgvXG82oqC8loJ7OpHko1q0zyJv9CWYCREkE18djsQMQa7VE5aMAh1HbhH
	 U1X0SpsEGH4m/pJHc56DvB7zOGxZXDaxWV60bO5A86gTtHyV2MrWHSDmPgZnVm2ZNNJib
	 Bl95SCisBuDYR7gtaKVf6lHeQuZOdXRCLii81rM3pSN7ixBcf4umrLA0T0ZtVh0q3ViK8
	 yI1tsxFBQs2GN9eZzmi6ZCSp5RVZ2MrNsVADbZRxbJNMhqpizIXhl+90dwFNupHKyoo5Y
	 j+Td2h75ZU2Zw0YRtQhu3+YYLSfIEFPMNXm738pFAH3cJJHjfY0zcnDWyPuNYVbj01Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MGqHquVV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gCJKjvhc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF155606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 13:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF155606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MGqHquVV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gCJKjvhc
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DAMtV3423292
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 13:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cFAKXDSGQkk7BEgESnOUdhReDo4Ll1s6Etz17oC2PPY=; b=MGqHquVVfmYGpZUf
	UHJfPKtiltdD0yKxc2fIXQfjt9UTfEzqzFKdIUbRdGKDQMSFaJShA/ae4wrTmx4E
	+v/G3O4Lnb4ar85ZF397Wvi2Qr5JOoiD60EYPbKlJS0H+luWBfkr4FXboqs5p2bD
	VtmWiW5Oqr5/HKmXFMaLSR0gkR/BMJ4RtYj6PXW0LksE6zjtLMSrypBGtuUhFPyL
	XW2i4+3qXHUCV0JMqVAKAft5qHgbmkrW3Zm/RH8pkI+v8FNgihIfWlGZcmFkzxu0
	PRq3LudY6pr5Dfeib0rzJ/GBmbQ7IDmGS43TNHIG1afdhJytoRFsbHYyL7lWK+KX
	p8arDA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrh1g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 13:32:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so5901329eec.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793626370; x=1794231170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFAKXDSGQkk7BEgESnOUdhReDo4Ll1s6Etz17oC2PPY=;
        b=gCJKjvhcA+byKOSpmFteUfTaQK7HOsStb8s5XEkLXKKDjKKDLnEyNqnpp2nz9oQgpe
         WYdscClccfWvfUrTt+9nCIvZi7TpCr7+S7SJDFuI+6YmrYXHp4e/R2iRkUFq/5S9rL0A
         f5YQNSPiQKTufq0Pw5xUuqIPdmOpgKVP8efzmvxW8WeZdJWWeZHV7FcaYZ3VP7kqcIgE
         oY0Dplh4ghpAHjGZPOgHtuggZV/hFU3qK45PhpzMbyKbe+M58/Aao/OCsjAHEB0UrayV
         F8Bzq0d9ELb+ovJKi9L7arYnkqM0YQQaNoI29s8TcJnKQ8q69O90Hg4bq9b+fmJIvAaM
         vpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626370; x=1794231170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFAKXDSGQkk7BEgESnOUdhReDo4Ll1s6Etz17oC2PPY=;
        b=MhD9dIJmpQGIsYEfGjNhlabZkJz5OoYynM9d+b0CE0yRn+MGouAAXi2e+RU+Pc55uo
         iPnogC+ow3phhoLvyDC5iQwpMBxidf8SyizaVau7qvlosuQtosHwqe70BKPRvo5oMZaE
         ABq05cqadbxIj2TDbAjq/tN8A8gUQGYvrMa5Vdp6SopOuIUPaE8lsg3qTdK3kUlOPiNe
         ZiCVicDwEVGi6LKw78x99cfGANnM3kx+hL8MjiSGFMa5oCleTufR6V4twCYXk/z8Byo6
         XwBtU7fncVbEbEoUTktEo9poGRyPtCa5/xXQ9xYVFuvfon9Sng8WVIssHFjRkOU26TBp
         uEjA==
X-Forwarded-Encrypted: i=1; AKwUvBxgQaH2cDLMii5AoAccqPwz68YCzKI2HPE8I5AAfxjEXY2k9ARdLuWJVkzlxoDs/B5sg9EVZ+M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8c995/9THA4kP+EHlbdUssFUdEfEwlEyvo3+vVI2Z6OibQw+sF
	MIooWA1CH0Rv0Dfd88+qLKg1CegBxZym958Oowjtxfr+UUQBfg1lZOWAmBENxAoQi322/Wx3PWn
	3n7EpimPCLeFyE8/PsFqe6rkdXXMF/iOmxGt0htkV1R1Sss0uL6jn8/E0aQJ86ZDVTfk=
X-Gm-Gg: AYBFou22vA3ReTiv83sH5R1HKH0cakgMaqe1C9NCHvwGs34uSDGmIifAZT6f6U2fT+w
	pVjxYNJuIW25Ev4R4IEldVBNQyjONLC12gCat5efthTR7xhLBqfqN2KO/8++KhdJRljtSVHyVKI
	3y+k1bKTEv4RlGmLjOusTMO/7jNupJBfQX3+EOG1S5YHW+CObv07qsB3Phl99hMIbMzfwanwUXP
	my6mHyWhfHc5idni9XqubLXN0z8al+ocQxHtg5QLSd854xZ2gFof04aCPAXUSsz1CBrTeb6wKZZ
	oxLVl93ajZWW0c8MpKLvql1YxVtA5A48svpR34URq2EpYSr5tXc3YWUBqjlvb04SHE/Wsjt4SDZ
	fCKrwP2Nve++uyoX3d8RltDS/+lNlGrGfxRKVMz08+UrmRNYpSqjsIugLZuCRNrBqv73reYbmT/
	2dgmLArg==
X-Received: by 2002:a05:693c:83dc:10b0:365:d42a:f415 with SMTP id 5a478bee46e88-36a423454b2mr17425567eec.12.1793626369441;
        Mon, 02 Nov 2026 05:32:49 -0800 (PST)
X-Received: by 2002:a05:693c:83dc:10b0:365:d42a:f415 with SMTP id 5a478bee46e88-36a423454b2mr17425524eec.12.1793626368612;
        Mon, 02 Nov 2026 05:32:48 -0800 (PST)
Received: from [10.204.101.201] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a5eee0f20sm17186741eec.17.2026.11.02.05.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 05:32:48 -0800 (PST)
Message-ID: <74397996-99e1-423d-9a0c-dc17ff013239@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 19:02:42 +0530
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
Subject: Re: [PATCH 1/3] media: iris: Fix runtime PM reference imbalance on
 failed resume
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
 <20261017-iris-handle-unbind-v1-1-7809148eb90f@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261017-iris-handle-unbind-v1-1-7809148eb90f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae89102 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fnL9iuGchlDLWTthXDkA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: DVYW3jSIRE9tUWdygsN54O10Rb_kyx54
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfX33FVXHR329kU
 WgFONMpQiKS517bxVbxrDVpsgIWmC3sn2NuP1eAJ8F6aG4OvUx6rHM0HmsfoW7gv69MWqD+18Gw
 uvr6HmHNuAc9l4rfaZ5QlagkRzGJWMw=
X-Proofpoint-ORIG-GUID: DVYW3jSIRE9tUWdygsN54O10Rb_kyx54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MyBTYWx0ZWRfXyTHgPcdgCRrz
 QQyyElsh7bEdlxcFF0uUX4/DvfbOcuIm+e0UlJownSw5sJ7jAiNEpDEyAPub854paYLmOrMJPvI
 AdJzoVa0KecuivigS1xsF9awulmjeAO+jsrbjotXpr6YhdgFVq/u57D6AfbMfo0QuVwCveYI9GN
 4LwbQrvvWxVym59OHjLGXrcG7l6iDFRbVOpCw20YEdlv921siKbVELLl83Pl4J8QWjJS6Rwkctr
 3osOW46r6tMRp35xba3x0AYOzWuQLjHX42HoY5wp3idD7TcjGwroPwRvmni00nrt9sEkiQp+3xV
 6d4Js3KxBAswFme4+bFSqEGOmcXsBlg6ZG7s4q/0/BnQAQ9b41MfMsLn07GSOBViQWC8/XHmC9/
 NODqCQC/vHXiGrt3kza/Y1fnnARkrP1iiXIq+mVkg/o6GxUl1sX39J4X8nc2qP7n/tKKU8Vr47+
 Xq9BsOYAiJlnmQdRAhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020053



On 10/17/2026 8:46 AM, Vishnu Reddy wrote:
> pm_runtime_resume_and_get() drops its usage count when the resume
> fails. iris_hfi_queue_cmd_write() dropped it a second time on that
> path, resulting in a runtime PM usage count underflow warning:
> 
>    qcom-iris aa00000.video-codec: Runtime PM usage count underflow!
> 
> Fixes: bb8a95aa038e ("media: iris: implement power management")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_hfi_queue.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
