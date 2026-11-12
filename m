Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489459;
	b=QS/LXsdcPa0AQR0kD/RtZ4drwdv75ZY2+Y4/LaOWS/o10m53B/5m6ql6UdQwituzdcZJ
	 whEpIJIJvJapQIdOqrvQCm/jrGEX7ZiMMwOJz2fGPCIpFamIIR54/79e7+CVOWdRlf6pZ
	 Q76qMJRTMiWFTioocQB1YJFHgCzo2jzPHWDgA7IW5f9u61Jm3imPP7HGlLfZ2o/77/wdj
	 sXLBrMUli7CX5nMwSD0Txiy1DLRT6a2k6UhPP99DoUD2O487SCAeEKmx9CHgcQs+qWHqz
	 e2sCuWhELAg2G3gUs8jBPtLiUDOLzVFCSDUdjyEt2kkIFXK5G8zucguW5+zYPNHD+Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489459;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Yzj1idXCtJoUHmqfLKHjwJlnUugxQp0V2Hcyn0etTKs=;
	b=4dcgTXP/pV3NTmAf0eP8DsBsXYanTKqDAlGLoZbe7GpfuC8o9fou+3/MsZeJbfl0mqPD
	 Qke4SsDxEnHCMzoKloSnmVnTQcqYlW/e2w5Czes/v1RRo0fI7M8waXLlIVh8WKYCtjuCn
	 9pfwL6paDra6j9gyl8Swyrq1rP6kN81XXg5U7P5tc8VuEaNCQZKowCXRO+Kk4/KF8A5ff
	 1JkdiSoAyOgTwZNG7bK8HFgETyle02ZDVCUQG8ehqtt3u8SpCO1J/TzQ1gIRW8oev/GRV
	 uwYd0t4evagcr4xO4jQnmOQEZhYRnGiMx2LqrEH17pXZY/GS5euL0hZAbbGvgE/aCnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcMjtF7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB6606A321;
	Thu, 12 Nov 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcMjtF7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610861F00A05;
	Thu, 12 Nov 2026 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794489459;
	bh=Yzj1idXCtJoUHmqfLKHjwJlnUugxQp0V2Hcyn0etTKs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KcMjtF7idjFnXqRPJ0m13utBRo4xxzDotH+skm6X9nKZ2K1b5wdF0nbjbC3KjU2DS
	 kJszcOzKHfm5P68n0SspMLJxXmyLS+wsyMIudy4l7WjVgGN8AWlC7XkNed2vduudNh
	 vHiWi1ihOquWeux8BnZ9WUK8GjBJJzglqWINqPwOJ82oKujOFprjPelq/j/EC+EXl0
	 vCByiK4IhgswlsyI1uw7YVh/ODIPU5sD6Cv8jQkSSDvutkEAPN675AAWtAKlhbesH5
	 ZPliWXy5tzfG0MED2cjsuawssi/gaSnawhhk2rrSwc6sZIUPY03/ftnXJEqDiZcmYh
	 T9wnliIizGKrg==
Subject: Re: [PATCH net v8] net: libwx: fix VF PM suspend/resume flow
From: netdev-bot+sashiko@kernel.org
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 13:17:37 +0000
Message-ID: <179448945794.2199510.9916666789815826556@kernel.org>
In-Reply-To: <20261109101442.84605-1-mengyuanlou@net-swift.com>
References: <20261109101442.84605-1-mengyuanlou@net-swift.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] wxvf_link_config_subtask()
  (drivers/net/ethernet/wangxun/libwx/wx_vf_common.c) now calls…
- [Low] The new `if (!wx->num_q_vectors) return -EBUSY;` guard in
  wx_set_ringparam_vf()…
- [Low] The new PF-readiness probe in wxvf_reopen_subtask() checks only
  the return value of wx_mbx_write_and_read_reply().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new resume
  recovery path depends on it.

--

net: libwx: fix VF PM suspend/resume flow

This commit reworks the shared txgbevf/ngbevf PM callbacks. On suspend, a
running VF is now closed under RTNL, and the service timer and work are
drained before PCI is disabled. On resume, PCI is re-enabled and the PF
readiness check, VF reset, interrupt setup and reopen are deferred to the
service task.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 940d2e59876c7..729b1ec65bd75 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> @@ -790,6 +790,9 @@ static int wx_set_ringparam_vf(struct net_device *netdev,
>  	struct wx_ring *temp_ring;
>  	int i, err = 0;
>  
> +	if (!wx->num_q_vectors)
> +		return -EBUSY;
> +

[Severity: Low]
Can this check in wx_set_ringparam_vf() ever be reached? Both ethtool entry
points reject a detached device before they call into the driver:

net/ethtool/ioctl.c:__dev_ethtool() {
    ...
	if (!netif_device_present(dev)) {
		rc = -ENODEV;
		goto out;
	}
    ...
}

net/ethtool/netlink.c:ethnl_ops_begin() {
    ...
	if (!netif_device_present(dev) ||
	    dev->reg_state >= NETREG_UNREGISTERING) {
		ret = -ENODEV;
    ...
}

As far as I can tell, the netdev stays detached under RTNL whenever
num_q_vectors is zero:

- wxvf_suspend() detaches before wx_clear_interrupt_scheme().
- wxvf_resume() does not reattach.
- wxvf_reopen_subtask() calls netif_device_attach() only after
  wx_init_interrupt_scheme() and wxvf_open() succeed.
- The err_disable_device path leaves the device detached.

The VF drivers also don't register a PCI err_handler that could reattach
the device.

wx_get_coalesce() and wx_set_coalesce(), in the same wx_ethtool_ops_vf
table, don't have this guard and dereference q_vector[0] directly:

	if (wx->q_vector[0]->tx.count && wx->q_vector[0]->rx.count)

If the state can't be reached, should the check be dropped, along with the
commit message line "Reject ring-parameter changes while queue vectors are
unavailable."? If it can be reached, wouldn't the coalesce ops need the
same guard?

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69ef..e274a77b3be9d 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c

[ ... ]

> @@ -388,25 +419,101 @@ static void wxvf_link_config_subtask(struct wx *wx)
>  {
>  	struct net_device *netdev = wx->netdev;
>  
> +	rtnl_lock();
> +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> +	    test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
> +		goto out;
> +
>  	wxvf_watchdog_update_link(wx);

[Severity: Medium]
Does this make every running VF take the global RTNL mutex every two
seconds, even when there is nothing to do?

wxvf_link_config_subtask() now takes rtnl_lock() before it checks any of
WX_STATE_DOWN, WX_FLAG_NEED_REOPEN or WX_FLAG_NEED_UPDATE_LINK. Meanwhile
wx_service_timer() re-arms itself every 2 * HZ:

wx_service_timer()
    mod_timer(&wx->service_timer, next_event_offset + jiffies);
    wx_service_event_schedule()
        -> wxvf_service_task()
            -> wxvf_link_config_subtask()
                -> rtnl_lock()

wx_msix_misc_vf() sets WX_FLAG_NEED_UPDATE_LINK on every misc interrupt,
and wxvf_up_complete() sets it too. When it is set,
wxvf_watchdog_update_link() now runs its mailbox exchange under RTNL. That
exchange holds mbx_lock with BH disabled and polls with
readx_poll_timeout_atomic().

wxvf_reopen_subtask() behaves the same way while a reopen is pending and
the PF does not answer. It takes RTNL every two seconds with no back-off or
retry limit, and each time it busy-waits on the GET_FW_VERSION ping.

Could the lockless flag checks be done before taking RTNL?

Also, this change to steady-state link polling is only mentioned in the v5
changelog below the "---" line, so it won't appear in git history. Would it
be worth describing it in the commit message?

[ ... ]

> +static void wxvf_reopen_subtask(struct wx *wx)
> +{
> +	u32 ping[2] = { WX_VF_GET_FW_VERSION };
> +	int ret;

[ ... ]

> +	spin_lock_bh(&wx->mbx.mbx_lock);
> +	ret = wx_mbx_write_and_read_reply(wx, ping, ping, ARRAY_SIZE(ping));
> +	spin_unlock_bh(&wx->mbx.mbx_lock);
> +	if (ret) {
> +		rtnl_unlock();
> +		return;
> +	}

[Severity: Low]
Is a zero return here enough to conclude that the PF is ready? ping[0] is
never checked for a WX_VF_GET_FW_VERSION reply with WX_VT_MSGTYPE_ACK or
WX_VT_MSGTYPE_NACK set.

If VF MMIO reads return all-ones, every poll in the mailbox transport
succeeds at once:

- wx_obtain_mbx_lock_vf() sees WX_VXMAILBOX_VFU.
- wx_poll_for_ack() sees WX_VXMAILBOX_PFACK.
- wx_poll_for_msg() sees WX_VXMAILBOX_PFSTS.
- wx_read_mbx_vf() copies 0xffffffff into ping[0] and returns 0.

wx_reset_vf() then writes to the unresponsive function. It only fails later,
with -EINVAL from the reply check in wx_reset_hw_vf():

	if (msgbuf[0] != (WX_VF_RESET | WX_VT_MSGTYPE_ACK) &&
	    msgbuf[0] != (WX_VF_RESET | WX_VT_MSGTYPE_NACK))
		return -EINVAL;

Would validating ping[0] in the same way, for example checking that
(ping[0] & 0xFFFF) == WX_VF_GET_FW_VERSION with ACK or NACK set, make this
a real readiness check?

[ ... ]

> +	if (netif_running(wx->netdev) && wxvf_open(wx->netdev))
> +		goto err_disable_device;

[Severity: High]
This isn't a bug introduced by this patch, but the new resume recovery
depends on it. wxvf_reopen_subtask() assumes wxvf_open() leaves the device
quiesced when it fails. However, the wxvf_open() error unwinding frees the
rings before it stops the hardware queues:

wxvf_open() {
    ...
err_free_irq:
	wx_free_irq(wx);
err_free_resources:
	wx_free_resources(wx);
err_reset:
	wx_reset_vf(wx);
	return err;
}

wx_configure_vf() has already enabled reception before either
wx_request_msix_irqs_vf() or netif_set_real_num_{tx,rx}_queues() can fail:

- wx_configure_rx_ring_vf() sets WX_VXRXDCTL_ENABLE, calls
  wx_enable_rx_queue() and posts DMA-mapped page_pool buffers.
- Through wx_rlpml_set_vf(), the PF has set this VF's bit in WX_RDM_VF_RE.

On failure, wx_free_resources()->wx_free_rx_resources() calls
dma_free_coherent() on the descriptor ring and then page_pool_destroy().
WX_VXRXDCTL_ENABLE is cleared only afterwards, in
wx_reset_vf()->wx_reset_hw_vf()->wx_stop_adapter_vf().

wxvf_resume() has already called pci_set_master() at this point. Can the VF
write back descriptors or received frames into the freed memory during that
window, before err_disable_device reaches pci_disable_device()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109101442.84605-1-mengyuanlou%40net-swift.com
