Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793883425;
	b=KhWmlSwxC/hB+L4d/jVnc3yPgB3bMip6li5HpwkTTuQeaDHzdJmCNoLaEsLsMZ70YoR3
	 ZP0DuxvveQ2MwNyRYawOC1sRJEYn/ztl0T3avot6eKVXZPjf6TuiVnCciYdQ3FvcJgwAS
	 PI90PoiwCDNFvlMum/Xs9h07kztMrqygxI7ox18PGZ3HTuW57Pb+RZlnkHzslSoG9NwOg
	 gZWDmUC2zIOOooq8OA1w3/bYSeLx7XY/2ziSL4E5UYD5EpFuejl7k2Onqf5wKpTnVQ+hu
	 RwYhkvGcqy658AuXDEqvwI2AvYGHR/Yzygrkov1EC97cmDGJfjKN73Qy8YLzgbOtqzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883425;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
	b=LHV3S0CXIsmwmnc0htZ+vO+cpFUjqa8qe0slrGfWKl+3XR1vj/K84GFyf5JQJHXXbgJc
	 nFjX2gttuianUh6BuQaq6i0mtq4R17PFyQfNXavxkfLETBVijPBmqSRJBnJpHjtevrWTK
	 MTq7ro8IS0ELEojsp5d66oOEXd9w2gOvhbK9lz8QqsFsXRE8dF5sX3l8Kvut5dFDHC6S5
	 WYR5bv/xWZ+1uR3vBOQzguPAgK9ulWYj47XGEtqBfSIFylLFIt3Mr0ypHF35RJxXt0R2u
	 /tOnX5lxv13IIqXc0JmPq96D/52I7/v6YH4jXXjCFUl23k2JjLBlIi/+Zp4i3VaWduA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxnJvaXE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kn80XzO3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233C606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C233C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxnJvaXE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kn80XzO3
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tjxS3532140
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 12:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=; b=UxnJvaXELaUEgiuu
	ks9r5kdERBsPO9yfyr9ebaZiQJplcqUiXUkl29RnjuG1yp2Go09xrsKYQJ/vghmT
	Xf8gueYHQ8k2uMS1CAKebDWvKFbzDjkGAcnTcgETbt3QAxKQFe3g2w2QRDi3U4C5
	mTlNGqTAqSpGpWHctZEyNwqV380/7fk/k/bhhqFtQ+J+7gqYoj4DfUkkfD+tTwGs
	ciR5KvagIwFL32tzML+a6YJ/XQRCA/YNHEgqPemOw0ToppgITrehySGdGeuQAhsS
	il96VeapyMWoBSkl2T17q6gjwOURjHLgTWBcN4+9u/Qf8SrWx2dp7GiMacY/AI0g
	fDpdAA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9qfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 12:57:03 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-836c416b236so28516337b3.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793883423; cv=none;
        d=google.com; s=arc-20260327;
        b=kJg236E53dbS3TCYzvDNmf4J+ZWjkUWV21rqkZ9/wl2uTch2UCcWBHgxrBMC+1+el5
         QcizXSdFa1PBZtKCUJFYtO3inTvTbg16U4QFtp4fGZ+Z6b6YvrZBfw9Eerlj50HsgzEE
         ydEiGT5K19xdPnLdQcbzR3aGWKTReD40ixKNttBz6tiZIreREQQij5Ep164h/MCt8S7X
         9s2Zb7T1mCbxlUZ+2PwJnSM7RsGtzjQkIWFmwi1e7MXv1dsY6kRM/sV6/sklK6dJToev
         T/cCP1kaMujS+ptdOPkZt6Z/fgdDyTM+dwIYEdhCG/2Df3av5NCZ68QicDlwB/PN0xI8
         SkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
        fh=E8XugJScrBp9u+EgALpuNLYOdgUp0ZATsAsE/+ppKyc=;
        b=oLAZ9VLyXYMb4WvACBTNh3ADzrCVhEi+X3nyK72/asI12KYyJK3/yt38jvwQI90eaI
         496jxbur5tfqLUm5+P442xO9T46YyIshlHQbz2Q0nDmVvZRGS3/4YVuVG+cVdpYKpTb2
         s4SgnPoyKS7boK3n9fHcjYuGOzApO2cJ7+TjL86Dcw6Bw9ksv8qxJjby70HA0YJesvo0
         CzGf4r7gguxR/Ztiy+ay0G7bj0hej7Vm2VNr5oVf8JIK/WJQj0+j8ZP/S8vHOB2ZGRf8
         lbDkk0AhKaJfcI6MQz51Y2z8EQjjHAgARom6DaZSJVMUYkikwavlvVAt/iCs/6uKNNUf
         AS7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793883423; x=1794488223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
        b=kn80XzO37lATT+kK4V9ZQ4zxwYPKG2G/KO7hzOecdZDUgDDWixHr8l0X+B4n3PpoO6
         Swz9SR8rfWsSOdFbihZ1XtMQbz5Z43Sdl1JUATQewdhIOd5NnSvCeG5MoOkuDOxOO7L1
         My2m82rNlnoIHHOp8WCsFqeEN4Dzj+Bcoee9IXY7dDc7N0oYfmZBv/NXKc5DuTEFKTpY
         6K+11W/nlSYaABB0XNtwBYVBaFv0nESvwpTqmwu8BVtGA9gNDr2tCCVa4ZWmjbgPQZ/G
         3dGuc40FeBZ5/Es1zC0cK7zFZJgk9GwRolTJyYrmJyarUTgiP4aDw4TntM5zkBEp0QeP
         OShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883423; x=1794488223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
        b=AIRMFKI0nY6qGigjd0OrgPf9CW1VQfMojz5xn1gGIFuIz1YARQlfpvO51MlINoo4ir
         3PSKS0BqqMOMVfW3Dnz4HdeRB9BWiC/11wc7vufjHnKpPSZl+luvt9ApGOzuY8+giKeG
         SPhDpKjm32BawN1NZJvrvr7y51FcpUjkGPFDLCvjU4VPNbqOw4/nby3WFRRDGpPBDctY
         i4f/n/Y11nekV+eo0mcBpZ9STO0DDIu9Vmps2IjV3OiDpMZTu96q6zl6DFAgSke12wu2
         g4Xqb9UcYmKTEfoPgqkPy7v+t2KbIXMYVFACk9kzcSDQNc1NOqNlcJ9ty42v4zFwqny8
         vL/g==
X-Forwarded-Encrypted: i=1; AKwUvBzY7q0wtbsS7BP5e3P3BLPKJEZHJAZRqY7GAbmL9HazBo3cWO3JwgX1jNgVCcVG0uUQ/K6nkEk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LEBx3W/W6WcGa7Bam1P9vdiK9uoXSJz+aNmPIQIADYoq5tjSQ
	azKIzvBNE6N2JN9WgEvR62EAo4vaNgL4BBpitorIhc8juxQcrLemXBEJ0KGth4RAEKxOVhLWnKM
	Nm8TWK7SdevuUOb/NZgt0jX+dieOKYm1obyV8DcFFKNmT+ofJ655UyFglT9z1ZEchzUCGFRuS06
	SvQBW3ysh+aUyFZtwlJh7M6MaTXmdDFwCgeg==
X-Gm-Gg: AYBFou32yeVO07J9hdRUtXpWdRBn1cRfJZu32ne2CTx7kaUuczcRPYCyLFZh+fe1+BQ
	Oe1GM89tUgQN2iMPBQ0xqNCYAcx5j8P8Fvpx09tKzhzZJ0aemF4nlOw/5pMLmAfP+aSfXBkSrSE
	DXIjSljDVHQh7lPduYgiIJwh9czju36nhZhjQpe47yqE4w1Hu7Pma0EF+EbBsOj4qwIcioP+2eA
	rAMPX9gnEiMy7Nl+xSdDM9ilEx4b60bC/xsSGi6
X-Received: by 2002:a05:690e:a44:b0:67c:709:9d51 with SMTP id 956f58d0204a3-67c0709a0dfmr825270d50.83.1793883422949;
        Thu, 05 Nov 2026 04:57:02 -0800 (PST)
X-Received: by 2002:a05:690e:a44:b0:67c:709:9d51 with SMTP id
 956f58d0204a3-67c0709a0dfmr825261d50.83.1793883422546; Thu, 05 Nov 2026
 04:57:02 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260806060727.191-1-getshell@seu.edu.cn>
In-Reply-To: <20260806060727.191-1-getshell@seu.edu.cn>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 13:56:51 +0100
X-Gm-Features: AclHuK8fnhCuqb1T0fFS_ASfWZzvsgNNY_vGXPh2_piEpskxhsQ1ds10NH8uPJY
Message-ID: <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
Subject: Re: [PATCH] tee: avoid accessing dma-buf shared memory after put
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Olivier Masse <olivier.masse@nxp.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX2V7XW+Yo4px4
 9OHGneIBaRmjppWPxsdCvBfitkZc5ckMNHRj6fMYBdE2bZEtVYcEykWoPmtjhZqnaAZmuv0oVth
 X5saxKVAdrHynY+B4R0KOi8x2Y1TmoE3lpQIL3qrgB83B3UV/4wtz7zbjjB6FV489DbggijGump
 xQhkY95e0EPH7LHTmaImJuleRqbvZfxtwFWfDT50DCnKIBs7RWXBep95eNbRQnNPBR6s10Xu9+g
 BCTZw7Lq6pOp3Sh124zl1FvJ1M7RsxJFYKPUsFP9JCqPOSKg/tPYnkMjYwp8ElkN+Hbg34inJNJ
 y8ojVnlO9IVhfN+ANHazY+NZVf+EEkLZInqdqATURD652l3yfBtx5xvL8Gfevli35+/7t+t4un/
 nlQvzHVuiMUjEfMW5ZPHmOEBvkNQ3fcPoaBY+BP+wDf/ob6iMKWpT3smYnzQQryhAsZi7IVi6ha
 Zs5LMu4gRSbTLqfQ+vg==
X-Proofpoint-ORIG-GUID: gKaewkNZHhE890Kymu4iifOciu5tMMLX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX+EZ+oK68u7NZ
 bUhyx9QcYPEftIrcysrO67u5g/Se1CGomWm91yNnoH9dsltyl1joVXxNZSVArc/2fES9jHYflrn
 Qs6uKtBNF8fNAK/S87GtuehSoPLc6UI=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec7d1f cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=X7xKr11vWj73--6tdDcA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: gKaewkNZHhE890Kymu4iifOciu5tMMLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051

Hi,

On Thu, Aug 6, 2026 at 8:07=E2=80=AFAM Hongyan Xu <getshell@seu.edu.cn> wro=
te:
>
> param_from_user_memref() obtains a temporary reference to the dma-buf
> tee_shm wrapper by ID. If closing the shared-memory file descriptor races
> with the ioctl, this temporary reference can be the wrapper's last one.
> tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the functi=
on
> still reads ref->parent_shm and ref->offset afterwards.
>
> Save the parent pointer and offset before dropping the wrapper reference.
> The additional parent reference keeps the parent shared memory alive for
> the parameter list as before.
>
> Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmabuf =
file descriptor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/tee/tee_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 1aac50c7c1de..489c39d5b35f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_context =
*ctx,
>                 }
>
>                 if (shm->flags & TEE_SHM_DMA_BUF) {
> +                       struct tee_shm *parent_shm;
>                         struct tee_shm_dmabuf_ref *ref;
>
>                         ref =3D container_of(shm, struct tee_shm_dmabuf_r=
ef, shm);
> @@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_contex=
t *ctx,
>                                  * list instead of the shm we got with
>                                  * tee_shm_get_from_id() above.
>                                  */
> -                               refcount_inc(&ref->parent_shm->refcount);
> -                               tee_shm_put(shm);
> -                               shm =3D ref->parent_shm;
> +                               parent_shm =3D ref->parent_shm;
>                                 offs =3D ref->offset;
> +                               refcount_inc(&parent_shm->refcount);
> +                               tee_shm_put(shm);
> +                               shm =3D parent_shm;
>                         }
>                 }
>         } else if (ctx->cap_memref_null) {
> --
> 2.50.1.windows.1
>

Looks good. Sumit, do you agree?

Cheers,
Jens
