Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933520;
	b=lPVluDLEqqTFaqtkq+OEAerveDSqhzPPMdUPw0VZSUr/dafOBpYp3VzNytNtPmCnjnG+
	 ORlQjsvQxrkIvbBBjTtTl/uBGxnsnHIXSneiBRe8lDRb3IR8S8poeWBVprTPx4wR9dFUD
	 WnLCes5buFPj0uZinpZbytmNa8XGkNAQju4akf7UzKeecQNdFGEp1t/SuiCW23XFbO5z7
	 Vk5AJRn4oDbuWWcW5qXrO18M1hNSR2bXYJDEEx3T2x1IJHZ9H6YzNh7+sg2C4R3RcQyH5
	 p4XofXBikFfc83/dPsicagClgZiKD8cewpqbxEuJs7d339JcuxEzq9LeoMc9PxHsNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933520;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WPcnW1jRhrB1DSYbwQEoywQTLvJP+6lhbwRnAR/VHHk=;
	b=QgIqN9Gx7BZM+dLNBHjY4aOg6WRq2svPmfxZHl5Y+yvNVfxy1S7gUO9ivbtAEbg0nZkg
	 EUH2SwGvkJLdeRhQ7foLRg6XFlJJNFQGB6gyjaDQyz9W3UsF04il76y4TYvLSr0n036lk
	 cQYH4igs/tTT0jtYt+EudRpqeoq8uWv4UxzM5W7cYuEdDqaooE1JRB3s26+yqsU06Nr3H
	 TUUSXpZG+QWQWHmFiZq8G6zCW8tLsJci00ujSeDnYqiZ1EhzZcAJvgRwXzjAfoUL2794z
	 2a5ymPouCiusykEj0dzfpIKTY3vtJyks/FbleIOstr7p/Qq7iDSRFZy58JXFvUJXc3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhCOzQQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FC0606A31C;
	Tue, 17 Nov 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhCOzQQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555D91F000D1;
	Tue, 17 Nov 2026 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933519;
	bh=WPcnW1jRhrB1DSYbwQEoywQTLvJP+6lhbwRnAR/VHHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhCOzQQ1agZ6+QTE56odeDAtftmD5yGnp+GXra6l4An6BpDk6FGmvHtpANSkLLMCF
	 6uQOuUbnTe2xz9GqY4Sej7wPXjwh39hSTtohoaMrgfmOwRnvFJ2Otg2vSIab5+r1pb
	 7QaWy4W0uF+fMLn1zh03nWCo4FNLw6PByp8mdMTdnmtsbqCPzViDyoKpnel8zv8g9S
	 iz+089QH9qZRuD4FDv5Ya+617rdIHmT1YPaUimvKSSj68nEEfuNaaVffyifMkeZWVX
	 Vj2N7M3ssy0ICp4DMRAfJgbYHRoZr7GpaWFuG8qKRLpw6MWYC30hj+QqzAR33JwyMT
	 vC2oc51xOTUug==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 03/11] dmaengine: ae4dma: Unregister DMA engine in ae4_pci_remove()
Date: Tue, 17 Nov 2026 16:37:04 +0000
Message-ID: <20261117163809.622249-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ae4_core_init() registers the DMA device and creates the descriptor slab
cache via pt_dmaengine_register(), but ae4_pci_remove() never undoes
either, leaking the descriptor cache and leaving a dangling DMA device
registered after device removal.

Unregister the DMA device first, so that no channels remain available to
clients, then stop the per-queue completion work, which may still free
descriptors into the cache, and only then destroy the descriptor cache.
pt_dmaengine_unregister() is open-coded here because it destroys the
cache immediately after unregistering, before the completion work has
been stopped.

Unregistering the DMA device also removes the ptdma debugfs entries,
which were previously left behind after removal, pointing at freed
device data.

Fixes: 98f5a4432622 ("dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register")
Closes: https://sashiko.dev/#/bug/linux-10d41112-e133-4bc5-8e53-b3e96592c70d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Stop the completion work before destroying the descriptor cache
 - Open-code the unregistration rather than exporting pt_dmaengine_unregister()

 drivers/dma/amd/ae4dma/ae4dma-pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 2c63907db228..b97fd37bb87d 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -131,8 +131,14 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void ae4_pci_remove(struct pci_dev *pdev)
 {
 	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
+	struct pt_device *pt = &ae4->pt;
 
+	dma_async_device_unregister(&pt->dma_dev);
+
+	/* Completion processing frees descriptors into the cache, so stop it first */
 	ae4_destroy_work(ae4);
+	kmem_cache_destroy(pt->dma_desc_cache);
+
 	ae4_deinit(ae4);
 }
 
-- 
2.56.0.679.gc527c65306-goog

