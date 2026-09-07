Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83F415B6C
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767844; cv=pass; b=DNlJtusWMTuf4qloj/NrqBbLCLdD/di9GXs7NR50BJEPzUghz58qkrtDq8JIaKL7pX7855VJVgQluq613EgCatKv1rmBsdjfwFrsdkkWaIVImAVLVy3MStBYR9QPoY80Is1eP28/JD0nOKlxHydqq7hp5o2S9auq+kvltmaVgVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767844; c=relaxed/simple;
	bh=UEgL+cjcC5V6DKWXjE8NrtuV3xJULsat02NZJ6k4OB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiokEzDUxM2cNoDQdwbzbHvUKnBzamwGMN9uKaTuNT6lcB7Ll46UdyPNhlcyjJPF6J2Qmdjx2MxgifXgV8Fi3B5IePxOwSB14fMxYNUrMI69XX3G7ovuD9GCAU5X3p6Q+dc05083cY0aMum74efJtQ7DjJJyGilyTpj9Aa/YUyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwwtiUaB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j91DCwsO; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwwtiUaB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j91DCwsO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777NrD3352439
	for <stable@vger.kernel.org>; Mon, 7 Sep 2026 07:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=; b=gwwtiUaBQ9vv5vCP
	F81bVhdb4bDH3f0qGwE8p9c3u1mrl0Apw3TIzE7Zz9Dm3hOzq/f9NONCiGvdpsyT
	QThCObQ3T45DCLGGi85tVZPs4TF8YeC/FijkeIngsVevj1rvd6lC/72BZHL3KoAh
	4LyXm8uUDznpgo2PY5rdntXtE5OGaVvGuuonwL8pKYn/a/J3JVvbffrlCI+DJYXT
	62+ynOG045je2Y6l7haRDroCh3wHbEQj1U19ckeRR/vCT/sYrXUmRsQ2L5HLoRx2
	HSas2PHgkQocg4jdib1bxY0BaYqCv0iAobiGHn1H4B9egSIGCu3bHkGh+czmlIVt
	+PcLQg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghq66gnw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 07 Sep 2026 07:57:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-939a6937513so113038085a.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 00:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788767842; cv=none;
        d=google.com; s=arc-20260327;
        b=hPaoAjxz94ILExE8Lbd9bTYnVOe+pC+WRFt+4e9P0fMfSgfEiz4ZdcpmvMRKdoUDXQ
         kC6RaUDytPEsUGwNUADEvn1S++AgrAinZcBz13EUVsZybKhS9VVB82/HnGe+9jv+sDw3
         pNH60YXpTJlhvpGFv1+LpcfKGUPyUEecBHZrDP5HrbAevLFcTLN6jPhWRUHC6art9LXe
         /51ulNBMzLxlsyNv82F7eiZh1pz88mIst2pqum/i6yHUYpajbijGYYF5c6DRKg3u62R8
         wZP+KGcehLqaHeFFzAJFXOADPSLBrkk39V9E21gAyY2MxVpRJBvWoNv5D3hCr2RS42AI
         QmEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=;
        fh=ONsa7rWu26/0CoCVB8jOJBSvynO33RWoTCP9ctQ93Tg=;
        b=WJN4vIBdX4oPf8oWUMDemr6NMxXa4u+UouTxU7aLPxc5BYmqf5wWwB9lipcdag6p/m
         8mTd+HcejxSWXsKu01K8Mc0G/FCppPTqiQ0T0yPd/kDoQxHWcwyZ93SvbqvOfLawCH9B
         JQZFvFeb+x55A41gU3WZphl+v0uQLmWk+WcZc7eHQErfIrv/UzYins0VxePgGDpG9zZv
         zMMsDew50y7A7W9gShUKrBWNz4uD2ymCq0mFu00hJj+aEedGGdcKA9pGmqjF6zA9bvo2
         G2Y0cWw6XvS6Kvzt3bq2NVK6UYpAhxb5DnSQT4uiFkH/aO2BrGocbGw9XkDLrymvU/+m
         OyNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788767842; x=1789372642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=;
        b=j91DCwsOsYuAs/1AjGtG0MksdXCs95ESIYKw0yrlaTcggDbWA7mW4Xy/7zulNn0ijM
         aT1NTCGPev4o7+QrpI9pVieabpNzyK2Y6DYYEXzdlmWMmzyJFQIOcyRprHoqOcS64VqN
         CSXP4PWzS/JvXy24DD/e1CX2LV13jvfngEYpuRqTVwa25YxQPTEpG7e7K0fbElDjbTq0
         A79U7O+uItwdX4q+zFB6motpGxuHbeqfRz/MjpaxLt90qRQTvEuzQxCv4lAuEbpWWkHQ
         ZEMEmeSPJUhhUjNb9frERVvUPkIrhDhWapoO5oEc2TPqr63kpYiB+YLGp+fABQcAsr6r
         0LDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767842; x=1789372642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=raxOv9BRhxh6b23v1ddPvBQgeOT1uLi4R0ZkrPkOa8o=;
        b=f3jQsQ2TvF+63Nfsctq1cVZH8ne1ES6e7oypTfu8GrRgOK883gNGeQV9RzaHc+WHfr
         es8w6Utn12JMc/z+2z/p8erK9NDm5diwiJ75EBlgvfD8hj25FdAd4AEtGwadpdQIfVdo
         /Kf95xMTf6hGxPc/21fuBIrhXM8sZC0GUegtJkfVXin7pv3/9jeXGqsFb8OEDFVyf7q2
         JUCLQwUU1UcyWBRiHeGFmA10sZFFEGLg1R3d6QnSjBNRZsPT79URw7Poxy3/opnd1a/u
         w7db32g4nBWz1wPlf7axLjpQPxB+9gF513YqxiZCYRNPJTVIp/xJTlP4OyLi8Dk2MZeY
         HbfA==
X-Forwarded-Encrypted: i=1; AKwUvBzSKmIcK6mbBgAYmbh2xPzwQwz4Z0NCs5DjZT6sDS6V8XfLk5JRDGP399qPDjNuYiksIzJH7SU=@vger.kernel.org
X-Gm-Message-State: AFuF++kyzGgK9gZPQE+I/mK07BEVhNxLsz3zE9RucRGQwcDgt+rs1rSv
	DcDozTjA1mbh8ODDoS1xhg8vUybSod5yM97Ax3GS5DPPxlkmh4WtR3+Kc6tr3uUpMwsM9ridxcG
	s7c9Emd7BaUJG4ZU8ES4buNr7xyo86BB78VosUYs3yKNGWujrCleMq+jvD203iv/CjCRrrRzCuz
	glauB/vfATChwbjDu37agLNUqCoArawAb6RA==
X-Gm-Gg: AYBFou1K9yJqN9QHjNLxrXAsinyB+9J8yom/++IRth5Itxxj2kFfk7Eb+rLxedebioR
	Y1xGX0fJbyuhkY+dhpy2ypfYvEnKmociFQuzBKptpNcRz1ywX4s8Ru68NOJgD3ELKYZrK8gxERH
	ACJhnlELmzkAINZGmMSx0SCi2RIELnaORgw3LDhb/C9I3zfYy+YuAj6IsCFzTwlgj02rPWbK18P
	SAR3BS2qea0o9b4Z0lt4WEKZ84xOa4a6zlMOS1o8CPJVBFzZsSEIe/F1y8o69c2CHcxFh/Xm/o=
X-Received: by 2002:a05:620a:2801:b0:939:6dea:374d with SMTP id af79cd13be357-939804f9de4mr2213548685a.49.1788767841580;
        Mon, 07 Sep 2026 00:57:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2801:b0:939:6dea:374d with SMTP id
 af79cd13be357-939804f9de4mr2213546085a.49.1788767841083; Mon, 07 Sep 2026
 00:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P251MB0001E25A247262552A62241BC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P251MB0001E25A247262552A62241BC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:57:09 +0200
X-Gm-Features: AcwNN1UIpQ05EZDWMaqZ2tZgRpvM1SyCnXtQocSo9oLyoRHOwGYKGcNY3oOx9UA
Message-ID: <CAFEp6-1QNj2a1av6inPPD-Kpg_c8cxzNgEf+rq8Q-GhyS-+Krg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: mhi_wwan_mbim: validate datagram bounds before copy
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QPhYgALL c=1 sm=1 tr=0 ts=6a9e6e62 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Zo5euW2OAAAA:8 a=VwQbUJbxAAAA:8
 a=hBUqTIjWXI3YtBs8_v4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: y9gqcoQi4ecORVMV8d109Yp1oDgWlZwO
X-Proofpoint-ORIG-GUID: y9gqcoQi4ecORVMV8d109Yp1oDgWlZwO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4NSBTYWx0ZWRfX6i95fsqYHNXx
 Njo2xWgUOZjtGC9tagDvDBMTqqmFx8G99SYEcef6sNv4qfqn3heOB1YmIMWYeqoXXSNz8XywBsJ
 V6ThZ50ssQMXjZG2Ud72oUbJrNYHI8c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4NSBTYWx0ZWRfX6A6EtMfj5GOu
 e13Ss/yQ63tfV/PHHgvJTIO66p1HBUCPNKjYfMOasShMYxz0TPyQAfc10LRhHQTJ4eRa11Mo+RC
 VIMCw+k4SaNOjPR5l/ZoxyjkVATAbN+BHZ+ziCTbaxP/Wkk1+nTy80hRdvl+SI0wGaI4Gnh3Uqt
 gJWEMrFV+lrowcVpegVoCPVs4ieam8Qzo+FlPD7wpu0pa3V1YCSVA65hZ4LnvqJFe7kJYXEQkU5
 6kZiuF+ADK9fV7owgGTvgI3xIcpuDfseqlg8gIA38epzqmoB4yOwH69WJQFY6ZxjzdziTd3Xp+2
 L8kcQWKPkrOa2tnloWpqtikQm+MNR1gAIpxWRHiJBgRoTfAuk0tN2RwtIYmbgA6pUK47A+w0cBn
 EQ2qSF/UtvpeNIiVxf42W8it6ZXG2fk4C+stRCqbte7GCPZV0gG4VnJCCLt+bPzYuWWQDP+UqUk
 bZvMcdWpi8FZzzKuTMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070085

Hi Aamir,

Please review AI-generated fixes carefully before submitting them, it
will save reviewers time...

You've submitted a lot of patches in the last two days. I'd suggest
starting with just a few, if not one, to first validate that your
process is solid and that your AI-assisted fixes are reliable and
double checked, before moving to a bulk submission.

On Mon, Sep 7, 2026 at 3:49=E2=80=AFAM Aamir Ahmed <elb12345@hotmail.co.uk>=
 wrote:
>
> mhi_mbim_rx() copies datagrams from the NTB using skb_copy_bits() but
> never validates that the datagram offset and length from the NDP entry
> actually lie within the source skb. If a malicious or buggy modem sends
> an NDP entry with dgram_offset + dgram_len > skb->len, skb_copy_bits()
> returns -EFAULT and the destination skb is delivered with partially
> uninitialized data.
>
> Add a bounds check matching the one in cdc_mbim.c to skip datagrams
> that would read past the end of the transfer block.
>
> Fixes: aab8d56c11be ("net: Add Qualcomm MHI MBIM network driver")

That hash doesn't exist.

> Cc: stable@vger.kernel.org
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan=
_mbim.c
> index a94998712597..acdcaceebc48 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -315,6 +315,9 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim=
, struct sk_buff *skb)
>                         if (!dgram_offset || !dgram_len)
>                                 break; /* null terminator */
>
> +                       if (dgram_offset + dgram_len > skb->len)
> +                               continue;

This seems redundant with the existing check in skb_copy_bits().
What would make more sense, however, is to check the return value of
skb_copy_bits().

Regards,
Loic


> +
>                         skbn =3D netdev_alloc_skb(link->ndev, dgram_len);
>                         if (!skbn)
>                                 continue;
> --
> 2.43.0
>
