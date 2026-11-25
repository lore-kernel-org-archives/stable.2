Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622661;
	b=fc3PdlBq9u6lw/3/pyWTEQz0PsEKr+FTGt4ecWeULNjdWiehctrF7KmzvFy+xQzhJsbp
	 UL9dlsS2mU5Gba3iWe+ymA5hEhdIPTzbgH3fF0eseCd2U/LBBFtxCGG3d4JQigNkL7Zt6
	 4ISJh2quhDcT7YaLf7ZL/6wFenbhYeK+QyvxfF/fW3oRR1YhGQV7LzK/t23tEmFLqc3Yl
	 i/OquhlArcWBszUEosctZYpwYiy0XMskW/RHmbmRFqb9JiiJsHaK3n9kI95smi734Mlgn
	 IW6OhnmIAmAtXMPssFps/MV4gXwd25JB+Mn6WfVL/W7k1D5sP+OLOMJBt8KUDooNIIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622661;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JcxXU1kD3orn7ry7t4JcJShKm3OQYTUQl3q4foQ3n/Y=;
	b=PYP6u3FqLSl8/dxZIrBCLMs1euEZjEe4chyum30NvUXdb9BcgIoGkWDhI/Xp1urnhR+j
	 vQgOszVePcBDvxEBd6XEInsIowtIf9VoK4WEPlT651S2B6sOhN6CbBw8ZYvhuep3HFZnJ
	 ePSQGcs/mtLNw0A6cmq3RA4qCHhUGxPHcR9veg7kcloHLrzrpnYbcjaF4LjXHUHi9mxNw
	 2hajU8LjMWE63nr5Y5ISZWy88HYzCfK/oqfsEgg2kU6+XfJWnOxxYqieKum5iHOLN7MNk
	 ven7YMDz15hEkxOLmA55OA6K2gPengWLIz9F+RtUj4P8lKevBz0+aPZTLmwyi9+JQ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNe+2vW6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB06606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNe+2vW6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195211F0093C;
	Wed, 25 Nov 2026 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622660;
	bh=JcxXU1kD3orn7ry7t4JcJShKm3OQYTUQl3q4foQ3n/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNe+2vW6jY38m+YP3DGzeE0E1R7zWon4/1bLByNz7pj1+cUCEt57XWIMHQUBvQYdI
	 8/x7J3g9NBnfrVLXbPnG6HnLzbBkcFYViCwqpeE5u54NJj9OR/++G8seNYRcS84fg3
	 pZbnheTA6/Wwb0Svw3hVDJK4cbZYxDVcen2tcTqnWyjU9hNaov00LVQrtPDYSMbGU8
	 ijDZY1DxN7edVIfCWqMsJd7vl19N2Y0VInJQiBSIopojwTn1137YAwTycvxROT6igz
	 xeRDeBoYpDSsS5tRf6IFRv5QG+vTOAbtkXz65Gt7iNP4RkRFRJrzvg7ywu8sZWooRS
	 WYxPF29rUH0hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel
Date: Wed, 25 Nov 2026 11:04:18 -0500
Message-ID: <20261125160353.661133-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-dividers-waged-68f2@gregkh>
References: <2026112510-dividers-waged-68f2@gregkh>
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

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit 1f2ac56137c51be0601e18a163d817e02a15913f ]

Reading buffered ERTM data after ACL link loss can clear local busy and
send a supervisory frame after l2cap_conn_del() has destroyed the HCI
channel, which oopses on a NULL pointer in hci_send_acl(). The socket still
owns its L2CAP channel, so its lifetime does not protect the underlying HCI
channel.

Require BT_CONNECTED before clearing local busy in recvmsg. The socket lock
already held here serializes this check and send with teardown, which
closes the socket before the HCI channel is destroyed. Continue to allow
buffered data to be read after disconnection.

AI assistance was used.

Fixes: 61aa4f5b9f43 ("Bluetooth: Use the transmit state machine for busy state changes")
Cc: stable@vger.kernel.org # needs adjustments for 5.15
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ sashal: Moved the sk->sk_state == BT_CONNECTED check onto the atomic_read(&sk->sk_rmem_alloc) condition guarding l2cap_chan_busy(), since the test_bit(CONN_LOCAL_BUSY) line it was meant to precede doesn't exist there. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3beb6e5a27cc0..a69b0747ad9b9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1260,7 +1260,8 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
+	if (sk->sk_state == BT_CONNECTED &&
+	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 
 done:
-- 
2.53.0

