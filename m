Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A74C39023F;
	Wed, 23 Sep 2026 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142911; cv=none; b=jB4scD+rM+WX34OJ8EZa0fzeHDJn1QBIbYFENfe+7BNTWofEtRV6aPOeFPV7ZSTdEQfqaPXhSGbvuOOCNbHSkpe8PLA75qGQcTsjgWJT3Vn1HUuUtxBKE+tw3vHHLGvx7JJF47STBBEJCBCxdIbYnQSyEhGF5pR5QJik/8BJo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142911; c=relaxed/simple;
	bh=oDL76qZe3pLsjMdiwLHE3eLhw+zujf3kzzYwe3mCEd0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDsg5gBTJHdQGtJhp6WFnas1qAd257jjOh2gK4BZvwcoOS0OfKyyv7u+3/P33xDcZc9roU0hvlzId4j/9MqItejnzw6c2qdDXsC0z2dlGKB2NMKym8HJcHIsK8Yg4IyABljSxFq7OO1DpYgJMUxKEwmaQyeTFf1EKn3KdVwT70s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9SoH5iQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9SoH5iQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8151F000FF;
	Wed, 23 Sep 2026 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790142909;
	bh=TraGMeCA9pkffDDmCOvPFMTZm8A9mB7/rgVzunnJM6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h9SoH5iQkl3t37QCkgDv34WeMmzNr8I+fr84AcprN4TyGLE5zwyd/4fPA1K7kPyVB
	 o2kRvuEtiwvV3NOZglTkgN1d4nyUDUyc2LQsRDKd3E46/CGNXWIEgpItQyjJh+FWA7
	 Q8niw17vXKEAQ881f488Tye6ZI1FWeeNImUz7DsVH2yteO+z5jNYlybWJAwoKNnyPh
	 zpWPf+65Ka2+KTA2FKwgIIaSObAz7OxhBxrnEnYBNWAApgtB9dKYQWsmoNEJ94tVIh
	 LvcySD6zUHyUBMJhFDQMkJIUjG7taPBtzhKAn0N3UUFRX4XB5jc2rKTxN8vDVxmKPQ
	 BGL5f/aAhMFqg==
Subject: Re: [PATCH v2] net: mediatek: fix PPE resource leak on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Date: Wed, 23 Sep 2026 05:55:08 +0000
Message-ID: <179014290838.2160803.10190235889811039929@kernel.org>
In-Reply-To: <20260921145421.443018-1-lgs201920130244@gmail.com>
References: <20260921145421.443018-1-lgs201920130244@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Teardown ordering bug: mtk_remove() calls the newly added
  mtk_ppe_deinit(eth) *after* mtk_hw_deinit(eth), which has already…
- [High] Use-after-free: mtk_remove() destroys the shared offload
  rhashtable (mtk_ppe_deinit() -> mtk_eth_offload_deinit() ->…
- [Medium] The WED reference drop added in mtk_flow_offload_free()
  (mtk_wed_flow_remove(entry->wed_index)) is dead code on the remove…

Pre-existing issues:
- [Medium] Pre-existing WED flow-reference leak in
  mtk_flow_offload_replace(): after 'if (wed_index >= 0 && (err =…

--

net: mediatek: fix PPE resource leak on remove

This patch drains eth->flow_table with rhashtable_free_and_destroy()
during PPE teardown, removes the PPE debugfs directories, tracks whether
the shared flow table was initialized, and calls mtk_ppe_deinit() from
mtk_remove().

A few questions about the new teardown ordering below.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 2ea5dfe85539b..0625be1b112f7 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5410,6 +5410,7 @@ static void mtk_remove(struct platform_device *pdev)
>  
>  	netif_napi_del(&eth->tx_napi);
>  	netif_napi_del(&eth->rx_napi);
> +	mtk_ppe_deinit(eth);
>  	mtk_cleanup(eth);
>  	free_netdev(eth->dummy_dev);
>  	mtk_mdio_cleanup(eth);

[Severity: High]
Can this new call site touch PPE registers after the clocks are gone?
In mtk_remove(), mtk_hw_deinit() has already run before this point:

drivers/net/ethernet/mediatek/mtk_eth_soc.c:mtk_hw_deinit() {
	if (!test_and_clear_bit(MTK_HW_INIT, &eth->state))
		return 0;

	mtk_clk_disable(eth);

	pm_runtime_put_sync(eth->dev);
	pm_runtime_disable(eth->dev);
	...
}

The new drain path reaches MMIO for every entry that still has a
hardware slot:

mtk_ppe_deinit() -> mtk_eth_offload_deinit() ->
rhashtable_free_and_destroy(&eth->flow_table, mtk_flow_offload_free) ->
mtk_foe_entry_clear() -> __mtk_foe_entry_clear()

drivers/net/ethernet/mediatek/mtk_ppe.c:__mtk_foe_entry_clear() {
	if (entry->hash != 0xffff) {
		struct mtk_foe_entry *hwe = mtk_foe_get_entry(ppe, entry->hash);

		hwe->ib1 &= ~MTK_FOE_IB1_STATE;
		hwe->ib1 |= FIELD_PREP(MTK_FOE_IB1_STATE, MTK_FOE_STATE_INVALID);
		dma_wmb();
		mtk_ppe_cache_clear(ppe);
	...
}

drivers/net/ethernet/mediatek/mtk_ppe.c:mtk_ppe_cache_clear() {
	ppe_set(ppe, MTK_PPE_CACHE_CTL, MTK_PPE_CACHE_CTL_CLEAR);
	ppe_clear(ppe, MTK_PPE_CACHE_CTL, MTK_PPE_CACHE_CTL_CLEAR);
}

mtk_ppe_stop() does not reset entry->hash, so the hash != 0xffff branch
is reachable during unbind when offloaded flows are present.

The probe unwind uses the opposite order, with mtk_ppe_deinit() running
before mtk_hw_deinit() and mtk_wed_exit():

err_deinit_ppe:
	mtk_ppe_deinit(eth);
	mtk_mdio_cleanup(eth);
err_free_dev:
	mtk_free_dev(eth);
err_deinit_hw:
	mtk_hw_deinit(eth);
err_wed_exit:
	mtk_wed_exit();

Should the remove path place mtk_ppe_deinit() before mtk_wed_exit() and
mtk_hw_deinit() to match?

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> index 88a9b3b23bea5..2b33067345c39 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
> @@ -1346,6 +1346,7 @@ struct mtk_eth {
>  
>  	struct mtk_ppe			*ppe[3];
>  	struct rhashtable		flow_table;
> +	bool				flow_table_initialized;
>  
>  	struct bpf_prog			__rcu *prog;
>  

[ ... ]

> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
> index 8451dc3fd00aa..f41df3cf0e2b8 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe.c

[ ... ]

> @@ -946,7 +947,17 @@ void mtk_ppe_deinit(struct mtk_eth *eth)
>  
>  	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++) {
>  		if (!eth->ppe[i])
> -			return;
> +			continue;
> +
> +		debugfs_lookup_and_remove(eth->ppe[i]->dirname, NULL);
> +	}
> +
> +	mtk_eth_offload_deinit(eth);
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++) {
> +		if (!eth->ppe[i])
> +			continue;
> +
>  		rhashtable_destroy(&eth->ppe[i]->l2_flows);
>  	}
>  }

> diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> index 99b28aaa7cc47..5b14c7b3052f9 100644
> --- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> +++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
> @@ -678,9 +678,42 @@ int mtk_eth_setup_tc(struct net_device *dev, enum tc_setup_type type,
>  	}
>  }
>  
> +static void mtk_flow_offload_free(void *ptr, void *arg)
> +{
> +	struct mtk_flow_entry *entry = ptr;
> +	struct mtk_eth *eth = arg;
> +
> +	mtk_foe_entry_clear(eth->ppe[entry->ppe_index], entry);
> +
> +	if (entry->wed_index >= 0)
> +		mtk_wed_flow_remove(entry->wed_index);

[Severity: Medium]
Does this mtk_wed_flow_remove() actually drop anything on the remove
path?  mtk_remove() runs mtk_wed_exit() before the new
mtk_ppe_deinit(), and mtk_wed_exit() tears down the WED registry:

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_exit() {
	...
		hw_list[i] = NULL;
		debugfs_remove(hw->debugfs_dir);
		put_device(hw->dev);
		of_node_put(hw->node);
		kfree(hw);
	...
}

so by the time the drain runs, mtk_wed_flow_remove() takes the early
bail-out:

drivers/net/ethernet/mediatek/mtk_wed.c:mtk_wed_flow_remove() {
	struct mtk_wed_hw *hw = hw_list[index];

	mutex_lock(&hw_lock);

	if (!hw || !hw->wed_dev)
		goto out;
	...
}

hw->num_flows is never decremented, wlan.offload_disable() is never
called and mtk_wed_set_ext_int() is never re-run, so the enable done by
mtk_wed_flow_add() is left unpaired.  Is the commit message claim of
"dropping the WED flow reference when necessary" reachable with this
ordering?

[Severity: Medium]
This isn't a bug introduced by this patch, but while on the subject of
WED flow references: mtk_flow_offload_replace() acquires one before the
entry allocation and the allocation failure path returns without
releasing it:

drivers/net/ethernet/mediatek/mtk_ppe_offload.c:mtk_flow_offload_replace() {
	if (wed_index >= 0 && (err = mtk_wed_flow_add(wed_index)) < 0)
		return err;

	entry = kzalloc_obj(*entry);
	if (!entry)
		return -ENOMEM;
	...
}

mtk_wed_flow_add() has already incremented hw->num_flows and possibly
called wlan.offload_enable(), and since no entry is inserted into
eth->flow_table the new drain cannot balance it either.  Should this
return go through the goto-based unwind further down the function, which
does call mtk_wed_flow_remove()?

> +
> +	kfree(entry);
> +}
> +
>  int mtk_eth_offload_init(struct mtk_eth *eth, u8 id)
>  {
> -	if (!eth->ppe[id] || !eth->ppe[id]->foe_table)
> +	int err;
> +
> +	if (!eth->ppe[id] || !eth->ppe[id]->foe_table ||
> +	    eth->flow_table_initialized)
>  		return 0;
> -	return rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
> +	err = rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
> +	if (!err)
> +		eth->flow_table_initialized = true;
> +
> +	return err;
> +}
> +
> +void mtk_eth_offload_deinit(struct mtk_eth *eth)
> +{
> +	if (!eth->flow_table_initialized)
> +		return;
> +
> +	mutex_lock(&mtk_flow_offload_mutex);
> +	rhashtable_free_and_destroy(&eth->flow_table, mtk_flow_offload_free,
> +				    eth);
> +	mutex_unlock(&mtk_flow_offload_mutex);
> +
> +	eth->flow_table_initialized = false;
>  }

[Severity: High]
Can this destroy the flow table while the offload block callbacks are
still bound to live netdevs?

In mtk_remove() the new mtk_ppe_deinit() runs before mtk_cleanup():

	mtk_ppe_deinit(eth);
	mtk_cleanup(eth);

and the netdevs are only unregistered inside mtk_cleanup():

drivers/net/ethernet/mediatek/mtk_eth_soc.c:mtk_cleanup() {
	mtk_sgmii_destroy(eth);
	mtk_unreg_dev(eth);
	...
}

unregister_netdev() unbinds the ingress block and flushes the flowtable,
which replays FLOW_CLS_DESTROY back into the driver through
mtk_eth_setup_tc_block_cb() -> mtk_flow_offload_cmd() ->
mtk_flow_offload_destroy(), where the freed table is dereferenced:

	entry = rhashtable_lookup(&eth->flow_table, &f->cookie,
				  mtk_flow_ht_params);

rhashtable_free_and_destroy() kvfree()s the bucket tables and does not
clear ht->tbl, so eth->flow_table.tbl is left dangling.

mtk_flow_offload_cmd() only takes mtk_flow_offload_mutex and never
consults the new flag:

	mutex_lock(&mtk_flow_offload_mutex);
	switch (cls->command) {
	case FLOW_CLS_REPLACE:
		err = mtk_flow_offload_replace(eth, cls, ppe_index);

Since mtk_remove() holds no RTNL, a concurrent tc filter add ...
skip_sw or an nf_flow_offload work item can also reach
mtk_flow_offload_replace() -> rhashtable_insert_fast() on the freed
table.

Should the table be destroyed only after all netdevs are unregistered,
and should mtk_flow_offload_cmd() check eth->flow_table_initialized
under mtk_flow_offload_mutex?  Note the flag is also cleared outside
the mutex here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921145421.443018-1-lgs201920130244%40gmail.com
