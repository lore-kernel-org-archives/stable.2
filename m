Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629673;
	b=TchEuBwSa9yBMmBgfd8zloFWfhO08U5z/Hs9j7Y9VCsxXRWgk3NKcendk47INZ5hohTk
	 zW4NBrtx3QU1sdrxuzooj1W9AMk52k9o9u3u1ejQewF+9LW1UfLXuJ3CywaYowgijXJUN
	 vHbNMOMn3RE8I8WyaG4XefsPAef0T4f3yuV/ecnnH1SjTyflJuFRd8a6poMyCQzKi2E5A
	 QvqWKrX/xYswvVCnJVOhNEXxYrN1PpRfkxnR3pT8ATtbNsEiDjolQ2UPF3qmskVtJyHIj
	 aw3cOEF8mM77j1oamt/dGutGuiA31OEfBsqqaEpvwuDLvdKU78xRxNhrHJ8pPVLu7zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629673;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7O78g7drrpQA9NJKlkHztJt8GYgTb6oyaZ2MZ53tc74=;
	b=yw9+ncsFZ76VysJYhREBVAdvba4bKu+tGxgZcST3Sl9dJ+KxNgOtkTSayNjcOFOapke3
	 w34Ej/EzMIitR3R/t/v8k9eniJHA6FNJE3aatAcCCqb4ej19ozLrxGpu0Dv74+sIPn3no
	 cf1bfL5JhqQqrhABP0ySumcTjZMDiogJD1Wb765aFuxD9C9oxPEvCz01LL2GcwbheNsxS
	 bc4GQk0vVjpiEvMaMEHgYOai1Yas1IExnEcAQEluQFWWBznvx9M12n7vXx/RoMyCxUTpG
	 Yt3BucJX35Y+mHCvXtJ9BKUXh1/1NZzVurMW079huiHAIESCj9RchgS3cGzvuEBMCBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZR8PHAVy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RQxuUbuq;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D0606F3C4
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 770D0606F3C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZR8PHAVy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RQxuUbuq
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DplqO2449634
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 14:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7O78g7drrpQA9NJKlkHztJt8GYgTb6oyaZ2MZ53tc74=; b=ZR8PHAVyDgsqVgY1
	AJ0KdeAERdFC8n6jm5aESl/nvRkNb4UismGJ1/QaF2jS61QVDci/f3rw0DlBr8vL
	Gx27VXo6ygscZf13LwXN9QteV+UKKRETx+IlRmEjAmCkgrOOv2d/N4535o9AnW+C
	Lree5tpHw9LWUOhfzpTPtdEbWo82Xjs/uKMxeNYEL+/kQSQpSQsxYcxnqZkitj72
	2rK6JJEXCx1kTifg0o5Cuy4i5UqhHKVn3gDslXpQmnroXKXISqyjLdUBM0zEg4Wt
	8LRaE7ADEriSdp0dLu2SXByspYK1bGuYUL0gnJbUngyOxtd2ZUXxCl0Hc8hdFOru
	LUgNLA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4j39m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:27:52 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9833e1390beso44748241.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793629671; x=1794234471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7O78g7drrpQA9NJKlkHztJt8GYgTb6oyaZ2MZ53tc74=;
        b=RQxuUbuq1/DHLsRrpVazR92QWu+xyrmNUxI68PLOirBLWH/vU7fvbu9K/GWk/dPMZs
         rkEceJgXJG66Tfx26z/GP4xYFGeAbt2BXPZx+BaTbvMxXI6sAG6WEjVAWX5ObpZYaIcP
         FfGNat1azY/bCbZgl3eejZZSQBN/gUbv4uOEazjHz4GaA75V9xQkdKVpEtVtNfXu7SaO
         sXqxHW3y1hxu+ucfx/cY7216n9Ml6+40j86FC8yBAN8QKwaTyWhvgIhfg8zQBbZVoqVe
         CKzFZokMckQ0nzS6qpxrAreltWi2xuHMx79ffmuTbhap3fuA6neDZBseYwuLCxioRQ5q
         9/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629671; x=1794234471;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7O78g7drrpQA9NJKlkHztJt8GYgTb6oyaZ2MZ53tc74=;
        b=fT5itGA6ZGWOLk2eUtKc2qqBXswlN8TsuSqrUsH4JtrbVpYSUTo/elXQs0E5B4AfAQ
         1yRJWPqQ6p5oIZPgLopbZ1g2P/bEjC4JRujwoiOMXn/byfCpXBLgWYkrmECqHst/E1aO
         MCVHDoXPJjFH4Cd2fGqoePPlV1DM/VQtwc8VhKX7D7TOTfYJsxKd45Zgquh8dXY/amZW
         xOE9vu8gVcHM27lCgqObRAZ4XpIzLOBiCeX7hoYLKjbJjqCCRjfSSU26x1jnoHbfvZ8C
         cNFvQn7mQ6j8Q4Kqr6V5Kyrnb7d6CodeR7hDD0Db2gtjIkYN9glybK0ICtgWY7iEPzWo
         WMEw==
X-Forwarded-Encrypted: i=1; AKwUvBxLuMGE7dSGB8nvyrB3I5EDO2ZGglIEARH1g0tUHIzg7XDIRmEgj/qrGaFFl00IacqhSfLpEKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oWeCYnT/47fPnwo7QKqjWUtnR13ukd3CFXLvnjI+oYZ29BRXZ
	HWJAQchqhsOoP+T+PK1KRCXoX3j19VjyqWLmw7rjdhMEouhCke72gHBr772ygfXnKj9C5HhIhNs
	weaGeI2wP7BSKlkK5rjKPUarfAcnwk5S0v4VHGNd8piLGIpYPi4LlOi3r2Io=
X-Gm-Gg: AYBFou1S4ow/29lJAGhDHOvs87htDBT6obiOZSGvpoQmEaM4LkhIUprHD++iuH02fB5
	QJFVW/KsvanIyjciBJrHtHw2U45kgrlq2KQtn2QcaL3DW3ab70wp45ILZXq2hDjR9UPh24XiM1f
	06XwPtn9RK8ESdvmgaRqn0EA7HElECL7WE3rZNrRHQu5E9YXtHg1azkq/t2GtEZnrxs3BDXTKRs
	QPcgfpYiUyNEu5awBVVnk9vzb4IVYX6QU3UPRCj/GFniOAYY5WrCuyezfDH+UMpesqNQL7dG3mD
	P8f4Hq0p1qcnmC13iwySyM8LpOiKuzXVAQM6KAP05ki9VqEnmWnsnZyETqoNTs87aOPVYkr9y5C
	IBPNfZ0snYImf1XJefA6tiah1WkFW3wPy2XlLXFjmErxBIrciLHgvxPQcu+Wm7wnHiDFFHcqKC9
	K2DVqPCAKhpVHnb5IikGOv3vu8+6ZkXQ==
X-Received: by 2002:a05:6122:5318:b0:5ea:9c73:eddb with SMTP id 71dfb90a1353d-5ec6858c115mr5084396e0c.2.1793629671121;
        Mon, 02 Nov 2026 06:27:51 -0800 (PST)
X-Received: by 2002:a05:6122:5318:b0:5ea:9c73:eddb with SMTP id 71dfb90a1353d-5ec6858c115mr5084377e0c.2.1793629670655;
        Mon, 02 Nov 2026 06:27:50 -0800 (PST)
Received: from ?IPV6:2a00:f44:e0:8d11:8079:3a24:c57d:745c? ([2a00:f44:e0:8d11:8079:3a24:c57d:745c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfdc20sm392186166b.19.2026.11.02.06.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:27:49 -0800 (PST)
Message-ID: <97c4555b-aa3d-44de-b5ae-9d11c708b530@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 15:27:48 +0100
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
Subject: Re: [PATCH v2 2/3] soc: qcom: smp2p: Fix out-of-bounds with incorrect
 DTB of too many outbound entries
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Chris Lew <chris.lew@oss.qualcomm.com>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261102133531.173434-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20261102133531.173434-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102133531.173434-5-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vHTjcMZxJpuXCSpbSmxxH0BXxdVO6-H4
X-Proofpoint-GUID: vHTjcMZxJpuXCSpbSmxxH0BXxdVO6-H4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX7zhxvXlrxW8j
 8uvkS9BKnmTm1fOFJ6ykZwxOc6BTzLTQkRARjysNO9SPKnL0vwumN3K2SoAEA5GBqb5t9uBEEDY
 fO4pTUgJyQCrXz5+lgB4XzS+leSq/OM=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae89de8 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=teR3AlUbzk4yVbe4HIgA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX+5K32IkCgzuy
 GqvYvXawWyEazhAVZ5K1TXuqV23b5Xj+X5GEkEsbw7ef/ZLIoZSviikn4cmbpGAGDR8I9A+xu+a
 QTFqhmzVZLjkHdEGELanXWCYhjO6bL42DQR4kOM0hPOxz/AczSxxe6vvZTmfWyEKCbk5D8BKSdr
 SuRbdRLcmpbQRtWdcMHv62egykk3XD6sQQxBXHj16IfuVQPMmgE9IQajPTiTORsG0iA1C09FWU/
 W2M8V4QpnmbJTgAzO0F8fr2/AmI54rst3NQSlhef4YVVWgGdJ5IzbZ+AfJNrN9oGw+gwYMBfbfS
 mC3yiR1EShabFcazHJAHVSBAz3ojb/yJsJYO9UhnWMUPnbAGeRzxKKTLrR5lXmaaOg9XKNhPkYC
 KFnbYu5K8CwxKEiV4T79NASs9fK/3cXId62sSuvONK6orjJlVfzaiedbKz3G6yDH+s1/AjH3q0F
 9ku5MM8Wzu6w8zHVDnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020057

On 11/2/26 2:35 PM, Krzysztof Kozlowski wrote:
> The outbound SMEM item has a fixed array of SMP2P_MAX_ENTRY (16)
> entries, thus driver should be sure that DTB does not have more of
> these, otherwise such incorrect DTB would cause out-of-bounds writes.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-eaf9beb4-cc0d-4d8e-be28-4c12b039b3c8
> Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
