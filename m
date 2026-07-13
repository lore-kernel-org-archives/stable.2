Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198519D8A8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963975; cv=none; b=d/wvCF6DrjJseeirJuCM2fQTaKnqVZGS7c8bZ1InTOjdKrUbeEJsY2Fv/AIoYxanhA1PwdyRz+wKApBwjWRYSYibb582YgBauigvOIsWTgcq1G+13M/y1/bqmRtj8sHQjMlivxY3I97D6fboijXUcA4qvU4ajx1R2MMxDsq5kLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963975; c=relaxed/simple;
	bh=x0j/8xdnIO9tpEJxlN0xwxwtfiVEGAtdk0uTgIEDoBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mMUlEgYXz2jvFYjCD6IJREZuPb6crKADMON+Q0XuNaJh8uLVlS7p7oFvNYtY0SmUbVNhN+NEvUZy3Wra5kc1CDbemg3yAbxouQdr5dATtuDfwUH4dSdWYxnIosM+qvHAcXkzaCiufIZGdIGpQsL8OgjJ9bMb7HMIcxMAYr1Eguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5yY6vwm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5yY6vwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02731F000E9;
	Mon, 13 Jul 2026 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783963974;
	bh=vgB0R3HSV4C8Mxv6RE7Od7xc4DLOTugaj7AN3ESm2BM=;
	h=Subject:To:Cc:From:Date;
	b=n5yY6vwmFtHSJ3pr+cjZwGMOlogqvq2cmy7V+vDVN/WR7FxrbJEEidVPKS0IpU6qP
	 g75tqyQMQ/xxwMDK85Uf39IEyLGILA4+VFcFcYjWWSz0lDehod+przfPzP+M9zghfW
	 TWTNABRGixXoiBq1rR3dbnuNuU2E8tVL5UpaU9bA=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work" failed to apply to 5.10-stable tree
To: pav@iki.fi,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 19:32:38 +0200
Message-ID: <2026071338-expend-curing-7388@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1b0d946d6f08bd39211385bc703a440911b41e46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071338-expend-curing-7388@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1b0d946d6f08bd39211385bc703a440911b41e46 Mon Sep 17 00:00:00 2001
From: Pauli Virtanen <pav@iki.fi>
Date: Sat, 13 Jun 2026 21:43:37 +0300
Subject: [PATCH] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work
 is canceled

HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
queueing it again.  Currently this bit is not cleared when canceling the
work in hci_uart_close(), which blocks future writes when device is
reopened later if write_work was pending.

Fix by clearing HCI_UART_SENDING when canceling the work.

Also make clearing of tx_skb safe by using disable_work_sync +
enable_work instead of just cancel_work_sync.  hci_uart_flush() purges
the proto tx queue so we can cancel the pending write_work there,
instead of doing it just in hci_uart_close().  Re-enable and possibly
requeue the work after queue flush.

Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths")
Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
Cc: stable@vger.kernel.org
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 47f4902b40b4..2ad42c3bbaac 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -239,6 +239,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
+	disable_work_sync(&hu->write_work);
+
 	if (hu->tx_skb) {
 		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
 	}
@@ -254,6 +256,14 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	percpu_up_read(&hu->proto_lock);
 
+	/* Resume TX. Also reschedule in case work was queued concurrently;
+	 * this may schedule write_work although there's nothing to do.
+	 */
+	enable_work(&hu->write_work);
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
+		hci_uart_tx_wakeup(hu);
+
 	return 0;
 }
 
@@ -271,12 +281,8 @@ static int hci_uart_open(struct hci_dev *hdev)
 /* Close device */
 static int hci_uart_close(struct hci_dev *hdev)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-
 	BT_DBG("hdev %p", hdev);
 
-	cancel_work_sync(&hu->write_work);
-
 	hci_uart_flush(hdev);
 	hdev->flush = NULL;
 	return 0;

