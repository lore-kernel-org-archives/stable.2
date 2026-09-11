Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84846A5FB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130658; cv=none; b=bWRLdyaFklj1sHKhrOPyfWMuePJihMEvIv0RJEJPbK4vCH52XCGh51t4oEGKY8A7BeTzJzTYEjhXF8U62tFx3lftLAysbKkoXvKLpg7slL7ljN5i3TLx1t9x5p1fWGaY0TGPoMBtrfsWkLJjZPcD9CGdU2eHLkrwBmtTixjE9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130658; c=relaxed/simple;
	bh=Iw8u2HFgGqDAoQrrT9wzoBb0ozZH/XWjDz6cYa9Fox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnB26G8JmHZSTeR1AwMkee+B/NCsOqa52uqVL1tFVSTl8D8KvK0bSmAe9P5oPu25I+eiiqhszf2qWU2v/JgYl8YWMzYkA5YAhqRWB8/lNYLztiAFhmyLoRL3OjNKW23asXshcXSHqhJ4w+p1KXxOFLCk4462fUDxy6mOzKcuAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NjK7fcb6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fKiQYTbD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjK7fcb6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fKiQYTbD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAqCVd842081
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hs3C87rUc37Br7hDul2xSyhF
	h9hB6GXOl4E84myixsI=; b=NjK7fcb6JPtbo5k6auGunh1/s6S8cSB7/2xfUCb0
	geBR6XfxyIyAv/YgcP8Y+c9tuKr9gYAo3B6JafTG8Heot7v1jkoHq+1UeI5/8ix4
	uIuXBf3NIewBEGLANgLEDH4Iv91nN3YQ4OrelX0svTbAYm0QAF7onmGlMv1xOTv2
	pqTqXF1qOaUn2TSkn2Zx+Zy+UlzWsOMcW6qV/pxCY0hCDp6ut9jyKGe+oY6sv/Jx
	mJYOXFPLWKjH6vg1XX2p8L37maNfpKt26iRisfXiPNpqJvnAdB1w7P207DHsAOw9
	m9cW25yCDc132GIie1OvaXAGaotgkwZaoA4TdtHSVtUrIw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbf8hr13-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:44:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d0e306c7d0so1886395ad.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789130655; x=1789735455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hs3C87rUc37Br7hDul2xSyhFh9hB6GXOl4E84myixsI=;
        b=fKiQYTbDKQfAi0S23XtJQ4AeV/Q42iA9GSeFDLieoavnkmfTPp0d5k5tawdaSIUc46
         E0V0yRBcCBXN9TjyVdkZEW3BAawVbG8PaSvbDO3XxkauzwfhLakBf44BbteZmIoczD0G
         pTyO+m0aRlQPpLg9Uw8aaacI56stDtWi9YuxC3CJzxDfOCtYrNo9iJwOpEdcGXwW9To1
         rGy8VvkgtxGn6YHFULweROYK+I5StwYfL90IDASdz0EVXy11u3Vf26RwHVeI5aJ/E8bW
         Y7Yq3lWv2rCpYZO8FU8bAW2OBjHRkerW9oAk+CddqHgp4WntOzM6EQiZVKUGkMYXY4u0
         hWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130655; x=1789735455;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hs3C87rUc37Br7hDul2xSyhFh9hB6GXOl4E84myixsI=;
        b=OernvLZHhRW9427Hlo8/Gn8oZNI/fyVioUaYvjjkGMHGwm3qKbIYFOEV/reT3OK8H0
         79T9T3Ns0mdE4JW8TAvSU7gKJOLoheRi7DBP3PGdpRsI8+UTYusRAmqPIGwiEbF9y8Yo
         Wr2Lk4f0pe8IzVaFoi3HZ4TVVlz+6fKlnkgrSGLYD+l5kKv2uFDoSOvi9tgsJTguepSs
         h8i282K78gylrxihjV8+k8GXYpckqf/UMF+XFWla4WJdlj4jbNZdRNMyxtaA/qD8S8mc
         Cna0lWo+chSfOzCVEavSGQ/Q/tB2ZbKz10JzrmetpKFMEbbzfQqxoz86jD30gD068ByA
         deDg==
X-Forwarded-Encrypted: i=1; AKwUvBxRij1E6hr8V5Cz/hvtllsbQvRNZwtWeKihSajuRDJyyLeQbDVy2aiT82HlzaXdoQRl/9KPA9E=@vger.kernel.org
X-Gm-Message-State: AFuF++ktFwOQbnTvrqfJa7XoVNkngSQZDwnCtwwVka/Qo/J4kHAbYsYE
	+oa1//GaWTsFKREmZz6bU5VJpMwegocdJhes6Txr+q2XxtKVWbQgnGVzem8oFeMQ4tUsZFTc6C/
	vW2gbJ8znszFxWFMMxhgVF7V85lE6lqZCLtmK6/5S8dNban/nzcFtqHx1vyc=
X-Gm-Gg: AYBFou34fG3yc+ezg31DXYpn9vb2JKu4n2HMQ5YnXK47//nIHejXG96PxmgT+C6KBxA
	+NyKtF/op2ubu/wh7JR9rt1QXb2Ld0D56PVa/XmV5v+N2o8j9E9+mAb/4/JH34O4tQ5N5TmpPKd
	2iRSOobKnCe8zutUxkYAKepNCNxAunG0bzOKb8Uxi3N0jNcgfDCWvVa8qgryCcJk41gQpu3Mima
	GhP8HEavoqoD/F3h0Tq2+dGhzxnwLDD9HGZYLja6Ooh+qs7B1Jxu5BY1SSzoBs60O3J1RPgYztl
	PsC1Ain7esYexCQVc/hTcGq7FgSWkKrRwSxwJOXR0VCGBASQVlv6n9jSgK6bSwjq50/MwK1xeCq
	yJHP4Kc6jRGI+nhsn1X0KbeqJoLUVUs1OeniDqE6+d7jXlUhZTQQFr3KWH0rqE8S7bdLAFahkLw
	M62lXafYNpOW+5wjhMh7lq
X-Received: by 2002:a17:902:ce12:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2dd29e0eb11mr52067705ad.0.1789130655008;
        Fri, 11 Sep 2026 05:44:15 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2dd29e0eb11mr52067185ad.0.1789130654445;
        Fri, 11 Sep 2026 05:44:14 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3f0faf19sm3636485ad.12.2026.09.11.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:44:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:14:04 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        venkata.valluru@oss.qualcomm.com,
        Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Message-ID: <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910064723.pbZP3vic@linutronix.de>
X-Proofpoint-GUID: 48lCqnLv-V695vjJfKQ9JrqQVgeeo0Fq
X-Proofpoint-ORIG-GUID: 48lCqnLv-V695vjJfKQ9JrqQVgeeo0Fq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE3NyBTYWx0ZWRfX6pkt3449tcfw
 9QRHCPVimV84B2UeKobjYwLNuKaO5fB7VEet1z63yiwy9Zzkc9tWLjY8i9j+wxdOL0SC/q7fvwH
 /G33Uo5hTO9SC5h1uiYwxsQCRP+jwMTWsCJgpyJ5JAYNbILLtbgLmojYocwe6mLqtMOOdYmwfq1
 FnJZfQuQ3SWWOhR/c+7Vhyoeh/OMx6xGwPByQFihwEUrAzq2UtfeejlkIqaUARbT4BrOouhN7H2
 mQ6QRXX8Fz4KBBMxlz14Er9FWRndA9ODZflN2+nCpHCNJUk3SXru0WfDCSmYSbJ50v+NXXm6RBx
 mMcb04JVqttl1gOS2Ot/CCvgxSgiypbfPXKdoB6cfXyRSuoG1JTRAYN5myoEW8kyyMLvoBPISwc
 aSR+xM3A930+J6S3uVeBNb1T9ZFb0W2UOnJKo77KOKHMRLinmsEsGLdwOnV7lw1dkDUSPaKDE3B
 PmG7rx2zRzJeJwNv8Sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE3NyBTYWx0ZWRfX9KZ4z6lZF0vd
 ScoWnJRyBaKWWui3jd0ZQdXV1qCbgea6zt/3Oqpw0NLHIp3ZH9P/+P+dDqJnBJGz4NH5T2NCpev
 TvOpHXF8Dj6kGVFMTjq1mEWzcetl1XQ=
X-Authority-Analysis: v=2.4 cv=UJFIjyfy c=1 sm=1 tr=0 ts=6aa3f79f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=p8fm3qIaiwJ8G5vN5j0A:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110177

On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > 
> > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> 
> *why* is this the case. The code you replaces adds some ifdefs around
> request_irq() with 0 as flags. This does not make it run has hardirq.
You are right, the statement is incorrect, i will update the commit msg.
On RT kernel, the dpu_core_irq() runs in threaded context by default.
This behavior is changed in the commit by calling devm_request_threaded_irq with
IRQ_ONESHOT flag only for RT kernel using the ifdefs.

The irq is now split into two parts for RT,
1: primary handler which does not use sleeping locks, and
2: secondary threaded handler which can use sleepable locks.
For normal kernels, the request_irq() with 0 flag is still used as-is.

 
> > but it dispatches per-encoder callbacks that take sleepable locks
> > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > inside a hardirq handler is not allowed and eventually crashes the
> > display, which is what happens after running GLMark2 for a while.
> 
> That is correct. That is the irq handler are threaded by default and
> only non-threaded if explicitly requested.
> 
> I suggest to stick with non-threaded by default.
> There is only one request_threaded_irq() as far as I can tell and this
> msm_dp_display_request_irq():
> 
> |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> |                                        msm_dp_display_irq_handler,
> |                                        msm_dp_display_irq_thread,
> |                                        IRQ_TYPE_LEVEL_HIGH,
> |                                        "dp_display_isr", dp);
> 
> and its primary handler will be threaded on PREEMPT_RT, too. So you end
> up with two threads here.
You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
The issue fixed by the current commit relates to msm_mdss_irq crash stack below.

[  152.108462] Call trace:
[  152.108465]  show_stack+0x18/0x30 (C)
[  152.108477]  dump_stack_lvl+0x60/0x80
[  152.108484]  dump_stack+0x18/0x24
[  152.108489]  __report_bad_irq+0x4c/0xec
[  152.108496]  note_interrupt+0x340/0x394
[  152.108502]  handle_irq_event+0x94/0xa0
[  152.108508]  handle_level_irq+0xd8/0x16c
[  152.108513]  handle_irq_desc+0x34/0x5c
[  152.108518]  generic_handle_domain_irq+0x1c/0x28
[  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
[  152.108654]  handle_irq_desc+0x34/0x5c
[  152.108660]  generic_handle_domain_irq+0x1c/0x28
[  152.108664]  gic_handle_irq+0x4c/0x140
[  152.108669]  call_on_irq_stack+0x30/0x48
[  152.108673]  do_interrupt_handler+0x80/0x84
[  152.108678]  el1_interrupt+0x38/0x58
[  152.108685]  el1h_64_irq_handler+0x18/0x24
[  152.108690]  el1h_64_irq+0x70/0x74
[  152.108694]  __schedule+0x6c/0xc9c (P)
[  152.108701]  schedule_idle+0x20/0x40
[  152.108705]  do_idle+0x17c/0x2c0
[  152.108710]  cpu_startup_entry+0x38/0x40
[  152.108714]  rest_init+0xd8/0xe0
[  152.108719]  console_on_rootfs+0x0/0x6c
[  152.108726]  __primary_switched+0x88/0x90
[  152.108732] handlers:
[  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
[  152.108859] Disabling IRQ #246

> Sebastian
