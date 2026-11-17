Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933563;
	b=SyMWveBPhD/SAHrxVCfNvlUvdD9bthyYK4BEhT0emkuzq855zgO2+cbXBPYBQyZWZGRN
	 AiWTneK9/PmktKZsvv0uzde9QeM8IL6uvlIKoiqOBPjJB5+zw/SXoo5cZyOrwPIB9d/Qv
	 iSOwS9jpbayTVorhut6u0ljGmc462KXl9c7cvzWEDTMm0sTCIjC6z1L3FadIcxU4rA+zK
	 mQW01RfyrNKl/Ys8ZctGNGLgfE19nHsUFwaYDqLXqKv6d60v2FGCkz/3OsOw1LyrsvwEJ
	 aF7dEl5kdxPhybbOBVWMh/8lc4YeVmM//4V88gvaYvyp4sXsDdrDbQZs/JsPrACxVxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0B5N+wzbfk453G1RKnELbLc5jLeaEcSSHYbAZl9PyvU=;
	b=WYlKuGjMkzm43qodTnBc/3bjt626uvmBXDrhYyfG5aJbZzgUG5YYbArLbKKjatXn7kpy
	 PpZyYLLIpzcCZ8oCDgXid8tmhpOUKnrcEXihKfZl5yxXpfq/ii9b/sz/JKx41B+0ZO6JF
	 s5YmuQSqdDfCSBDw1cGFsUGiOYpi+X1PsJsjl74DgAigKaLgFQ4UHERjaCda6DMer1i4+
	 kuCLPL8aJZBZXcaW3T1HuYZuMfoJPFCdt1/NAPgJmsPSabgM/myQJqoSdIYoYYvQ0CsLo
	 bO9do/f3Ofp0ii+v7zBwrFh/DsKDDK6YPI0/gK3ZMj+0hNaj1yHPyJT2dn45CGW4vTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C/m1dqAu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7C606A330;
	Tue, 17 Nov 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C/m1dqAu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC8C1F000C8;
	Tue, 17 Nov 2026 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933562;
	bh=0B5N+wzbfk453G1RKnELbLc5jLeaEcSSHYbAZl9PyvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C/m1dqAuBqfwLHgorqUyijsQC5Q7IL0aS5dSHjHS39hRTYmCWLpU6weSY+5VDMH8g
	 YRzM72fdba8SQW9zpQRvjXh8YDJNAp/1RQlKVTZ5VPGW6OrDL5kPCYk0nvRVHMmg29
	 MzVzFLQeeKZ+KFGS/oKNsUW78FY4GfYxbU/QUOejpTuIIegPdn7+RBZwSVDuepjiby
	 9MfCHEzMM8KVTKW25dUbQFQIGZjPfRS3Lnw+zmpbJwabju3PoLQokcZ3lWyMtrPLgZ
	 hTaUD6wVl6+fLdX6cG1t3y155g8wv0YA9/2y1vCAHO+/EKSS8R6JzmgmFVfGLDTBGw
	 2WQfmagktVzig==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sylvain Munaut <tnt@246tNt.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 09/11] dmaengine: bestcomm: Check rh_create() return value in bcom_sram_init()
Date: Tue, 17 Nov 2026 16:37:10 +0000
Message-ID: <20261117163809.622249-10-lee@kernel.org>
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

v1 => v2: No changes

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
2.56.0.679.gc527c65306-goog

