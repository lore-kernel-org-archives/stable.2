Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508975;
	b=r1ZsB0vnsNbev0kpx3GqDDkXYR9cFtgD4x5k7wU9IQJ38dnmD5eIu88xbGain2XAasMJ
	 HFcB/7Cfr1OZaSiknhWDT35oOxAq531bPxkPOppWXKGyUCtgA6lf1/mL6k56G7CzhEjbD
	 58aJKDfyqNP0pqgkGZrLWcyXHE5UGVanMjZpgJ6AfKB+hqKlz+LEyvxXk6XKrhnBxUfzB
	 JOk8X3a7oWqdD3Cg6Vb8dvLf9SORRFcERwFrFsuWPBGErMyCBCrRckiiDW5NRBTzGHSNw
	 TH79mkA3z4e/e5n0B+CcUyVpvF+YM3GGw/1fy01YUwDznhpIuF0WsVbHXX25PzlCChg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508975;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Action:X-Spam-Score:X-Spam-Flag:X-Spamd-Result:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Server;
	bh=Sls3bPmQCZyMAO5iplXNtOsVZo7FofwN1/WgYR7lQ8o=;
	b=joTBE47J9zh5eHYikrVdPm51yleYXwcCAGuzBlltBD/wo5xF62cGRNP6eBYduKBdRB8n
	 NBpgvef6gQR6wuUi5xPkve03rqzZF2IdYE93UBALNnJuoHBm2nrY3AzbrWPB2HflUF10U
	 GwHGXX+jyZ4RrMlHY5TLnB6mJxek4taYXa2B2oH9XYQVa0dl5G+HK0u9DlE16KCac752H
	 6f0+eXh5OD4rrYkubONd9ciD4BNB55ZMBt4xxDxhgRDZ/P3aP7dYJjEhyaK7Hd+oLBlLV
	 aj1RNU5bWKrhxAuvV4iOyg2mXq6Nwwul65ByJ+UEkUtpwbBRHk+ZIDTIVBUxT4vfkrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pb3uhxZT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Yk4FrAyW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pb3uhxZT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Yk4FrAyW;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41577606A325;
	Tue, 20 Oct 2026 15:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41577606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pb3uhxZT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Yk4FrAyW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pb3uhxZT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Yk4FrAyW
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 56E341F7CD;
	Tue, 20 Oct 2026 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792508966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sls3bPmQCZyMAO5iplXNtOsVZo7FofwN1/WgYR7lQ8o=;
	b=pb3uhxZTVaeXbRHucS6qREAJHNTXDF47MRY8XnKdSS2JjzHiciBJyy3ZVLDY4hwTFZfNS0
	pDb1pcjAmbLt+/TAoVDRVvK0KpMzHd2F3u4GOijl97WYoe5kH1VHdmpZzPOUfzmyxYmYzR
	YDOr1V1TuYfip17W0zq3FUsiPr85oPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792508966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sls3bPmQCZyMAO5iplXNtOsVZo7FofwN1/WgYR7lQ8o=;
	b=Yk4FrAyWhpjc8hCSSRcO2E/2FRWOsuQJmEA1JWoM83yRnOSiiWtSHtOO9Bn+GswR78zKK2
	STg1nVkn6KMMZJCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pb3uhxZT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yk4FrAyW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792508966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sls3bPmQCZyMAO5iplXNtOsVZo7FofwN1/WgYR7lQ8o=;
	b=pb3uhxZTVaeXbRHucS6qREAJHNTXDF47MRY8XnKdSS2JjzHiciBJyy3ZVLDY4hwTFZfNS0
	pDb1pcjAmbLt+/TAoVDRVvK0KpMzHd2F3u4GOijl97WYoe5kH1VHdmpZzPOUfzmyxYmYzR
	YDOr1V1TuYfip17W0zq3FUsiPr85oPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792508966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sls3bPmQCZyMAO5iplXNtOsVZo7FofwN1/WgYR7lQ8o=;
	b=Yk4FrAyWhpjc8hCSSRcO2E/2FRWOsuQJmEA1JWoM83yRnOSiiWtSHtOO9Bn+GswR78zKK2
	STg1nVkn6KMMZJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2357B136CC;
	Tue, 20 Oct 2026 15:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jTk2AiaE12pEaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 Oct 2026 15:09:26 +0000
Date: Tue, 20 Oct 2026 17:09:25 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, 
	frederic@kernel.org, tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <a6b3d7c6-64fd-4b92-8428-964a863ea9e8@flourine.local>
References: <20261016052203.489760-1-atomlin@atomlin.com>
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
In-Reply-To: <20261016052203.489760-1-atomlin@atomlin.com>
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.dk,gmail.com,suse.de,kernel.org,ashe.io,vger.kernel.org];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kernel.dk:email]
X-Spam-Level: 
X-Rspamd-Queue-Id: 56E341F7CD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri, Oct 16, 2026 at 01:22:03AM -0400, Aaron Tomlin wrote:
> Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> threads from executing block work on isolated CPUs. When all CPUs mapped
> to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> the intention of offloading execution.
> 
> However, kblockd_workqueue is allocated as a per-CPU workqueue
> (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> workqueue core resolves the target CPU via raw_smp_processor_id().
> Consequently, if a task executing on an isolated CPU submits I/O and
> triggers an asynchronous queue dispatch with zero delay (e.g. upon
> hardware queue congestion, tag/resource exhaustion returning
> BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> the local isolated CPU's worker pool. This causes the local per-CPU
> high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> in addition to introducing unwanted latency jitter on nohz_full cores,
> thereby defeating the original objective of commit a46c27026da1.
> 
> Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> from housekeeping_cpumask(HK_TYPE_DOMAIN) via
> cpumask_any_and_distribute() when executing on an isolated CPU, and
> otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
> unbound fallback paths in blk_mq_hctx_next_cpu()
> 
> This ensures that:
>     1.  When executing on an isolated CPU, deferred queue work is
>         cleanly offloaded to an online housekeeping CPU across single-queue
>         devices, hardware queues with empty cpumasks, and offline CPU
>         fallback paths.
> 
>     2.  The per-CPU high-priority kworker on the isolated CPU is not
>         scheduled, avoiding priority inversion and latency jitter.
> 
>     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
>         preserved, maintaining optimal local execution with zero CPU
>         bouncing.
> 
> Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> Changes since v2:
> 
>  - Query housekeeping_cpumask(HK_TYPE_DOMAIN) instead of HK_TYPE_TIMER
>    to align with cpu_is_isolated(), workqueue affinity rules, and cpuset
>    isolated partitions
> 
>  - Query the housekeeping cpumask under guard(rcu)() to safely handle
>    dynamic cpuset updates without lockdep warnings
> 
>  - Validate that cpumask_any_and_distribute() returns a valid cpu ID
>    before returning, falling back cleanly to WORK_CPU_UNBOUND
> 
>  - Link to v2: https://lore.kernel.org/all/20261015020225.422107-1-atomlin@atomlin.com/
> 
> Changes since v1:
> 
>  - Introduce the blk_mq_hctx_unbound_cpu() helper to steer deferred work
>    to an online housekeeping CPU only when executing on an isolated
>    core, preserving WORK_CPU_UNBOUND and local cache locality for
>    housekeeping cores
> 
>  - Apply blk_mq_hctx_unbound_cpu() across all unbound fallback paths in
>    blk_mq_hctx_next_cpu(), comprehensively covering single-queue devices
>    (nr_hw_queues == 1), empty hardware queue cpumasks, and the offline
>    CPU fallback path.
> 
>  - Elaborate in the commit log on the triggers for asynchronous queue
>    dispatch (e.g. tag exhaustion, BLK_STS_RESOURCE backpressure, and
>    plugging) and the SCHED_FIFO worker starvation hazard on isolated
>    cores
> 
>  - Link to v1: https://lore.kernel.org/lkml/20261012012905.267920-1-atomlin@atomlin.com/

Looks reasonable and related to my patch as well

  https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org

and I was able to create a blktests for it:

  https://lore.kernel.org/all/20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org

Would it possible to extend those tests or add a new one so we get this
also tested? And these two patches then should/could merge.
