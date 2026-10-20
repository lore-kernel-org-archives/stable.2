Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792491713;
	b=2RGMjKM0bYoYrQ5k8Wmo7Wiko8y8FsdhNMZh/4M34dMfIto8rzLeo5JfXd5O/t8K3FeG
	 KE3uZ4K1nCR4/cUD7ynIxxK97ygt4/CQO+rYf5WkFcVm3iKiH/6iWB3TMII3O0dff56kO
	 mHezwSS5Q3yl+1bcacq0AY0Xf6uzB/mw0DA6/CrBvwV62SuDhWNqjrf8S+hCVRWw/Izr3
	 UMauOonNxN5+RzGWpOMCm+tD6GZUr1qmjW+QAVhKkkXUV4HMSL/PvrxGa0jeccE4tdt6T
	 bciT2lXIwHIpk2EI1ckBjgxAU4CMujeZxLM1tw4lfm6euvqJBj0LKxYvKsmH1BRO0tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491713;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
	b=RQ7rVEMLAuRA30eJ+HzIaYlkKa0lfTOx7EnD93tHlfC+o1CyfZ/Gqn5nZTMfONcSm5iX
	 /jnZb/gtNW4nZiK9o1s8cc8i8cv/bnZManxTAC7JFZhVb0pcoXMRH9uzR4gyM5r3NM13W
	 qDvepYNpNbAHItiQdQDfNTrM2L2I0WEGX7LqiAvvtu6wCWxASUP6rDVXbsh+F4MoE+zjF
	 N6xCgj00+U04jta9aqRxZrATuWyqzA0Ch7HCozppQJ2SNZPehW8drIqtMVLbeb5/wvHKc
	 Sad6vt9aPp/QrlSNA1MLdu5glF6YfTFPeu7j0fhg3qHFHcP6LwL93f2OHv6hvKdWgCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lh0j/ICX";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EU4V8c7d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F9606A31E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C3F9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lh0j/ICX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EU4V8c7d
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8HffS3807111
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=; b=Lh0j/ICXD9F9bypK
	pUpAeSGdmK8ensVnmGZogRd77GWqLFCHY2yGj8cB1NSyL4EjnnrNLUM8p0kDH7tu
	GTvF2SosRxf5P33qoBdOsgES+AgTE8BqJM6W9J5imYDBPaz+oAIC0k9v9GKo2+eC
	0TJFy0VoN93QfyFHTt1YGPQcqmvWPBOS5QByjRdvJKXlWXTuJwxW4b8ajh7qYOVm
	w+RgxZE7+aWAlbuiMtLnIxsGBdZvP6BP99ZAWLT5539fY3FezqJViTRHaZy+EVru
	z+YBWcc27GBKfTdwRIXvkvQHMdoIk/6vj3+BmjYw7AHua1EKjbXm0OFHYjNU+oEu
	fpCvPQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pa261-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:21:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ecdc701a2so370759185a.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491711; cv=none;
        d=google.com; s=arc-20260327;
        b=rdozjm4YQZzie/bsjRUEC6HBGtkzSUYPXRkg4EX+Mer1fazTGHVtoXlUlUx7Szx0ik
         dGZ3OmU91JYCrCF5zp27udLTPLrLrLGRUmb8g6wZ7UH9aP0dMDoCynH8Z84HdcwnYtjz
         FhHWPD7cuoKzFadJtbyKTu3voZQIKaPfMas9fJR9qoB2/J+ZzI9PyJswmKIzsdUd4oiO
         l/hNQug1cWGtFHLlTWvYG69AuIHbRRkypT2naEf8XGoN2akZCRveM9u2qzEavG8HhpTN
         yAGR0TTRjQJ98h7LZLX3LiNgra24SJBxou/pgUby36KoevE5DJ7VejsXo8xy0USSCIK/
         4/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
        fh=MLxcQeiqwxpQXests0tZ1eIJ9tPT0BKzE36se1VK/mM=;
        b=gkvJ9fjkMvks0+qM+OEUbgLNVlriJ2nbLid8c5wbqYAsxGJEPmRkYWtBs5VzeJfi2c
         VkrNEJ/9nt5vzOzwAOvBD5gOcKYZf1ewvdxOXIa+CnfemNFK3nu1m6drZ5hUgUbVhKFH
         8HulPJH02r6K6yd46+TAx06+B5VW2cGzSFyL5O0ZQlPomtGO4KB/dfpEmKnpdZARk2r0
         GRZLBFL4JGgAOVat8iDYG6np6G62ALLc/zksuMzoeh+d/3A96TqtY0lOERsLL3chlxKR
         FOa/VMu+wgkrQIuo2yiWZnuIr6qmu4SUIHwlacM4CkWvoN/8AclCJHO//QVFxl+iwfDg
         mgNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792491711; x=1793096511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
        b=EU4V8c7dwPEcZ51zzG9IvdAHykYk0uA0MUUMiLLbMkTzZ6o+INI2aUc4iSeOj8BjHc
         yuIOYr1G+ge6AAQheGgRH5q6LqCc+FLqBFIs631p4MfDBYtNZRMJlPAvUzTYseFBUInh
         zw1rFj5moKxwxugWvU1/gIlQOSrD9QNz+7/EyNLq+PVCkuPBU0Avk0E0ACstqQnf7vmj
         rvkOwhrQFMpSV/THubJ+TcqRVbZXr+t/1+Z98r/NKzlgtzfnnPCKd0ITluZZDyIk1aVg
         pM+7FhXqBXyzFgjbCwlM1QH3hx1ubANYU8UgtpGSk2be0HKSwyR77SVtu81iPMNA5af0
         7Q0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491711; x=1793096511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmzEU/pYlWp69Fnmfb5E7Xfs+qaL+26qFfmEOpd/OvA=;
        b=1xD2tplNdIWgIsr/y5XyahcFfqPyiTPwQbLcUgcpfMjMo3F5oAQdwJqE2thZz/LZ8q
         UDDpQ6cISTMzmMsPQeUh3Cbxzb2ARfT9n8ehcK7bvrfMS4KZOGqx25KurQpt0T6/UbfR
         fRBmFTb/qlnc88I8P9B+hLJAYOR1gaeDVoPQaxMaGkEBtIHlPQhizCpdxTPfjOUtazI+
         Xt7lKCMNM6wZgGupnoELWmhd9MmL+kfhrntMnSxs8fB3/7YMKbc5P6syravyDRh/rxPA
         ajJ6Z3JeB6QvyyA0bUsAL1IKDXNkUeSgC9bwYLMqAI8/78f2EGN5yv+Rm2SyqZjQo/0J
         Tx0A==
X-Forwarded-Encrypted: i=1; AKwUvBz+QV8a5ZsNOVdn2fZtOjZFfwTWEsFHf/+4Kk5ZbGEVMcdU8+c3MfhdTGE6/sVfpEZ5ZX91cC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwhoizNOY+SKGYdLE4c+lBhI/9X9he2wN+8eACF46GlXcqZepc
	sUq9pm0MpPjL2umL6CDshD2izEEs2nvW8/NA7QWucnoXwmMZfXTuD9zO8fadkby7VqGoSZ9U0QO
	ob0L56fXo9a1IFwpqowkL6GS7MNbZMhITgK+cP1gfQycCzWJhceQTeVjMY+ltzTiGEllJCz5Hfb
	x5N2g6K63JyjrMoCMqxM2iYytXPjWh0/TFkQ==
X-Gm-Gg: AYBFou2AFZLb5XdWBg9AEz3FKJRPBiJINdOoFoxA7ISAmaiJ6hnFAZzpcxtT5hO0uGt
	0yCGMaMbH90ILax8L+SLc4wtQDoCcIMKbfD94cXmgVX5rIEZdexYwFxUqkYVIgHHqBChA2dl5bB
	yo4Z1VDsXEkTuqqNIAxRcvCrCGhO4RtaDrh/sJHZ2zZajqXoY2OlJ/YNzyHiYDyQ8NsMHtDxSgd
	/frtau0XDFIQKUdl1aLu1eWts125OsvV/sWKX/S+Ptn/dZrM81As1CZM2NQMW8gCiVQxhTgBfY=
X-Received: by 2002:a05:620a:2948:b0:93f:228c:52fc with SMTP id af79cd13be357-93f29d7b1admr1754524685a.58.1792491711339;
        Tue, 20 Oct 2026 03:21:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:93f:228c:52fc with SMTP id
 af79cd13be357-93f29d7b1admr1754521585a.58.1792491710779; Tue, 20 Oct 2026
 03:21:50 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020101150.16967-1-liuc63@xiaopeng.com>
In-Reply-To: <20261020101150.16967-1-liuc63@xiaopeng.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:21:39 +0200
X-Gm-Features: AclHuK_litW1CsHp-p-GfN5m3qzJOLKXldulgV3ixEju9BrCrj64dCZjrQIAVEk
Message-ID: <CAFEp6-341f_TjYw_rz75h3N9Ph56N05MowosmKJh-UobS+SdTg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: iosm: fix NULL skb deref in ul_td_process
To: liuc63 <liuc63@xiaopeng.com>
Cc: M Chetan Kumar <m.chetan.kumar@intel.com>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Guanglei Zhu <zhugl3@xiaopeng.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: qDc-CIVFllBDuz-d4qOpIOxoK-co6NF7
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad740c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EgahoUkMAAAA:8 a=VwQbUJbxAAAA:8
 a=5kY9qsDIvHh0I-ch4TEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=D2SkTF70-_n5gOfERQdM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX8Ya75m6w9T4Q
 e9CA0V8q9ghat8/PUilBVrDfTrZ3jiLWddFvbVw9V74PDT7swKCGDGvvh+YDi+BFjy7GGTpiM4R
 BdUPji8GB6fII4LRhIzuAk2yivHYfqOqZEYGdYdWZPJuRAuJA440YuzY6SK+GqWjgsb01KmXLkg
 gnSruS1ubETaqGaoYWFU4KVn6K+Z519TXAJghs7rwecddv0/DabMyQs9seIjmY8qOTpv0p++wMY
 S8sxFADTRJsrIIkQ2Mni5TAk7R+6Wsy/iFv3/Z4zLvN0ufN2Rbo8GEyyt66o//rF0klFEnehQBO
 1vShi0THhEo3wZPMUTjKNJCjc+ga5QUTQIjShzgwtUyr7UWJT4mii7TvUS00DI+YNrr1tclwBFj
 dKHqE2fTbtiYg6HAkBFEAEMk81m0/mC/cXi6hE05R5duub8nud3v1GPbyEL8aY1WzC8KLwZWRek
 U0HMb1C+YAroEp/jzeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX/o3Vdlb0Ha4h
 CCLKJdpiVZNEGIDPPDwzApmRyejWUtBZRCCllcuMas7Qtos8eb7z5DLwl7IVLQq4ZNqw7665fGF
 aBlemMafB/MPOF+ZjPvG2eZVMIfYv/o=
X-Proofpoint-ORIG-GUID: qDc-CIVFllBDuz-d4qOpIOxoK-co6NF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200041

On Tue, Oct 20, 2026 at 12:11=E2=80=AFPM liuc63 <liuc63@xiaopeng.com> wrote=
:
>
> From: Liu Chao <liuc63@xiaopeng.com>
>
> ipc_protocol_ul_td_process() fetches the skb for the current tail
> entry and then dereferences IPC_CB(skb) when comparing the TD buffer
> address against the skb DMA mapping. If the skb slot is NULL (e.g.
> the entry was never populated or was already consumed), this results
> in a NULL pointer dereference.
>
> Validate skb before dereferencing it, mirroring the existing check on
> p_td->buffer.address. Return NULL and log the error when the skb is
> missing so the caller can handle the malformed descriptor.
>
> Fixes: 64516f633bfd ("net: iosm: protocol operations")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
> ---
>  drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c b/drivers/net/=
wwan/iosm/iosm_ipc_protocol_ops.c
> index f2f86f41fd10..dee2e6607f77 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_protocol_ops.c
> @@ -302,6 +302,11 @@ struct sk_buff *ipc_protocol_ul_td_process(struct io=
sm_protocol *ipc_protocol,
>         if (pipe->old_tail >=3D pipe->nr_of_entries)
>                 pipe->old_tail =3D 0;
>
> +       if (!skb) {
> +               dev_err(ipc_protocol->dev, "skb is null");
> +               return NULL;

Look like the caller(s) already check/report for null skb, so instead
of adding another print here, maybe it would be simpler to check for
skb in the condition where IPC_CB(skb) is used:
`if (skb && p_td->buffer.address !=3D IPC_CB(skb)->mapping)`

> +
>         if (!p_td->buffer.address) {
>                 dev_err(ipc_protocol->dev, "Td buffer address is NULL");
>                 return NULL;
> --
> 2.50.1
>
