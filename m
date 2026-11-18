Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016028;
	b=eV+LUnGDh9oMvXQhlTBUGlmf9vpyYwFHdeeBjglOmPN2b0a7Zc6+z+qrHDpbOrJ8Z+1m
	 /G7oOfq6U6MB2kCXgBp4jEgy2H5WRAsQgk6877G8IrG5OtFvLoDvIFQJFu9dcQuy3eT9M
	 0YU9NIBw+6c4/HavAAAT4S99fMNRLut5GTON8UJSlqtB4JJX2SYhFEChw/Ol+z/gituih
	 KDYw15OytdUqcpLi+0quDYCLa4TLcd7T6z1B/MMuhkEI98XbQ/96IwXibxO5ORrQp7VzJ
	 H7mcTonw7slJt/gXlg1kmeOBtVMljW3MSFlY9xlruFRLtxHbjScGeXOri8WOf7FCLqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016028;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
	b=1tcCCyhdG7ur1ApE16mz5nTsmKRo2LCC01awKdYQ2DHH02XNjuJF4tAmgvqX+BW36Rds
	 Z0tD60AwL62+S7394QqrdjknzOeDQHDrN9PW6hZifmBxuOcw13qjK8Y/bi6ICM/CyIRSh
	 6TGFiMHnfXGC7FHPJU6ZMQ9h4zA5OdAXSjY4+m/qpmHOESmQQ3or9Tw7xh21zTrFWh7BJ
	 pfzrO8sFbmYHh9509BXChYdPCCncfshwQJ8FS5d6E8258dwYIMRLkxvT9yE3BW2xdeam1
	 wpjvYbAQR/hYmTSQs8iUkBCz6CEVVrcF72xAKzdXivpYL1hayd+1jpx+yq4/HnuwjwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMHVdGhq;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hjapHfa9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BE606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 15:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 883BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMHVdGhq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hjapHfa9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795016026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
	b=SMHVdGhqsrOTmOb/h7yyl7JinrKAkC/2HQEylbpLDrEdToSemJkq0rZnXh/1bc3keuw82u
	Tm4M+YIsPV5AYYtZqxRkIqD6Vt1WP8b0VAfz38mPiC9liNh0AeenirvzdaxvuK9XwOunVR
	JGUCx1kCMnj9XixnhrH1Mh5pUo5GOAY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-RFBbSyyCP1K_CesEPy-__A-1; Wed, 18 Nov 2026 10:33:45 -0500
X-MC-Unique: RFBbSyyCP1K_CesEPy-__A-1
X-Mimecast-MFC-AGG-ID: RFBbSyyCP1K_CesEPy-__A_1795016024
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb68a5e792so5305905e9.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795016024; x=1795620824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
        b=hjapHfa9Gh3Zmy9e0Dd9POv2CixHjjA6fXGunjIJ1xJ1iLutSfN3J26cEelLg5++1s
         aybMZHXUIPLNRvWSWyhJiy/LqnvrE8LIUVyHrM6gJKVkEAuHl6KHOhdUW//uGfE7oO+b
         N8th80yZMR1lm3M0MtWxQ+/wjcTW/6SGrGFkJ8Euu1CzQf4xmmIUYhczo40kdeufkohy
         1iv+6emM7lalwYFFhqy9d9C1VXmgGIEel5Ie3rXEUGDEkhTFUHnhc8ozAp3cRDc3ojYU
         jzsuQ0poAUXPz0V3Jkgsr31wy0pnbjcKgCmJluwtndAp5fcJlFgxAgdcdvlv9dsjIqR7
         Bi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016024; x=1795620824;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x85cpobaf638Fe9w3ZW1Zro4FQs+4uIPwl9i5atMIvg=;
        b=Kx1+aeb20t5lugtkNgvdIYGDhQAodBdOLGw8g6MWlUJ+UGtDfHupNLuR4Z1TeFWfTL
         yHvzPFmf1p2AywWXHNohDEdKIsWgjhQiubrjzaXfrOqaF5SQR/E/PlB7t9qUp4lyFk84
         RU7TftwbdBj8nIoDlIw7APlWGiygVdNlgPN/pOUHAeBzKD8x6mmc6hLGhqECCIy9SxP1
         xG1CoQqC93XVYRv0tLnPhkwxCHj+UWza1tGYEeGqyaHVmwWe2isFSZauG3s1aI+tHca2
         zxzzDXL9RmW7fvxpgOzfc//smJk3Dj674rDdPzmee30mjhoY5dErEDu2R9l1hn2ya/RL
         Dblg==
X-Forwarded-Encrypted: i=1; AL+hErHUm54UP3e3TQgSvVKctQLjNUf2RbyaLAe6Mnr1CKWotTvlW2ZnBh4fopsCW2rlOC1ciuSRmRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aaF8jfLxR0RtOiNbEl2CTrv33QTF4wsPjbe6/ldE5wx3ctANg
	xyVhh4mroaFV9VPvsB7bmnftHeBps5y6TOJZJkYnQGKDnHHSIGkCOPTyzS5IUwaU+p6IWEltfH2
	JpH1KRG6J3BVxetssx6xSckdb7Z9WWb++gkkcyDaQ77xE9O0wkVGaqyYBYg==
X-Gm-Gg: AYBFou0jolhVM4aOHAwpmfXfi0WVC5JQaDBRys+qP96bVHVBDBPnaC2Gs/4MCMonugu
	9dsD8MZ5bqXX8rm20pIVVTet7N8Gtcy4iCQyXMlQ5TDdBYrzHh8lDGEo38GUHYvz+UrFcRlCnbA
	VLeOUc+m+hI1v6DH97jtka1G/wG6ImTxEtp5pFI43438kMzid0jdApRADOMNWWsjtBOIjFXkYjT
	81P/Y1q3LArXfsrjE3X89aMBO8ov/t6o0J2iay0ijZudA/okRF67GteSl20fWOI3eezbaNoGbFl
	VXNLNQ2N/h6oAPp/eZRGYRzUt0D16F93078ozSZHsCZo7Qf/gapscgJJ/2HVJup8KuzKq+bPti7
	uUpbUT6OQ1t2Tr+FWb0U+GZFS5Td9ks3nmBK21bJc5VewZrTTPFegkxryMzt6NtzG+3+dArUdlk
	Dj1AI=
X-Received: by 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb7d6cd4ffmr53090265e9.2.1795016024151;
        Wed, 18 Nov 2026 07:33:44 -0800 (PST)
X-Received: by 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb7d6cd4ffmr53089605e9.2.1795016023651;
        Wed, 18 Nov 2026 07:33:43 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e50e992sm37379485e9.0.2026.11.18.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:33:43 -0800 (PST)
Date: Wed, 18 Nov 2026 16:33:40 +0100
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
Subject: Re: [PATCH v7 13/40] sched/deadline: Release the bandwidth of a task
 that leaves the class asleep
Message-ID: <av3FVDh4PX-5gWSW@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <a809425266acca7cfadd2e8187a7b5a815ba32cb.1794922146.git.mathieu.desnoyers@efficios.com>
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
In-Reply-To: <a809425266acca7cfadd2e8187a7b5a815ba32cb.1794922146.git.mathieu.desnoyers@efficios.com>

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
> A task that leaves SCHED_DEADLINE while it is not queued can keep its
> bandwidth in total_bw until the next rebuild of the root domains.
> Repeated, this fills total_bw up to the admission limit. Then
> sched_setattr(SCHED_DEADLINE) and CPU offlining fail with EBUSY.
> 
> A task that leaves the class keeps its bandwidth until its 0-lag time.
> Releasing it earlier would allow temporary overloads. For a queued task,
> switched_from_dl() calls task_non_contending(). It releases the
> bandwidth if the 0-lag time is past. Otherwise it arms the inactive
> timer, which releases it then. For a task that is not queued,
> switched_from_dl() relies on the timer armed when the task blocked.
> 
> But the timer is not always pending when the task leaves the class:
> - The task blocked after its 0-lag time. The timer was not armed.
> - The timer fired while the task was still in the class. It only
>   removed running_bw.
> - The task was woken up on another CPU and is not enqueued there yet.
>   The wakeup cancelled the timer.
> - The task came back to the class asleep. switched_to_dl() cancelled
>   the timer.
> 
> Then nothing releases total_bw.
> 
> Fix this in switched_from_dl(). For a task that is not queued and has
> no timer pending, call task_non_contending(), as for a queued task. It
> arms the timer if the 0-lag time is ahead. Otherwise it releases the
> bandwidth now and clears the parameters, as inactive_task_timer() does.
> 
> Clearing the parameters keeps later paths from releasing the bandwidth
> again:
> - A timer handler that already started finds a dl_bw of 0.
> - The deboost of a later priority inheritance boost finds no
>   parameters.
> 
> An owner that the task boosts as a waiter can find the parameters
> cleared too. "sched/deadline: Do not replenish a boost from cleared
> parameters" handles this, so a backport needs it first. Without it, the
> owner's CPU can lock up as soon as the waiter leaves the class.
> 
> Juri Lelli's first fix, since dropped from tip, released the bandwidth
> here without clearing dl_bw. The bandwidth of a boosted task was then
> released twice.
> 
> Juri Lelli suggested the call to task_non_contending() in review.
> 
> The Sashiko AI review of the third posting found the two cases with the
> 0-lag time ahead. deadline_bw_test, added later in this series, tests
> this in pi_former_owner_asleep and deboost_released_resets_period.
> 
> Fixes: 209a0cbda7a0 ("sched/deadline: Improve the tracking of active utilization")
> Reported-by: Tejun Heo <tj@kernel.org>
> Closes: https://lore.kernel.org/all/2b5fb3f22bca6aa383be8f4781923392@kernel.org/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761fe005b4@redhat.com/
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

