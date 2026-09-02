Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D93EE1C5
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339200; cv=none; b=omQb1jOWRO36kzAkNGikvO+CqflAnXW6mVU8/y29QYEPAf9+6zjh0OKH4M1sZPQrOPMYXa+lcqB+3dGatfFh9/I/x31SHco30RvmLFz+b2m0AGSbBNjvglLC7cG1nlH7EPQSmjiVHEARteIHEPFGtK9IC3+SUWQ2sxwu2ntJmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339200; c=relaxed/simple;
	bh=T1JG3em0p1paRb1Xu5kzfxwh6/d4EsI28h/XLBeD/J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhE8sRDf3cRPS+5o/r0IYInzzWOi6he2tEg1KZIlnqN9/TUzuU6dpMudc2bgo73BecuJy/WN6LN7NqKTI9MMqcfldPQwnotlD7tT3B4cwzCeaPFaLq/fqZ05V22lUJ2KHS57Ez6kTd+yUxAsd8fJGpxBIUm+4kVGrItJHJEtnCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hnyC6c4E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T4B+QZBh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hnyC6c4E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T4B+QZBh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826Vidd204988
	for <stable@vger.kernel.org>; Wed, 2 Sep 2026 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=K8a5Qeecw7yW/ZLAacnCV4Yc
	HDrzzzIXCU7cFMLwyag=; b=hnyC6c4EmJmACn6sqHDppoIb/MvNImIUa+OnwTpA
	2QSZVjFUOXWoZbcMasHDOjlc0t747iCBNhvGBmh7LyJGSZubNUxN2soncv1cI47f
	023VRpUgyylYNCodhl0Qcp/lUn+Gaq8OeeuTB1mvKfgs2UU/jlaeXNOWoE4PpRBV
	uFzjI5kjP+9/rthZw5C7Qi9M79Ku1InQaOWlQ4C3kOhU/CQx/t2qtXfr4Q3zql6H
	5c8/UoaFVg0h26hMGVjp7mg1a/z8HqF07zkR4oiZTiWdiAPp5xqqNctjBUsvPeEI
	VvaWruy6s32Cx/ceru52VsMhyUAkXdrB74+1OVC02xnC+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpbj2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:53:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so111080185a.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788339197; x=1788943997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8a5Qeecw7yW/ZLAacnCV4YcHDrzzzIXCU7cFMLwyag=;
        b=T4B+QZBh1xtZnJ0kKo86jk5G5NFXTdkM43gAY5wH/eqqpDJ8XevdJMfLOvZDcSSWDJ
         IeqRfXamXMMSCLxj477LEi0tU0qQUMIybpYRvgbXdXBdVgGU2GwkOkZCr5SqvU4g0uAL
         08/LueshIwkZvTh3fDVgRpwjImnVHDi+k1pu/dLfsUVdQ6b1pTp6nxTgg3tE4VmfXSbU
         BiUYSjUhWKu3Z3pFpqw3xLTBLOUEj7Amqo/UMghoqD+46iLOOpPB5rgbfBn8WZ9n1GIR
         11l3+ClIvlQHvwh4E9DMDAq4A5aRG+CFUylmJpKvIgKNA2zcE/RZMnEkuxwHr830+yTQ
         jKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339197; x=1788943997;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8a5Qeecw7yW/ZLAacnCV4YcHDrzzzIXCU7cFMLwyag=;
        b=kPyQRmzHCJbHxdOkGaA30qEYOgyfUQPL1/uBfjWDEFX7ZhGjPMF81RTgLVqqc8BvC4
         rAgU7V324y7zO3n2QBbmRzodrDNLGx3exPwqDSYp76ca4cKTK5zaOXQ2P4Rw1J2YtIus
         WB8oQLaePyaA/CG+aKnm4YYjRONl3G2Dzk1fMKiXY2VEdAisglYx1CPEd2xUBHbT08nC
         AN5yjYRQMYyDsLwt4ZYP+5KGoNCC4P20Z6MF5WO930QDu8TJ1W5zunZWGlM1cFIP9U6r
         p2+Wd5Ev2B298HA0hwyeKRW/O5WKhFlJ/yyKb7ohoXb80Ms59edgHBfG+aiSgzJFMydP
         D95g==
X-Forwarded-Encrypted: i=1; AHgh+Rp7eeo8ehOL2J3+fIIL0T+cAP4Rn9y+ndP2kPjq1GSwjeOs0W9VW3V2Ac8d/5HD3Sn3Owoz7lo=@vger.kernel.org
X-Gm-Message-State: AFuF++mavlhOUFcZHA1dPaY78eWBKSIF/JgpA+8nq8OjVgE/+NLZAoT6
	UKNoLnbxv7CLLeZAbWQfICwOJ+iq9VvX8Jp+L17HSL0MYA7iHyG5bkgag/8r5Dqjl85I6TNawOk
	ld+yGezz+uOIlYyGYB7+xLWjzJ44G6HsmhpzUENgpDX4w/Hy+W5evD66jHjs=
X-Gm-Gg: AR+sD119xTGM1bQmNaVtCFE9VaUvasOB3tMk1CP314hTnOK/UnXiK/rZBvTho2qpIkk
	14neC4utS+IABW0X9NpCgmRzH30dChtofwsirSSUsUYAjLBbN7mg2GYcgkXVz7sdoAixhpwkHYv
	Y/cozlXccOg0kOBtF2chViP9ysZo2tbc5PLSxbFEUS/faI76304f4j/aBusFkIC05arqm2cAX3x
	tMJHtw85Itdvpru38VUnwl/4focFkFPAm8U2P8zqJlNEOPTB6mVR8T1+5VVdhd5KoWmojKeVYWv
	6Lvu5OmXcI3H1R3RLsPHUVGJ4BNOR9Bqb1RAJfokt6nyyIBq+Ro7T4lXxa9RMMEVxrF2d92ERe6
	KcREsUWIua5QxpA==
X-Received: by 2002:a05:620a:2248:10b0:92e:e559:fe6b with SMTP id af79cd13be357-93960c9abbbmr285766985a.7.1788339196625;
        Wed, 02 Sep 2026 01:53:16 -0700 (PDT)
X-Received: by 2002:a05:620a:2248:10b0:92e:e559:fe6b with SMTP id af79cd13be357-93960c9abbbmr285764885a.7.1788339196097;
        Wed, 02 Sep 2026 01:53:16 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed3706sm4994717f8f.18.2026.09.02.01.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:53:14 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:53:13 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: jens.glathe@oldschoolsolutions.biz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
        "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 4/5] usb: typec: mux: ps883x: add a delay after writing
 config regs
Message-ID: <btc6lip75jn45tidah3ij3prn4y3thhcebuqnomyc77z7egika@kiwgg73impot>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-4-cec86d0b909e@oldschoolsolutions.biz>
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97e3fd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8 a=J1mlT1ugoPMniApVoKYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-GUID: ncSbNeCZgTQPT3dLGN82X5WVknYRng2Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3OCBTYWx0ZWRfXz3wzVZTuzPzb
 ZRWN9IIX2mVkmUcobz4msLzmK+R4/kSwDPI8/p6I+oC/FW1BMjH65WxrCqOo1AYN42kpA8vyBde
 Fl9lNQBx5ImkkEAMF7WRsrygfc4+ka0=
X-Proofpoint-ORIG-GUID: ncSbNeCZgTQPT3dLGN82X5WVknYRng2Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3OCBTYWx0ZWRfX2qTNZbdKVXUG
 CVKD2EYbqk7a1EvScjXgHspmiQ3I0FGc6ZPEh/tNR3ybKjde4CO3kLVKnUxcGLxSlLjmwV6CFpU
 Q3nfqoWNMTyvfP3DtPupx9AEf/5oBho61OoSWpj+i5AnowVnN3+sjYSp8Aw/O152tg3yLT01bBN
 Nq5FE+s6wEJlO7Fh/9ukkLLxskwP4yH2+sShlESPjllidv11DlPY2k8XFhZd9sml5zPTANhOS3y
 rxe09QCIiS0tFve3A8jmv+HBEU+KPbckZcpafR2Sl9kXHVC/05Wdmc5jj5y82rT2KN0UqUWRzZu
 f03ZfvLo/RSCCcDZeR8S5HZzQ+WO+6GcbxVT+hiUZo/y4IveYXfrc76wRKCpA6szi7I5MptRA66
 NMQt2wedg/vLizxOkgZ67FWLDWsnf7r/qyAZ7eJOG0VBV+SaT499uuP6NVePYQBtLeyeqD0h2vE
 p0fimCtlOn/3lnSFdmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020078

On 26-07-18 19:06:32, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> The config regs seem to need a few ms to propagate the changes through the
> system (like, PLLs). This improves the hotplug dp altmode success rate
> on the Lenovo 40B0 dock to 100%.
> 
> Tested with T14s G6 and 40B0 dock on the HDMI port with a type-c host cable.
> 
> Assisted-by: Gemini:3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
