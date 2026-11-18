Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965859;
	b=sDOCSlomVVgjoP3xyDHGj/TH0sUEi4EvKJWGgxncwEFlA1rXm8XD4PRDpx96DcHbVYtw
	 PmRfkuR263yxBOUTWd1slkB0TF9ng33biQ1i0BfxncOaoWodCnITALFgl4OxQVfya0tHe
	 uObvpWWHQFeFo7ArBGKqtwDR2eO/V9hjv8F1IqmcJraZ5H5lgp/DlL2EAsHk/EOHzFij9
	 SQWWwQMYnExGSyHJMjWoBEC8WNEEbSC4wMvbh8EWzcBD1hhpfkv5NuGclRQvMYiwYzNiO
	 XczlpD3Pn5VslwKrRvo5DW7zh248EBKE1FfS+vjMA7odu89U2oZYfmr6arHgFj6Yuow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VXRAGyWQErkwhL34UDeo0VXkUIHLTD8i2arSe3YYZSI=;
	b=2VSp5stBrHHXN/k3WSjk81SpcUC4J1h6tWFhQp/LCz/4wvOsl01g4uzljMiyZfjyZ2Yw
	 x7j11PkOyIDu3iB05sjx9bh3+f8pd1tUKQew/bNScyxfhLXLQgRuJ1YWKyF+pGULc6P+S
	 aeWfc8lyqS4umP+483icocgcWR4l3jzzTTaNDW2R0fXoejusR5u7GOy/9+WOgr3wOq6dI
	 gQMML5PbpGxVx4HsrmyTWQCJP8Mc4spOWHGlVFa396pbyB+359apDTr3EDPhsypyZQXJi
	 4E+frntSRXswTfLt640kwHNC+i9w0igbCwcjdW8JVq4vcPZde6TcdcYpCl44CEa6wMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQiULdF1;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4924606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4924606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BQiULdF1
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-380b40319bdso849869eec.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965858; x=1795570658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXRAGyWQErkwhL34UDeo0VXkUIHLTD8i2arSe3YYZSI=;
        b=BQiULdF1CUDzmbx1OT/9MSFFfozsLtqYjpk7Wb5M3q2MHqlc5LbCFOKmZVb32c/gQ+
         m81cqbDw/unB6Tx4q9qn1h0ruczLj2ebxq/wjOeOay2tBLJy1K4JBiMMU3gocWJNHONT
         4Xv/G053hZOcrgt+y9HjAStYvoouHsGhK5+5W2Y+7mkgHjURDP2AlAd+MkRZkF2+ZgwH
         mgEzT7YwXApV6UDD4eMKEQNK2VIcq88ZYfhpQuuC1QAPNX46z0fm00nxJaS8ncBVbbvw
         BiPY4q6HwkjvDzrZeZI0SZsMEMaHl1mLOUdxthKVJU5GAQID4f4StwknlK4sz80o6v1x
         Csng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965858; x=1795570658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXRAGyWQErkwhL34UDeo0VXkUIHLTD8i2arSe3YYZSI=;
        b=0bSshO21NlE5a1HAzXj+2PNw/sKxBtxr07/LjOEo667jwE8GGvaU+KDUOJzUuz9fFP
         drN+JlUik3KCioQFB038GVajC307AmrF51iXTEX8YYOUzdx7PZexrYccP0yiHc/a9p5c
         PhXCS3wWXwr+hhOjNJAXoZv6KHN7zQwQoayPQ84eLeI26cAmuITDFq2YHlJJYSBNO7tU
         XLYyGf393fkqdDcarhEDu7OqbDHdrdFRyi4e3PHotVBjRrV/Emj9HnmygitauQsaR5Od
         UpUMwJAPHR2sYZuz30dPNcyVNKM38QF4T/sOMxIiCJz0Hf2jp4EgYW9EYMgSRSefiVkP
         1UFg==
X-Forwarded-Encrypted: i=1; AL+hErEdnTg3gIlZgJXWojAC4Z2BR9iYajagMrO7df9Y3FFXRZAIukb644hd1dRMF33tgl0NPWFzG2E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CpcSMZy3gJff3LW74y/eoQXR2OCb1V/QYrhh/gRnvLHolEPhN
	WN+7Y1y2gUHMB7kbnIIUWyRNGdkgb6PzOxy5JR1NWps6pw+Iw3bgL5r6
X-Gm-Gg: AZFdTZclB7DhQlwNCN3nMbyukJPGBaXNmpIrMiLeN74VNjLkYrOyeMW5tGF3Q1gvNAu
	vJv1Q/o/lKKda1f/yuah4h8KEBBhgrdyZaSD5LLxnmiVu/52gl0T9efxPglkItFfMZb8luYh46n
	kKa/Q6STTy64sx9GfiUmBfpOC1fC7drV6B+dIRWeTTOt2qX5LfoCLe4rr563nya/RbfUYfqfYmo
	K0Q9UaoGJIvLahYiEPNXuNcyGm7GO9V1R5Eae4okFDjUhR/ED+Jq1g7gR3zYQ/Apw95CI7IFi0G
	kPWbvIhdigfMnVqUjc5BawehztnQIV66CkTFNejrksxBGwMB520cNue4TFI68r4kY0WjD4xyQrS
	HWcqLNQJPNykWGJuGNNucYEudqfpn4vhoewwltUdA49Oc1tACYBjMEQFazFbb8mkzNvnhC/P4YT
	gNF/dnZ4+kMhqPNC6/0t/ioBZLSy3Ex+Oht4q8Oho8SYOcF5cWuP3pweHKK2er1Zvo3unRzPfOR
	Bl2hKNQFxXIcDHFor0m+IlJakX2lzHbs/QWsTPfGK+BcIBoNYJIxMgrAIpSOFfN3PgJ2NoI5+no
	BH0Ii4t0iZc5R7BAQ+l1iFCDWNng6e0iO3ftZyPLBDF23lwVWL+77mSKT/VkKnzjcyAdwZBa+jx
	yUy49y/XxDAI6GjIiJoCkBiy303F7
X-Received: by 2002:a05:7300:50c4:b0:382:be3b:b236 with SMTP id 5a478bee46e88-382be3bb7d1mr631083eec.40.1794965857917;
        Tue, 17 Nov 2026 17:37:37 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:b1a7:bebf:2fc7:37b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6def9e2sm2094527eec.13.2026.11.17.17.37.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 17:37:37 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v2 2/2] hfs: pass the key buffer size to hfs_bnode_read_key()
Date: Tue, 17 Nov 2026 17:37:25 -0800
Message-ID: <20261118013725.90985-3-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118013725.90985-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
 <20261118013725.90985-1-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() reads the key length of leaf records (and of all
records of variable-key trees) from disk and only checks it against
sizeof(hfs_btree_key). The destination is always one of the two key
buffers hfs_find_init() allocates, each tree->max_key_len + 2 bytes
long. For the extents tree max_key_len is 7, so the whole allocation is
18 bytes and a crafted leaf key writes up to 256 bytes from the image
past it. The error path clears sizeof(hfs_btree_key) bytes of the same
buffer.

hfs_brec_insert() and hfs_brec_update_parent() reach this with keys
that were never validated, the same way as in hfsplus.

Record the size of each key buffer in struct hfs_find_data in
hfs_find_init(), allocate the two buffers from it, and pass it to every
hfs_bnode_read_key() call. Keys longer than the buffer are rejected as
before, and the error path clears only the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
v2: pass the key buffer size to hfs_bnode_read_key() and keep it in
    hfs_find_data, as suggested by Viacheslav
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

 fs/hfs/bfind.c | 6 ++++--
 fs/hfs/bnode.c | 7 ++++---
 fs/hfs/brec.c  | 9 +++++----
 fs/hfs/btree.h | 5 ++++-
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index d56e47bdc..15b0763ba 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,11 +21,13 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	/* search_key and key, each holding one key of the largest size */
+	fd->key_size = tree->max_key_len + 2;
+	ptr = kzalloc(2 * fd->key_size, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-	fd->key = ptr + tree->max_key_len + 2;
+	fd->key = ptr + fd->key_size;
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index fcb5b9cd1..11d3bfc9d 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_size)
 {
 	struct hfs_btree *tree;
 	u32 key_len;
@@ -83,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 1;
 
-	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfs_btree_key));
+	if (key_len > key_size || key_len < 1) {
+		memset(key, 0, key_size);
 		pr_err("hfs: Invalid key length: %u\n", key_len);
 		return;
 	}
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 5a2f740dd..d64cc2e53 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + size,
+				   fd->key_size);
 		hfs_brec_update_parent(fd);
 	}
 
@@ -156,7 +157,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14, fd->key_size);
 		__hfs_brec_find(fd->bnode, fd);
 
 		hfs_bnode_put(new_node);
@@ -450,7 +451,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14, fd->key_size);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd);
@@ -462,7 +463,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key, 14, fd->key_size);
 		}
 		new_node = NULL;
 	}
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 1f703f2c5..a24a3c966 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -82,6 +82,8 @@ struct hfs_find_data {
 	int record;
 	int keyoffset, keylength;
 	int entryoffset, entrylength;
+	/* size of each of the search_key and key buffers */
+	u32 key_size;
 };
 
 static inline bool is_hfs_bnode_range_valid(struct hfs_find_data *fd,
@@ -117,7 +119,8 @@ extern void hfs_bmap_free(struct hfs_bnode *node);
 extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 extern u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
 extern u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
-extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_size);
 extern void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 extern void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
 extern void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8 data);
-- 
2.39.5

