Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8403A3B1016;
	Thu, 17 Sep 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633150; cv=none; b=aKGw4H34gTllna7+CWgWF5q5O1UK2omfaT+HgCw6Z+BBPi2MbRUeziig6J62Id4S5AOeJpCv0JSKeC75gQnEihcFUbo2cC5Egp8jxDaxIX2OHtvCoXrJCvv1sPg2qCYp4XFSUkz5MwOVyC4wP+u1XK/MS8/DeI705xmgQNXCRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633150; c=relaxed/simple;
	bh=OOomfKftFBRnz+rSNUtws033tSlDbkznMVxKX8gkal0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISdQ8CIOmZcUsOQSShrTr1oTS6hLS5Lhf5IIkAfUaZxmx2+860gZiS+ICFFKiPOa4TkSdxvBA0r02FDSnnkXPRr9gKr3eHn6DFO0jZSQBVFIwMYAqcjKYOxvAtUUg1ko2u9gBAaZLnkVB8NVTGdgbvtlOqHwGhm8mKMSb9p/vSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJn7AYvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJn7AYvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7311F000FF;
	Thu, 17 Sep 2026 08:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633147;
	bh=TLhhUntP2UZd7usambWoY0dwKj1ntPIBjjB55O/+Cfo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CJn7AYvy9IBI2JLMN/hlKubM4BWIpnkD5dgJ/udfIJGEmK2hMH2R7FWZkRHzLhPv4
	 Ltgp6qlU5FKFa8R0v4Bv2rWrZOkjOSgJ/RlTpXSjQ68jVO/RyfWXLCkhUiURZJILnY
	 A5jT0iNk/ZNUh8kDHI2tCuDB7Kn5pvHrRpgpQel9FDeWhnM6XvH42lHJNY8+2ZT3/A
	 DZPdimsp2A/NeQKdoxBTqcWgMazI6VDHvM2VJYbGj8a3sMrvDUxzTWn8cXzY+DOUeF
	 aAOJExkVKAJirw04SnxV2bCBkiiQoI8Eg0mlOhaGdp31o70i69dyfK4ncApxcRQ2DA
	 v+yf3HzFoJGCw==
Subject: Re: [PATCH] net: mediatek: fix PPE resource leak on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: nbd@nbd.name, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
Date: Thu, 17 Sep 2026 08:19:05 +0000
Message-ID: <178963314597.22033.1751942424673544030@kernel.org>
In-Reply-To: <20260916051618.2904439-1-lgs201920130244@gmail.com>
References: <20260916051618.2904439-1-lgs201920130244@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

- [High] mtk_remove() now calls mtk_ppe_deinit(eth)
  (drivers/net/ethernet/mediatek/mtk_eth_soc.c:5409) *before*…
- [High] The patch closes only half of the leak it claims to fix.

Pre-existing issues:
- [High] mtk_ppe_init() registers per-PPE debugfs entries via
  mtk_ppe_debugfs_init() (mtk_ppe.c:934), which creates a top-level…

--

net: mediatek: fix PPE resource leak on remove

This adds a mtk_ppe_deinit(eth) call to mtk_remove() so that the l2_flows
rhashtables allocated by mtk_ppe_init() are released on device removal, the
way the probe error unwind already does.  A few questions about the placement
and the completeness of the teardown below.

> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index fd7a49ae88d01..903dac36ccf10 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -5406,6 +5406,7 @@ static void mtk_remove(struct platform_device *pdev)
>  
>  	netif_napi_del(&eth->tx_napi);
>  	netif_napi_del(&eth->rx_napi);
> +	mtk_ppe_deinit(eth);

[Severity: High]
Can this destroy ppe[i]->l2_flows while the netdevs are still registered and
their flow offload callbacks are still live?

mtk_ppe_deinit() only calls rhashtable_destroy(), which frees the bucket
table and leaves ht->tbl dangling, while eth->ppe[i] stays non-NULL:

drivers/net/ethernet/mediatek/mtk_ppe.c:mtk_ppe_deinit() {
	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++) {
		if (!eth->ppe[i])
			return;
		rhashtable_destroy(&eth->ppe[i]->l2_flows);
	}
}

The unregister_netdev() calls only happen afterwards, in mtk_cleanup() ->
mtk_unreg_dev(), and unregistering a device with offloaded flower rules
replays the removals back into the driver:

unregister_netdev() -> dev_shutdown() -> tcf_block_offload_unbind() ->
tcf_block_unbind() -> tcf_block_playback_offloads(..., add=false) ->
fl_reoffload()

net/sched/cls_flower.c:fl_reoffload() {
		cls_flower.command = add ?
			FLOW_CLS_REPLACE : FLOW_CLS_DESTROY;

For an MTK_FLOW_TYPE_L2 (bridge) entry that lands back in the already
destroyed table:

mtk_eth_setup_tc_block_cb() -> mtk_flow_offload_cmd() ->
mtk_flow_offload_destroy() -> mtk_foe_entry_clear() ->

drivers/net/ethernet/mediatek/mtk_ppe.c:__mtk_foe_entry_clear() {
	if (entry->type == MTK_FLOW_TYPE_L2) {
		rhashtable_remove_fast(&ppe->l2_flows, &entry->l2_node,
				       mtk_flow_l2_ht_params);

Is there anything preventing a concurrent FLOW_CLS_REPLACE from reaching
mtk_foe_entry_commit_l2() -> rhashtable_lookup_get_insert_fast() on the same
freed table?  mtk_remove() holds neither rtnl nor mtk_flow_offload_mutex.

The same applies to eth->reset.monitor_work and eth->pending_work, which are
only cancelled later, inside mtk_cleanup():

drivers/net/ethernet/mediatek/mtk_eth_soc.c:mtk_cleanup() {
	mtk_sgmii_destroy(eth);
	mtk_unreg_dev(eth);
	mtk_free_dev(eth);
	cancel_work_sync(&eth->pending_work);
	cancel_delayed_work_sync(&eth->reset.monitor_work);

If those re-run mtk_open()/napi_enable(), the receive path reaches
mtk_ppe_check_skb() -> rhashtable_lookup_fast(&ppe->l2_flows) on the freed
table.

The probe unwind orders this the other way around:

err_unreg_netdev:
	mtk_unreg_dev(eth);
err_deinit_ppe:
	mtk_ppe_deinit(eth);

Would placing mtk_ppe_deinit(eth) after mtk_cleanup(eth) match that order?

[Severity: High]
Does this leave eth->flow_table leaked?

mtk_probe() initializes two rhashtables per PPE index: l2_flows inside
mtk_ppe_init(), and eth->flow_table inside mtk_eth_offload_init():

drivers/net/ethernet/mediatek/mtk_ppe_offload.c:mtk_eth_offload_init() {
	if (!eth->ppe[id] || !eth->ppe[id]->foe_table)
		return 0;
	return rhashtable_init(&eth->flow_table, &mtk_flow_ht_params);
}

The only two rhashtable_destroy() call sites in
drivers/net/ethernet/mediatek/ are both on ppe->l2_flows, in mtk_ppe_init()'s
error path and in mtk_ppe_deinit(), so eth->flow_table's bucket table is
never freed on unbind either before or after this patch.  Should
mtk_ppe_deinit() (or the remove path) also destroy eth->flow_table?

Two related observations on eth->flow_table:

Only rhashtable_free_and_destroy() does cancel_work_sync(&ht->run_work), so a
pending deferred rehash work item stays pointing into struct mtk_eth, which
is devm_kzalloc'ed in mtk_probe() and freed on detach.

eth->flow_table is a single per-device field, but mtk_eth_offload_init() is
called once per PPE index in the mtk_probe() loop, and ppe_num is 2 on
mt7986/mt7981 and 3 on mt7988.  Does re-running rhashtable_init() on the same
object overwrite and leak the previously allocated bucket table already at
probe time?

[Severity: High]
This isn't a bug introduced by this patch, but since mtk_ppe_deinit() is now
the PPE teardown for the remove path: it has no counterpart for the debugfs
entries created during init.

mtk_ppe_init() ends with mtk_ppe_debugfs_init(ppe, index), and that creates a
top level directory plus two files whose private data is the devm_kzalloc'ed
struct mtk_ppe:

drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c:mtk_ppe_debugfs_init() {
	root = debugfs_create_dir(ppe->dirname, NULL);
	debugfs_create_file("entries", S_IRUGO, root, ppe, &mtk_ppe_debugfs_foe_all_fops);
	debugfs_create_file("bind", S_IRUGO, root, ppe, &mtk_ppe_debugfs_foe_bind_fops);

The root dentry is not stored anywhere and there is no debugfs_remove() for
the PPE in the driver (the only debugfs_remove() in
drivers/net/ethernet/mediatek/ is in mtk_wed.c, which does keep
hw->debugfs_dir).  With CONFIG_DEBUG_FS=y, does reading
/sys/kernel/debug/ppe0/entries after unbind dereference the freed struct
mtk_ppe and its freed dmam-allocated foe_table, and does a re-probe collide
with the stale ppe0 directory?  Would adding the debugfs teardown to
mtk_ppe_deinit() be appropriate here?

>  	mtk_cleanup(eth);
>  	free_netdev(eth->dummy_dev);
>  	mtk_mdio_cleanup(eth);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916051618.2904439-1-lgs201920130244%40gmail.com
