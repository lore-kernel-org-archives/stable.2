Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C5648A2CC
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988801; cv=none; b=k7AR2UGlnSzdbvEHCE+uVvWvW3nvwi3CGHaH1cQLo+ONQzBEfCHizRGzUFand+ksCMedWzZ/aNdGOX6rC+pnQuxM5g4MDVxqJ95vkmoXw0mZopHfY0N/+c+lk3O4MaRerzC3nICSkhFTy5Dj57xZz6eA1GtzlMbakY/nu7RpgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988801; c=relaxed/simple;
	bh=APDQF13y/S2iTJC8bsCnwlXoIXm7Osc7h1xGKtGf/V8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNf+PhdIfxOsRawSwMUgnNkriPOQXbsKKHd0tUdH41YJ/8+miey89ougpfj4xYO2exy8Vj/4Wa5dseq51SmF8JNgx+UiRKHwl3FqjOtym1lGsuVd9xaE86lUBGGTGz8MFexnAfsorhKsGV8icucRsnnjOo9FRb/X+3hswgbvL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8W0TYh/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=alIogjgH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8W0TYh/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="alIogjgH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdsF2287263
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fVGPjxP3QgcDv0E9g1JTcpUHcMxO88kzyAGTghYjz1g=; b=m8W0TYh/d0uyebaF
	/H4rugJm9UHLtaks3QckssiAtyDNBN4VuiPevXR9Djr6KzlTqNqN94dM756RqGU2
	NScRNU1R8rw6V6EHlfnol+na3tTdTl+izaV+EApchomVaHSztCRB2Gr/yfhGRdnX
	Iz1Bxp3qr3rMUteI4SEwqtGKT37Qq1B4D4Fs+UTQiElzZQ3vjCBQAZXj5XYxb/3G
	bkbPenBi2YQVunoAyv1n8iI4d+obL17oNt7c5GmCUW68PrvRGh0SxpJtsQVzKsjI
	Qa7UIn7jbSnyIy5kiKVrb9zhBs1CubhRxIdm9WvcSkTT/EP958vHElgSm5C8lIy5
	1aH33A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0rj0qwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:06:33 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c665139c92so102293e0c.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789988792; x=1790593592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fVGPjxP3QgcDv0E9g1JTcpUHcMxO88kzyAGTghYjz1g=;
        b=alIogjgHTnDYsZU3X4O9nwBJ/dcD/mfTtZsWrYULgjIsTsd6y2XdOAywFhYu1Q43rH
         Ut4D/Xf2Uz7JJPv47oribEwHjtxtSOpi61ulaPFU8S/rWZLIUUWzMnRnCxy+2UlTu9tx
         5Dnx3xEgcoxysDuQL4ewOQrY+I8aXbx3yhbZRe5IeyRX6M7fbaDjcpmT5WnZmuvNZWce
         B2rMPo5AI7szT2fiB3/62MCQftpEjMdBedvjt+epF4IEwmVhy48mI0jFIiJ+B/dellcN
         030Uj6eSPwlnzM3rg50KwlronZggMmFNus1K6OyrQoZJ7PoE0VjPRErcmMK3L/Y2uG6E
         NgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988792; x=1790593592;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fVGPjxP3QgcDv0E9g1JTcpUHcMxO88kzyAGTghYjz1g=;
        b=cVKKrjc3fhj99JvHKd2Qpy1GbfH+nK3sXephLT/7A85fvup6oX5LhWnYNQEfPQ7qp/
         ifJF3ykb+CqJ/dvwRwYVmlp0UewjOzOoRxQImpNSd9L0eQR7RHYzvEjwpciv7s0XChaB
         dEu9++xUqliz/DVHLQeRXyYV+Rko8gIG7w2igWoHimz/0pPji+h5LiqorwdXF/Lk4pcS
         +7HTeNU4/bFhe4hfpD+znfuyxptknqGg44K57pNlGm2afMKRyXSs2S24xsTsYDm7V7DB
         3ZkjBnvx9iDgq5GpHPx9DRLmRrjaErcPvKDCKUGrj5juRe8c3jimu0FOaL/8HN+h0jQY
         rU8Q==
X-Forwarded-Encrypted: i=1; AKwUvBy/ilNNQIo8RwXRIFYXsJNQlVTmjJAMS495nDI8eoB0OWNQQi/oOgnzlwMVfkM5BYqUGIta/wQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n2ZW+edQYs94AwSO/R7QLLAPemrkxaaIPAM1a9v4q2420PW53m
	9LNskAx7wJaNQRjGh124P3kT+o3Gl84Y3Lv3gaio46GYJwEERmFuSyaAjxRNQtoUmQeIDEsBukO
	Ux+OIU74kw3GjzgOuPJoHKjkupPK6HAShSTqC/TUtRRiFQcNMW15Z8Vhw3YQ=
X-Gm-Gg: AYBFou2Ce6Pk839fkAHSr7gsWdR0oRPdlIfwU36tqI7/DuwERa/Ji515Vl10fjTM2Rh
	gK1mj08YwLQIZ7wtH9RhZW0SpIDECQN8yDwlCFi1/4wKV3vkOD0jC8mnkr6J9YWvIjAPHn55Dbx
	XlEzadAxfvM34/DD77pRC7nSKtPPPKXb9pEQjfcVF0ZQadR3wG32TbvonmUpKn9S8r5Jr4e3nvN
	uzWMD9SZ+RSJSTmNHwUxedZe3kwJhs6r4HZ6Cu/9iCi/X/Cc6VyGxOkqTsQXcVnXfz0kPbVh890
	ETV4nuckmMh7PDgYJh1HcuKFjNlWE+HMaIAWJ7wJl7q83Q5x1guKEq5dDIidbkohFA9agh9doNH
	PxiNO/3APhrxbKmQFuq1cEQ==
X-Received: by 2002:a05:6122:35c1:b0:5bf:b91f:3bb5 with SMTP id 71dfb90a1353d-5c9bc3b53e6mr3524538e0c.2.1789988792532;
        Mon, 21 Sep 2026 04:06:32 -0700 (PDT)
X-Received: by 2002:a05:6122:35c1:b0:5bf:b91f:3bb5 with SMTP id 71dfb90a1353d-5c9bc3b53e6mr3524484e0c.2.1789988792144;
        Mon, 21 Sep 2026 04:06:32 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e1b7e1sm3810951a12.26.2026.09.21.04.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:06:31 -0700 (PDT)
Message-ID: <8204dd54-d282-4303-85fb-d5408cc0b4b2@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:06:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] backlight: qcom-wled: Fix NULL pointer dereference
 in wled_remove()
To: david@ixit.cz, Lee Jones <lee@kernel.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
        Kiran Gunda <quic_kgunda@quicinc.com>,
        Marco Mattiolo <marco.mattiolo@hotmail.it>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Joel Selvaraj <foss@joelselvaraj.com>,
        stable@vger.kernel.org
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
 <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260921-qcom-wled-backlight-v4-1-bab8c7ef73cb@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX/0gZcrFxoi5j
 gheURbcoeLoXJ3XEedobR0aa/pFCnCRn29TnmgEhG1N9rkQxEIuktrWLv4j9MFIyh0+voLRTcc1
 91I6SCvQMpGWFHP6hjsdb7VGAOovrpM=
X-Authority-Analysis: v=2.4 cv=AsR7T+9P c=1 sm=1 tr=0 ts=6ab10fb9 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z8QxmeLbveigHahU524A:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: kSAQgwAKQftRU9tWqBr63q0kAi0klAMo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2MCBTYWx0ZWRfX8apzzZ6+tmsm
 iul8Qmqf8OtWubnzEZK2Fi+KP/fmeQA2aKl1m/pFL7AkBAGn0KFEEHmQZ5i8E5zjwjziP/yZ2UU
 pYk/s8DX6tUCflQY34u2CA7r4wYNOhPKZ4NXYsZQ3p0SMNJAmPzKS/LQMot17XAMBsCyiN6uRhT
 vlsO9ADBWfKaFJBk4MuNehfnVxG+M9VM+5XeC+6D87MgPJwTCsFFRdmTFKdxYB6x0TPJMmDJqRV
 YJUWxZBYGbaoNlJRNVzsYsimhz1Jweo7TAD9Cm1smvAxz+7V7rEgJ8hY2/jsyvuleFmVDbgTN5c
 Ns5RwbtyfCglWYCz0GkNFMT8GUzE8GjmSgQgaIddzRIL5fJcU7JbENMeIPbXo7XB2ULZ5BDJzp4
 +QP6raiU0WhP5tnGBY1O8pAocPuhlGX6Z5tL+qIU6ZDPW35quDwjSMKC7rtdTqk65bX2a02fw1t
 ij3c838gj7J9/0oWQcQ==
X-Proofpoint-ORIG-GUID: kSAQgwAKQftRU9tWqBr63q0kAi0klAMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210160

On 9/21/26 12:46 PM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> wled_probe() doesn't set the driver data for the platform device.
> As a result, platform_get_drvdata() in wled_remove() will return NULL,
> and the first dereference of it crashes on unbind.
> 
> Set the platform device driver data in wled_probe().
> 
> Cc: stable@vger.kernel.org
> Fixes: feeab87b3072 ("backlight: qcom-wled: Add support for short circuit handling")
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
