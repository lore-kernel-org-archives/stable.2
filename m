Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601A39CD0F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613441; cv=none; b=JFSjFylPXYpcj1bwOg0O1EDMEh0+Gx7onFBKevWySlloBxrYE6vLt37iM2Apkki5cPnWAMITvQzvnoPU/twUOkK5F1QGKUO31MTFnzVq8CqUzMXyqzARRuPDNPEaCtqAYC8UjmrNLcvGSrkvVdgGDs66g10gAfikQN5MMhDlop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613441; c=relaxed/simple;
	bh=iRAL3qPdwITB9yb+MvNH7A+H56cD0dRAd0eaL4QJCNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgHNZnj9XzGTYMzVYIJb4QkYz5h4Cer3a1ihMSFk3u1jPYZ0si9Uo+4/HiMZt9GQ/bwOgAdu6goHCRTqdPwUWIgkaZ6wPxf4jfqSZI9UUvLSZVEM9kgWzf/zIIoNGIEkBCqsozQfHzCzHCET2fmx0KlxxIohMwzj525QKiRUAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXK08hKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXK08hKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F411F0089A;
	Thu, 17 Sep 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613416;
	bh=VdrVZ95upx2ZXuX19ZL7V/1wwE1+D4Hbk6Z0W7SltZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXK08hKOsyuSd/w8iFLaNHYAVerwUdxmH9a/Cisp97ZYEmXQZ8uyys3FgfX3TnvnF
	 gFhO0InnwdslZxj4LyOvICGwCm9MaWQZykINE3lV+j+dE4t4zCCvG/rkqaLbySOds4
	 z9gxkrm1I6Q7NOEnxpgtkd3sGUgQ1gkWDSRfT+YVfVmXqD3SLp/Ul3PCgsqr7ACMNN
	 /tJmj/Pxss5FtPS6dwGFuiUpjqYN0tlgNyvp9dkjpJw5ducpzyq3WupZ95fakQdViy
	 A3aS4TkQE3mPLZ+817f8D3XhNQJOjCLg2xakvbz9A2UTcebfhsyoFEfKIykLrSUjVa
	 hS/D7zlgUYMYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
Date: Wed, 16 Sep 2026 22:50:11 -0400
Message-ID: <20260917025012.3917055-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025012.3917055-1-sashal@kernel.org>
References: <2026091638-excretory-liquid-7149@gregkh>
 <20260917025012.3917055-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <joe@dama.to>

[ Upstream commit b814dfbfeb0a68c9a52073f2caa05a2d5247a329 ]

bnxt_alloc_one_tpa_info_data() returns -ENOMEM as soon as one allocation
fails. This leaves the remaining rxr->rx_tpa[] entries zeroed.

bnxt_queue_mem_alloc() discards that return value, so the partially
initialized ring is installed by bnxt_queue_start().

Since the agg_id is picked by the hardware and bnxt_alloc_agg_idx maps
it to a SW index in rxr->rx_tpa[], it is possible that an uninitialized
slot can be chosen which would hand a zero DMA address to the device.

Fix this by checking the return value of bnxt_alloc_one_tpa_info_data
and unwinding, freeing the ring buffers.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260902015652.2421609-4-joe@dama.to
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Retained bnxt_alloc_one_rx_ring_page() instead of upstream bnxt_alloc_one_rx_ring_netmem(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e14e2a0bf89ce..d14a2de8c06d9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15417,11 +15417,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_alloc_one_rx_ring_page(bp, clone, idx);
-	if (bp->flags & BNXT_FLAG_TPA)
-		bnxt_alloc_one_tpa_info_data(bp, clone);
+	if (bp->flags & BNXT_FLAG_TPA) {
+		rc = bnxt_alloc_one_tpa_info_data(bp, clone);
+		if (rc)
+			goto err_free_rx_ring_skbs;
+	}
 
 	return 0;
 
+err_free_rx_ring_skbs:
+	bnxt_free_one_rx_ring_skbs(bp, clone);
 err_free_tpa_info:
 	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:
-- 
2.53.0

