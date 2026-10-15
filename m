Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014748165B
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049922; cv=none; b=FeJB1vPM2dl/FagKrldTJFT3K5TFT0IbqRE7QAvS0lfcr/8C25cALgWVax/AxX3OCZJIo8vX5Bb/CnL5crulKM03p10ib+RZ++dJIUw8oHIOR4hkbLRE9xbLcJekulVmPoOiO057otJn3YTwXJ8i8Kd7g2fMc8qsDPUuM5xCqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049922; c=relaxed/simple;
	bh=ApZFJkjaNlT/TsCEe2d8dQaEOVgyQLshFJC22PAsFRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYdhcNo6TTX5F1LDPSNHjEaqlJ5bCNefUw6uCdhrrpCDXrvJtNXKOwTmEtgidRTP0QHYE/V18QlllUWDF2aKz+Lvg9mtCiBJOCJz7wn34Q8nFl89XqO2nQLxTTgcDsd1zxIAnNX7lEWcwsvMPL22NNg8v5B7+cBfdvgZblfR9ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nn3iLmtP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdGEPp2F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nn3iLmtP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdGEPp2F"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3xexr2738878
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Csz5ueyJ+/67ymuGuUM7rGGJRT/TQU1rQbsBSidkGiM=; b=nn3iLmtPP36d1A/G
	GkhCDVglIPixP5GPIwE3+2EbJI6nx0mtFoPY2/YeudLGulEmVXa83PvTUTjh3KQ8
	VcOmIl+YVKQPx7vEQYQqW6KgEBBBEyIkGlcssyuQSNTBOum4eN42Lw0cdS8W6on0
	shue6VMgrY9ybywlggKqxHbIM2eUi/UFU0CZLIQ0xGzwoFjmpiFrx0Az9nDQ3yU9
	XQI+GtrvLeqAFN+DyuMvzD1VvURy7N17VaAuR2B5GB5tQlmKZmebgTQMBhxOVmWT
	wmUEHMMuDn07Di2Qo0o7rFTHdiU9pEaw3lpws/PsgpwCNbqGxAiqGrR+mygrbdDR
	caKRhg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqds8rvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 07:38:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e85f74c21aso38463175ad.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792049916; x=1792654716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Csz5ueyJ+/67ymuGuUM7rGGJRT/TQU1rQbsBSidkGiM=;
        b=AdGEPp2FzhXS1afd1L1+fTtCAKWKkO8bqLfqg8+b86Vwx31SnYqlJEEL7N4UDzgjog
         9V7QCkAxd1YbPpfcA0Ul7s42L7RlB6Y8Sh8Xg2diMzAS7VECVdWp4mHJA+406sxUn+8+
         1NidrBoyuBr0fylNmb/fX/AD9qPVaiHcbEEQgN4ICdmREBnfMpDbEduOWrzgpV6aza6/
         Z8SbeGgUBq2uv7uswqiBh14BMHj95AzSRWR7ey+DPaJJpqHlYcGbhSCWcH4afNOYcW9O
         ilC1auKL9/BpotMaVTYH4rovpLp+h/CbwK9ujk7+35LbqJ4+4Q86h2CQaTK2JAd2ike2
         on2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792049916; x=1792654716;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Csz5ueyJ+/67ymuGuUM7rGGJRT/TQU1rQbsBSidkGiM=;
        b=MFx/SqA/5nhEqzceEh7dayEy89fxFm9J8ZFMF0otjcTNjPtcCAEZ9y4Iv3kTQlOGDW
         r+MAHGsZZ7v+BG2GVPLfKyh2LnRhHUEG2rhC0NUM2XFv36MRMOtpp4lz62HL6CJkJ5u9
         bn01/D0HVA+/sUo2TroOmXlBZJqMNBaTihbdQgNpc8ILIukvUr9I+rvgSymprtQ+R8bg
         e7yqdzh+zndoYVpIEw2MrsFD7S58HX9cvpOFdmSGC3rr1k+9oeEW3SnPziT+7GqN6QLf
         HGs4cyooyWe9ujmW3sfkozjXEi+8zdR2pTunJ1U7jJMKLCu4jwLka7JgTQZypwFscwLE
         t5kA==
X-Forwarded-Encrypted: i=1; AKwUvBw753ffV565zJHSLxI3/sLNjZf1xFpAzDoUj84I5KtP3pUhAHS4Xb7v0fKF8gmXG4RU29ytTAg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK78kQTRjjQXvqX2dzOUTXkgfBfsJlUHUaGPMygpdS2sVS+WPzV
	pxev1ENXqD8TxJwHeTAFz4Ed/YgRg3ugR8iOjEn2hNz/AZRpcBW+AHXYdL59tSCgRN1rikRO9Bf
	1NTabmvt3Zmkab8vr1lYMvjKv/g0R8AMJDj9HOvU06JKIE2Uy0VhwGp+h1v0=
X-Gm-Gg: AYBFou0AXvIZOUSklUq8qAhnnPWmJBMuRg8UieDxH5Yn2BUPosCnOBu69iPIy4PijMf
	9NkWtnLtrY8dIYHfLBGa78hGIYBpZOeY9b9V7gKcU6PD5x5q73gH6oxZNIgkEczecLfJJW8Z0x7
	R67INTefCraZzVN85wD7Y45+4OjViacAEe7CIvTuQqh9nY0i6CkRRH/nx6v1etOR7A2NUqVjxzb
	FbMl8w2xBLrb7//J9FR28/An93u7pRil9BD7o0C8tRq9tLnHpwqtleRnW3uDb5UU1MDEUQp58UF
	DQop/dU5Z28dowH0UHiwNQSMZzvbcPEn6RVPh6L9r3cvSJsaTz+DT6S49XjZ2h5FCkd7tZY8Ej/
	5o2OHNsxKqg5x6e0gbOXaRgQ/a1JMlLelit7dyOMDyhhsmPQKBtOS6dOKRvi4OuJhQqTWOpc=
X-Received: by 2002:a17:903:2c08:b0:2e3:1e9e:fd80 with SMTP id d9443c01a7336-2e8404bbec7mr113398905ad.7.1792049915642;
        Thu, 15 Oct 2026 00:38:35 -0700 (PDT)
X-Received: by 2002:a17:903:2c08:b0:2e3:1e9e:fd80 with SMTP id d9443c01a7336-2e8404bbec7mr113398745ad.7.1792049915162;
        Thu, 15 Oct 2026 00:38:35 -0700 (PDT)
Received: from [10.133.33.32] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421a1de9sm79321965ad.26.2026.10.15.00.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 00:38:34 -0700 (PDT)
Message-ID: <bc760367-4896-4626-8f5b-1bc3ef6cba22@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:38:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 2/2] wifi: ath12k: copy M3 firmware when reusing the
 buffer
To: Artem Dinaburg <artem@trailofbits.com>, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261012165925.32575-1-artem@trailofbits.com>
 <20261012165925.32575-3-artem@trailofbits.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261012165925.32575-3-artem@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VHpF_ZckBD1tTeSYODEk271-oy0_piPB
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad082fc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=rP-kOlJ0AAAA:8 a=EUspDBNiAAAA:8 a=cZfKjUfnoN_5-lsrkKoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=A60uPr_FG5abr3nATN9e:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfXw7TxdwfLa8Ib
 QSqwA2uMmGr6xldb8QrbzVTlotRWEJ+AhAw/rODHkdradEVe+avVEhebXpnIXiJnf96NeOrYuHI
 mektUyuNsiG5dZ6kCmkocpHFZBWVsxWU4JYpdXDT6DFq7PcwKSKeXAw47fITD5Lyr/SeLnPTkEX
 SIRkLJqMW7e0q+FkLALCG3+PTSyg6CnT7kuOokeSIPrc21x6lQsL6yJuQaDPB12Rz6Pg81/Oi+d
 lXDSMk6kchtNMk+Q7Nt6rMCKZjaTB1CYkhbIbz5b5a/C3UwCVEq4GMTziYj6YDuwV6pXfa9H+rr
 Si3CPye4+uttwWXz74jW5H4P6DRxOQF0F0xL8P5oZD0t4uUAylUhzwhiJ+0ilVfzJavbIzSuHeY
 2qXJRb+feI+yvryTRe8ikLtWt/2BFlI2vrCIJOgxNc87Bc/FuSOGW7n5PghASo7KcHSW2OuppyF
 Gwegq55B1k3wJijoWdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfXzAIVmPI9HfuK
 qk4VTb1DEfudjsMr3eW+n1RaTsMz031jMCAmF6kWUZsLS6Yy4fC8hWzXXj50BSWLVABcbWT21vW
 VupWO5Feli03aDd0IXt78Y3Xn8AEsQo=
X-Proofpoint-GUID: VHpF_ZckBD1tTeSYODEk271-oy0_piPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030



On 10/13/2026 12:59 AM, Artem Dinaburg wrote:
> This fixes my 6.6.y backport of upstream commit 05090ae82f44 ("wifi:
> ath12k: check M3 buffer size as well whey trying to reuse it"). There is
> no corresponding upstream commit, because upstream never had this bug.
> 
> When the existing M3 buffer is large enough for the new m3.bin, my
> backport releases the firmware and returns early. The new image is never
> copied, and m3_mem->size keeps the old length. Upstream instead jumps to
> skip_m3_alloc, which copies the current image into the existing buffer
> and records its length. As a result, after recovery or resume, 6.6.y
> gives the firmware the previous M3 image whenever the new one is the
> same size or smaller. A larger image is reallocated and loaded.
> 
> Replace the early return with the upstream goto skip_m3_alloc. The
> previous patch, a backport of upstream commit 00575bb44b2c ("wifi:
> ath12k: fix reusing m3 memory"), keeps the allocation size in
> total_size. So copying a smaller image no longer changes the size passed
> to dma_free_coherent().
> 
> Fixes: 9a38ba5561d9 ("wifi: ath12k: check M3 buffer size as well whey trying to reuse it")
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
