Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165D3403EA;
	Sat, 30 May 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173833; cv=none; b=F7BaKA1byrSEaHEeTrIVV3cg0Wdh4KFCxL2lvoQhGQcN8wevqZeHCyucfg448z8MqtZzAbWuCyAjeHQ+NGcSJ4B+TCp+LOTv3JLB0pwIaVomYQiKt9IKFNg7ZOuj3ZsoWbtlPnusQlC0NtIPCmNcmBB8TD/4MAfRUcelZzaDZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173833; c=relaxed/simple;
	bh=QI3ukdgzn9oHtvVOdq3G5jrrDf/hk6qMFVNn95PXs6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZJgQuvaoGnx6DZyo4ivLJoA3++it2szV16bqdel/ytRw8G6mnUepxmy74TNfPcLYy9TcJHiNxyBK7sBd3LYxV2QbhmiuYc/RWx3guPs7L1z0n0vZHkAgeQxQHL/4Lp1w41FKBqEd7RlCNAE0cYd6YFN9JEjIIOY2XLmc9cJuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9VYEzBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9VYEzBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125211F00898;
	Sat, 30 May 2026 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173832;
	bh=hpMYg9af1pGzvuZiChTfHI2TaVJJnId4BcvefQrMcws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g9VYEzBibwBclm0bULayQCINiCUNdD/V2GBTFZAMtB4F0vgk6W17a7lXQszAN7wf4
	 q2Eh7z01NdLsJC5vK83Z7Awi/eEAd4HyWdngA3Xj4DREIZHaTZzksA64rk0NamkkYp
	 rELFUS5Iht5wZFF0WjSQCOAyBYhdUpeIkOYu5hfgDQp/RkDN+vlVEbllo2i7d+/Ijc
	 trueC9/xCdsLwj7AGRwyC8cg7h/jxpjPPnTYV4//JNugPqv++TrUVjjTxpiBmXvAgS
	 5rVT/v9lvEmC5wGf4G3iGBgfY4Y68eAwG1gdS2lO0V8/S5wPKOWfCEK0DXrNeqosJZ
	 5ROuOOhh/Ijeg==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Andre Heider <a.heider@gmail.com>,
	Stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/2] nvmem: layouts: onie-tlv: fix hang on unknown types
Date: Sat, 30 May 2026 21:43:39 +0100
Message-ID: <20260530204340.116743-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204340.116743-1-srini@kernel.org>
References: <20260530204340.116743-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Heider <a.heider@gmail.com>

The EEPROM on my board has a vendor specific entry of type 0x41. When
stumbling upon that, this driver hangs in an endless loop.

Fix it by keep incrementing the offset on unknown entries, so the loop
will eventually stop.

Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
Cc: Stable@vger.kernel.org
Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/layouts/onie-tlv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 0967a32319a2..8b0f3c1b8a0e 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -119,7 +119,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 
 		cell.name = onie_tlv_cell_name(tlv.type);
 		if (!cell.name)
-			continue;
+			goto next;
 
 		cell.offset = hdr_len + offset + sizeof(tlv.type) + sizeof(tlv.len);
 		cell.bytes = tlv.len;
@@ -132,6 +132,7 @@ static int onie_tlv_add_cells(struct device *dev, struct nvmem_device *nvmem,
 			return ret;
 		}
 
+next:
 		offset += sizeof(tlv) + tlv.len;
 	}
 
-- 
2.53.0

