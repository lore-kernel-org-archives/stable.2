Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD04B95A8
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156492; cv=none; b=hnEmKg+8s6xyORq1kn6ciJ7rxZ+z4CEukVpwWzEmbZQqh2huqUxfX2Lb0rVGxHTDo7zNohOafTkoAk7BdGEkcMPkAediSCQR82wbUxPDgvXl8i7qUZE8bQJoB4Mn77zCxg6s69wtZLDmHzqPnfBUv1xftuSngGvms8VSl5vpvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156492; c=relaxed/simple;
	bh=CndP1bLne+UX3AI97tK+HL16zqhF/jGzueNBiUg3cEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEYLpDPPpb6SSEPVYSp19g/1AHIIuBNZZcA8JHIXjPkQPaO8hpU2u6VpkC+Q2KGkDO8F9bYGUqxNVdGPUC0XdXjQWAt/jjMpE3WX5Vj2CP6yKJ3w/Fcc+umyjL5Ov/aOaSmVf9TFtias5rLt9lA0ZnfR9IuSfGuW4OGgYW6/Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OfG7Ut8w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E+YP8q3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OfG7Ut8w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E+YP8q3Y"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAA7RP1647550
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KQZsw4ftvBo7+ZjIXx+lUmsyKGeSp9JqGs4axL88zkQ=; b=OfG7Ut8wEH1FASSl
	NEvHE2n3yl99902oZL5LLaDFq7dvc20v6xIeQzZFh1PncyKohYE+C4nq69HHZKVX
	WN17GyN8VxxNLmLVPQlWBg1Z9kr8Y7PwSsnkBU6a1pIRiGhRrzAKPZ9SLIk2J2gI
	7iB2vkAgxufgYPzjoN8VejpzWNDck1fPhA/Bas3u2i7AUwNJKovlEMtVQjmQZkuB
	HvRiaQf3mWrALcCUAlom2KtqaXKgiLFIyi5LSbRz5r5kcQWo9KX4JZTDBgCbqewl
	Xwu/Jv9+crSCvZt6lM7CBybKRU86eB+C2DDvsP/IJM1mlbe0NSI1hh6vb1etnrb9
	++8WHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhumrmuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 13:14:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1440e081so20051885a.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 06:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792156487; x=1792761287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KQZsw4ftvBo7+ZjIXx+lUmsyKGeSp9JqGs4axL88zkQ=;
        b=E+YP8q3YpnzAR1LmVbpfji4+vcTji3bI6ExV+Cda9QNwJz/VA9poOwg1+OpJ3LJoQz
         ODS4LwNrdDeJt4OyaBq+hL3tUP+eLsdB/NINS4vi91erE5G7HaBZFMvU8FdGcydYnupw
         40PTJ4l/uIPoHidLCRlybqLXB0wGVTy0IUFmzKZd4boH+KPnCATe3KFqG5UEg91N6aTq
         xm+9aSGwvRKUXKymJJRu+C/XaZxc+P9ZdRPS46dL4UDaT6zAYkOF+lZ4E4mnfpPG+fFe
         kJd2X6orW+uaCFo4Ft/fCKc4kdwfvG1cvn3yRq/YMHJ1auUBWGFXyib8PPrSlD/+Hi4P
         J+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792156487; x=1792761287;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KQZsw4ftvBo7+ZjIXx+lUmsyKGeSp9JqGs4axL88zkQ=;
        b=p5FIyCuKdQtHK4nQ6G1s4rsHp05RLbGLekagoCNnjSSIiojPoTYWhNQ+Q11pxxI8UI
         44z373y4tn+wmhwKkw+zVWTdn7dZJIf2YySmzJsyrEaRlzdaPk8ilkrBgn2MXWh2BxvO
         9SivkuQ5uUKYPfmZzXikevMTcqhRD8JXaqrLluHqvBXxkfy5HSvk3+jg7Tcq2DzEAGYB
         4UVSfg3M/L+tzgPq36tsg7qydPU55oAqi0lrVV8aoPkxWzWFRmYwv7YeODa9dbotD7F7
         ZVFvPEUPN06EusdlR5KmGY8UdOwHWCQfb7ODcloeIwR+1U7SVG4Qxx/avAR1aucEGSPZ
         Q2ng==
X-Forwarded-Encrypted: i=1; AKwUvBxOwaHHki6pFmNeeyQfk5hA7eX0Uwf8rMFv6bdkBkXhbpVlbSprIigXvVAhTsURbZVF1SE00Lc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKN01lb7UrvApEEIlnltpjCEY/27dY8saN9NFmOUpAHIfjEjzB
	D8vaoijDBP7PbQ9HYzD+gupBAlqiMvY4eVyOsJLYmWGdDA3IA7WicITy/X6UEnHWT0juxLPy/DI
	7eDvH7Gll8cvBa/0K0CSXhRoC9CLEYM/5RHqdounjQ7bN4DfqdI3GPJwPNES2B10dBzA=
X-Gm-Gg: AYBFou2mHacKQktkD9QC34hp70KmpEcqPXrwAQC9aBlw5AvPMBy8XfmJh82gEnjdqHG
	G+RWFZeukKHexhOn6zqdPQxQaj+fwW7ktK1yRHVXQno0uHdWnOCjIioj6DbXJ7KvsqMS7VXBydw
	TYH9StMNqoJp+pv4d5yNY0Hng9Lmm1LBL0vtnuLDV6qHNX5Vl4KrFgOlYmytuW3esZcxM9pQ+LK
	rW0yhi4NW1TLdEKfH2txqEneCrK696K09jg05sE+4j8nL0Z9z2MthZ42Nn5JxzkwE5aFtQTxByd
	CB6fiaWQXNoJjmCIN/DG2Zj+wa/aIuQSlqcmnlS2e+M2JAnW8mstv3KUIZyn3L63mQlQi/LKU6F
	x2jseFMWDWx8O2LwXVJkd2w==
X-Received: by 2002:a05:620a:a43:b0:93f:211f:7ba4 with SMTP id af79cd13be357-93f211f7e97mr152806385a.5.1792156487462;
        Fri, 16 Oct 2026 06:14:47 -0700 (PDT)
X-Received: by 2002:a05:620a:a43:b0:93f:211f:7ba4 with SMTP id af79cd13be357-93f211f7e97mr152800585a.5.1792156486768;
        Fri, 16 Oct 2026 06:14:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408b4a85b8sm71612466b.0.2026.10.16.06.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:14:45 -0700 (PDT)
Message-ID: <bbdaabf7-ffdb-433d-91fb-f6ca03b0747c@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:14:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: qrtr: ns: retry service announcements on -EAGAIN
To: Joonhoe Kim <26rote@gmail.com>, mani@kernel.org, davem@davemloft.net,
        edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, christopher.lew@oss.qualcomm.com,
        deepak.singh@oss.qualcomm.com, pranav.phansalkar@oss.qualcomm.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org
References: <20261016124600.31-1-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016124600.31-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX2Sl3oHmPFx2o
 KFzGyCqWqFhAsIzZAlhcrO8jMTy9Lj9OgTNMZekBgZsN71UNhYOFHXZ7esWZKkB3wiu1fgQN7wC
 C376V4TtWFcep8lUfD/YbGAB1eJL6mo=
X-Authority-Analysis: v=2.4 cv=H+BOUOYi c=1 sm=1 tr=0 ts=6ad22348 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=tdnHcQlNMze5R78DgzoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: K0DJYnksNCAwQEQGaJKBqTtLjoFYAvOR
X-Proofpoint-ORIG-GUID: K0DJYnksNCAwQEQGaJKBqTtLjoFYAvOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MiBTYWx0ZWRfX/WzqaCz+d4I5
 rA1qlN9yB1+QmwXrheodQddaULxk90PikZ9ZPj1HFkyf8yKW+WR3KaIT5n3MQTwu6WWjiVwvfgA
 YX10c7s2xTLQK/RwGOkY6jKg4AFQUY+ZVrw3+LD8F10Vn2wd1sIVHOXe6sagRrVQ4CgOte9W8Vs
 AMYmgvolzETI3Tf6Jm3C1UCP66QoIxXn33Q34Y+Nt1rLOitTrjHQff8cK8naBVv48Bi9Us4bwM4
 nU4afzbsf8zMgWI7Z6pnAdeRzFFqtso/11ARnCyMgb/811w3n+wn1NoiNkbGGdJJGaxrIF2ZGLy
 rgbyGXQT0JgsTOqDNKMDqqpR1dd00GeZYgXRfIvy9mk1rng8Ybx/y5ymwIz4ElD/TEFdNM0KT7X
 AbUvk47PeJ/qs6lyeXVyO5ZZXd+g6wXsSdfdmdUMYVa7IdnpUof8Plh6gXJOU+hcMSi8BzNgFtW
 Y4GhZu/+8lZGL3wJlEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160052

On 10/16/26 2:45 PM, Joonhoe Kim wrote:
> Since commit 544d85de4dc2 ("net: qrtr: Send HELLO message on endpoint
> register"), qrtr_node_enqueue() returns -EAGAIN for every packet but
> HELLO until our HELLO has gone out to the node. The HELLO is retried,
> but the NEW_SERVER announcements sent in reply to the remote's HELLO
> are not, so a service registered before the remote came up is never
> announced to it.
> 
> On Kaanapali the modem sends its HELLO before it accepts ours. With
> rmtfs started first, the modem never learns about rmtfs and its
> watchdog resets the SoC about 40 s later.

Please remember about Assisted-by tags if they apply in your case

Konrad
