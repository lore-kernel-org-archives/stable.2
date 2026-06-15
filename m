Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D63845CE
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558180; cv=none; b=BbSTJWkLX/e86uu0hI0OJ1GYWtA7mqxrxOQnMHvY3+LNWsfm7TDOrjzYZjY/mtMrSX5A5F06J06sSRa2LxjJ/9U6wLXKON9JBjf2VglVfFGmbtMF636TrVly9BV5UjFcHx9Nu5/Fgl4voLyMD4cY4aavtCbqzxoOzF2Drb0uqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558180; c=relaxed/simple;
	bh=3G7mFK1ZdIWoiNhGyc7v5JuNYpf1OWguiMFGf+E+E94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqtZ1vwXQONAe0sNyU7fK4BoP5Z0fyeqAAc2lhe1ZPPkmOPpV+W742oDkKt5hX9luvcXXjmVal/AJR0B1NGfjCwOAyXicWOFSg/C0E4U+uAkgflz9VwQR02C+wIUtgMzGXfRbvx9+tVnSuV6WL/Wksmc8K4JxvJIUuh5TCxjJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az+XbB1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az+XbB1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D921F00A3E;
	Mon, 15 Jun 2026 21:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558179;
	bh=FjirVKDkH3qdM39UzAmWvoyPWdH7AsBUgT4+UkRLTFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=az+XbB1Yv7AEn3HUUiIZv+mi/14CSsY3P4o5DGLM6ux0v4NHaO+QLqlbs6nTvRlY5
	 ui0q3bu+K21RTx2cnAq4vfRusVj4r+BTY8lvhqjtCmYe/geTgZPanF8TxXIXqVsypm
	 1baUDD/oijmP3QBMcg87z0akCZtVoPfGtHhHfrsn9nOjz2k05N5IkptwOv3Zy9rly6
	 9TDNw0WwImRfx3fJ/8n13QjOITtuPHUCDysZiw0c8AM9/d03lwxbBbPHRcQ532hJdF
	 CjViQtvpgU4J/Tq9qb8x9sXKUo3yCy1d6Ay6jEnOvLvK9QUTLpphKbcyRQOhrSVCQp
	 ER8QtZriibEVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] RDMA/umem: Move umem dmabuf revoke logic into helper function
Date: Mon, 15 Jun 2026 17:16:14 -0400
Message-ID: <20260615211616.2460210-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615211616.2460210-1-sashal@kernel.org>
References: <2026061550-repaying-riddance-1fc6@gregkh>
 <20260615211616.2460210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 797291a66ce346c96114b72222fc290d402da005 ]

This same logic will eventually be reused from within the
invalidate_mappings callback which already has the dma_resv_lock
held, so break it out into a separate function so it can be reused.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
Link: https://patch.msgid.link/20260305170826.3803155-3-jmoroni@google.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Stable-dep-of: badad6fad60d ("RDMA: During rereg_mr ensure that REREG_ACCESS is compatible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_dmabuf.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 09ab54950e2fac..fa31a21a970da0 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -198,6 +198,22 @@ static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
+static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+
+	if (umem_dmabuf->revoked)
+		return;
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	if (umem_dmabuf->pinned) {
+		dma_buf_unpin(umem_dmabuf->attach);
+		umem_dmabuf->pinned = 0;
+	}
+	umem_dmabuf->revoked = 1;
+}
+
 static struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
 				   struct device *dma_device,
@@ -265,15 +281,7 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
-	if (umem_dmabuf->revoked)
-		goto end;
-	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	if (umem_dmabuf->pinned) {
-		dma_buf_unpin(umem_dmabuf->attach);
-		umem_dmabuf->pinned = 0;
-	}
-	umem_dmabuf->revoked = 1;
-end:
+	ib_umem_dmabuf_revoke_locked(umem_dmabuf->attach);
 	dma_resv_unlock(dmabuf->resv);
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_revoke);
-- 
2.53.0

