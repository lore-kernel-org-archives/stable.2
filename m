Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795868278;
	b=LGv8/tpBMvj8lNfbdSkNxs64wx6eGZqMqWjD1g0M2vSUubA6P7BmNnppconyfYQrtgYI
	 I6I5AfLI4KJOxm59EMMtFmD/Nvnouqkgr5ISEQPdHuDj82kcymjBpQgdSdbDAPT8OgWPg
	 AGCClIuUtujdFv7aHBjwl3PY43g9NOMLPi2FUG8mIScFWNUSnjobPcO6LdThA94/a5dU7
	 v+HO2J9OX/rwjEjF3QpeqUxkdOtz1MAij3mU/0OQbbCPzPk1rfyfILbI7s48cK9AyTRhZ
	 z3+HG4KtKsycO7dlv+Su6hkmelQU7ESLCZGzNGviqnYouzQrnheL/MxtXGjuGhzZTVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795868278;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nm/PsFJBYui06j3UcjnQSuEvasqzOT2qCIsgjBSze0M=;
	b=lWfeERFkuKHD47HnjR6AeqZC6ajuLkQw9aTJaVTFWPRpQAjevarpoEpgJbvIqNLXlZwb
	 ZJnXhalWjmqEKjpGwJ5A6k/8mPCFG/pt+XDhgddIZaLRJfPoMfonDW/sHmg46mHAOk50o
	 yYGVbYCD/i6hoN5VZG5RCtreGeHobQjLm1hgRvXuoGWpm3/F2/ZS7F/cUHTbI18ke4tS9
	 sD0F2nrwtihvLA/0cm1ki6ltz6poQwMXEXzpAwXvmWxQIPec/arWHR0AycCd4NEP7AQsq
	 mbCPaAvwsin3FEMleXlTv2WCXYvMXrJFiLRpvnVHYPQAZQG3yB49bwzdPawq5PdBA0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCUm79wU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C350606A31C;
	Sat, 28 Nov 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCUm79wU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AC31F00899;
	Sat, 28 Nov 2026 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795868277;
	bh=nm/PsFJBYui06j3UcjnQSuEvasqzOT2qCIsgjBSze0M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mCUm79wUL38qosU+954EAGAZrPnGOzzk46SKCfudC+EjRJnjqRK1+5vQuCzXtFCFT
	 sx07Rry0mPzRjHcEqQpDLcMa90NRBdYfcth3bXsNANEsaMM0CfXG84JzNkL8HRgrGu
	 rAfrYErMvt3OdC15a7hx1nmLQg69xsktJw0IPEBnwzEQ5nGq18WKtIYVpMDr1VbXVo
	 oazL1VeoUWmT7yUYSzREmnKUOKo/qlTlGymutd6cmqxbsRZEAd6W4XaZ5Qj0lYc28P
	 PNDyWBLQu4IlGIQnlJR2hec1DW6gu1UOtHuUpUcjURCsvQsgmV/IeP5JsITxPw6RgG
	 yofcRXO6DsI0A==
Subject:
 Re: [PATCH net] net: ethernet: ti: cpsw_ale: serialize ALE table accesses
From: netdev-bot+sashiko@kernel.org
To: manuel.janocha@amperfied.com
Cc: s-vadapalli@ti.com, rogerq@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-omap@vger.kernel.org, netdev@vger.kernel.org, kuniyu@google.com,
 stable@vger.kernel.org
Date: Sat, 28 Nov 2026 12:17:56 +0000
Message-ID: <179586827652.3135.4662043469697713881@kernel.org>
In-Reply-To: <20261127-cpsw-ale-lock-v1-1-a72772d9a5ae@amperfied.com>
References: <20261127-cpsw-ale-lock-v1-1-a72772d9a5ae@amperfied.com>
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] netcp calls the ALE VLAN helpers with interrupts disabled, but
  those helpers now use spin_lock_bh()/spin_unlock_bh().
- [Low] The changelog says that ndo_set_rx_mode() 'runs under
  netif_addr_lock_bh() of one port only and never took RTNL', and…
- [Low] The new ale->lock serializes table sequences that use
  writel_relaxed()/readl_relaxed() in cpsw_ale_read() and…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  cpsw_ale_control_set() (drivers/net/ethernet/ti/cpsw_ale.c) still does…

--

net: ethernet: ti: cpsw_ale: serialize ALE table accesses

This commit adds a spinlock to struct cpsw_ale and takes it with
spin_lock_bh() in all exported functions that access the ALE table. The
table is reached through the shared index and data registers. The goal is
to stop table corruption seen on am65-cpsw when ndo_set_rx_mode() runs
without RTNL after IPv6 multicast joins stopped holding RTNL, and
cpsw_ale_add_vlan() is split into a locked wrapper and an unlocked
__cpsw_ale_add_vlan() helper.

> This did not matter as long as the callers were serialized by someone
> else. Both ports of a CPSW switch share one ALE, but the port VLAN
> and address operations run under RTNL, while ndo_set_rx_mode() runs
> under netif_addr_lock_bh() of one port only and never took RTNL. Since

[Severity: Low]
Is this accurate for all ALE users?

For the legacy cpsw and cpsw_new drivers, commit 0b8c878d1173 ("net: cpsw:
Execute ndo_set_rx_mode callback in a work queue") already addressed the
same Fixes: commit, and it was also tagged for stable. There,
cpsw_ndo_set_rx_mode() only schedules work, and the work takes RTNL before
it touches the ALE:

drivers/net/ethernet/ti/cpsw.c:cpsw_ndo_set_rx_mode_work() {
	rtnl_lock();
	if (!netif_running(ndev))
		goto unlock_rtnl;

	netif_addr_lock_bh(ndev);
	...
}

cpsw_new.c uses the same pattern. So in those two drivers, the rx_mode ALE
accesses are already serialized against VLAN and address operations by
RTNL.

The users that still reach the ALE table from rx_mode without RTNL seem to
be am65-cpsw and netcp. am65-cpsw does it through
am65_cpsw_nuss_ndo_slave_set_rx_mode(), which calls
cpsw_ale_set_allmulti(), cpsw_ale_flush_multicast() and
cpsw_ale_add_mcast() directly.

Could the changelog name the affected drivers and mention the earlier cpsw
fix? Could it also explain why a library-level lock was chosen over the
RTNL work approach used there?

> context (RTNL, workqueue, ethtool, system suspend). None of them runs
> in hard interrupt context, and a sleeping lock cannot be used because
> of the atomic callers. The register accesses under the lock are plain
> readl()/writel(); the regmap of the ALE is only used for the version,

[Severity: Low]
Is the "plain readl()/writel()" description correct? cpsw_ale_read() and
cpsw_ale_write() use the relaxed accessors:

drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_write() {
	...
	writel_relaxed(idx | ALE_TABLE_WRITE, ale->params.ale_regs +
		       ALE_TABLE_CONTROL);
	...
}

Documentation/memory-barriers.txt says readX_relaxed()/writeX_relaxed() do
not guarantee ordering with respect to locking.

The fix relies on one CPU's final ALE_TABLE_CONTROL write, or its index
write plus data reads, reaching the ALE before the next lock holder's
accesses. With relaxed accessors, that ordering comes from architecture
behaviour and not from the documented contract. On ARCH_HAS_MMIOWB
architectures, only the non-relaxed accessors call mmiowb_set_pending().

Outside COMPILE_TEST this driver only builds for ARM/ARM64, and the arm64
unlock probably orders these Device stores in practice. The hardware test
also passed. Should the changelog be corrected? Alternatively, should these
helpers use writel()/readl(), or at least use writel() for the final
ALE_TABLE_CONTROL write?

> The lock covers the table (index and data registers) only. The
> read-modify-write of the ALE control registers and the policer index
> registers are separate and left alone.

[Severity: High]
This isn't a bug introduced by this patch, but can the unlocked
read-modify-write in cpsw_ale_control_set() lose port state updates in a
similar way?

drivers/net/ethernet/ti/cpsw_ale.c:cpsw_ale_control_set() {
	...
	tmp = readl_relaxed(ale->params.ale_regs + offset);
	tmp = (tmp & ~(mask << shift)) | (value << shift);
	writel_relaxed(tmp, ale->params.ale_regs + offset);
	...
}

ALE_PORT_STATE and ALE_PORT_MACONLY_CAF are both in ALE_PORTCTL[port]. On
am65-cpsw, the rx_mode path runs without RTNL and rewrites that register on
every call:

am65_cpsw_nuss_ndo_slave_set_rx_mode()
  am65_cpsw_slave_set_promisc()
    cpsw_ale_control_set(common->ale, port->port_id,
                         ALE_PORT_MACONLY_CAF, 0);

Other paths write ALE_PORT_STATE in the same word:
am65_cpsw_nuss_mac_link_up() and am65_cpsw_nuss_mac_link_down() from the
phylink worker, and am65_cpsw_port_stp_state_set() under RTNL.

A possible interleaving:

CPU0 (rx_mode)                      CPU1 (mac_link_up)
readl(PORTCTL) -> STATE=DISABLE
                                    readl(PORTCTL)
                                    writel(STATE=FORWARD)
writel(STATE=DISABLE | CAF=0)

This would leave the port disabled in the ALE while the driver thinks it is
forwarding. All ingress would then be dropped until the next link or STP
transition. That is the same symptom this patch fixes.

ALE_CONTROL looks similar. cpsw_ale_timer() sets the AGEOUT bit from
softirq, while the promisc paths modify BYPASS and P0_UNI_FLOOD in the same
register.

An unprivileged IPv6 multicast join can now trigger rx_mode without RTNL.
Would it make sense to serialize cpsw_ale_control_set() as well?

> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index 9304405c9581a..dc550142ed822 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c

[ ... ]

> @@ -681,6 +699,19 @@ int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port_mask, int untag,
>  	cpsw_ale_write(ale, idx, ale_entry);
>  	return 0;
>  }
> +
> +int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port_mask, int untag,
> +		      int reg_mcast, int unreg_mcast)
> +{
> +	int ret;
> +
> +	spin_lock_bh(&ale->lock);
> +	ret = __cpsw_ale_add_vlan(ale, vid, port_mask, untag, reg_mcast,
> +				  unreg_mcast);
> +	spin_unlock_bh(&ale->lock);

[Severity: High]
Can this spin_unlock_bh() run with hard interrupts disabled? netcp calls
the ALE VLAN helpers from inside an irqsave section:

drivers/net/ethernet/ti/netcp_core.c:netcp_rx_kill_vid() {
	...
	spin_lock_irqsave(&netcp->lock, flags);
	for_each_module(netcp, intf_modpriv) {
		module = intf_modpriv->netcp_module;
		if (module->del_vid) {
			err = module->del_vid(intf_modpriv->module_priv, vid);
	...
}

netcp_rx_add_vid() does the same for module->add_vid(). For both the gbe
and xgbe modules, the call chains are:

gbe_add_vid() -> cpsw_ale_add_vlan()
gbe_del_vid() -> cpsw_ale_del_vlan()

Both ALE functions now take ale->lock with spin_lock_bh(). That includes
the -ENOENT early return in cpsw_ale_del_vlan().

On non-RT kernels, __local_bh_enable_ip() then triggers
lockdep_assert_irqs_enabled(). With CONFIG_TRACE_IRQFLAGS it also wraps
do_softirq() in local_irq_disable() ... local_irq_enable(). So hard IRQs
get re-enabled and pending softirqs run while netcp->lock is still held.
That allows re-entry into netcp code that takes the same lock, such as
netcp_set_rx_mode().

This looks easy to reach. netcp sets NETIF_F_HW_VLAN_CTAG_FILTER, so with
8021q loaded, every NETDEV_DOWN goes through:

vlan_vid0_del()
  vlan_vid_del(dev, htons(ETH_P_8021Q), 0)
    netcp_rx_kill_vid()
      gbe_del_vid()
        cpsw_ale_del_vlan()

netcp_rx_kill_vid() does not filter out vid 0. Creating any VLAN on a
netcp interface likewise reaches cpsw_ale_add_vlan() under the irqsave
lock.

The changelog says the other callers run in process context and that netcp
was only compile-tested. It doesn't seem to cover this IRQs-disabled
caller.

Would spin_lock_irqsave() work for ale->lock here? The other option would
be for netcp to stop calling into the ALE while holding netcp->lock.

> +
> +	return ret;
> +}
>  EXPORT_SYMBOL_GPL(cpsw_ale_add_vlan);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127-cpsw-ale-lock-v1-1-a72772d9a5ae%40amperfied.com
