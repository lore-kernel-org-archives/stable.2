Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012351;
	b=jYQ7XoMvlFoASI+zDzyum9eiZqu16aiZPecTpIQty1RkorQ5drC8Sh2nAev/3nfmRJbI
	 pJWP0Bd09MseI2O9CLeZz4GCFYDphDIMekcDhf/vDBPRUBTDx1dLx3YolWMXTjU2EpC/s
	 fFzHWuKHxOfphyeABfqIT/eX+MgEejLiBfAvHwOUbqcrfYXJspxn+47B/9BF2ZI4TqXUA
	 FFNl2otGxMTiq8uWX1YGF1rQagcK+5XADLt4mQLMHuODpFrss0pWquRMTz1FLl0b2Vzks
	 5igkIwI/pE1MTCdoCcJpXAd+HzH583IZ9c7+cJQ36bMotqvN5Qz0rX68jywsKEnvOdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012351;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
	b=ojHWjHzQtEF4ZHkj1wqjFwP+GNkxtCowDMvcVFMgL49S1jjpWGLk/YJsOhbVj7M5mUTE
	 ZAOuqdmlEiuG/Zi7DYpY4vWoZs8bha1rz/Z35Og5YCCrkNdCq8bezT6wMn5L6etdEoGu2
	 hI8lu8sLzwKrWhFmaa3EP74P88KEoVGxBzVY95LbZQSBIIImajW0F2N9dIUS0o1kID7MF
	 5mO1RvHHfy+bAt8jJA7Fyczy7S8oZsti20GRV0goQLiaNR1TnIaKjhsSOFQftFA5/VMkY
	 v4RnOcslflON7ZHI3699ZPsz3wooeIHhH2bMSVELp8HW/H7cxk0w3GhC7bEo6QavEdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VaD+Xsu3;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jhchfRR+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59938606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59938606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VaD+Xsu3;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=jhchfRR+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795012350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
	b=VaD+Xsu34vU64AKsQ/3FGGJHuzhiLtHQnsCNzlppRoorGh002QJMjXaBegLUGUzUg342Rn
	7KbJ1wjiA/xJYjp9bHq0MqJVJE03JkHdQSHgXQGR1E71KypjsuAwJpoxDG3ik86HAreqp+
	tfbGFOYrFM8UrxhgmYKz9aDlCmcul8M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-u9aj9921P42P1cWf6x1i_A-1; Wed, 18 Nov 2026 09:32:28 -0500
X-MC-Unique: u9aj9921P42P1cWf6x1i_A-1
X-Mimecast-MFC-AGG-ID: u9aj9921P42P1cWf6x1i_A_1795012347
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4bb68a5e792so4932465e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795012347; x=1795617147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
        b=jhchfRR+9STjT4RdQylP7KrJi5iKHkLKKg+LqCVbi+6LvYc/vlbXKwv+BbYq9IyMB5
         5IuuHmdsLkM2rw2y6UhKtLVj1wJeVgZIliUYnnFwyBooZl3lPlPjle9k6c9PjiB350TR
         ZdRR0OcSgvgiZaML0rzx4h8rU2XLsXvGAbf5Cm8NLa5+SdGfDzvkgg3NiYc/r8MBs1bt
         Y3knU0pXRvWk37uIGmeS3wbA/XMgLSH1UBvdcZsRGN5EhvpLsA4ZZEQcoZXnNl4n2zQQ
         /rWcyjyE018M2KmjNVvvymzL+Nls+cOtEIEDk09i8PkO6LBq6ANB/M00NGOAjbvSleoI
         iXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012347; x=1795617147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
        b=ePeTzKAHWfsvEhfHCO1NPFdJqrxmmvXj0VCiUfOGaCHg00DPXuUMir9i9u3DB8FZ3F
         /NYA5ZqPiP7625/w+p9ub7DU8gig0OABQn1aTv3gGc9zE0e+zqTEf7dI8WFMLiEuOu2f
         xqXb2afVkkLZhp0NTV7lp4GNQEt5/XaXjVl+7cfWtODGOqcgWP14OlOk8Y33TxWZSLWk
         o2AdeZmuRR6RyVcbx5B3zyItOCNVieL9s74dK49CnoS+pUnJJwAmXi79sxrCxO24FE0h
         RL7SnxY3fLClIDjwSaSzxXXDj/XHRn8aP81qHQW33SbL1lejur0qloinKDB3+kasmhN/
         sr7w==
X-Forwarded-Encrypted: i=1; AL+hErFxPgiCh921eFJcWuym2w7fo1y0PRJUnlRRMFBm36LZbO6tFyeu//hXPARckIyMPCe4X7c8yJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6neiVckmB/rY9rF+ddIlJhwvta0jnkxasVOEQOvm9QyWbJg0d
	ZEOdDb3shIL3Vr5h1mjScCHKnjCEP/Vy1J8eh/LxZGpuICs2HOGd//oqn0z1B9qjqxPGw8CEpIw
	KzAMu7W7TmkH3ltK4CR5AhrelYNmw/TuGQ0pCDKN91VMXHD7i4anndC6DxQ==
X-Gm-Gg: AYBFou3x58yvqGlFoNHWyDKEopz9t/1HHcDWE4brthQP6Ue6xpsMP4xyCZxz1POFlt6
	vGqEAUyWtdpxI+K96FoFIalz+pyVtNdAmkOXkPn7KNJpWzQ90T4XZgZ1yDXYm8ZFLFkIJBbdJvH
	EBdemnJbxRhfyUltYToYPlSQPgbUTVjV5nw8lj+3Lxvy9dd/7+pjwJo/L9CY5u/5cQqkUKfGUOS
	YVZNOzfM4B7ak1ZQEZpJ5m0gSFDuQhylrOllcHFFKmdIdP8NmvoAPJl8y5C5x+xRXbigQ4LChPf
	sYU9slJJr4nSddTuMPdbmgdEI+Fqwxfl2vwxjnShn8QMsKEEAA7waOlLs2mSFDMrol62NzHh87G
	lPUDX70C/bnaPUdq8vL+tf76X3hhfDmgvQpVGA9ETMM01u7fQcYauIqtm2OxZNKog9yfoqlU66H
	3SwB0=
X-Received: by 2002:a05:600c:6290:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb7d6cd48cmr55544885e9.1.1795012346840;
        Wed, 18 Nov 2026 06:32:26 -0800 (PST)
X-Received: by 2002:a05:600c:6290:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb7d6cd48cmr55544025e9.1.1795012346150;
        Wed, 18 Nov 2026 06:32:26 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2aad96sm58360485e9.6.2026.11.18.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:32:25 -0800 (PST)
Date: Wed, 18 Nov 2026 15:32:23 +0100
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
Subject: Re: [PATCH v7 08/40] sched/deadline: Do not replenish a boost from
 cleared parameters
Message-ID: <av2295tJMdwRp3wK@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <cefacab5f1c0e7617f17e050af4ef5f6db01700a.1794922146.git.mathieu.desnoyers@efficios.com>
 <av2k8JlLvUcBBOhn@jlelli-thinkpadt14gen4.remote.csb>
 <ddd215ff-d6de-4dea-b12a-80948a9b5ea6@efficios.com>
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
In-Reply-To: <ddd215ff-d6de-4dea-b12a-80948a9b5ea6@efficios.com>

On 18/11/26 08:44, Mathieu Desnoyers wrote:
> On 18/11/26 14:15, Juri Lelli wrote:
> > The above paragraph is a bit hard to decipher. :)
> >
> > Maybe something like the below?
> 
> Yes, thanks. The next version takes your text as is.
> 
> > Also for other changelogs, I am not sure this kind of info adds much, as
> > I fear it will be hard to track down in history anyway.
> 
> Agreed. The next version drops the sentences that name the review that
> found a bug, in all the changelogs. The credits to people stay.

Hummm, now that you say it, crediting Sashiko for findings might be
worthwhile (for usefulness statistics etc), though.

