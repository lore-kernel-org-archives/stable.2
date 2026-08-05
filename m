Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6443FCB1F
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922716; cv=none; b=iXZXdBCjk9QBjM3NoZtFvSQacWFNsHmjv96gASnuM/qUGcC4LTfFScxzWUWy3Caoz8VkcXTFLRfUNo1rO3/Nnpsl5RgyUrVRf860syeQuRSvDUK08r7Z9Lz1hUvEK9dP1u3nBnfTiPE0KCwWDsKGnRlZC5/yULgm7VA09WpO0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922716; c=relaxed/simple;
	bh=+tHYPXYUsu5Cjorb+4IDu4mWcO8ADOcYTbHzc1y46t0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aUJb2HCUonZeY9Kwfo2cMlYTu8urxIJ2Tpf9rqF0VGFhY4ZKdwEeHP3OTTm3p8zzPmt0rRp7HiPWGqQLP1EcU5rPQa6WOU07HyI5vI3wjpDbmPYIHn5nfYNRbM3eJJVppfW6j7KmP2oc+I+/D3ISq2HWfBjKitf0bHHrkSCvvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1blwWjcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1blwWjcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077E31F000E9;
	Wed,  5 Aug 2026 09:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922714;
	bh=b0S3WPoHjhE4ey8vSr30EVmkM9RW3Wq5QAUo6cPwlgQ=;
	h=Subject:To:Cc:From:Date;
	b=1blwWjcdiCQZiQREHJQQvffmUFWCFMmwhiCavZKLg8tadCLJt74gNw47S9Vydqvzv
	 ugEbiVbJH7/3xjhLyToF7+uZkOOLsp4pyFt5LvZ5Ap4gDHcxt+jCHc9ZNv3y5LhOZX
	 6fOXZO7obqWMHVE2Lg2+pdQvR2sjoq5+oDXfm+xg=
Subject: FAILED: patch "[PATCH] Bluetooth: HIDP: reject frames without a transaction header" failed to apply to 5.10-stable tree
To: kudo3228@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:38:16 +0200
Message-ID: <2026080515-broadness-backlash-dde1@gregkh>
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
git cherry-pick -x 47778d2c2087b5d192398f6fddf692d16a5431cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080515-broadness-backlash-dde1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 47778d2c2087b5d192398f6fddf692d16a5431cf Mon Sep 17 00:00:00 2001
From: Sangho Lee <kudo3228@gmail.com>
Date: Thu, 23 Jul 2026 12:28:06 +0900
Subject: [PATCH] Bluetooth: HIDP: reject frames without a transaction header

hidp_recv_ctrl_frame() and hidp_recv_intr_frame() read skb->data[0]
before checking that the L2CAP SDU contains a transaction header. A
connected HIDP peer can send an empty basic-mode SDU and make both paths
use an uninitialized byte from skb tailroom.

KMSAN reports the use in hidp_session_run(), with the uninitialized value
originating in __alloc_skb() through vhci_write(). The control path
produces two reports and the interrupt path produces one.

The byte can also be controlled by a malformed lower-layer packet. If an
HCI ACL packet contains an L2CAP PDU with a declared zero-length payload
followed by an extra 0x15 byte, l2cap_recv_acldata() reduces skb->len to
the declared PDU length before dispatch. The current HIDP path nevertheless
consumes the extra byte as HIDP_TRANS_HID_CONTROL |
HIDP_CTRL_VIRTUAL_CABLE_UNPLUG and terminates the HIDP session. With this
change, the same packet is discarded and a subsequent feature report
request succeeds.

Pull the transaction header with skb_pull_data() and discard frames that
do not contain it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 0e24c5e2955e..194208d03d18 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -560,16 +560,18 @@ static int hidp_process_data(struct hidp_session *session, struct sk_buff *skb,
 static void hidp_recv_ctrl_frame(struct hidp_session *session,
 					struct sk_buff *skb)
 {
-	unsigned char hdr, type, param;
+	unsigned char type, param;
+	u8 *hdr;
 	int free_skb = 1;
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	type = hdr & HIDP_HEADER_TRANS_MASK;
-	param = hdr & HIDP_HEADER_PARAM_MASK;
+	type = *hdr & HIDP_HEADER_TRANS_MASK;
+	param = *hdr & HIDP_HEADER_PARAM_MASK;
 
 	switch (type) {
 	case HIDP_TRANS_HANDSHAKE:
@@ -590,6 +592,7 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 		break;
 	}
 
+free:
 	if (free_skb)
 		kfree_skb(skb);
 }
@@ -597,14 +600,15 @@ static void hidp_recv_ctrl_frame(struct hidp_session *session,
 static void hidp_recv_intr_frame(struct hidp_session *session,
 				struct sk_buff *skb)
 {
-	unsigned char hdr;
+	u8 *hdr;
 
 	BT_DBG("session %p skb %p len %u", session, skb, skb->len);
 
-	hdr = skb->data[0];
-	skb_pull(skb, 1);
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		goto free;
 
-	if (hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
+	if (*hdr == (HIDP_TRANS_DATA | HIDP_DATA_RTYPE_INPUT)) {
 		hidp_set_timer(session);
 
 		if (session->input)
@@ -616,9 +620,10 @@ static void hidp_recv_intr_frame(struct hidp_session *session,
 			BT_DBG("report len %d", skb->len);
 		}
 	} else {
-		BT_DBG("Unsupported protocol header 0x%02x", hdr);
+		BT_DBG("Unsupported protocol header 0x%02x", *hdr);
 	}
 
+free:
 	kfree_skb(skb);
 }
 

