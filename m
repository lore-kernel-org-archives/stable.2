Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD036A03F
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734814; cv=none; b=PWKcQgiBRAqjTHrQ6SbJisgMe8TffhUvDSCu6Yo4UE950TKG50a+kbHFWN8YlvyEfIYpNSlcyPIUAjthNO+la4hZcxM4iW5hxq6TuIbv+PSW/mjsp5b2A4WGt0aXBS3UINgiFUQtDZbu/eruPRfkmbBvtk5kJ/w9K37kKkAhduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734814; c=relaxed/simple;
	bh=JJiOlF1x3irKYvIJ1pNjsSbsiPWX/mrHGNUxUyjiIIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZHEDk8b3jixN7kwdZBGivXbWeZkornM1M8Xeui7EvqaGDYTC9PDjeLd6/SPR12eAo+cOzQH7/J1s1ixjc3ci8X089MGmIEdWvGZuoRplOthS8Jp978ODYF94d7BW4lwQu25cTY3XErpZM4Frl9mcmRoISpTmCb44mdHvhY7QFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BpL7Xe3N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IMi7xUBL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BpL7Xe3N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMi7xUBL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RqYK3210733
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2zhZU54kOx/DqOOM3ZV5yI/6
	ZCgYZzJQql12RB//sA8=; b=BpL7Xe3NYC7q9qFq/rMjTqwLQ74p6pJ5hox5Gq5A
	UKYEhPl3hcXhgT5MqJ7CBvp3Nn+Qh6bsl/gP9xxKcbtVur9InEgZVMEW6cLBJZbS
	HF5AYmU/KiWfwijIzMgqM+QVEWeMWTtfjSHSAbF7DobzdJJcd4AFm5VX94VjesgL
	vQoK7ka2aveLp1JO5kGErbxcLXUk91lQradb9KKoj8AczudDpcF7B4e+32wcp0IT
	C+7kgkv38jPNsJgL86npw7cV3UQhQsp5ctTXtfycK2THM1B+SJ4V6w5byV4PxAVW
	jDTmVPciJy0MT6XrwnZOHJfDk7qv6jJHYvWxTxdc+ynf7w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgrb2tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:00:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0408254aso22465141cf.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787734810; x=1788339610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zhZU54kOx/DqOOM3ZV5yI/6ZCgYZzJQql12RB//sA8=;
        b=IMi7xUBLovqMOW5nOUu3iSfQW9jUyWGWSEfXc2+F+Xa/zW4xEZmyr93gspCMXgwPP8
         v3GxAIUYQ7iYSix1mfEno19ORPB3lwqT9iLgA1wPBaB5FLKcCXaEnsP3zBXG/fBB5ztP
         31CpR3eJxABMkTxZC43bx6M8Iw+7mDtaeUuKFzdIoCvcnOrSJC2alIiXRF89WBuX6l8X
         0q3CM/H90iWnz1BTlm7pzcvgBN3A6gzhTH4hvXVDhXgmSNsAhwuZulnUVlyG+aDvbd2b
         UGywLywOtuIyCsukmLL5mXpuZjF4Lx8vS3PnzleamjHXYb3GZpOnB6X7Eedr8ZOObwVC
         YH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734810; x=1788339610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zhZU54kOx/DqOOM3ZV5yI/6ZCgYZzJQql12RB//sA8=;
        b=LqNiyn+ceG7m6QMuNx0GrxMWdd3fb7g1mCRqU16rRrUzr4IayeEWEC4vP13U+fs3FB
         nFl47vgzqLbOPW3HikJTbKNDzTe99L6UcWBwAEXUsQCa/N5xgXIIsx5EclZbhwb5QrkW
         b7pME0zv+rv9nLOFpeHceHy6sy1L/sBx3W0+3LMWtElrE09BvrEh9RhuQ3oC/mw0aY1g
         ILmNRmMcG0sizX90cvXB+uqQDkb2jmz4FQO+7U2O0OY5evNUFlHgtHjRftOWxF53W9Fy
         2fftBTeemUmQqGDDx1IWrtFyfz97Hq86AonC953NYbXscUM6YGuikf0fMlcKDAE1QebZ
         i5uQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2nJMF8tyOb54pFV4N9NbWJ9lleMat3mRFIR54ejUedkQSF5Rq0BNBaHFnQmdfEGS/w+h8O9s=@vger.kernel.org
X-Gm-Message-State: AFuF++nwV9VPeGdQxNTHpf5BA+eOIxE6QcCjyx61xdAeP4y89a5IkXIQ
	e2zShNffdUwBUKxeiwWkZD/pRElWkPDMunfMgwjwoZcP2DM6WshpWkAtr5lQ8wHsGxx/PMuhO/S
	WVZ7BecY04bDSgXcaee0csVhtFiAEcEpAnr6/vub/QfhWYABiN9bytbCrRIo=
X-Gm-Gg: AR+sD13YKyGchytOlLYWEvjePnCjHAsEZzhMsSiqB1VjNxCHgj+D3aejuXKC7wuZVjn
	CqUi+kgkhPHmEYM9jPcI2/nu3XGlNMqWoG7ib1hbh5mjaf1FIaHOxZu8AItV6bQGpFGo6VxWzWh
	0YktcVRJDHllIJ3fkzocrmvYbqy7A46EQ9lm5y/WcLx6zwZ7EN7fDSKOFphfT4unoU5KBVfVXSM
	MX2xlwSpgcclIOy0C5PJA9xSK6zzpYf1Vu40LSwYJh2T3JHpl3U7xlQxei/f/qAYB1S8HcRaEs8
	tAFXvTMeBIhbGqaWbrQc2gWuF8AQir2VHo4UVnUvNfMc/sf1KmZFVCYUcKBiYUQP8brSFYQSYYe
	T2E4p9j9o0Oxu
X-Received: by 2002:ac8:594b:0:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52e2ec51d8emr120518671cf.9.1787734810448;
        Wed, 26 Aug 2026 02:00:10 -0700 (PDT)
X-Received: by 2002:ac8:594b:0:b0:517:6fc2:4760 with SMTP id d75a77b69052e-52e2ec51d8emr120517771cf.9.1787734809757;
        Wed, 26 Aug 2026 02:00:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d1188sm3655807a12.7.2026.08.26.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:00:08 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:00:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] cpuidle: psci: Fix support for probe deferral by
 dropping the faux device
Message-ID: <irfhmz2ago3suc3o3klfrztq4nhvrbdykuyqsg6pynnkr3naaw@rgnnsjk7ftd4>
References: <20260826084533.38960-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826084533.38960-1-ulf.hansson@oss.qualcomm.com>
X-Proofpoint-GUID: ojccgtgKt7Df5mjOTnAN18NULXmYVsqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3MyBTYWx0ZWRfX6yAgAiDbLxr6
 UDgq+q/+/rS5lHc+cwYZdcodz93GBc6RpbtyasCeFmR+g/jdkRSARlEVhRA5V/sX7Kl9dvz5MW+
 wdCZRYFJEiX4/Fpp9xYCHzM3mQGqzrESrkFbSIOFjgk5LWZ6JYESCqg41Jy56EG1WPTzWyJLROw
 HAql1fUNqptqYEzJyYaEjI09j/haFFPKLq2gGFCywxjFuW0I5dknx6dq0G6J3lmb17EW/RQPttM
 pfkmE4Arw5jXAvjbbOmJFY3AqE+54A7n59a32xAwBb5XyeH4nGEs766oJ0bJEkEfDHk3y+F7UO/
 LIMUy3D77KKpxfU0yDdViTUhgvuQH7x9uJlzxzzibFm9QaL5/b4sLtj4dAVnXoQL1FjbKQwUNAZ
 3sLLnGs8OXWn8Y8gYdML3n3jTRE3p7xqPGSl10ENFWqYE6SzuZLrvX4GJ+dBqH2wmIsHVWQ30Ki
 6P+u4Edy70fPM0uAFWQ==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8eab1b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vx8LKYWbTLu2W_pKgo8A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ojccgtgKt7Df5mjOTnAN18NULXmYVsqp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3MyBTYWx0ZWRfXxtVw4J084Ep4
 nsT+RdvEUTZzlrSNTfqRZFX5OaBKd0EZQExVKg+gfnp6uXb1FitsHjkSVq4iBWABY9l3hictaHy
 MPqVe6o2QwmG+IfMEYa8M1pfDvWTMqg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260073

On 26-08-26 10:45:32, Ulf Hansson wrote:
> From: Ulf Hansson <ulfh@kernel.org>
> 
> At the conversion to the faux driver/device we broke the support for probe
> deferral. In hindsight, the move to the faux device seems questionable, as
> it simply makes the code more complicated and for no good reason.
> 
> To fix the support for the probe deferral let's therefore restore the old
> code and drop the faux device.
> 
> Fixes: af5376a77e87 ("cpuidle: psci: Transition to the faux device interface")
> Fixes: 5836ebeb4a2b ("cpuidle: psci: Avoid initializing faux device if no DT idle states are present")
> Fixes: 39cdf87a97fd ("cpuidle: psci: Fix uninitialized variable in dt_idle_state_present()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

LGTM.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
