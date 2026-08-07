Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D242FCCE
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103298; cv=none; b=FdArhTb4G6rjxiYsALHzM5GDzcCDPnXiLPNlYNfHsccbVPg1zNyyaqJGywqUIa3jTSRhgQZFkA3Y/erXEO1Q4IdhiLo0VnZB5kW3jItaEI7CkUG2FxGubGm5Ws2cCNGNmXMF5h387xurkddZ52yQjf06I+Z+6APyNDZn4wIXLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103298; c=relaxed/simple;
	bh=zoRwDdpjC4Af44XxoH+tpcsYRlFvltA9Zuma+BQCBT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opPiKZGi+TZI5oMMdkb/MXP9M8hqwdIRsiN0XXfe/wSizjagzLKvj4RniExK52I8G7M8YH9w7lEqp1hoYnbhxOy/Y+KV9cuBJYZm7Z64g+gLV51vQ0rZohQrnOhapl3OJEYdWbkPU/bvLCDauu/+dkM92I6ggz/zCnnfZMMAevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfbNMRjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfbNMRjf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889A91F000E9;
	Fri,  7 Aug 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103291;
	bh=yc7GW68avlvUb71DR4Tl/slU1TuL3T4rOZDoQGp1LGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KfbNMRjf3NNhAhMAkOt+bJWsiYQNyB9noKHkzSoqBOaM6Kwb+uP2BDRzEb93z1wjM
	 2ykJ3MsPxFTrhDEwgB5zQ2bbEGiP/U3AlTtNh0o37mbrN5L6ZG0QsSfrNkFfpbs5vx
	 eNWoIxqlrspOu/QC1rSDgHLtvp46hyqXgDO51FHEJc+BB2yHaCPOojqn1KwNP2RzPl
	 WSQoWbX/An7pZXc/3MgGe4lGjWBb+37GjzqUWysZbP2I06uQatLbvT8QBVsEKeMZFI
	 tS1rXGiSJfYPovIRk64WR6URUmr3G/kTzwdr3Ovnp0uJT8IPvjy7C33TUVM/sTtQxs
	 TygKZJRQCc79w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] libceph: add doutc and *_client debug macros support
Date: Fri,  7 Aug 2026 07:48:06 -0400
Message-ID: <20260807114809.2056244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072936-dispersal-unwanted-0d62@gregkh>
References: <2026072936-dispersal-unwanted-0d62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 5c5f0d2b5f92c47baf82b9b211e27edd7d195158 ]

This will help print the fsid and client's global_id in debug logs,
and also print the function names.

[ idryomov: %lld -> %llu, leading space for doutc(), don't include
  __func__ in pr_*() variants ]

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: c3e64079d8b9 ("ceph: fix refcount leak in ceph_readdir()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ceph/ceph_debug.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index d5a5da838cafa..11a92a946016e 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -19,12 +19,25 @@
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
+#  define doutc(client, fmt, ...)					\
+	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,			\
+		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
+		 kbasename(__FILE__), __LINE__,				\
+		 &client->fsid, client->monc.auth->global_id,		\
+		 ##__VA_ARGS__)
 # else
 /* faux printk call just to see any compiler warnings. */
 #  define dout(fmt, ...)	do {				\
 		if (0)						\
 			printk(KERN_DEBUG fmt, ##__VA_ARGS__);	\
 	} while (0)
+#  define doutc(client, fmt, ...)	do {			\
+		if (0)						\
+			printk(KERN_DEBUG "[%pU %llu] " fmt,	\
+			&client->fsid,				\
+			client->monc.auth->global_id,		\
+			##__VA_ARGS__);				\
+		} while (0)
 # endif
 
 #else
@@ -33,7 +46,32 @@
  * or, just wrap pr_debug
  */
 # define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
+# define doutc(client, fmt, ...)					\
+	pr_debug(" [%pU %llu] %s: " fmt, &client->fsid,			\
+		 client->monc.auth->global_id, __func__, ##__VA_ARGS__)
 
 #endif
 
+#define pr_notice_client(client, fmt, ...)				\
+	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
+		  client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_info_client(client, fmt, ...)				\
+	pr_info("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_client(client, fmt, ...)				\
+	pr_warn("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_once_client(client, fmt, ...)				\
+	pr_warn_once("[%pU %llu]: " fmt, &client->fsid,			\
+		     client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_client(client, fmt, ...)					\
+	pr_err("[%pU %llu]: " fmt, &client->fsid,			\
+	       client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_ratelimited_client(client, fmt, ...)			\
+	pr_warn_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			    client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_ratelimited_client(client, fmt, ...)			\
+	pr_err_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			   client->monc.auth->global_id, ##__VA_ARGS__)
+
 #endif
-- 
2.53.0

