Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0BD25E469
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788575218; cv=none; b=hiYbyMNKuNIWJNrsPi2lUbbHHpEHHq5XwRmbndrKI6enioluerhieKLABNCsGzAEFwEWT02f56zp9uQ85gTyGDjsfaFc6aDrzc7xFRS9Wx500SgE55Wd00OYmgrQR3OArPevp8K1VkwM8nzJNLqX87gPzWnZOzC4IPg3UnOUYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788575218; c=relaxed/simple;
	bh=r8NzdIDhM2Ag9d2nVX+vxNZPkkf/P2sPsBGhQodUUTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTGzg1eblSN2l/BuaWUjHHP/OU6a1ZmnxC7KuqON5PWlfqe3wzl4yheJ3D0b1e01JbSbokvxoLJqsNkv1zO9iqnePUDbgHWfH/mGUN+Kn1NzLzOGHa9L5GpFN6T9d/ACYoB3XoVy6CsNDJLPVMDoyliLSyfxo/KWwIA/jSDylMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFVpdJUJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFVpdJUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E65A1F00A3D;
	Sat,  5 Sep 2026 02:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788575216;
	bh=H0oakASQnd7vrNRw2NKSe1WoxbWAGjb+wcG/S9V64C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFVpdJUJDeblm6pckPjdSbul6Pl3TkFAI3Z5LtLzjf8F2M1B5o7Mbl5gTuPOZvKL4
	 mLgiahMt7iciGEq0ImtW9Ysh1Is1XI8iCwSfUAW0BpkWPdtqIE3YE2S87pU4UjsHYr
	 j0K1S63kti38CasDtxqkkSpMe9qmh8knBLobxjWC6nvQriFG1q3KOOr4h8QmaSUtE6
	 Ep8jfPAGOl9/KFR2kFcRRwuw3SDx4v4V0D/D9G7O0iuuEKvdvdfuIX/YxjeXluMIUM
	 k+ZkuC4mqkHOGiNj/j9GY/yQqUeUO84XB8XK4UvUXzNTdwdLJw7PkqYYCVQLDp+NkL
	 Ti4hruBgJiFwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Carolina Jubran <cjubran@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] netlink: introduce type-checking attribute iteration for nlmsg
Date: Fri,  4 Sep 2026 22:26:53 -0400
Message-ID: <20260905022654.1856817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-bully-unsightly-dc1a@gregkh>
References: <2026090327-bully-unsightly-dc1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

[ Upstream commit 42401c42389622424f2973ec57414f033ae6be8f ]

Add the nlmsg_for_each_attr_type() macro to simplify iteration over
attributes of a specific type in a Netlink message.

Convert existing users in vxlan and nfsd to use the new macro.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Link: https://patch.msgid.link/20250629142138.361537-2-mbloch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: bdcc85c2b05a ("nfsd: validate sockaddr length per family in listener_set")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 13 ++++-------
 fs/nfsd/nfsctl.c                    | 36 +++++++++++------------------
 include/net/netlink.h               | 14 +++++++++++
 3 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 272fa31ef0745..4f2e2e84c9599 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -980,15 +980,10 @@ static int vxlan_vnifilter_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
 		return -EOPNOTSUPP;
 
-	nlmsg_for_each_attr(attr, nlh, sizeof(*tmsg), rem) {
-		switch (nla_type(attr)) {
-		case VXLAN_VNIFILTER_ENTRY:
-			err = vxlan_process_vni_filter(vxlan, attr,
-						       nlh->nlmsg_type, extack);
-			break;
-		default:
-			continue;
-		}
+	nlmsg_for_each_attr_type(attr, VXLAN_VNIFILTER_ENTRY, nlh,
+				 sizeof(*tmsg), rem) {
+		err = vxlan_process_vni_filter(vxlan, attr, nlh->nlmsg_type,
+					       extack);
 		vnis++;
 		if (err)
 			break;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7b0a6beee96ed..7854573e90009 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1679,10 +1679,9 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* count number of SERVER_THREADS values */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-		if (nla_type(attr) == NFSD_A_SERVER_THREADS)
-			nrpools++;
-	}
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_THREADS, info->nlhdr,
+				 GENL_HDRLEN, rem)
+		nrpools++;
 
 	mutex_lock(&nfsd_mutex);
 
@@ -1693,12 +1692,11 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	i = 0;
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
-		if (nla_type(attr) == NFSD_A_SERVER_THREADS) {
-			nthreads[i++] = nla_get_u32(attr);
-			if (i >= nrpools)
-				break;
-		}
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_THREADS, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		nthreads[i++] = nla_get_u32(attr);
+		if (i >= nrpools)
+			break;
 	}
 
 	if (info->attrs[NFSD_A_SERVER_GRACETIME] ||
@@ -1839,14 +1837,12 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info)
 	for (i = 0; i <= NFSD_SUPPORTED_MINOR_VERSION; i++)
 		nfsd_minorversion(nn, i, NFSD_CLEAR);
 
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_PROTO_VERSION, info->nlhdr,
+				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
 		u32 major, minor = 0;
 		bool enabled;
 
-		if (nla_type(attr) != NFSD_A_SERVER_PROTO_VERSION)
-			continue;
-
 		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
 				     nfsd_version_nl_policy, info->extack) < 0)
 			continue;
@@ -1997,14 +1993,12 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	 * Walk the list of server_socks from userland and move any that match
 	 * back to sv_permsocks
 	 */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
+				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
 		const char *xcl_name;
 		struct sockaddr *sa;
 
-		if (nla_type(attr) != NFSD_A_SERVER_SOCK_ADDR)
-			continue;
-
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
@@ -2059,15 +2053,13 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		svc_xprt_destroy_all(serv, net);
 
 	/* walk list of addrs again, open any that still don't exist */
-	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
+				 GENL_HDRLEN, rem) {
 		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
 		const char *xcl_name;
 		struct sockaddr *sa;
 		int ret;
 
-		if (nla_type(attr) != NFSD_A_SERVER_SOCK_ADDR)
-			continue;
-
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
diff --git a/include/net/netlink.h b/include/net/netlink.h
index db6af207287c8..bcc1ad092b515 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -68,6 +68,8 @@
  *   nlmsg_for_each_msg()		loop over all messages
  *   nlmsg_validate()			validate netlink message incl. attrs
  *   nlmsg_for_each_attr()		loop over all attributes
+ *   nlmsg_for_each_attr_type()		loop over all attributes with the
+ *					given type
  *
  * Misc:
  *   nlmsg_report()			report back to application?
@@ -940,6 +942,18 @@ static inline u32 nlmsg_seq(const struct nlmsghdr *nlh)
 	nla_for_each_attr(pos, nlmsg_attrdata(nlh, hdrlen), \
 			  nlmsg_attrlen(nlh, hdrlen), rem)
 
+/**
+ * nlmsg_for_each_attr_type - iterate over a stream of attributes
+ * @pos: loop counter, set to the current attribute
+ * @type: required attribute type for @pos
+ * @nlh: netlink message header
+ * @hdrlen: length of the family specific header
+ * @rem: initialized to len, holds bytes currently remaining in stream
+ */
+#define nlmsg_for_each_attr_type(pos, type, nlh, hdrlen, rem) \
+	nlmsg_for_each_attr(pos, nlh, hdrlen, rem) \
+		if (nla_type(pos) == type)
+
 /**
  * nlmsg_put - Add a new netlink message to an skb
  * @skb: socket buffer to store message in
-- 
2.53.0

