Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C938655B
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732550; cv=none; b=fUOuM9Q8PUF3b9VnttSWs1bqs2n66GUk37SQcaKX922G7rH4AMP4c2xGF+UauIwIrUZ0l0UHV54QUVJzmOKZQ41jcpYUmIve/ISZCKBjygLicDrmb0vmdofBCWBpVfO9l05RtUHSx3Vz1BtOmCthztdU1Sd3tPnof8uivYMjTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732550; c=relaxed/simple;
	bh=WQOz/FpowsZ32XqFFETVouryEa1F/0R8k5pJuBp1ezI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJuVrSEDH5O0E3tRWhqcU8AOjh2iX3GVpAYu09sWgM2XpPMQbeoECqhYtZIVE67jMKFUetiPF+LiK/oFdYGOy0A/1nC6LC1MbMRFn0jQGsXH2oi7fFeBpQbQNakycAztKEyOGCrJzBA45r6V14sRK7dsimD7sHRHF9Wv9sG1q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9ted4yr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEutyWXy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9ted4yr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEutyWXy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HIeQNa3588815
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IlNdZzz0mcq8uXSZYVq5G4To
	YroDK4RMx4Q0MAkPfKU=; b=a9ted4yrg3hbWO0fe20SEY24yFMeL8Rg4RkSB1uW
	shllfmmXZYlUeD1weroB24Lq359SQIx1T7N0P9h06kbBnOitnxilm5gU+ADpu+Ok
	/1I9SWnrJoCwIsG7WiahnMdUFbB0awcON2M9qM7S8mnzsBjA4ztNr/B1CpVk6o1l
	jGxSryWchma4Tj1kLYUdWYNuPH1D3++IcT9bazDUsD09lhIdGAxy9vxp4F+9GNv6
	o1p7gJrfr+FxW52cdoO05BjKfumWM6iyMufD0L+wqa8l9uQ5zliY+DaqEkNgHDbK
	VapWZKAUhPjxzPtUNnfpOoGiI0KLexry0obhjABJf0WZRw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kgmgn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:42:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91578c374easo84801885a.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781732547; x=1782337347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlNdZzz0mcq8uXSZYVq5G4ToYroDK4RMx4Q0MAkPfKU=;
        b=bEutyWXy+oa70uZ2Cn7LeQl8RwmnNiz5jlWU1okekXjSdrCeu6cEImXg4w8YsPyWnr
         KHDEQ+cG4M6M/oTeSvXZ8fgFdR7BZ8OaxXhRI6qyy3lrvUB5pFP3JEsNljTl069dHH65
         UiegZ8nsq6wyQJtrtc7ec9k7PkiS9Am7g+aBEHftuRCokAewomJOmJ6wfZuJF1gmDqZX
         CkCv4vEEBEv1GDrPE/WKNcncNZZx6RWvIJs+u+Yu1/NCoo5Xrk6pSvnnfGA2cnqQW2rt
         FkiwpJkJJciIWwmZH72tBYtu+2D/d8VdwUZDhiiulHmVR3z/uSg5ZacOm3n7jQC+mihC
         kThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781732547; x=1782337347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlNdZzz0mcq8uXSZYVq5G4ToYroDK4RMx4Q0MAkPfKU=;
        b=iXiRw2stTvS1JVmS5oSp1xOrfb+ZgH7ke96CtPlUJjYjdArBzhW1OUopE8TGz6IWNp
         kCcwk4Kppw+46QlPBiUhguMeQVwv/s0ZqUHUBdbDIeIXPyl9A3G5d9s7snrKu9eYif9W
         IXrXQret2fEMKSkKhbaSNz66SM3iVd4/PxKFqG7bWzX5aNBmKzWZubCJetyDMQmCmn63
         w/QgujZEI0MbwUaqLwrAWHmQERzhV1TtQ16SdsJaQJbMeF7FtUq6jyKUFZ5YA7ovfBQx
         ITURkznHn4RQowScN7xv9gBBmL+K8UlIkh9Xx0XdsVNZjLeupcEDKJ5+kki8i6A5pa+C
         1lMA==
X-Forwarded-Encrypted: i=1; AFNElJ/Wf2Oc6MueAcKrJEb14K877cPJx4+Vzo3WLN4bdmSTA/mDQ3RWBOd39hvjSQ6pIts5MOM1udc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1rc4jHer8pRsfdQU5YKK5zcfcgVq5MbxC9VJG5lIqZA8UJxch
	sdo/BuzboIfH4O7VNmmeWn2iR0rSrYmK9VeEaPc/nGa3MdmaoBuYA/UAq0mWKaE2dEQjdNditJZ
	XG8U6n+6RKGKWvbDY3wyxs+MXr+rpmkXpl04LHUiIppOwUTlodUfEOFRutvU=
X-Gm-Gg: Acq92OGKrM90MpbRt1W9HP5oJCWxzNgLPJ/r+s/5UHf/l44zFOUelVQ5dBqSSSP/JzV
	sSDx8S3EAga+iA4yyOYOlcBwTleKlmKk6Vc8oydeaZWN9vc84vHf6vFWHgWWXccvEqegRWQxXew
	VOxPeW1QeFCVWcnxKopTn4e2K3wG4ULyR3TpG8cWVuMe5z80yegOr8+n1ym2/avHqE//HnCKxWO
	l7tZEn61oXtNvadZqUy3BeEeS3K/ZsRblmjmY1YQmaf0vO9c2l3yqIDPSLWx5160/d2oV6gpM5J
	ZNhnRo4y6BMC6b2nlLDwKcFvzco5/78RmrH/bqCLrJRjaVqgy60I1ojAH790LK4M5sOseImhtqB
	VVMVsj5wyxrTprTNwYcHBTPnrjyRRq4TJEugiQ8MG5D8tfRsrAN/yi+c9iU+8GbYFIPrbvQqA6O
	ruWkwh6fp/tnfNdRpxc3Ldp7GM
X-Received: by 2002:a05:620a:d8b:b0:916:180d:5791 with SMTP id af79cd13be357-91f25ca5afemr164289385a.2.1781732547653;
        Wed, 17 Jun 2026 14:42:27 -0700 (PDT)
X-Received: by 2002:a05:620a:d8b:b0:916:180d:5791 with SMTP id af79cd13be357-91f25ca5afemr164284785a.2.1781732547216;
        Wed, 17 Jun 2026 14:42:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16a02asm4737924e87.21.2026.06.17.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:42:24 -0700 (PDT)
Date: Thu, 18 Jun 2026 00:42:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/3] regulator: qcom-refgen: correct the regulator
 type to CURRENT
Message-ID: <y5azvga2u2hyauqrspl7zzpmblex7hwdku7l3a5gumz6o2w4w4@u7ea7dfhqsb4>
References: <20260617-ipq9650_refgen-v4-0-c505ea6c6661@oss.qualcomm.com>
 <20260617-ipq9650_refgen-v4-1-c505ea6c6661@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-ipq9650_refgen-v4-1-c505ea6c6661@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDIwNiBTYWx0ZWRfX7EUBIjBBYIZQ
 pkxiN3vk7qnjwOoFxdOda9xDc3QpSR6nOnc162PXgULDnCWdF+OUWaggD4W8ps2J3MUlLR0poBf
 H4bQ6iK7nh7spk7xJ56gF3ImeSQAbGSTjToKSukc/uUj1CrLz3QXMv9rJpKgreb8G3B3a1w3gVB
 zMq4fWgmdzr8+Znbnstt/bhb2JC964HX4vY0KF95WsUDLR75HIefcarf8u82M7Zs41OdBqJTPpI
 swShuXq8Mr6JH7mOcK2v28CZk3ZJjifuZAogCswVIpUwGsMN7Gd7f10MASTovp+L7hzbseX7+cx
 9mUMOvqFFpGBKtVL6+W2xWQfYEroHWpCrogf4W/q0KrrQTWjLr2FblfyLoL1UZCl9RAVaF+rwEU
 HJf7cJXnbSAfUafXoWkzmiUMikqYdlBY8gj58SSZpPkXv20DFoFh3oG0Zvd7QhV1CTW9RpFlb0r
 0tLocsfWH2aZ75QeRBw==
X-Proofpoint-GUID: Fx9HDuN_syCe2en5M0Np6KP7q9mus693
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a3314c4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tQRUmb5bEndE2dhV-mAA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: Fx9HDuN_syCe2en5M0Np6KP7q9mus693
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDIwNiBTYWx0ZWRfX17lsoCHuKwml
 TVJwFvxR0E0lQGIYUxw7doXwifF0CWI8Is4JQ3vvXFwRXeQJzRMmxu72LLx7X2cq4RiIaOYlYdJ
 ep1gXVEjIKx78oF2ON0kKIIv+/2sm/8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170206

On Wed, Jun 17, 2026 at 11:08:43PM +0530, Kathiravan Thirumoorthy wrote:
> As per the REFGEN IP team, this block supplies the reference current to
> the PHYs in the SoC. So, correct the regulator type to REGULATOR_CURRENT
> to match with the HW behavior.
> 
> Fixes: 7cbfbe237960 ("regulator: Introduce Qualcomm REFGEN regulator driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/regulator/qcom-refgen-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
