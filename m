Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BB41E6AE
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532699; cv=none; b=a5wVgUqbejkAfVcxfA2m30FJWwb+cvnfRuQi/oEaHWonZR4bzOHoncxb/RpPULI0YL6PnNxJzWLY8Im5kPq1YGDAfMmswJcZRkzvySV8Xp0dZI8siabMqFUtm8a0a/9GFb84EAUtmqATqFZXm6nKEvyPfZY8YKB3a3i8GJeykJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532699; c=relaxed/simple;
	bh=KoYLN1pY8H8fCZ05HSFRCrDjWdqChrSYcmHa8I9ORXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/4e21CmhGXOALTfmslYwifSYeEEb3TX2hGYOBPQBJY13G4SxQqkDZor997AjoI2/e6TtO5WEf+7Y8+roUvZOREAuUiU8XLVnmiP9DNYz4p0sK73JK7cTHXZBIVjSdvko8Wo7x3MsvmFbcuLdhNVVkzlFB0r5vAXkkz1wQzP7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aGcgyS+S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7lniHxK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aGcgyS+S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7lniHxK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB46SN3265824
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KEYzo0w2+JxY4l4xdoQdqu9J3lwTBkTUXGBrN89InDw=; b=aGcgyS+SWGuxhZ+7
	or5dcgSQ1ie7LhkND50lJtwFjrhlfLp6Qs3DxIHak/JB+lj3xzX0rj2uRil5t668
	Yg5DvpFLP25zu+CHGp0SAUVWdWXSig9nrRRRi+FSkuQDzjKLB5XPKjk2k4tcSss/
	femKK4Ma6aNwB1EI66yT8cKJNwV/WgK27KadhGJw+TQLUi+6wIUNZjAgRYWREGlN
	eaJflj+jrfOUYugAOOhmaNuHsacV1TPX5Ff4sFSzqymhIn4Q0dhdR96SQzkjO0tH
	XU5J0mgIY/OKVX+Rd1B45Rn0JGmzaEYIaYUgXifr49OzpNB77pnb916KZDHEROAN
	LifYPw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrkgkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:04:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso1126725a12.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786532697; x=1787137497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KEYzo0w2+JxY4l4xdoQdqu9J3lwTBkTUXGBrN89InDw=;
        b=I7lniHxKLJw72kiKuR3grkSwJC4B8uGrPbDZ2crbUuaLoOTJy+zmERmmpNaKAPao/8
         MY7jDuN1+JFVy4b2yDvfdZG4czZ61KWonqCePh4wnOUa6gP6LQzjzUwWTRxWu/rJ32DJ
         fTRUIVc1afPmnsrsCr+OTCNo1F38egGfwKZTGAlw4eTves83nutyYCG9GJZhiJlkSDMe
         JeeWUElu7I2a56vRRC6TatH0ZfGojuYW5OnXz2lvEy6cvqFyBhL7OrhtZCBPRniSQHNm
         c4ARg3P5Cxt85HpIOGvsg2pRyK2wWnDdyAycLVthhHne3asUKtxeBokZ/cFXxEFimYus
         jS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532697; x=1787137497;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEYzo0w2+JxY4l4xdoQdqu9J3lwTBkTUXGBrN89InDw=;
        b=Wt3mIB/9WrEMAtkV2j6YcdIRsLjEGXZuZE5XWSuQCUZugm9VLhdB5ASJO1f76AdM+f
         4vAnB9BCwv3u2eev4Hxgb7NU3Mnqn9+mCE4A2nzeSVbqJMzn1H0h98VQuwGlU+YlfvFf
         zJJoLxcCzmVcNggEj9+xzkiDevjRFswge88STQOdmHPMmL+3pLSh1fum9qt48A8Rz+J5
         R35eKATzMslI3Toy6wqQeGmdxifADOdBb09L2VusADWBFA22t3HFT2iG2pNMU6E0UN4b
         HTvUJnttQXYT1S4lbOxEeKX7VzfzflkWojQaFrQ3/AO1bPlZSeHUhOqjHOUq/es/9cQe
         sjXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNn/pwYZALlWBT3s8w+hqt2huKi+DRZH4bG/ap7uPdlqZegAPRgw1nb1ITjtHp1wVbOVyr6IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLY0NsMuk6SVrju04314x6wZKXN+4GDKVtF8JoUFu7PYtIJiuL
	vK4mV2mmGbwqR8ygMR+8c9wH77U9fGYBF3mFsNZku+1Tv3tiITY7DidHr5eo0uWemInqICWYYug
	9C+DhCZQNXk4cZQInhA/aPzwK9FTSnUUAUUbDWHQopWIqtFrDsueO1V0MCBM=
X-Gm-Gg: AR+sD134yiC7lD2Tt5qkKsgsWSGIIsL+tzXkj22XflHJvuZfjzu2EWaBfNX7RTlTigP
	9AyykLDw6j2eciJo3vhV4W2LWBisoCx7dNhCVun32wLBzGToUQAIurEUjfhFAkID4YDY2ZcA04V
	9l8gEZltJsEzPsptWuxahtURzCGkxq1JFMmk3h978cp0EQvG69icVBTPiBZHflsDZvk3mGBTMvB
	F2tMd47/OjiU7eGI8+xrprWgui5o7CgmV193R/iJ2o+KOGk7jBZ0IBhwYLy2dxAuzCaAMo1gy5x
	V+nqGqenYUSubr46H1ssYCUzVkkQg/LC+UmkYDobz1xBywVvM33t8WAKQd6Sd+95Up08vJOexrY
	7kyIMX2OY7ocrZamWg9f9PHTXs7/KithI
X-Received: by 2002:a05:6a21:99a6:b0:3c3:791e:5e0c with SMTP id adf61e73a8af0-3cc3f72fdd1mr3773458637.19.1786532696994;
        Wed, 12 Aug 2026 04:04:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:99a6:b0:3c3:791e:5e0c with SMTP id adf61e73a8af0-3cc3f72fdd1mr3773366637.19.1786532696410;
        Wed, 12 Aug 2026 04:04:56 -0700 (PDT)
Received: from [10.218.22.155] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31d6aec3947sm7252714eec.17.2026.08.12.04.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 04:04:55 -0700 (PDT)
Message-ID: <9a31395d-15ca-4e74-b906-2cd5b56e0529@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 16:34:41 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
 <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
 <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
 <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
 <002ZtQRsWlMbVXarg5v4s8YbLGtxjWZJYhk47a6t1t-uTUXwA5ifUqzAaL1f4zKuffk9ig9c4v2vymXcQAj6AQ==@protonmail.internalid>
 <bkghekyhpporov7whqjd4s2oxaqd4dsjsgxn76vb7ezz67sbso@hrjpt2v4ejxz>
 <f2814e0c-15a9-4b7b-bd13-edca6c007e1f@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <f2814e0c-15a9-4b7b-bd13-edca6c007e1f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -iJej1egkvZonLHLN4Hw4b3s5Gjb7P-h
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX6OSg10XQpAr7
 hRTHcy77+z0YTZJfwORtgtDJeA/Q5YKQ7pKEJvnMxG18jZZsv1FFEkRsWMxYVmWUT8eELNyvsoJ
 QpSMJMG4G0Nqhn3Ro6UFwyMSn7agSFw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4OSBTYWx0ZWRfX3swyDQiExMf3
 2AsGsQ9+bhVfRNSd90x3Lu3pBnjD6xF2amAdUgZeLhSlNrxSQToK2xGh2rI+mKcGAHe7/JfPAGO
 JlenbikYFlpZTfWJdOaPY+sNNHyq/ZWE/9C9AkzKyvxcLwIK18w5JSfvE/g6WV9mSPpCwMW6oiV
 AjiQUcoRzf8s50YH34IynCfsdZGyd/CAVK8qirFJ0Ne5EmcGtH6Dxy0c1WT7hyJQ0kYTWj8kE2h
 cWCcLs6n0fp2J8qwJVwq1qc75RwPkd+w0pseQmqF6QfC0J6DMt2PxN04CcZz6gwaeBSqdkoGRQk
 TjFtvsxcXSg64yE8ax2iTWjhja6V05vyyKb+XeYSJOBZkq4XaeXrePsJd3dmps7Uhd+6gdILmei
 QCxKC65ENluTdKHDhojjCSwzLmKuBBnQTRevfuAfkPwjwU55iIOr6vlZgyU8s74OkKCgVDyLWKa
 XCMb52Yf/Yf3OG70E1A==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c5359 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JpGp7-KgIncjPpN-K7oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: -iJej1egkvZonLHLN4Hw4b3s5Gjb7P-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120089


On 8/12/2026 10:49 AM, Bryan O'Donoghue wrote:
> On 11/08/2026 01:17, Dmitry Baryshkov wrote:
>>> You are well aware of them, but still asking the same. Reasons,
>>> 1. We have been attempting the subnodes for almost a year with multiple
>>> pushbacks from multiple maintainers. We are closer and working on it 
>>> to post
>>> for iris, followed by venus, once review is acceptable for iris.
>> I think that we should have concentrated on it.  From my point of view,
>> the subnodes solution is ready and the last obstacle was the
>> under-informing commit message. As you can see, Rob has (had?) questions
>> about this solution too.
> 
> Its taking too long.
> 
> I just suggested restricting concurrency but, that can't be right. The 
> issue is IOVA - concurrency merely makes the bug more _likely_ to show 
> up so in fact that won't work.
> 
> -rc1 hits soon, if sub-nodes isn't ready to go by that point there is no 
> choice but to implement BROKEN or minItems, 100% up to qcom to decide 
> which.
> 

minItems is the way which could easily fix and patch all the kernels 
exposed with the known bug.

At the same time, we have identified a way to even reserve this in 
driver now (venus/iris) with [1] and the results are good with this as 
well. If not minItems, would prefer [1] in -rc1 to avoid further delays 
or to keep the crash exposed. Please review.

https://lore.kernel.org/linux-media/20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com/

Regards,
Vikash

> ---
> bod

