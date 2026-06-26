Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCF403B02
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490378; cv=none; b=sMxKaTojEstnp492Y6tKzXn9SIkN7UIybbapIamTE4BVagrbDZKsUj18sCR0LN8E7hy8ga5pBAEyd19NVhvca+//s0Qpa2S46NK8aW6NTDJjc9iRLJ9U0dgEtVAgolIWo2GUMpo28TJ52UdhRpjmkW1BzadaJyfDCxnW8k0B3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490378; c=relaxed/simple;
	bh=eTDkYVefQkdLOrwZ2BQVGzeiDC1RmmPj5PzRK+jVEWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWhnr26LXXsx9Obdncwz3Isa4jnngvBDnxyBFqQOSXTgrcxKEcJ8Ga17rp7eqYNwGfhlag9/jMjWbx3o7nG0tB1mMnFweqi3yeqZEm3kVFd9Y3HnIjl6fbBa+sYeUNzvIOK2jwinnCKtQ4M4OmcLS7XbKKty7hvXEaCv0tQIkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=LTy05GaB; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="LTy05GaB"
Received: by dvalin.narfation.org (Postfix) id 8AAEB20539;
	Fri, 26 Jun 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Jlhgwu6S8f0fKUqkxmCakNNmYGqyvD3DsffSpkcSoQ=;
	b=LTy05GaBwphq7ALT9/yYKMN0sa6ALTuy8GWCCBBHM/tFJUR8OqE6QvCNWJlE9R9fbOhCtV
	+FBnT9JHs7CCwrqt422vsvcdiusoctvcdHQpqCCuaCCsBR/fnv2XoVXMFZpjvYNR759uoy
	x0wJRsYCRJC8l07RpOSLqt43pBugTpQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 24/26] batman-adv: dat: prevent false sharing between VLANs
Date: Fri, 26 Jun 2026 18:12:39 +0200
Message-ID: <20260626161241.124988-25-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 20d7658b74169f86d4ac01b9185b3eadddf71f28 upstream.

The local hash of DAT entries is supposed to be VLAN (VID) aware. But
the adding to the hash and the search in the hash were not checking the VID
information of the hash entries. The entries would therefore only be
correctly separated when batadv_hash_dat() didn't select the same buckets
for different VIDs.

Cc: stable@kernel.org
Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0a8bd95e2f99e..86fb5de5022ac 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -214,10 +214,13 @@ static void batadv_dat_purge(struct work_struct *work)
  */
 static bool batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	const struct batadv_dat_entry *entry1;
+	const struct batadv_dat_entry *entry2;
 
-	return memcmp(data1, data2, sizeof(__be32)) == 0;
+	entry1 = container_of(node, struct batadv_dat_entry, hash_entry);
+	entry2 = data2;
+
+	return entry1->ip == entry2->ip && entry1->vid == entry2->vid;
 }
 
 /**
@@ -344,6 +347,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 		if (dat_entry->ip != ip)
 			continue;
 
+		if (dat_entry->vid != vid)
+			continue;
+
 		if (!kref_get_unless_zero(&dat_entry->refcount))
 			continue;
 
-- 
2.47.3

