Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5F403EB9
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526513; cv=none; b=HM5hnPSBtAglhhhnHCciAmktHt85sVB2lNLi221/hC/kH2biqH1ZI/zVK+imqMrNpKg8xHzLAe9Dy8xaM53bMi4AMqZRcOlAxraVacY5iB33h7E2yAPFn76xSKzHKtJVcR5v0ywKgbB3N0U52xrWF9/r8PyQ4lJLq7ZrcPqFonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526513; c=relaxed/simple;
	bh=f/z0d8p/JHOHV8e2Y1/mIj34JxMzxElptOKrVDxUjtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdH/xcO7yVTxjwndYs2qp8BQ7ry9XDq34/I7ahcxPIXUcPD1DXQLJyOD834JBVGrGMuFdowD7ZW57o7LA9dW3kZiilFe8J6JQggEdPjGT6qmoHglO3cjTVdYzr9963vTxIr9zqDJzgmHDlQHS1ekuxgcZSy1VfA4VmpmIkOpSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vg5wChGW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qGIVrkG6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vg5wChGW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qGIVrkG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786526509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zul2jzYANCApDwLIn7fzzjcsabOj3YOj7EPJ6HMmOco=;
	b=Vg5wChGWfxZz6LenQySesWbI4/gPjMRPEoZj4wP2iZ7PphtVXSvXYvuyth4g6Yky+bc5z6
	kCjrtZD083aecQowbMiyMw2ZwGtQzU1tpi9pRGvp9aK8NFg1arCwu2RfkvzWggv1hPzpF6
	4aX+1WhM+QMwfQ3sD08lxrECkDAYiM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-zhtXeXoLNo2uLU2NquLaGg-1; Wed, 12 Aug 2026 05:21:42 -0400
X-MC-Unique: zhtXeXoLNo2uLU2NquLaGg-1
X-Mimecast-MFC-AGG-ID: zhtXeXoLNo2uLU2NquLaGg_1786526501
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4814718d124so463276f8f.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786526501; x=1787131301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zul2jzYANCApDwLIn7fzzjcsabOj3YOj7EPJ6HMmOco=;
        b=qGIVrkG6/uvzEN7q5ekPNyALt80iCWZLW3by/S+GLjKvAcDGudX8dsq5ZO8WdV7uGP
         0Mirzm6sgWv4cMH2Zqse596+zI6Hb6w7Ygz5ovk/ceQho5BsE8N95XL1xkY7NNeoO8je
         TY2cCQNuMrvSCiH2MnCL8oRLz3mE0qdV4sj/uZr1NYQdh7CW+aVHvfmKepJPur9GPr04
         Ifka4AgxIi6lIFb81HgqCqCXHA3Q32J4qBfE5XJdQLGf9JYsx3MXHywapS2xxosXEkd8
         F6d+VQmI/oYZBwlWi9g1XWl9rbQY5T/SrnRPzLxi2o92WARcSpDziWsRVlTy7sT2ovQ4
         WnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526501; x=1787131301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zul2jzYANCApDwLIn7fzzjcsabOj3YOj7EPJ6HMmOco=;
        b=nEokOrBtdg5X1NSSef8g6s3/mwVThpUorCqdrrHcoE7sJZq4jHqnU0+yxSmqWjE2iT
         QtfD4siAfZsyzsUMG1ESkL3f8HkJpLseFHzwK4Gd6ELhAugfLhr64Gi+ZJRCGZ2/BlvQ
         jyMQxgxLG9mc4J5tnhnBJWr4DBgRbajSu+6UzrAHdKPv7J1Jm5H6o5cwcaRUPs8KoO5r
         Cr61ovw6qFxcn4hTXKmhIE5o5C1qbHg9vbkAarbfM6vLetx0O0KB7HVLpjtOtfipJxey
         OR/Peeh31M8BxiqDQXc+vFFJcdY+1Z1KrmqpCGkRyMpXUmbpPLUIGuKCAoewcIH2PcpI
         4y3A==
X-Forwarded-Encrypted: i=1; AHgh+RrBHl7Yp0YjFJFkrb8qp3Q6WDr9ZyIOwjftQoicbNLrK2EPb6t/UugR2kLv229w6Ea15+MK18k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIsFnWOzXbL0OK/VXemk5VSwgDB5jkqxdD7+ODAYlg0/06or+
	eS9VAQ8+bk1GJwRzYiuHkKLtz2WS0lrVdRafQ73sfovJhE2CJAvszDNB7HFzPaz7RHgAps8s2Q8
	EYFfGS7QDan9dOhI/DT0Zq8VoFcN1SY0OCg/d9YXobSgGno/YuilvCR4t/g==
X-Gm-Gg: AR+sD11fQqYi2LT/xkSlplnN+B4yzK1MDqQvUgXp1zfiKf3TfxKD0RGXl/oUY9MX16y
	zv4zCiMKMpBRniRXJVZqobF1sR6xhQhW6eFsZP3S6rIHAu6pG7TEBsTg+xg5BjJZnYryelM1WgU
	lNxr9pBRMjJFIjEufmuzO/iOziFKJ++Qxgr+1+ZLaWGsz35iBlhrw9trnq+yS9vpk7Uz2win3Xs
	miZj/PCIry5W+4ot3s5ziG1lmjv8hEVdv8rQWt2Ptmrbfvj+SqbX9Pa3ag8jIlMYG16Er4Ti5KQ
	uPt7SZIXVuvpWM0a6MbIQblYM5In9UXdNK9QJltHKxCaiLeclqGjzanhhIx2DbJMhXwKpghxr0o
	sNGUqL442KmylX9aOcv335+HicS5LYlk=
X-Received: by 2002:a05:600c:4e4a:b0:499:78b3:7b34 with SMTP id 5b1f17b1804b1-4997c0fca3cmr46672765e9.2.1786526500990;
        Wed, 12 Aug 2026 02:21:40 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4a:b0:499:78b3:7b34 with SMTP id 5b1f17b1804b1-4997c0fca3cmr46672045e9.2.1786526500599;
        Wed, 12 Aug 2026 02:21:40 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.92.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm44764135e9.4.2026.08.12.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:21:39 -0700 (PDT)
Date: Wed, 12 Aug 2026 11:21:36 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Hui Su <sh_def@163.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix DL server initialization for
 initially offline CPUs
Message-ID: <anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb>
References: <20260811100612.1408592-2-sh_def@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811100612.1408592-2-sh_def@163.com>

Hi Hui Su,

On 11/08/26 18:06, Hui Su wrote:
> Commit 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
> moved DL server initialization to sched_init_smp(), assuming that all
> CPUs are online after SMP initialization.
> 
> That assumption does not hold when CPUs are intentionally left offline
> at boot, for example with maxcpus=. sched_init_dl_servers() only walks
> online CPUs, so the fair and sched_ext DL servers of an initially
> offline CPU never get their default DL parameters configured. Bringing
> the CPU online later does not run this initialization again, leaving the
> server parameters at zero.
> 
> For example, boot a two-vCPU QEMU guest with maxcpus=1 and then bring
> CPU1 online:
> 
>   # echo 1 > /sys/devices/system/cpu/cpu1/online
>   # cat /sys/kernel/debug/sched/fair_server/cpu1/runtime
>   0
>   # cat /sys/kernel/debug/sched/fair_server/cpu1/period
>   0
> 
> With a zero runtime the fair server cannot be activated, so fair tasks
> on the late-online CPU can be starved when higher-priority tasks
> monopolize the CPU, potentially causing user-space workloads to stall.
> 
> Initialize DL servers for all possible CPUs instead. For CPUs that are
> already online, preserve the existing initialization behavior. For an
> initially offline CPU, initialize the server parameters and keep its
> bandwidth reservation local to the runqueue, but do not account it to
> the root domain until the CPU becomes active. A subsequent root-domain
> rebuild then publishes the reservation.
> 
> Avoid updating the runqueue clock and setting up the current CBS period
> for offline CPUs. The configured runtime and period are initialized at
> boot, while the dynamic runtime and absolute deadline are initialized
> through the normal CBS wakeup path when the server is first started.
> 
> After the fix, the same test reports:
> 
>   # cat /sys/kernel/debug/sched/fair_server/cpu1/runtime
>   50000000
>   # cat /sys/kernel/debug/sched/fair_server/cpu1/period
>   1000000000
> 
> Fixes: 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> ---

Thanks for the fix, makes sense to me.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

BTW, while reviewing, sashiko noted a related pre-existing issue in the
init=false path of dl_server_apply_params(): __dl_sub() and __dl_add() are
called unconditionally with cpus that could be 0 during CPU hot-unplug, when
the CPU is no longer active but still online. sched_server_write_common() only
checks cpu_online(), so a debugfs write during that window could hit a
divide-by-zero.

Could you take a look and consider posting an additional patch to address it?

Thanks,
Juri

