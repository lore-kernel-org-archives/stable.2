Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59A2BDC0F
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787984717; cv=none; b=CdHATkjN0iWQRgJp3dMxCIcUo+1bA2PhSN+L7FTZHPP0TwxfOtLaDOvuF+gY64DxSe3mx9fbi54zLTshd82728TSabSqk2ahYUAzCw2tJ/vc5diRcfO34+ttB9jSa9L0j3QBPzqLoEjJ3ARIjfxN3D3yC/A7V5qUVCmpoptXdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787984717; c=relaxed/simple;
	bh=5+qNSuBfaI7rfZ2mss24vGAI3qaKMMf3Acwprabefjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvw71MrF2BnYH9qENyNvrNAE2TczpLFl37u5uQN+cG1k9nB8doSyfsAe/5yc4WLA++wIb2QSE43zBmJh4dE9mkEiuQLE1ZwopMezyqIwKb5FuazdUTBN5Ubj8OZhy7UdttFlXsSDH/ySMYKUgYsiztsXvuLjjz0U2VKFkxWurSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Wmb7UL8Y; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Wmb7UL8Y"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d7195706f1so18027235ad.0
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 23:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787984715; x=1788589515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQpGeHFpF6hM3XAcJaWyHzxH1K1KBhOVpeax6pWgUcI=;
        b=Wmb7UL8YWrPHOOqlAza3v9D6jmHXo/E25qKtIONgMJfwb1fFSObDhV3N6ajCv42qji
         lW/SBEmFXgSRVBPEn0F75c3qrgj6gKEd81rPTTVE6LTwyD87nWME3oUI3hUf+wH09Nq4
         QoEL7NX2Ww7LHZcWhqyPUatFxhNiWosRJpLB9Jr0lvKGW55PGGAxDY8Q611UwGHFYhbK
         5SdoJ0PQrzuaAGP+wX6Z9V9MNM5BibKTY17ZGhfrA3YoUFicR6pW0jlIoO4aSNOFGsnV
         iGOpEq/fWml4mDWtcyfa4IT3jpuSN2k9N0kFZvuDde7LirQP0tAw1zLwCSLbZhtZOMir
         ApHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787984715; x=1788589515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQpGeHFpF6hM3XAcJaWyHzxH1K1KBhOVpeax6pWgUcI=;
        b=BQXFRwinFQai3z2k7J6Kn7GnQesanPQTi/saw7Ui7VRJRu2kZ8N6jF8orSZJRkatrh
         un8cBTJEHIh8byJr9GEGqm1c3EalzWLiWfSHdc/Ab1MdUlz+tiSXQzCNXjnwRQ8bJK60
         0T4SjliyZlOJz9dsAWLisr8lk22VDKT8a4996D65FrKWjH0himyjx57LZXLjSJvkcvP5
         2ofqVERyLuTqy9HEDhH1zgkSYkas0CMfN5/xZ9QteYlSIDYab5KRiq1Nxo9AKku43faT
         i6gF26BaNVZGq03L7Mst2GIc4lAdkILDVHj1CVMvw6DEW0GAs4s0YQwfTzYKBxAHpF10
         zs3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoLTd14ltnISfcTDugr1IbJp3affmd+QWEyX+r7FNpfQOvkwAR2GWMA/nSml5i44fHwJ1Zp++U=@vger.kernel.org
X-Gm-Message-State: AFuF++keUjRFpWJ26FA9rfScjzy0pxGj63q6VGd/dQcSsqVQd1RZtRqw
	35+0AaYzOmsK+kdSfzfDrAyKQqBvr7goti2v/Ecc3U3YEre5TW4AGALnxJyaiCgwSlA2
X-Gm-Gg: AR+sD11LbEP5VeFg8EUDZ84C1lEeItgBqVGqIoA1DktsKN/u+jZI11AOvyaVXMDkcHJ
	ibFYEhQTNo1q+CHzzXOwbfUfeMOEwGi8/aYj2CbIxLxckHqvmJEoEGNYpIM6+JurZz5q1dZe92B
	J9piAJQ7izQU9tX3UjIa4VphMksXZ2G2zSDVi24vnayxjzu3s1ew2YR9Y1UkCiIE/wiXRlSZv6f
	4epxPpREv52fow4Drdnag7TpQhQh877LZDdR8saUMAOR9HHCms+Sr3gTyoc6/o99aLPbmcBm7dx
	jmZgjWH8RLQCdtPvRk7tECQZTzD9XsanzntfjCi+iKFM/Sz6Z/EgkcfBEZAOOO/aqDrmz212AsC
	mLrhobFsx54MXAGH1CUsemwH8j1FL3Q9Hybx3ZhU+hjnySJgtJsaTU3FrqRrl+fBppL2w2+Opsj
	wI/68TxaFBCJxBDs6X/FsDrdbEv5hT8oN0Jz5Milq4iFnE/lE3QJp3CRogu7vtagHtc98d80T69
	l3gF/if3TgB0g==
X-Received: by 2002:a17:903:1ae5:b0:2d8:d4cc:be62 with SMTP id d9443c01a7336-2d8d4ccc940mr72729095ad.15.1787984714542;
        Fri, 28 Aug 2026 23:25:14 -0700 (PDT)
Received: from gmail.com ([202.201.12.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fb48dsm12354185ad.14.2026.08.28.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 23:25:14 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 1/1] ipv4: fib: avoid quadratic table ID lookup
Date: Sat, 29 Aug 2026 06:24:57 +0000
Message-ID: <0a00492a13038b268c1e0a219c138d07cfab92b3.1787982246.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787982246.git.zihanx@nebusec.ai>
References: <cover.1787982246.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fib_empty_table() probes every table ID from 1 until it finds a free
one.  Since IPv4 tables are stored in a 256-bucket hash table, a dense
set of IDs makes the probes repeatedly walk growing hash chains while
RTNL is held.

Count the existing tables once and use a bitmap for the bounded range
that can contain the first free ID.  This keeps table-ID selection
linear in the number of tables instead of quadratic, without changing
the lowest-free-ID behavior.

Fixes: 1af5a8c4a11c ("[IPV4]: Increase number of possible routing tables to 2^32")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/fib_rules.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index e068a5bac..55751b0d1 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -16,6 +16,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
 #include <linux/inetdevice.h>
@@ -216,16 +217,45 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 
 static struct fib_table *fib_empty_table(struct net *net)
 {
-	u32 id = 1;
+	unsigned int h, count = 0;
+	unsigned long *table_ids;
+	struct fib_table *table;
+	u32 id, max_id;
 
-	while (1) {
-		if (!fib_get_table(net, id))
-			return fib_new_table(net, id);
+	/* The first unused ID is no greater than the number of tables + 1. */
+	rcu_read_lock();
+	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
+		hlist_for_each_entry_rcu(table,
+					 &net->ipv4.fib_table_hash[h],
+					 tb_hlist) {
+			count++;
+		}
+	}
+	rcu_read_unlock();
+
+	if (count == RT_TABLE_MAX)
+		return NULL;
+
+	max_id = count + 1;
+	table_ids = bitmap_zalloc(max_id, GFP_KERNEL);
+	if (!table_ids)
+		return NULL;
 
-		if (id++ == RT_TABLE_MAX)
-			break;
+	rcu_read_lock();
+	for (h = 0; h < FIB_TABLE_HASHSZ; h++) {
+		hlist_for_each_entry_rcu(table,
+					 &net->ipv4.fib_table_hash[h],
+					 tb_hlist) {
+			if (table->tb_id <= max_id)
+				__set_bit(table->tb_id - 1, table_ids);
+		}
 	}
-	return NULL;
+	rcu_read_unlock();
+
+	id = find_first_zero_bit(table_ids, max_id) + 1;
+	bitmap_free(table_ids);
+
+	return fib_new_table(net, id);
 }
 
 static int fib4_nl2rule_dscp(const struct nlattr *nla, struct fib4_rule *rule4,
-- 
2.55.0.windows.3

