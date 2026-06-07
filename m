Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F91DE8AD
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865525; cv=none; b=rWZ5ygWeknuO7Z9BKA9NJL+eb209HYwQyMqKIYsK8hxvM+gIdvYSJAMfgMnFkfI21xyd+Oo9lZN1Dw2pJoatMOWxy+1foNpTOR/Qj33IKute1ztYSOpiP57mW2Zm01lapy+g0m4VlDv2xWG3s6r+jCAeGyzRcw85hwhTgFg3EJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865525; c=relaxed/simple;
	bh=BjkvTCRYz0fa8976imPRZK+W4llqBkazHf7ThLm7PCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz7wTmbdh9LxYgwEEZjsTBHPRkXwPZsUE0ryH7RywjT0qykrl4+RfAdate8KTZ1SesxS8O0M84nQFKIu9awz4Hs/3VLDgi5TK4idU+163W2YsL88Fmimc3UWpqJxaFuo9QoWimHvcWHBPq2HYtbS3luAfaDjsETNqyA05L9oTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z0U4/Rem; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbvTFWqF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z0U4/Rem";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbvTFWqF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657EkLgm440761
	for <stable@vger.kernel.org>; Sun, 7 Jun 2026 20:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+pIB02ijY13PTRTW3b1mGVCc
	zD2F0d4S/o/0/235A1c=; b=Z0U4/Rem0CA/ZN9xGxn11yk9brb6N3/rIDnleJ+J
	5FoB/O3jx5GHCTkyLhKhl+63GMWpjpTL09GuBLtv6JOLgXS7vNxklZ50H12Xg7aB
	EsFOXB7AK9oi8I+PYwLU0CwMyR7zlksRmplvAi8dQak+puVi8A5tC3X7LCqPYSh4
	cyPaMoGlAvDEI3LKuq+HEXLL67WAS6/yBLpahA1ScMV6E8HCaJiAwY34ILrz2+RZ
	+yXSEQnUM90ErccGQHlcC8IS5hCCGGRtgeDqedezIlVEm0XB8HdgNNMinND6YBH5
	Iu04MJohkySzLkOHjz8YUyCd+yf+xiz1zYCZWOoFUenA0w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em98cw86g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 07 Jun 2026 20:52:03 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6cc5ae9b959so4392099137.3
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780865522; x=1781470322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pIB02ijY13PTRTW3b1mGVCczD2F0d4S/o/0/235A1c=;
        b=WbvTFWqFEyuq7+zZSR6ew6K2qq6SPVL2N90XpQudI2Dlt8LPrmRt0NcxV4pdLVdWNm
         l/Vt2X6FCUlhm92TsiQLl26nTFk2Ell7AzQb1hE2eIonHd3GSTpEsLG4rEPlxMuccsRu
         1S2zVDwfkFZuUr/zxj3YOVV2VxzaKmgoXl0Ewi3N5O4qnXp64sfoDY9FViFUdeIcpCuF
         1f9+5eiBEhBMwwxs/0LAZHGFYc+lg6NpYw3stKyLk9WLhTFriffV9vhjclLDbQtlpzLv
         kvfPjUKb9S39OU+xSajKZvCF72O4CGmIN4mkCaY11/NXb6WU2J79mLPXZv1pvD35haMN
         9xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865522; x=1781470322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pIB02ijY13PTRTW3b1mGVCczD2F0d4S/o/0/235A1c=;
        b=KB504wBwRYXzXStAuqhREo/itZyAveix6J9YHICjY9LC7N2+Dy2HyEURktzdQAvzgf
         uF/aOcxn9DY4GlEGavbHyYpZkgMRG3Ik60xvj/EZLuVsk47EGTFQO/kZEuxgDlUw8bgd
         bOVCBNzcxIYGH00PN1I2rIUWRVucYhee+aD4FuJ3WOEfR+dHD5rPeltNvA66RPCQbkUr
         B/7GWIUOt7e8Bg4gqYvIM6RB9ty/LEy8i4j4+5Dzpa2zsqGEcRiRGaAIb+bh7dYX0yqS
         fgY2NT99QBb8bhxkXlPeGyaJCZso30IvW9emFmZxODRNmxVafRNMlJfhL3gHFZQQJHMr
         4G9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QY1dm/oS3XfB8zahdm97hILB70sul4B0OawG4Boy/NxPBSZc82qnP4pcB/wHHBoigd+iaizs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12HVM1deLIIXTuvyY3YGqw1eKZ58PCiXGLYY56bwtUm/mIJ1d
	Y+jlHwatfH3T1uUEySfGoC8Wr6/dOmdtjN5aSSuRfSFZmJ5aSl7P3xbtSrscL+aPpk4uF8VkKeN
	KtgjBJxO/e4XzWoyQOopO2q0PK+rwgO+gL2M+iFszfIIY+mHSrA0m4z7rG/U=
X-Gm-Gg: Acq92OHsNZswhacwncLFlPME51TE1hUuWAVKVeoabjBlXzgh/vbrrOnq9GrwbZZPlxv
	FZuAgvIF2ZgYUZVghKRlg/PcRlIEUMRCBVGtkWRvWUMdmVCN/9w/VXSmuMSVDj7QWbMVYk3qp+Q
	5wszaKxwMIUSIFayT9GZgRmg45YZSDXcnnKVyB4P1mC0JQP9C4W6t/6UTqXt6s7Ta8zMH4/nKTL
	tzAwkGGYynXHvkIY0G8IW0gglBBphKUKh5nh8EYOnNmFPD7qznyxX52qWaI+0t7bSc3zfrZKbCb
	ovD9IWWCekUoqZOt+XE3JvsIU5VgxjzZ67/P+b0V99b6bd5nrw63WQOT+bPtZWqdfLtKVikZROV
	dJ10RC2B+fFdMXH6Sr+KKuhyJD+5d85pbVgJWd88BqxJlhXpmghJ5eldjcmfQ6zTuJHd6dupAmY
	tthW1Xbrv62n9WuYWsRwkqgcybD/JUeQ1EFgh2HQkgeu/nwA==
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id ada2fe7eead31-6fefa23308cmr5994406137.20.1780865522392;
        Sun, 07 Jun 2026 13:52:02 -0700 (PDT)
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id ada2fe7eead31-6fefa23308cmr5994394137.20.1780865522035;
        Sun, 07 Jun 2026 13:52:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2ed9eesm41476591fa.40.2026.06.07.13.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:52:00 -0700 (PDT)
Date: Sun, 7 Jun 2026 23:51:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/4] crypto: qcom-rng - Enable clock in hwrng case
Message-ID: <ldquuwgt3ktbpsnrvgg3ld7lzt2gebvoyzw42jji3xmj6vm35g@myeavdjxraii>
References: <20260530020332.143058-1-ebiggers@kernel.org>
 <20260530020332.143058-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530020332.143058-2-ebiggers@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIwOSBTYWx0ZWRfX4PzaaCM15jiK
 W7InvGr0uRKFwfR1xQ68cNdTPVPRR/4QmFpl5733DAJJYik1swGCwZc3COTM6dT2FZbPidEYC9u
 xKvaoLv6k3MG0pjOwpnEHc/gP2P7CRSWpFmzC1OEXI55TkG0wFoNWYlkDEhxtQwbX1AoHA4sd82
 G8CGr69udOGOniW8ILHqIuPrDwe5/pnIKOoZaRXyaAWaYaKP9t3MWngT7gLtRDP/pA67MNguUpK
 YN/Vkyhj7yXvX8gmO+r4vSzEUJA9vsFEEL94mUi0CbKVYP6dZUx0DWEveLY+NLRtXCQDp92b4dQ
 ld9DA4SoAlNTECx1NwsfEBXQxrY+nGhyktwJb6d2nCnjPJm6EgBrvP5ykvZ+6OnO5WRBRUDZMG+
 2fiI6IdDaLrS+3D5+P+/RcI0cPINVQq92zoB4yxdH4tyHw5mFqmXszGrqn1Nm9zE7fCCEHa405o
 0D8quWWb6MSyo6CX5jA==
X-Proofpoint-ORIG-GUID: JxF9OiSKNpZRra2ylD6Ryp3-G-67hpmD
X-Proofpoint-GUID: JxF9OiSKNpZRra2ylD6Ryp3-G-67hpmD
X-Authority-Analysis: v=2.4 cv=A/pc+aWG c=1 sm=1 tr=0 ts=6a25d9f3 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tI4jJ0bUc5TXO7XjffgA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070209

On Fri, May 29, 2026 at 07:03:29PM -0700, Eric Biggers wrote:
> Fix qcom-rng.c to enable the clock before accessing the hardware.
> 
> Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  drivers/crypto/qcom-rng.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
