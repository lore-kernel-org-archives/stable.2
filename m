Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794668624;
	b=HILBSJtNAccOucRzvCxeMFCcqeFbnB4IY7fAZThEIyJycidehX9hUKN5mczF//9uvS8v
	 YlgkXTHZ63MOS3Fllm6gSPTRrxGuzkUhHuSq8wMb08WC7AnF3uGQUx04iGV4rr6QuFDWn
	 S+mIhsrvuFRB3UwPQSU2qDPVXIkYRKHse2UYoB4HYj0iMyLQfCjZO9JhrBLTS1ZrStjVc
	 78ZGGaJnUMz5xQFPBJ/gpyxJKnb6nREvJf2BZ+O9MOH1INgYYu6uVZMt6XhbjI31FbMtr
	 OWYEGaAK4vh1WlJUXDKeBTPQH9J8I2sSgKjKP3mafAJ/qslqj/S9hC49XLCMlpK9VQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668624;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
	b=uNWUtHMXY3iAfSTrWwypg+Z+iUOPBpTFA1EjAk9GWCCvqJtXJPiIg0s4Qss5HHOgoM6V
	 RfHHxCj3kg3yT3ipFF1cAmz5GB78da2HldCZ1rfniyIFVGMi4LBlYQMUuTT5PHR7YIN8M
	 74NsEz0HsvJpmbVgDpAcDsX9dQhRB3jdANuFUPowYOpJtFvpvjptrIM1aeJ7sY3ub8AYf
	 8fHs0gAy/ufd1wobc0vxdBMfo/ji6EkACDP5zYj5SQC507IJuMYwB+NmP927dEmkUDmj0
	 5AgTB4dzdAbTD2pPE7CKM/S+NgfrMVkhcn8Yy6n0HYvAn3fb15mpiycAH9kLYU+cebg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJo1MP3c;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gRmdTzyx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D3606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 181D3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJo1MP3c;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gRmdTzyx
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AEDkZuP2214167
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=; b=CJ
	o1MP3cF9U778Fl4UAjeW5R/pFXcIzfxcQ7rXLhxZjZpIMvPmteXIGV1bTl3Q/0uC
	hZwirgGUScYVlk+F5XMDWGUbg6flsUK6Dmk5Ef6/f2K+OeIq6i62seYRD4B42hrV
	VM3e1ZyYM9pkvjEFdZIZ5JMeAW5BA8O8tlVswm5rkbvag0+b+N/EzC4kIM4GOzsk
	zN2PJR6Qga4G0eFO7vLbdVSaIUv6qNSB5atb69gwAzQv9ANqEzxRDX9cz0yPeKsq
	B+opbSDTAGS4DpiAzqpKkD2zoFBA5R31CWGRCWO2jSjthas8be5uQQa2qSc69eUt
	fuUe4FvonoYrntg/UIjQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhj411qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:03:41 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-71ad455a8c1so206388eaf.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:03:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794668621; cv=none;
        d=google.com; s=arc-20260327;
        b=paQI7xGUCWBEY/uTJp0Uy7/T7sQpDU8DcX3RypO2xU85+w0ySduPs5ZivkD5TTfrAk
         Ydp+Oj0Fs6Pv0wIJJfU2h1HCTIT83bOsor3vd5pKrTGyvjsIpABtGOwxjAhCULmfgLTr
         y3M/WefIVnWCqitXejW8qqeUFYs+LMJMWO/K/l7Pe1QczZmqC5jcMrKki554ThSfAzWW
         RGL8JQXwazU2utE44h19uvgAGrp6bpyH7joepMN5/H4puIJ+Uaeofhb6KsPsq/vVUndM
         NiAfrgusBOaI5PoAJNpSwAjvbx0H3tq/s9BCboYg23gfvKq7b2dFtCNjGjCaQVxQVHdT
         Hnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
        fh=FLPX/D4TmeyDL2dfa3FkI+3d84xTFuEmeahRwdC+QaM=;
        b=GuODArmSNirN00rz6kZPNCSf9jpTq4RvOpMTRJFdvbTPGsoHip6zCgav3OVunBh/9R
         aoMBE/Nj5+0Qf2WhX5ycx2hRRoXWd2xKZ/D0CVvkMur7hTLrgrJQ4lhURfsm1hb1b++4
         ytpFntcJdH396okq2rIKkQlGVPusKLXxFxauL69/nGaZprKfnE6iN+sjS7nx39oUPAKy
         IHmV4bQbyMjGUpT2qwgHu7NNaAKlmmYcYjdUuKWCA1e/KCLQxG1HSrQiBYx71syPprKm
         hEAzo9NX+bFlEb15rAeSfeq/gVaVTEX6GJfMBD4zhFqsP8u6wCVDSdTRiwxaW2CY291i
         ebdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794668621; x=1795273421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
        b=gRmdTzyxeck1puoWqPpsrthiBIw3Eu1cKf3QHcfnBuqRFpdu1fQtuIpQLW79qiszyk
         jnHFMgRAfVi1SXNBeVi4gr18Uy+4d/aRdpOI0mFAsjElbsEFo76ZlZzxTeNVlCVKfdYL
         czvavHj+z6q0nhvEQX3+PubD4uMxjI9+ssbNcU4xlE9IO+VZz+0FbidXLx7EFX2VrUIv
         hE+60HnxDvjO221tQYXFJcEZ3/Qh+SOqYpzjZOWNwW2iWHTY1QfjK0mWKdesF9nH/vXB
         5yUchoWyEW3EbZdE3ZnG9cp3UJune0eumUCfvwNrBr6hJYPTah8ecwjQbsE7jJ40k8sp
         cXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794668621; x=1795273421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sDYL/1OD8+rhM9OxoZ603u83LGKRsfSXzfMD1R5tXtc=;
        b=Z6c1Cts2xx1eCLnMo2qj1xuDYeXO+1o2jO77LAhGCFAfHMy1/NYYO9QgUdDKjQlzTT
         Oq8zFfBg4IKO+yCowf1xopLb8k1CSdGvzWIBL5g1F/0ymMZgA+JN03LSBtQEjt7D1R59
         1ZaVsMAht51mJKj0TnoZHK1pNJLcCCiDLEbSA9l85nXWHcMl66X+DObByOBL9IFBDSUl
         OCccwNM6Zy2AgwbTFVKkrubl9uHUR1+iEdoNmzjPUFLQOx+tzZLSSN8P3DIFdKhH/zFq
         +Bq0AI3KkIVrRFErdndEdCOSLCSsR8tzgOszBIx4w8Ibs7uzMsZtfOLKJzLH9tXg57/o
         8lxA==
X-Forwarded-Encrypted: i=1; AL+hErHNlI8/nFoz/cpslY1Hg0jfyJo7Blq95kp284/1FlOlxUKN+LKd/nJvhwluYT+0ScvMkBW6PBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+okP/dBheciYiiUtwkdy5oyV7q0kCCSHHpEs1cM4RiuqqlEcZR
	AqU53YKIirZza1+0ezRzL9mNzeQBlR6TRBRmHgND/QcvNfLdORQnyrIlb7Odmu4ufnbmhkWJSqp
	ra0uVFelVadJNomdZd59Vz5PwX4J3YVx5Oqak0MNvLMFh7oJ/Axenq+FDzOZ78Has5k0PPnC6SG
	bLS8fljrwXeyppzb2bZ6H2pja2LkGK+7R4IQ==
X-Gm-Gg: AYBFou3HZ9UL6FqQsHl8rgYTWYGsAnpV703yIs9dBjRch4dGqJuaP0HYKECokfGuENu
	jP6RbybX9QnouOnNT4XAWcCzxMxBasn/bc9mgba0aATHgdiPAxjFHI8RKuUPOF/OogRwQkVwyj/
	hkNXPWv+l+nAf+KuOlaxKIJKrcpVUxWluzrGa9WM1vJ3H4np/3LL/AeW6L25jPrQmw7ahClWgb0
	LMFxNxfUGFSYuryElxMcw==
X-Received: by 2002:a05:6820:c0d4:10b0:712:c3fb:b4dd with SMTP id 006d021491bc7-71ab5101a6emr2292833eaf.58.1794668621142;
        Sat, 14 Nov 2026 07:03:41 -0800 (PST)
X-Received: by 2002:a05:6820:c0d4:10b0:712:c3fb:b4dd with SMTP id
 006d021491bc7-71ab5101a6emr2292808eaf.58.1794668620683; Sat, 14 Nov 2026
 07:03:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114081902.1669-1-arpe1618@gmail.com>
In-Reply-To: <20261114081902.1669-1-arpe1618@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 07:03:29 -0800
X-Gm-Features: AclHuK8KPquTQTMdHPjuGHN_Vjcpb4fNt0tQaGS8PVmX6JLmxM8xgl-PL0FADhg
Message-ID: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
To: Jiwoo Kim <arpe1618@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Antonino Maniscalco <antomani103@gmail.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX37W0gd3o9Ee/
 BKmnKe4sgVk2FLi4gbawdhso0bZahykLw0/lRZD1Sjf3Isxg8z0b8pUwMSEF8elFVEWt/gR+Wsz
 LTws/eKROM1t4XRbpyy3SGiF0DedPCYBgH/WtA1NmXTl2sj7gjiLX8f8nOZ82PyNDfWYKv9qaLj
 Gwj1WXZo2KHd3R7ZW/41xTGSTnR7wHmSQa9o4HLy+snWKWzmkGmJnsVaQ7Yw+47EN41kXK2Fmb9
 fgfUhlg1smt0H4NfssAU20Tx4rBCL5rParOckbjOwPFljpfCqSO3d+WSzWjTbhEpwXcf3U4TweR
 xBpdLDm6p2PnaImu6WOqIPSROEccM0haiU/UGtdjzYdRMCA6u7IfcpmqzwtKze/XZ3Uv8FcXd5Y
 sggTf7e2kNFIV3sf0JwLYtkHBwtg2wUqc3ifTv4WAMEnG+e8z+MDgO+FGJlPRNg338Bjuqt5m/s
 mDp8YTLN28tk5Nui9Bg==
X-Authority-Analysis: v=2.4 cv=av0nmiZV c=1 sm=1 tr=0 ts=6af8784d cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EtCpCjh61Ki2hOajGtoA:9 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-GUID: yqusdpJD12suSDrOKns5gHckUe0QXWIl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA1OSBTYWx0ZWRfX10gsZnA+c706
 jz7q2rz/c8av921kgNNxBN8x/CGsmnEBemE2rQ0bOfLi4ZrVMTPCorL8vEu8K6yQ2KhE/SEGC4Y
 IWuF/O0XelQiHz602I9GXOzVCMTaXkw=
X-Proofpoint-ORIG-GUID: yqusdpJD12suSDrOKns5gHckUe0QXWIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140059

On Sat, Nov 14, 2026 at 12:19=E2=80=AFAM Jiwoo Kim <arpe1618@gmail.com> wro=
te:
>
> These fix what happens to VM_BIND jobs, queues and entities when the
> file or a VM_BIND queue is closed while jobs are still pending.
>
> Patch 1 makes a VM_BIND job that is freed without having run apply its
> queued unmaps before it drops the references that keep the unmapped
> pages alive, release its BO pins, and mark the VM unusable, as the VM
> no longer matches its pgtables. Patch 2 destroys the VM_BIND entity
> when its queue is closed, instead of on the final put, which can come
> after the VM's scheduler has been torn down. Patch 3 puts the queue
> last in msm_vma_job_free(), as the queue may hold the last reference to
> the VM.

msm_gem_vm_close() waits on vm->last_fence which will be signaled
after msm_vma_job_run() returns.

My expectation is that if thread A is in midst of a VM_BIND ioctl,
perhaps not having created/updated last_fence yet, while thread B is
racing it closing the device fd, that file_operations::release will be
called after thread A's ioctl call returns.  Is this not the case?

BR,
-R

> Changes in v2:
> - New patch 1, for an issue that Sashiko reported on v1 patch 1, which
>   that patch makes easier to hit.
> - Patch 2: changelog refers to patch 1.
>
> v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com
>
> Jiwoo Kim (3):
>   drm/msm: Release the pins and ops of a VM_BIND job that never ran
>   drm/msm: Destroy the VM_BIND entity when its queue is closed
>   drm/msm: Put the VM_BIND queue last in msm_vma_job_free()
>
>  drivers/gpu/drm/msm/msm_gem_vma.c     | 77 +++++++++++++++++++++------
>  drivers/gpu/drm/msm/msm_gpu.h         |  6 +++
>  drivers/gpu/drm/msm/msm_submitqueue.c | 50 ++++++++++++-----
>  3 files changed, 102 insertions(+), 31 deletions(-)
>
>
> base-commit: 1e59855738454b14021b64115f0090eafc7526ae
> --
> 2.43.0
>
