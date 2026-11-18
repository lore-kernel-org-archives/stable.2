Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038465;
	b=y3wlKKhvN28rS+OleE900P0WoqDrMFHzPUoysvC3Qtmk2PLZ4V51UiPMN/tu6gtl20P2
	 E/jYVIhj6Rugjt8O47vN6gbywkgeBF37aQSow5yDuxW8AbE28dZp51CZHECwv2IN6qVmw
	 9lOfxcFU4ur8VHxEtMkv4B85l0KRt2QzniacAlc5cVJqLHVaIm1EQVPVf40qrG8NVkZA2
	 lL0DX8nlJI87zLmsO3TFH9XsIKDkUrf8yPaGh5ceKrX3BCT0xQ+KfOOkRLgF6OvU1K+kr
	 XhO73ujMxdRwUthl0/WfSwT2QV0jNvsC7RKPa23NcS9OYMmzdqn6rDulg5HWIeVAZkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038465;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CNB6iSHvxedKweBduiq/ZM5d60BtJ26KViuAeTWVp6k=;
	b=3OODQrQnjZN8ohVRihi/4BoED8jn0ln/2KNXolQiv7Cw631Lkiab716YwY3/gd1JO6Sm
	 /c8cgpiRK+opUAM6hzEGLD11uBIEsNIbjD8VirtyvYwQU+i5aaZdtLxRKtatYbgwjziUj
	 HvIFNI0j+iMgbRX1kNKARWalLwWrj4sFeqnAkeOuR102rFu4KI4jKC8ZPMAaAWtHhVRzz
	 P9voft4CfihARveAkVb2nZt4B6A+SormEt3yRyZuDlho1cR8wPO3JRm638leG6THOXctG
	 nnD9Hn3DLQPDdmFcjAB9E0c7iCmlxgBoorZUUK7+GjWmA8ehL/LyL5T+eWq0wSA9yhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZHlcdu8k;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED8606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BED8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=ZHlcdu8k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Reply-To;
	bh=CNB6iSHvxedKweBduiq/ZM5d60BtJ26KViuAeTWVp6k=; t=1795038465; x=2110398465; 
	b=ZHlcdu8kPK4u+NYWRIqPEfpK+Ec3aQa+0Cu/kdUGkTcpBa3Jco66EaFcA7D+/g69KidJr0LcVlh
	2dwjnUom1XmPWTW7JQRb7LKQA+2/NhPnKqRFhP33lDn9CVqAL4e50w3uSb/Xaxj8PrfmCsXQkEEDO
	uysaQxisVnStFP6wTBv1e+EiCvcwGPb48QkKzssa8srrfVDuMmdV3EYsCFUR0aDuQg/1T5JaQRCMx
	i7wSFqROzlg/+xCuyubNar6SQmDEgYqiBiZva84StUb984fnq9BMFBfIb2LEs3vLneovB+9PGEAWY
	scvNuo+F1d1B/Vh7pxMH1HiuVKLalqWyON0Q==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xTnVG-00000001DOD-1t8O;
	Wed, 18 Nov 2026 22:47:42 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 18 Nov 2026 18:47:28 -0300
Subject: [PATCH 1/4] drm/vc4: Fix off-by-one in the shader record BO handle
 check
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-vc4-icache-workaround-v1-1-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 "Juan A. Suarez Romero" <jasuarez@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=XNYsBpRqYjrTgWPoLRTtBGrva2YK8YUh+MlM1gtp31w=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/hz2xNPULxF58DQPnhhBojGn/EVjzHQ2RAFOB
 CP0ZALTyG+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav4c9gAKCRA/8w6Kdoj6
 qscBB/9yU+UMVgOZ9oiRUZq5czxN4GvmCGKveOviF2YA647bNP7YDSSm3gWpne69cVfAD228lKK
 hP4E2X9JEYhjWNtGo3uSCyKBIdQcEryOlhyYAkjok7VePUBMeGACuF0t7cD+N7ErRKjwRudeMgu
 HlI3+CWHj91ieQEbxKJigp4u3KUlYYUzeqhlE9RjIenkIN9MwOi09ffakRkRuk4YGKwnJxyvOOp
 KBkIpvsKQLXxoCLlDI1ldQh5131Ay23nuuR6um3/p0lz1w8y0Piskdbv3EtVfqy5Jw0FupJ5Fns
 u44x6Sjs6ZZZjGOgawnD3QHbeT6c6OTFgkiOjf3bQ+FblRsI
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

validate_gl_shader_rec() accepts a shader BO handle equal to
exec->bo_count, reading one entry past the end of exec->bo[] and
using it as a GEM object.

Reject handles that aren't below exec->bo_count.

Cc: stable@vger.kernel.org
Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 565227657b43..0d2b08abf1ad 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -815,7 +815,7 @@ validate_gl_shader_rec(struct drm_device *dev,
 	exec->shader_rec_size -= packet_size;
 
 	for (i = 0; i < shader_reloc_count; i++) {
-		if (src_handles[i] > exec->bo_count) {
+		if (src_handles[i] >= exec->bo_count) {
 			DRM_DEBUG("Shader handle %d too big\n", src_handles[i]);
 			return -EINVAL;
 		}

-- 
2.56.0

