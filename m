Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8622EC0AE
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865587; cv=none; b=qhm9TniSxIXSnzNuZajMrqZG0N6IPK5f0fCXa4wJIfil+12Dr5xmfMHE2kDi2Qj8wdgYWRgeox4Yvqi+FZnK98uXYnl+wJv6EtpPI9ThCISP3t4L2x9ETydEc5YZx3s3NPKtV4yVQFQiOKRMb1qZ8jckcL6wH9TrtpSKeSZzBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865587; c=relaxed/simple;
	bh=nSG49t2rWl45pGWYF1OsDUoVekoqCmWTFjRJ1mk0I2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOtLMaTAvN5TkfzjFdufw8GjMnPcaAQaSClgC2qkC2bIaPQPuS76ANe/iuY/iEIaj8OSmmr7Wg2SU0w2iBoyQlg9ncF2lp86VNaV0ax+I+ScWLEzf+7Lu6D98EqEY69/ve98TvJqsFqAJMbtmVZxZrh8ZEp+I0dsHNgCQ4xFu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TTUSJ/G6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B76iuLSS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TTUSJ/G6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B76iuLSS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657El9Sg866310
	for <stable@vger.kernel.org>; Sun, 7 Jun 2026 20:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=p16AzikaBGvxHOE7IgOcj9y4
	UVGtNm9juMaQ099Gfyc=; b=TTUSJ/G65OWYRJ6OpkesxCLBy4cHdz2HNiXFJvj4
	eF7eELJQLuDGB2/hbv77pWXNZ0TxKtLWjHWBK4k/hKnL/mx0R6s7Q5BJaM20UfPU
	xNHkO5MFc6dqZhAPfolh77LZh/4ArmqVGXuP9inBnHJpuCW3dlHMUY58wmv+5Hjq
	E5Z0/SENEagL+uK5XsnZw/ghm3Cpac1g11wwk6ubdv20xuO2GQt3k6Fe/saQmjYM
	/CKlZjZ9dFDSQBKyp0JHjf+i7DIE2I4IN90VwjPgVpfAUIa27CWfX31pe7KDEPcm
	RU3L0CE+B0uawkjjqpdDGgJqdOa6nPjWV+tyvnl9pCoNLQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emb4w4u1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 07 Jun 2026 20:53:05 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cfc66167c4so1475555137.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780865584; x=1781470384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p16AzikaBGvxHOE7IgOcj9y4UVGtNm9juMaQ099Gfyc=;
        b=B76iuLSSXamMNKptU1i8d1zRTcrL6K/RS8CdNXL3Eb+MEv6HQNAyLKSJ8wxv3lXCV2
         b7TgMAVieHvEpLfY8/NNrl2fQoshzw9ufnwVUcmk/O0HQhofPQl73NPiX+M6rXSk0aQ3
         3xdrczuJ9L8kcOwhJKxtfwRn7ZZIrMUwzHGVr7+mLisrczWgE0bNLE+djFSw7GyW8jD1
         TWO3KWy6Cv3oIVnZQN+u+L5m8OBUQm/+/qF9QFLay0sHOx92tBhCVdbJDX9IMA02JXi+
         y7UqK+VkJ9OivqDalLBP+Ex5GE/P+eO8bGwAz1zQODzqsaprMG1a17KWO+l4ioEXPCf5
         +Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865584; x=1781470384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p16AzikaBGvxHOE7IgOcj9y4UVGtNm9juMaQ099Gfyc=;
        b=JbbKXgO/6/kOvmY29K8+OEAEVPK2bunFr7Ma2FdXfdL1iix2YmiFz04zPGrYDLnRR1
         8vZTAXE3lP4WlpXllNTieZMjneK73C3trOXQTWnaKckvewdGNLJJ4ZBvucD7wf8Se/3o
         ZckxIHjnwFZNy4uAloH+JvSRCsExD0V7Xij5dLNIx7FcWuag6zLwQM9ovOjgGLPV39qV
         M4n/kpFaY3Eyrmf0+VgwBct23q9YQVlMjRjv4DT1rnlSsUmDdQG5SHNHgdKyfg2DdYac
         cMI6AG7tk1ZWxdtuI0jXayXnG6lDQHhFGQO/hMShOxy97+NCNg3K/uh06JwmKgGioiNq
         uA4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hoUyM6iZnlF29zPlkaA+jS8ASFAB3ic1c94blx5Qp87NoULg4u7O5iRwXa07RA2QrhCJk0Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFaHqjVVp6Jo9dANYjjvMh1+nABHpgTppaX465TMak5ZOv1er
	Y9gcBT3uBGr2WuMsYaTafL/pgLnnCXg33vgr8Q86LGyUe+i6U9KMCvlMcQSd5MnTqKKwy0fEOH/
	g9YU+knZ8OFJUZafmAOLbVUYwNfdmiTniDX5mMOJqmnLFrw2UU65FK/PENB0=
X-Gm-Gg: Acq92OFeB9UY1wdeKZf8VUxfyh/ksIIGMHt5j1O2t6wdgBwAP4cQOOkrDTNFEzBPoiN
	KxIJ9UrqlF187HvOM/dEb+1GSUWIzHUSBU6oUJ0916h1OGS8Lpm/P89ZQjr5ngFdht6nkS0HXYY
	fNg9q99E8XymWocA+bRE02U6Czfn0Z+FpojFhfhbBmyKdmbwPnvSjlrHNqVWJ9I69MvTBnzDVVP
	5t88LBret1OT7YHUn9J19tDL592+xJNIqh5Aep1luFkGkzNIKmo5zqpkRBQzqaOa6LWOOZrT6We
	k3Nm8P9pjtHL4dXlHfkJsj0i8O9Mbugt4PCfYx5W1TBt/omOK2a90bqmy9Ue7FjNWnwokxZ/gYV
	WkPDV2YE8DJ/fKcGtnuam6nHp9Iv0PTimK6deEy3YF53jzCJN+8eKeHiqV8/DeyrZv/gyUoJ/9a
	vsqgr2U/FXuaBEdRpSXJwkeFrxBKncKJLGTO0cJs8yAjHMXw==
X-Received: by 2002:a05:6102:6890:b0:6f0:3ba3:7d84 with SMTP id ada2fe7eead31-6feef09ad6dmr5751323137.5.1780865584601;
        Sun, 07 Jun 2026 13:53:04 -0700 (PDT)
X-Received: by 2002:a05:6102:6890:b0:6f0:3ba3:7d84 with SMTP id ada2fe7eead31-6feef09ad6dmr5751314137.5.1780865584069;
        Sun, 07 Jun 2026 13:53:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b990486sm3244065e87.68.2026.06.07.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:53:01 -0700 (PDT)
Date: Sun, 7 Jun 2026 23:52:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/4] crypto: qcom-rng - Allow zero as a random number
Message-ID: <qf4lum2jd57aevapv7nognmepjpgrj4kylwkdbbslco4zn22ab@pudydze4e7ic>
References: <20260530020332.143058-1-ebiggers@kernel.org>
 <20260530020332.143058-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530020332.143058-3-ebiggers@kernel.org>
X-Proofpoint-ORIG-GUID: EcLnzFjeOVWzgG40nAEna-W2pbUKKg3S
X-Proofpoint-GUID: EcLnzFjeOVWzgG40nAEna-W2pbUKKg3S
X-Authority-Analysis: v=2.4 cv=YIWvDxGx c=1 sm=1 tr=0 ts=6a25da31 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Ovu24umgMWGFFTF80NAA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIwOSBTYWx0ZWRfX8ArzD2F+6gp1
 9GMjSvxNvJnJajqAk6JFayoRo2VX4/a5Pnv9tZ1+I9/vZXzUDA63EchtHNL7/1l9UmClZzFHMIK
 wUFvN/65BQ8c+PuQZc7T9QHvfJQfbjKR3CNskuch8Zdm+boIE+m7BM9T4duguQb46OnEVZJdQdF
 nQfxdegbfpOYCQT+zKoNa/6SqRnphlTjCz+XhY6f32/sbme4yxRascsoEYkcRpB9zohIBLKGRlj
 dDBP3Os5r51xKCqQ5q8Exc56v6Z9KwtLNim9WKn3VgjXXsyD1VFcE69h0VBNc9M09KvzmiyrE6o
 NJ6e//s75Czf5rLAjrX0oJKAMNM8Aiy6rpHfCiH4awK/lk3CakUD5ddDjgoTe05fWcJNPBASTTs
 1qtgW5LDIvSxerjavGl+OgxvaqpE0nx9fxyoNn1ehN1bUY1Lr0S+Jxb0OEEwSFvKT6QHoCaJxQy
 LTq4LSpKvwYXKsXhPVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070209

On Fri, May 29, 2026 at 07:03:30PM -0700, Eric Biggers wrote:
> Zero is a valid random number and needs to be allowed.  Otherwise the
> output is distinguishable from random.

ROFL.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/qcom-rng.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

-- 
With best wishes
Dmitry
