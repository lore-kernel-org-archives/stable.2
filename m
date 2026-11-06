Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952548;
	b=vjX/tdkEyBbIMRKMmk4HdPmY+R0MIAIiS8t/+1HoNbiQkul/M8BwaKKRMpWNrb7MA8/U
	 hq2Pu88gIWgztMfoIGilh6X/Ebs+K0mjtTea8HPtVCHzfm+ItwVBifMnKc7tobl0PYC0I
	 7uqgHNvQAgsPHNKbD62+IU7hz1ROQiujDbIUePk84bRQRW2uNdYzK1nhjBdJpa1rN2IpQ
	 BV3YZb09xW3J/J8n65VM3Q+I5kPumISxQCaxf+3DnO1PDya+AR/9AjaPIO0Okh0LrxEhX
	 7s+fxC5lcWncCVugW1m3sI22WBK2EseT07twsMxQ389LOAi8dDWUDbtUiPfvQCZa1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952548;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
	b=lR48Z5OcC1SDRfB3ID94X2j3DhOfEcj6aQcaDMcMwcFfTyFBft3tOwDtf4puhxEOc/z8
	 q/WtKG7spFjZYOOd54rf+sAIcoaqHoDW7kmhGJ0/FT+2ol8jwyta/Nc7Xkn49ahz6m8pH
	 PY1BJ7AV41Sx5wBeyFfSZZJzsK4dYnYiO5ePO641ypEasWfKpFUjxQcGHGzpTrN3bxbjS
	 fnb88ml7t2wgIaZYFPm9vKVBcWC5wzRSMFMtq86rIxsFpp7Aty9zCA2zISPxBwuyPQJfx
	 k/aM4R1fsHUPny2+FafJbwopllnuzVzK7nmsx1R/103Gw+75Frfa3epoNyIlfi5nszw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AbJ9Wy+B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+5WnqNL;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B67A606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B67A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AbJ9Wy+B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W+5WnqNL
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67R6nx129135
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 08:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3FN098lze/WreTU28PCuTM35
	o6JS53fRURS5tMMldcw=; b=AbJ9Wy+BGWSUUH9wM7T+vApfarg2d5aL2VfAHDWj
	GhUMKfrdKJ86TPGiMyH04IssKqbRH94JUhqG3Dw3RLpQdIi5mrg3/TKtjcR7YIkv
	76n2JttdfT4dE3IY6H1CeBA5znPQQH1w+HV8O2TMvmV3QM8I19301b8J3Svf/Jg8
	Zt2XDBTOqJhy4CYjdnMaqwjaea9pJXcUclsD71pOcHnJXeWOxN14faTP2Xw6E2dR
	sqS2I9k0CrzYh0Fq04HwIsNi8znH0/OHcPAzoqchi2oBCVaArDIfVufgsO0vqI8y
	JbqhazuSXwZC51WG1VA4lHvCO2DQAJL+AqRsMixPQZ2YUQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9ssk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:09:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8812a952ef9so3552b3a.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 00:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793952542; x=1794557342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
        b=W+5WnqNLgnUkA96m4xDQsNFNkogAIVhY/IoHh7T8eL66nYGKD3LigaY6OiwnTt6Tj3
         SqQHnaHk9ay52LrIv0anoH9ECLdXLJjv4z8/Rg8vZDwmnpP5sBydvYn8GY+E3vZU3WyQ
         84BidKpug+JEHA4dwEoYTt7B+aiO/eKcOYYW0rYKORqHD9FRMXXrkIeQ2+ilxrkNKJdr
         REMbJq7DbRtdrweB1UxYQdiXnrE4GKQV9KhlaQaEh6rjTxTuHEAWnHW2wQIuKr4BsyD4
         Cj619K8QF7llPgBy+BoNFESgQY8IGBk3r2h62WKrIdMXnQtWXFzpeXI2kr8poqPiq+6V
         sAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952542; x=1794557342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
        b=2GIsaSTiN3+bS/qY6AtJsE/FSWg5reLpf3H4DTt4pl4ur5vU55ckoGvqja1DG3/Ut5
         hKoZuorvj/20jVieLkkp+Qq/+E/QIZa7y/Phn769aznn3PSVPo3tciy6Z3O3u2iBL9f1
         mIbyarbsjjt4gh8qjEtc4Lz5xuVjWRi7WIged0pUKVBwkU41E6fR0cyGAv8mUSJiuAaG
         g119LQsxI6O435L02Dnca6MNEEDpQYtPREpEXcRKrKxoEq1l+QvUJqzIBIAIPgDp/xEg
         tV5yUlMM4fxfeYRxk0um7ClnUlW+eeVV47vS5ymoMhQ+YhOta//jcNaneUUJpknVe5E2
         BYsg==
X-Forwarded-Encrypted: i=1; AKwUvBzn8IchIs4yMN1hK1fnq1CAdX+3fpaAfgtUaO252wOHxR/CJLd6/aFOQZ/Jll04T7S1jQ3Y3mM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+djAXI7/h3feXdaeEJOM7Be/qxdwVw5J2MOBhZdz1fNUO7LMQR
	NOl7jM9VTYTYZMvbqsoK21fqq6HwaUs6+/LEipZ6ASRYsIEQGDJGydVI1zoG1p9+5Qcd1bcgJju
	KJ2LiPAv6hdnw3JyZCn6YwbQAoqTRj7kNtbb+rAu3znp73mnsyDLBvlKncG8=
X-Gm-Gg: AYBFou3eUwA4v7UUwcIxU5WjMZJzH6tRACJnf1nLkUUNE8cPFxqPS5M7wf/gZpD/+Iu
	wEvd94QwIYA3uEhd36NkOBUGe01yHCW4A9YuWoJaaoiuzNxSkbiUoD1SsfqYUGJ9wT+XsWMSM7S
	f96fAg63F48PiZOVDx6Anm6G9YDoVlxfhJJ0cXuDTZ4Ggjy+gsEzcrkcr00FTboGHsmLjzgr07N
	hpBTd6Pw4KbK9Dt1mcL5KBZHHrLKxwMGznWvAmCeQIM45QJG+kPlpzoDw7A45p+8n4cprFmIRkb
	Cjc+dCWhRdczOZzRxs9xxRTcxs6wovZJHYkArjoXWae+gzT2ScqkwdUeiQJvYc9cDEjA0q7c0D2
	VmXii714kU+/bNm+PppMD+v7lTKldZduL+fN31aqAb8pc1UexEInrf5H7EbdmRIl+RE+PZVAEWZ
	BTOsBqhqdp7vrz7bue0sQzbtRp1id6RLFt7XKtwXt7TZqw4AS+sxftDbFwSwXzyyWZ0uaPjAiGn
	98el5BTC/nDmkhdatttfsGMxCxR
X-Received: by 2002:a05:6a00:890d:b0:8a0:646e:7e16 with SMTP id d2e1a72fcca58-8b37bc5ead6mr1669817b3a.2.1793952541847;
        Fri, 06 Nov 2026 00:09:01 -0800 (PST)
X-Received: by 2002:a05:6a00:890d:b0:8a0:646e:7e16 with SMTP id d2e1a72fcca58-8b37bc5ead6mr1669777b3a.2.1793952541282;
        Fri, 06 Nov 2026 00:09:01 -0800 (PST)
Received: from hu-vishsain-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35921dc8bsm375950b3a.10.2026.11.06.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:09:00 -0800 (PST)
Date: Fri, 6 Nov 2026 13:38:50 +0530
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
Message-ID: <au2LEsJjuOgKit1j@hu-vishsain-blr.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
 <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
 <20260915073614.nvT9zW3S@linutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915073614.nvT9zW3S@linutronix.de>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX41GnAH3luhWC
 LGNFNYSHYoqbceHphq+Eezt3RqOH5Xzftyrrh+PVaO0kb69/fbkL2FrLoDhNv4CkdJdxEEvGldD
 ln9BKzBOWY4Smyv0JbVIWFJ8PTtmK4Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfXzSY4/Ec8/D7J
 brHjB+6ni6unfQ3tHayvF/3JieaLe3A7a/IT3lN/UKGSGpcMWqZ/xpLRknsYEGMu8m37M1bYfs2
 7B2jbkRsNywS0keB9nSqjxR8Vsg4CqQl5Fa/bpWtQu9+kvsBv/5N3KyOS0DKkdB1dV0R7S3+Zdw
 GSv7kugNhg+tg64ykPy5vWKmG20FAFQXfX0P9r/FcA8CnxhFL592xwrVd5sPsI8cIRyEL6tASJs
 R186aVM9tC2/r+QjvCqyVaE+JHY1Om2dnfLh5dmyhCm9tFGDm0hJG3WqA1sqUOD1RIrpUgnTEHw
 7mfzgoHFAls2UoRH7sw+s3IfOWWi1krCBHX5eoIbhQ/DcD11yrFv6AKIGWapzbMx2TzKQu4VCvY
 rEjiwipjYYq5K3H8fWmEzdOIZU3yrMjsRjxJjhaUPKI1UzKORQNSv0Ngn3UK/UqPV3CYM2RQheO
 eGmoDp5IIy1/z3Dzq5g==
X-Proofpoint-ORIG-GUID: mJQ3FGjoYebvshpP6tTaYKcuMLgm6bMP
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aed8b1e cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ZNqZZCZIVyXZx7ky4tIA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: mJQ3FGjoYebvshpP6tTaYKcuMLgm6bMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060032

On Tue, Sep 15, 2026 at 09:36:14AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-11 18:14:04 [+0530], Vishnu Saini wrote:
> > On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > > > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > > > 
> > > > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> > > 
> > > *why* is this the case. The code you replaces adds some ifdefs around
> > > request_irq() with 0 as flags. This does not make it run has hardirq.
> > You are right, the statement is incorrect, i will update the commit msg.
> > On RT kernel, the dpu_core_irq() runs in threaded context by default.
> > This behavior is changed in the commit by calling devm_request_threaded_irq with
> > IRQ_ONESHOT flag only for RT kernel using the ifdefs.
> 
> The why would be interesting. Usually things stay threaded to avoid
> locking issues down the road.
> > The irq is now split into two parts for RT,
> > 1: primary handler which does not use sleeping locks, and
> > 2: secondary threaded handler which can use sleepable locks.
> > For normal kernels, the request_irq() with 0 flag is still used as-is.
> 
> If the split is properly done for RT, the non-RT variant should be able
> to use the same without any ifdefs.
> >  
> > > > but it dispatches per-encoder callbacks that take sleepable locks
> > > > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > > > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > > > inside a hardirq handler is not allowed and eventually crashes the
> > > > display, which is what happens after running GLMark2 for a while.
> > > 
> > > That is correct. That is the irq handler are threaded by default and
> > > only non-threaded if explicitly requested.
> > > 
> > > I suggest to stick with non-threaded by default.
> > > There is only one request_threaded_irq() as far as I can tell and this
> > > msm_dp_display_request_irq():
> > > 
> > > |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> > > |                                        msm_dp_display_irq_handler,
> > > |                                        msm_dp_display_irq_thread,
> > > |                                        IRQ_TYPE_LEVEL_HIGH,
> > > |                                        "dp_display_isr", dp);
> > > 
> > > and its primary handler will be threaded on PREEMPT_RT, too. So you end
> > > up with two threads here.
> > You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
> > But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
> > The issue fixed by the current commit relates to msm_mdss_irq crash stack below.
> 
> Why is it the way it is? What is the issue in the stack trace below?
> This is not described, is it? Your cleared the top of the report.
> Now, msm_dp_display_irq_handler() ors the return value which is wrong.
> You can't return IRQ_WAKE_THREAD | IRQ_HANDLED and expect the thread is
> woken up. It appears the handler is fires over and over which implies
> that something is wrong with your primary handler.
> 
> The way this is requested you supposed to have threaded handler and a
> secondary-threaded handler. While msm_dp_display_irq_handler() is
> invoked as threaded the IRQ chip masks the interrupt source. If it
> returns IRQ_WAKE_THREAD it supposed to mask the interrupt source because
> the IRQ-chip unmasks the interrupt while the secondary-threaded handler
> is run. It seems this does not work as intended.

Thank you for the inputs, we are further debugging this issue. The crash accur because of
increased unhandled IRQs on RT kernel, will share update once we have root cause of
increased unhandled IRQs.
> > [  152.108462] Call trace:
> > [  152.108465]  show_stack+0x18/0x30 (C)
> > [  152.108477]  dump_stack_lvl+0x60/0x80
> > [  152.108484]  dump_stack+0x18/0x24
> > [  152.108489]  __report_bad_irq+0x4c/0xec
> > [  152.108496]  note_interrupt+0x340/0x394
> > [  152.108502]  handle_irq_event+0x94/0xa0
> > [  152.108508]  handle_level_irq+0xd8/0x16c
> > [  152.108513]  handle_irq_desc+0x34/0x5c
> > [  152.108518]  generic_handle_domain_irq+0x1c/0x28
> > [  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
> > [  152.108654]  handle_irq_desc+0x34/0x5c
> > [  152.108660]  generic_handle_domain_irq+0x1c/0x28
> > [  152.108664]  gic_handle_irq+0x4c/0x140
> > [  152.108669]  call_on_irq_stack+0x30/0x48
> > [  152.108673]  do_interrupt_handler+0x80/0x84
> > [  152.108678]  el1_interrupt+0x38/0x58
> > [  152.108685]  el1h_64_irq_handler+0x18/0x24
> > [  152.108690]  el1h_64_irq+0x70/0x74
> > [  152.108694]  __schedule+0x6c/0xc9c (P)
> > [  152.108701]  schedule_idle+0x20/0x40
> > [  152.108705]  do_idle+0x17c/0x2c0
> > [  152.108710]  cpu_startup_entry+0x38/0x40
> > [  152.108714]  rest_init+0xd8/0xe0
> > [  152.108719]  console_on_rootfs+0x0/0x6c
> > [  152.108726]  __primary_switched+0x88/0x90
> > [  152.108732] handlers:
> > [  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
> > [  152.108859] Disabling IRQ #246
> 
> Sebastian
