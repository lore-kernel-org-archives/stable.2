Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798506;
	b=KdcfKa+FnQIFqrR0tl4KiFkjNbSnOut/jyamWkz3wsnDhcfEVLG/IlHs7jedi5UIJ87R
	 Ffh6OjAVObGFY2xAOjnJqTvwMtQbjjbIFk7iLXgAhtJ9E16RoCAF8izfBe9jcdAvCq7Nf
	 LSLzLw0tbaP0ne4UEYKMU3G2gY3WzQqHrpuvlyYvjG8bbgT09OenSNEB74toL1qPJiCTx
	 IJyVMptKmlAA8uZs5/QvQ/meVNGTyZNA5P/YcR4CyJa9+H8YlwZBmrVM3N1lovJgKz7IT
	 MaJr2LghNjQsCwOfM66QAwRTjgwi4/k8vDhJoTMjSOD4TFGGDAZyNeCA8G0fQEX6xoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798506;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bdDbdezahsnwvvodBAeZroZhoHCyGDtmjwh7kWkAIGA=;
	b=TQGFoYFS8YXXdwF8DAegiAIXkOHcuVLIEVqnCl3aBpYBMegvabeS6+tb46CvMMMyWBgJ
	 wN6b15QR6bVhRzP+zhErIndjwHUUz/E2J6d05GgHkQ3pQupOmNjd5VnSeLLG4DPNRfVzv
	 hJv+ox0bEExBEdu+gbeV3ZTBYj4szOK8OhKyNZ3ZihAcX9r5rAF2X3vUsLJcBd8DC/SPA
	 bGXRwS+XwEuOdBFyvgLGZF9PQdqFeQ2f9ycWtc5MdfYBUhn4r8sbPUZaGSDsXftlMYvoI
	 +PlYMQGxXRlxIuCrpaAeDi5O9J81aigM5hnMthh+k96wo8hhctBb3fwlZwtXGnPo0+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hMkwn1Cn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sjyo6MDD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2F7606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 13:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD2F7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hMkwn1Cn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sjyo6MDD
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4BZs3Q2284172
	for <stable@vger.kernel.org>; Wed, 4 Nov 2026 13:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bdDbdezahsnwvvodBAeZroZh
	oHCyGDtmjwh7kWkAIGA=; b=hMkwn1CndJq7dLbOzHFcp/c7/7+LQmnU4IIeYXhl
	eD9flXMfO5OaxwvR6zf96TNocN2EPwyBHfrQvx5gGEzZmRspTRMI/3FRyLn5T0nO
	qO41sHImGEHld9GwuCDhB6F99fvCiDuFm1TlIQYNaaFdRjFO/x+usFvPgSkxXyA4
	ID2fD9HRzGcPw54pAVPqmi+DrqNoJ8e4HpPBIeci+lzWMD7y/2DAhp4K7eupSWlq
	EqE0hb/9UOAHrXtqnuGvWtK69xBgP1n+U+SX3wIbITKHiuTT3c5NfNUqCY1eXeGF
	eJuVaTRqZ+2CTMIVbZ0oA4nhv2JbtD0c0Fu/ehoTXiLj4A==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284ru09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Nov 2026 13:21:44 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-98a829c43f3so251391241.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 05:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793798504; x=1794403304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdDbdezahsnwvvodBAeZroZhoHCyGDtmjwh7kWkAIGA=;
        b=Sjyo6MDDWJLQeMVjSqSGKWmDG7H4krUMB6ZdNQ5m9dHjyBt99Q8CwA1wQmlVRMbUGH
         rqI24qbrTRoJYiBfJapCIziabzEdgSXvOo1qIr3Wzhc+dCZ2D/9ILiY7/WyKx+/Bh/hQ
         cC6ySuikCJVLMiVtU6wpQwTY9+blH9La1pQzJei/mFiaWyT49WTABmY+n/nZjX3QyYBz
         FIh8XQnMyHW6NhnIjVTUEJI+mcj/Q21U6nZf7RK0QfVvOqGGHGIVAhpwPJ4UdysQ30jF
         7sr8+/TUObuNDX2AIMW8KUcMqf56HmUxk5m8Y5ev1wWhdP4C2xYAxl1PsfFaEGO2pqhw
         KZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793798504; x=1794403304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdDbdezahsnwvvodBAeZroZhoHCyGDtmjwh7kWkAIGA=;
        b=BjxB8CiwnUWBxfoaz3D3v6hAqIxbTnCvCnQxGb2p0yRBZ+hhZIQf6oG/Q6+O8O1H2M
         mKv2H5pfRmtHiBuazOZnvNp7YRV1yvFWajyKEL+w9ssmwJ4y2tc+lcGoR2Uf4f+DYWXA
         yaIQuRumB9tSLovayWvgkh6rdtbPFKOnfaWiWy7nKBoX4uI4v0qeJaG81XRm2u6QTlkW
         hkyKUw3OVkTSU5d88PG1RlGyI/K5gpimcozLecMNAzBzsBfZczQTpt4s2ddbIxaeq7n+
         xrplY/nW5SS9OqERNGiZ1tsvHoscBZgGCqs1nu6jqYRM+yKE8m7b8FwDqomRIbQ12EYS
         Pijg==
X-Forwarded-Encrypted: i=1; AKwUvBySnmGThclU8PejzyHvu8gB1iYyxIJzoW0z2Mtub4D5j8+5zp1tSXoimiZ4zfy+hBZ2M0QiGP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gI/mQYfGBSs9r9Aohy8sR4QtbS6NGfj0Hn3kQPzEK9ugR6LlY
	pXEZVNc0TlmuDe/3yeHRYz1bC/Bo8BWy3MyDWg4TKqhDKOIFlIMasWlrch2U2rJsDUE+Dj8YzW/
	UPfLXCUsMK9ei8TkkvmY3IGMBUnYa3bYqXwES1c0MD7Vp9aqNbpTWxOV667E=
X-Gm-Gg: AYBFou2cGWg4fynQtNcrKlVJD0QfxIqHX/zlT7EPa3Kmo6l2FRt2+PZLqMdGUG/sdqJ
	Ldh+ea8VBC6+aMZ7hGp56Kf/7ek1ZzxkcvMAKmAMiR3RgA5t0xOejx3DEN3Y87P43aGtCcOLvvB
	XiogfyPNMKcjZn6Vy+6338o47ksUPAP4QPtLZ6G3jEn2U/1MyjmA2V8XUIDM38JY5nBR/XeOJuR
	ubLEQI4ZW/AH+IFUetdmK8I3lzhuzMop0PWWkDWlbrMOgODG3uhwLIOOrNymOFDq2r0SDTNIE+T
	uoxuOhZCdQS9fr1UOUTqkExvUOc8bVjEAdWjzvT/dnvnYlXohE8NnW+uBWmAGEAhvaY/jgkYSf1
	/o46AO1rQHD83Fav9dH5hakwFSTz37Gvxdt1r0otIardJ8zqWwqDEoQXu2uvhQBc=
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7d072c56c97mr5830337137.21.1793798503852;
        Wed, 04 Nov 2026 05:21:43 -0800 (PST)
X-Received: by 2002:a05:6102:5712:b0:7c3:881f:b620 with SMTP id ada2fe7eead31-7d072c56c97mr5830327137.21.1793798503118;
        Wed, 04 Nov 2026 05:21:43 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b412e48fd8sm51175065e9.1.2026.11.04.05.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:21:41 -0800 (PST)
Date: Wed, 4 Nov 2026 15:21:40 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] soc: qcom: apr: Fix theoretical use-after-free of
 GPR port on concurrent RX callback
Message-ID: <xqvbybeyrp5fgortzu7pkq2ge4hshhsma2nu4ag5isjsekmitr@66erhrmbpega>
References: <20261103145635.309032-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20261103145635.309032-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103145635.309032-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb3168 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fpy8J9LNTvDAPkKIS1gA:9
 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: pVXymomMjqGHCzEIufgJRpCbPYwAlnAo
X-Proofpoint-GUID: pVXymomMjqGHCzEIufgJRpCbPYwAlnAo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX12MiMp24KD1J
 sWGM06dnzdEYfz2aYKGUUuYa6CqC6wvAGURpvngIWJRNCNsXNYCc9QDjlENkFva3/QkDaDzFYhx
 yUTQhm/m0+tTgiF9xp95/kHuajA7iBCEbl0Y1iNm2jNt7AKbXEV8Hye2Gb5W6Gm3uU+91UHJZzv
 +Z5srXIWFDdFISxAKRdkQNlLfDu8khep5RFy4Pdnwi5Eo1aD1iAAHMqVQCy/SGsmgJ9FSWyj+/l
 Rlyym1kzysMMCUYbgIlwOpdyysjgu8CKRiuDQ9+HD70auRwBhugbDTdgmomd666Vqbe6l3MTN/r
 QMAoRpef6YcYrF5iVmhZDjW4qhhrebTGffd/fH/e5+ZkXSGCeMEzX5P2+tn/BBukmfvM8tGylmw
 x05L5QXFHcHmulRQdEHhA6yNC411hL037T+TFJ3FFdgiIzO8DrbIrS6JFzB7DOaZQmZ3HMPbze7
 FagKmtiHVbpVdZs0rvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX3rUS0weBLasJ
 5KpONw6P/ECj64ILLiBC+7ZgcqMzhQ7tKX5t3tqY9vKL46ILOuvH3dGzyebqL4c4zOG17cNth7e
 R+TG2Ix22ri2cdhM1DtRj4yYdg9nZb8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040053

On 26-11-03 15:56:37, Krzysztof Kozlowski wrote:
> gpr_do_rx_callback(), executed from the RX workqueue, looks up the
> destination port in the IDR under svcs_lock, but then drops the lock to
> call port's callback.
> 
> Concurrently closing a graph calls gpr_free_port(), which frees the port
> after removing it from IDR, thus a theoretical scenario (not reproduced)
> is possible:
> 
>   CPU0 (RX worker)                  CPU1 (teardown)
>   ----------------                  ---------------
>   gpr_do_rx_callback()
>     lock(svcs_lock)
>     svc = idr_find()
>     unlock(svcs_lock)
>                                     q6apm_graph_close()
>                                       gpr_free_port()
>                                         idr_remove()
>                                         kfree(port)
>                                       kfree(graph)
>     svc->callback(..., svc->priv)   <- use-after-free
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-1ebe255f-a874-46dc-b7cc-455e7bce402f
> Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
