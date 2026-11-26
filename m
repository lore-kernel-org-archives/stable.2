Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705750;
	b=2XkJsioXHRxlRnEKi9V8IP2TserGoXpfs+Bz2FVuIgNLmRtVv+O4Zn9y0LtxMkMtKaB9
	 QYSPsdD+QA6GdXfZnErYxrfjFDdt/Q5D5jCCKcFb7bfUNVXRG33XUBCQ6d7x8BqziHh3R
	 Rs2cMOI9IslE0J3fntqVxtu6JdFnUMs/mybCE06nzwI/NxqS3jE+9hIYloa2M3pgSbnTN
	 Cmf+gSepLHEqpra84b1Owm3dxACcTk0SPEZ/cl74cc1M5dcT8FSJvsVLQgehWwa4xyLch
	 SFbzc6haie5xn95hplPdQBb4oq2w7pUkp3dsoszQc/kY9HUgjg+BkpQE8KF70LFZe2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705750;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A2ICbzFb+bJ39M63igcZXn6u2UnEfqBz8m7zceaMk3Q=;
	b=UHHUiZo1tviFBV/oMW9Fx0/JtP7ZjGs03/dVGd+5SkaIXv2z/hJdXBnZLxUeoulXMs6M
	 r1TXs0InbSJoM2M+25T3J9rRcwvwXpPoW8VSGYPJxvQ4E81Fw3LBehxZ/qVTx0ucWxYY0
	 9pXprll6Hxqk/4LwaR+4KuvbwZ2hsuzCGkucZW9wfkiwA8X2LOFydR/rM9FAUo2whvc+6
	 NaRv3rxg5Q5FM39CfW0iuEOs4IFatYLnuBhRY4oobvwjzLVQ8Wf7t96yblto+yA+XuTsj
	 rknlpnKeed4g0wp42k3RmfIcTzHJx6V7NtaoJoSi4VfF/xphfBNI7CLiyDNUaL2JAPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCy9bTP2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F4606A6A9
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCy9bTP2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5571F00A3C;
	Thu, 26 Nov 2026 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705750;
	bh=A2ICbzFb+bJ39M63igcZXn6u2UnEfqBz8m7zceaMk3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SCy9bTP2Mp1BnKzdCtu3wdokiTUaOE6I3GjoUoLQj2FHvS+ALzvmb3TIJwnO50rcQ
	 ffX9Q9ogOJexlzz3Rk2C08gmXM3JrLW6eO1PcnlVl28nE9Y/bbdN0lj7vuD7wVwf4B
	 exi46Ij/HUWIca1TWOLiy0hTxmE3Ql86rgKGJ0E3hyj3VdyTyY6lck7vS5+W7rC+pf
	 DtabZMhuo/+cPFMPBj3hEufmGWGP6ADOm7qDLGOHOMCFSB5ibsT2MHa6AFJlMfOq7/
	 RflqwdX/zGcBbJe0a83QDf7EaIR+HxyJy9wZyZpVds6Vr7NR3jnQiCtfooh6arBAUA
	 /GBJhidNcYfSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] misc: vmw_vmci: wait for callbacks in event unsubscribe
Date: Thu, 26 Nov 2026 10:09:06 -0500
Message-ID: <20261126150859.2240360-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126150859.2240360-1-sashal@kernel.org>
References: <2026112527-revert-unable-e720@gregkh>
 <20261126150859.2240360-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 824a27d391cf934d3232e8e2dabee221fc4e18ae ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/vmw_vmci/vmci_event.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 89ab9f05b88c5..dcfe639abcb5e 100644
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
-- 
2.53.0

