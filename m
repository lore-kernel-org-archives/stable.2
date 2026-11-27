Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790625;
	b=pd70R5+8S5SEALMZeTZGQYCNb3TzR1MkXkSdkbZwT+I1RtAWy/xMYOJ81VozyCZvEbB3
	 v0vl8PWaJFiovNedqWoGxo4uz2VFeBkVSjEg3saLT+o45flb9+u/tpMaANNx2NAiwMnSu
	 AwpFBsOrC8r6f41R7l6yFcQDPMAEJVu1Xi59ILqlLUVEpYqo3kIushJJCOn3gzkBYq4Yo
	 Fmhk8K6aa2yXlaBezlQbxx+AcG8NBI9/ZomQ2KC9flSK3oEcr10NNQIaeQBooMnGStolF
	 flcjKx2qQzMDetHbUWfeV0cUFiOX4HrVKqMC1KZnAkVZVmq7Rdob3bHsJQf496wtEFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790625;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
	b=B4H5mf1htvjNlMqxNM/uKxAfYKl3IX3nPk76MuBFcqjjiqoRqjH2cwcQzM1YyiGMOIes
	 q0G8tRiJxxjyY6peRvWbrkOjps+u5xXQLUhi8EFcHMIs40ms7SJMZd56H21eWGdjigBK9
	 qe8z6Djh6mIEdPYv/6052QU9TGHxuRwVwzOtH8Q54gghoWDfDBF5jwpXt6DIZ0E/Q0pZB
	 b2qNHLKd43HOxixhHooK32g9iC5/W4lp5nNkyrHLRxj3xn03oypFD24O+vj53ysurWk29
	 8yHowbopMy112iZqmuMUFGwZyIgV006U3FT9mk3B1taHVtBXnh2lwvxUFttAkiHsDdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiuwCcmC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R38YHaMA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D440606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D440606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiuwCcmC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R38YHaMA
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1YWO1971366
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=; b=CiuwCcmC0Nw6ivfM
	V314dM28Chs5bIEhdvdUrGJCifYOGvvRP8jGtT6Ultns7ncjT114LESxPipJ8c+J
	o7y6IQDKVhs9JOYOnklwGbGNVAhdI7nGAMFCWdb6WYY2HQOcTC9/zrqTLr9sxKiX
	t7WcTcZXzHrTRXpRpqVo99eyZz0fbVM6L+rMqG4PlnuJAVqy9OO0nfd7TJ1pmfqQ
	sqyH7Vq+7nEgQL1O4JduIcXNtmDT9RXX6iKolu3Lr4EjWFUwfo8h6GlATVa4AOlO
	wewfBpN7zE/pnxUtw4QX7j2vSr4E/76eWpzm3KPdiRXs9+7uVOmY/FVAtDgFvw0v
	wbaxOA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55udwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:43:43 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b4232374d6so10931816a91.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790623; cv=none;
        d=google.com; s=arc-20260327;
        b=DRKTnSOxTbR7yR1CMm7zKqjdNC4PNg8Fr9MNi3ssUQwljhQabFTNSrRIAEAYPL+Tyy
         7XxQNS3TFUf9aroOer1x5Lxt8dap+iGMNNRalAsK/BBmemaFh2y6iM2ekIS9w32aQBzo
         ddoSfQYgvTjXuxDvMgaWwezElf7l8RUoyDs2v3LAojaOOeIfEkydlTlTvIAMCAjqGmZw
         X56GTWfWZgBNnBfbBfTdP4sdTLS8+rpXuLLfA5gQq+ME3AOBKYO5S7Gq3ze7dGSPm4+o
         XgM0486uyeJmzZN1A2rdMee2vriMBgRlU/0i0PAFT4BCW+6H5KxdXQXCGxmtEuICNl6U
         fFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
        fh=RbWiC4YPjRSPX+r8Jg9qKetpCHEY/5vSrSZIiUtUD0I=;
        b=gkQvrSdkgMwlGcHy9tAxoGDfU75sfl/rrfnM72PP/yxmKftWzlVrXJ32wycBedElDA
         JLjlojSdLPxPVR9HM5j0P7EXEOHtOhqZGX6dzrKkJm9EpBa06UlAvcAEhoT/wltycMV1
         ORNYUWgotJWjRw9yLjv1jPRUyKz9wwFiuPJ6K4ZLsFDdyRwo8l8MlkR75BW4XXVSkF/5
         XvlNo/hAFD1/yCo98UI5JzqxX8JJIM1v2QwCge2XVP5FcVUP+X96tgIQ2f7b/DBhKbDU
         yGL0dnzNEcuP5nktpysLk/kgcry4IcabCbAQKc5+vIr6E1ZSGcQE7c/ODOBzg1WQlB/s
         N6dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790623; x=1796395423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
        b=R38YHaMAjBXNHcsgHJgxFblJfPczZ7buURFvLLDQOuLY6BOBnneYPoRX57McczePFA
         /e7Xz+E0FTYgyEYg8pp2f8BLz06b+NEVt0ClvsXsSh7DIhhlhK3PqIs9Et/J0Rt57hB0
         nTAMQeaY7Z/QRp0jMBPGBR/ldokEd5aNQY1xfOqi0qzlSGWzQJAMEI20wpKsPH5MVCIc
         i9saTl+QwwS9zDU4OiA3Lm6+UHT7yO0i5ZzfDjofWnu+Hx9xhgsF+xXpYK4YXfT7JzfM
         YujHl5za/1nr9Bt9YW2bw62AozNcshyM1CyV9FJ6pMdK6zOx5+/MBHkQk56PBhj+Yw8q
         PhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790623; x=1796395423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WYwRYvmg1yr4hFV3xXwX6VX9Ocs8Qg1v4HgcCvCbLoE=;
        b=AgJgi8TAyj8fEoyRsAA4nLgsBGOl4O9wx8jcwu+DxddzNR8X5ymBevfgHX1FvF9Wfs
         nOxUk/vjHoapr6oDgyfzMzioU1OLmvvjbY8ZhAkxH7dK9vgOMs3YXHA+ZUhQkSkP2LrT
         3CA0rZDgT6TIEqBgXlFrElNo33RBj7z9gWNZnMO0/8drPyL4hSvknPhcrZSsR8difvLX
         fe0JUpedag8LOF7WiPtSDkMIV0o/QUa94ocdRJarDz9lzxS7vXDmDu5skG1sZ62xxDUG
         Sgn2x61A+Y35YZOhsJUIwAYk1p1RF5pJHiU5Vkl2N6gGL3L9wNXYo8FhwAy/gr5nqg3B
         nZtg==
X-Forwarded-Encrypted: i=1; AL+hErEqUXmUVHgmayPwizzn9KDUAK/iqTUu8hpeg8yYoGbswqKRP8DEnKOR6sSvN5I3CUVLfT2bR0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ma9UX5CWXbaMVNLpkJSghKyiV9AezIs7Jymaya8SdmjsUIMmx
	gklsoo7N2m2LkYNxRPMsMT2pkK8FosP3N0Yycq33jDpoRvyMc+DcSMy6k4BpR8tDVM9F8gyoM/o
	WPAMY4iYfqWymdtXYyFYhnG2oHqBjWSCZt4w+bevI8xoB52CHjBoykF5ZJrrOFS0KA5O/4GbWD7
	/td893Nr3twjfyXcP6eisCJ/WbynuQbEJYjw==
X-Gm-Gg: AZFdTZej/73dpdYClS+wd78An+HG1aiuaXKFLjl7NMXt8/03VO/oDpGYgAgHnXNb5JB
	xUji3BsOF4NQF7gnTZ5hzG8M4Ce2Y22U+t4LsSDXaEWFf60R+so7hPfr9+9q51fDgq12l5BtoQY
	YuavNO+kuBF3wXLp2qJom2LAzEagsA+12Bk/vtWH3V1bFZaTyxaY5nPZas5w==
X-Received: by 2002:a17:90b:2e47:b0:3b4:a63:d56d with SMTP id 98e67ed59e1d1-3b41c7e119bmr24623434a91.1.1795790622831;
        Fri, 27 Nov 2026 06:43:42 -0800 (PST)
X-Received: by 2002:a17:90b:2e47:b0:3b4:a63:d56d with SMTP id
 98e67ed59e1d1-3b41c7e119bmr24623401a91.1.1795790622421; Fri, 27 Nov 2026
 06:43:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103192345.647483-1-kernel@picomail.one> <20261104054412.8310-1-kernel@picomail.one>
In-Reply-To: <20261104054412.8310-1-kernel@picomail.one>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:43:31 +0100
X-Gm-Features: Aa3M54qKOWtbP_f21x0lELCetsrIy47-wTE7FTFr0KH095P1fDzVSPwkO9ID7uc
Message-ID: <CAPx+jO_6CVfC+JsieB+u1z3R4b_D7GcOX8anXfgmBtd6MoozRQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: clear MQRQ_XFER_SINGLE_BLOCK for new requests
To: Jonathan Schmid <kernel@picomail.one>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX9D+15GfOnPEj
 Ai1i7bR/1CDVgYCuQ4a3nR0vIY57Rt1ba15RBM1yRzWwJMaBd7kauH343wCDRP+NqwO5azsttfG
 T+u8tPTwb9/ifQwA50njxGBhz+ebNvI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX1RRZHShySiKV
 T3BPBw28sZcikKrKKNi97BOS4L8ATk8L03wnGFqcIT6dc/SqfjzLtCLTNwyJ192TndsvxYiu89o
 mKx54ANAHYMZMMlx+1leolFIBvAfSc1EqrISven76l0Kei3lQCwX77SQJNfr7/au0QrgEgKb+6K
 drIMQeNLWmtUNccI+pGpCKEgRvY0xhXzDrNo6dGVRb4C4a44Agr6zWG7GmJyCsW/6OzlJGlTs/h
 miYFJ1tyluOc+7AsvTuynJe7T15N0Eddj1GBbm1Mbg68IyQZTFYUVw3hKlHIYOt4QDKOZ/UNzbx
 xWoWKDw0t8ktc0Z4z2hzbYn7oNv5qCWpFhijFO6jV+X0F5SFgJ8OUvhlD7mave8x6FVvdD0cvUY
 Sffv0wMUb6ERKf5yFpYNGbkvt259AA2BImzBfltoWIHSyQshSaEEgJev4pkH4tyj2yW2RANMOT9
 a/yMoq/lD3+PhozVG6Q==
X-Proofpoint-ORIG-GUID: hLYue01K7mf0z-qRcxt5UfZHfISaSCE2
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b09971f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=eT9L358XsF3sCvS_DZ4A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: hLYue01K7mf0z-qRcxt5UfZHfISaSCE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On Wed, Nov 4, 2026 at 6:45=E2=80=AFAM Jonathan Schmid <kernel@picomail.one=
> wrote:
>
> mmc_blk_mq_complete_rq() and mmc_blk_cqe_complete_rq() set
> MQRQ_XFER_SINGLE_BLOCK in the request PDU when a transfer fails, so the
> retry is done one block at a time. Nothing ever clears the flag again.
>
> The PDU belongs to the blk-mq tag and is reused for later requests, while
> mmc_mq_queue_rq() only resets ->retries for a new request. Every tag that
> has seen a single transfer error therefore keeps issuing single-block
> transfers (CMD17/CMD24) for the rest of the uptime.
>
> On an RK3576 board (HS400ES eMMC) with occasional data CRC errors, which
> are recovered correctly, sequential direct reads dropped from ~200 MB/s
> after boot to 3-10 MB/s within minutes and never recovered. The host
> registers showed only CMD17 with a 512 byte block size. With this change
> the read throughput stays at ~200 MB/s and writes at 60-90 MB/s while the
> data CRC errors continue to be retried.
>
> Reset the flags together with the retry counter when a request is
> prepared for the first time. Requeued requests keep RQF_DONTPREP, so the
> single-block retry of the failing request itself is unchanged.
>
> Fixes: d34124edffdb ("mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both rea=
d and write recovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jonathan Schmid <kernel@picomail.one>

Applied for fixes and by re-adding Shawn's reviewed-by tag, thanks!

Kind regards
Uffe


> ---
> v2: use my real name in From and Signed-off-by (Greg)
>
>  drivers/mmc/core/queue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -301,6 +301,8 @@
>
>         if (!(req->rq_flags & RQF_DONTPREP)) {
>                 req_to_mmc_queue_req(req)->retries =3D 0;
> +               /* the request PDU is reused: don't inherit single-block =
recovery */
> +               req_to_mmc_queue_req(req)->flags =3D 0;
>                 req->rq_flags |=3D RQF_DONTPREP;
>         }
>
