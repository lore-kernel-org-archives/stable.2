Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3837F8C6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951445; cv=none; b=X91MZEZ5OTPMhvE5DobC6RimukIOo22CS7F2pScBeAXnriDxB/H4Ah3zFy00Ea9eFOrqYQyGfzDPAZ+XszIzsNeptK/zKWNov6FeN1SUZecp8d+M/qUXTNL98ScWoG4CCbhc3Pyqc8UbQP6G9rAJNLiSjjbwGwheLgsHMZTdE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951445; c=relaxed/simple;
	bh=JmpHa1XEGHXion+AfCJkbcsKAKfHx9mHhcUAt5dpDUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWZ9ahglJcOrzRvNIopIssXTtFFih/TFKQ5u40MjpT1H4cmUH3LJ5k89CUwFdiuad9kD/9GPzHQl+UgM0Mg5YNJORNe65NvvsQrSLOQTXRkmtim2afoFPp7YAmF2x5Jrywisg6Fw89tT6CGgtOk3xo0nkSY+INWam921NtUzk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik0efii+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik0efii+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEF11F00AC4;
	Wed,  9 Sep 2026 10:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951443;
	bh=3V6Xbc+aaQWWkqwTW1ipdVJJgGGGpYw+4nOaYsJ3Nug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ik0efii+rbhA5Znkek/KB2l+1mk5ZyR6I6jN1LGMSLxChNx8bF2F9xovHp3h3LSFY
	 K2FZNPeEm9x6iaQ7Gqt5BPNAV79ampyu/3ACcZGxNG332XXzFf2MeDeeMENDkSropM
	 yBdm/A2u+770aT+DAUA5PVGiD3xiluBlETO1/iucMNdy1VWf9vcpiuSms09orv4vtL
	 5yD2kyzGrho1Y7FAJYkXGZNNevjq8AjQGgQDcNlggao7iWgme7Ggj8cp9PuMnsofCj
	 BkjCSwBZiZjDUv44b4fPl6gDLgUjxt5247XUlPs6SQxBDmAPPZQbADvQV+C8He+RgB
	 ZmwkWeRsodrzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] dmaengine: Add devm_dma_request_chan()
Date: Wed,  9 Sep 2026 06:57:20 -0400
Message-ID: <20260909105721.1641676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090302-showgirl-ongoing-e7b7@gregkh>
References: <2026090302-showgirl-ongoing-e7b7@gregkh>
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
index 04826a7930392..e4f4838f3b7b6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1486,6 +1486,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
@@ -1522,6 +1523,12 @@ static inline struct dma_chan *dma_request_chan_by_mask(
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

