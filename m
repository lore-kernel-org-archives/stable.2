Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992700;
	b=ZciNhLP7HjTqNtLAifQOClbVXIil/hKxopwUnHyrTL9GQsNXsROHtOMLpfV06Tpwvpi5
	 y//jrETRvl6qnuB2qn1V0dH89p5Bi6sJP1S8VRP9S2v8K9u58jYX8+daJu7ViBsA8AyET
	 zUe3ydRdUlsxpZXvpAw8yHj50TlYPOa28Mk35UWTtLVTZFRxGMaGINCeJZRv1jDGNuoML
	 hmq6UgROAgkYz8wqEfhF5XfTATCDTtndQgZBNREfifB+fbPbVCZ9GGzxGVSmvVisu8xEc
	 9UhFMju1TPwWzSPukhaLoosVjJq4MW4qf2ctQr/O1ggxLTASRr8Loak+DXq65jQSOnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992700;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=;
	b=THf9/4PiDCLzy0MUaAqGOF1svdqhOBBwkurA//YI8fMVNCDafmv1slyCxhwB/qOlq+Mb
	 xdwpp9ZG34MDVe9k9vD7CxeICgWdezM/YM81FePxwfl/cZkJewgh+tUAn7Eg9J7xKgIao
	 GFSGWz6pbnPZZrhCJ4cAP28yAuNHTQBjU5h0PqbRykuZq6QYX7HaHJ9EUlyg7Q4NiMZhd
	 Cbxuii/CQLGRsYPJb/uXAntBWdVN6YnMmMQA3dy8lSPyZVnyW/Xbkk7PoY7jpkpmUQ1T+
	 zkRD/ZbyzUYzumCTQRaPoyiNBN+rCM8RSd93zAWG9gy0b0U8SFs+cTX9RzL+M3bIGdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ecqGBCl7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RXSuNdi+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2904606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2904606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ecqGBCl7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RXSuNdi+
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b9Yt718211
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=; b=ecqGBCl7iDU9pDko
	eAYWdC2ecPWqVsHyt+6amofgkQW9fS4tZz/1Py6ef05r8metQAO5TvfgmR4qUHcJ
	2Bajust7IfA6Kd8TEfUAMIHtmWurqvWK+gFvMRvYktMA8Wd62DGXugX1ex+DUqwy
	L1+cxYsqmuMBgiwRkaSoB5XhGil90xwgua7E3aXKR9NzLLkQpDVru4eI+VKPw7HV
	/Syg8httgcppGTUoYh+RS4ssoLRDiEfoUtkvm+iWwGmsVNnbIACilNx9E2hykk4w
	snN4upute0OS3g3BvP9lPyqfJDkrwID8OKXbjyso1VjMnU7397nJndoi2HMrDfNt
	zsFIwQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsry42-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8862ed0539dso3255629b3a.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792992698; x=1793597498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=;
        b=RXSuNdi+h/q6CGMw58LURa82rcDEtlgaN4A5C1Q3gYMxNW5WsPkZbQOYkPQ5Qi+QEX
         5jI/vOc+qhPE8BVm9Von+wktI7UJlmXgw5XgJzg5U7HR7Tvi8KrCnyXxpt//rHBDvp6P
         jC6qi9VdszhX6rBiyQAlnksgvi9BwXKfRCPWMeprMwn7TmTyFz9MWadnYetlrq9Fy3bA
         QA2JteW3SIYzVqC8Pb2th45/FSVl3mAm5OtPCVZkm9vKfhPPvn0Bjvl63NgmkecwE2co
         sTdfnRVJzBYuY3BNoHpWpdSz83wVyA4Gon3Op2sjGP+DYOfMSYQVYGz667r0RJO/MiIv
         Ug6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992698; x=1793597498;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fyq5dGa+rOs8GKUpJEw1gvY3K4JPA9zickD9AlO7hlY=;
        b=noY04nCqRskMDY3UBi0fhXowxquJC5m4kdpNxjM95wjfJrNeFOMZgB/Tso7nNjtOGx
         +BvEoB/5YSqoiCR9ck6ZsflE9vmCZGBp5KL1TU7SAdWTeKC7ILo1zT5Qio0lUfKVeBil
         ANBz0Ht9n2vXrwRPpWwiTA2HNSBHogHg0B1ruF0ikp/o+UhRvDOVCXYkBN3ijpz+h1tU
         VOBruUC8N8X5ER/5IMBgL0FNI4tpukZKGHp28a5h6vcMvcAtWqQbrYCO+vPMVbAmR8vj
         3MUzlstjcG/CXbzZhdl7q80wuE8ISZKXCEkGqec3igBY/6D6PIvCFQz1SEfM1jI3e+Nh
         lijg==
X-Forwarded-Encrypted: i=1; AKwUvBxNdGxaTopwg6OWmpsf8LGAl7sT6i6xPr3LS4aDcskBxpUOdd6nxQmlmc3obSFNW6zdOHbgLBU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3XOUUsd5T8K9zHyz4LKMJwXoT0e2gOJAUC7BCh7lMScp/JwFv
	FqNv72YvjHuB9qU0V7KtocP0qttZ0cC+mhux0oTMJotN7OvcQVsrkRG/FD4Sk6DxeKpdRrUOMgR
	jCr8KVH29VULvej7GUQ6yUVhRy8sVXU5n6BeLYTBYPw++8aE2K/QI5DyE6NU=
X-Gm-Gg: AYBFou3k8oJYXznUbBHSznCLr40IEgnzR6wGTWrLGfQcZtY5+TGchYBaIt8WedztCIy
	WketYw9FqjhkjRC697dU1GPSo2s/xjeKNfbYa9XpDzR5Ty6Y91uqYaIE6MH7F9+5A5fIPQmTpXE
	ML2Uhdtg8s/UY3WtcXlzVhq1U73uJ55SwvjQ5hy8tqDGak72zZ5acAsJCSFSuZcrhcohRLeh3wP
	vfyXHUnKofvuf993gLXc9hMQgcMHMzl6ONrWv2PZ01JTGIE7gPvQB+PzBigLLjDvqbM7LsZwUZo
	tNVM4ZNUJ38x4xnyqN3/YaZ2A4SgBy++gOAr64MZ9BmOwupe7BNwuLgW+deGXIS2N8PMn1W36mT
	9mqm1SFCsN77ED0ggIqBWp7LtSSEa
X-Received: by 2002:a05:6a00:a0a:b0:89e:d76c:327f with SMTP id d2e1a72fcca58-8a367a2d5c5mr4469594b3a.34.1792992698480;
        Sun, 25 Oct 2026 22:31:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0a:b0:89e:d76c:327f with SMTP id d2e1a72fcca58-8a367a2d5c5mr4469573b3a.34.1792992698112;
        Sun, 25 Oct 2026 22:31:38 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36acada58sm901954b3a.11.2026.10.25.22.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 22:31:37 -0700 (PDT)
Message-ID: <9dac352b-6f8e-4616-a0c9-50eefbc4c0d4@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:33 +0530
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
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX0Jw/eAIi0Pcp
 5/BJkyQSmeOGaql7WjHx63J78ogmAj9IaKQZCF5ImMAZHeCUGDQucv/tzBKTGSBC3NyDgiYKBWS
 ILBaqPQNRbDzkK1P+4DDJmo0EaDUEhQ=
X-Proofpoint-GUID: CMRuD6zq2OZaTHPwh9_0r0kR1o9a5ceH
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adee5bb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lp2TWI-43rxGvoCc0Z8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: CMRuD6zq2OZaTHPwh9_0r0kR1o9a5ceH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX5HtQQzhoNFIM
 gD/TjEhbbygh9y4jevkI2PchHf7nJbyYHW8pEqv6vszFVE9WZrz1HPYpfFGBKQQrZWEO2mwo0VX
 s5gkI9V2mp/mCBi80xL4QFlN6ZEX6xrCUcZutOw3Cw+0HXy7xThP+mH6vxktDAQba8inR/iZsxz
 hH0lpaoPaS121b15ecku78MZOIioFFfxzQBMZhkCCWW2+vakLsBOzlaXzZte3ynEtAG/1LsbgVx
 oJ5Krj+2otenq58ov3l9cy1xJ2FQ3UVdhgxoEHRZ1D3AIumG/VW1AaVEu9dyqzUAA0KwS05/lVl
 TthV+tEAibD9Vzh7VxJ9ppKMnYEPR5spTOrrehpxwJwikevrtcI0bU8ojvGj/5oXJmrF6qKVwOK
 CuS4FW+L7ynnpin5V3iw156WPFn+6QR1U0H1vhBXAX1dKUvvP61EssSYeLRRjjNchoD1/qlkCSM
 d8fGwogZHPD4jxwczOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260021

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sc8280xp device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
