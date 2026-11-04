Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801697;
	b=mDCd2QVqiA/HDbFCijebXpULegmcAt5Gjrp4EqQPQV4YfAFt76qq8UMfHKAoyQkr+zIm
	 FeKbxNP9qWpbHfJ5ttDhLxcuUHbfKZ4/wGm38mGQaht1JIFO8q2wT3kdkVbBuCGItF/hi
	 czDR6hCk3rHqRjMZIJ4Efopfn8DP/c/urywGNSKQcBSeJU9wEWQY3vt7F3Z0GTNUcCboo
	 7cIpshPqovIOkKWZh7oZczZeqd6T0T3r84XU+ozRwAa1VmHHBd8hnL5xNRYZ+DqN97Zvj
	 N6lEaS6ipNAFXaMNCb9iCvZqdh+b1blueqA6AHHOaTO1NQ7D6/ODN/Nin//op9a/EJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801697;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p2jFi1+oVL5KDbjie1pBWMfP8RrBdGUj5vd1USLrnC4=;
	b=ZA89IbTX9zTPulHbeWLjxBCaR3G4axcADCvtE6++fogqBwyHDSqXqdN/XHcVH4PMRBrS
	 +QriZ0ffsb+dcBOHjfqiXOFZqurGLwjzeTtR1CGCiyi4wxOMgiVqMp9EHs40ZXGVuuIrw
	 Mqm/C7kaGrvVjf51Nue7tqW0igxcRlIT5pLZsoeSMMRtOcDuT294uZrbCrGxcDCZCOl6x
	 6O7viJMofTzPga/nQSTxPFCFPENlkIMVwHGj++r7WYNNlhZhsj0yXzLUlqOtC/mb+wW5R
	 lD8bhU2p32zAPdHtqpKdwTAsEnecoiZqSHohPbKxVIOS1+FJ1+esuP3SCzyh0ocwwqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VoKF4U5D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBF7606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VoKF4U5D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE91F000C1;
	Wed,  4 Nov 2026 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801697;
	bh=p2jFi1+oVL5KDbjie1pBWMfP8RrBdGUj5vd1USLrnC4=;
	h=Subject:To:Cc:From:Date;
	b=VoKF4U5DrAa82ZtpN5BH0x/RNHvAnxx8qYkRVmXFB0xiyrgj2b2R0qZFxn9pnkbbl
	 WHLYrw0JE5jszrlJMY8tI6ZksjlPzqgF01UsPin2/6tvnQOIwRyNHbiIrjphAnT2L3
	 j/topCvJAk31fawOxhOYr0+u/ArMFKSacQRibaj0=
Subject: FAILED: patch "[PATCH] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering" failed to apply to 6.12-stable tree
To: fanwu01@zju.edu.cn,Vijendar.Mukunda@amd.com,broonie@kernel.org,songl@zju.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:14:55 +0100
Message-ID: <2026110455-remark-unbuckled-2216@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c53791d673ed4da6759d276078627ec4d0c6536b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110455-remark-unbuckled-2216@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c53791d673ed4da6759d276078627ec4d0c6536b Mon Sep 17 00:00:00 2001
From: Fan Wu <fanwu01@zju.edu.cn>
Date: Tue, 29 Sep 2026 06:13:49 +0000
Subject: [PATCH] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering

The ACP IRQ handlers dereference the SoundWire, SoundWire DMA, and PDM
child platform devices, but snd_acp63_remove() unregisters them while
the interrupt is still held by devres, which frees it only after remove
returns. An interrupt in this window is a use-after-free.

Mask the ACP interrupt sources and call devm_free_irq() before the
first child device is unregistered. The masking goes through the new
acp_hw_ops->disable_interrupts callback, keeping the remove path
platform-agnostic. The interrupt line is shared, and acp_hw_deinit()
clears the sources only after the children are gone, which would
leave the line raised with no handler left to ack it. The window
predates the tagged refactor, which only reshaped the dereferences.

devm_free_irq() waits for in-flight handlers, but not for work the
hardirq has already queued: acp63_irq_handler() schedules
amd_sdw_irq_thread on the SoundWire manager. Draining that work in
the manager's remove path is a soundwire-side change and follows
separately.

This issue was found by an in-house static analysis tool.

Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20260929061349.3879-1-fanwu01@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 62cb6bef17ab..d0cfbd4dafc1 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -294,6 +294,7 @@ struct acp63_dev_data;
  * struct acp_hw_ops - ACP PCI driver platform specific ops
  * @acp_init: ACP initialization
  * @acp_deinit: ACP de-initialization
+ * @disable_interrupts: disable ACP interrupt sources
  * @acp_get_config: function to read the acp pin configuration
  * @acp_sdw_dma_irq_thread: ACP SoundWire DMA interrupt thread
  * acp_suspend: ACP system level suspend callback
@@ -304,6 +305,7 @@ struct acp63_dev_data;
 struct acp_hw_ops {
 	int (*acp_init)(void __iomem *acp_base, struct device *dev);
 	int (*acp_deinit)(void __iomem *acp_base, struct device *dev);
+	void (*disable_interrupts)(void __iomem *acp_base);
 	void (*acp_get_config)(struct pci_dev *pci, struct acp63_dev_data *acp_data);
 	void (*acp_sdw_dma_irq_thread)(struct acp63_dev_data *acp_data);
 	int (*acp_suspend)(struct device *dev);
@@ -397,6 +399,12 @@ static inline int acp_hw_deinit(struct acp63_dev_data *adata, struct device *dev
 	return -EOPNOTSUPP;
 }
 
+static inline void acp_hw_disable_interrupts(struct acp63_dev_data *adata)
+{
+	if (adata && adata->hw_ops && adata->hw_ops->disable_interrupts)
+		ACP_HW_OPS(adata, disable_interrupts)(adata->acp63_base);
+}
+
 static inline void acp_hw_get_config(struct pci_dev *pci, struct acp63_dev_data *adata)
 {
 	if (adata && adata->hw_ops && adata->hw_ops->acp_get_config)
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 729f9aaba69e..b604db4942dd 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -738,6 +738,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret;
 
 	adata = pci_get_drvdata(pci);
+	acp_hw_disable_interrupts(adata);
+	devm_free_irq(&pci->dev, pci->irq, adata);
 	if (adata->sdw) {
 		amd_sdw_exit(adata);
 		platform_device_unregister(adata->sdw_dma_dev);
diff --git a/sound/soc/amd/ps/ps-common.c b/sound/soc/amd/ps/ps-common.c
index 7b4966b75dc6..ea71cdf19c1e 100644
--- a/sound/soc/amd/ps/ps-common.c
+++ b/sound/soc/amd/ps/ps-common.c
@@ -248,6 +248,7 @@ void acp63_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp63_init;
 	hw_ops->acp_deinit = acp63_deinit;
+	hw_ops->disable_interrupts = acp63_disable_interrupts;
 	hw_ops->acp_get_config = acp63_get_config;
 	hw_ops->acp_sdw_dma_irq_thread = acp63_sdw_dma_irq_thread;
 	hw_ops->acp_suspend = snd_acp63_suspend;
@@ -484,6 +485,7 @@ void acp70_hw_init_ops(struct acp_hw_ops *hw_ops)
 {
 	hw_ops->acp_init = acp70_init;
 	hw_ops->acp_deinit = acp70_deinit;
+	hw_ops->disable_interrupts = acp70_disable_interrupts;
 	hw_ops->acp_get_config = acp70_get_config;
 	hw_ops->acp_sdw_dma_irq_thread = acp70_sdw_dma_irq_thread;
 	hw_ops->acp_suspend = snd_acp70_suspend;

