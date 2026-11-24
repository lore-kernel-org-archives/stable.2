Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541994;
	b=QomspLbbJhKL1yDdIId9Bq9M9hi5xDfm/Ved7JBefQtMyMEfzAHlM9ig7XHjAs7DiJbd
	 i4VmSz8kxgKYY7Lko+t5uOTMy8YRl9Rv3K+APVq2TJw0VdqeAYPvCUMwOfVOC1+uJFf0g
	 N5MepAr/yeQIso/DR0RIQH6HKFfmYHrydrzy+NYGG8pXggorCE8QsTqPqGcgIBnczwiJN
	 vSYKCps2I0QCtHRuIMq81hzoeSrE3a6rv4Thw/UjriGU2OeSzRgwJWX38KrSPTtIEOIhY
	 T9abDo8C2qwxrVuHeuAjBv5hE76LH7mot793CUCDD+1n6e6q8ztBQAmDzFX0Qq1di5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541994;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RN3pxnhCJYpGp3xiHRqRfmEucdv+kIWIunOXN3qEkkk=;
	b=yosrjpHDXUFFAQqLDcavPDq+do+EN9tE3VmS/0x0+QjjnIjdL2ONkbDi+G/FJeqr38Kz
	 MMJP/06rV/U9VghnBbHb5Xrtvyu9ljrL6I7RJOm3pgRE7JmE7m5x98lf69Dfd8C8I5RHT
	 mvBe0Qf+bK5XnSkV0RRdndAI1qdhgGX2NPc/1O1H8q9n4ez3B1ipAYFJ1ilaKvRZoYSnH
	 jvK5qFv/zdZ0ur5KWpooqBZg1f0e0B1yk9L2Uf2BpWdyteefMoVKmygCuwXCS0bPqAmLv
	 HdizKr/x4x+X/vMcSIzPtygLX5Oadh/03IDUkFC+GTGL8jrXzj/mJNJdAndfg/fUr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLNRfofh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C2606A31E;
	Tue, 24 Nov 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLNRfofh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5351F000C0;
	Tue, 24 Nov 2026 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541994;
	bh=RN3pxnhCJYpGp3xiHRqRfmEucdv+kIWIunOXN3qEkkk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MLNRfofhpzhbJogdT7qZlkES1pV+8p0B6u67WTjvMY0hNkkD7jsesA7K1ulp84url
	 m1PxRVKVDnJA7MtrWbBrejqs86EYnGFDBtQR/opyX+JjFWVnzxfc9TcDuGoJBF4ooi
	 VrtNz5qgpR38jbD3BzZrlyUV+ZjgwRUXVxIJHQ2ini0Crq7l2oK281FcQFbPphc1r2
	 GeeL/b+uLvzWhuLSyhsZDj0LIxw9wkGUyYkqXEPnU6C7/nF3dRU8sI1KLEkYpsEEw1
	 W77Ycds/xLhWzS+DA7f0fH3ikuNg074UDMOoWv7sG5FNOLJoPbRUfBaBWzAq0h0vKB
	 e4JwUHbtZvROA==
Subject: Re: [PATCH net] net: hix5hd2_gmac: do not release the RX ring on
 interface close
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, shenjian15@huawei.com,
 shaojijie@huawei.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zhangfei.gao@linaro.org
Date: Tue, 24 Nov 2026 17:39:52 +0000
Message-ID: <179554199298.3135.9008055481061380435@kernel.org>
In-Reply-To: <20261120173702.1551838-1-mmyangfl@gmail.com>
References: <20261120173702.1551838-1-mmyangfl@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not remove the use-after-free it describes.
- [Medium] Parts of the commit message do not match the code.
- [Medium] The whole fix rests on the claim that the block 'has no reset
  feature' and that prefetched RX descriptors 'cannot be expelled'.

Pre-existing issues:
- [High] This patch keeps the RX buffers across close because the MAC
  keeps its queue state and descriptors it has already fetched.

--

net: hix5hd2_gmac: do not release the RX ring on interface close

This patch splits hix5hd2_free_dma_desc_rings() into RX and TX helpers.
hix5hd2_net_close() now frees only the TX buffers. The RX buffers are
released in hix5hd2_destroy_hw_desc_queue() when the device goes away, so
the MAC keeps ownership of the RX addresses it may have prefetched.

> Do not release the receive buffers, their descriptors and the queue
> pointers on the close, until the device goes away, so the block keeps
> ownership of every address it prefetches.

[Severity: Medium]
Is this description accurate?

Before this patch, hix5hd2_net_close() called
hix5hd2_free_dma_desc_rings(), which only freed rx_skb[] and tx_skb[].
The coherent descriptor rings were already freed only in
hix5hd2_destroy_hw_desc_queue(). Nothing in the driver ever resets the
RD/WR pointer registers.

The only change in behaviour seems to be that the RX skbs and their DMA
mappings are no longer freed on close.

> The sibling hisi_femac has the same defect and resets the port before
> freeing its ring, as in commit d54b21d82430 ("net: hisilicon:
> hisi_femac: Stop the receiver before releasing the RX ring"); this one,
> however, has no reset feature and has to keep them alive across a close.

Does this block really have no reset feature?

hix5hd2_dev_probe() requests an optional "mac_core" reset and pulses it
through hix5hd2_mac_core_reset(). hi3798cv200.dtsi wires it up:

    reset-names = "mac_core", "mac_ifc", "phy";

So the GEMAC_V2 parts that this patch also changes do have one.

Even on Hi3716cv200, clk_ether_prepare() in
drivers/clk/hisilicon/clk-hix5hd2.c pulses the MAC core/IF reset bits on
every prepare:

    val |= clk->ctrl_clk_mask | clk->ctrl_rst_mask;
    writel_relaxed(val, clk->ctrl_reg);
    val &= ~(clk->ctrl_rst_mask);
    writel_relaxed(val, clk->ctrl_reg);

The commit message also leaves out two changes users can see:

- rx_skb[] and the hardware pointers now survive a close. At the next
  open, hix5hd2_rx() will pass RX BQ entries left over from the previous
  session to napi_gro_receive().

- The full RX ring of MAC_MAX_FRAME_SIZE skbs stays allocated and
  DMA-mapped while the interface is down.

Could the changelog be updated to describe these?

> diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> index 12a5657653f85..8c67a0670cbb2 100644
> --- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c

[ ... ]

> @@ -873,7 +880,10 @@ static int hix5hd2_net_close(struct net_device *dev)
>  	hix5hd2_irq_disable(priv);
>  	napi_disable(&priv->napi);
>  	netif_stop_queue(dev);
> -	hix5hd2_free_dma_desc_rings(priv);
> +	/* free rx buffers when device goes away, not when interface closed;
> +	 * the hardware prefetches rx descriptors and cannot be expelled
> +	 */

[Severity: Medium]
Is "cannot be expelled" known to be true for this block? The driver
already defines stop and flush controls for the queue DMA, and nothing
uses them:

    #define STOP_CMD            0x05e8
    #define BITS_TX_STOP        BIT(1)
    #define BITS_RX_STOP        BIT(0)
    #define FLUSH_CMD           0x05eC
    #define BITS_TX_FLUSH_CMD   BIT(5)
    #define BITS_RX_FLUSH_CMD   BIT(4)

The TX/RX FLUSH_FLAG_UP/DOWN status bits are defined there too.

hix5hd2_mac_core_reset() is only called from probe. The reset pulse in
clk_ether_prepare() has no delay between assert and deassert.
hix5hd2_port_disable() is just two posted writes, with no wait for the
DMA engine to go idle.

Suppose STOP_CMD/FLUSH_CMD, or a properly timed core reset, does what
the names suggest. Would the more complete fix then be to do this in
hix5hd2_net_close():

- stop and flush RX/TX
- poll the flush flag
- resync the RD/WR pointers

That would also cover the TX and remove/re-probe paths raised below.

There is also a possible regression in the other direction. On some
parts, the reset pulse in clk_ether_prepare() or the mac_core reset may
clear the queue RD/WR pointers. The RX FQ write pointer would then point
back at a slot whose rx_skb[] this patch kept, and hix5hd2_rx_refill()
stops right away:

    for (i = 0, pos = start; i < num; i++) {
        if (priv->rx_skb[pos]) {
            break;

Could the FQ then never be refilled, so RX starves after a close/open?

These register semantics are not documented in-tree, so it may be worth
checking them against the SoC manual or the vendor driver.

> +	hix5hd2_free_tx_buffers(priv);

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the TX side of
hix5hd2_net_close() have the same problem as the RX side fixed here?

hix5hd2_free_tx_buffers() unmaps and frees every non-NULL tx_skb[]
right after hix5hd2_port_disable(). There is no TX stop, flush or idle
poll first. This includes skbs whose descriptors are still posted in
TX_BQ, and skbs already completed in TX_RQ but not yet reclaimed.

hix5hd2_hw_init() only writes DEPTH and START_ADDR. So at the next open
the TX_BQ/TX_RQ RD/WR pointers are unchanged, and hix5hd2_port_enable()
writes 0xf to DESC_WR_RD_ENA.

If the MAC resumes the still-posted TX_BQ descriptors, can it DMA-read
the freed buffers and send whatever memory now lives there?

Any leftover TX_RQ entry also points at a slot where tx_skb[pos] is now
NULL. hix5hd2_xmit_reclaim() then stops without advancing
TX_RQ_RD_ADDR:

    skb = priv->tx_skb[pos];
    if (unlikely(!skb)) {
        netdev_err(dev, "inconsistent tx_skb\n");
        break;
    }
    ...
    if (pos != start)
        writel_relaxed(dma_byte(pos), priv->base + TX_RQ_RD_ADDR);

With pos == start, no completion is ever reclaimed again.
hix5hd2_net_xmit() eventually hits a non-NULL slot and returns
NETDEV_TX_BUSY, and the queue is never woken.

The watchdog path hix5hd2_net_timeout()->hix5hd2_tx_timeout_task()
calls dev_close()/dev_open(). It runs exactly when TX_BQ descriptors are
outstanding and resets nothing, so it does not look able to recover
from this either.

Would it make sense to handle TX in the same fix?

>  
>  	if (dev->phydev) {
>  		phy_stop(dev->phydev);

[ ... ]

> @@ -985,6 +995,8 @@ static void hix5hd2_destroy_hw_desc_queue(struct hix5hd2_priv *priv)
>  {
>  	int i;
>  
> +	hix5hd2_free_rx_buffers(priv);
> +

[Severity: High]
Doesn't this just move the use-after-free from ndo_stop to the remove
path?

hix5hd2_dev_remove()
    unregister_netdev()
        hix5hd2_net_close()          <- port disable + clock gate only
    hix5hd2_destroy_hw_desc_queue()
        hix5hd2_free_rx_buffers()    <- unmap + free every rx_skb[]
        dma_free_coherent()          <- all four rings

The commit message itself says the close sequence leaves the MAC's
prefetched FQ descriptors and queue pointers in place. Here, the buffers
they point to are freed.

On a rebind (sysfs unbind/bind or rmmod/insmod), the only reset in
hix5hd2_dev_probe() is hix5hd2_mac_core_reset(). That returns early
when the optional "mac_core" reset is absent:

    if (!priv->mac_core_rst)
        return;

hisi-x5hd2.dtsi (Hi3716cv200) has no resets property, and
hix5hd2_hw_init() rewrites only DEPTH and START_ADDR.

Could the first open after a rebind enable the port while the MAC still
holds the RX addresses of skbs freed at remove? Received frames would
then be DMA-written into memory that may have been reused.

>  	for (i = 0; i < QUEUE_NUMS; i++) {
>  		if (priv->pool[i].desc) {
>  			dma_free_coherent(priv->dev, priv->pool[i].size,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120173702.1551838-1-mmyangfl%40gmail.com
