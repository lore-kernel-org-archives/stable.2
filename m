Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240329;
	b=Upuwb+fzVVWrPQXrBtdHLbVwC+fCmJqn5qwILlsZ/9XewB+e5T/kzHvTZiwhftnBjsLz
	 2DA9+Qxkbg8I1bUD0gf7UKRS1iDLH46QMwexZJX3d8CgTdCK4DZGIOw7lCSpLS0uQurJV
	 WdSOKJuXCDuE7ueCpvN9MBjLHKIyIFp/gVtMc2Xkh9ZWVhBWYqNzV9kWDE/ShL85vkNSO
	 kOmiGRF6HHnw6hLtB0b8r+Sp8fj24FrXTNTuu85DL6pFjQAyt8ZkF+Ryv5GkZqBT9sG1y
	 iKRTrrwRkOr3fsvDKW12TRIIgSKCsUDPTjNHMiIBpTqm84Zim1yJt9rNst9zaI3HWzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240329;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
	b=TpN9TB0KkcR07BhR8Hn9edxnf+oa2UPH7h9vmgRtW6+lQHp6m9JvRrbO5NprcfO9I8zI
	 0WyufROuGGX6YUsq7pdUpz7wQmXiIBisHuaHC7uKiGB1jdt1l20B/wQ86xk8CErxnTXaz
	 6dsEEtyiqFeryddfoxzSzPthyQ2KLUDbxqdRpyjZwNEebTZN5+50YD83+4mGSgR+rlZzj
	 7Ra22UBnx+3BlUwrmTPDl2opPxBvhqelq5TidzVlBgkcCoJX5T2VLBRJgRJ2ulshtEiOU
	 oR0OVMOVM72kLwCJZhc/G3tdgNN9OTHB+wXW07B1V8b8nAE0Jcw6dxxDGE9mhRkpgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="bCxnFq/R";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B5PWwWw6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC99606EE9B
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 16:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC99606EE9B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bCxnFq/R;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B5PWwWw6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794240328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
	b=bCxnFq/RT5urprEEiJ5ITs61Bl4DH9HVhomn2ag/Kl+LFJCwBW69/emwjRqWalGAQWiLLj
	068Ocxb7kNDvCEAqb7hsQ05a+UODrLRH5xIklR0kks6i9o/MMpQx5bwzJUloJ1VqjXTY+t
	lRh2LuSvh6ATqPN9wvolT4+A3nCvAWs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-5ou75mciM6m43-OkgcQ6_Q-1; Mon, 09 Nov 2026 11:05:25 -0500
X-MC-Unique: 5ou75mciM6m43-OkgcQ6_Q-1
X-Mimecast-MFC-AGG-ID: 5ou75mciM6m43-OkgcQ6_Q_1794240324
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a2065a2ef9so8524975e9.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794240324; x=1794845124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
        b=B5PWwWw63AqQGP6aPZuN8Tk25j8UkVRJXzAcbq4ejEdJlT1oifD32CJOy1gJvaz13K
         8817mPy03rcCWGq7VwovwuuKF67xQtmMS8MQtE5mC0Yfsh1W7I8iYLXbMx4l5VhQGYkB
         uVE3eCtNB14iJTb6A7+asAuMxlcqIONlNuwc8CMbDxDYC+qpbWfzVCdbx7Pb/UYtij82
         ccZUl9jUoqhToyYrvizq+mv3hGYId4R6dpky4rWNzpZ1D3rHYVSqXkc1RlSfqTFareBB
         /esnPeNbcN/CsmeypyYAnPx9gHrhEOcu7H2eziDMV2vJM/NBr3+09rUgLDCQswDF2wjj
         DsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240324; x=1794845124;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rD0TnuuwuM4pZL+zr/dUGguLhGYNasqzjimFQ2f+J1Q=;
        b=xXV6abmG7a8j2hLQcNs4mHwIregYrM/Z9a7x8toUD1GotVhElbuf03jt5G7sZjcM93
         d+638mhpD8GHkUkH2RxdfR6jZ422qGIveTkBcAafzdTCEW7z6cfxBcMCiQf6vPOhSGv4
         WRRusI5C6CFO5GjKad6lh1MCviW7svUSF65Uru3ix5k+BaXR8nMsKOMpHriBVCnwPGzo
         nQEHxw7LDdwoIXUv7c07P6Su9qZQuf76rZRvzFVbx94eA6m8Nfrdq010KJfWU6MXEN2Y
         34JHYNRgX2BCnG8v3YSEepnXOifh0c9h4rzsQvvjgKNTmFSHp/xE8UPZFickAsfUH8xi
         llww==
X-Forwarded-Encrypted: i=1; AL+hErFUCPxLOYwvfrtelXUNn/t8a0Vwry8LSIdTVFJirUhxjmDGkBvEZW+1J8V3sduZRljiqCzWop0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VB7QOw5H+eIuWfNk33sUzZBinZ5on9Y3YWoA01ybaUxxR6HX2
	eg7H4v2zsRwhZkrpl8vLOeCNMS/qS9WUMaQGnFTEsCvueyEPdlm+NUaBn0l2XXl4nRBVCP1dWj4
	tLA61vh+0EteBZL3Lz6kC3khwnPAJk8B9ODswCydjwzap4uS9I2nwVp3kQQ==
X-Gm-Gg: AYBFou1VsH9xCrhAomIVQg3//03ivLJ2Xuq9oXXxgc1vM0O5RpUKEUhDKer9o6xVdhO
	UhX1Au9ahT4IUfjBsMK6ZYWWf+xQ4lksGojoib9acwdIDq8VCYR/jp/cQYUiNdTwd/CxCUMK91Z
	WRIe+DnZvjrzrOtHKXLL4wC11c/VCVnk8pmvQhMa7lR0M/u6uN/spFIURFuS3LkXftrOJDDKhaC
	EoyEFcjbT0VCDj5zemGGyvzqpjC8pfTC3hv/LfMBi0PKy3IIrfWKHHrnMAT+HlMnaths4jibckJ
	1lmS7nTh7qw4vJk40USyK8ER0YITynY59UnDXWKVc5o/Bzc8qq2LrUBwEyyj2+EGrfTZ4xoLS1y
	goAD971ylVsWOG+L5/NBouyVwRJPHlAGZK0RXO03ZBnieUZskHyu/Tp5BT6taC3/On6/Mc8J7iw
	O27A==
X-Received: by 2002:a05:600c:19d3:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4b9633cf337mr86690765e9.9.1794240323543;
        Mon, 09 Nov 2026 08:05:23 -0800 (PST)
X-Received: by 2002:a05:600c:19d3:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4b9633cf337mr86690105e9.9.1794240323029;
        Mon, 09 Nov 2026 08:05:23 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596acf465sm12474800f8f.21.2026.11.09.08.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:05:21 -0800 (PST)
Date: Mon, 9 Nov 2026 17:05:18 +0100
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
Subject: Re: [PATCH v5 07/29] sched/deadline: Do not lose a throttled task
 switched out and back
Message-ID: <avHvPjz4dL0zNyGb@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-8-mathieu.desnoyers@efficios.com>
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
In-Reply-To: <20261108185406.1549770-8-mathieu.desnoyers@efficios.com>

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A SCHED_DEADLINE task can be throttled, switched to another policy, and
> switched back before its 0-lag time. It may then never run again, not
> even to die of a fatal signal.
> 
> A task that leaves SCHED_DEADLINE keeps its parameters until its 0-lag
> time, so that leaving and coming back gains nothing. Commit 209a0cbda7a0
> ("sched/deadline: Improve the tracking of active utilization") moved
> their reset from the replenishment timer to the inactive timer, which
> switched_to_dl() cancels.
> 
> This misses a task that was throttled when it left. An overrun can put
> its 0-lag time after its replenishment timer. That timer fires while
> the task is out of the class, and does nothing. On the return of the
> task, enqueue_dl_entity() leaves it to that timer, which has fired. The
> task is then on no dl_rq, with no timer pending, until it leaves
> SCHED_DEADLINE again.
> 
> Fix this by replenishing the task when the timer finds it out of the
> class, as for a throttled task that is not queued. Its return then
> enqueues it.
> 
> Clearing dl_throttled alone would not do. It would forgive the overrun.
> A yield left set, or the old deadline of a constrained task, would
> throttle the task again. The Sashiko AI review of the first posting
> found this in the first version of this patch.
> 
> A cgroup selftest under development hung on this bug about once in
> 1350 runs. The throttled_round_trip case of deadline_switch_test, added
> later in this series, fails 8 times out of 8 on v7.3 and v7.4-rc1. It
> passes with this patch.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

this still fixes the hang, so my v2 comment stands: take it, and keep
working the potential additional re-entry corners separately.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Still have to review them properly, but between 09/29 and 24/29 I
believe every return at or after the 0-lag time is now covered, that was
the bulk of what I was "seeing more of" in my v2 review.

What I think is still open is the other half: a return before the 0-lag
time, with different parameters, where the budget carried over from the
old reservation is never validated against the new one. IIUC that can
only buy a task one instance past its new admission (it converges at the
next replenishment), so it should not block this series and we can
discuss separately/later on. Just mentioning here so that I hopefully
don't forget.

Thanks,
Juri

