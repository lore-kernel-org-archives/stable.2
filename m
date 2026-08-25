Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1B471422
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663882; cv=none; b=N4n0rQNwkwagdDPG3/XfVIIuj1cy+4+eXUErEcM7vqXu3J0fr29bHXU9VXyX7tb6gI7sr7NRCvQv/8UwH0DMi3rH0ZHCQchn9Yn2uo+Xsx2jW0/QliaRCyCiCHCb7Vwar1kUWPsIoHuKWWnBIQLnpxC4AM/oF4ubh2ZWQ7yCp1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663882; c=relaxed/simple;
	bh=XIWiFPVGE4kn7NML4VM6+DWLgPHE2KpMcmOLq6D8WqQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Op1VdRzYRbYJk0VwwqZ6R/HI8Mfbg/CjXkIYAbTc4ED4R1Jede+alSG+1RAC/9iG/APhFZXvR29jFsK7vszk+uI/NKt8qjuhFHoLEh5JYZZGSsW6Bz3WCtWVDPs8KqfkSP411MiCNycK2szBl76KTZZ+ngrwW6tPQsn7ev3U0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bwydu8II; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bwydu8II"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE671F00A3A;
	Tue, 25 Aug 2026 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663880;
	bh=shm9vB1XfOL2F/S89ij9ehO8G+CGH6ynS0wzTy0+UP4=;
	h=Subject:To:Cc:From:Date;
	b=Bwydu8IIvtrzqz5jPMITM8JH9LoKdOoLkVveFrt0BI/vC9mwb5ZzArAHN8t2NbGQV
	 h1dTq+KRn2JKYYZAh0L9m3NzsK6Y1H7tya68ZImnT0tjnI/dMVQCvXAYRp1tQygxZK
	 ZompBTlRTdtQeUV8TCuNVT14q6nfeS6qR4WAiZkY=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_event: fix LE list UAF on reset" failed to apply to 5.10-stable tree
To: nicoyip.dev@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:17:46 +0200
Message-ID: <2026082545-dallying-heroism-f09c@gregkh>
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
git cherry-pick -x 33af47e847fe4a28b109673affb5874015d54f5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082545-dallying-heroism-f09c@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33af47e847fe4a28b109673affb5874015d54f5a Mon Sep 17 00:00:00 2001
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 30 Jul 2026 16:32:02 +0800
Subject: [PATCH] Bluetooth: hci_event: fix LE list UAF on reset

hci_cc_reset() clears the LE accept and resolving lists without taking
hdev->lock. Other command-complete handlers serialize updates to these
lists with that lock, and the debugfs readers hold it while walking them.

This permits the reset completion and a debugfs read to interleave as
follows:

  hci_rx_work                 debugfs reader
  -----------                 --------------
                              lock hdev->lock
                              fetch current entry
  list_del(entry)
  kfree(entry)
                              read entry fields

The reader then dereferences a freed list entry and may follow its stale
next pointer.

KASAN reported:

  BUG: KASAN: slab-use-after-free in white_list_show+0x15f/0x180
  Read of size 1 at addr ffff8881015dab16 by task poc/95

  Call Trace:
   white_list_show+0x15f/0x180
   seq_read_iter+0x3ff/0x1190
   seq_read+0x267/0x3d0
   vfs_read+0x177/0xa20
   ksys_read+0xf7/0x1c0

  Allocated by task 91:
   hci_bdaddr_list_add+0x1a6/0x3a0
   hci_cc_le_add_to_accept_list+0xab/0x140
   hci_cmd_complete_evt+0x26c/0x9a0
   hci_event_packet+0x454/0xb20
   hci_rx_work+0x293/0x730

  Freed by task 90:
   kfree+0x131/0x3c0
   hci_bdaddr_list_clear+0xd8/0x160
   hci_cc_reset+0x28a/0x370
   hci_cmd_complete_evt+0x26c/0x9a0
   hci_event_packet+0x454/0xb20
   hci_rx_work+0x293/0x730

Take hdev->lock around both list clears. This matches the existing
mutation and traversal locking convention.

Fixes: a4d5504d5c39 ("Bluetooth: Clear LE white list when resetting controller")
Fixes: cfdb0c2d095a ("Bluetooth: Store Resolv list size")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9764efb9e293..9c8bf6708356 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -297,8 +297,10 @@ static u8 hci_cc_reset(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 
 	hdev->ssp_debug_mode = 0;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->le_accept_list);
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }

