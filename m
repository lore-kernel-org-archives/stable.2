Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602781;
	b=4hDUERnYqYCbYLprGMjAPTLY5rDSDI9kK3JRTufa5krqOh5r2qkRmkiM/MzkdUyudms3
	 iUmWTEdtDxAeL+Rw15lr9KpM4g7TFU98kelQ2B2HsFUxi0QfVY8q/F7eGEnfm9UFdDMj3
	 DVJH3ORvClbt2b6ANf012hmbzoWXz0twoJJBUP8jv73qQ6R28HxzVJrbZRTM4xXFwKG90
	 OalI/uSdOf1+vbP52SBhe9D61JHL+ZfqWnD+VYzx8PYJA+g8c4cOecwZhgOGdOISWug8i
	 nkoy8narjZrq09JA0JtIIhKdWJh+x5HDQyiBh7lnsUYiJXeMs++CLmLJ1ObXYqJCR2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D70B3ztBwMYUR86TjFMf+u8FJbSnTjMRLkpHsPBIJJc=;
	b=GXjaI6USmZjyO+FbO8NYt/VhwdltS1D8UJNGZYC9nrR4QjbZ5HsvMDQVS6BzndW8D8DD
	 owxSjv4Pb9ETegpMdmN2RXWxViNjVItDrI8vvgkmLu4NlsTtBv5jbkxwkcMHsQ/a/Mhk1
	 ZGAIkjeuMnAsGYqc/mCQIh6dRmqokV/ycC8Dv+KR18hgSyc4xQOW1I0J2kCseZUZLAknz
	 +PRz8Pz51hpNZDIe990CbyNAKL16XwEhTZz68QVhygs7HtiCsoNothlz83VutrWmrklqx
	 vlUq9QGoAvl7ENliUu/wuZPrOQzmmDDEqZG8MmlD0jfgKyHuJbckvP74b/ruFbetavw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LQDSy5P3;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630A606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2630A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LQDSy5P3
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so57175415e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795602779; x=1796207579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D70B3ztBwMYUR86TjFMf+u8FJbSnTjMRLkpHsPBIJJc=;
        b=LQDSy5P3LhpyWBDIhwce6A4J2KJt96sfWchyEqgH9hxV7VhgmFqtvInpWZh74dDfzZ
         1s3efsa6zkNYuwqxY/ZqQiJbS2Mh+Vi2FNVTsvMcjwucgaMR1TaqJJvhBonUP/bKD+uq
         LR32jiEqtDpDIN+B3gZeIY8jqZjDWOxBUyzw42Ck2ERGy87T34oBPTjluQmItalLzLs0
         WJnQEwyDvyppVrushipnZ8lQy5C5k6gnaQ4A29xk6Mxwtx3rb7h2fNxjT+weOtZuVc3R
         Zh2CvBkEHFJC/M36SFaJkhuDUCPSxsDG64o8QqIo8aIp9nMds5k9QesppdFX5akGiGYF
         rkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602779; x=1796207579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D70B3ztBwMYUR86TjFMf+u8FJbSnTjMRLkpHsPBIJJc=;
        b=fmrHxyGpFOg2uQQEsCvfSLocD+VP401Hr1zoGcEjca80iQEGV5RZJGUAKeNt/DCFM6
         VNczJlTQAOrRXRilkdRtbaMhIdLeFZZIyYhvMmKHhXQwTgAi/bc7/MtjVy8HE040Exqm
         JN+/UuK+oyscuGPH5h1RXlrtKWPZTmCwtlgChfdboo2ID+4ZTUuUaVAp8ydHGumG7qiV
         DLOqHHksadBlBzKyvGEShGXzw/1VxUlR5XkjjRQU7nYdy4lIuSOYNIHPh7b+Eg0aP8SK
         w7xixZKLsoOTjbcTQ6bE5U3YMWWhApQ+gkeKtzAaju9pO2pM3e3gDIqeNMNuFCwVkbCT
         osSw==
X-Gm-Message-State: APuU4Z81R1wd+YOnjfamy6GOl+YTd4ctQ/8tRHykyEz6fVBltovGIDlC
	IrucIbZXURCMAVuOWovygSWwQQ822oGO+xJEXA6roIj/svatlaI/GBlShxovhg==
X-Gm-Gg: AZFdTZdVkBjv7m80WIFrwPgXDsCwKDWQUt62hArBJ7KZoV3ddW5Ph0OHIR2HXpF0qQG
	EH4fA9SCfD8xfjiD0CvZ+LNYEcGZUY4qQvUPolM0OIDHuxQSNZ8DyBWzF5RTG/iL3MMu+ch50Wm
	WEKQJm3JACC/vnjfURR1gB/uSHqc6tMySGTuwveVMyPbD6RZQd84yjTvAKb4w/t9aoDNAWAcXFH
	NtnH9afiZlNNNqqmCnoYJ10KeRq1qrxQ3XhhwlbySkqONO0n3PfPGGbx0+qBJNDpuESFQdc8iL0
	KWcocMc3yxSEQLGasth+5lBr6FO0HJkRUnZBPqZOWbhhDAS+CfV6VWl1EU4RDdzGLsL+pROi7UU
	zfORr9gdGTFvePpCrM4vhmbA76ttmAb6/NRQgc5XnFQFjUKuuZuSxzbo0YLFRTXOmZQqFjItHye
	J03FY9AO5ig1dHpBV5evQcNFICst4XQtkY+AoNWXCZMy4NU093u9kC1zQsloerUT+6M0i5VamHv
	5VkyfpJXKocEFIIcQfwxFaEmTFyU25GmOJ9Rp9LALosbZZ+bapMxO27VrPHwSAXAK9OVUI69U/m
	+PlvIUGdta0vO/r0NDV5l1Ans3/E+lE39avnX23xrmgA9kha4ObC4urQN6PlC1yXz7f+l1YOWC7
	jFAHxvlhP+c3lXHAlfaMze9bKOAIaZlpQmgh2MfNJp4J1crQJjZNQZyqpeeufPxub4xBkaAH92z
	s6nWibbrlRroi70WXVHKAbX49cUOIhSy+R6qLReff27AXw67S1eqwXBjQ2myEFxKErW5RKQ7ZZI
	yv7RbE0nBRJru05Cg==
X-Received: by 2002:a05:600c:154e:b0:4a3:59ee:86b with SMTP id 5b1f17b1804b1-4bb887c3b63mr374460905e9.4.1795602779418;
        Wed, 25 Nov 2026 02:32:59 -0800 (PST)
Received: from longitude (2a02-8434-fda5-4201-fb56-7a23-de2e-e3d4.rev.sfr.net. [2a02:8434:fda5:4201:fb56:7a23:de2e:e3d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm27424238f8f.45.2026.11.25.02.32.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:32:59 -0800 (PST)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] tools/bootconfig: Close only opened braces in compact output
Date: Wed, 25 Nov 2026 11:32:33 +0100
Message-ID: <9f493c8011044edc5af3cb20ed7be18f6e9d0253.1795602751.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112515-salary-cover-90e1@gregkh>
References: <2026112515-salary-cover-90e1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 26fa92f351d4993428268afebf6c60c987477af5 upstream.

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

The stable test script only checks whether the good samples can
be attached. Add the compact-output comparison for the extended
mixed-value/subkey sample and add its expected output file.

Link: https://lore.kernel.org/all/6ad67e4cda05238cd173c99e820a85de2c13f5fc.1794337724.git.edumucelli@gmail.com/

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
Hi Greg,

Thanks for the notice. The formatter hunk applies unchanged to
5.15.y. I added the expected output and a comparison to the stable
test script. The comparison fails before the fix and passes after
it. The full bootconfig suite passes with the backport.

Thanks,
Eduardo

 tools/bootconfig/main.c                       | 29 ++++++++++++++-----
 .../samples/exp-good-mixed-kv1.bconf          |  7 +++++
 tools/bootconfig/samples/good-mixed-kv1.bconf |  5 ++++
 tools/bootconfig/test-bootconfig.sh           |  6 ++++
 4 files changed, 40 insertions(+), 7 deletions(-)
 create mode 100644 tools/bootconfig/samples/exp-good-mixed-kv1.bconf

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 78b252ac38..f21090809a 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -33,6 +33,23 @@ static int xbc_show_value(struct xbc_node *node, bool semicolon)
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
@@ -93,14 +110,12 @@ static void xbc_show_compact_tree(void)
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
new file mode 100644
index 0000000000..0b8b2f59da
--- /dev/null
+++ b/tools/bootconfig/samples/exp-good-mixed-kv1.bconf
@@ -0,0 +1,7 @@
+key = "value";
+key.subkey = "another-value";
+a {
+	b = "v";
+	b.c = "w";
+	z = "q";
+}
diff --git a/tools/bootconfig/samples/good-mixed-kv1.bconf b/tools/bootconfig/samples/good-mixed-kv1.bconf
index 1761547dd0..35442ee62b 100644
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
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index a2c484c243..3fb38b8f31 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -181,6 +181,12 @@ for i in samples/good-* ; do
 done
 
 
+echo "Compact output keeps siblings under their parent"
+xpass $BOOTCONF -a samples/good-mixed-kv1.bconf $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass cmp samples/exp-good-mixed-kv1.bconf $OUTFILE
+
+
 echo
 echo "=== Summary ==="
 echo "# of Passed: $(expr $NO - $NG - 1)"

base-commit: 4f2df9a01754521fbba3493e8ad91ef65515e68c
-- 
2.53.0

