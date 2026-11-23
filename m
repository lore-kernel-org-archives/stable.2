Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795446205;
	b=OXU9KdkG16KC+6o/3P/S4Un/zcfKdovnpW3JK79p5Hw/MLcylCq+bzKTNOrj5XEYd+lH
	 bu8ojTbu5QBUoE4K9RaVUt8nsVEQm66eqgAWqX9uSrl4WPGaJFQYea9hjcQLdNspv2+yc
	 z5ZvORWqQ5gZ4GTQOqgGlXdZvoPsycAK1KUtG9uN3DixETP2I+Kei4yF2AvnKAI9xtAic
	 12/BEbJ2KROgNCFnTq7qDOBb8FsAEbYKs3lw+bHAvVqLrSkYbRGuHaCzaMH5eeVbcp0na
	 y3SKFMQncvd9Fq0qxynmY0dNnZ2lS8UHeSq4R04a5tjQ4EEtyqiHjHAn2pPLxY1caKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446205;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
	b=rfbM+K+m9PNWggfKJgrPETYz/BQZcrsRnpwCQsEtEkDeKw/K/B0znKkJXM6i54BodcdV
	 spTgxe+8x+eaZ8y1aLlTg0STMSuXhSHeWJI5RY8D2x/E22/2aoE+TcJXQpbJOGRz8OG7q
	 MmDz6IrrH2lmVl4HBlzTwos87qrS2hGKQypZ/t0tU/pSxqpUS/3V8ikTqhBVErOKdo8NY
	 Ae7Q+FD+2c8+6bxCE2OlQzpgN6TjZtL9Qma6AKAS5+rbg2KaRRLckKQCY4QGB5TlKIQC7
	 kVBtCBIbhe6KbNQOBvHqzuTvuyymyLWVNOO1ONxrjFEmfc50sD38DT3IcuCp6UP1MVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbfO81VA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSVHDmP7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64B606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E64B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IbfO81VA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSVHDmP7
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLGPb1461376
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=; b=IbfO81VAygWqws1q
	TyYwzZLUHWgB64GgdO9dyaTt3zpAjoZJTDLgfEK+Re46q144zQ/jXm7UXcLujI3H
	3704UyUwCzMPStRZkWgk0SAvSYRVpYoQqPVCPMbG1rBBjNGXvQRthDqmm/VLgGmq
	eua9pk6y4yQJJboujmd9FOPeCnKeMLAi1zWreYZmb4BfbxKi6k8Usii2edWf3Qf2
	TPZ6mQvAySOhb7U/BEnLigjn1K43367diJYkpo40vAtzLfnyiP79fe+z1XO1Yckd
	yeY0KLT8BbSG1ND5//lKn9wXU+qJrzCeCaaZuhg7/Ttmcx3Impz72pohCAly1rYE
	5wYCbg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g9a1w4j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:03:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2f04561ee04so19445985ad.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446203; cv=none;
        d=google.com; s=arc-20260327;
        b=nmaZWOg7vcAffEZvib+7L8V1lZnDJE9pc4RZBxL5nXoTbw5Ka7yNQn2e4AzsF+jlFf
         7H+iV7ajaHi9hpKFQ7Ow/FGuMKjkc+d2FNzYsDuCUEV5amVf/QO8jJXUWH+JXcioF8fH
         xkkpfWpHX/npeI6iQwUYDJGA8qKohza/t563JponV8AOf5JjN2AurHxTdNOeE22aiSKZ
         mcO1EHzNDGQOH/vXpEi4B4tKDCjwGHKa5aD2kucDv2pfXrSKLTo2fYh1vfWrUcJ6OEUd
         SSGaQ0HV6nb4si8oPtlTNYV9u1k9F8s3Q3IvQ+Mj8f16czM5iAyfyPmivR2jW57iLlXD
         PjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
        fh=9ak+DxehurdTRRcN99DicmU5X0aBHdnZ7tp/iWfFv5c=;
        b=NtL1ZA2M1PyT1szDejLGABWQNqsDAVYd1otZ431b3+VsxnRILmltQcgDTqe1AZxAgg
         2TTudsGFuqNJaXcMeNHUMCINfGpWPc8eRpQYuLLgM0TWYLJYoFkROmGsyP0nuhjTuNI6
         bgMWE1zQeM0rhL/5OC6a+5nxwFlyHlKMDXU2lECLJySBQ05hSN2HJ+tOI/uR+WQS3bl/
         MdLSFAirfKrbN4n/RkxgBG+9+igV3dXzqXxcYVskV0sq13yHF+Jy+DQqsLVYHxsyLrLW
         7H735cWE1FuZzDMmaAxW4jzJCwWkzyiiBij/ZWZ7NlLCgLnSvb0tYO4H4pCIBKH9B6n3
         u+Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795446203; x=1796051003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
        b=CSVHDmP7FW2y/pOLoDB6PNBCVWcw3+h0ApgWjjBwGoeDiywj+f4NwZ5gjCsEM90OTh
         yWotG7pb6GK8viQ+bot4iKVZl+zwziyrqnt3qhOerMTFLaUizSbxru2WlldhG7VhihEB
         B3SboJsxLnj+JWm+vIwgpg9woP7vB/DJoDdZu2c3FJpoXTwuvCWj2/HZrFFxrdWoUZ9I
         w9v0mvcw5pzEa5jfcPTukaTo0Xoshl5lNhoBg3kIh06qcaTvRwHtmIaiHSlr2TCvVLbB
         EY9BHUaJO2sHPouYHdls/aHDfgCgo5LqJs9GXVN2ONmqveECgqN+CeOw4JVvgIvcGpMY
         d+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446203; x=1796051003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZmn/sNxwAfKWKSIqSCT0pljBWlXHOxHLlaVhxvwNo0=;
        b=TzPDFKEMPzya2UCbkPRHGj8B9YU6r6qTxPhsyb+Lnkx5hWppQ9wxQqCbMV7viTW7Dk
         rYoICx5fM6TPGXZjLDu/1CHgm6LcHFpa+jjZs1hbY3h6COrvykJ0ADngMFUkWCSI4keI
         EyR67Ycp1RDVr2deJEGK/eRLCS1kpYJGImZuCKUAD2hK8Yej7T4KJsbFlVeNPnyR7vED
         EYUZA5BPT4Fo6YqxT1199J6z29W5UbMeVs228VNBxH1aZba7NSsQS+94RNR5EUkWV+oU
         Oosp5DAzlP/XsxFZSWJOqrWBu+05SqzIiNvr10soLdYIgSAsyTlEMkQq7asLt2kW+QLg
         ZK5w==
X-Forwarded-Encrypted: i=1; AL+hErEYtWxOYv2USYWBFlXMmafWlUhV0ZZvbIytFER7VmZg/vS/8PNt60vam89w1R2QEN6zUmSUvP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lbDzmcwWOHmzDrJ5eE9kRAHSrfV24fLSEUfDY0vbZkF252DZf
	OIfVUD8+KeGendCTSPMjplmzRt90F01rXVHTfA55FF4hk0WHiR2Ungu0noTCGBic8BudKexLwFW
	Vjcp6N2SYshFtZF9e7agHuGtoHYzshnlJxMgC6sQYs6v09UglOnRA9zM2XffGZNNR8CvPpBRLkF
	T9jevykqmKelhhBPQP3d5O47tFGRCrgKWrOg==
X-Gm-Gg: AZFdTZekRlmSTZBIN90XZfbMOumdWTlIlnJaHbv5he5DVbhM+cRzSbQ59RWMWNxYoCl
	KTRoKeD2pjWAkbLwTtU+IdnUrB3g9/6+bYvK5HESwUtcdGTZIRcdFqPnOqhcEcmRoniHgMJs7G7
	SjSL6sYkyXpy8UBaHwbtVF2YIr5KjfD9grOB3CPzmbOjEiJ7oQv9IUwqKTfvj0dcPtLtq8336ek
	WahSj17ZX2H3ZEo
X-Received: by 2002:a17:903:1c9:b0:2ef:fcd8:df75 with SMTP id d9443c01a7336-2f03f18847fmr120968115ad.36.1795446202906;
        Mon, 23 Nov 2026 07:03:22 -0800 (PST)
X-Received: by 2002:a17:903:1c9:b0:2ef:fcd8:df75 with SMTP id
 d9443c01a7336-2f03f18847fmr120967425ad.36.1795446202035; Mon, 23 Nov 2026
 07:03:22 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
In-Reply-To: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:03:09 +0100
X-Gm-Features: Aa3M54p3bvaqL4-4P5a9q3TQOKbyz1uWNRpSG9PtFinKLWfQ4vS-W5Tpi3kneLA
Message-ID: <CAPx+jO8KYfvm+=UXKYZv+xBAmGNUU7xtYH9+cJRtOrnQh3GmrQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] pmdomain: rockchip: fix the probe error and
 deferral paths
To: aiyengar1990@gmail.com
Cc: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OSBTYWx0ZWRfX9OnwRH5iBql7
 2k/4+6SOZ05QN6vaMsutciUmkN00OeBAfK99e1MWkn26Or4HMrzB+BAWF5wXii0+9TEyPdpqAYT
 CZ9SOUlADAB9fYoewNpZLUGPK9pOpp8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OSBTYWx0ZWRfX/kv9fO34VLu9
 LHAU7av6moNSAVzxgjd29LnWdsNesNvGX6bCAVALE+cuoyQmGc7OVqGNnzciwjJ0/PDh6whHXGd
 i3+hhMxaAbbqmoRjIy9PBjcTqf2qotO+llC9DxTYCuxpjdEkKxQ3sCWjONqOTg8b5aaRQtie0OW
 +h6jCXcKinu/JIXq0omqKiEL0bLnEf7Ehs7ibCJrihnxPZD+xY9S+9t8mVwcSNI6Mx76OOU9gFg
 1axKW6+1cz+wMabWP6CLSWmEosHx8MEZCi3rN7YRSfobUyBC5jRfxsNfQyPY67ZJLqU+s+Nkk2x
 0j49/U+Qea5CeXj7RM7DXbhw8lV7UrgrqTFLeahtr18+goYGyL/t5obuf9q1ztybRGzxq6Wrzdm
 c9Fn2+Hebhe9zHAfmuQ7MrceYmmpmJeHuZ5iUtdl9vEnf4+2nHji2ehtq6qT9N6xUDyluppv59G
 vxSmxzu+Y3KIYwQFMLg==
X-Proofpoint-ORIG-GUID: tP5Xr5R4w288GjVtx2T7TTHCbTqOvvjX
X-Authority-Analysis: v=2.4 cv=cYJHPXDM c=1 sm=1 tr=0 ts=6b0455bb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=0OowS_b49qHy5rEh488A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: tP5Xr5R4w288GjVtx2T7TTHCbTqOvvjX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230059

On Fri, Nov 13, 2026 at 9:42=E2=80=AFAM Arun Iyengar via B4 Relay
<devnull+aiyengar1990.gmail.com@kernel.org> wrote:
>
> Fixes for a Rockchip power domain controller probe that fails or defers,
> for example on a domain clock that is not available yet. They apply on
> top of 1/2 of Yao Zi's series [1], which has to go in first; patch 2
> replaces 2/2 of [1]. On the pmdomain next branch, 1/2 of [1] conflicts
> with "cycle an optional power-domain reset on power-on" in one line.

This sounds messy.

I tried to apply patch1 on my fixes branch which failed. Please
re-base this and send a new version.

For changes that are targeted for fixes, please send them separately
from the other improvements.

Kind regards
Uffe

>
> Tested with v1 on an Orange Pi 5 (RK3588S), v7.3 based kernel, with a
> test device tree that makes the PD_FEC clock appear late: no freed
> domain left on gpd_list, no -517 errors, and the controller binds later
> with all 26 domains. The v2/v3 changes are build-tested only.
>
> [1] https://lore.kernel.org/r/20261105001257.1368266-1-me@ziyao.cc
>
> Developed with Claude (Anthropic), which wrote the code and the commit
> messages. I reviewed every change.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Changes in v3:
> - Split 2/2 into the fix (2/3: deferral, pm_qos error code, callers'
>   messages) and a clean-up of the other messages without Fixes tags
>   (3/3) (Yao Zi)
> - Shorter commit messages and comments (Heiko Stuebner)
> - No code change from v2 apart from the comments in 1/3
> - Link to v2: https://patch.msgid.link/20261112-pmdomain-rockchip-v2-0-5c=
d942a23df7@gmail.com
>
> Changes in v2:
> - Dropped "pmdomain: rockchip: put only the clocks that were got on
>   error" for 1/2 of [1], which fixes the same bug
> - 2/2: drop the callers' messages and use dev_err_probe() where the
>   errors happen (Sebastian Reichel)
> - 2/2: a pm_qos syscon error keeps its own code
> - Link to v1: https://patch.msgid.link/20261110-pmdomain-rockchip-v1-0-6b=
9fa6ebaa86@gmail.com
>
> ---
> Arun Iyengar (3):
>       pmdomain: rockchip: remove subdomain links before the domains on er=
ror
>       pmdomain: rockchip: don't report probe deferral as an error
>       pmdomain: rockchip: use dev_err_probe() for the other probe errors
>
>  drivers/pmdomain/rockchip/pm-domains.c | 131 +++++++++++++++++++--------=
------
>  1 file changed, 76 insertions(+), 55 deletions(-)
> ---
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
> change-id: 20261110-pmdomain-rockchip-3497a2e7fdf5
> prerequisite-patch-id: c2f0c5eb6651baa744f66342db63485a6685fb71
>
> Best regards,
> --
> Arun Iyengar <aiyengar1990@gmail.com>
>
>
