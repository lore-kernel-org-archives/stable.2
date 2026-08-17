Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B200427FB9
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977137; cv=none; b=WfFVDYvIDdNTanXzcWVw6B5NqJwtbodG2seQIryYwEAVQB8lOAVUL0v0ObgTFEPZMPHp0DAISbho3KHaPgpBkbhhzjhD2Wr7KNE1Bik1C0fXKzpS7v3ccDNDs6EUD0y9lmco7dsVPs3bPC2z+W0zVNTsNJaDB+JH0ScG2D1YFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977137; c=relaxed/simple;
	bh=xwZgFuVB+a/x/YBNjBHaRQYJBj3ccpCUe6U9ChYIHv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKlKqq0okPuYHKeCAHSPK0t+qX7XR5IdQ3Pr3p8PP3xIykZfPtVgm0Oy1dKs1mvB7V7WgxzJOYr7W6XG2NC2WTXXaBG6UbAXGdVj69pJzE8vE8zmxYUcQCtsI7gd7OVSQxCE3fkXi4g3RuAYwv0Cb7ebXqlxbj4++QgyWoHdBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9I62IrA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4Wqu6FI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9I62IrA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B4Wqu6FI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD5rd32008348
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2gJlC7z96U2P7KeHUsrz93C7B3NJLrVoEmMO0j0t+PU=; b=a9I62IrA0sPgcTmW
	aZ4pQrHL0lwZDFgiX9zvh48qNCSjhRfT1CXGdJCTZsLQac087SYiAvupxU/74nZy
	OpC3YRNrkGLYet1Hb8IDGnYQfZbZLbcIEgUxVC+fs8y/Gw6TClvWw3Edg3oAsjOt
	WwZoxaUTZ/M/Cc/rAlnQdwAgt3d1wNt+OI7lwe8/B0ONr60yAAGSRT95gmiDiAfD
	zxiC2k+Bj78m4vZGzjyF/zfTE3nR3ynfQcJiqc92g5mj5/1e6f79YbxPrK9khsgp
	NapB4q/R3WITXod54E0bH3EUn5ZiEerf7UQehJkjVVC6D0XGC0racRORtDoAj7I3
	4fHE8g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xw8hbxn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 14:32:15 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c39f4ae8c4so52838e0c.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 07:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786977134; x=1787581934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gJlC7z96U2P7KeHUsrz93C7B3NJLrVoEmMO0j0t+PU=;
        b=B4Wqu6FIRvOrxBKun6bm8X4Ly3Ya0DRcqpFDw1oImim/2uB1tMH6e4L3IVVgZgzo2T
         zDCgb27yNkfnH9v2LBM3rg8AghqAPQofaV6mxisg78I4mP5JGwSTCU3KskkmzPVhaJuh
         J1WJ+xGPnFw6b0g0UCAWAZsTlDwiFugTZ4MmXRCpTqKvzZcEewWCZhrwICSNzd6prx9l
         bQc3Hvqn7i9S21xQ4s/jQezaucKTGjcmNRlkiEdQjAXLabBO8XT7jx7BiqJlk3tOBR/0
         UcSC1TsiTnqkp5ajROJovAVGgsd6qlptkSuUkUMeclwWOCIrFBEzgt5cudNZe0/ZwlEc
         v5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977134; x=1787581934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gJlC7z96U2P7KeHUsrz93C7B3NJLrVoEmMO0j0t+PU=;
        b=C4OWhDJdhFTIOT1m/+2zwJG+ZauS1RePg+uuywwgehFharnCizEijGSdU36OwSK1y5
         1dQfTQyoozRdDFwXs063qGbO8nJe0rrjIf0x0iYG/Uhv4eaMKDK9ZEP3T3No/gC6meaD
         SCNTA+q8WVyJfoyiMDxhfFlwwmmTHhWH7LqM5FT1i7vSRUOP7VdjODw8ti1G3ky65Va7
         +bI7tyjl4bHPn7963eSCaMapLSx0gpLbI5ap4kOMkHd+H+vu2t78oaqTFr3HcnvBdXaV
         kMlfGS2GiQmMCM3MFdC0fofeudDPrkPDHy56mD2MmkvszbgnIp/VAGGqKPMkKBTQGlx1
         LD2g==
X-Forwarded-Encrypted: i=1; AHgh+Rp6cKHop/EsAGbhcvypItcB87HyIZhJu6FLreX037y07ar8XGoP8UjgwtsB+WR9DSQ3jyzceHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ACxfTpJmdfjllw8VlKEQI2XhNnCud/ZjAZuqMYK1Joapo0Ih
	a7P65EuM3K0hjXaU5y+LFJ01UDocouPDbkIf3MWarjwEPBzQfjkd82cgBOQ2nhsK18Buw7QzOKE
	OykvumrrVHhQWAKyY9cjEr6f8cBWJgWpYWhF99J7SwDUSgVA5gnrHN41k1bU=
X-Gm-Gg: AR+sD10K4VzK0ihWJI8x+vbAvsZ9UWAaIf4BHtvQuAth7/1ixuIhWY0Qg8RFQvg44oT
	A4AA1Aw0f2r1h9+ELb9w74etOfCbqlBUHsDV8qKdrBfRF7fnAx0OzfgyQeeXJEVW5LmkPRQBv/o
	FDUlZbmMUe1RQEPOQUlYUeEOSQvauCKqazt8iBRpFD6JIl4kkC4zsn97S2K2aP8m1slrxqOdWy8
	256Q00m21tyDVgzveum+0iP1JqaRKPJf/alTfE+u3/zdJw273xIgUD5s+nvm/929qBc+GkzFqMD
	BLFuLhoawX08v1cM8O/Ml8EY8mC6gN6p038eQiPp8CZt29Uju+sw09I7XF1aAmZwSpcJi+iOJsn
	4pvQVuZWTmudWKIe4heRmR8Xc
X-Received: by 2002:a05:6102:5091:b0:74d:ce65:3e8b with SMTP id ada2fe7eead31-76f2c643703mr1642973137.2.1786977134372;
        Mon, 17 Aug 2026 07:32:14 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:74d:ce65:3e8b with SMTP id ada2fe7eead31-76f2c643703mr1642778137.2.1786977130839;
        Mon, 17 Aug 2026 07:32:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8530d3bsm833509a12.10.2026.08.17.07.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 07:32:09 -0700 (PDT)
Message-ID: <db0e8834-598a-4823-adb0-c8655d0c5dc8@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:32:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] power: supply: qcom_smbx: fix float voltage selector
To: robin@snyders.xyz, Casey Connolly <casey.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        stable@vger.kernel.org
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
 <20260812-qcom-smbx-fixes-v1-3-eb48246be599@snyders.xyz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-3-eb48246be599@snyders.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _cL4HcUey76uRqL9QIRf4y8hOuj4CSxK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfX8QfySJq1g/MG
 67p5uZPWW3uVc5QBkfjR47QIlxAxGOl8vATO2mSOXSG5bSLkPyEUm+tHg65RIxH2/Juuqd6m8EN
 ITHyy5KTqmUQdKEsFy3ybvL6zr9OfH4=
X-Authority-Analysis: v=2.4 cv=SuCgLvO0 c=1 sm=1 tr=0 ts=6a831b6f cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=OsHF4jKAAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=d5mbiQXY12LgLljGaeIA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=tNoRWFLymzeba-QzToBc:22
 a=aAwnOj5LE8VeXseigifb:22
X-Proofpoint-ORIG-GUID: _cL4HcUey76uRqL9QIRf4y8hOuj4CSxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExMSBTYWx0ZWRfX35Db7QbmEeCy
 g02ZchARJWi05BSCwFGRbM5oiUImshmzAfgMPiL1nm3sUdI02hB6GnYuFTyW5U4aDGaA4xnw/9q
 JDUaZ8K49rYB/xpGrtFJ712WXH1aNoVW+aLaescmubm4mh7zxSqHQotzLJ7jkRQg8mzNF8gyGi2
 rvdCMtsBc4xeB0X0S92yiDQ7ascVLRYSdbiS/C8WpDfaqlId/gHGJK2ASfFMZdwDgBWmRMF/1cQ
 8gmGwvqWtVojaJuR4Xdk+RhAmguUqM505s5RR9O9t5s1jMecAuWtnNBiHX0HAl7GElE5Lo5I+Dn
 ms1WsSiGlw0hLBiM4mwJ0CMP8BJcElNBhujDD33NYG4dzqIWhIS/a/r7K5GmR81zx0eoEByFZE/
 0kJy2nASKUiaWRKhLkcq6QnTMwl0zjmbgc8RcAOQEi2sUAv8gHlMpGwqGSF4/f9CX6wRa0z1x7U
 5FW1FzGdDadfNgC6+rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170111

On 8/12/26 1:30 AM, Robin Snyders via B4 Relay wrote:
> From: Robin Snyders <robin@snyders.xyz>
> 
> FLOAT_VOLTAGE_CFG encodes 3,487,500 uV as selector zero and advances in
> 7,500 uV steps. The current calculation adds one to that selector, so it
> programs the requested float voltage one step too high.
> 
> Remove the extra offset and name the hardware encoding constants.
> 
> Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Robin Snyders <robin@snyders.xyz>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
