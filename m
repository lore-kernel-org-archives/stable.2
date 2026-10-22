Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686448;
	b=NpNo4NbxSjVDGarozvjo84q+oow25VgN8GLuceULUvOpXGY8beUT2FPgPIocdFrdSE4o
	 +OqjPYbFNECkAijO1zH9v18cMdrH9WEpDV41GUtzBxx83ZGjvJKCWLyZ3ruP6hDh2lZ62
	 hU5rrCGNK3GwNevTUOIOCCVzMllIrW+eY38WvY0sx08BMhroSK9DeiFgYxgSbcFuthMdz
	 6zulhb7G9AK4b6/qW+je/nPmqzrHC5hHic2AQjDRNnKidAZRuGloR7yCuBjUNSa064d1R
	 q0LT7AIGP9+1QBNtcXjXPx4goBUc08VErrcbVIVqfsxHFuelGf458JLFa3PqhWaKs1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0kEZM8sNAspVPW2vb+/MfnX8dDWw+ByilqZzMDa2qIc=;
	b=0ERDMDhLRobxl/1e5qiFlSLQ/deUMu63dvIZ8vBDp+wqhl77ZmVvjCFeFRk2tFQOWHFN
	 DyjvrSQoQA0zMMGOfw4yoG/z3ESZBNFCC7OBQv93xqf7HuMoyk6tX7fsroTkgtUR7K8MD
	 ozueK4DlMghqWrxtcnVErqK7QIRl7T+Em9enbmAfY9Yl/vz6BzFdtkMwDvKbnQfUz93PO
	 6JSoVbNt3jh/NvKq9F1U0U0M84xso7bBiBcxlJoTriiqa6H1tD4+PDfcy4OEKeUCA9r96
	 wLGFHiyvM4U+Dflb+ouwui+iLo/iG5KCOXLSePpPeQO6i1M39LqCKObEHYlwSUWmw9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wn1+trwK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8385606A32A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wn1+trwK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DE71F01825;
	Thu, 22 Oct 2026 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792686447;
	bh=0kEZM8sNAspVPW2vb+/MfnX8dDWw+ByilqZzMDa2qIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wn1+trwKjy703cuPVzRQUe69bSmJVnasbY719M7Y2YSDPs8doFWn7Ke8Hij6Lt0S4
	 Y5WhCc0VERFDGZKvshb+NxnBkWH4xauTSXDeTEK0hfMVGQLm2TX6flu3iOHNKP4Ky/
	 akGmkR3LKzGhIddelVOwRJSLafuLBqgEa8iV1ZvlJiXJxyaX/XIhfcEb6573bo8FAi
	 jW49Fn7dPkmQs6qVnty3EPSG5zBqfSRIcwDjoGQ6y/taUK5ZIj98/kCmosKLd4GMp4
	 XKa2GPjCXyeRJjxfURKMihJv4RSodUHM8WA/HEc3hvpOIJ3LKYjT1xw1f8rBsvZoDg
	 VRhosoLeyo1Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] virtio: set skb owner of virtio_transport_reset_no_sock() reply
Date: Thu, 22 Oct 2026 12:27:23 -0400
Message-ID: <20261022162527.1685626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102109-rival-yin-0759@gregkh>
References: <2026102109-rival-yin-0759@gregkh>
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
index 829feae9c0e08..c08fa44384b4d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1312,6 +1312,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
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

