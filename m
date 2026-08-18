Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E641F366
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041216; cv=none; b=RBE+qbAiBKkPxaP3U0vPvbYyBdPLiRR7gmUrb9taYfQ1Ys5GNeY96HYvSFaB1SzuxPKkOMUM7w4ZzMcuHpfop79hAnKfgqrpvSApgpVREW3nJpvabj/fn9snIiFmejXF/JNU1jFPJfXcGEZUArip+XNd8SEfzeCynLkJg9gHNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041216; c=relaxed/simple;
	bh=ycovQT/558FlnXscF8m7zxc9zLWWsuZv+tlyiAi8cKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqVs1heAmFwx59sb1Bd4zaFzOSG+ZbKwh7yLk8mZNwlHWUWJSz0ewI6GUoAKHpq1FLhsxsySgH0kuppIplw8LtIgTAiHnF4rBaHes2nuJr0S6QnNBCAavTsgMv48rTRVhPQ0G6csTMUo8rtKjuXZIqUieOUbli7O/ecPnwkcB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMhLpZWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rk/Dh+KU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMhLpZWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rk/Dh+KU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BI6V243024
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=S1i9yeznsxYEHXqB0fIApER1
	x8xqRjP0230BnDCm118=; b=lMhLpZWNqmD3WPWL4aYj8Xq0MKgo3kKIX7AiyAbz
	0Mq1Z1SwYNka1cX2xOUg6H9XaexhQU5W1g5i/nHptNOkHZc0rbZRzM3dPkid80ED
	+e80UEaTXPm1Z804gd0wNoYrNTxQpDzkbyZXIi9pE0zq8WNtj7faIjW6rMAHRghT
	9aG6ibjjQZVndnPz0Id3Vi0amNqpsWNzHL8tSwf6x2fMUqdrrGk1tvgHEUU3AJF2
	bxo43gjnC6NraQOczXYG4mGiPfjFGC5LaaRlIJXp1/m8tAgSHfP/UE4lo+lT1y9R
	nmGOPWDKorGdyEF1HARP69JpRX+8+nFPi0nTNVQf5aRk3Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ea2hg4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:20:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52d7b3adda4so43174381cf.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787041213; x=1787646013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S1i9yeznsxYEHXqB0fIApER1x8xqRjP0230BnDCm118=;
        b=Rk/Dh+KU87vZv7JskT6DAxlqQ5xbTctGTn5E2uRLoUmPW56AkOOrV/SSv+at+36All
         Y3o2T1Ma9/Ba+d/qPxdQjCHhwjMfL/Jzm5QQA39QKA06WRQCN0+x/q25T+Umw6C1G8CW
         MlEQ6IUC2zENksfGVyv2iIpyA84VCxeBNhvKrfiwd7uw/87rUH898O05ly8QeST0imfX
         x0AeH0zIEoG5yTL69Ni2VDLIPcnYUjGXd3l5SAHnwXTAn1C7ZnTfeO9ptmoQTx/KZMBf
         aSR3pyxx6g2UcvHlWR4/7EjgZNSTM0mhADMPVasyMNcvoC6uRM2iTU3ydBjwin69oq5t
         f7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041213; x=1787646013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1i9yeznsxYEHXqB0fIApER1x8xqRjP0230BnDCm118=;
        b=WTWYeg1QwQqyFcP7KBotHW2jXN3jAXt3nOy+ArfltMrSuRqNLFgxFM3dG8fkT8Ok/8
         TxkqMBBYwn+zIjsmC9P2PLNjVdzhYqWQVk7IjDb36N2b04GK+eUyahtxxXHJxSE0Zd8J
         2TY7/8XI/amEeB8YfdOfp4CwJANJ+/FJHCiuD2o8qK4lWLR4cp16kZRd9OxMpPaMnYMk
         NwZlNxHkz9dfHN22yDP1TRnEnegIWok0sSAwxGEPIYT3WqEXnk5+/FjtQmOnmeO9JTpe
         E7CylQgzY5s23WP+KmW+2w7NEGMOQo5VYn5IMbCDpxLY+B3evdN+H1gYVkh99Eq/iB1f
         /k5A==
X-Forwarded-Encrypted: i=1; AHgh+Rr2pgc6h3rFpTau1+2623c6XbEZpdnTdIO1gsh3pMtM7BNM5zNmMhThOqVreW5RbBALVMy1p9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3QiGdJv28MXfjXsFmKxNz8Z4mYmIjH8LiN9cOj1lN9ebmJEu
	Hxs1PwPoOAbq/PQoswbJSRybLnJRDJPT6vpaY4m1G/AWUjP6s5ilrzEqGk3aS9n7yfdd9Dhno97
	irVR7wpOz2DJaYVuNK/nQNgov5ZjfQu1+bCTH87j+RtU43rEfq25YIoDEvRE=
X-Gm-Gg: AR+sD13Jucb8kX+lOjAMCtTQ7yVTdHe3c/Jr7h+UEctJMoeUsFEv9icsIyYBckSQhiK
	O4pMjbz/mvQCj7vDYUbAdFP6kTB0PnIS7UiCCQeADMXg07UzdXUHEfcW9eDV8MpLtC18zXFtKLM
	O2zteZtgQm/AFhFG0k1iKqt3yyQEsnrRaWoxQC4+cGk/X5rSts5lLUBHbX+Fb/QD1Et79lF4Gpk
	CmB/c/tPx1VJiyMcSS024P1Chi90LujMDUep4BwYpz5UOJGnpsipKK35ZiIbEgfqUUt1WaVZa2x
	It0VlpKVUFflvFynz8k73Epg8rRwRVPdP66tdP3SX4HRi2cljfivI43GO6vBpldWw444gem7Hne
	smyHQNeeOuBukzH/358NDRJwx226sRQxu6E+bnJsBT9mJh41gjOVebqrwQB+876ttx0nYPKpnZO
	irflAcbp5nar1a
X-Received: by 2002:ac8:5f8c:0:b0:517:8470:2d2d with SMTP id d75a77b69052e-52dbd71dacdmr55780591cf.29.1787041212930;
        Tue, 18 Aug 2026 01:20:12 -0700 (PDT)
X-Received: by 2002:ac8:5f8c:0:b0:517:8470:2d2d with SMTP id d75a77b69052e-52dbd71dacdmr55780501cf.29.1787041212387;
        Tue, 18 Aug 2026 01:20:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e55fcsm9764021fa.16.2026.08.18.01.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:20:11 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:20:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] media: venus: Fix iova allocation from restrict
 region
Message-ID: <jf2zzsnwe66owxs4rgpugbipaztw2xxeejz6q7vjvnttq3lnz5@spdh5ylsqggp>
References: <20260812-reserve_iova_in_driver-v1-0-ed62f801275c@oss.qualcomm.com>
 <20260812-reserve_iova_in_driver-v1-2-ed62f801275c@oss.qualcomm.com>
 <hzu33hharafxhfdnr5tr23ti2tmtjhls3iwbvmtfllwcv232m5@nvxemt5ijf4n>
 <8a9b417f-11cf-4dd8-af3f-494afa38b868@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9b417f-11cf-4dd8-af3f-494afa38b868@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2MCBTYWx0ZWRfXwkhnwxl7jms9
 GpHpV0FrMJ/qT9ZXacdYotKTYJ4GU/IfedYd8e3wndJWCRoXk5sOzjWVXGTB3L5Uvs+0pIX6s/P
 GBPsJmZycfnTYfSpIPn0TgXE4oYhqDaPSlzOPTe0az71mghSgeXpoV3u6Jj/y0l+fwMGEg1h4UT
 vyIHnaxD8yK0AgFdhvoFHVL91j7iyQX8DxWsTUa0d/xqvCaBLycJkQgtNE2Mq06TguwkoORdEeG
 AZs1cioe1XW7K+5FtRYAHXsI82l75Le24RglvAiTIY/+PovWNTXduQzbp7XQlDWs1xio9gMEefj
 0iVfmk6n9w6HtHpPimJaJbBhvAFP1DLAqg09vyX1LTETNdYI23V4J3dDiFqpTpzB2hodDliTqOt
 88dp055U/W85lQ6YUvH9IixQMcuKPqFqk96yyF+UnUGOjCH8aLGYVBXIKkIEZAwDtLUPuu/qTqv
 fjmZIQuFw9Y8qQlUpxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2MCBTYWx0ZWRfX5P8yI84QVhbc
 X47AotUgJut4Ln1SwSGTDV7tOudkbxWHP9duZvG7SF92q/SEfVRx0PiXKIAIT+y2K3iNqS6L4I8
 mXBvXIVrwqKLEF4g4pC7sRBUHVbn7Uo=
X-Authority-Analysis: v=2.4 cv=XtfK/1F9 c=1 sm=1 tr=0 ts=6a8415be cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=PHneWq3mTtEDJPo0Y0MA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 1wH2_W8hWJmovm2axUtcKToKruIj0rIa
X-Proofpoint-GUID: 1wH2_W8hWJmovm2axUtcKToKruIj0rIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180060

On Tue, Aug 18, 2026 at 01:25:58PM +0530, Vikash Garodia wrote:
> 
> On 8/18/2026 12:34 PM, Dmitry Baryshkov wrote:
> > On Wed, Aug 12, 2026 at 04:25:59PM +0530, Vishnu Reddy wrote:
> > > The VPU issues DMA through several SMMU streams, and the hardware does
> > > not give every stream the same addressable range. The non-pixel stream
> > > cannot address the low 600MB of IOVA space, while the pixel stream can
> > > address the full range:
> > >      +-----------------------------------------------------------+
> > >      | non-pixel stream addressable range (600 MB - 3.5 GB)      |
> > >      | 0x25800000 - 0xe0000000                                   |
> > >      +-----------------------------------------------------------+
> > >      | pixel stream addressable range (0 - 3.5 GB)               |
> > >      | 0x00000000 - 0xe0000000                                   |
> > >      +-----------------------------------------------------------+
> > Does this split apply to all generations of Venus? We support MSM8916,
> > for example. There has been work to enable MSM8974.
> 
> Yes, applicable for all VPUs

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
