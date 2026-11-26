Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667270;
	b=pRKXSZU4fTFgx/X6TTK9Z1HWAMOoaihjJAujLLqKl6UAiCnuCE1+ZYSZxx7a4UMGUlVA
	 Dfc1UQLjFQOXzzOwzNOSkidpdf/e/F3S1jZ+11XL8N0k1/VsPKd+mipTESlU/lz7zlVb5
	 0G3VgoDcFuH3WQxe6g6KDkig6lUc1Yc7FaY/WcyY8Evy4fum/SG6t0hrkWJELjrr0E/Qw
	 NPGSnCYusQWzdgWOATnJLZSzwjCY4Ur4EYEiF1VhIcAcnVh/ogzj7DJqkDuDLc19volV9
	 VnFtNITIyJTzs4P5+2MJRJ4bsuY+XTL/11sudh08B78yd8jTbbPXhKbVeL7qiAWTmDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FBbpQztYdUM9tYncKdpoO2zbgwN/s94hh5EFsX2Bnnk=;
	b=DgsR0Zd/IFKywAoqGaX+jEI02ZUtVfxJv/2QhjuchGrCjEdlvoLuwfUfj6rwHg954ZGD
	 Ih90G2nDhvxIA4jsyPvvS8RbsPIXYjyCEm3j6oGsrDkTNdH/q2qJf5Be33d7bAo+O7apE
	 QOyrk1gvbp6+bNAPbuX43Vs4VPMioC3J/GwPv41/5d5z8TPBaDczEghWQkueu3gdwQ/qc
	 o1eEtdEEaNRwc4PV4xNoMXVfn8OoOKeCkeFjZ7zLU/qnFJb2xGn8suS4yfXoGW79U/yEK
	 JCmBZlUySqbFbtP2cIDH2BEEpdiXeb6srmme6ncaqEJFq4s21HW0Ej4ExaPFtmArUwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYPdpOM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFEF606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYPdpOM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB141F000C0;
	Thu, 26 Nov 2026 04:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667269;
	bh=FBbpQztYdUM9tYncKdpoO2zbgwN/s94hh5EFsX2Bnnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gYPdpOM550NzcBV43YmOe1z6fik7XkfbZ+9Qg2lcobqiVqKBz7NpjmzQuTCcg39mV
	 G7EQT7jJZROi4pPd0S3JZye70xjMvnKLCzBqe9HeJiUv/2oANFqiGd5XaP/s6xhT29
	 KrZw2lkh7usznYjNHPQELv2oYUAzuWn32mcMYJGGIaDKFrjbps+LeKc+wUtmckzXfY
	 sdbNO76JDoelb3X4HWKLkmosjeDiMGb7r9Gh6YowpcvOWKd9bqBhldTCVGxmTcCjBC
	 /DgK7Y/KOFbEEMfEAQZJs2TJIfuvtSN7ky49eA6jxIQPDkgnQbco08Oyxctrn1K0S3
	 12dozIpPLA/Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: hold server ref while queueing reconnect work
Date: Wed, 25 Nov 2026 23:27:47 -0500
Message-ID: <20261126042723.1962827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-crowbar-trio-f08b@gregkh>
References: <2026112545-crowbar-trio-f08b@gregkh>
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
[ sashal: adapted to older code: open-coded the reconnect work queueing and channel disable calls (mod_delayed_work, cifs_chan_skip_or_disable) and adjusted variable declaration context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 24863ba8a0926..3c6d26f6a6921 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -214,6 +214,7 @@ static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server, bool from_reconnect)
 {
+	bool hold_server_ref = false;
 	int rc = 0;
 	struct nls_table *nls_codepage = NULL;
 	struct cifs_ses *ses;
@@ -452,6 +453,20 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
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
@@ -478,6 +493,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 
 	if (smb2_command != SMB2_INTERNAL_CMD)
 		mod_delayed_work(cifsiod_wq, &server->reconnect, 0);
+	if (hold_server_ref)
+		cifs_put_tcp_session(server, from_reconnect);
 
 	atomic_inc(&tconInfoReconnectCount);
 out:
-- 
2.53.0

