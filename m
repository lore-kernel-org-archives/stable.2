Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA345322749
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983939; cv=none; b=dJ9TGCK2meJ0j/Nj4Tb1HlXt39nhtqPsSDrUXELhNk/xRa7bOyP5WVE89HmIqn/2KuQ/1USdIxUb7tbwUkOon5RfI6MvkhSGeYGr94hlQgrCSvQvek3i6RF77UfGCXiqTamBqkEwLuQrOV0uad4niKH2In5N0L+98UR/124OgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983939; c=relaxed/simple;
	bh=NAhNj+xAYKXjwTf4Bu4MG+U94N39qFYkCb06SSvAYiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgkqDKhWJ2Ne5sQUw0Sua4PrYEQ8NbnmPCScg0AtHlG39ScjfbtfHIHG77lvyleYnY42p7hQ/YUclaLj6kmwn0CL/8FRIKR8dYQa/2WJDJNGdwhSRNiR1H6WLebq/PPGF4aPeSkvhdY1x/+rGLgK1DPsuHVk56rTykvwJpR+10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCdxPO/6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E9MCNMKZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCdxPO/6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9MCNMKZ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E9xsm4806654
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vmr9fYYhrMz/+NTty6Yb5DMS3qhB8lLFFLzfZXJtLww=; b=KCdxPO/6K+SOR16t
	VvioE/s5u7GQ6HhRNcXzGbSjQ1HPMDslfihNbr9hqD/v7z0JZnHmE2OvtGZISgQ+
	yc0/m7lwjVj3DbV1vgPc1UYX2hTVti7/VyimwojtDshyUZfZ2G8ObqVCT5G5jrBd
	kPuz9LuiG3JE5DCGBvE3VZZqb+QCs/qp9rtio+6r2lOl/NVob94g5Icfq3mpznfD
	3AAshC4ZLiiaom1h1nXlTxI54zlizxOTFret/w1XA0dDbV95RRs9BdCHNf7T7MTC
	c36nVMqWP9f8kK41Nee0oCN6c2KbSny0EH6QIC3Uu/kquJWu4Gr32yngJDjjFmzD
	AHLu0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud6bmmg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:18:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93edac5877bso37786185a.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983855; x=1792588655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vmr9fYYhrMz/+NTty6Yb5DMS3qhB8lLFFLzfZXJtLww=;
        b=E9MCNMKZtih9Rdj4nmZNXOxYgqH0I4ytmcG5J40MLCOr7lbXGR2ycwS/brxI2UeszP
         9tOigd+bzfvFGFuVxxgWuGFrt5MbOL87eTRevAo/vuZVvkb3yY/rfaG2yPuCkwikfPso
         NGoshtnDodS8vQgmE6aikkjwyMrfFURnx/NVowgqkJbvCJt8mCmChSQFTm5zhj2iXyeH
         q+4zz3uZPOpi5wl4F2eyHTxl2fN0XEaDOyvC3Duz/L7+nUo7sizkFmplY7iyDRKq3uDJ
         OwYsEu1SRswBSBUKpWi39RQxwxBPWEvw/Sd5spK88YJCixIvi2UVukbavhA4YWjZ7AzX
         5Idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983855; x=1792588655;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vmr9fYYhrMz/+NTty6Yb5DMS3qhB8lLFFLzfZXJtLww=;
        b=0meQ86FYRsIl4RlNVJwTqx7YmUp+8dcrdFcht0qwyZJcJLEezwAAdiQzS4CNiF+llS
         jK+C25Hdy1DlVScdqZWmxSMPEMo4BRMZCZTJ3gGVPKt/xYWX+N6Y2OrpRTtQ6puy4tK1
         wv83Np9+xQn1Ts2BbheLV6MQ1TjYJUhKxMaCM58qd3DeOBaM3acvbdd2PCgfDdGyvXy2
         Au7M38EJLXYI/oZKpx1oRnxlqc5gZX1bZBxIfnJth2xkX58ph5G9+HyMaU90Cdt3gsM2
         inam054XNJKEWjJ8epe++OwYVxrr8Hnfb5dLKyM2QcVnorvWVv7ODixftTBfcYFXGvsy
         0aoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBAlxu/jsIp873XQ9O1V5FnKGMnMT3xysTNc/jhfTRNDwWpEZx3VdIQk546LfEgg8LVMfuMu4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpW2XRWT5ciTUAiCtf8udw5o7tSIT4nAVpvdeaoPE0yfnjFbWQ
	YEe+eUQCKeQ5Fh59TygURf8Jiodk43dyywKGeuCjebHbMlFU59IWoRE/WHpb03lFbIJ2HuwUJYv
	g6N9LFF5cpMhW6AvHHmb0rKvIVauwgf0BDVUDqhEUSpg/zRpQqthkqger9wo=
X-Gm-Gg: AYBFou3PwcEUBSNXqvI/peJnFyAu4RpYZFwtQmM/qAIxU/OnqiZPlWMr1QPAhe0oKaS
	6MljTO/MghU2FNyw0KZ95VoqKcZHjr7l8lc54FLR365j0hPOJOdE7yjZ8y5+WkLHxkpw5mwF5zV
	nJWy3huuremnXiW2dIYUEbrqQOpw6CI9be2WuXpRup+0IKiOsJ5ybqWbl/zPesMNHKMPpeUsv7g
	B1d8BCOBzmJUkKgXWZcQKa9p4v+pXnnpcBcaLXUHKE7EmtI9twQzNGmF/znAoG49J73QxE7i7KQ
	w0ISJ71ei2BZIM1VgjvC8pEC8wP/GF2byeTNKTQd8k08eywR4bedoHfhksX8QKGu4UiLUMk4yi1
	Y8pDRc86ht8cPkBHdNrlPyw==
X-Received: by 2002:a05:620a:1a10:b0:93c:c96c:a5b4 with SMTP id af79cd13be357-93ebd23a4f6mr2938896085a.4.1791983855459;
        Wed, 14 Oct 2026 06:17:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:93c:c96c:a5b4 with SMTP id af79cd13be357-93ebd23a4f6mr2938889785a.4.1791983854924;
        Wed, 14 Oct 2026 06:17:34 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be33d704c1sm632732e87.25.2026.10.14.06.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 06:17:34 -0700 (PDT)
Message-ID: <230a39d3-6957-4203-a54b-88c871092e08@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:17:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL"
To: Birk Skyum <birk.skyum@pm.me>, Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        Daniel J Blueman <daniel@quora.org>, Sasha Levin <sashal@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev
References: <20261014130805.48840-1-birk.skyum@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261014130805.48840-1-birk.skyum@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sBCQjX1jaQjekEsLtvMdjRzRvZlQdcFU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX9m1/1dELtUT+
 WzDdBG/HAUsdJBvCvajdi17WTdwcu5cBakceZ2AFXROjjF10eTR2MBkIzH2FP+VC9jWeufyGgZk
 3z3KhlO5Q1kc7EStPHuyr2fvdIdkdRI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfXwJ0WkabdgsHY
 4Pl1V1iImnrIDCHmbxQSk9qFpIu41khI2wFsaRrayZopV53aOvAuEaNPdnpTutnbuQNiGUcSSgT
 W6Abf4KJlLFTOD4jkvtTAIVJvOnr8ooWOEbm4pdru6Xr8AwMuKYaRzzqdx2Y3+LsBeOpkb+f+WX
 pFlfCT9MXyujemzHpsCkz6qFWRbL+Rw9XXAWmk+YlaygiCEEwhUwZ1QhFy0hFgaRj0WYhcXW7Ck
 qJ725XW5UeUtt4tTjHK5ATUyNek27yORbEIQn5w9+rY85SJ4l+wAnlo8qDIezHxF6NImGr3uDVx
 b41SJuxfLPoqfBs0XauIYqyDx4uwoNjfqkFrIsFHV0zMbGSiVQgQWV33li+SO54MvwURAgwRRzd
 pYtlcM+Pt21Gzwb7Gwf4LuOQQnGDPFoSi2m6jVDO82tfidMS3Tp+/+xg9Fd2tTRkvNDGm6EZHc2
 0+NJTsvdxAgC3r64dQg==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6acf8141 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zjrlJ_9gmUhWjCpjid0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: sBCQjX1jaQjekEsLtvMdjRzRvZlQdcFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140052

On 10/14/26 3:08 PM, Birk Skyum wrote:
> This reverts commit cb97bf3d4f91453b881acaf8e9f0cc47bb40b604.
> 
> With that commit the keyboard and touchpad of the Lenovo Yoga Slim 7x
> (x1e80100) are dead, also at the disk passphrase prompt, on 7.2.9 and on
> v7.3-rc7. The first transfer on their bus fails.
> 
>   geni_i2c b80000.i2c: Bus proto err, noisy/unexpected start/stop
>   i2c_hid_of 1-003a: failed to fetch HID descriptor: -5
> 
> With the commit the I2C serial engine clocks read 32 MHz, without it
> 19.2 MHz. A fix for the 32 MHz fast-mode timing is still being
> discussed, so go back to the previous behaviour for 7.3. This brings
> back the hardcoded index 0 in SE_GENI_CLK_SEL.
> 
> On v7.3-rc7 with only i2c-qcom-geni.ko swapped, the keyboard is dead
> without this revert and works with it.
> 
> Fixes: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL")
> Reported-by: Birk Skyum <birk.skyum@pm.me>

(this looks funny because you're the author of the revert but
it's fine I suppose)

> Closes: https://lore.kernel.org/r/179173732257.29426.7905170638383807320@pm.me
> Link: https://lore.kernel.org/r/ae03e7a3-75f1-42df-b0e6-0e64358be647@oss.qualcomm.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
