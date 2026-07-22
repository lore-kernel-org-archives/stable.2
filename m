Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673E3EA955
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739280; cv=none; b=aTNET3C19lPH1PNEq6oduPIGn/wC6NT5l3Xyu6pxHTwZ8G/Oo+8EA+8uEbchEM7c9P+ruSWA7tL00kWSMhaAZ7NHHao7v+lMdPoElpQm10YtxlhgNcM+bD4Uut60/IzhIMuqQmYf8LwQ6PJt5QqhPvkK+X4zcOpwIS75yZHH5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739280; c=relaxed/simple;
	bh=Q89PBk4jiuGmoLzAyNUi2dvWt2LetgqGVbPEf05l9Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3dGgqhT18bSivIhacPFmXpWahdoeM39pggvKFdck4uWsZOXdyNhV60MFranRVnobBBDLqHRk+3rUS8P4uD0dZ/AbS0luDbJnNSTAO5p07NdMpvokPcAnPKzITY3oy7kfrEOkAlj1lcVoKwjycYs0n79+vt4A51j7j+LbEkd1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSBsDILI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSBsDILI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2381F00A3D;
	Wed, 22 Jul 2026 16:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739279;
	bh=tqkyyamt+QcgFH9NFRzdMikWLyJXh7qTbPZe5zvRFNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSBsDILIcyzTHciZtW7qyl3XiD74K894cui3ou9sUzh3Vq6p1xLK8475GbaZuusHV
	 Hgtde3XUaD0PEdqFlChSc02OoUvE6aFCfxjZYiIyjELS01H7mhc8qi+ELEanYzzuQr
	 x3XSNEWMePOg3GeN/JGvsaOICr/K8QcWpWgLORQhYlDWZWHdxAhIie62jbELV3Ykf3
	 dUJg0idIjtnw7hURplgZvb7nV3JvKr4xLbsh+6fBRv6ED83at/MQt2AR9J7Kcy1UV+
	 V7dFE3Wf9ZeZHhKit/XTyfoApsKoesaag1NyY6LjU8KftzGTot1HC711gDpQbxoVWC
	 bYcuWLYGt38Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] VDUSE: avoid leaking information to userspace
Date: Wed, 22 Jul 2026 12:54:33 -0400
Message-ID: <20260722165433.1853588-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722165433.1853588-1-sashal@kernel.org>
References: <2026072041-theft-grievous-be50@gregkh>
 <20260722165433.1853588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 9c1523803445ee0348f62b77793266dd981596e0 ]

The bounceing is not necessarily page aligned, so current VDUSE can
leak kernel information through mapping bounce pages to
userspace. Allocate bounce pages with __GFP_ZERO to avoid leaking
information to userspace.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260130050750.4050-1-jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 0a9f668467a8df..ec743bed361c17 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -124,7 +124,7 @@ static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 		if (!map->bounce_page) {
 			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
 			if (!head_map->bounce_page) {
-				tmp_page = alloc_page(GFP_ATOMIC);
+				tmp_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
 				if (!tmp_page)
 					return -ENOMEM;
 				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 505171a17de873..4348f4279cece6 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -864,7 +864,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 
 	*dma_addr = DMA_MAPPING_ERROR;
 
-	addr = alloc_pages_exact(size, flag);
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-- 
2.53.0

