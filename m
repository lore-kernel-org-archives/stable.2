Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992756;
	b=gNThEqrpegjNl5JKS0K/YOmgIb95xFeW7yT1jXVowm6LfRPYkJyIp+kFfjYV7K4Tzu7M
	 aYJKuTpw8b7lu/N0xMJl1e2p7Oh5MwtOSKOVdkKcG3pYVCe9aQUXIwvakAh/UBcHGTcHo
	 /o4KLe27qoKi6dPxvlBQWdjFWaNCzSG3UKuIRMOYyeq3uIH0cJ1WpqZFAF3kCQwDTb3HA
	 8V/uNcKMBcc8sOF1dtO9XgRPMgjUgNMTrDm4y0wz9y219/e+is0My+dUtCsH5UVyfl4uE
	 BdBHNxT1ofXPP9gwgH7fpJR2+/BfK+sZ1PDoOp6suZALymbYoSKXvvIDmuOyeUJyGqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992756;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=;
	b=VePA+uqaxy9iLMynL2zZwINqkhgpEBcWyHbwhpTbkQjy1ReT/Ler7Y9OHHc/FqdN8ml9
	 i3gFWQXpVMMkLK9mPlM9d70Z9X0DpMsbshSteksEGJ19l51wZRa6g0JSY+PZB+dqjJm5i
	 W0x0gGfLVmxiVC3c+dx6qPqG5FK/ZmNli2WrtfXC0QMLnp30bBsUzAkYP/kzLOJN92sVJ
	 COA4ebnj43Te1TbONNjlV2Apd0uPwb6zZiEp2ckj0karQTBYZsODtTIdhFL0yC8v8z/tL
	 3k/A0okNzK+V1DLGIio35l9tPqNAdqHX7OIP7ybiXHM86iD9h54UNN+aIjDDqL65sVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laYZx0k5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SjuJLAi0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C59606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C59606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laYZx0k5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SjuJLAi0
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aVIc3300713
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=; b=laYZx0k5KqM6PnvO
	RGu6cyNnyeLJgzKwlDEdTnQgcq/Y4sjc4sRnknyRgAc9JYmnd1p8XBqr9xZK+PV1
	8vx/RKGXni6cpjgJyURTz9ejj0SrHBiWab0RQ5Y4VakrKH+BCXCrLjTVUx5xnV5p
	CyMvwkBTuWFo33OMcQAHgPw/wYY/divzGgo4Urrs6NNb78aEoslHtqrW5xEw5Ud7
	gAmOwlepjnUHb5KtqdpgsGkHCn3hneaCQtcX6D8KK/zNye1k7HwOpEWPzoRN5uoW
	p2VL3tmvv1Wci4tfQabZx9CbiPSJWAKyJifwfxrHhO0KkhuoWKc36w9OuJnl80eU
	Hk/E8Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshprxns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a05b68f851so3318561b3a.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792992754; x=1793597554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=;
        b=SjuJLAi0cAf07GR+2YrNmh0X3mhGa8B80I6X+2VDBcEGwSkFGzrWVSWmjHY/qo7E5T
         zyOPnEh6pOM5pRvMURhZVDDTYXUh427CN3jSfbfaVMeN0dlLZwMuhf9kSLZE+SIZG2Bc
         TJDLGOVB69bb9GdmEPtY6AtMa93lo8QLM85D2OvfhC0gWRAcZECEONkc53ZFmvUMA9n5
         fjyiWSaFJRUNMEBTGQIXjjd1nZOdsGjIOkqrPQ4v54e+hgFOaaXE0HFOA8yW767VaYIO
         T19hqX1b9z3KjvpAhAgpM5obIyo+RCJxDCmpH22F1eqrjMe2iIR7eeMEzr9ezNoWAGdA
         socA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992754; x=1793597554;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW1samNYYT64bJe09RAe2TapYHj86RTpjxKKlwrWwCk=;
        b=WGoPY30mI3YWOdzLR03oLYiZoyPTm/MUh2fCyF8O84QmRupLJuS52UxzMw/CNMs6CK
         JiF8PFsr7C/o9ZmKwz4GZ1PIbcMM1USp+T74rU9eBtE4k2S2Q3b1CvTWUs4fL7u3qt75
         PNY0myxkoaKPU1ahxlH7mr62BHURJ0oMi+si/PdCuFWCIDw9kdAQodHk+BWPzAkOVzOo
         Lu88p8195xHueVTlep/0LxGgPpeh8OzdFChjlrNU87JCB6+mI4cMLtVLV+lzqvFku6tx
         F9IN7bpu7jVq1qc6+74ZipxxBGksEyPT8fD7OiDptRd4IqI31w2AIrZFbHuGW5l8EFLK
         e8cA==
X-Forwarded-Encrypted: i=1; AKwUvBzzoAFNzswFZ2v5v9X/jMGnP4n/QZ7761DRa8lGTfeB+vmTzoU+PSQxmc4hjw+l2Y9sl/SJpKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ078lQsO1VQW0ijHtPI8VVxPrFbWVJ926fiGH9x//BqFFZJ5Kb
	m9ok1xY6Pjq4mCc0QsRjPY4RaR2dy0YvMc8uavA0JIYiHHgvxKq5YrCif8nWq+nROSKEnbJK2wO
	pQ4Mp2jhzehqVbJuzSsGOGLlIvAV1+ISNM+ZVot+xTDfeTwqVW7DR9wzfZAQ=
X-Gm-Gg: AYBFou0v5bTTyqQm7MKy5wsUEXVqwV7zBM8vY84XrPt+KC4GCw8AzpNNcas8GPIqXg9
	SChKD0dZB8R6VgCGVqwJwKCKdyoq8MPfMnIm8PecuT+4BwJ9/Kr8G9rdRQPEsxXw5EHBb4wpp1H
	W0G3mmtIikSkcLBkInrpP672gW/XJz11Rrf9sjjRZe4OIMxCxIKcanALdXqx1/c3mevoTVyKKls
	kIpWGAH6CmQvI/VojKzAfBtIfJVLMMjDAjPWVtSGeX5S3iugxDVb1bXa4pY7vgg+EjBjRPadn7j
	ztuy5wiPMF8VZn19sFxQbd4nhGYxlkv89Ay0Fyshf6PbcGaS6W3xFGYPTkxUF6lXR+UjC2Yedd+
	RhJwQxt/ab6S7a1ffaKCsnioAstZO
X-Received: by 2002:a05:6a20:548d:b0:3e1:d72f:4128 with SMTP id adf61e73a8af0-3e7c0f3df1amr4025289637.32.1792992754223;
        Sun, 25 Oct 2026 22:32:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:548d:b0:3e1:d72f:4128 with SMTP id adf61e73a8af0-3e7c0f3df1amr4025281637.32.1792992753812;
        Sun, 25 Oct 2026 22:32:33 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccde306sm1046860a12.30.2026.10.25.22.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 22:32:33 -0700 (PDT)
Message-ID: <594e0a9b-32cf-4b0b-99ce-a8e92cef580f@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:02:28 +0530
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
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sdm630: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-6-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX1+/hwg+uPv92
 DriBD/vHj+nxCe9l3wkTQRqLBRPmLZ2oU6zEjZ5Kv8qdF6AZLBtTNphJGzt2ZVXZ2En4U9xo4Gf
 yGrtNnRgUqMsc00hdgTueRnRqpE7/jg=
X-Proofpoint-GUID: eYaeA_UJe6KT8xffkDCjDBuhpIGutKwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX3eIOQu67g0JF
 q7rAZ2hvBbfYHQDlkiEyeHqBUyd5WS1NG71f0aay+I+g/ufSYLCG3TXnQg1CMjZQyZjZKjdGYX2
 s/HXv0dXm9XsbkKCF+G6su+lLnM9F+3NOm3h9cBK5odq1xrRJzUem5NdFyIYXB5bx/k2iFKDZuU
 JHEjb5POanCI34ry1nnpnChskUCCr/SLOrhVgK+uURfoF4AEVAyTjpUUOgj/vZUeE/Kew1qkHJT
 5aM8tsIEMOifQBnmmH2yIYxDsve+4a2N1CvM2uiCqM7psQx1RIp2hFWktaO9T4b8v05g8lx/+Li
 urJh0sLpOHAfni4bPk4kA6c4WE5vUuVdVuHH78cmQ3Pj4hHAhXcBrVH2h3bQthlNoO/Ty884SV5
 14F5l1p+J/W5TRNCMqxg8E96+EI/ssyQVpofKDhFMmuJ5+yn5wDkJXY5YFB3MT2LUO1P2swg/m9
 e5VZgLj5fC4JcSIp1fA==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adee5f2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3XWmBZFTJKG1aVtgwM0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: eYaeA_UJe6KT8xffkDCjDBuhpIGutKwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260021

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm630 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: e8e1fb5c703f ("arm64: dts: qcom: sdm630: set adsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
