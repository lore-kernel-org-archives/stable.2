Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716849159B;
	Mon, 12 Oct 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810791; cv=none; b=QQ6eWjhSpPRew87L1pYEPv+orMI2gFdNBEwC8elPDWO7b/HJ9I0/IU86C8vnQq51EIr21jW+JVWreLr0bX1uq5mk0ryL7BWTXCGRvzyHRcInEnfrlnyKAAjJPFHsPOJXONLbO93DSmvMa/sJ9S2jg2qECW4PTToapkMeDcgQS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810791; c=relaxed/simple;
	bh=/I+jlN+d/FAE42fcXTvmir+ecIF2fyv2Zy+QazhUheM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EXGkj7VKmanoPPTc7dC6qg2vgMr+aSBSV2Tmg6h1ZOj6paWAiSZyknoD5Cql8rMxQtBhz/txWZXPJnwZBB4kZUyNOlWC0eYmM9Wn7F/tl8awozcf4XAc0QbCvy838j7+xsfDtmWRXxoICwzZl5RBCc2q2+BhO36hsCQxSYJxW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB8mi6Np; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB8mi6Np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FD1F0089B;
	Mon, 12 Oct 2026 13:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810790;
	bh=myeibkSBWUeD/TYhfikZwsBFUkc4eRrceW+dihMhzhs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fB8mi6NpzeQZSPp1QB9G0x+fZt7POh8384PpwLX6EQmA1e/x8xzXYs6zCNU19qikf
	 Oup9+VmBUv0OqwgfTJ3n2xjXSk6+5HGEIckUU1n1JtVTn2R3XmwZ9DmoyVYj2c/9R1
	 rjDoM9bS11MqxMh9SBLVEUolWNqJlibopibGtMUmbVxYAQSeh8/3sPJXoUxfKD2Lhi
	 dtWR/aTFtMtSslozfafMNIGJBLBxi5H1GXz4vtjfqv2zS/DbKWcIPG/k1Og8Akd7Ms
	 FwgAISgx8XmI0hukJIH6GcbzO0r2ejkZaKz7oQUj2raAVmcKlPXSJ2SgnmOOVgTZNS
	 ufxiCMHTecGVw==
Subject: Re: [PATCH net] net: jme: keep RX MAC clock enabled for WoL
From: netdev-bot+sashiko@kernel.org
To: franck.baur.67@gmail.com
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 12 Oct 2026 13:13:09 +0000
Message-ID: <179181078924.434549.16666867636447785126@kernel.org>
In-Reply-To: <20261011-jme-wol-submit-v1-1-9cc033e259e4@gmail.com>
References: <20261011-jme-wol-submit-v1-1-9cc033e259e4@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch turns the RX MAC clock on before arming WoL, but
  resume never turns it back off.
- [Medium] The patch's guarantee ('Keep the RX MAC clock running while
  WoL is armed') can be undone by jme_link_change_work() running at the…

--

net: jme: keep RX MAC clock enabled for WoL

This patch turns the RX MAC clock back on in jme_powersave_phy() just
before jme_clear_pm_enable_wol() arms WoL. Earlier in the suspend path the
MAC reset leaves GPREG1_RXCLKOFF set. On a JMC250 rev 03, Magic Packet
detection does not work while the RX MAC clock is gated.

> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index 25ec5f757c68..27ac7405f76f 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -1892,6 +1892,7 @@ jme_powersave_phy(struct jme_adapter *jme)
>  		jme_set_100m_half(jme);
>  		if (jme->reg_pmcs & (PMCS_LFEN | PMCS_LREN))
>  			jme_wait_link(jme);
> +		jme_mac_rxclk_on(jme);

[Severity: Medium]
Does anything turn the RX MAC clock back off on resume?

jme_mac_rxclk_on() changes the cached copy as well as the register:

    jme->reg_gpreg1 &= ~GPREG1_RXCLKOFF;
    jwrite32f(jme, JME_GPREG1, jme->reg_gpreg1);

jme_resume() calls jme_clear_pm_disable_wol(), jme_phy_on(),
jme_set_link_ksettings() or jme_reset_phy_processor(),
jme_phy_calibration(), jme_phy_setEA(), jme_reset_link() and
jme_start_irq(). None of them calls jme_mac_rxclk_off() or
jme_reset_mac_processor().

jme_link_change_work() also skips its disable/reset block the first time
it runs after resume, because jme_suspend() already called
netif_carrier_off():

    if (netif_carrier_ok(netdev)) {
        jme_disable_rx_engine(jme);
        jme_disable_tx_engine(jme);
        jme_reset_mac_processor(jme);
        ...

After each WoL suspend/resume, if the link stays down, the RX MAC clock
keeps running while the RX engine is disabled. Before this patch it was
gated in that state.

If the link comes up, jme_check_link() writes the cached reg_gpreg1, which
no longer has RXCLKOFF set, to JME_GPREG1. jme_enable_rx_engine() then
programs RXCS, RXDBA, RXNDA and RXQDC while the clock is already running.
Its trailing jme_mac_rxclk_on() then has nothing to do.

Doesn't this skip the order that commit 854a2e7c331a ("jme: Safer MAC
processor reset sequence") introduced, where the RX engine is programmed
with the clock gated and the clock is started afterwards?

The commit message says "Keep the RX MAC clock running while WoL is
armed". However, the clock stays on after WoL is disarmed, until the next
link-down runs jme_disable_rx_engine() and jme_reset_mac_processor().

Would calling jme_mac_rxclk_off() in jme_resume(), for example right after
jme_clear_pm_disable_wol(), keep the WoL fix and restore the previous
state?

[Severity: Medium]
Can jme_link_change_work() running at the same time gate the clock again
after this call?

jme_link_change_work() calls jme_disable_rx_engine() and
jme_reset_mac_processor(). Both end in jme_mac_rxclk_off(). Neither
caller of jme_powersave_phy() waits for linkch_task to finish first.

On the suspend path, jme_suspend() only does:

    atomic_dec(&jme->link_changing);

The work uses that atomic as an ad-hoc lock:

    while (!atomic_dec_and_test(&jme->link_changing)) {
        atomic_inc(&jme->link_changing);
        ...
    }

If the work has already passed that gate, the counter just drops to -1 and
suspend continues without waiting. jme_stop_irq() masks the device
interrupt but does not flush or cancel linkch_task. schedule_work() puts
the work on system_wq, which is not freezable.

Suppose the work is preempted after its netif_carrier_ok() check.
jme_suspend() can then run the new jme_mac_rxclk_on() and arm PMCS. When
the work resumes, it resets the MAC and gates the clock. If the link is
down, the work never turns the clock back on.

On the shutdown path:

    jme_shutdown()
        jme_powersave_phy(jme);
        pci_pme_active(pdev, true);

there is no jme_stop_irq(), no link_changing gate and no
cancel_work_sync(). With the interface up, jme_set_100m_half() forces
100M/half. That drops the link, raises INTR_LINKCH and schedules
linkch_task. With the default reg_pmcs = PMCS_MFEN, jme_wait_link() is
skipped, so jme_shutdown() returns right after the clock is turned on.

If power-off happens before the link comes back up, could the work reset
the MAC and leave WoL armed with RXCLKOFF set?

jme_mac_rxclk_on(), jme_mac_rxclk_off() and jme_check_link() also do
unlocked read-modify-writes of jme->reg_gpreg1, so concurrent updates to
that cached value can be lost.

The missing synchronization with the link-change work and the atomic gate
are older than this patch. But this fix only works if nothing gates the
clock after it is turned on.

Should linkch_task be stopped from rescheduling and drained (for example
with cancel_work_sync()) before WoL is armed?

>  		jme_clear_pm_enable_wol(jme);
>  	} else {
>  		jme_phy_off(jme);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-jme-wol-submit-v1-1-9cc033e259e4%40gmail.com
