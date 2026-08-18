Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76527FD74
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029599; cv=none; b=ftH8yIFzQqnVU5/hbvqTdNzlIoV20eP0IWpdWsyE+Nl+ePl5cNIFgUyDscmc0cJxz17wBYhDhRHXa3hcWufdKQAVilOPIkdfuBqd9isuKfwW98dy7nPdtVD9qrxSrS0VeCy4AXwV+4fmVhkXYkpd8r3AGlczfX7luawmmB4dA7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029599; c=relaxed/simple;
	bh=obBhAprkWc8Lae54dpHELQpspvmMcLErKyLD1OATbtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyXaEsslWG8Q0Wqb/sE4iAGAuNX9noAx/qCJuxDPMTrMGhvTnMhCDvDkCl53RDdTvFIgM3IDlLwM1/nrjcU0NBBH6+5nTxDX3/Yg10wxy7zABtypQaOkkZQ/mMOCD2Pzn70phDDeYM0SfrDEhZdzrqdcMEnBiCn+bPtRP65XxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GDDCmUuS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OdMfIT8q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GDDCmUuS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdMfIT8q"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLkZ403532245
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=04f+8KaxtOFE4Q3iMJJMcvw0
	fVceKVZsGRuuLQ+xrK8=; b=GDDCmUuSzEoo8h1Z7TR/mR7kVtApRfhITBzFogEK
	UeDXBUUrsvxEI/UYoWA97ohzdvIh4hyX8Oxxo/Oq3hKfLh8iFRc2mC8NQ/cdAuVc
	i2fmZi/UaZq0XepGCb1AAJhepPP8ozzFu1weoF7Af0397KswDXyJAYZrCfcJW++g
	9e1BzjaiHViHnRjWozrvl8rUAKHPbIgk88Yg1Utnob4PeNlXQ6axsTfN2wCmNETO
	TLOaUrgQ+jYatIkVoc0zQU0JAHQoLMyo9cYF28L5MroaamwZdAK6MHMffvYLMVNe
	L6lL9wjcaeaiNlWuLddjvVlKE9XMYGVl9Pf5UVHTNZYzFg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615jknn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 05:06:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e9a2b95b5so730572885a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787029596; x=1787634396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=04f+8KaxtOFE4Q3iMJJMcvw0fVceKVZsGRuuLQ+xrK8=;
        b=OdMfIT8qf28ADA2bEpqeb5NsBziIZdnsgdbtwEJcWW1bxZVr8wIlzpVTuI1+z+7cIg
         mvQEkOZsjAe7J0wVSGdpDdOwB5sozEPl1swXJpSc3vNvUZ1P7lJq1mtvjDLhnbpxwStj
         IAbdB6M9VGg2XJWHfaqL5kn0VmYvHqDh5AG5dVH3qzJzLjpkT9C3kCQjWtATST9Z6+vn
         Fk37HbJvNqo3jIfPHuu0PpP7osvIHdPXA1ZT+55CKul+P6s16hnbDlMR4ze1HuHGajga
         X4epdBKNLhUn7R2FQ07E/Mrbjjc9uF857r8sA2wHYksnmCGzEwUnmb3sWozjuTPfVtHm
         8cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787029596; x=1787634396;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=04f+8KaxtOFE4Q3iMJJMcvw0fVceKVZsGRuuLQ+xrK8=;
        b=DmKjoIzfoKVLvmZtp8i/S3g4h/10vLMn0bymcd2CabTfRtYxZPo4BT2JoG/0AIOod5
         uRtvABwF4GLFnbkEaoO0jAmJ0Y4t1y7cAll9dL1LqbJM62Y92wHyRSreUhvlZ9RzYNaq
         2wzduAOn3Zf5hR7mUwNquFzAMcd7f9L45c6nvkWxvoP3ItrkglotTUAUq+TjbWYLiL8p
         Pjn+92JGwTX36E8fXRoeUzLfUpBAH9hS/Vx5Z4mRIDybMgFMGo/SsaT25bBDqMRXatDw
         VhtJ6RTLklnCZhOck+lLXxa7fY2m9VLGb5M0Iqw8pqKe7dunf6ENWpy44w0ehTar4cuK
         j21A==
X-Forwarded-Encrypted: i=1; AHgh+RobdC70MuCJKIrRiJYPp8M+Yt1jJaSOt7j4bmIVTR/6fBQ85bBsZAXxlA7W1/mfp7mHi/e232k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywMhiaWBE4z3+LEdi77KAGeEHcz9MDo1HDF2bNBgjOgyz5cad
	hT788UsW89SS/b8KwQRB2EIqpD9QxU7i3ZqBY00kj9m0FhJRSrj/1yLhOyDec5+IlV9hYB8S93C
	tpxruiagvncN3LGbfCH0lS2yNHDyiO/Dq0ApUuC9hUnDhm4/8Q97EuFfD7KY=
X-Gm-Gg: AR+sD12NU0KT0hykwvEKp3uK8rvzKXBWPoSbqT691TT65OE+Ko8gThLhxE4OqzTl+DI
	ICWjTKXOeKwVBPmSWY286ZH4p5ylxnfkHrVRJLLOMU5QgNQOTeZyWgT45g7jmn7iM+m8y19SY63
	2QAGMYzpuq2RLPix+1LQk2vJaz4GQqqdINbOf6XAteCMMB6IfUiuigEDIAtShDOwR4PN27BEc4Y
	kZhjf9DKLuMc+exHWkKHS34bXzLKVlkNlyXWxXJVhbK0iSTDbkoH3KgwennJHeEoeMbeyDOhsTE
	PAsYy0J4N+epEOfP+th1jfv2DNM3NGZedBo/q7ofMB996Ub2V2UMRV5dF3GRVnaPbKCBbUvALva
	qZ9nidGxV2RbTwSMepH30RQU7yatgdSxSE3rL6ywbs1Vr2r5WKzQ90E0qNhdEeicdXQSfTZagA9
	rHUrExAakuHO24
X-Received: by 2002:a05:620a:4552:b0:936:e702:51a9 with SMTP id af79cd13be357-936e7025821mr1996399985a.36.1787029596127;
        Mon, 17 Aug 2026 22:06:36 -0700 (PDT)
X-Received: by 2002:a05:620a:4552:b0:936:e702:51a9 with SMTP id af79cd13be357-936e7025821mr1996395485a.36.1787029595710;
        Mon, 17 Aug 2026 22:06:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cf957f8sm892422e87.11.2026.08.17.22.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 22:06:34 -0700 (PDT)
Date: Tue, 18 Aug 2026 08:06:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, quic_akdwived@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix off-by-one error in
 regulator error cleanup
Message-ID: <jm3wxzzpwh7sut53xcs3im4gluwbv6h2mofmr6z2cx4xjasdwi@6pmmyqlfbs44>
References: <20260710194638.1502-1-saileshnandanavanam@gmail.com>
 <bc13f78b-287c-4832-b2f1-a68e7b35b57d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc13f78b-287c-4832-b2f1-a68e7b35b57d@oss.qualcomm.com>
X-Proofpoint-GUID: ZjUiwe_5O8iWm6H4dUTbxWaWunOaLnXq
X-Proofpoint-ORIG-GUID: ZjUiwe_5O8iWm6H4dUTbxWaWunOaLnXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX61Ia6ip43AVd
 ZLvVkOQkJbnMf5hXlBTEMyhltbcqPn81SkscPmTMFZ+OrQKQNxc2WXdSULuyfgInUA36Iirxg3f
 p9ZhBrvPZnqV8jDbS/10cOIBWGun9+ZoarlErx3zGSgEiC1Vc1dVrM4CY8qK6SoDZ5OZ+uwWHZE
 XeKTiix8+ul9n718bj0CDV+tsKIY4SaFLs2z5dQrPEWqwp9PZJx/h/Rcq8c+bO3Zuk00XPhLJ0a
 sR5biIIpWdPgz/riAwDpqreHBe/xoDLbmrPanHNLbP6+1s0YrURklY8Pj9M0x0YCfuROtMdXVjl
 UPHtpIo/pPkl9fKaFO7qMG04c6CNJxYRkVpj+kay4kE7szXCN/U6eh86bjjkvRoXs57rSIaKlvh
 qCgLn7Zo2H6GgH9iPRGjAUIXIR20ABFIU1nzqrNBfDdb8THdhBKk4kPMz7gwTAhjuLZMUg6D24B
 W9PqFxQqo3aJlBHomgA==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a83e85d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=BJTZDRrohyow2i3H338A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfXw6GgN064uOgf
 2DDbEYR4IMecg92auqbD6NIztUj2mUNlRQR7zHQS5S9qLb3r7Y/r6h/fPwqX/GajyABcNqKWywu
 JaPmvzMxqFDIY5AQRBE6/41my43MWPE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180036

On Fri, Jul 17, 2026 at 11:31:02AM +0200, Konrad Dybcio wrote:
> On 7/10/26 9:46 PM, Sailesh Nandanavanam wrote:
> > In q6v5_regulator_enable(), when any operation fails for regulator at
> > index 'i', the error cleanup path unconditionally calls
> > regulator_disable() starting from index 'i'. However, regulator 'i'
> > was never successfully enabled at this point, resulting in an
> > unbalanced disable.
> > 
> > There are three distinct failure points:
> > - regulator_set_voltage() failure: voltage was never set, load was
> > never set, regulator was never enabled.
> > - regulator_set_load() failure: voltage was set, but regulator was
> > never enabled.
> > - regulator_enable() failure: voltage and load were set, but
> > regulator was never enabled.
> > 
> > Fix this by introducing three separate error labels to handle each
> > failure point correctly. For the failing regulator at index 'i',
> > only reset the resources that were actually configured, without
> > calling regulator_disable(). Then roll back all previously enabled
> > regulators using 'i--' in the for loop initializer to skip the
> > never-enabled regulator.
> > 
> > Fixes: 19f902b53b47 ("remoteproc: qcom: Initialize and enable proxy and active regulators.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> > ---
> 
> [...]
> 
> > -err:
> > -	for (; i >= 0; i--) {
> > +err_enable:
> > +	if (regs[i].uA > 0)
> > +		regulator_set_load(regs[i].reg, 0);
> > +err_set_load:
> > +	if (regs[i].uV > 0)
> > +		regulator_set_voltage(regs[i].reg, 0, INT_MAX);
> 
> The first two labels only unwind a single regulator

It is expected, the rest are unwound in the loop.

> 
> Konrad

-- 
With best wishes
Dmitry
