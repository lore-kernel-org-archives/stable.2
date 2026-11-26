Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665937;
	b=LDz+/PHHW4weaRDnzfAoLipKkKU4/CcmClJelSCGm6tg5seCzBKrRIKOT4EwE5kFGO+V
	 JdtdUDCiGa8oXLSwZnw6YqSBw9pthhHb/efP15teWALBXs7Dg5DwkRxmVSDWTZTZm2Z8o
	 /j7juF4XKCLIF/UMxexO3WqWDFiRZez296NUaSkVgYGSEEhRN2vdbZj0qhEY0RgmskLFw
	 SzVF6OZyY5X3MWuDxfgHW6kkVg7FoU5RGAwpSOpMPVFW5Xnits7fKYQ2ZsGnpmObRLl9A
	 mCbyrRQhwTWrMU5/9e6OSyyLHrUUtGwzCLPj3Wm6a3Ii0IsZONhqGouOphzw+kiqqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z0DcopaQEDCqlitse4NFvxqrmWxNAKTy3a3/XwlPu5c=;
	b=LLmZVObn/rAeS86deZfIYVwN0Dy6YoiJ8LpwIHLtBamMKlEwGOxWKOFDxv3whs+/LgOX
	 PiH2MchxVK/Dl988tu/5338Nz85cG57Y7sEdK6h2UG1dkZ/IoCEJFnuzhNT8QWITDLL90
	 1JzLuEdW0FHe0ljAWb3wL2OcFY+v1rgFn6B9+81hffvzx25nY6ljwTGehirHuI/ChZGb4
	 XqSDKpUZXPJ4/CXeo97DPUuO2DkVvS+tvEA70SPV18LDeVtQpPl6Z1DmJR3nykt/0Kl/U
	 MNlzcrE2ptXGqGNL8Z6y/jkosGuNreKGl3hDSEsyqx1rXK3wZ5YQ+9I/7X42RFqP8Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lh4tmEHt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1462606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lh4tmEHt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435BB1F000C4;
	Thu, 26 Nov 2026 04:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665936;
	bh=Z0DcopaQEDCqlitse4NFvxqrmWxNAKTy3a3/XwlPu5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lh4tmEHtB91+UaK9bu9GnybJkV8q8CVKLOqn0OgkUcUxpFhgaBl5FPKYA3zoD1F/0
	 2h3Fjr99HOQRwrf8XGFTtxfCB0aaRbqnyafP4YA/6S9VMeSuBC7c3r5fzPBvN/J46f
	 NtBzGmXeYHBD/5LfC7hnBS5kHaJG/ZFFfEKyc/GiBNxA2WBBg0axiK6WuHmohseG2i
	 fPzd2qFh35oSUdPagZyDExVxoMU4znQ7ncKLdL+32BzuF6bZNjabyX9rBi8uzqpuau
	 S1JidFbz8studwl86dNy2HLSf23aaAH9a83BYHD2lR/5q07K7kr1vBEhQ3xJv/ja4h
	 xkx9tUEQgRNYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] smb: client: hold server ref while queueing reconnect work
Date: Wed, 25 Nov 2026 23:05:34 -0500
Message-ID: <20261126040504.1872414-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126040504.1872414-1-sashal@kernel.org>
References: <2026112544-groin-automatic-abac@gregkh>
 <20261126040504.1872414-1-sashal@kernel.org>
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

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit f02d249e9756b78990aaaa1635e47e06deb2cb51 ]

When query_server_interfaces() returns -EOPNOTSUPP on a secondary
channel, smb2_reconnect() calls smb3_update_ses_channels() which for a
channel runs cifs_chan_skip_or_disable().  That clears the channel's
slot in the session and calls cifs_put_tcp_session(), which can drop
the last reference of the channel and tear it down.

smb2_reconnect() then falls through to skip_add_channels and queues
reconnect work on that server, using a server that may already be
freed.  The send path obtained the channel from cifs_pick_channel(),
which does not take a reference, so the session's channel reference is
the only one.

Take our own reference on the channel before calling
smb3_update_ses_channels() and drop it after the reconnect work has
been queued, so the channel cannot be freed while it is still used.

Fixes: f591062bdbf4 ("cifs: handle servers that still advertise multichannel after disabling")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Used cifs_chan_skip_or_disable() in place of smb3_update_ses_channels(), which doesn't exist in this tree, while keeping the same extra-reference locking and put as upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 01e582967df47..d0b1b4c430a78 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -219,9 +219,10 @@ static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server, bool from_reconnect)
 {
+	bool hold_server_ref = false;
 	struct cifs_ses *ses;
-	int xid;
 	int rc = 0;
+	int xid;
 
 	/*
 	 * SMB2s NegProt, SessSetup, Logoff do not have tcon yet so
@@ -439,6 +440,20 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 			 * treat this as server not supporting multichannel
 			 */
 
+			/*
+			 * If server is a secondary channel,
+			 * cifs_chan_skip_or_disable() called below may
+			 * drop its last reference, so hold our own
+			 * reference until the reconnect work below has
+			 * been queued.
+			 */
+			spin_lock(&cifs_tcp_ses_lock);
+			if (server->srv_count) {
+				server->srv_count++;
+				hold_server_ref = true;
+			}
+			spin_unlock(&cifs_tcp_ses_lock);
+
 			rc = cifs_chan_skip_or_disable(ses, server,
 						       from_reconnect);
 			goto skip_add_channels;
@@ -465,6 +480,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 
 	if (smb2_command != SMB2_INTERNAL_CMD)
 		cifs_queue_server_reconn(server);
+	if (hold_server_ref)
+		cifs_put_tcp_session(server, from_reconnect);
 
 	atomic_inc(&tconInfoReconnectCount);
 out:
-- 
2.53.0

