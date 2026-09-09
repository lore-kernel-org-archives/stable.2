Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9E530DEC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950725; cv=none; b=C60mrNyWaXkTwNGIaeIJKrzzZfuVzR5FcidArm4a49ISL4apjSQo4/oJTaHs+sWL/EhW0ADtazSKNMnpRrMhj04SGo4kqI5wNxPt+R+4VDhvrdnBUuT79SHL6BLPhXH7SCjV28YPetg0PoCEpDdbsOfLVqthIJ4uF9kuHtVwkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950725; c=relaxed/simple;
	bh=wpscjhLHShuwilUgf5sf+EJsZDPfuVat+Cx+eMm5A+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZg7cMKaLPxRdWu69B03HNzYaPslHVcql5XAELEwjEcXzbdhVLqSxwE2F+bc5g2Dxmj1/Aak1M6rMtGkqQN0p7r8D6oMtiqhiXsjkTZ0pTkjenfATe0jFRbME6i+B36pZLknHnlasmJser4VXbXLbaLmbQd39kXrr7goUGeg7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IANHaZjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IANHaZjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C121F00A3D;
	Wed,  9 Sep 2026 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950722;
	bh=lmCA/LwkBP52y2wIsxzkF6RN0Wlb4enyMufQDTETJ4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IANHaZjnNqMgdrloai+kE5bqc04UytXxdHM4w1P6uVwZOix5BXJC1gaD2DOazSTp8
	 bD4z8S1R38SLiiPj8L/AItkgG+bm2GtJLk1BjfRUjcUf2xY34Em72am9PfyQMX1QAw
	 YJfWaBOC5UfB7MYkPSr7+BIdEIqKNVfIELo5NZbejU/ISKJqm0Cf5y+KDk9FuGR8Re
	 uNI4mXh+mLN8AShVCgXpRn/oeXvBW1tDTCasatRdsYuMY5s2WvPx0Qu0EcSZljXcOR
	 6KnThmlJmW1ywMHsZr0U062U95dQn3cEjL0GrZf0Yqk5+PEj3ETNxcaKktDCMC8f68
	 90Iw4UQE/4nJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] dmaengine: Add devm_dma_request_chan()
Date: Wed,  9 Sep 2026 06:45:19 -0400
Message-ID: <20260909104520.1561085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090301-luncheon-compactly-c5cc@gregkh>
References: <2026090301-luncheon-compactly-c5cc@gregkh>
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
index b1c9187602d53..8f221a407fc04 100644
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
index cff3dba658209..ea476ea79f767 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1490,6 +1490,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1526,6 +1527,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
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

