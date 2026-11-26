Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795719601;
	b=dNoqcv91lBCTz3bReC4dNvCsDUkOYiLlRTSTPCRL83wHsbc7cfPF8l6nnfsNZ7uPgDYK
	 SzoOtmsSiVOstNXW/5/EiPhSI4VR5iQJqNrsmzB5OHbAHXk2eRpo4UVuugeGpI7S/AyJ9
	 6VfJmYluaZC4feZMzRq5tqa8I6GNad7fzptyFE2iV3OfFTYfkq5ysHpkFNvYPsViTznop
	 Bm4LEs4Q6SIwioO4rOzncGGDu+h0bS5M7yR4W4wERjTW4gJZcDd1n4E2Mnkj3zzTdVhJw
	 LSWqi9IO1lbCI17PfKEq0ABfkfyUniXBmSzNs/D+IwtbeaJ/48YpNSDUJBMnMIIZc/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795719601;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=jWwv6SLgvSFFDCvgqquvmQoWH49kQLiOQm3ccYIx0dE=;
	b=EnSaAtDMw1gzW+6emrkLc90xnuV3wgsCqeIaEF6cADdF2pKPSVHZKcqOkgwc9oXb2UFS
	 44c1Cjjp0IcRd648KBS/Ta82HHfBw5KYiw0f8oFZeUaF+56kSzRxc4HDqTYPl1ZBFUEqj
	 JxZ731uIZQCf4kdj4gO7CdNF+khrTHbPMRS7LQW13GJgoJ0MAAUVAWujb0XWL51lw8ci9
	 pKjmAcwwwZgOqMZuHvq3SmaPwP6iCw0q6IoXk6UCiwFaJW5W1d8h/nYHftlLjLv1xkxSs
	 tXPOYEx6l6uOaou4BQ51h056ixqEh+Jp86uVBzHaPcORHy0wr/8q2qatCLgaz+j7KxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=tuuhb0vF;
	arc=none smtp.remote-ip=109.224.244.106
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E1606A31E;
	Thu, 26 Nov 2026 19:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 822E1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=tuuhb0vF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1795719597; x=1795978797;
	bh=jWwv6SLgvSFFDCvgqquvmQoWH49kQLiOQm3ccYIx0dE=;
	h=From:To:Cc:Date:Subject:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=tuuhb0vFEMYISj6momk35v/v5qgDBZAa9aFS+T+0Ev2OI5ww8BNcH6WK3qW684zKP
	 2jeymXE2Glo+raGlH3YCSPeYYB7QJW+hJU5qmCNzquiPAfOLtAAwOany3rIbRpwfKn
	 etOdvd5hzL49zboZ3MWarYgQDiuwN6IFj6SlklJpZGD3KfEazsuOJPHUfTuV9oPMSa
	 cTTalGhmhEycWv06149uBW8ifOQRCvTqflV4aHclb9ddrFHqFVGtJJuJLL8CbmLkbT
	 QHbW+uMeiimQg2D5n4hD135ExhilYcRvuJdMomZBfsoYHUb88xMQC9INknp+OdDrAc
	 J/gmCc6dr762A==
X-Pm-Submission-Id: 4jb5T80YqWz2ScX2
From: Michael McAllister <me@michaelmcallister.org>
To: marcel@holtmann.org, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, brgl@kernel.org, zhaojinming@uniontech.com,
 stable@vger.kernel.org, me@michaelmcallister.org
Date: Thu, 26 Nov 2026 18:59:41 +0000
Subject:
 [PATCH v4] Bluetooth: hci_serdev: Unregister HCI before freeing the TX buffer
Message-ID: <179571958163.81221.18219121256319863408.hci-serdev-unregister-v4@michaelmcallister.org>
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

Unregister frees hu->tx_skb before hci_unregister_dev() waits for an
in-flight HCI close or reset. That path can still flush the same frame,
causing a use-after-free or double free.

Unregister HCI first, before clearing protocol readiness and cancelling
write_work. Skip the HCI flush and close callbacks during unregister;
the transport teardown frees the frame and closes the protocol and port
once setup and HCI close have finished.

Flush controller TX after stopping UART work, before protocol and port
close, so previously accepted bytes are discarded rather than drained.

Fixes: 21139b3ac62a ("Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
Split out from the WCN3950 series, as Bartosz requested. Rebased onto
f57f78086ab5, including Zhao's flush and close fixes. Keep the unregister
guard in the HCI flush callback so close still balances disabling and
enabling write_work if unregister starts while close is in progress.

The standalone fix now flushes controller TX itself, before protocol and
port close; that flush was previously part of the dependent QCA patch.

Previous version: https://lore.kernel.org/179484638195.54009.16928291772826938293.wcn3950-poweroff-v3-1@michaelmcallister.org/

 drivers/bluetooth/hci_serdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 9f038ab65..dfa921afc 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -124,6 +124,9 @@ static void __hci_uart_flush(struct hci_dev *hdev, bool resume_tx)
 
 static int hci_uart_flush(struct hci_dev *hdev)
 {
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	__hci_uart_flush(hdev, true);
 
 	return 0;
@@ -162,6 +165,9 @@ static int hci_uart_close(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p", hdev);
 
+	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
+		return 0;
+
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		return 0;
 
@@ -431,6 +437,10 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	/* Wait for init_ready to finish to prevent registration races */
 	cancel_work_sync(&hu->init_ready);
 
+	/* Drain HCI setup before clearing protocol readiness. */
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+		hci_unregister_dev(hdev);
+
 	proto_ready = test_bit(HCI_UART_PROTO_READY, &hu->flags);
 	if (proto_ready) {
 		/* Clear HCI_UART_PROTO_READY under the write lock so a
@@ -452,16 +462,16 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	cancel_work_sync(&hu->write_work);
 
 	/* Free any partially transmitted frame left over by write_work now
-	 * that the transmit path is fully quiesced. hci_uart_close() would
-	 * skip hci_uart_flush() because HCI_UART_PROTO_READY is cleared.
+	 * that the transmit path is fully quiesced. The HCI close and flush
+	 * callbacks leave transport teardown to us during unregister.
 	 */
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb);
 		hu->tx_skb = NULL;
 	}
 
-	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-		hci_unregister_dev(hdev);
+	if (proto_ready)
+		serdev_device_write_flush(hu->serdev);
 
 	/* Close the protocol before freeing hdev (intrinsically purges queues).
 	 * Some protocol close handlers (e.g. qca_close) may still access the

base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
-- 
2.39.5

