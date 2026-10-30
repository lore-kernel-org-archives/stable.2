Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331863;
	b=k+i1+KKCd0gr/a3KSfZlssJ4Y1Je+nSy2gdEGcz6UbxEAYN3mGu2OdJXkY4HZlX35MBH
	 OlRnQkQSC8XmdN35/s18CvPJpO1kOsdZ2sAlLdrdzo+nHizsgz+L5LT+ErReqAujx0hBB
	 VGzQhJZZ0xWIL6PTdua98FHZ87NGt2EOB74sNhsGlZUuQOCaMfyIzl5GoHMU8bMlnu07r
	 v5yvqeUcPl+o4AYNv9Jp1S1woa+1UcPh1TJio8iPMEF31VBWBfllxrrr7DGqsYCi1hAid
	 KukflDNxih06pg9GuReGv2cffrJibMovbeLQX5eYw+wxskGrjLDOMotEVbFgj19gpeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331863;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=v4DQsLR0Sr6pSUF5Nmqru+Sp8EwUJhrxZNM3O9AZMaU=;
	b=xQkPuC+rVo0YN/2GtgCI7vW4yXm1QXHUxs5yANDyBLXRmOgkJ94VEiuDwo4ShPm1G/5L
	 zMem6PWhX1Tup+h12HhtAqr4d5vUc2mr66HitL3KaOQvhMfxvxCVZ40kIM/7ESZBSWOPy
	 tV9fuWccO7Baq0DM993n75GDmKC4WtHOYqSNnLLdjjqf23QCFMBL5g9ddE3dY1utktMFx
	 ZKObLzyvrwP5gFKr0CO7MTkyoWPagpQa9IZ1GUxXQguuhNCjDVygH2NW5/kHqh03u89En
	 IiUJd1F5xgJwZ2/LqEOHB5Vz2SXnjY8HFCESS7n9wlKsL7wH4ZyMAzjNjswS0k+yk1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB6606A31A;
	Fri, 30 Oct 2026 03:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EB6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jG6R73PgXz8Xrrd;
	Fri, 30 Oct 2026 11:44:19 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 69U3i57m012676;
	Fri, 30 Oct 2026 11:44:05 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 30 Oct 2026 11:44:06 +0800 (CST)
X-Zmail-TransId: 2afb6ae41286f05-83c2a
X-Mailer: Zmail v1.0
Message-ID: <20261030114406371EZw_orIqSRlCTxnz_L39Z@zte.com.cn>
Date: Fri, 30 Oct 2026 11:44:06 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSB1YmlmczogcHJvcGFnYXRlIHViaWZzX3NoYXNoX2NvcHlfc3RhdGUoKSBlcnJvcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69U3i57m012676
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 30 Oct 2026 11:44:19 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE41293.002/4jG6R73PgXz8Xrrd

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ubifs_shash_copy_state() duplicates the rolling hash state with
crypto_shash_export() and crypto_shash_import().  The export buffer is
allocated with kmalloc(), so the function can fail with -ENOMEM, and
crypto_shash_import() can fail as well.

Five callers ignore the return value.  The target descriptor then has no
valid state, and the crypto_shash_final() that follows computes a digest
from uninitialized data.  When preparing an auth node this stores a
wrong HMAC on the media, so the affected journal head no longer
authenticates after a remount.  During replay it makes the verification
of a valid image fail with -EPERM, and in replay_bud() and
add_replay_bud() it leaves the replay hash state inconsistent with the
media, which corrupts the auth nodes written by later commits.

Check the error at all five call sites and propagate it.  In
add_replay_bud() the descriptor belongs to the new bud, so free it on
the added error path.

Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
Fixes: da8ef65f9573 ("ubifs: Authenticate replayed journal")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index 1f770795ee70..62dfacfb6d6b 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -70,7 +70,10 @@ int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
 		SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);

 		hash_desc->tfm = c->hash_tfm;
-		ubifs_shash_copy_state(c, inhash, hash_desc);
+
+		err = ubifs_shash_copy_state(c, inhash, hash_desc);
+		if (err)
+			return err;

 		err = crypto_shash_final(hash_desc, hash);
 		if (err)
diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index c6edcbf35ebc..42cadf558a4f 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -412,7 +412,11 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 					 UBIFS_REF_NODE_SZ);
 		if (err)
 			goto out;
-		ubifs_shash_copy_state(c, c->log_hash, c->jheads[i].log_hash);
+
+		err = ubifs_shash_copy_state(c, c->log_hash,
+					     c->jheads[i].log_hash);
+		if (err)
+			goto out;
 	}

 	ubifs_pad(c, buf + len, ALIGN(len, c->min_io_size) - len);
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 263045e05cf1..0b82c67a2dcc 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -566,10 +566,14 @@ authenticate_sleb_hash(struct ubifs_info *c,
 		       struct shash_desc *log_hash, u8 *hash)
 {
 	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
+	int err;

 	hash_desc->tfm = c->hash_tfm;

-	ubifs_shash_copy_state(c, log_hash, hash_desc);
+	err = ubifs_shash_copy_state(c, log_hash, hash_desc);
+	if (err)
+		return err;
+
 	return crypto_shash_final(hash_desc, hash);
 }

@@ -694,8 +698,10 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 		goto out;
 	}

-	ubifs_shash_copy_state(c, b->bud->log_hash,
-			       c->jheads[b->bud->jhead].log_hash);
+	err = ubifs_shash_copy_state(c, b->bud->log_hash,
+				     c->jheads[b->bud->jhead].log_hash);
+	if (err)
+		goto out;

 	/*
 	 * The bud does not have to start from offset zero - the beginning of
@@ -915,7 +921,9 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
 		goto out;
 	}

-	ubifs_shash_copy_state(c, c->log_hash, bud->log_hash);
+	err = ubifs_shash_copy_state(c, c->log_hash, bud->log_hash);
+	if (err)
+		goto out_free_log_hash;

 	ubifs_add_bud(c, bud);

@@ -924,6 +932,8 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
 	list_add_tail(&b->list, &c->replay_buds);

 	return 0;
+out_free_log_hash:
+	kfree(bud->log_hash);
 out:
 	kfree(bud);
 	kfree(b);
