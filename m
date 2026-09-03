Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFE4483A1
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441547; cv=none; b=QvSMGY4eSlayegOEybKn/+lQVhkNJ5aTZH++WDlGVHAVo8AKa7CG1svYk5URMcGvbsLc3Y79pDYWczapnuccx5bP042GuMqNFie97b9cu8xOT4venMjOQbBnoe9eVvEFCm4JxwQJO6onHwqdbkUipTM8h3SYub1UPEiNYC5T6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441547; c=relaxed/simple;
	bh=pORN9a666Krqf9vOnQLmxbCcLcB4KAGymoTNayjn8tg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ajVBXf1m8bSxoHD5EHqF7RdywpoYUh62AgJ2MWdat4G7UbpD542k/ov3q7F/JuGiarVI656f4wUsL3Lt+HdOw6vhf9+qK9rUT6U4u9aaGPe4mn9rHlVhBRKD+N6zY6Ig55AO6hgRJnJQeInONLfrfHTwMDGKlINl+zy9HhW6t0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EVOnRPiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EVOnRPiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2831F00ACA;
	Thu,  3 Sep 2026 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788441534;
	bh=4bnkunhXuIUseD54oUyrPykqDvQqew4wmt2OXDVlgQA=;
	h=Subject:To:Cc:From:Date;
	b=EVOnRPiqV3SjIL1aZiOYaQ/jzpHIsMX3SXdoz4kSwoWaDPnfIiXF41j99H3c8Ki7L
	 pJzjZR6EJZ02VL/1fV/Avli4BN/CtP0TyidFBcb6NZoSVFlw44caXJeg1ETpLJz7K5
	 cR2NNg1plp3xO+Zq5rxxWu5A3dbPqoTlP4Ygs3t4=
Subject: FAILED: patch "[PATCH] nfsd: validate sockaddr length per family in listener_set" failed to apply to 6.12-stable tree
To: jlayton@kernel.org,cel@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:11:27 +0200
Message-ID: <2026090327-bully-unsightly-dc1a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bdcc85c2b05a9378d8bd2d65f9fc41440a3cf464
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-bully-unsightly-dc1a@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bdcc85c2b05a9378d8bd2d65f9fc41440a3cf464 Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jun 2026 14:31:25 -0400
Subject: [PATCH] nfsd: validate sockaddr length per family in listener_set

nfsd_sock_nl_policy declares NFSD_A_SOCK_ADDR as a bare NLA_BINARY
attribute with no minimum length. A CAP_NET_ADMIN caller can send a
16-byte NFSD_A_SOCK_ADDR with sa_family=AF_INET6, causing a 12-byte
OOB read across three consumers (rpc_cmp_addr_port, svc_find_listener,
kernel_bind).

nfsd_nl_listener_set_doit() also parsed and validated each listener
entry inline in two separate loops, interleaved with mutating the
running listener configuration. The validation was duplicated, used an
open-coded "nla_len < sizeof(struct sockaddr)" check that was too short
for AF_INET6, and handled a malformed entry inconsistently depending on
which loop noticed it.

Add an nfsd_nl_validate_listeners() helper that walks the entire list
once and confirms each entry parses, carries both an address and a
transport name, and is long enough for its address family
(sizeof(struct sockaddr_in) for AF_INET, sizeof(struct sockaddr_in6)
for AF_INET6, -EAFNOSUPPORT otherwise). Call it before taking
nfsd_mutex or creating the serv, so a malformed request fails cleanly
with no side effects.

Since every entry is known valid by the time the two existing loops
run, drop the redundant presence and per-family length checks from
both, leaving only the nla_parse_nested() call needed to extract the
data.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260615-nfsd-testing-v5-1-188d75aedda0@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f1ecbb13f642..caf59421f8f4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1971,6 +1971,60 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_validate_listeners - sanity-check the listener list from userland
+ * @info: netlink metadata and command arguments
+ *
+ * Walk every NFSD_A_SERVER_SOCK_ADDR attribute and confirm that each entry
+ * is well-formed: it parses against the policy, carries both an address and
+ * a transport name, and the address is long enough for its family. Doing
+ * this up front lets the callers below assume every entry is valid and
+ * guarantees we make no changes when the request is malformed.
+ *
+ * Return: 0 if every entry is valid, or a negative errno otherwise.
+ */
+static int nfsd_nl_validate_listeners(struct genl_info *info)
+{
+	const struct nlattr *attr;
+	int rem;
+
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
+		struct sockaddr *sa;
+		int err;
+
+		err = nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
+				       nfsd_sock_nl_policy, info->extack);
+		if (err < 0)
+			return err;
+
+		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
+			return -EINVAL;
+
+		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
+		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(sa->sa_family))
+			return -EINVAL;
+
+		switch (sa->sa_family) {
+		case AF_INET:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in))
+				return -EINVAL;
+			break;
+		case AF_INET6:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in6))
+				return -EINVAL;
+			break;
+		default:
+			return -EAFNOSUPPORT;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * nfsd_nl_listener_set_doit - set the nfs running sockets
  * @skb: reply buffer
@@ -1989,6 +2043,15 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	bool delete = false;
 	int err, rem;
 
+	/*
+	 * Validate the entire listener list before making any changes, so a
+	 * malformed request fails cleanly without creating a serv or touching
+	 * the existing listeners.
+	 */
+	err = nfsd_nl_validate_listeners(info);
+	if (err)
+		return err;
+
 	mutex_lock(&nfsd_mutex);
 
 	err = nfsd_create_serv(net);
@@ -2015,16 +2078,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		const char *xcl_name;
 		struct sockaddr *sa;
 
+		/* validated up front in nfsd_nl_validate_listeners() */
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
 
-		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
-			continue;
-
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
@@ -2076,16 +2134,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		struct sockaddr *sa;
 		int ret;
 
+		/* validated up front in nfsd_nl_validate_listeners() */
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
 
-		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
-			continue;
-
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 

