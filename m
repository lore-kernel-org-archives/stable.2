Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA14B514D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444944; cv=none; b=HOuuZQSrNIbjU/q31k2Pzz4ICv2nK3GZxx/EtoIaN/0h0svMFYvNDEa/AjFWnuucU8PZ48+MCXoLU47GgrxTGQ3WKEfJG00yQZMxyZOxBjrayHcw/tuH3jqUmUgb9T9aBJmx9SHgFojEm0qSAgOjmeyTVn31ISXXAmIIEEqulNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444944; c=relaxed/simple;
	bh=iuQwfX9LCNOotgRONKQjvlTuKeq9ZIxCjgMtoxV1/yQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hKi7bvvlarNUy/c96iAXGHCvjuOcFNHCTo0bXDy4Ca6IO/oOgqYza75KcccZGCsshoNZHkAx5Azpr2LC1pkMAvhXH+fjVeIbFcZPUxBEUUVWsUEpQvoQIwjLQIr5CQwacbzzG7o/+958Qfi/MUSAgkntp2m0cHakW6Po7AS4j9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDuLu0/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDuLu0/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B08A1F00AC4;
	Thu,  3 Sep 2026 14:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444932;
	bh=zrmmLv2aZhwPKMTVlQshyBTL9tgnFOb57smN8YEplIY=;
	h=Subject:To:Cc:From:Date;
	b=WDuLu0/fojMAn57IT0euXUu3cQvm3mRHpR02BINi6xL/UYWFM7GoApgb9cffEySn7
	 j40LWgyXiBCWd47puvxutSbeFSblEaxy9q2c9O34DuQt2SjIl6Al7T0WeiwV+tUw2S
	 y+KIbD+OK39lZ4+CcIXmqh7s0LqFNs3j42+VHLfw=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the" failed to apply to 6.1-stable tree
To: iabdelka@qti.qualcomm.com,johannes.goede@oss.qualcomm.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:56:05 +0200
Message-ID: <2026090305-playmaker-geriatric-db71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cb19774faa57c51efa189d8b8606aeabccebc53b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090305-playmaker-geriatric-db71@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb19774faa57c51efa189d8b8606aeabccebc53b Mon Sep 17 00:00:00 2001
From: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Date: Tue, 11 Aug 2026 10:37:29 +0200
Subject: [PATCH] Bluetooth: hci_sync: Clear HCI_CMD_PENDING when dropping the
 last request

A synchronous HCI command that never receives a response leaves
HCI_CMD_PENDING set: hci_req_cmd_complete() is the only place that clears
it, and it only runs when a response matching the last command sent
arrives.

hci_send_cmd_sync() populates hdev->req_skb only when the flag transitions
from clear to set, while hci_dev_open_sync() and hci_dev_close_sync() drop
req_skb without clearing the flag. After a timeout followed by either, the
two disagree: the flag claims a request is outstanding while req_skb is
NULL. Subsequent synchronous commands are then sent with no req_skb, so
hci_event_packet() has nothing to match an arriving event against, and the
caller times out even though the controller answered.

Commands answered by Command Complete recover on their own, since
hci_req_cmd_complete() clears the flag as a side effect. Drivers using
__hci_cmd_sync_ev() with a custom event do not, because a vendor event
never reaches that path. On a WCN3988 (hci_qca over UART) this makes a
controller firmware hang unrecoverable: the driver injects a hardware
error and re-runs qca_setup(), qca_read_soc_version() waits for
HCI_EV_VENDOR, the reply arrives within 4 ms and is discarded, and every
retry fails the same way. The adapter is left down until the driver is
unbound and rebound, or power is removed.

Clear the flag wherever the last request is dropped, restoring the
invariant that req_skb is non-NULL exactly when HCI_CMD_PENDING is set.
Verified on hardware by forcing a command timeout: without this change
setup fails on every attempt, with it setup succeeds on the first.

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Abdelkader <iabdelka@qti.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b5897545d795..4d6ab5d39e94 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5448,6 +5448,7 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 		if (hdev->req_skb) {
 			kfree_skb(hdev->req_skb);
 			hdev->req_skb = NULL;
+			hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 		}
 
 		clear_bit(HCI_RUNNING, &hdev->flags);
@@ -5632,6 +5633,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	if (hdev->req_skb) {
 		kfree_skb(hdev->req_skb);
 		hdev->req_skb = NULL;
+		hci_dev_clear_flag(hdev, HCI_CMD_PENDING);
 	}
 
 	clear_bit(HCI_RUNNING, &hdev->flags);

