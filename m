Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908098;
	b=vhm6wXU+SGfY0s1B4/LbaYz3Mb7EidUgpdXiIUJ6N1M3RkRHbwwLvmRkV6ImsBael2Vg
	 jdy9Q+ekUpqRVghKGDSbUWGMFWhCSjrm4K+2o+KrpkazqBq1ud4CMRwH++uSQFS/SQ0bX
	 p2kj5ueI4vWt5y87VylJrQBvEnBKD6+Sw6W6nu4v/BoDlYC1j58OvzY/SYFkqRf5tXtoR
	 zCPKsPtoHrohtzxsBJR+KQpkulJPWRlvmVweZ87N4sBOoEVBMWJQYv9kGvzOxmO5OYvg5
	 3EMUcm0IQOwa/ZcrGvlS/5XhsSNxpwAapjga8L3ATgz/WhOVLa9qSsNeFYQh6vJzDYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sIOjW8Q+w5N6pIcBWDLElI9KPghsoFADokUVhUCNLiI=;
	b=C3IwVi5TVD0+htFDlVHqZP0QdgfPYRd3/pHBp8WjWm6qAf3OxkyfZKzuRLzRImULjf10
	 0MUO55HsqF7p1Q51IJwyMEAFqOTRP02b//FPHY6OT3L41uZE9cEnw1J2uwtQcTbUBM8Js
	 gLYmp6yf2B7JgVtwfdur7LDPoa/JkpusDgtWAzTdyVdLbV/S1VBx20LRyx12eFxZkD0vu
	 urV9IX+JuiqtdFh03dECrU71ByjsiizV90ZZiOn4ykhzTE5FHZSGXrWrGJy4khx1feYlJ
	 z+HDIdzLwXGFC38YlUHf7dFHBjl7yhE0DDufrDS8j8VPultvnKehVda6OvlYBeFkjgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSoqBKwP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5470606A329
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSoqBKwP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E0D1F0089F;
	Thu,  5 Nov 2026 19:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908097;
	bh=sIOjW8Q+w5N6pIcBWDLElI9KPghsoFADokUVhUCNLiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSoqBKwPOviGKrH/yiZBz+P83zGzoKgY5r+yHPJ7u0E4seCOytztni/CN86nrrq1j
	 txm9LRH8vFbqzONR4mrixVkGUE7bg6hZsYYzZS3FP7ZWLNsxzZ8ERN+vWK8i93c5b7
	 hhA/CBrzCGL1nYOan+i8mi+nRG7fStxpMkVVywl84rcuSqo06geXZHr0q6hk+5T2co
	 +t4ZtEhWCzcT+jMHj4vaVbcbAjmWztFGxmcBCZvP2PNLCL+QjgECLMBMH6dI2EgST1
	 zk6MM0a05HWTMVgYcKzrqcqvIMyTNTRyfyjkXLKJF6+2ooEk2WVf+cf4PVp5SYNuF7
	 5pxanqFSdSKwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Paulo Alcantara <pc@manguebit.org>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: fix buffer overflow in SMB2_tcon()
Date: Thu,  5 Nov 2026 14:48:15 -0500
Message-ID: <20261105194550.2633857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-purity-munchkin-1270@gregkh>
References: <2026110432-purity-munchkin-1270@gregkh>
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

From: Luxiao Xu <rakukuip@gmail.com>

[ Upstream commit 73cc469b0ff7551f8537ea919709973e6dc4f514 ]

In SMB2_tcon(), unc_path is allocated with a fixed buffer size of
MAX_SHARENAME_LENGTH * 2 bytes (672 bytes). However, the user-controlled
UNC path (tree) length is passed to cifs_strtoUTF16(), which assumes the
destination buffer is large enough and writes strlen(tree) + 1 UTF-16 code
units.

Commit 62a1a439e0fd ("cifs: clean up handling of unc= option") removed the
length check on UNC mount options, allowing mount paths to exceed
MAX_SHARENAME_LENGTH while retaining the fixed-size buffer allocation in
SMB2_tcon(). Consequently, an oversized UNC string causes cifs_strtoUTF16()
to write past the end of the heap object, resulting in a slab-out-of-bounds
write. Furthermore, if a tree exceeds MAX_TREE_SIZE characters, strscpy()
truncates it in cifs_tcon::tree_name, causing subsequent reconnects or
failovers to fail.

Fix this by first verifying that the length of tree does not exceed
MAX_TREE_SIZE, returning -EINVAL if it does. Then, dynamically allocate
unc_path based on the length of tree so that it safely accommodates all
UTF-16 code units for paths within MAX_TREE_SIZE.

Fixes: 62a1a439e0fd ("cifs: clean up handling of unc= option")
Cc: stable@vger.kernel.org
Reported-by: Xin Liu <bird@lzu.edu.cn>
Closes: https://bugtracker.nebusec.ai/f/3292
Assisted-by: LLM
Suggested-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
[pc: remove unused MAX_SHARENAME_LENGTH]
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: adjusted context to match the existing MAX_SHARENAME_LENGTH location and direct -EIO return ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index a2f1d165d8862..bba79784931fe 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1703,8 +1703,6 @@ static inline void cifs_stats_fail_inc(struct cifs_tcon *tcon, uint16_t code)
 	cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_failed[code]);
 }
 
-#define MAX_SHARENAME_LENGTH (255 /* server */ + 80 /* share */ + 1 /* NULL */)
-
 /* These are similar values to what Windows uses */
 static inline void init_copy_chunk_defaults(struct cifs_tcon *tcon)
 {
@@ -1738,7 +1736,15 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	if (!server || !tree)
 		return -EIO;
 
-	unc_path = kmalloc(MAX_SHARENAME_LENGTH * 2, GFP_KERNEL);
+	total_len = strlen(tree);
+	if (total_len > MAX_TREE_SIZE) {
+		cifs_server_dbg(VFS | ONCE,
+				"%s: tree name exceeded %u characters\n",
+				__func__, MAX_TREE_SIZE);
+		return -EINVAL;
+	}
+
+	unc_path = kmalloc((total_len + 1) * sizeof(*unc_path), GFP_KERNEL);
 	if (unc_path == NULL)
 		return -ENOMEM;
 
-- 
2.53.0

