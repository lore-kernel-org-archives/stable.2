Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794674445;
	b=IvCFHkNUGDVy85CahtIb8IDK0irBDDGjxleaYevPubYpx7fGUUdKWAcX+QyaXJ9YmrOq
	 Ix7AwoMXvgRCozpuwZUhsBTNFX5VAZF4BIySiuwZAWIQOT7t3H530i5Yt84mYUnZWlEnN
	 tPe2+8EDia8xw4XoiSdcutusoVL5hnwiefipgDBdwhBuWyVAMMxtmMVC2fATITWvVGO55
	 K0CQcF6f3WgRcXDGoOZrq3xW3sI9hrCH4WFNfJVFXVAu5Sv/Pb8A5ZWku/08YeosToqo+
	 Yi77iy99cDBHTRo+Sxi3Y+ETTWbZUc2I2Y9rbeJlf3JlDj2mfs1X7/t2VFMMTWfKQmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
	b=MDRSOcbhK/r7TL4FGqs/glS4rnx1DAABCYhXv6yg38WM5BKRvtHa6f8/106u2Y6kO4VN
	 kwkQ/kre6T1eA04I7jDdCbpTNMdRY2eKPVSqn6CetK+C/LBhVLE+9GcRSSk+5J34gwss1
	 zSfYNoNm9QT4wIRMCZa9qkx0ncotfS0NKyhR6JNixiLxe4NYLatUOZMuUD0bPH0IXgY+S
	 JBR3gSeplfkuClY5h+4kSLDkrPkT66I/K6rN6Ultwwbujoe8jLK37gjeH+PiubRIFWOYz
	 R+uSz0PVCq67Hpz/S+YoPN0A8OJC1pxNLFaYUmMFP1KAvI6LsfSkHMhmNcJmWyg8tQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fpYXnSkd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PEyKBndF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE6606A882
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58AE6606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fpYXnSkd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PEyKBndF
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AEDkG7c4183366
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=; b=fp
	YXnSkdnG4BA4y8XDLRl8x2Co9x2NAPivGl8Owm4IYNiITvILAgSN3/MakeeFTb51
	oQ8ysc9yiMQMzZ6pOGm6khvyUOxdnIydruCt5uqV4NQvj3bpmKyr+kOnzdaUlXKB
	hevt+FA4bZxt2sFFHBKSpKAMO1WBHi30sU/FjKa0QRmwba52oYXcestA+zmoVJft
	Yym1C5/qt8+wUAa/sTnxPbYtcn4CE8g9YUD0UZo6STZrnIOTbUaR5h4Z7ev67KyG
	3CA7GXlrMqCtC3IE49B4siNKjkxkxF1tIYcUo3ePvlp92/FNIZAg6xKIAOZmIsjV
	NCZGFDSvrVLBR78lAFWA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk2183u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:40:43 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-862adf80a1eso314628a34.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:40:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794674443; cv=none;
        d=google.com; s=arc-20260327;
        b=MEaTmPpULfwDvBGxOQ3fPmelK9WYIZWF/jJaqSDGdQEYUqBK/24+mDrl0ZjQX0rJuh
         pATNaXr6QvGF0kib4oLrk6HAoyNT2WDPcB2f2pm+eR0qd2MSAv+6d69nZi9XgftQZeRT
         7c72854YFrqjAH4VohlkYFahBoXYklSgoC3Y6y6ahpglW/6VnsN51wIGMKLFmvbYxjgm
         VVi6bBKqJQjf9Mne4J7BanYUhN4V8xO70uVtKsImponBTSExeXXwNYR14LzzhFDHA6fp
         QI3FvAx+d/chQtdQVVydvSBF1ZPM7iPAi71//TPVX2u+agmYqy691LfuCsHdsmvow1fE
         z6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
        fh=wfshn3+ZdgUsgSA6zLQ0lQBWGwnNNFPYDhR20lq/aQU=;
        b=GDBgxRMM9fFp7dKtcivEnnKDm3SoM4sBzzUcA6r0cPzhf8pZq9eHdIbquqMYs4kBIO
         xyy/5I0uvFHryD2w5bM8ozPfFggqIa+Nw0N02LwsBRJZ3KaEGovbo89+NxPTgeeNm/2J
         junm/0jNthLhfALYpeCB7eygnH/iinE2k+7oercfK0ngCmg70J+FTzAKxckOUgoZbeQr
         VTq49QGH0QpXV779b5fYtPzCwLVwe/FDY8I3nysKuqEInDZaYX9tGIc+ifBiFYRxgvAq
         n0N6U9E4EOevb3CjzRO4s9h7gK+BIuWoKGXqMfR08IIt/ke+6Id4JgRzEi7HSXCmONJc
         GCAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794674443; x=1795279243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
        b=PEyKBndFsBRy6cE+pH6wvUPpxLuqOFsAMgUnt6zROwdejjuihiLQYeOlCBoLvqUiHI
         NLrND11V6vM9gjVqZMMrelLjeLmYj1wDFK1X2Ldq0nQ2xT96OQRxjbGywolczIHnudsG
         gmFL+d4iKq1E6nJUbFVW5VRqr841KnY3HZNv7OAtqswQvjb3aE0bqGVngXb2nbyl0Bp0
         TkzLqPI8j0OdDrkDWZfYOm+6gF4C0YC25rElTQE8HWIUck6KdnJEh8KQvUqn10jntAH6
         MlFC7E7/nJQw7wYZxz0PYlY7XVboE5D1FkuogrYeCywEDFY8VSN910NjT0FFbUuLGWJP
         WYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674443; x=1795279243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXkHJphoEY20da+45qB+WjPGBGb3UoQAwSXHDIUPxh4=;
        b=wa+06DQ1Hg/0+2plYXYlE5qL2rdlb21GRfV4rzRoXscVeykEGf6T+eXQAtxNEJ1ZFr
         0nDX7hv7+YD5WTuga99EkN3D0QGGaSSMxGHwunTrstOElYQE3IiS7ji8qUINA0DwwJrM
         5+/i2/h0SsAa3jz6HoZH91VsPQyo8bo1s8Fnt/GF2RcJ0xFhlyVGY6d0Y7yemRF7oAxa
         Ngy0MmDLCkQoS6qDRuYSBGC6Rs5gyEV08cu0JsZMEUk7R7Ka70gEF1K3RMvSBCLyfJCL
         b1eE888Iu/sZtPqbvO9O1K/Qkx5pwB3xhhehqgJwS4weZUwa6AEdM4BKP1YLAX3EeIBk
         8PJw==
X-Forwarded-Encrypted: i=1; AL+hErHW+1Ms6WiTTv9Ah/yyQl3CIu4t1QyMclHjCYQF1fXtWSK5ZKhG5mSI8e2HUdRcGMvoKRV6lB4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EPpU3PH4kJq4ONUjUjMgbkUQ3a0enAuLyHIvaPRJbTK9xOqqJ
	X7MzCYt8fv6ehTvY3XUwpdY2AGsqW4APBCtJGV9RMdTZo1O0kSiKwgZg3Z+9ApaqrptnABMoIvL
	dXM64JDaZ9NAWNigStbQeMpSc32/OGuND36nIri50nbf4tjOOh+fxdzqqUqTgk3sxUGyEIr9oLi
	IZZ7r3ggfaIiRu0bPRzhBQIgbI1yCYGg637Q==
X-Gm-Gg: AYBFou2pLxJS7PWdavrEeA8OeU5Vy2zYNdhZyMXVi6koVpBoOncgiqqtlK7ymvtU3qH
	gTnNQo1Mq1iK/Mg8QRORJZrbTrX1fz/SWqrQma5vF3mJcKMC8UlSHHPAgiFeAHcQMXuArpRNFwm
	fyrKBJD6cPaGpX6JKUrVBoy+txHfG+031qVDFN8/d0chnAyJ7OQSMur88UGMyOuwtfshLFnk/Qj
	UMFBa2TmIiV1TZx0LzSAg==
X-Received: by 2002:a05:6820:1394:b0:715:453:c6e2 with SMTP id 006d021491bc7-71ab4fbfbebmr3860134eaf.33.1794674443059;
        Sat, 14 Nov 2026 08:40:43 -0800 (PST)
X-Received: by 2002:a05:6820:1394:b0:715:453:c6e2 with SMTP id
 006d021491bc7-71ab4fbfbebmr3860118eaf.33.1794674442621; Sat, 14 Nov 2026
 08:40:42 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CACSVV02fCwbFXVjE+XHCo68xMxYUHovJ9ZHRYd98L74N1T14Hw@mail.gmail.com>
 <20261114153622.148125-1-arpe1618@gmail.com>
In-Reply-To: <20261114153622.148125-1-arpe1618@gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 08:40:31 -0800
X-Gm-Features: AclHuK8v6yocAMov5_kcb3jEgrVHdGlRUdiYk4AGEpFJ8mzDlgn5asj4NprUyOQ
Message-ID: <CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
To: Jiwoo Kim <arpe1618@gmail.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: oPYEUXefY4u9-5CcgL3LaY9q0d74hkah
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af88f0b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=2g9MNY1Fx1-Z8oZBzW0A:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA2NiBTYWx0ZWRfXzysRYj1mS/wD
 qcQNWDJjVKAQUCzzpvQKLAhER+wfVDeIWEM7aWrzrpTx0CApp9s9Rq9bw+dD+l0QCSXMBzlySVI
 wbh3i7+Vx+Pi+7zumytjvUPKlH9DO4R1Dm6aNZLfJ2ZAYuZrYauctCNwv4J1ucPFhBTyjSvp9jy
 f/ferb4jP0fA0EmZmA652zgG5Mfzn9Oxn5BDnOnVj0ZOsjb9qie/0+rLIY2hgafiFf6vDiWU7nZ
 8dWKSkQBx9eCL+zKEDYaW36i4mzs6GVge9pwIUPbztTOPsjzFhjccCAHgxh064zQrKwYGuUTQWN
 9VwZum4l/BpxoVuIfEwbPLIjue8ytKnT7ki4hADM1bllIgZ78MTB0G3OTNe7iVxR4V5dwBqY1Lk
 nV3p46OW5zgAxEuTglrVYLpD4oOaL/J1r+xIFezbVcn1Qbw6Hscgz6/UxU8J6VEdSGF1uWW8+RL
 aK7TxoL5V3YM6WVa4CA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA2NiBTYWx0ZWRfX8dB/nuKSIQPG
 OgESrgdzsUoUghpN/A7XkUp57swkWOKn4EoqP6ST+02huwOxYEJb5y1eFfYsIy9i5nripGk0v8K
 BKZGle8STEQPim+6S0e6Nf4OILpRC6I=
X-Proofpoint-GUID: oPYEUXefY4u9-5CcgL3LaY9q0d74hkah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140066

On Sat, Nov 14, 2026 at 7:36=E2=80=AFAM Jiwoo Kim <arpe1618@gmail.com> wrot=
e:
>
> On Sat, Nov 14, 2026 at 7:03 AM Rob Clark <rob.clark@oss.qualcomm.com> wr=
ote:
> > msm_gem_vm_close() waits on vm->last_fence which will be signaled
> > after msm_vma_job_run() returns.
>
> vm->last_fence only collects the fences of GEM_SUBMIT jobs, in
> submit_attach_object_fences(). VM_BIND jobs don't add theirs, so
> msm_gem_vm_close() waits for a VM_BIND job only if a submit depends
> on it.

Oh, right.  We should probably just update last_fence for VM_BIND in
the same way.  (Ie. using dma_fence_unwrap_merge() to deal with the
case that the current last_fence is on a different timeline.)  I
overlooked that.

> > My expectation is that if thread A is in midst of a VM_BIND ioctl,
> > perhaps not having created/updated last_fence yet, while thread B is
> > racing it closing the device fd, that file_operations::release will be
> > called after thread A's ioctl call returns.  Is this not the case?
>
> It is the case. (The vm_bind_closed check in patch 2 is only for
> MSM_SUBMITQUEUE_CLOSE, which can race with a VM_BIND ioctl on the same
> queue in another thread.)
>
> The problem is a job that the ioctl has already pushed and that is
> still waiting for its in-fence, e.g. one from another device or
> drm_file, when the file is released:
>
> - If the queue was closed with MSM_SUBMITQUEUE_CLOSE first,
>   msm_submitqueue_close() no longer sees it, and nothing waits for the
>   job. Otherwise drm_sched_entity_flush() waits at most
>   MAX_WAIT_SCHED_ENTITY_Q_EMPTY for an exiting task, and kills the
>   remaining jobs only on SIGKILL. Either way, the job's reference
>   keeps the queue, and so the entity in it, alive.
> - msm_gem_vm_close() then calls drm_sched_fini() on vm->sched, which
>   frees the run queue that the entity still points to.
> - When the in-fence signals, drm_sched_entity_wakeup(), which the
>   scheduler registered on it, uses entity->rq->sched;
>   drm_sched_entity_kill() leaves that callback in place. A killed job
>   is freed then too, and the final put of the queue calls
>   drm_sched_entity_destroy(), whose flush reads entity->rq->sched
>   again.

I think if last_fence is also accounting for VM_BIND jobs, this should
ensure that all VM_BIND jobs are also finished.

> Patch 2 destroys a VM_BIND queue's entity when the queue is closed,
> by MSM_SUBMITQUEUE_CLOSE or on file close, so always before
> msm_gem_vm_close() tears the scheduler down.
>
> This comes from code review (see the note in the patches), and I have
> not reproduced it.
>
> v3 is at
> https://lore.kernel.org/r/20261114141851.134290-1-arpe1618@gmail.com
> and its patch 2 is unchanged from v2.
>
> Separately, Sashiko's review of v3 found an ordering problem that
> predates this series: the VM_BIND queues of a VM update the VM's VMAs
> at ioctl time, but their pgtable updates are not ordered across
> queues, so an unmap can reach the pgtables before the map it undoes.
> That does not need a queue to be closed, but v3 patch 1 adds another
> way to get there: the unmaps it applies when freeing a killed job are
> not ordered against other queues either. (Its other point, that a
> killed job's fence signals before those unmaps are applied, I'll
> address in v4 as well.)

Yes, userspace must use fences/syncobjs to synchronize VM_BINDs if it
is using multiple VM_BIND queues with overlapping updates.  An error
would mark the vm unuseable, and the kernel will stop accepting
SUBMITs and VM_BINDs.  But maybe we should also handle errors in the
UNMAP path as well, as that also indicates that userspace is doing
something wrong?

Userspace shouldn't be allowed to cause the kernel to do something bad
(use-after-free, freeing pages that are still mapped, etc).  But it is
perfectly fine to let userspace shoot its own foot, for example
triggering an SMMU fault due to pages unmapped while the GPU is still
accessing them.

BR,
-R

> For v4 I would make a job that unmaps a VMA wait for the job that maps
> it. The other way round, a map that overtakes an unmap of the same
> range fails or gets undone, which breaks that VM but doesn't leave
> freed pages mapped. Ordering all VM_BIND jobs of a VM would be
> simpler, but turnip uses one VM_BIND queue per device plus one per
> Vulkan queue. Would that be the right direction?
>
> Thanks,
> Jiwoo Kim
