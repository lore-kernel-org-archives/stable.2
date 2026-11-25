Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608336;
	b=jgM/jlIvRps2zFVLEsfg3K5CfzORJLGcMBNOOcz5BnM27TuQu+ECtyy1uD6zYvN4Q+DY
	 fJCBM4l6UPGKM8IBF7fH28n2BfcyFK5/XgT0An0OdNp1mRNAPSp4LDnmYOZaO1Vv6lSkI
	 UHEcrM41vBi/kEDPJzARJeyw4VLvcNsvZ+09FqF/ow4UfH1iKBL4ePJfWUkujD4aKzLb/
	 bp0tKE8t++SWYrkaS26oGXBqNYKAqjC+gXwBknR1JFkdfJkl0BUrahcwHPaq5YOyQAosL
	 i5ugBh0yqQDrfdgL3M3KEwGezpwgYt8+rFignyYg8CbLMAx89Q0UhBHMjUcIon8SmMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608336;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ULrmB807K+I0RW/jCrM8JoZYDtHTAfcVfQdIvt4TMSM=;
	b=49d8kFqrXl/48pYrGc1IUNpf0ba2YT1D22YJHAJH7wWUY55ozpTK7zZkqRnQzs6TCZwD
	 LqEoH0Do1gNBk/LZsqYY39AGJ4wWeMXnnxZK0zUebjYBce/Qj4x1ZsUuwk0fY+esUnHb8
	 7M31T1kwZGIQ1nDSaadbwnx7uDmOZyvmddWjKBTb78MduR1KdG+NpjNsc+8trppDHPHWb
	 nkJz28Ik3+vz4y4EYQTrfs7kjoSU0a5qcdX8oOygosJA1gPIGC8c8sRguz+PErm1rPvWV
	 09oaGHnpK1De4se9tPsjclHB4joRoJoXwe6ujugw7W5hdjj4mNgjuvNXRok1qZleBOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=viTCGKdP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F0606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=viTCGKdP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B461F000C4;
	Wed, 25 Nov 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608335;
	bh=ULrmB807K+I0RW/jCrM8JoZYDtHTAfcVfQdIvt4TMSM=;
	h=Subject:To:Cc:From:Date;
	b=viTCGKdPonEEfXfcKuDiTg51wRxUvsgn/UNkqvn4WJrFGoJGvxRUgCUnhfHnEsCDy
	 8oL6gAV2bT0f7r1RpJ/xzk9+7s8y3NpSclFmAB30J48hLm5Xdg2l4YKXzGt/v9NoW8
	 vtL2eBHn7aaowV9rj/Qrl8veS15Cf6ZI4jofR9k8=
Subject: FAILED: patch "[PATCH] misc: vmw_vmci: wait for callbacks in event unsubscribe" failed to apply to 6.1-stable tree
To: josef@toxicpanda.com,arnd@arndb.de,bcm-kernel-feedback-list@broadcom.com,bryan-bt.tan@broadcom.com,gregkh@linuxfoundation.org,stable@kernel.org,vishnu.dasa@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:30:27 +0100
Message-ID: <2026112527-revert-unable-e720@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 824a27d391cf934d3232e8e2dabee221fc4e18ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112527-revert-unable-e720@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 824a27d391cf934d3232e8e2dabee221fc4e18ae Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 17:58:16 +0100
Subject: [PATCH] misc: vmw_vmci: wait for callbacks in event unsubscribe

event_deliver() calls the callbacks of the subscribers inside an RCU read
side critical section. vmci_event_unsubscribe() used to call
synchronize_rcu() before it freed the subscription. This did more than
to protect the struct vmci_subscription: when the function returned, no
callback was running any more, and its callers rely on that.

vmci_transport_free_resources() unsubscribes from
VMCI_EVENT_QP_PEER_DETACH and frees the struct vmci_transport, which is
the callback data, a few lines later:

  CPU0                                CPU1
  event_deliver()
    rcu_read_lock()
    vmci_transport_peer_detach_cb()
                                      vmci_event_unsubscribe()
                                        list_del_rcu(&s->node)
                                        kvfree_rcu_mightsleep(s)
                                      kfree(transport)
      spin_lock_bh(&trans->lock)

The event is sent when the peer of the queue pair detaches, so the other
end of a vsock connection chooses the time. vmci_transport_exit() and
vmci_guest_remove_device() unsubscribe callbacks which are gone with
their module.

kvfree_rcu_mightsleep() only waits for a grace period if it cannot
allocate memory. Bring the synchronize_rcu() back. The cleanup work of
the vmci transport now waits for one grace period per socket again.

Fixes: 6da3f33770e0 ("misc: vmw_vmci: Switch to kvfree_rcu() API")
Cc: stable <stable@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Link: https://patch.msgid.link/2026102715-escapable-quaintly-8530@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index c3ef3b98c432..57d3a63678ac 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -213,7 +213,12 @@ int vmci_event_unsubscribe(u32 sub_id)
 	if (!s)
 		return VMCI_ERROR_NOT_FOUND;
 
-	kvfree_rcu_mightsleep(s);
+	/*
+	 * Wait for event_deliver(): the caller is going to free what the
+	 * callback works on.
+	 */
+	synchronize_rcu();
+	kfree(s);
 
 	return VMCI_SUCCESS;
 }

