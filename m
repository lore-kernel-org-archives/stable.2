Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFDE48095A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525562; cv=pass; b=A+4S5gKawRjr6vv4w+fKCqfbvq/0kgH5Yc4Q02dPb0HTFrDiR/rScOn4gIpAXXkym7saxPjV2Spb8txBiFsryN0R7R+gvmlIJaUSa2lYcrjKZHt5yhSyXuYfYBaKIj/3ThsdcTNDvKFN57TYiTxEQqshz8HvPjy1eohuqFpVVr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525562; c=relaxed/simple;
	bh=VUcBB0vOW6MkjtjLDRFaCy6FaOEhAXU/YjiYrkHQqRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/4dmyFOb1rzl2iNaRf5iPfpQOqMOedx0/+sK04IPtmHk6KRqo9ObAVdPrfZWur91OjEYP374Q9e9uEozyLYZbkNrnuWLhDdH16ts0zdAePxPf/NYtOKNwU8wO8Ueeb9HXpwTw4BTy8Q4pVoX5oVos7wlZMDbRgWmPsa9A3pBkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K0XJ4tXG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bs6ICLq1; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0XJ4tXG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bs6ICLq1"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684AImfn2096466
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 12:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G64/bNzWu0MVWc4hGb1QXCkMcnWhjiEk88kN6xUqbpE=; b=K0XJ4tXGEidqOsXZ
	b032oR5V1rqvQce0EcA9gAHTKUvpdP1vfUI2NvqJy9w/gP6XHjbadQgX9dOh+sH2
	U0udof4CD8CAWQvCHepl4wCV5X3ApQBfEkUitnWsclRsnOxoVB+V5GMzJ++6e2Re
	3mQUMOjyswcZbavDWSMq4x329nxo9nfG2K4bI5NTW7pUROmGarJHDQX5Yx6XXn7A
	hGQSNZhHyd7cmP+Qf4qbuxe1qskxzB/YsHswpsfOspQ1rDXbM/FcVJ62NSaVpeAJ
	azWw3CIV/wasFEdMSeRe759zAFUe/X8vfVoeVM2jXo/U5ZMfaNS//ACUzGzVRc9P
	rLTDZQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqsk63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 12:39:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52f52ccd459so15087131cf.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 05:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788525559; cv=none;
        d=google.com; s=arc-20260327;
        b=Ps/ek8Q4TVA0Zq/wXLycWFGz8mrdwFRwFoVZIEDe1bHfDuJjCZB2qDp5MaQd5JPPbi
         pzRd1xWnXLlddFo57FOL4OCviFa5AoTdZRWgBtmSN1/eqICMiXpXmu82vK/s7KkgLP6o
         KTgNR+EECwsm9NBNY7iNlpeAdZsas6YSl9PUkcOVGmviH7cSzVPyIWKVdfX/Hxl923vU
         XGGG5uGsu633vZTUH6wQeJ3l9iJImnZBskdsaGNnwu+mn09XpviDZ1N72Kh2m9cKnYj6
         Eh+5SE1gqNL6ozSdHKAh2G/yCvmBubcxDRtB741kEaFavBz6GdPzWVEz05T6qy6lNX0b
         4zWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G64/bNzWu0MVWc4hGb1QXCkMcnWhjiEk88kN6xUqbpE=;
        fh=FBdfWluXFPZByZLLNI+VaKZzmveumC9kjDOqoowg9U0=;
        b=WyKut+BpnkphnQvJT4RlCpwZkYOzJA2NnilY+MzBDIfB1nOYVWurwZG/x5lI7bBbnV
         6pAoAoiFwVdEzpJQUra+fsPdT6fMhF7Nrt5YBNz3KTOgQn1X7BKw8C4e9K5+N5KEuigD
         G8qzYuokGjRi1wukpHWNkPLBd3unepEWzZAW/WWVnwVsBtBegdWkRqpKl9KyaSZxF3a7
         +TjfdGi/Q9ykA76qPFpNvb6JjLnGuwwcwlk72mHkvXajckB6wSWxe8Us9BmrD+Fdcpdj
         f6/3Y9fzo+ThzboXLqkImpZIX/Pm7QSiOCQwRuTFBBHhPPJ/IKJ2BDINVUoaVPB8fxTR
         aoFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788525559; x=1789130359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G64/bNzWu0MVWc4hGb1QXCkMcnWhjiEk88kN6xUqbpE=;
        b=bs6ICLq1Rcpo6h+NJ2NAsIwXSG8ONm3ZBYr4slddu1Dj0FY7PzwsFcqVE2iNOtiu5Y
         nofWPOHx3vrWyr9cRT9lEh5CvPCbxV10P9AccSVmu8DUIOD32F2iHYxrrGB6SOodrhbl
         tUji8woJ0E+7WI2yWxeGSuVwEt75H/NoQAkweFbosavuNvk2nqtETGni8+/ORWTQLr9u
         fBDkIiWgUaiFOINw2U6xvfttuSJcxaq64oK111DpDa/GkZeJpiaRuCXFomuDFsB/jiEM
         1EszKH+jPwJjFXjbzrOw5uOYKqGTRC38BRtLGjCArL2e+E8Ny9SmHZzF/61y6/Icsu9E
         5jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525559; x=1789130359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G64/bNzWu0MVWc4hGb1QXCkMcnWhjiEk88kN6xUqbpE=;
        b=FZ9wtEQ6bjlpQtYC2Aju34Dq0uiJju9fyRBoaSd/ZwpdubyfKSjsWmEkajYz05t3JT
         f2dg8JPn7fdVMxZVXc3iH434ITMN7f3TJBUqw7YB8D5HZyPQDPCtTs8nCuTgG/SZT9IK
         nnVPnrZNDFcR5uzUMFZnotlkY9ex8D56iNky9E7+4esbKsGdvXq7bDee4y12dBhoIZ2Y
         gTffmOTSqUT97/R9KQxR6eGv1J6IM3dNMZydipRhqYEUCPWU8XghRupvB0nyFUp39aM3
         ZE4Fscx32Vm+CMod9eMhA1c1+dfbPx8qbw0ZcaLUwTBSt7bTxU/HJKj3lktKLPNQyREU
         px3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwvTo4nAsGEsV9HQUZmBbuIAqSCIvqstr+bWeNZxlWiaBC54Kw5uehX6Cz9ilgopKxF1JCi0P0=@vger.kernel.org
X-Gm-Message-State: AFuF++lvdfU01TvOHMRkfRIEKcGa7zjipQ2N8ebQ4gLxL+0EH+nnyOWe
	ydZ5D2XYB662MX+WTpesuNa8Al5RjnA2EGIGYwRy9OaZX+Z6STboJ+Na+CALAAnTXivgTeCXZI3
	EAdc1kIQdDqryMKmtb7RjG/WOl6B8Tkc+EA7YdQUTELzvUyCxqAuGXs7+3Sb0yDFPXzJqq4JqoC
	OjatdsqnU9a/mthuNfqegWko3dw+kS2lScTw==
X-Gm-Gg: AYBFou00YuKN28hVivD520U/9Sx9t8N3d3uwRnjEUT+0HzGpjFsYTI3Af7NVdEa/l7I
	1ZXnms8ypCN4nSkC7fFaJlmkh9FQFirYiW1tl1CPANE0r7QF8HMGoU6TkIOJAZ1yhj+APKbbmx7
	Xxe8lQGD3ryKnMH8xGZqvxus0sKe+/iImDe7+2yDP+hv1mSCoL3assW5cvMJbMdPrKbRwTeW/Jr
	l1aj0iBalgFCtqBbwWYWDJ5rsuib4DP8nk24SfNn2SDk8P4xhIm08Fu/KG0WE5pDTkpUlyW+y/m
X-Received: by 2002:a05:622a:286:b0:51c:1fd1:e755 with SMTP id d75a77b69052e-530549fd6c2mr61916371cf.36.1788525558807;
        Fri, 04 Sep 2026 05:39:18 -0700 (PDT)
X-Received: by 2002:a05:622a:286:b0:51c:1fd1:e755 with SMTP id
 d75a77b69052e-530549fd6c2mr61915361cf.36.1788525558050; Fri, 04 Sep 2026
 05:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-0-01ef1eced075@linaro.org>
 <20260903-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v14-1-01ef1eced075@linaro.org>
 <2aXo5I_5YqQ6uikqbIOWs7L__EwJV2oTs24Jqa-YRqGIU2FOT1O4bixGBbTzbaiBuENyW0XkWbqAJJQnxgSnWQ==@protonmail.internalid>
 <CAFEp6-2nWfjF18R9pw0xFt92GcPORKKa+ix8czQ=m512TYuP8Q@mail.gmail.com> <51b3dd1a-5595-4538-b792-a679b6813a6f@kernel.org>
In-Reply-To: <51b3dd1a-5595-4538-b792-a679b6813a6f@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 14:39:04 +0200
X-Gm-Features: AcwNN1Xi0ZnbHcNu1xFGVtcHdZiZF7hrQekcNJq1YSDgANQhTlSn5NmxIbSBScw
Message-ID: <CAFEp6-2_XTMnxqcoNFwu=BfWki2U7U=iuQL8n6QcR-CZSMsX-Q@mail.gmail.com>
Subject: Re: [PATCH v14 1/4] phy: core: Fix use-after-free in phy_get paths
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felipe Balbi <balbi@ti.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExNCBTYWx0ZWRfX62vCRh0TgUe1
 tfXx5kjCoCxmKcenz97PJOsG37whtG50tFAYPRxeW+TuJRhlZKpWg1J7QexEDy+du+J90NSSYX4
 OgMTWTWrCoCXTgkXYKkHWd1P8fP9wYc=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9abbf7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=4B6qI-Qak-9ifnyKK3wA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExNCBTYWx0ZWRfX08IjTygDdQnr
 BC50lawlJDByl28GGW/QgJjHxBKlaMTJ0jkhNw8GkEPnqxmSnQYvFFyqArSd8L2vB08s5FFmND2
 LLqJLDqMthesT/5MqcfZnoej9cRKlxg1urkg1lTwJIGJAJfUyYBYCnSblN/BwEZhRPl6wi3lvzE
 xm2rakzXftkLBE3EItxtAy7wF0OPl3v9L3JAtF0MBsZGqDcq8llsy2S3pDLQHocAM6GbtJfH2rm
 VkTdHTUUQOpX7teUMQ+xI/fBfhsgD1knpfwUTRuPCRnBhJba+4l2bP0OjE5oImNDHgPa82qLHfh
 DxV+TZRZeQ9cSBJxZVgL5beKhX9xvrHBQWnWp7/C8++gIBBNfgEq4hFzepQPvV3NHNrz6e4ob7Q
 j6rXEryJnD5BOdI1r9dY6Yf4JD57qKerw6JUctRo5J3NeSQWQ+FOXaB8nA0HxarvqLx/XMXg8lK
 ev/CwwIL2zcJ4seyYBA==
X-Proofpoint-ORIG-GUID: 0EEEJB3YgsHM5N3tIptHkivfDK5Mv3FG
X-Proofpoint-GUID: 0EEEJB3YgsHM5N3tIptHkivfDK5Mv3FG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040114

On Fri, Sep 4, 2026 at 11:41=E2=80=AFAM Bryan O'Donoghue <bod@kernel.org> w=
rote:
>
> On 04/09/2026 08:45, Loic Poulain wrote:
> >> -       mutex_lock(&phy_provider_mutex);
> > Then, now we're moving the responsibility to the callers, maybe we shou=
ld have:
> >      lockdep_assert_held(&phy_provider_mutex)
>
> An LLM suggested the same thing to me but, I thought the resulting patch
> "looked messy".
>
> Do you want it added, its only three additional callsites.

It's only a minor suggestion, but if you end up submitting a new
version, it might be worth including.

I would also probably use a scoped/guarded locking pattern for the
mutex, as it tends to simplify the error paths. That said, it's mostly
a matter of personal preference, and some maintainers prefer explicit
lock/unlock pairs for clarity.

Regards,
Loic
