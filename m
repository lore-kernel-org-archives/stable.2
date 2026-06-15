Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07B3AA4E1
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553797; cv=none; b=jgXSPx0Lyb0RmPXSlQ6BUwvSIS/38cpoEYqLuQpsGwKR7x4a0TBMS5cVZJfS/5REHn0g8R2pA+UFRfd9i6VzQywADvAtupCI+tjXtRj7/5mXkWvnUBoesM7cm3zgvq2YH25/OOwJZI66EZbWfzo/oqtmWDCACXFkoLyYHnIkBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553797; c=relaxed/simple;
	bh=SUq9iKxQn5lLu4iBO706He/bKeek8Dg7871HIBNatB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTIijc6DITyMGZzjLwxr+ZHofQq4AD2NZa3IHyebUIiLmcO1LjEsyiSuZsKoO5oHWkjnAC5nMfIOGlhEX0Dsky8YPBmAG1q/JGBLFC1cVkZgknXRcBMtvf5fu62IzcUs5v7lypkk2bmXtwIBRxg2rNZebLGv95rrnIQPz0NlaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8nuoNLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8nuoNLD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781553795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nys48/KdCPu7erZEVP0pTQ4EccdIQbCXyeeBZUzmgvY=;
	b=X8nuoNLDfu245SQZsff17P4qreMrKKapmyoBH+J5It/fNFwa04OVNyXeRx1ua/5YFyypeK
	HwHxJ9169I5bBw03Yi0hiKA4aCwLZGKFHxi3Pxb41vaEgF6FwleHIkzINH2XNHI5oQoFLP
	9eDXcHSLBLwxlQBF8Gn8ndTqw+OqhQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-FAIdYIB8OUO_Vg0-Hp2LPQ-1; Mon,
 15 Jun 2026 16:03:12 -0400
X-MC-Unique: FAIdYIB8OUO_Vg0-Hp2LPQ-1
X-Mimecast-MFC-AGG-ID: FAIdYIB8OUO_Vg0-Hp2LPQ_1781553790
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A0F19560AD;
	Mon, 15 Jun 2026 20:03:10 +0000 (UTC)
Received: from [10.22.89.117] (unknown [10.22.89.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2C791800367;
	Mon, 15 Jun 2026 20:03:09 +0000 (UTC)
Message-ID: <1ba5a885-ac2b-46e2-b18f-f5b3e02e8094@redhat.com>
Date: Mon, 15 Jun 2026 16:03:09 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] debugobjects: Don't call fill_pool() in
 early boot hardirq" failed to apply to 7.0-stable tree
To: gregkh@linuxfoundation.org, bigeasy@linutronix.de, tglx@kernel.org,
 tglx@linutronix.de
Cc: stable@vger.kernel.org
References: <2026061558-amiable-showman-7ea7@gregkh>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <2026061558-amiable-showman-7ea7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


On 6/15/26 10:31 AM, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 7.0-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0d046ae106255cba5eb83b23f78ee93f3620247d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061558-amiable-showman-7ea7@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h

Commit 0d046ae10625 ("debugobjects: Don't call fill_pool() in early boot 
hardirq context") has dependency on commit 5f41161059fd ("debugobjects: 
Do not fill_pool() if pi_blocked_on") as they both modify 
debug_objects_fill_pool(). So commit 5f41161059fd has to be applied 
before commit 0d046ae10625 to avoid a merge conflict. Since both are fix 
commits, I supposed they should both be applied to v7.0.y in the right 
order. Similarly for the other stable branches.

Cheers,
Longman


>
> ------------------ original commit in Linus's tree ------------------
>
>  From 0d046ae106255cba5eb83b23f78ee93f3620247d Mon Sep 17 00:00:00 2001
> From: Waiman Long <longman@redhat.com>
> Date: Fri, 5 Jun 2026 13:30:38 -0400
> Subject: [PATCH] debugobjects: Don't call fill_pool() in early boot hardirq
>   context
>
> When booting a debug PREEMPT_RT kernel on an ARM64 system, a "inconsistent
> {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage" lockdep warning message was
> reported to the console.
>
> During early boot, interrupts are enabled before the scheduler is
> enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts can
> fire and in the hard interrupt context handler attempt to fill the pool
>
> This can lead to a deadlock when the interrupt occurred when the interrupt
> hits a region which holds a lock that is required to be taken in the
> allocation path.
>
> Add a new can_fill_pool() helper and reorder the exception rule and forbid
> this scenario by excluding allocations from hard interrupt context.
>
> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260605173038.495075-1-longman@redhat.com
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 772ddabcbe7d..1fa156c45c09 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
>   #endif
>   }
>   
> +static inline bool can_fill_pool(void)
> +{
> +	/*
> +	 * On !RT enabled kernels there are no restrictions and spinlock_t and
> +	 * raw_spinlock_t are the same types.
> +	 */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return true;
> +
> +	/*
> +	 * On RT enabled kernels, the task must not be blocked on a lock as
> +	 * that could corrupt the PI state when blocking on a lock in the
> +	 * allocation path.
> +	 */
> +	if (debug_objects_is_pi_blocked_on())
> +		return false;
> +
> +	/*
> +	 * On RT enabled kernels the pool refill should happen in preemptible
> +	 * context.
> +	 */
> +	if (preemptible())
> +		return true;
> +
> +	/*
> +	 * Though during system boot before scheduling is set up, preemption is
> +	 * disabled and the pool can get exhausted. Before scheduling is active
> +	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
> +	 * and if interrupted then hard interrupt context might run into a lock
> +	 * inversion. So exclude hard interrupt context from allocations before
> +	 * scheduling is active.
> +	 */
> +	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
> +}
> +
>   static void debug_objects_fill_pool(void)
>   {
>   	if (!static_branch_likely(&obj_cache_enabled))
> @@ -734,18 +769,11 @@ static void debug_objects_fill_pool(void)
>   	if (likely(!pool_should_refill(&pool_global)))
>   		return;
>   
> -	/*
> -	 * On RT enabled kernels the pool refill must happen in preemptible
> -	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
> -	 * on the fact that spinlock_t and raw_spinlock_t are basically the
> -	 * same type and this lock-type inversion works just fine.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
> -	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
> +	if (can_fill_pool()) {
>   		/*
>   		 * Annotate away the spinlock_t inside raw_spinlock_t warning
>   		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
> -		 * the preemptible() condition above.
> +		 * the preemptible() condition in can_fill_pool().
>   		 */
>   		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
>   		lock_map_acquire_try(&fill_pool_map);
>

