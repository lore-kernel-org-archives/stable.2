Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866077;
	b=q2OCUSOZBEFGBSyLxLdUYhE55ys6UdnE4rGytZpSAAEdRJV6BScBvbJMTNWO1VyE5SIE
	 3CmmUCdSft35m4zmtC9nhOpyNbLgpMnFWHJ2neO7OMdt9xVr6mFAWio1nteqjT5xF+Byg
	 R6XZZrjyQkuarG4YD3Y8gwSBlqjkskbUexnJJLJuE/uHxZiYmzt5opZThR+lMYxfuDxF1
	 5sObjcY83hx/FOBCP5qlpvKyvknuj7FbGJGt+fp8LvTUx+HCAVx/6zVzWxDO51+HXk2sV
	 mHfhBE2RiNFcz5cN7Mf8/RNQWzwNOet2M8z86tDVl/jaCBdkVDngrxBoG53ZN0k9B2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866077;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=K5CgyL6wkC55flU3cPg0zwdEWrmj5DP7BYobqVRqAyo=;
	b=TQGP5lCwKs6JJxm5E73QjLc0PujFBCDp9fJD0rptbHjgQefyW0P9lOgwmsa4PKkWI4gz
	 lyB8reMADQDjPtjZBxkkt9/C1ZTKXpAFXOs6Vm438IwwSs+kj8C+2SVDhC2AtA5ue0Rq5
	 y8jXn0yhU5IzFsMb8reo9ytgZOpCzF0haqDIC1CEv+XEu4GZ46aYN8a+ywNiBv0OJOjLf
	 xxhJAQqDL1rvYyB+mUuU028kCjXZUzDa3ESQu6kKVu3wG7goxwL8+fcJiNJ/+Su8UZG3g
	 b4UH72Edb9GIiY6VvBNLwjuELoKCtvtSUZ4FpmZ8u2q+gI6RtL0HsQE4kAptwdrLqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OzQDKC7C;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PzZcaNCV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CFF606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7CFF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OzQDKC7C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PzZcaNCV
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56U4Tk565134
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K5CgyL6wkC55flU3cPg0zwdEWrmj5DP7BYobqVRqAyo=; b=OzQDKC7CxAHiLMut
	iSdFiHG8IFC3eQGM0ZWd75RncmWLuW+xyVeW1uJBPYMdmyvXPqC6gX5TYF9Q4GNC
	0mSWiVWqV6IF2Yl7XkVhhpuE179UZCBKgXkpVT14+fzxC8bRDh6DML76K++sai3m
	JKNawe4sK8cWyGGB/0v1mYLD51kfDi8nIkRnlwJdlPXJtsYeTVO2koc3RZe6l+pl
	uJ0nOxWDhUpozvuN/DwVGR30B/QMVtgBntMQ+X/LBVMLT9v1bG0M+jDWnXLGRQgX
	JFZx7LIhsnrX9TTn1f7usIieUsy2I8XYc7WIcJqeLWAGKbX4NRuOzJ07VI2zJOz+
	9vjNfA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaq8pn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:07:55 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ecbb3b4696so9374e0c.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866075; x=1794470875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5CgyL6wkC55flU3cPg0zwdEWrmj5DP7BYobqVRqAyo=;
        b=PzZcaNCVUN6WoqFdqwAvSQwqwEQvdgBKxjRfpxHtvea6whNOaMU99v4AfsGcpx6nGC
         1G2yd5Ac721TqyJ9+kFuntIJ30bIbRfWLfpAxaPgZrL/B2rs3YAe86kyndw0x9Ho17X5
         JpWptze+Tjivz73XCs1GFtpfkm9QJ88fBa8e1zeM8DlDH+ppreG3PZGiAEX+hmAIGJl7
         o4gTxyecLDLyDg/ULxEcluGZddLdnapcB2AZOpUilavH2sSC8Qvag27Di7qFF/kd6liv
         9UQAsG3GOdVV5TY/xD20V3Na71DAPFyQmM2gi2sIS+b3FQLDjpO21VdleLMXOgQRmx2w
         HXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866075; x=1794470875;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K5CgyL6wkC55flU3cPg0zwdEWrmj5DP7BYobqVRqAyo=;
        b=lLNh0cVjXQjkzHH34tbgxqiE4C2rMfB2YFKC4OqnuMyKzZpy868mWTEE9b3llC2tEB
         k3ZjcWB+J+UwscEsexssveGhwDIL7EnnCS5lP43xJShXKFuj7hk93hxGAp5dMVq68ruy
         laPtAcpzVX+H49fKlv5oIqZvUA48lXGVU3LAWfUPSURok60aRYeuLhbSC5oGoT34Lg7O
         bqQFHVVZidVT6qOhcLrVIi9A5n2BCLVg4/FsqVd5HFkw1PDsZKWs3MP8XbHvw/lzehJ+
         ZCWuU4eXpI2/D9LVbmxMxTbdI5B260LvZclPX31BAyzSn2GOHugplnz6bZNWT6L6ifaP
         OY6A==
X-Forwarded-Encrypted: i=1; AKwUvBz8hfr1Q37/kRtfw+ayz0alJiirF0i3owSqi1uEhFiB5bKhtOitOJRD/iq40rrCVrzxS+nbx2A=@vger.kernel.org
X-Gm-Message-State: APuU4Z99sjDlGK8SjB/k5AfAGS7Cl/ScFiLVERnSmVrUY/l8IGy3fnBb
	3RFAO+FnrJ1w/5peClS9/a2QuH6xqjRDfkASWIsztIsLxxbPfW89CfMwhcBqdKP/87xpUxe6M6e
	fEuXhhNnbpQauv6wILuGxkOPdxuf/Fo0/7IA0+Reppsf5DZAf6ONK4tV4S1M=
X-Gm-Gg: AYBFou2m3RkYQtKGa9iabNkw/vNe//K3v+WNpZsh4T5vm0dOmXw5texcLDEQVR5lNg4
	CVwAIeU88EZVciK4B0wJrnamaaU78ae6Z2+zYnSNsaTevwXrV70JT748km4v7BUOX2x6cM6sDdG
	/cXGW1lC6W6SXmvIw0Q8bqSrRDsGI1HrFPdwpPbzpIKoZclbYAQjb2BMk0mcnXjex0mvvwtoBjB
	mSvGljiCrdkkDSxpFCq3JikkRCqGNFKBFeHnR7SV9ixc9hhtTmA2uUDSldEoXv9Pn49QPJTmTr1
	ji/xglCB2n0HNBeXsjVwaZfaYmGaDmbrl98Fv2cfuyxkBo2tjlRZUXi/81KaFFCJMGK9RU8sPmi
	L78PS//7BfeRf6KD3NQoDAkt8eNZSVyGts/G1ShFva1PJm228cIOlBMpUcHW2Sl+c3PCf
X-Received: by 2002:ac5:cd24:0:b0:5ec:abdc:bb72 with SMTP id 71dfb90a1353d-5ecabdcbd50mr2502457e0c.2.1793866074971;
        Thu, 05 Nov 2026 00:07:54 -0800 (PST)
X-Received: by 2002:ac5:cd24:0:b0:5ec:abdc:bb72 with SMTP id 71dfb90a1353d-5ecabdcbd50mr2502424e0c.2.1793866074496;
        Thu, 05 Nov 2026 00:07:54 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e1402c6sm151963566b.2.2026.11.05.00.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:07:53 -0800 (PST)
Message-ID: <31d38c50-665c-4f1d-b191-55ce5d38660d@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:07:50 +0100
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
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8994-octagon: Fix side touch
 interrupts
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gustave Monce
 <gustave.monce@outlook.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261104191700.676773-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104191700.676773-3-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _DyxMqmfHAc7iOhyqBZJqtHZ_c8IRaFM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX5e5atEJlFv87
 0huHkAsx00fq+HlM3EcRl98wMq8RBbWWRGtejL7g69vg0rxF25NoTNidkTGXXLf6KM8aHIFjHNd
 IwHRqZY+KCxmCUzsRP75eryATAXkwNk=
X-Proofpoint-ORIG-GUID: _DyxMqmfHAc7iOhyqBZJqtHZ_c8IRaFM
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aec395b cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=S5PwCt2dg2jEj5C25JAA:9
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX3A2ZfNW972zO
 CSRwqxgtPKnQoKYSvaW3yKRzLmq5+YLB4fnynNFOtZNginMnJ4C5jAjfJMHYc+QS7c/i7YGjKMF
 jdCGTZPRfAr42xxT6HsAruv46SL6RNURIQsKsyhR3vIgC/VaFUd2np4F9pqLuhu/h3l9hnEahks
 ccNmNR6t6odJD9t5yU57VAPRcZEva9GXbHV5M5C2jeUwliDOOKCouRRnX1Vv0f/e7JEyL49tiUJ
 9/tA836lxaYtXK1SD9ycjWiFfy6Pyu7a2E32HsRz+H4UY384RB2vmYUxUJ1LjQcYVYQzcg6QQWU
 hagHayc3Qnlpge8Ug549VgeRtM7cm6hN4o5MV1UgHqAZ+lIjgQXQrypswXKuvj3fdUN6DHMZMLD
 kiHFl7GdgisFcMq8zF0CH5l9egbZiS0+EEdjr5XeeI/p804u8juu+0pQsntypaH5TGdTewKAd+6
 Ehs3l7TRIGlT0mwNEXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032

On 11/4/26 8:17 PM, Krzysztof Kozlowski wrote:
> Interrupts property takes a number, not a phandle.  Passing the TLMM
> phandle made most likely the interrupt as broken, which could affect
> touch operation.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-759fcb27-d081-4ec4-9683-6667b54fa3dc
> Fixes: c636eeb751f6 ("arm64: dts: qcom: msm8994-octagon: Add AD7147 and APDS9930 sensors")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

fwiw

https://lore.kernel.org/linux-arm-msm/20260911-topic-lumia_drop_captouch-v1-1-6f92f1f3c6d3@oss.qualcomm.com/

Konrad
