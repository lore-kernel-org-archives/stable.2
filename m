Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596650;
	b=H5XEKmOm0pRmXmCkZbA/fhvrBpopjwvzHWJgrr6hFro5Ve5NPTb7ZXdRDNH/mwwGNSHK
	 JSYjHlF5Sf/kZfv2dyJSvImue0wdhQAmOqtHiDfP+C8SmMq/u1pzy5F5e60giBryCIZGH
	 RZsa3FyNO/QW5AaV4VEQYKf2tCdgG3KZ1BfjZp3XlfH9xdjoNZEdx9DZyBfLRbkg2CQJV
	 9amjXcGhgLsG5IH6TFvMaAmYLcVcCEfztgT0cHN9gCblOhFxuhYNGcOY8X99AtMy5EgPB
	 4TJx+q8WXN8dlB65PsG9HsuOSFjMbGGSiA4MhAWz/Vgq7LlkNixxJRpqTs6Ws3Z04tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596650;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DrjcUQEzpPzbsbvwxX4MztNPUXE+25WcXqcwELQkwC8=;
	b=DdA4XeGzwjiGBJzwgK77F35guIGgvFPfuD17dguSCX/Cp0+YGpAjKg+EfAVxJgrYcu5e
	 gx89Jrf+O1QBu4UU9JQYkGnKhVVv+Nolw6myTwIxEVYxJsaEjmN/L46oQqL4qySA9jKRp
	 VnFlapQnMX7GBCe3p7p2LTGIhWrEd3HKFUZ5u0IXb5qGZE9dnIOeXzpL+WHPXvSgt2sz9
	 mYgVD0tMAo3AkUvQqoxlpRPhfqNSHnKFM1s94UHZcanVbtC3WQ7stU/P3UhGVhr07BpDj
	 z2QjGTLZUyIwRGNaWqFsauMhug0z8YEh9cmK30g4WKj/4M+IMNljfgZ46K2eQc2d8cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TF9xwStT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17F606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=TF9xwStT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB4E1F000CA;
	Wed, 25 Nov 2026 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795596649;
	bh=DrjcUQEzpPzbsbvwxX4MztNPUXE+25WcXqcwELQkwC8=;
	h=Subject:To:Cc:From:Date;
	b=TF9xwStTQyY0BFbQRAr1Ma/zqSy7iminlTsrvm1D+b5litJ4BKRUSCg9+X1IhikVZ
	 F4y9CnK20QPhmJdPkf7trqmn/OYbz7JGO53IexqwHOuQoKaZWDUl3q39Qc788JrQm5
	 CXTMRaXgUeqQvt1ka/JPYcb/28hnCzXmv7Hrwl2E=
Subject: FAILED: patch "[PATCH] tools/bootconfig: Close only opened braces in compact output" failed to apply to 6.12-stable tree
To: edumucelli@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:48:13 +0100
Message-ID: <2026112513-patronize-spinster-cf95@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 26fa92f351d4993428268afebf6c60c987477af5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112513-patronize-spinster-cf95@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26fa92f351d4993428268afebf6c60c987477af5 Mon Sep 17 00:00:00 2001
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Date: Tue, 10 Nov 2026 20:08:45 +0100
Subject: [PATCH] tools/bootconfig: Close only opened braces in compact output

A key may have both a value and subkeys. When it has only one subkey,
xbc_show_compact_tree() can print that subkey using dotted notation
without opening a brace. During backtracking, however, it treats the
value node followed by a subkey as evidence that a brace was opened.

For example, a.b=v, a.b.c=w and a.z=q are printed with the brace for a
closed before z. Reading that output back changes a.z into the root key
z, silently changing the configuration.

Check the key children when deciding whether to close a brace. Skip the
value child, and account for a sole subkey that itself has both a value
and subkeys, since that combination is not compacted. This follows the
conditions used to open braces without keeping a depth-indexed array.
Extend the mixed-value/subkey sample to cover the lost sibling.

Link: https://lore.kernel.org/all/6ad67e4cda05238cd173c99e820a85de2c13f5fc.1794337724.git.edumucelli@gmail.com/

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Cc: stable@vger.kernel.org
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 6f476e3c06b8..d3f840c5adce 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -68,6 +68,23 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
 	return i;
 }
 
+/* Match the conditions under which the compact formatter opens braces. */
+static bool xbc_node_needs_braces(struct xbc_node *node)
+{
+	struct xbc_node *child = xbc_node_get_child(node);
+
+	if (child && xbc_node_is_value(child))
+		child = xbc_node_get_next(child);
+	if (!child)
+		return false;
+	if (child->next)
+		return true;
+
+	/* A single subkey with both a value and subkeys is not compacted. */
+	child = xbc_node_get_child(child);
+	return child && xbc_node_is_value(child) && child->next;
+}
+
 static void xbc_show_compact_tree(void)
 {
 	struct xbc_node *node, *cnode = NULL, *vnode;
@@ -128,14 +145,12 @@ static void xbc_show_compact_tree(void)
 			node = xbc_node_get_parent(node);
 			if (!node)
 				return;
-			if (!xbc_node_get_child(node)->next)
+			if (!depth || !xbc_node_needs_braces(node))
 				continue;
-			if (depth) {
-				depth--;
-				for (i = 0; i < depth; i++)
-					printf("\t");
-				printf("}\n");
-			}
+			depth--;
+			for (i = 0; i < depth; i++)
+				printf("\t");
+			printf("}\n");
 		}
 		node = xbc_node_get_next(node);
 	}
diff --git a/tools/bootconfig/samples/exp-good-mixed-kv1.bconf b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
index 8346287d9251..0b8b2f59da31 100644
--- a/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
+++ b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
@@ -1,2 +1,7 @@
 key = "value";
 key.subkey = "another-value";
+a {
+	b = "v";
+	b.c = "w";
+	z = "q";
+}
diff --git a/tools/bootconfig/samples/good-mixed-kv1.bconf b/tools/bootconfig/samples/good-mixed-kv1.bconf
index 1761547dd05c..35442ee62b75 100644
--- a/tools/bootconfig/samples/good-mixed-kv1.bconf
+++ b/tools/bootconfig/samples/good-mixed-kv1.bconf
@@ -1,3 +1,8 @@
 # value -> subkey pattern
 key = value
 key.subkey = another-value
+
+# A valued parent with one subkey must not close its enclosing brace.
+a.b = v
+a.b.c = w
+a.z = q

