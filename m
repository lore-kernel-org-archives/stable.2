Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236960;
	b=rZFXgTBAQEY6Ew2B/YH3dsWBkao1e4rW1Yiej1rnujQl4q/BsBF51NLYv9+EI6Q10ig8
	 ISXhnnWu1omR6ktNuu6Jv/j/7RTT5fePu0NG9cBx7Ue5QLQ+02KoLZosYpBQ5VqObY6uP
	 Y9JCkD84tdfG14tHB3clq7JGWwV62tEaFPct/k0zfav5CwdUCgRlHxOVpCy1fWxQEqGFf
	 ua1jR1uPNU6xghkw8DxaQWly49HLEMgUS67nGjHuxzmMaomUyK3vgFnousKn66WjTLgpL
	 4H95j0rRc0pw2PNBcok/PJ+hFSMLfv8ptpBdXYDLqPSm2KP+G5Mpj9W/4Yp+/mG06cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236960;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ehk/Gi0k4ynJUIsecQ39iaSJWX96HxZZqDpEX10WpqA=;
	b=rbsTIt3z2CeMaef7o3zGGSGHRvkXPWVnNyRO5UnERvzMqqsxUfd0+oO7EQDjTN8/QGXU
	 2hQGueg/AdHgoO58uINCywG6Q/n5d0wTx2Wuzdy5Gxb72bU8iItWBfZaQSLdzqTXlzZa3
	 pYDTHHYGaISNUS8VEep3ihOLr2zP9Ib7GwsUorydKX8T13Vv6N3smT5btr33w1/tPGaXv
	 XzTQlEHEXvht8Pnforv7n9dWrGq0hYjBOf40qi6ybZR+bWi9ZazInIBDu7GicexW2wADq
	 oPrvPOIRfG439AY9uCeLZhXgZG8Rg1bl1fQkEE9Vf6pTzuu1s6yvd3jg8ZjexDN+A4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NBPytV81;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LTIsuBLa;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F1B606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F1B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NBPytV81;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LTIsuBLa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794236958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ehk/Gi0k4ynJUIsecQ39iaSJWX96HxZZqDpEX10WpqA=;
	b=NBPytV81+7IQ1bsURrkG9p3gBWD4pBjXPu9W1Zpig2qF91IchzVeWY2UaFkJ5ZYL17VDcL
	wa7qbofyx6q56Epg4YDYYC88bo1P9d2EurOueQ0Ie9CTj4+si1qdoXJJ/RE9MGsiWUt8ut
	YS6EcLvqonfgwrKtcrKGXAyADl4coHM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-vFQgIt-rNN-Ti7UE4nawlg-1; Mon, 09 Nov 2026 10:09:17 -0500
X-MC-Unique: vFQgIt-rNN-Ti7UE4nawlg-1
X-Mimecast-MFC-AGG-ID: vFQgIt-rNN-Ti7UE4nawlg_1794236956
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so7644735e9.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794236956; x=1794841756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ehk/Gi0k4ynJUIsecQ39iaSJWX96HxZZqDpEX10WpqA=;
        b=LTIsuBLaTJuFbm754tSh3DeL+OrbAxHo5FnRP/90ZuKvbnEDj7v8rOVgTVoP9+/9c8
         CQPD2ixbWQqhUKx/pDu4v6PA/pMkf1xzvIUn/bez4yFIkpU8JnNoULhad5PSW/2DGP1L
         FKiNt9gOjCE2HOGezsfk3wZnGVm3JdxxSurhkZNUbmdTbL57/knVw7gvuEcmp/xyfq76
         4OCeBZPwWgTINF0Vpr0y6QgI1eUSkJfPivCYwlt4AgEAmtR6vPZR4no3b5R30BzYkdI0
         nVrDG9rmcrdpPzOLAgziSE4torSay4ZfeVzjGKJAjFYJ8yCI7ABuD4Y6MsOBGO2W0Q1Q
         l13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236956; x=1794841756;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ehk/Gi0k4ynJUIsecQ39iaSJWX96HxZZqDpEX10WpqA=;
        b=hFaR+zeA63mHF5XwjBs6FfOVcCOisxSHYlOMLYOWBXmNvHc0YIglpc7y0ZShRRy5mH
         Oiu6vAruxXHC1Ra142vfFo5spO0uQQPMYCapWfJ/S1Z0W7/g75y7DeRApjXh4k30WDC0
         VEeva8qSuU3On5IM0GprzJKykntWQCYJlfrOPONfS6bFTH+JrkS0EeRykeB1wNrzFoMC
         akuFdcHTDXLNbq8WeO2M6i6d2eSI9+0Zi/NEAut2sEDJw/uJviI/C6aIxH8725ES68Pt
         5Ba3K+U9B4fFZcnO0f3exB3HzCMKt1AdBglpvzSWJ6VNE5DoooFc6bra7udzkVHi3iLn
         zmvA==
X-Forwarded-Encrypted: i=1; AL+hErGQ48XvR4NSbJuIJKqmK0DynkALnN+TP+z1DIGKwnvkq0zwAfwRRuh11TKk1ZqVAEEROa2oxGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LhIYuysLgLCwjiXqD4hOJ63eup5oMlqT2x0T9CxnXv0UkJnc5
	nX165bnW7WBnTibanJzFoHmt/0Q3g+B0TuMj9RawpyyWxt9QY/iQMqHJHZBBngq1iG1y7FNogYa
	EfKj+elHRV59MQ4+L1NOO3oeMGbj/PJ+/RFz6sB9CFB42eFicPA1dOqf1zw==
X-Gm-Gg: AYBFou0+BAL45Y5Loac2q7nB8ep/sJptK7L96GHzQd90rq9/YRG/H/3EYBakGNHcvSX
	ZKrFBeIlyhkjTJ5fkkyXacjLLVgbhwn2BXEHGkaOMMpFi7c8U6/ho2NoubpxDF0D8ypJuPIn/eI
	sDSABCYtonNxpPJDCKe/SS66cysSkYdakGpFch1v7TPAEDOOm2VSW2wwmKQv9K+ns6+4J1pCMgA
	VoznJgedYwD20z4RpZIGIVdAeLrEpVDlmEKMxeq34BJuyMr3ZcKO0OmCtDu0J/tlk9wQlW27lOv
	WY/lk5DS7n7HK+HGlKpgvajhTnBFkffsbPKlX3bPpJZdgbP0QpWXdaxFZKgibzlJJxtcSTr//tG
	RHKBRo1IPI4wxZPSAQHAfELRLxhskM0ShEhwocsDZ8bZpEH6lSX7OvolvLwlAcwt7SFN8hFGC3r
	rE3w==
X-Received: by 2002:a05:600d:82ea:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4b943f76d81mr96595545e9.0.1794236956048;
        Mon, 09 Nov 2026 07:09:16 -0800 (PST)
X-Received: by 2002:a05:600d:82ea:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4b943f76d81mr96594555e9.0.1794236955393;
        Mon, 09 Nov 2026 07:09:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32ad4d1sm255269375e9.5.2026.11.09.07.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:09:14 -0800 (PST)
Date: Mon, 9 Nov 2026 16:09:12 +0100
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
Subject: Re: [PATCH v5 05/29] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Message-ID: <avHiGH_4WBizEaBJ@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-6-mathieu.desnoyers@efficios.com>
 <avHY7oNeuvjsLT4I@jlelli-thinkpadt14gen4.remote.csb>
 <3e6677a8-b972-4081-a080-e925fe1df3b0@efficios.com>
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
In-Reply-To: <3e6677a8-b972-4081-a080-e925fe1df3b0@efficios.com>

On 09/11/26 09:57, Mathieu Desnoyers wrote:
> On 2026-11-09 09:30, Juri Lelli wrote:
> [...]
> > This 2nd hunk complements and tightens 4043f54984161 ("sched/deadline:
> > Reject debugfs dl_server writes for offline CPUs") which has Fixes:
> > d741f297bcea ("sched/fair: Fair server interface"). Do we need both
> > fixes (if that is allowed) or maybe we need to split this change in two
> > (as this second part won't apply to old kernels w/o dl-servers)?
> 
> Good point. I will split it in two in the next version:
> 
> - __dl_sub() and __dl_add() skip the division when the root domain has
>   no active CPU. Fixes: daec57983670. This alone removes the divide
>   error, on the debugfs path too.
> - The debugfs write is refused while the runqueue is offline. Fixes:
>   4043f5498416, which it completes for the hotplug windows. It only
>   applies where that commit is.

Hummm, I'm not sure we can say it fixes 4043f5498416, which was a
correct, but only incomplete, fix for d741f297bcea (which the second
hunk fixes properly).

