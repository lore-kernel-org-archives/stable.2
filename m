Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C693A9611
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789083402; cv=none; b=mrfafnwI+DA7AYUEUTTwza0QOw9r2/8IgnAEctSrX8jFhHeCp1w2a+XTHp8SI6i5TEl5QfKvrS5McebkjLgMbkmRRQ1jLZEqWuVRs/N3ecF81uXKSvdX34mJGK6uQ36s/26IU5AUA2rdpcB2EoeqvCCv2gFUWWdMOYtLFECBZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789083402; c=relaxed/simple;
	bh=epgqlBySMN6w/cVjDW0RVEJKWkmkN3AgYj4lnrkHhCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dH9SeOt6G2dAllFvSDIjLUFPY0/0WvF26x3E6MEa18vmK95q7UGqW7hLAy6kVDC5/A3UijZ19sGgpSltWoEq7oxDvQpbTsBXt2FjmhUrGU0MG63eTn1T8GYBljobF/qvW6fpdX9VBmd9P9cbuwQmfB2QahKzpKLS5Ht6HZLOng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCwW5ekC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BGhZeYdt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCwW5ekC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BGhZeYdt"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALTepY3280012
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1+vvzCCj9uIOCMpmZMgB4cBfFQbtwALqKT3eGuMlqX0=; b=VCwW5ekCY6iefRfk
	3Iu3HlcrVCG3NeqQAqI5HYNLMG/AvMpzyzOQ9BSzngOEEMKO3qP41rCgJ3ZzW1QB
	6CVXG7veTJwWm+38u6NzMAVWeaqdoWN2b82jh9R0iaGKYs7YSDQHA0N1gCxK9+9D
	Kh0wdhhvh0zyhABDlEoK5l30FjfuQyyeemyobfnKX8pXZ2a6J8Sj7mYdhSnDQWtm
	+3xOrxbl8pjro79dvDCnx0kpCJnCxBqYf9UjfppjMs65x24ycWX3H6yD/3SoO9vK
	4poWOhJ50shWQ1mx2cf8YG03CaonSulaZJ+u6AvUChGzzvEJ/cVLbf7CCaX9Ss74
	XjlTog==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxnva354-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 23:36:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so352718a91.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789083390; x=1789688190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1+vvzCCj9uIOCMpmZMgB4cBfFQbtwALqKT3eGuMlqX0=;
        b=BGhZeYdtVFvG2Om9aqg9N6WSev/KVO+p1GK2JnJsGFYvYujTJ9D5nwGdgjMFxzC/S6
         rSIa3MmR1gCRn0uMolvZPO7gpf+UwP2/rRN5oCcF+jQ8jnedduzj1RjbiSmUn8UqweZH
         1XaYPuuEgy/oCmBplJvt8W4TFsK/Vc2Ondm6i8sFPxtC0tYgbSGv+peCxQRAg0EnEtO/
         HFiqHARyu5FqexdobOEEUO8Um9QB4nMW8nEMzgEHFVFbhbKcM3XJ/6LNjpUw3wFWv2aF
         n+BPq9TDJYMZ7tl4G+dw4N2CVVYYhy6YRLnEktzotoXZEsiYQUVracChOPAEPuApl9mE
         7YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789083390; x=1789688190;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1+vvzCCj9uIOCMpmZMgB4cBfFQbtwALqKT3eGuMlqX0=;
        b=KETfrZFX74V9V4hUTx4s8DgiG8d9COiH61ONIR1+DLLxyVRdJqBlXjVX33zMcrro6T
         vzCECjOs7Li3FUMhIHOzoX7BMbAYdTM3vtZ2rTQC5zv8GvEFVFZov3HlOuYYpt/xlZvY
         k4R9ZipeTEFr4B0ZeciWGdM2hQ8SLIR+asqyWGzqf89r0Bf//pvSMDPe2s0QConnvY1s
         PF1FrAy65xL4t4/fyXtKQkpt9PeTtsS0KLtUoEicOY+ZQbJ3Z3C/osWjEfBHZh/xhBoW
         0wb3g8pQUiloolbErQRlBw7xWtaii69LKAitGi10RqiBVdoJwbjGnkpEMzU7XJJ4YuIq
         lg2Q==
X-Forwarded-Encrypted: i=1; AKwUvBz44WHOI45zZQizwz4VWm/T2mdjpmlCSLvFoiCn8rdalPPlSAXFz/JHonU9FfKiJ+tj0fBgIes=@vger.kernel.org
X-Gm-Message-State: AFuF++nXcCofVf0py9tLYy/k+WPsQvvo8O/kB4R5fX4OJfAZHqG+Fkgo
	EibXDXGaWB2oykVHnet1hPqTckQqSNu7rDFI8+H2RqsUZqqEBIJ1KlKOOOFcho8jgbjKf7KZqPV
	yV2czJKegGQkDbFwDdEtXKUtcYULwa1K/S/sp/9T/YWSEBYLZ26Kd4aVo7WU=
X-Gm-Gg: AYBFou0dttaeG5BJs0oZfewgQUJkVAnQiFbGGm4R3vWFXnoqBpR6NcPTWj5lQUF1inM
	SwGhJoVuiNE1p22UmcMQ23DyHU2SdJa/I74KXcjwPvV32VtEW3HkBTZjkxhUlTucL4EfdlXU7lo
	hvnu0Qz8z8JTyG3rEoulwU13G5BMBTUN1ldih4B20dFdNw0m80YpPlqCDvXGgVgzQapnSojvJxz
	CoN0mqLQWA+HcBWPGIl9YTHifjjOU7/NnRhSyOW1mRQb8v7+D1AyWwGNrbDIryj99/0BWY5IEas
	L3+1G6WL8OK/01Rx2ymOEIZIAXp14oRyKA/C0/arlwGfG7rQJhGEUQjnFiJFcfHJdJPiIKXpbb+
	jIEhU7vaa+mIp289It+NKtq8lKmG4qN80cSJ2IuH3fRipaQbqaRja53U=
X-Received: by 2002:a17:90b:2f44:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-39d9c21f686mr1988980a91.20.1789083389991;
        Thu, 10 Sep 2026 16:36:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2f44:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-39d9c21f686mr1988929a91.20.1789083389498;
        Thu, 10 Sep 2026 16:36:29 -0700 (PDT)
Received: from [192.168.1.20] (163.sub-97-215-3.myvzw.com. [97.215.3.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143659a9a06sm1895630c88.0.2026.09.10.16.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 16:36:29 -0700 (PDT)
Message-ID: <f8563571-3ede-4f5d-9744-3d72b441a4b5@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 16:36:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wcn36xx: Fix potential use-after-free in TX ack
 timer teardown
To: Fan Wu <fanwu01@zju.edu.cn>, Loic Poulain
 <loic.poulain@oss.qualcomm.com>,
        wcn36xx@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
References: <20260910020907.3353-1-fanwu01@zju.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910020907.3353-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI5OCBTYWx0ZWRfX1WknAVpe1mDG
 eilE55TRtXwo3V/SivfWtwyngw2mZa/RLfdEN0mks4kQqD9FkoC8sBW8TaTgv6QL84d3vjNPtyI
 PC7xDNgb6p0/bYDUJ9KghM6cMSLmMmkL8z6WuYhc45mOlEAgPQuOdEVtwL3Bo27DHVMASKwrIcr
 9r1HhjYJb60QyxJ8wZVxOfxzMkADaDf024jou+TL4EgmQE7pPg3jyDBpcx7xZqUl6gyAdnWxmnR
 H/zDw00A6nAsg2yUEm8SSqsz2URnMaujyrHLGkdu5HzkfBsbwWmjK8O0TKCBjbCxT2nJCYWnwTn
 bg5mmaUnqWM6YYMcUhQyDcoop6PdJ1Uim8mYhcC844TypSpEHUejbSgGkcaU2hdkQQJxYsATP8u
 wrTPkDYSUGSFGoqlODGdBkl1Wjy6eAOlq/ol1G5xIKVQNSZ4vOXkTcTYQ2zL4gHp0w8jXu4W+ih
 BNmBnTWV3AeaHJ9IHzQ==
X-Authority-Analysis: v=2.4 cv=RsxQvymK c=1 sm=1 tr=0 ts=6aa33efe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=7QqFuFOOHQR3GLhHC5mhXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=OIB5ShivEfEboS5j5kIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: nssv7Ik714sN_SmS5QdQaQcis6OlGoIS
X-Proofpoint-ORIG-GUID: nssv7Ik714sN_SmS5QdQaQcis6OlGoIS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI5OCBTYWx0ZWRfXxf/x1e6HA0Qn
 H2keBVaX2VPGnDKvcP8Sh7D+uaEXofxyw7ltH7lOX7UcIfv6TkXBdk/HR8qC7dPbIDaueysVHdL
 tP7VRPCBNpTF3EbVAnKbE+30/D+6S9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100298

On 9/9/2026 7:09 PM, Fan Wu wrote:
> wcn36xx_dxe_deinit() tears down the TX ack timer with timer_delete(),
> which only dequeues the timer and does not wait for a callback that is
> already executing; the preceding free_irq() calls synchronize the
> interrupt handlers only. The callback, wcn36xx_dxe_tx_timer(), can
> therefore be running past the teardown and use the wcn freed along
> with the ieee80211_hw in wcn36xx_remove(): it takes wcn->dxe_lock,
> reads wcn->tx_ack_skb and passes wcn->hw to
> ieee80211_tx_status_irqsafe().
> 
> Fix this by using timer_shutdown_sync(), which waits for a running
> callback and also prevents the timer from being rearmed again. The
> timer is set up again by wcn36xx_dxe_init() on the next start, so the
> start/stop cycle is unaffected.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: fdf21cc37149 ("wcn36xx: Add TX ack support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6

Current guidance is to just have Assisted-by: LLM
https://docs.kernel.org/process/coding-assistants.html#attribution

No need to resend, I'll make that change when I process the patch.

/jeff
