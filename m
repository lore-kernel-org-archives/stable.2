Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D4202C46
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613403; cv=none; b=cWoFeDmpl+wukWjFwKdWUzuCqvXrCVojUZqpgiDrWkBDVSEcyclXhyWQqec5mciFa0LOiPNhV0WNc/Q9zoxY9ntuzNbPzM9hXPL2iZFpPCD5PRAVY8ueFt9W0NhHC3+3OqSBScq0snafnk4xV6LwxmEJhqOxik45A3NOoi7bELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613403; c=relaxed/simple;
	bh=RZGydrbawCA99Kwdz2JbCmVeovoxSjXEh6Zse881/sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lC221cAZ5HkAeVDV2XL9CRskGEA2014B/Zg3Ql5Si2HPM+gOTUwyp0S/WtHKT9KEpdh71uJ4GUd6Zd6quW7lctAIv4kPvIqTBoxjIbSIh+QNjifulCqH/vuEwZqecqPDR0oLYMTIQG6GBe9XpO6BTljsHUrQYP+GB9s5BZzjL/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RQfcu0Ud; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RQfcu0Ud"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=AlyM5jPlqre7qhFvJSo4ow0p4UnaxsR0ABn/eTi8xPE=; b=RQfcu0Ud5Zhd3+QsQLD3Oq8szN
	Jgpx5YZ0gXC9gk8ryoyCZFB8YPOycv0IqlfiRib/r2n0tydF3hAOU+z2EHD3TAB+G4/bsb5bCDCjp
	WqtFj6JuQ5TW7pHXcOJtziDc/JOBGP4dqb8kdIUZyd7pzsZ5UGIx2OLJMuuTssoBnSF/zrmzGamHQ
	IAifmFzfMKEC3dX5k0Nzrb+B5sKChdd4ELulNybC2CLn4KSEkCZs+qOzoeVA3a5YeEErRCdu3qEab
	DDcdaECADIG7pNPrRNERp2uLSCslpzCNIeVbqybXC/eALkWTe1QE9FN9x+80fuugPeFGjUdvkdvlz
	9cRY8pgw==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	edumazet@google.com,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 1/3] net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
Date: Tue, 16 Jun 2026 14:36:27 +0200
Message-ID: <20260616123629.1218562-2-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616123629.1218562-1-heiko@sntech.de>
References: <20260616123629.1218562-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 54568a84c95bdea20227cf48d41f198d083e78dd ]

We have many EXPORT_SYMBOL(x) in networking tree because IPv6
can be built as a module.

CONFIG_IPV6=y is becoming the norm.

Define a EXPORT_IPV6_MOD(x) which only exports x
for modular IPv6.

Same principle applies to EXPORT_IPV6_MOD_GPL()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Link: https://patch.msgid.link/20250212132418.1524422-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 54568a84c95bdea20227cf48d41f198d083e78dd)
[needed as dependency for tcp: secure_seq: add back ports to TS offset]
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 include/net/ip.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/ip.h b/include/net/ip.h
index c65ca2765e29..39c6a4033aed 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -675,6 +675,14 @@ static inline void ip_ipgre_mc_map(__be32 naddr, const unsigned char *broadcast,
 		memcpy(buf, &naddr, sizeof(naddr));
 }
 
+#if IS_MODULE(CONFIG_IPV6)
+#define EXPORT_IPV6_MOD(X) EXPORT_SYMBOL(X)
+#define EXPORT_IPV6_MOD_GPL(X) EXPORT_SYMBOL_GPL(X)
+#else
+#define EXPORT_IPV6_MOD(X)
+#define EXPORT_IPV6_MOD_GPL(X)
+#endif
+
 #if IS_ENABLED(CONFIG_IPV6)
 #include <linux/ipv6.h>
 #endif
-- 
2.53.0

