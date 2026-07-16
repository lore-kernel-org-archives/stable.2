Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B940862A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197114; cv=none; b=XeMhZYYE+Zp+4kafEitt5bCRo9W1xTuZwcn6sXRjG0c68RCHEZHlzHtbIIrHCOoxEBd+A+jQbHEFs96z6vjzQr6/p2wgASHQWlh6PZ+1LFniuVVHYFLzXRQOCPm1dOtk6pZgXkeRGtk96OK7WekVtrZxqcztR5121mjXsuuy6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197114; c=relaxed/simple;
	bh=VOz4DCsu90uUxGjOMlwOIOy+FRXAWLbLkryf4g0N0II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKfS2Gd9HGAQjfjt3MLxeh9cMI+US/piE+Qitwz7EoIgthDx1Xt6iaCfUS3ekKG8WJ1vFCSId48ECY8RzncGmCnnM8KuQHe1rtkuo7gMp1sZ/7O91MUFSm79UvycJ/pDUsSSEZFGxLOc7jYWxZwXFHTP17TfLxuJNqS2b98OeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk1BaqjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk1BaqjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AEA1F00A3A;
	Thu, 16 Jul 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784197112;
	bh=BDg7Ljeo2uT7I+6IY6tBNnGTKfG8HZG0Rva6iZfy7nI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bk1BaqjWT45uLXg4t3yQ32BqfWRODCIOzO2G60w3ohBImXtBrIK+lalLuGOLB8Ae9
	 mA1qhfa0UitWpd83/4/0XDKgmskmSMy/OBAYfMtBg/CZfwHIqKgVvRvwb4VypyM4IJ
	 kHb+EyBOaxgODMy1To6cVcvcvOm1pbgc4tcgsMjdfFOARsdhMkbDw2tagiOT4VdFhx
	 rst/6BbOnEdn4so4Qtg2VLAciEP0+MmSmVUYU1uvBXBzuw8AFxs43dhmeN32uxcShL
	 OqM//uAUe6e7N8c6S/6noY1k82lHY75Ku85nuJnLmsOyXYUw/h7HMszYaQEFGSNg/O
	 fY+BmS7S6JBxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] smb: client: resolve SWN tcon from live registrations
Date: Thu, 16 Jul 2026 06:18:24 -0400
Message-ID: <20260716101824.1461870-5-sashal@kernel.org>
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

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit ec457f9afe5ae9538bdcd58fd4cb442b9787e183 ]

cifs_swn_notify() looks up a witness registration by id under
cifs_swnreg_idr_mutex, drops the mutex, and then uses the registration's
cached tcon pointer.  That pointer is not a lifetime reference, and it is
not a stable representative once cifs_get_swn_reg() lets multiple tcons
for the same net/share name share one registration id.

A same-share second mount can keep the cifs_swn_reg alive after the first
tcon unregisters and is freed.  The registration then still points at the
freed first tcon, so taking tc_lock or incrementing tc_count through
swnreg->tcon only moves the use-after-free earlier.  Taking tc_lock while
holding cifs_swnreg_idr_mutex also violates the documented CIFS lock
order.

Fix this by making the registration store only the stable witness
identity: id, net name, share name, and notify flags.  When a notify
arrives, copy that identity under cifs_swnreg_idr_mutex, drop the mutex,
then find and pin a live witness tcon that currently matches the net/share
pair under the normal cifs_tcp_ses_lock -> tc_lock order.  The notification
path uses that pinned tcon directly and drops the reference when done.

Registration and unregister messages now use the live tcon passed by the
caller instead of a cached tcon in the registration.  The final unregister
send is folded into cifs_swn_unregister() while the registration is still
protected by cifs_swnreg_idr_mutex.  This removes the previous
find/drop/reacquire raw-pointer window.  The release path only removes the
idr entry and frees the stable identity strings.

This preserves the intended one-registration/many-tcon behavior: a
registration id represents a net/share pair, and notify handling acts on a
live representative selected at use time.  It also preserves CLIENT_MOVE
ordering for the representative tcon because the old-IP unregister is sent
before cifs_swn_register() sends the new-IP register.

Fixes: fed979a7e082 ("cifs: Set witness notification handler for messages from userspace daemon")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifs_swn.c | 314 ++++++++++++++++++++++++++++++++-------
 fs/smb/client/trace.h    |   2 +
 2 files changed, 262 insertions(+), 54 deletions(-)

diff --git a/fs/smb/client/cifs_swn.c b/fs/smb/client/cifs_swn.c
index 35a3e73c195806..693f609512e6b5 100644
--- a/fs/smb/client/cifs_swn.c
+++ b/fs/smb/client/cifs_swn.c
@@ -28,10 +28,54 @@ struct cifs_swn_reg {
 	bool net_name_notify;
 	bool share_name_notify;
 	bool ip_notify;
+};
 
-	struct cifs_tcon *tcon;
+struct cifs_swn_reg_info {
+	int id;
+	unsigned int ref_count;
+	const char *net_name;
+	const char *share_name;
+	bool net_name_notify;
+	bool share_name_notify;
+	bool ip_notify;
 };
 
+static void cifs_swn_snapshot_reg(struct cifs_swn_reg *swnreg,
+				  struct cifs_swn_reg_info *info)
+{
+	info->id = swnreg->id;
+	info->ref_count = kref_read(&swnreg->ref_count);
+	info->net_name = swnreg->net_name;
+	info->share_name = swnreg->share_name;
+	info->net_name_notify = swnreg->net_name_notify;
+	info->share_name_notify = swnreg->share_name_notify;
+	info->ip_notify = swnreg->ip_notify;
+}
+
+static int cifs_swn_dup_reg(struct cifs_swn_reg *swnreg,
+			    struct cifs_swn_reg_info *info)
+{
+	cifs_swn_snapshot_reg(swnreg, info);
+
+	info->net_name = kstrdup(swnreg->net_name, GFP_KERNEL);
+	if (!info->net_name)
+		return -ENOMEM;
+
+	info->share_name = kstrdup(swnreg->share_name, GFP_KERNEL);
+	if (!info->share_name) {
+		kfree(info->net_name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void cifs_swn_free_reg_info(struct cifs_swn_reg_info *info)
+{
+	kfree(info->net_name);
+	kfree(info->share_name);
+}
+
 static int cifs_swn_auth_info_krb(struct cifs_tcon *tcon, struct sk_buff *skb)
 {
 	int ret;
@@ -73,7 +117,8 @@ static int cifs_swn_auth_info_ntlm(struct cifs_tcon *tcon, struct sk_buff *skb)
  * The authentication information to connect to the witness service is bundled
  * into the message.
  */
-static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
+static int cifs_swn_send_register_message(struct cifs_swn_reg_info *swnreg,
+					  struct cifs_tcon *tcon)
 {
 	struct sk_buff *skb;
 	struct genlmsghdr *hdr;
@@ -111,10 +156,10 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 	 * told to switch to it (client move message). In these cases we unregister from the
 	 * server address and register to the new address when we receive the notification.
 	 */
-	if (swnreg->tcon->ses->server->use_swn_dstaddr)
-		addr = &swnreg->tcon->ses->server->swn_dstaddr;
+	if (tcon->ses->server->use_swn_dstaddr)
+		addr = &tcon->ses->server->swn_dstaddr;
 	else
-		addr = &swnreg->tcon->ses->server->dstaddr;
+		addr = &tcon->ses->server->dstaddr;
 
 	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage), addr);
 	if (ret < 0)
@@ -138,10 +183,10 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 			goto nlmsg_fail;
 	}
 
-	authtype = cifs_select_sectype(swnreg->tcon->ses->server, swnreg->tcon->ses->sectype);
+	authtype = cifs_select_sectype(tcon->ses->server, tcon->ses->sectype);
 	switch (authtype) {
 	case Kerberos:
-		ret = cifs_swn_auth_info_krb(swnreg->tcon, skb);
+		ret = cifs_swn_auth_info_krb(tcon, skb);
 		if (ret < 0) {
 			cifs_dbg(VFS, "%s: Failed to get kerberos auth info: %d\n", __func__, ret);
 			goto nlmsg_fail;
@@ -149,7 +194,7 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 		break;
 	case NTLMv2:
 	case RawNTLMSSP:
-		ret = cifs_swn_auth_info_ntlm(swnreg->tcon, skb);
+		ret = cifs_swn_auth_info_ntlm(tcon, skb);
 		if (ret < 0) {
 			cifs_dbg(VFS, "%s: Failed to get NTLM auth info: %d\n", __func__, ret);
 			goto nlmsg_fail;
@@ -179,7 +224,8 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 /*
  * Sends an uregister message to the userspace daemon based on the registration
  */
-static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
+static int cifs_swn_send_unregister_message(struct cifs_swn_reg_info *swnreg,
+					    struct cifs_tcon *tcon)
 {
 	struct sk_buff *skb;
 	struct genlmsghdr *hdr;
@@ -208,7 +254,7 @@ static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
 		goto nlmsg_fail;
 
 	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage),
-			&swnreg->tcon->ses->server->dstaddr);
+			&tcon->ses->server->dstaddr);
 	if (ret < 0)
 		goto nlmsg_fail;
 
@@ -244,6 +290,88 @@ static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
 	return ret;
 }
 
+/*
+ * Allocation-free mirror of extract_hostname() + extract_sharename() from
+ * fs/smb/client/unc.c.  Those helpers kmalloc(GFP_KERNEL); this runs under
+ * cifs_tcp_ses_lock and tcon->tc_lock, both spinlocks, so we mirror their
+ * parsing in place against the caller's stable net_name/share_name strings.
+ * Keep in sync with unc.c.
+ */
+static bool cifs_swn_tcon_matches(struct cifs_tcon *tcon,
+				  const char *net_name,
+				  const char *share_name)
+{
+	const char *unc = tcon->tree_name;
+	const char *host, *share, *delim;
+	size_t host_len, share_len;
+
+	if (!tcon->use_witness)
+		return false;
+
+	/* extract_hostname: require strlen(unc) >= 3 */
+	if (strnlen(unc, 3) < 3)
+		return false;
+	/* extract_hostname: skip all leading '\' characters */
+	for (host = unc; *host == '\\'; host++)
+		;
+	if (!*host)
+		return false;
+	delim = strchr(host, '\\');
+	if (!delim)
+		return false;
+	host_len = delim - host;
+	if (strlen(net_name) != host_len ||
+	    strncasecmp(host, net_name, host_len))
+		return false;
+
+	/* extract_sharename: start at unc + 2, then first '\' onward */
+	share = unc + 2;
+	delim = strchr(share, '\\');
+	if (!delim)
+		return false;
+	share = delim + 1;
+	share_len = strlen(share);
+
+	return strlen(share_name) == share_len &&
+	       !strncasecmp(share, share_name, share_len);
+}
+
+/*
+ * One SWN registration id represents one net/share name pair.  Multiple
+ * mounted tcons can therefore share the id.  Pick a live representative at
+ * use time instead of caching the first tcon pointer in the registration.
+ */
+static struct cifs_tcon *cifs_swn_get_tcon(struct cifs_swn_reg_info *swnreg)
+{
+	struct TCP_Server_Info *server;
+	struct cifs_ses *ses;
+	struct cifs_tcon *tcon;
+
+	spin_lock(&cifs_tcp_ses_lock);
+	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
+		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
+				spin_lock(&tcon->tc_lock);
+				if (tcon->status == TID_EXITING ||
+				    !cifs_swn_tcon_matches(tcon, swnreg->net_name,
+							   swnreg->share_name)) {
+					spin_unlock(&tcon->tc_lock);
+					continue;
+				}
+				++tcon->tc_count;
+				trace_smb3_tcon_ref(tcon->debug_id,
+						    tcon->tc_count,
+						    netfs_trace_tcon_ref_get_swn_notify);
+				spin_unlock(&tcon->tc_lock);
+				spin_unlock(&cifs_tcp_ses_lock);
+				return tcon;
+			}
+		}
+	}
+	spin_unlock(&cifs_tcp_ses_lock);
+	return NULL;
+}
+
 /*
  * Try to find a matching registration for the tcon's server name and share name.
  * Calls to this function must be protected by cifs_swnreg_idr_mutex.
@@ -350,8 +478,6 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 	reg->net_name_notify = true;
 	reg->share_name_notify = true;
 	reg->ip_notify = (tcon->capabilities & SMB2_SHARE_CAP_SCALEOUT);
-
-	reg->tcon = tcon;
 unlock:
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 
@@ -371,11 +497,6 @@ static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
 static void cifs_swn_reg_release(struct kref *ref)
 {
 	struct cifs_swn_reg *swnreg = container_of(ref, struct cifs_swn_reg, ref_count);
-	int ret;
-
-	ret = cifs_swn_send_unregister_message(swnreg);
-	if (ret < 0)
-		cifs_dbg(VFS, "%s: Failed to send unregister message: %d\n", __func__, ret);
 
 	idr_remove(&cifs_swnreg_idr, swnreg->id);
 	kfree(swnreg->net_name);
@@ -383,23 +504,33 @@ static void cifs_swn_reg_release(struct kref *ref)
 	kfree(swnreg);
 }
 
-static void cifs_put_swn_reg(struct cifs_swn_reg *swnreg)
+static void cifs_put_swn_reg_locked(struct cifs_swn_reg *swnreg,
+				    struct cifs_tcon *tcon)
 {
-	mutex_lock(&cifs_swnreg_idr_mutex);
+	if (kref_read(&swnreg->ref_count) == 1) {
+		struct cifs_swn_reg_info swnreg_info;
+		int ret;
+
+		cifs_swn_snapshot_reg(swnreg, &swnreg_info);
+		ret = cifs_swn_send_unregister_message(&swnreg_info, tcon);
+		if (ret < 0)
+			cifs_dbg(VFS, "%s: Failed to send unregister message: %d\n",
+				 __func__, ret);
+	}
+
 	kref_put(&swnreg->ref_count, cifs_swn_reg_release);
-	mutex_unlock(&cifs_swnreg_idr_mutex);
 }
 
-static int cifs_swn_resource_state_changed(struct cifs_swn_reg *swnreg, const char *name, int state)
+static int cifs_swn_resource_state_changed(struct cifs_tcon *tcon, const char *name, int state)
 {
 	switch (state) {
 	case CIFS_SWN_RESOURCE_STATE_UNAVAILABLE:
 		cifs_dbg(FYI, "%s: resource name '%s' become unavailable\n", __func__, name);
-		cifs_signal_cifsd_for_reconnect(swnreg->tcon->ses->server, true);
+		cifs_signal_cifsd_for_reconnect(tcon->ses->server, true);
 		break;
 	case CIFS_SWN_RESOURCE_STATE_AVAILABLE:
 		cifs_dbg(FYI, "%s: resource name '%s' become available\n", __func__, name);
-		cifs_signal_cifsd_for_reconnect(swnreg->tcon->ses->server, true);
+		cifs_signal_cifsd_for_reconnect(tcon->ses->server, true);
 		break;
 	case CIFS_SWN_RESOURCE_STATE_UNKNOWN:
 		cifs_dbg(FYI, "%s: resource name '%s' changed to unknown state\n", __func__, name);
@@ -505,7 +636,7 @@ static int cifs_swn_reconnect(struct cifs_tcon *tcon, struct sockaddr_storage *a
 	return ret;
 }
 
-static int cifs_swn_client_move(struct cifs_swn_reg *swnreg, struct sockaddr_storage *addr)
+static int cifs_swn_client_move(struct cifs_tcon *tcon, struct sockaddr_storage *addr)
 {
 	struct sockaddr_in *ipv4 = (struct sockaddr_in *)addr;
 	struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)addr;
@@ -515,14 +646,17 @@ static int cifs_swn_client_move(struct cifs_swn_reg *swnreg, struct sockaddr_sto
 	else if (addr->ss_family == AF_INET6)
 		cifs_dbg(FYI, "%s: move to %pI6\n", __func__, &ipv6->sin6_addr);
 
-	return cifs_swn_reconnect(swnreg->tcon, addr);
+	return cifs_swn_reconnect(tcon, addr);
 }
 
 int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cifs_swn_reg *swnreg;
+	struct cifs_swn_reg_info swnreg_info;
+	struct cifs_tcon *tcon;
 	char name[256];
 	int type;
+	int ret = 0;
 
 	if (info->attrs[CIFS_GENL_ATTR_SWN_REGISTRATION_ID]) {
 		int swnreg_id;
@@ -530,21 +664,34 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 		swnreg_id = nla_get_u32(info->attrs[CIFS_GENL_ATTR_SWN_REGISTRATION_ID]);
 		mutex_lock(&cifs_swnreg_idr_mutex);
 		swnreg = idr_find(&cifs_swnreg_idr, swnreg_id);
-		mutex_unlock(&cifs_swnreg_idr_mutex);
 		if (swnreg == NULL) {
+			mutex_unlock(&cifs_swnreg_idr_mutex);
 			cifs_dbg(FYI, "%s: registration id %d not found\n", __func__, swnreg_id);
 			return -EINVAL;
 		}
+		ret = cifs_swn_dup_reg(swnreg, &swnreg_info);
+		mutex_unlock(&cifs_swnreg_idr_mutex);
+		if (ret)
+			return ret;
 	} else {
 		cifs_dbg(FYI, "%s: missing registration id attribute\n", __func__);
 		return -EINVAL;
 	}
 
+	tcon = cifs_swn_get_tcon(&swnreg_info);
+	if (!tcon) {
+		cifs_dbg(FYI, "%s: registration id %d has no live tcon\n",
+			 __func__, swnreg_info.id);
+		ret = -ENODEV;
+		goto free_info;
+	}
+
 	if (info->attrs[CIFS_GENL_ATTR_SWN_NOTIFICATION_TYPE]) {
 		type = nla_get_u32(info->attrs[CIFS_GENL_ATTR_SWN_NOTIFICATION_TYPE]);
 	} else {
 		cifs_dbg(FYI, "%s: missing notification type attribute\n", __func__);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	switch (type) {
@@ -556,15 +703,18 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 					sizeof(name));
 		} else {
 			cifs_dbg(FYI, "%s: missing resource name attribute\n", __func__);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		if (info->attrs[CIFS_GENL_ATTR_SWN_RESOURCE_STATE]) {
 			state = nla_get_u32(info->attrs[CIFS_GENL_ATTR_SWN_RESOURCE_STATE]);
 		} else {
 			cifs_dbg(FYI, "%s: missing resource state attribute\n", __func__);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
-		return cifs_swn_resource_state_changed(swnreg, name, state);
+		ret = cifs_swn_resource_state_changed(tcon, name, state);
+		break;
 	}
 	case CIFS_SWN_NOTIFICATION_CLIENT_MOVE: {
 		struct sockaddr_storage addr;
@@ -573,28 +723,36 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 			nla_memcpy(&addr, info->attrs[CIFS_GENL_ATTR_SWN_IP], sizeof(addr));
 		} else {
 			cifs_dbg(FYI, "%s: missing IP address attribute\n", __func__);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
-		return cifs_swn_client_move(swnreg, &addr);
+		ret = cifs_swn_client_move(tcon, &addr);
+		break;
 	}
 	default:
 		cifs_dbg(FYI, "%s: unknown notification type %d\n", __func__, type);
 		break;
 	}
 
-	return 0;
+out:
+	cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_swn_notify);
+free_info:
+	cifs_swn_free_reg_info(&swnreg_info);
+	return ret;
 }
 
 int cifs_swn_register(struct cifs_tcon *tcon)
 {
 	struct cifs_swn_reg *swnreg;
+	struct cifs_swn_reg_info swnreg_info;
 	int ret;
 
 	swnreg = cifs_get_swn_reg(tcon);
 	if (IS_ERR(swnreg))
 		return PTR_ERR(swnreg);
 
-	ret = cifs_swn_send_register_message(swnreg);
+	cifs_swn_snapshot_reg(swnreg, &swnreg_info);
+	ret = cifs_swn_send_register_message(&swnreg_info, tcon);
 	if (ret < 0) {
 		cifs_dbg(VFS, "%s: Failed to send swn register message: %d\n", __func__, ret);
 		/* Do not put the swnreg or return error, the echo task will retry */
@@ -615,35 +773,68 @@ int cifs_swn_unregister(struct cifs_tcon *tcon)
 		return PTR_ERR(swnreg);
 	}
 
+	cifs_put_swn_reg_locked(swnreg, tcon);
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 
-	cifs_put_swn_reg(swnreg);
-
 	return 0;
 }
 
-void cifs_swn_dump(struct seq_file *m)
+/*
+ * Snapshot one registration under cifs_swnreg_idr_mutex and return.  Callers
+ * intentionally do the per-registration network/genlmsg work without the
+ * mutex held, both to keep the critical section short and to avoid nesting
+ * cifs_swnreg_idr_mutex inside the higher tc_lock when a live tcon is then
+ * pinned for the send.
+ */
+static int cifs_swn_get_next_reg_info(int *id, struct cifs_swn_reg_info *info)
 {
 	struct cifs_swn_reg *swnreg;
+	int ret = 0;
+
+	mutex_lock(&cifs_swnreg_idr_mutex);
+	swnreg = idr_get_next(&cifs_swnreg_idr, id);
+	if (swnreg) {
+		ret = cifs_swn_dup_reg(swnreg, info);
+		if (!ret) {
+			*id = swnreg->id + 1;
+			ret = 1;
+		}
+	}
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+
+	return ret;
+}
+
+void cifs_swn_dump(struct seq_file *m)
+{
+	struct cifs_swn_reg_info swnreg_info;
+	struct cifs_tcon *tcon;
 	struct sockaddr_in *sa;
 	struct sockaddr_in6 *sa6;
-	int id;
+	int id = 0;
+	int ret;
 
 	seq_puts(m, "Witness registrations:");
 
-	mutex_lock(&cifs_swnreg_idr_mutex);
-	idr_for_each_entry(&cifs_swnreg_idr, swnreg, id) {
+	while ((ret = cifs_swn_get_next_reg_info(&id, &swnreg_info)) > 0) {
 		seq_printf(m, "\nId: %u Refs: %u Network name: '%s'%s Share name: '%s'%s Ip address: ",
-				id, kref_read(&swnreg->ref_count),
-				swnreg->net_name, swnreg->net_name_notify ? "(y)" : "(n)",
-				swnreg->share_name, swnreg->share_name_notify ? "(y)" : "(n)");
-		switch (swnreg->tcon->ses->server->dstaddr.ss_family) {
+			   swnreg_info.id, swnreg_info.ref_count,
+			   swnreg_info.net_name, swnreg_info.net_name_notify ? "(y)" : "(n)",
+			   swnreg_info.share_name, swnreg_info.share_name_notify ? "(y)" : "(n)");
+
+		tcon = cifs_swn_get_tcon(&swnreg_info);
+		if (!tcon) {
+			seq_puts(m, "(no live tcon)");
+			goto next;
+		}
+
+		switch (tcon->ses->server->dstaddr.ss_family) {
 		case AF_INET:
-			sa = (struct sockaddr_in *) &swnreg->tcon->ses->server->dstaddr;
+			sa = (struct sockaddr_in *)&tcon->ses->server->dstaddr;
 			seq_printf(m, "%pI4", &sa->sin_addr.s_addr);
 			break;
 		case AF_INET6:
-			sa6 = (struct sockaddr_in6 *) &swnreg->tcon->ses->server->dstaddr;
+			sa6 = (struct sockaddr_in6 *)&tcon->ses->server->dstaddr;
 			seq_printf(m, "%pI6", &sa6->sin6_addr.s6_addr);
 			if (sa6->sin6_scope_id)
 				seq_printf(m, "%%%u", sa6->sin6_scope_id);
@@ -651,23 +842,38 @@ void cifs_swn_dump(struct seq_file *m)
 		default:
 			seq_puts(m, "(unknown)");
 		}
-		seq_printf(m, "%s", swnreg->ip_notify ? "(y)" : "(n)");
+		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_swn_notify);
+next:
+		seq_printf(m, "%s", swnreg_info.ip_notify ? "(y)" : "(n)");
+		cifs_swn_free_reg_info(&swnreg_info);
 	}
-	mutex_unlock(&cifs_swnreg_idr_mutex);
+	if (ret < 0)
+		seq_printf(m, "\nFailed to snapshot witness registration: %d", ret);
 	seq_puts(m, "\n");
 }
 
 void cifs_swn_check(void)
 {
-	struct cifs_swn_reg *swnreg;
-	int id;
+	struct cifs_swn_reg_info swnreg_info;
+	struct cifs_tcon *tcon;
+	int id = 0;
 	int ret;
 
-	mutex_lock(&cifs_swnreg_idr_mutex);
-	idr_for_each_entry(&cifs_swnreg_idr, swnreg, id) {
-		ret = cifs_swn_send_register_message(swnreg);
+	while ((ret = cifs_swn_get_next_reg_info(&id, &swnreg_info)) > 0) {
+		tcon = cifs_swn_get_tcon(&swnreg_info);
+		if (!tcon) {
+			cifs_dbg(FYI, "%s: registration id %d has no live tcon\n",
+				 __func__, swnreg_info.id);
+			goto free_info;
+		}
+
+		ret = cifs_swn_send_register_message(&swnreg_info, tcon);
 		if (ret < 0)
 			cifs_dbg(FYI, "%s: Failed to send register message: %d\n", __func__, ret);
+		cifs_put_tcon(tcon, netfs_trace_tcon_ref_put_swn_notify);
+free_info:
+		cifs_swn_free_reg_info(&swnreg_info);
 	}
-	mutex_unlock(&cifs_swnreg_idr_mutex);
+	if (ret < 0)
+		cifs_dbg(FYI, "%s: Failed to snapshot registration: %d\n", __func__, ret);
 }
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index fb80bb28fdcffc..ef8e849c09f2c2 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -32,6 +32,7 @@
 	EM(netfs_trace_tcon_ref_get_find,		"GET Find  ") \
 	EM(netfs_trace_tcon_ref_get_find_sess_tcon,	"GET FndSes") \
 	EM(netfs_trace_tcon_ref_get_reconnect_server,	"GET Reconn") \
+	EM(netfs_trace_tcon_ref_get_swn_notify,		"GET SwnNot") \
 	EM(netfs_trace_tcon_ref_new,			"NEW       ") \
 	EM(netfs_trace_tcon_ref_new_ipc,		"NEW Ipc   ") \
 	EM(netfs_trace_tcon_ref_new_reconnect_server,	"NEW Reconn") \
@@ -41,6 +42,7 @@
 	EM(netfs_trace_tcon_ref_put_mnt_ctx,		"PUT MntCtx") \
 	EM(netfs_trace_tcon_ref_put_dfs_refer,		"PUT DfsRfr") \
 	EM(netfs_trace_tcon_ref_put_reconnect_server,	"PUT Reconn") \
+	EM(netfs_trace_tcon_ref_put_swn_notify,		"PUT SwnNot") \
 	EM(netfs_trace_tcon_ref_put_tlink,		"PUT Tlink ") \
 	EM(netfs_trace_tcon_ref_see_cancelled_close,	"SEE Cn-Cls") \
 	EM(netfs_trace_tcon_ref_see_fscache_collision,	"SEE FV-CO!") \
-- 
2.53.0

