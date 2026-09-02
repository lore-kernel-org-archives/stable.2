Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A023E25B
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339396; cv=none; b=sjws62JTkNN/iBbyD0lljR5SZssTWWb46Lc5igYKZPj39uQEU26hP7vYCU1DziFZYbZQR75wt+wC/2SnJZu3CFtZVTczzDVZKauwLLu3Vbk51u1N1+xYqiky2W6oWnEZp/KU1zJHhwfR65BWXZg5cwhd/UgSNynx/lcOftMAtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339396; c=relaxed/simple;
	bh=Hkd7WTFmIkuhSa1Lj9Ua/wTrqEfFcr8VgdL7VPdGPqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCG+F+ojnV95frcsfQdKSmsA8Dz6iEKK7DKob4AstJlONeJhyIp8OzCHrwpcbXLlx5zGUgfMV1PPbJ+uuPtSQKlIugKBdxmSyUEoagKDU2YKArs3mDyTlacHTlcg4prC7K8v1Dq6bXXnu8Vo615h8Y+PGJfK1HyA6QrNI6398QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fU4qlX3W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGMiDirk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fU4qlX3W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGMiDirk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VXXm758571
	for <stable@vger.kernel.org>; Wed, 2 Sep 2026 08:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/QOK9WvQe6jUV3BBjRVMVi73
	3JCIvhjtwq+YyPWtdNU=; b=fU4qlX3WW28/3oPqaAGLDrVjbf+XxneHLH91r71y
	Vv7W4MEcQAVA3MJoMlATX8IzXpfmdoPI34TckvUDFFL0A8wmv/wgnbUJxb7fKTkw
	QFkesvN9Zx8IKmmF0GoE+j0ZldC2Bn3ko171H74srFf0eG7VXWIvD0cQI5SQyOth
	S48R8SgNZFXZsPJOM1Sx5jhuKcMzS1wVe/Jv8SwAmHEJav9IJdgLSnNoO6PrrUIm
	c0PEmRnGTAVl1dHe8XhP8FCSWVzXkJOulrI2cpj6MhmYiK7S2FvcT/Teey5tCOZS
	3M1YOD2WQpT+xttxY5ydfSeUhLKIZhsACJVcJiJJwF6DSw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j31js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 02 Sep 2026 08:56:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso143626385a.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788339393; x=1788944193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QOK9WvQe6jUV3BBjRVMVi733JCIvhjtwq+YyPWtdNU=;
        b=FGMiDirkQWdC3nSIcmMYo8NYWunM9TEy8Fye977YYt7uA1Xn+7fEaYeAAw/pGhQSB8
         71RSkqzEl4mVpJxhApC7u5ojc1nkAQ7qRJDAwN+5CuyLPpykCxPhTPvGaBMlXrdCucpq
         k1/0aXD50D9KnmDs4kUM7ppN9l0Kf6F9VsKEdvfMl7i38IfV4s4r3QhP9KdE3ZoEndlR
         bfsuq+huIESX33nx1zLVT3TKa55oiqOqpNUjqvMJSYqLdczPi+ZHT1E7TbctGCL0ai0g
         +1eJUFNWWnspdvLV6/TC2OONTBmO/JGbUPFX47A6I0iEE1UTdsazpucZhR4Z8RzS6ZOC
         CGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788339393; x=1788944193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QOK9WvQe6jUV3BBjRVMVi733JCIvhjtwq+YyPWtdNU=;
        b=JXMLEflNkpCPfc5Qwr3+5ZZJ8h1mp0F9j0nzI0RydY5+t+FQMwYT9GR1byHgOu6YzD
         e5TgCgCS7IGfrXjecrwPwLbV2UE8Ni33+ulNssgZD602cgt9DOcmzRTLYQf6iR6PNXqJ
         9ubTaJIn8xAD9Y+HQedO9fGUkpZpMwHKCVp7aOEBJVQmzFvRNYJ2lypQWDGOuWDCuOQv
         x60y5xS+lCw72OFMNq97e3QMecCTvMjRDVGsVMa+JSoRGpk8i973+6vfdeM/kMEObRho
         T12DY9dYyvyhppB8uU+eZZmNJJW+w5AlBgeL9aw82aTk97wIwfJBnzgatmHhlCe6ZCCJ
         axaA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1PXS5TQ7o1Rkr4yRibNKdoTZCvGT9IHaKem46zr9JkubTePd0Wsy+WlwX0I2s1+sq65GrTlo=@vger.kernel.org
X-Gm-Message-State: AFuF++mfbDgfg1xKWzcINXX1esyZSMs1rbLEtY/bBaWQk/u/tobW9v23
	zwatAwp31nQ2UCWauqw9JNVfWalApRHzYkaB/Ex3vCAU4TvdV2qNoMgeTarS/y8FNqO8//WLEdq
	iW5m6TlSQWqSlNcJMVlcavkMCcK4mT72uGyiV9UDAPUFY2NVIYNP/z+QC0R8=
X-Gm-Gg: AR+sD13L6fYJEJJAq6k6nrZPopc07SFQwfHo7i4F7LnXzFbKt+NSX0s/sUpmlS4fXGm
	WX4c2Oi5C50/tqgimftyFF90yaYtxKKy3lt+iljj8EmCFjSmSV72Z4dSgOeVuuz3SAS9hpoBWqf
	9z7gdI2TEjdx+RpSVZYij8esopucuQsgJPIXhdswYHGp7+evuXcpRfgcz5Z6s2I8EM1lze9aMUc
	iK5408eKFu+kPCl52FQNUD5hbrlslCxvdo7VlUgG5JEHAw+akTL2kh6/RxcrrHaMQ7Jg8zeuGs8
	tTe6+bgZ+KzpcuHTn22vAI0mp5Drl1puwmFblQI1NQd3DxIlcpeEsY+8IWSdQtTKugAXErl+l27
	Z6qqkAw8GaaGnbeQ=
X-Received: by 2002:a05:620a:bca:b0:92e:535b:e08b with SMTP id af79cd13be357-93960f57dfdmr345502185a.33.1788339393039;
        Wed, 02 Sep 2026 01:56:33 -0700 (PDT)
X-Received: by 2002:a05:620a:bca:b0:92e:535b:e08b with SMTP id af79cd13be357-93960f57dfdmr345497285a.33.1788339392514;
        Wed, 02 Sep 2026 01:56:32 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm6241821f8f.14.2026.09.02.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:56:31 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:56:29 +0300
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
Subject: Re: [PATCH 3/5] usb: typec: mux: ps883x: refactor DP altmode
 handling and support TYPEC_DP_STATE_F
Message-ID: <yit5hlvrumamlkp653uleqczt534aabcgrw75q4utxpistsnfv@ctd4lu27fndm>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-ps883x-disable-usb4-v1-3-cec86d0b909e@oldschoolsolutions.biz>
X-Proofpoint-GUID: KSUgoeVWOn0_cE_vCP3o81G5tOIFvTcx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA3OCBTYWx0ZWRfX1wLTHLdx80R7
 s4etJpwbYNiPueHCvUlDGOQQSH9aYdINEtzCV81YAIEjh5HIfRDRcvq0QCTX2t0cOCc63WzuPH4
 sfpF1Lcd8W0ySURc7MRkp/ykFEeK2Hc=
X-Proofpoint-ORIG-GUID: KSUgoeVWOn0_cE_vCP3o81G5tOIFvTcx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA3OCBTYWx0ZWRfXzJnqsc9HyY7D
 hN4fuDSublGLvyd8ZzWnY1TjR5TPtR5KW/OnS48/ZojO0nhQA09Yri8Vuwfj3rdT3GravQdhQJN
 4vbxfShnCbXf4V8dpiws8QjWlnEJguLQlHspYb2Qy5KBfMvL1g8fHHdLsHGZgpBfAL8BxhXtd9/
 W35L/F84/EY2MUpGTu0dojkOceeFMjUq14bClAGM1LFCvlUa5jcf5YOXNu9o+9adA7XnAXlgHpG
 4g3GXyn0k0ElSIInpregLCJ7JHqJogxgyPZ7wgpQAw+eqBO3TNnwHEjJImL3OYiiQAq9R9W4I7T
 MIODrYmTBzc/T7jkkFFsMNt1YT0Wm/iWKuIrRRxpaIlLvYWToBFiwqPcyUAFGzysyqp35r4sAHa
 y3ul9Smr94n0B5wyRhInu+4JfbUqg10yPdJX6ICRXromgUMwcvT5AYPwpWARGrWMb5kBzOjXB3M
 xdufiHRovsfLtI79JAQ==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a97e4c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8 a=Xqxl2qIfDM1Vn1vrR_wA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020078

On 26-07-18 19:06:31, Jens Glathe via B4 Relay wrote:
> From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Several docks, including the Lenovo 40B0 and SSK SC220, still send the
> legacy TYPEC_DP_STATE_F mode request (deprecated since DisplayPort Alt
> Mode spec version 1.0b). Treat it as USB3 + DP altmode (same as
> TYPEC_DP_STATE_D) so that DP altmode works correctly, especially on
> the 40B0 in Type-C fallback mode.
> 
> Extract the state handling into ps883x_apply_dp_altmode() (modelled
> after qmp-combo-phy) for consistency.
> 
> Assisted-by: Grok(xAI):4.3
> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
