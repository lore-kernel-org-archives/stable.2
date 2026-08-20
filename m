Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25547443A96
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229560; cv=none; b=GyMXTebBJZNbZPl/stTFrLzMFuESBKsvKwrco2aoBCWiaOlutTKHRHXj9/9vkar2D6ZSV2YvggnK4KVB73nFRZzxVyuQoc9wEijCPEm/Sg7TNnUR9dsnWBxpLPJ3e9iEUQS/9UGCvWtYV09dvhkVIjI8PFiQpKwEYAyPy4Uf088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229560; c=relaxed/simple;
	bh=z9FygIuKxU14dZKl9fA8Rk3lkYSVbb8FjnTr17YcsL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pn+F0U9hWILIe9FUGNhg0BBIIeDpTHBtiG/NQEdSWh5iKicoS1bU3JkzG9a0JtFvbxNLSVHGDKIaWF5CTCW2AOtU7usSr/FqSKepRBh984v+iueSlFTdzTjDHzT3riGJApFJNgC6QDXbh6qlBAw8IqQE65X8M5LqCBB94dv4O78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSH7s9z8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSH7s9z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A5F1F000E9;
	Thu, 20 Aug 2026 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229557;
	bh=TdNhxPWEpp8B9DoZmO2TFYO1xwfI3e2Cw+t5gyyWBAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSH7s9z8l1zaB0tENnxf+xhztsLfkPhWuAvTCRDuKF1zKE5w8nsNwU/GLOEkCfVJ9
	 2pI49iWCMhJ3DTg3xpgrsTuhj74/O5qI9d8b4cczViwA78D+sXgqEVAd6iz4nTVTaJ
	 D5RmY8tgv1QzV8GJco24115N+agDXjKq4F6hGLZ406UrIe5H6JZtoje345s4a0x6GH
	 IMLmhcepvDAgkZzz1rKcwiHHT5FsDlZA5yoPJk6cr5ex8N9zb8vUKAKrShqzTw4uaH
	 xAylFLmzMZKV8Jw8DNl5NQVtT+JOMOXFVu4Ro5rjyal6aZTKi14hkcGwemFwgp/a1D
	 SuK0gnwpxal9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daming Li <d4n.for.sec@gmail.com>,
	Vega <vega@nebusec.ai>,
	Xiao Liu <lx24@stu.ynu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net: smc: fix splice entry lifetime imbalance in smc_rx_splice
Date: Thu, 20 Aug 2026 08:39:14 -0400
Message-ID: <20260820123914.1615169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820123914.1615169-1-sashal@kernel.org>
References: <2026081710-untie-barn-6dcc@gregkh>
 <20260820123914.1615169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daming Li <d4n.for.sec@gmail.com>

[ Upstream commit 5d9686af2976741bbd79b150d1c9e60b81e7f12e ]

smc_rx_splice() passes pages to splice_to_pipe() before taking the
references that cover the lifetime of each splice entry. In the
VM-backed RMB path, splice_to_pipe() may drop unqueued entries through
smc_rx_spd_release(), while queued entries are released later via the
pipe buffer callback.

The old post-splice accounting also derives the number of queued VM pages
from an offset mutated while building the descriptor, and a multi-page
splice pairs one sock_hold() with multiple sock_put() calls.

Take the page and socket references for every candidate entry before
splice_to_pipe(), and drop the matching private state, page reference,
and socket reference from smc_rx_spd_release() for entries that never
get queued. This fixes a refcount imbalance that can underflow page
refcounts and trigger a use-after-free.

Fixes: 9014db202cb7 ("smc: add support for splice()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Link: https://patch.msgid.link/20260730145552.360287-2-enjou1224z@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ collapsed the multi-page get_page()/sock_hold() loop to a single get_page()/sock_hold() pair and dropped the trailing kfree() calls, as 5.15 lacks the multi-page pages[]/partial[]/priv[] arrays ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_rx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 3468c58bbeebe..33b5bcafdec7d 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -145,7 +145,12 @@ static const struct pipe_buf_operations smc_pipe_ops = {
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
 			       unsigned int i)
 {
+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
+	struct sock *sk = &priv->smc->sk;
+
+	kfree(priv);
 	put_page(spd->pages[i]);
+	sock_put(sk);
 }
 
 static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
@@ -165,6 +170,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	partial.len = len;
 	partial.private = (unsigned long)priv;
 
+	get_page(smc->conn.rmb_desc->pages);
+	sock_hold(&smc->sk);
 	spd.nr_pages_max = 1;
 	spd.nr_pages = 1;
 	spd.pages = &smc->conn.rmb_desc->pages;
@@ -173,11 +180,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	spd.spd_release = smc_rx_spd_release;
 
 	bytes = splice_to_pipe(pipe, &spd);
-	if (bytes > 0) {
-		sock_hold(&smc->sk);
-		get_page(smc->conn.rmb_desc->pages);
+	if (bytes > 0)
 		atomic_add(bytes, &smc->conn.splice_pending);
-	}
 
 	return bytes;
 }
-- 
2.53.0

