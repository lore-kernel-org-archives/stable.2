Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788448;
	b=VGyy3FjDDSe1dh46bSzLw/B2LC4Jtm9s60v3oLnrIrEdKhHsgtJckY1/G88WouqHbv5S
	 P4aGaQtVSZhE5Faphj7y1xOmEChHqpGYmHf85N0QeNE+NjPr9NHH5vfulKkF6Fbq+GYkn
	 Q/OmO/SKux4Uxb1WU+tb1DB0zHYGLTqZ2+EFDZvFO4YzXtLzCT01cNIrYfeiOJfuYJD04
	 fwlGyW5jHjtgtS4lKLzHfpj9fhHe5yhdAR1BHTRikPVF2Nx2FPyvIZpMA6n0QATX6o6rD
	 2G8Epq8rdJXeUPpgTNajZeZO1XGfT+tCODOcsIXbOJuGLVDMGZ2dA1os2QRMKSW0mVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bK/XsYMUPQ8SxDCiyg661SpI+UmAnvDiubWVw3wX2Y0=;
	b=jeQIoBbmW9LdmeTJk9qBbJG7dAl15iWoF9o4HGv5XuVPrGtIXSYlJHxE/EaS4BZZCj0g
	 97Q7uyMymUXSCZ3H6xlcW33WlTUKb3WP5VOT/mOM4lOjY2APYki4AlNSFJeFpRJxhdgFF
	 lWwSIrzR/QYEAGgDle+wDu/7HIrXqOBQqLm3nA6SZOHo/v1vj8rcTwgX7oxf/nEpLlZ74
	 tg2/Yn4O1Bx8lYoucuGZlMdu/e5gyz7MHzZiWy74lL9W6kBCwkeUmtEAf6d9aEg1q9SAv
	 ZqSIf84j2732CwYYYx1Hk0LVXjKQbovqgBq5w9sA8onh8wO6fFn3/F6jt4+g7msIhQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2mAoHdf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28B606A31E;
	Fri, 27 Nov 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2mAoHdf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5F1F00898;
	Fri, 27 Nov 2026 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788448;
	bh=bK/XsYMUPQ8SxDCiyg661SpI+UmAnvDiubWVw3wX2Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2mAoHdfCj/D3495JJuezXFoFjme1SXD3pYBFMzhk42DTpbvp8+YoyTtjSK+1KDxM
	 Tx+MkHZvAvJHc06NmJ/VOBRDaMkVOXOYKudvzonv4Hveahf48FiUnk1dmFzvKOzcVe
	 6rc9f1LSyWzHuc5laAHZDDTsRYneNdiKymtV8msquYaXohz6uE4D0Ax2LdJASjZjUz
	 qDtwe2P5oh7v83nSJZLTA2o5zN5eTSXuJhzNZHEW8UxmutfLShQph89Se3qzggCo6X
	 y7PQz4YxK/cw9U7tggspJh6Z6rbp6eWXCOax/FXihcfVqwZsF9JRYhMZ4vx+eKdBYe
	 +g/5/s218CJ3Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dvorkin Dmitry <dvorkin@tibbo.com>,
	Wells Lu <wellslutw@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Andrew Gaylard <ag@ffroot.co.za>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 11/12] pinctrl: sunplus: Validate pin_func index in sppctl_dt_node_to_map()
Date: Fri, 27 Nov 2026 14:04:59 +0000
Message-ID: <20261127140602.2790001-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

In sppctl_dt_node_to_map(), the validation loop checks that pin_num is
within sppctl_pins_all_sz, but does not validate pin_func (bits 15:8)
before indexing sppctl_list_funcs[pin_func] for fully-pinmuxed pins.
Check that pin_func is less than sppctl_list_funcs_sz when pin_type
selects a mux function.

Fixes: aa74c44be19c ("pinctrl: Add driver for Sunplus SP7021")
Closes: https://sashiko.dev/#/bug/linux-977252d6-b0cc-4d3a-ae2d-59d1e2f8a649
Cc: stable@vger.kernel.org
Reviewed-by: Andrew Gaylard <ag@ffroot.co.za>
Tested-by: Andrew Gaylard <ag@ffroot.co.za>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/sunplus/sppctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/sppctl.c
index 68ff6d8451bb..cadaf16ab358 100644
--- a/drivers/pinctrl/sunplus/sppctl.c
+++ b/drivers/pinctrl/sunplus/sppctl.c
@@ -867,8 +867,13 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node
 	for (i = 0; i < (*num_maps); i++) {
 		dt_pin = be32_to_cpu(list[i]);
 		pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
+		pin_type = FIELD_GET(GENMASK(23, 16), dt_pin);
+		pin_func = FIELD_GET(GENMASK(15, 8), dt_pin);
 
-		if (pin_num >= sppctl_pins_all_sz) {
+		if (pin_num >= sppctl_pins_all_sz ||
+		    (pin_type != SPPCTL_PCTL_G_GPIO &&
+		     pin_type != SPPCTL_PCTL_G_IOPP &&
+		     pin_func >= sppctl_list_funcs_sz)) {
 			dev_err(pctldev->dev, "Invalid pin property at index %d (0x%08x)\n",
 				i, dt_pin);
 			return -EINVAL;
-- 
2.56.1.839.g22a8290db9-goog

