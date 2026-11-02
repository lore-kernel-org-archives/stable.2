Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621666;
	b=aBDK1gOZsaHD4CAOmEYfuZpokgpFfNGmxGDajSxafpYGFpG+d8V8PuKGL/JCh8QuNACO
	 YyEw5dKqAX3quZmeAq/FzrYUb9sB4qV+rMsahvOFcITmvoXUMZmoRW5FqXALjRLAybPF5
	 7+0E6auwba8XaT+fEhQ1r7j4J56MeajVmeEk64Cll8LEim7O/IjnTO3Y0Ia8Vw0K8/fI5
	 4AnteKTghEw7KQj4qd9c3TKaRYHE2iZyLJEkReryCcRl/Bbw42IcDTpH8aQCm4KvClrJy
	 +HKCZ7S7u7+x1uRALWMbZu8IO438a/NCZ0Uxn+4bA+hdrPob7znWpktDSF76twyJJXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621666;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=cel5vkA1S8lRKOALwlkHAw6iYFPZW/oCzk0fMlr+iwE=;
	b=K96M1mzyQpvu7lqzjlUkHlf+BHYy28mok6nO7gU2EywlTtPqbgY+cxMtOdv5FqMHr9RT
	 kl4qx57zkOoT7C5C0F0QqOH2YKZjYe+BO92nmZspB2oMYlKCb+2G3HRheWn0+I0bpu/z8
	 FFh4fRybU3Y75CLArJuOYREvWUOPBCZj4rCZJst/HZCmoXWjfwqyTdQ5MTYhjATZNis8K
	 Oq17KZgRxrlE/w784H1RrN+HdUNZLWLNsDUf7+w9/RWt8R20lBXIzY8AOF7C7V9eddO3q
	 +PAE4E6t0iUlMYGLTbOjJqgomX12lfYgus8Mrgtfvo+W5yq2+1o2bSP25FvnfYZ9n5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC2606A327;
	Mon,  2 Nov 2026 12:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ADC2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJ9cB3K6jz57KTp;
	Mon, 02 Nov 2026 20:14:18 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6A2CEHOs024199;
	Mon, 2 Nov 2026 20:14:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 20:14:20 +0800 (CST)
X-Zmail-TransId: 2afc6ae87e9c98b-99802
X-Mailer: Zmail v1.0
Message-ID: <202611022014201140sh13oFtWkIgBr7UQKyMK@zte.com.cn>
In-Reply-To: <20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn>
References: 20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn
Date: Mon, 2 Nov 2026 20:14:20 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gdWJpZnM6IGNoZWNrIG5vZGUgaGFzaCBjYWxjdWxhdGlvbiBlcnJvcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2CEHOs024199
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 20:14:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE87E9A.000/4jJ9cB3K6jz57KTp

ubifs_node_calc_hash() can fail when authentication is enabled and the
crypto operation fails.  Five calls ignore the return value and use the
uninitialized stack buffer as the node hash: replay_bud() stores it in
the replay entry, make_idx_node() and write_index() copy it into the
parent branch or the index root, and create_default_filesystem() copies
it into an index branch and into the master node.  Verifying those nodes
later then fails with a hash mismatch.

Propagate the error from all five call sites.

Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
Fixes: 104115a3eb54 ("ubifs: Add hashes and HMACs to default filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 263045e05cf1..442493dc18c6 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -730,7 +730,9 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 			goto out_dump;
 		}

-		ubifs_node_calc_hash(c, snod->node, hash);
+		err = ubifs_node_calc_hash(c, snod->node, hash);
+		if (err)
+			goto out;

 		if (snod->sqnum > c->max_sqnum)
 			c->max_sqnum = snod->sqnum;
diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index e7693b94e5b5..1c176be261e0 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -329,14 +329,18 @@ static int create_default_filesystem(struct ubifs_info *c)
 	if (err)
 		goto out;

-	ubifs_node_calc_hash(c, ino, hash);
+	err = ubifs_node_calc_hash(c, ino, hash);
+	if (err)
+		goto out;
 	ubifs_copy_hash(c, hash, ubifs_branch_hash(c, br));

 	err = ubifs_write_node(c, idx, idx_node_size, main_first + DEFAULT_IDX_LEB, 0);
 	if (err)
 		goto out;

-	ubifs_node_calc_hash(c, idx, hash);
+	err = ubifs_node_calc_hash(c, idx, hash);
+	if (err)
+		goto out;
 	ubifs_copy_hash(c, hash, mst->hash_root_idx);

 	err = ubifs_write_node_hmac(c, mst, UBIFS_MST_NODE_SZ, UBIFS_MST_LNUM, 0,
diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index 7bf2672062a2..1a62739c3731 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -52,7 +52,9 @@ static int make_idx_node(struct ubifs_info *c, struct ubifs_idx_node *idx,
 		}
 	}
 	ubifs_prepare_node(c, idx, len, 0);
-	ubifs_node_calc_hash(c, idx, hash);
+	err = ubifs_node_calc_hash(c, idx, hash);
+	if (err)
+		return err;

 	znode->lnum = lnum;
 	znode->offs = offs;
@@ -887,7 +889,9 @@ static int write_index(struct ubifs_info *c)
 		}
 		len = ubifs_idx_node_sz(c, znode->child_cnt);
 		ubifs_prepare_node(c, idx, len, 0);
-		ubifs_node_calc_hash(c, idx, hash);
+		err = ubifs_node_calc_hash(c, idx, hash);
+		if (err)
+			return err;

 		mutex_lock(&c->tnc_mutex);
