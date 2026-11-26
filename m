Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667009;
	b=A5Vu8Me3ydSKKusqQO0jo8n78Qw6PTkd3tUatviJ8EsvIwBIAwOmIWo6cQrEf3pZsz3V
	 jjygys2yW6bfX5F4xGHX7/WsMtl5uoUzI49uKtX11mNjeca30xeCZtCngZ33uMmeXfD8f
	 xsrPoJKwooVz2t9fadcG/lJmrXYxPx20RpfLuihiAHwBxVGohsT7fRWU2N91eOt2dXANn
	 HLurBo6NdKA9XhST7tganJ9s5Gs2QeNoFsj3g61eXk3qzEHrOaZHehU7Vh0A8OVF8Ml+a
	 WrOIJw/CvizMoRuR4qd6QBXG4GZj+M6U2QzvoMy65WiVA1VoA26cfLEIXV1gAm2+KeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+tQAa2A/g4fm+pJHMw/qK3Gpu5W9/tblSuCMwBkk44E=;
	b=4+ILBd1yGHdEpwe9WN80EpIRpk597TMUGMdUieFXrCAzD7Az1LYVAQKkqFXczyRZI7KD
	 /S2UbF+fsZ8nMiep8Xu9c1eP7L+3FZDYodhUNmPvgrbQFRhF5JuOopOwIVH4Vr/3X/u02
	 sQH86clf21PV3jokngynpU9EadgzO3CKCElWSesyvI8FgKQo48/OBBxmyD1ux93lpF3L9
	 RAeD7D+8ucgKpQsND+O43NaL9+Wkack88EuHxlC+zxvZJhbgzHYCsGCRqoCyE2H5G1LEe
	 NkY43bZm3tqrwd7UCMN+mtWd/wcnKWIdoSXZqTUgc1iEexpX5fuAvYRv/wYafwt7c9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igelRMSw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18176606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igelRMSw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38EA1F000C4;
	Thu, 26 Nov 2026 04:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667008;
	bh=+tQAa2A/g4fm+pJHMw/qK3Gpu5W9/tblSuCMwBkk44E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igelRMSwS8omJRi5ywfTuWppo4NvHXyG1/DFRGLaysmu3gQ4JYwodV9SimPqJj6CK
	 +etaJIWi+m6BgZaw8GLFVaQSWDGI31a4ETZjaMF5GMeRb3n7xqE1EeUaZ3mYyKToOG
	 U7ofhAz1pl8pXTTurB4Mw45WVLnIaLyDXzJ3Vl4gf63l1G4vyLnf/HhUf5oRaFlZYj
	 hAkWRPKzXvK2nNDCytrg8ddcfVXHEX9WXIUKNFqAIO9LkgJlHa2VHA81KXI08pPjgu
	 Zh9caYtmgHjV5YCnmzhVc4Ty0fQdoupvU8uEje6J1G67TnbY2z6yqNwYBdKw/x/K10
	 kTlrSLRcBhmiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: hold server ref while queueing reconnect work
Date: Wed, 25 Nov 2026 23:23:26 -0500
Message-ID: <20261126042228.1925097-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-unlovely-trapped-6193@gregkh>
References: <2026112545-unlovely-trapped-6193@gregkh>
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
[ sashal: Replaced the upstream smb3_update_ses_channels() and cifs_queue_server_reconn() calls with this tree's cifs_chan_skip_or_disable() and mod_delayed_work(), and left the local declaration context unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a92226e3e6e9b..4ab53b398721b 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -217,6 +217,7 @@ static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server, bool from_reconnect)
 {
+	bool hold_server_ref = false;
 	int rc = 0;
 	struct nls_table *nls_codepage = NULL;
 	struct cifs_ses *ses;
@@ -455,6 +456,20 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
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
@@ -481,6 +496,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 
 	if (smb2_command != SMB2_INTERNAL_CMD)
 		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
+	if (hold_server_ref)
+		cifs_put_tcp_session(server, from_reconnect);
 
 	atomic_inc(&tconInfoReconnectCount);
 out:
-- 
2.53.0

