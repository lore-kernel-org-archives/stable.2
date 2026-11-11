Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434100;
	b=2o+JTOm0nI1OugtwoHL21/spUwlOEZOIii4WcNYEU4+QW2ABFHVNfBeNRd2GapU+zt9F
	 OCysvkeVGuD1PBmU73TToMljY+JDzi5nEhBWNBL+969xkmlWP6uoTsV0+AqYZ8X+tRjqE
	 GXD9Z6sgGHLoTk6OImOg+Os2rU2eFKE2YO/6R+H5vp9Sjhm6GE2a4LpMyTTHW7x/lRYzZ
	 0aNlYLNWkGeL7ZuI4euAe3dJVbGDiF5TSHbYlfwC4CX8HbeX5p/BBIMY1+6s7XgvLZl3c
	 hiA75MjuItKGVVDm0CJjfleh7jMRoNA84vR2/aw5gXQhrXnhgY4CNDmbqu4TSQqYvdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YpATtb9CRJROOdQJGZVI7OOr5rIfYH3Wyflv4TMGDlU=;
	b=RlBsIlKnyP6JKFcIsXHjERYRqltQs+a/D6diqQ9OdIqiESpxBdoI2qYC8e488VW8PRU4
	 WJe7yrY+fQYXKzTgCWWwNWeT+ZuxFfPt4phS2gXALsU0pwE2PnTYp0A69xyfUlAvaEYSx
	 tmPLc3cn4ISfliGlMmYlAAN5tJEfLCEjZIGaJTqNW2bbl8X4k9T8VU019mNUgWp46Bcob
	 Mgb03a1oe/TJ2PM1kezgl1Zw7sfMzIs4WTPpUigUcMuHGLzgbSVlIFuMQDIf7uAQQpCvS
	 fv8yO1g/b58QJSlAY78yNZAIcf1mOntUD18Qjqr3014r0UFncERK+MgH1jYviITAwig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLcFk7Mk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF560A2625;
	Wed, 11 Nov 2026 21:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLcFk7Mk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F364D1F00A06;
	Wed, 11 Nov 2026 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434100;
	bh=YpATtb9CRJROOdQJGZVI7OOr5rIfYH3Wyflv4TMGDlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dLcFk7MkZ89xniHB4Yq1Ikv92uOz0S+AbyJXVJeToeCxEVv+SdH8piJiMqqOqsiem
	 kQ31jmIn4vxkUsHVmNBwAeT1lvAfXxznGwMEcmHS2bg9DcUFfWNyKsbqUiwZIA2CGF
	 itMAnYoE99DGVIQdd953v6J5OMdgHx0bTeYZK7xFftIY+geXzblMDiqQfZsiVUs/gU
	 j6EIqyCjBJtEVAPj3of+essWEdouJt/ypWHb4D/Brm0LImpF85aQv5euhQK4xliJHX
	 CcqKK7Q/y0Bxj0GfyBFl1vR+SjIJpt2J/VT7R6YANRxH3E3AOwBCGB8ZbWYE0rtKqR
	 t9FKOff9sWQNA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sylvain Munaut <tnt@246tNt.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] dmaengine: bestcomm: Check rh_create() return value in bcom_sram_init()
Date: Wed, 11 Nov 2026 21:52:46 +0000
Message-ID: <20261111215349.1983909-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215349.1983909-1-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
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

rh_create() returns ERR_PTR(-ENOMEM) on allocation failure.
bcom_sram_init() assigns this return value directly to bcom_sram->rh
without checking IS_ERR() and passes it to rh_attach_region(), which
dereferences the error pointer.

Check IS_ERR(bcom_sram->rh) after rh_create() and unmap the SRAM region
on failure.

Fixes: 2f9ea1bde0d1 ("[POWERPC] bestcomm: core bestcomm support for Freescale MPC5200")
Closes: https://sashiko.dev/#/bug/linux-c3caaf6f-9a88-4451-b40e-d061c1fdeabd
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/bestcomm/sram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/bestcomm/sram.c b/drivers/dma/bestcomm/sram.c
index 09ef5142c26c..df4d90cee465 100644
--- a/drivers/dma/bestcomm/sram.c
+++ b/drivers/dma/bestcomm/sram.c
@@ -88,6 +88,10 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 
 	/* Create an rheap (defaults to 32 bits word alignment) */
 	bcom_sram->rh = rh_create(4);
+	if (IS_ERR(bcom_sram->rh)) {
+		rv = PTR_ERR(bcom_sram->rh);
+		goto error_unmap;
+	}
 
 	/* Attach the free zones */
 	regaddr_p = NULL;
@@ -111,6 +115,8 @@ int bcom_sram_init(struct device_node *sram_node, char *owner)
 
 	return 0;
 
+error_unmap:
+	iounmap((void __iomem *)bcom_sram->base_virt);
 error_release:
 	release_mem_region(res.start, resource_size(&res));
 error_free:
-- 
2.56.0.567.gdb80ae8cd5-goog

