Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6A42315C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785412773; cv=none; b=ivB8Q/coPfHnM9hoHCQ3IX1JTHgf4qHomyPqgNJHNFEzkSn4MJM0CgGQzn1q6VKnbXGUMZjHoz9wfZTa3Cm4uw6Bi04rB6Z41mxo1u67C/yzydGlH67QBuBiXhPGqlBtticU8tcQ18NDaEWajUixfkf7va88wqVfDZ+UoPoNTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785412773; c=relaxed/simple;
	bh=NoxRCcgEgb06epQxvvw2a85CLBOzEBByEaQUWYnXeDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6+uIRMDqybl27sAVU2wkIVO2tZzgPfvNn8nfeLZLZqFdW44nMNl2TARwtRTRpD9C4Tvz0fOudhrvLjWOSreV+wqxUtmlCbuiEb5PUebdCrPI+X9x1O+rLgqa4UoS/kLGG2KmT0X8p5puF4XH9qR+pnP3Nrj3T1xTGGir8o+Rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hgf4Or5+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gwHvC/Ca; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hgf4Or5+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gwHvC/Ca"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2cnF735369
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FBp2w12lai0FjiEpU3v2YGIn15VLtuFjmO2fx6m51K0=; b=Hgf4Or5+CB1nNkn1
	ZfCPnnCqJ1dMySNQ/AZF38CTRN27kGa/vGd6P7EM1+zKce3eDJ7avdCXTJttIhsY
	2PjFvvmR/zlzxWCDuvoUO9WlHMV/L0AkaEQs4MwUivlrx+QgrLuxC/KutmE+E2pR
	8MRjEFh5nqFZqWTHwTAmjYJHINM5kyfJimT42icbAxsVvR+id9THGNTET3nbK1HE
	6ODWwjUJVBAnZDO/cCknpfS+r/FMF1jWTvHTL4lYXUnzwcfOT1OEbpIwwS/Qs7m6
	gmz5djwVSeDw1sSitCYxQYqPEvJFGGNRusaDdNb31a0Hl2JINsnmz9yRiYJgjCue
	OBNBmQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr4a2gh27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:59:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a8b0a08d2so17440331cf.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785412771; x=1786017571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBp2w12lai0FjiEpU3v2YGIn15VLtuFjmO2fx6m51K0=;
        b=gwHvC/CamFiyMY7tfpb4jyUD4zHTAuP2jvIvOlxV0pDBbqwn2dSRp4sbc3RSfgYErB
         j+VpiW5/cXSR7EuWWrjkqs+OxAjpN7rE7Ld5F1Ka0cePLLbJ8iectWnVoFWzHx109LWF
         gNCsyZJzAvc4FtzppLirwV8rtQKI5mKDMJcMrVjBQEdOLg7emPYuOzxb9pyf/vI5OEOy
         ghzVF7IMoDg2ASaurLinBymcoG6r1Ed2586cwzmxBdP3HkyLcoGUVtnezcqVhnpD5poi
         c5BjzFquajtYdMDcxtFJtcma98mCYJ388QA9K/WkkvAhONOzRXdbt5Sqb1Gn1AKLeBrf
         zVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785412771; x=1786017571;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBp2w12lai0FjiEpU3v2YGIn15VLtuFjmO2fx6m51K0=;
        b=tYX3kOXrYljSfLtW6JsDNI0/mjRfjJFENLGxxNYVQO1EJxyYXjgopT0F1BKGTbcaXv
         Fi1mzfAeKYY9ZBc8T9B6SQSpZJuNcV8uQk4+d9OYuC1qZtr1Y0yajIcev4nGFHOfwHH4
         zsgGOPtVcsQzM4Y1eYzJwlwj5P1WOn5d+sjyB703om3PZhu4yQk5lDhqPQ40H/xvbU1R
         daN/F03s/wh3zkU3w9YK63A+SYm4yviZnpT7xzcZuoCUepolpUTMwsTrv8YxVg8rc0Wp
         Oc2RIbqsQ5dtVzLQVWrvNiG+67B1ul2xD3IUePJ/1XLWc7vYndsw0umYI1SC349vrVL0
         fQOg==
X-Forwarded-Encrypted: i=1; AHgh+RpQFPyNO6kA3untaK8uwCQ0459klNjlzlpCMbyXLWCg3XCDGH05zxPotVP0L9QOrQjPZ3W8Km4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zp/1Ivw+42gag0uGmcdLFtGciuv1+/SBt9B9p1Ku9r0kyQ7y
	Wyw8ULZ6HjKWUCfD8ihI0PGAZKWJzVGlV8NDFNuCMYmwXJgHnGPPKpjUqyzBWRI86+WVWs9pHxL
	W3kbSK+m1/77EbuL1+ZLCnsHF39UMVfKQ8mH+cWJiixyKL+DsArL3nXeUZBE=
X-Gm-Gg: AR+sD12WPr4Imj6RFTSsmRUsEYiC7xobPGCi93EwhUr2qyZXgT0Icsh58VAuaDSrG/r
	h6QJ9vADWcx9Pp11jCskc951Nw22xuGXGQWLloXLPtkKoy1OCVj8FCmJJgCgTKAYL6LxxF3Kr3Y
	GwHgUT44TYFxFGH8hBtUV1jqVqGwf1Zjd2lkGwOx3sncpw4zQnzIRojWC+w4vs8Oywq8lwEbLkn
	g1hfy5aAUeBtG3KwO3Huz5P/x7tGr4cSQr1v+KXZdkwE7vn8/wNt7EHlG7EcO5LEIw2HX4RWG5Y
	n1uD6JSMJEaeoPewibNt9dbFRTgtA4QhdIDxEeU0DLzWuARiudbPuEglUbRycFKFriUSBFi8e4a
	vMpMtsyaYF0TmLvzIibspRGiWlc8=
X-Received: by 2002:ac8:6f17:0:b0:51c:7b13:62f9 with SMTP id d75a77b69052e-52b38742986mr24485411cf.79.1785412770616;
        Thu, 30 Jul 2026 04:59:30 -0700 (PDT)
X-Received: by 2002:ac8:6f17:0:b0:51c:7b13:62f9 with SMTP id d75a77b69052e-52b38742986mr24485201cf.79.1785412770205;
        Thu, 30 Jul 2026 04:59:30 -0700 (PDT)
Received: from [192.168.68.105] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c1fa8577e6dsm59312266b.22.2026.07.30.04.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 04:59:29 -0700 (PDT)
Message-ID: <ee25f647-33dc-4a55-8959-e658c53141d4@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 12:59:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ASoC: codecs: lpass-{tx,wsa}-macro: fix enum
 kcontrol accesses
To: me@dawidwrobel.com, Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260730-worktree-lpass-tx-macro-enum-fix-v2-0-6d091c736116@dawidwrobel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xG9GoSwpLJ4Jt2EO7LT2TcY9jkezIsA8
X-Proofpoint-ORIG-GUID: xG9GoSwpLJ4Jt2EO7LT2TcY9jkezIsA8
X-Authority-Analysis: v=2.4 cv=IoIutr/g c=1 sm=1 tr=0 ts=6a6b3ca3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=br21HGidAAAA:8 a=EUspDBNiAAAA:8 a=pIAsNjLqZIIOTrGnJRYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=rq5_1Q1BYlbxkLLkNd_B:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX6uDoeU/J6Rpw
 QgT15wqmSTrK3l7A2wz4q8zui1/q7SAKrt/460AQBKd2L9f9zCuAqwbrgY3s8HQ9Dqnehs2Ya/1
 VapwgLALP6jzC4t7P3rsnXgtiZryc+O3uRrkKtSUZ82qgnPtYdDmSoMkMefo59sgN+AsOL6UCny
 BT33Wwi23WgDhHi74WjRkf5O/oyxLeJI8sz1irevCuuS2ycMaFCplWPZSqY0CqgW2j6tmh5Ko3U
 0EVtXdMfG3BphUYgzyNf++7mBm9ZmrSXjkvIIrhKAPvykNADn70ieVD4GSAS5+T2Oed4Xr184Ic
 tv+OxZM0yVx3fLeQcjPTooVtMSFmIb+Wj87etzZCqU6LlnbmJ87lDVtenp5QXV7YNZwtiXO8KiC
 qKVGvyX92YsB9iM3824cX1TWEvUa+lXogwm/A7+TwPxnOiCXoCOHQHc/Kh4u4ETJo8XMtn0P5zY
 46o4oQ9lofyaDJEUpFg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5MCBTYWx0ZWRfX9/qYLHFPGy6q
 fRFZ19sk5bHESQE1LrmX9acRMA3cYtpeJdm2nHW/cyUdJoNgxGksh/YLgKDcejTlwjxY5t5RzYq
 aRQZqj4JLOLh0bLbzow/U5vVF9KQvUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300090

On 7/30/26 11:58 AM, Dawid Wróbel via B4 Relay wrote:
> Both drivers access enumerated controls through value.integer.value[0]
> instead of value.enumerated.item[0]. The same bug was fixed in rx-macro
> and va-macro in 2022 (bcfe5f76cc40, 0ea5eff7c606); tx-macro and
> wsa-macro were missed.
> 
> On 64-bit kernels with CONFIG_SND_CTL_DEBUG this trips the elem value
> sanity check, and every read of the affected controls fails with
> -EINVAL.
> 
> Reproduced and fixed on a Xiaomi Mi Pad 5 Pro (SM8250) for tx-macro.
> wsa-macro is compile-tested only — that codec is not instantiated on
> this hardware.
> 
> Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
> ---

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

--srini
> Changes in v2:
> - wsa-macro: also fix wsa_macro_rx_mux_get() and wsa_macro_rx_mux_put(),
>   which have the same bug (Srinivas Kandagatla)
> - Cc stable on both patches (Srinivas Kandagatla)
> - Link to v1: https://lore.kernel.org/r/20260729-worktree-lpass-tx-macro-enum-fix-v1-0-0cf02c681332@dawidwrobel.com
> 
> ---
> Dawid Wróbel (2):
>       ASoC: codecs: lpass-tx-macro: Fix enum kcontrol accesses
>       ASoC: codecs: lpass-wsa-macro: Fix enum kcontrol accesses
> 
>  sound/soc/codecs/lpass-tx-macro.c  | 4 ++--
>  sound/soc/codecs/lpass-wsa-macro.c | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
> change-id: 20260729-worktree-lpass-tx-macro-enum-fix-c5fbafef75b6
> 
> Best regards,

