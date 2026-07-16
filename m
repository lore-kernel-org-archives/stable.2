Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38C3FE36D
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197110; cv=none; b=EJmbIhvf0+QdVc4hyPNfNEtGG7+WJXP62cpc65rP42oa+mlRzfOSi+R3u/kL9n+9dxq4hyPzCps6Zb8DcERBZrPwMEX3dVb1eoz0tElW3jbCIQCsMqjg/lbHo36bmUTq3ZSg2lMHLaDXzoYSkyxwHOBa/kZ8gfcIaayQTzIlETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197110; c=relaxed/simple;
	bh=924e/Ne7oj/bIOpV0zyoYJTM6vtQv4IFYrZsW6aAFCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pajyU61BXXTJjzxqDV+TMuBQoMCeNj2l+i57tZxIb9GZBokCog7OSg4UIXJtaz7s6I4seQvKk0CSuInLiOmlaqXOwH3ACTbtRw8lUImysMMfplEjUG0eQgaSVc4k5Ntdwbel6JHFlPJvsS9ntHu8sZj0IUz8fOOlNRO39nf9X1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbCNq4bs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbCNq4bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139ED1F00A3A;
	Thu, 16 Jul 2026 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784197109;
	bh=+oW1xZYYPj6Cf8W+ZeAnA0eT+llU7C7X5gpXv33trkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LbCNq4bsE+UMhqydOajdXIYz3XKYoT1yS24ASrfsGzqthtPljgX17APf/o77z9o8z
	 /EAWFqWkdGcZsXPABKAfCodJMS8Y7Ey2uMSBUwkUX3Qz0X7olihyCLLMmH1X4mNi7a
	 W6TIttLagPofcOK7A/UzKV2kXLyJzaCl7GYIfSzCN31NGJqjoVUfCCO7E4NJgtiVlb
	 1KHoLrBU+8ZpOQPa0TJvlyZEVul1g5n5EBIdsD1JeG/ZOJzgLdrX8vIBUW1IjOqa5v
	 By6jZy46vBSaCfPWDCJ6VFR5EZM/sOIWOelR02aOAJoYf4HvVxGTE1Bf56zEpFm2ga
	 KAsxII3I3oWww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] cifs: after disabling multichannel, mark tcon for reconnect
Date: Thu, 16 Jul 2026 06:18:21 -0400
Message-ID: <20260716101824.1461870-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716101824.1461870-1-sashal@kernel.org>
References: <2026071415-visiting-rise-04bc@gregkh>
 <20260716101824.1461870-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 27e1fd343f80168ff456785c2443136b6b7ca3cc ]

Once the server disables multichannel for an active multichannel
session, on the following reconnect, the client would reduce
the number of channels to 1. However, it could be the case that
the tree connect was active on one of these disabled channels.
This results in an unrecoverable state.

This change fixes that by making sure that whenever a channel
is being terminated, the session and tcon are marked for
reconnect too. This could mean a few redundant tree connect
calls to the server, but considering that this is not a frequent
event, we should be okay.

Fixes: ee1d21794e55 ("cifs: handle when server stops supporting multichannel")
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: ec457f9afe5a ("smb: client: resolve SWN tcon from live registrations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index c9b166366da94e..605476fac102b4 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -256,17 +256,21 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 	/* If server is a channel, select the primary channel */
 	pserver = CIFS_SERVER_IS_CHAN(server) ? server->primary_server : server;
 
+	/*
+	 * if the server has been marked for termination, there is a
+	 * chance that the remaining channels all need reconnect. To be
+	 * on the safer side, mark the session and trees for reconnect
+	 * for this scenario. This might cause a few redundant session
+	 * setup and tree connect requests, but it is better than not doing
+	 * a tree connect when needed, and all following requests failing
+	 */
+	if (server->terminate) {
+		mark_smb_session = true;
+		server = pserver;
+	}
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
-		/*
-		 * if channel has been marked for termination, nothing to do
-		 * for the channel. in fact, we cannot find the channel for the
-		 * server. So safe to exit here
-		 */
-		if (server->terminate)
-			break;
-
 		spin_lock(&ses->ses_lock);
 		if (ses->ses_status == SES_EXITING) {
 			spin_unlock(&ses->ses_lock);
-- 
2.53.0

