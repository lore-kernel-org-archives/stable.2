Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902263;
	b=XGszDovQuR3DxniJaBKdecm7937NfWKb71inVYVYxOi6BFCzgA1kda5wdiZROcb7Cz1c
	 Uzf+9bpcHg/lUPO1GSXnhz64IvILDdi316A9oPPXvT4TJW/mi4vBDHstx6t5G3/nMzobV
	 nLZpdwHuSWjwQp32dOos0nekXiVe2N2iiMrZTFR9fc05tQNnCl0abYQ392hMP2/zyiwZ+
	 TksohprR95KKQUqTz1kkHNjopFHG1P0KoksPhcT8NaNMg5eXyDVQ1PKmQsVsyd80OM9NE
	 xotCXg6H5Q+gS8qjHdX0bZLWabaPqLZt8rFNmFNzt1gOvgqXLfIezY7LWo/mDSfh4Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902263;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MLlCCShlOa+MPZ0JlAdJDjsDVBjSAOvo1zMk+KLQ9bY=;
	b=YGovOkghCYkFz0VPJNoe7m/1LREVrcHz1m3ZNDC+B8XcUzSp3N0BlKAYcb1mt9/BQEvt
	 nk/HNFpItLIMiNLDV202kTgVTqc5mnfQaSTTNWhrejgDsejLUSCrbZvC6Pzk223wTjlyZ
	 LsEDN7g9yqqy9Y/v/PvzNxJc6CsK83nKIzbt/gJpNqN/1ZK06jS8IoDt5gJzANSJkMw/r
	 NUTWCYber/8EBsAV0QsZSNYf5pNMPJ/Lz/2coJj1FNDje/fEmI25ddlVlvb8jvpjvKbnH
	 eHDozdj3XYYACAaqebyCZyGG/3w8iU1fz8utIdH5E0ZD22/+HQWv4QnO0CLig7wHsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FmQwt4bb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PtgIgQWR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41650606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 07:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41650606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FmQwt4bb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PtgIgQWR
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH4444q1699233
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 07:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLlCCShlOa+MPZ0JlAdJDjsDVBjSAOvo1zMk+KLQ9bY=; b=FmQwt4bbWhbkQ6Ts
	W0PvawoGMyhL7hp+98zs4c+/dRDaPCwScV6Qd0qLno4+F6QZpAQPfPvBisW/w2u5
	2+/mIo6vqbfVeWp+wIljKODwLfrteqTRWsCOFhrrrntOc/tabxQaQwyu2qGR81Db
	BRXlRLtDHnQYFQIOj7vW7TAiTOrp6IdkPTyc6s73IpDEtSldpOT5Vn2dCZMP9TAC
	TfG14XNeFsFoUZIRLRlekLdPmwnWxgx4yk6EA1OiGEOrhkurqtf5g8Q9N3GiaeNr
	mfIWtr9l5L/OUV9+OVyQhySbXXkVoshpyKR2XZtAeDehEG1ko1PFVFETR8I7B9Fo
	XnVbkQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0fjugrf2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 07:57:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30c0d568830so5632346eec.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 23:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794902260; x=1795507060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLlCCShlOa+MPZ0JlAdJDjsDVBjSAOvo1zMk+KLQ9bY=;
        b=PtgIgQWRUPwyFAcZnIWuokqaMkEixi+NvN8cSjwIaP3QHP+XEUpg5FqsLZuAWQ1OKn
         Xh0juSRs5XAkC1QsJh0Wyw6mwoXleyrBkFKncJcPg2CmtDv1sYMuMt2xbIi76zneoNdu
         f/RtmDfH+eOdpnfOdfK4TlAS3EnyWJkT/P3gtGddMlg/AlVC+CleRtmlB7trhfFWHZaq
         smYWI4tX/Mg41evpCs0B/sJN/KvpgPifE4ZQw9oRF0GtTXvcWa4JoWVQAoyySRLNpScp
         HEzEup7LTZ05GudFCl3DW/pE3fg8F/1rt6FSd3r6R4tloENryKo0jjC2Btkafwz5pg0I
         fgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794902260; x=1795507060;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLlCCShlOa+MPZ0JlAdJDjsDVBjSAOvo1zMk+KLQ9bY=;
        b=XnwFzX+1vLjnTFQXunTT5tps9EagsKOyzrfSJCLt3t4sP21mAjnGBiw4pn5OLmtKYS
         4QHjIa3qs5a/FDLRekZ268mrpXLs+9ur0GmudIURWHToMFNrnVWZ7EOgrseBa5LtVyvh
         EY2vWiJxjMx6nkjSsSpf82d92cNQDzB5xJyrP3NduJ4dWujc90CgX6JX9gBecuTYdh19
         CRrZo8j58ZApE04i/5fkWW6e5YOWNwhzX9P6PEJ7iLj9ZoZp19NaUgGvcNwpYLr47k4Z
         SOlVUA82aZZF3S92m+17++b0QPBhLuHPoVPONNUhXqhJbMqMVQJcnqxLK/rHEWQkEdeF
         Wo3Q==
X-Forwarded-Encrypted: i=1; AL+hErGit/UIhAAN5uZJ5wYtHxBqTslc4rtLABTLu+hvKyom2Uc8DG4KIjeMJRFFbeGs94HS+ul4/Jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KxTq/T4ewQ39S2aETKjspBHQGyXTeIXfQZg7glvucuP9cKINK
	OryIUKfI/LZTD3HJNtrlqYsOtQvt3NF672d59T1Tc8dhJ6or21uygdxswjxRf16r/SgC91MYh/r
	sfR+KESsSTcFdqNFVYvar3Hg3s3kw70OedPxzVmeomkpL8wC7ZP0yexQy+HU=
X-Gm-Gg: AZFdTZfu0KjghAr++Mod/a3I4CyvtlPI8z6vsvcvOG9phmUrWrxJM8CdDLnErORcUAu
	g/Pu35k6nByDSqdyAJwvjCrwV4FUkbU45GUFCctqYwfWj/rl2qQSvaw79Ns5M3VZedHkktQoLfB
	XBXp4aQoKjuFAf1ZsbMM3/LFq56UstSIx6eofg5cOHJZL63FqbUOUmch1ppF914OJxDWQJOxaav
	QquR4mC7vKo0z3SvVCzf73aY67s/qs7HKivtdU2VtI7Za1/ijVIzuPuI9vl83RMd8hvI6RJQ6yb
	w5Lf8uDLvO38EfbMbbz/jWbziS9FmWhxtV5dbP1zCUeXzWZYNdXmJrkdii8Dz64AWdwHGsTeUXY
	8RDi1vF1tXsaaKWx/a8J8deA08bYU1f/eYtT3FsJtQ5Bn9IdFZpIHOzjff8MFVvhJd/HnYe8940
	aaRCwy
X-Received: by 2002:a05:7301:fd03:b0:36a:3ac:b15 with SMTP id 5a478bee46e88-37968993d61mr11889994eec.36.1794902260030;
        Mon, 16 Nov 2026 23:57:40 -0800 (PST)
X-Received: by 2002:a05:7301:fd03:b0:36a:3ac:b15 with SMTP id 5a478bee46e88-37968993d61mr11889973eec.36.1794902259508;
        Mon, 16 Nov 2026 23:57:39 -0800 (PST)
Received: from [10.204.100.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380e0fdcc36sm6089673eec.25.2026.11.16.23.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 23:57:38 -0800 (PST)
Message-ID: <f3079c6e-36eb-0c65-2e46-c9cb0a371656@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:27:32 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] Revert "media: qcom: iris: use disable_irq()
 during power-off"
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
 <20261111-fix-disable-irq-safely-v2-1-8e13f68c2ef9@oss.qualcomm.com>
 <39881cfa-6f44-41fb-aade-041d9cdf2f9e@linaro.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <39881cfa-6f44-41fb-aade-041d9cdf2f9e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMSBTYWx0ZWRfXyNAVTw3PIyPU
 lJZkYcLtR8EWJ7XEGARN8GqQHd4x4GxCv7LC64f4jn/QT/5uGji0kh4+BBJmPFlRzIU33j2seFp
 q5TgmGDO4Ax0uB8HpWrXLFoXqHEak+MNkOr1tgVk4h3tWPLkZUyL7LuefvftBas0Bc5Ys5Lfqlw
 OpWWU5oBkwAwD3krUra7R8o2e2j0bmBJA9dtaNBSIyOwIrsRxXbJdwVbNHytFzHCdd/Cxi4n9ea
 RkeSsQCr5SkGY512HHc+r3LIeUJg21GositJ8zkm5hKj3tmTG7nJDH/s0z1eyX2Tmbj/W0LAspp
 5ER9t/6zmyy22O3yJNeN/0FtZwoQ6AbIjnfN+D6zcdEMZxqCATWUVXyXeFfb/fKSDgdPSfGHylA
 ec7v0gO9RgEyhswNgi1crs4IFI8OckY4u554K+F7emnhSTWyTAi5vGD95Xvpg1b3JavqCH+VnWs
 FeGR1kQD7seM/PGihoA==
X-Authority-Analysis: v=2.4 cv=JfIpPkKV c=1 sm=1 tr=0 ts=6afc08f5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4gvInHfGZssBu6MVqJwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9k8tviCTEISdA-1s8cZ9q3DdOXOlFlos
X-Proofpoint-GUID: 9k8tviCTEISdA-1s8cZ9q3DdOXOlFlos
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMSBTYWx0ZWRfX/YbFa14rBCGc
 3tS2ItxWxUsL+hqqvPm6HXBqMJk7T9XdH5dcmokRdHjsLbNGXe/JGkZGo8/9pDI0rKU3bBrzxiC
 6mX7OBEc1yF0T4uNT8DD37acVnOhWzg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170031


On 11/13/2026 6:25 AM, Bryan O'Donoghue wrote:
> On 11/11/2026 09:05, Vishnu Reddy wrote:
>> iris_vpu_power_off() is always called with core->lock held.
>
> This statement is not true : int iris_hfi_pm_suspend(struct iris_core *core)

Why is the statement not true here?

iris_hfi_pm_suspend() is called from iris_pm_suspend(), which already holds
core->lock when it calls it. So iris_vpu_power_off() is called with core->lock
held on this path too.

>
> And TBH as I look at the code I wonder if it should have a lockdep assert if
> that lock is a requirement...
>
>  The threaded
>> IRQ handler also requires core->lock to proceed. If the handler is woken
>> and queued around the same time power-off is entered, it cannot acquire
>> core->lock because it is held by the power-off caller. disable_irq() waits
>> for the handler to complete, resulting in a deadlock.
>>
>> Fixes: b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during power-off")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> index 243bd845349f..1e183fc4e58c 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
>> @@ -240,7 +240,7 @@ void iris_vpu_power_off(struct iris_core *core)
>>       iris_unset_icc_bw(core);
>>         if (!iris_vpu_watchdog(core, core->intr_status))
>> -        disable_irq(core->irq);
>> +        disable_irq_nosync(core->irq);
>>   }
>>     int iris_vpu_power_on_controller(struct iris_core *core)
>>
>
> Looking at the next patch I'm fully recoiling.
