Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992727;
	b=SdcEyrvSjOXXO1dzjJ1AXCL5pkj/viOL7rzYs8d5+MLMVbDf/oq4S1ee/vmzpZNbfI+T
	 UiwyMAQ5PsyrNKX0Gvcp44lYZ99jfB4jP7Gsg1DLkIy3kOP70Ur2HBzstELxY6IV7TTwr
	 Cnp7SLdkTkq8MDarrI+Wl6D0k60q5SPtYX8dPPPMqIlbh5u2sXdhiYXuOUuIBqhUKJHGr
	 vcCTW4Gy3FFHh5SORnqWdmSGmK+UeEQAZi5pne4KFiny58kzgY3deqPszygds3y5zCdiK
	 sJZtmfPHQUVwP26aA6QK91nnxZHrM5V48z8TJV1knVCxqEiEgnCYJILaZNYzeFFXMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=;
	b=ajmdamsfQOcnvtxRfpxmLG6iQl/JwmLSS167PKNN/wa5u15PYZmrAnYXDWWPPlIDn6qK
	 G5jSAXumYv4Ocy+NM/8aeY5Ufpkmy1P8e0bnl44ThToglX/PdVXjM/ulcZBmCypny4g0s
	 XanPfpW5BvzFmXZ6JwkI5gHBxd5mpVuJY2X0p5JOvUxM6onJbhNw0BVJ/eZ/hfi6pqbLt
	 ROlh3d0xFcnhs853YH0nEAZq1QzOyekJnv6f/MxEsdgSbyNdZ02b48EKAk4MDRrSd6S+c
	 ylBLYd1KYZEL/I/sLoCeMEvMnhU3uaGhqNBrUjiGo7lEzg5LWHGoYvedzzLX5uUDNoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pjmq54yV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bnd9b3gr;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673B606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1673B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pjmq54yV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bnd9b3gr
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4b7vj2206426
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=; b=pjmq54yVpPurVyB1
	3dDQuNvDNwsRIAzCPtq+eS1bIKHv9qdfPTBCDZ9SYpmaYPNosDzHjw6kBn4VcrVG
	6eLUEJzA+ZHxSBHnaqXeArZSLPO0lkWfIU54HU6KkDaWWFepRO0pBLKyQNXuY9Kk
	bJuZCwbbsDBeC/ZQ4tGkwP9+PPqz2Te1Qppl+izvLhat3cO3AiX0aBDvgOoMj0Ew
	E68yXAiwV4R4OV4sLaizjjozKWw7Yfy3QtiaeQ/0Z6RmZlMZORDpfzxgXyrMw/mc
	xvkLYQJ5rZzZTkHRa4RqGq+tqJ6fNUraHbA+32eRPUHkHR/i2H/Fc0vnJpgD1ZnJ
	7oQDAg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrumvt0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:32:05 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1665200f4c2so3045426c88.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792992725; x=1793597525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=;
        b=bnd9b3gr6DoMnossatN68Cx9wMSwzCvXfgakBJbRMV/tCjnWcev6dTR/9MDoCbTrko
         wfy/mg068k0hEMEipJeeUxIq31yHZlggcR2c53liX5zgEO1uIShnuVvgFjMJ4SmI1j1h
         QLS4nVcCuE2KHs4Cc5XLE4W56qhlrLxH69rJkzyJ6O9HL36DaKbGu9XJRD0iWjHpJk2s
         uh3VNEKPbcy5HnjcRP4j4UgHF5Q1x4gWHNzIYMwzZ6sfDrdBQ08Asx2R8TAFufPjP5NE
         WaJIT4f8OvmOhNYeigJG5IsnSdFF11e5h3hKgewX2Ttki6ivHlc4FQ02jujVxuzRK1H0
         dw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992725; x=1793597525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+pIQ82vdej/2mAxE5Ss98Wl8RmyGvtFzNZ9cyB2WStA=;
        b=ShcKrZLqnjdOZryIknfwpxdjNKmAVJc2AWoOFqZf6Dgdru2Yf7AiGPn+MPlX3f+BOs
         O5vwD3i2iPtUOr6XXkAnBZZsn4EzYaM9+5LZjc8V0g78/33ajim/YGogkzFL7QZgScIi
         5AqJ1HkbPEBxybBc/t2iL07Kic9GR0J2IC1/T28OOtlMkhgao8dPUA5klimMJ+fnyzDT
         BPWPpVd4CZREjLfIqfml8u4iwvEyQLetptelYcAZgbAKb2FguRm07jYEb1+BOcc4pLHp
         H27mtILQKBVI3U4Ay/mHi+oXqckgylNoQvxPpi7WW+leAuP4ObIpGr8wLcZOjRS/AUON
         4yiw==
X-Forwarded-Encrypted: i=1; AKwUvBwOrlJcjI+Wou5LvG1zORAMK/Rw6Me5/WoKwvWu5sE6I8/KvsyEY6TSvqnuq0FZt43f13nAXXc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRL9pmbHep5/mtjRUlNaM2EspV/SY5LyWPr04Ov4Yp574qm1e6
	Ni5asAC0/cCy9cvWcHyJASJ8JQ38UaSoVzcFpjFAVpUUMLTkx+L0LNA17py7EJivZKGTLfr1kte
	9Jbcq3rf5fKT8wttLAne/twViWrzQ3DAECtVuzQaSbqbvrNUyoOtPJDMQ4k4=
X-Gm-Gg: AYBFou37eaRapOOn13EiKfB0+Z4ledoSkfPDriW2UyH0pdSgvZbaWg1SEJKxs3oIrvm
	aqOE+RLqv9hJ6K33WDVEy2Co7qa7MrBXIN9QPRieGPHM4RYrHUhJ/m0actYix5JJQZctIgpKrvL
	ZlE4qLcw/S5xfj0ZV04myyiE4hmBludiHZcdFXskWXFeEAjahVcMDZbySz0zMoYxEtfqJrTi/yR
	S4paFKEQ9q8DKbXDjHJ1zGlpLq882tz2118hH1q7CD0KM2J/jquNHZcYJj9AZnvraRGk2qvQO4e
	EwVMp9leOVET8mzcMkdt1BGuWqmXeRbvCXuMNxNw2DYuvO8oTPutOaQAqmKDcgqJ2asIBsIw6TP
	6Tu5r+ISwo4PNYxcYyycSYEykAMcC
X-Received: by 2002:a05:7022:e888:b0:15e:3a65:5b97 with SMTP id a92af1059eb24-1993505df58mr9283569c88.16.1792992724878;
        Sun, 25 Oct 2026 22:32:04 -0700 (PDT)
X-Received: by 2002:a05:7022:e888:b0:15e:3a65:5b97 with SMTP id a92af1059eb24-1993505df58mr9283530c88.16.1792992724312;
        Sun, 25 Oct 2026 22:32:04 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a064510b0sm1838859eec.2.2026.10.25.22.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 22:32:03 -0700 (PDT)
Message-ID: <d0f317a5-430e-47e7-bb14-b8d24678eddf@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:59 +0530
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
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-5-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX57aaYt+mdJt2
 xo2Q3qjicAJqzI9AjjaGrJmACghh3IGs61/GVpUie8cSigZk84anGHzoSwWAaoiemSM50Z3YR5s
 GfAUXjZLC9Pb1f9Jb0CSs1gzRO8IVuXypFrRSgWO0Cm3JXt5SgmzE5FV9fulBCjjSRci4tC8FE7
 mbvL64il+hDGvrXzlfDg9f2Frwz/MNNoLtgDs0GnzqOL0v5UCeGkzQeSpD5UeqoVTiRDzYMMw/j
 ZzHIDdzRnkLZ2r4PT7xm/AcYnhdtQho9wiEOhjI+wuD8nXAjIG7H7eHwzscZdDcXefhy7e72WbD
 qku3dWMSa2f+X+XfUqcqR3zPQCp6YFGcWnKn95pGEP8RlrjzfDGXID8NmUrSPT2l7wAGKnv5WwB
 LBvLs2zNYpZ0L06qnVSjYmoss6NjfnS0yrIuE6XNPq3Iyf1D4fIbh/+IylrJqCKjc1tHJKwlWFJ
 7cQRkwjr9LzDD91MAJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX476kLNxP8qlk
 U92dP3oBslFTZBV523WQP98a+guuHn/ZuUQV7aAVe+PbVufwVTDCAhPNEe3/HEdZOVc9tWnykbz
 sHC8kWyA0IkKib4t4o8x2SrxIGcC/e4=
X-Proofpoint-ORIG-GUID: _oW7dnB4SOaftpIOnE4NssROmnSNn40Z
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adee5d5 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fi4xyBuKck7nv7155uYA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: _oW7dnB4SOaftpIOnE4NssROmnSNn40Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260021

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sdm660 device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
