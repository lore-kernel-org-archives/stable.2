Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793291311;
	b=sniUkqRnS+0Pdg+HWKTZ4CoOU3tUlcuysy3bSGEVR8GCFg5GQ1MFdepfuVDz07XIM7ol
	 rtK7KKJkqwbbiyUYfXH2EfEjpJ3f+j8Yn34/2kEskx66RTLGUQ3XlhdGWcCyVttCKBM3R
	 P5fe/ip7Bub6/Ew0u2YJOozZlcqnMJZeMAbyt3MYkp17ut17BQDnqiEiLdDmbH6jdp8Da
	 FN7x7AKbegc3V6PLrZxanwkYZNuBaHzrAkE3X6HiUVULVDrki+PWwQjojRyx26XXgDc9D
	 0TEAC26WR2QBwLqA8sKICAmi2Y7kdirmpCxERshjakPGbd/dQkn7YY0S9nXeGG9owAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291311;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ec7n3tBIs89R2/LzH5q+gHIxeKPOb/RT/5XNvFGn7Gs=;
	b=skiMmS5seb7DOQKyZ897DCYhQ4gGTiKjgTC1ikckWcyY+GFU066dfM/JOokZIOt0vIoO
	 y05KZY7Fo2EeLwfkAfEJWjma15dh3pc01uXFrPLEQuP/7RQeVsbteqEiGKESqWAGTe1pr
	 LM2UyZdiGskVSnJq3nWi3P/6/QXi+YeUmzzHcFkObgel8ZLXzM696GFBr80VyPpVc5AEA
	 E5dY7lyWOVk7Lvjcehu20LUb8dBqBntzkuZnN1aUUNbGZ59UMWX1ofKPA7PicSglZglvD
	 RMd/FCIBYnptxwOIB/fZtpoNy31tIKHoqvgyca9yLkObfsq95TXeeUXV/gPltKRPzLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ljJaEdhI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+7gZiJU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC0606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EC0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ljJaEdhI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+7gZiJU
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGD1tZ535251
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ec7n3tBIs89R2/LzH5q+gHIxeKPOb/RT/5XNvFGn7Gs=; b=ljJaEdhI51Ae+dKw
	BJD0bZe2JkSc0nwrpWLUljK0wB3INpfz7VXgHHVAtqn1Xrmh8QUGuXzYrdGOPPp2
	bQvomHAMxEFcSwiAK8fIWB8irunsEo6hByYcCqV5womjEUBL85IWIMCWVwPqnLcd
	zFjEE/276e3tv+PujkrtT4ciFcLBrG3XiLVpkCivhVfZl3T3r/YvzmRty5avP/yy
	Q+J7N1FiGz+xAuG96OA90BCKZ9u0nlXoJd0RPo/500Q8/6MSci2KNfowAYuAtpSe
	4CdeP9r9S7k2O0k5a6xCmaOcyDe0GSSXBNvuUjb0552QBJbz49t6y8Wr5S5U1sOF
	eawDpw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4gdt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:28:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb7f9bb86so490484985a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793291309; cv=none;
        d=google.com; s=arc-20260327;
        b=K5pCktkS+MoxeaHdQfUyAU/lSwOn+Ba068FhN3R8HEw3L6Lvmugqy0CkrlRFszHuET
         EaY4R9W1QBY7iY0srVKge1/vbRMRTIx8CZ4uyL7bxN5ydFZ0iiEID1fVajgbKv1ppLQ0
         jn7o/5eAlAWK+dSxkfCu1HI+MLTGs7owSkVCYrvZYBczA7Gz9d44UwMMVJc2Pl30zNiR
         IQ8oNh5xhw6ihcNG8x4ujE7I0O/E+SZsy1bXZ+25/X2oDEsvdrZGotYatR82hY8ZHSSv
         7eDKQ5uGmoLy8iE8nfy7p7tdmB24PeSioUv3MLokAxYKum/2bOsP3HM0puzD2l9TiTdh
         YoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ec7n3tBIs89R2/LzH5q+gHIxeKPOb/RT/5XNvFGn7Gs=;
        fh=QvdDd9NzVvHwhB/utSGeok+hpHDU7NS8z9zsIWXZgYI=;
        b=cEFN8n0TGt7SR/kyHfTHSWCyGn7yWH1p2dVWod0/rpUv6fyVMuJwOD1mqZuFjwLPu0
         /9rKOONjyt/jdZb6rSRULtA6VuR9LVMLvxySCgXo1q4QQH0AM4vmOviXGD6XbA1xB7Gh
         xWjj+qXw9xGCuPRgFLzmdbHOTdDiukCUUa3S5f6AJNGcA2p3KDz1CmXgyoAGSve7oSGq
         wACwt2jl3/4KeV3niqDpbEDA5+DaANmXW7WVWo4A2G3o0HN6BWzjACbz+8b5YZxU31KJ
         7aw6LAR/jRvJ7XH+5yBNeWuXD6mcarKxopdcpyNO4K8RmE/80eDtGVDYND5Ikz1fLKlS
         E20w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793291309; x=1793896109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ec7n3tBIs89R2/LzH5q+gHIxeKPOb/RT/5XNvFGn7Gs=;
        b=W+7gZiJUh31zjNBcD/7gfEEnrXKm8SK0/9Q0iunWJvHcGD0tX7rrjZ1uEI5KFwOYAt
         qUntqwgI/33M7umcU8ip81T0BOW8scWg9G5h8ZVIonGNH0qvdbyXj9Q6Z+c8gosDtCZc
         VPCgcUa8M11Oyrju45LEQZVIuvKWXdyU0/Yl80A1YojvKif46GdP30ZhpwLMJuCywdU1
         DGUiNncosd1dx1/fvqKu4sgP8IGOKx/bbAq+q8W5Nlr3fu+vrjps62/aPI3B9INpNNy6
         NWKumY50Q560hePsb9v2u3QjsXgEjLfd+kFnhecvEWqjiOI1BBMOVq3VsT/LHNR/H5No
         rFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291309; x=1793896109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ec7n3tBIs89R2/LzH5q+gHIxeKPOb/RT/5XNvFGn7Gs=;
        b=iYxx8oruZNtaVDVvvYFK70YNNUz4AHqITethMbiOxaF4fGjh+2ehDx/QyhCwPVLSfl
         NdXPSLrOHCgDijNXucqAJED9/lGRayBKfOaBvleDx1ehrOu5U8ccGqF6LVQTiM+4Etcb
         AcYoenRFw13PNmKo6cx9tgN2C43yVP/B++aCLHwozYLUQ4yrWimlbVaAJLiqNiO/87CC
         6jJYgwYRa1ZH8ulmn/0GsgVRZ6zxfjR45lcn0djClZCrd+6PdI1SdsP0C0Di64HKBuok
         igWB0SxLp9XqkJN0EYNC4BRxiza5E53heFdLepAIuE5lWvJIRxOQk5an8MlsCN378yF8
         MH8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxMMgfvB14ic1deqAtIIITo51s0oWjtm+RoT/16R4WII7BE4Y/xfsMTdrhlSFTbBa3njwSIfRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI/5PXexSX1WeRR2NiRQMBHOfFgjZfWSnXyKpRh1Hp4InfaQhX
	lGFMeCowFuYpi9j58TOad6cyjFcOGHo7sOxAWr8/Gcy6DH881W+Wik1BlUenNvBnG2n3WMjuYvQ
	kfI8PgNND7dFQvLCKKwSla7siHnrz853sUTJAwGgLH2aQ5oB/uQW4IC8aEMBqEPRXR9qb1h6tCB
	U6oY0E8kHbg7sz4TNvPJnPx8ubxE/b8ILiCQ==
X-Gm-Gg: AYBFou2mjXCR6PZ3bH+ktffgDDwQjnVGOs7pDZLPAgqtI4LBRQdYPTCEjGi2jPEi4GX
	1AHNbz3wasVqAdzlo/5CB8aiEPwnTijt8gO/fDDDtEeAoxNi3m5AjxUvXvyhPw4PPZGdwq9BvCh
	CfNAi3xlK9rVdvIWtXDCj+vG8xrS+km8NPhsRUoERNtcnLBMsijsVJY7cT2d+cBi44vUk7DbyTJ
	wHAp6wU6ZuGPhekAohAT4+9tnAEm7qG4i20zTa6FiSeolPtr2ximuMupVebiye0GAJX1MyNoas0
X-Received: by 2002:a05:620a:4106:b0:93f:565f:e40 with SMTP id af79cd13be357-94408d9cd0cmr909714385a.65.1793291308675;
        Thu, 29 Oct 2026 09:28:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4106:b0:93f:565f:e40 with SMTP id
 af79cd13be357-94408d9cd0cmr909709685a.65.1793291308187; Thu, 29 Oct 2026
 09:28:28 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028050337.127464-1-yaojiale02@163.com> <20261028050337.127464-2-yaojiale02@163.com>
In-Reply-To: <20261028050337.127464-2-yaojiale02@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 17:28:16 +0100
X-Gm-Features: AclHuK9jYoqEMbdFg84LDshS_f4aCDb9uqZSpjUek3Kwn5SwhZg0YWrh26svot4
Message-ID: <CAFEp6-3UCSqHqABuvBwmNf_bAvJCWg+N9rZvLMYRydWQKxMpeA@mail.gmail.com>
Subject: Re: [PATCH 1/4] wifi: ath10k: clear monitor interface after add failure
To: Jiale Yao <yaojiale02@163.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Michal Kazior <michal.kazior@tieto.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NCBTYWx0ZWRfX4WhMgtjfLi6U
 zYy6Xcz+A03SUFw+RavOuIJspIqBACmA/ze5LQ9+IWOV0ob+DSlrDLFOO6YdnXaZsmZ/vz8Lblf
 gsWQUY9uEi1i+P90YA+5xO+C5gtFHEYqjIr0C4Cs+HKhfoZpfQVulh9q5ep5bKXW8tHI/2ox4B/
 b6t18mwWRf82kRkRTDSvAG5aiecb59Uhr+Fmnt85KsTIkorAz0vkcaKCTLb5rBqft7IKna9aii2
 BF/AFUmYu+IeiK1+qhZla8Ye/m8lH03cJEOlVEZw1z/eGMZ4c7DEl5gTzRrd3hou7CLKNV+DFVt
 bjzhlzgHeuhSrW5jKHCuHi5/Nq6rMv4aV+HMqYJDqG1J9LHkUTGI+iTI65Cmto2BYvMvinCqk74
 pVOvem0MylKKWWCQmTA7wDk7hJ4JjsvipZ7SgDbN4BeYIZxSj20YRc5BedXmQ1WAwaj2C/rUM/y
 TpEkOcGZP6G5VJCssKA==
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae3742d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 42NvQK-gbKPta07sz_617GT57yeGvr8A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NCBTYWx0ZWRfXxTqN/mTzN0tu
 mCliVKWzui8g14n/bLqOqaUwSoDhziGB5p6yH6vDnyfLuSIKlvUiuqxpO+QD7FGHzs0ugFQF5YU
 ridQAfgqtsC4BIaggCPW5CTnwzsqgqs=
X-Proofpoint-ORIG-GUID: 42NvQK-gbKPta07sz_617GT57yeGvr8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290064

On Wed, Oct 28, 2026 at 6:04=E2=80=AFAM Jiale Yao <yaojiale02@163.com> wrot=
e:
>
> ath10k_add_interface() publishes the monitor vif before recalculating the
> monitor configuration. If that operation fails, the interface addition is
> unwound but monitor_arvif still points at the vif that mac80211 will free=
.
>
> Clear the published pointer before entering the common vdev cleanup path.
>
> Fixes: 500ff9f9389d ("ath10k: implement chanctx API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

This looks like a reasonable UAF fix to me.

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/ath10k/mac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless=
/ath/ath10k/mac.c
> index 8e604697d6c2..36b694ae6de4 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -5875,6 +5875,7 @@ static int ath10k_add_interface(struct ieee80211_hw=
 *hw,
>                 ret =3D ath10k_monitor_recalc(ar);
>                 if (ret) {
>                         ath10k_warn(ar, "failed to recalc monitor: %d\n",=
 ret);
> +                       ar->monitor_arvif =3D NULL;
>                         goto err_peer_delete;
>                 }
>         }
> --
> 2.34.1
>
>
