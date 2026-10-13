Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22E52ED23
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916143; cv=none; b=ueMa4IRx0UleHdkU1Y5sd8HzyakuQlm5z/pQnaU3gaFIguBZWOC+c+0tJcsSI+QdPpW2P7BCK5lLrP4s2LeovQpOyTMk+G+CYppjGFWxkfMCGXJ3mBPpIQswcIKj+FNb1YM0fFC9B54c8EkW7lKiNWMnDFGwXttKEv6t/ZZbSjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916143; c=relaxed/simple;
	bh=e9zBphVBZjd44IWcpVI0lqCnAplEQpZXDYyGO8O3PSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZIpZb/75urAf95DpUGmaG46OeWtCkpEfJhnY6GUAApWepyUAL/5a/NjEWfQcLzFKnFoXHXRkErwyUfskbB6eTFYFM1W94B1CwnwG5CeYU1ld7bV5kmEVf0gdq2QNTl+qdaplv4tBWHXbvGi4Ap0UqnF62nMnvJjNzosO6dIii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZ6bS9TR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ul3EVaQP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZ6bS9TR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ul3EVaQP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DE3unE1460112
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PSYA3BT7fccaOgtCBIv4Ihm58BgpNYihDvGMqz3iMdc=; b=YZ6bS9TRHlzDLJ1M
	S5RPkSa/7+VXXes6MMLQbiUVW7Ag0HpQcmw3TjFHKrUzQLem6KECe9yf4me1uiTM
	KF0i8Zi9ATtrLN1dYlIUsSpMoby4PhY23fCgp3Li0+QZOTMfCeEt3HZJnlmyrAfC
	56oh+tvRP05IlY+5Ot+VeIFl+M9AdpegzATZekhxE33xFN1dpTX+raO+5AnysYbI
	h3O3hBgp3s6KL5+INtX7yemKJY8Fg4LfYDvI7ACE3f12KpUvADPXwSIzVGOncIg5
	1h0nTao4ggd6Bpp6FkwdvHQbv4ASvzBUDeTS4zp6z6PvkKQd5JI1qjDlkSjw/4R3
	//YMcw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjtge1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:29:00 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14fed306427so521042c88.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791916139; x=1792520939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSYA3BT7fccaOgtCBIv4Ihm58BgpNYihDvGMqz3iMdc=;
        b=Ul3EVaQPant+aYGS3EV/2HAHDUm41oHwNiVIMbuHCKB9qLXLyLWLfcPiiqbSXK25zf
         6YvZWYy9hklwrgmfmbPeybic0rzT3GZk7y7bI56uuVr4L1ZjBKNY8Owg+R/6Oxt1q1Sr
         iCh2SGdXmUjESUnmXgC5Op9eqS+kHNTvz5faOjJldTuCLWQbKvqLpgkRiCMNy4pRDxng
         TVF/TIxWIpKy3cjE37Gv/x9ykzZpshzkuec8Wl4STaL0TMij3QXN+dhb+i197ZjYB6L0
         vGhzVf/hJX4XU32MAckKrBJrfVtbbSO+JXMzDzRrj8plkjc1GZmpmYmvnbP0VSyvyFvG
         vYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916139; x=1792520939;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSYA3BT7fccaOgtCBIv4Ihm58BgpNYihDvGMqz3iMdc=;
        b=X6zVC6S+g2kDxl5IJ+gCCbsQv0cxJXnp3ckNCDE2W1v8Vh+UDYAbuWRYCBb1k8drjU
         B6NxsyexnR9vwDrhBoAxobBiQ/vwVaWjb0dYwoZVaoeNGYxLA+QcYgy/Dj1n0t2H/INK
         5Nl9O1gR6YACz29WmYhUcXNRon2xPisNSzF85nl/AqEpfX2+c1eKsvNQgHxuKWwLT/nS
         /192AHj4tP5bN6O7deU74T6/1XI/yas5WKxEoYAGshCys2/qTHhDKe0ZUpuKbUTRSXDk
         p9tmDa9J1RYqglgAJevM9DL9LwsvDlZgGOJALgbDr+7IOElkHfCY3UbGRNS6yRKqmcUb
         cPAQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0/OlTgqQfRdx4kIcpHVyqnGYnP62ZWpIAdhOo69XRKAyyqKtLuYKMEQwU+nxXAl7G7tycJhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb7c+g+s5cJn2KuyMT3zf/pSa0k8bxsVG/hVzjxG1QbsoWk83E
	NxFDhmjiiUJm+7zxpILIX0081l7nCfOsvKN/vQDxP+ZWcIoCBLNeD30pYtGgsTrZ6EQ/zi5oheG
	PSxT4rU27aLMQ7wuv0XLamNn1aJbN+Rb0VPi/jFE/X8NbUb6+xAzEjxxDYig=
X-Gm-Gg: AYBFou0aG8KBZjFuq6rpGX2qB4eSBjnvvFdvAFiyDzH8XjEJp72c+M2N9Rmi6UuuBHE
	g5P+dK5aSBQLy63LiinZNuWtd8/5PSEY8MEbcywHzBQQlQSeETFCc8NEZ2Up9xsvuTLYALBtq6s
	nFbyFgSq2JL74CcjCtCUcydSKIi9G4Q+Hxb6QEzPhS9aersl9wURp7JWH9tpeO1v0oVLjiXat3f
	kZqYGELli1+ZjhEjFVYMkGwGf8k1LC3gmXovgWGUl/YYGsZCnimIiSa4wOb10nrNMC6qoCAIWCO
	pNT+2E2pJrEDRcAagGq07piX6gycwo831XgKIWFmf1gFJFwcMZagWw9rMgedlCeACLfjrjZ3iPp
	5/snjZiktBtTEcoa1pa8t/GedHAhFHBI7ZahOnT1AFWWjbqunw65iNhewwKaMdnqb5HjD3oA=
X-Received: by 2002:a05:7022:b0d4:b0:143:2984:6518 with SMTP id a92af1059eb24-16a612bc1e8mr20627347c88.39.1791916139060;
        Tue, 13 Oct 2026 11:28:59 -0700 (PDT)
X-Received: by 2002:a05:7022:b0d4:b0:143:2984:6518 with SMTP id a92af1059eb24-16a612bc1e8mr20627312c88.39.1791916138466;
        Tue, 13 Oct 2026 11:28:58 -0700 (PDT)
Received: from ?IPV6:2401:4900:889d:390b:491d:8cf9:7389:5b70? ([2401:4900:889d:390b:491d:8cf9:7389:5b70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567aef5sm39437810c88.19.2026.10.13.11.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 11:28:57 -0700 (PDT)
Message-ID: <4acb0eee-f7ae-4817-9848-d72cf486bc06@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 23:58:44 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
To: Thorsten Leemhuis <regressions@leemhuis.info>,
        Daniel J Blueman <daniel@quora.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Sasha Levin <sashal@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Birk Skyum <birk.skyum@pm.me>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260929041444.9837-1-daniel@quora.org>
 <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com>
 <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com>
 <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
 <20261009145800.rc-reply-0004@kernel.org>
 <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <b7bfbf6a-e5b5-48be-84ad-8bcd8e22c5de@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3MyBTYWx0ZWRfX7HrIkPnQS8bh
 Qz0eFUSayFbH3Re7lI4KJWflOGo1AyaBx7QNtHfmhxwuNh45+gt/GI9YcuCmpWhQwMIGLK2+EI+
 HitKjh3mcvgywmDFhiFirOY+IOUgNcA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3MyBTYWx0ZWRfX8NofVRy/e24E
 cviO41ffFKiadvs3Qq9FvhgVnG39OqasFcErJRDQOHLuIV059NQ2D0NVivzuHcw0+AAcGUVudBn
 J7AvHD5W1L1DkqhFeqlzKifnkGzv3nnGEBFsFSkDQMYNhuJjZdncwi9CL/Zye+TcxGFu3n7uHYx
 y3TGUNyFe0HSrah10xGRL4x8OGX88sd9P5FJWMYaT7LB+ulH5xradU9xClC1FMAwOmEDtwrbRN9
 Szq6voZNA75KsbHrFq8M5DBri4Qh6yeSYOwWGk5dfWH4eGAkN0KK8fdtlXIKbM1hnVtQZw7r0X3
 qzhDvrC9ticV8sCoiS+W8m2jGxygXaczY4Mb/o81BTI79wEPFzpQv+TLGmK9QDIDiLfNr3m8VvN
 YVbRbeBfOkQMYgtW/VTTzYHWB7qYSJBfKVI6iNzVHWlWxO1flNRCb/8/vAwRuppd4DRLKX3aT4a
 fib4rHyFQC+zMVbdw7w==
X-Proofpoint-ORIG-GUID: PZ8a75CuzHyEN_Puf66_5G3a0DuFYorf
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace786c cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=-sI2l8CUKJjV0ebggCoA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: PZ8a75CuzHyEN_Puf66_5G3a0DuFYorf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130073

Hi Thorsten, Thanks !

On 10/13/2026 1:04 PM, Thorsten Leemhuis wrote:
> On 10/9/26 21:01, Sasha Levin wrote:
>>> On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
>>>> I would revert the original patch if there is hardware that uses the
>>>> I2C 1MHz fast-mode, since the current timings aren't to spec, but also
>>>> weren't before.
>>
>> For stable: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
>> SE_GENI_CLK_SEL") has already shipped in 7.2.9, 6.18.55 and 6.12.112, and is
>> queued for 6.6, 6.1, 5.15 and 5.10.
>>
>> The 32 MHz clock map (506bb2ab0075, v6.13+) does not exist in 6.12.y and older.
>> The backports there pick only the 19.2 MHz entry, so the Yoga Slim 7x /
>> X1E80100 timing regression cannot occur on 6.12.y or older, and I'm keeping the
>> 6.6 and older queues as they are.
>>
>> 7.2.y and 6.18.y do have the 32 MHz table and are affected. Once the fix lands
>> in mainline, I'll pick it up for 7.2 and 6.18.
> 
> @Andi, @viken, and/or @Daniel:
> 
> Is the patch at the start of the thread or some improved version heading
> to mainline meanwhile? What Sasha wrote above is one reason why that
> would be good rather sooner than latter; another is a regression
> report[1] from Birk (now CCed) wo ran into the problem with mainline --
> so it would be good to fix this before 7.3 is released, too.
> 
> Or is a revert the better option to achieve that?
> 

This is in active discussion with hardware experts, but taking time to 
get specs compliant configuration values while it's being tested.

I see 7.3 release on 25th, so what max time we can have before reverting ?

I am trying to get values asap.

> Ciao, Thorsten
> 
> [1]
> https://lore.kernel.org/stable/179173732257.29426.7905170638383807320@pm.me/

