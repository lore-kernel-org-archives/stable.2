Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792992683;
	b=5YT2M+QDO0QLvn2mi1qu3D9hBh622w/StgD7iqyCV3wq7nm7NHdjPv666V5+Y6jOynRt
	 2/024Hnf9HkiVLhtPq28MUX5VF0RfKjo1jAPfKPb5GSBp3ITZSpuWJoZ7Rr5JcBdGdR9q
	 jXSYy5wUp3bDzucJaoM3dN/bBZyQxvMuFa5BoI5nMH7MwJf+WbuW/9ZSsiUqf5T6sG5jP
	 kfrcikOk+GHfAspwmqcuP+kKFMoaM2gRA2ZpCkQCQ5/tnuLMa1Dc29VvvuCLA4TXDxAo9
	 DoFtYi+udMtzgIZrDjoS92Jg+6ZCI013LRrHen34vuEJbl926Iwalr6StlAboqk8h3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792992683;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=;
	b=tZ7MZVb+jibMX3W6ekYuwaTn2uw+nEjm6GdRR/5T7Po06w0V2lRPaSLsM3T8WuEe1DIV
	 TeD55oPyW76Mmc00gt8vGNJRMriPZE9szI7R/JnoCd1XHS1FAcqiMOG/bDeKCIbfK3XG1
	 3N6yZwLPR55c92XoUlzH6D0Ri8tnuxZiGn2UweyFC7n3BCMyN5yafp0sd+7eaY2NUr5+x
	 sDeD28jk+YOploE4wJmZmy6GwuIxNuEO4ndL7xbuoUJDl8I2hYsdwl8FM7OwVcp7CNUBR
	 xxWNCr3J1HX2RQyUkrPHSEGyzYldDVIVOjbnRCYkwR5kjQP6CdutmF2EEvCDyDpLgCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjHQO5TT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="etx1K/YY";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518E6606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 518E6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjHQO5TT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=etx1K/YY
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4avDL2727104
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=; b=jjHQO5TT4qCEYWvu
	9a05YClP+echbMyLofIH2MSnKayOoznBn/j4JWNHM5j1s/kH78OSoItHe+Y1Uimb
	Ct9F5kNV66vWR72XMOy5HMtMpk4UeKMYJKeLUKGZ/xU/hEuAfve+JbIIpMWqTah1
	bGBJnvNGYrla2YG4j9mzsaHh6ICJPHOGf8yoemQZc0xD/RMFGhR/Tt2NTgnePEaB
	TeGCb1daDNE4C28WcAQsUNJ7kqADovrynsvvl3zGQIHHluHk2+3DzVYelHVaP6Uk
	OsOkRK+INBDJh6rG+cBvWDW/yZ4vDUfi93zBs1rm+p0GCykW/2vGbdqzakCHNR49
	dihZ8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6n0tc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 05:31:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4831489eec.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792992680; x=1793597480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=;
        b=etx1K/YYlSBFzRyJr+rj54tdeVHHLZ52sIRq5l/tvmD4Nd5bpIemTo7F9q3lr7/AdX
         L4rzDbAs2q6i2vAiqrrX9G4XkxtHi+CDbOd29uGFLs5SNarmA94yA7LWufXoog27HpS8
         xt3uHX20MHgOeF9wyv0adcMKktmx9QWH0fuyW40tWnHnZSQxh3LKY5GO5ipld2lUKOEI
         SIzB8MZXgq/heqBuZnkIxJKcKh06FP9x7gbKZYT9s8N4BayGVRCuB9StDHzykmSu8sW+
         he3aXg3HLzq+4I50356hV0Qp3B4OmhgyIOEO/m47huaCLbgE3dR+Q6kwJjCJhahsIPXR
         aWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792992680; x=1793597480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlujsyuCUi1kWfCtrDGOhLB75OvATIPXE/Gw9ApCurw=;
        b=NHDx8hncgcefZyMx8fP3+tm9piqijZ0FQiqA2ZJiiaqcfiFPD0DnTHMslEFk2C/fMn
         sinyCmof3+3DGHyVnQZdj40tYCA7d6J7cGz9gx8OHl3ZUuHl+Xk9hLbhRs8I0B14ORlu
         xPo76r2tSLUEQ0yW0/X0LmLeztqjU+8nCllHH1Y7OiHTVlc1C70QVKeiZ79PnPTaX+aY
         14YMPwT87ejbLl4+oxK++3QTby++p57WNsphgSd5s1Ru+Jig3EWVO16KFBdGmdxhTByS
         +oms2my7qqVk0dKrCGB/Dm2kSk4OA6wjWUmrajOWMYUnaJu+SVH4h3kSjvOc9AkJ7irc
         vivg==
X-Forwarded-Encrypted: i=1; AKwUvByfsjxHomiSKVO98lKjGfPaO1lidROVYH0cOFWCYhUP5kR+kVNTvjFN2dNPVfLCLjkSEVAyTts=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtYvzT1KYiZii5Pwtc4w+5PmU12rQkUxT9mDFQyHeb9dvqtIwg
	xSTRbwCqHy77e5PC/xIhqi+zfxweqD4oPlGY/mO1/1maxmd+woJouxu85OoLTmxApfrcYYrkvZt
	1GOYz6qKFtVW7H4XN6ELOeQHVMfOyKAFIvm276csX/8Qex/uiNmvDM6vdHwY=
X-Gm-Gg: AYBFou1hhB3l84sPGdEWO8u37fmA1spEAOIPTUru6ql3f4+7qhtvNgd4RFLx67E9lOF
	xpVUksDAU3Xw6sre1Gbkix5Xq6BCEzL4NO6jJdD+1Qw+1+tLTmfPKse9cRpxP+MNlNcZs269crm
	FLRf5bPgGcAjiYE6YC5dLShMwY+PJxOZtZ+HrTby10DqWPjozsJa7Rf5XZPcANSn0Vn70UuU/f+
	v0dGRRbMzzjkJbuHOFDyjgOP2UCEVVHseSryy+FBjW7Va92emtJYKcW0btWehtwgDyTmaAaB1D9
	uZEB7tw+HzYVWH1/GugxWHduxxckDXqxgt/ht7Ta54h7ssZ9qEzHT3wD4EvUptvf/C467OyOKIX
	drn+sN7z9I9FjeGYQw9+05BW12XhqeA==
X-Received: by 2002:a05:7023:885:b0:149:d501:b990 with SMTP id a92af1059eb24-1993677a1b1mr11019300c88.25.1792992680067;
        Sun, 25 Oct 2026 22:31:20 -0700 (PDT)
X-Received: by 2002:a05:7023:885:b0:149:d501:b990 with SMTP id a92af1059eb24-1993677a1b1mr11019264c88.25.1792992679477;
        Sun, 25 Oct 2026 22:31:19 -0700 (PDT)
Received: from [10.219.57.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee69sm29231493c88.4.2026.10.25.22.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 22:31:19 -0700 (PDT)
Message-ID: <d0b68329-a784-40a2-919d-971923a599fd@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:01:14 +0530
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
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
        linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
        dri-devel@lists.freedesktop.org, arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MpJdSSKo5a2HamaZWKpDUQmBA9BnkQTf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX7oXH14HxwDF1
 0yViCbnlPrgvfNC/uJ88TX3aWgA0cJo+lOokRS6zB9wtMT9iQQE+q+Rv9ZG5VYkVsy74I+pvXzx
 WAyww1bgOajbX67/X6xWnzH3LWOEn68=
X-Proofpoint-GUID: MpJdSSKo5a2HamaZWKpDUQmBA9BnkQTf
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adee5a9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rdexUmAEWTTLP2vLS_oA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyMSBTYWx0ZWRfX2MCx0k+UotkN
 qnGS8ioPH749Prk2AiwumHXME+2ImOVTyT7Sv24glAzIoc7lqzG6yJvwoqWYFXdfXC2MTk4YleF
 hws//v8pgh5z7KmLBKPMNu4f0RXoor6OjwqC89IVUveM5++6DFmSk6CffwSdPzx16KAVSY1IT9c
 KLBmlPGW3uWj8z3+AoZfx6wRgjmC+Q8kzaGh02Kwru+DKs+Tf4avQajOoZsKZbGxg6dBOHJK6de
 8FUarRMkgbpFc5zc/R+NqAYQB+LI85F+vCSdluEq79LPKLEBK9Gt+n+F5tyvoxyVbV+TblmJVOW
 m6jf69C3Oxtjbsf/DinGRsyefNhnBuJ/lxWCUzPEbgp2VR4DBbDhFJFPjQuuGWYdQgtNzEZDC1i
 rk/G7SwHU/DuAHUpbvhPOSc6/s2oc6jYdnKN1OUmx31+qG3UYI8SfErDY472waWr8H1nk1I0YdB
 CBWlFwV8GQrL0T1B1MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260021

On 23-10-2026 14:33, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from Monaco device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
