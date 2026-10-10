Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C843785C;
	Sat, 10 Oct 2026 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663599; cv=none; b=SZ3Lc7Ip9LJPoM8lspwrRUczcoAAlDLMehpxFSxa7u+ViDJd0FB6ZQqattKEoSAVrGIZ3hZbAa6zJDxhAmMnPwiiLvG90j3XT7QgD9tTHb+6/vZAyLFdhGQbuCP1VnVSO/JdYUC5OMzir70VgLf9oBHAwrgcuf7atGq9FyKMLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663599; c=relaxed/simple;
	bh=/Sf0cKiVKGHl+Am4wxmLhvpgZw9oVAfCazCFs1x1GEI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIoFXPlADNrPTnufXlDWJEjs5SMP8Sp6RrvhCxNJhc5j4K8c0iToOL5GtapEIBxlvOmz3dehECt+CrfzMkbm6gXo9UEf6G8DVmRYVL+yvsIPputdepCh6JED1tx5ObGMnrXK2ex4d4wpoGIcEhFjdHZILI1OrgAxcql8ERapp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxhNByKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxhNByKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5701F00893;
	Sat, 10 Oct 2026 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791663597;
	bh=EbZxgriG9LOE+4G3LAQgNhtyqzkdoxVqFQblWm+V5+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oxhNByKSXDWGdVjMDnDYYBib/2iK/5yb9QgTS5R6kqbnlvWT8fD/odtF8chzCeshd
	 SK1ID/Y0SzfnOSTKfAjwxGqf/+oYf6QLT9K2JZGXZmathmMekZM56SLRkTE57+b0mk
	 vKt5Z3oI3+Prd3wFdBcbu1NH6Rz4gOY7n00PQbMGUOW5cn6uNDAavQcgg+rp4hhAU0
	 5UsQIA2hT6vPL3RZSTyIujb8rJ/Vybwd+uQo6Cx0H5FVYPUv32OJigs133jgxKMJ1C
	 kPz3r12mankhDQi5Cko61MoXQhA0g9vr0UGA9JKovpAFHmEp9xgOGdR941BSJ1ZOGK
	 yJVhK8sjMmelQ==
Subject: Re: [PATCH net v7 2/4] net: hsr: preserve submission order without a
 forwarding lock
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
Date: Sat, 10 Oct 2026 20:19:55 +0000
Message-ID: <179166359576.434549.3725229845621611180@kernel.org>
In-Reply-To: <20261009201324.17-3-xiexinet@gmail.com>
References: <20261009201324.17-3-xiexinet@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hsr_queue_fits() (net/hsr/hsr_forward_queue.c) only checks
  HSR_JOB_INTERNAL_SUP jobs against the shared total (HSR_FWD_JOBS_MAX =…
- [Medium] The patch replaces seqnr_lock with hsr->fwd_owned, a bool that
  acts as an open-coded exclusive lock over the whole forwarding path…
- [Medium] Untrusted interlink RX frames and locally originated master TX
  frames share one ordinary-class admission budget (HSR_FWD_ORD_JOBS_MAX…
- [Low] net/hsr/hsr_forward_queue.c: hsr_job_process() always returns 1,
  and its comment says GSO per-frame accounting "is added by the…
- [Low] hsr_queue_submit() (net/hsr/hsr_forward_queue.c) allocates a
  struct hsr_job with GFP_ATOMIC, calls skb_dst_force() and calls…
- [Low] The concern says the commit message hides the scope of the
  redesign: a new 306-line file, a deferred-execution engine and a…
- [Low] The same input class is counted differently depending on which
  stage drops it.
- [Low] hsr_queue_submit() pins job->dev with an untracked dev_hold(),
  which is netdev_hold(dev, NULL, GFP_ATOMIC).

--

net: hsr: preserve submission order without a forwarding lock

This patch stops holding seqnr_lock across dev_queue_xmit(). Master TX,
interlink RX and internally generated supervision frames now go to a
single per-instance consumer: an idle caller runs its frame inline, and
contended callers queue it in a bounded FIFO that one BH work item
drains. Sequence numbers are assigned at execution time under a short
counter lock, and the queue is limited to 1024 jobs and 8 MiB, with a
reserve for supervision frames.

Link: https://syzkaller.appspot.com/bug?extid=fbf74291c3b7e753b481

> Fixes: 06afd2c31d33 ("hsr: Synchronize sending frames to have always incremented outgoing seq nr.")
> Fixes: 430d67bdcb04 ("net: hsr: Use the seqnr lock for frames received via interlink port.")

[Severity: Low]
This isn't a bug, but this patch carries both Fixes: tags and also adds a
new 306-line forwarding queue, a BH worker, and a new return convention
for proto_ops->fill_frame_info() (HSR_FRAME_PLAIN). The commit message
does describe the design.

Would it be easier to review and backport if the deadlock fix were split
from the queueing redesign? Or is the whole thing intended for stable as
one change?

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 7734a521a96c2..e8b53367bf3ec 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -640,13 +652,20 @@ static void handle_std_frame(struct sk_buff *skb,
>  	if (port->type != HSR_PT_MASTER)
>  		frame->is_from_san = true;
>  
> -	if (port->type == HSR_PT_MASTER ||
> -	    port->type == HSR_PT_INTERLINK) {
> -		/* Sequence nr for the master/interlink node */
> -		lockdep_assert_held(&hsr->seqnr_lock);
> -		frame->sequence_nr = hsr->sequence_nr;
> -		hsr->sequence_nr++;
> -	}
> +	if (!hsr_needs_local_numbering(port))
> +		return;
> +
> +	/* Sequence nr for the master/interlink node.  Local sequence
> +	 * numbers are assigned only by the single consumer; the
> +	 * explicit call-chain source proves it, shared ownership state
> +	 * does not.
> +	 */
> +	WARN_ON_ONCE(source == HSR_EXEC_DIRECT_LAN);

[Severity: Low]
This isn't a bug, but is the enum hsr_exec_source parameter needed? In
handle_std_frame() and hsr_assign_sup_seq() its only use is this
WARN_ON_ONCE(). hsr_forward_skb() routes on the same predicate:

hsr_forward_skb()
    if (hsr_needs_local_numbering(port)) {
        hsr_queue_submit(skb, port, HSR_JOB_NORMAL);
        return;
    }
    hsr_forward_frame(skb, port, HSR_EXEC_DIRECT_LAN);

so a master or interlink port can never reach this point with
HSR_EXEC_DIRECT_LAN.

Also, hsr_job_process() always returns 1 in this patch, so the
saturating budget arithmetic in hsr_queue_work() has no effect yet. The
comment there says per-frame accounting "is added by the segmentation
change". The next patch in the series ("net: hsr: segment GSO before
per-frame forwarding") replaces it with the return value of
hsr_forward_input(), so that part gets resolved later in the series.

> +	spin_lock_bh(&hsr->seqnr_lock);
> +	seq = hsr->sequence_nr;
> +	WRITE_ONCE(hsr->sequence_nr, seq + 1);
> +	spin_unlock_bh(&hsr->seqnr_lock);
> +	frame->sequence_nr = seq;
>  }

[ ... ]

> diff --git a/net/hsr/hsr_forward_queue.c b/net/hsr/hsr_forward_queue.c
> new file mode 100644
> index 0000000000000..5e96c24dec005
> --- /dev/null
> +++ b/net/hsr/hsr_forward_queue.c
> @@ -0,0 +1,306 @@

[ ... ]

> +/* Queue-stage drop: one count per dropped original input on the held
> + * entry device.  Ordinary interlink RX is an RX drop; master TX and
> + * internally generated supervision frames are TX drops.
> + */
> +static void hsr_fwd_drop_stat(struct net_device *dev, enum hsr_port_type type,
> +			      enum hsr_job_class class)
> +{
> +	if (class == HSR_JOB_NORMAL && type == HSR_PT_INTERLINK)
> +		dev_core_stats_rx_dropped_inc(dev);
> +	else
> +		dev_core_stats_tx_dropped_inc(dev);
> +}

[Severity: Low]
Should an interlink RX drop be counted differently depending on where it
happens? When an ordinary interlink frame is dropped at queue admission,
it is counted here with dev_core_stats_rx_dropped_inc(). If the same
frame fails fill_frame_info() one step later, hsr_forward_frame() counts
it as:

out_drop:
	rcu_read_unlock();
	port->dev->stats.tx_dropped++;

So userspace sees rx_dropped for one case and tx_dropped for the other,
and the two sites use different counter sets (core per-CPU stats vs
dev->stats).

Later in the series hsr_fwd_drop_stat() moves to hsr_forward.c and maps
every non-master normal input to rx_dropped. The out_drop path in
hsr_forward_frame() does not change, so the mismatch is still there.

[ ... ]

> +static bool hsr_queue_fits(struct hsr_priv *hsr, struct hsr_job *job)
> +{
> +	if (hsr->fwd_jobs >= HSR_FWD_JOBS_MAX)
> +		return false;
> +	if (job->charge > HSR_FWD_BYTES_MAX - hsr->fwd_bytes)
> +		return false;

[Severity: Medium]
Can internal supervision frames fill all HSR_FWD_JOBS_MAX slots? Only
HSR_JOB_NORMAL jobs have their own cap. HSR_JOB_INTERNAL_SUP jobs are
limited only by the shared total.

hsr_proxy_announce() sends one supervision frame per proxy_node_db entry
in a single timer callback:

	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
			continue;
		hsr->proto_ops->send_sv_frame(interlink, &interval,
					      node->macaddress_A);
	}

proxy_node_db is filled from source MACs seen on the interlink, and it
doesn't seem to have a size limit.

If that burst arrives while another context owns the consumer
(fwd_owned is true), supervision jobs can use all 1024 slots. Every
master TX and interlink RX frame then fails the fwd_jobs check above and
is dropped by hsr_job_drop() until the worker clears the burst, at 64
jobs per activation. Before this patch those frames waited on
seqnr_lock instead of being dropped.

Should the supervision class have a cap as well?

> +	if (job->class == HSR_JOB_NORMAL) {
> +		if (hsr->fwd_ord_jobs >= HSR_FWD_ORD_JOBS_MAX)
> +			return false;
> +		if (job->charge > HSR_FWD_ORD_BYTES_MAX - hsr->fwd_ord_bytes)
> +			return false;
> +	}
> +	return true;
> +}

[Severity: Medium]
Interlink RX and local master TX share this one ordinary budget. With
this patch, contended interlink receivers in hsr_handle_frame() queue
the frame and return instead of spinning on seqnr_lock. A SAN-side host
flooding the interlink, possibly from several RX CPUs on a multi-queue
NIC, could keep fwd_ord_jobs at HSR_FWD_ORD_JOBS_MAX.

Would locally originated frames then be dropped here?

hsr_dev_xmit()
  hsr_forward_skb(skb, master)
    hsr_queue_submit(skb, master, HSR_JOB_NORMAL)
      hsr_queue_fits() returns false
      hsr_job_drop(job)

Before this patch, interlink load could slow master TX through lock
contention, but it could not get master TX frames dropped at an
internal admission check. Every remote frame also gets a GFP_ATOMIC job
allocation before this check runs.

Should master TX have a reserve that is separate from interlink RX?

[ ... ]

> +static void hsr_queue_owned_release(struct hsr_priv *hsr)
> +{
> +	if (!hsr->fwd_stopped && !list_empty(&hsr->fwd_queue))
> +		queue_work(system_bh_wq, &hsr->fwd_work);
> +	else
> +		hsr->fwd_owned = false;
> +}

[ ... ]

> +static void hsr_queue_inline_one(struct hsr_priv *hsr, struct hsr_job *job)
> +{
> +	local_bh_disable();
> +	hsr_job_process(hsr, job, HSR_EXEC_INLINE);
> +	spin_lock_bh(&hsr->fwd_lock);
> +	hsr_queue_owned_release(hsr);
> +	spin_unlock_bh(&hsr->fwd_lock);
> +	local_bh_enable();
> +}
> +
> +void hsr_queue_submit(struct sk_buff *skb, struct hsr_port *port,
> +		      enum hsr_job_class class)
> +{
> +	struct hsr_priv *hsr = port->hsr;
> +	struct hsr_job *job;
> +	bool inline_owner = false;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> +			 "HSR queue submit outside RCU read-side");
> +
> +	job = kzalloc_obj(*job, GFP_ATOMIC);
> +	if (!job) {
> +		hsr_fwd_drop_stat(port->dev, port->type, class);
> +		kfree_skb(skb);
> +		return;
> +	}

[Severity: Low]
This allocation, plus the skb_dst_force() and dev_hold() below, runs for
every master TX, interlink RX and supervision frame. All of it happens
before fwd_lock is taken to check whether the consumer is idle. In the
uncontended inline case the job never enters the queue, so is a heap
allocation needed there?

It also adds a new drop path: if the GFP_ATOMIC allocation fails, the
frame is dropped through hsr_fwd_drop_stat() and kfree_skb(). Before
this patch, hsr_dev_xmit() and the interlink RX path allocated nothing
at this point.

Would an on-stack job for the inline case, or allocating only when the
job has to be queued, avoid both the per-packet cost and this new
failure mode?

> +	job->skb = skb;
> +	job->dev = port->dev;
> +	job->type = port->type;
> +	job->class = class;
> +	job->depth = dev_recursion_level();
> +	job->charge = skb->truesize;
> +	skb_dst_force(skb);
> +	dev_hold(job->dev);

[Severity: Low]
This isn't a bug, but this reference is passed to system_bh_wq and can
outlive the submitting context. Would netdev_hold() with a
netdevice_tracker in struct hsr_job work better than an untracked
dev_hold()?

With CONFIG_NET_DEV_REFCNT_TRACKER, a leaked job reference would then
show the owner's stack, not just the generic "waiting for <dev> to
become free" message.

> +
> +	spin_lock_bh(&hsr->fwd_lock);
> +	if (hsr->fwd_stopped) {
> +		spin_unlock_bh(&hsr->fwd_lock);
> +		hsr_job_drop(job);
> +		return;
> +	}
> +	if (!hsr->fwd_owned) {
> +		/* Idle: take the execution ownership and process this
> +		 * input directly.  The job never enters the public queue
> +		 * and does not consume queued charge.
> +		 */
> +		hsr->fwd_owned = true;
> +		inline_owner = true;
> +	} else if (hsr_queue_fits(hsr, job)) {
> +		list_add_tail(&job->list, &hsr->fwd_queue);
> +		hsr_queue_charge_add(hsr, job);
> +	} else {
> +		spin_unlock_bh(&hsr->fwd_lock);
> +		hsr_job_drop(job);
> +		return;
> +	}
> +	spin_unlock_bh(&hsr->fwd_lock);
> +
> +	if (inline_owner)
> +		hsr_queue_inline_one(hsr, job);
> +}

[Severity: Medium]
fwd_owned acts as an exclusive lock over the whole forwarding path:
fill_frame_info(), hsr_forward_do() and dev_queue_xmit() to every lower.
Contenders never wait on it, though. They add to fwd_queue and return.

Does this lose the priority inheritance that seqnr_lock gave on
PREEMPT_RT? There, spinlock_t is rt_mutex based, so a high-priority
contender would boost a low-priority holder. Now suppose a low-priority
task takes ownership in hsr_dev_xmit() and is preempted inside
hsr_queue_inline_one():

	local_bh_disable();
	hsr_job_process(hsr, job, HSR_EXEC_INLINE);

local_bh_disable() does not prevent preemption on RT, and nothing boosts
the owner. Master TX, interlink RX and supervision frames from every CPU
wait in the queue until it runs again. Once the queue fills, they are
dropped.

The commit message seems to describe forwarding stopping for as long as
the load ran:

  On PREEMPT_RT, high-priority load preempted both the inline consumer
  and BH worker while another CPU continued to enqueue inputs. All
  2118 inputs completed without drops; the finite data workload
  completed 4.07 seconds after the load ended.

On non-RT, hsr_queue_owned_release() hands ownership to the worker:

	queue_work(system_bh_wq, &hsr->fwd_work);

system_bh_wq is per-CPU, so the backlog for the whole instance drains
only on the CPU that queued the work. If that CPU is busy, can inputs
from all the other CPUs pile up to the 960/1024 limits and get dropped?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009201324.17-1-xiexinet%40gmail.com
