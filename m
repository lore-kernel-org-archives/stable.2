Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793629636;
	b=0kVlYg9OMNtr05L96OK/pcIqCeYGo3SrHnCzhdLxeBo67cgK9OwNrtd0Jtb34jRVRGqN
	 dO9+qw5ExdRVak2YYn4KTTctsIfHydVcDYHkqD/d8Vn50tvNiupuHUnbM3lXSPugTYDDE
	 j7slMO4W4X+ahfmmu/GZMzUZS0AsbEtlQaHvTmC+9TouMXEXk1zFc8t6yyzKggTVOlTCG
	 60dJ68VxKOph5kydTsGoCWntZ2BbOboeJ0DcqQi4eouFns5wSR7Gg/WiBsk3tk4UeyIw8
	 tGU8IZ2nFUYW4VowrgZwI3L2aOQa4dYTHtV4L2TtbW2G/tBDUFCXhLuI+WkgiA8DoRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629636;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
	b=KpKQ9Yq3dR59CUmgb8IhhzWdl6tyja6AYF9ejJL2A/cGTBd6TbheWZGYhSbdZhIkjtW9
	 xbSYK5JLA2WOV8sIXBbfRnOcZbUSyX510IE4xYRpDmmapRvV4GiFo/KVduMN/9SKuSVfw
	 Hr522Su44A29H4AFpPrc3SvyjCVzHv4+yfHpVPzaG3TUUYbzPVrniPzfLKMFOL4+OXqdw
	 Ya0XQZARIFlsRyF4s9tvF7jOcJckXWMeyOLd7B1Pj1RwSORTWlblPMtaLIaEsYqVPB+Hg
	 tLrqYMocUpukE93q6GY//jonsZOlgNDBqIhffs7QlkCcmwh+kgABRyNPWioVPkLGhDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lejKQmqG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="PYFZyU/4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E98606E03E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E98606E03E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lejKQmqG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PYFZyU/4
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dq62s3717200
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 14:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=; b=le
	jKQmqGwQP6CJxqQJ/4fG9AAw3mSod/NgYwm7RK3UIEyXk+z/xXX6OXL4S19UhWco
	oV+EhLgcfkB0pZ4KMvF/6Kelt4BfdjwFZaJRP5v0oRb83w1iu0m5yHHmIQA+UWaR
	DhhgwpvVQV2qWsBlh1he2QjWfHaPduvsxfRK+sYUbB865yOswBeeaAeFYnya7eep
	kfGesPqEekAJal5fHnoDzCbPT9e9NdZelrVaonqvYk/z2tzKrTrfJPDYvbi+qn3R
	WHVuTIOR+xjuW/jZrTFDOv2IDQS91ZB8cKANe9mXk2jLZTtaT5v8A+iR9VHQxFjj
	LRmOwMp77484C9FWK9pg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka627d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 14:27:14 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-702f912301aso2997844eaf.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 06:27:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793629634; cv=none;
        d=google.com; s=arc-20260327;
        b=gjbxih1L4TWB3LRID/sENORMnewLMOByuvd3e7NICZZomI6lh5e7jXjIWEXfE1osng
         ies4W0rwU7R81Du/p4oAJ6L7R4y6bP7Nz5VoXO9irddJK0RXnMvnSp+nOoPQfTrgq0qi
         FTxvAmlLyPKTLtCwfscLXGVl0Vt1Gjk8u9pN2fkSm0gP8tNY9U390uicfQaGXHYPLPRP
         4zRA9NjBRhFcpbvJ68vmq8ZX2+6Fg12TVd0w2Fz4KKRZJh16CnTVJvAVObTvLCgDBQjU
         e0BrqqDPoVUMFxKoexg2us7q1UG+soetZE767StJbmP5XDv+O+k8X5URFFez4sCoUJzd
         YhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
        fh=L2Ppc7yBZECPp4BSzahqxbRUE9FaeUNI39wXS/dB9Mw=;
        b=gL+qrF9iCPFIO3Skr9VX6R4is4txIgf2bSsBRKgNzNN1T4d6dwOJLqZf8jjXPRwPBS
         Fa5Ou9+L1MwGLwqJsiB9QL6Em94RUSZeBAY1rl1IP2vn27ff4il8PTJI3cosxt4HwAvE
         CRH2Bi2vjnwL20g3lB4jjJYv2njXhonwUcY5h/25xl7Wf/35TazcQewb9X0Zi9lkEgZt
         6OE6On49zcn7FccGdMBc2Feo0aolAoaw27QOtyM3JkfC7qNimvkOaNQ7Pi65h2PidCsf
         nIGr7rMFkYVOq0Y9WVRXZMe+oQOeRkGGYxSx2AdMpwLms4sxuCVTnmpaHTWe3KF6nE4n
         euOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793629634; x=1794234434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
        b=PYFZyU/4vU6vjmUGpX6rvzfVjbmpRUBEcQvje8FtjXO15OAvem+9Y+YtjRg1cUvnwb
         0d171Ul9cS0UMUsnsYcbNIzlAoudpUywDuj2ngFQiHTr3o23RX93nrsTT/dVJ0GagpxD
         RTQEodUc0wsrvENGLLSVWU0jOrk66Atgh/c0Fd7I3xIj6VlQNqulXELf1kHfJvUtkP3b
         IQghkEio2Oi5aRQHetLdphqH5GFe+cA8fK4KIUm9IymOWfTrE8eK32pAjd5AI2OwYuWC
         y/t4QqK+JtZ+N/wquk027M/IS+gQR7vIR1EWSRM/279ae5R7KAf54KoaPknPYmxN9cNe
         ptAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629634; x=1794234434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3C3fTfBmoqwoS3MGZeLcIJkmnsPUJSPdomT1oiAvZw=;
        b=Vhn7Cr/EWWv9/QK5wMzZrOrAEMbNsaZMhPACvxxVP4HbhRLcMreZSv3cJtY88rTKdj
         Y8H/u7bdj2az2Lek03EDUWAizh7S/piuIJGGd3kFZ9k7rjeYVc4vYV3HwMBFQx6nIFWQ
         KK4A7sZxCg53gbE4i7dI1Pb6PsUfJ/W1ZsABpdzf3keWR5EYu6EMqD0h20UH0Xzlev5w
         I6iaZ2m+Qb5MPMqgJGx/Ti/g+6O61wYlaZ72kwIVPPQPfMyG0rTaDvb4H1JW32q6iJXf
         csnKNdAflxr6iO842KjKz0H+nA/moyr4RnOSo++IjPZAhtU9kTh6cWq9U7VsJ+bnGUs1
         KGlA==
X-Forwarded-Encrypted: i=1; AKwUvBzzzvSvH7a+IRX2HfqOs2Eil2p1w9h78NEbwDI8iOp0ge+OdO8wyJzelVR8xozzIuPLEnL9DrI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWqvEWWM3ZP0Yhsi78s2TOO1gADweMBjSFfhOGBOFyD/XVy0F7
	n2Qh95yiJdX5M+Qn4AwYfL4JEwP71R8ACmP0JUrtnFmCsO088f3FTySF24fCpyIvRv40B3iQBj0
	ACvT/+EwkeHieMuHb5eNYcorPMi3P5/qzFy50jVueY+5iKlOMX7XpCFNak4yQ1Qv1dQqncDXdtI
	nSI+BgvVZhEy/oy7937YBdp+jECn7KGwM1hQ==
X-Gm-Gg: AYBFou1VdPyKvgamBllSmB/KY7GOsZjDneuaauH6GRM+lTo58kVae0DwxURM0vUfFlU
	mK3Q4b4FMDNUp+xRtcbbCUV8C+mywiOihYTGB+7AGS+6SXK/YsCUEKxvGae1pCTQos+zwU/167J
	WZvQhnx26GAY8Ztwv3rGVgGx6u7cQ87fu7VexmrqO4wlHgYpGisxkQlOjrzw==
X-Received: by 2002:a05:6820:7081:10b0:6e0:1599:a4a with SMTP id 006d021491bc7-714f290f51emr4033702eaf.35.1793629634175;
        Mon, 02 Nov 2026 06:27:14 -0800 (PST)
X-Received: by 2002:a05:6820:7081:10b0:6e0:1599:a4a with SMTP id
 006d021491bc7-714f290f51emr4033681eaf.35.1793629633693; Mon, 02 Nov 2026
 06:27:13 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com> <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
In-Reply-To: <20261101175553.53746-3-nicoangelodelacruz@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 06:27:01 -0800
X-Gm-Features: AclHuK9APyGtpZOJQcsejCVfEW4m73oY8nFEMTVCqR0OB1TvK7sTUjK0ek7HnrA
Message-ID: <CACSVV00ud7+mJ0YWM4a_jzRwDuZTFkHkLF3tXC9NBwMcmyMUfg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: free the crash state asynchronously
To: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zIWwww72-zngO4YFFmFe1aWzv6c0jLgl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX5uJKIMSu8lb0
 sP82/wFyItNR1bVud8RC4u4gec27onW40godMAi/dze3UR5DjV5mGYPXWZ5OSJFPS+V4ZEdOKy6
 2Id1eK8Us6Qcn3jpzY5EilmIX7hWolU=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae89dc2 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=PDzu0jb1FHLFr2hdgv4A:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NyBTYWx0ZWRfX4LQGaw3ton2D
 NXAmbXfeGlx3mgCPkE+nS8I3j7PgJ/r1iL0YS5l0l57D3GVfF5VGp885OLYYcwb28jVKxXstOli
 7xrbNAxYvuxV3LCTdaImxL4hm4RUnwDe90upSyuikoQBnLK6GAxZHyPXp+jZ3woP5Iqb1VTHyPY
 aHmhs7peOqXiIUYN42gMzJNY+qg2qYShN3KSmEi/0G9g4al03FwAEvIjmFsX2PTUqO25oO1SxHV
 xquzwXkE52j3WEC59/yA0HhT9T3ZWhy7MuzdBVZp/kesb0UCPCkv/fRiVDQpTSgXO70IwscMKDk
 1B4haceqPYXpzDlG40+wzyLIsaViyvyZeXWKkcT5yxYENA6uVA1co1CK+RN8dbcpg86Fev9UMcb
 BIgt62EUnEMgOAJi47MP1JwkUI7xFgJ/5sLWay+g+OsBfg6TRks3A7bfFKU5nV84n1gyESLCNll
 csTs0dvlimfh66l1ZwA==
X-Proofpoint-GUID: zIWwww72-zngO4YFFmFe1aWzv6c0jLgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020057

On Sun, Nov 1, 2026 at 10:00=E2=80=AFAM Nico Angelo Dela Cruz
<nicoangelodelacruz@gmail.com> wrote:
>
> msm_gpu_crashstate_capture() sets gpu->crashstate and calls
> dev_coredumpm() while the caller (recover_worker() or
> msm_gpu_fault_crashstate_capture()) holds gpu->lock. When devcoredump
> is disabled (/sys/class/devcoredump/disabled, a write-once knob) or
> its allocation fails, dev_coredumpm_timeout() calls the free callback
> synchronously.
>
> msm_gpu_devcoredump_free() then calls msm_gpu_crashstate_put(), which
> does mutex_lock(&gpu->lock) and so recursively takes a mutex the
> caller already holds. On systems with devcoredump disabled, every GPU
> recovery that captures a crash state deadlocks.
>
> Defer the put to a work item on system_dfl_wq instead. This is safe
> because msm_gpu_devcoredump_read() takes and drops its own crash
> state reference, and the work takes gpu->lock normally once the
> holder has released it. gpu->crashstate stays set until the work
> runs, which only means a capture in that window is skipped.
> msm_gpu_cleanup() flushes an already queued free before teardown.
>
> Tested on an Adreno 830 with /sys/class/devcoredump/disabled set to 1:
> IGT msm_recovery gpu-fault recovers and the GPU resumes.

It seems like this is missing test coverage in msm_recovery test.. it
wasn't a case that had occurred to me.

Care to also send an igt patch to add this case?

BR,
-R

> Fixes: c0fec7f562ec ("drm/msm/gpu: Capture the GPU state on a GPU hang")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 21 ++++++++++++++++++++-
>  drivers/gpu/drm/msm/msm_gpu.h |  6 ++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.=
c
> index caa86279f..fded78fdb 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -175,6 +175,14 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
>         return ret;
>  }
>
> +static void msm_gpu_crashstate_free_worker(struct work_struct *work)
> +{
> +       struct msm_gpu *gpu =3D container_of(work, struct msm_gpu,
> +                                          crashstate_free_work);
> +
> +       msm_gpu_crashstate_put(gpu);
> +}
> +
>  #ifdef CONFIG_DEV_COREDUMP
>  static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
>                 size_t count, void *data, size_t datalen)
> @@ -215,7 +223,13 @@ static void msm_gpu_devcoredump_free(void *data)
>  {
>         struct msm_gpu *gpu =3D data;
>
> -       msm_gpu_crashstate_put(gpu);
> +       /*
> +        * dev_coredumpm() calls this synchronously when it can't keep th=
e
> +        * dump (devcoredump disabled, or out of memory), while
> +        * msm_gpu_crashstate_capture() holds gpu->lock, which
> +        * msm_gpu_crashstate_put() also takes.  Defer the put to a worke=
r.
> +        */
> +       queue_work(system_dfl_wq, &gpu->crashstate_free_work);
>  }
>
>  static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
> @@ -899,6 +913,7 @@ int msm_gpu_init(struct drm_device *drm, struct platf=
orm_device *pdev,
>         gpu->dev =3D drm;
>         gpu->funcs =3D funcs;
>         gpu->name =3D name;
> +       INIT_WORK(&gpu->crashstate_free_work, msm_gpu_crashstate_free_wor=
ker);
>
>         gpu->worker =3D kthread_run_worker(0, "gpu-worker");
>         if (IS_ERR(gpu->worker)) {
> @@ -1047,6 +1062,10 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
>
>         DBG("%s", gpu->name);
>
> +       /* May be unset if probe failed before msm_gpu_init() */
> +       if (gpu->crashstate_free_work.func)
> +               flush_work(&gpu->crashstate_free_work);
> +
>         for (i =3D 0; i < ARRAY_SIZE(gpu->rb); i++) {
>                 msm_ringbuffer_destroy(gpu->rb[i]);
>                 gpu->rb[i] =3D NULL;
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.=
h
> index 5cf220f75..db9e11e7f 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -258,6 +258,12 @@ struct msm_gpu {
>
>         struct msm_gpu_state *crashstate;
>
> +       /**
> +        * @crashstate_free_work: drops the devcoredump's crashstate refe=
rence
> +        * outside of @lock, see msm_gpu_devcoredump_free().
> +        */
> +       struct work_struct crashstate_free_work;
> +
>         /**
>          * @recovery_in_progress: true while recover_worker() holds @lock=
, so
>          * that fault capture and GMU waits don't wait on a fault devcore=
dump
> --
> 2.53.0
>
