Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787736;
	b=W5OX/YE0etLpKkzYIcGNLLv5OCkO/05JXfClRnD+cOm70QjqEp7ux+F5b4Q5YjX/idwL
	 blEkSz/crKS3SHLW8gVIDuJcsYTu+DLkLqGX5s8GcnD9UoVzczXfxbBBBVkgQFFJUDEiM
	 kndEpg8xF7qq3DTCRJurBhXR3pZDHiC4FkEep6YhxccePduJZQMhkL6Gp3zyai1IcPPmd
	 zuMU/QRr3mDoKjmrUtR1g3pql6C/6DTzCRH1Y/5JwGGCf0m2UMQo/M718fn+4nuf291qy
	 FafFfaNfawJhqTChwV3/fRIE59gPGTK35pmFIp15jRZgjvlBXdRoYdiz31THIWWkKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787736;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+xGIJ8DGOyu2gbCTh1FSGJE7fE4QKip4VB8iOYWUKQI=;
	b=N9eh8Sj36ynUF4OoRBFxjuZJ6aBZbpEgzZ2qi9syi4z1re0rlPNiLno871d0CF3DZ88p
	 Qwer46QZKiImuQr0c7pd2yk0tVXB5mgCGLsgavn/5ky6+eMlMQ/nfWOECPptCyhIvrxSv
	 jTyAewGGYQ4qObLY31iO6pIEBzcSW06fZdjjBFAGcOvqrdNsFAVF638yULN6ay9GPiH/A
	 jPG97sYqcGkQ7f3bM1und4x1WP13Y7J81BvykQ5zmHfpvt6i5leig/OxF3Q8AEs9AaF0R
	 aeONOA5RAEQoLaV8dhcWnDVjWFqfepuNPm0hr6IRkegyaVZmqEEwtEkY8Oph347eUsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fCIsiBj1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gRJmt72H;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC575606A32D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC575606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fCIsiBj1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gRJmt72H
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARChA3u2205041
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+xGIJ8DGOyu2gbCTh1FSGJE7fE4QKip4VB8iOYWUKQI=; b=fCIsiBj1dAFnx17q
	0e8g4pAsQFToDktVqgqG28sY150BG7zfC1/mAMWa/OfpcVsCKi8GWH4/UiNKE4R4
	d21XuPqo1OsnKNtfDnX4vhl+IqnMtPFHgTg5sRH/wwL3GHV6CVOJH3GDgFoU/zDs
	4KSuRCxK0OVGXPnkNjmVkZHL+t3fdtROE0B/WuenYTUKWfi31CDAF7bi3hmfHNkh
	cPr6dzwAo353SC+yxCt9P5XG/X1oVC9/RLvLdkFnaeuczxrKXz6RqbIZ5H6tNpqn
	A9q/GNLUdN4WWgum/VLcYT3GZKWxIsiqjPyEtGk/6/dOIqEonFIgEbYCeCCBES0g
	KsR2Ug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4huamc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:55:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38355b03cb8so7392460eec.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 05:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795787734; x=1796392534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xGIJ8DGOyu2gbCTh1FSGJE7fE4QKip4VB8iOYWUKQI=;
        b=gRJmt72HW4N3xXsOyjnqc4tAn0wZKKReRN9M2WZ8acOtS/+cwoy+QHx4NFOgluGCkd
         agov2uhR1sOfmn3mdV6xThnQWZ4WC/qx0sgmHCWSf1u6x+1SKC9bTffoiAVRxbMjDC/N
         6MGN59hW3B+g5VBV9C0FInIgfASsEp4gcLjCrDSOk19Xxm+sUyOAMPHmYxBqq3eDTvFA
         f6T/soT6t1JWW6a5aOwzwBzBIMF1gF9sRgkgTroqCNA/N9hYQZ5lOpUFyjXqJPiH+1Sp
         O7nGgpDVEx+5accm/PpN0XDm1IGfFwXJJWYCwOwdgF3SQxIJvN5dThDnfdMxyNBYTwf9
         avSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795787734; x=1796392534;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xGIJ8DGOyu2gbCTh1FSGJE7fE4QKip4VB8iOYWUKQI=;
        b=yHBTtC+2mIxbEFkzk8jw+RrrFiO+84unmtiNzOnLPnh7s70sjMR2GDi2wrQMU1qrhw
         S4xi7mjxJPYNcu5ndeZMIKOTmzwZHO8QBDvslGUkDQqQCrgt47Oxna/CPVG0mbJ2D8fw
         P6L2goIRSYZDLzKej7jzIkb9syJMHQkuofQZTHi2lmd+fDERwHqzT4KdAHUStd81dqAh
         DftOJbmhmYIBQnvdiB9+K7kdJj3o/aXGJdxRaKuMPuWXPnjT5chFPxclqVmpIHyMjtQd
         spQj9bhgj9+7mjhrG4ohDPiMAyPFE84kY+6VgGQqSDQhzCBrLDt+hzrlyKoNKNdIOJq9
         BmcA==
X-Forwarded-Encrypted: i=1; AL+hErFa6tJtpp4fxH0tPvi5Bwwz0/ES438Wg7mBl9Ot/+H3oG8GCzUdahJQHhn2MFhvFKL/xh1LY6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z806uwrZ4JkfTWKE+C9y93q3RbxKSjTbYulAW14o/4u0dXt8br+
	Xe6W/832LP9G6LX8F8ScHD5AR6IDTAYE5k70GM5WidsJ7WAlgGQdk8dtkW/7+wbuEZ7FuiF2rcS
	xC3INSNQUG2XM4KeGQp90BnC0dz9n5m+wcEw9ty0PFAu97+MhqWGv52SyJ1s=
X-Gm-Gg: AZFdTZdnNdoXTYqQDkwdHOgLpwoFN+vIZ0ezVGziI/sjK1m/tOk1MN2NSzMul3+dZU9
	ET9Jy19Yq2ZWeMwEuJECJSWbav7lnDUR4PDk/9yZnBwZ1WYSI2fyPTFkOOMCPV9+XMQrMfoKPVK
	7VD3NY7lxJKiAaUTihLyR6eIO8iRx8B3DQP11g1s087HE4k3LyX39GBGL7q10m36OB92E1ffd6H
	UkRSuBWDuaj8iRcGiaRcwc+xkoI4F8DKvoLjp2PMa9zmk0ssKO5OFtEl5WgSUBdbiYxdpvBSUXy
	hc2P5f33nELASrWD1GgJfiWy+FHRbqxszgs/vPaNKn5lkCurYUZ+z+wSDIUM+Vh6Ha3GGA2CZEq
	vAhNel0dPfG80i1grYXpFuhJGjGe3T1Ky5Zx528Qzhq8ux3kP8VvSuL/jUIn74orjlAxEEEqqay
	kGgblB
X-Received: by 2002:a05:693c:62d4:b0:386:ad86:21a9 with SMTP id 5a478bee46e88-386ad862c8emr15267653eec.13.1795787734074;
        Fri, 27 Nov 2026 05:55:34 -0800 (PST)
X-Received: by 2002:a05:693c:62d4:b0:386:ad86:21a9 with SMTP id 5a478bee46e88-386ad862c8emr15267622eec.13.1795787733548;
        Fri, 27 Nov 2026 05:55:33 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm32534281eec.17.2026.11.27.05.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:55:33 -0800 (PST)
Message-ID: <fdb8d9d2-3478-4257-8a61-1e8de6274352@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 19:25:25 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Revert "media: qcom: iris: use disable_irq()
 during power-off"
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261120-fix-disable-irq-safely-v3-0-82f9561394cb@oss.qualcomm.com>
 <20261120-fix-disable-irq-safely-v3-1-82f9561394cb@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261120-fix-disable-irq-safely-v3-1-82f9561394cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX0ZiDLi1y7Il+
 c/DrJsLY5Rq910EIJ47hJXIiTCLYbkeMwbDANCQkOFV0Ol3ss7mSizrTnmZ0UskJfaCxyBP2k8J
 Et4uZm3FZu0iyvGmyiXb0Q5OH2BwuSk=
X-Proofpoint-GUID: MgD2p_vXcr6Gb9Xw0VLNQ3v95BaCEDuI
X-Proofpoint-ORIG-GUID: MgD2p_vXcr6Gb9Xw0VLNQ3v95BaCEDuI
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b098bd7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=O1gZ55P4O49W-73hC6wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NSBTYWx0ZWRfX4VWR3YJ5zjNy
 BBf3tE5A0YlspuD4Ybs+B94dUaS4uu8misXIY07lk88ewIRi+Z46QFq6Qg/qKigbjiYez4NW9qR
 Lo+voHzAim1Bm7q8jimqbOLMWuQN0z/7GZl3GlAA7hCji3TvPe5AK3y9qZFAvtNImIHHM2FezFP
 SCNGd4HHbQNTzpHGEAridpkw0vB9cmFkjqWVGMN2ujeVmBJi7ftUhyBDToKYJsrlfwQ1nasnRpd
 MfX1Z+l2/95xx/lVtn2YHejG3GXoGFJ2Ebe+jiWbyI7dD83wG0J+74KksKmeK65M5zucVaC4auj
 OLjqNvezdUQANKVVAgRxh4Pn3qtKilkoefN9YBsTdsp4uI0McrB1aCsaDPFIm3y2wTG/xVYgkEi
 LcP3STqQPDAIiZ+lqUxD22w+Gj00D39APGsLUAiAMPlzPb3Df4UTQQR2F18MTtPXL2zPDETy1VF
 diDHRf4DqVsuLQ9dgYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270055


On 11/20/2026 1:12 PM, Vishnu Reddy wrote:
> iris_vpu_power_off() is always called with core->lock held. Its callers
> are core init, core deinit and the runtime PM suspend and resume
> callbacks, and each of them takes core->lock before calling it.
> 
> The threaded IRQ handler also requires core->lock to proceed. If the
> handler is woken and queued around the same time power-off is entered,
> it cannot acquire core->lock because it is held by the power-off caller.
> disable_irq() waits for the handler to complete, resulting in a
> deadlock.
> 
> Fixes: b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during power-off")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
