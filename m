Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FAE5328A1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951280; cv=none; b=XiibKS3yMxWNEMjtw6sxj8OlI19Zy/iAIYYihfnpEQrTgzUqfd61tW81ZUXooDZ49zN6Nm1jM0aDOmNJdEnr8Q/PrbpogPKX8H1+5wcZnYzyI5UmK+LpO5I+XOWXsPkCPxfa6JihV/+2pQFJFRNuU51Y5MiH9w7PdLJUAz38KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951280; c=relaxed/simple;
	bh=rJvIK3kj6V04eeN8HoPVZYoCchlUTtXzAPr+T2fhHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDch+xck9KeV6/RvZOQFXPQVHS8LPL9TlKIxqeP+lMCzOLkfBmZwslLA+6RYPhAlhyg6iLNvgYSCcVfeKtboOdUNvy8V7J+37IEcmcSFFtkZWMz7qc+WbJDTiP1tqjDVY5QmBNQygOMKkuuJP8JnyK+Xc5F7n3HR3mofG+/Kpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYJOL5+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYJOL5+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3001F00A3E;
	Wed,  9 Sep 2026 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951275;
	bh=rSfJja/v1WRQEA60s8RcjGSCb5F7wON/+VizKLYBYvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYJOL5+kgc41wmkaBnxOrObYFic30yon45bNBJYijT07s+d7y2rrmKNBHIMNZTrZ3
	 J9wrPF4AVvmvhexB7cLle/hGcw986k4TiTqgu46cZAPY8yYsnYJwaicBGTqEegTRBB
	 pSwBtL7BOrBAeOlRKRwhTUh3V/kAgjzhVZsGgnl62QmHbZG0GVOFMuwUe/gUJ4PBKg
	 vCO6JSdB6wycniRfh6/POgNC/0ZdtVsEtH2xc+Fcal4CpHVEfvTK+VrHFSpYf/qFwg
	 N4hxw57pnDx0AEvHpb7Ngn5XhVz3XygqcRM3P/ty/rRL7BRwub44yA0cQMrWv+DeY2
	 +39jHDcKWgVMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] dmaengine: Add devm_dma_request_chan()
Date: Wed,  9 Sep 2026 06:54:32 -0400
Message-ID: <20260909105433.1622090-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090301-rope-disprove-ff1d@gregkh>
References: <2026090301-rope-disprove-ff1d@gregkh>
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
index d89827d0927e4..9fb312cebe7dd 100644
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
index 3576c6e89fea4..368a03920c928 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1489,6 +1489,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1525,6 +1526,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
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

