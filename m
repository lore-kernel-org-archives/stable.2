Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F993E638C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950260; cv=none; b=uXriYyx8eaN41bAN8rJRLszMKOs+uciYWgDVLt87GgfCVCm1q3kaxysJGBQMFs8YyEY2+Cwvh2EJBvlxJ497JeUq5IZMBp2T6gMV6GHlwCdj7NlaFNRyIrbaqkkSN8Dlb3Jn0WAYMj5w8d9wrrIJLiAf0RTFi8a+d+CmH16o3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950260; c=relaxed/simple;
	bh=COuEBZTOheVk38rYaLV2hA3b8RYkv2KQzEiY6D14g98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iw2VIsVKysMCzPlpeiZ8I3I9leBRZ2lVKxKF13WnOIFqwAfw5s4qZP4NzKc/zUzHiyaIKFTt9QYIjUAG1mjrJ2uCQM24IjaZH5AQfkGGMajkw1AUibph37KGdj+qQFNbOqaqa2oNcc3Ah/9fgLHPT35DaGwR62ofMerboDGJY5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqcJvChL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqcJvChL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165B31F00A3A;
	Wed,  9 Sep 2026 10:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950258;
	bh=ywyM7S4J4pjIzcoc1RNSYUSDCzYUOHwZ84pVySI2Nxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqcJvChL7LhfKo6Ge0E/9t3D1v51BU6mmcvZo0u8VOKjUJqFwciA05JL4iE1seP+s
	 oHVZDxVXgC2j6p2s86gJhDSTjqZvv8CWWPOdEQGFwmOJKdnpRbLq7ayixr/xjOA8St
	 yNBZmshzV31TThIwkCWbOOh+NYD4XokINAoaVgzSrawMthH1NZWkH4Mc2TJTmkqKQ3
	 yN6+TavACgXXLwHWij9k8eeTKqhSBTLGFNgGbnvU3zUDAj2vytiAV0WR0LCsgYTZQB
	 iivSvFu1J6xxjYjbijNQVXoRTLMBvyKSfSIJ57fpDYYVUFP377e5bNmBhpQLFdqHzy
	 gylEFbwoSGdvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] dmaengine: Add devm_dma_request_chan()
Date: Wed,  9 Sep 2026 06:37:35 -0400
Message-ID: <20260909103736.1550307-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090301-stream-storage-7d41@gregkh>
References: <2026090301-stream-storage-7d41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bence Csókás <csokas.bence@prolan.hu>

[ Upstream commit 08bf1663c21a3e815eda28fa242d84c945ca3b94 ]

Expand the arsenal of devm functions for DMA devices, this time for
requesting channels.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
Link: https://lore.kernel.org/r/20250610082256.400492-2-csokas.bence@prolan.hu
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 777979e62711 ("i2c: mxs: fix DMA channel leak on probe error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/dmaengine.c   | 30 ++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  7 +++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e241b7b01233e..72656845f839f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -927,6 +927,36 @@ void dma_release_channel(struct dma_chan *chan)
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);
 
+static void dmaenginem_release_channel(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_dma_request_chan - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate DMA channel on success or an error pointer.
+ *
+ * The operation is managed and will be undone on driver detach.
+ */
+
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
+{
+	struct dma_chan *chan = dma_request_chan(dev, name);
+	int ret = 0;
+
+	if (!IS_ERR(chan))
+		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
+
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_dma_request_chan);
+
 /**
  * dmaengine_get - register interest in dma_channels
  */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b137fdb56093b..631519552c5a9 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1521,6 +1521,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1557,6 +1558,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-- 
2.53.0

