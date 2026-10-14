Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E4E47F3BD;
	Wed, 14 Oct 2026 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000932; cv=none; b=qzehvV06+2BMaWKr+Mvuc7W3irMRkXV1eVK25+nddPXo/2gRkUc8Cgm0ctqdgzJMD0ZJnN6rwpYyTo3EQytJuhqPlkNJzry2EyKFN2FAAoDYgPBr1/CFrcswCAPYeT0djzCdSnWyCEqkcaIOqTwGL1HP0nytesY5X1zRZIC13NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000932; c=relaxed/simple;
	bh=hzGcmhJT2FmFRf6nc5h0MmQUOOKA6QuPs0v0S6naB3c=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ez2WnOP7PHtCwbEbpPh4jLrYKO+ZSQyiUeJxbbl2RthmxLKhRU5sbKAMyfuhC6bFqCNIImTzYTnShjXlfs+bGQ0/rvBfOp2fKFDUdbeiwk7mbJVcgU+lex9DObgpoqYHxuJShpuVIUJIXbvZi4rCBYE2+wuK4T6f/J9TjGynKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IhRaNRTX; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IhRaNRTX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792000928; x=1792260128;
	bh=9nICx+kZ4aCEOVUwXTEwaKCXjblsqbjRgDzmtXcnD+g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IhRaNRTX2H6v4pXF+KLx7MFJbgZjxY88QoB0p3bFobdsf9gD9i2plm8QoI6DvTZIh
	 g12MP9danb97u6EdbQGiViD0xs36jeU4BRrX8y+JMUuUJJ3yX2IaGJowGj7e0t+swF
	 nDaV297chJqpUI1kgpETKuVRHUHVyJZzeEAC2d/ZUW+yz9Qb4emM3HX3uRA3Kt6XvJ
	 meJVa+pA2+e4ehtMuSq9f0BOm5q9UKQH4t1Tiha4+K3MldzRkbwUVbCapY9MlnZ/C4
	 I9cAptm+F54WUoWLiSdQ2eN1Nx0TyLuScLUjf1QtzU4ZbWFIpUPYjkNSx9UQOr6yFZ
	 2fATumkbjIdeA==
Date: Wed, 14 Oct 2026 18:02:03 +0000
To: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>, linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_qca: Reset the in-band sleep state on power off
Message-ID: <20261014180201.57109-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: ff478eacab4415be8db0232201d760eeecb80e9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

qca_power_off() cuts the power of the controller but leaves the host
side of the in-band sleep (IBS) protocol as it was. tx_ibs_state and
rx_ibs_state are initialised in qca_open() only, so a controller that
qca_setup() powers on again meets whatever state the last session ended
in.

If that state is HCI_IBS_TX_AWAKE, the host sends the frames after the
next setup without a wake indication. qca_hci_shutdown() stops both IBS
timers, but the pre-shutdown command it sends afterwards goes through
qca_enqueue() and arms tx_idle_timer again for 2 s, so a power on within
those 2 s finds the state at AWAKE. On a OnePlus Pad 3 (WCN7880) this
happens with a power off and on within 2 s, and at every boot of a board
without local-bd-address when user space sets the address right after
the controller registers. The controller comes back asleep, and the
first command after it has gone to sleep breaks the link:

  Bluetooth: hci0: Frame reassembly failed (-84)
  Bluetooth: hci0: Opcode 0x0c56 failed: -110
  Bluetooth: hci0: crash the soc to collect controller dump

The timer left armed can also send HCI_IBS_SLEEP_IND in the middle of
the next setup.

If the state is HCI_IBS_TX_WAKING, the host is waiting for a wake
acknowledgment, and qca_hci_shutdown() has deleted the timer that
sends the wake indication again. The setup still works, because frames
bypass IBS while QCA_IBS_DISABLED is set. Once the flag is cleared,
qca_enqueue() puts every frame on tx_wait_q and nothing takes it off:

  Bluetooth: hci0: QCA setup on UART is completed
  Bluetooth: hci0: Opcode 0x0c03 failed: -110

A restore from hibernation gets there on a Lenovo Yoga Slim 7x
(WCN7850). The controller has been through a power cycle, while the
restored kernel holds the state from before the image was taken. Its
wake indications go unanswered, the commands behind them time out, and
the core closes the device and sets it up again. From then on
tx_ibs_state reads 1 in debugfs and Bluetooth stays dead until hci_uart
is reloaded.

When the controller loses power, cancel the IBS work, wait for the IBS
timers, drop what was queued and put both sides back to asleep, which
is where qca_open() starts. The timer callbacks take hci_ibs_lock, so
the timers are deleted outside of it. All callers of qca_power_off()
can sleep, and the work items do not call it.

Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci d=
own for wcn3990")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Co-developed-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
Changes since v1
- Cancel both IBS work items and wait for both timers before the reset,
  with the timers deleted outside hci_ibs_lock, and flush after that, as
  the Sashiko review of v1 pointed out (Vladyslav)
- Describe the AWAKE trigger next to the WAKING one
- Add Fixes: and Cc: stable
- v1 is at https://lore.kernel.org/r/179163212446.46972.2306254853726299632=
@pm.me

Vladyslav tested this version on a OnePlus Pad 3 (SM8750, WCN7880). In
five quick power cycles four fail without it and none with it [1].

On a Lenovo Yoga Slim 7x with v7.3-rc7 and hci_uart rebuilt, ten quick
power cycles (power on 1 s after the power off, then a scan) pass with
the stock module, with v1 and with v2, so this board does not show the
AWAKE failure. Right after the power off, debugfs reads tx_ibs_state=3D2
and rx_ibs_state=3D1 with the stock module and 0 and 0 with v1 and v2.

The hibernation runs were done with v1 (stock dead after four restores
out of four, back by itself after two out of two) and are not repeated
with v2. Those kernels also carried the hibernation changes in [2], [3]
and [4]. v2 is based on bluetooth-next, where it builds without
warnings (W=3D1).

[1] https://lore.kernel.org/r/20261014162025.3733-1-tvlad744@gmail.com
[2] https://lore.kernel.org/r/179157746908.73485.2343672865542690797@pm.me
[3] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me
[4] https://lore.kernel.org/r/179163141354.18006.80461347454353634@pm.me

 drivers/bluetooth/hci_qca.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b63..0d3b5f198 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2229,12 +2229,25 @@ static void qca_power_off(struct hci_uart *hu)
 =09struct qca_power *power;
=20
 =09/* From this point we go into power off state. But serial port may
-=09 * still be open, stop queueing the IBS data and flush all the buffered
-=09 * data in skb's.
+=09 * still be open, stop queueing the IBS data.
 =09 */
 =09spin_lock_irqsave(&qca->hci_ibs_lock, flags);
 =09set_bit(QCA_IBS_DISABLED, &qca->flags);
+=09spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
+=09/* The controller loses the IBS state with its power and comes back
+=09 * with both sides asleep, as qca_open() assumes. Stop the IBS work and
+=09 * timers, drop what they queued and start over from there.
+=09 */
+=09cancel_work_sync(&qca->ws_awake_device);
+=09cancel_work_sync(&qca->ws_awake_rx);
+=09timer_delete_sync(&qca->wake_retrans_timer);
+=09timer_delete_sync(&qca->tx_idle_timer);
+
+=09spin_lock_irqsave(&qca->hci_ibs_lock, flags);
 =09qca_flush(hu);
+=09qca->tx_ibs_state =3D HCI_IBS_TX_ASLEEP;
+=09qca->rx_ibs_state =3D HCI_IBS_RX_ASLEEP;
 =09spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
=20
 =09/* Non-serdev device usually is powered by external power
--=20
2.55.0


