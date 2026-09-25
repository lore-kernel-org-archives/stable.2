Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DB3AB262;
	Fri, 25 Sep 2026 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337142; cv=none; b=laBSPKKp11l5AX4FX8hmk3WWcNbGiBDXRRai82HQC0LLhamTUtv2avEbA06bH9YBJ4SadIRLfCTAvUy1zBqaAmuHT2hu7nKOs2tJvFiukzuTB+R1GOdI5nIkZ4t2EL0Uhl1c3hJiB3bzsf+1aZ7sXhgOyTTCbIDB6FnGG7A2qfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337142; c=relaxed/simple;
	bh=6bmfY8HJceGr7akz5gYMBXr7Yprkq22IwFV3/qVd5FU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDLCGD51wxeLG6geP0ndH60hTKOYwb0mXcW1JhuzralAJBJcbhcjzzt9D7x1DVaOQ+FPumIqNlkD7zJovLGK69pnVh6nN2Vi50HHbv/KCNnpFNLJrlokx0AS7t0dVvUq9UbVQ99pQqYbSEj5LHnyA6q5KGOuNT6MNvMj9wnBLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdgJ59lt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdgJ59lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6F51F000FF;
	Fri, 25 Sep 2026 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790337141;
	bh=gnR2egljKH+qXax1IeJY/N+dRlaUQHrIKREFzgFctzQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TdgJ59lt5u82qCHvUY5M+Xl1icq+UpnyHNkCfod8ZF3C4Lufl52abMBDJD1jgcceL
	 mEff+FLXr4WXwDLT4w4+FDOxuIC6lJU6v0kBPX1M3GA99m7TNQ++5zRyuY6TNmtWGz
	 CcYHVqGQ7T1OfsaPn1c78z0FloOC73CWfZGAamC+y6XY1Pqw/Ml+hS+jsi4kN1PCQg
	 NKYG1r3T5/aJvaJpg7/RlxFHK558AY9iYkIeM4DYH2yfQBR5W/aHf1YsDJHiogc9G7
	 LrkvbnF26GSey62lwzUOu29L/WVEgAO4P39cc+FgblK9+z3BCQ5plcx9S3VVdn5Qpn
	 Qkg0MO6QbzTxA==
Subject:
 Re: [PATCH net v2] net: cap skb->queue_mapping when the tx queue is picked
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 vinicius.gomes@intel.com, horms@kernel.org, xiangxia.m.yue@gmail.com,
 victor@mojatatu.com, zdi-disclosures@trendmicro.com, hybris@mojatatu.ai,
 stable@vger.kernel.org
Date: Fri, 25 Sep 2026 11:52:19 +0000
Message-ID: <179033713973.2160803.4914570693994398206@kernel.org>
In-Reply-To: <QDISC-9R8V.v2.20260924072708@mojatatu.com>
References: <QDISC-9R8V.v2.20260924072708@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not close the whole tc-BPF queue_mapping case its
  commit message claims to cover.
- [Low] The comment this patch adds in __dev_queue_xmit()
  (net/core/dev.c) says "The flag is per-CPU and a nested xmit can set…

--

net: cap skb->queue_mapping when the tx queue is picked

This patch changes __dev_queue_xmit() to save and clear the skip_txqueue
flag when a transmit frame starts and to restore it when the frame exits.
A nested xmit can then no longer hand the flag to an outer xmit. The patch
also stores the value picked by netdev_cap_txqueue() back into
skb->queue_mapping in netdev_tx_queue_mapping().

Link: https://lore.kernel.org/netdev/CANn89iLwYx8nCVf0pCEk_MmEiyC6kQaMwCQT9WkQVeeNzNQHqQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/179008581937.2160803.7117814290574262942@kernel.org/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0292a16e16c2c..e72a5c6dc63af 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4404,9 +4404,14 @@ EXPORT_SYMBOL(dev_loopback_xmit);
>  static struct netdev_queue *
>  netdev_tx_queue_mapping(struct net_device *dev, struct sk_buff *skb)
>  {
> -	int qm = skb_get_queue_mapping(skb);
> +	int queue = skb_get_queue_mapping(skb);
> +	int capped;
>  
> -	return netdev_get_tx_queue(dev, netdev_cap_txqueue(dev, qm));
> +	capped = netdev_cap_txqueue(dev, queue);
> +	if (unlikely(capped != queue))
> +		skb_set_queue_mapping(skb, capped);
> +
> +	return netdev_get_tx_queue(dev, capped);
>  }

[Severity: High]

The commit message says this write-back means "a mapping rewritten later
in the same egress run (for example a tc BPF store) cannot leave an
out-of-range index for the later readers on the xmit path". Is that true
for a BPF store made by a transmit-qdisc classifier?

In __dev_queue_xmit(), this write-back runs after sch_handle_egress() and
before q->enqueue(). The commit message itself notes that transmit-qdisc
classifiers run inside q->enqueue(), which is later in the same frame.

tc_cls_act_is_valid_access() lets any SCHED_CLS/SCHED_ACT program write
__sk_buff->queue_mapping. That includes a cls_bpf filter or act_bpf on a
transmit qdisc such as prio, multiq, htb, or a child of mq or taprio. The
ctx rewrite in net/core/filter.c only rejects values at or above
NO_QUEUE_MAPPING:

    if (BPF_CLASS(si->code) == BPF_ST && si->imm >= NO_QUEUE_MAPPING) {
        *insn++ = BPF_JMP_A(0); /* noop */
        break;
    }

Take a 1-queue device with a prio root and a cls_bpf filter that sets
skb->queue_mapping = 100 and returns TC_ACT_OK:

__dev_queue_xmit()
  netdev_core_pick_tx()            <- mapping capped here
  __dev_xmit_skb()
    dev_qdisc_enqueue()
      prio_enqueue()
        prio_classify()
          tcf_classify_qdisc()     <- BPF sets queue_mapping = 100
    qdisc_run()
      __qdisc_run()
        qdisc_restart()
          skb_get_tx_queue(dev, skb)
            netdev_get_tx_queue()  <- &dev->_tx[100]

The only check in netdev_get_tx_queue() is a debug warning:

    DEBUG_NET_WARN_ON_ONCE(index >= dev->num_tx_queues);
    return &dev->_tx[index];

sch_direct_xmit() then calls HARD_TX_LOCK(), netif_xmit_frozen_or_stopped()
and dev_hard_start_xmit() on that out-of-bounds netdev_queue. Drivers then
index their rings with the same value.

multiq behaves the same way. After classification it checks the band
against q->bands, but skb->queue_mapping stays out of range when
qdisc_restart() reads it.

This path does not use the skip_txqueue flag, so saving, clearing and
restoring the flag does not help here either.

The unchecked read in qdisc_restart() already existed before this patch.
However, the commit message and the v1->v2 notes ("covering the residual
in-frame rewrite nipa identified (e.g. a tc BPF store)") say this case is
fixed.

Would a cap on the consumer side be needed to close it, in qdisc_restart(),
skb_get_tx_queue() or sch_direct_xmit()? A bound on the BPF store could
also work.

If not, could the commit message make a narrower claim, so backporters do
not assume every queue_mapping out-of-bounds case is fixed?

[ ... ]

> @@ -4847,6 +4855,14 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>  
>  	tcx_set_ingress(skb, false);
>  #ifdef CONFIG_NET_EGRESS
> +	/* The flag is per-CPU and a nested xmit can set it from its own
> +	 * clsact hook or transmit qdisc. Own it for the whole frame: this
> +	 * frame cannot consume a nested xmit's flag and a nested xmit
> +	 * cannot inherit this frame's.
> +	 */

[Severity: Low]

This isn't a bug, but is "per-CPU" accurate on every config? With
CONFIG_PREEMPT_RT, the helpers in the same file store the flag per task:

    static bool netdev_xmit_txqueue_skipped(void)
    {
        return current->net_xmit.skip_txqueue;
    }

Saving and restoring the flag still works on RT, because nested xmits run
in the same task. Could the comment say "per-CPU (per-task on
PREEMPT_RT)"?

> +	skip_txq = netdev_xmit_txqueue_skipped();
> +	netdev_xmit_skip_txqueue(false);
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
