Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130D538D75
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951843; cv=none; b=p2FXzGzHCtgGCMkZat1SdcnVrwGX9s+bWoGpQzJiZSLPzH7wrnxIszTamnfektn1FzR8Ajyx1qSxY16TGsKSMgpYSs7El2C36H/eLrTIonINUOogcjTyPuieOis+fo7YljL3IsccjVtrxqVUKGswJwQVZVtWPF78pntw/cBRHWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951843; c=relaxed/simple;
	bh=QY0kS79idmaeGO5KfkJs/i2KbgE/Po5oANP5haxKRkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RN7HNya5rlS7rihelmKEkAZ9O1LU2BPjf53y9YAcVgqTJq23fc1kFPmdkApQnj0cVoiiQg1CKiD/p/mM/EbEqYSdSzq2tXwXlyiTPZuBfEjgbVU8BQqpsv/AiiEj7GvVgRDjAl0sPhkbFTUe6DHMao+GmUrT+0VQnVyalwLQwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv2TSPfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv2TSPfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE91F00A3F;
	Wed,  9 Sep 2026 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951835;
	bh=qc5iNUuy3ecj9jqvZOjh8JkbWIEud8na6+sLt6OCmq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nv2TSPfXKiqllOJGfju2Dj92ElEfDdWBBGpkgjkPSaPoF+d6nsB/529BhAuqDk8yU
	 CZ6TmS65jgy/CJGlfK+FRTI0T4JrNcEdOHUBHcLaT/ASt5ryhgY78aQ5BN7K42S0A5
	 mSwEgumovaLxBhHFELJTOUpkboUi4jnW7Z+Gaz+smWF8Hpww5XwZPq+7RdWp4eWiyO
	 T8TSfiBEMaRdaQ0JJkskdKqNx0pplF3zUmhVTUljWnxxUoA712U2rruCPIWzFvO6Kn
	 mkPJULVcVVPELVLE00VQXpIsJlHO1BNRSf9nn0X3ldSJKNBhksGr9yUfVgiXE2oKZd
	 FSJ/RTqFWsXmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] dmaengine: Add devm_dma_request_chan()
Date: Wed,  9 Sep 2026 07:03:52 -0400
Message-ID: <20260909110354.1706356-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090302-opposite-tuesday-1dc5@gregkh>
References: <2026090302-opposite-tuesday-1dc5@gregkh>
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
index 68078e83d5756..66b5db511601b 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -928,6 +928,36 @@ void dma_release_channel(struct dma_chan *chan)
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
index 4e4cce0ad4d79..0f3a35da0c99c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1476,6 +1476,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1512,6 +1513,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
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

