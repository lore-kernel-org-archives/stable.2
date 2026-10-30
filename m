Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793358008;
	b=FKyftmYmK3ARFPR/oV6NlcsCUi+h6W9u7DGCtk97OhE6cP3Pl14f2gBxQeaBokGzHkLe
	 1RBrcnoNsCyGsS5wR2zKq5yae4qz5xbElp9Sfn9DqaiWBRFdi1fqoyXv6jy/7/FabsyyF
	 ivGGeUKV+DySTHs4cvoi5NHv+xjTvd5tC26QlTLbm9eIZORxvhgPco3HRDh+WUVLcuON4
	 oNWo86brOksNOMBCVkN4A1cU5oWKmjM+qx81Hpeg96PHhx80BjiS2k/Wb4GQ38ALj8VJO
	 gPjOFsgc2rzSz6Dl5ROrXuaVMfUGQJDI6DBnZukfbkRXvA4V2B5gTHpyoeF05nIMZQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358008;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
	b=REl5iLYdMo69Q8hLTY9akuQUazB+lgyz9OvvmSIAz7Eb1l7IwTDY7xdcjL6AYYi3oSko
	 ApQKLCLPf0cnjql6MEybC5ZixTQ5sJSeg293XtfkeZkc/f0nklqdPYI2DgbxbmcRYIo9J
	 XnRRcc0xP4ZmiLl1a0AObiUm4AUqWcUMSDNBsz52fxgDczrsvaPQLOhIE13dg5kUTm7TO
	 lLS4ssVoqel/badhdZlMPuKQ/uzzF0J5eLIKx7ivseREh652FlFV3fPB1n3vLa9z5OyK+
	 /jsHhMyzZ+p6pJpexPwq+KdUgInHre90WQq8Dk3UPed5/P46w3eKPgnHc/3WCAdtdVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aTzOVivM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LmluDg78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5C606AC3E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E5C606AC3E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aTzOVivM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LmluDg78
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U9cCnd1948794
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=; b=aTzOVivMPp0yWKdU
	9LGLEv6Ecdv5Kov+N1E3GZC9BjPJVT9lzoQmm5SLp4p1w7SbyzWmSKKV9ZdI6vGV
	MvBhZveSuOzvdzRSWF1fiSEXOw+zp0rE+dXiWlR9aYBJqvkHlUPtpSZx8tfnTRT7
	WOTpxYWBMbhmqqcSVIMnabloXlQqW+b0bpkWRBztpaJEQGt6PaZPtg5mR0jYpPJx
	FmOAqUW/84QlIfhRZAQMPNy5MEnaABH786sBNXj2c4es1H+sYf89OXA/h40VgajG
	v7h9/zjWQIsHZwBEXPSIM/4Ht3+PlxxZd1EccLcPKF8omnZWfDobgWIL1gSkj1V3
	zM97OA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6paj85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:00:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2eac6e96bd4so10454915ad.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 04:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793358006; cv=none;
        d=google.com; s=arc-20260327;
        b=W1bF8Tx80e3+sEwGmQAECzQQv63mzcsp2oUdktF1V6kw0dtCFt4zUBtbbQ3t+3L52g
         KxHScfJCIWkp7Z19Cxt+JxC7VrNLz2dIjQmwH6TdJE/RlwUKEMWlrg3np+BtqYDAJcJu
         Ji54QMk0B2QxShkqnyDaVk4tJjrdTrg0HFYQFb+Dl87q8xzd53EEC+rKOceHjUh7qT4r
         u619+mFynTccTTLhyt646Fkr0mtvrPrSbDRIUpE1iVgwTN9ibhZPFoHMmtK5xu7ojErv
         FMyllL4Ug1p4LYwnNY+VkHXTSobOc+twOb1UoEK/al5jSR+bNhjWopTFvYxbNDIkGFC9
         mXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
        fh=REpgFCRGvVN5dr/1vKT9uhJfnTQ22E0S0Jj72qD1Bjk=;
        b=r16ym0hKEcixahZjWmUbp7tE/5oqpepf93F8bOpw1Aew0o3Gq2WnSzDDD/9hq3A7y/
         QHHv9G3GUCq1j/wrbfwvN1mRjSGZP5HTQieLDYgrCY8EAAJWT5ArsZM25RVwdqjhNTSD
         Ve440QaCm7ndsncQVsNUT9kQd6kNCR2AI0eSDANEOUXkllryJXLDxnQf7UZGxZ20E9Rc
         +MWoi6z//AJR6br2y0mSgnWMZGZSZ+afObjyJtPnWHr9vA6jV6LXKzWoqsRum9m95PXx
         zeOjJC1hqDoVDo6zkisIRo4fnBRa37W77NK3nglPMKmhfVMBoidn5oJFEW/n61/YXZy6
         cIXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793358006; x=1793962806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
        b=LmluDg78lOffrPR30CLZKM7PkpMEWJtTgCh8w4/4Kn0PDP6S0BllKRt6R68To9+vSO
         wxzwkly0y9TMLqGeTKKrHfTG5h0ovfVGTiEzFvHqsLU1Jr91uUJQrmmZ3+vKEIykf3Q7
         vKWLSz+XLXeVXhvnWTB9he0sEAMc1m+OKOlUMWs49rr2aTCjDYq/W+4GuibP3Et/ZKv/
         DoN6ZK8mymkSIDiOcS9WgqiHZb6uFIsumCHUoUk7HWRzezbZwKKYERogfZt6mAujo7ID
         8DbeyGVqhNSQLrUkkZd2TTRr6WyQK29vO2J2eWKATLZg+fkNJ47BdRbu4TqhbON2l4e0
         mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358006; x=1793962806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PIuOCX0AHVQZHCW56MurqyskT5/roJv4n8HNkBO1lr4=;
        b=GJ2aLwhvuUYdK9PtWWqFwfAasXUqcZqhW/LNfIvbyU9OIzx3XugS39Ny0yV+pAv38h
         x+6NcFPCUayk5Pq5491I8XorrMQXJFaBdKU9QTYvMOJY6Cu371OC+mannQ68l57OOURR
         H67l3CnYQX27PamGd+kUVli1O+nTzjV+PE4zdMueFGTW6ZhVV7S3jpX9njrl6VlfvIrt
         JkRJ51702Vxf8UNhqrkn44TfaO03nYXu9U+fx/uohOJaD+3v+6qzBPRCXc3XSK50eUv0
         dixEW4UsJs3vm9HE8YQS7Wr7ZPEEsbxT6gZmVb9IzPqDnlq3KLxZDKkcWJT7PvLVEBM6
         1/3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwlz7BsBMq3BLDLzpWwcokOwR87dRnW4Z6QxMf8fHF3iemofW9HeWbjuCrywj91lU2Pq1fYK2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi55EPta/l9s1fNKJdC51KI79VIXqNC0GBbN194LCzCwEqJQJH
	YZ6C+gVrKCBlHAM3IVLuk+CY4UG43RmExsT2uyfWY6NEj0ckOaehWpv4OQ7GJGDZkF7ufbe52R9
	oaj/9If+TVHu/g/pixS83YGBdxNthR5e9xK73GAPqmWZwH9WOSittv2RinYXmb0+OhyK777GZb6
	HQMMibxhcJJP/WsOmJ/Y6fui/eW6FYIlnzHWBEVVQfTA==
X-Gm-Gg: AYBFou3ie+3+RQlLppUG8vXeYQLTdzGnSXrt+Q49AQqaSYol3A6W87IxfUBgMrmRTrg
	7SU48X8ZMxEDiR/Tt9fLHLwCesk0f3L6gnwrzwiSbg5cjcvq+glNX3s0l0Zmellys2socsibrsR
	/3Xn30lvf/7kUdMf2DOwuph2vMROP1pGytr2oaHK/ZZEb6u002NZAZsHvT0w==
X-Received: by 2002:a17:902:f785:b0:2ea:238c:4451 with SMTP id d9443c01a7336-2eb364b499amr21193635ad.30.1793358006473;
        Fri, 30 Oct 2026 04:00:06 -0700 (PDT)
X-Received: by 2002:a17:902:f785:b0:2ea:238c:4451 with SMTP id
 d9443c01a7336-2eb364b499amr21193275ad.30.1793358006004; Fri, 30 Oct 2026
 04:00:06 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016163707.3508-1-anferneemelokc5@gmail.com>
In-Reply-To: <20261016163707.3508-1-anferneemelokc5@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:59:52 +0100
X-Gm-Features: AclHuK-BvDlghJYUIO9TuDP8Rn85PebL2VkhT0kLOMXOR76evk5RCctsK-_4c1g
Message-ID: <CAPx+jO_FV4Cfms7HmfxGxhtNuME6NJ8Vgov1P+AT+4UtJOsqAQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: fix DMA channel leak when mmc_add_host() fails
To: Anfernee Cao <anferneemelokc5@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXwebI8gRMkJxZ
 R/B7+BgCVAj+bB3uh1KBxm4cOOgUKu9Hd4lznaeoJq+77AB3BQhjQWEZcBAEzTIG/uDxnBb1eJU
 yTPjsHKhIeCVH19bkXfLBDskyQZTvDFfnePrIcSmYI+UGMTfseivx0clGA2Sdp44fvm4dbStFNq
 fsNj9fXn3g3V4/XJpFb1FpbTWv4C8ekdambrwP5JYBxi7ccvPm7b9sxjNmaRtWoSM86Yy6p80nA
 KCcsVfexc8Oc7CtDeue9GfzkysohHQHTBEkoR9nQHQ9qE5Zs0XduzBIFMUNXbjq2YhTZt/h2a24
 hoVFIC3X8xms6hsh4Fp13Mh3YBE47hhv/sI6lC7Gf/IwAZO6GzNDvtTZwkZZjRswgZFI0h4p6fZ
 RG9geAFcwX6e5dgAY9mj000EOM9izvoivPdvV5jcr1GL6yWkDmR7CBZfCJviEabQ1roytu3DQ6D
 eG4aofUbaBVFsfst4Jw==
X-Proofpoint-GUID: LzJ4rpYzZDCXbKJ-RDwDFT8ygzCj-e0N
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae478b7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=rFPXIUPvEMN7u70KbzcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: LzJ4rpYzZDCXbKJ-RDwDFT8ygzCj-e0N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MyBTYWx0ZWRfXwUFt+iLsNprY
 IQsM2PDgn7Yf2KkuJlmmrTye0CCDH0ilz8NqQ9uQQDmq+MBV2Et/dBJd+ocB0hLJLXO29qQOaL7
 NfOq8N0SrUckGf32pQS5pSFcFjn33wA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300043

On Fri, Oct 16, 2026 at 6:37=E2=80=AFPM Anfernee Cao <anferneemelokc5@gmail=
.com> wrote:
>
> mmci_probe() calls mmci_dma_setup(), which acquires the RX and TX DMA
> channels via dma_request_chan(). These channels are not managed by
> devres, and are released only by mmci_dma_release().
>
> If the following mmc_add_host() fails, probe jumps to the clk_disable
> label, which only disables the clock. As probe then fails,
> mmci_remove() is never called, so both DMA channels are leaked.
>
> Release them by adding a dedicated unwind label, reached only after
> mmci_dma_setup().
>
> This issue was found by manual code inspection.
>
> Fixes: b38a20f29a49 ("mmc: mmci: fix return value check of mmc_add_host()=
")
> Cc: stable@vger.kernel.org # v6.2+
> Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 416bdb184ed4..4db5c55b2700 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2477,11 +2477,13 @@ static int mmci_probe(struct amba_device *dev,
>
>         ret =3D mmc_add_host(mmc);
>         if (ret)
> -               goto clk_disable;
> +               goto dma_release;
>
>         pm_runtime_put(&dev->dev);
>         return 0;
>
> +dma_release:
> +       mmci_dma_release(host);
>   clk_disable:
>         clk_disable_unprepare(host->clk);
>         return ret;
> --
> 2.54.0.windows.1
>
