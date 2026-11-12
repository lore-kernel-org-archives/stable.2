Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467033;
	b=Lg8y3r6KJXUn1djfEVwYi+CIWs13u44H9fdQhOnW1rC24JvuNuMUf5mYeYQPdcO9B+10
	 jZUQF3zhk2c5D7Ho2d4ZDfls0KYjZhP5Q8tCIxFgeeuNHKyejjdtIO0gcmZDUGeuhXNC3
	 l80nJ7G+iY5v6/FgmJpWPPOuAEmQf/Xermqhnnooqh/TaC9Wn4HTcw3Vne2rAwwxX4UBx
	 FJpwPFUbWq6aZtpvhL53zKNzPXPRE6oYYFQAVuINN6UfLBIFPWAaCtzBEsaRiQj/aDdi1
	 YFZY2BZ4LIuKmAUjnhAfYM/c2MzwjGh+VkGz2rFJUCDreWGyeFAOGGfktUbTm6PWpGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467033;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
	b=TDx1gPIwTaea+ay5sYtOVqkKqgNdz0I+nRXDxTIcs76zdO/JmY0DlZV5/pp7TeboMLj0
	 EBBmeJNmCvyyaiJE09xihl8IknPtiC7gObxgxFXtOOo6l4dpdd5uARsrVIFVzeR9CQeAU
	 DAcnYtukpcZr1SEiU22goM+TMuDYu+a1A/ld3Gk61hQocT55IbTZyp+tgQeRP9tWqVbRj
	 okj/IYSCCshTwPUJXpJ8a55gKcyeD/d31yfQnya70VBtd+wvGa3gIt3bMnnmszGE8yHG2
	 remu8+Ld6vLNsBQI8RAWGEoesiQvt/T7p9/FHHIe0XweHWxDF759rE7zhcL0xnqBk4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UU4sr+KE;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qV7AOgop;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9D606A330
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B9D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UU4sr+KE;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qV7AOgop
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794467032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
	b=UU4sr+KEXLWG/VMn1tojphdaL3NHxohGi1XR7H6d1DZnX2DZ/Dmoe4EXaCaFOPROeVmBuD
	2Bfbh3HCYBFXXQFQrUCiXcYUeVnOSG812IacDyGUJsnzLOreHMjOSegjGGe6KiHolligtl
	OeRD6FxIHNmw1C/SrndI+EtsqjnDOk8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-PY4ihT4XNxWzdITWQOvE0w-1; Thu, 12 Nov 2026 02:03:50 -0500
X-MC-Unique: PY4ihT4XNxWzdITWQOvE0w-1
X-Mimecast-MFC-AGG-ID: PY4ihT4XNxWzdITWQOvE0w_1794467030
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so30224755e9.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794467029; x=1795071829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
        b=qV7AOgop0W01vPhiKpcbR1iniUM5nKXxDo0iqseOsfEa7Vdop3uUtjikrlcz9SfGhX
         swRduSSzYFGPA6SA1t0n/QbHVPGxqpAkLR364JdwWI2FHto12oirN84ozqFqFMq20r1F
         WUyGD/gKFIKiGOgs8EB7mvjygEmIB6oYqrdDeV6MTrTONcrBiyutaMcXH9UZPOTY+izo
         bdNJUrD04e5vd9Ifm+3QURW2XY1Q0PG5n3UAVMkxJDF3iaDVeuxNhWZcsf/3oDmoYqfu
         VTbWQJzjrzM8tI5fxMlDn45A68wJutyg/8IB6/YQC8CI8F4D7IsPPkKg4DmE7om/b3Tw
         eJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467029; x=1795071829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzKSTO8LvpR1kk43PP3scsPYLloAVo4g9q+JhIcdw+g=;
        b=G2a06OPRv+sPP/LqQLHbnfKS6khKdFlaQIzOJXQpOokmvDLRaZCzymBMAt7b07UaEx
         e/CUi5mZ7BnrtBC9sI/3AZc5GlK0c2AU3OBSN81/6J8fIn74SmIEzmvF1vGq4qB1DNjH
         py4zA1Vdc/8pDa2SwcZh8qbaeUY4gpKCG9UD0++NV2fuadg0HRGRovOr/OIWjdhhTxQI
         LPJblwFhsZI8gZ/PJHDiclUCiHXz/meF2hbq0wmuQV3UNIyiy47fB7fJsbLU2OQ/P4CK
         cA3i/utUfb0FdmoSy9nkq72laAVAlyB5q/Pim1mKJV2ErOG1qRWQmhd5uVgGooeBwGcc
         UDEQ==
X-Forwarded-Encrypted: i=1; AL+hErEpi+fPK6S13Yxd+zKnqB7LKchaHhf8sRczohf/mz2HLF9l1N+th60b0xo/8rosgh0m14K6pik=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ckcZoSrIQvZEuCoMxLqHFIEIcJrVItlObcUy+e9+239neOm0p
	fPKGxCl4V6rfVhTsl44erdwRYXM9Jz3owzTq+oOAfVGIURaIySXppnvFcwkwdIf6o4TDu/uBLid
	b1ysjV0zcbOh45iEEKSP3hyMy4HUJ88FcdEqwtdnRfqlbtb/Xep5NZDouDw==
X-Gm-Gg: AYBFou0N/o7NAl4peAIljzTh5b3jGW4NfZw/WTxFYGfcLGCcHaT9Wjn5Bn+iDKHdkJD
	kfU+ax4C+j3IqyAyVermo1jlfdWAekZinqEb87of9ZWOGxRDX+kDgOS3U+eV/EwDrNYjQPIs2i1
	GDSgL+fUnNzyJK9FDo4/t1beOnExSJbyTJUaog413KqG44MzWYLDGyW3PPUzj6wvG2mWqGj6HnK
	iFeZMWSYk20BAJZnCvY4gGEYnOSbUYdrJSGcRjbCqaXCOw+HbFvgIKThAs4u4IksVPpPpBIY9nX
	2jcyR1+/qwkWYA8S+X05fOul//MchFMPRMDPWmf+e3lDFTrTqNVY22MCmcFZfZMfYJvo2ufhH2i
	p3szHKE0nSj2hYz7/EFl9n7mm7BeZddzr2L+XhEqtCGsrfxxl565DXh5fHWSVteAi
X-Received: by 2002:a05:600c:46c5:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ba093ab88emr83497565e9.32.1794467029420;
        Wed, 11 Nov 2026 23:03:49 -0800 (PST)
X-Received: by 2002:a05:600c:46c5:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4ba093ab88emr83497045e9.32.1794467028991;
        Wed, 11 Nov 2026 23:03:48 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a495csm14952955f8f.55.2026.11.11.23.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:03:48 -0800 (PST)
Date: Thu, 12 Nov 2026 08:03:45 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 18/29] sched/deadline: Move a task's bandwidth only
 where room was made
Message-ID: <avVk0UU8IRGoo77v@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> Commit 7f51412a415d ("sched/deadline: Fix bandwidth check/update when
> migrating tasks between exclusive cpusets") moves a deadline task's
> bandwidth in two halves. cpuset_can_attach() reserves it in the
> destination root domain. set_cpus_allowed_dl() then frees it in the
> source, when the task's affinity changes. Its comment relies on the
> first half: "We already made space for us in the destination domain".
> 
> But set_cpus_allowed_dl() runs on every change of affinity. It frees
> the bandwidth whenever the new mask leaves the task's root domain, with
> or without a reservation. sched_setaffinity() gets there too, if the
> task's cpuset spans two root domains. With admission control on,
> __sched_setaffinity() refuses such a mask. With sched_rt_runtime_us
> at -1, nothing refuses it. The bandwidth then moves with no room made,
> and no root domain counts it any more. The destination would underflow
> when the task leaves.
> 
> Fix this by flagging the affinity changes that come with a reservation,
> as SCA_DL_BW_RESERVED. cpuset_attach_task() sets it, through the new
> set_cpus_allowed_bw_reserved(). set_cpus_allowed_dl() moves the
> bandwidth only with the flag. Without it, the bandwidth stays where it
> is counted, until the next rebuild of the accounting counts it anew.
> 
> The attach still flags a task that became a deadline task after
> cpuset_can_attach(), with nothing reserved for it. "cgroup/cpuset: Give
> back the bandwidth an attach did not move" fixes that.
> 
> Fixes: 7f51412a415d ("sched/deadline: Fix bandwidth check/update when migrating tasks between exclusive cpusets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

...

> @@ -2957,6 +2957,8 @@ extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
>  #define SCA_MIGRATE_DISABLE	0x02
>  #define SCA_MIGRATE_ENABLE	0x04
>  #define SCA_USER		0x08
> +/* The caller made room for the deadline bandwidth in the new root domain. */
> +#define SCA_DL_BW_RESERVED	0x20

Why not 0x10?

Also, nit, the comment looks off compared to the other flags w/o
comments. But maybe they just need to gain comments (I keep forgetting
what SCA stands for - Set CPUs Allowed, maybe? :).

Thanks,
Juri

