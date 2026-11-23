Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454581;
	b=llkDA+gDtNge6xf3sMcfxy+U3sR3GFh79dRxJamUwPtxqXSVnwEENjnOkLfylhx+/i32
	 BWRnHhS3qoYg5st4CpTJtNVI8yvF3pr5cxbBbJOtYvzv+TeobITKeLPvAQojIrR5gh2et
	 M+4SNegOoS2qhTeDzD2yqfGEns3Zlae2GsnVJX7K0iXN5o1s8rhkwmyrRe7fjph/0q+pU
	 4oMt2k1LxwePsoOjIjKyMl6Iw9DlImoIvt6/zc7QGgYSRkSZf85jS0G7FzoHQGdTbGKbK
	 UBTzKPMk6S6mQOPcQKveDGJrwQX1r+1VeI93ncbDnhiSAPuPd61eO77OT71thzhupdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HmV9sETKCIqTEm5gpQSn0ZKljOkssnactLIkz6YmI5s=;
	b=lx3yxXnsF2C0zTYDyRgUKJWc7RO2J0bb0vlk5kcGZC7rZuLIWYbRL8bIlviN+WioUqnA
	 S79oB6f2m3ubq0QmrJgmbumw3KaDRSvbt9ZT+B6eWnDwQtuZvka1wGBbJWXaOzKijsynH
	 njEtNiI8dyM2uLfFDtl1jurV4tDXCtV5Rptsdd9kQxrgXb3JQ/7aFQ3QqA/KXeb7fVCBV
	 Moyq3FT9o0UpnTv9IaCaBO/F2E4/UcjLaJEHq+qJPesEVnGlNQV4SCzds6TmIY/HcIYEY
	 zHByyjGje0u5KoZRwWBog7nvchRSCuvapwEcNOv1eGA7SngpKnyLy28UhOOKZN8priA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdWIAy0I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E6606A31F;
	Mon, 23 Nov 2026 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdWIAy0I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4729D1F000D0;
	Mon, 23 Nov 2026 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454580;
	bh=HmV9sETKCIqTEm5gpQSn0ZKljOkssnactLIkz6YmI5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdWIAy0IYBltJGVJMVfmHqWjwv6Mpp8Pq0EQnRnN4LY4bdqGl9tvW36dWPYuUjipM
	 fG+6WkatUFaSKiUU7SdiMmcPybvYYg+fDz3X2HgPVi0Kp5wK0UakOut1SyuwjnJXHg
	 6TtiX/5NcpW6iwm1HtZ/xVb69hkry+/4IMRDPS1Hf7m6zGK5QZ/XKkbJ3oJJT9Wo9q
	 BxRTLBUCg4yxiUTCXs13qMY6F0Wq7pjl+RfoE4orvHnG8w8NxqJGBb16nQMyzdgrgm
	 T5vrm7tIEVTXqrn1pAAg6QxhQnzQKS9WQLfW69M4v/8d58sK5yPOXALFdwdBbv1fNP
	 uEOKxgr3hsrIw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] remoteproc: imx_dsp_rproc: Fix off-by-one bitmask for trailing bytes
Date: Mon, 23 Nov 2026 17:20:54 +0000
Message-ID: <20261123172140.3547896-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When size is not a multiple of 4, both imx_dsp_rproc_memcpy() and
imx_dsp_rproc_memset() compute affected_mask as GENMASK(8 * r, 0) for
the remaining r bytes (1 <= r <= 3).  Because GENMASK(h, l) is inclusive
of bit h, GENMASK(8 * r, 0) sets 8 * r + 1 bits and clears or overwrites
the least-significant bit of the first byte past the end of the target
region during the 32-bit read-modify-write.

Use GENMASK(8 * r - 1, 0) to mask exclusively the r trailing bytes.

Fixes: 408ec1ff0caa ("remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores")
Closes: https://sashiko.dev/#/bug/linux-2e407b68-a7e9-42ff-a613-e61b47a4461b
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/imx_dsp_rproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 2771043ee433..0e0325d5df9f 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -799,7 +799,7 @@ static int imx_dsp_rproc_memcpy(void *dst, const void *src, size_t size)
 		writel(source[i], dest + i * 4);
 
 	if (r) {
-		affected_mask = GENMASK(8 * r, 0);
+		affected_mask = GENMASK(8 * r - 1, 0);
 
 		/*
 		 * first read the 32bit data of dest, then change affected
@@ -849,7 +849,7 @@ static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
 	}
 
 	if (r) {
-		affected_mask = GENMASK(8 * r, 0);
+		affected_mask = GENMASK(8 * r - 1, 0);
 
 		/*
 		 * first read the 32bit data of addr, then change affected
-- 
2.56.1.750.gf70dc682cf-goog

