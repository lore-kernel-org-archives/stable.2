Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00592737F8
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785651010; cv=none; b=hOfheBYMKttq8IC+kK6pHZ9LoIc22v1JWdSoLZ3KHYEVv/WL2d3/PHYWib54pV43ujouoKgZvsFQqASBA9K+e4zh0CN3yqyZB1blv9Ne/f9DdX1EApr8OBRA37vZkPSBu1qklE0eda+TkO3Xvi4n2sDk4+/T6fbuFGT5YTzCG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785651010; c=relaxed/simple;
	bh=QfJv91um63bPb9ScvxSk86fXm7iANE/MFGInCWz+ucw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGt/XJVpbyj20VXm6Q7nlj+niXe/ccvgMtkcdzz5hDKaqS90F/eYbCkrL83tFRoqMWWqskb4Vlj6ZWCAIw5I7eCUQ3pNtuJVOukoOI+WEj+ZqJ2qo5JQ/dpkC9kLP2+OqyR9FA9p+R5HbmeNzZvpym9RKBcJW/CAKXOIUFM2Cv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZEAzJidk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e+XVHY22; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZEAzJidk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e+XVHY22"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6724aUBS875748
	for <stable@vger.kernel.org>; Sun, 2 Aug 2026 06:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XtCJpW6WeDvF8fWWNtxaWZcE4QHG/drgeJPi98d2dgY=; b=ZEAzJidkEGp83wJu
	G9lcBbIotSWD5QusIMVztxcDIaZVhVQOomPv2Rg0tk6ohk0rNXhKDQjR5Ptc/QRU
	CwAj4wtg5ocPRx4GG0fUVkcHGEJq1suBi/nrz1tfgIz8Sw4BERuSYLckynbASrCv
	5GcfaVwvbztBL5fOM8dIOzaXLoVQeBtTqgtwS1BZifFYx74HHyjofmnKdvyKmqqm
	eq8Ag9s2+Tjsn6hFhC/laaR17qDVL2bmkNTkCiQ37LDJXxMkf4sUAsjlzVmHcBsY
	ANl4eqbcA0jYLF5IIFXnG3fBh0mzzdr/fi8rXcLgvkf0KCGyQJU28HVYIslvZLQF
	zqgG4g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs911aapn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 02 Aug 2026 06:10:08 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso3168411a91.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785651007; x=1786255807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XtCJpW6WeDvF8fWWNtxaWZcE4QHG/drgeJPi98d2dgY=;
        b=e+XVHY22tOjJzJd39WkWRkeiEbSP14P9mcGiQ0UTi/3/B48GCtl1voA3GJws9IEgUI
         htIfcNlQwuNDLY2YhNPoO6FuvqmXXJ3yJFEjq1aTbh4ZF6KARER0et9YiVEJEg7KUJfl
         z2q2en0buse2gmHUwEbzuox0t8OIzzHZwjA1PVn8XVTibHpvf1vILnyc+ec+0Q0rP/PH
         VVsqxgG58Mw/7nAEKvmYlxsPcyIO6ZuOsJ3wlk9pqQ2jW8JnrOut4D1N4tf0mO6U7zWV
         feO1dx2CVcJXQG/azO4STaK8XD1m8g72GJqbFp03h++CJ4R1L8ePQXrJwqV7HYmmFANu
         4pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785651007; x=1786255807;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XtCJpW6WeDvF8fWWNtxaWZcE4QHG/drgeJPi98d2dgY=;
        b=ZfoXALmy5//3idNfjYoCruz8a9MndRRW4WjPGMrL5Ev/1BliHmOtNS14+18mvTWDx4
         x5a8vRT0lEq+PEKrCeUU7HWyfYeUoDB9z6qwwfym0+gpKhqrci/cu+wgHJYY1JBXGepR
         q8uxsCrmEYJ1bPMCEI3hJZgbs7LcTmPy2mc2n4jICBDi0vdR91roobVj9mVCTxBEtoRt
         AAPHhuXQ3alu6dowrU8dlKD6wvrapFjf3PkR918m0KWvgQof4H8jrgaSg4IrXsV76NfV
         xQUIqR3fxCzVxyLKJEjJaDktRVPByQ3qi2Nt/M35DqBC6oIl26KlaHHTmzl/9nKrM+oK
         wNIg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0FFi1UhAQvxP1UNc1njk4rLhX9gNf1t+Fryd8a8zq01r8+oyBInI1MrR2WUxVX/ewsCc4F2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEUdAU9oK4fPHB6siWqi4X9wivsCDrqvHxq9KB+LNGpJOz/j0
	WySKjVtZg5AWFxCRnuJVHy+g8jazrAB2TsXpYmEGg6CfCWA1O9OP3h71LmC0To6NbPhXWe5EwZY
	AYEer9EzF/e9jU6kZcxQn6k8wJrVDc/XdtUL56S7eX2pCo2o9Oq1PSJJtE8U=
X-Gm-Gg: AR+sD13GtGDfJD68DUH1LJoSa8V47HiI4dfmR8iuDW8Tf5EMYubm5d3hiKmsDnN3d0Z
	lwwwCcGi8v4cYpMsiqVkjL3wPdwVWlYrnPDFLzUOjUYKzU8QrNj3Gcgq5c00bkLoUfAVqAu4BMi
	5If19/VdDaZd5yvwWAkTwkwZQzQUzkhEpjbFgTwxXzEZOUE9FnwqLkWxxsIStAwkg3W7qf8VH+Q
	HWxahqaAQ5kak1Vvasvtn8dunMd7U7PPT4SlwzJ/8jAkTtGTlFrAw4cvGEtKR0Z9zkcudEGyFX+
	3ZTxvze+u8BwdyVQwmNhwggsq3BcjRDTLIo8fhIGWI2PJ9nOf4FJwq/kdv0JRaJQgM3ErjLSl4R
	SyOjp2h5EUpMvIRlZcf1oLW9qXh4=
X-Received: by 2002:a17:90b:3912:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-38fbc430fd5mr5724485a91.12.1785651007380;
        Sat, 01 Aug 2026 23:10:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3912:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-38fbc430fd5mr5724448a91.12.1785651006806;
        Sat, 01 Aug 2026 23:10:06 -0700 (PDT)
Received: from [192.168.1.6] ([182.77.67.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153ddda5d9sm28617963eec.13.2026.08.01.23.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 23:10:06 -0700 (PDT)
Message-ID: <1c1c926d-e0a9-40f7-963b-94677d29ebb3@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 11:40:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0139/1276] arm64: dts: qcom: sc7180: Add power-domain
 and iface clk for ice node
To: Sasha Levin <sashal@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, vegard.nossum@oracle.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20260721152446.065700225@linuxfoundation.org>
 <20260721152449.211750681@linuxfoundation.org>
 <a0273f34-8596-4b6c-a489-66a4533b6dd1@oracle.com>
 <ab3c3006-bfa0-417b-86f7-95470c73e547@oss.qualcomm.com>
 <20260801101505-6a6d5089afcf@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <20260801101505-6a6d5089afcf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA0NiBTYWx0ZWRfX6PYhAiUlIwKw
 XCRJ5mrbVoPILB3fanV7gbRPaeJIS54zG1hc13y5r8q3oI+lESboBH9VrWMEaGGR6q0auEktdF8
 NIsc03IiDsfXU1tDZGozE+z1VMGbdZw=
X-Authority-Analysis: v=2.4 cv=PvGjqQM3 c=1 sm=1 tr=0 ts=6a6edf40 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=mrmDAJacfjHp5PIfN2e9YA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=sAzOfAp-q0GaX7_v92wA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 1kqnwj9WgEBeNVgFPsbFbOgzRFsJ0PKX
X-Proofpoint-ORIG-GUID: 1kqnwj9WgEBeNVgFPsbFbOgzRFsJ0PKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA0NiBTYWx0ZWRfX54vB3/LgdXbD
 w03DrjW3gDKNiOGONb33VMDXieeyP9+Q3Nrug8+tij2ccBPBJRml9K3FemeIDPWue7md0v2S8i8
 fkBj2X90q/rxpypoNhr064UDdBLdoeHGoBYt6D9u2JOYT448eyTld3ax952To9MWwYW5I6FW4v0
 dRUgWDIMAWI7AOmpHOy6wM7ix5srBkrfx8BjQ4pr69M26cBHuIjpUEkhY8pih/IKx1QSXoFTu29
 eMLHA3RZMf+lHEk9qh4POVoU4kXS+gHVY4EpTD2hx1r+ofKjZ7/e6Q0BdfYwiIpmR7hy8li1wzT
 8JDoFTNckeoGuyy3iEbU09PztZ4doZBPMgHpJrDY1vyn6YTzhxk3iXxE8cBS/GBrwCeRJxfogCy
 dn6xCk5PKqJmdduVo2gTiS+slWGAVdh8HzBbsaYxK0bqtzJ1fEyd0Tcz9iOQm8qBgA6Bsl7vmS4
 KlL7ScHsWqhLa5SRxqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020046

Hi Sasha, Harshit

On 01-08-2026 07:50 pm, Sasha Levin wrote:
> On Fri, Jul 31, 2026 at 12:51:25PM +0530, Harshal Dev wrote:
>> The 1st can be taken on-top of the four DTS, since describing the clocks
>> first but enabling them later via the commit is totally fine.
> 
> Thanks for confirming - and no worries about the delay, enjoy the
> vacation.
> 
> 0d5dc5818191 ("soc: qcom: ice: Allow explicit votes on 'iface' clock for ICE")
> stays queued for 6.12 on that basis. It closes the gap the four DTS commits
> already shipped in v6.12.97 opened up, and I confirmed it's harmless on the
> 6.12 nodes that were never converted (sm8550, sa8775p):
> devm_clk_get_optional_enabled(dev, "iface") just resolves to NULL there, same
> as mainline.
> 
>> The 2nd one should be taken to make the DTS patches comply with an updated
>> binding. [...] However, the patch must be adapted to 6.12 to not make the
>> power-domain and clock-names mandatory for Eliza and Milos since those
>> targets arrived in 7.1 kernel. Only the first portion of the patch is
>> applicable for 6.12.
> 
> Agreed, and that matches what I see: the allOf/if-then block in e27264daac7d
> keys on qcom,eliza-inline-crypto-engine and qcom,milos-inline-crypto-engine,
> and neither compatible exists in the 6.12 binding's enum, so it can't go in
> verbatim.
> 
> We don't hand-split upstream commits in the stable queue, though, so
> could you send the adapted version yourself once you're back? Please
> post it to stable@vger.kernel.org targeting both 6.12 and 6.18 - 6.18
> shipped the driver change already and has the same binding gap.

Sure, I will send an adapted version after validating the binding with it.
I will be back in office next week and will be able to provide the patch.

Regards,
Harshal

> 
> Thanks!
> 

