Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEED4A5C21
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105635; cv=none; b=s3synAfETmidY1KV3GlnMJX8tvop8inpJ6Kty4bqyT/b6/QACyPsaNUlbYYFNADDaNKjVAlh/T31XpnWM5QJoetmwF/Lz0b31uhyjLt9Vd87mSpJEoIU2HKaXwQMcixnYXPfCRC4EH+OCcT/2CKRkYQZLJT4AuQyaudFt9pIBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105635; c=relaxed/simple;
	bh=kncHk8yVmC3/iiBglA+huw8yx6Z3xuddVtnPIo7zFBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aExjHo1fuv3d2qM1TzMmeZj5HwVEX1JXtqypiV73EHIJF+fDaJ+Zb0xKj/YaTH2SMOWAJX+7ryIEJvkdiCkNonIBoOISPE4STIGxfkE4dRexqKtbC+zu+nxz/B9ue31yKweo9CZ0JV289lMur/G2hExzwOcoWRaCz2zHG+EVseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6O+rn/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6O+rn/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668131F000FF;
	Tue, 22 Sep 2026 19:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105633;
	bh=7/1fypCTkvaLrz1yMKHRybFlAbT8AlKIliPLd7UY4gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N6O+rn/SbLDhX43ycjJ5oKEZtIeP7OrwAZt2EQCmtR8ESCGWUV32jSX5U51T6RnAK
	 l3K2nRKw1cugRRoInslsJwXlT82l1vWykJZGU+udmVY+bGDMwWOo9drgJ/HmENuqKE
	 UBidc0ahox2g6AJoS8wep3iXhkys3ZcWrKHeuN96mo0NzY9JbZcjRyCs2tUDQuc94I
	 nRwbMw3+fEx5FjybcKXH61GwYNFRzwd8YfjhznaNnQLslozzjJ6uXvfAazYiUssAq7
	 Clpxv3BwcIGDn0iPG/YrPjj5udefX8HtPPIZLoaQieMoO1JyjpsaKPLCYD6U4zpXtf
	 CYB2gOXzgy7MQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] cifs: get rid of dns resolve worker
Date: Tue, 22 Sep 2026 15:33:51 -0400
Message-ID: <20260922193352.4154615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092259-extortion-dragging-26e2@gregkh>
References: <2026092259-extortion-dragging-26e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 0e9bd27b2a635d54665fcc1d6398a5f6aeb6b0cb ]

We already upcall to resolve hostnames during reconnect by calling
reconn_set_ipaddr_from_hostname(), so there is no point in having a
worker to periodically call it.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Reviewed-by <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

Backport to 6.1: keep the string-returning DNS resolver API, the
cifs_convert_address() call under srv_lock, and the existing return-value
convention. Pass NULL for the unused expiry and remove all periodic DNS
work state, scheduling, and cancellation.

Drop the sess.c hunk: channel error cleanup already calls
cifs_put_tcp_session(), which handles delayed work and reference counts.
Removing the resolve cancellation from clean_demultiplex_info() also
allows c65eae6f61d1778ff7a82e4aae4080e26f486af1 to apply unchanged.

[ sashal: Reduced backport -- upstream 0e9bd27b2a635 touches 3 file(s), this
  backport carries 2. Not backported here:
  fs/cifs/cifsglob.h
  fs/cifs/connect.c
  fs/cifs/sess.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c65eae6f61d1 ("smb: client: cancel reconnect work in clean_demultiplex_info()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h |  5 ----
 fs/smb/client/connect.c  | 53 +++-------------------------------------
 2 files changed, 3 insertions(+), 55 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a5e9f79c10f90..962eeb0b3c5c7 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -80,10 +80,6 @@
 #define SMB_ECHO_INTERVAL_MAX 600
 #define SMB_ECHO_INTERVAL_DEFAULT 60
 
-/* dns resolution intervals in seconds */
-#define SMB_DNS_RESOLVE_INTERVAL_MIN     120
-#define SMB_DNS_RESOLVE_INTERVAL_DEFAULT 600
-
 /* smb multichannel query server interfaces interval in seconds */
 #define SMB_INTERFACE_POLL_INTERVAL	600
 
@@ -671,7 +667,6 @@ struct TCP_Server_Info {
 	/* point to the SMBD connection if RDMA is used instead of socket */
 	struct smbd_connection *smbd_conn;
 	struct delayed_work	echo; /* echo ping workqueue job */
-	struct delayed_work	resolve; /* dns resolution workqueue job */
 	char	*smallbuf;	/* pointer to current "small" buffer */
 	char	*bigbuf;	/* pointer to current "big" buffer */
 	/* Total size of this PDU. Only valid from cifs_demultiplex_thread */
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 096e69c591722..6ded0a1d02c8c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -91,8 +91,6 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 	int rc;
 	int len;
 	char *unc, *ipaddr = NULL;
-	time64_t expiry, now;
-	unsigned long ttl = SMB_DNS_RESOLVE_INTERVAL_DEFAULT;
 
 	if (!server->hostname)
 		return -EINVAL;
@@ -110,13 +108,13 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 	}
 	scnprintf(unc, len, "\\\\%s", server->hostname);
 
-	rc = dns_resolve_server_name_to_ip(unc, &ipaddr, &expiry);
+	rc = dns_resolve_server_name_to_ip(unc, &ipaddr, NULL);
 	kfree(unc);
 
 	if (rc < 0) {
 		cifs_dbg(FYI, "%s: failed to resolve server part of %s to IP: %d\n",
 			 __func__, server->hostname, rc);
-		goto requeue_resolve;
+		return rc;
 	}
 
 	spin_lock(&server->srv_lock);
@@ -126,23 +124,7 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 	kfree(ipaddr);
 
 	/* rc == 1 means success here */
-	if (rc) {
-		now = ktime_get_real_seconds();
-		if (expiry && expiry > now)
-			/*
-			 * To make sure we don't use the cached entry, retry 1s
-			 * after expiry.
-			 */
-			ttl = max_t(unsigned long, expiry - now, SMB_DNS_RESOLVE_INTERVAL_MIN) + 1;
-	}
-	rc = !rc ? -1 : 0;
-
-requeue_resolve:
-	cifs_dbg(FYI, "%s: next dns resolution scheduled for %lu seconds in the future\n",
-		 __func__, ttl);
-	mod_delayed_work(cifsiod_wq, &server->resolve, (ttl * HZ));
-
-	return rc;
+	return !rc ? -1 : 0;
 }
 
 static void smb2_query_server_interfaces(struct work_struct *work)
@@ -165,26 +147,6 @@ static void smb2_query_server_interfaces(struct work_struct *work)
 			   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 }
 
-static void cifs_resolve_server(struct work_struct *work)
-{
-	int rc;
-	struct TCP_Server_Info *server = container_of(work,
-					struct TCP_Server_Info, resolve.work);
-
-	cifs_server_lock(server);
-
-	/*
-	 * Resolve the hostname again to make sure that IP address is up-to-date.
-	 */
-	rc = reconn_set_ipaddr_from_hostname(server);
-	if (rc) {
-		cifs_dbg(FYI, "%s: failed to resolve hostname: %d\n",
-				__func__, rc);
-	}
-
-	cifs_server_unlock(server);
-}
-
 /*
  * Update the tcpStatus for the server.
  * This is used to signal the cifsd thread to call cifs_reconnect
@@ -1008,7 +970,6 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 	spin_unlock(&server->srv_lock);
 
 	cancel_delayed_work_sync(&server->echo);
-	cancel_delayed_work_sync(&server->resolve);
 
 	spin_lock(&server->srv_lock);
 	server->tcpStatus = CifsExiting;
@@ -1687,7 +1648,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 		cifs_put_tcp_session(server->primary_server, from_reconnect);
 
 	cancel_delayed_work_sync(&server->echo);
-	cancel_delayed_work_sync(&server->resolve);
 
 	if (from_reconnect)
 		/*
@@ -1785,7 +1745,6 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	INIT_LIST_HEAD(&tcp_ses->tcp_ses_list);
 	INIT_LIST_HEAD(&tcp_ses->smb_ses_list);
 	INIT_DELAYED_WORK(&tcp_ses->echo, cifs_echo_request);
-	INIT_DELAYED_WORK(&tcp_ses->resolve, cifs_resolve_server);
 	INIT_DELAYED_WORK(&tcp_ses->reconnect, smb2_reconnect_server);
 	mutex_init(&tcp_ses->reconnect_mutex);
 #ifdef CONFIG_CIFS_DFS_UPCALL
@@ -1874,12 +1833,6 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 	/* queue echo request delayed work */
 	queue_delayed_work(cifsiod_wq, &tcp_ses->echo, tcp_ses->echo_interval);
 
-	/* queue dns resolution delayed work */
-	cifs_dbg(FYI, "%s: next dns resolution scheduled for %d seconds in the future\n",
-		 __func__, SMB_DNS_RESOLVE_INTERVAL_DEFAULT);
-
-	queue_delayed_work(cifsiod_wq, &tcp_ses->resolve, (SMB_DNS_RESOLVE_INTERVAL_DEFAULT * HZ));
-
 	return tcp_ses;
 
 out_err_crypto_release:
-- 
2.53.0

