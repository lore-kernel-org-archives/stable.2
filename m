Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80B54B1C0
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112222; cv=none; b=aR91BMAkb0jRi1aeqGlELynWmZAqaUrCfzMAJt9f/fxu8hpDqnOEVL7ZWTFCa0ZcrKdLeBI8to/19Lu+45Ej4KFtdpxVhK4Ww7vavB8ATP7tU7Bti3K4tArNJTwfcVj2QUxjinpmEGEQl/VTpAgYREJckJBnk7O2+DQrz3mEg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112222; c=relaxed/simple;
	bh=VwYGqQ/hYYra99+t0B2ayOJWPkQnWkl5revnM1DfBMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjcpNPMbSqdBShOc1d9e9y0qykCOv5vfrMsd6oXl/FVkdjSEY5qFv/v3u3rP3IZaRI6JesoNdp8pBnd4Fbd6ektl5FMzdCBtz1XoLw4rbwQ6xSy62ol7+TmMiCVfFGBgM9Tn6+FKEiRmvs3FDeiWcLrABDjUbD6pEM74XeXggXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj0DRS/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj0DRS/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2941F0089A;
	Tue, 22 Sep 2026 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112209;
	bh=NIsCw0gNuk6svBU3ViyprjmVHairJ918j609v0dlsoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kj0DRS/t+0UgMv1GjtcBg2hnsEw6Voe3CZaR8IONHgTjVc4msB4RVFBG1/TNKfkJu
	 yYhq8itW+p++x/AOOqeUfjRHOiRQzGYow8nvO2X4bMSxRlCMFf5GREhEpEuv0SANJP
	 a+/4PV/+FWDWUoxaYj17+40vlb8XCaSR4hkGTuJm4OJMjjri2gM4R8ejh6bXp/NCOm
	 APcf3M5VuBYij9hwvwx8pS1kODijZF0frierbzfv/qWdGoQ/gan8nm4fl/tSYnDjwg
	 8RLgfBmjhE6eLR8Jstm2t1Wt/MED7CsCqPIp+s1ura4SbU446KvWku3QNWussCtPu5
	 W2JnxmTyty8JQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] cifs: get rid of dns resolve worker
Date: Tue, 22 Sep 2026 17:23:26 -0400
Message-ID: <20260922212327.752944-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092200-operating-swinger-d7a7@gregkh>
References: <2026092200-operating-swinger-d7a7@gregkh>
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

Backport to 5.15: keep the existing string-returning DNS resolver,
address conversion, and cifs_tcp_ses_lock protection. Remove the DNS
worker, its scheduling and cancellation, and its interval constants.
Drop the sess.c hunk because this tree has no explicit DNS-work
cancellation in cifs_ses_add_channel(); it uses cifs_put_tcp_session().
Do not import the newer interface-polling or reconnect helpers.

This leaves clean_demultiplex_info() ready for the reconnect-work
cancellation in c65eae6f61d1778ff7a82e4aae4080e26f486af1.

[ sashal: Reduced backport -- upstream 0e9bd27b2a635 touches 3 file(s), this
  backport carries 2. Not backported here:
  fs/cifs/sess.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c65eae6f61d1 ("smb: client: cancel reconnect work in clean_demultiplex_info()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h |  5 -----
 fs/cifs/connect.c  | 54 +++-------------------------------------------
 2 files changed, 3 insertions(+), 56 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 9b08020634f19..019ce688c1943 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -78,10 +78,6 @@
 #define SMB_ECHO_INTERVAL_MAX 600
 #define SMB_ECHO_INTERVAL_DEFAULT 60
 
-/* dns resolution intervals in seconds */
-#define SMB_DNS_RESOLVE_INTERVAL_MIN     120
-#define SMB_DNS_RESOLVE_INTERVAL_DEFAULT 600
-
 /* maximum number of PDUs in one compound */
 #define MAX_COMPOUND 5
 
@@ -651,7 +647,6 @@ struct TCP_Server_Info {
 	/* point to the SMBD connection if RDMA is used instead of socket */
 	struct smbd_connection *smbd_conn;
 	struct delayed_work	echo; /* echo ping workqueue job */
-	struct delayed_work	resolve; /* dns resolution workqueue job */
 	char	*smallbuf;	/* pointer to current "small" buffer */
 	char	*bigbuf;	/* pointer to current "big" buffer */
 	/* Total size of this PDU. Only valid from cifs_demultiplex_thread */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d35474b836007..424cc901fb27a 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -91,8 +91,6 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 	int rc;
 	int len;
 	char *unc, *ipaddr = NULL;
-	time64_t expiry, now;
-	unsigned long ttl = SMB_DNS_RESOLVE_INTERVAL_DEFAULT;
 
 	if (!server->hostname)
 		return -EINVAL;
@@ -106,13 +104,13 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
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
 
 	spin_lock(&cifs_tcp_ses_lock);
@@ -122,44 +120,7 @@ static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
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
-}
-
-
-static void cifs_resolve_server(struct work_struct *work)
-{
-	int rc;
-	struct TCP_Server_Info *server = container_of(work,
-					struct TCP_Server_Info, resolve.work);
-
-	mutex_lock(&server->srv_mutex);
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
-	mutex_unlock(&server->srv_mutex);
+	return !rc ? -1 : 0;
 }
 
 /**
@@ -764,7 +725,6 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	cancel_delayed_work_sync(&server->echo);
-	cancel_delayed_work_sync(&server->resolve);
 
 	spin_lock(&GlobalMid_Lock);
 	server->tcpStatus = CifsExiting;
@@ -1378,7 +1338,6 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	cancel_delayed_work_sync(&server->echo);
-	cancel_delayed_work_sync(&server->resolve);
 
 	if (from_reconnect)
 		/*
@@ -1467,7 +1426,6 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
 	INIT_LIST_HEAD(&tcp_ses->tcp_ses_list);
 	INIT_LIST_HEAD(&tcp_ses->smb_ses_list);
 	INIT_DELAYED_WORK(&tcp_ses->echo, cifs_echo_request);
-	INIT_DELAYED_WORK(&tcp_ses->resolve, cifs_resolve_server);
 	INIT_DELAYED_WORK(&tcp_ses->reconnect, smb2_reconnect_server);
 	mutex_init(&tcp_ses->reconnect_mutex);
 #ifdef CONFIG_CIFS_DFS_UPCALL
@@ -1556,12 +1514,6 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx)
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

