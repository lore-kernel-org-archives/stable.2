Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9414B1D1B
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585665; cv=none; b=qFtDkfdO2UcsIaJnGiGjTbdQwvipFUvrhlEimBqmWAS3/QgvgYN3NywKTNmayH4YKY8rMGJGlm7XHKlMKkR1Yk2ZNQGe4isVe877EfFhuxni1zRO9Y/0sFEJ4OzSnB3TDEpjpG7GaAMBU0Hq77dw87Qmcp4knEm17i/DDSZoL7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585665; c=relaxed/simple;
	bh=B0BdSaCDPkx4WRgi3+vlokUd3ar6k8DeHkGl/Bio3fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDBGeov/e1P68HL0Ve8Mwg0lKlBWoJFuOebAZAQsT7m7Vcu9qbeZOZBr6n5mXYUBS42Pwq8xOC/0XlJjA6oJYSjAOO0ILdAtX/6xOqePYjC4I8MtPMiEVvMEfPWmKATtqBhTrE6gA2ewdjOqX+VyGBNRtPLbDVg4lTxrdxWNtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgECEVah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgECEVah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3D81F00898;
	Wed, 16 Sep 2026 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789585658;
	bh=H0vl2R6m6s37TJAau7MoylmqerpmNelJg9GjiZuIpzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lgECEVah4tYjFeOj8w7A9RwQUNq1rZC+AqY59m0ISUw+copVGle6Kk2cbEBvuRXlm
	 d3NxoWDx98QY20XoRGRliHKD/znldYqG8b+mBaqnJmfy0uVI0KL0KJYOw0FW2eV1Eu
	 yZbg9p4cyEJ4mBbcIRn6WO3+28LN52naxD8XQMNGkKp8Fv0oXPWycY620F8VSjzrKk
	 gg2hOLxRz0e52DMjK9aIaFJxfYXsu2+8w9AcTpXWN4ECb2PdAEhgFQvThO04l7VNnR
	 J02HGBBKoRN/8ijjWAvey+fT62xnSSg6eCMEf3FCWD0oDR8UDBo6agrJf8dhRl0EPL
	 oabhup2yGu8FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/7] bootconfig: Change array value to use child node
Date: Wed, 16 Sep 2026 15:07:30 -0400
Message-ID: <20260916190735.1968203-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916190735.1968203-1-sashal@kernel.org>
References: <2026091617-cackle-deeply-2ea2@gregkh>
 <20260916190735.1968203-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit ca24306d83a125df187ad53eddb038fe0cffb8ca ]

It is not possible to put an array value with subkeys under
a key node, because both of subkeys and the array elements
are using "next" field of the xbc_node.

Thus this changes the array values to use "child" field in
the array case. The reason why split this change is to
test it easily.

Link: https://lkml.kernel.org/r/162262193838.264090.16044473274501498656.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Stable-dep-of: 462d0b066b61 ("tools/bootconfig: Fix integer overflow and truncation in size checks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/bootconfig.c       |  2 +-
 include/linux/bootconfig.h |  6 +++---
 lib/bootconfig.c           | 23 +++++++++++++++++++----
 tools/bootconfig/main.c    |  2 +-
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index d82dae133243b..2e244ada1f970 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -51,7 +51,7 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				else
 					q = '"';
 				ret = snprintf(dst, rest(dst, end), "%c%s%c%s",
-					q, val, q, vnode->next ? ", " : "\n");
+					q, val, q, xbc_node_is_array(vnode) ? ", " : "\n");
 				if (ret < 0)
 					goto out;
 				dst += ret;
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 39d2e2468c237..2c5f0b2484caa 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -71,7 +71,7 @@ static inline __init bool xbc_node_is_key(struct xbc_node *node)
  */
 static inline __init bool xbc_node_is_array(struct xbc_node *node)
 {
-	return xbc_node_is_value(node) && node->next != 0;
+	return xbc_node_is_value(node) && node->child != 0;
 }
 
 /**
@@ -140,7 +140,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
  */
 #define xbc_array_for_each_value(anode, value)				\
 	for (value = xbc_node_get_data(anode); anode != NULL ;		\
-	     anode = xbc_node_get_next(anode),				\
+	     anode = xbc_node_get_child(anode),				\
 	     value = anode ? xbc_node_get_data(anode) : NULL)
 
 /**
@@ -171,7 +171,7 @@ static inline struct xbc_node * __init xbc_find_node(const char *key)
  */
 #define xbc_node_for_each_array_value(node, key, anode, value)		\
 	for (value = xbc_node_find_value(node, key, &anode); value != NULL; \
-	     anode = xbc_node_get_next(anode),				\
+	     anode = xbc_node_get_child(anode),				\
 	     value = anode ? xbc_node_get_data(anode) : NULL)
 
 /**
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index f6bede03c6926..36146607912e8 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -432,6 +432,14 @@ static inline __init struct xbc_node *xbc_last_sibling(struct xbc_node *node)
 	return node;
 }
 
+static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
+{
+	while (node->child)
+		node = xbc_node_get_child(node);
+
+	return node;
+}
+
 static struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
@@ -582,17 +590,20 @@ static int __init xbc_parse_array(char **__v)
 	char *next;
 	int c = 0;
 
+	if (last_parent->child)
+		last_parent = xbc_node_get_child(last_parent);
+
 	do {
 		c = __xbc_parse_value(__v, &next);
 		if (c < 0)
 			return c;
 
-		node = xbc_add_sibling(*__v, XBC_VALUE);
+		node = xbc_add_child(*__v, XBC_VALUE);
 		if (!node)
 			return -ENOMEM;
 		*__v = next;
 	} while (c == ',');
-	node->next = 0;
+	node->child = 0;
 
 	return c;
 }
@@ -680,8 +691,12 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 
 	if (op == ':' && child) {
 		xbc_init_node(child, v, XBC_VALUE);
-	} else if (!xbc_add_sibling(v, XBC_VALUE))
-		return -ENOMEM;
+	} else {
+		if (op == '+' && child)
+			last_parent = xbc_last_child(child);
+		if (!xbc_add_sibling(v, XBC_VALUE))
+			return -ENOMEM;
+	}
 
 	if (c == ',') {	/* Array */
 		c = xbc_parse_array(&next);
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6862afd66cfd3..b276fb75065e4 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -27,7 +27,7 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 			q = '\'';
 		else
 			q = '"';
-		printf("%c%s%c%s", q, val, q, node->next ? ", " : eol);
+		printf("%c%s%c%s", q, val, q, xbc_node_is_array(node) ? ", " : eol);
 		i++;
 	}
 	return i;
-- 
2.53.0

