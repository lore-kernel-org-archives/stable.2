Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630939;
	b=RF11d1pdD+xH3AK2VhFgYb8wN9JVT46OEHa2eqZ6dws9wS8InxZwXtsLXrkJqgd+Q9Fy
	 sAcZ4Nwg3awXiCNF0s0ihIzyFebZA3ADQXmvoPtiL73P1uJ1RjRxgu4RDpBfU5NwRluxt
	 vv2umDWAJTkvVTmBreOM/T8FQJ7PMe3TZkPDVz8afsvLWK6uOTx4+EQDuEdtPnC4+tmqj
	 /d8G3215B39ZLC7idQqOsY2+KRf3nMFiRrPimeYGI4j2SuhWdV7RlDAj/gUgN5p11MwOy
	 3gGA/5GPx7LPvvIXxuR/+sLSyvK09wuNQmTVEff6M96vBI7aFUQVjfqj9bU+7P531HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qiW5EsyMhvM/T+7WTNOJmmFgLaE+Y6fQGJrEN+loHe4=;
	b=zSrQXg2875Lqn85dx7kUYTjBafX6wmL2DyKxUjgmqWk76Cd/W/9ahl0MqUAF4JtFodWF
	 crAlmK/f76ao5WoIxGE7EJZvuHMMEgyw3HkdH19ZqcOMIAcCSLAAmOd1PXvrR4afgEdZn
	 wUT908HCZGFOBqyx7H/Zg0cm5PVg1lMAMxlpOUi/d/B1bLksmTe7NeBGuxArwk7zV4PjW
	 kqAEMhhHcxZom9QSQ7xOdhFSWNng5RIznbYu+GNfofj8iU7qElUkoK+O2kvZfr5+iIeXp
	 UpVBmUxH8K7TVwR44FoaTvpcWF3HRC9NsszKONTW41d1gqeT2P4iEvcWTLzCtGL3Acg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UMda+HX2;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589CD606A331
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 589CD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UMda+HX2
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3146190eec.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794630938; x=1795235738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qiW5EsyMhvM/T+7WTNOJmmFgLaE+Y6fQGJrEN+loHe4=;
        b=UMda+HX2vxyRAAv2yaCE6FBNtDKdZdeEhlTP7g2fj4RCAL9KonoCdNMRaKLFBxgtcL
         eXncfrWmrpOc2roZBgQapI3R6QldTXOvDPX5UYwBlWuNlQovmMmxhJQ27l3/4Gx2zMy2
         va6DmpFg56tISWeWhS85DkDxJcu9pD/Uxr9PozhIM3EDFB1m4D0IlvBoA3l3holrURuu
         l0RSY22dzkui603y44pPamNYsCrXwF2cxuQcAuraE9wqbdZdfGxYl6DT/8POLU4uLNpT
         xmci5NpOQgJGjKIPdITpcql+WR0RCYvrACR0ITk54U5OhOtuf1GaSusadFUalrZNzSqQ
         0XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794630938; x=1795235738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qiW5EsyMhvM/T+7WTNOJmmFgLaE+Y6fQGJrEN+loHe4=;
        b=CzGoq9TxUk0f2b4tV3j/hIciD8ziRClaPWpW+byy9tI8nZE5mxUoQbnHrMBDUVJB1p
         RBlrK3IWQeEKKxbcWxAQXtlbuGR8w0imG9lhNr74Elx1cVcwIYdFDT2xQ16hhL9H7vM+
         Bd3yNKqgVkvcCLGAvQ1D4nNMuiSPC+TlFi+k3sdsJXFQYxPhXr//pPkf0QzqRrSF7Uw1
         HVbmf/Ow7A9kDTzmGh4I1kHx22VyehTPTJ2zRBgDYDV5oIuOF3B4bA9uIymkXD0NsEsh
         nOiuC0Z7/nTJcOZhEqWw1by3T90emwEo5IFCa8Wq+A3oP0hHB7wIF9/UpOjGqFysMBLR
         f66A==
X-Forwarded-Encrypted: i=1; AL+hErELGNkQCp1ARU3OoL2eB69XZG3le2M3VajcvcFC5DHinCWNckA5nQD8MGbACZeUIDlye7u9V1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fN1aVfTNyFF5P6y+qKMeT0VtZT9STcDj808FeX4gRhicQlYEP
	0nebmatcpiWdIta8T3R0TzQjJlp5MfY8qIRaEzYImOaEjQoqE5NRIwrH
X-Gm-Gg: AYBFou13hunIqxiNqx1KIK9tFyq+jCNMO2p4elinlkS7o3IgcA94lA73yHYESCp3bAt
	J6qk3WOPkBD/99eOmdClFxWLiPOLNf8qekj0PUAeG09e3E0q24FoqpyUz++A/yAy7eZklP+ZFUu
	aQdyFpKNaouIQ7AH/xjqcCSoXdu4p2Jf5ju1Ez8ntpbkXEy97Dz/MF5VNfahI2ijY8K47qx69AK
	cK0KS8Qy2lYpIqJz7AJ1m79Cx0gQwP1fg+iwQiMRKzQnop3YhnOi1wVZy9T7CKdh/4LBxG1xsiD
	MLRN/sqd7FQyNIcql0c/UeI53aG45Zu70Ibek3uXeDWGYZTOiqXG5W6tkCQPPe15tzJgDg/o/Jo
	CaZuguRGaO5PeAc0lMmFH2hBqgZR9XIfZrLQPU2lmo9GESKNlCqBnSTg7jVW76LXjTA1WTtVDDg
	6GhVqwu3DxlIsoZFzEsEH9hxC54vvipy6SMCPcPsg6QwuyqZUBcrVn24VYGdOyFF7HmSZXuaUlo
	RIvuKF9g9eKzoU6c/86APixnSHw39YKdBbPrEQsauf3SDlph38vHTeaNE/1XlH/efKHqhjmFp26
	k2B/nSJCj+RI2tp0Ls9oBfJp/ak//bzxCgtUnwuvyqn5jRl/eZHzUpEHPeoOB/24joL2npvxb+V
	JLNEA26zpLN5hh/q+qvOJ9FWrYOU=
X-Received: by 2002:a05:7301:4287:b0:36e:53bc:4681 with SMTP id 5a478bee46e88-3796731594bmr3469347eec.37.1794630938255;
        Fri, 13 Nov 2026 20:35:38 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:796f:2855:533:1bb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm11744106eec.16.2026.11.13.20.35.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:35:37 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>,
	Guikun Yang <yangguikun19@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] hfsplus: bound btree keys by the tree's max_key_len in hfs_bnode_read_key()
Date: Fri, 13 Nov 2026 20:35:21 -0800
Message-ID: <20261114043522.48764-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
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
records of variable-key and attributes trees) from disk and only checks
it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
always one of the two key buffers hfs_find_init() allocates, each
tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
fixed at 10, so the whole allocation is 24 bytes and a crafted leaf key
writes up to 516 attacker-controlled bytes into kmalloc-32. The error
path has the same problem: it clears 518 bytes of the 24-byte buffer.

hfs_brec_insert() reaches this with an unvalidated key: when the tree
root is 0 it reads the key of record 0 of the leaf it inserts into, and
after a split it reads the first key of the new node. A read-write mount
that extends the catalog (creating the private data directory), or an
append to a file whose extents spill into the extents tree, is enough;
no other file operation is needed.

The 518-byte bound was added by commit bb5e07cb9277 ("hfs/hfsplus: fix
slab-out-of-bounds in hfs_bnode_read_key"); it covers the catalog and
attributes buffers but not the extents buffer. Bound the key length by
the tree's own maximum, which btree.c already validates per tree, and
only clear the bytes the buffer actually has.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 3a1a1fa..f414020 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -84,8 +84,13 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 2;
 
-	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfsplus_btree_key));
+	/*
+	 * The key buffers come from hfs_find_init() and hold
+	 * tree->max_key_len + 2 bytes each, which is far less than
+	 * sizeof(hfsplus_btree_key) for the extents tree.
+	 */
+	if (key_len > tree->max_key_len + 2 || key_len < 1) {
+		memset(key, 0, tree->max_key_len + 2);
 		pr_err("hfsplus: Invalid key length: %u\n", key_len);
 		return;
 	}
--
2.47.0
