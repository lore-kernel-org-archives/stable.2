Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235A3537CD;
	Wed, 30 Sep 2026 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729916; cv=none; b=SNJXOjIAMEqL/R5IVLxZrAQt4ky/ci7hs1uvU5swHmwrMENvFxVipCu+5+zD6VIED57b4xnLwMBoQGHKIfBnrM3Ft2+sr5Tn/tgvcTdsLdKK4+FhYwrs5t84lOdyJOE2R03SiYV+KLtAaexnsMOlrdZA2OSHWHhPBuCCC4gcJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729916; c=relaxed/simple;
	bh=t+R+FXZGQNP6jEgyp5jMjpsd+b6ZgTdckszKZhdCIOk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HdV9P/9mn25kLQZaA/9wViXM4lelBhnc/3APS+aZGSFpUOUr8N/j4g6DqK2RAXy8lBtysyCGUMgjYw68luxPWJpc/GOw5xGfsp9u90oJ5DWBYy3vYRthx6HPvYtSzBmUnSCK3a4Wc6cfIzRLOieZ4gy5SRjE+15UbCMqh61v7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmW/nnVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmW/nnVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDDD1F00893;
	Wed, 30 Sep 2026 00:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729915;
	bh=SmffG1wdban4FHiyxbAkH8QFCMiPIyOO/odZpjkc624=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bmW/nnVZzTY2lYYVSFp2h63Dy1u/jj57bvUnbe6zoYNMJM2SvreTYuFthH7y6/0Oz
	 oDDoJ2CSyxwtmUnE79cNmMIlmVd9quS0qPJao0sF6E6qvZGPDEst8JG0C2LfXSywIs
	 MlZVh4jzZjDuh3SQKez0n7UJLbltcTXLfvyivDu/Lp5SzIWOvj66vVFwXAGnpBG89T
	 z9SIzp6OKhDsgFXdZPSAIHLuEb4ZCKZmqmCH64cVVZKK+bczoa/PZd4BZoMf1vLsIm
	 4o1kdkkekjJmo/GsFMzSYGc67ujtGSIyK//CzODruPZ6As7R6yEIvn03nvzNN0f4qu
	 DL30XCr1JrmFg==
Subject: Re: [PATCH net 3/6] ice: Restore Ordered MMIO Writes for Tx Doorbells
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 david.butler@appgate.com, emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 tomasz.lichwala@linux.intel.com, horms@kernel.org,
 aleksander.lobakin@intel.com, stable@vger.kernel.org,
 jacob.e.keller@intel.com, aleksandr.loktionov@intel.com
Date: Wed, 30 Sep 2026 00:58:33 +0000
Message-ID: <179072991356.434549.1211761359531074249@kernel.org>
In-Reply-To: <20260928230429.495442-4-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes only the writer side of the ordering chain
  behind the dql_completed() BUG_ON.

--

ice: Restore Ordered MMIO Writes for Tx Doorbells

This commit changes the Tx ring and tstamp ring tail doorbell writes in
ice_tx_map() from writel_relaxed() back to writel(). The goal is to make
the dql->num_queued update from __netdev_tx_sent_queue() visible before
the NIC can start on the new descriptors. That avoids the BUG_ON in
dql_completed() seen on arm64.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2161572

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 31303ab5be175..a2c7c4962882d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1561,10 +1561,10 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
>  			}
>  		}
>  		tstamp_ring->next_to_use = j;
> -		writel_relaxed(j, tstamp_ring->tail);
> +		writel(j, tstamp_ring->tail);
>  	} else {
>  ring_kick:
> -		writel_relaxed(i, tx_ring->tail);
> +		writel(i, tx_ring->tail);
>  	}
>  	return;

[Severity: Medium]

This orders the xmit side. Is there a matching read barrier on the
completion side?

ice_clean_tx_irq() reads the DONE bit that the device writes, and then
completes the queue:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_clean_tx_irq() {
    ...
		if (!(eop_desc->cmd_type_offset_bsz &
		      cpu_to_le64(ICE_TX_DESC_DTYPE_DESC_DONE)))
			break;
    ...
	netdev_tx_completed_queue(txring_txq(tx_ring), total_pkts, total_bytes);
    ...
}

netdev_tx_completed_queue() then calls dql_completed(), which uses a
relaxed load:

lib/dynamic_queue_limits.c:dql_completed() {
	num_queued = READ_ONCE(dql->num_queued);
    ...
	BUG_ON(count > num_queued - dql->num_completed);
    ...
}

The smp_mb() in netdev_tx_completed_queue() runs after dql_completed(), so
it does not order this load. On arm64, a control dependency on the DONE
bit does not order a later load either.

The barriers that happen to sit on this path are not always there:

- The smp_rmb() at the top of the ice_clean_tx_irq() loop runs again only
  when the next tx_buf has a non-NULL next_to_watch. It is skipped when
  the loop stops on a NULL next_to_watch or when the budget runs out.

- skb_unref() issues smp_rmb() only when skb->users == 1 and
  CONFIG_DEBUG_NET is off. With users > 1 (for example pktgen with burst,
  which does refcount_add(burst, &skb->users)), napi_consume_skb() skips
  the defer path. The failing refcount_dec_and_test() then gives only
  release ordering.

- u64_stats_update_begin()/end() in ice_update_tx_ring_stats() are no-ops
  on 64-bit. dma_unmap_single() does nothing for coherent dma-direct
  without an IOMMU.

On that path, can the num_queued load complete before the DONE bit load?
If so, it would return a value from before the xmit CPU's dql_queued()
update and hit the same BUG_ON this commit is meant to fix.

The window is probably very small in practice. The num_queued store comes
before the doorbell, the descriptor fetch, the transmit and the DONE
write-back, and testing shows the observed crash is gone. This reader-side
pattern is also older than both this patch and commit ccde82e90946.

Would a dma_rmb() or smp_rmb() in ice_clean_tx_irq() help close this
fully? It could go after the DONE check or before the
netdev_tx_completed_queue() call.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928230429.495442-1-anthony.l.nguyen%40intel.com
