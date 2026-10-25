Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792901038;
	b=AowICi+SZs2K/0EBpJ62Zgq4OtW2GxLdRHqssn1E2ub457tqurOIK2lCPOgLo/QSCG2q
	 TzHO6qwHKRf59Ju9F8AXa8vILLkeN7eISXL8zBiYcvwyMFbHG+p2bHBQfB0zsF764PFRq
	 vg5rE8FvG4olrGDZOvmR1+XMJES6H6xu7VcNBvT/iFKDJKk7zZY7yh9I+ITvv8GGAaqd5
	 EXyb1nteGFqAb3rWlzwfEJ8z2kaV4w28D40p9nuIoUJasOXg/T7cJbW9YRjBxA6oW7hov
	 VUmCodY/ZdtItwcTBLIZ+UFsYNjFQ1u4uTiogQf+Ynoe/PMC42QD9k9/SZEMJpfQkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792901038;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EzVD2bT7oaizuDVBh+h57LTaRZEKb5zEcCK5n3l4SOY=;
	b=LnocAO9kyApItoMBi4FpRs/LkQ2caTXvI0mqT3T8vkuAsEYn5xlPOrfmIqOSht4weiGv
	 XobyqYBQNhgQKKFtBKR8OH4RT04oM9lzzhMuJ9NlQsoc58YvJIOHNOvvblIPXUlKnYzn1
	 ziP5peWDNH98VfKCGzVP5fXHqcYa/P+tqK5RlFYYq6MIluKbh449ZUBADmWnZJjAlV0Wm
	 FZ4z4/+3rgvrsW6pxG8hphYOW1GseZEIRfElsozLAe+7EGjyU2NOTrV7YqfM0IW6lL6KI
	 7cpACaDnZEQ95HW2xy7eYlteRx29CMT+AJeLEBsj8qLtst4Pu/k98mXoS131wSagRpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8SZj3UK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86998606A31E;
	Sun, 25 Oct 2026 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8SZj3UK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC811F01825;
	Sun, 25 Oct 2026 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792901037;
	bh=EzVD2bT7oaizuDVBh+h57LTaRZEKb5zEcCK5n3l4SOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k8SZj3UKZ8kW9I9DVd5h89/tc+6gO1l9k31Ud8hnMcWjL+ch1YJurCxR/ifEDl857
	 4EX9KoXmuJLfNhOQf7+uNyfyiI1ywaZadGOvA91ES4YjN/IUTx1aNgbb9rZiypXNq4
	 vGUZH8phfEw6hxF4qgUN1dgeDbHUp/Y6TwheCzn0mVXAhTTXpb+2hyyo7bqyd6KxSy
	 j+K9gssLcXyhaKDN6JD1/Vge8xY3B65AUCLFYdEVmtcSXRN5IjrBCkDUfzdQ8vZoib
	 KGTLfVuTSMG2ye20gD743qcpiRY8g9ubPCmJVTT0aGVUKMUiGsNJAY6tHbSUToH0nu
	 PUO86dD0empLw==
Subject:
 Re: [PATCH net v6 1/6] nfc: nci: skip controller reset while unregistering
From: netdev-bot+sashiko@kernel.org
To: shubham@octane.security
Cc: netdev@vger.kernel.org, david@ixit.cz, oe-linux-nfc@lists.linux.dev,
 gio@octane.security, stable@vger.kernel.org, kuba@kernel.org
Date: Sun, 25 Oct 2026 04:03:56 +0000
Message-ID: <179290103628.3134.7771623645403317712@kernel.org>
In-Reply-To: <20261021032443.44412-2-shubham@octane.security>
References: <20261021032443.44412-2-shubham@octane.security>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch skips CORE_RESET_CMD for every caller of
  nci_unregister_device(), not only for transports that are detaching.
- [Medium] The NCI_UNREG check only removes the CORE_RESET that close
  sends itself.
- [Medium] The new NCI_UNREG gate cannot affect a reset (or init) request
  that is already in flight when line discipline close starts.
- [Low] On the unregister path, nci_close_device() no longer sets
  NCI_INIT, but it still calls ndev->ops->close().

--

nfc: nci: skip controller reset while unregistering

This patch makes nci_close_device() skip sending CORE_RESET (and skip
setting NCI_INIT) when NCI_UNREG is set. The motivation is that on line
discipline close the transport can no longer deliver the response, so close
waits for the full reset timeout.

> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 73e3a96470ace..8ee33505e93ad 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -582,13 +582,15 @@ static int nci_close_device(struct nci_dev *ndev)
>  	/* Flush TX wq, RX wq flush can't be under the lock */
>  	flush_workqueue(ndev->tx_wq);
>  
> -	/* Reset device */
> +	/* Reset device unless it is being unregistered */
>  	skb_queue_purge(&ndev->cmd_q);
> -	atomic_set(&ndev->cmd_cnt, 1);
>  
> -	set_bit(NCI_INIT, &ndev->flags);
> -	__nci_request(ndev, nci_reset_req, (void *)0,
> -		      msecs_to_jiffies(NCI_RESET_TIMEOUT));
> +	if (!test_bit(NCI_UNREG, &ndev->flags)) {
> +		atomic_set(&ndev->cmd_cnt, 1);
> +		set_bit(NCI_INIT, &ndev->flags);
> +		__nci_request(ndev, nci_reset_req, (void *)0,
> +			      msecs_to_jiffies(NCI_RESET_TIMEOUT));
> +	}

[Severity: Medium]
This skips the reset for every caller of nci_unregister_device(), not only
for transports that are detaching. Is that intended for drivers whose bus
still works during remove() and whose ops->close() does nothing?

For nfcmrvl over I2C/SPI, nfcmrvl_nci_close() only calls the per-bus close
function, and that function is empty:

drivers/nfc/nfcmrvl/i2c.c:nfcmrvl_i2c_nci_close() {
	return 0;
}

FDP is the same:

drivers/nfc/fdp/fdp.c:fdp_nci_close() {
	return 0;
}

nfcmrvl_nci_unregister_dev() also never calls nfcmrvl_chip_halt(). The
I2C/SPI IRQs are devm-managed, so they are still live during remove().

Before this patch, the CORE_RESET went out over the live bus with NCI_INIT
set. nci_recv_frame() accepted the response, and the NFCC went back to
reset.

With this change, suppose the device is up when nfcmrvl_i2c_remove(),
nfcmrvl_spi_remove() or fdp_nci_remove() runs. Can the controller then stay
in its last RF state (polling with the field on, listen mode, or an active
interface) after the kernel has cleared all of its state?

The commit message says:

  Keep the reset for a normal device-down operation, where the transport
  remains attached and can deliver the response.

For these drivers, the transport is also still attached during unregister.

Later patches in the series don't seem to change this:

- nci_close_device() stays the same.
- nfcmrvl_fw_dnld_abort() returns early when no download is active.
- The new nci_quiesce hook exists only for UART.

[Severity: Low]
On the unregister path, test_and_clear_bit() at the top of
nci_close_device() has already cleared NCI_UP. Now NCI_INIT is not set
either. But ndev->ops->close(ndev) still runs right after this block, and
for ST NCI that callback sends a request:

st_nci_close()
  ndlc_close()
    nci_prop_cmd(ndlc->ndev, ST_NCI_CORE_PROP, ...)
      __nci_request(..., msecs_to_jiffies(NCI_CMD_TIMEOUT))

The reply comes in through llt_ndlc_rcv_queue() -> nci_recv_frame(), which
drops it:

	if (!ndev || (!test_bit(NCI_UP, &ndev->flags) &&
	    !test_bit(NCI_INIT, &ndev->flags))) {

Will the mode-set command in ndlc_close() now always time out after 5
seconds and log a pr_err during unregister?

The impact is limited. st_nci_remove() already calls ndlc_close() directly
before nci_unregister_device(), and that call disables the IRQ, so the old
CORE_RESET also timed out. The stall moves from the reset to the mode-set
command, and total unbind time stays about the same.

[Severity: Medium]
Does this cover a reset or init request that is already running when line
discipline close starts?

nfc_dev_down() takes device_lock and calls nci_dev_down() ->
nci_close_device(). NCI_UNREG isn't set yet, so __nci_request(nci_reset_req)
runs and waits for up to NCI_RESET_TIMEOUT. nfc_dev_up() ->
nci_open_device() does the same with its reset and init requests.

Meanwhile, with the ldisc write lock held:

nci_uart_tty_close()
  tty->disc_data = NULL;
  nu->ops.close(nu)
    nfcmrvl_nci_unregister_dev()
      nci_unregister_device()
        nfc_unregister_rfkill()
          device_lock(&dev->dev);   <- blocks behind nfc_dev_down()

This block happens before set_bit(NCI_UNREG) and before nci_req_cancel() in
nci_close_device().

The pending response can't arrive, because disc_data is NULL and the ldisc
lock is held for writing. So the waiter runs out the full 5000 ms timeout,
and ldisc close waits along with it.

This is the "close waits for the full timeout" symptom from the commit
message, reached through a race. The rest of the series doesn't seem to
change it either. The later UART quiesce patch stops rx/tx before ops.close,
which only makes sure the response never arrives.

Would it work better to mark the device as unregistering and cancel pending
requests before serializing on device_lock? Another option is to make
in-flight requests abort when the transport detaches.

[Severity: Medium]
A related question about requests already in flight. nci_req_cancel() runs
only once, at the top of nci_close_device(). It only completes a request if
one is pending at that exact moment:

net/nfc/nci/core.c:nci_req_cancel() {
	if (ndev->req_status == NCI_REQ_PEND) {
	...
}

nci_open_device() checks NCI_UNREG only on entry:

	if (test_bit(NCI_UNREG, &ndev->flags)) {

After that check, its __nci_request() calls (reset/init, 5000 ms timeouts)
wait out their full timeouts while device_lock is held.

Say NFC_CMD_DEV_UP is waiting there when nci_uart_tty_close() starts.
Unregister then blocks in device_lock() in nfc_unregister_rfkill() until
the timeout expires.

Doesn't that still leave ldisc close stalled for NCI_RESET_TIMEOUT or
NCI_INIT_TIMEOUT, even with the new NCI_UNREG check?

This overlaps with the device_lock ordering question above. Other nfc core
ops take device_lock and check shutting_down, so no new request should be
able to start after nfc_unregister_rfkill().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021032443.44412-1-shubham%40octane.security
