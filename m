Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012077;
	b=cKNt4jiBipLpnTixoZHDiuhZWdOMm7tND1Bkg8hIw6td8gIsJrf7BJ5qMph3aa9c2cIL
	 1luLYQFSKV/s52qS0XrEZGId6hg5bLRQuu2xi+izNutFm74rhyQ4QqYivmbrEHYhBK/WF
	 NN1o1AkAC1oLfFenDUOcq2cNNsTp/nNI+/kbQXHuvAmgWB82L3pHX1QcmEPRLZWBhImb4
	 ipbiJtO5Pa0txWGzHu7qkL+q4NrBdjXvLBSqVXGaYhsIY8H/fJ7wpYd4aatAOesgqAwuo
	 wxB34Ua8pYgIyJPh4TY74YR1b3eCK+9Kj+EPhaEqSTYzIuoINnJzwovt1w9mkP+cqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012077;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
	b=WPG/4nKh8T/XjP7+zFaAi8SiyhYd6TlXsaTRbUwtqAgb2Alvc4FZbVGtYLgL+TEwrqC8
	 j+UyNhGWrdGQsqm5AD/6k1J8220ifPYRQchfvMs1BpR75VKSF9IDC7Z2NL45MF/RLANrq
	 jU3/7PBpt+e6zulLpki9nht2fftEMt8BzS7r7e1QjHMjtU9fHRQbmfQvcyjiwK6i/+Twu
	 HUZkypxSuDo7sMXj3oLUncbppr0OdtSKTQkv5jgdT9DxuWJc0BS5OEpzOg1VEoY3wOOEl
	 t9TgKKPSmaH3+AETI3U4J2wB2VyEOKe3Cq8r5Kh7MsQ6biG6vCnuMVbzrxKvZy3TgZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkYNVbFy;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ovW6qsQm;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40914606A33E
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40914606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QkYNVbFy;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ovW6qsQm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795012075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
	b=QkYNVbFysbtyTo4AxL9B0KwDuvSpfKKsbLodLqm+JE17yhpqM0Uc1uPV54vOxQ2dt2R8Mp
	DR5gWNMiUB1X7iZeh1X3GFSnqhRQITCHNkf1td9SMRIMjElUawN3/Z15TV4NKlFp/cpIEF
	H5TGVjuYC28MEq+4aildZ7y8A8b27uc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-6XEaF-AHMty_FSeWd-ruxA-1; Wed, 18 Nov 2026 09:27:54 -0500
X-MC-Unique: 6XEaF-AHMty_FSeWd-ruxA-1
X-Mimecast-MFC-AGG-ID: 6XEaF-AHMty_FSeWd-ruxA_1795012073
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-490d2ac331bso1103205f8f.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795012073; x=1795616873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
        b=ovW6qsQmxXVAihs5E/C0Up2koWSJwl97J3RlT0gDjxNl/3ewPaKcGrXV6X/pbbBTw2
         xi9g//5llwdtKmaJLelowcrxl6y2x+sSq/SIaGXuPrGIx7XotPDQPhf3iy6TPJp63kL4
         z3BSDoag6uBYVTcj7pKhffpS/T6Nx38DFBhbvGqc6b472iaOq7TrkQ4AqGzbrwYncE6F
         24mDqAPo/P1px0V9gCwDqrbihj3uE9zsWEh4eM7S8K66PxOvWYx6UwR6BnOD5nLDovKG
         ZgBLNUOY7akxZNQFRg8u9y4rWNLBdBE+JiRdlM+VlZqGrz+8T5aX1b4vTxhG8aQYZkGP
         G7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012073; x=1795616873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZboGS9TzIUKYx8nlJm/8q9o+1lIrW0X9zgljbgU57g=;
        b=G+67hGYqa8eBFhpGqq4vnMPpaVXma0jHuunh8oTNRnRheJTw9a6CutkKDWBC5l/EYh
         chS5Z2cc34uXFSPEBwE/8DfJjW6FFYpinizbH40/EVhNsRB7c5HPvVNBC3GIGBbj8xWo
         OU25N6gfeNnjHfQycIN2r82X5nnbdGTpUnkCTrUqRaLXv0WN66gs9tP4tTQZdeoFedtX
         OcXquG17CpIjdjsbMmdBrE2Hg6411jnqP03fk/5f8cmItTnsxf3uYeE5TmPxZzaMsu7l
         5fuw0GJlg1R6SjqPBp4Qk4uW+NKNJkXErWXviYJwqN/ZUnG7lagGnOB8oyG0WOlpDIsX
         fVdA==
X-Forwarded-Encrypted: i=1; AL+hErHH58UvbhnhwqLSGEfSHib/xdqlIAxtrs6U3x9C/3zBELM4pXBFCfrIoJSSQyRasnBRcvhO/Pg=@vger.kernel.org
X-Gm-Message-State: APuU4Z98vNWrOI2KEE+nOgyg9IM06pO+i8yIkGWKY7qbsTfQePWHow5l
	+bqvQQrqCzQ9TQNWASRl59Oz4ulLKV8fu5QLZsSD31k+sXM3a8YcOVdNHWSqidGX8MS7LnZ4VPU
	SmWO7XNxo0xi553bvnTv0Pvr0HKPtnVMpPlph3gj2dCta2sh4F0MSlfDxjg==
X-Gm-Gg: AZFdTZd6gZImF0xIqAQSwzCC20px8YGIe4DoQ++Zq+Il+goQ8gBXu+R9xc8BDYjBYuU
	5avKwVm1BGFuPjl0YA/TTbU6W8KiyvAuxfGbpm9o9wWu6eLLnXKIkzM14OO9Q7wUD68GGtZ+uzB
	K+w3AXwEcc8GvJNfW/Vhd2qRlJnZXRMF8yRj1KWrI4qlAjCu2NX1KKTh2lC5+ZZDWqQQG6XBGcC
	a5Sfz1OGZ3hpcRmX6CyhZE/H7a1h6EKbwlYfTW2v7AxA9yp/UzeckG1tvCZoLO+xFRXijyaqJtN
	QmaW8ZL+cjH4+nNLAm7UELnjEqu4JxW9XhfdUivKWHMKboT7Lp62P8DlEr3/qE4qChZmxUqaAvw
	pe83tTAdcX4UHtT4x37vUapkcdC3X2WBwwVJWvtu3RKJUf22lIktwSPUVAqBB6TPd6RqS8Fo02K
	IIHl0=
X-Received: by 2002:a5d:5888:0:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-4a639475750mr5574841f8f.17.1795012072807;
        Wed, 18 Nov 2026 06:27:52 -0800 (PST)
X-Received: by 2002:a5d:5888:0:b0:48d:ff71:dd87 with SMTP id ffacd0b85a97d-4a639475750mr5574789f8f.17.1795012072412;
        Wed, 18 Nov 2026 06:27:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656933961sm5275395f8f.46.2026.11.18.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:27:51 -0800 (PST)
Date: Wed, 18 Nov 2026 15:27:49 +0100
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
Subject: Re: [PATCH v7 09/40] rtmutex: Continue the chain walk when a
 waiter's deadline donor changes
Message-ID: <av215SnBF5GShg0J@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>
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
In-Reply-To: <c8b228501d8981454f63843b394019fefd4002f3.1794922146.git.mathieu.desnoyers@efficios.com>

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:

...

> Fix this by recording the donor in the waiter with the sort keys, in
> waiter_update_prio(). rt_waiter_up_to_date() compares both. The walk and
> rt_mutex_adjust_pi() use it. A new donor then takes the walk on to the

...

>  kernel/locking/rtmutex.c        | 22 ++++++++++++++++++++--
>  kernel/locking/rtmutex_api.c    |  2 +-
>  kernel/locking/rtmutex_common.h |  3 +++
>  3 files changed, 24 insertions(+), 3 deletions(-)

Thanks for confirming the Sashiko finding and for the plan in your reply
[1]. As you note there, a window remains however the walk is changed,
because the donor pointer holds no reference on the donor. So I have to
wonder (and ask for Peter, Thomas, etc opinion) if we'd rather not keep
extending the chain walk for DEADLINE PI, which is known broken and
proxy execution is going to replace anyway, and leave rtmutex.c alone.

It looks like what we lack is memory safety, apart from accurate PI.
It's an hack after another, but how about having the owner pin its donor
instead: take a reference on the task behind dl.pi_se whenever it is set
to another task's entity, and drop it when pi_se changes
(rt_mutex_setprio() and __setscheduler_dl_pi() are the only writers).
The donor then stays allocated at most for the owner's critical section;
its parameters may be stale or cleared meanwhile, which
replenish_dl_entity() already copes with after patch 8; and the owner
may keep running on a stale donor, which is no worse than today's
DEADLINE PI. Thoughts?

Not against doing "the more right thing" of course. Just evaluating
alternatives.

Thanks,
Juri

[1] https://lore.kernel.org/all/f535fbbd-2247-4d0d-9771-a67116fda1a2@efficios.com/

