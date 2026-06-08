Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDC53E3D8F
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943490; cv=none; b=ANjgDlIuQPT6xzdi3fPTqmxPleBN1+i9pe4EwwpQGVbWQd53qCo37kpe0ejkYA/edJL4XKezp9mQOWAe1+RPb8WsmNOd3ashdhtSyt+DLruIEx0GU/GTY5YflRt7WlpBo50VG6TUhNT3KIPfQzdfFi2euluWPAKYrXbh2UM0FB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943490; c=relaxed/simple;
	bh=xNum+tWC2aMU452Q4bpTFPsuhLzqpmZUmqcPe0OPSiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn4nZ8ujPkgjMgw4Nt1iUiUIwrQd4A1faTM6G4a5GgokFwZD/ljGNHzRQkRI6jJlhqkx0peMFZeOR6DQDiuTqY5bdz4FepeyMdclq3OSRXBxHjUDWRL0vXvfKoJSrneMfV0AFyuN0Y4Im1a/X8qG14eqUQ+o4SWUT9X+gHlTwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXENHefx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jgwhjVro; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXENHefx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jgwhjVro"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFa5N3596279
	for <stable@vger.kernel.org>; Mon, 8 Jun 2026 18:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yL3biVRnQzmQP3JTE+TrfcqR
	LaExr7Z+40hJ1bAFkXo=; b=oXENHefxvYDkgrLThJUdpDu9IwUyLKB+g0fX3dIn
	mzPq3pEyVQI0iiKJrMhVVJW72aT4lesVI8JrV93dHXmYjDhipX8BedPGunhk0gyf
	WwJqNiGm1pCttLFX2ZMLKISj6gOJjM0S7gxSgMAXh/rXsHZl5iyt7Gu7SFcg3aQv
	c5POOIOBucgzQo1AzWFdzbES3EKcrEqE/OgWdr0SixCGP1HvlVdZQOBa6qBff0nC
	5p0uOkuznRgW62+mo+FnT2DJBQW/1PMp7r06usbQcJCayDm/Vg1RR3mgB/+NG0Pn
	ooXbpngwfEOoAPimclKCu+YdnRASfyIU4L7nNkp+hFzESw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaja561-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 08 Jun 2026 18:31:28 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4867831a9a8so5838654b6e.3
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780943488; x=1781548288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yL3biVRnQzmQP3JTE+TrfcqRLaExr7Z+40hJ1bAFkXo=;
        b=jgwhjVrofuArGjI+m9nTmJ788IGRP9r7RSpVrpfBvnaOShs0+2eV75ODMthq+qGzcG
         eP4PRo96yXTd2KmP5/LKvMWCakYPOhMslID6N0vBuosuJZUPrEXKrJ6x+q1mgR9BRMuy
         ejS6+pt8ejcBv25YAR+Ar690Ak9yeR4hTzwvJabTNqV0CsBoFjZuJBRzfGwVjRm8vqY8
         G2SzPrXoAmJJvNzjIE4Aqb0ZUNmVMR62nNzlMWZHe4H7HDg/JX3muJIr2SLB1JjqeiMx
         JJG8Qy4s/pnMMhxy1xf1Lh2ufJIJRffIfU4hrdJofM2GHHyYrflpFyqCEEplYaUHgn0m
         eihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943488; x=1781548288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL3biVRnQzmQP3JTE+TrfcqRLaExr7Z+40hJ1bAFkXo=;
        b=CFNPkHHCCRfB5e912/oBYI2Y0LjTjGde7rrxn4bcxRUNiKH1q4tQk6xRCCC2GiaOVB
         FV/T9puMz9biU22/I7n2/DzE6rMSzAyKP6XuxmptW9Sa4zpegYx3WGpvgLKDtw7UwQDH
         R4DO5Km89qrm6UUjtYitW58amG1uZ1DE+wGm/BN+WbPaliN05SC0kXxvJZTLox041yiR
         PE5GQYExL6SRL1BZtGOQFQgRPqkgqUC+CgcZf5jc2TBU/3Nbp8f24ZGm9XnUIZ/f/k1O
         qNl+394Vp+hkic1QXCo3m4kreJtmnHE+Lch/HyvHlNiq3JHXeKuvXzN1t/WckAUlHe3j
         I7CA==
X-Forwarded-Encrypted: i=1; AFNElJ9d32VInsXrFa5TfeqVvESvU169AxMX3FDoKUfLLSAXsIfE32dfizXY11b9t2br29sIw+U+6u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpzq6+bmIDe5mriyzUrY+GzCDxM/yA7Ne+SF2675t2f/T4v7VE
	/hFunw+tAamJ+BBQYZEbzkGiX+mvJJb72y2UFmtyEhES5haSTLplKNM4j8myAdl2stjf8R0D1SV
	PqNvFASJQpzBZ5KVhF0tec23s/av0h7JRAYQxMge6rcEO2drY9ijzvc1iEWOevBTIPCv6bw==
X-Gm-Gg: Acq92OGy4cJ7HxUFzwuF2ZNNunjRiOyUfJr4rVYnzINWWT4a/tA20nRVey7v0zaCX/Y
	fk/gloMQmCfJ1J24yWIk5uwLLtUSjiJ4Rn0DNEtIMhZ4SC1BrYfMUzZp32Oe/T9lctaUya8DRFW
	IhbdlggNJLIC7vno2Lk/N2b5/IbbPHi23CL05lU+eDxpQ8qQUSl2OF9CkrgeA1xRx3m2KySv+Ke
	xFz9svzjwhj1sCqjkatbvpm/4kaflcRDyhhoQ6o7sbLoxabRkdZFYTyotWJMcKMmIJv9k7dFszX
	3p0QuFuMiY+Am44MeRB+trwB6bOkK7O3EQyQi1vxGiQSwIlqyya7KKAuseM0fe5K6PAaiO6H6i2
	6/XH1xZ1jFptvXnOV516PN+32kiRQcXC48qgDr4uT9510z2eEaKcRNCxbrYsNWSV6d+N9hnXvVE
	UYsrw+fkroS6WdAP1CW7jtP1no/QSo3VsbxdAhsSkizxfZ/w==
X-Received: by 2002:a05:6808:2223:b0:486:89d8:6d50 with SMTP id 5614622812f47-4868dddaf14mr8480551b6e.4.1780943487698;
        Mon, 08 Jun 2026 11:31:27 -0700 (PDT)
X-Received: by 2002:a05:6808:2223:b0:486:89d8:6d50 with SMTP id 5614622812f47-4868dddaf14mr8480525b6e.4.1780943487271;
        Mon, 08 Jun 2026 11:31:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ab56sm4037399e87.44.2026.06.08.11.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:31:26 -0700 (PDT)
Date: Mon, 8 Jun 2026 21:31:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] crypto: qcom-rng - Remove crypto_rng interface
Message-ID: <5u2hogvqf273xuapkdeygsoqsncfhbexzcpwgsbddhgg4j7wmm@2t6gnzakxzi7>
References: <20260608175848.2045229-1-ebiggers@kernel.org>
 <20260608175848.2045229-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608175848.2045229-4-ebiggers@kernel.org>
X-Proofpoint-GUID: ieLyJPLwP83arAXa82Hvvli1AN1TR7zC
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a270a80 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GGXhDfIuiivKoIxXIwgA:9 a=CjuIK1q_8ugA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: ieLyJPLwP83arAXa82Hvvli1AN1TR7zC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3MyBTYWx0ZWRfX4Eq5HJOBO+LM
 lGr276X2Dm8MgyVO0u3s/jnZX8HlkkgNAoDaglRMAJmj/ta7+vAw9NzN4JHU8YqR36YjCXYxeFR
 loZ+OyeY/Bg95G3EwzlIxC8opQVoo45ke/wEmIpIc87sXfRL5ndkYYzIoKXVu0HeS7hzEYVHTET
 K+u26fuLcVQNSTqseJtzPYPohY3+Kj1nEH6qfpvTSTyJjEUB9admUsT7U1L/B2Ebd4Gf219BgYe
 qpdWUJWZ3U3muIrj+OlD8LJQ3TniyY6+0Wax9xkgtPXxkRyj/+HP40yYU/O830yfoc26wcqQZg0
 ZWHisOEDJgWx64TW0qtqiBKjDl2qHJ9VIKJ0RIgY1bznMYGrLfv1fsRU8yJ2UUUSx6yPk3vw7Kw
 r7totNJcz+a3ppJ/Z28VSNmOZQLrKQRABnUEDUjWNM8vSSTdIc1AS8KuaZc+nY0gtkelWhJHCAe
 xGBU/VhkUZFTTudKxLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080173

On Mon, Jun 08, 2026 at 05:58:47PM +0000, Eric Biggers wrote:
> qcom-rng.c exposes the same hardware through two completely separate
> interfaces, crypto_rng and hwrng.  However, the implementation of this
> is buggy because it permits generation operations from these interfaces
> to run concurrently with each other, accessing the same registers.  That
> is, qcom_rng_generate() synchronizes with itself but not with
> qcom_hwrng_read().  This results in potential repetition of output from
> the RNG, output of non-random values, etc.
> 
> Fortunately, there's actually no point in hardware RNG drivers
> implementing the crypto_rng interface.  It's not actually used by
> anything besides the "rng" algorithm type of AF_ALG, which in turn is
> not actually used in practice.  Other crypto_rng hardware drivers are
> likewise being phased out, leaving just the hwrng support.
> 
> Thus, remove it to simplify the code and avoid conflict (and confusion)
> with the hwrng interface which is the one that actually matters.
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/Kconfig    |   1 -
>  drivers/crypto/qcom-rng.c | 158 +++++---------------------------------
>  2 files changed, 19 insertions(+), 140 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
