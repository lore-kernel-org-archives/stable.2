Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016122;
	b=0WdwbahGlvfVtu3jUFffkLqvNtiQXhelUjc5UT/I88Rxm9v4iIJtN97zSPfGmGOXLs51
	 wnV/hxO5i3ZDhgM63ykm4OZp6WMOec8e6JPJlPPLKrGNYPTN6m5mtcp8kxj0VKKz81EQz
	 NGtXz8M0u6NlwlRJgbOm45nFI9PNh/uPe9mFMqKDhyq+wPRr4iXrkMmQIe6S+eR/SxP+a
	 BGSC5oOcYMtRNJw0oVGkGfgx+q4N2neCVRGgBEbcSvsYTaG4np8tWNV2l4RmUhP12Bih1
	 OrvFEkeStKOhWBlnGsH+JsJQsRZ5PGBvhcVenFJGJb7swWCDrzl2kICs8lLDEAjl7Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016122;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=;
	b=D7z01wTAHhz5fl8LZsH3V2jRPLq1JJkHNQe+t5WaX92hCriwt71OaG9Q2gc3pWwJ5ROo
	 zkNQodROygYH+w200yuJNKid0Oevt3BzXARKk/8AZVMqZ0IpCQEYNSJ+Ucc3Ob71gJeYR
	 RKG3xMnlNU7UaDayusse4unYi9h8FJJeDcWFjvDD1hCJNUhZgox04N1v+1O85Z+VGreBy
	 jCtfXq+xRg6ipbwpXfIC3bG9rfRU8+K8bOG0+vY7+lbIqBGw32xPpW4O7THbRlvHvOkqx
	 aT8Meb8DNdF3x6nzgLduQGCLRYRNd/tM1VLOari3oly2u79pEESfq3w9ziBm1kj6UrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ItEGc5uu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0p4VilW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A997660A2638
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A997660A2638
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ItEGc5uu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N0p4VilW
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QAtEOf3034730
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=; b=ItEGc5uuZEPb/KGb
	EhHnE2Ni0IRkipvHjLuYd7Vrs9LtGXnJrR9MqECWpw6mjRrLbsGnFVwTJyque5Vf
	g1wCRxRhQhN3/Mgy/qJ2ozw73hvf30vdn3Zgz1zsRPKMnP3A+gfrKBRxjr/sFrs1
	1JR8zxvQOi123lmZdwm7kuNZu5I864qfTK58c+m3ShwcsH+QQpQ4DUcIJuuQUnwM
	sEdh7zoTvXgntul9ja69eZVwMSrOFqrElCp87JeKYctt8TgOXSxWVaDEX5Lax/uH
	cY6J5FIbc0qRTQuxVoq6D+CdSCfCl8+3GswbcrthaA25f/A57Rsbk5z4rjeZoPe3
	hG4+fw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y099s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:02:00 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-988c723394dso100154241.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793016119; x=1793620919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=;
        b=N0p4VilWxUwDRPDcfRXKMYcP54sedUSDoMJqH1WYoxAqD29+sCTH5fwr/drMue6MPY
         ymjn/MZQi0sRBBevjsAPs1lLJp2hobC1qs1xj0MEPTrnOsbyxrnLLAG2uB1PwBioHnYA
         vpm2zvT9LCgHFihSIYkT9J4MiW359SvvVdKVogLWizXWJQDrYNogJwpyl8np71uoqvGF
         XmDTLiksNPa+J6RjDEqw8TCe7R0lpz8Zs96bavVOM7UFIS5nPOhICnWep6bu3VZ7qlcd
         fAm1UUrcQ6RYIyRMUEKWakJ+xV94VOItCRpDMdvoxbnC7VsaisiI1Y3jUhsDVDPmN5mA
         vchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016119; x=1793620919;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FwZpsfmJUNZUlkHboNK+aqwI7PKWRJo811Bw9yHhN0=;
        b=RXsB9C2v5YA8zqEl3i048fZXBkzK+Lci/n7sXD5BknTvagJcNaGPP2vk8FJ+G8KVxk
         Wql0N88zMeWEpu+DT+aiDRApRRZeElEGSxkdiy68dwSjjY1GKaoYHmhbdRabU/nm4pzg
         amGby26J9LPPyZ4d3aqTT/PD4rCHyL1SN4aEN9813PfdyU2TPjrp/JfX4r/ewvtjvHtv
         lqe5+UMl/k6ryS2/UqdV/EBAeXmI77x9t5oK4NJvGtfOTLCvySF876OFZvWsIbK5a06j
         7Yw0A2zD3wEh4nJGRRlQCYuusVHlVX5aTP4taAYxug3o6Znh+OxoP4lLCRQpTFcu7wVT
         toFg==
X-Forwarded-Encrypted: i=1; AKwUvBzMp4axBzwEpcYKjDuDBt5kZatCH7IKeKfxCnYFD99sSszUSJ96fiJMOatdjyiv0VYJN50YKbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFdek//W+7aI7uT8/pAlrIBeI2ynRvtMzNRqycTN2yA3WpSo+V
	piENrqaQMKCrm9eSdP/5bhth8DrimEoFzMXfk9qLa/abxfbo9cRVVJi5d+3Flw8Dpm6tq2xk3Zo
	jMDmjl/yKKmYp+lp0q0qXOLWqv/dg12IHuIgaVDalQ14VLxgsLS0nYINmYko=
X-Gm-Gg: AYBFou2r5daMmd0lXGPKvGv7pctP5n9wQklkeMlJQGKZAiZY37nEsRlOT1ZNGZLYtI/
	1Sr6/TkndDIZTS4F4JDJxUCnT8p/FxXiTVjFUJSBxaS8zYdvFpug4y/OVtPhL3dPE5dH4ycc9jx
	OO1CcKzQRnnGC0m6ye9gkppLPwVEB9yTbqoLZP1wF/bgIuY4QckEDHkZrXOJ7AoTUEFpZOGw5RL
	l3PuR3idl0y7Z8ef+t/LTu+tYreoptQG6ORruBKqBwxXh7qd2Gskb5YdvEGW10fG9W3eWYLTF+E
	FAS5rJLZBtVS8B7HZaYQiIcQSarpSfsPFshns0l4iW5r3RGrmaZqFN6CK/47chH0DtH6CBxcfAd
	syJDSH6jx7W+AsJMbyLqOpw==
X-Received: by 2002:a05:6122:e012:20b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ec22ecf6e9mr1504393e0c.0.1793016112535;
        Mon, 26 Oct 2026 05:01:52 -0700 (PDT)
X-Received: by 2002:a05:6122:e012:20b0:5ce:23fe:84d8 with SMTP id 71dfb90a1353d-5ec22ecf6e9mr1503020e0c.0.1793016106287;
        Mon, 26 Oct 2026 05:01:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46c59c063csm265518866b.34.2026.10.26.05.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 05:01:44 -0700 (PDT)
Message-ID: <9845762f-c667-427f-a848-ee1cb1291779@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:01:42 +0100
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
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: lemans: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
        arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-2-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX6FERSvIaYCKg
 suQJ+QJ7azJyRU0gLbIK7E5fk9ayvr9z5YwLmkNGhjmDfymjuSyeQIpyB8lyH2QeSJ6MhUo1zJj
 aXzfb7WX+GNvI1P0U5vFur19otzg9iA=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf4138 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=khcIRSTurGpjo1Y0ADwA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX5Z4bbsKSi9h4
 HMJk2yeTE6/LFQtByXzGq7eitJyEK1ZMRoF1jELunnPqv6b3c33zovVdysfwfeeIqkUtLOMxyDb
 X78keAUsDk+fDJMrRlWk95Jr5h/PNP/PNerqOxzTmU9DdqSms/OazfXJoHCiDVX/muRm4WgYgkL
 PrU448W2gMFZFj9Qbq9G/TJi2nxW891X8ULmgVKPsGWXao3OEns4fzNKqg6fLW7NYWOxX9dmzH8
 n2Mk64Batpaiq9C/W6Bl2jSEAwALW7bVJCrqVUHYTtWqBQS1x8UozXa6FbkBVc/WfwIuktH1BuR
 53QZWFidjAPaE9SRVhHI+S6FsmrurPfRSx4GmQXMRQ8bGCnyPk4/byRMMwEdIxM39fxB4dNq6VB
 R6ZWyS8gMNlIIIbkqaP21OJMssdmnyDdgUeE5FnSSe5lEagjmLj0W345567yCqZmhuleuCu8Kff
 1sB5x0HXPLOf115Ixsw==
X-Proofpoint-GUID: G55A2ft0UnGe2gM0lKQu3hHPay7WtrpW
X-Proofpoint-ORIG-GUID: G55A2ft0UnGe2gM0lKQu3hHPay7WtrpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Lemans device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: f7b01bfb4b47 ("arm64: qcom: sa8775p: Add ADSP and CDSP0 fastrpc nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---

The documentation doesn't concur this for this platform

Konrad
