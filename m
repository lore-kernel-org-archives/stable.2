Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792491320;
	b=Zn66w8GT2vCW+3bZ1AnzcuILD6IHJ9lqf+OceRc7B2g61BbqMNcFMnSXM3WhC3UPSvaQ
	 pqnY4UpMTBJ+pdKy0SWudZfaO32Oy+pZfcz3oPFsnUhIehTMRKL9M0K9b7RIHONrEnrB8
	 SvRDRja9vMYT/p5QbG8gzm60aWWW0MrJF0H4WlT17tNMv+biJ7G1ufw8sLUlDtWK274Wm
	 nchIXm/75VcDkjIIbWBgbQJN37v6fAIkDl2Lc8qgxuLve7tTVjSjdEFQYhscsNUa0jnCY
	 c1/mBK2mCZSZoDSf/SbSIZqirlCaW4a0av0HbybPWMr/hL8bRHf+vAKbCy0QmAoXg6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491320;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
	b=AGujB+S7WLJBtFi2VNHewiFkqns18yfchCui13052rRhUrsOFMGK2mMBHgykYOwaY078
	 iChv84bM+TcVqjxHUEql5ivje7KexFIxmsY7SKO0vtaVgF8IDi7L2CLVUBzGR+syiJn0+
	 A5/IL+x1QgZPq5mtqElBn56RCBhusa5ceKg9wFTYczIY4OHf652ZXtQlNAiH4teLsA8Wm
	 01U1kzt4MLOBPLP0kobZv+7exQjeLBLY7VPcbWJghUQhFnVOQSO4Cigy1pZzMwz9VzVj8
	 3Guy/ydwVCk4HvRfj0X2ulNgcu3/Zwg8xwlJahF4m541EtwLyXGiHOaGGx/Vpzxsjig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UKkTd88o;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ulz5B1US;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C379606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C379606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UKkTd88o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ulz5B1US
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K9UrPs1258011
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=; b=UKkTd88oLwZdCd/+
	YCxYihHaOby/yPYVVziRpjuEbPJJKmoW5Qq1EKX8mhlUbr+UNA4Rp9aBTauxsV7U
	q+QAdtBVdkXyAs4ui/EUUREDU0dSc7H1CbD2lMHucZGIBbY69/eUavQu1/ttygVB
	L5uf0QCUd2auv1Yox8L0OviRJMJf6rPA5CvPAvX2ReTBCM7TDtqFKGI7FI8r7NrV
	IpxKEll8pVtkdc5GZVr7wmMW8doXKpFi92V/jknOgtIEYOTXntihyQnCG8I0pov3
	pgmn2yo7SFv8/4wS6oFvnSdXuSW7mkoHv1Zr23dALiHXYlKdpsU8VGBRIVqkEdXy
	uNy3ng==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n2126-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:15:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5337ed1ba44so62641771cf.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491317; cv=none;
        d=google.com; s=arc-20260327;
        b=mqCWGOby3xO2mIkCxoYg2VtqNPp0LSmGRIJB/vSej1vIlGv/FfCAlMPgjstQmnoMKi
         jtdtraMcmKhI/tckCmlh+Jg4g3EUQcUtciYFzDXd8aP3x5VfFMl+u8Cj0HMLG9HmD0/Z
         0SjJpItOTN3GEXYz4PmU2dudri2zw0Dlq2XRb1YHicX2E0aQ/h6lYHv1gWMyWmNky2hf
         mM+o4Yzqbk3vPtko3n70A2ZeO1UDR4fALXzMnKzp5Zt4R6Yy2p6eEuptdqrh7nbaCd7Y
         1FbkGqBf/f0tj4S27gB0nPxNsqiYooM3PQpwR232ndAWJkQRznMPng6cgpxCzMnYPcu/
         ysvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
        fh=1MvywIKE5g9vKZtCtULiANUxL0uPrqsbpJDMVwBbTN0=;
        b=BSQg8NT5FNBmIxWznngyD4VOCAFJK4Xm5PZ/BiYeUGcqpM8E/cTKpeFnLiaBjaJqoV
         w9kqImrsAcPnC25qAKSfWWYGMJ80aStPlGUkOM2vvk9IrO687BqeiglvGIoXL1aeOWCQ
         eKBRvK13608VSR4+b1jWdOuGtAKnf3qxVAiFQJc05a9k5O4Nhv7t7MhXrkIfNDz2JRhN
         mN+B3kd1TJaNy2w/TpRWXsGmRcbYYWPrk/4iBqmKD6bYDm+41UxbyVfYzX47yGWVMlot
         Zj3bPTDgn+MUygijQoTy/nmXndk8zoIxLwEkPUVgASHlMKvSh/b01jY9DAgXEf2WY9br
         Cu/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792491317; x=1793096117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
        b=Ulz5B1US1WxZAdUJUv8EZC/hYQ5/YRkEuT3q80ZV8FVNrib6/z9JF0vCH2Fo4zoeNV
         9n4k19tTy8OcPQjscNIB6/X5Re549QL/XhXFQbqwumqKebdiM/G5YaS64HMeWDkP/k9l
         wRg6bQX+5Yuku3yyg1GKUY++JNirktoDdaYOAJMlmrJmnUBnj6/JBCU2UeOMCeYNJ12O
         8zo9UVcC5Lq3uk7ZGIdDe0SvJwUoaRXMyFiHCgyUEU8iVGPtW9HmH6r8qyPcLVdegRbn
         qAoFzICDUseH18WfbiSht9kS0m4xDQuNn0LyfWfdnITVE8xf6vWTXCB2lAAYAFQ9komP
         AXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491317; x=1793096117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USzUAeXmvNCRnE9FctU6fubUlHkhva9uo5i/eKw0KrI=;
        b=CIZzy27KTugYWb3A9hgY+ZMLqwYIJFc3SSD/hLNMwr/LunEda+r7bH9ct8OwSO6AF+
         d20MR+OP0Ows//re5cYq+JIqvGFrELx4MfJQqldN4RX8mZ2vNzEgwSfbt4Odvubm5x6L
         3pgQEt13R6xFCn7+bLQqRZJB4ckeq8STtj2AJ6Tny5GTSrE0KWSgnZLQ2K9Rh+c/x7sG
         B2/ihbFSRdIknrrbl4I6aJkb//8OGbBKIJcp6Swv/ezU+nOhkoeg92B5sAYWZW4IFKDc
         3zRZ6vJrhi0qIwEuqXiCXp0Yah/qM5DuIKoTvfhzN8FsnKAO7hZGX8ZzqSHFxfHC276I
         WQRQ==
X-Forwarded-Encrypted: i=1; AKwUvByksoCtBFDOYDvwIdv3qOoDMwUwh7PdMc0FeylDfWPKNPai7F8Sdt2IxREYm6n5K2sUKzhGisM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdRWOpAqnNBewXJDAmakizjSghI4COZ+qESs7N2l+WNdsyf/nK
	VyO9fcrM2kzDEFfvi3ySiKWc2NG2RadKSutTnIgAulj088P8qDqlYHDUASUcODXThDQP9lczVKi
	jTCOrWUSOEsXcaA+wz7s2mDzyaIl0rVZ4rjh5IHSo/pU+poz/ruCZ5u7p1644LLpGZGV2bQL8+0
	aC6JMjd2BfhkgVjdTnjC3kub5nyJnbT6tJBQ==
X-Gm-Gg: AYBFou0pBEiiy4XXd/bzqlI4h04r0nh5ndx4J+KTggWVctxErxn3YvncZAWA9XQn8IG
	vwT5H5ppDBIsl9L2UIDleQNKvWjQZQjG9aHS+hOYkxT5/UTvYhE0WRERs/lATT9z82oG4eE4UIF
	+slBUj1SYi8pdzFHItyYwCiSPsHu/LfVpFRDMCZHt46hCE5XsNDoKw8mhznknvYAxNDigX/UkrR
	I90kvUEGQw/9qBKuia9jq3psL6EXL33BfMM7DcW+iFpLz+ePZlOIVgCpi2NdsAgOcfUdzyu1S0=
X-Received: by 2002:a05:620a:c4e:b0:93f:1f22:96a4 with SMTP id af79cd13be357-93f29cefa8cmr1720594385a.29.1792491317497;
        Tue, 20 Oct 2026 03:15:17 -0700 (PDT)
X-Received: by 2002:a05:620a:c4e:b0:93f:1f22:96a4 with SMTP id
 af79cd13be357-93f29cefa8cmr1720589785a.29.1792491316829; Tue, 20 Oct 2026
 03:15:16 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020094254.4017726-1-liuc63@xiaopeng.com>
In-Reply-To: <20261020094254.4017726-1-liuc63@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:15:06 +0200
X-Gm-Features: AclHuK9KNDkqLpjluDp4MS8p0mVyq6DiUSCMyPi7A_OSUeyRYLDop--oOo4-vxw
Message-ID: <CAFEp6-3dycfwn-2O3X6tMYmYuTMgDgoOgYrxGv1Qcg-F-YZ7Lg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: validate msg_head before indexing msg_ring
To: liuc63 <liuc63@xiaopeng.com>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Fang Xieyan <fangxy@xiaopeng.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FKs5eZjqz091NaAVHkbzIU0wmq5g-HXW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX2/ehsVErKtaf
 /Mbhoji/mvkrgIepszhZJ+TykXa3jKnEnxvYq1DQ7Tn1q39me/VwEWyJe4DKYUYsjV8vuvVO7J4
 boLxfpOk1ATW7fqa7pE2yJ3hftqoXkQ=
X-Proofpoint-ORIG-GUID: FKs5eZjqz091NaAVHkbzIU0wmq5g-HXW
X-Authority-Analysis: v=2.4 cv=A5z5rKWG c=1 sm=1 tr=0 ts=6ad73f36 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=laIMyccDeTmSpVvBuxYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX8VjhxQ0jeUhE
 NTe0RG72ccS0fAYhPmMHVNvQhxXF09ySf7DvdSnWVHFLLy5jV5ppnP3X1P7+zlloG6jiMy+65sP
 Q53opFz6PJ6ws2F2JEEbNVzYIZmjzjFUrLuoTmq4+f+666ungU3zHKwo6AahjEo+PvSqzDjW5eD
 3bRjr7MaJs9u0GlG4dxUiOuH52O2MWu3ByzDnFEfcJCTVK33soj3KKpcEVkVjkons/oFGw5YX6W
 hywIqyVU/mOBJpe7RWtvHgCFw0/PlF+ramEJvgJsqGb6ZtD4O6agRP9cAkaDqKWVATLXCMwF0s0
 HFAoEyZFrV+JcsziQjVk6YJDcuN00+X8zmAd/MSbyhImiUuAZ5RqTuBrfoo4Y0t0GNqSLKArb3Q
 9TgzhlHvzmWa6ZxubIdhf8nAtkQtNcvVxWmghtFFEkAymCFvepFmvUQBcLnlxPmjHCv4saUDtU2
 5+0i1sFPJ6vbhxsp8Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200040

On Tue, Oct 20, 2026 at 11:42=E2=80=AFAM liuc63 <liuc63@xiaopeng.com> wrote=
:
>
> From: Liu Chao <liuc63@xiaopeng.com>
>
> ipc_protocol_free_msg_get() reads msg_head from shared memory and
> uses it directly as an index into msg_ring[]. If the head is out
> of range, the subsequent memset() writes beyond the message ring.
>
> Validate head against IPC_MEM_MSG_ENTRIES before using it as an
> index. The ring is a circular buffer, so a value outside the valid
> range indicates a corrupted head pointer; report the error and fail
> the allocation instead of writing out of bounds.
>
> Fixes: 64516f633bfd ("net: iosm: protocol operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fang Xieyan <fangxy@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/=
wwan/iosm/iosm_ipc_protocol_ops.c
> index f2f86f41fd10..004920068c45 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> @@ -14,6 +14,11 @@ ipc_protocol_free_msg_get(struct iosm_protocol *ipc_pr=
otocol, int *index)
>         u32 new_head =3D (head + 1) % IPC_MEM_MSG_ENTRIES;
>         union ipc_mem_msg_entry *msg;
>
> +       if (head >=3D IPC_MEM_MSG_ENTRIES) {
> +               dev_err(ipc_protocol->dev, "invalid message head %u", hea=
d);
> +               return NULL;
> +       }
> +
>         if (new_head =3D=3D le32_to_cpu(ipc_protocol->p_ap_shm->msg_tail)=
) {
>                 dev_err(ipc_protocol->dev, "message ring is full");
>                 return NULL;
> --
> 2.50.1
>
