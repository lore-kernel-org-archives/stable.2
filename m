Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500400;
	b=cUkS5OC2kB/Tu6bWB4lw7oILOMnWrUWMUTdHlHhN66+vkkfda2PNpXX6FvDB8XEoL3Uf
	 Zq162KhlT2u11kJhTAjMGTrjnlxe72qu90MWmb5UbYYe5L8d/y/xqeOc4puNwqy+UUIlE
	 5gemj0uIgpGmgeXlNeJoJWU9DrB5kywELFnyTY/DkJsHhYiGlbTVJ/eCFV2XQT+Qe6CbU
	 RB/zqfyhDjxT7n2GARmLbbsqYrNNBavgop9ApldDvOPkrG4OfMlNJbMqO8AirFrXFQ5kO
	 TxmAm+OBSyZp8rzmegqB9plnApAzFkPIRL+nUudkSfVbUxBU8sJ9j/dVJ3mHD9jAEaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500400;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QeE2tYwp8mzE086gdIcUEvuuD3n7eTJHgzKi/qUwFhE=;
	b=0dwn5WBH3dFFPJcOm+CTYsXOYnrswiyU04DnKhl6T0xi4EK878jsd3pZ7rHLqWCzYzYG
	 1quCGmEZD1hLon4nEt6TLeUsoHzT1mBfH2Y7zssocSnJubmG9N9CuIMMe7fS0bPasZ7Ue
	 UmfYULJSJp/DG4CrQEd5L/iRA1QWKpar/6YIqy0D/f5ujF5eiAJukQoSz9GAwIUKmkIzX
	 IJwpkNkYUXJT2V0T6E8pG9sB/TG07wAHmkr+q+dnHc0aa+LntBK7bHPY7A34GC3cyAlDM
	 /AMZXVT22WxnYZFjhabyMYqHz1036GMdPqir9yn3MNkvQo7bX2GxsxiCFnlNbar5PTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KWMIS5Zw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EB1q4tBD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA91606A320
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AA91606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KWMIS5Zw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EB1q4tBD
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAxbpw927047
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QeE2tYwp8mzE086gdIcUEvuuD3n7eTJHgzKi/qUwFhE=; b=KWMIS5ZwvKpMuQy6
	B/Hq5J4jh2srTIJZj1rWvqt6giAfvYSZW79kkcplGj3Pb5uX2s5BYuT4w7satKnZ
	qIt/RY86cpQpFZub+nFCKRuvtD7ezEKT3pq2bTFv3IAjx7AcgTrEd4XYceMIKDkX
	nHPISHFqcS8+mXt7tdiJpCJT1XsOvmTdubjRYr93W5fa+h8s8Ho4GOyVvcg7O/yk
	l0Qcu/9VFpIYN5mHoIjLNIsmW+QyaJHV3u4x9veuaRxSdNtJ25LM19vjeBFMGrP+
	nbOBnFcWcJArZUCkmeGcJyHiq67CeywfbBCxc3K4kX+iCmw8jXG0p2VssBP68s92
	fnn7zw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pagrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:46:39 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c2b7a15cedso92109137.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792500398; x=1793105198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeE2tYwp8mzE086gdIcUEvuuD3n7eTJHgzKi/qUwFhE=;
        b=EB1q4tBD1HROKieSRH9n0lXMHmHUXTHXcqox7NujofddDur3IW/vzXZuHNmPjUsVUg
         Cpnp7/MwVUATG2r127SlusUVMKR+dd/elIruKnrYSaGP2Xj1jQd5WQzEJeC5ixka+3Q2
         vndWjGaVLck7ayTxyPfBLRb66j21HgZiAHmqpyA0jWRd15l4Uwu1RgDsSn3Cvya/o8bN
         eNCJfIH+4vsrbWj1dBPRjfFtA58DYJyxCEpDYw08mCSmFVPHXS/5iFmQWdJeoUQVxLj8
         1qc4xAkKRcCZzASj5JLAL+a3z0cxVfRKsmyN5LC/IcK7ln1C6M5YNaHr0zg/1lBNyOuc
         tUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500398; x=1793105198;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QeE2tYwp8mzE086gdIcUEvuuD3n7eTJHgzKi/qUwFhE=;
        b=f1aQu0P6+iWTDih3kvnduo9ggez265yfliiUQqf2ErZvRPf83xjCiDw9Kn+TFx0jD3
         RK8rDezMGqWp8+shorKaShSWvJ+sVCM8ZMEQ0+UQnrth5BSZwk8fWfeZ9a+5PFIh91Jc
         6YYAicrQ20fAajx0k7s6MDkF4l8Yu8tCPVTCNAa9/FJEo4umfbLVhFmbYA1BgKluUNrv
         lcCgwzZpmnvCZbZerX/UYf8LBbdQJqCRlksakD1cxE3AuieDy88wUM7az6BSdQPpp8fl
         sGb2iZaaorlvOSxeFqAQchjmVcu6u4N6JSyjREHI6KIQH+Ldqlr2aqc2DNHOvGMclajS
         tpFA==
X-Forwarded-Encrypted: i=1; AKwUvBwiq9zGFjRyVjBlfD3tBAm7lJf+YK3S8cjYh45wU2vdWIbYTaKKxhjc+BDy7I99mt6h9DtfsVw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkOZHaSHZkJdSsNeR07pjoF4djLFrS/dNXSO8F6S+JjeXyVZ1U
	E9yqmGheaSryys9Fi0L8tX33fiXV9A9IfxmTbgCl9BwmD9/7j4UlWoi1lr1JZOhAqzCtAmu35AN
	UQjPOQoS3vTBdCihmZM1qLjK9r1wDyP3kUVPQZQnv0zECM8WCHVjHuvVskS8=
X-Gm-Gg: AYBFou21X/s81PXtNE16zc9RRyqOOfgm+0/UWEpfwvlrrnXIN71Za/y/I1z68xlGKCp
	JSXtW7frr6BFAEL/kD+Nvnh3DPEqOvFEu44BYxphy53k/wbyBPtApa9Sk8vzGc+KYMm6Wk983n5
	OoL3BonSbb/WpnDO4rGt5M/yMxf62QVykefE4pEhIPNLevGPQb7F4/kpQY9Ro5zwSGMH9fp6xmd
	Qk3gsMgLIno8+qajU8awO+KvF+t57mm1FVrDTkuZbYtPrEsxYFtl70/pASKLrfKun0HIrXn3VJS
	R57S5JZrClspE3zIDldGKdNSIpcVlb9l8Ttm86x50YMkCo3PfHfxKPGf2b99/6pbe99zIVxdBVg
	tyLG88rlpKwGPqqEzXkZ1zQ==
X-Received: by 2002:a05:6102:509f:b0:7ca:21e4:8e20 with SMTP id ada2fe7eead31-7cc36929107mr1800639137.2.1792500398225;
        Tue, 20 Oct 2026 05:46:38 -0700 (PDT)
X-Received: by 2002:a05:6102:509f:b0:7ca:21e4:8e20 with SMTP id ada2fe7eead31-7cc36929107mr1800634137.2.1792500397661;
        Tue, 20 Oct 2026 05:46:37 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40913c4806sm475795366b.44.2026.10.20.05.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 05:46:36 -0700 (PDT)
Message-ID: <72b98e95-29b2-4c8e-8afb-986abcd1367e@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 14:46:33 +0200
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
Subject: Re: [PATCH] clk: qcom: gcc-ipq5018: mark 'gpll0_main' clock as
 critical
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: Stanislaw Pal <kuncy7@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>,
        Jie Luo <jie.luo@oss.qualcomm.com>, Georg Seema <georgseema@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260918-ipq5018-mark-gpll0_main-critical-v1-1-fbe8f27a0106@gmail.com>
 <e16cf23c-82aa-465b-81b2-6240f4a0f4d9@oss.qualcomm.com>
 <f2ccd6b6-e5a2-4d36-a12c-124638c31280@gmail.com>
 <66d48e1f-7bab-42f3-84db-ce794f2a2a89@oss.qualcomm.com>
 <4ae83db6-768d-447e-b177-3ef5206267f9@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4ae83db6-768d-447e-b177-3ef5206267f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VTSt7SbUo7IwGjloeRqtLStSjfhNn9ng
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad762af cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=k2Pudi_VgRJteF2nVXcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX4q+ovz3SQQBT
 2A23opUCADKIUR29DTD7dQwBvhg7rbtsoJntWnlvAVgEl1/x+a70n6DwxO4TDDqUe1s/bwh1nt1
 Xu/rO0d47zK0/eklhH+AFEbo1SG648y+dDnJS2mP19SsBpUyC+wKXV5oDj/O32dGMHtqv07tlu4
 xPf+jmkfhKlgbgtO/JN/d2zXfB20l95faqsPbK3v8d3+DwYe5R90ejLN4gXA1vfNV4NFkwHyZIA
 F/MrrfJoPBf8oTm02QwpWnVuAwogqSdpPKXKXmrr4BSptXDfGrJz5KUNT6GaDTdbuK/K1lIOMgn
 fy0N1oVha6M1OyKa7wmcbjPZpPGLQUzny3R8u+5rEH/pknh5LkWRm/ON6Xl0ZQNWMJ65AMaKBjU
 F+WE8CGJI79adOQdEYBjvHdx3djXbqKLm4Qdl86SqBKsZTlmlsAtWtmNy8Yky0s3WiLd1w1v09a
 wTC3HTCgvElcDE/CTUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX2UV+aK51LPrL
 teDL6EOI1A/mugR+KOG2svmiEh31ZWZ6fMH9xsf1i0BnrDo/lCqF9D7fIXgfBRSAmoJvJCeevtV
 xQqTmy30MUWvW9rpJ5soOpRSK+9alus=
X-Proofpoint-ORIG-GUID: VTSt7SbUo7IwGjloeRqtLStSjfhNn9ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200050

On 10/3/26 9:50 PM, Gabor Juhos wrote:
> 2026. 10. 01. 18:15 keltezéssel, Konrad Dybcio írta:
>> On 9/24/26 1:33 PM, Gabor Juhos wrote:
>>> Hi Konrad,
>>>
>>> 2026. 09. 23. 15:32 keltezéssel, Konrad Dybcio írta:
>>>> On 9/18/26 11:27 AM, Gabor Juhos wrote:
>>>>> On IPQ5018, the APCS core clock feeds the CPUs. It can use
>>>>> different clocks as its parent, but during system boot it
>>>>> utilizes GPLL0.

[...]

> Maybe this helps to understand the problem.

Yes, it's much clearer now. I think the right solution here could
be to make .sync_state hold off any non-transient disables until
sync_state has completed.

But we're still working on getting any sort of sync_state in the
clk framework:

https://lore.kernel.org/linux-arm-msm/20260626-clk-sync-state-v1-0-4156d8196dc8@redhat.com/

Konrad
