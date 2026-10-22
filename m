Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689102;
	b=Nrspv5Z3dq+e7ZmvxJFma7j/u60NPip+mv/6L8PBbvW452WGto3Uxjpy7FD/DSPD/bnr
	 /2pu3Oi6gE2QL1n4joJ77NHKRCMdaykxkdOj5TTaG9oi202J4ywSk83tN9N3sKILtQ4MM
	 T2iSuQV4DiJuQ3ZUaaWHj9BKaalpzEd64GWkPGgyvCBlO2WgYOyrIBVoTHewvYlSAdDzo
	 JXeLLPHJFnt9+xjwRWo4zDaho2PBe7q440CliEeLIUvHxiFmh67BtqVk+sLwnfvQ9fcgc
	 fxatGJJRAemW/3Gyrl1OyAEz9SoYic0dWktzun58GaNDnmdV0GzlDvDqoYQjfWP/Hkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0AtrglWi2mDOVzLI9X9mrlQJAAF7GctMgsck1q4Ouiw=;
	b=tAtnLB2eGSUkTgPg+yEF2jbZGWTJj6DAMe6f4uTmLXugfqLDFq7mUf6+N/DnL/5BPmwz
	 AguvzLK6KHLU5XuHmsU8fr4Q5ApQl0woQhf+y3Inqz9TBq0TNptU7FvNmb3dY+dIIEzQ+
	 H6cCWnl9rQ9ucSQVlcjjoJ0sMAamvYL/KXy/4ZBeLp87Lu1u05G8ZQj3RJwt40RwsJiTQ
	 nd8Ys+Er5GrIVScYUOh8Zd9Eu0V4YAtsV9E1Vn03v2mw3YnoyqCFTOF3NnN+B1BLyCTsS
	 wiy/+BluXFCsqWhPczO9X5c/ux6ZDHlkjG33zjySXCCNQC3WsAdlFaX7TWwvtadTzWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYIG3hzd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C3E606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYIG3hzd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B151F01825;
	Thu, 22 Oct 2026 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689101;
	bh=0AtrglWi2mDOVzLI9X9mrlQJAAF7GctMgsck1q4Ouiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYIG3hzdhYmvuTbTEPxlGSycGXijIC4ZYKH9FIGr5rNNWiTQ+UM30pTBt7ymuEt3N
	 ImEcahLDK2nToXvNRTZ5dpbItEkXZ3itpoMBb9P1jSmlr/GJNCktqI9R5MefIX98v2
	 d8JsTsfYuOrtu7WgVpjjgqX20QT1g9OoEIMfx50LmTLmal6TWAS90Z7mJZhDvPum0y
	 x3H6AzHBmWtIFX7Ds2vKojBDCxoJNIRkCJwjHQQ+QfJ88MG2jTENq9fFeTNFVuItO4
	 8j1NL+jUAw6mOzdO7OQYDFXMFn1g3V9snk4cMajCRA3jn0N2kUBbDy7vbKrpmWhHJE
	 RTx52m1eeGlqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] virtio: set skb owner of virtio_transport_reset_no_sock() reply
Date: Thu, 22 Oct 2026 13:11:38 -0400
Message-ID: <20261022170952.1760451-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102110-finalize-subpar-d30e@gregkh>
References: <2026102110-finalize-subpar-d30e@gregkh>
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

[ Upstream commit a6ae12a599e0f16bc01a38bcfe8d0278a26b5ee0 ]

Associate reply packets with the sending socket. When vsock must reply
with an RST packet and there exists a sending socket (e.g., for
loopback), setting the skb owner to the socket correctly handles
reference counting between the skb and sk (i.e., the sk stays alive
until the skb is freed).

This allows the net namespace to be used for socket lookups for the
duration of the reply skb's lifetime, preventing race conditions between
the namespace lifecycle and vsock socket search using the namespace
pointer.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Link: https://patch.msgid.link/20260121-vsock-vmtest-v16-2-2859a7512097@meta.com
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: dee44f41f206 ("vsock/virtio: validate packet source for connected sockets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8552173aafe16..75df280bcc81f 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1313,6 +1313,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 
-- 
2.53.0

