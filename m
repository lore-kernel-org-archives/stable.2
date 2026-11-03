Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698109;
	b=Sl704ZVDXpMd20UWxgL1XA0CnI1OAGzGrySJ4sdvHNy6SmtWBeog7AUNy06yiEbgTmQe
	 Mo2Pd2u8bBOlkJdzd2O+6RaLgV+jl44DQTWHtb4X7GonHNEnYFFlsx4for718GIbcjfvB
	 CzzHgrro4U6TrHc44O97wAKnTLMs6mC2Lflx/koB9XXdP0nwfa6TVL/7ZqhnBJnLaRWT4
	 VMvT/E5WEUDnglNK2GhiZLC3S3m1RGfR3H359NP32ymTGV8jgoZO67lZd5PBIvrzh1t3A
	 1tKz+UqiEqvMXX9JGZTHC7OtpQggAGkWSH1J4nHzavl9pW7W2kmFS6A5EAiLk0UXK4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698109;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CnLwxnc87zGnVss348UPyqqWPDveLZQZgSaACTND7ko=;
	b=Vx2dlMMBdCQiokKiLwh1LA8OHVz6QC3t7EwxIcuKBNAuAC2CnFdZFyRsS8px2BSWe/e9
	 np93+19MUOHBLxLQsZR7UevCzLUE7zu6CRaQCUaMPfpNL8jRF1knlbUe9HJk+eqnpHWdY
	 Vwkrtwo0AKHTTsp+XNvn5eH/0bvC7ngWiMJYc0+k64rQDGWN5nNFAoKtL5Gk/GHKYxvNG
	 1rzICtIdt1YMIvT5IvqokxnA4dNqdU8x456e2bpL7dCLkSKlh8SAxXa2OBN0quP1/Wh1q
	 W+/ZZNDZEYEidh548AMcTj4WzkwHEewXfDiFWs+FEUchKmHewt01MP4f8cegAbVbW4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Paa42qr0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjrNM+fC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C43606D839
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54C43606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Paa42qr0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XjrNM+fC
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37nnaM470787
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 09:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CnLwxnc87zGnVss348UPyqqWPDveLZQZgSaACTND7ko=; b=Paa42qr0P3PMZZsA
	wtsXsKohzQTuOaxCDEXPIGYM6fW1SkLcgzIq7hKWBuS6MoMyNShKdUPLDrA3TEEp
	KoRIgJBT8DAfFUMnHjnisOfOi0Fvir/XxD5wIoZg5ypvD8CIuVFYpslhT0+dvFMs
	6/DdSspeX03xqt+MU4QcpXnQm9bX6QQXmiYbQxG6qefx2ydzcBydxHzRq68YJoXU
	HUK66gttema0l/K8eEbRQU1N1GByO2Hoo+nay9uF7evyK+OPm7VX3kRRcANMlO/Z
	XTkcQRAHiBFtGsj3E+zBBFT2vD+Pwf9gIG7bFlco2+AoC1wEgstTWv+3CP9Vnhrb
	UC6MWQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq081u0gy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:28:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb1091fffso42787785a.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793698106; x=1794302906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnLwxnc87zGnVss348UPyqqWPDveLZQZgSaACTND7ko=;
        b=XjrNM+fCJwSBOUO/eXz+K6Bpz4aLWsrL59h+6YAwsxHmLcjvaD+rkD02txPa+ZNaM0
         NU3P2McmS3SummUye7elrrNTiWgeF+C016lNsaL5B9VqjaVD5im9BYy5DRIyAn2misZ9
         /kwbwpy00idlGHtMwyOyHY0YBE+TrC3fSg669vDfi6vaVutjM/WTwPk5VzvP2SIXdSxI
         TYLKodqZDtVrDH2iwhHjF5AUzveheSM3LPiDzWqo9JewBBjvyMazWzI0dk0hXltCvfru
         1QtMaHXJNlgveHxWcF2FvHXPzMiOEw/gXJold8KenZEENz6+pB20elqD1KMQjzA6o62m
         tY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793698106; x=1794302906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CnLwxnc87zGnVss348UPyqqWPDveLZQZgSaACTND7ko=;
        b=yZFI8KsKFYv/l1mYRgGaV5ms56hANABPG2g4gMQlzS9a+h6mJk1VcaxKN0ddCaYN3w
         nvu666DC7mCY78X9Iw3yOYQoxbt75WdDW/xeUcyHNEaDPXO5yOw3+K/YiJO2wEKEPq41
         KEhMe5Jn9uom2Ipu5poUcPXSGw1Tlue9A4o4YdotyE72KY1mE7Jilyi0LljMqszyvEdv
         KM5cZlssYXYLlLF2mkBhb0ZVK6PueOGfFhEsxx5PEqXyJL7hILgPe0JmDOecSO+IPbpO
         BkbYxsXjzXxcQBrSY/LECX0rKOyVIGUIJOWR6iA3J0Ez4bvUqewh4QjHBr3QEEjpfz2o
         utNQ==
X-Forwarded-Encrypted: i=1; AKwUvBziJSFX4mHJmoaNocX+F6clr4jADiCfVjZVDo8IG64eNXYEBvk+x8hdNrik9GPTZUyAMiaSLR0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c7i8qFjM+BBEbwEHM4llyWLuv8U+wB/Yut5wU9L46raWUUJoH
	gyQwwRqFcsOyc72O4yYLQjUksxg0yTqWbBH2d4rkCGwzJhozwQVtKqHE8ny4pM1d707Ftgj9uwn
	GE3MaWolnN6D/4tbBUdLBztIMSfCpPZxz+8BP/yaptz6ukW8M6/JuWQ+TCr4=
X-Gm-Gg: AYBFou1HHGN65eAb0yd47JabDHO36ENCBZBAnrk4kaTEdhgaCj46ThU2nxPti/b1JkU
	x3RtTn9gEXo6fE7pyyz0toKr3gPYPI7LWPlR9Agkb0iujhvQk13Fhw0AVlDCJNVC79gXz6lKmRm
	stlqtPQanM77/gm4Z98ykmOXHNG5MQ7W3JFs20I8/9y1prAcO+RHfCUG3hdqJPElMH4i2W47Ag/
	baYoJUu1bm4ftP1e2MWE/97ZeGBWzzASYCZFmM7XEeuix7eCLqZosPUmH6+5fKPnELO2eAgqYMO
	l7nDjXT7FfzhiTKjTKKm+0Y1ouPeDNjx1cbI9KrZx9q9ENp6cO0hS64cRjDiKXXizwaxzYhs1wa
	juvSENQaX2ksiqC+olsIekKXQlFTWYP+bZYmkUSVlxVM8BHyMIfuwUClo5I1PTgDACXC3ag==
X-Received: by 2002:a05:620a:4d0e:b0:939:8148:1e3d with SMTP id af79cd13be357-944215b76dbmr2356107785a.2.1793698106292;
        Tue, 03 Nov 2026 01:28:26 -0800 (PST)
X-Received: by 2002:a05:620a:4d0e:b0:939:8148:1e3d with SMTP id af79cd13be357-944215b76dbmr2356104885a.2.1793698105836;
        Tue, 03 Nov 2026 01:28:25 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4eca0fbd6sm4065994a12.24.2026.11.03.01.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:28:24 -0800 (PST)
Message-ID: <9f6029c0-5dcb-4835-998f-03b1b30edaa6@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 10:28:21 +0100
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
Subject: Re: [PATCH] spmi: pmic-arb: Fix the driver data used by non-data
 commands
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dan Carpenter <error27@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261102-spmi-pmic-arb-cmd-drvdata-v1-1-2e5ec8035b85@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261102-spmi-pmic-arb-cmd-drvdata-v1-1-2e5ec8035b85@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNyBTYWx0ZWRfX/SHCM+f7iPHC
 Mc9z9SCkPLeoMBQYQF3pTnLlHepE+6J2U07P6hFp3cSa1qFz/1RoOkCEsnD7j5Csr/3pStu4Tv6
 HiWqtHXWak72PD2cKPgfKED/ne5AxeE=
X-Proofpoint-ORIG-GUID: smiYv-iXqXSYrvZM8nXjLZg6JANB90HZ
X-Authority-Analysis: v=2.4 cv=F73C5ahN c=1 sm=1 tr=0 ts=6ae9a93b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yHj-swwPdn-rtVx7EIEA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: smiYv-iXqXSYrvZM8nXjLZg6JANB90HZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNyBTYWx0ZWRfX0fiXzssH5m57
 VZiMSlZwhvoiFIY69qnnZ9m6cW0zaWrUT+/5KPLitM1NbIlTpMPJF3+qDbrwo5RtMUfxwcDuivd
 lflq+dUNKs4qlwjgyJP0hbRFHBkRzaFMwoJs3EOj2UUpK5sEb1Xk081HgDhJr6DFFVKDza0drK5
 XJ9WfXxMP4x9z2i4FGN+NUSLeDedY92pJlkOL+bSKLG9QIF+peXSpoow0XzozyBMEbeC+hWiGJI
 JdZSggCSHnkeeFiEmH7/Mey5Z6bzz7Gg+o9FLwtZ8YcGUFpVSdKARrkkfBuMN1Q1RO87gvVttzh
 5cCS5AEta7RaCofI0O6XfnDVtpriTCBSCy64w08ayHItCfbtcPENbxQ+DjsnUz+ScLAXGMo8ppl
 galU5Z6m2hvcfMCEV61C7YC4ZBnXdV/SEqETbDtncKPxeRzAX5Twv7DaMcTehczsEjycfCGoDd8
 C9fSamjDoI5xZxofs3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030037

On 11/2/26 4:46 PM, Abel Vesa wrote:
> Since commit 02922ccbb330 ("spmi: pmic-arb: Register controller for bus
> instead of arbiter"), the driver data of each SPMI controller is a
> struct spmi_pmic_arb_bus, which points to the arbiter. pmic_arb_cmd()
> was not converted along with the other controller callbacks and still
> takes the driver data for the arbiter itself, so a non-data command
> reads ver_ops from the wrong structure and calls through a bogus
> pointer.
> 
> No in-tree driver sends non-data commands at the moment, which is why
> this has gone unnoticed, but spmi_command_reset() and friends are
> exported for any SPMI client to use.
> 
> Get the arbiter through the bus, like the other callbacks do.
> 
> Fixes: 02922ccbb330 ("spmi: pmic-arb: Register controller for bus instead of arbiter")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-29e1d31a-8d20-42c9-a5b3-41a90553d799
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
