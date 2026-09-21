Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05B49CF43;
	Mon, 21 Sep 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996880; cv=none; b=RWsIlHlM84fBkJm/IX/n666b8GdQQY3C/yfSn5rm31WIz/Mo4bsM2QLoqeiCY1d6t5CM9xFSnY+TY4x3e1eNishsmcs5809e4P3y8QkEqJIz1ewbCmNJhRe8X+MAH0cD+cswX3JI+FESob9bW8GgNsU8veuJg8W4Z/yB6vRNWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996880; c=relaxed/simple;
	bh=9KCV0Isfm5NCv42LoTot0OpHp4tbSNJhFOGM+fnhpV8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPL6FndCm7RVh8bFiiJWHRddUvb3JTihxHKd8kw4r+8sadPr3zokbh50WvpPEnQvQNpEYohGf2sFIpDb4u5BXcMrxMgLX0wDCz+j4NHjJO1VmH/CIqYGLLmickEy572jBAckqdniY5D0L0IcSUPZyW+XqjQAbWpC6MupspVxiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsiLQZ1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsiLQZ1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FCA1F000FF;
	Mon, 21 Sep 2026 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789996878;
	bh=TVH4gdfHIjrlW/sC4pd4Pp6xDgotmIlq12Mx8bnqRl8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dsiLQZ1ZAPndrzcseRm2HQOfoi850/scAxAcGNKtOx7+aXJ7FJJ895UehV6+LdHAp
	 XEWXuwOBMJvmU5J6HjRP3oYgDTYYJJrCoSNWFbMYRVOzvnAG4Qhkn3YBgaYGet1kjs
	 cBMWxZ0dfF4wKl7yhKFD4aQhTca4Z+ntgy9tEj3a9uU+Mm7UWphRb9C5w0ur3GLavw
	 TCVxE8GbqTmBX19p4mhYgZuRAiO4+dz31+nxboYIdI2c4HZgw97J+D+AGo2tD6kiqS
	 B4zQ5Lpekv07ii5BF2mxQf4Vv42/70+4fvG+pag+kFvtdJVpsJHvSeIEo4E21xTzLC
	 lCO9f0pMv8kKQ==
Subject: Re: [PATCH] net: ethernet: sunplus: Fix ethernet-ports node leak in
 spl2sw_probe()
From: netdev-bot+sashiko@kernel.org
To: vulab@iscas.ac.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, wellslutw@gmail.com, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 13:21:17 +0000
Message-ID: <178999687739.2160803.3482833492987734211@kernel.org>
In-Reply-To: <20260917114118.2149439-1-vulab@iscas.ac.cn>
References: <20260917114118.2149439-1-vulab@iscas.ac.cn>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete fix: the 'port@i' OF node references obtained in
  spl2sw_probe() are still leaked.
- [Medium] The patch mixes goto-based unwinding with scope-based cleanup
  in the same function, which include/linux/cleanup.h explicitly forbids.

Pre-existing issues:
- [Medium] phy-handle OF node references are leaked on spl2sw_probe()
  failure paths.
- [Medium] DMA descriptor memory and preallocated RX skbs are leaked on
  all late spl2sw_probe() failure paths.

--

net: ethernet: sunplus: Fix ethernet-ports node leak in spl2sw_probe()

This changes the eth_ports_np local in spl2sw_probe() to be declared with
__free(device_node) so the reference taken by of_get_child_by_name() on the
"ethernet-ports" child node is dropped when the function returns. No other
code in the function is changed.

> diff --git a/drivers/net/ethernet/sunplus/spl2sw_driver.c b/drivers/net/ethernet/sunplus/spl2sw_driver.c
> index 5e0e4c9ecbb07..fdc9c31967381 100644
> --- a/drivers/net/ethernet/sunplus/spl2sw_driver.c
> +++ b/drivers/net/ethernet/sunplus/spl2sw_driver.c
> @@ -319,7 +319,7 @@ static struct device_node *spl2sw_get_eth_child_node(struct device_node *ether_n
>  
>  static int spl2sw_probe(struct platform_device *pdev)
>  {
> -	struct device_node *eth_ports_np;
> +	struct device_node *eth_ports_np __free(device_node) = NULL;
>  	struct device_node *port_np;

[Severity: Medium]
Does this leave the larger sibling leak in the same function unfixed?  The
port_np pointer right below also holds a reference.  spl2sw_get_eth_child_node()
returns the matching child straight out of the iterator:

drivers/net/ethernet/sunplus/spl2sw_driver.c:spl2sw_get_eth_child_node() {
	for_each_child_of_node(ether_np, port_np) {
		...
		if (port_id == id)
			return port_np;
	}

for_each_child_of_node() only drops the reference when the loop advances, so
the early return hands a held reference to the caller.  In spl2sw_probe() that
reference lands in a plain local:

		port_np = spl2sw_get_eth_child_node(eth_ports_np, i);
		if (!port_np)
			continue;

and I can't find any of_node_put(port_np) in spl2sw_driver.c.  Does this leak
one port@i node reference per iteration on the two "continue" paths
(of_get_phy_mode() failure and missing phy-handle), on every goto to
out_unregister_dev / out_free_mdio, and on the successful return as well?

Would declaring port_np with __free(device_node) too, or switching the helper
to for_each_child_of_node_scoped() and returning the node with an explicit
of_node_get(), cover that case?

[Severity: Medium]
Is mixing __free() with the existing goto unwinding here in line with what
cleanup.h asks for?  spl2sw_probe() keeps three unwind labels and eight goto
statements:

out_unregister_dev:
	for (i = 0; i < MAX_NETDEV_NUM; i++)
		if (comm->ndev[i])
			unregister_netdev(comm->ndev[i]);

out_free_mdio:
	spl2sw_mdio_remove(comm);

out_clk_disable:
	clk_disable_unprepare(comm->clk);
	return ret;

include/linux/cleanup.h says:

 * expectation is that usage of "goto" and cleanup helpers is never
 * mixed in the same function.

There is no functional failure today, since of_node_put(NULL) is a no-op for
the gotos taken before the assignment, but the implicit release now runs after
all of the label code and is not visible at any goto site.

The same file also recommends defining and assigning in one statement.  Here
the declaration is "= NULL" at the top of the function while the acquisition
happens much later:

	eth_ports_np = of_get_child_by_name(pdev->dev.of_node, "ethernet-ports");

Would an explicit of_node_put() on the three exits, or converting all of the
resources in this function to scope-based cleanup, fit better than converting
just this one?

[Severity: Medium]
This isn't a bug introduced by this patch, but the phy-handle node references
look like they leak on the probe error paths too, and they are in the same
family of probe-time OF leaks the commit message describes.

of_parse_phandle() takes a reference:

		phy_np = of_parse_phandle(port_np, "phy-handle", 0);

If spl2sw_nvmem_get_mac_address() returns -EPROBE_DEFER, or spl2sw_init_netdev()
fails, control leaves before mac->phy_node = phy_np runs:

		ret = spl2sw_nvmem_get_mac_address(&pdev->dev, port_np, mac_addr);
		if (ret == -EPROBE_DEFER) {
			goto out_unregister_dev;

so the only handle on that reference is lost.  For failures after the transfer
(spl2sw_mac_addr_add(), a later loop iteration, spl2sw_phy_connect()), the
out_unregister_dev label only calls unregister_netdev().  The single
of_node_put(mac->phy_node) in the driver lives in spl2sw_phy_remove():

drivers/net/ethernet/sunplus/spl2sw_phy.c:spl2sw_phy_remove() {
			phy_disconnect(ndev->phydev);
			of_node_put(mac->phy_node);

and that is only reached from spl2sw_remove(), which does not run when probe
fails.  Does the -EPROBE_DEFER case then leak another reference on every
deferred-probe retry?

[Severity: Medium]
This is a pre-existing issue, but the descriptor memory looks like it leaks on
exactly the out_free_mdio and out_unregister_dev paths the commit message
mentions.

spl2sw_descs_init() allocates non-devm memory:

drivers/net/ethernet/sunplus/spl2sw_desc.c:spl2sw_descs_alloc() {
	comm->desc_base = dma_alloc_coherent(&comm->pdev->dev, desc_size, &comm->desc_dma,
					     GFP_KERNEL);

plus the RX skbs and their DMA mappings in spl2sw_rx_descs_init().  These are
released only by spl2sw_descs_free():

drivers/net/ethernet/sunplus/spl2sw_desc.c:spl2sw_descs_free() {
		dma_free_coherent(&comm->pdev->dev, comm->desc_size, comm->desc_base,
				  comm->desc_dma);

In spl2sw_probe(), spl2sw_descs_free() is called only in the "if (ret)" block
immediately after spl2sw_descs_init().  None of out_unregister_dev,
out_free_mdio or out_clk_disable calls it, and spl2sw_remove() does not run
when probe returns an error.

Does that mean a device tree without an "ethernet-ports" child (goto
out_free_mdio) or an -EPROBE_DEFER from spl2sw_nvmem_get_mac_address() (goto
out_unregister_dev) leaks the coherent descriptor buffer, the 32 RX skbs and
their streaming DMA mappings, with the -EPROBE_DEFER case repeating on each
retry?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917114118.2149439-1-vulab%40iscas.ac.cn
