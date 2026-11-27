Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795771138;
	b=1XJtDaQLPFMU9SPPlsT/+Uzc8pxfYecqVRI99qWamhxcVo3cYSrU3nQBGi7fmXg0jD8d
	 qvdIq27RWsPccIYuZUquxZAIDXm0WmtvIDguTYKrS0fbPdEOKcgJbi8OVXsNvsWDD+uN6
	 RULyJ/ffHinYZgJ6SS+/lt+5JdTQiJKJYyUzHdVwD2TbvDDd1h5DmDU0FVmA6K0lPfhze
	 OauC/M+eL82T/eK1qUFKoz4VEXQgEfF6ktmD0y1sNp1kZ3WEu1UyPPjKcp7CDzCivwF55
	 AS9bOkPrGdVkSqRoJfQ+h0idFnXNtsoL+3KtBSFRr17yOEvsju6n8mElkVL0TRvF7WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795771138;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=O76IIwZpAm8NpBXKtN94VyTUYktRHuJ9UogySv+TxgE=;
	b=Ka8PUIXXklOyfa9FUmTTKQjsKZ2VWml96hePD9AehCvAqXN+DR6a1+53KTykZlPh0pGm
	 WFQeW2SIAgM8QKlALarTwhHFKwbgiNjUkIy4RvVVv4K47QMyRa9DpXhTjRxZKy7pGRXJL
	 T/CU7oiF4cVj6fEBJrYMmltZR07traXHb3QDT6khBiCLnfeaNciM0RsS3oVSLDn1ug6rP
	 rZxLLUIErpZ0l956rQ28rvOow71F6P/tdFpSPNwRnEjLxrR9qonbCjS8HU/Amm2zhIqzu
	 HGFRge0E6ddlgCJNAo1aYg5BCWSsfHKk0xpG3owjfag0ZtyiTFkA8sBwIaOky8l603w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=q+P8Z+VF;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C367606A31C;
	Fri, 27 Nov 2026 09:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C367606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=q+P8Z+VF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O76IIwZpAm8NpBXKtN94VyTUYktRHuJ9UogySv+TxgE=; b=q+P8Z+VFvcXOYcSsAQUUKdha9A
	G0JnWTshf2VqEs1N0M1XnEtiC5lRjVs73Mz+IgnC1cOkOb6aFxF3ZzgdxDCEewLlIeb9EmKc5Rg6e
	sfwiaF44IVMsmeI9AFm59NLM3hJyQLzmbuZmMGlqgW+InkS3imPOr6A1oU4kRbWDpse4wqwPQ6B40
	h0Gg2m9PHl0Z8QlWWZyq9OI1A+eXY1FHVI8GjGpseiNEVkigkH1Z+tDjdqdU8ePUwYJoD/RcBKxEY
	KcjE6N0W01wkSJGeVuq3V+fNaGplx33ZN3K6xkyLT2axYOwH3Skhv763gFTVnN4jjYAH+yEF9Acpz
	ciUf+WTw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWs6Y-00000007VNz-0X3X;
	Fri, 27 Nov 2026 09:18:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 655D530316A; Fri, 27 Nov 2026 10:18:52 +0100 (CET)
Date: Fri, 27 Nov 2026 10:18:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH 1/2] perf: look up address filter files without
 ctx->mutex held
Message-ID: <20261127091852.GD83911@noisy.programming.kicks-ass.net>
References: <20261126-work-exec-update_lock-leftovers-v1-0-1024b26792bc@kernel.org>
 <20261126-work-exec-update_lock-leftovers-v1-1-1024b26792bc@kernel.org>
 <20261126152414.GH49833@noisy.programming.kicks-ass.net>
 <20261126-gedruckt-gastarbeiter-vorsorgen-5fea7cea1877@brauner>
 <20261126-erlogen-bedrucken-dementieren-5de5e5460481@brauner>
 <20261127081303.GN49833@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261127081303.GN49833@noisy.programming.kicks-ass.net>

On Fri, Nov 27, 2026 at 09:13:03AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 26, 2026 at 10:26:02PM +0100, Christian Brauner wrote:
> > So ok, if we can't drop ctx->mutex in the middle of the ioctl then how
> > about we don't hold ctx->mutex during parsing to begin with?
> > We let perf_ioctl() hand PERF_EVENT_IOC_SET_FILTER off before it takes
> > the mutex:
> > 
> > ioctl(PERF_EVENT_IOC_SET_FILTER)
> > -> perf_ioctl()
> >    -> perf_event_set_filter()                // no ctx->mutex
> >       -> perf_event_set_addr_filter()
> >          -> perf_event_parse_addr_filter()   // kern_path(), own list
> >          -> perf_event_ctx_lock()
> >             // revoked? has_addr_filter()? ->addr_filters_validate()
> >             -> perf_addr_filters_splice()
> >             -> perf_event_addr_filters_apply() on each child
> >          -> perf_event_ctx_unlock()
> > 
> > The parser fills its own list and counts the file filters in locals.
> > Everything that needs ctx->mutex then happens in one go under
> > perf_event_ctx_lock().
> > 
> > So ctx->mutex is never dropped in the middle of an ioctl, a migrated
> > event is handled by perf_event_ctx_lock() like everywhere else and no
> > ctx is carried across the lookup?
> 
> Let me try this.

Compile tested only; Alexander, Adrian; could any of you take a hard
look at this and actually test?

---
 kernel/events/core.c | 135 +++++++++++++++++++++++++--------------------------
 1 file changed, 67 insertions(+), 68 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 77c501005143..c019e4faf655 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6632,16 +6632,24 @@ static inline bool is_perf_file(struct fd f)
 
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
-static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_filter(struct perf_event *event, struct list_head *filters);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
 static int __perf_event_set_bpf_prog(struct perf_event *event,
 				     struct bpf_prog *prog,
 				     u64 bpf_cookie);
 
-static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
+struct perf_ioctl_ctx {
+	unsigned int cmd;
+	unsigned long arg;
+	struct list_head filters;
+};
+
+static long _perf_ioctl(struct perf_event *event, struct perf_ioctl_ctx *ctx)
 {
 	void (*func)(struct perf_event *);
+	unsigned long arg = ctx->arg;
+	unsigned int cmd = ctx->cmd;
 	u32 flags = arg;
 
 	if (event->state <= PERF_EVENT_STATE_REVOKED)
@@ -6692,7 +6700,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 	}
 
 	case PERF_EVENT_IOC_SET_FILTER:
-		return perf_event_set_filter(event, (void __user *)arg);
+		return perf_event_set_filter(event, &ctx->filters);
 
 	case PERF_EVENT_IOC_SET_BPF:
 	{
@@ -6751,10 +6759,21 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 	return 0;
 }
 
+static inline bool perf_event_is_tracing(struct perf_event *event);
+static void free_filters_list(struct list_head *filters);
+static int
+perf_event_parse_addr_filter(int event_node, bool event_task, char *fstr,
+			     struct list_head *filters);
+
 static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct perf_event *event = file->private_data;
 	struct perf_event_context *ctx;
+	struct perf_ioctl_ctx ic = {
+		.cmd = cmd,
+		.arg = arg,
+		.filters = LIST_HEAD_INIT(ic.filters),
+	};
 	long ret;
 
 	/* Treat ioctl like writes as it is likely a mutating operation. */
@@ -6762,10 +6781,34 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (ret)
 		return ret;
 
+	if (cmd == PERF_EVENT_IOC_SET_FILTER) {
+		int cpu = READ_ONCE(event->cpu);
+		int node = cpu == -1 ? NUMA_NO_NODE : cpu_to_node(cpu);
+		bool task = event->attach_state & PERF_ATTACH_TASK;
+		char *filter_str __free(kfree) =
+			strndup_user((void __user *)arg, PAGE_SIZE);
+
+		if (IS_ERR(filter_str))
+			return PTR_ERR(filter_str);
+
+#ifdef CONFIG_EVENT_TRACING
+		if (perf_event_is_tracing(event)) {
+			return ftrace_profile_set_filter(event, event->attr.config,
+							filter_str);
+		}
+#endif
+		ret = perf_event_parse_addr_filter(node, task, filter_str,
+						   &ic.filters);
+		if (ret)
+			return ret;
+	}
+
 	ctx = perf_event_ctx_lock(event);
-	ret = _perf_ioctl(event, cmd, arg);
+	ret = _perf_ioctl(event, &ic);
 	perf_event_ctx_unlock(event, ctx);
 
+	free_filters_list(&ic.filters);
+
 	return ret;
 }
 
@@ -11990,9 +12033,8 @@ void perf_bp_event(struct perf_event *bp, void *data)
  * Allocate a new address filter
  */
 static struct perf_addr_filter *
-perf_addr_filter_new(struct perf_event *event, struct list_head *filters)
+perf_addr_filter_new(int node, struct list_head *filters)
 {
-	int node = cpu_to_node(event->cpu == -1 ? 0 : event->cpu);
 	struct perf_addr_filter *filter;
 
 	filter = kzalloc_node(sizeof(*filter), GFP_KERNEL, node);
@@ -12035,8 +12077,17 @@ static void perf_addr_filters_splice(struct perf_event *event,
 	raw_spin_lock_irqsave(&event->addr_filters.lock, flags);
 
 	list_splice_init(&event->addr_filters.list, &list);
-	if (head)
+	event->addr_filters.nr_file_filters = 0;
+
+	if (head) {
+		struct perf_addr_filter *filter;
+
 		list_splice(head, &event->addr_filters.list);
+		list_for_each_entry(filter, &event->addr_filters.list, entry) {
+			if (filter->path.dentry)
+				event->addr_filters.nr_file_filters++;
+		}
+	}
 
 	raw_spin_unlock_irqrestore(&event->addr_filters.lock, flags);
 
@@ -12186,7 +12237,7 @@ static const match_table_t if_tokens = {
  * Address filter string parser
  */
 static int
-perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
+perf_event_parse_addr_filter(int event_node, bool event_task, char *fstr,
 			     struct list_head *filters)
 {
 	struct perf_addr_filter *filter = NULL;
@@ -12213,7 +12264,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 
 		/* filter definition begins */
 		if (state == IF_STATE_ACTION) {
-			filter = perf_addr_filter_new(event, filters);
+			filter = perf_addr_filter_new(event_node, filters);
 			if (!filter)
 				goto fail;
 		}
@@ -12299,7 +12350,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 				 * different processes.
 				 */
 				ret = -EOPNOTSUPP;
-				if (!event->ctx->task)
+				if (!event_task)
 					goto fail;
 
 				/* look up the path and grab its inode */
@@ -12310,11 +12361,8 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 
 				ret = -EINVAL;
 				if (!filter->path.dentry ||
-				    !S_ISREG(d_inode(filter->path.dentry)
-					     ->i_mode))
+				    !S_ISREG(d_inode(filter->path.dentry)->i_mode))
 					goto fail;
-
-				event->addr_filters.nr_file_filters++;
 			}
 
 			/* ready to consume more filters */
@@ -12343,9 +12391,8 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 }
 
 static int
-perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
+perf_event_set_filter(struct perf_event *event, struct list_head *filters)
 {
-	LIST_HEAD(filters);
 	int ret;
 
 	/*
@@ -12357,65 +12404,17 @@ perf_event_set_addr_filter(struct perf_event *event, char *filter_str)
 	if (WARN_ON_ONCE(event->parent))
 		return -EINVAL;
 
-	ret = perf_event_parse_addr_filter(event, filter_str, &filters);
+	ret = event->pmu->addr_filters_validate(filters);
 	if (ret)
-		goto fail_clear_files;
-
-	ret = event->pmu->addr_filters_validate(&filters);
-	if (ret)
-		goto fail_free_filters;
+		return ret;
 
 	/* remove existing filters, if any */
-	perf_addr_filters_splice(event, &filters);
+	perf_addr_filters_splice(event, filters);
 
 	/* install new filters */
 	perf_event_for_each_child(event, perf_event_addr_filters_apply);
 
-	return ret;
-
-fail_free_filters:
-	free_filters_list(&filters);
-
-fail_clear_files:
-	event->addr_filters.nr_file_filters = 0;
-
-	return ret;
-}
-
-static int perf_event_set_filter(struct perf_event *event, void __user *arg)
-{
-	int ret = -EINVAL;
-	char *filter_str;
-
-	filter_str = strndup_user(arg, PAGE_SIZE);
-	if (IS_ERR(filter_str))
-		return PTR_ERR(filter_str);
-
-#ifdef CONFIG_EVENT_TRACING
-	if (perf_event_is_tracing(event)) {
-		struct perf_event_context *ctx = event->ctx;
-
-		/*
-		 * Beware, here be dragons!!
-		 *
-		 * the tracepoint muck will deadlock against ctx->mutex, but
-		 * the tracepoint stuff does not actually need it. So
-		 * temporarily drop ctx->mutex. As per perf_event_ctx_lock() we
-		 * already have a reference on ctx.
-		 *
-		 * This can result in event getting moved to a different ctx,
-		 * but that does not affect the tracepoint state.
-		 */
-		mutex_unlock(&ctx->mutex);
-		ret = ftrace_profile_set_filter(event, event->attr.config, filter_str);
-		mutex_lock(&ctx->mutex);
-	} else
-#endif
-	if (has_addr_filter(event))
-		ret = perf_event_set_addr_filter(event, filter_str);
-
-	kfree(filter_str);
-	return ret;
+	return 0;
 }
 
 /*
