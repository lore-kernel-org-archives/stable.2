Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AB30596F
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788575219; cv=none; b=Q4LcfC3uNSIQdLgwnFUiKVMsS1ea1lAhKeOEu8L7q9YU9yD3ej/FRTcb2dj6HYXlip63R7TYuNnEz9OfGigvC1ZZdFRb8rh0+4b/ofDquZubhg54XSRatyzqFk86mKNeEg4LZJJIxT/vkQGPZ1neAPheu8tGGohu1EQ9nAQd6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788575219; c=relaxed/simple;
	bh=3b+kJxQ4vmsekx4uApiQg+shmNteRTZNlSicSubMj/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtKoufKjMiRKwQENm0r6ZX/Ai0QmZMJDkUralcVGIuFZiKN1YQqIJRK71bT5hmCJPB+2MvoW+9qyrES6wBHYXNCC4qQI/zP5pnrCepsFMc2LG/osBlAX8YfgtkJxR8hus12BBdZ7vZy+4zybtw/RHDv3y7ObDlll19HCMBfwt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkV8eHy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkV8eHy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7A01F00AC4;
	Sat,  5 Sep 2026 02:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788575217;
	bh=yOzr8sWHQB9Vzbcvt55l1EhBwFXspgVmq06vxnHm9UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BkV8eHy+6s9SVFOVkmKQmXbVkskvkmezT8ZSQI5hRvKcPmRHqo1sdxtauAoATHp2V
	 RFAL9zSF3x9S1+9kzQ7GBZrRdEiQaZfHfbcUfR5SB2TcGH9ImhXiVFXtJPLcNDxDHY
	 SsoI+vmTMpyS4vyKOfy1A8/OmqT+e7JekSG4erXb5LuGRbswVc4/U90f0T+leyv75q
	 qMrtUptKZlKBeUuBEciewGjhbzZX389Vjh5RcyjC1zxzz7fEzfM3tZUC1t+XlyCChz
	 L66mVLF0dqDhQ1EHvx8XPRlFa72ahWDt0p1oTShNXTscb6l3LogWgMQwocR4d2rnm5
	 P55/UE6WJHgpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] nfsd: validate sockaddr length per family in listener_set
Date: Fri,  4 Sep 2026 22:26:54 -0400
Message-ID: <20260905022654.1856817-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905022654.1856817-1-sashal@kernel.org>
References: <2026090327-bully-unsightly-dc1a@gregkh>
 <20260905022654.1856817-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit bdcc85c2b05a9378d8bd2d65f9fc41440a3cf464 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsctl.c | 77 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7854573e90009..15c4397f09dfc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1955,6 +1955,60 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1973,6 +2027,15 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
@@ -1999,16 +2062,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -2060,16 +2118,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
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
 
-- 
2.53.0

