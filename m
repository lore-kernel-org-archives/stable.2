Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723980;
	b=IJ1+TaCi1hF+hvsQOcwfgi3RW3TQC7fxSWsm7w0zyX4Yzg/BhxMB5M6emWEXWdmswHzs
	 /mPAFQ4PkFLULG4BawaLHEskhnhYaJnf10chYJUeQtU0I6vba8Bx0bEsl7pDALXTFEogr
	 j/FxpXzMngA3akPOBw+Mm6sdc++aqGLKfyoB5XAJ9lmA5R9EuZGsSVWASHEzHmUkmR7Vi
	 o2QfvUGTVfLJYJtp533Oa0WAWb5PaxoAkUDxcidjbjml07UztPdlLGeQPQNCzOenmpkZP
	 KKaR+mDMVeE5viWDoMNesYWeAt53FM3tX1NyjpvSr64S/3Q37E3J4W3heU0UpUSACpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=twVdNlp2Xp2s3R4jnt9dwl/S/l2rHvkyAgM192PTLz0=;
	b=vYlZ3vmTishid7jG8rO/hPzEIQxmUqHpNH+VCGbaeMPh0O0+tGw8wlCq2zgMnzsFDkPu
	 au3k2liHH40d/mLbCjXVHKFRIUc/4Eh2gFR6PLPUCzvOxLO7BY2UFIAqBxjBUApAfbcYJ
	 Zb1cCRX3rOfsXZbh3RwFGbvpai0Vt/mmCXPwhlEZV1ZTFlnQvkMUfCC1Q8BKcDDjd2Okq
	 Tbq4FUW23+Fqo5nxFz7oyDE8CuKJ81lPGp0xE/laNLIEtKITYKK9GCfSiouo3YbGeMa8+
	 fLEcCZ7OkUwV2Zw+QWVUaSQgtdsid8Lb4PhcB4OgyA44UgYYqjd6dWFjv4Oq5+tZOVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D68T2+j6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456C3606EEB7
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D68T2+j6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C4D1F0093A;
	Tue,  3 Nov 2026 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723980;
	bh=twVdNlp2Xp2s3R4jnt9dwl/S/l2rHvkyAgM192PTLz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D68T2+j6x7LsphekoktZGMyA3+W33dQFYnkPNfg7ZKRXLzZi9zJoIduvcDpV5JaDZ
	 fdh9g/985YqVIdHWGJ4zshumHD//ZVC94E0Qbk48XjzmYpTp8RQ6wfMPCPSKSgtq6R
	 GwXK0/Z1iUG2ALkB4jZCA5zDBDX9aTy/pcbyzsje8ottSCLVTX45WjOBZvCjNFjBWt
	 /YceDPiYKhyZKUWvTla6N/rmtk1KMcV+JMTQiHCtJ/TG9eL/xUKG+1M38tSO91mlDF
	 TWM8FjxudqoNzMKhlDMlp8X5wgq+u2dsToBYRWWKiB6rrMZG61WOVoKW57GlHqI+9/
	 nxAUh22X0FBcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Koester <j.koester@act-marketing.de>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: ignore network devices of other namespaces
Date: Tue,  3 Nov 2026 11:39:38 -0500
Message-ID: <20261103163910.284897-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110346-accuracy-product-ad13@gregkh>
References: <2026110346-accuracy-product-ad13@gregkh>
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

From: Jan Koester <j.koester@act-marketing.de>

[ Upstream commit 1f5ce2b8b9164b3fcb93a18fe1e7b451c2fc6eea ]

With no interface list configured, ksmbd binds every interface that
comes up. ksmbd_netdev_event() does not look at the device's namespace,
and create_socket() opens the listener in the namespace of the task
raising NETDEV_UP. A container with its own address on a bridge brings
up its interface and finds port 445 in its namespace already taken by
ksmbd, so an SMB server running inside the container fails with
"Address already in use".

Interfaces are also matched by name only, so a container's eth0 going
down would stop the listener on the host's eth0.

Only handle netdev events for devices in init_net.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Koester <j.koester@act-marketing.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Adapted the patch to the older ksmbd implementation location. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_tcp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index c0a038666ec34..ac34fc15b0c13 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -514,6 +514,15 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 	struct interface *iface;
 	int ret, found = 0;
 
+	/*
+	 * ksmbd serves the initial namespace only. create_socket() listens in
+	 * the namespace of the task raising the event, so a container bringing
+	 * up its own interface would get a listener on its port 445, and the
+	 * name-only interface lookup would let its interfaces stop ours.
+	 */
+	if (!net_eq(dev_net(netdev), &init_net))
+		return NOTIFY_DONE;
+
 	switch (event) {
 	case NETDEV_UP:
 		if (netif_is_bridge_port(netdev))
-- 
2.53.0

