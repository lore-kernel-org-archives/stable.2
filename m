Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231496;
	b=LZyVoai1eIjrFhdsbBGvPaEg6bPREHV55RAygrjtnmoGtfirhPCZzQB0ZH3K3gPGevrw
	 OqK1QLc/tqCxIdP0c1iaocPQdf3jvnG1Fz0S/6L2uCmcLB9+I9s0+AMkm7rOzoJMVwzD/
	 4oLPuTc0DOmW04WQp/dESTg0YsYkFokgLduoOhzt/kEK5Va4EkCW3GQZsJ1UgQNkhsYBF
	 zLJLf+t3phVywE7wSXbmpgRBzWr3bFztmcXVoNVqejjwZFHyu3JUJXzjsXC/plN44QXfr
	 //Mv3zVlhlK5FAIhpKKChgvTFP40Tv5n/K13dt31iRtoSDPaRguzOlHPQ+6PSGN1ySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231496;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
	b=slRQ1hnET2xAcx4RmlLZct8h8QX97HW0llxZ6BWyicI9DJqO1oREuubclM366+JsDZbI
	 GVXmNRohWd4RzkJGHCtxaFYBoNWcborcjGNJRvTBtOCfOj8lX4HoSbmxPYK4MXo5y7Bzf
	 8UhRi+WLu5UUT2yGfIUbuROljAAVVJ6iGHHkblst8mTS8JBXdJdn7yHrAuKtdnEwDDm5H
	 kr6wJEwvBgZFJNwVUrAj8iXfuVR/ZwYdCeZM3Kji/NV4WC7SzovtsIWiEgqtnMs2ODC0R
	 Ff7PRb9lk4WqJNm5Si5jO141pyVm5wJCH1JyEs39SzPd39Pmx2hnc+QZst8f7s1TyLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VUtCOFoi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HEIAIx1m;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4385606A330
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4385606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VUtCOFoi;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HEIAIx1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794231493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
	b=VUtCOFoin3YsnZlHv1bGq3yzV7qv02AZiKSQEwCqxciMjpsbtAYhunQCGP+3TJqorp8+7s
	XHva+KGu7ZSpUVy+QsQTGaGCv+s3xM3wiDikmYx+0gUM8sL7j5BEVbS58Ap38Ws2v8NlWY
	aPRNxjHsXiCuAMXedfUcgPN2MLoOSMU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-jS595FIQNuKvKGpSIHHgjQ-1; Mon, 09 Nov 2026 08:38:12 -0500
X-MC-Unique: jS595FIQNuKvKGpSIHHgjQ-1
X-Mimecast-MFC-AGG-ID: jS595FIQNuKvKGpSIHHgjQ_1794231491
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e00f3929bso504027f8f.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794231491; x=1794836291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
        b=HEIAIx1myBNl8RKtNU2XaCgpu79yU/cswIopgOKAAckX76fZaPPdUZz80jomxlLDwO
         TKpL5uzkNnDfJql6smhnFjeHPj5toVH6EOsjjQvyTt2TTDk6jGYXTmWBMqt5oJ+OISXZ
         bNk3+uKL9NKgignHq9zvMKt/kEK8wxGyRNU2KW7txfTsNUrLo2Scc0aQESVh0r4NWCvZ
         JV+zF0NG9GxdWyiozHCOGj0s/PT/Uj8ExGGkdMxibWPUuFofVzD18pC5GlVDGIqE1EzS
         VbALQvoq1rBNznrl6Krqrwsni8JvywssTcTmdCSNFkjO7HhJndbap36p2vQswKUuf5GZ
         bPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231491; x=1794836291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGYsCV+6ghrjpGJ3qQugEb8Y0kCPQvn96f3QlByPPhE=;
        b=Z1PYj/S5XBJ43fwrLi9KS1cqlonN37mRahKrfnWAyqwMYQdl+Oa+XN5P/LCdQ12FkK
         R84Qi983db8GN+4dwtxI7Eto2Owx+brwfLGEOX5hEXAyLaccJ4Ki5JJF75ZtcKyS9mPs
         4wwZfMGqsPdhS5HNDqTUk5IzBfRsm3SNM7fdqvhSA+LEaRfRcG8hQbnnonuiLyTL4peA
         xGuLVZF5+nmn/rj4he2L76hhhZ214+Ur19mPUrYRxVm+AfUjtTUFLayt/pT1F7BTrLOv
         c3PJDHwHxJ5WYEgph1TrvkWPCj51tcKofDiIail+pNk/YwfCyi+T23KU51mt7yorlVCZ
         ecSw==
X-Forwarded-Encrypted: i=1; AL+hErEz407a+SHlTh2x8wkKc0hETSLVIC9Uz+YJf2CHJrB8VC9y/0PpgLYrmu/xjuFHixNx2NdwKac=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zgrdIPS6Kfgt7PGuny/R9Z1m8TK3rQQw6C0GmYycUy02iR5cg
	BQj+mdiyKaWUh6ogOdHCLGIKm0qAzJi9FQTeF4PJxhORHxMEOCnMoyTIY90bBUg9s++LWaHfALL
	Sikj44Fe9JjlSY68dvMnD4K4l4uvjIdtw6OKHheG+C06CXft5iF9bPqagRQ==
X-Gm-Gg: AYBFou2QdEua8EETnhl8ueZi0aL3zBLltxjVgJl71pS7Qsl4Zj/gQOibwC7NzL0O9zz
	lGaR3GnDY+CgvxaYI6XZIjZY4CgR1R9rr4znWyY48jjOp9s+6j/akFY9rPJzUi+8GJpD9pEVj/S
	EGD5MZRJL12HLGNjkDZHgk3XeWa6W5jLIfimlnl0ja0qA/aP3wl/luryZEaL5a9eP5lJEvEuwsd
	oKsfEpxj86pUncoB2v1gal9lGayvL9jxxIcNgTTtOMeTOLdly2T+AwFdV09CtJaomO+moLz42cn
	NTlPp54l78y6RXI01v2OjjqwQwtXaqkzHgJU5eGzwEEzEsWZa8VVrnqyVhYNK45IWCAjTIhvHrB
	O7OdzPi0fko5ZGhPjrYi/7bml/8UwAKgxi+3BvTYKGoAhmv2rlwjKpMd31mMKiw/u2yYShWBbHJ
	xRsQ==
X-Received: by 2002:a05:6000:240f:b0:48d:f160:efad with SMTP id ffacd0b85a97d-49425566d13mr15141623f8f.30.1794231490605;
        Mon, 09 Nov 2026 05:38:10 -0800 (PST)
X-Received: by 2002:a05:6000:240f:b0:48d:f160:efad with SMTP id ffacd0b85a97d-49425566d13mr15141537f8f.30.1794231490148;
        Mon, 09 Nov 2026 05:38:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597652ca7sm10965139f8f.39.2026.11.09.05.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:38:09 -0800 (PST)
Date: Mon, 9 Nov 2026 14:38:06 +0100
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
Subject: Re: [PATCH v5 04/29] sched: Let a task boosted by a deadline waiter
 change its policy
Message-ID: <avHMvpJonTciAtx_@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-5-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-5-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A SCHED_OTHER or SCHED_FIFO task that holds an rt_mutex can be boosted
> into the deadline class by a deadline waiter. Then a sched_setattr() or
> sched_setscheduler() call on it fails with EBUSY, unless it asks for
> SCHED_DEADLINE. sysrq-n would not reset it either.
> 
> The admission test runs "if setscheduling to SCHED_DEADLINE (or
> changing the parameters of a SCHED_DEADLINE task)", as its comment
> says. sched_dl_overflow() then handles three cases, by the task's
> policy: the task enters, leaves or stays in SCHED_DEADLINE. But the
> call site tests dl_task(p). That tests the priority, so a boosted task
> passes it. For such a task and another policy, sched_dl_overflow()
> matches no case and returns -1.
> 
> Fix this by testing the policy, with task_has_dl_policy(). A boosted
> task has no bandwidth of its own to admit or release.
> 
> Now sysrq-n can take a boosted task out of the class.
> normalize_rt_tasks() calls __sched_setscheduler() without pi, so the
> task gets its normal priority. Nothing then drops the boost. At the
> unlock, rt_mutex_setprio() sees no change of priority. The pi_se of the
> task would keep pointing to the waiter, which can exit. So also drop the
> boost in __setscheduler_dl_pi() when the task leaves the class, as
> rt_mutex_setprio() does.
> 
> The boosted_owner_policy case of deadline_bw_test, added later in this
> series, fails with EBUSY on v7.4-rc1. It passes with this series. The
> sysrq_boosted_owner case of deadline_switch_test tests the sysrq-n path.
> 
> Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

