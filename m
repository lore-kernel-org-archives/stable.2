Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB04B2CC2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444946; cv=none; b=oXEd8a3slXwy9uJewVF6melE5rc8na2fMLjPNoXSkU6OpAamSm9SABig1ksn/eOQ+Ni8jdzIufKWzkatmZMtjHzWq/m+LWgNvpsniemnEMRmyA4gJ4okq4nWOI6rFs4eMcSeYk73uh3THc++Ux5vdh4T6eua4oWn9WkLoAf7x14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444946; c=relaxed/simple;
	bh=URWsQI1MfVyDQmfrPm40dfNfroKIxeVXz+2Uk/wxcAc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=B/ocj+2AuoHBDQLkFFHH4DV9n/0XYQVJRdhPHiCa6C4dmVXFAS26lOf1r0tiVB/aNE5XtB7HdOHLZSKhch8K3ncmbTaw04WAzC6GbzTcFjTOBiYdwGjXjLhWdnlN/p7QqHg9AhdeUch6+q7JETCpsHyf/jnxcIVdzeL2VcPj6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LB4B+tBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LB4B+tBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF74E1F00A3F;
	Thu,  3 Sep 2026 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444929;
	bh=klQ5AwPdzejipvhBMB4Lw9cD8zGQHEukzDqpb2T3LuQ=;
	h=Subject:To:Cc:From:Date;
	b=LB4B+tBXZs4M2iHaarDeOFY44w3yk3Z3YNI4lXO9CKPt7N835Ckdy6WKNuA4yoWiX
	 K9ahG5EFV9MyGD+eCYeI9ZmRClMJRbfAgSu5VgJrYJqIEbQXz2BSkYM0dHcyAucH8V
	 wl3mNgq32dyFHYQjhPVfjDNoTA7OFOgxyVgVrpaE=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_core: use skb_get() instead of skb_clone() for" failed to apply to 6.1-stable tree
To: xin.chen2@oss.qualcomm.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:55:31 +0200
Message-ID: <2026090331-cheddar-preheated-6153@gregkh>
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
git cherry-pick -x f5afdff569a09d1cb8cf19826199d024725576cb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090331-cheddar-preheated-6153@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5afdff569a09d1cb8cf19826199d024725576cb Mon Sep 17 00:00:00 2001
From: Xin Chen <xin.chen2@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 21:53:21 +0800
Subject: [PATCH] Bluetooth: hci_core: use skb_get() instead of skb_clone() for
 req_skb

BT enable fails intermittently with -ETIMEDOUT (-110).  The kernel log
shows the HCI Read Local Version command was sent and the firmware
replied with status 0x00 (logged by hci_req_cmd_complete() BT_DBG),
but the waiter in __hci_cmd_sync_sk() never woke up and timed out
after 10 s:

  bluetooth hci0: Opcode 0xfc00              // __hci_cmd_sync_sk
  bluetooth hci0: opcode 0xfc00 plen 1       // hci_cmd_sync_add
  bluetooth hci0: skb len 4                  // hci_cmd_sync_alloc
  bluetooth hci0: length 1                   // hci_req_sync_run
  Bluetooth: hci0 cmd_cnt 1 cmd queued 1     // hci_cmd_work
  Bluetooth: hci0 type 1 len 4               // hci_send_frame
  Bluetooth: opcode 0xfc00 status 0x00       // hci_req_cmd_complete
  <-- req_skb NULL: req_complete_skb not set,
      hci_cmd_sync_complete() never called,
      req_status stays HCI_REQ_PEND            -->
  <-- 10 s later: wait_event_interruptible_timeout expires -->
  bluetooth hci0: end: err -110              // __hci_cmd_sync_sk

The root cause is that hci_send_cmd_sync() clones the sent command
into hdev->req_skb so that hci_req_cmd_complete() can locate the
registered completion callback.  Under memory pressure this
skb_clone() fails, leaving hdev->req_skb NULL.  The firmware reply
is received and processed, but hci_req_cmd_complete() finds NULL
req_skb, so hci_cmd_sync_complete() is never called, req_status
stays HCI_REQ_PEND, and the waiter times out with -ETIMEDOUT.

req_skb is only used to read bt_cb(skb)->hci callbacks and opcode --
it is never modified.  Replace skb_clone() with skb_get(), which
simply increments the reference count of hdev->sent_cmd without
allocating new memory and therefore cannot fail.

This issue was first observed as a use-after-free in ttyport_close()
when ttyport_open() failed, which was investigated in an earlier
patch series [1].  That investigation led to the discovery of the
true root cause described above.

[1] https://lore.kernel.org/all/20250430111617.1151390-1-quic_cxin@quicinc.com/

Fixes: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Cc: stable@vger.kernel.org
Signed-off-by: Xin Chen <xin.chen2@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 509c820a693d..35a1be57e386 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4093,7 +4093,7 @@ static int hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 	if (READ_ONCE(hdev->req_status) == HCI_REQ_PEND &&
 	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
 		kfree_skb(hdev->req_skb);
-		hdev->req_skb = skb_clone(hdev->sent_cmd, GFP_KERNEL);
+		hdev->req_skb = skb_get(hdev->sent_cmd);
 	}
 
 	return err;

